import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section68
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section68
set_option verso.exampleProject "."

#doc (Manual) "§6.8 Inequalities" =>
%%%
tag := "chapter-6-section-8"
%%%

:::dlmfChapter "https://dlmf.nist.gov/6.8"
Source: NIST Digital Library of Mathematical Functions, §6.8.
:::

# §6.8 Inequalities
%%%
number := false
%%%

Throughout this section `x` is real and positive.  The declarations use the
real part of the canonical positive-ray §6.2 map `realE1`; write
`scaledE1 x = eˣ E₁(x)` for this direct specialization.  Each display below gives a strict
lower and upper bound for that same quantity; the inequalities are not
asymptotic equivalences.  The common hypothesis `0 < x` is explicit in every
declaration.

::::dlmfEntry "§6.8 source note" "https://dlmf.nist.gov/6.8#info"
The source attributes E1 to Gautschi (1959b), and E2–E3 to Luke (1969b,
p. 201).
::::

::::dlmfEntry "§6.8 standing domain" "https://dlmf.nist.gov/6.8#p1"
All three inequalities use the standing real-positive domain `x > 0`.
::::

::::dlmfEntry "Logarithmic bounds" "https://dlmf.nist.gov/6.8.E1"
Gautschi's bound is

$$`\frac{1}{2}\ln\left(1+\frac{2}{x}\right)<e^xE_{1}(x)<\ln\left(1+\frac{1}{x}\right),\quad x>0.`$$

:::leanStatement "6.8.E1 logarithmic enclosure"
```anchor dlmf_6_8_1 (module := LMLF.Blueprint.ExponentialIntegrals.Section68)
theorem dlmf_6_8_1 (x : ℝ) (hx : 0 < x) :
    (1 / 2 : ℝ) * Real.log (1 + 2 / x) < scaledE1 x ∧
      scaledE1 x < Real.log (1 + 1 / x)
```
:::
::::

::::dlmfEntry "First rational bounds" "https://dlmf.nist.gov/6.8.E2"
The first rational enclosure is

$$`\frac{x}{x+1}<xe^xE_{1}(x)<\frac{x+1}{x+2},\quad x>0.`$$

:::leanStatement "6.8.E2 rational enclosure"
```anchor dlmf_6_8_2 (module := LMLF.Blueprint.ExponentialIntegrals.Section68)
theorem dlmf_6_8_2 (x : ℝ) (hx : 0 < x) :
    x / (x + 1) < x * scaledE1 x ∧
      x * scaledE1 x < (x + 1) / (x + 2)
```
:::
::::

::::dlmfEntry "Second rational bounds" "https://dlmf.nist.gov/6.8.E3"
The sharper rational enclosure is

$$`\frac{x(x+3)}{x^2+4x+2}<xe^xE_{1}(x)<\frac{x^2+5x+2}{x^2+6x+6},\quad x>0.`$$

:::leanStatement "6.8.E3 sharper rational enclosure"
```anchor dlmf_6_8_3 (module := LMLF.Blueprint.ExponentialIntegrals.Section68)
theorem dlmf_6_8_3 (x : ℝ) (hx : 0 < x) :
    x * (x + 3) / (x ^ 2 + 4 * x + 2) < x * scaledE1 x ∧
      x * scaledE1 x < (x ^ 2 + 5 * x + 2) / (x ^ 2 + 6 * x + 6)
```
:::
::::

The page cites Gautschi (1959b) for E1 and Luke (1969b, p. 201) for E2 and
E3.  The neighboring pages are [§6.7 Integral Representations](https://dlmf.nist.gov/6.7)
and [§6.9 Continued Fraction](https://dlmf.nist.gov/6.9).

end LMLFManual.Chapter6
