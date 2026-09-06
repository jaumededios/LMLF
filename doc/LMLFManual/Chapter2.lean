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

:::leanStatement "Quantitative Lean definition"
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

`seriesPartialSum term n` is the sum of the first `n` terms. The terms form an asymptotic scale when
each successive term is little-o of its predecessor along the chosen filter.

:::leanStatement "Lean definitions"
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
is written `f ∼[l] term` in Lean. It means that after terms `0` through `n` are retained, the
remainder is little-o of term `n` along `l`.

:::leanStatement "Lean definition and notation"
```anchor HasPoincareExpansion (module := LMLF.Quantitative.Series) -showProofStates
def HasPoincareExpansion (l : Filter X) (f : X → E) (term : ℕ → X → E) : Prop :=
  ∀ n, (fun x ↦ f x - seriesPartialSum term (n + 1) x) =o[l] term n
```

```anchor poincareNotation (module := LMLF.Quantitative.Series) -showProofStates
notation:50
  f:50 " ∼[" l:50 "] " term:50 =>
    QuantitativeAnalysis.HasPoincareExpansion l f term
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
