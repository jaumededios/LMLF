import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section44
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual
open Filter Finset

set_option verso.exampleProject "."

#doc (Manual) "§4.4 Special Values and Limits" =>
%%%
tag := "chapter-4-section-4"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.4"
Source: NIST Digital Library of Mathematical Functions, §4.4.
:::

This section records principal-logarithm values, elementary exponential values,
and limits. Complex statements use the principal branch; real-variable limits
are written on the positive half-line where that branch is unambiguous.

# §4.4(i) Logarithms
%%%
number := false
%%%

::::dlmfEntry "4.4.1" "https://dlmf.nist.gov/4.4.E1"
$$`\[\ln 1=0.\]`

The principal logarithm at one is zero.

:::leanStatement "Principal logarithm at one"
```anchor dlmf_4_4_1 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_1 : Complex.log 1 = 0
```
:::
::::

::::dlmfEntry "4.4.2" "https://dlmf.nist.gov/4.4.E2"
$$`\[\ln(-1\mathbin{\pm}i0)=\mathbin{\pm}\pi i.\]`

Approaching the negative real axis from above or below gives the two boundary
values of the principal logarithm, with arguments `+π` and `−π`.

:::leanStatement "Logarithm boundary values at minus one"
```anchor dlmf_4_4_2 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_2 :
    Tendsto (fun t : ℝ ↦ Complex.log (-1 + t * Complex.I))
        (𝓝[>] 0) (𝓝 (Real.pi * Complex.I)) ∧
      Tendsto (fun t : ℝ ↦ Complex.log (-1 - t * Complex.I))
        (𝓝[>] 0) (𝓝 (-Real.pi * Complex.I))
```
:::
::::

::::dlmfEntry "4.4.3" "https://dlmf.nist.gov/4.4.E3"
$$`\[\ln(\mathord{\pm}i)=\mathord{\pm}\tfrac12\pi i.\]`

The principal logarithm of the positive and negative imaginary units has
argument `±π/2`.

:::leanStatement "Logarithm at the imaginary units"
```anchor dlmf_4_4_3 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_3 :
    Complex.log Complex.I = (Real.pi / 2 : ℂ) * Complex.I ∧
      Complex.log (-Complex.I) = -(Real.pi / 2 : ℂ) * Complex.I
```
:::
::::

# §4.4(ii) Powers
%%%
number := false
%%%

::::dlmfEntry "4.4.4" "https://dlmf.nist.gov/4.4.E4"
$$`\[e^0=1.\]`

The exponential at zero is one.

:::leanStatement "Exponential at zero"
```anchor dlmf_4_4_4 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_4 : Complex.exp 0 = 1
```
:::
::::

::::dlmfEntry "4.4.5" "https://dlmf.nist.gov/4.4.E5"
$$`\[e^{\mathord{\pm}\pi i}=-1.\]`

Both half-turns on the unit circle map to `−1`.

:::leanStatement "Exponential at the half-turns"
```anchor dlmf_4_4_5 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_5 :
    Complex.exp (Real.pi * Complex.I) = -1 ∧
      Complex.exp (-Real.pi * Complex.I) = -1
```
:::
::::

::::dlmfEntry "4.4.6" "https://dlmf.nist.gov/4.4.E6"
$$`\[e^{\mathord{\pm}\pi i/2}=\mathord{\pm}i.\]`

The quarter-turn values are the two imaginary units.

:::leanStatement "Exponential at the quarter-turns"
```anchor dlmf_4_4_6 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_6 :
    Complex.exp (Real.pi / 2 * Complex.I) = Complex.I ∧
      Complex.exp (-Real.pi / 2 * Complex.I) = -Complex.I
```
:::
::::

::::dlmfEntry "4.4.7" "https://dlmf.nist.gov/4.4.E7"
$$`\[e^{2\pi k i}=1,\qquad k\in\mathbb Z.\]`

Every integral number of full turns returns to one.

:::leanStatement "Exponential at integral full turns"
```anchor dlmf_4_4_7 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_7 (k : ℤ) : Complex.exp (2 * Real.pi * k * Complex.I) = 1
```
:::
::::

::::dlmfEntry "4.4.8" "https://dlmf.nist.gov/4.4.E8"
$$`\[e^{\mathord{\pm}\pi i/3}=\tfrac12\mathbin{\pm}\tfrac12\sqrt3 i.\]`

The sixth-turn values have real part `1/2` and imaginary part `±√3/2`.

:::leanStatement "Exponential at the sixth-turns"
```anchor dlmf_4_4_8 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_8 :
    Complex.exp (Real.pi / 3 * Complex.I) = 1 / 2 + Complex.I * (Real.sqrt 3 / 2) ∧
      Complex.exp (-Real.pi / 3 * Complex.I) = 1 / 2 - Complex.I * (Real.sqrt 3 / 2)
```
:::
::::

::::dlmfEntry "4.4.9" "https://dlmf.nist.gov/4.4.E9"
$$`\[e^{\mathord{\pm}2\pi i/3}=-\tfrac12\mathbin{\pm}\tfrac12\sqrt3 i.\]`

The third-turn values have real part `−1/2` and imaginary part `±√3/2`.

:::leanStatement "Exponential at the third-turns"
```anchor dlmf_4_4_9 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_9 :
    Complex.exp (2 * Real.pi / 3 * Complex.I) = -(1 / 2 : ℂ) + Complex.I * (Real.sqrt 3 / 2) ∧
      Complex.exp (-2 * Real.pi / 3 * Complex.I) = -(1 / 2 : ℂ) - Complex.I * (Real.sqrt 3 / 2)
```
:::
::::

::::dlmfEntry "4.4.10" "https://dlmf.nist.gov/4.4.E10"
$$`\[e^{\mathord{\pm}\pi i/4}=\tfrac1{\sqrt2}\mathbin{\pm}\tfrac1{\sqrt2}i.\]`

The eighth-turn values have equal real and imaginary magnitudes.

:::leanStatement "Exponential at the eighth-turns"
```anchor dlmf_4_4_10 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_10 :
    Complex.exp (Real.pi / 4 * Complex.I) = 1 / Real.sqrt 2 + Complex.I * (1 / Real.sqrt 2) ∧
      Complex.exp (-Real.pi / 4 * Complex.I) = 1 / Real.sqrt 2 - Complex.I * (1 / Real.sqrt 2)
```
:::
::::

::::dlmfEntry "4.4.11" "https://dlmf.nist.gov/4.4.E11"
$$`\[e^{\mathord{\pm}3\pi i/4}=-\tfrac1{\sqrt2}\mathbin{\pm}\tfrac1{\sqrt2}i.\]`

At three eighths of a turn, the real part is negative and the imaginary part
has sign matching the direction of rotation.

:::leanStatement "Exponential at three eighths of a turn"
```anchor dlmf_4_4_11 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_11 :
    Complex.exp (3 * Real.pi / 4 * Complex.I) = -(1 / Real.sqrt 2 : ℂ) + Complex.I * (1 / Real.sqrt 2) ∧
      Complex.exp (-3 * Real.pi / 4 * Complex.I) = -(1 / Real.sqrt 2 : ℂ) - Complex.I * (1 / Real.sqrt 2)
```
:::
::::

::::dlmfEntry "4.4.12" "https://dlmf.nist.gov/4.4.E12"
$$`\[i^{\mathord{\pm}i}=e^{\mp\pi/2}.\]`

Using the principal complex power, the two imaginary-unit bases give the
displayed real exponentials.

:::leanStatement "Imaginary powers of the imaginary unit"
```anchor dlmf_4_4_12 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_12 :
    Complex.I ^ Complex.I = Complex.exp (-(Real.pi : ℂ) / 2) ∧
      (-Complex.I) ^ Complex.I = Complex.exp ((Real.pi : ℂ) / 2)
```
:::
::::

# §4.4(iii) Limits
%%%
number := false
%%%

::::dlmfEntry "4.4.13" "https://dlmf.nist.gov/4.4.E13"
$$`\[\lim_{x\to\infty}x^{-a}\ln x=0,\qquad \Re a>0.\]`

For positive real `x`, every complex power with positive real exponent part
dominates the logarithm at infinity.

:::leanStatement "Logarithm divided by a positive power"
```anchor dlmf_4_4_13 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_13 {a : ℂ} (ha : 0 < a.re) :
    Tendsto (fun x : ℝ ↦ (x : ℂ) ^ (-a) * Complex.log x) atTop (𝓝 0)
```
:::
::::

::::dlmfEntry "4.4.14" "https://dlmf.nist.gov/4.4.E14"
$$`\[\lim_{x\to0^+}x^a\ln x=0,\qquad \Re a>0.\]`

At the positive endpoint, a positive-real-part power suppresses the logarithmic
singularity.

:::leanStatement "Power times logarithm at zero"
```anchor dlmf_4_4_14 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_14 {a : ℂ} (ha : 0 < a.re) :
    Tendsto (fun x : ℝ ↦ (x : ℂ) ^ a * Real.log x) (𝓝[>] 0) (𝓝 0)
```
:::
::::

::::dlmfEntry "4.4.15" "https://dlmf.nist.gov/4.4.E15"
$$`\[\lim_{x\to\infty}x^ae^{-x}=0.\]`

Exponential decay dominates every fixed complex power on the positive real
axis.

:::leanStatement "Exponential decay of a power"
```anchor dlmf_4_4_15 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_15 {a : ℂ} :
    Tendsto (fun x : ℝ ↦ (x : ℂ) ^ a * Complex.exp (-x)) atTop (𝓝 0)
```
:::
::::

::::dlmfEntry "4.4.16" "https://dlmf.nist.gov/4.4.E16"
$$`\[\lim_{z\to\infty}z^ae^{-z}=0,\qquad |\operatorname{ph}z|\le\tfrac12\pi-\delta.\]`

In a closed sector strictly inside the right half-plane, the exponential factor
dominates the complex power. The declaration fixes one admissible boundary ray,
which is an explicit sectorial specialization.

:::leanStatement "Sectorial exponential decay"
```anchor dlmf_4_4_16 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_16 {a : ℂ} {δ : ℝ} (hδ₀ : 0 < δ) (hδ₁ : δ ≤ Real.pi / 2) :
    Tendsto (fun r : ℝ ↦ ((r : ℂ) * Complex.exp (Complex.I * (Real.pi / 2 - δ))) ^ a *
      Complex.exp (-((r : ℂ) * Complex.exp (Complex.I * (Real.pi / 2 - δ)))))
      atTop (𝓝 0)
```
:::
::::

::::dlmfEntry "4.4.17" "https://dlmf.nist.gov/4.4.E17"
$$`\[\lim_{n\to\infty}\left(1+\frac zn\right)^n=e^z.\]`

For fixed complex `z`, the binomial sequence converges to the complex
exponential.

:::leanStatement "Complex exponential limit"
```anchor dlmf_4_4_17 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_17 (z : ℂ) :
    Tendsto (fun n : ℕ ↦ (1 + z / n) ^ n) atTop (𝓝 (Complex.exp z))
```
:::
::::

::::dlmfEntry "4.4.18" "https://dlmf.nist.gov/4.4.E18"
$$`\[\lim_{n\to\infty}\left(1+\frac1n\right)^n=e.\]`

The classical real sequence gives Euler's number.

:::leanStatement "Limit defining Euler's number"
```anchor dlmf_4_4_18 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_18 :
    Tendsto (fun n : ℕ ↦ (1 + (1 : ℝ) / n) ^ n) atTop (𝓝 (Real.exp 1))
```
:::
::::

::::dlmfEntry "4.4.19" "https://dlmf.nist.gov/4.4.E19"
$$`\[\lim_{n\to\infty}\left(\sum_{k=1}^n\frac1k-\ln n\right)=\gamma.\]`

The harmonic numbers minus the logarithm converge to the Euler–Mascheroni
constant.

:::leanStatement "Harmonic numbers and Euler's constant"
```anchor dlmf_4_4_19 (module := LMLF.Blueprint.Elementary.Section44)
theorem dlmf_4_4_19 :
    Tendsto (fun n : ℕ ↦ (∑ k ∈ Icc 1 n, (k : ℝ)⁻¹) - Real.log n)
      atTop (𝓝 Real.eulerMascheroniConstant)
```
:::
::::
