# DLMF Chapters 4–10 coverage

[`dlmf-4-10.json`](dlmf-4-10.json) is the machine-readable coverage ledger. Schema version 1 has one
row for every **numbered formula** in DLMF Chapters 4–10. It does not copy formula bodies.

[`dlmf-4-10-source-inventory.json`](dlmf-4-10-source-inventory.json) is the schema-version-2
structural inventory. It indexes 4,792 formula, prose, table-row, caption, and substantive-annotation
candidates by stable location and content hash. It deliberately labels every source item
`unreviewed`: structural detection is not a claim that every paragraph is theorem-shaped. Its
contract is [`dlmf-source-inventory.schema.json`](dlmf-source-inventory.schema.json).

The boolean fields are deliberately independent:

- `lean_statement`: LMLF has a checked Lean declaration matching the formula exactly or as described
  by `match`.
- `lean_proof`: that declaration has a proof rather than a proof-pending axiom.
- `quantitative_analogue`: LMLF has identified a distinct finite estimate for the result.
- `quantitative_statement`: the distinct estimate has a checked Lean declaration.
- `quantitative_proof`: the distinct estimate has a proof.

`match` is `exact`, `specialization`, `consequence`, or `none`. An unmapped row has all five booleans set to `false`;
this means no corresponding declaration is currently catalogued in LMLF, not that the mathematics is
absent from Mathlib or another Lean library.

Synchronize the reviewed Chapter 5 manifests (both the author-contract and earlier page shapes),
validate their IDs against the schema-v2 inventory, and regenerate both ledgers with one
idempotent command:

```sh
python3 scripts/sync_chapter5_coverage.py
```

The command replaces only Chapter 5.1--5.18 formula overrides, preserves overrides for other
sections, updates the rendered summary rows from the generated ledger, and may be rerun after any
manifest edit.  Its output is stable apart from the generators' UTC `generated_at` timestamps.
The lower-level generators remain useful for a ledger rebuild when no reviewed Chapter 5
specialization overrides are present.

Update `overrides.json` whenever a statement or proof lands. The generator rejects inconsistent
states such as a proof without a statement.
