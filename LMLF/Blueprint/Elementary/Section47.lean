import Mathlib.Analysis.Complex.Basic
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
import Mathlib.Analysis.Analytic.Basic
import Mathlib.Analysis.SpecialFunctions.Complex.Log
import Mathlib.Analysis.SpecialFunctions.Pow.Complex
import Mathlib.Analysis.RCLike.Sqrt

open Set
open scoped BigOperators

noncomputable section

namespace LMLF.Blueprint.Elementary.Section47

/-! DLMF §4.7: derivatives and differential equations for logarithms,
exponentials, and powers.  The declarations use `deriv` and `iteratedDeriv`;
the branch-sensitive general-logarithm formulas are stated with their branch
function made explicit. -/

/-- DLMF 4.7.1: derivative of the principal logarithm. -/
-- ANCHOR: dlmf_4_7_1
theorem principalLog_deriv {z : ℂ} (hz : z ∈ Complex.slitPlane) :
    deriv Complex.log z = 1 / z
-- ANCHOR_END: dlmf_4_7_1
    := by sorry

/-- DLMF 4.7.2: every chosen branch of the logarithm has derivative `1 / z`. -/
-- ANCHOR: dlmf_4_7_2
theorem generalLog_deriv (Ln : ℂ → ℂ) {z : ℂ} (hz : z ≠ 0)
    (hLn : HasDerivAt Ln (1 / z) z) :
    deriv Ln z = 1 / z
-- ANCHOR_END: dlmf_4_7_2
    := by sorry

/-- DLMF 4.7.3: n-th derivative of the principal logarithm. -/
-- ANCHOR: dlmf_4_7_3
theorem principalLog_iteratedDeriv {z : ℂ} (n : ℕ) (hn : 0 < n)
    (hz : z ∈ Complex.slitPlane) :
    iteratedDeriv n Complex.log z =
      (-1 : ℂ) ^ (n - 1) * (n - 1).factorial * z ^ (-n : ℤ)
-- ANCHOR_END: dlmf_4_7_3
      := by sorry

/-- DLMF 4.7.4: n-th derivative of a chosen general logarithm branch. -/
-- ANCHOR: dlmf_4_7_4
theorem generalLog_iteratedDeriv (Ln : ℂ → ℂ) (U : Set ℂ) {z : ℂ} (n : ℕ)
    (hUopen : IsOpen U) (hn : 0 < n) (hz : z ∈ U)
    (hLn : ∀ w ∈ U, HasDerivAt Ln (1 / w) w) :
    iteratedDeriv n Ln z = (-1 : ℂ) ^ (n - 1) * (n - 1).factorial * z ^ (-n : ℤ)
-- ANCHOR_END: dlmf_4_7_4
    := by sorry

/-- DLMF 4.7.5: logarithmic differential equation for a nonvanishing analytic `f`. -/
-- ANCHOR: dlmf_4_7_5
def logarithmicDifferentialEquation (f w : ℂ → ℂ) (U : Set ℂ) : Prop :=
  ∀ z ∈ U, HasDerivAt w (deriv f z / f z) z
-- ANCHOR_END: dlmf_4_7_5

/-- DLMF 4.7.6: a local solution is a chosen logarithm of `f`, up to a constant. -/
-- ANCHOR: dlmf_4_7_6
theorem logarithmicSolution (f w Ln : ℂ → ℂ) (U : Set ℂ)
    (hUopen : IsOpen U) (hUconn : IsPreconnected U)
    (hODE : ∀ z ∈ U, HasDerivAt w (deriv f z / f z) z)
    (hLn : ∀ z ∈ U, HasDerivAt (fun u => Ln (f u)) (deriv f z / f z) z) :
    ∃ C : ℂ, ∀ z ∈ U, w z - Ln (f z) = C
-- ANCHOR_END: dlmf_4_7_6
    := by sorry

/-- DLMF 4.7.7: derivative of the exponential. -/
-- ANCHOR: dlmf_4_7_7
theorem exp_deriv (z : ℂ) : deriv Complex.exp z = Complex.exp z
-- ANCHOR_END: dlmf_4_7_7
:= by sorry

/-- DLMF 4.7.8: derivative of `exp (a z)`. -/
-- ANCHOR: dlmf_4_7_8
theorem exp_mul_deriv (a z : ℂ) :
    deriv (fun w : ℂ => Complex.exp (a * w)) z = a * Complex.exp (a * z)
-- ANCHOR_END: dlmf_4_7_8
    := by sorry

/-- DLMF 4.7.9: derivative of the principal power `a ^ z`, for `a ≠ 0`. -/
-- ANCHOR: dlmf_4_7_9
theorem cpow_deriv (a z : ℂ) (ha : a ≠ 0) :
    deriv (fun w : ℂ => a ^ w) z = a ^ z * Complex.log a
-- ANCHOR_END: dlmf_4_7_9
    := by sorry

/-- DLMF 4.7.10: derivative of `z ^ a` on a branch domain. -/
-- ANCHOR: dlmf_4_7_10
theorem z_cpow_deriv (a : ℂ) (U : Set ℂ) {z : ℂ} (hz : z ∈ U)
    (hU : ∀ w ∈ U, w ∈ Complex.slitPlane) :
    deriv (fun w : ℂ => Complex.exp (a * Complex.log w)) z =
      a * Complex.exp (a * Complex.log z) / z
-- ANCHOR_END: dlmf_4_7_10
      := by sorry

/-- DLMF 4.7.11: n-th derivative of a power. -/
-- ANCHOR: dlmf_4_7_11
theorem z_cpow_iteratedDeriv (a : ℂ) (U : Set ℂ) {z : ℂ} (n : ℕ)
    (hz : z ∈ U) (hU : ∀ w ∈ U, w ∈ Complex.slitPlane) :
    iteratedDeriv n (fun w : ℂ => Complex.exp (a * Complex.log w)) z =
      (∏ k : Fin n, (a - (k : ℂ))) * Complex.exp (a * Complex.log z) / z ^ n
-- ANCHOR_END: dlmf_4_7_11
      := by sorry

/-- DLMF 4.7.12: first-order linear differential equation. -/
-- ANCHOR: dlmf_4_7_12
def linearDifferentialEquation (f w : ℂ → ℂ) (U : Set ℂ) : Prop :=
  ∀ z ∈ U, HasDerivAt w (f z * w z) z
-- ANCHOR_END: dlmf_4_7_12

/-- DLMF 4.7.13: solution represented by an exponential of an antiderivative. -/
-- ANCHOR: dlmf_4_7_13
theorem linearDifferentialSolution (f F w : ℂ → ℂ) (U : Set ℂ)
    (hUopen : IsOpen U) (hUconn : IsPreconnected U)
    (hF : ∀ z ∈ U, HasDerivAt F (f z) z)
    (hw : ∀ z ∈ U, HasDerivAt w (f z * w z) z)
    (hw0 : ∀ z ∈ U, w z ≠ 0) :
    (∃ C : ℂ, C ≠ 0 ∧ ∀ z ∈ U, w z = C * Complex.exp (F z))
-- ANCHOR_END: dlmf_4_7_13
    := by sorry

/-- DLMF 4.7.14: constant-coefficient second-order equation. -/
-- ANCHOR: dlmf_4_7_14
def secondOrderExponentialEquation (a : ℂ) (w : ℂ → ℂ) (U : Set ℂ) : Prop :=
  (a ≠ 0) ∧ ∀ z ∈ U, HasDerivAt (deriv w) (a * w z) z
-- ANCHOR_END: dlmf_4_7_14

/-- DLMF 4.7.15: the two-exponential general solution, with a chosen square root. -/
-- ANCHOR: dlmf_4_7_15
theorem secondOrderExponentialSolution (a : ℂ) (w : ℂ → ℂ) (U : Set ℂ)
    (ha : a ≠ 0) (hUopen : IsOpen U) (hUconn : IsPreconnected U)
    (hsq : (Complex.sqrt a) ^ 2 = a)
    (hw : ∀ z ∈ U, HasDerivAt (deriv w) (a * w z) z) :
    (∃ A B : ℂ, ∀ z ∈ U, w z = A * Complex.exp (Complex.sqrt a * z) +
      B * Complex.exp (-Complex.sqrt a * z))
-- ANCHOR_END: dlmf_4_7_15
      := by sorry

end LMLF.Blueprint.Elementary.Section47
