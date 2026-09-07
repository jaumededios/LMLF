import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Inverse
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Arctan
import Mathlib.Analysis.RCLike.Sqrt
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic

open scoped Interval
open scoped Topology
open Filter
open MeasureTheory
noncomputable section
namespace LMLF.Blueprint.Elementary.Section423

/-- DLMF 4.23.E19: principal arcsine on the slit plane. -/
def principalArcsin (z : ℂ) : ℂ := -Complex.I * Complex.log (Complex.sqrt (1 - z ^ 2) + Complex.I * z)
/-- DLMF 4.23.E22: principal arccosine on the slit plane. -/
def principalArccos (z : ℂ) : ℂ := Real.pi / 2 + Complex.I * Complex.log (Complex.sqrt (1 - z ^ 2) + Complex.I * z)
/-- DLMF 4.23.E26: principal arctangent on its slit plane. -/
def principalArctan (z : ℂ) : ℂ := Complex.I / 2 * Complex.log ((Complex.I + z) / (Complex.I - z))
/-- DLMF 4.23.E7: principal arccosecant by reciprocal specialization. -/
def principalArccsc (z : ℂ) : ℂ := principalArcsin (1 / z)
/-- DLMF 4.23.E8: principal arcsecant by reciprocal specialization. -/
def principalArcsec (z : ℂ) : ℂ := principalArccos (1 / z)
/-- DLMF 4.23.E9: principal arccotangent by reciprocal specialization. -/
def principalArccot (z : ℂ) : ℂ := principalArctan (1 / z)
/-- DLMF 4.23(ii): complement of the real branch cuts. -/
def principalArcsinDomain (z : ℂ) : Prop := ¬ (z.im = 0 ∧ (1 < z.re ∨ z.re < -1))
/-- DLMF 4.23(iii): complement of the arctangent branch cuts. -/
def principalArctanDomain (z : ℂ) : Prop := ¬ ((z / Complex.I).im = 0 ∧ ((z / Complex.I).re ≤ -1 ∨ 1 ≤ (z / Complex.I).re))
/-- DLMF 4.23.E28: general arcsine value relation. -/
def generalArcsinValue (z w : ℂ) : Prop := Complex.sin w = z
/-- DLMF 4.23.E29: general arccosine value relation. -/
def generalArccosValue (z w : ℂ) : Prop := Complex.cos w = z
/-- DLMF 4.23.E30: general arctangent value relation. -/
def generalArctanValue (z w : ℂ) : Prop := Complex.tan w = z
/-- DLMF 4.23.E4: general arccosecant value relation. -/
def generalArccscValue (z w : ℂ) : Prop := Complex.sin w = 1 / z
/-- DLMF 4.23.E5: general arcsecant value relation. -/
def generalArcsecValue (z w : ℂ) : Prop := Complex.cos w = 1 / z
/-- DLMF 4.23.E6: general arccotangent value relation. -/
def generalArccotValue (z w : ℂ) : Prop := Complex.tan w = 1 / z
/-! DLMF 4.23.E1--E6: function-specific continuation paths.  The endpoints,
forbidden points, continued radicand, and path integral are parameters rather
than being silently shared by unrelated inverse functions. -/
/-- DLMF 4.23.E1--E6: a square-root continuation from the real reference
    interval `(-1,1)` to the initial point of a defining path. -/
-- ANCHOR: SqrtContinuation
structure SqrtContinuation (a : ℂ) where
  referencePoint : ℝ
  referenceInterior : -1 < referencePoint ∧ referencePoint < 1
  curve : ℝ → ℂ
  start : curve 0 = (referencePoint : ℂ)
  finish : curve 1 = a
  continuous : Continuous curve
  tangent : ℝ → ℂ
  hasDeriv : ∀ t ∈ Set.Icc (0 : ℝ) 1,
    HasDerivWithinAt curve (tangent t) (Set.Icc 0 1) t
  tangentContinuous : ContinuousOn tangent (Set.Icc (0 : ℝ) 1)
  avoids : ∀ t, 0 < t → t < 1 → curve t ≠ 1 ∧ curve t ≠ -1
  squareRootBranch : ℝ → ℂ
  branchContinuous : Continuous squareRootBranch
  principalAtReference : squareRootBranch 0 =
    Complex.sqrt (1 - (referencePoint : ℂ) ^ 2)
  branchEquation : ∀ t, squareRootBranch t ^ 2 = 1 - (curve t) ^ 2
-- ANCHOR_END: SqrtContinuation

/-- DLMF 4.23.E1--E6: a path carrying the continued square-root branch from
    its DLMF-normalized continuation to the path's endpoint. -/
-- ANCHOR: SqrtPath
structure SqrtPath (a b : ℂ) where
  curve : ℝ → ℂ
  start : curve 0 = a
  finish : curve 1 = b
  continuous : Continuous curve
  tangent : ℝ → ℂ
  hasDeriv : ∀ t ∈ Set.Icc (0 : ℝ) 1,
    HasDerivWithinAt curve (tangent t) (Set.Icc 0 1) t
  tangentContinuous : ContinuousOn tangent (Set.Icc (0 : ℝ) 1)
  avoids : ∀ t, 0 < t → t < 1 → curve t ≠ 1 ∧ curve t ≠ -1
  squareRootBranch : ℝ → ℂ
  branchContinuous : Continuous squareRootBranch
  branchEquation : ∀ t, squareRootBranch t ^ 2 = 1 - (curve t) ^ 2
  continuation : SqrtContinuation a
  branchAtContinuation : squareRootBranch 0 = continuation.squareRootBranch 1
  integrable : IntervalIntegrable
    (fun t => tangent t / squareRootBranch t) volume 0 1
-- ANCHOR_END: SqrtPath

/-- DLMF 4.23.E1--E2/E4--E5: integral carried by a continued square-root path. -/
-- ANCHOR: SqrtPath.integral
def SqrtPath.integral (P : SqrtPath a b) : ℂ :=
  ∫ t in (0 : ℝ)..1, P.tangent t / P.squareRootBranch t
-- ANCHOR_END: SqrtPath.integral

/-- DLMF 4.23.E3/E6: a rational continuation path avoiding the poles `±i`. -/
-- ANCHOR: RationalPath
structure RationalPath (a b : ℂ) where
  curve : ℝ → ℂ
  start : curve 0 = a
  finish : curve 1 = b
  continuous : Continuous curve
  tangent : ℝ → ℂ
  hasDeriv : ∀ t ∈ Set.Icc (0 : ℝ) 1,
    HasDerivWithinAt curve (tangent t) (Set.Icc 0 1) t
  tangentContinuous : ContinuousOn tangent (Set.Icc (0 : ℝ) 1)
  avoids : ∀ t, 0 < t → t < 1 → curve t ≠ Complex.I ∧ curve t ≠ -Complex.I
  integrable : IntervalIntegrable
    (fun t => tangent t / (1 + curve t ^ 2)) volume 0 1
-- ANCHOR_END: RationalPath

/-- DLMF 4.23.E3/E6: integral carried by a rational continuation path. -/
-- ANCHOR: RationalPath.integral
def RationalPath.integral (P : RationalPath a b) : ℂ :=
  ∫ t in (0 : ℝ)..1, P.tangent t / (1 + P.curve t ^ 2)
-- ANCHOR_END: RationalPath.integral

/-- DLMF 4.23.E1: arcsine path value with its continued-branch integral. -/
def arcsinPathValue (z w : ℂ) : Prop :=
  ∃ P : SqrtPath 0 z, w = P.integral ∧ Complex.sin w = z
/-- DLMF 4.23.E2: arccosine path value with its continued-branch integral. -/
def arccosPathValue (z w : ℂ) : Prop :=
  ∃ P : SqrtPath z 1, w = P.integral ∧ Complex.cos w = z
/-- DLMF 4.23.E3: arctangent path value with its path integral. -/
def arctanPathValue (z w : ℂ) : Prop :=
  ∃ P : RationalPath 0 z, w = P.integral ∧ Complex.tan w = z
/-- DLMF 4.23.E4: arccosecant path value with its continued-branch integral. -/
def arccscPathValue (z w : ℂ) : Prop :=
  ∃ P : SqrtPath 0 (1 / z), w = P.integral ∧ Complex.sin w = 1 / z
/-- DLMF 4.23.E5: arcsecant path value with its continued-branch integral. -/
def arcsecPathValue (z w : ℂ) : Prop :=
  ∃ P : SqrtPath (1 / z) 1, w = P.integral ∧ Complex.cos w = 1 / z
/-- DLMF 4.23.E6: arccotangent path value with its path integral. -/
def arccotPathValue (z w : ℂ) : Prop :=
  ∃ P : RationalPath 0 (1 / z), w = P.integral ∧ Complex.tan w = 1 / z
/-- DLMF 4.23.E40/E42: real hyperbolic cotangent auxiliary. -/
def realCoth (x : ℝ) : ℝ := Real.cosh x / Real.sinh x
/-- DLMF 4.23.E40: real hyperbolic secant auxiliary. -/
def realSech (x : ℝ) : ℝ := 1 / Real.cosh x
/-- DLMF 4.23.E40: real hyperbolic cosecant auxiliary. -/
def realCsch (x : ℝ) : ℝ := 1 / Real.sinh x
/-- DLMF 4.23.E42: principal inverse hyperbolic sine. -/
def principalArcsinh (z : ℂ) : ℂ :=
  Complex.log (Complex.sqrt (z ^ 2 + 1) + z)
/-- DLMF 4.23.E42: principal inverse hyperbolic cosecant. -/
def principalArccsch (z : ℂ) : ℂ := principalArcsinh (1 / z)
/-- DLMF 4.23.E42: principal inverse hyperbolic cosine. -/
def principalArccosh (z : ℂ) : ℂ :=
  2 * Complex.log (Complex.sqrt ((z + 1) / 2) + Complex.sqrt ((z - 1) / 2))
/-- DLMF 4.23.E42: principal inverse hyperbolic secant. -/
def principalArcsech (z : ℂ) : ℂ := principalArccosh (1 / z)
/-- DLMF 4.23.E42: principal inverse hyperbolic tangent. -/
def principalArctanh (z : ℂ) : ℂ :=
  Complex.log ((1 + z) / (1 - z)) / 2
/-- DLMF 4.23.E42: principal inverse hyperbolic cotangent. -/
def principalArccoth (z : ℂ) : ℂ := principalArctanh (1 / z)
/-- DLMF 4.23.E42: real secant auxiliary. -/
def realSec (x : ℝ) : ℝ := 1 / Real.cos x
/-- DLMF 4.23.E42: real cotangent auxiliary. -/
def realCot (x : ℝ) : ℝ := Real.cos x / Real.sin x
/-- DLMF 4.23.E42: real cosecant auxiliary. -/
def realCsc (x : ℝ) : ℝ := 1 / Real.sin x
/-- DLMF 4.23(ii): open real rays removed from the principal cut plane. -/
def openRealRay (z : ℂ) : Prop := z.im = 0 ∧ (1 < z.re ∨ z.re < -1)
/-- DLMF 4.23(iii): arctangent cut predicate. -/
def arctanCut (z : ℂ) : Prop := (z / Complex.I).im = 0 ∧
  ((z / Complex.I).re ≤ -1 ∨ 1 ≤ (z / Complex.I).re)
/-- DLMF 4.23.E20--E27: admissible boundary side. -/
def boundarySign (s : ℝ) : Prop := s = 1 ∨ s = -1
/-- DLMF 4.23.E20--E25: side-indexed boundary limit on a real cut. -/
def boundaryLimit (f : ℂ → ℂ) (x s : ℝ) (w : ℂ) : Prop :=
  boundarySign s ∧ ∃ γ : ℝ → ℂ,
    Tendsto γ atTop (𝓝 (x : ℂ)) ∧
    (∀ᶠ t in atTop, 0 < s * (γ t).im) ∧
    Tendsto (fun t => f (γ t)) atTop (𝓝 w)
/-- DLMF 4.23.E27: side-indexed boundary limit on the imaginary cut. -/
def imaginaryCutBoundaryLimit (f : ℂ → ℂ) (y s : ℝ) (w : ℂ) : Prop :=
  boundarySign s ∧ ∃ γ : ℝ → ℂ,
    Tendsto γ atTop (𝓝 (Complex.I * y)) ∧
    (∀ᶠ t in atTop, 0 < s * (γ t).re) ∧
    Tendsto (fun t => f (γ t)) atTop (𝓝 w)
/-- DLMF 4.23.E20: positive real-cut arcsine boundary value. -/
def arcsinBoundaryValue (x s : ℝ) : ℂ := Real.pi / 2 + s * Complex.I * Complex.log (Real.sqrt (x ^ 2 - 1) + x)
/-- DLMF 4.23.E21: negative real-cut arcsine boundary value. -/
def arcsinNegativeBoundaryValue (x s : ℝ) : ℂ := -Real.pi / 2 + s * Complex.I * Complex.log (Real.sqrt (x ^ 2 - 1) - x)
/-- DLMF 4.23.E24: positive real-cut arccosine boundary value. -/
def arccosBoundaryValue (x s : ℝ) : ℂ := s * Complex.I * Complex.log (Real.sqrt (x ^ 2 - 1) + x)
/-- DLMF 4.23.E25: negative real-cut arccosine boundary value. -/
def arccosNegativeBoundaryValue (x s : ℝ) : ℂ := Real.pi + s * Complex.I * Complex.log (Real.sqrt (x ^ 2 - 1) - x)
/-- DLMF 4.23.E27: imaginary-cut arctangent boundary value. -/
def arctanImaginaryBoundaryValue (y s : ℝ) : ℂ := s * Real.pi / 2 + Complex.I / 2 * Complex.log ((y + 1) / (y - 1))
/-- DLMF 4.23.E34--E38: elliptic coordinate alpha. -/
def alpha (x y : ℝ) : ℝ := (Real.sqrt ((x + 1) ^ 2 + y ^ 2) + Real.sqrt ((x - 1) ^ 2 + y ^ 2)) / 2
/-- DLMF 4.23.E34--E38: elliptic coordinate beta. -/
def beta (x y : ℝ) : ℝ := (Real.sqrt ((x + 1) ^ 2 + y ^ 2) - Real.sqrt ((x - 1) ^ 2 + y ^ 2)) / 2
/-- DLMF 4.23.E39: Gudermannian interval integral. -/
def gudermannian (x : ℝ) : ℝ := ∫ t in (0 : ℝ)..x, 1 / Real.cosh t
/-- DLMF 4.23.E41: inverse Gudermannian interval integral. -/
def inverseGudermannian (x : ℝ) : ℝ := ∫ t in (0 : ℝ)..x, 1 / Real.cos t

/-- DLMF 4.23.T1: special-value table vocabulary. -/
inductive TableValue where
  | dash
  | value (x : ℝ)
  | oneSided (upper lower : ℝ)

/-- DLMF 4.23.T1: table header. -/
def tableHeader : List String := ["x", "arcsin x", "arccos x", "arctan x", "arccsc x", "arcsec x", "arccot x"]

/-- DLMF 4.23.F1: figure caption. -/
def figureCaption : String := "z-plane. Branch cuts for the inverse trigonometric functions."
/-- DLMF 4.23.F1: figure panel labels. -/
def figurePanelLabels : List String :=
  ["(i) arcsin/arccos", "(ii) arctan", "(iii) arccsc/arcsec", "(iv) arccot"]
/-- DLMF 4.23.T1: negative-infinity row. -/
def tableRowNegInf : List (TableValue) :=
  [.dash, .dash, .value (-Real.pi / 2), .value 0, .value (Real.pi / 2), .value 0]
/-- DLMF 4.23.T1: negative-one row. -/
def tableRowNegOne : List (TableValue) :=
  [.value (-Real.pi / 2), .value Real.pi, .value (-Real.pi / 4), .value (-Real.pi / 2),
    .value Real.pi, .value (-Real.pi / 4)]
/-- DLMF 4.23.T1: zero row, including one-sided arccotangent. -/
def tableRowZero : List (TableValue) :=
  [.value 0, .value (Real.pi / 2), .value 0, .oneSided (Real.pi / 2) (-Real.pi / 2), .dash, .dash]
/-- DLMF 4.23.T1: positive-one row. -/
def tableRowOne : List (TableValue) :=
  [.value (Real.pi / 2), .value 0, .value (Real.pi / 4), .value (Real.pi / 2), .value 0, .value (Real.pi / 4)]
/-- DLMF 4.23.T1: positive-infinity row. -/
def tableRowPosInf : List (TableValue) :=
  [.dash, .dash, .value (Real.pi / 2), .value 0, .value (Real.pi / 2), .value 0]

/-- Figure 4.23.1 caption and panel labels. -/
-- ANCHOR: dlmf_4_23_F1_t1_r1
theorem dlmf_4_23_F1_t1_r1 : figureCaption = "z-plane. Branch cuts for the inverse trigonometric functions."
-- ANCHOR_END: dlmf_4_23_F1_t1_r1
:= by sorry
-- ANCHOR: dlmf_4_23_F1_t1_r2
theorem dlmf_4_23_F1_t1_r2 : figurePanelLabels = ["(i) arcsin/arccos", "(ii) arctan", "(iii) arccsc/arcsec", "(iv) arccot"]
-- ANCHOR_END: dlmf_4_23_F1_t1_r2
:= by sorry
-- ANCHOR: dlmf_4_23_T1_caption
theorem dlmf_4_23_T1_caption : tableHeader.length = 7 ∧ tableRowNegInf.length = 6 ∧ tableRowPosInf.length = 6
-- ANCHOR_END: dlmf_4_23_T1_caption
:= by sorry
-- ANCHOR: dlmf_4_23_T1_t1_r1
theorem dlmf_4_23_T1_t1_r1 : tableHeader = ["x", "arcsin x", "arccos x", "arctan x", "arccsc x", "arcsec x", "arccot x"]
-- ANCHOR_END: dlmf_4_23_T1_t1_r1
:= by sorry
-- ANCHOR: dlmf_4_23_T1_t1_r2
theorem dlmf_4_23_T1_t1_r2 : tableRowNegInf = [.dash, .dash, .value (-Real.pi / 2), .value 0, .value (Real.pi / 2), .value 0]
-- ANCHOR_END: dlmf_4_23_T1_t1_r2
:= by sorry
-- ANCHOR: dlmf_4_23_T1_t1_r3
theorem dlmf_4_23_T1_t1_r3 : tableRowNegOne = [.value (-Real.pi / 2), .value Real.pi, .value (-Real.pi / 4), .value (-Real.pi / 2), .value Real.pi, .value (-Real.pi / 4)]
-- ANCHOR_END: dlmf_4_23_T1_t1_r3
:= by sorry
-- ANCHOR: dlmf_4_23_T1_t1_r4
theorem dlmf_4_23_T1_t1_r4 : tableRowZero = [.value 0, .value (Real.pi / 2), .value 0, .oneSided (Real.pi / 2) (-Real.pi / 2), .dash, .dash]
-- ANCHOR_END: dlmf_4_23_T1_t1_r4
:= by sorry
-- ANCHOR: dlmf_4_23_T1_t1_r5
theorem dlmf_4_23_T1_t1_r5 : tableRowOne = [.value (Real.pi / 2), .value 0, .value (Real.pi / 4), .value (Real.pi / 2), .value 0, .value (Real.pi / 4)]
-- ANCHOR_END: dlmf_4_23_T1_t1_r5
:= by sorry
-- ANCHOR: dlmf_4_23_T1_t1_r6
theorem dlmf_4_23_T1_t1_r6 : tableRowPosInf = [.dash, .dash, .value (Real.pi / 2), .value 0, .value (Real.pi / 2), .value 0]
-- ANCHOR_END: dlmf_4_23_T1_t1_r6
:= by sorry

/-- DLMF 4.23.E1. -/
-- ANCHOR: dlmf_4_23_1
theorem dlmf_4_23_1 (z : ℂ) :
    ∃ P : SqrtPath 0 z, Complex.sin P.integral = z
-- ANCHOR_END: dlmf_4_23_1
:= by sorry

/-- DLMF 4.23.E2. -/
-- ANCHOR: dlmf_4_23_2
theorem dlmf_4_23_2 (z : ℂ) :
    ∃ P : SqrtPath z 1, Complex.cos P.integral = z
-- ANCHOR_END: dlmf_4_23_2
:= by sorry

/-- DLMF 4.23.E3. -/
-- ANCHOR: dlmf_4_23_3
theorem dlmf_4_23_3 (z : ℂ) (hz : z ≠ Complex.I) (hz' : z ≠ -Complex.I) :
    ∃ P : RationalPath 0 z, Complex.tan P.integral = z
-- ANCHOR_END: dlmf_4_23_3
:= by sorry

/-- DLMF 4.23.E4. -/
-- ANCHOR: dlmf_4_23_4
theorem dlmf_4_23_4 (z w : ℂ) (hz : z ≠ 0) :
    generalArccscValue z w ↔ generalArcsinValue (1 / z) w
-- ANCHOR_END: dlmf_4_23_4
:= by sorry

/-- DLMF 4.23.E5. -/
-- ANCHOR: dlmf_4_23_5
theorem dlmf_4_23_5 (z w : ℂ) (hz : z ≠ 0) :
    generalArcsecValue z w ↔ generalArccosValue (1 / z) w
-- ANCHOR_END: dlmf_4_23_5
:= by sorry

/-- DLMF 4.23.E6. -/
-- ANCHOR: dlmf_4_23_6
theorem dlmf_4_23_6 (z w : ℂ) (hz : z ≠ 0) (hi : z ≠ Complex.I) (hi' : z ≠ -Complex.I) :
    generalArccotValue z w ↔ generalArctanValue (1 / z) w
-- ANCHOR_END: dlmf_4_23_6
:= by sorry

/-- DLMF 4.23.E7. -/
-- ANCHOR: dlmf_4_23_7
theorem dlmf_4_23_7 (z : ℂ) (hz : z ≠ 0) : principalArccsc z = principalArcsin (1 / z)
-- ANCHOR_END: dlmf_4_23_7
:= by sorry

/-- DLMF 4.23.E8. -/
-- ANCHOR: dlmf_4_23_8
theorem dlmf_4_23_8 (z : ℂ) (hz : z ≠ 0) : principalArcsec z = principalArccos (1 / z)
-- ANCHOR_END: dlmf_4_23_8
:= by sorry

/-- DLMF 4.23.E9. -/
-- ANCHOR: dlmf_4_23_9
theorem dlmf_4_23_9 (z : ℂ) (hz : z ≠ Complex.I) (hz' : z ≠ -Complex.I) : principalArccot z = principalArctan (1 / z)
-- ANCHOR_END: dlmf_4_23_9
:= by sorry

/-- DLMF 4.23.E10. -/
-- ANCHOR: dlmf_4_23_10
theorem dlmf_4_23_10 (z : ℂ) (hz : principalArcsinDomain z) : principalArcsin (-z) = -principalArcsin z
-- ANCHOR_END: dlmf_4_23_10
:= by sorry

/-- DLMF 4.23.E11. -/
-- ANCHOR: dlmf_4_23_11
theorem dlmf_4_23_11 (z : ℂ) (hz : principalArcsinDomain z) : principalArccos (-z) = Real.pi - principalArccos z
-- ANCHOR_END: dlmf_4_23_11
:= by sorry

/-- DLMF 4.23.E12. -/
-- ANCHOR: dlmf_4_23_12
theorem dlmf_4_23_12 (z : ℂ) (hz : principalArctanDomain z) (hz' : principalArctanDomain (-z)) : principalArctan (-z) = -principalArctan z
-- ANCHOR_END: dlmf_4_23_12
:= by sorry

/-- DLMF 4.23.E13. -/
-- ANCHOR: dlmf_4_23_13
theorem dlmf_4_23_13 (z : ℂ) (hz : z ≠ 0) (hc : principalArcsinDomain (1 / z)) (hc' : principalArcsinDomain (-1 / z)) : principalArccsc (-z) = -principalArccsc z
-- ANCHOR_END: dlmf_4_23_13
:= by sorry

/-- DLMF 4.23.E14. -/
-- ANCHOR: dlmf_4_23_14
theorem dlmf_4_23_14 (z : ℂ) (hz : z ≠ 0) (hc : principalArcsinDomain (1 / z)) (hc' : principalArcsinDomain (-1 / z)) : principalArcsec (-z) = Real.pi - principalArcsec z
-- ANCHOR_END: dlmf_4_23_14
:= by sorry

/-- DLMF 4.23.E15. -/
-- ANCHOR: dlmf_4_23_15
theorem dlmf_4_23_15 (z : ℂ) (hz : z ≠ 0) (hc : principalArctanDomain (1 / z)) (hc' : principalArctanDomain (-1 / z)) : principalArccot (-z) = -principalArccot z
-- ANCHOR_END: dlmf_4_23_15
:= by sorry

/-- DLMF 4.23.E16. -/
-- ANCHOR: dlmf_4_23_16
theorem dlmf_4_23_16 (z : ℂ) (hz : principalArcsinDomain z) : principalArccos z = Real.pi / 2 - principalArcsin z
-- ANCHOR_END: dlmf_4_23_16
:= by sorry

/-- DLMF 4.23.E17. -/
-- ANCHOR: dlmf_4_23_17
theorem dlmf_4_23_17 (z : ℂ) (hz : z ≠ 0) (hd : principalArcsinDomain (1 / z)) : principalArcsec z = Real.pi / 2 - principalArccsc z
-- ANCHOR_END: dlmf_4_23_17
:= by sorry

/-- DLMF 4.23.E18. -/
-- ANCHOR: dlmf_4_23_18
theorem dlmf_4_23_18 {z : ℂ} (hz : z.re ≠ 0) (he : z ≠ Complex.I) (he' : z ≠ -Complex.I) : (0 < z.re → principalArccot z = Real.pi / 2 - principalArctan z) ∧ (z.re < 0 → principalArccot z = -Real.pi / 2 - principalArctan z)
-- ANCHOR_END: dlmf_4_23_18
:= by sorry

/-- DLMF 4.23.E19. -/
-- ANCHOR: dlmf_4_23_19
theorem dlmf_4_23_19 {z : ℂ} (hcut : principalArcsinDomain z) : principalArcsin z = -Complex.I * Complex.log (Complex.sqrt (1 - z ^ 2) + Complex.I * z)
-- ANCHOR_END: dlmf_4_23_19
:= by sorry

/-- DLMF 4.23.E20. -/
-- ANCHOR: dlmf_4_23_20
theorem dlmf_4_23_20 {x s : ℝ} (hx : 1 ≤ x) (hs : boundarySign s) : boundaryLimit principalArcsin x s (Real.pi / 2 + s * Complex.I * Complex.log (Real.sqrt (x ^ 2 - 1) + x))
-- ANCHOR_END: dlmf_4_23_20
:= by sorry

/-- DLMF 4.23.E21. -/
-- ANCHOR: dlmf_4_23_21
theorem dlmf_4_23_21 {x s : ℝ} (hx : x ≤ -1) (hs : boundarySign s) : boundaryLimit principalArcsin x s (-Real.pi / 2 + s * Complex.I * Complex.log (Real.sqrt (x ^ 2 - 1) - x))
-- ANCHOR_END: dlmf_4_23_21
:= by sorry

/-- DLMF 4.23.E22. -/
-- ANCHOR: dlmf_4_23_22
theorem dlmf_4_23_22 {z : ℂ} (hcut : principalArcsinDomain z) : principalArccos z = Real.pi / 2 + Complex.I * Complex.log (Complex.sqrt (1 - z ^ 2) + Complex.I * z)
-- ANCHOR_END: dlmf_4_23_22
:= by sorry

/-- DLMF 4.23.E23. -/
-- ANCHOR: dlmf_4_23_23
theorem dlmf_4_23_23 {z : ℂ} (hcut : principalArcsinDomain z) :
    principalArccos z = -2 * Complex.I * Complex.log
      (Complex.sqrt ((1 + z) / 2) + Complex.I * Complex.sqrt ((1 - z) / 2))
-- ANCHOR_END: dlmf_4_23_23
:= by sorry

/-- DLMF 4.23.E24. -/
-- ANCHOR: dlmf_4_23_24
theorem dlmf_4_23_24 {x s : ℝ} (hx : 1 ≤ x) (hs : boundarySign s) : boundaryLimit principalArccos x s (s * Complex.I * Complex.log (Real.sqrt (x ^ 2 - 1) + x))
-- ANCHOR_END: dlmf_4_23_24
:= by sorry

/-- DLMF 4.23.E25. -/
-- ANCHOR: dlmf_4_23_25
theorem dlmf_4_23_25 {x s : ℝ} (hx : x ≤ -1) (hs : boundarySign s) : boundaryLimit principalArccos x s (Real.pi + s * Complex.I * Complex.log (Real.sqrt (x ^ 2 - 1) - x))
-- ANCHOR_END: dlmf_4_23_25
:= by sorry

/-- DLMF 4.23.E26. -/
-- ANCHOR: dlmf_4_23_26
theorem dlmf_4_23_26 {z : ℂ} (hcut : principalArctanDomain z) : principalArctan z = Complex.I / 2 * Complex.log ((Complex.I + z) / (Complex.I - z))
-- ANCHOR_END: dlmf_4_23_26
:= by sorry

/-- DLMF 4.23.E27. -/
-- ANCHOR: dlmf_4_23_27
theorem dlmf_4_23_27 {y s : ℝ} (hy : y < -1 ∨ 1 < y) (hs : boundarySign s) : imaginaryCutBoundaryLimit principalArctan y s (s * Real.pi / 2 + Complex.I / 2 * Complex.log ((y + 1) / (y - 1)))
-- ANCHOR_END: dlmf_4_23_27
:= by sorry

/-- DLMF 4.23.E28. -/
-- ANCHOR: dlmf_4_23_28
theorem dlmf_4_23_28 {z w : ℂ} : w ∈ {u : ℂ | Complex.sin u = z} ↔ generalArcsinValue z w
-- ANCHOR_END: dlmf_4_23_28
:= by sorry

/-- DLMF 4.23.E29. -/
-- ANCHOR: dlmf_4_23_29
theorem dlmf_4_23_29 {z w : ℂ} : w ∈ {u : ℂ | Complex.cos u = z} ↔ generalArccosValue z w
-- ANCHOR_END: dlmf_4_23_29
:= by sorry

/-- DLMF 4.23.E30. -/
-- ANCHOR: dlmf_4_23_30
theorem dlmf_4_23_30 {z w : ℂ} : w ∈ {u : ℂ | Complex.tan u = z} ↔ generalArctanValue z w
-- ANCHOR_END: dlmf_4_23_30
:= by sorry

/-- DLMF 4.23.E31. -/
-- ANCHOR: dlmf_4_23_31
theorem dlmf_4_23_31 {z w : ℂ} (h : generalArcsinValue z w) : ∃ k : ℤ, w = (-1 : ℂ) ^ k * principalArcsin z + k * Real.pi
-- ANCHOR_END: dlmf_4_23_31
:= by sorry

/-- DLMF 4.23.E32. -/
-- ANCHOR: dlmf_4_23_32
theorem dlmf_4_23_32 {z w : ℂ} (h : generalArccosValue z w) : ∃ k : ℤ, ∃ ε : ℤ, (ε = 1 ∨ ε = -1) ∧ w = (if ε = 1 then (1 : ℂ) else -1) * principalArccos z + 2 * k * Real.pi
-- ANCHOR_END: dlmf_4_23_32
:= by sorry

/-- DLMF 4.23.E33. -/
-- ANCHOR: dlmf_4_23_33
theorem dlmf_4_23_33 {z w : ℂ} (hz : z ≠ Complex.I) (hz' : z ≠ -Complex.I) (h : generalArctanValue z w) : ∃ k : ℤ, w = principalArctan z + k * Real.pi
-- ANCHOR_END: dlmf_4_23_33
:= by sorry

/-- DLMF 4.23.E34. -/
-- ANCHOR: dlmf_4_23_34
theorem dlmf_4_23_34 {x y : ℝ} (hcut : ¬ openRealRay (x + Complex.I * y)) : principalArcsin (x + Complex.I * y) = Real.arcsin (beta x y) + Complex.I * (if 0 < y then (1 : ℝ) else if y < 0 then -1 else 0) * Real.log (alpha x y + Real.sqrt (alpha x y ^ 2 - 1))
-- ANCHOR_END: dlmf_4_23_34
:= by sorry

/-- DLMF 4.23.E35. -/
-- ANCHOR: dlmf_4_23_35
theorem dlmf_4_23_35 {x y : ℝ} (hcut : ¬ openRealRay (x + Complex.I * y)) : principalArccos (x + Complex.I * y) = Real.arccos (beta x y) - Complex.I * (if 0 < y then (1 : ℝ) else if y < 0 then -1 else 0) * Real.log (alpha x y + Real.sqrt (alpha x y ^ 2 - 1))
-- ANCHOR_END: dlmf_4_23_35
:= by sorry

/-- DLMF 4.23.E36. -/
-- ANCHOR: dlmf_4_23_36
theorem dlmf_4_23_36 {x y : ℝ} (h : x ^ 2 + y ^ 2 < 1) : principalArctan (x + Complex.I * y) = (1 / 2 : ℝ) * Real.arctan (2 * x / (1 - x ^ 2 - y ^ 2)) + Complex.I * (1 / 4 : ℝ) * Real.log ((x ^ 2 + (y + 1) ^ 2) / (x ^ 2 + (y - 1) ^ 2))
-- ANCHOR_END: dlmf_4_23_36
:= by sorry

/-- DLMF 4.23.E37. -/
-- ANCHOR: dlmf_4_23_37
theorem dlmf_4_23_37 (x y : ℝ) : alpha x y = (Real.sqrt ((x + 1) ^ 2 + y ^ 2) + Real.sqrt ((x - 1) ^ 2 + y ^ 2)) / 2
-- ANCHOR_END: dlmf_4_23_37
:= by sorry

/-- DLMF 4.23.E38. -/
-- ANCHOR: dlmf_4_23_38
theorem dlmf_4_23_38 (x y : ℝ) : beta x y = (Real.sqrt ((x + 1) ^ 2 + y ^ 2) - Real.sqrt ((x - 1) ^ 2 + y ^ 2)) / 2
-- ANCHOR_END: dlmf_4_23_38
:= by sorry

/-- DLMF 4.23.E39. -/
-- ANCHOR: dlmf_4_23_39
theorem dlmf_4_23_39 (x : ℝ) : gudermannian x = ∫ t in (0 : ℝ)..x, 1 / Real.cosh t
-- ANCHOR_END: dlmf_4_23_39
:= by sorry

/-- DLMF 4.23.E40. -/
-- ANCHOR: dlmf_4_23_40
theorem dlmf_4_23_40 {x : ℝ} (hx : x ≠ 0) :
    (gudermannian x : ℂ) = ((2 * Real.arctan (Real.exp x) - Real.pi / 2 : ℝ) : ℂ) ∧
      (gudermannian x : ℂ) = principalArcsin (Real.tanh x) ∧
      (gudermannian x : ℂ) = principalArccsc (realCoth x) ∧
      (gudermannian x : ℂ) = principalArccos (realSech x) ∧
      (gudermannian x : ℂ) = principalArcsec (Real.cosh x) ∧
      (gudermannian x : ℂ) = principalArctan (Real.sinh x) ∧
      (gudermannian x : ℂ) = principalArccot (realCsch x)
-- ANCHOR_END: dlmf_4_23_40
:= by sorry

/-- DLMF 4.23.E41. -/
-- ANCHOR: dlmf_4_23_41
theorem dlmf_4_23_41 {x : ℝ} (hx : -Real.pi / 2 < x) (hx' : x < Real.pi / 2) : inverseGudermannian x = ∫ t in (0 : ℝ)..x, 1 / Real.cos t
-- ANCHOR_END: dlmf_4_23_41
:= by sorry

/-- DLMF 4.23.E42. -/
-- ANCHOR: dlmf_4_23_42
theorem dlmf_4_23_42 {x : ℝ} (hx : -Real.pi / 2 < x) (hx' : x < Real.pi / 2)
    (hx0 : x ≠ 0) :
    (inverseGudermannian x : ℂ) =
        (Real.log (Real.tan (x / 2 + Real.pi / 4)) : ℂ) ∧
      (inverseGudermannian x : ℂ) =
        (Real.log (realSec x + Real.tan x) : ℂ) ∧
      (inverseGudermannian x : ℂ) = principalArcsinh (Real.tan x) ∧
      (inverseGudermannian x : ℂ) = principalArccsch (realCot x) ∧
      (inverseGudermannian x : ℂ) = principalArccosh (realSec x) ∧
      (inverseGudermannian x : ℂ) = principalArcsech (Real.cos x) ∧
      (inverseGudermannian x : ℂ) = principalArctanh (Real.sin x) ∧
      (inverseGudermannian x : ℂ) = principalArccoth (realCsc x)
-- ANCHOR_END: dlmf_4_23_42
:= by sorry

end LMLF.Blueprint.Elementary.Section423
