import VersoManual
import Verso.Code.External
import LMLF.Integral.Improper.Basic
import LMLF.Integral.Improper.Bochner
import LMLF.Integral.Improper.Abel
import LMLF.Integral.Curve
import LMLF.Integral.Domain
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "Improper integrals" =>
%%%
tag := "chapter-3"
%%%

This chapter introduces LMLF's interface for improper integrals on a half-line with finitely many
singular points. It records ordinary one-sided convergence at every singularity: contributions from
opposite sides are never allowed to cancel as a principal value.

Throughout, `E` is a complete normed real vector space.

# 3.1 Improper integrals with finitely many exceptional points
%%%
number := false
%%%

`HasImproperIntegralAtTopExcept f k S I` means that all points of `S` lie strictly to the right of
`k`, and that the integral of `f` from `k` to `+∞` is `I`. Each interval cut out by the ordered
points of `S` must converge independently at both ends. Thus the definition expresses an ordinary
improper integral, not a Cauchy principal value.

The recursive definitions below spell out those independent limits. The empty list is the final
interval ending at `+∞`; a nonempty list handles one singular point and then the remaining tail.

:::leanStatement "Lean · LMLF.Integral"
```anchor improperBasicContext (module := LMLF.Integral.Improper.Basic) -showProofStates
namespace LMLF.Integral

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
```

```anchor HasImproperIntegralTailFromBreaks (module := LMLF.Integral.Improper.Basic) -showProofStates
def HasImproperIntegralTailFromBreaks
    [CompleteSpace E] (f : ℝ → E) (c : ℝ) : List ℝ → E → Prop
  | [], I =>
      ∃ d : ℝ, ∃ L R : E, c < d ∧
        (∀ {a b : ℝ}, c < a → a ≤ b →
          IntervalIntegrable f volume a b) ∧
        Tendsto (fun a => ∫ t in a..d, f t)
          (nhdsWithin c (Ioi c)) (nhds L) ∧
        Tendsto (fun b => ∫ t in d..b, f t) atTop (nhds R) ∧
        I = L + R
  | d :: ds, I =>
      ∃ p : ℝ, ∃ L R J : E, c < p ∧ p < d ∧
        (∀ {a b : ℝ}, c < a → a ≤ b → b < d →
          IntervalIntegrable f volume a b) ∧
        Tendsto (fun a => ∫ t in a..p, f t)
          (nhdsWithin c (Ioi c)) (nhds L) ∧
        Tendsto (fun b => ∫ t in p..b, f t)
          (nhdsWithin d (Iio d)) (nhds R) ∧
        HasImproperIntegralTailFromBreaks f d ds J ∧
        I = L + R + J
```

```anchor HasImproperIntegralAtTopBreaks (module := LMLF.Integral.Improper.Basic) -showProofStates
def HasImproperIntegralAtTopBreaks
    [CompleteSpace E] (f : ℝ → E) (k : ℝ) : List ℝ → E → Prop
  | [], I =>
      (∀ {b : ℝ}, k ≤ b → IntervalIntegrable f volume k b) ∧
      Tendsto (fun b => ∫ t in k..b, f t) atTop (nhds I)
  | c :: cs, I =>
      ∃ L J : E, k < c ∧
        (∀ {b : ℝ}, k ≤ b → b < c →
          IntervalIntegrable f volume k b) ∧
        Tendsto (fun b => ∫ t in k..b, f t)
          (nhdsWithin c (Iio c)) (nhds L) ∧
        HasImproperIntegralTailFromBreaks f c cs J ∧
        I = L + J
```

```anchor HasImproperIntegralAtTopExcept (module := LMLF.Integral.Improper.Basic) -showProofStates
def HasImproperIntegralAtTopExcept
    [CompleteSpace E] (f : ℝ → E) (k : ℝ) (S : Finset ℝ) (I : E) : Prop :=
  (∀ c ∈ S, k < c) ∧
    HasImproperIntegralAtTopBreaks f k (S.sort (· ≤ ·)) I
```
:::

Finite-dimensional formulas use the same object-first discipline. A
`MultidimensionalDomain n` fixes the coordinate type `Fin n → ℝ` and its carrier;
`domainIntegral` is the restricted volume integral, while `domainIntegrable`
records convergence separately. This lets Chapter 5 name a simplex, cube, or
orthant without duplicating measure-theoretic plumbing.

:::leanStatement "Lean · typed multidimensional domains"
```anchor MultidimensionalDomain (module := LMLF.Integral.Domain) -showProofStates
structure MultidimensionalDomain (n : ℕ) where
  carrier : Set (Fin n → ℝ)
```

```anchor domainIntegral (module := LMLF.Integral.Domain) -showProofStates
noncomputable def domainIntegral {n : ℕ} (D : MultidimensionalDomain n)
    (f : (Fin n → ℝ) → ℝ) : ℝ :=
  ∫ t in D.carrier, f t
```

```anchor domainIntegrable (module := LMLF.Integral.Domain) -showProofStates
def domainIntegrable {n : ℕ} (D : MultidimensionalDomain n)
    (f : (Fin n → ℝ) → ℝ) : Prop :=
  IntegrableOn f D.carrier volume
```
:::

When the improper integral exists, its value is unique.

:::leanStatement "Lean · LMLF.Integral"
```anchor improperBasicContext (module := LMLF.Integral.Improper.Basic) -showProofStates
namespace LMLF.Integral

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
```

```anchor HasImproperIntegralAtTopExcept.unique (module := LMLF.Integral.Improper.Basic) -showProofStates
theorem HasImproperIntegralAtTopExcept.unique
    [CompleteSpace E] {f : ℝ → E} {k : ℝ} {S : Finset ℝ} {I J : E}
    (hI : HasImproperIntegralAtTopExcept f k S I)
    (hJ : HasImproperIntegralAtTopExcept f k S J) : I = J
```
:::

# 3.2 Continuous primitives across the exceptional set
%%%
number := false
%%%

`IsFiniteExceptionalPrimitive g k S F` packages a primitive normalized by `F k = 0`. The function
`F` is continuous on `[k,+∞)`, and on every compact interval avoiding `S` its increment is the
integral of `g`.

:::leanStatement "Lean · LMLF.Integral"
```anchor improperBasicContext (module := LMLF.Integral.Improper.Basic) -showProofStates
namespace LMLF.Integral

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
```

```anchor IsFiniteExceptionalPrimitive (module := LMLF.Integral.Improper.Basic) -showProofStates
def IsFiniteExceptionalPrimitive
    [CompleteSpace E] (g : ℝ → E) (k : ℝ) (S : Finset ℝ) (F : ℝ → E) : Prop :=
  (∀ c ∈ S, k < c) ∧
    ContinuousOn F (Ici k) ∧
    F k = 0 ∧
    ∀ {a b : ℝ}, k ≤ a → a ≤ b →
      Disjoint (Icc a b) (↑S : Set ℝ) →
      IntervalIntegrable g volume a b ∧
        F b - F a = ∫ t in a..b, g t
```
:::

The improper integral has value `I` exactly when such a normalized primitive tends to `I` at
`+∞`. This is the bridge between local antiderivative identities and the global improper value.

:::leanStatement "Lean · LMLF.Integral"
```anchor hasImproperIntegralAtTopExcept_iff_exists_primitive (module := LMLF.Integral.Improper.Basic) -showProofStates
theorem hasImproperIntegralAtTopExcept_iff_exists_primitive
    [CompleteSpace E] {f : ℝ → E} {k : ℝ} {S : Finset ℝ} {I : E} :
    HasImproperIntegralAtTopExcept f k S I ↔
      ∃ F : ℝ → E,
        IsFiniteExceptionalPrimitive f k S F ∧
          Tendsto F atTop (nhds I)
```
:::

# 3.3 Algebra and a change of starting point
%%%
number := false
%%%

Finite sums may be formed before integration. Each summand may also be sent through its own
continuous linear map; the exceptional set of the sum is the union of the individual exceptional
sets, and the value is the corresponding sum of mapped values.

:::leanStatement "Lean · LMLF.Integral"
```anchor improperBasicContext (module := LMLF.Integral.Improper.Basic) -showProofStates
namespace LMLF.Integral

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
```

```anchor HasImproperIntegralAtTopExcept.finset_clm (module := LMLF.Integral.Improper.Basic) -showProofStates
theorem HasImproperIntegralAtTopExcept.finset_clm
    {H : Type*} [NormedAddCommGroup H] [NormedSpace ℝ H]
    [CompleteSpace E] [CompleteSpace H]
    {A : Type*} (s : Finset A) (f : A → ℝ → E)
    (S : A → Finset ℝ) (I : A → E) (T : A → E →L[ℝ] H) {k : ℝ}
    (h : ∀ i ∈ s, HasImproperIntegralAtTopExcept (f i) k (S i) (I i)) :
    HasImproperIntegralAtTopExcept
      (fun t => ∑ i ∈ s, T i (f i t)) k
      (s.biUnion S) (∑ i ∈ s, T i (I i))
```
:::

If `f` is integrable on the compact prefix from `a` to `k`, moving the starting point from `k` back
to `a` adds precisely that ordinary integral to the improper value.

:::leanStatement "Lean · LMLF.Integral"
```anchor HasImproperIntegralAtTopExcept.split_regular (module := LMLF.Integral.Improper.Basic) -showProofStates
theorem HasImproperIntegralAtTopExcept.split_regular
    [CompleteSpace E] (f : ℝ → E) {a k : ℝ} (S : Finset ℝ) (I : E)
    (hak : a ≤ k) (hS : ∀ c ∈ S, k < c)
    (hf : IntervalIntegrable f volume a k) :
    HasImproperIntegralAtTopExcept f a S ((∫ t in a..k, f t) + I) ↔
      HasImproperIntegralAtTopExcept f k S I
```
:::

# 3.4 Absolutely integrable functions
%%%
number := false
%%%

Bochner integrability on `(k,+∞)` supplies an improper integral immediately. Any declared
exceptional points are harmless in this case, and the improper value is the usual set integral.

:::leanStatement "Lean · LMLF.Integral"
```anchor improperBochnerContext (module := LMLF.Integral.Improper.Bochner) -showProofStates
namespace LMLF.Integral

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
```

```anchor HasImproperIntegralAtTopExcept.of_integrableOn_Ioi (module := LMLF.Integral.Improper.Bochner) -showProofStates
theorem HasImproperIntegralAtTopExcept.of_integrableOn_Ioi
    [CompleteSpace E] (f : ℝ → E) (k : ℝ) (S : Finset ℝ)
    (hS : ∀ c ∈ S, k < c) (hf : IntegrableOn f (Ioi k)) :
    HasImproperIntegralAtTopExcept f k S (∫ t in Ioi k, f t)
```
:::

# 3.5 Abel reweighting
%%%
number := false
%%%

Let `F` be the normalized primitive of `g`. Multiplication by the exponential weight
`exp (-h t)` gives an improper integral whenever the weighted primitive is integrable and its
boundary term tends to zero. Integration by parts identifies the value as `h` times the integral of
the weighted primitive.

:::leanStatement "Lean · LMLF.Integral"
```anchor improperAbelContext (module := LMLF.Integral.Improper.Abel) -showProofStates
namespace LMLF.Integral

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
```

```anchor IsFiniteExceptionalPrimitive.hasImproperIntegralAtTopExcept_exp_smul (module := LMLF.Integral.Improper.Abel) -showProofStates
theorem IsFiniteExceptionalPrimitive.hasImproperIntegralAtTopExcept_exp_smul
    [CompleteSpace E] {g F : ℝ → E} {k : ℝ} {S : Finset ℝ}
    (hF : IsFiniteExceptionalPrimitive g k S F) (h : ℝ)
    (hInt : IntegrableOn (fun t => Real.exp (-h * t) • F t) (Ioi k))
    (hLim : Tendsto (fun R => Real.exp (-h * R) • F R)
      atTop (nhds 0)) :
    HasImproperIntegralAtTopExcept
      (fun t => Real.exp (-h * t) • g t) k S
      (h • ∫ t in Ioi k, Real.exp (-h * t) • F t)
```
:::

# 3.6 Complex contour integrals
%%%
number := false
%%%

A `C1Contour` is a continuously differentiable map $`\gamma:[0,1]\to\mathbb C`
with named endpoints and a continuous tangent $`\gamma'`. Storing the tangent
and its within-interval derivative law avoids using a totalized derivative at
the endpoints. Its integral is the familiar parameterized integral
$$`\int_\gamma f(z)\,\mathrm dz
  =\int_0^1 f(\gamma(t))\gamma'(t)\,\mathrm dt.`

:::leanStatement "Lean · C¹ contours and dγ"
```anchor C1Contour (module := LMLF.Integral.Curve) -showProofStates
structure C1Contour where
  point : ℝ → ℂ
  tangent : ℝ → ℂ
  start : ℂ
  finish : ℂ
  point_zero : point 0 = start
  point_one : point 1 = finish
  hasDeriv : ∀ t ∈ Icc (0 : ℝ) 1,
    HasDerivWithinAt point (tangent t) (Icc 0 1) t
  tangent_continuous : ContinuousOn tangent (Icc 0 1)
```

```anchor C1Contour.integral (module := LMLF.Integral.Curve) -showProofStates
def C1Contour.integral (γ : C1Contour) (f : ℂ → ℂ) : ℂ :=
  ∫ t in (0 : ℝ)..1, f (γ t) * γ.tangent t
```

```anchor C1Contour.Integrable (module := LMLF.Integral.Curve) -showProofStates
def C1Contour.Integrable (γ : C1Contour) (f : ℂ → ℂ) : Prop :=
  IntervalIntegrable (fun t => f (γ t) * γ.tangent t) volume 0 1
```
:::

A contour assembled from finitely many smooth pieces uses
`PiecewiseC1Contour`. Its finite break set is constrained to `[0,1]`, the path
is continuous across every join, and the endpoint equations expose the start
and finish compatibility. The tangent may jump at a join, but away from the
break set it is the derivative and is continuous on the remaining pieces.

:::leanStatement "Lean · piecewise C¹ contours"
```anchor PiecewiseC1Contour (module := LMLF.Integral.Curve) -showProofStates
structure PiecewiseC1Contour where
  point : ℝ → ℂ
  tangent : ℝ → ℂ
  start : ℂ
  finish : ℂ
  breaks : Finset ℝ
  breaks_mem : ∀ t ∈ breaks, t ∈ Icc (0 : ℝ) 1
  point_zero : point 0 = start
  point_one : point 1 = finish
  point_continuous : ContinuousOn point (Icc (0 : ℝ) 1)
  hasDerivOffBreaks : ∀ t ∈ Icc (0 : ℝ) 1, t ∉ breaks →
    HasDerivAt point (tangent t) t
  tangent_continuous_off_breaks :
    ContinuousOn tangent (Icc (0 : ℝ) 1 \ (breaks : Set ℝ))
```

```anchor PiecewiseC1Contour.integral₂ (module := LMLF.Integral.Curve) -showProofStates
def PiecewiseC1Contour.integral₂ (γ : PiecewiseC1Contour)
    (f : ℂ → ℂ → ℂ → ℂ) (log₁ log₂ : ℝ → ℂ) : ℂ :=
  ∫ t in (0 : ℝ)..1, f (γ.point t) (log₁ t) (log₂ t) * γ.tangent t
```

```anchor PiecewiseC1Contour.Integrable₂ (module := LMLF.Integral.Curve) -showProofStates
def PiecewiseC1Contour.Integrable₂ (γ : PiecewiseC1Contour)
    (f : ℂ → ℂ → ℂ → ℂ) (log₁ log₂ : ℝ → ℂ) : Prop :=
  IntervalIntegrable
    (fun t => f (γ.point t) (log₁ t) (log₂ t) * γ.tangent t) volume 0 1
```
:::

For Mellin--Barnes formulas, `VerticalLine` is the canonical upward contour
`t ↦ c + it`. Its whole-line Bochner integral is distinct from the symmetric
finite-cutoff interface used for formulas whose convergence is stated as a
limit of finite segments.

:::leanStatement "Lean · vertical-line contours"
```anchor VerticalLine (module := LMLF.Integral.Curve) -showProofStates
structure VerticalLine where
  offset : ℝ
```

```anchor VerticalLine.point (module := LMLF.Integral.Curve) -showProofStates
def VerticalLine.point (γ : VerticalLine) (t : ℝ) : ℂ :=
  (γ.offset : ℂ) + (t : ℂ) * Complex.I
```

```anchor VerticalLine.tangent (module := LMLF.Integral.Curve) -showProofStates
def VerticalLine.tangent (_γ : VerticalLine) : ℂ := Complex.I
```

```anchor VerticalLine.integrand (module := LMLF.Integral.Curve) -showProofStates
def VerticalLine.integrand (γ : VerticalLine) (f : ℂ → ℂ) : ℝ → ℂ := fun t ↦
  f (γ.point t) * γ.tangent
```

```anchor VerticalLine.integral (module := LMLF.Integral.Curve) -showProofStates
noncomputable def VerticalLine.integral (γ : VerticalLine) (f : ℂ → ℂ) : ℂ :=
  ∫ t : ℝ, γ.integrand f t
```

```anchor VerticalLine.Integrable (module := LMLF.Integral.Curve) -showProofStates
def VerticalLine.Integrable (γ : VerticalLine) (f : ℂ → ℂ) : Prop :=
  MeasureTheory.Integrable (γ.integrand f)
```

```anchor verticalLine (module := LMLF.Integral.Curve) -showProofStates
def verticalLine (c : ℝ) : VerticalLine := ⟨c⟩
```

```anchor VerticalLine.symmetricSegment (module := LMLF.Integral.Curve) -showProofStates
noncomputable def VerticalLine.symmetricSegment (γ : VerticalLine) (L : ℝ) : C1Contour where
  point u := γ.point (-L + 2 * L * u)
  tangent _ := (2 * L : ℂ) * Complex.I
  start := γ.point (-L)
  finish := γ.point L
  point_zero := by sorry
  point_one := by sorry
  hasDeriv := by sorry
  tangent_continuous := by fun_prop
```

```anchor VerticalLine.symmetricSegmentIntegral (module := LMLF.Integral.Curve) -showProofStates
noncomputable def VerticalLine.symmetricSegmentIntegral
    (γ : VerticalLine) (L : ℝ) (f : ℂ → ℂ) : ℂ :=
  (γ.symmetricSegment L).integral f
```

```anchor VerticalLine.symmetricSegmentIntegrable (module := LMLF.Integral.Curve) -showProofStates
def VerticalLine.symmetricSegmentIntegrable
    (γ : VerticalLine) (f : ℂ → ℂ) : Prop :=
  ∀ L : ℝ, 0 < L → (γ.symmetricSegment L).Integrable f
```

```anchor VerticalLine.symmetricSegmentValue (module := LMLF.Integral.Curve) -showProofStates
noncomputable def VerticalLine.symmetricSegmentValue
    (γ : VerticalLine) (f : ℂ → ℂ) : ℂ :=
  limUnder atTop (fun L : ℝ => γ.symmetricSegmentIntegral L f)
```

```anchor VerticalLine.symmetricSegmentConverges (module := LMLF.Integral.Curve) -showProofStates
def VerticalLine.symmetricSegmentConverges
    (γ : VerticalLine) (f : ℂ → ℂ) : Prop :=
  Tendsto (fun L : ℝ => γ.symmetricSegmentIntegral L f) atTop
    (𝓝 (γ.symmetricSegmentValue f))
```
:::

For a ray extending to infinity, `ImproperC1Ray` stores the point, its
tangent, the initial point, a derivative certificate, tangent continuity, and
escape to infinity.  Its finite and improper integral predicates use that
stored tangent and a forward parameter limit.

:::leanStatement "Lean · typed improper C¹ rays"
```anchor ImproperC1Ray (module := LMLF.Integral.Curve) -showProofStates
structure ImproperC1Ray where
  point : ℝ → ℂ
  tangent : ℝ → ℂ
  start : ℂ
  point_zero : point 0 = start
  hasDeriv : ∀ t : ℝ, 0 ≤ t → HasDerivWithinAt point (tangent t) (Set.Ici 0) t
  tangent_continuous : ContinuousOn tangent (Set.Ici 0)
  escape : Tendsto (fun t : ℝ => ‖point t‖) atTop atTop
```

```anchor ImproperC1Ray.HasIntegral (module := LMLF.Integral.Curve) -showProofStates
def ImproperC1Ray.HasIntegral
    (γ : ImproperC1Ray) (f : ℂ → ℂ) (R : ℝ) (value : ℂ) : Prop :=
  0 ≤ R ∧
    IntervalIntegrable
        (fun t : ℝ => f (γ.point t) * γ.tangent t) volume 0 R ∧
    value = ∫ t in (0 : ℝ)..R, f (γ.point t) * γ.tangent t
```

```anchor ImproperC1Ray.HasImproperIntegral (module := LMLF.Integral.Curve) -showProofStates
def ImproperC1Ray.HasImproperIntegral
    (γ : ImproperC1Ray) (f : ℂ → ℂ) (value : ℂ) : Prop :=
  (∀ R : ℝ, 0 ≤ R →
      IntervalIntegrable
        (fun t : ℝ => f (γ.point t) * γ.tangent t) volume 0 R) ∧
    Tendsto
      (fun R : ℝ => ∫ t in (0 : ℝ)..R, f (γ.point t) * γ.tangent t)
      atTop (𝓝 value)
```
:::

Expressions such as $`z^s` or $`\log z` need more data when the contour winds
around zero. A `LogLiftedC1Contour` carries a continuous
choice of logarithm along the path. Its integral may depend on both the point
$`\gamma(t)` and the selected lift $`\operatorname{Log}_\gamma(t)`.

:::leanStatement "Lean · branch-aware contours"
```anchor LogLiftedC1Contour (module := LMLF.Integral.Curve) -showProofStates
structure LogLiftedC1Contour extends C1Contour where
  logLift : ℝ → ℂ
  logLift_continuous : ContinuousOn logLift (Icc 0 1)
  exp_logLift : ∀ t ∈ Icc (0 : ℝ) 1, Complex.exp (logLift t) = point t
```

```anchor LogLiftedC1Contour.integral (module := LMLF.Integral.Curve) -showProofStates
def LogLiftedC1Contour.integral
    (γ : LogLiftedC1Contour) (f : ℂ → ℂ → ℂ) : ℂ :=
  ∫ t in (0 : ℝ)..1,
    f (γ.point t) (γ.logLift t) * γ.tangent t
```

```anchor LogLiftedC1Contour.Integrable (module := LMLF.Integral.Curve) -showProofStates
def LogLiftedC1Contour.Integrable
    (γ : LogLiftedC1Contour) (f : ℂ → ℂ → ℂ) : Prop :=
  IntervalIntegrable
    (fun t => f (γ.point t) (γ.logLift t) * γ.tangent t) volume 0 1
```
:::

The standard finite Hankel contour has radii $`0<\varepsilon<R` and three C¹
pieces. For $`0\le u\le1`, write
$$`r_-(u)=R+u(\varepsilon-R),\qquad
  \theta(u)=-\pi+2\pi u,\qquad
  r_+(u)=\varepsilon+u(R-\varepsilon).`
The lower bank uses $`\gamma_-(u)=-r_-(u)` and
$`\operatorname{Log}_{\gamma_-}=\log r_-(u)-\pi i`; the inner circle uses
$`\gamma_0(u)=\varepsilon e^{i\theta(u)}` and
$`\operatorname{Log}_{\gamma_0}=\log\varepsilon+i\theta(u)`; the upper bank
uses $`\gamma_+(u)=-r_+(u)` and
$`\operatorname{Log}_{\gamma_+}=\log r_+(u)+\pi i`. Thus the circle is
counterclockwise and the two bank values of the logarithm are fixed in the
data.

:::leanStatement "Lean · explicit Hankel geometry"
```anchor HankelRadii (module := LMLF.Integral.Curve) -showProofStates
structure HankelRadii where
  inner : ℝ
  outer : ℝ
  inner_pos : 0 < inner
  inner_lt_outer : inner < outer
```

```anchor HankelRadii.of (module := LMLF.Integral.Curve) -showProofStates
def HankelRadii.of (ε : PositiveRadius) (R : OuterRadius ε) : HankelRadii :=
  ⟨ε, R, ε.property, R.property⟩
```

```anchor hankelLowerBank_spec (module := LMLF.Integral.Curve) -showProofStates
theorem hankelLowerBank_spec (ρ : HankelRadii) :
    (∀ u, (hankelLowerBank ρ).point u =
      -((ρ.outer + u * (ρ.inner - ρ.outer) : ℝ) : ℂ)) ∧
    (∀ u, (hankelLowerBank ρ).tangent u =
      ((ρ.outer - ρ.inner : ℝ) : ℂ)) ∧
    (∀ u, (hankelLowerBank ρ).logLift u =
      Real.log (ρ.outer + u * (ρ.inner - ρ.outer)) - Real.pi * Complex.I)
```

```anchor hankelInnerCircle_spec (module := LMLF.Integral.Curve) -showProofStates
theorem hankelInnerCircle_spec (ρ : HankelRadii) :
    (∀ u, (hankelInnerCircle ρ).point u =
      (ρ.inner : ℂ) *
        Complex.exp (((-Real.pi + 2 * Real.pi * u : ℝ) : ℂ) * Complex.I)) ∧
    (∀ u, (hankelInnerCircle ρ).tangent u =
      (ρ.inner : ℂ) *
        Complex.exp (((-Real.pi + 2 * Real.pi * u : ℝ) : ℂ) * Complex.I) *
        ((2 * Real.pi : ℝ) : ℂ) * Complex.I) ∧
    (∀ u, (hankelInnerCircle ρ).logLift u =
      Real.log ρ.inner +
        ((-Real.pi + 2 * Real.pi * u : ℝ) : ℂ) * Complex.I)
```

```anchor hankelUpperBank_spec (module := LMLF.Integral.Curve) -showProofStates
theorem hankelUpperBank_spec (ρ : HankelRadii) :
    (∀ u, (hankelUpperBank ρ).point u =
      -((ρ.inner + u * (ρ.outer - ρ.inner) : ℝ) : ℂ)) ∧
    (∀ u, (hankelUpperBank ρ).tangent u =
      -((ρ.outer - ρ.inner : ℝ) : ℂ)) ∧
    (∀ u, (hankelUpperBank ρ).logLift u =
      Real.log (ρ.inner + u * (ρ.outer - ρ.inner)) + Real.pi * Complex.I)
```

```anchor HankelContour (module := LMLF.Integral.Curve) -showProofStates
structure HankelContour where
  lowerBank : LogLiftedC1Contour
  innerCircle : LogLiftedC1Contour
  upperBank : LogLiftedC1Contour
  lower_join : lowerBank.finish = innerCircle.start
  upper_join : innerCircle.finish = upperBank.start
  closed : lowerBank.start = upperBank.finish
  lower_log_join : lowerBank.logLift 1 = innerCircle.logLift 0
  upper_log_join : innerCircle.logLift 1 = upperBank.logLift 0
```

```anchor hankelContour (module := LMLF.Integral.Curve) -showProofStates
noncomputable def hankelContour (ρ : HankelRadii) : HankelContour
```

```anchor HankelContour.integral (module := LMLF.Integral.Curve) -showProofStates
def HankelContour.integral (γ : HankelContour) (f : ℂ → ℂ → ℂ) : ℂ :=
  γ.lowerBank.integral f + γ.innerCircle.integral f + γ.upperBank.integral f
```

```anchor HankelContour.Integrable (module := LMLF.Integral.Curve) -showProofStates
def HankelContour.Integrable (γ : HankelContour) (f : ℂ → ℂ → ℂ) : Prop :=
  γ.lowerBank.Integrable f ∧ γ.innerCircle.Integrable f ∧ γ.upperBank.Integrable f
```
:::

The improper integral has two stages. Every admissible finite contour must be
integrable. At fixed positive inner radius its outer radius tends to infinity;
only then does the inner radius tend to zero. The radius subtypes ensure that
no invalid finite contour enters either limit.

:::leanStatement "Lean · Hankel convergence"
```anchor HasHankelIntegral (module := LMLF.Integral.Curve) -showProofStates
def HasHankelIntegral (f : ℂ → ℂ → ℂ) (value : ℂ) : Prop :=
  (∀ ε : PositiveRadius, ∀ R : OuterRadius ε,
      (hankelContour (HankelRadii.of ε R)).Integrable f) ∧
    ∃ outerLimit : PositiveRadius → ℂ,
      (∀ ε : PositiveRadius,
        Tendsto
          (fun R : OuterRadius ε =>
            (hankelContour (HankelRadii.of ε R)).integral f)
          atTop (nhds (outerLimit ε))) ∧
      Tendsto outerLimit positiveRadiusAtZero (nhds value)
```

```anchor HasHankelRepresentation (module := LMLF.Integral.Curve) -showProofStates
def HasHankelRepresentation
    (f : ℂ → ℂ → ℂ) (normalization value : ℂ) : Prop :=
  ∃ integral, HasHankelIntegral f integral ∧ value = normalization * integral
```
:::
