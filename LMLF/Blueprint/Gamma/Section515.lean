import LMLF.Quantitative.Series
import Mathlib.Analysis.SpecialFunctions.Gamma.Digamma
import Mathlib.NumberTheory.Bernoulli
import Mathlib.NumberTheory.LSeries.RiemannZeta

open Filter Set Asymptotics
open scoped BigOperators

noncomputable section

namespace LMLF.Blueprint.Gamma.Section515

/-- DLMF §5.15: `ψ⁽ⁿ⁾` is the `n`-th iterated derivative of the digamma function. -/
noncomputable def polygamma (n : ℕ) (z : ℂ) : ℂ :=
  iteratedDeriv n Complex.digamma z

/-- DLMF 5.15.6: the `n`-th derivative of `cot (π z)`. -/
noncomputable def cotPiDerivative (n : ℕ) (z : ℂ) : ℂ :=
  iteratedDeriv n (fun w : ℂ ↦ Complex.cot ((Real.pi : ℂ) * w)) z

/-- DLMF 5.15.8: the positive-real restriction of the trigamma function. -/
noncomputable def realPolygamma (n : ℕ) (x : ℝ) : ℝ :=
  (polygamma n (x : ℂ)).re

/-- DLMF 5.15.8: terms indexed from zero; the tail uses source index `j = k - 1`. -/
noncomputable def trigammaAsymptoticTerm (k : ℕ) (x : ℝ) : ℝ :=
  if k = 0 then 1 / x
  else if k = 1 then 1 / (2 * x ^ 2)
  else
    let j := k - 1
    (bernoulli (2 * j) : ℝ) / x ^ (2 * j + 1)

/-- DLMF 5.15.9: terms indexed from zero; the tail uses source index `j = k - 1`. -/
noncomputable def polygammaAsymptoticTerm (n k : ℕ) (x : ℝ) : ℝ :=
  if k = 0 then
    (-1 : ℝ) ^ (n - 1) * (n - 1).factorial / x ^ n
  else if k = 1 then
    (-1 : ℝ) ^ (n - 1) * n.factorial / (2 * x ^ (n + 1))
  else
    let j := k - 1
    (-1 : ℝ) ^ (n - 1) *
      ((2 * j + n - 1).factorial : ℝ) / (2 * j).factorial *
        (bernoulli (2 * j) : ℝ) / x ^ (2 * j + n)

/-- DLMF 5.15.1: trigamma is the reciprocal-square series away from the Gamma poles. -/
-- ANCHOR: dlmf_5_15_1
theorem dlmf_5_15_1 {z : ℂ} (hz : ∀ k : ℕ, z ≠ -(k : ℂ)) :
    HasSum (fun k : ℕ ↦ 1 / ((k : ℂ) + z) ^ 2) (polygamma 1 z)
-- ANCHOR_END: dlmf_5_15_1
    := by sorry

/-- DLMF 5.15.2: the polygamma value at one is a zeta value. -/
-- ANCHOR: dlmf_5_15_2
theorem dlmf_5_15_2 (n : ℕ) (hn : 1 ≤ n) :
    polygamma n 1 =
      (-1 : ℂ) ^ (n + 1) * (n.factorial : ℂ) * riemannZeta (n + 1)
-- ANCHOR_END: dlmf_5_15_2
    := by sorry

/-- DLMF 5.15.3: the polygamma value at one half is the odd-part zeta value. -/
-- ANCHOR: dlmf_5_15_3
theorem dlmf_5_15_3 (n : ℕ) (hn : 1 ≤ n) :
    polygamma n (1 / 2 : ℂ) =
      (-1 : ℂ) ^ (n + 1) * (n.factorial : ℂ) *
        ((2 : ℂ) ^ (n + 1) - 1) * riemannZeta (n + 1)
-- ANCHOR_END: dlmf_5_15_3
    := by sorry

/-- DLMF 5.15.4: trigamma at a positive half-integer is a finite odd reciprocal-square sum. -/
-- ANCHOR: dlmf_5_15_4
theorem dlmf_5_15_4 (n : ℕ) (hn : 1 ≤ n) :
    polygamma 1 ((n : ℂ) - 1 / 2) =
      (Real.pi : ℂ) ^ 2 / 2 -
        4 * ∑ k ∈ Finset.Ico 1 n, 1 / ((2 * k - 1 : ℕ) : ℂ) ^ 2
-- ANCHOR_END: dlmf_5_15_4
    := by sorry

/-- DLMF 5.15.5: the polygamma recurrence, away from the nonpositive integers. -/
-- ANCHOR: dlmf_5_15_5
theorem dlmf_5_15_5 (n : ℕ) (hn : 1 ≤ n) {z : ℂ}
    (hz : ∀ k : ℕ, z ≠ -(k : ℂ)) :
    polygamma n (z + 1) =
      polygamma n z + (-1 : ℂ) ^ n * (n.factorial : ℂ) / z ^ (n + 1)
-- ANCHOR_END: dlmf_5_15_5
    := by sorry

/-- DLMF 5.15.6: the reflection identity for the `n`-th polygamma derivative. -/
-- ANCHOR: dlmf_5_15_6
theorem dlmf_5_15_6 (n : ℕ) (hn : 1 ≤ n) {z : ℂ}
    (hz : ∀ k : ℤ, z ≠ (k : ℂ)) :
    polygamma n (1 - z) + (-1 : ℂ) ^ (n - 1) * polygamma n z =
      (-1 : ℂ) ^ n * (Real.pi : ℂ) * cotPiDerivative n z
-- ANCHOR_END: dlmf_5_15_6
    := by sorry

/-- DLMF 5.15.7: multiplication distributes a polygamma over the `m` residue classes. -/
-- ANCHOR: dlmf_5_15_7
theorem dlmf_5_15_7 (n m : ℕ) (hn : 1 ≤ n) (hm : 1 ≤ m) {z : ℂ}
    (hz : ∀ k : ℕ, (m : ℂ) * z ≠ -(k : ℂ)) :
    polygamma n ((m : ℂ) * z) =
      1 / (m : ℂ) ^ (n + 1) *
        ∑ k ∈ Finset.range m, polygamma n (z + (k : ℂ) / (m : ℂ))
-- ANCHOR_END: dlmf_5_15_7
    := by sorry

/-- DLMF 5.15.8: on the positive real axis, trigamma has the displayed Poincare expansion. -/
-- ANCHOR: dlmf_5_15_8
theorem dlmf_5_15_8 :
    (fun x : ℝ ↦ realPolygamma 1 x) ∼ₚ[atTop] trigammaAsymptoticTerm
-- ANCHOR_END: dlmf_5_15_8
    := by sorry

/-- DLMF 5.15.9: on the positive real axis, the `n`-th polygamma has the displayed expansion. -/
-- ANCHOR: dlmf_5_15_9
theorem dlmf_5_15_9 (n : ℕ) (hn : 1 ≤ n) :
    (fun x : ℝ ↦ realPolygamma n x) ∼ₚ[atTop] polygammaAsymptoticTerm n
-- ANCHOR_END: dlmf_5_15_9
    := by sorry

end LMLF.Blueprint.Gamma.Section515
