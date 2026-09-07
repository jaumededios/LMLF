# Referee report: DLMF §4.12 (final audit after second revision)

## Scope and coverage

I read both prior §4.12 reports and reviewed the current official
[DLMF §4.12](https://dlmf.nist.gov/4.12),
`LMLF/Blueprint/Elementary/Section412.lean`,
`doc/LMLFManual/Chapter4/Section412.lean`, and
`coverage/sections/chapter4-412.json`.

The official page contains exactly 4.12.E1--4.12.E10.  The manifest lists
all ten expected and stated IDs with no omissions.  It also records the
iteration definitions, the guarded logarithm-domain predicate, both
generalized-function interfaces, the paired inverse interface, monotonicity,
and continuous differentiability.

## Verdict: accept

The second revision resolves both prior blocking issues.  E2--E9 are direct
projections from reusable generalized-function interfaces rather than theorem
hypotheses repeating their conclusions.  `GeneralizedFunctionPair` now states
both inverse identities.  E10's `iteratedLogDefined` guard prevents a
totalized `Real.log 0 = 0` from producing duplicate witnesses, while retaining
the source's positive iteration count and half-open unit interval.

## Formula audit

- **E1:** `φ (x+1) = exp (φ x)` is stated for every real `x` with `-1 < x`.
- **E2:** `φ 0 = 0` is a direct projection of the generalized-exponential
  normalization field.
- **E3:** `ψ (exp x) = 1 + ψ x` is stated for every real `x`.
- **E4:** `ψ 0 = 0` is a direct projection of the generalized-logarithm
  normalization field.
- **E5:** Both functions equal the identity on the closed interval `[0,1]`.
- **E6:** The principal real-logarithm branch has the exact domain
  `-1 < x < 0`.
- **E7:** For `x > 1`, the natural floor and fractional part are followed by
  exactly that many explicit real-exponential iterations.
- **E8:** The negative-half-line branch is `exp x - 1`, with `x < 0`.
- **E9:** For `x > 1`, the generalized logarithm is a positive natural number
  plus that many explicit principal-logarithm iterations.
- **E10:** The statement has `x > 1`, a positive natural `l`, and
  `0 ≤ iteratedLog l x < 1`, plus positivity of every earlier iterate.

The E10 guard is effective: for the previous counterexample
`x = exp (exp 1)`, `l = 3` has intermediate iterates `x`, `exp 1`, and `1`
all positive and final iterate `0`; `l = 4` fails
`iteratedLogDefined` because its `k = 3` intermediate value is zero.  More
generally, a later witness cannot pass the guard after an iterate reaches
zero or becomes nonpositive, so totalized-log duplicates are excluded.

## Interfaces and unnumbered source claims

`GeneralizedFunctionPair` has
`Function.LeftInverse logarithm.toFun exponential.toFun` and
`Function.RightInverse logarithm.toFun exponential.toFun`, which respectively
state `ψ(φ(x)) = x` and `φ(ψ(x)) = x`.  The anchored
`generalized_functions_inverse` disclosure exposes both identities to readers.

The generalized structures carry the recurrence, origin normalization,
identity interval, continuation branches, strict increase on `[0,1]`, and
`ContDiff ℝ 1`; the two anchored claims project monotonicity and continuous
differentiability for the paired functions.  The manual explicitly explains
the inverse pairing and the guarded principal-logarithm convention.

## Anchors, prose, manifest, and builds

All E1--E10 have DLMF-linked displays, ordinary mathematical prose, and
module-qualified Lean disclosures.  The extra vocabulary and unnumbered
claims are synchronized between source, manual, and manifest.  No `#check`
or reader-facing status/filler prose is present.

`lake env lean LMLF/Blueprint/Elementary/Section412.lean` succeeds with only
the expected `sorry` warnings, and
`cd doc && lake env lean LMLFManual/Chapter4/Section412.lean` also succeeds.
The remaining `sorry`s are proof-status placeholders permitted by the author
contract; no P0 or P1 statement/API/source-fidelity finding remains.
