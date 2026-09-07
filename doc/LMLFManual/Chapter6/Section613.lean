import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section613
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section613
set_option verso.exampleProject "."

#doc (Manual) "§6.13 Zeros" =>
%%%
tag := "chapter-6-section-13"
%%%

:::dlmfChapter "https://dlmf.nist.gov/6.13"
Source: NIST Digital Library of Mathematical Functions, §6.13.
:::

# §6.13 Zeros
%%%
number := false
%%%

The exponential integral `Ei(x)` has exactly one positive real zero.  The
qualitative Lean statement records that unique zero in the positive domain;
the decimal enclosure is displayed separately as a quantitative companion.
Here `realEi` is the canonical positive-real map from §6.2.  The second
display gives the Poincaré expansion for the complete ordered positive zeros
`cₖ` of `Ci` and `sₖ` of lower-case `si`, where `si(z)=Si(z)-π/2`, indexed
from `k=0`.  For `cₖ` use `α=kπ`, while for `sₖ` use `α=(k+1/2)π`.  The
primary Lean statement is the finite displayed prefix, so every coefficient
shown by DLMF is visible without choosing hidden data.  An explicitly
auxiliary all-orders continuation records the source ellipsis when a
downstream result needs it.  The separate quantitative declaration records
the displayed next-term estimate and same-sign assertion.

::::dlmfEntry "6.13.1" "https://dlmf.nist.gov/6.13.E1"
$$`x_0=0.37250\;74107\;81366\;63446\;19918\;66580\dots`$$
:::leanStatement "The real zero of Ei"
```anchor dlmf_6_13_1 (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
theorem dlmf_6_13_1 :
    ∃! x₀ : ℝ, EiZero x₀
```
:::
::::

:::leanStatement "Positive real zero predicate"
```anchor EiZero (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
def EiZero (x : ℝ) : Prop := 0 < x ∧ realEi x = 0
```
:::

The displayed digits are an enclosure, not an exact terminating decimal.  For
the unique zero supplied by the existence statement, the reusable numerical
specialization is:

:::leanStatement "Numerical enclosure for the Ei zero"
```anchor dlmf_6_13_1_approx (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
theorem dlmf_6_13_1_approx (x₀ : ℝ)
    (hzero : EiZero x₀) :
    |x₀ - 0.372507410781366634461991866580| < 1 / (10 : ℝ) ^ 30
```
:::

:::leanStatement "Ci zero predicate"
```anchor ciRealZero (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
def ciRealZero (x : ℝ) : Prop :=
  0 < x ∧ principalCiPositive x = 0
```
:::

:::leanStatement "si zero predicate"
```anchor siRealZero (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
def siRealZero (x : ℝ) : Prop :=
  0 < x ∧ principalSi (x : ℂ) - (Real.pi / 2 : ℂ) = 0
```
:::

:::leanStatement "Ascending complete zero family"
```anchor PositiveZeroFamily (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
structure PositiveZeroFamily (zero : ℝ → Prop) where
  value : ℕ → ℝ
  positive : ∀ k, 0 < value k
  vanishes : ∀ k, zero (value k)
  ascending : StrictMono value
  complete : ∀ x, zero x → ∃ k, value k = x
```
:::

The finite displayed prefix and the continuation used below are explicit Lean
objects. A displayed term is indexed by `Fin 5`, so an invalid displayed
order cannot be passed accidentally; the coefficient object fixes the four
correction coefficients printed by DLMF and leaves only the ellipsis as data.

:::leanStatement "Displayed correction coefficients"
```anchor six13DisplayedCoefficient (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
def six13DisplayedCoefficient (n : Fin 4) : ℝ :=
  if n = 0 then 1
  else if n = 1 then -(16 / 3)
  else if n = 2 then 1673 / 15
  else -(507746 / 105)
```
:::

:::leanStatement "Displayed terms"
```anchor six13DisplayedTerm (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
def six13DisplayedTerm (n : Fin 5) (α : ℕ → ℝ) (k : ℕ) : ℝ :=
  if _hn : n.val = 0 then
    α k
  else
    let j : Fin 4 := ⟨n.val - 1, by omega⟩
    six13DisplayedCoefficient j / α k ^ (2 * j.val + 1)
```
:::

:::leanStatement "Displayed finite partial"
```anchor six13DisplayedPartial (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
def six13DisplayedPartial (n : Fin 5) (α : ℕ → ℝ) (k : ℕ) : ℝ :=
  ∑ j ∈ Finset.Iic n, six13DisplayedTerm j α k
```
:::

:::leanStatement "Displayed finite-prefix expansion"
```anchor HasSix13DisplayedExpansion (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
def HasSix13DisplayedExpansion (zeros α : ℕ → ℝ) : Prop :=
  ∀ n : Fin 5,
    (fun k => zeros k - six13DisplayedPartial n α k) =o[atTop]
      (fun k => six13DisplayedTerm n α k)
```
:::

:::leanStatement "Displayed next-term remainder bound"
```anchor six13DisplayedRetainedIndex (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
/-- DLMF 6.13.2: the displayed retained-term index. -/
def six13DisplayedRetainedIndex (n : Fin 4) : Fin 5 :=
  ⟨n.val, by omega⟩
```

```anchor six13DisplayedNextIndex (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
/-- DLMF 6.13.2: the next displayed-term index. -/
def six13DisplayedNextIndex (n : Fin 4) : Fin 5 :=
  ⟨n.val + 1, by omega⟩
```

```anchor HasSix13DisplayedRemainderBound (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
/-- DLMF 6.13.2: the quantitative next-term bound for the displayed prefix. -/
def HasSix13DisplayedRemainderBound (zeros α : ℕ → ℝ) : Prop :=
  ∀ n : Fin 4, ∀ k : ℕ, 1 ≤ k →
    let remainder := zeros k - six13DisplayedPartial (six13DisplayedRetainedIndex n) α k
    let nextTerm := six13DisplayedTerm (six13DisplayedNextIndex n) α k
    |remainder| ≤ |nextTerm| ∧ 0 ≤ remainder * nextTerm
```
:::

:::leanStatement "Common coefficient continuation"
```anchor Six13CoefficientContinuation (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
structure Six13CoefficientContinuation where
  value : ℕ → ℝ
  displayed_prefix : ∀ n : Fin 4, value n.val = six13DisplayedCoefficient n
```
:::

:::leanStatement "Ci phase parameter"
```anchor ciZeroAlpha (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
def ciZeroAlpha (k : ℕ) : ℝ := (k : ℝ) * Real.pi
```
:::

:::leanStatement "si phase parameter"
```anchor siZeroAlpha (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
def siZeroAlpha (k : ℕ) : ℝ := ((k : ℝ) + 1 / 2) * Real.pi
```
:::

:::leanStatement "All-orders term"
```anchor six13ContinuationTerm (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
def six13ContinuationTerm (coeff : Six13CoefficientContinuation)
    (α : ℕ → ℝ) (n k : ℕ) : ℝ :=
  match n with
  | 0 => α k
  | j + 1 => coeff.value j / α k ^ (2 * j + 1)
```
:::

:::leanStatement "All-orders Poincare expansion"
```anchor HasSix13AllOrdersExpansion (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
def HasSix13AllOrdersExpansion
    (zeros α : ℕ → ℝ) (coeff : Six13CoefficientContinuation) : Prop :=
  QuantitativeAnalysis.HasPoincareExpansion atTop (fun k => zeros k)
    (six13ContinuationTerm coeff α)
```
:::

:::leanStatement "Shared asymptotic data"
```anchor Six13AsymptoticData (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
structure Six13AsymptoticData
    (c : PositiveZeroFamily ciRealZero) (s : PositiveZeroFamily siRealZero) where
  coeff : Six13CoefficientContinuation
  c_expansion : HasSix13AllOrdersExpansion c.value ciZeroAlpha coeff
  s_expansion : HasSix13AllOrdersExpansion s.value siZeroAlpha coeff
```
:::

:::leanStatement "All-orders finite partial"
```anchor six13ContinuationPartial (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
def six13ContinuationPartial (coeff : Six13CoefficientContinuation)
    (α : ℕ → ℝ) (n k : ℕ) : ℝ :=
  α k + ∑ j ∈ Finset.range n, coeff.value j / α k ^ (2 * j + 1)
```
:::

:::leanStatement "All-orders remainder predicate"
```anchor HasSix13AllOrdersRemainderBound (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
def HasSix13AllOrdersRemainderBound
    (zeros α : ℕ → ℝ) (coeff : Six13CoefficientContinuation) : Prop :=
  ∀ n k : ℕ, 1 ≤ k →
    let remainder := zeros k - six13ContinuationPartial coeff α n k
    let nextTerm := six13ContinuationTerm coeff α (n + 1) k
    |remainder| ≤ |nextTerm| ∧ 0 ≤ remainder * nextTerm
```
:::

::::dlmfEntry "6.13.2" "https://dlmf.nist.gov/6.13.E2"
$$`c_k,s_k\sim\alpha+\frac1\alpha-\frac{16}{3\alpha^3}+\frac{1673}{15\alpha^5}-\frac{507746}{105\alpha^7}+\cdots`$$
:::leanStatement "Asymptotic zeros of Ci and si"
```anchor dlmf_6_13_2 (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
theorem dlmf_6_13_2
    (c : PositiveZeroFamily ciRealZero) (s : PositiveZeroFamily siRealZero) :
    HasSix13DisplayedExpansion c.value ciZeroAlpha ∧
      HasSix13DisplayedExpansion s.value siZeroAlpha
```
:::
::::

The primary theorem above is intentionally finite: it formalizes the terms
actually printed in the DLMF display. The next declaration is auxiliary and
introduces one arbitrary continuation for the ellipsis only when an all-orders
interface is desired.

:::leanStatement "Auxiliary all-orders continuation"
```anchor dlmf_6_13_2_all_orders_auxiliary (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
/-- DLMF 6.13.2: auxiliary existence of an all-orders continuation. -/
theorem dlmf_6_13_2_all_orders_auxiliary
    (c : PositiveZeroFamily ciRealZero) (s : PositiveZeroFamily siRealZero) :
    Nonempty (Six13AsymptoticData c s)
```
:::

:::leanStatement "Quantitative displayed-prefix remainder"
```anchor dlmf_6_13_2_remainder (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
theorem dlmf_6_13_2_remainder
    (c : PositiveZeroFamily ciRealZero) (s : PositiveZeroFamily siRealZero)
    : HasSix13DisplayedRemainderBound c.value ciZeroAlpha ∧
      HasSix13DisplayedRemainderBound s.value siZeroAlpha
```
:::

:::leanStatement "Auxiliary all-orders remainder"
```anchor dlmf_6_13_2_all_orders_remainder_auxiliary (module := LMLF.Blueprint.ExponentialIntegrals.Section613)
/-- DLMF 6.13.2: auxiliary all-orders remainder bound. -/
theorem dlmf_6_13_2_all_orders_remainder_auxiliary
    (c : PositiveZeroFamily ciRealZero) (s : PositiveZeroFamily siRealZero)
    (data : Six13AsymptoticData c s) :
    HasSix13AllOrdersRemainderBound c.value ciZeroAlpha data.coeff ∧
      HasSix13AllOrdersRemainderBound s.value siZeroAlpha data.coeff
```
:::

The source notes point to numerical work for the constant in E1. For E2, after
the displayed retained terms the remainder does not exceed the next displayed
term in absolute value and has the same sign. The quantitative declaration
records that finite-prefix result for both families; its condition `1 ≤ k`
excludes the singular phase `α=0` at `c₀`. The all-orders remainder panel is
explicitly auxiliary and depends on chosen continuation data.

::::dlmfEntry "6.13 section notes" "https://dlmf.nist.gov/6.13#info"
The section notes cite Cody and Thacher for the displayed constant in E1 and
record the section-level references accompanying the zero discussion.
::::

::::dlmfEntry "6.13 editorial addition" "https://dlmf.nist.gov/6.13#info"
The source records an editorial addition, effective with version 1.2.7,
concerning the remainder remark below E2 and the reference to Nemes (2025).
::::

::::dlmfEntry "6.13 definitions" "https://dlmf.nist.gov/6.13#p1"
The source defines `cₖ` and `sₖ` as the ascending positive real zeros of
`Ci(x)` and lower-case `si(x)`, and states that `Ei(x)` has one real zero.
::::

::::dlmfEntry "6.13 E1 note" "https://dlmf.nist.gov/6.13#E1.info"
For more digits of the E1 constant, the source points to OEIS sequence A091723
and to Sloane (2003).
::::

::::dlmfEntry "6.13 phase choices" "https://dlmf.nist.gov/6.13#p2"
The source specifies `α = kπ` for `cₖ` and `α = (k+1/2)π` for `sₖ`, with
the zero families indexed from `k = 0`.
::::

::::dlmfEntry "6.13 E2 editorial note" "https://dlmf.nist.gov/6.13#E2.info"
The source notes that E2 was reformatted to improve the readability of its
fractions.
::::
