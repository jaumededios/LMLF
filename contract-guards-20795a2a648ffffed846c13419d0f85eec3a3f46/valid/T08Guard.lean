import LMLF.Integral.Improper.Basic

open Filter MeasureTheory Set

noncomputable section

namespace ContractGuard.ValidT08

open LMLF.Integral

variable {E : Type*}
  [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]

example {f F : ℝ → E} {k : ℝ} {S : Finset ℝ} {I : E}
    (hF : IsFiniteExceptionalPrimitive f k S F)
    (hLim : Tendsto F atTop (nhds I)) :
    HasImproperIntegralAtTopExcept f k S I :=
  hasImproperIntegralAtTopExcept_iff_exists_primitive.mpr ⟨F, hF, hLim⟩

example (_f _F : ℝ → E) (_k : ℝ) (_S : Finset ℝ) (_I : E) : True := by
  fail_if_success
    have hbad :
      HasImproperIntegralAtTopExcept _f _k _S _I ↔
        IsFiniteExceptionalPrimitive _f _k _S _F ∧ Tendsto _F atTop (nhds _I) :=
      hasImproperIntegralAtTopExcept_iff_exists_primitive
  trivial

end ContractGuard.ValidT08
