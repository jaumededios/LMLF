import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section429
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
set_option verso.exampleProject "."

#doc (Manual) "§4.29 Graphics" =>
%%%
tag := "chapter-4-section-29"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.29"
Source: NIST Digital Library of Mathematical Functions, §4.29, Graphics.
:::

# §4.29 Graphics
%%%
number := false
%%%

Source: [DLMF §4.29](https://dlmf.nist.gov/4.29).

## §4.29(i) Real arguments

The DLMF notes that these graphs were produced at NIST. Figure 4.29.1 plots
the real functions `sinh x` and `cosh x`; the first disclosure records the
strict positivity of `cosh` and the ordering `-cosh x < sinh x < cosh x`.
Figure 4.29.2 plots the principal values of `arcsinh x` and `arccosh x`;
for real arguments, `cosh` has range `[1,∞)`, so the inverse cosine is real
there and complex below 1. Figure 4.29.3 plots `tanh x` and `coth x`:
`tanh` stays strictly between -1 and 1, while `coth` is its reciprocal away
from the pole at zero. Figure 4.29.4 displays the corresponding principal
inverse values and the real coth range outside the unit interval.  The
complex coth preimage statement below is restricted away from zeros of `sinh`,
so Lean's totalized value at a pole is not treated as an inverse value.

Figures 4.29.5 and 4.29.6 show `csch`/`sech` and their principal inverses.
The real graph has `sinh x = 0` exactly at the csch pole, whereas `cosh x`
never vanishes; consequently `sech x` takes values in `(0,1]`. The six
figure disclosures below are honest real-argument statements about the
plotted branches, and do not pretend that a picture is a numbered identity.

::::dlmfEntry "4.29.F1" "https://dlmf.nist.gov/4.29.F1"
The plotted real branches satisfy the strict ordering and positivity shown in Figure 4.29.1.
:::leanStatement "DLMF 4.29 Figure 4.29.1"
```anchor dlmf_4_29_F1 (module := LMLF.Blueprint.Elementary.Section429)
theorem dlmf_4_29_F1 (x : ℝ) :
    0 < Real.cosh x ∧ -Real.cosh x < Real.sinh x ∧ Real.sinh x < Real.cosh x
```
:::
::::

::::dlmfEntry "4.29.F2" "https://dlmf.nist.gov/4.29.F2"
The real part of the principal arccosh graph is supported by the real range of cosh, while the plotted inverse is complex below 1.
:::leanStatement "DLMF 4.29 Figure 4.29.2"
```anchor dlmf_4_29_F2 (module := LMLF.Blueprint.Elementary.Section429)
theorem dlmf_4_29_F2 (x : ℝ) :
    (1 ≤ x → ∃ y : ℝ, Real.cosh y = x) ∧
    (x < 1 → ¬ ∃ y : ℝ, Real.cosh y = x) ∧
    (x < 1 → ∀ y : ℂ, Complex.cosh y = x → y.im ≠ 0)
```
:::
::::

::::dlmfEntry "4.29.F3" "https://dlmf.nist.gov/4.29.F3"
Figure 4.29.3 records the bounded tanh branch and the reciprocal coth branch away from its pole.
:::leanStatement "DLMF 4.29 Figure 4.29.3"
```anchor dlmf_4_29_F3 (module := LMLF.Blueprint.Elementary.Section429)
theorem dlmf_4_29_F3 (x : ℝ) :
    -1 < Real.tanh x ∧ Real.tanh x < 1 ∧
    (x ≠ 0 → 1 / Real.tanh x = Real.cosh x / Real.sinh x)
```
:::
::::

::::dlmfEntry "4.29.F4" "https://dlmf.nist.gov/4.29.F4"
The real coth range is strictly outside the closed unit interval: the boundary values `±1` are limiting values and are not attained at finite nonzero real arguments. Its inverse graph is complex on the interior interval; the formal complex preimage clause below requires `sinh y ≠ 0` so that a totalized pole value is not counted. The arctanh graph is complex outside the closed unit interval.
:::leanStatement "DLMF 4.29 Figure 4.29.4"
```anchor dlmf_4_29_F4 (module := LMLF.Blueprint.Elementary.Section429)
theorem dlmf_4_29_F4 (x : ℝ) :
    (1 < |x| → ∃ y : ℝ, y ≠ 0 ∧ Real.cosh y / Real.sinh y = x) ∧
    (|x| ≤ 1 → ¬ ∃ y : ℝ, y ≠ 0 ∧ Real.cosh y / Real.sinh y = x) ∧
    ((x < -1 ∨ 1 < x) →
      ∀ y : ℂ, Complex.tanh y = x → y.im ≠ 0) ∧
    ((-1 < x ∧ x < 1) →
      ∀ y : ℂ, Complex.sinh y ≠ 0 →
        Complex.cosh y / Complex.sinh y = x → y.im ≠ 0)
```
:::
::::

::::dlmfEntry "4.29.F5" "https://dlmf.nist.gov/4.29.F5"
The csch pole and the everywhere-finite sech denominator are stated explicitly for Figure 4.29.5.
:::leanStatement "DLMF 4.29 Figure 4.29.5"
```anchor dlmf_4_29_F5 (module := LMLF.Blueprint.Elementary.Section429)
theorem dlmf_4_29_F5 (x : ℝ) :
    (Real.sinh x = 0 ↔ x = 0) ∧ Real.cosh x ≠ 0
```
:::
::::

::::dlmfEntry "4.29.F6" "https://dlmf.nist.gov/4.29.F6"
Figure 4.29.6 uses the principal inverse branches of csch and sech; the real sech range is `(0,1]`, so the principal arcsech branch is complex for targets `x < 0` or `x > 1`.
:::leanStatement "DLMF 4.29 Figure 4.29.6"
```anchor dlmf_4_29_F6 (module := LMLF.Blueprint.Elementary.Section429)
theorem dlmf_4_29_F6 (x : ℝ) :
    0 < 1 / Real.cosh x ∧ 1 / Real.cosh x ≤ 1 ∧
    ((x < 0 ∨ 1 < x) →
      ∀ y : ℂ, 1 / Complex.cosh y = x → y.im ≠ 0)
```
:::
::::

## §4.29(ii) Complex arguments

The complex-argument paragraph explains that the conformal map `w = sinh z`
is obtained from the corresponding sine map by rotating both planes through
`π/2`, and it points readers to equations 4.28.8–4.28.13. It also says that
the surfaces for the complex hyperbolic and inverse hyperbolic functions are
similar to those in §4.15(iii). The following two disclosures make those
relations explicit: multiplication of the argument by `i` transports sine
and cosine to sinh and cosh, and transports tangent to tanh. These are
complex identities, not real-graph approximations.

::::dlmfEntry "4.29.ii.p1" "https://dlmf.nist.gov/4.29.ii#ii.p1"
The rotation relation for the conformal map is the paired sine/sinh and cosine/cosh identity.
:::leanStatement "DLMF 4.29(ii) first prose block"
```anchor dlmf_4_29_ii_p1 (module := LMLF.Blueprint.Elementary.Section429)
theorem dlmf_4_29_ii_p1 (z : ℂ) :
    Complex.sinh (Complex.I * z) = Complex.I * Complex.sin z ∧
    Complex.cosh (Complex.I * z) = Complex.cos z
```
:::
::::

::::dlmfEntry "4.29.ii.p2" "https://dlmf.nist.gov/4.29.ii#ii.p2"
The surface correspondence is expressed by the tangent relation together with the sine/cosine transport identities.
:::leanStatement "DLMF 4.29(ii) second prose block"
```anchor dlmf_4_29_ii_p2 (module := LMLF.Blueprint.Elementary.Section429)
theorem dlmf_4_29_ii_p2 (z : ℂ) :
    Complex.tanh (Complex.I * z) = Complex.I * Complex.tan z ∧
    Complex.sin (Complex.I * z) = Complex.I * Complex.sinh z ∧
    Complex.cos (Complex.I * z) = Complex.cosh z
```
:::
::::

The page note applies to the whole real-argument panel: the six graphs use
the principal real branches. In particular, `cosh` is positive everywhere
and `tanh` remains in the open interval `(-1,1)`.

::::dlmfEntry "4.29.i.info" "https://dlmf.nist.gov/4.29#i.info"
The NIST production note is recorded with the branch facts used by the real panel.
:::leanStatement "DLMF 4.29 notes annotation"
```anchor dlmf_4_29_notes (module := LMLF.Blueprint.Elementary.Section429)
theorem dlmf_4_29_notes :
    (∀ x : ℝ, Real.cosh x > 0) ∧
    (∀ x : ℝ, -1 < Real.tanh x ∧ Real.tanh x < 1)
```
:::
::::
