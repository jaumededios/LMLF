# Referee 9 — DLMF §4.38 terminal all-values audit

## Snapshot and files reviewed

Reviewed the current working-tree versions of:

- `LMLF/Blueprint/Elementary/Section438.lean`;
- `doc/LMLFManual/Chapter4/Section438.lean`;
- `coverage/sections/chapter4-438.json`;
- the official DLMF §4.38 E1–E19 source encodings;
- prior reports through `chapter4-438-referee-7.md`.

## Inventory and anchors

Independent enumeration gives exactly `4.38.E1` through `4.38.E19`, and the
manifest expected/stated sets are equal with no omissions.  The six
nonformula records (`4.38#i.p1`, `4.38#ii.p1`, `4.38#iii.p1`, and the three
subsection annotation notes) are all present with exact stable IDs and
source-linked reader-facing disclosures.  There are 19 source anchors and 19
manual anchors; every source anchor ends before its `by sorry` proof and every
manual disclosure is statement-only.

## Formula audit

E1–E8 preserve the source coefficients, indexing, signs, and convergence
regimes.  In particular, E4 begins at source index `n=1` with the corrected
coefficient sequence, and E7 retains the exact product ratio and
`Re(z²)<1/2` chart.  E9–E14 expose principal square-root derivatives with
branch-complement, pole, and branch-point hypotheses; E10/E12 retain the
half-plane-selected sign parameter and E13/E14 retain reciprocal branch
domains.

E15–E19 now provide genuine bidirectional all-values correspondences.  Their
left sides quantify independently over arbitrary inverse values `x,y`, while
their right sides quantify the square-root choices `r,s` and assert the target
inverse-value predicates.  No left-hand witnesses are assumed as theorem
hypotheses, so the `↔` is not a tautological wrapper.  E15/E16 preserve the
two square-root choices and `ε²=1`; E17 preserves the denominator exclusion;
E18 preserves both target arcsinh/arccosh value relations; and E19 preserves
both denominator exclusions and both target arctanh/arccoth relations.

The manual explicitly explains the multivalued interpretation and links each
formula to its canonical DLMF E-page.  No separate quantitative companion is
warranted: §4.38 contains convergent series, exact derivative identities, and
multivalued addition correspondences, but no distinct error-bound display.

## Verdict: accept

## Verification

- `lake build LMLF.Blueprint.Elementary.Section438`: **pass**, with only
  permitted `sorry` and style warnings.
- `(cd doc && lake build LMLFManual.Chapter4.Section438)`: **pass**, with the
  same permitted warnings.
- Manifest JSON validation: **pass**.
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter4/Section438.lean`:
  **pass**.
- No `#check`, `#eval`, forbidden `\[...\]` delimiters, filler status prose,
  or proof-displacing anchor content was found.
- No unreviewed numbered formula, branch-domain declaration, or substantive
  subsection note remains.
