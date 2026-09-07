import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section425
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.25 Continued Fractions" =>
%%%
tag := "chapter-4-section-25"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.25"
Source: NIST Digital Library of Mathematical Functions, §4.25.
:::

# §4.25 Continued Fractions
%%%
number := false
%%%

Section 4.25 records five continued fractions for the tangent and inverse
trigonometric functions.  Each display below is represented by explicit
numerator and denominator streams.  A depth `d` convergent retains the first
`d+1` entries, and the corresponding `Tendsto` statement gives the meaning of
the infinite nesting.  The inverse functions use their principal branches; the
cut conditions are written directly in terms of real and imaginary parts.

:::leanStatement "Lean · finite continued-fraction convergents"
```anchor continuedFractionTail (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
def continuedFractionTail (numerator denominator : ℕ → ℂ) (offset depth : ℕ) : ℂ :=
  match depth with
  | 0 => 0
  | n + 1 => numerator offset /
      (denominator offset + continuedFractionTail numerator denominator (offset + 1) n)
```

```anchor continuedFractionConvergent (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
def continuedFractionConvergent (numerator denominator : ℕ → ℂ) (depth : ℕ) : ℂ :=
  continuedFractionTail numerator denominator 0 (depth + 1)
```
:::

::::dlmfEntry "4.25.1" "https://dlmf.nist.gov/4.25.E1"
$$`\tan z=\cfrac{z}{1-\cfrac{z^2}{3-\cfrac{z^2}{5-\cfrac{z^2}{7-\cdots}}}}.`
The numerator stream begins with `z` and then repeats `-z²`; the denominator
stream is `1,3,5,7,…`.  The source excludes every tangent pole
`z=(2k+1)π/2`, expressed in Lean by the explicit integer-indexed predicate.

:::leanStatement "Lean · tangent continued fraction"
```anchor tangentFractionNumerator (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
def tangentFractionNumerator (z : ℂ) : ℕ → ℂ
  | 0 => z
  | _ + 1 => -z ^ 2
```

```anchor oddFractionDenominator (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
def oddFractionDenominator : ℕ → ℂ := fun n => (2 * n + 1 : ℕ)
```

```anchor tangentPole (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
def tangentPole (k : ℤ) : ℂ := ((2 * k + 1 : ℤ) : ℂ) * (Real.pi : ℂ) / 2
```

```anchor dlmf_4_25_1 (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
theorem dlmf_4_25_1 {z : ℂ} (hpole : ∀ k : ℤ, z ≠ tangentPole k) :
    Tendsto
        (fun depth =>
          continuedFractionConvergent (tangentFractionNumerator z)
            oddFractionDenominator depth)
        atTop (nhds (Complex.tan z)) := by
  sorry
```
:::
::::

::::dlmfEntry "4.25.2" "https://dlmf.nist.gov/4.25.E2"
$$`\tan(az)=\cfrac{a\tan z}{1+\cfrac{(1-a^2)\tan^2z}{3+\cfrac{(4-a^2)\tan^2z}{5+\cfrac{(9-a^2)\tan^2z}{7+\cdots}}}}.`
Here `a` may be real or complex.  The source requires
`|Re z| < π/2` and excludes the poles of `tan(az)`.  The first numerator is
`a tan z`, followed by `((n+1)²-a²)tan²z`; the denominators are again the odd
positive integers.

:::leanStatement "Lean · scaled tangent continued fraction"
```anchor scaledTangentFractionNumerator (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
def scaledTangentFractionNumerator (a z : ℂ) : ℕ → ℂ
  | 0 => a * Complex.tan z
  | n + 1 => (((n + 1 : ℕ) : ℂ) ^ 2 - a ^ 2) * Complex.tan z ^ 2
```

```anchor scaledTangentFractionDenominator (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
def scaledTangentFractionDenominator : ℕ → ℂ := oddFractionDenominator
```

```anchor dlmf_4_25_2 (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
theorem dlmf_4_25_2 {a z : ℂ} (hz : |z.re| < Real.pi / 2)
    (hpole : ∀ k : ℤ, a * z ≠ tangentPole k) :
    Tendsto
        (fun depth =>
          continuedFractionConvergent (scaledTangentFractionNumerator a z)
            scaledTangentFractionDenominator depth)
        atTop (nhds (Complex.tan (a * z))) := by
  sorry
```
:::
::::

::::dlmfEntry "4.25.3" "https://dlmf.nist.gov/4.25.E3"
$$`\frac{\arcsin z}{\sqrt{1-z^2}}=\cfrac{z}{1-\cfrac{1\cdot2z^2}{3-\cfrac{1\cdot2z^2}{5-\cfrac{3\cdot4z^2}{7-\cdots}}}}.`
The successive negative numerators are the products `1·2`, `3·4`, and so on,
and the denominators are odd.  DLMF places the identity in the open cut plane
for principal `arcsin`, namely the complex plane with the real rays
`(-∞,-1]` and `[1,∞)` removed.  The Lean branch is the standard logarithmic
formula for principal arcsine, and the cut is stated as a direct condition.

:::leanStatement "Lean · arcsine continued fraction"
```anchor arcsineFractionNumerator (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
def arcsineFractionNumerator (z : ℂ) : ℕ → ℂ
  | 0 => z
  | n + 1 => -(((2 * (n + 1) - 1 : ℕ) : ℂ) *
      ((2 * (n + 1) : ℕ) : ℂ) * z ^ 2)
```

```anchor arcsineFractionDenominator (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
def arcsineFractionDenominator : ℕ → ℂ := oddFractionDenominator
```

```anchor principalArcsin (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
def principalArcsin (z : ℂ) : ℂ :=
  -Complex.I * Complex.log (Complex.sqrt (1 - z ^ 2) + Complex.I * z)
```

```anchor dlmf_4_25_3 (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
theorem dlmf_4_25_3 {z : ℂ}
    (hcut : ¬(z.im = 0 ∧ (z.re ≤ -1 ∨ 1 ≤ z.re))) :
    Tendsto
        (fun depth =>
          continuedFractionConvergent (arcsineFractionNumerator z)
            arcsineFractionDenominator depth)
        atTop
        (nhds (principalArcsin z / Complex.sqrt (1 - z ^ 2))) := by
  sorry
```
:::
::::

::::dlmfEntry "4.25.4" "https://dlmf.nist.gov/4.25.E4"
$$`\arctan z=\cfrac{z}{1+\cfrac{z^2}{3+\cfrac{4z^2}{5+\cfrac{9z^2}{7+\cfrac{16z^2}{9+\cdots}}}}}.`
The noninitial numerators are `1²z²,2²z²,3²z²,…`, with odd denominators.
The principal arctangent is analytic in the open cut plane obtained by removing
the imaginary rays `i[1,∞)` and `i(-∞,-1]`; this is exactly the displayed
real/imaginary-part condition below.

:::leanStatement "Lean · arctangent continued fraction"
```anchor arctangentFractionNumerator (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
def arctangentFractionNumerator (z : ℂ) : ℕ → ℂ
  | 0 => z
  | n + 1 => (((n + 1 : ℕ) : ℂ) ^ 2) * z ^ 2
```

```anchor arctangentFractionDenominator (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
def arctangentFractionDenominator : ℕ → ℂ := oddFractionDenominator
```

```anchor principalArctan (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
def principalArctan (z : ℂ) : ℂ :=
  Complex.I / 2 * Complex.log ((Complex.I + z) / (Complex.I - z))
```

```anchor dlmf_4_25_4 (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
theorem dlmf_4_25_4 {z : ℂ}
    (hcut : ¬(z.re = 0 ∧ (z.im ≤ -1 ∨ 1 ≤ z.im))) :
    Tendsto
        (fun depth =>
          continuedFractionConvergent (arctangentFractionNumerator z)
            arctangentFractionDenominator depth)
        atTop (nhds (principalArctan z)) := by
  sorry
```
:::
::::

::::dlmfEntry "4.25.5" "https://dlmf.nist.gov/4.25.E5"
$$`e^{2a\arctan(1/z)}=1+\cfrac{2a}{z-a+\cfrac{a^2+1}{3z+\cfrac{a^2+4}{5z+\cfrac{a^2+9}{7z+\cdots}}}}.`
The first denominator is `z-a`, while the later ones are `3z,5z,7z,…`;
the corresponding numerators are `2a` and `a²+n²` for `n=1,2,3,…`.  DLMF
uses the open cut plane for principal `arccot z`, which is the branch represented
here as `arctan(1/z)`: after inversion its removed set is the imaginary segment
`[-i,i]`.  The statement therefore makes both `z ≠ 0` and that segment exclusion
explicit.

:::leanStatement "Lean · exponential arctangent continued fraction"
```anchor exponentialArctanFractionNumerator (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
def exponentialArctanFractionNumerator (a : ℂ) : ℕ → ℂ
  | 0 => 2 * a
  | n + 1 => a ^ 2 + (((n + 1 : ℕ) : ℂ) ^ 2)
```

```anchor exponentialArctanFractionDenominator (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
def exponentialArctanFractionDenominator (a z : ℂ) : ℕ → ℂ
  | 0 => z - a
  | n + 1 => ((2 * (n + 1) + 1 : ℕ) : ℂ) * z
```

```anchor dlmf_4_25_5 (module := LMLF.Blueprint.Elementary.Section425) -showProofStates
theorem dlmf_4_25_5 {a z : ℂ} (hz : z ≠ 0)
    (hcut : ¬(z.re = 0 ∧ (-1 ≤ z.im ∧ z.im ≤ 1))) :
    Tendsto
        (fun depth =>
          1 + continuedFractionConvergent
            (exponentialArctanFractionNumerator a)
            (exponentialArctanFractionDenominator a z) depth)
        atTop
        (nhds (Complex.exp (2 * a * principalArctan (1 / z)))) := by
  sorry
```
:::
::::

The five displays are the complete numbered content of the page.  The first two
use Mathlib's complex tangent directly.  The last three expose the principal
inverse-trigonometric branches as logarithmic expressions so that the DLMF cut
planes remain visible in the hypotheses rather than being hidden behind an
unspecified branch convention.
