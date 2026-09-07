import VersoManual
import LMLFManual.Components
import LMLFManual.Chapter4.Section41
import LMLFManual.Chapter4.Section42
import LMLFManual.Chapter4.Section43
import LMLFManual.Chapter4.Section44
import LMLFManual.Chapter4.Section45
import LMLFManual.Chapter4.Section46
import LMLFManual.Chapter4.Section47
import LMLFManual.Chapter4.Section48
import LMLFManual.Chapter4.Section49
import LMLFManual.Chapter4.Section410
import LMLFManual.Chapter4.Section411
import LMLFManual.Chapter4.Section412
import LMLFManual.Chapter4.Section413
import LMLFManual.Chapter4.Section414
import LMLFManual.Chapter4.Section415
import LMLFManual.Chapter4.Section416
import LMLFManual.Chapter4.Section417
import LMLFManual.Chapter4.Section418
import LMLFManual.Chapter4.Section419
import LMLFManual.Chapter4.Section420
import LMLFManual.Chapter4.Section421
import LMLFManual.Chapter4.Section422
import LMLFManual.Chapter4.Section423
import LMLFManual.Chapter4.Section424
import LMLFManual.Chapter4.Section425
import LMLFManual.Chapter4.Section426
import LMLFManual.Chapter4.Section427
import LMLFManual.Chapter4.Section428
import LMLFManual.Chapter4.Section429
import LMLFManual.Chapter4.Section430
import LMLFManual.Chapter4.Section431
import LMLFManual.Chapter4.Section432
import LMLFManual.Chapter4.Section433
import LMLFManual.Chapter4.Section434
import LMLFManual.Chapter4.Section435
import LMLFManual.Chapter4.Section436
import LMLFManual.Chapter4.Section437
import LMLFManual.Chapter4.Section438
import LMLFManual.Chapter4.Section439
import LMLFManual.Chapter4.Section440
import LMLFManual.Chapter4.Section441
import LMLFManual.Chapter4.Section442
import LMLFManual.Chapter4.Section443
import LMLFManual.Chapter4.Section444
import LMLFManual.Chapter4.Section445
import LMLFManual.Chapter4.Section446
import LMLFManual.Chapter4.Section447
import LMLFManual.Chapter4.Section448

open Verso.Genre Manual
open LMLFManual

#doc (Manual) "Elementary Functions" =>
%%%
tag := "chapter-4"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4"
Source: NIST Digital Library of Mathematical Functions, Chapter 4.
:::

# Chapter contents
%%%
number := false
%%%

## Notation
%%%
number := false
%%%

:::sectionIndex
* [4.1 Special Notation](https://dlmf.nist.gov/4.1)
:::

## Logarithm, exponential, and powers
%%%
number := false
%%%

:::sectionIndex
* [4.2 Definitions](https://dlmf.nist.gov/4.2)
* [4.3 Graphics](https://dlmf.nist.gov/4.3)
* [4.4 Special Values and Limits](https://dlmf.nist.gov/4.4)
* [4.5 Inequalities](https://dlmf.nist.gov/4.5)
* [4.6 Power Series](https://dlmf.nist.gov/4.6)
* [4.7 Derivatives and Differential Equations](https://dlmf.nist.gov/4.7)
* [4.8 Identities](https://dlmf.nist.gov/4.8)
* [4.9 Continued Fractions](https://dlmf.nist.gov/4.9)
* [4.10 Integrals](https://dlmf.nist.gov/4.10)
* [4.11 Sums](https://dlmf.nist.gov/4.11)
* [4.12 Generalized Logarithms and Exponentials](https://dlmf.nist.gov/4.12)
* [4.13 Lambert W-Function](https://dlmf.nist.gov/4.13)
:::

## Trigonometric functions
%%%
number := false
%%%

:::sectionIndex
* [4.14 Definitions and Periodicity](https://dlmf.nist.gov/4.14)
* [4.15 Graphics](https://dlmf.nist.gov/4.15)
* [4.16 Elementary Properties](https://dlmf.nist.gov/4.16)
* [4.17 Special Values and Limits](https://dlmf.nist.gov/4.17)
* [4.18 Inequalities](https://dlmf.nist.gov/4.18)
* [4.19 Maclaurin Series and Laurent Series](https://dlmf.nist.gov/4.19)
* [4.20 Derivatives and Differential Equations](https://dlmf.nist.gov/4.20)
* [4.21 Identities](https://dlmf.nist.gov/4.21)
* [4.22 Infinite Products and Partial Fractions](https://dlmf.nist.gov/4.22)
* [4.23 Inverse Trigonometric Functions](https://dlmf.nist.gov/4.23)
* [4.24 Inverse Trigonometric Functions: Further Properties](https://dlmf.nist.gov/4.24)
* [4.25 Continued Fractions](https://dlmf.nist.gov/4.25)
* [4.26 Integrals](https://dlmf.nist.gov/4.26)
* [4.27 Sums](https://dlmf.nist.gov/4.27)
:::

## Hyperbolic functions
%%%
number := false
%%%

:::sectionIndex
* [4.28 Definitions and Periodicity](https://dlmf.nist.gov/4.28)
* [4.29 Graphics](https://dlmf.nist.gov/4.29)
* [4.30 Elementary Properties](https://dlmf.nist.gov/4.30)
* [4.31 Special Values and Limits](https://dlmf.nist.gov/4.31)
* [4.32 Inequalities](https://dlmf.nist.gov/4.32)
* [4.33 Maclaurin Series and Laurent Series](https://dlmf.nist.gov/4.33)
* [4.34 Derivatives and Differential Equations](https://dlmf.nist.gov/4.34)
* [4.35 Identities](https://dlmf.nist.gov/4.35)
* [4.36 Infinite Products and Partial Fractions](https://dlmf.nist.gov/4.36)
* [4.37 Inverse Hyperbolic Functions](https://dlmf.nist.gov/4.37)
* [4.38 Inverse Hyperbolic Functions: Further Properties](https://dlmf.nist.gov/4.38)
* [4.39 Continued Fractions](https://dlmf.nist.gov/4.39)
* [4.40 Integrals](https://dlmf.nist.gov/4.40)
* [4.41 Sums](https://dlmf.nist.gov/4.41)
:::

## Applications and computation
%%%
number := false
%%%

:::sectionIndex
* [4.42 Solution of Triangles](https://dlmf.nist.gov/4.42)
* [4.43 Cubic Equations](https://dlmf.nist.gov/4.43)
* [4.44 Other Applications](https://dlmf.nist.gov/4.44)
* [4.45 Methods of Computation](https://dlmf.nist.gov/4.45)
* [4.46 Tables](https://dlmf.nist.gov/4.46)
* [4.47 Approximations](https://dlmf.nist.gov/4.47)
* [4.48 Software](https://dlmf.nist.gov/4.48)
:::

{include 1 LMLFManual.Chapter4.Section41}

{include 1 LMLFManual.Chapter4.Section42}

{include 1 LMLFManual.Chapter4.Section43}

{include 1 LMLFManual.Chapter4.Section44}

{include 1 LMLFManual.Chapter4.Section45}

{include 1 LMLFManual.Chapter4.Section46}

{include 1 LMLFManual.Chapter4.Section47}

{include 1 LMLFManual.Chapter4.Section48}

{include 1 LMLFManual.Chapter4.Section49}

{include 1 LMLFManual.Chapter4.Section410}

{include 1 LMLFManual.Chapter4.Section411}

{include 1 LMLFManual.Chapter4.Section412}

{include 1 LMLFManual.Chapter4.Section413}

{include 1 LMLFManual.Chapter4.Section414}

{include 1 LMLFManual.Chapter4.Section415}

{include 1 LMLFManual.Chapter4.Section416}

{include 1 LMLFManual.Chapter4.Section417}

{include 1 LMLFManual.Chapter4.Section418}

{include 1 LMLFManual.Chapter4.Section419}

{include 1 LMLFManual.Chapter4.Section420}

{include 1 LMLFManual.Chapter4.Section421}

{include 1 LMLFManual.Chapter4.Section422}

{include 1 LMLFManual.Chapter4.Section423}

{include 1 LMLFManual.Chapter4.Section424}

{include 1 LMLFManual.Chapter4.Section425}

{include 1 LMLFManual.Chapter4.Section426}

{include 1 LMLFManual.Chapter4.Section427}

{include 1 LMLFManual.Chapter4.Section428}

{include 1 LMLFManual.Chapter4.Section429}

{include 1 LMLFManual.Chapter4.Section430}

{include 1 LMLFManual.Chapter4.Section431}

{include 1 LMLFManual.Chapter4.Section432}

{include 1 LMLFManual.Chapter4.Section433}

{include 1 LMLFManual.Chapter4.Section434}

{include 1 LMLFManual.Chapter4.Section435}

{include 1 LMLFManual.Chapter4.Section436}

{include 1 LMLFManual.Chapter4.Section437}

{include 1 LMLFManual.Chapter4.Section438}

{include 1 LMLFManual.Chapter4.Section439}

{include 1 LMLFManual.Chapter4.Section440}

{include 1 LMLFManual.Chapter4.Section441}

{include 1 LMLFManual.Chapter4.Section442}

{include 1 LMLFManual.Chapter4.Section443}

{include 1 LMLFManual.Chapter4.Section444}

{include 1 LMLFManual.Chapter4.Section445}

{include 1 LMLFManual.Chapter4.Section446}

{include 1 LMLFManual.Chapter4.Section447}

{include 1 LMLFManual.Chapter4.Section448}
