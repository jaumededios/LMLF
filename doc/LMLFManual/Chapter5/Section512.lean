import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section512
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§5.12 Beta Function" =>
%%%
tag := "chapter-5-section-12"
%%%

The beta formulas below use typed domains and named integrals.  Following the
DLMF convention, fractional powers use principal values throughout unless E11
or E12 explicitly supplies a continuous branch lift.  E10 therefore uses
pointwise principal powers on its loop.  Convergence or finite integrability is
stated separately from each value identity.  Meromorphic values carry a
conservative Gamma-quotient guard, while branch-sensitive loops use typed
contours and continuous logarithm lifts.

:::leanStatement "Lean vocabulary · Euler beta objects"
```anchor EulerBetaDomain (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
structure EulerBetaDomain where
  a : ℂ
  b : ℂ
  a_pos : 0 < a.re
  b_pos : 0 < b.re
```
```anchor betaEulerIntegrand (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaEulerIntegrand (p : EulerBetaDomain) (t : ℝ) : ℂ :=
  (t : ℂ) ^ (p.a - 1) * (1 - (t : ℂ)) ^ (p.b - 1)
```
```anchor betaEulerIntegral (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaEulerIntegral (p : EulerBetaDomain) : ℂ :=
  ∫ t in (0 : ℝ)..1, betaEulerIntegrand p t
```
```anchor betaTrigonometricIntegrand (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaTrigonometricIntegrand (p : EulerBetaDomain) (θ : ℝ) : ℂ :=
  (Complex.sin (θ : ℂ)) ^ (2 * p.a - 1) *
    (Complex.cos (θ : ℂ)) ^ (2 * p.b - 1)
```
```anchor betaHalfLineIntegrand (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaHalfLineIntegrand (p : EulerBetaDomain) (t : ℝ) : ℂ :=
  (t : ℂ) ^ (p.a - 1) / (1 + (t : ℂ)) ^ (p.a + p.b)
```
```anchor ShiftedBetaDomain (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
structure ShiftedBetaDomain extends EulerBetaDomain where
  z : ℂ
  z_ne_zero : z ≠ 0
  arg_lt_pi : |Complex.arg z| < Real.pi
```
```anchor betaShiftedIntegrand (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaShiftedIntegrand (p : ShiftedBetaDomain) (t : ℝ) : ℂ :=
  (t : ℂ) ^ (p.a - 1) * (1 - (t : ℂ)) ^ (p.b - 1) /
    ((t : ℂ) + p.z) ^ (p.a + p.b)
```
:::

:::leanStatement "Lean vocabulary · Gamma-quotient guard"
The quotient guard below requires all three displayed Gamma factors to be
nonzero.  It is a sufficient domain for this field quotient, not an exact
description of every finite value of the meromorphic continuation.
```anchor meromorphicBeta (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def meromorphicBeta (a b : ℂ) : ℂ :=
  Complex.Gamma a * Complex.Gamma b / Complex.Gamma (a + b)
```
```anchor meromorphicBetaDefined (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
def meromorphicBetaDefined (a b : ℂ) : Prop :=
  Complex.Gamma a ≠ 0 ∧ Complex.Gamma b ≠ 0 ∧ Complex.Gamma (a + b) ≠ 0
```
```anchor GammaQuotientDefined (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
structure GammaQuotientDefined (a b : ℂ) : Type where
  gamma_ne_zero : meromorphicBetaDefined a b
```
```anchor GammaQuotientDefined.value (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def GammaQuotientDefined.value {a b : ℂ} (_p : GammaQuotientDefined a b) : ℂ :=
  meromorphicBeta a b
```
:::

:::leanStatement "Lean vocabulary · transformed domains"
```anchor HyperbolicBetaDomain (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
structure HyperbolicBetaDomain where
  a : ℂ
  b : ℂ
  abs_b_re_lt_a_re : |b.re| < a.re
```
```anchor VerticalBetaDomain (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
structure VerticalBetaDomain where
  a : ℂ
  b : ℂ
  w : ℂ
  z : ℂ
  sum_re_gt_one : 1 < (a + b).re
  w_re_pos : 0 < w.re
  z_re_pos : 0 < z.re
```
```anchor VerticalGammaQuotientDomain (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
structure VerticalGammaQuotientDomain extends VerticalBetaDomain where
  beta : GammaQuotientDefined a b
```
```anchor BarnesBetaDomain (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
structure BarnesBetaDomain where
  a : ℂ
  b : ℂ
  c : ℝ
  c_pos : 0 < c
  c_lt_one : c < 1
  sum_re_pos : 0 < (a + b).re
  b_ne_zero : b ≠ 0
  beta : GammaQuotientDefined a b
```
```anchor CosineBetaDomain (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
structure CosineBetaDomain where
  a : ℂ
  b : ℂ
  a_re_pos : 0 < a.re
  a_ne_zero : a ≠ 0
  beta : GammaQuotientDefined ((a + b + 1) / 2) ((a - b + 1) / 2)
```
```anchor FourierBetaDomain (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
structure FourierBetaDomain where
  a : ℂ
  b : ℂ
  a_re_pos : 0 < a.re
  a_ne_zero : a ≠ 0
  beta : GammaQuotientDefined ((a + b + 1) / 2) ((a - b + 1) / 2)
```
```anchor FirstLoopBetaDomain (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
structure FirstLoopBetaDomain where
  a : ℂ
  b : ℂ
  a_re_pos : 0 < a.re
  beta : GammaQuotientDefined a b
```
:::

:::leanStatement "Lean vocabulary · named transformed integrals"
```anchor betaTrigonometricIntegral (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaTrigonometricIntegral (p : EulerBetaDomain) : ℂ :=
  ∫ θ in (0 : ℝ)..(Real.pi / 2), betaTrigonometricIntegrand p θ
```
```anchor betaHalfLineIntegral (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaHalfLineIntegral (p : EulerBetaDomain) : ℂ :=
  ∫ t in Ioi (0 : ℝ), betaHalfLineIntegrand p t
```
```anchor betaShiftedIntegral (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaShiftedIntegral (p : ShiftedBetaDomain) : ℂ :=
  ∫ t in (0 : ℝ)..1, betaShiftedIntegrand p t
```
```anchor betaCosineIntegrand (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaCosineIntegrand (p : CosineBetaDomain) (t : ℝ) : ℂ :=
  (Complex.cos (t : ℂ)) ^ (p.a - 1) * Complex.cos (p.b * t)
```
```anchor betaCosineIntegral (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaCosineIntegral (p : CosineBetaDomain) : ℂ :=
  ∫ t in (0 : ℝ)..(Real.pi / 2), betaCosineIntegrand p t
```
```anchor betaSineFourierIntegrand (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaSineFourierIntegrand (p : FourierBetaDomain) (t : ℝ) : ℂ :=
  (Complex.sin (t : ℂ)) ^ (p.a - 1) * Complex.exp (Complex.I * p.b * t)
```
```anchor betaSineFourierIntegral (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaSineFourierIntegral (p : FourierBetaDomain) : ℂ :=
  ∫ t in (0 : ℝ)..Real.pi, betaSineFourierIntegrand p t
```
```anchor betaHyperbolicIntegrand (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaHyperbolicIntegrand (p : HyperbolicBetaDomain) (t : ℝ) : ℂ :=
  Complex.cosh (2 * p.b * t) / (Complex.cosh (t : ℂ)) ^ (2 * p.a)
```
```anchor betaHyperbolicIntegral (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaHyperbolicIntegral (p : HyperbolicBetaDomain) : ℂ :=
  ∫ t in Ioi (0 : ℝ), betaHyperbolicIntegrand p t
```
```anchor betaVerticalIntegrand (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaVerticalIntegrand (p : VerticalGammaQuotientDomain) (t : ℝ) : ℂ :=
  1 / ((p.w + Complex.I * t) ^ p.a * (p.z - Complex.I * t) ^ p.b)
```
```anchor betaVerticalIntegral (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaVerticalIntegral (p : VerticalGammaQuotientDomain) : ℂ :=
  ∫ t : ℝ, betaVerticalIntegrand p t
```
```anchor betaBarnesIntegrand (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaBarnesIntegrand (p : BarnesBetaDomain) (y : ℝ) : ℂ :=
  (p.c + Complex.I * y) ^ (-p.a) *
    (1 - (p.c + Complex.I * y)) ^ (-1 - p.b) * Complex.I
```
```anchor betaBarnesIntegral (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaBarnesIntegral (p : BarnesBetaDomain) : ℂ :=
  ∫ y : ℝ, betaBarnesIntegrand p y
```
:::

:::leanStatement "Lean vocabulary · coherent second-loop branch"
```anchor SecondLoopLogBranch (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
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
```
:::

:::leanStatement "Lean vocabulary · second-loop truncation and limit"
```anchor betaSecondLoopTruncation (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
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
```
```anchor betaSecondLoopFamily (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaSecondLoopFamily {a b : ℂ}
    (branch : SecondLoopLogBranch a b) (R : ℝ) : ℂ :=
  if hR : 1 < R then betaSecondLoopTruncation branch R hR else 0
```
```anchor SecondLoopDomain (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
structure SecondLoopDomain (a b : ℂ) where
  branch : SecondLoopLogBranch a b
  b_re_pos : 0 < b.re
  a_not_integer : ∀ n : ℤ, a ≠ n
  cutPoint : ℝ
  cut_between : -1 < cutPoint ∧ cutPoint < 0
```
```anchor SecondLoopIntegralData (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
structure SecondLoopIntegralData {a b : ℂ} (d : SecondLoopDomain a b) where
  value : ℂ
  converges : Tendsto (betaSecondLoopFamily d.branch) atTop (𝓝 value)
```
```anchor betaSecondLoopIntegral (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaSecondLoopIntegral {a b : ℂ} {d : SecondLoopDomain a b}
    (data : SecondLoopIntegralData d) : ℂ := data.value
```
```anchor canonicalSecondLoopLogBranch (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
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
```
:::

:::leanStatement "Lean vocabulary · Pochhammer branch and integral"
The shared Chapter 3 `PiecewiseC1Contour` API supplies the finite break set,
continuity at joins, endpoint compatibility, and piecewise tangent laws. Its
two-log integral and integrability combinators are used below.
```anchor betaPochhammerCurve (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
def betaPochhammerCurve (P : ℝ) : ℝ → ℂ := fun u ↦
  if u ≤ 1 / 4 then 1 + (1 - (P : ℂ)) *
      Complex.exp ((Real.pi + 8 * Real.pi * (u : ℂ)) * Complex.I)
  else if u ≤ 1 / 2 then (P : ℂ) *
      Complex.exp (8 * Real.pi * ((u - 1 / 4 : ℝ) : ℂ) * Complex.I)
  else if u ≤ 3 / 4 then 1 + (1 - (P : ℂ)) *
      Complex.exp ((Real.pi - 8 * Real.pi * ((u - 1 / 2 : ℝ) : ℂ)) * Complex.I)
  else (P : ℂ) * Complex.exp (-8 * Real.pi * ((u - 3 / 4 : ℝ) : ℂ) * Complex.I)
```
```anchor PochhammerLogBranch (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
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
```
```anchor betaPochhammerIntegral (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaPochhammerIntegral {a b : ℂ} {P : ℝ}
    (branch : PochhammerLogBranch a b P) : ℂ :=
  branch.contour.integral₂
    (fun _ logT logOneMinusT =>
      Complex.exp ((a - 1) * logT) * Complex.exp ((b - 1) * logOneMinusT))
    branch.logT branch.logOneMinusT
```
```anchor PochhammerLogBranch.Integrable (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
def PochhammerLogBranch.Integrable {a b : ℂ} {P : ℝ}
    (branch : PochhammerLogBranch a b P) : Prop :=
  branch.contour.Integrable₂
    (fun _ logT logOneMinusT =>
      Complex.exp ((a - 1) * logT) * Complex.exp ((b - 1) * logOneMinusT))
    branch.logT branch.logOneMinusT
```
:::

::::dlmfEntry "5.12.1" "https://dlmf.nist.gov/5.12.E1"
For `Re a>0` and `Re b>0`, $$`\mathrm{B}(a,b)=\int_0^1t^{a-1}(1-t)^{b-1}\,dt=\frac{\Gamma(a)\Gamma(b)}{\Gamma(a+b)}.`

The typed domain carries convergence hypotheses.
:::leanStatement "Euler convergence"
```anchor dlmf_5_12_1_integrable (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_1_integrable (p : EulerBetaDomain) :
    IntervalIntegrable (betaEulerIntegrand p) volume 0 1
```
:::
:::leanStatement "Euler value"
```anchor dlmf_5_12_1 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_1 (p : EulerBetaDomain) :
    betaEulerIntegral p = meromorphicBeta p.a p.b
```
:::
:::leanStatement "Euler integral object"
```anchor dlmf_5_12_1_euler (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_1_euler (p : EulerBetaDomain) :
    Complex.betaIntegral p.a p.b = betaEulerIntegral p
```
:::
::::

::::dlmfEntry "5.12.2" "https://dlmf.nist.gov/5.12.E2"
$$`\int_0^{\pi/2}\sin^{2a-1}\theta\cos^{2b-1}\theta\,d\theta=\tfrac12\mathrm{B}(a,b).`
:::leanStatement "Trigonometric convergence"
```anchor dlmf_5_12_2_integrable (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_2_integrable (p : EulerBetaDomain) :
    IntervalIntegrable (betaTrigonometricIntegrand p) volume 0 (Real.pi / 2)
```
:::
:::leanStatement "Trigonometric value"
```anchor dlmf_5_12_2 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_2 (p : EulerBetaDomain) :
    betaTrigonometricIntegral p = Complex.betaIntegral p.a p.b / 2
```
:::
::::

::::dlmfEntry "5.12.3" "https://dlmf.nist.gov/5.12.E3"
$$`\int_0^\infty\frac{t^{a-1}}{(1+t)^{a+b}}\,dt=\mathrm{B}(a,b).`
:::leanStatement "Half-line convergence"
```anchor dlmf_5_12_3_integrable (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_3_integrable (p : EulerBetaDomain) :
    IntegrableOn (betaHalfLineIntegrand p) (Ioi 0)
```
:::
:::leanStatement "Half-line value"
```anchor dlmf_5_12_3 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_3 (p : EulerBetaDomain) :
    betaHalfLineIntegral p = Complex.betaIntegral p.a p.b
```
:::
::::

::::dlmfEntry "5.12.4" "https://dlmf.nist.gov/5.12.E4"
For `|ph z|<π`, $$`\int_0^1\frac{t^{a-1}(1-t)^{b-1}}{(t+z)^{a+b}}\,dt=\mathrm{B}(a,b)(1+z)^{-a}z^{-b}.`
`ShiftedBetaDomain` stores the phase and nonzero-shift conditions.
:::leanStatement "Shifted convergence"
```anchor dlmf_5_12_4_integrable (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_4_integrable (p : ShiftedBetaDomain) :
    IntervalIntegrable (betaShiftedIntegrand p) volume 0 1
```
:::
:::leanStatement "Shifted value"
```anchor dlmf_5_12_4 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_4 (p : ShiftedBetaDomain) :
    betaShiftedIntegral p =
      Complex.betaIntegral p.a p.b * (1 + p.z) ^ (-p.a) * p.z ^ (-p.b)
```
:::
::::

::::dlmfEntry "5.12.5" "https://dlmf.nist.gov/5.12.E5"
For `Re a>0`, $$`\int_0^{\pi/2}(\cos t)^{a-1}\cos(bt)\,dt=\frac{\pi}{2^a}\frac{1}{a\mathrm{B}((a+b+1)/2,(a-b+1)/2)}.`
`CosineBetaDomain` stores `a≠0` and a `GammaQuotientDefined` transformed beta value.
:::leanStatement "Cosine convergence and value"
```anchor dlmf_5_12_5_integrable (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_5_integrable (p : CosineBetaDomain) :
    IntervalIntegrable (betaCosineIntegrand p) volume 0 (Real.pi / 2)
```
```anchor dlmf_5_12_5 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_5 (p : CosineBetaDomain) :
    betaCosineIntegral p =
      Real.pi / (2 : ℂ) ^ p.a / (p.a * GammaQuotientDefined.value p.beta)
```
:::
::::

::::dlmfEntry "5.12.6" "https://dlmf.nist.gov/5.12.E6"
For `Re a>0`, $$`\int_0^\pi(\sin t)^{a-1}e^{ibt}\,dt=\frac{\pi}{2^{a-1}}\frac{e^{i\pi b/2}}{a\mathrm{B}((a+b+1)/2,(a-b+1)/2)}.`
`FourierBetaDomain` stores a `GammaQuotientDefined` transformed beta value.
:::leanStatement "Fourier convergence and value"
```anchor dlmf_5_12_6_integrable (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_6_integrable (p : FourierBetaDomain) :
    IntervalIntegrable (betaSineFourierIntegrand p) volume 0 Real.pi
```
```anchor dlmf_5_12_6 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_6 (p : FourierBetaDomain) :
    betaSineFourierIntegral p =
      Real.pi / (2 : ℂ) ^ (p.a - 1) * Complex.exp (Complex.I * Real.pi * p.b / 2) /
        (p.a * GammaQuotientDefined.value p.beta)
```
:::
::::

::::dlmfEntry "5.12.7" "https://dlmf.nist.gov/5.12.E7"
For `Re a>|Re b|`, $$`\int_0^\infty\frac{\cosh(2bt)}{(\cosh t)^{2a}}\,dt=4^{a-1}\mathrm{B}(a+b,a-b).`
:::leanStatement "Hyperbolic convergence and value"
```anchor dlmf_5_12_7_integrable (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_7_integrable (p : HyperbolicBetaDomain) :
    IntegrableOn (betaHyperbolicIntegrand p) (Ioi 0)
```
```anchor dlmf_5_12_7 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_7 (p : HyperbolicBetaDomain) :
    betaHyperbolicIntegral p =
      (4 : ℂ) ^ (p.a - 1) * Complex.betaIntegral (p.a + p.b) (p.a - p.b)
```
:::
::::

::::dlmfEntry "5.12.8" "https://dlmf.nist.gov/5.12.E8"
For `Re(a+b)>1`, `Re w>0`, and `Re z>0`, $$`\frac1{2\pi}\int_{-\infty}^{\infty}\frac{dt}{(w+it)^a(z-it)^b}=\frac{(w+z)^{1-a-b}}{(a+b-1)\mathrm{B}(a,b)}.`
:::leanStatement "Vertical convergence and value"
```anchor dlmf_5_12_8_integrable (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_8_integrable (p : VerticalGammaQuotientDomain) :
    Integrable (betaVerticalIntegrand p)
```
```anchor dlmf_5_12_8 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_8 (p : VerticalGammaQuotientDomain) :
    (1 / (2 * Real.pi : ℂ)) * betaVerticalIntegral p =
      (p.w + p.z) ^ (1 - p.a - p.b) /
        ((p.a + p.b - 1) * GammaQuotientDefined.value p.beta)
```
:::
::::

::::dlmfEntry "5.12.9" "https://dlmf.nist.gov/5.12.E9"
For `0<c<1` and `Re(a+b)>0`, $$`\frac1{2\pi i}\int_{c-i\infty}^{c+i\infty}t^{-a}(1-t)^{-1-b}\,dt=\frac1{b\mathrm{B}(a,b)}.`
:::leanStatement "Barnes convergence and value"
```anchor dlmf_5_12_9_integrable (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_9_integrable (p : BarnesBetaDomain) :
    Integrable (betaBarnesIntegrand p)
```
```anchor dlmf_5_12_9 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_9 (p : BarnesBetaDomain) :
    (1 / (2 * Real.pi * Complex.I)) * betaBarnesIntegral p =
      1 / (p.b * GammaQuotientDefined.value p.beta)
```
:::
::::

::::dlmfEntry "5.12.10" "https://dlmf.nist.gov/5.12.E10"
For `Re a>0`, $$`\frac1{2\pi i}\int_0^{(1+)}t^{a-1}(t-1)^{b-1}\,dt=\frac{\sin(\pi b)}\pi\mathrm{B}(a,b).`
The positively oriented loop begins at `t=0`, circles `1` once counterclockwise,
and returns to its starting point.  It is represented by
the shared `C1Contour` object with a stored tangent; its fractional powers are
the pointwise principal values prescribed by DLMF.
:::leanStatement "First-loop contour and integrand"
```anchor betaFirstLoopContour (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
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
```
```anchor betaFirstLoopIntegral (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaFirstLoopIntegral (f : ℂ → ℂ) : ℂ :=
  betaFirstLoopContour.integral f
```
```anchor betaFirstLoopIntegrand (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaFirstLoopIntegrand (p : FirstLoopBetaDomain) (t : ℂ) : ℂ :=
  t ^ (p.a - 1) * (t - 1) ^ (p.b - 1)
```
```anchor dlmf_5_12_10_integrable (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_10_integrable (p : FirstLoopBetaDomain) :
    betaFirstLoopContour.Integrable (betaFirstLoopIntegrand p)
```
```anchor dlmf_5_12_10 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_10 (p : FirstLoopBetaDomain) :
    (1 / (2 * Real.pi * Complex.I)) *
        betaFirstLoopIntegral (betaFirstLoopIntegrand p) =
        Complex.sin (Real.pi * p.b) / Real.pi * GammaQuotientDefined.value p.beta
```
:::
::::

::::dlmfEntry "5.12.11" "https://dlmf.nist.gov/5.12.E11"
When `Re b>0` and `a` is not an integer, $$`\frac1{e^{2\pi ia}-1}\int_\infty^{(0+)}t^{a-1}(1+t)^{-a-b}\,dt=\mathrm{B}(a,b).`  The path runs from
`+∞` down the positive ray to `0`, follows the positively oriented small
circle about `0`, and then returns from `0` to `+∞` on the outgoing ray.
The coherent logarithm-lift branch, canonical truncation, and improper integral are defined before these two statements.
:::leanStatement "Second-loop convergence and value"
```anchor betaSecondLoopConverges (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
def betaSecondLoopConverges {a b : ℂ} {d : SecondLoopDomain a b}
    (data : SecondLoopIntegralData d) : Prop :=
  Tendsto (betaSecondLoopFamily d.branch) atTop (𝓝 data.value)
```
```anchor dlmf_5_12_11_converges (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_11_converges {a b : ℂ}
    {d : SecondLoopDomain a b} (data : SecondLoopIntegralData d) :
    betaSecondLoopConverges data
```
```anchor dlmf_5_12_11 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_11 {a b : ℂ}
    (d : SecondLoopDomain a b) (p : GammaQuotientDefined a b)
    (i : SecondLoopIntegralData d) :
    1 / (Complex.exp (2 * Real.pi * Complex.I * a) - 1) *
        betaSecondLoopIntegral i = GammaQuotientDefined.value p
```
:::
::::

::::dlmfEntry "5.12.12" "https://dlmf.nist.gov/5.12.E12"
For arbitrary `a,b∈ℂ`, $$`\int_P^{(1+,0+,1-,0-)}t^{a-1}(1-t)^{b-1}\,dt=-4e^{\pi i(a+b)}\sin(\pi a)\sin(\pi b)\mathrm{B}(a,b).`
The global convention is principal values for fractional powers.  E11 uses a cut on the real
axis between `-1` and `0`, with powers principal on the initial positive ray; its circle winds
once around `0`, so the outgoing `t` logarithm carries `+2πi` while the `1+t` logarithm returns
to its principal value.  E12 starts at arbitrary `P∈(0,1)`, traverses the loops `(1+,0+,1-,0-)`,
and returns to `P`; both logarithm lifts are continuous along that piecewise-C¹ contour.
:::leanStatement "Pochhammer convergence and value"
```anchor dlmf_5_12_12_integrable (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_12_integrable {a b : ℂ} {P : ℝ}
    (branch : PochhammerLogBranch a b P) : branch.Integrable
```
```anchor dlmf_5_12_12 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_12 (a b : ℂ) {P : ℝ}
    (branch : PochhammerLogBranch a b P) (p : GammaQuotientDefined a b) :
    betaPochhammerIntegral branch =
      -4 * Complex.exp (Real.pi * Complex.I * (a + b)) * Complex.sin (Real.pi * a) *
        Complex.sin (Real.pi * b) * GammaQuotientDefined.value p
```
:::
::::
