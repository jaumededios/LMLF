# Final referee report: DLMF §4.16 Elementary Properties

## Snapshot and files reviewed

Reviewed the referee contract, prior §4.16 reports 1–3, the official [DLMF §4.16](https://dlmf.nist.gov/4.16) including Figure 4.16.1 and Tables 4.16.1–4.16.3, and the current:

- LMLF/Blueprint/Elementary/Section416.lean;
- doc/LMLFManual/Chapter4/Section416.lean;
- coverage/sections/chapter4-416.json.

## Independently computed source records

DLMF §4.16 has no numbered E-formulas. Its substantive records are four caption/figure records (F1, T1, T2, T3) and 19 table-row records: five rows for T1, seven for T2, and seven for T3. The manifest lists all 19 row declarations and all four caption/figure records; no row is omitted.

## Verdict

**accept**

No P0 or P1 finding remains in the current artifacts.

## Audit of T1

The four strict quadrant predicates use the correct open intervals bounded by 0, π/2, π, 3π/2, and 2π. Rows 1–4 state all six signs (sin, cos, tan, csc, sec, cot) with the correct signs in every quadrant. The boundary row covers all four axis values and explicitly exposes the totalized reciprocal values at poles; the documentation labels these as Lean totalization/pole conventions rather than finite mathematical reciprocal values.

## Audit of T2

The sine, cosine, tangent, cosecant, secant, and cotangent declarations each preserve all nine source transformations: −θ, π/2 ± θ, π ± θ, 3π/2 ± θ, and 2π ± θ. The tangent and reciprocal rows carry sin θ ≠ 0 and cos θ ≠ 0, excluding the relevant poles before division. The tangent signs and all quarter-period signs agree with the source table. The additional table4162_row7 period cross-check is clearly identified in the manual as shared API context, not an omitted or substituted source row.

## Audit of T3

The six input rows—sine, cosine, tangent, cosecant, secant, and cotangent—each expose six cells (the input plus five recovered functions), giving the complete 6×6 interrelation table. The sine and cosine rows use strict positive sign hypotheses for the recovered branch and strict positive radicands. The tangent and cotangent rows use the positive-cosine branch, nonzero input values, and radicand conditions; the tangent sign is therefore coherent. The cosecant and secant rows use nonzero input values, positive sign hypotheses, and strict radicand conditions, avoiding totalized reciprocal poles and zero square-root denominators. The final T3 row states the principal nonnegative real square-root convention.

The prose explicitly describes the real, finite, principal-square-root convention and the strict non-pole/radicand choices represented by the Lean declarations.

## Anchors, manifest, and builds

- Source anchors: 19.
- Documentation anchors: 19.
- Exact source/document anchor-name equality: yes.
- Manifest declarations: 19.
- Manifest caption/figure and row IDs: complete.
- No #check declarations or proof/status filler prose found.
- lake build LMLF.Blueprint.Elementary.Section416: passes.
- cd doc && lake env lean LMLFManual/Chapter4/Section416.lean: passes.

Section §4.16 contains tables and a figure, not quantitative estimates, so no quantitative companion declaration is warranted. No unreviewed substantive table-row candidate remains.
