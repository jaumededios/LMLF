import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section55
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open LMLFManual
open Verso.Code.External

set_option verso.exampleProject "."

#doc (Manual) "§5.5 Functional Relations" =>
%%%
tag := "chapter-5-section-5"
%%%

# §5.5(i) Recurrence
%%%
number := false
%%%

Source: [DLMF §5.5(i)](https://dlmf.nist.gov/5.5.i).

::::dlmfEntry "5.5.1" "https://dlmf.nist.gov/5.5.E1"
$$`\Gamma(z+1)=z\Gamma(z).`

Away from the nonpositive integers, increasing the argument of the Gamma function by one
multiplies its value by the original argument. The formal statement keeps this ordinary
pointwise domain explicit because Mathlib assigns the value zero to Gamma at its poles.

:::leanStatement "Lean · LMLF.Blueprint.Gamma"
```anchor section55Context (module := LMLF.Blueprint.Gamma.Section55) -showProofStates
namespace LMLF.Blueprint.Gamma

open scoped BigOperators Real
```

```anchor gamma_recurrence (module := LMLF.Blueprint.Gamma.Section55) -showProofStates
theorem gamma_recurrence (z : ℂ) (hz : ∀ m : ℕ, z ≠ -(m : ℂ)) :
    Complex.Gamma (z + 1) = z * Complex.Gamma z
```
:::
::::

::::dlmfEntry "5.5.2" "https://dlmf.nist.gov/5.5.E2"
$$`\psi(z+1)=\psi(z)+\frac1z.`

On the same pole-free domain, the logarithmic derivative of Gamma gains the reciprocal term
$`1/z` when its argument is increased by one.

:::leanStatement "Lean · LMLF.Blueprint.Gamma"
```anchor digamma_recurrence (module := LMLF.Blueprint.Gamma.Section55) -showProofStates
theorem digamma_recurrence (z : ℂ) (hz : ∀ m : ℕ, z ≠ -(m : ℂ)) :
    Complex.digamma (z + 1) = Complex.digamma z + 1 / z
```
:::
::::

# §5.5(ii) Reflection
%%%
number := false
%%%

Source: [DLMF §5.5(ii)](https://dlmf.nist.gov/5.5.ii).

::::dlmfEntry "5.5.3" "https://dlmf.nist.gov/5.5.E3"
For $`z\ne0,\pm1,\pm2,\ldots`,
$$`\Gamma(z)\Gamma(1-z)=\frac{\pi}{\sin(\pi z)}.`

Euler's reflection formula relates the values at complementary arguments. Excluding every integer
is exactly the pointwise condition under which both sides have their usual complex values.

:::leanStatement "Lean · LMLF.Blueprint.Gamma"
```anchor gamma_reflection (module := LMLF.Blueprint.Gamma.Section55) -showProofStates
theorem gamma_reflection (z : ℂ) (hz : ∀ k : ℤ, z ≠ (k : ℂ)) :
    Complex.Gamma z * Complex.Gamma (1 - z) =
      (Real.pi : ℂ) / Complex.sin ((Real.pi : ℂ) * z)
```
:::
::::

::::dlmfEntry "5.5.4" "https://dlmf.nist.gov/5.5.E4"
For $`z\ne0,\pm1,\pm2,\ldots`,
$$`\psi(z)-\psi(1-z)=-\frac{\pi}{\tan(\pi z)}.`

The corresponding reflection law for the digamma function expresses its antisymmetric part under
$`z\mapsto1-z` as the negative cotangent term.

:::leanStatement "Lean · LMLF.Blueprint.Gamma"
```anchor digamma_reflection (module := LMLF.Blueprint.Gamma.Section55) -showProofStates
theorem digamma_reflection (z : ℂ) (hz : ∀ k : ℤ, z ≠ (k : ℂ)) :
    Complex.digamma z - Complex.digamma (1 - z) =
      -(Real.pi : ℂ) / Complex.tan ((Real.pi : ℂ) * z)
```
:::
::::

# §5.5(iii) Multiplication
%%%
number := false
%%%

Source: [DLMF §5.5(iii)](https://dlmf.nist.gov/5.5.iii).

## Duplication formula
%%%
number := false
%%%

::::dlmfEntry "5.5.5" "https://dlmf.nist.gov/5.5.E5"
For $`2z\ne0,-1,-2,\ldots`,
$$`\Gamma(2z)=\pi^{-1/2}2^{2z-1}\Gamma(z)\Gamma\!\left(z+\frac12\right).`

Legendre's duplication formula recovers Gamma at twice the argument from the two values separated
by one half. The powers are principal complex powers; their bases are positive real numbers, so no
branch ambiguity remains.

:::leanStatement "Lean · LMLF.Blueprint.Gamma"
```anchor gamma_duplication (module := LMLF.Blueprint.Gamma.Section55) -showProofStates
theorem gamma_duplication (z : ℂ) (hz : ∀ m : ℕ, 2 * z ≠ -(m : ℂ)) :
    Complex.Gamma (2 * z) =
      (Real.pi : ℂ) ^ (-1 / 2 : ℂ) * (2 : ℂ) ^ (2 * z - 1) *
        Complex.Gamma z * Complex.Gamma (z + 1 / 2)
```
:::
::::

## Gauss's multiplication formula
%%%
number := false
%%%

::::dlmfEntry "5.5.6" "https://dlmf.nist.gov/5.5.E6"
For $`nz\ne0,-1,-2,\ldots`,
$$`\Gamma(nz)=(2\pi)^{(1-n)/2}n^{nz-1/2}
\prod_{k=0}^{n-1}\Gamma\!\left(z+\frac{k}{n}\right).`

For a positive integer $`n`, Gauss's formula expresses Gamma at $`nz` as a finite product of $`n`
equally spaced Gamma values. Positivity of $`n` makes all quotients and powers meaningful; the
displayed exclusion of nonpositive integral values of $`nz` also excludes every pole in the
product.

:::leanStatement "Lean · LMLF.Blueprint.Gamma"
```anchor gamma_multiplication (module := LMLF.Blueprint.Gamma.Section55) -showProofStates
theorem gamma_multiplication (n : ℕ) (hn : 0 < n) (z : ℂ)
    (hz : ∀ m : ℕ, (n : ℂ) * z ≠ -(m : ℂ)) :
    Complex.Gamma ((n : ℂ) * z) =
      (2 * (Real.pi : ℂ)) ^ ((1 - (n : ℂ)) / 2) *
        (n : ℂ) ^ ((n : ℂ) * z - 1 / 2) *
          ∏ k ∈ Finset.range n, Complex.Gamma (z + (k : ℂ) / (n : ℂ))
```
:::
::::

::::dlmfEntry "5.5.7" "https://dlmf.nist.gov/5.5.E7"
For a positive integer $`n`,
$$`\prod_{k=1}^{n-1}\Gamma\!\left(\frac{k}{n}\right)
=(2\pi)^{(n-1)/2}n^{-1/2}.`

This real-valued specialization multiplies Gamma over the nonzero proper fractions with denominator
$`n`. The finite interval is empty when $`n=1`, and both sides then equal one.

:::leanStatement "Lean · LMLF.Blueprint.Gamma · real-valued form"
```anchor gamma_rational_product (module := LMLF.Blueprint.Gamma.Section55) -showProofStates
theorem gamma_rational_product (n : ℕ) (hn : 0 < n) :
    (∏ k ∈ Finset.Ico 1 n, Real.Gamma ((k : ℝ) / (n : ℝ))) =
      (2 * Real.pi) ^ (((n : ℝ) - 1) / 2) * (n : ℝ) ^ (-1 / 2 : ℝ)
```
:::
::::

::::dlmfEntry "5.5.8" "https://dlmf.nist.gov/5.5.E8"
$$`\psi(2z)=\frac12\left(\psi(z)+\psi\!\left(z+\frac12\right)\right)+\ln2.`

The digamma duplication law is stated on its natural pointwise domain: $`2z` is not a
nonpositive integer. That single condition also keeps both digamma terms on the right away from
their poles. Here $`\ln 2` is the principal complex logarithm of the positive real number two.

:::leanStatement "Lean · LMLF.Blueprint.Gamma"
```anchor digamma_duplication (module := LMLF.Blueprint.Gamma.Section55) -showProofStates
theorem digamma_duplication (z : ℂ) (hz : ∀ m : ℕ, 2 * z ≠ -(m : ℂ)) :
    Complex.digamma (2 * z) =
      (Complex.digamma z + Complex.digamma (z + 1 / 2)) / 2 + Complex.log 2
```
:::
::::

::::dlmfEntry "5.5.9" "https://dlmf.nist.gov/5.5.E9"
$$`\psi(nz)=\frac1n\sum_{k=0}^{n-1}\psi\!\left(z+\frac{k}{n}\right)+\ln n.`

For positive integral $`n`, the general multiplication law averages the $`n` equally spaced
digamma values and adds the principal logarithm of $`n`. The pointwise pole exclusion is the same
as for Gauss's Gamma multiplication formula. DLMF notes that this formula follows from E6 by
logarithmic differentiation; this file states both pointwise formulas separately.

:::leanStatement "Lean · LMLF.Blueprint.Gamma"
```anchor digamma_multiplication (module := LMLF.Blueprint.Gamma.Section55) -showProofStates
theorem digamma_multiplication (n : ℕ) (hn : 0 < n) (z : ℂ)
    (hz : ∀ m : ℕ, (n : ℂ) * z ≠ -(m : ℂ)) :
    Complex.digamma ((n : ℂ) * z) =
      (1 / (n : ℂ)) *
          ∑ k ∈ Finset.range n, Complex.digamma (z + (k : ℂ) / (n : ℂ))
        + Complex.log (n : ℂ)
```
:::
::::

# §5.5(iv) Bohr--Mollerup Theorem
%%%
number := false
%%%

Source: [DLMF §5.5(iv)](https://dlmf.nist.gov/5.5.iv).

::::dlmfEntry "§5.5(iv)" "https://dlmf.nist.gov/5.5.iv"
If $`f(x)>0` for $`x>0`, $`f(x+1)=xf(x)`, $`f(1)=1`, and $`\ln f` is convex on
$`(0,\infty)`, then
$$`f(x)=\Gamma(x)\qquad(x>0).`

The Bohr--Mollerup theorem characterizes the real Gamma function uniquely among positive,
log-convex functions satisfying the normalized recurrence. The conclusion is equality on the
positive real axis; the values of $`f` outside that interval are irrelevant.

:::leanStatement "Lean · LMLF.Blueprint.Gamma"
```anchor bohrMollerup_unique (module := LMLF.Blueprint.Gamma.Section55) -showProofStates
theorem bohrMollerup_unique {f : ℝ → ℝ}
    (hf_pos : ∀ {x : ℝ}, 0 < x → 0 < f x)
    (hf_recurrence : ∀ {x : ℝ}, 0 < x → f (x + 1) = x * f x)
    (hf_one : f 1 = 1)
    (hf_logConvex : ConvexOn ℝ (Set.Ioi 0) (Real.log ∘ f)) :
    Set.EqOn f Real.Gamma (Set.Ioi 0)
```
:::
::::
