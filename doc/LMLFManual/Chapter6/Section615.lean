import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section615
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section615
set_option verso.exampleProject "."

#doc (Manual) "§6.15 Sums" =>
%%%
tag := "chapter-6-section-15"
%%%

:::dlmfChapter "https://dlmf.nist.gov/6.15"
Source: NIST Digital Library of Mathematical Functions, §6.15.
:::

# §6.15 Sums
%%%
number := false
%%%

This page records four convergent sums involving the cosine integral Ci and
the sine-integral tail si. The summation index begins at n=1; the Lean terms
use the equivalent n+1 indexing over ℕ, so the denominator in the si sums is
never zero. The positive-real values come from the principal definitions in
§6.2: positiveCi x is the principal Ci(x), and positiveSi x is Si(x)-π/2,
namely si(x). Each declaration uses HasSum, recording both convergence and
the displayed value.

::::dlmfEntry "Section context" "https://dlmf.nist.gov/6.15#p1"
DLMF presents the four sums as a group. The source displays and corresponding
reusable Lean statements follow.
::::

::::dlmfEntry "Cosine-integral sum at π" "https://dlmf.nist.gov/6.15.E1"
$$`\sum_{n=1}^{\infty}\operatorname{Ci}(\pi n)
=\frac12(\ln 2-\gamma)`
For the positive real multiples of π, the principal Ci terms sum to the real
constant on the right.
:::leanStatement "DLMF 6.15.E1"
```anchor dlmf_6_15_1 (module := LMLF.Blueprint.ExponentialIntegrals.Section615)
theorem dlmf_6_15_1 :
    HasSum ciPiTerm
      (((Real.log 2 - Real.eulerMascheroniConstant : ℝ) : ℂ) / 2)
```
:::
::::

::::dlmfEntry "Sine-integral-tail sum at π" "https://dlmf.nist.gov/6.15.E2"
$$`\sum_{n=1}^{\infty}\frac{\operatorname{si}(\pi n)}{n}
=\frac{\pi}{2}(\ln\pi-1)`
The denominator is the positive integer n, and the principal sine-integral
tail is evaluated at the positive points π n.
:::leanStatement "DLMF 6.15.E2"
```anchor dlmf_6_15_2 (module := LMLF.Blueprint.ExponentialIntegrals.Section615)
theorem dlmf_6_15_2 :
    HasSum siPiTerm
      ((Real.pi : ℂ) / 2 * ((Real.log Real.pi - 1 : ℝ) : ℂ))
```
:::
::::

::::dlmfEntry "Alternating cosine-integral sum at 2π" "https://dlmf.nist.gov/6.15.E3"
$$`\sum_{n=1}^{\infty}(-1)^n\operatorname{Ci}(2\pi n)
=1-\ln 2-\frac12\gamma`
The alternating sign is part of each term, and the argument is twice the
positive integer multiple of π.
:::leanStatement "DLMF 6.15.E3"
```anchor dlmf_6_15_3 (module := LMLF.Blueprint.ExponentialIntegrals.Section615)
theorem dlmf_6_15_3 :
    HasSum alternatingCiTwoPiTerm
      (((1 - Real.log 2 - Real.eulerMascheroniConstant : ℝ) : ℂ))
```
:::
::::

::::dlmfEntry "Alternating sine-integral-tail sum at 2π" "https://dlmf.nist.gov/6.15.E4"
$$`\sum_{n=1}^{\infty}(-1)^n\frac{\operatorname{si}(2\pi n)}{n}
=\pi\left(\frac32\ln 2-1\right)`
This final identity combines the alternating sign, positive denominator, and
2π n arguments before summing.
:::leanStatement "DLMF 6.15.E4"
```anchor dlmf_6_15_4 (module := LMLF.Blueprint.ExponentialIntegrals.Section615)
theorem dlmf_6_15_4 :
    HasSum alternatingSiTwoPiTerm
      ((Real.pi : ℂ) * ((3 / 2 * Real.log 2 - 1 : ℝ) : ℂ))
```
:::
::::

::::dlmfEntry "Source note" "https://dlmf.nist.gov/6.15#info"
The section notes Slavić (1974) for these and related sine/cosine-integral
sums.
::::

::::dlmfEntry "Further sums" "https://dlmf.nist.gov/6.15#p2"
For additional sums, DLMF cites Fempl (1960), Hansen (1975), Harris (2000),
Prudnikov et al. (1986b), and Slavić (1974). Those references are part of
the source context; the four displayed identities above are the formulas
covered on this page.
::::
