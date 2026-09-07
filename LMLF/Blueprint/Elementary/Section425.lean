import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Inverse
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Arctan
import Mathlib.Analysis.RCLike.Sqrt

/-!
# DLMF 4.25: continued fractions

The five displays in this section are represented by explicit coefficient streams
and finite convergents.  Thus the signs and the index sequences in the printed
fractions remain visible in the statements, while `Tendsto` records the meaning
of the infinite fraction.
-/

namespace LMLF.Blueprint.Elementary.Section425

noncomputable section

open Filter

/-- DLMF 4.25.1--4.25.5: finite continued-fraction tails and convergents. -/
-- ANCHOR: continuedFractionTail
def continuedFractionTail (numerator denominator : ℕ → ℂ) (offset depth : ℕ) : ℂ :=
  match depth with
  | 0 => 0
  | n + 1 => numerator offset /
      (denominator offset + continuedFractionTail numerator denominator (offset + 1) n)
-- ANCHOR_END: continuedFractionTail

/-- DLMF 4.25.1--4.25.5: finite continued-fraction convergents. -/
-- ANCHOR: continuedFractionConvergent
def continuedFractionConvergent (numerator denominator : ℕ → ℂ) (depth : ℕ) : ℂ :=
  continuedFractionTail numerator denominator 0 (depth + 1)
-- ANCHOR_END: continuedFractionConvergent

/-- DLMF 4.25.1: the tangent fraction has numerator `z` followed by `-z^2`
   and odd denominators. -/
-- ANCHOR: tangentFractionNumerator
def tangentFractionNumerator (z : ℂ) : ℕ → ℂ
  | 0 => z
  | _ + 1 => -z ^ 2
-- ANCHOR_END: tangentFractionNumerator

/-- DLMF 4.25.1: odd denominators `1,3,5, …` in the tangent fraction. -/
-- ANCHOR: oddFractionDenominator
def oddFractionDenominator : ℕ → ℂ := fun n => (2 * n + 1 : ℕ)
-- ANCHOR_END: oddFractionDenominator

/-- DLMF 4.25.1: the tangent poles `(2k+1)π/2`. -/
-- ANCHOR: tangentPole
def tangentPole (k : ℤ) : ℂ := ((2 * k + 1 : ℤ) : ℂ) * (Real.pi : ℂ) / 2
-- ANCHOR_END: tangentPole

/-- DLMF 4.25.2: coefficients `(n+1)^2-a^2` and odd denominators after the
   initial numerator `a tan z`. -/
-- ANCHOR: scaledTangentFractionNumerator
def scaledTangentFractionNumerator (a z : ℂ) : ℕ → ℂ
  | 0 => a * Complex.tan z
  | n + 1 => (((n + 1 : ℕ) : ℂ) ^ 2 - a ^ 2) * Complex.tan z ^ 2
-- ANCHOR_END: scaledTangentFractionNumerator

/-- DLMF 4.25.2: odd denominators in the scaled tangent fraction. -/
-- ANCHOR: scaledTangentFractionDenominator
def scaledTangentFractionDenominator : ℕ → ℂ := oddFractionDenominator
-- ANCHOR_END: scaledTangentFractionDenominator

/-- DLMF 4.25.3: the negative products `1·2, 3·4, …` are the noninitial
   numerators of the arcsine fraction. -/
-- ANCHOR: arcsineFractionNumerator
def arcsineFractionNumerator (z : ℂ) : ℕ → ℂ
  | 0 => z
  | n + 1 => -(((2 * (n + 1) - 1 : ℕ) : ℂ) *
      ((2 * (n + 1) : ℕ) : ℂ) * z ^ 2)
-- ANCHOR_END: arcsineFractionNumerator

/-- DLMF 4.25.3: odd denominators in the arcsine fraction. -/
-- ANCHOR: arcsineFractionDenominator
def arcsineFractionDenominator : ℕ → ℂ := oddFractionDenominator
-- ANCHOR_END: arcsineFractionDenominator

/-- DLMF 4.25.3: principal arcsine in logarithmic form. -/
-- ANCHOR: principalArcsin
def principalArcsin (z : ℂ) : ℂ :=
  -Complex.I * Complex.log (Complex.sqrt (1 - z ^ 2) + Complex.I * z)
-- ANCHOR_END: principalArcsin

/-- DLMF 4.25.4: the positive square coefficients `1^2, 2^2, …` in the
   arctangent fraction. -/
-- ANCHOR: arctangentFractionNumerator
def arctangentFractionNumerator (z : ℂ) : ℕ → ℂ
  | 0 => z
  | n + 1 => (((n + 1 : ℕ) : ℂ) ^ 2) * z ^ 2
-- ANCHOR_END: arctangentFractionNumerator

/-- DLMF 4.25.4: odd denominators in the arctangent fraction. -/
-- ANCHOR: arctangentFractionDenominator
def arctangentFractionDenominator : ℕ → ℂ := oddFractionDenominator
-- ANCHOR_END: arctangentFractionDenominator

/-- DLMF 4.25.4: principal arctangent in logarithmic form. -/
-- ANCHOR: principalArctan
def principalArctan (z : ℂ) : ℂ :=
  Complex.I / 2 * Complex.log ((Complex.I + z) / (Complex.I - z))
-- ANCHOR_END: principalArctan

/-- DLMF 4.25.5: the outer numerator is `2a`; the subsequent numerators are
   `a^2+1^2, a^2+2^2, …`, and the denominators are `z-a,3z,5z,…`. -/
-- ANCHOR: exponentialArctanFractionNumerator
def exponentialArctanFractionNumerator (a : ℂ) : ℕ → ℂ
  | 0 => 2 * a
  | n + 1 => a ^ 2 + (((n + 1 : ℕ) : ℂ) ^ 2)
-- ANCHOR_END: exponentialArctanFractionNumerator

/-- DLMF 4.25.5: denominators `z-a,3z,5z,…` in the exponential fraction. -/
-- ANCHOR: exponentialArctanFractionDenominator
def exponentialArctanFractionDenominator (a z : ℂ) : ℕ → ℂ
  | 0 => z - a
  | n + 1 => ((2 * (n + 1) + 1 : ℕ) : ℂ) * z
-- ANCHOR_END: exponentialArctanFractionDenominator

/-- DLMF 4.25.1: convergence of the tangent continued fraction. -/
-- ANCHOR: dlmf_4_25_1
theorem dlmf_4_25_1 {z : ℂ} (hpole : ∀ k : ℤ, z ≠ tangentPole k) :
    Tendsto
        (fun depth =>
          continuedFractionConvergent (tangentFractionNumerator z)
            oddFractionDenominator depth)
        atTop (nhds (Complex.tan z)) := by
  sorry
-- ANCHOR_END: dlmf_4_25_1

/-- DLMF 4.25.2: convergence of the scaled tangent continued fraction. -/
-- ANCHOR: dlmf_4_25_2
theorem dlmf_4_25_2 {a z : ℂ} (hz : |z.re| < Real.pi / 2)
    (hpole : ∀ k : ℤ, a * z ≠ tangentPole k) :
    Tendsto
        (fun depth =>
          continuedFractionConvergent (scaledTangentFractionNumerator a z)
            scaledTangentFractionDenominator depth)
        atTop (nhds (Complex.tan (a * z))) := by
  sorry
-- ANCHOR_END: dlmf_4_25_2

/-- DLMF 4.25.3: convergence of the arcsine continued fraction. -/
-- ANCHOR: dlmf_4_25_3
theorem dlmf_4_25_3 {z : ℂ}
    (hcut : ¬(z.im = 0 ∧ (z.re ≤ -1 ∨ 1 ≤ z.re))) :
    Tendsto
        (fun depth =>
          continuedFractionConvergent (arcsineFractionNumerator z)
            arcsineFractionDenominator depth)
        atTop
        (nhds (principalArcsin z / Complex.sqrt (1 - z ^ 2))) := by
  sorry
-- ANCHOR_END: dlmf_4_25_3

/-- DLMF 4.25.4: convergence of the arctangent continued fraction. -/
-- ANCHOR: dlmf_4_25_4
theorem dlmf_4_25_4 {z : ℂ}
    (hcut : ¬(z.re = 0 ∧ (z.im ≤ -1 ∨ 1 ≤ z.im))) :
    Tendsto
        (fun depth =>
          continuedFractionConvergent (arctangentFractionNumerator z)
            arctangentFractionDenominator depth)
        atTop (nhds (principalArctan z)) := by
  sorry
-- ANCHOR_END: dlmf_4_25_4

/-- DLMF 4.25.5: convergence of the exponential arctangent continued fraction. -/
-- ANCHOR: dlmf_4_25_5
theorem dlmf_4_25_5 {a z : ℂ} (hz : z ≠ 0)
    (hcut : ¬(z.re = 0 ∧ (-1 ≤ z.im ∧ z.im ≤ 1))) :
    Tendsto
        (fun depth =>
          1 + continuedFractionConvergent
            (exponentialArctanFractionNumerator a)
            (exponentialArctanFractionDenominator a z) depth)
        atTop
        (nhds (Complex.exp (2 * a * principalArctan (1 / z)))) := by
  sorry
-- ANCHOR_END: dlmf_4_25_5

end

end LMLF.Blueprint.Elementary.Section425
