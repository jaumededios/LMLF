import LMLF.Definitions.Gamma
import Mathlib.Analysis.SpecialFunctions.Gamma.Digamma

/-!
# DLMF §5.6: inequalities for the Gamma function

This statement module records the nine inequalities in DLMF §5.6.  Real powers use
Mathlib's `Real.rpow`, complex absolute values use the norm, and the real digamma
function is the real restriction of Mathlib's complex digamma function.
-/

-- ANCHOR: section56Context
namespace LMLF.Blueprint.Gamma

open scoped Real
-- ANCHOR_END: section56Context

/-- DLMF 5.6.1: the sharp elementary two-sided bound associated with Stirling's formula. -/
-- ANCHOR: stirlingNormalizedBounds
theorem stirlingNormalizedBounds {x : ℝ} (hx : 0 < x) :
    1 < (2 * Real.pi) ^ (-(1 : ℝ) / 2) *
          x ^ ((1 : ℝ) / 2 - x) * Real.exp x * Real.Gamma x ∧
      (2 * Real.pi) ^ (-(1 : ℝ) / 2) *
          x ^ ((1 : ℝ) / 2 - x) * Real.exp x * Real.Gamma x <
        Real.exp (1 / (12 * x))
-- ANCHOR_END: stirlingNormalizedBounds
:= by
  sorry

/-- DLMF 5.6.2: the reciprocal Gamma values at `x` and `1 / x` have sum at most two. -/
-- ANCHOR: oneDivGamma_add_oneDivGamma_reciprocal_le_two
theorem oneDivGamma_add_oneDivGamma_reciprocal_le_two {x : ℝ} (hx : 0 < x) :
    1 / Real.Gamma x + 1 / Real.Gamma (1 / x) ≤ 2
-- ANCHOR_END: oneDivGamma_add_oneDivGamma_reciprocal_le_two
:= by
  sorry

/-- DLMF 5.6.3: the squared reciprocal Gamma values at `x` and `1 / x` have sum at most two. -/
-- ANCHOR: oneDivGammaSq_add_oneDivGammaSq_reciprocal_le_two
theorem oneDivGammaSq_add_oneDivGammaSq_reciprocal_le_two {x : ℝ} (hx : 0 < x) :
    1 / (Real.Gamma x) ^ 2 + 1 / (Real.Gamma (1 / x)) ^ 2 ≤ 2
-- ANCHOR_END: oneDivGammaSq_add_oneDivGammaSq_reciprocal_le_two
:= by
  sorry

/-- DLMF 5.6.4, Gautschi's inequality: a Gamma quotient lies strictly between
two neighboring powers. -/
-- ANCHOR: gautschiInequality
theorem gautschiInequality {x s : ℝ} (hx : 0 < x) (hs0 : 0 < s) (hs1 : s < 1) :
    x ^ (1 - s) < Real.Gamma (x + 1) / Real.Gamma (x + s) ∧
      Real.Gamma (x + 1) / Real.Gamma (x + s) < (x + 1) ^ (1 - s)
-- ANCHOR_END: gautschiInequality
:= by
  sorry

/-- The real digamma function used in DLMF 5.6.5, obtained by restricting Mathlib's
`Complex.digamma` to the real axis. -/
-- ANCHOR: realDigamma
noncomputable def realDigamma (x : ℝ) : ℝ :=
  (Complex.digamma (x : ℂ)).re
-- ANCHOR_END: realDigamma

/-- DLMF 5.6.5, Kershaw's inequality: digamma values give exponential bounds for
the same Gamma quotient. -/
-- ANCHOR: kershawInequality
theorem kershawInequality {x s : ℝ} (hx : 0 < x) (hs0 : 0 < s) (hs1 : s < 1) :
    Real.exp ((1 - s) * realDigamma (x + Real.sqrt s)) ≤
        Real.Gamma (x + 1) / Real.Gamma (x + s) ∧
      Real.Gamma (x + 1) / Real.Gamma (x + s) ≤
        Real.exp ((1 - s) * realDigamma (x + (s + 1) / 2))
-- ANCHOR_END: kershawInequality
:= by
  sorry

/-- DLMF 5.6.6: moving vertically from a finite real Gamma value cannot increase
the modulus.  The pole exclusion makes the classical domain explicit because Mathlib
totalizes Gamma to zero at nonpositive integers. -/
-- ANCHOR: norm_Gamma_vertical_le
theorem norm_Gamma_vertical_le {x y : ℝ} (hx : ∀ n : ℕ, x ≠ -(n : ℝ)) :
    ‖Complex.Gamma ((x : ℂ) + y * Complex.I)‖ ≤ |Real.Gamma x|
-- ANCHOR_END: norm_Gamma_vertical_le
:= by
  sorry

/-- DLMF 5.6.7: on `x ≥ 1 / 2`, the modulus on a vertical line has a lower
bound involving the hyperbolic secant. -/
-- ANCHOR: norm_Gamma_vertical_lowerBound
theorem norm_Gamma_vertical_lowerBound {x y : ℝ} (hx : (1 : ℝ) / 2 ≤ x) :
    Real.sqrt ((Real.cosh (Real.pi * y))⁻¹) * Real.Gamma x ≤
      ‖Complex.Gamma ((x : ℂ) + y * Complex.I)‖
-- ANCHOR_END: norm_Gamma_vertical_lowerBound
:= by
  sorry

/-- DLMF 5.6.8: a Gamma quotient in the open right half-plane is bounded by a
negative power of the modulus. -/
-- ANCHOR: norm_Gamma_div_Gamma_le
theorem norm_Gamma_div_Gamma_le {z : ℂ} {a b : ℝ} (hz : 0 < z.re)
    (ha : 0 ≤ a) (hab : 1 ≤ b - a) :
    ‖Complex.Gamma (z + (a : ℂ)) / Complex.Gamma (z + (b : ℂ))‖ ≤
      1 / ‖z‖ ^ (b - a)
-- ANCHOR_END: norm_Gamma_div_Gamma_le
:= by
  sorry

/-- DLMF 5.6.9: an explicit Gamma-modulus bound on the closed right half-plane,
away from the pole at zero. -/
-- ANCHOR: norm_Gamma_rightHalfPlane_le
theorem norm_Gamma_rightHalfPlane_le {z : ℂ} (hz : 0 ≤ z.re) (hz0 : z ≠ 0) :
    ‖Complex.Gamma z‖ ≤
      (2 * Real.pi) ^ ((1 : ℝ) / 2) *
        ‖z‖ ^ (z.re - (1 : ℝ) / 2) *
        Real.exp (-Real.pi * |z.im| / 2) *
        Real.exp ((1 : ℝ) / 6 * ‖z‖⁻¹)
-- ANCHOR_END: norm_Gamma_rightHalfPlane_le
:= by
  sorry

end LMLF.Blueprint.Gamma
