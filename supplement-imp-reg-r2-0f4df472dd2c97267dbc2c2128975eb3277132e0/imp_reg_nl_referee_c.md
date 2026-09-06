# IMP-001-REG-R2 supplemental natural-language review — referee C

## Binding and verdict

- Reviewer: `/root/imp_reg_nl_referee_c`
- Model/runtime: `gpt-5.6-sol`, Codex desktop multi-agent runtime
- Rubric/perspective: `mathematical_correctness` / `analytic_regression_proof_correctness`
- Pending envelope: `pending-envelope.yaml`, SHA-256 `701b26b3ce0daa1c67183fd38c72f610190a4016966be1894e1eaf1face41f00`
- Candidate: `blueprint/proofs/IMP-001-REG-R2.md` (`NLP-IMP-001-REG-R2`, revision 2), SHA-256 `316fc09bf3f35a5649f951ea0964ed1330e540d028a48c4706312d37c87ae7e9`
- Candidate commit: `0f4df472dd2c97267dbc2c2128975eb3277132e0`
- Verdict: **approve**
- Findings: none

The machine-readable verdict bound to this report is
`IMP-001-REG-R2-natural_language_review-imp_reg_nl_referee_c.json`, SHA-256
`48a36b67d7acfbd6f6ccbbccb490779c250149afd9b1d195605d834b3726d42e`.
That verdict retains the template's exact core and companion identities. It
counts only toward the R2 supplemental review requirement, counts zero toward
the completed core pre-Lean quorum, and has
`authorization_effect: none_without_root_adjudication`.

## Isolation and review boundary

I manually attest to a fresh delegated review context and an independent
mathematical rederivation. I created the detached worktree
`/tmp/imp-reg-r2-referee-c.Fj1r8q` directly from the supplied repository and
verified its `HEAD` as exactly
`0f4df472dd2c97267dbc2c2128975eb3277132e0`; `git status` reported detached
`HEAD` and no worktree changes. The resolved Mathlib source checkout was
independently verified at
`0df444a360eaa60ab8c11dca51a86af692955474`, and `lean-toolchain` contained
`leanprover/lean4:v4.33.1`.

Isolation strength is `manual_attestation`, not technical sandboxing: the
agent ran on a shared host filesystem. I treated the candidate and dependency
sources as read-only. I did not read a peer supplemental review, the R1
companion, an R1 disposition, or any predecessor/historical verdict or report.
I did not inspect current production IMP code or tests, uncommitted candidate
files, QL/OLV implementations, source-coverage work, or numerical work. The
permitted immutable core envelope and root adjudication were read only to
confirm the bound authority and its expressly limited effect; no core review
conclusion was inherited.

I read the four external instructions/template files in full, the complete
1,357-line R2 artifact, the bound core contracts and relevant full-context core
proof sections, and only the pinned Mathlib sources needed for the named
declarations and supporting translation facts. I made no Lean proof or
elaboration attempt on the new mathematics, ran no CI, and made no candidate
edit, commit, or push. No subagent was used.

## Independent mathematical audit

### Base estimates and conditional convergence

REG.9 has the correct sign. Differentiating
`-cos u / u` gives `sin u / u + cos u / u^2`; hence

\[
 \int_A^B \frac{\sin u}{u}\,du
 =\frac{\cos A}{A}-\frac{\cos B}{B}
  -\int_A^B\frac{\cos u}{u^2}\,du.
\]

For `1 ≤ A ≤ B`, the three terms give exactly `2/A`, including cancellation
of the two `1/B` contributions. This is sufficient for the two-sided Cauchy
estimate of `H(R)` at `atTop`. The correction integral has the stated exact
bound `1/(2A^2)-1/(2B^2)`, so the cutoff tail bound
`2/A + 1/(2A^2)` and the existence and uniqueness characterization of `L_Q`
are valid.

On
`J_n = [n*pi + pi/6, n*pi + 5*pi/6]`, the reduction modulo `n*pi` gives
`|sin u| ≥ 1/2`, the denominator obeys `u ≤ (n+1)pi`, and the interval length
is `2pi/3`. Therefore REG.12 is exactly `1/(3(n+1))`. The dyadic blocks have
`2^j` terms, each at least `1/(3*2^(j+1))`, so each block contributes at least
`1/6`. This proves divergence of the norm integral, not merely conditional
oscillation. Since `1-u^(-2) ≥ 1/2` for `u ≥ sqrt 2`, the same proof transfers
to the cutoff absolute tail. The conclusions used in R05, R06, and the
negative R22 example therefore correctly distinguish ordinary convergence
from Bochner `IntegrableOn`.

### Substitution ledger, orientations, and absolute values

Pinned source inspection confirms that
`intervalIntegral.integral_comp_mul_deriv'` has precisely the three premises
recorded in REG.19a:

1. `HasDerivAt f (f' x) x` for every `x ∈ uIcc a b`;
2. `ContinuousOn f' (uIcc a b)`; and
3. `ContinuousOn g (f '' [[a,b]])`.

Its conclusion is the oriented identity
`∫ x in a..b, (g ∘ f) x * f' x = ∫ x in f a..f b, g x`.
The companion correctly uses continuity only on the direct image of the
unoriented interval, not global continuity.

For the reciprocal map `x ↦ 1/x` with oriented endpoints `1 → delta`, the
Jacobian is `-x^(-2)`, the image endpoints are `1 → 1/delta`, and direct
algebra gives

\[
 (G\circ\phi)(x)(-x^{-2})=-r(x).
\]

Thus the left side is `∫_1^delta -r = ∫_delta^1 r`; no sign or absolute
Jacobian is lost. Replacing `r,G` by `|r|,G_abs` gives the same negative
Jacobian and orientation, so the absolute-integral equality is also exact.
For the left half, reflection `t ↦ c-t` has derivative `-1` and endpoint image
`1 → delta`; reversing that orientation again yields `∫_delta^1 r`. The
translation, reciprocal, and reflection image sets and all their local
continuity premises are correctly stated, including endpoint values. REG.19
and REG.20 therefore both equal `Q(1/delta)` with the claimed sign.

The open-ray translation for R22 is mathematically valid: `t ↦ t-k` maps
`Ioi k` bijectively and measure-preservingly to `Ioi 0`, and
`s_k(u+k)=exp(-u)/sqrt u` there. The pinned import closure contains the
measure-preserving/integral translation support (including the additive
translation generated from `integral_mul_right_eq_self` and
`MeasurePreserving.integrableOn_comp_preimage`), while REG-M02 supplies the
stated compact identities.

### Individual regressions

- **IMP-R04.** The antiderivative `log |x| - x^2/2` gives the displayed left
  value `log delta + (1-delta^2)/2` and right value
  `-log delta - (1-delta^2)/2`. They diverge independently to opposite
  infinities while their symmetric sum is identically zero. T01 therefore
  rejects every finite proposed value despite the genuine principal value.

- **IMP-R05.** Both one-sided components equal `Q(1/delta)` and tend
  independently to `L_Q`; the initial zero padding and final zero tail yield
  the exact T01 sum `2L_Q`. The piecewise `P_c` has left and right limit
  `L_Q` at `c`, agrees at both cutoff endpoints, satisfies every regular
  increment, is normalized at `c-2`, and is eventually `2L_Q`. Each punctured
  absolute side contains a divergent reciprocal tail, so every neighborhood
  across `c` fails local `IntegrableOn`.

- **IMP-R06.** On every `[1,R]`, the restriction of `d` is continuous and its
  integral is `H(R)`, yielding T01 at `L_D` for empty `S`. The harmonic lower
  bound proves failure of whole-ray `IntegrableOn`; no totalized set-integral
  value is asserted.

- **IMP-R07.** The empty-list body of the exact frozen T01 definition really
  projects `IntervalIntegrable f volume k b` for every `b ≥ k`, separately
  from its `atTop` limit. `intervalIntegral.integral_undef` confirms that a
  totalized equality cannot provide this field. The section stays within the
  frozen core projection and claims no new analytic authorization.

- **IMP-R11.** `F_J` is constant on every closed regular interval disjoint
  from `{1}`, normalized at zero, and fails only the required continuity.
  The weighted primitive has exact Ioi integral `e^(-1)>0` and vanishing
  boundary, whereas the weighted integrand is identically zero and can have
  only T01 value zero. The uncancelled jump and REG.36 are correct.

- **IMP-R12.** `F_B(1)-F_B(0)=0` but the intermediate increment at `1/2` is
  `1/4`, so it cannot populate T05 for `g_B=0`. For every `h>0`,
  `exp(-ht)t(1-t)` is continuous, nonnegative, and positive on `(0,1)`;
  its integral, and hence its `h` multiple, is strictly positive. This
  contradicts the zero left side and zero boundary terms of the Abel identity.

- **IMP-R13.** The clipped ramp is continuous, normalized, bounded by one,
  and its interval increments equal the closed-interval indicator integral in
  every crossing configuration. Its one-sided slopes at both 1 and 2 differ.
  For arbitrary `h>0`, exponential domination gives both T06 tail premises.
  Direct integration gives
  `(exp(-h)-exp(-2h))/h^2`, hence T06 gives the exact value
  `(exp(-h)-exp(-2h))/h`. No derivative premise is used, and the companion
  correctly leaves the `a=b` and `h=0` algebra to the core proof.

- **IMP-R22.** On `u>0`, `u^(-1/2)=1/sqrt u`, so the translated integrand is
  exactly the Gamma integrand at parameter `1/2`. Gamma convergence proves
  honest Ioi integrability, Gamma equality gives the value, and Gamma
  positivity makes it strictly positive. The elementary bounds by
  `u^(-1/2)` near zero and `exp(-u)` after one independently validate the two
  integrability regions. Conversely, `n_k` has the finite conditional
  endpoint limit `L_Q` but its norm integral diverges on `[k,k+1]`, defeating
  both the empty-S T01 compact-integrability field and T07's Ioi premise.

- **IMP-R24.** `A={k}∪S` is finite and volume-null. Equality off `A` produces
  global a.e. equality and a.e. equality under every interval and Ioi
  restriction. The pinned congruence lemmas therefore preserve interval
  integrability, oriented interval integrals, Ioi integrability, and Ioi set
  integrals even when replacement values at all points of `A` are unrelated.
  For each fixed `F`, every non-integrand T05 clause is literally unchanged
  and every increment clause transfers. Existentially quantifying the same
  `F` transfers the full right side of T08; applying the two directions of
  the frozen T08 gives T01 equivalence. T07's above-`k` condition is unchanged,
  and its honest value transfers by the Ioi congruences. The reasoning also
  handles empty `S` and invalid-domain `S`, for which both predicates remain
  false for the same reason.

### Exact pinned declarations

At Mathlib revision `0df444a360eaa60ab8c11dca51a86af692955474`, I located
all REG-M01 through REG-M13 declarations in the stated defining files and
checked their usable types. In particular:

- the integration-by-parts theorem requires continuity of both functions,
  two-sided derivatives on the interval interior, and interval integrability
  of both displayed derivatives, exactly available in REG-I01;
- the FTC theorem requires ordered endpoints, continuity of the primitive,
  derivatives on the open interval, and interval integrability of the
  derivative;
- `Real.GammaIntegral_convergent` proves `IntegrableOn` of
  `exp(-x) * x^(s-1)` on `Ioi 0` for `0<s`,
  `Real.Gamma_eq_integral` identifies the same set integral, and
  `Real.Gamma_pos_of_pos` supplies the strict sign;
- `intervalIntegrable_congr_ae` and `integrableOn_congr_fun_ae` are
  equivalences under equality for the appropriate restricted measures;
  `intervalIntegral.integral_congr_ae` and `setIntegral_congr_ae` give the
  required integral equalities without an integrability premise;
- `MeasureTheory.setIntegral_pos_iff_support_of_nonneg_ae` explicitly requires
  nonnegativity a.e. and honest `IntegrableOn`, both supplied in R12/R22; and
- the log/exp limit declarations and the four sine declarations have the
  direction and domains used in the text.

## Scope conclusion

The regression map reaches exactly the nonpublic mathematical content listed
for IMP-R04, R05, R06, R07, R11, the analytic endpoint-law part of R12, the
nondifferentiable-example part of R13, R22, and R24. The functions and endpoint
values are globally defined; all convergence, divergence, measurability,
compact integrability, strict positivity, and null-set transports needed by
those conclusions are present. I found no hidden principal-value semantics,
no absolute-integrability strengthening, no changed public premise, no ninth
public target, no current implementation claim, and no source or numerical
scope claim.

Accordingly, there is no material mathematical or pinned-API issue requiring a
change to the exact frozen R2 bytes. This approval can support only a later
root adjudication about the reviewed nonpublic analytic regressions; it does
not reopen or approve the core gate and does not itself authorize Lean
formalization.
