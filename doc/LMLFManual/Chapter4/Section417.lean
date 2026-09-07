import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section417
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual
open Filter
open scoped Topology

set_option verso.exampleProject "."

#doc (Manual) "§4.17 Special Values and Limits" =>
%%%
tag := "chapter-4-section-17"
%%%

The DLMF page gives a table of exact values for the six trigonometric
functions at multiples of π/12, followed by three complex limits at the
origin.  The table's ∞ entries are pole markers, not real values of a
totalized reciprocal; no one-sided sign is asserted by the source table.

::::dlmfEntry "Table 4.17.1" "https://dlmf.nist.gov/4.17.T1"
Table 4.17.1, “Trigonometric functions: values at multiples of
π/12,” has columns θ, sin θ, cos θ, tan θ, csc θ, sec θ, and cot θ.  The
thirteen data rows are listed below in increasing θ, with every sign and
radical as in the source.  The symbol ∞ is retained through the tagged Lean value
`TrigSpecialValue.infinity`; it records a pole in the displayed reciprocal
function rather than an element of ℝ.

:::leanStatement "Lean table schema and column header"
```anchor table417_header (module := LMLF.Blueprint.Elementary.Section417) -showProofStates
def table417_header : List String :=
  ["θ", "sin θ", "cos θ", "tan θ", "csc θ", "sec θ", "cot θ"]
```
:::

:::leanStatement "Lean rows · θ = 0, π/12, π/6, π/4"
```anchor table417_row_zero (module := LMLF.Blueprint.Elementary.Section417) -showProofStates
def table417_row_zero : TrigSpecialValueRow :=
  { theta := 0
    sinValue := .finite 0
    cosValue := .finite 1
    tanValue := .finite 0
    cscValue := .infinity
    secValue := .finite 1
    cotValue := .infinity }
```
```anchor table417_row_pi_div_12 (module := LMLF.Blueprint.Elementary.Section417) -showProofStates
def table417_row_pi_div_12 : TrigSpecialValueRow :=
  { theta := Real.pi / 12
    sinValue := .finite (Real.sqrt 2 * (Real.sqrt 3 - 1) / 4)
    cosValue := .finite (Real.sqrt 2 * (Real.sqrt 3 + 1) / 4)
    tanValue := .finite (2 - Real.sqrt 3)
    cscValue := .finite (Real.sqrt 2 * (Real.sqrt 3 + 1))
    secValue := .finite (Real.sqrt 2 * (Real.sqrt 3 - 1))
    cotValue := .finite (2 + Real.sqrt 3) }
```
```anchor table417_row_pi_div_6 (module := LMLF.Blueprint.Elementary.Section417) -showProofStates
def table417_row_pi_div_6 : TrigSpecialValueRow :=
  { theta := Real.pi / 6
    sinValue := .finite (1 / 2)
    cosValue := .finite (Real.sqrt 3 / 2)
    tanValue := .finite (Real.sqrt 3 / 3)
    cscValue := .finite 2
    secValue := .finite (2 * Real.sqrt 3 / 3)
    cotValue := .finite (Real.sqrt 3) }
```
```anchor table417_row_pi_div_4 (module := LMLF.Blueprint.Elementary.Section417) -showProofStates
def table417_row_pi_div_4 : TrigSpecialValueRow :=
  { theta := Real.pi / 4
    sinValue := .finite (Real.sqrt 2 / 2)
    cosValue := .finite (Real.sqrt 2 / 2)
    tanValue := .finite 1
    cscValue := .finite (Real.sqrt 2)
    secValue := .finite (Real.sqrt 2)
    cotValue := .finite 1 }
```
:::

:::leanStatement "Lean rows · θ = π/3, 5π/12, π/2, 7π/12"
```anchor table417_row_pi_div_3 (module := LMLF.Blueprint.Elementary.Section417) -showProofStates
def table417_row_pi_div_3 : TrigSpecialValueRow :=
  { theta := Real.pi / 3
    sinValue := .finite (Real.sqrt 3 / 2)
    cosValue := .finite (1 / 2)
    tanValue := .finite (Real.sqrt 3)
    cscValue := .finite (2 * Real.sqrt 3 / 3)
    secValue := .finite 2
    cotValue := .finite (Real.sqrt 3 / 3) }
```
```anchor table417_row_five_pi_div_12 (module := LMLF.Blueprint.Elementary.Section417) -showProofStates
def table417_row_five_pi_div_12 : TrigSpecialValueRow :=
  { theta := 5 * Real.pi / 12
    sinValue := .finite (Real.sqrt 2 * (Real.sqrt 3 + 1) / 4)
    cosValue := .finite (Real.sqrt 2 * (Real.sqrt 3 - 1) / 4)
    tanValue := .finite (2 + Real.sqrt 3)
    cscValue := .finite (Real.sqrt 2 * (Real.sqrt 3 - 1))
    secValue := .finite (Real.sqrt 2 * (Real.sqrt 3 + 1))
    cotValue := .finite (2 - Real.sqrt 3) }
```
```anchor table417_row_pi_div_2 (module := LMLF.Blueprint.Elementary.Section417) -showProofStates
def table417_row_pi_div_2 : TrigSpecialValueRow :=
  { theta := Real.pi / 2
    sinValue := .finite 1
    cosValue := .finite 0
    tanValue := .infinity
    cscValue := .finite 1
    secValue := .infinity
    cotValue := .finite 0 }
```
```anchor table417_row_seven_pi_div_12 (module := LMLF.Blueprint.Elementary.Section417) -showProofStates
def table417_row_seven_pi_div_12 : TrigSpecialValueRow :=
  { theta := 7 * Real.pi / 12
    sinValue := .finite (Real.sqrt 2 * (Real.sqrt 3 + 1) / 4)
    cosValue := .finite (-(Real.sqrt 2 * (Real.sqrt 3 - 1) / 4))
    tanValue := .finite (-(2 + Real.sqrt 3))
    cscValue := .finite (Real.sqrt 2 * (Real.sqrt 3 - 1))
    secValue := .finite (-(Real.sqrt 2 * (Real.sqrt 3 + 1)))
    cotValue := .finite (-(2 - Real.sqrt 3)) }
```
:::

:::leanStatement "Lean rows · θ = 2π/3, 3π/4, 5π/6, 11π/12, π"
```anchor table417_row_two_pi_div_3 (module := LMLF.Blueprint.Elementary.Section417) -showProofStates
def table417_row_two_pi_div_3 : TrigSpecialValueRow :=
  { theta := 2 * Real.pi / 3
    sinValue := .finite (Real.sqrt 3 / 2)
    cosValue := .finite (-(1 / 2))
    tanValue := .finite (-Real.sqrt 3)
    cscValue := .finite (2 * Real.sqrt 3 / 3)
    secValue := .finite (-2)
    cotValue := .finite (-(Real.sqrt 3 / 3)) }
```
```anchor table417_row_three_pi_div_4 (module := LMLF.Blueprint.Elementary.Section417) -showProofStates
def table417_row_three_pi_div_4 : TrigSpecialValueRow :=
  { theta := 3 * Real.pi / 4
    sinValue := .finite (Real.sqrt 2 / 2)
    cosValue := .finite (-(Real.sqrt 2 / 2))
    tanValue := .finite (-1)
    cscValue := .finite (Real.sqrt 2)
    secValue := .finite (-Real.sqrt 2)
    cotValue := .finite (-1) }
```
```anchor table417_row_five_pi_div_6 (module := LMLF.Blueprint.Elementary.Section417) -showProofStates
def table417_row_five_pi_div_6 : TrigSpecialValueRow :=
  { theta := 5 * Real.pi / 6
    sinValue := .finite (1 / 2)
    cosValue := .finite (-(Real.sqrt 3 / 2))
    tanValue := .finite (-(Real.sqrt 3 / 3))
    cscValue := .finite 2
    secValue := .finite (-(2 * Real.sqrt 3 / 3))
    cotValue := .finite (-Real.sqrt 3) }
```
```anchor table417_row_eleven_pi_div_12 (module := LMLF.Blueprint.Elementary.Section417) -showProofStates
def table417_row_eleven_pi_div_12 : TrigSpecialValueRow :=
  { theta := 11 * Real.pi / 12
    sinValue := .finite (Real.sqrt 2 * (Real.sqrt 3 - 1) / 4)
    cosValue := .finite (-(Real.sqrt 2 * (Real.sqrt 3 + 1) / 4))
    tanValue := .finite (-(2 - Real.sqrt 3))
    cscValue := .finite (Real.sqrt 2 * (Real.sqrt 3 + 1))
    secValue := .finite (-(Real.sqrt 2 * (Real.sqrt 3 - 1)))
    cotValue := .finite (-(2 + Real.sqrt 3)) }
```
```anchor table417_row_pi (module := LMLF.Blueprint.Elementary.Section417) -showProofStates
def table417_row_pi : TrigSpecialValueRow :=
  { theta := Real.pi
    sinValue := .finite 0
    cosValue := .finite (-1)
    tanValue := .finite 0
    cscValue := .infinity
    secValue := .finite (-1)
    cotValue := .infinity }
```
:::
::::

::::dlmfEntry "Limits at the origin" "https://dlmf.nist.gov/4.17#p1"
For complex z approaching zero through the punctured neighborhood, the
source records the three limits below.  The Lean statements use `Tendsto` at
the punctured filter `nhdsWithin 0 {0}ᶜ`, so the displayed quotients retain their exact
complex domain and limiting direction z → 0.

:::leanStatement "DLMF 4.17.1 · sine quotient"
```anchor dlmf_4_17_E1 (module := LMLF.Blueprint.Elementary.Section417) -showProofStates
theorem dlmf_4_17_E1 :
    Tendsto (fun z : ℂ => Complex.sin z / z)
      (nhdsWithin (0 : ℂ) {0}ᶜ) (𝓝 (1 : ℂ)) := by sorry
```
:::

:::leanStatement "DLMF 4.17.2 · tangent quotient"
```anchor dlmf_4_17_E2 (module := LMLF.Blueprint.Elementary.Section417) -showProofStates
theorem dlmf_4_17_E2 :
    Tendsto (fun z : ℂ => Complex.tan z / z)
      (nhdsWithin (0 : ℂ) {0}ᶜ) (𝓝 (1 : ℂ)) := by sorry
```
:::

:::leanStatement "DLMF 4.17.3 · cosine remainder quotient"
```anchor dlmf_4_17_E3 (module := LMLF.Blueprint.Elementary.Section417) -showProofStates
theorem dlmf_4_17_E3 :
    Tendsto (fun z : ℂ => (1 - Complex.cos z) / z ^ 2)
      (nhdsWithin (0 : ℂ) {0}ᶜ)
      (𝓝 ((1 : ℂ) / 2)) := by sorry
```
:::
::::
