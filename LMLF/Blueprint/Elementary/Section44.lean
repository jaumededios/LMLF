import LMLF.Basic
import Mathlib.Analysis.SpecialFunctions.Complex.Log
import Mathlib.Analysis.SpecialFunctions.Pow.Complex
import Mathlib.NumberTheory.Harmonic.EulerMascheroni

/-!
# DLMF §4.4: special values and limits
-/

open Filter Finset
open scoped Topology

namespace LMLF.Blueprint.Elementary.Section44

/-- DLMF 4.4.1: the principal logarithm at one. -/
-- ANCHOR: dlmf_4_4_1
theorem dlmf_4_4_1 : Complex.log 1 = 0
-- ANCHOR_END: dlmf_4_4_1
    := by sorry

/-- DLMF 4.4.2: the two boundary values of the principal logarithm at `-1`. -/
-- ANCHOR: dlmf_4_4_2
theorem dlmf_4_4_2 :
    Tendsto (fun t : ℝ ↦ Complex.log (-1 + t * Complex.I))
        (𝓝[>] 0) (𝓝 (Real.pi * Complex.I)) ∧
      Tendsto (fun t : ℝ ↦ Complex.log (-1 - t * Complex.I))
        (𝓝[>] 0) (𝓝 (-Real.pi * Complex.I))
-- ANCHOR_END: dlmf_4_4_2
    := by sorry

/-- DLMF 4.4.3: the principal logarithm at the two imaginary units. -/
-- ANCHOR: dlmf_4_4_3
theorem dlmf_4_4_3 :
    Complex.log Complex.I = (Real.pi / 2 : ℂ) * Complex.I ∧
      Complex.log (-Complex.I) = -(Real.pi / 2 : ℂ) * Complex.I
-- ANCHOR_END: dlmf_4_4_3
    := by sorry

/-- DLMF 4.4.4: the zeroth exponential power. -/
-- ANCHOR: dlmf_4_4_4
theorem dlmf_4_4_4 : Complex.exp 0 = 1
-- ANCHOR_END: dlmf_4_4_4
    := by sorry

/-- DLMF 4.4.5: exponential values at the two half-turns. -/
-- ANCHOR: dlmf_4_4_5
theorem dlmf_4_4_5 :
    Complex.exp (Real.pi * Complex.I) = -1 ∧
      Complex.exp (-Real.pi * Complex.I) = -1
-- ANCHOR_END: dlmf_4_4_5
    := by sorry

/-- DLMF 4.4.6: exponential values at the quarter-turns. -/
-- ANCHOR: dlmf_4_4_6
theorem dlmf_4_4_6 :
    Complex.exp (Real.pi / 2 * Complex.I) = Complex.I ∧
      Complex.exp (-Real.pi / 2 * Complex.I) = -Complex.I
-- ANCHOR_END: dlmf_4_4_6
    := by sorry

/-- DLMF 4.4.7: integer full turns of the exponential. -/
-- ANCHOR: dlmf_4_4_7
theorem dlmf_4_4_7 (k : ℤ) : Complex.exp (2 * Real.pi * k * Complex.I) = 1
-- ANCHOR_END: dlmf_4_4_7
    := by sorry

/-- DLMF 4.4.8: exponential values at the sixth-turns. -/
-- ANCHOR: dlmf_4_4_8
theorem dlmf_4_4_8 :
    Complex.exp (Real.pi / 3 * Complex.I) = 1 / 2 + Complex.I * (Real.sqrt 3 / 2) ∧
      Complex.exp (-Real.pi / 3 * Complex.I) = 1 / 2 - Complex.I * (Real.sqrt 3 / 2)
-- ANCHOR_END: dlmf_4_4_8
    := by sorry

/-- DLMF 4.4.9: exponential values at the third-turns. -/
-- ANCHOR: dlmf_4_4_9
theorem dlmf_4_4_9 :
    Complex.exp (2 * Real.pi / 3 * Complex.I) = -(1 / 2 : ℂ) + Complex.I * (Real.sqrt 3 / 2) ∧
      Complex.exp (-2 * Real.pi / 3 * Complex.I) = -(1 / 2 : ℂ) - Complex.I * (Real.sqrt 3 / 2)
-- ANCHOR_END: dlmf_4_4_9
    := by sorry

/-- DLMF 4.4.10: exponential values at the eighth-turns. -/
-- ANCHOR: dlmf_4_4_10
theorem dlmf_4_4_10 :
    Complex.exp (Real.pi / 4 * Complex.I) = 1 / Real.sqrt 2 + Complex.I * (1 / Real.sqrt 2) ∧
      Complex.exp (-Real.pi / 4 * Complex.I) = 1 / Real.sqrt 2 - Complex.I * (1 / Real.sqrt 2)
-- ANCHOR_END: dlmf_4_4_10
    := by sorry

/-- DLMF 4.4.11: exponential values at the three-eighths turns. -/
-- ANCHOR: dlmf_4_4_11
theorem dlmf_4_4_11 :
    Complex.exp (3 * Real.pi / 4 * Complex.I) = -(1 / Real.sqrt 2 : ℂ) + Complex.I * (1 / Real.sqrt 2) ∧
      Complex.exp (-3 * Real.pi / 4 * Complex.I) = -(1 / Real.sqrt 2 : ℂ) - Complex.I * (1 / Real.sqrt 2)
-- ANCHOR_END: dlmf_4_4_11
    := by sorry

/-- DLMF 4.4.12: imaginary powers of the imaginary unit. -/
-- ANCHOR: dlmf_4_4_12
theorem dlmf_4_4_12 :
    Complex.I ^ Complex.I = Complex.exp (-(Real.pi : ℂ) / 2) ∧
      (-Complex.I) ^ Complex.I = Complex.exp ((Real.pi : ℂ) / 2)
-- ANCHOR_END: dlmf_4_4_12
    := by sorry

/-- DLMF 4.4.13: a logarithm divided by a positive power at infinity. -/
-- ANCHOR: dlmf_4_4_13
theorem dlmf_4_4_13 {a : ℂ} (ha : 0 < a.re) :
    Tendsto (fun x : ℝ ↦ (x : ℂ) ^ (-a) * Complex.log x) atTop (𝓝 0)
-- ANCHOR_END: dlmf_4_4_13
    := by sorry

/-- DLMF 4.4.14: a positive power times a logarithm at zero. -/
-- ANCHOR: dlmf_4_4_14
theorem dlmf_4_4_14 {a : ℂ} (ha : 0 < a.re) :
    Tendsto (fun x : ℝ ↦ (x : ℂ) ^ a * Real.log x) (𝓝[>] 0) (𝓝 0)
-- ANCHOR_END: dlmf_4_4_14
    := by sorry

/-- DLMF 4.4.15: exponential decay dominates a power at infinity. -/
-- ANCHOR: dlmf_4_4_15
theorem dlmf_4_4_15 {a : ℂ} :
    Tendsto (fun x : ℝ ↦ (x : ℂ) ^ a * Complex.exp (-x)) atTop (𝓝 0)
-- ANCHOR_END: dlmf_4_4_15
    := by sorry

/-- DLMF 4.4.16: sectorial exponential decay for complex powers. -/
-- ANCHOR: dlmf_4_4_16
theorem dlmf_4_4_16 {a : ℂ} {δ : ℝ} (hδ₀ : 0 < δ) (hδ₁ : δ ≤ Real.pi / 2) :
    Tendsto (fun r : ℝ ↦ ((r : ℂ) * Complex.exp (Complex.I * (Real.pi / 2 - δ))) ^ a *
      Complex.exp (-((r : ℂ) * Complex.exp (Complex.I * (Real.pi / 2 - δ)))))
      atTop (𝓝 0)
-- ANCHOR_END: dlmf_4_4_16
    := by sorry

/-- DLMF 4.4.17: the defining exponential limit. -/
-- ANCHOR: dlmf_4_4_17
theorem dlmf_4_4_17 (z : ℂ) :
    Tendsto (fun n : ℕ ↦ (1 + z / n) ^ n) atTop (𝓝 (Complex.exp z))
-- ANCHOR_END: dlmf_4_4_17
    := by sorry

/-- DLMF 4.4.18: the standard limit defining `e`. -/
-- ANCHOR: dlmf_4_4_18
theorem dlmf_4_4_18 :
    Tendsto (fun n : ℕ ↦ (1 + (1 : ℝ) / n) ^ n) atTop (𝓝 (Real.exp 1))
-- ANCHOR_END: dlmf_4_4_18
    := by sorry

/-- DLMF 4.4.19: harmonic numbers minus their logarithm tend to Euler's constant. -/
-- ANCHOR: dlmf_4_4_19
theorem dlmf_4_4_19 :
    Tendsto (fun n : ℕ ↦ (∑ k ∈ Icc 1 n, (k : ℝ)⁻¹) - Real.log n)
      atTop (𝓝 Real.eulerMascheroniConstant)
-- ANCHOR_END: dlmf_4_4_19
    := by sorry

end LMLF.Blueprint.Elementary.Section44
