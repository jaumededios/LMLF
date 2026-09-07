import LMLF.ODE.HolomorphicLinear

namespace LMLFTest.ODE

universe u

open Set

-- The public theorem remains polymorphic in the Banach-space universe.
example {E : Type u} [NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E]
    {Z : Set ℂ} (hZ : IsOpen Z) (hZc : IsSimplyConnected Z)
    {A : ℂ → (E →L[ℂ] E)} (hA : AnalyticOnNhd ℂ A Z)
    {x₀ : ℂ} (hx₀ : x₀ ∈ Z) (u₀ : E) :
    ∃ u : ℂ → E, u x₀ = u₀ ∧ AnalyticOnNhd ℂ u Z ∧
      (∀ z ∈ Z, HasDerivAt u (A z (u z)) z) ∧
      ∀ v : ℂ → E, v x₀ = u₀ → AnalyticOnNhd ℂ v Z →
        (∀ z ∈ Z, HasDerivAt v (A z (v z)) z) → EqOn u v Z :=
  LMLF.ODE.exists_unique_holomorphicLinearIVP hZ hZc hA hx₀ u₀

end LMLFTest.ODE
