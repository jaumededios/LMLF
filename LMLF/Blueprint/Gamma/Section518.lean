import LMLF.Definitions.Gamma

/-!
# DLMF §5.18: q-Gamma and q-Beta functions

The finite q-Pochhammer and q-factorial products are defined for complex `q`.
The infinite q-Pochhammer product is used under the source condition `‖q‖ < 1`;
the q-Gamma and q-Beta formulas in this section use the source's real range
`0 < q < 1`.  In particular, no convergence claim for an infinite product is
made here for `q > 1`.  The quotient definitions below are Lean's totalized
field-valued proxies: at a zero denominator they return `0`, whereas the source
functions are meromorphic and have poles.  Pointwise recurrence statements
therefore carry an explicit pole-free hypothesis.
-/

open Filter Set
open scoped BigOperators Topology

noncomputable section

namespace LMLF.Blueprint.Gamma.Section518

/-! ### Minimal q-calculus vocabulary -/

/-- DLMF 5.18.1: the finite q-Pochhammer (q-shifted factorial) symbol. -/
def qPochhammer (a q : ℂ) (n : ℕ) : ℂ :=
  ∏ k ∈ Finset.range n, (1 - a * q ^ k)

/-- DLMF 5.18.3: the infinite q-Pochhammer product, totalized as `tprod`. -/
noncomputable def qPochhammerInf (a q : ℂ) : ℂ :=
  ∏' k : ℕ, (1 - a * q ^ k)

/-- DLMF 5.18.2: the q-factorial, as the product of q-integers. -/
def qFactorial (q : ℂ) (n : ℕ) : ℂ :=
  ∏ k ∈ Finset.range n, ∑ j ∈ Finset.range (k + 1), q ^ j

/-- DLMF 5.18.4: the q-Gamma function for a real base `q`. -/
noncomputable def qGamma (q : ℝ) (z : ℂ) : ℂ :=
  qPochhammerInf (q : ℂ) (q : ℂ) *
      Complex.cpow (1 - (q : ℂ)) (1 - z) /
    qPochhammerInf (Complex.cpow (q : ℂ) z) (q : ℂ)

/-- DLMF 5.18.4 and 5.18.7: the q-Pochhammer denominator of q-Gamma. -/
-- ANCHOR: qGammaDenom
noncomputable def qGammaDenom (q : ℝ) (z : ℂ) : ℂ :=
  qPochhammerInf (Complex.cpow (q : ℂ) z) (q : ℂ)
-- ANCHOR_END: qGammaDenom

/-- DLMF 5.18.4 and 5.18.7: the ordinary finite-value domain of q-Gamma.

This excludes the zero set of the denominator product.  It is needed when a
meromorphic source identity is represented by Lean's totalized field quotient. -/
-- ANCHOR: qGammaPoleFree
def qGammaPoleFree (q : ℝ) (z : ℂ) : Prop :=
  qGammaDenom q z ≠ 0
-- ANCHOR_END: qGammaPoleFree

/-- DLMF 5.18.8–5.18.9: the real-axis q-Gamma value used by the inequalities. -/
noncomputable def qGammaReal (q x : ℝ) : ℝ :=
  (qGamma q (x : ℂ)).re

/-- DLMF 5.18.11: the q-Beta function for a real base `q`. -/
noncomputable def qBeta (q : ℝ) (a b : ℂ) : ℂ :=
  qGamma q a * qGamma q b / qGamma q (a + b)

/-- DLMF 5.18.12: Jackson's q-integral on `[0,1]` for a real base. -/
noncomputable def qJacksonIntegral (q : ℝ) (f : ℝ → ℂ) : ℂ :=
  (1 - (q : ℂ)) * ∑' k : ℕ, (q : ℂ) ^ k * f (q ^ k)

/-! ### q-factorials -/

/-- DLMF 5.18.1: finite q-Pochhammer products. -/
-- DLMF 5.18.1 https://dlmf.nist.gov/5.18.E1
-- ANCHOR: dlmf_5_18_1
theorem dlmf_5_18_1 (a q : ℂ) (n : ℕ) :
    qPochhammer a q n = ∏ k ∈ Finset.range n, (1 - a * q ^ k)
-- ANCHOR_END: dlmf_5_18_1
    := by sorry

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
    HasProd (fun k : ℕ ↦ 1 - a * q ^ k) (qPochhammerInf a q)
-- ANCHOR_END: dlmf_5_18_3
    := by sorry

/-! ### q-Gamma function -/

/-- DLMF 5.18.4: product representation of q-Gamma for `0 < q < 1`. -/
-- DLMF 5.18.4 https://dlmf.nist.gov/5.18.E4
-- ANCHOR: dlmf_5_18_4
theorem dlmf_5_18_4 {q : ℝ} (hq₀ : 0 < q) (hq₁ : q < 1) (z : ℂ) :
    qGamma q z =
      qPochhammerInf (q : ℂ) (q : ℂ) *
          Complex.cpow (1 - (q : ℂ)) (1 - z) /
        qPochhammerInf (Complex.cpow (q : ℂ) z) (q : ℂ)
-- ANCHOR_END: dlmf_5_18_4
    := by sorry

/-- DLMF 5.18.5: the first two q-Gamma values. -/
-- DLMF 5.18.5 https://dlmf.nist.gov/5.18.E5
-- ANCHOR: dlmf_5_18_5
theorem dlmf_5_18_5 {q : ℝ} (hq₀ : 0 < q) (hq₁ : q < 1) :
    qGamma q 1 = 1 ∧ qGamma q 2 = 1
-- ANCHOR_END: dlmf_5_18_5
    := by sorry

/-- DLMF 5.18.6: q-factorials are q-Gamma values at positive integers. -/
-- DLMF 5.18.6 https://dlmf.nist.gov/5.18.E6
-- ANCHOR: dlmf_5_18_6
theorem dlmf_5_18_6 {q : ℝ} (hq₀ : 0 < q) (hq₁ : q < 1) (n : ℕ) :
    qFactorial (q : ℂ) n = qGamma q (n + 1 : ℕ)
-- ANCHOR_END: dlmf_5_18_6
    := by sorry

/-- DLMF 5.18.7: the q-Gamma recurrence. -/
-- DLMF 5.18.7 https://dlmf.nist.gov/5.18.E7
-- ANCHOR: dlmf_5_18_7
theorem dlmf_5_18_7 {q : ℝ} (hq₀ : 0 < q) (hq₁ : q < 1) (z : ℂ)
    (hz : qGammaPoleFree q z) (hz1 : qGammaPoleFree q (z + 1)) :
    qGamma q (z + 1) =
      ((1 - Complex.cpow (q : ℂ) z) / (1 - (q : ℂ))) * qGamma q z
-- ANCHOR_END: dlmf_5_18_7
    := by sorry

/-! ### Convexity and the q-Bohr--Mollerup characterization -/

/-- DLMF 5.18(ii): on the positive real axis, q-Gamma is real-valued away from
its q-Pochhammer poles; `qGammaReal` is the real-axis specialization used below. -/
-- DLMF 5.18 https://dlmf.nist.gov/5.18#ii.p2
-- ANCHOR: qGammaReal_coe
theorem qGammaReal_coe {q x : ℝ} (hq₀ : 0 < q) (hq₁ : q < 1)
    (hx : qGammaPoleFree q (x : ℂ)) :
    qGamma q (x : ℂ) = (qGammaReal q x : ℂ)
-- ANCHOR_END: qGammaReal_coe
    := by sorry

/-- DLMF 5.18(ii): `ln Γ_q(x)` is convex for positive real `x`. -/
-- DLMF 5.18 https://dlmf.nist.gov/5.18#ii.p2
-- ANCHOR: dlmf_5_18_convexity
theorem dlmf_5_18_convexity {q : ℝ} (hq₀ : 0 < q) (hq₁ : q < 1) :
    ConvexOn ℝ (Set.Ioi (0 : ℝ)) (fun x : ℝ ↦ Real.log (qGammaReal q x))
-- ANCHOR_END: dlmf_5_18_convexity
    := by sorry

/-- DLMF 5.18(ii): q-Gamma is characterized by positivity, normalization,
the q-recurrence, and log-convexity on the positive real axis. -/
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

/-- DLMF 5.18.8: q-Gamma increases with the base on `0 < x < 1`. -/
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

/-- DLMF 5.18.10: q-Gamma tends to the ordinary Gamma function as `q → 1⁻`. -/
-- DLMF 5.18.10 https://dlmf.nist.gov/5.18.E10
-- ANCHOR: dlmf_5_18_10
theorem dlmf_5_18_10 (z : ℂ) :
    Tendsto (fun q : ℝ ↦ qGamma q z)
      (nhdsWithin 1 (Iio 1)) (𝓝 (Complex.Gamma z))
-- ANCHOR_END: dlmf_5_18_10
    := by sorry

/-! ### q-Beta function -/

/-- DLMF 5.18.11: q-Beta as a quotient of q-Gamma values. -/
-- DLMF 5.18.11 https://dlmf.nist.gov/5.18.E11
-- ANCHOR: dlmf_5_18_11
theorem dlmf_5_18_11 {q : ℝ} (hq₀ : 0 < q) (hq₁ : q < 1) (a b : ℂ) :
    qBeta q a b = qGamma q a * qGamma q b / qGamma q (a + b)
-- ANCHOR_END: dlmf_5_18_11
    := by sorry

/-- DLMF 5.18.12: q-Beta's Jackson integral representation. -/
-- DLMF 5.18.12 https://dlmf.nist.gov/5.18.E12
-- ANCHOR: dlmf_5_18_12
theorem dlmf_5_18_12 {q : ℝ} (hq₀ : 0 < q) (hq₁ : q < 1) {a b : ℂ}
    (ha : 0 < a.re) (hb : 0 < b.re) :
    qBeta q a b =
      qJacksonIntegral q (fun t : ℝ ↦
        Complex.cpow (t : ℂ) (a - 1) *
          qPochhammerInf (t * (q : ℂ)) (q : ℂ) /
            qPochhammerInf (t * Complex.cpow (q : ℂ) b) (q : ℂ))
-- ANCHOR_END: dlmf_5_18_12
    := by sorry

end LMLF.Blueprint.Gamma.Section518
