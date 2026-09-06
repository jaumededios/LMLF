import VersoManual
import LMLFManual.Components

open Verso.Genre Manual
open LMLFManual

#doc (Manual) "Improper integrals, series, and source recovery" =>
%%%
tag := "chapter-3"
%%%

This chapter contains only the source-independent analytic language and Olver-facing theorem route
that are new to LMLF. General integration and series theory already in Mathlib are not duplicated.

:::chapterStatus "https://dlmf.nist.gov/3" "specified · not on main"
The next source-independent layer gives ordinary improper integrals with finitely many exceptional
points, followed by explicit Laplace-remainder bounds. It is specified separately from numerical
algorithms and is not yet part of the accepted site dependency.
:::

:::result "Finite-exceptional improper integration" "specified · IMP-001"
*Qualitative view.*

An improper value is the sum of independently convergent one-sided component limits. Principal-value
cancellation across an exceptional point is excluded.

*Quantitative view.*

The frozen packet specifies eight public targets: the relation and uniqueness theorem, a normalized
continuous-primitive characterization, linear transport, local splitting, an absolute-Bochner bridge,
and Abel composition. No accepted declaration is shown until that packet lands on `main`.
:::

:::result "Watson's lemma: closest current Olver-facing statement" "proof draft · OLV-001"
*Qualitative view.*

The planned source-recovery theorem says that the Laplace transform has Olver's asymptotic expansion
when the amplitude has the corresponding expansion at the origin and the ordinary improper transform
exists for all sufficiently large positive parameters.

*Quantitative view.*

For each truncation order `n`, the current proof draft produces positive local constants and bounds the
remainder by a Gamma-weighted power term plus an exponentially decaying tail term. The constants may
depend on `n`; the baseline convergence parameter is chosen once before `n`.

With $`\beta_s=(s+\lambda)/\mu`, the draft's finite conclusion is
$$`\left\lVert Q_{n,x}-\sum_{s=0}^{n-1}a_s\Gamma(\beta_s)x^{-\beta_s}\right\rVert
\le K_n\Gamma(\beta_n)x^{-\beta_n}+L_ne^{-(x-X)k_n}`
for every $`x>X`, after one $`X>0` is chosen independently of `n`. The related improper value
$`Q_{n,x}` is unique for fixed source data and `x`, despite being introduced within the fixed-order
conclusion.

There is no Lean disclosure here: `QL-001`, `OLV-001`, and the qualitative `SR-001` bridge remain
planning artifacts rather than accepted declarations.
:::
