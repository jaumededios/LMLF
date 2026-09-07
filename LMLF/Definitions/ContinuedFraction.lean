import Mathlib.RingTheory.PowerSeries.Inverse

/-!
# Continued fractions and coefficient extraction

Reusable syntax for finite continued fractions, together with the coefficient
algorithm for normalized continued fractions of odd asymptotic series.
-/

open scoped PowerSeries

namespace LMLF

/-- Evaluate a finite continued-fraction tail beginning at `offset`.

The denominator and numerator streams are kept separate. This supports the
constant-denominator fractions in DLMF 5.10 without baking that specialization
into the general definition.
-/
-- ANCHOR: continuedFractionFrom
def continuedFractionFrom {K : Type*} [DivisionRing K]
    (denominator numerator : ℕ → K) (offset : ℕ) : ℕ → K
  | 0 => 0
  | depth + 1 =>
      numerator offset /
        (denominator offset +
          continuedFractionFrom denominator numerator (offset + 1) depth)
-- ANCHOR_END: continuedFractionFrom

/-- Evaluate a finite continued fraction.

The usual fraction starts at coefficient zero. Pass `(offset := k)` only when
an actual tail beginning at `k` is wanted.
-/
-- ANCHOR: continuedFraction
def continuedFraction {K : Type*} [DivisionRing K]
    (denominator numerator : ℕ → K) (depth : ℕ) (offset : ℕ := 0) : K :=
  continuedFractionFrom denominator numerator offset depth
-- ANCHOR_END: continuedFraction

/-- The `n`th convergent retains numerator coefficients
`offset, …, offset + n`; at the default offset these are `0, …, n`. -/
-- ANCHOR: continuedFractionConvergent
def continuedFractionConvergent {K : Type*} [DivisionRing K]
    (denominator numerator : ℕ → K) (n : ℕ) (offset : ℕ := 0) : K :=
  continuedFraction denominator numerator (n + 1) (offset := offset)
-- ANCHOR_END: continuedFractionConvergent

/-- Coefficients of an odd asymptotic germ
`z⁻¹ (s 0 + s 1 z⁻² + s 2 z⁻⁴ + ⋯)` at infinity. -/
abbrev OddAsymptoticSeries := ℕ → ℚ

/-- Coefficients of `s(0) / S`, where `S` has coefficient stream `s`.

The recurrence is triangular: output coefficient `n` reads only input
coefficients through `n`. It is therefore executable over `ℚ`.
-/
-- ANCHOR: normalizedReciprocalCoeff
def normalizedReciprocalCoeff (s : OddAsymptoticSeries) : ℕ → ℚ
  | 0 => 1
  | n + 1 =>
      if s 0 = 0 then 0
      else
        -(∑ i ∈ Finset.range (n + 1),
            s (i + 1) * normalizedReciprocalCoeff s (n - i)) / s 0
termination_by n => n
decreasing_by omega
-- ANCHOR_END: normalizedReciprocalCoeff

/-- One step of the normalized continued-fraction coefficient algorithm.

If `S(x) = a / (1 + x T(x))`, this returns the coefficient stream of `T`.
-/
-- ANCHOR: cfracStep
def cfracStep (s : OddAsymptoticSeries) : OddAsymptoticSeries :=
  fun n => normalizedReciprocalCoeff s (n + 1)
-- ANCHOR_END: cfracStep

/-- The residual series after extracting the first `k` numerators. -/
-- ANCHOR: cfracRemainder
def cfracRemainder (s : OddAsymptoticSeries) : ℕ → OddAsymptoticSeries
  | 0 => s
  | k + 1 => cfracStep (cfracRemainder s k)
-- ANCHOR_END: cfracRemainder

/-- The raw numerator found after `k` triangular extraction steps. -/
-- ANCHOR: cfracCoeffRaw
def cfracCoeffRaw (s : OddAsymptoticSeries) (k : ℕ) : ℚ :=
  cfracRemainder s k 0
-- ANCHOR_END: cfracCoeffRaw

/-- The extraction is regular if a zero next numerator occurs only when the
whole residual series is already zero. -/
-- ANCHOR: CFracRegular
def CFracRegular (s : OddAsymptoticSeries) : Prop :=
  ∀ k, cfracCoeffRaw s k = 0 → cfracRemainder s k = 0
-- ANCHOR_END: CFracRegular

/-- A coefficient stream is zero-terminated if a zero numerator ends the
continued fraction: every later numerator is zero as well. -/
-- ANCHOR: ZeroTerminated
def ZeroTerminated {K : Type} [Zero K] (a : ℕ → K) : Prop :=
  ∀ k, a k = 0 → ∀ j, k ≤ j → a j = 0
-- ANCHOR_END: ZeroTerminated

/-- Normalized continued-fraction coefficient streams. The termination
convention is part of the type, so uniqueness theorems cannot forget it. -/
-- ANCHOR: CFCoefficients
abbrev CFCoefficients (K : Type := ℚ) [Zero K] :=
  {a : ℕ → K // ZeroTerminated a}
-- ANCHOR_END: CFCoefficients

instance {K : Type} [Zero K] : CoeFun (CFCoefficients K) (fun _ => ℕ → K) :=
  ⟨fun a => a.1⟩

/-- Once a normalized numerator is zero, any later numerator is zero. -/
-- ANCHOR: CFCoefficients.eq_zero_of_le
theorem CFCoefficients.eq_zero_of_le {K : Type} [Zero K]
    (a : CFCoefficients K) {k j : ℕ} (hk : a k = 0) (hkj : k ≤ j) :
    a j = 0 :=
  a.property k hk j hkj
-- ANCHOR_END: CFCoefficients.eq_zero_of_le

/-- Canonicalize the raw algorithm by setting the current and all later
coefficients to zero as soon as a zero numerator is encountered. -/
-- ANCHOR: cfracCoeffValue
def cfracCoeffValue (s : OddAsymptoticSeries) (k : ℕ) : ℚ :=
  if ∃ j ≤ k, cfracCoeffRaw s j = 0 then 0 else cfracCoeffRaw s k
-- ANCHOR_END: cfracCoeffValue

/-- Canonicalization makes the extracted stream zero-terminated. -/
-- ANCHOR: cfracCoeffValue_zeroTerminated
theorem cfracCoeffValue_zeroTerminated (s : OddAsymptoticSeries) :
    ZeroTerminated (cfracCoeffValue s)
-- ANCHOR_END: cfracCoeffValue_zeroTerminated
:= by
  sorry

/-- Canonical normalized continued-fraction coefficients of an odd asymptotic
series. This is an executable map from rational asymptotic coefficients to a
zero-terminated coefficient stream. -/
-- ANCHOR: cfracCoeff
def cfracCoeff (s : OddAsymptoticSeries) : CFCoefficients :=
  ⟨cfracCoeffValue s, cfracCoeffValue_zeroTerminated s⟩
-- ANCHOR_END: cfracCoeff

/-- A finite normalized continued fraction as a formal power series in `x`.
It represents the odd function of `z` after the substitution `x = z⁻²` and
multiplication by `z⁻¹`.
-/
noncomputable def formalContinuedFractionFrom
    (a : CFCoefficients) (offset : ℕ) : ℕ → ℚ⟦X⟧
  | 0 => 0
  | depth + 1 =>
      PowerSeries.C (a offset) *
        (1 + PowerSeries.X *
          formalContinuedFractionFrom a (offset + 1) depth)⁻¹

/-- The finite normalized formal continued fraction, with optional offset. -/
noncomputable def formalContinuedFractionConvergent
    (a : CFCoefficients) (depth : ℕ) (offset : ℕ := 0) : ℚ⟦X⟧ :=
  formalContinuedFractionFrom a offset depth

/-- The formal continued fraction whose coefficient of degree `n` is read
from the depth-`n + 1` convergent, where that coefficient has stabilized. -/
-- ANCHOR: formalContinuedFraction
noncomputable def formalContinuedFraction (a : CFCoefficients) : ℚ⟦X⟧ :=
  PowerSeries.mk fun n =>
    PowerSeries.coeff n (formalContinuedFractionConvergent a (n + 1))
-- ANCHOR_END: formalContinuedFraction

/-- A regular odd asymptotic series is reconstructed by its canonical
continued-fraction coefficients. -/
-- ANCHOR: formalContinuedFraction_cfracCoeff
theorem formalContinuedFraction_cfracCoeff
    (s : OddAsymptoticSeries) (hs : CFracRegular s) :
    formalContinuedFraction (cfracCoeff s) = PowerSeries.mk s
-- ANCHOR_END: formalContinuedFraction_cfracCoeff
:= by
  sorry

/-- Uniqueness of normalized continued-fraction coefficients. Regularity and
normalization are essential: after a zero numerator, an unnormalized tail is
invisible in the value of the fraction. -/
-- ANCHOR: cfracCoeff_unique
theorem cfracCoeff_unique
    (s : OddAsymptoticSeries) (a : CFCoefficients)
    (hs : CFracRegular s)
    (h : formalContinuedFraction a = PowerSeries.mk s) :
    a = cfracCoeff s
-- ANCHOR_END: cfracCoeff_unique
:= by
  sorry

/-- The `k`th continued-fraction numerator depends on only the first `k + 1`
coefficients of the asymptotic series. This is the finite-prefix theorem behind
computation of any requested numerator. -/
-- ANCHOR: cfracCoeff_congr_prefix
theorem cfracCoeff_congr_prefix
    (s t : OddAsymptoticSeries) (k : ℕ)
    (h : ∀ n ≤ k, s n = t n) :
    cfracCoeff s k = cfracCoeff t k
-- ANCHOR_END: cfracCoeff_congr_prefix
:= by
  sorry

end LMLF
