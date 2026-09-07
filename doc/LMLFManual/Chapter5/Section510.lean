import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section510
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§5.10 Continued Fractions" =>
%%%
tag := "chapter-5-section-10"
%%%

This page covers the two numbered source records in [DLMF §5.10](https://dlmf.nist.gov/5.10).
Finite continued-fraction convergents make the limiting interpretation explicit.  The
5.10.1 declaration is the positive-real specialization of the source statement: for
complex `z`, DLMF uses the general logarithm `Ln Γ(z)`, whereas the Lean statement uses
`Real.log (Real.Gamma x)` for `x > 0`.
DLMF 5.10.2 displays only `a₀` through `a₆` and refers to external tables for later
coefficients.  The Lean page therefore states existence of a full sequence with the
displayed initial values and the DLMF limit, then chooses that sequence explicitly; the
later coefficients are not presented as if they were printed in this section.

::::dlmfEntry "5.10.1" "https://dlmf.nist.gov/5.10.E1"
For $`\Re z>0`,
$$`\operatorname{Ln}\Gamma(z)+z-\left(z-\tfrac12\right)\ln z-	frac12\ln(2\pi)
 = \cfrac{a_0}{z+\cfrac{a_1}{z+\cfrac{a_2}{z+\cfrac{a_3}{z+\cfrac{a_4}{z+\cfrac{a_5}{z+}}}}}}\cdots.`

The right side is read as the limit of its finite convergents.  `continuedFractionTail`
and `continuedFractionConvergent` expose that construction directly.  The Lean theorem
uses `x > 0`, so both logarithms are the ordinary real logarithm and the resulting value
is embedded into `ℂ`; this is a specialization, not a claim that the principal complex
logarithm reproduces DLMF's general branch.  The existential source assertion below
supplies the full coefficient sequence, including the later entries referred to by the
source tables, and records its convergence to the displayed value.

:::leanStatement "Lean statement · finite convergents"
```anchor continuedFractionTail (module := LMLF.Blueprint.Gamma.Section510) -showProofStates
noncomputable def continuedFractionTail (coeff : ℕ → ℂ) (z : ℂ) (offset : ℕ) : ℕ → ℂ
  | 0 => 0
  | n + 1 => coeff offset / (z + continuedFractionTail coeff z (offset + 1) n)
```

```anchor continuedFractionConvergent (module := LMLF.Blueprint.Gamma.Section510) -showProofStates
noncomputable def continuedFractionConvergent (coeff : ℕ → ℂ) (z : ℂ) (n : ℕ) : ℂ :=
  continuedFractionTail coeff z 0 (n + 1)
```

```anchor exists_gammaContinuedFractionCoeff (module := LMLF.Blueprint.Gamma.Section510) -showProofStates
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
```

```anchor gammaContinuedFractionCoeff (module := LMLF.Blueprint.Gamma.Section510) -showProofStates
noncomputable def gammaContinuedFractionCoeff : ℕ → ℂ :=
  Classical.choose exists_gammaContinuedFractionCoeff
```

```anchor gammaContinuedFractionCoeff_spec (module := LMLF.Blueprint.Gamma.Section510) -showProofStates
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
```

```anchor dlmf_5_10_1 (module := LMLF.Blueprint.Gamma.Section510) -showProofStates
theorem dlmf_5_10_1 {x : ℝ} (hx : 0 < x) :
    Tendsto (continuedFractionConvergent gammaContinuedFractionCoeff (x : ℂ)) atTop
      (nhds
        ((Real.log (Real.Gamma x) + x - (x - 1 / 2) * Real.log x -
          Real.log (2 * Real.pi) / 2 : ℝ) : ℂ))
```
:::
::::

::::dlmfEntry "5.10.2" "https://dlmf.nist.gov/5.10.E2"
The first coefficients in the continued fraction are
$$`a_0=\frac1{12},\quad a_1=\frac1{30},\quad a_2=\frac{53}{210},\quad
a_3=\frac{195}{371},\quad a_4=\frac{22999}{22737},\quad
a_5=\frac{29944523}{19733142},\quad
a_6=\frac{109535241009}{48264275462}.`

These seven equalities are one grouped source record in DLMF.  The selected full sequence
`gammaContinuedFractionCoeff` has exactly these initial values by the choose-spec above;
its later values are supplied existentially because §5.10 itself refers to external
tables rather than printing them.

:::leanStatement "Lean statement · coefficient record"
```anchor dlmf_5_10_2 (module := LMLF.Blueprint.Gamma.Section510) -showProofStates
theorem dlmf_5_10_2 :
    gammaContinuedFractionCoeff 0 = (1 / 12 : ℂ) ∧
      gammaContinuedFractionCoeff 1 = (1 / 30 : ℂ) ∧
      gammaContinuedFractionCoeff 2 = (53 / 210 : ℂ) ∧
      gammaContinuedFractionCoeff 3 = (195 / 371 : ℂ) ∧
      gammaContinuedFractionCoeff 4 = (22999 / 22737 : ℂ) ∧
      gammaContinuedFractionCoeff 5 = (29944523 / 19733142 : ℂ) ∧
      gammaContinuedFractionCoeff 6 = (109535241009 / 48264275462 : ℂ)
```
:::
::::
