import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import Mathlib.Analysis.SpecialFunctions.Complex.Log
import Mathlib.Analysis.RCLike.Sqrt

/-! DLMF §4.39: continued fractions for hyperbolic and inverse hyperbolic functions. -/
namespace LMLF.Blueprint.Elementary.Section439

noncomputable section

open Filter Set
open scoped Topology

/- The poles excluded from the tanh continued fraction are the odd imaginary
   half-periods of the hyperbolic tangent. -/
-- ANCHOR: dlmf_4_39_tanhPole
/-- DLMF 4.39.E1: the pole set for the principal hyperbolic tangent. -/
def tanhPole (m : ℤ) : ℂ :=
  (((2 * m + 1 : ℤ) : ℂ) * (Real.pi : ℂ) / 2) * Complex.I
-- ANCHOR_END: dlmf_4_39_tanhPole

-- ANCHOR: dlmf_4_39_tanhPoleSet
/-- DLMF 4.39.E1: all odd imaginary half-period poles. -/
def tanhPoleSet : Set ℂ := Set.range tanhPole
-- ANCHOR_END: dlmf_4_39_tanhPoleSet

-- ANCHOR: dlmf_4_39_arcsinhCut
/-- DLMF 4.39.E2: the open principal cut plane for `arcsinh`. -/
def arcsinhCut : Set ℂ := {z | ¬(z.re = 0 ∧ (1 ≤ z.im ∨ z.im ≤ -1))}
-- ANCHOR_END: dlmf_4_39_arcsinhCut

-- ANCHOR: dlmf_4_39_arctanhCut
/-- DLMF 4.39.E3: the open principal cut plane for `arctanh`. -/
def arctanhCut : Set ℂ := {z | ¬(z.im = 0 ∧ (1 ≤ z.re ∨ z.re ≤ -1))}
-- ANCHOR_END: dlmf_4_39_arctanhCut

-- ANCHOR: dlmf_4_39_principalArcsinh
/-- DLMF 4.39.E2: the principal logarithmic branch of inverse hyperbolic sine. -/
def principalArcsinh (z : ℂ) : ℂ := Complex.log (z + Complex.sqrt (1 + z ^ 2))
-- ANCHOR_END: dlmf_4_39_principalArcsinh

-- ANCHOR: dlmf_4_39_principalArctanh
/-- DLMF 4.39.E3: the principal logarithmic branch of inverse hyperbolic tangent. -/
def principalArctanh (z : ℂ) : ℂ :=
  (Complex.log (1 + z) - Complex.log (1 - z)) / 2
-- ANCHOR_END: dlmf_4_39_principalArctanh

/- Finite tails are built from the bottom upward, so each finite convergent is
   an actual truncation of the displayed continued fraction. -/
-- ANCHOR: dlmf_4_39_tanhTail
/-- DLMF 4.39.E1: a finite odd-denominator tail for `tanh`. -/
def tanhTail : ℕ → ℕ → ℂ → ℂ
  | level, 0, _z => ((2 * level + 3 : ℕ) : ℂ)
  | level, n + 1, z => ((2 * level + 3 : ℕ) : ℂ) + z ^ 2 / tanhTail (level + 1) n z
-- ANCHOR_END: dlmf_4_39_tanhTail

-- ANCHOR: dlmf_4_39_tanhConvergent
/-- DLMF 4.39.E1: the `n`th finite convergent for `tanh`. -/
def tanhConvergent (z : ℂ) (n : ℕ) : ℂ :=
  z / (1 + z ^ 2 / tanhTail 0 n z)
-- ANCHOR_END: dlmf_4_39_tanhConvergent

-- ANCHOR: dlmf_4_39_arcsinhNumerator
/-- DLMF 4.39.E2: the repeated numerator pattern in the `arcsinh` fraction. -/
def arcsinhNumerator (level : ℕ) (z : ℂ) : ℂ :=
  (((2 * (level / 2) + 1 : ℕ) : ℂ) * ((2 * (level / 2) + 2 : ℕ) : ℂ)) * z ^ 2
-- ANCHOR_END: dlmf_4_39_arcsinhNumerator

-- ANCHOR: dlmf_4_39_arcsinhTail
/-- DLMF 4.39.E2: a finite tail for the `arcsinh` continued fraction. -/
def arcsinhTail : ℕ → ℕ → ℂ → ℂ
  | level, 0, _z => ((2 * level + 3 : ℕ) : ℂ)
  | level, n + 1, z =>
      ((2 * level + 3 : ℕ) : ℂ) + arcsinhNumerator level z / arcsinhTail (level + 1) n z
-- ANCHOR_END: dlmf_4_39_arcsinhTail

-- ANCHOR: dlmf_4_39_arcsinhConvergent
/-- DLMF 4.39.E2: the `n`th finite convergent for `arcsinh`. -/
def arcsinhConvergent (z : ℂ) (n : ℕ) : ℂ :=
  z / (1 + arcsinhNumerator 0 z / arcsinhTail 0 n z)
-- ANCHOR_END: dlmf_4_39_arcsinhConvergent

-- ANCHOR: dlmf_4_39_arctanhNumerator
/-- DLMF 4.39.E3: the square numerator sequence in the `arctanh` fraction. -/
def arctanhNumerator (level : ℕ) (z : ℂ) : ℂ :=
  (((level + 1 : ℕ) : ℂ) ^ 2) * z ^ 2
-- ANCHOR_END: dlmf_4_39_arctanhNumerator

-- ANCHOR: dlmf_4_39_arctanhTail
/-- DLMF 4.39.E3: a finite tail for the `arctanh` continued fraction. -/
def arctanhTail : ℕ → ℕ → ℂ → ℂ
  | level, 0, _z => ((2 * level + 3 : ℕ) : ℂ)
  | level, n + 1, z =>
      ((2 * level + 3 : ℕ) : ℂ) - arctanhNumerator level z / arctanhTail (level + 1) n z
-- ANCHOR_END: dlmf_4_39_arctanhTail

-- ANCHOR: dlmf_4_39_arctanhConvergent
/-- DLMF 4.39.E3: the `n`th finite convergent for `arctanh`. -/
def arctanhConvergent (z : ℂ) (n : ℕ) : ℂ :=
  z / (1 - arctanhNumerator 0 z / arctanhTail 0 n z)
-- ANCHOR_END: dlmf_4_39_arctanhConvergent

-- ANCHOR: dlmf_4_39_1
/-- DLMF 4.39.E1: convergence of the finite `tanh` continued-fraction convergents. -/
theorem dlmf_4_39_1 (z : ℂ) (hz : z ∉ tanhPoleSet) :
    Tendsto (fun n : ℕ => tanhConvergent z n) atTop (𝓝 (Complex.tanh z)) := by sorry
-- ANCHOR_END: dlmf_4_39_1

-- ANCHOR: dlmf_4_39_2
/-- DLMF 4.39.E2: convergence of the finite `arcsinh` continued-fraction convergents. -/
theorem dlmf_4_39_2 (z : ℂ) (hz : z ∈ arcsinhCut) :
    Tendsto (fun n : ℕ => arcsinhConvergent z n) atTop
      (𝓝 (principalArcsinh z / Complex.sqrt (1 + z ^ 2))) := by sorry
-- ANCHOR_END: dlmf_4_39_2

-- ANCHOR: dlmf_4_39_3
/-- DLMF 4.39.E3: convergence of the finite `arctanh` continued-fraction convergents. -/
theorem dlmf_4_39_3 (z : ℂ) (hz : z ∈ arctanhCut) :
    Tendsto (fun n : ℕ => arctanhConvergent z n) atTop (𝓝 (principalArctanh z)) := by sorry
-- ANCHOR_END: dlmf_4_39_3

end
end LMLF.Blueprint.Elementary.Section439
