import Mathlib.Analysis.SpecialFunctions.Trigonometric.Inverse

noncomputable section

namespace LMLF.Blueprint.Elementary.Section430

/-! Table 4.30.1 from DLMF §4.30.  Each row is a six-column lookup for the
real, nonnegative, finite regime named by the source.  `Real.sqrt` supplies the
principal square root, and the displayed quotients use Lean's totalized
division outside their mathematical domains. -/

/-- DLMF 4.30.T1.t1.r1: column headings and row shape of Table 4.30.1. -/
-- ANCHOR: HyperbolicInterrelationRow
structure HyperbolicInterrelationRow where
  label : String
  sinhColumn : ℝ → ℝ
  coshColumn : ℝ → ℝ
  tanhColumn : ℝ → ℝ
  cschColumn : ℝ → ℝ
  sechColumn : ℝ → ℝ
  cothColumn : ℝ → ℝ
-- ANCHOR_END: HyperbolicInterrelationRow

/-- DLMF 4.30.T1.t1.r2: row headed by `sinh θ`. -/
-- ANCHOR: table4301_sinhRow
def table4301_sinhRow : HyperbolicInterrelationRow :=
  { label := "sinh"
    sinhColumn := fun a => a
    coshColumn := fun a => Real.sqrt (a ^ 2 - 1)
    tanhColumn := fun a => a / Real.sqrt (1 - a ^ 2)
    cschColumn := fun a => 1 / a
    sechColumn := fun a => Real.sqrt (1 - a ^ 2) / a
    cothColumn := fun a => 1 / Real.sqrt (a ^ 2 - 1) }
-- ANCHOR_END: table4301_sinhRow

/-- DLMF 4.30.T1.t1.r3: row headed by `cosh θ`. -/
-- ANCHOR: table4301_coshRow
def table4301_coshRow : HyperbolicInterrelationRow :=
  { label := "cosh"
    sinhColumn := fun a => Real.sqrt (1 + a ^ 2)
    coshColumn := fun a => a
    tanhColumn := fun a => 1 / Real.sqrt (1 - a ^ 2)
    cschColumn := fun a => Real.sqrt (1 + a ^ 2) / a
    sechColumn := fun a => 1 / a
    cothColumn := fun a => a / Real.sqrt (a ^ 2 - 1) }
-- ANCHOR_END: table4301_coshRow

/-- DLMF 4.30.T1.t1.r4: row headed by `tanh θ`. -/
-- ANCHOR: table4301_tanhRow
def table4301_tanhRow : HyperbolicInterrelationRow :=
  { label := "tanh"
    sinhColumn := fun a => a / Real.sqrt (1 + a ^ 2)
    coshColumn := fun a => Real.sqrt (a ^ 2 - 1) / a
    tanhColumn := fun a => a
    cschColumn := fun a => 1 / Real.sqrt (1 + a ^ 2)
    sechColumn := fun a => Real.sqrt (1 - a ^ 2)
    cothColumn := fun a => 1 / a }
-- ANCHOR_END: table4301_tanhRow

/-- DLMF 4.30.T1.t1.r5: row headed by `csch θ`. -/
-- ANCHOR: table4301_cschRow
def table4301_cschRow : HyperbolicInterrelationRow :=
  { label := "csch"
    sinhColumn := fun a => 1 / a
    coshColumn := fun a => 1 / Real.sqrt (a ^ 2 - 1)
    tanhColumn := fun a => Real.sqrt (1 - a ^ 2) / a
    cschColumn := fun a => a
    sechColumn := fun a => a / Real.sqrt (1 - a ^ 2)
    cothColumn := fun a => Real.sqrt (a ^ 2 - 1) }
-- ANCHOR_END: table4301_cschRow

/-- DLMF 4.30.T1.t1.r6: row headed by `sech θ`. -/
-- ANCHOR: table4301_sechRow
def table4301_sechRow : HyperbolicInterrelationRow :=
  { label := "sech"
    sinhColumn := fun a => 1 / Real.sqrt (1 + a ^ 2)
    coshColumn := fun a => 1 / a
    tanhColumn := fun a => Real.sqrt (1 - a ^ 2)
    cschColumn := fun a => a / Real.sqrt (1 + a ^ 2)
    sechColumn := fun a => a
    cothColumn := fun a => Real.sqrt (a ^ 2 - 1) / a }
-- ANCHOR_END: table4301_sechRow

/-- DLMF 4.30.T1.t1.r7: row headed by `coth θ`. -/
-- ANCHOR: table4301_cothRow
def table4301_cothRow : HyperbolicInterrelationRow :=
  { label := "coth"
    sinhColumn := fun a => Real.sqrt (a ^ 2 + 1) / a
    coshColumn := fun a => a * Real.sqrt (a ^ 2 - 1)⁻¹
    tanhColumn := fun a => 1 / a
    cschColumn := fun a => Real.sqrt (a ^ 2 + 1)
    sechColumn := fun a => Real.sqrt (1 - a ^ 2)⁻¹
    cothColumn := fun a => a }
-- ANCHOR_END: table4301_cothRow

/-- DLMF 4.30.T1: all six rows of the hyperbolic interrelation table. -/
-- ANCHOR: table4301
def table4301 : List HyperbolicInterrelationRow :=
  [table4301_sinhRow, table4301_coshRow, table4301_tanhRow,
    table4301_cschRow, table4301_sechRow, table4301_cothRow]
-- ANCHOR_END: table4301

end LMLF.Blueprint.Elementary.Section430
