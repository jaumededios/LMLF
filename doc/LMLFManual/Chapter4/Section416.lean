import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section416
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.16 Elementary Properties" =>
%%%
tag := "chapter-4-section-16"
%%%

The DLMF page collects the elementary sign rules, quarter-period symmetries, and
interrelations of the six trigonometric functions. Figure 4.16.1
([source](https://dlmf.nist.gov/4.16.F1)) places the terminal ray of θ in the four
open quadrants, bounded by `0`, `π/2`, `π`, `3π/2`, and `2π`; the signs in Table
4.16.1 are read from those quadrants. The formal statements use real angles and
make the quadrant, boundary, and denominator assumptions visible.

::::dlmfEntry "Table 4.16.1" "https://dlmf.nist.gov/4.16.T1"
In quadrant I, all six functions `(sin, cos, tan, csc, sec, cot)` are positive;
in quadrant II sine and cosecant are positive while cosine, secant, tangent,
and cotangent are negative; in quadrant III tangent and cotangent are positive
while sine, cosine, cosecant, and secant are negative; and in quadrant IV cosine
and secant are positive while the other four are negative. The boundary row
records the axis values separately, where reciprocal functions may have poles.
:::leanStatement "Lean statements · quadrant signs"
```anchor table4161_row1 (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4161_row1 (θ : ℝ) (h : quadrantI θ) :
    0 < Real.sin θ ∧ 0 < Real.cos θ ∧ 0 < Real.tan θ ∧
      0 < 1 / Real.sin θ ∧ 0 < 1 / Real.cos θ ∧ 0 < 1 / Real.tan θ := by sorry
```
```anchor table4161_row2 (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4161_row2 (θ : ℝ) (h : quadrantII θ) :
    0 < Real.sin θ ∧ Real.cos θ < 0 ∧ Real.tan θ < 0 ∧
      0 < 1 / Real.sin θ ∧ 1 / Real.cos θ < 0 ∧ 1 / Real.tan θ < 0 := by sorry
```
```anchor table4161_row3 (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4161_row3 (θ : ℝ) (h : quadrantIII θ) :
    Real.sin θ < 0 ∧ Real.cos θ < 0 ∧ 0 < Real.tan θ ∧
      1 / Real.sin θ < 0 ∧ 1 / Real.cos θ < 0 ∧ 0 < 1 / Real.tan θ := by sorry
```
```anchor table4161_row4 (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4161_row4 (θ : ℝ) (h : quadrantIV θ) :
    Real.sin θ < 0 ∧ 0 < Real.cos θ ∧ Real.tan θ < 0 ∧
      1 / Real.sin θ < 0 ∧ 0 < 1 / Real.cos θ ∧ 1 / Real.tan θ < 0 := by sorry
```
```anchor table4161_row5 (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4161_row5 (θ : ℝ)
    (h : θ = 0 ∨ θ = Real.pi / 2 ∨ θ = Real.pi ∨ θ = 3 * Real.pi / 2) :
    (θ = 0 → Real.sin θ = 0 ∧ Real.cos θ = 1) ∧
      (θ = Real.pi / 2 → Real.sin θ = 1 ∧ Real.cos θ = 0) ∧
      (θ = Real.pi → Real.sin θ = 0 ∧ Real.cos θ = -1) ∧
      (θ = 3 * Real.pi / 2 → Real.sin θ = -1 ∧ Real.cos θ = 0) ∧
      (θ = 0 → Real.tan θ = 0 ∧ 1 / Real.sin θ = 0 ∧
        1 / Real.cos θ = 1 ∧ 1 / Real.tan θ = 0) ∧
      (θ = Real.pi / 2 → Real.tan θ = 0 ∧ 1 / Real.sin θ = 1 ∧
        1 / Real.cos θ = 0 ∧ 1 / Real.tan θ = 0) ∧
      (θ = Real.pi → Real.tan θ = 0 ∧ 1 / Real.sin θ = 0 ∧
        1 / Real.cos θ = -1 ∧ 1 / Real.tan θ = 0) ∧
      (θ = 3 * Real.pi / 2 → Real.tan θ = 0 ∧ 1 / Real.sin θ = -1 ∧
        1 / Real.cos θ = 0 ∧ 1 / Real.tan θ = 0) := by sorry
```
:::
::::

::::dlmfEntry "Table 4.16.2" "https://dlmf.nist.gov/4.16.T2"
For `x=-θ`, `π/2±θ`, `π±θ`, `3π/2±θ`, and `2π±θ`, the source table gives all
nine transformations for each of sine, cosine, tangent, cosecant, secant, and
cotangent. The following rows record every listed case directly; reciprocal
rows use `1/sin`, `1/cos`, and `1/tan` for csc, sec, and cot. The six named
function declarations are the reusable APIs paired with the six source rows;
the final `table4162_row7` anchor is a shared period cross-check, not an extra
unmatched function row. Tangent and
reciprocal rows explicitly assume the relevant sine and cosine values are
nonzero, so totalized division is not being used to conceal a pole.
:::leanStatement "Lean statements · quarter-period transformations"
```anchor table4162_sin (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4162_sin (x θ : ℝ) :
    (x = -θ → Real.sin x = -Real.sin θ) ∧
      (x = Real.pi / 2 + θ → Real.sin x = Real.cos θ) ∧
      (x = Real.pi / 2 - θ → Real.sin x = Real.cos θ) ∧
      (x = Real.pi + θ → Real.sin x = -Real.sin θ) ∧
      (x = Real.pi - θ → Real.sin x = Real.sin θ) ∧
      (x = 3 * Real.pi / 2 + θ → Real.sin x = -Real.cos θ) ∧
      (x = 3 * Real.pi / 2 - θ → Real.sin x = -Real.cos θ) ∧
      (x = 2 * Real.pi + θ → Real.sin x = Real.sin θ) ∧
      (x = 2 * Real.pi - θ → Real.sin x = -Real.sin θ) := by sorry
```
```anchor table4162_cos (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4162_cos (x θ : ℝ) :
    (x = -θ → Real.cos x = Real.cos θ) ∧
      (x = Real.pi / 2 + θ → Real.cos x = -Real.sin θ) ∧
      (x = Real.pi / 2 - θ → Real.cos x = Real.sin θ) ∧
      (x = Real.pi + θ → Real.cos x = -Real.cos θ) ∧
      (x = Real.pi - θ → Real.cos x = -Real.cos θ) ∧
      (x = 3 * Real.pi / 2 + θ → Real.cos x = Real.sin θ) ∧
      (x = 3 * Real.pi / 2 - θ → Real.cos x = -Real.sin θ) ∧
      (x = 2 * Real.pi + θ → Real.cos x = Real.cos θ) ∧
      (x = 2 * Real.pi - θ → Real.cos x = Real.cos θ) := by sorry
```
```anchor table4162_tan (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4162_tan (θ : ℝ) (hs : Real.sin θ ≠ 0) (hc : Real.cos θ ≠ 0) :
    (Real.tan (-θ) = -Real.tan θ) ∧
      (Real.tan (Real.pi / 2 + θ) = -1 / Real.tan θ) ∧
      (Real.tan (Real.pi / 2 - θ) = 1 / Real.tan θ) ∧
      (Real.tan (Real.pi + θ) = Real.tan θ) ∧
      (Real.tan (Real.pi - θ) = -Real.tan θ) ∧
      (Real.tan (3 * Real.pi / 2 + θ) = -1 / Real.tan θ) ∧
      (Real.tan (3 * Real.pi / 2 - θ) = 1 / Real.tan θ) ∧
      (Real.tan (2 * Real.pi + θ) = Real.tan θ) ∧
      (Real.tan (2 * Real.pi - θ) = -Real.tan θ) := by sorry
```
```anchor table4162_csc (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4162_csc (θ : ℝ) (hs : Real.sin θ ≠ 0) (hc : Real.cos θ ≠ 0) :
    (1 / Real.sin (-θ) = -(1 / Real.sin θ)) ∧
      (1 / Real.sin (Real.pi / 2 + θ) = 1 / Real.cos θ) ∧
      (1 / Real.sin (Real.pi / 2 - θ) = 1 / Real.cos θ) ∧
      (1 / Real.sin (Real.pi + θ) = -(1 / Real.sin θ)) ∧
      (1 / Real.sin (Real.pi - θ) = 1 / Real.sin θ) ∧
      (1 / Real.sin (3 * Real.pi / 2 + θ) = -(1 / Real.cos θ)) ∧
      (1 / Real.sin (3 * Real.pi / 2 - θ) = -(1 / Real.cos θ)) ∧
      (1 / Real.sin (2 * Real.pi + θ) = 1 / Real.sin θ) ∧
      (1 / Real.sin (2 * Real.pi - θ) = -(1 / Real.sin θ)) := by sorry
```
```anchor table4162_sec (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4162_sec (θ : ℝ) (hs : Real.sin θ ≠ 0) (hc : Real.cos θ ≠ 0) :
    (1 / Real.cos (-θ) = 1 / Real.cos θ) ∧
      (1 / Real.cos (Real.pi / 2 + θ) = -(1 / Real.sin θ)) ∧
      (1 / Real.cos (Real.pi / 2 - θ) = 1 / Real.sin θ) ∧
      (1 / Real.cos (Real.pi + θ) = -(1 / Real.cos θ)) ∧
      (1 / Real.cos (Real.pi - θ) = -(1 / Real.cos θ)) ∧
      (1 / Real.cos (3 * Real.pi / 2 + θ) = 1 / Real.sin θ) ∧
      (1 / Real.cos (3 * Real.pi / 2 - θ) = -(1 / Real.sin θ)) ∧
      (1 / Real.cos (2 * Real.pi + θ) = 1 / Real.cos θ) ∧
      (1 / Real.cos (2 * Real.pi - θ) = 1 / Real.cos θ) := by sorry
```
```anchor table4162_cot (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4162_cot (θ : ℝ) (hs : Real.sin θ ≠ 0) (hc : Real.cos θ ≠ 0) :
    (1 / Real.tan (-θ) = -(1 / Real.tan θ)) ∧
      (1 / Real.tan (Real.pi / 2 + θ) = -Real.tan θ) ∧
      (1 / Real.tan (Real.pi / 2 - θ) = Real.tan θ) ∧
      (1 / Real.tan (Real.pi + θ) = 1 / Real.tan θ) ∧
      (1 / Real.tan (Real.pi - θ) = -(1 / Real.tan θ)) ∧
      (1 / Real.tan (3 * Real.pi / 2 + θ) = -Real.tan θ) ∧
      (1 / Real.tan (3 * Real.pi / 2 - θ) = Real.tan θ) ∧
      (1 / Real.tan (2 * Real.pi + θ) = 1 / Real.tan θ) ∧
      (1 / Real.tan (2 * Real.pi - θ) = -(1 / Real.tan θ)) := by sorry
```
```anchor table4162_row7 (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4162_row7 (θ : ℝ) :
    Real.sin (2 * Real.pi + θ) = Real.sin θ ∧
      Real.cos (2 * Real.pi + θ) = Real.cos θ ∧
      Real.tan (2 * Real.pi + θ) = Real.tan θ ∧
      Real.sin (2 * Real.pi - θ) = -Real.sin θ ∧
      Real.cos (2 * Real.pi - θ) = Real.cos θ ∧
      Real.tan (2 * Real.pi - θ) = -Real.tan θ := by sorry
```
:::
::::

::::dlmfEntry "Table 4.16.3" "https://dlmf.nist.gov/4.16.T3"
The interrelation table is a six-by-six grid: each of the six given values
`sin θ = a`, `cos θ = a`, `tan θ = a`, `csc θ = a`, `sec θ = a`, and `cot θ = a`
recovers all six functions. The six anchored declarations below expose every
cell as a conjunction. The sine, cosine, and tangent rows include a sign choice
for the recovered quantity and a nonnegative radicand; cells containing
reciprocals strengthen this to strict positivity and nonzero input values, so
the principal square root is finite. Reciprocal entries therefore exclude
their poles rather than relying on totalized division. The final row records the
real principal-square-root convention.
:::leanStatement "Lean statements · interrelations"
```anchor table4163_sin (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4163_sin (θ a : ℝ) (ha0 : a ≠ 0) (hrad : 0 < 1 - a ^ 2)
    (hcos : 0 < Real.cos θ) :
    Real.sin θ = a →
      Real.cos θ = Real.sqrt (1 - a ^ 2) ∧
      Real.tan θ = a / Real.sqrt (1 - a ^ 2) ∧
      1 / Real.sin θ = 1 / a ∧
      1 / Real.cos θ = 1 / Real.sqrt (1 - a ^ 2) ∧
      1 / Real.tan θ = Real.sqrt (1 - a ^ 2) / a := by sorry
```
```anchor table4163_cos (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4163_cos (θ a : ℝ) (ha0 : a ≠ 0) (hrad : 0 < 1 - a ^ 2)
    (hsin : 0 < Real.sin θ) :
    Real.cos θ = a →
      Real.sin θ = Real.sqrt (1 - a ^ 2) ∧
      Real.tan θ = Real.sqrt (1 - a ^ 2) / a ∧
      1 / Real.sin θ = 1 / Real.sqrt (1 - a ^ 2) ∧
      1 / Real.cos θ = 1 / a ∧
      1 / Real.tan θ = a / Real.sqrt (1 - a ^ 2) := by sorry
```
```anchor table4163_tan (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4163_tan (θ a : ℝ) (hden : 0 < Real.cos θ)
    (ha : a ≠ 0) (hrad : 0 ≤ 1 + a ^ 2) :
    Real.tan θ = a →
      Real.sin θ = a / Real.sqrt (1 + a ^ 2) ∧
      Real.cos θ = 1 / Real.sqrt (1 + a ^ 2) ∧
      1 / Real.sin θ = Real.sqrt (1 + a ^ 2) / a ∧
      1 / Real.cos θ = Real.sqrt (1 + a ^ 2) ∧
      1 / Real.tan θ = 1 / a := by sorry
```
```anchor table4163_csc (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4163_csc (θ a : ℝ) (ha : a ≠ 0) (hcos : 0 < Real.cos θ)
    (hrad : 0 < 1 - (1 / a) ^ 2) :
    1 / Real.sin θ = a →
      Real.sin θ = 1 / a ∧
      Real.cos θ = Real.sqrt (1 - (1 / a) ^ 2) ∧
      Real.tan θ = (1 / a) / Real.sqrt (1 - (1 / a) ^ 2) ∧
      1 / Real.cos θ = 1 / Real.sqrt (1 - (1 / a) ^ 2) ∧
      1 / Real.tan θ = a * Real.sqrt (1 - (1 / a) ^ 2) := by sorry
```
```anchor table4163_sec (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4163_sec (θ a : ℝ) (ha : a ≠ 0) (hsin : 0 < Real.sin θ)
    (hrad : 0 < 1 - (1 / a) ^ 2) :
    1 / Real.cos θ = a →
      Real.cos θ = 1 / a ∧
      Real.sin θ = Real.sqrt (1 - (1 / a) ^ 2) ∧
      Real.tan θ = a * Real.sqrt (1 - (1 / a) ^ 2) ∧
      1 / Real.sin θ = 1 / Real.sqrt (1 - (1 / a) ^ 2) ∧
      1 / Real.tan θ = 1 / (a * Real.sqrt (1 - (1 / a) ^ 2)) := by sorry
```
```anchor table4163_cot (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4163_cot (θ a : ℝ) (ha : a ≠ 0) (hcos : 0 < Real.cos θ)
    (hrad : 0 ≤ 1 + (1 / a) ^ 2) :
    1 / Real.tan θ = a →
      Real.tan θ = 1 / a ∧
      Real.cos θ = 1 / Real.sqrt (1 + (1 / a) ^ 2) ∧
      Real.sin θ = (1 / a) / Real.sqrt (1 + (1 / a) ^ 2) ∧
      1 / Real.cos θ = Real.sqrt (1 + (1 / a) ^ 2) ∧
      1 / Real.sin θ = a * Real.sqrt (1 + (1 / a) ^ 2) := by sorry
```
```anchor table4163_row7 (module := LMLF.Blueprint.Elementary.Section416) -showProofStates
theorem table4163_row7 (a : ℝ) (ha : 0 ≤ a) :
    Real.sqrt (a ^ 2) = a ∧ 0 ≤ Real.sqrt a := by sorry
```
:::
::::
