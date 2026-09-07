import LMLF.Definitions.Gamma
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import LMLF.Integral.Domain

/-!
# DLMF §5.14: multidimensional integrals

The source formulas in §5.14 are written for complex parameters with real-part
conditions.  This module uses the positive-real specialization throughout: it keeps
the domains and measures concrete (`volume` on `Fin n → ℝ`) while retaining every
source convergence condition needed by the displayed identities.
-/

open Filter MeasureTheory Set
open scoped BigOperators

noncomputable section

namespace LMLF.Blueprint.Gamma.Section514

open LMLF.Integral

/-! ### Typed domains and recurring products -/

/-- The simplex `Vₙ = {t : ℝⁿ | 0 ≤ tᵢ and ∑ᵢ tᵢ ≤ 1}` from DLMF 5.14.1–5.14.2. -/
-- ANCHOR: simplex
def simplex (n : ℕ) : MultidimensionalDomain n where
  carrier := {t | (∀ i, 0 ≤ t i) ∧ ∑ i, t i ≤ 1}
-- ANCHOR_END: simplex

/-- The unit cube `[0,1]ⁿ` used by DLMF 5.14.4. -/
-- ANCHOR: unitCube
def unitCube (n : ℕ) : MultidimensionalDomain n where
  carrier := Set.Icc (0 : Fin n → ℝ) 1
-- ANCHOR_END: unitCube

/-- The positive orthant `[0,∞)ⁿ` used by DLMF 5.14.5. -/
-- ANCHOR: positiveOrthant
def positiveOrthant (n : ℕ) : MultidimensionalDomain n where
  carrier := Set.Ici (0 : Fin n → ℝ)
-- ANCHOR_END: positiveOrthant

/-- The cube `[-π,π]ⁿ` used by DLMF 5.14.7. -/
-- ANCHOR: dysonCube
def dysonCube (n : ℕ) : MultidimensionalDomain n where
  carrier := Set.Icc (fun _ : Fin n ↦ -Real.pi) (fun _ : Fin n ↦ Real.pi)
-- ANCHOR_END: dysonCube

/-- The whole space `(Fin n → ℝ)` used by DLMF 5.14.6. -/
-- ANCHOR: wholeSpace
def wholeSpace (n : ℕ) : MultidimensionalDomain n where
  carrier := Set.univ
-- ANCHOR_END: wholeSpace

/-- The Vandermonde product `Δ(t₁,…,tₙ)`, DLMF 5.14.3. -/
-- ANCHOR: vandermonde
def vandermonde (n : ℕ) (t : Fin n → ℝ) : ℝ :=
  ∏ j : Fin n, ∏ k : Fin n, if j < k then t j - t k else 1
-- ANCHOR_END: vandermonde

/-- DLMF 5.14.4–5.14.5.  The canonical inclusion of the first `m` coordinates
into `n` coordinates. -/
-- ANCHOR: firstCoordinateSelection
def firstCoordinateSelection {m n : ℕ} (hmn : m ≤ n) : Fin m → Fin n :=
  Fin.castLE hmn
-- ANCHOR_END: firstCoordinateSelection

/-- The first-`m` coordinate product in DLMF 5.14.4–5.14.5, with `m ≤ n`.
The source's coordinate choice is therefore canonical, not an arbitrary witness. -/
-- ANCHOR: firstCoordinatesProduct
def firstCoordinatesProduct {m n : ℕ} (hmn : m ≤ n) (t : Fin n → ℝ) : ℝ :=
  ∏ k : Fin m, t (firstCoordinateSelection hmn k)
-- ANCHOR_END: firstCoordinatesProduct

/-- The source index `n-k` in DLMF 5.14.4–5.14.5.

The `Fin n` coordinate `k` is zero-based, so its source index is `k.1 + 1`.
Writing the resulting value directly in `ℝ` avoids truncated natural subtraction. -/
-- ANCHOR: selbergIndex
def selbergIndex (n : ℕ) (k : Fin n) : ℝ := (n : ℝ) - (k.1 : ℝ) - 1
-- ANCHOR_END: selbergIndex

/-! ### Simplex beta integrals -/

/-- The integrand in DLMF 5.14.1. -/
-- ANCHOR: simplexBetaIntegrand
def simplexBetaIntegrand {n : ℕ} (z : Fin n → ℝ) (t : Fin n → ℝ) : ℝ :=
  ∏ i : Fin n, Real.rpow (t i) (z i - 1)
-- ANCHOR_END: simplexBetaIntegrand

/-- The integrand in DLMF 5.14.2, including the residual barycentric coordinate. -/
-- ANCHOR: fullSimplexBetaIntegrand
def fullSimplexBetaIntegrand {n : ℕ} (z : Fin (n + 1) → ℝ) (t : Fin n → ℝ) : ℝ :=
  Real.rpow (1 - ∑ i : Fin n, t i) (z (Fin.last n) - 1) *
    ∏ i : Fin n, Real.rpow (t i) (z (Fin.castSucc i) - 1)
-- ANCHOR_END: fullSimplexBetaIntegrand

/-- DLMF 5.14.1: the simplex beta integral without the final barycentric coordinate. -/
-- DLMF 5.14.1 https://dlmf.nist.gov/5.14.E1
-- ANCHOR: dlmf_5_14_1
theorem dlmf_5_14_1 {n : ℕ} (hn : 0 < n) (z : Fin n → ℝ)
    (hz : ∀ i, 0 < z i) :
    domainIntegral (simplex n) (simplexBetaIntegrand z) =
      (∏ i : Fin n, Real.Gamma (z i)) /
        Real.Gamma (1 + ∑ i : Fin n, z i)
-- ANCHOR_END: dlmf_5_14_1
  := by sorry

/-- DLMF 5.14.1: convergence of the simplex beta integral. -/
-- DLMF 5.14.1 https://dlmf.nist.gov/5.14.E1
-- ANCHOR: dlmf_5_14_1_integrable
theorem dlmf_5_14_1_integrable {n : ℕ} (hn : 0 < n) (z : Fin n → ℝ)
    (hz : ∀ i, 0 < z i) :
    domainIntegrable (simplex n) (simplexBetaIntegrand z)
-- ANCHOR_END: dlmf_5_14_1_integrable
  := by sorry

/-- DLMF 5.14.2: the full simplex beta integral, including the residual coordinate. -/
-- DLMF 5.14.2 https://dlmf.nist.gov/5.14.E2
-- ANCHOR: dlmf_5_14_2
theorem dlmf_5_14_2 {n : ℕ} (hn : 0 < n) (z : Fin (n + 1) → ℝ)
    (hz : ∀ i, 0 < z i) :
    domainIntegral (simplex n) (fullSimplexBetaIntegrand z) =
      (∏ i : Fin (n + 1), Real.Gamma (z i)) /
        Real.Gamma (∑ i : Fin (n + 1), z i)
-- ANCHOR_END: dlmf_5_14_2
  := by sorry

/-- DLMF 5.14.2: convergence of the full simplex beta integral. -/
-- DLMF 5.14.2 https://dlmf.nist.gov/5.14.E2
-- ANCHOR: dlmf_5_14_2_integrable
theorem dlmf_5_14_2_integrable {n : ℕ} (hn : 0 < n) (z : Fin (n + 1) → ℝ)
    (hz : ∀ i, 0 < z i) :
    domainIntegrable (simplex n) (fullSimplexBetaIntegrand z)
-- ANCHOR_END: dlmf_5_14_2_integrable
  := by sorry

/-- DLMF 5.14.3: the Vandermonde determinant product. -/
-- DLMF 5.14.3 https://dlmf.nist.gov/5.14.E3
-- ANCHOR: dlmf_5_14_3
theorem dlmf_5_14_3 (n : ℕ) (t : Fin n → ℝ) :
    vandermonde n t = ∏ j : Fin n, ∏ k : Fin n, if j < k then t j - t k else 1
-- ANCHOR_END: dlmf_5_14_3
  := by sorry

/-! ### Selberg-type integrals -/

/-- The real Selberg integrand in DLMF 5.14.4 on `[0,1]ⁿ`. -/
-- ANCHOR: selbergCubeIntegrand
def selbergCubeIntegrand {m n : ℕ} (hmn : m ≤ n) (a b c : ℝ)
    (t : Fin n → ℝ) : ℝ :=
  firstCoordinatesProduct hmn t * Real.rpow (|vandermonde n t|) (2 * c) *
    ∏ k : Fin n, Real.rpow (t k) (a - 1) * Real.rpow (1 - t k) (b - 1)
-- ANCHOR_END: selbergCubeIntegrand

/-- DLMF 5.14.4: the Selberg integral on the unit cube. -/
-- DLMF 5.14.4 https://dlmf.nist.gov/5.14.E4
-- ANCHOR: dlmf_5_14_4
theorem dlmf_5_14_4 {m n : ℕ} (hmn : m ≤ n) (hn : 2 ≤ n)
    {a b c : ℝ} (ha : 0 < a) (hb : 0 < b)
    (hc₁ : -1 / (n : ℝ) < c)
    (hc₂ : -(a / ((n : ℝ) - 1)) < c)
    (hc₃ : -(b / ((n : ℝ) - 1)) < c) :
    domainIntegral (unitCube n) (selbergCubeIntegrand hmn a b c) =
      (∏ k : Fin m,
          (a + selbergIndex n (firstCoordinateSelection hmn k) * c) /
            (a + b +
              (selbergIndex n (firstCoordinateSelection hmn k) + (n : ℝ) - 1) * c)) *
        (∏ k : Fin n,
          Real.Gamma (a + selbergIndex n k * c) *
            Real.Gamma (b + selbergIndex n k * c) *
            Real.Gamma (1 + (k.1 + 1 : ℝ) * c) /
              Real.Gamma (a + b +
                (selbergIndex n k + (n : ℝ) - 1) * c)) /
          (∏ _ : Fin n, Real.Gamma (1 + c))
-- ANCHOR_END: dlmf_5_14_4
  := by sorry

/-- DLMF 5.14.4: convergence of the Selberg integral on the typed cube. -/
-- DLMF 5.14.4 https://dlmf.nist.gov/5.14.E4
-- ANCHOR: dlmf_5_14_4_integrable
theorem dlmf_5_14_4_integrable {m n : ℕ} (hmn : m ≤ n) (hn : 2 ≤ n)
    {a b c : ℝ} (ha : 0 < a) (hb : 0 < b)
    (hc₁ : -1 / (n : ℝ) < c)
    (hc₂ : -(a / ((n : ℝ) - 1)) < c)
    (hc₃ : -(b / ((n : ℝ) - 1)) < c) :
    domainIntegrable (unitCube n) (selbergCubeIntegrand hmn a b c)
-- ANCHOR_END: dlmf_5_14_4_integrable
  := by sorry

/-- The real Laguerre/Selberg integrand in DLMF 5.14.5. -/
-- ANCHOR: laguerreIntegrand
def laguerreIntegrand {m n : ℕ} (hmn : m ≤ n) (a c : ℝ)
    (t : Fin n → ℝ) : ℝ :=
  firstCoordinatesProduct hmn t * Real.rpow (|vandermonde n t|) (2 * c) *
    ∏ k : Fin n, Real.rpow (t k) (a - 1) * Real.exp (-t k)
-- ANCHOR_END: laguerreIntegrand

/-- DLMF 5.14.5: the Laguerre/Selberg integral on `[0,∞)ⁿ`. -/
-- DLMF 5.14.5 https://dlmf.nist.gov/5.14.E5
-- ANCHOR: dlmf_5_14_5
theorem dlmf_5_14_5 {m n : ℕ} (hmn : m ≤ n) (hn : 2 ≤ n)
    {a c : ℝ} (ha : 0 < a) (hc₁ : -1 / (n : ℝ) < c)
    (hc₂ : -(a / ((n : ℝ) - 1)) < c) :
    domainIntegral (positiveOrthant n) (laguerreIntegrand hmn a c) =
      (∏ k : Fin m,
          (a + selbergIndex n (firstCoordinateSelection hmn k) * c)) *
        (∏ k : Fin n,
          Real.Gamma (a + selbergIndex n k * c) *
            Real.Gamma (1 + (k.1 + 1 : ℝ) * c)) /
          (∏ _ : Fin n, Real.Gamma (1 + c))
-- ANCHOR_END: dlmf_5_14_5
  := by sorry

/-- DLMF 5.14.5: convergence of the Laguerre/Selberg integral. -/
-- DLMF 5.14.5 https://dlmf.nist.gov/5.14.E5
-- ANCHOR: dlmf_5_14_5_integrable
theorem dlmf_5_14_5_integrable {m n : ℕ} (hmn : m ≤ n) (hn : 2 ≤ n)
    {a c : ℝ} (ha : 0 < a) (hc₁ : -1 / (n : ℝ) < c)
    (hc₂ : -(a / ((n : ℝ) - 1)) < c) :
    domainIntegrable (positiveOrthant n) (laguerreIntegrand hmn a c)
-- ANCHOR_END: dlmf_5_14_5_integrable
  := by sorry

/-! ### Gaussian and circular (Dyson) integrals -/

/-- The real Gaussian Vandermonde integrand in DLMF 5.14.6. -/
-- ANCHOR: gaussianVandermondeIntegrand
def gaussianVandermondeIntegrand (n : ℕ) (c : ℝ) (t : Fin n → ℝ) : ℝ :=
  Real.rpow (|vandermonde n t|) (2 * c) *
    ∏ k : Fin n, Real.exp (-(1 / 2) * (t k) ^ 2)
-- ANCHOR_END: gaussianVandermondeIntegrand

/-- DLMF 5.14.6: the normalized Gaussian Vandermonde integral. -/
-- DLMF 5.14.6 https://dlmf.nist.gov/5.14.E6
-- ANCHOR: dlmf_5_14_6
theorem dlmf_5_14_6 {n : ℕ} (hn : 0 < n) {c : ℝ}
    (hc : -1 / (n : ℝ) < c) :
    (1 / (2 * Real.pi) ^ ((n : ℝ) / 2)) *
        domainIntegral (wholeSpace n) (gaussianVandermondeIntegrand n c) =
      (∏ k : Fin n, Real.Gamma (1 + (k.1 + 1 : ℝ) * c)) /
        (∏ _ : Fin n, Real.Gamma (1 + c))
-- ANCHOR_END: dlmf_5_14_6
  := by sorry

/-- DLMF 5.14.6: convergence of the Gaussian Vandermonde integral. -/
-- DLMF 5.14.6 https://dlmf.nist.gov/5.14.E6
-- ANCHOR: dlmf_5_14_6_integrable
theorem dlmf_5_14_6_integrable {n : ℕ} (hn : 0 < n) {c : ℝ}
    (hc : -1 / (n : ℝ) < c) :
    domainIntegrable (wholeSpace n) (gaussianVandermondeIntegrand n c)
-- ANCHOR_END: dlmf_5_14_6_integrable
  := by sorry

/-- The real circular Vandermonde integrand in Dyson's integral. -/
-- ANCHOR: dysonIntegrand
def dysonIntegrand (n : ℕ) (b : ℝ) (θ : Fin n → ℝ) : ℝ :=
  ∏ j : Fin n, ∏ k : Fin n, if j < k then
    Real.rpow (‖Complex.exp (Complex.I * (θ j : ℂ)) -
      Complex.exp (Complex.I * (θ k : ℂ))‖) (2 * b) else 1
-- ANCHOR_END: dysonIntegrand

/-- DLMF 5.14.7: Dyson's circular integral. -/
-- DLMF 5.14.7 https://dlmf.nist.gov/5.14.E7
-- ANCHOR: dlmf_5_14_7
theorem dlmf_5_14_7 {n : ℕ} (hn : 0 < n) {b : ℝ}
    (hb : -1 / (n : ℝ) < b) :
    (1 / (2 * Real.pi) ^ (n : ℝ)) *
        domainIntegral (dysonCube n) (dysonIntegrand n b) =
      Real.Gamma (1 + b * (n : ℝ)) /
        (∏ _ : Fin n, Real.Gamma (1 + b))
-- ANCHOR_END: dlmf_5_14_7
  := by sorry

/-- DLMF 5.14.7: convergence of Dyson's circular integral. -/
-- DLMF 5.14.7 https://dlmf.nist.gov/5.14.E7
-- ANCHOR: dlmf_5_14_7_integrable
theorem dlmf_5_14_7_integrable {n : ℕ} (hn : 0 < n) {b : ℝ}
    (hb : -1 / (n : ℝ) < b) :
    domainIntegrable (dysonCube n) (dysonIntegrand n b)
-- ANCHOR_END: dlmf_5_14_7_integrable
  := by sorry

end LMLF.Blueprint.Gamma.Section514
