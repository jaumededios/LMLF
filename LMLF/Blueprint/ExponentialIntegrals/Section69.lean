import Mathlib.Analysis.Asymptotics.AsymptoticEquivalent
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import LMLF.Definitions.ContinuedFraction
import LMLF.Blueprint.ExponentialIntegrals.Section62

open Filter
open scoped Topology

noncomputable section
namespace LMLF.Blueprint.ExponentialIntegrals.Section69

/-! DLMF §6.9 continued fraction for the principal exponential integral. -/

/-- DLMF 6.9.E1: the successive numerators of the continued fraction. -/
def e1PartialNumerator (n : ℕ) : ℂ :=
  ((n + 2) / 2 : ℕ)

/-- DLMF 6.9.E1: alternating z,1,z,1,... partial denominators. -/
def e1PartialDenominator (z : ℂ) (n : ℕ) : ℂ :=
  if Even n then z else 1

/-- DLMF 6.9.E1: the n-th finite convergent, including the leading exp(-z). -/
def e1Convergent (z : ℂ) (n : ℕ) (offset : ℕ := 0) : ℂ :=
  Complex.exp (-z) *
    LMLF.continuedFractionConvergent
      (e1PartialDenominator z) e1PartialNumerator n (offset := offset)

/-- DLMF 6.9.E1: the convergents recover the canonical principal E₁ value in the
open principal cut plane. -/
-- ANCHOR: dlmf_6_9_1
theorem dlmf_6_9_1 (z : ℂ) (hz0 : z ≠ 0) (hz : ‖Complex.arg z‖ < Real.pi) :
    Tendsto (e1Convergent z) atTop
      (𝓝 (LMLF.Blueprint.ExponentialIntegrals.Section62.principalE1 z))
-- ANCHOR_END: dlmf_6_9_1
:= by sorry

end LMLF.Blueprint.ExponentialIntegrals.Section69
