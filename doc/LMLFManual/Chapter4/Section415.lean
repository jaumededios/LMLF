import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section415
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.15 Graphics" =>
%%%
tag := "chapter-4-section-15"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.15"
Source: NIST Digital Library of Mathematical Functions, §4.15, Graphics.
:::

# §4.15 Graphics
%%%
number := false
%%%

The figures below retain the source visualizations and captions.  Real-axis
plots show principal values where indicated; complex surfaces use height for
the absolute value and color for phase.  The conformal-map table records the
strip-to-slit-plane geometry of the sine map, including the two sides of the
real-axis cuts.

## §4.15(i) Real Arguments
%%%
number := false
%%%

Source: [DLMF §4.15(i)](https://dlmf.nist.gov/4.15.i).

The complex reciprocal and inverse functions below are read on their ordinary
pole-free domains; Lean's division is totalized only as an implementation
convention, while the displayed hypotheses record the mathematical exclusions.

::::dlmfEntry "4.15.F1" "https://dlmf.nist.gov/4.15.F1"
![Figure 4.15.1: sin x and cos x](https://dlmf.nist.gov/4.15.F1.png)

The first real-argument plot places sine and cosine on their common periodic
scale.
::::

::::dlmfEntry "4.15.F2" "https://dlmf.nist.gov/4.15.F2"
![Figure 4.15.2: Arcsin x and Arccos x](https://dlmf.nist.gov/4.15.F2.png)

The inverse-sine and inverse-cosine curves show their principal values with
thickened lines.
::::

::::dlmfEntry "4.15.F3" "https://dlmf.nist.gov/4.15.F3"
![Figure 4.15.3: tan x and cot x](https://dlmf.nist.gov/4.15.F3.png)

The tangent and cotangent plots display their real poles and periodic branches.
::::

::::dlmfEntry "4.15.F4" "https://dlmf.nist.gov/4.15.F4"
![Figure 4.15.4: arctan x and arccot x](https://dlmf.nist.gov/4.15.F4.png)

Only principal values are shown for arctangent and arccotangent; the source
caption emphasizes that arccotangent is discontinuous at zero.
::::

::::dlmfEntry "4.15.F5" "https://dlmf.nist.gov/4.15.F5"
![Figure 4.15.5: csc x and sec x](https://dlmf.nist.gov/4.15.F5.png)

The reciprocal trigonometric plots show the poles inherited from sine and
cosine.
::::

::::dlmfEntry "4.15.F6" "https://dlmf.nist.gov/4.15.F6"
![Figure 4.15.6: arccsc x and arcsec x](https://dlmf.nist.gov/4.15.F6.png)

The principal arccosecant and arcsecant curves become complex for `-1<x<1`,
as stated in the source caption.
::::

These real plots retain the qualitative features that determine their shapes:
`sin x` and `tan x` are odd while `cos x` and `sec x` are even; the zeros of
`sin` occur at integer multiples of `π`, the zeros of `cos` at
`π/2 + kπ`, and the reciprocal functions have poles at those respective
zero sets.  Sine and cosine attain alternating extrema `±1`, whereas tangent
and cotangent have unbounded periodic branches.  The inverse plots use their
principal domains and ranges: arcsine maps `[-1,1]` to `[-π/2,π/2]`, while
arccosine maps `[-1,1]` to `[0,π]`; arctangent has range
`(-π/2,π/2)` and the principal arccotangent has its source discontinuity at
zero.

## §4.15(ii) Complex Arguments: Conformal Maps
%%%
number := false
%%%

Source: [DLMF §4.15(ii)](https://dlmf.nist.gov/4.15.ii).

::::dlmfEntry "4.15.F7" "https://dlmf.nist.gov/4.15.F7"
![Figure 4.15.7: Conformal mapping of sine and inverse sine](https://dlmf.nist.gov/4.15.F7.png)

The map `w=sin z` sends the strip `−π/2 < Re z < π/2` onto the `w`-plane
cut along the real axis from `−∞` to `−1` and from `1` to `∞`; `z=arcsin w`
is the principal inverse.  Horizontal lines map to confocal ellipses with
foci `±1`, while vertical lines map to confocal rectangular hyperbolas.  For
`r>0`, the four-row source correspondence table has labels
`A,B,C,C̄,D,D̄,E,Ē,F`; the `C/C̄` and `E/Ē` entries retain distinct upper
and lower slit sides, written `+i0` and `−i0`, rather than collapsing them.

:::leanStatement "Sine conformal-map table"
```anchor sineConformalTable (module := LMLF.Blueprint.Elementary.Section415)
def sineConformalTable (r : ℝ) : List SineCorrespondence :=
  [ { label := "A", z := 0, w := 0, side := none },
    { label := "B", z := (Real.pi : ℂ) / 2, w := 1, side := none },
    { label := "C", z := (Real.pi : ℂ) / 2 + (r : ℂ) * Complex.I,
      w := Real.cosh r, side := some SlitSide.upper },
    { label := "C̄", z := (Real.pi : ℂ) / 2 - (r : ℂ) * Complex.I,
      w := Real.cosh r, side := some SlitSide.lower },
    { label := "D", z := (r : ℂ) * Complex.I,
      w := (Real.sinh r : ℂ) * Complex.I, side := none },
    { label := "D̄", z := -(r : ℂ) * Complex.I,
      w := -(Real.sinh r : ℂ) * Complex.I, side := none },
    { label := "E", z := -((Real.pi : ℂ) / 2) + (r : ℂ) * Complex.I,
      w := -(Real.cosh r : ℂ), side := some SlitSide.upper },
    { label := "Ē", z := -((Real.pi : ℂ) / 2) - (r : ℂ) * Complex.I,
      w := -(Real.cosh r : ℂ), side := some SlitSide.lower },
    { label := "F", z := -((Real.pi : ℂ) / 2), w := -1, side := none } ]
```
```anchor sineConformalTable_spec (module := LMLF.Blueprint.Elementary.Section415)
theorem sineConformalTable_spec {r : ℝ} (hr : 0 < r) :
    (sineConformalTable r).length = 9
```
:::
::::

## §4.15(iii) Complex Arguments: Surfaces
%%%
number := false
%%%

Source: [DLMF §4.15(iii)](https://dlmf.nist.gov/4.15.iii).

In Figures 4.15.8–4.15.13, height is the modulus and color is the phase.
The branch-cut descriptions below are part of the mathematical content of the
surface plots.

The tangent and cosecant surface statements exclude cosine and sine zeros,
respectively; the principal arcsine and arctangent statements exclude their
branch cuts, and the principal arccosecant statement excludes both its pole at
`0` and its real branch cut `[-1,1]`.

```anchor SlitSide (module := LMLF.Blueprint.Elementary.Section415)
inductive SlitSide where
  | upper
  | lower
deriving DecidableEq, Repr
```
```anchor SineCorrespondence (module := LMLF.Blueprint.Elementary.Section415)
structure SineCorrespondence where
  label : String
  z : ℂ
  w : ℂ
  side : Option SlitSide
```

:::leanStatement "Surface height, phase, and branch-cut vocabulary"
```anchor surfaceHeight (module := LMLF.Blueprint.Elementary.Section415)
def surfaceHeight (f : ℂ → ℂ) (x y : ℝ) : ℝ :=
  ‖f (x + (y : ℂ) * Complex.I)‖
```
```anchor surfacePhase (module := LMLF.Blueprint.Elementary.Section415)
def surfacePhase (f : ℂ → ℂ) (x y : ℝ) : ℝ :=
  Complex.arg (f (x + (y : ℂ) * Complex.I))
```
```anchor arcsinBranchCut (module := LMLF.Blueprint.Elementary.Section415)
def arcsinBranchCut : Set ℂ :=
  {z | z.im = 0 ∧ (z.re ≤ -1 ∨ 1 ≤ z.re)}
```
```anchor arctanBranchCut (module := LMLF.Blueprint.Elementary.Section415)
def arctanBranchCut : Set ℂ :=
  {z | z.re = 0 ∧ (z.im ≤ -1 ∨ 1 ≤ z.im)}
```
```anchor arccscBranchCut (module := LMLF.Blueprint.Elementary.Section415)
def arccscBranchCut : Set ℂ :=
  {z | z.im = 0 ∧ -1 ≤ z.re ∧ z.re ≤ 1}
```
```anchor reciprocalTrigDomain (module := LMLF.Blueprint.Elementary.Section415)
def reciprocalTrigDomain (z : ℂ) : Prop :=
  Complex.sin z ≠ 0 ∧ Complex.cos z ≠ 0
```
```anchor principalArccscDomain (module := LMLF.Blueprint.Elementary.Section415)
def principalArccscDomain (z : ℂ) : Prop :=
  z ≠ 0 ∧ z ∉ arccscBranchCut
```
:::

::::dlmfEntry "4.15.F8" "https://dlmf.nist.gov/4.15.F8"
![Figure 4.15.8: sin(x+iy)](https://dlmf.nist.gov/4.15.F8.png)

The sine surface uses `sin(x+i y)` as its complex-valued height/phase field.
:::leanStatement "Sine surface height"
```anchor sineSurfaceHeight (module := LMLF.Blueprint.Elementary.Section415)
theorem sineSurfaceHeight (x y : ℝ) :
    surfaceHeight Complex.sin x y = ‖Complex.sin (x + (y : ℂ) * Complex.I)‖
```
:::
::::

::::dlmfEntry "4.15.F9" "https://dlmf.nist.gov/4.15.F9"
![Figure 4.15.9: principal arcsin(x+iy)](https://dlmf.nist.gov/4.15.F9.png)

The principal arcsine surface has branch cuts on the real axis from `−∞` to
`−1` and from `1` to `∞`.
:::leanStatement "Principal-arcsine surface height"
```anchor principalArcsin (module := LMLF.Blueprint.Elementary.Section415)
def principalArcsin (z : ℂ) : ℂ :=
  -Complex.I * Complex.log (Complex.I * z + Complex.sqrt (1 - z ^ 2))
```
```anchor arcsinSurfaceHeight (module := LMLF.Blueprint.Elementary.Section415)
theorem arcsinSurfaceHeight (x y : ℝ)
    (hcut : (x + (y : ℂ) * Complex.I) ∉ arcsinBranchCut) :
    surfaceHeight principalArcsin x y = ‖principalArcsin (x + (y : ℂ) * Complex.I)‖
```
:::
::::

::::dlmfEntry "4.15.F10" "https://dlmf.nist.gov/4.15.F10"
![Figure 4.15.10: tan(x+iy)](https://dlmf.nist.gov/4.15.F10.png)

The tangent surface is periodic in the real direction and has poles where
cosine vanishes.
:::leanStatement "Tangent surface height"
```anchor tanSurfaceHeight (module := LMLF.Blueprint.Elementary.Section415)
theorem tanSurfaceHeight (x y : ℝ)
    (hdom : Complex.cos (x + (y : ℂ) * Complex.I) ≠ 0) :
    surfaceHeight Complex.tan x y = ‖Complex.tan (x + (y : ℂ) * Complex.I)‖
```
:::
::::

::::dlmfEntry "4.15.F11" "https://dlmf.nist.gov/4.15.F11"
![Figure 4.15.11: principal arctan(x+iy)](https://dlmf.nist.gov/4.15.F11.png)

The principal arctangent has branch cuts on the imaginary axis from `−i∞` to
`−i` and from `i` to `i∞`.
:::leanStatement "Principal-arctangent surface height"
```anchor arctanSurfaceHeight (module := LMLF.Blueprint.Elementary.Section415)
theorem arctanSurfaceHeight (x y : ℝ)
    (hcut : (x + (y : ℂ) * Complex.I) ∉ arctanBranchCut) :
    surfaceHeight Complex.arctan x y = ‖Complex.arctan (x + (y : ℂ) * Complex.I)‖
```
:::
::::

::::dlmfEntry "4.15.F12" "https://dlmf.nist.gov/4.15.F12"
![Figure 4.15.12: csc(x+iy)](https://dlmf.nist.gov/4.15.F12.png)

The cosecant surface is the reciprocal-sine surface, with poles inherited from
the zeros of sine.
:::leanStatement "Cosecant surface height"
```anchor complexSecCsc (module := LMLF.Blueprint.Elementary.Section415)
def complexSec (z : ℂ) : ℂ := 1 / Complex.cos z
def complexCsc (z : ℂ) : ℂ := 1 / Complex.sin z
```
```anchor cscSurfaceHeight (module := LMLF.Blueprint.Elementary.Section415)
theorem cscSurfaceHeight (x y : ℝ)
    (hdom : Complex.sin (x + (y : ℂ) * Complex.I) ≠ 0) :
    surfaceHeight complexCsc x y = ‖complexCsc (x + (y : ℂ) * Complex.I)‖
```
:::
::::

::::dlmfEntry "4.15.F13" "https://dlmf.nist.gov/4.15.F13"
![Figure 4.15.13: principal arccsc(x+iy)](https://dlmf.nist.gov/4.15.F13.png)

The principal arccosecant has a branch cut on the real axis from `−1` to `1`.
:::leanStatement "Principal-arccosecant surface height"
```anchor principalArccsc (module := LMLF.Blueprint.Elementary.Section415)
def principalArccsc (z : ℂ) : ℂ := principalArcsin (1 / z)
```
```anchor arccscSurfaceHeight (module := LMLF.Blueprint.Elementary.Section415)
theorem arccscSurfaceHeight (x y : ℝ)
    (hdom : principalArccscDomain (x + (y : ℂ) * Complex.I)) :
    surfaceHeight principalArccsc x y = ‖principalArccsc (x + (y : ℂ) * Complex.I)‖
```
:::
::::

The corresponding cosine, cotangent, and secant surfaces are obtained from
Figures 4.15.8, 4.15.10, and 4.15.12 by translating `x` by `−π/2`, with the
phase coloring adjusted for cotangent.  The three identities below formalize
the source’s displayed modulus translations.

:::leanStatement "Surface translation identities"
```anchor dlmf_4_15_1 (module := LMLF.Blueprint.Elementary.Section415)
theorem dlmf_4_15_1 (x y : ℝ)
    (hcos : Complex.cos (x + (y : ℂ) * Complex.I) ≠ 0)
    (hsin : Complex.sin (x + (Real.pi : ℂ) / 2 + (y : ℂ) * Complex.I) ≠ 0) :
    ‖Complex.cos (x + (y : ℂ) * Complex.I)‖ =
      ‖Complex.sin (x + (Real.pi : ℂ) / 2 + (y : ℂ) * Complex.I)‖
```
```anchor dlmf_4_15_2 (module := LMLF.Blueprint.Elementary.Section415)
theorem dlmf_4_15_2 (x y : ℝ)
    (hsin : Complex.sin (x + (y : ℂ) * Complex.I) ≠ 0)
    (hcos : Complex.cos (x + (Real.pi : ℂ) / 2 + (y : ℂ) * Complex.I) ≠ 0) :
    ‖Complex.cot (x + (y : ℂ) * Complex.I)‖ =
      ‖-Complex.tan (x + (Real.pi : ℂ) / 2 + (y : ℂ) * Complex.I)‖
```
```anchor dlmf_4_15_3 (module := LMLF.Blueprint.Elementary.Section415)
theorem dlmf_4_15_3 (x y : ℝ)
    (hdom : reciprocalTrigDomain (x + (y : ℂ) * Complex.I)) :
    ‖complexSec (x + (y : ℂ) * Complex.I)‖ =
      ‖complexCsc (x + (Real.pi : ℂ) / 2 + (y : ℂ) * Complex.I)‖
```
:::
