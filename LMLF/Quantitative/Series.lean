import LMLF.Quantitative.Basic
import Mathlib.Analysis.Asymptotics.AsymptoticEquivalent

/-!
# Finite truncations and asymptotic series

The definitions here package Mathlib's little-o relation together with LMLF's explicit finite error
bounds.  They do not introduce a second notion of convergence.
-/

-- ANCHOR: quantitativeSeriesContext
namespace QuantitativeAnalysis

open Asymptotics Filter

variable {X E : Type*} [NormedAddCommGroup E]
-- ANCHOR_END: quantitativeSeriesContext

/-- The sum of the first `n` terms of a function-valued series. -/
-- ANCHOR: seriesPartialSum
def seriesPartialSum (term : ℕ → X → E) (n : ℕ) (x : X) : E :=
  ∑ k ∈ Finset.range n, term k x
-- ANCHOR_END: seriesPartialSum

/-- Each successive term is asymptotically smaller in norm than its predecessor along `l`. -/
-- ANCHOR: IsAsymptoticScale
def IsAsymptoticScale (l : Filter X) (term : ℕ → X → E) : Prop :=
  ∀ n, term (n + 1) =o[l] term n
-- ANCHOR_END: IsAsymptoticScale

/--
`f` has the Poincaré expansion `term` along `l` when every finite-truncation remainder is
little-o of its last retained term. This relation does not assert convergence of an infinite sum.
-/
-- ANCHOR: HasPoincareExpansion
def HasPoincareExpansion (l : Filter X) (f : X → E) (term : ℕ → X → E) : Prop :=
  ∀ n, (fun x ↦ f x - seriesPartialSum term (n + 1) x) =o[l] term n
-- ANCHOR_END: HasPoincareExpansion

-- ANCHOR: hasPoincareExpansionNamespace
namespace HasPoincareExpansion
-- ANCHOR_END: hasPoincareExpansionNamespace

variable {l : Filter X} {f : X → E} {term : ℕ → X → E}

/-- The remainder after retaining terms `0` through `n` is little-o of term `n`. -/
-- ANCHOR: HasPoincareExpansion.remainder_isLittleO
theorem remainder_isLittleO (h : HasPoincareExpansion l f term) (n : ℕ) :
    (fun x ↦ f x - seriesPartialSum term (n + 1) x) =o[l] term n
-- ANCHOR_END: HasPoincareExpansion.remainder_isLittleO
:= h n

/-- The terms of every Poincaré expansion form an asymptotic scale. -/
-- ANCHOR: HasPoincareExpansion.isAsymptoticScale
theorem isAsymptoticScale (h : HasPoincareExpansion l f term) :
    IsAsymptoticScale l term
-- ANCHOR_END: HasPoincareExpansion.isAsymptoticScale
:= by
  sorry

end HasPoincareExpansion

/-- Every finite truncation of `term` approximates `f` with the displayed pointwise bound. -/
-- ANCHOR: HasExpansionError
def HasExpansionError
    (f : X → E) (term : ℕ → X → E)
    (D : ℕ → Set X) (bound : ℕ → X → ℝ) : Prop :=
  ∀ n, ErrorOn (D n) f (seriesPartialSum term (n + 1)) (bound n)
-- ANCHOR_END: HasExpansionError

end QuantitativeAnalysis

@[inherit_doc QuantitativeAnalysis.HasPoincareExpansion]
-- ANCHOR: poincareNotation
notation:50
  f:50 " ∼ₚ[" l:50 "] " term:50 =>
    QuantitativeAnalysis.HasPoincareExpansion l f term
-- ANCHOR_END: poincareNotation
