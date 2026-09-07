import LMLF.ODE.Hypergeometric.Principal

/-!
# Public-use tests for the principal Gauss hypergeometric function

The chart domains and the four IVP selections are intentionally private. Their geometry is
therefore checked by the production proofs that establish the public domain, disk agreement,
analyticity, and the equation on points representing every chart and both nonreal components.
-/

open Filter Metric Set
open scoped ComplexOrder Topology

namespace LMLFTest.ODE.Hypergeometric.Principal

open LMLF.Definitions LMLF.ODE

example : (0 : ℂ) ∈ gaussHypergeometricDomain := by simp

example : (1 / 2 : ℂ) ∈ gaussHypergeometricDomain := by
  norm_num [gaussHypergeometricDomain, Complex.le_def, div_eq_mul_inv]

example : (-1 / 2 : ℂ) ∈ gaussHypergeometricDomain := by
  norm_num [gaussHypergeometricDomain, Complex.le_def, div_eq_mul_inv]

example : (Complex.I / 2 : ℂ) ∈ gaussHypergeometricDomain := by
  norm_num

example : (-Complex.I / 2 : ℂ) ∈ gaussHypergeometricDomain := by
  norm_num

example : (1 : ℂ) ∉ gaussHypergeometricDomain := by simp

example (z : ℂ) :
    z ∈ gaussHypergeometricDomain ↔ z.im ≠ 0 ∨ z.re < 1 :=
  mem_gaussHypergeometricDomain_iff z

example : IsOpen gaussHypergeometricDomain := isOpen_gaussHypergeometricDomain

example : IsSimplyConnected gaussHypergeometricDomain :=
  isSimplyConnected_gaussHypergeometricDomain

example (a b c z : ℂ) (hz : ‖z‖ < 1) :
    regularizedGaussHypergeometric a b c z =
      regularizedGaussHypergeometricSeriesSum a b c z :=
  regularizedGaussHypergeometric_eqOn_seriesSum a b c (by simpa using hz)

example (a b c : ℂ) :
    regularizedGaussHypergeometric a b c 0 =
      regularizedGaussHypergeometricSeriesSum a b c 0 :=
  regularizedGaussHypergeometric_eqOn_seriesSum a b c (by simp)

example (a b : ℂ) :
    regularizedGaussHypergeometric a b 0 0 =
      regularizedGaussHypergeometricSeriesSum a b 0 0 :=
  regularizedGaussHypergeometric_eqOn_seriesSum a b 0 (by simp)

example (a b : ℂ) (N : ℕ) :
    regularizedGaussHypergeometric a b (-(N : ℂ)) 0 =
      regularizedGaussHypergeometricSeriesSum a b (-(N : ℂ)) 0 :=
  regularizedGaussHypergeometric_eqOn_seriesSum a b (-(N : ℂ)) (by simp)

example (a b c : ℂ) :
    AnalyticOnNhd ℂ (regularizedGaussHypergeometric a b c) gaussHypergeometricDomain :=
  regularizedGaussHypergeometric_analyticOnNhd a b c

example (a b c : ℂ) :
    c * deriv (regularizedGaussHypergeometric a b c) 0 -
      a * b * regularizedGaussHypergeometric a b c 0 = 0 := by
  simpa using regularizedGaussHypergeometric_gaussEquation a b c
    (show (0 : ℂ) ∈ gaussHypergeometricDomain by simp)

example (a b c : ℂ) :
    (1 / 2 : ℂ) * (1 - 1 / 2) *
          deriv (deriv (regularizedGaussHypergeometric a b c)) (1 / 2) +
        (c - (a + b + 1) * (1 / 2)) *
          deriv (regularizedGaussHypergeometric a b c) (1 / 2) -
      a * b * regularizedGaussHypergeometric a b c (1 / 2) = 0 := by
  exact regularizedGaussHypergeometric_gaussEquation a b c
    (by norm_num [gaussHypergeometricDomain, Complex.le_def, div_eq_mul_inv])

example (a b c : ℂ) :
    (-1 / 2 : ℂ) * (1 - (-1 / 2)) *
          deriv (deriv (regularizedGaussHypergeometric a b c)) (-1 / 2) +
        (c - (a + b + 1) * (-1 / 2)) *
          deriv (regularizedGaussHypergeometric a b c) (-1 / 2) -
      a * b * regularizedGaussHypergeometric a b c (-1 / 2) = 0 := by
  exact regularizedGaussHypergeometric_gaussEquation a b c
    (by norm_num [gaussHypergeometricDomain, Complex.le_def, div_eq_mul_inv])

example (a b c : ℂ) :
    (-2 : ℂ) * (1 - (-2)) *
          deriv (deriv (regularizedGaussHypergeometric a b c)) (-2) +
        (c - (a + b + 1) * (-2)) *
          deriv (regularizedGaussHypergeometric a b c) (-2) -
      a * b * regularizedGaussHypergeometric a b c (-2) = 0 := by
  exact regularizedGaussHypergeometric_gaussEquation a b c (by norm_num)

example (a b c : ℂ) :
    (2 * Complex.I : ℂ) * (1 - 2 * Complex.I) *
          deriv (deriv (regularizedGaussHypergeometric a b c)) (2 * Complex.I) +
        (c - (a + b + 1) * (2 * Complex.I)) *
          deriv (regularizedGaussHypergeometric a b c) (2 * Complex.I) -
      a * b * regularizedGaussHypergeometric a b c (2 * Complex.I) = 0 := by
  exact regularizedGaussHypergeometric_gaussEquation a b c (by norm_num)

example (a b c : ℂ) :
    (-2 * Complex.I : ℂ) * (1 - (-2 * Complex.I)) *
          deriv (deriv (regularizedGaussHypergeometric a b c)) (-2 * Complex.I) +
        (c - (a + b + 1) * (-2 * Complex.I)) *
          deriv (regularizedGaussHypergeometric a b c) (-2 * Complex.I) -
      a * b * regularizedGaussHypergeometric a b c (-2 * Complex.I) = 0 := by
  exact regularizedGaussHypergeometric_gaussEquation a b c (by norm_num)

example (a b c : ℂ) :
    let v : ℂ → ℂ := fun z ↦ @ite ℂ (z ∈ gaussHypergeometricDomain)
      (Classical.propDecidable _) (regularizedGaussHypergeometric a b c z) 7
    Set.EqOn (regularizedGaussHypergeometric a b c) v gaussHypergeometricDomain ∧
      v 1 = 7 := by
  classical
  dsimp only
  let v : ℂ → ℂ := fun z ↦ @ite ℂ (z ∈ gaussHypergeometricDomain)
    (Classical.propDecidable _) (regularizedGaussHypergeometric a b c z) 7
  have hvEq : Set.EqOn (regularizedGaussHypergeometric a b c) v
      gaussHypergeometricDomain := by
    intro z hz
    rw [show v z = regularizedGaussHypergeometric a b c z by simp only [v, if_pos hz]]
  have hvAnalytic : AnalyticOnNhd ℂ v gaussHypergeometricDomain :=
    (regularizedGaussHypergeometric_analyticOnNhd a b c).congr
      isOpen_gaussHypergeometricDomain hvEq
  have hball : Metric.ball (0 : ℂ) 1 ⊆ gaussHypergeometricDomain := by
    intro z hz
    rw [mem_gaussHypergeometricDomain_iff]
    by_cases hi : z.im = 0
    · right
      exact lt_of_le_of_lt (Complex.re_le_norm z) (by simpa using hz)
    · exact Or.inl hi
  have hvgerm : Set.EqOn v (regularizedGaussHypergeometricSeriesSum a b c)
      (Metric.ball 0 1) := by
    intro z hz
    rw [← regularizedGaussHypergeometric_eqOn_seriesSum a b c hz]
    rw [show v z = regularizedGaussHypergeometric a b c z by
      simp only [v, if_pos (hball hz)]]
  refine ⟨regularizedGaussHypergeometric_eqOn_of_eqOn_seriesSum a b c hvAnalytic hvgerm, ?_⟩
  rw [if_neg (show (1 : ℂ) ∉ gaussHypergeometricDomain by simp)]

example (a b c z : ℂ) (hc : ∀ n : ℕ, c ≠ -(n : ℂ)) (hz : ‖z‖ < 1) :
    gaussHypergeometric a b c z = gaussHypergeometricSeriesSum a b c z :=
  gaussHypergeometric_eqOn_seriesSum a b c hc (by simpa using hz)

example (a b c : ℂ) (hc : ∀ n : ℕ, c ≠ -(n : ℂ)) :
    AnalyticOnNhd ℂ (gaussHypergeometric a b c) gaussHypergeometricDomain :=
  gaussHypergeometric_analyticOnNhd a b c hc

example (a b c z : ℂ) (hc : ∀ n : ℕ, c ≠ -(n : ℂ)) :
    gaussHypergeometric a b c z / Complex.Gamma c =
      regularizedGaussHypergeometric a b c z :=
  gaussHypergeometric_div_Gamma a b c hc z

example (a b c : ℂ) (hc : ∀ n : ℕ, c ≠ -(n : ℂ)) {z : ℂ}
    (hz : z ∈ gaussHypergeometricDomain) :
    z * (1 - z) * deriv (deriv (gaussHypergeometric a b c)) z +
        (c - (a + b + 1) * z) * deriv (gaussHypergeometric a b c) z -
      a * b * gaussHypergeometric a b c z = 0 :=
  gaussHypergeometric_gaussEquation a b c hc hz

example (a b c : ℂ) (hc : ∀ n : ℕ, c ≠ -(n : ℂ)) :
    let v : ℂ → ℂ := gaussHypergeometric a b c
    Set.EqOn (gaussHypergeometric a b c) v gaussHypergeometricDomain := by
  dsimp only
  exact gaussHypergeometric_eqOn_of_eqOn_seriesSum a b c hc
    (gaussHypergeometric_analyticOnNhd a b c hc)
    (gaussHypergeometric_eqOn_seriesSum a b c hc)

example (a b c : ℂ) :
    Set.EqOn (regularizedGaussHypergeometric a b c)
      (regularizedGaussHypergeometricSeriesSum a b c) gaussHypergeometricDomainᶜ :=
  regularizedGaussHypergeometric_eqOn_seriesSum_compl a b c

example (a b c : ℂ) :
    regularizedGaussHypergeometric a b c 1 =
      regularizedGaussHypergeometricSeriesSum a b c 1 := by
  exact regularizedGaussHypergeometric_eqOn_seriesSum_compl a b c (by simp)

/-- Regression for the nonzero off-domain fallback: the terminating regularized series with
`a = b = 0`, `c = 1` is the constant one at every ambient point. -/
theorem terminatingRegularizedGaussSeries_zero_zero_one (z : ℂ) :
    regularizedGaussHypergeometricSeriesSum 0 0 1 z = 1 := by
  change (Complex.regularizedGaussHGFunSeries 0 0 1).sum z = 1
  unfold FormalMultilinearSeries.sum
  rw [tsum_eq_single 0]
  · simp [FormalMultilinearSeries.apply_eq_prod_smul_coeff,
      Complex.coeff_regularizedGaussHGFunSeries]
  · intro k hk
    rw [FormalMultilinearSeries.apply_eq_prod_smul_coeff,
      Complex.coeff_regularizedGaussHGFunSeries]
    have hkpos : 0 < k := Nat.pos_of_ne_zero hk
    have hpoch : (ascPochhammer ℂ k).eval (0 : ℂ) = 0 := by
      rw [ascPochhammer_eval_eq_zero_iff]
      exact ⟨0, hkpos, by simp⟩
    simp [hpoch]

/-- Named boundary regression guarding against the obsolete zero fallback. -/
theorem terminatingPrincipalGauss_at_one :
    regularizedGaussHypergeometric 0 0 1 1 = 1 ∧
      gaussHypergeometric 0 0 1 1 = 1 := by
  have hfallback := regularizedGaussHypergeometric_eqOn_seriesSum_compl
    (0 : ℂ) 0 1 (show (1 : ℂ) ∈ gaussHypergeometricDomainᶜ by simp)
  have hregularized : regularizedGaussHypergeometric 0 0 1 1 = 1 :=
    hfallback.trans (terminatingRegularizedGaussSeries_zero_zero_one 1)
  refine ⟨hregularized, ?_⟩
  rw [gaussHypergeometric, hregularized, Complex.Gamma_one, one_mul]

end LMLFTest.ODE.Hypergeometric.Principal
