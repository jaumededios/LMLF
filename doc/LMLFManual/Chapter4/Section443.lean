import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section443
import LMLFManual.Components
open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.Elementary.Section443
set_option verso.exampleProject "."
#doc (Manual) "§4.43 Cubic Equations" =>
%%%
tag := "chapter-4-section-43"
%%%
:::dlmfChapter "https://dlmf.nist.gov/4.43"
Source: NIST Digital Library of Mathematical Functions, §4.43.
:::
# §4.43 Cubic Equations
%%%
number := false
%%%
The section reduces a cubic to the depressed equation z^3 + p z + q = 0, with real
constants p nonzero and q. Scale factors are selected in the relevant sign
regime, and the phase is chosen on the appropriate real or complex branch.
::::dlmfEntry "4.43.1" "https://dlmf.nist.gov/4.43.E1"
For p < 0, A = sqrt(-4p/3); for p > 0, B = sqrt(4p/3).
:::leanStatement "DLMF 4.43.E1"
```anchor dlmf_4_43_1 (module := LMLF.Blueprint.Elementary.Section443)
theorem dlmf_4_43_1 {p : ℝ} (hp : p ≠ 0) :
    (p < 0 → |sineScale p| = Real.sqrt (-4 * p / 3)) ∧
    (0 < p → |hyperbolicScale p| = Real.sqrt (4 * p / 3))
```
:::
::::
::::dlmfEntry "4.43.2" "https://dlmf.nist.gov/4.43.E2"
The roots are trigonometric when 4p^3 + 27q^2 <= 0, hyperbolic-cosine when
p < 0, q < 0 and the discriminant is positive, and hyperbolic-sine when p > 0.
The three 2pi/3-separated branches are retained; in the last two regimes
one root is real and the other two form a conjugate pair.
:::leanStatement "DLMF 4.43.E2"
```anchor dlmf_4_43_2 (module := LMLF.Blueprint.Elementary.Section443)
theorem dlmf_4_43_2 (p q : ℝ) :
    (p < 0 ∧ cubicDiscriminant p q ≤ 0 →
      ∃ a : ℝ, Real.sin (3 * a) = 4 * q / sineScale p ^ 3 ∧
        depressedCubic p q (cubicSineRoot p a) = 0 ∧
        depressedCubic p q (cubicSineRoot p (a + 2 * Real.pi / 3)) = 0 ∧
        depressedCubic p q (cubicSineRoot p (a + 4 * Real.pi / 3)) = 0) ∧
    (p < 0 ∧ q < 0 ∧ 0 < cubicDiscriminant p q →
      ∃ a : ℂ, Complex.cosh (3 * a) = (-4 * q / sineScale p ^ 3 : ℂ) ∧
        depressedCubic p q (cubicCoshRoot p a) = 0 ∧
        depressedCubic p q (cubicCoshRoot p (a + 2 * Real.pi * Complex.I / 3)) = 0 ∧
        depressedCubic p q (cubicCoshRoot p (a + 4 * Real.pi * Complex.I / 3)) = 0) ∧
    (0 < p → ∃ a : ℂ, Complex.sinh (3 * a) = (-4 * q / hyperbolicScale p ^ 3 : ℂ) ∧
        depressedCubic p q (cubicSinhRoot p a) = 0 ∧
        depressedCubic p q (cubicSinhRoot p (a + 2 * Real.pi * Complex.I / 3)) = 0 ∧
        depressedCubic p q (cubicSinhRoot p (a + 4 * Real.pi * Complex.I / 3)) = 0)
```
:::
::::
::::dlmfEntry "4.43.E2(a)" "https://dlmf.nist.gov/4.43.E2"
The three real sine roots occur when p < 0 and the discriminant is nonpositive.
:::leanStatement "DLMF 4.43.E2(a)"
```anchor dlmf_4_43_2a (module := LMLF.Blueprint.Elementary.Section443)
theorem dlmf_4_43_2a {p q a : ℝ}
    (hp : p < 0) (hd : cubicDiscriminant p q ≤ 0)
    (ha : Real.sin (3 * a) = 4 * q / sineScale p ^ 3) :
    depressedCubic p q (cubicSineRoot p a) = 0 ∧
    depressedCubic p q (cubicSineRoot p (a + 2 * Real.pi / 3)) = 0 ∧
    depressedCubic p q (cubicSineRoot p (a + 4 * Real.pi / 3)) = 0
```
:::
::::
::::dlmfEntry "4.43.E2(b)" "https://dlmf.nist.gov/4.43.E2"
The hyperbolic-cosine triple applies when p and q are negative and the
discriminant is positive.
:::leanStatement "DLMF 4.43.E2(b)"
```anchor dlmf_4_43_2b (module := LMLF.Blueprint.Elementary.Section443)
theorem dlmf_4_43_2b {p q : ℝ} {a : ℂ}
    (hp : p < 0) (hq : q < 0) (hd : 0 < cubicDiscriminant p q)
    (ha : Complex.cosh (3 * a) = (-4 * q / sineScale p ^ 3 : ℂ)) :
    depressedCubic p q (cubicCoshRoot p a) = 0 ∧
    depressedCubic p q (cubicCoshRoot p (a + 2 * Real.pi * Complex.I / 3)) = 0 ∧
    depressedCubic p q (cubicCoshRoot p (a + 4 * Real.pi * Complex.I / 3)) = 0
```
:::
::::
::::dlmfEntry "4.43.E2(c)" "https://dlmf.nist.gov/4.43.E2"
For p positive the hyperbolic-sine triple gives the remaining real-plus-conjugate
case.
:::leanStatement "DLMF 4.43.E2(c)"
```anchor dlmf_4_43_2c (module := LMLF.Blueprint.Elementary.Section443)
theorem dlmf_4_43_2c {p q : ℝ} {a : ℂ}
    (hp : 0 < p)
    (ha : Complex.sinh (3 * a) = (-4 * q / hyperbolicScale p ^ 3 : ℂ)) :
    depressedCubic p q (cubicSinhRoot p a) = 0 ∧
    depressedCubic p q (cubicSinhRoot p (a + 2 * Real.pi * Complex.I / 3)) = 0 ∧
    depressedCubic p q (cubicSinhRoot p (a + 4 * Real.pi * Complex.I / 3)) = 0
```
:::
::::
::::dlmfEntry "4.43 note" "https://dlmf.nist.gov/4.43#info@annotation-note-1"
The section note identifies the classical source Hobson (1928, p. 335) and
places cubic equations among the applications of elementary functions.
::::
::::dlmfEntry "4.43 erratum" "https://dlmf.nist.gov/4.43#info@editorial-change-note-1"
The section erratum replaces the opening discussion and removes obsolete C and
D constants; the corrected discriminant cases are the ones stated above.
::::
::::dlmfEntry "4.43 introduction" "https://dlmf.nist.gov/4.43#p1"
The introductory prose sets p and q real, assumes p nonzero, and reduces the
general cubic to z^3 + p z + q = 0.
::::
::::dlmfEntry "4.43 E1 erratum" "https://dlmf.nist.gov/4.43#E1.info@editorial-change-note-1"
The E1 erratum records that its former auxiliary constants were eliminated;
the scale-factor convention above is the corrected one.
::::
::::dlmfEntry "4.43 E2 erratum" "https://dlmf.nist.gov/4.43#E2.info@editorial-change-note-1"
The E2 erratum corrects all three root cases, including their discriminant and
sign conditions.
::::
::::dlmfEntry "4.43 case a" "https://dlmf.nist.gov/4.43#I3.ix1.p1"
In case (a), the three sine phases give three real roots when
4 p^3 + 27 q^2 is nonpositive.
::::
::::dlmfEntry "4.43 case b" "https://dlmf.nist.gov/4.43#I3.ix2.p1"
In case (b), p and q are negative and the positive-discriminant regime gives
one real root and a conjugate complex pair through hyperbolic cosine.
::::
::::dlmfEntry "4.43 case c" "https://dlmf.nist.gov/4.43#I3.ix3.p1"
In case (c), p is positive and the hyperbolic-sine phases likewise describe
one real root and a conjugate pair.
::::
::::dlmfEntry "4.43 conclusion" "https://dlmf.nist.gov/4.43#p2"
The concluding prose distinguishes the all-real case from the two
real-plus-conjugate-pair cases and points to the general complex discussion.
::::
The introductory note cites Hobson and the erratum records removal of obsolete
auxiliary constants and correction of all three cases. The first case has
three real roots with phases a, a + 2pi/3, a + 4pi/3 and
sin(3a) = 4q/A^3. The second uses cosh(3a) = -4q/A^3, and the third
sinh(3a) = -4q/B^3. These are branch-indexed descriptions, and denominators
are used only in sign regimes where the scale is nonzero. The final paragraph
emphasizes the real-versus-complex distinction without identifying branches
across the discriminant boundary.
