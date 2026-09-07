import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import LMLF.Blueprint.ExponentialIntegrals.Section62

open scoped BigOperators Topology
noncomputable section
namespace LMLF.Blueprint.ExponentialIntegrals.Section615

open LMLF.Blueprint.ExponentialIntegrals.Section62

/-- DLMF 6.15.E1 and 6.15.E3: the positive-real cosine-integral value. -/
def positiveCi (x : ℝ) : ℂ :=
  principalCiPositive x

/-- DLMF 6.15.E2 and 6.15.E4: the positive-real sine-integral tail value. -/
def positiveSi (x : ℝ) : ℂ :=
  principalSi x - Real.pi / 2

/-- DLMF 6.15.E1: the terms of the sum over Ci(π n), indexed from n = 1. -/
def ciPiTerm (n : ℕ) : ℂ :=
  positiveCi (Real.pi * (n + 1))

/-- DLMF 6.15.E2: the terms of the sum over si(π n)/n. -/
def siPiTerm (n : ℕ) : ℂ :=
  positiveSi (Real.pi * (n + 1)) / ((n + 1 : ℕ) : ℂ)

/-- DLMF 6.15.E3: the alternating terms over Ci(2π n). -/
def alternatingCiTwoPiTerm (n : ℕ) : ℂ :=
  (-1 : ℂ) ^ (n + 1) * positiveCi (2 * Real.pi * (n + 1))

/-- DLMF 6.15.E4: the alternating terms over si(2π n)/n. -/
def alternatingSiTwoPiTerm (n : ℕ) : ℂ :=
  (-1 : ℂ) ^ (n + 1) *
    positiveSi (2 * Real.pi * (n + 1)) / ((n + 1 : ℕ) : ℂ)

/-- DLMF 6.15.E1: the cosine-integral sum at the positive multiples of π. -/
-- ANCHOR: dlmf_6_15_1
theorem dlmf_6_15_1 :
    HasSum ciPiTerm
      (((Real.log 2 - Real.eulerMascheroniConstant : ℝ) : ℂ) / 2)
-- ANCHOR_END: dlmf_6_15_1
  := by sorry

/-- DLMF 6.15.E2: the sine-integral-tail sum at the positive multiples of π. -/
-- ANCHOR: dlmf_6_15_2
theorem dlmf_6_15_2 :
    HasSum siPiTerm
      ((Real.pi : ℂ) / 2 * ((Real.log Real.pi - 1 : ℝ) : ℂ))
-- ANCHOR_END: dlmf_6_15_2
  := by sorry

/-- DLMF 6.15.E3: the alternating cosine-integral sum at twice the multiples. -/
-- ANCHOR: dlmf_6_15_3
theorem dlmf_6_15_3 :
    HasSum alternatingCiTwoPiTerm
      (((1 - Real.log 2 - Real.eulerMascheroniConstant : ℝ) : ℂ))
-- ANCHOR_END: dlmf_6_15_3
  := by sorry

/-- DLMF 6.15.E4: the alternating sine-integral-tail sum at twice the multiples. -/
-- ANCHOR: dlmf_6_15_4
theorem dlmf_6_15_4 :
    HasSum alternatingSiTwoPiTerm
      ((Real.pi : ℂ) * ((3 / 2 * Real.log 2 - 1 : ℝ) : ℂ))
-- ANCHOR_END: dlmf_6_15_4
  := by sorry

end LMLF.Blueprint.ExponentialIntegrals.Section615
