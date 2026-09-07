import Mathlib.Analysis.SpecialFunctions.Gamma.Basic

/-!
# DLMF 5.10: continued fractions

The continued fraction is represented by finite convergents, so its limiting meaning is
visible in Lean.  DLMF 5.10.2 records only the first seven coefficients in one grouped
display and points to external tables for the later ones.  We therefore state the source
claim as the existence of a full coefficient sequence with the displayed initial values
and the DLMF limit, then choose that sequence for the reader-facing declarations.
-/

open Filter

namespace LMLF.Blueprint.Gamma.Section510

/-- The finite tail of a continued fraction with constant denominator `z`.

The depth-zero tail is the empty tail, and a successor depth adds the coefficient at
`offset` above the denominator `z` and the next tail.  This is the local vocabulary used
to expose the finite convergents in DLMF 5.10.1.
-/
-- ANCHOR: continuedFractionTail
noncomputable def continuedFractionTail (coeff : ℕ → ℂ) (z : ℂ) (offset : ℕ) : ℕ → ℂ
  | 0 => 0
  | n + 1 => coeff offset / (z + continuedFractionTail coeff z (offset + 1) n)
-- ANCHOR_END: continuedFractionTail

/-- The depth-`n` convergent of `a₀/(z + a₁/(z + ⋯))`.

Depth `n` uses the first `n + 1` coefficients, with the final denominator `z` visible
in the recursive definition of `continuedFractionTail`.
-/
-- ANCHOR: continuedFractionConvergent
noncomputable def continuedFractionConvergent (coeff : ℕ → ℂ) (z : ℂ) (n : ℕ) : ℂ :=
  continuedFractionTail coeff z 0 (n + 1)
-- ANCHOR_END: continuedFractionConvergent

/--
DLMF 5.10.1–5.10.2, specialized to positive real arguments.

The source displays the first seven coefficients and refers to external tables for the
rest.  This existential states that a full source sequence has those seven values and
that its finite convergents have the DLMF limit.
-/
-- DLMF 5.10.1, 5.10.2 https://dlmf.nist.gov/5.10.E1 https://dlmf.nist.gov/5.10.E2
-- ANCHOR: exists_gammaContinuedFractionCoeff
theorem exists_gammaContinuedFractionCoeff :
    ∃ coeff : ℕ → ℂ,
      (coeff 0 = (1 / 12 : ℂ) ∧
        coeff 1 = (1 / 30 : ℂ) ∧
          coeff 2 = (53 / 210 : ℂ) ∧
            coeff 3 = (195 / 371 : ℂ) ∧
              coeff 4 = (22999 / 22737 : ℂ) ∧
                coeff 5 = (29944523 / 19733142 : ℂ) ∧
                  coeff 6 = (109535241009 / 48264275462 : ℂ)) ∧
        ∀ x : ℝ, 0 < x →
          Tendsto (continuedFractionConvergent coeff (x : ℂ)) atTop
            (nhds
              ((Real.log (Real.Gamma x) + x - (x - 1 / 2) * Real.log x -
                Real.log (2 * Real.pi) / 2 : ℝ) : ℂ))
-- ANCHOR_END: exists_gammaContinuedFractionCoeff
:= by sorry

/-- The full DLMF coefficient sequence selected from the existence assertion above. -/
-- DLMF 5.10.1, 5.10.2 https://dlmf.nist.gov/5.10.E1 https://dlmf.nist.gov/5.10.E2
-- ANCHOR: gammaContinuedFractionCoeff
noncomputable def gammaContinuedFractionCoeff : ℕ → ℂ :=
  Classical.choose exists_gammaContinuedFractionCoeff
-- ANCHOR_END: gammaContinuedFractionCoeff

/-- The displayed coefficients and convergence property of the selected DLMF sequence. -/
-- DLMF 5.10.1, 5.10.2 https://dlmf.nist.gov/5.10.E1 https://dlmf.nist.gov/5.10.E2
-- ANCHOR: gammaContinuedFractionCoeff_spec
theorem gammaContinuedFractionCoeff_spec :
    (gammaContinuedFractionCoeff 0 = (1 / 12 : ℂ) ∧
      gammaContinuedFractionCoeff 1 = (1 / 30 : ℂ) ∧
        gammaContinuedFractionCoeff 2 = (53 / 210 : ℂ) ∧
          gammaContinuedFractionCoeff 3 = (195 / 371 : ℂ) ∧
            gammaContinuedFractionCoeff 4 = (22999 / 22737 : ℂ) ∧
              gammaContinuedFractionCoeff 5 = (29944523 / 19733142 : ℂ) ∧
                gammaContinuedFractionCoeff 6 = (109535241009 / 48264275462 : ℂ)) ∧
      ∀ x : ℝ, 0 < x →
        Tendsto (continuedFractionConvergent gammaContinuedFractionCoeff (x : ℂ)) atTop
          (nhds
            ((Real.log (Real.Gamma x) + x - (x - 1 / 2) * Real.log x -
              Real.log (2 * Real.pi) / 2 : ℝ) : ℂ))
-- ANCHOR_END: gammaContinuedFractionCoeff_spec
:= by
  simpa [gammaContinuedFractionCoeff] using
    (Classical.choose_spec exists_gammaContinuedFractionCoeff)

/--
DLMF 5.10.1, specialized to positive real `x` to make the logarithm branch explicit.

Because DLMF 5.10.2 displays only `a₀` through `a₆`, the full source sequence is the
one selected by `gammaContinuedFractionCoeff` from the existence assertion, rather than
an opaque stream with unconstrained later values.
-/
-- DLMF 5.10.1 https://dlmf.nist.gov/5.10.E1
-- ANCHOR: dlmf_5_10_1
theorem dlmf_5_10_1 {x : ℝ} (hx : 0 < x) :
    Tendsto (continuedFractionConvergent gammaContinuedFractionCoeff (x : ℂ)) atTop
      (nhds
        ((Real.log (Real.Gamma x) + x - (x - 1 / 2) * Real.log x -
          Real.log (2 * Real.pi) / 2 : ℝ) : ℂ))
-- ANCHOR_END: dlmf_5_10_1
:= by exact gammaContinuedFractionCoeff_spec.2 x hx

/-- DLMF 5.10.2.  The first seven continued-fraction coefficients, as one source record. -/
-- DLMF 5.10.2 https://dlmf.nist.gov/5.10.E2
-- ANCHOR: dlmf_5_10_2
theorem dlmf_5_10_2 :
    gammaContinuedFractionCoeff 0 = (1 / 12 : ℂ) ∧
      gammaContinuedFractionCoeff 1 = (1 / 30 : ℂ) ∧
      gammaContinuedFractionCoeff 2 = (53 / 210 : ℂ) ∧
      gammaContinuedFractionCoeff 3 = (195 / 371 : ℂ) ∧
      gammaContinuedFractionCoeff 4 = (22999 / 22737 : ℂ) ∧
      gammaContinuedFractionCoeff 5 = (29944523 / 19733142 : ℂ) ∧
      gammaContinuedFractionCoeff 6 = (109535241009 / 48264275462 : ℂ)
-- ANCHOR_END: dlmf_5_10_2
:= by exact gammaContinuedFractionCoeff_spec.1

end LMLF.Blueprint.Gamma.Section510
