import LMLF.Definitions.Gamma
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic

/-!
# DLMF §5.13: integrals

Whole-line integrals are ordinary Bochner integrals.  The first display is written on its
straight vertical contour by the usual real parameterization `s = c + i t`.
-/

open Filter MeasureTheory Set
open scoped BigOperators

noncomputable section

namespace LMLF.Blueprint.Gamma.Section513

/-- DLMF 5.13.1: the ordinary integral on the upward vertical line `Re s = c`.

The factor `Complex.I` is `ds/dt` for the parameterization `s = c + i t`, so this
definition displays the contour orientation rather than hiding it in an opaque predicate.
-/
-- ANCHOR: verticalLineIntegral
noncomputable def verticalLineIntegral (c : ℝ) (f : ℂ → ℂ) : ℂ :=
  ∫ t : ℝ, f ((c : ℂ) + (t : ℂ) * Complex.I) * Complex.I
-- ANCHOR_END: verticalLineIntegral

/-- DLMF 5.13.5: the four-factor numerator in the de Branges--Wilson integrand. -/
-- ANCHOR: deBrangesWilsonNumerator
noncomputable def deBrangesWilsonNumerator (a : Fin 4 → ℂ) (t : ℝ) : ℂ :=
  ∏ k : Fin 4, Complex.Gamma (a k + (t : ℂ) * Complex.I) *
    Complex.Gamma (a k - (t : ℂ) * Complex.I)
-- ANCHOR_END: deBrangesWilsonNumerator

/-- DLMF 5.13.1: Barnes' vertical-line integral for the beta-function quotient. -/
-- DLMF 5.13.1 https://dlmf.nist.gov/5.13.E1
-- ANCHOR: dlmf_5_13_1
theorem dlmf_5_13_1 {a b z : ℂ} {c : ℝ}
    (hab : 0 < (a + b).re) (hc : -a.re < c) (hc' : c < b.re) (hz0 : z ≠ 0)
    (hz : |Complex.arg z| < Real.pi) :
    Integrable (fun t : ℝ ↦
      Complex.Gamma ((c : ℂ) + (t : ℂ) * Complex.I + a) *
        Complex.Gamma (b - ((c : ℂ) + (t : ℂ) * Complex.I)) *
        z ^ (-((c : ℂ) + (t : ℂ) * Complex.I)) * Complex.I) ∧
      (1 / (2 * Real.pi * Complex.I)) *
          verticalLineIntegral c (fun s : ℂ ↦
            Complex.Gamma (s + a) * Complex.Gamma (b - s) * z ^ (-s)) =
        Complex.Gamma (a + b) * z ^ a / (1 + z) ^ (a + b)
-- ANCHOR_END: dlmf_5_13_1
  := by sorry

/-- DLMF 5.13.2: the modulus-square Barnes integral, for real `a` and `b`. -/
-- DLMF 5.13.2 https://dlmf.nist.gov/5.13.E2
-- ANCHOR: dlmf_5_13_2
theorem dlmf_5_13_2 {a b : ℝ} (ha : 0 < a) (hb0 : 0 < b) (hbπ : b < Real.pi) :
    Integrable (fun t : ℝ ↦
      ‖Complex.Gamma ((a : ℂ) + (t : ℂ) * Complex.I)‖ ^ 2 *
        Real.exp ((2 * b - Real.pi) * t)) ∧
      (1 / (2 * Real.pi : ℝ)) *
          ∫ t : ℝ,
            ‖Complex.Gamma ((a : ℂ) + (t : ℂ) * Complex.I)‖ ^ 2 *
              Real.exp ((2 * b - Real.pi) * t) =
        Real.Gamma (2 * a) / (2 * Real.sin b) ^ (2 * a)
-- ANCHOR_END: dlmf_5_13_2
  := by sorry

/-- DLMF 5.13.3: Barnes' beta integral with four complex parameters. -/
-- DLMF 5.13.3 https://dlmf.nist.gov/5.13.E3
-- ANCHOR: dlmf_5_13_3
theorem dlmf_5_13_3 {a b c d : ℂ}
    (ha : 0 < a.re) (hb : 0 < b.re) (hc : 0 < c.re) (hd : 0 < d.re) :
    Integrable (fun t : ℝ ↦
      Complex.Gamma (a + (t : ℂ) * Complex.I) *
        Complex.Gamma (b + (t : ℂ) * Complex.I) *
        Complex.Gamma (c - (t : ℂ) * Complex.I) *
        Complex.Gamma (d - (t : ℂ) * Complex.I)) ∧
      (1 / (2 * Real.pi : ℂ)) *
          ∫ t : ℝ,
            Complex.Gamma (a + (t : ℂ) * Complex.I) *
              Complex.Gamma (b + (t : ℂ) * Complex.I) *
              Complex.Gamma (c - (t : ℂ) * Complex.I) *
              Complex.Gamma (d - (t : ℂ) * Complex.I) =
        Complex.Gamma (a + c) * Complex.Gamma (a + d) *
          Complex.Gamma (b + c) * Complex.Gamma (b + d) /
            Complex.Gamma (a + b + c + d)
-- ANCHOR_END: dlmf_5_13_3
  := by sorry

/-- DLMF 5.13.4: Ramanujan's beta integral. -/
-- DLMF 5.13.4 https://dlmf.nist.gov/5.13.E4
-- ANCHOR: dlmf_5_13_4
theorem dlmf_5_13_4 {a b c d : ℂ} (hs : 3 < (a + b + c + d).re) :
    Integrable (fun t : ℝ ↦
      1 / (Complex.Gamma (a + (t : ℂ)) * Complex.Gamma (b + (t : ℂ)) *
        Complex.Gamma (c - (t : ℂ)) * Complex.Gamma (d - (t : ℂ)))) ∧
      ∫ t : ℝ,
          1 / (Complex.Gamma (a + (t : ℂ)) * Complex.Gamma (b + (t : ℂ)) *
            Complex.Gamma (c - (t : ℂ)) * Complex.Gamma (d - (t : ℂ))) =
        Complex.Gamma (a + b + c + d - 3) /
          (Complex.Gamma (a + c - 1) * Complex.Gamma (a + d - 1) *
            Complex.Gamma (b + c - 1) * Complex.Gamma (b + d - 1))
-- ANCHOR_END: dlmf_5_13_4
  := by sorry

/-- DLMF 5.13.5: de Branges--Wilson's beta integral. -/
-- DLMF 5.13.5 https://dlmf.nist.gov/5.13.E5
-- ANCHOR: dlmf_5_13_5
theorem dlmf_5_13_5 (a : Fin 4 → ℂ) (ha : ∀ k : Fin 4, 0 < (a k).re) :
    Integrable (fun t : ℝ ↦
      deBrangesWilsonNumerator a t /
        (Complex.Gamma (2 * (t : ℂ) * Complex.I) *
          Complex.Gamma (-2 * (t : ℂ) * Complex.I))) ∧
      (1 / (4 * Real.pi : ℝ)) *
          ∫ t : ℝ,
            deBrangesWilsonNumerator a t /
              (Complex.Gamma (2 * (t : ℂ) * Complex.I) *
                Complex.Gamma (-2 * (t : ℂ) * Complex.I)) =
        (∏ j : Fin 4, ∏ k : Fin 4, if j < k then Complex.Gamma (a j + a k) else 1) /
          Complex.Gamma (∑ k : Fin 4, a k)
-- ANCHOR_END: dlmf_5_13_5
  := by sorry

end LMLF.Blueprint.Gamma.Section513
