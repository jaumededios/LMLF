import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Inverse
import Mathlib.Analysis.SpecialFunctions.Complex.Log
import Mathlib.Analysis.RCLike.Sqrt

open Set
noncomputable section

namespace LMLF.Blueprint.Elementary.Section437

/-! DLMF §4.37.  General inverse hyperbolic values are represented by the
equations they invert; principal formulas carry explicit cut complements. -/

/-- DLMF 4.37.E1: general inverse hyperbolic sine values. -/
def arcsinhValues (z : ℂ) : Set ℂ := {w | Complex.sinh w = z}
/-- DLMF 4.37.E2: general inverse hyperbolic cosine values. -/
def arccoshValues (z : ℂ) : Set ℂ := {w | Complex.cosh w = z}
/-- DLMF 4.37.E3: general inverse hyperbolic tangent values. -/
def arctanhValues (z : ℂ) : Set ℂ := {w | Complex.tanh w = z}
/-- DLMF 4.37.E4: general inverse hyperbolic cosecant values. -/
def arccschValues (z : ℂ) : Set ℂ := {w | Complex.sinh w ≠ 0 ∧ Complex.sinh w = 1 / z}
/-- DLMF 4.37.E5: general inverse hyperbolic secant values. -/
def arcsechValues (z : ℂ) : Set ℂ := {w | Complex.cosh w ≠ 0 ∧ Complex.cosh w = 1 / z}
/-- DLMF 4.37.E6: general inverse hyperbolic cotangent values. -/
def arccothValues (z : ℂ) : Set ℂ := {w | Complex.tanh w = 1 / z}

/-- DLMF 4.37.E7: principal inverse hyperbolic cosecant. -/
def principalArccsch (z : ℂ) : ℂ := Complex.log (Complex.sqrt (1 + (1 / z) ^ 2) + 1 / z)
/-- DLMF 4.37.E8: principal inverse hyperbolic secant. -/
def principalArcsech (z : ℂ) : ℂ :=
  2 * Complex.log (Complex.sqrt ((1 / z + 1) / 2) + Complex.sqrt ((1 / z - 1) / 2))
/-- DLMF 4.37.E9: principal inverse hyperbolic cotangent. -/
def principalArccoth (z : ℂ) : ℂ := Complex.log ((z + 1) / (z - 1)) / 2

/-- DLMF 4.37.E10: odd reflection of principal arcsinh. -/
def principalArcsinh (z : ℂ) : ℂ := Complex.log (Complex.sqrt (z ^ 2 + 1) + z)
/-- DLMF 4.37.E19/E21: the signed square-root branch used by principal arccosh.

The two-square-root expression is the branch-aware form of the `±` radical in
DLMF E19; unlike `Complex.sqrt (z ^ 2 - 1)` by itself, it remains correct in
the left half-plane and on the imaginary axis. -/
def arccoshRadical (z : ℂ) : ℂ :=
  (Complex.sqrt ((z + 1) / 2) + Complex.sqrt ((z - 1) / 2)) ^ 2 - z
/-- DLMF 4.37.E11: principal arccosh reflection branch. -/
def principalArccosh (z : ℂ) : ℂ :=
  2 * Complex.log (Complex.sqrt ((z + 1) / 2) + Complex.sqrt ((z - 1) / 2))
/-- DLMF 4.37.E12: odd reflection of principal arctanh. -/
def principalArctanh (z : ℂ) : ℂ := Complex.log ((1 + z) / (1 - z)) / 2

/-- DLMF 4.37.E16: principal logarithmic arcsinh domain. -/
def arcsinhLogDomain (z : ℂ) : Prop := ¬ (z.re = 0 ∧ (z.im < -1 ∨ 1 < z.im))
/-- DLMF 4.37.E19 and E21: formula domain `ℂ \ (-∞,1)`. -/
def arccoshLogDomain (z : ℂ) : Prop := ¬ (z.im = 0 ∧ z.re < 1)
/-- DLMF 4.37.E24: principal arctanh cut complement. -/
def arctanhLogDomain (z : ℂ) : Prop := ¬ (z.im = 0 ∧ (z.re ≤ -1 ∨ 1 ≤ z.re))

/- The principal functions are single-valued in Mathlib, while DLMF records two
values on a cut.  These transparent side-indexed expressions retain both
boundary values without pretending that one totalized `Complex.log` has two
outputs. -/
inductive CutSide
  | upper
  | lower

/-- DLMF 4.37.E17/E18/E22/E23/E25: upper/lower cut sign. -/
def cutSideSign : CutSide → ℂ
  | .upper => 1
  | .lower => -1

/-- DLMF 4.37.E17: side-indexed arcsinh value on the positive imaginary cut. -/
def arcsinhPositiveCutValue (side : CutSide) (y : ℝ) : ℂ :=
  Real.pi / 2 * Complex.I + cutSideSign side *
    Complex.log (Complex.sqrt (y ^ 2 - 1) + y)
/-- DLMF 4.37.E18: side-indexed arcsinh value on the negative imaginary cut. -/
def arcsinhNegativeCutValue (side : CutSide) (y : ℝ) : ℂ :=
  -(Real.pi / 2) * Complex.I + cutSideSign side *
    Complex.log (Complex.sqrt (y ^ 2 - 1) - y)
/-- DLMF 4.37.E22: side-indexed arccosh value on `(-1,1]`. -/
def arccoshMiddleCutValue (side : CutSide) (x : ℝ) : ℂ :=
  cutSideSign side * Complex.log (Complex.I * Complex.sqrt (1 - x ^ 2) + x)
/-- DLMF 4.37.E23: side-indexed arccosh value on `(-∞,-1]`. -/
def arccoshNegativeCutValue (side : CutSide) (x : ℝ) : ℂ :=
  cutSideSign side * (Real.pi * Complex.I) +
    Complex.log (Complex.sqrt (x ^ 2 - 1) - x)
/-- DLMF 4.37.E25: side-indexed arctanh value on the real cuts. -/
def arctanhCutValue (side : CutSide) (x : ℝ) : ℂ :=
  cutSideSign side * (Real.pi * Complex.I / 2) +
    Complex.log ((x + 1) / (x - 1)) / 2

-- ANCHOR: dlmf_4_37_1
/-- DLMF 4.37.E1: general inverse hyperbolic-sine value relation. -/
theorem dlmf_4_37_1 (z w : ℂ) : w ∈ arcsinhValues z ↔ Complex.sinh w = z :=
-- ANCHOR_END: dlmf_4_37_1
by sorry
-- ANCHOR: dlmf_4_37_2
/-- DLMF 4.37.E2: general inverse hyperbolic-cosine value relation. -/
theorem dlmf_4_37_2 (z w : ℂ) : w ∈ arccoshValues z ↔ Complex.cosh w = z :=
-- ANCHOR_END: dlmf_4_37_2
by sorry
-- ANCHOR: dlmf_4_37_3
/-- DLMF 4.37.E3: general inverse hyperbolic-tangent value relation away from poles. -/
theorem dlmf_4_37_3 (z w : ℂ) (hz : z ≠ 1) (hz' : z ≠ -1) :
    w ∈ arctanhValues z ↔ Complex.tanh w = z :=
-- ANCHOR_END: dlmf_4_37_3
by sorry
-- ANCHOR: dlmf_4_37_4
/-- DLMF 4.37.E4: general inverse-cosecant value relation. -/
theorem dlmf_4_37_4 (z w : ℂ) (hz : z ≠ 0) : w ∈ arccschValues z ↔ Complex.sinh w = 1 / z :=
-- ANCHOR_END: dlmf_4_37_4
by sorry
-- ANCHOR: dlmf_4_37_5
/-- DLMF 4.37.E5: general inverse-secant value relation. -/
theorem dlmf_4_37_5 (z w : ℂ) (hz : z ≠ 0) : w ∈ arcsechValues z ↔ Complex.cosh w = 1 / z :=
-- ANCHOR_END: dlmf_4_37_5
by sorry
-- ANCHOR: dlmf_4_37_6
/-- DLMF 4.37.E6: general inverse-cotangent value relation. -/
theorem dlmf_4_37_6 (z w : ℂ) (hz : z ≠ 0) : w ∈ arccothValues z ↔ Complex.tanh w = 1 / z :=
-- ANCHOR_END: dlmf_4_37_6
by sorry

-- ANCHOR: dlmf_4_37_7
/-- DLMF 4.37.E7: principal arccsch reciprocal specialization. -/
theorem dlmf_4_37_7 (z : ℂ) (hz : z ≠ 0) : principalArccsch z = principalArcsinh (1 / z) :=
-- ANCHOR_END: dlmf_4_37_7
by sorry
-- ANCHOR: dlmf_4_37_8
/-- DLMF 4.37.E8: principal arcsech reciprocal specialization. -/
theorem dlmf_4_37_8 (z : ℂ) (hz : z ≠ 0) : principalArcsech z = principalArccosh (1 / z) :=
-- ANCHOR_END: dlmf_4_37_8
by sorry
-- ANCHOR: dlmf_4_37_9
/-- DLMF 4.37.E9: principal arccoth reciprocal specialization. -/
theorem dlmf_4_37_9 (z : ℂ) (hz0 : z ≠ 0) (hz : z ≠ 1) (hz' : z ≠ -1) : principalArccoth z = principalArctanh (1 / z) :=
-- ANCHOR_END: dlmf_4_37_9
by sorry

-- ANCHOR: dlmf_4_37_10
/-- DLMF 4.37.E10: principal arcsinh odd reflection. -/
theorem dlmf_4_37_10 (z : ℂ) (hz : arcsinhLogDomain z) :
    principalArcsinh (-z) = -principalArcsinh z :=
-- ANCHOR_END: dlmf_4_37_10
by sorry
-- ANCHOR: dlmf_4_37_11
/-- DLMF 4.37.E11: principal arccosh reflection with half-plane sign. -/
theorem dlmf_4_37_11 (z : ℂ) (hz : z.im ≠ 0) :
    principalArccosh (-z) = (if 0 < z.im then -2 * Real.pi * Complex.I else 2 * Real.pi * Complex.I) / 2 + principalArccosh z :=
-- ANCHOR_END: dlmf_4_37_11
by sorry
-- ANCHOR: dlmf_4_37_12
/-- DLMF 4.37.E12: principal arctanh odd reflection off its poles. -/
theorem dlmf_4_37_12 (z : ℂ) (hz : arctanhLogDomain z) :
    principalArctanh (-z) = -principalArctanh z :=
-- ANCHOR_END: dlmf_4_37_12
by sorry
-- ANCHOR: dlmf_4_37_13
/-- DLMF 4.37.E13: principal arccsch odd reflection. -/
theorem dlmf_4_37_13 (z : ℂ) (hz : z ≠ 0) (hcut : arcsinhLogDomain (1 / z)) :
    principalArccsch (-z) = -principalArccsch z :=
-- ANCHOR_END: dlmf_4_37_13
by sorry
-- ANCHOR: dlmf_4_37_14
/-- DLMF 4.37.E14: principal arcsech reflection with side sign. -/
theorem dlmf_4_37_14 (z : ℂ) (hz : z.im ≠ 0) :
    principalArcsech (-z) = (if 0 < z.im then 2 * Real.pi * Complex.I else -2 * Real.pi * Complex.I) / 2 + principalArcsech z :=
-- ANCHOR_END: dlmf_4_37_14
by sorry
-- ANCHOR: dlmf_4_37_15
/-- DLMF 4.37.E15: principal arccoth odd reflection off its poles. -/
theorem dlmf_4_37_15 (z : ℂ) (hz : z ≠ 0) (hz' : z ≠ 1) (hz'' : z ≠ -1)
    (hcut : arctanhLogDomain (1 / z)) : principalArccoth (-z) = -principalArccoth z :=
-- ANCHOR_END: dlmf_4_37_15
by sorry

-- ANCHOR: dlmf_4_37_16
/-- DLMF 4.37.E16: principal logarithmic arcsinh formula on its cut complement. -/
theorem dlmf_4_37_16 (z : ℂ) (hz : arcsinhLogDomain z) : principalArcsinh z = Complex.log (Complex.sqrt (z ^ 2 + 1) + z) :=
-- ANCHOR_END: dlmf_4_37_16
by sorry
-- ANCHOR: dlmf_4_37_17
/-- DLMF 4.37.E17: upper/lower-side arcsinh cut values. -/
theorem dlmf_4_37_17 (y : ℝ) (side : CutSide) (hy : 1 ≤ y) :
    Real.pi / 2 * Complex.I + cutSideSign side *
        Complex.log (Complex.sqrt (y ^ 2 - 1) + y) ∈ arcsinhValues (Complex.I * y) :=
-- ANCHOR_END: dlmf_4_37_17
by sorry
-- ANCHOR: dlmf_4_37_18
/-- DLMF 4.37.E18: upper/lower-side arcsinh cut values. -/
theorem dlmf_4_37_18 (y : ℝ) (side : CutSide) (hy : y ≤ -1) :
    -(Real.pi / 2) * Complex.I + cutSideSign side *
        Complex.log (Complex.sqrt (y ^ 2 - 1) - y) ∈ arcsinhValues (Complex.I * y) :=
-- ANCHOR_END: dlmf_4_37_18
by sorry
-- ANCHOR: dlmf_4_37_19
/-- DLMF 4.37.E19: principal logarithmic arccosh formula. -/
theorem dlmf_4_37_19 (z : ℂ) (hz : arccoshLogDomain z) :
    principalArccosh z = Complex.log (arccoshRadical z + z) :=
-- ANCHOR_END: dlmf_4_37_19
by sorry
-- ANCHOR: dlmf_4_37_20
/-- DLMF 4.37.E20: imaginary-axis arccosh values. -/
theorem dlmf_4_37_20 (y : ℝ) (hy : y ≠ 0) : principalArccosh (Complex.I * y) = (if 0 < y then 1 else -1) * (Real.pi / 2 * Complex.I) + Complex.log (Complex.sqrt (y ^ 2 + 1) + (if 0 < y then y else -y)) :=
-- ANCHOR_END: dlmf_4_37_20
by sorry
-- ANCHOR: dlmf_4_37_21
/-- DLMF 4.37.E21: equivalent two-square-root arccosh formula. -/
theorem dlmf_4_37_21 (z : ℂ) (hz : arccoshLogDomain z) : principalArccosh z = 2 * Complex.log (Complex.sqrt ((z + 1) / 2) + Complex.sqrt ((z - 1) / 2)) :=
-- ANCHOR_END: dlmf_4_37_21
by sorry
-- ANCHOR: dlmf_4_37_22
/-- DLMF 4.37.E22: upper/lower-side arccosh values on `(-1,1]`. -/
theorem dlmf_4_37_22 (x : ℝ) (side : CutSide) (hx : -1 < x) (hx' : x ≤ 1) :
    cutSideSign side * Complex.log (Complex.I * Complex.sqrt (1 - x ^ 2) + x) ∈
      arccoshValues x :=
-- ANCHOR_END: dlmf_4_37_22
by sorry
-- ANCHOR: dlmf_4_37_23
/-- DLMF 4.37.E23: upper/lower-side arccosh values on `(-∞,-1]`. -/
theorem dlmf_4_37_23 (x : ℝ) (side : CutSide) (hx : x ≤ -1) :
    cutSideSign side * (Real.pi * Complex.I) +
        Complex.log (Complex.sqrt (x ^ 2 - 1) - x) ∈ arccoshValues x :=
-- ANCHOR_END: dlmf_4_37_23
by sorry
-- ANCHOR: dlmf_4_37_24
/-- DLMF 4.37.E24: principal logarithmic arctanh formula. -/
theorem dlmf_4_37_24 (z : ℂ) (hz : arctanhLogDomain z) : principalArctanh z = Complex.log ((1 + z) / (1 - z)) / 2 :=
-- ANCHOR_END: dlmf_4_37_24
by sorry
-- ANCHOR: dlmf_4_37_25
/-- DLMF 4.37.E25: cut values of principal arctanh. -/
theorem dlmf_4_37_25 (x : ℝ) (side : CutSide) (hx : x < -1 ∨ 1 < x) :
    cutSideSign side * (Real.pi * Complex.I / 2) +
        Complex.log ((x + 1) / (x - 1)) / 2 ∈ arctanhValues x :=
-- ANCHOR_END: dlmf_4_37_25
by sorry

-- ANCHOR: dlmf_4_37_26
/-- DLMF 4.37.E26: inverse hyperbolic sine equation. -/
theorem dlmf_4_37_26 (z w : ℂ) (h : Complex.sinh w = z) : w ∈ arcsinhValues z :=
-- ANCHOR_END: dlmf_4_37_26
by sorry
-- ANCHOR: dlmf_4_37_27
/-- DLMF 4.37.E27: inverse hyperbolic cosine equation. -/
theorem dlmf_4_37_27 (z w : ℂ) (h : Complex.cosh w = z) : w ∈ arccoshValues z :=
-- ANCHOR_END: dlmf_4_37_27
by sorry
-- ANCHOR: dlmf_4_37_28
/-- DLMF 4.37.E28: inverse hyperbolic tangent equation off poles. -/
theorem dlmf_4_37_28 (z w : ℂ) (hz : z ≠ 1) (hz' : z ≠ -1) (h : Complex.tanh w = z) : w ∈ arctanhValues z :=
-- ANCHOR_END: dlmf_4_37_28
by sorry
-- ANCHOR: dlmf_4_37_29
/-- DLMF 4.37.E29: general arcsinh family with integer period. -/
theorem dlmf_4_37_29 (z w : ℂ) :
    w ∈ arcsinhValues z ↔
      ∃ k : ℤ, w = (-1 : ℂ) ^ k * principalArcsinh z + k * (Real.pi * Complex.I) :=
-- ANCHOR_END: dlmf_4_37_29
by sorry
-- ANCHOR: dlmf_4_37_30
/-- DLMF 4.37.E30: general arccosh family with sign and integer period. -/
theorem dlmf_4_37_30 (z w : ℂ) :
    w ∈ arccoshValues z ↔
      ∃ (k : ℤ) (ε : ℂ), (ε = 1 ∨ ε = -1) ∧
        w = ε * principalArccosh z + 2 * k * (Real.pi * Complex.I) :=
-- ANCHOR_END: dlmf_4_37_30
by sorry
-- ANCHOR: dlmf_4_37_31
/-- DLMF 4.37.E31: general arctanh family with integer period off poles. -/
theorem dlmf_4_37_31 (z w : ℂ) (hz : z ≠ 1) (hz' : z ≠ -1) :
    w ∈ arctanhValues z ↔
      ∃ k : ℤ, w = principalArctanh z + k * (Real.pi * Complex.I) :=
-- ANCHOR_END: dlmf_4_37_31
by sorry

end LMLF.Blueprint.Elementary.Section437
