import LMLF.Results.HypergeometricPrincipalSpecializations

/-!
# Public-use tests for principal Gauss hypergeometric specializations
-/

namespace LMLFTest.Results

open LMLF.Definitions

example {a z : ℂ} (hz : z ∈ gaussHypergeometricDomain) :
    gaussHypergeometric a 1 1 z = (1 - z) ^ (-a) :=
  gaussHypergeometric_one_one a hz

example {a z : ℂ} (hz : z ∈ gaussHypergeometricDomain) :
    regularizedGaussHypergeometric a 1 1 z = (1 - z) ^ (-a) :=
  regularizedGaussHypergeometric_one_one a hz

example {a z : ℂ} (hz : z ∈ gaussHypergeometricDomain) :
    gaussHypergeometric a 1 1 z = regularizedGaussHypergeometric a 1 1 z ∧
      gaussHypergeometric a 1 1 z = (1 - z) ^ (-a) ∧
      regularizedGaussHypergeometric a 1 1 z = (1 - z) ^ (-a) := by
  have hquotient := gaussHypergeometric_div_Gamma a 1 1 (fun n ↦ by
    intro h
    have hreal := congrArg Complex.re h
    have hn : (0 : ℝ) ≤ n := by positivity
    norm_num at hreal
    linarith) z
  rw [Complex.Gamma_one, div_one] at hquotient
  exact ⟨hquotient, gaussHypergeometric_one_one a hz,
    regularizedGaussHypergeometric_one_one a hz⟩

example (a : ℂ) : gaussHypergeometric a 1 1 0 = 1 ∧
    regularizedGaussHypergeometric a 1 1 0 = 1 := by
  constructor
  · simpa using gaussHypergeometric_one_one a (z := 0) (by simp)
  · simpa using regularizedGaussHypergeometric_one_one a (z := 0) (by simp)

example {z : ℂ} (hz : z ∈ gaussHypergeometricDomain) :
    gaussHypergeometric (-3) 1 1 z = (1 - z) ^ (3 : ℕ) := by
  rw [gaussHypergeometric_one_one (-3) hz]
  norm_num

example :
    gaussHypergeometric (1 / 2) 1 1 (1 / 2) =
        (1 - (1 / 2 : ℂ)) ^ (-(1 / 2 : ℂ)) ∧
      regularizedGaussHypergeometric (1 / 2) 1 1 (1 / 2) =
        (1 - (1 / 2 : ℂ)) ^ (-(1 / 2 : ℂ)) := by
  have hz : (1 / 2 : ℂ) ∈ gaussHypergeometricDomain := by
    rw [mem_gaussHypergeometricDomain_iff]
    right
    norm_num [div_eq_mul_inv]
  exact ⟨gaussHypergeometric_one_one (1 / 2) hz,
    regularizedGaussHypergeometric_one_one (1 / 2) hz⟩

example {z : ℂ} (hz : z ∈ gaussHypergeometricDomain) :
    gaussHypergeometric 1 1 1 z = (1 - z)⁻¹ :=
  gaussHypergeometric_geometric hz

example {z : ℂ} (hz : ‖z‖ < 1) :
    HasSum (fun n : ℕ ↦ z ^ n) (gaussHypergeometric 1 1 1 z) ∧
      z ∈ gaussHypergeometricDomain ∧
      gaussHypergeometric 1 1 1 z = (1 - z)⁻¹ := by
  have hzDomain : z ∈ gaussHypergeometricDomain := by
    rw [mem_gaussHypergeometricDomain_iff]
    right
    exact lt_of_le_of_lt (Complex.re_le_norm z) hz
  exact ⟨hasSum_gaussHypergeometric_geometric hz, hzDomain,
    gaussHypergeometric_geometric hzDomain⟩

example : (1 : ℂ) ∉ gaussHypergeometricDomain := by
  norm_num [gaussHypergeometricDomain, Complex.le_def]

example : (2 : ℂ) ∉ gaussHypergeometricDomain := by
  norm_num [gaussHypergeometricDomain, Complex.le_def]

example (a : ℂ) :
    gaussHypergeometric a 1 1 (2 + Complex.I) =
      (1 - (2 + Complex.I)) ^ (-a) := by
  exact gaussHypergeometric_one_one a (by simp)

example (a : ℂ) :
    regularizedGaussHypergeometric a 1 1 (2 - Complex.I) =
      (1 - (2 - Complex.I)) ^ (-a) := by
  exact regularizedGaussHypergeometric_one_one a (by simp)

/-- A public consumer combining the principal specialization, the `Gamma(1)` convention bridge,
and the geometric-series API on its convergence disk. -/
theorem principalGaussSpecializationConventionSeriesCertificate
    (a : ℂ) {z : ℂ} (hz : ‖z‖ < 1) :
    gaussHypergeometric a 1 1 z = (1 - z) ^ (-a) ∧
      regularizedGaussHypergeometric a 1 1 z = (1 - z) ^ (-a) ∧
      gaussHypergeometric a 1 1 z = regularizedGaussHypergeometric a 1 1 z ∧
      HasSum (fun n : ℕ ↦ z ^ n) (gaussHypergeometric 1 1 1 z) := by
  have hzDomain : z ∈ gaussHypergeometricDomain := by
    rw [mem_gaussHypergeometricDomain_iff]
    right
    exact lt_of_le_of_lt (Complex.re_le_norm z) hz
  have hquotient := gaussHypergeometric_div_Gamma a 1 1 (fun n ↦ by
    intro h
    have hreal := congrArg Complex.re h
    have hn : (0 : ℝ) ≤ n := by positivity
    norm_num at hreal
    linarith) z
  rw [Complex.Gamma_one, div_one] at hquotient
  exact ⟨gaussHypergeometric_one_one a hzDomain,
    regularizedGaussHypergeometric_one_one a hzDomain, hquotient,
    hasSum_gaussHypergeometric_geometric hz⟩

end LMLFTest.Results
