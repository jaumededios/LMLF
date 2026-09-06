# IMP-001 analytic-regression companion — independent referee B

Reviewer: `/root/imp_reg_nl_referee_b`  
Model/runtime: `gpt-5.6-sol`, Codex desktop sub-agent runtime  
Issued: 2026-09-06T16:40:36Z  
Verdict: **request_changes**

## Binding, isolation, and scope

I reviewed `NLP-IMP-001-REG-R1` only. I created the independent detached worktree `/tmp/imp-reg-b.WwSyBT` from `/workspace/Documents/Codex/2026-09-05/yo` and verified its `HEAD` as `9b3ad2e903bb182cafe8d7c13e7cbfe80f8538b7` with an empty porcelain status. The companion SHA-256 is `c10dcbc498d80b98f24473a367546963c0b9d6713d99e73e21fd834ff8eedd4c`; all packet, theorem-card, R7 proof, R6-P2 signature, classification, manifest, core lean-ready-envelope, core adjudication, pending-envelope, and template digests matched their bindings. The pinned Mathlib checkout is clean at `0df444a360eaa60ab8c11dca51a86af692955474`; Lean reports version 4.33.1.

Isolation strength is `manual_attestation`. I began in a fresh assigned context, am independent of the proposer, treated the candidate checkout as read-only, and did not read any peer or historical referee report. I did not inspect production IMP code or tests, QL, OLV, source-coverage, or numerical implementations. I ran no Lean proof attempt for the new mathematics, no CI, no commit, and no push. Generic referee workflow instructions affected only review organization and were not used as mathematical evidence.

The review does not reopen the already-passed core pre-Lean gate, grants it no additional credit, and does not assess production implementation. R07 was checked only against the frozen core semantics. R13 was checked only for the new nondifferentiable analytic example; the private `a=b` and `h=0` algebra remains core-owned.

## Independent mathematical rederivation

- **Definitions and regularity.** The cutoff `chi(x)=max(1-x^2,0)` has the stated support. With the declared point values, `p_c` is odd, `q_c` is even, and both have support `[c-1,c+1]`. The tail, square-root, one-sided conditional, jump, bump, indicator, and clipped-ramp examples have the stated domains, supports, endpoint values, and Borel measurability. On every compact regular component, boundedness away from the displayed singularity gives honest interval integrability; no argument crosses an unmarked non-`L1` singularity.
- **Dirichlet base and constants.** Differentiating `-cos(u)/u` gives `sin(u)/u+cos(u)/u^2`, so REG.9 and the exact bound `|D(A,B)| <= 2/A` follow. This is a genuine Cauchy modulus for `H(R)` and determines the unique finite `L_D`. The correction has bound `1/(2A^2)`, giving the stated modulus for `Q` and the unique `L_Q`.
- **Failure of absolute integrability.** On each `J_n`, the trigonometric identities imply `|sin u| >= 1/2`; its length is `2pi/3` and `u <= (n+1)pi`, giving exactly `1/(3(n+1))`. Dyadic blocks contribute at least `1/6`, so the norm integral is unbounded. The factor `1-u^-2 >= 1/2` for `u>=sqrt(2)` transfers this to the cutoff tail. These are honest non-`L1` arguments, not deductions from sign oscillation or totalized values.
- **Substitutions.** The signs and Jacobian in REG.19 and REG.20 are correct: `u=1/x` contributes `-u^-2 du`, and reversal of limits gives the displayed positive orientation. The absolute-value substitution is likewise exact. Translation sends `(k,infinity)` to `(0,infinity)`, and on `u>0`, the square-root integrand is the Gamma integrand at parameter `1/2`.
- **R04.** The antiderivative `log|x|-x^2/2` gives the displayed left limit `-infinity` and right limit `+infinity`, while their symmetric sum is identically zero. Thus principal-value convergence cannot satisfy either independent T01 endpoint limit.
- **R05.** Each side equals `Q(1/delta)` and tends independently to `L_Q`; with the zero tail, the exact T01 value is `2L_Q`. The piecewise `P_c` has matching value `L_Q` at the singularity, is continuous, normalized at `c-2`, satisfies every regular T05 increment, and tends to `2L_Q`. Every neighborhood of `c` contains a divergent absolute reciprocal tail, so the example is genuinely conditional.
- **R06 and R07.** For empty `S`, the honest compact truncations of `d` converge to `L_D` while the ray norm integral diverges. The R07 projection is exactly the empty-list conjunct of the frozen T01 definition: it retains `IntervalIntegrable` separately from the limit of totalized interval-integral expressions. It introduces no new mathematics or authorization.
- **R11 and R12.** The jump primitive satisfies normalization and every regular-component increment but fails continuity at the exception. Its weighted primitive has honest integral `e^-1>0` and vanishing boundary, while the weighted zero integrand has only T01 value zero, exposing the uncancelled jump. The compact bump matches only the outer endpoints; at `1/2` its increment is `1/4`. For every `h>0`, its weighted integral is strictly positive, so endpoint matching cannot replace the all-intermediate T05 law.
- **R13.** The clipped ramp is continuous, normalized, bounded, eventually constant, and satisfies the indicator increment law on all interval configurations, including crossings of 1 and 2. Its one-sided slopes disagree at both corners. For `h>0`, exponential domination proves both T06 tail hypotheses, and direct integration gives `(exp(-h)-exp(-2h))/h^2`; multiplication by `h` gives the exact T06 value `(exp(-h)-exp(-2h))/h` without any derivative premise on the primitive.
- **R22.** Translation reduces the positive example to the integrable Gamma integrand at `1/2`, giving the honest positive value `Gamma(1/2)`. The elementary split at 1 independently confirms local `u^-1/2` integrability and exponential tail integrability. The one-sided `n_k` truncations tend to `L_Q`, but their norm integral diverges, so both interval integrability at `[k,k+1]` and ray `IntegrableOn` fail; empty-set T01 and T07 therefore reject it.
- **R24.** `A={k} union S` is finite and volume-null. Equality off `A` gives global and restricted a.e. equality, preserving interval integrability, interval integrals, ray integrability, and ray integrals. For a fixed `F`, all non-integrand T05 fields are identical and the increment field transports by a.e. congruence. Existentially using the same `F` transports the T08 right side; public T08 in both directions then gives T01 invariance without opening the private representation. T07 additionally uses its unchanged explicit domain condition and honest integrability premise.

All constants, signs, endpoint orientations, branch choices, strict inequalities, and null-value conventions above are correct. The examples do not select functions from target conclusions, do not infer convergence from totalization, do not launder absolute integrability into conditional cases, and do not introduce a public target, changed public premise, source claim, numerical scope, or representation-level consumer dependency.

## Pinned API audit

The pinned source contains the cited integration-by-parts, FTC, derivative, exponential-decay, Gamma, a.e.-congruence, finite-null-set, totalization, positivity, logarithmic-limit, exponential-limit, and trigonometric declarations with types suitable for their stated uses. In particular, the Gamma theorem is honest `IntegrableOn` on `Ioi 0`, the positivity theorem also requires that honest integrability internally, and the interval/set congruence theorems preserve integrability separately from totalized integral equality.

One cited substitution API does not match the hypotheses actually supplied by the companion, as recorded below.

## Finding

### B1 — P2 — substitution citation requires an unstated global extension

**Location:** `blueprint/proofs/IMP-001-REG.md`, REG-M02 at line 336 and the justification at lines 544–568.

**Evidence:** At the pinned revision, `intervalIntegral.integral_comp_mul_deriv` in `Mathlib/MeasureTheory/Integral/IntervalIntegral/IntegrationByParts.lean` has a final premise `Continuous g`, i.e. global continuity. The reciprocal substitution naturally takes

`g(u) = (1-u^-2) * sin(u) / u`,

which is only used and continuous on the image interval `[1,1/delta]` and is not globally continuous at zero. The companion proves exactly this compact-image continuity at lines 567–568, not the global premise of the cited unprimed theorem. The adjacent pinned declaration `intervalIntegral.integral_comp_mul_deriv'` instead requires `ContinuousOn g (f '' [[a,b]])`, which matches the stated argument. Equivalently, the unprimed theorem could be retained only after explicitly constructing a globally continuous extension agreeing with the transformed integrand on the image and applying integral congruence. No such extension is defined or justified in the frozen proof.

**Required fix:** Replace REG-M02 by the exact locally continuous declaration `intervalIntegral.integral_comp_mul_deriv'` and state how its derivative, derivative-continuity, and image-continuity premises discharge both orientations of REG.19–REG.20 (and the absolute-value version), or add the explicit global continuous extension and congruence argument needed by the currently cited theorem. Re-freeze and rehash the companion before review. This is a bounded proof/API repair; the displayed substitution identities and all downstream mathematics remain correct.

There are no P0, P1, or P3 findings. Because the review instructions require every cited pinned declaration to have a usable type for its claimed proof step, B1 prevents approval of the present frozen bytes but does not block a corrected successor.

## Scope disposition

The companion otherwise matches the frozen T01/T05/T06/T07/T08 semantics exactly, preserves independent endpoint limits and honest integrability requirements, uses T08 as the representation-independent R24 route, and keeps all proposed regression declarations nonpublic. My verdict counts only toward the supplemental regression natural-language review and has `none_without_root_adjudication` authorization effect.
