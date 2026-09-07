import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section422
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

open scoped BigOperators Topology

set_option verso.exampleProject "."

#doc (Manual) "§4.22 Infinite Products and Partial Fractions" =>
%%%
tag := "chapter-4-section-22"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.22"
Source: NIST Digital Library of Mathematical Functions, §4.22.
:::

# §4.22 Infinite Products and Partial Fractions
%%%
number := false
%%%

The products below are genuine infinite products, represented by `HasProd`
with the natural-number summation filter.  The partial fractions use ordinary
infinite sums.  The bilateral sum in E4 uses an explicit filter of finite
integer intervals `[−N,N]`; this makes the symmetric limiting convention
literal.  All complex identities involving cotangent or cosecant exclude the
poles `z=nπ`.

:::leanStatement "Product and partial-fraction terms"
```anchor sineProductTerm (module := LMLF.Blueprint.Elementary.Section422)
def sineProductTerm (z : ℂ) (n : ℕ) : ℂ :=
  1 - z ^ 2 / (((n + 1 : ℕ) : ℂ) ^ 2 * (Real.pi : ℂ) ^ 2)
```
```anchor cosineProductTerm (module := LMLF.Blueprint.Elementary.Section422)
def cosineProductTerm (z : ℂ) (n : ℕ) : ℂ :=
  1 - 4 * z ^ 2 / (((2 * n + 1 : ℕ) : ℂ) ^ 2 * (Real.pi : ℂ) ^ 2)
```
```anchor sineProductValue (module := LMLF.Blueprint.Elementary.Section422)
def sineProductValue (z : ℂ) : ℂ :=
  if z = 0 then 1 else Complex.sin z / z
```
```anchor cotangentPartialFractionTerm (module := LMLF.Blueprint.Elementary.Section422)
def cotangentPartialFractionTerm (z : ℂ) (n : ℕ) : ℂ :=
  2 * z / (z ^ 2 - (n : ℂ) ^ 2 * (Real.pi : ℂ) ^ 2)
```
```anchor cosecantSquareTerm (module := LMLF.Blueprint.Elementary.Section422)
def cosecantSquareTerm (z : ℂ) (n : ℤ) : ℂ :=
  1 / (z - (n : ℂ) * (Real.pi : ℂ)) ^ 2
```
```anchor cosecantPartialFractionTerm (module := LMLF.Blueprint.Elementary.Section422)
def cosecantPartialFractionTerm (z : ℂ) (n : ℕ) : ℂ :=
  2 * z * (-1 : ℂ) ^ n / (z ^ 2 - (n : ℂ) ^ 2 * (Real.pi : ℂ) ^ 2)
```
```anchor symmetricIntegerSummation (module := LMLF.Blueprint.Elementary.Section422)
def symmetricIntegerSummation : SummationFilter ℤ where
  filter := Filter.map (fun N : ℕ ↦ Finset.Icc (-(N : ℤ)) (N : ℤ)) atTop
```
:::

::::dlmfEntry "4.22.1" "https://dlmf.nist.gov/4.22.E1"
$$`\sin z=z\prod_{n=1}^{\infty}\left(1-\frac{z^2}{n^2\pi^2}\right).`

For every complex `z`, sine is `z` times the convergent product of the
displayed factors.  The Lean product term is indexed from zero with `n+1`, so
its first factor is the source's `n=1` factor.  At `z=0` the normalized product
value is explicitly defined as `1`, preserving the entire identity rather than
dividing by zero.

:::leanStatement "Sine infinite product"
```anchor dlmf_4_22_1 (module := LMLF.Blueprint.Elementary.Section422)
theorem dlmf_4_22_1 (z : ℂ) :
    HasProd (fun n : ℕ ↦ sineProductTerm z n) (sineProductValue z) ∧
      Complex.sin z = z * sineProductValue z
```
:::
::::

::::dlmfEntry "4.22.2" "https://dlmf.nist.gov/4.22.E2"
$$`\cos z=\prod_{n=1}^{\infty}\left(1-\frac{4z^2}{(2n-1)^2\pi^2}\right).`

Cosine is the convergent product over the odd positive multiples of
`π/2`.  The natural index in Lean uses `2*n+1`, again beginning at the first
odd denominator.

:::leanStatement "Cosine infinite product"
```anchor dlmf_4_22_2 (module := LMLF.Blueprint.Elementary.Section422)
theorem dlmf_4_22_2 (z : ℂ) :
    HasProd (fun n : ℕ ↦ cosineProductTerm z n) (Complex.cos z)
```
:::
::::

::::dlmfEntry "4.22.3" "https://dlmf.nist.gov/4.22.E3"
$$`\cot z=\frac1z+2z\sum_{n=1}^{\infty}\frac1{z^2-n^2\pi^2},\qquad z\ne n\pi.`

Away from every integer multiple of `π`, cotangent has the displayed
partial-fraction expansion.  The Lean sum starts at `n+1`, matching the
source's positive lower limit, and the pole exclusion is quantified over all
integer multiples.

:::leanStatement "Cotangent partial fractions"
```anchor dlmf_4_22_3 (module := LMLF.Blueprint.Elementary.Section422)
theorem dlmf_4_22_3 {z : ℂ}
    (hz : ∀ n : ℤ, z ≠ (n : ℂ) * (Real.pi : ℂ)) :
    Complex.cot z = 1 / z + ∑' n : ℕ, cotangentPartialFractionTerm z (n + 1)
```
:::
::::

::::dlmfEntry "4.22.4" "https://dlmf.nist.gov/4.22.E4"
$$`\csc^2z=\sum_{n=-\infty}^{\infty}\frac1{(z-n\pi)^2}.`

The bilateral sum is taken symmetrically over integer indices, i.e. as the
limit of finite sums over `−N ≤ n ≤ N` along `symmetricIntegerSummation`.
This is an actual infinite sum, not a finite truncation, and the pole
exclusion keeps every denominator nonzero.

:::leanStatement "Bilateral cosecant-square partial fractions"
```anchor dlmf_4_22_4 (module := LMLF.Blueprint.Elementary.Section422)
theorem dlmf_4_22_4 {z : ℂ}
    (hz : ∀ n : ℤ, z ≠ (n : ℂ) * (Real.pi : ℂ)) :
    HasSum (L := symmetricIntegerSummation)
      (fun n : ℤ ↦ cosecantSquareTerm z n) ((1 / Complex.sin z) ^ 2)
```
:::
::::

::::dlmfEntry "4.22.5" "https://dlmf.nist.gov/4.22.E5"
$$`\csc z=\frac1z+2z\sum_{n=1}^{\infty}\frac{(-1)^n}{z^2-n^2\pi^2},\qquad z\ne n\pi.`

The corresponding cosecant partial fraction has alternating signs and the
same exclusion of all integer multiples of `π`.

:::leanStatement "Cosecant partial fractions"
```anchor dlmf_4_22_5 (module := LMLF.Blueprint.Elementary.Section422)
theorem dlmf_4_22_5 {z : ℂ}
    (hz : ∀ n : ℤ, z ≠ (n : ℂ) * (Real.pi : ℂ)) :
    1 / Complex.sin z = 1 / z + ∑' n : ℕ, cosecantPartialFractionTerm z (n + 1)
```
:::
::::
