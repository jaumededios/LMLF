import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section61
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual
set_option verso.exampleProject "."

#doc (Manual) "§6.1 Special Notation" =>
%%%
tag := "chapter-6-section-1"
%%%

:::dlmfChapter "https://dlmf.nist.gov/6.1"
Source: NIST Digital Library of Mathematical Functions, §6.1.
:::

# §6.1 Special Notation
%%%
number := false
%%%

Section 6.1 is a notation page, not a formula page.  The source distinguishes
real variables `x`, complex variables `z`, and nonnegative integer indices
`n`; it also uses `δ` for an arbitrary small positive constant and `γ` for
Euler's constant.  Unless a section says otherwise, a prime means derivative
with respect to the displayed function's argument.  The declarations below
make those conventions available to later Lean pages without pretending that
this page contains numbered mathematical identities.

::::dlmfEntry "Real variable" "https://dlmf.nist.gov/6.1#p1.t1.r1"
The symbol `x` denotes a real variable.
:::leanStatement "Real-variable vocabulary"
```anchor dlmf_6_1_real_variable (module := LMLF.Blueprint.ExponentialIntegrals.Section61)
abbrev RealVariable := ℝ
```
:::
::::

::::dlmfEntry "Complex variable" "https://dlmf.nist.gov/6.1#p1.t1.r2"
The symbol `z` denotes a complex variable.
:::leanStatement "Complex-variable vocabulary"
```anchor dlmf_6_1_complex_variable (module := LMLF.Blueprint.ExponentialIntegrals.Section61)
abbrev ComplexVariable := ℂ
```
:::
::::

::::dlmfEntry "Nonnegative integer" "https://dlmf.nist.gov/6.1#p1.t1.r3"
The symbol `n` ranges over the nonnegative integers.
:::leanStatement "Index vocabulary"
```anchor dlmf_6_1_nonnegative_index (module := LMLF.Blueprint.ExponentialIntegrals.Section61)
abbrev NonnegativeIndex := ℕ
```
:::
::::

::::dlmfEntry "Small positive constant" "https://dlmf.nist.gov/6.1#p1.t1.r4"
The symbol `δ` denotes an arbitrary positive constant that may be taken as
small as needed; it is not a fixed numerical value.
:::leanStatement "Small-positive condition"
```anchor dlmf_6_1_small_positive (module := LMLF.Blueprint.ExponentialIntegrals.Section61)
def SmallPositive (δ : ℝ) : Prop := 0 < δ
```
:::
::::

::::dlmfEntry "Euler's constant" "https://dlmf.nist.gov/6.1#p1.t1.r5"
The symbol `γ` is Euler's constant, as defined in DLMF §5.2(ii).
:::leanStatement "Euler constant"
```anchor dlmf_6_1_euler_constant (module := LMLF.Blueprint.ExponentialIntegrals.Section61)
noncomputable abbrev eulerConstant : ℝ := Real.eulerMascheroniConstant
```
:::
::::

The remaining prose records three conventions.  A prime is differentiation
with respect to the argument.  The main functions of the chapter are
`Ei(x)`, `E₁(z)`, `Ein(z)`, `li(x)`, `Si(z)`, `si(z)`, `Ci(z)`, and `Cin(z)`.
Other notation is delegated to the DLMF notation index rather than silently
redefined here.

::::dlmfEntry "Argument derivative" "https://dlmf.nist.gov/6.1#p1"
Primes indicate differentiation with respect to the argument, so the local
Lean vocabulary uses the totalized derivative at a specified complex point.
:::leanStatement "Argument derivative"
```anchor dlmf_6_1_argument_derivative (module := LMLF.Blueprint.ExponentialIntegrals.Section61)
noncomputable def argumentDerivative (f : ℂ → ℂ) (z : ℂ) : ℂ := deriv f z
```
:::
::::

::::dlmfEntry "Chapter 6 functions" "https://dlmf.nist.gov/6.1#p2"
The named family is recorded as vocabulary only; definitions and identities
belong to the later sections.
:::leanStatement "Chapter 6 function names"
```anchor dlmf_6_1_function_names (module := LMLF.Blueprint.ExponentialIntegrals.Section61)
inductive Chapter6Function
  | Ei | E1 | Ein | li | Si | si | Ci | Cin
deriving DecidableEq, Repr
```
:::
::::

::::dlmfEntry "External notation" "https://dlmf.nist.gov/6.1#p3"
The source directs readers to the general DLMF notation index for notation
not introduced on this page; this marker keeps that cross-reference explicit.
:::leanStatement "External notation marker"
```anchor dlmf_6_1_external_notation (module := LMLF.Blueprint.ExponentialIntegrals.Section61)
inductive ExternalNotation
  | notationForSpecialFunctions
deriving DecidableEq, Repr
```
:::
::::

The official inventory contains no numbered formula records in §6.1.  The
eight notation/prose items above are therefore the complete coverage target;
definitions and identities begin on [§6.2](https://dlmf.nist.gov/6.2).
