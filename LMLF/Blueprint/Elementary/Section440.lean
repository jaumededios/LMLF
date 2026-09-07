import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Inverse
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Arctan
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Topology.Basic

open scoped Interval
open scoped Topology
open Filter
noncomputable section
namespace LMLF.Blueprint.Elementary.Section440

/-- Truncation used to expose the endpoint semantics of DLMF 4.40.7--4.40.10. -/
def truncatedIntegral (f : ℝ → ℝ) (ε R : ℝ) : ℝ := ∫ x in ε..R, f x
def symmetricTruncatedIntegral (f : ℝ → ℝ) (R : ℝ) : ℝ := ∫ x in (-R)..R, f x

def arsinh (x : ℝ) : ℝ := Real.log (x + Real.sqrt (1 + x ^ 2))
def arcosh (x : ℝ) : ℝ := Real.log (x + Real.sqrt (x ^ 2 - 1))
def artanh (x : ℝ) : ℝ := (1 / 2 : ℝ) * Real.log ((1 + x) / (1 - x))
def arcsch (x : ℝ) : ℝ := arsinh (1 / x)
def arsech (x : ℝ) : ℝ := arcosh (1 / x)
def arcoth (x : ℝ) : ℝ := artanh (1 / x)
def gd (x : ℝ) : ℝ := 2 * Real.arctan (Real.exp x) - Real.pi / 2

/- The removable continuation of the E9 quotient at a = 0. -/
def e9Value (a : ℝ) : ℝ := if a = 0 then 4 else 4 * Real.pi * a / Real.sin (Real.pi * a)

/-- DLMF 4.40.E1. -/
-- ANCHOR: dlmf_4_40_1
theorem dlmf_4_40_1 (x : ℝ) : HasDerivAt Real.cosh (Real.sinh x) x
-- ANCHOR_END: dlmf_4_40_1
:= by sorry

/-- DLMF 4.40.E2. -/
-- ANCHOR: dlmf_4_40_2
theorem dlmf_4_40_2 (x : ℝ) : HasDerivAt Real.sinh (Real.cosh x) x
-- ANCHOR_END: dlmf_4_40_2
:= by sorry

/-- DLMF 4.40.E3. -/
-- ANCHOR: dlmf_4_40_3
theorem dlmf_4_40_3 {x : ℝ} (hx : 0 < Real.cosh x) : HasDerivAt (fun t => Real.log (Real.cosh t)) (Real.tanh x) x
-- ANCHOR_END: dlmf_4_40_3
:= by sorry

/-- DLMF 4.40.E4, on the source interval x > 0. -/
-- ANCHOR: dlmf_4_40_4
theorem dlmf_4_40_4 {x : ℝ} (hx : 0 < x) : HasDerivAt (fun t => Real.log (Real.tanh (t / 2))) (1 / Real.sinh x) x
-- ANCHOR_END: dlmf_4_40_4
:= by sorry

/-- DLMF 4.40.E5. -/
-- ANCHOR: dlmf_4_40_5
theorem dlmf_4_40_5 (x : ℝ) : HasDerivAt gd (1 / Real.cosh x) x
-- ANCHOR_END: dlmf_4_40_5
:= by sorry

/-- DLMF 4.40.E6, on the source interval x > 0. -/
-- ANCHOR: dlmf_4_40_6
theorem dlmf_4_40_6 {x : ℝ} (hx : 0 < x) : HasDerivAt (fun t => Real.log (Real.sinh t)) (1 / Real.tanh x) x
-- ANCHOR_END: dlmf_4_40_6
:= by sorry

/-- DLMF 4.40.E7, an explicit convergent endpoint limit for the improper integral. -/
-- ANCHOR: dlmf_4_40_7
theorem dlmf_4_40_7 {a : ℝ} (ha : a ≠ 0) : ∃ L : ℝ, Tendsto (fun R => truncatedIntegral (fun x => Real.exp (-x) * Real.sin (a * x) / Real.sinh x) (1 / R) R) atTop (𝓝 L) ∧ L = Real.pi / 2 * (1 / Real.tanh (Real.pi * a / 2)) - 1 / a
-- ANCHOR_END: dlmf_4_40_7
:= by sorry

/-- DLMF 4.40.E8, valid for -pi < a < pi. -/
-- ANCHOR: dlmf_4_40_8
theorem dlmf_4_40_8 {a : ℝ} (ha₁ : -Real.pi < a) (ha₂ : a < Real.pi) : ∃ L : ℝ, Tendsto (fun R => truncatedIntegral (fun x => Real.sinh (a * x) / Real.sinh (Real.pi * x)) (1 / R) R) atTop (𝓝 L) ∧ L = 1 / 2 * Real.tan (a / 2)
-- ANCHOR_END: dlmf_4_40_8
:= by sorry

/-- DLMF 4.40.E9, valid for -1 < a < 1. -/
-- ANCHOR: dlmf_4_40_9
theorem dlmf_4_40_9 {a : ℝ} (ha₁ : -1 < a) (ha₂ : a < 1) : ∃ L : ℝ, Tendsto (fun R => symmetricTruncatedIntegral (fun x => Real.exp (a * x) / (Real.cosh (x / 2)) ^ 2) R) atTop (𝓝 L) ∧ L = e9Value a
-- ANCHOR_END: dlmf_4_40_9
:= by sorry

/-- DLMF 4.40.E10, valid for positive a and b. -/
-- ANCHOR: dlmf_4_40_10
theorem dlmf_4_40_10 {a b : ℝ} (ha : 0 < a) (hb : 0 < b) : ∃ L : ℝ, Tendsto (fun R => truncatedIntegral (fun x => (Real.tanh (a * x) - Real.tanh (b * x)) / x) (1 / R) R) atTop (𝓝 L) ∧ L = Real.log (a / b)
-- ANCHOR_END: dlmf_4_40_10
:= by sorry

/-- DLMF 4.40.E11. -/
-- ANCHOR: dlmf_4_40_11
theorem dlmf_4_40_11 (x : ℝ) : HasDerivAt (fun t => t * arsinh t - Real.sqrt (1 + t ^ 2)) (arsinh x) x
-- ANCHOR_END: dlmf_4_40_11
:= by sorry

/-- DLMF 4.40.E12, on 1 < x. -/
-- ANCHOR: dlmf_4_40_12
theorem dlmf_4_40_12 {x : ℝ} (hx : 1 < x) : HasDerivAt (fun t => t * arcosh t - Real.sqrt (t ^ 2 - 1)) (arcosh x) x
-- ANCHOR_END: dlmf_4_40_12
:= by sorry

/-- DLMF 4.40.E13, on -1 < x < 1. -/
-- ANCHOR: dlmf_4_40_13
theorem dlmf_4_40_13 {x : ℝ} (hx₁ : -1 < x) (hx₂ : x < 1) : HasDerivAt (fun t => t * artanh t + (1 / 2 : ℝ) * Real.log (1 - t ^ 2)) (artanh x) x
-- ANCHOR_END: dlmf_4_40_13
:= by sorry

/-- DLMF 4.40.E14, on x > 0. -/
-- ANCHOR: dlmf_4_40_14
theorem dlmf_4_40_14 {x : ℝ} (hx : 0 < x) : HasDerivAt (fun t => t * arcsch t + arsinh t) (arcsch x) x
-- ANCHOR_END: dlmf_4_40_14
:= by sorry

/-- DLMF 4.40.E15, on 0 < x < 1. -/
-- ANCHOR: dlmf_4_40_15
theorem dlmf_4_40_15 {x : ℝ} (hx₁ : 0 < x) (hx₂ : x < 1) : HasDerivAt (fun t => t * arsech t + Real.arcsin t) (arsech x) x
-- ANCHOR_END: dlmf_4_40_15
:= by sorry

/-- DLMF 4.40.E16, on 1 < x. -/
-- ANCHOR: dlmf_4_40_16
theorem dlmf_4_40_16 {x : ℝ} (hx : 1 < x) : HasDerivAt (fun t => t * arcoth t + (1 / 2 : ℝ) * Real.log (t ^ 2 - 1)) (arcoth x) x
-- ANCHOR_END: dlmf_4_40_16
:= by sorry

end LMLF.Blueprint.Elementary.Section440
