import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section619
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section619
set_option verso.exampleProject "."

#doc (Manual) "§6.19 Tables" =>
%%%
tag := "chapter-6-section-19"
%%%

:::dlmfChapter "https://dlmf.nist.gov/6.19"
Source: NIST Digital Library of Mathematical Functions, §6.19, Tables.
:::

# §6.19 Tables
%%%
number := false
%%%

DLMF §6.19 is a bibliography of numerical tables, not a list of numbered
identities. It records which published tables cover the exponential, sine,
cosine, and auxiliary exponential-integral functions, together with their
grids and stated accuracy. The typed records below preserve that catalog data;
they do not claim to reproduce the external table values.

## Introduction
%%%
number := false
%%%

Lebedev and Fedorova (1960) and Fletcher et al. (1962) are cited as
comprehensive indexes of mathematical tables. The section then lists more
recent tables relevant to these functions.

::::dlmfEntry "6.19(i) Introduction" "https://dlmf.nist.gov/6.19#i.p1"
:::leanStatement "DLMF 6.19 table indexes"
```anchor indexReferences (module := LMLF.Blueprint.ExponentialIntegrals.Section619) -showProofStates
def indexReferences : List TableSource :=
  [.lebedevFedorova1960, .fletcherEtAl1962]
```
:::
::::

## Real variables
%%%
number := false
%%%

Abramowitz and Stegun (1964, Chapter 5) includes tables for
$`x^{-1}\operatorname{Si}(x)`, $`-x^{-2}\operatorname{Cin}(x)`,
$`x^{-1}\operatorname{Ein}(x)`, and $`-x^{-1}\operatorname{Ein}(-x)`
on $`x=0(.01)0.5`, as well as $`\operatorname{Si}(x)`,
$`\operatorname{Ci}(x)`, $`\operatorname{Ei}(x)`, and $`E_1(x)`
on $`x=0.5(.01)2`. The same source lists $`\operatorname{Si}(x)` and
$`\operatorname{Ci}(x)`, together with $`xe^{-x}\operatorname{Ei}(x)`
and $`xe^xE_1(x)` on $`x=2(.1)10`, and the auxiliary combinations
$`x f(x)` and $`x^2 g(x)` on the inverse-variable grid
$`x^{-1}=0(.005)0.1`. The stated accuracy varies within 8S–11S.

The same Abramowitz–Stegun source also tabulates $`\operatorname{Si}(\pi x)`
and $`\operatorname{Cin}(\pi x)` on $`x=0(.1)10`, with accuracy in the
same 8S–11S range.

Zhang and Jin (1996, pp. 652, 689) include $`\operatorname{Si}(x)` and
$`\operatorname{Ci}(x)` on $`x=0(.5)20(2)30`, and $`\operatorname{Ei}(x)`
and $`E_1(x)` on $`x\in[0,100]`, to 8S.

::::dlmfEntry "6.19(ii) Real Variables" "https://dlmf.nist.gov/6.19#ii.p1"
The records below preserve the functions, grids, bibliographic page ranges,
and accuracy notation of both real-variable source entries.

:::leanStatement "DLMF 6.19 real-variable table records"
```anchor realVariableTables (module := LMLF.Blueprint.ExponentialIntegrals.Section619) -showProofStates
def realVariableTables : List TableRecord :=
  [ { source := .abramowitzStegun1964
      pages := "Chapter 5"
      quantities := [.xInvSi, .negXInvSqCin, .xInvEin, .negXInvEinNeg]
      grid := .x (.arithmetic 0 (1 / 100) (1 / 2))
      accuracy := .significant 8 11 }
  , { source := .abramowitzStegun1964
      pages := "Chapter 5"
      quantities := [.si, .ci, .ei, .eOne]
      grid := .x (.arithmetic (1 / 2) (1 / 100) 2)
      accuracy := .significant 8 11 }
  , { source := .abramowitzStegun1964
      pages := "Chapter 5"
      quantities := [.si, .ci, .xExpNegEi, .xExpEOne]
      grid := .x (.arithmetic 2 (1 / 10) 10)
      accuracy := .significant 8 11 }
  , { source := .abramowitzStegun1964
      pages := "Chapter 5"
      quantities := [.xF, .xSqG, .xExpNegEi, .xExpEOne]
      grid := .x (.inverseArithmetic 0 (1 / 200) (1 / 10))
      accuracy := .significant 8 11 }
  , { source := .abramowitzStegun1964
      pages := "Chapter 5"
      quantities := [.siPi, .cinPi]
      grid := .x (.arithmetic 0 (1 / 10) 10)
      accuracy := .significant 8 11 }
  , { source := .zhangJin1996
      pages := "pp. 652, 689"
      quantities := [.si, .ci]
      grid := .x (.piecewise 0 (1 / 2) 20 2 30)
      accuracy := .decimal 8 }
  , { source := .zhangJin1996
      pages := "pp. 652, 689"
      quantities := [.ei, .eOne]
      grid := .x (.interval 0 100)
      accuracy := .significant 8 8 } ]
```
:::
::::

## Complex variables, z=x+iy
%%%
number := false
%%%

For complex $`z=x+iy`, Abramowitz and Stegun (1964, Chapter 5) tabulate
the real and imaginary parts of $`ze^zE_1(z)` on
$`x=-19(1)20`, $`y=0(1)20`; $`e^zE_1(z)` on
$`x=-4(.5)-2`, $`y=0(.2)1`; and $`E_1(z)+\ln z` on
$`x=-2(.5)2.5`, $`y=0(.2)1`. These are given to 6D.

Zhang and Jin (1996, pp. 690–692) include the real and imaginary parts of
$`E_1(z)` for $`\pm x=0.5,1,3,5,10,15,20,50,100` and
$`y=0(.5)1(1)5(5)30,50,100`, to 8S.

::::dlmfEntry "6.19(iii) Complex Variables" "https://dlmf.nist.gov/6.19#iii.p1"
The complex-variable records retain the source's coordinate grids and
significant/decimal-digit accuracy conventions.

:::leanStatement "DLMF 6.19 complex-variable table records"
```anchor complexVariableTables (module := LMLF.Blueprint.ExponentialIntegrals.Section619) -showProofStates
def complexVariableTables : List TableRecord :=
  [ { source := .abramowitzStegun1964
      pages := "Chapter 5"
      quantities := [.zExpEOne]
      grid := .xy (.arithmetic (-19) 1 20) (.arithmetic 0 1 20)
      accuracy := .decimal 6 }
  , { source := .abramowitzStegun1964
      pages := "Chapter 5"
      quantities := [.expEOne]
      grid := .xy (.arithmetic (-4) (1 / 2) (-2)) (.arithmetic 0 (1 / 5) 1)
      accuracy := .decimal 6 }
  , { source := .abramowitzStegun1964
      pages := "Chapter 5"
      quantities := [.eOneAddLog]
      grid := .xy (.arithmetic (-2) (1 / 2) (5 / 2)) (.arithmetic 0 (1 / 5) 1)
      accuracy := .decimal 6 }
  , { source := .zhangJin1996
      pages := "pp. 690–692"
      quantities := [.realImagEOne]
      grid := .xy
        (.signedExplicit [1 / 2, 1, 3, 5, 10, 15, 20, 50, 100])
        (.piecewise3WithTail 0 (1 / 2) 1 1 5 5 30 [50, 100])
      accuracy := .significant 8 8 } ]
```
:::
::::

No numbered DLMF formulas occur in this section; the coverage manifest records
the seven prose candidates and the two typed table catalogs instead.
