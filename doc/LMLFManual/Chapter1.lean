import VersoManual
import LMLF.Quantitative.Basic
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open LMLFManual

#doc (Manual) "Finite error calculus" =>
%%%
tag := "chapter-1"
%%%

This chapter does not reproduce Mathlib's algebra, calculus, topology, measure theory, or numerical
methods. It documents only LMLF's additional language for finite approximations and explicit error
bounds.

:::chapterStatus "https://dlmf.nist.gov/1" "implemented · bootstrap"
The first layer says exactly what it means for an approximant to have a pointwise error or norm bound
on an ordinary set. Empty domains remain logically valid here; named applications must separately
prove that their advertised domains are reachable.
:::

::::result "Pointwise approximation on a domain" "implemented · QB-001"
*Qualitative view.*

Exact agreement on a domain is the zero-error case.

*Quantitative view.*

`ErrorOn D f a b` records the explicit inequality `‖f x - a x‖ ≤ b x` for every `x ∈ D`.
`NormBoundOn D f b` records `‖f x‖ ≤ b x` on the same kind of domain.

:::leanStatement "Expand the checked Lean declarations"
```lean
#check QuantitativeAnalysis.ErrorOn
#check QuantitativeAnalysis.NormBoundOn
#check QuantitativeAnalysis.ErrorOn.exact
```
:::
::::

::::result "Transporting a finite error bound" "implemented · QB-001"
*Qualitative view.*

The same approximation remains valid after restricting its domain, weakening its majorant, or
reparameterizing the domain.

*Quantitative view.*

Error bounds compose by the triangle inequality: bounds `b` and `d` produce the visible bound
`b + d`. No asymptotic notation or unnamed constant is introduced.

:::leanStatement "Expand the checked Lean declarations"
```lean
#check QuantitativeAnalysis.ErrorOn.restrict
#check QuantitativeAnalysis.ErrorOn.weaken
#check QuantitativeAnalysis.ErrorOn.trans
#check QuantitativeAnalysis.ErrorOn.comp
```
:::
::::
