import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section57
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§5.7 Series Expansions" =>
%%%
tag := "chapter-5-section-7"
%%%

This page covers every numbered formula in
[DLMF §5.7](https://dlmf.nist.gov/5.7). Infinite series are stated with `HasSum`, so convergence
and the claimed value are one assertion.

# §5.7(i) Maclaurin and Taylor Series
%%%
number := false
%%%

Throughout this subsection, $`\zeta` denotes the Riemann zeta function, as defined in DLMF
Chapter 25.

::::dlmfEntry "5.7.1" "https://dlmf.nist.gov/5.7.E1"
$$`\frac{1}{\Gamma(z)}=\sum_{k=1}^{\infty}c_kz^k,
\qquad c_1=1,\quad c_2=\gamma.`

The reciprocal Gamma function is entire. Its Maclaurin series therefore converges at every complex
argument. Lean defines `reciprocalGammaCoeff k` as the usual derivative divided by `k!`; shifting a
natural-number index by one represents DLMF's sum beginning at `k=1` without an artificial zero
term.

:::leanStatement "Lean statement · LMLF.Blueprint.Gamma"
```anchor reciprocalGammaCoeff (module := LMLF.Blueprint.Gamma.Section57) -showProofStates
noncomputable def reciprocalGammaCoeff (k : ℕ) : ℂ :=
  iteratedDeriv k (fun z : ℂ ↦ (Complex.Gamma z)⁻¹) 0 /
    (k.factorial : ℂ)
```

```anchor reciprocalGamma_hasSum (module := LMLF.Blueprint.Gamma.Section57) -showProofStates
theorem reciprocalGamma_hasSum (z : ℂ) :
    HasSum
      (fun n : ℕ ↦ reciprocalGammaCoeff (n + 1) * z ^ (n + 1))
      (Complex.Gamma z)⁻¹
```

```anchor reciprocalGammaCoeff_one (module := LMLF.Blueprint.Gamma.Section57) -showProofStates
theorem reciprocalGammaCoeff_one : reciprocalGammaCoeff 1 = 1
```

```anchor reciprocalGammaCoeff_two (module := LMLF.Blueprint.Gamma.Section57) -showProofStates
theorem reciprocalGammaCoeff_two :
    reciprocalGammaCoeff 2 = (Real.eulerMascheroniConstant : ℂ)
```
:::
::::

::::dlmfEntry "5.7.2" "https://dlmf.nist.gov/5.7.E2"
For $`k\ge3`,
$$`(k-1)c_k=\gamma c_{k-1}-\zeta(2)c_{k-2}+\zeta(3)c_{k-3}
-\cdots+(-1)^k\zeta(k-1)c_1.`

The Lean statement removes the ellipsis. The finite sum has index `j=2,…,k-1`, coefficient
`(-1)^(j+1) · ζ(j)`, and reciprocal-Gamma coefficient `c_(k-j)`, exactly reproducing the displayed
alternating recurrence.

:::leanStatement "Lean statement · finite recurrence"
```anchor reciprocalGammaCoeff_recurrence (module := LMLF.Blueprint.Gamma.Section57) -showProofStates
theorem reciprocalGammaCoeff_recurrence (k : ℕ) (hk : 3 ≤ k) :
    ((k - 1 : ℕ) : ℂ) * reciprocalGammaCoeff k =
      (Real.eulerMascheroniConstant : ℂ) *
          reciprocalGammaCoeff (k - 1) +
        ∑ j ∈ Finset.Icc 2 (k - 1),
          (-1 : ℂ) ^ (j + 1) * riemannZeta (j : ℂ) *
            reciprocalGammaCoeff (k - j)
```
:::
::::

::::dlmfEntry "5.7.3" "https://dlmf.nist.gov/5.7.E3"
For $`|z|<2`,
$$`\ln\Gamma(1+z)=-\ln(1+z)+z(1-\gamma)
+\sum_{k=2}^{\infty}(-1)^k(\zeta(k)-1)\frac{z^k}{k}.`

The `ln Gamma` in this formula is a branch-consistent log-Gamma, not the global composition
`Complex.log (Complex.Gamma ·)`: those principal values differ by multiples of `2πi` on part of the
source disk. Lean therefore names the branch selected by this expansion and separately states that
its exponential is Gamma. The explicit `z ≠ -1` records the Gamma pole and the undefined `log 0`
which are implicit in the source notation.

:::leanStatement "Lean statement · branch-consistent log-Gamma"
```anchor logGammaOnePlusSeriesTerm (module := LMLF.Blueprint.Gamma.Section57) -showProofStates
noncomputable def logGammaOnePlusSeriesTerm (z : ℂ) (n : ℕ) : ℂ :=
  (-1 : ℂ) ^ (n + 2) *
    (riemannZeta (n + 2 : ℕ) - 1) * z ^ (n + 2) /
      (n + 2 : ℕ)
```

```anchor logGammaOnePlus (module := LMLF.Blueprint.Gamma.Section57) -showProofStates
noncomputable def logGammaOnePlus (z : ℂ) : ℂ :=
  -Complex.log (1 + z) +
    z * (1 - (Real.eulerMascheroniConstant : ℂ)) +
      ∑' n : ℕ, logGammaOnePlusSeriesTerm z n
```

```anchor exp_logGammaOnePlus (module := LMLF.Blueprint.Gamma.Section57) -showProofStates
theorem exp_logGammaOnePlus {z : ℂ} (hz : ‖z‖ < 2) (hzneg : z ≠ -1) :
    Complex.exp (logGammaOnePlus z) = Complex.Gamma (1 + z)
```

```anchor logGamma_one_add_hasSum (module := LMLF.Blueprint.Gamma.Section57) -showProofStates
theorem logGamma_one_add_hasSum
    {z : ℂ} (hz : ‖z‖ < 2) (hzneg : z ≠ -1) :
    HasSum (logGammaOnePlusSeriesTerm z)
      (logGammaOnePlus z + Complex.log (1 + z) -
        z * (1 - (Real.eulerMascheroniConstant : ℂ)))
```
:::
::::

::::dlmfEntry "5.7.4" "https://dlmf.nist.gov/5.7.E4"
For $`|z|<1`,
$$`\psi(1+z)=-\gamma+
\sum_{k=2}^{\infty}(-1)^k\zeta(k)z^{k-1}.`

This is the Taylor series of digamma at `1`. Again, the shifted Lean index makes `n=0` correspond
to DLMF's first term `k=2`.

:::leanStatement "Lean statement · digamma Taylor series"
```anchor digamma_one_add_hasSum (module := LMLF.Blueprint.Gamma.Section57) -showProofStates
theorem digamma_one_add_hasSum {z : ℂ} (hz : ‖z‖ < 1) :
    HasSum
      (fun n : ℕ ↦
        (-1 : ℂ) ^ (n + 2) * riemannZeta (n + 2 : ℕ) *
          z ^ (n + 1))
      (Complex.digamma (1 + z) +
        (Real.eulerMascheroniConstant : ℂ))
```
:::
::::

::::dlmfEntry "5.7.5" "https://dlmf.nist.gov/5.7.E5"
For $`|z|<2` and $`z\ne0,\pm1`,
$$`\psi(1+z)=\frac{1}{2z}-\frac{\pi}{2}\cot(\pi z)
+\frac{1}{z^2-1}+1-\gamma
-\sum_{k=1}^{\infty}(\zeta(2k+1)-1)z^{2k}.`

The three exclusions make every elementary term in the displayed identity meaningful. Lean states
that the even-power series converges to the elementary expression minus `digamma (1+z)`.

:::leanStatement "Lean statement · accelerated even-power series"
```anchor digamma_one_add_even_hasSum (module := LMLF.Blueprint.Gamma.Section57) -showProofStates
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
```
:::
::::

# §5.7(ii) Other Series
%%%
number := false
%%%

::::dlmfEntry "5.7.6" "https://dlmf.nist.gov/5.7.E6"
When $`z\ne0,-1,-2,\ldots`,
$$`\psi(z)=-\gamma-\frac1z+
\sum_{k=1}^{\infty}\frac{z}{k(k+z)}
=-\gamma+
\sum_{k=0}^{\infty}\left(\frac1{k+1}-\frac1{k+z}\right).`

One numbered DLMF equation contains two convergent series. The Lean theorem therefore returns both
`HasSum` statements together. The pole-avoidance hypothesis is written literally as exclusion of
every negative natural-number cast.

:::leanStatement "Lean statement · two partial-fraction series"
```anchor digamma_partialFractions_hasSum (module := LMLF.Blueprint.Gamma.Section57) -showProofStates
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
```
:::
::::

::::dlmfEntry "5.7.7" "https://dlmf.nist.gov/5.7.E7"
Under the same exclusion $`z\ne0,-1,-2,\ldots`,
$$`\psi\!\left(\frac{z+1}{2}\right)-
\psi\!\left(\frac z2\right)
=2\sum_{k=0}^{\infty}\frac{(-1)^k}{k+z}.`

The factor `2` is included in each Lean summand, so the `HasSum` target is exactly the displayed
digamma difference.

:::leanStatement "Lean statement · alternating partial fractions"
```anchor digamma_halfDifference_hasSum (module := LMLF.Blueprint.Gamma.Section57) -showProofStates
theorem digamma_halfDifference_hasSum
    {z : ℂ} (hz : ∀ n : ℕ, z ≠ -(n : ℂ)) :
    HasSum
      (fun n : ℕ ↦ 2 * (-1 : ℂ) ^ n / ((n : ℂ) + z))
      (Complex.digamma ((z + 1) / 2) - Complex.digamma (z / 2))
```
:::
::::

::::dlmfEntry "5.7.8" "https://dlmf.nist.gov/5.7.E8"
For real $`y`,
$$`\Im\psi(1+\mathrm{i}y)=
\sum_{k=1}^{\infty}\frac{y}{k^2+y^2}.`

This is a real series. Its sum is the imaginary part of Mathlib's complex digamma function at
`1 + i y`; the shifted Lean index represents the source index beginning at `k=1`.

:::leanStatement "Lean statement · real-valued series"
```anchor digamma_one_add_mul_I_im_hasSum (module := LMLF.Blueprint.Gamma.Section57) -showProofStates
theorem digamma_one_add_mul_I_im_hasSum (y : ℝ) :
    HasSum
      (fun n : ℕ ↦ y / ((n + 1 : ℕ) ^ 2 + y ^ 2))
      (Complex.digamma (1 + Complex.I * y)).im
```
:::
::::
