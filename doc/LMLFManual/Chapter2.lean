import VersoManual
import Verso.Code.External
import LMLF.Definitions.ContinuedFraction
import LMLF.Quantitative.Series
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "Approximants and series" =>
%%%
tag := "chapter-2"
%%%

These are LMLF's small interfaces around Mathlib's finite sums, filters, and little-o relation.

# 2.1 Families of approximants
%%%
number := false
%%%

`HasErrorFamily f a D b` gives each finite order its own approximant `a n`, validity domain `D n`,
and explicit error bound `b n`.

:::leanStatement "Quantitative Lean · QuantitativeAnalysis"
```anchor quantitativeBasicContext (module := LMLF.Quantitative.Basic) -showProofStates
namespace QuantitativeAnalysis

variable {X E : Type*} [NormedAddCommGroup E]
```

```anchor HasErrorFamily (module := LMLF.Quantitative.Basic) -showProofStates
def HasErrorFamily
    (f : X → E) (a : ℕ → X → E)
    (D : ℕ → Set X) (b : ℕ → X → ℝ) : Prop :=
  ∀ n, ErrorOn (D n) f (a n) (b n)
```
:::

# 2.2 Poincaré expansions
%%%
number := false
%%%

Let `X` be the space of arguments and `E` a normed additive commutative group. The function
`term n : X → E` is the term of index `n`; `seriesPartialSum term n` retains the terms with indices
`0` through `n - 1`. The filter `l` specifies how the argument approaches the asymptotic regime.

The family `term` is an asymptotic scale along `l` when every next term is little-o of its
predecessor.
$$`t_{n+1}=o_l(t_n).`

:::leanStatement "Lean · QuantitativeAnalysis"
```anchor quantitativeSeriesContext (module := LMLF.Quantitative.Series) -showProofStates
namespace QuantitativeAnalysis

open Asymptotics Filter

variable {X E : Type*} [NormedAddCommGroup E]
```

```anchor seriesPartialSum (module := LMLF.Quantitative.Series) -showProofStates
def seriesPartialSum (term : ℕ → X → E) (n : ℕ) (x : X) : E :=
  ∑ k ∈ Finset.range n, term k x
```

```anchor IsAsymptoticScale (module := LMLF.Quantitative.Series) -showProofStates
def IsAsymptoticScale (l : Filter X) (term : ℕ → X → E) : Prop :=
  ∀ n, term (n + 1) =o[l] term n
```
:::

The notation
$$`f\sim_{\mathrm P,l}\sum_{k\ge0}t_k`
is written `f ∼ₚ[l] term` in Lean. For every `n`, the remainder after retaining terms `0` through
`n` is little-o of `term n` along `l`:
$$`f-\sum_{k=0}^{n}t_k=o_l(t_n).`

These all-orders remainder estimates imply that `term` is an asymptotic scale. The displayed series
is formal: this relation does not assert that an infinite sum converges. The subscript `ₚ`
distinguishes this relation from Mathlib's asymptotic equivalence between two functions.

:::leanStatement "Lean definition and notation"
```anchor HasPoincareExpansion (module := LMLF.Quantitative.Series) -showProofStates
def HasPoincareExpansion (l : Filter X) (f : X → E) (term : ℕ → X → E) : Prop :=
  ∀ n, (fun x ↦ f x - seriesPartialSum term (n + 1) x) =o[l] term n
```

```anchor poincareNotation (module := LMLF.Quantitative.Series) -showProofStates
notation:50
  f:50 " ∼ₚ[" l:50 "] " term:50 =>
    QuantitativeAnalysis.HasPoincareExpansion l f term
```

```anchor hasPoincareExpansionNamespace (module := LMLF.Quantitative.Series) -showProofStates
namespace HasPoincareExpansion
```

```anchor HasPoincareExpansion.remainder_isLittleO (module := LMLF.Quantitative.Series) -showProofStates
theorem remainder_isLittleO (h : HasPoincareExpansion l f term) (n : ℕ) :
    (fun x ↦ f x - seriesPartialSum term (n + 1) x) =o[l] term n
```

```anchor HasPoincareExpansion.isAsymptoticScale (module := LMLF.Quantitative.Series) -showProofStates
theorem isAsymptoticScale (h : HasPoincareExpansion l f term) :
    IsAsymptoticScale l term
```
:::

The quantitative companion keeps an explicit domain and pointwise bound for every finite
truncation. It is deliberately separate from the Poincaré relation.

:::leanStatement "Quantitative Lean definition"
```anchor HasExpansionError (module := LMLF.Quantitative.Series) -showProofStates
def HasExpansionError
    (f : X → E) (term : ℕ → X → E)
    (D : ℕ → Set X) (bound : ℕ → X → ℝ) : Prop :=
  ∀ n, ErrorOn (D n) f (seriesPartialSum term (n + 1)) (bound n)
```
:::

# 2.3 Normalized continued fractions
%%%
number := false
%%%

A continued fraction has two different lives in LMLF. Its finite convergents
are ordinary values, used in analytic convergence theorems. Its coefficient
extraction is instead performed on a formal asymptotic germ, where every
requested coefficient can be computed from a finite prefix.

The evaluator starts at coefficient zero. The optional `offset` selects a tail;
readers do not have to supply it in the usual case. Its `n`th convergent uses
numerators `offset` through `offset + n`.

:::leanStatement "Lean · finite continued fractions"
```anchor continuedFraction (module := LMLF.Definitions.ContinuedFraction) -showProofStates
def continuedFraction {K : Type*} [DivisionRing K]
    (denominator numerator : ℕ → K) (depth : ℕ) (offset : ℕ := 0) : K :=
  continuedFractionFrom denominator numerator offset depth
```

```anchor continuedFractionConvergent (module := LMLF.Definitions.ContinuedFraction) -showProofStates
def continuedFractionConvergent {K : Type*} [DivisionRing K]
    (denominator numerator : ℕ → K) (n : ℕ) (offset : ℕ := 0) : K :=
  continuedFraction denominator numerator (n + 1) (offset := offset)
```
:::

Normalized coefficients form a subtype. Its invariant says exactly that a
zero numerator terminates the fraction: all later numerators are also zero.
This convention matters because coefficients after the first zero cannot be
recovered from the value of a continued fraction.

:::leanStatement "Lean · normalized coefficient streams"
```anchor ZeroTerminated (module := LMLF.Definitions.ContinuedFraction) -showProofStates
def ZeroTerminated {K : Type} [Zero K] (a : ℕ → K) : Prop :=
  ∀ k, a k = 0 → ∀ j, k ≤ j → a j = 0
```

```anchor CFCoefficients (module := LMLF.Definitions.ContinuedFraction) -showProofStates
abbrev CFCoefficients (K : Type := ℚ) [Zero K] :=
  {a : ℕ → K // ZeroTerminated a}
```
:::

The extraction itself repeatedly takes the normalized reciprocal of the
current residual series. Its constant coefficient is the next numerator, and
the remaining coefficients form the next residual. All operations below are
finite rational arithmetic. If a nonzero residual has zero constant term, the
algorithm returns the terminating zero stream; the reconstruction and
uniqueness theorems deliberately exclude exactly that case through
`CFracRegular`.

:::leanStatement "Lean · executable triangular extraction"
```anchor normalizedReciprocalCoeff (module := LMLF.Definitions.ContinuedFraction) -showProofStates
def normalizedReciprocalCoeff (s : OddAsymptoticSeries) : ℕ → ℚ
  | 0 => 1
  | n + 1 =>
      if s 0 = 0 then 0
      else
        -(∑ i ∈ Finset.range (n + 1),
            s (i + 1) * normalizedReciprocalCoeff s (n - i)) / s 0
termination_by n => n
decreasing_by omega
```

```anchor cfracStep (module := LMLF.Definitions.ContinuedFraction) -showProofStates
def cfracStep (s : OddAsymptoticSeries) : OddAsymptoticSeries :=
  fun n => normalizedReciprocalCoeff s (n + 1)
```

```anchor cfracRemainder (module := LMLF.Definitions.ContinuedFraction) -showProofStates
def cfracRemainder (s : OddAsymptoticSeries) : ℕ → OddAsymptoticSeries
  | 0 => s
  | k + 1 => cfracStep (cfracRemainder s k)
```

```anchor cfracCoeffValue (module := LMLF.Definitions.ContinuedFraction) -showProofStates
def cfracCoeffValue (s : OddAsymptoticSeries) (k : ℕ) : ℚ :=
  if ∃ j ≤ k, cfracCoeffRaw s j = 0 then 0 else cfracCoeffRaw s k
```
:::

For an odd germ
$$`z^{-1}(s_0+s_1z^{-2}+s_2z^{-4}+\cdots),`
`cfracCoeff s` is the canonical normalized coefficient stream. The algorithm
is triangular and executable over the rationals. Under the regularity
condition shown below, its continued fraction reconstructs the germ, and it is
the only normalized coefficient stream that does so.

:::leanStatement "Lean · extraction, reconstruction, and uniqueness"
```anchor CFracRegular (module := LMLF.Definitions.ContinuedFraction) -showProofStates
def CFracRegular (s : OddAsymptoticSeries) : Prop :=
  ∀ k, cfracCoeffRaw s k = 0 → cfracRemainder s k = 0
```

```anchor cfracCoeff (module := LMLF.Definitions.ContinuedFraction) -showProofStates
def cfracCoeff (s : OddAsymptoticSeries) : CFCoefficients :=
  ⟨cfracCoeffValue s, cfracCoeffValue_zeroTerminated s⟩
```

```anchor formalContinuedFraction_cfracCoeff (module := LMLF.Definitions.ContinuedFraction) -showProofStates
theorem formalContinuedFraction_cfracCoeff
    (s : OddAsymptoticSeries) (hs : CFracRegular s) :
    formalContinuedFraction (cfracCoeff s) = PowerSeries.mk s
```

```anchor cfracCoeff_unique (module := LMLF.Definitions.ContinuedFraction) -showProofStates
theorem cfracCoeff_unique
    (s : OddAsymptoticSeries) (a : CFCoefficients)
    (hs : CFracRegular s)
    (h : formalContinuedFraction a = PowerSeries.mk s) :
    a = cfracCoeff s
```

```anchor cfracCoeff_congr_prefix (module := LMLF.Definitions.ContinuedFraction) -showProofStates
theorem cfracCoeff_congr_prefix
    (s t : OddAsymptoticSeries) (k : ℕ)
    (h : ∀ n ≤ k, s n = t n) :
    cfracCoeff s k = cfracCoeff t k
```
:::

This is not a claim that every holomorphic function has a unique continued
fraction. The canonical map applies to the normalized formal germ used by the
special-function theorem; analytic equality with the function is a separate
convergence statement.
