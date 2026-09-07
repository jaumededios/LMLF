# Independent second code/data referee — non-formula coverage synchronization

## Scope

I independently reviewed the current bytes of:

- `scripts/update_dlmf_source_inventory.py`
- `scripts/sync_chapter5_coverage.py`
- `coverage/README.md`
- `coverage/source-item-overrides.json`
- the prior report `coverage/reviews/source-item-coverage-referee-1.md`

Only this report was edited.

## Verification performed

- The requested narrow dry-run succeeds twice with identical output:

  ```text
  python3 scripts/sync_chapter5_coverage.py --dry-run --chapter 6 --first-section 20 --last-section 20 --expected-formulas 0
  {"formula_overrides": 0, "source_item_no_claim": 0, "source_item_overrides": 14}
  ```

- SHA-256 snapshots of `coverage/overrides.json`,
  `coverage/source-item-overrides.json`, both generated ledgers, and
  `doc/LMLFManual/Components.lean` are unchanged by that dry-run.  The full legacy Chapter 5
  range also passes in dry-run mode with 160 formula overrides and zero source-item overrides,
  confirming compatibility with the older formula-only manifests.
- Python compilation of both synchronizer/generator modules passes.  The §6.20 manifest has exact
  non-formula ID parity: all 14 listed IDs are recognized, and the generated in-memory status map
  validates for every row.  A quantitative-only source claim (`names=[]`, a checked quantitative
  declaration) is classified as `claims_identified`, not `reviewed_no_claim`.
- Adversarial status tests reject proof without a checked statement, declarations under
  `reviewed_absent`, quantitative declarations without a checked quantitative statement,
  quantitative claims under `not_applicable`, and unknown quantitative declarations.  Valid
  qualitative-only, no-claim, quantitative-only, and candidate rows are accepted.
- Exact-ID checks accept a known non-formula inventory ID and reject an unprefixed ID, an unknown
  non-formula ID, and a numbered-formula ID.  Applying a source-item override directly to a
  numbered formula is also rejected.
- Merge tests show selected-range source statuses are replaced, selected stale rows are removed,
  and rows outside the selected range are retained.  Formula merging remains isolated from the
  source-item map.
- The checked repository inventory is JSON-readable and satisfies the independent structural
  schema gate: schema version 2, 243 sections, 4,792 items, all required item/status keys, and
  the pinned kind/status enums.  An in-memory full inventory regeneration through the
  synchronizer's specialization adapter reproduces 243 sections, 4,792 items, and 2,108
  numbered formulas.
- The optional Python `jsonschema` package is not installed, so external Draft 2020-12 validation
  was unavailable; the repository generator's own structural checks and the independent checks
  above pass.

## Findings

The two P1 findings in referee 1 are repaired:

1. Quantitative-only claims now force `review.state = claims_identified` through the analogue
   status, even when the qualitative declaration list is empty.
2. `validate_source_item_override` now enforces the cross-field invariants for statement/proof
   status and declaration presence on both qualitative and quantitative branches, including the
   `not_applicable` analogue case.

The standalone inventory generator still rejects the repository's pre-existing formula
`specialization` rows when invoked directly; the synchronizer's documented compatibility adapter
accepts `specialization`, and both requested synchronizer paths pass.  This is an inherited
formula-generator limitation, not a defect in the non-formula synchronization changes.

## Verdict: ACCEPT

No P0/P1 issue remains in the requested non-formula synchronization scope.  The focused dry-run,
quantitative-only classification, status validation, exact-ID checks, merge scoping, formula
isolation, schema-shape checks, and backward-compatible Chapter 5 path all pass.
