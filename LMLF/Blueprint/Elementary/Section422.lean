import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import Mathlib.Topology.Algebra.InfiniteSum.Basic

open Filter Set
open scoped BigOperators Topology

noncomputable section

namespace LMLF.Blueprint.Elementary.Section422

/-! The products and sums below are genuine infinite objects.  The bilateral
partial fraction in E4 uses the symmetric integer summation filter. -/

/-- DLMF 4.22.1: factors in the sine product. -/
-- ANCHOR: sineProductTerm
def sineProductTerm (z : ℂ) (n : ℕ) : ℂ :=
  1 - z ^ 2 / (((n + 1 : ℕ) : ℂ) ^ 2 * (Real.pi : ℂ) ^ 2)
-- ANCHOR_END: sineProductTerm

/-- DLMF 4.22.2: factors in the cosine product. -/
-- ANCHOR: cosineProductTerm
def cosineProductTerm (z : ℂ) (n : ℕ) : ℂ :=
  1 - 4 * z ^ 2 / (((2 * n + 1 : ℕ) : ℂ) ^ 2 * (Real.pi : ℂ) ^ 2)
-- ANCHOR_END: cosineProductTerm

/-- DLMF 4.22.1: the normalized value of the sine product, including its
entire extension at `z = 0`. -/
-- ANCHOR: sineProductValue
def sineProductValue (z : ℂ) : ℂ :=
  if z = 0 then 1 else Complex.sin z / z
-- ANCHOR_END: sineProductValue

/-- DLMF 4.22.3: terms in the cotangent partial fraction. -/
-- ANCHOR: cotangentPartialFractionTerm
def cotangentPartialFractionTerm (z : ℂ) (n : ℕ) : ℂ :=
  2 * z / (z ^ 2 - (n : ℂ) ^ 2 * (Real.pi : ℂ) ^ 2)
-- ANCHOR_END: cotangentPartialFractionTerm

/-- DLMF 4.22.4: terms in the bilateral cosecant-square sum. -/
-- ANCHOR: cosecantSquareTerm
def cosecantSquareTerm (z : ℂ) (n : ℤ) : ℂ :=
  1 / (z - (n : ℂ) * (Real.pi : ℂ)) ^ 2
-- ANCHOR_END: cosecantSquareTerm

/-- DLMF 4.22.5: terms in the cosecant partial fraction. -/
-- ANCHOR: cosecantPartialFractionTerm
def cosecantPartialFractionTerm (z : ℂ) (n : ℕ) : ℂ :=
  2 * z * (-1 : ℂ) ^ n / (z ^ 2 - (n : ℂ) ^ 2 * (Real.pi : ℂ) ^ 2)
-- ANCHOR_END: cosecantPartialFractionTerm

/-- DLMF 4.22.4: symmetric finite intervals `[-N,N]` for bilateral sums. -/
-- ANCHOR: symmetricIntegerSummation
def symmetricIntegerSummation : SummationFilter ℤ where
  filter := Filter.map (fun N : ℕ ↦ Finset.Icc (-(N : ℤ)) (N : ℤ)) atTop
-- ANCHOR_END: symmetricIntegerSummation

/-- DLMF 4.22.1: sine's Weierstrass product. -/
-- ANCHOR: dlmf_4_22_1
theorem dlmf_4_22_1 (z : ℂ) :
    HasProd (fun n : ℕ ↦ sineProductTerm z n) (sineProductValue z) ∧
      Complex.sin z = z * sineProductValue z
-- ANCHOR_END: dlmf_4_22_1
    := by sorry

/-- DLMF 4.22.2: cosine's Weierstrass product. -/
-- ANCHOR: dlmf_4_22_2
theorem dlmf_4_22_2 (z : ℂ) :
    HasProd (fun n : ℕ ↦ cosineProductTerm z n) (Complex.cos z)
-- ANCHOR_END: dlmf_4_22_2
    := by sorry

/-- DLMF 4.22.3: cotangent partial fractions away from its poles. -/
-- ANCHOR: dlmf_4_22_3
theorem dlmf_4_22_3 {z : ℂ}
    (hz : ∀ n : ℤ, z ≠ (n : ℂ) * (Real.pi : ℂ)) :
    Complex.cot z = 1 / z + ∑' n : ℕ, cotangentPartialFractionTerm z (n + 1)
-- ANCHOR_END: dlmf_4_22_3
    := by sorry

/-- DLMF 4.22.4: bilateral cosecant-square partial fractions. -/
-- ANCHOR: dlmf_4_22_4
theorem dlmf_4_22_4 {z : ℂ}
    (hz : ∀ n : ℤ, z ≠ (n : ℂ) * (Real.pi : ℂ)) :
    HasSum (L := symmetricIntegerSummation)
      (fun n : ℤ ↦ cosecantSquareTerm z n) ((1 / Complex.sin z) ^ 2)
-- ANCHOR_END: dlmf_4_22_4
    := by sorry

/-- DLMF 4.22.5: cosecant partial fractions away from its poles. -/
-- ANCHOR: dlmf_4_22_5
theorem dlmf_4_22_5 {z : ℂ}
    (hz : ∀ n : ℤ, z ≠ (n : ℂ) * (Real.pi : ℂ)) :
    1 / Complex.sin z = 1 / z + ∑' n : ℕ, cosecantPartialFractionTerm z (n + 1)
-- ANCHOR_END: dlmf_4_22_5
    := by sorry

end LMLF.Blueprint.Elementary.Section422
