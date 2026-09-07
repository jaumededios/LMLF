import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section434
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.34 Derivatives and Differential Equations" =>
%%%
tag := "chapter-4-section-34"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.34"
Source: NIST Digital Library of Mathematical Functions, §4.34.
:::

# §4.34 Derivatives and Differential Equations
%%%
number := false
%%%

All variables are complex.  E1–E6 are local derivative identities; reciprocal
functions are stated only away from their poles.  E7–E10 are differential
equation predicates for a candidate `w`, whereas E11–E14 record the displayed
solution families or their derivative consequences with `a ≠ 0` and the
relevant pole conditions explicit.  This keeps local calculus facts distinct
from global classifications.  The source points to Kamke for further ODEs.

::::dlmfEntry "4.34.1" "https://dlmf.nist.gov/4.34.E1"
$$`\frac{d}{dz}\sinh z=\cosh z`$$
:::leanStatement "Derivative of sinh"
```anchor dlmf_4_34_1 (module := LMLF.Blueprint.Elementary.Section434)
theorem dlmf_4_34_1 (z : ℂ) : HasDerivAt Complex.sinh (Complex.cosh z) z := by sorry
```
:::
::::

::::dlmfEntry "4.34.2" "https://dlmf.nist.gov/4.34.E2"
$$`\frac{d}{dz}\cosh z=\sinh z`$$
:::leanStatement "Derivative of cosh"
```anchor dlmf_4_34_2 (module := LMLF.Blueprint.Elementary.Section434)
theorem dlmf_4_34_2 (z : ℂ) : HasDerivAt Complex.cosh (Complex.sinh z) z := by sorry
```
:::
::::

::::dlmfEntry "4.34.3–4.34.6" "https://dlmf.nist.gov/4.34.E3"
The quotient derivatives are `tanh' = sech²`, `csch' = -csch·coth`,
`sech' = -sech·tanh`, and `coth' = -csch²`.  Their Lean statements expose
nonzero denominator hypotheses rather than silently treating poles as ordinary
points.  The four source links are [E3](https://dlmf.nist.gov/4.34.E3),
[E4](https://dlmf.nist.gov/4.34.E4), [E5](https://dlmf.nist.gov/4.34.E5), and
[E6](https://dlmf.nist.gov/4.34.E6).
:::leanStatement "Hyperbolic reciprocal derivatives"
```anchor dlmf_4_34_3 (module := LMLF.Blueprint.Elementary.Section434)
theorem dlmf_4_34_3 (z : ℂ) (h : Complex.cosh z ≠ 0) :
    HasDerivAt Complex.tanh ((1 / Complex.cosh z) ^ 2) z := by sorry
```
```anchor dlmf_4_34_4 (module := LMLF.Blueprint.Elementary.Section434)
theorem dlmf_4_34_4 (z : ℂ) (hs : Complex.sinh z ≠ 0) (hc : Complex.tanh z ≠ 0) :
    HasDerivAt (fun z => 1 / Complex.sinh z)
      (-(1 / Complex.sinh z) * (1 / Complex.tanh z)) z := by sorry
```
```anchor dlmf_4_34_5 (module := LMLF.Blueprint.Elementary.Section434)
theorem dlmf_4_34_5 (z : ℂ) (hc : Complex.cosh z ≠ 0) :
    HasDerivAt (fun z => 1 / Complex.cosh z)
      (-(1 / Complex.cosh z) * Complex.tanh z) z := by sorry
```
```anchor dlmf_4_34_6 (module := LMLF.Blueprint.Elementary.Section434)
theorem dlmf_4_34_6 (z : ℂ) (ht : Complex.tanh z ≠ 0) (hs : Complex.sinh z ≠ 0) :
    HasDerivAt (fun z => 1 / Complex.tanh z) (-(1 / Complex.sinh z) ^ 2) z := by sorry
```
:::
::::

::::dlmfEntry "4.34.7–4.34.10" "https://dlmf.nist.gov/4.34.E7"
For `a ≠ 0`, the source introduces the second-order equation
`w''-a²w=0`, the two first integrals with right sides `1` and `-1`, and the
Riccati equation `w'+a²w²=1`.  The reusable predicates below are instantiated
only on the named hyperbolic solution families; they do not assert an ODE for
an arbitrary unconstrained function.  See the
individual source links [E7](https://dlmf.nist.gov/4.34.E7),
[E8](https://dlmf.nist.gov/4.34.E8), [E9](https://dlmf.nist.gov/4.34.E9), and
[E10](https://dlmf.nist.gov/4.34.E10).
:::leanStatement "Differential-equation predicates"
```anchor dlmf_4_34_7 (module := LMLF.Blueprint.Elementary.Section434)
theorem dlmf_4_34_7 (a : ℂ) (ha : a ≠ 0) (A B : ℂ) :
    secondOrderODE a (fun z => A * Complex.cosh (a * z) + B * Complex.sinh (a * z)) := by sorry
```
```anchor dlmf_4_34_8 (module := LMLF.Blueprint.Elementary.Section434)
theorem dlmf_4_34_8 (a c : ℂ) (ha : a ≠ 0) :
    quadraticPlusODE a (fun z => (1 / a) * Complex.sinh (a * z + c)) := by sorry
```
```anchor dlmf_4_34_9 (module := LMLF.Blueprint.Elementary.Section434)
theorem dlmf_4_34_9 (a c : ℂ) (ha : a ≠ 0) :
    quadraticMinusODE a (fun z => (1 / a) * Complex.cosh (a * z + c)) := by sorry
```
```anchor dlmf_4_34_10 (module := LMLF.Blueprint.Elementary.Section434)
theorem dlmf_4_34_10 (a c : ℂ) (ha : a ≠ 0) :
    riccatiODE a (fun z => (1 / a) * Complex.tanh (a * z + c)) := by sorry
```
:::
::::

::::dlmfEntry "4.34.11–4.34.14" "https://dlmf.nist.gov/4.34.E11"
The complete second-order family is `A cosh(az)+B sinh(az)`; the remaining
source displays give the sinh, cosh, and coth parametrizations with arbitrary
constant `c`.  The Lean signatures retain `a ≠ 0`, and E14 excludes zeros of
`sinh(az+c)` before differentiating the coth chart.  Direct links: [E11](https://dlmf.nist.gov/4.34.E11), [E12](https://dlmf.nist.gov/4.34.E12), [E13](https://dlmf.nist.gov/4.34.E13), and [E14](https://dlmf.nist.gov/4.34.E14).
:::leanStatement "Solution-family consequences"
```anchor dlmf_4_34_11 (module := LMLF.Blueprint.Elementary.Section434)
theorem dlmf_4_34_11 (a : ℂ) (ha : a ≠ 0) (A B : ℂ) :
    ∀ z, deriv (deriv (fun z => A * Complex.cosh (a * z) + B * Complex.sinh (a * z))) z -
      a ^ 2 * (A * Complex.cosh (a * z) + B * Complex.sinh (a * z)) = 0 := by sorry
```
```anchor dlmf_4_34_12 (module := LMLF.Blueprint.Elementary.Section434)
theorem dlmf_4_34_12 (a c z : ℂ) (ha : a ≠ 0) :
    HasDerivAt (fun z => (1 / a) * Complex.sinh (a * z + c))
      (Complex.cosh (a * z + c)) z := by sorry
```
```anchor dlmf_4_34_13 (module := LMLF.Blueprint.Elementary.Section434)
theorem dlmf_4_34_13 (a c z : ℂ) (ha : a ≠ 0) :
    HasDerivAt (fun z => (1 / a) * Complex.cosh (a * z + c))
      (Complex.sinh (a * z + c)) z := by sorry
```
```anchor dlmf_4_34_14 (module := LMLF.Blueprint.Elementary.Section434)
theorem dlmf_4_34_14 (a c z : ℂ) (ha : a ≠ 0)
    (hpole : Complex.sinh (a * z + c) ≠ 0) :
    HasDerivAt (fun z => (1 / a) * (Complex.cosh (a * z + c) / Complex.sinh (a * z + c)))
      (-(1 / Complex.sinh (a * z + c)) ^ 2) z := by sorry
```
:::
::::
