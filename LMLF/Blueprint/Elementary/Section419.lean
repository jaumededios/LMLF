import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Cotangent
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Series
import Mathlib.NumberTheory.Bernoulli

/-!
# DLMF §4.19: Maclaurin and Laurent series

The summands below use the Bernoulli and Euler numbers in the conventions of
DLMF §24.2.  The statements deliberately use `HasSum`, so that convergence
and the exact coefficient sequence are visible to downstream users.
-/

namespace LMLF.Blueprint.Elementary.Section419

open scoped BigOperators

noncomputable section

/-! These symbols abbreviate the standard sequences from DLMF §24.2. -/
/-- DLMF §24.2: Bernoulli numbers in the convention used by §4.19. -/
-- ANCHOR: bernoulliNumber
def bernoulliNumber (n : ℕ) : ℂ := (bernoulli n : ℂ)
-- ANCHOR_END: bernoulliNumber
/-- DLMF §24.2: Euler numbers in the convention used by §4.19. -/
-- ANCHOR: eulerNumber
def eulerNumber : ℕ → ℂ
  | 0 => 1
  | n + 1 =>
      if Even (n + 1) then
        -(∑ k : Fin ((n + 1) / 2),
          (Nat.choose (n + 1) (2 * k.1) : ℂ) * eulerNumber (2 * k.1))
      else 0
termination_by n => n
decreasing_by
  simp_wf
  omega
-- ANCHOR_END: eulerNumber

/-- DLMF §4.19.4: totalized notation for the cosecant function. -/
-- ANCHOR: csc
def csc (z : ℂ) : ℂ := 1 / Complex.sin z
-- ANCHOR_END: csc
/-- DLMF §4.19.5: totalized notation for the secant function. -/
-- ANCHOR: sec
def sec (z : ℂ) : ℂ := 1 / Complex.cos z
-- ANCHOR_END: sec

/-- DLMF §4.19.7: the removable extension of `sin z / z` at zero. -/
-- ANCHOR: sinRatio
def sinRatio (z : ℂ) : ℂ := if z = 0 then 1 else Complex.sin z / z
-- ANCHOR_END: sinRatio

/-- DLMF §4.19.9: the removable extension of `tan z / z` at zero. -/
-- ANCHOR: tanRatio
def tanRatio (z : ℂ) : ℂ := if z = 0 then 1 else Complex.tan z / z
-- ANCHOR_END: tanRatio

/- DLMF §4.19.3: the coefficient of z^(2n+1) in the tangent series. -/
/-- DLMF §4.19.3: tangent-series summand, indexed from n = 1. -/
-- ANCHOR: tanTerm
def tanTerm (z : ℂ) (n : ℕ) : ℂ :=
  let m := n + 1
  ((-1 : ℂ) ^ (m - 1) * (2 : ℂ) ^ (2 * m) *
      ((2 : ℂ) ^ (2 * m) - 1) * bernoulliNumber (2 * m) /
      (Nat.factorial (2 * m) : ℂ)) * z ^ (2 * m - 1)
-- ANCHOR_END: tanTerm

/- DLMF §4.19.4: the non-principal-part terms of the cosecant Laurent series. -/
/-- DLMF §4.19.4: cosecant Laurent-series summand after 1/z. -/
-- ANCHOR: cscTerm
def cscTerm (z : ℂ) (n : ℕ) : ℂ :=
  let m := n + 1
  ((-1 : ℂ) ^ (m - 1) * 2 *
      ((2 : ℂ) ^ (2 * m - 1) - 1) * bernoulliNumber (2 * m) /
      (Nat.factorial (2 * m) : ℂ)) * z ^ (2 * m - 1)
-- ANCHOR_END: cscTerm

/- DLMF §4.19.5: the coefficient of z^(2n) in the secant series. -/
/-- DLMF §4.19.5: secant-series summand. -/
-- ANCHOR: secTerm
def secTerm (z : ℂ) (n : ℕ) : ℂ :=
  (-1 : ℂ) ^ n * eulerNumber (2 * n) /
      (Nat.factorial (2 * n) : ℂ) * z ^ (2 * n)
-- ANCHOR_END: secTerm

/- DLMF §4.19.6: the non-principal-part terms of the cotangent Laurent series. -/
/-- DLMF §4.19.6: cotangent Laurent-series summand after 1/z. -/
-- ANCHOR: cotTerm
def cotTerm (z : ℂ) (n : ℕ) : ℂ :=
  -(((-1 : ℂ) ^ n) * (2 : ℂ) ^ (2 * (n + 1)) *
      bernoulliNumber (2 * (n + 1)) / (Nat.factorial (2 * (n + 1)) : ℂ) *
      z ^ (2 * (n + 1) - 1))
-- ANCHOR_END: cotTerm

/- DLMF §4.19.7: the coefficient of z^(2n) in log(sin z / z). -/
/-- DLMF §4.19.7: summand for log(sin z / z). -/
-- ANCHOR: logSinRatioTerm
def logSinRatioTerm (z : ℂ) (n : ℕ) : ℂ :=
  let m := n + 1
  ((-1 : ℂ) ^ m * (2 : ℂ) ^ (2 * m - 1) * bernoulliNumber (2 * m) /
      ((m : ℂ) * (Nat.factorial (2 * m) : ℂ))) * z ^ (2 * m)
-- ANCHOR_END: logSinRatioTerm

/- DLMF §4.19.8: the coefficient of z^(2n) in log(cos z). -/
/-- DLMF §4.19.8: summand for log(cos z). -/
-- ANCHOR: logCosTerm
def logCosTerm (z : ℂ) (n : ℕ) : ℂ :=
  let m := n + 1
  ((-1 : ℂ) ^ m * (2 : ℂ) ^ (2 * m - 1) *
      ((2 : ℂ) ^ (2 * m) - 1) * bernoulliNumber (2 * m) /
      ((m : ℂ) * (Nat.factorial (2 * m) : ℂ))) * z ^ (2 * m)
-- ANCHOR_END: logCosTerm

/- DLMF §4.19.9: the coefficient of z^(2n) in log(tan z / z). -/
/-- DLMF §4.19.9: summand for log(tan z / z). -/
-- ANCHOR: logTanRatioTerm
def logTanRatioTerm (z : ℂ) (n : ℕ) : ℂ :=
  let m := n + 1
  ((-1 : ℂ) ^ (m - 1) * (2 : ℂ) ^ (2 * m) *
      ((2 : ℂ) ^ (2 * m - 1) - 1) * bernoulliNumber (2 * m) /
      ((m : ℂ) * (Nat.factorial (2 * m) : ℂ))) * z ^ (2 * m)
-- ANCHOR_END: logTanRatioTerm

/-- DLMF §4.19.1: Maclaurin series for sine. -/
-- ANCHOR: dlmf_4_19_1
theorem dlmf_4_19_1 (z : ℂ) :
    HasSum (fun n : ℕ ↦ (-1 : ℂ) ^ n * z ^ (2 * n + 1) /
      (Nat.factorial (2 * n + 1) : ℂ)) (Complex.sin z) := by sorry
-- ANCHOR_END: dlmf_4_19_1

/-- DLMF §4.19.2: Maclaurin series for cosine. -/
-- ANCHOR: dlmf_4_19_2
theorem dlmf_4_19_2 (z : ℂ) :
    HasSum (fun n : ℕ ↦ (-1 : ℂ) ^ n * z ^ (2 * n) /
      (Nat.factorial (2 * n) : ℂ)) (Complex.cos z) := by sorry
-- ANCHOR_END: dlmf_4_19_2

/-- DLMF §4.19.3: tangent power series on the disk |z| < π/2. -/
-- ANCHOR: dlmf_4_19_3
theorem dlmf_4_19_3 {z : ℂ} (hz : ‖z‖ < Real.pi / 2) :
    HasSum (tanTerm z) (Complex.tan z) := by sorry
-- ANCHOR_END: dlmf_4_19_3

/-- DLMF §4.19.4: cosecant Laurent series on 0 < |z| < π. -/
-- ANCHOR: dlmf_4_19_4
theorem dlmf_4_19_4 {z : ℂ} (hz0 : 0 < ‖z‖) (hzπ : ‖z‖ < Real.pi) :
    HasSum (cscTerm z) (csc z - 1 / z) := by sorry
-- ANCHOR_END: dlmf_4_19_4

/-- DLMF §4.19.5: secant power series on the disk |z| < π/2. -/
-- ANCHOR: dlmf_4_19_5
theorem dlmf_4_19_5 {z : ℂ} (hz : ‖z‖ < Real.pi / 2) :
    HasSum (secTerm z) (sec z) := by sorry
-- ANCHOR_END: dlmf_4_19_5

/-- DLMF §4.19.6: cotangent Laurent series on 0 < |z| < π. -/
-- ANCHOR: dlmf_4_19_6
theorem dlmf_4_19_6 {z : ℂ} (hz0 : 0 < ‖z‖) (hzπ : ‖z‖ < Real.pi) :
    HasSum (cotTerm z) (Complex.cot z - 1 / z) := by sorry
-- ANCHOR_END: dlmf_4_19_6

/-- DLMF §4.19.7: principal-log series for sin z / z on |z| < π. -/
-- ANCHOR: dlmf_4_19_7
theorem dlmf_4_19_7 {z : ℂ} (hz : ‖z‖ < Real.pi) :
    HasSum (logSinRatioTerm z) (Complex.log (sinRatio z)) := by sorry
-- ANCHOR_END: dlmf_4_19_7

/-- DLMF §4.19.8: principal-log series for cos z on |z| < π/2. -/
-- ANCHOR: dlmf_4_19_8
theorem dlmf_4_19_8 {z : ℂ} (hz : ‖z‖ < Real.pi / 2) :
    HasSum (logCosTerm z) (Complex.log (Complex.cos z)) := by sorry
-- ANCHOR_END: dlmf_4_19_8

/-- DLMF §4.19.9: principal-log series for tan z / z on |z| < π/2. -/
-- ANCHOR: dlmf_4_19_9
theorem dlmf_4_19_9 {z : ℂ} (hz : ‖z‖ < Real.pi / 2) :
    HasSum (logTanRatioTerm z) (Complex.log (tanRatio z)) := by sorry
-- ANCHOR_END: dlmf_4_19_9

end

end LMLF.Blueprint.Elementary.Section419
