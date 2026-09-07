import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section63
import LMLFManual.Components
open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section63
set_option verso.exampleProject "."
#doc (Manual) "§6.3 Graphics" =>
%%%
tag := "chapter-6-section-3"
%%%
:::dlmfChapter "https://dlmf.nist.gov/6.3"
Source: NIST Digital Library of Mathematical Functions, §6.3.
:::
# §6.3 Graphics
%%%
number := false
%%%
This section is graphical rather than a formula list. The real-variable
figures show the named exponential, sine, and cosine integrals on finite
intervals; the complex-variable figure shows the principal E₁ surface,
including its negative-real-axis cut and logarithmic growth near the origin.
The linked DLMF graphics and captions remain the primary disclosures; the
Lean vocabulary below records only their concrete plotting ranges and cut.
::::dlmfEntry "6.3(i) note" "https://dlmf.nist.gov/6.3#i.info"
The real-variable graphics are identified as having been produced at NIST.
::::
::::dlmfEntry "6.3(i) prose" "https://dlmf.nist.gov/6.3#i.p1"
The real-variable subsection introduces the two graphs and directs readers to
the exponential, sine, and cosine integral functions named in their captions.
For a graph of the logarithmic integral `li(x)`, the source directs readers
to [Figure 6.16.2](https://dlmf.nist.gov/6.16.F2).
::::
::::dlmfEntry "Figure 6.3.1" "https://dlmf.nist.gov/6.3.F1"
NIST identifies the real-variable graphics as NIST-produced. Figure 6.3.1
plots E₁(x) and Ei(x) for 0 < x <= 2.
:::leanStatement "Figure 6.3.1 domain"
```anchor figure631PlotInterval (module := LMLF.Blueprint.ExponentialIntegrals.Section63)
def figure631PlotInterval : Set ℝ := Set.Ioc 0 2
```
:::
::::
::::dlmfEntry "Figure 6.3.2" "https://dlmf.nist.gov/6.3.F2"
Figure 6.3.2 plots Si(x) and Ci(x) for 0 <= x <= 15.
:::leanStatement "Figure 6.3.2 domain"
```anchor figure632PlotInterval (module := LMLF.Blueprint.ExponentialIntegrals.Section63)
def figure632PlotInterval : Set ℝ := Set.Icc 0 15
```
:::
::::
::::dlmfEntry "6.3(ii) note" "https://dlmf.nist.gov/6.3#ii.info"
The complex-variable surface is identified as having been produced at NIST.
::::
::::dlmfEntry "6.3(ii) Complex Variable" "https://dlmf.nist.gov/6.3.ii"
The complex-variable subsection records a NIST-produced surface and its
principal-value convention.
::::
::::dlmfEntry "Figure 6.3.3" "https://dlmf.nist.gov/6.3.F3"
Figure 6.3.3 displays |E₁(x+iy)| over -4 <= x <= 4 and -4 <= y <= 4.
It uses the principal value, has a cut along the negative real axis, and
records logarithmic divergence of |E₁(z)| as z tends to zero.
:::leanStatement "Figure 6.3.3 domain"
```anchor figure633PlotRectangle (module := LMLF.Blueprint.ExponentialIntegrals.Section63)
def figure633PlotRectangle : Set (ℝ × ℝ) :=
  Set.Icc (-4 : ℝ) 4 ×ˢ Set.Icc (-4 : ℝ) 4
```
:::
:::leanStatement "Figure 6.3.3 cut"
```anchor principalE1Cut (module := LMLF.Blueprint.ExponentialIntegrals.Section63)
def principalE1Cut : Set ℂ := {z | z.im = 0 ∧ z.re ≤ 0}
```
:::
::::
The section notes state that the real graphs and complex surface were produced
at NIST. The page also points to Figure 6.16.2 for the logarithmic integral.
No numbered mathematical displays occur in this graphics section; the formal
disclosures therefore record only the concrete plotting domains and the
negative-real-axis cut explicitly described by Figure 6.3.3.
