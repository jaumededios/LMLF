import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import Mathlib.Analysis.SpecialFunctions.Pow.Complex
import Mathlib.Analysis.RCLike.Sqrt
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import LMLF.Blueprint.ExponentialIntegrals.Section62
import LMLF.Blueprint.ExponentialIntegrals.Section64

open scoped Interval Topology
open Filter
noncomputable section
open Set MeasureTheory
open LMLF.Blueprint.ExponentialIntegrals.Section62
open LMLF.Blueprint.ExponentialIntegrals.Section64
namespace LMLF.Blueprint.ExponentialIntegrals.Section67

/-! The six tail formulas below use the Section 6.2 limit vocabulary.  In
particular, a Bochner integral over `Ioi` is not used as a totalized proxy for
an improper or conditionally convergent DLMF integral. -/

/- DLMF 6.7.1 -/
-- ANCHOR: dlmf_6_7_1
theorem dlmf_6_7_1 (a b : ℝ) (ha : 0 < a) (hb : 0 < b) :
    HasImproperIntegral
        (fun t : ℝ => Complex.exp (-(a : ℂ) * t) / (t + b)) 0
        (Complex.exp (a * b) * principalE1 (a * b)) ∧
      HasImproperIntegral
        (fun t : ℝ => Complex.exp (Complex.I * a * t) /
          (t + Complex.I * b)) 0
        (Complex.exp (a * b) * principalE1 (a * b))
-- ANCHOR_END: dlmf_6_7_1
  := by sorry

/- DLMF 6.7.2 -/
-- ANCHOR: dlmf_6_7_2
theorem dlmf_6_7_2 (x α : ℝ) (hx : 0 < x) (hα₀ : 0 ≤ α) (hα₁ : α < 1) :
    Complex.exp x *
        (∫ t in (0 : ℝ)..α, Complex.exp (-(x : ℂ) * t) / (1 - t)) =
      realEi x - realEi ((1 - α) * x)
-- ANCHOR_END: dlmf_6_7_2
  := by sorry

/- DLMF 6.7.3 -/
-- ANCHOR: dlmf_6_7_3
theorem dlmf_6_7_3 (a x : ℝ) (ha : 0 < a) (hx : 0 < x) :
    HasImproperIntegral
        (fun t : ℝ => Complex.exp (Complex.I * t) / (a ^ 2 + t ^ 2)) x
        (Complex.I / (2 * a) *
          (Complex.exp a * principalE1 (a - Complex.I * x) -
            Complex.exp (-a) * principalE1 (-a - Complex.I * x)))
-- ANCHOR_END: dlmf_6_7_3
  := by sorry

/- DLMF 6.7.4 -/
-- ANCHOR: dlmf_6_7_4
theorem dlmf_6_7_4 (a x : ℝ) (ha : 0 < a) (hx : 0 < x) :
    HasImproperIntegral
        (fun t : ℝ => (t : ℂ) * Complex.exp (Complex.I * t) /
          (a ^ 2 + t ^ 2)) x
        ((Complex.exp a * principalE1 (a - Complex.I * x) +
            Complex.exp (-a) * principalE1 (-a - Complex.I * x)) / 2)
-- ANCHOR_END: dlmf_6_7_4
  := by sorry

/- DLMF 6.7.5 -/
-- ANCHOR: dlmf_6_7_5
theorem dlmf_6_7_5 (a x : ℝ) (ha : 0 < a) :
    HasImproperIntegral
        (fun t : ℝ => Complex.exp (-t) / (a ^ 2 + t ^ 2)) x
        (-(Complex.exp (Complex.I * a) * principalE1 (x + Complex.I * a) -
            Complex.exp (-Complex.I * a) * principalE1 (x - Complex.I * a)) /
          (2 * a * Complex.I))
-- ANCHOR_END: dlmf_6_7_5
  := by sorry

/- DLMF 6.7.6 -/
-- ANCHOR: dlmf_6_7_6
theorem dlmf_6_7_6 (a x : ℝ) (ha : 0 < a) :
    HasImproperIntegral
        (fun t : ℝ => (t : ℂ) * Complex.exp (-t) /
          (a ^ 2 + t ^ 2)) x
        ((Complex.exp (Complex.I * a) * principalE1 (x + Complex.I * a) +
          Complex.exp (-Complex.I * a) * principalE1 (x - Complex.I * a)) / 2)
-- ANCHOR_END: dlmf_6_7_6
  := by sorry

/- DLMF 6.7.7 -/
-- ANCHOR: dlmf_6_7_7
theorem dlmf_6_7_7 (a b : ℝ) :
    (∫ t in (0 : ℝ)..1,
      Complex.exp (-(a : ℂ) * t) * Complex.sin (b * t) / t) =
      (principalEin (a + Complex.I * b)).im
-- ANCHOR_END: dlmf_6_7_7
  := by sorry

/- DLMF 6.7.8 -/
-- ANCHOR: dlmf_6_7_8
theorem dlmf_6_7_8 (a b : ℝ) :
    (∫ t in (0 : ℝ)..1,
      Complex.exp (-(a : ℂ) * t) * (1 - Complex.cos (b * t)) / t) =
      (principalEin (a + Complex.I * b)).re - (principalEin a).re
-- ANCHOR_END: dlmf_6_7_8
  := by sorry

/- DLMF 6.7.9 -/
-- ANCHOR: dlmf_6_7_9
theorem dlmf_6_7_9 (z : ℂ) :
    si z =
      -(∫ t in (0 : ℝ)..(Real.pi / 2),
        Complex.exp (-z * Complex.cos t) * Complex.cos (z * Complex.sin t))
-- ANCHOR_END: dlmf_6_7_9
  := by sorry

/- DLMF 6.7.10 -/
-- ANCHOR: dlmf_6_7_10
theorem dlmf_6_7_10 (z : ℂ) :
    principalEin z - principalCin z =
      ∫ t in (0 : ℝ)..(Real.pi / 2),
        Complex.exp (-z * Complex.cos t) * Complex.sin (z * Complex.sin t)
-- ANCHOR_END: dlmf_6_7_10
  := by sorry

/- DLMF 6.7.11 -/
-- ANCHOR: dlmf_6_7_11
theorem dlmf_6_7_11 (a b : ℝ) :
    (∫ t in (0 : ℝ)..1,
      (1 - Complex.exp (-(a : ℂ) * t)) * Complex.cos (b * t) / t) =
      (principalEin (a + Complex.I * b)).re - (principalCin b).re
-- ANCHOR_END: dlmf_6_7_11
  := by sorry

/- A path object records only the geometric hypotheses in DLMF §6.7.E12:
the path starts at z, stays in the principal cut domain, and tends to infinity.
The integral value is supplied by `HasImproperPathIntegral`, not stored as a
field of the path object. -/
structure DlmfPrincipalPath where
  z : ℂ
  path : ℝ → ℂ
  path_start : path 0 = z
  regular : regularPath path
  principal : ∀ t : ℝ, 0 ≤ t → principalDomain (path t)
  escapes : Tendsto (fun t : ℝ => ‖path t‖) atTop atTop
  phase_bound : ‖Complex.arg z‖ ≤ Real.pi

/- DLMF §10.25(ii): the positive-real principal modified Bessel K₀ value.
At the measure-zero endpoint x = 0 we use the harmless value 0; positive
arguments are characterized by the standard convergent integral. -/
def principalK0Value (x : ℝ) : ℂ :=
  if 0 < x then
    ∫ u in Ioi (0 : ℝ), (Real.exp (-(x * Real.cosh u)) : ℂ)
  else 0

/- The specification both supplies existence of the positive-real K₀ value and
separates its improper-integral semantics from the totalized definition above. -/
theorem principalK0_spec {x : ℝ} (hx : 0 < x) :
    HasImproperIntegral
      (fun u : ℝ => (Real.exp (-(x * Real.cosh u)) : ℂ)) 0
      (principalK0Value x) := by sorry

/- The standard positive-real K₀ value is unique among improper-integral
values. -/
theorem principalK0_unique {x : ℝ} {v : ℂ} (hx : 0 < x)
    (hv : HasImproperIntegral
      (fun u : ℝ => (Real.exp (-(x * Real.cosh u)) : ℂ)) 0 v) :
    v = principalK0Value x := by sorry

/- DLMF 6.7.12 -/
-- ANCHOR: dlmf_6_7_12
theorem dlmf_6_7_12 (P : DlmfPrincipalPath) :
    HasImproperPathIntegral
        (fun u : ℂ => Complex.exp (Complex.I * u) / u) P.path 0
        (Complex.exp (Complex.I * P.z) *
          (principalAuxiliaryG P.z + Complex.I * principalAuxiliaryF P.z))
-- ANCHOR_END: dlmf_6_7_12
  := by sorry

/- DLMF 6.7.13 -/
-- ANCHOR: dlmf_6_7_13
theorem dlmf_6_7_13 (z : ℝ) (hz : 0 < z) :
    HasImproperIntegral (fun t : ℝ => Complex.sin t / (t + z)) 0
        (principalAuxiliaryF z) ∧
      HasImproperIntegral
        (fun t : ℝ => Complex.exp (-(z : ℂ) * t) / (t ^ 2 + 1)) 0
        (principalAuxiliaryF z)
-- ANCHOR_END: dlmf_6_7_13
  := by sorry

/- DLMF 6.7.14 -/
-- ANCHOR: dlmf_6_7_14
theorem dlmf_6_7_14 (z : ℝ) (hz : 0 < z) :
    HasImproperIntegral (fun t : ℝ => Complex.cos t / (t + z)) 0
        (principalAuxiliaryG z) ∧
      HasImproperIntegral
        (fun t : ℝ => (t : ℂ) * Complex.exp (-(z : ℂ) * t) /
          (t ^ 2 + 1)) 0 (principalAuxiliaryG z)
-- ANCHOR_END: dlmf_6_7_14
  := by sorry

/- DLMF 6.7.15 -/
-- ANCHOR: dlmf_6_7_15
theorem dlmf_6_7_15 (z : ℝ) (hz : 0 < z) :
    HasImproperIntegral
        (fun t : ℝ => principalK0Value (2 * Real.sqrt (z * t)) *
          Complex.cos t) 0 (principalAuxiliaryF z / 2)
-- ANCHOR_END: dlmf_6_7_15
  := by sorry

/- DLMF 6.7.16 -/
-- ANCHOR: dlmf_6_7_16
theorem dlmf_6_7_16 (z : ℝ) (hz : 0 < z) :
    HasImproperIntegral
        (fun t : ℝ => principalK0Value (2 * Real.sqrt (z * t)) *
          Complex.sin t) 0 (principalAuxiliaryG z / 2)
-- ANCHOR_END: dlmf_6_7_16
  := by sorry

end LMLF.Blueprint.ExponentialIntegrals.Section67
