import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section43
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.3 Graphics" =>
%%%
tag := "chapter-4-section-3"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.3"
Source: NIST Digital Library of Mathematical Functions, §4.3, Graphics.
:::

# §4.3 Graphics
%%%
number := false
%%%

The four figures in this section visualize the real inverse relationship between
the logarithm and exponential, the conformal mapping of the principal strip, and
the magnitude and phase of the principal logarithm and exponential.  The displays
below retain the source captions and make their mathematical content explicit in
Lean.

## §4.3(i) Real Arguments
%%%
number := false
%%%

Source: [DLMF §4.3(i)](https://dlmf.nist.gov/4.3.i).

::::dlmfEntry "4.3.F1" "https://dlmf.nist.gov/4.3.F1"
$$`\[\ln x\quad\text{and}\quad {\mathrm e}^{x}.\]`

![Figure 4.3.1: ln x and e^x](https://dlmf.nist.gov/4.3.F1.png)

The curves are mirror images in the line `y=x`: their parallel tangents at
`(1,0)` and `(0,1)` make the inverse relationship visible.  On the real line,
`log` and `exp` are inverse everywhere in the direction `log (exp x) = x`, and
the reverse direction holds on the positive half-line.

:::leanStatement "Real logarithm and exponential inverses"
```anchor real_log_exp_inverse (module := LMLF.Blueprint.Elementary.Section43)
theorem real_log_exp_inverse (x : ℝ) : Real.log (Real.exp x) = x
```

```anchor real_exp_log_inverse (module := LMLF.Blueprint.Elementary.Section43)
theorem real_exp_log_inverse {x : ℝ} (hx : 0 < x) : Real.exp (Real.log x) = x
```
:::
::::

## §4.3(ii) Complex Arguments: Conformal Maps
%%%
number := false
%%%

Source: [DLMF §4.3(ii)](https://dlmf.nist.gov/4.3.ii).

::::dlmfEntry "4.3.F2" "https://dlmf.nist.gov/4.3.F2"
$$`\[w={\mathrm e}^{z},\qquad z=\ln w.\]`

![Figure 4.3.2: Conformal mapping of exponential and logarithm](https://dlmf.nist.gov/4.3.F2.png)

The strip `-π < Im z < π` maps under `w=exp z` onto the `w`-plane cut along
the negative real axis; `log w` is the principal value on that slit plane.
Horizontal lines map to rays and vertical lines to circles centered at the
origin.  For a positive real parameter `r`, the table in the source records
`0 ↦ 1`, `r ↦ eʳ`, `r+iπ ↦ -eʳ+i0`, `r−iπ ↦ -eʳ−i0`,
`iπ ↦ -1+i0`, `−iπ ↦ -1−i0`, `-r+iπ ↦ -e⁻ʳ+i0`,
`-r−iπ ↦ -e⁻ʳ−i0`, and `-r ↦ e⁻ʳ`.

:::leanStatement "Principal logarithm and exponential on their domains"
```anchor complex_exp_principal_log_inverse (module := LMLF.Blueprint.Elementary.Section43)
theorem complex_exp_principal_log_inverse {z : ℂ}
    (hz : z ≠ 0) (harg : |Complex.arg z| < Real.pi) :
    Complex.exp (Complex.log z) = z
```

```anchor principal_log_exp_on_strip (module := LMLF.Blueprint.Elementary.Section43)
theorem principal_log_exp_on_strip {z : ℂ}
    (hlo : -Real.pi < z.im) (hhi : z.im < Real.pi) :
    Complex.log (Complex.exp z) = z
```

```anchor conformal_map_boundary_values (module := LMLF.Blueprint.Elementary.Section43)
theorem conformal_map_boundary_values {r : ℝ} (hr : 0 < r) :
    Complex.exp (r + (Real.pi : ℂ) * Complex.I) = -(Real.exp r : ℂ) ∧
    Complex.exp (r - (Real.pi : ℂ) * Complex.I) = -(Real.exp r : ℂ) ∧
    Complex.exp ((Real.pi : ℂ) * Complex.I) = -1 ∧
    Complex.exp (-r + (Real.pi : ℂ) * Complex.I) = -(Real.exp (-r) : ℂ)
```

```anchor conformal_map_nine_point_table (module := LMLF.Blueprint.Elementary.Section43)
def conformalMapNinePointTable (r : ℝ) : List (ℂ × ℂ) :=
  [ (0, 1),
    (r, (Real.exp r : ℂ)),
    (r + (Real.pi : ℂ) * Complex.I, -(Real.exp r : ℂ) + 0 * Complex.I),
    (r - (Real.pi : ℂ) * Complex.I, -(Real.exp r : ℂ) - 0 * Complex.I),
    ((Real.pi : ℂ) * Complex.I, -1 + 0 * Complex.I),
    (-(Real.pi : ℂ) * Complex.I, -1 - 0 * Complex.I),
    (-r + (Real.pi : ℂ) * Complex.I, -(Real.exp (-r) : ℂ) + 0 * Complex.I),
    (-r - (Real.pi : ℂ) * Complex.I, -(Real.exp (-r) : ℂ) - 0 * Complex.I),
    (-r, (Real.exp (-r) : ℂ)) ]
```

```anchor conformal_map_nine_point_table_spec (module := LMLF.Blueprint.Elementary.Section43)
theorem conformal_map_nine_point_table_spec {r : ℝ} (hr : 0 < r) :
    conformalMapNinePointTable r =
      [ ((0 : ℂ), Complex.exp 0),
        ((r : ℂ), Complex.exp r),
        ((r : ℂ) + (Real.pi : ℂ) * Complex.I, Complex.exp (r + (Real.pi : ℂ) * Complex.I)),
        ((r : ℂ) - (Real.pi : ℂ) * Complex.I, Complex.exp (r - (Real.pi : ℂ) * Complex.I)),
        ((Real.pi : ℂ) * Complex.I, Complex.exp ((Real.pi : ℂ) * Complex.I)),
        (-(Real.pi : ℂ) * Complex.I, Complex.exp (-(Real.pi : ℂ) * Complex.I)),
        (-(r : ℂ) + (Real.pi : ℂ) * Complex.I, Complex.exp (-r + (Real.pi : ℂ) * Complex.I)),
        (-(r : ℂ) - (Real.pi : ℂ) * Complex.I, Complex.exp (-r - (Real.pi : ℂ) * Complex.I)),
        (-(r : ℂ), Complex.exp (-r)) ]
```
:::
::::

## §4.3(iii) Complex Arguments: Surfaces
%%%
number := false
%%%

Source: [DLMF §4.3(iii)](https://dlmf.nist.gov/4.3.iii).

In these graphics, height is the absolute value of the function and color is
its phase.  The principal logarithm has a branch cut on the negative real axis.

::::dlmfEntry "4.3.F3" "https://dlmf.nist.gov/4.3.F3"
$$`\[\left|\ln(x+\mathrm{i}y)\right|.\]`

![Figure 4.3.3: ln(x+iy), principal value](https://dlmf.nist.gov/4.3.F3.png)

The surface height is the modulus of the principal logarithm at `x+i y`; its
color records the principal phase.  The displayed domain is the plane slit
along the nonpositive real axis, which makes the branch-cut discontinuity
visible.

:::leanStatement "Principal-logarithm surface height"
```anchor principalLogSurfaceHeight (module := LMLF.Blueprint.Elementary.Section43)
def principalLogSurfaceHeight (x y : ℝ) : ℝ :=
  ‖Complex.log (x + (y : ℂ) * Complex.I)‖
```

```anchor principalLogSurfaceDomain (module := LMLF.Blueprint.Elementary.Section43)
def principalLogSurfaceDomain : Set ℂ :=
  {z | ¬ (z.im = 0 ∧ z.re ≤ 0)}
```

```anchor principal_log_surface_height (module := LMLF.Blueprint.Elementary.Section43)
theorem principal_log_surface_height {x y : ℝ}
    (hxy : (x + (y : ℂ) * Complex.I) ∈ principalLogSurfaceDomain) :
    principalLogSurfaceHeight x y =
      ‖Complex.log (x + (y : ℂ) * Complex.I)‖
```
:::
::::

::::dlmfEntry "4.3.F4" "https://dlmf.nist.gov/4.3.F4"
$$`\[\left|{\mathrm e}^{x+\mathrm{i}y}\right|.\]`

![Figure 4.3.4: e^(x+iy)](https://dlmf.nist.gov/4.3.F4.png)

For the exponential surface, the modulus depends only on the real coordinate:
`|exp(x+i y)| = exp x`; the imaginary coordinate controls the phase and hence
the color bands.

:::leanStatement "Complex-exponential surface height"
```anchor complex_exp_surface_height (module := LMLF.Blueprint.Elementary.Section43)
theorem complex_exp_surface_height (x y : ℝ) :
    ‖Complex.exp (x + (y : ℂ) * Complex.I)‖ = Real.exp x
```
:::
::::
