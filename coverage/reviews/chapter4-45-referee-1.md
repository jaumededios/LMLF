# Referee report: DLMF §4.5

## Snapshot and files reviewed

Reviewed at commit `703f1ad`:

- official [DLMF §4.5](https://dlmf.nist.gov/4.5), including the logarithm
  and exponential subsections, hypotheses, symbol notes, and derivational notes;
- `LMLF/Blueprint/Elementary/Section45.lean`;
- `doc/LMLFManual/Chapter4/Section45.lean`;
- `coverage/sections/chapter4-45.json`.

No rendered standalone §4.5 page is present under `doc/_out/html-multi`; source
elaboration and anchor checks were therefore used for the page-level review.

## Independently computed coverage

The official page contains exactly:

`4.5.E1`, `4.5.E2`, `4.5.E3`, `4.5.E4`, `4.5.E5`, `4.5.E6`, `4.5.E7`,
`4.5.E8`, `4.5.E9`, `4.5.E10`, `4.5.E11`, `4.5.E12`, `4.5.E13`, `4.5.E14`,
`4.5.E15`, `4.5.E16`.

The manifest has the same expected and stated sets and no omissions or extras.

## Verdict: accept

All sixteen numbered displays are paired with the correct source links, readable
mathematical prose, and complete anchored Lean declarations. Inequality
directions and strictness agree with the source, including the source note that
4.5.7–4.5.12 become equalities at `x = 0`. The Lean module and standalone
documentation elaborate with only permitted `sorry` warnings. No P0 or P1
finding remains.

## Formula-by-formula audit

- **4.5.E1–E2:** The two-sided logarithm inequalities have the correct order,
  denominators, and domains (`x > -1` and `x < 1`, respectively), with `x ≠ 0`
  for strictness. The declarations are direct real propositions in
  `dlmf_4_5_1` and `dlmf_4_5_2`.
- **4.5.E3:** The absolute logarithm estimate has `0 < x ≤ 0.5828`; the
  finite decimal is honestly documented as a specialization of the source's
  recurring cutoff `0.5828…`. `dlmf_4_5_3` preserves strictness and the
  factor `3/2`.
- **4.5.E4–E5:** The positive-real logarithm tangent inequality and the
  power-form inequality preserve `x > 0` and `a > 0`. The real-power reading is
  stated in the prose and recorded as a specialization for E5.
- **4.5.E6:** The principal complex logarithm estimate is stated on the open
  unit disk with the correct norm and real right-hand side in `dlmf_4_5_6`.
- **4.5.E7–E12:** Every exponential inequality has the source's direction and
  denominator. The declarations include `x ≠ 0` where the source's strict
  inequalities require it; E8's prose explicitly notes equality at zero. E10
  and E12 retain `x > -1`, while E7, E9, and E11 retain `x < 1`.
- **4.5.E13:** The weighted power sandwich has both strict inequalities and
  positive `x,y`; the declaration uses real `rpow`, explicitly recorded as the
  real specialization.
- **4.5.E14:** The strict small-positive exponential estimate preserves
  `0 < x ≤ 1.5936`, with the finite decimal identified as a specialization of
  the source's recurring cutoff `1.5936…`.
- **4.5.E15–E16:** The complex increment estimates preserve respectively
  `0 < ‖z‖ < 1` and unrestricted `z ∈ ℂ`, including both bounds in each
  conjunction and the correct constants `1/4`, `7/4`, and `‖z‖e^{‖z‖}`.

Every documentation anchor names the corresponding fully qualified declaration,
and the source-side anchors enclose the statement before `by sorry`. No opaque
proxy predicates, `#check`, filler status prose, or proof work displacing the
mathematical statements was found.

## Findings

### P2 — Formula typography in E1 and E2

`doc/LMLFManual/Chapter4/Section45.lean` uses `quad` rather than `\quad` in
the displayed formulas for 4.5.1 and 4.5.2 (`x>-1,quad x\ne0` and
`x<1,quad x\ne0`). The hypotheses are stated correctly in prose and Lean, so
this is presentation-only. Replace each literal `quad` with `\quad` to match
the DLMF display and avoid rendering it as ordinary text.

## Specializations and quantitative pairs

- E3 and E14 use finite displayed decimal cutoffs in place of the source's
  recurring decimal endpoints; both are marked `specialization` in the manifest.
- E5 and E13 use real positive variables and real powers; both are honestly
  marked `specialization`.
- E1, E2, E4, E6–E12, E15, and E16 are direct statements in the chosen real or
  complex vocabulary.
- No second quantitative declaration is warranted: each source display is
  itself an inequality, and no distinct remainder/enclosure result is supplied.

## Verification and remaining source candidates

- `lake env lean LMLF/Blueprint/Elementary/Section45.lean`: passed; only the
  sixteen expected `sorry` warnings were emitted.
- `cd doc && lake env lean LMLFManual/Chapter4/Section45.lean`: passed.
- `#check` search in both assigned source files: no hits.
- The DLMF derivational notes (Hardy et al., Maclaurin-series remarks, and the
  zero statements for the cutoff functions) are explanatory source prose rather
  than additional numbered formulas. No table, figure, caption, or other
  mathematically substantive unnumbered candidate was omitted from the authored
  page.
