# DLMF §4.33 referee report

Snapshot reviewed: `958aad0d1078c589a3f7e30a52dc1a32ddf8062c` (with the
current uncommitted §4.33 author files present).

Files reviewed:

- `LMLF/Blueprint/Elementary/Section433.lean`
- `doc/LMLFManual/Chapter4/Section433.lean`
- `coverage/sections/chapter4-433.json`
- `coverage/dlmf-4-10-source-inventory.json`

## Independent inventory

The source inventory contains five §4.33 records: prose blocks
`dlmf:4.33#p1` and `dlmf:4.33#p2`, plus exactly the three numbered formulas
`dlmf:4.33.E1`, `dlmf:4.33.E2`, and `dlmf:4.33.E3`.  The manifest's expected,
stated, and omitted formula-ID lists agree exactly with this independent
enumeration.  There are no tables, figures, or additional formula records.

## Formula audit

- **E1** is correctly reproduced as the complex odd sinh series, with the
  `2*n + 1` power and matching `(2*n + 1)!` denominator.  The documentation
  preserves the source's first terms and identifies the series as entire.
- **E2** is correctly reproduced as the complex even cosh series, with the
  `2*n` power and matching `(2*n)!` denominator.  The constant and first
  terms are shown in the prose.
- **E3** preserves the source's Bernoulli coefficient and odd-power display
  in reader-facing prose, including the explicit terms `z - z^3/3 +
  2z^5/15 - 17z^7/315`.  The Lean declaration is honestly marked a
  specialization: it uses the equivalent all-power Taylor coefficient
  `(tanh)⁽ⁿ⁾(0)/n!`, and it includes the exact source convergence domain
  `‖z‖ < π/2`.  The manual also preserves the nearest-pole/sharp-disk
  explanation and points to §24.2(i) and §4.28.8–§4.28.13 for the Bernoulli
  and imaginary-argument substitution context.

All three entries have direct `4.33.E*` source links, complete anchored
declarations, readable namespace context, and manifest declaration names.
No quantitative analogue is applicable, and no second declaration is
needed for any formula.

## Findings

None.  No P0, P1, P2, or P3 findings.

The two prose records are substantively represented: the introductory
complex-variable and convergence context is in the manual's opening prose,
and the source's Bernoulli-number/reference and `z ↦ iz` trigonometric-series
substitution note is reproduced at the end.

## Build and hygiene

- `lake build LMLF.Blueprint.Elementary.Section433` — passed (only the three
  permitted `sorry` warnings).
- `cd doc && lake env lean LMLFManual/Chapter4/Section433.lean` — passed.
- Neither source file contains `#check`; no filler declarations or displaced
  proof work were found.

## Verdict

**accept**
