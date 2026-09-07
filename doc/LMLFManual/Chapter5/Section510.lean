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

This page follows [DLMF §5.10](https://dlmf.nist.gov/5.10). The continued
fraction is normalized by taking every partial denominator to be `z`. Its
numerators are recovered canonically from the odd Stirling asymptotic series;
they are not selected from an existence statement.

::::dlmfEntry "5.10.1" "https://dlmf.nist.gov/5.10.E1"
For $`\Re z>0`,
$$`\operatorname{Ln}\Gamma(z)+z-\left(z-\tfrac12\right)\ln z-\tfrac12\ln(2\pi)
 = \cfrac{a_0}{z+\cfrac{a_1}{z+\cfrac{a_2}{z+\cfrac{a_3}{z+\cfrac{a_4}{z+\cfrac{a_5}{z+}}}}}}\cdots.`

The right side is the limit of its finite convergents. The reusable Lean
definition accepts separate denominator and numerator streams. It starts at
coefficient zero by default; `(offset := k)` exposes a tail only when one is
actually needed.

:::leanStatement "Lean · finite continued fractions"
```anchor continuedFraction (module := LMLF.Definitions.ContinuedFraction) -showProofStates
def continuedFraction {K : Type*} [DivisionRing K]
    (denominator numerator : ℕ → K) (depth : ℕ) (offset : ℕ := 0) : K :=
  continuedFractionFrom denominator numerator offset depth
```

```anchor continuedFractionConvergent (module := LMLF.Definitions.ContinuedFraction) -showProofStates
def continuedFractionConvergent {K : Type*} [DivisionRing K]
    (denominator numerator : ℕ → K) (n : ℕ) (offset : ℕ := 0) : K :=
  continuedFraction denominator numerator (n + 1) (offset := offset)
```
:::

The formal coefficient extractor acts on the odd asymptotic germ
$`z^{-1}(s_0+s_1z^{-2}+s_2z^{-4}+\cdots)`$. Its codomain is a subtype of
coefficient streams: once a numerator is zero, every later numerator is zero.
This removes the otherwise invisible and non-unique tail after termination.

:::leanStatement "Lean · normalized coefficient extraction"
```anchor ZeroTerminated (module := LMLF.Definitions.ContinuedFraction) -showProofStates
def ZeroTerminated {K : Type} [Zero K] (a : ℕ → K) : Prop :=
  ∀ k, a k = 0 → ∀ j, k ≤ j → a j = 0
```

```anchor CFCoefficients (module := LMLF.Definitions.ContinuedFraction) -showProofStates
abbrev CFCoefficients (K : Type := ℚ) [Zero K] :=
  {a : ℕ → K // ZeroTerminated a}
```

```anchor cfracCoeff (module := LMLF.Definitions.ContinuedFraction) -showProofStates
def cfracCoeff (s : OddAsymptoticSeries) : CFCoefficients :=
  ⟨cfracCoeffValue s, cfracCoeffValue_zeroTerminated s⟩
```
:::

The extractor repeatedly takes a normalized reciprocal of the residual formal
series. The constant term at step `k` is the raw numerator `aₖ`; if any such
numerator is zero, `cfracCoeffValue` makes the present and every later value
zero. These are executable definitions over `ℚ`, not existential witnesses.

:::leanStatement "Lean · executable coefficient algorithm"
```anchor normalizedReciprocalCoeff (module := LMLF.Definitions.ContinuedFraction) -showProofStates
def normalizedReciprocalCoeff (s : OddAsymptoticSeries) : ℕ → ℚ
  | 0 => 1
  | n + 1 =>
      if s 0 = 0 then 0
      else
        -(∑ i ∈ Finset.range (n + 1),
            s (i + 1) * normalizedReciprocalCoeff s (n - i)) / s 0
termination_by n => n
decreasing_by omega
```

```anchor cfracRemainder (module := LMLF.Definitions.ContinuedFraction) -showProofStates
def cfracRemainder (s : OddAsymptoticSeries) : ℕ → OddAsymptoticSeries
  | 0 => s
  | k + 1 => cfracStep (cfracRemainder s k)
```

```anchor cfracCoeffValue (module := LMLF.Definitions.ContinuedFraction) -showProofStates
def cfracCoeffValue (s : OddAsymptoticSeries) (k : ℕ) : ℚ :=
  if ∃ j ≤ k, cfracCoeffRaw s j = 0 then 0 else cfracCoeffRaw s k
```
:::

For a regular germ, the extractor reconstructs the original formal series.
Conversely, any normalized coefficient stream reconstructing that series is
the extracted stream. These are the existence and uniqueness statements that
make `cfracCoeff` a mathematical API rather than an opaque choice.

:::leanStatement "Lean · reconstruction and uniqueness"
```anchor formalContinuedFraction_cfracCoeff (module := LMLF.Definitions.ContinuedFraction) -showProofStates
theorem formalContinuedFraction_cfracCoeff
    (s : OddAsymptoticSeries) (hs : CFracRegular s) :
    formalContinuedFraction (cfracCoeff s) = PowerSeries.mk s
```

```anchor cfracCoeff_unique (module := LMLF.Definitions.ContinuedFraction) -showProofStates
theorem cfracCoeff_unique
    (s : OddAsymptoticSeries) (a : CFCoefficients)
    (hs : CFracRegular s)
    (h : formalContinuedFraction a = PowerSeries.mk s) :
    a = cfracCoeff s
```

```anchor cfracCoeff_congr_prefix (module := LMLF.Definitions.ContinuedFraction) -showProofStates
theorem cfracCoeff_congr_prefix
    (s t : OddAsymptoticSeries) (k : ℕ)
    (h : ∀ n ≤ k, s n = t n) :
    cfracCoeff s k = cfracCoeff t k
```
:::

For Gamma, `logGammaStirlingSeries` supplies the rational germ and
`gammaContinuedFractionCoeff` applies the executable triangular algorithm.

:::leanStatement "Lean · the Gamma coefficient map"
```anchor logGammaStirlingSeries (module := LMLF.Blueprint.Gamma.Section510) -showProofStates
def logGammaStirlingSeries (n : ℕ) : ℚ :=
  bernoulli (2 * n + 2) /
    (((2 * n + 2 : ℕ) : ℚ) * ((2 * n + 1 : ℕ) : ℚ))
```

```anchor gammaContinuedFractionCoeff (module := LMLF.Blueprint.Gamma.Section510) -showProofStates
def gammaContinuedFractionCoeff : LMLF.CFCoefficients :=
  LMLF.cfracCoeff logGammaStirlingSeries
```

```anchor gammaContinuedFraction_reconstructs_stirling (module := LMLF.Blueprint.Gamma.Section510) -showProofStates
theorem gammaContinuedFraction_reconstructs_stirling :
    LMLF.formalContinuedFraction gammaContinuedFractionCoeff =
      PowerSeries.mk logGammaStirlingSeries
```

```anchor gammaContinuedFractionCoeff_unique (module := LMLF.Blueprint.Gamma.Section510) -showProofStates
theorem gammaContinuedFractionCoeff_unique
    (a : LMLF.CFCoefficients)
    (h : LMLF.formalContinuedFraction a =
      PowerSeries.mk logGammaStirlingSeries) :
    a = gammaContinuedFractionCoeff
```
:::

The analytic statement below remains the positive-real specialization: the
source uses the general logarithm `Ln Γ(z)`, while Lean uses the ordinary real
logarithm for `x > 0` and then embeds the value into `ℂ`.

:::leanStatement "Lean · DLMF 5.10.1"
```anchor dlmf_5_10_1 (module := LMLF.Blueprint.Gamma.Section510) -showProofStates
theorem dlmf_5_10_1 {x : ℝ} (hx : 0 < x) :
    Tendsto
      (fun n => LMLF.continuedFractionConvergent
        (fun _ => (x : ℂ))
        (fun k => (gammaContinuedFractionCoeff k : ℂ)) n)
      atTop
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

The values are now computed from the Bernoulli-number series by
`gammaContinuedFractionCoeff`. The declaration closes with `native_decide`, so
the displayed finite prefix is checked by execution rather than assumed as
part of an existential witness. The same algorithm computes any requested
index; the finite-prefix theorem says coefficient `k` needs only the first
`k + 1` Stirling coefficients.

DLMF points to Char (1980) for exact values through $`a_{11}` and 40-significant-
digit values through $`a_{40}`, with further references there. Those tables are
not formulas printed in §5.10; LMLF's extractor is an independent executable
route to any requested finite prefix.

:::leanStatement "Lean · DLMF 5.10.2"
```anchor dlmf_5_10_2 (module := LMLF.Blueprint.Gamma.Section510) -showProofStates
theorem dlmf_5_10_2 :
    gammaContinuedFractionCoeff 0 = 1 / 12 ∧
      gammaContinuedFractionCoeff 1 = 1 / 30 ∧
      gammaContinuedFractionCoeff 2 = 53 / 210 ∧
      gammaContinuedFractionCoeff 3 = 195 / 371 ∧
      gammaContinuedFractionCoeff 4 = 22999 / 22737 ∧
      gammaContinuedFractionCoeff 5 = 29944523 / 19733142 ∧
      gammaContinuedFractionCoeff 6 = 109535241009 / 48264275462
```
:::
::::
