import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

open scoped BigOperators
open Filter
noncomputable section
namespace LMLF.Blueprint.Elementary.Section436

/-! Finite approximants and convergence statements for DLMF §4.36.  Products
and partial fractions are expressed as `Tendsto` limits of their natural finite
approximants, so no divergent or pole-valued totalized expression is asserted. -/

/-- Finite product approximant for DLMF 4.36.1. -/
def sinhProduct (z : ℂ) (N : ℕ) : ℂ :=
  z * Finset.prod (Finset.Icc 1 N) (fun n => 1 + z ^ 2 / ((n : ℂ) ^ 2 * (Real.pi : ℂ) ^ 2))
/-- Finite product approximant for DLMF 4.36.2. -/
def coshProduct (z : ℂ) (N : ℕ) : ℂ :=
  Finset.prod (Finset.Icc 1 N) (fun n => 1 + 4 * z ^ 2 / (((2 * n - 1 : ℕ) : ℂ) ^ 2 * (Real.pi : ℂ) ^ 2))
/-- Finite partial-fraction approximant for DLMF 4.36.3. -/
def cothPartial (z : ℂ) (N : ℕ) : ℂ :=
  1 / z + 2 * z * Finset.sum (Finset.Icc 1 N) (fun n => 1 / (z ^ 2 + (n : ℂ) ^ 2 * (Real.pi : ℂ) ^ 2))
/-- Finite symmetric partial-fraction approximant for DLMF 4.36.4. -/
def cschSqPartial (z : ℂ) (N : ℕ) : ℂ :=
  Finset.sum (Finset.Icc (-(N : ℤ)) (N : ℤ)) (fun n =>
    1 / (z - (n : ℂ) * (Real.pi : ℂ) * Complex.I) ^ 2)
/-- Finite partial-fraction approximant for DLMF 4.36.5. -/
def cschPartial (z : ℂ) (N : ℕ) : ℂ :=
  1 / z + 2 * z * Finset.sum (Finset.Icc 1 N) (fun n =>
    (-1 : ℂ) ^ n / (z ^ 2 + (n : ℂ) ^ 2 * (Real.pi : ℂ) ^ 2))

/-- DLMF 4.36.1: sinh infinite product, as convergence of finite products. -/
-- ANCHOR: dlmf_4_36_1
theorem dlmf_4_36_1 (z : ℂ) :
    Tendsto (sinhProduct z) atTop (nhds (Complex.sinh z)) := by sorry
-- ANCHOR_END: dlmf_4_36_1
/-- DLMF 4.36.2: cosh infinite product, as convergence of finite products. -/
-- ANCHOR: dlmf_4_36_2
theorem dlmf_4_36_2 (z : ℂ) :
    Tendsto (coshProduct z) atTop (nhds (Complex.cosh z)) := by sorry
-- ANCHOR_END: dlmf_4_36_2
/-- DLMF 4.36.3: coth partial fractions away from all poles. -/
-- ANCHOR: dlmf_4_36_3
theorem dlmf_4_36_3 (z : ℂ) (h : ∀ k : ℤ, z ≠ (k : ℂ) * (Real.pi : ℂ) * Complex.I) :
    Tendsto (cothPartial z) atTop (nhds (Complex.cosh z / Complex.sinh z)) := by sorry
-- ANCHOR_END: dlmf_4_36_3
/-- DLMF 4.36.4: symmetric csch-square partial fractions away from poles. -/
-- ANCHOR: dlmf_4_36_4
theorem dlmf_4_36_4 (z : ℂ) (h : ∀ k : ℤ, z ≠ (k : ℂ) * (Real.pi : ℂ) * Complex.I) :
    Tendsto (cschSqPartial z) atTop (nhds ((1 / Complex.sinh z) ^ 2)) := by sorry
-- ANCHOR_END: dlmf_4_36_4
/-- DLMF 4.36.5: alternating csch partial fractions away from poles. -/
-- ANCHOR: dlmf_4_36_5
theorem dlmf_4_36_5 (z : ℂ) (h : ∀ k : ℤ, z ≠ (k : ℂ) * (Real.pi : ℂ) * Complex.I) :
    Tendsto (cschPartial z) atTop (nhds (1 / Complex.sinh z)) := by sorry
-- ANCHOR_END: dlmf_4_36_5

end LMLF.Blueprint.Elementary.Section436
