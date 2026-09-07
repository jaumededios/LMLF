import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section430
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual
open LMLF.Blueprint.Elementary.Section430

set_option verso.exampleProject "."

#doc (Manual) "§4.30 Elementary Properties" =>
%%%
tag := "chapter-4-section-30"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.30"
Source: NIST Digital Library of Mathematical Functions, §4.30, Elementary Properties.
:::

# §4.30 Elementary Properties
%%%
number := false
%%%

Section 4.30 consists of Table 4.30.1, a six-by-six interrelation table for
the hyperbolic functions.  Its rows are indexed by the known value `a` of one
function, and its columns give the corresponding value of each of
`sinh θ`, `cosh θ`, `tanh θ`, `csch θ`, `sech θ`, and `coth θ`.  The source
specifies that every square root is the principal value when the functions are
real, nonnegative, and finite.  The Lean table is therefore a real-valued
specialization of the source table; its `Real.sqrt` expressions make the
principal-root convention explicit.  As with ordinary Lean division, values
outside the source's finite nonnegative regime are totalized rather than
silently treated as additional mathematical cases.

## Table 4.30.1 — Hyperbolic functions: interrelations
%%%
number := false
%%%

Source: [DLMF Table 4.30.1](https://dlmf.nist.gov/4.30.T1).
The column-heading row is [T1.t1.r1](https://dlmf.nist.gov/4.30#T1.t1.r1).

The first table row records the six column headings `f(θ)=a`; the six data
rows below it are the interrelations for `sinh`, `cosh`, `tanh`, `csch`, `sech`,
and `coth`.
Writing `√` for the principal real square root, the table is:

| known function | `sinh θ = a` | `cosh θ = a` | `tanh θ = a` | `csch θ = a` | `sech θ = a` | `coth θ = a` |
|---|---|---|---|---|---|---|
| `sinh θ` | `a` | `√(a²−1)` | `a/√(1−a²)` | `a⁻¹` | `a⁻¹√(1−a²)` | `(a²−1)⁻¹/²` |
| `cosh θ` | `√(1+a²)` | `a` | `(1−a²)⁻¹/²` | `a⁻¹√(1+a²)` | `a⁻¹` | `a(a²−1)⁻¹/²` |
| `tanh θ` | `a/√(1+a²)` | `a⁻¹√(a²−1)` | `a` | `(1+a²)⁻¹/²` | `√(1−a²)` | `a⁻¹` |
| `csch θ` | `a⁻¹` | `(a²−1)⁻¹/²` | `a⁻¹√(1−a²)` | `a` | `a(1−a²)⁻¹/²` | `√(a²−1)` |
| `sech θ` | `(1+a²)⁻¹/²` | `a⁻¹` | `√(1−a²)` | `a(1+a²)⁻¹/²` | `a` | `a⁻¹√(a²−1)` |
| `coth θ` | `a⁻¹√(a²+1)` | `a(a²−1)⁻¹/²` | `a⁻¹` | `√(a²+1)` | `(1−a²)⁻¹/²` | `a` |

Each row below is a reusable Lean record of those six expressions.  The
`label` field keeps the row heading attached to its formulas.

:::leanStatement "Table row vocabulary"
```anchor HyperbolicInterrelationRow (module := LMLF.Blueprint.Elementary.Section430)
structure HyperbolicInterrelationRow where
  label : String
  sinhColumn : ℝ → ℝ
  coshColumn : ℝ → ℝ
  tanhColumn : ℝ → ℝ
  cschColumn : ℝ → ℝ
  sechColumn : ℝ → ℝ
  cothColumn : ℝ → ℝ
```
:::

::::dlmfEntry "4.30.T1.t1.r2" "https://dlmf.nist.gov/4.30#T1.t1.r2"
The `sinh θ` row gives the other five hyperbolic values in terms of
`sinh θ=a`, with the principal-root and finite-real convention stated above.

:::leanStatement "sinh row"
```anchor table4301_sinhRow (module := LMLF.Blueprint.Elementary.Section430)
def table4301_sinhRow : HyperbolicInterrelationRow :=
  { label := "sinh"
    sinhColumn := fun a => a
    coshColumn := fun a => Real.sqrt (a ^ 2 - 1)
    tanhColumn := fun a => a / Real.sqrt (1 - a ^ 2)
    cschColumn := fun a => 1 / a
    sechColumn := fun a => Real.sqrt (1 - a ^ 2) / a
    cothColumn := fun a => 1 / Real.sqrt (a ^ 2 - 1) }
```
:::
::::

::::dlmfEntry "4.30.T1.t1.r3" "https://dlmf.nist.gov/4.30#T1.t1.r3"
The `cosh θ` row gives the corresponding expressions when `cosh θ=a`.

:::leanStatement "cosh row"
```anchor table4301_coshRow (module := LMLF.Blueprint.Elementary.Section430)
def table4301_coshRow : HyperbolicInterrelationRow :=
  { label := "cosh"
    sinhColumn := fun a => Real.sqrt (1 + a ^ 2)
    coshColumn := fun a => a
    tanhColumn := fun a => 1 / Real.sqrt (1 - a ^ 2)
    cschColumn := fun a => Real.sqrt (1 + a ^ 2) / a
    sechColumn := fun a => 1 / a
    cothColumn := fun a => a / Real.sqrt (a ^ 2 - 1) }
```
:::
::::

::::dlmfEntry "4.30.T1.t1.r4" "https://dlmf.nist.gov/4.30#T1.t1.r4"
The `tanh θ` row gives the reciprocal and square-root transformations for
`tanh θ=a`.

:::leanStatement "tanh row"
```anchor table4301_tanhRow (module := LMLF.Blueprint.Elementary.Section430)
def table4301_tanhRow : HyperbolicInterrelationRow :=
  { label := "tanh"
    sinhColumn := fun a => a / Real.sqrt (1 + a ^ 2)
    coshColumn := fun a => Real.sqrt (a ^ 2 - 1) / a
    tanhColumn := fun a => a
    cschColumn := fun a => 1 / Real.sqrt (1 + a ^ 2)
    sechColumn := fun a => Real.sqrt (1 - a ^ 2)
    cothColumn := fun a => 1 / a }
```
:::
::::

::::dlmfEntry "4.30.T1.t1.r5" "https://dlmf.nist.gov/4.30#T1.t1.r5"
The `csch θ` row gives the transformations for `csch θ=a`.

:::leanStatement "csch row"
```anchor table4301_cschRow (module := LMLF.Blueprint.Elementary.Section430)
def table4301_cschRow : HyperbolicInterrelationRow :=
  { label := "csch"
    sinhColumn := fun a => 1 / a
    coshColumn := fun a => 1 / Real.sqrt (a ^ 2 - 1)
    tanhColumn := fun a => Real.sqrt (1 - a ^ 2) / a
    cschColumn := fun a => a
    sechColumn := fun a => a / Real.sqrt (1 - a ^ 2)
    cothColumn := fun a => Real.sqrt (a ^ 2 - 1) }
```
:::
::::

::::dlmfEntry "4.30.T1.t1.r6" "https://dlmf.nist.gov/4.30#T1.t1.r6"
The `sech θ` row gives the transformations for `sech θ=a`.

:::leanStatement "sech row"
```anchor table4301_sechRow (module := LMLF.Blueprint.Elementary.Section430)
def table4301_sechRow : HyperbolicInterrelationRow :=
  { label := "sech"
    sinhColumn := fun a => 1 / Real.sqrt (1 + a ^ 2)
    coshColumn := fun a => 1 / a
    tanhColumn := fun a => Real.sqrt (1 - a ^ 2)
    cschColumn := fun a => a / Real.sqrt (1 + a ^ 2)
    sechColumn := fun a => a
    cothColumn := fun a => Real.sqrt (a ^ 2 - 1) / a }
```
:::
::::

::::dlmfEntry "4.30.T1.t1.r7" "https://dlmf.nist.gov/4.30#T1.t1.r7"
The `coth θ` row gives the transformations for `coth θ=a`.

:::leanStatement "coth row"
```anchor table4301_cothRow (module := LMLF.Blueprint.Elementary.Section430)
def table4301_cothRow : HyperbolicInterrelationRow :=
  { label := "coth"
    sinhColumn := fun a => Real.sqrt (a ^ 2 + 1) / a
    coshColumn := fun a => a * Real.sqrt (a ^ 2 - 1)⁻¹
    tanhColumn := fun a => 1 / a
    cschColumn := fun a => Real.sqrt (a ^ 2 + 1)
    sechColumn := fun a => Real.sqrt (1 - a ^ 2)⁻¹
    cothColumn := fun a => a }
```
:::
::::

The six records are assembled in source-table order, preserving the table's
row hierarchy for downstream use.

:::leanStatement "Complete Table 4.30.1"
```anchor table4301 (module := LMLF.Blueprint.Elementary.Section430)
def table4301 : List HyperbolicInterrelationRow :=
  [table4301_sinhRow, table4301_coshRow, table4301_tanhRow,
    table4301_cschRow, table4301_sechRow, table4301_cothRow]
```
:::

The [source note](https://dlmf.nist.gov/4.30#info) cites Hobson (1928),
pages 323–326, for these elementary properties.  The neighboring sections are [§4.29 Graphics](https://dlmf.nist.gov/4.29)
and [§4.31 Special Values and Limits](https://dlmf.nist.gov/4.31).
