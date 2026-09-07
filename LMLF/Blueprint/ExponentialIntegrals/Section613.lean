import Mathlib.Analysis.Asymptotics.AsymptoticEquivalent
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Series
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import LMLF.Quantitative.Series
import LMLF.Blueprint.ExponentialIntegrals.Section62

noncomputable section
open scoped BigOperators Topology
open Filter Asymptotics
namespace LMLF.Blueprint.ExponentialIntegrals.Section613

open LMLF.Blueprint.ExponentialIntegrals.Section62

/-! DLMF §6.13 uses the named exponential, sine, and cosine integrals from
§6.2.  The zero families below therefore refer to those canonical objects,
rather than to an unconstrained function supplied by a theorem caller. -/

/- DLMF 6.13.1: a positive zero of the canonical §6.2 realEi map. -/
-- ANCHOR: EiZero
def EiZero (x : ℝ) : Prop := 0 < x ∧ realEi x = 0
-- ANCHOR_END: EiZero

/- DLMF 6.13.2: positive real zeros of Ci and lower-case si = Si - π/2. -/
-- ANCHOR: ciRealZero
def ciRealZero (x : ℝ) : Prop :=
  0 < x ∧ principalCiPositive x = 0
-- ANCHOR_END: ciRealZero

-- ANCHOR: siRealZero
def siRealZero (x : ℝ) : Prop :=
  0 < x ∧ principalSi (x : ℂ) - (Real.pi / 2 : ℂ) = 0
-- ANCHOR_END: siRealZero

/- DLMF 6.13.2: an ascending, indexed family of positive zeros. -/
-- ANCHOR: PositiveZeroFamily
structure PositiveZeroFamily (zero : ℝ → Prop) where
  value : ℕ → ℝ
  positive : ∀ k, 0 < value k
  vanishes : ∀ k, zero (value k)
  ascending : StrictMono value
  complete : ∀ x, zero x → ∃ k, value k = x
-- ANCHOR_END: PositiveZeroFamily

/- DLMF 6.13.2: the four correction coefficients explicitly displayed in the
formula.  The source uses an ellipsis after these values; it does not give a
canonical all-orders coefficient sequence on this page. -/
-- ANCHOR: six13DisplayedCoefficient
def six13DisplayedCoefficient (n : Fin 4) : ℝ :=
  if n = 0 then 1
  else if n = 1 then -(16 / 3)
  else if n = 2 then 1673 / 15
  else -(507746 / 105)
-- ANCHOR_END: six13DisplayedCoefficient

/- DLMF 6.13.2: a term in the displayed finite prefix, including the leading
parameter at index zero. -/
-- ANCHOR: six13DisplayedTerm
def six13DisplayedTerm (n : Fin 5) (α : ℕ → ℝ) (k : ℕ) : ℝ :=
  if _hn : n.val = 0 then
    α k
  else
    let j : Fin 4 := ⟨n.val - 1, by omega⟩
    six13DisplayedCoefficient j / α k ^ (2 * j.val + 1)
-- ANCHOR_END: six13DisplayedTerm

/- DLMF 6.13.2: the finite truncation containing the first `n + 1`
displayed terms. -/
-- ANCHOR: six13DisplayedPartial
def six13DisplayedPartial (n : Fin 5) (α : ℕ → ℝ) (k : ℕ) : ℝ :=
  ∑ j ∈ Finset.Iic n, six13DisplayedTerm j α k
-- ANCHOR_END: six13DisplayedPartial

/- DLMF 6.13.2: the displayed finite prefix is a Poincaré expansion in the
finite-prefix sense.  This avoids selecting arbitrary coefficients hidden by
the source's ellipsis. -/
-- ANCHOR: HasSix13DisplayedExpansion
def HasSix13DisplayedExpansion (zeros α : ℕ → ℝ) : Prop :=
  ∀ n : Fin 5,
    (fun k => zeros k - six13DisplayedPartial n α k) =o[atTop]
      (fun k => six13DisplayedTerm n α k)
-- ANCHOR_END: HasSix13DisplayedExpansion

/- DLMF 6.13.2: the coefficient sequence represented by the source's
ellipsis.  Its first four entries are fixed by the displayed formula; the
later entries are intentionally left as data rather than guessed. -/
-- ANCHOR: Six13CoefficientContinuation
structure Six13CoefficientContinuation where
  value : ℕ → ℝ
  displayed_prefix : ∀ n : Fin 4, value n.val = six13DisplayedCoefficient n
-- ANCHOR_END: Six13CoefficientContinuation

/- DLMF 6.13.2: an all-orders term, with the leading phase at index zero. -/
-- ANCHOR: six13ContinuationTerm
def six13ContinuationTerm (coeff : Six13CoefficientContinuation)
    (α : ℕ → ℝ) (n k : ℕ) : ℝ :=
  match n with
  | 0 => α k
  | j + 1 => coeff.value j / α k ^ (2 * j + 1)
-- ANCHOR_END: six13ContinuationTerm

/- DLMF 6.13.2: the all-orders Poincaré expansion denoted by the ellipsis. -/
-- ANCHOR: HasSix13AllOrdersExpansion
def HasSix13AllOrdersExpansion
    (zeros α : ℕ → ℝ) (coeff : Six13CoefficientContinuation) : Prop :=
  QuantitativeAnalysis.HasPoincareExpansion atTop (fun k => zeros k)
    (six13ContinuationTerm coeff α)
-- ANCHOR_END: HasSix13AllOrdersExpansion

/- DLMF 6.13.2: the all-orders finite truncation used by the next-term bound. -/
-- ANCHOR: six13ContinuationPartial
def six13ContinuationPartial (coeff : Six13CoefficientContinuation)
    (α : ℕ → ℝ) (n k : ℕ) : ℝ :=
  α k + ∑ j ∈ Finset.range n, coeff.value j / α k ^ (2 * j + 1)
-- ANCHOR_END: six13ContinuationPartial

/- DLMF 6.13.2: the quantitative next-term and same-sign remainder assertion.
The condition `1 ≤ k` excludes the singular phase `α = 0` at `c₀`. -/
-- ANCHOR: HasSix13AllOrdersRemainderBound
def HasSix13AllOrdersRemainderBound
    (zeros α : ℕ → ℝ) (coeff : Six13CoefficientContinuation) : Prop :=
  ∀ n k : ℕ, 1 ≤ k →
    let remainder := zeros k - six13ContinuationPartial coeff α n k
    let nextTerm := six13ContinuationTerm coeff α (n + 1) k
    |remainder| ≤ |nextTerm| ∧ 0 ≤ remainder * nextTerm
-- ANCHOR_END: HasSix13AllOrdersRemainderBound

/- DLMF 6.13.2: the displayed next-term estimate, restricted to the four
truncations for which the successor is also printed. -/
-- ANCHOR: six13DisplayedRetainedIndex
/-- DLMF 6.13.2: the displayed retained-term index. -/
def six13DisplayedRetainedIndex (n : Fin 4) : Fin 5 :=
  ⟨n.val, by omega⟩

-- ANCHOR_END: six13DisplayedRetainedIndex
-- ANCHOR: six13DisplayedNextIndex
/-- DLMF 6.13.2: the next displayed-term index. -/
def six13DisplayedNextIndex (n : Fin 4) : Fin 5 :=
  ⟨n.val + 1, by omega⟩
-- ANCHOR_END: six13DisplayedNextIndex

-- ANCHOR: HasSix13DisplayedRemainderBound
/-- DLMF 6.13.2: the quantitative next-term bound for the displayed prefix. -/
def HasSix13DisplayedRemainderBound (zeros α : ℕ → ℝ) : Prop :=
  ∀ n : Fin 4, ∀ k : ℕ, 1 ≤ k →
    let remainder := zeros k - six13DisplayedPartial (six13DisplayedRetainedIndex n) α k
    let nextTerm := six13DisplayedTerm (six13DisplayedNextIndex n) α k
    |remainder| ≤ |nextTerm| ∧ 0 ≤ remainder * nextTerm
-- ANCHOR_END: HasSix13DisplayedRemainderBound

/- DLMF 6.13.2: the two phase parameters in the zero expansions. -/
-- ANCHOR: ciZeroAlpha
def ciZeroAlpha (k : ℕ) : ℝ := (k : ℝ) * Real.pi
-- ANCHOR_END: ciZeroAlpha

-- ANCHOR: siZeroAlpha
def siZeroAlpha (k : ℕ) : ℝ := ((k : ℝ) + 1 / 2) * Real.pi
-- ANCHOR_END: siZeroAlpha

/- DLMF 6.13.2: one common coefficient continuation together with the two
all-orders expansion laws displayed for the Ci and si zero families. -/
-- ANCHOR: Six13AsymptoticData
structure Six13AsymptoticData
    (c : PositiveZeroFamily ciRealZero) (s : PositiveZeroFamily siRealZero) where
  coeff : Six13CoefficientContinuation
  c_expansion : HasSix13AllOrdersExpansion c.value ciZeroAlpha coeff
  s_expansion : HasSix13AllOrdersExpansion s.value siZeroAlpha coeff
-- ANCHOR_END: Six13AsymptoticData

/- DLMF 6.13.1 -/
-- ANCHOR: dlmf_6_13_1
theorem dlmf_6_13_1 :
    ∃! x₀ : ℝ, EiZero x₀
-- ANCHOR_END: dlmf_6_13_1
  := by sorry

/- DLMF 6.13.1: a reusable enclosure for the displayed decimal. -/
-- ANCHOR: dlmf_6_13_1_approx
theorem dlmf_6_13_1_approx (x₀ : ℝ)
    (hzero : EiZero x₀) :
    |x₀ - 0.372507410781366634461991866580| < 1 / (10 : ℝ) ^ 30
-- ANCHOR_END: dlmf_6_13_1_approx
  := by sorry

/- DLMF 6.13.2: the finite displayed prefix is the primary reader-facing
result.  The arbitrary continuation below is retained only as auxiliary data
for an all-orders formulation of the source ellipsis. -/
-- ANCHOR: dlmf_6_13_2
theorem dlmf_6_13_2
    (c : PositiveZeroFamily ciRealZero) (s : PositiveZeroFamily siRealZero) :
    HasSix13DisplayedExpansion c.value ciZeroAlpha ∧
      HasSix13DisplayedExpansion s.value siZeroAlpha
-- ANCHOR_END: dlmf_6_13_2
  := by sorry

/- DLMF 6.13.2: arbitrary all-orders continuation, retained explicitly as an
auxiliary theorem because the source prints only a finite prefix and ellipsis. -/
-- ANCHOR: dlmf_6_13_2_all_orders_auxiliary
/-- DLMF 6.13.2: auxiliary existence of an all-orders continuation. -/
theorem dlmf_6_13_2_all_orders_auxiliary
    (c : PositiveZeroFamily ciRealZero) (s : PositiveZeroFamily siRealZero) :
    Nonempty (Six13AsymptoticData c s)
-- ANCHOR_END: dlmf_6_13_2_all_orders_auxiliary
  := by sorry

/- DLMF 6.13.2: quantitative companion to the displayed finite prefix. -/
-- ANCHOR: dlmf_6_13_2_remainder
theorem dlmf_6_13_2_remainder
    (c : PositiveZeroFamily ciRealZero) (s : PositiveZeroFamily siRealZero)
    : HasSix13DisplayedRemainderBound c.value ciZeroAlpha ∧
      HasSix13DisplayedRemainderBound s.value siZeroAlpha
-- ANCHOR_END: dlmf_6_13_2_remainder
  := by sorry

/- DLMF 6.13.2: auxiliary quantitative companion for a chosen all-orders
continuation. -/
-- ANCHOR: dlmf_6_13_2_all_orders_remainder_auxiliary
/-- DLMF 6.13.2: auxiliary all-orders remainder bound. -/
theorem dlmf_6_13_2_all_orders_remainder_auxiliary
    (c : PositiveZeroFamily ciRealZero) (s : PositiveZeroFamily siRealZero)
    (data : Six13AsymptoticData c s) :
    HasSix13AllOrdersRemainderBound c.value ciZeroAlpha data.coeff ∧
      HasSix13AllOrdersRemainderBound s.value siZeroAlpha data.coeff
-- ANCHOR_END: dlmf_6_13_2_all_orders_remainder_auxiliary
  := by sorry

end LMLF.Blueprint.ExponentialIntegrals.Section613
