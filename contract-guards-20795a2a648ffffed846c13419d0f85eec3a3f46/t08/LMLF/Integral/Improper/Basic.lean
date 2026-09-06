import Mathlib.Data.Finset.Sort
import Mathlib.MeasureTheory.Integral.DominatedConvergence

/-!
Disposable signature-sensitivity mutant only. These axioms are type-level
mocks, are not mathematical evidence, and are never imported by the candidate.
-/

open Filter

namespace LMLF.Integral

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

axiom HasImproperIntegralAtTopExcept
    [CompleteSpace E] (f : ℝ → E) (k : ℝ) (S : Finset ℝ) (I : E) : Prop

axiom IsFiniteExceptionalPrimitive
    [CompleteSpace E] (g : ℝ → E) (k : ℝ) (S : Finset ℝ) (F : ℝ → E) : Prop

axiom hasImproperIntegralAtTopExcept_iff_exists_primitive
    [CompleteSpace E] {f F : ℝ → E} {k : ℝ} {S : Finset ℝ} {I : E} :
    HasImproperIntegralAtTopExcept f k S I ↔
      IsFiniteExceptionalPrimitive f k S F ∧ Tendsto F atTop (nhds I)

end LMLF.Integral
