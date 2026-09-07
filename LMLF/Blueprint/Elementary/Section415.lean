import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import Mathlib.Analysis.SpecialFunctions.Complex.Arg
import Mathlib.Analysis.SpecialFunctions.Complex.Arctan
import Mathlib.Analysis.RCLike.Sqrt

open Set

noncomputable section

namespace LMLF.Blueprint.Elementary.Section415

/-- The two boundary sides of a slit in the conformal-map table. -/
-- ANCHOR: SlitSide
inductive SlitSide where
  | upper
  | lower
deriving DecidableEq, Repr
-- ANCHOR_END: SlitSide

/-- A labeled point correspondence, retaining the side of a slit when present. -/
-- ANCHOR: SineCorrespondence
structure SineCorrespondence where
  label : String
  z : ℂ
  w : ℂ
  side : Option SlitSide
-- ANCHOR_END: SineCorrespondence

/-- DLMF 4.15.F8--F13: height of a complex-function surface. -/
-- ANCHOR: surfaceHeight
def surfaceHeight (f : ℂ → ℂ) (x y : ℝ) : ℝ :=
  ‖f (x + (y : ℂ) * Complex.I)‖
-- ANCHOR_END: surfaceHeight

/-- DLMF 4.15.F8--F13: phase coloring of a complex-function surface. -/
-- ANCHOR: surfacePhase
def surfacePhase (f : ℂ → ℂ) (x y : ℝ) : ℝ :=
  Complex.arg (f (x + (y : ℂ) * Complex.I))
-- ANCHOR_END: surfacePhase

/-- DLMF 4.15.F9: branch cuts of the principal arcsine surface. -/
-- ANCHOR: arcsinBranchCut
def arcsinBranchCut : Set ℂ :=
  {z | z.im = 0 ∧ (z.re ≤ -1 ∨ 1 ≤ z.re)}
-- ANCHOR_END: arcsinBranchCut

/-- DLMF 4.15.F11: branch cuts of the principal arctangent surface. -/
-- ANCHOR: arctanBranchCut
def arctanBranchCut : Set ℂ :=
  {z | z.re = 0 ∧ (z.im ≤ -1 ∨ 1 ≤ z.im)}
-- ANCHOR_END: arctanBranchCut

/-- DLMF 4.15.F13: branch cut of the principal arccosecant surface. -/
-- ANCHOR: arccscBranchCut
def arccscBranchCut : Set ℂ :=
  {z | z.im = 0 ∧ -1 ≤ z.re ∧ z.re ≤ 1}
-- ANCHOR_END: arccscBranchCut

/-- DLMF 4.15.F9: the principal complex arcsine used by the surface. -/
-- ANCHOR: principalArcsin
def principalArcsin (z : ℂ) : ℂ :=
  -Complex.I * Complex.log (Complex.I * z + Complex.sqrt (1 - z ^ 2))
-- ANCHOR_END: principalArcsin

/-- DLMF 4.15.F3/F5/F12: reciprocal trigonometric functions used by the plots. -/
-- ANCHOR: complexSecCsc
def complexSec (z : ℂ) : ℂ := 1 / Complex.cos z
def complexCsc (z : ℂ) : ℂ := 1 / Complex.sin z
-- ANCHOR_END: complexSecCsc

/-- DLMF 4.15.F13: the principal arccosecant surface function. -/
-- ANCHOR: principalArccsc
def principalArccsc (z : ℂ) : ℂ := principalArcsin (1 / z)
-- ANCHOR_END: principalArccsc

/-- Pole-free domain for the secant/cosecant modulus identities. -/
-- ANCHOR: reciprocalTrigDomain
def reciprocalTrigDomain (z : ℂ) : Prop :=
  Complex.sin z ≠ 0 ∧ Complex.cos z ≠ 0
-- ANCHOR_END: reciprocalTrigDomain

/-- The principal arccosecant surface is considered away from its pole and
branch cut. -/
-- ANCHOR: principalArccscDomain
def principalArccscDomain (z : ℂ) : Prop :=
  z ≠ 0 ∧ z ∉ arccscBranchCut
-- ANCHOR_END: principalArccscDomain

/-- DLMF 4.15.1: modulus translation from cosine to sine. -/
-- ANCHOR: dlmf_4_15_1
theorem dlmf_4_15_1 (x y : ℝ)
    (hcos : Complex.cos (x + (y : ℂ) * Complex.I) ≠ 0)
    (hsin : Complex.sin (x + (Real.pi : ℂ) / 2 + (y : ℂ) * Complex.I) ≠ 0) :
    ‖Complex.cos (x + (y : ℂ) * Complex.I)‖ =
      ‖Complex.sin (x + (Real.pi : ℂ) / 2 + (y : ℂ) * Complex.I)‖
-- ANCHOR_END: dlmf_4_15_1
    := by sorry

/-- DLMF 4.15.2: modulus translation from cotangent to tangent. -/
-- ANCHOR: dlmf_4_15_2
theorem dlmf_4_15_2 (x y : ℝ)
    (hsin : Complex.sin (x + (y : ℂ) * Complex.I) ≠ 0)
    (hcos : Complex.cos (x + (Real.pi : ℂ) / 2 + (y : ℂ) * Complex.I) ≠ 0) :
    ‖Complex.cot (x + (y : ℂ) * Complex.I)‖ =
      ‖-Complex.tan (x + (Real.pi : ℂ) / 2 + (y : ℂ) * Complex.I)‖
-- ANCHOR_END: dlmf_4_15_2
    := by sorry

/-- DLMF 4.15.3: modulus translation from secant to cosecant. -/
-- ANCHOR: dlmf_4_15_3
theorem dlmf_4_15_3 (x y : ℝ)
    (hdom : reciprocalTrigDomain (x + (y : ℂ) * Complex.I)) :
    ‖complexSec (x + (y : ℂ) * Complex.I)‖ =
      ‖complexCsc (x + (Real.pi : ℂ) / 2 + (y : ℂ) * Complex.I)‖
-- ANCHOR_END: dlmf_4_15_3
    := by sorry

/-- DLMF 4.15.F7: complete correspondence table for `w = sin z` at positive
real parameter `r`; the `±i0` values retain the two sides of the cuts. -/
-- ANCHOR: sineConformalTable
def sineConformalTable (r : ℝ) : List SineCorrespondence :=
  [ { label := "A", z := 0, w := 0, side := none },
    { label := "B", z := (Real.pi : ℂ) / 2, w := 1, side := none },
    { label := "C", z := (Real.pi : ℂ) / 2 + (r : ℂ) * Complex.I,
      w := Real.cosh r, side := some SlitSide.upper },
    { label := "C̄", z := (Real.pi : ℂ) / 2 - (r : ℂ) * Complex.I,
      w := Real.cosh r, side := some SlitSide.lower },
    { label := "D", z := (r : ℂ) * Complex.I,
      w := (Real.sinh r : ℂ) * Complex.I, side := none },
    { label := "D̄", z := -(r : ℂ) * Complex.I,
      w := -(Real.sinh r : ℂ) * Complex.I, side := none },
    { label := "E", z := -((Real.pi : ℂ) / 2) + (r : ℂ) * Complex.I,
      w := -(Real.cosh r : ℂ), side := some SlitSide.upper },
    { label := "Ē", z := -((Real.pi : ℂ) / 2) - (r : ℂ) * Complex.I,
      w := -(Real.cosh r : ℂ), side := some SlitSide.lower },
    { label := "F", z := -((Real.pi : ℂ) / 2), w := -1, side := none } ]
-- ANCHOR_END: sineConformalTable

/-- DLMF 4.15.F7: the sine conformal-map table uses every listed point for
positive `r`. -/
-- ANCHOR: sineConformalTable_spec
theorem sineConformalTable_spec {r : ℝ} (hr : 0 < r) :
    (sineConformalTable r).length = 9
-- ANCHOR_END: sineConformalTable_spec
    := by sorry

/-- DLMF 4.15.F8: height of the sine surface. -/
-- ANCHOR: sineSurfaceHeight
theorem sineSurfaceHeight (x y : ℝ) :
    surfaceHeight Complex.sin x y = ‖Complex.sin (x + (y : ℂ) * Complex.I)‖
-- ANCHOR_END: sineSurfaceHeight
    := by sorry

/-- DLMF 4.15.F9: height of the principal arcsine surface. -/
-- ANCHOR: arcsinSurfaceHeight
theorem arcsinSurfaceHeight (x y : ℝ)
    (hcut : (x + (y : ℂ) * Complex.I) ∉ arcsinBranchCut) :
    surfaceHeight principalArcsin x y = ‖principalArcsin (x + (y : ℂ) * Complex.I)‖
-- ANCHOR_END: arcsinSurfaceHeight
    := by sorry

/-- DLMF 4.15.F10: height of the tangent surface. -/
-- ANCHOR: tanSurfaceHeight
theorem tanSurfaceHeight (x y : ℝ)
    (hdom : Complex.cos (x + (y : ℂ) * Complex.I) ≠ 0) :
    surfaceHeight Complex.tan x y = ‖Complex.tan (x + (y : ℂ) * Complex.I)‖
-- ANCHOR_END: tanSurfaceHeight
    := by sorry

/-- DLMF 4.15.F11: height of the principal arctangent surface. -/
-- ANCHOR: arctanSurfaceHeight
theorem arctanSurfaceHeight (x y : ℝ)
    (hcut : (x + (y : ℂ) * Complex.I) ∉ arctanBranchCut) :
    surfaceHeight Complex.arctan x y = ‖Complex.arctan (x + (y : ℂ) * Complex.I)‖
-- ANCHOR_END: arctanSurfaceHeight
    := by sorry

/-- DLMF 4.15.F12: height of the cosecant surface. -/
-- ANCHOR: cscSurfaceHeight
theorem cscSurfaceHeight (x y : ℝ)
    (hdom : Complex.sin (x + (y : ℂ) * Complex.I) ≠ 0) :
    surfaceHeight complexCsc x y = ‖complexCsc (x + (y : ℂ) * Complex.I)‖
-- ANCHOR_END: cscSurfaceHeight
    := by sorry

/-- DLMF 4.15.F13: height of the principal arccosecant surface. -/
-- ANCHOR: arccscSurfaceHeight
theorem arccscSurfaceHeight (x y : ℝ)
    (hdom : principalArccscDomain (x + (y : ℂ) * Complex.I)) :
    surfaceHeight principalArccsc x y = ‖principalArccsc (x + (y : ℂ) * Complex.I)‖
-- ANCHOR_END: arccscSurfaceHeight
    := by sorry

end LMLF.Blueprint.Elementary.Section415
