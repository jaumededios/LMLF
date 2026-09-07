import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

/-!
# DLMF §4.14: definitions and periodicity
-/

open scoped ComplexConjugate

namespace LMLF.Blueprint.Elementary.Section414

/-- DLMF 4.14.1: complex sine from the exponential definition. -/
-- ANCHOR: dlmf_4_14_1
theorem dlmf_4_14_1 (z : ℂ) :
    Complex.sin z =
      (Complex.exp (Complex.I * z) - Complex.exp (-Complex.I * z)) /
        (2 * Complex.I)
-- ANCHOR_END: dlmf_4_14_1
    := by sorry

/-- DLMF 4.14.2: complex cosine from the exponential definition. -/
-- ANCHOR: dlmf_4_14_2
theorem dlmf_4_14_2 (z : ℂ) :
    Complex.cos z =
      (Complex.exp (Complex.I * z) + Complex.exp (-Complex.I * z)) / 2
-- ANCHOR_END: dlmf_4_14_2
    := by sorry

/-- DLMF 4.14.3: the two exponential forms of sine and cosine. -/
-- ANCHOR: dlmf_4_14_3
theorem dlmf_4_14_3 (z : ℂ) :
    Complex.cos z + Complex.I * Complex.sin z = Complex.exp (Complex.I * z) ∧
      Complex.cos z - Complex.I * Complex.sin z = Complex.exp (-Complex.I * z)
-- ANCHOR_END: dlmf_4_14_3
    := by sorry

/-- DLMF 4.14.4: tangent as the sine/cosine quotient where cosine is nonzero. -/
-- ANCHOR: dlmf_4_14_4
theorem dlmf_4_14_4 {z : ℂ} (hz : Complex.cos z ≠ 0) :
    Complex.tan z = Complex.sin z / Complex.cos z
-- ANCHOR_END: dlmf_4_14_4
    := by sorry

/-- DLMF 4.14.5: cosecant as the reciprocal of sine away from its zeros. -/
-- ANCHOR: csc
noncomputable def csc (z : ℂ) : ℂ := 1 / Complex.sin z
-- ANCHOR_END: csc

-- ANCHOR: dlmf_4_14_5
theorem dlmf_4_14_5 {z : ℂ} (hz : Complex.sin z ≠ 0) :
    csc z = 1 / Complex.sin z
-- ANCHOR_END: dlmf_4_14_5
    := by sorry

/-- DLMF 4.14.6: secant as the reciprocal of cosine away from its zeros. -/
-- ANCHOR: sec
noncomputable def sec (z : ℂ) : ℂ := 1 / Complex.cos z
-- ANCHOR_END: sec

-- ANCHOR: dlmf_4_14_6
theorem dlmf_4_14_6 {z : ℂ} (hz : Complex.cos z ≠ 0) :
    sec z = 1 / Complex.cos z
-- ANCHOR_END: dlmf_4_14_6
    := by sorry

/-- DLMF 4.14.7: cotangent as cosine/sine and reciprocal tangent quotients. -/
-- ANCHOR: dlmf_4_14_7
theorem dlmf_4_14_7 {z : ℂ} (hs : Complex.sin z ≠ 0) (ht : Complex.tan z ≠ 0) :
    Complex.cos z / Complex.sin z = 1 / Complex.tan z
-- ANCHOR_END: dlmf_4_14_7
    := by sorry

/-- DLMF 4.14 prose after E7: complex sine zeros are integral multiples of π. -/
-- ANCHOR: sin_zero_iff
theorem sin_zero_iff (z : ℂ) :
    Complex.sin z = 0 ↔ ∃ k : ℤ, z = (k : ℂ) * Real.pi
-- ANCHOR_END: sin_zero_iff
    := by sorry

/-- DLMF 4.14 prose after E7: complex cosine zeros are half-integral multiples of π. -/
-- ANCHOR: cos_zero_iff
theorem cos_zero_iff (z : ℂ) :
    Complex.cos z = 0 ↔ ∃ k : ℤ, z = ((k : ℂ) + 1 / 2) * Real.pi
-- ANCHOR_END: cos_zero_iff
    := by sorry

/-- DLMF 4.14.8: sine has period `2π`. -/
-- ANCHOR: dlmf_4_14_8
theorem dlmf_4_14_8 (z : ℂ) (k : ℤ) :
    Complex.sin (z + 2 * (k : ℂ) * Real.pi) = Complex.sin z
-- ANCHOR_END: dlmf_4_14_8
    := by sorry

/-- DLMF 4.14.9: cosine has period `2π`. -/
-- ANCHOR: dlmf_4_14_9
theorem dlmf_4_14_9 (z : ℂ) (k : ℤ) :
    Complex.cos (z + 2 * (k : ℂ) * Real.pi) = Complex.cos z
-- ANCHOR_END: dlmf_4_14_9
    := by sorry

/-- DLMF 4.14.10: tangent has period `π` away from its poles. -/
-- ANCHOR: dlmf_4_14_10
theorem dlmf_4_14_10 {z : ℂ} (k : ℤ)
    (hz : Complex.cos (z + (k : ℂ) * Real.pi) ≠ 0) :
    Complex.tan (z + (k : ℂ) * Real.pi) = Complex.tan z
-- ANCHOR_END: dlmf_4_14_10
    := by sorry

end LMLF.Blueprint.Elementary.Section414
