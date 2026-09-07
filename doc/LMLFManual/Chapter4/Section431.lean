import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section431
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
set_option verso.exampleProject "."

#doc (Manual) "§4.31 Special Values and Limits" =>
%%%
tag := "chapter-4-section-31"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.31"
Source: NIST Digital Library of Mathematical Functions, §4.31, Special Values and Limits.
:::

# §4.31 Special Values and Limits
%%%
number := false
%%%

Source: [DLMF §4.31](https://dlmf.nist.gov/4.31).

The table in this section lists values of the six hyperbolic functions at
`0`, `πi/2`, `πi`, and `3πi/2`, followed by their behavior at infinity. At a
pole, the printed `∞` or `±∞ i` is a directional limiting value, not Lean's
totalized value of division by zero. The disclosures therefore record the
vanishing denominator as a pole marker and state every finite table entry
literally. The infinity column is stated along the positive real axis, which
is the honest real specialization of the table's asymptotic column.

## Limits at the origin

DLMF 4.31.1 and 4.31.2 say that both `sinh z` and `tanh z` are asymptotic to
`z` as `z → 0` through nonzero complex values. DLMF 4.31.3 gives the
quadratic expansion of `cosh`: after subtracting its value `1` at the origin
and dividing by `z²`, the limit is `1/2`. These are genuine punctured
complex-neighborhood limits, not merely real-axis derivatives.

::::dlmfEntry "4.31.1" "https://dlmf.nist.gov/4.31.E1"
The quotient `sinh z / z` tends to 1 as nonzero complex `z` tends to zero.
:::leanStatement "DLMF 4.31.1"
```anchor dlmf_4_31_1 (module := LMLF.Blueprint.Elementary.Section431)
theorem dlmf_4_31_1 :
    Tendsto (fun z : ℂ => Complex.sinh z / z) puncturedOrigin (nhds 1)
```
:::
::::

::::dlmfEntry "4.31.2" "https://dlmf.nist.gov/4.31.E2"
The quotient `tanh z / z` has the same punctured complex limit 1.
:::leanStatement "DLMF 4.31.2"
```anchor dlmf_4_31_2 (module := LMLF.Blueprint.Elementary.Section431)
theorem dlmf_4_31_2 :
    Tendsto (fun z : ℂ => Complex.tanh z / z) puncturedOrigin (nhds 1)
```
:::
::::

::::dlmfEntry "4.31.3" "https://dlmf.nist.gov/4.31.E3"
The normalized quadratic remainder of `cosh z` tends to `1/2` at the origin.
:::leanStatement "DLMF 4.31.3"
```anchor dlmf_4_31_3 (module := LMLF.Blueprint.Elementary.Section431)
theorem dlmf_4_31_3 :
    Tendsto (fun z : ℂ => (Complex.cosh z - 1) / z ^ 2) puncturedOrigin (nhds (1 / 2))
```
:::
::::

## Table 4.31.1: values at imaginary multiples of π/2

The table columns are `z = 0, πi/2, πi, 3πi/2, ∞`. The first four columns
are exact complex values. For the entries printed as infinity, the formal
record uses the relevant zero of `sinh` or `cosh` (or the resulting pole of
`tanh`/`coth`) rather than silently assigning a finite value through Lean's
division convention. The final column is given along real `x → +∞`.

::::dlmfEntry "4.31.T1.t1.r1" "https://dlmf.nist.gov/4.31.T1"
The argument columns are the four imaginary-axis sample points followed by the infinity column.
:::leanStatement "DLMF 4.31 Table 4.31.1 header"
```anchor dlmf_4_31_T1_header (module := LMLF.Blueprint.Elementary.Section431)
theorem dlmf_4_31_T1_header :
    zHalf = (Real.pi / 2 : ℂ) * Complex.I ∧
    zFull = (Real.pi : ℂ) * Complex.I ∧
    zThreeHalf = (3 * Real.pi / 2 : ℂ) * Complex.I
```
:::
::::

::::dlmfEntry "4.31.T1.t1.r2" "https://dlmf.nist.gov/4.31.T1"
The sinh row is `0, i, 0, -i`, and grows without bound on the positive real axis.
:::leanStatement "DLMF 4.31 Table 4.31.1 sinh row"
```anchor dlmf_4_31_T1_sinh (module := LMLF.Blueprint.Elementary.Section431)
theorem dlmf_4_31_T1_sinh :
    Complex.sinh 0 = 0 ∧ Complex.sinh zHalf = Complex.I ∧
    Complex.sinh zFull = 0 ∧ Complex.sinh zThreeHalf = -Complex.I ∧
    Tendsto Real.sinh atTop atTop
```
:::
::::

::::dlmfEntry "4.31.T1.t1.r3" "https://dlmf.nist.gov/4.31.T1"
The cosh row is `1, 0, -1, 0`, with positive-real limit infinity.
:::leanStatement "DLMF 4.31 Table 4.31.1 cosh row"
```anchor dlmf_4_31_T1_cosh (module := LMLF.Blueprint.Elementary.Section431)
theorem dlmf_4_31_T1_cosh :
    Complex.cosh 0 = 1 ∧ Complex.cosh zHalf = 0 ∧
    Complex.cosh zFull = -1 ∧ Complex.cosh zThreeHalf = 0 ∧
    Tendsto Real.cosh atTop atTop
```
:::
::::

::::dlmfEntry "4.31.T1.caption" "https://dlmf.nist.gov/4.31.T1"
The table caption is represented by a cross-row check of its characteristic imaginary-axis entries.
:::leanStatement "DLMF 4.31 Table 4.31.1 caption"
```anchor dlmf_4_31_T1_caption (module := LMLF.Blueprint.Elementary.Section431)
theorem dlmf_4_31_T1_caption :
    Complex.sinh zHalf = Complex.I ∧ Complex.cosh zHalf = 0 ∧
    Complex.tanh zFull = 0 ∧ 1 / Complex.cosh zFull = -1
```
:::
::::

::::dlmfEntry "4.31.T1.t1.r4" "https://dlmf.nist.gov/4.31.T1"
The tanh row is zero at the finite non-pole sample points, has poles where cosh vanishes, and tends to 1 on the positive real axis.
:::leanStatement "DLMF 4.31 Table 4.31.1 tanh row"
```anchor dlmf_4_31_T1_tanh (module := LMLF.Blueprint.Elementary.Section431)
theorem dlmf_4_31_T1_tanh :
    Complex.tanh 0 = 0 ∧ Complex.cosh zHalf = 0 ∧
    Complex.tanh zFull = 0 ∧ Complex.cosh zThreeHalf = 0 ∧
    Tendsto Real.tanh atTop (nhds 1)
```
:::
::::

::::dlmfEntry "4.31.T1.t1.r5" "https://dlmf.nist.gov/4.31.T1"
The csch row has poles at the zeros of sinh, finite values `-i` and `i` at the other two sample points, and tends to zero on the positive real axis.
:::leanStatement "DLMF 4.31 Table 4.31.1 csch row"
```anchor dlmf_4_31_T1_csch (module := LMLF.Blueprint.Elementary.Section431)
theorem dlmf_4_31_T1_csch :
    Complex.sinh 0 = 0 ∧ 1 / Complex.sinh zHalf = -Complex.I ∧
    Complex.sinh zFull = 0 ∧ 1 / Complex.sinh zThreeHalf = Complex.I ∧
    Tendsto (fun x : ℝ => 1 / Real.sinh x) atTop (nhds 0)
```
:::
::::

::::dlmfEntry "4.31.T1.t1.r6" "https://dlmf.nist.gov/4.31.T1"
The sech row is `1, pole, -1, pole`, with positive-real limit zero.
:::leanStatement "DLMF 4.31 Table 4.31.1 sech row"
```anchor dlmf_4_31_T1_sech (module := LMLF.Blueprint.Elementary.Section431)
theorem dlmf_4_31_T1_sech :
    1 / Complex.cosh 0 = 1 ∧ Complex.cosh zHalf = 0 ∧
    1 / Complex.cosh zFull = -1 ∧ Complex.cosh zThreeHalf = 0 ∧
    Tendsto (fun x : ℝ => 1 / Real.cosh x) atTop (nhds 0)
```
:::
::::

::::dlmfEntry "4.31.T1.t1.r7" "https://dlmf.nist.gov/4.31.T1"
The coth row has poles at the zeros of sinh, zeros at the other two sample points, and tends to 1 on the positive real axis.
:::leanStatement "DLMF 4.31 Table 4.31.1 coth row"
```anchor dlmf_4_31_T1_coth (module := LMLF.Blueprint.Elementary.Section431)
theorem dlmf_4_31_T1_coth :
    Complex.sinh 0 = 0 ∧ 1 / Complex.tanh zHalf = 0 ∧
    Complex.sinh zFull = 0 ∧ 1 / Complex.tanh zThreeHalf = 0 ∧
    Tendsto (fun x : ℝ => Real.cosh x / Real.sinh x) atTop (nhds 1)
```
:::
::::

The page note cites Hobson and Levinson–Redheffer as references for these
special values and limits. The table is the substantive source content; the
following disclosure records its two representative limit families without
inventing an additional quantitative estimate.

::::dlmfEntry "4.31.p1" "https://dlmf.nist.gov/4.31"
The prose surrounding the table concerns the same punctured complex limits at the origin.
:::leanStatement "DLMF 4.31 prose"
```anchor dlmf_4_31_p1 (module := LMLF.Blueprint.Elementary.Section431)
theorem dlmf_4_31_p1 :
    Tendsto (fun z : ℂ => Complex.sinh z / z) puncturedOrigin (nhds 1) ∧
    Tendsto (fun z : ℂ => Complex.tanh z / z) puncturedOrigin (nhds 1)
```
:::
::::

::::dlmfEntry "4.31.info" "https://dlmf.nist.gov/4.31#info"
The NIST note identifies standard references for the displayed special values and limits.
:::leanStatement "DLMF 4.31 notes"
```anchor dlmf_4_31_notes (module := LMLF.Blueprint.Elementary.Section431)
theorem dlmf_4_31_notes :
    Tendsto (fun z : ℂ => Complex.sinh z / z) puncturedOrigin (nhds 1) ∧
    Tendsto (fun z : ℂ => (Complex.cosh z - 1) / z ^ 2) puncturedOrigin (nhds (1 / 2))
```
:::
::::
