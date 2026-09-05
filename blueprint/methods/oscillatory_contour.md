# Oscillatory and contour methods

**Document status:** planning blueprint; no packet listed here authorizes Lean  
**Scope:** nonstationary oscillatory integration, conditional improper
integrals, parameterized contour identities and bounds, simple stationary and
saddle models, and later coalescing configurations  
**Dependency rule:** this is a parallel Track B branch and is not on the Watson
critical path

The organizing rule is exact identity first, estimate second, named
specialization last.  Real interval integrals and complex contour integrals
share finite estimate infrastructure, but their regularity and convergence
semantics remain separate.

## 1. Conventions that every card must freeze

- A finite real interval is `[a₀,b₀]` with `a₀ ≤ b₀`; the letter `A`
  denotes a complex-valued amplitude and `φ` a real-valued phase.  The
  frequency `λ : ℝ` satisfies `λ ≠ 0`, or `0 < λ` when its sign enters a
  model formula.
- On a finite interval, integrals are Bochner interval integrals.  A Fresnel,
  Fourier, or stationary-phase integral that is not absolutely integrable is a
  two-sided or one-sided improper limit of finite interval integrals.  It is
  never represented by a silently totalized whole-line Bochner integral.
- A contour is an explicit piecewise `C¹` map `γ : [a₀,b₀] → ℂ` with
  orientation.  Its integral is the parameter integral of
  `γ'(t) • f(γ(t))`.  Reparameterization requires an orientation-preserving
  change of variable; reversal contributes a minus sign.
- Complex powers, square roots, and phases use one stated branch on a domain
  containing the entire contour or homotopy.  Endpoint values, indentation
  sides, and winding are source data, not diagrammatic intuition.
- Parameter differentiation of a moving contour either uses a proved
  fixed-contour representation or includes endpoint-motion and path-motion
  terms.  Holomorphy in the spatial variable alone is insufficient.
- Every generic conditional method is `infrastructure`.  It earns no Olver
  coverage until an exact-source generic theorem or an identified named
  application discharges the phase, contour, branch, and majorant hypotheses.

## 2. Dependency-ordered queue

Every ID in this table is provisional.

| Order | Card | Packet theorem / coverage / novelty class | Bounded content | Dependencies |
|---:|---|---|---|---|
| 1 | OI-001 | `finite_remainder_bound` / `infrastructure` / `equivalent_reformulation` | one-step finite oscillatory integration by parts and sharp first remainder | QB-001 and Mathlib interval integration by parts |
| 2 | OI-002 | `finite_remainder_bound` / `infrastructure` / `generalized` | repeated exact operator identity and recursive derivative constants | OI-001, finite sums |
| 3 | OI-003 | `finite_remainder_bound` / `infrastructure` / `generalized` | improper endpoint-limit version and explicit nonstationary tails | OI-002 |
| 4 | CT-001 | `foundational_calculus` / `infrastructure` / `equivalent_reformulation` | parameterized-curve semantics, orientation, concatenation, length bound | QB-001 and Mathlib curve integrals |
| 5 | CT-002 | `mixed` / `infrastructure` / `generalized` | deformation on an explicit homotopy plus connector estimates | CT-001 and pinned Cauchy/Goursat primitives |
| 6 | SP-001 | `exact_identity` / `infrastructure` / `equivalent_reformulation` | damped Gaussian/Fresnel model moments with the correct improper-limit meaning | QL-002 only for the selected Gamma proof route |
| 7 | SP-002 | `finite_remainder_bound` / `infrastructure` / `novel` | quantitative one-dimensional Morse chart and localized stationary phase | OI-002, SP-001 |
| 8 | SD-001 | `finite_remainder_bound` / `infrastructure` / `novel` | simple complex saddle path with Gaussian decay and explicit local/nonlocal bounds | CT-001, CT-002, SP-001 |
| 9 | COAL-001 | `finite_remainder_bound` / `infrastructure` / `novel` | constructed two-critical-point normal form and uniform bounds | CT-002, SD-001, branch/domain support |

`COAL-001` is deliberately late.  A record whose fields assume the desired
normal form, coefficient bounds, and admissible contour may support a
conditional lemma, but it does not complete this construction packet or any
named application.

The table uses the packet-level v2 axes and is queue shorthand, not a frozen
card.  `exact_identity` describes the pure model-identity scope of SP-001;
`mixed` describes CT-002 because connector bounds accompany its deformation
identity.  A bounded card classifies every declaration separately at the target
level.

### Planned proof artifacts

The first proposed new-mathematics artifact IDs are `NLP-OI-001-R1`,
`NLP-OI-002-R1`, `NLP-OI-003-R1`, `NLP-CT-001-R1`, `NLP-CT-002-R1`,
`NLP-SP-001-R1`, `NLP-SP-002-R1`, `NLP-SD-001-R1`, and
`NLP-COAL-001-R1`.  Each follows
`blueprint/automation/proof_artifact_schema.md`: exact target and source
bindings, quantifier and dependency ledgers, numbered identities, analytic
side-condition and constant-loss ledgers, full target proofs, adversarial
cases, laundering audit, regression list, and trust/import exclusions.  These
names create no artifact and reserve no authorization.

## 3. OI-001 — one nonstationary integration by parts

Assume `a₀ ≤ b₀`, `λ ≠ 0`, \(A:[a_0,b_0]\to\mathbb C\), and
\(\phi:[a_0,b_0]\to\mathbb R\).  The frozen regularity version should use
actual derivative witnesses: `A` is `C¹` and `φ` is `C²` on a neighborhood
of the interval, \(\phi'(t)\ne0\), and the displayed derivative products are
interval integrable.  Define

\[
 L_\phi A=\left(\frac{A}{\phi'}\right)'.
\]

Then prove the exact identity

\[
 \int_{a_0}^{b_0}e^{i\lambda\phi(t)}A(t)\,dt
 =\left[\frac{e^{i\lambda\phi(t)}A(t)}{i\lambda\phi'(t)}
   \right]_{a_0}^{b_0}
 -\frac1{i\lambda}\int_{a_0}^{b_0}
   e^{i\lambda\phi(t)}L_\phi A(t)\,dt. \tag{OC.1}
\]

No endpoint term may be discarded by a compact-support convention unless the
endpoint vanishing theorem is an explicit premise.

For \(L=b_0-a_0\), assume the pointwise controls

\[
 |\phi'|\ge\sigma>0,
 \quad |\phi''|\le P_2,
 \quad |A|\le A_0,
 \quad |A'|\le A_1,
\]

with all four majorants nonnegative.  The quotient rule gives

\[
 |L_\phi A|\le A_1/\sigma+A_0P_2/\sigma^2, \tag{OC.2}
\]

so the remainder following the boundary term in (OC.1) is at most

\[
 \frac{L}{|\lambda|}
 \left(\frac{A_1}{\sigma}+\frac{A_0P_2}{\sigma^2}\right). \tag{OC.3}
\]

The card also exposes the boundary majorant
\(2A_0/(|\lambda|\sigma)\) as a separate corollary.  When `a₀ = b₀`,
both the oriented integral and the endpoint difference are zero.

The natural-language dossier must expand the exponential derivative, quotient
derivative, and interval integration-by-parts hypotheses; prove every
denominator nonzero; derive (OC.2) before applying the integral norm bound; and
check orientation under swapped endpoints.  Two independent pre-Lean reviews
are required: quantitative/integral semantics and API/Mathlib reuse.

## 4. OI-002 — repeated identity with computable constants

Set \(A^{[0]}=A\) and

\[
 A^{[k+1]}=L_\phi A^{[k]}
 =\left(\frac{A^{[k]}}{\phi'}\right)'.
\]

For `m : ℕ`, `A` of class `Cᵐ`, `φ` of class `Cᵐ⁺¹`, `λ ≠ 0`, and
nonvanishing \(\phi'\) on a neighborhood of the interval, prove

\[
\begin{aligned}
 \int_{a_0}^{b_0}e^{i\lambda\phi}A
 &=\sum_{k<m}\frac{(-1)^k}{(i\lambda)^{k+1}}
   \left[e^{i\lambda\phi}\frac{A^{[k]}}{\phi'}\right]_{a_0}^{b_0}\\
 &\quad+\frac{(-1)^m}{(i\lambda)^m}
   \int_{a_0}^{b_0}e^{i\lambda\phi}A^{[m]}.
\end{aligned}\tag{OC.4}
\]

This convention makes `m = 0` the original integral and `m = 1` exactly
(OC.1).

Higher-order constants are not existential.  Put \(q=1/\phi'\).  If
\(|q^{(r)}|\le Q_r\) for `0 ≤ r ≤ m` and
\(|A^{(r)}|\le C_r\), define the finite triangular array

\[
 K_{0,d}=C_d,
 \qquad
 K_{k+1,d}=\sum_{r=0}^{d}\binom dr
 \bigl(Q_{r+1}K_{k,d-r}+Q_rK_{k,d-r+1}\bigr), \tag{OC.5}
\]

for `k+d < m`.  Leibniz's rule proves
\(|(A^{[k]})^{(d)}|\le K_{k,d}\).  Therefore the final remainder in
(OC.4) is bounded by

\[
 (b_0-a_0)K_{m,0}/|\lambda|^m. \tag{OC.6}
\]

The initial reciprocal controls are \(Q_0=1/\sigma\) and
\(Q_1=P_2/\sigma^2\).  A later subtarget may derive higher `Qᵣ` from
explicit derivative bounds for `φ`; it must use a finite recurrence (for example
the differentiated identity \(q\phi'=1\)), not an unnamed Faà-di-Bruno
constant.

The dossier must prove (OC.4) by induction and (OC.5) by a second induction,
with array domains preventing out-of-range derivative requests.  Test `m = 0`,
`1`, and `2`, constant phase derivative, and vanishing endpoint data.

## 5. OI-003 — conditional improper integrals

For an infinite endpoint, first prove (OC.4) on `[a₀,T]`.  Passage
`T → ∞` requires, separately:

1. convergence of the finite-interval integrals to the declared improper
   integral;
2. explicit limits of every boundary expression;
3. integrability or a further conditional-convergence argument for the final
   transformed remainder.

A useful terminal theorem assumes \(A^{[k]}(T)/\phi'(T)\to0\) for `k < m`
and an explicit tail control

\[
 \int_T^\infty |A^{[m]}(t)|\,dt\le E_m(T),\qquad E_m(T)\ge0,
\]

and concludes a remainder at most \(E_m(T)/|\lambda|^m\), plus any retained
lower-end boundary terms.  `Eₘ` is acceptable generic input; each named
application must derive it from explicit amplitude/phase data rather than
assuming its desired final estimate.

The permanent counterexample is \(A=1,\phi(t)=t\) on the whole real line:
the integrand has unit norm and is not Bochner integrable, despite oscillatory
finite-cutoff cancellation.  A whole-line theorem must use a symmetric or
specified one-sided improper convention.

## 6. CT-001 — curve identities and length bounds

For a piecewise `C¹` curve `γ : [a₀,b₀] → ℂ` and continuous
`E`-valued integrand `f` on its image, define the curve integral through the
parameter integral and prove:

- invariance under an explicitly orientation-preserving piecewise `C¹`
  bijective reparameterization;
- reversal gives exactly the negative integral;
- concatenation gives the sum when the joining endpoints agree;
- for an integrable nonnegative `M(t)` with
  \(\|f(\gamma(t))\|\,|\gamma'(t)|\le M(t)\),
  \[
    \left\|\int_\gamma f(z)\,dz\right\|
    \le\int_{a_0}^{b_0}M(t)\,dt; \tag{OC.7}
  \]
- if \(\|f\|\le B\), \(|\gamma'|\le V\), and `B,V ≥ 0`, then
  \(\|\int_\gamma f\|\le(b_0-a_0)BV\).

The last formula is stated in terms of speed; a corollary may replace
`(b₀-a₀)V` by a separately proved length bound.  Endpoint distance alone
never replaces curve length.

The dossier checks constant curves, affine segments, reversal twice, and a
piecewise curve whose image retraces itself.  Two reviewers cover contour
semantics/orientation and Mathlib/API reuse.

## 7. CT-002 — deformation with all connectors visible

The exact deformation target concerns an explicit piecewise `C¹` homotopy
\(H(s,t)\) whose boundary consists of the original curve, the deformed curve
with opposite orientation, and two endpoint tracks.  Assume its image lies in
an open set where `f` is holomorphic.  Cauchy--Goursat/Stokes infrastructure
then proves the signed boundary integral is zero.

If endpoints are fixed, the two connector integrals vanish and the original
and deformed integrals agree.  If endpoints move, retain both connector
integrals and bound each by (OC.7).  If a pole, cut, or excluded point lies in
the homotopy image, the theorem is inapplicable; a residue or indentation
packet must state the replacement identity and orientation explicitly.

The proof dossier must include the homotopy boundary orientation, regularity of
all four sides, image containment, and branch consistency.  This is branch- and
orientation-sensitive work, so its pre-Lean gate requires three independent
perspectives: mathematical contour semantics, quantitative proof, and
structural/dependency review.  At least two distinct reviewer IDs must approve
the card and proof, and the third structural review is additionally required.

## 8. SP-001 — Gaussian and Fresnel model moments

Reuse Mathlib's absolutely convergent complex Gaussian theorem for
`Re ε > 0`.  For `λ > 0` and `η ∈ {-1,1}`, define the oscillatory model by the
specified damping limit `ε ↓ 0` (and prove agreement with symmetric finite-cutoff
limits):

\[
 \lim_{\varepsilon\downarrow0}
 \int_{-\infty}^{\infty}
 e^{-(\varepsilon-i\eta\lambda/2)s^2}\,ds
 =e^{i\eta\pi/4}\sqrt{\frac{2\pi}{\lambda}}. \tag{OC.8}
\]

Differentiation while `ε > 0`, followed by a justified limit, gives

\[
 \operatorname{FresnelMoment}_{2j}(\eta,\lambda)
 =(2j-1)!!\left(\frac{i\eta}{\lambda}\right)^j
 e^{i\eta\pi/4}\sqrt{\frac{2\pi}{\lambda}},
 \qquad
 \operatorname{FresnelMoment}_{2j+1}=0. \tag{OC.9}
\]

Use `(-1)!! = 1` or state `j = 0` separately; the card must choose one exact
finite definition.  Branches of the complex square root are checked by the
positive-real normalization and `η = ±1` specializations.

The dossier includes dominated convergence only in the damped region,
integration-by-parts estimates for the undamped tails, parity for odd moments,
and exact constants.  Two reviewers are mandatory, with a third branch/source
review if these moments are tied directly to a source occurrence.

## 9. SP-002 and SD-001 — explicit critical-point geometry

### Real stationary chart

Let `t₀` lie in the interior of `[a₀,b₀]`, with
\(\phi'(t_0)=0\) and \(\kappa=\phi''(t_0)\ne0\).  Choose `δ > 0` so
`[t₀-δ,t₀+δ]` lies in the interval and assume

\[
 |\phi''(t)-\kappa|\le|\kappa|/2
 \quad (|t-t_0|\le\delta). \tag{OC.10}
\]

Define

\[
 s(t)=\operatorname{sgn}(t-t_0)
 \sqrt{\frac{2\,\operatorname{sgn}(\kappa)
 (\phi(t)-\phi(t_0))}{|\kappa|}}.
\]

The packet proves this is a monotone `C¹` chart with

\[
 \phi(t)=\phi(t_0)+\operatorname{sgn}(\kappa)|\kappa|s(t)^2/2,
 \quad
 \frac1{\sqrt6}\le s'(t)\le\frac3{\sqrt2}, \tag{OC.11}
\]

using continuous extension at `t₀`; consequently the inverse derivative is
at most `√6`.  These constants follow from (OC.10) and are retained even if a
later proof sharpens them.  The local amplitude becomes
\(B(s)=A(t(s))t'(s)\); its Taylor remainder and the exact model moments (OC.9)
produce the finite local expansion.  The complementary intervals use OI-002
with an explicit lower bound for `|φ'|`.  Local, complement, cutoff, and endpoint
errors remain separate in the final majorant.

The SP-002 dossier must freeze an actual finite theorem (order, cutoff, exact
coefficient formula, and all constants) before implementation.  Merely citing
the Morse lemma is insufficient because it supplies no usable `δ` or derivative
bounds.

### Complex simple saddle

For `u > 0`, a parameterized contour `γ : [-L,L] → ℂ`, phase `Φ`, and
amplitude `G`, assume

\[
 \operatorname{Re}(\Phi(\gamma(t))-\Phi(z_0))\le-c t^2,
 \quad |G(\gamma(t))\gamma'(t)|\le M,
 \quad c>0,\ M\ge0. \tag{OC.12}
\]

Then CT-001 and the real Gaussian integral give the explicit saddle bound

\[
 \left|\int_\gamma e^{u\Phi(z)}G(z)\,dz\right|
 \le M e^{u\operatorname{Re}\Phi(z_0)}
       \sqrt{\frac{\pi}{uc}}. \tag{OC.13}
\]

If a remaining contour piece has length at most `ℓ`, amplitude at most `Mₜ`,
and phase drop at least `ω > 0`, retain the separate contribution
\(\ell M_t e^{u(\operatorname{Re}\Phi(z_0)-\omega)}\).  The application must
construct the contour and prove (OC.12); assuming those facts is only the
generic SD-001 theorem.

SP-002 and SD-001 require two quantitative reviews.  When a branch, moving
critical point, or named model is present, add the structural/circularity review
required by the roadmap.

## 10. COAL-001 — coalescing critical points

This is a novel-mathematics dossier, not a placeholder structure.  For one
frozen source-relevant configuration it must construct the analytic change of
variable to the selected canonical cubic or endpoint normal form, prove its
parameter domain, branch, injectivity/local inverse, coefficient formulas,
Jacobian bounds, critical-point correspondence, and an explicit contour image.
The final theorem separates normal-form error, amplitude Taylor error, local
model tail, and nonlocal contour contributions.

Before Lean, the dossier needs three blind reviews: source/normalization,
quantitative rederivation of every constant/domain, and
structural/circularity/dependency.  Prototypes must include the exactly
coalesced parameter, two separated critical points, a boundary parameter, and
a case showing that choosing unrelated local branches produces an inconsistent
global contour.  Any change to the canonical normalization invalidates all
three approvals.

## 11. Prototype and counterexample suite

- **Boundary-term check:** with `φ(t)=t` and `A(t)=1`, (OC.1) is the exact
  formula
  \((e^{i\lambda b_0}-e^{i\lambda a_0})/(i\lambda)\); the remainder is zero.
- **Stationary-point exclusion:** `φ(t)=t²` on an interval containing zero
  cannot satisfy `σ > 0`; OI-001 must not prove a false `1/|λ|` bound there.
- **Orientation check:** a contour followed by its reversal integrates to zero;
  a closed curve with reversed orientation changes sign.
- **Length check:** curves with the same endpoints can have arbitrarily large
  length, so endpoint distance cannot replace `ℓ` in a contour bound.
- **Conditional-integral check:** the undamped Fresnel kernel has norm one and
  is not Bochner integrable on the line, while its declared improper integral
  exists.
- **Branch check:** a contour crossing the chosen logarithm cut is outside the
  theorem domain even when the endpoints lie inside it.
- **Cancellation check:** absolute remainder bounds remain meaningful where a
  leading Airy, Bessel, or oscillatory combination vanishes; no relative bound
  divides by that leading term.

## 12. Pinned Mathlib reuse and gaps

Reuse candidates already verified in the local audit include:

- `intervalIntegral.integral_mul_deriv_eq_deriv_mul` and its explicit-derivative
  variants;
- `MeasureTheory.integral_Ioi_mul_deriv_eq_deriv_mul` for absolutely integrable
  transformed tails, with its boundary-limit hypotheses kept visible;
- `MeasureTheory.norm_integral_le_integral_norm` and
  `intervalIntegral.norm_integral_le_of_norm_le_const`;
- curve- and circle-integral definitions and norm bounds under
  `Mathlib.MeasureTheory.Integral.CurveIntegral.Basic` and
  `CircleIntegral`;
- the Cauchy integral/deformation substrate in
  `Mathlib.Analysis.Complex.CauchyIntegral`;
- complex Gaussian integrals under
  `Mathlib.Analysis.SpecialFunctions.Gaussian.GaussianIntegral` for positive
  real part, before taking a separately justified oscillatory boundary limit;
- existing principal branch and simply-connected logarithm support recorded in
  `blueprint/mathlib_audit.md`.

The pinned audit found no ready repeated nonstationary operator with constants,
no conditional Fresnel-moment package in the required semantics, no
quantitative stationary-phase or steepest-descent theorem, and no constructed
uniform coalescing normal form.  These are genuine project gaps.  Exact
declaration and import searches must be repeated when each card is frozen.

## 13. Named Olver consumers

These provisional cards are driven by the book contents and current inventory;
their body occurrences and exact formulas remain to be collated.

| Provisional card | Named consumer | Method dependency to investigate |
|---|---|---|
| APP-IGAMMA-CONTOUR-001 | incomplete Gamma functions of complex argument, Chapter 4 | CT-002/SD-001 plus exact upper/lower normalization |
| APP-AIRY-CONTOUR-001 | Airy integral/functions of complex argument, Chapter 4 | CT-002, SP-001, SD-001; rotated contours and phases must be reconciled |
| APP-GAMMA-RATIO-001 | ratio of two Gamma functions and loop Watson method, Chapter 4 | CT-002 plus a loop-integral variant; poles and branch are explicit |
| APP-BESSEL-CONTOUR-001 | Bessel functions of large argument and order, Chapter 4 | stationary/saddle packets and identified J/Y/H object |
| APP-NICHOLSON-001 | Nicholson integral for the Bessel combination in Chapter 9 | oscillatory/stationary analysis after the exact combination is transcribed |
| APP-ANGER-001 | Anger functions of large order, Chapter 9 | saddle or coalescing packet plus source-specific Anger normalization |
| APP-AIRY-TRANSITION-001 | Airy comparison consumers in Chapter 11 | COAL-001 only after the independent Airy definition and envelope gates |

Each named card proves a reachable/nonempty domain, nonnegative final majorant,
contour existence and containment, every generic hypothesis, and public
function identification.  A conditional contour theorem alone earns no named
source coverage.  None of these consumers is allowed onto the OLV-001 Watson
critical path.

## 14. Exit criteria

A packet exits planning only after its theorem card freezes exact signatures,
integral convention, regularity, endpoints, branches, domains, constants,
dependency IDs, proof dossier, counterexamples, and review quorum.  Completion
means checked exact identities and explicit finite estimates; it does not
include contour-finding software, quadrature, numerical steepest descent, or
special-function evaluation.
