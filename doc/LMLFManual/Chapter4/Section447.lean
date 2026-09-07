import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section447
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
set_option verso.exampleProject "."

#doc (Manual) "§4.47 Approximations" =>
%%%
tag := "chapter-4-section-47"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.47"
Source: NIST Digital Library of Mathematical Functions, §4.47.
:::

# §4.47 Approximations
%%%
number := false
%%%

DLMF §4.47 is a bibliography of approximation resources for elementary
functions. It has four subsections and no numbered formulas: the references
provide coefficient tables, rational approximants, Padé approximants, and
additional bibliographic guidance. The available precision and the list of
functions depend on the cited source, so this page records those scopes rather
than introducing unsupported approximation formulas or error bounds.

## §4.47(i) Chebyshev-Series Expansions

::::dlmfEntry "Chebyshev-series expansions" "https://dlmf.nist.gov/4.47.i"
Clenshaw (1962) and Luke (1975, Chapter 3) give 20D coefficients for
`ln`, `exp`, `sin`, `cos`, `tan`, `cot`, `arcsin`, `arctan`, and `arcsinh`.
Schonfelder (1980) gives 40D coefficients for `sin`, `cos`, and `tan`.
The source subsection is a reference to these coefficient sets, not a
displayed universal approximation identity.
::::

## §4.47(ii) Rational Functions

::::dlmfEntry "Rational functions" "https://dlmf.nist.gov/4.47.ii"
Hart et al. (1968) give rational approximations for `ln`, `exp`, `sin`,
`cos`, `tan`, `cot`, `arcsin`, `arccos`, `arctan`, `sinh`, `cosh`, `tanh`,
`arcsinh`, and `arccosh`. The source explicitly notes that the precision is
variable; no single error estimate or domain is asserted on this page.
::::

## §4.47(iii) Padé Approximations

::::dlmfEntry "Padé approximations" "https://dlmf.nist.gov/4.47.iii"
Luke (1975, Chapter 3) supplies real and complex approximations for `ln`,
`exp`, `sin`, `cos`, `tan`, `arctan`, and `arcsinh`. The cited source has
variable precision, and this subsection gives no coefficient list or
quantitative error bound to formalize here.
::::

## §4.47(iv) Additional References

::::dlmfEntry "Additional references" "https://dlmf.nist.gov/4.47.iv"
For further approximation references, DLMF points to Luke (1975,
pp. 288–289) and Luke (1969b, pp. 74–76).
::::

The neighboring DLMF pages are [§4.46 Tables](https://dlmf.nist.gov/4.46)
and [§4.48 Software](https://dlmf.nist.gov/4.48). Since §4.47 supplies only
reference prose and no concrete approximation statement, the Lean companion
module contains no theorem declaration.
