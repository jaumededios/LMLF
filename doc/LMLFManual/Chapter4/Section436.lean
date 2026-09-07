import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section436
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual
open LMLF.Blueprint.Elementary.Section436

set_option verso.exampleProject "."

#doc (Manual) "§4.36 Infinite Products and Partial Fractions" =>
%%%
tag := "chapter-4-section-36"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.36"
Source: NIST Digital Library of Mathematical Functions, §4.36.
:::

# §4.36 Infinite Products and Partial Fractions
%%%
number := false
%%%

All variables are complex.  E1 and E2 are interpreted as limits of the natural
finite products, with factors ordered by increasing positive integer index.
E3–E5 are likewise limits of finite partial-fraction sums; the pole sets are
stated explicitly, so no divergent totalized expression is identified with a
meromorphic value.  The source notes that these formulas follow from the
trigonometric products and partial fractions of §4.22 after replacing `z` by
`i z`.

::::dlmfEntry "4.36.1" "https://dlmf.nist.gov/4.36.E1"
$$`\sinh z=z\prod_{n=1}^{\infty}\left(1+\frac{z^2}{n^2\pi^2}\right)`$$

The finite approximant `sinhProduct z N` retains the source's order and the
limit statement records convergence for every complex `z`.
:::leanStatement "Sine-hyperbolic product"
```anchor dlmf_4_36_1 (module := LMLF.Blueprint.Elementary.Section436)
theorem dlmf_4_36_1 (z : ℂ) :
    Tendsto (sinhProduct z) atTop (nhds (Complex.sinh z)) := by sorry
```
:::
::::

::::dlmfEntry "4.36.2" "https://dlmf.nist.gov/4.36.E2"
$$`\cosh z=\prod_{n=1}^{\infty}\left(1+\frac{4z^2}{(2n-1)^2\pi^2}\right)`$$

The odd positive integers index the factors, and `coshProduct` makes that
ordering explicit before taking the limit.
:::leanStatement "Cosh product"
```anchor dlmf_4_36_2 (module := LMLF.Blueprint.Elementary.Section436)
theorem dlmf_4_36_2 (z : ℂ) :
    Tendsto (coshProduct z) atTop (nhds (Complex.cosh z)) := by sorry
```
:::
::::

::::dlmfEntry "4.36.3" "https://dlmf.nist.gov/4.36.E3"
$$`\coth z=\frac1z+2z\sum_{n=1}^{\infty}\frac1{z^2+n^2\pi^2},\quad z\ne n\pi i.`$$

The displayed partial fractions converge away from every zero of `sinh`; the
finite approximant uses the positive-index order and the Lean target is the
explicit quotient `cosh z / sinh z`.
:::leanStatement "Coth partial fractions"
```anchor dlmf_4_36_3 (module := LMLF.Blueprint.Elementary.Section436)
theorem dlmf_4_36_3 (z : ℂ) (h : ∀ k : ℤ, z ≠ (k : ℂ) * (Real.pi : ℂ) * Complex.I) :
    Tendsto (cothPartial z) atTop (nhds (Complex.cosh z / Complex.sinh z)) := by sorry
```
:::
::::

::::dlmfEntry "4.36.4" "https://dlmf.nist.gov/4.36.E4"
$$`\operatorname{csch}^2z=\sum_{n=-\infty}^{\infty}\frac1{(z-n\pi i)^2}`$$

The symmetric finite sum `cschSqPartial z N` ranges from `-N` through `N`.
This ordering is part of the convergence convention, and all lattice poles are
excluded.
:::leanStatement "Symmetric csch-square partial fractions"
```anchor dlmf_4_36_4 (module := LMLF.Blueprint.Elementary.Section436)
theorem dlmf_4_36_4 (z : ℂ) (h : ∀ k : ℤ, z ≠ (k : ℂ) * (Real.pi : ℂ) * Complex.I) :
    Tendsto (cschSqPartial z) atTop (nhds ((1 / Complex.sinh z) ^ 2)) := by sorry
```
:::
::::

::::dlmfEntry "4.36.5" "https://dlmf.nist.gov/4.36.E5"
$$`\operatorname{csch} z=\frac1z+2z\sum_{n=1}^{\infty}\frac{(-1)^n}{z^2+n^2\pi^2}`$$

The alternating positive-index partial fractions converge on the same
pole-free domain as E3.  The finite `cschPartial` approximants avoid assigning
a value to the singular lattice.
:::leanStatement "Alternating csch partial fractions"
```anchor dlmf_4_36_5 (module := LMLF.Blueprint.Elementary.Section436)
theorem dlmf_4_36_5 (z : ℂ) (h : ∀ k : ℤ, z ≠ (k : ℂ) * (Real.pi : ℂ) * Complex.I) :
    Tendsto (cschPartial z) atTop (nhds (1 / Complex.sinh z)) := by sorry
```
:::
::::
