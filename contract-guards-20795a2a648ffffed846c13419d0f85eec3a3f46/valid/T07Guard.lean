import LMLF.Integral.Improper.Bochner

open Filter MeasureTheory Set

noncomputable section

namespace ContractGuard.ValidT07

open LMLF.Integral

variable {E : Type*}
  [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]

example (f : ℝ → E) (k : ℝ) (S : Finset ℝ)
    (hS : ∀ c ∈ S, k < c) (hInt : IntegrableOn f (Ioi k)) :
    HasImproperIntegralAtTopExcept f k S (∫ t in Ioi k, f t) :=
  HasImproperIntegralAtTopExcept.of_integrableOn_Ioi f k S hS hInt

example (_f : ℝ → E) (k : ℝ) (S : Finset ℝ)
    (_hS : ∀ c ∈ S, k < c) : True := by
  fail_if_success
    have hbad : HasImproperIntegralAtTopExcept
        _f k S (∫ t in Ioi k, _f t) :=
      HasImproperIntegralAtTopExcept.of_integrableOn_Ioi _f k S _hS
  trivial

end ContractGuard.ValidT07
