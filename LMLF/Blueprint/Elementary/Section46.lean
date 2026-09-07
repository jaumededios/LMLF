import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real

/-!
# DLMF §4.6: Power Series

The declarations in this file record the logarithmic and binomial series of
DLMF §4.6, with their source domains stated explicitly.
-/

namespace LMLF.Blueprint.Elementary.Section46

noncomputable section

/-- DLMF §4.6.1: the `n`th term of the logarithm series at `1+z`. -/
-- ANCHOR: logOneAddTerm
def logOneAddTerm (z : ℂ) (n : ℕ) : ℂ :=
  (-1 : ℂ) ^ n * z ^ (n + 1) / (n + 1 : ℂ)
-- ANCHOR_END: logOneAddTerm

/-- DLMF §4.6.2: the `n`th term of the logarithm series in `(z-1)/z`. -/
-- ANCHOR: logRatioTerm
def logRatioTerm (z : ℂ) (n : ℕ) : ℂ :=
  ((z - 1) / z) ^ (n + 1) / (n + 1 : ℂ)
-- ANCHOR_END: logRatioTerm

/-- DLMF §4.6.3: the `n`th term of the logarithm series at `z-1`. -/
-- ANCHOR: logSubOneTerm
def logSubOneTerm (z : ℂ) (n : ℕ) : ℂ :=
  (-1 : ℂ) ^ n * (z - 1) ^ (n + 1) / (n + 1 : ℂ)
-- ANCHOR_END: logSubOneTerm

/-- DLMF §4.6.4: the `n`th odd term in the symmetric logarithm series. -/
-- ANCHOR: logSymmetricTerm
def logSymmetricTerm (z : ℂ) (n : ℕ) : ℂ :=
  2 * (((z - 1) / (z + 1)) ^ (2 * n + 1) / (2 * n + 1 : ℂ))
-- ANCHOR_END: logSymmetricTerm

/-- DLMF §4.6.5: the `n`th odd inverse-power term. -/
-- ANCHOR: logInverseOddTerm
def logInverseOddTerm (z : ℂ) (n : ℕ) : ℂ :=
  2 * (1 / ((2 * n + 1 : ℕ) : ℂ) / z ^ (2 * n + 1))
-- ANCHOR_END: logInverseOddTerm

/-- DLMF §4.6.6: the `n`th odd term in the shifted logarithm series. -/
-- ANCHOR: logShiftedTerm
def logShiftedTerm (a z : ℝ) (n : ℕ) : ℂ :=
  (((z : ℂ) / (2 * a + z)) ^ (2 * n + 1)) / (2 * n + 1 : ℂ)
-- ANCHOR_END: logShiftedTerm

/-- DLMF §4.6.7: generalized binomial coefficient. -/
-- ANCHOR: generalizedBinomial
def generalizedBinomial (a : ℂ) (n : ℕ) : ℂ :=
  (∏ k ∈ Finset.range n, (a - k)) / (n.factorial : ℂ)
-- ANCHOR_END: generalizedBinomial

/-- DLMF §4.6.1: logarithm series on `|z| ≤ 1`, excluding `z = -1`. -/
-- ANCHOR: dlmf_4_6_1
theorem dlmf_4_6_1 {z : ℂ} (hz : ‖z‖ ≤ 1) (hz1 : z ≠ -1) :
    HasSum (logOneAddTerm z) (Complex.log (1 + z)) := by
  sorry
-- ANCHOR_END: dlmf_4_6_1

/-- DLMF §4.6.2: logarithm series when `Re z ≥ 1/2`. -/
-- ANCHOR: dlmf_4_6_2
theorem dlmf_4_6_2 {z : ℂ} (hz : 1 / 2 ≤ z.re) :
    HasSum (logRatioTerm z) (Complex.log z) := by
  sorry
-- ANCHOR_END: dlmf_4_6_2

/-- DLMF §4.6.3: logarithm series on `|z-1| ≤ 1`, excluding `z = 0`. -/
-- ANCHOR: dlmf_4_6_3
theorem dlmf_4_6_3 {z : ℂ} (hz : ‖z - 1‖ ≤ 1) (hz0 : z ≠ 0) :
    HasSum (logSubOneTerm z) (Complex.log z) := by
  sorry
-- ANCHOR_END: dlmf_4_6_3

/-- DLMF §4.6.4: symmetric logarithm series for `Re z ≥ 0`, `z ≠ 0`. -/
-- ANCHOR: dlmf_4_6_4
theorem dlmf_4_6_4 {z : ℂ} (hz : 0 ≤ z.re) (hz0 : z ≠ 0) :
    HasSum (logSymmetricTerm z) (Complex.log z) := by
  sorry
-- ANCHOR_END: dlmf_4_6_4

/-- DLMF §4.6.5: inverse odd-power logarithm series for `|z| ≥ 1`. -/
-- ANCHOR: dlmf_4_6_5
theorem dlmf_4_6_5 {z : ℂ} (hz : 1 ≤ ‖z‖) (hz1 : z ≠ 1) (hzneg1 : z ≠ -1) :
    HasSum (logInverseOddTerm z) (Complex.log ((z + 1) / (z - 1))) := by
  sorry
-- ANCHOR_END: dlmf_4_6_5

/-- DLMF §4.6.6: shifted logarithm series for `a > 0`, `Re z ≥ -a`, `z ≠ -a`. -/
-- ANCHOR: dlmf_4_6_6
theorem dlmf_4_6_6 {a : ℝ} {z : ℝ} (ha : 0 < a) (hz : -a ≤ z) (hza : z ≠ -a) :
    Complex.log ((z + a : ℂ)) = Complex.log (a : ℂ) +
      2 * ∑' n, logShiftedTerm a z n := by
  sorry
-- ANCHOR_END: dlmf_4_6_6

/-- DLMF §4.6.7: generalized binomial expansion for `|z| < 1`. -/
-- ANCHOR: dlmf_4_6_7
theorem dlmf_4_6_7 (a z : ℂ) (hz : ‖z‖ < 1) :
    Complex.cpow (1 + z) a = ∑' n, generalizedBinomial a n * z ^ n := by
  sorry
-- ANCHOR_END: dlmf_4_6_7

/-- DLMF §4.6.7: for a nonnegative integral exponent, the binomial series
terminates and the resulting polynomial is valid for every complex `z`. -/
-- ANCHOR: dlmf_4_6_7_terminating
theorem dlmf_4_6_7_terminating (m : ℕ) (z : ℂ) :
    Complex.cpow (1 + z) (m : ℂ) =
      ∑' n, generalizedBinomial (m : ℂ) n * z ^ n := by
  sorry
-- ANCHOR_END: dlmf_4_6_7_terminating

end

end LMLF.Blueprint.Elementary.Section46
