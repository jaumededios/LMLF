import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section53
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open LMLFManual
open Verso.Code.External

set_option verso.exampleProject "."

#doc (Manual) "Gamma Function · §5.3 Graphics" =>
%%%
tag := "chapter-5-section-5-3"
%%%

:::dlmfChapter "https://dlmf.nist.gov/5.3"
Source: NIST Digital Library of Mathematical Functions, §5.3, Graphics.
:::

# §5.3 Graphics
%%%
number := false
%%%

## §5.3(i) Real Argument
%%%
number := false
%%%

Source: [DLMF §5.3(i)](https://dlmf.nist.gov/5.3.i).

::::dlmfEntry "5.3.F1" "https://dlmf.nist.gov/5.3.F1"
$$`\Gamma(x)\quad\text{and}\quad 1/\Gamma(x),\qquad
x_0=1.46\ldots,\quad \Gamma(x_0)=0.88\ldots.`

![Figure 5.3.1: Gamma and its reciprocal](https://dlmf.nist.gov/5.3.F1.png)

The real-argument plot places the Gamma function beside its reciprocal.  On the positive real
axis the reciprocal is the multiplicative inverse, which is the specialization formalized below.
The source caption records the positive minimum as `x₀ = 1.46…` with
`Γ(x₀) = 0.88…`; its “see §5.4(iii)” cross-reference gives the special-value context for this
minimum.  These ellipses are caption approximations, so the Lean declaration below does not turn
them into exact decimal equalities.

See also [DLMF §5.4(iii)](https://dlmf.nist.gov/5.4.iii).

:::leanStatement "Lean · LMLF.Blueprint.Gamma · positive-real specialization"
```anchor section53Context (module := LMLF.Blueprint.Gamma.Section53) -showProofStates
namespace LMLF.Blueprint.Gamma
```

```anchor gamma_graph_reciprocal_on_pos (module := LMLF.Blueprint.Gamma.Section53) -showProofStates
theorem gamma_graph_reciprocal_on_pos {x : ℝ} (hx : 0 < x) :
    Real.Gamma x * (Real.Gamma x)⁻¹ = 1
```
:::
::::

::::dlmfEntry "5.3.F2" "https://dlmf.nist.gov/5.3.F2"
$$`\ln\Gamma(x),\qquad x\in(0,\infty).`

![Figure 5.3.2: logarithm of Gamma](https://dlmf.nist.gov/5.3.F2.png)

For positive real `x`, the plotted logarithm of Gamma is convex on the open interval
`(0,\infty)`.  The declaration uses `ConvexOn` on exactly that domain and does not extend the
claim across Gamma's poles.

:::leanStatement "Lean · LMLF.Blueprint.Gamma · exact real-domain statement"
```anchor log_gamma_convexOn (module := LMLF.Blueprint.Gamma.Section53) -showProofStates
theorem log_gamma_convexOn :
    ConvexOn ℝ (Set.Ioi (0 : ℝ)) (fun x : ℝ ↦ Real.log (Real.Gamma x))
```
:::
::::

::::dlmfEntry "5.3.F3" "https://dlmf.nist.gov/5.3.F3"
$$`\psi(x).`

![Figure 5.3.3: psi function](https://dlmf.nist.gov/5.3.F3.png)

The third real-axis graphic is the digamma (psi) function.  In the complex notation used by the
formal development, psi is the logarithmic derivative of Gamma away from the nonpositive-integer
poles; restricting the argument to the real axis gives the plotted function.

:::leanStatement "Lean · LMLF.Blueprint.Gamma · real-axis interpretation"
```anchor digamma_graph_log_derivative (module := LMLF.Blueprint.Gamma.Section53) -showProofStates
theorem digamma_graph_log_derivative {x : ℝ}
    (hx : ∀ n : ℕ, (x : ℂ) ≠ -(n : ℂ)) :
    Complex.digamma (x : ℂ) =
      deriv Complex.Gamma (x : ℂ) / Complex.Gamma (x : ℂ)
```
:::
::::

## §5.3(ii) Complex Argument
%%%
number := false
%%%

Source: [DLMF §5.3(ii)](https://dlmf.nist.gov/5.3.ii).

The three complex-argument surfaces use `x + i y` as their input.  In each figure, both the height
and the color represent the displayed absolute value.  The source pictures visualize the ordinary
meromorphic functions away from their poles; Mathlib totalizes Gamma and digamma at poles, so the
pointwise declarations below use that explicit formal convention.

::::dlmfEntry "5.3.F4" "https://dlmf.nist.gov/5.3.F4"
$$`\left|\Gamma(x+\mathrm{i}y)\right|.`

![Figure 5.3.4: absolute value of Gamma](https://dlmf.nist.gov/5.3.F4.png)

The height of this surface is the norm of the complex Gamma value, hence is nonnegative for every
real pair `(x,y)`.

:::leanStatement "Lean · LMLF.Blueprint.Gamma · complex surface height"
```anchor gamma_abs_graph_nonnegative (module := LMLF.Blueprint.Gamma.Section53) -showProofStates
theorem gamma_abs_graph_nonnegative (x y : ℝ) :
    0 ≤ ‖Complex.Gamma (x + (y : ℂ) * Complex.I)‖
```
:::
::::

::::dlmfEntry "5.3.F5" "https://dlmf.nist.gov/5.3.F5"
$$`1/\left|\Gamma(x+\mathrm{i}y)\right|.`

![Figure 5.3.5: reciprocal absolute value of Gamma](https://dlmf.nist.gov/5.3.F5.png)

The reciprocal surface plots the reciprocal of the norm of Gamma.  Norm inversion gives the same
quantity as the norm of the complex reciprocal; the declaration includes Mathlib's totalized value
at a Gamma pole, whereas the source graphic is read away from such poles.

:::leanStatement "Lean · LMLF.Blueprint.Gamma · reciprocal surface identity"
```anchor reciprocal_gamma_abs_graph (module := LMLF.Blueprint.Gamma.Section53) -showProofStates
theorem reciprocal_gamma_abs_graph (x y : ℝ) :
    ‖(Complex.Gamma (x + (y : ℂ) * Complex.I))⁻¹‖ =
      ‖Complex.Gamma (x + (y : ℂ) * Complex.I)‖⁻¹
```
:::
::::

::::dlmfEntry "5.3.F6" "https://dlmf.nist.gov/5.3.F6"
$$`\left|\psi(x+\mathrm{i}y)\right|.`

![Figure 5.3.6: absolute value of psi](https://dlmf.nist.gov/5.3.F6.png)

The final surface uses the norm of the digamma value as its height and color coordinate, so that
coordinate is nonnegative at every point of the complex plane.

:::leanStatement "Lean · LMLF.Blueprint.Gamma · digamma surface height"
```anchor digamma_abs_graph_nonnegative (module := LMLF.Blueprint.Gamma.Section53) -showProofStates
theorem digamma_abs_graph_nonnegative (x y : ℝ) :
    0 ≤ ‖Complex.digamma (x + (y : ℂ) * Complex.I)‖
```
:::
::::
