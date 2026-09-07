import LMLF.Definitions.Gamma
import LMLF.Quantitative.Series
import Mathlib.Analysis.Asymptotics.AsymptoticEquivalent
import Mathlib.Analysis.SpecialFunctions.Gamma.Digamma
import Mathlib.NumberTheory.Bernoulli
import Mathlib.NumberTheory.LSeries.RiemannZeta

/-!
# DLMF §5.11: asymptotic expansions of the Gamma function

The declarations below follow all nineteen numbered displays in the three
subsections of DLMF §5.11.  Branch-sensitive displays are stated on the positive
real axis when that gives a faithful, readable specialization; the prose page
records those specialization choices.  The `∼ₚ` declarations use the Poincaré
expansion relation introduced in Chapter 2.
-/

open Filter Set Asymptotics
open scoped BigOperators

noncomputable section

namespace LMLF.Blueprint.Gamma.Section511

/-! ### Local vocabulary for coefficients and sectors -/

/-- DLMF 5.11.5: the finite rising factorial `(a)_n`. -/
-- ANCHOR: risingFactorial
def risingFactorial (a : ℝ) (n : ℕ) : ℝ :=
  ∏ j ∈ Finset.range n, (a + j)
-- ANCHOR_END: risingFactorial

/-- DLMF 5.11.15–5.11.16: generalized binomial coefficients. -/
-- ANCHOR: generalizedBinomial
def generalizedBinomial (a : ℝ) (n : ℕ) : ℝ :=
  (∏ j ∈ Finset.range n, (a - j)) / n.factorial
-- ANCHOR_END: generalizedBinomial

/-- DLMF 5.11.3: the scaled Gamma function on the positive real axis. -/
/- The positive-real prefactor is named separately so that E3's exact
   factorization and its asymptotic statement have distinct API entries. -/
-- ANCHOR: scaledGammaPrefactorReal
noncomputable def scaledGammaPrefactorReal (x : ℝ) : ℝ :=
  Real.exp (-x) * x ^ x * Real.sqrt (2 * Real.pi / x)
-- ANCHOR_END: scaledGammaPrefactorReal

/-- DLMF 5.11.3: the scaled Gamma function on the positive real axis. -/
-- ANCHOR: scaledGammaReal
noncomputable def scaledGammaReal (x : ℝ) : ℝ :=
  Real.Gamma x / scaledGammaPrefactorReal x
-- ANCHOR_END: scaledGammaReal

/-- DLMF 5.11.3: exact positive-real factorization defining `Γ*`. -/
-- ANCHOR: scaledGammaReal_factorization
theorem scaledGammaReal_factorization {x : ℝ} (hx : 0 < x) :
    Real.Gamma x = scaledGammaPrefactorReal x * scaledGammaReal x
-- ANCHOR_END: scaledGammaReal_factorization
:= by sorry

/-- DLMF 5.11.8: the ordinary Bernoulli polynomial. -/
-- ANCHOR: bernoulliPoly
noncomputable def bernoulliPoly (n : ℕ) (x : ℝ) : ℝ :=
  ∑ j ∈ Finset.range (n + 1),
    (n.choose j : ℝ) * (bernoulli (n - j) : ℝ) * x ^ j
-- ANCHOR_END: bernoulliPoly

/-- DLMF 5.11.3–5.11.6: the complete selected coefficient specification. -/
-- ANCHOR: StirlingCoefficientSpec
structure StirlingCoefficientSpec where
  gCoeff : ℕ → ℝ
  aCoeff : ℕ → ℝ
  g_initial :
    gCoeff 0 = 1 ∧
      gCoeff 1 = 1 / 12 ∧
      gCoeff 2 = 1 / 288 ∧
      gCoeff 3 = -(139 : ℝ) / 51840 ∧
      gCoeff 4 = -(571 : ℝ) / 2488320 ∧
      gCoeff 5 = 163879 / 209018880 ∧
      gCoeff 6 = 5246819 / 75246796800
  g_from_a : ∀ k, gCoeff k = Real.sqrt 2 * risingFactorial (1 / 2) k * aCoeff (2 * k)
  a_recurrence : ∀ {k}, 1 ≤ k →
    ∑ j ∈ Finset.range (k + 1),
      aCoeff j * aCoeff (k - j) / (j + 1) = aCoeff (k - 1) / k
  a_initial : aCoeff 0 = Real.sqrt 2 / 2
-- ANCHOR_END: StirlingCoefficientSpec

/-- The source-facing existence/specification boundary for DLMF 5.11.3–5.11.6. -/
-- ANCHOR: existsStirlingCoefficientSpec
theorem existsStirlingCoefficientSpec : Nonempty StirlingCoefficientSpec
-- ANCHOR_END: existsStirlingCoefficientSpec
  := by sorry

/-- The selected coefficient specification used by DLMF 5.11.3–5.11.6. -/
noncomputable def stirlingCoefficientSpec : StirlingCoefficientSpec :=
  Classical.choice existsStirlingCoefficientSpec

/-- DLMF 5.11.4–5.11.6: Stirling's scaled-Gamma coefficients. -/
-- ANCHOR: gCoeff
noncomputable def gCoeff : ℕ → ℝ := stirlingCoefficientSpec.gCoeff
-- ANCHOR_END: gCoeff

/-- DLMF 5.11.5–5.11.6: coefficients used to generate `gCoeff`. -/
-- ANCHOR: aCoeff
noncomputable def aCoeff : ℕ → ℝ := stirlingCoefficientSpec.aCoeff
-- ANCHOR_END: aCoeff

/-- DLMF §24.16(i), used by 5.11.17–5.11.18: the generating kernel
`(t / (exp t - 1))^α`, continuously totalized at `t = 0`. -/
-- ANCHOR: generalizedBernoulliKernel
noncomputable def generalizedBernoulliKernel (α t : ℝ) : ℝ :=
  if t = 0 then 1 else (t / (Real.exp t - 1)) ^ α
-- ANCHOR_END: generalizedBernoulliKernel

/-- DLMF §24.16(i): a transparent generating-function specification for
generalized Bernoulli polynomials. -/
-- ANCHOR: GeneralizedBernoulliSpec
structure GeneralizedBernoulliSpec where
  value : ℝ → ℝ → ℕ → ℝ
  generating_function : ∀ α x t, |t| < 2 * Real.pi →
    HasSum (fun n : ℕ ↦ value α x n * t ^ n / (n.factorial : ℝ))
      (generalizedBernoulliKernel α t * Real.exp (x * t))
-- ANCHOR_END: GeneralizedBernoulliSpec

/-- DLMF §24.16(i): the selected generating-function specification. -/
-- ANCHOR: existsGeneralizedBernoulliSpec
theorem existsGeneralizedBernoulliSpec : Nonempty GeneralizedBernoulliSpec
-- ANCHOR_END: existsGeneralizedBernoulliSpec
  := by sorry

/-- The selected generalized-Bernoulli generating-function datum. -/
-- ANCHOR: generalizedBernoulliSpec
noncomputable def generalizedBernoulliSpec : GeneralizedBernoulliSpec :=
  Classical.choice existsGeneralizedBernoulliSpec
-- ANCHOR_END: generalizedBernoulliSpec

/-- DLMF 5.11.17–5.11.18: generalized Bernoulli polynomials. -/
-- ANCHOR: generalizedBernoulli
noncomputable def generalizedBernoulli : ℝ → ℝ → ℕ → ℝ :=
  generalizedBernoulliSpec.value
-- ANCHOR_END: generalizedBernoulli

/-- DLMF 5.11.13 and 5.11.15: the ratio-expansion coefficients. -/
-- ANCHOR: ratioCoeff
noncomputable def ratioCoeff (a b : ℝ) (k : ℕ) : ℝ :=
  generalizedBinomial (a - b) k * generalizedBernoulli (a - b + 1) a k
-- ANCHOR_END: ratioCoeff

/-- DLMF 5.11.14 and 5.11.16: the centered ratio-expansion coefficients. -/
-- ANCHOR: centeredRatioCoeff
noncomputable def centeredRatioCoeff (a b : ℝ) (k : ℕ) : ℝ :=
  generalizedBinomial (a - b) (2 * k) *
    generalizedBernoulli (a - b + 1) ((a - b + 1) / 2) (2 * k)
-- ANCHOR_END: centeredRatioCoeff

/-- DLMF 5.11.1: the elementary Stirling logarithm main term. -/
-- ANCHOR: stirlingLogMain
noncomputable def stirlingLogMain (x : ℝ) : ℝ :=
  (x - 1 / 2) * Real.log x - x + Real.log (2 * Real.pi) / 2
-- ANCHOR_END: stirlingLogMain

/-- DLMF 5.11.1: the `k`th term, with index zero corresponding to DLMF `k=1`. -/
-- ANCHOR: stirlingLogTerm
noncomputable def stirlingLogTerm (k : ℕ) (x : ℝ) : ℝ :=
  (bernoulli (2 * k + 2) : ℝ) /
    ((2 * k + 2 : ℕ) * (2 * k + 1 : ℕ) * x ^ (2 * k + 1))
-- ANCHOR_END: stirlingLogTerm

/-- DLMF 5.11.1: the finite sum of the first `n` zero-based terms. -/
-- ANCHOR: stirlingLogApprox
noncomputable def stirlingLogApprox (n : ℕ) (x : ℝ) : ℝ :=
  stirlingLogMain x + QuantitativeAnalysis.seriesPartialSum stirlingLogTerm n x
-- ANCHOR_END: stirlingLogApprox

/-- DLMF 5.11.1: Stirling's series on the positive real axis. -/
-- ANCHOR: dlmf_5_11_1
theorem dlmf_5_11_1 :
    (fun x : ℝ ↦ Real.log (Real.Gamma x) - stirlingLogMain x) ∼ₚ[atTop]
      stirlingLogTerm
-- ANCHOR_END: dlmf_5_11_1
:= by sorry

/-- DLMF 5.11.1 and §5.11(ii): the first-neglected-term bound for Stirling's series. -/
-- ANCHOR: dlmf_5_11_1_remainder_bound
theorem dlmf_5_11_1_remainder_bound (n : ℕ) {x : ℝ} (hx : 0 < x) :
    0 ≤ (Real.log (Real.Gamma x) - stirlingLogApprox n x) *
      stirlingLogTerm n x ∧
      |Real.log (Real.Gamma x) - stirlingLogApprox n x| ≤
        |stirlingLogTerm n x|
-- ANCHOR_END: dlmf_5_11_1_remainder_bound
:= by sorry

/-- DLMF 5.11.2: the digamma expansion term, indexed from zero. -/
-- ANCHOR: digammaTerm
noncomputable def digammaTerm (k : ℕ) (x : ℝ) : ℝ :=
  if k = 0 then -1 / (2 * x)
  else
    (let j : ℕ := k - 1;
     -(bernoulli (2 * j + 2) : ℝ) /
       ((2 * j + 2 : ℕ) * x ^ (2 * j + 2)))
-- ANCHOR_END: digammaTerm

/-- DLMF 5.11.2: the real restriction of Mathlib's digamma function. -/
-- ANCHOR: realDigamma
noncomputable def realDigamma (x : ℝ) : ℝ :=
  (Complex.digamma (x : ℂ)).re
-- ANCHOR_END: realDigamma

/-- DLMF 5.11.2: the finite sum of the first `n` zero-based terms. -/
-- ANCHOR: digammaApprox
noncomputable def digammaApprox (n : ℕ) (x : ℝ) : ℝ :=
  Real.log x + QuantitativeAnalysis.seriesPartialSum digammaTerm n x
-- ANCHOR_END: digammaApprox

/-- DLMF 5.11.2: the Poincaré expansion of the digamma function. -/
-- ANCHOR: dlmf_5_11_2
theorem dlmf_5_11_2 :
    (fun x : ℝ ↦ realDigamma x - Real.log x) ∼ₚ[atTop] digammaTerm
-- ANCHOR_END: dlmf_5_11_2
:= by sorry

/-- DLMF 5.11.2 and §5.11(ii): the first-neglected-term digamma bound. -/
-- ANCHOR: dlmf_5_11_2_remainder_bound
theorem dlmf_5_11_2_remainder_bound (n : ℕ) {x : ℝ} (hx : 0 < x) :
    0 ≤ (realDigamma x - digammaApprox n x) * digammaTerm n x ∧
      |realDigamma x - digammaApprox n x| ≤ |digammaTerm n x|
-- ANCHOR_END: dlmf_5_11_2_remainder_bound
:= by sorry

/-- DLMF 5.11.1: the complex term with the source's one-based index. -/
-- ANCHOR: complexStirlingTerm
noncomputable def complexStirlingTerm (k : ℕ) (z : ℂ) : ℂ :=
  (bernoulli (2 * k) : ℂ) /
    ((2 * k : ℕ) * (2 * k - 1 : ℕ) * z ^ (2 * k - 1))
-- ANCHOR_END: complexStirlingTerm

/-- DLMF 5.11.2: the complex Bernoulli term with the source's one-based index. -/
-- ANCHOR: complexDigammaTerm
noncomputable def complexDigammaTerm (k : ℕ) (z : ℂ) : ℂ :=
  -(bernoulli (2 * k) : ℂ) / ((2 * k : ℕ) * z ^ (2 * k))
-- ANCHOR_END: complexDigammaTerm

/-- DLMF 5.11.1: the sector domain carrying the general-logarithm branch. -/
-- ANCHOR: gammaSectorDomain
def gammaSectorDomain (δ : ℝ) (z : ℂ) : Prop :=
  z ≠ 0 ∧ |Complex.arg z| ≤ Real.pi - δ
-- ANCHOR_END: gammaSectorDomain

/-- DLMF 5.11.1: a selected branch of `Ln Γ` on each admissible sector.

The exponential compatibility field records that this is a logarithm of the
Gamma value. Analyticity on each admissible sector, overlap consistency, and
agreement with the positive-real log-Gamma normalization make the selected
branch explicit. -/
-- ANCHOR: LnGammaDatum
structure LnGammaDatum where
  value : ℝ → ℂ → ℂ
  exp_eq_gamma : ∀ {δ : ℝ} {z : ℂ}, 0 < δ → gammaSectorDomain δ z →
    Complex.exp (value δ z) = Complex.Gamma z
  analytic_on : ∀ {δ : ℝ}, 0 < δ →
    AnalyticOnNhd ℂ (value δ) {z | gammaSectorDomain δ z}
  branch_consistent : ∀ {δ₁ δ₂ : ℝ} {z : ℂ},
    0 < δ₁ → 0 < δ₂ → gammaSectorDomain δ₁ z → gammaSectorDomain δ₂ z →
      value δ₁ z = value δ₂ z
  real_normalization : ∀ {δ : ℝ} {x : ℝ},
    0 < δ → 0 < x → gammaSectorDomain δ (x : ℂ) →
      value δ (x : ℂ) = (Real.log (Real.Gamma x) : ℂ)
-- ANCHOR_END: LnGammaDatum

/-- DLMF 5.11.1: existence/specification boundary for the selected `Ln Γ` branch. -/
-- ANCHOR: existsLnGammaDatum
theorem existsLnGammaDatum : Nonempty LnGammaDatum
-- ANCHOR_END: existsLnGammaDatum
  := by sorry

/-- The selected branch datum used by the complex E1 residual. -/
-- ANCHOR: lnGammaDatum
noncomputable def lnGammaDatum : LnGammaDatum := Classical.choice existsLnGammaDatum
-- ANCHOR_END: lnGammaDatum

/-- DLMF 5.11.1: the selected general logarithm of Gamma. -/
-- ANCHOR: lnGamma
noncomputable def lnGamma (δ : ℝ) (z : ℂ) : ℂ := lnGammaDatum.value δ z
-- ANCHOR_END: lnGamma

/-- DLMF 5.11.1: the principal-branch finite sum through source index `n-1`. -/
-- ANCHOR: complexStirlingApprox
noncomputable def complexStirlingApprox (n : ℕ) (z : ℂ) : ℂ :=
  (z - 1 / 2) * Complex.log z - z + Complex.log (2 * Real.pi) / 2 +
    ∑ k ∈ Finset.Icc 1 (n - 1), complexStirlingTerm k z
-- ANCHOR_END: complexStirlingApprox

/-- DLMF 5.11.2: the principal-branch finite digamma sum through source index `n-1`. -/
-- ANCHOR: complexDigammaApprox
noncomputable def complexDigammaApprox (n : ℕ) (z : ℂ) : ℂ :=
  Complex.log z - 1 / (2 * z) +
    ∑ k ∈ Finset.Icc 1 (n - 1), complexDigammaTerm k z
-- ANCHOR_END: complexDigammaApprox

/-- DLMF 5.11(ii): the residual after truncating E1 at source index `n-1`,
using the selected, normalized general logarithm `lnGamma`. -/
-- ANCHOR: complexStirlingRemainder
noncomputable def complexStirlingRemainder (δ : ℝ) (n : ℕ) (z : ℂ) : ℂ :=
  lnGamma δ z - complexStirlingApprox n z
-- ANCHOR_END: complexStirlingRemainder

/-- DLMF 5.11(ii): the residual after truncating E2 at source index `n-1`. -/
-- ANCHOR: complexDigammaRemainder
noncomputable def complexDigammaRemainder (n : ℕ) (z : ℂ) : ℂ :=
  Complex.digamma z - complexDigammaApprox n z
-- ANCHOR_END: complexDigammaRemainder

/-- DLMF 5.11(ii): the complex first-neglected-term bound for E1. -/
-- ANCHOR: dlmf_5_11_1_complex_remainder_bound
theorem dlmf_5_11_1_complex_remainder_bound {n : ℕ} (hn : 1 ≤ n)
    {δ : ℝ} (hδ : 0 < δ) {z : ℂ} (hz : z ≠ 0)
    (hsector : |Complex.arg z| ≤ Real.pi - δ) :
    ‖complexStirlingRemainder δ n z‖ ≤
      ‖complexStirlingTerm n z‖ *
        (1 / Real.cos (Complex.arg z / 2)) ^ (2 * n)
-- ANCHOR_END: dlmf_5_11_1_complex_remainder_bound
:= by sorry

/-- DLMF 5.11(ii): the distinct complex first-neglected-term bound for E2. -/
-- ANCHOR: dlmf_5_11_2_complex_remainder_bound
theorem dlmf_5_11_2_complex_remainder_bound {n : ℕ} (hn : 1 ≤ n)
    {δ : ℝ} (hδ : 0 < δ) {z : ℂ} (hz : z ≠ 0)
    (hsector : |Complex.arg z| ≤ Real.pi - δ) :
    ‖complexDigammaRemainder n z‖ ≤
      ‖complexDigammaTerm n z‖ *
        (1 / Real.cos (Complex.arg z / 2)) ^ (2 * n + 1)
-- ANCHOR_END: dlmf_5_11_2_complex_remainder_bound
:= by sorry

/-- DLMF 5.11.3: the scaled-Gamma asymptotic series on positive reals. -/
-- ANCHOR: scaledGammaTerm
noncomputable def scaledGammaTerm (k : ℕ) (x : ℝ) : ℝ :=
  gCoeff k / x ^ k
-- ANCHOR_END: scaledGammaTerm

/-- DLMF 5.11.3: `Gamma*` has the Poincaré expansion in the `g_k`. -/
-- ANCHOR: dlmf_5_11_3
theorem dlmf_5_11_3 :
    (fun x : ℝ ↦ scaledGammaReal x) ∼ₚ[atTop] scaledGammaTerm
-- ANCHOR_END: dlmf_5_11_3
:= by sorry

/-- DLMF 5.11.4: the seven displayed initial values of `g_k`. -/
-- ANCHOR: dlmf_5_11_4
theorem dlmf_5_11_4 :
    gCoeff 0 = 1 ∧
    gCoeff 1 = 1 / 12 ∧
    gCoeff 2 = 1 / 288 ∧
    gCoeff 3 = -(139 : ℝ) / 51840 ∧
    gCoeff 4 = -(571 : ℝ) / 2488320 ∧
    gCoeff 5 = 163879 / 209018880 ∧
    gCoeff 6 = 5246819 / 75246796800
-- ANCHOR_END: dlmf_5_11_4
:= by sorry

/-- DLMF 5.11.5: relation between `g_k` and the auxiliary `a_k`. -/
-- ANCHOR: dlmf_5_11_5
theorem dlmf_5_11_5 (k : ℕ) :
    gCoeff k = Real.sqrt 2 * risingFactorial (1 / 2) k * aCoeff (2 * k)
-- ANCHOR_END: dlmf_5_11_5
:= by sorry

/-- DLMF 5.11.6: the recurrence for the auxiliary coefficients. -/
-- ANCHOR: dlmf_5_11_6
theorem dlmf_5_11_6 {k : ℕ} (hk : 1 ≤ k) :
    ∑ j ∈ Finset.range (k + 1),
        aCoeff j * aCoeff (k - j) / (j + 1) = aCoeff (k - 1) / k
-- ANCHOR_END: dlmf_5_11_6
:= by sorry

/-- DLMF 5.11.6: the initial value for the auxiliary recurrence. -/
-- ANCHOR: dlmf_5_11_6_initial
theorem dlmf_5_11_6_initial : aCoeff 0 = Real.sqrt 2 / 2
-- ANCHOR_END: dlmf_5_11_6_initial
:= by sorry

/-- DLMF 5.11.7: the leading Gamma asymptotic for fixed real `a>0,b`. -/
-- ANCHOR: dlmf_5_11_7
theorem dlmf_5_11_7 {a b : ℝ} (ha : 0 < a) :
    (fun z : ℝ ↦ Real.Gamma (a * z + b)) ~[atTop]
      (fun z ↦ Real.sqrt (2 * Real.pi) * Real.exp (-a * z) *
        (a * z) ^ (a * z + b - 1 / 2))
-- ANCHOR_END: dlmf_5_11_7
:= by sorry

/-- DLMF 5.11.8: shifted-log-Gamma main term for fixed real `h`. -/
-- ANCHOR: shiftedLogGammaMain
noncomputable def shiftedLogGammaMain (h x : ℝ) : ℝ :=
  (x + h - 1 / 2) * Real.log x - x + Real.log (2 * Real.pi) / 2
-- ANCHOR_END: shiftedLogGammaMain

/-- DLMF 5.11.8: the shifted Bernoulli-series term, indexed from zero. -/
-- ANCHOR: shiftedLogGammaTerm
noncomputable def shiftedLogGammaTerm (h : ℝ) (k : ℕ) (x : ℝ) : ℝ :=
  (-1 : ℝ) ^ (k + 2) * bernoulliPoly (k + 2) h /
    ((k + 2 : ℕ) * (k + 1 : ℕ) * x ^ (k + 1))
-- ANCHOR_END: shiftedLogGammaTerm

/-- DLMF 5.11.8: shifted-log-Gamma Poincaré expansion. -/
-- ANCHOR: dlmf_5_11_8
theorem dlmf_5_11_8 (h : ℝ) :
    (fun x : ℝ ↦ Real.log (Real.Gamma (x + h)) - shiftedLogGammaMain h x) ∼ₚ[atTop]
      shiftedLogGammaTerm h
-- ANCHOR_END: dlmf_5_11_8
:= by sorry

/-- DLMF 5.11.9: uniform relative-error asymptotics on every bounded set of `x`. -/
-- ANCHOR: UniformAsymptoticOnBounded
def UniformAsymptoticOnBounded
    (f g : ℝ → ℝ → ℝ) (l : Filter ℝ) : Prop :=
  ∀ s : Set ℝ, Bornology.IsBounded s →
    TendstoUniformlyOn
      (fun y x ↦ ‖f x y / g x y - 1‖) (fun _ ↦ 0) l s
-- ANCHOR_END: UniformAsymptoticOnBounded

-- ANCHOR: dlmf_5_11_9
theorem dlmf_5_11_9 :
    UniformAsymptoticOnBounded
        (fun x y ↦ ‖Complex.Gamma (x + (y : ℂ) * Complex.I)‖)
        (fun x y ↦ Real.sqrt (2 * Real.pi) * |y| ^ (x - 1 / 2) *
          Real.exp (-Real.pi * |y| / 2)) atTop ∧
      UniformAsymptoticOnBounded
        (fun x y ↦ ‖Complex.Gamma (x + (y : ℂ) * Complex.I)‖)
        (fun x y ↦ Real.sqrt (2 * Real.pi) * |y| ^ (x - 1 / 2) *
          Real.exp (-Real.pi * |y| / 2)) atBot
-- ANCHOR_END: dlmf_5_11_9
:= by sorry

/-- DLMF 5.11.3 and 5.11.10: the principal-branch prefactor. -/
-- ANCHOR: gammaPrefactor
noncomputable def gammaPrefactor (z : ℂ) : ℂ :=
  Complex.exp (-z) * z ^ z * (2 * Real.pi / z) ^ (1 / 2 : ℂ)
-- ANCHOR_END: gammaPrefactor

/-- DLMF 5.11.10: the finite scaled-Gamma sum. -/
-- ANCHOR: gammaFiniteSum
noncomputable def gammaFiniteSum (K : ℕ) (z : ℂ) : ℂ :=
  ∑ k ∈ Finset.range K, (gCoeff k : ℂ) / z ^ k
-- ANCHOR_END: gammaFiniteSum

/-- DLMF 5.11.10: the remainder defined as the residual of the finite expansion.

The zero branch only totalizes the definition at a vanishing prefactor; the
source theorem below carries the nonzero, sectorial hypotheses under which the
residual is the mathematical remainder. -/
-- ANCHOR: gammaRemainder
noncomputable def gammaRemainder (K : ℕ) (z : ℂ) : ℂ :=
  if gammaPrefactor z = 0 then 0
  else Complex.Gamma z / gammaPrefactor z - gammaFiniteSum K z
-- ANCHOR_END: gammaRemainder

/-- DLMF 5.11.10: the exact finite expansion with inherited branch and sector context. -/
-- ANCHOR: dlmf_5_11_10
theorem dlmf_5_11_10 {δ : ℝ} (hδ : 0 < δ) {K : ℕ} (hK : 1 ≤ K)
    {z : ℂ} (hz : z ≠ 0) (hsector : |Complex.arg z| ≤ Real.pi - δ) :
    Complex.Gamma z = gammaPrefactor z *
      (gammaFiniteSum K z + gammaRemainder K z)
-- ANCHOR_END: dlmf_5_11_10
:= by sorry

/-- DLMF 5.11.11: the capped secant factor, including the sector endpoints. -/
-- ANCHOR: cappedSecant
noncomputable def cappedSecant (K : ℕ) (θ : ℝ) : ℝ :=
  if Real.cos θ = 0 then 2 * Real.sqrt K else min (1 / Real.cos θ) (2 * Real.sqrt K)
-- ANCHOR_END: cappedSecant

/-- DLMF 5.11.11: the explicit sectorial bound for `R_K`. -/
-- ANCHOR: dlmf_5_11_11
theorem dlmf_5_11_11 {K : ℕ} (hK : 1 ≤ K) {z : ℂ} (hz : z ≠ 0)
    (hsector : |Complex.arg z| ≤ Real.pi / 2) :
    ‖gammaRemainder K z‖ ≤
      (if K = 1 then 4 else ‖1 + riemannZeta (K : ℂ)‖) * Real.Gamma K /
        (2 * (2 * Real.pi) ^ (K + 1) * ‖z‖ ^ K) *
        (1 + cappedSecant K (Complex.arg z))
-- ANCHOR_END: dlmf_5_11_11
:= by sorry

/-- DLMF 5.11.12: Gamma-quotient leading asymptotic on positive reals. -/
-- ANCHOR: dlmf_5_11_12
theorem dlmf_5_11_12 (a b : ℝ) :
    (fun z : ℝ ↦ Real.Gamma (z + a) / Real.Gamma (z + b)) ~[atTop]
      (fun z ↦ z ^ (a - b))
-- ANCHOR_END: dlmf_5_11_12
:= by sorry

/-- DLMF 5.11.13: the full Gamma-quotient Poincaré expansion. -/
-- ANCHOR: ratioTerm
noncomputable def ratioTerm (a b : ℝ) (k : ℕ) (z : ℝ) : ℝ :=
  ratioCoeff a b k * z ^ (a - b - k)
-- ANCHOR_END: ratioTerm

/-- DLMF 5.11.13: quotient expansion in the coefficients `G_k(a,b)`. -/
-- ANCHOR: dlmf_5_11_13
theorem dlmf_5_11_13 (a b : ℝ) :
    (fun z : ℝ ↦ Real.Gamma (z + a) / Real.Gamma (z + b)) ∼ₚ[atTop]
      ratioTerm a b
-- ANCHOR_END: dlmf_5_11_13
:= by sorry

/-- DLMF 5.11.14: centered even-power quotient terms. -/
-- ANCHOR: centeredRatioTerm
noncomputable def centeredRatioTerm (a b : ℝ) (k : ℕ) (z : ℝ) : ℝ :=
  centeredRatioCoeff a b k * (z + (a + b - 1) / 2) ^ (a - b - 2 * k)
-- ANCHOR_END: centeredRatioTerm

/-- DLMF 5.11.14: centered quotient expansion in the coefficients `H_k(a,b)`. -/
-- ANCHOR: dlmf_5_11_14
theorem dlmf_5_11_14 (a b : ℝ) :
    (fun z : ℝ ↦ Real.Gamma (z + a) / Real.Gamma (z + b)) ∼ₚ[atTop]
      centeredRatioTerm a b
-- ANCHOR_END: dlmf_5_11_14
:= by sorry

/-- DLMF 5.11.15: initial explicit `G_k(a,b)` values. -/
-- ANCHOR: dlmf_5_11_15
theorem dlmf_5_11_15 (a b : ℝ) :
    ratioCoeff a b 0 = 1 ∧
    ratioCoeff a b 1 = (a - b) * (a + b - 1) / 2 ∧
    ratioCoeff a b 2 =
      generalizedBinomial (a - b) 2 *
        (3 * (a + b - 1) ^ 2 - (a - b + 1)) / 12
-- ANCHOR_END: dlmf_5_11_15
:= by sorry

/-- DLMF 5.11.16: initial explicit `H_k(a,b)` values. -/
-- ANCHOR: dlmf_5_11_16
theorem dlmf_5_11_16 (a b : ℝ) :
    centeredRatioCoeff a b 0 = 1 ∧
    centeredRatioCoeff a b 1 =
      -generalizedBinomial (a - b) 2 * (a - b + 1) / 12 ∧
    centeredRatioCoeff a b 2 =
      generalizedBinomial (a - b) 4 *
        (2 * (a - b + 1) + 5 * (a - b + 1) ^ 2) / 240
-- ANCHOR_END: dlmf_5_11_16
:= by sorry

/-- DLMF 5.11.17: generalized-Bernoulli representation of `G_k`. -/
-- ANCHOR: dlmf_5_11_17
theorem dlmf_5_11_17 (a b : ℝ) (k : ℕ) :
    ratioCoeff a b k = generalizedBinomial (a - b) k *
      generalizedBernoulli (a - b + 1) a k
-- ANCHOR_END: dlmf_5_11_17
:= by sorry

/-- DLMF 5.11.18: generalized-Bernoulli representation of `H_k`. -/
-- ANCHOR: dlmf_5_11_18
theorem dlmf_5_11_18 (a b : ℝ) (k : ℕ) :
    centeredRatioCoeff a b k = generalizedBinomial (a - b) (2 * k) *
      generalizedBernoulli (a - b + 1) ((a - b + 1) / 2) (2 * k)
-- ANCHOR_END: dlmf_5_11_18
:= by sorry

/-- DLMF 5.11.19: the Gamma-product Poincaré expansion on positive reals. -/
-- ANCHOR: gammaProductTerm
noncomputable def gammaProductTerm (a b c : ℝ) (k : ℕ) (z : ℝ) : ℝ :=
  (-1 : ℝ) ^ k * risingFactorial (c - a) k * risingFactorial (c - b) k /
    k.factorial * Real.Gamma (a + b - c + z - k)
-- ANCHOR_END: gammaProductTerm

/-- DLMF 5.11.19: Gamma products expand in shifted Gamma terms. -/
-- ANCHOR: dlmf_5_11_19
theorem dlmf_5_11_19 (a b c : ℝ) :
    (fun z : ℝ ↦ Real.Gamma (z + a) * Real.Gamma (z + b) /
      Real.Gamma (z + c)) ∼ₚ[atTop] gammaProductTerm a b c
-- ANCHOR_END: dlmf_5_11_19
:= by sorry

end LMLF.Blueprint.Gamma.Section511
