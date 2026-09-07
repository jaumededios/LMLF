import LMLF.Definitions.Gamma
import LMLF.Quantitative.Series
import Mathlib.Analysis.Asymptotics.AsymptoticEquivalent
import Mathlib.NumberTheory.Bernoulli
import Mathlib.NumberTheory.Harmonic.EulerMascheroni
import Mathlib.NumberTheory.LSeries.RiemannZeta

/-!
# DLMF §5.17: Barnes' G-function

The source-facing vocabulary below is deliberately small: it names Barnes' `G`,
the factors in its Weierstrass product, the positive-integer product, and the
terms in the asymptotic expansion.  The branch-sensitive integral and
asymptotic displays are recorded on the positive real axis, an honest
specialization of the complex formulas in the source.
-/

open Filter Set Asymptotics MeasureTheory
open scoped BigOperators

noncomputable section

namespace LMLF.Blueprint.Gamma.Section517

/-! ### Barnes-G vocabulary -/

/-- DLMF 5.17.3: the `k`th factor in Barnes' canonical product, for `k ≥ 1`. -/
-- ANCHOR: barnesGProductTerm
noncomputable def barnesGProductTerm (z : ℂ) (k : {n : ℕ // 1 ≤ n}) : ℂ :=
  (1 + z / (k.1 : ℂ)) ^ k.1 *
    Complex.exp (-z + z ^ 2 / (2 * (k.1 : ℂ)))
-- ANCHOR_END: barnesGProductTerm

/-- DLMF 5.17.3: the non-product exponential factor in the Barnes product. -/
-- ANCHOR: barnesGProductPrefactor
noncomputable def barnesGProductPrefactor (z : ℂ) : ℂ :=
  Complex.exp ((z / 2) * Complex.log (2 * Real.pi) -
    (1 / 2) * z * (z + 1) -
      (1 / 2) * (Real.eulerMascheroniConstant : ℂ) * z ^ 2)
-- ANCHOR_END: barnesGProductPrefactor

/-- DLMF 5.17.3: Barnes' `G`-function (double gamma function), via the canonical product. -/
-- ANCHOR: barnesG
noncomputable def barnesG (z : ℂ) : ℂ :=
  barnesGProductPrefactor (z - 1) *
    ∏' k : {n : ℕ // 1 ≤ n}, barnesGProductTerm (z - 1) k
-- ANCHOR_END: barnesG

/-- DLMF 5.17.2: the finite product of factorials at a positive integer. -/
-- ANCHOR: barnesIntegerProduct
noncomputable def barnesIntegerProduct (n : ℕ) : ℂ :=
  ∏ k ∈ Finset.Icc 1 (n - 2), (k.factorial : ℂ)
-- ANCHOR_END: barnesIntegerProduct

/-- DLMF 5.17.7: the renormalized finite expression converging to `C`. -/
-- ANCHOR: glaisherPartialExpression
noncomputable def glaisherPartialExpression (n : ℕ) : ℝ :=
  (∑ k ∈ Finset.Icc 1 n, (k : ℝ) * Real.log (k : ℝ)) -
    ((1 / 2 : ℝ) * (n : ℝ) ^ 2 + (1 / 2 : ℝ) * (n : ℝ) + 1 / 12) *
      Real.log (n : ℝ) +
    (1 / 4 : ℝ) * (n : ℝ) ^ 2
-- ANCHOR_END: glaisherPartialExpression

/-- DLMF 5.17.6–5.17.7: Glaisher's constant and its logarithm. -/
-- ANCHOR: glaisherLogConstant
noncomputable def glaisherLogConstant : ℝ :=
  limUnder atTop glaisherPartialExpression
-- ANCHOR_END: glaisherLogConstant

/-- DLMF 5.17.6: the exponential definition of Glaisher's constant. -/
-- ANCHOR: glaisherConstant
noncomputable def glaisherConstant : ℝ := Real.exp glaisherLogConstant
-- ANCHOR_END: glaisherConstant

/-- DLMF 5.17.5: the principal-branch main term on the positive real axis. -/
-- ANCHOR: barnesGAsymptoticMain
noncomputable def barnesGAsymptoticMain (x : ℝ) : ℂ :=
  (1 / 4 : ℂ) * (x : ℂ) ^ 2 +
    (x : ℂ) * Complex.log (Complex.Gamma ((x + 1 : ℝ) : ℂ)) -
    ((1 / 2 : ℂ) * (x : ℂ) * ((x : ℂ) + 1) + 1 / 12) *
      Complex.log (x : ℂ) -
    Complex.log (glaisherConstant : ℂ)
-- ANCHOR_END: barnesGAsymptoticMain

/-- DLMF 5.17.5: the term with source index `k = n + 1`. -/
-- ANCHOR: barnesGAsymptoticTerm
noncomputable def barnesGAsymptoticTerm (n : ℕ) (x : ℝ) : ℂ :=
  (bernoulli (2 * n + 4) : ℂ) /
    (((2 * n + 2 : ℕ) : ℂ) * ((2 * n + 3 : ℕ) : ℂ) *
      ((2 * n + 4 : ℕ) : ℂ) * (x : ℂ) ^ (2 * n + 2))
-- ANCHOR_END: barnesGAsymptoticTerm

/-! ### Functional equations, products, and special values -/

/-- DLMF 5.17.1: Barnes' functional equation on the ordinary pole-free domain. -/
-- DLMF 5.17.1 https://dlmf.nist.gov/5.17.E1
-- ANCHOR: dlmf_5_17_1
theorem dlmf_5_17_1 (z : ℂ) (hz : ∀ m : ℕ, z ≠ -(m : ℂ)) :
    barnesG (z + 1) = Complex.Gamma z * barnesG z
-- ANCHOR_END: dlmf_5_17_1
    := by sorry

/-- DLMF 5.17.1: Barnes' normalization at one. -/
-- DLMF 5.17.1 https://dlmf.nist.gov/5.17.E1
-- ANCHOR: barnesG_one
theorem barnesG_one : barnesG 1 = 1
-- ANCHOR_END: barnesG_one
    := by sorry

/-- DLMF 5.17.2: Barnes' `G` at each integer `n ≥ 2`. -/
-- DLMF 5.17.2 https://dlmf.nist.gov/5.17.E2
-- ANCHOR: dlmf_5_17_2
theorem dlmf_5_17_2 {n : ℕ} (hn : 2 ≤ n) :
    barnesG (n : ℂ) = barnesIntegerProduct n
-- ANCHOR_END: dlmf_5_17_2
    := by sorry

/-- DLMF 5.17.3: Barnes' canonical infinite product, indexed from `k = 1`. -/
-- DLMF 5.17.3 https://dlmf.nist.gov/5.17.E3
-- ANCHOR: dlmf_5_17_3
theorem dlmf_5_17_3 (z : ℂ) :
    barnesG (z + 1) =
      barnesGProductPrefactor z *
        ∏' k : {n : ℕ // 1 ≤ n}, barnesGProductTerm z k
-- ANCHOR_END: dlmf_5_17_3
    := by sorry

/-! ### Integral representation and asymptotics -/

/-- DLMF 5.17.4: the positive-real specialization of the Barnes log integral. -/
-- DLMF 5.17.4 https://dlmf.nist.gov/5.17.E4
-- ANCHOR: dlmf_5_17_4
theorem dlmf_5_17_4 {x : ℝ} (hx : 0 < x) :
    Complex.log (barnesG ((x + 1 : ℝ) : ℂ)) =
      (x : ℂ) / 2 * Complex.log (2 * Real.pi) -
        (1 / 2 : ℂ) * (x : ℂ) * ((x : ℂ) + 1) +
        (x : ℂ) * Complex.log (Complex.Gamma ((x + 1 : ℝ) : ℂ)) -
        ∫ t in (0 : ℝ)..x, Complex.log (Complex.Gamma ((t + 1 : ℝ) : ℂ))
-- ANCHOR_END: dlmf_5_17_4
    := by sorry

/-- DLMF 5.17.5: the positive-real Poincare expansion of `Ln G(x+1)`. -/
-- DLMF 5.17.5 https://dlmf.nist.gov/5.17.E5
-- ANCHOR: dlmf_5_17_5
theorem dlmf_5_17_5 :
    (fun x : ℝ ↦
      Complex.log (barnesG ((x + 1 : ℝ) : ℂ)) - barnesGAsymptoticMain x) ∼ₚ[atTop]
        barnesGAsymptoticTerm
-- ANCHOR_END: dlmf_5_17_5
    := by sorry

/-- DLMF 5.17.6: Glaisher's constant is the exponential of `C`. -/
-- DLMF 5.17.6 https://dlmf.nist.gov/5.17.E6
-- ANCHOR: dlmf_5_17_6
theorem dlmf_5_17_6 :
    glaisherConstant = Real.exp glaisherLogConstant
-- ANCHOR_END: dlmf_5_17_6
    := by sorry

/-- DLMF 5.17.7: the defining limit and zeta-derivative formulas for `C`. -/
-- DLMF 5.17.7 https://dlmf.nist.gov/5.17.E7
-- ANCHOR: dlmf_5_17_7
theorem dlmf_5_17_7 :
    Tendsto glaisherPartialExpression atTop (nhds glaisherLogConstant) ∧
      (glaisherLogConstant : ℂ) =
        ((Real.eulerMascheroniConstant : ℂ) + Complex.log (2 * Real.pi)) / 12 -
          deriv riemannZeta (2 : ℂ) / (2 * (Real.pi : ℂ) ^ 2) ∧
      (glaisherLogConstant : ℂ) =
        (1 / 12 : ℂ) - deriv riemannZeta (-1 : ℂ)
-- ANCHOR_END: dlmf_5_17_7
    := by sorry

end LMLF.Blueprint.Gamma.Section517
