import LMLF.Definitions.Gamma

/-!
# DLMF §5.18: q-Gamma and q-Beta functions

The source's finite products are defined for complex `q`.  The infinite
products and the q-Gamma/q-Beta values use `0 < q < 1` (or `‖q‖ < 1` for the
complex-base q-Pochhammer product).  Totalized `tprod`, `tsum`, and field
quotients are kept as implementation representatives, while the public
q-Gamma and q-Beta value layers carry the source's convergence and pole-free
conditions explicitly.
-/

open Filter Set
open scoped BigOperators Topology

noncomputable section

namespace LMLF.Blueprint.Gamma.Section518

/-! ### q-calculus vocabulary -/

/-- DLMF 5.18.1: the finite q-Pochhammer (q-shifted factorial) symbol. -/
-- ANCHOR: dlmf_5_18_1
def qPochhammer (a q : ℂ) (n : ℕ) : ℂ :=
  ∏ k ∈ Finset.range n, (1 - a * q ^ k)
-- ANCHOR_END: dlmf_5_18_1

/-- DLMF 5.18.3: one factor of the infinite q-Pochhammer product. -/
-- ANCHOR: qPochhammerTerm
def qPochhammerTerm (a q : ℂ) (k : ℕ) : ℂ := 1 - a * q ^ k
-- ANCHOR_END: qPochhammerTerm

/-- DLMF 5.18.3: the infinite q-Pochhammer product, totalized as `tprod`.

The semantic convergence interface is `dlmf_5_18_3`; this definition is the
canonical product value used by later q-Gamma and q-Beta objects. -/
-- ANCHOR: qPochhammerInf
noncomputable def qPochhammerInf (a q : ℂ) : ℂ :=
  ∏' k : ℕ, qPochhammerTerm a q k
-- ANCHOR_END: qPochhammerInf

/-- DLMF 5.18.2: the q-factorial, as the product of q-integers. -/
-- ANCHOR: qFactorial
def qFactorial (q : ℂ) (n : ℕ) : ℂ :=
  ∏ k ∈ Finset.range n, ∑ j ∈ Finset.range (k + 1), q ^ j
-- ANCHOR_END: qFactorial

/-- DLMF 5.18.4 and 5.18.7: the q-Pochhammer denominator of q-Gamma. -/
-- ANCHOR: qGammaDenom
noncomputable def qGammaDenom (q : ℝ) (z : ℂ) : ℂ :=
  qPochhammerInf (Complex.cpow (q : ℂ) z) (q : ℂ)
-- ANCHOR_END: qGammaDenom

/-- DLMF 5.18.4 and 5.18.7: the denominator-only pole guard for q-Gamma.

This predicate intentionally says only that the q-Pochhammer denominator is
nonzero.  The complete source domain, including `0 < q < 1`, is
`QGammaPoint`. -/
-- ANCHOR: qGammaDenomNeZero
def qGammaDenomNeZero (q : ℝ) (z : ℂ) : Prop :=
  qGammaDenom q z ≠ 0
-- ANCHOR_END: qGammaDenomNeZero

/-- DLMF 5.18.4: q-Gamma for a real base `q`.

This is the source product formula.  At a zero denominator it is Lean's
totalized field quotient; `QGammaPoint` and `qGammaValue` below are the
pole-free interface for ordinary meromorphic values. -/
-- ANCHOR: dlmf_5_18_4
noncomputable def qGamma (q : ℝ) (z : ℂ) : ℂ :=
  qPochhammerInf (q : ℂ) (q : ℂ) *
      Complex.cpow (1 - (q : ℂ)) (1 - z) /
    qGammaDenom q z
-- ANCHOR_END: dlmf_5_18_4

/- DLMF 5.18.4 and 5.18.7: a q-Gamma point in the source base range. -/
-- ANCHOR: QGammaPoint
structure QGammaPoint (q : ℝ) (z : ℂ) : Prop where
  base_pos : 0 < q
  base_lt_one : q < 1
  denominator_ne_zero : qGammaDenomNeZero q z
-- ANCHOR_END: QGammaPoint

/-- DLMF 5.18.4: q-Gamma evaluated at a pole-free point. -/
-- ANCHOR: qGammaValue
noncomputable def qGammaValue {q : ℝ} {z : ℂ} (p : QGammaPoint q z) : ℂ :=
  qGamma q z
-- ANCHOR_END: qGammaValue

/-- DLMF 5.18.4: the numerator product used by q-Gamma. -/
-- ANCHOR: qGammaNumerator
noncomputable def qGammaNumerator (q : ℝ) : ℂ :=
  qPochhammerInf (q : ℂ) (q : ℂ)
-- ANCHOR_END: qGammaNumerator

/-- DLMF 5.18.4: a numerator product term used by q-Gamma. -/
-- ANCHOR: qGammaNumeratorTerm
def qGammaNumeratorTerm (q : ℝ) (k : ℕ) : ℂ :=
  qPochhammerTerm (q : ℂ) (q : ℂ) k
-- ANCHOR_END: qGammaNumeratorTerm

/-- DLMF 5.18.4: a denominator product term used by q-Gamma. -/
-- ANCHOR: qGammaDenominatorTerm
def qGammaDenominatorTerm (q : ℝ) (z : ℂ) (k : ℕ) : ℂ :=
  qPochhammerTerm (Complex.cpow (q : ℂ) z) (q : ℂ) k
-- ANCHOR_END: qGammaDenominatorTerm

/-- DLMF 5.18.8–5.18.9: the totalized real-axis q-Gamma proxy. -/
-- ANCHOR: qGammaReal
noncomputable def qGammaReal (q x : ℝ) : ℝ :=
  (qGamma q (x : ℂ)).re
-- ANCHOR_END: qGammaReal

/-- DLMF 5.18.11: the q-Beta function for a real base `q`. -/
-- ANCHOR: dlmf_5_18_11
noncomputable def qBeta (q : ℝ) (a b : ℂ) : ℂ :=
  qGamma q a * qGamma q b / qGamma q (a + b)
-- ANCHOR_END: dlmf_5_18_11

/-- DLMF 5.18.11: q-Beta's three pole-free q-Gamma arguments. -/
-- ANCHOR: QBetaPoint
structure QBetaPoint (q : ℝ) where
  a : ℂ
  b : ℂ
  gamma_a : QGammaPoint q a
  gamma_b : QGammaPoint q b
  gamma_sum : QGammaPoint q (a + b)
-- ANCHOR_END: QBetaPoint

/-- DLMF 5.18.11: q-Beta evaluated on its ordinary finite-value domain. -/
-- ANCHOR: qBetaValue
noncomputable def qBetaValue (p : QBetaPoint q) : ℂ :=
  qBeta q p.a p.b
-- ANCHOR_END: qBetaValue

/-- DLMF 5.18.12: Jackson's q-integral on `[0,1]` for a real base. -/
-- ANCHOR: qJacksonIntegral
noncomputable def qJacksonIntegral (q : ℝ) (f : ℝ → ℂ) : ℂ :=
  (1 - (q : ℂ)) * ∑' k : ℕ, (q : ℂ) ^ k * f (q ^ k)
-- ANCHOR_END: qJacksonIntegral

/-- DLMF 5.18.12: the q-Beta Jackson integrand. -/
-- ANCHOR: qBetaJacksonIntegrand
def qBetaJacksonIntegrand (q : ℝ) (a b : ℂ) (t : ℝ) : ℂ :=
  Complex.cpow (t : ℂ) (a - 1) *
    qPochhammerInf ((t : ℂ) * (q : ℂ)) (q : ℂ) /
      qPochhammerInf ((t : ℂ) * Complex.cpow (q : ℂ) b) (q : ℂ)
-- ANCHOR_END: qBetaJacksonIntegrand

/-- DLMF 5.18.12: the sampled summand behind the Jackson integral. -/
-- ANCHOR: qBetaJacksonTerm
def qBetaJacksonTerm (q : ℝ) (a b : ℂ) (k : ℕ) : ℂ :=
  (1 - (q : ℂ)) * (q : ℂ) ^ k * qBetaJacksonIntegrand q a b (q ^ k)
-- ANCHOR_END: qBetaJacksonTerm

/-! ### q-factorials and semantic convergence -/

/-- DLMF 5.18.2: q-factorial in terms of the q-Pochhammer symbol. -/
-- DLMF 5.18.2 https://dlmf.nist.gov/5.18.E2
-- ANCHOR: dlmf_5_18_2
theorem dlmf_5_18_2 (q : ℂ) (n : ℕ) (hq : q ≠ 1) :
    qFactorial q n = qPochhammer q q n * (1 - q)⁻¹ ^ n
-- ANCHOR_END: dlmf_5_18_2
    := by sorry

/-- DLMF 5.18.3: the infinite q-Pochhammer product converges for `‖q‖ < 1`. -/
-- DLMF 5.18.3 https://dlmf.nist.gov/5.18.E3
-- ANCHOR: dlmf_5_18_3
theorem dlmf_5_18_3 {a q : ℂ} (hq : ‖q‖ < 1) :
    HasProd (qPochhammerTerm a q) (qPochhammerInf a q)
-- ANCHOR_END: dlmf_5_18_3
    := by sorry

/-- DLMF 5.18.4: both q-Gamma products have semantic convergence before a
value identity is used. -/
-- ANCHOR: qGamma_products_hasProd
theorem qGamma_products_hasProd {q : ℝ} (hq₀ : 0 < q) (hq₁ : q < 1) (z : ℂ) :
    HasProd (qGammaNumeratorTerm q) (qGammaNumerator q) ∧
      HasProd (qGammaDenominatorTerm q z) (qGammaDenom q z)
-- ANCHOR_END: qGamma_products_hasProd
    := by sorry

/-! ### q-Gamma function -/

/-- DLMF 5.18.5: the first two q-Gamma values. -/
-- DLMF 5.18.5 https://dlmf.nist.gov/5.18.E5
-- ANCHOR: dlmf_5_18_5
theorem dlmf_5_18_5 {q : ℝ} (p₁ : QGammaPoint q 1) (p₂ : QGammaPoint q 2) :
    qGammaValue p₁ = 1 ∧ qGammaValue p₂ = 1
-- ANCHOR_END: dlmf_5_18_5
    := by sorry

/-- DLMF 5.18.6: q-factorials are q-Gamma values at positive integers. -/
-- DLMF 5.18.6 https://dlmf.nist.gov/5.18.E6
-- ANCHOR: dlmf_5_18_6
theorem dlmf_5_18_6 {q : ℝ} (n : ℕ) (p : QGammaPoint q (n + 1 : ℕ)) :
    qFactorial (q : ℂ) n = qGammaValue p
-- ANCHOR_END: dlmf_5_18_6
    := by sorry

/-- DLMF 5.18.7: the q-Gamma recurrence on two pole-free points. -/
-- DLMF 5.18.7 https://dlmf.nist.gov/5.18.E7
-- ANCHOR: dlmf_5_18_7
theorem dlmf_5_18_7 {q : ℝ} {z : ℂ} (p : QGammaPoint q z)
    (p₁ : QGammaPoint q (z + 1)) :
    qGammaValue p₁ =
      ((1 - Complex.cpow (q : ℂ) z) / (1 - (q : ℂ))) * qGammaValue p
-- ANCHOR_END: dlmf_5_18_7
    := by sorry

/-! ### Convexity and the q-Bohr--Mollerup characterization -/

/-- DLMF 5.18(ii): the pole-free real-axis bridge for q-Gamma. -/
-- DLMF 5.18 https://dlmf.nist.gov/5.18#ii.p2
-- ANCHOR: qGammaReal_coe
theorem qGammaReal_coe {q x : ℝ} (p : QGammaPoint q (x : ℂ)) :
    qGammaValue p = (qGammaReal q x : ℂ)
-- ANCHOR_END: qGammaReal_coe
    := by sorry

/-- DLMF 5.18(ii): `ln Γ_q(x)` is convex for positive real `x`. -/
-- DLMF 5.18 https://dlmf.nist.gov/5.18#ii.p2
-- ANCHOR: dlmf_5_18_convexity
theorem dlmf_5_18_convexity {q : ℝ} (hq₀ : 0 < q) (hq₁ : q < 1) :
    ConvexOn ℝ (Set.Ioi (0 : ℝ)) (fun x : ℝ ↦ Real.log (qGammaReal q x))
-- ANCHOR_END: dlmf_5_18_convexity
    := by sorry

/-- DLMF 5.18(ii): q-Gamma's q-Bohr--Mollerup characterization. -/
-- DLMF 5.18 https://dlmf.nist.gov/5.18#ii.p2
-- ANCHOR: dlmf_5_18_bohr_mollerup
theorem dlmf_5_18_bohr_mollerup {q : ℝ} (hq₀ : 0 < q) (hq₁ : q < 1) {f : ℝ → ℝ}
    (hf_pos : ∀ {x : ℝ}, 0 < x → 0 < f x)
    (hf_recurrence : ∀ {x : ℝ}, 0 < x →
      f (x + 1) = ((1 - Real.rpow q x) / (1 - q)) * f x)
    (hf_one : f 1 = 1)
    (hf_logConvex : ConvexOn ℝ (Set.Ioi (0 : ℝ)) (Real.log ∘ f)) :
    Set.EqOn f (qGammaReal q) (Set.Ioi 0)
-- ANCHOR_END: dlmf_5_18_bohr_mollerup
    := by sorry

/-- DLMF 5.18.8: q-Gamma increases with the base on `0 < x < 1` or `x > 2`. -/
-- DLMF 5.18.8 https://dlmf.nist.gov/5.18.E8
-- ANCHOR: dlmf_5_18_8
theorem dlmf_5_18_8 {q r x : ℝ} (hq : 0 < q) (hqr : q < r) (hr : r < 1)
    (hx : (0 < x ∧ x < 1) ∨ 2 < x) :
    qGammaReal q x < qGammaReal r x
-- ANCHOR_END: dlmf_5_18_8
    := by sorry

/-- DLMF 5.18.9: q-Gamma decreases with the base on `1 < x < 2`. -/
-- DLMF 5.18.9 https://dlmf.nist.gov/5.18.E9
-- ANCHOR: dlmf_5_18_9
theorem dlmf_5_18_9 {q r x : ℝ} (hq : 0 < q) (hqr : q < r) (hr : r < 1)
    (hx₀ : 1 < x) (hx₁ : x < 2) :
    qGammaReal q x > qGammaReal r x
-- ANCHOR_END: dlmf_5_18_9
    := by sorry

/-- DLMF 5.18.10: q-Gamma tends to ordinary Gamma as `q → 1⁻`. -/
-- DLMF 5.18.10 https://dlmf.nist.gov/5.18.E10
-- ANCHOR: dlmf_5_18_10
theorem dlmf_5_18_10 (z : ℂ) :
    Tendsto (fun q : ℝ ↦ qGamma q z)
      (nhdsWithin 1 (Iio 1)) (𝓝 (Complex.Gamma z))
-- ANCHOR_END: dlmf_5_18_10
    := by sorry

/-! ### q-Beta function -/

/-- DLMF 5.18.12: semantic convergence of the Jackson sum before the value
identity. -/
-- ANCHOR: qBeta_jackson_hasSum
theorem qBeta_jackson_hasSum {q : ℝ} {a b : ℂ}
    (hq₀ : 0 < q) (hq₁ : q < 1) (ha : 0 < a.re) (hb : 0 < b.re) :
    HasSum (qBetaJacksonTerm q a b)
      (qJacksonIntegral q (qBetaJacksonIntegrand q a b))
-- ANCHOR_END: qBeta_jackson_hasSum
    := by sorry

/-- DLMF 5.18.12: q-Beta's Jackson integral representation. -/
-- DLMF 5.18.12 https://dlmf.nist.gov/5.18.E12
-- ANCHOR: dlmf_5_18_12
theorem dlmf_5_18_12 {q : ℝ} (p : QBetaPoint q)
    (ha : 0 < p.a.re) (hb : 0 < p.b.re) :
    qBetaValue p = qJacksonIntegral q (qBetaJacksonIntegrand q p.a p.b)
-- ANCHOR_END: dlmf_5_18_12
    := by sorry

end LMLF.Blueprint.Gamma.Section518
