import LMLF.Results.HypergeometricPrincipal

/-!
# Public-use tests for principal Gauss exceptional-parameter results
-/

namespace LMLFTest.Results

open LMLF.Definitions LMLF.ODE

example {a b z : ℂ} (N : ℕ) (hz : z ∈ gaussHypergeometricDomain) :
    regularizedGaussHypergeometric a b (-(N : ℂ)) z =
      (ascPochhammer ℂ (N + 1)).eval a *
        (ascPochhammer ℂ (N + 1)).eval b * z ^ (N + 1) *
          regularizedGaussHypergeometric
            (a + ((N + 1 : ℕ) : ℂ))
            (b + ((N + 1 : ℕ) : ℂ)) ((N + 2 : ℕ) : ℂ) z :=
  regularizedGaussHypergeometric_neg_nat N hz

example {a b z : ℂ} (N : ℕ) (hz : z ∈ gaussHypergeometricDomain) :
    regularizedGaussHypergeometric a b (-(N : ℂ)) z =
      ((ascPochhammer ℂ (N + 1)).eval a *
          (ascPochhammer ℂ (N + 1)).eval b * z ^ (N + 1) /
        (Nat.factorial (N + 1) : ℂ)) *
          gaussHypergeometric
            (a + ((N + 1 : ℕ) : ℂ))
            (b + ((N + 1 : ℕ) : ℂ)) ((N + 2 : ℕ) : ℂ) z :=
  regularizedGaussHypergeometric_neg_nat_eq_gauss N hz

example {a b z : ℂ} (hz : z ∈ gaussHypergeometricDomain) :
    regularizedGaussHypergeometric a b 0 z =
      a * b * z * regularizedGaussHypergeometric (a + 1) (b + 1) 2 z := by
  simpa using regularizedGaussHypergeometric_neg_nat (a := a) (b := b) 0 hz

example {a b z : ℂ} (hz : z ∈ gaussHypergeometricDomain) :
    regularizedGaussHypergeometric a b 0 z =
      a * b * z * gaussHypergeometric (a + 1) (b + 1) 2 z := by
  simpa using regularizedGaussHypergeometric_neg_nat_eq_gauss (a := a) (b := b) 0 hz

example (a b : ℂ) (N : ℕ) :
    regularizedGaussHypergeometric a b (-(N : ℂ)) 0 = 0 := by
  rw [regularizedGaussHypergeometric_neg_nat N (by simp)]
  simp

example (a b : ℂ) (N : ℕ) :
    regularizedGaussHypergeometric a b (-(N : ℂ)) (1 / 2) =
      (ascPochhammer ℂ (N + 1)).eval a *
        (ascPochhammer ℂ (N + 1)).eval b * (1 / 2) ^ (N + 1) *
          regularizedGaussHypergeometric
            (a + ((N + 1 : ℕ) : ℂ))
            (b + ((N + 1 : ℕ) : ℂ)) ((N + 2 : ℕ) : ℂ) (1 / 2) := by
  exact regularizedGaussHypergeometric_neg_nat N (by
    rw [mem_gaussHypergeometricDomain_iff]
    right
    norm_num [div_eq_mul_inv])

example (a b : ℂ) (N : ℕ) :
    regularizedGaussHypergeometric a b (-(N : ℂ)) (-1 / 2) =
      ((ascPochhammer ℂ (N + 1)).eval a *
          (ascPochhammer ℂ (N + 1)).eval b * (-1 / 2) ^ (N + 1) /
        (Nat.factorial (N + 1) : ℂ)) *
          gaussHypergeometric
            (a + ((N + 1 : ℕ) : ℂ))
            (b + ((N + 1 : ℕ) : ℂ)) ((N + 2 : ℕ) : ℂ) (-1 / 2) := by
  exact regularizedGaussHypergeometric_neg_nat_eq_gauss N (by
    rw [mem_gaussHypergeometricDomain_iff]
    right
    norm_num [div_eq_mul_inv])

example (a b : ℂ) (N : ℕ) :
    regularizedGaussHypergeometric a b (-(N : ℂ)) Complex.I =
      (ascPochhammer ℂ (N + 1)).eval a *
        (ascPochhammer ℂ (N + 1)).eval b * Complex.I ^ (N + 1) *
          regularizedGaussHypergeometric
            (a + ((N + 1 : ℕ) : ℂ))
            (b + ((N + 1 : ℕ) : ℂ)) ((N + 2 : ℕ) : ℂ) Complex.I := by
  exact regularizedGaussHypergeometric_neg_nat N (by simp)

example (a b : ℂ) (N : ℕ) :
    regularizedGaussHypergeometric a b (-(N : ℂ)) (-Complex.I) =
      (ascPochhammer ℂ (N + 1)).eval a *
        (ascPochhammer ℂ (N + 1)).eval b * (-Complex.I) ^ (N + 1) *
          regularizedGaussHypergeometric
            (a + ((N + 1 : ℕ) : ℂ))
            (b + ((N + 1 : ℕ) : ℂ)) ((N + 2 : ℕ) : ℂ) (-Complex.I) := by
  exact regularizedGaussHypergeometric_neg_nat N (by simp)

example (b z : ℂ) (m N : ℕ) (hm : m ≤ N) :
    regularizedGaussHypergeometric (-(m : ℂ)) b (-(N : ℂ)) z = 0 :=
  regularizedGaussHypergeometric_eq_zero_of_early_left_termination b m N hm z

example (a z : ℂ) (m N : ℕ) (hm : m ≤ N) :
    regularizedGaussHypergeometric a (-(m : ℂ)) (-(N : ℂ)) z = 0 :=
  regularizedGaussHypergeometric_eq_zero_of_early_right_termination a m N hm z

example (m N : ℕ) (hm : m ≤ N) (z : ℂ) :
    regularizedGaussHypergeometric (-(m : ℂ)) (-(m : ℂ)) (-(N : ℂ)) z = 0 :=
  regularizedGaussHypergeometric_eq_zero_of_early_left_termination (-(m : ℂ)) m N hm z

example (b : ℂ) (m N : ℕ) (hm : m ≤ N) :
    regularizedGaussHypergeometric (-(m : ℂ)) b (-(N : ℂ)) 1 = 0 :=
  regularizedGaussHypergeometric_eq_zero_of_early_left_termination b m N hm 1

example (a : ℂ) (m N : ℕ) (hm : m ≤ N) :
    regularizedGaussHypergeometric a (-(m : ℂ)) (-(N : ℂ)) 2 = 0 :=
  regularizedGaussHypergeometric_eq_zero_of_early_right_termination a m N hm 2

example (a b c : ℂ) :
    regularizedGaussHypergeometric a b c 1 =
      regularizedGaussHypergeometricSeriesSum a b c 1 := by
  exact regularizedGaussHypergeometric_eqOn_seriesSum_compl a b c (by
    norm_num [gaussHypergeometricDomain, Complex.le_def])

example (a b c : ℂ) :
    regularizedGaussHypergeometric a b c 2 =
      regularizedGaussHypergeometricSeriesSum a b c 2 := by
  exact regularizedGaussHypergeometric_eqOn_seriesSum_compl a b c (by
    norm_num [gaussHypergeometricDomain, Complex.le_def])

example : regularizedGaussHypergeometric 0 0 1 1 = 1 := by
  rw [regularizedGaussHypergeometric_eqOn_seriesSum_compl 0 0 1 (by
    norm_num [gaussHypergeometricDomain, Complex.le_def])]
  rw [regularizedGaussHypergeometricSeriesSum, Complex.regularizedGaussHGFun,
    FormalMultilinearSeries.sum]
  have hterms :
      (fun k : ℕ ↦ (Complex.regularizedGaussHGFunSeries 0 0 1 k) (fun _ ↦ (1 : ℂ))) =
        fun k ↦ if k = 0 then 1 else 0 := by
    funext k
    rw [FormalMultilinearSeries.apply_eq_prod_smul_coeff,
      Complex.coeff_regularizedGaussHGFunSeries]
    by_cases hk : k = 0
    · subst k
      simp [Complex.Gamma_one]
    · have hkpos : 0 < k := Nat.pos_of_ne_zero hk
      have hp : (ascPochhammer ℂ k).eval 0 = 0 := by
        simpa using (@ascPochhammer_eval_neg_coe_nat_of_lt ℂ _ k 0) hkpos
      rw [hp]
      simp [hk]
  rw [hterms]
  simp

/-- A public consumer composing the principal exceptional shift, principal analyticity, and the
principal polynomial Gauss equation. It intentionally makes no exact vanishing-order claim when
the Pochhammer prefactor is zero. -/
theorem principalExceptionalGaussCertificate (a b : ℂ) (N : ℕ) :
    let H : ℂ → ℂ := fun z ↦
      ((ascPochhammer ℂ (N + 1)).eval a *
        (ascPochhammer ℂ (N + 1)).eval b) *
          regularizedGaussHypergeometric
            (a + ((N + 1 : ℕ) : ℂ))
            (b + ((N + 1 : ℕ) : ℂ)) ((N + 2 : ℕ) : ℂ) z
    Set.EqOn (regularizedGaussHypergeometric a b (-(N : ℂ)))
        (fun z ↦ z ^ (N + 1) * H z) gaussHypergeometricDomain ∧
      AnalyticOnNhd ℂ H gaussHypergeometricDomain ∧
      ∀ z ∈ gaussHypergeometricDomain,
        z * (1 - z) * deriv (deriv (regularizedGaussHypergeometric a b (-(N : ℂ)))) z +
            (-(N : ℂ) - (a + b + 1) * z) *
              deriv (regularizedGaussHypergeometric a b (-(N : ℂ))) z -
          a * b * regularizedGaussHypergeometric a b (-(N : ℂ)) z = 0 := by
  dsimp only
  refine ⟨?_, ?_, ?_⟩
  · intro z hz
    have hshift := regularizedGaussHypergeometric_neg_nat (a := a) (b := b) N hz
    simpa only [mul_assoc, mul_comm, mul_left_comm] using hshift
  · exact analyticOnNhd_const.mul
      (regularizedGaussHypergeometric_analyticOnNhd
        (a + ((N + 1 : ℕ) : ℂ))
        (b + ((N + 1 : ℕ) : ℂ)) ((N + 2 : ℕ) : ℂ))
  · intro z hz
    exact regularizedGaussHypergeometric_gaussEquation a b (-(N : ℂ)) hz

end LMLFTest.Results
