import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section515
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§5.15 Polygamma Functions" =>
%%%
tag := "chapter-5-section-15"
%%%

:::dlmfChapter "https://dlmf.nist.gov/5.15"
Source: NIST Digital Library of Mathematical Functions, §5.15.
:::

The polygamma functions are the successive derivatives of the digamma function:
`ψ⁽ⁿ⁾` denotes the `n`-th derivative, so `ψ′` is the trigamma function.  The
first seven displays below are stated over the complex numbers, with the source
domains made explicit.  The final two displays are sectorial complex asymptotics
in DLMF; their Lean statements use the positive-real restriction, where the
phase is zero and the source sector condition is automatically met for every
fixed `0 < δ ≤ π`.

::::dlmfEntry "5.15.1" "https://dlmf.nist.gov/5.15.E1"
$$`\psi ^\prime (z)=\sum _{k=0}^{\infty }\frac{1}{(k+z)^2},\qquad
z\ne 0,-1,-2,\ldots .`

For a complex argument away from the nonpositive integers, the trigamma value is
the reciprocal-square series beginning at `k=0`.  The Lean statement uses
`HasSum`, retaining both the convergence assertion and the value of the series.

:::leanStatement "Trigamma reciprocal-square series"
```anchor dlmf_5_15_1 (module := LMLF.Blueprint.Gamma.Section515)
theorem dlmf_5_15_1 {z : ℂ} (hz : ∀ k : ℕ, z ≠ -(k : ℂ)) :
    HasSum (fun k : ℕ ↦ 1 / ((k : ℂ) + z) ^ 2) (polygamma 1 z)
```
:::
::::

::::dlmfEntry "5.15.2" "https://dlmf.nist.gov/5.15.E2"
$$`\psi ^{(n)}(1)=(-1)^{n+1}n!\,\zeta (n+1),\qquad n=1,2,3,\ldots .`

At the unit argument, every positive-order polygamma is a signed factorial
multiple of the Riemann zeta value one order higher.  The natural-number
parameter is constrained by `1 ≤ n`, exactly expressing the source convention.

:::leanStatement "Polygamma values at one"
```anchor dlmf_5_15_2 (module := LMLF.Blueprint.Gamma.Section515)
theorem dlmf_5_15_2 (n : ℕ) (hn : 1 ≤ n) :
    polygamma n 1 =
      (-1 : ℂ) ^ (n + 1) * (n.factorial : ℂ) * riemannZeta (n + 1)
```
:::
::::

::::dlmfEntry "5.15.3" "https://dlmf.nist.gov/5.15.E3"
$$`\psi ^{(n)}\!\left(\frac12\right)=(-1)^{n+1}n!\,(2^{n+1}-1)\zeta (n+1),\qquad n=1,2,3,\ldots .`

At one half, the same signed factorial and zeta factor is multiplied by the
odd-part factor `2ⁿ⁺¹−1`.  The Lean expression keeps the value complex, as does
the surrounding polygamma vocabulary.

:::leanStatement "Polygamma values at one half"
```anchor dlmf_5_15_3 (module := LMLF.Blueprint.Gamma.Section515)
theorem dlmf_5_15_3 (n : ℕ) (hn : 1 ≤ n) :
    polygamma n (1 / 2 : ℂ) =
      (-1 : ℂ) ^ (n + 1) * (n.factorial : ℂ) *
        ((2 : ℂ) ^ (n + 1) - 1) * riemannZeta (n + 1)
```
:::
::::

::::dlmfEntry "5.15.4" "https://dlmf.nist.gov/5.15.E4"
$$`\psi ^\prime \!\left(n-\frac12\right)=\frac12\pi ^2-4\sum _{k=1}^{n-1}\frac{1}{(2k-1)^2},\qquad n=1,2,3,\ldots .`

The trigamma value at a positive half-integer is a finite correction to
`π²/2`: the correction contains the odd reciprocal squares through `2n−3`.
For `n=1` the indexed sum is empty, as prescribed by the source limits.

:::leanStatement "Trigamma at positive half-integers"
```anchor dlmf_5_15_4 (module := LMLF.Blueprint.Gamma.Section515)
theorem dlmf_5_15_4 (n : ℕ) (hn : 1 ≤ n) :
    polygamma 1 ((n : ℂ) - 1 / 2) =
      (Real.pi : ℂ) ^ 2 / 2 -
        4 * ∑ k ∈ Finset.Ico 1 n, 1 / ((2 * k - 1 : ℕ) : ℂ) ^ 2
```
:::
::::

::::dlmfEntry "5.15.5" "https://dlmf.nist.gov/5.15.E5"
$$`\psi ^{(n)}(z+1)=\psi ^{(n)}(z)+(-1)^n n!z^{-n-1},\qquad n=1,2,3,\ldots .`

Shifting the argument by one adds the signed reciprocal power shown in the
source.  The displayed domain excludes every nonpositive integer, so both the
polygamma values and the reciprocal power are evaluated away from their poles.

:::leanStatement "Polygamma recurrence"
```anchor dlmf_5_15_5 (module := LMLF.Blueprint.Gamma.Section515)
theorem dlmf_5_15_5 (n : ℕ) (hn : 1 ≤ n) {z : ℂ}
    (hz : ∀ k : ℕ, z ≠ -(k : ℂ)) :
    polygamma n (z + 1) =
      polygamma n z + (-1 : ℂ) ^ n * (n.factorial : ℂ) / z ^ (n + 1)
```
:::
::::

::::dlmfEntry "5.15.6" "https://dlmf.nist.gov/5.15.E6"
$$`\psi ^{(n)}(1-z)+(-1)^{n-1}\psi ^{(n)}(z)=(-1)^n\pi \,\frac{d^n}{dz^n}\cot (\pi z),\qquad n=1,2,3,\ldots .`

Reflection pairs the values at `z` and `1−z`.  The right side is the `n`-th
derivative, with respect to `z`, of `cot(πz)`, multiplied by the source factor
`(-1)ⁿπ`; the hypothesis excludes the integer poles of cotangent and the
corresponding polygamma terms.

:::leanStatement "Polygamma reflection"
```anchor dlmf_5_15_6 (module := LMLF.Blueprint.Gamma.Section515)
theorem dlmf_5_15_6 (n : ℕ) (hn : 1 ≤ n) {z : ℂ}
    (hz : ∀ k : ℤ, z ≠ (k : ℂ)) :
    polygamma n (1 - z) + (-1 : ℂ) ^ (n - 1) * polygamma n z =
      (-1 : ℂ) ^ n * (Real.pi : ℂ) * cotPiDerivative n z
```
:::
::::

::::dlmfEntry "5.15.7" "https://dlmf.nist.gov/5.15.E7"
$$`\psi ^{(n)}(mz)=\frac{1}{m^{n+1}}\sum _{k=0}^{m-1}\psi ^{(n)}\!\left(z+\frac{k}{m}\right),\qquad m,n=1,2,3,\ldots .`

The multiplication formula averages the `m` translated residue classes, with
the factor `m⁻⁽ⁿ⁺¹⁾`.  Requiring that `mz` avoid the nonpositive integers also
keeps every translated summand away from its pole, because multiplying a
translated pole equation by `m` produces a pole of the left-hand argument.

:::leanStatement "Polygamma multiplication"
```anchor dlmf_5_15_7 (module := LMLF.Blueprint.Gamma.Section515)
theorem dlmf_5_15_7 (n m : ℕ) (hn : 1 ≤ n) (hm : 1 ≤ m) {z : ℂ}
    (hz : ∀ k : ℕ, (m : ℂ) * z ≠ -(k : ℂ)) :
    polygamma n ((m : ℂ) * z) =
      1 / (m : ℂ) ^ (n + 1) *
        ∑ k ∈ Finset.range m, polygamma n (z + (k : ℂ) / (m : ℂ))
```
:::
::::

::::dlmfEntry "5.15.8" "https://dlmf.nist.gov/5.15.E8"
$$`\psi ^\prime (z)\sim \frac1z+\frac{1}{2z^2}+\sum _{k=1}^{\infty }\frac{B_{2k}}{z^{2k+1}},\qquad z\to\infty ,\quad |\operatorname{ph}z|\leq\pi-\delta .`

This is a Poincaré expansion in the source sector.  The Lean declaration
specializes to `x → +∞` on the positive real axis, where `ph x = 0`; its
indexed term function lists the two initial terms first and then the Bernoulli
terms beginning with `B₂/x³`; its zero-based tail index `k=2` corresponds to
the source index `j=1`.

:::leanStatement "Positive-real trigamma expansion"
```anchor dlmf_5_15_8 (module := LMLF.Blueprint.Gamma.Section515)
theorem dlmf_5_15_8 :
    (fun x : ℝ ↦ realPolygamma 1 x) ∼ₚ[atTop] trigammaAsymptoticTerm
```
:::
::::

::::dlmfEntry "5.15.9" "https://dlmf.nist.gov/5.15.E9"
$$`\psi ^{(n)}(z)\sim (-1)^{n-1}\!\left(\frac{(n-1)!}{z^n}+\frac{n!}{2z^{n+1}}+\sum _{k=1}^{\infty }\frac{(2k+n-1)!}{(2k)!}\frac{B_{2k}}{z^{2k+n}}\right),\quad z\to\infty ,\quad |\operatorname{ph}z|\leq\pi-\delta .`

For every positive order `n`, the same sectorial convention gives the general
polygamma expansion.  On the positive real axis the Lean term function records
the leading factorial term, the half-factorial term, and then the Bernoulli
series, with zero-based tail index `k=2` corresponding to source index `j=1`;
`1 ≤ n` preserves the source's order convention.  At `n=1`, the factorial
ratio simplifies to one, recovering the trigamma coefficients in 5.15.8.

:::leanStatement "Positive-real polygamma expansion"
```anchor dlmf_5_15_9 (module := LMLF.Blueprint.Gamma.Section515)
theorem dlmf_5_15_9 (n : ℕ) (hn : 1 ≤ n) :
    (fun x : ℝ ↦ realPolygamma n x) ∼ₚ[atTop] polygammaAsymptoticTerm n
```
:::
::::
