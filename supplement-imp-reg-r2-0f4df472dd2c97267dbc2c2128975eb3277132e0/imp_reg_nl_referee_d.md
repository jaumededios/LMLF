# Independent natural-language mathematical review: IMP-001-REG-R2

## Verdict

**Approve**, with no findings.

Exact verdict JSON binding:
`IMP-001-REG-R2-natural_language_review-imp_reg_nl_referee_d.json`, SHA-256
`eac147c1fe49bfd8751b310df60502b28baf0036856049b5858b2f665de9b7b7`.

This verdict covers only the supplemental R2 natural-language gate for the
nonpublic analytic regressions bound by `pending-envelope.yaml`. It contributes
no credit to the completed core pre-Lean gate, changes no core authority, and
has no authorization effect without the required root adjudication.

## Identity, binding, and isolation

- Reviewer: `/root/imp_reg_nl_referee_d`.
- Model: `gpt-5.6-sol`, supplied by the explicit parent dispatch metadata; the
  runtime environment did not independently expose the deployment identifier.
- Runtime: Codex desktop collaboration agent on a shared Linux host, reasoning
  effort `high`, dispatched with `fork_turns: none`.
- Isolation strength: `manual_attestation`. There was no technical filesystem
  sandbox isolating this reviewer from other agents.
- Independent checkout: `/tmp/imp-reg-r2-ref-d.SX1ZJT/checkout`, created with
  `git worktree add --detach` from
  `/workspace/Documents/Codex/2026-09-05/yo` at exact commit
  `0f4df472dd2c97267dbc2c2128975eb3277132e0`. Its status was clean and detached.
- The candidate checkout was treated read-only. The only files created are this
  report and its bound verdict JSON in the external supplemental directory.
- I did not open current production IMP Lean or tests, the R1 proof, peer R2
  reports, predecessor referee reports or verdicts, or historical referee
  reports or verdicts. Administrative references appearing inside the required
  frozen core artifacts were not followed.
- I did not delegate any part of the review and did not run Lean, build, CI,
  numerical, QL, OLV, source-coverage, or implementation checks.

The pending envelope rehashed to
`701b26b3ce0daa1c67183fd38c72f610190a4016966be1894e1eaf1face41f00`.
The companion rehashed to
`316fc09bf3f35a5649f951ea0964ed1330e540d028a48c4706312d37c87ae7e9`.
All packet, card, R7 proof, R6-P2 signature, classification, manifest, immutable
core envelope, and core adjudication digests matched the exact values in the
pending envelope. The pinned Mathlib checkout was clean and detached at
`0df444a360eaa60ab8c11dca51a86af692955474`.

## Full mathematical review

I independently read and checked all 1,357 lines of
`blueprint/proofs/IMP-001-REG-R2.md`, not only its R2-specific substitution
discussion. I also read the complete frozen work packet, theorem card, R7 proof,
R6-P2 signature artifact, classification schema, core lean-ready envelope, and
core adjudication needed to fix the exact T01/T05/T06/T07/T08 semantics.

### Shared analytic base and exact functions

The global definitions of \(\chi,p_c,q_c,d,s_k,n_k,g_J,F_J,g_B,F_B,g_I,F_I\)
are unambiguous at every real input. Their stated parity, endpoint values,
outside-domain behavior, and topological supports are correct. In particular,
the zeros of the oscillatory functions do not shrink their supports, since
nonzero points occur in every neighborhood inside the claimed closed support.
The piecewise-continuity/Borel arguments establish strong measurability, and
boundedness on compact intervals separated from the displayed singularity gives
all regular-piece Bochner integrability used by R04 and R05.

For the Dirichlet base, differentiating \(-\cos u/u\) gives the stated
integration-by-parts identity and the bound
\(|D(A,B)|\le 2/A\). This is a valid Cauchy modulus at infinity. The harmonic
test intervals have length \(2\pi/3\), lie in the positive ray, have pairwise
disjoint interiors, and satisfy \(|\sin u|\ge 1/2\); hence their contribution is
at least \(1/(3(n+1))\). The dyadic-block lower bound is correct and proves
failure of norm integrability, not merely oscillation. The cutoff correction
has the stated \(1/(2A^2)\) tail bound, so \(Q\) converges, while the factor
\(1-u^{-2}\ge 1/2\) beyond \(\sqrt2\) correctly transfers absolute divergence.

### Change of variables

The corrected binding to
`intervalIntegral.integral_comp_mul_deriv'` is exact. At the pinned revision its
hypotheses are precisely: `HasDerivAt` on `uIcc`, continuity of the derivative
there, and `ContinuousOn` of the outer integrand on the direct image of that
unoriented interval. The companion checks all three hypotheses for every use.

For translation, the image is exactly \([\delta,1]\). For reciprocal inversion,
the oriented endpoints are \(1\) and \(\delta\), the unoriented domain is
\([\delta,1]\), the image is \([1,1/\delta]\), and the derivative is
\(-x^{-2}\). Direct calculation gives
\((G\circ(1/x))(-x^{-2})=-r(x)\); reversing the interval orientation therefore
produces the positive \(\int_\delta^1r\) and the displayed right-side formula.
Reflection on the left has derivative \(-1\); its orientation reversal and the
evenness of \(q_c\) produce the same positive formula. The identical calculation
for `abs` is valid because both absolute-value outer functions are continuous on
the exact images, which stay away from zero. Thus REG.19--REG.20 have the right
Jacobian and signs in both orientations, including the absolute-value forms.

The R22 translation also has no hidden endpoint problem: compact translations
meet the same local hypotheses, while Lebesgue translation invariance transfers
both `IntegrableOn` and the open-ray set integral; the omitted endpoint is null.

### Regression-by-regression conclusions

- **IMP-R04:** The two antiderivative evaluations have the correct signs. The
  left component tends to \(-\infty\), the right component to \(+\infty\), and
  their synchronized sum is identically zero. T01 therefore fails for every
  finite value despite a genuine symmetric principal value.
- **IMP-R05:** Both independent singular-side limits equal the uniquely defined
  \(L_Q\), the final anchored tail is zero, and the exact T01 sum is \(2L_Q\).
  The piecewise primitive \(P_c\) has matching limits at \(c\), agrees at the
  cutoff endpoints, is normalized at \(c-2\), satisfies every regular increment,
  and tends to \(2L_Q\). The absolute reciprocal tails rule out `IntegrableOn`
  on every neighborhood of \(c\).
- **IMP-R06:** For every finite truncation the restriction of \(d\) to
  \([1,R]\) is continuous and interval integrable, and its atTop limit is
  \(L_D\). The harmonic lower bound proves non-`IntegrableOn` on the open ray,
  so neither a totalized whole-ray value nor T07 is used.
- **IMP-R07:** Simplifying the frozen empty-break definition gives exactly the
  asserted `IntervalIntegrable` projection plus the endpoint limit. The
  totalization guard correctly shows that an integral equality or limit cannot
  supply the missing proposition. This is consistent with the frozen core and
  makes no new supplemental Lean-authorization claim.
- **IMP-R11:** The jump primitive satisfies the above-start condition,
  normalization, regular integrability, and every componentwise increment, but
  fails continuity at 1. Its weighted primitive has integral \(e^{-1}>0\) and
  vanishing boundary, whereas the weighted zero integrand has only T01 value
  zero. The uncancelled jump is therefore exactly the required counterexample.
- **IMP-R12:** Endpoint matching holds but the increment at \(1/2\) fails. For
  every \(h>0\), the weighted bump is integrable, nonnegative, and positive on
  a positive-measure interval, so the Abel right-hand contribution is strictly
  positive while the other terms vanish.
- **IMP-R13:** The clipped ramp is a continuous normalized T05 primitive for the
  indicator, including all endpoint-crossing interval configurations, and has
  unequal one-sided slopes at 1 and 2. Its exponential domination establishes
  both T06 tail hypotheses for every \(h>0\). Direct integration gives
  \((e^{-h}-e^{-2h})/h^2\), so the T06 value
  \((e^{-h}-e^{-2h})/h\) is correct. The private `a=b` and `h=0` algebra is not
  claimed by this review.
- **IMP-R22:** The positive example is the translated Gamma integrand with
  parameter \(1/2\), is honestly integrable, and has strictly positive integral
  \(\Gamma(1/2)\), so T07 applies. The conditional example has ordinary finite
  endpoint limit \(L_Q\) but divergent norm integral on \([k,k+1]\) and the
  open ray; it consequently fails the empty-set T01 integrability field and T07.
- **IMP-R24:** The update set \(\{k\}\cup S\) is finite and volume-null. Global
  a.e. equality restricts to every unoriented interval and to `Ioi k`, giving
  both integrability equivalences and exact integral equalities. For a fixed
  primitive, every non-integrand T05 field is unchanged and every regular
  increment transports. Existential T08 in both directions then yields T01
  invariance for every proposed value. Under the explicit above-start condition,
  the honest T07 premises and values transport as well. The argument remains
  valid when the domain condition is false, since both relation sides fail for
  the same unchanged reason.

## Pinned Mathlib API review

I inspected the defining pinned sources and exact declaration types for every
REG-M01--REG-M13 entry. All names exist in the stated namespaces and their types
are usable as claimed. This includes the integration-by-parts and local
substitution theorems; FTC; real sine, cosine, exponential, and logarithm
derivatives; exponential-tail integrability; all three Gamma facts; interval,
set, and `IntegrableOn` a.e. congruence; finite-set nullity; interval-integral
totalization; the set-integral positivity equivalence; logarithm and exponential
limits; and the four trigonometric facts used in the harmonic lower bound.

As additional source-level confirmation of the R22 unnamed standard step, the
pinned source provides the additive measure-preserving translation generated
from `measurePreserving_mul_right`, together with
`MeasurePreserving.integrableOn_comp_preimage` and
`MeasurePreserving.setIntegral_preimage_emb`. No claim here depends on a theorem
available only outside the pinned revision.

## Scope and authorization audit

The regression map reaches exactly the nonpublic theorem content enumerated in
REG.25, REG.27--REG.33, REG.34--REG.48, and REG.50--REG.54, subject to the
envelope's partial-scope qualifications for R07, R12, and R13. It introduces no
public target binding, ninth public target, changed public premise, selected
improper-value API, source assertion, numerical scope, production implementation
claim, or production dependency. Supporting Dirichlet lemmas remain private to
the future regression file, and consumer-only Gamma and substitution imports are
not proposed for production IMP modules.

The mathematical and library-scale rubric sections are clear: intent, reusable
support, public API boundary, dependency direction, Mathlib integration, proof
architecture, durability, and refactor risk reveal no actionable finding. Root
adjudication remains required before this approval has any authorization effect.

## Limitations

Isolation is a truthful manual attestation on a shared host, not an enforced
sandbox. API validation was by complete pinned-source inspection rather than by
Lean elaboration, because this review was expressly forbidden from attempting
the new mathematics in Lean. The model identifier comes from the explicit
parent dispatch record rather than a runtime environment variable.
