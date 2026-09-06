# Independent mathematical referee report: NLP-IMP-001-REG-R1

## Verdict

**Request changes.** The analytic examples and counterexamples are mathematically
correct and reach the regression conclusions claimed for IMP-R04, R05, R06,
R07, R11, the analytic part of R12, the analytic part of R13, R22, and R24.
However, the exact pinned-dependency ledger names the wrong change-of-variables
declaration for REG.19--REG.20. This is a concrete, localized, fixable P2 defect
in an expressly required part of the review surface.

This verdict applies only to the supplemental natural-language analytic
regression companion. It does not reopen or replace the passed core pre-Lean
gate, does not assess production Lean, and grants no formalization authority
without a later root adjudication.

## Identity, binding, and isolation

- Reviewer: `/root/imp_reg_nl_referee_a`, agent, model `gpt-5.6-sol`, running as
  a Codex desktop sub-agent.
- Isolation strength: `manual_attestation`. I worked in this fresh delegated
  reviewer context and independently created detached worktree
  `/tmp/imp-reg-ref-a.WK3BnC/yo` at exact commit
  `9b3ad2e903bb182cafe8d7c13e7cbfe80f8538b7` using `mktemp -d` and
  `git worktree add --detach`.
- Candidate treatment: read-only. The detached worktree remained clean. I did
  not inspect production IMP code or tests, did not run Lean on the proposed new
  mathematics, and did not invoke CI, commit, or push.
- Peer context: I did not read either peer supplemental review or any historical
  referee report. The permitted immutable core lean-ready envelope and root
  adjudication necessarily contain administrative references to historical
  verdicts; I did not open those referenced reports or use their conclusions as
  mathematical evidence.
- The pending envelope hash was independently confirmed as
  `fd13506194ddc37dbf8b5c5fe8e8f0380ac58981c030370b3c7909ceb53e0ba1`.
  The companion and every bound core artifact matched the digest recorded in
  that envelope. The pinned Mathlib checkout used for source inspection was
  independently confirmed at
  `0df444a360eaa60ab8c11dca51a86af692955474`.
- This narrative is paired with the filled verdict record
  `IMP-001-REG-natural_language_review-imp_reg_nl_referee_a.json`, SHA-256
  `456537d54e80dabd3eccbfa648a329fd7cf4ef64e551606b3bb75bc04f0b7cfa`.

## Mathematical rederivation

### Shared Dirichlet and cutoff arguments

REG.9 has the correct sign: differentiating `-cos(u)/u` gives
`sin(u)/u + cos(u)/u^2`. The endpoint terms and the integral of `u^-2` yield
the stated sharp-enough bound `|D(A,B)| <= 2/A`. This gives the Cauchy property
of the finite integrals and hence the unique finite limit `L_D`.

The non-`L^1` proof is also sound. On each
`J_n = [n*pi+pi/6, n*pi+5*pi/6]`, the absolute sine is at least `1/2`, the
denominator is at most `(n+1)pi`, and the interval length is `2pi/3`, giving
exactly `1/(3(n+1))`. The dyadic blocks contribute at least `1/6` each, so the
norm integral is unbounded. The cutoff correction is absolutely Cauchy with
tail at most `1/(2A^2)`; subtracting it preserves conditional convergence, and
the factor `1-u^-2 >= 1/2` beyond `sqrt(2)` transfers absolute divergence.

The reciprocal Jacobian and orientations in REG.19--REG.20 are correct:
`dx = -u^-2 du`, and evenness of `q_c` makes the left and right expressions
identical. This mathematical conclusion is separate from the dependency-ledger
defect recorded below.

### Regression-by-regression result

- **IMP-R04:** The displayed antiderivative `log|x| - x^2/2` gives the left
  divergence to `-infinity` and right divergence to `+infinity` with the stated
  signs. Equal cutoffs cancel exactly, but neither required independent T01
  side has a finite limit. The universal rejection in REG.25 follows.
- **IMP-R05:** Both sides of the even cutoff model converge independently to
  `L_Q`; the final atTop piece is zero and the exact component sum is `2L_Q`.
  The piecewise `P_c` has matching value and limits `L_Q` at `c`, is normalized
  at `c-2`, satisfies every regular-piece increment, and is eventually
  `2L_Q`. Absolute reciprocal substitution gives divergence in every
  neighborhood of `c`, so the example is genuinely conditional.
- **IMP-R06:** For every finite truncation from `1`, the function agrees with
  `sin(t)/t` and is interval integrable. Its integrals tend to `L_D`, while the
  norm-integral lower bound proves failure of `IntegrableOn (Ioi 1)`. This
  correctly separates T01 from absolute integrability.
- **IMP-R07:** Unfolding only the frozen empty-break semantics yields precisely
  the regular-truncation `IntervalIntegrable` projection plus the atTop limit.
  A totalized interval-integral value cannot supply the omitted integrability
  proposition. This is consistent with the core-owned type-shape regression
  and asserts no new analytic authorization.
- **IMP-R11:** With the specified value `F_J(1)=0`, all regular-component
  increment laws, normalization, the domain condition, and both weighted-tail
  conditions hold, but continuity fails at `1`. The weighted primitive integral
  is `e^-1 > 0`, whereas the weighted zero integrand has only T01 value zero.
  Thus the deleted-continuity conclusion is false by exactly the jump term.
- **IMP-R12 (analytic part):** Endpoint matching holds for `g_B=0`, while the
  increment at `b=1/2` is `1/4` rather than zero. For every `h>0`, the weighted
  primitive is integrable and strictly positive on `(0,1)`, so the proposed
  Abel identity would equate zero with a positive number.
- **IMP-R13 (analytic part):** The clipped ramp is continuous, normalized,
  bounded, eventually constant, and its increments equal the integral of the
  closed-interval indicator; endpoint values are null-set irrelevant. Its
  one-sided slopes differ at both corners. For every `h>0`, exponential
  domination gives the two T06 tail hypotheses. Direct integration confirms
  `(exp(-h)-exp(-2h))/h^2` for the weighted primitive and therefore
  `(exp(-h)-exp(-2h))/h` for the weighted indicator. I did not reassess or claim
  ownership of the private `a=b` or `h=0` algebra.
- **IMP-R22:** Translation reduces the positive endpoint model to the real
  Gamma integrand at parameter `1/2`; integrability, exact value, and strict
  positivity follow. The elementary local `u^-1/2` and exponential-tail bounds
  independently confirm the integrability mechanism. The one-sided conditional
  model has limit `L_Q` but fails interval and ray Bochner integrability, so the
  unmarked initial endpoint correctly rejects it.
- **IMP-R24:** Equality away from `{k} union S` gives global and restricted a.e.
  equality because that set is finite and null. It transports interval
  integrability, all interval integrals, ray integrability, and ray set
  integrals. For the same fixed `F`, every non-integrand T05 clause is unchanged
  and each increment equation is preserved, yielding the fixed-`F` equivalence.
  Existential quantification and the frozen T08 equivalence then give full T01
  invariance for every value `I`; T07 is transported honestly using the
  separate integrability equivalence. This remains valid when the domain
  condition fails, since it fails identically on both T01 sides.

The global definitions, support descriptions, endpoint assignments,
measurability assertions, compact regular-piece integrability, strict
inequalities, and quantifier dependencies are consistent with these proofs.
The regression map adds no public target or premise, makes no source or
numerical claim, and does not treat current implementation as evidence.

## Finding

### A-REG-M02-001 — P2 — exact substitution API has an undischarged global-continuity premise

**Location:** `blueprint/proofs/IMP-001-REG.md`, dependency row REG-M02 at line
336, used by the substitution discussion at lines 546--568.

**Evidence:** At pinned Mathlib revision
`0df444a360eaa60ab8c11dca51a86af692955474`,
`intervalIntegral.integral_comp_mul_deriv` in
`Mathlib.MeasureTheory.Integral.IntervalIntegral.IntegrationByParts` requires
`Continuous g` on all of `Real`. The companion discharges only continuity on
the finite image interval and explicitly says that every transformed integrand
is continuous on `[1,1/delta]`. The naturally substituted functions are not
globally continuous: the reciprocal expression has a singularity at zero, and
`q_c` is not continuous at `c`. Thus the exact declaration named in REG-M02 is
not directly usable from the hypotheses supplied by the companion.

The same pinned source provides
`intervalIntegral.integral_comp_mul_deriv'`, whose integrand hypothesis is
`ContinuousOn g (f '' [[a,b]])`, as well as the more general local variants.
Those match the stated compact-away-from-zero argument.

**Required fix:** Issue a successor of the frozen companion that changes
REG-M02 to a suitable local-continuity substitution declaration (most directly
`intervalIntegral.integral_comp_mul_deriv'`) and states the corresponding
image-continuity and derivative side conditions for the translation and
reciprocal maps. Alternatively, explicitly construct and justify globally
continuous extensions and retain the non-prime theorem. The mathematical
identities REG.19--REG.20 need not change.

## Dependency and scope conclusion

All other declarations in REG-M01 and REG-M03--REG-M13 were found at the
pinned Mathlib revision in the stated defining modules with types suitable for
their described roles. In particular, the Gamma convergence/value/positivity
triple, finite-set nullity and all a.e.-congruence declarations, totalization
guard, logarithmic and exponential limit lemmas, positivity criterion, and
sine identities are available.

Because the defect is a wrong exact API binding rather than a false analytic
identity, it is localized and readily repairable. Nevertheless, the review
instructions require every cited pinned declaration to have a usable type, so
the present frozen bytes should not be approved for later regression
formalization. The core eight-target `lean_ready` authority remains unchanged.
