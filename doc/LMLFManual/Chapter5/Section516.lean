import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section516
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§5.16 Sums" =>
%%%
tag := "chapter-5-section-16"
%%%

:::dlmfChapter "https://dlmf.nist.gov/5.16"
Source: NIST Digital Library of Mathematical Functions, §5.16.
:::

The two numbered displays in [DLMF §5.16](https://dlmf.nist.gov/5.16) sum
polygamma values at positive integers.  A summation index of type
`{n : ℕ // 1 ≤ n}` records the range `k = 1,2,\ldots` directly.  The first
display is conditionally convergent in its ordinary ordered sense, so it uses
Mathlib's built-in `SummationFilter.conditional` on this ordered index type;
this records the ordered partial sums, not a different summability method.  The
second display is absolutely convergent, so its default `HasSum` records the
same value independently of the ordering.

::::dlmfEntry "5.16.1" "https://dlmf.nist.gov/5.16.E1"
$$`\sum_{k=1}^{\infty}(-1)^k\psi'(k)=-\frac{\pi^2}{8}.`

The alternating trigamma values at the positive integers have sum `−π²/8`.

:::leanStatement "Alternating trigamma sum"
```anchor dlmf_5_16_1 (module := LMLF.Blueprint.Gamma.Section516) -showProofStates
theorem dlmf_5_16_1 :
    HasSum (L := SummationFilter.conditional {n : ℕ // 1 ≤ n})
      (fun k : {n : ℕ // 1 ≤ n} ↦
        (-1 : ℂ) ^ k.1 * polygamma 1 (k.1 : ℂ))
      (-(Real.pi : ℂ) ^ 2 / 8)
```
:::
::::

::::dlmfEntry "5.16.2" "https://dlmf.nist.gov/5.16.E2"
$$`\sum_{k=1}^{\infty}\frac{1}{k}\psi'(k+1)=\zeta(3)=-\frac12\psi''(1).`

Weighting the trigamma value at `k+1` by `1/k` gives the Riemann zeta value
`ζ(3)`, which is also `−ψ''(1)/2`.

:::leanStatement "Reciprocal-weighted trigamma sum"
```anchor dlmf_5_16_2 (module := LMLF.Blueprint.Gamma.Section516) -showProofStates
theorem dlmf_5_16_2 :
    HasSum
        (fun k : {n : ℕ // 1 ≤ n} ↦
          (1 : ℂ) / (k.1 : ℂ) * polygamma 1 ((k.1 + 1 : ℕ) : ℂ))
        (riemannZeta (3 : ℂ)) ∧
      riemannZeta (3 : ℂ) = -(1 / 2 : ℂ) * polygamma 2 (1 : ℂ)
```
:::
::::
