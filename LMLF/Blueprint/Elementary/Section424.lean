import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Inverse
import Mathlib.Analysis.SpecialFunctions.Complex.Arctan
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.RCLike.Sqrt

open Set
open scoped BigOperators

noncomputable section

namespace LMLF.Blueprint.Elementary.Section424

/-! Power series, derivatives, and addition formulas from DLMF §4.24.

The complex inverse functions below use the principal logarithm and square root
where a principal branch is intended.  The addition-formula declarations use
explicit value relations, since the capitalized functions in DLMF are
multivalued rather than principal branches.
-/

/-- DLMF 4.24.E7: principal complex arcsine. -/
-- ANCHOR: principalArcsin
def principalArcsin (z : ℂ) : ℂ :=
  -Complex.I * Complex.log (Complex.sqrt (1 - z ^ 2) + Complex.I * z)
-- ANCHOR_END: principalArcsin

/-- DLMF 4.24.E8: principal complex arccosine. -/
-- ANCHOR: principalArccos
def principalArccos (z : ℂ) : ℂ :=
  (Real.pi / 2 : ℂ) + Complex.I *
    Complex.log (Complex.sqrt (1 - z ^ 2) + Complex.I * z)
-- ANCHOR_END: principalArccos

/-- DLMF 4.24.E9: principal complex arctangent. -/
-- ANCHOR: principalArctan
def principalArctan (z : ℂ) : ℂ := Complex.arctan z
-- ANCHOR_END: principalArctan

/-- DLMF 4.24.E10: principal complex arccosecant. -/
-- ANCHOR: principalArccsc
def principalArccsc (z : ℂ) : ℂ := principalArcsin (1 / z)
-- ANCHOR_END: principalArccsc

/-- DLMF 4.24.E11: principal complex arcsecant. -/
-- ANCHOR: principalArcsec
def principalArcsec (z : ℂ) : ℂ := principalArccos (1 / z)
-- ANCHOR_END: principalArcsec

/-- DLMF 4.24.E12: principal complex arccotangent. -/
-- ANCHOR: principalArccot
def principalArccot (z : ℂ) : ℂ := principalArctan (1 / z)
-- ANCHOR_END: principalArccot

/-- Odd products appearing in DLMF 4.24.E2 and E5. -/
-- ANCHOR: oddProduct
def oddProduct (n : ℕ) : ℕ := Finset.prod (Finset.range n) (fun k => 2 * k + 1)
-- ANCHOR_END: oddProduct

/-- DLMF 4.24.E1: the nth term of the arcsine power series. -/
-- ANCHOR: arcsinSeriesTerm
def arcsinSeriesTerm (z : ℂ) (n : ℕ) : ℂ :=
  ((Nat.choose (2 * n) n : ℂ) /
      ((4 : ℂ) ^ n * ((2 * n + 1 : ℕ) : ℂ))) * z ^ (2 * n + 1)
-- ANCHOR_END: arcsinSeriesTerm

/-- DLMF 4.24.E1: arcsine is the sum of its terms on the closed unit disk. -/
-- ANCHOR: dlmf_4_24_1
theorem dlmf_4_24_1 {z : ℂ} (hz : ‖z‖ ≤ 1) :
    HasSum (fun n : ℕ => arcsinSeriesTerm z n) (principalArcsin z)
-- ANCHOR_END: dlmf_4_24_1
    := by sorry

/-- DLMF 4.24.E2: the nth term in the arccosine expansion about `z = 1`. -/
-- ANCHOR: arccosSeriesTerm
def arccosSeriesTerm (z : ℂ) (n : ℕ) : ℂ :=
  Complex.sqrt (2 * (1 - z)) *
    ((oddProduct n : ℂ) /
      ((2 : ℂ) ^ (2 * n) * ((2 * n + 1 : ℕ) : ℂ) * (Nat.factorial n : ℂ))) *
    (1 - z) ^ n
-- ANCHOR_END: arccosSeriesTerm

/-- DLMF 4.24.E2: arccosine expansion on the disk `|1-z| ≤ 2`. -/
-- ANCHOR: dlmf_4_24_2
theorem dlmf_4_24_2 {z : ℂ} (hz : ‖1 - z‖ ≤ 2) :
    principalArccos z = Complex.sqrt (2 * (1 - z)) *
      (1 + ∑' n : ℕ, ((oddProduct (n + 1) : ℂ) /
        ((2 : ℂ) ^ (2 * (n + 1)) * ((2 * (n + 1) + 1 : ℕ) : ℂ) *
          (Nat.factorial (n + 1) : ℂ))) * (1 - z) ^ (n + 1))
-- ANCHOR_END: dlmf_4_24_2
    := by sorry

/-- DLMF 4.24.E3: the nth term of the arctangent power series. -/
-- ANCHOR: arctanSeriesTerm
def arctanSeriesTerm (z : ℂ) (n : ℕ) : ℂ :=
  (-1 : ℂ) ^ n * z ^ (2 * n + 1) / ((2 * n + 1 : ℕ) : ℂ)
-- ANCHOR_END: arctanSeriesTerm

/-- DLMF 4.24.E3: arctangent power series on the closed unit disk. -/
-- ANCHOR: dlmf_4_24_3
theorem dlmf_4_24_3 {z : ℂ} (hz : ‖z‖ ≤ 1) (hbranch : z ≠ Complex.I) (hbranch' : z ≠ -Complex.I) :
    HasSum (fun n : ℕ => arctanSeriesTerm z n) (principalArctan z)
-- ANCHOR_END: dlmf_4_24_3
    := by sorry

/-- The sign of the exterior arctangent branch, selected by `Re z`. -/
-- ANCHOR: exteriorBranchSign
def exteriorBranchSign (z : ℂ) : ℂ := if 0 < z.re then 1 else -1
-- ANCHOR_END: exteriorBranchSign

/-- DLMF 4.24.E4: nth inverse-power term in the exterior expansion. -/
-- ANCHOR: arctanExteriorTerm
def arctanExteriorTerm (z : ℂ) (n : ℕ) : ℂ :=
  (-1 : ℂ) ^ (n + 1) / (((2 * n + 1 : ℕ) : ℂ) * z ^ (2 * n + 1))
-- ANCHOR_END: arctanExteriorTerm

/-- DLMF 4.24.E4: exterior expansion, with the sign fixed by `Re z`. -/
-- ANCHOR: dlmf_4_24_4
theorem dlmf_4_24_4 {z : ℂ} (hz : ‖z‖ ≥ 1) (hhalf : z.re ≠ 0) :
    principalArctan z = exteriorBranchSign z * (Real.pi / 2 : ℂ) +
      ∑' n : ℕ, arctanExteriorTerm z n
-- ANCHOR_END: dlmf_4_24_4
    := by sorry

/-- DLMF 4.24.E5: nth coefficient and power in the transformed arctangent series. -/
-- ANCHOR: arctanTransformedTerm
def arctanTransformedTerm (z : ℂ) (n : ℕ) : ℂ :=
  ((2 : ℂ) ^ n * (Nat.factorial n : ℂ) /
      (oddProduct (n + 1) : ℂ)) * (z ^ 2 / (1 + z ^ 2)) ^ n
-- ANCHOR_END: arctanTransformedTerm

/-- DLMF 4.24.E5: transformed arctangent series in `Re(z²) > -1/2`. -/
-- ANCHOR: dlmf_4_24_5
theorem dlmf_4_24_5 {z : ℂ} (hz : -(1 / 2 : ℝ) < (z ^ 2).re) :
    principalArctan z = z / (z ^ 2 + 1) *
      ∑' n : ℕ, arctanTransformedTerm z n
-- ANCHOR_END: dlmf_4_24_5
    := by sorry

/-- DLMF 4.24.E6: `x²-y²=-1/2` is the boundary hyperbola for E5. -/
-- ANCHOR: dlmf_4_24_6
def dlmf_4_24_6 (x y : ℝ) : Prop := x ^ 2 - y ^ 2 = -(1 / 2 : ℝ)
-- ANCHOR_END: dlmf_4_24_6

/- The principal arcsine and arccosine use the standard slit plane with cuts
`(-∞,-1]` and `[1,∞)`. -/
-- ANCHOR: principalInverseTrigDomain
/-- DLMF 4.24.E7 and E8: principal inverse-trigonometric slit-plane domain. -/
def principalInverseTrigDomain (z : ℂ) : Prop :=
  ¬ (z.im = 0 ∧ (1 ≤ z.re ∨ z.re ≤ -1))
-- ANCHOR_END: principalInverseTrigDomain

/-- DLMF 4.24.E7: derivative of the principal arcsine on its slit plane. -/
-- ANCHOR: dlmf_4_24_7
theorem dlmf_4_24_7 {z : ℂ} (hcut : principalInverseTrigDomain z) :
    deriv principalArcsin z = (Complex.sqrt (1 - z ^ 2))⁻¹
-- ANCHOR_END: dlmf_4_24_7
    := by sorry

/-- DLMF 4.24.E8: derivative of the principal arccosine on its slit plane. -/
-- ANCHOR: dlmf_4_24_8
theorem dlmf_4_24_8 {z : ℂ} (hcut : principalInverseTrigDomain z) :
    deriv principalArccos z = -(Complex.sqrt (1 - z ^ 2))⁻¹
-- ANCHOR_END: dlmf_4_24_8
    := by sorry

/- The principal arctangent has cuts on the imaginary rays `i[1,∞)` and
`i(-∞,-1]`. -/
-- ANCHOR: principalArctanDomain
/-- DLMF 4.24.E9: principal arctangent cut-complement domain. -/
def principalArctanDomain (z : ℂ) : Prop :=
  ¬ (z.re = 0 ∧ (1 ≤ z.im ∨ z.im ≤ -1))
-- ANCHOR_END: principalArctanDomain

/-- DLMF 4.24.E9: derivative of the principal arctangent off its cuts. -/
-- ANCHOR: dlmf_4_24_9
theorem dlmf_4_24_9 {z : ℂ} (hcut : principalArctanDomain z) :
    deriv principalArctan z = (1 + z ^ 2)⁻¹
-- ANCHOR_END: dlmf_4_24_9
    := by sorry

/- DLMF 4.24.E10: derivative branch sign for the principal arccosecant. -/
/- The square-root factor has the imaginary-axis cut and the real segment
`[-1,1]` in the `z`-plane. -/
-- ANCHOR: principalArcCscSecDomain
/-- DLMF 4.24.E10 and E11: real-segment complement for `sqrt (z²-1)`. -/
def principalArcCscSecDomain (z : ℂ) : Prop :=
  ¬ (z.im = 0 ∧ -1 ≤ z.re ∧ z.re ≤ 1)
-- ANCHOR_END: principalArcCscSecDomain

/- DLMF E10 and E11 retain the open-half-plane sign selection in addition to
the cut-complement condition. -/
/-- DLMF 4.24.E10: derivative branch sign for the principal arccosecant. -/
-- ANCHOR: dlmf_4_24_10
theorem dlmf_4_24_10 {z : ℂ} (hz : z ≠ 0) (hz₁ : z ≠ 1) (hz₂ : z ≠ -1)
    (hhalf : z.re ≠ 0) (hcut : principalArcCscSecDomain z) :
    deriv principalArccsc z = -(exteriorBranchSign z) /
      (z * Complex.sqrt (z ^ 2 - 1))
-- ANCHOR_END: dlmf_4_24_10
    := by sorry

/-- DLMF 4.24.E11: derivative branch sign for the principal arcsecant. -/
-- ANCHOR: dlmf_4_24_11
theorem dlmf_4_24_11 {z : ℂ} (hz : z ≠ 0) (hz₁ : z ≠ 1) (hz₂ : z ≠ -1)
    (hhalf : z.re ≠ 0) (hcut : principalArcCscSecDomain z) :
    deriv principalArcsec z = exteriorBranchSign z /
      (z * Complex.sqrt (z ^ 2 - 1))
-- ANCHOR_END: dlmf_4_24_11
    := by sorry

/- DLMF 4.24.E12: derivative of the principal arccotangent. -/
/- The reciprocal definition pulls the arctangent cuts back to the imaginary
segment `[-i,i]`. -/
-- ANCHOR: principalArccotDomain
/-- DLMF 4.24.E12: principal arccotangent cut-complement domain. -/
def principalArccotDomain (z : ℂ) : Prop :=
  ¬ (z.re = 0 ∧ -1 ≤ z.im ∧ z.im ≤ 1)
-- ANCHOR_END: principalArccotDomain

/-- DLMF 4.24.E12: derivative of the principal arccotangent. -/
-- ANCHOR: dlmf_4_24_12
theorem dlmf_4_24_12 {z : ℂ} (hz : z ≠ 0) (hz₁ : z ≠ Complex.I)
    (hz₂ : z ≠ -Complex.I) (hcut : principalArccotDomain z) :
    deriv principalArccot z = -(1 + z ^ 2)⁻¹
-- ANCHOR_END: dlmf_4_24_12
    := by sorry

/-- The full multivalued inverse-sine value relation used by DLMF E13 and E16. -/
-- ANCHOR: arcsinValues
def arcsinValues (z : ℂ) : Set ℂ := {w | Complex.sin w = z}
-- ANCHOR_END: arcsinValues

/-- The full multivalued inverse-cosine value relation used by DLMF E14 and E16. -/
-- ANCHOR: arccosValues
def arccosValues (z : ℂ) : Set ℂ := {w | Complex.cos w = z}
-- ANCHOR_END: arccosValues

/-- The full multivalued inverse-tangent value relation used by DLMF E15 and E17. -/
-- ANCHOR: arctanValues
def arctanValues (z : ℂ) : Set ℂ :=
  {w | Complex.cos w ≠ 0 ∧ Complex.tan w = z}
-- ANCHOR_END: arctanValues

/-- The full multivalued inverse-cotangent value relation used by DLMF E17. -/
-- ANCHOR: arccotValues
def arccotValues (z : ℂ) : Set ℂ :=
  {w | Complex.sin w ≠ 0 ∧ Complex.cot w = z}
-- ANCHOR_END: arccotValues

/-! A signed sum of two value sets, and the right-hand value sets occurring in
the five multivalued addition formulas. -/
-- ANCHOR: signedValueSum
/-- DLMF 4.24.E13--E17: signed sum of two multivalued value sets. -/
def signedValueSum (A B : Set ℂ) (σ : ℂ) : Set ℂ :=
  {w | ∃ a ∈ A, ∃ b ∈ B, w = a + σ * b}
-- ANCHOR_END: signedValueSum

-- ANCHOR: arcsinAdditionValues
/-- DLMF 4.24.E13: all right-hand inverse-sine addition values. -/
def arcsinAdditionValues (u v σ : ℂ) : Set ℂ :=
  {w | ∃ ru rv : ℂ, ru ^ 2 = 1 - u ^ 2 ∧ rv ^ 2 = 1 - v ^ 2 ∧
    w ∈ arcsinValues (u * rv + σ * v * ru)}
-- ANCHOR_END: arcsinAdditionValues

-- ANCHOR: arccosAdditionValues
/-- DLMF 4.24.E14: all right-hand inverse-cosine addition values. -/
def arccosAdditionValues (u v σ : ℂ) : Set ℂ :=
  {w | ∃ ru rv : ℂ, ru ^ 2 = 1 - u ^ 2 ∧ rv ^ 2 = 1 - v ^ 2 ∧
    w ∈ arccosValues (u * v - σ * ru * rv)}
-- ANCHOR_END: arccosAdditionValues

-- ANCHOR: arctanAdditionValues
/-- DLMF 4.24.E15: all right-hand inverse-tangent addition values. -/
def arctanAdditionValues (u v σ : ℂ) : Set ℂ :=
  {w | 1 - σ * u * v ≠ 0 ∧
    w ∈ arctanValues ((u + σ * v) / (1 - σ * u * v))}
-- ANCHOR_END: arctanAdditionValues

-- ANCHOR: mixedArcsinArccosAdditionValues
/-- DLMF 4.24.E16: both mixed inverse-sine/cosine right-hand value sets. -/
def mixedArcsinArccosAdditionValues (u v σ : ℂ) : Set ℂ :=
  {w | ∃ ru rv : ℂ, ru ^ 2 = 1 - u ^ 2 ∧ rv ^ 2 = 1 - v ^ 2 ∧
    (w ∈ arcsinValues (u * v + σ * ru * rv) ∨
      w ∈ arccosValues (v * ru - σ * u * rv))}
-- ANCHOR_END: mixedArcsinArccosAdditionValues

-- ANCHOR: mixedArctanArccotAdditionValues
/-- DLMF 4.24.E17: both mixed inverse-tangent/cotangent value sets. -/
def mixedArctanArccotAdditionValues (u v σ : ℂ) : Set ℂ :=
  {w | v - σ * u ≠ 0 ∧ u * v + σ ≠ 0 ∧
    (w ∈ arctanValues ((u * v + σ) / (v - σ * u)) ∨
      w ∈ arccotValues ((v - σ * u) / (u * v + σ)))}
-- ANCHOR_END: mixedArctanArccotAdditionValues

/-- DLMF 4.24.E13: inverse-sine addition values, with both square-root choices. -/
-- ANCHOR: dlmf_4_24_13
theorem dlmf_4_24_13 (u v σ w : ℂ) (hσ : σ = 1 ∨ σ = -1) :
    w ∈ signedValueSum (arcsinValues u) (arcsinValues v) σ ↔
      w ∈ arcsinAdditionValues u v σ
-- ANCHOR_END: dlmf_4_24_13
    := by sorry

/-- DLMF 4.24.E14: inverse-cosine addition values, with both square-root choices. -/
-- ANCHOR: dlmf_4_24_14
theorem dlmf_4_24_14 (u v σ w : ℂ) (hσ : σ = 1 ∨ σ = -1) :
    w ∈ signedValueSum (arccosValues u) (arccosValues v) σ ↔
      w ∈ arccosAdditionValues u v σ
-- ANCHOR_END: dlmf_4_24_14
    := by sorry

/-- DLMF 4.24.E15: inverse-tangent addition values, with denominator exclusion. -/
-- ANCHOR: dlmf_4_24_15
theorem dlmf_4_24_15 (u v σ w : ℂ) (hσ : σ = 1 ∨ σ = -1)
    (hden : 1 - σ * u * v ≠ 0) :
    w ∈ signedValueSum (arctanValues u) (arctanValues v) σ ↔
      w ∈ arctanAdditionValues u v σ
-- ANCHOR_END: dlmf_4_24_15
    := by sorry

/-- DLMF 4.24.E16: mixed inverse-sine/cosine addition values. -/
-- ANCHOR: dlmf_4_24_16
theorem dlmf_4_24_16 (u v σ w : ℂ) (hσ : σ = 1 ∨ σ = -1) :
    w ∈ signedValueSum (arcsinValues u) (arccosValues v) σ ↔
      w ∈ mixedArcsinArccosAdditionValues u v σ
-- ANCHOR_END: dlmf_4_24_16
    := by sorry

/-- DLMF 4.24.E17: mixed inverse-tangent/cotangent addition values. -/
-- ANCHOR: dlmf_4_24_17
theorem dlmf_4_24_17 (u v σ w : ℂ) (hσ : σ = 1 ∨ σ = -1)
    (hden₁ : v - σ * u ≠ 0) (hden₂ : u * v + σ ≠ 0) :
    w ∈ signedValueSum (arctanValues u) (arccotValues v) σ ↔
      w ∈ mixedArctanArccotAdditionValues u v σ
-- ANCHOR_END: dlmf_4_24_17
    := by sorry

end LMLF.Blueprint.Elementary.Section424
