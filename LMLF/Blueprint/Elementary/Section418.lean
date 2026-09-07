import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

open scoped ComplexConjugate

noncomputable section

namespace LMLF.Blueprint.Elementary.Section418

/-! DLMF §4.18 inequalities.  The first four statements are real-variable
inequalities; E5--E10 use complex values and real norms, with the real and
imaginary coordinates made explicit where DLMF does so. -/

/-- DLMF 4.18.1: Jordan's two-sided sine inequality. -/
-- ANCHOR: dlmf_4_18_1
theorem dlmf_4_18_1 {x : ℝ} (hx0 : 0 ≤ x) (hxπ : x ≤ Real.pi / 2) :
    2 * x / Real.pi ≤ Real.sin x ∧ Real.sin x ≤ x := by sorry
-- ANCHOR_END: dlmf_4_18_1

/-- DLMF 4.18.2: tangent dominates its argument before the pole. -/
-- ANCHOR: dlmf_4_18_2
theorem dlmf_4_18_2 {x : ℝ} (hx0 : 0 ≤ x) (hxπ : x < Real.pi / 2) :
    x ≤ Real.tan x := by sorry
-- ANCHOR_END: dlmf_4_18_2

/-- The continuous totalization of `sin x / x` used at the endpoint `x = 0`. -/
-- ANCHOR: sinc
def sinc (x : ℝ) : ℝ := if x = 0 then 1 else Real.sin x / x
-- ANCHOR_END: sinc

/-- DLMF 4.18.3: cosine bounds the normalized sine on `[0, π]`. -/
-- ANCHOR: dlmf_4_18_3
theorem dlmf_4_18_3 {x : ℝ} (hx0 : 0 ≤ x) (hxπ : x ≤ Real.pi) :
    Real.cos x ≤ sinc x ∧ sinc x ≤ 1 := by sorry
-- ANCHOR_END: dlmf_4_18_3

/-- DLMF 4.18.4: the sharp strict/lax bounds on `sin (π x)`. -/
-- ANCHOR: dlmf_4_18_4
theorem dlmf_4_18_4 {x : ℝ} (hx0 : 0 < x) (hx1 : x < 1) :
    Real.pi < Real.sin (Real.pi * x) / (x * (1 - x)) ∧
      Real.sin (Real.pi * x) / (x * (1 - x)) ≤ 4 := by sorry
-- ANCHOR_END: dlmf_4_18_4

/-- DLMF 4.18.5: for `z = x + i y`, `|sinh y| ≤ |sin z| ≤ cosh y`. -/
-- ANCHOR: dlmf_4_18_5
theorem dlmf_4_18_5 (x y : ℝ) :
    |Real.sinh y| ≤ ‖Complex.sin ((x : ℂ) + (y : ℂ) * Complex.I)‖ ∧
      ‖Complex.sin ((x : ℂ) + (y : ℂ) * Complex.I)‖ ≤ Real.cosh y := by sorry
-- ANCHOR_END: dlmf_4_18_5

/-- DLMF 4.18.6: for `z = x + i y`, `|sinh y| ≤ |cos z| ≤ cosh y`. -/
-- ANCHOR: dlmf_4_18_6
theorem dlmf_4_18_6 (x y : ℝ) :
    |Real.sinh y| ≤ ‖Complex.cos ((x : ℂ) + (y : ℂ) * Complex.I)‖ ∧
      ‖Complex.cos ((x : ℂ) + (y : ℂ) * Complex.I)‖ ≤ Real.cosh y := by sorry
-- ANCHOR_END: dlmf_4_18_6

/-- DLMF 4.18.7: a real totalization of `csch` and the nonzero-imaginary bound. -/
-- ANCHOR: csch
def csch (y : ℝ) : ℝ := 1 / Real.sinh y
-- ANCHOR_END: csch

-- ANCHOR: dlmf_4_18_7
theorem dlmf_4_18_7 (x y : ℝ) (hy : y ≠ 0) :
    ‖1 / Complex.sin ((x : ℂ) + (y : ℂ) * Complex.I)‖ ≤ csch |y| := by sorry
-- ANCHOR_END: dlmf_4_18_7

/-- DLMF 4.18.8: the complex cosine norm is bounded by `cosh ‖z‖`. -/
-- ANCHOR: dlmf_4_18_8
theorem dlmf_4_18_8 (z : ℂ) :
    ‖Complex.cos z‖ ≤ Real.cosh ‖z‖ := by sorry
-- ANCHOR_END: dlmf_4_18_8

/-- DLMF 4.18.9: the complex sine norm is bounded by `sinh ‖z‖`. -/
-- ANCHOR: dlmf_4_18_9
theorem dlmf_4_18_9 (z : ℂ) :
    ‖Complex.sin z‖ ≤ Real.sinh ‖z‖ := by sorry
-- ANCHOR_END: dlmf_4_18_9

/-- DLMF 4.18.10: small-disc bounds with the displayed constants. -/
-- ANCHOR: dlmf_4_18_10
theorem dlmf_4_18_10 {z : ℂ} (hz : ‖z‖ < 1) :
    ‖Complex.cos z‖ < 2 ∧ ‖Complex.sin z‖ ≤ (6 / 5 : ℝ) * ‖z‖ := by sorry
-- ANCHOR_END: dlmf_4_18_10

end LMLF.Blueprint.Elementary.Section418
