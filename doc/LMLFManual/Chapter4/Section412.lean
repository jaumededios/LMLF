import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section412
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.12 Generalized Logarithms and Exponentials" =>
%%%
tag := "chapter-4-section-12"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.12"
Source: NIST Digital Library of Mathematical Functions, §4.12.
:::

# §4.12 Generalized Logarithms and Exponentials
%%%
number := false
%%%

A generalized exponential `φ` is specified by a recurrence and an initial
value, together with strict monotonicity and continuous differentiability on
`[0,1]`; its inverse `ψ` is called a generalized logarithm.  The first formulas
state these defining relations and the simplest identity choice.  Later
formulas continue that choice across the negative and positive real axes using
the principal real logarithm and iterated exponentials or logarithms.

:::leanStatement "Iteration vocabulary"
```anchor iterateRealFunction (module := LMLF.Blueprint.Elementary.Section412)
def iterateRealFunction (f : ℝ → ℝ) (n : ℕ) (x : ℝ) : ℝ :=
  match n with
  | 0 => x
  | n + 1 => f (iterateRealFunction f n x)
```
```anchor iteratedExp (module := LMLF.Blueprint.Elementary.Section412)
def iteratedExp (n : ℕ) (x : ℝ) : ℝ :=
  iterateRealFunction Real.exp n x
```
```anchor iteratedLog (module := LMLF.Blueprint.Elementary.Section412)
def iteratedLog (n : ℕ) (x : ℝ) : ℝ :=
  iterateRealFunction Real.log n x
```
```anchor iteratedLogDefined (module := LMLF.Blueprint.Elementary.Section412)
def iteratedLogDefined (n : ℕ) (x : ℝ) : Prop :=
  ∀ k < n, 0 < iteratedLog k x
```
:::

The reusable interfaces package the recurrence, normalizations, continuation
branches, strict monotonicity, and continuous differentiability without making
each displayed formula assume its own conclusion.

:::leanStatement "Generalized-function interfaces"
```anchor GeneralizedExponential (module := LMLF.Blueprint.Elementary.Section412)
structure GeneralizedExponential where
  toFun : ℝ → ℝ
  recurrence : ∀ y, -1 < y → toFun (y + 1) = Real.exp (toFun y)
  zero : toFun 0 = 0
  identityOnUnit : ∀ x ∈ Icc (0 : ℝ) 1, toFun x = x
  negativeBranch : ∀ x, -1 < x → x < 0 → toFun x = Real.log (x + 1)
  positiveBranch : ∀ x, 1 < x → toFun x = iteratedExp ⌊x⌋₊ (x - ⌊x⌋₊)
  strictMono : StrictMonoOn toFun (Icc (0 : ℝ) 1)
  contDiff : ContDiff ℝ 1 toFun
```
```anchor GeneralizedLogarithm (module := LMLF.Blueprint.Elementary.Section412)
structure GeneralizedLogarithm where
  toFun : ℝ → ℝ
  shift : ∀ x : ℝ, toFun (Real.exp x) = 1 + toFun x
  zero : toFun 0 = 0
  identityOnUnit : ∀ x ∈ Icc (0 : ℝ) 1, toFun x = x
  negativeBranch : ∀ x, x < 0 → toFun x = Real.exp x - 1
  positiveBranch : ∀ x, 1 < x → ∃ l : ℕ, 0 < l ∧ toFun x = l + iteratedLog l x
  strictMono : StrictMonoOn toFun (Icc (0 : ℝ) 1)
  contDiff : ContDiff ℝ 1 toFun
```
:::

:::leanStatement "Paired generalized functions"
```anchor GeneralizedFunctionPair (module := LMLF.Blueprint.Elementary.Section412)
structure GeneralizedFunctionPair where
  exponential : GeneralizedExponential
  logarithm : GeneralizedLogarithm
  leftInverse : Function.LeftInverse logarithm.toFun exponential.toFun
  rightInverse : Function.RightInverse logarithm.toFun exponential.toFun
```
:::

::::dlmfEntry "4.12.1" "https://dlmf.nist.gov/4.12.E1"
$$`\[\varphi(x+1)=\exp(\varphi(x)),\qquad -1<x<\infty.\]`

The generalized exponential satisfies this recurrence for every real `x` in
the interval `(-1,∞)`.

:::leanStatement "Generalized exponential recurrence"
```anchor dlmf_4_12_1 (module := LMLF.Blueprint.Elementary.Section412)
theorem dlmf_4_12_1 (φ : GeneralizedExponential)
    {x : ℝ} (hx : -1 < x) :
    φ.toFun (x + 1) = Real.exp (φ.toFun x)
```
:::
::::

The phrase “inverse generalized logarithm” is represented by a paired
interface: its `leftInverse` and `rightInverse` fields assert the two
composition identities explicitly.

:::leanStatement "Inverse relationship"
```anchor generalized_functions_inverse (module := LMLF.Blueprint.Elementary.Section412)
theorem generalized_functions_inverse (p : GeneralizedFunctionPair) :
    Function.LeftInverse p.logarithm.toFun p.exponential.toFun ∧
      Function.RightInverse p.logarithm.toFun p.exponential.toFun
```
:::

The generalized exponential and logarithm are strictly increasing on the
closed unit interval, and each is continuously differentiable there (indeed,
the interface records global `ContDiff` regularity).

:::leanStatement "Monotonicity and differentiability"
```anchor generalized_functions_strictMono (module := LMLF.Blueprint.Elementary.Section412)
theorem generalized_functions_strictMono (φ : GeneralizedExponential)
    (ψ : GeneralizedLogarithm) :
    StrictMonoOn φ.toFun (Icc (0 : ℝ) 1) ∧
      StrictMonoOn ψ.toFun (Icc (0 : ℝ) 1)
```
```anchor generalized_functions_contDiff (module := LMLF.Blueprint.Elementary.Section412)
theorem generalized_functions_contDiff (φ : GeneralizedExponential)
    (ψ : GeneralizedLogarithm) :
    ContDiff ℝ 1 φ.toFun ∧ ContDiff ℝ 1 ψ.toFun
```
:::

::::dlmfEntry "4.12.2" "https://dlmf.nist.gov/4.12.E2"
$$`\[\varphi(0)=0.\]`

The normalization fixes the generalized exponential at the origin.

:::leanStatement "Generalized exponential at zero"
```anchor dlmf_4_12_2 (module := LMLF.Blueprint.Elementary.Section412)
theorem dlmf_4_12_2 (φ : GeneralizedExponential) : φ.toFun 0 = 0
```
:::
::::

::::dlmfEntry "4.12.3" "https://dlmf.nist.gov/4.12.E3"
$$`\[\psi(e^x)=1+\psi(x),\qquad -\infty<x<\infty.\]`

The inverse generalized logarithm obeys the corresponding unit-shift relation
for every real `x`.

:::leanStatement "Generalized logarithm recurrence"
```anchor dlmf_4_12_3 (module := LMLF.Blueprint.Elementary.Section412)
theorem dlmf_4_12_3 (ψ : GeneralizedLogarithm) (x : ℝ) :
    ψ.toFun (Real.exp x) = 1 + ψ.toFun x
```
:::
::::

::::dlmfEntry "4.12.4" "https://dlmf.nist.gov/4.12.E4"
$$`\[\psi(0)=0.\]`

The generalized logarithm has the matching origin normalization.

:::leanStatement "Generalized logarithm at zero"
```anchor dlmf_4_12_4 (module := LMLF.Blueprint.Elementary.Section412)
theorem dlmf_4_12_4 (ψ : GeneralizedLogarithm) : ψ.toFun 0 = 0
```
:::
::::

::::dlmfEntry "4.12.5" "https://dlmf.nist.gov/4.12.E5"
$$`\[\varphi(x)=\psi(x)=x,\qquad 0\le x\le1.\]`

The simplest admissible choice takes both functions to be the identity on the
unit interval.  The Lean form permits the two functions to be named while
making both identity equalities explicit.

:::leanStatement "Identity generalized functions"
```anchor dlmf_4_12_5 (module := LMLF.Blueprint.Elementary.Section412)
theorem dlmf_4_12_5 (φ : GeneralizedExponential) (ψ : GeneralizedLogarithm)
    {x : ℝ} (hx : x ∈ Set.Icc (0 : ℝ) 1) :
    φ.toFun x = x ∧ ψ.toFun x = x
```
:::
::::

::::dlmfEntry "4.12.6" "https://dlmf.nist.gov/4.12.E6"
$$`\[\varphi(x)=\ln(x+1),\qquad -1<x<0.\]`

On the interval `(-1,0)`, the simplest generalized exponential continues as
the principal real logarithm of `x+1`.

:::leanStatement "Negative-interval generalized exponential"
```anchor dlmf_4_12_6 (module := LMLF.Blueprint.Elementary.Section412)
theorem dlmf_4_12_6 (φ : GeneralizedExponential)
    {x : ℝ} (hx₁ : -1 < x) (hx₂ : x < 0) :
    φ.toFun x = Real.log (x + 1)
```
:::
::::

::::dlmfEntry "4.12.7" "https://dlmf.nist.gov/4.12.E7"
$$`\[\varphi(x)=\underbrace{\exp\cdots\exp}_{\lfloor x\rfloor\ \mathrm{times}}
(x-\lfloor x\rfloor),\qquad x>1.\]`

For `x>1`, let `⌊x⌋` be the natural-number floor.  Apply the ordinary
exponential exactly that many times to the fractional part `x−⌊x⌋`; the
result is the generalized exponential.

:::leanStatement "Iterated-exponential continuation"
```anchor dlmf_4_12_7 (module := LMLF.Blueprint.Elementary.Section412)
theorem dlmf_4_12_7 (φ : GeneralizedExponential)
    {x : ℝ} (hx : 1 < x) :
    φ.toFun x = iteratedExp ⌊x⌋₊ (x - ⌊x⌋₊)
```
:::
::::

::::dlmfEntry "4.12.8" "https://dlmf.nist.gov/4.12.E8"
$$`\[\psi(x)=e^x-1,\qquad -\infty<x<0.\]`

The inverse continuation on the negative half-line is the ordinary
exponential shifted down by one.

:::leanStatement "Negative-half-line generalized logarithm"
```anchor dlmf_4_12_8 (module := LMLF.Blueprint.Elementary.Section412)
theorem dlmf_4_12_8 (ψ : GeneralizedLogarithm)
    {x : ℝ} (hx : x < 0) :
    ψ.toFun x = Real.exp x - 1
```
:::
::::

::::dlmfEntry "4.12.9" "https://dlmf.nist.gov/4.12.E9"
$$`\[\psi(x)=\ell+\underbrace{\ln\cdots\ln}_{\ell\ \mathrm{times}}x,qquad x>1.\]`

For `x>1`, the generalized logarithm is a positive integer `ℓ` plus `ℓ`
successive principal logarithms.  The existential Lean statement records that
positive integer rather than hiding it in an opaque choice.

:::leanStatement "Iterated-logarithm continuation"
```anchor dlmf_4_12_9 (module := LMLF.Blueprint.Elementary.Section412)
theorem dlmf_4_12_9 (ψ : GeneralizedLogarithm)
    {x : ℝ} (hx : 1 < x) :
    ∃ l : ℕ, 0 < l ∧ ψ.toFun x = l + iteratedLog l x
```
:::
::::

::::dlmfEntry "4.12.10" "https://dlmf.nist.gov/4.12.E10"
$$`\[0\le\underbrace{\ln\cdots\ln}_{\ell\ \mathrm{times}}x<1.\]`

The positive integer `ℓ` is selected so that the `ℓ`-fold logarithm lands in
the half-open unit interval.  Every intermediate input to those principal
logarithms must remain positive; this domain guard prevents the totalized
value of `Real.log 0` from creating a second, spurious count.

:::leanStatement "Iteration-count condition"
```anchor dlmf_4_12_10 (module := LMLF.Blueprint.Elementary.Section412)
theorem dlmf_4_12_10 (x : ℝ)
    (hx : 1 < x) :
    ∃! l : ℕ, 0 < l ∧ iteratedLogDefined l x ∧
      0 ≤ iteratedLog l x ∧ iteratedLog l x < 1
```
:::
::::
