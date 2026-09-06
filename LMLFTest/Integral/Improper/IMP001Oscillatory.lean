import LMLF.Integral.Improper.Bochner
import LMLFTest.Integral.Improper.IMP001Regressions
import Mathlib.Analysis.PSeries
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds
import Mathlib.MeasureTheory.Integral.IntervalIntegral.IntegrationByParts
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Periodic
import Mathlib.MeasureTheory.Integral.Bochner.SumMeasure

/-!
Analytic regression examples for IMP-001 (IMP-R04, IMP-R05, IMP-R06, and the
negative half of IMP-R22).  All analytic support is deliberately private to
this test module.
-/

open Filter MeasureTheory Set
open scoped Interval Topology

noncomputable section

namespace LMLFTest.Integral.Improper.IMP001Oscillatory

open LMLF.Integral

private def cutoff (x : ℝ) : ℝ := max (1 - x ^ 2) 0

private def pCutoff (c t : ℝ) : ℝ :=
  if t - c = 0 then 0 else cutoff (t - c) / (t - c)

private def qCutoff (c t : ℝ) : ℝ :=
  if t - c = 0 then 0
  else cutoff (t - c) * Real.sin ((t - c)⁻¹) / (t - c)

private def sinDivTail (t : ℝ) : ℝ :=
  if 1 ≤ t then Real.sin t / t else 0

private def initialConditional (k t : ℝ) : ℝ :=
  if k < t then qCutoff k t else 0

private def dirichletIntegrand (t : ℝ) : ℝ := Real.sin t / t

private def cutoffTailIntegrand (t : ℝ) : ℝ :=
  (1 - t⁻¹ ^ 2) * (Real.sin t / t)

private def positiveCutoffTail (t : ℝ) : ℝ :=
  if 1 < t then cutoffTailIntegrand t else 0

private def finiteCutoffPrimitive (c LQ t : ℝ) : ℝ :=
  if t ≤ c - 1 then 0
  else if t < c then ∫ v in c - 1..t, qCutoff c v
  else if t = c then LQ
  else if t < c + 1 then 2 * LQ - ∫ v in t..c + 1, qCutoff c v
  else 2 * LQ

private lemma cutoff_eq {x : ℝ} (hx : |x| ≤ 1) : cutoff x = 1 - x ^ 2 := by
  rw [cutoff, max_eq_left]
  rcases abs_le.mp hx with ⟨hx₁, hx₂⟩
  nlinarith

private lemma cutoff_eq_zero {x : ℝ} (hx : 1 ≤ |x|) : cutoff x = 0 := by
  rw [cutoff, max_eq_right]
  rcases le_abs.mp hx with hx | hx <;> nlinarith

/- REG-I01: the finite-interval integration-by-parts identity. -/
private lemma dirichlet_identity {A B : ℝ} (hA : 1 ≤ A) (hAB : A ≤ B) :
    (∫ u in A..B, dirichletIntegrand u) =
      Real.cos A / A - Real.cos B / B -
        ∫ u in A..B, Real.cos u / u ^ 2 := by
  have hne : ∀ x ∈ Icc A B, x ≠ 0 := by
    intro x hx
    linarith [hx.1]
  have hu : ContinuousOn (fun x : ℝ => x⁻¹) [[A, B]] := by
    rw [uIcc_of_le hAB]
    exact continuousOn_id.inv₀ hne
  have hv : ContinuousOn (fun x : ℝ => 0 - Real.cos x) [[A, B]] := by
    fun_prop
  have huu : ∀ x ∈ Ioo (min A B) (max A B),
      HasDerivAt (fun y : ℝ => y⁻¹) (-(x ^ 2)⁻¹) x := by
    intro x hx
    apply hasDerivAt_inv
    apply hne x
    rw [min_eq_left hAB, max_eq_right hAB] at hx
    exact ⟨hx.1.le, hx.2.le⟩
  have hvv : ∀ x ∈ Ioo (min A B) (max A B),
      HasDerivAt (fun y : ℝ => 0 - Real.cos y) (Real.sin x) x := by
    intro x _
    simpa only [zero_sub, neg_neg] using (Real.hasDerivAt_cos x).const_sub 0
  have huInt : IntervalIntegrable (fun x : ℝ => -(x ^ 2)⁻¹) volume A B := by
    apply ContinuousOn.intervalIntegrable
    rw [uIcc_of_le hAB]
    exact (continuousOn_id.pow 2).inv₀ (fun x hx => pow_ne_zero _ (hne x hx)) |>.neg
  have hvInt : IntervalIntegrable Real.sin volume A B :=
    Real.continuous_sin.intervalIntegrable A B
  have hip := intervalIntegral.integral_mul_deriv_eq_deriv_mul_of_hasDerivAt
    hu hv huu hvv huInt hvInt
  have hfun : (fun u : ℝ => u⁻¹ * Real.sin u) = dirichletIntegrand := by
    funext u
    simp [dirichletIntegrand, div_eq_mul_inv, mul_comm]
  rw [hfun] at hip
  have hcos : (∫ u in A..B, Real.cos u / u ^ 2) =
      ∫ u in A..B, (u ^ 2)⁻¹ * Real.cos u := by
    apply intervalIntegral.integral_congr
    intro u _
    simp [div_eq_mul_inv, mul_comm]
  rw [hcos]
  simp only [zero_sub, mul_neg, neg_mul, neg_neg] at hip
  simpa [div_eq_mul_inv, mul_comm, sub_eq_add_neg, add_comm, add_left_comm,
    add_assoc] using hip

private lemma integral_inv_sq {A B : ℝ} (hA : 1 ≤ A) (hAB : A ≤ B) :
    (∫ u in A..B, (u ^ 2)⁻¹) = A⁻¹ - B⁻¹ := by
  have hne : ∀ x ∈ Icc A B, x ≠ 0 := by
    intro x hx
    linarith [hx.1]
  have hcont : ContinuousOn (fun x : ℝ => 0 - x⁻¹) (Icc A B) := by
    exact continuousOn_const.sub (continuousOn_id.inv₀ hne)
  have hderiv : ∀ x ∈ Ioo A B,
      HasDerivAt (fun y : ℝ => 0 - y⁻¹) ((x ^ 2)⁻¹) x := by
    intro x hx
    simpa only [zero_sub, neg_neg] using
      (hasDerivAt_inv (hne x ⟨hx.1.le, hx.2.le⟩)).const_sub 0
  have hint : IntervalIntegrable (fun x : ℝ => (x ^ 2)⁻¹) volume A B := by
    apply ContinuousOn.intervalIntegrable
    rw [uIcc_of_le hAB]
    exact (continuousOn_id.pow 2).inv₀ (fun x hx => pow_ne_zero _ (hne x hx))
  have h := intervalIntegral.integral_eq_sub_of_hasDerivAt_of_le hAB hcont hderiv hint
  simpa only [zero_sub, neg_sub_neg] using h

/- REG-I01, estimate form. -/
private lemma dirichlet_bound {A B : ℝ} (hA : 1 ≤ A) (hAB : A ≤ B) :
    |∫ u in A..B, dirichletIntegrand u| ≤ 2 / A := by
  have hB : 1 ≤ B := hA.trans hAB
  have hAB0 : 0 < A := lt_of_lt_of_le zero_lt_one hA
  have hB0 : 0 < B := lt_of_lt_of_le zero_lt_one hB
  have hcosInt : IntervalIntegrable (fun u : ℝ => Real.cos u / u ^ 2) volume A B := by
    apply ContinuousOn.intervalIntegrable
    rw [uIcc_of_le hAB]
    apply Real.continuous_cos.continuousOn.div (continuousOn_id.pow 2)
    intro x hx
    exact pow_ne_zero _ (by simp only [id_eq] at hx ⊢; linarith [hx.1])
  have hinvInt : IntervalIntegrable (fun u : ℝ => (u ^ 2)⁻¹) volume A B := by
    apply ContinuousOn.intervalIntegrable
    rw [uIcc_of_le hAB]
    exact (continuousOn_id.pow 2).inv₀ (fun x hx =>
      pow_ne_zero _ (by simp only [id_eq] at hx ⊢; linarith [hx.1]))
  have hcosBound :
      |∫ u in A..B, Real.cos u / u ^ 2| ≤ A⁻¹ - B⁻¹ := by
    calc
      |∫ u in A..B, Real.cos u / u ^ 2| =
          ‖∫ u in A..B, Real.cos u / u ^ 2‖ := by simp
      _ ≤ ∫ u in A..B, (u ^ 2)⁻¹ := by
        apply intervalIntegral.norm_integral_le_of_norm_le hAB
        · filter_upwards with u hu
          have hu0 : 0 < u := by linarith [hu.1]
          rw [Real.norm_eq_abs, abs_div, abs_of_pos (sq_pos_of_pos hu0)]
          calc
            |Real.cos u| / u ^ 2 ≤ 1 / u ^ 2 :=
              div_le_div_of_nonneg_right (Real.abs_cos_le_one u) (sq_nonneg u)
            _ = (u ^ 2)⁻¹ := by rw [one_div]
        · exact hinvInt
      _ = A⁻¹ - B⁻¹ := integral_inv_sq hA hAB
  rw [dirichlet_identity hA hAB]
  calc
    |Real.cos A / A - Real.cos B / B -
        ∫ u in A..B, Real.cos u / u ^ 2| ≤
        |Real.cos A / A| + |Real.cos B / B| +
          |∫ u in A..B, Real.cos u / u ^ 2| := by
            grw [abs_sub, abs_sub]
    _ ≤ A⁻¹ + B⁻¹ + (A⁻¹ - B⁻¹) := by
      gcongr
      · rw [abs_div, abs_of_pos hAB0]
        calc
          |Real.cos A| / A ≤ 1 / A :=
            div_le_div_of_nonneg_right (Real.abs_cos_le_one A) hAB0.le
          _ = A⁻¹ := by rw [one_div]
      · rw [abs_div, abs_of_pos hB0]
        calc
          |Real.cos B| / B ≤ 1 / B :=
            div_le_div_of_nonneg_right (Real.abs_cos_le_one B) hB0.le
          _ = B⁻¹ := by rw [one_div]
    _ = 2 / A := by field_simp; ring

private lemma dirichlet_intervalIntegrable {A B : ℝ} (hA : 1 ≤ A) (hAB : A ≤ B) :
    IntervalIntegrable dirichletIntegrand volume A B := by
  apply ContinuousOn.intervalIntegrable
  apply Real.continuous_sin.continuousOn.div continuousOn_id
  intro x hx
  simp only [id_eq]
  have hxA : A ≤ x := by
    rw [uIcc_of_le hAB] at hx
    exact hx.1
  linarith

/- REG-I02: the exact Dirichlet partial integrals have a finite atTop limit. -/
private lemma exists_dirichlet_limit :
    ∃ L : ℝ, Tendsto (fun R => ∫ u in (1 : ℝ)..R, dirichletIntegrand u)
      atTop (nhds L) := by
  let H : ℝ → ℝ := fun R => ∫ u in (1 : ℝ)..R, dirichletIntegrand u
  apply cauchy_map_iff_exists_tendsto.mp
  rw [Metric.cauchy_iff]
  refine ⟨by infer_instance, ?_⟩
  intro ε hε
  let A : ℝ := max 1 (5 / ε)
  have hA : 1 ≤ A := le_max_left _ _
  have hA0 : 0 < A := zero_lt_one.trans_le hA
  have htail : 2 / A < ε / 2 := by
    rw [div_lt_iff₀ hA0]
    have hAε : 5 ≤ A * ε := by
      have := le_max_right (1 : ℝ) (5 / ε)
      rw [div_le_iff₀ hε] at this
      nlinarith
    nlinarith
  have hnear : ∀ R, A ≤ R → dist (H R) (H A) < ε / 2 := by
    intro R hAR
    have h1A := dirichlet_intervalIntegrable (A := (1 : ℝ)) (B := A) le_rfl hA
    have hARInt := dirichlet_intervalIntegrable (A := A) (B := R) hA hAR
    have hadd := intervalIntegral.integral_add_adjacent_intervals h1A hARInt
    rw [Real.dist_eq]
    have heq : H R - H A = ∫ u in A..R, dirichletIntegrand u := by
      dsimp only [H]
      linarith
    rw [heq]
    exact (dirichlet_bound hA hAR).trans_lt htail
  refine ⟨Metric.ball (H A) (ε / 2), ?_, ?_⟩
  · rw [Filter.mem_map]
    exact mem_atTop_sets.mpr ⟨A, fun R hAR => by
      rw [Set.mem_preimage, Metric.mem_ball]
      exact hnear R hAR⟩
  · intro x hx y hy
    rw [Metric.mem_ball] at hx hy
    exact (dist_triangle_right x y (H A)).trans_lt (by linarith [hx, hy])

private lemma integral_inv_cube {A B : ℝ} (hA : 1 ≤ A) (hAB : A ≤ B) :
    (∫ u in A..B, (u ^ 3)⁻¹) = 1 / (2 * A ^ 2) - 1 / (2 * B ^ 2) := by
  have hzero : (0 : ℝ) ∉ [[A, B]] := by
    rw [uIcc_of_le hAB]
    intro h
    linarith [h.1]
  have h := integral_zpow (a := A) (b := B) (n := (-3 : ℤ))
    (Or.inr ⟨by norm_num, hzero⟩)
  norm_num [zpow_neg, pow_succ, div_eq_mul_inv] at h
  have hfun : (fun u : ℝ => (u ^ 3)⁻¹) =
      fun u => u⁻¹ * (u⁻¹ * u⁻¹) := by
    funext u
    simp [pow_succ]
  rw [hfun]
  rw [h]
  ring

private lemma correction_intervalIntegrable {A B : ℝ} (hA : 1 ≤ A) (hAB : A ≤ B) :
    IntervalIntegrable (fun u : ℝ => Real.sin u / u ^ 3) volume A B := by
  apply ContinuousOn.intervalIntegrable
  rw [uIcc_of_le hAB]
  apply Real.continuous_sin.continuousOn.div (continuousOn_id.pow 3)
  intro x hx
  apply pow_ne_zero
  simp only [id_eq]
  linarith [hx.1]

private lemma correction_bound {A B : ℝ} (hA : 1 ≤ A) (hAB : A ≤ B) :
    |∫ u in A..B, Real.sin u / u ^ 3| ≤ 1 / (2 * A ^ 2) := by
  have hA0 : 0 < A := zero_lt_one.trans_le hA
  have hinvInt : IntervalIntegrable (fun u : ℝ => (u ^ 3)⁻¹) volume A B := by
    apply ContinuousOn.intervalIntegrable
    rw [uIcc_of_le hAB]
    exact (continuousOn_id.pow 3).inv₀ (fun x hx =>
      pow_ne_zero _ (by simp only [id_eq] at hx ⊢; linarith [hx.1]))
  calc
    |∫ u in A..B, Real.sin u / u ^ 3| =
        ‖∫ u in A..B, Real.sin u / u ^ 3‖ := by simp
    _ ≤ ∫ u in A..B, (u ^ 3)⁻¹ := by
      apply intervalIntegral.norm_integral_le_of_norm_le hAB
      · filter_upwards with u hu
        have hu0 : 0 < u := by linarith [hu.1]
        rw [Real.norm_eq_abs, abs_div, abs_of_pos (pow_pos hu0 3)]
        calc
          |Real.sin u| / u ^ 3 ≤ 1 / u ^ 3 :=
            div_le_div_of_nonneg_right (Real.abs_sin_le_one u) (pow_nonneg hu0.le 3)
          _ = (u ^ 3)⁻¹ := by rw [one_div]
      · exact hinvInt
    _ = 1 / (2 * A ^ 2) - 1 / (2 * B ^ 2) := integral_inv_cube hA hAB
    _ ≤ 1 / (2 * A ^ 2) := by
      have : 0 ≤ 1 / (2 * B ^ 2) := by positivity
      linarith

private lemma cutoffTail_eq_sub {u : ℝ} (hu : 0 < u) :
    cutoffTailIntegrand u = dirichletIntegrand u - Real.sin u / u ^ 3 := by
  simp only [cutoffTailIntegrand, dirichletIntegrand]
  field_simp

private lemma cutoffTail_intervalIntegrable {A B : ℝ} (hA : 1 ≤ A) (hAB : A ≤ B) :
    IntervalIntegrable cutoffTailIntegrand volume A B := by
  have hd := dirichlet_intervalIntegrable hA hAB
  have hc := correction_intervalIntegrable hA hAB
  apply (hd.sub hc).congr
  intro u hu
  rw [uIoc_of_le hAB] at hu
  exact (cutoffTail_eq_sub (by linarith [hu.1])).symm

/- REG-I04: the cutoff correction has the reviewed explicit tail modulus. -/
private lemma cutoffTail_bound {A B : ℝ} (hA : 1 ≤ A) (hAB : A ≤ B) :
    |∫ u in A..B, cutoffTailIntegrand u| ≤ 2 / A + 1 / (2 * A ^ 2) := by
  have hd := dirichlet_intervalIntegrable hA hAB
  have hc := correction_intervalIntegrable hA hAB
  have heq : (∫ u in A..B, cutoffTailIntegrand u) =
      (∫ u in A..B, dirichletIntegrand u) -
        ∫ u in A..B, Real.sin u / u ^ 3 := by
    rw [← intervalIntegral.integral_sub hd hc]
    apply intervalIntegral.integral_congr
    intro u hu
    rw [uIcc_of_le hAB] at hu
    exact cutoffTail_eq_sub (by linarith [hu.1])
  rw [heq]
  exact (abs_sub _ _).trans <| add_le_add (dirichlet_bound hA hAB)
    (correction_bound hA hAB)

private lemma exists_cutoffTail_limit :
    ∃ L : ℝ, Tendsto (fun R => ∫ u in (1 : ℝ)..R, cutoffTailIntegrand u)
      atTop (nhds L) := by
  let Q : ℝ → ℝ := fun R => ∫ u in (1 : ℝ)..R, cutoffTailIntegrand u
  apply cauchy_map_iff_exists_tendsto.mp
  rw [Metric.cauchy_iff]
  refine ⟨by infer_instance, ?_⟩
  intro ε hε
  let A : ℝ := max 1 (10 / ε)
  have hA : 1 ≤ A := le_max_left _ _
  have hA0 : 0 < A := zero_lt_one.trans_le hA
  have htail : 2 / A + 1 / (2 * A ^ 2) < ε / 2 := by
    have hAε : 10 ≤ A * ε := by
      have := le_max_right (1 : ℝ) (10 / ε)
      rw [div_le_iff₀ hε] at this
      nlinarith
    have hA2 : 1 ≤ A ^ 2 := by nlinarith
    have hfirst : 2 / A ≤ ε / 5 := by
      rw [div_le_iff₀ hA0]
      nlinarith
    have hsecond : 1 / (2 * A ^ 2) ≤ ε / 20 := by
      have hden : 0 < 2 * A ^ 2 := by positivity
      rw [div_le_iff₀ hden]
      have : 1 ≤ A ^ 2 := hA2
      nlinarith
    linarith
  have hnear : ∀ R, A ≤ R → dist (Q R) (Q A) < ε / 2 := by
    intro R hAR
    have h1A := cutoffTail_intervalIntegrable (A := (1 : ℝ)) (B := A) le_rfl hA
    have hARInt := cutoffTail_intervalIntegrable (A := A) (B := R) hA hAR
    have hadd := intervalIntegral.integral_add_adjacent_intervals h1A hARInt
    rw [Real.dist_eq]
    have heq : Q R - Q A = ∫ u in A..R, cutoffTailIntegrand u := by
      dsimp only [Q]
      linarith
    rw [heq]
    exact (cutoffTail_bound hA hAR).trans_lt htail
  refine ⟨Metric.ball (Q A) (ε / 2), ?_, ?_⟩
  · rw [Filter.mem_map]
    exact mem_atTop_sets.mpr ⟨A, fun R hAR => by
      rw [Set.mem_preimage, Metric.mem_ball]
      exact hnear R hAR⟩
  · intro x hx y hy
    rw [Metric.mem_ball] at hx hy
    exact (dist_triangle_right x y (Q A)).trans_lt (by linarith [hx, hy])

private lemma abs_sin_lower_on_harmonic_interval (n : ℕ) (u : ℝ)
    (hu : u ∈ Icc ((n : ℝ) * Real.pi + Real.pi / 6)
      ((n : ℝ) * Real.pi + 5 * Real.pi / 6)) :
    (1 / 2 : ℝ) ≤ |Real.sin u| := by
  let θ : ℝ := u - (n : ℝ) * Real.pi
  have hθlo : Real.pi / 6 ≤ θ := by dsimp only [θ]; linarith [hu.1]
  have hθhi : θ ≤ 5 * Real.pi / 6 := by dsimp only [θ]; linarith [hu.2]
  have hsin : (1 / 2 : ℝ) ≤ Real.sin θ := by
    by_cases hmid : θ ≤ Real.pi / 2
    · have hloMem : Real.pi / 6 ∈ Icc (-(Real.pi / 2)) (Real.pi / 2) := by
        constructor <;> nlinarith [Real.pi_pos]
      have hθMem : θ ∈ Icc (-(Real.pi / 2)) (Real.pi / 2) := by
        constructor <;> nlinarith [Real.pi_pos]
      have hmono := Real.strictMonoOn_sin.monotoneOn hloMem hθMem hθlo
      simpa [Real.sin_pi_div_six] using hmono
    · have hreflectLo : Real.pi / 6 ≤ Real.pi - θ := by linarith
      have hreflectHi : Real.pi - θ ≤ Real.pi / 2 := by linarith
      have hloMem : Real.pi / 6 ∈ Icc (-(Real.pi / 2)) (Real.pi / 2) := by
        constructor <;> nlinarith [Real.pi_pos]
      have hreflectMem : Real.pi - θ ∈ Icc (-(Real.pi / 2)) (Real.pi / 2) := by
        constructor <;> nlinarith [Real.pi_pos]
      have hmono := Real.strictMonoOn_sin.monotoneOn hloMem hreflectMem hreflectLo
      rw [Real.sin_pi_sub] at hmono
      simpa [Real.sin_pi_div_six] using hmono
  have huform : u = θ + (n : ℝ) * Real.pi := by dsimp only [θ]; ring
  rw [huform, Real.sin_add_nat_mul_pi]
  rw [abs_mul, abs_pow, abs_neg, abs_one, one_pow, one_mul]
  exact hsin.trans (le_abs_self _)

private lemma harmonic_interval_lower (n : ℕ) (hn : 1 ≤ n) :
    1 / (3 * ((n + 1 : ℕ) : ℝ)) ≤
      ∫ u in (n : ℝ) * Real.pi + Real.pi / 6..
        (n : ℝ) * Real.pi + 5 * Real.pi / 6,
        |Real.sin u| / u := by
  let a : ℝ := (n : ℝ) * Real.pi + Real.pi / 6
  let b : ℝ := (n : ℝ) * Real.pi + 5 * Real.pi / 6
  let C : ℝ := 1 / (2 * (((n + 1 : ℕ) : ℝ) * Real.pi))
  have hab : a ≤ b := by dsimp only [a, b]; nlinarith [Real.pi_pos]
  have ha0 : 0 < a := by
    have hn0 : 0 < (n : ℝ) := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hn)
    dsimp only [a]
    positivity
  have hfInt : IntervalIntegrable (fun u : ℝ => |Real.sin u| / u) volume a b := by
    apply ContinuousOn.intervalIntegrable
    apply Real.continuous_sin.abs.continuousOn.div continuousOn_id
    intro u hu
    simp only [id_eq]
    rw [uIcc_of_le hab] at hu
    linarith [ha0, hu.1]
  have hpoint : ∀ u ∈ Icc a b, C ≤ |Real.sin u| / u := by
    intro u hu
    have hu0 : 0 < u := by linarith [ha0, hu.1]
    have hub : u ≤ (((n + 1 : ℕ) : ℝ) * Real.pi) := by
      dsimp only [b] at hu
      push_cast
      nlinarith [hu.2, Real.pi_pos]
    have hden : 0 < (((n + 1 : ℕ) : ℝ) * Real.pi) := by positivity
    have hsin := abs_sin_lower_on_harmonic_interval n u (by simpa [a, b] using hu)
    calc
      C = (1 / 2 : ℝ) / (((n + 1 : ℕ) : ℝ) * Real.pi) := by
        simp [C, div_eq_mul_inv]
        ring
      _ ≤ (1 / 2 : ℝ) / u := by
        exact div_le_div_of_nonneg_left (by positivity) hu0 hub
      _ ≤ |Real.sin u| / u := by
        exact (div_le_div_iff_of_pos_right hu0).mpr hsin
  have hmono : (∫ u in a..b, C) ≤ ∫ u in a..b, |Real.sin u| / u :=
    intervalIntegral.integral_mono_on hab intervalIntegrable_const hfInt hpoint
  have hconst : (∫ _u in a..b, C) = 1 / (3 * ((n + 1 : ℕ) : ℝ)) := by
    simp only [intervalIntegral.integral_const, smul_eq_mul]
    dsimp only [a, b, C]
    have hn1 : (0 : ℝ) < (n + 1 : ℕ) := by positivity
    field_simp
    ring
  rw [← hconst]
  exact hmono

/- REG-I03: the Dirichlet integrand is not Bochner integrable on the ray. -/
private lemma dirichlet_not_integrableOn_Ioi :
    ¬ IntegrableOn dirichletIntegrand (Ioi 1) := by
  intro hInt
  let s : ℕ → Set ℝ := fun n =>
    Ioc (((n + 1 : ℕ) : ℝ) * Real.pi + Real.pi / 6)
      (((n + 1 : ℕ) : ℝ) * Real.pi + 5 * Real.pi / 6)
  have hdis : Pairwise (fun i j => Disjoint (s i) (s j)) := by
    intro i j hij
    rcases lt_or_gt_of_ne hij with hij | hji
    · apply Set.Ioc_disjoint_Ioc_of_le
      have hc : ((i + 2 : ℕ) : ℝ) ≤ (j + 1 : ℕ) := by
        have : i + 2 ≤ j + 1 := by omega
        exact_mod_cast this
      have hcmul := mul_le_mul_of_nonneg_right hc Real.pi_pos.le
      push_cast at hcmul
      calc
        ((i + 1 : ℕ) : ℝ) * Real.pi + 5 * Real.pi / 6 ≤
            ((i : ℝ) + 2) * Real.pi := by
          push_cast
          nlinarith [Real.pi_pos]
        _ ≤ ((j : ℝ) + 1) * Real.pi := hcmul
        _ ≤ ((j + 1 : ℕ) : ℝ) * Real.pi + Real.pi / 6 := by
          push_cast
          exact le_add_of_nonneg_right (by positivity)
    · apply (Set.Ioc_disjoint_Ioc_of_le ?_).symm
      have hc : ((j + 2 : ℕ) : ℝ) ≤ (i + 1 : ℕ) := by
        have : j + 2 ≤ i + 1 := by omega
        exact_mod_cast this
      have hcmul := mul_le_mul_of_nonneg_right hc Real.pi_pos.le
      push_cast at hcmul
      calc
        ((j + 1 : ℕ) : ℝ) * Real.pi + 5 * Real.pi / 6 ≤
            ((j : ℝ) + 2) * Real.pi := by
          push_cast
          nlinarith [Real.pi_pos]
        _ ≤ ((i : ℝ) + 1) * Real.pi := hcmul
        _ ≤ ((i + 1 : ℕ) : ℝ) * Real.pi + Real.pi / 6 := by
          push_cast
          exact le_add_of_nonneg_right (by positivity)
  have hsub : (⋃ n, s n) ⊆ Ioi (1 : ℝ) := by
    intro x hx
    rw [mem_iUnion] at hx
    rcases hx with ⟨n, hn⟩
    rw [mem_Ioi]
    dsimp only [s] at hn
    have hncast : (1 : ℝ) ≤ ((n + 1 : ℕ) : ℝ) := by
      exact_mod_cast Nat.succ_le_succ (Nat.zero_le n)
    nlinarith [hn.1, Real.two_le_pi, Real.pi_pos]
  have hsumEq : Measure.sum (fun n => volume.restrict (s n)) =
      volume.restrict (⋃ n, s n) :=
    (Measure.restrict_iUnion hdis (fun _ => measurableSet_Ioc)).symm
  have hsumLe : Measure.sum (fun n => volume.restrict (s n)) ≤
      volume.restrict (Ioi (1 : ℝ)) := by
    rw [hsumEq]
    exact Measure.restrict_mono hsub le_rfl
  have hIntSum : Integrable dirichletIntegrand
      (Measure.sum (fun n => volume.restrict (s n))) :=
    hInt.integrable.mono_measure hsumLe
  have hsummable : Summable (fun n =>
      ∫ x, ‖dirichletIntegrand x‖ ∂volume.restrict (s n)) :=
    hIntSum.summable_integral
  have hterm (n : ℕ) :
      (∫ x, ‖dirichletIntegrand x‖ ∂volume.restrict (s n)) =
        ∫ u in ((n + 1 : ℕ) : ℝ) * Real.pi + Real.pi / 6..
          ((n + 1 : ℕ) : ℝ) * Real.pi + 5 * Real.pi / 6,
          |Real.sin u| / u := by
    let a : ℝ := ((n + 1 : ℕ) : ℝ) * Real.pi + Real.pi / 6
    let b : ℝ := ((n + 1 : ℕ) : ℝ) * Real.pi + 5 * Real.pi / 6
    have hab : a ≤ b := by dsimp only [a, b]; nlinarith [Real.pi_pos]
    change (∫ x in Ioc a b, ‖dirichletIntegrand x‖) = _
    rw [← intervalIntegral.integral_of_le hab]
    apply intervalIntegral.integral_congr
    intro u hu
    rw [uIcc_of_le hab] at hu
    have hu0 : 0 < u := by
      dsimp only [a] at hu
      have hncast : (1 : ℝ) ≤ ((n + 1 : ℕ) : ℝ) := by
        exact_mod_cast Nat.succ_le_succ (Nat.zero_le n)
      nlinarith [hu.1, Real.two_le_pi, Real.pi_pos]
    simp [dirichletIntegrand, Real.norm_eq_abs, abs_of_pos hu0]
  have hlower : ∀ n : ℕ,
      1 / (3 * ((n + 2 : ℕ) : ℝ)) ≤
        ∫ x, ‖dirichletIntegrand x‖ ∂volume.restrict (s n) := by
    intro n
    rw [hterm n]
    simpa only [Nat.add_assoc] using harmonic_interval_lower (n + 1) (by omega)
  have hshifted : Summable (fun n : ℕ => 1 / (3 * ((n + 2 : ℕ) : ℝ))) :=
    hsummable.of_nonneg_of_le (fun _ => by positivity) hlower
  have hharmonic : Summable (fun n : ℕ => 1 / ((n + 2 : ℕ) : ℝ)) := by
    have hscaled := hshifted.mul_left 3
    apply hscaled.congr
    intro n
    field_simp
  apply Real.not_summable_one_div_natCast
  rw [← _root_.summable_nat_add_iff 2]
  simpa [Nat.cast_add] using hharmonic

/- REG-I04, nonabsolute half: the cutoff factor retains a fixed half of the
absolute Dirichlet tail once `u > 2`. -/
private lemma cutoffTail_not_integrableOn_Ioi :
    ¬ IntegrableOn cutoffTailIntegrand (Ioi 1) := by
  intro hcut
  have hcut2 : IntegrableOn cutoffTailIntegrand (Ioi 2) :=
    hcut.mono_set (Ioi_subset_Ioi (by norm_num))
  have hmajor : IntegrableOn (fun u => 2 * cutoffTailIntegrand u) (Ioi 2) :=
    hcut2.const_mul 2
  have hmeas : AEStronglyMeasurable dirichletIntegrand
      (volume.restrict (Ioi 2)) := by
    refine ContinuousOn.aestronglyMeasurable ?_ measurableSet_Ioi
    apply Real.continuous_sin.continuousOn.div continuousOn_id
    intro u hu
    change 2 < u at hu
    simp only [id_eq]
    exact ne_of_gt (by linarith)
  have htail : IntegrableOn dirichletIntegrand (Ioi 2) := by
    apply hmajor.integrable.mono hmeas
    apply (ae_restrict_iff' measurableSet_Ioi).2
    filter_upwards with u
    intro hu
    have hu2 : 2 < u := hu
    have hu0 : 0 < u := by linarith
    have hinv : u⁻¹ ^ 2 ≤ 1 / 4 := by
      have huinv : u⁻¹ ≤ (2 : ℝ)⁻¹ :=
        (inv_le_inv₀ hu0 (by positivity)).2 hu2.le
      have huinv0 : 0 ≤ u⁻¹ := inv_nonneg.mpr hu0.le
      nlinarith
    have hcoef : 1 ≤ 2 * (1 - u⁻¹ ^ 2) := by nlinarith
    have hcoef0 : 0 ≤ 1 - u⁻¹ ^ 2 := by nlinarith
    rw [Real.norm_eq_abs, Real.norm_eq_abs]
    calc
      |dirichletIntegrand u| = 1 * |dirichletIntegrand u| := by ring
      _ ≤ (2 * (1 - u⁻¹ ^ 2)) * |dirichletIntegrand u| :=
        mul_le_mul_of_nonneg_right hcoef (abs_nonneg _)
      _ = |2 * cutoffTailIntegrand u| := by
        have hcutEq : cutoffTailIntegrand u =
            (1 - u⁻¹ ^ 2) * dirichletIntegrand u := rfl
        rw [hcutEq, abs_mul, abs_mul, abs_of_nonneg (by norm_num : (0 : ℝ) ≤ 2),
          abs_of_nonneg hcoef0]
        ring
  have hcompact : IntegrableOn dirichletIntegrand (Ioc 1 2) := by
    rw [← intervalIntegrable_iff_integrableOn_Ioc_of_le (by norm_num)]
    exact dirichlet_intervalIntegrable le_rfl (by norm_num)
  have hwhole := hcompact.union htail
  rw [Ioc_union_Ioi_eq_Ioi (by norm_num : (1 : ℝ) ≤ 2)] at hwhole
  exact dirichlet_not_integrableOn_Ioi hwhole

private lemma qCutoff_zero_formula {x : ℝ} (hx0 : 0 < x) (hx1 : x ≤ 1) :
    qCutoff 0 x = (1 - x ^ 2) * Real.sin x⁻¹ / x := by
  rw [qCutoff, if_neg (by linarith)]
  rw [show x - 0 = x by ring, cutoff_eq]
  rw [abs_of_pos hx0]
  exact hx1

private lemma positiveCutoffTail_not_integrableOn_Ioi_zero :
    ¬ IntegrableOn positiveCutoffTail (Ioi 0) := by
  intro h
  apply cutoffTail_not_integrableOn_Ioi
  apply (h.mono_set (Ioi_subset_Ioi (by norm_num : (0 : ℝ) ≤ 1))).congr_fun_ae
  apply (ae_restrict_iff' measurableSet_Ioi).2
  filter_upwards with t
  intro ht
  change 1 < t at ht
  simp [positiveCutoffTail, ht]

private lemma transformed_positiveCutoffTail_eq_qCutoff_zero {x : ℝ} (hx : 0 < x) :
    (|(-1 : ℝ)| * x ^ ((-1 : ℝ) - 1)) •
        positiveCutoffTail (x ^ (-1 : ℝ)) = qCutoff 0 x := by
  simp only [abs_neg, abs_one, one_mul, Real.rpow_neg_one]
  by_cases hx1 : x < 1
  · have hxinv : 1 < x⁻¹ := (one_lt_inv₀ hx).2 hx1
    rw [positiveCutoffTail, if_pos hxinv, qCutoff_zero_formula hx hx1.le]
    rw [show (-1 : ℝ) - 1 = -2 by ring, Real.rpow_neg hx.le, Real.rpow_two]
    simp only [cutoffTailIntegrand]
    field_simp [hx.ne']
    simp only [smul_eq_mul]
    field_simp [hx.ne']
  · have h1x : 1 ≤ x := le_of_not_gt hx1
    have hxinv : x⁻¹ ≤ 1 := (inv_le_one₀ hx).2 h1x
    rw [positiveCutoffTail, if_neg (not_lt_of_ge hxinv)]
    rw [qCutoff, if_neg (by linarith), sub_zero, cutoff_eq_zero]
    · simp
    · rw [abs_of_pos hx]
      exact h1x

private lemma qCutoff_zero_not_integrableOn_Ioi_zero :
    ¬ IntegrableOn (qCutoff 0) (Ioi 0) := by
  intro hq
  apply positiveCutoffTail_not_integrableOn_Ioi_zero
  have hiff := integrableOn_Ioi_comp_rpow_iff positiveCutoffTail
    (show (-1 : ℝ) ≠ 0 by norm_num)
  apply hiff.mp
  apply hq.congr_fun_ae
  apply (ae_restrict_iff' measurableSet_Ioi).2
  filter_upwards with x
  intro hx
  exact (transformed_positiveCutoffTail_eq_qCutoff_zero hx).symm

private lemma cutoffTail_continuousOn_pos :
    ContinuousOn cutoffTailIntegrand (Ioi 0) := by
  have hinv : ContinuousOn (fun x : ℝ => x⁻¹) (Ioi 0) :=
    continuousOn_id.inv₀ (fun x hx => by
    simp only [id_eq]
    exact ne_of_gt hx)
  have hdir : ContinuousOn dirichletIntegrand (Ioi 0) := by
    apply Real.continuous_sin.continuousOn.div continuousOn_id
    intro x hx
    simp only [id_eq]
    exact ne_of_gt hx
  exact (continuousOn_const.sub (hinv.pow 2)).mul hdir

/- The reviewed prime change-of-variables calculation for `x ↦ x⁻¹`. -/
private lemma qCutoff_zero_right_substitution {δ : ℝ} (hδ0 : 0 < δ) (hδ1 : δ < 1) :
    (∫ x in δ..1, qCutoff 0 x) =
      ∫ u in (1 : ℝ)..δ⁻¹, cutoffTailIntegrand u := by
  have hδle : δ ≤ 1 := hδ1.le
  have hne : ∀ x ∈ [[(1 : ℝ), δ]], x ≠ 0 := by
    intro x hx
    rw [uIcc_of_ge hδle] at hx
    linarith [hx.1]
  have hderiv : ∀ x ∈ [[(1 : ℝ), δ]],
      HasDerivAt (fun y : ℝ => y⁻¹) (-(x ^ 2)⁻¹) x := by
    intro x hx
    exact hasDerivAt_inv (hne x hx)
  have hderivCont : ContinuousOn (fun x : ℝ => -(x ^ 2)⁻¹) [[(1 : ℝ), δ]] := by
    rw [uIcc_of_ge hδle]
    exact ((continuousOn_id.pow 2).inv₀ (fun x hx =>
      pow_ne_zero _ (by simp only [id_eq] at hx ⊢; linarith [hx.1]))).neg
  have houter : ContinuousOn cutoffTailIntegrand
      ((fun x : ℝ => x⁻¹) '' [[(1 : ℝ), δ]]) := by
    apply cutoffTail_continuousOn_pos.mono
    rintro _ ⟨x, hx, rfl⟩
    exact inv_pos.mpr (lt_of_lt_of_le hδ0 (by
      rw [uIcc_of_ge hδle] at hx
      exact hx.1))
  have hsubst := intervalIntegral.integral_comp_mul_deriv'
    (a := (1 : ℝ)) (b := δ) (f := fun x : ℝ => x⁻¹)
    (f' := fun x => -(x ^ 2)⁻¹) (g := cutoffTailIntegrand)
    hderiv hderivCont houter
  have hpoint : ∀ x ∈ [[(1 : ℝ), δ]],
      (cutoffTailIntegrand ∘ fun y : ℝ => y⁻¹) x * (-(x ^ 2)⁻¹) =
        -qCutoff 0 x := by
    intro x hx
    rw [uIcc_of_ge hδle] at hx
    have hx0 : 0 < x := hδ0.trans_le hx.1
    rw [qCutoff_zero_formula hx0 hx.2]
    simp only [Function.comp_apply, cutoffTailIntegrand]
    field_simp
  calc
    (∫ x in δ..1, qCutoff 0 x) = -(∫ x in (1 : ℝ)..δ, qCutoff 0 x) := by
      rw [intervalIntegral.integral_symm]
    _ = ∫ x in (1 : ℝ)..δ, -qCutoff 0 x := by
      rw [intervalIntegral.integral_neg]
    _ = ∫ x in (1 : ℝ)..δ,
        (cutoffTailIntegrand ∘ fun y : ℝ => y⁻¹) x * (-(x ^ 2)⁻¹) := by
      apply intervalIntegral.integral_congr
      intro x hx
      exact (hpoint x hx).symm
    _ = ∫ u in (1 : ℝ)..δ⁻¹, cutoffTailIntegrand u := by simpa using hsubst

private lemma cutoff_continuous : Continuous cutoff := by
  unfold cutoff
  fun_prop

private lemma qCutoff_zero_continuousOn_pos : ContinuousOn (qCutoff 0) (Ioi 0) := by
  have hinv : ContinuousOn (fun x : ℝ => x⁻¹) (Ioi 0) :=
    continuousOn_id.inv₀ (fun x hx => by
      simp only [id_eq]
      exact ne_of_gt hx)
  have hsinInv : ContinuousOn (fun x : ℝ => Real.sin x⁻¹) (Ioi 0) :=
    Real.continuous_sin.comp_continuousOn hinv
  have hformula : ContinuousOn
      (fun x : ℝ => cutoff x * Real.sin x⁻¹ / x) (Ioi 0) := by
    apply (cutoff_continuous.continuousOn.mul hsinInv).div continuousOn_id
    intro x hx
    simp only [id_eq]
    exact ne_of_gt hx
  apply hformula.congr
  intro x hx
  change 0 < x at hx
  rw [qCutoff, if_neg (by linarith)]
  ring_nf

private lemma qCutoff_continuousAt_of_ne {c t : ℝ} (ht : t ≠ c) :
    ContinuousAt (qCutoff c) t := by
  have hsub : ContinuousAt (fun x : ℝ => x - c) t := continuousAt_id.sub_const c
  have hne : t - c ≠ 0 := sub_ne_zero.mpr ht
  have hinv : ContinuousAt (fun x : ℝ => (x - c)⁻¹) t := hsub.inv₀ hne
  have hcut : ContinuousAt (fun x : ℝ => cutoff (x - c)) t := by
    simpa [Function.comp_def] using cutoff_continuous.continuousAt.comp hsub
  have hsin : ContinuousAt (fun x : ℝ => Real.sin ((x - c)⁻¹)) t := by
    simpa [Function.comp_def] using Real.continuous_sin.continuousAt.comp hinv
  have hform : ContinuousAt
      (fun x : ℝ => cutoff (x - c) * Real.sin ((x - c)⁻¹) / (x - c)) t :=
    hcut.mul hsin |>.div hsub hne
  apply hform.congr_of_eventuallyEq
  filter_upwards [hsub.eventually_ne (sub_ne_zero.mpr ht)] with x hx
  simp [qCutoff, hx]

private lemma qCutoff_intervalIntegrable_of_not_mem_uIcc {c a b : ℝ}
    (hc : c ∉ [[a, b]]) : IntervalIntegrable (qCutoff c) volume a b := by
  apply ContinuousOn.intervalIntegrable
  intro t ht
  have htc : t ≠ c := by
    intro h
    subst t
    exact hc ht
  exact (qCutoff_continuousAt_of_ne htc).continuousWithinAt

private lemma qCutoff_eq_zero_of_le (c : ℝ) {t : ℝ} (ht : t ≤ c - 1) :
    qCutoff c t = 0 := by
  rw [qCutoff, if_neg (by linarith), cutoff_eq_zero]
  · simp
  · rw [abs_of_nonpos (by linarith : t - c ≤ 0)]
    linarith

private lemma qCutoff_eq_zero_of_ge (c : ℝ) {t : ℝ} (ht : c + 1 ≤ t) :
    qCutoff c t = 0 := by
  rw [qCutoff, if_neg (by linarith), cutoff_eq_zero]
  · simp
  · rw [abs_of_nonneg (by linarith : 0 ≤ t - c)]
    linarith

private lemma finiteCutoffPrimitive_left {c LQ t : ℝ} (ht : t < c) :
    finiteCutoffPrimitive c LQ t = ∫ v in c - 1..t, qCutoff c v := by
  by_cases hfar : t ≤ c - 1
  · rw [finiteCutoffPrimitive, if_pos hfar]
    symm
    rw [← intervalIntegral.integral_zero]
    apply intervalIntegral.integral_congr
    intro v hv
    rw [uIcc_of_ge hfar] at hv
    exact qCutoff_eq_zero_of_le c hv.2
  · simp [finiteCutoffPrimitive, hfar, ht]

private lemma finiteCutoffPrimitive_right {c LQ t : ℝ} (ht : c < t) :
    finiteCutoffPrimitive c LQ t =
      2 * LQ - ∫ v in t..c + 1, qCutoff c v := by
  by_cases hnear : t < c + 1
  · simp [finiteCutoffPrimitive, (by linarith : ¬t ≤ c - 1), (by linarith : ¬t < c),
      (by linarith : t ≠ c), hnear]
  · have hfar : c + 1 ≤ t := le_of_not_gt hnear
    rw [finiteCutoffPrimitive, if_neg (by linarith), if_neg (by linarith),
      if_neg (by linarith), if_neg hnear]
    have hz : (∫ v in t..c + 1, qCutoff c v) = 0 := by
      rw [← intervalIntegral.integral_zero]
      apply intervalIntegral.integral_congr
      intro v hv
      rw [uIcc_of_ge hfar] at hv
      exact qCutoff_eq_zero_of_ge c hv.1
    rw [hz, sub_zero]

private lemma finiteCutoffPrimitive_center (c LQ : ℝ) :
    finiteCutoffPrimitive c LQ c = LQ := by
  simp [finiteCutoffPrimitive]

private lemma pCutoff_formula {c t : ℝ} (h0 : t ≠ c) (h1 : |t - c| ≤ 1) :
    pCutoff c t = 1 / (t - c) - (t - c) := by
  rw [pCutoff, if_neg (sub_ne_zero.mpr h0), cutoff_eq h1]
  field_simp [sub_ne_zero.mpr h0]

private lemma pCutoff_right_integral {c δ : ℝ} (hδ0 : 0 < δ) (hδ1 : δ ≤ 1) :
    (∫ t in c + δ..c + 1, pCutoff c t) =
      -Real.log δ + (δ ^ 2 - 1) / 2 := by
  have hinv : IntervalIntegrable (fun x : ℝ => 1 / x) volume δ 1 := by
    apply ContinuousOn.intervalIntegrable
    apply continuousOn_const.div continuousOn_id
    intro x hx
    rw [uIcc_of_le hδ1] at hx
    exact ne_of_gt (hδ0.trans_le hx.1)
  have hid : IntervalIntegrable (fun x : ℝ => x) volume δ 1 :=
    continuous_id.intervalIntegrable δ 1
  have htrans := intervalIntegral.integral_comp_add_right
    (f := pCutoff c) (a := δ) (b := 1) c
  calc
    (∫ t in c + δ..c + 1, pCutoff c t) =
        ∫ t in δ + c..1 + c, pCutoff c t := by
          congr 1 <;> ring
    _ = ∫ x in δ..1, pCutoff c (x + c) := htrans.symm
    _ = ∫ x in δ..1, (1 / x - x) := by
      apply intervalIntegral.integral_congr
      intro x hx
      rw [uIcc_of_le hδ1] at hx
      change pCutoff c (x + c) = 1 / x - x
      rw [show x + c = c + x by ring,
        pCutoff_formula (c := c) (t := c + x) (by linarith [hδ0, hx.1])]
      · congr 2 <;> ring
      · rw [show c + x - c = x by ring, abs_of_pos (hδ0.trans_le hx.1)]
        exact hx.2
    _ = (∫ x in δ..1, 1 / x) - ∫ x in δ..1, x :=
      intervalIntegral.integral_sub hinv hid
    _ = Real.log (1 / δ) - (1 ^ 2 - δ ^ 2) / 2 := by
      rw [integral_one_div_of_pos hδ0 zero_lt_one, integral_id]
    _ = -Real.log δ + (δ ^ 2 - 1) / 2 := by
      rw [Real.log_div (by norm_num) hδ0.ne', Real.log_one]
      ring

private lemma pCutoff_neg_symm (c t : ℝ) : pCutoff c (2 * c - t) = -pCutoff c t := by
  simp only [pCutoff]
  have hm : 2 * c - t - c = -(t - c) := by ring
  have hp : t - c = t - c := rfl
  rw [hm, hp]
  by_cases hx : t - c = 0
  · simp [hx]
  · rw [if_neg (neg_ne_zero.mpr hx), if_neg hx]
    simp only [cutoff]
    rw [neg_sq]
    field_simp

private lemma pCutoff_left_integral {c δ : ℝ} (hδ0 : 0 < δ) (hδ1 : δ ≤ 1) :
    (∫ t in c - 1..c - δ, pCutoff c t) =
      Real.log δ + (1 - δ ^ 2) / 2 := by
  have hright := pCutoff_right_integral (c := c) hδ0 hδ1
  have hreflect := intervalIntegral.integral_comp_sub_left
    (f := pCutoff c) (a := c + δ) (b := c + 1) (2 * c)
  have heq : (∫ x in c + δ..c + 1, pCutoff c (2 * c - x)) =
      ∫ x in c + δ..c + 1, -pCutoff c x := by
    apply intervalIntegral.integral_congr
    intro x _
    exact pCutoff_neg_symm c x
  rw [heq, intervalIntegral.integral_neg] at hreflect
  have he₁ : 2 * c - (c + 1) = c - 1 := by ring
  have he₂ : 2 * c - (c + δ) = c - δ := by ring
  rw [he₁, he₂] at hreflect
  have hleft : (∫ t in c - 1..c - δ, pCutoff c t) =
      -(∫ t in c + δ..c + 1, pCutoff c t) := by
    exact hreflect.symm
  rw [hleft, hright]
  ring

/- IMP-R04: symmetric principal-value cancellation is exact, while T01
rejects the two one-sided logarithmic divergences. -/
theorem principalValueCutoff_rejected (c : ℝ) :
    Tendsto (fun δ =>
        (∫ t in c - 1..c - δ, pCutoff c t) +
          ∫ t in c + δ..c + 1, pCutoff c t)
      (nhdsWithin 0 (Ioi 0)) (nhds 0) ∧
      ∀ I : ℝ, ¬ HasImproperIntegralAtTopExcept (pCutoff c) (c - 2) {c} I := by
  constructor
  · apply tendsto_const_nhds.congr'
    filter_upwards [eventually_mem_nhdsWithin,
      eventually_nhdsWithin_of_eventually_nhds (Iic_mem_nhds zero_lt_one)] with δ hδ hδ1
    change 0 < δ at hδ
    rw [pCutoff_left_integral hδ hδ1, pCutoff_right_integral hδ hδ1]
    ring
  · intro I hI
    rcases hasImproperIntegralAtTopExcept_iff_exists_primitive.mp hI with
      ⟨F, hF, _⟩
    have hcmem : c ∈ Ici (c - 2) := by
      change c - 2 ≤ c
      linarith
    have hFc : ContinuousAt F c :=
      (hF.2.1 c hcmem).continuousAt
        (Ici_mem_nhds (by linarith : c - 2 < c))
    have hmap : Tendsto (fun δ : ℝ => c - δ) (nhdsWithin 0 (Ioi 0)) (nhds c) := by
      have hcst : Tendsto (fun _ : ℝ => c) (nhdsWithin 0 (Ioi 0)) (nhds c) :=
        tendsto_const_nhds
      have hid : Tendsto (fun δ : ℝ => δ) (nhdsWithin 0 (Ioi 0)) (nhds 0) :=
        tendsto_id.mono_left nhdsWithin_le_nhds
      simpa using hcst.sub hid
    have hfinite : Tendsto (fun δ => ∫ t in c - 1..c - δ, pCutoff c t)
        (nhdsWithin 0 (Ioi 0)) (nhds (F c - F (c - 1))) := by
      have hlim := (hFc.tendsto.comp hmap).sub_const (F (c - 1))
      apply hlim.congr'
      filter_upwards [eventually_mem_nhdsWithin,
        eventually_nhdsWithin_of_eventually_nhds (Iic_mem_nhds zero_lt_one)] with δ hδ hδ1
      change 0 < δ at hδ
      let bδ : ℝ := c - δ
      have hinc := (hF.2.2.2
        (by linarith : c - 2 ≤ c - 1) (by dsimp [bδ]; linarith : c - 1 ≤ bδ) (by
          apply Set.disjoint_left.2
          intro x hx hxc
          simp only [Finset.coe_singleton, mem_singleton_iff] at hxc
          subst x
          dsimp [bδ] at hx
          linarith [hx.2])).2
      simpa [bδ] using hinc
    have hpert : Tendsto (fun δ : ℝ => (1 - δ ^ 2) / 2)
        (nhdsWithin 0 (Ioi 0)) (nhds ((1 : ℝ) / 2)) := by
      have h : ContinuousAt (fun δ : ℝ => (1 - δ ^ 2) / 2) 0 := by fun_prop
      simpa using h.tendsto.mono_left nhdsWithin_le_nhds
    have hbotFormula : Tendsto (fun δ => Real.log δ + (1 - δ ^ 2) / 2)
        (nhdsWithin 0 (Ioi 0)) atBot :=
      Real.tendsto_log_nhdsGT_zero.atBot_add hpert
    have hbot : Tendsto (fun δ => ∫ t in c - 1..c - δ, pCutoff c t)
        (nhdsWithin 0 (Ioi 0)) atBot := by
      apply hbotFormula.congr'
      filter_upwards [eventually_mem_nhdsWithin,
        eventually_nhdsWithin_of_eventually_nhds (Iic_mem_nhds zero_lt_one)] with δ hδ hδ1
      change 0 < δ at hδ
      exact (pCutoff_left_integral hδ hδ1).symm
    exact not_tendsto_nhds_of_tendsto_atBot hbot _ hfinite

private lemma qCutoff_translate (c x : ℝ) : qCutoff c (c + x) = qCutoff 0 x := by
  simp only [qCutoff]
  have hsub : c + x - c = x := by ring
  rw [hsub, sub_zero]

private lemma qCutoff_zero_integrableOn_Ioi {r : ℝ} (hr : 0 < r) :
    IntegrableOn (qCutoff 0) (Ioi r) := by
  by_cases hr1 : r ≤ 1
  · have hcompactII : IntervalIntegrable (qCutoff 0) volume r 1 := by
      apply ContinuousOn.intervalIntegrable
      apply qCutoff_zero_continuousOn_pos.mono
      rw [uIcc_of_le hr1]
      intro x hx
      exact hr.trans_le hx.1
    have hcompact : IntegrableOn (qCutoff 0) (Ioc r 1) := by
      rwa [← intervalIntegrable_iff_integrableOn_Ioc_of_le hr1]
    have hzero : IntegrableOn (qCutoff 0) (Ioi 1) := by
      apply (integrableOn_zero (s := Ioi 1)).congr_fun
      · intro x hx
        change 1 < x at hx
        rw [qCutoff, sub_zero, if_neg (ne_of_gt (zero_lt_one.trans hx)), cutoff_eq_zero]
        · simp
        · simpa [abs_of_pos (zero_lt_one.trans hx)] using hx.le
      · exact measurableSet_Ioi
    have hunion := hcompact.union hzero
    rwa [Ioc_union_Ioi_eq_Ioi hr1] at hunion
  · have h1r : 1 < r := lt_of_not_ge hr1
    apply (integrableOn_zero (s := Ioi r)).congr_fun
    · intro x hx
      change r < x at hx
      have hx0 : 0 < x := hr.trans hx
      rw [qCutoff, sub_zero, if_neg hx0.ne', cutoff_eq_zero]
      · simp
      · simpa [abs_of_pos hx0] using (h1r.trans hx).le
    · exact measurableSet_Ioi

private lemma qCutoff_zero_not_integrableOn_Ioc {r : ℝ} (hr : 0 < r) :
    ¬ IntegrableOn (qCutoff 0) (Ioc 0 r) := by
  intro hlocal
  apply qCutoff_zero_not_integrableOn_Ioi_zero
  have hunion := hlocal.union (qCutoff_zero_integrableOn_Ioi hr)
  rwa [Ioc_union_Ioi_eq_Ioi hr.le] at hunion

private lemma qCutoff_not_integrableOn_Ioc_right (c : ℝ) {r : ℝ} (hr : 0 < r) :
    ¬ IntegrableOn (qCutoff c) (Ioc c (c + r)) := by
  intro hlocal
  have hII : IntervalIntegrable (qCutoff c) volume c (c + r) := by
    rwa [intervalIntegrable_iff_integrableOn_Ioc_of_le (by linarith)]
  have hcomp : IntervalIntegrable (fun t => qCutoff 0 (t - c)) volume c (c + r) := by
    apply hII.congr
    intro t _
    calc
      qCutoff c t = qCutoff c (c + (t - c)) := by congr 2; ring
      _ = qCutoff 0 (t - c) := qCutoff_translate c (t - c)
  have hzeroII : IntervalIntegrable (qCutoff 0) volume 0 r := by
    have hiff := IntervalIntegrable.comp_sub_right_iff
      (f := qCutoff 0) (a := 0) (b := r) (c := c)
    apply hiff.mp
    simpa [add_comm] using hcomp
  apply qCutoff_zero_not_integrableOn_Ioc hr
  rwa [← intervalIntegrable_iff_integrableOn_Ioc_of_le hr.le]

private lemma qCutoff_not_integrableOn_neighborhood (c : ℝ) {η : ℝ} (hη : 0 < η) :
    ¬ IntegrableOn (qCutoff c) (Ioo (c - η) (c + η)) := by
  intro hlocal
  have hr : 0 < η / 2 := half_pos hη
  apply qCutoff_not_integrableOn_Ioc_right c hr
  apply hlocal.mono_set
  intro x hx
  constructor <;> linarith [hx.1, hx.2]

private lemma cutoff_neg (x : ℝ) : cutoff (-x) = cutoff x := by
  simp [cutoff]

private lemma qCutoff_zero_even (x : ℝ) : qCutoff 0 (-x) = qCutoff 0 x := by
  by_cases hx : x = 0
  · subst x
    simp [qCutoff]
  · rw [qCutoff, qCutoff, if_neg (by simp [hx]), if_neg (by simp [hx])]
    simp only [sub_zero, cutoff_neg, inv_neg, Real.sin_neg]
    field_simp

private lemma qCutoff_reflect (c t : ℝ) : qCutoff c t = qCutoff 0 (c - t) := by
  calc
    qCutoff c t = qCutoff 0 (t - c) := by
      have ht : t = c + (t - c) := by ring
      conv_lhs => rw [ht, qCutoff_translate]
    _ = qCutoff 0 (-(t - c)) := (qCutoff_zero_even (t - c)).symm
    _ = qCutoff 0 (c - t) := by congr 2; ring

private lemma qCutoff_right_substitution {c δ : ℝ} (hδ0 : 0 < δ) (hδ1 : δ < 1) :
    (∫ t in c + δ..c + 1, qCutoff c t) =
      ∫ x in δ..1, qCutoff 0 x := by
  have hle : c + δ ≤ c + 1 := by linarith
  have hderiv : ∀ t ∈ [[c + δ, c + 1]],
      HasDerivAt (fun y : ℝ => y - c) 1 t := by
    intro t _
    simpa using (hasDerivAt_id t).sub_const c
  have houter : ContinuousOn (qCutoff 0)
      ((fun y : ℝ => y - c) '' [[c + δ, c + 1]]) := by
    apply qCutoff_zero_continuousOn_pos.mono
    rintro _ ⟨t, ht, rfl⟩
    rw [uIcc_of_le hle] at ht
    change 0 < t - c
    linarith [ht.1]
  have hsubst := intervalIntegral.integral_comp_mul_deriv'
    (a := c + δ) (b := c + 1) (f := fun y : ℝ => y - c)
    (f' := fun _ => 1) (g := qCutoff 0) hderiv continuousOn_const houter
  have heq : (∫ t in c + δ..c + 1,
      (qCutoff 0 ∘ fun y : ℝ => y - c) t * 1) =
        ∫ t in c + δ..c + 1, qCutoff c t := by
    apply intervalIntegral.integral_congr
    intro t _
    simp only [Function.comp_apply, mul_one]
    have ht : t = c + (t - c) := by ring
    conv_rhs => rw [ht, qCutoff_translate]
  rw [← heq]
  have hδsub : c + δ - c = δ := by ring
  have h1sub : c + 1 - c = 1 := by ring
  simpa only [hδsub, h1sub] using hsubst

private lemma qCutoff_left_substitution {c δ : ℝ} (hδ0 : 0 < δ) (hδ1 : δ < 1) :
    (∫ t in c - 1..c - δ, qCutoff c t) =
      ∫ x in δ..1, qCutoff 0 x := by
  have hle : c - 1 ≤ c - δ := by linarith
  have hderiv : ∀ t ∈ [[c - 1, c - δ]],
      HasDerivAt (fun y : ℝ => c - y) (-1) t := by
    intro t _
    simpa using (hasDerivAt_id t).const_sub c
  have houter : ContinuousOn (qCutoff 0)
      ((fun y : ℝ => c - y) '' [[c - 1, c - δ]]) := by
    apply qCutoff_zero_continuousOn_pos.mono
    rintro _ ⟨t, ht, rfl⟩
    rw [uIcc_of_le hle] at ht
    change 0 < c - t
    linarith [ht.2]
  have hsubst := intervalIntegral.integral_comp_mul_deriv'
    (a := c - 1) (b := c - δ) (f := fun y : ℝ => c - y)
    (f' := fun _ => -1) (g := qCutoff 0) hderiv continuousOn_const houter
  have heq : (∫ t in c - 1..c - δ,
      (qCutoff 0 ∘ fun y : ℝ => c - y) t * (-1)) =
        -(∫ t in c - 1..c - δ, qCutoff c t) := by
    rw [← intervalIntegral.integral_neg]
    apply intervalIntegral.integral_congr
    intro t _
    simp only [Function.comp_apply]
    rw [qCutoff_reflect c t]
    ring
  have hs : -(∫ t in c - 1..c - δ, qCutoff c t) =
      ∫ x in (1 : ℝ)..δ, qCutoff 0 x := by
    rw [← heq]
    simpa using hsubst
  calc
    (∫ t in c - 1..c - δ, qCutoff c t) =
        -(-(∫ t in c - 1..c - δ, qCutoff c t)) := by ring
    _ = -(∫ x in (1 : ℝ)..δ, qCutoff 0 x) := by rw [hs]
    _ = ∫ x in δ..1, qCutoff 0 x := by
      have hsym := intervalIntegral.integral_symm
        (f := qCutoff 0) (μ := volume) δ 1
      linarith

private lemma exists_qCutoff_side_limits (c : ℝ) :
    ∃ LQ : ℝ,
      Tendsto (fun δ => ∫ t in c - 1..c - δ, qCutoff c t)
          (nhdsWithin 0 (Ioi 0)) (nhds LQ) ∧
        Tendsto (fun δ => ∫ t in c + δ..c + 1, qCutoff c t)
          (nhdsWithin 0 (Ioi 0)) (nhds LQ) := by
  rcases exists_cutoffTail_limit with ⟨LQ, hLQ⟩
  refine ⟨LQ, ?_, ?_⟩
  · have hcomp := hLQ.comp tendsto_inv_nhdsGT_zero
    apply hcomp.congr'
    filter_upwards [eventually_mem_nhdsWithin,
      eventually_nhdsWithin_of_eventually_nhds (Iio_mem_nhds zero_lt_one)] with δ hδ0 hδ1
    exact ((qCutoff_left_substitution (c := c) hδ0 hδ1).trans
      (qCutoff_zero_right_substitution hδ0 hδ1)).symm
  · have hcomp := hLQ.comp tendsto_inv_nhdsGT_zero
    apply hcomp.congr'
    filter_upwards [eventually_mem_nhdsWithin,
      eventually_nhdsWithin_of_eventually_nhds (Iio_mem_nhds zero_lt_one)] with δ hδ0 hδ1
    exact ((qCutoff_right_substitution (c := c) hδ0 hδ1).trans
      (qCutoff_zero_right_substitution hδ0 hδ1)).symm

private lemma qCutoff_left_primitive_continuousOn (c : ℝ) :
    ContinuousOn (fun t => ∫ v in c - 1..t, qCutoff c v) (Iio c) := by
  intro x hx
  change x < c at hx
  let lo := min (c - 1) (x - 1)
  let hi := max (c - 1) ((x + c) / 2)
  have hlo : lo < x := (min_le_right _ _).trans_lt (by linarith)
  have hhi : x < hi := (by linarith : x < (x + c) / 2) |>.trans_le (le_max_right _ _)
  have hic : hi < c := (max_lt_iff).2 ⟨by linarith, by linarith⟩
  have hlohi : lo ≤ hi := hlo.le.trans hhi.le
  have hcnot : c ∉ [[lo, hi]] := by
    rw [uIcc_of_le hlohi]
    intro hc
    linarith [hc.2]
  have hInt := qCutoff_intervalIntegrable_of_not_mem_uIcc hcnot
  have hanchor : c - 1 ∈ [[lo, hi]] := by
    rw [uIcc_of_le hlohi]
    constructor
    · exact min_le_left _ _
    · exact le_max_left _ _
  have hcont := intervalIntegral.continuousOn_primitive_interval' hInt hanchor
  have hxmem : x ∈ [[lo, hi]] := by
    rw [uIcc_of_le hlohi]
    exact ⟨hlo.le, hhi.le⟩
  apply (hcont x hxmem).mono_of_mem_nhdsWithin
  filter_upwards [eventually_nhdsWithin_of_eventually_nhds
    (mem_of_superset (Ioo_mem_nhds hlo hhi) Ioo_subset_Icc_self)] with y hy
  simpa [uIcc_of_le hlohi] using hy

private lemma qCutoff_right_primitive_continuousOn (c LQ : ℝ) :
    ContinuousOn (fun t => 2 * LQ - ∫ v in t..c + 1, qCutoff c v) (Ioi c) := by
  intro x hx
  change c < x at hx
  let lo := min (c + 1) ((x + c) / 2)
  let hi := max (c + 1) (x + 1)
  have hclo : c < lo := (lt_min_iff).2 ⟨by linarith, by linarith⟩
  have hlo : lo < x := (min_lt_iff).2 (Or.inr (by linarith))
  have hhi : x < hi := lt_of_lt_of_le (by linarith : x < x + 1) (le_max_right _ _)
  have hlohi : lo ≤ hi := hlo.le.trans hhi.le
  have hcnot : c ∉ [[lo, hi]] := by
    rw [uIcc_of_le hlohi]
    intro hc
    linarith [hc.1]
  have hInt := qCutoff_intervalIntegrable_of_not_mem_uIcc hcnot
  have hanchor : c + 1 ∈ [[lo, hi]] := by
    rw [uIcc_of_le hlohi]
    exact ⟨min_le_left _ _, le_max_left _ _⟩
  have hbase := intervalIntegral.continuousOn_primitive_interval' hInt hanchor
  have hcont : ContinuousOn (fun t => ∫ v in t..c + 1, qCutoff c v) [[lo, hi]] := by
    have heq : (fun t => ∫ v in t..c + 1, qCutoff c v) =
        fun t => -(∫ v in c + 1..t, qCutoff c v) := by
      funext t
      exact intervalIntegral.integral_symm _ _
    rw [heq]
    exact hbase.neg
  have hxmem : x ∈ [[lo, hi]] := by
    rw [uIcc_of_le hlohi]
    exact ⟨hlo.le, hhi.le⟩
  have hcst : ContinuousOn (fun _ : ℝ => 2 * LQ) [[lo, hi]] := continuous_const.continuousOn
  have hxcont := (hcst.sub hcont) x hxmem
  apply hxcont.mono_of_mem_nhdsWithin
  filter_upwards [eventually_nhdsWithin_of_eventually_nhds
    (mem_of_superset (Ioo_mem_nhds hlo hhi) Ioo_subset_Icc_self)] with y hy
  simpa [uIcc_of_le hlohi] using hy

private lemma finiteCutoffPrimitive_continuous (c LQ : ℝ)
    (hleft : Tendsto (fun δ => ∫ t in c - 1..c - δ, qCutoff c t)
      (nhdsWithin 0 (Ioi 0)) (nhds LQ))
    (hright : Tendsto (fun δ => ∫ t in c + δ..c + 1, qCutoff c t)
      (nhdsWithin 0 (Ioi 0)) (nhds LQ)) :
    Continuous (finiteCutoffPrimitive c LQ) := by
  apply continuous_iff_continuousAt.mpr
  intro x
  by_cases hxc : x < c
  · have hA := (qCutoff_left_primitive_continuousOn c x hxc).continuousAt
      (Iio_mem_nhds hxc)
    apply hA.congr_of_eventuallyEq
    filter_upwards [Iio_mem_nhds hxc] with t ht
    exact finiteCutoffPrimitive_left ht
  by_cases hcx : c < x
  · have hB := (qCutoff_right_primitive_continuousOn c LQ x hcx).continuousAt
      (Ioi_mem_nhds hcx)
    apply hB.congr_of_eventuallyEq
    filter_upwards [Ioi_mem_nhds hcx] with t ht
    exact finiteCutoffPrimitive_right ht
  have hxcEq : x = c := by linarith
  subst x
  rw [continuousAt_iff_continuous_left'_right']
  constructor
  · rw [ContinuousWithinAt, finiteCutoffPrimitive_center]
    have hmap : Tendsto (fun t : ℝ => c - t)
        (nhdsWithin c (Iio c)) (nhdsWithin 0 (Ioi 0)) := by
      apply tendsto_nhdsWithin_iff.mpr
      constructor
      · have hcst : Tendsto (fun _ : ℝ => c) (nhdsWithin c (Iio c)) (nhds c) :=
          tendsto_const_nhds
        have hid : Tendsto (fun t : ℝ => t) (nhdsWithin c (Iio c)) (nhds c) :=
          tendsto_id.mono_left nhdsWithin_le_nhds
        simpa using hcst.sub hid
      · filter_upwards [eventually_mem_nhdsWithin] with t ht
        change t < c at ht
        change 0 < c - t
        linarith
    have hlim := hleft.comp hmap
    apply hlim.congr'
    filter_upwards [eventually_mem_nhdsWithin] with t ht
    change t < c at ht
    simpa [Function.comp_def] using
      (finiteCutoffPrimitive_left (LQ := LQ) ht).symm
  · rw [ContinuousWithinAt, finiteCutoffPrimitive_center]
    have hmap : Tendsto (fun t : ℝ => t - c)
        (nhdsWithin c (Ioi c)) (nhdsWithin 0 (Ioi 0)) := by
      apply tendsto_nhdsWithin_iff.mpr
      constructor
      · have hid : Tendsto (fun t : ℝ => t) (nhdsWithin c (Ioi c)) (nhds c) :=
          tendsto_id.mono_left nhdsWithin_le_nhds
        have hcst : Tendsto (fun _ : ℝ => c) (nhdsWithin c (Ioi c)) (nhds c) :=
          tendsto_const_nhds
        simpa using hid.sub hcst
      · filter_upwards [eventually_mem_nhdsWithin] with t ht
        change c < t at ht
        change 0 < t - c
        linarith
    have hcst : Tendsto (fun _ : ℝ => 2 * LQ) (nhdsWithin c (Ioi c))
        (nhds (2 * LQ)) := tendsto_const_nhds
    have hlim := hcst.sub (hright.comp hmap)
    have hlim' : Tendsto (fun t => 2 * LQ -
        ((fun δ => ∫ t in c + δ..c + 1, qCutoff c t) ∘ fun t => t - c) t)
        (nhdsWithin c (Ioi c)) (nhds LQ) := by
      simpa only [two_mul, add_sub_cancel_right] using hlim
    apply hlim'.congr'
    filter_upwards [eventually_mem_nhdsWithin] with t ht
    change c < t at ht
    simpa [Function.comp_def] using
      (finiteCutoffPrimitive_right (LQ := LQ) ht).symm

private lemma finiteCutoffPrimitive_isPrimitive (c LQ : ℝ)
    (hleft : Tendsto (fun δ => ∫ t in c - 1..c - δ, qCutoff c t)
      (nhdsWithin 0 (Ioi 0)) (nhds LQ))
    (hright : Tendsto (fun δ => ∫ t in c + δ..c + 1, qCutoff c t)
      (nhdsWithin 0 (Ioi 0)) (nhds LQ)) :
    IsFiniteExceptionalPrimitive (qCutoff c) (c - 2) {c}
      (finiteCutoffPrimitive c LQ) := by
  refine ⟨by simp, (finiteCutoffPrimitive_continuous c LQ hleft hright).continuousOn,
    ?_, ?_⟩
  · rw [finiteCutoffPrimitive, if_pos (by linarith : c - 2 ≤ c - 1)]
  · intro a b hka hab hdis
    have hcnot : c ∉ Icc a b := by
      intro hc
      exact Set.disjoint_left.1 hdis hc (by simp)
    have hcnotU : c ∉ [[a, b]] := by simpa [uIcc_of_le hab] using hcnot
    have habInt := qCutoff_intervalIntegrable_of_not_mem_uIcc hcnotU
    refine ⟨habInt, ?_⟩
    by_cases hbc : b < c
    · rw [finiteCutoffPrimitive_left hbc,
        finiteCutoffPrimitive_left (hab.trans_lt hbc)]
      have hca : IntervalIntegrable (qCutoff c) volume (c - 1) a := by
        apply qCutoff_intervalIntegrable_of_not_mem_uIcc
        intro hc
        rw [uIcc] at hc
        have hmax : max (c - 1) a < c := (max_lt_iff).2 ⟨by linarith, by linarith⟩
        linarith [hc.2]
      have hadd := intervalIntegral.integral_add_adjacent_intervals hca habInt
      linarith
    · have hca : c < a := by
        by_contra hnca
        apply hcnot
        exact ⟨le_of_not_gt hnca, le_of_not_gt hbc⟩
      rw [finiteCutoffPrimitive_right hca,
        finiteCutoffPrimitive_right (hca.trans_le hab)]
      have hbt : IntervalIntegrable (qCutoff c) volume b (c + 1) := by
        apply qCutoff_intervalIntegrable_of_not_mem_uIcc
        intro hc
        rw [uIcc] at hc
        have hmin : c < min b (c + 1) := (lt_min_iff).2 ⟨by linarith, by linarith⟩
        linarith [hc.1]
      have hadd := intervalIntegral.integral_add_adjacent_intervals habInt hbt
      linarith

private lemma finiteCutoffPrimitive_tendsto (c LQ : ℝ) :
    Tendsto (finiteCutoffPrimitive c LQ) atTop (nhds (2 * LQ)) := by
  apply tendsto_const_nhds.congr'
  filter_upwards [eventually_ge_atTop (c + 1)] with t ht
  simp [finiteCutoffPrimitive, (by linarith : ¬t ≤ c - 1),
    (by linarith : ¬t < c), (by linarith : t ≠ c), (by linarith : ¬t < c + 1)]

/- IMP-R05: the oscillatory cutoff has two independent finite sides, the
exact explicit T05 primitive, T01 value `2 * LQ`, and no local L¹
neighborhood across the marked point. -/
theorem conditionalFiniteCutoff (c : ℝ) :
    ∃ LQ : ℝ,
      Tendsto (fun δ => ∫ t in c - 1..c - δ, qCutoff c t)
          (nhdsWithin 0 (Ioi 0)) (nhds LQ) ∧
        Tendsto (fun δ => ∫ t in c + δ..c + 1, qCutoff c t)
          (nhdsWithin 0 (Ioi 0)) (nhds LQ) ∧
        IsFiniteExceptionalPrimitive (qCutoff c) (c - 2) {c}
          (finiteCutoffPrimitive c LQ) ∧
        Tendsto (finiteCutoffPrimitive c LQ) atTop (nhds (2 * LQ)) ∧
        HasImproperIntegralAtTopExcept (qCutoff c) (c - 2) {c} (2 * LQ) ∧
        ∀ η : ℝ, 0 < η →
          ¬ IntegrableOn (qCutoff c) (Ioo (c - η) (c + η)) := by
  rcases exists_qCutoff_side_limits c with ⟨LQ, hleft, hright⟩
  have hP := finiteCutoffPrimitive_isPrimitive c LQ hleft hright
  have hLim := finiteCutoffPrimitive_tendsto c LQ
  refine ⟨LQ, hleft, hright, hP, hLim, ?_, ?_⟩
  · exact hasImproperIntegralAtTopExcept_iff_exists_primitive.mpr
      ⟨finiteCutoffPrimitive c LQ, hP, hLim⟩
  · intro η hη
    exact qCutoff_not_integrableOn_neighborhood c hη

private lemma sinDivTail_eq {t : ℝ} (ht : 1 ≤ t) :
    sinDivTail t = dirichletIntegrand t := by
  simp [sinDivTail, dirichletIntegrand, ht]

/-- IMP-R06: conditional convergence at infinity is accepted by T01 without
whole-ray Bochner integrability. -/
theorem sinDivTail_conditional :
    ∃ LD : ℝ,
      HasImproperIntegralAtTopExcept sinDivTail 1 ∅ LD ∧
        ¬ IntegrableOn sinDivTail (Ioi 1) := by
  rcases exists_dirichlet_limit with ⟨LD, hLD⟩
  refine ⟨LD, ?_, ?_⟩
  · apply IMP001Regressions.r02_empty_exceptional_set_iff.mpr
    constructor
    · intro b h1b
      apply (dirichlet_intervalIntegrable le_rfl h1b).congr
      intro t ht
      rw [uIoc_of_le h1b] at ht
      exact (sinDivTail_eq ht.1.le).symm
    · apply hLD.congr'
      filter_upwards [eventually_ge_atTop (1 : ℝ)] with b h1b
      apply intervalIntegral.integral_congr
      intro t ht
      rw [uIcc_of_le h1b] at ht
      exact (sinDivTail_eq ht.1).symm
  · intro hInt
    apply dirichlet_not_integrableOn_Ioi
    apply hInt.congr_fun_ae
    apply (ae_restrict_iff' measurableSet_Ioi).2
    filter_upwards with t
    intro ht
    exact sinDivTail_eq ht.le

private lemma initialConditional_eq {k t : ℝ} (ht : k < t) :
    initialConditional k t = qCutoff k t := by
  simp [initialConditional, ht]

private lemma initialConditional_not_intervalIntegrable (k : ℝ) :
    ¬ IntervalIntegrable (initialConditional k) volume k (k + 1) := by
  intro hInt
  apply qCutoff_not_integrableOn_Ioc_right k zero_lt_one
  rw [← intervalIntegrable_iff_integrableOn_Ioc_of_le (by linarith)]
  apply hInt.congr
  intro t ht
  rw [uIoc_of_le (by linarith : k ≤ k + 1)] at ht
  exact initialConditional_eq ht.1

private lemma initialConditional_not_integrableOn_Ioi (k : ℝ) :
    ¬ IntegrableOn (initialConditional k) (Ioi k) := by
  intro hInt
  have hlocal := hInt.mono_set (show Ioc k (k + 1) ⊆ Ioi k by
    intro t ht
    exact ht.1)
  have hII : IntervalIntegrable (initialConditional k) volume k (k + 1) := by
    rwa [intervalIntegrable_iff_integrableOn_Ioc_of_le (by linarith)]
  exact initialConditional_not_intervalIntegrable k hII

/- IMP-R22-negative: a finite conditional right-endpoint value neither gives
local Bochner integrability nor satisfies the empty-exceptional-set relation. -/
theorem initialEndpoint_nonL1_example (k : ℝ) :
    ∃ LQ : ℝ,
      Tendsto (fun δ => ∫ t in k + δ..k + 1, initialConditional k t)
          (nhdsWithin 0 (Ioi 0)) (nhds LQ) ∧
        ¬ IntervalIntegrable (initialConditional k) volume k (k + 1) ∧
        ¬ IntegrableOn (initialConditional k) (Ioi k) ∧
        ∀ I : ℝ,
          ¬ HasImproperIntegralAtTopExcept (initialConditional k) k ∅ I := by
  rcases exists_qCutoff_side_limits k with ⟨LQ, _, hright⟩
  refine ⟨LQ, ?_, initialConditional_not_intervalIntegrable k,
    initialConditional_not_integrableOn_Ioi k, ?_⟩
  · apply hright.congr'
    filter_upwards [eventually_mem_nhdsWithin,
      eventually_nhdsWithin_of_eventually_nhds (Iio_mem_nhds zero_lt_one)] with δ hδ hδ1
    change 0 < δ at hδ
    apply intervalIntegral.integral_congr
    intro t ht
    rw [uIcc_of_le (by linarith : k + δ ≤ k + 1)] at ht
    exact (initialConditional_eq (by linarith [ht.1])).symm
  · intro I hI
    have hregular :=
      (IMP001Regressions.r02_empty_exceptional_set_iff.mp hI).1
        (show k ≤ k + 1 by linarith)
    exact initialConditional_not_intervalIntegrable k hregular

end LMLFTest.Integral.Improper.IMP001Oscillatory
