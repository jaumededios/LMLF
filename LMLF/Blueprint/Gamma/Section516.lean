import LMLF.Blueprint.Gamma.Section515

/-!
# DLMF §5.16: sums

The two numbered displays in this section are sums of polygamma values at
positive integers.  The positive-index subtype in the declarations records
the source lower limit `k = 1` directly.
-/

open scoped BigOperators

noncomputable section

namespace LMLF.Blueprint.Gamma.Section516

open LMLF.Blueprint.Gamma.Section515

/-! ### Sums of polygamma values

The first display is an ordinary ordered (conditionally convergent) series;
the built-in `SummationFilter.conditional` expresses its ordered partial sums.
-/

/-- DLMF 5.16.1: the alternating sum of trigamma values at positive integers. -/
-- DLMF 5.16.1 https://dlmf.nist.gov/5.16.E1
-- ANCHOR: dlmf_5_16_1
theorem dlmf_5_16_1 :
    HasSum (L := SummationFilter.conditional {n : ℕ // 1 ≤ n})
      (fun k : {n : ℕ // 1 ≤ n} ↦
        (-1 : ℂ) ^ k.1 * polygamma 1 (k.1 : ℂ))
      (-(Real.pi : ℂ) ^ 2 / 8)
-- ANCHOR_END: dlmf_5_16_1
    := by sorry

/-- DLMF 5.16.2: a reciprocal-weighted trigamma sum and its second-polygamma value. -/
-- DLMF 5.16.2 https://dlmf.nist.gov/5.16.E2
-- ANCHOR: dlmf_5_16_2
theorem dlmf_5_16_2 :
    HasSum
        (fun k : {n : ℕ // 1 ≤ n} ↦
          (1 : ℂ) / (k.1 : ℂ) * polygamma 1 ((k.1 + 1 : ℕ) : ℂ))
        (riemannZeta (3 : ℂ)) ∧
      riemannZeta (3 : ℂ) = -(1 / 2 : ℂ) * polygamma 2 (1 : ℂ)
-- ANCHOR_END: dlmf_5_16_2
    := by sorry

end LMLF.Blueprint.Gamma.Section516
