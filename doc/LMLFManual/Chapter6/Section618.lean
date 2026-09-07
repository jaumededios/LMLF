import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section618
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section618
set_option verso.exampleProject "."

#doc (Manual) "§6.18 Methods of Computation" =>
%%%
tag := "chapter-6-section-18"
%%%
:::dlmfChapter "https://dlmf.nist.gov/6.18"
Source: NIST Digital Library of Mathematical Functions, §6.18, Methods of Computation.
:::

# §6.18 Methods of Computation
%%%
number := false
%%%

This section surveys numerical methods and records the auxiliary-function
recurrence in a typed, convergence-aware form. The appropriate method depends
on scale, cancellation, phase, and whether a function is evaluated by a
convergent series, an asymptotic expansion, quadrature, or a continued
fraction.

## Main functions
%%%
number := false
%%%

::::dlmfEntry "6.18(i) series methods" "https://dlmf.nist.gov/6.18#i.p1"
For small or moderate values of `x` and `|z|`, the power-series methods of
[§6.6](https://dlmf.nist.gov/6.6) and the spherical-Bessel series of
[§6.10(ii)](https://dlmf.nist.gov/6.10#ii) are available. The spherical-Bessel
series generally converges more rapidly; except for
[6.10.6](https://dlmf.nist.gov/6.10.E6), it also avoids cancellation when
`z=x>0`.
::::

::::dlmfEntry "6.18(i) large-argument methods" "https://dlmf.nist.gov/6.18#i.p2"
For large `x` or `|z|`, inverse-factorial series
([§6.10(i)](https://dlmf.nist.gov/6.10#i)) and asymptotic expansions
([§6.12](https://dlmf.nist.gov/6.12)) are available, with exponential
improvement increasing attainable asymptotic accuracy. Other phase ranges can
be covered by the continuation formulas of
[§6.4](https://dlmf.nist.gov/6.4).
::::

::::dlmfEntry "6.18(i) quadrature methods" "https://dlmf.nist.gov/6.18#i.p3"
Quadrature of integral representations is another effective method. In
particular, the Gauss–Laguerre and Gauss–Legendre formulas of
[§3.5(v)](https://dlmf.nist.gov/3.5#v) apply to suitable representations,
including [6.2.2](https://dlmf.nist.gov/6.2.E2); the source points to Todd
(1954), Tseng and Lee (1998), and Tooper and Mark (1968) for applications.
::::

::::dlmfEntry "6.18(i) continued fraction" "https://dlmf.nist.gov/6.18#i.p4"
The continued fraction [6.9.1](https://dlmf.nist.gov/6.9.E1) is useful when
`|z|` is bounded away from the origin, although convergence becomes slow near
the negative real axis.
::::

## Auxiliary functions
%%%
number := false
%%%

::::dlmfEntry "6.18(ii) auxiliary-function methods" "https://dlmf.nist.gov/6.18#ii.p1"
Power series ([§6.6](https://dlmf.nist.gov/6.6)), asymptotic expansions
([§6.12](https://dlmf.nist.gov/6.12)), and quadrature (see
[§6.14](https://dlmf.nist.gov/6.14)) also compute the auxiliary functions
`f` and `g`. Acton (1974) gives the recurrence procedure used here. For
`n=0,1,2,\dots`, the three integrals are represented on the right half-plane
`Re z>0`; the Lean `RightHalfPlane` subtype packages this convergence
hypothesis once, so the canonical maps below do not repeat a proof argument.
::::

The displayed values are the ordinary Bochner integrals over the positive
ray. Their convergence as improper integrals is recorded separately, so the
definition remains a direct mathematical object while the convergence claim is
available to later theorems.
:::leanStatement "Canonical positive-ray values"
```anchor recurrenceA (module := LMLF.Blueprint.ExponentialIntegrals.Section618)
noncomputable def recurrenceA (z : RightHalfPlane) (n : ℕ) : ℂ :=
  ∫ t in Ioi (0 : ℝ), recurrenceAIntegrand z.1 n t
```
```anchor recurrenceB (module := LMLF.Blueprint.ExponentialIntegrals.Section618)
noncomputable def recurrenceB (z : RightHalfPlane) (n : ℕ) : ℂ :=
  ∫ t in Ioi (0 : ℝ), recurrenceBIntegrand z.1 n t
```
```anchor recurrenceC (module := LMLF.Blueprint.ExponentialIntegrals.Section618)
noncomputable def recurrenceC (z : RightHalfPlane) (n : ℕ) : ℂ :=
  ∫ t in Ioi (0 : ℝ), recurrenceCIntegrand z.1 n t
```
:::

::::dlmfEntry "6.18.1" "https://dlmf.nist.gov/6.18.E1"
$$`A_n=\int_0^\infty\frac{te^{-zt}}{1+t^2}\left(\frac{t^2}{1+t^2}\right)^n dt,\quad B_n=\int_0^\infty\frac{e^{-zt}}{1+t^2}\left(\frac{t^2}{1+t^2}\right)^n dt,\quad C_n=\int_0^\infty e^{-zt}\left(\frac{t^2}{1+t^2}\right)^n dt`$$
:::leanStatement "Improper-integral definitions of A, B, and C"
```anchor dlmf_6_18_1 (module := LMLF.Blueprint.ExponentialIntegrals.Section618)
theorem dlmf_6_18_1 (z : RightHalfPlane) :
    ∀ n : ℕ,
      HasImproperIntegral (recurrenceAIntegrand z.1 n) 0 (recurrenceA z n) ∧
        HasImproperIntegral (recurrenceBIntegrand z.1 n) 0 (recurrenceB z n) ∧
        HasImproperIntegral (recurrenceCIntegrand z.1 n) 0 (recurrenceC z n)
```
:::
::::

::::dlmfEntry "6.18(ii) base auxiliary values" "https://dlmf.nist.gov/6.18#ii.p1"
Thus the base auxiliary values are `f(z)=B₀(z)` and `g(z)=A₀(z)`. For
`n=1,2,3,\dots`, integration identities give the downward recurrence:
::::

::::dlmfEntry "6.18.2" "https://dlmf.nist.gov/6.18.E2"
$$`A_{n-1}=A_n+\frac{z}{2n}C_n,\quad B_{n-1}=\frac{2nB_n+zA_{n-1}}{2n-1},\quad C_{n-1}=C_n+B_{n-1}`$$
:::leanStatement "Recurrences for A, B, and C"
```anchor dlmf_6_18_2 (module := LMLF.Blueprint.ExponentialIntegrals.Section618)
theorem dlmf_6_18_2 (z : RightHalfPlane) (n : ℕ)
    (hn : 1 ≤ n) :
    auxiliaryF z.1 = recurrenceB z 0 ∧ auxiliaryG z.1 = recurrenceA z 0 ∧
      recurrenceA z (n - 1) =
        recurrenceA z n + z.1 / (2 * n) * recurrenceC z n ∧
      recurrenceB z (n - 1) =
        (2 * n * recurrenceB z n + z.1 * recurrenceA z (n - 1)) /
          (2 * n - 1) ∧
      recurrenceC z (n - 1) =
        recurrenceC z n + recurrenceB z (n - 1)
```
:::
::::

::::dlmfEntry "6.18(ii) Miller initialization" "https://dlmf.nist.gov/6.18#ii.p1"
The initial values `A₀`, `B₀`, and `C₀` can be computed by Miller's
backward algorithm, as described in [§3.6(iii)](https://dlmf.nist.gov/3.6#iii):
start at an arbitrary large index with `(A_N,B_N,C_N)=(1,0,0)` and normalize
by `C₀=1/z`.
::::

## Zeros
%%%
number := false
%%%

::::dlmfEntry "6.18(iii) zeros" "https://dlmf.nist.gov/6.18#iii.p1"
Zeros of `Ci(x)` and `si(x)` can be computed to high precision by Newton's
rule ([§3.8(ii)](https://dlmf.nist.gov/3.8#ii)), using the values supplied as
initial approximations by [§6.13.2](https://dlmf.nist.gov/6.13.E2).
::::

## Other references
%%%
number := false
%%%

::::dlmfEntry "6.18(iv) other references" "https://dlmf.nist.gov/6.18#iv.p1"
For a comprehensive survey of computational methods for the functions treated
in Chapter 6, the source cites van der Laan and Temme (1984, Chapter IV).
::::

end LMLFManual.Chapter6
