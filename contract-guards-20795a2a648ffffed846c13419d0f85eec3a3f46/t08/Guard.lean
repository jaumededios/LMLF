import LMLF.Integral.Improper.Basic

open Filter

noncomputable section

open LMLF.Integral

variable {E : Type*}
  [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]

example (_f _F : ℝ → E) (_k : ℝ) (_S : Finset ℝ) (_I : E) : True := by
  fail_if_success
    have hbad :
      HasImproperIntegralAtTopExcept _f _k _S _I ↔
        IsFiniteExceptionalPrimitive _f _k _S _F ∧ Tendsto _F atTop (nhds _I) :=
      hasImproperIntegralAtTopExcept_iff_exists_primitive
  trivial
