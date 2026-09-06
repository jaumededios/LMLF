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

:::leanStatement "Lean definitions"
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

:::leanStatement "Lean theorems"
```anchor ErrorOn.exact (module := LMLF.Quantitative.Basic) -showProofStates
theorem exact {D : Set X} {f a : X → E} (h : Set.EqOn f a D) :
    ErrorOn D f a (fun _ ↦ 0) := by
  intro x hx
  simpa only [h hx, sub_self, norm_zero] using (le_refl (0 : ℝ))
```

```anchor ErrorOn.restrict (module := LMLF.Quantitative.Basic) -showProofStates
theorem restrict {D D' : Set X} {f a : X → E} {b : X → ℝ}
    (h : ErrorOn D f a b) (hD : D' ⊆ D) :
    ErrorOn D' f a b := by
  intro x hx
  exact h x (hD hx)
```

```anchor ErrorOn.weaken (module := LMLF.Quantitative.Basic) -showProofStates
theorem weaken {D : Set X} {f a : X → E} {b d : X → ℝ}
    (h : ErrorOn D f a b) (hbd : ∀ x ∈ D, b x ≤ d x) :
    ErrorOn D f a d := by
  intro x hx
  exact (h x hx).trans (hbd x hx)
```

```anchor ErrorOn.trans (module := LMLF.Quantitative.Basic) -showProofStates
theorem trans {D : Set X} {f a c : X → E} {b d : X → ℝ}
    (hfa : ErrorOn D f a b) (hac : ErrorOn D a c d) :
    ErrorOn D f c (fun x ↦ b x + d x) := by
  intro x hx
  calc
    ‖f x - c x‖ = ‖(f x - a x) + (a x - c x)‖ := by rw [sub_add_sub_cancel]
    _ ≤ ‖f x - a x‖ + ‖a x - c x‖ := norm_add_le _ _
    _ ≤ b x + d x := add_le_add (hfa x hx) (hac x hx)
```

```anchor ErrorOn.comp (module := LMLF.Quantitative.Basic) -showProofStates
theorem comp {D : Set X} {f a : X → E} {b : X → ℝ}
    (h : ErrorOn D f a b) {S : Set Y} (ψ : Y → X)
    (hψ : Set.MapsTo ψ S D) :
    ErrorOn S (f ∘ ψ) (a ∘ ψ) (b ∘ ψ) := by
  intro y hy
  exact h (ψ y) (hψ hy)
```
:::
