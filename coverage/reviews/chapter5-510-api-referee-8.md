# Referee report: DLMF §5.10 aggregate synchronization audit

## Snapshot and files reviewed

- Snapshot: `d6e983b4cd0480fdd162cb1eae0bdd9a92c3568f`; current worktree bytes
  include the repaired synchronization changes.
- Official source: [DLMF §5.10](https://dlmf.nist.gov/5.10), version 1.2.7,
  including [5.10.E1](https://dlmf.nist.gov/5.10.E1) and
  [5.10.E2](https://dlmf.nist.gov/5.10.E2).
- Aggregate metadata reviewed: `coverage/overrides.json`,
  `coverage/dlmf-4-10.json`, `coverage/dlmf-4-10-source-inventory.json`, and
  `coverage/sections/chapter5-510.json`.
- Synchronizer reviewed: `scripts/sync_chapter5_coverage.py`.
- Source/manual checks: `LMLF/Blueprint/Gamma/Section510.lean`,
  `LMLF/Definitions/ContinuedFraction.lean`,
  `doc/LMLFManual/Chapter5/Section510.lean`, and
  `doc/LMLFManual/Chapter2.lean`.
- Generated HTML remains parent-owned and was not used for this aggregate
  verdict.

## Independently computed expected formula IDs

The DLMF source inventory contains exactly `5.10.E1` (display `5.10.1`) and
`5.10.E2` (display `5.10.2`) in section 5.10. E2 is one grouped display with
components `5.10.E2a` through `5.10.E2g`; there are no additional numbered
formulas.

## Verdict

`accept`

The synchronization repair is now present in all current metadata bytes. The
section manifest, overrides, formula ledger, and structural source inventory
agree on the repaired declaration names and proof statuses. The synchronizer's
merge is section-authoritative and semantically idempotent: it removes all old
rows for reviewed formula IDs before inserting the current manifest rows, with
deterministic key ordering. Its documented exception is generator timestamps,
so repeated runs are not byte-identical in `generated_at` fields but do not
resurrect removed declarations. No P0 or P1 finding remains.

## Findings

No P0, P1, P2, or P3 findings.

## Synchronization and stale-name audit

- `coverage/sections/chapter5-510.json` has exactly the expected IDs, no
  omissions, `lean_proofs: 1`, E1 proof-pending, and E2 proved by native
  evaluation. Its declaration lists are the current reusable evaluator,
  canonical coefficient map, formal reconstruction/uniqueness API, and Gamma
  statements.
- `coverage/overrides.json` contains current E1/E2 rows and zero occurrences of
  `continuedFractionTail`, `exists_gammaContinuedFractionCoeff`, or
  `gammaContinuedFractionCoeff_spec`.
- Both aggregate ledgers, `coverage/dlmf-4-10.json` and
  `coverage/dlmf-4-10-source-inventory.json`, likewise contain zero occurrences
  of all three removed names. Their §5.10 E1/E2 rows agree with the overrides,
  including E1 specialization, E2 exact match, and E2's proved status.
- `merge_overrides` in `scripts/sync_chapter5_coverage.py` explicitly starts
  from old rows excluding every reviewed formula ID, then inserts the reviewed
  rows in sorted order. The write-boundary re-read of manifests and inventory
  prevents a concurrent stale snapshot from being merged. This directly fixes
  the prior union-based resurrection failure.
- The script itself documents deterministic behavior apart from generator
  `generated_at` timestamps; no command was run that rewrites or restores the
  manifest.

## Source/manual and mathematical confirmation

- The reusable API exposes optional tail offset, `ZeroTerminated`, executable
  triangular extraction, finite-prefix dependence, formal reconstruction, and
  uniqueness. The Chapter 2 exposition teaches these interfaces before their
  §5.10 use.
- E1 is honestly labeled as the positive-real specialization of DLMF's
  `\(\Re z>0\)` statement with general `Ln Γ`; E2 exactly records all seven
  displayed coefficients. No quantitative analogue is asserted for either
  formula.
- The source note for DLMF's later-coefficient references is present and
  correctly distinguishes external tables from additional §5.10 formulas.

## Build and validation results

- `lake env lean LMLF/Blueprint/Gamma/Section510.lean`: passed; only the two
  permitted `sorry` warnings (Gamma regularity and E1 convergence) remain.
- `cd doc && lake env lean LMLFManual/Chapter5/Section510.lean`: passed,
  resolving the current external anchors.
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter5/Section510.lean`:
  passed (6 expressions); Chapter 2 passed as well (4 expressions).
- Read-only JSON parsing and declaration/stale-name checks passed for all four
  section/aggregate metadata files. The synchronizer parses successfully.
- No `#check`, filler status prose, or source candidate displacing formula
  coverage was found. Generated-site rendering is intentionally deferred to the
  parent-owned rebuild.
