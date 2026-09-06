import Mathlib.Data.Finset.Sort
import Mathlib.MeasureTheory.Integral.DominatedConvergence

open Filter MeasureTheory Set
open scoped Interval

noncomputable section

namespace LMLF.Integral

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

private def HasImproperIntegralTailFromBreaks
    [CompleteSpace E] (f : ℝ → E) (c : ℝ) : List ℝ → E → Prop
  | [], I =>
      ∃ d : ℝ, ∃ L R : E, c < d ∧
        (∀ {a b : ℝ}, c < a → a ≤ b →
          IntervalIntegrable f volume a b) ∧
        Tendsto (fun a => ∫ t in a..d, f t)
          (nhdsWithin c (Ioi c)) (nhds L) ∧
        Tendsto (fun b => ∫ t in d..b, f t) atTop (nhds R) ∧
        I = L + R
  | d :: ds, I =>
      ∃ p : ℝ, ∃ L R J : E, c < p ∧ p < d ∧
        (∀ {a b : ℝ}, c < a → a ≤ b → b < d →
          IntervalIntegrable f volume a b) ∧
        Tendsto (fun a => ∫ t in a..p, f t)
          (nhdsWithin c (Ioi c)) (nhds L) ∧
        Tendsto (fun b => ∫ t in p..b, f t)
          (nhdsWithin d (Iio d)) (nhds R) ∧
        HasImproperIntegralTailFromBreaks f d ds J ∧
        I = L + R + J

private def HasImproperIntegralAtTopBreaks
    [CompleteSpace E] (f : ℝ → E) (k : ℝ) : List ℝ → E → Prop
  | [], I =>
      (∀ {b : ℝ}, k ≤ b → IntervalIntegrable f volume k b) ∧
      Tendsto (fun b => ∫ t in k..b, f t) atTop (nhds I)
  | c :: cs, I =>
      ∃ L J : E, k < c ∧
        (∀ {b : ℝ}, k ≤ b → b < c →
          IntervalIntegrable f volume k b) ∧
        Tendsto (fun b => ∫ t in k..b, f t)
          (nhdsWithin c (Iio c)) (nhds L) ∧
        HasImproperIntegralTailFromBreaks f c cs J ∧
        I = L + J

/-- IMP-001-T01. -/
def HasImproperIntegralAtTopExcept
    [CompleteSpace E] (f : ℝ → E) (k : ℝ) (S : Finset ℝ) (I : E) : Prop :=
  (∀ c ∈ S, k < c) ∧
    HasImproperIntegralAtTopBreaks f k (S.sort (· ≤ ·)) I

/-- IMP-001-T05. -/
def IsFiniteExceptionalPrimitive
    [CompleteSpace E] (g : ℝ → E) (k : ℝ) (S : Finset ℝ) (F : ℝ → E) : Prop :=
  (∀ c ∈ S, k < c) ∧
    ContinuousOn F (Ici k) ∧
    F k = 0 ∧
    ∀ {a b : ℝ}, k ≤ a → a ≤ b →
      Disjoint (Icc a b) (↑S : Set ℝ) →
      IntervalIntegrable g volume a b ∧
        F b - F a = ∫ t in a..b, g t

private theorem atTopComponentValue_eq_of_anchor_le
    [CompleteSpace E] {f : ℝ → E} {c p q : ℝ} {Lp Rp Lq Rq : E}
    (hcp : c < p) (hpq : p ≤ q)
    (hInt : ∀ {a b : ℝ}, c < a → a ≤ b →
      IntervalIntegrable f volume a b)
    (hpL : Tendsto (fun a => ∫ t in a..p, f t)
      (nhdsWithin c (Ioi c)) (nhds Lp))
    (hpR : Tendsto (fun b => ∫ t in p..b, f t) atTop (nhds Rp))
    (hqL : Tendsto (fun a => ∫ t in a..q, f t)
      (nhdsWithin c (Ioi c)) (nhds Lq))
    (hqR : Tendsto (fun b => ∫ t in q..b, f t) atTop (nhds Rq)) :
    Lp + Rp = Lq + Rq := by
  have hcq : c < q := hcp.trans_le hpq
  have hpqInt : IntervalIntegrable f volume p q := hInt hcp hpq
  have hleft :
      (∀ᶠ a in nhdsWithin c (Ioi c),
        (∫ t in a..p, f t) + ∫ t in p..q, f t = ∫ t in a..q, f t) := by
    filter_upwards [eventually_mem_nhdsWithin,
      eventually_nhdsWithin_of_eventually_nhds (Iio_mem_nhds hcp)] with a hca hap
    exact intervalIntegral.integral_add_adjacent_intervals
      (hInt hca (le_of_lt hap)) hpqInt
  have hLq : Lq = Lp + ∫ t in p..q, f t :=
    tendsto_nhds_unique hqL ((hpL.add_const (∫ t in p..q, f t)).congr' hleft)
  have hright :
      (∀ᶠ b in atTop,
        (∫ t in p..q, f t) + ∫ t in q..b, f t = ∫ t in p..b, f t) := by
    filter_upwards [eventually_ge_atTop q] with b hqb
    exact intervalIntegral.integral_add_adjacent_intervals hpqInt (hInt hcq hqb)
  have hRp : Rp = (∫ t in p..q, f t) + Rq :=
    tendsto_nhds_unique hpR
      ((hqR.const_add (∫ t in p..q, f t)).congr' hright)
  rw [hLq, hRp]
  simp only [add_assoc]

private theorem atTopComponentValue_unique
    [CompleteSpace E] {f : ℝ → E} {c p q : ℝ} {Lp Rp Lq Rq : E}
    (hcp : c < p) (hcq : c < q)
    (hInt : ∀ {a b : ℝ}, c < a → a ≤ b →
      IntervalIntegrable f volume a b)
    (hpL : Tendsto (fun a => ∫ t in a..p, f t)
      (nhdsWithin c (Ioi c)) (nhds Lp))
    (hpR : Tendsto (fun b => ∫ t in p..b, f t) atTop (nhds Rp))
    (hqL : Tendsto (fun a => ∫ t in a..q, f t)
      (nhdsWithin c (Ioi c)) (nhds Lq))
    (hqR : Tendsto (fun b => ∫ t in q..b, f t) atTop (nhds Rq)) :
    Lp + Rp = Lq + Rq := by
  rcases le_total p q with hpq | hqp
  · exact atTopComponentValue_eq_of_anchor_le hcp hpq hInt hpL hpR hqL hqR
  · exact (atTopComponentValue_eq_of_anchor_le hcq hqp hInt hqL hqR hpL hpR).symm

private theorem boundedComponentValue_eq_of_anchor_le
    [CompleteSpace E] {f : ℝ → E} {c d p q : ℝ} {Lp Rp Lq Rq : E}
    (hcp : c < p) (hpq : p ≤ q) (hqd : q < d)
    (hInt : ∀ {a b : ℝ}, c < a → a ≤ b → b < d →
      IntervalIntegrable f volume a b)
    (hpL : Tendsto (fun a => ∫ t in a..p, f t)
      (nhdsWithin c (Ioi c)) (nhds Lp))
    (hpR : Tendsto (fun b => ∫ t in p..b, f t)
      (nhdsWithin d (Iio d)) (nhds Rp))
    (hqL : Tendsto (fun a => ∫ t in a..q, f t)
      (nhdsWithin c (Ioi c)) (nhds Lq))
    (hqR : Tendsto (fun b => ∫ t in q..b, f t)
      (nhdsWithin d (Iio d)) (nhds Rq)) :
    Lp + Rp = Lq + Rq := by
  have hcq : c < q := hcp.trans_le hpq
  have hpd : p < d := lt_of_le_of_lt hpq hqd
  have hpqInt : IntervalIntegrable f volume p q := hInt hcp hpq hqd
  have hleft :
      (∀ᶠ a in nhdsWithin c (Ioi c),
        (∫ t in a..p, f t) + ∫ t in p..q, f t = ∫ t in a..q, f t) := by
    filter_upwards [eventually_mem_nhdsWithin,
      eventually_nhdsWithin_of_eventually_nhds (Iio_mem_nhds hcp)] with a hca hap
    exact intervalIntegral.integral_add_adjacent_intervals
      (hInt hca (le_of_lt hap) hpd) hpqInt
  have hLq : Lq = Lp + ∫ t in p..q, f t :=
    tendsto_nhds_unique hqL ((hpL.add_const (∫ t in p..q, f t)).congr' hleft)
  have hright :
      (∀ᶠ b in nhdsWithin d (Iio d),
        (∫ t in p..q, f t) + ∫ t in q..b, f t = ∫ t in p..b, f t) := by
    filter_upwards [eventually_mem_nhdsWithin,
      eventually_nhdsWithin_of_eventually_nhds (Ioi_mem_nhds hqd)] with b hbd hqb
    exact intervalIntegral.integral_add_adjacent_intervals hpqInt
      (hInt hcq (le_of_lt hqb) hbd)
  have hRp : Rp = (∫ t in p..q, f t) + Rq :=
    tendsto_nhds_unique hpR
      ((hqR.const_add (∫ t in p..q, f t)).congr' hright)
  rw [hLq, hRp]
  simp only [add_assoc]

private theorem boundedComponentValue_unique
    [CompleteSpace E] {f : ℝ → E} {c d p q : ℝ} {Lp Rp Lq Rq : E}
    (hcp : c < p) (hpd : p < d) (hcq : c < q) (hqd : q < d)
    (hInt : ∀ {a b : ℝ}, c < a → a ≤ b → b < d →
      IntervalIntegrable f volume a b)
    (hpL : Tendsto (fun a => ∫ t in a..p, f t)
      (nhdsWithin c (Ioi c)) (nhds Lp))
    (hpR : Tendsto (fun b => ∫ t in p..b, f t)
      (nhdsWithin d (Iio d)) (nhds Rp))
    (hqL : Tendsto (fun a => ∫ t in a..q, f t)
      (nhdsWithin c (Ioi c)) (nhds Lq))
    (hqR : Tendsto (fun b => ∫ t in q..b, f t)
      (nhdsWithin d (Iio d)) (nhds Rq)) :
    Lp + Rp = Lq + Rq := by
  rcases le_total p q with hpq | hqp
  · exact boundedComponentValue_eq_of_anchor_le
      hcp hpq hqd hInt hpL hpR hqL hqR
  · exact (boundedComponentValue_eq_of_anchor_le
      hcq hqp hpd hInt hqL hqR hpL hpR).symm

private theorem HasImproperIntegralTailFromBreaks.unique
    [CompleteSpace E] {f : ℝ → E} {c : ℝ} {breaks : List ℝ} {I J : E}
    (hI : HasImproperIntegralTailFromBreaks f c breaks I)
    (hJ : HasImproperIntegralTailFromBreaks f c breaks J) : I = J := by
  induction breaks generalizing c I J with
  | nil =>
      rcases hI with ⟨p, Lp, Rp, hcp, hInt, hpL, hpR, rfl⟩
      rcases hJ with ⟨q, Lq, Rq, hcq, _, hqL, hqR, rfl⟩
      exact atTopComponentValue_unique hcp hcq hInt hpL hpR hqL hqR
  | cons d ds ih =>
      rcases hI with ⟨p, Lp, Rp, Ip, hcp, hpd, hInt, hpL, hpR, htailI, rfl⟩
      rcases hJ with ⟨q, Lq, Rq, Iq, hcq, hqd, _, hqL, hqR, htailJ, rfl⟩
      have hcomponent : Lp + Rp = Lq + Rq :=
        boundedComponentValue_unique hcp hpd hcq hqd hInt hpL hpR hqL hqR
      have htail : Ip = Iq := ih htailI htailJ
      rw [hcomponent, htail]

private theorem HasImproperIntegralAtTopBreaks.unique
    [CompleteSpace E] {f : ℝ → E} {k : ℝ} {breaks : List ℝ} {I J : E}
    (hI : HasImproperIntegralAtTopBreaks f k breaks I)
    (hJ : HasImproperIntegralAtTopBreaks f k breaks J) : I = J := by
  induction breaks generalizing k I J with
  | nil =>
      exact tendsto_nhds_unique hI.2 hJ.2
  | cons c cs _ =>
      rcases hI with ⟨LI, II, _, _, hLI, htailI, rfl⟩
      rcases hJ with ⟨LJ, IJ, _, _, hLJ, htailJ, rfl⟩
      have hleft : LI = LJ := tendsto_nhds_unique hLI hLJ
      have htail : II = IJ := HasImproperIntegralTailFromBreaks.unique htailI htailJ
      rw [hleft, htail]

/-- IMP-001-T02. -/
theorem HasImproperIntegralAtTopExcept.unique
    [CompleteSpace E] {f : ℝ → E} {k : ℝ} {S : Finset ℝ} {I J : E}
    (hI : HasImproperIntegralAtTopExcept f k S I)
    (hJ : HasImproperIntegralAtTopExcept f k S J) : I = J :=
  HasImproperIntegralAtTopBreaks.unique hI.2 hJ.2

end LMLF.Integral
