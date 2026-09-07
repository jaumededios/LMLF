import Mathlib.Analysis.SpecialFunctions.Gamma.BohrMollerup
import Mathlib.Analysis.SpecialFunctions.Gamma.Digamma

/-!
# DLMF section 5.5: Functional Relations

Statements for the recurrence, reflection, and multiplication formulas of the Gamma and digamma
functions, together with the Bohr--Mollerup characterization of the real Gamma function.

The pointwise complex statements explicitly exclude the poles occurring in their formulas. This is
important because Mathlib totalizes `Complex.Gamma` at nonpositive integers and defines
`Complex.digamma` through a total logarithmic derivative.
-/

-- ANCHOR: section55Context
namespace LMLF.Blueprint.Gamma

open scoped BigOperators Real
-- ANCHOR_END: section55Context

/-- DLMF 5.5.1: the Gamma recurrence relation, on the ordinary pointwise domain of `Gamma`. -/
-- ANCHOR: gamma_recurrence
theorem gamma_recurrence (z : ℂ) (hz : ∀ m : ℕ, z ≠ -(m : ℂ)) :
    Complex.Gamma (z + 1) = z * Complex.Gamma z
-- ANCHOR_END: gamma_recurrence
:= by
  sorry

/-- DLMF 5.5.2: the digamma recurrence relation. -/
-- ANCHOR: digamma_recurrence
theorem digamma_recurrence (z : ℂ) (hz : ∀ m : ℕ, z ≠ -(m : ℂ)) :
    Complex.digamma (z + 1) = Complex.digamma z + 1 / z
-- ANCHOR_END: digamma_recurrence
:= by
  sorry

/-- DLMF 5.5.3: Euler's reflection formula for the Gamma function. -/
-- ANCHOR: gamma_reflection
theorem gamma_reflection (z : ℂ) (hz : ∀ k : ℤ, z ≠ (k : ℂ)) :
    Complex.Gamma z * Complex.Gamma (1 - z) =
      (Real.pi : ℂ) / Complex.sin ((Real.pi : ℂ) * z)
-- ANCHOR_END: gamma_reflection
:= by
  sorry

/-- DLMF 5.5.4: the reflection formula for the digamma function. -/
-- ANCHOR: digamma_reflection
theorem digamma_reflection (z : ℂ) (hz : ∀ k : ℤ, z ≠ (k : ℂ)) :
    Complex.digamma z - Complex.digamma (1 - z) =
      -(Real.pi : ℂ) / Complex.tan ((Real.pi : ℂ) * z)
-- ANCHOR_END: digamma_reflection
:= by
  sorry

/-- DLMF 5.5.5: Legendre's duplication formula for the Gamma function. -/
-- ANCHOR: gamma_duplication
theorem gamma_duplication (z : ℂ) (hz : ∀ m : ℕ, 2 * z ≠ -(m : ℂ)) :
    Complex.Gamma (2 * z) =
      (Real.pi : ℂ) ^ (-1 / 2 : ℂ) * (2 : ℂ) ^ (2 * z - 1) *
        Complex.Gamma z * Complex.Gamma (z + 1 / 2)
-- ANCHOR_END: gamma_duplication
:= by
  sorry

/-- DLMF 5.5.6: Gauss's multiplication formula for the Gamma function. -/
-- ANCHOR: gamma_multiplication
theorem gamma_multiplication (n : ℕ) (hn : 0 < n) (z : ℂ)
    (hz : ∀ m : ℕ, (n : ℂ) * z ≠ -(m : ℂ)) :
    Complex.Gamma ((n : ℂ) * z) =
      (2 * (Real.pi : ℂ)) ^ ((1 - (n : ℂ)) / 2) *
        (n : ℂ) ^ ((n : ℂ) * z - 1 / 2) *
          ∏ k ∈ Finset.range n, Complex.Gamma (z + (k : ℂ) / (n : ℂ))
-- ANCHOR_END: gamma_multiplication
:= by
  sorry

/-- DLMF 5.5.7: the finite product of Gamma values at the nonzero fractions with denominator `n`. -/
-- ANCHOR: gamma_rational_product
theorem gamma_rational_product (n : ℕ) (hn : 0 < n) :
    (∏ k ∈ Finset.Ico 1 n, Real.Gamma ((k : ℝ) / (n : ℝ))) =
      (2 * Real.pi) ^ (((n : ℝ) - 1) / 2) * (n : ℝ) ^ (-1 / 2 : ℝ)
-- ANCHOR_END: gamma_rational_product
:= by
  sorry

/-- DLMF 5.5.8: the duplication formula for the digamma function. -/
-- ANCHOR: digamma_duplication
theorem digamma_duplication (z : ℂ) (hz : ∀ m : ℕ, 2 * z ≠ -(m : ℂ)) :
    Complex.digamma (2 * z) =
      (Complex.digamma z + Complex.digamma (z + 1 / 2)) / 2 + Complex.log 2
-- ANCHOR_END: digamma_duplication
:= by
  sorry

/-- DLMF 5.5.9: Gauss's multiplication formula for the digamma function. -/
-- ANCHOR: digamma_multiplication
theorem digamma_multiplication (n : ℕ) (hn : 0 < n) (z : ℂ)
    (hz : ∀ m : ℕ, (n : ℂ) * z ≠ -(m : ℂ)) :
    Complex.digamma ((n : ℂ) * z) =
      (1 / (n : ℂ)) *
          ∑ k ∈ Finset.range n, Complex.digamma (z + (k : ℂ) / (n : ℂ))
        + Complex.log (n : ℂ)
-- ANCHOR_END: digamma_multiplication
:= by
  sorry

/-- DLMF 5.5(iv), Bohr--Mollerup: Gamma is the unique positive log-convex normalized solution of
the Gamma recurrence on the positive real axis. -/
-- ANCHOR: bohrMollerup_unique
theorem bohrMollerup_unique {f : ℝ → ℝ}
    (hf_pos : ∀ {x : ℝ}, 0 < x → 0 < f x)
    (hf_recurrence : ∀ {x : ℝ}, 0 < x → f (x + 1) = x * f x)
    (hf_one : f 1 = 1)
    (hf_logConvex : ConvexOn ℝ (Set.Ioi 0) (Real.log ∘ f)) :
    Set.EqOn f Real.Gamma (Set.Ioi 0)
-- ANCHOR_END: bohrMollerup_unique
:= by
  sorry

end LMLF.Blueprint.Gamma
