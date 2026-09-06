import LMLF.Integral.Improper.Basic

/-!
Disposable signature-sensitivity mutant only. The axiom below is not
mathematical evidence and is never imported by the candidate.
-/

open MeasureTheory Set

noncomputable section

namespace LMLF.Integral

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

axiom HasImproperIntegralAtTopExcept.of_integrableOn_Ioi
    [CompleteSpace E] (f : ℝ → E) (k : ℝ) (S : Finset ℝ)
    (hS : ∀ c ∈ S, k < c) :
    HasImproperIntegralAtTopExcept f k S (∫ t in Ioi k, f t)

end LMLF.Integral
