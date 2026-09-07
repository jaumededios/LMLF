import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section432
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.Elementary.Section432
set_option verso.exampleProject "."

#doc (Manual) "§4.32 Inequalities" =>
%%%
tag := "chapter-4-section-32"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.32"
Source: NIST Digital Library of Mathematical Functions, §4.32.
:::

# §4.32 Inequalities
%%%
number := false
%%%

DLMF §4.32 records four real inequalities involving trigonometric and
hyperbolic functions. The positivity and nonnegativity hypotheses are included
at the formulas where the source imposes them.

::::dlmfEntry "4.32.1" "https://dlmf.nist.gov/4.32.E1"
For nonzero real x, the inequality compares cosh x with the cubic power of
the normalized sinh quotient.  The displayed quotient has a removable value
at x = 0 in the DLMF convention; the Lean declaration uses its natural
nonzero quotient domain explicitly.
:::leanStatement "DLMF 4.32.E1"
```anchor dlmf_4_32_1 (module := LMLF.Blueprint.Elementary.Section432)
theorem dlmf_4_32_1 {x : ℝ} (hx : x ≠ 0) :
    Real.cosh x ≤ (Real.sinh x / x) ^ (3 : ℕ) := by sorry
```
:::
::::

::::dlmfEntry "4.32.2" "https://dlmf.nist.gov/4.32.E2"
For positive x, sin x cos x is strictly below tanh x, and tanh x is strictly below x.
:::leanStatement "DLMF 4.32.E2"
```anchor dlmf_4_32_2 (module := LMLF.Blueprint.Elementary.Section432)
theorem dlmf_4_32_2 {x : ℝ} (hx : 0 < x) : Real.sin x * Real.cos x < Real.tanh x ∧ Real.tanh x < x := by sorry
```
:::
::::

::::dlmfEntry "4.32.3" "https://dlmf.nist.gov/4.32.E3"
For positive x and y, the absolute cosh difference dominates the argument distance multiplied by the square root of the product of the two positive sinh values.
:::leanStatement "DLMF 4.32.E3"
```anchor dlmf_4_32_3 (module := LMLF.Blueprint.Elementary.Section432)
theorem dlmf_4_32_3 {x y : ℝ} (hx : 0 < x) (hy : 0 < y) : |Real.cosh x - Real.cosh y| ≥ |x - y| * Real.sqrt (Real.sinh x * Real.sinh y) := by sorry
```
:::
::::

::::dlmfEntry "4.32.4" "https://dlmf.nist.gov/4.32.E4"
For nonnegative x, arctan x is bounded above by one half of pi times tanh x.
:::leanStatement "DLMF 4.32.E4"
```anchor dlmf_4_32_4 (module := LMLF.Blueprint.Elementary.Section432)
theorem dlmf_4_32_4 {x : ℝ} (hx : 0 ≤ x) : Real.arctan x ≤ (1 / 2 : ℝ) * Real.pi * Real.tanh x := by sorry
```
:::
::::
