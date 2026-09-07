# DLMF §4.7 final referee report

## Snapshot and files reviewed

- Snapshot: `7d39f17cef5d56ab37efd6ab9e607fff60f9d7a1` (current working-tree
  versions of the listed files were reviewed).
- Official source: [DLMF §4.7](https://dlmf.nist.gov/4.7), including both
  subsections, the six prose blocks, constraints, and surrounding branch and
  solution context.
- Source inventory: `coverage/dlmf-4-10-source-inventory.json`.
- Lean source: `LMLF/Blueprint/Elementary/Section47.lean`.
- Documentation: `doc/LMLFManual/Chapter4/Section47.lean`.
- Manifest: `coverage/sections/chapter4-47.json`.
- Prior reports: `coverage/reviews/chapter4-47-referee-1.md`,
  `coverage/reviews/chapter4-47-referee-2.md`, and
  `coverage/reviews/chapter4-47-referee-3.md`.
- No rendered §4.7 page is present in `doc/_out/html-multi`; the documentation
  source and its standalone elaboration were checked directly.

## Independently computed expected IDs and verdict

The official page and source inventory contain exactly
`4.7.E1` through `4.7.E15`. The documentation and manifest each contain
exactly that same set, with no omissions or extras. Every entry has one
matching DLMF `.E` link and one complete external anchor whose declaration
specifies module context.

**Verdict: accept.** No P0 or P1 finding remains. In particular, the third
revision's E14/E15 repair is present consistently: both the Lean E14 predicate
and E15 solution theorem require `a ≠ 0`, and the E14/E15 prose and manifest
notes state the same condition.

## Findings

No P0, P1, P2, or P3 findings.

## Correctly handled specializations and quantitative pairs

- E1 and E3 restrict principal-logarithm formulas to
  `Complex.slitPlane`, excluding the branch cut and origin.
- E2 records a selected logarithm branch with an explicit `HasDerivAt`
  hypothesis.
- E4 uses an open local branch domain and `0 < n`, retaining the factorial
  coefficient and negative-power indexing.
- E5 and E12 are reusable `HasDerivAt` candidate-equation predicates rather
  than false claims that arbitrary functions solve the ODEs; the surrounding
  prose identifies the analytic/nonvanishing context.
- E6 uses an open preconnected domain and equal derivative hypotheses to
  conclude one additive constant, matching the local solution qualification.
- E7 and E8 correctly state the exponential derivative identities.
- E9 retains `a ≠ 0` and explicitly identifies the principal `Complex.log`
  specialization.
- E10 and E11 use an explicit domain contained in the principal slit plane;
  E11 retains the finite descending product.
- E13 states the complete nonvanishing family `C * exp(F)` on an open
  preconnected domain, with `C ≠ 0`, and the manifest honestly records this
  as a specialization of the source's antiderivative notation.
- E14 includes the source condition `a ≠ 0` in
  `secondOrderExponentialEquation`.
- E15 includes the same `a ≠ 0` condition, an explicit square-root witness
  `(Complex.sqrt a) ^ 2 = a`, both arbitrary exponential-mode constants, and
  open/preconnected-domain hypotheses.
- No second quantitative declaration is supplied or required by §4.7; no
  genuinely distinct quantitative pair is unreviewed.

## Verification

- `lake env lean LMLF/Blueprint/Elementary/Section47.lean`: passed; the only
  diagnostics are the permitted `sorry` warnings on theorem declarations.
- From `doc/`, `lake env lean LMLFManual/Chapter4/Section47.lean`: passed with
  no errors.
- Independent scans found 15/15 expected and stated IDs, 15/15 DLMF links,
  and anchors `dlmf_4_7_1` through `dlmf_4_7_15` in both Lean and
  documentation. The manifest's expected and stated arrays agree and its 15
  declaration entries name the corresponding declarations.
- Neither source file contains `#check`, filler status prose, or proof work
  displacing statement coverage.
- The inventory's six prose blocks are represented by subsection/context
  prose; no additional table, caption, graphic, or mathematically substantive
  source candidate is unreviewed.
