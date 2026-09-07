import Mathlib.MeasureTheory.Integral.CurveIntegral.Basic

/-!
# Complex contour integrals

Reader-facing parameterized complex contours, including piecewise contours
whose integrands use a continuous logarithm selected along each piece.
-/

open Filter MeasureTheory Set
open scoped Interval Topology

noncomputable section

namespace LMLF.Integral

/-- A continuously differentiable complex contour parameterized by `[0, 1]`.
The tangent is stored explicitly, so integration never uses a totalized ambient
derivative at an endpoint. -/
-- ANCHOR: C1Contour
structure C1Contour where
  point : ℝ → ℂ
  tangent : ℝ → ℂ
  start : ℂ
  finish : ℂ
  point_zero : point 0 = start
  point_one : point 1 = finish
  hasDeriv : ∀ t ∈ Icc (0 : ℝ) 1,
    HasDerivWithinAt point (tangent t) (Icc 0 1) t
  tangent_continuous : ContinuousOn tangent (Icc 0 1)
-- ANCHOR_END: C1Contour

instance : CoeFun C1Contour (fun _ => ℝ → ℂ) :=
  ⟨C1Contour.point⟩

/-- The contour integral `∫ f(γ(t)) dγ(t)` on `[0, 1]`. -/
-- ANCHOR: C1Contour.integral
def C1Contour.integral (γ : C1Contour) (f : ℂ → ℂ) : ℂ :=
  ∫ t in (0 : ℝ)..1, f (γ t) * γ.tangent t
-- ANCHOR_END: C1Contour.integral

/-- The integrand is integrable along the finite contour. -/
-- ANCHOR: C1Contour.Integrable
def C1Contour.Integrable (γ : C1Contour) (f : ℂ → ℂ) : Prop :=
  IntervalIntegrable (fun t => f (γ t) * γ.tangent t) volume 0 1
-- ANCHOR_END: C1Contour.Integrable

/-! A piecewise C¹ contour keeps the path continuous at its finite joins while
allowing the tangent to jump there.  The finite break set and its interval
membership make the piece decomposition explicit; the endpoint equations are
the compatibility laws used by concatenated contour formulas. -/

/-- DLMF 5.12.12: a continuous piecewise-C¹ complex contour on `[0,1]`.

The finite break set records all possible tangent jumps.  Away from it, the
stored tangent is the derivative and is continuous on each remaining piece. -/
-- ANCHOR: PiecewiseC1Contour
structure PiecewiseC1Contour where
  point : ℝ → ℂ
  tangent : ℝ → ℂ
  start : ℂ
  finish : ℂ
  breaks : Finset ℝ
  breaks_mem : ∀ t ∈ breaks, t ∈ Icc (0 : ℝ) 1
  point_zero : point 0 = start
  point_one : point 1 = finish
  point_continuous : ContinuousOn point (Icc (0 : ℝ) 1)
  hasDerivOffBreaks : ∀ t ∈ Icc (0 : ℝ) 1, t ∉ breaks →
    HasDerivAt point (tangent t) t
  tangent_continuous_off_breaks :
    ContinuousOn tangent (Icc (0 : ℝ) 1 \ (breaks : Set ℝ))
-- ANCHOR_END: PiecewiseC1Contour

/-- DLMF 5.12.12: integrate a two-branch integrand on a piecewise-C¹ contour. -/
-- ANCHOR: PiecewiseC1Contour.integral₂
def PiecewiseC1Contour.integral₂ (γ : PiecewiseC1Contour)
    (f : ℂ → ℂ → ℂ → ℂ) (log₁ log₂ : ℝ → ℂ) : ℂ :=
  ∫ t in (0 : ℝ)..1, f (γ.point t) (log₁ t) (log₂ t) * γ.tangent t
-- ANCHOR_END: PiecewiseC1Contour.integral₂

/-- DLMF 5.12.12: branch-aware integrability on a piecewise-C¹ contour. -/
-- ANCHOR: PiecewiseC1Contour.Integrable₂
def PiecewiseC1Contour.Integrable₂ (γ : PiecewiseC1Contour)
    (f : ℂ → ℂ → ℂ → ℂ) (log₁ log₂ : ℝ → ℂ) : Prop :=
  IntervalIntegrable
    (fun t => f (γ.point t) (log₁ t) (log₂ t) * γ.tangent t) volume 0 1
-- ANCHOR_END: PiecewiseC1Contour.Integrable₂

/-! A vertical line is a reusable contour object rather than a section-local
parameterization.  The whole-line and symmetric finite-segment interfaces are
kept distinct: the former is an ordinary Bochner integral, while the latter is
the ordered finite-cutoff interface used by Mellin--Barnes formulas. -/

/-- DLMF 5.13.1: the upward vertical contour `s = c + i t`. -/
-- ANCHOR: VerticalLine
structure VerticalLine where
  offset : ℝ
-- ANCHOR_END: VerticalLine

/-- DLMF 5.13.1: the point on a vertical line at height `t`. -/
-- ANCHOR: VerticalLine.point
def VerticalLine.point (γ : VerticalLine) (t : ℝ) : ℂ :=
  (γ.offset : ℂ) + (t : ℂ) * Complex.I
-- ANCHOR_END: VerticalLine.point

/-- DLMF 5.13.1: the upward tangent of a vertical line. -/
-- ANCHOR: VerticalLine.tangent
def VerticalLine.tangent (_γ : VerticalLine) : ℂ := Complex.I
-- ANCHOR_END: VerticalLine.tangent

/-- DLMF 5.13.1: the pulled-back integrand on a vertical line. -/
-- ANCHOR: VerticalLine.integrand
def VerticalLine.integrand (γ : VerticalLine) (f : ℂ → ℂ) : ℝ → ℂ := fun t ↦
  f (γ.point t) * γ.tangent
-- ANCHOR_END: VerticalLine.integrand

/-- DLMF 5.13.1: the ordinary whole-line integral along a vertical line. -/
-- ANCHOR: VerticalLine.integral
noncomputable def VerticalLine.integral (γ : VerticalLine) (f : ℂ → ℂ) : ℂ :=
  ∫ t : ℝ, γ.integrand f t
-- ANCHOR_END: VerticalLine.integral

/-- DLMF 5.13.1: absolute convergence of a whole-line vertical integral. -/
-- ANCHOR: VerticalLine.Integrable
def VerticalLine.Integrable (γ : VerticalLine) (f : ℂ → ℂ) : Prop :=
  MeasureTheory.Integrable (γ.integrand f)
-- ANCHOR_END: VerticalLine.Integrable

/-- DLMF 5.13.1: the canonical vertical line at real part `c`. -/
-- ANCHOR: verticalLine
def verticalLine (c : ℝ) : VerticalLine := ⟨c⟩
-- ANCHOR_END: verticalLine

/-- DLMF 5.9.11 and 5.9.17: a symmetric finite cutoff on a vertical line. -/
-- ANCHOR: VerticalLine.symmetricSegment
noncomputable def VerticalLine.symmetricSegment (γ : VerticalLine) (L : ℝ) : C1Contour where
  point u := γ.point (-L + 2 * L * u)
  tangent _ := (2 * L : ℂ) * Complex.I
  start := γ.point (-L)
  finish := γ.point L
  point_zero := by sorry
  point_one := by sorry
  hasDeriv := by sorry
  tangent_continuous := by fun_prop
-- ANCHOR_END: VerticalLine.symmetricSegment

/-- DLMF 5.9.11 and 5.9.17: the finite symmetric-segment integral. -/
-- ANCHOR: VerticalLine.symmetricSegmentIntegral
noncomputable def VerticalLine.symmetricSegmentIntegral
    (γ : VerticalLine) (L : ℝ) (f : ℂ → ℂ) : ℂ :=
  (γ.symmetricSegment L).integral f
-- ANCHOR_END: VerticalLine.symmetricSegmentIntegral

/-- DLMF 5.9.11 and 5.9.17: finite-cutoff integrability on every symmetric segment. -/
-- ANCHOR: VerticalLine.symmetricSegmentIntegrable
def VerticalLine.symmetricSegmentIntegrable
    (γ : VerticalLine) (f : ℂ → ℂ) : Prop :=
  ∀ L : ℝ, 0 < L → (γ.symmetricSegment L).Integrable f
-- ANCHOR_END: VerticalLine.symmetricSegmentIntegrable

/- DLMF 5.9.11 and 5.9.17: the totalized candidate value of the cutoff family. -/
-- ANCHOR: VerticalLine.symmetricSegmentValue
noncomputable def VerticalLine.symmetricSegmentValue
    (γ : VerticalLine) (f : ℂ → ℂ) : ℂ :=
  limUnder atTop (fun L : ℝ => γ.symmetricSegmentIntegral L f)
-- ANCHOR_END: VerticalLine.symmetricSegmentValue

/-- DLMF 5.9.11 and 5.9.17: ordered convergence of symmetric cutoffs. -/
-- ANCHOR: VerticalLine.symmetricSegmentConverges
def VerticalLine.symmetricSegmentConverges
    (γ : VerticalLine) (f : ℂ → ℂ) : Prop :=
  Tendsto (fun L : ℝ => γ.symmetricSegmentIntegral L f) atTop
    (𝓝 (γ.symmetricSegmentValue f))
-- ANCHOR_END: VerticalLine.symmetricSegmentConverges

/-! An improper ray uses the same point/tangent discipline as a finite contour,
but its parameter runs forward from `0` to infinity. -/

/-- A continuously differentiable complex ray with a stored tangent and escape
to infinity.  The tangent is data, so improper integration never calls the
totalized ambient `deriv`. -/
-- ANCHOR: ImproperC1Ray
structure ImproperC1Ray where
  point : ℝ → ℂ
  tangent : ℝ → ℂ
  start : ℂ
  point_zero : point 0 = start
  hasDeriv : ∀ t : ℝ, 0 ≤ t → HasDerivWithinAt point (tangent t) (Set.Ici 0) t
  tangent_continuous : ContinuousOn tangent (Set.Ici 0)
  escape : Tendsto (fun t : ℝ => ‖point t‖) atTop atTop
-- ANCHOR_END: ImproperC1Ray

instance : CoeFun ImproperC1Ray (fun _ => ℝ → ℂ) :=
  ⟨ImproperC1Ray.point⟩

/-- Finite integration along an improper C¹ ray up to parameter `R`. -/
-- ANCHOR: ImproperC1Ray.HasIntegral
def ImproperC1Ray.HasIntegral
    (γ : ImproperC1Ray) (f : ℂ → ℂ) (R : ℝ) (value : ℂ) : Prop :=
  0 ≤ R ∧
    IntervalIntegrable
        (fun t : ℝ => f (γ.point t) * γ.tangent t) volume 0 R ∧
    value = ∫ t in (0 : ℝ)..R, f (γ.point t) * γ.tangent t
-- ANCHOR_END: ImproperC1Ray.HasIntegral

/-- The forward improper integral along a typed C¹ ray. -/
-- ANCHOR: ImproperC1Ray.HasImproperIntegral
def ImproperC1Ray.HasImproperIntegral
    (γ : ImproperC1Ray) (f : ℂ → ℂ) (value : ℂ) : Prop :=
  (∀ R : ℝ, 0 ≤ R →
      IntervalIntegrable
        (fun t : ℝ => f (γ.point t) * γ.tangent t) volume 0 R) ∧
    Tendsto
      (fun R : ℝ => ∫ t in (0 : ℝ)..R, f (γ.point t) * γ.tangent t)
      atTop (𝓝 value)
-- ANCHOR_END: ImproperC1Ray.HasImproperIntegral

/-- A C¹ contour together with a continuous logarithm along it. This is the
data needed for powers on contours that wind around zero. -/
-- ANCHOR: LogLiftedC1Contour
structure LogLiftedC1Contour extends C1Contour where
  logLift : ℝ → ℂ
  logLift_continuous : ContinuousOn logLift (Icc 0 1)
  exp_logLift : ∀ t ∈ Icc (0 : ℝ) 1, Complex.exp (logLift t) = point t
-- ANCHOR_END: LogLiftedC1Contour

/-- Integrate an expression that may depend on both the point of the contour
and its selected logarithm. -/
-- ANCHOR: LogLiftedC1Contour.integral
def LogLiftedC1Contour.integral
    (γ : LogLiftedC1Contour) (f : ℂ → ℂ → ℂ) : ℂ :=
  ∫ t in (0 : ℝ)..1,
    f (γ.point t) (γ.logLift t) * γ.tangent t
-- ANCHOR_END: LogLiftedC1Contour.integral

/-- The branch-aware integrand is integrable along the finite contour. -/
-- ANCHOR: LogLiftedC1Contour.Integrable
def LogLiftedC1Contour.Integrable
    (γ : LogLiftedC1Contour) (f : ℂ → ℂ → ℂ) : Prop :=
  IntervalIntegrable
    (fun t => f (γ.point t) (γ.logLift t) * γ.tangent t) volume 0 1
-- ANCHOR_END: LogLiftedC1Contour.Integrable

/-- Admissible inner and outer radii for a finite Hankel contour. -/
-- ANCHOR: HankelRadii
structure HankelRadii where
  inner : ℝ
  outer : ℝ
  inner_pos : 0 < inner
  inner_lt_outer : inner < outer
-- ANCHOR_END: HankelRadii

/-- Positive inner radii, used for the limit `ε → 0⁺`. -/
abbrev PositiveRadius := {ε : ℝ // 0 < ε}

/-- Outer radii admissible for a fixed positive inner radius. -/
abbrev OuterRadius (ε : PositiveRadius) := {R : ℝ // ε.1 < R}

/-- Package a positive inner radius and an admissible outer radius. -/
-- ANCHOR: HankelRadii.of
def HankelRadii.of (ε : PositiveRadius) (R : OuterRadius ε) : HankelRadii :=
  ⟨ε, R, ε.property, R.property⟩
-- ANCHOR_END: HankelRadii.of

/-- The filter of positive radii tending to zero. -/
def positiveRadiusAtZero : Filter PositiveRadius :=
  comap (fun ε : PositiveRadius => (ε : ℝ)) (nhdsWithin 0 (Ioi 0))

/-- The lower bank of the finite Hankel contour, oriented from `-R` to `-ε`
with logarithm `log r - πi`. -/
-- ANCHOR: hankelLowerBank
noncomputable def hankelLowerBank (ρ : HankelRadii) : LogLiftedC1Contour
-- ANCHOR_END: hankelLowerBank
where
  point u := -((ρ.outer + u * (ρ.inner - ρ.outer) : ℝ) : ℂ)
  tangent _ := ((ρ.outer - ρ.inner : ℝ) : ℂ)
  start := -(ρ.outer : ℂ)
  finish := -(ρ.inner : ℂ)
  point_zero := by simp
  point_one := by push_cast; ring
  hasDeriv := by sorry
  tangent_continuous := by fun_prop
  logLift u :=
    Real.log (ρ.outer + u * (ρ.inner - ρ.outer)) - Real.pi * Complex.I
  logLift_continuous := by sorry
  exp_logLift := by sorry

/-- Point, tangent, and selected logarithm on the lower bank. -/
-- ANCHOR: hankelLowerBank_spec
theorem hankelLowerBank_spec (ρ : HankelRadii) :
    (∀ u, (hankelLowerBank ρ).point u =
      -((ρ.outer + u * (ρ.inner - ρ.outer) : ℝ) : ℂ)) ∧
    (∀ u, (hankelLowerBank ρ).tangent u =
      ((ρ.outer - ρ.inner : ℝ) : ℂ)) ∧
    (∀ u, (hankelLowerBank ρ).logLift u =
      Real.log (ρ.outer + u * (ρ.inner - ρ.outer)) - Real.pi * Complex.I)
-- ANCHOR_END: hankelLowerBank_spec
:= by simp [hankelLowerBank]

/-- The inner circle, oriented counterclockwise from argument `-π` to `+π`. -/
-- ANCHOR: hankelInnerCircle
noncomputable def hankelInnerCircle (ρ : HankelRadii) : LogLiftedC1Contour
-- ANCHOR_END: hankelInnerCircle
where
  point u :=
    (ρ.inner : ℂ) * Complex.exp (((-Real.pi + 2 * Real.pi * u : ℝ) : ℂ) * Complex.I)
  tangent u :=
    (ρ.inner : ℂ) * Complex.exp (((-Real.pi + 2 * Real.pi * u : ℝ) : ℂ) * Complex.I) *
      ((2 * Real.pi : ℝ) : ℂ) * Complex.I
  start := -(ρ.inner : ℂ)
  finish := -(ρ.inner : ℂ)
  point_zero := by sorry
  point_one := by sorry
  hasDeriv := by sorry
  tangent_continuous := by fun_prop
  logLift u :=
    Real.log ρ.inner + ((-Real.pi + 2 * Real.pi * u : ℝ) : ℂ) * Complex.I
  logLift_continuous := by fun_prop
  exp_logLift := by sorry

/-- Point, tangent, and selected logarithm on the counterclockwise inner circle. -/
-- ANCHOR: hankelInnerCircle_spec
theorem hankelInnerCircle_spec (ρ : HankelRadii) :
    (∀ u, (hankelInnerCircle ρ).point u =
      (ρ.inner : ℂ) *
        Complex.exp (((-Real.pi + 2 * Real.pi * u : ℝ) : ℂ) * Complex.I)) ∧
    (∀ u, (hankelInnerCircle ρ).tangent u =
      (ρ.inner : ℂ) *
        Complex.exp (((-Real.pi + 2 * Real.pi * u : ℝ) : ℂ) * Complex.I) *
        ((2 * Real.pi : ℝ) : ℂ) * Complex.I) ∧
    (∀ u, (hankelInnerCircle ρ).logLift u =
      Real.log ρ.inner +
        ((-Real.pi + 2 * Real.pi * u : ℝ) : ℂ) * Complex.I)
-- ANCHOR_END: hankelInnerCircle_spec
:= by simp [hankelInnerCircle]

/-- The upper bank of the finite Hankel contour, oriented from `-ε` to `-R`
with logarithm `log r + πi`. -/
-- ANCHOR: hankelUpperBank
noncomputable def hankelUpperBank (ρ : HankelRadii) : LogLiftedC1Contour
-- ANCHOR_END: hankelUpperBank
where
  point u := -((ρ.inner + u * (ρ.outer - ρ.inner) : ℝ) : ℂ)
  tangent _ := -((ρ.outer - ρ.inner : ℝ) : ℂ)
  start := -(ρ.inner : ℂ)
  finish := -(ρ.outer : ℂ)
  point_zero := by simp
  point_one := by push_cast; ring
  hasDeriv := by sorry
  tangent_continuous := by fun_prop
  logLift u :=
    Real.log (ρ.inner + u * (ρ.outer - ρ.inner)) + Real.pi * Complex.I
  logLift_continuous := by sorry
  exp_logLift := by sorry

/-- Point, tangent, and selected logarithm on the upper bank. -/
-- ANCHOR: hankelUpperBank_spec
theorem hankelUpperBank_spec (ρ : HankelRadii) :
    (∀ u, (hankelUpperBank ρ).point u =
      -((ρ.inner + u * (ρ.outer - ρ.inner) : ℝ) : ℂ)) ∧
    (∀ u, (hankelUpperBank ρ).tangent u =
      -((ρ.outer - ρ.inner : ℝ) : ℂ)) ∧
    (∀ u, (hankelUpperBank ρ).logLift u =
      Real.log (ρ.inner + u * (ρ.outer - ρ.inner)) + Real.pi * Complex.I)
-- ANCHOR_END: hankelUpperBank_spec
:= by simp [hankelUpperBank]

/-- The standard finite Hankel contour as its three C¹ pieces. -/
-- ANCHOR: HankelContour
structure HankelContour where
  lowerBank : LogLiftedC1Contour
  innerCircle : LogLiftedC1Contour
  upperBank : LogLiftedC1Contour
  lower_join : lowerBank.finish = innerCircle.start
  upper_join : innerCircle.finish = upperBank.start
  closed : lowerBank.start = upperBank.finish
  lower_log_join : lowerBank.logLift 1 = innerCircle.logLift 0
  upper_log_join : innerCircle.logLift 1 = upperBank.logLift 0
-- ANCHOR_END: HankelContour

/-- The explicitly oriented finite Hankel contour for admissible radii. -/
-- ANCHOR: hankelContour
noncomputable def hankelContour (ρ : HankelRadii) : HankelContour
-- ANCHOR_END: hankelContour
where
  lowerBank := hankelLowerBank ρ
  innerCircle := hankelInnerCircle ρ
  upperBank := hankelUpperBank ρ
  lower_join := rfl
  upper_join := rfl
  closed := rfl
  lower_log_join := by
    simp [hankelLowerBank, hankelInnerCircle]
    ring
  upper_log_join := by
    simp [hankelInnerCircle, hankelUpperBank]
    ring

/-- Sum the branch-aware integrals over the three pieces of a Hankel contour. -/
-- ANCHOR: HankelContour.integral
def HankelContour.integral (γ : HankelContour) (f : ℂ → ℂ → ℂ) : ℂ :=
  γ.lowerBank.integral f + γ.innerCircle.integral f + γ.upperBank.integral f
-- ANCHOR_END: HankelContour.integral

/-- Integrability on each finite piece of a Hankel contour. -/
-- ANCHOR: HankelContour.Integrable
def HankelContour.Integrable (γ : HankelContour) (f : ℂ → ℂ → ℂ) : Prop :=
  γ.lowerBank.Integrable f ∧ γ.innerCircle.Integrable f ∧ γ.upperBank.Integrable f
-- ANCHOR_END: HankelContour.Integrable

/-- The two-stage improper integral over the standard Hankel contour. Every
finite three-piece contour is integrable; its outer radius tends to infinity at
fixed positive inner radius, and then the inner radius tends to zero. -/
-- ANCHOR: HasHankelIntegral
def HasHankelIntegral (f : ℂ → ℂ → ℂ) (value : ℂ) : Prop :=
  (∀ ε : PositiveRadius, ∀ R : OuterRadius ε,
      (hankelContour (HankelRadii.of ε R)).Integrable f) ∧
    ∃ outerLimit : PositiveRadius → ℂ,
      (∀ ε : PositiveRadius,
        Tendsto
          (fun R : OuterRadius ε =>
            (hankelContour (HankelRadii.of ε R)).integral f)
          atTop (nhds (outerLimit ε))) ∧
      Tendsto outerLimit positiveRadiusAtZero (nhds value)
-- ANCHOR_END: HasHankelIntegral

/-- A source-oriented normalized Hankel representation: the improper integral
exists, and multiplying it by `normalization` gives `value`. -/
-- ANCHOR: HasHankelRepresentation
def HasHankelRepresentation
    (f : ℂ → ℂ → ℂ) (normalization value : ℂ) : Prop :=
  ∃ integral, HasHankelIntegral f integral ∧ value = normalization * integral
-- ANCHOR_END: HasHankelRepresentation

end LMLF.Integral
