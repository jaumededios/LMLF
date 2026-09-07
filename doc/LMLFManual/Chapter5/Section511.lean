import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section511
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§5.11 Asymptotic Expansions" =>
%%%
tag := "chapter-5-section-11"
%%%

:::dlmfChapter "https://dlmf.nist.gov/5.11"
Source: NIST Digital Library of Mathematical Functions, §5.11.
:::

This page follows all nineteen numbered displays in DLMF §5.11. Branch-sensitive
displays use explicit positive-real specializations where that makes the branch
choice visible; the declarations retain Chapter 2's `∼ₚ` notation.

# §5.11(i) Poincaré-Type Expansions
%%%
number := false
%%%

The coefficient streams below are canonical maps. A finite-state computation
isolates each new coefficient in the DLMF convolution, and the scaled-Gamma
coefficients are reconstructed from that stream. The recurrence and initial
value are exposed as semantic laws, rather than hiding the data behind a
selected existence witness.

The finite products used by the coefficient formulas are introduced once in
this shared vocabulary block before any numbered formula uses them.

```anchor risingFactorial (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
def risingFactorial (a : ℝ) (n : ℕ) : ℝ :=
  ∏ j ∈ Finset.range n, (a + j)
```

```anchor generalizedBinomial (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
def generalizedBinomial (a : ℝ) (n : ℕ) : ℝ :=
  (∏ j ∈ Finset.range n, (a - j)) / n.factorial
```

```anchor aCoeffStep (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def aCoeffStep (a : ℕ → ℝ) (n : ℕ) : ℝ :=
  let α : ℝ := Real.sqrt 2 / 2
  let interior : ℝ :=
    ∑ j ∈ Finset.Icc 1 n,
      a j * a (n + 1 - j) / (j + 1)
  (a n / (n + 1) - interior) / (α * (1 + 1 / (n + 2)))
```

```anchor aCoeffState (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def aCoeffState : ℕ → (ℕ → ℝ) :=
  Nat.rec (fun k ↦ if k = 0 then Real.sqrt 2 / 2 else 0)
    (fun n state k ↦ if k = n + 1 then aCoeffStep state n else state k)
```

```anchor aCoeff (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def aCoeff (k : ℕ) : ℝ :=
  aCoeffState (k + 1) k
```

```anchor gCoeff (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def gCoeff (k : ℕ) : ℝ :=
  Real.sqrt 2 * risingFactorial (1 / 2) k * aCoeff (2 * k)
```

```anchor aCoeff_recurrence (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem aCoeff_recurrence {k : ℕ} (hk : 1 ≤ k) :
    ∑ j ∈ Finset.range (k + 1),
      aCoeff j * aCoeff (k - j) / (j + 1) = aCoeff (k - 1) / k
```

```anchor aCoeff_unique (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem aCoeff_unique (a : ℕ → ℝ)
    (ha0 : a 0 = Real.sqrt 2 / 2)
    (ha : ∀ {k : ℕ}, 1 ≤ k →
      ∑ j ∈ Finset.range (k + 1),
        a j * a (k - j) / (j + 1) = a (k - 1) / k) :
    a = aCoeff
```

```anchor aCoeff_initial (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem aCoeff_initial : aCoeff 0 = Real.sqrt 2 / 2
```

```anchor aCoeff_prefix (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem aCoeff_prefix (k : ℕ) : aCoeff k = aCoeffState (k + 1) k
```

```anchor bernoulliPoly (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def bernoulliPoly (n : ℕ) (x : ℝ) : ℝ :=
  ∑ j ∈ Finset.range (n + 1),
    (n.choose j : ℝ) * (bernoulli (n - j) : ℝ) * x ^ j
```

As $`z\to\infty`$ in the sector $`|\operatorname{ph}z|\le\pi-\delta`$, DLMF
uses the general logarithm on the left and the principal logarithm in the
explicit terms.

::::dlmfEntry "5.11.1" "https://dlmf.nist.gov/5.11.E1"
$$`
\operatorname{Ln}\Gamma(z)\sim
\left(z-\frac12\right)\ln z-z+\frac12\ln(2\pi)
+\sum_{k=1}^{\infty}\frac{B_{2k}}{2k(2k-1)z^{2k-1}}.
`

On the positive real axis, `stirlingLogMain` is the elementary part and
`stirlingLogTerm` supplies the Bernoulli terms. Chapter 2's Poincaré relation
records every finite truncation remainder along `atTop`.

:::leanStatement "Lean statement · positive-real specialization"
```anchor stirlingLogMain (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def stirlingLogMain (x : ℝ) : ℝ :=
  (x - 1 / 2) * Real.log x - x + Real.log (2 * Real.pi) / 2
```

```anchor stirlingLogTerm (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def stirlingLogTerm (k : ℕ) (x : ℝ) : ℝ :=
  (bernoulli (2 * k + 2) : ℝ) /
    ((2 * k + 2 : ℕ) * (2 * k + 1 : ℕ) * x ^ (2 * k + 1))
```

The local index starts at zero, so `stirlingLogApprox n` retains exactly the
terms with local indices in `Finset.range n`; the first omitted term is then
`stirlingLogTerm n`.

```anchor stirlingLogApprox (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def stirlingLogApprox (n : ℕ) (x : ℝ) : ℝ :=
  stirlingLogMain x + QuantitativeAnalysis.seriesPartialSum stirlingLogTerm n x
```

```anchor dlmf_5_11_1 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_1 :
    (fun x : ℝ ↦ Real.log (Real.Gamma x) - stirlingLogMain x) ∼ₚ[atTop]
      stirlingLogTerm
```
:::

For positive real `x`, §5.11(ii) also says that the remainder after retaining
the first `n` terms has the sign of, and absolute value no larger than, the
first omitted term.

```anchor dlmf_5_11_1_remainder_bound (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_1_remainder_bound (n : ℕ) {x : ℝ} (hx : 0 < x) :
    0 ≤ (Real.log (Real.Gamma x) - stirlingLogApprox n x) *
      stirlingLogTerm n x ∧
      |Real.log (Real.Gamma x) - stirlingLogApprox n x| ≤
        |stirlingLogTerm n x|
```
::::

::::dlmfEntry "5.11.2" "https://dlmf.nist.gov/5.11.E2"
$$`
\psi(z)\sim\ln z-\frac{1}{2z}-\sum_{k=1}^{\infty}\frac{B_{2k}}{2kz^{2k}}.
`

The statement below restricts `ψ` to the real axis through the real part of
Mathlib's complex digamma function. The term indexed zero is `-1/(2x)` and
the subsequent terms are the displayed Bernoulli terms.

:::leanStatement "Lean statement · positive-real specialization"
```anchor realDigamma (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def realDigamma (x : ℝ) : ℝ :=
  (Complex.digamma (x : ℂ)).re
```

```anchor digammaTerm (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def digammaTerm (k : ℕ) (x : ℝ) : ℝ :=
  if k = 0 then -1 / (2 * x)
  else
    (let j : ℕ := k - 1;
     -(bernoulli (2 * j + 2) : ℝ) /
       ((2 * j + 2 : ℕ) * x ^ (2 * j + 2)))
```

The same zero-based convention is packaged by `digammaApprox`.

```anchor digammaApprox (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def digammaApprox (n : ℕ) (x : ℝ) : ℝ :=
  Real.log x + QuantitativeAnalysis.seriesPartialSum digammaTerm n x
```

```anchor dlmf_5_11_2 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_2 :
    (fun x : ℝ ↦ realDigamma x - Real.log x) ∼ₚ[atTop] digammaTerm
```
:::

The same positive-real hypothesis gives the first-neglected-term sign and
magnitude estimate for this expansion.

```anchor dlmf_5_11_2_remainder_bound (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_2_remainder_bound (n : ℕ) {x : ℝ} (hx : 0 < x) :
    0 ≤ (realDigamma x - digammaApprox n x) * digammaTerm n x ∧
      |realDigamma x - digammaApprox n x| ≤ |digammaTerm n x|
```
::::


::::dlmfEntry "5.11.3" "https://dlmf.nist.gov/5.11.E3"
$$`
\Gamma(z)=e^{-z}z^z\left(\frac{2\pi}{z}\right)^{1/2}\Gamma^*(z)
\sim e^{-z}z^z\left(\frac{2\pi}{z}\right)^{1/2}
\sum_{k=0}^{\infty}\frac{g_k}{z^k}.
`

For positive real `x`, `scaledGammaReal` is `Γ*(x)` and its formal series is
represented by the coefficient map displayed below.

:::leanStatement "Lean statement · positive-real specialization"
```anchor scaledGammaPrefactorReal (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def scaledGammaPrefactorReal (x : ℝ) : ℝ :=
  Real.exp (-x) * x ^ x * Real.sqrt (2 * Real.pi / x)
```

```anchor scaledGammaReal (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def scaledGammaReal (x : ℝ) : ℝ :=
  Real.Gamma x / scaledGammaPrefactorReal x
```

The exact defining factorization is separate from the asymptotic expansion:

```anchor scaledGammaReal_factorization (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem scaledGammaReal_factorization {x : ℝ} (hx : 0 < x) :
    Real.Gamma x = scaledGammaPrefactorReal x * scaledGammaReal x
```

```anchor scaledGammaTerm (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def scaledGammaTerm (k : ℕ) (x : ℝ) : ℝ :=
  gCoeff k / x ^ k
```

```anchor dlmf_5_11_3 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_3 :
    (fun x : ℝ ↦ scaledGammaReal x) ∼ₚ[atTop] scaledGammaTerm
```

In particular, the positive-real specialization makes the source's main
property `Γ*(x) ∼ 1` explicit in the ordinary Chapter 1–3 asymptotic
equivalence notation.

```anchor scaledGammaReal_asymptotic_one (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem scaledGammaReal_asymptotic_one :
    (fun x : ℝ ↦ scaledGammaReal x) ~[atTop] (fun _ : ℝ ↦ (1 : ℝ))
```
:::
::::

::::dlmfEntry "5.11.4" "https://dlmf.nist.gov/5.11.E4"
$$`
g_0=1,\quad g_1=\frac1{12},\quad g_2=\frac1{288},\quad
g_3=-\frac{139}{51840},\quad g_4=-\frac{571}{2488320},\quad
g_5=\frac{163879}{209018880},\quad g_6=\frac{5246819}{75246796800}.
`

The seven displayed coefficients are recorded exactly as real equalities.

```anchor dlmf_5_11_4 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_4 :
    gCoeff 0 = 1 ∧
    gCoeff 1 = 1 / 12 ∧
    gCoeff 2 = 1 / 288 ∧
    gCoeff 3 = -(139 : ℝ) / 51840 ∧
    gCoeff 4 = -(571 : ℝ) / 2488320 ∧
    gCoeff 5 = 163879 / 209018880 ∧
    gCoeff 6 = 5246819 / 75246796800
```
::::

::::dlmfEntry "5.11.5" "https://dlmf.nist.gov/5.11.E5"
$$`g_k=\sqrt{2}\left(\frac12\right)_k a_{2k}.`

Here `(1/2)_k` is the finite rising factorial `risingFactorial` introduced in
the shared vocabulary block above.

```anchor dlmf_5_11_5 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_5 (k : ℕ) :
    gCoeff k = Real.sqrt 2 * risingFactorial (1 / 2) k * aCoeff (2 * k)
```
::::

::::dlmfEntry "5.11.6" "https://dlmf.nist.gov/5.11.E6"
$$`
a_0a_k+\frac12a_1a_{k-1}+\cdots+\frac1{k+1}a_ka_0=\frac1k a_{k-1},
\qquad k\ge1,
`

The displayed recurrence is written as a finite sum, with the initial value
`a₀=√2/2` stated separately.

```anchor dlmf_5_11_6 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_6 {k : ℕ} (hk : 1 ≤ k) :
    ∑ j ∈ Finset.range (k + 1),
        aCoeff j * aCoeff (k - j) / (j + 1) = aCoeff (k - 1) / k
```

```anchor dlmf_5_11_6_initial (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_6_initial : aCoeff 0 = Real.sqrt 2 / 2
```
::::

::::dlmfEntry "5.11.7" "https://dlmf.nist.gov/5.11.E7"
$$`
\Gamma(az+b)\sim\sqrt{2\pi}\,e^{-az}(az)^{az+b-1/2},
\qquad a>0,
`

For fixed real `a>0` and real `b`, the positive-real specialization uses
Mathlib's asymptotic-equivalence relation along `atTop`.

```anchor dlmf_5_11_7 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_7 {a b : ℝ} (ha : 0 < a) :
    (fun z : ℝ ↦ Real.Gamma (a * z + b)) ~[atTop]
      (fun z ↦ Real.sqrt (2 * Real.pi) * Real.exp (-a * z) *
        (a * z) ^ (a * z + b - 1 / 2))
```
::::

::::dlmfEntry "5.11.8" "https://dlmf.nist.gov/5.11.E8"
$$`
\operatorname{Ln}\Gamma(z+h)\sim\left(z+h-\frac12\right)\ln z-z
+\frac12\ln(2\pi)+\sum_{k=2}^{\infty}
\frac{(-1)^kB_k(h)}{k(k-1)z^{k-1}}.
`

With fixed real `h` and positive real `x`, `shiftedLogGammaMain` and
`shiftedLogGammaTerm` give the corresponding specialization. The source now
allows arbitrary complex `h`; restricting it to real `h` here makes the real
logarithm branch explicit.

```anchor shiftedLogGammaMain (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def shiftedLogGammaMain (h x : ℝ) : ℝ :=
  (x + h - 1 / 2) * Real.log x - x + Real.log (2 * Real.pi) / 2
```

```anchor shiftedLogGammaTerm (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def shiftedLogGammaTerm (h : ℝ) (k : ℕ) (x : ℝ) : ℝ :=
  (-1 : ℝ) ^ (k + 2) * bernoulliPoly (k + 2) h /
    ((k + 2 : ℕ) * (k + 1 : ℕ) * x ^ (k + 1))
```

```anchor dlmf_5_11_8 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_8 (h : ℝ) :
    (fun x : ℝ ↦ Real.log (Real.Gamma (x + h)) - shiftedLogGammaMain h x) ∼ₚ[atTop]
      shiftedLogGammaTerm h
```
::::

::::dlmfEntry "5.11.9" "https://dlmf.nist.gov/5.11.E9"
$$`
|\Gamma(x+iy)|\sim\sqrt{2\pi}|y|^{x-1/2}e^{-\pi|y|/2},
`

The source asserts this uniformly for bounded real `x`. The predicate
`UniformAsymptoticOnBounded` expresses that assertion as uniform convergence
of the relative error on every bounded set of `x` values.

```anchor UniformAsymptoticOnBounded (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
def UniformAsymptoticOnBounded
    (f g : ℝ → ℝ → ℝ) (l : Filter ℝ) : Prop :=
  ∀ s : Set ℝ, Bornology.IsBounded s →
    TendstoUniformlyOn
      (fun y x ↦ ‖f x y / g x y - 1‖) (fun _ ↦ 0) l s
```

```anchor dlmf_5_11_9 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_9 :
    UniformAsymptoticOnBounded
        (fun x y ↦ ‖Complex.Gamma (x + (y : ℂ) * Complex.I)‖)
        (fun x y ↦ Real.sqrt (2 * Real.pi) * |y| ^ (x - 1 / 2) *
          Real.exp (-Real.pi * |y| / 2)) atTop ∧
      UniformAsymptoticOnBounded
        (fun x y ↦ ‖Complex.Gamma (x + (y : ℂ) * Complex.I)‖)
        (fun x y ↦ Real.sqrt (2 * Real.pi) * |y| ^ (x - 1 / 2) *
          Real.exp (-Real.pi * |y| / 2)) atBot
```
::::


# §5.11(ii) Error Bounds and Exponential Improvement
%%%
number := false
%%%

The paragraph immediately before E10 gives two further, genuinely distinct
complex remainder estimates. To make the first omitted source index explicit,
the following definitions use one-based `n` and truncate through `n - 1`.

```anchor complexStirlingTerm (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def complexStirlingTerm (k : ℕ) (z : ℂ) : ℂ :=
  (bernoulli (2 * k) : ℂ) /
    ((2 * k : ℕ) * (2 * k - 1 : ℕ) * z ^ (2 * k - 1))
```

```anchor complexDigammaTerm (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def complexDigammaTerm (k : ℕ) (z : ℂ) : ℂ :=
  -(bernoulli (2 * k) : ℂ) / ((2 * k : ℕ) * z ^ (2 * k))
```

The explicit terms use principal `Complex.log z`, while the left side of E1
uses a general logarithm of Gamma carried by an explicit branch datum. The
datum is indexed by the sector margin `δ`, is analytic on each admissible
sector, agrees on overlapping sectors, and is normalized to
`Real.log (Real.Gamma x)` on positive reals. No arbitrary branch witness is
selected globally; the complex residual APIs take this datum as an argument.

```anchor gammaSectorDomain (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
def gammaSectorDomain (δ : ℝ) (z : ℂ) : Prop :=
  z ≠ 0 ∧ |Complex.arg z| ≤ Real.pi - δ
```

```anchor LnGammaDatum (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
structure LnGammaDatum where
  value : ℝ → ℂ → ℂ
  exp_eq_gamma : ∀ {δ : ℝ} {z : ℂ}, 0 < δ → gammaSectorDomain δ z →
    Complex.exp (value δ z) = Complex.Gamma z
  analytic_on : ∀ {δ : ℝ}, 0 < δ →
    AnalyticOnNhd ℂ (value δ) {z | gammaSectorDomain δ z}
  branch_consistent : ∀ {δ₁ δ₂ : ℝ} {z : ℂ},
    0 < δ₁ → 0 < δ₂ → gammaSectorDomain δ₁ z → gammaSectorDomain δ₂ z →
      value δ₁ z = value δ₂ z
  real_normalization : ∀ {δ : ℝ} {x : ℝ},
    0 < δ → 0 < x → gammaSectorDomain δ (x : ℂ) →
      value δ (x : ℂ) = (Real.log (Real.Gamma x) : ℂ)
```

```anchor existsLnGammaDatum (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem existsLnGammaDatum : Nonempty LnGammaDatum
```

```anchor lnGamma (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def lnGamma (datum : LnGammaDatum) (δ : ℝ) (z : ℂ) : ℂ :=
  datum.value δ z
```

```anchor complexStirlingApprox (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def complexStirlingApprox (n : ℕ) (z : ℂ) : ℂ :=
  (z - 1 / 2) * Complex.log z - z + Complex.log (2 * Real.pi) / 2 +
    ∑ k ∈ Finset.Icc 1 (n - 1), complexStirlingTerm k z
```

```anchor complexDigammaApprox (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def complexDigammaApprox (n : ℕ) (z : ℂ) : ℂ :=
  Complex.log z - 1 / (2 * z) +
    ∑ k ∈ Finset.Icc 1 (n - 1), complexDigammaTerm k z
```

```anchor complexStirlingRemainder (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def complexStirlingRemainder (datum : LnGammaDatum)
    (δ : ℝ) (n : ℕ) (z : ℂ) : ℂ :=
  lnGamma datum δ z - complexStirlingApprox n z
```

```anchor complexDigammaRemainder (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def complexDigammaRemainder (n : ℕ) (z : ℂ) : ℂ :=
  Complex.digamma z - complexDigammaApprox n z
```

```anchor dlmf_5_11_1_complex_remainder_bound (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_1_complex_remainder_bound (datum : LnGammaDatum)
    {n : ℕ} (hn : 1 ≤ n)
    {δ : ℝ} (hδ : 0 < δ) {z : ℂ} (hz : z ≠ 0)
    (hsector : |Complex.arg z| ≤ Real.pi - δ) :
    ‖complexStirlingRemainder datum δ n z‖ ≤
      ‖complexStirlingTerm n z‖ *
        (1 / Real.cos (Complex.arg z / 2)) ^ (2 * n)
```

```anchor dlmf_5_11_2_complex_remainder_bound (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_2_complex_remainder_bound {n : ℕ} (hn : 1 ≤ n)
    {δ : ℝ} (hδ : 0 < δ) {z : ℂ} (hz : z ≠ 0)
    (hsector : |Complex.arg z| ≤ Real.pi - δ) :
    ‖complexDigammaRemainder n z‖ ≤
      ‖complexDigammaTerm n z‖ *
        (1 / Real.cos (Complex.arg z / 2)) ^ (2 * n + 1)
```

The first bound uses `sec^(2n)(ph z/2)` for E1 and the second uses the
different exponent `sec^(2n+1)(ph z/2)` for E2.

::::dlmfEntry "5.11.10" "https://dlmf.nist.gov/5.11.E10"
$$`
\Gamma(z)=e^{-z}z^z\left(\frac{2\pi}{z}\right)^{1/2}
\left(\sum_{k=0}^{K-1}\frac{g_k}{z^k}+R_K(z)\right),
\qquad K=1,2,3,\ldots.
`

The finite expansion inherits the preceding principal-branch convention and
the sector `|arg z| ≤ π − δ`, with `δ > 0` and `z ≠ 0`. The finite sum and
remainder are named separately; the remainder is defined as the residual of
the displayed prefactor on this nonzero sector.

```anchor gammaPrefactor (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def gammaPrefactor (z : ℂ) : ℂ :=
  Complex.exp (-z) * z ^ z * (2 * Real.pi / z) ^ (1 / 2 : ℂ)
```

```anchor gammaFiniteSum (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def gammaFiniteSum (K : ℕ) (z : ℂ) : ℂ :=
  ∑ k ∈ Finset.range K, (gCoeff k : ℂ) / z ^ k
```

```anchor gammaRemainder (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def gammaRemainder (K : ℕ) (z : ℂ) : ℂ :=
  if gammaPrefactor z = 0 then 0
  else Complex.Gamma z / gammaPrefactor z - gammaFiniteSum K z
```

```anchor dlmf_5_11_10 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_10 {δ : ℝ} (hδ : 0 < δ) {K : ℕ} (hK : 1 ≤ K)
    {z : ℂ} (hz : z ≠ 0) (hsector : |Complex.arg z| ≤ Real.pi - δ) :
    Complex.Gamma z = gammaPrefactor z *
      (gammaFiniteSum K z + gammaRemainder K z)
```
::::

::::dlmfEntry "5.11.11" "https://dlmf.nist.gov/5.11.E11"
$$`
|R_K(z)|\le
\frac{(1+\zeta(K))\Gamma(K)}{2(2\pi)^{K+1}|z|^K}
\left(1+\min\left(\sec(\operatorname{ph}z),2K^{1/2}\right)\right),
\quad |\operatorname{ph}z|\le\frac\pi2.
`

The Lean bound uses the norm of complex quantities. Its `cappedSecant` agrees
with `min (sec (arg z), 2√K)` in the open sector and takes the cap value when
`cos (arg z)=0`, so the source's included boundary `|arg z|=π/2` is meaningful.

```anchor cappedSecant (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def cappedSecant (K : ℕ) (θ : ℝ) : ℝ :=
  if Real.cos θ = 0 then 2 * Real.sqrt K else min (1 / Real.cos θ) (2 * Real.sqrt K)
```

```anchor dlmf_5_11_11 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_11 {K : ℕ} (hK : 1 ≤ K) {z : ℂ} (hz : z ≠ 0)
    (hsector : |Complex.arg z| ≤ Real.pi / 2) :
    ‖gammaRemainder K z‖ ≤
      (if K = 1 then 4 else ‖1 + riemannZeta (K : ℂ)‖) * Real.Gamma K /
        (2 * (2 * Real.pi) ^ (K + 1) * ‖z‖ ^ K) *
        (1 + cappedSecant K (Complex.arg z))
```

The residual is retained as a named definition because the exact E10
bookkeeping identity is accompanied by substantive content: E11 gives its
sectorial quantitative bound, and on the positive real ray the remainder
decays to zero.

```anchor gammaRemainder_tendsto_zero (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem gammaRemainder_tendsto_zero (K : ℕ) (hK : 1 ≤ K) :
    Tendsto (fun x : ℝ ↦ gammaRemainder K (x : ℂ)) atTop (nhds 0)
```
::::

# §5.11(iii) Ratios
%%%
number := false
%%%

In this subsection the source allows real or complex constants and approaches
in a sector. The declarations below give positive-real specializations, so
all powers and Gamma values use their unambiguous real meanings.

The generalized Bernoulli polynomials are canonical formal coefficients. Their
formal generating series raises the Bernoulli series by the binomial map and
multiplies by the formal exponential; the analytic generating-function law is
then stated separately. The ratio coefficients below are defined from this
canonical map.

```anchor generalizedBernoulliKernel (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def generalizedBernoulliKernel (α t : ℝ) : ℝ :=
  if t = 0 then 1 else (t / (Real.exp t - 1)) ^ α
```

```anchor generalizedBernoulliFormal (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def generalizedBernoulliFormal (α x : ℝ) : PowerSeries ℝ :=
  PowerSeries.subst
      (bernoulliPowerSeries ℝ - 1)
      (PowerSeries.binomialSeries ℝ α) *
    PowerSeries.rescale x (PowerSeries.exp ℝ)
```

```anchor generalizedBernoulli (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def generalizedBernoulli (α x : ℝ) (n : ℕ) : ℝ :=
  (n.factorial : ℝ) * PowerSeries.coeff n (generalizedBernoulliFormal α x)
```

```anchor generalizedBernoulli_generating (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem generalizedBernoulli_generating (α x : ℝ) :
    ∀ t : ℝ, |t| < 2 * Real.pi →
      HasSum (fun n : ℕ ↦ generalizedBernoulli α x n * t ^ n / (n.factorial : ℝ))
        (generalizedBernoulliKernel α t * Real.exp (x * t))
```

```anchor generalizedBernoulli_prefix (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem generalizedBernoulli_prefix (α x : ℝ) (n : ℕ) :
    generalizedBernoulli α x n =
      (n.factorial : ℝ) * PowerSeries.coeff n (generalizedBernoulliFormal α x)
```

::::dlmfEntry "5.11.12" "https://dlmf.nist.gov/5.11.E12"
$$`
\frac{\Gamma(z+a)}{\Gamma(z+b)}\sim z^{a-b}.
`

```anchor dlmf_5_11_12 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_12 (a b : ℝ) :
    (fun z : ℝ ↦ Real.Gamma (z + a) / Real.Gamma (z + b)) ~[atTop]
      (fun z ↦ z ^ (a - b))
```
::::

::::dlmfEntry "5.11.13" "https://dlmf.nist.gov/5.11.E13"
$$`
\frac{\Gamma(z+a)}{\Gamma(z+b)}\sim z^{a-b}
\sum_{k=0}^{\infty}\frac{G_k(a,b)}{z^k}.
`

```anchor ratioCoeff (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def ratioCoeff (a b : ℝ) (k : ℕ) : ℝ :=
  generalizedBinomial (a - b) k * generalizedBernoulli (a - b + 1) a k
```

```anchor ratioTerm (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def ratioTerm (a b : ℝ) (k : ℕ) (z : ℝ) : ℝ :=
  ratioCoeff a b k * z ^ (a - b - k)
```

```anchor dlmf_5_11_13 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_13 (a b : ℝ) :
    (fun z : ℝ ↦ Real.Gamma (z + a) / Real.Gamma (z + b)) ∼ₚ[atTop]
      ratioTerm a b
```
::::

::::dlmfEntry "5.11.14" "https://dlmf.nist.gov/5.11.E14"
$$`
\frac{\Gamma(z+a)}{\Gamma(z+b)}\sim
\left(z+\frac{a+b-1}{2}\right)^{a-b}
\sum_{k=0}^{\infty}\frac{H_k(a,b)}{(z+(a+b-1)/2)^{2k}}.
`

```anchor centeredRatioCoeff (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def centeredRatioCoeff (a b : ℝ) (k : ℕ) : ℝ :=
  generalizedBinomial (a - b) (2 * k) *
    generalizedBernoulli (a - b + 1) ((a - b + 1) / 2) (2 * k)
```

```anchor centeredRatioTerm (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def centeredRatioTerm (a b : ℝ) (k : ℕ) (z : ℝ) : ℝ :=
  centeredRatioCoeff a b k * (z + (a + b - 1) / 2) ^ (a - b - 2 * k)
```

```anchor dlmf_5_11_14 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_14 (a b : ℝ) :
    (fun z : ℝ ↦ Real.Gamma (z + a) / Real.Gamma (z + b)) ∼ₚ[atTop]
      centeredRatioTerm a b
```
::::

::::dlmfEntry "5.11.15" "https://dlmf.nist.gov/5.11.E15"
$$`
G_0=1,\quad G_1=\frac12(a-b)(a+b-1),\quad
G_2=\frac1{12}{a-b\choose2}\left(3(a+b-1)^2-(a-b+1)\right).
`

The generalized binomial coefficient is the finite falling product
`generalizedBinomial` introduced in the shared vocabulary block above.

```anchor dlmf_5_11_15 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_15 (a b : ℝ) :
    ratioCoeff a b 0 = 1 ∧
    ratioCoeff a b 1 = (a - b) * (a + b - 1) / 2 ∧
    ratioCoeff a b 2 =
      generalizedBinomial (a - b) 2 *
        (3 * (a + b - 1) ^ 2 - (a - b + 1)) / 12
```
::::

::::dlmfEntry "5.11.16" "https://dlmf.nist.gov/5.11.E16"
$$`
H_0=1,\quad H_1=-\frac1{12}{a-b\choose2}(a-b+1),\quad
H_2=\frac1{240}{a-b\choose4}\left(2(a-b+1)+5(a-b+1)^2\right).
`

```anchor dlmf_5_11_16 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_16 (a b : ℝ) :
    centeredRatioCoeff a b 0 = 1 ∧
    centeredRatioCoeff a b 1 =
      -generalizedBinomial (a - b) 2 * (a - b + 1) / 12 ∧
    centeredRatioCoeff a b 2 =
      generalizedBinomial (a - b) 4 *
        (2 * (a - b + 1) + 5 * (a - b + 1) ^ 2) / 240
```
::::

::::dlmfEntry "5.11.17" "https://dlmf.nist.gov/5.11.E17"
$$`
G_k(a,b)={a-b\choose k}B_k^{(a-b+1)}(a).
`

```anchor dlmf_5_11_17 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_17 (a b : ℝ) (k : ℕ) :
    ratioCoeff a b k = generalizedBinomial (a - b) k *
      generalizedBernoulli (a - b + 1) a k
```
::::

::::dlmfEntry "5.11.18" "https://dlmf.nist.gov/5.11.E18"
$$`
H_k(a,b)={a-b\choose 2k}B_{2k}^{(a-b+1)}\left(\frac{a-b+1}{2}\right).
`

```anchor dlmf_5_11_18 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_18 (a b : ℝ) (k : ℕ) :
    centeredRatioCoeff a b k = generalizedBinomial (a - b) (2 * k) *
      generalizedBernoulli (a - b + 1) ((a - b + 1) / 2) (2 * k)
```
::::

::::dlmfEntry "5.11.19" "https://dlmf.nist.gov/5.11.E19"
$$`
\frac{\Gamma(z+a)\Gamma(z+b)}{\Gamma(z+c)}\sim
\sum_{k=0}^{\infty}(-1)^k\frac{(c-a)_k(c-b)_k}{k!}
\Gamma(a+b-c+z-k).
`

On positive real `z`, the summand is exposed as `gammaProductTerm`, using the
same finite rising factorial as 5.11.5.

```anchor gammaProductTerm (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
noncomputable def gammaProductTerm (a b c : ℝ) (k : ℕ) (z : ℝ) : ℝ :=
  (-1 : ℝ) ^ k * risingFactorial (c - a) k * risingFactorial (c - b) k /
    k.factorial * Real.Gamma (a + b - c + z - k)
```

```anchor dlmf_5_11_19 (module := LMLF.Blueprint.Gamma.Section511) -showProofStates
theorem dlmf_5_11_19 (a b c : ℝ) :
    (fun z : ℝ ↦ Real.Gamma (z + a) * Real.Gamma (z + b) /
      Real.Gamma (z + c)) ∼ₚ[atTop] gammaProductTerm a b c
```
::::
