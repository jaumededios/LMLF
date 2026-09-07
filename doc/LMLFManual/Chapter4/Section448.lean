import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section448
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
set_option verso.exampleProject "."

#doc (Manual) "§4.48 Software" =>
%%%
tag := "chapter-4-section-48"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.48"
Source: NIST Digital Library of Mathematical Functions, §4.48.
:::

# §4.48 Software
%%%
number := false
%%%

DLMF §4.48 is a curated software bibliography, organized by the kind of
arithmetic or function support supplied. It deliberately omits software that
uses only standard floating-point arithmetic. The page has no numbered
mathematical formulas: the entries below preserve its resource categories,
languages, references, and editorial additions.

## §4.48(i) Introduction

::::dlmfEntry "Introduction: scope" "https://dlmf.nist.gov/4.48#i.p1"
Scientific programming languages, libraries, and systems support at least
some elementary functions in standard floating-point arithmetic; DLMF refers
to [§3.1(i)](https://dlmf.nist.gov/3.1.i) and does not list those routine
implementations here.
::::

::::dlmfEntry "Introduction: research literature" "https://dlmf.nist.gov/4.48#i.p2"
This page links research literature describing algorithms implemented in
software for the functions of Chapter 4 when the arithmetic is nonstandard.
It also includes links for the Lambert W-function and for test software.
Citations in the bulleted lists identify papers whose research software can
be downloaded via the Web; references to software available in other ways are
listed separately.
::::

::::dlmfEntry "Introduction: software indexes" "https://dlmf.nist.gov/4.48#i.p3"
The [DLMF Software Index](https://dlmf.nist.gov/software/) provides a more
complete list of available software for these functions, again excluding
implementations using only standard floating-point arithmetic. DLMF also
points to [GAMS class C4](https://gams.nist.gov/serve.cgi/Class/C4/) as
another list of Web-accessible software for the functions in this chapter.
::::

## §4.48(ii) Interval Arithmetic

::::dlmfEntry "Interval arithmetic" "https://dlmf.nist.gov/4.48#ii.p1"
The interval-arithmetic resources are Kearfott et al. (1994), Fortran;
Kearfott (1996), Fortran 90; and Neher (2007), C++.
::::

::::dlmfEntry "Kearfott et al. (1994)" "https://dlmf.nist.gov/4.48#I1.i1.p1"
Kearfott et al. (1994) is listed as a Fortran interval-arithmetic resource.
::::

::::dlmfEntry "Kearfott (1996)" "https://dlmf.nist.gov/4.48#I1.i2.p1"
Kearfott (1996) is listed as a Fortran 90 interval-arithmetic resource.
::::

::::dlmfEntry "Neher (2007)" "https://dlmf.nist.gov/4.48#I1.i3.p1"
Neher (2007) is listed as a C++ interval-arithmetic resource.
::::

::::dlmfEntry "Interval-arithmetic further references" "https://dlmf.nist.gov/4.48#ii.p2"
Further interval-arithmetic references are Loenko (2001) and Yohe (1979).
::::

## §4.48(iii) General Precision

::::dlmfEntry "General-precision editorial addition" "https://dlmf.nist.gov/4.48#iii.info"
Effective with DLMF version 1.0.9, the reference to Smith (2011) was added
to this subsection.
::::

::::dlmfEntry "General-precision resources" "https://dlmf.nist.gov/4.48#iii.p1"
The general-precision resources are Brent (1978a), Fortran; Smith (1991),
Fortran; Bailey (1993), Fortran; Smith (1998), Fortran; and Smith (2011),
Fortran.
::::

::::dlmfEntry "Brent (1978a)" "https://dlmf.nist.gov/4.48#I2.i1.p1"
Brent (1978a) is listed as a Fortran general-precision resource.
::::

::::dlmfEntry "Smith (1991)" "https://dlmf.nist.gov/4.48#I2.i2.p1"
Smith (1991) is listed as a Fortran general-precision resource.
::::

::::dlmfEntry "Bailey (1993)" "https://dlmf.nist.gov/4.48#I2.i3.p1"
Bailey (1993) is listed as a Fortran general-precision resource.
::::

::::dlmfEntry "Smith (1998)" "https://dlmf.nist.gov/4.48#I2.i4.p1"
Smith (1998) is listed as a Fortran general-precision resource.
::::

::::dlmfEntry "Smith (2011)" "https://dlmf.nist.gov/4.48#I2.i5.p1"
Smith (2011) is listed as a Fortran general-precision resource.
::::

::::dlmfEntry "General-precision further references" "https://dlmf.nist.gov/4.48#iii.p2"
Further references are Bailey (1995), Hull and Abrham (1986), and Xu and Li
(1994).
::::

## §4.48(iv) Lambert W-Function

::::dlmfEntry "Lambert W editorial addition" "https://dlmf.nist.gov/4.48#iv.info"
Effective with DLMF version 1.0.9, the reference to Lawrence et al. (2012)
was added to this subsection.
::::

::::dlmfEntry "Lambert W resources" "https://dlmf.nist.gov/4.48#iv.p1"
The Lambert W-function resources are Barry et al. (1995a), Fortran, and
Lawrence et al. (2012), C.
::::

::::dlmfEntry "Barry et al. (1995a)" "https://dlmf.nist.gov/4.48#I3.i1.p1"
Barry et al. (1995a) is listed as a Fortran Lambert W-function resource.
::::

::::dlmfEntry "Lawrence et al. (2012)" "https://dlmf.nist.gov/4.48#I3.i2.p1"
Lawrence et al. (2012) is listed as a C Lambert W-function resource.
::::

::::dlmfEntry "Lambert W further reference" "https://dlmf.nist.gov/4.48#iv.p2"
The further Lambert W-function reference is Fritsch et al. (1973).
::::

## §4.48(v) Testing

::::dlmfEntry "Testing" "https://dlmf.nist.gov/4.48#v.p1"
The testing resource is Cody (1993a), Fortran.
::::

::::dlmfEntry "Cody (1993a)" "https://dlmf.nist.gov/4.48#I4.i1.p1"
Cody (1993a) is listed as a Fortran testing resource for the functions in
the software bibliography.
::::

The neighboring DLMF pages are [§4.47 Approximations](https://dlmf.nist.gov/4.47)
and [§5 Gamma Function](https://dlmf.nist.gov/5). Since §4.48 contains
software references rather than displayed mathematics, its Lean companion
module contains no theorem declaration.
