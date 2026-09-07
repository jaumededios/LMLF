import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section621
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section621
set_option verso.exampleProject "."

#doc (Manual) "§6.21 Software" =>
%%%
tag := "chapter-6-section-21"
%%%

:::dlmfChapter "https://dlmf.nist.gov/6.21"
Source: NIST Digital Library of Mathematical Functions, §6.21, Software.
:::

# §6.21 Software
%%%
number := false
%%%

This section is a software and literature index for the exponential,
logarithmic, sine, and cosine integrals of Chapter 6. It links research papers
describing implementations and separates entries whose software can be
downloaded from the Web from related references whose software is available in
other ways. The declarations below record bibliographic scope; they do not
assert that a package is installed or formalize the cited algorithms.

## Introduction
%%%
number := false
%%%

The DLMF introduction points readers to two broader indexes. The DLMF
[Software Index](https://dlmf.nist.gov/software/) is the more complete list for
these functions, while [GAMS class C5](https://gams.nist.gov/serve.cgi/Class/C5/)
is another directory of Web-accessible software for Chapter 6.

::::dlmfEntry "6.21(i) directories" "https://dlmf.nist.gov/6.21#i.p2"
The finite vocabulary keeps those two directory pointers distinct.
:::leanStatement "DLMF 6.21 directory sources"
```anchor dlmf_6_21_i_p2 (module := LMLF.Blueprint.ExponentialIntegrals.Section621)
def softwareDirectories : List SoftwareDirectory :=
  [ .dlmfSoftwareIndex
  , .gamsClassC5 ]
```
:::
::::

## Real arguments
%%%
number := false
%%%

For
$$`E_{1}(x),\ \operatorname{Ei}(x),\ \operatorname{Si}(x),\ \operatorname{Ci}(x),\ \operatorname{Shi}(x),\ \operatorname{Chi}(x),\qquad x\in\mathbb{R}`$$
the source lists three papers whose research software is available on the Web:
Amos (1980a), Cody (1993b), and Smith (2011). Each is identified as Fortran in
the DLMF. The Smith reference was added to this subsection effective with
version 1.0.9.

::::dlmfEntry "6.21(ii) downloadable software" "https://dlmf.nist.gov/6.21.ii"
The list preserves the source order and the real-variable scope.
:::leanStatement "DLMF 6.21 real-variable software"
```anchor dlmf_6_21_ii_p1 (module := LMLF.Blueprint.ExponentialIntegrals.Section621)
def realVariableSoftware : List RealWebSoftware :=
  [ .amos1980a
  , .cody1993b
  , .smith2011 ]
```
:::
::::

The subsection also says “See also” Gautschi (1973), MacLeod (1996b),
Paciorek (1970), and Stegun and Zucker (1976). These references are kept
separate from the downloadable list because the source presents them as
related software literature rather than as entries in the preceding bullets.

::::dlmfEntry "6.21(ii) related literature" "https://dlmf.nist.gov/6.21#I1.i3.p1"
:::leanStatement "DLMF 6.21 related real-variable literature"
```anchor dlmf_6_21_I1_related (module := LMLF.Blueprint.ExponentialIntegrals.Section621)
def relatedRealVariableLiterature : List RelatedRealSoftwareLiterature :=
  [ .gautschi1973
  , .macleod1996b
  , .paciorek1970
  , .stegunAndZucker1976 ]
```
:::
::::

## Complex arguments
%%%
number := false
%%%

For
$$`E_{1}(z),\ \operatorname{Si}(z),\ \operatorname{Ci}(z),\ \operatorname{Shi}(z),\ \operatorname{Chi}(z),\qquad z\in\mathbb{C}`$$
the DLMF lists Amos (1990), again identified as Fortran. The complex-argument
entry is separate from the real-argument list because it covers a different
domain and a different implementation reference.

::::dlmfEntry "6.21(iii) downloadable software" "https://dlmf.nist.gov/6.21.iii"
:::leanStatement "DLMF 6.21 complex-variable software"
```anchor dlmf_6_21_iii_p1 (module := LMLF.Blueprint.ExponentialIntegrals.Section621)
def complexVariableSoftware : List ComplexWebSoftware :=
  [ .amos1990 ]
```
:::
::::

The DLMF Software Cross Index provides the corresponding navigation for both
the real and complex entries. No numbered equation, table, or figure occurs in
§6.21; the page's substantive content is the software bibliography and its
domain split.

end LMLFManual.Chapter6
