# DLMF §4.7 referee-2 report

## Snapshot and files reviewed

- Snapshot: 703f1ad1d96c360bbac555c43dc39f6ca64d1a7b.
- Official source: DLMF §4.7 (https://dlmf.nist.gov/4.7), including its logarithm and exponential/power subsections.
- Source inventory: coverage/dlmf-4-10-source-inventory.json.
- Lean source: LMLF/Blueprint/Elementary/Section47.lean.
- Documentation: doc/LMLFManual/Chapter4/Section47.lean.
- Manifest: coverage/sections/chapter4-47.json.

## Independently computed expected IDs and verdict

The official page and inventory contain exactly 4.7.E1 through 4.7.E15. The revised manifest and documentation contain exactly that same set, with no omissions or extras.

**Verdict: revise.** The principal slit-plane repairs for E1/E3, explicit branch-domain hypotheses for E10/E11, and branch/solution parameters for the logarithm formulas are present. However, material P1 failures remain in the differential-equation declarations E5/E6 and E12–E15.

## Findings

### P1 — E5 is still an unconstrained, false equation

LMLF/Blueprint/Elementary/Section47.lean:52-54, logarithmicDifferentialEquation, assumes only analyticity and nonvanishing of f, but quantifies an arbitrary w and concludes deriv w z = deriv f z / f z. The hypotheses do not relate w to f; for example, f := fun _ => 1 and w := fun z => z satisfy the hypotheses but contradict the conclusion. This does not express DLMF 4.7.E5.

Repair by tying w to a selected logarithm branch of f (with local HasDerivAt/analytic hypotheses), or by making the displayed differential equation a proposition whose hypotheses include the actual solution relation. Do not leave an arbitrary w under unrelated hf/hnz.

### P1 — E6 lacks the regularity and domain assumptions needed for the constant-difference result

LMLF/Blueprint/Elementary/Section47.lean:59-62, logarithmicSolution, assumes hODE only through totalized deriv and gives no open connected domain or HasDerivAt hypothesis for w. Equality of totalized derivatives does not imply that w - Ln ∘ f is constant, and the conclusion is global even though DLMF explicitly says the solution is local. The documentation at doc/LMLFManual/Chapter4/Section47.lean:112-126 consequently overstates the formal result.

Repair on an explicit open connected domain: require HasDerivAt w and HasDerivAt (fun u => Ln (f u)) with equal derivatives at every point in that domain, then conclude existence of one constant on that domain (or state a pointwise local neighborhood result).

### P1 — E12 asserts every function solves the linear ODE

LMLF/Blueprint/Elementary/Section47.lean:100-101, linearDifferentialEquation, has no hypotheses at all and concludes deriv w z = f z * w z for arbitrary f and w. This is false and is not a reusable statement of DLMF 4.7.E12. The page repeats the false universal claim at doc/LMLFManual/Chapter4/Section47.lean:204-215.

Repair by stating a genuine solution characterization or by supplying explicit HasDerivAt/analytic assumptions that establish the equation for the selected solution. Avoid a theorem whose conclusion is simply an unconstrained ODE.

### P1 — E13 is only a particular-solution check, not DLMF's general solution

LMLF/Blueprint/Elementary/Section47.lean:106-109, linearDifferentialSolution, correctly identifies that an antiderivative F' = f yields C * exp F as a solution, but it does not state the source's “general solution” claim (and the documentation's prose says “solution” without marking this as only a sufficient family). It also uses totalized deriv rather than HasDerivAt regularity.

Repair by labeling this as a sufficient solution family and separately adding a converse/characterization on a connected domain with the needed differentiability and nonvanishing assumptions, or narrow the source relation to an explicitly declared specialization.

### P1 — E14 is the same unconstrained-w error for the second-order ODE

LMLF/Blueprint/Elementary/Section47.lean:114-115, secondOrderExponentialEquation, assumes only a ≠ 0 and quantifies arbitrary w, then asserts the second-order equation. The theorem is false for arbitrary w; the nonzero coefficient does not establish that w is a solution.

Repair by stating the equation for an explicitly defined solution or by making the equation a characterized proposition with genuine differentiability hypotheses. Do not quantify an arbitrary function and assert the ODE.

### P1 — E15 verifies one family but does not formalize the stated general solution

LMLF/Blueprint/Elementary/Section47.lean:120-124, secondOrderExponentialSolution, gives a valid-looking sufficient family under a chosen square root, but does not assert that every solution is of this form, does not state the branch choice as a hypothesis, and does not connect the result to the E14 solution space. The page at doc/LMLFManual/Chapter4/Section47.lean:247-262 calls it “the general solution,” which the declaration does not establish.

Repair by explicitly labeling the declaration as a solution family, or state an iff/general-solution result on a connected domain with a fixed square-root branch and arbitrary constants.

### P2 — E4's local branch domain is still underspecified

generalLog_iteratedDeriv at LMLF/Blueprint/Elementary/Section47.lean:44-47 assumes only point membership z ∈ U and derivative hypotheses for points in U; it does not require U to be open (or supply a neighborhood of z). A local branch statement should use an open domain or a local HasDerivAt hypothesis. This is not a new P0/P1 blocker, but it remains a readability and mathematical-domain improvement.

## Correctly handled items and quantitative pairs

- E1 and E3 now restrict the principal logarithm to Complex.slitPlane, excluding the branch cut and origin.
- E2 uses an explicit HasDerivAt branch hypothesis.
- E7 and E8 correctly state the complex exponential derivative identities.
- E9 retains the nonzero constant-base condition and principal Complex.log.
- E10 and E11 now carry an explicit domain contained in the principal slit plane, and E11 retains the finite descending product.
- E4 retains n > 0, factorial coefficient, and negative-power shape, subject to the P2 domain refinement above.
- No genuinely distinct quantitative declaration is supplied or required by §4.7.

## Verification

- lake build LMLF.Blueprint.Elementary.Section47: passed with permitted sorry warnings.
- From doc/, lake build LMLFManual.Chapter4.Section47: passed with permitted sorry warnings.
- Expected/stated numbered IDs: 15/15; omitted IDs: 0.
- Both source files contain no #check, filler status prose, or proof work displacing coverage.
- No rendered page was available for an additional visual anchor inspection.
