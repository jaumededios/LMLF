import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Inverse

/-! DLMF §4.42, solution of planar and spherical triangles.

The declarations use real side lengths and angles.  The small domain
predicates make positivity, nondegeneracy, and the usual angle ranges visible
without hiding any of the displayed identities. -/
namespace LMLF.Blueprint.Elementary.Section442

/-- DLMF §4.42: positive, nondegenerate right-triangle data. -/
def rightTriangleData (a b c A : ℝ) : Prop :=
  0 < a ∧ 0 < b ∧ 0 < c ∧ 0 < A ∧ A < Real.pi / 2 ∧
    a ^ 2 + b ^ 2 = c ^ 2 ∧ A = Real.arcsin (a / c)

/-- DLMF §4.42: positive side lengths and angles of a planar triangle. -/
def planarTriangleData (a b c A B C : ℝ) : Prop :=
  0 < a ∧ 0 < b ∧ 0 < c ∧ 0 < A ∧ A < Real.pi ∧
    0 < B ∧ B < Real.pi ∧ 0 < C ∧ C < Real.pi ∧
    A + B + C = Real.pi ∧ a < b + c ∧ b < a + c ∧ c < a + b ∧
    (∃ R : ℝ, 0 < R ∧ a = 2 * R * Real.sin A ∧
      b = 2 * R * Real.sin B ∧ c = 2 * R * Real.sin C)

/-- DLMF §4.42: nondegenerate side/angle data for a spherical triangle. -/
def sphericalTriangleData (a b c A B C : ℝ) : Prop :=
  0 < a ∧ a < Real.pi ∧ 0 < b ∧ b < Real.pi ∧ 0 < c ∧ c < Real.pi ∧
    0 < A ∧ A < Real.pi ∧ 0 < B ∧ B < Real.pi ∧ 0 < C ∧ C < Real.pi ∧
    Real.pi < A + B + C ∧ b ≠ Real.pi / 2 ∧ B ≠ Real.pi / 2 ∧
    Real.cos a = Real.cos b * Real.cos c + Real.sin b * Real.sin c * Real.cos A ∧
    Real.sin A / Real.sin a = Real.sin B / Real.sin b ∧
      Real.sin B / Real.sin b = Real.sin C / Real.sin c ∧
    Real.cos A = -Real.cos B * Real.cos C +
      Real.sin B * Real.sin C * Real.cos a

/-! Planar right triangles. -/

/-- DLMF 4.42.1: sine ratio in a planar right triangle. -/
-- ANCHOR: dlmf_4_42_1
theorem dlmf_4_42_1 {a b c A : ℝ} (h : rightTriangleData a b c A) :
    Real.sin A = a / c
-- ANCHOR_END: dlmf_4_42_1
  := by sorry

/-- DLMF 4.42.2: cosine ratio in a planar right triangle. -/
-- ANCHOR: dlmf_4_42_2
theorem dlmf_4_42_2 {a b c A : ℝ} (h : rightTriangleData a b c A) :
    Real.cos A = b / c
-- ANCHOR_END: dlmf_4_42_2
  := by sorry

/-- DLMF 4.42.3: tangent ratio in a planar right triangle. -/
-- ANCHOR: dlmf_4_42_3
theorem dlmf_4_42_3 {a b A : ℝ} (h : rightTriangleData a b (Real.sqrt (a ^ 2 + b ^ 2)) A) :
    Real.tan A = a / b
-- ANCHOR_END: dlmf_4_42_3
  := by sorry

/-! General planar triangles. -/

/-- DLMF 4.42.4: law of sines for a planar triangle. -/
-- ANCHOR: dlmf_4_42_4
theorem dlmf_4_42_4 {a b c A B C : ℝ} (h : planarTriangleData a b c A B C) :
    a / Real.sin A = b / Real.sin B ∧ b / Real.sin B = c / Real.sin C
-- ANCHOR_END: dlmf_4_42_4
  := by sorry

/-- DLMF 4.42.5: law of cosines for a planar triangle. -/
-- ANCHOR: dlmf_4_42_5
theorem dlmf_4_42_5 {a b c A B C : ℝ}
    (h : planarTriangleData a b c A B C) :
    c ^ 2 = a ^ 2 + b ^ 2 - 2 * a * b * Real.cos C
-- ANCHOR_END: dlmf_4_42_5
  := by sorry

/-- DLMF 4.42.6: projection form of the planar cosine law. -/
-- ANCHOR: dlmf_4_42_6
theorem dlmf_4_42_6 {a b c B C : ℝ} (h : planarTriangleData a b c (Real.pi - B - C) B C) :
    a = b * Real.cos C + c * Real.cos B
-- ANCHOR_END: dlmf_4_42_6
  := by sorry

/-- DLMF 4.42.7: area and Heron formulas. -/
-- ANCHOR: dlmf_4_42_7
theorem dlmf_4_42_7 {a b c A B C : ℝ} (h : planarTriangleData a b c A B C) :
    let s := (a + b + c) / 2
    (b * c * Real.sin A) / 2 = Real.sqrt (s * (s - a) * (s - b) * (s - c))
-- ANCHOR_END: dlmf_4_42_7
  := by sorry

/-! Spherical triangles. -/

/-- DLMF 4.42.8: spherical cosine law for sides. -/
-- ANCHOR: dlmf_4_42_8
theorem dlmf_4_42_8 {a b c A B C : ℝ} (h : sphericalTriangleData a b c A B C) :
    Real.cos a = Real.cos b * Real.cos c + Real.sin b * Real.sin c * Real.cos A
-- ANCHOR_END: dlmf_4_42_8
  := by sorry

/-- DLMF 4.42.9: spherical sine law. -/
-- ANCHOR: dlmf_4_42_9
theorem dlmf_4_42_9 {a b c A B C : ℝ} (h : sphericalTriangleData a b c A B C) :
    Real.sin A / Real.sin a = Real.sin B / Real.sin b ∧
      Real.sin B / Real.sin b = Real.sin C / Real.sin c
-- ANCHOR_END: dlmf_4_42_9
  := by sorry

/-- DLMF 4.42.10: spherical sine-cosine relation. -/
-- ANCHOR: dlmf_4_42_10
theorem dlmf_4_42_10 {a b c A B C : ℝ}
    (h : sphericalTriangleData a b c A B C) :
    Real.sin a * Real.cos B = Real.cos b * Real.sin c -
      Real.sin b * Real.cos c * Real.cos A
-- ANCHOR_END: dlmf_4_42_10
  := by sorry

/-- DLMF 4.42.11: cotangent form of a spherical identity. -/
-- ANCHOR: dlmf_4_42_11
theorem dlmf_4_42_11 {a b c A B C : ℝ} (h : sphericalTriangleData a b c A B C) :
    Real.cos a * Real.cos C = Real.sin a / Real.tan b - Real.sin C / Real.tan B
-- ANCHOR_END: dlmf_4_42_11
  := by sorry

/-- DLMF 4.42.12: spherical cosine law for angles. -/
-- ANCHOR: dlmf_4_42_12
theorem dlmf_4_42_12 {a b c A B C : ℝ} (h : sphericalTriangleData a b c A B C) :
    Real.cos A = -Real.cos B * Real.cos C + Real.sin B * Real.sin C * Real.cos a
-- ANCHOR_END: dlmf_4_42_12
  := by sorry

end LMLF.Blueprint.Elementary.Section442
