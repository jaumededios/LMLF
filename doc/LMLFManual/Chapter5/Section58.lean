import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section58
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§5.8 Infinite Products" =>
%%%
tag := "chapter-5-section-8"
%%%

::::dlmfEntry "5.8.1" "https://dlmf.nist.gov/5.8.E1"
For $`z\ne0,-1,-2,\ldots`,
$$`\Gamma(z)=\lim_{k\to\infty}
\frac{k!\,k^z}{z(z+1)\cdots(z+k)}.`

`gammaShiftedProduct z (k+1)` is the denominator `z(z+1)⋯(z+k)`. The corresponding finite
approximation tends to Mathlib's complex Gamma function. The hypothesis excludes exactly the
nonpositive integers listed by DLMF.

:::leanStatement "Lean statement · Euler limit"
```anchor gammaShiftedProduct (module := LMLF.Blueprint.Gamma.Section58) -showProofStates
def gammaShiftedProduct (z : ℂ) (n : ℕ) : ℂ :=
  ∏ j ∈ Finset.range n, (z + j)
```

```anchor gammaLimitApprox (module := LMLF.Blueprint.Gamma.Section58) -showProofStates
noncomputable def gammaLimitApprox (z : ℂ) (n : ℕ) : ℂ :=
  (n.factorial : ℂ) * Complex.cpow n z /
    gammaShiftedProduct z (n + 1)
```

```anchor gamma_limit_formula (module := LMLF.Blueprint.Gamma.Section58) -showProofStates
theorem gamma_limit_formula {z : ℂ}
    (hz : ∀ n : ℕ, z ≠ -(n : ℂ)) :
    Tendsto (gammaLimitApprox z) atTop (nhds (Complex.Gamma z))
```
:::
::::

::::dlmfEntry "5.8.2" "https://dlmf.nist.gov/5.8.E2"
For every complex $`z`,
$$`\frac1{\Gamma(z)}=z\mathrm e^{\gamma z}
\prod_{k=1}^{\infty}\left(1+\frac zk\right)\mathrm e^{-z/k}.`

The finite approximation includes both the prefactor and the first `n` product factors. Stating the
limit of this whole expression is important at `z=0`: dividing reciprocal Gamma by the prefactor
would introduce an artificial `0/0`.

:::leanStatement "Lean statement · Weierstrass product"
```anchor reciprocalGammaWeierstrassFactor (module := LMLF.Blueprint.Gamma.Section58) -showProofStates
noncomputable def reciprocalGammaWeierstrassFactor
    (z : ℂ) (k : ℕ) : ℂ :=
  (1 + z / (k + 1 : ℕ)) * Complex.exp (-z / (k + 1 : ℕ))
```

```anchor reciprocalGammaProductApprox (module := LMLF.Blueprint.Gamma.Section58) -showProofStates
noncomputable def reciprocalGammaProductApprox (z : ℂ) (n : ℕ) : ℂ :=
  z * Complex.exp ((Real.eulerMascheroniConstant : ℂ) * z) *
    ∏ k ∈ Finset.range n, reciprocalGammaWeierstrassFactor z k
```

```anchor reciprocalGamma_weierstrassProduct (module := LMLF.Blueprint.Gamma.Section58) -showProofStates
theorem reciprocalGamma_weierstrassProduct (z : ℂ) :
    Tendsto (reciprocalGammaProductApprox z) atTop
      (nhds (Complex.Gamma z)⁻¹)
```
:::
::::

::::dlmfEntry "5.8.3" "https://dlmf.nist.gov/5.8.E3"
For real $`x,y` with $`x\ne0,-1,-2,\ldots`,
$$`\left|\frac{\Gamma(x)}{\Gamma(x+\mathrm{i}y)}\right|^2
=\prod_{k=0}^{\infty}\left(1+\frac{y^2}{(x+k)^2}\right).`

The right-hand side is a real product beginning at `k=0`. Lean states directly that its finite
partial products tend to the squared complex norm of the Gamma ratio.

:::leanStatement "Lean statement · squared modulus ratio"
```anchor gammaNormRatioSqProductApprox (module := LMLF.Blueprint.Gamma.Section58) -showProofStates
noncomputable def gammaNormRatioSqProductApprox
    (x y : ℝ) (n : ℕ) : ℝ :=
  Finset.prod (Finset.range n) fun k ↦
    1 + y ^ 2 / (x + (k : ℝ)) ^ 2
```

```anchor gamma_norm_ratio_sq_product (module := LMLF.Blueprint.Gamma.Section58) -showProofStates
theorem gamma_norm_ratio_sq_product
    {x : ℝ} (y : ℝ) (hx : ∀ n : ℕ, x ≠ -(n : ℝ)) :
    Tendsto (gammaNormRatioSqProductApprox x y) atTop
      (nhds
        (‖Complex.Gamma (x : ℂ) /
            Complex.Gamma ((x : ℂ) + Complex.I * y)‖ ^ 2))
```
:::
::::

::::dlmfEntry "5.8.4" "https://dlmf.nist.gov/5.8.E4"
Let $`a_1,\ldots,a_m` and $`b_1,\ldots,b_m` satisfy
$$`\sum_{k=1}^{m}a_k=\sum_{k=1}^{m}b_k.`

This numbered equation is the balancing hypothesis for 5.8.5, not an independent conclusion.
Finite families indexed by `Fin m` express the two sums without indexing edge cases.

:::leanStatement "Lean definition · balancing hypothesis"
```anchor BalancedGammaParameters (module := LMLF.Blueprint.Gamma.Section58) -showProofStates
def BalancedGammaParameters {m : ℕ}
    (a b : Fin m → ℂ) : Prop :=
  ∑ i, a i = ∑ i, b i
```
:::
::::

::::dlmfEntry "5.8.5" "https://dlmf.nist.gov/5.8.E5"
If 5.8.4 holds and no $`b_j` is a nonpositive integer, then
$$`\prod_{k=0}^{\infty}
\frac{(a_1+k)(a_2+k)\cdots(a_m+k)}
     {(b_1+k)(b_2+k)\cdots(b_m+k)}
=\frac{\Gamma(b_1)\Gamma(b_2)\cdots\Gamma(b_m)}
       {\Gamma(a_1)\Gamma(a_2)\cdots\Gamma(a_m)}.`

Each `balancedGammaRatioFactor a b k` is the finite ratio at index `k`. Under the balancing
condition, its partial products converge to the quotient of the two finite Gamma products. The Lean
hypothesis excludes nonpositive integers only from `b`, matching DLMF's stated condition.

:::leanStatement "Lean statement · balanced Gamma-ratio product"
```anchor balancedGammaRatioFactor (module := LMLF.Blueprint.Gamma.Section58) -showProofStates
noncomputable def balancedGammaRatioFactor {m : ℕ}
    (a b : Fin m → ℂ) (k : ℕ) : ℂ :=
  (∏ i, (a i + k)) / ∏ i, (b i + k)
```

```anchor balancedGammaRatioProductApprox (module := LMLF.Blueprint.Gamma.Section58) -showProofStates
noncomputable def balancedGammaRatioProductApprox {m : ℕ}
    (a b : Fin m → ℂ) (n : ℕ) : ℂ :=
  ∏ k ∈ Finset.range n, balancedGammaRatioFactor a b k
```

```anchor balanced_gamma_ratio_product (module := LMLF.Blueprint.Gamma.Section58) -showProofStates
theorem balanced_gamma_ratio_product {m : ℕ}
    {a b : Fin m → ℂ} (hab : BalancedGammaParameters a b)
    (hb : ∀ i n, b i ≠ -(n : ℂ)) :
    Tendsto (balancedGammaRatioProductApprox a b) atTop
      (nhds ((∏ i, Complex.Gamma (b i)) /
        ∏ i, Complex.Gamma (a i)))
```
:::
::::
