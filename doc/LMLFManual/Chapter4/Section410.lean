import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section410
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual
open Filter Set MeasureTheory

set_option verso.exampleProject "."

#doc (Manual) "§4.10 Integrals" =>
%%%
tag := "chapter-4-section-10"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.10"
Source: NIST Digital Library of Mathematical Functions, §4.10.
:::

This section collects antiderivatives and definite integrals for logarithms and
exponentials. Complex antiderivatives use the principal logarithm on an explicit
branch domain; definite integrals use the indicated real intervals and measures.

# §4.10(i) Logarithms
%%%
number := false
%%%

::::dlmfEntry "4.10.1" "https://dlmf.nist.gov/4.10.E1"
$$`\[\int\frac{dz}{z}=\ln z.\]`

On a region avoiding zero and the principal branch cut, the derivative of the
principal logarithm is `1/z`.

:::leanStatement "Principal logarithm antiderivative"
```anchor dlmf_4_10_1 (module := LMLF.Blueprint.Elementary.Section410)
theorem dlmf_4_10_1 {z : ℂ}
    (hz : z ≠ 0) (hbranch : z.im ≠ 0 ∨ 0 < z.re) :
    HasDerivAt Complex.log (1 / z) z
```
:::
::::

::::dlmfEntry "4.10.2" "https://dlmf.nist.gov/4.10.E2"
$$`\[\int\ln z\,dz=z\ln z-z.\]`

Differentiating `z ln z − z` gives the principal logarithm on the same branch
domain.

:::leanStatement "Logarithm antiderivative"
```anchor dlmf_4_10_2 (module := LMLF.Blueprint.Elementary.Section410)
theorem dlmf_4_10_2 {z : ℂ}
    (hbranch : z ≠ 0 ∧ (z.im ≠ 0 ∨ 0 < z.re)) :
    HasDerivAt (fun w : ℂ ↦ w * Complex.log w - w) (Complex.log z) z
```
:::
::::

::::dlmfEntry "4.10.3" "https://dlmf.nist.gov/4.10.E3"
$$`\[\int z^n\ln z\,dz=\frac{z^{n+1}}{n+1}\ln z-\frac{z^{n+1}}{(n+1)^2},\qquad n\ne-1.\]`

For an integer exponent other than `−1`, integration by parts yields the
displayed logarithmic power antiderivative on a chosen principal branch.

:::leanStatement "Logarithmic power antiderivative"
```anchor dlmf_4_10_3 (module := LMLF.Blueprint.Elementary.Section410)
theorem dlmf_4_10_3 (n : ℤ) (hn : n ≠ -1) {z : ℂ}
    (hbranch : z ≠ 0 ∧ (z.im ≠ 0 ∨ 0 < z.re)) :
    HasDerivAt
      (fun w : ℂ ↦ w ^ (n + 1) / (n + 1) * Complex.log w -
        w ^ (n + 1) / (n + 1) ^ 2)
      (z ^ n * Complex.log z) z
```
:::
::::

::::dlmfEntry "4.10.4" "https://dlmf.nist.gov/4.10.E4"
$$`\[\int\frac{dz}{z\ln z}=\ln(\ln z).\]`

Where both `z` and its principal logarithm are nonzero, the iterated logarithm
has derivative `1/(z ln z)` on the selected branch.

:::leanStatement "Iterated logarithm antiderivative"
```anchor dlmf_4_10_4 (module := LMLF.Blueprint.Elementary.Section410)
theorem dlmf_4_10_4 {z : ℂ}
    (hz : z ≠ 0) (hlog : Complex.log z ≠ 0)
    (hbranch : z.im ≠ 0 ∨ 0 < z.re) :
    HasDerivAt (fun w : ℂ ↦ Complex.log (Complex.log w))
      (1 / (z * Complex.log z)) z
```
:::
::::

::::dlmfEntry "4.10.5" "https://dlmf.nist.gov/4.10.E5"
$$`\[\int_0^1\frac{\ln t}{1-t}\,dt=-\frac{\pi^2}{6}.\]`

The improper endpoint integral over `(0,1)` has the stated negative zeta-value.

:::leanStatement "Logarithmic integral with one minus t"
```anchor dlmf_4_10_5 (module := LMLF.Blueprint.Elementary.Section410)
theorem dlmf_4_10_5 :
    (∫ t in Ioc (0 : ℝ) 1, Real.log t / (1 - t)) = -(Real.pi : ℝ) ^ 2 / 6
```
:::
::::

::::dlmfEntry "4.10.6" "https://dlmf.nist.gov/4.10.E6"
$$`\[\int_0^1\frac{\ln t}{1+t}\,dt=-\frac{\pi^2}{12}.\]`

The corresponding improper integral with denominator `1+t` equals
`−π²/12`.

:::leanStatement "Logarithmic integral with one plus t"
```anchor dlmf_4_10_6 (module := LMLF.Blueprint.Elementary.Section410)
theorem dlmf_4_10_6 :
    (∫ t in Ioc (0 : ℝ) 1, Real.log t / (1 + t)) = -(Real.pi : ℝ) ^ 2 / 12
```
:::
::::

::::dlmfEntry "4.10.7" "https://dlmf.nist.gov/4.10.E7"
$$`\[\dashint_0^x\frac{dt}{\ln t}=\operatorname{li}(x),\qquad x>1.\]`

For `x>1`, the logarithmic integral is interpreted as a Cauchy principal value
at the interior singularity `t=1`; the local vocabulary records that symmetric
cutoff interpretation.

:::leanStatement "Cauchy-principal-value logarithmic integral"
```anchor dlmf_4_10_7 (module := LMLF.Blueprint.Elementary.Section410)
theorem dlmf_4_10_7 {x : ℝ} (hx : 1 < x) :
    Tendsto (fun ε ↦
      (∫ t in Ioc 0 (1 - ε), 1 / Real.log t) +
        (∫ t in Ioc (1 + ε) x, 1 / Real.log t))
      (nhdsWithin (0 : ℝ) (Ioi 0)) (nhds (logarithmicIntegral x))
```
:::
::::

# §4.10(ii) Exponentials
%%%
number := false
%%%

::::dlmfEntry "4.10.8" "https://dlmf.nist.gov/4.10.E8"
$$`\[\int e^{az}\,dz=\frac{e^{az}}a,\qquad a\ne0.\]`

For nonzero complex `a`, the displayed quotient is an antiderivative.

:::leanStatement "Exponential antiderivative"
```anchor dlmf_4_10_8 (module := LMLF.Blueprint.Elementary.Section410)
theorem dlmf_4_10_8 {a z : ℂ} (ha : a ≠ 0) :
    HasDerivAt (fun w : ℂ ↦ Complex.exp (a * w) / a) (Complex.exp (a * z)) z
```
:::
::::

::::dlmfEntry "4.10.9" "https://dlmf.nist.gov/4.10.E9"
$$`\[\int\frac{dz}{e^{az}+b}=\frac{az-\ln(e^{az}+b)}{ab},\qquad a,b\ne0.\]`

Away from zero and the nonpositive-real branch cut of the logarithm argument,
the principal-logarithm expression is an antiderivative for nonzero complex
`a` and `b`.

:::leanStatement "Reciprocal affine exponential antiderivative"
```anchor dlmf_4_10_9 (module := LMLF.Blueprint.Elementary.Section410)
theorem dlmf_4_10_9 {a b z : ℂ} (ha : a ≠ 0) (hb : b ≠ 0)
    (hz : Complex.exp (a * z) + b ≠ 0)
    (hbranch : (Complex.exp (a * z) + b).im ≠ 0 ∨
      0 < (Complex.exp (a * z) + b).re) :
    HasDerivAt
      (fun w : ℂ ↦ (a * w - Complex.log (Complex.exp (a * w) + b)) / (a * b))
      (1 / (Complex.exp (a * z) + b)) z
```
:::
::::

::::dlmfEntry "4.10.10" "https://dlmf.nist.gov/4.10.E10"
$$`\[\int\frac{e^{az}-1}{e^{az}+1}\,dz=\frac2a\ln(e^{az/2}+e^{-az/2}),\qquad a\ne0.\]`

On a branch avoiding zero and the nonpositive-real cut of the logarithm
argument, the principal-logarithm expression differentiates to the displayed
quotient.

:::leanStatement "Hyperbolic exponential antiderivative"
```anchor dlmf_4_10_10 (module := LMLF.Blueprint.Elementary.Section410)
theorem dlmf_4_10_10 {a z : ℂ} (ha : a ≠ 0)
    (hz : Complex.exp (a * z) + Complex.exp (-a * z) ≠ 0)
    (hlog : Complex.exp (a * z / 2) + Complex.exp (-a * z / 2) ≠ 0)
    (hbranch : (Complex.exp (a * z / 2) + Complex.exp (-a * z / 2)).im ≠ 0 ∨
      0 < (Complex.exp (a * z / 2) + Complex.exp (-a * z / 2)).re) :
    HasDerivAt
      (fun w : ℂ ↦ 2 / a * Complex.log (Complex.exp (a * w / 2) +
        Complex.exp (-a * w / 2)))
      ((Complex.exp (a * z) - 1) / (Complex.exp (a * z) + 1)) z
```
:::
::::

::::dlmfEntry "4.10.11" "https://dlmf.nist.gov/4.10.E11"
$$`\[\int_{-\infty}^{\infty}e^{-cx^2}\,dx=\sqrt{\frac\pi c},\qquad \Re c>0.\]`

The Gaussian integral converges for complex `c` with positive real part; the
principal complex square root gives the value.

:::leanStatement "Complex Gaussian integral"
```anchor dlmf_4_10_11 (module := LMLF.Blueprint.Elementary.Section410)
theorem dlmf_4_10_11 {c : ℂ} (hc : 0 < c.re) :
    (∫ x : ℝ, Complex.exp (-c * (x : ℂ) ^ 2)) =
      (Real.pi / c) ^ (1 / 2 : ℂ)
```
:::
::::

::::dlmfEntry "4.10.12" "https://dlmf.nist.gov/4.10.E12"
$$`\[\int_0^{\ln2}\frac{x e^x}{e^x-1}\,dx=\frac{\pi^2}{12}.\]`

The finite integral up to `ln 2` has value `π²/12`; its endpoint behavior is
understood through the improper integral represented by the interval integral.

:::leanStatement "Finite exponential Bose integral"
```anchor dlmf_4_10_12 (module := LMLF.Blueprint.Elementary.Section410)
theorem dlmf_4_10_12 :
    (∫ x in Ioc (0 : ℝ) (Real.log 2),
      x * Real.exp x / (Real.exp x - 1)) = Real.pi ^ 2 / 12
```
:::
::::

::::dlmfEntry "4.10.13" "https://dlmf.nist.gov/4.10.E13"
$$`\[\int_0^\infty\frac{dx}{e^x+1}=\ln2.\]`

The improper integral over the positive half-line equals `ln 2`.

:::leanStatement "Fermi integral"
```anchor dlmf_4_10_13 (module := LMLF.Blueprint.Elementary.Section410)
theorem dlmf_4_10_13 :
    (∫ x in Ioi (0 : ℝ), 1 / (Real.exp x + 1)) = Real.log 2
```
:::
::::
