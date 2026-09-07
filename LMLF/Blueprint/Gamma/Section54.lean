import LMLF.Definitions.Gamma
import Mathlib.Analysis.SpecialFunctions.Gamma.Digamma

/-!
# DLMF §5.4: special values and extrema

The declarations in this file follow the twenty numbered formulas in DLMF §5.4.
The exact identities are stated over Mathlib's Gamma and digamma functions; decimal
entries in the source are recorded as numerical enclosures, and the final estimate is
written as an explicit eventual big-O bound.
-/

-- ANCHOR: section54Context
namespace LMLF.Blueprint.Gamma

open Filter
open scoped BigOperators
-- ANCHOR_END: section54Context

/-- The natural-number double factorial used in DLMF 5.4.2. -/
-- ANCHOR: doubleFactorial
def doubleFactorial (n : ℕ) : ℕ :=
  ∏ k ∈ Finset.range (n / 2 + n % 2), (n - 2 * k)
-- ANCHOR_END: doubleFactorial

/-- DLMF 5.4.1: Gamma at one is one, and Gamma at a positive integer is the factorial. -/
-- ANCHOR: gamma_special_factorial
theorem gamma_special_factorial :
    Complex.Gamma 1 = 1 ∧
      ∀ n : ℕ, Complex.Gamma (n + 1) = (n.factorial : ℂ)
-- ANCHOR_END: gamma_special_factorial
:= by
  sorry

/-- DLMF 5.4.2: the even and odd double-factorial formulas. -/
-- ANCHOR: gamma_doubleFactorial_even
theorem gamma_doubleFactorial_even {n : ℕ} (hn : n % 2 = 0) :
    (doubleFactorial n : ℝ) =
      (2 : ℝ) ^ ((n : ℝ) / 2) * Real.Gamma ((n : ℝ) / 2 + 1)
-- ANCHOR_END: gamma_doubleFactorial_even
:= by
  sorry

/- The source notes that the odd line also applies to the exceptional index
   `n = -1`; this Lean specialization uses the natural-number convention and
   therefore covers only nonnegative `n`. -/
-- ANCHOR: gamma_doubleFactorial_odd
theorem gamma_doubleFactorial_odd {n : ℕ} (hn : n % 2 = 1) :
    (doubleFactorial n : ℝ) =
      Real.pi ^ (-((1 : ℝ) / 2)) *
        (2 : ℝ) ^ ((n : ℝ) / 2 + 1 / 2) * Real.Gamma ((n : ℝ) / 2 + 1)
-- ANCHOR_END: gamma_doubleFactorial_odd
:= by
  sorry

/-- DLMF 5.4.3: the modulus of Gamma on the imaginary axis. -/
-- ANCHOR: gamma_imaginary_modulus
theorem gamma_imaginary_modulus {y : ℝ} (hy : y ≠ 0) :
    ‖Complex.Gamma (Complex.I * (y : ℂ))‖ =
      Real.sqrt (Real.pi / (y * Real.sinh (Real.pi * y)))
-- ANCHOR_END: gamma_imaginary_modulus
:= by
  sorry

/-- DLMF 5.4.4: the half-line Gamma product and its squared modulus. -/
-- ANCHOR: gamma_half_line_product
theorem gamma_half_line_product (y : ℝ) :
    Complex.Gamma ((1 / 2 : ℂ) + Complex.I * y) *
        Complex.Gamma ((1 / 2 : ℂ) - Complex.I * y) =
      (‖Complex.Gamma ((1 / 2 : ℂ) + Complex.I * y)‖ ^ 2 : ℝ) ∧
    (‖Complex.Gamma ((1 / 2 : ℂ) + Complex.I * y)‖ ^ 2 : ℝ) =
      Real.pi / Real.cosh (Real.pi * y)
-- ANCHOR_END: gamma_half_line_product
:= by
  sorry

/-- DLMF 5.4.5: a quarter-shifted Gamma product. -/
-- ANCHOR: gamma_quarter_shift_product
theorem gamma_quarter_shift_product (y : ℝ) :
    Complex.Gamma ((1 / 4 : ℂ) + Complex.I * y) *
        Complex.Gamma ((3 / 4 : ℂ) - Complex.I * y) =
      (Real.pi * Real.sqrt 2 : ℂ) /
        (Complex.cosh (Real.pi * y) + Complex.I * Complex.sinh (Real.pi * y))
-- ANCHOR_END: gamma_quarter_shift_product
:= by
  sorry

/-- DLMF 5.4.6: the half-value of Gamma, together with its displayed decimal enclosure. -/
-- ANCHOR: gamma_half_value
theorem gamma_half_value :
    Real.Gamma (1 / 2 : ℝ) = Real.sqrt Real.pi ∧
      |Real.Gamma (1 / 2 : ℝ) - 1.77245385090551602729| < 1 / 10 ^ 20
-- ANCHOR_END: gamma_half_value
:= by
  sorry

/-- DLMF 5.4.7: the one-third value of Gamma, to the displayed precision. -/
-- ANCHOR: gamma_third_value
theorem gamma_third_value :
    |Real.Gamma (1 / 3 : ℝ) - 2.67893853470774763365| < 1 / 10 ^ 20
-- ANCHOR_END: gamma_third_value
:= by
  sorry

/-- DLMF 5.4.8: the two-thirds value of Gamma, to the displayed precision. -/
-- ANCHOR: gamma_two_thirds_value
theorem gamma_two_thirds_value :
    |Real.Gamma (2 / 3 : ℝ) - 1.35411793942640041694| < 1 / 10 ^ 20
-- ANCHOR_END: gamma_two_thirds_value
:= by
  sorry

/-- DLMF 5.4.9: the quarter-value of Gamma, to the displayed precision. -/
-- ANCHOR: gamma_quarter_value
theorem gamma_quarter_value :
    |Real.Gamma (1 / 4 : ℝ) - 3.62560990822190831193| < 1 / 10 ^ 20
-- ANCHOR_END: gamma_quarter_value
:= by
  sorry

/-- DLMF 5.4.10: the three-quarter value of Gamma, to the displayed precision. -/
-- ANCHOR: gamma_three_quarters_value
theorem gamma_three_quarters_value :
    |Real.Gamma (3 / 4 : ℝ) - 1.22541670246517764512| < 1 / 10 ^ 20
-- ANCHOR_END: gamma_three_quarters_value
:= by
  sorry

/-- DLMF 5.4.11: Gamma's derivative at one is minus Euler's constant. -/
-- ANCHOR: gamma_deriv_one_value
theorem gamma_deriv_one_value :
    deriv Real.Gamma 1 = -Real.eulerMascheroniConstant
-- ANCHOR_END: gamma_deriv_one_value
:= by
  sorry

/-- DLMF 5.4.12: the first two special values of digamma and its derivative. -/
-- ANCHOR: digamma_one_values
theorem digamma_one_values :
    Complex.digamma 1 = (-Real.eulerMascheroniConstant : ℂ) ∧
      deriv Complex.digamma 1 = Real.pi ^ 2 / 6
-- ANCHOR_END: digamma_one_values
:= by
  sorry

/-- DLMF 5.4.13: the corresponding values at one-half. -/
-- ANCHOR: digamma_half_values
theorem digamma_half_values :
    Complex.digamma (1 / 2 : ℂ) =
        (-(Real.eulerMascheroniConstant : ℝ) - 2 * Real.log 2 : ℂ) ∧
      deriv Complex.digamma (1 / 2 : ℂ) = Real.pi ^ 2 / 2
-- ANCHOR_END: digamma_half_values
:= by
  sorry

/-- DLMF 5.4.14: digamma at a positive integer in terms of a harmonic sum. -/
-- ANCHOR: digamma_nat_value
theorem digamma_nat_value (n : ℕ) :
    Complex.digamma (n + 1) =
      (∑ k ∈ Finset.range n, (1 / ((k + 1 : ℕ) : ℂ))) -
        (Real.eulerMascheroniConstant : ℂ)
-- ANCHOR_END: digamma_nat_value
:= by
  sorry

/-- DLMF 5.4.15: digamma at a positive half-integer. -/
-- ANCHOR: digamma_half_nat_value
theorem digamma_half_nat_value {n : ℕ} (hn : 0 < n) :
    Complex.digamma ((n : ℂ) + 1 / 2) =
      (-(Real.eulerMascheroniConstant : ℝ) - 2 * Real.log 2 : ℂ) +
        2 * ∑ k ∈ Finset.range n, (1 / ((2 * k + 1 : ℕ) : ℂ))
-- ANCHOR_END: digamma_half_nat_value
:= by
  sorry

/-- DLMF 5.4.16: the imaginary part of digamma on the imaginary axis. -/
-- ANCHOR: digamma_imaginary_part
theorem digamma_imaginary_part {y : ℝ} (hy : y ≠ 0) :
    (Complex.digamma (Complex.I * (y : ℂ))).im =
      1 / (2 * y) + Real.pi / 2 * (Real.cosh (Real.pi * y) / Real.sinh (Real.pi * y))
-- ANCHOR_END: digamma_imaginary_part
:= by
  sorry

/-- DLMF 5.4.17: the imaginary part on the half-shifted imaginary line. -/
-- ANCHOR: digamma_half_shift_imaginary_part
theorem digamma_half_shift_imaginary_part (y : ℝ) :
    (Complex.digamma ((1 / 2 : ℂ) + Complex.I * y)).im =
      Real.pi / 2 * (Real.sinh (Real.pi * y) / Real.cosh (Real.pi * y))
-- ANCHOR_END: digamma_half_shift_imaginary_part
:= by
  sorry

/-- DLMF 5.4.18: the imaginary part on the line through one. -/
-- ANCHOR: digamma_one_shift_imaginary_part
theorem digamma_one_shift_imaginary_part {y : ℝ} (hy : y ≠ 0) :
    (Complex.digamma (1 + Complex.I * (y : ℂ))).im =
      -1 / (2 * y) + Real.pi / 2 * (Real.cosh (Real.pi * y) / Real.sinh (Real.pi * y))
-- ANCHOR_END: digamma_one_shift_imaginary_part
:= by
  sorry

/-- DLMF 5.4.19: Gauss's finite sum for digamma at a rational argument. -/
-- ANCHOR: digamma_rational_value
theorem digamma_rational_value {p q : ℕ} (hp : 0 < p) (hpq : p < q) :
    Complex.digamma ((p : ℂ) / q) =
      -(Real.eulerMascheroniConstant : ℂ) - Complex.log q -
        (Real.pi : ℂ) / 2 * Complex.cot ((Real.pi : ℂ) * p / q) +
        (1 / 2 : ℂ) * ∑ k ∈ Finset.Ico 1 q,
          Complex.cos (2 * (Real.pi : ℂ) * k * p / q) *
            Complex.log (2 - 2 * Complex.cos (2 * (Real.pi : ℂ) * k / q))
-- ANCHOR_END: digamma_rational_value
:= by
  sorry

/-- DLMF 5.4.20: locations of the negative extrema, with an explicit eventual error bound. -/
-- ANCHOR: gamma_extrema_asymptotic
theorem gamma_extrema_asymptotic :
    ∃ x : ℕ → ℝ,
      (∀ n : ℕ,
        deriv Real.Gamma (x n) = 0 ∧
          Complex.digamma (x n : ℂ) = 0) ∧
        ∃ C : ℝ, 0 < C ∧
          ∀ᶠ n : ℕ in atTop,
            |x n - (-n + 1 / Real.pi * Real.arctan (Real.pi / Real.log n))| ≤
              C / (n * (Real.log n) ^ 2)
-- ANCHOR_END: gamma_extrema_asymptotic
:= by
  sorry

end LMLF.Blueprint.Gamma
