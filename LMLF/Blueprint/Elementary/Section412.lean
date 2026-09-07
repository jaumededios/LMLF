import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.Calculus.ContDiff.Basic

noncomputable section

namespace LMLF.Blueprint.Elementary.Section412

open Set

/-- DLMF 4.12.7 and 4.12.9: `n`-fold iteration of a real function. -/
-- ANCHOR: iterateRealFunction
def iterateRealFunction (f : ℝ → ℝ) (n : ℕ) (x : ℝ) : ℝ :=
  match n with
  | 0 => x
  | n + 1 => f (iterateRealFunction f n x)
-- ANCHOR_END: iterateRealFunction

/-- DLMF 4.12.7: the iterated exponential used in the generalized exponential. -/
-- ANCHOR: iteratedExp
def iteratedExp (n : ℕ) (x : ℝ) : ℝ :=
  iterateRealFunction Real.exp n x
-- ANCHOR_END: iteratedExp

/-- DLMF 4.12.9: the iterated principal logarithm used in the generalized logarithm. -/
-- ANCHOR: iteratedLog
def iteratedLog (n : ℕ) (x : ℝ) : ℝ :=
  iterateRealFunction Real.log n x
-- ANCHOR_END: iteratedLog

/-- Every intermediate input in an `n`-fold principal-logarithm iteration is
positive; this prevents Mathlib's totalized `Real.log` from creating spurious
iteration counts after reaching zero. -/
-- ANCHOR: iteratedLogDefined
def iteratedLogDefined (n : ℕ) (x : ℝ) : Prop :=
  ∀ k < n, 0 < iteratedLog k x
-- ANCHOR_END: iteratedLogDefined

/-- A generalized exponential with the recurrence and regularity data used in
§4.12. The fields make the displayed formulas reusable without repeating
their conclusions as theorem hypotheses. -/
-- ANCHOR: GeneralizedExponential
structure GeneralizedExponential where
  toFun : ℝ → ℝ
  recurrence : ∀ y, -1 < y → toFun (y + 1) = Real.exp (toFun y)
  zero : toFun 0 = 0
  identityOnUnit : ∀ x ∈ Icc (0 : ℝ) 1, toFun x = x
  negativeBranch : ∀ x, -1 < x → x < 0 → toFun x = Real.log (x + 1)
  positiveBranch : ∀ x, 1 < x → toFun x = iteratedExp ⌊x⌋₊ (x - ⌊x⌋₊)
  strictMono : StrictMonoOn toFun (Icc (0 : ℝ) 1)
  contDiff : ContDiff ℝ 1 toFun
-- ANCHOR_END: GeneralizedExponential

/-- A generalized logarithm with the corresponding shift, branch, and
regularity data from §4.12. -/
-- ANCHOR: GeneralizedLogarithm
structure GeneralizedLogarithm where
  toFun : ℝ → ℝ
  shift : ∀ x : ℝ, toFun (Real.exp x) = 1 + toFun x
  zero : toFun 0 = 0
  identityOnUnit : ∀ x ∈ Icc (0 : ℝ) 1, toFun x = x
  negativeBranch : ∀ x, x < 0 → toFun x = Real.exp x - 1
  positiveBranch : ∀ x, 1 < x → ∃ l : ℕ, 0 < l ∧ toFun x = l + iteratedLog l x
  strictMono : StrictMonoOn toFun (Icc (0 : ℝ) 1)
  contDiff : ContDiff ℝ 1 toFun
-- ANCHOR_END: GeneralizedLogarithm

/-- A paired generalized exponential and logarithm, with the inverse
relationship asserted in both directions. -/
-- ANCHOR: GeneralizedFunctionPair
structure GeneralizedFunctionPair where
  exponential : GeneralizedExponential
  logarithm : GeneralizedLogarithm
  leftInverse : Function.LeftInverse logarithm.toFun exponential.toFun
  rightInverse : Function.RightInverse logarithm.toFun exponential.toFun
-- ANCHOR_END: GeneralizedFunctionPair

/-- DLMF 4.12.1: defining recurrence for a generalized exponential. -/
-- ANCHOR: dlmf_4_12_1
theorem dlmf_4_12_1 (φ : GeneralizedExponential)
    {x : ℝ} (hx : -1 < x) :
    φ.toFun (x + 1) = Real.exp (φ.toFun x)
-- ANCHOR_END: dlmf_4_12_1
    := by sorry

/-- DLMF 4.12.2: normalization at the origin for a generalized exponential. -/
-- ANCHOR: dlmf_4_12_2
theorem dlmf_4_12_2 (φ : GeneralizedExponential) : φ.toFun 0 = 0
-- ANCHOR_END: dlmf_4_12_2
    := by sorry

/-- DLMF 4.12.3: defining inverse-shift relation for a generalized logarithm. -/
-- ANCHOR: dlmf_4_12_3
theorem dlmf_4_12_3 (ψ : GeneralizedLogarithm) (x : ℝ) :
    ψ.toFun (Real.exp x) = 1 + ψ.toFun x
-- ANCHOR_END: dlmf_4_12_3
    := by sorry

/-- DLMF 4.12.4: normalization at the origin for a generalized logarithm. -/
-- ANCHOR: dlmf_4_12_4
theorem dlmf_4_12_4 (ψ : GeneralizedLogarithm) : ψ.toFun 0 = 0
-- ANCHOR_END: dlmf_4_12_4
    := by sorry

/-- DLMF 4.12.5: the simplest generalized exponential and logarithm are both
the identity on `[0,1]`. -/
-- ANCHOR: dlmf_4_12_5
theorem dlmf_4_12_5 (φ : GeneralizedExponential) (ψ : GeneralizedLogarithm)
    {x : ℝ} (hx : x ∈ Set.Icc (0 : ℝ) 1) :
    φ.toFun x = x ∧ ψ.toFun x = x
-- ANCHOR_END: dlmf_4_12_5
    := by sorry

/-- DLMF 4.12.6: the first continuation of the simplest generalized
exponential is the principal logarithm on `(-1,0)`. -/
-- ANCHOR: dlmf_4_12_6
theorem dlmf_4_12_6 (φ : GeneralizedExponential)
    {x : ℝ} (hx₁ : -1 < x) (hx₂ : x < 0) :
    φ.toFun x = Real.log (x + 1)
-- ANCHOR_END: dlmf_4_12_6
    := by sorry

/-- DLMF 4.12.7: for `x>1`, the generalized exponential is the iterated
exponential applied to the fractional part of `x`. -/
-- ANCHOR: dlmf_4_12_7
theorem dlmf_4_12_7 (φ : GeneralizedExponential)
    {x : ℝ} (hx : 1 < x) :
    φ.toFun x = iteratedExp ⌊x⌋₊ (x - ⌊x⌋₊)
-- ANCHOR_END: dlmf_4_12_7
    := by sorry

/-- DLMF 4.12.8: the corresponding generalized logarithm on the negative
half-line is `exp x - 1`. -/
-- ANCHOR: dlmf_4_12_8
theorem dlmf_4_12_8 (ψ : GeneralizedLogarithm)
    {x : ℝ} (hx : x < 0) :
    ψ.toFun x = Real.exp x - 1
-- ANCHOR_END: dlmf_4_12_8
    := by sorry

/-- DLMF 4.12.9: for `x>1`, the generalized logarithm is a positive integer
plus that many iterated principal logarithms. -/
-- ANCHOR: dlmf_4_12_9
theorem dlmf_4_12_9 (ψ : GeneralizedLogarithm)
    {x : ℝ} (hx : 1 < x) :
    ∃ l : ℕ, 0 < l ∧ ψ.toFun x = l + iteratedLog l x
-- ANCHOR_END: dlmf_4_12_9
    := by sorry

/-- DLMF 4.12.10: the iteration count is selected by the unit-interval
condition on the iterated logarithm. -/
-- ANCHOR: dlmf_4_12_10
theorem dlmf_4_12_10 (x : ℝ)
    (hx : 1 < x) :
    ∃! l : ℕ, 0 < l ∧ iteratedLogDefined l x ∧
      0 ≤ iteratedLog l x ∧ iteratedLog l x < 1
-- ANCHOR_END: dlmf_4_12_10
    := by sorry

/-- DLMF §4.12: both generalized functions are strictly increasing on the
closed unit interval. -/
-- ANCHOR: generalized_functions_strictMono
theorem generalized_functions_strictMono (φ : GeneralizedExponential)
    (ψ : GeneralizedLogarithm) :
    StrictMonoOn φ.toFun (Icc (0 : ℝ) 1) ∧
      StrictMonoOn ψ.toFun (Icc (0 : ℝ) 1)
-- ANCHOR_END: generalized_functions_strictMono
    := by sorry

/-- DLMF §4.12: both generalized functions are continuously differentiable. -/
-- ANCHOR: generalized_functions_contDiff
theorem generalized_functions_contDiff (φ : GeneralizedExponential)
    (ψ : GeneralizedLogarithm) :
    ContDiff ℝ 1 φ.toFun ∧ ContDiff ℝ 1 ψ.toFun
-- ANCHOR_END: generalized_functions_contDiff
    := by sorry

/-- The paired generalized functions are mutual inverses. -/
-- ANCHOR: generalized_functions_inverse
theorem generalized_functions_inverse (p : GeneralizedFunctionPair) :
    Function.LeftInverse p.logarithm.toFun p.exponential.toFun ∧
      Function.RightInverse p.logarithm.toFun p.exponential.toFun
-- ANCHOR_END: generalized_functions_inverse
    := by sorry

end LMLF.Blueprint.Elementary.Section412
