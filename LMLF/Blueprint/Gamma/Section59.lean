import LMLF.Definitions.Gamma
import Mathlib.Analysis.SpecialFunctions.Gamma.Digamma
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import Mathlib.NumberTheory.LSeries.RiemannZeta

/-!
# DLMF 5.9: integral representations for Gamma and psi

Ordinary integrals are paired with their integrability assertions; conditionally convergent Fourier
integrals are stated as limits of finite interval integrals.  The one contour formula uses explicit
finite Hankel contours and two limits.
-/

open Filter MeasureTheory Set
open scoped Interval Topology

noncomputable section

namespace LMLF.Blueprint.Gamma.Section59

/-- DLMF 5.9.20. The integral of `f` along the straight segment from `a` to `b`. -/
-- ANCHOR: complexSegmentIntegral
noncomputable def complexSegmentIntegral (f : ℂ → ℂ) (a b : ℂ) : ℂ :=
  (b - a) * ∫ u in (0 : ℝ)..1, f (a + (u : ℂ) * (b - a))
-- ANCHOR_END: complexSegmentIntegral

/-- DLMF 5.9.2. A finite Hankel contour with explicit continuous branch arguments:
the lower bank uses `-π`, the circle runs through `-π ≤ θ ≤ π`, and the upper bank uses `+π`. -/
-- ANCHOR: hankelTruncation
noncomputable def hankelTruncation (z : ℂ) (R ε : ℝ) : ℂ :=
  ∫ r in R..ε,
      Complex.exp ((r : ℂ) * Complex.exp (-(Real.pi : ℂ) * Complex.I)) *
        Complex.exp (-z * ((Real.log r : ℂ) - (Real.pi : ℂ) * Complex.I)) *
        Complex.exp (-(Real.pi : ℂ) * Complex.I) +
    ∫ θ in (-Real.pi)..Real.pi,
      Complex.exp ((ε : ℂ) * Complex.exp ((θ : ℂ) * Complex.I)) *
        Complex.exp (-z * ((Real.log ε : ℂ) + (θ : ℂ) * Complex.I)) *
        ((ε : ℂ) * Complex.I * Complex.exp ((θ : ℂ) * Complex.I)) +
    ∫ r in ε..R,
      Complex.exp ((r : ℂ) * Complex.exp ((Real.pi : ℂ) * Complex.I)) *
        Complex.exp (-z * ((Real.log r : ℂ) + (Real.pi : ℂ) * Complex.I)) *
      Complex.exp ((Real.pi : ℂ) * Complex.I)
-- ANCHOR_END: hankelTruncation

/-- DLMF 5.9.1. Generalized Euler integral, including absolute convergence. -/
-- ANCHOR: dlmf_5_9_1
theorem dlmf_5_9_1 {z ν : ℂ} {μ : ℝ} (hμ : 0 < μ) (hν : 0 < ν.re) (hz : 0 < z.re) :
    IntegrableOn
        (fun t : ℝ ↦ Complex.exp (-z * (Real.rpow t μ : ℂ)) * (t : ℂ) ^ (ν - 1))
        (Ioi 0) ∧
      (1 / (μ : ℂ)) * Complex.Gamma (ν / μ) / z ^ (ν / μ) =
        ∫ t in Ioi (0 : ℝ),
          Complex.exp (-z * (Real.rpow t μ : ℂ)) * (t : ℂ) ^ (ν - 1)
-- ANCHOR_END: dlmf_5_9_1
:= by sorry

/-- DLMF 5.9.2. Hankel's loop integral, with both limiting processes explicit. -/
-- ANCHOR: dlmf_5_9_2
theorem dlmf_5_9_2 (z : ℂ) :
    ∃ outer : ℝ → ℂ,
      (∀ ε > 0,
        Tendsto (fun R : ℝ ↦ hankelTruncation z R ε)
          atTop (nhds (outer ε))) ∧
      Tendsto outer (nhdsWithin 0 (Ioi 0))
        (nhds (2 * Real.pi * Complex.I / Complex.Gamma z))
-- ANCHOR_END: dlmf_5_9_2
:= by sorry

/-- DLMF 5.9.2_5. The phase function; its totalized value at the removable point `t = 0`
is immaterial to the interval integral. -/
-- ANCHOR: temmePhase
noncomputable def temmePhase (t : ℝ) : ℝ :=
  1 - t / Real.tan t + Real.log (t / Real.sin t)
-- ANCHOR_END: temmePhase

/-- DLMF 5.9.2_5. Temme's finite-interval representation. -/
-- ANCHOR: dlmf_5_9_2_5
theorem dlmf_5_9_2_5 {z : ℂ} (hz : 0 < z.re) :
    IntervalIntegrable (fun t : ℝ ↦ Complex.exp (-z * temmePhase t)) volume
        (-Real.pi) Real.pi ∧
      1 / Complex.Gamma z =
        Complex.exp z * z ^ (1 - z) / (2 * Real.pi) *
          ∫ t in (-Real.pi)..Real.pi, Complex.exp (-z * temmePhase t)
-- ANCHOR_END: dlmf_5_9_2_5
:= by sorry

/-- DLMF 5.9.3. Gaussian form of Euler's integral. -/
-- ANCHOR: dlmf_5_9_3
theorem dlmf_5_9_3 {z : ℂ} {c : ℝ} (hc : 0 < c) (hz : 0 < z.re) :
    Integrable (fun t : ℝ ↦ ((|t| : ℝ) : ℂ) ^ (2 * z - 1) * Complex.exp (-c * t ^ 2)) ∧
      (c : ℂ) ^ (-z) * Complex.Gamma z =
        ∫ t : ℝ, ((|t| : ℝ) : ℂ) ^ (2 * z - 1) * Complex.exp (-c * t ^ 2)
-- ANCHOR_END: dlmf_5_9_3
:= by sorry

/-- DLMF 5.9.4. Meromorphic continuation split at one. -/
-- ANCHOR: dlmf_5_9_4
theorem dlmf_5_9_4 {z : ℂ} (hz : ∀ k : ℕ, z ≠ -(k : ℂ)) :
    IntegrableOn (fun t : ℝ ↦ (t : ℂ) ^ (z - 1) * Real.exp (-t)) (Ici 1) ∧
      Summable (fun k : ℕ ↦ (-1 : ℂ) ^ k / ((z + k) * k.factorial)) ∧
      Complex.Gamma z =
        (∫ t in Ici (1 : ℝ), (t : ℂ) ^ (z - 1) * Real.exp (-t)) +
          ∑' k : ℕ, (-1 : ℂ) ^ k / ((z + k) * k.factorial)
-- ANCHOR_END: dlmf_5_9_4
:= by sorry

/-- DLMF 5.9.5. Euler's integral after subtracting a Taylor polynomial at zero. -/
-- ANCHOR: dlmf_5_9_5
theorem dlmf_5_9_5 (n : ℕ) {z : ℂ} (hl : -(n : ℝ) - 1 < z.re) (hu : z.re < -n) :
    IntegrableOn
        (fun t : ℝ ↦ (t : ℂ) ^ (z - 1) *
          (Real.exp (-t) - ∑ k ∈ Finset.range (n + 1), (-1 : ℂ) ^ k * t ^ k / k.factorial))
        (Ioi 0) ∧
      Complex.Gamma z = ∫ t in Ioi (0 : ℝ), (t : ℂ) ^ (z - 1) *
        (Real.exp (-t) - ∑ k ∈ Finset.range (n + 1), (-1 : ℂ) ^ k * t ^ k / k.factorial)
-- ANCHOR_END: dlmf_5_9_5
:= by sorry

/-- DLMF 5.9.6. The conditionally convergent cosine Mellin integral. -/
-- ANCHOR: dlmf_5_9_6
theorem dlmf_5_9_6 {z : ℂ} (hl : 0 < z.re) (hu : z.re < 1) :
    Tendsto (fun R : ℝ ↦ ∫ t in (0 : ℝ)..R, (t : ℂ) ^ (z - 1) * Real.cos t)
      atTop (nhds (Complex.Gamma z * Complex.cos (Real.pi * z / 2)))
-- ANCHOR_END: dlmf_5_9_6
:= by sorry

/-- DLMF 5.9.7. The conditionally convergent sine Mellin integral. -/
-- ANCHOR: dlmf_5_9_7
theorem dlmf_5_9_7 {z : ℂ} (hl : -1 < z.re) (hu : z.re < 1) :
    Tendsto (fun R : ℝ ↦ ∫ t in (0 : ℝ)..R, (t : ℂ) ^ (z - 1) * Real.sin t)
      atTop (nhds (Complex.Gamma z * Complex.sin (Real.pi * z / 2)))
-- ANCHOR_END: dlmf_5_9_7
:= by sorry

/-- DLMF 5.9.8. The cosine power-phase integral. -/
-- ANCHOR: dlmf_5_9_8
theorem dlmf_5_9_8 {n : ℕ} (hn : 2 ≤ n) :
    Tendsto (fun R : ℝ ↦ ∫ t in (0 : ℝ)..R, Real.cos (t ^ n)) atTop
      (nhds (Real.Gamma (1 + 1 / (n : ℝ)) * Real.cos (Real.pi / (2 * n))))
-- ANCHOR_END: dlmf_5_9_8
:= by sorry

/-- DLMF 5.9.9. The sine power-phase integral. -/
-- ANCHOR: dlmf_5_9_9
theorem dlmf_5_9_9 {n : ℕ} (hn : 2 ≤ n) :
    Tendsto (fun R : ℝ ↦ ∫ t in (0 : ℝ)..R, Real.sin (t ^ n)) atTop
      (nhds (Real.Gamma (1 + 1 / (n : ℝ)) * Real.sin (Real.pi / (2 * n))))
-- ANCHOR_END: dlmf_5_9_9
:= by sorry

/-- DLMF 5.9.10. Binet's first formula on the positive real axis. -/
-- ANCHOR: dlmf_5_9_10
theorem dlmf_5_9_10 {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.arctan (t / x) / (Real.exp (2 * Real.pi * t) - 1))
        (Ioi 0) ∧
      Real.log (Real.Gamma x) =
        (x - 1 / 2) * Real.log x - x + Real.log (2 * Real.pi) / 2 +
          2 * ∫ t in Ioi (0 : ℝ), Real.arctan (t / x) / (Real.exp (2 * Real.pi * t) - 1)
-- ANCHOR_END: dlmf_5_9_10
:= by sorry

/-- DLMF 5.9.10_1. The integration-by-parts form of Binet's formula, for positive reals. -/
-- ANCHOR: dlmf_5_9_10_1
theorem dlmf_5_9_10_1 {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.log (1 - Real.exp (-2 * Real.pi * t)) / (t ^ 2 + x ^ 2))
        (Ioi 0) ∧
      Real.log (Real.Gamma x) =
        (x - 1 / 2) * Real.log x - x + Real.log (2 * Real.pi) / 2 -
          x / Real.pi * ∫ t in Ioi (0 : ℝ),
            Real.log (1 - Real.exp (-2 * Real.pi * t)) / (t ^ 2 + x ^ 2)
-- ANCHOR_END: dlmf_5_9_10_1
:= by sorry

/-- DLMF 5.9.10_2. The Laplace-integral form of Binet's formula, for positive reals. -/
-- ANCHOR: dlmf_5_9_10_2
theorem dlmf_5_9_10_2 {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-x * t) *
      (1 / (Real.exp t - 1) - 1 / t + 1 / 2) / t) (Ioi 0) ∧
      Real.log (Real.Gamma x) =
        (x - 1 / 2) * Real.log x - x + Real.log (2 * Real.pi) / 2 +
          ∫ t in Ioi (0 : ℝ), Real.exp (-x * t) *
            (1 / (Real.exp t - 1) - 1 / t + 1 / 2) / t
-- ANCHOR_END: dlmf_5_9_10_2
:= by sorry

/-- DLMF 5.9.11 and 5.9.17. Integral along the vertical line `re s = -c`, oriented upward. -/
-- ANCHOR: verticalLineIntegral
noncomputable def verticalLineIntegral (c : ℝ) (f : ℂ → ℂ) : ℂ :=
  ∫ y : ℝ, f (-c + y * Complex.I) * Complex.I
-- ANCHOR_END: verticalLineIntegral

/-- DLMF 5.9.11, specialized to positive real `x`. -/
-- ANCHOR: dlmf_5_9_11
theorem dlmf_5_9_11 {x c : ℝ} (hx : 0 < x) (hc1 : 1 < c) (hc2 : c < 2) :
    Integrable (fun y : ℝ ↦
      (Real.pi : ℂ) * (x : ℂ) ^ (-(-c + y * Complex.I)) /
        ((-c + y * Complex.I) * Complex.sin (Real.pi * (-c + y * Complex.I))) *
        riemannZeta (-(-c + y * Complex.I)) * Complex.I) ∧
      (Real.log (Real.Gamma (x + 1)) : ℂ) =
        -Real.eulerMascheroniConstant * x -
          verticalLineIntegral c (fun s ↦
            Real.pi * (x : ℂ) ^ (-s) / (s * Complex.sin (Real.pi * s)) * riemannZeta (-s)) /
            (2 * Real.pi * Complex.I)
-- ANCHOR_END: dlmf_5_9_11
:= by sorry

/-- The scaled Gamma function used in DLMF 5.9.11_1 and 5.9.11_2. -/
-- ANCHOR: scaledGamma
noncomputable def scaledGamma (z : ℂ) : ℂ :=
  Complex.Gamma z /
    ((2 * Real.pi : ℂ) ^ (1 / 2 : ℂ) * z ^ (z - 1 / 2) * Complex.exp (-z))
-- ANCHOR_END: scaledGamma

/-- DLMF 5.9.11_1, specialized to positive real arguments. -/
-- ANCHOR: dlmf_5_9_11_1
theorem dlmf_5_9_11_1 {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-2 * Real.pi * t) *
      scaledGamma (t * Complex.I) / (t + Complex.I * x)) (Ioi 0) ∧
    IntegrableOn (fun t : ℝ ↦ Real.exp (-2 * Real.pi * t) *
      scaledGamma (-t * Complex.I) / (t - Complex.I * x)) (Ioi 0) ∧
    scaledGamma x = 1 - (1 / (2 * Real.pi * Complex.I)) *
      (∫ t in Ioi (0 : ℝ), Real.exp (-2 * Real.pi * t) *
        scaledGamma (t * Complex.I) / (t + Complex.I * x)) +
      (1 / (2 * Real.pi * Complex.I)) *
      (∫ t in Ioi (0 : ℝ), Real.exp (-2 * Real.pi * t) *
        scaledGamma (-t * Complex.I) / (t - Complex.I * x))
-- ANCHOR_END: dlmf_5_9_11_1
:= by sorry

/-- DLMF 5.9.11_2, specialized to positive real arguments. -/
-- ANCHOR: dlmf_5_9_11_2
theorem dlmf_5_9_11_2 {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-2 * Real.pi * t) *
      scaledGamma (t * Complex.I) / (t - Complex.I * x)) (Ioi 0) ∧
    IntegrableOn (fun t : ℝ ↦ Real.exp (-2 * Real.pi * t) *
      scaledGamma (-t * Complex.I) / (t + Complex.I * x)) (Ioi 0) ∧
    1 / scaledGamma x = 1 - (1 / (2 * Real.pi * Complex.I)) *
      (∫ t in Ioi (0 : ℝ), Real.exp (-2 * Real.pi * t) *
        scaledGamma (t * Complex.I) / (t - Complex.I * x)) +
      (1 / (2 * Real.pi * Complex.I)) *
      (∫ t in Ioi (0 : ℝ), Real.exp (-2 * Real.pi * t) *
        scaledGamma (-t * Complex.I) / (t + Complex.I * x))
-- ANCHOR_END: dlmf_5_9_11_2
:= by sorry

/-- DLMF 5.9.12, specialized to the positive real axis. -/
-- ANCHOR: dlmf_5_9_12
theorem dlmf_5_9_12 {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-t) / t - Real.exp (-x * t) / (1 - Real.exp (-t)))
        (Ioi 0) ∧
      Complex.digamma x = ∫ t in Ioi (0 : ℝ),
        Real.exp (-t) / t - Real.exp (-x * t) / (1 - Real.exp (-t))
-- ANCHOR_END: dlmf_5_9_12
:= by sorry

/-- DLMF 5.9.13, specialized to the positive real axis. -/
-- ANCHOR: dlmf_5_9_13
theorem dlmf_5_9_13 {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ (1 / t - 1 / (1 - Real.exp (-t))) * Real.exp (-t * x))
        (Ioi 0) ∧
      Complex.digamma x = Real.log x + ∫ t in Ioi (0 : ℝ),
        (1 / t - 1 / (1 - Real.exp (-t))) * Real.exp (-t * x)
-- ANCHOR_END: dlmf_5_9_13
:= by sorry

/-- DLMF 5.9.14, specialized to the positive real axis. -/
-- ANCHOR: dlmf_5_9_14
theorem dlmf_5_9_14 {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ (Real.exp (-t) - (1 + t) ^ (-x)) / t) (Ioi 0) ∧
      Complex.digamma x = ∫ t in Ioi (0 : ℝ), (Real.exp (-t) - (1 + t) ^ (-x)) / t
-- ANCHOR_END: dlmf_5_9_14
:= by sorry

/-- DLMF 5.9.15, specialized to the positive real axis. -/
-- ANCHOR: dlmf_5_9_15
theorem dlmf_5_9_15 {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ t / ((t ^ 2 + x ^ 2) * (Real.exp (2 * Real.pi * t) - 1)))
        (Ioi 0) ∧
      Complex.digamma x = (Real.log x - 1 / (2 * x) : ℝ) -
        (2 : ℂ) * (↑((∫ t in Ioi (0 : ℝ),
          (t / ((t ^ 2 + x ^ 2) * (Real.exp (2 * Real.pi * t) - 1)) : ℝ)) : ℝ) : ℂ)
-- ANCHOR_END: dlmf_5_9_15
:= by sorry

/-- DLMF 5.9.16, specialized to the positive real axis. -/
-- ANCHOR: dlmf_5_9_16
theorem dlmf_5_9_16 {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ (Real.exp (-t) - Real.exp (-x * t)) / (1 - Real.exp (-t)))
        (Ioi 0) ∧
    IntegrableOn (fun t : ℝ ↦ (1 - t ^ (x - 1)) / (1 - t)) (Ioo 0 1) ∧
    Complex.digamma x + Real.eulerMascheroniConstant =
      ∫ t in Ioi (0 : ℝ), (Real.exp (-t) - Real.exp (-x * t)) / (1 - Real.exp (-t)) ∧
    Complex.digamma x + Real.eulerMascheroniConstant =
      ∫ t in Ioo (0 : ℝ) 1, (1 - t ^ (x - 1)) / (1 - t)
-- ANCHOR_END: dlmf_5_9_16
:= by sorry

/-- DLMF 5.9.17, specialized to positive real `x`. -/
-- ANCHOR: dlmf_5_9_17
theorem dlmf_5_9_17 {x c : ℝ} (hx : 0 < x) (hc1 : 1 < c) (hc2 : c < 2) :
    Integrable (fun y : ℝ ↦ Real.pi * (x : ℂ) ^ (-(-c + y * Complex.I) - 1) /
      Complex.sin (Real.pi * (-c + y * Complex.I)) * riemannZeta (-(-c + y * Complex.I)) *
      Complex.I) ∧
    Complex.digamma (x + 1) = -Real.eulerMascheroniConstant +
      verticalLineIntegral c (fun s ↦ Real.pi * (x : ℂ) ^ (-s - 1) /
        Complex.sin (Real.pi * s) * riemannZeta (-s)) / (2 * Real.pi * Complex.I)
-- ANCHOR_END: dlmf_5_9_17
:= by sorry

/-- DLMF 5.9.18. Four convergent integral representations of Euler's constant. -/
-- ANCHOR: dlmf_5_9_18
theorem dlmf_5_9_18 :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-t) * Real.log t) (Ioi 0) ∧
    IntegrableOn (fun t : ℝ ↦ (1 / (1 + t) - Real.exp (-t)) / t) (Ioi 0) ∧
    IntegrableOn (fun t : ℝ ↦ (1 - Real.exp (-t)) / t) (Ioo 0 1) ∧
    IntegrableOn (fun t : ℝ ↦ Real.exp (-t) / t) (Ici 1) ∧
    IntegrableOn (fun t : ℝ ↦ (Real.exp (-t) / (1 - Real.exp (-t)) - Real.exp (-t) / t))
      (Ioi 0) ∧
    Real.eulerMascheroniConstant = -∫ t in Ioi (0 : ℝ), Real.exp (-t) * Real.log t ∧
    Real.eulerMascheroniConstant = ∫ t in Ioi (0 : ℝ), (1 / (1 + t) - Real.exp (-t)) / t ∧
    Real.eulerMascheroniConstant =
      (∫ t in Ioo (0 : ℝ) 1, (1 - Real.exp (-t)) / t) -
        ∫ t in Ici (1 : ℝ), Real.exp (-t) / t ∧
    Real.eulerMascheroniConstant = ∫ t in Ioi (0 : ℝ),
      Real.exp (-t) / (1 - Real.exp (-t)) - Real.exp (-t) / t
-- ANCHOR_END: dlmf_5_9_18
:= by sorry

/-- DLMF 5.9.19. Differentiating Euler's integral under the integral sign. -/
-- ANCHOR: dlmf_5_9_19
theorem dlmf_5_9_19 (n : ℕ) {z : ℂ} (hz : 0 < z.re) :
    IntegrableOn (fun t : ℝ ↦ (Real.log t : ℂ) ^ n * Real.exp (-t) * (t : ℂ) ^ (z - 1))
        (Ioi 0) ∧
      iteratedDeriv n Complex.Gamma z = ∫ t in Ioi (0 : ℝ),
        (Real.log t : ℂ) ^ n * Real.exp (-t) * (t : ℂ) ^ (z - 1)
-- ANCHOR_END: dlmf_5_9_19
:= by sorry

/-- DLMF 5.9.20. Integrating Gamma along a straight segment in the right half-plane;
the quotient's totalized value at the removable point `t = 1` is immaterial to the integral. -/
-- ANCHOR: dlmf_5_9_20
theorem dlmf_5_9_20 {c z : ℂ} (hc : 0 < c.re) (hz : 0 < z.re) :
    IntegrableOn (fun t : ℝ ↦ ((t : ℂ) ^ (z - 1) - (t : ℂ) ^ (c - 1)) /
      Real.log t * Real.exp (-t)) (Ioi 0) ∧
    complexSegmentIntegral Complex.Gamma c z = ∫ t in Ioi (0 : ℝ),
      ((t : ℂ) ^ (z - 1) - (t : ℂ) ^ (c - 1)) / Real.log t * Real.exp (-t)
-- ANCHOR_END: dlmf_5_9_20
:= by sorry

end LMLF.Blueprint.Gamma.Section59
