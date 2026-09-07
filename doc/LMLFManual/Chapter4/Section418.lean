import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section418
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.18 Inequalities" =>
%%%
tag := "chapter-4-section-18"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.18"
Source: NIST Digital Library of Mathematical Functions, §4.18.
:::

# §4.18 Inequalities
%%%
number := false
%%%

The first four displays are real-variable inequalities, with every endpoint and
strictness condition retained.  Displays 4.18.5–4.18.10 are complex estimates;
the formal statements use the complex norm and make the real coordinates or
small-disc hypothesis explicit.  The normalized sine in 4.18.3 is totalized at
zero by its continuous value `1`.

::::dlmfEntry "4.18.1" "https://dlmf.nist.gov/4.18.E1"
$$`\frac{2x}{\pi}\le\sin x\le x,\qquad 0\le x\le\frac{\pi}{2}.`$$

Jordan's inequality sandwiches the real sine between its chord lower bound and
the tangent-line upper bound.  Both endpoints are included.

:::leanStatement "Jordan sine inequality"
```anchor dlmf_4_18_1 (module := LMLF.Blueprint.Elementary.Section418) -showProofStates
theorem dlmf_4_18_1 {x : ℝ} (hx0 : 0 ≤ x) (hxπ : x ≤ Real.pi / 2) :
    2 * x / Real.pi ≤ Real.sin x ∧ Real.sin x ≤ x := by sorry
```
:::
::::

::::dlmfEntry "4.18.2" "https://dlmf.nist.gov/4.18.E2"
$$`x\le\tan x,\qquad 0\le x<\frac{\pi}{2}.`$$

The tangent lower bound is an equality at `x=0` and is strict for
`0<x<π/2`; the pole `π/2` is excluded from the domain rather than treated as
an endpoint value.

:::leanStatement "Tangent lower bound"
```anchor dlmf_4_18_2 (module := LMLF.Blueprint.Elementary.Section418) -showProofStates
theorem dlmf_4_18_2 {x : ℝ} (hx0 : 0 ≤ x) (hxπ : x < Real.pi / 2) :
    x ≤ Real.tan x := by sorry
```
:::
::::

::::dlmfEntry "4.18.3" "https://dlmf.nist.gov/4.18.E3"
$$`\cos x\le\frac{\sin x}{x}\le1,\qquad 0\le x\le\pi.`$$

At `x=0`, the quotient is understood by continuity as `1`; the named `sinc`
definition makes that endpoint convention explicit.  On the rest of the closed
interval the displayed quotient is ordinary division.

:::leanStatement "Normalized sine and sinc totalization"
```anchor sinc (module := LMLF.Blueprint.Elementary.Section418) -showProofStates
def sinc (x : ℝ) : ℝ := if x = 0 then 1 else Real.sin x / x
```
```anchor dlmf_4_18_3 (module := LMLF.Blueprint.Elementary.Section418) -showProofStates
theorem dlmf_4_18_3 {x : ℝ} (hx0 : 0 ≤ x) (hxπ : x ≤ Real.pi) :
    Real.cos x ≤ sinc x ∧ sinc x ≤ 1 := by sorry
```
:::
::::

::::dlmfEntry "4.18.4" "https://dlmf.nist.gov/4.18.E4"
$$`\pi<\frac{\sin(\pi x)}{x(1-x)}\le4,\qquad0<x<1.`$$

The lower constant is strict throughout the open interval.  The upper
equality is attained at the interior point `x=1/2`, while the lower bound has
endpoint limit `π`; the formal statement preserves the strict/lax pair exactly.

:::leanStatement "Sharp sine quotient bounds"
```anchor dlmf_4_18_4 (module := LMLF.Blueprint.Elementary.Section418) -showProofStates
theorem dlmf_4_18_4 {x : ℝ} (hx0 : 0 < x) (hx1 : x < 1) :
    Real.pi < Real.sin (Real.pi * x) / (x * (1 - x)) ∧
      Real.sin (Real.pi * x) / (x * (1 - x)) ≤ 4 := by sorry
```
:::
::::

::::dlmfEntry "4.18.5" "https://dlmf.nist.gov/4.18.E5"
$$`|\sinh y|\le|\sin z|\le\cosh y,\qquad z=x+iy.`$$

For complex `z` written with real coordinates `x` and `y`, the imaginary
coordinate controls the lower bound and the real hyperbolic cosine controls the
upper bound.

:::leanStatement "Complex sine coordinate bounds"
```anchor dlmf_4_18_5 (module := LMLF.Blueprint.Elementary.Section418) -showProofStates
theorem dlmf_4_18_5 (x y : ℝ) :
    |Real.sinh y| ≤ ‖Complex.sin ((x : ℂ) + (y : ℂ) * Complex.I)‖ ∧
      ‖Complex.sin ((x : ℂ) + (y : ℂ) * Complex.I)‖ ≤ Real.cosh y := by sorry
```
:::
::::

::::dlmfEntry "4.18.6" "https://dlmf.nist.gov/4.18.E6"
$$`|\sinh y|\le|\cos z|\le\cosh y,\qquad z=x+iy.`$$

The corresponding cosine estimate has the same coordinate-dependent lower and
upper bounds.

:::leanStatement "Complex cosine coordinate bounds"
```anchor dlmf_4_18_6 (module := LMLF.Blueprint.Elementary.Section418) -showProofStates
theorem dlmf_4_18_6 (x y : ℝ) :
    |Real.sinh y| ≤ ‖Complex.cos ((x : ℂ) + (y : ℂ) * Complex.I)‖ ∧
      ‖Complex.cos ((x : ℂ) + (y : ℂ) * Complex.I)‖ ≤ Real.cosh y := by sorry
```
:::
::::

::::dlmfEntry "4.18.7" "https://dlmf.nist.gov/4.18.E7"
$$`|\csc z|\le\operatorname{csch}|y|,\qquad z=x+iy.`$$

The cosecant estimate is used away from the real axis, where the right side is
finite.  The local `csch` definition is the reciprocal of real hyperbolic sine;
the explicit `y ≠ 0` hypothesis records this domain.

:::leanStatement "Cosecant and hyperbolic-cosecant bound"
```anchor csch (module := LMLF.Blueprint.Elementary.Section418) -showProofStates
def csch (y : ℝ) : ℝ := 1 / Real.sinh y
```
```anchor dlmf_4_18_7 (module := LMLF.Blueprint.Elementary.Section418) -showProofStates
theorem dlmf_4_18_7 (x y : ℝ) (hy : y ≠ 0) :
    ‖1 / Complex.sin ((x : ℂ) + (y : ℂ) * Complex.I)‖ ≤ csch |y| := by sorry
```
:::
::::

::::dlmfEntry "4.18.8" "https://dlmf.nist.gov/4.18.E8"
$$`|\cos z|\le\cosh|z|.`$$

The global complex cosine norm is bounded by the real hyperbolic cosine of the
complex modulus.

:::leanStatement "Global cosine norm bound"
```anchor dlmf_4_18_8 (module := LMLF.Blueprint.Elementary.Section418) -showProofStates
theorem dlmf_4_18_8 (z : ℂ) :
    ‖Complex.cos z‖ ≤ Real.cosh ‖z‖ := by sorry
```
:::
::::

::::dlmfEntry "4.18.9" "https://dlmf.nist.gov/4.18.E9"
$$`|\sin z|\le\sinh|z|.`$$

Likewise, the complex sine norm is bounded by the real hyperbolic sine of the
modulus.

:::leanStatement "Global sine norm bound"
```anchor dlmf_4_18_9 (module := LMLF.Blueprint.Elementary.Section418) -showProofStates
theorem dlmf_4_18_9 (z : ℂ) :
    ‖Complex.sin z‖ ≤ Real.sinh ‖z‖ := by sorry
```
:::
::::

::::dlmfEntry "4.18.10" "https://dlmf.nist.gov/4.18.E10"
$$`|\cos z|<2,\qquad |\sin z|\le\frac65|z|,\qquad |z|<1.`$$

Inside the unit disk the cosine has the strict bound `2`, while sine has the
explicit displayed linear constant `6/5`.

:::leanStatement "Small-disc sine and cosine bounds"
```anchor dlmf_4_18_10 (module := LMLF.Blueprint.Elementary.Section418) -showProofStates
theorem dlmf_4_18_10 {z : ℂ} (hz : ‖z‖ < 1) :
    ‖Complex.cos z‖ < 2 ∧ ‖Complex.sin z‖ ≤ (6 / 5 : ℝ) * ‖z‖ := by sorry
```
:::
::::
