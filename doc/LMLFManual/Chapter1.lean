import VersoManual
import Verso.Code.External
import LMLF.Quantitative.Basic
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "Finite error bounds" =>
%%%
tag := "chapter-1"
%%%

This chapter introduces only LMLF notation. General analysis already available in Mathlib is not
repeated.

# 1.1 Pointwise bounds
%%%
number := false
%%%

`ErrorOn D f a b` says that `a x` approximates `f x` throughout `D`, with the explicit pointwise
error `b x`. `NormBoundOn D f b` is the same language for a bound on `f` itself.

:::leanStatement "Lean · QuantitativeAnalysis"
```anchor quantitativeBasicContext (module := LMLF.Quantitative.Basic) -showProofStates
namespace QuantitativeAnalysis

variable {X E : Type*} [NormedAddCommGroup E]
```

```anchor ErrorOn (module := LMLF.Quantitative.Basic) -showProofStates
def ErrorOn (D : Set X) (f a : X → E) (b : X → ℝ) : Prop :=
  ∀ x ∈ D, ‖f x - a x‖ ≤ b x
```

```anchor NormBoundOn (module := LMLF.Quantitative.Basic) -showProofStates
def NormBoundOn (D : Set X) (f : X → E) (b : X → ℝ) : Prop :=
  ∀ x ∈ D, ‖f x‖ ≤ b x
```
:::

# 1.2 Elementary rules
%%%
number := false
%%%

Exact equality gives zero error. A bound can be restricted to a smaller domain, enlarged, composed
with another approximation by the triangle inequality, or pulled back along a change of variables.

:::leanStatement "Lean · QuantitativeAnalysis.ErrorOn"
```anchor quantitativeBasicContext (module := LMLF.Quantitative.Basic) -showProofStates
namespace QuantitativeAnalysis

variable {X E : Type*} [NormedAddCommGroup E]
```

```anchor quantitativeMapContext (module := LMLF.Quantitative.Basic) -showProofStates
variable {Y : Type*}
```

```anchor errorOnNamespace (module := LMLF.Quantitative.Basic) -showProofStates
namespace ErrorOn
```

```anchor ErrorOn.exact (module := LMLF.Quantitative.Basic) -showProofStates
theorem exact {D : Set X} {f a : X → E} (h : Set.EqOn f a D) :
    ErrorOn D f a (fun _ ↦ 0)
```

```anchor ErrorOn.restrict (module := LMLF.Quantitative.Basic) -showProofStates
theorem restrict {D D' : Set X} {f a : X → E} {b : X → ℝ}
    (h : ErrorOn D f a b) (hD : D' ⊆ D) :
    ErrorOn D' f a b
```

```anchor ErrorOn.weaken (module := LMLF.Quantitative.Basic) -showProofStates
theorem weaken {D : Set X} {f a : X → E} {b d : X → ℝ}
    (h : ErrorOn D f a b) (hbd : ∀ x ∈ D, b x ≤ d x) :
    ErrorOn D f a d
```

```anchor ErrorOn.trans (module := LMLF.Quantitative.Basic) -showProofStates
theorem trans {D : Set X} {f a c : X → E} {b d : X → ℝ}
    (hfa : ErrorOn D f a b) (hac : ErrorOn D a c d) :
    ErrorOn D f c (fun x ↦ b x + d x)
```

```anchor ErrorOn.comp (module := LMLF.Quantitative.Basic) -showProofStates
theorem comp {D : Set X} {f a : X → E} {b : X → ℝ}
    (h : ErrorOn D f a b) {S : Set Y} (ψ : Y → X)
    (hψ : Set.MapsTo ψ S D) :
    ErrorOn S (f ∘ ψ) (a ∘ ψ) (b ∘ ψ)
```
:::
