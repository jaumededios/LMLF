import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section426
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.Elementary.Section426 Filter
open scoped Interval
set_option verso.exampleProject "."

#doc (Manual) "§4.26 Integrals" =>
%%%
tag := "chapter-4-section-26"
%%%

Throughout §4.26 variables are real. The indefinite identities use the stated
open intervals to avoid singularities and principal-log branch changes. The
definite identities include finite orthogonality integrals and improper
integrals interpreted as limits; inverse-trigonometric entries retain their
real endpoint restrictions.

# §4.26(ii) Indefinite integrals

The first two source displays are `∫ sin x dx = -cos x` and
`∫ cos x dx = sin x`.  On the principal real intervals, E3–E6 give
`∫ tan x dx = -log(cos x)` for `-π/2 < x < π/2`,
`∫ csc x dx = log(tan(x/2))` for `0 < x < π`,
`∫ sec x dx = gd⁻¹(x)` for `-π/2 < x < π/2`, and
`∫ cot x dx = log(sin x)` for `0 < x < π`.  E5 uses the equivalent
`log(tan(x/2 + π/4))` representative of the inverse Gudermannian, on this
interval and with the source's §4.23.41–42 cross-reference understood.
E7 and E8 are the exponential sine/cosine primitives for real `a,b` with
`a²+b² ≠ 0`; the source also allows complex constants, so these declarations
are explicitly real specializations.

# §4.26(iii) Definite integrals

For positive integer frequencies, E9 and E10 are the sine and cosine
orthogonality integrals on `[0,π]`; E11 gives both square integrals as `π/2`.
E12 is the conditionally convergent Dirichlet limit
`∫₀^∞ sin(mt)/t dt`, with values `π/2`, `0`, and `-π/2` for positive, zero,
and negative integer `m`.  E13 is the pair of Fresnel limits
`∫₀^∞ sin(t²)dt = ∫₀^∞ cos(t²)dt = ½√(π/2) = √(π/8)`.  These are improper
limits, not Lebesgue integrals over `Ioi`; the formal statements use `Tendsto`
of finite interval integrals.  DLMF cites Copson (1935) for E12–E13.

# §4.26(iv) Inverse trigonometric functions

E14 and E15 hold on `-1 < x < 1` for arcsine and arccosine, E16 holds for all
real `x` for arctangent, E17 and E18 use the positive-real reciprocal forms of
the source's `arccsc` and `arcsec` formulas (`x > 1`), and E19 uses the
corresponding `arccot` form (`x > 0`).  E20 and E21 integrate `x arcsin x` and
`x arccos x` on `(-1,1)`, preserving every coefficient and square-root sign.
All inverse functions use their principal real branches.  The source notes
that complex extensions require continuous branches and avoidance of
singularities; these declarations intentionally remain honest real
specializations.  DLMF's final compendia paragraph points to the standard
integral tables of Apelblat, Bierens de Haan, Gradshteyn–Ryzhik, Gröbner–
Hofreiter, and Prudnikov et al.

::::dlmfEntry "4.26.1" "https://dlmf.nist.gov/4.26.E1"
$$`\int \sin x\,dx=-\cos x.`
This first primitive is valid for every real `x`; the Lean disclosure records
its derivative, so an arbitrary additive constant is implicit.
:::leanStatement "DLMF 4.26.E1"
```anchor dlmf_4_26_1 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_1 (x : ℝ) : HasDerivAt (fun x : ℝ => -Real.cos x) (Real.sin x) x :=
```
:::
::::

::::dlmfEntry "4.26.2" "https://dlmf.nist.gov/4.26.E2"
$$`\int \cos x\,dx=\sin x.`
Again the statement is an all-real derivative encoding of the displayed
indefinite integral.
:::leanStatement "DLMF 4.26.E2"
```anchor dlmf_4_26_2 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_2 (x : ℝ) : HasDerivAt Real.sin (Real.cos x) x :=
```
:::
::::

::::dlmfEntry "4.26.3" "https://dlmf.nist.gov/4.26.E3"
$$`\int\tan x\,dx=-\log(\cos x),\qquad -\frac\pi2<x<\frac\pi2.`
On this open interval cosine is positive, so the real principal logarithm
represents the source branch without a hidden absolute value.
:::leanStatement "DLMF 4.26.E3"
```anchor dlmf_4_26_3 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_3 {x : ℝ} (hx : -(Real.pi / 2) < x) (hx' : x < Real.pi / 2) :
    HasDerivAt (fun x : ℝ => -Real.log (Real.cos x)) (Real.tan x) x :=
```
:::
::::

::::dlmfEntry "4.26.4" "https://dlmf.nist.gov/4.26.E4"
$$`\int\csc x\,dx=\log\tan\frac x2,\qquad 0<x<\pi.`
The interval keeps sine and the half-angle tangent positive and avoids both
endpoint singularities.
:::leanStatement "DLMF 4.26.E4"
```anchor dlmf_4_26_4 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_4 {x : ℝ} (hx : 0 < x) (hx' : x < Real.pi) :
    HasDerivAt (fun x : ℝ => Real.log (Real.tan (x / 2))) (1 / Real.sin x) x :=
```
:::
::::

::::dlmfEntry "4.26.5" "https://dlmf.nist.gov/4.26.E5"
$$`\int\sec x\,dx=\operatorname{gd}^{-1}(x),\qquad -\frac\pi2<x<\frac\pi2.`
The Lean logarithm `log(tan(x/2+π/4))` is the equivalent real form of the
inverse Gudermannian cited by DLMF §4.23.41–42.
:::leanStatement "DLMF 4.26.E5"
```anchor dlmf_4_26_5 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_5 {x : ℝ} (hx : -(Real.pi / 2) < x) (hx' : x < Real.pi / 2) :
    HasDerivAt (fun x : ℝ => Real.log (Real.tan (x / 2 + Real.pi / 4))) (1 / Real.cos x) x :=
```
:::
::::

::::dlmfEntry "4.26.6" "https://dlmf.nist.gov/4.26.E6"
$$`\int\cot x\,dx=\log(\sin x),\qquad 0<x<\pi.`
The open interval makes the logarithm's argument positive and excludes the
zeros of sine.
:::leanStatement "DLMF 4.26.E6"
```anchor dlmf_4_26_6 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_6 {x : ℝ} (hx : 0 < x) (hx' : x < Real.pi) :
    HasDerivAt (fun x : ℝ => Real.log (Real.sin x)) (1 / Real.tan x) x :=
```
:::
::::

::::dlmfEntry "4.26.7" "https://dlmf.nist.gov/4.26.E7"
$$`\int e^{ax}\sin(bx)\,dx=\frac{e^{ax}}{a^2+b^2}(a\sin bx-b\cos bx),\quad a^2+b^2\ne0.`
The declaration is the real-parameter specialization of the source's complex
constant formula.
:::leanStatement "DLMF 4.26.E7"
```anchor dlmf_4_26_7 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_7 (a b x : ℝ) (hab : a ^ 2 + b ^ 2 ≠ 0) :
    HasDerivAt (fun x : ℝ => Real.exp (a * x) / (a ^ 2 + b ^ 2) *
      (a * Real.sin (b * x) - b * Real.cos (b * x)))
      (Real.exp (a * x) * Real.sin (b * x)) x :=
```
:::
::::

::::dlmfEntry "4.26.8" "https://dlmf.nist.gov/4.26.E8"
$$`\int e^{ax}\cos(bx)\,dx=\frac{e^{ax}}{a^2+b^2}(a\cos bx+b\sin bx),\quad a^2+b^2\ne0.`
This is the companion real specialization, with the same nonzero quadratic
denominator.
:::leanStatement "DLMF 4.26.E8"
```anchor dlmf_4_26_8 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_8 (a b x : ℝ) (hab : a ^ 2 + b ^ 2 ≠ 0) :
    HasDerivAt (fun x : ℝ => Real.exp (a * x) / (a ^ 2 + b ^ 2) *
      (a * Real.cos (b * x) + b * Real.sin (b * x)))
      (Real.exp (a * x) * Real.cos (b * x)) x :=
```
:::
::::

::::dlmfEntry "4.26.9" "https://dlmf.nist.gov/4.26.E9"
$$`\int_0^\pi\sin(mt)\sin(nt)\,dt=0,\qquad 0<m,n,\ m\ne n.`
The frequencies are positive integers, which is the convention needed for the
distinct-frequency sine orthogonality relation.
:::leanStatement "DLMF 4.26.E9"
```anchor dlmf_4_26_9 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_9 {m n : ℤ} (hm : 0 < m) (hn : 0 < n) (h : m ≠ n) :
    ∫ t in (0 : ℝ)..Real.pi, Real.sin (m * t) * Real.sin (n * t) = 0 :=
```
:::
::::

::::dlmfEntry "4.26.10" "https://dlmf.nist.gov/4.26.E10"
$$`\int_0^\pi\cos(mt)\cos(nt)\,dt=0,\qquad 0<m,n,\ m\ne n.`
The cosine relation uses the same positive integer frequency regime.
:::leanStatement "DLMF 4.26.E10"
```anchor dlmf_4_26_10 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_10 {m n : ℤ} (hm : 0 < m) (hn : 0 < n) (h : m ≠ n) :
    ∫ t in (0 : ℝ)..Real.pi, Real.cos (m * t) * Real.cos (n * t) = 0 :=
```
:::
::::

::::dlmfEntry "4.26.11" "https://dlmf.nist.gov/4.26.E11"
$$`\int_0^\pi\sin^2(nt)\,dt=\int_0^\pi\cos^2(nt)\,dt=\frac\pi2,\qquad n\ne0.`
Both square integrals have the same value for every nonzero integer frequency.
:::leanStatement "DLMF 4.26.E11"
```anchor dlmf_4_26_11 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_11 {n : ℤ} (h : n ≠ 0) :
    (∫ t in (0 : ℝ)..Real.pi, (Real.sin (n * t)) ^ 2) = Real.pi / 2 ∧
    (∫ t in (0 : ℝ)..Real.pi, (Real.cos (n * t)) ^ 2) = Real.pi / 2 :=
```
:::
::::

::::dlmfEntry "4.26.12" "https://dlmf.nist.gov/4.26.E12"
$$`\int_0^\infty\frac{\sin(mt)}t\,dt=\begin{cases}\frac\pi2&m>0,\\0&m=0,\\-\frac\pi2&m<0.\end{cases}`
This is a conditional improper limit as the finite upper endpoint tends to
infinity, not a Lebesgue integral over `Ioi 0`.
:::leanStatement "DLMF 4.26.E12"
```anchor dlmf_4_26_12 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_12 (m : ℤ) :
    ∃ L : ℝ, Tendsto (fun R : ℝ => ∫ t in (0 : ℝ)..R, Real.sin (m * t) / t)
      atTop (nhds L) ∧
      L = if 0 < m then Real.pi / 2 else if m = 0 then 0 else -(Real.pi / 2) :=
```
:::
::::

::::dlmfEntry "4.26.13" "https://dlmf.nist.gov/4.26.E13"
$$`\int_0^\infty\sin(t^2)\,dt=\int_0^\infty\cos(t^2)\,dt=\frac12\sqrt{\frac\pi2}=\sqrt{\frac\pi8}.`
Both Fresnel integrals are interpreted as conditionally convergent limits of
finite interval integrals; DLMF cites Copson for these values.
:::leanStatement "DLMF 4.26.E13"
```anchor dlmf_4_26_13 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_13 :
    (∃ L : ℝ, Tendsto (fun R : ℝ => ∫ t in (0 : ℝ)..R, Real.sin (t ^ 2))
      atTop (nhds L) ∧ L = Real.sqrt (Real.pi / 8)) ∧
    (∃ L : ℝ, Tendsto (fun R : ℝ => ∫ t in (0 : ℝ)..R, Real.cos (t ^ 2))
      atTop (nhds L) ∧ L = Real.sqrt (Real.pi / 8)) :=
```
:::
::::

::::dlmfEntry "4.26.14" "https://dlmf.nist.gov/4.26.E14"
$$`\int\arcsin x\,dx=x\arcsin x+\sqrt{1-x^2},\qquad -1<x<1.`
The principal real arcsine and positive square root are used on the open
interval.
:::leanStatement "DLMF 4.26.E14"
```anchor dlmf_4_26_14 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_14 {x : ℝ} (hx : -1 < x) (hx' : x < 1) :
    HasDerivAt (fun x : ℝ => x * Real.arcsin x + Real.sqrt (1 - x ^ 2)) (Real.arcsin x) x :=
```
:::
::::

::::dlmfEntry "4.26.15" "https://dlmf.nist.gov/4.26.E15"
$$`\int\arccos x\,dx=x\arccos x-\sqrt{1-x^2},\qquad -1<x<1.`
The minus sign in the square-root term is part of the arccosine primitive.
:::leanStatement "DLMF 4.26.E15"
```anchor dlmf_4_26_15 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_15 {x : ℝ} (hx : -1 < x) (hx' : x < 1) :
    HasDerivAt (fun x : ℝ => x * Real.arccos x - Real.sqrt (1 - x ^ 2)) (Real.arccos x) x :=
```
:::
::::

::::dlmfEntry "4.26.16" "https://dlmf.nist.gov/4.26.E16"
$$`\int\arctan x\,dx=x\arctan x-\tfrac12\log(1+x^2).`
This principal-real formula has no finite endpoint restriction.
:::leanStatement "DLMF 4.26.E16"
```anchor dlmf_4_26_16 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_16 (x : ℝ) :
    HasDerivAt (fun x : ℝ => x * Real.arctan x - Real.log (1 + x ^ 2) / 2)
      (Real.arctan x) x :=
```
:::
::::

::::dlmfEntry "4.26.17" "https://dlmf.nist.gov/4.26.E17"
$$`\int\operatorname{arccsc}x\,dx=x\arcsin(1/x)+\log(x+\sqrt{x^2-1}),\quad x>1.`
The Lean statement is the positive-real reciprocal specialization of the
source's arccsc branch.
:::leanStatement "DLMF 4.26.E17"
```anchor dlmf_4_26_17 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_17 {x : ℝ} (hx : 1 < x) :
    HasDerivAt (fun x : ℝ => x * (Real.arcsin (1 / x)) + Real.log (x + Real.sqrt (x ^ 2 - 1)))
      (Real.arcsin (1 / x)) x :=
```
:::
::::

::::dlmfEntry "4.26.18" "https://dlmf.nist.gov/4.26.E18"
$$`\int\operatorname{arcsec}x\,dx=x\arccos(1/x)-\log(x+\sqrt{x^2-1}),\quad x>1.`
The positive-real condition fixes the principal arcsecant specialization.
:::leanStatement "DLMF 4.26.E18"
```anchor dlmf_4_26_18 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_18 {x : ℝ} (hx : 1 < x) :
    HasDerivAt (fun x : ℝ => x * (Real.arccos (1 / x)) - Real.log (x + Real.sqrt (x ^ 2 - 1)))
      (Real.arccos (1 / x)) x :=
```
:::
::::

::::dlmfEntry "4.26.19" "https://dlmf.nist.gov/4.26.E19"
$$`\int\operatorname{arccot}x\,dx=x\arctan(1/x)+\tfrac12\log(1+x^2),\quad x>0.`
Here the source arccotangent is represented by its positive-real reciprocal
arctangent branch.
:::leanStatement "DLMF 4.26.E19"
```anchor dlmf_4_26_19 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_19 {x : ℝ} (hx : 0 < x) :
    HasDerivAt (fun x : ℝ => x * (Real.arctan (1 / x)) + Real.log (1 + x ^ 2) / 2)
      (Real.arctan (1 / x)) x :=
```
:::
::::

::::dlmfEntry "4.26.20" "https://dlmf.nist.gov/4.26.E20"
$$`\int x\arcsin x\,dx=(\tfrac{x^2}{2}-\tfrac14)\arcsin x+\tfrac{x}{4}\sqrt{1-x^2},\quad -1<x<1.`
The weighted arcsine primitive retains the polynomial coefficients and the
principal real branch.
:::leanStatement "DLMF 4.26.E20"
```anchor dlmf_4_26_20 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_20 {x : ℝ} (hx : -1 < x) (hx' : x < 1) :
    HasDerivAt (fun x : ℝ => (x ^ 2 / 2 - 1 / 4) * Real.arcsin x +
      x / 4 * Real.sqrt (1 - x ^ 2)) (x * Real.arcsin x) x :=
```
:::
::::

::::dlmfEntry "4.26.21" "https://dlmf.nist.gov/4.26.E21"
$$`\int x\arccos x\,dx=(\tfrac{x^2}{2}-\tfrac14)\arccos x-\tfrac{x}{4}\sqrt{1-x^2},\quad -1<x<1.`
The corresponding arccosine formula has the opposite square-root sign.
:::leanStatement "DLMF 4.26.E21"
```anchor dlmf_4_26_21 (module := LMLF.Blueprint.Elementary.Section426)
theorem dlmf_4_26_21 {x : ℝ} (hx : -1 < x) (hx' : x < 1) :
    HasDerivAt (fun x : ℝ => (x ^ 2 / 2 - 1 / 4) * Real.arccos x -
      x / 4 * Real.sqrt (1 - x ^ 2)) (x * Real.arccos x) x :=
```
:::
::::
