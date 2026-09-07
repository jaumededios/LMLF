import LMLF.Definitions.Gamma
import Mathlib.Analysis.SpecialFunctions.Gamma.Beta
import Mathlib.Analysis.SpecialFunctions.Gamma.Digamma
import Mathlib.NumberTheory.Harmonic.EulerMascheroni
import Mathlib.RingTheory.Polynomial.Pochhammer

/-!
# DLMF §5.2: definitions for the Gamma family

This statement module follows every numbered formula in DLMF §5.2.  The Gamma function,
digamma function, Euler–Mascheroni constant, and Pochhammer polynomials are the corresponding
Mathlib objects.  The local `pochhammerSymbol`, `fallingFactorial`, and `lahNumber` names keep the
formulas readable without introducing a second mathematical implementation.
-/

-- ANCHOR: section52Context
namespace LMLF.Blueprint.Gamma

open Filter Finset Polynomial
open scoped BigOperators
-- ANCHOR_END: section52Context

/-- DLMF 5.2.2: the digamma function is the logarithmic derivative of Gamma away from its poles. -/
-- ANCHOR: digamma_eq_gamma_deriv_div
theorem digamma_eq_gamma_deriv_div {z : ℂ} (hz : ∀ n : ℕ, z ≠ -(n : ℂ)) :
    Complex.digamma z = deriv Complex.Gamma z / Complex.Gamma z
-- ANCHOR_END: digamma_eq_gamma_deriv_div
:= by
  sorry

/-- DLMF 5.2.3: the harmonic-minus-logarithm sequence tends to Euler's constant. -/
-- ANCHOR: tendsto_harmonic_sub_log_eulerMascheroni
theorem tendsto_harmonic_sub_log_eulerMascheroni :
    Tendsto
      (fun n : ℕ ↦ (∑ k ∈ Icc 1 n, (k : ℝ)⁻¹) - Real.log n)
      atTop (nhds Real.eulerMascheroniConstant)
-- ANCHOR_END: tendsto_harmonic_sub_log_eulerMascheroni
:= by
  sorry

/-- DLMF 5.2.3: the displayed twenty-decimal approximation to Euler's constant. -/
-- ANCHOR: eulerMascheroni_decimal
theorem eulerMascheroni_decimal :
    |Real.eulerMascheroniConstant - 0.57721566490153286060| < 1 / 10 ^ 20
-- ANCHOR_END: eulerMascheroni_decimal
:= by
  sorry

/-- DLMF 5.2.4: the Pochhammer symbol, using Mathlib's ascending Pochhammer polynomial. -/
-- ANCHOR: pochhammerSymbol
noncomputable def pochhammerSymbol {R : Type*} [CommSemiring R] (a : R) (n : ℕ) : R :=
  (ascPochhammer R n).eval a
-- ANCHOR_END: pochhammerSymbol

/-- DLMF 5.2.4: the zeroth Pochhammer symbol is one. -/
-- ANCHOR: pochhammerSymbol_zero
theorem pochhammerSymbol_zero (a : ℂ) : pochhammerSymbol a 0 = 1
-- ANCHOR_END: pochhammerSymbol_zero
:= by
  sorry

/-- DLMF 5.2.4: the Pochhammer symbol is the finite rising product. -/
-- ANCHOR: pochhammerSymbol_eq_prod
theorem pochhammerSymbol_eq_prod (a : ℂ) (n : ℕ) :
    pochhammerSymbol a n = ∏ k ∈ range n, (a + k)
-- ANCHOR_END: pochhammerSymbol_eq_prod
:= by
  sorry

/-- DLMF 5.2.5: away from the poles of Gamma, a Pochhammer symbol is a Gamma quotient. -/
-- ANCHOR: pochhammerSymbol_eq_gamma_div
theorem pochhammerSymbol_eq_gamma_div {a : ℂ} (n : ℕ)
    (ha : ∀ m : ℕ, a ≠ -(m : ℂ)) :
    pochhammerSymbol a n = Complex.Gamma (a + n) / Complex.Gamma a
-- ANCHOR_END: pochhammerSymbol_eq_gamma_div
:= by
  sorry

/-- DLMF 5.2.6: negating the initial value reverses a finite Pochhammer product. -/
-- ANCHOR: pochhammerSymbol_neg
theorem pochhammerSymbol_neg (a : ℂ) (n : ℕ) :
    pochhammerSymbol (-a) n = (-1 : ℂ) ^ n * pochhammerSymbol (a - n + 1) n
-- ANCHOR_END: pochhammerSymbol_neg
:= by
  sorry

/-- DLMF 5.2.7: a Pochhammer symbol beginning at a negative integer terminates. -/
-- ANCHOR: pochhammerSymbol_neg_nat
theorem pochhammerSymbol_neg_nat (m n : ℕ) :
    pochhammerSymbol (-(m : ℂ)) n =
      if n ≤ m then
        (-1 : ℂ) ^ n * m.factorial / (m - n).factorial
      else 0
-- ANCHOR_END: pochhammerSymbol_neg_nat
:= by
  sorry

/-- DLMF 5.2.8: duplication of an even-indexed Pochhammer symbol. -/
-- ANCHOR: pochhammerSymbol_two_mul
theorem pochhammerSymbol_two_mul (a : ℂ) (n : ℕ) :
    pochhammerSymbol a (2 * n) =
      (2 : ℂ) ^ (2 * n) * pochhammerSymbol (a / 2) n *
        pochhammerSymbol ((a + 1) / 2) n
-- ANCHOR_END: pochhammerSymbol_two_mul
:= by
  sorry

/-- DLMF 5.2.8: duplication of an odd-indexed Pochhammer symbol. -/
-- ANCHOR: pochhammerSymbol_two_mul_add_one
theorem pochhammerSymbol_two_mul_add_one (a : ℂ) (n : ℕ) :
    pochhammerSymbol a (2 * n + 1) =
      (2 : ℂ) ^ (2 * n + 1) * pochhammerSymbol (a / 2) (n + 1) *
        pochhammerSymbol ((a + 1) / 2) n
-- ANCHOR_END: pochhammerSymbol_two_mul_add_one
:= by
  sorry

/-- DLMF 5.2.9: the falling factorial, using Mathlib's descending Pochhammer polynomial. -/
-- ANCHOR: fallingFactorial
noncomputable def fallingFactorial {R : Type*} [CommRing R] (x : R) (n : ℕ) : R :=
  (descPochhammer R n).eval x
-- ANCHOR_END: fallingFactorial

/-- DLMF 5.2.9: the descending Pochhammer polynomial is the signed rising one. -/
-- ANCHOR: fallingFactorial_eq_neg_one_pow_mul_pochhammerSymbol_neg
theorem fallingFactorial_eq_neg_one_pow_mul_pochhammerSymbol_neg
    {R : Type*} [CommRing R] (x : R) (n : ℕ) :
    fallingFactorial x n = (-1 : R) ^ n * pochhammerSymbol (-x) n
-- ANCHOR_END: fallingFactorial_eq_neg_one_pow_mul_pochhammerSymbol_neg
:= by
  sorry

/-- DLMF 5.2.9: the unsigned Lah number `L(n,k)`. -/
-- ANCHOR: lahNumber
def lahNumber (n k : ℕ) : ℕ :=
  if k = 0 then if n = 0 then 1 else 0
  else Nat.choose (n - 1) (k - 1) * n.factorial / k.factorial
-- ANCHOR_END: lahNumber

/-- DLMF 5.2.9: rising factorials expanded in the falling-factorial basis. -/
-- ANCHOR: pochhammerSymbol_eq_sum_lah_fallingFactorial
theorem pochhammerSymbol_eq_sum_lah_fallingFactorial (x : ℝ) (n : ℕ) :
    pochhammerSymbol x n =
      ∑ k ∈ range (n + 1), (lahNumber n k : ℝ) * fallingFactorial x k
-- ANCHOR_END: pochhammerSymbol_eq_sum_lah_fallingFactorial
:= by
  sorry

/-- DLMF 5.2.9: falling factorials expanded in the rising-factorial basis. -/
-- ANCHOR: fallingFactorial_eq_sum_lah_pochhammerSymbol
theorem fallingFactorial_eq_sum_lah_pochhammerSymbol (x : ℝ) (n : ℕ) :
    fallingFactorial x n =
      ∑ k ∈ range (n + 1),
        (-1 : ℝ) ^ (n - k) * lahNumber n k * pochhammerSymbol x k
-- ANCHOR_END: fallingFactorial_eq_sum_lah_pochhammerSymbol
:= by
  sorry

/-- DLMF 5.2(i), surrounding 5.2.1: Gamma is nonzero away from its poles. -/
-- ANCHOR: gamma_ne_zero_away_from_poles
theorem gamma_ne_zero_away_from_poles {z : ℂ} (hz : ∀ n : ℕ, z ≠ -(n : ℂ)) :
    Complex.Gamma z ≠ 0
-- ANCHOR_END: gamma_ne_zero_away_from_poles
:= by
  sorry

/-- DLMF 5.2(i), surrounding 5.2.1: Gamma is meromorphic on the complex plane. -/
-- ANCHOR: meromorphic_gamma
theorem meromorphic_gamma : Meromorphic Complex.Gamma
-- ANCHOR_END: meromorphic_gamma
:= by
  sorry

/-- DLMF 5.2(i), surrounding 5.2.1: Lean's totalized Gamma is zero at a classical pole. -/
-- ANCHOR: gamma_totalized_at_pole
theorem gamma_totalized_at_pole (n : ℕ) :
    Complex.Gamma (-(n : ℂ)) = 0
-- ANCHOR_END: gamma_totalized_at_pole
:= by
  sorry

/-- DLMF 5.2(i), surrounding 5.2.1: the pole at `-n` has residue `(-1)^n/n!`. -/
-- ANCHOR: tendsto_gamma_residue_neg_nat
theorem tendsto_gamma_residue_neg_nat (n : ℕ) :
    Tendsto
      (fun z : ℂ ↦ (z + n) * Complex.Gamma z)
      (nhdsWithin (-(n : ℂ)) {-(n : ℂ)}ᶜ)
      (nhds ((-1 : ℂ) ^ n / n.factorial))
-- ANCHOR_END: tendsto_gamma_residue_neg_nat
:= by
  sorry

/-- DLMF 5.2(i), surrounding 5.2.1: the reciprocal Gamma function is entire. -/
-- ANCHOR: differentiable_one_div_gamma
theorem differentiable_one_div_gamma :
    Differentiable ℂ (fun z : ℂ ↦ (Complex.Gamma z)⁻¹)
-- ANCHOR_END: differentiable_one_div_gamma
:= by
  sorry

/-- DLMF 5.2(i), surrounding 5.2.1: reciprocal Gamma vanishes exactly at `-n`. -/
-- ANCHOR: one_div_gamma_eq_zero_iff
theorem one_div_gamma_eq_zero_iff (z : ℂ) :
    (Complex.Gamma z)⁻¹ = 0 ↔ ∃ n : ℕ, z = -(n : ℂ)
-- ANCHOR_END: one_div_gamma_eq_zero_iff
:= by
  sorry

/-- DLMF 5.2(i), surrounding 5.2.1: every zero of reciprocal Gamma at `-n` is simple. -/
-- ANCHOR: one_div_gamma_hasSimpleZero_neg_nat
theorem one_div_gamma_hasSimpleZero_neg_nat (n : ℕ) :
    (Complex.Gamma (-(n : ℂ)))⁻¹ = 0 ∧
      deriv (fun z : ℂ ↦ (Complex.Gamma z)⁻¹) (-(n : ℂ)) ≠ 0
-- ANCHOR_END: one_div_gamma_hasSimpleZero_neg_nat
:= by
  sorry

/-- DLMF 5.2(i), surrounding 5.2.2: digamma is meromorphic on the complex plane. -/
-- ANCHOR: meromorphic_digamma
theorem meromorphic_digamma : Meromorphic Complex.digamma
-- ANCHOR_END: meromorphic_digamma
:= by
  sorry

/-- DLMF 5.2(i), surrounding 5.2.2: digamma has residue `-1` at every Gamma pole. -/
-- ANCHOR: tendsto_digamma_residue_neg_nat
theorem tendsto_digamma_residue_neg_nat (n : ℕ) :
    Tendsto
      (fun z : ℂ ↦ (z + n) * Complex.digamma z)
      (nhdsWithin (-(n : ℂ)) {-(n : ℂ)}ᶜ)
      (nhds (-1))
-- ANCHOR_END: tendsto_digamma_residue_neg_nat
:= by
  sorry

end LMLF.Blueprint.Gamma
