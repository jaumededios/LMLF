import VersoManual
import Verso.Code.External
import LMLF.Integral.Improper.Basic
import LMLF.Integral.Improper.Bochner
import LMLF.Integral.Improper.Abel
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
