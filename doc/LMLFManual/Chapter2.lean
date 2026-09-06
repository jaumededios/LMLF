import VersoManual
import Verso.Code.External
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
