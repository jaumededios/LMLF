import LMLF.Definitions.Gamma
import Mathlib.Analysis.SpecialFunctions.Gamma.BohrMollerup
import Mathlib.Analysis.SpecialFunctions.Gamma.Digamma

/-!
# DLMF §5.3: Graphics

Section 5.3 contains figures rather than numbered equations.  The declarations below keep the
mathematical content visible: the reciprocal plotted with Gamma, the convexity stated in the
real-argument caption, the standard logarithmic-derivative meaning of the digamma graph, and the
absolute-value quantities used for the complex-argument surfaces.
-/

-- ANCHOR: section53Context
namespace LMLF.Blueprint.Gamma
-- ANCHOR_END: section53Context

/-- DLMF 5.3.F1: on the positive real axis, the plotted reciprocal of Gamma is its multiplicative
inverse.  This is the real-positive specialization of the graph, where Gamma is nonzero. -/
-- ANCHOR: gamma_graph_reciprocal_on_pos
theorem gamma_graph_reciprocal_on_pos {x : ℝ} (hx : 0 < x) :
    Real.Gamma x * (Real.Gamma x)⁻¹ = 1
-- ANCHOR_END: gamma_graph_reciprocal_on_pos
:= by
  sorry

/-- DLMF 5.3.F2: the logarithm of Gamma is convex on the open positive half-line. -/
-- ANCHOR: log_gamma_convexOn
theorem log_gamma_convexOn :
    ConvexOn ℝ (Set.Ioi (0 : ℝ)) (fun x : ℝ ↦ Real.log (Real.Gamma x))
-- ANCHOR_END: log_gamma_convexOn
:= by
  sorry

/-- DLMF 5.3.F3: the plotted psi function is the logarithmic derivative of Gamma, here written on
the real axis with the complex Gamma and digamma objects used by the formal development. -/
-- ANCHOR: digamma_graph_log_derivative
theorem digamma_graph_log_derivative {x : ℝ}
    (hx : ∀ n : ℕ, (x : ℂ) ≠ -(n : ℂ)) :
    Complex.digamma (x : ℂ) =
      deriv Complex.Gamma (x : ℂ) / Complex.Gamma (x : ℂ)
-- ANCHOR_END: digamma_graph_log_derivative
:= by
  sorry

/-- DLMF 5.3.F4: the height and color of the Gamma surface are the nonnegative absolute value of
Gamma at `x + I y`. -/
-- ANCHOR: gamma_abs_graph_nonnegative
theorem gamma_abs_graph_nonnegative (x y : ℝ) :
    0 ≤ ‖Complex.Gamma (x + (y : ℂ) * Complex.I)‖
-- ANCHOR_END: gamma_abs_graph_nonnegative
:= by
  sorry

/-- DLMF 5.3.F5: the reciprocal-Gamma surface is the reciprocal of the absolute value of the
complex Gamma value at `x + I y`. -/
-- ANCHOR: reciprocal_gamma_abs_graph
theorem reciprocal_gamma_abs_graph (x y : ℝ) :
    ‖(Complex.Gamma (x + (y : ℂ) * Complex.I))⁻¹‖ =
      ‖Complex.Gamma (x + (y : ℂ) * Complex.I)‖⁻¹
-- ANCHOR_END: reciprocal_gamma_abs_graph
:= by
  sorry

/-- DLMF 5.3.F6: the digamma surface uses the nonnegative absolute value of psi at `x + I y`. -/
-- ANCHOR: digamma_abs_graph_nonnegative
theorem digamma_abs_graph_nonnegative (x y : ℝ) :
    0 ≤ ‖Complex.digamma (x + (y : ℂ) * Complex.I)‖
-- ANCHOR_END: digamma_abs_graph_nonnegative
:= by
  sorry

end LMLF.Blueprint.Gamma
