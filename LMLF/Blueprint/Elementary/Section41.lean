import Mathlib.Analysis.SpecialFunctions.Gamma.Basic

/-!
# DLMF 4.1: special notation

Section 4.1 fixes the notation used throughout the elementary-functions chapter rather
than stating numbered equations.  The declarations below make the notation table's
domains, complex-coordinate convention, and exponential base explicit while leaving
the substantive function definitions to the later sections where DLMF introduces them.
-/

namespace LMLF.Blueprint.Elementary.Section41

/-- DLMF 4.1, notation table row `k,m,n`: integer variables. -/
-- ANCHOR: IntegerVariable
abbrev IntegerVariable := ℤ
-- ANCHOR_END: IntegerVariable

/-- DLMF 4.1, notation table row `a,c`: real or complex constants represented in `ℂ`. -/
-- ANCHOR: RealOrComplexConstant
abbrev RealOrComplexConstant := ℂ
-- ANCHOR_END: RealOrComplexConstant

/-- DLMF 4.1, notation table row `x,y`: real variables. -/
-- ANCHOR: RealVariable
abbrev RealVariable := ℝ
-- ANCHOR_END: RealVariable

/-- DLMF 4.1, notation table row `z = x + i y`: the complex argument determined by
real coordinates. -/
-- ANCHOR: complexCoordinate
def complexCoordinate (x y : ℝ) : ℂ := (x : ℂ) + Complex.I * (y : ℂ)
-- ANCHOR_END: complexCoordinate

/-- DLMF 4.1, notation table row `z = x + i y`: its real coordinate is `x`. -/
-- ANCHOR: complexCoordinate_re
theorem complexCoordinate_re (x y : ℝ) :
    (complexCoordinate x y).re = x
-- ANCHOR_END: complexCoordinate_re
:= by sorry

/-- DLMF 4.1, notation table row `z = x + i y`: its imaginary coordinate is `y`. -/
-- ANCHOR: complexCoordinate_im
theorem complexCoordinate_im (x y : ℝ) :
    (complexCoordinate x y).im = y
-- ANCHOR_END: complexCoordinate_im
:= by sorry

/-- DLMF 4.1, notation table row `e`: the base of natural logarithms. -/
-- ANCHOR: naturalLogBase
noncomputable def naturalLogBase : ℝ := Real.exp 1
-- ANCHOR_END: naturalLogBase

/-- DLMF 4.1, notation table row `e`: the base is positive. -/
-- ANCHOR: naturalLogBase_pos
theorem naturalLogBase_pos : 0 < naturalLogBase
-- ANCHOR_END: naturalLogBase_pos
:= by sorry

/-- DLMF 4.1, chapter scope: the named elementary functions take a complex argument. -/
-- ANCHOR: ComplexFunction
abbrev ComplexFunction := ℂ → ℂ
-- ANCHOR_END: ComplexFunction

end LMLF.Blueprint.Elementary.Section41
