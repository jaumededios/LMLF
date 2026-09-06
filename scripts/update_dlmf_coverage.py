#!/usr/bin/env python3
"""Build the DLMF Chapters 4--10 formula coverage ledger.

The generator records identifiers, titles, and stable links, but deliberately does not copy DLMF
formula bodies.  LMLF-specific status is supplied by ``coverage/overrides.json``.
"""

from __future__ import annotations

import argparse
import concurrent.futures
import datetime as dt
import html
import json
import pathlib
import re
import time
import urllib.error
import urllib.request


CHAPTERS = tuple(range(4, 11))
EXPECTED_FORMULA_COUNTS = {4: 531, 5: 169, 6: 100, 7: 139, 8: 241, 9: 230, 10: 698}
BASE_URL = "https://dlmf.nist.gov"
USER_AGENT = "LMLF-coverage-index/1.0 (+https://github.com/jaumededios/LMLF)"

SECTION_RE = re.compile(
    r'<link rel="section" href="\./(?P<id>(?:[4-9]|10)\.\d+)" title="(?P<title>[^"]+)"'
)
VERSION_RE = re.compile(r"Version\s+(?P<version>[\d.]+);\s*Release date\s+(?P<date>\d{4}-\d{2}-\d{2})")


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


def chapter_sections(chapter: int, source: str) -> list[dict[str, object]]:
    seen: set[str] = set()
    sections: list[dict[str, object]] = []
    for match in SECTION_RE.finditer(source):
        section_id = match.group("id")
        if not section_id.startswith(f"{chapter}.") or section_id in seen:
            continue
        seen.add(section_id)
        full_title = html.unescape(match.group("title"))
        short_title = full_title.split(" ‣ ", maxsplit=1)[0]
        short_title = re.sub(rf"^§{re.escape(section_id)}\s*", "", short_title)
        sections.append(
            {
                "id": section_id,
                "chapter": chapter,
                "title": short_title,
                "source_url": f"{BASE_URL}/{section_id}",
            }
        )
    return sections


def formula_ids(section_id: str) -> list[str]:
    source = fetch(f"{BASE_URL}/{section_id}")
    pattern = re.compile(
        rf"https?://dlmf\.nist\.gov/{re.escape(section_id)}\.(E\d+(?:[a-z]|_\d+)?)"
    )
    identifiers = {f"{section_id}.{match}" for match in pattern.findall(source)}
    return sorted(identifiers, key=formula_sort_key)


def formula_sort_key(identifier: str) -> tuple[int, int, int, str]:
    match = re.fullmatch(r"(\d+)\.(\d+)\.E(\d+)([a-z]|_\d+)?", identifier)
    if match is None:
        raise ValueError(f"Unexpected DLMF formula identifier: {identifier}")
    chapter, section, number, suffix = match.groups()
    return int(chapter), int(section), int(number), suffix or ""


def display_number(identifier: str) -> str:
    return identifier.replace(".E", ".")


def default_status() -> dict[str, object]:
    return {
        "match": "none",
        "lean_statement": False,
        "lean_proof": False,
        "lean_declarations": [],
        "quantitative_analogue": False,
        "quantitative_statement": False,
        "quantitative_proof": False,
        "quantitative_declarations": [],
        "notes": None,
    }


def validate_status(identifier: str, status: dict[str, object]) -> None:
    if status["lean_proof"] and not status["lean_statement"]:
        raise ValueError(f"{identifier}: a proof requires a Lean statement")
    if status["quantitative_statement"] and not status["quantitative_analogue"]:
        raise ValueError(f"{identifier}: a quantitative statement requires an analogue")
    if status["quantitative_proof"] and not status["quantitative_statement"]:
        raise ValueError(f"{identifier}: a quantitative proof requires its statement")


def build_ledger(overrides_path: pathlib.Path) -> dict[str, object]:
    chapter_sources = {chapter: fetch(f"{BASE_URL}/{chapter}") for chapter in CHAPTERS}
    version_match = VERSION_RE.search(chapter_sources[CHAPTERS[0]])
    if version_match is None:
        raise RuntimeError("Could not read the DLMF version from the Chapter 4 page")

    sections = [
        section
        for chapter in CHAPTERS
        for section in chapter_sections(chapter, chapter_sources[chapter])
    ]
    with concurrent.futures.ThreadPoolExecutor(max_workers=6) as executor:
        formula_lists = list(executor.map(lambda item: formula_ids(str(item["id"])), sections))

    overrides = json.loads(overrides_path.read_text(encoding="utf-8"))
    formulas: list[dict[str, object]] = []
    for section, identifiers in zip(sections, formula_lists, strict=True):
        section["formula_count"] = len(identifiers)
        for identifier in identifiers:
            status = default_status()
            status.update(overrides.get(identifier, {}))
            validate_status(identifier, status)
            formulas.append(
                {
                    "dlmf_id": identifier,
                    "display_number": display_number(identifier),
                    "chapter": section["chapter"],
                    "section": section["id"],
                    "section_title": section["title"],
                    "source_url": f"{BASE_URL}/{identifier}",
                    **status,
                }
            )

    unknown_overrides = sorted(set(overrides) - {item["dlmf_id"] for item in formulas})
    if unknown_overrides:
        raise ValueError(f"Overrides do not name current DLMF formulas: {unknown_overrides}")

    actual_counts = {
        chapter: sum(item["chapter"] == chapter for item in formulas) for chapter in CHAPTERS
    }
    if actual_counts != EXPECTED_FORMULA_COUNTS:
        raise RuntimeError(
            f"DLMF formula inventory changed: expected {EXPECTED_FORMULA_COUNTS}, got {actual_counts}"
        )

    summary: dict[str, object] = {}
    for chapter in CHAPTERS:
        chapter_formulas = [item for item in formulas if item["chapter"] == chapter]
        summary[str(chapter)] = {
            "formulas": len(chapter_formulas),
            "lean_statements": sum(bool(item["lean_statement"]) for item in chapter_formulas),
            "lean_proofs": sum(bool(item["lean_proof"]) for item in chapter_formulas),
            "quantitative_statements": sum(
                bool(item["quantitative_statement"]) for item in chapter_formulas
            ),
            "quantitative_proofs": sum(
                bool(item["quantitative_proof"]) for item in chapter_formulas
            ),
        }

    return {
        "schema_version": 1,
        "generated_at": dt.datetime.now(dt.timezone.utc).replace(microsecond=0).isoformat(),
        "source": {
            "name": "NIST Digital Library of Mathematical Functions",
            "base_url": BASE_URL,
            "version": version_match.group("version"),
            "release_date": version_match.group("date"),
        },
        "scope": {
            "chapters": list(CHAPTERS),
            "unit": "numbered_formula",
            "status_catalog": "LMLF",
            "description": (
                "Every numbered DLMF formula in Chapters 4--10. Prose assertions, figures, "
                "tables, and unnumbered formulas are outside schema version 1."
            ),
        },
        "summary": summary,
        "sections": sections,
        "statements": formulas,
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--overrides", type=pathlib.Path, default=pathlib.Path("coverage/overrides.json"))
    parser.add_argument("--output", type=pathlib.Path, default=pathlib.Path("coverage/dlmf-4-10.json"))
    args = parser.parse_args()

    ledger = build_ledger(args.overrides)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(ledger, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
