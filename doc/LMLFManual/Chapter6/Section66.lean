import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section66
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section66
open LMLF.Blueprint.ExponentialIntegrals.Section62
set_option verso.exampleProject "."

#doc (Manual) "§6.6 Power Series" =>
%%%
tag := "chapter-6-section-6"
%%%

:::dlmfChapter "https://dlmf.nist.gov/6.6"
Source: NIST Digital Library of Mathematical Functions, §6.6, Power Series.
:::

# §6.6 Power Series
%%%
number := false
%%%

This section collects power series for the exponential, complementary
exponential, sine, and cosine integrals. The principal logarithm is used in the
complex formulas. Lean writes the positive-indexed sums in E1, E2, E4, and E6
with zero-based `n + 1` reindexes, while preserving the same coefficients and
convergence domains. The complex series in E2–E6 are stated for finite `z`;
E1 is the positive-real formula `x>0`. The disclosures use the principal
value specifications from §6.2 for `E₁`, `Ei`, `Ein`, `Si`, and `Ci`, rather
than defining those functions by the series they characterize.

The source notes [Olver (1997b), pp. 40–43](https://dlmf.nist.gov/6.6#info)
and records that E3 follows from [§6.11.2](https://dlmf.nist.gov/6.11.E2) and
[§13.2.9](https://dlmf.nist.gov/13.2.E9). These are provenance notes rather
than additional numbered formulas.

::::dlmfEntry "6.6.1" "https://dlmf.nist.gov/6.6.E1"
$$`\operatorname{Ei}(x)=\gamma+\ln x+\sum_{n=1}^{\infty}\frac{x^{n}}{n!\,n},\qquad x>0`$$

For positive real `x`, E1 expands the canonical §6.2 value `realEi x` using
Euler's constant `γ`, the real logarithm, and the factorial-weighted
coefficients. It uses `n+1` as the summation index.

:::leanStatement "Ei power series"
```anchor dlmf_6_6_1 (module := LMLF.Blueprint.ExponentialIntegrals.Section66)
/-- DLMF 6.6.E1: `Ei(x)` power series for `x > 0`. -/
theorem dlmf_6_6_1 (x : ℝ) (hx : 0 < x) :
    realEi x = (Real.eulerMascheroniConstant : ℂ) + Real.log x +
      ∑' n : ℕ, x ^ (n + 1) / (Nat.factorial (n + 1) * (n + 1)) :=
```
:::
::::

::::dlmfEntry "6.6.2" "https://dlmf.nist.gov/6.6.E2"
$$`E_{1}(z)=-\gamma-\ln z-\sum_{n=1}^{\infty}\frac{(-1)^{n}z^{n}}{n!\,n}`$$

E2 is the principal-branch complex expansion of the canonical §6.2 map
`principalE1`; `ln` is the principal logarithm. The Lean statement assumes
the open principal-cut domain `principalCutDomain z` and uses the equivalent
zero-based index shift. Since `(-1)^(n+1)` is the reindexed source sign, the
first term has the required negative sign.

:::leanStatement "E1 power series"
```anchor dlmf_6_6_2 (module := LMLF.Blueprint.ExponentialIntegrals.Section66)
/-- DLMF 6.6.E2: principal `E₁(z)` power series. -/
theorem dlmf_6_6_2 (z : ℂ) (hz : principalCutDomain z) :
    principalE1 z = -(Real.eulerMascheroniConstant : ℂ) - Complex.log z -
      ∑' n : ℕ, ((-1 : ℂ) ^ (n + 1) * z ^ (n + 1)) /
        ((Nat.factorial (n + 1) : ℂ) * (n + 1)) :=
```
:::
::::

::::dlmfEntry "6.6.3" "https://dlmf.nist.gov/6.6.E3"
$$`E_{1}(z)=-\ln z+e^{-z}\sum_{n=0}^{\infty}\frac{z^{n}}{n!}\,\psi(n+1)`$$

E3 is an alternative expansion of the same canonical principal `principalE1`,
now weighted by the digamma function `ψ`, the logarithmic derivative of the
gamma function. The theorem uses the open principal-cut domain. The source
cross-references §6.11.2 and §13.2.9 for this representation.

:::leanStatement "Digamma-weighted E1 series"
```anchor dlmf_6_6_3 (module := LMLF.Blueprint.ExponentialIntegrals.Section66)
/-- DLMF 6.6.E3: digamma-weighted `E₁(z)` power series. -/
theorem dlmf_6_6_3 (z : ℂ) (hz : principalCutDomain z) :
    principalE1 z = -Complex.log z + Complex.exp (-z) *
      ∑' n : ℕ, z ^ n / (Nat.factorial n : ℂ) * Complex.digamma (n + 1) :=
```
:::
::::

::::dlmfEntry "6.6.4" "https://dlmf.nist.gov/6.6.E4"
$$`\operatorname{Ein}(z)=\sum_{n=1}^{\infty}\frac{(-1)^{n-1}z^{n}}{n!\,n}`$$

E4 gives the entire complementary exponential integral. Unlike E2 and E3,
there is no logarithmic term, so the power series is regular at the origin.
The Lean left-hand side is §6.2's removable-integrand definition
`principalEin`.

:::leanStatement "Ein power series"
```anchor dlmf_6_6_4 (module := LMLF.Blueprint.ExponentialIntegrals.Section66)
/-- DLMF 6.6.E4: complementary exponential-integral power series. -/
theorem dlmf_6_6_4 (z : ℂ) :
    principalEin z = ∑' n : ℕ, ((-1 : ℂ) ^ n * z ^ (n + 1)) /
      ((Nat.factorial (n + 1) : ℂ) * (n + 1)) :=
```
:::
::::

::::dlmfEntry "6.6.5" "https://dlmf.nist.gov/6.6.E5"
$$`\operatorname{Si}(z)=\sum_{n=0}^{\infty}\frac{(-1)^{n}z^{2n+1}}{(2n+1)!(2n+1)}`$$

E5 is the odd power series for the sine integral. Its indexing exposes the
odd powers and the corresponding odd factorial and denominator. The Lean
left-hand side is §6.2's entire `principalSi` path integral.

:::leanStatement "Sine-integral power series"
```anchor dlmf_6_6_5 (module := LMLF.Blueprint.ExponentialIntegrals.Section66)
/-- DLMF 6.6.E5: sine-integral power series. -/
theorem dlmf_6_6_5 (z : ℂ) :
    principalSi z = ∑' n : ℕ, (-1 : ℂ) ^ n * z ^ (2 * n + 1) /
      ((Nat.factorial (2 * n + 1) : ℂ) * (2 * n + 1)) :=
```
:::
::::

::::dlmfEntry "6.6.6" "https://dlmf.nist.gov/6.6.E6"
$$`\operatorname{Ci}(z)=\gamma+\ln z+\sum_{n=1}^{\infty}\frac{(-1)^{n}z^{2n}}{(2n)!(2n)}`$$

E6 is the corresponding cosine-integral expansion for the canonical §6.2 map
`principalCi`. It has the principal logarithm and Euler constant together
with an even power series beginning at the first positive even index; the
origin is therefore a logarithmic singularity. The hypothesis
`principalCutDomain z` keeps the principal branch away from the cut.

:::leanStatement "Cosine-integral power series"
```anchor dlmf_6_6_6 (module := LMLF.Blueprint.ExponentialIntegrals.Section66)
/-- DLMF 6.6.E6: cosine-integral power series. -/
theorem dlmf_6_6_6 (z : ℂ) (hz : principalCutDomain z) :
    principalCi z = (Real.eulerMascheroniConstant : ℂ) + Complex.log z +
      ∑' n : ℕ, (-1 : ℂ) ^ (n + 1) * z ^ (2 * (n + 1)) /
        ((Nat.factorial (2 * (n + 1)) : ℂ) * (2 * (n + 1))) :=
```
:::
::::

::::dlmfEntry "§6.6 convergence of the six series" "https://dlmf.nist.gov/6.6#p1"
The source states that all six displayed series converge for every finite real
`x` and complex `z` in their stated series variables.  Lean exposes these as
six independent `Summable` facts, so each convergence result can be reused
without an irrelevant argument for another series.

:::leanStatement "E1 series convergence"
```anchor eiSeriesTerm_summable (module := LMLF.Blueprint.ExponentialIntegrals.Section66)
/-- DLMF 6.6 prose: the E1 series is summable for every finite real argument. -/
theorem eiSeriesTerm_summable (x : ℝ) :
    Summable (eiSeriesTerm x) :=
```
:::

:::leanStatement "E2 series convergence"
```anchor e1SeriesTerm_summable (module := LMLF.Blueprint.ExponentialIntegrals.Section66)
/-- DLMF 6.6 prose: the E2 series is summable for every finite complex argument. -/
theorem e1SeriesTerm_summable (z : ℂ) :
    Summable (e1SeriesTerm z) :=
```
:::

:::leanStatement "E3 series convergence"
```anchor e1DigammaSeriesTerm_summable (module := LMLF.Blueprint.ExponentialIntegrals.Section66)
/-- DLMF 6.6 prose: the E3 digamma series is summable for every finite complex argument. -/
theorem e1DigammaSeriesTerm_summable (z : ℂ) :
    Summable (e1DigammaSeriesTerm z) :=
```
:::

:::leanStatement "E4 series convergence"
```anchor einSeriesTerm_summable (module := LMLF.Blueprint.ExponentialIntegrals.Section66)
/-- DLMF 6.6 prose: the E4 series is summable for every finite complex argument. -/
theorem einSeriesTerm_summable (z : ℂ) :
    Summable (einSeriesTerm z) :=
```
:::

:::leanStatement "E5 series convergence"
```anchor siSeriesTerm_summable (module := LMLF.Blueprint.ExponentialIntegrals.Section66)
/-- DLMF 6.6 prose: the E5 series is summable for every finite complex argument. -/
theorem siSeriesTerm_summable (z : ℂ) :
    Summable (siSeriesTerm z) :=
```
:::

:::leanStatement "E6 series convergence"
```anchor ciSeriesTerm_summable (module := LMLF.Blueprint.ExponentialIntegrals.Section66)
/-- DLMF 6.6 prose: the E6 series is summable for every finite complex argument. -/
theorem ciSeriesTerm_summable (z : ℂ) :
    Summable (ciSeriesTerm z) :=
```
:::
::::
