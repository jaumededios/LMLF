import LMLF.Definitions.Gamma

/-!
# DLMF §4.5: Inequalities

The declarations below record the real logarithmic and exponential inequalities
and the complex estimates in the two parts of §4.5.
-/

namespace LMLF.Blueprint.Elementary.Section45

/-! ### Logarithms -/

/-- DLMF 4.5.1: the two-sided logarithm bound for `x > -1`, `x ≠ 0`. -/
-- ANCHOR: dlmf_4_5_1
theorem dlmf_4_5_1 {x : ℝ} (hx : -1 < x) (hx0 : x ≠ 0) :
    x / (1 + x) < Real.log (1 + x) ∧ Real.log (1 + x) < x
-- ANCHOR_END: dlmf_4_5_1
    := by sorry

/-- DLMF 4.5.2: the two-sided bound for `log (1-x)` when `x < 1`, `x ≠ 0`. -/
-- ANCHOR: dlmf_4_5_2
theorem dlmf_4_5_2 {x : ℝ} (hx : x < 1) (hx0 : x ≠ 0) :
    x < -Real.log (1 - x) ∧ -Real.log (1 - x) < x / (1 - x)
-- ANCHOR_END: dlmf_4_5_2
    := by sorry

/-- DLMF 4.5.3: the small-positive-`x` bound for `|log (1-x)|`. -/
-- ANCHOR: dlmf_4_5_3
theorem dlmf_4_5_3 {x : ℝ} (hx : 0 < x) (hxmax : x ≤ (0.5828 : ℝ)) :
    |Real.log (1 - x)| < (3 / 2 : ℝ) * x
-- ANCHOR_END: dlmf_4_5_3
    := by sorry

/-- DLMF 4.5.4: the standard upper bound for `log x` on the positive reals. -/
-- ANCHOR: dlmf_4_5_4
theorem dlmf_4_5_4 {x : ℝ} (hx : 0 < x) :
    Real.log x ≤ x - 1
-- ANCHOR_END: dlmf_4_5_4
    := by sorry

/-- DLMF 4.5.5: the power-form logarithm inequality for positive `a` and `x`. -/
-- ANCHOR: dlmf_4_5_5
theorem dlmf_4_5_5 {a x : ℝ} (ha : 0 < a) (hx : 0 < x) :
    Real.log x ≤ a * (x ^ (1 / a) - 1)
-- ANCHOR_END: dlmf_4_5_5
    := by sorry

/-- DLMF 4.5.6: the principal complex-logarithm estimate for `|z| < 1`. -/
-- ANCHOR: dlmf_4_5_6
theorem dlmf_4_5_6 {z : ℂ} (hz : ‖z‖ < 1) :
    ‖Complex.log (1 + z)‖ ≤ -Real.log (1 - ‖z‖)
-- ANCHOR_END: dlmf_4_5_6
    := by sorry

/-! ### Exponentials -/

/-- DLMF 4.5.7: the two-sided exponential bound for `x < 1`. -/
-- ANCHOR: dlmf_4_5_7
theorem dlmf_4_5_7 {x : ℝ} (hx : x < 1) (hx0 : x ≠ 0) :
    Real.exp (-x / (1 - x)) < 1 - x ∧ 1 - x < Real.exp (-x)
-- ANCHOR_END: dlmf_4_5_7
    := by sorry

/-- DLMF 4.5.8: the strict tangent-line bound for the real exponential. -/
-- ANCHOR: dlmf_4_5_8
theorem dlmf_4_5_8 {x : ℝ} (hx0 : x ≠ 0) :
    1 + x < Real.exp x
-- ANCHOR_END: dlmf_4_5_8
    := by sorry

/-- DLMF 4.5.9: the exponential bound for `x < 1`. -/
-- ANCHOR: dlmf_4_5_9
theorem dlmf_4_5_9 {x : ℝ} (hx : x < 1) (hx0 : x ≠ 0) :
    Real.exp x < 1 / (1 - x)
-- ANCHOR_END: dlmf_4_5_9
    := by sorry

/-- DLMF 4.5.10: the two-sided bound for `1-exp(-x)` when `x > -1`. -/
-- ANCHOR: dlmf_4_5_10
theorem dlmf_4_5_10 {x : ℝ} (hx : -1 < x) (hx0 : x ≠ 0) :
    x / (1 + x) < 1 - Real.exp (-x) ∧ 1 - Real.exp (-x) < x
-- ANCHOR_END: dlmf_4_5_10
    := by sorry

/-- DLMF 4.5.11: the two-sided bound for `exp x - 1` when `x < 1`. -/
-- ANCHOR: dlmf_4_5_11
theorem dlmf_4_5_11 {x : ℝ} (hx : x < 1) (hx0 : x ≠ 0) :
    x < Real.exp x - 1 ∧ Real.exp x - 1 < x / (1 - x)
-- ANCHOR_END: dlmf_4_5_11
    := by sorry

/-- DLMF 4.5.12: the upper bound for `1+x` when `x > -1`. -/
-- ANCHOR: dlmf_4_5_12
theorem dlmf_4_5_12 {x : ℝ} (hx : -1 < x) (hx0 : x ≠ 0) :
    Real.exp (x / (1 + x)) < 1 + x
-- ANCHOR_END: dlmf_4_5_12
    := by sorry

/-- DLMF 4.5.13: the weighted power bound for positive `x` and `y`. -/
-- ANCHOR: dlmf_4_5_13
theorem dlmf_4_5_13 {x y : ℝ} (hx : 0 < x) (hy : 0 < y) :
    Real.exp (x * y / (x + y)) < (1 + x / y) ^ y ∧
      (1 + x / y) ^ y < Real.exp x
-- ANCHOR_END: dlmf_4_5_13
    := by sorry

/-- DLMF 4.5.14: the small-positive-`x` upper bound for `exp (-x)`. -/
-- ANCHOR: dlmf_4_5_14
theorem dlmf_4_5_14 {x : ℝ} (hx : 0 < x) (hxmax : x ≤ (1.5936 : ℝ)) :
    Real.exp (-x) < 1 - x / 2
-- ANCHOR_END: dlmf_4_5_14
    := by sorry

/-- DLMF 4.5.15: the two-sided complex estimate for `exp z - 1`. -/
-- ANCHOR: dlmf_4_5_15
theorem dlmf_4_5_15 {z : ℂ} (hz : 0 < ‖z‖) (hz1 : ‖z‖ < 1) :
    (1 / 4 : ℝ) * ‖z‖ < ‖Complex.exp z - 1‖ ∧
      ‖Complex.exp z - 1‖ < (7 / 4 : ℝ) * ‖z‖
-- ANCHOR_END: dlmf_4_5_15
    := by sorry

/-- DLMF 4.5.16: the global complex exponential increment estimate. -/
-- ANCHOR: dlmf_4_5_16
theorem dlmf_4_5_16 (z : ℂ) :
    ‖Complex.exp z - 1‖ ≤ Real.exp ‖z‖ - 1 ∧
      Real.exp ‖z‖ - 1 ≤ ‖z‖ * Real.exp ‖z‖
-- ANCHOR_END: dlmf_4_5_16
    := by sorry

end LMLF.Blueprint.Elementary.Section45
