import Mathlib.Analysis.SpecialFunctions.Complex.Log
import Mathlib.Analysis.SpecialFunctions.Gamma.Digamma
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import LMLF.Blueprint.ExponentialIntegrals.Section62

open Filter
open scoped Topology BigOperators

noncomputable section
namespace LMLF.Blueprint.ExponentialIntegrals.Section610

/-! DLMF §6.10: inverse-factorial and spherical-Bessel series expansions. -/

/- DLMF §6.10.E3: one executable step of the inverse-factorial coefficient
recurrence.  The defaulted lookup is only used outside a well-formed prefix;
`inverseFactorialPrefix` supplies such prefixes. -/
def inverseFactorialNext (xs : List ℂ) : ℂ :=
  -(Finset.sum (Finset.range xs.length) fun j =>
    (xs[j]?).getD 0 / ((xs.length - j : ℕ) : ℂ))

/- DLMF §6.10.E2–E3: the finite, executable coefficient prefix. -/
-- ANCHOR: inverseFactorialPrefix
def inverseFactorialPrefix : ℕ → List ℂ
  | 0 => []
  | 1 => [1]
  | n + 2 =>
      let xs := inverseFactorialPrefix (n + 1)
      xs ++ [inverseFactorialNext xs]
-- ANCHOR_END: inverseFactorialPrefix

/- DLMF §6.10.E2–E3: the canonical inverse-factorial coefficient map. -/
-- ANCHOR: inverseFactorialCoeff
def inverseFactorialCoeff (n : ℕ) : ℂ :=
  ((inverseFactorialPrefix (n + 1))[n]?).getD 0
-- ANCHOR_END: inverseFactorialCoeff

/- DLMF §6.10.E1: the nth inverse-factorial summand. -/
def inverseFactorialTerm (z : ℂ) (n : ℕ) : ℂ :=
  (Nat.factorial n : ℂ) * inverseFactorialCoeff n /
    (Finset.prod (Finset.range (n + 1)) fun j => z + j)

/- DLMF §6.10.E4–E5 and §10.47(ii): a normalized spherical-Bessel family.
The recurrence and the two initial values identify the intended DLMF family;
the structure is used because Mathlib does not currently expose these
special functions as named canonical maps. -/
-- ANCHOR: SphericalBesselFamily
structure SphericalBesselFamily where
  value : ℕ → ℂ → ℂ
  value_zero : value 0 0 = 1
  higher_at_zero : ∀ n : ℕ, 0 < n → value n 0 = 0
  initial_zero : ∀ z : ℂ, z ≠ 0 → value 0 z = Complex.sin z / z
  initial_one : ∀ z : ℂ, z ≠ 0 →
    value 1 z = Complex.sin z / z ^ 2 - Complex.cos z / z
  recurrence : ∀ (n : ℕ) (z : ℂ), z ≠ 0 →
    value (n + 2) z = ((2 * (n + 1) + 1 : ℂ) / z) * value (n + 1) z - value n z
-- ANCHOR_END: SphericalBesselFamily

/- DLMF §6.10.E6 and §10.47(ii): a normalized modified spherical-Bessel
family of the first kind. -/
-- ANCHOR: ModifiedSphericalBesselFamily
structure ModifiedSphericalBesselFamily where
  value : ℕ → ℂ → ℂ
  value_zero : value 0 0 = 1
  higher_at_zero : ∀ n : ℕ, 0 < n → value n 0 = 0
  initial_zero : ∀ z : ℂ, z ≠ 0 → value 0 z = Complex.sinh z / z
  initial_one : ∀ z : ℂ, z ≠ 0 →
    value 1 z = Complex.cosh z / z - Complex.sinh z / z ^ 2
  recurrence : ∀ (n : ℕ) (z : ℂ), z ≠ 0 →
    value (n + 2) z = value n z -
      ((2 * (n + 1) + 1 : ℂ) / z) * value (n + 1) z
-- ANCHOR_END: ModifiedSphericalBesselFamily

/- DLMF §6.10.E5 and E7: the coefficient map, using Mathlib's canonical
complex digamma function and its real part on positive integers. -/
-- ANCHOR: modifiedSphericalCoeff
def modifiedSphericalCoeff (n : ℕ) : ℝ :=
  (2 * n + 1 : ℝ) *
    (1 - (-1 : ℝ) ^ n +
      (Complex.digamma ((n + 1 : ℕ) : ℂ)).re - (Complex.digamma (1 : ℂ)).re)
-- ANCHOR_END: modifiedSphericalCoeff

/- DLMF §6.10.E1: inverse-factorial expansion for the canonical principal E₁
value relation from §6.2. -/
-- ANCHOR: dlmf_6_10_1
theorem dlmf_6_10_1 (z : ℂ) (hz : 0 < z.re) :
    HasSum (inverseFactorialTerm z)
      (Complex.exp z *
        LMLF.Blueprint.ExponentialIntegrals.Section62.principalE1 z)
-- ANCHOR_END: dlmf_6_10_1
    := by sorry

/- DLMF §6.10.E2: initial values of the canonical coefficient map. -/
-- ANCHOR: dlmf_6_10_2
theorem dlmf_6_10_2 :
    inverseFactorialCoeff 0 = 1 ∧ inverseFactorialCoeff 1 = -1 ∧
      inverseFactorialCoeff 2 = (1 / 2 : ℂ) ∧
      inverseFactorialCoeff 3 = -(1 / 3 : ℂ) ∧ inverseFactorialCoeff 4 = 1 / 6
-- ANCHOR_END: dlmf_6_10_2
    := by sorry

/- DLMF §6.10.E3: finite triangular recurrence for the canonical coefficients. -/
-- ANCHOR: dlmf_6_10_3
theorem dlmf_6_10_3 :
    ∀ k : ℕ, 1 ≤ k → inverseFactorialCoeff k =
      -(Finset.sum (Finset.range k) fun j =>
        inverseFactorialCoeff j / ((k - j : ℕ) : ℂ))
-- ANCHOR_END: dlmf_6_10_3
    := by sorry

/- DLMF §6.10.E4: spherical-Bessel expansion of the canonical sine integral. -/
-- ANCHOR: dlmf_6_10_4
theorem dlmf_6_10_4 (J : SphericalBesselFamily) (z : ℂ) :
    ∃ s : ℂ,
      HasSum (fun n : ℕ => (J.value n (z / 2)) ^ 2) s ∧
        LMLF.Blueprint.ExponentialIntegrals.Section62.principalSi z = z * s
-- ANCHOR_END: dlmf_6_10_4
    := by sorry

/- DLMF §6.10.E5: spherical-Bessel expansion of the canonical Cin function. -/
-- ANCHOR: dlmf_6_10_5
theorem dlmf_6_10_5 (J : SphericalBesselFamily) (z : ℂ) :
    HasSum
        (fun n : ℕ => (modifiedSphericalCoeff (n + 1) : ℂ) *
          (J.value (n + 1) (z / 2)) ^ 2)
        (LMLF.Blueprint.ExponentialIntegrals.Section62.principalCin z)
-- ANCHOR_END: dlmf_6_10_5
    := by sorry

/- DLMF §6.10.E6: modified spherical-Bessel expansion of the canonical Ei
value relation on the real line away from zero. -/
-- ANCHOR: dlmf_6_10_6
theorem dlmf_6_10_6 (I : ModifiedSphericalBesselFamily) (x : ℝ) (hx : x ≠ 0) :
    HasSum
        (fun n : ℕ => (-1 : ℂ) ^ n *
          ((x : ℂ) - (modifiedSphericalCoeff n : ℂ)) *
          (I.value n ((x : ℂ) / 2)) ^ 2)
        (LMLF.Blueprint.ExponentialIntegrals.Section62.realEi x -
          (Real.eulerMascheroniConstant : ℂ) - (Real.log |x| : ℂ))
-- ANCHOR_END: dlmf_6_10_6
    := by sorry

/- DLMF §6.10.E7: explicit coefficient formula in terms of canonical digamma. -/
-- ANCHOR: dlmf_6_10_7
theorem dlmf_6_10_7 (n : ℕ) :
    modifiedSphericalCoeff n = (2 * n + 1 : ℝ) *
      (1 - (-1 : ℝ) ^ n +
        (Complex.digamma ((n + 1 : ℕ) : ℂ)).re - (Complex.digamma (1 : ℂ)).re)
-- ANCHOR_END: dlmf_6_10_7
    := by sorry

/- DLMF §6.10.E8: modified spherical-Bessel expansion of the canonical entire
complementary exponential integral. -/
-- ANCHOR: dlmf_6_10_8
theorem dlmf_6_10_8 (I : ModifiedSphericalBesselFamily) (z : ℂ) :
    ∃ s : ℂ,
      HasSum
          (fun n : ℕ => (2 * (n + 1) + 1 : ℂ) /
            ((n + 1 : ℂ) * (n + 2)) * I.value (n + 1) (z / 2)) s ∧
        LMLF.Blueprint.ExponentialIntegrals.Section62.principalEin z =
          z * Complex.exp (-z / 2) * (I.value 0 (z / 2) + s)
-- ANCHOR_END: dlmf_6_10_8
    := by sorry

end LMLF.Blueprint.ExponentialIntegrals.Section610
