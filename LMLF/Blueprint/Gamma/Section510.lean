import Mathlib.Analysis.SpecialFunctions.Gamma.Basic
import Mathlib.NumberTheory.Bernoulli
import LMLF.Definitions.ContinuedFraction

/-!
# DLMF 5.10: continued fractions

The analytic fraction is represented by finite convergents. Its rational
numerators are extracted canonically from the odd Stirling asymptotic series,
rather than selected from a bare existence assertion.
-/

open Filter
open scoped PowerSeries

namespace LMLF.Blueprint.Gamma.Section510

/-- Coefficients of the odd Stirling series
`Σ B_{2n+2}/((2n+2)(2n+1)) z^{-(2n+1)}`. -/
-- ANCHOR: logGammaStirlingSeries
def logGammaStirlingSeries (n : ℕ) : ℚ :=
  bernoulli (2 * n + 2) /
    (((2 * n + 2 : ℕ) : ℚ) * ((2 * n + 1 : ℕ) : ℚ))
-- ANCHOR_END: logGammaStirlingSeries

/-- The canonical DLMF 5.10 numerator stream, computed from the Stirling
series by the normalized continued-fraction coefficient algorithm. -/
-- ANCHOR: gammaContinuedFractionCoeff
def gammaContinuedFractionCoeff : LMLF.CFCoefficients :=
  LMLF.cfracCoeff logGammaStirlingSeries
-- ANCHOR_END: gammaContinuedFractionCoeff

/-- The Stirling series has no degenerate intermediate residual. -/
-- ANCHOR: gammaContinuedFractionCoeff_regular
theorem gammaContinuedFractionCoeff_regular :
    LMLF.CFracRegular logGammaStirlingSeries := by
  sorry
-- ANCHOR_END: gammaContinuedFractionCoeff_regular

/-- The canonical numerator stream reconstructs the complete formal Stirling
series. This is `f = ContinuedFraction (CFCoeff f)` at the formal-series level.
-/
-- ANCHOR: gammaContinuedFraction_reconstructs_stirling
theorem gammaContinuedFraction_reconstructs_stirling :
    LMLF.formalContinuedFraction gammaContinuedFractionCoeff =
      PowerSeries.mk logGammaStirlingSeries
-- ANCHOR_END: gammaContinuedFraction_reconstructs_stirling
:= by
  exact LMLF.formalContinuedFraction_cfracCoeff
    logGammaStirlingSeries gammaContinuedFractionCoeff_regular

/-- Any normalized numerator stream reconstructing the Stirling series is the
canonical stream above. -/
-- ANCHOR: gammaContinuedFractionCoeff_unique
theorem gammaContinuedFractionCoeff_unique
    (a : LMLF.CFCoefficients)
    (h : LMLF.formalContinuedFraction a =
      PowerSeries.mk logGammaStirlingSeries) :
    a = gammaContinuedFractionCoeff
-- ANCHOR_END: gammaContinuedFractionCoeff_unique
:= by
  exact LMLF.cfracCoeff_unique logGammaStirlingSeries a
    gammaContinuedFractionCoeff_regular h

/-- Every requested numerator is produced by the executable triangular
algorithm `cfracCoeff`; the `k`th result reads only Stirling coefficients
through index `k`. -/
-- ANCHOR: gammaContinuedFractionCoeff_algorithm
theorem gammaContinuedFractionCoeff_algorithm (k : ℕ) :
    gammaContinuedFractionCoeff k =
      LMLF.cfracCoeff
        (fun n => bernoulli (2 * n + 2) /
          (((2 * n + 2 : ℕ) : ℚ) * ((2 * n + 1 : ℕ) : ℚ))) k
-- ANCHOR_END: gammaContinuedFractionCoeff_algorithm
:= by
  rfl

/-- DLMF 5.10.1, specialized to positive real `x` so that the logarithm
branch is unambiguous. -/
-- DLMF 5.10.1 https://dlmf.nist.gov/5.10.E1
-- ANCHOR: dlmf_5_10_1
theorem dlmf_5_10_1 {x : ℝ} (hx : 0 < x) :
    Tendsto
      (fun n => LMLF.continuedFractionConvergent
        (fun _ => (x : ℂ))
        (fun k => (gammaContinuedFractionCoeff k : ℂ)) n)
      atTop
      (nhds
        ((Real.log (Real.Gamma x) + x - (x - 1 / 2) * Real.log x -
          Real.log (2 * Real.pi) / 2 : ℝ) : ℂ))
-- ANCHOR_END: dlmf_5_10_1
:= by
  sorry

set_option linter.style.nativeDecide false in
/-- DLMF 5.10.2. The first seven coefficients are computed, not chosen. -/
-- DLMF 5.10.2 https://dlmf.nist.gov/5.10.E2
-- ANCHOR: dlmf_5_10_2
theorem dlmf_5_10_2 :
    gammaContinuedFractionCoeff 0 = 1 / 12 ∧
      gammaContinuedFractionCoeff 1 = 1 / 30 ∧
      gammaContinuedFractionCoeff 2 = 53 / 210 ∧
      gammaContinuedFractionCoeff 3 = 195 / 371 ∧
      gammaContinuedFractionCoeff 4 = 22999 / 22737 ∧
      gammaContinuedFractionCoeff 5 = 29944523 / 19733142 ∧
      gammaContinuedFractionCoeff 6 = 109535241009 / 48264275462
-- ANCHOR_END: dlmf_5_10_2
:= by
  native_decide

end LMLF.Blueprint.Gamma.Section510
