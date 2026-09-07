import LMLF.Basic
import Mathlib.Analysis.SpecialFunctions.Gamma.Basic
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic

open Filter Set MeasureTheory

namespace LMLF.Blueprint.Elementary.Section410

/-- DLMF 4.10.1: the principal-logarithm antiderivative on a branch domain. -/
-- ANCHOR: dlmf_4_10_1
theorem dlmf_4_10_1 {z : ℂ}
    (hz : z ≠ 0) (hbranch : z.im ≠ 0 ∨ 0 < z.re) :
    HasDerivAt Complex.log (1 / z) z
-- ANCHOR_END: dlmf_4_10_1
    := by sorry

/-- DLMF 4.10.2: an antiderivative of the principal logarithm. -/
-- ANCHOR: dlmf_4_10_2
theorem dlmf_4_10_2 {z : ℂ}
    (hbranch : z ≠ 0 ∧ (z.im ≠ 0 ∨ 0 < z.re)) :
    HasDerivAt (fun w : ℂ ↦ w * Complex.log w - w) (Complex.log z) z
-- ANCHOR_END: dlmf_4_10_2
    := by sorry

/-- DLMF 4.10.3: the logarithmic power antiderivative for `n ≠ -1`. -/
-- ANCHOR: dlmf_4_10_3
theorem dlmf_4_10_3 (n : ℤ) (hn : n ≠ -1) {z : ℂ}
    (hbranch : z ≠ 0 ∧ (z.im ≠ 0 ∨ 0 < z.re)) :
    HasDerivAt
      (fun w : ℂ ↦ w ^ (n + 1) / (n + 1) * Complex.log w -
        w ^ (n + 1) / (n + 1) ^ 2)
      (z ^ n * Complex.log z) z
-- ANCHOR_END: dlmf_4_10_3
    := by sorry

/-- DLMF 4.10.4: an antiderivative of `1/(z log z)` on a branch domain. -/
-- ANCHOR: dlmf_4_10_4
theorem dlmf_4_10_4 {z : ℂ}
    (hz : z ≠ 0) (hlog : Complex.log z ≠ 0)
    (hbranch : z.im ≠ 0 ∨ 0 < z.re) :
    HasDerivAt (fun w : ℂ ↦ Complex.log (Complex.log w))
      (1 / (z * Complex.log z)) z
-- ANCHOR_END: dlmf_4_10_4
    := by sorry

/-- DLMF 4.10.5: the logarithmic integral on `(0,1)`. -/
-- ANCHOR: dlmf_4_10_5
theorem dlmf_4_10_5 :
    (∫ t in Ioc (0 : ℝ) 1, Real.log t / (1 - t)) = -(Real.pi : ℝ) ^ 2 / 6
-- ANCHOR_END: dlmf_4_10_5
    := by sorry

/-- DLMF 4.10.6: the companion logarithmic integral on `(0,1)`. -/
-- ANCHOR: dlmf_4_10_6
theorem dlmf_4_10_6 :
    (∫ t in Ioc (0 : ℝ) 1, Real.log t / (1 + t)) = -(Real.pi : ℝ) ^ 2 / 12
-- ANCHOR_END: dlmf_4_10_6
    := by sorry

/-- DLMF 4.10.7: the Cauchy-principal-value logarithmic integral. -/
noncomputable def logarithmicIntegral (x : ℝ) : ℝ :=
  Filter.limUnder (nhdsWithin (0 : ℝ) (Ioi 0)) (fun ε ↦
    (∫ t in Ioc 0 (1 - ε), 1 / Real.log t) +
      (∫ t in Ioc (1 + ε) x, 1 / Real.log t))

-- ANCHOR: dlmf_4_10_7
theorem dlmf_4_10_7 {x : ℝ} (hx : 1 < x) :
    Tendsto (fun ε ↦
      (∫ t in Ioc 0 (1 - ε), 1 / Real.log t) +
        (∫ t in Ioc (1 + ε) x, 1 / Real.log t))
      (nhdsWithin (0 : ℝ) (Ioi 0)) (nhds (logarithmicIntegral x))
-- ANCHOR_END: dlmf_4_10_7
    := by sorry

/-- DLMF 4.10.8: an exponential antiderivative for nonzero `a`. -/
-- ANCHOR: dlmf_4_10_8
theorem dlmf_4_10_8 {a z : ℂ} (ha : a ≠ 0) :
    HasDerivAt (fun w : ℂ ↦ Complex.exp (a * w) / a) (Complex.exp (a * z)) z
-- ANCHOR_END: dlmf_4_10_8
    := by sorry

/-- DLMF 4.10.9: an antiderivative of a reciprocal exponential affine term. -/
-- ANCHOR: dlmf_4_10_9
theorem dlmf_4_10_9 {a b z : ℂ} (ha : a ≠ 0) (hb : b ≠ 0)
    (hz : Complex.exp (a * z) + b ≠ 0)
    (hbranch : (Complex.exp (a * z) + b).im ≠ 0 ∨
      0 < (Complex.exp (a * z) + b).re) :
    HasDerivAt
      (fun w : ℂ ↦ (a * w - Complex.log (Complex.exp (a * w) + b)) / (a * b))
      (1 / (Complex.exp (a * z) + b)) z
-- ANCHOR_END: dlmf_4_10_9
    := by sorry

/-- DLMF 4.10.10: an antiderivative of the hyperbolic tangent expression. -/
-- ANCHOR: dlmf_4_10_10
theorem dlmf_4_10_10 {a z : ℂ} (ha : a ≠ 0)
    (hz : Complex.exp (a * z) + Complex.exp (-a * z) ≠ 0)
    (hlog : Complex.exp (a * z / 2) + Complex.exp (-a * z / 2) ≠ 0)
    (hbranch : (Complex.exp (a * z / 2) + Complex.exp (-a * z / 2)).im ≠ 0 ∨
      0 < (Complex.exp (a * z / 2) + Complex.exp (-a * z / 2)).re) :
    HasDerivAt
      (fun w : ℂ ↦ 2 / a * Complex.log (Complex.exp (a * w / 2) +
        Complex.exp (-a * w / 2)))
      ((Complex.exp (a * z) - 1) / (Complex.exp (a * z) + 1)) z
-- ANCHOR_END: dlmf_4_10_10
    := by sorry

/-- DLMF 4.10.11: the complex Gaussian integral for `Re c > 0`. -/
-- ANCHOR: dlmf_4_10_11
theorem dlmf_4_10_11 {c : ℂ} (hc : 0 < c.re) :
    (∫ x : ℝ, Complex.exp (-c * (x : ℂ) ^ 2)) =
      (Real.pi / c) ^ (1 / 2 : ℂ)
-- ANCHOR_END: dlmf_4_10_11
    := by sorry

/-- DLMF 4.10.12: the finite Bose integral ending at `log 2`. -/
-- ANCHOR: dlmf_4_10_12
theorem dlmf_4_10_12 :
    (∫ x in Ioc (0 : ℝ) (Real.log 2),
      x * Real.exp x / (Real.exp x - 1)) = Real.pi ^ 2 / 12
-- ANCHOR_END: dlmf_4_10_12
    := by sorry

/-- DLMF 4.10.13: the Fermi-Dirac integral on the positive half-line. -/
-- ANCHOR: dlmf_4_10_13
theorem dlmf_4_10_13 :
    (∫ x in Ioi (0 : ℝ), 1 / (Real.exp x + 1)) = Real.log 2
-- ANCHOR_END: dlmf_4_10_13
    := by sorry

end LMLF.Blueprint.Elementary.Section410
