# DLMF §4.10 referee review

## Snapshot and files reviewed

Snapshot: current workspace state based on `703f1ad1d96c360bbac555c43dc39f6ca64d1a7b`.

Reviewed:

- Official [DLMF §4.10](https://dlmf.nist.gov/4.10), including E1–E13,
  endpoint conventions, the Cauchy principal-value note for E7, and the
  complex Gaussian condition;
- `coverage/dlmf-4-10-source-inventory.json`;
- `LMLF/Blueprint/Elementary/Section410.lean`;
- `doc/LMLFManual/Chapter4/Section410.lean`; and
- `coverage/sections/chapter4-410.json`.

No rendered standalone page was available in the checked-in output tree;
anchors were checked directly in the manual source.

## Independently computed expected formula IDs

The source inventory contains exactly:

`4.10.E1`, `4.10.E2`, `4.10.E3`, `4.10.E4`, `4.10.E5`, `4.10.E6`,
`4.10.E7`, `4.10.E8`, `4.10.E9`, `4.10.E10`, `4.10.E11`, `4.10.E12`,
`4.10.E13`.

The manifest expected and stated sets agree exactly, with no omissions.

## Verdict: revise

The section has complete identifier coverage and builds successfully, and most
endpoint/specialization choices are reasonable. However, E7 is not a
mathematical principal-value characterization, and E9/E10 lack the branch
conditions required for derivatives of the principal logarithm. These are P0/P1
source-fidelity failures.

## Findings

### P0 — E7 is an unfolding tautology, not the Cauchy principal-value logarithmic integral

- **DLMF ID:** `4.10.E7`.
- **Declarations:** `logarithmicIntegral` and `dlmf_4_10_7` in
  `LMLF/Blueprint/Elementary/Section410.lean`; corresponding entry in the
  manual.
- **Evidence:** DLMF states `li(x)` as the Cauchy principal value of
  `∫₀ˣ dt/log t`, with `x>1`, and separately explains the principal-value
  interpretation at the interior singularity `t=1`. The local definition sets
  `logarithmicIntegral x` to exactly the displayed `Filter.limUnder` expression,
  and the theorem merely repeats that definition. It does not expose a
  meaningful `li`/PV proposition, endpoint or symmetric-cutoff property, or
  establish that the limit is the source integral; `hx` is unused in the
  conclusion.
- **Repair:** define a readable PV expression with the positive-side filter and
  symmetric exclusions, then state its equality to the named logarithmic
  integral (or state the PV limit directly as the theorem’s conclusion). Ensure
  the `x>1` condition participates in the definition/theorem rather than only
  appearing as an unused hypothesis.

### P0 — E9 omits the principal-log branch domain at the logarithm argument

- **DLMF ID:** `4.10.E9`.
- **Declaration:** `dlmf_4_10_9`.
- **Evidence:** The antiderivative contains
  `Complex.log (exp(a w)+b)`. The derivative of Mathlib’s principal `Complex.log`
  is valid only away from zero and the nonpositive-real branch cut. The theorem
  assumes only `exp(a*z)+b ≠ 0`; that permits the argument to lie on the
  negative real axis, where the principal logarithm is not complex
  differentiable. The manual says “away from zeros” but does not mention the
  branch-cut condition.
- **Repair:** add the local branch hypothesis
  `((Complex.exp (a*z)+b).im ≠ 0 ∨ 0 < (Complex.exp (a*z)+b).re)` (together
  with the existing nonzero condition), and state the principal-branch
  specialization explicitly in the prose and manifest.

### P0 — E10 has the same missing branch-domain condition

- **DLMF ID:** `4.10.E10`.
- **Declaration:** `dlmf_4_10_10`.
- **Evidence:** The antiderivative uses
  `Complex.log (exp(a*w/2)+exp(-a*w/2))`, but the only extra hypothesis is
  `exp(a*z)+exp(-a*z) ≠ 0`. That denominator condition is equivalent to the
  logarithm argument being nonzero after multiplication by a nonzero factor,
  but it does not exclude the negative-real branch cut. Consequently the
  claimed `HasDerivAt` is not valid for every allowed `z` under the principal
  `Complex.log`.
- **Repair:** add a nonzero and off-cut condition for the logarithm argument at
  `z`, and explain that this is a principal-log branch specialization of the
  source antiderivative.

## Correctly handled formulas and specializations

- **E1–E4:** derivative formulations correctly use `HasDerivAt`, explicit
  nonzero conditions, and a principal-branch domain excluding the nonpositive
  real axis; E3 retains integer `n ≠ −1`.
- **E5–E6:** the interval integrals use the positive interval `(0,1)` and
  preserve the stated values; the endpoint behavior is represented by the
  measure integral over `Ioc`.
- **E8:** the exponential antiderivative correctly requires `a ≠ 0`.
- **E11:** the complex Gaussian uses `Re c > 0`, integrates over all real
  `x`, and uses the principal complex square-root notation.
- **E12:** the finite Bose integral has the correct upper endpoint `ln 2` and
  value `π²/12`.
- **E13:** the positive-half-line Fermi integral uses `Ioi 0` and value `ln 2`.

E1–E4 and E8–E10 are honestly marked as derivative/principal-branch
specializations in the manifest, while E5–E6 and E11–E13 preserve their real
or complex source domains. No distinct quantitative analogue is supplied by
§4.10, so no second quantitative declaration is required.

## Anchors, prose, and verification

All thirteen source links and theorem anchors are present in the manual. The
prose identifies the real/complex specializations, improper endpoint integrals,
Gaussian convergence condition, and Cauchy-PV intent. Neither authored source
contains `#check` or displaced proof work.

Verification passed:

- `lake build LMLF.Blueprint.Elementary.Section410`;
- `cd doc && lake env lean LMLFManual/Chapter4/Section410.lean`;
- inventory/manifest formula counts: `13/13/0`.

Unreviewed source candidate: none. The remaining blockers are branch and PV
semantics, not enumeration or compilation.
