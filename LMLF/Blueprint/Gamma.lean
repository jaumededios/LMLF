import LMLF.Definitions.Gamma
import LMLF.Quantitative.Series
import Mathlib.NumberTheory.Bernoulli

/-!
# Proof-pending Gamma statements

This module contains typechecked statement design, isolated from the proved `LMLF` API.
Declarations move out of `LMLF.Blueprint` only when proofs are supplied.
-/

-- ANCHOR: stirlingContext
namespace LMLF.Blueprint.Gamma

open Filter
-- ANCHOR_END: stirlingContext
/-- The elementary part of Stirling's expansion for `log (Gamma x)`. -/
-- ANCHOR: stirlingLogMain
noncomputable def stirlingLogMain (x : ℝ) : ℝ :=
  (x - 1 / 2) * Real.log x - x + Real.log (2 * Real.pi) / 2
-- ANCHOR_END: stirlingLogMain

/-- Expand the elementary part of Stirling's formula. -/
theorem stirlingLogMain_apply (x : ℝ) :
    stirlingLogMain x =
      (x - 1 / 2) * Real.log x - x + Real.log (2 * Real.pi) / 2 :=
  rfl

/-- Term `k` is the term numbered `k + 1` in DLMF 5.11.1. -/
-- ANCHOR: stirlingLogTerm
noncomputable def stirlingLogTerm (k : ℕ) (x : ℝ) : ℝ :=
  (bernoulli (2 * k + 2) : ℝ) /
    ((2 * k + 2 : ℕ) * (2 * k + 1 : ℕ) * x ^ (2 * k + 1))
-- ANCHOR_END: stirlingLogTerm

/-- Expand a term of Stirling's series. -/
theorem stirlingLogTerm_apply (k : ℕ) (x : ℝ) :
    stirlingLogTerm k x =
      (bernoulli (2 * k + 2) : ℝ) /
        ((2 * k + 2 : ℕ) * (2 * k + 1 : ℕ) * x ^ (2 * k + 1)) :=
  rfl

/-- The real-positive specialization of the Poincaré expansion in DLMF 5.11.1. -/
-- ANCHOR: stirlingLog_hasPoincareExpansion
theorem stirlingLog_hasPoincareExpansion :
    (fun x : ℝ ↦ Real.log (Real.Gamma x) - stirlingLogMain x) ∼ₚ[atTop]
      stirlingLogTerm
-- ANCHOR_END: stirlingLog_hasPoincareExpansion
:= by
  sorry

/-- Stirling's approximation after `n` Bernoulli terms. -/
-- ANCHOR: stirlingLogApprox
noncomputable def stirlingLogApprox (n : ℕ) (x : ℝ) : ℝ :=
  stirlingLogMain x + QuantitativeAnalysis.seriesPartialSum stirlingLogTerm n x
-- ANCHOR_END: stirlingLogApprox

/-- Expand the finite Stirling approximation. -/
theorem stirlingLogApprox_apply (n : ℕ) (x : ℝ) :
    stirlingLogApprox n x =
      stirlingLogMain x + QuantitativeAnalysis.seriesPartialSum stirlingLogTerm n x :=
  rfl

/-- On the positive real axis, the remainder has the sign of and is bounded by the next term. -/
-- ANCHOR: stirlingLog_remainder_bounds
theorem stirlingLog_remainder_bounds (n : ℕ) {x : ℝ} (hx : 0 < x) :
    0 ≤
        (Real.log (Real.Gamma x) - stirlingLogApprox n x) *
          stirlingLogTerm n x ∧
      |Real.log (Real.Gamma x) - stirlingLogApprox n x| ≤
        |stirlingLogTerm n x|
-- ANCHOR_END: stirlingLog_remainder_bounds
:= by
  sorry

end LMLF.Blueprint.Gamma
