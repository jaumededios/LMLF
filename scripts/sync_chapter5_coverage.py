#!/usr/bin/env python3
"""Synchronize the reviewed Chapter 5 section manifests into coverage ledgers.

The section authors used two manifest revisions.  This command accepts both, validates their
numbered-formula coverage against the schema-v2 source inventory, writes the formula overrides,
regenerates both ledgers with the existing generators, and updates the manual's hard-coded
summary.  It is deliberately deterministic apart from the generators' ``generated_at`` fields.
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
RELATIONS = {"exact", "specialization", "consequence", "related"}
FORMULA_RELATIONS = {"exact", "specialization", "consequence"}
QUANTITATIVE_NAME_RE = re.compile(r"(?:remainder[_-]?bound|quantitative|decimal)", re.I)


def load_json(path: pathlib.Path) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        raise RuntimeError(f"cannot read valid JSON from {path}: {exc}") from exc


def canonical_id(value: object) -> str:
    if not isinstance(value, str):
        raise ValueError(f"formula ID must be a string, got {value!r}")
    match = re.fullmatch(r"(\d+\.\d+)\.(?:E)?(\d+)(?:(_\d+))?", value)
    if match is None:
        return value
    return f"{match.group(1)}.E{match.group(2)}{match.group(3) or ''}"


def load_expected_inventory(path: pathlib.Path) -> dict[str, set[str]]:
    inventory = load_json(path)
    if inventory.get("schema_version") != 2:
        raise ValueError(f"{path}: expected schema_version 2")
    source = inventory.get("source", {})
    if (source.get("version"), source.get("release_date")) != ("1.2.7", "2026-06-15"):
        raise ValueError(f"{path}: inventory is not the pinned DLMF 1.2.7 release")
    by_section: dict[str, set[str]] = {section: set() for section in SECTIONS}
    for item in inventory.get("items", []):
        if item.get("kind") != "numbered_formula":
            continue
        location = item.get("location", {})
        section = location.get("section")
        if section in by_section:
            item_id = item.get("id")
            if not isinstance(item_id, str) or not item_id.startswith("dlmf:"):
                raise ValueError(f"{path}: malformed formula item ID {item_id!r}")
            by_section[section].add(canonical_id(item_id.removeprefix("dlmf:")))
    actual = sum(len(ids) for ids in by_section.values())
    if actual != EXPECTED_FORMULAS:
        raise ValueError(f"schema-v2 inventory has {actual} Chapter 5.1--5.18 formulas, expected {EXPECTED_FORMULAS}")
    return by_section


def section_id(manifest: dict[str, Any], path: pathlib.Path) -> str:
    if isinstance(manifest.get("section"), str):
        section = manifest["section"]
    else:
        ranges = manifest.get("section_range")
        if not isinstance(ranges, list) or len(ranges) != 1 or not isinstance(ranges[0], str):
            raise ValueError(f"{path}: expected a one-section section_range")
        section = ranges[0]
    if section not in SECTIONS:
        raise ValueError(f"{path}: section {section!r} is outside 5.1--5.18")
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


def parse_manifest(path: pathlib.Path, expected: dict[str, set[str]]) -> dict[str, dict[str, Any]]:
    manifest = load_json(path)
    if not isinstance(manifest, dict):
        raise ValueError(f"{path}: manifest must be a JSON object")
    section = section_id(manifest, path)
    expected_ids = expected[section]
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
    for raw in entries:
        if not isinstance(raw, dict):
            raise ValueError(f"{path}: declaration entry must be an object")
        source_id = raw.get("id", raw.get("source_id"))
        if not isinstance(source_id, str):
            raise ValueError(f"{path}: declaration is missing source_id/id")
        formula_id = canonical_id(source_id)
        relation = raw.get("match", raw.get("relation"))
        if relation not in RELATIONS:
            raise ValueError(f"{path}: malformed declaration relation {relation!r} for {source_id}")
        names_value = raw.get("lean_declarations", raw.get("names"))
        names = list_strings(names_value, f"{path}:{source_id}.declarations")
        if formula_id not in expected_ids:
            # Section vocabulary/caption declarations are not numbered formulas, but a typo in a
            # display formula ID must not be silently reclassified as vocabulary.
            if re.fullmatch(r"\d+\.\d+\.(?:E)?\d+(?:_\d+)?", source_id):
                raise ValueError(f"{path}: unknown formula declaration ID {source_id}")
            continue
        if formula_id in result:
            raise ValueError(f"{path}: duplicate declaration for {formula_id}")
        if relation not in FORMULA_RELATIONS:
            raise ValueError(f"{path}: malformed formula relation {relation!r} for {formula_id}")
        if "lean_statement" in raw:
            statement = raw["lean_statement"] is True
            proof = raw.get("lean_proof") is True
            if not statement:
                raise ValueError(f"{path}:{formula_id}: reviewed formula lacks a Lean statement")
        else:
            proof_status = raw.get("proof_status")
            if proof_status not in {"missing", "proved"}:
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
    return result


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
        current = dict(reviewed[formula_id])
        previous = old.get(formula_id)
        if isinstance(previous, dict):
            # Preserve only stronger proof evidence while replacing stale Chapter 5 mappings.
            # In particular, the old 5.2.E1 proved gamma_eq_eulerIntegral declaration survives;
            # old unproved 5.11 names are intentionally not carried into the reviewed manifest.
            if previous.get("lean_proof") is True:
                current["lean_proof"] = True
                current["lean_statement"] = True
                old_names = previous.get("lean_declarations", [])
                if isinstance(old_names, list):
                    current["lean_declarations"] = sorted(
                        set(current["lean_declarations"]) | {name for name in old_names if isinstance(name, str) and name}
                    )
            if previous.get("quantitative_proof") is True:
                current["quantitative_proof"] = True
                current["quantitative_statement"] = True
                current["quantitative_analogue"] = True
                old_names = previous.get("quantitative_declarations", [])
                if isinstance(old_names, list):
                    current["quantitative_declarations"] = sorted(
                        set(current["quantitative_declarations"]) | {name for name in old_names if isinstance(name, str) and name}
                    )
        merged[formula_id] = current
    return dict(sorted(merged.items()))


def write_json(path: pathlib.Path, value: Any) -> None:
    path.write_text(json.dumps(value, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def regenerate(root: pathlib.Path, overrides_path: pathlib.Path) -> tuple[dict[str, Any], dict[str, Any]]:
    scripts = root / "scripts"
    coverage = import_script(scripts / "update_dlmf_coverage.py", "chapter5_update_coverage")
    inventory = import_script(scripts / "update_dlmf_source_inventory.py", "chapter5_update_inventory")

    # The existing generators predate the author manifest's explicit specialization relation.  Keep
    # their files untouched while allowing the reusable synchronization command to pass that
    # relation through to both ledgers (the schema-v2 inventory already supports it).
    def validate_status(identifier: str, status: dict[str, object]) -> None:
        if status["lean_proof"] and not status["lean_statement"]:
            raise ValueError(f"{identifier}: a proof requires a Lean statement")
        if status["quantitative_statement"] and not status["quantitative_analogue"]:
            raise ValueError(f"{identifier}: a quantitative statement requires an analogue")
        if status["quantitative_proof"] and not status["quantitative_statement"]:
            raise ValueError(f"{identifier}: a quantitative proof requires its statement")
        if status["match"] not in {"none", "exact", "specialization", "consequence"}:
            raise ValueError(f"{identifier}: malformed match {status['match']!r}")

    coverage.validate_status = validate_status

    def apply_formula_override(item: dict[str, object], formula_id: str, overrides: dict[str, object]) -> None:
        raw = overrides.get(formula_id)
        if not isinstance(raw, dict):
            return
        statement = raw.get("lean_statement") is True
        proof = raw.get("lean_proof") is True
        declarations = raw.get("lean_declarations", [])
        match = raw.get("match")
        if statement:
            if match not in {"exact", "specialization", "consequence"}:
                raise ValueError(f"{formula_id}: malformed match {match!r}")
            item["lean"] = {
                "statement_status": "checked",
                "proof_status": "proved" if proof else "missing",
                "coverage_relation": match,
                "declarations": declarations,
                "evidence_source": "coverage/overrides.json",
            }
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

    inventory.apply_formula_override = apply_formula_override
    formula_ledger = coverage.build_ledger(overrides_path)
    source_inventory = inventory.build_inventory(overrides_path)
    write_json(root / "coverage/dlmf-4-10.json", formula_ledger)
    write_json(root / "coverage/dlmf-4-10-source-inventory.json", source_inventory)
    return formula_ledger, source_inventory


def update_summary(path: pathlib.Path, ledger: dict[str, Any]) -> None:
    text = path.read_text(encoding="utf-8")
    summary = ledger["summary"]
    total = {
        key: sum(int(summary[str(chapter)][key]) for chapter in range(4, 11))
        for key in ("formulas", "lean_statements", "lean_proofs", "quantitative_statements")
    }
    chapter = summary["5"]
    row = re.compile(r'<tr><td>"5"</td><td>"[0-9,]+"</td><td>"[0-9,]+"</td><td>"[0-9,]+"</td><td>"[0-9,]+"</td></tr>')
    text, count = row.subn(
        f'<tr><td>"5"</td><td>"{chapter["formulas"]:,}"</td><td>"{chapter["lean_statements"]:,}"</td><td>"{chapter["lean_proofs"]:,}"</td><td>"{chapter["quantitative_statements"]:,}"</td></tr>',
        text,
        count=1,
    )
    if count != 1:
        raise RuntimeError(f"{path}: could not find Chapter 5 coverage row")
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
        raise RuntimeError(f"Chapter 5 reviewed formula guard failed: formulas={len(formulas)}, checked={checked}")
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
        raise RuntimeError(f"override guard failed: {len(override_ids)} Chapter 5 overrides")
    return {"formulas": len(formulas), "checked": checked, "proofs": proofs, "quantitative_statements": q_statements, "quantitative_proofs": q_proofs}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=pathlib.Path, default=pathlib.Path("."))
    args = parser.parse_args()
    root = args.root.resolve()
    expected = load_expected_inventory(root / "coverage/dlmf-4-10-source-inventory.json")
    manifests: dict[str, dict[str, Any]] = {}
    for path in sorted((root / "coverage/sections").glob("chapter5-*.json")):
        parsed = parse_manifest(path, expected)
        section = section_id(load_json(path), path)
        if section in manifests:
            raise RuntimeError(f"duplicate manifest for {section}")
        manifests[section] = parsed
    if set(manifests) != set(SECTIONS):
        raise RuntimeError(f"missing Chapter 5 manifests: {sorted(set(SECTIONS) - set(manifests))}")

    # Re-read all manifests at the write boundary.  This catches a concurrent source-indexing
    # revision (notably section 5.15) instead of writing an override from stale in-memory data.
    expected = load_expected_inventory(root / "coverage/dlmf-4-10-source-inventory.json")
    manifests = {}
    for path in sorted((root / "coverage/sections").glob("chapter5-*.json")):
        parsed = parse_manifest(path, expected)
        section = section_id(load_json(path), path)
        if section in manifests:
            raise RuntimeError(f"duplicate manifest for {section}")
        manifests[section] = parsed
    reviewed = {formula_id: entry for section in SECTIONS for formula_id, entry in sorted(manifests[section].items())}
    old = load_json(root / "coverage/overrides.json")
    if not isinstance(old, dict):
        raise RuntimeError("coverage/overrides.json must be an object")
    merged = merge_overrides(old, reviewed)
    write_json(root / "coverage/overrides.json", merged)
    ledger, inventory = regenerate(root, root / "coverage/overrides.json")
    update_summary(root / "doc/LMLFManual/Components.lean", ledger)
    totals = verify(ledger, inventory, merged)
    print(json.dumps(totals, sort_keys=True))


if __name__ == "__main__":
    main()
