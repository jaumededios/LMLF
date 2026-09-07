import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section437
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.Elementary.Section437
set_option verso.exampleProject "."

#doc (Manual) "§4.37 Inverse Hyperbolic Functions" =>
%%%
tag := "chapter-4-section-37"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.37"
Source: NIST Digital Library of Mathematical Functions, §4.37, Inverse Hyperbolic Functions.
:::

# §4.37 Inverse Hyperbolic Functions
%%%
number := false
%%%

The capitalized inverse hyperbolic functions are general multivalued values;
their paths avoid branch points, use the stated principal square-root values
on the reference real sets, and continue the chosen branch. `Arcsinh` and
`Arccsch` have branch points at `±i`; the other four general functions have
branch points at `±1`. The lowercase functions are principal branches on the
explicit cut complements below. DLMF treats them as two-valued on their cuts
and real on the remaining real axis. The Lean value-set declarations are an
honest equation-level specialization: they retain the defining hyperbolic
equations but do not formalize path integrals or continuation data.

## General definitions

[Source: DLMF §4.37(i)](https://dlmf.nist.gov/4.37.i)

E1–E6 are the path-integral definitions
`Arcsinh z=∫₀ᶻdt/√(1+t²)`, `Arccosh z=∫₁ᶻdt/√(t²−1)`,
`Arctanh z=∫₀ᶻdt/(1−t²)`, and the reciprocal identities for Arccsch,
Arcsech, and Arccoth. Paths avoid `±i` for the sinh pair and `±1` otherwise.

## Principal values

[Source: DLMF §4.37(ii)](https://dlmf.nist.gov/4.37.ii)

E7–E9 are the principal reciprocal branches; E7 and E8 exclude zero, while E9
also excludes its stated poles. The six panels of [Figure 4.37.1](https://dlmf.nist.gov/4.37#F1)
show the cuts for the three basic functions and their reciprocals. Graphs for
real arguments appear in [§4.29](https://dlmf.nist.gov/4.29), while the same
section points to conformal mappings and complex surface plots.

### 4.37.1 — `Arcsinh z=∫₀ᶻdt/√(1+t²)`, paths avoid `±i`.

[Source: DLMF 4.37.1](https://dlmf.nist.gov/4.37.E1)
$$`\mathrm{Arcsinh}z=\int_{0}^{z}\frac{dt}{\sqrt{1+t^2}}.`$$
### 4.37.2 — `Arccosh z=∫₁ᶻdt/√(t²−1)`, paths avoid `±1`.

[Source: DLMF 4.37.2](https://dlmf.nist.gov/4.37.E2)
$$`\mathrm{Arccosh}z=\int_{1}^{z}\frac{dt}{\sqrt{t^2-1}}.`$$
### 4.37.3 — `Arctanh z=∫₀ᶻdt/(1−t²)`, `z≠±1`.

[Source: DLMF 4.37.3](https://dlmf.nist.gov/4.37.E3)
$$`\mathrm{Arctanh}z=\int_{0}^{z}\frac{dt}{1-t^2},\qquad z\ne\pm1.`$$
### 4.37.4 — `Arccsch z=Arcsinh(1/z)`, `z≠0`.

[Source: DLMF 4.37.4](https://dlmf.nist.gov/4.37.E4)
$$`\mathrm{Arccsch}z=\mathrm{Arcsinh}\left(1/z\right).`$$
### 4.37.5 — `Arcsech z=Arccosh(1/z)`, `z≠0`.

[Source: DLMF 4.37.5](https://dlmf.nist.gov/4.37.E5)
$$`\mathrm{Arcsech}z=\mathrm{Arccosh}\left(1/z\right).`$$
### 4.37.6 — `Arccoth z=Arctanh(1/z)`, `z≠0` for the reciprocal encoding.

[Source: DLMF 4.37.6](https://dlmf.nist.gov/4.37.E6)
$$`\mathrm{Arccoth}z=\mathrm{Arctanh}\left(1/z\right).`$$
### 4.37.7 — `arccsch z=arcsinh(1/z)`, `z≠0`.

[Source: DLMF 4.37.7](https://dlmf.nist.gov/4.37.E7)
$$`\mathrm{arccsch}z=\mathrm{arcsinh}\left(1/z\right).`$$
### 4.37.8 — `arcsech z=arccosh(1/z)`, `z≠0`.

[Source: DLMF 4.37.8](https://dlmf.nist.gov/4.37.E8)
$$`\mathrm{arcsech}z=\mathrm{arccosh}\left(1/z\right).`$$
### 4.37.9 — `arccoth z=arctanh(1/z)`, `z≠0, ±1`.

[Source: DLMF 4.37.9](https://dlmf.nist.gov/4.37.E9)
$$`\mathrm{arccoth}z=\mathrm{arctanh}\left(1/z\right),\qquad z\ne\pm1.`$$

## Reflection formulas

[Source: DLMF §4.37(iii)](https://dlmf.nist.gov/4.37.iii)

E10–E15 give odd reflections and the side-dependent `π i` corrections for
arccosh and arcsech; the imaginary-part conditions select the upper/lower
side. Away from cuts, the Lean reflection declarations use the corresponding
cut-complement predicate; on a cut, DLMF's two boundary values are retained
by the explicit `CutSide` API below.

For the displayed sign convention, E11 selects `-π i` when `Im z>0` and
`+π i` when `Im z<0`; E14 uses the opposite correction, `+π i` above and
`-π i` below. The anchored branch expressions make this upper/lower choice
explicit.

### 4.37.10 — `arcsinh(-z)=-arcsinh z`.

[Source: DLMF 4.37.10](https://dlmf.nist.gov/4.37.E10)
$$`\mathrm{arcsinh}\left(-z\right)=-\mathrm{arcsinh}z.`$$
### 4.37.11 — `arccosh(-z)=±πi+arccosh z`, `Im z≷0`.

[Source: DLMF 4.37.11](https://dlmf.nist.gov/4.37.E11)
$$`\mathrm{arccosh}\left(-z\right)=\pm\pi\mathrm{i}+\mathrm{arccosh}z,\qquad \operatorname{Im}z\gtrless0.`$$
### 4.37.12 — `arctanh(-z)=-arctanh z`, `z≠±1`.

[Source: DLMF 4.37.12](https://dlmf.nist.gov/4.37.E12)
$$`\mathrm{arctanh}\left(-z\right)=-\mathrm{arctanh}z,\qquad z\ne\pm1.`$$
### 4.37.13 — `arccsch(-z)=-arccsch z`.

[Source: DLMF 4.37.13](https://dlmf.nist.gov/4.37.E13)
$$`\mathrm{arccsch}\left(-z\right)=-\mathrm{arccsch}z.`$$
### 4.37.14 — `arcsech(-z)=∓πi+arcsech z`, `Im z≷0`.

[Source: DLMF 4.37.14](https://dlmf.nist.gov/4.37.E14)
$$`\mathrm{arcsech}\left(-z\right)=\mp\pi\mathrm{i}+\mathrm{arcsech}z,\qquad \operatorname{Im}z\gtrless0.`$$
### 4.37.15 — `arccoth(-z)=-arccoth z`, `z≠±1`.

[Source: DLMF 4.37.15](https://dlmf.nist.gov/4.37.E15)
$$`\mathrm{arccoth}\left(-z\right)=-\mathrm{arccoth}z,\qquad z\ne\pm1.`$$

## Logarithmic forms

[Source: DLMF §4.37(iv)](https://dlmf.nist.gov/4.37.iv)

E16–E25 state principal logarithmic expressions off their cuts and the
upper/lower boundary values on the cuts. E16 allows the endpoints `±i`; its
excluded intervals are open. E19 and E21 use `ℂ \ (-∞,1)` for the formula,
while the analytic cut is `(-∞,1]`. The branch-aware `arccoshRadical` is the
two-square-root realization of E19's `±` sign (and E21's equivalent formula).
The `CutSide` values make both signs in E17, E18, E22, E23, and E25 explicit;
Mathlib's totalized `Complex.log` is single-valued and cannot itself represent
both DLMF boundary limits. DLMF notes that the principal square root in E19 is
discontinuous on the imaginary axis, so analytic continuation switches to the
other branch; this explains the `±` sign. The subsection also points to
Dempsey (2025) for more concrete principal-branch expressions.

### 4.37.16 — `arcsinh z=ln(√(z²+1)+z)` off the rotated cuts.

[Source: DLMF 4.37.16](https://dlmf.nist.gov/4.37.E16)
$$`\mathrm{arcsinh}z=\mathrm{ln}\left(\sqrt{z^2+1}+z\right),\qquad z/\mathrm{i}\in\mathbb{C}\setminus\left((-\infty,-1)\cup(1,\infty)\right).`$$
### 4.37.17 — `arcsinh(iy)=½πi±ln(√(y²−1)+y)`, `y≥1`.

[Source: DLMF 4.37.17](https://dlmf.nist.gov/4.37.E17)
$$`\mathrm{arcsinh}\left(\mathrm{i}y\right)=\frac{1}{2}\pi\mathrm{i}\pm\mathrm{ln}\left(\sqrt{y^2-1}+y\right),\qquad y\in[1,\infty).`$$
### 4.37.18 — `arcsinh(iy)=−½πi±ln(√(y²−1)−y)`, `y≤−1`.

[Source: DLMF 4.37.18](https://dlmf.nist.gov/4.37.E18)
$$`\mathrm{arcsinh}\left(\mathrm{i}y\right)=-\frac{1}{2}\pi\mathrm{i}\pm\mathrm{ln}\left(\sqrt{y^2-1}-y\right),\qquad y\in(-\infty,-1].`$$
### 4.37.19 — `arccosh z=ln(±√(z²−1)+z)`, `z∈ℂ\(-∞,1)`; the sign is selected by `Re z≷0`.

[Source: DLMF 4.37.19](https://dlmf.nist.gov/4.37.E19)
$$`\mathrm{arccosh}z=\mathrm{ln}\left(\pm\sqrt{z^2-1}+z\right),\qquad z\in\mathbb{C}\setminus(-\infty,1).`$$
### 4.37.20 — `arccosh(iy)=±½πi+ln(√(y²+1)±y)`, `y≷0`.

[Source: DLMF 4.37.20](https://dlmf.nist.gov/4.37.E20)
$$`\mathrm{arccosh}\left(\mathrm{i}y\right)=\pm\frac{1}{2}\pi\mathrm{i}+\mathrm{ln}\left(\sqrt{y^2+1}\pm y\right),\qquad y\gtrless0.`$$
### 4.37.21 — `arccosh z=2ln(√((z+1)/2)+√((z−1)/2))`, `z∈ℂ\(-∞,1)`; see Kahan (1987).

[Source: DLMF 4.37.21](https://dlmf.nist.gov/4.37.E21)
$$`\mathrm{arccosh}z=2\mathrm{ln}\left(\sqrt{\frac{z+1}{2}}+\sqrt{\frac{z-1}{2}}\right),\qquad z\in\mathbb{C}\setminus(-\infty,1).`$$
### 4.37.22 — `arccosh x=±ln(i√(1−x²)+x)`, `−1<x≤1`.

[Source: DLMF 4.37.22](https://dlmf.nist.gov/4.37.E22)
$$`\mathrm{arccosh}x=\pm\mathrm{ln}\left(\mathrm{i}\sqrt{1-x^2}+x\right),\qquad x\in(-1,1].`$$
### 4.37.23 — `arccosh x=±πi+ln(√(x²−1)−x)`, `x≤−1`.

[Source: DLMF 4.37.23](https://dlmf.nist.gov/4.37.E23)
$$`\mathrm{arccosh}x=\pm\pi\mathrm{i}+\mathrm{ln}\left(\sqrt{x^2-1}-x\right),\qquad x\in(-\infty,-1].`$$
### 4.37.24 — `arctanh z=½ln((1+z)/(1−z))` off the real cuts.

[Source: DLMF 4.37.24](https://dlmf.nist.gov/4.37.E24)
$$`\mathrm{arctanh}z=\frac{1}{2}\mathrm{ln}\left(\frac{1+z}{1-z}\right),\qquad z\in\mathbb{C}\setminus\left((-\infty,-1]\cup[1,\infty)\right).`$$
### 4.37.25 — `arctanh x=±½πi+½ln((x+1)/(x−1))`, `|x|>1`.

[Source: DLMF 4.37.25](https://dlmf.nist.gov/4.37.E25)
$$`\mathrm{arctanh}x=\pm\frac{1}{2}\pi\mathrm{i}+\frac{1}{2}\mathrm{ln}\left(\frac{x+1}{x-1}\right),\qquad x\in(-\infty,-1)\cup(1,\infty).`$$

## Fundamental property

[Source: DLMF §4.37(v)](https://dlmf.nist.gov/4.37.v)

E26–E28 are the equations `z=sinh w`, `z=cosh w`, and `z=tanh w`; the Lean
disclosures record their direct implication to the corresponding inverse-value
sets. E29–E31 now characterize all inverse values using `k∈ℤ` and the
displayed sign families.

### 4.37.26 — `z=sinh w`.

[Source: DLMF 4.37.26](https://dlmf.nist.gov/4.37.E26)
$$`z=\mathrm{sinh}w.`$$
### 4.37.27 — `z=cosh w`.

[Source: DLMF 4.37.27](https://dlmf.nist.gov/4.37.E27)
$$`z=\mathrm{cosh}w.`$$
### 4.37.28 — `z=tanh w`.

[Source: DLMF 4.37.28](https://dlmf.nist.gov/4.37.E28)
$$`z=\mathrm{tanh}w.`$$
### 4.37.29 — `w=(-1)^k arcsinh z+kπi`.

[Source: DLMF 4.37.29](https://dlmf.nist.gov/4.37.E29)
$$`w=\mathrm{Arcsinh}z=(-1)^k\mathrm{arcsinh}z+k\pi\mathrm{i},\qquad k\in\mathbb{Z}.`$$
### 4.37.30 — `w=±arccosh z+2kπi`.

[Source: DLMF 4.37.30](https://dlmf.nist.gov/4.37.E30)
$$`w=\mathrm{Arccosh}z=\pm\mathrm{arccosh}z+2k\pi\mathrm{i},\qquad k\in\mathbb{Z}.`$$
### 4.37.31 — `w=arctanh z+kπi`, `z≠±1`.

[Source: DLMF 4.37.31](https://dlmf.nist.gov/4.37.E31)
$$`w=\mathrm{Arctanh}z=\mathrm{arctanh}z+k\pi\mathrm{i},\qquad z\ne\pm1,\quad k\in\mathbb{Z}.`$$

:::leanStatement "General, reflection, logarithmic, and fundamental declarations"
```anchor dlmf_4_37_1 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E1: general inverse hyperbolic-sine value relation. -/
theorem dlmf_4_37_1 (z w : ℂ) : w ∈ arcsinhValues z ↔ Complex.sinh w = z :=
```
```anchor dlmf_4_37_2 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E2: general inverse hyperbolic-cosine value relation. -/
theorem dlmf_4_37_2 (z w : ℂ) : w ∈ arccoshValues z ↔ Complex.cosh w = z :=
```
```anchor dlmf_4_37_3 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E3: general inverse hyperbolic-tangent value relation away from poles. -/
theorem dlmf_4_37_3 (z w : ℂ) (hz : z ≠ 1) (hz' : z ≠ -1) :
    w ∈ arctanhValues z ↔ Complex.tanh w = z :=
```
```anchor dlmf_4_37_4 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E4: general inverse-cosecant value relation. -/
theorem dlmf_4_37_4 (z w : ℂ) (hz : z ≠ 0) : w ∈ arccschValues z ↔ Complex.sinh w = 1 / z :=
```
```anchor dlmf_4_37_5 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E5: general inverse-secant value relation. -/
theorem dlmf_4_37_5 (z w : ℂ) (hz : z ≠ 0) : w ∈ arcsechValues z ↔ Complex.cosh w = 1 / z :=
```
```anchor dlmf_4_37_6 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E6: general inverse-cotangent value relation. -/
theorem dlmf_4_37_6 (z w : ℂ) (hz : z ≠ 0) : w ∈ arccothValues z ↔ Complex.tanh w = 1 / z :=
```
```anchor dlmf_4_37_7 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E7: principal arccsch reciprocal specialization. -/
theorem dlmf_4_37_7 (z : ℂ) (hz : z ≠ 0) : principalArccsch z = principalArcsinh (1 / z) :=
```
```anchor dlmf_4_37_8 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E8: principal arcsech reciprocal specialization. -/
theorem dlmf_4_37_8 (z : ℂ) (hz : z ≠ 0) : principalArcsech z = principalArccosh (1 / z) :=
```
```anchor dlmf_4_37_9 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E9: principal arccoth reciprocal specialization. -/
theorem dlmf_4_37_9 (z : ℂ) (hz0 : z ≠ 0) (hz : z ≠ 1) (hz' : z ≠ -1) : principalArccoth z = principalArctanh (1 / z) :=
```
```anchor dlmf_4_37_10 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E10: principal arcsinh odd reflection. -/
theorem dlmf_4_37_10 (z : ℂ) (hz : arcsinhLogDomain z) :
    principalArcsinh (-z) = -principalArcsinh z :=
```
```anchor dlmf_4_37_11 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E11: principal arccosh reflection with half-plane sign. -/
theorem dlmf_4_37_11 (z : ℂ) (hz : z.im ≠ 0) :
    principalArccosh (-z) = (if 0 < z.im then -2 * Real.pi * Complex.I else 2 * Real.pi * Complex.I) / 2 + principalArccosh z :=
```
```anchor dlmf_4_37_12 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E12: principal arctanh odd reflection off its poles. -/
theorem dlmf_4_37_12 (z : ℂ) (hz : arctanhLogDomain z) :
    principalArctanh (-z) = -principalArctanh z :=
```
```anchor dlmf_4_37_13 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E13: principal arccsch odd reflection. -/
theorem dlmf_4_37_13 (z : ℂ) (hz : z ≠ 0) (hcut : arcsinhLogDomain (1 / z)) :
    principalArccsch (-z) = -principalArccsch z :=
```
```anchor dlmf_4_37_14 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E14: principal arcsech reflection with side sign. -/
theorem dlmf_4_37_14 (z : ℂ) (hz : z.im ≠ 0) :
    principalArcsech (-z) = (if 0 < z.im then 2 * Real.pi * Complex.I else -2 * Real.pi * Complex.I) / 2 + principalArcsech z :=
```
```anchor dlmf_4_37_15 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E15: principal arccoth odd reflection off its poles. -/
theorem dlmf_4_37_15 (z : ℂ) (hz : z ≠ 0) (hz' : z ≠ 1) (hz'' : z ≠ -1)
    (hcut : arctanhLogDomain (1 / z)) : principalArccoth (-z) = -principalArccoth z :=
```
```anchor dlmf_4_37_16 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E16: principal logarithmic arcsinh formula on its cut complement. -/
theorem dlmf_4_37_16 (z : ℂ) (hz : arcsinhLogDomain z) : principalArcsinh z = Complex.log (Complex.sqrt (z ^ 2 + 1) + z) :=
```
```anchor dlmf_4_37_17 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E17: upper/lower-side arcsinh cut values. -/
theorem dlmf_4_37_17 (y : ℝ) (side : CutSide) (hy : 1 ≤ y) :
    Real.pi / 2 * Complex.I + cutSideSign side *
        Complex.log (Complex.sqrt (y ^ 2 - 1) + y) ∈ arcsinhValues (Complex.I * y) :=
```
```anchor dlmf_4_37_18 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E18: upper/lower-side arcsinh cut values. -/
theorem dlmf_4_37_18 (y : ℝ) (side : CutSide) (hy : y ≤ -1) :
    -(Real.pi / 2) * Complex.I + cutSideSign side *
        Complex.log (Complex.sqrt (y ^ 2 - 1) - y) ∈ arcsinhValues (Complex.I * y) :=
```
```anchor dlmf_4_37_19 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E19: principal logarithmic arccosh formula. -/
theorem dlmf_4_37_19 (z : ℂ) (hz : arccoshLogDomain z) :
    principalArccosh z = Complex.log (arccoshRadical z + z) :=
```
```anchor dlmf_4_37_20 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E20: imaginary-axis arccosh values. -/
theorem dlmf_4_37_20 (y : ℝ) (hy : y ≠ 0) : principalArccosh (Complex.I * y) = (if 0 < y then 1 else -1) * (Real.pi / 2 * Complex.I) + Complex.log (Complex.sqrt (y ^ 2 + 1) + (if 0 < y then y else -y)) :=
```
```anchor dlmf_4_37_21 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E21: equivalent two-square-root arccosh formula. -/
theorem dlmf_4_37_21 (z : ℂ) (hz : arccoshLogDomain z) : principalArccosh z = 2 * Complex.log (Complex.sqrt ((z + 1) / 2) + Complex.sqrt ((z - 1) / 2)) :=
```
```anchor dlmf_4_37_22 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E22: upper/lower-side arccosh values on `(-1,1]`. -/
theorem dlmf_4_37_22 (x : ℝ) (side : CutSide) (hx : -1 < x) (hx' : x ≤ 1) :
    cutSideSign side * Complex.log (Complex.I * Complex.sqrt (1 - x ^ 2) + x) ∈
      arccoshValues x :=
```
```anchor dlmf_4_37_23 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E23: upper/lower-side arccosh values on `(-∞,-1]`. -/
theorem dlmf_4_37_23 (x : ℝ) (side : CutSide) (hx : x ≤ -1) :
    cutSideSign side * (Real.pi * Complex.I) +
        Complex.log (Complex.sqrt (x ^ 2 - 1) - x) ∈ arccoshValues x :=
```
```anchor dlmf_4_37_24 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E24: principal logarithmic arctanh formula. -/
theorem dlmf_4_37_24 (z : ℂ) (hz : arctanhLogDomain z) : principalArctanh z = Complex.log ((1 + z) / (1 - z)) / 2 :=
```
```anchor dlmf_4_37_25 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E25: cut values of principal arctanh. -/
theorem dlmf_4_37_25 (x : ℝ) (side : CutSide) (hx : x < -1 ∨ 1 < x) :
    cutSideSign side * (Real.pi * Complex.I / 2) +
        Complex.log ((x + 1) / (x - 1)) / 2 ∈ arctanhValues x :=
```
:::

:::leanStatement "Fundamental-property declarations"
```anchor dlmf_4_37_26 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E26: inverse hyperbolic sine equation. -/
theorem dlmf_4_37_26 (z w : ℂ) (h : Complex.sinh w = z) : w ∈ arcsinhValues z :=
```
```anchor dlmf_4_37_27 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E27: inverse hyperbolic cosine equation. -/
theorem dlmf_4_37_27 (z w : ℂ) (h : Complex.cosh w = z) : w ∈ arccoshValues z :=
```
```anchor dlmf_4_37_28 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E28: inverse hyperbolic tangent equation off poles. -/
theorem dlmf_4_37_28 (z w : ℂ) (hz : z ≠ 1) (hz' : z ≠ -1) (h : Complex.tanh w = z) : w ∈ arctanhValues z :=
```
```anchor dlmf_4_37_29 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E29: general arcsinh family with integer period. -/
theorem dlmf_4_37_29 (z w : ℂ) :
    w ∈ arcsinhValues z ↔
      ∃ k : ℤ, w = (-1 : ℂ) ^ k * principalArcsinh z + k * (Real.pi * Complex.I) :=
```
```anchor dlmf_4_37_30 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E30: general arccosh family with sign and integer period. -/
theorem dlmf_4_37_30 (z w : ℂ) :
    w ∈ arccoshValues z ↔
      ∃ (k : ℤ) (ε : ℂ), (ε = 1 ∨ ε = -1) ∧
        w = ε * principalArccosh z + 2 * k * (Real.pi * Complex.I) :=
```
```anchor dlmf_4_37_31 (module := LMLF.Blueprint.Elementary.Section437)
/-- DLMF 4.37.E31: general arctanh family with integer period off poles. -/
theorem dlmf_4_37_31 (z w : ℂ) (hz : z ≠ 1) (hz' : z ≠ -1) :
    w ∈ arctanhValues z ↔
      ∃ k : ℤ, w = principalArctanh z + k * (Real.pi * Complex.I) :=
```
:::

## §4.37(vi) Interrelations

Source: [DLMF §4.37(vi)](https://dlmf.nist.gov/4.37.vi). Interrelations are
tabulated in [DLMF Table 4.30.1](https://dlmf.nist.gov/4.30#T1); for example,
the table gives reciprocal-composition relations such as
`arcsech z = arccoth ((1-z²)⁻¹ᐟ²)` under the table's branch conventions.
This subsection adds no numbered equation. DLMF's note that E11 follows from
E19 is also reflected by the shared branch-aware `arccoshRadical` definition;
the equivalent E21 form follows the branch-cut discussion of Kahan (1987).
