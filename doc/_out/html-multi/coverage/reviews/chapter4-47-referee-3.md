# DLMF §4.7 final referee report

## Snapshot and files reviewed

- Snapshot: `7d39f17cef5d56ab37efd6ab9e607fff60f9d7a1` (working-tree files were reviewed as supplied).
- Official source: [DLMF §4.7](https://dlmf.nist.gov/4.7), including the logarithm and exponential/power subsections, constraints, and surrounding prose.
- Source inventory: `coverage/dlmf-4-10-source-inventory.json`.
- Lean source: `LMLF/Blueprint/Elementary/Section47.lean`.
- Documentation: `doc/LMLFManual/Chapter4/Section47.lean`.
- Manifest: `coverage/sections/chapter4-47.json`.
- Prior reports: `coverage/reviews/chapter4-47-referee-1.md` and `coverage/reviews/chapter4-47-referee-2.md`.
- No rendered §4.7 page is present in `doc/_out/html-multi`; the standalone Verso source was elaborated directly.

## Independently computed expected IDs and verdict

The official page and inventory contain exactly `4.7.E1` through `4.7.E15`.
The manifest and documentation contain exactly that same set, with no omissions
or extras.

**Verdict: revise.** The revised candidate predicates for E5 and E12 no longer
assert equations for arbitrary functions, and the E6/E13 APIs now express the
requested connected-domain constant-difference and complete nonvanishing-family
results. However, E14 drops the source's nonzero constraint on `a`, and E15 is
false under its stated hypotheses because the same constraint is absent.

## Findings

### P0 — E15 is false because the E14 constraint `a ≠ 0` is not formalized

`LMLF/Blueprint/Elementary/Section47.lean:122-127`,
`doc/LMLFManual/Chapter4/Section47.lean:254-270`, and the E15 manifest entry
state a complete two-exponential solution family with only
`hsq : (Complex.sqrt a) ^ 2 = a`. The official [E14](https://dlmf.nist.gov/4.7.E14)
display has the explicit condition `a ≠ 0`; E15 is the general solution in that
context. The current Lean theorem admits `a = 0`: take `U = Set.univ`,
`w z = z`, and `Complex.sqrt 0 = 0`. Then `hw` holds for the equation
`w'' = 0`, and `hsq` holds, but no constants `A` and `B` can satisfy
`z = A * exp 0 + B * exp 0` for every `z`.

Add `(ha : a ≠ 0)` to `secondOrderExponentialSolution` (and retain the explicit
square-root witness/branch condition), and state that condition in the prose and
manifest notes. The resulting open/preconnected-domain theorem can then be the
complete two-mode family requested by E15.

### P1 — E14's candidate predicate omits the numbered formula's domain constraint

`LMLF/Blueprint/Elementary/Section47.lean:116-117` defines
`secondOrderExponentialEquation a w U` for every `a : ℂ`, while the source
[E14](https://dlmf.nist.gov/4.7.E14) explicitly requires `a ≠ 0`. The page's
formula at `doc/LMLFManual/Chapter4/Section47.lean:240-249` displays `a ≠ 0`,
but the complete anchored declaration and the manifest's `exact` relation do not
carry it. Although this is now a genuine candidate predicate rather than the
previous false universal theorem, it is still broader than the numbered source.

Repair by making the predicate include `a ≠ 0` (for example, an explicit
`ha : a ≠ 0` parameter or a conjunction in the proposition), and align E14's
manifest note with that formal domain. E15 should use the same hypothesis.

## Correctly handled specializations and quantitative pairs

- E1 and E3 use `Complex.slitPlane`, making the principal-logarithm branch cut
  explicit.
- E2 is a genuine branch-explicit derivative statement via `HasDerivAt`.
- E4 now supplies an open local branch domain and `0 < n`, with the factorial and
  negative-power indexing preserved.
- E5 and E12 are non-tautological candidate predicates: they define the displayed
  `HasDerivAt` equations without claiming that arbitrary `w` satisfies them.
  The source's nonvanishing/analytic context is explained in the surrounding
  prose rather than asserted as an unconstrained theorem.
- E6 uses an open preconnected domain and equal derivative hypotheses to conclude
  one additive constant on that domain.
- E7–E9 retain the complex derivative formulas and the E9 condition `a ≠ 0`;
  E9's principal-power specialization is identified in the prose and manifest.
- E10–E11 state the principal variable-base branch on an explicit slit-plane
  domain and retain the finite descending product for E11.
- E13 states the complete nonvanishing family `C * exp(F)` on an open
  preconnected domain, with `C ≠ 0`; this is honestly recorded as a
  specialization of the source's antiderivative notation.
- E14 has the correct second-derivative predicate shape apart from the missing
  `a ≠ 0` constraint above.
- E15 makes a square-root witness explicit through `hsq` and quantifies both
  exponential-mode constants; it still needs the nonzero-`a` repair above.
- No genuinely distinct quantitative declaration is supplied or required by
  §4.7.

## Verification

- `lake env lean LMLF/Blueprint/Elementary/Section47.lean`: passed, with the
  permitted `sorry` warnings.
- From `doc/`, `lake env lean LMLFManual/Chapter4/Section47.lean`: passed.
- Expected/stated numbered IDs: 15/15; omitted IDs: 0.
- All E1–E15 documentation entries have the corresponding stable DLMF `.E`
  links and open external anchors containing complete declarations.
- Neither source file contains `#check`, filler status prose, or proof work that
  displaces statement coverage.
- No additional mathematically substantive source candidate is unreviewed: the
  inventory's §4.7 prose blocks are represented by the subsection/context prose;
  no table or graphics caption contributes a separate result.
