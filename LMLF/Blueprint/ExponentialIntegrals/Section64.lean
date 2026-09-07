import Mathlib.Analysis.SpecialFunctions.Complex.Log
import LMLF.Blueprint.ExponentialIntegrals.Section62

open Filter
open scoped Topology
noncomputable section

namespace LMLF.Blueprint.ExponentialIntegrals
namespace Section64

/-! DLMF §6.4: analytic continuation and the side of the negative-axis cut. -/

/-- DLMF §6.4: the two boundary sides of the negative-real-axis cut. -/
inductive CutSide where
  | upper
  | lower
deriving DecidableEq, Repr

/-- DLMF §6.4.E3–E7: the signed choice for the upper or lower side. -/
def sideSign : CutSide → ℤ
  | .upper => 1
  | .lower => -1

/-- DLMF §6.4: the closed negative-real-axis cut. -/
def negativeAxis (z : ℂ) : Prop := z.im = 0 ∧ z.re ≤ 0

/-- DLMF §6.4: the open principal-logarithm domain. -/
def principalDomain (z : ℂ) : Prop := ¬ negativeAxis z

/-- DLMF §6.4: the positive real axis used to normalize principal values. -/
def positiveAxis (z : ℂ) : Prop := z.im = 0 ∧ 0 < z.re

/-- DLMF §6.4.E1–E2: the general logarithm with integer branch index. -/
def branchLog (z : ℂ) (m : ℤ) : ℂ :=
  Complex.log z + 2 * (m : ℂ) * (Real.pi : ℂ) * Complex.I

/-- DLMF §6.4.E3–E7: a typed lifted half-turn.  The continuous logarithm is the
branch data: its endpoint differs from the starting logarithm by exactly the
signed half-turn, even though both ordinary paths end at `-source`. -/
-- ANCHOR: HalfTurnLift
structure HalfTurnLift where
  source : ℂ
  side : CutSide
  nonzero : source ≠ 0
  path : ℝ → ℂ
  path_start : path 0 = source
  path_endpoint : Tendsto path atTop (𝓝 (-source))
  path_continuous : Continuous path
  path_nonzero : ∀ t : ℝ, path t ≠ 0
  liftedLog : ℝ → ℂ
  liftedLog_continuous : Continuous liftedLog
  liftedLog_exp : ∀ t : ℝ, Complex.exp (liftedLog t) = path t
  liftedLog_start : liftedLog 0 = Complex.log source
  liftedLog_endpoint : Tendsto liftedLog atTop
    (𝓝 (Complex.log source + (sideSign side : ℂ) * (Real.pi : ℂ) * Complex.I))
-- ANCHOR_END: HalfTurnLift

/-- DLMF §6.4.E1: a canonical lifted logarithm along a returning path. -/
-- ANCHOR: GeneralE1Continuation
structure GeneralE1Continuation where
  source : ℂ
  winding : ℤ
  nonzero : source ≠ 0
  path : ℝ → ℂ
  path_start : path 0 = source
  path_endpoint : Tendsto path atTop (𝓝 source)
  path_nonzero : ∀ t : ℝ, path t ≠ 0
  liftedLog : ℝ → ℂ
  liftedLog_continuous : Continuous liftedLog
  liftedLog_exp : ∀ t : ℝ, Complex.exp (liftedLog t) = path t
  liftedLog_start : liftedLog 0 = Complex.log source
  liftedLog_endpoint : Tendsto liftedLog atTop (𝓝 (branchLog source winding))
  value : ℂ
  value_limit : Tendsto
    (fun t => LMLF.Blueprint.ExponentialIntegrals.Section62.principalEin (path t) -
      liftedLog t - (Real.eulerMascheroniConstant : ℂ))
    atTop (𝓝 value)
-- ANCHOR_END: GeneralE1Continuation

/-- DLMF §6.4.E3–E7: a boundary value of a branch-aware continuation along the
typed half-turn path. -/
-- ANCHOR: HasHalfTurnLimit
def HasHalfTurnLimit (f : ℂ → ℂ → ℂ) (P : HalfTurnLift) (v : ℂ) : Prop :=
  Tendsto (fun t : ℝ => f (P.path t) (P.liftedLog t)) atTop (𝓝 v)
-- ANCHOR_END: HasHalfTurnLimit

/-- DLMF §6.4.E1: the canonical general E₁ value built from §6.2 `Ein`, the
principal logarithm, Euler's constant, and an explicit branch index. -/
def generalE1Value (z : ℂ) (m : ℤ) : ℂ :=
  LMLF.Blueprint.ExponentialIntegrals.Section62.principalEin z - branchLog z m -
    (Real.eulerMascheroniConstant : ℂ)

/-- DLMF §6.4.E4: the principal Ci value reconstructed from §6.2.E12–E13. -/
def principalCiValue (z : ℂ) : ℂ :=
  -LMLF.Blueprint.ExponentialIntegrals.Section62.principalCin z + Complex.log z +
    (Real.eulerMascheroniConstant : ℂ)

/-- DLMF §6.4.E5: the principal Chi value reconstructed from §6.2.E16. -/
def principalChiValue (z : ℂ) : ℂ :=
  (Real.eulerMascheroniConstant : ℂ) + Complex.log z +
    LMLF.Blueprint.ExponentialIntegrals.Section62.principalChiRegular z

/- DLMF §6.2.E10: the lower-case sine-integral tail used by the auxiliary
functions, distinct from the entire upper-case principal Si. -/
-- ANCHOR: principalSiTailValue
def principalSiTailValue (z : ℂ) : ℂ :=
  LMLF.Blueprint.ExponentialIntegrals.Section62.principalSi z -
    (Real.pi : ℂ) / 2
-- ANCHOR_END: principalSiTailValue

/-- DLMF §6.4.E6: the branch-side principal auxiliary sine-integral value. -/
-- ANCHOR: principalContinuationFValue
def principalContinuationFValue (z : ℂ) : ℂ :=
  principalCiValue z * Complex.sin z -
    principalSiTailValue z * Complex.cos z
-- ANCHOR_END: principalContinuationFValue

/-- DLMF §6.4.E7: the branch-side principal auxiliary cosine-integral value. -/
-- ANCHOR: principalContinuationGValue
def principalContinuationGValue (z : ℂ) : ℂ :=
  -principalCiValue z * Complex.cos z -
    principalSiTailValue z * Complex.sin z
-- ANCHOR_END: principalContinuationGValue

/- The §6.4 formulas use branch-side reconstructions.  On the principal-cut
domain they agree with the canonical §6.2 auxiliary pair; the explicit bridge
keeps the two APIs from being silently identified by namespace resolution. -/
-- ANCHOR: principalContinuationFValue_bridge
/-- DLMF 6.4.E6: principal-domain bridge for the branch-side f value. -/
theorem principalContinuationFValue_eq_principalAuxiliaryF (z : ℂ)
    (hz : Section62.principalCutDomain z) :
    principalContinuationFValue z = Section62.principalAuxiliaryF z
-- ANCHOR_END: principalContinuationFValue_bridge
    := by sorry

-- ANCHOR: principalContinuationGValue_bridge
/-- DLMF 6.4.E7: principal-domain bridge for the branch-side g value. -/
theorem principalContinuationGValue_eq_principalAuxiliaryG (z : ℂ)
    (hz : Section62.principalCutDomain z) :
    principalContinuationGValue z = Section62.principalAuxiliaryG z
-- ANCHOR_END: principalContinuationGValue_bridge
    := by sorry

/-- DLMF §6.4.E3: the E₁ continuation expression evaluated with a lifted log. -/
-- ANCHOR: halfTurnE1Continuation
def halfTurnE1Continuation (z logz : ℂ) : ℂ :=
  LMLF.Blueprint.ExponentialIntegrals.Section62.principalEin z - logz -
    (Real.eulerMascheroniConstant : ℂ)
-- ANCHOR_END: halfTurnE1Continuation

/-- DLMF §6.4.E4: the Ci continuation expression evaluated with a lifted log. -/
-- ANCHOR: halfTurnCiContinuation
def halfTurnCiContinuation (z logz : ℂ) : ℂ :=
  -LMLF.Blueprint.ExponentialIntegrals.Section62.principalCin z + logz +
    (Real.eulerMascheroniConstant : ℂ)
-- ANCHOR_END: halfTurnCiContinuation

/-- DLMF §6.4.E5: the Chi continuation expression evaluated with a lifted log. -/
-- ANCHOR: halfTurnChiContinuation
def halfTurnChiContinuation (z logz : ℂ) : ℂ :=
  (Real.eulerMascheroniConstant : ℂ) + logz +
    LMLF.Blueprint.ExponentialIntegrals.Section62.principalChiRegular z
-- ANCHOR_END: halfTurnChiContinuation

/-- DLMF §6.4.E6: the f continuation expression evaluated with a lifted log. -/
-- ANCHOR: halfTurnFContinuation
def halfTurnFContinuation (z logz : ℂ) : ℂ :=
  halfTurnCiContinuation z logz * Complex.sin z -
    principalSiTailValue z * Complex.cos z
-- ANCHOR_END: halfTurnFContinuation

/-- DLMF §6.4.E7: the g continuation expression evaluated with a lifted log. -/
-- ANCHOR: halfTurnGContinuation
def halfTurnGContinuation (z logz : ℂ) : ℂ :=
  -halfTurnCiContinuation z logz * Complex.cos z -
    principalSiTailValue z * Complex.sin z
-- ANCHOR_END: halfTurnGContinuation

/- DLMF 6.4.E1. The lifted canonical value is determined by the continuation
limit of the principal Ein/logarithm expression. -/
-- ANCHOR: dlmf_6_4_E1
theorem dlmf_6_4_E1 (L : GeneralE1Continuation) :
    L.value = generalE1Value L.source L.winding
-- ANCHOR_END: dlmf_6_4_E1
    := by sorry

/- DLMF 6.4.E2. A full turn changes the logarithmic value by 2 m pi i;
the branch index is retained rather than evaluated at the same ordinary point. -/
-- ANCHOR: dlmf_6_4_E2
theorem dlmf_6_4_E2 (L : GeneralE1Continuation) :
    L.value = generalE1Value L.source 0 -
      2 * (L.winding : ℂ) * (Real.pi : ℂ) * Complex.I
-- ANCHOR_END: dlmf_6_4_E2
    := by sorry

/- DLMF 6.4.E3. The two half-turn boundary values retain their side in a
typed lift of the endpoint `-z`. -/
-- ANCHOR: dlmf_6_4_E3
theorem dlmf_6_4_E3 (P : HalfTurnLift)
    : HasHalfTurnLimit
      halfTurnE1Continuation P
      (LMLF.Blueprint.ExponentialIntegrals.Section62.principalEin (-P.source) -
        Complex.log P.source - (Real.eulerMascheroniConstant : ℂ) -
          (sideSign P.side : ℂ) * (Real.pi : ℂ) * Complex.I)
-- ANCHOR_END: dlmf_6_4_E3
    := by sorry

/- DLMF 6.4.E4. Ci has the signed jump across the typed half-turn. -/
-- ANCHOR: dlmf_6_4_E4
theorem dlmf_6_4_E4 (P : HalfTurnLift)
    : HasHalfTurnLimit halfTurnCiContinuation P
      ((sideSign P.side : ℂ) * (Real.pi : ℂ) * Complex.I + principalCiValue P.source)
-- ANCHOR_END: dlmf_6_4_E4
    := by sorry

/- DLMF 6.4.E5. Chi has the same signed logarithmic jump. -/
-- ANCHOR: dlmf_6_4_E5
theorem dlmf_6_4_E5 (P : HalfTurnLift)
    : HasHalfTurnLimit halfTurnChiContinuation P
      ((sideSign P.side : ℂ) * (Real.pi : ℂ) * Complex.I + principalChiValue P.source)
-- ANCHOR_END: dlmf_6_4_E5
    := by sorry

/- DLMF 6.4.E6. The auxiliary sine-integral continuation has its exponential
term, with the side retained by the typed lift. -/
-- ANCHOR: dlmf_6_4_E6
theorem dlmf_6_4_E6 (P : HalfTurnLift)
    : HasHalfTurnLimit halfTurnFContinuation P
      ((Real.pi : ℂ) * Complex.exp (-((sideSign P.side : ℂ) * Complex.I * P.source)) -
        principalContinuationFValue P.source)
-- ANCHOR_END: dlmf_6_4_E6
    := by sorry

/- DLMF 6.4.E7. The auxiliary cosine-integral continuation has its signed
exponential term. -/
-- ANCHOR: dlmf_6_4_E7
theorem dlmf_6_4_E7 (P : HalfTurnLift)
    : HasHalfTurnLimit halfTurnGContinuation P
      (-((sideSign P.side : ℂ) * (Real.pi : ℂ) * Complex.I) *
          Complex.exp (-((sideSign P.side : ℂ) * Complex.I * P.source)) +
          principalContinuationGValue P.source)
-- ANCHOR_END: dlmf_6_4_E7
    := by sorry

end Section64
end LMLF.Blueprint.ExponentialIntegrals
