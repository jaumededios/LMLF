import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section446
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
set_option verso.exampleProject "."

#doc (Manual) "§4.46 Tables" =>
%%%
tag := "chapter-4-section-46"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.46"
Source: NIST Digital Library of Mathematical Functions, §4.46.
:::

# §4.46 Tables
%%%
number := false
%%%

Section §4.46 is a resource guide for numerical tables rather than a formula
list. Its four source paragraphs direct readers to printed tables of elementary
functions, high-precision real roots of `tan x = x`, selected complex roots of
three parameterized equations, and a further reference for computation.

::::dlmfEntry "4.46" "https://dlmf.nist.gov/4.46"
The resource links below preserve the scope and precision labels of the DLMF
source. They complement the computational methods in §4.45 and the
approximations in §4.47.
::::

::::dlmfEntry "4.46#p1" "https://dlmf.nist.gov/4.46#p1"
For real arguments, extensive numerical tables for all elementary functions
appear in Abramowitz and Stegun (1964), Chapter 4. That handbook also gives
references to earlier tables, including Fletcher et al. (1962) and Lebedev and
Fedorova (1960).
::::

::::dlmfEntry "4.46#p2" "https://dlmf.nist.gov/4.46#p2"
Robinson (1972) gives 40-decimal-digit values for the first 500 roots of
`tan x = x`. These roots are zeros of the Bessel function `J_(3/2)(x)`; the
source points to [DLMF §10.21](https://dlmf.nist.gov/10.21) for Bessel zeros.
::::

::::dlmfEntry "4.46#p3" "https://dlmf.nist.gov/4.46#p3"
Fettis (1976) gives ten-significant-digit values for the first five complex
roots of each of `sin z = a z`, `cos z = a z`, and `cosh z = a z`, for selected
positive values of the parameter `a`.
::::

::::dlmfEntry "4.46#p4" "https://dlmf.nist.gov/4.46#p4"
The source also directs readers to Luther (1995) for additional computational
tables and numerical resources.
::::
