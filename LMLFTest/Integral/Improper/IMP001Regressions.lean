import LMLF.Integral.Improper.Basic
import LMLF.Integral.Improper.Bochner
import LMLF.Integral.Improper.Abel
import Mathlib.Analysis.Complex.Basic
import Mathlib.Analysis.Normed.Operator.Mul

/-!
Non-analytic implementation regressions for IMP-001.

The analytic example and counterexample obligations requiring the separately reviewed
`NLP-IMP-001-REG` companion are intentionally absent.
-/

open Filter MeasureTheory Set
open scoped Interval

noncomputable section

namespace LMLFTest.Integral.Improper.IMP001Regressions

open LMLF.Integral

#check (@LMLF.Integral.HasImproperIntegralAtTopExcept :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E],
    (ℝ → E) → ℝ → Finset ℝ → E → Prop)

#check (@LMLF.Integral.HasImproperIntegralAtTopExcept.unique :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
    {f : ℝ → E} {k : ℝ} {S : Finset ℝ} {I J : E},
    HasImproperIntegralAtTopExcept f k S I →
      HasImproperIntegralAtTopExcept f k S J → I = J)

#check (@LMLF.Integral.HasImproperIntegralAtTopExcept.finset_clm :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {H : Type*} [NormedAddCommGroup H] [NormedSpace ℝ H]
    [CompleteSpace E] [CompleteSpace H] {A : Type*},
    (s : Finset A) → (f : A → ℝ → E) → (S : A → Finset ℝ) →
      (I : A → E) → (T : A → E →L[ℝ] H) → ∀ {k : ℝ},
        (∀ i ∈ s, HasImproperIntegralAtTopExcept (f i) k (S i) (I i)) →
          HasImproperIntegralAtTopExcept
            (fun t => ∑ i ∈ s, T i (f i t)) k
            (s.biUnion S) (∑ i ∈ s, T i (I i)))

#check (@LMLF.Integral.HasImproperIntegralAtTopExcept.split_regular :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E],
    (f : ℝ → E) → ∀ {a k : ℝ}, (S : Finset ℝ) → (I : E) →
      a ≤ k → (∀ c ∈ S, k < c) → IntervalIntegrable f volume a k →
        (HasImproperIntegralAtTopExcept f a S ((∫ t in a..k, f t) + I) ↔
          HasImproperIntegralAtTopExcept f k S I))

#check (@LMLF.Integral.IsFiniteExceptionalPrimitive :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E],
    (ℝ → E) → ℝ → Finset ℝ → (ℝ → E) → Prop)

#check (@LMLF.Integral.IsFiniteExceptionalPrimitive.hasImproperIntegralAtTopExcept_exp_smul :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
    {g F : ℝ → E} {k : ℝ} {S : Finset ℝ},
    IsFiniteExceptionalPrimitive g k S F → (h : ℝ) →
      IntegrableOn (fun t => Real.exp (-h * t) • F t) (Ioi k) →
      Tendsto (fun R => Real.exp (-h * R) • F R) atTop (nhds 0) →
        HasImproperIntegralAtTopExcept
          (fun t => Real.exp (-h * t) • g t) k S
          (h • ∫ t in Ioi k, Real.exp (-h * t) • F t))

#check (@LMLF.Integral.HasImproperIntegralAtTopExcept.of_integrableOn_Ioi :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E],
    (f : ℝ → E) → (k : ℝ) → (S : Finset ℝ) →
      (∀ c ∈ S, k < c) → IntegrableOn f (Ioi k) →
        HasImproperIntegralAtTopExcept f k S (∫ t in Ioi k, f t))

#check (@LMLF.Integral.hasImproperIntegralAtTopExcept_iff_exists_primitive :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
    {f : ℝ → E} {k : ℝ} {S : Finset ℝ} {I : E},
    HasImproperIntegralAtTopExcept f k S I ↔
      ∃ F : ℝ → E,
        IsFiniteExceptionalPrimitive f k S F ∧ Tendsto F atTop (nhds I))

variable {E H : Type*}
  [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
  [NormedAddCommGroup H] [NormedSpace ℝ H] [CompleteSpace H]

/-- IMP-R01: T01 exposes the exact above-start domain field. -/
theorem r01_t01_above_start
    {f : ℝ → E} {k : ℝ} {S : Finset ℝ} {I : E}
    (h : HasImproperIntegralAtTopExcept f k S I) :
    ∀ c ∈ S, k < c :=
  h.1

/-- IMP-R10: T05 has exactly the frozen public fields and no limit or bound. -/
theorem r10_t05_fields_iff
    {g F : ℝ → E} {k : ℝ} {S : Finset ℝ} :
    IsFiniteExceptionalPrimitive g k S F ↔
      (∀ c ∈ S, k < c) ∧
        ContinuousOn F (Ici k) ∧
        F k = 0 ∧
        ∀ {a b : ℝ}, k ≤ a → a ≤ b →
          Disjoint (Icc a b) (↑S : Set ℝ) →
          IntervalIntegrable g volume a b ∧
            F b - F a = ∫ t in a..b, g t :=
  Iff.rfl

/-- IMP-R02: the empty exceptional-set case has a concrete zero witness through
the public primitive equivalence. -/
theorem r02_empty_exceptional_set_zero {k : ℝ} :
    HasImproperIntegralAtTopExcept (fun _ : ℝ => (0 : E)) k ∅ 0 := by
  apply hasImproperIntegralAtTopExcept_iff_exists_primitive.mpr
  refine ⟨fun _ => 0, ?_, tendsto_const_nhds⟩
  refine ⟨by simp, continuous_const.continuousOn, rfl, ?_⟩
  intro a b _ _ _
  exact ⟨intervalIntegrable_const, by simp⟩

/-- IMP-R02/R07 abstract projection: an empty-set relation exposes honest
regular truncations and the direct right-endpoint limit through T08/T05. No
concrete nonintegrable example is introduced. -/
theorem r02_empty_exceptional_set_projection
    {f : ℝ → E} {k : ℝ} {I : E}
    (h : HasImproperIntegralAtTopExcept f k ∅ I) :
    (∀ {b : ℝ}, k ≤ b → IntervalIntegrable f volume k b) ∧
      Tendsto (fun b => ∫ t in k..b, f t) atTop (nhds I) := by
  rcases hasImproperIntegralAtTopExcept_iff_exists_primitive.mp h with
    ⟨F, hF, hLim⟩
  constructor
  · intro b hkb
    exact (hF.2.2.2 le_rfl hkb (by simp)).1
  · refine hLim.congr' ?_
    filter_upwards [eventually_ge_atTop k] with b hkb
    have hinc := (hF.2.2.2 le_rfl hkb (by simp)).2
    simpa [hF.2.2.1] using hinc

/-- IMP-R02: exact empty-set equivalence with honest regular truncations and
the direct atTop interval-integral limit. -/
theorem r02_empty_exceptional_set_iff
    {f : ℝ → E} {k : ℝ} {I : E} :
    HasImproperIntegralAtTopExcept f k ∅ I ↔
      ((∀ {b : ℝ}, k ≤ b → IntervalIntegrable f volume k b) ∧
        Tendsto (fun b => ∫ t in k..b, f t) atTop (nhds I)) := by
  constructor
  · exact r02_empty_exceptional_set_projection
  · rintro ⟨hInt, hLim⟩
    let P : ℝ → E := fun t => ∫ x in k..t, f x
    have hPcont : ContinuousOn P (Ici k) := by
      intro x hkx
      let b := x + 1
      have hxb : x < b := by simp [b]
      have hkb : k ≤ b := hkx.trans hxb.le
      have hlocal := intervalIntegral.continuousOn_primitive_interval'
        (a := k) (hInt hkb) (by simpa [uIcc_of_le hkb] using
          (show k ∈ Icc k b from ⟨le_rfl, hkb⟩))
      have hxlocal : ContinuousWithinAt P (Icc k b) x := by
        have hxmem : x ∈ [[k, b]] := by
          simpa [uIcc_of_le hkb] using
            (show x ∈ Icc k b from ⟨hkx, hxb.le⟩)
        simpa only [P, uIcc_of_le hkb] using hlocal x hxmem
      apply hxlocal.mono_of_mem_nhdsWithin
      have hIic : Iic b ∈ nhds x :=
        mem_of_superset (Iio_mem_nhds hxb) Iio_subset_Iic_self
      have hmem := inter_mem_nhdsWithin (Ici k) hIic
      simpa only [Ici_inter_Iic] using hmem
    have hP : IsFiniteExceptionalPrimitive f k ∅ P := by
      refine ⟨by simp, hPcont, by simp [P], ?_⟩
      intro a b hka hab _
      have hkb : k ≤ b := hka.trans hab
      have hkbInt := hInt hkb
      have hkaInt := hInt hka
      have habInt : IntervalIntegrable f volume a b := by
        apply hkbInt.mono_set
        rw [uIcc_of_le hab, uIcc_of_le hkb]
        exact Icc_subset_Icc hka le_rfl
      refine ⟨habInt, ?_⟩
      exact intervalIntegral.integral_interval_sub_left hkbInt hkaInt
    exact hasImproperIntegralAtTopExcept_iff_exists_primitive.mpr
      ⟨P, hP, hLim⟩

/-- IMP-R07 abstract projection: an empty-set relation supplies each required
honest regular truncation. -/
theorem r07_empty_set_intervalIntegrable
    {f : ℝ → E} {k b : ℝ} {I : E}
    (h : HasImproperIntegralAtTopExcept f k ∅ I) (hkb : k ≤ b) :
    IntervalIntegrable f volume k b :=
  (r02_empty_exceptional_set_iff.mp h).1 hkb

/-- IMP-R07 positive control: both exact empty-set fields construct the
relation. -/
theorem r07_empty_set_positive_control
    {f : ℝ → E} {k : ℝ} {I : E}
    (hInt : ∀ {b : ℝ}, k ≤ b → IntervalIntegrable f volume k b)
    (hLim : Tendsto (fun b => ∫ t in k..b, f t) atTop (nhds I)) :
    HasImproperIntegralAtTopExcept f k ∅ I :=
  r02_empty_exceptional_set_iff.mpr ⟨hInt, hLim⟩

/-- IMP-R03: T08 round-trips the relation for an explicit generic two-point
exceptional set without exposing component representation. -/
theorem r03_t08_two_point_set_roundtrip
    {f : ℝ → E} {k c d : ℝ} {I : E} :
    HasImproperIntegralAtTopExcept f k {c, d} I ↔
      ∃ F : ℝ → E,
        IsFiniteExceptionalPrimitive f k {c, d} F ∧
          Tendsto F atTop (nhds I) :=
  hasImproperIntegralAtTopExcept_iff_exists_primitive

private theorem singleton_clm
    {f : ℝ → E} {k : ℝ} {S : Finset ℝ} {I : E}
    (T : E →L[ℝ] H)
    (h : HasImproperIntegralAtTopExcept f k S I) :
    HasImproperIntegralAtTopExcept (fun t => T (f t)) k S (T I) := by
  simpa using HasImproperIntegralAtTopExcept.finset_clm
    ({()} : Finset Unit) (fun _ => f) (fun _ => S) (fun _ => I) (fun _ => T)
    (by simpa using h)

/-- IMP-R08: the empty finite family gives the zero relation in an arbitrary
complete output space. -/
theorem r08_empty_family {k : ℝ} :
    HasImproperIntegralAtTopExcept (fun _ : ℝ => (0 : H)) k ∅ 0 := by
  simpa using HasImproperIntegralAtTopExcept.finset_clm
    (∅ : Finset (Fin 0)) (fun _ _ => (0 : H)) (fun _ => ∅)
    (fun _ => (0 : H)) (fun _ => (0 : H →L[ℝ] H)) (by simp)

/-- IMP-R08: two relations combine on their literal union. -/
theorem r08_two_term_literal_union
    {f g : ℝ → E} {k : ℝ} {Sf Sg : Finset ℝ} {I J : E}
    (hf : HasImproperIntegralAtTopExcept f k Sf I)
    (hg : HasImproperIntegralAtTopExcept g k Sg J) :
    HasImproperIntegralAtTopExcept
      (fun t => f t + g t) k (Sf ∪ Sg) (I + J) := by
  let fs : Fin 2 → ℝ → E := ![f, g]
  let sets : Fin 2 → Finset ℝ := ![Sf, Sg]
  let vals : Fin 2 → E := ![I, J]
  let maps : Fin 2 → E →L[ℝ] E :=
    ![ContinuousLinearMap.id ℝ E, ContinuousLinearMap.id ℝ E]
  have hs : ∀ i ∈ (Finset.univ : Finset (Fin 2)),
      HasImproperIntegralAtTopExcept (fs i) k (sets i) (vals i) := by
    intro i _
    fin_cases i
    · simpa [fs, sets, vals] using hf
    · simpa [fs, sets, vals] using hg
  have hunion : (Finset.univ : Finset (Fin 2)).biUnion sets = Sf ∪ Sg := by
    ext x
    simp only [Finset.mem_biUnion, Finset.mem_univ, true_and, Finset.mem_union]
    constructor
    · rintro ⟨i, hi⟩
      fin_cases i
      · exact Or.inl (by simpa [sets] using hi)
      · exact Or.inr (by simpa [sets] using hi)
    · rintro (hx | hx)
      · exact ⟨0, by simpa [sets] using hx⟩
      · exact ⟨1, by simpa [sets] using hx⟩
  have hcomb := HasImproperIntegralAtTopExcept.finset_clm
    (Finset.univ : Finset (Fin 2)) fs sets vals maps hs
  rw [hunion] at hcomb
  simpa [fs, vals, maps, Fin.sum_univ_two] using hcomb

/-- IMP-R08: negation is a one-term continuous-real-linear specialization. -/
theorem r08_neg
    {f : ℝ → E} {k : ℝ} {S : Finset ℝ} {I : E}
    (h : HasImproperIntegralAtTopExcept f k S I) :
    HasImproperIntegralAtTopExcept (fun t => -f t) k S (-I) := by
  simpa using singleton_clm (-(ContinuousLinearMap.id ℝ E)) h

/-- IMP-R08: real scalar multiplication is a one-term CLM specialization. -/
theorem r08_real_smul (a : ℝ)
    {f : ℝ → E} {k : ℝ} {S : Finset ℝ} {I : E}
    (h : HasImproperIntegralAtTopExcept f k S I) :
    HasImproperIntegralAtTopExcept (fun t => a • f t) k S (a • I) := by
  simpa using singleton_clm (a • ContinuousLinearMap.id ℝ E) h

/-- IMP-R08: multiplication by a fixed complex coefficient is available as a
continuous real-linear specialization. -/
theorem r08_complex_mul (z : ℂ)
    {f : ℝ → ℂ} {k : ℝ} {S : Finset ℝ} {I : ℂ}
    (h : HasImproperIntegralAtTopExcept f k S I) :
    HasImproperIntegralAtTopExcept (fun t => z * f t) k S (z * I) := by
  simpa using singleton_clm (ContinuousLinearMap.mul ℝ ℂ z) h

/-- IMP-R08: the canonical real-to-complex map changes codomain. -/
theorem r08_real_to_complex
    {f : ℝ → ℝ} {k : ℝ} {S : Finset ℝ} {I : ℝ}
    (h : HasImproperIntegralAtTopExcept f k S I) :
    HasImproperIntegralAtTopExcept
      (fun t => (f t : ℂ)) k S (I : ℂ) := by
  simpa using singleton_clm Complex.ofRealCLM h

/-- IMP-R08: the real-part CLM changes codomain from complex to real. -/
theorem r08_complex_to_real
    {f : ℝ → ℂ} {k : ℝ} {S : Finset ℝ} {I : ℂ}
    (h : HasImproperIntegralAtTopExcept f k S I) :
    HasImproperIntegralAtTopExcept (fun t => (f t).re) k S I.re := by
  simpa using singleton_clm Complex.reCLM h

/-- IMP-R09: splitting at the same start is exactly the degenerate-prefix case. -/
theorem r09_split_same_start
    (f : ℝ → E) (k : ℝ) (S : Finset ℝ) (I : E)
    (hS : ∀ c ∈ S, k < c) :
    HasImproperIntegralAtTopExcept f k S ((∫ t in k..k, f t) + I) ↔
      HasImproperIntegralAtTopExcept f k S I :=
  HasImproperIntegralAtTopExcept.split_regular
    f S I le_rfl hS IntervalIntegrable.refl

/-- IMP-R09: a constant prepended interval contributes `(k - a) • v`, with
the frozen `J + I` orientation. -/
theorem r09_constant_prefix_sign
    (f : ℝ → E) (v : E) {a k : ℝ} (S : Finset ℝ) (I : E)
    (hak : a ≤ k) (hS : ∀ c ∈ S, k < c)
    (hEq : Set.EqOn f (fun _ => v) (Icc a k))
    (hInt : IntervalIntegrable f volume a k)
    (htail : HasImproperIntegralAtTopExcept f k S I) :
    HasImproperIntegralAtTopExcept
      f a S ((k - a) • v + I) := by
  have hIntegral : (∫ t in a..k, f t) = (k - a) • v := by
    rw [intervalIntegral.integral_congr (by
      intro t ht
      exact hEq (by simpa [uIcc_of_le hak] using ht))]
    exact intervalIntegral.integral_const v
  have hsplit := HasImproperIntegralAtTopExcept.split_regular
    f S I hak hS hInt
  rw [hIntegral] at hsplit
  exact hsplit.mpr htail

/-- IMP-R13 algebraic case: T06 at `h = 0` gives value zero under its exact
two tail premises. -/
theorem r13_exp_smul_h_zero
    {g F : ℝ → E} {k : ℝ} {S : Finset ℝ}
    (hF : IsFiniteExceptionalPrimitive g k S F)
    (hInt : IntegrableOn F (Ioi k))
    (hLim : Tendsto F atTop (nhds 0)) :
    HasImproperIntegralAtTopExcept g k S 0 := by
  simpa using hF.hasImproperIntegralAtTopExcept_exp_smul 0
    (by simpa using hInt) (by simpa using hLim)

private theorem primitive_congr_on_Ici
    {f F G : ℝ → E} {k : ℝ} {S : Finset ℝ}
    (hF : IsFiniteExceptionalPrimitive f k S F)
    (hFG : ∀ t, k ≤ t → G t = F t) :
    IsFiniteExceptionalPrimitive f k S G := by
  refine ⟨hF.1, hF.2.1.congr ?_, ?_, ?_⟩
  · intro t ht
    exact hFG t ht
  · rw [hFG k le_rfl]
    exact hF.2.2.1
  · intro a b hka hab hdisj
    rcases hF.2.2.2 hka hab hdisj with ⟨hInt, hinc⟩
    refine ⟨hInt, ?_⟩
    rw [hFG a hka, hFG b (hka.trans hab)]
    exact hinc

/-- IMP-R23: replacing a primitive arbitrarily below `k` preserves its use as
the existential T08 witness. -/
theorem r23_primitive_values_below_start_irrelevant
    {f F G : ℝ → E} {k : ℝ} {S : Finset ℝ} {I : E}
    (hF : IsFiniteExceptionalPrimitive f k S F)
    (hLim : Tendsto F atTop (nhds I))
    (hFG : ∀ t, k ≤ t → G t = F t) :
    HasImproperIntegralAtTopExcept f k S I := by
  apply hasImproperIntegralAtTopExcept_iff_exists_primitive.mpr
  refine ⟨G, primitive_congr_on_Ici hF hFG, ?_⟩
  exact hLim.congr' ((eventually_ge_atTop k).mono fun t ht => (hFG t ht).symm)

/-- IMP-R21 positive control: the T07 bridge applies when its exact
`IntegrableOn` premise is supplied. -/
theorem r21_integrableOn_positive_control
    (f : ℝ → E) (k : ℝ) (S : Finset ℝ)
    (hS : ∀ c ∈ S, k < c) (hInt : IntegrableOn f (Ioi k)) :
    HasImproperIntegralAtTopExcept f k S (∫ t in Ioi k, f t) :=
  HasImproperIntegralAtTopExcept.of_integrableOn_Ioi f k S hS hInt

/-- IMP-R23 positive control: T08 accepts the exact existential witness. -/
theorem r23_existential_positive_control
    {f F : ℝ → E} {k : ℝ} {S : Finset ℝ} {I : E}
    (hF : IsFiniteExceptionalPrimitive f k S F)
    (hLim : Tendsto F atTop (nhds I)) :
    HasImproperIntegralAtTopExcept f k S I :=
  hasImproperIntegralAtTopExcept_iff_exists_primitive.mpr ⟨F, hF, hLim⟩

section NegativeTypeShapeChecks

/-- IMP-R07 type-shape guard: a direct empty-set endpoint limit alone cannot
construct the relation without the regular-truncation field. -/
example {_f : ℝ → E} {_k : ℝ} {_I : E}
    (_hLim : Tendsto (fun b => ∫ t in _k..b, _f t) atTop (nhds _I)) : True := by
  fail_if_success
    have hbad : HasImproperIntegralAtTopExcept _f _k ∅ _I :=
      r02_empty_exceptional_set_iff.mpr _hLim
  trivial

/-- IMP-R10: T05 has no bounding-constant field. -/
example {f F : ℝ → E} {k : ℝ} {S : Finset ℝ}
    (_hF : IsFiniteExceptionalPrimitive f k S F) : True := by
  fail_if_success
    have hbad : ∃ L : ℝ, 0 ≤ L ∧ ∀ t, k ≤ t → ‖F t‖ ≤ L :=
      _hF.2.2.2
  trivial

/-- IMP-R23: T08 does not bundle a quantitative bound. -/
example (_f : ℝ → E) (_k : ℝ) (_S : Finset ℝ) (_I : E) : True := by
  fail_if_success
    have hbad :
      HasImproperIntegralAtTopExcept _f _k _S _I ↔
        ∃ F : ℝ → E, ∃ L : ℝ,
          IsFiniteExceptionalPrimitive _f _k _S F ∧
            Tendsto F atTop (nhds _I) ∧
              0 ≤ L ∧ ∀ t, _k ≤ t → ‖F t‖ ≤ L :=
      hasImproperIntegralAtTopExcept_iff_exists_primitive
  trivial

end NegativeTypeShapeChecks

end LMLFTest.Integral.Improper.IMP001Regressions
