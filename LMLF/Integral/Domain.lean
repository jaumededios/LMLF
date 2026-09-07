import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.MeasureTheory.Constructions.Pi
import Mathlib.MeasureTheory.Measure.Lebesgue.Basic
import Mathlib.MeasureTheory.Integral.IntegrableOn

/-!
# Typed finite-dimensional integration domains

The domain object keeps the coordinate dimension, carrier, volume measure, and
integrability predicate together.  Special-function chapters can then name
their domains and integrands without repeating measure plumbing.
-/

open MeasureTheory Set

noncomputable section

namespace LMLF.Integral

/-- DLMF 5.14.1--5.14.7: a measurable region in `Fin n → ℝ`.

The carrier is intentionally explicit; formulas cannot silently change the
ambient dimension or the restricted volume measure. -/
-- ANCHOR: MultidimensionalDomain
structure MultidimensionalDomain (n : ℕ) where
  carrier : Set (Fin n → ℝ)
-- ANCHOR_END: MultidimensionalDomain

/-- DLMF 5.14.1--5.14.7: the volume integral over a typed domain. -/
-- ANCHOR: domainIntegral
noncomputable def domainIntegral {n : ℕ} (D : MultidimensionalDomain n)
    (f : (Fin n → ℝ) → ℝ) : ℝ :=
  ∫ t in D.carrier, f t
-- ANCHOR_END: domainIntegral

/-- DLMF 5.14.1--5.14.7: Bochner integrability over a typed domain. -/
-- ANCHOR: domainIntegrable
def domainIntegrable {n : ℕ} (D : MultidimensionalDomain n)
    (f : (Fin n → ℝ) → ℝ) : Prop :=
  IntegrableOn f D.carrier volume
-- ANCHOR_END: domainIntegrable

end LMLF.Integral
