import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

open Filter
open scoped Topology
noncomputable section
namespace LMLF.Blueprint.Elementary.Section417

/-! Special values and limits for the trigonometric functions from DLMF §4.17.

The table uses an explicit pole marker rather than pretending that `∞` is a
real number.  This is a faithful transcription of the DLMF table; it also
makes the distinction from Mathlib's totalized real division visible.
-/

/-- DLMF 4.17.T1: the two kinds of entry occurring in Table 4.17.1. -/
inductive TrigSpecialValue where
  | finite (value : ℝ)
  | infinity

/-- DLMF 4.17.T1: one row of the six-column trigonometric-value table. -/
structure TrigSpecialValueRow where
  theta : ℝ
  sinValue : TrigSpecialValue
  cosValue : TrigSpecialValue
  tanValue : TrigSpecialValue
  cscValue : TrigSpecialValue
  secValue : TrigSpecialValue
  cotValue : TrigSpecialValue

/-- DLMF 4.17.T1, row 1: the column labels `θ`, `sin θ`, `cos θ`,
`tan θ`, `csc θ`, `sec θ`, and `cot θ`. -/
-- ANCHOR: table417_header
def table417_header : List String :=
  ["θ", "sin θ", "cos θ", "tan θ", "csc θ", "sec θ", "cot θ"]
-- ANCHOR_END: table417_header

/- DLMF 4.17.T1, row 2 -/
/-- DLMF 4.17.T1, row 2: values at `θ = 0`; the reciprocal columns carry
the table's pole marker `∞`. -/
-- ANCHOR: table417_row_zero
def table417_row_zero : TrigSpecialValueRow :=
  { theta := 0
    sinValue := .finite 0
    cosValue := .finite 1
    tanValue := .finite 0
    cscValue := .infinity
    secValue := .finite 1
    cotValue := .infinity }
-- ANCHOR_END: table417_row_zero

/- DLMF 4.17.T1, row 3 -/
/-- DLMF 4.17.T1, row 3: values at `θ = π/12`. -/
-- ANCHOR: table417_row_pi_div_12
def table417_row_pi_div_12 : TrigSpecialValueRow :=
  { theta := Real.pi / 12
    sinValue := .finite (Real.sqrt 2 * (Real.sqrt 3 - 1) / 4)
    cosValue := .finite (Real.sqrt 2 * (Real.sqrt 3 + 1) / 4)
    tanValue := .finite (2 - Real.sqrt 3)
    cscValue := .finite (Real.sqrt 2 * (Real.sqrt 3 + 1))
    secValue := .finite (Real.sqrt 2 * (Real.sqrt 3 - 1))
    cotValue := .finite (2 + Real.sqrt 3) }
-- ANCHOR_END: table417_row_pi_div_12

/- DLMF 4.17.T1, row 4 -/
/-- DLMF 4.17.T1, row 4: values at `θ = π/6`. -/
-- ANCHOR: table417_row_pi_div_6
def table417_row_pi_div_6 : TrigSpecialValueRow :=
  { theta := Real.pi / 6
    sinValue := .finite (1 / 2)
    cosValue := .finite (Real.sqrt 3 / 2)
    tanValue := .finite (Real.sqrt 3 / 3)
    cscValue := .finite 2
    secValue := .finite (2 * Real.sqrt 3 / 3)
    cotValue := .finite (Real.sqrt 3) }
-- ANCHOR_END: table417_row_pi_div_6

/- DLMF 4.17.T1, row 5 -/
/-- DLMF 4.17.T1, row 5: values at `θ = π/4`. -/
-- ANCHOR: table417_row_pi_div_4
def table417_row_pi_div_4 : TrigSpecialValueRow :=
  { theta := Real.pi / 4
    sinValue := .finite (Real.sqrt 2 / 2)
    cosValue := .finite (Real.sqrt 2 / 2)
    tanValue := .finite 1
    cscValue := .finite (Real.sqrt 2)
    secValue := .finite (Real.sqrt 2)
    cotValue := .finite 1 }
-- ANCHOR_END: table417_row_pi_div_4

/- DLMF 4.17.T1, row 6 -/
/-- DLMF 4.17.T1, row 6: values at `θ = π/3`. -/
-- ANCHOR: table417_row_pi_div_3
def table417_row_pi_div_3 : TrigSpecialValueRow :=
  { theta := Real.pi / 3
    sinValue := .finite (Real.sqrt 3 / 2)
    cosValue := .finite (1 / 2)
    tanValue := .finite (Real.sqrt 3)
    cscValue := .finite (2 * Real.sqrt 3 / 3)
    secValue := .finite 2
    cotValue := .finite (Real.sqrt 3 / 3) }
-- ANCHOR_END: table417_row_pi_div_3

/- DLMF 4.17.T1, row 7 -/
/-- DLMF 4.17.T1, row 7: values at `θ = 5π/12`. -/
-- ANCHOR: table417_row_five_pi_div_12
def table417_row_five_pi_div_12 : TrigSpecialValueRow :=
  { theta := 5 * Real.pi / 12
    sinValue := .finite (Real.sqrt 2 * (Real.sqrt 3 + 1) / 4)
    cosValue := .finite (Real.sqrt 2 * (Real.sqrt 3 - 1) / 4)
    tanValue := .finite (2 + Real.sqrt 3)
    cscValue := .finite (Real.sqrt 2 * (Real.sqrt 3 - 1))
    secValue := .finite (Real.sqrt 2 * (Real.sqrt 3 + 1))
    cotValue := .finite (2 - Real.sqrt 3) }
-- ANCHOR_END: table417_row_five_pi_div_12

/- DLMF 4.17.T1, row 8 -/
/-- DLMF 4.17.T1, row 8: values at `θ = π/2`; tangent and secant carry
the table's pole marker `∞`. -/
-- ANCHOR: table417_row_pi_div_2
def table417_row_pi_div_2 : TrigSpecialValueRow :=
  { theta := Real.pi / 2
    sinValue := .finite 1
    cosValue := .finite 0
    tanValue := .infinity
    cscValue := .finite 1
    secValue := .infinity
    cotValue := .finite 0 }
-- ANCHOR_END: table417_row_pi_div_2

/- DLMF 4.17.T1, row 9 -/
/-- DLMF 4.17.T1, row 9: values at `θ = 7π/12`, including the negative
cosine, tangent, secant, and cotangent entries. -/
-- ANCHOR: table417_row_seven_pi_div_12
def table417_row_seven_pi_div_12 : TrigSpecialValueRow :=
  { theta := 7 * Real.pi / 12
    sinValue := .finite (Real.sqrt 2 * (Real.sqrt 3 + 1) / 4)
    cosValue := .finite (-(Real.sqrt 2 * (Real.sqrt 3 - 1) / 4))
    tanValue := .finite (-(2 + Real.sqrt 3))
    cscValue := .finite (Real.sqrt 2 * (Real.sqrt 3 - 1))
    secValue := .finite (-(Real.sqrt 2 * (Real.sqrt 3 + 1)))
    cotValue := .finite (-(2 - Real.sqrt 3)) }
-- ANCHOR_END: table417_row_seven_pi_div_12

/- DLMF 4.17.T1, row 10 -/
/-- DLMF 4.17.T1, row 10: values at `θ = 2π/3`. -/
-- ANCHOR: table417_row_two_pi_div_3
def table417_row_two_pi_div_3 : TrigSpecialValueRow :=
  { theta := 2 * Real.pi / 3
    sinValue := .finite (Real.sqrt 3 / 2)
    cosValue := .finite (-(1 / 2))
    tanValue := .finite (-Real.sqrt 3)
    cscValue := .finite (2 * Real.sqrt 3 / 3)
    secValue := .finite (-2)
    cotValue := .finite (-(Real.sqrt 3 / 3)) }
-- ANCHOR_END: table417_row_two_pi_div_3

/- DLMF 4.17.T1, row 11 -/
/-- DLMF 4.17.T1, row 11: values at `θ = 3π/4`. -/
-- ANCHOR: table417_row_three_pi_div_4
def table417_row_three_pi_div_4 : TrigSpecialValueRow :=
  { theta := 3 * Real.pi / 4
    sinValue := .finite (Real.sqrt 2 / 2)
    cosValue := .finite (-(Real.sqrt 2 / 2))
    tanValue := .finite (-1)
    cscValue := .finite (Real.sqrt 2)
    secValue := .finite (-Real.sqrt 2)
    cotValue := .finite (-1) }
-- ANCHOR_END: table417_row_three_pi_div_4

/- DLMF 4.17.T1, row 12 -/
/-- DLMF 4.17.T1, row 12: values at `θ = 5π/6`. -/
-- ANCHOR: table417_row_five_pi_div_6
def table417_row_five_pi_div_6 : TrigSpecialValueRow :=
  { theta := 5 * Real.pi / 6
    sinValue := .finite (1 / 2)
    cosValue := .finite (-(Real.sqrt 3 / 2))
    tanValue := .finite (-(Real.sqrt 3 / 3))
    cscValue := .finite 2
    secValue := .finite (-(2 * Real.sqrt 3 / 3))
    cotValue := .finite (-Real.sqrt 3) }
-- ANCHOR_END: table417_row_five_pi_div_6

/- DLMF 4.17.T1, row 13 -/
/-- DLMF 4.17.T1, row 13: values at `θ = 11π/12`. -/
-- ANCHOR: table417_row_eleven_pi_div_12
def table417_row_eleven_pi_div_12 : TrigSpecialValueRow :=
  { theta := 11 * Real.pi / 12
    sinValue := .finite (Real.sqrt 2 * (Real.sqrt 3 - 1) / 4)
    cosValue := .finite (-(Real.sqrt 2 * (Real.sqrt 3 + 1) / 4))
    tanValue := .finite (-(2 - Real.sqrt 3))
    cscValue := .finite (Real.sqrt 2 * (Real.sqrt 3 + 1))
    secValue := .finite (-(Real.sqrt 2 * (Real.sqrt 3 - 1)))
    cotValue := .finite (-(2 + Real.sqrt 3)) }
-- ANCHOR_END: table417_row_eleven_pi_div_12

/- DLMF 4.17.T1, row 14 -/
/-- DLMF 4.17.T1, row 14: values at `θ = π`; the reciprocal columns again
carry the table's pole marker `∞`. -/
-- ANCHOR: table417_row_pi
def table417_row_pi : TrigSpecialValueRow :=
  { theta := Real.pi
    sinValue := .finite 0
    cosValue := .finite (-1)
    tanValue := .finite 0
    cscValue := .infinity
    secValue := .finite (-1)
    cotValue := .infinity }
-- ANCHOR_END: table417_row_pi

/- DLMF 4.17.E1 -/
/-- DLMF 4.17.E1: the complex sine quotient tends to `1` as `z → 0`. -/
-- ANCHOR: dlmf_4_17_E1
theorem dlmf_4_17_E1 :
    Tendsto (fun z : ℂ => Complex.sin z / z)
      (nhdsWithin (0 : ℂ) {0}ᶜ) (𝓝 (1 : ℂ)) := by sorry
-- ANCHOR_END: dlmf_4_17_E1

/- DLMF 4.17.E2 -/
/-- DLMF 4.17.E2: the complex tangent quotient tends to `1` as `z → 0`. -/
-- ANCHOR: dlmf_4_17_E2
theorem dlmf_4_17_E2 :
    Tendsto (fun z : ℂ => Complex.tan z / z)
      (nhdsWithin (0 : ℂ) {0}ᶜ) (𝓝 (1 : ℂ)) := by sorry
-- ANCHOR_END: dlmf_4_17_E2

/- DLMF 4.17.E3 -/
/-- DLMF 4.17.E3: `(1 - cos z) / z²` tends to `1/2` as `z → 0` in the
complex plane. -/
-- ANCHOR: dlmf_4_17_E3
theorem dlmf_4_17_E3 :
    Tendsto (fun z : ℂ => (1 - Complex.cos z) / z ^ 2)
      (nhdsWithin (0 : ℂ) {0}ᶜ)
      (𝓝 ((1 : ℂ) / 2)) := by sorry
-- ANCHOR_END: dlmf_4_17_E3

end LMLF.Blueprint.Elementary.Section417
