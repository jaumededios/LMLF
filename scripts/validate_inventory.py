#!/usr/bin/env python3
"""Validate the normalized Olver inventory using only the standard library."""

from __future__ import annotations

import csv
import sys
from copy import deepcopy
from collections import defaultdict
from pathlib import Path


SCHEMA_VERSION = "inventory-v1.0.0"
ROOT = Path(__file__).resolve().parents[1]
INVENTORY = ROOT / "blueprint" / "inventory"


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
    "cards.csv": [
        "schema_version",
        "card_id",
        "theorem_class",
        "coverage_class",
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
        "cards.csv": REQUIRED["cards.csv"]
        + (
            "theorem_class",
            "coverage_class",
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
    ("cards.csv", "theorem_class"): {
        "foundational_calculus",
        "definition_identification",
        "finite_remainder_bound",
        "existence_uniqueness",
        "qualitative_bridge",
    },
    ("cards.csv", "coverage_class"): {
        "infrastructure",
        "entity_identification",
        "exact_source_generic",
        "named_source_application",
        "audit_source_recovery",
    },
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


def check_rows(tables: dict[str, list[dict[str, str]]], errors: list[str]) -> None:
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
            for (enum_file, field), allowed in ENUMS.items():
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


def check_semantics(
    tables: dict[str, list[dict[str, str]]], errors: list[str]
) -> None:
    editions = index_by(tables, "editions.csv", "edition_id")
    snapshots = index_by(tables, "source_snapshots.csv", "source_snapshot_id")

    for row in tables["edition_relations.csv"]:
        if row["from_edition_id"] == row["to_edition_id"]:
            add_error(
                errors,
                "edition_relations.csv",
                line_of(row),
                "edition relation must connect distinct edition IDs",
            )
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

    for row in tables["source_snapshots.csv"]:
        digest_fields = (row["digest_algorithm"], row["digest_value"])
        if row["digest_status"] == "verified" and not all(digest_fields):
            add_error(
                errors,
                "source_snapshots.csv",
                line_of(row),
                "verified digest requires digest_algorithm and digest_value",
            )
        if row["digest_status"] == "unresolved" and any(digest_fields):
            add_error(
                errors,
                "source_snapshots.csv",
                line_of(row),
                "unresolved digest must not carry an algorithm or value",
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
            if row["target_class"] == "source_definition":
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
                        "resolved source definition requires confirmed notation and entity links",
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
        if row["resolution_status"] == "resolved" and row["transcription_status"] != "verified":
            add_error(
                errors,
                "notation.csv",
                line_of(row),
                "resolved notation requires verified transcription",
            )

    occurrences = index_by(tables, "occurrences.csv", "occurrence_id")
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
            if not row["target_path"]:
                add_error(
                    errors,
                    "cards.csv",
                    line_of(row),
                    "file_present card requires target_path",
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

    occurrences = index_by(tables, "occurrences.csv", "occurrence_id")
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


def validate_tables(
    tables: dict[str, list[dict[str, str]]]
) -> tuple[list[str], dict[str, int]]:
    errors: list[str] = []
    check_rows(tables, errors)
    check_foreign_keys(tables, errors)
    check_semantics(tables, errors)
    totals = check_manifest_totals(tables, errors)
    return errors, totals


def run_negative_invariant_tests(
    tables: dict[str, list[dict[str, str]]]
) -> list[str]:
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
    ]

    failures: list[str] = []
    for name, mutate, expected in cases:
        copied = deepcopy(tables)
        mutate(copied)
        errors, _ = validate_tables(copied)
        if not any(expected in error for error in errors):
            failures.append(
                f"negative test {name!r} did not produce expected diagnostic {expected!r}"
            )
    return failures


def main() -> int:
    arguments = set(sys.argv[1:])
    if arguments - {"--negative-tests"}:
        print("usage: validate_inventory.py [--negative-tests]", file=sys.stderr)
        return 2

    read_errors: list[str] = []
    tables = read_tables(read_errors)
    validation_errors, totals = validate_tables(tables)
    errors = read_errors + validation_errors

    if errors:
        print(f"inventory validation failed with {len(errors)} error(s):", file=sys.stderr)
        for error in errors:
            print(f"- {error}", file=sys.stderr)
        return 1

    if "--negative-tests" in arguments:
        negative_failures = run_negative_invariant_tests(tables)
        if negative_failures:
            print(
                f"negative invariant testing failed with {len(negative_failures)} error(s):",
                file=sys.stderr,
            )
            for failure in negative_failures:
                print(f"- {failure}", file=sys.stderr)
            return 1
        print("negative invariant tests passed: 5 intentionally invalid copied fixtures rejected")

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
    print(
        "inventory validation passed: "
        f"{len(tables['occurrences.csv'])} occurrences, "
        f"{len(tables['notation.csv'])} notations, "
        f"{len(tables['entities.csv'])} entities, "
        f"{association_rows} associations; manifest totals [{manifest_summary}]"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
