import Mathlib.Analysis.Calculus.FDeriv.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import LMLF.Blueprint.ExponentialIntegrals.Section62

noncomputable section
open Set Filter
open scoped Topology
namespace LMLF.Blueprint.ExponentialIntegrals.Section65

/-- DLMF §6.5: convergence of the canonical principal E₁ map to a one-sided
boundary value on the negative real cut. -/
def E1Boundary (x σ : ℝ) (w : ℂ) : Prop :=
  Tendsto (fun t : ℝ =>
      LMLF.Blueprint.ExponentialIntegrals.Section62.principalE1
        (-x + Complex.I * (σ * t)))
    (nhdsWithin 0 (Ioi 0)) (𝓝 w)

/-- DLMF §6.5: the canonical upper or lower boundary value of E₁ on the
negative-real cut. -/
def e1CutBoundary (x σ : ℝ) : ℂ :=
  -LMLF.Blueprint.ExponentialIntegrals.Section62.realEi x -
    Complex.I * σ * Real.pi

/-- DLMF §6.5: a principal-value average across the E₁ cut. -/
def principalCutAverage (upper lower : ℂ) : ℂ := (upper + lower) / 2

/- DLMF 6.5.1 -/
-- ANCHOR: dlmf_6_5_1
theorem dlmf_6_5_1 (x σ : ℝ)
    (hx : 0 < x) (hσ : σ = 1 ∨ σ = -1) :
    E1Boundary x σ (e1CutBoundary x σ)
-- ANCHOR_END: dlmf_6_5_1
  := by sorry

/- DLMF 6.5.2 -/
-- ANCHOR: dlmf_6_5_2
theorem dlmf_6_5_2 (x : ℝ) (hx : 0 < x) :
    E1Boundary x 1 (e1CutBoundary x 1) ∧
      E1Boundary x (-1) (e1CutBoundary x (-1)) ∧
      LMLF.Blueprint.ExponentialIntegrals.Section62.realEi x =
        -principalCutAverage (e1CutBoundary x 1) (e1CutBoundary x (-1))
-- ANCHOR_END: dlmf_6_5_2
  := by sorry

/- DLMF 6.5.3 -/
-- ANCHOR: dlmf_6_5_3
theorem dlmf_6_5_3 (x : ℝ) (hx : 0 < x) :
    (LMLF.Blueprint.ExponentialIntegrals.Section62.realEi x +
        LMLF.Blueprint.ExponentialIntegrals.Section62.realE1 x) / 2 =
        LMLF.Blueprint.ExponentialIntegrals.Section62.principalShi (x : ℂ) ∧
      LMLF.Blueprint.ExponentialIntegrals.Section62.principalShi (x : ℂ) =
        -Complex.I *
          LMLF.Blueprint.ExponentialIntegrals.Section62.principalSi
            (Complex.I * x)
-- ANCHOR_END: dlmf_6_5_3
  := by sorry

/- DLMF 6.5.4 -/
-- ANCHOR: dlmf_6_5_4
theorem dlmf_6_5_4 (x : ℝ) (hx : 0 < x) :
    (LMLF.Blueprint.ExponentialIntegrals.Section62.realEi x -
        LMLF.Blueprint.ExponentialIntegrals.Section62.realE1 x) / 2 =
        LMLF.Blueprint.ExponentialIntegrals.Section62.principalChi (x : ℂ) ∧
      LMLF.Blueprint.ExponentialIntegrals.Section62.principalChi (x : ℂ) =
        LMLF.Blueprint.ExponentialIntegrals.Section62.principalCi (Complex.I * x) -
          Complex.I * Real.pi / 2
-- ANCHOR_END: dlmf_6_5_4
  := by sorry

/- DLMF 6.5.5 -/
-- ANCHOR: dlmf_6_5_5
theorem dlmf_6_5_5 (z : ℂ)
    (hz : z ≠ 0)
    (hphase : ‖Complex.arg z‖ < Real.pi / 2) :
    LMLF.Blueprint.ExponentialIntegrals.Section62.principalSi z =
      Complex.I / 2 *
        (LMLF.Blueprint.ExponentialIntegrals.Section62.principalE1
          (-Complex.I * z) -
          LMLF.Blueprint.ExponentialIntegrals.Section62.principalE1
            (Complex.I * z)) + Real.pi / 2
-- ANCHOR_END: dlmf_6_5_5
  := by sorry

/- DLMF 6.5.6 -/
-- ANCHOR: dlmf_6_5_6
theorem dlmf_6_5_6 (z : ℂ)
    (hz : z ≠ 0)
    (hphase : ‖Complex.arg z‖ < Real.pi / 2) :
    LMLF.Blueprint.ExponentialIntegrals.Section62.principalCi z =
      -(LMLF.Blueprint.ExponentialIntegrals.Section62.principalE1
          (Complex.I * z) +
        LMLF.Blueprint.ExponentialIntegrals.Section62.principalE1
          (-Complex.I * z)) / 2
-- ANCHOR_END: dlmf_6_5_6
  := by sorry

/- DLMF 6.5.7 -/
-- ANCHOR: dlmf_6_5_7
theorem dlmf_6_5_7 (z : ℂ) (hz : z ≠ 0)
    (hphase : ‖Complex.arg z‖ < Real.pi / 2) :
    LMLF.Blueprint.ExponentialIntegrals.Section62.principalAuxiliaryG z +
          Complex.I * LMLF.Blueprint.ExponentialIntegrals.Section62.principalAuxiliaryF z =
        LMLF.Blueprint.ExponentialIntegrals.Section62.principalE1
          (-Complex.I * z) * Complex.exp (-Complex.I * z) ∧
      LMLF.Blueprint.ExponentialIntegrals.Section62.principalAuxiliaryG z -
          Complex.I * LMLF.Blueprint.ExponentialIntegrals.Section62.principalAuxiliaryF z =
        LMLF.Blueprint.ExponentialIntegrals.Section62.principalE1
          (Complex.I * z) * Complex.exp (Complex.I * z)
-- ANCHOR_END: dlmf_6_5_7
  := by sorry

end LMLF.Blueprint.ExponentialIntegrals.Section65
