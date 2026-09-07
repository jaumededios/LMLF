import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section433
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.33 Maclaurin Series and Laurent Series" =>
%%%
tag := "chapter-4-section-33"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.33"
Source: NIST Digital Library of Mathematical Functions, §4.33.
:::

# §4.33 Maclaurin Series and Laurent Series
%%%
number := false
%%%

All variables are complex.  The first two displays are entire Maclaurin
series, with odd and even powers indexed explicitly.  The third is the
principal Taylor expansion of `tanh`; its radius is the distance from zero to
the nearest poles, `|z| < π/2`.  DLMF writes the odd coefficients using
Bernoulli numbers; the Lean statement uses the equivalent canonical Taylor
coefficient `(tanh)⁽ⁿ⁾(0)/n!`, while the first terms and indexing remain visible
in the source display below.  The source also notes that the corresponding
trigonometric expansions follow by replacing `z` with `i z` and using the
imaginary-argument identities of §4.28.

::::dlmfEntry "4.33.1" "https://dlmf.nist.gov/4.33.E1"
$$`\sinh z=\sum_{n=0}^{\infty}\frac{z^{2n+1}}{(2n+1)!}`$$

The odd factorial series converges for every complex `z`; its first terms are
`z + z³/3! + z⁵/5! + ⋯`.

:::leanStatement "Entire odd sinh series"
```anchor dlmf_4_33_1 (module := LMLF.Blueprint.Elementary.Section433)
theorem dlmf_4_33_1 (z : ℂ) :
    Complex.sinh z = ∑' n : ℕ, z ^ (2 * n + 1) / (Nat.factorial (2 * n + 1) : ℂ) := by sorry
```
:::
::::

::::dlmfEntry "4.33.2" "https://dlmf.nist.gov/4.33.E2"
$$`\cosh z=\sum_{n=0}^{\infty}\frac{z^{2n}}{(2n)!}`$$

The even series is also entire, beginning `1 + z²/2! + z⁴/4! + ⋯`.

:::leanStatement "Entire even cosh series"
```anchor dlmf_4_33_2 (module := LMLF.Blueprint.Elementary.Section433)
theorem dlmf_4_33_2 (z : ℂ) :
    Complex.cosh z = ∑' n : ℕ, z ^ (2 * n) / (Nat.factorial (2 * n) : ℂ) := by sorry
```
:::
::::

::::dlmfEntry "4.33.3" "https://dlmf.nist.gov/4.33.E3"
$$`\tanh z=z-\frac{z^3}{3}+\frac{2z^5}{15}-\frac{17z^7}{315}+\cdots,
\qquad |z|<\frac{\pi}{2}.`$$

The Bernoulli-number form in the source has general odd coefficient
`2^(2n)(2^(2n)-1) B_(2n)/(2n)!` multiplying `z^(2n-1)`; the pole pair at
`±iπ/2` gives the sharp convergence disk.  The Taylor-coefficient statement
is equivalent and is reusable without introducing a second Bernoulli-number
vocabulary into Mathlib.

:::leanStatement "Tanh Taylor series on its convergence disk"
```anchor dlmf_4_33_3 (module := LMLF.Blueprint.Elementary.Section433)
theorem dlmf_4_33_3 (z : ℂ) (hz : ‖z‖ < Real.pi / 2) :
    Complex.tanh z =
      ∑' n : ℕ, (iteratedDeriv n Complex.tanh 0 / (Nat.factorial n : ℂ)) * z ^ n := by sorry
```
:::
::::

The DLMF page points to §24.2(i) for Bernoulli numbers and to §4.28.8–§4.28.13
for the substitution that produces the corresponding trigonometric series.
