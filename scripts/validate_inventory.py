#!/usr/bin/env python3
"""Validate the normalized Olver inventory using only the standard library."""

from __future__ import annotations

import csv
import json
import sys
from copy import deepcopy
from collections import defaultdict
from pathlib import Path


SCHEMA_VERSION = "inventory-v1.0.0"
ROOT = Path(__file__).resolve().parents[1]
INVENTORY = ROOT / "blueprint" / "inventory"
CLASSIFICATION_AUTHORITY = ROOT / "review" / "classifications-v2.json"
CLASSIFICATION_SCHEMA_VERSION = "lmlf-classification-v2"
DIRECT_SOURCE_EVIDENCE_TYPES = {"direct_formula", "direct_prose"}
RESERVED_PENDING_SNAPSHOT_ID = "SRC-OLV-1997-COLLATION-PENDING"
RESERVED_PENDING_SNAPSHOT_FIELDS = {
    "edition_id": "olver_1997b",
    "snapshot_kind": "locked_copy_placeholder",
    "impression_year": "1997",
    "publisher": "A K Peters",
    "identifier": "ISBN 1-56881-069-5",
    "url": "",
    "access_date": "",
    "availability_status": "pending",
    "digest_algorithm": "",
    "digest_value": "",
    "digest_status": "unresolved",
    "edition_reconciliation_status": "unresolved",
    "page_mapping_status": "unresolved",
    "rights_status": "unknown",
}


HEADERS: dict[str, list[str]] = {
    "editions.csv": [
        "schema_version",
        "edition_id",
        "author",
        "title",
        "publisher",
        "publication_year",
        "impression_kind",
        "target_status",
        "isbn",
        "bibliographic_status",
        "notes",
    ],
    "edition_relations.csv": [
        "schema_version",
        "edition_relation_id",
        "from_edition_id",
        "to_edition_id",
        "relation_type",
        "content_equivalence_status",
        "page_locator_equivalence_status",
        "join_semantics",
        "evidence",
        "notes",
    ],
    "source_snapshots.csv": [
        "schema_version",
        "source_snapshot_id",
        "edition_id",
        "snapshot_kind",
        "impression_year",
        "publisher",
        "identifier",
        "url",
        "access_date",
        "availability_status",
        "digest_algorithm",
        "digest_value",
        "digest_status",
        "edition_reconciliation_status",
        "page_mapping_status",
        "rights_status",
        "notes",
    ],
    "page_audits.csv": [
        "schema_version",
        "page_audit_id",
        "source_snapshot_id",
        "coordinate_system",
        "snapshot_page_start",
        "snapshot_page_end",
        "printed_page_start",
        "printed_page_end",
        "audit_scope",
        "audit_status",
        "audited_by",
        "audit_date",
        "reviewed_by",
        "review_date",
        "notes",
    ],
    "occurrences.csv": [
        "schema_version",
        "occurrence_id",
        "edition_id",
        "source_snapshot_id",
        "queue_class",
        "chapter",
        "section",
        "printed_page_start",
        "printed_page_end",
        "source_locator",
        "printed_label",
        "source_kind",
        "target_class",
        "novelty_class",
        "context_role",
        "evidence_type",
        "resolution_status",
        "transcription_status",
        "transcription_hash_algorithm",
        "transcription_hash",
        "transcribed_by",
        "transcription_date",
        "reconciliation_status",
        "reconciliation_result",
        "notes",
        "crosscheck_url",
    ],
    "notation.csv": [
        "schema_version",
        "notation_id",
        "entity_id",
        "source_snapshot_id",
        "source_locator",
        "printed_symbol",
        "binder_and_argument_order",
        "ambient_type",
        "parameter_roles",
        "domain_and_branch",
        "normalization",
        "exceptional_values",
        "derivative_variable",
        "evidence_type",
        "resolution_status",
        "transcription_status",
        "notes",
    ],
    "entities.csv": [
        "schema_version",
        "entity_id",
        "queue_class",
        "canonical_label",
        "aliases",
        "object_kind",
        "source_basis",
        "identity_status",
        "normalization_status",
        "dlmf_reference",
        "lean_reuse_candidate",
        "identification_status",
        "notes",
    ],
    "entity_evidence.csv": [
        "schema_version",
        "entity_evidence_id",
        "entity_id",
        "edition_id",
        "source_snapshot_id",
        "evidence_role",
        "evidence_status",
        "notes",
    ],
    "cards.csv": [
        "schema_version",
        "card_id",
        "theorem_class",
        "coverage_class",
        "novelty_class",
        "manifest_id",
        "registration_status",
        "artifact_status",
        "target_path",
        "notes",
    ],
    "manifests.csv": [
        "schema_version",
        "manifest_id",
        "manifest_version",
        "scope_closed",
        "occurrence_selection_locked",
        "manifest_status",
        "declared_source_occurrence_total",
        "notes",
    ],
    "occurrence_notations.csv": [
        "schema_version",
        "occurrence_id",
        "notation_id",
        "notation_role",
        "link_status",
        "notes",
    ],
    "occurrence_entities.csv": [
        "schema_version",
        "occurrence_id",
        "entity_id",
        "entity_role",
        "link_status",
        "notes",
    ],
    "occurrence_cards.csv": [
        "schema_version",
        "occurrence_id",
        "card_id",
        "card_role",
        "link_status",
        "notes",
    ],
    "occurrence_manifests.csv": [
        "schema_version",
        "occurrence_id",
        "manifest_id",
        "coverage_role",
        "notes",
    ],
}


PRIMARY_KEYS: dict[str, tuple[str, ...]] = {
    "editions.csv": ("edition_id",),
    "edition_relations.csv": ("edition_relation_id",),
    "source_snapshots.csv": ("source_snapshot_id",),
    "page_audits.csv": ("page_audit_id",),
    "occurrences.csv": ("occurrence_id",),
    "notation.csv": ("notation_id",),
    "entities.csv": ("entity_id",),
    "entity_evidence.csv": ("entity_evidence_id",),
    "cards.csv": ("card_id",),
    "manifests.csv": ("manifest_id",),
    "occurrence_notations.csv": ("occurrence_id", "notation_id"),
    "occurrence_entities.csv": ("occurrence_id", "entity_id"),
    "occurrence_cards.csv": ("occurrence_id", "card_id"),
    "occurrence_manifests.csv": ("occurrence_id", "manifest_id"),
}


REQUIRED: dict[str, tuple[str, ...]] = {
    name: ("schema_version",) + PRIMARY_KEYS[name] for name in HEADERS
}
REQUIRED.update(
    {
        "editions.csv": REQUIRED["editions.csv"]
        + (
            "author",
            "title",
            "publisher",
            "publication_year",
            "impression_kind",
            "target_status",
            "bibliographic_status",
        ),
        "edition_relations.csv": REQUIRED["edition_relations.csv"]
        + (
            "from_edition_id",
            "to_edition_id",
            "relation_type",
            "content_equivalence_status",
            "page_locator_equivalence_status",
            "join_semantics",
            "evidence",
        ),
        "source_snapshots.csv": REQUIRED["source_snapshots.csv"]
        + (
            "edition_id",
            "snapshot_kind",
            "availability_status",
            "digest_status",
            "edition_reconciliation_status",
            "page_mapping_status",
            "rights_status",
        ),
        "page_audits.csv": REQUIRED["page_audits.csv"]
        + (
            "source_snapshot_id",
            "coordinate_system",
            "audit_scope",
            "audit_status",
            "audited_by",
            "audit_date",
        ),
        "occurrences.csv": REQUIRED["occurrences.csv"]
        + (
            "edition_id",
            "source_snapshot_id",
            "queue_class",
            "chapter",
            "source_locator",
            "source_kind",
            "target_class",
            "novelty_class",
            "context_role",
            "evidence_type",
            "resolution_status",
            "transcription_status",
            "reconciliation_status",
        ),
        "notation.csv": REQUIRED["notation.csv"]
        + (
            "entity_id",
            "source_snapshot_id",
            "source_locator",
            "printed_symbol",
            "binder_and_argument_order",
            "ambient_type",
            "evidence_type",
            "resolution_status",
            "transcription_status",
        ),
        "entities.csv": REQUIRED["entities.csv"]
        + (
            "queue_class",
            "canonical_label",
            "object_kind",
            "source_basis",
            "identity_status",
            "normalization_status",
            "identification_status",
        ),
        "entity_evidence.csv": REQUIRED["entity_evidence.csv"]
        + (
            "entity_id",
            "edition_id",
            "source_snapshot_id",
            "evidence_role",
            "evidence_status",
        ),
        "cards.csv": REQUIRED["cards.csv"]
        + (
            "theorem_class",
            "coverage_class",
            "novelty_class",
            "manifest_id",
            "registration_status",
            "artifact_status",
        ),
        "manifests.csv": REQUIRED["manifests.csv"]
        + (
            "manifest_version",
            "scope_closed",
            "occurrence_selection_locked",
            "manifest_status",
            "declared_source_occurrence_total",
        ),
        "occurrence_notations.csv": REQUIRED["occurrence_notations.csv"]
        + ("notation_role", "link_status"),
        "occurrence_entities.csv": REQUIRED["occurrence_entities.csv"]
        + ("entity_role", "link_status"),
        "occurrence_cards.csv": REQUIRED["occurrence_cards.csv"]
        + ("card_role", "link_status"),
        "occurrence_manifests.csv": REQUIRED["occurrence_manifests.csv"]
        + ("coverage_role",),
    }
)


ENUMS: dict[tuple[str, str], set[str]] = {
    ("editions.csv", "impression_kind"): {
        "original_edition",
        "corrected_reprint",
        "later_reprint_preview",
        "later_reprint",
    },
    ("editions.csv", "target_status"): {"locked_target", "comparison_only"},
    ("editions.csv", "bibliographic_status"): {
        "authoritatively_identified",
        "publisher_preview_identified",
        "unresolved",
    },
    ("edition_relations.csv", "relation_type"): {
        "reprint_of",
        "later_reprint_of",
        "corrected_reprint_of",
    },
    ("edition_relations.csv", "content_equivalence_status"): {
        "matched",
        "mismatch",
        "unresolved",
    },
    ("edition_relations.csv", "page_locator_equivalence_status"): {
        "matched",
        "mismatch",
        "unresolved",
    },
    ("edition_relations.csv", "join_semantics"): {"equivalent", "non_equivalent"},
    ("source_snapshots.csv", "snapshot_kind"): {
        "publisher_preview",
        "locked_copy_placeholder",
        "local_scan",
        "physical_copy",
    },
    ("source_snapshots.csv", "availability_status"): {"available", "partial", "pending"},
    ("source_snapshots.csv", "digest_status"): {"verified", "unresolved"},
    ("source_snapshots.csv", "edition_reconciliation_status"): {
        "matched",
        "mismatch",
        "unresolved",
    },
    ("source_snapshots.csv", "page_mapping_status"): {"matched", "partial", "unresolved"},
    ("source_snapshots.csv", "rights_status"): {
        "all_rights_reserved",
        "permission_recorded",
        "public_domain",
        "unknown",
    },
    ("page_audits.csv", "coordinate_system"): {"pdf_page", "printed_page", "physical_leaf"},
    ("page_audits.csv", "audit_status"): {"partial", "complete"},
    ("occurrences.csv", "queue_class"): {
        "seed",
        "cross_cutting",
        "later_family",
        "source_theorem",
        "project_extra",
    },
    ("occurrences.csv", "source_kind"): {
        "body_definition",
        "body_use",
        "displayed_formula",
        "exercise",
        "answer",
        "table",
        "cross_reference",
        "toc_heading",
        "index_lead",
        "source_theorem",
        "project_spec",
    },
    ("occurrences.csv", "target_class"): {
        "source_definition",
        "source_theorem",
        "source_formula",
        "source_exercise",
        "source_table",
        "inventory_lead",
        "project_extra",
    },
    ("occurrences.csv", "novelty_class"): {
        "unclassified",
        "source_recovery",
        "formalization_only",
        "strengthening",
        "new_mathematics",
    },
    ("occurrences.csv", "evidence_type"): {
        "direct_formula",
        "direct_prose",
        "toc_only",
        "index_only",
        "dlmf_locator",
        "project_design",
    },
    ("occurrences.csv", "resolution_status"): {
        "occurrence_unresolved",
        "located_untranscribed",
        "transcribed_unreconciled",
        "resolved",
        "excluded_name_only",
        "project_extra",
    },
    ("occurrences.csv", "transcription_status"): {
        "not_started",
        "locator_only",
        "summary_only",
        "mathematical_transcription",
        "verified",
    },
    ("occurrences.csv", "reconciliation_status"): {
        "unresolved",
        "matched",
        "mismatch",
        "not_applicable",
    },
    ("notation.csv", "ambient_type"): {"real", "complex", "mixed", "unresolved"},
    ("notation.csv", "evidence_type"): {
        "direct_formula",
        "direct_prose",
        "project_design",
    },
    ("notation.csv", "resolution_status"): {"normalization_unresolved", "resolved"},
    ("notation.csv", "transcription_status"): {
        "summary_only",
        "mathematical_transcription",
        "verified",
    },
    ("entities.csv", "queue_class"): {"seed", "cross_cutting", "later_family", "project_extra"},
    ("entities.csv", "object_kind"): {
        "named_special_function",
        "named_normalization",
        "named_derivative",
        "provisional_named_special_function",
        "named_comparison_function",
        "project_auxiliary",
    },
    ("entities.csv", "identity_status"): {"provisional", "confirmed", "excluded"},
    ("entities.csv", "normalization_status"): {"unresolved", "resolved", "not_applicable"},
    ("entities.csv", "identification_status"): {
        "not_assessed",
        "reuse_candidate",
        "construction_planned",
        "bridge_pending",
        "proved",
    },
    ("entity_evidence.csv", "evidence_role"): {
        "body_definition",
        "body_naming",
        "toc_lead",
        "project_design",
    },
    ("entity_evidence.csv", "evidence_status"): {"provisional", "confirmed"},
    ("cards.csv", "registration_status"): {
        "planning_only",
        "execution_ready",
        "active",
        "complete",
        "superseded",
    },
    ("cards.csv", "artifact_status"): {"planned", "file_present"},
    ("manifests.csv", "scope_closed"): {"true", "false"},
    ("manifests.csv", "occurrence_selection_locked"): {
        "true",
        "false",
        "not_applicable",
    },
    ("manifests.csv", "manifest_status"): {
        "planning_only",
        "execution_ready",
        "active",
        "complete",
        "superseded",
    },
    ("occurrence_notations.csv", "notation_role"): {
        "defined_notation",
        "used_notation",
        "alias_notation",
    },
    ("occurrence_notations.csv", "link_status"): {"provisional", "confirmed"},
    ("occurrence_entities.csv", "entity_role"): {
        "defines",
        "uses",
        "names",
        "defines_or_aliases",
        "provisional_definition",
        "candidate_family",
    },
    ("occurrence_entities.csv", "link_status"): {"provisional", "confirmed"},
    ("occurrence_cards.csv", "card_role"): {
        "generic_dependency",
        "exact_source_target",
        "named_application",
        "source_recovery",
    },
    ("occurrence_cards.csv", "link_status"): {"provisional", "confirmed"},
    ("occurrence_manifests.csv", "coverage_role"): {"source_coverage", "context_only"},
}


def add_error(errors: list[str], filename: str, line: int | None, message: str) -> None:
    location = filename if line is None else f"{filename}:{line}"
    errors.append(f"{location}: {message}")


def load_classification_authority(
    errors: list[str],
) -> tuple[dict[tuple[str, str], set[str]], dict[str, dict[str, str]]]:
    """Load packet enums and required examples from the single frozen authority."""

    filename = str(CLASSIFICATION_AUTHORITY.relative_to(ROOT))
    try:
        with CLASSIFICATION_AUTHORITY.open("r", encoding="utf-8") as handle:
            document = json.load(handle)
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        add_error(errors, filename, None, f"cannot load classification authority: {exc}")
        return {}, {}

    if not isinstance(document, dict):
        add_error(errors, filename, None, "classification authority must be a JSON object")
        return {}, {}
    if document.get("schema_version") != CLASSIFICATION_SCHEMA_VERSION:
        add_error(
            errors,
            filename,
            None,
            f"schema_version must be {CLASSIFICATION_SCHEMA_VERSION!r}",
        )
    if document.get("record_kind") != "classification_vocabulary":
        add_error(errors, filename, None, "record_kind must be 'classification_vocabulary'")
    if document.get("status") != "frozen":
        add_error(errors, filename, None, "classification authority must have status='frozen'")

    allowed_by_level: dict[tuple[str, str], set[str]] = {}
    for level in ("packet_level", "target_level"):
        level_data = document.get(level)
        if not isinstance(level_data, dict):
            add_error(errors, filename, None, f"{level} must be an object")
            continue
        for axis in ("theorem_class", "coverage_class", "novelty_class"):
            axis_data = level_data.get(axis)
            values = axis_data.get("allowed") if isinstance(axis_data, dict) else None
            if not isinstance(values, list) or not values:
                add_error(errors, filename, None, f"{level}.{axis}.allowed must be a nonempty list")
                continue
            if not all(isinstance(value, str) and value for value in values):
                add_error(
                    errors,
                    filename,
                    None,
                    f"{level}.{axis}.allowed must contain only nonempty strings",
                )
                continue
            if len(values) != len(set(values)):
                add_error(errors, filename, None, f"{level}.{axis}.allowed contains duplicates")
            allowed_by_level[(level, axis)] = set(values)

    binding_data = document.get("registry_binding")
    binding_values = (
        binding_data.get("allowed") if isinstance(binding_data, dict) else None
    )
    if not isinstance(binding_values, list) or not binding_values:
        add_error(errors, filename, None, "registry_binding.allowed must be a nonempty list")
        binding_allowed: set[str] = set()
    elif not all(isinstance(value, str) and value for value in binding_values):
        add_error(
            errors,
            filename,
            None,
            "registry_binding.allowed must contain only nonempty strings",
        )
        binding_allowed = set()
    else:
        binding_allowed = set(binding_values)
        if len(binding_values) != len(binding_allowed):
            add_error(errors, filename, None, "registry_binding.allowed contains duplicates")

    examples: dict[str, dict[str, str]] = {}
    registry_examples: dict[str, dict[str, str]] = {}
    raw_examples = document.get("required_packet_examples")
    if not isinstance(raw_examples, list):
        add_error(errors, filename, None, "required_packet_examples must be a list")
        raw_examples = []
    for index, example in enumerate(raw_examples):
        label = f"required_packet_examples[{index}]"
        if not isinstance(example, dict):
            add_error(errors, filename, None, f"{label} must be an object")
            continue
        required_fields = (
            "id",
            "theorem_class",
            "coverage_class",
            "novelty_class",
            "registry_binding",
        )
        if not all(isinstance(example.get(field), str) and example[field] for field in required_fields):
            add_error(errors, filename, None, f"{label} must define nonempty {required_fields!r}")
            continue
        example_id = example["id"]
        if example_id in examples:
            add_error(errors, filename, None, f"duplicate required packet example id {example_id!r}")
            continue
        examples[example_id] = {field: example[field] for field in required_fields}
        if example["registry_binding"] not in binding_allowed:
            add_error(
                errors,
                filename,
                None,
                f"{label}.registry_binding={example['registry_binding']!r} is not allowed",
            )
        elif example["registry_binding"] == "required":
            registry_examples[example_id] = examples[example_id]
        for axis in ("theorem_class", "coverage_class", "novelty_class"):
            allowed = allowed_by_level.get(("packet_level", axis), set())
            if example[axis] not in allowed:
                add_error(
                    errors,
                    filename,
                    None,
                    f"{label}.{axis}={example[axis]!r} is not allowed on the packet {axis} axis",
                )

    card_enums = {
        ("cards.csv", axis): allowed_by_level[("packet_level", axis)]
        for axis in ("theorem_class", "coverage_class", "novelty_class")
        if ("packet_level", axis) in allowed_by_level
    }
    return card_enums, registry_examples


def read_tables(errors: list[str]) -> dict[str, list[dict[str, str]]]:
    tables: dict[str, list[dict[str, str]]] = {}
    for filename, expected_header in HEADERS.items():
        path = INVENTORY / filename
        if not path.is_file():
            add_error(errors, filename, None, "missing required table")
            tables[filename] = []
            continue
        try:
            with path.open("r", encoding="utf-8-sig", newline="") as handle:
                raw_rows = list(csv.reader(handle))
        except (OSError, UnicodeError, csv.Error) as exc:
            add_error(errors, filename, None, f"cannot parse CSV: {exc}")
            tables[filename] = []
            continue
        if not raw_rows:
            add_error(errors, filename, None, "empty file")
            tables[filename] = []
            continue
        if raw_rows[0] != expected_header:
            add_error(
                errors,
                filename,
                1,
                f"header mismatch; expected {expected_header!r}, got {raw_rows[0]!r}",
            )
            tables[filename] = []
            continue
        rows: list[dict[str, str]] = []
        for line, values in enumerate(raw_rows[1:], start=2):
            if len(values) != len(expected_header):
                add_error(
                    errors,
                    filename,
                    line,
                    f"expected {len(expected_header)} columns, got {len(values)}",
                )
                continue
            if not any(values):
                add_error(errors, filename, line, "blank row")
                continue
            row = dict(zip(expected_header, values))
            row["__line__"] = str(line)
            rows.append(row)
        tables[filename] = rows
    return tables


def line_of(row: dict[str, str]) -> int:
    return int(row["__line__"])


def check_rows(
    tables: dict[str, list[dict[str, str]]],
    errors: list[str],
    classification_enums: dict[tuple[str, str], set[str]],
) -> None:
    active_enums = {**ENUMS, **classification_enums}
    for filename, rows in tables.items():
        for row in rows:
            line = line_of(row)
            if row["schema_version"] != SCHEMA_VERSION:
                add_error(
                    errors,
                    filename,
                    line,
                    f"schema_version must be {SCHEMA_VERSION!r}",
                )
            for field in REQUIRED[filename]:
                if not row[field].strip():
                    add_error(errors, filename, line, f"required field {field!r} is blank")
            for (enum_file, field), allowed in active_enums.items():
                if enum_file == filename and row[field] not in allowed:
                    add_error(
                        errors,
                        filename,
                        line,
                        f"invalid {field}={row[field]!r}; expected one of {sorted(allowed)!r}",
                    )

        key_fields = PRIMARY_KEYS[filename]
        seen: dict[tuple[str, ...], int] = {}
        for row in rows:
            key = tuple(row[field] for field in key_fields)
            if key in seen:
                add_error(
                    errors,
                    filename,
                    line_of(row),
                    f"duplicate key {key!r}; first seen on line {seen[key]}",
                )
            else:
                seen[key] = line_of(row)


def index_by(
    tables: dict[str, list[dict[str, str]]], filename: str, field: str
) -> dict[str, dict[str, str]]:
    return {row[field]: row for row in tables[filename] if row[field]}


def check_foreign_keys(
    tables: dict[str, list[dict[str, str]]], errors: list[str]
) -> None:
    editions = index_by(tables, "editions.csv", "edition_id")
    snapshots = index_by(tables, "source_snapshots.csv", "source_snapshot_id")
    occurrences = index_by(tables, "occurrences.csv", "occurrence_id")
    notations = index_by(tables, "notation.csv", "notation_id")
    entities = index_by(tables, "entities.csv", "entity_id")
    cards = index_by(tables, "cards.csv", "card_id")
    manifests = index_by(tables, "manifests.csv", "manifest_id")

    checks = [
        ("edition_relations.csv", "from_edition_id", editions),
        ("edition_relations.csv", "to_edition_id", editions),
        ("source_snapshots.csv", "edition_id", editions),
        ("page_audits.csv", "source_snapshot_id", snapshots),
        ("occurrences.csv", "edition_id", editions),
        ("occurrences.csv", "source_snapshot_id", snapshots),
        ("notation.csv", "source_snapshot_id", snapshots),
        ("notation.csv", "entity_id", entities),
        ("entity_evidence.csv", "entity_id", entities),
        ("entity_evidence.csv", "edition_id", editions),
        ("entity_evidence.csv", "source_snapshot_id", snapshots),
        ("cards.csv", "manifest_id", manifests),
        ("occurrence_notations.csv", "occurrence_id", occurrences),
        ("occurrence_notations.csv", "notation_id", notations),
        ("occurrence_entities.csv", "occurrence_id", occurrences),
        ("occurrence_entities.csv", "entity_id", entities),
        ("occurrence_cards.csv", "occurrence_id", occurrences),
        ("occurrence_cards.csv", "card_id", cards),
        ("occurrence_manifests.csv", "occurrence_id", occurrences),
        ("occurrence_manifests.csv", "manifest_id", manifests),
    ]
    for filename, field, target in checks:
        for row in tables[filename]:
            value = row[field]
            if value and value not in target:
                add_error(
                    errors,
                    filename,
                    line_of(row),
                    f"{field}={value!r} has no association target",
                )

    for row in tables["notation.csv"]:
        entity = entities.get(row["entity_id"])
        if entity and entity["identity_status"] == "excluded":
            add_error(
                errors,
                "notation.csv",
                line_of(row),
                f"notation targets excluded entity {row['entity_id']!r}",
            )


def parse_page_pair(
    row: dict[str, str],
    filename: str,
    start_field: str,
    end_field: str,
    errors: list[str],
) -> None:
    start_text, end_text = row[start_field], row[end_field]
    if bool(start_text) != bool(end_text):
        add_error(
            errors,
            filename,
            line_of(row),
            f"{start_field} and {end_field} must both be filled or both be blank",
        )
        return
    if not start_text:
        return
    try:
        start, end = int(start_text), int(end_text)
    except ValueError:
        add_error(errors, filename, line_of(row), "page range must contain integers")
        return
    if start <= 0 or end <= 0 or start > end:
        add_error(
            errors,
            filename,
            line_of(row),
            f"invalid page range {start}-{end}",
        )


def editions_are_fully_equivalent(
    left: str,
    right: str,
    relations: list[dict[str, str]],
) -> bool:
    if left == right:
        return True
    for relation in relations:
        endpoints = {relation["from_edition_id"], relation["to_edition_id"]}
        if endpoints != {left, right}:
            continue
        if (
            relation["content_equivalence_status"] == "matched"
            and relation["page_locator_equivalence_status"] == "matched"
            and relation["join_semantics"] == "equivalent"
        ):
            return True
    return False


def is_lowercase_sha256(value: str) -> bool:
    return len(value) == 64 and all(character in "0123456789abcdef" for character in value)


def source_snapshot_is_ready(snapshot: dict[str, str] | None) -> bool:
    return bool(
        snapshot
        and snapshot["snapshot_kind"] != "locked_copy_placeholder"
        and snapshot["availability_status"] == "available"
        and snapshot["digest_status"] == "verified"
        and snapshot["digest_algorithm"] == "sha256"
        and is_lowercase_sha256(snapshot["digest_value"])
        and snapshot["edition_reconciliation_status"] == "matched"
        and snapshot["page_mapping_status"] == "matched"
    )


def page_audit_is_complete_and_independent(audit: dict[str, str]) -> bool:
    return bool(
        audit["audit_status"] == "complete"
        and audit["audited_by"]
        and audit["audit_date"]
        and audit["reviewed_by"]
        and audit["review_date"]
        and audit["reviewed_by"] != audit["audited_by"]
    )


def page_audit_covers_printed_range(
    audit: dict[str, str], start_text: str, end_text: str
) -> bool:
    if not (start_text and end_text):
        return True
    if not (audit["printed_page_start"] and audit["printed_page_end"]):
        return False
    try:
        start = int(start_text)
        end = int(end_text)
        audit_start = int(audit["printed_page_start"])
        audit_end = int(audit["printed_page_end"])
    except ValueError:
        return False
    return audit_start <= start and end <= audit_end


def occurrence_is_source_ready(
    occurrence: dict[str, str] | None,
    snapshots: dict[str, dict[str, str]],
) -> bool:
    return bool(
        occurrence
        and occurrence["resolution_status"] == "resolved"
        and occurrence["transcription_status"] == "verified"
        and occurrence["reconciliation_status"] == "matched"
        and source_snapshot_is_ready(snapshots.get(occurrence["source_snapshot_id"]))
    )


def source_provenance_is_compatible(
    left_snapshot_id: str,
    right_snapshot_id: str,
    snapshots: dict[str, dict[str, str]],
    relations: list[dict[str, str]],
) -> bool:
    """Permit an exact-snapshot join or a fully reconciled equivalent-edition join."""

    left = snapshots.get(left_snapshot_id)
    right = snapshots.get(right_snapshot_id)
    if not source_snapshot_is_ready(left) or not source_snapshot_is_ready(right):
        return False
    if left_snapshot_id == right_snapshot_id:
        return True
    if left["edition_id"] == right["edition_id"]:
        # No reviewed snapshot-equivalence relation exists in inventory-v1.0.0.
        return False
    return (
        left["edition_reconciliation_status"] == "matched"
        and right["edition_reconciliation_status"] == "matched"
        and editions_are_fully_equivalent(
            left["edition_id"],
            right["edition_id"],
            relations,
        )
    )


def check_semantics(
    tables: dict[str, list[dict[str, str]]], errors: list[str]
) -> None:
    editions = index_by(tables, "editions.csv", "edition_id")
    snapshots = index_by(tables, "source_snapshots.csv", "source_snapshot_id")
    edition_relations = tables["edition_relations.csv"]
    complete_audits_by_snapshot: defaultdict[str, list[dict[str, str]]] = defaultdict(
        list
    )
    for audit in tables["page_audits.csv"]:
        if page_audit_is_complete_and_independent(audit):
            complete_audits_by_snapshot[audit["source_snapshot_id"]].append(audit)

    relation_pairs: dict[tuple[str, str], int] = {}
    for row in tables["edition_relations.csv"]:
        if row["from_edition_id"] == row["to_edition_id"]:
            add_error(
                errors,
                "edition_relations.csv",
                line_of(row),
                "edition relation must connect distinct edition IDs",
            )
        endpoint_pair = tuple(sorted((row["from_edition_id"], row["to_edition_id"])))
        if endpoint_pair in relation_pairs:
            add_error(
                errors,
                "edition_relations.csv",
                line_of(row),
                f"duplicate unordered edition endpoint pair {endpoint_pair!r}; "
                f"first relation is on line {relation_pairs[endpoint_pair]}",
            )
        else:
            relation_pairs[endpoint_pair] = line_of(row)
        fully_matched = (
            row["content_equivalence_status"] == "matched"
            and row["page_locator_equivalence_status"] == "matched"
        )
        required_join = "equivalent" if fully_matched else "non_equivalent"
        if row["join_semantics"] != required_join:
            add_error(
                errors,
                "edition_relations.csv",
                line_of(row),
                f"join_semantics must be {required_join!r} for the recorded "
                "content/page equivalence statuses",
            )

    reserved_snapshot = snapshots.get(RESERVED_PENDING_SNAPSHOT_ID)
    if not reserved_snapshot:
        add_error(
            errors,
            "source_snapshots.csv",
            None,
            f"missing reserved planning placeholder {RESERVED_PENDING_SNAPSHOT_ID!r}",
        )
    else:
        for field, expected in RESERVED_PENDING_SNAPSHOT_FIELDS.items():
            if reserved_snapshot[field] != expected:
                add_error(
                    errors,
                    "source_snapshots.csv",
                    line_of(reserved_snapshot),
                    f"reserved placeholder {RESERVED_PENDING_SNAPSHOT_ID!r} requires "
                    f"{field}={expected!r}; acquisition must use a new snapshot ID",
                )

    for row in tables["source_snapshots.csv"]:
        digest_fields = (row["digest_algorithm"], row["digest_value"])
        if row["digest_status"] == "verified" and not all(digest_fields):
            add_error(
                errors,
                "source_snapshots.csv",
                line_of(row),
                "verified digest requires digest_algorithm and digest_value",
            )
        if row["digest_status"] == "verified" and row["digest_algorithm"] != "sha256":
            add_error(
                errors,
                "source_snapshots.csv",
                line_of(row),
                "verified source digest requires digest_algorithm='sha256'",
            )
        if row["digest_status"] == "verified" and not is_lowercase_sha256(
            row["digest_value"]
        ):
            add_error(
                errors,
                "source_snapshots.csv",
                line_of(row),
                "verified source digest must be exactly 64 lowercase hexadecimal digits",
            )
        if row["digest_status"] == "unresolved" and any(digest_fields):
            add_error(
                errors,
                "source_snapshots.csv",
                line_of(row),
                "unresolved digest must not carry an algorithm or value",
            )

    for row in tables["entity_evidence.csv"]:
        snapshot = snapshots.get(row["source_snapshot_id"])
        if snapshot and row["edition_id"] != snapshot["edition_id"]:
            add_error(
                errors,
                "entity_evidence.csv",
                line_of(row),
                "entity evidence edition_id must equal its source snapshot edition_id",
            )
        if (
            row["evidence_status"] == "confirmed"
            and snapshot
            and not source_snapshot_is_ready(snapshot)
        ):
            add_error(
                errors,
                "entity_evidence.csv",
                line_of(row),
                "confirmed entity evidence requires an available non-placeholder snapshot "
                "with a valid verified digest and matched edition/page reconciliation",
            )
        if (
            row["evidence_status"] == "confirmed"
            and source_snapshot_is_ready(snapshot)
            and not complete_audits_by_snapshot[row["source_snapshot_id"]]
        ):
            add_error(
                errors,
                "entity_evidence.csv",
                line_of(row),
                "confirmed entity evidence requires a complete independently reviewed "
                "page audit for its exact source snapshot",
            )

    for row in tables["page_audits.csv"]:
        parse_page_pair(
            row,
            "page_audits.csv",
            "snapshot_page_start",
            "snapshot_page_end",
            errors,
        )
        parse_page_pair(
            row,
            "page_audits.csv",
            "printed_page_start",
            "printed_page_end",
            errors,
        )
        if row["audit_status"] == "complete" and not (
            row["reviewed_by"] and row["review_date"]
        ):
            add_error(
                errors,
                "page_audits.csv",
                line_of(row),
                "complete page audit requires reviewed_by and review_date",
            )
        if (
            row["audit_status"] == "complete"
            and row["reviewed_by"]
            and row["reviewed_by"] == row["audited_by"]
        ):
            add_error(
                errors,
                "page_audits.csv",
                line_of(row),
                "complete page audit requires reviewed_by distinct from audited_by",
            )

    occurrence_notations: defaultdict[str, list[dict[str, str]]] = defaultdict(list)
    occurrence_entities: defaultdict[str, list[dict[str, str]]] = defaultdict(list)
    for link in tables["occurrence_notations.csv"]:
        occurrence_notations[link["occurrence_id"]].append(link)
    for link in tables["occurrence_entities.csv"]:
        occurrence_entities[link["occurrence_id"]].append(link)

    for row in tables["occurrences.csv"]:
        snapshot = snapshots.get(row["source_snapshot_id"])
        if snapshot and row["edition_id"] != snapshot["edition_id"]:
            add_error(
                errors,
                "occurrences.csv",
                line_of(row),
                "occurrence edition_id must equal its source snapshot edition_id; "
                "cross-edition correspondence belongs in edition_relations.csv",
            )
        if row["edition_id"] == "olver_crc_2010_preview" and not row[
            "occurrence_id"
        ].startswith("OLV10P-"):
            add_error(
                errors,
                "occurrences.csv",
                line_of(row),
                "2010-preview occurrence IDs must use the OLV10P- prefix",
            )
        if row["edition_id"] == "olver_1997b" and row["occurrence_id"].startswith(
            "OLV10P-"
        ):
            add_error(
                errors,
                "occurrences.csv",
                line_of(row),
                "locked-1997 occurrence cannot use a preview occurrence ID",
            )
        parse_page_pair(
            row,
            "occurrences.csv",
            "printed_page_start",
            "printed_page_end",
            errors,
        )
        if row["evidence_type"] in {"toc_only", "index_only"}:
            if row["resolution_status"] != "occurrence_unresolved":
                add_error(
                    errors,
                    "occurrences.csv",
                    line_of(row),
                    "contents/index-only evidence must remain occurrence_unresolved",
                )
            if row["transcription_status"] != "locator_only":
                add_error(
                    errors,
                    "occurrences.csv",
                    line_of(row),
                    "contents/index-only evidence must use locator_only transcription status",
                )
        hash_fields = (
            row["transcription_hash_algorithm"],
            row["transcription_hash"],
        )
        if bool(hash_fields[0]) != bool(hash_fields[1]):
            add_error(
                errors,
                "occurrences.csv",
                line_of(row),
                "transcription hash algorithm and value must be supplied together",
            )
        if row["transcription_status"] == "verified" and not (
            all(hash_fields) and row["transcribed_by"] and row["transcription_date"]
        ):
            add_error(
                errors,
                "occurrences.csv",
                line_of(row),
                "verified transcription requires hash, collator, and date",
            )
        if (
            row["transcription_status"] == "verified"
            and row["transcription_hash_algorithm"] != "sha256"
        ):
            add_error(
                errors,
                "occurrences.csv",
                line_of(row),
                "verified transcription requires transcription_hash_algorithm='sha256'",
            )
        if row["transcription_status"] == "verified" and not is_lowercase_sha256(
            row["transcription_hash"]
        ):
            add_error(
                errors,
                "occurrences.csv",
                line_of(row),
                "verified transcription hash must be exactly 64 lowercase hexadecimal digits",
            )
        if row["resolution_status"] == "resolved":
            if row["transcription_status"] != "verified":
                add_error(
                    errors,
                    "occurrences.csv",
                    line_of(row),
                    "resolved occurrence requires verified transcription",
                )
            if row["reconciliation_status"] != "matched":
                add_error(
                    errors,
                    "occurrences.csv",
                    line_of(row),
                    "resolved occurrence requires matched reconciliation",
                )
            if not source_snapshot_is_ready(snapshot):
                add_error(
                    errors,
                    "occurrences.csv",
                    line_of(row),
                    "resolved occurrence requires an available non-placeholder source snapshot "
                    "with a valid verified digest and matched edition/page reconciliation",
                )
            complete_audits = complete_audits_by_snapshot[row["source_snapshot_id"]]
            if not complete_audits:
                add_error(
                    errors,
                    "occurrences.csv",
                    line_of(row),
                    "resolved occurrence requires a complete independently reviewed page "
                    "audit for its exact source snapshot",
                )
            elif row["printed_page_start"] and row["printed_page_end"] and not any(
                page_audit_covers_printed_range(
                    audit,
                    row["printed_page_start"],
                    row["printed_page_end"],
                )
                for audit in complete_audits
            ):
                add_error(
                    errors,
                    "occurrences.csv",
                    line_of(row),
                    f"resolved occurrence printed range {row['printed_page_start']}-"
                    f"{row['printed_page_end']} is not covered by a complete independently "
                    "reviewed page audit for its exact source snapshot",
                )
            if (
                row["target_class"] != "project_extra"
                and row["evidence_type"] not in DIRECT_SOURCE_EVIDENCE_TYPES
            ):
                add_error(
                    errors,
                    "occurrences.csv",
                    line_of(row),
                    "resolved source occurrence requires evidence_type direct_formula or direct_prose",
                )
            if row["target_class"] in {"source_definition", "source_theorem"}:
                confirmed_notations = any(
                    link["link_status"] == "confirmed"
                    for link in occurrence_notations[row["occurrence_id"]]
                )
                confirmed_entities = any(
                    link["link_status"] == "confirmed"
                    for link in occurrence_entities[row["occurrence_id"]]
                )
                if not (confirmed_notations and confirmed_entities):
                    add_error(
                        errors,
                        "occurrences.csv",
                        line_of(row),
                        "resolved source definition or theorem requires confirmed notation and entity links",
                    )

    for row in tables["notation.csv"]:
        snapshot = snapshots.get(row["source_snapshot_id"])
        if (
            snapshot
            and snapshot["edition_id"] == "olver_crc_2010_preview"
            and not row["notation_id"].startswith("OLV10P-")
        ):
            add_error(
                errors,
                "notation.csv",
                line_of(row),
                "2010-preview notation IDs must use the OLV10P- prefix",
            )
        if row["resolution_status"] == "resolved":
            if row["transcription_status"] != "verified":
                add_error(
                    errors,
                    "notation.csv",
                    line_of(row),
                    "resolved notation requires verified transcription",
                )
            if not source_snapshot_is_ready(snapshot):
                add_error(
                    errors,
                    "notation.csv",
                    line_of(row),
                    "resolved notation requires an available non-placeholder source snapshot "
                    "with a valid verified digest and matched edition/page reconciliation",
                )

    occurrences = index_by(tables, "occurrences.csv", "occurrence_id")
    notations = index_by(tables, "notation.csv", "notation_id")
    for link in tables["occurrence_notations.csv"]:
        if link["link_status"] != "confirmed":
            continue
        occurrence = occurrences.get(link["occurrence_id"])
        notation = notations.get(link["notation_id"])
        if occurrence and not occurrence_is_source_ready(occurrence, snapshots):
            add_error(
                errors,
                "occurrence_notations.csv",
                line_of(link),
                "confirmed occurrence-notation association requires a resolved verified "
                "occurrence on a ready source snapshot",
            )
        if notation and not (
            notation["resolution_status"] == "resolved"
            and notation["transcription_status"] == "verified"
            and source_snapshot_is_ready(snapshots.get(notation["source_snapshot_id"]))
        ):
            add_error(
                errors,
                "occurrence_notations.csv",
                line_of(link),
                "confirmed occurrence-notation association requires a resolved verified "
                "notation on a ready source snapshot",
            )
        if occurrence and notation and not source_provenance_is_compatible(
            occurrence["source_snapshot_id"],
            notation["source_snapshot_id"],
            snapshots,
            edition_relations,
        ):
            add_error(
                errors,
                "occurrence_notations.csv",
                line_of(link),
                "confirmed occurrence-notation association lacks ready matching source "
                "provenance or a fully matched equivalent-edition relation",
            )

    evidence_by_entity: defaultdict[str, list[dict[str, str]]] = defaultdict(list)
    for evidence in tables["entity_evidence.csv"]:
        evidence_by_entity[evidence["entity_id"]].append(evidence)
    for link in tables["occurrence_entities.csv"]:
        if link["link_status"] != "confirmed":
            continue
        occurrence = occurrences.get(link["occurrence_id"])
        compatible_evidence = False
        if occurrence and not occurrence_is_source_ready(occurrence, snapshots):
            add_error(
                errors,
                "occurrence_entities.csv",
                line_of(link),
                "confirmed occurrence-entity association requires a resolved verified "
                "occurrence on a ready source snapshot",
            )
        if occurrence:
            compatible_evidence = any(
                evidence["evidence_status"] == "confirmed"
                and source_provenance_is_compatible(
                    occurrence["source_snapshot_id"],
                    evidence["source_snapshot_id"],
                    snapshots,
                    edition_relations,
                )
                for evidence in evidence_by_entity[link["entity_id"]]
            )
        if occurrence and not compatible_evidence:
            add_error(
                errors,
                "occurrence_entities.csv",
                line_of(link),
                "confirmed occurrence-entity association has no confirmed entity evidence "
                "with matching provenance or a fully matched equivalent-edition relation",
            )

    links_by_entity: defaultdict[str, list[dict[str, str]]] = defaultdict(list)
    for link in tables["occurrence_entities.csv"]:
        links_by_entity[link["entity_id"]].append(link)
    for entity in tables["entities.csv"]:
        if entity["identity_status"] != "confirmed":
            continue
        qualifying = False
        for link in links_by_entity[entity["entity_id"]]:
            occurrence = occurrences.get(link["occurrence_id"])
            if not occurrence:
                continue
            edition = editions.get(occurrence["edition_id"])
            snapshot = snapshots.get(occurrence["source_snapshot_id"])
            if (
                link["link_status"] == "confirmed"
                and edition
                and edition["target_status"] == "locked_target"
                and occurrence["resolution_status"] == "resolved"
                and occurrence["reconciliation_status"] == "matched"
                and snapshot
                and snapshot["edition_id"] == occurrence["edition_id"]
                and snapshot["edition_reconciliation_status"] == "matched"
            ):
                qualifying = True
                break
        if not qualifying:
            add_error(
                errors,
                "entities.csv",
                line_of(entity),
                "confirmed entity requires a confirmed link to a resolved, "
                "reconciled occurrence in a locked-target edition",
            )

    for row in tables["cards.csv"]:
        if row["artifact_status"] == "file_present":
            expected_path = f"blueprint/theorem_cards/{row['card_id']}.yaml"
            if not row["target_path"]:
                add_error(
                    errors,
                    "cards.csv",
                    line_of(row),
                    "file_present card requires target_path",
                )
            elif row["target_path"] != expected_path:
                add_error(
                    errors,
                    "cards.csv",
                    line_of(row),
                    f"file_present card target_path must be canonical path {expected_path!r}",
                )
            elif not (ROOT / row["target_path"]).is_file():
                add_error(
                    errors,
                    "cards.csv",
                    line_of(row),
                    f"target_path does not exist: {row['target_path']!r}",
                )
        elif row["target_path"]:
            add_error(
                errors,
                "cards.csv",
                line_of(row),
                "planned artifact must not claim a target_path",
            )

    manifests = index_by(tables, "manifests.csv", "manifest_id")
    for row in tables["cards.csv"]:
        manifest = manifests.get(row["manifest_id"])
        if manifest and row["registration_status"] != manifest["manifest_status"]:
            add_error(
                errors,
                "cards.csv",
                line_of(row),
                "registration_status must match the current manifest_status",
            )

    cards = index_by(tables, "cards.csv", "card_id")
    required_card_roles = {
        "exact_source_generic": "exact_source_target",
        "named_source_application": "named_application",
        "audit_source_recovery": "source_recovery",
    }
    for row in tables["occurrence_cards.csv"]:
        card = cards.get(row["card_id"])
        if not card:
            continue
        required_role = required_card_roles.get(card["coverage_class"])
        if required_role and row["card_role"] != required_role:
            add_error(
                errors,
                "occurrence_cards.csv",
                line_of(row),
                f"card_role must be {required_role!r} for coverage_class "
                f"{card['coverage_class']!r}",
            )

    ready_states = {"execution_ready", "active", "complete"}
    for card in tables["cards.csv"]:
        if (
            card["registration_status"] in ready_states
            and card["artifact_status"] != "file_present"
        ):
            add_error(
                errors,
                "cards.csv",
                line_of(card),
                "ready, active, or complete card registration requires artifact_status="
                "'file_present' at its canonical card path",
            )
    source_card_coverages = {
        "exact_source_generic",
        "named_source_application",
        "audit_source_recovery",
    }
    links_by_card: defaultdict[str, list[dict[str, str]]] = defaultdict(list)
    for link in tables["occurrence_cards.csv"]:
        links_by_card[link["card_id"]].append(link)
    for card in tables["cards.csv"]:
        if (
            card["registration_status"] not in ready_states
            or card["coverage_class"] not in source_card_coverages
        ):
            continue
        source_links = links_by_card[card["card_id"]]
        if not source_links:
            add_error(
                errors,
                "cards.csv",
                line_of(card),
                "ready source-dependent card requires at least one occurrence association",
            )
        for link in source_links:
            occurrence = occurrences.get(link["occurrence_id"])
            if occurrence and not occurrence_is_source_ready(occurrence, snapshots):
                add_error(
                    errors,
                    "cards.csv",
                    line_of(card),
                    f"ready source-dependent card {card['card_id']!r} depends on "
                    f"unresolved or unverified occurrence {link['occurrence_id']!r}",
                )

    manifest_occurrence_links: defaultdict[str, list[dict[str, str]]] = defaultdict(list)
    for link in tables["occurrence_manifests.csv"]:
        if link["coverage_role"] == "source_coverage":
            manifest_occurrence_links[link["manifest_id"]].append(link)
    cards_by_manifest: defaultdict[str, list[dict[str, str]]] = defaultdict(list)
    for card in tables["cards.csv"]:
        cards_by_manifest[card["manifest_id"]].append(card)
    for row in tables["manifests.csv"]:
        scope_closed = row["scope_closed"] == "true"
        if row["manifest_status"] == "execution_ready" and not scope_closed:
            add_error(
                errors,
                "manifests.csv",
                line_of(row),
                "execution_ready manifest must have scope_closed=true",
            )
        if not scope_closed and row["manifest_status"] != "planning_only":
            add_error(
                errors,
                "manifests.csv",
                line_of(row),
                "open manifest scope must remain planning_only",
            )
        try:
            source_total = int(row["declared_source_occurrence_total"])
        except ValueError:
            source_total = -1
        if source_total == 0 and row["occurrence_selection_locked"] != "not_applicable":
            add_error(
                errors,
                "manifests.csv",
                line_of(row),
                "zero-source manifest must use occurrence_selection_locked=not_applicable",
            )
        if source_total > 0 and row["occurrence_selection_locked"] == "not_applicable":
            add_error(
                errors,
                "manifests.csv",
                line_of(row),
                "source manifest must state whether occurrence selection is locked",
            )
        if scope_closed or row["manifest_status"] in ready_states:
            if not cards_by_manifest[row["manifest_id"]]:
                add_error(
                    errors,
                    "manifests.csv",
                    line_of(row),
                    "closed or ready manifest requires at least one registered member card",
                )
            for card in cards_by_manifest[row["manifest_id"]]:
                expected_path = f"blueprint/theorem_cards/{card['card_id']}.yaml"
                if (
                    card["artifact_status"] != "file_present"
                    or card["target_path"] != expected_path
                    or not (ROOT / expected_path).is_file()
                ):
                    add_error(
                        errors,
                        "manifests.csv",
                        line_of(row),
                        f"closed or ready manifest member {card['card_id']!r} requires a "
                        "file-present canonical card artifact",
                    )
            for link in manifest_occurrence_links[row["manifest_id"]]:
                occurrence = occurrences.get(link["occurrence_id"])
                if occurrence and not occurrence_is_source_ready(occurrence, snapshots):
                    add_error(
                        errors,
                        "manifests.csv",
                        line_of(row),
                        f"closed or ready manifest {row['manifest_id']!r} depends on "
                        f"unresolved or unverified occurrence {link['occurrence_id']!r}",
                    )

    for row in tables["occurrence_manifests.csv"]:
        occurrence = occurrences.get(row["occurrence_id"])
        if row["coverage_role"] == "source_coverage" and occurrence:
            if occurrence["queue_class"] == "project_extra" or occurrence["edition_id"] == "project":
                add_error(
                    errors,
                    "occurrence_manifests.csv",
                    line_of(row),
                    "project extra cannot count as source coverage",
                )

def check_manifest_totals(
    tables: dict[str, list[dict[str, str]]], errors: list[str]
) -> dict[str, int]:
    counted: defaultdict[str, set[str]] = defaultdict(set)
    for row in tables["occurrence_manifests.csv"]:
        if row["coverage_role"] == "source_coverage":
            counted[row["manifest_id"]].add(row["occurrence_id"])

    result: dict[str, int] = {}
    for manifest in tables["manifests.csv"]:
        manifest_id = manifest["manifest_id"]
        try:
            declared = int(manifest["declared_source_occurrence_total"])
        except ValueError:
            add_error(
                errors,
                "manifests.csv",
                line_of(manifest),
                "declared_source_occurrence_total must be a nonnegative integer",
            )
            continue
        if declared < 0:
            add_error(
                errors,
                "manifests.csv",
                line_of(manifest),
                "declared_source_occurrence_total must be nonnegative",
            )
            continue
        actual = len(counted[manifest_id])
        result[manifest_id] = actual
        if actual != declared:
            add_error(
                errors,
                "manifests.csv",
                line_of(manifest),
                f"declares {declared} source occurrences but associations count {actual}",
            )
    return result


def check_classification_examples(
    tables: dict[str, list[dict[str, str]]],
    examples: dict[str, dict[str, str]],
    errors: list[str],
) -> None:
    """Bind registry rows to every authority example marked registry_binding=required."""

    filename = str(CLASSIFICATION_AUTHORITY.relative_to(ROOT))
    cards = index_by(tables, "cards.csv", "card_id")
    if not examples:
        add_error(errors, filename, None, "no required registry-bound packet examples")
    for card_id, example in sorted(examples.items()):
        card = cards.get(card_id)
        if not card:
            add_error(
                errors,
                "cards.csv",
                None,
                f"missing registry row for required classification example {card_id!r}",
            )
            continue
        for axis in ("theorem_class", "coverage_class", "novelty_class"):
            if card[axis] != example[axis]:
                add_error(
                    errors,
                    "cards.csv",
                    line_of(card),
                    f"{card_id} {axis}={card[axis]!r} does not match the frozen "
                    f"classification example {example[axis]!r}",
                )


def validate_tables(
    tables: dict[str, list[dict[str, str]]],
    classification_enums: dict[tuple[str, str], set[str]],
    classification_examples: dict[str, dict[str, str]],
) -> tuple[list[str], dict[str, int]]:
    errors: list[str] = []
    check_rows(tables, errors, classification_enums)
    check_foreign_keys(tables, errors)
    check_semantics(tables, errors)
    check_classification_examples(tables, classification_examples, errors)
    totals = check_manifest_totals(tables, errors)
    return errors, totals


def run_negative_invariant_tests(
    tables: dict[str, list[dict[str, str]]],
    classification_enums: dict[tuple[str, str], set[str]],
    classification_examples: dict[str, dict[str, str]],
) -> tuple[list[str], int]:
    """Prove that high-risk provenance mutations are rejected in copied data."""

    def mutate_edition_mismatch(copy: dict[str, list[dict[str, str]]]) -> None:
        row = next(
            item
            for item in copy["occurrences.csv"]
            if item["occurrence_id"] == "OLV10P-O0001"
        )
        row["edition_id"] = "olver_1997b"

    def mutate_preview_confirmation(copy: dict[str, list[dict[str, str]]]) -> None:
        row = next(
            item for item in copy["entities.csv"] if item["entity_id"] == "gamma"
        )
        row["identity_status"] = "confirmed"

    def mutate_relation_join(copy: dict[str, list[dict[str, str]]]) -> None:
        copy["edition_relations.csv"][0]["join_semantics"] = "equivalent"

    def mutate_preview_prefix(copy: dict[str, list[dict[str, str]]]) -> None:
        row = next(
            item
            for item in copy["occurrences.csv"]
            if item["occurrence_id"] == "OLV10P-O0001"
        )
        row["occurrence_id"] = "OLV97-O0001"

    def mutate_manifest_total(copy: dict[str, list[dict[str, str]]]) -> None:
        row = next(
            item
            for item in copy["manifests.csv"]
            if item["manifest_id"] == "OLV-MVP-1"
        )
        row["declared_source_occurrence_total"] = "2"

    def mutate_watson_preview_notation(
        copy: dict[str, list[dict[str, str]]]
    ) -> None:
        copy["occurrence_notations.csv"].append(
            {
                "schema_version": SCHEMA_VERSION,
                "occurrence_id": "OLV97-C03-WATSON",
                "notation_id": "OLV10P-N0001",
                "notation_role": "used_notation",
                "link_status": "confirmed",
                "notes": "Intentional invalid cross-edition negative fixture.",
                "__line__": "999",
            }
        )

    def mutate_watson_preview_entity(
        copy: dict[str, list[dict[str, str]]]
    ) -> None:
        copy["occurrence_entities.csv"].append(
            {
                "schema_version": SCHEMA_VERSION,
                "occurrence_id": "OLV97-C03-WATSON",
                "entity_id": "gamma",
                "entity_role": "uses",
                "link_status": "confirmed",
                "notes": "Intentional invalid cross-edition negative fixture.",
                "__line__": "999",
            }
        )

    def mutate_invalid_source_hash(copy: dict[str, list[dict[str, str]]]) -> None:
        snapshot = next(
            row
            for row in copy["source_snapshots.csv"]
            if row["source_snapshot_id"] == "SRC-OLV-2010-PREVIEW"
        )
        snapshot["digest_status"] = "verified"
        snapshot["digest_algorithm"] = "md5"
        snapshot["digest_value"] = "A" * 64

    def mutate_invalid_transcription_hash(
        copy: dict[str, list[dict[str, str]]]
    ) -> None:
        occurrence = next(
            row
            for row in copy["occurrences.csv"]
            if row["occurrence_id"] == "OLV97-C03-WATSON"
        )
        occurrence["transcription_status"] = "verified"
        occurrence["transcription_hash_algorithm"] = "md5"
        occurrence["transcription_hash"] = "A" * 64
        occurrence["transcribed_by"] = "negative-fixture"
        occurrence["transcription_date"] = "2026-09-05"

    def mutate_resolved_watson_on_placeholder(
        copy: dict[str, list[dict[str, str]]]
    ) -> None:
        occurrence = next(
            row
            for row in copy["occurrences.csv"]
            if row["occurrence_id"] == "OLV97-C03-WATSON"
        )
        occurrence["resolution_status"] = "resolved"
        occurrence["transcription_status"] = "verified"
        occurrence["transcription_hash_algorithm"] = "sha256"
        occurrence["transcription_hash"] = "0" * 64
        occurrence["transcribed_by"] = "negative-fixture"
        occurrence["transcription_date"] = "2026-09-05"
        occurrence["reconciliation_status"] = "matched"

    def mutate_same_edition_placeholder_notation(
        copy: dict[str, list[dict[str, str]]]
    ) -> None:
        notation = next(
            row
            for row in copy["notation.csv"]
            if row["notation_id"] == "OLV10P-N0001"
        )
        notation["source_snapshot_id"] = "SRC-OLV-1997-COLLATION-PENDING"
        notation["resolution_status"] = "resolved"
        notation["transcription_status"] = "verified"
        copy["occurrence_notations.csv"].append(
            {
                "schema_version": SCHEMA_VERSION,
                "occurrence_id": "OLV97-C03-WATSON",
                "notation_id": "OLV10P-N0001",
                "notation_role": "used_notation",
                "link_status": "confirmed",
                "notes": "Intentional invalid same-edition placeholder fixture.",
                "__line__": "999",
            }
        )

    def mutate_confirmed_summary_notation(
        copy: dict[str, list[dict[str, str]]]
    ) -> None:
        link = next(
            row
            for row in copy["occurrence_notations.csv"]
            if row["occurrence_id"] == "OLV10P-O0001"
            and row["notation_id"] == "OLV10P-N0001"
        )
        link["link_status"] = "confirmed"

    def mutate_ready_olv_manifest(copy: dict[str, list[dict[str, str]]]) -> None:
        manifest = next(
            row
            for row in copy["manifests.csv"]
            if row["manifest_id"] == "OLV-MVP-1"
        )
        manifest["scope_closed"] = "true"
        manifest["manifest_status"] = "execution_ready"
        for card in copy["cards.csv"]:
            if card["manifest_id"] == "OLV-MVP-1":
                card["registration_status"] = "execution_ready"

    def mutate_ql_novelty(copy: dict[str, list[dict[str, str]]]) -> None:
        card = next(
            row for row in copy["cards.csv"] if row["card_id"] == "QL-001"
        )
        card["novelty_class"] = "non_novel"

    def mutate_distinct_ready_same_edition_snapshots(
        copy: dict[str, list[dict[str, str]]]
    ) -> None:
        first = next(
            row
            for row in copy["source_snapshots.csv"]
            if row["source_snapshot_id"] == "SRC-OLV-1997-COLLATION-PENDING"
        )
        first["snapshot_kind"] = "local_scan"
        first["access_date"] = "2026-09-05"
        first["availability_status"] = "available"
        first["digest_algorithm"] = "sha256"
        first["digest_value"] = "0" * 64
        first["digest_status"] = "verified"
        first["edition_reconciliation_status"] = "matched"
        first["page_mapping_status"] = "matched"
        copy["source_snapshots.csv"].append(
            {
                "schema_version": SCHEMA_VERSION,
                "source_snapshot_id": "SRC-OLV-1997-SECOND-READY",
                "edition_id": "olver_1997b",
                "snapshot_kind": "local_scan",
                "impression_year": "1997",
                "publisher": "A K Peters",
                "identifier": "negative-fixture-second-snapshot",
                "url": "",
                "access_date": "2026-09-05",
                "availability_status": "available",
                "digest_algorithm": "sha256",
                "digest_value": "1" * 64,
                "digest_status": "verified",
                "edition_reconciliation_status": "matched",
                "page_mapping_status": "matched",
                "rights_status": "unknown",
                "notes": "Intentional second ready snapshot for a negative fixture.",
                "__line__": "999",
            }
        )
        notation = next(
            row
            for row in copy["notation.csv"]
            if row["notation_id"] == "OLV10P-N0001"
        )
        notation["source_snapshot_id"] = "SRC-OLV-1997-SECOND-READY"
        copy["occurrence_notations.csv"].append(
            {
                "schema_version": SCHEMA_VERSION,
                "occurrence_id": "OLV97-C03-WATSON",
                "notation_id": "OLV10P-N0001",
                "notation_role": "used_notation",
                "link_status": "confirmed",
                "notes": "Intentional distinct-snapshot same-edition negative fixture.",
                "__line__": "999",
            }
        )

    def mutate_duplicate_edition_relation(
        copy: dict[str, list[dict[str, str]]]
    ) -> None:
        relation = dict(copy["edition_relations.csv"][0])
        relation.update(
            {
                "edition_relation_id": "REL-OLV-1997-TO-2010-CONFLICT",
                "from_edition_id": "olver_1997b",
                "to_edition_id": "olver_crc_2010_preview",
                "content_equivalence_status": "matched",
                "page_locator_equivalence_status": "matched",
                "join_semantics": "equivalent",
                "evidence": "Intentional conflicting relation fixture.",
                "notes": "The second row must not override the unresolved relation.",
                "__line__": "999",
            }
        )
        copy["edition_relations.csv"].append(relation)

    def mutate_reserved_placeholder_to_acquired(
        copy: dict[str, list[dict[str, str]]]
    ) -> None:
        snapshot = next(
            row
            for row in copy["source_snapshots.csv"]
            if row["source_snapshot_id"] == RESERVED_PENDING_SNAPSHOT_ID
        )
        snapshot.update(
            {
                "snapshot_kind": "local_scan",
                "access_date": "2026-09-05",
                "availability_status": "available",
                "digest_algorithm": "sha256",
                "digest_value": "2" * 64,
                "digest_status": "verified",
                "edition_reconciliation_status": "matched",
                "page_mapping_status": "matched",
            }
        )

    def mutate_page_audit_self_review(
        copy: dict[str, list[dict[str, str]]]
    ) -> None:
        audit = copy["page_audits.csv"][0]
        audit["audit_status"] = "complete"
        audit["reviewed_by"] = audit["audited_by"]
        audit["review_date"] = "2026-09-05"

    def mutate_ql_card_to_arbitrary_file(
        copy: dict[str, list[dict[str, str]]]
    ) -> None:
        card = next(
            row for row in copy["cards.csv"] if row["card_id"] == "QL-001"
        )
        card["artifact_status"] = "file_present"
        card["target_path"] = "README.md"

    def mutate_empty_demo_manifest_closed(
        copy: dict[str, list[dict[str, str]]]
    ) -> None:
        manifest = next(
            row
            for row in copy["manifests.csv"]
            if row["manifest_id"] == "DEMO-0"
        )
        manifest["scope_closed"] = "true"
        manifest["manifest_status"] = "complete"

    def mutate_ready_card_without_artifact(
        copy: dict[str, list[dict[str, str]]]
    ) -> None:
        card = next(
            row for row in copy["cards.csv"] if row["card_id"] == "QB-001"
        )
        card["artifact_status"] = "planned"
        card["target_path"] = ""

    def mutate_composed_fake_ready_source(
        copy: dict[str, list[dict[str, str]]], *, add_noncovering_audit: bool
    ) -> None:
        snapshot_id = "SRC-OLV-1997-FAKE-READY"
        copy["source_snapshots.csv"].append(
            {
                "schema_version": SCHEMA_VERSION,
                "source_snapshot_id": snapshot_id,
                "edition_id": "olver_1997b",
                "snapshot_kind": "local_scan",
                "impression_year": "1997",
                "publisher": "A K Peters",
                "identifier": "negative-fixture-unverified-bytes",
                "url": "",
                "access_date": "2026-09-05",
                "availability_status": "available",
                "digest_algorithm": "sha256",
                "digest_value": "3" * 64,
                "digest_status": "verified",
                "edition_reconciliation_status": "matched",
                "page_mapping_status": "matched",
                "rights_status": "unknown",
                "notes": "Syntactically valid fake metadata for a negative fixture.",
                "__line__": "990",
            }
        )
        occurrence = next(
            row
            for row in copy["occurrences.csv"]
            if row["occurrence_id"] == "OLV97-C03-WATSON"
        )
        occurrence.update(
            {
                "source_snapshot_id": snapshot_id,
                "evidence_type": "direct_prose",
                "resolution_status": "resolved",
                "transcription_status": "verified",
                "transcription_hash_algorithm": "sha256",
                "transcription_hash": "4" * 64,
                "transcribed_by": "negative-fixture-collator",
                "transcription_date": "2026-09-05",
                "reconciliation_status": "matched",
            }
        )
        copy["notation.csv"].append(
            {
                "schema_version": SCHEMA_VERSION,
                "notation_id": "OLV97-N-WATSON-FAKE",
                "entity_id": "gamma",
                "source_snapshot_id": snapshot_id,
                "source_locator": "Ch. 3, printed pp. 71-72",
                "printed_symbol": "Gamma",
                "binder_and_argument_order": "z",
                "ambient_type": "complex",
                "parameter_roles": "negative fixture",
                "domain_and_branch": "negative fixture",
                "normalization": "negative fixture",
                "exceptional_values": "negative fixture",
                "derivative_variable": "",
                "evidence_type": "direct_prose",
                "resolution_status": "resolved",
                "transcription_status": "verified",
                "notes": "Syntactically complete same-snapshot negative fixture.",
                "__line__": "991",
            }
        )
        copy["entity_evidence.csv"].append(
            {
                "schema_version": SCHEMA_VERSION,
                "entity_evidence_id": "EE-OLV97-WATSON-FAKE",
                "entity_id": "gamma",
                "edition_id": "olver_1997b",
                "source_snapshot_id": snapshot_id,
                "evidence_role": "body_naming",
                "evidence_status": "confirmed",
                "notes": "Claimed confirmed evidence without an adequate page audit.",
                "__line__": "992",
            }
        )
        copy["occurrence_notations.csv"].append(
            {
                "schema_version": SCHEMA_VERSION,
                "occurrence_id": "OLV97-C03-WATSON",
                "notation_id": "OLV97-N-WATSON-FAKE",
                "notation_role": "used_notation",
                "link_status": "confirmed",
                "notes": "Same-snapshot composed negative fixture.",
                "__line__": "993",
            }
        )
        copy["occurrence_entities.csv"].append(
            {
                "schema_version": SCHEMA_VERSION,
                "occurrence_id": "OLV97-C03-WATSON",
                "entity_id": "gamma",
                "entity_role": "uses",
                "link_status": "confirmed",
                "notes": "Same-snapshot composed negative fixture.",
                "__line__": "994",
            }
        )
        manifest = next(
            row
            for row in copy["manifests.csv"]
            if row["manifest_id"] == "OLV-MVP-1"
        )
        manifest["scope_closed"] = "true"
        manifest["manifest_status"] = "execution_ready"
        for card in copy["cards.csv"]:
            if card["manifest_id"] == "OLV-MVP-1":
                card["registration_status"] = "execution_ready"
        if add_noncovering_audit:
            copy["page_audits.csv"].append(
                {
                    "schema_version": SCHEMA_VERSION,
                    "page_audit_id": "PA-OLV97-FAKE-NONCOVERING",
                    "source_snapshot_id": snapshot_id,
                    "coordinate_system": "printed_page",
                    "snapshot_page_start": "70",
                    "snapshot_page_end": "70",
                    "printed_page_start": "70",
                    "printed_page_end": "70",
                    "audit_scope": "intentional_noncoverage_fixture",
                    "audit_status": "complete",
                    "audited_by": "negative-fixture-auditor",
                    "audit_date": "2026-09-05",
                    "reviewed_by": "negative-fixture-reviewer",
                    "review_date": "2026-09-05",
                    "notes": "Complete but does not cover Watson pages 71-72.",
                    "__line__": "995",
                }
            )

    def mutate_composed_fake_ready_source_without_audit(
        copy: dict[str, list[dict[str, str]]]
    ) -> None:
        mutate_composed_fake_ready_source(copy, add_noncovering_audit=False)

    def mutate_composed_fake_ready_source_with_noncovering_audit(
        copy: dict[str, list[dict[str, str]]]
    ) -> None:
        mutate_composed_fake_ready_source(copy, add_noncovering_audit=True)

    cases = [
        (
            "edition/snapshot mismatch",
            mutate_edition_mismatch,
            "occurrence edition_id must equal its source snapshot edition_id",
        ),
        (
            "preview-only entity confirmation",
            mutate_preview_confirmation,
            "confirmed entity requires a confirmed link",
        ),
        (
            "unresolved relation treated as equivalent",
            mutate_relation_join,
            "join_semantics must be 'non_equivalent'",
        ),
        (
            "preview occurrence with locked-edition prefix",
            mutate_preview_prefix,
            "2010-preview occurrence IDs must use the OLV10P- prefix",
        ),
        (
            "incorrect manifest denominator",
            mutate_manifest_total,
            "declares 2 source occurrences but associations count 1",
        ),
        (
            "Watson linked to 2010-preview notation",
            mutate_watson_preview_notation,
            "confirmed occurrence-notation association lacks ready matching source provenance",
        ),
        (
            "Watson linked to 2010-preview entity",
            mutate_watson_preview_entity,
            "confirmed occurrence-entity association has no confirmed entity evidence",
        ),
        (
            "verified source digest with unsupported algorithm and uppercase hash",
            mutate_invalid_source_hash,
            (
                "verified source digest requires digest_algorithm='sha256'",
                "verified source digest must be exactly 64 lowercase hexadecimal digits",
            ),
        ),
        (
            "verified transcription with unsupported algorithm and uppercase hash",
            mutate_invalid_transcription_hash,
            (
                "verified transcription requires transcription_hash_algorithm='sha256'",
                "verified transcription hash must be exactly 64 lowercase hexadecimal digits",
            ),
        ),
        (
            "resolved Watson occurrence on uninspected placeholder",
            mutate_resolved_watson_on_placeholder,
            (
                "resolved occurrence requires an available non-placeholder source snapshot",
                "resolved source occurrence requires evidence_type direct_formula or direct_prose",
                "resolved source definition or theorem requires confirmed notation and entity links",
            ),
        ),
        (
            "same-edition confirmed notation join through pending placeholder",
            mutate_same_edition_placeholder_notation,
            (
                "resolved notation requires an available non-placeholder source snapshot",
                "confirmed occurrence-notation association requires a resolved verified occurrence",
                "confirmed occurrence-notation association lacks ready matching source provenance",
            ),
        ),
        (
            "confirmed notation link with unresolved summary-only endpoints",
            mutate_confirmed_summary_notation,
            (
                "confirmed occurrence-notation association requires a resolved verified occurrence",
                "confirmed occurrence-notation association requires a resolved verified notation",
            ),
        ),
        (
            "ready closed source manifest with unresolved member and cards",
            mutate_ready_olv_manifest,
            (
                "ready source-dependent card 'OLV-001' depends on unresolved or unverified occurrence",
                "ready source-dependent card 'SR-001' depends on unresolved or unverified occurrence",
                "closed or ready manifest 'OLV-MVP-1' depends on unresolved or unverified occurrence",
            ),
        ),
        (
            "registry novelty differs from required classification example",
            mutate_ql_novelty,
            "QL-001 novelty_class='non_novel' does not match the frozen classification example 'novel'",
        ),
        (
            "distinct ready snapshots of the same edition are not equivalent",
            mutate_distinct_ready_same_edition_snapshots,
            "confirmed occurrence-notation association lacks ready matching source provenance",
        ),
        (
            "conflicting duplicate relation for one unordered edition pair",
            mutate_duplicate_edition_relation,
            "duplicate unordered edition endpoint pair",
        ),
        (
            "reserved planning snapshot promoted in place",
            mutate_reserved_placeholder_to_acquired,
            (
                f"reserved placeholder {RESERVED_PENDING_SNAPSHOT_ID!r} requires "
                "snapshot_kind='locked_copy_placeholder'",
                "acquisition must use a new snapshot ID",
            ),
        ),
        (
            "completed page audit reviewed by its auditor",
            mutate_page_audit_self_review,
            "complete page audit requires reviewed_by distinct from audited_by",
        ),
        (
            "file-present card points to an arbitrary existing file",
            mutate_ql_card_to_arbitrary_file,
            (
                "file_present card target_path must be canonical path "
                "'blueprint/theorem_cards/QL-001.yaml'"
            ),
        ),
        (
            "closed complete manifest without a member card",
            mutate_empty_demo_manifest_closed,
            "closed or ready manifest requires at least one registered member card",
        ),
        (
            "ready bootstrap member loses its canonical artifact",
            mutate_ready_card_without_artifact,
            (
                "ready, active, or complete card registration requires artifact_status="
                "'file_present' at its canonical card path",
                "closed or ready manifest member 'QB-001' requires a file-present "
                "canonical card artifact",
            ),
        ),
        (
            "composed fake ready source without a complete page audit",
            mutate_composed_fake_ready_source_without_audit,
            (
                "confirmed entity evidence requires a complete independently reviewed "
                "page audit for its exact source snapshot",
                "resolved occurrence requires a complete independently reviewed page audit "
                "for its exact source snapshot",
                "ready, active, or complete card registration requires artifact_status="
                "'file_present' at its canonical card path",
                "closed or ready manifest member 'OLV-001' requires a file-present "
                "canonical card artifact",
            ),
        ),
        (
            "composed fake ready source with a noncovering page audit",
            mutate_composed_fake_ready_source_with_noncovering_audit,
            (
                "resolved occurrence printed range 71-72 is not covered by a complete "
                "independently reviewed page audit for its exact source snapshot",
                "ready, active, or complete card registration requires artifact_status="
                "'file_present' at its canonical card path",
                "closed or ready manifest member 'SR-001' requires a file-present "
                "canonical card artifact",
            ),
        ),
    ]

    failures: list[str] = []
    for name, mutate, expected in cases:
        copied = deepcopy(tables)
        mutate(copied)
        errors, _ = validate_tables(
            copied,
            classification_enums,
            classification_examples,
        )
        expected_diagnostics = expected if isinstance(expected, tuple) else (expected,)
        for diagnostic in expected_diagnostics:
            if not any(diagnostic in error for error in errors):
                failures.append(
                    f"negative test {name!r} did not produce expected diagnostic "
                    f"{diagnostic!r}"
                )
    return failures, len(cases)


def main() -> int:
    arguments = set(sys.argv[1:])
    if arguments - {"--negative-tests"}:
        print("usage: validate_inventory.py [--negative-tests]", file=sys.stderr)
        return 2

    read_errors: list[str] = []
    classification_enums, classification_examples = load_classification_authority(
        read_errors
    )
    tables = read_tables(read_errors)
    validation_errors, totals = validate_tables(
        tables,
        classification_enums,
        classification_examples,
    )
    errors = read_errors + validation_errors

    if errors:
        print(f"inventory validation failed with {len(errors)} error(s):", file=sys.stderr)
        for error in errors:
            print(f"- {error}", file=sys.stderr)
        return 1

    if "--negative-tests" in arguments:
        negative_failures, negative_count = run_negative_invariant_tests(
            tables,
            classification_enums,
            classification_examples,
        )
        if negative_failures:
            print(
                f"negative invariant testing failed with {len(negative_failures)} error(s):",
                file=sys.stderr,
            )
            for failure in negative_failures:
                print(f"- {failure}", file=sys.stderr)
            return 1
        print(
            f"negative invariant tests passed: {negative_count} intentionally invalid "
            "copied fixtures rejected"
        )

    association_rows = sum(
        len(tables[name])
        for name in (
            "occurrence_notations.csv",
            "occurrence_entities.csv",
            "occurrence_cards.csv",
            "occurrence_manifests.csv",
        )
    )
    manifest_summary = ", ".join(
        f"{manifest_id}={total}" for manifest_id, total in sorted(totals.items())
    )
    classification_summary = ", ".join(sorted(classification_examples))
    print(
        "inventory validation passed: "
        f"{len(tables['occurrences.csv'])} occurrences, "
        f"{len(tables['notation.csv'])} notations, "
        f"{len(tables['entities.csv'])} entities, "
        f"{len(tables['entity_evidence.csv'])} entity evidence rows, "
        f"{association_rows} occurrence associations; "
        f"classification examples [{classification_summary}]; "
        f"manifest totals [{manifest_summary}]"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
