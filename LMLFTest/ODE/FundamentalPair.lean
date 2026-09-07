import LMLF.ODE.FundamentalPair

/-!
# Public-use tests for fundamental pairs
-/

open Function Set

namespace LMLFTest.ODE

example {X K : Type*} [Ring K] (I : Set X) (y₁ y₂ : X → K) :
    LinearIndependent K
        ![(fun x : I ↦ y₁ x.1), (fun x : I ↦ y₂ x.1)] ↔
      ∀ A B : K, EqOn (fun x ↦ A * y₁ x + B * y₂ x) 0 I → A = 0 ∧ B = 0 :=
  LMLF.ODE.linearIndependent_restrict_pair_iff I y₁ y₂

example {I : Set ℝ} (hI : IsOpen I) (hIc : IsPreconnected I)
    {f g : ℝ → ℂ} (hf : ContinuousOn f I) (hg : ContinuousOn g I)
    {x₀ : ℝ} (hx₀ : x₀ ∈ I) {y₁ v₁ y₂ v₂ y v : ℝ → ℂ}
    (hy₁ : ∀ x ∈ I, HasDerivAt y₁ (v₁ x) x)
    (hv₁ : ∀ x ∈ I, HasDerivAt v₁ (-f x * v₁ x - g x * y₁ x) x)
    (hy₂ : ∀ x ∈ I, HasDerivAt y₂ (v₂ x) x)
    (hv₂ : ∀ x ∈ I, HasDerivAt v₂ (-f x * v₂ x - g x * y₂ x) x)
    (hy : ∀ x ∈ I, HasDerivAt y (v x) x)
    (hv : ∀ x ∈ I, HasDerivAt v (-f x * v x - g x * y x) x)
    (hW : LMLF.ODE.wronskian y₁ v₁ y₂ v₂ x₀ ≠ 0) :
    let Δ := LMLF.ODE.wronskian y₁ v₁ y₂ v₂ x₀
    let A := (y x₀ * v₂ x₀ - y₂ x₀ * v x₀) / Δ
    let B := (y₁ x₀ * v x₀ - y x₀ * v₁ x₀) / Δ
    EqOn y (fun x ↦ A * y₁ x + B * y₂ x) I ∧
      EqOn v (fun x ↦ A * v₁ x + B * v₂ x) I :=
  LMLF.ODE.complexLinearSolution_eqOn_cramer hI hIc hf hg hx₀
    hy₁ hv₁ hy₂ hv₂ hy hv hW

example {I : Set ℝ} (hI : IsOpen I) (hIc : IsPreconnected I)
    {f g : ℝ → ℝ} (hf : ContinuousOn f I) (hg : ContinuousOn g I)
    {x₀ : ℝ} (hx₀ : x₀ ∈ I) {y₁ v₁ y₂ v₂ y v : ℝ → ℝ}
    (hy₁ : ∀ x ∈ I, HasDerivAt y₁ (v₁ x) x)
    (hv₁ : ∀ x ∈ I, HasDerivAt v₁ (-f x * v₁ x - g x * y₁ x) x)
    (hy₂ : ∀ x ∈ I, HasDerivAt y₂ (v₂ x) x)
    (hv₂ : ∀ x ∈ I, HasDerivAt v₂ (-f x * v₂ x - g x * y₂ x) x)
    (hy : ∀ x ∈ I, HasDerivAt y (v x) x)
    (hv : ∀ x ∈ I, HasDerivAt v (-f x * v x - g x * y x) x)
    (hW : LMLF.ODE.realWronskian y₁ v₁ y₂ v₂ x₀ ≠ 0) :
    let Δ := LMLF.ODE.realWronskian y₁ v₁ y₂ v₂ x₀
    let A := (y x₀ * v₂ x₀ - y₂ x₀ * v x₀) / Δ
    let B := (y₁ x₀ * v x₀ - y x₀ * v₁ x₀) / Δ
    EqOn y (fun x ↦ A * y₁ x + B * y₂ x) I ∧
      EqOn v (fun x ↦ A * v₁ x + B * v₂ x) I :=
  LMLF.ODE.realLinearSolution_eqOn_cramer hI hIc hf hg hx₀
    hy₁ hv₁ hy₂ hv₂ hy hv hW

theorem spanning_offDomain_invariant
    {𝕂 : Type*} [RCLike 𝕂] {I : Set ℝ} {f g y₁ y₂ z₁ z₂ : ℝ → 𝕂}
    (hy₁ : EqOn y₁ z₁ I) (hy₂ : EqOn y₂ z₂ I) :
    LMLF.ODE.SpansSecondOrderLinearSolutionsOn I f g y₁ y₂ ↔
      LMLF.ODE.SpansSecondOrderLinearSolutionsOn I f g z₁ z₂ := by
  constructor
  · intro h y v hy hv
    obtain ⟨A, B, hEq⟩ := h y v hy hv
    refine ⟨A, B, hEq.trans ?_⟩
    intro x hx
    change A * y₁ x + B * y₂ x = A * z₁ x + B * z₂ x
    rw [hy₁ hx, hy₂ hx]
  · intro h y v hy hv
    obtain ⟨A, B, hEq⟩ := h y v hy hv
    refine ⟨A, B, hEq.trans ?_⟩
    intro x hx
    change A * z₁ x + B * z₂ x = A * y₁ x + B * y₂ x
    rw [← hy₁ hx, ← hy₂ hx]

theorem restricted_independence_offDomain_invariant
    {X K : Type*} [Ring K] {I : Set X} {y₁ y₂ z₁ z₂ : X → K}
    (hy₁ : EqOn y₁ z₁ I) (hy₂ : EqOn y₂ z₂ I) :
    LinearIndependent K ![(fun x : I ↦ y₁ x.1), (fun x : I ↦ y₂ x.1)] ↔
      LinearIndependent K ![(fun x : I ↦ z₁ x.1), (fun x : I ↦ z₂ x.1)] := by
  rw [LMLF.ODE.linearIndependent_restrict_pair_iff,
    LMLF.ODE.linearIndependent_restrict_pair_iff]
  constructor
  · intro h A B hzero
    apply h A B
    intro x hx
    simpa [hy₁ hx, hy₂ hx] using hzero hx
  · intro h A B hzero
    apply h A B
    intro x hx
    simpa [hy₁ hx, hy₂ hx] using hzero hx

theorem complexCanonicalFundamentalPair_consumer
    {I : Set ℝ} (hI : IsOpen I) (hIc : IsPreconnected I)
    {f g : ℝ → ℂ} (hf : ContinuousOn f I) (hg : ContinuousOn g I)
    {x₀ : ℝ} (hx₀ : x₀ ∈ I) :
    ∃ y₁ y₂ : ℝ → ℂ,
      ContDiffOn ℝ 2 y₁ I ∧ ContDiffOn ℝ 2 y₂ I ∧
      LMLF.ODE.SpansSecondOrderLinearSolutionsOn I f g y₁ y₂ ∧
      LinearIndependent ℂ ![(fun x : I ↦ y₁ x.1), (fun x : I ↦ y₂ x.1)] := by
  obtain ⟨y₁, v₁, y₂, v₂, hy₁₀, hv₁₀, hy₂₀, hv₂₀,
    hy₁, hv₁, hy₂, hv₂, hy₁C2, hy₂C2, hW, hspan, hind, hrepr⟩ :=
    LMLF.ODE.exists_complexCanonicalFundamentalPair hI hIc hf hg hx₀
  exact ⟨y₁, y₂, hy₁C2, hy₂C2, hspan, hind⟩

theorem realCanonicalFundamentalPair_consumer
    {I : Set ℝ} (hI : IsOpen I) (hIc : IsPreconnected I)
    {f g : ℝ → ℝ} (hf : ContinuousOn f I) (hg : ContinuousOn g I)
    {x₀ : ℝ} (hx₀ : x₀ ∈ I) :
    ∃ y₁ y₂ : ℝ → ℝ,
      ContDiffOn ℝ 2 y₁ I ∧ ContDiffOn ℝ 2 y₂ I ∧
      LMLF.ODE.SpansSecondOrderLinearSolutionsOn I f g y₁ y₂ ∧
      LinearIndependent ℝ ![(fun x : I ↦ y₁ x.1), (fun x : I ↦ y₂ x.1)] := by
  obtain ⟨y₁, v₁, y₂, v₂, hy₁₀, hv₁₀, hy₂₀, hv₂₀,
    hy₁, hv₁, hy₂, hv₂, hy₁C2, hy₂C2, hW, hspan, hind, hrepr⟩ :=
    LMLF.ODE.exists_realCanonicalFundamentalPair hI hIc hf hg hx₀
  exact ⟨y₁, y₂, hy₁C2, hy₂C2, hspan, hind⟩

end LMLFTest.ODE
