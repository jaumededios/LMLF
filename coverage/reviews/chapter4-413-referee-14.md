# Independent post-repair terminal referee — DLMF §4.13

## Snapshot and files reviewed

I independently reviewed the current bytes of:

- `LMLF/Blueprint/Elementary/Section413.lean`
- `doc/LMLFManual/Chapter4/Section413.lean`
- `coverage/sections/chapter4-413.json`

against the official [DLMF §4.13](https://dlmf.nist.gov/4.13).  The source
and manual each contain 31 statement anchors: the 28 numbered displays and
three explicitly separated proof-sketch disclosures.  The manifest has 28
expected numbered IDs, the same 28 stated IDs, no omissions, 48 nonformula
statement IDs, and 76 declaration records in total.

## Independently computed formula inventory

The official numbered inventory is exactly:

`4.13.E1`, `4.13.E1_1`, `4.13.E1_2`, `4.13.E1_3`, `4.13.E2`, `4.13.E3`,
`4.13.E3_1`, `4.13.E3_2`, `4.13.E4`, `4.13.E4_1`, `4.13.E4_2`, `4.13.E5`,
`4.13.E5_1`, `4.13.E5_2`, `4.13.E5_3`, `4.13.E6`, `4.13.E7`, `4.13.E8`,
`4.13.E9`, `4.13.E9_1`, `4.13.E9_2`, `4.13.E10`, `4.13.E11`, `4.13.E12`,
`4.13.E13`, `4.13.E14`, `4.13.E15`, `4.13.E16`.

The formula-specific URLs, displays, declarations, manifest entries, and
anchors agree exactly with this inventory.  Figure 4.13.1, Figure 4.13.2,
the section prose/annotation records, and all three proof-sketch records are
also represented in the manual and manifest without being miscounted as
numbered formulas.

## E2 branch-point repair

The prior blocker is repaired.  `principalBranch` correctly identifies the
index-zero branch and its cut, while `dlmf_4_13_2` now explicitly requires

`hbranchPoint : W₀.value branchPoint = -1`.

This is the necessary source-faithful normalization because
`branchPoint = -e⁻¹` lies on the principal branch cut, so the off-cut
Lambert equation cannot determine its endpoint value.  The disclosure also
retains the explicit `LambertBoundaryBranch.branchPointValue` for the signed
nonprincipal boundary branch, and states the remaining values `W₀(0)=0` and
`W₀(e)=1`.  The manual prose clearly explains why the principal endpoint is
an explicit hypothesis rather than an off-cut consequence; the manifest note
records the same convention.  No P1 remains here.

## Mathematical/API audit

The branch and domain conditions are preserved throughout: the principal cut
is `(-∞,-e⁻¹]`, nonprincipal cuts are `(-∞,0]`, indexed asymptotics carry
analyticity and the positive-real logarithmic-strip selector, and the
boundary API fixes branch index, opposite one-sided approach, equation,
range, and branch-point value.  E3.1/E3.2 use the corrected `x exp x`
arguments and honest principal/signed selectors.  E4/E4.1/E4.2 separate
first derivatives, iterated derivatives, and the canonical polynomial
recurrence.  E5–E5.3 state their radius, nonzero, cut, and principal-branch
conditions; E6–E9.2 preserve the signed branch-point choices, coefficient
values/recurrences, product relation, phase filter, and square-root series.
E10/E11 separate complete finite-order asymptotic bounds and use the proper
large-argument and negative-real filters.  E12–E14 expose the principal
nonzero domain and derivative hypotheses for the three antiderivative
families.  E15/E16 retain the principal-cut domain and explicit
interval-integrability hypotheses for their finite integral representations.

The E3.1, E3.2, and E9.1 proof-sketch anchors are statement-only and
mathematically distinct from the numbered formulas.  No extra quantitative
companion is required: E1.1/E10 and E11 already provide the source's
distinct asymptotic forms, while the coefficient/series pairs are represented
by their separate source displays.

## Validation

- `lake build LMLF.Blueprint.Elementary.Section413`: passed.
- `cd doc && lake build LMLFManual.Chapter4.Section413`: passed.
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter4/Section413.lean`:
  passed (29 source expressions).
- `node scripts/check_rendered_tex.mjs`: passed (394 generated expressions).
- No `#check`, `#eval`, or `sorryAx` artifact occurs in either authored file;
  permitted theorem `sorry`s are the only build warnings.
- JSON parsing and expected/stated/declaration parity pass.

## Verdict: ACCEPT

No P0 or P1 finding remains after the explicit E2 principal branch-point
normalization repair.
