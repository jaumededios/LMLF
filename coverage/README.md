# DLMF Chapters 4–10 coverage

[`dlmf-4-10.json`](dlmf-4-10.json) is the machine-readable coverage ledger. Schema version 1 has one
row for every **numbered formula** in DLMF Chapters 4–10. It does not copy formula bodies.

[`dlmf-4-10-source-inventory.json`](dlmf-4-10-source-inventory.json) is the schema-version-2
structural inventory. It indexes 4,792 formula, prose, table-row, caption, and substantive-annotation
candidates by stable location and content hash. Section manifests can synchronize non-formula source
items into `reviewed_no_claim` or `claims_identified` states; items without a reviewed manifest row
remain `unreviewed`. Structural detection is not a claim that every paragraph is theorem-shaped. Its
contract is [`dlmf-source-inventory.schema.json`](dlmf-source-inventory.schema.json).

Non-formula status overrides are kept separately in
[`source-item-overrides.json`](source-item-overrides.json). Formula declarations remain exclusively
in [`overrides.json`](overrides.json), so the two ledgers cannot silently exchange IDs.
The synchronizer validates status combinations as well as enum values: checked statuses carry
declarations, reviewed-absent statuses do not, proofs require checked statements, and an identified
quantitative analogue cannot be recorded as `not_applicable`.

The boolean fields are deliberately independent:

- `lean_statement`: LMLF has a checked Lean declaration matching the formula exactly or as described
  by `match`.
- `lean_proof`: that declaration has a proof rather than a proof-pending axiom.
- `quantitative_analogue`: LMLF has identified a distinct finite estimate for the result.
- `quantitative_statement`: the distinct estimate has a checked Lean declaration.
- `quantitative_proof`: the distinct estimate has a proof.

Reviewed overrides may also carry `lean_proof_status`: `proved`, `missing`, or
`not_applicable`. The last value distinguishes a transparent definition from a theorem awaiting a
proof while retaining the legacy `lean_proof` boolean for schema-v1 consumers.

`match` is `exact`, `specialization`, `consequence`, `related`, or `none`. `related` records a
useful checked declaration that is not logically equivalent to the displayed DLMF formula; the
schema-v2 inventory reports this honestly as `partial`. An unmapped row has all five booleans set to `false`;
this means no corresponding declaration is currently catalogued in LMLF, not that the mathematics is
absent from Mathlib or another Lean library.

Synchronize a reviewed consecutive section range (accepting both the author-contract and earlier
page shapes), validate its IDs against the schema-v2 inventory, and regenerate both ledgers with
one idempotent command. The historical default remains Chapter 5:

```sh
python3 scripts/sync_chapter5_coverage.py
```

Use `--dry-run` with `--chapter`, `--first-section`, and `--last-section` to validate a narrow
manifest range and report both formula and source-item counts without writing artifacts.

For example, synchronize all of Chapter 4 with:

```sh
python3 scripts/sync_chapter5_coverage.py \
  --chapter 4 --first-section 1 --last-section 48 --expected-formulas 531
```

The command replaces formula and source-item overrides only for the selected section range,
preserves overrides elsewhere, updates the rendered summary rows from the generated ledger, and
may be rerun after any manifest edit. Its output is stable apart from the generators' UTC
`generated_at` timestamps. The filename is historical; the command is chapter-parameterized.
The lower-level generators remain useful for a ledger rebuild when no reviewed specialization
overrides are present.

Update `overrides.json` whenever a statement or proof lands. The generator rejects inconsistent
states such as a proof without a statement.
