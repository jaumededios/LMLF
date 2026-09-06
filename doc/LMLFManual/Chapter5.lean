import VersoManual
import LMLF.Definitions.Gamma
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open LMLFManual

#doc (Manual) "Gamma Function" =>
%%%
tag := "chapter-5"
%%%

:::chapterStatus "https://dlmf.nist.gov/5" "partial · four accepted declarations"
LMLF currently identifies the pinned Mathlib Gamma object on its Euler half-plane, records real
agreement, and exposes Mathlib's totalization convention. It does not yet implement the chapter's
series, asymptotic expansions, inequalities, polygamma, Barnes, or q-Gamma families.
:::

# 5.2 Definitions and 5.9 Integral representations

::::result "Euler integral identification" "implemented · DEF-001"
*Qualitative view.*

For complex `s` with positive real part, the selected Gamma function is Euler's integral on the
positive real axis. The integrability assertion is separate from the value identity.

*Quantitative view.*

This is an exact identification, not an approximation; there is no error majorant to display.

:::leanStatement "Expand the checked Lean declarations"
```lean
#check LMLF.Definitions.gamma_eulerIntegrable
#check LMLF.Definitions.gamma_eq_eulerIntegral
```
:::
::::

# 5.2 Definitions and conventions

::::result "Real agreement and pole totalization" "implemented · DEF-001"
*Qualitative view.*

The complex and real Mathlib Gamma functions agree on real inputs. At nonpositive integers, the
totalized Lean function has value zero; this records an implementation convention at classical poles,
not a finite classical Gamma value.

*Quantitative view.*

These are exact convention and identification theorems, so a quantitative remainder analogue is not
applicable.

:::leanStatement "Expand the checked Lean declarations"
```lean
#check LMLF.Definitions.gamma_ofReal
#check LMLF.Definitions.gamma_neg_nat_eq_zero
```
:::
::::

# Chapter contents

## Notation and properties

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

:::sectionIndex
* [5.19 Mathematical Applications](https://dlmf.nist.gov/5.19)
* [5.20 Physical Applications](https://dlmf.nist.gov/5.20)
* [5.21 Methods of Computation](https://dlmf.nist.gov/5.21)
* [5.22 Tables](https://dlmf.nist.gov/5.22)
* [5.23 Approximations](https://dlmf.nist.gov/5.23)
* [5.24 Software](https://dlmf.nist.gov/5.24)
:::
