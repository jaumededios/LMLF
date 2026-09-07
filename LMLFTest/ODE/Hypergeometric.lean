import LMLF.ODE.Hypergeometric

/-!
# Public-use tests for the local Gauss hypergeometric equation
-/

namespace LMLFTest.ODE

open LMLF.Definitions LMLF.ODE

example {a b c z : ℂ} (hz : ‖z‖ < 1) :
    z * (1 - z) *
          deriv (deriv (regularizedGaussHypergeometricSeriesSum a b c)) z
      + (c - (a + b + 1) * z) *
          deriv (regularizedGaussHypergeometricSeriesSum a b c) z
      - a * b * regularizedGaussHypergeometricSeriesSum a b c z = 0 :=
  regularizedGaussHypergeometricSeriesSum_gaussEquation hz

example {a b c z : ℂ} (hc : ∀ n : ℕ, c ≠ -(n : ℂ)) (hz : ‖z‖ < 1) :
    z * (1 - z) * deriv (deriv (gaussHypergeometricSeriesSum a b c)) z
      + (c - (a + b + 1) * z) * deriv (gaussHypergeometricSeriesSum a b c) z
      - a * b * gaussHypergeometricSeriesSum a b c z = 0 :=
  gaussHypergeometricSeriesSum_gaussEquation hc hz

example (a b : ℂ) :
    (0 : ℂ) * (1 - 0) *
          deriv (deriv (regularizedGaussHypergeometricSeriesSum a b 0)) 0
      + (0 - (a + b + 1) * 0) *
          deriv (regularizedGaussHypergeometricSeriesSum a b 0) 0
      - a * b * regularizedGaussHypergeometricSeriesSum a b 0 0 = 0 := by
  exact regularizedGaussHypergeometricSeriesSum_gaussEquation (by norm_num)

example (a b : ℂ) (N : ℕ) {z : ℂ} (hz : ‖z‖ < 1) :
    z * (1 - z) *
          deriv (deriv (regularizedGaussHypergeometricSeriesSum a b (-(N : ℂ)))) z
      + (-(N : ℂ) - (a + b + 1) * z) *
          deriv (regularizedGaussHypergeometricSeriesSum a b (-(N : ℂ))) z
      - a * b * regularizedGaussHypergeometricSeriesSum a b (-(N : ℂ)) z = 0 :=
  regularizedGaussHypergeometricSeriesSum_gaussEquation hz

example (b c : ℂ) {z : ℂ} (hz : ‖z‖ < 1) :
    z * (1 - z) *
          deriv (deriv (regularizedGaussHypergeometricSeriesSum 0 b c)) z
      + (c - (0 + b + 1) * z) *
          deriv (regularizedGaussHypergeometricSeriesSum 0 b c) z
      - 0 * b * regularizedGaussHypergeometricSeriesSum 0 b c z = 0 :=
  regularizedGaussHypergeometricSeriesSum_gaussEquation hz

example (b c : ℂ) (M : ℕ) {z : ℂ} (hz : ‖z‖ < 1) :
    z * (1 - z) *
          deriv (deriv (regularizedGaussHypergeometricSeriesSum (-(M : ℂ)) b c)) z
      + (c - (-(M : ℂ) + b + 1) * z) *
          deriv (regularizedGaussHypergeometricSeriesSum (-(M : ℂ)) b c) z
      - (-(M : ℂ)) * b * regularizedGaussHypergeometricSeriesSum (-(M : ℂ)) b c z = 0 :=
  regularizedGaussHypergeometricSeriesSum_gaussEquation hz

example (a b : ℂ) (N : ℕ) (z : ℂ) (hz : ‖z‖ < 1) :
    DifferentiableAt ℂ
        (regularizedGaussHypergeometricSeriesSum a b (-(N : ℂ))) z ∧
    DifferentiableAt ℂ
        (deriv (regularizedGaussHypergeometricSeriesSum a b (-(N : ℂ)))) z ∧
    z * (1 - z) *
          deriv (deriv
            (regularizedGaussHypergeometricSeriesSum a b (-(N : ℂ)))) z
      + (-(N : ℂ) - (a + b + 1) * z) *
          deriv (regularizedGaussHypergeometricSeriesSum a b (-(N : ℂ))) z
      - a * b *
          regularizedGaussHypergeometricSeriesSum a b (-(N : ℂ)) z = 0 := by
  have han : AnalyticAt ℂ
      (regularizedGaussHypergeometricSeriesSum a b (-(N : ℂ))) z :=
    regularizedGaussHypergeometricSeriesSum_analyticOnNhd a b (-(N : ℂ)) z (by simpa using hz)
  exact ⟨han.differentiableAt, han.deriv.differentiableAt,
    regularizedGaussHypergeometricSeriesSum_gaussEquation hz⟩

end LMLFTest.ODE
