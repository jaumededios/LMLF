import LMLF.Integral.Improper.Basic

/-!
Disposable signature-sensitivity mutant only. The axiom below weakens the
test characterization, is not mathematical evidence, and is never imported by
the candidate.
-/

open Filter MeasureTheory Set
open scoped Interval

noncomputable section

namespace LMLFTest.Integral.Improper.IMP001Regressions

open LMLF.Integral

variable {E : Type*}
  [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]

axiom r02_empty_exceptional_set_iff
    {f : ℝ → E} {k : ℝ} {I : E} :
    HasImproperIntegralAtTopExcept f k ∅ I ↔
      Tendsto (fun b => ∫ t in k..b, f t) atTop (nhds I)

end LMLFTest.Integral.Improper.IMP001Regressions
