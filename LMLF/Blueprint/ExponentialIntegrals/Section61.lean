import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.SpecialFunctions.Gamma.Digamma

/-! DLMF §6.1 special notation.  This page has no numbered formulas: these
declarations expose the notation and vocabulary used by the later sections. -/
namespace LMLF.Blueprint.ExponentialIntegrals.Section61

/-- DLMF 6.1 table: a real variable. -/
-- ANCHOR: dlmf_6_1_real_variable
abbrev RealVariable := ℝ
-- ANCHOR_END: dlmf_6_1_real_variable

/-- DLMF 6.1 table: a complex variable. -/
-- ANCHOR: dlmf_6_1_complex_variable
abbrev ComplexVariable := ℂ
-- ANCHOR_END: dlmf_6_1_complex_variable

/-- DLMF 6.1 table: a nonnegative integer index. -/
-- ANCHOR: dlmf_6_1_nonnegative_index
abbrev NonnegativeIndex := ℕ
-- ANCHOR_END: dlmf_6_1_nonnegative_index

/-- DLMF 6.1 table: an arbitrary small positive constant. -/
-- ANCHOR: dlmf_6_1_small_positive
def SmallPositive (δ : ℝ) : Prop := 0 < δ
-- ANCHOR_END: dlmf_6_1_small_positive

/-- DLMF 6.1 table: Euler's constant γ. -/
-- ANCHOR: dlmf_6_1_euler_constant
noncomputable abbrev eulerConstant : ℝ := Real.eulerMascheroniConstant
-- ANCHOR_END: dlmf_6_1_euler_constant

/-- DLMF 6.1 prose: a prime denotes differentiation with respect to the argument. -/
-- ANCHOR: dlmf_6_1_argument_derivative
noncomputable def argumentDerivative (f : ℂ → ℂ) (z : ℂ) : ℂ := deriv f z
-- ANCHOR_END: dlmf_6_1_argument_derivative

/-- DLMF 6.1 prose: principal functions treated in Chapter 6. -/
-- ANCHOR: dlmf_6_1_function_names
inductive Chapter6Function
  | Ei | E1 | Ein | li | Si | si | Ci | Cin
deriving DecidableEq, Repr
-- ANCHOR_END: dlmf_6_1_function_names

/-- DLMF 6.1 prose: a symbolic notation not defined on this page. -/
-- ANCHOR: dlmf_6_1_external_notation
inductive ExternalNotation
  | notationForSpecialFunctions
deriving DecidableEq, Repr
-- ANCHOR_END: dlmf_6_1_external_notation

end LMLF.Blueprint.ExponentialIntegrals.Section61
