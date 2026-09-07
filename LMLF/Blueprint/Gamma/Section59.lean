import LMLF.Definitions.Gamma
import LMLF.Integral.Curve
import Mathlib.Analysis.SpecialFunctions.Gamma.Digamma
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import Mathlib.NumberTheory.LSeries.RiemannZeta

/-!
# DLMF 5.9: integral representations for Gamma and psi

The page separates finite/improper convergence declarations from the value
identities. Contour values use typed C¹ paths; the Hankel representation is
the branch-aware object supplied by `LMLF.Integral.Curve`.
-/

open Filter MeasureTheory Set
open scoped Interval Topology

noncomputable section

namespace LMLF.Blueprint.Gamma.Section59

/-! ## Typed paths used by the contour formulas -/

/-- DLMF 5.9.20. The C¹ straight segment from `a` to `b`. -/
-- ANCHOR: complexSegmentContour
noncomputable def complexSegmentContour (a b : ℂ) : LMLF.Integral.C1Contour where
  point u := a + (u : ℂ) * (b - a)
  tangent _ := b - a
  start := a
  finish := b
  point_zero := by sorry
  point_one := by sorry
  hasDeriv := by sorry
  tangent_continuous := by fun_prop
-- ANCHOR_END: complexSegmentContour

/-- DLMF 5.9.20. Integrate along the typed straight segment. -/
-- ANCHOR: complexSegmentIntegral
noncomputable def complexSegmentIntegral (f : ℂ → ℂ) (a b : ℂ) : ℂ :=
  (complexSegmentContour a b).integral f
-- ANCHOR_END: complexSegmentIntegral

/-- DLMF 5.9.11 and 5.9.17. Bridge the section's `c` convention to the
shared vertical-line object: the contour is `Re s = -c`. -/
-- ANCHOR: verticalSegment
noncomputable def verticalSegment (c L : ℝ) : LMLF.Integral.C1Contour :=
  (LMLF.Integral.verticalLine (-c)).symmetricSegment L
-- ANCHOR_END: verticalSegment

/-- DLMF 5.9.11 and 5.9.17. Bridge to the shared finite-cutoff value. -/
-- ANCHOR: verticalLineIntegral
noncomputable def verticalLineIntegral (c : ℝ) (f : ℂ → ℂ) : ℂ :=
  (LMLF.Integral.verticalLine (-c)).symmetricSegmentValue f
-- ANCHOR_END: verticalLineIntegral

/-- DLMF 5.9.11 and 5.9.17. Bridge to shared finite-cutoff integrability. -/
-- ANCHOR: verticalLineIntegrable
def verticalLineIntegrable (c : ℝ) (f : ℂ → ℂ) : Prop :=
  (LMLF.Integral.verticalLine (-c)).symmetricSegmentIntegrable f
-- ANCHOR_END: verticalLineIntegrable

/-- DLMF 5.9.11 and 5.9.17. Bridge to shared finite-cutoff convergence. -/
-- ANCHOR: verticalLineConverges
def verticalLineConverges (c : ℝ) (f : ℂ → ℂ) : Prop :=
  (LMLF.Integral.verticalLine (-c)).symmetricSegmentConverges f
-- ANCHOR_END: verticalLineConverges

/-- DLMF 5.9.2_5. Temme's phase. -/
-- ANCHOR: temmePhase
noncomputable def temmePhase (t : ℝ) : ℝ :=
  1 - t / Real.tan t + Real.log (t / Real.sin t)
-- ANCHOR_END: temmePhase

/-- DLMF 5.9.11_1 and 5.9.11_2. The scaled Gamma normalization. -/
-- ANCHOR: scaledGamma
noncomputable def scaledGamma (z : ℂ) : ℂ :=
  Complex.Gamma z /
    ((2 * Real.pi : ℂ) ^ (1 / 2 : ℂ) * z ^ (z - 1 / 2) * Complex.exp (-z))
-- ANCHOR_END: scaledGamma

/-! ## Gamma function -/

/-- DLMF 5.9.1. Absolute convergence of generalized Euler's integrand. -/
-- ANCHOR: dlmf_5_9_1_integrable
theorem dlmf_5_9_1_integrable {z ν : ℂ} {μ : ℝ} (hμ : 0 < μ) (hν : 0 < ν.re)
    (hz : 0 < z.re) :
    IntegrableOn
      (fun t : ℝ ↦ Complex.exp (-z * (Real.rpow t μ : ℂ)) * (t : ℂ) ^ (ν - 1)) (Ioi 0)
-- ANCHOR_END: dlmf_5_9_1_integrable
:= by sorry

/-! ## Psi, Euler's constant, and derivatives -/

/-- DLMF 5.9.12. Integrability of the digamma kernel. -/
-- ANCHOR: dlmf_5_9_12_integrable
theorem dlmf_5_9_12_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-t) / t - Real.exp (-x * t) /
      (1 - Real.exp (-t))) (Ioi 0)
-- ANCHOR_END: dlmf_5_9_12_integrable
:= by sorry

/-- DLMF 5.9.12. Digamma integral value on the positive real axis. -/
-- ANCHOR: dlmf_5_9_12
theorem dlmf_5_9_12 {x : ℝ} (hx : 0 < x) :
    Complex.digamma x = ∫ t in Ioi (0 : ℝ),
      Real.exp (-t) / t - Real.exp (-x * t) / (1 - Real.exp (-t))
-- ANCHOR_END: dlmf_5_9_12
:= by sorry

/-- DLMF 5.9.13. Integrability of the Laplace correction kernel. -/
-- ANCHOR: dlmf_5_9_13_integrable
theorem dlmf_5_9_13_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ (1 / t - 1 / (1 - Real.exp (-t))) *
      Real.exp (-t * x)) (Ioi 0)
-- ANCHOR_END: dlmf_5_9_13_integrable
:= by sorry

/-- DLMF 5.9.13. Digamma plus logarithm value identity. -/
-- ANCHOR: dlmf_5_9_13
theorem dlmf_5_9_13 {x : ℝ} (hx : 0 < x) :
    Complex.digamma x = Real.log x + ∫ t in Ioi (0 : ℝ),
      (1 / t - 1 / (1 - Real.exp (-t))) * Real.exp (-t * x)
-- ANCHOR_END: dlmf_5_9_13
:= by sorry

/-- DLMF 5.9.14. Integrability of the cancellation kernel. -/
-- ANCHOR: dlmf_5_9_14_integrable
theorem dlmf_5_9_14_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ (Real.exp (-t) - (1 + t) ^ (-x)) / t) (Ioi 0)
-- ANCHOR_END: dlmf_5_9_14_integrable
:= by sorry

/-- DLMF 5.9.14. Digamma cancellation-integral value. -/
-- ANCHOR: dlmf_5_9_14
theorem dlmf_5_9_14 {x : ℝ} (hx : 0 < x) :
    Complex.digamma x = ∫ t in Ioi (0 : ℝ), (Real.exp (-t) - (1 + t) ^ (-x)) / t
-- ANCHOR_END: dlmf_5_9_14
:= by sorry

/-- DLMF 5.9.15. Integrability of the differentiated Binet kernel. -/
-- ANCHOR: dlmf_5_9_15_integrable
theorem dlmf_5_9_15_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ t / ((t ^ 2 + x ^ 2) *
      (Real.exp (2 * Real.pi * t) - 1))) (Ioi 0)
-- ANCHOR_END: dlmf_5_9_15_integrable
:= by sorry

/-- DLMF 5.9.15. Digamma differentiated-Binet value identity. -/
-- ANCHOR: dlmf_5_9_15
theorem dlmf_5_9_15 {x : ℝ} (hx : 0 < x) :
    Complex.digamma x = (Real.log x - 1 / (2 * x) : ℝ) -
      (2 : ℂ) * (↑((∫ t in Ioi (0 : ℝ),
        (t / ((t ^ 2 + x ^ 2) * (Real.exp (2 * Real.pi * t) - 1)) : ℝ)) : ℝ) : ℂ)
-- ANCHOR_END: dlmf_5_9_15
:= by sorry

/-- DLMF 5.9.16. Integrability of the exponential digamma kernel. -/
-- ANCHOR: dlmf_5_9_16_laplace_integrable
theorem dlmf_5_9_16_laplace_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ (Real.exp (-t) - Real.exp (-x * t)) /
      (1 - Real.exp (-t))) (Ioi 0)
-- ANCHOR_END: dlmf_5_9_16_laplace_integrable
:= by sorry

/-- DLMF 5.9.16. Integrability of the unit-interval digamma kernel. -/
-- ANCHOR: dlmf_5_9_16_unit_integrable
theorem dlmf_5_9_16_unit_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ (1 - t ^ (x - 1)) / (1 - t)) (Ioo 0 1)
-- ANCHOR_END: dlmf_5_9_16_unit_integrable
:= by sorry

/-- DLMF 5.9.16. Exponential-integral value identity. -/
-- ANCHOR: dlmf_5_9_16_laplace
theorem dlmf_5_9_16_laplace {x : ℝ} (hx : 0 < x) :
    Complex.digamma x + Real.eulerMascheroniConstant =
      ∫ t in Ioi (0 : ℝ), (Real.exp (-t) - Real.exp (-x * t)) /
        (1 - Real.exp (-t))
-- ANCHOR_END: dlmf_5_9_16_laplace
:= by sorry

/-- DLMF 5.9.16. Unit-interval value identity. -/
-- ANCHOR: dlmf_5_9_16_unit
theorem dlmf_5_9_16_unit {x : ℝ} (hx : 0 < x) :
    Complex.digamma x + Real.eulerMascheroniConstant =
      ∫ t in Ioo (0 : ℝ) 1, (1 - t ^ (x - 1)) / (1 - t)
-- ANCHOR_END: dlmf_5_9_16_unit
:= by sorry

/-- DLMF 5.9.17. Mellin–Barnes differentiated kernel is integrable on every
finite vertical segment. -/
-- ANCHOR: dlmf_5_9_17_integrable
theorem dlmf_5_9_17_integrable {x c : ℝ} (hx : 0 < x) (hc1 : 1 < c) (hc2 : c < 2) :
    verticalLineIntegrable c (fun s ↦ Real.pi * (x : ℂ) ^ (-s - 1) /
      Complex.sin (Real.pi * s) * riemannZeta (-s))
-- ANCHOR_END: dlmf_5_9_17_integrable
:= by sorry

/-- DLMF 5.9.17. Convergence of the differentiated vertical-line integral. -/
-- ANCHOR: dlmf_5_9_17_converges
theorem dlmf_5_9_17_converges {x c : ℝ} (hx : 0 < x) (hc1 : 1 < c) (hc2 : c < 2) :
    verticalLineConverges c (fun s ↦ Real.pi * (x : ℂ) ^ (-s - 1) /
      Complex.sin (Real.pi * s) * riemannZeta (-s))
-- ANCHOR_END: dlmf_5_9_17_converges
:= by sorry

/-- DLMF 5.9.17. Differentiated Mellin–Barnes value identity. -/
-- ANCHOR: dlmf_5_9_17
theorem dlmf_5_9_17 {x c : ℝ} (hx : 0 < x) (hc1 : 1 < c) (hc2 : c < 2) :
    Complex.digamma (x + 1) = -Real.eulerMascheroniConstant +
      verticalLineIntegral c (fun s ↦ Real.pi * (x : ℂ) ^ (-s - 1) /
        Complex.sin (Real.pi * s) * riemannZeta (-s)) / (2 * Real.pi * Complex.I)
-- ANCHOR_END: dlmf_5_9_17
:= by sorry

/-- DLMF 5.9.18. Integrability of the first Euler-constant kernel. -/
-- ANCHOR: dlmf_5_9_18_first_integrable
theorem dlmf_5_9_18_first_integrable :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-t) * Real.log t) (Ioi 0)
-- ANCHOR_END: dlmf_5_9_18_first_integrable
:= by sorry

/-- DLMF 5.9.18. Integrability of the second Euler-constant kernel. -/
-- ANCHOR: dlmf_5_9_18_second_integrable
theorem dlmf_5_9_18_second_integrable :
    IntegrableOn (fun t : ℝ ↦ (1 / (1 + t) - Real.exp (-t)) / t) (Ioi 0)
-- ANCHOR_END: dlmf_5_9_18_second_integrable
:= by sorry

/-- DLMF 5.9.18. Integrability of the unit-interval Euler-constant kernel. -/
-- ANCHOR: dlmf_5_9_18_third_integrable
theorem dlmf_5_9_18_third_integrable :
    IntegrableOn (fun t : ℝ ↦ (1 - Real.exp (-t)) / t) (Ioo 0 1)
-- ANCHOR_END: dlmf_5_9_18_third_integrable
:= by sorry

/-- DLMF 5.9.18. Integrability of the tail Euler-constant kernel. -/
-- ANCHOR: dlmf_5_9_18_fourth_integrable
theorem dlmf_5_9_18_fourth_integrable :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-t) / t) (Ici 1)
-- ANCHOR_END: dlmf_5_9_18_fourth_integrable
:= by sorry

/-- DLMF 5.9.18. Integrability of the final Euler-constant kernel. -/
-- ANCHOR: dlmf_5_9_18_fifth_integrable
theorem dlmf_5_9_18_fifth_integrable :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-t) / (1 - Real.exp (-t)) - Real.exp (-t) / t)
      (Ioi 0)
-- ANCHOR_END: dlmf_5_9_18_fifth_integrable
:= by sorry

/-- DLMF 5.9.18. First Euler-constant value identity. -/
-- ANCHOR: dlmf_5_9_18_first
theorem dlmf_5_9_18_first :
    Real.eulerMascheroniConstant = -∫ t in Ioi (0 : ℝ), Real.exp (-t) * Real.log t
-- ANCHOR_END: dlmf_5_9_18_first
:= by sorry

/-- DLMF 5.9.18. Second Euler-constant value identity. -/
-- ANCHOR: dlmf_5_9_18_second
theorem dlmf_5_9_18_second :
    Real.eulerMascheroniConstant = ∫ t in Ioi (0 : ℝ),
      (1 / (1 + t) - Real.exp (-t)) / t
-- ANCHOR_END: dlmf_5_9_18_second
:= by sorry

/-- DLMF 5.9.18. Split-interval Euler-constant value identity. -/
-- ANCHOR: dlmf_5_9_18_third
theorem dlmf_5_9_18_third :
    Real.eulerMascheroniConstant =
      (∫ t in Ioo (0 : ℝ) 1, (1 - Real.exp (-t)) / t) -
        ∫ t in Ici (1 : ℝ), Real.exp (-t) / t
-- ANCHOR_END: dlmf_5_9_18_third
:= by sorry

/-- DLMF 5.9.18. Final Euler-constant value identity. -/
-- ANCHOR: dlmf_5_9_18_fourth
theorem dlmf_5_9_18_fourth :
    Real.eulerMascheroniConstant = ∫ t in Ioi (0 : ℝ),
      Real.exp (-t) / (1 - Real.exp (-t)) - Real.exp (-t) / t
-- ANCHOR_END: dlmf_5_9_18_fourth
:= by sorry

/-- DLMF 5.9.19. Integrability of the logarithmic derivative kernel. -/
-- ANCHOR: dlmf_5_9_19_integrable
theorem dlmf_5_9_19_integrable (n : ℕ) {z : ℂ} (hz : 0 < z.re) :
    IntegrableOn (fun t : ℝ ↦ (Real.log t : ℂ) ^ n * Real.exp (-t) *
      (t : ℂ) ^ (z - 1)) (Ioi 0)
-- ANCHOR_END: dlmf_5_9_19_integrable
:= by sorry

/-- DLMF 5.9.19. Differentiating Euler's integral under the integral sign. -/
-- ANCHOR: dlmf_5_9_19
theorem dlmf_5_9_19 (n : ℕ) {z : ℂ} (hz : 0 < z.re) :
    iteratedDeriv n Complex.Gamma z = ∫ t in Ioi (0 : ℝ),
      (Real.log t : ℂ) ^ n * Real.exp (-t) * (t : ℂ) ^ (z - 1)
-- ANCHOR_END: dlmf_5_9_19
:= by sorry

/-- DLMF 5.9.20. Integrability of the real integral on the right. -/
-- ANCHOR: dlmf_5_9_20_integrable
theorem dlmf_5_9_20_integrable {c z : ℂ} (hc : 0 < c.re) (hz : 0 < z.re) :
    IntegrableOn (fun t : ℝ ↦ ((t : ℂ) ^ (z - 1) - (t : ℂ) ^ (c - 1)) /
      Real.log t * Real.exp (-t)) (Ioi 0)
-- ANCHOR_END: dlmf_5_9_20_integrable
:= by sorry

/-- DLMF 5.9.20. Gamma integrated along the typed straight segment. -/
-- ANCHOR: dlmf_5_9_20
theorem dlmf_5_9_20 {c z : ℂ} (hc : 0 < c.re) (hz : 0 < z.re) :
    complexSegmentIntegral Complex.Gamma c z = ∫ t in Ioi (0 : ℝ),
      ((t : ℂ) ^ (z - 1) - (t : ℂ) ^ (c - 1)) /
        Real.log t * Real.exp (-t)
-- ANCHOR_END: dlmf_5_9_20
:= by sorry


/-- DLMF 5.9.1. Generalized Euler's integral value. -/
-- ANCHOR: dlmf_5_9_1
theorem dlmf_5_9_1 {z ν : ℂ} {μ : ℝ} (hμ : 0 < μ) (hν : 0 < ν.re) (hz : 0 < z.re) :
    (1 / (μ : ℂ)) * Complex.Gamma (ν / μ) / z ^ (ν / μ) =
      ∫ t in Ioi (0 : ℝ),
        Complex.exp (-z * (Real.rpow t μ : ℂ)) * (t : ℂ) ^ (ν - 1)
-- ANCHOR_END: dlmf_5_9_1
:= by sorry

/-- DLMF 5.9.2. Hankel's branch-aware loop representation. -/
-- ANCHOR: dlmf_5_9_2
theorem dlmf_5_9_2 (z : ℂ) :
    LMLF.Integral.HasHankelRepresentation
      (fun t logt => Complex.exp t * Complex.exp (-z * logt))
      (1 / (2 * Real.pi * Complex.I))
      (1 / Complex.Gamma z)
-- ANCHOR_END: dlmf_5_9_2
:= by sorry

/-- DLMF 5.9.2_5. Finite-interval convergence for Temme's representation. -/
-- ANCHOR: dlmf_5_9_2_5_integrable
theorem dlmf_5_9_2_5_integrable {z : ℂ} (hz : 0 < z.re) :
    IntervalIntegrable (fun t : ℝ ↦ Complex.exp (-z * temmePhase t)) volume
      (-Real.pi) Real.pi
-- ANCHOR_END: dlmf_5_9_2_5_integrable
:= by sorry

/-- DLMF 5.9.2_5. Temme's reciprocal-Gamma value identity. -/
-- ANCHOR: dlmf_5_9_2_5
theorem dlmf_5_9_2_5 {z : ℂ} (hz : 0 < z.re) :
    1 / Complex.Gamma z =
      Complex.exp z * z ^ (1 - z) / (2 * Real.pi) *
        ∫ t in (-Real.pi)..Real.pi, Complex.exp (-z * temmePhase t)
-- ANCHOR_END: dlmf_5_9_2_5
:= by sorry

/-- DLMF 5.9.3. Absolute convergence of the Gaussian Gamma integrand. -/
-- ANCHOR: dlmf_5_9_3_integrable
theorem dlmf_5_9_3_integrable {z : ℂ} {c : ℝ} (hc : 0 < c) (hz : 0 < z.re) :
    Integrable (fun t : ℝ ↦ ((|t| : ℝ) : ℂ) ^ (2 * z - 1) * Complex.exp (-c * t ^ 2))
-- ANCHOR_END: dlmf_5_9_3_integrable
:= by sorry

/-- DLMF 5.9.3. Gaussian form of Euler's integral. -/
-- ANCHOR: dlmf_5_9_3
theorem dlmf_5_9_3 {z : ℂ} {c : ℝ} (hc : 0 < c) (hz : 0 < z.re) :
    (c : ℂ) ^ (-z) * Complex.Gamma z =
      ∫ t : ℝ, ((|t| : ℝ) : ℂ) ^ (2 * z - 1) * Complex.exp (-c * t ^ 2)
-- ANCHOR_END: dlmf_5_9_3
:= by sorry

/-- DLMF 5.9.4. Integrability of the tail integral. -/
-- ANCHOR: dlmf_5_9_4_integrable
theorem dlmf_5_9_4_integrable {z : ℂ} (hz : ∀ k : ℕ, z ≠ -(k : ℂ)) :
    IntegrableOn (fun t : ℝ ↦ (t : ℂ) ^ (z - 1) * Real.exp (-t)) (Ici 1)
-- ANCHOR_END: dlmf_5_9_4_integrable
:= by sorry

/-- DLMF 5.9.4. Summability of the correction series. -/
-- ANCHOR: dlmf_5_9_4_summable
theorem dlmf_5_9_4_summable {z : ℂ} (hz : ∀ k : ℕ, z ≠ -(k : ℂ)) :
    Summable (fun k : ℕ ↦ (-1 : ℂ) ^ k / ((z + k) * k.factorial))
-- ANCHOR_END: dlmf_5_9_4_summable
:= by sorry

/-- DLMF 5.9.4. Meromorphic continuation split at one. -/
-- ANCHOR: dlmf_5_9_4
theorem dlmf_5_9_4 {z : ℂ} (hz : ∀ k : ℕ, z ≠ -(k : ℂ)) :
    Complex.Gamma z =
      (∫ t in Ici (1 : ℝ), (t : ℂ) ^ (z - 1) * Real.exp (-t)) +
        ∑' k : ℕ, (-1 : ℂ) ^ k / ((z + k) * k.factorial)
-- ANCHOR_END: dlmf_5_9_4
:= by sorry

/-- DLMF 5.9.5. Integrability after subtracting the Taylor polynomial. -/
-- ANCHOR: dlmf_5_9_5_integrable
theorem dlmf_5_9_5_integrable (n : ℕ) {z : ℂ} (hl : -(n : ℝ) - 1 < z.re)
    (hu : z.re < -n) :
    IntegrableOn
      (fun t : ℝ ↦ (t : ℂ) ^ (z - 1) *
        (Real.exp (-t) - ∑ k ∈ Finset.range (n + 1), (-1 : ℂ) ^ k * t ^ k / k.factorial))
      (Ioi 0)
-- ANCHOR_END: dlmf_5_9_5_integrable
:= by sorry

/-- DLMF 5.9.5. Euler's regularized integral value. -/
-- ANCHOR: dlmf_5_9_5
theorem dlmf_5_9_5 (n : ℕ) {z : ℂ} (hl : -(n : ℝ) - 1 < z.re) (hu : z.re < -n) :
    Complex.Gamma z = ∫ t in Ioi (0 : ℝ), (t : ℂ) ^ (z - 1) *
      (Real.exp (-t) - ∑ k ∈ Finset.range (n + 1), (-1 : ℂ) ^ k * t ^ k / k.factorial)
-- ANCHOR_END: dlmf_5_9_5
:= by sorry

/-- DLMF 5.9.6. The cosine Mellin cutoff converges. -/
-- ANCHOR: dlmf_5_9_6
theorem dlmf_5_9_6 {z : ℂ} (hl : 0 < z.re) (hu : z.re < 1) :
    Tendsto (fun R : ℝ ↦ ∫ t in (0 : ℝ)..R, (t : ℂ) ^ (z - 1) * Real.cos t)
      atTop (𝓝 (Complex.Gamma z * Complex.cos (Real.pi * z / 2)))
-- ANCHOR_END: dlmf_5_9_6
:= by sorry

/-- DLMF 5.9.7. The sine Mellin cutoff converges. -/
-- ANCHOR: dlmf_5_9_7
theorem dlmf_5_9_7 {z : ℂ} (hl : -1 < z.re) (hu : z.re < 1) :
    Tendsto (fun R : ℝ ↦ ∫ t in (0 : ℝ)..R, (t : ℂ) ^ (z - 1) * Real.sin t)
      atTop (𝓝 (Complex.Gamma z * Complex.sin (Real.pi * z / 2)))
-- ANCHOR_END: dlmf_5_9_7
:= by sorry

/-- DLMF 5.9.8. The cosine power-phase cutoff converges. -/
-- ANCHOR: dlmf_5_9_8
theorem dlmf_5_9_8 {n : ℕ} (hn : 2 ≤ n) :
    Tendsto (fun R : ℝ ↦ ∫ t in (0 : ℝ)..R, Real.cos (t ^ n)) atTop
      (𝓝 (Real.Gamma (1 + 1 / (n : ℝ)) * Real.cos (Real.pi / (2 * n))))
-- ANCHOR_END: dlmf_5_9_8
:= by sorry

/-- DLMF 5.9.9. The sine power-phase cutoff converges. -/
-- ANCHOR: dlmf_5_9_9
theorem dlmf_5_9_9 {n : ℕ} (hn : 2 ≤ n) :
    Tendsto (fun R : ℝ ↦ ∫ t in (0 : ℝ)..R, Real.sin (t ^ n)) atTop
      (𝓝 (Real.Gamma (1 + 1 / (n : ℝ)) * Real.sin (Real.pi / (2 * n))))
-- ANCHOR_END: dlmf_5_9_9
:= by sorry

/-- DLMF 5.9.10. Binet's first kernel is integrable on `(0,∞)`. -/
-- ANCHOR: dlmf_5_9_10_integrable
theorem dlmf_5_9_10_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.arctan (t / x) / (Real.exp (2 * Real.pi * t) - 1)) (Ioi 0)
-- ANCHOR_END: dlmf_5_9_10_integrable
:= by sorry

/-- DLMF 5.9.10. Binet's first value identity on the positive real axis. -/
-- ANCHOR: dlmf_5_9_10
theorem dlmf_5_9_10 {x : ℝ} (hx : 0 < x) :
    Real.log (Real.Gamma x) =
      (x - 1 / 2) * Real.log x - x + Real.log (2 * Real.pi) / 2 +
        2 * ∫ t in Ioi (0 : ℝ), Real.arctan (t / x) /
          (Real.exp (2 * Real.pi * t) - 1)
-- ANCHOR_END: dlmf_5_9_10
:= by sorry

/-- DLMF 5.9.10_1. Integrability of the integration-by-parts kernel. -/
-- ANCHOR: dlmf_5_9_10_1_integrable
theorem dlmf_5_9_10_1_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn
      (fun t : ℝ ↦ Real.log (1 - Real.exp (-2 * Real.pi * t)) / (t ^ 2 + x ^ 2)) (Ioi 0)
-- ANCHOR_END: dlmf_5_9_10_1_integrable
:= by sorry

/-- DLMF 5.9.10_1. The integration-by-parts Binet value identity. -/
-- ANCHOR: dlmf_5_9_10_1
theorem dlmf_5_9_10_1 {x : ℝ} (hx : 0 < x) :
    Real.log (Real.Gamma x) =
      (x - 1 / 2) * Real.log x - x + Real.log (2 * Real.pi) / 2 -
        x / Real.pi * ∫ t in Ioi (0 : ℝ),
          Real.log (1 - Real.exp (-2 * Real.pi * t)) / (t ^ 2 + x ^ 2)
-- ANCHOR_END: dlmf_5_9_10_1
:= by sorry

/-- DLMF 5.9.10_2. Integrability of the Laplace Binet kernel. -/
-- ANCHOR: dlmf_5_9_10_2_integrable
theorem dlmf_5_9_10_2_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-x * t) *
      (1 / (Real.exp t - 1) - 1 / t + 1 / 2) / t) (Ioi 0)
-- ANCHOR_END: dlmf_5_9_10_2_integrable
:= by sorry

/-- DLMF 5.9.10_2. The Laplace Binet value identity. -/
-- ANCHOR: dlmf_5_9_10_2
theorem dlmf_5_9_10_2 {x : ℝ} (hx : 0 < x) :
    Real.log (Real.Gamma x) =
      (x - 1 / 2) * Real.log x - x + Real.log (2 * Real.pi) / 2 +
        ∫ t in Ioi (0 : ℝ), Real.exp (-x * t) *
          (1 / (Real.exp t - 1) - 1 / t + 1 / 2) / t
-- ANCHOR_END: dlmf_5_9_10_2
:= by sorry

/-! ## Mellin–Barnes and scaled Gamma integrals -/

/-- DLMF 5.9.11. The Mellin–Barnes kernel is integrable on every finite
vertical segment. -/
-- ANCHOR: dlmf_5_9_11_integrable
theorem dlmf_5_9_11_integrable {x c : ℝ} (hx : 0 < x) (hc1 : 1 < c) (hc2 : c < 2) :
    verticalLineIntegrable c (fun s ↦
      Real.pi * (x : ℂ) ^ (-s) / (s * Complex.sin (Real.pi * s)) * riemannZeta (-s))
-- ANCHOR_END: dlmf_5_9_11_integrable
:= by sorry

/-- DLMF 5.9.11. Convergence of the Mellin–Barnes vertical-line integral. -/
-- ANCHOR: dlmf_5_9_11_converges
theorem dlmf_5_9_11_converges {x c : ℝ} (hx : 0 < x) (hc1 : 1 < c) (hc2 : c < 2) :
    verticalLineConverges c (fun s ↦
      Real.pi * (x : ℂ) ^ (-s) / (s * Complex.sin (Real.pi * s)) * riemannZeta (-s))
-- ANCHOR_END: dlmf_5_9_11_converges
:= by sorry

/-- DLMF 5.9.11. Mellin–Barnes value identity, specialized to `x > 0`. -/
-- ANCHOR: dlmf_5_9_11
theorem dlmf_5_9_11 {x c : ℝ} (hx : 0 < x) (hc1 : 1 < c) (hc2 : c < 2) :
    (Real.log (Real.Gamma (x + 1)) : ℂ) =
      -Real.eulerMascheroniConstant * x -
        verticalLineIntegral c (fun s ↦
          Real.pi * (x : ℂ) ^ (-s) / (s * Complex.sin (Real.pi * s)) * riemannZeta (-s)) /
          (2 * Real.pi * Complex.I)
-- ANCHOR_END: dlmf_5_9_11
:= by sorry

/-- DLMF 5.9.11_1. Integrability of the first scaled-Gamma ray kernel. -/
-- ANCHOR: dlmf_5_9_11_1_left_integrable
theorem dlmf_5_9_11_1_left_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-2 * Real.pi * t) *
      scaledGamma (t * Complex.I) / (t + Complex.I * x)) (Ioi 0)
-- ANCHOR_END: dlmf_5_9_11_1_left_integrable
:= by sorry

/-- DLMF 5.9.11_1. Integrability of the second scaled-Gamma ray kernel. -/
-- ANCHOR: dlmf_5_9_11_1_right_integrable
theorem dlmf_5_9_11_1_right_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-2 * Real.pi * t) *
      scaledGamma (-t * Complex.I) / (t - Complex.I * x)) (Ioi 0)
-- ANCHOR_END: dlmf_5_9_11_1_right_integrable
:= by sorry

/-- DLMF 5.9.11_1. First scaled-Gamma value identity. -/
-- ANCHOR: dlmf_5_9_11_1
theorem dlmf_5_9_11_1 {x : ℝ} (hx : 0 < x) :
    scaledGamma x = 1 - (1 / (2 * Real.pi * Complex.I)) *
      (∫ t in Ioi (0 : ℝ), Real.exp (-2 * Real.pi * t) *
        scaledGamma (t * Complex.I) / (t + Complex.I * x)) +
      (1 / (2 * Real.pi * Complex.I)) *
      (∫ t in Ioi (0 : ℝ), Real.exp (-2 * Real.pi * t) *
        scaledGamma (-t * Complex.I) / (t - Complex.I * x))
-- ANCHOR_END: dlmf_5_9_11_1
:= by sorry

/-- DLMF 5.9.11_2. Integrability of the first reciprocal scaled-Gamma ray. -/
-- ANCHOR: dlmf_5_9_11_2_left_integrable
theorem dlmf_5_9_11_2_left_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-2 * Real.pi * t) *
      scaledGamma (t * Complex.I) / (t - Complex.I * x)) (Ioi 0)
-- ANCHOR_END: dlmf_5_9_11_2_left_integrable
:= by sorry

/-- DLMF 5.9.11_2. Integrability of the second reciprocal scaled-Gamma ray. -/
-- ANCHOR: dlmf_5_9_11_2_right_integrable
theorem dlmf_5_9_11_2_right_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-2 * Real.pi * t) *
      scaledGamma (-t * Complex.I) / (t + Complex.I * x)) (Ioi 0)
-- ANCHOR_END: dlmf_5_9_11_2_right_integrable
:= by sorry

/-- DLMF 5.9.11_2. Reciprocal scaled-Gamma value identity. -/
-- ANCHOR: dlmf_5_9_11_2
theorem dlmf_5_9_11_2 {x : ℝ} (hx : 0 < x) :
    1 / scaledGamma x = 1 - (1 / (2 * Real.pi * Complex.I)) *
      (∫ t in Ioi (0 : ℝ), Real.exp (-2 * Real.pi * t) *
        scaledGamma (t * Complex.I) / (t - Complex.I * x)) +
      (1 / (2 * Real.pi * Complex.I)) *
      (∫ t in Ioi (0 : ℝ), Real.exp (-2 * Real.pi * t) *
        scaledGamma (-t * Complex.I) / (t + Complex.I * x))
-- ANCHOR_END: dlmf_5_9_11_2
:= by sorry

end LMLF.Blueprint.Gamma.Section59
