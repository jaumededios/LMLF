import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section41
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.1 Special Notation" =>
%%%
tag := "chapter-4-section-1"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.1"
Source: NIST Digital Library of Mathematical Functions, §4.1.
:::

Section 4.1 establishes the notation used throughout the elementary-functions chapter.
It introduces no numbered equations.  The table fixes the domains of the recurring
symbols, writes a complex variable as `z = x + i y`, and reserves `e` for the base of
natural logarithms.

::::dlmfEntry "4.1.variables" "https://dlmf.nist.gov/4.1#p1"
The notation table uses the following domains:

| symbols | meaning |
| --- | --- |
| `k`, `m`, `n` | integers |
| `a`, `c` | real or complex constants |
| `x`, `y` | real variables |
| `z = x + i y` | complex variable |
| `e` | base of natural logarithms |

In Lean, integer variables use `ℤ`, real variables use `ℝ`, and constants allowed to
be real or complex are represented in `ℂ`, with real constants inserted by coercion.
The coordinate definition makes the source convention visible, and its two projections
recover `x` and `y`.

:::leanStatement "Lean · variables, coordinates, and the logarithm base"
```anchor IntegerVariable (module := LMLF.Blueprint.Elementary.Section41) -showProofStates
abbrev IntegerVariable := ℤ
```

```anchor RealOrComplexConstant (module := LMLF.Blueprint.Elementary.Section41) -showProofStates
abbrev RealOrComplexConstant := ℂ
```

```anchor RealVariable (module := LMLF.Blueprint.Elementary.Section41) -showProofStates
abbrev RealVariable := ℝ
```

```anchor complexCoordinate (module := LMLF.Blueprint.Elementary.Section41) -showProofStates
def complexCoordinate (x y : ℝ) : ℂ := (x : ℂ) + Complex.I * (y : ℂ)
```

```anchor complexCoordinate_re (module := LMLF.Blueprint.Elementary.Section41) -showProofStates
theorem complexCoordinate_re (x y : ℝ) :
    (complexCoordinate x y).re = x
```

```anchor complexCoordinate_im (module := LMLF.Blueprint.Elementary.Section41) -showProofStates
theorem complexCoordinate_im (x y : ℝ) :
    (complexCoordinate x y).im = y
```

```anchor naturalLogBase (module := LMLF.Blueprint.Elementary.Section41) -showProofStates
noncomputable def naturalLogBase : ℝ := Real.exp 1
```

```anchor naturalLogBase_pos (module := LMLF.Blueprint.Elementary.Section41) -showProofStates
theorem naturalLogBase_pos : 0 < naturalLogBase
```
:::
::::

::::dlmfEntry "4.1.functions" "https://dlmf.nist.gov/4.1#p3"
The chapter assumes familiarity with elementary functions of a real argument `x` and
extends their definitions and properties to a complex argument `z`.  The principal and
general logarithms are written `ln z` and `Ln z`; the exponential is written both `exp z`
and `e^z`.

The circular trigonometric family is
`sin z`, `cos z`, `tan z`, `csc z`, `sec z`, and `cot z`.  The inverse trigonometric
family begins with `arcsin z` and its general counterpart `Arcsin z`, with analogous
capitalization for the other inverse functions.  The hyperbolic family is
`sinh z`, `cosh z`, `tanh z`, `csch z`, `sech z`, and `coth z`; its inverse family begins
with `arcsinh z` and `Arcsinh z`, again continuing by analogy.

These names are the source vocabulary for the definitions in §§4.2–4.37.  The coordinate
convention above is the common interface between real inputs and those complex functions.

:::leanStatement "Lean · complex function domain"
```anchor ComplexFunction (module := LMLF.Blueprint.Elementary.Section41) -showProofStates
abbrev ComplexFunction := ℂ → ℂ
```
:::
::::

::::dlmfEntry "4.1.naming" "https://dlmf.nist.gov/4.1#p5"
The source warns that authors sometimes interchange the meanings of `ln` and `Ln`, or of
lowercase and uppercase inverse-function names such as `arcsin` and `Arcsin`.  It also
notes that an index `−1` may replace the prefix `arc`: for example, `sin⁻¹ z` can denote
`arcsin z`, while `Sin⁻¹ z` can denote `Arcsin z`.  These are notational conventions;
the surrounding definition determines which branch is intended.
::::
