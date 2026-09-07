import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
noncomputable section
namespace LMLF.Blueprint.ExponentialIntegrals.Section63

/-- DLMF §6.3.F1: the plotted real-variable interval `0 < x ≤ 2`. -/
-- ANCHOR: figure631PlotInterval
def figure631PlotInterval : Set ℝ := Set.Ioc 0 2
-- ANCHOR_END: figure631PlotInterval

/-- DLMF §6.3.F2: the plotted real-variable interval `0 ≤ x ≤ 15`. -/
-- ANCHOR: figure632PlotInterval
def figure632PlotInterval : Set ℝ := Set.Icc 0 15
-- ANCHOR_END: figure632PlotInterval

/-- DLMF §6.3.F3: the plotted rectangle in the `(x,y)` plane. -/
-- ANCHOR: figure633PlotRectangle
def figure633PlotRectangle : Set (ℝ × ℝ) :=
  Set.Icc (-4 : ℝ) 4 ×ˢ Set.Icc (-4 : ℝ) 4
-- ANCHOR_END: figure633PlotRectangle

/-- DLMF §6.3.F3: the principal E₁ cut along the nonpositive real axis. -/
-- ANCHOR: principalE1Cut
def principalE1Cut : Set ℂ := {z | z.im = 0 ∧ z.re ≤ 0}
-- ANCHOR_END: principalE1Cut
end LMLF.Blueprint.ExponentialIntegrals.Section63
