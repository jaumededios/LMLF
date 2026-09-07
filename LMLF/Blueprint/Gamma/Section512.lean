import Mathlib.Analysis.SpecialFunctions.Gamma.Beta
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic

open Filter MeasureTheory Set
open scoped Interval Topology

noncomputable section

namespace LMLF.Blueprint.Gamma.Section512

/-! ### Meromorphic beta continuation -/

/-- DLMF 5.12.5–5.12.6 and 5.12.8–5.12.12: the meromorphic beta function represented
by its Gamma quotient.  This is deliberately separate from Mathlib's
`Complex.betaIntegral`, whose definition is the convergent interval Euler integral. -/
-- ANCHOR: meromorphicBeta
noncomputable def meromorphicBeta (a b : ℂ) : ℂ :=
  Complex.Gamma a * Complex.Gamma b / Complex.Gamma (a + b)
-- ANCHOR_END: meromorphicBeta

/-- DLMF 5.12.5–5.12.6 and 5.12.8–5.12.12: the finite meromorphic-beta locus used by
the displayed identities.  The
Gamma quotient is then evaluated away from all three Gamma poles; this prevents Lean's
totalized field division from being mistaken for a value at a pole. -/
-- ANCHOR: meromorphicBetaDefined
def meromorphicBetaDefined (a b : ℂ) : Prop :=
  Complex.Gamma a ≠ 0 ∧ Complex.Gamma b ≠ 0 ∧ Complex.Gamma (a + b) ≠ 0
-- ANCHOR_END: meromorphicBetaDefined

/-! ### Contour vocabulary for the loop formulas -/

/-- DLMF 5.12.10–5.12.12: a parametrized complex contour integral, with the
parameter interval normalized to `[0, 1]`.

The curve is differentiated in the ordinary complex sense whenever the integral is used.
This definition exposes the integrand and the oriented curve rather than hiding a contour
identity behind an opaque proposition.
-/
-- ANCHOR: contourIntegral
noncomputable def contourIntegral (f : ℂ → ℂ) (curve : ℝ → ℂ) : ℂ :=
  ∫ u in (0 : ℝ)..1, f (curve u) * deriv curve u
-- ANCHOR_END: contourIntegral

/-- DLMF 5.12.10: the normalized positively oriented loop about `1` used for
the first beta loop formula.

The associated source notation is `∫₀^(1+)`; E10 uses the source's pointwise principal
values on this loop.
-/
-- ANCHOR: betaFirstLoopIntegral
noncomputable def betaFirstLoopIntegral (f : ℂ → ℂ) : ℂ :=
  contourIntegral f (fun u : ℝ ↦
    1 + Complex.exp ((Real.pi + 2 * Real.pi * (u : ℂ)) * Complex.I))
-- ANCHOR_END: betaFirstLoopIntegral

/-- DLMF 5.12.11: one coherent pair of logarithm lifts for the whole incoming ray,
the shrinking circle, and the outgoing ray.  Every finite truncation is obtained by
restriction of this single datum, so branch choices cannot vary with `R`. -/
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
  outgoing_t_starts : ∀ ε : ℝ, 0 < ε → ε < 1 →
    logTOutgoing ε = logTCircle ε (2 * Real.pi)
  outgoing_one_starts : ∀ ε : ℝ, 0 < ε → ε < 1 →
    logOnePlusOutgoing ε = logOnePlusCircle ε (2 * Real.pi)
-- ANCHOR_END: SecondLoopLogBranch
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

/-- DLMF 5.12.11: the improper limit of the finite loop truncations, obtained by
restricting one coherent logarithm-lift datum to each canonical scale `ε = 1 / R`. -/
-- ANCHOR: betaSecondLoopIntegral
noncomputable def betaSecondLoopIntegral {a b : ℂ}
    (branch : SecondLoopLogBranch a b) : ℂ :=
  Filter.limUnder atTop (fun R : ℝ ↦
    if hR : 1 < R then betaSecondLoopTruncation branch R hR else 0)
-- ANCHOR_END: betaSecondLoopIntegral

/-- DLMF 5.12.12: the Pochhammer contour with base point `P ∈ (0,1)`, positive loops
around `1` and `0`, followed by negative loops around `1` and `0`. -/
def betaPochhammerCurve (P : ℝ) : ℝ → ℂ := fun u ↦
  if u ≤ 1 / 4 then 1 + (1 - (P : ℂ)) *
      Complex.exp ((Real.pi + 8 * Real.pi * (u : ℂ)) * Complex.I)
  else if u ≤ 1 / 2 then (P : ℂ) *
      Complex.exp (8 * Real.pi * ((u - 1 / 4 : ℝ) : ℂ) * Complex.I)
  else if u ≤ 3 / 4 then 1 + (1 - (P : ℂ)) *
      Complex.exp ((Real.pi - 8 * Real.pi * ((u - 1 / 2 : ℝ) : ℂ)) * Complex.I)
  else (P : ℂ) * Complex.exp (-8 * Real.pi * ((u - 3 / 4 : ℝ) : ℂ) * Complex.I)

/-- DLMF 5.12.12: logarithm lifts tied pointwise to the Pochhammer contour and its
`1 - t` companion.  Both lifts are continuous and principal at the base point. -/
-- ANCHOR: PochhammerLogBranch
structure PochhammerLogBranch (a b : ℂ) (P : ℝ) where
  logT : ℝ → ℂ
  logOneMinusT : ℝ → ℂ
  t_continuous : ContinuousOn logT (Icc 0 1)
  one_minus_t_continuous : ContinuousOn logOneMinusT (Icc 0 1)
  t_exp : ∀ u : ℝ, 0 < P → P < 1 →
    Complex.exp (logT u) = betaPochhammerCurve P u
  one_minus_t_exp : ∀ u : ℝ, 0 < P → P < 1 →
    Complex.exp (logOneMinusT u) = 1 - betaPochhammerCurve P u
  t_principal_at_start : 0 < P → P < 1 → logT 0 = Complex.log (P : ℂ)
  one_minus_t_principal_at_start : 0 < P → P < 1 →
    logOneMinusT 0 = Complex.log (1 - (P : ℂ))
-- ANCHOR_END: PochhammerLogBranch

-- ANCHOR: betaPochhammerIntegral
noncomputable def betaPochhammerIntegral {a b : ℂ} {P : ℝ}
    (branch : PochhammerLogBranch a b P) : ℂ :=
  ∫ u in (0 : ℝ)..1,
    (Complex.exp ((a - 1) * branch.logT u) *
      Complex.exp ((b - 1) * branch.logOneMinusT u)) * deriv (betaPochhammerCurve P) u
-- ANCHOR_END: betaPochhammerIntegral

/-! ### Euler's beta integral and its transformations -/

/-- DLMF 5.12.1: Euler's beta integral and the Gamma quotient. -/
-- DLMF 5.12.1 https://dlmf.nist.gov/5.12.E1
-- ANCHOR: dlmf_5_12_1
theorem dlmf_5_12_1 {a b : ℂ} (ha : 0 < a.re) (hb : 0 < b.re) :
    Complex.betaIntegral a b =
        ∫ t in (0 : ℝ)..1, (t : ℂ) ^ (a - 1) * (1 - (t : ℂ)) ^ (b - 1) ∧
      Complex.betaIntegral a b = Complex.Gamma a * Complex.Gamma b / Complex.Gamma (a + b)
-- ANCHOR_END: dlmf_5_12_1
  := by sorry

/-- DLMF 5.12.2: the trigonometric form of Euler's beta integral. -/
-- DLMF 5.12.2 https://dlmf.nist.gov/5.12.E2
-- ANCHOR: dlmf_5_12_2
theorem dlmf_5_12_2 {a b : ℂ} (ha : 0 < a.re) (hb : 0 < b.re) :
    IntervalIntegrable
        (fun θ : ℝ ↦ (Complex.sin (θ : ℂ)) ^ (2 * a - 1) *
          (Complex.cos (θ : ℂ)) ^ (2 * b - 1)) volume 0 (Real.pi / 2) ∧
      (∫ θ in (0 : ℝ)..(Real.pi / 2),
          (Complex.sin (θ : ℂ)) ^ (2 * a - 1) *
            (Complex.cos (θ : ℂ)) ^ (2 * b - 1)) = Complex.betaIntegral a b / 2
-- ANCHOR_END: dlmf_5_12_2
  := by sorry

/-- DLMF 5.12.3: the beta integral on the positive half-line. -/
-- DLMF 5.12.3 https://dlmf.nist.gov/5.12.E3
-- ANCHOR: dlmf_5_12_3
theorem dlmf_5_12_3 {a b : ℂ} (ha : 0 < a.re) (hb : 0 < b.re) :
    IntegrableOn
        (fun t : ℝ ↦ (t : ℂ) ^ (a - 1) / (1 + (t : ℂ)) ^ (a + b)) (Ioi 0) ∧
      (∫ t in Ioi (0 : ℝ), (t : ℂ) ^ (a - 1) / (1 + (t : ℂ)) ^ (a + b)) =
        Complex.betaIntegral a b
-- ANCHOR_END: dlmf_5_12_3
  := by sorry

/-- DLMF 5.12.4: the shifted beta integral, with the principal phase condition on `z`. -/
-- DLMF 5.12.4 https://dlmf.nist.gov/5.12.E4
-- ANCHOR: dlmf_5_12_4
theorem dlmf_5_12_4 {a b z : ℂ} (ha : 0 < a.re) (hb : 0 < b.re)
    (hz0 : z ≠ 0) (hz : |Complex.arg z| < Real.pi) :
    IntervalIntegrable
        (fun t : ℝ ↦ (t : ℂ) ^ (a - 1) * (1 - (t : ℂ)) ^ (b - 1) /
          ((t : ℂ) + z) ^ (a + b)) volume 0 1 ∧
      (∫ t in (0 : ℝ)..1,
          (t : ℂ) ^ (a - 1) * (1 - (t : ℂ)) ^ (b - 1) /
            ((t : ℂ) + z) ^ (a + b)) =
        Complex.betaIntegral a b * (1 + z) ^ (-a) * z ^ (-b)
-- ANCHOR_END: dlmf_5_12_4
  := by sorry

/-! ### Trigonometric and hyperbolic forms -/

/-- DLMF 5.12.5: a cosine-power integral on `[0, π/2]`. -/
-- DLMF 5.12.5 https://dlmf.nist.gov/5.12.E5
-- ANCHOR: dlmf_5_12_5
theorem dlmf_5_12_5 {a b : ℂ} (ha : 0 < a.re) (ha0 : a ≠ 0)
    (hβ : meromorphicBetaDefined ((a + b + 1) / 2) ((a - b + 1) / 2)) :
    IntervalIntegrable
        (fun t : ℝ ↦ (Complex.cos (t : ℂ)) ^ (a - 1) * Complex.cos (b * t)) volume 0
          (Real.pi / 2) ∧
      (∫ t in (0 : ℝ)..(Real.pi / 2),
          (Complex.cos (t : ℂ)) ^ (a - 1) * Complex.cos (b * t)) =
        Real.pi / (2 : ℂ) ^ a /
          (a * meromorphicBeta ((a + b + 1) / 2) ((a - b + 1) / 2))
-- ANCHOR_END: dlmf_5_12_5
  := by sorry

/-- DLMF 5.12.6: the exponential Fourier form over `[0, π]`. -/
-- DLMF 5.12.6 https://dlmf.nist.gov/5.12.E6
-- ANCHOR: dlmf_5_12_6
theorem dlmf_5_12_6 {a b : ℂ} (ha : 0 < a.re) (ha0 : a ≠ 0)
    (hβ : meromorphicBetaDefined ((a + b + 1) / 2) ((a - b + 1) / 2)) :
    IntervalIntegrable
        (fun t : ℝ ↦ (Complex.sin (t : ℂ)) ^ (a - 1) * Complex.exp (Complex.I * b * t)) volume 0
          Real.pi ∧
      (∫ t in (0 : ℝ)..Real.pi,
          (Complex.sin (t : ℂ)) ^ (a - 1) * Complex.exp (Complex.I * b * t)) =
        Real.pi / (2 : ℂ) ^ (a - 1) * Complex.exp (Complex.I * Real.pi * b / 2) /
          (a * meromorphicBeta ((a + b + 1) / 2) ((a - b + 1) / 2))
-- ANCHOR_END: dlmf_5_12_6
  := by sorry

/-- DLMF 5.12.7: the hyperbolic-cosine integral, convergent when
`Re a > |Re b|`. -/
-- DLMF 5.12.7 https://dlmf.nist.gov/5.12.E7
-- ANCHOR: dlmf_5_12_7
theorem dlmf_5_12_7 {a b : ℂ} (hab : |b.re| < a.re) :
    IntegrableOn
        (fun t : ℝ ↦ Complex.cosh (2 * b * t) / (Complex.cosh (t : ℂ)) ^ (2 * a)) (Ioi 0) ∧
      (∫ t in Ioi (0 : ℝ),
          Complex.cosh (2 * b * t) / (Complex.cosh (t : ℂ)) ^ (2 * a)) =
        (4 : ℂ) ^ (a - 1) * Complex.betaIntegral (a + b) (a - b)
-- ANCHOR_END: dlmf_5_12_7
  := by sorry

/-- DLMF 5.12.8: the Fourier integral on a vertical line, with all three real-part
conditions from the source formula. -/
-- DLMF 5.12.8 https://dlmf.nist.gov/5.12.E8
-- ANCHOR: dlmf_5_12_8
theorem dlmf_5_12_8 {a b w z : ℂ} (hab : 1 < (a + b).re) (hw : 0 < w.re) (hz : 0 < z.re)
    (hβ : meromorphicBetaDefined a b) :
    Integrable
        (fun t : ℝ ↦ 1 / ((w + Complex.I * t) ^ a * (z - Complex.I * t) ^ b)) ∧
      (1 / (2 * Real.pi : ℂ)) *
          (∫ t : ℝ, 1 / ((w + Complex.I * t) ^ a * (z - Complex.I * t) ^ b)) =
        (w + z) ^ (1 - a - b) /
          ((a + b - 1) * meromorphicBeta a b)
-- ANCHOR_END: dlmf_5_12_8
  := by sorry

/-! ### Loop and Pochhammer forms -/

/-- DLMF 5.12.9: the vertical Barnes contour representation of the beta function. -/
-- DLMF 5.12.9 https://dlmf.nist.gov/5.12.E9
-- ANCHOR: dlmf_5_12_9
theorem dlmf_5_12_9 {a b : ℂ} {c : ℝ} (hc0 : 0 < c) (hc1 : c < 1)
    (hab : 0 < (a + b).re) (hb0 : b ≠ 0) (hβ : meromorphicBetaDefined a b) :
    Integrable
        (fun y : ℝ ↦ (c + Complex.I * y) ^ (-a) *
          (1 - (c + Complex.I * y)) ^ (-1 - b) * Complex.I) ∧
      (1 / (2 * Real.pi * Complex.I)) *
          (∫ y : ℝ, (c + Complex.I * y) ^ (-a) *
            (1 - (c + Complex.I * y)) ^ (-1 - b) * Complex.I) =
        1 / (b * meromorphicBeta a b)
-- ANCHOR_END: dlmf_5_12_9
  := by sorry

/-- DLMF 5.12.10: the first loop integral around `1`, with `Re a > 0`. -/
-- DLMF 5.12.10 https://dlmf.nist.gov/5.12.E10
-- ANCHOR: dlmf_5_12_10
theorem dlmf_5_12_10 {a b : ℂ} (ha : 0 < a.re)
    (hβ : meromorphicBetaDefined a b) :
    (1 / (2 * Real.pi * Complex.I)) *
        betaFirstLoopIntegral (fun t : ℂ ↦ t ^ (a - 1) * (t - 1) ^ (b - 1)) =
        Complex.sin (Real.pi * b) / Real.pi * meromorphicBeta a b
-- ANCHOR_END: dlmf_5_12_10
  := by sorry

/-- DLMF 5.12.11: the second loop representation.  The supplied branch data are
continuous on the positive-ray tails and the circle, principal at the starting ray,
and glued at the two joins.  The source additionally assumes `Re b > 0`, `a ∉ ℤ`,
and a cut between `-1` and `0`. -/
-- DLMF 5.12.11 https://dlmf.nist.gov/5.12.E11
-- ANCHOR: dlmf_5_12_11
theorem dlmf_5_12_11 {a b : ℂ}
    (branch : SecondLoopLogBranch a b)
    (hb : 0 < b.re) (ha : ∀ n : ℤ, a ≠ n) (hβ : meromorphicBetaDefined a b) :
    1 / (Complex.exp (2 * Real.pi * Complex.I * a) - 1) *
        betaSecondLoopIntegral branch = meromorphicBeta a b
-- ANCHOR_END: dlmf_5_12_11
  := by sorry

/-- DLMF 5.12.12: Pochhammer's integral for arbitrary complex `a` and `b`.  The
branch argument is continuous around all four loops and is principal at the arbitrary
base point `P ∈ (0,1)`. -/
-- DLMF 5.12.12 https://dlmf.nist.gov/5.12.E12
-- ANCHOR: dlmf_5_12_12
theorem dlmf_5_12_12 (a b : ℂ) {P : ℝ}
    (hP0 : 0 < P) (hP1 : P < 1) (branch : PochhammerLogBranch a b P)
    (hβ : meromorphicBetaDefined a b) :
    betaPochhammerIntegral branch =
      -4 * Complex.exp (Real.pi * Complex.I * (a + b)) * Complex.sin (Real.pi * a) *
        Complex.sin (Real.pi * b) * meromorphicBeta a b
-- ANCHOR_END: dlmf_5_12_12
  := by sorry

end LMLF.Blueprint.Gamma.Section512
