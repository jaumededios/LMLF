#!/usr/bin/env python3
"""Synchronize a reviewed consecutive section range into the coverage ledgers.

The section authors used two manifest revisions.  This command accepts both, validates their
numbered-formula coverage against the schema-v2 source inventory, writes formula overrides and a
separate non-formula source-item override map, regenerates both ledgers with the existing
generators, and updates the manual's hard-coded summary. It is deliberately deterministic apart
from the generators' ``generated_at`` fields.
"""

from __future__ import annotations

import argparse
import importlib.util
import json
import pathlib
import re
import sys
from typing import Any


SECTIONS = tuple(f"5.{n}" for n in range(1, 19))
EXPECTED_FORMULAS = 160
RELATIONS = {"exact", "specialization", "consequence", "related", "none", "unknown"}
FORMULA_RELATIONS = {"exact", "specialization", "consequence", "related"}
QUANTITATIVE_NAME_RE = re.compile(r"(?:remainder[_-]?bound|quantitative|decimal)", re.I)


def load_json(path: pathlib.Path) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        raise RuntimeError(f"cannot read valid JSON from {path}: {exc}") from exc


def canonical_id(value: object) -> str:
    if not isinstance(value, str):
        raise ValueError(f"formula ID must be a string, got {value!r}")
    value = value.removeprefix("dlmf:")
    match = re.fullmatch(r"(\d+\.\d+)\.(?:E)?(\d+)(?:(_\d+))?", value)
    if match is None:
        return value
    return f"{match.group(1)}.E{match.group(2)}{match.group(3) or ''}"


def canonical_source_id(value: object) -> str:
    if not isinstance(value, str) or not value:
        raise ValueError(f"source ID must be a nonempty string, got {value!r}")
    return value if value.startswith("dlmf:") else f"dlmf:{value}"


def source_shaped_id(value: object) -> bool:
    return isinstance(value, str) and (
        value.startswith("dlmf:") or re.fullmatch(r"(?:\d+\.\d+)#.+", value) is not None
    )


def resolve_source_id(value: object, expected: set[str]) -> str:
    """Resolve a manifest source label to its schema-v2 occurrence ID.

    DLMF can emit one occurrence for a stable label with a typed suffix such as
    ``#F1@caption`` or ``#i.info@annotation-note-1``. Author manifests use the reader-facing
    stable label. Accept that shorthand only when it resolves uniquely.
    """

    item_id = canonical_source_id(value)
    if item_id in expected:
        return item_id
    candidates = sorted(candidate for candidate in expected if candidate.startswith(item_id + "@"))
    if len(candidates) == 1:
        return candidates[0]
    return item_id


def load_inventory_ids(path: pathlib.Path) -> tuple[dict[str, set[str]], dict[str, set[str]]]:
    inventory = load_json(path)
    if inventory.get("schema_version") != 2:
        raise ValueError(f"{path}: expected schema_version 2")
    source = inventory.get("source", {})
    if (source.get("version"), source.get("release_date")) != ("1.2.7", "2026-06-15"):
        raise ValueError(f"{path}: inventory is not the pinned DLMF 1.2.7 release")
    formulas: dict[str, set[str]] = {section: set() for section in SECTIONS}
    nonformulas: dict[str, set[str]] = {section: set() for section in SECTIONS}
    for item in inventory.get("items", []):
        location = item.get("location", {})
        section = location.get("section")
        if section not in formulas:
            continue
        item_id = item.get("id")
        if not isinstance(item_id, str) or not item_id.startswith("dlmf:"):
            raise ValueError(f"{path}: malformed source item ID {item_id!r}")
        if item.get("kind") == "numbered_formula":
            formulas[section].add(canonical_id(item_id.removeprefix("dlmf:")))
        else:
            nonformulas[section].add(item_id)
    actual = sum(len(ids) for ids in formulas.values())
    if actual != EXPECTED_FORMULAS:
        raise ValueError(
            f"schema-v2 inventory has {actual} formulas in {SECTIONS[0]}--{SECTIONS[-1]}, "
            f"expected {EXPECTED_FORMULAS}"
        )
    return formulas, nonformulas


def load_expected_inventory(path: pathlib.Path) -> dict[str, set[str]]:
    """Compatibility wrapper returning only the numbered-formula IDs."""

    return load_inventory_ids(path)[0]


def section_id(manifest: dict[str, Any], path: pathlib.Path) -> str:
    if isinstance(manifest.get("section"), str):
        section = manifest["section"]
    else:
        ranges = manifest.get("section_range")
        if not isinstance(ranges, list) or len(ranges) != 1 or not isinstance(ranges[0], str):
            raise ValueError(f"{path}: expected a one-section section_range")
        section = ranges[0]
    if section not in SECTIONS:
        raise ValueError(f"{path}: section {section!r} is outside {SECTIONS[0]}--{SECTIONS[-1]}")
    return section


def list_strings(value: object, label: str) -> list[str]:
    if not isinstance(value, list) or not value or not all(isinstance(x, str) and x for x in value):
        raise ValueError(f"{label}: expected a non-empty list of declaration names")
    if len(set(value)) != len(value):
        raise ValueError(f"{label}: duplicate declaration names")
    return value


def normalise_formula_ids(values: object, label: str) -> set[str]:
    if not isinstance(values, list) or not all(isinstance(x, str) for x in values):
        raise ValueError(f"{label}: expected a list of formula IDs")
    normalised = {canonical_id(x) for x in values}
    if len(normalised) != len(values):
        raise ValueError(f"{label}: duplicate formula IDs")
    return normalised


def quantitative_names(entry: dict[str, Any], names: list[str], label: str) -> tuple[list[str], list[str], bool, bool, bool]:
    """Return qualitative names, quantitative names, and quantitative status flags."""

    if "quantitative_statement" in entry:
        analogue = bool(entry.get("quantitative_analogue"))
        q_statement = bool(entry.get("quantitative_statement"))
        q_proof = bool(entry.get("quantitative_proof"))
        q_names = entry.get("quantitative_declarations", [])
        if analogue:
            q_names = list_strings(q_names, f"{label}.quantitative_declarations")
        elif q_names:
            raise ValueError(f"{label}: quantitative declarations without an analogue")
        return names, q_names, analogue, q_statement, q_proof

    analogue_value = entry.get("quantitative_analogue", "not_applicable")
    if analogue_value in (False, None, "not_applicable", "absent"):
        return names, [], False, False, False
    if analogue_value != "present":
        raise ValueError(f"{label}: malformed quantitative_analogue {analogue_value!r}")
    q_names = [name for name in names if QUANTITATIVE_NAME_RE.search(name)]
    if not q_names:
        raise ValueError(f"{label}: quantitative analogue has no quantitative declaration name")
    qualitative = [name for name in names if name not in q_names]
    if not qualitative:
        raise ValueError(f"{label}: quantitative analogue consumed the only Lean declaration")
    # Author manifests state one proof_status for the formula.  The analogue is a checked
    # declaration when present; proof status is only promoted when an explicit page-shape proof
    # flag is available (or all declarations are explicitly proved in a future author manifest).
    q_proof = entry.get("proof_status") == "proved" and bool(entry.get("quantitative_proof", False))
    return qualitative, q_names, True, True, q_proof


def parse_manifest(
    path: pathlib.Path,
    expected: dict[str, set[str]],
    nonformula_expected: dict[str, set[str]] | None = None,
) -> tuple[dict[str, dict[str, Any]], dict[str, dict[str, Any]], set[str]]:
    manifest = load_json(path)
    if not isinstance(manifest, dict):
        raise ValueError(f"{path}: manifest must be a JSON object")
    section = section_id(manifest, path)
    expected_ids = expected[section]
    expected_nonformula_ids = (nonformula_expected or {}).get(section, set())
    listed_nonformula: set[str] = set()
    for field in ("nonformula_inventory_ids", "extra_statement_ids"):
        values = manifest.get(field, [])
        if not isinstance(values, list) or not all(isinstance(value, str) and value for value in values):
            raise ValueError(f"{path}.{field}: expected a list of IDs")
        for value in values:
            if field == "nonformula_inventory_ids" or source_shaped_id(value):
                item_id = resolve_source_id(value, expected_nonformula_ids)
                if item_id not in expected_nonformula_ids:
                    raise ValueError(f"{path}: unknown nonformula inventory ID {value!r}")
                listed_nonformula.add(item_id)
    author_shape = "declarations" in manifest
    if author_shape:
        manifest_expected = normalise_formula_ids(manifest.get("numbered_formula_ids_expected", []), f"{path}.numbered_formula_ids_expected")
        stated = normalise_formula_ids(manifest.get("numbered_formula_ids_stated", []), f"{path}.numbered_formula_ids_stated")
        omitted = normalise_formula_ids(manifest.get("numbered_formula_ids_omitted", []), f"{path}.numbered_formula_ids_omitted")
        if manifest_expected != stated or omitted or manifest_expected != expected_ids:
            raise ValueError(f"{path}: manifest formula IDs do not exactly match schema-v2 inventory for {section}")
        entries = manifest.get("declarations")
    else:
        included = normalise_formula_ids(manifest.get("included_ids", []), f"{path}.included_ids")
        omitted = normalise_formula_ids(manifest.get("omitted_ids", []), f"{path}.omitted_ids")
        if included != expected_ids or omitted:
            raise ValueError(f"{path}: manifest formula IDs do not exactly match schema-v2 inventory for {section}")
        if manifest.get("formula_count") != len(expected_ids):
            raise ValueError(f"{path}: formula_count disagrees with expected IDs")
        entries = manifest.get("entries")
    if not isinstance(entries, list):
        raise ValueError(f"{path}: declaration/entry list is missing")

    result: dict[str, dict[str, Any]] = {}
    nonformula_result: dict[str, dict[str, Any]] = {}
    for raw in entries:
        if not isinstance(raw, dict):
            raise ValueError(f"{path}: declaration entry must be an object")
        source_id = raw.get("id", raw.get("source_id"))
        if not isinstance(source_id, str):
            raise ValueError(f"{path}: declaration is missing source_id/id")
        formula_id = canonical_id(source_id)
        relation = raw.get("match", raw.get("relation"))
        if relation is None and source_shaped_id(source_id):
            relation = "none"
        if relation not in RELATIONS:
            raise ValueError(f"{path}: malformed declaration relation {relation!r} for {source_id}")
        if formula_id not in expected_ids:
            # Section vocabulary/caption declarations are not numbered formulas, but a typo in a
            # display formula ID must not be silently reclassified as vocabulary.
            if re.fullmatch(r"\d+\.\d+\.(?:E)?\d+(?:_\d+)?", source_id):
                raise ValueError(f"{path}: unknown formula declaration ID {source_id}")
            if source_shaped_id(source_id):
                item_id = resolve_source_id(source_id, expected_nonformula_ids)
                if item_id not in expected_nonformula_ids:
                    raise ValueError(f"{path}: unknown nonformula declaration ID {source_id!r}")
                names_value = raw.get("names", raw.get("lean_declarations", []))
                if names_value is None:
                    names_value = []
                if not isinstance(names_value, list) or not all(
                    isinstance(name, str) and name for name in names_value
                ) or len(set(names_value)) != len(names_value):
                    raise ValueError(f"{path}:{source_id}.names: expected unique nonempty strings")
                if item_id in nonformula_result:
                    raise ValueError(f"{path}: duplicate declaration for {item_id}")
                nonformula_result[item_id] = {
                    "names": names_value,
                    "relation": relation,
                    "proof_status": raw.get("proof_status", "not_applicable"),
                    "quantitative_analogue": raw.get("quantitative_analogue", "not_applicable"),
                    "quantitative_statement": raw.get("quantitative_statement"),
                    "quantitative_proof": raw.get("quantitative_proof"),
                    "quantitative_declarations": raw.get("quantitative_declarations", []),
                }
            continue
        names_value = raw.get("lean_declarations", raw.get("names"))
        names = list_strings(names_value, f"{path}:{source_id}.declarations")
        if formula_id in result:
            raise ValueError(f"{path}: duplicate declaration for {formula_id}")
        if relation not in FORMULA_RELATIONS:
            raise ValueError(f"{path}: malformed formula relation {relation!r} for {formula_id}")
        if "lean_statement" in raw:
            statement = raw["lean_statement"] is True
            proof = raw.get("lean_proof") is True
            proof_status = "proved" if proof else "missing"
            if not statement:
                raise ValueError(f"{path}:{formula_id}: reviewed formula lacks a Lean statement")
        else:
            proof_status = raw.get("proof_status")
            if proof_status not in {"missing", "proved", "not_applicable"}:
                raise ValueError(f"{path}:{formula_id}: malformed proof_status {proof_status!r}")
            statement, proof = True, proof_status == "proved"
        qualitative, q_names, q_analogue, q_statement, q_proof = quantitative_names(raw, names, f"{path}:{formula_id}")
        if proof and not statement:
            raise ValueError(f"{path}:{formula_id}: proof without statement")
        if q_statement and not q_analogue:
            raise ValueError(f"{path}:{formula_id}: quantitative statement without analogue")
        if q_proof and not q_statement:
            raise ValueError(f"{path}:{formula_id}: quantitative proof without statement")
        result[formula_id] = {
            "match": relation,
            "lean_statement": statement,
            "lean_proof": proof,
            "lean_proof_status": proof_status,
            "lean_declarations": qualitative,
            "quantitative_analogue": q_analogue,
            "quantitative_statement": q_statement,
            "quantitative_proof": q_proof,
            "quantitative_declarations": q_names,
            "notes": raw.get("notes") or None,
        }
    if set(result) != expected_ids:
        missing = sorted(expected_ids - set(result))
        raise ValueError(f"{path}: missing formula declarations {missing}")
    return result, nonformula_result, listed_nonformula


SOURCE_RELATION_MAP = {
    "none": "unknown",
    "unknown": "unknown",
    "exact": "exact",
    "equivalent": "equivalent",
    "specialization": "specialization",
    "consequence": "consequence",
    "generalization": "generalization",
    "related": "partial",
}


def source_item_override(
    item_id: str, entry: dict[str, Any], evidence_source: str
) -> dict[str, Any]:
    names = entry["names"]
    if not isinstance(entry.get("proof_status"), str) or entry["proof_status"] not in {
        "proved",
        "missing",
        "not_applicable",
    }:
        raise ValueError(f"{item_id}: malformed nonformula proof_status")
    relation = entry.get("relation")
    if relation not in SOURCE_RELATION_MAP:
        raise ValueError(f"{item_id}: malformed nonformula relation {relation!r}")

    if names:
        lean = {
            "statement_status": "checked",
            "proof_status": entry["proof_status"],
            "coverage_relation": SOURCE_RELATION_MAP[relation],
            "declarations": names,
            "evidence_source": evidence_source,
        }
        review_state = "claims_identified"
    else:
        lean = {
            "statement_status": "reviewed_absent",
            "proof_status": "not_applicable",
            "coverage_relation": "unknown",
            "declarations": [],
            "evidence_source": evidence_source,
        }
        review_state = "reviewed_no_claim"

    analogue_value = entry.get("quantitative_analogue", "not_applicable")
    if analogue_value in (True, "present"):
        analogue_status = "present"
    elif analogue_value == "candidate":
        analogue_status = "candidate"
    elif analogue_value in (False, None, "not_applicable", "absent"):
        analogue_status = "not_applicable"
    else:
        raise ValueError(f"{item_id}: malformed quantitative_analogue {analogue_value!r}")
    raw_q_statement = entry.get("quantitative_statement")
    raw_q_proof = entry.get("quantitative_proof")
    if raw_q_statement not in (None, False, True) or raw_q_proof not in (None, False, True):
        raise ValueError(f"{item_id}: quantitative statement/proof flags must be boolean")
    q_names = entry.get("quantitative_declarations", [])
    if not isinstance(q_names, list) or not all(
        isinstance(name, str) and name for name in q_names
    ) or len(set(q_names)) != len(q_names):
        raise ValueError(f"{item_id}: malformed quantitative declarations")
    if analogue_status == "present":
        if q_names and raw_q_statement is not True:
            raise ValueError(f"{item_id}: quantitative declarations require a checked statement")
        q_names = entry.get("quantitative_declarations", [])
        q_statement = raw_q_statement is True
        q_proof = raw_q_proof is True
        if q_proof and not q_statement:
            raise ValueError(f"{item_id}: quantitative proof requires a statement")
        quantitative = {
            "analogue_status": "present",
            "statement_status": "checked" if q_statement else "reviewed_absent",
            "proof_status": "proved" if q_proof else "missing" if q_statement else "not_applicable",
            "declarations": q_names,
            "evidence_source": evidence_source,
        }
    elif analogue_status == "candidate":
        if raw_q_statement is True or raw_q_proof is True or q_names:
            raise ValueError(f"{item_id}: candidate analogue cannot carry a checked claim")
        quantitative = {
            "analogue_status": "candidate",
            "statement_status": "reviewed_absent",
            "proof_status": "not_applicable",
            "declarations": [],
            "evidence_source": evidence_source,
        }
    else:
        if raw_q_statement is True or raw_q_proof is True or q_names:
            raise ValueError(f"{item_id}: quantitative claim requires an analogue")
        quantitative = {
            "analogue_status": "not_applicable",
            "statement_status": "reviewed_absent",
            "proof_status": "not_applicable",
            "declarations": [],
            "evidence_source": evidence_source,
        }
    if analogue_status in {"present", "candidate"}:
        review_state = "claims_identified"
    return {
        "review": {"state": review_state},
        "lean": lean,
        "quantitative": quantitative,
    }


def source_item_no_claim_override(evidence_source: str) -> dict[str, Any]:
    return {
        "review": {"state": "reviewed_no_claim"},
        "lean": {
            "statement_status": "reviewed_absent",
            "proof_status": "not_applicable",
            "coverage_relation": "unknown",
            "declarations": [],
            "evidence_source": evidence_source,
        },
        "quantitative": {
            "analogue_status": "not_applicable",
            "statement_status": "reviewed_absent",
            "proof_status": "not_applicable",
            "declarations": [],
            "evidence_source": evidence_source,
        },
    }


def import_script(path: pathlib.Path, name: str):
    spec = importlib.util.spec_from_file_location(name, path)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"cannot import generator {path}")
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module


def merge_overrides(old: dict[str, Any], reviewed: dict[str, dict[str, Any]]) -> dict[str, Any]:
    chapter_ids = set(reviewed)
    merged: dict[str, Any] = {key: value for key, value in old.items() if key not in chapter_ids}
    for formula_id in sorted(reviewed):
        # Reviewed section manifests are authoritative for Chapter 5. Unioning
        # an older proved row's declaration names reintroduces declarations that
        # have since been removed (as happened during the §5.10 API rewrite).
        # Strong proof evidence must therefore live in the current manifest;
        # §5.2.E1 already records its two proved Euler-integral declarations.
        merged[formula_id] = dict(reviewed[formula_id])
    return dict(sorted(merged.items()))


def merge_source_item_overrides(
    old: dict[str, Any],
    reviewed: dict[str, dict[str, Any]],
    listed_without_declaration: set[str],
    evidence_sources: dict[str, str],
    target_inventory_ids: set[str] | None = None,
) -> dict[str, Any]:
    target_ids = set(reviewed) | listed_without_declaration | (target_inventory_ids or set())
    merged = {key: value for key, value in old.items() if key not in target_ids}
    for item_id in sorted(reviewed):
        merged[item_id] = reviewed[item_id]
    for item_id in sorted(listed_without_declaration):
        merged[item_id] = source_item_no_claim_override(evidence_sources[item_id])
    return dict(sorted(merged.items()))


def validate_source_override_keys(
    inventory_path: pathlib.Path, overrides: dict[str, Any]
) -> None:
    inventory = load_json(inventory_path)
    formula_ids: set[str] = set()
    nonformula_ids: set[str] = set()
    for item in inventory.get("items", []):
        item_id = item.get("id")
        if not isinstance(item_id, str) or not item_id.startswith("dlmf:"):
            continue
        if item.get("kind") == "numbered_formula":
            formula_ids.add(item_id)
        else:
            nonformula_ids.add(item_id)
    malformed = sorted(key for key in overrides if not isinstance(key, str) or not key.startswith("dlmf:"))
    if malformed:
        raise ValueError(f"source-item override IDs must use dlmf: prefix: {malformed}")
    unknown = sorted(set(overrides) - nonformula_ids)
    if unknown:
        raise ValueError(f"source-item overrides reference unknown inventory IDs: {unknown}")
    formula_keys = sorted(set(overrides) & formula_ids)
    if formula_keys:
        raise ValueError(f"source-item overrides must be non-formula IDs: {formula_keys}")


def write_json(path: pathlib.Path, value: Any) -> None:
    path.write_text(json.dumps(value, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def regenerate(
    root: pathlib.Path,
    overrides_path: pathlib.Path,
    source_item_overrides_path: pathlib.Path,
) -> tuple[dict[str, Any], dict[str, Any]]:
    scripts = root / "scripts"
    coverage = import_script(scripts / "update_dlmf_coverage.py", "chapter5_update_coverage")
    inventory = import_script(scripts / "update_dlmf_source_inventory.py", "chapter5_update_inventory")

    # The existing generators predate the author manifest's explicit specialization relation.  Keep
    # their files untouched while allowing the reusable synchronization command to pass that
    # relation through to both ledgers (the schema-v2 inventory already supports it).
    def validate_status(identifier: str, status: dict[str, object]) -> None:
        if status["lean_proof"] and not status["lean_statement"]:
            raise ValueError(f"{identifier}: a proof requires a Lean statement")
        proof_status = status.get("lean_proof_status")
        if proof_status is not None:
            if proof_status not in {"missing", "proved", "not_applicable"}:
                raise ValueError(f"{identifier}: malformed Lean proof status {proof_status!r}")
            if (proof_status == "proved") != bool(status["lean_proof"]):
                raise ValueError(f"{identifier}: Lean proof boolean/status disagree")
        if status["quantitative_statement"] and not status["quantitative_analogue"]:
            raise ValueError(f"{identifier}: a quantitative statement requires an analogue")
        if status["quantitative_proof"] and not status["quantitative_statement"]:
            raise ValueError(f"{identifier}: a quantitative proof requires its statement")
        if status["match"] not in {"none", "exact", "specialization", "consequence", "related"}:
            raise ValueError(f"{identifier}: malformed match {status['match']!r}")

    coverage.validate_status = validate_status

    def apply_formula_override(item: dict[str, object], formula_id: str, overrides: dict[str, object]) -> None:
        raw = overrides.get(formula_id)
        if not isinstance(raw, dict):
            return
        statement = raw.get("lean_statement") is True
        proof = raw.get("lean_proof") is True
        proof_status = raw.get("lean_proof_status", "proved" if proof else "missing")
        declarations = raw.get("lean_declarations", [])
        match = raw.get("match")
        if statement:
            if match not in FORMULA_RELATIONS:
                raise ValueError(f"{formula_id}: malformed match {match!r}")
            item["lean"] = {
                "statement_status": "checked",
                "proof_status": proof_status,
                "coverage_relation": SOURCE_RELATION_MAP[match],
                "declarations": declarations,
                "evidence_source": "coverage/overrides.json",
            }
            item["review"] = {"state": "claims_identified"}
        analogue = raw.get("quantitative_analogue") is True
        q_statement = raw.get("quantitative_statement") is True
        q_proof = raw.get("quantitative_proof") is True
        q_declarations = raw.get("quantitative_declarations", [])
        if analogue:
            item["quantitative"] = {
                "analogue_status": "present",
                "statement_status": "checked" if q_statement else "unknown",
                "proof_status": "proved" if q_proof else "missing" if q_statement else "unknown",
                "declarations": q_declarations,
                "evidence_source": "coverage/overrides.json",
            }
        else:
            item["quantitative"] = {
                "analogue_status": "not_applicable",
                "statement_status": "reviewed_absent",
                "proof_status": "not_applicable",
                "declarations": [],
                "evidence_source": "coverage/overrides.json",
            }

    inventory.apply_formula_override = apply_formula_override
    formula_ledger = coverage.build_ledger(overrides_path)
    source_inventory = inventory.build_inventory(overrides_path, source_item_overrides_path)
    write_json(root / "coverage/dlmf-4-10.json", formula_ledger)
    write_json(root / "coverage/dlmf-4-10-source-inventory.json", source_inventory)
    return formula_ledger, source_inventory


def update_summary(path: pathlib.Path, ledger: dict[str, Any], chapter_number: int) -> None:
    text = path.read_text(encoding="utf-8")
    summary = ledger["summary"]
    total = {
        key: sum(int(summary[str(chapter)][key]) for chapter in range(4, 11))
        for key in ("formulas", "lean_statements", "lean_proofs", "quantitative_statements")
    }
    chapter_key = str(chapter_number)
    chapter = summary[chapter_key]
    row = re.compile(
        rf'<tr><td>"{chapter_key}"</td><td>"[0-9,]+"</td><td>"[0-9,]+"</td>'
        r'<td>"[0-9,]+"</td><td>"[0-9,]+"</td></tr>'
    )
    text, count = row.subn(
        f'<tr><td>"{chapter_key}"</td><td>"{chapter["formulas"]:,}"</td><td>"{chapter["lean_statements"]:,}"</td><td>"{chapter["lean_proofs"]:,}"</td><td>"{chapter["quantitative_statements"]:,}"</td></tr>',
        text,
        count=1,
    )
    if count != 1:
        raise RuntimeError(f"{path}: could not find Chapter {chapter_key} coverage row")
    total_row = re.compile(r'<tr><th>"Total"</th><th>"[0-9,]+"</th><th>"[0-9,]+"</th><th>"[0-9,]+"</th><th>"[0-9,]+"</th></tr>')
    text, count = total_row.subn(
        f'<tr><th>"Total"</th><th>"{total["formulas"]:,}"</th><th>"{total["lean_statements"]:,}"</th><th>"{total["lean_proofs"]:,}"</th><th>"{total["quantitative_statements"]:,}"</th></tr>',
        text,
        count=1,
    )
    if count != 1:
        raise RuntimeError(f"{path}: could not find coverage total row")
    path.write_text(text, encoding="utf-8")


def verify(formula_ledger: dict[str, Any], source_inventory: dict[str, Any], overrides: dict[str, Any]) -> dict[str, int]:
    formulas = [item for item in formula_ledger["statements"] if item["section"] in SECTIONS]
    checked = sum(item["lean_statement"] is True for item in formulas)
    proofs = sum(item["lean_proof"] is True for item in formulas)
    q_statements = sum(item["quantitative_statement"] is True for item in formulas)
    q_proofs = sum(item["quantitative_proof"] is True for item in formulas)
    if len(formulas) != EXPECTED_FORMULAS or checked != EXPECTED_FORMULAS:
        raise RuntimeError(
            f"reviewed formula guard failed for {SECTIONS[0]}--{SECTIONS[-1]}: "
            f"formulas={len(formulas)}, checked={checked}"
        )
    if source_inventory["summary"]["items"] != 4792 or source_inventory["summary"]["by_kind"]["numbered_formula"] != 2108:
        raise RuntimeError("structural inventory guard changed")
    inventory_formulas = [item for item in source_inventory["items"] if item["kind"] == "numbered_formula" and item["location"]["section"] in SECTIONS]
    inv_checked = sum(item["lean"]["statement_status"] == "checked" for item in inventory_formulas)
    inv_proofs = sum(item["lean"]["proof_status"] == "proved" for item in inventory_formulas)
    inv_q_statements = sum(item["quantitative"]["statement_status"] == "checked" for item in inventory_formulas)
    inv_q_proofs = sum(item["quantitative"]["proof_status"] == "proved" for item in inventory_formulas)
    if (checked, proofs, q_statements, q_proofs) != (inv_checked, inv_proofs, inv_q_statements, inv_q_proofs):
        raise RuntimeError("formula and structural-ledger status totals disagree")
    override_ids = {key for key in overrides if key in set(item["dlmf_id"] for item in formulas)}
    if len(override_ids) != EXPECTED_FORMULAS:
        raise RuntimeError(
            f"override guard failed: {len(override_ids)} overrides for {SECTIONS[0]}--{SECTIONS[-1]}"
        )
    return {"formulas": len(formulas), "checked": checked, "proofs": proofs, "quantitative_statements": q_statements, "quantitative_proofs": q_proofs}


def main() -> None:
    global SECTIONS, EXPECTED_FORMULAS
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=pathlib.Path, default=pathlib.Path("."))
    parser.add_argument("--chapter", type=int, default=5)
    parser.add_argument("--first-section", type=int, default=1)
    parser.add_argument("--last-section", type=int, default=18)
    parser.add_argument("--expected-formulas", type=int, default=160)
    parser.add_argument(
        "--source-item-overrides",
        type=pathlib.Path,
        default=pathlib.Path("coverage/source-item-overrides.json"),
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="validate manifests and print synchronized counts without writing ledgers",
    )
    args = parser.parse_args()
    if args.first_section < 1 or args.last_section < args.first_section:
        parser.error("section range must be positive and nonempty")
    SECTIONS = tuple(
        f"{args.chapter}.{number}"
        for number in range(args.first_section, args.last_section + 1)
    )
    EXPECTED_FORMULAS = args.expected_formulas
    root = args.root.resolve()
    inventory_path = root / "coverage/dlmf-4-10-source-inventory.json"
    expected, expected_nonformula = load_inventory_ids(inventory_path)
    manifests: dict[str, dict[str, Any]] = {}
    nonformula_manifests: dict[str, dict[str, dict[str, Any]]] = {}
    listed_nonformula: dict[str, set[str]] = {}
    evidence_sources: dict[str, str] = {}
    manifest_glob = f"chapter{args.chapter}-*.json"
    for path in sorted((root / "coverage/sections").glob(manifest_glob)):
        raw_manifest = load_json(path)
        raw_section = raw_manifest.get("section")
        if raw_section is None:
            raw_range = raw_manifest.get("section_range")
            raw_section = raw_range[0] if isinstance(raw_range, list) and len(raw_range) == 1 else None
        if raw_section not in SECTIONS:
            continue
        parsed, source_entries, listed = parse_manifest(path, expected, expected_nonformula)
        section = section_id(raw_manifest, path)
        if section in manifests:
            raise RuntimeError(f"duplicate manifest for {section}")
        manifests[section] = parsed
        nonformula_manifests[section] = source_entries
        listed_nonformula[section] = listed
        evidence_source = path.relative_to(root).as_posix()
        for item_id in source_entries:
            evidence_sources[item_id] = evidence_source
        for item_id in listed:
            evidence_sources.setdefault(item_id, evidence_source)
    if set(manifests) != set(SECTIONS):
        raise RuntimeError(
            f"missing manifests for {SECTIONS[0]}--{SECTIONS[-1]}: "
            f"{sorted(set(SECTIONS) - set(manifests))}"
        )

    # Re-read all manifests at the write boundary.  This catches a concurrent source-indexing
    # revision (notably section 5.15) instead of writing an override from stale in-memory data.
    expected, expected_nonformula = load_inventory_ids(inventory_path)
    manifests = {}
    nonformula_manifests = {}
    listed_nonformula = {}
    evidence_sources = {}
    for path in sorted((root / "coverage/sections").glob(manifest_glob)):
        raw_manifest = load_json(path)
        raw_section = raw_manifest.get("section")
        if raw_section is None:
            raw_range = raw_manifest.get("section_range")
            raw_section = raw_range[0] if isinstance(raw_range, list) and len(raw_range) == 1 else None
        if raw_section not in SECTIONS:
            continue
        parsed, source_entries, listed = parse_manifest(path, expected, expected_nonformula)
        section = section_id(raw_manifest, path)
        if section in manifests:
            raise RuntimeError(f"duplicate manifest for {section}")
        manifests[section] = parsed
        nonformula_manifests[section] = source_entries
        listed_nonformula[section] = listed
        evidence_source = path.relative_to(root).as_posix()
        for item_id in source_entries:
            evidence_sources[item_id] = evidence_source
        for item_id in listed:
            evidence_sources.setdefault(item_id, evidence_source)
    reviewed = {formula_id: entry for section in SECTIONS for formula_id, entry in sorted(manifests[section].items())}
    old = load_json(root / "coverage/overrides.json")
    if not isinstance(old, dict):
        raise RuntimeError("coverage/overrides.json must be an object")
    merged = merge_overrides(old, reviewed)
    source_item_overrides_path = args.source_item_overrides
    if not source_item_overrides_path.is_absolute():
        source_item_overrides_path = root / source_item_overrides_path
    old_source = load_json(source_item_overrides_path) if source_item_overrides_path.exists() else {}
    if not isinstance(old_source, dict):
        raise RuntimeError("coverage/source-item-overrides.json must be an object")
    reviewed_source: dict[str, dict[str, Any]] = {}
    listed_without_declaration: set[str] = set()
    for section in SECTIONS:
        section_entries = nonformula_manifests[section]
        evidence_source = {
            item_id: evidence_sources[item_id] for item_id in section_entries
        }
        for item_id, entry in section_entries.items():
            reviewed_source[item_id] = source_item_override(
                item_id, entry, evidence_source[item_id]
            )
        listed_without_declaration.update(listed_nonformula[section] - set(section_entries))
    source_merged = merge_source_item_overrides(
        old_source,
        reviewed_source,
        listed_without_declaration,
        evidence_sources,
        target_inventory_ids={
            item_id for section in SECTIONS for item_id in expected_nonformula[section]
        },
    )
    validate_source_override_keys(inventory_path, source_merged)
    source_status_validator = import_script(
        root / "scripts/update_dlmf_source_inventory.py", "source_item_status_validator"
    )
    for item_id, status in source_merged.items():
        source_status_validator.validate_source_item_override(item_id, status)
    if args.dry_run:
        print(
            json.dumps(
                {
                    "formula_overrides": len(reviewed),
                    "source_item_overrides": len(source_merged),
                    "source_item_no_claim": len(listed_without_declaration),
                },
                sort_keys=True,
            )
        )
        return
    write_json(root / "coverage/overrides.json", merged)
    source_item_overrides_path.parent.mkdir(parents=True, exist_ok=True)
    write_json(source_item_overrides_path, source_merged)
    ledger, inventory = regenerate(
        root, root / "coverage/overrides.json", source_item_overrides_path
    )
    update_summary(root / "doc/LMLFManual/Components.lean", ledger, args.chapter)
    totals = verify(ledger, inventory, merged)
    print(json.dumps(totals, sort_keys=True))


if __name__ == "__main__":
    main()
