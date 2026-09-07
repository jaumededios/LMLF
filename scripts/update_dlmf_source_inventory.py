#!/usr/bin/env python3
"""Build the DLMF Chapters 4--10 structural source inventory (schema v2).

This inventory records stable source locations and content hashes.  It deliberately does not copy
DLMF formula bodies or prose.  Structural source blocks are candidates for later human review; the
generator does not infer that every paragraph, table row, caption, or annotation is theorem-shaped.
Formula statuses come from ``coverage/overrides.json``; non-formula statuses come from the separate
``coverage/source-item-overrides.json`` map.
"""

from __future__ import annotations

import argparse
import concurrent.futures
import datetime as dt
import hashlib
import html
from html.parser import HTMLParser
import json
import pathlib
import re
import time
import urllib.error
import urllib.request
from collections import Counter
from typing import Iterator


CHAPTERS = tuple(range(4, 11))
BASE_URL = "https://dlmf.nist.gov"
USER_AGENT = "LMLF-source-inventory/2.0 (+https://github.com/jaumededios/LMLF)"

PINNED_DLMF_VERSION = "1.2.7"
PINNED_RELEASE_DATE = "2026-06-15"
EXPECTED_SECTION_COUNTS = {4: 48, 5: 24, 6: 21, 7: 25, 8: 28, 9: 20, 10: 77}
EXPECTED_ITEM_COUNTS = {
    "numbered_formula": 2108,
    "prose_block": 1575,
    "unnumbered_display_formula": 3,
    "table_row": 221,
    "figure_caption": 161,
    "annotation_note": 395,
    "proof_sketch": 109,
    "editorial_change_note": 220,
}
EXPECTED_COMPONENT_COUNTS = {"formula_tex_parts": 2447, "formula_constraints": 697}

VERSION_RE = re.compile(
    r"Version\s+(?P<version>[\d.]+);\s*Release date\s+(?P<date>\d{4}-\d{2}-\d{2})"
)
FORMULA_LOCAL_ID_RE = re.compile(r"E\d+(?:_\d+)?")
EDITORIAL_ANNOTATION_RE = re.compile(
    r"^(?:Addition|Additions and Changes|Change|Changes|Changes and Additions|Clarification|"
    r"Correction|Correction/Addition|Errata|Generalization|Modification|Notational Change|"
    r"Rearrangement|Substitution) \(effective with [^)]+\):$"
)

VOID_ELEMENTS = {
    "area",
    "base",
    "br",
    "col",
    "embed",
    "hr",
    "img",
    "input",
    "link",
    "meta",
    "param",
    "source",
    "track",
    "wbr",
}


class Element:
    def __init__(
        self,
        tag: str,
        attrs: list[tuple[str, str | None]],
        parent: Element | None,
        order: int,
    ) -> None:
        self.tag = tag
        self.attrs = {key: value or "" for key, value in attrs}
        self.parent = parent
        self.order = order
        self.children: list[Element | str] = []

    @property
    def element_id(self) -> str | None:
        return self.attrs.get("id") or None

    @property
    def classes(self) -> set[str]:
        return set(self.attrs.get("class", "").split())


class TreeParser(HTMLParser):
    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self.root = Element("document", [], None, 0)
        self.stack = [self.root]
        self.elements: list[Element] = []

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        tag = tag.lower()
        node = Element(tag, attrs, self.stack[-1], len(self.elements) + 1)
        self.stack[-1].children.append(node)
        self.elements.append(node)
        if tag not in VOID_ELEMENTS:
            self.stack.append(node)

    def handle_startendtag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        node = Element(tag.lower(), attrs, self.stack[-1], len(self.elements) + 1)
        self.stack[-1].children.append(node)
        self.elements.append(node)

    def handle_endtag(self, tag: str) -> None:
        tag = tag.lower()
        for index in range(len(self.stack) - 1, 0, -1):
            if self.stack[index].tag == tag:
                del self.stack[index:]
                return

    def handle_data(self, data: str) -> None:
        if data:
            self.stack[-1].children.append(data)


def fetch(url: str) -> str:
    request = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    for attempt in range(4):
        try:
            with urllib.request.urlopen(request, timeout=30) as response:
                return response.read().decode("utf-8")
        except (urllib.error.URLError, TimeoutError):
            if attempt == 3:
                raise
            time.sleep(2**attempt)
    raise AssertionError("unreachable")


def descendants(node: Element) -> Iterator[Element]:
    for child in node.children:
        if isinstance(child, Element):
            yield child
            yield from descendants(child)


def ancestors(node: Element) -> Iterator[Element]:
    current = node.parent
    while current is not None:
        yield current
        current = current.parent


def has_ancestor_class(node: Element, class_name: str) -> bool:
    return any(class_name in ancestor.classes for ancestor in ancestors(node))


def has_descendant_class(node: Element, class_name: str) -> bool:
    return any(class_name in child.classes for child in descendants(node))


def normalize_space(value: str) -> str:
    return re.sub(r"\s+", " ", value).strip()


def plain_text(node: Element) -> str:
    parts: list[str] = []

    def visit(current: Element) -> None:
        if current.tag in {"script", "style"}:
            return
        if current.tag == "math" and current.attrs.get("alttext"):
            parts.append(current.attrs["alttext"])
            return
        for child in current.children:
            if isinstance(child, str):
                text = normalize_space(child)
                if text:
                    parts.append(text)
            else:
                visit(child)

    visit(node)
    return normalize_space(" ".join(parts))


def content_fingerprint(node: Element, *, prose: bool = False) -> str:
    """Return a normalized content fingerprint without retaining the content in the artifact."""

    parts: list[str] = []

    def visit(current: Element, *, is_root: bool = False) -> None:
        if current.tag in {"script", "style"} or "ltx_metadata" in current.classes:
            return
        if prose and not is_root:
            if (
                (current.tag == "table" and "ltx_eqn_table" in current.classes)
                or (current.tag == "table" and "ltx_tabular" in current.classes)
                or current.tag == "figure"
            ):
                return
        if current.tag == "math" and current.attrs.get("alttext"):
            parts.append(f"MATH({normalize_space(current.attrs['alttext'])})")
            return
        parts.append(f"<{current.tag}>")
        for child in current.children:
            if isinstance(child, str):
                text = normalize_space(child)
                if text:
                    parts.append(text)
            else:
                visit(child)
        parts.append(f"</{current.tag}>")

    visit(node, is_root=True)
    return " ".join(parts)


def sha256_text(value: str) -> str:
    return hashlib.sha256(value.encode("utf-8")).hexdigest()


def nearest_context_id(node: Element) -> str | None:
    for ancestor in ancestors(node):
        if ancestor.tag == "section" and ancestor.element_id:
            return ancestor.element_id
    return None


def find_content_root(parser: TreeParser, section_id: str) -> Element:
    roots = [node for node in parser.elements if "ltx_page_content" in node.classes]
    if len(roots) != 1:
        raise RuntimeError(f"{section_id}: expected one ltx_page_content, found {len(roots)}")
    return roots[0]


def is_within(node: Element, root: Element) -> bool:
    return node is root or any(ancestor is root for ancestor in ancestors(node))


def location(
    chapter: int,
    section_id: str,
    node: Element,
    dom_id: str,
    source_url: str,
) -> dict[str, object]:
    return {
        "chapter": chapter,
        "section": section_id,
        "context_id": nearest_context_id(node),
        "dom_id": dom_id,
        "source_url": source_url,
        "document_order": node.order,
    }


def unknown_lean_status() -> dict[str, object]:
    return {
        "statement_status": "unknown",
        "proof_status": "unknown",
        "coverage_relation": "unknown",
        "declarations": [],
        "evidence_source": None,
    }


def unknown_quantitative_status() -> dict[str, object]:
    return {
        "analogue_status": "unknown",
        "statement_status": "unknown",
        "proof_status": "unknown",
        "declarations": [],
        "evidence_source": None,
    }


def base_item(
    item_id: str,
    kind: str,
    item_location: dict[str, object],
    source_hash: str,
    *,
    owner_source_id: str | None = None,
    annotation_label: str | None = None,
) -> dict[str, object]:
    return {
        "id": item_id,
        "kind": kind,
        "location": item_location,
        "source_sha256": source_hash,
        "owner_source_id": owner_source_id,
        "annotation_label": annotation_label,
        "formula_components": None,
        "review": {"state": "unreviewed"},
        "lean": unknown_lean_status(),
        "quantitative": unknown_quantitative_status(),
    }


def annotation_kind(label: str) -> str | None:
    if label == "Notes:":
        return "annotation_note"
    if label == "Proof sketch:":
        return "proof_sketch"
    if EDITORIAL_ANNOTATION_RE.fullmatch(label):
        return "editorial_change_note"
    return None


def metadata_value_nodes(term: Element) -> list[Element]:
    parent = term.parent
    if parent is None:
        return []
    element_children = [child for child in parent.children if isinstance(child, Element)]
    try:
        index = element_children.index(term)
    except ValueError:
        return []
    values: list[Element] = []
    for sibling in element_children[index + 1 :]:
        if sibling.tag == "dt":
            break
        if sibling.tag == "dd":
            values.append(sibling)
    return values


def formula_permalink_ids(section_id: str, source: str) -> list[str]:
    pattern = re.compile(
        rf"https?://dlmf\.nist\.gov/{re.escape(section_id)}\.({FORMULA_LOCAL_ID_RE.pattern})"
    )
    return sorted(set(pattern.findall(source)))


def formula_sort_key(local_id: str) -> tuple[int, int]:
    match = re.fullmatch(r"E(\d+)(?:_(\d+))?", local_id)
    if match is None:
        raise ValueError(f"Unexpected formula ID: {local_id}")
    return int(match.group(1)), int(match.group(2) or 0)


def apply_formula_override(
    item: dict[str, object], formula_id: str, overrides: dict[str, object]
) -> None:
    raw = overrides.get(formula_id)
    if not isinstance(raw, dict):
        return

    lean_statement = raw.get("lean_statement") is True
    lean_proof = raw.get("lean_proof") is True
    lean_declarations = raw.get("lean_declarations", [])
    match = raw.get("match")
    if lean_statement and isinstance(lean_declarations, list) and all(
        isinstance(name, str) for name in lean_declarations
    ):
        if match not in {"exact", "consequence"}:
            raise ValueError(f"{formula_id}: cannot migrate invalid match value {match!r}")
        item["lean"] = {
            "statement_status": "checked",
            "proof_status": "proved" if lean_proof else "missing",
            "coverage_relation": match,
            "declarations": lean_declarations,
            "evidence_source": "coverage/overrides.json",
        }

    analogue = raw.get("quantitative_analogue") is True
    quantitative_statement = raw.get("quantitative_statement") is True
    quantitative_proof = raw.get("quantitative_proof") is True
    quantitative_declarations = raw.get("quantitative_declarations", [])
    if analogue:
        if not isinstance(quantitative_declarations, list) or not all(
            isinstance(name, str) for name in quantitative_declarations
        ):
            raise ValueError(f"{formula_id}: invalid quantitative declaration list")
        item["quantitative"] = {
            "analogue_status": "present",
            "statement_status": "checked" if quantitative_statement else "unknown",
            "proof_status": (
                "proved"
                if quantitative_proof
                else "missing"
                if quantitative_statement
                else "unknown"
            ),
            "declarations": quantitative_declarations,
            "evidence_source": "coverage/overrides.json",
        }


def validate_source_item_override(item_id: str, raw: object) -> dict[str, object]:
    """Validate and return one normalized non-formula status override.

    Source-item overrides are deliberately kept separate from the formula override map.  The
    sync command writes the complete schema-v2 status objects, so the inventory generator can
    reject malformed or formula-shaped rows before applying them.
    """

    if not isinstance(raw, dict):
        raise ValueError(f"{item_id}: source-item override must be an object")
    review = raw.get("review")
    lean = raw.get("lean")
    quantitative = raw.get("quantitative")
    if not isinstance(review, dict) or review.get("state") not in {
        "reviewed_no_claim",
        "claims_identified",
        "mixed",
    }:
        raise ValueError(f"{item_id}: malformed source-item review state")
    if not isinstance(lean, dict):
        raise ValueError(f"{item_id}: source-item lean status must be an object")
    lean_statement = lean.get("statement_status")
    lean_proof = lean.get("proof_status")
    if lean_statement not in {"reviewed_absent", "checked"}:
        raise ValueError(f"{item_id}: malformed source-item Lean statement status")
    if lean_proof not in {"not_applicable", "missing", "proved"}:
        raise ValueError(f"{item_id}: malformed source-item Lean proof status")
    if lean.get("coverage_relation") not in {
        "unknown",
        "exact",
        "equivalent",
        "specialization",
        "consequence",
        "generalization",
        "partial",
    }:
        raise ValueError(f"{item_id}: malformed source-item coverage relation")
    declarations = lean.get("declarations")
    if not isinstance(declarations, list) or not all(
        isinstance(name, str) and name for name in declarations
    ) or len(set(declarations)) != len(declarations):
        raise ValueError(f"{item_id}: malformed source-item declarations")
    if lean_statement == "checked" and not declarations:
        raise ValueError(f"{item_id}: checked source-item Lean status requires declarations")
    if lean_statement == "reviewed_absent" and declarations:
        raise ValueError(f"{item_id}: reviewed_absent source-item Lean status forbids declarations")
    if lean_proof in {"proved", "missing"} and lean_statement != "checked":
        raise ValueError(f"{item_id}: source-item proof requires a checked statement")
    if lean_statement == "reviewed_absent" and lean_proof != "not_applicable":
        raise ValueError(f"{item_id}: absent source-item statement requires not_applicable proof")
    if not isinstance(lean.get("evidence_source"), str) or not lean["evidence_source"]:
        raise ValueError(f"{item_id}: source-item evidence_source is required")
    if not isinstance(quantitative, dict):
        raise ValueError(f"{item_id}: source-item quantitative status must be an object")
    analogue_status = quantitative.get("analogue_status")
    q_statement = quantitative.get("statement_status")
    q_proof = quantitative.get("proof_status")
    if analogue_status not in {
        "not_applicable",
        "source_already_quantitative",
        "candidate",
        "present",
    }:
        raise ValueError(f"{item_id}: malformed source-item quantitative analogue status")
    if q_statement not in {"reviewed_absent", "checked", "unknown"}:
        raise ValueError(f"{item_id}: malformed source-item quantitative statement status")
    if q_proof not in {
        "not_applicable",
        "missing",
        "proved",
        "unknown",
    }:
        raise ValueError(f"{item_id}: malformed source-item quantitative proof status")
    q_declarations = quantitative.get("declarations")
    if not isinstance(q_declarations, list) or not all(
        isinstance(name, str) and name for name in q_declarations
    ) or len(set(q_declarations)) != len(q_declarations):
        raise ValueError(f"{item_id}: malformed source-item quantitative declarations")
    if q_statement == "checked" and not q_declarations:
        raise ValueError(f"{item_id}: checked quantitative status requires declarations")
    if q_statement == "reviewed_absent" and q_declarations:
        raise ValueError(f"{item_id}: reviewed_absent quantitative status forbids declarations")
    if q_statement == "unknown" and q_declarations:
        raise ValueError(f"{item_id}: unknown quantitative status forbids declarations")
    if q_statement == "checked" and q_proof == "unknown":
        raise ValueError(f"{item_id}: checked quantitative status requires an explicit proof status")
    if q_statement == "unknown" and q_proof != "unknown":
        raise ValueError(f"{item_id}: unknown quantitative statement requires unknown proof status")
    if q_proof in {"proved", "missing"} and q_statement != "checked":
        raise ValueError(f"{item_id}: quantitative proof requires a checked statement")
    if q_statement == "reviewed_absent" and q_proof not in {"not_applicable", "unknown"}:
        raise ValueError(f"{item_id}: absent quantitative statement requires no proof")
    if analogue_status == "not_applicable":
        if (q_statement, q_proof, q_declarations) != (
            "reviewed_absent",
            "not_applicable",
            [],
        ):
            raise ValueError(f"{item_id}: not_applicable analogue has inconsistent quantitative status")
    elif analogue_status == "candidate":
        if q_declarations or q_statement == "checked" or q_proof in {"proved", "missing"}:
            raise ValueError(f"{item_id}: candidate analogue cannot carry a checked quantitative claim")
    elif analogue_status in {"present", "source_already_quantitative"}:
        if q_proof in {"proved", "missing"} and q_statement != "checked":
            raise ValueError(f"{item_id}: present analogue proof requires checked statement")
    review_state = review["state"]
    has_claim = (
        lean_statement == "checked"
        or bool(declarations)
        or analogue_status == "candidate"
        or analogue_status in {"present", "source_already_quantitative"}
        or q_statement == "checked"
        or bool(q_declarations)
    )
    if review_state == "reviewed_no_claim":
        if has_claim or lean_proof != "not_applicable" or analogue_status != "not_applicable":
            raise ValueError(f"{item_id}: reviewed_no_claim conflicts with identified statuses")
    elif review_state == "claims_identified" and not has_claim:
        raise ValueError(f"{item_id}: claims_identified requires a qualitative or quantitative claim")
    if not isinstance(quantitative.get("evidence_source"), str) or not quantitative[
        "evidence_source"
    ]:
        raise ValueError(f"{item_id}: source-item quantitative evidence_source is required")
    return raw


def apply_source_item_override(
    item: dict[str, object], item_id: str, overrides: dict[str, object]
) -> None:
    raw = overrides.get(item_id)
    if raw is None:
        return
    if item["kind"] == "numbered_formula":
        raise ValueError(f"{item_id}: source-item override targets a numbered formula")
    validate_source_item_override(item_id, raw)
    item["review"] = raw["review"]
    item["lean"] = raw["lean"]
    item["quantitative"] = raw["quantitative"]


def extract_section(
    chapter: int,
    section_id: str,
    title: str,
    source: str,
    overrides: dict[str, object],
    source_item_overrides: dict[str, object] | None = None,
) -> tuple[dict[str, object], list[dict[str, object]]]:
    parser = TreeParser()
    parser.feed(source)
    parser.close()
    content_root = find_content_root(parser, section_id)
    id_nodes: dict[str, list[Element]] = {}
    for node in parser.elements:
        if node.element_id:
            id_nodes.setdefault(node.element_id, []).append(node)

    items: list[dict[str, object]] = []
    item_by_dom_id: dict[str, str] = {}
    formula_ids = formula_permalink_ids(section_id, source)

    for local_id in sorted(formula_ids, key=formula_sort_key):
        nodes = [node for node in id_nodes.get(local_id, []) if is_within(node, content_root)]
        if len(nodes) != 1:
            raise RuntimeError(f"{section_id}.{local_id}: expected one source node, found {len(nodes)}")
        node = nodes[0]
        metadata_nodes = id_nodes.get(f"{local_id}.info", [])
        metadata = metadata_nodes[0] if len(metadata_nodes) == 1 else None
        tex_parts: list[dict[str, str]] = []
        if metadata is not None:
            seen_tex: set[str] = set()
            for child in descendants(metadata):
                href = child.attrs.get("href", "")
                match = re.fullmatch(
                    rf"\./{re.escape(section_id)}\.(E[^/#?]+)\.tex", href
                )
                if match and match.group(1) not in seen_tex:
                    seen_tex.add(match.group(1))
                    tex_parts.append(
                        {
                            "id": f"{section_id}.{match.group(1)}",
                            "source_url": f"{BASE_URL}/{section_id}.{match.group(1)}.tex",
                        }
                    )
        formula_id = f"{section_id}.{local_id}"
        item_id = f"dlmf:{formula_id}"
        formula_url = f"{BASE_URL}/{formula_id}"
        item = base_item(
            item_id,
            "numbered_formula",
            location(chapter, section_id, node, local_id, formula_url),
            sha256_text(content_fingerprint(node)),
        )
        item["formula_components"] = {
            "display_number": formula_id.replace(".E", "."),
            "tex_parts": tex_parts,
            "constraint_count": sum(
                "ltx_constraint" in child.classes for child in descendants(node)
            ),
        }
        apply_formula_override(item, formula_id, overrides)
        items.append(item)
        item_by_dom_id[local_id] = item_id

    for node in parser.elements:
        if not is_within(node, content_root):
            continue

        # The three unnumbered outer displays in this corpus occur inside substantive annotation
        # fields.  They remain first-class candidates even though ordinary metadata descendants are
        # excluded from the main-flow prose/table/caption pass.
        if (
            node.tag == "table"
            and "ltx_eqn_table" in node.classes
            and not has_descendant_class(node, "ltx_eqn_eqno")
        ):
            dom_id = node.element_id
            if dom_id is None:
                raise RuntimeError(f"{section_id}: unnumbered display without an ID")
            item_id = f"dlmf:{section_id}#{dom_id}"
            items.append(
                base_item(
                    item_id,
                    "unnumbered_display_formula",
                    location(chapter, section_id, node, dom_id, f"{BASE_URL}/{section_id}#{dom_id}"),
                    sha256_text(content_fingerprint(node)),
                )
            )
            item_by_dom_id[dom_id] = item_id

        if has_ancestor_class(node, "ltx_metadata"):
            continue

        if node.tag == "div" and "ltx_para" in node.classes:
            dom_id = node.element_id
            if dom_id is None:
                raise RuntimeError(f"{section_id}: prose block without an ID")
            item_id = f"dlmf:{section_id}#{dom_id}"
            items.append(
                base_item(
                    item_id,
                    "prose_block",
                    location(chapter, section_id, node, dom_id, f"{BASE_URL}/{section_id}#{dom_id}"),
                    sha256_text(content_fingerprint(node, prose=True)),
                )
            )
            item_by_dom_id[dom_id] = item_id

        if node.tag == "tr" and "ltx_tr" in node.classes:
            dom_id = node.element_id
            if dom_id is None:
                raise RuntimeError(f"{section_id}: table row without an ID")
            item_id = f"dlmf:{section_id}#{dom_id}"
            items.append(
                base_item(
                    item_id,
                    "table_row",
                    location(chapter, section_id, node, dom_id, f"{BASE_URL}/{section_id}#{dom_id}"),
                    sha256_text(content_fingerprint(node)),
                )
            )
            item_by_dom_id[dom_id] = item_id

        if node.tag == "figcaption":
            figure = next((ancestor for ancestor in ancestors(node) if ancestor.tag == "figure"), None)
            if figure is None or figure.element_id is None:
                raise RuntimeError(f"{section_id}: figure caption without an identified figure")
            dom_id = figure.element_id
            item_id = f"dlmf:{section_id}#{dom_id}@caption"
            items.append(
                base_item(
                    item_id,
                    "figure_caption",
                    location(chapter, section_id, node, dom_id, f"{BASE_URL}/{section_id}#{dom_id}"),
                    sha256_text(content_fingerprint(node)),
                )
            )

    annotation_ordinals: Counter[tuple[str, str]] = Counter()
    for node in parser.elements:
        if node.tag != "dt" or not has_ancestor_class(node, "ltx_metadata"):
            continue
        label = plain_text(node)
        kind = annotation_kind(label)
        if kind is None:
            continue
        metadata = next(
            (ancestor for ancestor in ancestors(node) if "ltx_metadata" in ancestor.classes), None
        )
        if metadata is None or metadata.element_id is None:
            raise RuntimeError(f"{section_id}: substantive annotation without metadata ID")
        values = metadata_value_nodes(node)
        if not values:
            raise RuntimeError(f"{section_id}#{metadata.element_id}: {label} has no value")
        annotation_ordinals[(metadata.element_id, kind)] += 1
        ordinal = annotation_ordinals[(metadata.element_id, kind)]
        owner_dom_id = metadata.element_id.removesuffix(".info")
        owner_source_id = item_by_dom_id.get(owner_dom_id)
        item_id = f"dlmf:{section_id}#{metadata.element_id}@{kind.replace('_', '-')}-{ordinal}"
        annotation_hash = sha256_text("\n".join(content_fingerprint(value) for value in values))
        items.append(
            base_item(
                item_id,
                kind,
                location(
                    chapter,
                    section_id,
                    node,
                    metadata.element_id,
                    f"{BASE_URL}/{section_id}#{metadata.element_id}",
                ),
                annotation_hash,
                owner_source_id=owner_source_id,
                annotation_label=label,
            )
        )

    source_item_overrides = source_item_overrides or {}
    for item in items:
        item_id = str(item["id"])
        if item["kind"] != "numbered_formula":
            apply_source_item_override(item, item_id, source_item_overrides)

    item_ids = [str(item["id"]) for item in items]
    duplicates = sorted(item_id for item_id, count in Counter(item_ids).items() if count > 1)
    if duplicates:
        raise RuntimeError(f"{section_id}: duplicate source item IDs: {duplicates}")
    items.sort(key=lambda item: (int(item["location"]["document_order"]), str(item["id"])))

    section_record = {
        "id": section_id,
        "chapter": chapter,
        "title": title,
        "source_url": f"{BASE_URL}/{section_id}",
        "page_sha256": sha256_text(content_fingerprint(content_root)),
        "item_counts": dict(sorted(Counter(str(item["kind"]) for item in items).items())),
    }
    return section_record, items


def chapter_sections(chapter: int, source: str) -> list[tuple[str, str]]:
    parser = TreeParser()
    parser.feed(source)
    parser.close()
    sections: list[tuple[str, str]] = []
    seen: set[str] = set()
    for node in parser.elements:
        if node.tag != "link" or "section" not in node.attrs.get("rel", "").split():
            continue
        href = node.attrs.get("href", "")
        match = re.fullmatch(rf"\./({chapter}\.\d+)", href)
        if match is None or match.group(1) in seen:
            continue
        section_id = match.group(1)
        full_title = html.unescape(node.attrs.get("title", ""))
        short_title = full_title.split(" ‣ ", maxsplit=1)[0]
        short_title = re.sub(rf"^§{re.escape(section_id)}\s*", "", short_title)
        sections.append((section_id, short_title))
        seen.add(section_id)
    return sections


def status_counts(items: list[dict[str, object]], path: tuple[str, str]) -> dict[str, int]:
    outer, inner = path
    return dict(sorted(Counter(str(item[outer][inner]) for item in items).items()))


def validate_structural_counts(
    sections: list[dict[str, object]], items: list[dict[str, object]]
) -> None:
    actual_sections = Counter(int(section["chapter"]) for section in sections)
    if dict(actual_sections) != EXPECTED_SECTION_COUNTS:
        raise RuntimeError(
            f"DLMF section inventory changed: expected {EXPECTED_SECTION_COUNTS}, "
            f"got {dict(actual_sections)}"
        )

    actual_items = Counter(str(item["kind"]) for item in items)
    if dict(actual_items) != EXPECTED_ITEM_COUNTS:
        raise RuntimeError(
            f"DLMF source-item inventory changed: expected {EXPECTED_ITEM_COUNTS}, "
            f"got {dict(actual_items)}"
        )

    formula_items = [item for item in items if item["kind"] == "numbered_formula"]
    actual_components = {
        "formula_tex_parts": sum(
            len(item["formula_components"]["tex_parts"]) for item in formula_items
        ),
        "formula_constraints": sum(
            int(item["formula_components"]["constraint_count"]) for item in formula_items
        ),
    }
    if actual_components != EXPECTED_COMPONENT_COUNTS:
        raise RuntimeError(
            f"DLMF formula components changed: expected {EXPECTED_COMPONENT_COUNTS}, "
            f"got {actual_components}"
        )


def build_inventory(
    overrides_path: pathlib.Path,
    source_item_overrides_path: pathlib.Path | None = None,
) -> dict[str, object]:
    chapter_sources = {chapter: fetch(f"{BASE_URL}/{chapter}") for chapter in CHAPTERS}
    versions: set[tuple[str, str]] = set()
    for chapter, source in chapter_sources.items():
        match = VERSION_RE.search(source)
        if match is None:
            raise RuntimeError(f"Could not read the DLMF version from Chapter {chapter}")
        versions.add((match.group("version"), match.group("date")))
    expected_version = (PINNED_DLMF_VERSION, PINNED_RELEASE_DATE)
    if versions != {expected_version}:
        raise RuntimeError(f"Expected pinned DLMF release {expected_version}, got {sorted(versions)}")

    sections_by_chapter = {
        chapter: chapter_sections(chapter, chapter_sources[chapter]) for chapter in CHAPTERS
    }
    chapter_hashes = {
        str(chapter): sha256_text(
            json.dumps(
                {
                    "version": PINNED_DLMF_VERSION,
                    "release_date": PINNED_RELEASE_DATE,
                    "sections": sections_by_chapter[chapter],
                },
                ensure_ascii=False,
                separators=(",", ":"),
            )
        )
        for chapter in CHAPTERS
    }
    section_specs = [
        (chapter, section_id, title)
        for chapter in CHAPTERS
        for section_id, title in sections_by_chapter[chapter]
    ]
    overrides = json.loads(overrides_path.read_text(encoding="utf-8"))
    if not isinstance(overrides, dict):
        raise ValueError("Coverage overrides must be a JSON object")
    if source_item_overrides_path is None:
        source_item_overrides_path = overrides_path.parent / "source-item-overrides.json"
    if source_item_overrides_path.exists():
        source_item_overrides = json.loads(source_item_overrides_path.read_text(encoding="utf-8"))
    else:
        source_item_overrides = {}
    if not isinstance(source_item_overrides, dict):
        raise ValueError("Source-item overrides must be a JSON object")
    for item_id, raw in source_item_overrides.items():
        if not isinstance(item_id, str) or not item_id.startswith("dlmf:"):
            raise ValueError(f"malformed source-item override ID {item_id!r}; expected dlmf:")
        validate_source_item_override(item_id, raw)

    def fetch_and_extract(spec: tuple[int, str, str]):
        chapter, section_id, title = spec
        source = fetch(f"{BASE_URL}/{section_id}")
        return extract_section(
            chapter, section_id, title, source, overrides, source_item_overrides
        )

    with concurrent.futures.ThreadPoolExecutor(max_workers=6) as executor:
        extracted = list(executor.map(fetch_and_extract, section_specs))

    sections = [section for section, _items in extracted]
    items = [item for _section, section_items in extracted for item in section_items]
    validate_structural_counts(sections, items)

    item_ids = [str(item["id"]) for item in items]
    if len(item_ids) != len(set(item_ids)):
        raise RuntimeError("Source item IDs are not globally unique")
    item_by_id = {str(item["id"]): item for item in items}
    unknown_ids = sorted(set(source_item_overrides) - set(item_by_id))
    if unknown_ids:
        raise ValueError(f"source-item overrides reference unknown inventory IDs: {unknown_ids}")
    formula_ids = sorted(
        item_id
        for item_id in source_item_overrides
        if item_by_id[item_id]["kind"] == "numbered_formula"
    )
    if formula_ids:
        raise ValueError(f"source-item overrides must be non-formula IDs: {formula_ids}")

    return {
        "$schema": "dlmf-source-inventory.schema.json",
        "schema_version": 2,
        "artifact_kind": "dlmf_structural_source_inventory",
        "generated_at": dt.datetime.now(dt.timezone.utc).replace(microsecond=0).isoformat(),
        "source": {
            "name": "NIST Digital Library of Mathematical Functions",
            "base_url": BASE_URL,
            "version": PINNED_DLMF_VERSION,
            "release_date": PINNED_RELEASE_DATE,
            "chapters": list(CHAPTERS),
            "chapter_index_sha256": chapter_hashes,
        },
        "scope": {
            "description": (
                "Structural source candidates in DLMF Chapters 4--10. Items may be marked "
                "reviewed_no_claim or claims_identified by section manifests; unreviewed "
                "items remain candidates, and inclusion does not assert that a source block "
                "is theorem-shaped."
            ),
            "included_kinds": list(EXPECTED_ITEM_COUNTS),
            "body_policy": (
                "No DLMF formula or prose bodies are stored. Hashes fingerprint normalized source "
                "content; formula records retain only TeX encoding URLs and constraint counts."
            ),
            "excluded_structural_metadata": [
                "Permalink",
                "Encodings",
                "Symbols",
                "Referenced by",
                "See also",
                "Keywords",
                "A&S Ref",
                "Defines",
                "Source",
                "Sources",
            ],
        },
        "summary": {
            "sections": len(sections),
            "items": len(items),
            "by_kind": dict(sorted(Counter(str(item["kind"]) for item in items).items())),
            "formula_components": EXPECTED_COMPONENT_COUNTS,
            "review_state": status_counts(items, ("review", "state")),
            "lean_statement_status": status_counts(items, ("lean", "statement_status")),
            "lean_proof_status": status_counts(items, ("lean", "proof_status")),
            "quantitative_analogue_status": status_counts(
                items, ("quantitative", "analogue_status")
            ),
            "quantitative_statement_status": status_counts(
                items, ("quantitative", "statement_status")
            ),
            "quantitative_proof_status": status_counts(
                items, ("quantitative", "proof_status")
            ),
        },
        "sections": sections,
        "items": items,
    }


def validate_json_schema(inventory: dict[str, object], schema_path: pathlib.Path) -> bool:
    try:
        import jsonschema  # type: ignore[import-not-found]
    except ImportError:
        return False
    schema = json.loads(schema_path.read_text(encoding="utf-8"))
    jsonschema.validate(instance=inventory, schema=schema)
    return True


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--overrides", type=pathlib.Path, default=pathlib.Path("coverage/overrides.json")
    )
    parser.add_argument(
        "--source-item-overrides",
        type=pathlib.Path,
        default=pathlib.Path("coverage/source-item-overrides.json"),
    )
    parser.add_argument(
        "--schema",
        type=pathlib.Path,
        default=pathlib.Path("coverage/dlmf-source-inventory.schema.json"),
    )
    parser.add_argument(
        "--output",
        type=pathlib.Path,
        default=pathlib.Path("coverage/dlmf-4-10-source-inventory.json"),
    )
    args = parser.parse_args()

    inventory = build_inventory(args.overrides, args.source_item_overrides)
    schema_validated = validate_json_schema(inventory, args.schema)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(
        json.dumps(inventory, indent=2, ensure_ascii=False) + "\n", encoding="utf-8"
    )
    print(
        f"wrote {args.output}: {inventory['summary']['items']} items; "
        f"jsonschema={'validated' if schema_validated else 'not installed'}"
    )


if __name__ == "__main__":
    main()
