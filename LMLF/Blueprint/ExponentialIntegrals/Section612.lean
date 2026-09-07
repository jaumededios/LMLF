import Mathlib.Analysis.Asymptotics.AsymptoticEquivalent
import Mathlib.Analysis.SpecialFunctions.Gamma.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import LMLF.Quantitative.Series
import LMLF.Blueprint.ExponentialIntegrals.Section62

open Filter Set Asymptotics
open scoped BigOperators Topology Interval

noncomputable section
namespace LMLF.Blueprint.ExponentialIntegrals.Section612
open LMLF.Blueprint.ExponentialIntegrals.Section62

/-- DLMF 6.12(i,ii): a nonempty sector margin, with `0 < δ < angle`. -/
structure SectorMargin (angle : ℝ) where
  value : ℝ
  positive : 0 < value
  lt_angle : value < angle

/-! The filters below make the sector and the meaning of `z → ∞` explicit. -/

/-- DLMF 6.12.1, 6.12.3, 6.12.4: escape to infinity in a phase sector. -/
def sectorAtInfinity (angle : ℝ) (δ : SectorMargin angle) : Filter ℂ :=
  cocompact ℂ ⊓ 𝓟 {z : ℂ |
    principalCutDomain z ∧ ‖Complex.arg z‖ ≤ angle - δ.value}

/-- DLMF 6.12.1: the kth E₁ asymptotic term. -/
def e1Term (k : ℕ) (z : ℂ) : ℂ :=
  Complex.exp (-z) * (-1 : ℂ) ^ k * (k.factorial : ℂ) / z ^ (k + 1)

/-- DLMF 6.12.2: the kth positive-real Ei asymptotic term. -/
def eiTerm (k : ℕ) (x : ℝ) : ℝ :=
  Real.exp x * (k.factorial : ℝ) / x ^ (k + 1)

/-- DLMF 6.12.3 and 6.12.5: the kth auxiliary-f asymptotic term. -/
def fTerm (k : ℕ) (z : ℂ) : ℂ :=
  (-1 : ℂ) ^ k * ((2 * k).factorial : ℂ) / z ^ (2 * k + 1)

/-- DLMF 6.12.4 and 6.12.6: the kth auxiliary-g asymptotic term. -/
def gTerm (k : ℕ) (z : ℂ) : ℂ :=
  (-1 : ℂ) ^ k * ((2 * k + 1).factorial : ℂ) / z ^ (2 * k + 2)

/-- The source domain of the finite f and g expansions in DLMF 6.12.5–6.12.6.

The surrounding definitions are totalized by Lean's field division, but the
source formulas are read only on this nonzero-argument domain. -/
-- ANCHOR: dlmf_6_12_finite_domain
def finiteExpansionDomain : Set ℂ := {z : ℂ | z ≠ 0}
-- ANCHOR_END: dlmf_6_12_finite_domain

/-- DLMF 6.12.3 and 6.12.5: the first `n` terms of the f expansion, and
the DLMF 6.12.5 and 6.12.7 canonical f remainder of order `n`.

The remainder is source data for the finite expansion, not a theorem asserting
an identity obtained by subtracting the same definition from both sides. -/
-- ANCHOR: dlmf_6_12_5
def fPartial (n : ℕ) (z : ℂ) : ℂ := ∑ k ∈ Finset.range n, fTerm k z
def fRemainder (n : ℕ) (z : ℂ) : ℂ := principalAuxiliaryF z - fPartial n z
-- ANCHOR_END: dlmf_6_12_5

/-- DLMF 6.12.4 and 6.12.6: the first `n` terms of the g expansion, and
the DLMF 6.12.6 and 6.12.8 canonical g remainder of order `n`.

As for `fRemainder`, this definition names the residual used by the source
finite expansion and its integral representation. -/
-- ANCHOR: dlmf_6_12_6
def gPartial (n : ℕ) (z : ℂ) : ℂ := ∑ k ∈ Finset.range n, gTerm k z
def gRemainder (n : ℕ) (z : ℂ) : ℂ := principalAuxiliaryG z - gPartial n z
-- ANCHOR_END: dlmf_6_12_6

/-- DLMF 6.12.2: the canonical Ei remainder after `n` terms. -/
def eiRemainder (n : ℕ) (x : ℝ) : ℝ :=
  (realEi x).re - ∑ k ∈ Finset.range n, eiTerm k x

/-- DLMF 6.12.1: the canonical E₁ remainder after `n` terms. -/
def e1Remainder (n : ℕ) (z : ℂ) : ℂ :=
  principalE1 z - ∑ k ∈ Finset.range n, e1Term k z

/-- Two complex quantities have non-opposite real-axis signs.

The imaginary parts are required to vanish, and the product of the real parts
is nonnegative, so a zero value is included. This is the reader-facing
encoding of DLMF's same-sign clauses on the positive real ray. -/
def SameRealSign (a b : ℂ) : Prop :=
  a.im = 0 ∧ b.im = 0 ∧ 0 ≤ a.re * b.re

/-- DLMF 6.12.1: the real cosecant factor in the outer phase range. -/
def realCsc (θ : ℝ) : ℝ := 1 / Real.sin θ

/-- DLMF 9.7.3, used by the 6.12.2 next-term bound. -/
def chi (x : ℝ) : ℝ :=
  Real.sqrt Real.pi * Real.Gamma (x / 2 + 1) /
    Real.Gamma (x / 2 + 1 / 2)

-- ANCHOR: dlmf_6_12_1
theorem dlmf_6_12_1 (δ : SectorMargin (3 * Real.pi / 2)) :
    principalE1 ∼ₚ[sectorAtInfinity (3 * Real.pi / 2) δ] e1Term
-- ANCHOR_END: dlmf_6_12_1
    := by sorry

-- ANCHOR: dlmf_6_12_1_bounds
theorem dlmf_6_12_1_bounds (n : ℕ) :
    (∀ z : ℂ, z ≠ 0 → ‖Complex.arg z‖ ≤ Real.pi / 2 →
      ‖e1Remainder n z‖ ≤ ‖e1Term n z‖) ∧
    (∀ z : ℂ, z ≠ 0 → Real.pi / 2 ≤ ‖Complex.arg z‖ →
      ‖Complex.arg z‖ < Real.pi →
      ‖e1Remainder n z‖ ≤
        realCsc (‖Complex.arg z‖) * ‖e1Term n z‖)
-- ANCHOR_END: dlmf_6_12_1_bounds
    := by sorry

-- ANCHOR: dlmf_6_12_1_same_sign
theorem dlmf_6_12_1_same_sign (n : ℕ) :
    ∀ x : ℝ, 0 < x →
      SameRealSign (e1Remainder n (x : ℂ)) (e1Term n (x : ℂ))
-- ANCHOR_END: dlmf_6_12_1_same_sign
    := by sorry

-- ANCHOR: dlmf_6_12_2
theorem dlmf_6_12_2 :
    ∀ n : ℕ, (fun x : ℝ => eiRemainder n x) =O[atTop]
      (eiTerm n)
-- ANCHOR_END: dlmf_6_12_2
    := by sorry

-- ANCHOR: dlmf_6_12_2_bound
theorem dlmf_6_12_2_bound (n : ℕ) :
    ∀ x : ℝ, 0 < x →
      |eiRemainder (n + 1) x| ≤ (1 + chi (n + 1)) * eiTerm (n + 1) x
-- ANCHOR_END: dlmf_6_12_2_bound
    := by sorry

-- ANCHOR: dlmf_6_12_3
theorem dlmf_6_12_3 (δ : SectorMargin Real.pi) :
    principalAuxiliaryF ∼ₚ[sectorAtInfinity Real.pi δ] fTerm
-- ANCHOR_END: dlmf_6_12_3
    := by sorry

-- ANCHOR: dlmf_6_12_4
theorem dlmf_6_12_4 (δ : SectorMargin Real.pi) :
    principalAuxiliaryG ∼ₚ[sectorAtInfinity Real.pi δ] gTerm
-- ANCHOR_END: dlmf_6_12_4
    := by sorry

-- ANCHOR: dlmf_6_12_7
theorem dlmf_6_12_7 (n : ℕ) (z : ℂ) (hz : 0 < z.re) :
    Section62.HasImproperIntegral
        (fun t : ℝ => Complex.exp (-(z * t)) * (t : ℂ) ^ (2 * n) /
          ((t : ℂ) ^ 2 + 1)) 0 ((-1 : ℂ) ^ n * fRemainder n z)
-- ANCHOR_END: dlmf_6_12_7
    := by sorry

-- ANCHOR: dlmf_6_12_7_bounds
theorem dlmf_6_12_7_bounds (n : ℕ) :
    (∀ z : ℂ, 0 < z.re → z ≠ 0 → ‖Complex.arg z‖ ≤ Real.pi / 4 →
      ‖fRemainder n z‖ ≤ ‖fTerm n z‖) ∧
    (∀ z : ℂ, 0 < z.re → z ≠ 0 → Real.pi / 4 ≤ ‖Complex.arg z‖ →
      ‖Complex.arg z‖ < Real.pi / 2 →
      ‖fRemainder n z‖ ≤
        realCsc (2 * ‖Complex.arg z‖) * ‖fTerm n z‖)
-- ANCHOR_END: dlmf_6_12_7_bounds
    := by sorry

-- ANCHOR: dlmf_6_12_7_same_sign
theorem dlmf_6_12_7_same_sign (n : ℕ) :
    ∀ x : ℝ, 0 < x →
      SameRealSign (fRemainder n (x : ℂ)) (fTerm n (x : ℂ))
-- ANCHOR_END: dlmf_6_12_7_same_sign
    := by sorry

-- ANCHOR: dlmf_6_12_8
theorem dlmf_6_12_8 (n : ℕ) (z : ℂ) (hz : 0 < z.re) :
    Section62.HasImproperIntegral
        (fun t : ℝ => Complex.exp (-(z * t)) * (t : ℂ) ^ (2 * n + 1) /
          ((t : ℂ) ^ 2 + 1)) 0 ((-1 : ℂ) ^ n * gRemainder n z)
-- ANCHOR_END: dlmf_6_12_8
    := by sorry

-- ANCHOR: dlmf_6_12_8_bounds
theorem dlmf_6_12_8_bounds (n : ℕ) :
    (∀ z : ℂ, 0 < z.re → z ≠ 0 → ‖Complex.arg z‖ ≤ Real.pi / 4 →
      ‖gRemainder n z‖ ≤ ‖gTerm n z‖) ∧
    (∀ z : ℂ, 0 < z.re → z ≠ 0 → Real.pi / 4 ≤ ‖Complex.arg z‖ →
      ‖Complex.arg z‖ < Real.pi / 2 →
      ‖gRemainder n z‖ ≤
        realCsc (2 * ‖Complex.arg z‖) * ‖gTerm n z‖)
-- ANCHOR_END: dlmf_6_12_8_bounds
    := by sorry

-- ANCHOR: dlmf_6_12_8_same_sign
theorem dlmf_6_12_8_same_sign (n : ℕ) :
    ∀ x : ℝ, 0 < x →
      SameRealSign (gRemainder n (x : ℂ)) (gTerm n (x : ℂ))
-- ANCHOR_END: dlmf_6_12_8_same_sign
    := by sorry

end LMLF.Blueprint.ExponentialIntegrals.Section612
