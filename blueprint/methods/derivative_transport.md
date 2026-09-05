# Quantitative derivative transport

**Document status:** planning specification; not a theorem card and not Lean authorization

**Roadmap position:** M3 parallel architecture demonstrator; not on the Watson critical path

**Coverage class:** infrastructure and audit regressions; no Olver occurrence is claimed here

**Authoritative dependency snapshot:** Lean/Mathlib `v4.33.1`, resolved Mathlib commit
`0df444a360eaa60ab8c11dca51a86af692955474`

This document refines the derivative portions of the attached *Explicit Quantitative Olver in Lean*
blueprint. It must be read with [complex domains and branches](complex_domains_branches.md), the
[roadmap](../roadmap.md), [Mathlib audit](../mathlib_audit.md), and
[review protocol](../../review/PROTOCOL.md). Proposed names and signatures are inputs to future frozen
theorem cards. They authorize no Lean implementation by themselves.

## 1. Contract and non-implications

The central operation is quantitative transport from a complex-neighborhood value bound to a
center derivative bound:

\[
  \sup_{|w-z|=r(z)}\|F(w)-A(w)\|\le B(z)
  \quad\Longrightarrow\quad
  \|F^{(k)}(z)-A^{(k)}(z)\|
  \le \frac{k!B(z)}{r(z)^k}.
\]

Every public result displays the derivative order, positive radius, analytic/closure regularity,
boundary or closed-disk control, domain containment, and factorial/radius loss. Applications also
display any threshold change and boundary-to-center weight comparison.

This layer does **not** infer derivative bounds from a real-axis estimate, the existence of an entire
extension, pointwise real/complex agreement, a qualitative `IsBigO`, or an unnamed neighborhood. It
does not claim that Cauchy's estimate is sharper than direct differentiation. It does not implement a
radius-selection algorithm.

## 2. Layering and packet order

```text
accepted QB finite-error core       LMLF.Complex.Domain / RealRestriction
             \                         /
              +--> LMLF.Complex.CauchyRemainder
                         |
                         +--> proportional/fixed-radius corollaries
                         +--> derivative-family wrappers
                         `--> Examples/DerivativeTransport

iterated-derivative algebra
  +--> LMLF.Quantitative.DerivativeProfile
  +--> LMLF.Complex.Normalization
  `--> LMLF.Complex.Polydisk       (later, independent card)
```

The one-variable Cauchy wrapper must land before optimized specializations. Real restriction consumes
that complex result; it is not embedded in the generic Cauchy theorem. Mixed derivatives, normalized
jets, and fast-factor normalization are later cards and cannot enlarge the initial M3 packet silently.
No file in this layer imports a named special function or an application umbrella.

Candidate narrow imports are:

| Project file | Candidate imports |
|---|---|
| `LMLF/Complex/CauchyRemainder.lean` | accepted module defining `QuantitativeAnalysis.ErrorOn`; `Mathlib.Analysis.Complex.Liouville`; `Mathlib.Analysis.Calculus.IteratedDeriv.Lemmas`; `LMLF.Complex.Domain` only for geometric corollaries |
| `LMLF/Quantitative/DerivativeProfile.lean` | accepted finite-error core and focused iterated-derivative algebra |
| `LMLF/Complex/Polydisk.lean` | Cauchy remainder, analytic product/slice support, iterated Fréchet derivative symmetry |
| `LMLF/Complex/Normalization.lean` | iterated-derivative product/chain rules and accepted branch support only when a phase uses a branch |

Keep tactic modules out of all four semantic files.

## 3. Verified Mathlib reuse at the repository pin

The attached blueprint cited an older Mathlib commit. The following claims were rechecked in the local
resolved checkout at `0df444a360eaa60ab8c11dca51a86af692955474`; the repository audit, not the old
attachment hash, is authoritative.

### 3.1 The quantitative Cauchy theorem

`Mathlib.Analysis.Complex.Liouville` provides exactly:

```lean
Complex.norm_iteratedDeriv_le_of_forall_mem_sphere_norm_le
  (n : ℕ) (hR : 0 < R)
  (hf : DiffContOnCl ℂ f (Metric.ball c R))
  (hC : ∀ z ∈ Metric.sphere c R, ‖f z‖ ≤ C) :
  ‖iteratedDeriv n f c‖ ≤ (n.factorial : ℝ) * C / R ^ n
```

for a complete complex normed codomain. The same file provides
`Complex.norm_deriv_le_of_forall_mem_sphere_norm_le` for the first derivative without a codomain
completeness assumption.

This is the fundamental estimate. LMLF should wrap it in the project error predicate and should not
reprove Cauchy's integral formula.

### 3.2 Subtraction and regularity

`Mathlib.Analysis.Calculus.IteratedDeriv.Lemmas` supplies `iteratedDeriv_sub`, whose hypotheses are
`ContDiffAt` for both functions at the requested order. `DiffContOnCl.sub` is already available, as are
`DiffContOnCl.differentiableOn`, `.continuousOn_ball`, `.mono`, and
`DifferentiableOn.diffContOnCl_ball`.

The wrapper proof must derive the needed center regularity from the disk hypotheses before rewriting
the derivative of `f-a`. It must not use linearity of Mathlib's totalized `iteratedDeriv` for arbitrary
nondifferentiable functions.

### 3.3 Real restriction and product analyticity

The pinned source provides the first-order real/complex bridges listed in
[the companion document](complex_domains_branches.md#52-derivative-restriction). It also provides
`AnalyticOnNhd.curry_left` and `.curry_right` for analytic functions on products, and symmetry of
`iteratedFDeriv` for analytic or sufficiently smooth functions in
`Mathlib.Analysis.Analytic.IteratedFDeriv`.

These are useful ingredients for mixed derivatives. No ready-made theorem with the proposed explicit
polydisk product bound was found in the local source, and no direct all-orders scalar real-restriction
wrapper was found. Both remain project work.

## 4. One-variable Cauchy wrapper

### 4.1 Main candidate signature

The first future card should freeze a Banach-valued version, since Mathlib's iterated theorem already
supports it:

```lean
namespace QuantitativeAnalysis

theorem errorOn_iteratedDeriv_of_disks
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E]
    {D : Set ℂ} {f a : ℂ → E} {r b : ℂ → ℝ}
    (k : ℕ)
    (hr : ∀ z ∈ D, 0 < r z)
    (hf : ∀ z ∈ D, DiffContOnCl ℂ f (Metric.ball z (r z)))
    (ha : ∀ z ∈ D, DiffContOnCl ℂ a (Metric.ball z (r z)))
    (hb : ∀ z ∈ D, ∀ w ∈ Metric.sphere z (r z),
      ‖f w - a w‖ ≤ b z) :
    ErrorOn D (iteratedDeriv k f) (iteratedDeriv k a)
      (fun z ↦ (k.factorial : ℝ) * b z / (r z) ^ k)

end QuantitativeAnalysis
```

The current Mathlib audit records that this interface shape compiled as a standalone spike. That spike
is feasibility evidence, not a public declaration and not authorization. Its exact signature must be
recompiled and frozen in the future card against the then-current accepted `ErrorOn` module.

### 4.2 Proof decomposition

At a fixed `z ∈ D`:

1. form the analytic remainder `q = f-a` using `DiffContOnCl.sub`;
2. apply Mathlib's sphere Cauchy estimate to `q` with radius `r z` and constant `b z`;
3. obtain the center `ContDiffAt` facts from the disk hypotheses;
4. rewrite `iteratedDeriv k (f-a) z` with `iteratedDeriv_sub`;
5. close exactly the unfolded `ErrorOn` goal.

Do not strengthen the assumptions to global entire functions. Do not add a standalone `0 ≤ b z`
hypothesis: the positive-radius sphere is nonempty, so the supplied boundary norm inequality already
forces nonnegativity where the theorem uses the bound. If a later algebraic helper uses `b` away from
those centers, it owns its own sign hypothesis.

Order zero is intentional. The conclusion becomes a center value estimate derived from boundary
control, as already covered by the Mathlib theorem. Regress it separately from order one and higher
orders.

### 4.3 Focused variants

Add variants only when they remove repeated real proof obligations:

- `errorOn_deriv_of_disks`, using Mathlib's first-derivative theorem and avoiding `CompleteSpace E`;
- `errorOn_iteratedDeriv_of_closedBall`, accepting a bound for every point of the closed ball and
  restricting it to the sphere;
- `errorOn_iteratedDeriv_of_domain`, accepting `closedBall z (r z) ⊆ U` plus differentiability on `U`
  and continuity on the needed closure, then constructing `DiffContOnCl`;
- a constant-radius corollary with `r z = r₀`;
- a `HasErrorFamily` wrapper obtained by fixing the approximation order and applying the pointwise
  theorem, only after the corresponding family API has its own card.

In the family wrapper the target complex function is fixed across every approximation order. The
approximant, center domain, radius, boundary majorant, and threshold may depend on the order; replacing
the target by `f n` would be a different predicate and must not be smuggled into `HasErrorFamily`.

Do not create a new Cauchy-bound structure that merely renames the four hypotheses. A named structure
becomes justified only if several consumers carry the same disk field, boundary comparison, and
regularity data together.

## 5. From domain bounds to sphere bounds

Most applications begin with an error theorem on a complex domain `U`, not a sphere-specific premise.
The adapter chain should remain visible:

```text
ErrorOn U f a B
  + closedBall z (r z) ⊆ U
  + sphere-to-center comparison: B w ≤ K z * W z
  -> boundary bound ‖f w-a w‖ ≤ K z * W z
  -> Cauchy: k! * K z * W z / r(z)^k
```

This separation makes the sources of loss auditable:

- disk shrinkage or threshold change comes from domain containment;
- `K` comes from comparing the original weight on the sphere with the center weight;
- `k! r⁻ᵏ` is the Cauchy loss;
- real restriction and coordinate changes contribute their own exact factors later.

An API that jumps directly from an application theorem to its differentiated corollary must still expose
these ingredients in named intermediate lemmas or in the proof dossier.

## 6. Fixed, proportional, and optimized radii

### 6.1 Natural proportional-radius theorem

Suppose for all relevant `w`,

\[
  \|R(w)\|\le C|w|^{-n},
\]

and center at `x>0` with radius `r=θx`, where `0<θ<1`. The radial boundary comparison gives
`|w| ≥ (1-θ)x`, hence

\[
 \|R^{(k)}(x)\|
 \le C k!\,\theta^{-k}(1-\theta)^{-n}x^{-n-k}.
\]

This full factor is the primary theorem. A simplified numeric constant is a corollary. If the original
remainder theorem requires `|w| ≥ R₀`, the center hypothesis becomes

\[
  (1-\theta)x\ge R_0.
\]

If an angular boundary imposes a smaller disk margin, replace `θx` by the actual admissible radius.

Candidate helper:

```lean
def cauchyPowerFactor (n k : ℕ) (theta : ℝ) : ℝ :=
  (k.factorial : ℝ) * theta ^ (-(k : ℤ)) *
    (1 - theta) ^ (-(n : ℤ))
```

The exact Lean normal form may instead use division by natural powers if it produces simpler positivity
proofs. Freeze one public orientation and prove conversion lemmas rather than exposing both forms
arbitrarily.

### 6.2 Optimizer

For positive integers `n,k`, the interior factor

\[
  \theta^{-k}(1-\theta)^{-n},\qquad 0<\theta<1,
\]

is minimized at

\[
  \theta_* = \frac{k}{n+k}.
\]

The proof dossier must handle `n=0` and `k=0` separately; neither has this interior optimizer in the
same sense. It must also distinguish the unconstrained optimizer from the best radius after threshold,
sector, singularity-distance, or parameter-uniform constraints are imposed.

At `θ*`, the threshold changes from `x ≥ R₀` to

\[
 x\ge\frac{n+k}{n}R_0
\]

when `n>0`. The threshold is part of the theorem regression, not a comment.

### 6.3 Exact `29` versus `2048` regression

For `n=10`, `k=1`, the optimizer is `θ=1/11` and the factor is

\[
  11\left(\frac{11}{10}\right)^{10}<29.
\]

At the routine half-radius `θ=1/2`, the factor is

\[
  2^{1+10}=2048.
\]

Both results use their correct domains: the optimized radius requires `10x/11 ≥ R₀`; the
half-radius requires `x/2 ≥ R₀`. The regression suite proves the exact rational inequality and
the exact equality for `2048`, plus the corresponding disk containment and threshold statements.

For the geometric prototype

\[
 F(z)=\frac1{1+z},\qquad
 A_9(z)=\sum_{j<9}(-1)^jz^{-j-1},
\]

retain three separate facts:

1. the complex value remainder on the right half-plane;
2. the generic Cauchy corollary with constant `<29`;
3. the sharper direct identity
   \[
     (F-A_9)'(x)=\frac{10x+9}{x^{10}(1+x)^2},
   \]
   yielding constant `10` for `x>0`.

The direct result does not replace the generic regression; it demonstrates why the API should permit
method-specific sharpening.

### 6.4 Other radius scales

Export transparent corollaries for:

| Radius | Derivative loss of order `k` |
|---|---|
| fixed `r₀>0` | `k! r₀⁻ᵏ` |
| `θ‖z‖` | `k! θ⁻ᵏ ‖z‖⁻ᵏ` plus radial weight comparison |
| `c u⁻ᵃ` | `k! c⁻ᵏ uᵃᵏ` |
| `c * dist z Σ` | `k! c⁻ᵏ (dist z Σ)⁻ᵏ`, with explicit positive distance |

Thus a turning-point disk of scale `u⁻²⁄³` naturally costs `u²ᵏ⁄³`. Any better spatial
derivative scale requires additional exact structure such as an ODE identity or analytic normalization.

## 7. Spatial analyticity versus parameter analyticity

For `R : ℂ × ℂ → E`, declare which coordinate is parameter and which is spatial. Use explicit slices:

```lean
def parameterSlice (R : ℂ × ℂ → E) (z : ℂ) : ℂ → E := fun p ↦ R (p, z)
def spatialSlice   (R : ℂ × ℂ → E) (p : ℂ) : ℂ → E := fun z ↦ R (p, z)
```

Rules for every theorem:

- holomorphy of `spatialSlice R p` justifies only spatial derivatives;
- a real parameter with finite smoothness uses real calculus, not parameter Cauchy estimates;
- parameter Cauchy estimates require an actual complex parameter extension and parameter-disk
  containment;
- a joint theorem states a domain in `ℂ×ℂ` or `Fin d → ℂ`; it cannot hide separately selected
  parameter neighborhoods;
- parameter differentiation of a branch power includes logarithms on the chosen branch, e.g.
  `∂_p z^p = z^p log z`;
- moving-coordinate derivatives use the exact chain rule. For example,
  \[
    \frac{d}{d\nu}F(\nu,\nu t)
    =\partial_\nu F(\nu,\nu t)+t\,\partial_zF(\nu,\nu t).
  \]

The two partial derivatives should have different names, even when their types coincide. Avoid a bare
`deriv` in public prose without its differentiated variable.

## 8. Mixed derivatives and polydisks

### 8.1 Geometry and multi-index convention

For a finite coordinate type, use `Fin d → ℂ` and `Fin d → ℕ`. Candidate definitions are:

\[
 \operatorname{polydisc}(c,r)=
 \{z:\forall i,\ |z_i-c_i|<r_i\},
 \qquad
 \alpha!=\prod_i\alpha_i!.
\]

All radii are strictly positive. The first quantitative theorem should accept control on the closed
polydisc, because repeated one-coordinate Cauchy estimates pass through points where earlier
coordinates lie on their boundary circles and later coordinates remain at their centers. A theorem
using only the distinguished boundary torus needs an additional maximum-modulus argument and should be
separate.

### 8.2 Target estimate

For a jointly analytic Banach-valued remainder on an explicitly contained polydisc,

\[
  \|\partial^\alpha R(c)\|
  \le \alpha!\,M\prod_{i=1}^{d}r_i^{-\alpha_i}.
\]

The project first defines a canonical coordinate derivative order, then proves independence from order
under joint analyticity. Mathlib's symmetry theorems for `iteratedFDeriv` are the preferred foundation
for commutation. Coordinate derivative bounds are not silently identified with the operator norm of the
full Fréchet derivative; conversions state the ambient product norm and any dimension factor.

### 8.3 Staging

1. Prove a two-coordinate parameter/spatial theorem for `ℂ×ℂ` by iterating the accepted scalar
   Cauchy wrapper.
2. Prove the order-commutation bridge using joint analyticity.
3. Generalize to `Fin d` only after the bivariate theorem and one further consumer establish a stable
   multi-index representation.
4. Compare the product-radii estimate with the cheaper ambient-ball theorem obtained from general
   Fréchet calculus; retain both if their constants and consumers differ.

Separate slice holomorphy is not recorded as joint holomorphy without a verified theorem supplying that
upgrade. Parameter domains that move with the spatial coordinate require explicit contained polydisks,
not pointwise existential radii.

## 9. Derivative profiles and normalized jets

### 9.1 Real-facing derivative profiles

A profile is useful once value and several derivative bounds travel together. The candidate proof-facing
structure is:

```lean
structure DerivativeErrorOn
    (m : ℕ) (D Omega : Set ℝ) (f a : ℝ → ℝ)
    (b : ℕ → ℝ → ℝ) : Prop where
  open_domain : IsOpen Omega
  domain_inclusion : D ⊆ Omega
  regular_f : ContDiffOn ℝ m f Omega
  regular_a : ContDiffOn ℝ m a Omega
  bound : ∀ j, j ≤ m → ∀ x ∈ D,
    |iteratedDeriv j f x - iteratedDeriv j a x| ≤ b j x
```

The order convention is inclusive: bounds are supplied for `0 ≤ j ≤ m`. The dossier must decide
whether the exact Lean order parameter is `m` or `(m : ℕ∞)` and compile the result. Do not bundle a
claim that the profile came from Cauchy; direct differentiation and ODE stability are equally valid
producers.

### 9.2 Normalized one-variable jets

Define

\[
  J_n f(x)=\frac{f^{(n)}(x)}{n!}.
\]

The payoff is the exact convolution

\[
  J_n(fg)=\sum_{i=0}^n J_i(f)J_{n-i}(g),
\]

with no binomial coefficients. Candidate APIs include:

- `normalizedIteratedDeriv` and conversion to/from ordinary `iteratedDeriv`;
- order-zero and order-one simp lemmas, kept local or narrowly attributed;
- `normalizedIteratedDeriv_mul` in a commutative normed algebra, and an order-preserving noncommutative
  version where justified;
- finite-sum, scalar, and error-bound lemmas;
- `NormalizedDerivativeErrorOn` only if repeated consumers show it is better than mapping an ordinary
  profile through conversion lemmas.

For multi-indices use

\[
 J_\alpha f=\frac{\partial^\alpha f}{\alpha!},
 \qquad
 J_\alpha(fg)=\sum_{\beta\le\alpha}J_\beta(f)J_{\alpha-\beta}(g).
\]

The multi-index finite set, subtraction convention, and product order must be fixed before this becomes
a public API. Avoid a large jet algebra structure until finite coefficient algebra and at least two
substantial consumers agree on the representation.

## 10. Fast analytic factors and conjugated derivatives

For a rapidly varying analytic factor, estimate the amplitude before reconstructing ordinary
derivatives. If

\[
  F=e^\Phi A,
\]

define the conjugated operator

\[
  D_\Phi G=G'-\Phi'G.
\]

Then, under actual differentiability hypotheses,

\[
  D_\Phi(e^\Phi A)=e^\Phi A',
  \qquad
  D_\Phi^k(e^\Phi A)=e^\Phi A^{(k)}.
\]

Candidate recursive interface:

```lean
def conjugatedIteratedDeriv (Phi : ℂ → ℂ) : ℕ → (ℂ → ℂ) → ℂ → ℂ
  | 0,     F => F
  | k + 1, F => fun z ↦
      deriv (conjugatedIteratedDeriv Phi k F) z - deriv Phi z *
        conjugatedIteratedDeriv Phi k F z
```

The definition is only syntax until its theorems assume enough regularity for each displayed derivative.
Prove the first-order identity and the iterated identity exactly before taking norms. Ordinary derivative
bounds are then recovered by finite product/chain formulas with derivatives of `Φ` and `exp Φ` visible.

If `Φ` contains `log`, fractional powers, or a parameter-dependent exponent, the theorem imports the
accepted branch chart and states its domain. Never divide by an absolute-value envelope and call the
quotient analytic. At turning points or zeros, prefer a multi-component amplitude or a positive
nonanalytic envelope for inequalities while applying Cauchy only to genuine analytic quantities.

## 11. Permanent negative and comparison regressions

### 11.1 Entire extension plus real smallness is insufficient

Define

\[
  H(z)=e^{-z}\sin(e^{2z}).
\]

It is entire and, for real `x`,

\[
  |H(x)|\le e^{-x}.
\]

But

\[
  H'(x)=-e^{-x}\sin(e^{2x})+2e^x\cos(e^{2x}).
\]

For

\[
  x_n=\tfrac12\log(2\pi n),\qquad n\ge1,
\]

one has `H'(xₙ)=2e^{xₙ}`. Therefore no theorem may turn the real-axis bound and mere existence of an
entire extension into a derivative bound of comparable decaying scale. The regression should be a
proved public audit theorem, not only a comment.

### 11.2 Additional rejected shortcuts

- Radius `0` or an unspecified existential radius cannot instantiate the quantitative theorem.
- Holomorphy on an open ball without continuity on its closure does not match the pinned Cauchy theorem;
  use a smaller closed ball inside an open analytic domain or prove the needed `DiffContOnCl` fact.
- `iteratedDeriv (f-a)=...` is not rewritten without the exact regularity hypotheses.
- Spatial analyticity does not yield parameter or mixed derivatives.
- A coordinate partial bound does not equal a full Fréchet-derivative norm bound for free.
- A weight comparison on the center alone does not bound the boundary sphere.
- The unconstrained optimizer `k/(n+k)` is invalid when the disk crosses a cut, singularity, sector
  boundary, or original threshold.
- A Cauchy result need not replace a sharper exact differentiated identity; both can be public and their
  bounds can later be combined by a minimum lemma.

## 12. Candidate packets, exact dependencies, and acceptance

The repository currently lists `QC-001` only as a planning candidate and `EX-001` as the geometric
constant regression candidate. The following are recommended bounded slices, not additional registered
manifest members:

| Slice | Included targets | Exact predecessor boundary | Acceptance regression |
|---|---|---|---|
| `QC-CAUCHY` | main Banach-valued wrapper, optional first-derivative variant | accepted `ErrorOn`; pinned Cauchy and subtraction APIs | orders `0,1,2`, constant radius, empty generic domain |
| `QC-RADIUS` | domain-to-sphere adapter, fixed/proportional radius, threshold transport | `QC-CAUCHY`, accepted domain lemmas | formula `k!θ⁻ᵏ(1-θ)⁻ⁿx⁻ⁿ⁻ᵏ` |
| `EX-001` | geometric complex remainder, real restriction, optimized and half-radius constants, direct derivative | `QC-RADIUS`, `QC-REAL`, finite-sum algebra | `<29`, `=2048`, direct `≤10`, all with domains |
| `QC-NEG-DERIV` | the entire-function counterexample | complex exp/sine derivative facts | sequence `xₙ`, value decay, derivative growth |
| `QC-JET` | derivative profiles and normalized one-variable jets | stable derivative algebra and two consumers | product convolution and ordinary/normalized conversion |
| `QC-MIXED` | bivariate, then finite-dimensional polydisk estimate | accepted scalar Cauchy and product analyticity | mixed order `(0,0)`, coordinate orders, radius product |
| `QC-GAUGE` | conjugated derivative exact identities and bounds | accepted branch layer if needed; derivative product algebra | `k=0,1,2`, constant/linear phase |

The first M3 exit requires only the bounded domain, real-restriction, `QC-CAUCHY`, `QC-RADIUS`,
`EX-001`, and negative-regression slices. Jets, mixed derivatives, and fast factors remain later track-D
work unless separately carded. None is on the Watson critical path.

## 13. Proof-dossier requirements

Every quantitative derivative packet supplies, before Lean:

1. exact quantified statements and signature artifacts, including codomain completeness and binder
   order;
2. the actual complex domain, open/closed disk distinction, strictly positive radius, and a disk
   containment proof;
3. the analytic-to-`DiffContOnCl` construction and the exact derivative-of-difference step;
4. the boundary majorant and its nonnegativity provenance;
5. every factorial, radius, weight, threshold, coordinate, and real-restriction loss;
6. order-zero, order-one, small-order, empty-domain, and boundary cases;
7. exact constant/domain regressions, including `29` versus `2048` where applicable;
8. an adversarial example, especially the entire real-axis counterexample;
9. dependency provenance from the pinned Mathlib commit or an already accepted LMLF packet;
10. a laundering check showing that no premise is equivalent to the intended named derivative
    conclusion.

For mixed derivatives, add the polydisk closure, joint analyticity, multi-index convention, coordinate
order/commutation proof, and ambient-norm comparison. For fast factors, add the exact conjugated identity,
phase branch, and all phase-derivative bounds before estimating. The dossier follows the repository's
[proof-artifact schema](../automation/proof_artifact_schema.md); its side-condition and constant-loss
ledgers are normative inputs to review, not optional exposition.

## 14. Independent-review gates

Follow [the repository protocol](../../review/PROTOCOL.md) rather than treating this document as an
approval.

- New quantitative statements require two independent pre-Lean reviews of the frozen theorem card and
  proof dossier. A source/semantics reviewer checks variables, derivative meaning, domains, branches,
  and real agreement; a proof/quantitative reviewer independently re-derives radii, factorials,
  thresholds, and constants.
- Branch-dependent parameter or continuation packets also require the third structural/circularity
  review mandated by the roadmap.
- Implementation review applies `quantitative_correctness`, `mathlib_reuse`, `api_dependency`, and
  `proof_quality`; apply `source_fidelity` to every source-facing or named-function corollary.
- Review evidence binds the exact toolchain and full resolved Mathlib commit. Every candidate-head or
  upstream-artifact change invalidates prior implementation verdicts.
- Release evidence includes complete builds, axiom reports, exact changed declarations, import edges,
  and regression output. Filled verdicts and dispositions stay outside the candidate head.

`cauchy_bound` automation is prohibited at this stage. Consider it only after several accepted explicit-
radius proofs exhibit one stable invocation pattern. A future tactic may apply an already proved theorem
and expose positivity, geometry, and boundary-bound goals; it may not discover extensions, radii,
branches, or constants.

## 15. Open research and implementation risks

1. **All-orders real restriction (P1):** the exact induction and coercion-normal form are not packaged by
   the pinned API.
2. **Polydisk estimate (P1):** the product-factorial bound is new project work; boundary-torus versus
   closed-polydisk assumptions materially change the proof.
3. **Joint versus separate analyticity (P1):** an invalid upgrade would make mixed derivative claims
   unsound at the specification level even if a nearby theorem compiles under stronger assumptions.
4. **Constrained radius optimization (P1):** the analytic-domain margin may be the active constraint;
   optimizing only the radial factor can state the wrong domain.
5. **Normalized-jet API (P2):** multi-index subtraction, noncommutative product order, and coercions may
   create more adapter noise than they remove until consumers stabilize.
6. **Fast phases (P1):** recovering ordinary derivatives can reintroduce large phase terms and Bell-type
   combinatorics; the amplitude estimate alone is not the advertised derivative theorem.
7. **Closure regularity (P1):** application proofs often know analyticity on an open neighborhood but
   must still select a smaller radius and prove closed-ball containment to obtain `DiffContOnCl`.
8. **Constant regression (P1):** algebraic simplification can obscure the natural factor or preserve a
   smaller number only by shrinking the domain.
9. **Import and elaboration cost (P2):** keep product analytic and Fréchet machinery out of the initial
   scalar wrapper; profile before claiming a performance defect.
10. **Mathlib drift (P1):** the Cauchy and iterated-derivative APIs are pinned, but future signatures and
    namespaces may change; re-audit at every pin update.

## 16. M3 exit criteria

The derivative demonstrator is complete when one accepted complex remainder theorem yields a real
derivative estimate through this explicit chain:

```text
identified complex and real functions + neighborhood agreement
  -> positive chosen radius and closed-disk containment
  -> boundary weight/threshold comparison
  -> pinned Mathlib Cauchy wrapper
  -> iterated derivative of the difference
  -> real derivative restriction
  -> explicit constant and changed domain
```

The release must preserve the optimized `11(11/10)^10 < 29` result, the half-radius `2048` comparison,
the sharper direct geometric derivative bound, and the entire-function negative theorem. All theorem
cards, natural-language proofs, independent verdicts, exact-head implementation checks, and external
dispositions must pass. No named-function, source-coverage, mixed-derivative, or tactic claim is implied
by completing only this slice.
