import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section45
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.5 Inequalities" =>
%%%
tag := "chapter-4-section-5"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.5"
Source: NIST Digital Library of Mathematical Functions, §4.5.
:::

DLMF §4.5 gives inequalities for the logarithm and exponential functions.
The first six displays concern logarithms, including the principal complex
branch in (4.5.6); the remaining displays concern real exponentials and two
complex estimates.  The decimal cutoffs in (4.5.3) and (4.5.14) are retained
as the displayed real cutoffs `0.5828` and `1.5936`.

::::dlmfEntry "4.5.1" "https://dlmf.nist.gov/4.5.E1"
$$`\[\frac{x}{1+x}<\ln(1+x)<x,\qquad x>-1,\quad x\ne0.\]`

For a real `x` greater than `−1` and different from zero, the logarithm of
`1+x` lies strictly between `x/(1+x)` and `x`.

:::leanStatement "Logarithm bounds"
```anchor dlmf_4_5_1 (module := LMLF.Blueprint.Elementary.Section45) -showProofStates
theorem dlmf_4_5_1 {x : ℝ} (hx : -1 < x) (hx0 : x ≠ 0) :
    x / (1 + x) < Real.log (1 + x) ∧ Real.log (1 + x) < x
```
:::
::::

::::dlmfEntry "4.5.2" "https://dlmf.nist.gov/4.5.E2"
$$`\[x<−\ln(1−x)<\frac{x}{1−x},\qquad x<1,\quad x\ne0.\]`

For real `x<1` with `x≠0`, the quantity `−log(1−x)` is strictly bounded by
`x` and `x/(1−x)`.

:::leanStatement "Logarithm of one minus x"
```anchor dlmf_4_5_2 (module := LMLF.Blueprint.Elementary.Section45) -showProofStates
theorem dlmf_4_5_2 {x : ℝ} (hx : x < 1) (hx0 : x ≠ 0) :
    x < -Real.log (1 - x) ∧ -Real.log (1 - x) < x / (1 - x)
```
:::
::::

::::dlmfEntry "4.5.3" "https://dlmf.nist.gov/4.5.E3"
$$`\[|\ln(1−x)|<\frac32x,\qquad 0<x\le0.5828\ldots.\]`

On the stated small positive interval, the absolute value of `log(1−x)` is
strictly less than `3x/2`.

:::leanStatement "Small positive logarithm bound"
```anchor dlmf_4_5_3 (module := LMLF.Blueprint.Elementary.Section45) -showProofStates
theorem dlmf_4_5_3 {x : ℝ} (hx : 0 < x) (hxmax : x ≤ (0.5828 : ℝ)) :
    |Real.log (1 - x)| < (3 / 2 : ℝ) * x
```
:::
::::

::::dlmfEntry "4.5.4" "https://dlmf.nist.gov/4.5.E4"
$$`\[\ln x\le x−1,\qquad x>0.\]`

For every positive real `x`, `log x` is at most `x−1`.

:::leanStatement "Logarithm tangent bound"
```anchor dlmf_4_5_4 (module := LMLF.Blueprint.Elementary.Section45) -showProofStates
theorem dlmf_4_5_4 {x : ℝ} (hx : 0 < x) :
    Real.log x ≤ x - 1
```
:::
::::

::::dlmfEntry "4.5.5" "https://dlmf.nist.gov/4.5.E5"
$$`\[\ln x\le a\left(x^{1/a}−1\right),\qquad a,x>0.\]`

For positive real `a` and `x`, the logarithm is bounded above by the displayed
power expression.  The declaration uses the real `rpow` interpretation of
the power.

:::leanStatement "Power-form logarithm bound"
```anchor dlmf_4_5_5 (module := LMLF.Blueprint.Elementary.Section45) -showProofStates
theorem dlmf_4_5_5 {a x : ℝ} (ha : 0 < a) (hx : 0 < x) :
    Real.log x ≤ a * (x ^ (1 / a) - 1)
```
:::
::::

::::dlmfEntry "4.5.6" "https://dlmf.nist.gov/4.5.E6"
$$`\[|\ln(1+z)|\le−\ln(1−|z|),\qquad |z|<1.\]`

For a complex `z` in the open unit disk, the modulus of the principal complex
logarithm is bounded by the real quantity `−log(1−|z|)`.

:::leanStatement "Complex logarithm bound"
```anchor dlmf_4_5_6 (module := LMLF.Blueprint.Elementary.Section45) -showProofStates
theorem dlmf_4_5_6 {z : ℂ} (hz : ‖z‖ < 1) :
    ‖Complex.log (1 + z)‖ ≤ -Real.log (1 - ‖z‖)
```
:::
::::

::::dlmfEntry "4.5.7" "https://dlmf.nist.gov/4.5.E7"
$$`\[e^{-x/(1-x)}<1-x<e^{-x},\qquad x<1.\]`

For nonzero real `x<1`, the quantity `1−x` lies strictly between the two
displayed exponentials.

:::leanStatement "Exponential bounds near one"
```anchor dlmf_4_5_7 (module := LMLF.Blueprint.Elementary.Section45) -showProofStates
theorem dlmf_4_5_7 {x : ℝ} (hx : x < 1) (hx0 : x ≠ 0) :
    Real.exp (-x / (1 - x)) < 1 - x ∧ 1 - x < Real.exp (-x)
```
:::
::::

::::dlmfEntry "4.5.8" "https://dlmf.nist.gov/4.5.E8"
$$`\[1+x<e^x,\qquad −\infty<x<\infty.\]`

For every nonzero real `x` (with equality at zero), the exponential is strictly
above its tangent line `1+x`.

:::leanStatement "Exponential tangent bound"
```anchor dlmf_4_5_8 (module := LMLF.Blueprint.Elementary.Section45) -showProofStates
theorem dlmf_4_5_8 {x : ℝ} (hx0 : x ≠ 0) :
    1 + x < Real.exp x
```
:::
::::

::::dlmfEntry "4.5.9" "https://dlmf.nist.gov/4.5.E9"
$$`\[e^x<\frac1{1-x},\qquad x<1.\]`

For nonzero real `x<1`, the exponential is strictly below the reciprocal
`1/(1−x)`.

:::leanStatement "Reciprocal exponential bound"
```anchor dlmf_4_5_9 (module := LMLF.Blueprint.Elementary.Section45) -showProofStates
theorem dlmf_4_5_9 {x : ℝ} (hx : x < 1) (hx0 : x ≠ 0) :
    Real.exp x < 1 / (1 - x)
```
:::
::::

::::dlmfEntry "4.5.10" "https://dlmf.nist.gov/4.5.E10"
$$`\[\frac{x}{1+x}<1−e^{-x}<x,\qquad x>−1.\]`

For nonzero real `x>-1`, `1−e^{-x}` lies strictly between `x/(1+x)` and
`x`.

:::leanStatement "One minus an exponential"
```anchor dlmf_4_5_10 (module := LMLF.Blueprint.Elementary.Section45) -showProofStates
theorem dlmf_4_5_10 {x : ℝ} (hx : -1 < x) (hx0 : x ≠ 0) :
    x / (1 + x) < 1 - Real.exp (-x) ∧ 1 - Real.exp (-x) < x
```
:::
::::

::::dlmfEntry "4.5.11" "https://dlmf.nist.gov/4.5.E11"
$$`\[x<e^x−1<\frac{x}{1-x},\qquad x<1.\]`

For nonzero real `x<1`, `e^x−1` lies strictly between `x` and `x/(1−x)`.

:::leanStatement "Exponential increment bound"
```anchor dlmf_4_5_11 (module := LMLF.Blueprint.Elementary.Section45) -showProofStates
theorem dlmf_4_5_11 {x : ℝ} (hx : x < 1) (hx0 : x ≠ 0) :
    x < Real.exp x - 1 ∧ Real.exp x - 1 < x / (1 - x)
```
:::
::::

::::dlmfEntry "4.5.12" "https://dlmf.nist.gov/4.5.E12"
$$`\[e^{x/(1+x)}<1+x,\qquad x>−1.\]`

For nonzero real `x>-1`, `1+x` is strictly above the exponential shown.

:::leanStatement "Exponential lower tangent bound"
```anchor dlmf_4_5_12 (module := LMLF.Blueprint.Elementary.Section45) -showProofStates
theorem dlmf_4_5_12 {x : ℝ} (hx : -1 < x) (hx0 : x ≠ 0) :
    Real.exp (x / (1 + x)) < 1 + x
```
:::
::::

::::dlmfEntry "4.5.13" "https://dlmf.nist.gov/4.5.E13"
$$`\[e^{xy/(x+y)}<\left(1+\frac{x}{y}\right)^y<e^x,\qquad x>0, y>0.\]`

For positive real `x` and `y`, the real power `(1+x/y)^y` lies strictly
between the two displayed exponentials.

:::leanStatement "Weighted power exponential bound"
```anchor dlmf_4_5_13 (module := LMLF.Blueprint.Elementary.Section45) -showProofStates
theorem dlmf_4_5_13 {x y : ℝ} (hx : 0 < x) (hy : 0 < y) :
    Real.exp (x * y / (x + y)) < (1 + x / y) ^ y ∧
      (1 + x / y) ^ y < Real.exp x
```
:::
::::

::::dlmfEntry "4.5.14" "https://dlmf.nist.gov/4.5.E14"
$$`\[e^{-x}<1−\frac12x,\qquad 0<x\le1.5936\ldots.\]`

On the displayed small positive interval, `e^{-x}` is strictly below
`1−x/2`.

:::leanStatement "Small positive exponential bound"
```anchor dlmf_4_5_14 (module := LMLF.Blueprint.Elementary.Section45) -showProofStates
theorem dlmf_4_5_14 {x : ℝ} (hx : 0 < x) (hxmax : x ≤ (1.5936 : ℝ)) :
    Real.exp (-x) < 1 - x / 2
```
:::
::::

::::dlmfEntry "4.5.15" "https://dlmf.nist.gov/4.5.E15"
$$`\[\frac14|z|<|e^z−1|<\frac74|z|,\qquad 0<|z|<1.\]`

For a nonzero complex `z` in the open unit disk, the modulus of `e^z−1` is
strictly between one quarter and seven quarters of `|z|`.

:::leanStatement "Complex exponential increment bound"
```anchor dlmf_4_5_15 (module := LMLF.Blueprint.Elementary.Section45) -showProofStates
theorem dlmf_4_5_15 {z : ℂ} (hz : 0 < ‖z‖) (hz1 : ‖z‖ < 1) :
    (1 / 4 : ℝ) * ‖z‖ < ‖Complex.exp z - 1‖ ∧
      ‖Complex.exp z - 1‖ < (7 / 4 : ℝ) * ‖z‖
```
:::
::::

::::dlmfEntry "4.5.16" "https://dlmf.nist.gov/4.5.E16"
$$`\[|e^z−1|\le e^{|z|}−1\le |z|e^{|z|},\qquad z\in\mathbb C.\]`

For every complex `z`, the exponential increment is bounded first by the
real exponential increment at `|z|`, and then by `|z|e^{|z|}`.

:::leanStatement "Global complex exponential bound"
```anchor dlmf_4_5_16 (module := LMLF.Blueprint.Elementary.Section45) -showProofStates
theorem dlmf_4_5_16 (z : ℂ) :
    ‖Complex.exp z - 1‖ ≤ Real.exp ‖z‖ - 1 ∧
      Real.exp ‖z‖ - 1 ≤ ‖z‖ * Real.exp ‖z‖
```
:::
::::
