# Summation and coefficient-transfer methods

**Document status:** planning blueprint; no packet listed here authorizes Lean  
**Scope:** finite summation by parts, Euler--Maclaurin with an exact periodic-
Bernoulli remainder, explicit remainder bounds, and analytic coefficient
extraction/transfer  
**Critical-path status:** parallel Track B work; no packet here is a prerequisite
for the first Watson source theorem

The public layer consists of finite identities and finite inequalities.  It
does not identify a function with a divergent formal series, infer a coefficient
bound from a radius of convergence alone, or turn a practical error estimate
into a certified upper bound by changing its name.

## 1. Frozen conventions

- `N` terms means a sum over `Finset.range N`; for natural endpoints `m ≤ n`,
  the default interval is half-open, \(\sum_{k=m}^{n-1}\).  Inclusive sums are
  named explicitly.
- The locked Chapter 8 §1 transcription uses Mathlib's convention, in particular
  \(B_1=-\tfrac12\).  The real Bernoulli polynomial is
  \(B_r(x)\); the periodic function is separately defined by
  \(\widetilde B_r(x)=B_r(\{x\})\), with `0 ≤ {x} < 1`.
  The pin already provides `periodizedBernoulli` on `UnitAddCircle` through the
  `[0,1)` representative; a real-line wrapper must reuse it rather than invent
  a second periodization. Source agreement remains independently unreviewed.
- The baseline Euler--Maclaurin formula sums `[m,n)`.  This fixes the endpoint
  term as `(f(m) - f(n))/2`; changing to an inclusive or `(m,n]` convention
  requires a separately proved transport lemma.
- Complex powers and logarithms in Stirling, Barnes, or Darboux applications
  use a declared branch.  Totalized division at a pole and totalized logarithm
  on a cut are not continuations.
- A coefficient is attached to an actual `HasFPowerSeriesOnBall` or equivalent
  Taylor-series object.  A formal sequence that satisfies a recurrence is not
  automatically the coefficient sequence of the named analytic function.
- Generic conditional infrastructure may accept derivative or boundary
  controls as explicit inputs.  Every named application proves those controls,
  domain reachability, and majorant nonnegativity.

## 2. Dependency-ordered theorem-card queue

All IDs are provisional and remain `planning_only` until a bounded theorem card
and reviewed proof artifact exist.

| Order | Card | Packet theorem / coverage / novelty class | Bounded content | Dependencies |
|---:|---|---|---|---|
| 1 | SUM-001 | `foundational_calculus` / `infrastructure` / `equivalent_reformulation` | finite summation-by-parts identities and Dirichlet bound | QB-001 and Mathlib finite sums |
| 2 | BER-001 | `definition_identification` / `infrastructure` / `equivalent_reformulation` | real-line facade for pinned `periodizedBernoulli`, unit-interval calculus, and explicit finite envelope | accepted DEF-BERN-001 number/polynomial identification, accepted DEF-BERN-002 periodization identification, and pinned Bernoulli objects |
| 3 | EM-001 | `exact_identity` / `infrastructure` / `equivalent_reformulation` | half-open Euler--Maclaurin exact identity | SUM-001, BER-001, interval integration by parts |
| 4 | EM-002 | `finite_remainder_bound` / `infrastructure` / `novel` explicit packaging | natural integral remainder bound and explicit constant corollaries | EM-001, QB-001 |
| 5 | CF-001 | `mixed` / `infrastructure` / `equivalent_reformulation` | circle coefficient identity and Cauchy coefficient bound | pinned Cauchy integral infrastructure |
| 6 | CF-002 | `finite_remainder_bound` / `infrastructure` / `generalized` | finite singular expansion plus remainder coefficient transfer | CF-001; CT-001/CT-002 only for noncircular contours |
| 7 | DAR-001 | `finite_remainder_bound` / `infrastructure` / `novel` | one constructed Darboux/keyhole contour with explicit local and remote bounds | CF-002 and branch/domain support |
| 8 | ILT-001 | unclassified pending occurrence collation | inverse-Laplace/Haar coefficient or sequence transfer | CF-002 and accepted integral/contour packets selected by its statement |

The packets are intentionally split.  In particular, elementary finite
summation can proceed without Bernoulli polynomials, and circle coefficient
bounds can proceed without Euler--Maclaurin or a general contour framework.
The table uses the packet-level v2 axes.  `exact_identity` is valid for a pure
identity packet such as EM-001; `mixed` records that CF-001 has both an identity
and a quantitatively distinct bound.  Exact declarations receive separate
target-level classifications only after a bounded card exists.

### Planned proof artifacts

The first proposed artifact IDs are `NLP-SUM-001-R1`, `NLP-BER-001-R1`,
`NLP-EM-001-R1`, `NLP-EM-002-R1`, `NLP-CF-001-R1`, `NLP-CF-002-R1`,
`NLP-DAR-001-R1`, and, only after source selection, `NLP-ILT-001-R1`.
Every new-mathematics artifact follows
`blueprint/automation/proof_artifact_schema.md` and binds exact target IDs,
card/signature revisions, the resolved Mathlib pin, accepted dependencies, and
source artifacts where applicable.  It contains quantifier, dependency,
analytic-side-condition, and constant-loss ledgers; numbered exact identities;
complete target proofs; adversarial cases; a hypothesis/choice-laundering
audit; regressions; and trust/import exclusions.  The proposed IDs create no
file or status.

## 3. SUM-001 — finite summation by parts

Let `aₖ` be scalar and `bₖ` lie in a normed module.  For naturals `m ≤ n`,
put

\[
 S_k=\sum_{j=m}^{k}a_j.
\]

The inclusive identity is

\[
 \sum_{k=m}^{n}a_kb_k
 =S_nb_n+\sum_{k=m}^{n-1}S_k(b_k-b_{k+1}). \tag{SM.1}
\]

The card also provides the exact `[m,n)` and `range N` orientations matching
`Finset.sum_Ico_by_parts` and `Finset.sum_range_by_parts`.  These are distinct
target statements so applications do not repeatedly translate indices by
hand.

For real nonnegative, nonincreasing `bₖ`, if

\[
 |S_k|\le M\quad(m\le k\le n),\qquad M\ge0,
\]

then (SM.1) telescopes to the sharp finite Dirichlet bound

\[
 \left|\sum_{k=m}^{n}a_kb_k\right|\le M b_m. \tag{SM.2}
\]

For complex or vector `bₖ`, retain instead the total-variation formula

\[
 \left\|\sum_{k=m}^{n}a_kb_k\right\|
 \le M\left(\|b_n\|+
       \sum_{k=m}^{n-1}\|b_k-b_{k+1}\|\right). \tag{SM.3}
\]

The natural-language dossier proves (SM.1) by expanding partial sums and
reindexing finite sums, then derives (SM.2) without replacing a telescoping sum
by a larger `nM` bound.  It checks `m = n`, `m = 0`, a one-term `range`, and a
constant weight.  Two independent reviewers cover index/orientation
correctness and Mathlib/API reuse before Lean.

## 4. BER-001 — periodic Bernoulli support

This packet must not redefine Mathlib's Bernoulli numbers, polynomials, or
periodization. It adds only the real-line facade needed by Euler--Maclaurin and
the calculus/envelope facts not already exported for pinned
`periodizedBernoulli`. `DEF-BERN-001` is reuse-only and declaration-free;
`DEF-BERN-002` separately owns the source-to-periodization identification.

For `r : ℕ`, define

\[
 \widetilde B_r(x)=B_r(\{x\}). \tag{SM.4}
\]

Required exact facts are:

- periodicity under integer translation;
- on every open unit interval `(k,k+1)`,
  \((\widetilde B_{r+1})'=(r+1)\widetilde B_r\);
- \(\int_k^{k+1}\widetilde B_r(x)\,dx=0\) for `r ≠ 0`;
- for `r ≠ 1`, the endpoint polynomial values agree, while the `r = 1`
  jump is exactly one under Mathlib's \(B_1=-1/2\) convention.

The baseline explicit envelope contains no supremum:

\[
 C_r^{\mathrm{alg}}
 :=\sum_{j=0}^{r}\binom rj |B_j|,
 \qquad
 |\widetilde B_r(x)|\le C_r^{\mathrm{alg}}. \tag{SM.5}
\]

This follows from
\(B_r(y)=\sum_{j=0}^{r}\binom rj B_jy^{r-j}\) and `0 ≤ y ≤ 1`.
The finite rational expression in (SM.5) is a valid terminal constant.  A
sharper optional packet may prove, for `p ≥ 1`,

\[
 |\widetilde B_{2p}(x)|
 \le \frac{2(2p)!\,\zeta(2p)}{(2\pi)^{2p}}, \tag{SM.6}
\]

but EM-001/EM-002 do not wait for it.

The dossier must treat integer points explicitly rather than differentiating
through the periodic jump.  `r = 0`, `1`, and `2` are mandatory regressions.
Two independent reviews cover Bernoulli convention/semantics and proof/API
design.

## 5. EM-001 — exact half-open Euler--Maclaurin identity

Let `m,n : ℕ` with `m ≤ n`, let `p ≥ 1`, and let
`f : ℝ → E`, where `E` is a complete normed real vector space.  The card
must freeze one actual regularity interface, such as continuous derivatives
through order `2p` on a neighborhood of `[m,n]`, together with interval
integrability.  Totalized iterated derivatives without this regularity are not
accepted.

The target identity is

\[
\begin{aligned}
 \sum_{k=m}^{n-1}f(k)
 &=\int_m^n f(x)\,dx+\frac{f(m)-f(n)}2\\
 &\quad+\sum_{r=1}^{p}
  \frac{B_{2r}}{(2r)!}
  \bigl(f^{(2r-1)}(n)-f^{(2r-1)}(m)\bigr)
  +R_p(f;m,n).
\end{aligned}\tag{SM.7}
\]

Here every natural endpoint and summation index is coerced to `ℝ` before
evaluation by `f`, and `(n-m)` in later real bounds denotes the corresponding
real cast.

The exact remainder is

\[
 R_p(f;m,n)
 =-\frac1{(2p)!}\int_m^n
   \widetilde B_{2p}(x)f^{(2p)}(x)\,dx. \tag{SM.8}
\]

The multiplication in (SM.8) is scalar action for vector-valued `f`.  The
identity includes `m = n`, where the sum, integral, endpoint difference, and
remainder all vanish.  A later complex-interval or contour version is a new
card, not silent coercion of (SM.7).

### Proof dossier

The planned artifact `blueprint/proofs/EM-001.md` must:

1. establish the one-unit-interval identity using ordinary interval
   integration by parts, never a false global derivative theorem for the
   discontinuous periodic `B̃₁`;
2. sum the unit identities and show exactly how interior endpoints telescope;
3. derive the `(f(m)-f(n))/2` sign from the chosen half-open convention;
4. iterate through `2p`, recording factorials and the vanishing odd Bernoulli
   numbers actually used;
5. derive (SM.8) with its minus sign;
6. test `p = 1` on `f(x)=1`, `x`, `x²`, and `x⁴` over `[0,1)`; the `x⁴`
   case makes the remainder `-1/30`, detecting a reversed sign;
7. test arbitrary natural translation and `m = n`.

Because this is missing from Mathlib and endpoint conventions are fragile, its
pre-Lean gate requires two independent quantitative proof reviews plus a
separate Mathlib/API reuse review.  The overall gate uses at least three
distinct reviewer IDs.  A change of sum convention, Bernoulli convention,
derivative order, or remainder sign invalidates all approvals.

## 6. EM-002 — explicit remainder bounds

From (SM.5), (SM.8), and the integral norm inequality, prove the natural bound

\[
 \|R_p(f;m,n)\|
 \le\frac{C_{2p}^{\mathrm{alg}}}{(2p)!}
   \int_m^n\|f^{(2p)}(x)\|\,dx. \tag{SM.9}
\]

If `M ≥ 0` and
\(\|f^{(2p)}(x)\|\le M\) on `[m,n]`, then

\[
 \|R_p(f;m,n)\|
 \le\frac{C_{2p}^{\mathrm{alg}}}{(2p)!}(n-m)M. \tag{SM.10}
\]

Export (SM.9) before (SM.10): the integral variation can be much sharper than
a uniform bound.  If (SM.6) is independently proved, add the separate sharper
corollary

\[
 \|R_p\|\le
 \frac{2\zeta(2p)}{(2\pi)^{2p}}
 \int_m^n\|f^{(2p)}(x)\|\,dx. \tag{SM.11}
\]

No formula contains an unnamed supremum or constant.  The dossier checks
nonnegativity of `C`, factorial denominators, interval length, and both
endpoints.  Two independent reviews are required; one may be shared with
EM-001 only if the overall distinct-reviewer quorum remains satisfied.

## 7. CF-001 — exact circle coefficient extraction

Let `E` be a complete complex normed vector space, `R > 0`, and let `f` be
complex differentiable on a neighborhood of the closed disk
`closedBall c R`.  Let `aₙ` be the coefficient of its proved power series at
`c`, equivalently the normalized iterated derivative.  Prove

\[
 a_n=\frac1{2\pi i}\oint_{|z-c|=R}
       \frac{f(z)}{(z-c)^{n+1}}\,dz. \tag{SM.12}
\]

If `M ≥ 0` and `‖f(z)‖ ≤ M` on that circle, the circle length and
denominator norm give

\[
 \|a_n\|\le M/R^n. \tag{SM.13}
\]

The card freezes whether `aₙ` is expressed through Mathlib's
`cauchyPowerSeries`, an existing `HasFPowerSeriesOnBall`, or
`iteratedDeriv n f c / n!`; bridges among these forms are separate exact
targets.  It checks `n = 0`, constant functions, positive radius, and
translation from center zero.

The proof should reuse `Complex.cauchyPowerSeries`,
`cauchyPowerSeries_apply`, Cauchy's derivative integral, and the circle norm
bound.  It must not build a second contour integral API.  Two reviewers cover
complex semantics and Mathlib/API reuse.

## 8. CF-002 — finite coefficient transfer

The safe circular theorem is elementary and useful.  Suppose
`f = S + h` on a neighborhood of `closedBall c R`, the power-series
coefficients of `S` are known exactly, and `‖h(z)‖ ≤ M` on the circle.  Then

\[
 [w^n]f(c+w)-[w^n]S(c+w)
 =\frac1{2\pi i}\oint_{|z-c|=R}
   \frac{h(z)}{(z-c)^{n+1}}\,dz, \tag{SM.14}
\]

and

\[
 \bigl\|[w^n]f(c+w)-[w^n]S(c+w)\bigr\|
 \le M/R^n. \tag{SM.15}
\]

The exact finite local expansion of `S` is established algebraically before
(SM.14).  For a parameterized family, one uniform `R` and `M` is quantified
outside the parameter; pointwise existence of a radius does not prove a
uniform coefficient estimate.

Classical Darboux problems have a singularity on or inside the useful circle.
They therefore do **not** follow from CF-002 by pretending the remainder is
analytic on a forbidden disk.  DAR-001 must construct a dented/keyhole contour,
declare the branch and orientation, use CT-002 for the valid deformation, and
bound local and remote pieces separately.

## 9. DAR-001 and ILT-001 — novel transfer dossiers

### Darboux packet

For one collated Olver-relevant singularity class, freeze:

- an explicit slit domain and logarithm/power branch;
- a finite singular model, for example
  \(S_K(z)=\sum_{j<K}c_j(1-z/\rho)^{\alpha_j}
  (\log(1-z/\rho))^{q_j}\), with exact coefficient formulas;
- a parameterized keyhole or dented circle, including every radius, angle,
  orientation, connector, and nonempty-domain condition;
- an exact coefficient-contour identity;
- explicit local remainder and remote-arc bounds, with their sum retained;
- the admissible relation among coefficient index, indentation radius, and
  source parameters.

The proof dossier constructs the contour and proves branch consistency; it may
not assume a structure field containing the desired deformation and bound.
Three independent pre-Lean reviews are mandatory: source/branch fidelity,
quantitative constants/domains, and structural/circularity/API.

### Inverse-Laplace/Haar packet

`ILT-001` is not a generic promise.  It is created only after a direct Chapter
8 occurrence audit selects an exact transform and inversion convention.  The
card then freezes the vertical or deformed contour, normalization factor,
growth assumptions, cutoff identity, and explicit remainder.  Any motion of
the contour and any residues crossed are included in the exact identity.  Its
novelty and coverage classes remain unresolved until collation.

## 10. Prototype and counterexample queue

- **Summation orientation:** verify (SM.1) for one and two terms and show that
  swapping `bₖ-bₖ₊₁` reverses the identity.
- **Dirichlet hypotheses:** with `aₖ = bₖ = 1`, partial sums are unbounded and
  no order-independent bound follows.  With nonmonotone weights, (SM.3), not
  (SM.2), is the safe conclusion.
- **Euler--Maclaurin sign:** `p = 1`, `[0,1)`, and `f(x)=x⁴` gives partial
  terms totaling `1/30` and remainder `-1/30`.
- **Bernoulli jump:** `B̃₁` has different one-sided endpoint values; a proof
  differentiating it globally must fail.  Even `B̃₂` has matching endpoints.
- **Circle coefficient bound:** for `f(z)=1/(1-z)` and `0 < r < 1`,
  `aₙ = 1` and (SM.13) gives
  \(1\le 1/(r^n(1-r))\).  For `n ≥ 1`, the explicit choice
  `r=n/(n+1)` gives `(n+1)(1+1/n)^n`.
- **Radius is insufficient:** multiplying a function by an arbitrary scalar
  preserves its radius of convergence and makes its coefficients arbitrarily
  large; a boundary majorant is indispensable.
- **Singularity-domain check:** CF-001 may not use a circle crossing the pole of
  `1/(1-z)`.
- **Divergence check:** an all-orders Stirling or Darboux finite remainder family
  is not, by itself, convergence of the formal series in order.

## 11. Pinned Mathlib reuse and gaps

Reuse candidates verified in the current local audit are:

- `Finset.sum_Ico_by_parts`, `Finset.sum_Ioc_by_parts`, and
  `Finset.sum_range_by_parts` from `Mathlib.Algebra.BigOperators.Module`;
- the analytic Abel-summation declarations
  `sum_mul_eq_sub_sub_integral_mul` and `sum_mul_eq_sub_integral_mul` when their
  exact natural-index and derivative conventions fit;
- root `bernoulli`, `Polynomial.bernoulli`,
  `Polynomial.derivative_bernoulli`, and
  `Polynomial.sum_range_pow_eq_bernoulli_sub`;
- root `bernoulliFun`, `periodizedBernoulli` on `UnitAddCircle`,
  `hasDerivAt_bernoulliFun`, `intervalIntegrable_bernoulliFun`, and its
  unit-interval integral facts;
- interval integration by parts and the Bochner integral norm inequality;
- `Complex.cauchyPowerSeries`, `cauchyPowerSeries_apply`,
  `DifferentiableOn.hasFPowerSeriesOnBall`, the Cauchy derivative integral, and
  `circleIntegral.norm_integral_le_of_norm_le_const`.

The pinned searches found no Euler--Maclaurin theorem with the exact
periodic-Bernoulli remainder and no ready finite Darboux/coefficient-transfer
package in the required source-facing form. Periodization itself is already
present; the remaining gap is its real-line calculus facade and the exact
finite identity. EM-001, EM-002, and DAR-001 remain project formalization work;
a fresh exact-signature search is required before freezing each card.

## 12. Named Olver consumers

The Chapter 8 §1 Bernoulli/Euler--Maclaurin row now has a locked body
transcription; it remains independently unreconciled. Other consumers below
are discovery-level and still need exact locked occurrences before their
coverage and novelty classifications are frozen.

| Provisional card | Named consumer | Expected dependency |
|---|---|---|
| DEF-BERN-001 | Bernoulli polynomials in Chapter 8 §1 | entity identification/convention audit, not by itself theorem coverage |
| APP-STIRLING-LOGGAMMA-001 | Stirling's series for `log Γ(z)`, Chapter 8 | EM-001/002 or the source's contour remainder, identified Gamma, and a fixed logarithm branch |
| APP-BARNES-HYPERGEOMETRIC-001 | Barnes integral for the hypergeometric function, Chapter 8 | CT-001/002, residue/branch data, and identified ordinary versus regularized hypergeometric object |
| APP-ENTIRE-EXPANSION-001 | asymptotic expansions of entire functions, Chapter 8 | CF-001 plus exact source growth hypotheses |
| APP-DARBOUX-COEFFICIENT-001 | coefficients in a power-series expansion; Darboux method, Chapter 8 | CF-002 and one accepted DAR-001 singularity packet |
| APP-ILT-HAAR-001 | inverse Laplace transforms; Haar's method, Chapter 8 | a collated ILT-001 packet with exact normalization |

For `APP-STIRLING-LOGGAMMA-001`, the theorem card must distinguish `log Γ`
from a logarithm of Mathlib's totalized value at poles and state the cut/sector,
remainder formula, order convention, and branch normalization.  For
`APP-BARNES-HYPERGEOMETRIC-001`, parameter poles, contour separation, residue
orientation, and ordinary/regularized normalization are mandatory.  These
branch-sensitive named packets require the third structural/source review in
addition to the two ordinary proof reviews.

No named card may claim completion from a generic conditional theorem.  It
must prove target-function identification, nonempty/reachable domain,
majorant nonnegativity, and every generic summation, derivative, contour, and
branch hypothesis.

## 13. Review and release gate summary

For every packet, the frozen card records exact declarations and binder order,
theorem/coverage/novelty classes per target, imports, accepted dependencies,
order and endpoint conventions, domain, regularity, constants, proof artifact,
and regressions.  Novel constants, a new periodic-smoothness argument, a new
contour construction, or a strengthened source conclusion require a complete
natural-language proof before Lean.

At least two independent reviewers inspect every mathematical dossier.
EM-001 and all branch-sensitive/source-named transfer packets have the stronger
three-perspective quorum stated above.  Filled verdicts and the envelope remain
outside the candidate head; any material artifact or source-snapshot change
invalidates prior approvals.  Later implementation must pass quantitative
correctness, source fidelity where applicable, Mathlib reuse, API/dependency,
proof quality, build, axiom, and exact regression checks at one candidate SHA.

Completion means exact finite summation/coefficient identities and explicit
remainder estimates for the accepted cards.  It does not include sequence
evaluation, quadrature, tolerance routing, automatic contour selection, or
numerical coefficient computation.
