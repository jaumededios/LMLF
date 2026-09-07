import Mathlib.Analysis.SpecialFunctions.Gamma.Beta
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import LMLF.Integral.Curve

open Filter MeasureTheory Set
open scoped Interval Topology

noncomputable section

namespace LMLF.Blueprint.Gamma.Section512

open LMLF.Integral

/-! ### Typed beta domains and values -/

/-- DLMF 5.12.1--5.12.4: parameters in the Euler convergence domain. -/
-- ANCHOR: EulerBetaDomain
structure EulerBetaDomain where
  a : ℂ
  b : ℂ
  a_pos : 0 < a.re
  b_pos : 0 < b.re
-- ANCHOR_END: EulerBetaDomain

/-- DLMF 5.12.1: the Euler beta integrand attached to its typed domain data. -/
-- ANCHOR: betaEulerIntegrand
noncomputable def betaEulerIntegrand (p : EulerBetaDomain) (t : ℝ) : ℂ :=
  (t : ℂ) ^ (p.a - 1) * (1 - (t : ℂ)) ^ (p.b - 1)
-- ANCHOR_END: betaEulerIntegrand

/-- DLMF 5.12.1: the finite Euler beta integral. -/
-- ANCHOR: betaEulerIntegral
noncomputable def betaEulerIntegral (p : EulerBetaDomain) : ℂ :=
  ∫ t in (0 : ℝ)..1, betaEulerIntegrand p t
-- ANCHOR_END: betaEulerIntegral

/-- DLMF 5.12.2: the trigonometric beta integrand. -/
-- ANCHOR: betaTrigonometricIntegrand
noncomputable def betaTrigonometricIntegrand (p : EulerBetaDomain) (θ : ℝ) : ℂ :=
  (Complex.sin (θ : ℂ)) ^ (2 * p.a - 1) *
    (Complex.cos (θ : ℂ)) ^ (2 * p.b - 1)
-- ANCHOR_END: betaTrigonometricIntegrand

/-- DLMF 5.12.3: the positive-half-line beta integrand. -/
-- ANCHOR: betaHalfLineIntegrand
noncomputable def betaHalfLineIntegrand (p : EulerBetaDomain) (t : ℝ) : ℂ :=
  (t : ℂ) ^ (p.a - 1) / (1 + (t : ℂ)) ^ (p.a + p.b)
-- ANCHOR_END: betaHalfLineIntegrand

/-- DLMF 5.12.4: Euler parameters together with the admissible shift. -/
-- ANCHOR: ShiftedBetaDomain
structure ShiftedBetaDomain extends EulerBetaDomain where
  z : ℂ
  z_ne_zero : z ≠ 0
  arg_lt_pi : |Complex.arg z| < Real.pi
-- ANCHOR_END: ShiftedBetaDomain

/-- DLMF 5.12.4: the shifted beta integrand. -/
-- ANCHOR: betaShiftedIntegrand
noncomputable def betaShiftedIntegrand (p : ShiftedBetaDomain) (t : ℝ) : ℂ :=
  (t : ℂ) ^ (p.a - 1) * (1 - (t : ℂ)) ^ (p.b - 1) /
    ((t : ℂ) + p.z) ^ (p.a + p.b)
-- ANCHOR_END: betaShiftedIntegrand

/-! ### Meromorphic beta continuation -/

/-- DLMF 5.12.5–5.12.6 and 5.12.8–5.12.12: the meromorphic beta function represented
by its Gamma quotient.  This is deliberately separate from Mathlib's
`Complex.betaIntegral`, whose definition is the convergent interval Euler integral. -/
-- ANCHOR: meromorphicBeta
noncomputable def meromorphicBeta (a b : ℂ) : ℂ :=
  Complex.Gamma a * Complex.Gamma b / Complex.Gamma (a + b)
-- ANCHOR_END: meromorphicBeta

/-- DLMF 5.12.5–5.12.6 and 5.12.8–5.12.12: a conservative guard requiring all
three Gamma factors displayed in the quotient to be nonzero.  It is sufficient
for the quotient evaluator, but is not a characterization of every finite value
of the meromorphic continuation. -/
-- ANCHOR: meromorphicBetaDefined
def meromorphicBetaDefined (a b : ℂ) : Prop :=
  Complex.Gamma a ≠ 0 ∧ Complex.Gamma b ≠ 0 ∧ Complex.Gamma (a + b) ≠ 0
-- ANCHOR_END: meromorphicBetaDefined

/-- DLMF 5.12.5--5.12.12: the conservative domain where all three Gamma
factors in the displayed quotient are nonzero.  This is a sufficient
Gamma-quotient guard, not a characterization of every finite meromorphic beta value. -/
-- ANCHOR: GammaQuotientDefined
structure GammaQuotientDefined (a b : ℂ) : Type where
  gamma_ne_zero : meromorphicBetaDefined a b
-- ANCHOR_END: GammaQuotientDefined

/-- DLMF 5.12.5--5.12.12: evaluate the Gamma quotient on its guarded domain. -/
-- ANCHOR: GammaQuotientDefined.value
noncomputable def GammaQuotientDefined.value {a b : ℂ} (_p : GammaQuotientDefined a b) : ℂ :=
  meromorphicBeta a b
-- ANCHOR_END: GammaQuotientDefined.value

/-- DLMF 5.12.7: the hyperbolic beta convergence domain. -/
-- ANCHOR: HyperbolicBetaDomain
structure HyperbolicBetaDomain where
  a : ℂ
  b : ℂ
  abs_b_re_lt_a_re : |b.re| < a.re
-- ANCHOR_END: HyperbolicBetaDomain

/-- DLMF 5.12.8: parameters for the vertical Fourier integral. -/
-- ANCHOR: VerticalBetaDomain
structure VerticalBetaDomain where
  a : ℂ
  b : ℂ
  w : ℂ
  z : ℂ
  sum_re_gt_one : 1 < (a + b).re
  w_re_pos : 0 < w.re
  z_re_pos : 0 < z.re
-- ANCHOR_END: VerticalBetaDomain

/-- DLMF 5.12.9: parameters for the Barnes vertical contour. -/
-- ANCHOR: BarnesBetaDomain
structure BarnesBetaDomain where
  a : ℂ
  b : ℂ
  c : ℝ
  c_pos : 0 < c
  c_lt_one : c < 1
  sum_re_pos : 0 < (a + b).re
  b_ne_zero : b ≠ 0
  beta : GammaQuotientDefined a b
-- ANCHOR_END: BarnesBetaDomain

/-- DLMF 5.12.10: parameters for the first beta loop. -/
-- ANCHOR: FirstLoopBetaDomain
structure FirstLoopBetaDomain where
  a : ℂ
  b : ℂ
  a_re_pos : 0 < a.re
  beta : GammaQuotientDefined a b
-- ANCHOR_END: FirstLoopBetaDomain

/-- DLMF 5.12.5: cosine parameters with a `GammaQuotientDefined` transformed
beta pair. -/
-- ANCHOR: CosineBetaDomain
structure CosineBetaDomain where
  a : ℂ
  b : ℂ
  a_re_pos : 0 < a.re
  a_ne_zero : a ≠ 0
  beta : GammaQuotientDefined ((a + b + 1) / 2) ((a - b + 1) / 2)
-- ANCHOR_END: CosineBetaDomain

/-- DLMF 5.12.6: Fourier parameters with a `GammaQuotientDefined` transformed
beta pair. -/
-- ANCHOR: FourierBetaDomain
structure FourierBetaDomain where
  a : ℂ
  b : ℂ
  a_re_pos : 0 < a.re
  a_ne_zero : a ≠ 0
  beta : GammaQuotientDefined ((a + b + 1) / 2) ((a - b + 1) / 2)
-- ANCHOR_END: FourierBetaDomain

/-- DLMF 5.12.8: vertical parameters with a `GammaQuotientDefined` beta pair. -/
-- ANCHOR: VerticalGammaQuotientDomain
structure VerticalGammaQuotientDomain extends VerticalBetaDomain where
  beta : GammaQuotientDefined a b
-- ANCHOR_END: VerticalGammaQuotientDomain

/-! ### Contour vocabulary for the loop formulas -/

/-- DLMF 5.12.10: the normalized positively oriented loop about `1` used for
the first beta loop formula.

The associated source notation is `∫₀^(1+)`; E10 uses the source's pointwise principal
values on this loop.
-/
-- ANCHOR: betaFirstLoopContour
noncomputable def betaFirstLoopContour : LMLF.Integral.C1Contour where
  point u := 1 + Complex.exp ((Real.pi + 2 * Real.pi * (u : ℂ)) * Complex.I)
  tangent u :=
    Complex.exp ((Real.pi + 2 * Real.pi * (u : ℂ)) * Complex.I) *
      (2 * Real.pi : ℂ) * Complex.I
  start := 1 + Complex.exp (Real.pi * Complex.I)
  finish := 1 + Complex.exp (3 * Real.pi * Complex.I)
  point_zero := by sorry
  point_one := by sorry
  hasDeriv := by sorry
  tangent_continuous := by fun_prop
-- ANCHOR_END: betaFirstLoopContour

/-- DLMF 5.12.10: integrate a principal-power integrand on the typed first loop. -/
-- ANCHOR: betaFirstLoopIntegral
noncomputable def betaFirstLoopIntegral (f : ℂ → ℂ) : ℂ :=
  betaFirstLoopContour.integral f
-- ANCHOR_END: betaFirstLoopIntegral

/-- DLMF 5.12.11: one coherent pair of logarithm lifts for the whole incoming ray,
the shrinking circle, and the outgoing ray.  Every finite truncation is obtained by
restriction of this single datum, so branch choices cannot vary with `R`.  The
positive circle records one `t` winding (`+2πi` at the outgoing join), while the
`1+t` lift returns to its principal value. -/
-- ANCHOR: SecondLoopLogBranch
structure SecondLoopLogBranch (a b : ℂ) where
  logTIncoming : ℝ → ℂ
  logOnePlusIncoming : ℝ → ℂ
  logTCircle : ℝ → ℝ → ℂ
  logOnePlusCircle : ℝ → ℝ → ℂ
  logTOutgoing : ℝ → ℂ
  logOnePlusOutgoing : ℝ → ℂ
  incoming_t_continuous : ContinuousOn logTIncoming (Ioi 0)
  incoming_one_continuous : ContinuousOn logOnePlusIncoming (Ioi 0)
  circle_t_continuous : ∀ ε : ℝ, 0 < ε → ε < 1 → Continuous (logTCircle ε)
  circle_one_continuous : ∀ ε : ℝ, 0 < ε → ε < 1 → Continuous (logOnePlusCircle ε)
  outgoing_t_continuous : ContinuousOn logTOutgoing (Ioi 0)
  outgoing_one_continuous : ContinuousOn logOnePlusOutgoing (Ioi 0)
  incoming_t_exp : ∀ r : ℝ, 0 < r →
    Complex.exp (logTIncoming r) = (r : ℂ)
  incoming_one_exp : ∀ r : ℝ, 0 < r →
    Complex.exp (logOnePlusIncoming r) = 1 + (r : ℂ)
  circle_t_exp : ∀ ε θ : ℝ, 0 < ε → ε < 1 →
    Complex.exp (logTCircle ε θ) = (ε : ℂ) * Complex.exp ((θ : ℂ) * Complex.I)
  circle_one_exp : ∀ ε θ : ℝ, 0 < ε → ε < 1 →
    Complex.exp (logOnePlusCircle ε θ) =
      1 + (ε : ℂ) * Complex.exp ((θ : ℂ) * Complex.I)
  outgoing_t_exp : ∀ r : ℝ, 0 < r →
    Complex.exp (logTOutgoing r) = (r : ℂ)
  outgoing_one_exp : ∀ r : ℝ, 0 < r →
    Complex.exp (logOnePlusOutgoing r) = 1 + (r : ℂ)
  incoming_t_principal : ∀ r : ℝ, 0 < r →
    logTIncoming r = Complex.log (r : ℂ)
  incoming_one_principal : ∀ r : ℝ, 0 < r →
    logOnePlusIncoming r = Complex.log (1 + (r : ℂ))
  circle_t_starts : ∀ ε : ℝ, 0 < ε → ε < 1 →
    logTCircle ε 0 = logTIncoming ε
  circle_one_starts : ∀ ε : ℝ, 0 < ε → ε < 1 →
    logOnePlusCircle ε 0 = logOnePlusIncoming ε
  circle_t_ends : ∀ ε : ℝ, 0 < ε → ε < 1 →
    logTCircle ε (2 * Real.pi) = logTIncoming ε + 2 * Real.pi * Complex.I
  circle_one_ends : ∀ ε : ℝ, 0 < ε → ε < 1 →
    logOnePlusCircle ε (2 * Real.pi) = logOnePlusIncoming ε
  outgoing_t_starts : ∀ ε : ℝ, 0 < ε → ε < 1 →
    logTOutgoing ε = logTCircle ε (2 * Real.pi)
  outgoing_one_starts : ∀ ε : ℝ, 0 < ε → ε < 1 →
    logOnePlusOutgoing ε = logOnePlusCircle ε (2 * Real.pi)
  outgoing_t_monodromy : ∀ ε : ℝ, 0 < ε → ε < 1 →
    logTOutgoing ε = logTIncoming ε + 2 * Real.pi * Complex.I
  outgoing_one_principal : ∀ ε : ℝ, 0 < ε → ε < 1 →
    logOnePlusOutgoing ε = Complex.log (1 + (ε : ℂ))
-- ANCHOR_END: SecondLoopLogBranch

/-- DLMF 5.12.11: the cut and convergence domain for the second-loop formula. -/
-- ANCHOR: SecondLoopDomain
structure SecondLoopDomain (a b : ℂ) where
  branch : SecondLoopLogBranch a b
  b_re_pos : 0 < b.re
  a_not_integer : ∀ n : ℤ, a ≠ n
  cutPoint : ℝ
  cut_between : -1 < cutPoint ∧ cutPoint < 0
-- ANCHOR_END: SecondLoopDomain

/-- DLMF 5.12.11: a mathematically inhabited canonical branch datum.  The
analytic lift laws are explicit fields; their proofs remain pending. -/
-- ANCHOR: canonicalSecondLoopLogBranch
noncomputable def canonicalSecondLoopLogBranch (a b : ℂ) : SecondLoopLogBranch a b := by
  refine
    { logTIncoming := fun r => Complex.log (r : ℂ)
      logOnePlusIncoming := fun r => Complex.log (1 + (r : ℂ))
      logTCircle := fun ε θ => Complex.log (ε : ℂ) + (θ : ℂ) * Complex.I
      logOnePlusCircle := fun ε θ => Complex.log
        (1 + (ε : ℂ) * Complex.exp ((θ : ℂ) * Complex.I))
      logTOutgoing := fun r => Complex.log (r : ℂ) + 2 * Real.pi * Complex.I
      logOnePlusOutgoing := fun r => Complex.log (1 + (r : ℂ))
      incoming_t_continuous := by sorry
      incoming_one_continuous := by sorry
      circle_t_continuous := by sorry
      circle_one_continuous := by sorry
      outgoing_t_continuous := by sorry
      outgoing_one_continuous := by sorry
      incoming_t_exp := by sorry
      incoming_one_exp := by sorry
      circle_t_exp := by sorry
      circle_one_exp := by sorry
      outgoing_t_exp := by sorry
      outgoing_one_exp := by sorry
      incoming_t_principal := by sorry
      incoming_one_principal := by sorry
      circle_t_starts := by sorry
      circle_one_starts := by sorry
      circle_t_ends := by sorry
      circle_one_ends := by sorry
      outgoing_t_starts := by sorry
      outgoing_one_starts := by sorry
      outgoing_t_monodromy := by sorry
      outgoing_one_principal := by sorry }
-- ANCHOR_END: canonicalSecondLoopLogBranch
/-- DLMF 5.12.11: the finite positive-ray Hankel truncation.  The third piece runs
from `ε` back out to `R` on the positive real ray; it is not a negative-ray segment. -/
-- ANCHOR: betaSecondLoopTruncation
noncomputable def betaSecondLoopTruncation {a b : ℂ}
    (branch : SecondLoopLogBranch a b) (R : ℝ) (_hR : 1 < R) : ℂ :=
  let ε : ℝ := 1 / R
  ∫ r in R..ε,
      Complex.exp ((a - 1) * branch.logTIncoming r) *
        Complex.exp ((-a - b) * branch.logOnePlusIncoming r) +
    ∫ θ in (0 : ℝ)..(2 * Real.pi),
      (Complex.exp ((a - 1) * branch.logTCircle ε θ) *
        Complex.exp ((-a - b) * branch.logOnePlusCircle ε θ)) *
        ((ε : ℂ) * Complex.I * Complex.exp ((θ : ℂ) * Complex.I)) +
    ∫ r in (ε : ℝ)..(R : ℝ),
      Complex.exp ((a - 1) * branch.logTOutgoing r) *
        Complex.exp ((-a - b) * branch.logOnePlusOutgoing r)
-- ANCHOR_END: betaSecondLoopTruncation

/-- DLMF 5.12.11: the canonical finite-truncation family for a coherent branch. -/
-- ANCHOR: betaSecondLoopFamily
noncomputable def betaSecondLoopFamily {a b : ℂ}
    (branch : SecondLoopLogBranch a b) (R : ℝ) : ℂ :=
  if hR : 1 < R then betaSecondLoopTruncation branch R hR else 0
-- ANCHOR_END: betaSecondLoopFamily

/-- DLMF 5.12.11: a named improper beta integral together with its actual limit proof. -/
-- ANCHOR: SecondLoopIntegralData
structure SecondLoopIntegralData {a b : ℂ} (d : SecondLoopDomain a b) where
  value : ℂ
  converges : Tendsto (betaSecondLoopFamily d.branch) atTop (𝓝 value)
-- ANCHOR_END: SecondLoopIntegralData

/-- DLMF 5.12.11: the named value carried by a convergent second-loop datum. -/
-- ANCHOR: betaSecondLoopIntegral
noncomputable def betaSecondLoopIntegral {a b : ℂ} {d : SecondLoopDomain a b}
    (data : SecondLoopIntegralData d) : ℂ := data.value
-- ANCHOR_END: betaSecondLoopIntegral

/-- DLMF 5.12.11: convergence of the supplied canonical truncation datum. -/
-- ANCHOR: betaSecondLoopConverges
def betaSecondLoopConverges {a b : ℂ} {d : SecondLoopDomain a b}
    (data : SecondLoopIntegralData d) : Prop :=
  Tendsto (betaSecondLoopFamily d.branch) atTop (𝓝 data.value)
-- ANCHOR_END: betaSecondLoopConverges

/-- DLMF 5.12.12: the Pochhammer contour with base point `P ∈ (0,1)`, positive loops
around `1` and `0`, followed by negative loops around `1` and `0`. -/
-- ANCHOR: betaPochhammerCurve
def betaPochhammerCurve (P : ℝ) : ℝ → ℂ := fun u ↦
  if u ≤ 1 / 4 then 1 + (1 - (P : ℂ)) *
      Complex.exp ((Real.pi + 8 * Real.pi * (u : ℂ)) * Complex.I)
  else if u ≤ 1 / 2 then (P : ℂ) *
      Complex.exp (8 * Real.pi * ((u - 1 / 4 : ℝ) : ℂ) * Complex.I)
  else if u ≤ 3 / 4 then 1 + (1 - (P : ℂ)) *
      Complex.exp ((Real.pi - 8 * Real.pi * ((u - 1 / 2 : ℝ) : ℂ)) * Complex.I)
  else (P : ℂ) * Complex.exp (-8 * Real.pi * ((u - 3 / 4 : ℝ) : ℂ) * Complex.I)
-- ANCHOR_END: betaPochhammerCurve

/-- DLMF 5.12.12: logarithm lifts tied pointwise to the Pochhammer contour and its
`1 - t` companion.  Both lifts are continuous and principal at the base point;
the contour order is `(1+, 0+, 1-, 0-)` and returns to `P`. -/
-- ANCHOR: PochhammerLogBranch
structure PochhammerLogBranch (a b : ℂ) (P : ℝ) where
  contour : PiecewiseC1Contour
  logT : ℝ → ℂ
  logOneMinusT : ℝ → ℂ
  P_pos : 0 < P
  P_lt_one : P < 1
  curve_eq : ∀ u : ℝ, contour.point u = betaPochhammerCurve P u
  t_continuous : ContinuousOn logT (Icc 0 1)
  one_minus_t_continuous : ContinuousOn logOneMinusT (Icc 0 1)
  t_exp : ∀ u : ℝ,
    Complex.exp (logT u) = betaPochhammerCurve P u
  one_minus_t_exp : ∀ u : ℝ,
    Complex.exp (logOneMinusT u) = 1 - betaPochhammerCurve P u
  t_principal_at_start : logT 0 = Complex.log (P : ℂ)
  one_minus_t_principal_at_start :
    logOneMinusT 0 = Complex.log (1 - (P : ℂ))
-- ANCHOR_END: PochhammerLogBranch

-- ANCHOR: betaPochhammerIntegral
noncomputable def betaPochhammerIntegral {a b : ℂ} {P : ℝ}
    (branch : PochhammerLogBranch a b P) : ℂ :=
  branch.contour.integral₂
    (fun _ logT logOneMinusT =>
      Complex.exp ((a - 1) * logT) * Complex.exp ((b - 1) * logOneMinusT))
    branch.logT branch.logOneMinusT
-- ANCHOR_END: betaPochhammerIntegral

/-- DLMF 5.12.12: branch-aware finite-contour integrability. -/
-- ANCHOR: PochhammerLogBranch.Integrable
def PochhammerLogBranch.Integrable {a b : ℂ} {P : ℝ}
    (branch : PochhammerLogBranch a b P) : Prop :=
  branch.contour.Integrable₂
    (fun _ logT logOneMinusT =>
      Complex.exp ((a - 1) * logT) * Complex.exp ((b - 1) * logOneMinusT))
    branch.logT branch.logOneMinusT
-- ANCHOR_END: PochhammerLogBranch.Integrable

/-! ### Named transformed beta integrands -/

/-- DLMF 5.12.5: the cosine-power integrand. -/
-- ANCHOR: betaCosineIntegrand
noncomputable def betaCosineIntegrand (p : CosineBetaDomain) (t : ℝ) : ℂ :=
  (Complex.cos (t : ℂ)) ^ (p.a - 1) * Complex.cos (p.b * t)
-- ANCHOR_END: betaCosineIntegrand

/-- DLMF 5.12.6: the sine-power Fourier integrand. -/
-- ANCHOR: betaSineFourierIntegrand
noncomputable def betaSineFourierIntegrand (p : FourierBetaDomain) (t : ℝ) : ℂ :=
  (Complex.sin (t : ℂ)) ^ (p.a - 1) * Complex.exp (Complex.I * p.b * t)
-- ANCHOR_END: betaSineFourierIntegrand

/-- DLMF 5.12.7: the hyperbolic-cosine integrand. -/
-- ANCHOR: betaHyperbolicIntegrand
noncomputable def betaHyperbolicIntegrand (p : HyperbolicBetaDomain) (t : ℝ) : ℂ :=
  Complex.cosh (2 * p.b * t) / (Complex.cosh (t : ℂ)) ^ (2 * p.a)
-- ANCHOR_END: betaHyperbolicIntegrand

/-- DLMF 5.12.8: the vertical Fourier integrand. -/
-- ANCHOR: betaVerticalIntegrand
noncomputable def betaVerticalIntegrand (p : VerticalGammaQuotientDomain) (t : ℝ) : ℂ :=
  1 / ((p.w + Complex.I * t) ^ p.a * (p.z - Complex.I * t) ^ p.b)
-- ANCHOR_END: betaVerticalIntegrand

/-- DLMF 5.12.9: the Barnes vertical-contour integrand. -/
-- ANCHOR: betaBarnesIntegrand
noncomputable def betaBarnesIntegrand (p : BarnesBetaDomain) (y : ℝ) : ℂ :=
  (p.c + Complex.I * y) ^ (-p.a) *
    (1 - (p.c + Complex.I * y)) ^ (-1 - p.b) * Complex.I
-- ANCHOR_END: betaBarnesIntegrand

/-! ### Euler's beta integral and its transformations -/

/-- DLMF 5.12.2: the finite trigonometric beta integral. -/
-- ANCHOR: betaTrigonometricIntegral
noncomputable def betaTrigonometricIntegral (p : EulerBetaDomain) : ℂ :=
  ∫ θ in (0 : ℝ)..(Real.pi / 2), betaTrigonometricIntegrand p θ
-- ANCHOR_END: betaTrigonometricIntegral

/-- DLMF 5.12.3: the positive-half-line beta integral. -/
-- ANCHOR: betaHalfLineIntegral
noncomputable def betaHalfLineIntegral (p : EulerBetaDomain) : ℂ :=
  ∫ t in Ioi (0 : ℝ), betaHalfLineIntegrand p t
-- ANCHOR_END: betaHalfLineIntegral

/-- DLMF 5.12.4: the shifted finite beta integral. -/
-- ANCHOR: betaShiftedIntegral
noncomputable def betaShiftedIntegral (p : ShiftedBetaDomain) : ℂ :=
  ∫ t in (0 : ℝ)..1, betaShiftedIntegrand p t
-- ANCHOR_END: betaShiftedIntegral

/-- DLMF 5.12.5: the cosine-power beta integral. -/
-- ANCHOR: betaCosineIntegral
noncomputable def betaCosineIntegral (p : CosineBetaDomain) : ℂ :=
  ∫ t in (0 : ℝ)..(Real.pi / 2), betaCosineIntegrand p t
-- ANCHOR_END: betaCosineIntegral

/-- DLMF 5.12.6: the sine-power Fourier beta integral. -/
-- ANCHOR: betaSineFourierIntegral
noncomputable def betaSineFourierIntegral (p : FourierBetaDomain) : ℂ :=
  ∫ t in (0 : ℝ)..Real.pi, betaSineFourierIntegrand p t
-- ANCHOR_END: betaSineFourierIntegral

/-- DLMF 5.12.7: the hyperbolic beta integral. -/
-- ANCHOR: betaHyperbolicIntegral
noncomputable def betaHyperbolicIntegral (p : HyperbolicBetaDomain) : ℂ :=
  ∫ t in Ioi (0 : ℝ), betaHyperbolicIntegrand p t
-- ANCHOR_END: betaHyperbolicIntegral

/-- DLMF 5.12.8: the vertical Fourier beta integral. -/
-- ANCHOR: betaVerticalIntegral
noncomputable def betaVerticalIntegral (p : VerticalGammaQuotientDomain) : ℂ :=
  ∫ t : ℝ, betaVerticalIntegrand p t
-- ANCHOR_END: betaVerticalIntegral

/-- DLMF 5.12.9: the Barnes vertical-contour beta integral. -/
-- ANCHOR: betaBarnesIntegral
noncomputable def betaBarnesIntegral (p : BarnesBetaDomain) : ℂ :=
  ∫ y : ℝ, betaBarnesIntegrand p y
-- ANCHOR_END: betaBarnesIntegral

/-- DLMF 5.12.10: the principal-power integrand on the first loop. -/
-- ANCHOR: betaFirstLoopIntegrand
noncomputable def betaFirstLoopIntegrand (p : FirstLoopBetaDomain) (t : ℂ) : ℂ :=
  t ^ (p.a - 1) * (t - 1) ^ (p.b - 1)
-- ANCHOR_END: betaFirstLoopIntegrand

/-- DLMF 5.12.1: Euler's beta integral and the Gamma quotient. -/
-- DLMF 5.12.1 https://dlmf.nist.gov/5.12.E1
-- ANCHOR: dlmf_5_12_1_integrable
theorem dlmf_5_12_1_integrable (p : EulerBetaDomain) :
    IntervalIntegrable (betaEulerIntegrand p) volume 0 1
-- ANCHOR_END: dlmf_5_12_1_integrable
  := by sorry

-- ANCHOR: dlmf_5_12_1_euler
theorem dlmf_5_12_1_euler (p : EulerBetaDomain) :
    Complex.betaIntegral p.a p.b = betaEulerIntegral p
-- ANCHOR_END: dlmf_5_12_1_euler
  := by sorry

-- ANCHOR: dlmf_5_12_1
theorem dlmf_5_12_1 (p : EulerBetaDomain) :
    betaEulerIntegral p = meromorphicBeta p.a p.b
-- ANCHOR_END: dlmf_5_12_1
  := by sorry

/-- DLMF 5.12.2: the trigonometric form of Euler's beta integral. -/
-- DLMF 5.12.2 https://dlmf.nist.gov/5.12.E2
-- ANCHOR: dlmf_5_12_2_integrable
theorem dlmf_5_12_2_integrable (p : EulerBetaDomain) :
    IntervalIntegrable (betaTrigonometricIntegrand p) volume 0 (Real.pi / 2)
-- ANCHOR_END: dlmf_5_12_2_integrable
  := by sorry

-- ANCHOR: dlmf_5_12_2
theorem dlmf_5_12_2 (p : EulerBetaDomain) :
    betaTrigonometricIntegral p = Complex.betaIntegral p.a p.b / 2
-- ANCHOR_END: dlmf_5_12_2
  := by sorry

/-- DLMF 5.12.3: the beta integral on the positive half-line. -/
-- DLMF 5.12.3 https://dlmf.nist.gov/5.12.E3
-- ANCHOR: dlmf_5_12_3_integrable
theorem dlmf_5_12_3_integrable (p : EulerBetaDomain) :
    IntegrableOn (betaHalfLineIntegrand p) (Ioi 0)
-- ANCHOR_END: dlmf_5_12_3_integrable
  := by sorry

-- ANCHOR: dlmf_5_12_3
theorem dlmf_5_12_3 (p : EulerBetaDomain) :
    betaHalfLineIntegral p = Complex.betaIntegral p.a p.b
-- ANCHOR_END: dlmf_5_12_3
  := by sorry

/-- DLMF 5.12.4: the shifted beta integral, with the principal phase condition on `z`. -/
-- DLMF 5.12.4 https://dlmf.nist.gov/5.12.E4
-- ANCHOR: dlmf_5_12_4_integrable
theorem dlmf_5_12_4_integrable (p : ShiftedBetaDomain) :
    IntervalIntegrable (betaShiftedIntegrand p) volume 0 1
-- ANCHOR_END: dlmf_5_12_4_integrable
  := by sorry

-- ANCHOR: dlmf_5_12_4
theorem dlmf_5_12_4 (p : ShiftedBetaDomain) :
    betaShiftedIntegral p =
      Complex.betaIntegral p.a p.b * (1 + p.z) ^ (-p.a) * p.z ^ (-p.b)
-- ANCHOR_END: dlmf_5_12_4
  := by sorry

/-! ### Trigonometric and hyperbolic forms -/

/-- DLMF 5.12.5: a cosine-power integral on `[0, π/2]`. -/
-- DLMF 5.12.5 https://dlmf.nist.gov/5.12.E5
-- ANCHOR: dlmf_5_12_5_integrable
theorem dlmf_5_12_5_integrable (p : CosineBetaDomain) :
    IntervalIntegrable (betaCosineIntegrand p) volume 0 (Real.pi / 2)
-- ANCHOR_END: dlmf_5_12_5_integrable
  := by sorry

-- ANCHOR: dlmf_5_12_5
theorem dlmf_5_12_5 (p : CosineBetaDomain) :
    betaCosineIntegral p =
      Real.pi / (2 : ℂ) ^ p.a / (p.a * GammaQuotientDefined.value p.beta)
-- ANCHOR_END: dlmf_5_12_5
  := by sorry

/-- DLMF 5.12.6: the exponential Fourier form over `[0, π]`. -/
-- DLMF 5.12.6 https://dlmf.nist.gov/5.12.E6
-- ANCHOR: dlmf_5_12_6_integrable
theorem dlmf_5_12_6_integrable (p : FourierBetaDomain) :
    IntervalIntegrable (betaSineFourierIntegrand p) volume 0 Real.pi
-- ANCHOR_END: dlmf_5_12_6_integrable
  := by sorry

-- ANCHOR: dlmf_5_12_6
theorem dlmf_5_12_6 (p : FourierBetaDomain) :
    betaSineFourierIntegral p =
      Real.pi / (2 : ℂ) ^ (p.a - 1) * Complex.exp (Complex.I * Real.pi * p.b / 2) /
        (p.a * GammaQuotientDefined.value p.beta)
-- ANCHOR_END: dlmf_5_12_6
  := by sorry

/-- DLMF 5.12.7: the hyperbolic-cosine integral, convergent when
`Re a > |Re b|`. -/
-- DLMF 5.12.7 https://dlmf.nist.gov/5.12.E7
-- ANCHOR: dlmf_5_12_7_integrable
theorem dlmf_5_12_7_integrable (p : HyperbolicBetaDomain) :
    IntegrableOn (betaHyperbolicIntegrand p) (Ioi 0)
-- ANCHOR_END: dlmf_5_12_7_integrable
  := by sorry

-- ANCHOR: dlmf_5_12_7
theorem dlmf_5_12_7 (p : HyperbolicBetaDomain) :
    betaHyperbolicIntegral p =
      (4 : ℂ) ^ (p.a - 1) * Complex.betaIntegral (p.a + p.b) (p.a - p.b)
-- ANCHOR_END: dlmf_5_12_7
  := by sorry

/-- DLMF 5.12.8: the Fourier integral on a vertical line, with all three real-part
conditions from the source formula. -/
-- DLMF 5.12.8 https://dlmf.nist.gov/5.12.E8
-- ANCHOR: dlmf_5_12_8_integrable
theorem dlmf_5_12_8_integrable (p : VerticalGammaQuotientDomain) :
    Integrable (betaVerticalIntegrand p)
-- ANCHOR_END: dlmf_5_12_8_integrable
  := by sorry

-- ANCHOR: dlmf_5_12_8
theorem dlmf_5_12_8 (p : VerticalGammaQuotientDomain) :
    (1 / (2 * Real.pi : ℂ)) * betaVerticalIntegral p =
      (p.w + p.z) ^ (1 - p.a - p.b) /
        ((p.a + p.b - 1) * GammaQuotientDefined.value p.beta)
-- ANCHOR_END: dlmf_5_12_8
  := by sorry

/-! ### Loop and Pochhammer forms -/

/-- DLMF 5.12.9: the vertical Barnes contour representation of the beta function. -/
-- DLMF 5.12.9 https://dlmf.nist.gov/5.12.E9
-- ANCHOR: dlmf_5_12_9_integrable
theorem dlmf_5_12_9_integrable (p : BarnesBetaDomain) :
    Integrable (betaBarnesIntegrand p)
-- ANCHOR_END: dlmf_5_12_9_integrable
  := by sorry

-- ANCHOR: dlmf_5_12_9
theorem dlmf_5_12_9 (p : BarnesBetaDomain) :
    (1 / (2 * Real.pi * Complex.I)) * betaBarnesIntegral p =
      1 / (p.b * GammaQuotientDefined.value p.beta)
-- ANCHOR_END: dlmf_5_12_9
  := by sorry

/-- DLMF 5.12.10: the first loop integral around `1`, with `Re a > 0`. -/
-- DLMF 5.12.10 https://dlmf.nist.gov/5.12.E10
-- ANCHOR: dlmf_5_12_10_integrable
theorem dlmf_5_12_10_integrable (p : FirstLoopBetaDomain) :
    betaFirstLoopContour.Integrable (betaFirstLoopIntegrand p)
-- ANCHOR_END: dlmf_5_12_10_integrable
  := by sorry

-- ANCHOR: dlmf_5_12_10
theorem dlmf_5_12_10 (p : FirstLoopBetaDomain) :
    (1 / (2 * Real.pi * Complex.I)) *
        betaFirstLoopIntegral (betaFirstLoopIntegrand p) =
        Complex.sin (Real.pi * p.b) / Real.pi * GammaQuotientDefined.value p.beta
-- ANCHOR_END: dlmf_5_12_10
  := by sorry

/-- DLMF 5.12.11: the second loop representation.  The supplied branch data are
continuous on the positive-ray tails and the circle, principal at the starting ray,
and glued at the two joins.  The source additionally assumes `Re b > 0`, `a ∉ ℤ`,
and a cut between `-1` and `0`. -/
-- DLMF 5.12.11 https://dlmf.nist.gov/5.12.E11
-- ANCHOR: dlmf_5_12_11_converges
theorem dlmf_5_12_11_converges {a b : ℂ}
    {d : SecondLoopDomain a b} (data : SecondLoopIntegralData d) :
    betaSecondLoopConverges data
-- ANCHOR_END: dlmf_5_12_11_converges
  := by sorry

-- ANCHOR: dlmf_5_12_11
theorem dlmf_5_12_11 {a b : ℂ}
    (d : SecondLoopDomain a b) (p : GammaQuotientDefined a b)
    (i : SecondLoopIntegralData d) :
    1 / (Complex.exp (2 * Real.pi * Complex.I * a) - 1) *
        betaSecondLoopIntegral i = GammaQuotientDefined.value p
-- ANCHOR_END: dlmf_5_12_11
  := by sorry

/-- DLMF 5.12.12: Pochhammer's integral for arbitrary complex `a` and `b`.  The
branch argument is continuous around all four loops and is principal at the arbitrary
base point `P ∈ (0,1)`. -/
-- DLMF 5.12.12 https://dlmf.nist.gov/5.12.E12
-- ANCHOR: dlmf_5_12_12_integrable
theorem dlmf_5_12_12_integrable {a b : ℂ} {P : ℝ}
    (branch : PochhammerLogBranch a b P) : branch.Integrable
-- ANCHOR_END: dlmf_5_12_12_integrable
  := by sorry

-- ANCHOR: dlmf_5_12_12
theorem dlmf_5_12_12 (a b : ℂ) {P : ℝ}
    (branch : PochhammerLogBranch a b P) (p : GammaQuotientDefined a b) :
    betaPochhammerIntegral branch =
      -4 * Complex.exp (Real.pi * Complex.I * (a + b)) * Complex.sin (Real.pi * a) *
        Complex.sin (Real.pi * b) * GammaQuotientDefined.value p
-- ANCHOR_END: dlmf_5_12_12
  := by sorry

end LMLF.Blueprint.Gamma.Section512
