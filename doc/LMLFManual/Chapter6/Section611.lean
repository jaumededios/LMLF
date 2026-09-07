import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section611
import LMLF.Blueprint.ExponentialIntegrals.Section62
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section611
open LMLF.Blueprint.ExponentialIntegrals.Section62
set_option verso.exampleProject "."

#doc (Manual) "§6.11 Relations to Other Functions" =>
%%%
tag := "chapter-6-section-11"
%%%

:::dlmfChapter "https://dlmf.nist.gov/6.11"
Source: NIST Digital Library of Mathematical Functions, §6.11, Relations to Other Functions.
:::

# §6.11 Relations to Other Functions
%%%
number := false
%%%

This section records three standard identifications of the exponential and
sine/cosine integrals with functions developed elsewhere in the DLMF. The
first formula identifies the principal exponential integral `E₁(z)` with the
upper incomplete gamma function at parameter zero. The second expresses the
same function through Tricomi's confluent hypergeometric function `U`. The
third gives the corresponding confluent-hypergeometric representation of the
canonical §6.4 auxiliary functions `f` and `g`. The Lean disclosures use the
§6.2/§6.4 principal definitions, the normalized `(1,1)` Tricomi interface,
and explicit principal-domain conditions.

## Incomplete Gamma Function
%%%
number := false
%%%

The notation `Γ(a,z)` is the upper incomplete gamma function. At `a=0` it
coincides with the exponential integral `E₁(z)`; this is the special case
used in the first displayed identity. The DLMF treats the logarithmic cut by
the principal continuation, so the formula is read with that branch
convention rather than as a real-only statement. The named
`upperIncompleteGammaZero` is the `Ein - log - γ` reconstruction on
`principalRelationDomain`.

:::leanStatement "Normalized upper incomplete gamma value"
```anchor upperIncompleteGammaZero (module := LMLF.Blueprint.ExponentialIntegrals.Section611)
def upperIncompleteGammaZero (z : ℂ) : ℂ :=
  principalEin z - Complex.log z - (Real.eulerMascheroniConstant : ℂ)
```
:::

::::dlmfEntry "§6.11 annotation" "https://dlmf.nist.gov/6.11#info"
The section annotation records the Temme references for E1 and E2 and the
§6.5.7 dependency for E3.
::::
::::dlmfEntry "§6.11 introduction" "https://dlmf.nist.gov/6.11#p1"
The section introduction points to §§8.2(i) and 13.2(i) for the notation
used by the confluent-hypergeometric formulas.
::::
::::dlmfEntry "Incomplete-gamma prose" "https://dlmf.nist.gov/6.11#Px1.p1"
The incomplete-gamma subsection fixes the Γ(0,z) notation and its relation to
the exponential integral.
::::
::::dlmfEntry "Confluent-hypergeometric prose" "https://dlmf.nist.gov/6.11#Px2.p1"
The confluent-hypergeometric subsection introduces U and the auxiliary f/g
functions used in E2 and E3.
::::

::::dlmfEntry "6.11.1" "https://dlmf.nist.gov/6.11.E1"
$$`E_{1}(z)=\Gamma(0,z)`$$

:::leanStatement "E1 and the upper incomplete gamma function"
```anchor dlmf_6_11_1 (module := LMLF.Blueprint.ExponentialIntegrals.Section611)
/-- DLMF 6.11.E1: E₁ is the upper incomplete gamma function at a = 0. -/
theorem dlmf_6_11_1 (z : ℂ) (hdom : principalRelationDomain z) :
    principalE1 z = upperIncompleteGammaZero z
```
:::
::::

The source notes point to Temme's treatment for this identity and for the
next one. The notation and branch conventions are those of the DLMF
incomplete-gamma and exponential-integral entries.

## Confluent Hypergeometric Function
%%%
number := false
%%%

Tricomi's confluent hypergeometric function is denoted by `U(a,b,z)`. In the
special parameter case `(a,b)=(1,1)`, the exponential integral is obtained by
removing the factor `e^{-z}` from the expression below. The identity uses the
canonical principal-E₁ map, the named `tricomiU11` interface, and the explicit
principal domain.

:::leanStatement "Normalized Tricomi U value"
```anchor tricomiU11 (module := LMLF.Blueprint.ExponentialIntegrals.Section611)
def tricomiU11 (z : ℂ) : ℂ :=
  Complex.exp z * upperIncompleteGammaZero z
```
:::

::::dlmfEntry "6.11.2" "https://dlmf.nist.gov/6.11.E2"
$$`E_{1}(z)=e^{-z}U(1,1,z)`$$

:::leanStatement "E1 and Tricomi U"
```anchor dlmf_6_11_2 (module := LMLF.Blueprint.ExponentialIntegrals.Section611)
/-- DLMF 6.11.E2: E₁ is e⁻ᶻ times Tricomi's U(1,1,z). -/
theorem dlmf_6_11_2 (z : ℂ) (hdom : principalRelationDomain z) :
    principalE1 z = Complex.exp (-z) * tricomiU11 z
```
:::
::::

For the auxiliary sine and cosine integrals, the DLMF uses functions `f(z)`
and `g(z)` whose complex combination is naturally expressed with the same
Tricomi function. The argument is rotated by `-iz`; the imaginary unit, the
parameters `(1,1)`, and the sign are part of the identity. The canonical §6.2
principal combinations appear through the named `auxiliaryF`, `auxiliaryG`, and
normalized `tricomiU11` interfaces.

:::leanStatement "Canonical auxiliary f"
```anchor auxiliaryF (module := LMLF.Blueprint.ExponentialIntegrals.Section611)
def auxiliaryF (z : ℂ) : ℂ := principalAuxiliaryF z
```
:::

:::leanStatement "Canonical auxiliary g"
```anchor auxiliaryG (module := LMLF.Blueprint.ExponentialIntegrals.Section611)
def auxiliaryG (z : ℂ) : ℂ := principalAuxiliaryG z
```
:::

::::dlmfEntry "6.11.3" "https://dlmf.nist.gov/6.11.E3"
$$`g(z)+\mathrm{i}f(z)=U(1,1,-\mathrm{i}z)`$$

:::leanStatement "Auxiliary functions and Tricomi U"
```anchor dlmf_6_11_3 (module := LMLF.Blueprint.ExponentialIntegrals.Section611)
/-- DLMF 6.11.E3: the auxiliary sine/cosine-integral functions combine to U. -/
theorem dlmf_6_11_3 (z : ℂ) (hdom : principalRelationDomain (-Complex.I * z)) :
    auxiliaryG z + Complex.I * auxiliaryF z = tricomiU11 (-Complex.I * z)
```
:::
::::

The page notes that E3 is obtained from the auxiliary-function formula in
§6.5.7. The explicit domain condition applies the principal continuation to
the rotated Tricomi argument.

end LMLFManual.Chapter6
