import LMLF.Definitions.Hypergeometric
import Mathlib.Analysis.Calculus.FDeriv.Analytic

/-!
# Public-use tests for local Gauss hypergeometric series
-/

namespace LMLFTest.Definitions

open LMLF.Definitions

example {a b c z : ℂ} (hc : ∀ n : ℕ, c ≠ -(n : ℂ)) (hz : ‖z‖ < 1) :
    HasSum
      (fun n : ℕ ↦
        ((Nat.factorial n : ℂ)⁻¹ * (ascPochhammer ℂ n).eval a *
          (ascPochhammer ℂ n).eval b * ((ascPochhammer ℂ n).eval c)⁻¹) * z ^ n)
      (gaussHypergeometricSeriesSum a b c z) :=
  hasSum_gaussHypergeometricSeries hc hz

example {a b c z : ℂ} (hz : ‖z‖ < 1) :
    ∑' n : ℕ,
        ((ascPochhammer ℂ n).eval a * (ascPochhammer ℂ n).eval b /
          ((Nat.factorial n : ℂ) * Complex.Gamma (c + n))) * z ^ n =
      regularizedGaussHypergeometricSeriesSum a b c z :=
  (hasSum_regularizedGaussHypergeometricSeries hz).tsum_eq

example {b c : ℂ} (hc : ∀ n : ℕ, c ≠ -(n : ℂ)) :
    1 ≤ (ordinaryHypergeometricSeries ℂ (-(3 : ℂ)) b c).radius :=
  ordinaryHypergeometricSeries_radius_ge_one hc

example (a b : ℂ) : regularizedGaussHypergeometricSeriesSum a b 0 0 = 0 := by
  simp

example {a b c z : ℂ} (hc : ∀ n : ℕ, c ≠ -(n : ℂ)) (hz : ‖z‖ < 1) :
    DifferentiableAt ℂ (gaussHypergeometricSeriesSum a b c) z := by
  apply AnalyticAt.differentiableAt
  exact gaussHypergeometricSeriesSum_analyticOnNhd hc z (by simpa using hz)

example {a b c z : ℂ} (hz : ‖z‖ < 1) :
    DifferentiableAt ℂ (regularizedGaussHypergeometricSeriesSum a b c) z := by
  apply AnalyticAt.differentiableAt
  exact regularizedGaussHypergeometricSeriesSum_analyticOnNhd a b c z (by simpa using hz)

end LMLFTest.Definitions
