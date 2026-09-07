import Mathlib.Analysis.SpecialFunctions.Gamma.Basic

/-!
# DLMF 4.9: continued fractions

The source gives continued fractions for logarithms and exponentials.  The generic
approximant below makes the nesting and the limit index explicit; each numbered result
then supplies the indexed numerators and denominators appearing in its DLMF display.
-/

namespace LMLF.Blueprint.Elementary.Section49

noncomputable section

open Filter
open scoped BigOperators

/-- DLMF 4.9.1–4.9.5: the finite tail of a continued fraction. -/
-- ANCHOR: continuedFractionTail
def continuedFractionTail (numerator denominator : ℕ → ℂ) (offset depth : ℕ) : ℂ :=
  match depth with
  | 0 => 0
  | n + 1 => numerator offset /
      (denominator offset + continuedFractionTail numerator denominator (offset + 1) n)
-- ANCHOR_END: continuedFractionTail

/-- DLMF 4.9.1–4.9.5: the depth-`depth` finite continued-fraction convergent. -/
-- ANCHOR: continuedFractionConvergent
def continuedFractionConvergent (numerator denominator : ℕ → ℂ) (depth : ℕ) : ℂ :=
  continuedFractionTail numerator denominator 0 (depth + 1)
-- ANCHOR_END: continuedFractionConvergent

/-- DLMF 4.9.1: numerators `z,z,z,4z,4z,9z,9z,…` in the logarithm fraction. -/
-- ANCHOR: logarithmFractionNumerator
def logarithmFractionNumerator (z : ℂ) : ℕ → ℂ
  | 0 => z
  | n + 1 => ((((n + 2) / 2 : ℕ) : ℂ) ^ 2) * z
-- ANCHOR_END: logarithmFractionNumerator

/-- DLMF 4.9.1: denominators `1,2,3,4,…` in the logarithm fraction. -/
-- ANCHOR: logarithmFractionDenominator
def logarithmFractionDenominator : ℕ → ℂ := fun n => (n + 1 : ℕ)
-- ANCHOR_END: logarithmFractionDenominator

/-- DLMF 4.9.2: signed square numerators in the logarithm fraction. -/
-- ANCHOR: symmetricLogFractionNumerator
def symmetricLogFractionNumerator (z : ℂ) : ℕ → ℂ
  | 0 => 2 * z
  | n + 1 => -((((n + 1 : ℕ) : ℂ) ^ 2) * z ^ 2)
-- ANCHOR_END: symmetricLogFractionNumerator

/-- DLMF 4.9.2: odd denominators `1,3,5,7,…` in the logarithm fraction. -/
-- ANCHOR: symmetricLogFractionDenominator
def symmetricLogFractionDenominator : ℕ → ℂ := fun n => (2 * n + 1 : ℕ)
-- ANCHOR_END: symmetricLogFractionDenominator

/-- DLMF 4.9.3: numerators for the first continued fraction of `exp z`. -/
-- ANCHOR: exponentialFractionNumeratorOne
def exponentialFractionNumeratorOne (z : ℂ) : ℕ → ℂ
  | 0 => 1
  | n + 1 => (-1 : ℂ) ^ (n + 1) * z
-- ANCHOR_END: exponentialFractionNumeratorOne

/-- DLMF 4.9.3: denominators `1,1,2,3,2,5,2,…` in the first `exp z` fraction. -/
-- ANCHOR: exponentialFractionDenominatorOne
def exponentialFractionDenominatorOne : ℕ → ℂ
  | 0 => 1
  | n + 1 => if (n + 1) % 2 = 0 then 2 else n + 1
-- ANCHOR_END: exponentialFractionDenominatorOne

/-- DLMF 4.9.3: numerators for the second continued fraction of `exp z`. -/
-- ANCHOR: exponentialFractionNumeratorTwo
def exponentialFractionNumeratorTwo (z : ℂ) : ℕ → ℂ := fun n => (-1 : ℂ) ^ n * z
-- ANCHOR_END: exponentialFractionNumeratorTwo

/-- DLMF 4.9.3: denominators `1,2,3,2,5,2,…` in the second `exp z` fraction. -/
-- ANCHOR: exponentialFractionDenominatorTwo
def exponentialFractionDenominatorTwo : ℕ → ℂ
  | 0 => 1
  | n + 1 => if (n + 1) % 2 = 1 then 2 else n + 2
-- ANCHOR_END: exponentialFractionDenominatorTwo

/-- DLMF 4.9.3: numerators in the third continued fraction of `exp z`. -/
-- ANCHOR: exponentialFractionNumeratorThree
def exponentialFractionNumeratorThree (z : ℂ) : ℕ → ℂ
  | 0 => z
  | n + 1 => z ^ 2 / ((4 * (4 * (n + 1) ^ 2 - 1) : ℕ) : ℂ)
-- ANCHOR_END: exponentialFractionNumeratorThree

/-- DLMF 4.9.3: denominators `1-z/2,1,1,…` in the third `exp z` fraction. -/
-- ANCHOR: exponentialFractionDenominatorThree
def exponentialFractionDenominatorThree (z : ℂ) : ℕ → ℂ
  | 0 => 1 - z / 2
  | _ + 1 => 1
-- ANCHOR_END: exponentialFractionDenominatorThree

/-- DLMF 4.9.4: the finite exponential expansion `e_n(z)`. -/
-- ANCHOR: exponentialExpansion
def exponentialExpansion (n : ℕ) (z : ℂ) : ℂ :=
  ∑ k ∈ Finset.range (n + 1), z ^ k / (k.factorial : ℂ)
-- ANCHOR_END: exponentialExpansion

/-- DLMF 4.9.4: numerators in the remainder continued fraction. -/
-- ANCHOR: exponentialRemainderNumerator
def exponentialRemainderNumerator (n : ℕ) (z : ℂ) : ℕ → ℂ
  | 0 => (n.factorial : ℂ) * z
  | k + 1 =>
      (-1 : ℂ) ^ k *
        (if k % 2 = 0 then (((k / 2 + 1 : ℕ) : ℂ))
        else (((n + (k + 1) / 2 : ℕ) : ℂ))) * z
-- ANCHOR_END: exponentialRemainderNumerator

/-- DLMF 4.9.4: denominators `n+1,n+2,n+3,…` in the remainder fraction. -/
-- ANCHOR: exponentialRemainderDenominator
def exponentialRemainderDenominator (n : ℕ) : ℕ → ℂ :=
  fun k => (n + k + 1 : ℕ)
-- ANCHOR_END: exponentialRemainderDenominator

/-- DLMF 4.9.1: logarithm continued fraction in the principal branch domain. -/
-- ANCHOR: dlmf_4_9_1
theorem dlmf_4_9_1 {z : ℂ} (hz : 1 + z ≠ 0)
    (hphase : |Complex.arg (1 + z)| < Real.pi) :
    Tendsto
        (fun depth =>
          continuedFractionConvergent (logarithmFractionNumerator z)
            logarithmFractionDenominator depth)
        atTop (nhds (Complex.log (1 + z))) := by
  sorry
-- ANCHOR_END: dlmf_4_9_1

/-- DLMF 4.9.2: symmetric logarithm continued fraction away from its cuts. -/
-- ANCHOR: dlmf_4_9_2
theorem dlmf_4_9_2 {z : ℂ}
    (hz : ¬(z.im = 0 ∧ (z.re ≤ -1 ∨ 1 ≤ z.re))) :
    Tendsto
        (fun depth =>
          continuedFractionConvergent (symmetricLogFractionNumerator z)
            symmetricLogFractionDenominator depth)
        atTop (nhds (Complex.log ((1 + z) / (1 - z)))) := by
  sorry
-- ANCHOR_END: dlmf_4_9_2

/-- DLMF 4.9.3: the three displayed continued fractions for the exponential. -/
-- ANCHOR: dlmf_4_9_3
theorem dlmf_4_9_3 (z : ℂ) :
    Tendsto
        (fun depth =>
          continuedFractionConvergent (exponentialFractionNumeratorOne z)
            exponentialFractionDenominatorOne depth)
        atTop (nhds (Complex.exp z)) ∧
      Tendsto
        (fun depth =>
          1 + continuedFractionConvergent (exponentialFractionNumeratorTwo z)
            exponentialFractionDenominatorTwo depth)
        atTop (nhds (Complex.exp z)) ∧
      Tendsto
        (fun depth =>
          1 + continuedFractionConvergent (exponentialFractionNumeratorThree z)
            (exponentialFractionDenominatorThree z) depth)
        atTop (nhds (Complex.exp z)) := by
  sorry
-- ANCHOR_END: dlmf_4_9_3

/-- DLMF 4.9.4: continued fraction for the exponential remainder after `e_(n-1)`. -/
-- ANCHOR: dlmf_4_9_4
theorem dlmf_4_9_4 {n : ℕ} (hn : 1 ≤ n) (z : ℂ) :
    Tendsto
        (fun depth =>
          z ^ n / (n.factorial : ℂ) -
            continuedFractionConvergent
              (exponentialRemainderNumerator n z)
              (exponentialRemainderDenominator n) depth)
        atTop (nhds (Complex.exp z - exponentialExpansion (n - 1) z)) := by
  sorry
-- ANCHOR_END: dlmf_4_9_4

/-- DLMF 4.9.5: the finite expansion defining `e_n(z)`. -/
-- ANCHOR: dlmf_4_9_5
theorem dlmf_4_9_5 (n : ℕ) (z : ℂ) :
    exponentialExpansion n z =
      ∑ k ∈ Finset.range (n + 1), z ^ k / (k.factorial : ℂ) := by
  sorry
-- ANCHOR_END: dlmf_4_9_5

end

end LMLF.Blueprint.Elementary.Section49
