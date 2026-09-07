import Mathlib.Analysis.SpecialFunctions.Gamma.Basic
import Mathlib.NumberTheory.Harmonic.EulerMascheroni

-- ANCHOR: gammaSection58Context
namespace LMLF.Blueprint.Gamma

open Filter
-- ANCHOR_END: gammaSection58Context

/-- DLMF 5.8.1: the denominator product `z (z + 1) ⋯ (z + n - 1)`. -/
-- ANCHOR: gammaShiftedProduct
def gammaShiftedProduct (z : ℂ) (n : ℕ) : ℂ :=
  ∏ j ∈ Finset.range n, (z + j)
-- ANCHOR_END: gammaShiftedProduct

/-- DLMF 5.8.1: the finite expression whose limit is Gamma. -/
-- ANCHOR: gammaLimitApprox
noncomputable def gammaLimitApprox (z : ℂ) (n : ℕ) : ℂ :=
  (n.factorial : ℂ) * Complex.cpow n z /
    gammaShiftedProduct z (n + 1)
-- ANCHOR_END: gammaLimitApprox

/-- DLMF 5.8.1: Euler's limit formula for Gamma. -/
-- DLMF 5.8.1 https://dlmf.nist.gov/5.8.E1
-- ANCHOR: gamma_limit_formula
theorem gamma_limit_formula {z : ℂ}
    (hz : ∀ n : ℕ, z ≠ -(n : ℂ)) :
    Tendsto (gammaLimitApprox z) atTop (nhds (Complex.Gamma z))
-- ANCHOR_END: gamma_limit_formula
:= by
  sorry

/-- DLMF 5.8.2: the factor indexed by `k + 1` in the Weierstrass product. -/
-- ANCHOR: reciprocalGammaWeierstrassFactor
noncomputable def reciprocalGammaWeierstrassFactor
    (z : ℂ) (k : ℕ) : ℂ :=
  (1 + z / (k + 1 : ℕ)) * Complex.exp (-z / (k + 1 : ℕ))
-- ANCHOR_END: reciprocalGammaWeierstrassFactor

/-- DLMF 5.8.2: the prefactor times the first `n` factors of the Weierstrass product. -/
-- ANCHOR: reciprocalGammaProductApprox
noncomputable def reciprocalGammaProductApprox (z : ℂ) (n : ℕ) : ℂ :=
  z * Complex.exp ((Real.eulerMascheroniConstant : ℂ) * z) *
    ∏ k ∈ Finset.range n, reciprocalGammaWeierstrassFactor z k
-- ANCHOR_END: reciprocalGammaProductApprox

/-- DLMF 5.8.2: the Weierstrass product for reciprocal Gamma. -/
-- DLMF 5.8.2 https://dlmf.nist.gov/5.8.E2
-- ANCHOR: reciprocalGamma_weierstrassProduct
theorem reciprocalGamma_weierstrassProduct (z : ℂ) :
    Tendsto (reciprocalGammaProductApprox z) atTop
      (nhds (Complex.Gamma z)⁻¹)
-- ANCHOR_END: reciprocalGamma_weierstrassProduct
:= by
  sorry

/-- DLMF 5.8.3: the first `n` factors of the real Gamma-modulus ratio product. -/
-- ANCHOR: gammaNormRatioSqProductApprox
noncomputable def gammaNormRatioSqProductApprox
    (x y : ℝ) (n : ℕ) : ℝ :=
  Finset.prod (Finset.range n) fun k ↦
    1 + y ^ 2 / (x + (k : ℝ)) ^ 2
-- ANCHOR_END: gammaNormRatioSqProductApprox

/-- DLMF 5.8.3: the infinite product for a squared Gamma-modulus ratio. -/
-- DLMF 5.8.3 https://dlmf.nist.gov/5.8.E3
-- ANCHOR: gamma_norm_ratio_sq_product
theorem gamma_norm_ratio_sq_product
    {x : ℝ} (y : ℝ) (hx : ∀ n : ℕ, x ≠ -(n : ℝ)) :
    Tendsto (gammaNormRatioSqProductApprox x y) atTop
      (nhds
        (‖Complex.Gamma (x : ℂ) /
            Complex.Gamma ((x : ℂ) + Complex.I * y)‖ ^ 2))
-- ANCHOR_END: gamma_norm_ratio_sq_product
:= by
  sorry

/-- DLMF 5.8.4: the balancing condition for the product in DLMF 5.8.5. -/
-- DLMF 5.8.4 https://dlmf.nist.gov/5.8.E4
-- ANCHOR: BalancedGammaParameters
def BalancedGammaParameters {m : ℕ}
    (a b : Fin m → ℂ) : Prop :=
  ∑ i, a i = ∑ i, b i
-- ANCHOR_END: BalancedGammaParameters

/-- DLMF 5.8.5: the factor of index `k` in the balanced Gamma-ratio product. -/
-- ANCHOR: balancedGammaRatioFactor
noncomputable def balancedGammaRatioFactor {m : ℕ}
    (a b : Fin m → ℂ) (k : ℕ) : ℂ :=
  (∏ i, (a i + k)) / ∏ i, (b i + k)
-- ANCHOR_END: balancedGammaRatioFactor

/-- DLMF 5.8.5: the first `n` factors of the balanced Gamma-ratio product. -/
-- ANCHOR: balancedGammaRatioProductApprox
noncomputable def balancedGammaRatioProductApprox {m : ℕ}
    (a b : Fin m → ℂ) (n : ℕ) : ℂ :=
  ∏ k ∈ Finset.range n, balancedGammaRatioFactor a b k
-- ANCHOR_END: balancedGammaRatioProductApprox

/-- DLMF 5.8.5: the infinite product for balanced finite families of Gamma arguments. -/
-- DLMF 5.8.5 https://dlmf.nist.gov/5.8.E5
-- ANCHOR: balanced_gamma_ratio_product
theorem balanced_gamma_ratio_product {m : ℕ}
    {a b : Fin m → ℂ} (hab : BalancedGammaParameters a b)
    (hb : ∀ i n, b i ≠ -(n : ℂ)) :
    Tendsto (balancedGammaRatioProductApprox a b) atTop
      (nhds ((∏ i, Complex.Gamma (b i)) /
        ∏ i, Complex.Gamma (a i)))
-- ANCHOR_END: balanced_gamma_ratio_product
:= by
  sorry

end LMLF.Blueprint.Gamma
