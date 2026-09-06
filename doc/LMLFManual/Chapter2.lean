import VersoManual
import LMLF.Quantitative.Basic
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open LMLFManual

#doc (Manual) "Finite families of approximants" =>
%%%
tag := "chapter-2"
%%%

This chapter records only the approximation-family vocabulary introduced by LMLF, rather than a
catalogue of Mathlib's existing finite sums, series, or convergence theory.

:::chapterStatus "https://dlmf.nist.gov/2" "implemented vocabulary"
LMLF's current approximation-family object is deliberately finite-order. It does not claim that the
approximants converge as the order tends to infinity.
:::

::::result "One target, many finite orders" "implemented · QB-001"
*Qualitative view.*

No qualitative asymptotic conclusion is built into this predicate. Such a conclusion requires a
separate theorem showing that the explicit majorants tend to zero in the required regime.

*Quantitative view.*

`HasErrorFamily f a D b` means that order `n` has approximant `a n`, domain `D n`, and explicit
majorant `b n`, all for one fixed target `f`.

:::leanStatement "Expand the checked Lean declaration"
```lean
#check QuantitativeAnalysis.HasErrorFamily
```
:::
::::
