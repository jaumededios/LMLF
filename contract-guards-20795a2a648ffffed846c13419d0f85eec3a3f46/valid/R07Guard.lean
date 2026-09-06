import LMLFTest.Integral.Improper.IMP001Regressions

open Filter MeasureTheory Set
open scoped Interval

noncomputable section

namespace ContractGuard.ValidR07

open LMLF.Integral
open LMLFTest.Integral.Improper.IMP001Regressions

variable {E : Type*}
  [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]

example {f : ℝ → E} {k : ℝ} {I : E}
    (hInt : ∀ {b : ℝ}, k ≤ b → IntervalIntegrable f volume k b)
    (hLim : Tendsto (fun b => ∫ t in k..b, f t) atTop (nhds I)) :
    HasImproperIntegralAtTopExcept f k ∅ I :=
  r07_empty_set_positive_control hInt hLim

example {_f : ℝ → E} {_k : ℝ} {_I : E}
    (_hLim : Tendsto (fun b => ∫ t in _k..b, _f t) atTop (nhds _I)) : True := by
  fail_if_success
    have hbad : HasImproperIntegralAtTopExcept _f _k ∅ _I :=
      r02_empty_exceptional_set_iff.mpr _hLim
  trivial

end ContractGuard.ValidR07
