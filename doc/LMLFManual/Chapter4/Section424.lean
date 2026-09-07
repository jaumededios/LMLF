import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section424
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.24 Inverse Trigonometric Functions: Further Properties" =>
%%%
tag := "chapter-4-section-24"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.24"
Source: NIST Digital Library of Mathematical Functions, §4.24, Inverse Trigonometric Functions: Further Properties.
:::

# §4.24 Inverse Trigonometric Functions: Further Properties
%%%
number := false
%%%

This section records three complementary parts of the inverse-trigonometric
calculus.  The first subsection gives convergent power-series and transformed
series, with their exact disks or half-plane conditions.  The second gives
derivatives of the principal complex branches, including the real-part sign
choice for arcsecant and arccosecant.  The final subsection uses explicit value
relations: DLMF's capitalized inverse functions are multivalued, and every
square root in those addition formulas may take either value.

## §4.24(i) Power Series
%%%
number := false
%%%

Source: [DLMF §4.24(i)](https://dlmf.nist.gov/4.24.i).

:::leanStatement "Principal inverse branches and series vocabulary"
```anchor principalArcsin (module := LMLF.Blueprint.Elementary.Section424)
def principalArcsin (z : ℂ) : ℂ :=
  -Complex.I * Complex.log (Complex.sqrt (1 - z ^ 2) + Complex.I * z)
```
```anchor principalArccos (module := LMLF.Blueprint.Elementary.Section424)
def principalArccos (z : ℂ) : ℂ :=
  (Real.pi / 2 : ℂ) + Complex.I *
    Complex.log (Complex.sqrt (1 - z ^ 2) + Complex.I * z)
```
```anchor principalArctan (module := LMLF.Blueprint.Elementary.Section424)
def principalArctan (z : ℂ) : ℂ := Complex.arctan z
```
```anchor oddProduct (module := LMLF.Blueprint.Elementary.Section424)
def oddProduct (n : ℕ) : ℕ := Finset.prod (Finset.range n) (fun k => 2 * k + 1)
```
```anchor arcsinSeriesTerm (module := LMLF.Blueprint.Elementary.Section424)
def arcsinSeriesTerm (z : ℂ) (n : ℕ) : ℂ :=
  ((Nat.choose (2 * n) n : ℂ) /
      ((4 : ℂ) ^ n * ((2 * n + 1 : ℕ) : ℂ))) * z ^ (2 * n + 1)
```
```anchor arccosSeriesTerm (module := LMLF.Blueprint.Elementary.Section424)
def arccosSeriesTerm (z : ℂ) (n : ℕ) : ℂ :=
  Complex.sqrt (2 * (1 - z)) *
    ((oddProduct n : ℂ) /
      ((2 : ℂ) ^ (2 * n) * ((2 * n + 1 : ℕ) : ℂ) * (Nat.factorial n : ℂ))) *
    (1 - z) ^ n
```
```anchor arctanSeriesTerm (module := LMLF.Blueprint.Elementary.Section424)
def arctanSeriesTerm (z : ℂ) (n : ℕ) : ℂ :=
  (-1 : ℂ) ^ n * z ^ (2 * n + 1) / ((2 * n + 1 : ℕ) : ℂ)
```
:::

::::dlmfEntry "4.24.1" "https://dlmf.nist.gov/4.24.E1"
$$`\arcsin z=z+\frac12\frac{z^3}{3}+\frac{1\cdot3}{2\cdot4}\frac{z^5}{5}+\frac{1\cdot3\cdot5}{2\cdot4\cdot6}\frac{z^7}{7}+\cdots,\qquad |z|\leq1.`

The coefficient of `z^(2n+1)` is `binom(2n,n)/(4^n(2n+1))`.  The closed-unit-
disk condition includes the boundary points at which the series has its
standard convergent limiting values; `principalArcsin` fixes the branch used
for the complex function.

:::leanStatement "Arcsine power series"
```anchor dlmf_4_24_1 (module := LMLF.Blueprint.Elementary.Section424)
theorem dlmf_4_24_1 {z : ℂ} (hz : ‖z‖ ≤ 1) :
    HasSum (fun n : ℕ => arcsinSeriesTerm z n) (principalArcsin z)
```
:::
::::

::::dlmfEntry "4.24.2" "https://dlmf.nist.gov/4.24.E2"
$$`\arccos z=\{2(1-z)\}^{1/2}\left(1+\sum_{n=1}^{\infty}
\frac{1\cdot3\cdots(2n-1)}{2^{2n}(2n+1)n!}(1-z)^n\right),\qquad |1-z|\leq2.`

The odd product is indexed from one in the source; the Lean term uses a
natural index and `oddProduct n`.  The principal square root and the principal
arccosine branch are retained, and the disk is centered at `1` with radius
`2`, not the unit disk centered at the origin.

:::leanStatement "Arccosine expansion about one"
```anchor dlmf_4_24_2 (module := LMLF.Blueprint.Elementary.Section424)
theorem dlmf_4_24_2 {z : ℂ} (hz : ‖1 - z‖ ≤ 2) :
    principalArccos z = Complex.sqrt (2 * (1 - z)) *
      (1 + ∑' n : ℕ, ((oddProduct (n + 1) : ℂ) /
        ((2 : ℂ) ^ (2 * (n + 1)) * ((2 * (n + 1) + 1 : ℕ) : ℂ) *
          (Nat.factorial (n + 1) : ℂ))) * (1 - z) ^ (n + 1))
```
:::
::::

::::dlmfEntry "4.24.3" "https://dlmf.nist.gov/4.24.E3"
$$`\arctan z=z-\frac{z^3}{3}+\frac{z^5}{5}-\frac{z^7}{7}+\cdots,
\qquad |z|\leq1,\quad z\ne\pm i.`

The alternating odd-power series is valid through the closed unit disk with
the two branch points `±i` explicitly excluded.  Its coefficient is
`(-1)^n/(2n+1)` in the natural index convention.

:::leanStatement "Arctangent power series"
```anchor dlmf_4_24_3 (module := LMLF.Blueprint.Elementary.Section424)
theorem dlmf_4_24_3 {z : ℂ} (hz : ‖z‖ ≤ 1) (hbranch : z ≠ Complex.I) (hbranch' : z ≠ -Complex.I) :
    HasSum (fun n : ℕ => arctanSeriesTerm z n) (principalArctan z)
```
:::
::::

::::dlmfEntry "4.24.4" "https://dlmf.nist.gov/4.24.E4"
$$`\arctan z=\pm\frac{\pi}{2}-\frac1z+\frac1{3z^3}-\frac1{5z^5}+\cdots,
\qquad \Re z\gtrless0,\quad |z|\geq1.`

The sign is positive on the right half-plane and negative on the left
half-plane.  This is the corrected sign convention noted by DLMF: the older
Abramowitz--Stegun display had the wrong sign for `Re z<0`.  The exterior term
is a genuine inverse-power expansion, not the origin-centered series in E3.

:::leanStatement "Exterior arctangent expansion"
```anchor exteriorBranchSign (module := LMLF.Blueprint.Elementary.Section424)
def exteriorBranchSign (z : ℂ) : ℂ := if 0 < z.re then 1 else -1
```
```anchor arctanExteriorTerm (module := LMLF.Blueprint.Elementary.Section424)
def arctanExteriorTerm (z : ℂ) (n : ℕ) : ℂ :=
  (-1 : ℂ) ^ (n + 1) / (((2 * n + 1 : ℕ) : ℂ) * z ^ (2 * n + 1))
```
```anchor dlmf_4_24_4 (module := LMLF.Blueprint.Elementary.Section424)
theorem dlmf_4_24_4 {z : ℂ} (hz : ‖z‖ ≥ 1) (hhalf : z.re ≠ 0) :
    principalArctan z = exteriorBranchSign z * (Real.pi / 2 : ℂ) +
      ∑' n : ℕ, arctanExteriorTerm z n
```
:::
::::

::::dlmfEntry "4.24.5" "https://dlmf.nist.gov/4.24.E5"
$$`\arctan z=\frac{z}{z^2+1}\left(1+\frac23\frac{z^2}{1+z^2}
+\frac{2\cdot4}{3\cdot5}\left(\frac{z^2}{1+z^2}\right)^2+\cdots\right),
\qquad \Re(z^2)>-\tfrac12.`

The coefficient of the nth transformed power is
`2^n n!/(1·3·...·(2n+1))`; thus the first coefficients are `1`, `2/3`,
and `8/15`.  The half-plane condition is equivalent to convergence of this
transformed series and is bounded by the hyperbola recorded in E6.

:::leanStatement "Transformed arctangent series"
```anchor arctanTransformedTerm (module := LMLF.Blueprint.Elementary.Section424)
def arctanTransformedTerm (z : ℂ) (n : ℕ) : ℂ :=
  ((2 : ℂ) ^ n * (Nat.factorial n : ℂ) /
      (oddProduct (n + 1) : ℂ)) * (z ^ 2 / (1 + z ^ 2)) ^ n
```
```anchor dlmf_4_24_5 (module := LMLF.Blueprint.Elementary.Section424)
theorem dlmf_4_24_5 {z : ℂ} (hz : -(1 / 2 : ℝ) < (z ^ 2).re) :
    principalArctan z = z / (z ^ 2 + 1) *
      ∑' n : ℕ, arctanTransformedTerm z n
```
:::
::::

::::dlmfEntry "4.24.6" "https://dlmf.nist.gov/4.24.E6"
$$`x^2-y^2=-\tfrac12,\qquad z=x+iy.`

In real coordinates this hyperbola is the boundary of the E5 half-plane
condition `Re(z²)>-1/2`.  It is recorded as a boundary predicate rather than
as a universal equality: only points on the boundary satisfy the displayed
equation.

:::leanStatement "Transformed-series boundary"
```anchor dlmf_4_24_6 (module := LMLF.Blueprint.Elementary.Section424)
def dlmf_4_24_6 (x y : ℝ) : Prop := x ^ 2 - y ^ 2 = -(1 / 2 : ℝ)
```
:::
::::

## §4.24(ii) Derivatives
%%%
number := false
%%%

Source: [DLMF §4.24(ii)](https://dlmf.nist.gov/4.24.ii).

The following formulas are derivatives of principal branches on their stated
slit domains and away from poles.  For E10 and E11 the principal square root of
`z²−1` has both the imaginary-axis cut and the real segment `[-1,1]`; the
open-half-plane sign is used only off those cuts.  The reciprocal arccotangent
pulls the arctangent cuts back to the imaginary segment `[-i,i]`.

::::dlmfEntry "4.24.7" "https://dlmf.nist.gov/4.24.E7"
$$`\frac{d}{dz}\arcsin z=(1-z^2)^{-1/2}.`

The hypothesis is the principal slit-plane condition: the real cuts
`(-∞,-1]` and `[1,∞)` are excluded, including their endpoints.

:::leanStatement "Arcsine derivative"
```anchor principalInverseTrigDomain (module := LMLF.Blueprint.Elementary.Section424)
/-- DLMF 4.24.E7 and E8: principal inverse-trigonometric slit-plane domain. -/
def principalInverseTrigDomain (z : ℂ) : Prop :=
  ¬ (z.im = 0 ∧ (1 ≤ z.re ∨ z.re ≤ -1))
```
```anchor dlmf_4_24_7 (module := LMLF.Blueprint.Elementary.Section424)
theorem dlmf_4_24_7 {z : ℂ} (hcut : principalInverseTrigDomain z) :
    deriv principalArcsin z = (Complex.sqrt (1 - z ^ 2))⁻¹
```
:::
::::

::::dlmfEntry "4.24.8" "https://dlmf.nist.gov/4.24.E8"
$$`\frac{d}{dz}\arccos z=-(1-z^2)^{-1/2}.`

The arccosine derivative uses the same principal slit-plane domain as E7 and
has the opposite sign.

:::leanStatement "Arccosine derivative"
```anchor dlmf_4_24_8 (module := LMLF.Blueprint.Elementary.Section424)
theorem dlmf_4_24_8 {z : ℂ} (hcut : principalInverseTrigDomain z) :
    deriv principalArccos z = -(Complex.sqrt (1 - z ^ 2))⁻¹
```
:::
::::

::::dlmfEntry "4.24.9" "https://dlmf.nist.gov/4.24.E9"
$$`\frac{d}{dz}\arctan z=\frac1{1+z^2}.`

The cut-complement hypothesis excludes the imaginary rays `i[1,∞)` and
`i(-∞,-1]`, including the poles `±i`.

:::leanStatement "Arctangent derivative"
```anchor principalArctanDomain (module := LMLF.Blueprint.Elementary.Section424)
/-- DLMF 4.24.E9: principal arctangent cut-complement domain. -/
def principalArctanDomain (z : ℂ) : Prop :=
  ¬ (z.re = 0 ∧ (1 ≤ z.im ∨ z.im ≤ -1))
```
```anchor dlmf_4_24_9 (module := LMLF.Blueprint.Elementary.Section424)
theorem dlmf_4_24_9 {z : ℂ} (hcut : principalArctanDomain z) :
    deriv principalArctan z = (1 + z ^ 2)⁻¹
```
:::
::::

::::dlmfEntry "4.24.10" "https://dlmf.nist.gov/4.24.E10"
$$`\frac{d}{dz}\operatorname{arccsc}z=\mp\frac1{z(z^2-1)^{1/2}},
\qquad \Re z\gtrless0.`

The pole at zero and the branch points `±1` are excluded.  The sign is
negative on the right half-plane and positive on the left.  In addition to
those points, the real segment `[-1,1]` is excluded because it is a cut of
the displayed principal square root.

:::leanStatement "Arccosecant derivative"
```anchor principalArccsc (module := LMLF.Blueprint.Elementary.Section424)
def principalArccsc (z : ℂ) : ℂ := principalArcsin (1 / z)
```
```anchor principalArcCscSecDomain (module := LMLF.Blueprint.Elementary.Section424)
/-- DLMF 4.24.E10 and E11: real-segment complement for `sqrt (z²-1)`. -/
def principalArcCscSecDomain (z : ℂ) : Prop :=
  ¬ (z.im = 0 ∧ -1 ≤ z.re ∧ z.re ≤ 1)
```
/-- DLMF 4.24.E10: derivative branch sign for the principal arccosecant. -/
```anchor dlmf_4_24_10 (module := LMLF.Blueprint.Elementary.Section424)
theorem dlmf_4_24_10 {z : ℂ} (hz : z ≠ 0) (hz₁ : z ≠ 1) (hz₂ : z ≠ -1)
    (hhalf : z.re ≠ 0) (hcut : principalArcCscSecDomain z) :
    deriv principalArccsc z = -(exteriorBranchSign z) /
      (z * Complex.sqrt (z ^ 2 - 1))
```
:::
::::

::::dlmfEntry "4.24.11" "https://dlmf.nist.gov/4.24.E11"
$$`\frac{d}{dz}\operatorname{arcsec}z=\pm\frac1{z(z^2-1)^{1/2}},
\qquad \Re z\gtrless0.`

Arcsecant has the same pole, branch-point, imaginary-axis, and real-segment
cut exclusions.  Its sign is the opposite of arccosecant on each
corresponding half-plane.

:::leanStatement "Arcsecant derivative"
```anchor principalArcsec (module := LMLF.Blueprint.Elementary.Section424)
def principalArcsec (z : ℂ) : ℂ := principalArccos (1 / z)
```
```anchor dlmf_4_24_11 (module := LMLF.Blueprint.Elementary.Section424)
theorem dlmf_4_24_11 {z : ℂ} (hz : z ≠ 0) (hz₁ : z ≠ 1) (hz₂ : z ≠ -1)
    (hhalf : z.re ≠ 0) (hcut : principalArcCscSecDomain z) :
    deriv principalArcsec z = exteriorBranchSign z /
      (z * Complex.sqrt (z ^ 2 - 1))
```
:::
::::

::::dlmfEntry "4.24.12" "https://dlmf.nist.gov/4.24.E12"
$$`\frac{d}{dz}\operatorname{arccot}z=-\frac1{1+z^2}.`

Because the declared principal branch is `arctan (1/z)`, the arccotangent
formula excludes zero, the poles `±i`, and the pulled-back imaginary cut
segment `[-i,i]`.

:::leanStatement "Arccotangent derivative"
```anchor principalArccot (module := LMLF.Blueprint.Elementary.Section424)
def principalArccot (z : ℂ) : ℂ := principalArctan (1 / z)
```
```anchor principalArccotDomain (module := LMLF.Blueprint.Elementary.Section424)
/-- DLMF 4.24.E12: principal arccotangent cut-complement domain. -/
def principalArccotDomain (z : ℂ) : Prop :=
  ¬ (z.re = 0 ∧ -1 ≤ z.im ∧ z.im ≤ 1)
```
/-- DLMF 4.24.E12: derivative of the principal arccotangent. -/
```anchor dlmf_4_24_12 (module := LMLF.Blueprint.Elementary.Section424)
theorem dlmf_4_24_12 {z : ℂ} (hz : z ≠ 0) (hz₁ : z ≠ Complex.I)
    (hz₂ : z ≠ -Complex.I) (hcut : principalArccotDomain z) :
    deriv principalArccot z = -(1 + z ^ 2)⁻¹
```
:::
::::

## §4.24(iii) Addition Formulas
%%%
number := false
%%%

Source: [DLMF §4.24(iii)](https://dlmf.nist.gov/4.24.iii).

For this subsection, `arcsinValues`, `arccosValues`, `arctanValues`, and
`arccotValues` are transparent multivalued relations for `sin w=u`, `cos w=u`,
`tan w=u`, and `cot w=u`; the latter two also require the corresponding
denominator to be nonzero, so tangent and cotangent poles are not values.
This keeps the source's capitalized multivalued interpretation visible in Lean.
The parameter `σ` is restricted to `1` or
`-1`.  Each addition declaration is a membership equivalence, so it records
both inclusions between all left-hand values and all right-hand values while
retaining square-root choices and denominator exclusions.

:::leanStatement "Multivalued inverse-function relations"
```anchor arcsinValues (module := LMLF.Blueprint.Elementary.Section424)
def arcsinValues (z : ℂ) : Set ℂ := {w | Complex.sin w = z}
```
```anchor arccosValues (module := LMLF.Blueprint.Elementary.Section424)
def arccosValues (z : ℂ) : Set ℂ := {w | Complex.cos w = z}
```
```anchor arctanValues (module := LMLF.Blueprint.Elementary.Section424)
def arctanValues (z : ℂ) : Set ℂ :=
  {w | Complex.cos w ≠ 0 ∧ Complex.tan w = z}
```
```anchor arccotValues (module := LMLF.Blueprint.Elementary.Section424)
def arccotValues (z : ℂ) : Set ℂ :=
  {w | Complex.sin w ≠ 0 ∧ Complex.cot w = z}
```
```anchor signedValueSum (module := LMLF.Blueprint.Elementary.Section424)
/-- DLMF 4.24.E13--E17: signed sum of two multivalued value sets. -/
def signedValueSum (A B : Set ℂ) (σ : ℂ) : Set ℂ :=
  {w | ∃ a ∈ A, ∃ b ∈ B, w = a + σ * b}
```
```anchor arcsinAdditionValues (module := LMLF.Blueprint.Elementary.Section424)
/-- DLMF 4.24.E13: all right-hand inverse-sine addition values. -/
def arcsinAdditionValues (u v σ : ℂ) : Set ℂ :=
  {w | ∃ ru rv : ℂ, ru ^ 2 = 1 - u ^ 2 ∧ rv ^ 2 = 1 - v ^ 2 ∧
    w ∈ arcsinValues (u * rv + σ * v * ru)}
```
```anchor arccosAdditionValues (module := LMLF.Blueprint.Elementary.Section424)
/-- DLMF 4.24.E14: all right-hand inverse-cosine addition values. -/
def arccosAdditionValues (u v σ : ℂ) : Set ℂ :=
  {w | ∃ ru rv : ℂ, ru ^ 2 = 1 - u ^ 2 ∧ rv ^ 2 = 1 - v ^ 2 ∧
    w ∈ arccosValues (u * v - σ * ru * rv)}
```
```anchor arctanAdditionValues (module := LMLF.Blueprint.Elementary.Section424)
/-- DLMF 4.24.E15: all right-hand inverse-tangent addition values. -/
def arctanAdditionValues (u v σ : ℂ) : Set ℂ :=
  {w | 1 - σ * u * v ≠ 0 ∧
    w ∈ arctanValues ((u + σ * v) / (1 - σ * u * v))}
```
```anchor mixedArcsinArccosAdditionValues (module := LMLF.Blueprint.Elementary.Section424)
/-- DLMF 4.24.E16: both mixed inverse-sine/cosine right-hand value sets. -/
def mixedArcsinArccosAdditionValues (u v σ : ℂ) : Set ℂ :=
  {w | ∃ ru rv : ℂ, ru ^ 2 = 1 - u ^ 2 ∧ rv ^ 2 = 1 - v ^ 2 ∧
    (w ∈ arcsinValues (u * v + σ * ru * rv) ∨
      w ∈ arccosValues (v * ru - σ * u * rv))}
```
```anchor mixedArctanArccotAdditionValues (module := LMLF.Blueprint.Elementary.Section424)
/-- DLMF 4.24.E17: both mixed inverse-tangent/cotangent value sets. -/
def mixedArctanArccotAdditionValues (u v σ : ℂ) : Set ℂ :=
  {w | v - σ * u ≠ 0 ∧ u * v + σ ≠ 0 ∧
    (w ∈ arctanValues ((u * v + σ) / (v - σ * u)) ∨
      w ∈ arccotValues ((v - σ * u) / (u * v + σ)))}
```
:::

::::dlmfEntry "4.24.13" "https://dlmf.nist.gov/4.24.E13"
$$`\operatorname{Arcsin}u\mathbin{\pm}\operatorname{Arcsin}v=
\operatorname{Arcsin}\left(u(1-v^2)^{1/2}\mathbin{\pm}v(1-u^2)^{1/2}\right).`

Both inverse-sine values and both square-root choices are retained.  The
membership equivalence below gives the source equality of value sets in both
directions.

:::leanStatement "Multivalued inverse-sine addition"
```anchor dlmf_4_24_13 (module := LMLF.Blueprint.Elementary.Section424)
theorem dlmf_4_24_13 (u v σ w : ℂ) (hσ : σ = 1 ∨ σ = -1) :
    w ∈ signedValueSum (arcsinValues u) (arcsinValues v) σ ↔
      w ∈ arcsinAdditionValues u v σ
```
:::
::::

::::dlmfEntry "4.24.14" "https://dlmf.nist.gov/4.24.E14"
$$`\operatorname{Arccos}u\mathbin{\pm}\operatorname{Arccos}v=
\operatorname{Arccos}\left(uv\mathbin{\mp}\{(1-u^2)(1-v^2)\}^{1/2}\right).`

The opposite sign in the right-hand square-root term is represented by the
minus sign in `u*v - σ*ru*rv`.

:::leanStatement "Multivalued inverse-cosine addition"
```anchor dlmf_4_24_14 (module := LMLF.Blueprint.Elementary.Section424)
theorem dlmf_4_24_14 (u v σ w : ℂ) (hσ : σ = 1 ∨ σ = -1) :
    w ∈ signedValueSum (arccosValues u) (arccosValues v) σ ↔
      w ∈ arccosAdditionValues u v σ
```
:::
::::

::::dlmfEntry "4.24.15" "https://dlmf.nist.gov/4.24.E15"
$$`\operatorname{Arctan}u\mathbin{\pm}\operatorname{Arctan}v=
\operatorname{Arctan}\frac{u\mathbin{\pm}v}{1\mathbin{\mp}uv}.`

The denominator must be nonzero.  No principal-value simplification is made:
the value relation retains the possible integer-`π` branches of the source.

:::leanStatement "Multivalued inverse-tangent addition"
```anchor dlmf_4_24_15 (module := LMLF.Blueprint.Elementary.Section424)
theorem dlmf_4_24_15 (u v σ w : ℂ) (hσ : σ = 1 ∨ σ = -1)
    (hden : 1 - σ * u * v ≠ 0) :
    w ∈ signedValueSum (arctanValues u) (arctanValues v) σ ↔
      w ∈ arctanAdditionValues u v σ
```
:::
::::

::::dlmfEntry "4.24.16" "https://dlmf.nist.gov/4.24.E16"
$$`\begin{aligned}
\operatorname{Arcsin}u\mathbin{\pm}\operatorname{Arccos}v
 &=\operatorname{Arcsin}\left(uv\mathbin{\pm}\{(1-u^2)(1-v^2)\}^{1/2}\right)\\
 &=\operatorname{Arccos}\left(v(1-u^2)^{1/2}\mathbin{\mp}u(1-v^2)^{1/2}\right).
\end{aligned}`

The Lean relation records both right-hand descriptions, with independent
square-root witnesses and the same signed sum on the left.

:::leanStatement "Mixed inverse-sine and inverse-cosine addition"
```anchor dlmf_4_24_16 (module := LMLF.Blueprint.Elementary.Section424)
theorem dlmf_4_24_16 (u v σ w : ℂ) (hσ : σ = 1 ∨ σ = -1) :
    w ∈ signedValueSum (arcsinValues u) (arccosValues v) σ ↔
      w ∈ mixedArcsinArccosAdditionValues u v σ
```
:::
::::

::::dlmfEntry "4.24.17" "https://dlmf.nist.gov/4.24.E17"
$$`\begin{aligned}
\operatorname{Arctan}u\mathbin{\pm}\operatorname{Arccot}v
 &=\operatorname{Arctan}\frac{uv\mathbin{\pm}1}{v\mathbin{\mp}u}\\
 &=\operatorname{Arccot}\frac{v\mathbin{\mp}u}{uv\mathbin{\pm}1}.
\end{aligned}`

The two displayed fractions are reciprocal descriptions of the same
multivalued addition.  Both denominators are excluded in the Lean relation, so
totalized division does not erase either source domain condition.

:::leanStatement "Mixed inverse-tangent and inverse-cotangent addition"
```anchor dlmf_4_24_17 (module := LMLF.Blueprint.Elementary.Section424)
theorem dlmf_4_24_17 (u v σ w : ℂ) (hσ : σ = 1 ∨ σ = -1)
    (hden₁ : v - σ * u ≠ 0) (hden₂ : u * v + σ ≠ 0) :
    w ∈ signedValueSum (arctanValues u) (arccotValues v) σ ↔
      w ∈ mixedArctanArccotAdditionValues u v σ
```
:::
::::
