import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section442
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual
set_option verso.exampleProject "."

#doc (Manual) "§4.42 Solution of Triangles" =>
%%%
tag := "chapter-4-section-42"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.42"
Source: NIST Digital Library of Mathematical Functions, §4.42.
:::

# §4.42 Solution of Triangles
%%%
number := false
%%%

The first subsection treats planar right triangles, with `a` the height
opposite `A`, `b` the base, and `c` the hypotenuse.  The second treats ordinary
planar triangles, with `a` and `c` side lengths and `b` the base; all side lengths are positive and the three angles lie in
`(0, π)` and sum to `π`, so the displayed ratios have no zero sine
denominators.  The final subsection uses arc lengths and angles in `(0, π)`
for a nondegenerate spherical triangle.  The accompanying figures in the
source fix these side/angle conventions; the formal domain predicates make
positivity, triangle inequalities, and the spherical angle-sum condition
explicit.  The compatibility fields tie those measurements to the angles,
rather than allowing an unrelated range-filtered tuple.  Degenerate and
ambiguous cases are therefore outside these exact identities rather than
silently totalized.

::::dlmfEntry "Figure 4.42.1" "https://dlmf.nist.gov/4.42.F1"
Figure 4.42.1 is the source's planar right-triangle diagram.  Its labels are
`a` (height), `b` (base), and `c` (hypotenuse), with `A` the acute angle and
`C` the right angle.  The formal right-triangle data uses this opposite/base/
hypotenuse convention.
::::

::::dlmfEntry "Figure 4.42.2" "https://dlmf.nist.gov/4.42.F2"
Figure 4.42.2 is the source's planar-triangle diagram.  It labels `a` and `c`
as side lengths, `b` as the base, and `A`, `B`, `C` as the corresponding
angles.  Positivity, triangle inequalities, angle sum, and side-angle
compatibility are retained in the formal data.
::::

::::dlmfEntry "Figure 4.42.3" "https://dlmf.nist.gov/4.42.F3"
Figure 4.42.3 is the source's spherical-triangle diagram.  Lower-case `a`,
`b`, `c` are arc lengths and upper-case `A`, `B`, `C` are angles.  The formal
domain restricts arcs and angles to `(0, π)`, imposes the spherical angle-sum
condition, excludes the tangent poles used in E11, and records the side/angle
cosine and sine-law compatibility.
::::

## Planar right triangles

The right-triangle ratios are the elementary definitions of sine, cosine, and
tangent in the source figure.  The hypotenuse is positive, and the acute-angle
hypothesis excludes the degenerate endpoints; the `arcsin` compatibility
records that `A` is the angle opposite height `a`.

::::dlmfEntry "4.42.1" "https://dlmf.nist.gov/4.42.E1"
$$`\sin A=\frac{a}{c}=\frac{1}{\csc A}`$$
:::leanStatement "Right-triangle sine ratio"
```anchor dlmf_4_42_1 (module := LMLF.Blueprint.Elementary.Section442)
theorem dlmf_4_42_1 {a b c A : ℝ} (h : rightTriangleData a b c A) :
    Real.sin A = a / c
```
:::
::::

::::dlmfEntry "4.42.2" "https://dlmf.nist.gov/4.42.E2"
$$`\cos A=\frac{b}{c}=\frac{1}{\sec A}`$$
:::leanStatement "Right-triangle cosine ratio"
```anchor dlmf_4_42_2 (module := LMLF.Blueprint.Elementary.Section442)
theorem dlmf_4_42_2 {a b c A : ℝ} (h : rightTriangleData a b c A) :
    Real.cos A = b / c
```
:::
::::

::::dlmfEntry "4.42.3" "https://dlmf.nist.gov/4.42.E3"
$$`\tan A=\frac{a}{b}=\frac{1}{\cot A}`$$
:::leanStatement "Right-triangle tangent ratio"
```anchor dlmf_4_42_3 (module := LMLF.Blueprint.Elementary.Section442)
theorem dlmf_4_42_3 {a b A : ℝ} (h : rightTriangleData a b (Real.sqrt (a ^ 2 + b ^ 2)) A) :
    Real.tan A = a / b
```
:::
::::

## Planar triangles

For a nondegenerate planar triangle, E4 is the law of sines, E5 the law of
cosines, and E6 its projection form.  E7 gives both the included-angle and
Heron area expressions; `s=(a+b+c)/2` is the semiperimeter.

::::dlmfEntry "4.42.4" "https://dlmf.nist.gov/4.42.E4"
$$`\frac{a}{\sin A}=\frac{b}{\sin B}=\frac{c}{\sin C}`$$
:::leanStatement "Planar law of sines"
```anchor dlmf_4_42_4 (module := LMLF.Blueprint.Elementary.Section442)
theorem dlmf_4_42_4 {a b c A B C : ℝ} (h : planarTriangleData a b c A B C) :
    a / Real.sin A = b / Real.sin B ∧ b / Real.sin B = c / Real.sin C
```
:::
::::

::::dlmfEntry "4.42.5" "https://dlmf.nist.gov/4.42.E5"
$$`c^2=a^2+b^2-2ab\cos C`$$
:::leanStatement "Planar law of cosines"
```anchor dlmf_4_42_5 (module := LMLF.Blueprint.Elementary.Section442)
theorem dlmf_4_42_5 {a b c A B C : ℝ}
    (h : planarTriangleData a b c A B C) :
    c ^ 2 = a ^ 2 + b ^ 2 - 2 * a * b * Real.cos C
```
:::
::::

::::dlmfEntry "4.42.6" "https://dlmf.nist.gov/4.42.E6"
$$`a=b\cos C+c\cos B`$$
:::leanStatement "Planar projection identity"
```anchor dlmf_4_42_6 (module := LMLF.Blueprint.Elementary.Section442)
theorem dlmf_4_42_6 {a b c B C : ℝ} (h : planarTriangleData a b c (Real.pi - B - C) B C) :
    a = b * Real.cos C + c * Real.cos B
```
:::
::::

::::dlmfEntry "4.42.7" "https://dlmf.nist.gov/4.42.E7"
$$`\operatorname{area}=\frac12bc\sin A=\sqrt{s(s-a)(s-b)(s-c)}`$$
:::leanStatement "Planar triangle area"
```anchor dlmf_4_42_7 (module := LMLF.Blueprint.Elementary.Section442)
theorem dlmf_4_42_7 {a b c A B C : ℝ} (h : planarTriangleData a b c A B C) :
    let s := (a + b + c) / 2
    (b * c * Real.sin A) / 2 = Real.sqrt (s * (s - a) * (s - b) * (s - c))
```
:::
::::

## Spherical triangles

For spherical triangles, lower-case letters denote arc lengths and upper-case
letters angles.  E8 and E12 are the two cosine laws, E9 is the sine law, and
E10–E11 are useful rearrangements.  Since every angle and arc is strictly
between `0` and `π`, all sine denominators are nonzero.  E11 additionally
excludes `b=π/2` and `B=π/2`, where Lean's totalized tangent would have a zero
denominator; no branch choice or ambiguous inverse-trigonometric solution is
being silently selected.

::::dlmfEntry "4.42.8" "https://dlmf.nist.gov/4.42.E8"
$$`\cos a=\cos b\cos c+\sin b\sin c\cos A`$$
:::leanStatement "Spherical law of cosines for sides"
```anchor dlmf_4_42_8 (module := LMLF.Blueprint.Elementary.Section442)
theorem dlmf_4_42_8 {a b c A B C : ℝ} (h : sphericalTriangleData a b c A B C) :
    Real.cos a = Real.cos b * Real.cos c + Real.sin b * Real.sin c * Real.cos A
```
:::
::::

::::dlmfEntry "4.42.9" "https://dlmf.nist.gov/4.42.E9"
$$`\frac{\sin A}{\sin a}=\frac{\sin B}{\sin b}=\frac{\sin C}{\sin c}`$$
:::leanStatement "Spherical law of sines"
```anchor dlmf_4_42_9 (module := LMLF.Blueprint.Elementary.Section442)
theorem dlmf_4_42_9 {a b c A B C : ℝ} (h : sphericalTriangleData a b c A B C) :
    Real.sin A / Real.sin a = Real.sin B / Real.sin b ∧
      Real.sin B / Real.sin b = Real.sin C / Real.sin c
```
:::
::::

::::dlmfEntry "4.42.10" "https://dlmf.nist.gov/4.42.E10"
$$`\sin a\cos B=\cos b\sin c-\sin b\cos c\cos A`$$
:::leanStatement "Spherical mixed sine-cosine identity"
```anchor dlmf_4_42_10 (module := LMLF.Blueprint.Elementary.Section442)
theorem dlmf_4_42_10 {a b c A B C : ℝ}
    (h : sphericalTriangleData a b c A B C) :
    Real.sin a * Real.cos B = Real.cos b * Real.sin c -
      Real.sin b * Real.cos c * Real.cos A
```
:::
::::

::::dlmfEntry "4.42.11" "https://dlmf.nist.gov/4.42.E11"
$$`\cos a\cos C=\sin a\cot b-\sin C\cot B`$$
:::leanStatement "Spherical cotangent identity"
```anchor dlmf_4_42_11 (module := LMLF.Blueprint.Elementary.Section442)
theorem dlmf_4_42_11 {a b c A B C : ℝ} (h : sphericalTriangleData a b c A B C) :
    Real.cos a * Real.cos C = Real.sin a / Real.tan b - Real.sin C / Real.tan B
```
:::
::::

::::dlmfEntry "4.42.12" "https://dlmf.nist.gov/4.42.E12"
$$`\cos A=-\cos B\cos C+\sin B\sin C\cos a`$$
:::leanStatement "Spherical law of cosines for angles"
```anchor dlmf_4_42_12 (module := LMLF.Blueprint.Elementary.Section442)
theorem dlmf_4_42_12 {a b c A B C : ℝ} (h : sphericalTriangleData a b c A B C) :
    Real.cos A = -Real.cos B * Real.cos C + Real.sin B * Real.sin C * Real.cos a
```
:::
::::

The source figures 4.42.1–4.42.3 illustrate these conventions; they carry no
additional numbered identity.  All twelve numbered displays are represented
above, with the real-positive specialization recorded explicitly in the
coverage manifest.
