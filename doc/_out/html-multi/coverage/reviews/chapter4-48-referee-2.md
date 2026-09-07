# Referee report: DLMF §4.8 — Identities

## Snapshot and files reviewed

Snapshot: `703f1ad1d96c360bbac555c43dc39f6ca64d1a7b`.  I independently reviewed
the official [DLMF §4.8 page](https://dlmf.nist.gov/4.8), all E1–E17 source
displays and surrounding branch conditions, the inventory, the Lean source
`LMLF/Blueprint/Elementary/Section48.lean`, the manual page
`doc/LMLFManual/Chapter4/Section48.lean`, and
`coverage/sections/chapter4-48.json`.  No rendered §4.8 page was available in
`doc/_out`.

## Independently computed formula set and verdict

The official numbered set is exactly `4.8.E1` through `4.8.E17`.  The manifest
has exact expected/stated equality and no omissions.

**Verdict: accept.** No P0 or P1 finding remains. The page consistently marks
real-positive/real-variable specializations and records the branch choices and
the one-sided boundary convention.

## Formula-by-formula audit

- **E1–E7:** The real logarithm product, quotient, integer-power, and inverse
  identities are honest specializations of the general-logarithm formulas;
  positive hypotheses are supplied for principal-branch variants.  The
  integer-power declarations use `n : ℤ`, and the real-log totalization at
  negative values is kept within the explicitly stated real specialization.
- **E8:** The complex branch ambiguity is represented by an existential integer
  `k`, preserving the source's `Ln(exp z)=z+2kπi` structure rather than forcing
  a principal value.
- **E9:** The source's inclusive phase display is narrowed to Mathlib's actual
  principal-log convention, `−π < Im z ≤ π`; this is explicitly disclosed in
  the page and manifest as a specialization, so the lower-cut exceptional
  point is not silently misrepresented.
- **E10:** The nonzero condition is explicit and the principal identity
  `exp(log z)=z` is stated with canonical `Complex.exp`/`Complex.log`.
- **E11–E13:** The general/principal/real-power progression is represented by
  positive-real base and real-exponent statements.  The manifest labels the
  first two as specializations and the real identity as the natural real form.
- **E14–E15:** Positive real bases make the source phase constraints automatic;
  the common-base and two-base real power laws are readable and correctly
  scoped.
- **E16–E17:** The real exponential addition law and positive-real power of an
  exponential are honest real slices of the complex formulas, with the source
  branch condition explained as automatic.

## Branch, API, and anchor checks

The documentation names principal versus general logarithms and explicitly
explains every real specialization.  The branch-sensitive complex statements
use `Complex.log`, `Complex.exp`, and an existential integer where appropriate;
no opaque proxy predicate hides a branch condition.  Source anchors are unique,
module-qualified, and each manual block reproduces the complete declaration.
No second quantitative declaration is required: DLMF supplies identities only.

The repeated real forms in E11–E13 mirror genuinely distinct source displays
(general branch, principal branch, and real-variable identity), and their
specialization notes prevent them from being presented as complex exact matches.

## P2/P3 notes

No P2 or P3 issue materially affects this page.  A future readability pass could
remove `-showProofStates` from the manual anchors, but this is presentation
polish and does not affect source fidelity.

## Verification and remaining gaps

`lake env lean LMLF/Blueprint/Elementary/Section48.lean` passes with the 17
expected `sorry` warnings.  Neither source file contains `#check`, filler
status prose, or displaced proof work.  The only unavailable artifact is the
rendered standalone HTML page, so visual anchor inspection remains pending.
