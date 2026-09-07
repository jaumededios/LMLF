import Mathlib.Analysis.SpecialFunctions.Complex.Log
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Inverse
import Mathlib.Analysis.SpecialFunctions.Complex.Arctan
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.MeasureTheory.Measure.Lebesgue.Basic
import LMLF.Blueprint.ExponentialIntegrals.Section62

/-! DLMF §6.14: Laplace transforms and other integrals. -/
noncomputable section
open Set MeasureTheory
namespace LMLF.Blueprint.ExponentialIntegrals.Section614

open LMLF.Blueprint.ExponentialIntegrals.Section62

/-- DLMF 6.14.E1: the removable extension of log(1+a)/a at a = 0. -/
def logOnePlusOver (a : ℂ) : ℂ :=
  if a = 0 then 1 else Complex.log (1 + a) / a

-- ANCHOR: dlmf_6_14_1
/-- DLMF 6.14.E1: Laplace transform of E₁ on Re a > -1. -/
theorem dlmf_6_14_1 (a : ℂ) (ha : -1 < a.re) :
    HasImproperIntegral
      (fun t : ℝ => Complex.exp (-(a * (t : ℂ))) * realE1 t) 0
      (logOnePlusOver a)
-- ANCHOR_END: dlmf_6_14_1
  := by sorry

-- ANCHOR: dlmf_6_14_2
/-- DLMF 6.14.E2: Laplace transform of Ci on Re a > 0. -/
theorem dlmf_6_14_2 (a : ℂ) (ha : 0 < a.re) :
    HasImproperIntegral
      (fun t : ℝ => Complex.exp (-(a * (t : ℂ))) * principalCiPositive t) 0
      (-(1 / (2 * a)) * Complex.log (1 + a ^ 2))
-- ANCHOR_END: dlmf_6_14_2
  := by sorry

-- ANCHOR: dlmf_6_14_3
/-- DLMF 6.14.E3: Laplace transform of si on Re a > 0. -/
theorem dlmf_6_14_3 (a : ℂ) (ha : 0 < a.re) :
    HasImproperIntegral
      (fun t : ℝ => Complex.exp (-(a * (t : ℂ))) *
        (principalSi t - Real.pi / 2)) 0 (-Complex.arctan a / a)
-- ANCHOR_END: dlmf_6_14_3
  := by sorry

-- ANCHOR: dlmf_6_14_4
/-- DLMF 6.14.E4: the square integral of E₁. -/
theorem dlmf_6_14_4 :
    HasImproperIntegral (fun t : ℝ => (realE1 t) ^ 2) 0 (2 * Real.log 2 : ℂ)
-- ANCHOR_END: dlmf_6_14_4
  := by sorry

-- ANCHOR: dlmf_6_14_5
/-- DLMF 6.14.E5: the cosine/sine integral pair. -/
theorem dlmf_6_14_5 :
    HasImproperIntegral
        (fun t : ℝ => (Real.cos t : ℂ) * principalCiPositive t) 0
        (-Real.pi / 4) ∧
      HasImproperIntegral
        (fun t : ℝ => (Real.sin t : ℂ) * (principalSi t - Real.pi / 2)) 0
        (-Real.pi / 4)
-- ANCHOR_END: dlmf_6_14_5
  := by sorry

-- ANCHOR: dlmf_6_14_6
/-- DLMF 6.14.E6: the two square-integral identities. -/
theorem dlmf_6_14_6 :
    HasImproperIntegral (fun t : ℝ => principalCiPositive t ^ 2) 0
        (Real.pi / 2) ∧
      HasImproperIntegral
        (fun t : ℝ => (principalSi t - Real.pi / 2) ^ 2) 0 (Real.pi / 2)
-- ANCHOR_END: dlmf_6_14_6
  := by sorry

-- ANCHOR: dlmf_6_14_7
/-- DLMF 6.14.E7: the mixed cosine/sine integral. -/
theorem dlmf_6_14_7 :
    HasImproperIntegral
      (fun t : ℝ => principalCiPositive t * (principalSi t - Real.pi / 2)) 0
      (Real.log 2)
-- ANCHOR_END: dlmf_6_14_7
  := by sorry

end LMLF.Blueprint.ExponentialIntegrals.Section614
