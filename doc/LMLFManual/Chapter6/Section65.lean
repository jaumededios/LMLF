import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section65
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section65
set_option verso.exampleProject "."

#doc (Manual) "§6.5 Further Interrelations" =>
%%%
tag := "chapter-6-section-5"
%%%

:::dlmfChapter "https://dlmf.nist.gov/6.5"
Source: NIST Digital Library of Mathematical Functions, §6.5.
:::

# §6.5 Further Interrelations
%%%
number := false
%%%

The first four formulas describe genuine one-sided limits of the canonical
principal `E₁` branch on its negative-real cut and their principal-value
average, then identify the canonical hyperbolic sine and cosine integrals.
They are stated for positive real `x`; the sign `σ=±1` records the
upper/lower limiting side and is not collapsed into a totalized value at the
cut.  E5–E6 use the canonical §6.2 functions directly at the rotated
arguments `±iz`, with `|arg z| < π/2` and `z ≠ 0`.  E7 uses the canonical
§6.2 auxiliary functions and principal `E₁` map, with both signs explicit.
The named `e1CutBoundary x σ` records the corresponding canonical limit
value, so E1 and E2 do not quantify arbitrary side-limit outputs.

::::dlmfEntry "6.5.1" "https://dlmf.nist.gov/6.5.E1"
$$`E_{1}(-x\pm i0)=-\operatorname{Ei}(x)\mp i\pi,\quad x>0`$$
:::leanStatement "E1 cut boundary values"
```anchor dlmf_6_5_1 (module := LMLF.Blueprint.ExponentialIntegrals.Section65)
theorem dlmf_6_5_1 (x σ : ℝ)
    (hx : 0 < x) (hσ : σ = 1 ∨ σ = -1) :
    E1Boundary x σ (e1CutBoundary x σ)
```
:::
::::

::::dlmfEntry "6.5.2" "https://dlmf.nist.gov/6.5.E2"
$$`\operatorname{Ei}(x)=-\tfrac12(E_{1}(-x+i0)+E_{1}(-x-i0)),\quad x>0`$$
:::leanStatement "Principal cut average"
```anchor dlmf_6_5_2 (module := LMLF.Blueprint.ExponentialIntegrals.Section65)
theorem dlmf_6_5_2 (x : ℝ) (hx : 0 < x) :
    E1Boundary x 1 (e1CutBoundary x 1) ∧
      E1Boundary x (-1) (e1CutBoundary x (-1)) ∧
      LMLF.Blueprint.ExponentialIntegrals.Section62.realEi x =
        -principalCutAverage (e1CutBoundary x 1) (e1CutBoundary x (-1))
```
:::
::::

::::dlmfEntry "6.5.3" "https://dlmf.nist.gov/6.5.E3"
$$`\tfrac12(\operatorname{Ei}(x)+E_{1}(x))=\operatorname{Shi}(x)=-i\operatorname{Si}(ix),\quad x>0`$$
:::leanStatement "Shi relation"
```anchor dlmf_6_5_3 (module := LMLF.Blueprint.ExponentialIntegrals.Section65)
theorem dlmf_6_5_3 (x : ℝ) (hx : 0 < x) :
    (LMLF.Blueprint.ExponentialIntegrals.Section62.realEi x +
        LMLF.Blueprint.ExponentialIntegrals.Section62.realE1 x) / 2 =
        LMLF.Blueprint.ExponentialIntegrals.Section62.principalShi (x : ℂ) ∧
      LMLF.Blueprint.ExponentialIntegrals.Section62.principalShi (x : ℂ) =
        -Complex.I *
          LMLF.Blueprint.ExponentialIntegrals.Section62.principalSi
            (Complex.I * x)
```
:::
::::

::::dlmfEntry "6.5.4" "https://dlmf.nist.gov/6.5.E4"
$$`\tfrac12(\operatorname{Ei}(x)-E_{1}(x))=\operatorname{Chi}(x)=\operatorname{Ci}(ix)-\tfrac12\pi i,\quad x>0`$$
:::leanStatement "Chi relation"
```anchor dlmf_6_5_4 (module := LMLF.Blueprint.ExponentialIntegrals.Section65)
theorem dlmf_6_5_4 (x : ℝ) (hx : 0 < x) :
    (LMLF.Blueprint.ExponentialIntegrals.Section62.realEi x -
        LMLF.Blueprint.ExponentialIntegrals.Section62.realE1 x) / 2 =
        LMLF.Blueprint.ExponentialIntegrals.Section62.principalChi (x : ℂ) ∧
      LMLF.Blueprint.ExponentialIntegrals.Section62.principalChi (x : ℂ) =
        LMLF.Blueprint.ExponentialIntegrals.Section62.principalCi (Complex.I * x) -
          Complex.I * Real.pi / 2
```
:::
::::

::::dlmfEntry "6.5.5" "https://dlmf.nist.gov/6.5.E5"
$$`\operatorname{Si}(z)=\tfrac12i(E_{1}(-iz)-E_{1}(iz))+\tfrac12\pi`$$
:::leanStatement "Sine-integral relation"
```anchor dlmf_6_5_5 (module := LMLF.Blueprint.ExponentialIntegrals.Section65)
theorem dlmf_6_5_5 (z : ℂ)
    (hz : z ≠ 0)
    (hphase : ‖Complex.arg z‖ < Real.pi / 2) :
    LMLF.Blueprint.ExponentialIntegrals.Section62.principalSi z =
      Complex.I / 2 *
        (LMLF.Blueprint.ExponentialIntegrals.Section62.principalE1
          (-Complex.I * z) -
          LMLF.Blueprint.ExponentialIntegrals.Section62.principalE1
            (Complex.I * z)) + Real.pi / 2
```
:::
::::

::::dlmfEntry "6.5.6" "https://dlmf.nist.gov/6.5.E6"
$$`\operatorname{Ci}(z)=-\tfrac12(E_{1}(iz)+E_{1}(-iz))`$$
:::leanStatement "Cosine-integral relation"
```anchor dlmf_6_5_6 (module := LMLF.Blueprint.ExponentialIntegrals.Section65)
theorem dlmf_6_5_6 (z : ℂ)
    (hz : z ≠ 0)
    (hphase : ‖Complex.arg z‖ < Real.pi / 2) :
    LMLF.Blueprint.ExponentialIntegrals.Section62.principalCi z =
      -(LMLF.Blueprint.ExponentialIntegrals.Section62.principalE1
          (Complex.I * z) +
        LMLF.Blueprint.ExponentialIntegrals.Section62.principalE1
          (-Complex.I * z)) / 2
```
:::
::::

::::dlmfEntry "6.5.7" "https://dlmf.nist.gov/6.5.E7"
$$`g(z)\pm if(z)=E_{1}(\mp iz)e^{\mp iz}`$$
:::leanStatement "Auxiliary-function relations"
```anchor dlmf_6_5_7 (module := LMLF.Blueprint.ExponentialIntegrals.Section65)
theorem dlmf_6_5_7 (z : ℂ) (hz : z ≠ 0)
    (hphase : ‖Complex.arg z‖ < Real.pi / 2) :
    LMLF.Blueprint.ExponentialIntegrals.Section62.principalAuxiliaryG z +
          Complex.I * LMLF.Blueprint.ExponentialIntegrals.Section62.principalAuxiliaryF z =
        LMLF.Blueprint.ExponentialIntegrals.Section62.principalE1
          (-Complex.I * z) * Complex.exp (-Complex.I * z) ∧
      LMLF.Blueprint.ExponentialIntegrals.Section62.principalAuxiliaryG z -
          Complex.I * LMLF.Blueprint.ExponentialIntegrals.Section62.principalAuxiliaryF z =
        LMLF.Blueprint.ExponentialIntegrals.Section62.principalE1
          (Complex.I * z) * Complex.exp (Complex.I * z)
```
:::
::::

::::dlmfEntry "§6.5 source annotation" "https://dlmf.nist.gov/6.5#info"
The DLMF source cites [Olver (1997b)](https://dlmf.nist.gov/bib/O#bib1809),
p. 41, for [E1](https://dlmf.nist.gov/6.5.E1) and
[E2](https://dlmf.nist.gov/6.5.E2), and p. 42 for
[E5](https://dlmf.nist.gov/6.5.E5) and [E6](https://dlmf.nist.gov/6.5.E6).
It records that E3 and E4 follow from
[6.6.E1](https://dlmf.nist.gov/6.6.E1),
[6.6.E2](https://dlmf.nist.gov/6.6.E2),
[6.6.E5](https://dlmf.nist.gov/6.6.E5), and
[6.6.E6](https://dlmf.nist.gov/6.6.E6), while E7 follows from
[6.2.E10](https://dlmf.nist.gov/6.2.E10),
[6.2.E17](https://dlmf.nist.gov/6.2.E17),
[6.2.E18](https://dlmf.nist.gov/6.2.E18),
[E5](https://dlmf.nist.gov/6.5.E5), and
[E6](https://dlmf.nist.gov/6.5.E6).
These are source dependencies, not additional numbered formulas.
::::

::::dlmfEntry "§6.5 positive-real context" "https://dlmf.nist.gov/6.5#p1"
The first four interrelations use positive real `x`; the two cut values retain
the upper and lower signs separately, while E3 and E4 use the canonical
positive-real `Ei`, `E₁`, `Shi`, and `Chi` values.
::::

::::dlmfEntry "§6.5 complex phase context" "https://dlmf.nist.gov/6.5#p2"
For E5, E6, and E7 the source condition is `|ph z| < π/2`, represented here by
`‖Complex.arg z‖ < π/2`.  E7 also retains the honest Lean endpoint condition
`z ≠ 0`, because the formal `arg` map is totalized at zero; this prevents the
canonical rotated `E₁` values from being read at the singular endpoint.
::::
