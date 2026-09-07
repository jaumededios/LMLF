import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real

open Set

noncomputable section

namespace LMLF.Blueprint.Elementary.Section43

/-! The figures in DLMF §4.3 record inverse relationships, a conformal map, and
the magnitude/phase surfaces of the principal logarithm and exponential. -/

/-- DLMF 4.3.F1: the real exponential and logarithm are inverse on their natural domains. -/
-- ANCHOR: real_log_exp_inverse
theorem real_log_exp_inverse (x : ℝ) : Real.log (Real.exp x) = x
-- ANCHOR_END: real_log_exp_inverse
    := by sorry

/-- DLMF 4.3.F1: exponentiating the real logarithm recovers every positive real. -/
-- ANCHOR: real_exp_log_inverse
theorem real_exp_log_inverse {x : ℝ} (hx : 0 < x) : Real.exp (Real.log x) = x
-- ANCHOR_END: real_exp_log_inverse
    := by sorry

/-- DLMF 4.3.F2: the exponential sends the horizontal strip to the slit plane;
the principal logarithm is its inverse there. -/
-- ANCHOR: complex_exp_principal_log_inverse
theorem complex_exp_principal_log_inverse {z : ℂ}
    (hz : z ≠ 0) (harg : |Complex.arg z| < Real.pi) :
    Complex.exp (Complex.log z) = z
-- ANCHOR_END: complex_exp_principal_log_inverse
    := by sorry

/-- DLMF 4.3.F2: on the principal strip, taking the principal logarithm after
exponentiation recovers the original complex coordinate. -/
-- ANCHOR: principal_log_exp_on_strip
theorem principal_log_exp_on_strip {z : ℂ}
    (hlo : -Real.pi < z.im) (hhi : z.im < Real.pi) :
    Complex.log (Complex.exp z) = z
-- ANCHOR_END: principal_log_exp_on_strip
    := by sorry

/-- DLMF 4.3.F2: the boundary points of the strip map to the two sides of the
negative real-axis cut, with the real parameter `r` controlling the radius. -/
-- ANCHOR: conformal_map_boundary_values
theorem conformal_map_boundary_values {r : ℝ} (hr : 0 < r) :
    Complex.exp (r + (Real.pi : ℂ) * Complex.I) = -(Real.exp r : ℂ) ∧
    Complex.exp (r - (Real.pi : ℂ) * Complex.I) = -(Real.exp r : ℂ) ∧
    Complex.exp ((Real.pi : ℂ) * Complex.I) = -1 ∧
    Complex.exp (-r + (Real.pi : ℂ) * Complex.I) = -(Real.exp (-r) : ℂ)
-- ANCHOR_END: conformal_map_boundary_values
    := by sorry

/-- DLMF 4.3.F2: the complete nine-point correspondence table for `w = exp z`.
The entries with `± i 0` represent the two sides of the negative-real-axis cut. -/
-- ANCHOR: conformal_map_nine_point_table
def conformalMapNinePointTable (r : ℝ) : List (ℂ × ℂ) :=
  [ (0, 1),
    (r, (Real.exp r : ℂ)),
    (r + (Real.pi : ℂ) * Complex.I, -(Real.exp r : ℂ) + 0 * Complex.I),
    (r - (Real.pi : ℂ) * Complex.I, -(Real.exp r : ℂ) - 0 * Complex.I),
    ((Real.pi : ℂ) * Complex.I, -1 + 0 * Complex.I),
    (-(Real.pi : ℂ) * Complex.I, -1 - 0 * Complex.I),
    (-r + (Real.pi : ℂ) * Complex.I, -(Real.exp (-r) : ℂ) + 0 * Complex.I),
    (-r - (Real.pi : ℂ) * Complex.I, -(Real.exp (-r) : ℂ) - 0 * Complex.I),
    (-r, (Real.exp (-r) : ℂ)) ]
-- ANCHOR_END: conformal_map_nine_point_table

/-- DLMF 4.3.F2: the nine-point table is the image of each listed `z` under
the exponential map, for every positive real parameter `r`. -/
-- ANCHOR: conformal_map_nine_point_table_spec
theorem conformal_map_nine_point_table_spec {r : ℝ} (hr : 0 < r) :
    conformalMapNinePointTable r =
      [ ((0 : ℂ), Complex.exp 0),
        ((r : ℂ), Complex.exp r),
        ((r : ℂ) + (Real.pi : ℂ) * Complex.I, Complex.exp (r + (Real.pi : ℂ) * Complex.I)),
        ((r : ℂ) - (Real.pi : ℂ) * Complex.I, Complex.exp (r - (Real.pi : ℂ) * Complex.I)),
        ((Real.pi : ℂ) * Complex.I, Complex.exp ((Real.pi : ℂ) * Complex.I)),
        (-(Real.pi : ℂ) * Complex.I, Complex.exp (-(Real.pi : ℂ) * Complex.I)),
        (-(r : ℂ) + (Real.pi : ℂ) * Complex.I, Complex.exp (-r + (Real.pi : ℂ) * Complex.I)),
        (-(r : ℂ) - (Real.pi : ℂ) * Complex.I, Complex.exp (-r - (Real.pi : ℂ) * Complex.I)),
        (-(r : ℂ), Complex.exp (-r)) ]
-- ANCHOR_END: conformal_map_nine_point_table_spec
    := by sorry

/-- DLMF 4.3.F3: the plotted surface height is the modulus of the principal
logarithm. -/
-- ANCHOR: principalLogSurfaceHeight
def principalLogSurfaceHeight (x y : ℝ) : ℝ :=
  ‖Complex.log (x + (y : ℂ) * Complex.I)‖
-- ANCHOR_END: principalLogSurfaceHeight

/-- DLMF 4.3.F3: the principal-logarithm plot uses the plane slit along the
nonpositive real axis as its displayed domain. -/
-- ANCHOR: principalLogSurfaceDomain
def principalLogSurfaceDomain : Set ℂ :=
  {z | ¬ (z.im = 0 ∧ z.re ≤ 0)}
-- ANCHOR_END: principalLogSurfaceDomain

/-- DLMF 4.3.F3: on the displayed slit-plane domain, the surface height is the
absolute value shown in the source caption. -/
-- ANCHOR: principal_log_surface_height
theorem principal_log_surface_height {x y : ℝ}
    (hxy : (x + (y : ℂ) * Complex.I) ∈ principalLogSurfaceDomain) :
    principalLogSurfaceHeight x y =
      ‖Complex.log (x + (y : ℂ) * Complex.I)‖
-- ANCHOR_END: principal_log_surface_height
    := by sorry

/-- DLMF 4.3.F4: the exponential surface has magnitude `exp x` at `x + i y`. -/
-- ANCHOR: complex_exp_surface_height
theorem complex_exp_surface_height (x y : ℝ) :
    ‖Complex.exp (x + (y : ℂ) * Complex.I)‖ = Real.exp x
-- ANCHOR_END: complex_exp_surface_height
    := by sorry

end LMLF.Blueprint.Elementary.Section43
