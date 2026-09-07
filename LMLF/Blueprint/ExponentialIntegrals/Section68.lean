import Mathlib.Analysis.SpecialFunctions.Log.Basic
import LMLF.Blueprint.ExponentialIntegrals.Section62

noncomputable section
namespace LMLF.Blueprint.ExponentialIntegrals.Section68
open LMLF.Blueprint.ExponentialIntegrals.Section62

/-! DLMF §6.8: positive-real inequalities for the exponential integral. -/

/- DLMF §6.8: the real positive-ray specialization of the canonical §6.2 E₁. -/
def scaledE1 (x : ℝ) : ℝ := Real.exp x * (realE1 x).re

/-- DLMF 6.8.E1: Gautschi's strict logarithmic enclosure for x > 0. -/
-- ANCHOR: dlmf_6_8_1
theorem dlmf_6_8_1 (x : ℝ) (hx : 0 < x) :
    (1 / 2 : ℝ) * Real.log (1 + 2 / x) < scaledE1 x ∧
      scaledE1 x < Real.log (1 + 1 / x)
-- ANCHOR_END: dlmf_6_8_1
  := by
  sorry

/-- DLMF 6.8.E2: the first strict rational enclosure for x > 0. -/
-- ANCHOR: dlmf_6_8_2
theorem dlmf_6_8_2 (x : ℝ) (hx : 0 < x) :
    x / (x + 1) < x * scaledE1 x ∧
      x * scaledE1 x < (x + 1) / (x + 2)
-- ANCHOR_END: dlmf_6_8_2
  := by
  sorry

/-- DLMF 6.8.E3: the sharper strict rational enclosure for x > 0. -/
-- ANCHOR: dlmf_6_8_3
theorem dlmf_6_8_3 (x : ℝ) (hx : 0 < x) :
    x * (x + 3) / (x ^ 2 + 4 * x + 2) < x * scaledE1 x ∧
      x * scaledE1 x < (x ^ 2 + 5 * x + 2) / (x ^ 2 + 6 * x + 6)
-- ANCHOR_END: dlmf_6_8_3
  := by
  sorry

end LMLF.Blueprint.ExponentialIntegrals.Section68
