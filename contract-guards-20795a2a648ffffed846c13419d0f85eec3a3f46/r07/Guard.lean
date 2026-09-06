import LMLFTest.Integral.Improper.IMP001Regressions

open Filter MeasureTheory Set
open scoped Interval

noncomputable section

open LMLF.Integral
open LMLFTest.Integral.Improper.IMP001Regressions

variable {E : Type*}
  [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]

example {_f : ℝ → E} {_k : ℝ} {_I : E}
    (_hLim : Tendsto (fun b => ∫ t in _k..b, _f t) atTop (nhds _I)) : True := by
  fail_if_success
    have hbad : HasImproperIntegralAtTopExcept _f _k ∅ _I :=
      r02_empty_exceptional_set_iff.mpr _hLim
  trivial
