import Mathlib.Analysis.SpecialFunctions.Trigonometric.ComplexDeriv

noncomputable section

namespace LMLF.Blueprint.Elementary.Section420

/- DLMF §4.20.5: secant quotient. -/
-- ANCHOR: sec
def sec (z : ℂ) : ℂ := 1 / Complex.cos z
-- ANCHOR_END: sec
/- DLMF §4.20.4: cosecant quotient. -/
-- ANCHOR: csc
def csc (z : ℂ) : ℂ := 1 / Complex.sin z
-- ANCHOR_END: csc
/- DLMF §4.20.6: cotangent quotient. -/
-- ANCHOR: cot
def cot (z : ℂ) : ℂ := Complex.cos z / Complex.sin z
-- ANCHOR_END: cot

/- DLMF §4.20.12: second-order solution candidate. -/
-- ANCHOR: secondOrderCandidate
def secondOrderCandidate (a A B z : ℂ) : ℂ :=
  A * Complex.cos (a * z) + B * Complex.sin (a * z)
-- ANCHOR_END: secondOrderCandidate

/- DLMF §4.20.13: first-order energy-equation candidate. -/
-- ANCHOR: energyCandidate
def energyCandidate (a c z : ℂ) : ℂ := (1 / a) * Complex.sin (a * z + c)
-- ANCHOR_END: energyCandidate

/- DLMF §4.20.14: Riccati solution candidate. -/
-- ANCHOR: riccatiCandidate
def riccatiCandidate (a c z : ℂ) : ℂ := (1 / a) * Complex.tan (a * z + c)
-- ANCHOR_END: riccatiCandidate

/- DLMF §4.20.1: derivative of sine. -/
-- ANCHOR: dlmf_4_20_1
theorem dlmf_4_20_1 (z : ℂ) : deriv Complex.sin z = Complex.cos z
-- ANCHOR_END: dlmf_4_20_1
    := by sorry

/- DLMF §4.20.2: derivative of cosine. -/
-- ANCHOR: dlmf_4_20_2
theorem dlmf_4_20_2 (z : ℂ) : deriv Complex.cos z = -Complex.sin z
-- ANCHOR_END: dlmf_4_20_2
    := by sorry

/- DLMF §4.20.3: derivative of tangent away from its poles. -/
-- ANCHOR: dlmf_4_20_3
theorem dlmf_4_20_3 {z : ℂ} (hz : Complex.cos z ≠ 0) :
    deriv Complex.tan z = sec z ^ 2
-- ANCHOR_END: dlmf_4_20_3
    := by sorry

/- DLMF §4.20.4: derivative of cosecant away from its poles. -/
-- ANCHOR: dlmf_4_20_4
theorem dlmf_4_20_4 {z : ℂ} (hz : Complex.sin z ≠ 0) :
    deriv csc z = -csc z * cot z
-- ANCHOR_END: dlmf_4_20_4
    := by sorry

/- DLMF §4.20.5: derivative of secant away from its poles. -/
-- ANCHOR: dlmf_4_20_5
theorem dlmf_4_20_5 {z : ℂ} (hz : Complex.cos z ≠ 0) :
    deriv sec z = sec z * Complex.tan z
-- ANCHOR_END: dlmf_4_20_5
    := by sorry

/- DLMF §4.20.6: derivative of cotangent away from its poles. -/
-- ANCHOR: dlmf_4_20_6
theorem dlmf_4_20_6 {z : ℂ} (hz : Complex.sin z ≠ 0) :
    deriv cot z = -(csc z) ^ 2
-- ANCHOR_END: dlmf_4_20_6
    := by sorry

/- DLMF §4.20.7: all derivatives of sine. -/
-- ANCHOR: dlmf_4_20_7
theorem dlmf_4_20_7 (n : ℕ) (z : ℂ) :
    iteratedDeriv n Complex.sin z =
      Complex.sin (z + (n : ℂ) * (Real.pi / 2))
-- ANCHOR_END: dlmf_4_20_7
    := by sorry

/- DLMF §4.20.8: all derivatives of cosine. -/
-- ANCHOR: dlmf_4_20_8
theorem dlmf_4_20_8 (n : ℕ) (z : ℂ) :
    iteratedDeriv n Complex.cos z =
      Complex.cos (z + (n : ℂ) * (Real.pi / 2))
-- ANCHOR_END: dlmf_4_20_8
    := by sorry

/- DLMF §4.20.9: the second-order equation, witnessed by its solution family. -/
-- ANCHOR: dlmf_4_20_9
theorem dlmf_4_20_9 (a A B z : ℂ) (ha : a ≠ 0) :
    deriv (fun z => deriv (fun z => secondOrderCandidate a A B z) z) z +
      a ^ 2 * secondOrderCandidate a A B z = 0
-- ANCHOR_END: dlmf_4_20_9
    := by sorry

/- DLMF §4.20.10: the first-order energy equation, witnessed by its family. -/
-- ANCHOR: dlmf_4_20_10
theorem dlmf_4_20_10 (a c z : ℂ) (ha : a ≠ 0) :
    (deriv (fun z => energyCandidate a c z) z) ^ 2 +
      a ^ 2 * (energyCandidate a c z) ^ 2 = 1
-- ANCHOR_END: dlmf_4_20_10
    := by sorry

/- DLMF §4.20.11: the Riccati equation, witnessed by its family. -/
-- ANCHOR: dlmf_4_20_11
theorem dlmf_4_20_11 (a c z : ℂ) (ha : a ≠ 0)
    (hcos : Complex.cos (a * z + c) ≠ 0) :
    deriv (fun z => riccatiCandidate a c z) z -
      a ^ 2 * (riccatiCandidate a c z) ^ 2 = 1
-- ANCHOR_END: dlmf_4_20_11
    := by sorry

/- DLMF §4.20.12: the complete solution family of the second-order equation. -/
-- ANCHOR: dlmf_4_20_12
theorem dlmf_4_20_12 (a : ℂ) (ha : a ≠ 0) :
    ∀ w : ℂ → ℂ,
      (Differentiable ℂ w ∧
        (∀ z, deriv (fun z => deriv w z) z + a ^ 2 * w z = 0)) ↔
      ∃ A B : ℂ, ∀ z, w z = secondOrderCandidate a A B z
-- ANCHOR_END: dlmf_4_20_12
    := by sorry

/- DLMF §4.20.13: the complete solution family of the energy equation. -/
-- ANCHOR: dlmf_4_20_13
theorem dlmf_4_20_13 (a : ℂ) (ha : a ≠ 0) :
    ∀ w : ℂ → ℂ,
      (Differentiable ℂ w ∧
        (∀ z, (deriv w z) ^ 2 + a ^ 2 * (w z) ^ 2 = 1)) ↔
      (∃ c : ℂ, ∀ z, w z = energyCandidate a c z) ∨
        (∀ z, w z = 1 / a) ∨ (∀ z, w z = -(1 / a))
-- ANCHOR_END: dlmf_4_20_13
    := by sorry

/- DLMF §4.20.14: the complete local solution family of the Riccati equation. -/
-- ANCHOR: dlmf_4_20_14
theorem dlmf_4_20_14 (a : ℂ) (ha : a ≠ 0) (U : Set ℂ)
    (hUopen : IsOpen U) (hUconn : IsPreconnected U) :
    ∀ w : ℂ → ℂ,
      (DifferentiableOn ℂ w U ∧
        (∀ z ∈ U, (derivWithin w U z) - a ^ 2 * (w z) ^ 2 = 1)) ↔
      (∃ c : ℂ, (∀ z ∈ U, w z = riccatiCandidate a c z) ∧
        (∀ z ∈ U, Complex.cos (a * z + c) ≠ 0)) ∨
        (∀ z ∈ U, w z = Complex.I / a) ∨
        (∀ z ∈ U, w z = -Complex.I / a)
-- ANCHOR_END: dlmf_4_20_14
    := by sorry

end LMLF.Blueprint.Elementary.Section420
