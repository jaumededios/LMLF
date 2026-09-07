import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section56
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open LMLFManual
open Verso.Code.External

set_option verso.exampleProject "."

#doc (Manual) "Gamma-Function Inequalities" =>
%%%
tag := "chapter-5-section-6"
%%%

:::dlmfChapter "https://dlmf.nist.gov/5.6"
Source: NIST Digital Library of Mathematical Functions, §5.6.
:::

# §5.6 Inequalities
%%%
number := false
%%%

## §5.6(i) Real Variables
%%%
number := false
%%%

Throughout this subsection, $`x>0`. Real powers in the declarations below use Mathlib's
real-power operation.

::::dlmfEntry "5.6.1" "https://dlmf.nist.gov/5.6.E1"
$$`1<(2\pi)^{-1/2}x^{1/2-x}e^x\Gamma(x)<e^{1/(12x)}.`

After division by the leading term in Stirling's formula, the Gamma function is strictly larger
than one and strictly smaller than the elementary exponential correction $`e^{1/(12x)}`.

:::leanStatement "Lean · LMLF.Blueprint.Gamma · two-sided normalized bound"
```anchor section56Context (module := LMLF.Blueprint.Gamma.Section56) -showProofStates
namespace LMLF.Blueprint.Gamma

open scoped Real
```

```anchor stirlingNormalizedBounds (module := LMLF.Blueprint.Gamma.Section56) -showProofStates
theorem stirlingNormalizedBounds {x : ℝ} (hx : 0 < x) :
    1 < (2 * Real.pi) ^ (-(1 : ℝ) / 2) *
          x ^ ((1 : ℝ) / 2 - x) * Real.exp x * Real.Gamma x ∧
      (2 * Real.pi) ^ (-(1 : ℝ) / 2) *
          x ^ ((1 : ℝ) / 2 - x) * Real.exp x * Real.Gamma x <
        Real.exp (1 / (12 * x))
```
:::
::::

::::dlmfEntry "5.6.2" "https://dlmf.nist.gov/5.6.E2"
$$`\frac1{\Gamma(x)}+\frac1{\Gamma(1/x)}\le 2.`

The reciprocal Gamma values at the positive reciprocal arguments $`x` and $`1/x` have sum at
most two.

:::leanStatement "Lean · LMLF.Blueprint.Gamma"
```anchor oneDivGamma_add_oneDivGamma_reciprocal_le_two (module := LMLF.Blueprint.Gamma.Section56) -showProofStates
theorem oneDivGamma_add_oneDivGamma_reciprocal_le_two {x : ℝ} (hx : 0 < x) :
    1 / Real.Gamma x + 1 / Real.Gamma (1 / x) ≤ 2
```
:::
::::

::::dlmfEntry "5.6.3" "https://dlmf.nist.gov/5.6.E3"
$$`\frac1{\Gamma(x)^2}+\frac1{\Gamma(1/x)^2}\le 2.`

The corresponding sum of squared reciprocal Gamma values is also at most two.

:::leanStatement "Lean · LMLF.Blueprint.Gamma"
```anchor oneDivGammaSq_add_oneDivGammaSq_reciprocal_le_two (module := LMLF.Blueprint.Gamma.Section56) -showProofStates
theorem oneDivGammaSq_add_oneDivGammaSq_reciprocal_le_two {x : ℝ} (hx : 0 < x) :
    1 / (Real.Gamma x) ^ 2 + 1 / (Real.Gamma (1 / x)) ^ 2 ≤ 2
```
:::
::::

### Gautschi's Inequality
%%%
number := false
%%%

::::dlmfEntry "5.6.4" "https://dlmf.nist.gov/5.6.E4"
For $`0<s<1`,
$$`x^{1-s}<\frac{\Gamma(x+1)}{\Gamma(x+s)}<(x+1)^{1-s}.`

Gautschi's inequality places the Gamma quotient strictly between the same positive real power at
two consecutive arguments. Both the subsection assumption $`x>0` and the local restriction
$`0<s<1` are explicit in the declaration.

:::leanStatement "Lean · LMLF.Blueprint.Gamma · Gautschi's inequality"
```anchor gautschiInequality (module := LMLF.Blueprint.Gamma.Section56) -showProofStates
theorem gautschiInequality {x s : ℝ} (hx : 0 < x) (hs0 : 0 < s) (hs1 : s < 1) :
    x ^ (1 - s) < Real.Gamma (x + 1) / Real.Gamma (x + s) ∧
      Real.Gamma (x + 1) / Real.Gamma (x + s) < (x + 1) ^ (1 - s)
```
:::
::::

### Kershaw's Inequality
%%%
number := false
%%%

::::dlmfEntry "5.6.5" "https://dlmf.nist.gov/5.6.E5"
For $`0<s<1`,
$$`\exp\!\left((1-s)\psi(x+\sqrt{s})\right)
\le \frac{\Gamma(x+1)}{\Gamma(x+s)}
\le \exp\!\left((1-s)\psi\!\left(x+\frac{s+1}{2}\right)\right).`

Kershaw's inequality gives two non-strict exponential bounds for the Gamma quotient. Mathlib has
a canonical complex digamma function but no separate real-valued name, so `realDigamma` restricts
that function to the real axis by taking its real part. Every digamma argument here is positive.

:::leanStatement "Lean · LMLF.Blueprint.Gamma · real digamma and Kershaw's inequality"
```anchor realDigamma (module := LMLF.Blueprint.Gamma.Section56) -showProofStates
noncomputable def realDigamma (x : ℝ) : ℝ :=
  (Complex.digamma (x : ℂ)).re
```

```anchor kershawInequality (module := LMLF.Blueprint.Gamma.Section56) -showProofStates
theorem kershawInequality {x s : ℝ} (hx : 0 < x) (hs0 : 0 < s) (hs1 : s < 1) :
    Real.exp ((1 - s) * realDigamma (x + Real.sqrt s)) ≤
        Real.Gamma (x + 1) / Real.Gamma (x + s) ∧
      Real.Gamma (x + 1) / Real.Gamma (x + s) ≤
        Real.exp ((1 - s) * realDigamma (x + (s + 1) / 2))
```
:::
::::

## §5.6(ii) Complex Variables
%%%
number := false
%%%

For real $`x,y`, write $`x+iy` for the corresponding complex number. Complex absolute values are
represented by the norm in Lean.

::::dlmfEntry "5.6.6" "https://dlmf.nist.gov/5.6.E6"
$$`|\Gamma(x+iy)|\le |\Gamma(x)|.`

The Gamma modulus cannot increase when a finite real argument is moved vertically in the complex
plane. DLMF's usual Gamma function is singular at the nonpositive integers; Mathlib instead assigns
zero there. The explicit hypothesis $`x\ne-n` for every nonnegative integer $`n` therefore records
the classical domain of the right-hand side and prevents the totalized value from changing the
statement.

:::leanStatement "Lean · LMLF.Blueprint.Gamma · vertical upper bound"
```anchor norm_Gamma_vertical_le (module := LMLF.Blueprint.Gamma.Section56) -showProofStates
theorem norm_Gamma_vertical_le {x y : ℝ} (hx : ∀ n : ℕ, x ≠ -(n : ℝ)) :
    ‖Complex.Gamma ((x : ℂ) + y * Complex.I)‖ ≤ |Real.Gamma x|
```
:::
::::

::::dlmfEntry "5.6.7" "https://dlmf.nist.gov/5.6.E7"
For $`x\ge\tfrac12`,
$$`|\Gamma(x+iy)|\ge \operatorname{sech}(\pi y)^{1/2}\Gamma(x).`

On and to the right of the vertical line $`x=1/2`, the Gamma modulus is bounded below by its real
value multiplied by the square root of the hyperbolic secant. Since Mathlib has no named real
hyperbolic secant, the declaration writes the factor as `Real.sqrt ((Real.cosh (Real.pi * y))⁻¹)`,
i.e. the square root of $`\operatorname{sech}(\pi y)`.

:::leanStatement "Lean · LMLF.Blueprint.Gamma · vertical lower bound"
```anchor norm_Gamma_vertical_lowerBound (module := LMLF.Blueprint.Gamma.Section56) -showProofStates
theorem norm_Gamma_vertical_lowerBound {x y : ℝ} (hx : (1 : ℝ) / 2 ≤ x) :
    Real.sqrt ((Real.cosh (Real.pi * y))⁻¹) * Real.Gamma x ≤
      ‖Complex.Gamma ((x : ℂ) + y * Complex.I)‖
```
:::
::::

::::dlmfEntry "5.6.8" "https://dlmf.nist.gov/5.6.E8"
For $`b-a\ge1`, $`a\ge0`, and $`z=x+iy` with $`x>0`,
$$`\left|\frac{\Gamma(z+a)}{\Gamma(z+b)}\right|\le\frac1{|z|^{b-a}}.`

Here $`a,b` are real and $`z` is complex. The declaration replaces the coordinates by the
coordinate-free condition $`\Re z>0`; this is exactly the source condition $`x>0` for
$`z=x+iy`.

:::leanStatement "Lean · LMLF.Blueprint.Gamma · quotient bound"
```anchor norm_Gamma_div_Gamma_le (module := LMLF.Blueprint.Gamma.Section56) -showProofStates
theorem norm_Gamma_div_Gamma_le {z : ℂ} {a b : ℝ} (hz : 0 < z.re)
    (ha : 0 ≤ a) (hab : 1 ≤ b - a) :
    ‖Complex.Gamma (z + (a : ℂ)) / Complex.Gamma (z + (b : ℂ))‖ ≤
      1 / ‖z‖ ^ (b - a)
```
:::
::::

::::dlmfEntry "5.6.9" "https://dlmf.nist.gov/5.6.E9"
For $`z=x+iy` with $`x\ge0`,
$$`|\Gamma(z)|\le (2\pi)^{1/2}|z|^{x-1/2}e^{-\pi|y|/2}
\exp\!\left(\frac16|z|^{-1}\right).`

This explicit bound holds on the closed right half-plane. The declaration writes $`x` and $`y` as
the real and imaginary parts of $`z`, and makes $`z\ne0` explicit because the source Gamma function
has a pole there whereas Mathlib's totalized Gamma value is zero.

:::leanStatement "Lean · LMLF.Blueprint.Gamma · right-half-plane bound"
```anchor norm_Gamma_rightHalfPlane_le (module := LMLF.Blueprint.Gamma.Section56) -showProofStates
theorem norm_Gamma_rightHalfPlane_le {z : ℂ} (hz : 0 ≤ z.re) (hz0 : z ≠ 0) :
    ‖Complex.Gamma z‖ ≤
      (2 * Real.pi) ^ ((1 : ℝ) / 2) *
        ‖z‖ ^ (z.re - (1 : ℝ) / 2) *
        Real.exp (-Real.pi * |z.im| / 2) *
        Real.exp ((1 : ℝ) / 6 * ‖z‖⁻¹)
```
:::
::::
