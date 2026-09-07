import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section439
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.Elementary.Section439

set_option verso.exampleProject "."

#doc (Manual) "§4.39 Continued Fractions" =>
%%%
tag := "chapter-4-section-39"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.39"
Source: NIST Digital Library of Mathematical Functions, §4.39.
:::

# §4.39 Continued Fractions
%%%
number := false
%%%

The three continued fractions in this section are read from the bottom up:
the finite tails below give genuine truncations, and the theorems state their
limits rather than identifying a finite expression with an assumed limit.
The first fraction is meromorphic and its excluded points are the odd
imaginary half-period poles of `tanh`.  The inverse-hyperbolic fractions use
the principal branches on the open cut planes shown in Figure 4.37.1(i) and
(iii), respectively.

## Hyperbolic tangent

The pole set and the finite bottom-up construction are explicit in Lean.  At
depth `n`, `tanhTail 0 n z` ends at the denominator `2n+3`, so the convergent
contains exactly the first `n+1` odd denominators after the leading `1`.

:::leanStatement "DLMF 4.39.E1"
```anchor dlmf_4_39_tanhPole (module := LMLF.Blueprint.Elementary.Section439)
/-- DLMF 4.39.E1: the pole set for the principal hyperbolic tangent. -/
def tanhPole (m : ℤ) : ℂ :=
  (((2 * m + 1 : ℤ) : ℂ) * (Real.pi : ℂ) / 2) * Complex.I
```
:::

:::leanStatement "DLMF 4.39.E1"
```anchor dlmf_4_39_tanhPoleSet (module := LMLF.Blueprint.Elementary.Section439)
/-- DLMF 4.39.E1: all odd imaginary half-period poles. -/
def tanhPoleSet : Set ℂ := Set.range tanhPole
```
:::

:::leanStatement "DLMF 4.39.E1"
```anchor dlmf_4_39_tanhTail (module := LMLF.Blueprint.Elementary.Section439)
/-- DLMF 4.39.E1: a finite odd-denominator tail for `tanh`. -/
def tanhTail : ℕ → ℕ → ℂ → ℂ
  | level, 0, _z => ((2 * level + 3 : ℕ) : ℂ)
  | level, n + 1, z => ((2 * level + 3 : ℕ) : ℂ) + z ^ 2 / tanhTail (level + 1) n z
```
:::

:::leanStatement "DLMF 4.39.E1"
```anchor dlmf_4_39_tanhConvergent (module := LMLF.Blueprint.Elementary.Section439)
/-- DLMF 4.39.E1: the `n`th finite convergent for `tanh`. -/
def tanhConvergent (z : ℂ) (n : ℕ) : ℂ :=
  z / (1 + z ^ 2 / tanhTail 0 n z)
```
:::

::::dlmfEntry "4.39.1" "https://dlmf.nist.gov/4.39.E1"
The DLMF continued fraction is
$$`\operatorname{tanh}z=\frac{z}{1+\frac{z^2}{3+\frac{z^2}{5+\frac{z^2}{7+\cdots}}}}`$$
for complex `z` away from the poles
`z = ±(2m+1)π i/2`.  The `n`th Lean convergent retains the denominator `1`
and then the first `n+1` odd denominators beginning with `3`; its limit is
the canonical complex hyperbolic tangent (A&S 4.5.70).
:::leanStatement "DLMF 4.39.E1"
```anchor dlmf_4_39_1 (module := LMLF.Blueprint.Elementary.Section439)
/-- DLMF 4.39.E1: convergence of the finite `tanh` continued-fraction convergents. -/
theorem dlmf_4_39_1 (z : ℂ) (hz : z ∉ tanhPoleSet) :
    Tendsto (fun n : ℕ => tanhConvergent z n) atTop (𝓝 (Complex.tanh z)) := by sorry
```
:::
::::

## Inverse hyperbolic sine

The open cut plane and principal branch are represented directly, and the
finite tail exposes the repeated numerator sequence `(1·2),(1·2),(3·4),
(3·4),…` together with its odd denominators.

:::leanStatement "DLMF 4.39.E2"
```anchor dlmf_4_39_arcsinhCut (module := LMLF.Blueprint.Elementary.Section439)
/-- DLMF 4.39.E2: the open principal cut plane for `arcsinh`. -/
def arcsinhCut : Set ℂ := {z | ¬(z.re = 0 ∧ (1 ≤ z.im ∨ z.im ≤ -1))}
```
:::

:::leanStatement "DLMF 4.39.E2"
```anchor dlmf_4_39_principalArcsinh (module := LMLF.Blueprint.Elementary.Section439)
/-- DLMF 4.39.E2: the principal logarithmic branch of inverse hyperbolic sine. -/
def principalArcsinh (z : ℂ) : ℂ := Complex.log (z + Complex.sqrt (1 + z ^ 2))
```
:::

:::leanStatement "DLMF 4.39.E2"
```anchor dlmf_4_39_arcsinhNumerator (module := LMLF.Blueprint.Elementary.Section439)
/-- DLMF 4.39.E2: the repeated numerator pattern in the `arcsinh` fraction. -/
def arcsinhNumerator (level : ℕ) (z : ℂ) : ℂ :=
  (((2 * (level / 2) + 1 : ℕ) : ℂ) * ((2 * (level / 2) + 2 : ℕ) : ℂ)) * z ^ 2
```
:::

:::leanStatement "DLMF 4.39.E2"
```anchor dlmf_4_39_arcsinhTail (module := LMLF.Blueprint.Elementary.Section439)
/-- DLMF 4.39.E2: a finite tail for the `arcsinh` continued fraction. -/
def arcsinhTail : ℕ → ℕ → ℂ → ℂ
  | level, 0, _z => ((2 * level + 3 : ℕ) : ℂ)
  | level, n + 1, z =>
      ((2 * level + 3 : ℕ) : ℂ) + arcsinhNumerator level z / arcsinhTail (level + 1) n z
```
:::

:::leanStatement "DLMF 4.39.E2"
```anchor dlmf_4_39_arcsinhConvergent (module := LMLF.Blueprint.Elementary.Section439)
/-- DLMF 4.39.E2: the `n`th finite convergent for `arcsinh`. -/
def arcsinhConvergent (z : ℂ) (n : ℕ) : ℂ :=
  z / (1 + arcsinhNumerator 0 z / arcsinhTail 0 n z)
```
:::

::::dlmfEntry "4.39.2" "https://dlmf.nist.gov/4.39.E2"
On the open principal cut plane of [Figure 4.37.1(i)](https://dlmf.nist.gov/4.37#F1),
the source gives
$$`\frac{\operatorname{arcsinh}z}{\sqrt{1+z^2}}=\frac{z}{1+\frac{1\cdot2z^2}{3+\frac{1\cdot2z^2}{5+\frac{3\cdot4z^2}{7+\frac{3\cdot4z^2}{9+\cdots}}}}}`$$
where the square root and inverse hyperbolic sine are principal.  The Lean
tail uses the repeated numerator pattern `(1·2),(1·2),(3·4),(3·4),…`, and
convergence is stated to the explicit principal logarithmic branch divided by
the principal square root (A&S 4.6.36).
:::leanStatement "DLMF 4.39.E2"
```anchor dlmf_4_39_2 (module := LMLF.Blueprint.Elementary.Section439)
/-- DLMF 4.39.E2: convergence of the finite `arcsinh` continued-fraction convergents. -/
theorem dlmf_4_39_2 (z : ℂ) (hz : z ∈ arcsinhCut) :
    Tendsto (fun n : ℕ => arcsinhConvergent z n) atTop
      (𝓝 (principalArcsinh z / Complex.sqrt (1 + z ^ 2))) := by sorry
```
:::
::::

## Inverse hyperbolic tangent

Here the numerator stream is `1²,2²,3²,…`; the tail makes the alternating
minus signs and the odd denominators visible at every finite depth.

:::leanStatement "DLMF 4.39.E3"
```anchor dlmf_4_39_arctanhCut (module := LMLF.Blueprint.Elementary.Section439)
/-- DLMF 4.39.E3: the open principal cut plane for `arctanh`. -/
def arctanhCut : Set ℂ := {z | ¬(z.im = 0 ∧ (1 ≤ z.re ∨ z.re ≤ -1))}
```
:::

:::leanStatement "DLMF 4.39.E3"
```anchor dlmf_4_39_principalArctanh (module := LMLF.Blueprint.Elementary.Section439)
/-- DLMF 4.39.E3: the principal logarithmic branch of inverse hyperbolic tangent. -/
def principalArctanh (z : ℂ) : ℂ :=
  (Complex.log (1 + z) - Complex.log (1 - z)) / 2
```
:::

:::leanStatement "DLMF 4.39.E3"
```anchor dlmf_4_39_arctanhNumerator (module := LMLF.Blueprint.Elementary.Section439)
/-- DLMF 4.39.E3: the square numerator sequence in the `arctanh` fraction. -/
def arctanhNumerator (level : ℕ) (z : ℂ) : ℂ :=
  (((level + 1 : ℕ) : ℂ) ^ 2) * z ^ 2
```
:::

:::leanStatement "DLMF 4.39.E3"
```anchor dlmf_4_39_arctanhTail (module := LMLF.Blueprint.Elementary.Section439)
/-- DLMF 4.39.E3: a finite tail for the `arctanh` continued fraction. -/
def arctanhTail : ℕ → ℕ → ℂ → ℂ
  | level, 0, _z => ((2 * level + 3 : ℕ) : ℂ)
  | level, n + 1, z =>
      ((2 * level + 3 : ℕ) : ℂ) - arctanhNumerator level z / arctanhTail (level + 1) n z
```
:::

:::leanStatement "DLMF 4.39.E3"
```anchor dlmf_4_39_arctanhConvergent (module := LMLF.Blueprint.Elementary.Section439)
/-- DLMF 4.39.E3: the `n`th finite convergent for `arctanh`. -/
def arctanhConvergent (z : ℂ) (n : ℕ) : ℂ :=
  z / (1 - arctanhNumerator 0 z / arctanhTail 0 n z)
```
:::

::::dlmfEntry "4.39.3" "https://dlmf.nist.gov/4.39.E3"
On the open principal cut plane of [Figure 4.37.1(iii)](https://dlmf.nist.gov/4.37#F1),
the continued fraction is
$$`\operatorname{arctanh}z=\frac{z}{1-\frac{z^2}{3-\frac{4z^2}{5-\frac{9z^2}{7-\cdots}}}}`$$
and the squared numerators continue as `1²,2²,3²,…`.  The finite tails
therefore use the displayed minus signs and the limit is the principal
logarithmic branch of `arctanh` (A&S 4.6.35).
:::leanStatement "DLMF 4.39.E3"
```anchor dlmf_4_39_3 (module := LMLF.Blueprint.Elementary.Section439)
/-- DLMF 4.39.E3: convergence of the finite `arctanh` continued-fraction convergents. -/
theorem dlmf_4_39_3 (z : ℂ) (hz : z ∈ arctanhCut) :
    Tendsto (fun n : ℕ => arctanhConvergent z n) atTop (𝓝 (principalArctanh z)) := by sorry
```
:::
::::

For related continued fractions involving inverse hyperbolic functions, the
DLMF points to Lorentzen and Waadeland (1992, pp. 569–571) and Cuyt et al.
(2008, pp. 211–217).  The branch-cut conventions are inherited from the
principal inverse-hyperbolic functions in §4.37.
