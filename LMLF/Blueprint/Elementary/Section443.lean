import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex

noncomputable section
namespace LMLF.Blueprint.Elementary.Section443
open Complex
def depressedCubic (p q : ℝ) (z : ℂ) : ℂ := z ^ 3 + (p : ℂ) * z + q
def cubicDiscriminant (p q : ℝ) : ℝ := 4 * p ^ 3 + 27 * q ^ 2
def sineScale (p : ℝ) : ℝ := Real.sqrt (-4 * p / 3)
def hyperbolicScale (p : ℝ) : ℝ := Real.sqrt (4 * p / 3)
def cubicSineRoot (p a : ℝ) : ℝ := sineScale p * Real.sin a
def cubicCoshRoot (p : ℝ) (a : ℂ) : ℂ := (sineScale p : ℂ) * Complex.cosh a
def cubicSinhRoot (p : ℝ) (a : ℂ) : ℂ := (hyperbolicScale p : ℂ) * Complex.sinh a
-- ANCHOR: dlmf_4_43_1
theorem dlmf_4_43_1 {p : ℝ} (hp : p ≠ 0) :
    (p < 0 → |sineScale p| = Real.sqrt (-4 * p / 3)) ∧
    (0 < p → |hyperbolicScale p| = Real.sqrt (4 * p / 3))
-- ANCHOR_END: dlmf_4_43_1
 := by sorry
-- ANCHOR: dlmf_4_43_2
theorem dlmf_4_43_2 (p q : ℝ) :
    (p < 0 ∧ cubicDiscriminant p q ≤ 0 →
      ∃ a : ℝ, Real.sin (3 * a) = 4 * q / sineScale p ^ 3 ∧
        depressedCubic p q (cubicSineRoot p a) = 0 ∧
        depressedCubic p q (cubicSineRoot p (a + 2 * Real.pi / 3)) = 0 ∧
        depressedCubic p q (cubicSineRoot p (a + 4 * Real.pi / 3)) = 0) ∧
    (p < 0 ∧ q < 0 ∧ 0 < cubicDiscriminant p q →
      ∃ a : ℂ, Complex.cosh (3 * a) = (-4 * q / sineScale p ^ 3 : ℂ) ∧
        depressedCubic p q (cubicCoshRoot p a) = 0 ∧
        depressedCubic p q (cubicCoshRoot p (a + 2 * Real.pi * Complex.I / 3)) = 0 ∧
        depressedCubic p q (cubicCoshRoot p (a + 4 * Real.pi * Complex.I / 3)) = 0) ∧
    (0 < p → ∃ a : ℂ, Complex.sinh (3 * a) = (-4 * q / hyperbolicScale p ^ 3 : ℂ) ∧
        depressedCubic p q (cubicSinhRoot p a) = 0 ∧
        depressedCubic p q (cubicSinhRoot p (a + 2 * Real.pi * Complex.I / 3)) = 0 ∧
        depressedCubic p q (cubicSinhRoot p (a + 4 * Real.pi * Complex.I / 3)) = 0)
-- ANCHOR_END: dlmf_4_43_2
 := by sorry
-- ANCHOR: dlmf_4_43_2a
theorem dlmf_4_43_2a {p q a : ℝ}
    (hp : p < 0) (hd : cubicDiscriminant p q ≤ 0)
    (ha : Real.sin (3 * a) = 4 * q / sineScale p ^ 3) :
    depressedCubic p q (cubicSineRoot p a) = 0 ∧
    depressedCubic p q (cubicSineRoot p (a + 2 * Real.pi / 3)) = 0 ∧
    depressedCubic p q (cubicSineRoot p (a + 4 * Real.pi / 3)) = 0
-- ANCHOR_END: dlmf_4_43_2a
 := by sorry
-- ANCHOR: dlmf_4_43_2b
theorem dlmf_4_43_2b {p q : ℝ} {a : ℂ}
    (hp : p < 0) (hq : q < 0) (hd : 0 < cubicDiscriminant p q)
    (ha : Complex.cosh (3 * a) = (-4 * q / sineScale p ^ 3 : ℂ)) :
    depressedCubic p q (cubicCoshRoot p a) = 0 ∧
    depressedCubic p q (cubicCoshRoot p (a + 2 * Real.pi * Complex.I / 3)) = 0 ∧
    depressedCubic p q (cubicCoshRoot p (a + 4 * Real.pi * Complex.I / 3)) = 0
-- ANCHOR_END: dlmf_4_43_2b
 := by sorry
-- ANCHOR: dlmf_4_43_2c
theorem dlmf_4_43_2c {p q : ℝ} {a : ℂ}
    (hp : 0 < p)
    (ha : Complex.sinh (3 * a) = (-4 * q / hyperbolicScale p ^ 3 : ℂ)) :
    depressedCubic p q (cubicSinhRoot p a) = 0 ∧
    depressedCubic p q (cubicSinhRoot p (a + 2 * Real.pi * Complex.I / 3)) = 0 ∧
    depressedCubic p q (cubicSinhRoot p (a + 4 * Real.pi * Complex.I / 3)) = 0
-- ANCHOR_END: dlmf_4_43_2c
 := by sorry
end LMLF.Blueprint.Elementary.Section443
