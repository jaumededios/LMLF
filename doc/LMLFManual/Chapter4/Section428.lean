import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section428
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual
open LMLF.Blueprint.Elementary.Section428

set_option verso.exampleProject "."

#doc (Manual) "§4.28 Definitions and Periodicity" =>
%%%
tag := "chapter-4-section-28"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.28"
Source: NIST Digital Library of Mathematical Functions, §4.28, Definitions and Periodicity.
:::

# §4.28 Definitions and Periodicity
%%%
number := false
%%%

The variables in this section are complex.  The first seven entries define
the hyperbolic functions from the exponential, quotient, and reciprocal
conventions.  The next six identify hyperbolic functions with ordinary
trigonometric functions evaluated at an imaginary argument.  The reciprocal
definitions use the usual totalized Lean division; away from zeros they are
the analytic functions represented by the DLMF notation.

## Definitions
%%%
number := false
%%%

Source: [DLMF §4.28, Definitions](https://dlmf.nist.gov/4.28).

::::dlmfEntry "4.28.1" "https://dlmf.nist.gov/4.28.E1"
$$`\sinh z=\frac{e^z-e^{-z}}{2}.`

Hyperbolic sine is the odd part of the exponential, with `z` allowed to be
any complex number.

:::leanStatement "Hyperbolic sine definition"
```anchor dlmf_4_28_1 (module := LMLF.Blueprint.Elementary.Section428)
theorem dlmf_4_28_1 (z : ℂ) :
    Complex.sinh z = (Complex.exp z - Complex.exp (-z)) / 2
```
:::
::::

::::dlmfEntry "4.28.2" "https://dlmf.nist.gov/4.28.E2"
$$`\cosh z=\frac{e^z+e^{-z}}{2}.`

Hyperbolic cosine is the even part of the exponential, on the same entire
complex domain.

:::leanStatement "Hyperbolic cosine definition"
```anchor dlmf_4_28_2 (module := LMLF.Blueprint.Elementary.Section428)
theorem dlmf_4_28_2 (z : ℂ) :
    Complex.cosh z = (Complex.exp z + Complex.exp (-z)) / 2
```
:::
::::

::::dlmfEntry "4.28.3" "https://dlmf.nist.gov/4.28.E3"
$$`\cosh z\mathbin{\pm}\sinh z=e^{\pm z}.`

The two signs are recorded together: the plus combination is `exp z`, and
the minus combination is `exp (-z)`.

:::leanStatement "Exponential combinations"
```anchor dlmf_4_28_3 (module := LMLF.Blueprint.Elementary.Section428)
theorem dlmf_4_28_3 (z : ℂ) :
    Complex.cosh z + Complex.sinh z = Complex.exp z ∧
    Complex.cosh z - Complex.sinh z = Complex.exp (-z)
```
:::
::::

::::dlmfEntry "4.28.4" "https://dlmf.nist.gov/4.28.E4"
$$`\tanh z=\frac{\sinh z}{\cosh z}.`

The hyperbolic tangent is the quotient of hyperbolic sine by hyperbolic
cosine.  Its poles occur where the denominator vanishes.

:::leanStatement "Hyperbolic tangent definition"
```anchor dlmf_4_28_4 (module := LMLF.Blueprint.Elementary.Section428)
theorem dlmf_4_28_4 (z : ℂ) :
    Complex.tanh z = Complex.sinh z / Complex.cosh z
```
:::
::::

::::dlmfEntry "4.28.5" "https://dlmf.nist.gov/4.28.E5"
$$`\operatorname{csch} z=\frac1{\sinh z}.`

The hyperbolic cosecant is the reciprocal of hyperbolic sine, with the source
domain understood away from the zeros of `sinh`.

:::leanStatement "Hyperbolic cosecant definition"
```anchor hyperbolicCosecant (module := LMLF.Blueprint.Elementary.Section428)
def hyperbolicCosecant (z : ℂ) : ℂ := 1 / Complex.sinh z
```
:::
::::

::::dlmfEntry "4.28.6" "https://dlmf.nist.gov/4.28.E6"
$$`\operatorname{sech} z=\frac1{\cosh z}.`

The hyperbolic secant is the reciprocal of hyperbolic cosine, away from its
zero set.

:::leanStatement "Hyperbolic secant definition"
```anchor hyperbolicSecant (module := LMLF.Blueprint.Elementary.Section428)
def hyperbolicSecant (z : ℂ) : ℂ := 1 / Complex.cosh z
```
:::
::::

::::dlmfEntry "4.28.7" "https://dlmf.nist.gov/4.28.E7"
$$`\coth z=\frac1{\tanh z}.`

The hyperbolic cotangent is the reciprocal of hyperbolic tangent, with the
corresponding pole convention.

:::leanStatement "Hyperbolic cotangent definition"
```anchor hyperbolicCotangent (module := LMLF.Blueprint.Elementary.Section428)
def hyperbolicCotangent (z : ℂ) : ℂ := 1 / Complex.tanh z
```
:::
::::

## Relations to trigonometric functions
%%%
number := false
%%%

Source: [DLMF §4.28, Relations to Trigonometric Functions](https://dlmf.nist.gov/4.28).

The imaginary-argument identities below are complex identities.  In the
cosecant and secant entries, Mathlib has no dedicated complex reciprocal
function names, so the page uses the transparent local definitions
`complexCosecant z = 1/sin z` and `complexSecant z = 1/cos z`.

::::dlmfEntry "4.28.8" "https://dlmf.nist.gov/4.28.E8"
$$`\sin(iz)=i\sinh z.`

Sine at `i z` is `i` times hyperbolic sine.

:::leanStatement "Sine and hyperbolic sine"
```anchor dlmf_4_28_8 (module := LMLF.Blueprint.Elementary.Section428)
theorem dlmf_4_28_8 (z : ℂ) :
    Complex.sin (Complex.I * z) = Complex.I * Complex.sinh z
```
:::
::::

::::dlmfEntry "4.28.9" "https://dlmf.nist.gov/4.28.E9"
$$`\cos(iz)=\cosh z.`

Cosine at `i z` is hyperbolic cosine without an additional factor.

:::leanStatement "Cosine and hyperbolic cosine"
```anchor dlmf_4_28_9 (module := LMLF.Blueprint.Elementary.Section428)
theorem dlmf_4_28_9 (z : ℂ) :
    Complex.cos (Complex.I * z) = Complex.cosh z
```
:::
::::

::::dlmfEntry "4.28.10" "https://dlmf.nist.gov/4.28.E10"
$$`\tan(iz)=i\tanh z.`

The tangent identity follows the same imaginary-argument conversion, away
from poles under the quotient convention.

:::leanStatement "Tangent and hyperbolic tangent"
```anchor dlmf_4_28_10 (module := LMLF.Blueprint.Elementary.Section428)
theorem dlmf_4_28_10 (z : ℂ) :
    Complex.tan (Complex.I * z) = Complex.I * Complex.tanh z
```
:::
::::

::::dlmfEntry "4.28.11" "https://dlmf.nist.gov/4.28.E11"
$$`\csc(iz)=-i\operatorname{csch} z.`

Using the transparent reciprocal definitions, cosecant at `i z` becomes
`-i` times hyperbolic cosecant.

:::leanStatement "Cosecant and hyperbolic cosecant"
```anchor complexCosecant (module := LMLF.Blueprint.Elementary.Section428)
def complexCosecant (z : ℂ) : ℂ := 1 / Complex.sin z
```
```anchor dlmf_4_28_11 (module := LMLF.Blueprint.Elementary.Section428)
theorem dlmf_4_28_11 (z : ℂ) :
    complexCosecant (Complex.I * z) = -Complex.I * hyperbolicCosecant z
```
:::
::::

::::dlmfEntry "4.28.12" "https://dlmf.nist.gov/4.28.E12"
$$`\sec(iz)=\operatorname{sech} z.`

Secant at `i z` agrees with hyperbolic secant, again using reciprocal
definitions on their pole-free domains.

:::leanStatement "Secant and hyperbolic secant"
```anchor complexSecant (module := LMLF.Blueprint.Elementary.Section428)
def complexSecant (z : ℂ) : ℂ := 1 / Complex.cos z
```
```anchor dlmf_4_28_12 (module := LMLF.Blueprint.Elementary.Section428)
theorem dlmf_4_28_12 (z : ℂ) :
    complexSecant (Complex.I * z) = hyperbolicSecant z
```
:::
::::

::::dlmfEntry "4.28.13" "https://dlmf.nist.gov/4.28.E13"
$$`\cot(iz)=-i\coth z.`

The cotangent identity is the reciprocal counterpart of E10.

:::leanStatement "Cotangent and hyperbolic cotangent"
```anchor dlmf_4_28_13 (module := LMLF.Blueprint.Elementary.Section428)
theorem dlmf_4_28_13 (z : ℂ) :
    Complex.cot (Complex.I * z) = -Complex.I * hyperbolicCotangent z
```
:::
::::

## Periodicity and zeros
%%%
number := false
%%%

Source: [DLMF §4.28, Periodicity and Zeros](https://dlmf.nist.gov/4.28).

The hyperbolic sine and cosine have period `2πi`, while hyperbolic tangent has
period `πi`.  Their zeros are
`sinh z = 0` at `z = i k π` and `cosh z = 0` at
`z = i(k+1/2)π`, for integers `k`.  The single Lean declaration records both
periods and both zero families in one reusable proposition.

:::leanStatement "Hyperbolic periodicity and zero sets"
```anchor dlmf_4_28_periodicity_and_zeros (module := LMLF.Blueprint.Elementary.Section428)
theorem dlmf_4_28_periodicity_and_zeros :
    (∀ z : ℂ, Complex.sinh (z + 2 * (Real.pi : ℂ) * Complex.I) = Complex.sinh z) ∧
    (∀ z : ℂ, Complex.cosh (z + 2 * (Real.pi : ℂ) * Complex.I) = Complex.cosh z) ∧
    (∀ z : ℂ, Complex.tanh (z + (Real.pi : ℂ) * Complex.I) = Complex.tanh z) ∧
    (∀ z : ℂ, Complex.sinh z = 0 ↔
      ∃ k : ℤ, z = (k : ℂ) * (Real.pi : ℂ) * Complex.I) ∧
    (∀ z : ℂ, Complex.cosh z = 0 ↔
      ∃ k : ℤ, z = ((k : ℂ) + (1 / 2 : ℂ)) * (Real.pi : ℂ) * Complex.I)
```
:::

The source notes that the hyperbolic identities inherit many properties from
the corresponding trigonometric functions.  For background references, it
points to Hobson (1928), pp. 322–326, and Levinson and Redheffer (1970),
pp. 56–57.
