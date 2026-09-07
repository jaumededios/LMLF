import LMLF.ODE.LinearFirstOrder

/-!
# Tests for first-order homogeneous scalar equations

The examples exercise arbitrary constants (including zero and negative real
values), real-time complex solutions, oriented endpoints, basepoint
normalization, unbounded intervals, and `EqOn` classification on a proper
open interval.
-/

open MeasureTheory Set
open scoped Interval

namespace LMLFTest.ODE

noncomputable section

example (c : ℝ) :
    ∀ x ∈ (Set.univ : Set ℝ),
      HasDerivAt
        (fun u ↦ c * Real.exp (-∫ _t in (0 : ℝ)..u, (2 : ℝ)))
        (-(2 : ℝ) * (c * Real.exp (-∫ _t in (0 : ℝ)..x, (2 : ℝ)))) x := by
  exact LMLF.ODE.hasDerivAt_const_mul_exp_neg_integral
    isOpen_univ isPreconnected_univ continuousOn_const (Set.mem_univ 0) c

example :
    ∀ x ∈ (Set.univ : Set ℝ),
      HasDerivAt
        (fun u ↦ (5 : ℝ) * Real.exp (-∫ _t in (0 : ℝ)..u, (2 : ℝ)))
        (-(2 : ℝ) * ((5 : ℝ) * Real.exp (-∫ _t in (0 : ℝ)..x, (2 : ℝ)))) x := by
  exact LMLF.ODE.hasDerivAt_const_mul_exp_neg_integral
    isOpen_univ isPreconnected_univ continuousOn_const (Set.mem_univ 0) 5

example :
    ∀ x ∈ (Set.univ : Set ℝ),
      HasDerivAt
        (fun u ↦ (0 : ℝ) * Real.exp (-∫ _t in (0 : ℝ)..u, (2 : ℝ)))
        (-(2 : ℝ) * ((0 : ℝ) * Real.exp (-∫ _t in (0 : ℝ)..x, (2 : ℝ)))) x := by
  exact LMLF.ODE.hasDerivAt_const_mul_exp_neg_integral
    isOpen_univ isPreconnected_univ continuousOn_const (Set.mem_univ 0) 0

example :
    ∀ x ∈ (Set.univ : Set ℝ),
      HasDerivAt
        (fun u ↦ (-3 : ℝ) * Real.exp (-∫ _t in (0 : ℝ)..u, (2 : ℝ)))
        (-(2 : ℝ) * ((-3 : ℝ) * Real.exp (-∫ _t in (0 : ℝ)..x, (2 : ℝ)))) x := by
  exact LMLF.ODE.hasDerivAt_const_mul_exp_neg_integral
    isOpen_univ isPreconnected_univ continuousOn_const (Set.mem_univ 0) (-3)

example (c : ℂ) :
    ∀ x ∈ (Set.univ : Set ℝ),
      HasDerivAt
        (fun u ↦ c * Complex.exp (-∫ _t in (0 : ℝ)..u, (2 : ℂ)))
        (-(2 : ℂ) * (c * Complex.exp (-∫ _t in (0 : ℝ)..x, (2 : ℂ)))) x := by
  exact LMLF.ODE.hasDerivAt_const_mul_cexp_neg_integral
    isOpen_univ isPreconnected_univ continuousOn_const (Set.mem_univ 0) c

example :
    ∀ x ∈ (Set.univ : Set ℝ),
      HasDerivAt
        (fun u ↦ (0 : ℂ) * Complex.exp (-∫ _t in (0 : ℝ)..u, (2 : ℂ)))
        (-(2 : ℂ) * ((0 : ℂ) * Complex.exp (-∫ _t in (0 : ℝ)..x, (2 : ℂ)))) x := by
  exact LMLF.ODE.hasDerivAt_const_mul_cexp_neg_integral
    isOpen_univ isPreconnected_univ continuousOn_const (Set.mem_univ 0) 0

example :
    ∀ x ∈ (Set.univ : Set ℝ),
      HasDerivAt
        (fun u ↦ ((2 : ℂ) + Complex.I) *
          Complex.exp (-∫ _t in (0 : ℝ)..u, (2 : ℂ)))
        (-(2 : ℂ) * (((2 : ℂ) + Complex.I) *
          Complex.exp (-∫ _t in (0 : ℝ)..x, (2 : ℂ)))) x := by
  exact LMLF.ODE.hasDerivAt_const_mul_cexp_neg_integral
    isOpen_univ isPreconnected_univ continuousOn_const (Set.mem_univ 0) (2 + Complex.I)

-- The oriented integral supports either endpoint order and equal endpoints.
example (a : ℝ → ℝ) (ha : Continuous a) :
    HasDerivAt
      (fun u ↦ (-3 : ℝ) * Real.exp (-∫ t in (1 : ℝ)..u, a t))
      (-a (-2) * ((-3 : ℝ) * Real.exp (-∫ t in (1 : ℝ)..(-2), a t))) (-2) := by
  exact LMLF.ODE.hasDerivAt_const_mul_exp_neg_integral
    isOpen_univ isPreconnected_univ ha.continuousOn (Set.mem_univ 1) (-3) (-2) (Set.mem_univ _)

example (a : ℝ → ℝ) (ha : Continuous a) :
    HasDerivAt
      (fun u ↦ (-3 : ℝ) * Real.exp (-∫ t in (-2 : ℝ)..u, a t))
      (-a 1 * ((-3 : ℝ) * Real.exp (-∫ t in (-2 : ℝ)..(1 : ℝ), a t))) 1 := by
  exact LMLF.ODE.hasDerivAt_const_mul_exp_neg_integral
    isOpen_univ isPreconnected_univ ha.continuousOn (Set.mem_univ (-2)) (-3) 1 (Set.mem_univ _)

example (a : ℝ → ℝ) (ha : Continuous a) :
    HasDerivAt
      (fun u ↦ (-3 : ℝ) * Real.exp (-∫ t in (1 : ℝ)..u, a t))
      (-a 1 * ((-3 : ℝ) * Real.exp (-∫ t in (1 : ℝ)..(1 : ℝ), a t))) 1 := by
  exact LMLF.ODE.hasDerivAt_const_mul_exp_neg_integral
    isOpen_univ isPreconnected_univ ha.continuousOn (Set.mem_univ 1) (-3) 1 (Set.mem_univ _)

-- Basepoint normalization holds for every coefficient because the same-endpoint integral is zero.
example (a : ℝ → ℝ) (x₀ c : ℝ) :
    c * Real.exp (-∫ t in x₀..x₀, a t) = c := by simp

example (a : ℝ → ℂ) (x₀ : ℝ) (c : ℂ) :
    c * Complex.exp (-∫ t in x₀..x₀, a t) = c := by simp

-- `Ioi 0` is unbounded; only finite oriented segments inside it are used.
example {a w : ℝ → ℝ} (ha : ContinuousOn a (Ioi 0))
    (hw : ∀ x ∈ Ioi (0 : ℝ), HasDerivAt w (-a x * w x) x) :
    Set.EqOn w (fun x ↦ w 1 * Real.exp (-∫ t in (1 : ℝ)..x, a t)) (Ioi 0) := by
  exact LMLF.ODE.eqOn_const_mul_exp_neg_integral_of_hasDerivAt
    isOpen_Ioi isPreconnected_Ioi ha hw (by norm_num)

-- The conclusion deliberately remains `EqOn` on this proper open interval;
-- it makes no assertion that the two total functions agree outside `Ioo (-2) 3`.
example {a w : ℝ → ℝ} (ha : ContinuousOn a (Ioo (-2) 3))
    (hw : ∀ x ∈ Ioo (-2 : ℝ) 3, HasDerivAt w (-a x * w x) x) :
    Set.EqOn w (fun x ↦ w 0 * Real.exp (-∫ t in (0 : ℝ)..x, a t)) (Ioo (-2) 3) := by
  exact LMLF.ODE.eqOn_const_mul_exp_neg_integral_of_hasDerivAt
    isOpen_Ioo isPreconnected_Ioo ha hw (by constructor <;> norm_num)

example {a w : ℝ → ℂ} (ha : ContinuousOn a (Ioo (-2) 3))
    (hw : ∀ x ∈ Ioo (-2 : ℝ) 3, HasDerivAt w (-a x * w x) x) :
    Set.EqOn w (fun x ↦ w 0 * Complex.exp (-∫ t in (0 : ℝ)..x, a t)) (Ioo (-2) 3) := by
  exact LMLF.ODE.eqOn_const_mul_cexp_neg_integral_of_hasDerivAt
    isOpen_Ioo isPreconnected_Ioo ha hw (by constructor <;> norm_num)

end

end LMLFTest.ODE
