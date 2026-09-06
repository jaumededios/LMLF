import VersoManual
import Verso.Code.External
import LMLF.Definitions.Gamma
import LMLF.Blueprint.Gamma
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open LMLFManual
open Verso.Code.External

set_option verso.exampleProject "."

#doc (Manual) "Gamma Function" =>
%%%
tag := "chapter-5"
%%%

:::dlmfChapter "https://dlmf.nist.gov/5"
Source: NIST Digital Library of Mathematical Functions, Chapter 5.
:::

# Chapter contents
%%%
number := false
%%%

## Notation and properties
%%%
number := false
%%%

:::sectionIndex
* [5.1 Special Notation](https://dlmf.nist.gov/5.1)
* [5.2 Definitions](https://dlmf.nist.gov/5.2)
* [5.3 Graphics](https://dlmf.nist.gov/5.3)
* [5.4 Special Values and Extrema](https://dlmf.nist.gov/5.4)
* [5.5 Functional Relations](https://dlmf.nist.gov/5.5)
* [5.6 Inequalities](https://dlmf.nist.gov/5.6)
* [5.7 Series Expansions](https://dlmf.nist.gov/5.7)
* [5.8 Infinite Products](https://dlmf.nist.gov/5.8)
* [5.9 Integral Representations](https://dlmf.nist.gov/5.9)
* [5.10 Continued Fractions](https://dlmf.nist.gov/5.10)
* [5.11 Asymptotic Expansions](https://dlmf.nist.gov/5.11)
* [5.12 Beta Function](https://dlmf.nist.gov/5.12)
* [5.13 Integrals](https://dlmf.nist.gov/5.13)
* [5.14 Multidimensional Integrals](https://dlmf.nist.gov/5.14)
* [5.15 Polygamma Functions](https://dlmf.nist.gov/5.15)
* [5.16 Sums](https://dlmf.nist.gov/5.16)
* [5.17 Barnes' G-Function (Double Gamma Function)](https://dlmf.nist.gov/5.17)
* [5.18 q-Gamma and q-Beta Functions](https://dlmf.nist.gov/5.18)
:::

## Applications and computation
%%%
number := false
%%%

:::sectionIndex
* [5.19 Mathematical Applications](https://dlmf.nist.gov/5.19)
* [5.20 Physical Applications](https://dlmf.nist.gov/5.20)
* [5.21 Methods of Computation](https://dlmf.nist.gov/5.21)
* [5.22 Tables](https://dlmf.nist.gov/5.22)
* [5.23 Approximations](https://dlmf.nist.gov/5.23)
* [5.24 Software](https://dlmf.nist.gov/5.24)
:::

# §5.2 Definitions
%%%
number := false
%%%

## §5.2(i) Gamma and Psi Functions
%%%
number := false
%%%

::::dlmfEntry "5.2.1" "https://dlmf.nist.gov/5.2.E1"
$$`\Gamma(z)=\int_0^\infty e^{-t}t^{z-1}\,dt,\qquad \Re z>0.`

For a complex number with positive real part, the Gamma function is Euler's integral on the positive
real axis. The first declaration verifies convergence of that integral; the second states its value.

:::leanStatement "Lean · LMLF.Definitions"
```anchor gammaContext (module := LMLF.Definitions.Gamma) -showProofStates
namespace LMLF.Definitions
```

```anchor gamma_eulerIntegrable (module := LMLF.Definitions.Gamma) -showProofStates
theorem gamma_eulerIntegrable {s : ℂ} (hs : 0 < s.re) :
    MeasureTheory.IntegrableOn
      (fun t : ℝ ↦ (Real.exp (-t) : ℂ) * (t : ℂ) ^ (s - 1))
      (Set.Ioi 0)
```

```anchor gamma_eq_eulerIntegral (module := LMLF.Definitions.Gamma) -showProofStates
theorem gamma_eq_eulerIntegral {s : ℂ} (hs : 0 < s.re) :
    Complex.Gamma s =
      ∫ t in Set.Ioi (0 : ℝ), (Real.exp (-t) : ℂ) * (t : ℂ) ^ (s - 1)
```
:::
::::

# §5.11 Asymptotic Expansions
%%%
number := false
%%%

## §5.11(i) Poincaré-Type Expansions
%%%
number := false
%%%

::::dlmfEntry "5.11.1" "https://dlmf.nist.gov/5.11.E1"
As $`z\to\infty` in $`|\operatorname{ph}z|\le\pi-\delta`,
$$`\operatorname{Ln}\Gamma(z)\sim
\left(z-\frac12\right)\ln z-z+\frac12\ln(2\pi)
+\sum_{k=1}^{\infty}\frac{B_{2k}}{2k(2k-1)z^{2k-1}}.`

For positive real `x`, the Lean specialization uses the same Bernoulli terms. After any finite
truncation, the remaining error is little-o of the last retained term as `x` tends to infinity.

:::leanStatement "Lean · LMLF.Blueprint.Gamma · real-positive specialization"
```anchor stirlingContext (module := LMLF.Blueprint.Gamma) -showProofStates
namespace LMLF.Blueprint.Gamma

open Filter
```

```anchor stirlingLogMain (module := LMLF.Blueprint.Gamma) -showProofStates
noncomputable def stirlingLogMain (x : ℝ) : ℝ :=
  (x - 1 / 2) * Real.log x - x + Real.log (2 * Real.pi) / 2
```

```anchor stirlingLogTerm (module := LMLF.Blueprint.Gamma) -showProofStates
noncomputable def stirlingLogTerm (k : ℕ) (x : ℝ) : ℝ :=
  (bernoulli (2 * k + 2) : ℝ) /
    ((2 * k + 2 : ℕ) * (2 * k + 1 : ℕ) * x ^ (2 * k + 1))
```

```anchor stirlingLog_hasPoincareExpansion (module := LMLF.Blueprint.Gamma) -showProofStates
theorem stirlingLog_hasPoincareExpansion :
    (fun x : ℝ ↦ Real.log (Real.Gamma x) - stirlingLogMain x) ∼ₚ[atTop]
      stirlingLogTerm
```
:::

The distinct finite theorem says that the remainder has the sign of the first omitted term and no
greater magnitude.

:::leanStatement "Quantitative Lean · LMLF.Blueprint.Gamma · first-neglected-term bound"
```anchor stirlingLogApprox (module := LMLF.Blueprint.Gamma) -showProofStates
noncomputable def stirlingLogApprox (n : ℕ) (x : ℝ) : ℝ :=
  stirlingLogMain x + QuantitativeAnalysis.seriesPartialSum stirlingLogTerm n x
```

```anchor stirlingLog_remainder_bounds (module := LMLF.Blueprint.Gamma) -showProofStates
theorem stirlingLog_remainder_bounds (n : ℕ) {x : ℝ} (hx : 0 < x) :
    0 ≤
        (Real.log (Real.Gamma x) - stirlingLogApprox n x) *
          stirlingLogTerm n x ∧
      |Real.log (Real.Gamma x) - stirlingLogApprox n x| ≤
        |stirlingLogTerm n x|
```
:::
::::
