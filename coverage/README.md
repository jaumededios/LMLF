# DLMF Chapters 4–10 coverage

[`dlmf-4-10.json`](dlmf-4-10.json) is the machine-readable coverage ledger. Schema version 1 has one
row for every **numbered formula** in DLMF Chapters 4–10. It does not copy formula bodies.

The boolean fields are deliberately independent:

- `lean_statement`: LMLF has a checked Lean declaration matching the formula exactly or as described
  by `match`.
- `lean_proof`: that declaration has a proof rather than a proof-pending axiom.
- `quantitative_analogue`: LMLF has identified a distinct finite estimate for the result.
- `quantitative_statement`: the distinct estimate has a checked Lean declaration.
- `quantitative_proof`: the distinct estimate has a proof.

`match` is `exact`, `consequence`, or `none`. An unmapped row has all five booleans set to `false`;
this means no corresponding declaration is currently catalogued in LMLF, not that the mathematics is
absent from Mathlib or another Lean library.

Regenerate the ledger from the current DLMF section pages with:

```sh
python3 scripts/update_dlmf_coverage.py
```

Update `overrides.json` whenever a statement or proof lands. The generator rejects inconsistent
states such as a proof without a statement.
