import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
import Mathlib.Topology.Order.IntermediateValue

/-!
# Wronskians for second-order ordinary differential equations

Abel's identity for complex-valued solutions of a second-order ODE with real
independent variable, together with its real-valued specialization.
-/

open MeasureTheory Set
open scoped Interval

namespace LMLF.ODE

/-- The pointwise Wronskian determinant of two phase pairs. -/
def wronskian {X R : Type*} [Mul R] [Sub R]
    (y₁ v₁ y₂ v₂ : X → R) (x : X) : R :=
  y₁ x * v₂ x - y₂ x * v₁ x

/-- Compatibility name for the Wronskian of two real-valued phase pairs. -/
abbrev realWronskian (y₁ v₁ y₂ v₂ : ℝ → ℝ) (x : ℝ) : ℝ :=
  wronskian y₁ v₁ y₂ v₂ x

private theorem integral_hasDerivAt_of_continuousOn
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
    {I : Set ℝ} (hI : IsOpen I) (hIc : IsPreconnected I)
    {f : ℝ → E} (hf : ContinuousOn f I) {x₀ x : ℝ} (hx₀ : x₀ ∈ I) (hx : x ∈ I) :
    HasDerivAt (fun u ↦ ∫ t in x₀..u, f t) (f x) x := by
  apply intervalIntegral.integral_hasDerivAt_right
  · exact (hf.mono (hIc.ordConnected.uIcc_subset hx₀ hx)).intervalIntegrable
  · exact hf.stronglyMeasurableAtFilter hI x hx
  · exact hf.continuousAt (hI.mem_nhds hx)

/-- A1: the Wronskian of two complex phase-pair solutions satisfies `W' = -f W`. -/
theorem hasDerivAt_wronskian {I : Set ℝ} {f g y₁ v₁ y₂ v₂ : ℝ → ℂ} {x : ℝ}
    (hx : x ∈ I)
    (hy₁ : ∀ z ∈ I, HasDerivAt y₁ (v₁ z) z)
    (hv₁ : ∀ z ∈ I, HasDerivAt v₁ (-f z * v₁ z - g z * y₁ z) z)
    (hy₂ : ∀ z ∈ I, HasDerivAt y₂ (v₂ z) z)
    (hv₂ : ∀ z ∈ I, HasDerivAt v₂ (-f z * v₂ z - g z * y₂ z) z) :
    HasDerivAt (wronskian y₁ v₁ y₂ v₂)
      (-f x * wronskian y₁ v₁ y₂ v₂ x) x := by
  have h := ((hy₁ x hx).mul (hv₂ x hx)).sub ((hy₂ x hx).mul (hv₁ x hx))
  exact h.congr_deriv (by simp only [wronskian]; ring)

/-- A2: Abel's basepoint formula for complex-valued solutions. -/
theorem wronskian_eq_mul_cexp_integral {I : Set ℝ} {f g y₁ v₁ y₂ v₂ : ℝ → ℂ}
    (hI : IsOpen I) (hIc : IsPreconnected I) (hf : ContinuousOn f I)
    (hy₁ : ∀ z ∈ I, HasDerivAt y₁ (v₁ z) z)
    (hv₁ : ∀ z ∈ I, HasDerivAt v₁ (-f z * v₁ z - g z * y₁ z) z)
    (hy₂ : ∀ z ∈ I, HasDerivAt y₂ (v₂ z) z)
    (hv₂ : ∀ z ∈ I, HasDerivAt v₂ (-f z * v₂ z - g z * y₂ z) z)
    {x₀ x : ℝ} (hx₀ : x₀ ∈ I) (hx : x ∈ I) :
    wronskian y₁ v₁ y₂ v₂ x = wronskian y₁ v₁ y₂ v₂ x₀ *
      Complex.exp (-∫ t in x₀..x, f t) := by
  let A : ℝ → ℂ := fun u ↦ ∫ t in x₀..u, f t
  let E : ℝ → ℂ := fun u ↦ Complex.exp (A u) * wronskian y₁ v₁ y₂ v₂ u
  have hE : ∀ z ∈ I, HasDerivAt E 0 z := by
    intro z hz
    have hA : HasDerivAt A (f z) z :=
      integral_hasDerivAt_of_continuousOn hI hIc hf hx₀ hz
    have hW := hasDerivAt_wronskian hz hy₁ hv₁ hy₂ hv₂
    have h := hA.cexp.mul hW
    exact h.congr_deriv (by ring)
  have hconst : E x = E x₀ :=
    hI.is_const_of_deriv_eq_zero hIc
      (fun z hz ↦ (hE z hz).differentiableAt.differentiableWithinAt)
      (fun z hz ↦ (hE z hz).deriv) hx hx₀
  have hproduct : Complex.exp (A x) * wronskian y₁ v₁ y₂ v₂ x =
      wronskian y₁ v₁ y₂ v₂ x₀ := by
    simpa [E, A] using hconst
  calc
    wronskian y₁ v₁ y₂ v₂ x =
        (Complex.exp (A x))⁻¹ *
          (Complex.exp (A x) * wronskian y₁ v₁ y₂ v₂ x) := by
            simp [Complex.exp_ne_zero]
    _ = (Complex.exp (A x))⁻¹ * wronskian y₁ v₁ y₂ v₂ x₀ := by rw [hproduct]
    _ = wronskian y₁ v₁ y₂ v₂ x₀ * Complex.exp (-A x) := by
      rw [Complex.exp_neg]
      ac_rfl
    _ = wronskian y₁ v₁ y₂ v₂ x₀ * Complex.exp (-∫ t in x₀..x, f t) := by rfl

/-- A3, pointwise form: a complex Wronskian vanishes at one point iff it vanishes at another. -/
theorem wronskian_eq_zero_iff {I : Set ℝ} {f g y₁ v₁ y₂ v₂ : ℝ → ℂ}
    (hI : IsOpen I) (hIc : IsPreconnected I) (hf : ContinuousOn f I)
    (hy₁ : ∀ z ∈ I, HasDerivAt y₁ (v₁ z) z)
    (hv₁ : ∀ z ∈ I, HasDerivAt v₁ (-f z * v₁ z - g z * y₁ z) z)
    (hy₂ : ∀ z ∈ I, HasDerivAt y₂ (v₂ z) z)
    (hv₂ : ∀ z ∈ I, HasDerivAt v₂ (-f z * v₂ z - g z * y₂ z) z)
    {x₀ x : ℝ} (hx₀ : x₀ ∈ I) (hx : x ∈ I) :
    wronskian y₁ v₁ y₂ v₂ x = 0 ↔ wronskian y₁ v₁ y₂ v₂ x₀ = 0 := by
  rw [wronskian_eq_mul_cexp_integral hI hIc hf hy₁ hv₁ hy₂ hv₂ hx₀ hx,
    mul_eq_zero]
  simp [Complex.exp_ne_zero]

/-- A3: a complex Wronskian is identically zero or nowhere zero on a nonempty interval. -/
theorem wronskian_zero_or_nowhere_zero {I : Set ℝ} {f g y₁ v₁ y₂ v₂ : ℝ → ℂ}
    (hIne : I.Nonempty) (hI : IsOpen I) (hIc : IsPreconnected I) (hf : ContinuousOn f I)
    (hy₁ : ∀ z ∈ I, HasDerivAt y₁ (v₁ z) z)
    (hv₁ : ∀ z ∈ I, HasDerivAt v₁ (-f z * v₁ z - g z * y₁ z) z)
    (hy₂ : ∀ z ∈ I, HasDerivAt y₂ (v₂ z) z)
    (hv₂ : ∀ z ∈ I, HasDerivAt v₂ (-f z * v₂ z - g z * y₂ z) z) :
    (∀ x ∈ I, wronskian y₁ v₁ y₂ v₂ x = 0) ∨
      (∀ x ∈ I, wronskian y₁ v₁ y₂ v₂ x ≠ 0) := by
  obtain ⟨x₀, hx₀⟩ := hIne
  by_cases hzero : wronskian y₁ v₁ y₂ v₂ x₀ = 0
  · left
    intro x hx
    exact (wronskian_eq_zero_iff hI hIc hf hy₁ hv₁ hy₂ hv₂ hx₀ hx).2 hzero
  · right
    intro x hx hxzero
    exact hzero ((wronskian_eq_zero_iff hI hIc hf hy₁ hv₁ hy₂ hv₂ hx₀ hx).1 hxzero)

/-- A3, exclusive form: exactly one complex Wronskian alternative holds. -/
theorem wronskian_zero_xor_nowhere_zero {I : Set ℝ} {f g y₁ v₁ y₂ v₂ : ℝ → ℂ}
    (hIne : I.Nonempty) (hI : IsOpen I) (hIc : IsPreconnected I) (hf : ContinuousOn f I)
    (hy₁ : ∀ z ∈ I, HasDerivAt y₁ (v₁ z) z)
    (hv₁ : ∀ z ∈ I, HasDerivAt v₁ (-f z * v₁ z - g z * y₁ z) z)
    (hy₂ : ∀ z ∈ I, HasDerivAt y₂ (v₂ z) z)
    (hv₂ : ∀ z ∈ I, HasDerivAt v₂ (-f z * v₂ z - g z * y₂ z) z) :
    Xor (∀ x ∈ I, wronskian y₁ v₁ y₂ v₂ x = 0)
      (∀ x ∈ I, wronskian y₁ v₁ y₂ v₂ x ≠ 0) := by
  rcases wronskian_zero_or_nowhere_zero hIne hI hIc hf hy₁ hv₁ hy₂ hv₂ with hzero | hne
  · left
    refine ⟨hzero, ?_⟩
    intro hnowhere
    obtain ⟨x, hx⟩ := hIne
    exact hnowhere x hx (hzero x hx)
  · right
    refine ⟨hne, ?_⟩
    intro hzero
    obtain ⟨x, hx⟩ := hIne
    exact hne x hx (hzero x hx)

/-- A4: if the first-derivative coefficient vanishes, the complex Wronskian is constant. -/
theorem wronskian_eq_of_f_eq_zero {I : Set ℝ} {f g y₁ v₁ y₂ v₂ : ℝ → ℂ}
    (hI : IsOpen I) (hIc : IsPreconnected I) (hf : ∀ z ∈ I, f z = 0)
    (hy₁ : ∀ z ∈ I, HasDerivAt y₁ (v₁ z) z)
    (hv₁ : ∀ z ∈ I, HasDerivAt v₁ (-f z * v₁ z - g z * y₁ z) z)
    (hy₂ : ∀ z ∈ I, HasDerivAt y₂ (v₂ z) z)
    (hv₂ : ∀ z ∈ I, HasDerivAt v₂ (-f z * v₂ z - g z * y₂ z) z)
    {x₀ x : ℝ} (hx₀ : x₀ ∈ I) (hx : x ∈ I) :
    wronskian y₁ v₁ y₂ v₂ x = wronskian y₁ v₁ y₂ v₂ x₀ := by
  apply hI.is_const_of_deriv_eq_zero hIc
    (fun z hz ↦
      (hasDerivAt_wronskian hz hy₁ hv₁ hy₂ hv₂).differentiableAt.differentiableWithinAt)
    (fun z hz ↦ ?_) hx hx₀
  simpa [hf z hz] using (hasDerivAt_wronskian hz hy₁ hv₁ hy₂ hv₂).deriv

/-- Real A1: the Wronskian of two real phase-pair solutions satisfies `W' = -f W`. -/
theorem hasDerivAt_realWronskian {I : Set ℝ} {f g y₁ v₁ y₂ v₂ : ℝ → ℝ} {x : ℝ}
    (hx : x ∈ I)
    (hy₁ : ∀ z ∈ I, HasDerivAt y₁ (v₁ z) z)
    (hv₁ : ∀ z ∈ I, HasDerivAt v₁ (-f z * v₁ z - g z * y₁ z) z)
    (hy₂ : ∀ z ∈ I, HasDerivAt y₂ (v₂ z) z)
    (hv₂ : ∀ z ∈ I, HasDerivAt v₂ (-f z * v₂ z - g z * y₂ z) z) :
    HasDerivAt (realWronskian y₁ v₁ y₂ v₂)
      (-f x * realWronskian y₁ v₁ y₂ v₂ x) x := by
  have h := ((hy₁ x hx).mul (hv₂ x hx)).sub ((hy₂ x hx).mul (hv₁ x hx))
  exact h.congr_deriv (by simp only [realWronskian, wronskian]; ring)

/-- Real A2: Abel's basepoint formula for real-valued solutions. -/
theorem realWronskian_eq_mul_exp_integral {I : Set ℝ} {f g y₁ v₁ y₂ v₂ : ℝ → ℝ}
    (hI : IsOpen I) (hIc : IsPreconnected I) (hf : ContinuousOn f I)
    (hy₁ : ∀ z ∈ I, HasDerivAt y₁ (v₁ z) z)
    (hv₁ : ∀ z ∈ I, HasDerivAt v₁ (-f z * v₁ z - g z * y₁ z) z)
    (hy₂ : ∀ z ∈ I, HasDerivAt y₂ (v₂ z) z)
    (hv₂ : ∀ z ∈ I, HasDerivAt v₂ (-f z * v₂ z - g z * y₂ z) z)
    {x₀ x : ℝ} (hx₀ : x₀ ∈ I) (hx : x ∈ I) :
    realWronskian y₁ v₁ y₂ v₂ x = realWronskian y₁ v₁ y₂ v₂ x₀ *
      Real.exp (-∫ t in x₀..x, f t) := by
  let A : ℝ → ℝ := fun u ↦ ∫ t in x₀..u, f t
  let E : ℝ → ℝ := fun u ↦ Real.exp (A u) * realWronskian y₁ v₁ y₂ v₂ u
  have hE : ∀ z ∈ I, HasDerivAt E 0 z := by
    intro z hz
    have hA : HasDerivAt A (f z) z :=
      integral_hasDerivAt_of_continuousOn hI hIc hf hx₀ hz
    have hW := hasDerivAt_realWronskian hz hy₁ hv₁ hy₂ hv₂
    have h := hA.exp.mul hW
    exact h.congr_deriv (by ring)
  have hconst : E x = E x₀ :=
    hI.is_const_of_deriv_eq_zero hIc
      (fun z hz ↦ (hE z hz).differentiableAt.differentiableWithinAt)
      (fun z hz ↦ (hE z hz).deriv) hx hx₀
  have hproduct : Real.exp (A x) * realWronskian y₁ v₁ y₂ v₂ x =
      realWronskian y₁ v₁ y₂ v₂ x₀ := by
    simpa [E, A] using hconst
  calc
    realWronskian y₁ v₁ y₂ v₂ x =
        (Real.exp (A x))⁻¹ * (Real.exp (A x) * realWronskian y₁ v₁ y₂ v₂ x) := by
          simp [Real.exp_ne_zero]
    _ = (Real.exp (A x))⁻¹ * realWronskian y₁ v₁ y₂ v₂ x₀ := by rw [hproduct]
    _ = realWronskian y₁ v₁ y₂ v₂ x₀ * Real.exp (-A x) := by
      rw [Real.exp_neg]
      ac_rfl
    _ = realWronskian y₁ v₁ y₂ v₂ x₀ * Real.exp (-∫ t in x₀..x, f t) := by rfl

/-- Real A3, pointwise form. -/
theorem realWronskian_eq_zero_iff {I : Set ℝ} {f g y₁ v₁ y₂ v₂ : ℝ → ℝ}
    (hI : IsOpen I) (hIc : IsPreconnected I) (hf : ContinuousOn f I)
    (hy₁ : ∀ z ∈ I, HasDerivAt y₁ (v₁ z) z)
    (hv₁ : ∀ z ∈ I, HasDerivAt v₁ (-f z * v₁ z - g z * y₁ z) z)
    (hy₂ : ∀ z ∈ I, HasDerivAt y₂ (v₂ z) z)
    (hv₂ : ∀ z ∈ I, HasDerivAt v₂ (-f z * v₂ z - g z * y₂ z) z)
    {x₀ x : ℝ} (hx₀ : x₀ ∈ I) (hx : x ∈ I) :
    realWronskian y₁ v₁ y₂ v₂ x = 0 ↔ realWronskian y₁ v₁ y₂ v₂ x₀ = 0 := by
  rw [realWronskian_eq_mul_exp_integral hI hIc hf hy₁ hv₁ hy₂ hv₂ hx₀ hx,
    mul_eq_zero]
  simp [Real.exp_ne_zero]

/-- Real A3: a real Wronskian is identically zero or nowhere zero. -/
theorem realWronskian_zero_or_nowhere_zero {I : Set ℝ} {f g y₁ v₁ y₂ v₂ : ℝ → ℝ}
    (hIne : I.Nonempty) (hI : IsOpen I) (hIc : IsPreconnected I) (hf : ContinuousOn f I)
    (hy₁ : ∀ z ∈ I, HasDerivAt y₁ (v₁ z) z)
    (hv₁ : ∀ z ∈ I, HasDerivAt v₁ (-f z * v₁ z - g z * y₁ z) z)
    (hy₂ : ∀ z ∈ I, HasDerivAt y₂ (v₂ z) z)
    (hv₂ : ∀ z ∈ I, HasDerivAt v₂ (-f z * v₂ z - g z * y₂ z) z) :
    (∀ x ∈ I, realWronskian y₁ v₁ y₂ v₂ x = 0) ∨
      (∀ x ∈ I, realWronskian y₁ v₁ y₂ v₂ x ≠ 0) := by
  obtain ⟨x₀, hx₀⟩ := hIne
  by_cases hzero : realWronskian y₁ v₁ y₂ v₂ x₀ = 0
  · left
    intro x hx
    exact (realWronskian_eq_zero_iff hI hIc hf hy₁ hv₁ hy₂ hv₂ hx₀ hx).2 hzero
  · right
    intro x hx hxzero
    exact hzero ((realWronskian_eq_zero_iff hI hIc hf hy₁ hv₁ hy₂ hv₂ hx₀ hx).1 hxzero)

/-- Real A3, exclusive form: exactly one real Wronskian alternative holds. -/
theorem realWronskian_zero_xor_nowhere_zero {I : Set ℝ} {f g y₁ v₁ y₂ v₂ : ℝ → ℝ}
    (hIne : I.Nonempty) (hI : IsOpen I) (hIc : IsPreconnected I) (hf : ContinuousOn f I)
    (hy₁ : ∀ z ∈ I, HasDerivAt y₁ (v₁ z) z)
    (hv₁ : ∀ z ∈ I, HasDerivAt v₁ (-f z * v₁ z - g z * y₁ z) z)
    (hy₂ : ∀ z ∈ I, HasDerivAt y₂ (v₂ z) z)
    (hv₂ : ∀ z ∈ I, HasDerivAt v₂ (-f z * v₂ z - g z * y₂ z) z) :
    Xor (∀ x ∈ I, realWronskian y₁ v₁ y₂ v₂ x = 0)
      (∀ x ∈ I, realWronskian y₁ v₁ y₂ v₂ x ≠ 0) := by
  rcases realWronskian_zero_or_nowhere_zero hIne hI hIc hf hy₁ hv₁ hy₂ hv₂ with hzero | hne
  · left
    refine ⟨hzero, ?_⟩
    intro hnowhere
    obtain ⟨x, hx⟩ := hIne
    exact hnowhere x hx (hzero x hx)
  · right
    refine ⟨hne, ?_⟩
    intro hzero
    obtain ⟨x, hx⟩ := hIne
    exact hne x hx (hzero x hx)

/-- Real A4: if the first-derivative coefficient vanishes, the real Wronskian is constant. -/
theorem realWronskian_eq_of_f_eq_zero {I : Set ℝ} {f g y₁ v₁ y₂ v₂ : ℝ → ℝ}
    (hI : IsOpen I) (hIc : IsPreconnected I) (hf : ∀ z ∈ I, f z = 0)
    (hy₁ : ∀ z ∈ I, HasDerivAt y₁ (v₁ z) z)
    (hv₁ : ∀ z ∈ I, HasDerivAt v₁ (-f z * v₁ z - g z * y₁ z) z)
    (hy₂ : ∀ z ∈ I, HasDerivAt y₂ (v₂ z) z)
    (hv₂ : ∀ z ∈ I, HasDerivAt v₂ (-f z * v₂ z - g z * y₂ z) z)
    {x₀ x : ℝ} (hx₀ : x₀ ∈ I) (hx : x ∈ I) :
    realWronskian y₁ v₁ y₂ v₂ x = realWronskian y₁ v₁ y₂ v₂ x₀ := by
  apply hI.is_const_of_deriv_eq_zero hIc
    (fun z hz ↦
      (hasDerivAt_realWronskian hz hy₁ hv₁ hy₂ hv₂).differentiableAt.differentiableWithinAt)
    (fun z hz ↦ ?_) hx hx₀
  simpa [hf z hz] using (hasDerivAt_realWronskian hz hy₁ hv₁ hy₂ hv₂).deriv

end LMLF.ODE
