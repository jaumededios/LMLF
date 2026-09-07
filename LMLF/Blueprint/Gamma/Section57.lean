import Mathlib.Analysis.SpecialFunctions.Gamma.Digamma
import Mathlib.NumberTheory.LSeries.RiemannZeta

/-!
# DLMF 5.7: Series expansions for Gamma and digamma

The declarations below state the series identities and recurrences from DLMF 5.7.
-/

-- ANCHOR: gammaSection57Context
namespace LMLF.Blueprint.Gamma

open Filter
-- ANCHOR_END: gammaSection57Context

/-- The Maclaurin coefficient of order `k` of the entire reciprocal-Gamma function. -/
-- ANCHOR: reciprocalGammaCoeff
noncomputable def reciprocalGammaCoeff (k : ℕ) : ℂ :=
  iteratedDeriv k (fun z : ℂ ↦ (Complex.Gamma z)⁻¹) 0 /
    (k.factorial : ℂ)
-- ANCHOR_END: reciprocalGammaCoeff

/-- DLMF 5.7.1: the reciprocal-Gamma Maclaurin series converges for every complex `z`. -/
-- DLMF 5.7.1 https://dlmf.nist.gov/5.7.E1
-- ANCHOR: reciprocalGamma_hasSum
theorem reciprocalGamma_hasSum (z : ℂ) :
    HasSum
      (fun n : ℕ ↦ reciprocalGammaCoeff (n + 1) * z ^ (n + 1))
      (Complex.Gamma z)⁻¹
-- ANCHOR_END: reciprocalGamma_hasSum
:= by
  sorry

/-- The first reciprocal-Gamma coefficient specified after DLMF 5.7.1. -/
-- ANCHOR: reciprocalGammaCoeff_one
theorem reciprocalGammaCoeff_one : reciprocalGammaCoeff 1 = 1
-- ANCHOR_END: reciprocalGammaCoeff_one
:= by
  sorry

/-- The second reciprocal-Gamma coefficient specified after DLMF 5.7.1. -/
-- ANCHOR: reciprocalGammaCoeff_two
theorem reciprocalGammaCoeff_two :
    reciprocalGammaCoeff 2 = (Real.eulerMascheroniConstant : ℂ)
-- ANCHOR_END: reciprocalGammaCoeff_two
:= by
  sorry

/-- DLMF 5.7.2: the finite recurrence for the reciprocal-Gamma coefficients. -/
-- DLMF 5.7.2 https://dlmf.nist.gov/5.7.E2
-- ANCHOR: reciprocalGammaCoeff_recurrence
theorem reciprocalGammaCoeff_recurrence (k : ℕ) (hk : 3 ≤ k) :
    ((k - 1 : ℕ) : ℂ) * reciprocalGammaCoeff k =
      (Real.eulerMascheroniConstant : ℂ) *
          reciprocalGammaCoeff (k - 1) +
        ∑ j ∈ Finset.Icc 2 (k - 1),
          (-1 : ℂ) ^ (j + 1) * riemannZeta (j : ℂ) *
            reciprocalGammaCoeff (k - j)
-- ANCHOR_END: reciprocalGammaCoeff_recurrence
:= by
  sorry

/-- The term of index `n + 2` in the log-Gamma series of DLMF 5.7.3. -/
-- ANCHOR: logGammaOnePlusSeriesTerm
noncomputable def logGammaOnePlusSeriesTerm (z : ℂ) (n : ℕ) : ℂ :=
  (-1 : ℂ) ^ (n + 2) *
    (riemannZeta (n + 2 : ℕ) - 1) * z ^ (n + 2) /
      (n + 2 : ℕ)
-- ANCHOR_END: logGammaOnePlusSeriesTerm

/--
The branch of `log Gamma (1 + z)` selected by DLMF 5.7.3.

It is not the global composition `Complex.log (Complex.Gamma (1 + z))`: those principal values
differ by multiples of `2 · π · i` on part of the disk.
-/
-- ANCHOR: logGammaOnePlus
noncomputable def logGammaOnePlus (z : ℂ) : ℂ :=
  -Complex.log (1 + z) +
    z * (1 - (Real.eulerMascheroniConstant : ℂ)) +
      ∑' n : ℕ, logGammaOnePlusSeriesTerm z n
-- ANCHOR_END: logGammaOnePlus

/-- The selected branch exponentiates to Gamma away from its pole at `z = -1`. -/
-- ANCHOR: exp_logGammaOnePlus
theorem exp_logGammaOnePlus {z : ℂ} (hz : ‖z‖ < 2) (hzneg : z ≠ -1) :
    Complex.exp (logGammaOnePlus z) = Complex.Gamma (1 + z)
-- ANCHOR_END: exp_logGammaOnePlus
:= by
  sorry

/-- DLMF 5.7.3: the Taylor series for the selected log-Gamma branch at `1`. -/
-- DLMF 5.7.3 https://dlmf.nist.gov/5.7.E3
-- ANCHOR: logGamma_one_add_hasSum
theorem logGamma_one_add_hasSum
    {z : ℂ} (hz : ‖z‖ < 2) (hzneg : z ≠ -1) :
    HasSum (logGammaOnePlusSeriesTerm z)
      (logGammaOnePlus z + Complex.log (1 + z) -
        z * (1 - (Real.eulerMascheroniConstant : ℂ)))
-- ANCHOR_END: logGamma_one_add_hasSum
:= by
  sorry

/-- DLMF 5.7.4: the Taylor series for digamma at `1`. -/
-- DLMF 5.7.4 https://dlmf.nist.gov/5.7.E4
-- ANCHOR: digamma_one_add_hasSum
theorem digamma_one_add_hasSum {z : ℂ} (hz : ‖z‖ < 1) :
    HasSum
      (fun n : ℕ ↦
        (-1 : ℂ) ^ (n + 2) * riemannZeta (n + 2 : ℕ) *
          z ^ (n + 1))
      (Complex.digamma (1 + z) +
        (Real.eulerMascheroniConstant : ℂ))
-- ANCHOR_END: digamma_one_add_hasSum
:= by
  sorry

/-- DLMF 5.7.5: the accelerated even-power series for digamma. -/
-- DLMF 5.7.5 https://dlmf.nist.gov/5.7.E5
-- ANCHOR: digamma_one_add_even_hasSum
theorem digamma_one_add_even_hasSum
    {z : ℂ} (hz : ‖z‖ < 2) (hz0 : z ≠ 0)
    (hz1 : z ≠ 1) (hzn1 : z ≠ -1) :
    HasSum
      (fun n : ℕ ↦
        (riemannZeta (2 * (n + 1) + 1 : ℕ) - 1) *
          z ^ (2 * (n + 1)))
      (1 / (2 * z) - (Real.pi : ℂ) / 2 * Complex.cot (Real.pi * z) +
        1 / (z ^ 2 - 1) + 1 -
          (Real.eulerMascheroniConstant : ℂ) -
        Complex.digamma (1 + z))
-- ANCHOR_END: digamma_one_add_even_hasSum
:= by
  sorry

/-- DLMF 5.7.6: both partial-fraction series for digamma. -/
-- DLMF 5.7.6 https://dlmf.nist.gov/5.7.E6
-- ANCHOR: digamma_partialFractions_hasSum
theorem digamma_partialFractions_hasSum
    {z : ℂ} (hz : ∀ n : ℕ, z ≠ -(n : ℂ)) :
    HasSum
        (fun n : ℕ ↦
          z / ((n + 1 : ℕ) * ((n + 1 : ℕ) + z)))
        (Complex.digamma z +
          (Real.eulerMascheroniConstant : ℂ) + 1 / z) ∧
      HasSum
        (fun n : ℕ ↦ 1 / (n + 1 : ℕ) - 1 / ((n : ℂ) + z))
        (Complex.digamma z +
          (Real.eulerMascheroniConstant : ℂ))
-- ANCHOR_END: digamma_partialFractions_hasSum
:= by
  sorry

/-- DLMF 5.7.7: the alternating partial-fraction series for a digamma difference. -/
-- DLMF 5.7.7 https://dlmf.nist.gov/5.7.E7
-- ANCHOR: digamma_halfDifference_hasSum
theorem digamma_halfDifference_hasSum
    {z : ℂ} (hz : ∀ n : ℕ, z ≠ -(n : ℂ)) :
    HasSum
      (fun n : ℕ ↦ 2 * (-1 : ℂ) ^ n / ((n : ℂ) + z))
      (Complex.digamma ((z + 1) / 2) - Complex.digamma (z / 2))
-- ANCHOR_END: digamma_halfDifference_hasSum
:= by
  sorry

/-- DLMF 5.7.8: the series for the imaginary part of digamma on `1 + iℝ`. -/
-- DLMF 5.7.8 https://dlmf.nist.gov/5.7.E8
-- ANCHOR: digamma_one_add_mul_I_im_hasSum
theorem digamma_one_add_mul_I_im_hasSum (y : ℝ) :
    HasSum
      (fun n : ℕ ↦ y / ((n + 1 : ℕ) ^ 2 + y ^ 2))
      (Complex.digamma (1 + Complex.I * y)).im
-- ANCHOR_END: digamma_one_add_mul_I_im_hasSum
:= by
  sorry

end LMLF.Blueprint.Gamma
