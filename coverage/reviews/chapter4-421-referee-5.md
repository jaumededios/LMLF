# Final referee report: DLMF §4.21

## Snapshot and files reviewed

Snapshot: `4c16e1d` (working-tree §4.21 author files reviewed).  I read the
referee contract and the preceding `chapter4-421-referee-4.md`, then audited:

- `LMLF/Blueprint/Elementary/Section421.lean`;
- `doc/LMLFManual/Chapter4/Section421.lean`;
- `coverage/sections/chapter4-421.json`.

## Formula inventory

The independently computed numbered inventory is
`4.21.E1`, `4.21.E1_5`, and `4.21.E2` through `4.21.E43`, totaling 44
records.  The manifest expected and stated sets are identical (44/44), and
all 44 manifest declarations have distinct matching source IDs.

## Verdict: accept

The prior P1 has been repaired.  E36 no longer takes the differential relation
as an input and returns it verbatim: its source and manual declarations now
state the direct reusable proposition
`HasDerivAt (fun s : ℂ => 2 * Complex.arctan s)
  (2 / (1 + t ^ 2)) t`, alongside the tangent-half-angle parametrization.
The chart hypotheses `t = tan (z/2)`, `cos (z/2) ≠ 0`, and
`1 + t^2 ≠ 0` are explicit, with the last excluding the inverse-chart poles.
The E36 source and manual anchors display the same complete declaration.

## Formula audit

- **E1/E1_5:** quarter-period sine/cosine forms and the real amplitude-phase
  specialization have the expected signs.
- **E2–E5:** addition/subtraction signs, input/output poles, and quotient
  denominator exclusions are present.
- **E6–E20:** sum/product, Pythagorean, reciprocal, and square identities
  preserve the displayed signs and domains.
- **E21–E23:** square-root sign choices remain existential or signed rather
  than silently selecting a branch; quotient forms carry their exclusions.
- **E24–E29:** parity, double-angle, and tangent rational forms include the
  required denominator conditions.
- **E30–E35:** multiple-angle, integer De Moivre, and positive-natural
  product formulas preserve coefficients and indexing; E34's fractional and
  complex-index continuation is retained in prose.
- **E36:** the repaired direct `HasDerivAt` relation and rational
  parametrization are readable and non-tautological under explicit chart
  hypotheses.
- **E37–E43:** real-coordinate decompositions, modulus identities, and the
  tangent denominator condition have the expected factors and signs.

No specialization is mislabeled: E1_5 is the real amplitude-phase case, E34
discloses its continuation, E35 is restricted to positive natural index, and
E37–E43 are identified as real-coordinate specializations.  No quantitative
companion declarations are warranted for this identity/coordinate section.

## Anchors, manifest, and build

The source and manual each contain exactly 44 anchors, with no missing or
extra ID relative to the manifest; each manual anchor displays the complete
theorem declaration.  No `#check`, filler status prose, tables, figures, or
other unreviewed mathematical candidates were found.

`lake build LMLF.Blueprint.Elementary.Section421` passes (only permitted
`sorry` and style warnings).  `cd doc && lake build
LMLFManual.Chapter4.Section421` and standalone manual elaboration also pass.

There are no P0 or P1 findings.  **Accept.**
