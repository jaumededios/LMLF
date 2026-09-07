import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section59
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§5.9 Integral Representations" =>
%%%
tag := "chapter-5-section-9"
%%%

This page covers every numbered formula in [DLMF §5.9](https://dlmf.nist.gov/5.9).
Convergence and value identities are displayed separately where they are mathematically distinct.
Where branch conventions are unambiguous, formulas are stated over complex variables; several
branch-sensitive identities are stated on the positive real axis. Typed C¹ contours and branch lifts
are introduced before the formulas that use them.

# §5.9(i) Gamma Function
%%%
number := false
%%%

::::dlmfEntry "5.9.1" "https://dlmf.nist.gov/5.9.E1"
$$`\frac{1}{\mu}\Gamma\left(\frac{\nu}{\mu}\right)\frac{1}{z^{\nu/\mu}}=\int_{0}^ {\infty}\exp\left(-zt^{\mu}\right)t^{\nu-1}\,\mathrm{d}t,`

For real μ>0 and complex ν,z in their right half-planes, the integrand is absolutely integrable on (0,∞), and the displayed scaled Gamma value is its Bochner integral. Complex powers use their principal values.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_1_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_1_integrable {z ν : ℂ} {μ : ℝ} (hμ : 0 < μ) (hν : 0 < ν.re)
    (hz : 0 < z.re) :
    IntegrableOn
      (fun t : ℝ ↦ Complex.exp (-z * (Real.rpow t μ : ℂ)) * (t : ℂ) ^ (ν - 1)) (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_1 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_1 {z ν : ℂ} {μ : ℝ} (hμ : 0 < μ) (hν : 0 < ν.re) (hz : 0 < z.re) :
    (1 / (μ : ℂ)) * Complex.Gamma (ν / μ) / z ^ (ν / μ) =
      ∫ t in Ioi (0 : ℝ),
        Complex.exp (-z * (Real.rpow t μ : ℂ)) * (t : ℂ) ^ (ν - 1)
```
:::
::::
::::dlmfEntry "5.9.2" "https://dlmf.nist.gov/5.9.E2"
$$`\frac{1}{\Gamma\left(z\right)}=\frac{1}{2\pi i}\int_{-\infty}^{(0+)}e^{t}t^{-z }\,\mathrm{d}t,`

The contour starts at $`-\infty` below the negative real axis, circles the
origin counterclockwise, and returns to $`-\infty` above the cut. Along it,
$`t^{-z}` means $`\exp(-z\operatorname{Log}_\gamma t)`, where
$`\operatorname{Log}_\gamma` is the continuously selected logarithm carried
by the contour.

The reusable §3.6 contour interface makes those choices formal. Its finite
contour has admissible radii $`0<\varepsilon<R`, three separately C¹ pieces,
and an explicit lift on each piece. The first disclosure records the actual
lower bank, counterclockwise circle, and upper bank formulas. The second
records finite integrability and the ordered limits $`R\to\infty` followed by
$`\varepsilon\to0^+`.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_2 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_2 (z : ℂ) :
    LMLF.Integral.HasHankelRepresentation
      (fun t logt => Complex.exp t * Complex.exp (-z * logt))
      (1 / (2 * Real.pi * Complex.I))
      (1 / Complex.Gamma z)
```
:::
::::
::::dlmfEntry "Figure 5.9.1" "https://dlmf.nist.gov/5.9#F1"
The $`t`-plane contour for Hankel's loop integral. The figure makes the lower-bank start, positive circuit around the origin, and upper-bank return in 5.9.2 explicit.
::::

::::dlmfEntry "5.9.2_5" "https://dlmf.nist.gov/5.9.E2_5"
$$`\frac{1}{\Gamma\left(z\right)}=\frac{{\mathrm{e}}^{z}z^{1-z}}{2\pi}\int_{-\pi} ^{\pi}{\mathrm{e}}^{-z\Phi(t)}\,\mathrm{d}t,`

For $`\Re z>0`, Temme’s phase `temmePhase` turns reciprocal Gamma into an ordinary
integrable expression on the finite interval $`[-\pi,\pi]`. Its totalized value at the
removable point $`t=0` is immaterial to the interval integral.

:::leanStatement "Lean statement"
```anchor temmePhase (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
noncomputable def temmePhase (t : ℝ) : ℝ :=
  1 - t / Real.tan t + Real.log (t / Real.sin t)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_2_5_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_2_5_integrable {z : ℂ} (hz : 0 < z.re) :
    IntervalIntegrable (fun t : ℝ ↦ Complex.exp (-z * temmePhase t)) volume
      (-Real.pi) Real.pi
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_2_5 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_2_5 {z : ℂ} (hz : 0 < z.re) :
    1 / Complex.Gamma z =
      Complex.exp z * z ^ (1 - z) / (2 * Real.pi) *
        ∫ t in (-Real.pi)..Real.pi, Complex.exp (-z * temmePhase t)
```
:::
::::

::::dlmfEntry "5.9.3" "https://dlmf.nist.gov/5.9.E3"
$$`c^{-z}\Gamma\left(z\right)=\int_{-\infty}^{\infty}|t|^{2z-1}e^{-ct^{2}}\, \mathrm{d}t,`

For c>0 and Re z>0, this is an absolutely convergent complex-valued integral over the whole real axis; the path and the principal complex power are therefore explicit.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_3_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_3_integrable {z : ℂ} {c : ℝ} (hc : 0 < c) (hz : 0 < z.re) :
    Integrable (fun t : ℝ ↦ ((|t| : ℝ) : ℂ) ^ (2 * z - 1) * Complex.exp (-c * t ^ 2))
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_3 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_3 {z : ℂ} {c : ℝ} (hc : 0 < c) (hz : 0 < z.re) :
    (c : ℂ) ^ (-z) * Complex.Gamma z =
      ∫ t : ℝ, ((|t| : ℝ) : ℂ) ^ (2 * z - 1) * Complex.exp (-c * t ^ 2)
```
:::
::::

::::dlmfEntry "5.9.4" "https://dlmf.nist.gov/5.9.E4"
$$`\Gamma\left(z\right)=\int_{1}^{\infty}t^{z-1}e^{-t}\,\mathrm{d}t+\sum_{k=0}^{ \infty}\frac{(-1)^{k}}{(z+k)k!},`

Away from the nonpositive integers, Gamma is the sum of an absolutely convergent tail integral and a summable correction series. The Lean hypothesis excludes exactly the listed poles.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_4_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_4_integrable {z : ℂ} (hz : ∀ k : ℕ, z ≠ -(k : ℂ)) :
    IntegrableOn (fun t : ℝ ↦ (t : ℂ) ^ (z - 1) * Real.exp (-t)) (Ici 1)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_4_summable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_4_summable {z : ℂ} (hz : ∀ k : ℕ, z ≠ -(k : ℂ)) :
    Summable (fun k : ℕ ↦ (-1 : ℂ) ^ k / ((z + k) * k.factorial))
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_4 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_4 {z : ℂ} (hz : ∀ k : ℕ, z ≠ -(k : ℂ)) :
    Complex.Gamma z =
      (∫ t in Ici (1 : ℝ), (t : ℂ) ^ (z - 1) * Real.exp (-t)) +
        ∑' k : ℕ, (-1 : ℂ) ^ k / ((z + k) * k.factorial)
```
:::
::::

::::dlmfEntry "5.9.5" "https://dlmf.nist.gov/5.9.E5"
$$`\Gamma\left(z\right)=\int_{0}^{\infty}t^{z-1}\left(e^{-t}-\sum_{k=0}^{n}\frac{ (-1)^{k}t^{k}}{k!}\right)\,\mathrm{d}t,`

For n≥0 and −n−1<Re z<−n, subtracting the degree-n exponential Taylor polynomial removes the singular behavior at zero. Lean records absolute integrability as part of the result.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_5_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_5_integrable (n : ℕ) {z : ℂ} (hl : -(n : ℝ) - 1 < z.re)
    (hu : z.re < -n) :
    IntegrableOn
      (fun t : ℝ ↦ (t : ℂ) ^ (z - 1) *
        (Real.exp (-t) - ∑ k ∈ Finset.range (n + 1), (-1 : ℂ) ^ k * t ^ k / k.factorial))
      (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_5 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_5 (n : ℕ) {z : ℂ} (hl : -(n : ℝ) - 1 < z.re) (hu : z.re < -n) :
    Complex.Gamma z = ∫ t in Ioi (0 : ℝ), (t : ℂ) ^ (z - 1) *
      (Real.exp (-t) - ∑ k ∈ Finset.range (n + 1), (-1 : ℂ) ^ k * t ^ k / k.factorial)
```
:::
::::

::::dlmfEntry "5.9.6" "https://dlmf.nist.gov/5.9.E6"
$$`\Gamma\left(z\right)\cos\left(\tfrac{1}{2}\pi z\right)=\int_{0}^{\infty}t^{z-1 }\cos t\,\mathrm{d}t,`

When $`0<\Re z<1`, the cosine integral is generally conditional. Lean states convergence as the
limit of integrals over $`[0,R]`, rather than using a totalized infinite integral.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_6 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_6 {z : ℂ} (hl : 0 < z.re) (hu : z.re < 1) :
    Tendsto (fun R : ℝ ↦ ∫ t in (0 : ℝ)..R, (t : ℂ) ^ (z - 1) * Real.cos t)
      atTop (𝓝 (Complex.Gamma z * Complex.cos (Real.pi * z / 2)))
```
:::
::::

::::dlmfEntry "5.9.7" "https://dlmf.nist.gov/5.9.E7"
$$`\Gamma\left(z\right)\sin\left(\tfrac{1}{2}\pi z\right)=\int_{0}^{\infty}t^{z-1 }\sin t\,\mathrm{d}t,`

When −1<Re z<1, the sine factor also gives a conditionally convergent improper integral, represented by its finite-cutoff limit.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_7 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_7 {z : ℂ} (hl : -1 < z.re) (hu : z.re < 1) :
    Tendsto (fun R : ℝ ↦ ∫ t in (0 : ℝ)..R, (t : ℂ) ^ (z - 1) * Real.sin t)
      atTop (𝓝 (Complex.Gamma z * Complex.sin (Real.pi * z / 2)))
```
:::
::::

::::dlmfEntry "5.9.8" "https://dlmf.nist.gov/5.9.E8"
$$`\Gamma\left(1+\frac{1}{n}\right)\cos\left(\frac{\pi}{2n}\right)=\int_{0}^{ \infty}\cos\left(t^{n}\right)\,\mathrm{d}t,`

For every integer n≥2, the oscillatory cosine integral converges to the displayed real Gamma value. The bound n≥2 is represented directly.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_8 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_8 {n : ℕ} (hn : 2 ≤ n) :
    Tendsto (fun R : ℝ ↦ ∫ t in (0 : ℝ)..R, Real.cos (t ^ n)) atTop
      (𝓝 (Real.Gamma (1 + 1 / (n : ℝ)) * Real.cos (Real.pi / (2 * n))))
```
:::
::::

::::dlmfEntry "5.9.9" "https://dlmf.nist.gov/5.9.E9"
$$`\Gamma\left(1+\frac{1}{n}\right)\sin\left(\frac{\pi}{2n}\right)=\int_{0}^{ \infty}\sin\left(t^{n}\right)\,\mathrm{d}t,`

For every integer n≥2, the matching sine power-phase integral converges to the displayed real Gamma value.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_9 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_9 {n : ℕ} (hn : 2 ≤ n) :
    Tendsto (fun R : ℝ ↦ ∫ t in (0 : ℝ)..R, Real.sin (t ^ n)) atTop
      (𝓝 (Real.Gamma (1 + 1 / (n : ℝ)) * Real.sin (Real.pi / (2 * n))))
```
:::
::::

::::dlmfEntry "5.9.10" "https://dlmf.nist.gov/5.9.E10"
$$`\operatorname{Ln}\Gamma\left(z\right)=\left(z-\tfrac{1}{2}\right)\ln z-z+ \tfrac{1}{2}\ln\left(2\pi\right)+2\int_{0}^{\infty}\frac{\operatorname{arctan} \left(t/z\right)}{e^{2\pi t}-1}\,\mathrm{d}t,`

On the positive real axis this specializes Binet’s first formula without a logarithm-branch choice. The integral is asserted absolutely convergent before its value is identified.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_10_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_10_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.arctan (t / x) / (Real.exp (2 * Real.pi * t) - 1)) (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_10 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_10 {x : ℝ} (hx : 0 < x) :
    Real.log (Real.Gamma x) =
      (x - 1 / 2) * Real.log x - x + Real.log (2 * Real.pi) / 2 +
        2 * ∫ t in Ioi (0 : ℝ), Real.arctan (t / x) /
          (Real.exp (2 * Real.pi * t) - 1)
```
:::
::::

::::dlmfEntry "5.9.10_1" "https://dlmf.nist.gov/5.9.E10_1"
$$`\operatorname{Ln}\Gamma\left(z\right)=\left(z-\tfrac{1}{2}\right)\ln z-z+ \tfrac{1}{2}\ln\left(2\pi\right)-\frac{z}{\pi}\int_{0}^{\infty}\frac{\ln\left( 1-{\mathrm{e}}^{-2\pi t}\right)}{t^{2}+z^{2}}\,\mathrm{d}t,`

This positive-real specialization is the integration-by-parts form of Binet’s formula; its logarithmic kernel is recorded as an integrable function on (0,∞).

:::leanStatement "Lean statement"
```anchor dlmf_5_9_10_1_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_10_1_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn
      (fun t : ℝ ↦ Real.log (1 - Real.exp (-2 * Real.pi * t)) / (t ^ 2 + x ^ 2)) (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_10_1 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_10_1 {x : ℝ} (hx : 0 < x) :
    Real.log (Real.Gamma x) =
      (x - 1 / 2) * Real.log x - x + Real.log (2 * Real.pi) / 2 -
        x / Real.pi * ∫ t in Ioi (0 : ℝ),
          Real.log (1 - Real.exp (-2 * Real.pi * t)) / (t ^ 2 + x ^ 2)
```
:::
::::

::::dlmfEntry "5.9.10_2" "https://dlmf.nist.gov/5.9.E10_2"
$$`\operatorname{Ln}\Gamma\left(z\right)=\left(z-\tfrac{1}{2}\right)\ln z-z+ \tfrac{1}{2}\ln\left(2\pi\right)+\int_{0}^{\infty}{\mathrm{e}}^{-zt}\left( \frac{1}{{\mathrm{e}}^{t}-1}-\frac{1}{t}+\frac{1}{2}\right)\frac{\,\mathrm{d}t }{t},`

This positive-real Laplace form isolates the cancellation at t=0 inside one integrand and states its convergence explicitly.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_10_2_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_10_2_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-x * t) *
      (1 / (Real.exp t - 1) - 1 / t + 1 / 2) / t) (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_10_2 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_10_2 {x : ℝ} (hx : 0 < x) :
    Real.log (Real.Gamma x) =
      (x - 1 / 2) * Real.log x - x + Real.log (2 * Real.pi) / 2 +
        ∫ t in Ioi (0 : ℝ), Real.exp (-x * t) *
          (1 / (Real.exp t - 1) - 1 / t + 1 / 2) / t
```
:::
::::

::::dlmfEntry "5.9.11" "https://dlmf.nist.gov/5.9.E11"
$$`\operatorname{Ln}\Gamma\left(z+1\right)=-\gamma z-\frac{1}{2\pi i}\int_{-c- \infty i}^{-c+\infty i}\frac{\pi z^{-s}}{s\sin\left(\pi s\right)}\zeta\left(-s \right)\,\mathrm{d}s,`

For x>0 and 1<c<2, the Mellin–Barnes integral is taken upward on Re s=−c.
The shared Chapter 3 `VerticalLine` object supplies the symmetric finite-cutoff
contour and its named limit; these section-local names are thin bridges preserving
the source's positive parameter `c`. Integrability is a separate declaration.

:::leanStatement "Lean statement"
```anchor verticalSegment (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
noncomputable def verticalSegment (c L : ℝ) : LMLF.Integral.C1Contour :=
  (LMLF.Integral.verticalLine (-c)).symmetricSegment L
```
:::

:::leanStatement "Lean statement"
```anchor verticalLineIntegral (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
noncomputable def verticalLineIntegral (c : ℝ) (f : ℂ → ℂ) : ℂ :=
  (LMLF.Integral.verticalLine (-c)).symmetricSegmentValue f
```
:::

:::leanStatement "Lean statement"
```anchor verticalLineIntegrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
def verticalLineIntegrable (c : ℝ) (f : ℂ → ℂ) : Prop :=
  (LMLF.Integral.verticalLine (-c)).symmetricSegmentIntegrable f
```
:::

:::leanStatement "Lean statement"
```anchor verticalLineConverges (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
def verticalLineConverges (c : ℝ) (f : ℂ → ℂ) : Prop :=
  (LMLF.Integral.verticalLine (-c)).symmetricSegmentConverges f
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_11_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_11_integrable {x c : ℝ} (hx : 0 < x) (hc1 : 1 < c) (hc2 : c < 2) :
    verticalLineIntegrable c (fun s ↦
      Real.pi * (x : ℂ) ^ (-s) / (s * Complex.sin (Real.pi * s)) * riemannZeta (-s))
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_11_converges (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_11_converges {x c : ℝ} (hx : 0 < x) (hc1 : 1 < c) (hc2 : c < 2) :
    verticalLineConverges c (fun s ↦
      Real.pi * (x : ℂ) ^ (-s) / (s * Complex.sin (Real.pi * s)) * riemannZeta (-s))
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_11 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_11 {x c : ℝ} (hx : 0 < x) (hc1 : 1 < c) (hc2 : c < 2) :
    (Real.log (Real.Gamma (x + 1)) : ℂ) =
      -Real.eulerMascheroniConstant * x -
        verticalLineIntegral c (fun s ↦
          Real.pi * (x : ℂ) ^ (-s) / (s * Complex.sin (Real.pi * s)) * riemannZeta (-s)) /
          (2 * Real.pi * Complex.I)
```
:::
::::

::::dlmfEntry "5.9.11_1" "https://dlmf.nist.gov/5.9.E11_1"
$$`\Gamma^{*}\left(z\right)=1-\frac{1}{2\pi\mathrm{i}}\int_{0}^{\infty}\frac{{ \mathrm{e}}^{-2\pi t}\Gamma^{*}\left(t{\mathrm{e}}^{\mathrm{i}\pi/2}\right)}{t +\mathrm{i}z}\,\mathrm{d}t+\frac{1}{2\pi\mathrm{i}}\int_{0}^{\infty}\frac{{ \mathrm{e}}^{-2\pi t}\Gamma^{*}\left(t{\mathrm{e}}^{-\mathrm{i}\pi/2}\right)}{ t-\mathrm{i}z}\,\mathrm{d}t,`

For positive real x, the two scaled-Gamma kernels are absolutely integrable and their values combine exactly as displayed. `scaledGamma` spells out the normalization used by DLMF.

:::leanStatement "Lean statement"
```anchor scaledGamma (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
noncomputable def scaledGamma (z : ℂ) : ℂ :=
  Complex.Gamma z /
    ((2 * Real.pi : ℂ) ^ (1 / 2 : ℂ) * z ^ (z - 1 / 2) * Complex.exp (-z))
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_11_1_left_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_11_1_left_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-2 * Real.pi * t) *
      scaledGamma (t * Complex.I) / (t + Complex.I * x)) (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_11_1_right_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_11_1_right_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-2 * Real.pi * t) *
      scaledGamma (-t * Complex.I) / (t - Complex.I * x)) (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_11_1 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_11_1 {x : ℝ} (hx : 0 < x) :
    scaledGamma x = 1 - (1 / (2 * Real.pi * Complex.I)) *
      (∫ t in Ioi (0 : ℝ), Real.exp (-2 * Real.pi * t) *
        scaledGamma (t * Complex.I) / (t + Complex.I * x)) +
      (1 / (2 * Real.pi * Complex.I)) *
      (∫ t in Ioi (0 : ℝ), Real.exp (-2 * Real.pi * t) *
        scaledGamma (-t * Complex.I) / (t - Complex.I * x))
```
:::
::::

::::dlmfEntry "5.9.11_2" "https://dlmf.nist.gov/5.9.E11_2"
$$`\frac{1}{\Gamma^{*}\left(z\right)}=1-\frac{1}{2\pi\mathrm{i}}\int_{0}^{\infty} \frac{{\mathrm{e}}^{-2\pi t}\Gamma^{*}\left(t{\mathrm{e}}^{\mathrm{i}\pi/2} \right)}{t-\mathrm{i}z}\,\mathrm{d}t+\frac{1}{2\pi\mathrm{i}}\int_{0}^{\infty} \frac{{\mathrm{e}}^{-2\pi t}\Gamma^{*}\left(t{\mathrm{e}}^{-\mathrm{i}\pi/2} \right)}{t+\mathrm{i}z}\,\mathrm{d}t,`

The reciprocal scaled-Gamma representation uses the same two rays with the denominator signs interchanged; both convergence assertions remain visible.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_11_2_left_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_11_2_left_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-2 * Real.pi * t) *
      scaledGamma (t * Complex.I) / (t - Complex.I * x)) (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_11_2_right_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_11_2_right_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-2 * Real.pi * t) *
      scaledGamma (-t * Complex.I) / (t + Complex.I * x)) (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_11_2 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_11_2 {x : ℝ} (hx : 0 < x) :
    1 / scaledGamma x = 1 - (1 / (2 * Real.pi * Complex.I)) *
      (∫ t in Ioi (0 : ℝ), Real.exp (-2 * Real.pi * t) *
        scaledGamma (t * Complex.I) / (t - Complex.I * x)) +
      (1 / (2 * Real.pi * Complex.I)) *
      (∫ t in Ioi (0 : ℝ), Real.exp (-2 * Real.pi * t) *
        scaledGamma (-t * Complex.I) / (t + Complex.I * x))
```
:::
::::


# §5.9(ii) Psi Function, Euler’s Constant, and Derivatives
%%%
number := false
%%%

::::dlmfEntry "5.9.12" "https://dlmf.nist.gov/5.9.E12"
$$`\psi\left(z\right)=\int_{0}^{\infty}\left(\frac{e^{-t}}{t}-\frac{e^{-zt}}{1-e^ {-t}}\right)\,\mathrm{d}t,`

For x>0, Mathlib’s complex digamma at the real argument x equals this absolutely convergent integral.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_12_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_12_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-t) / t - Real.exp (-x * t) /
      (1 - Real.exp (-t))) (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_12 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_12 {x : ℝ} (hx : 0 < x) :
    Complex.digamma x = ∫ t in Ioi (0 : ℝ),
      Real.exp (-t) / t - Real.exp (-x * t) / (1 - Real.exp (-t))
```
:::
::::

::::dlmfEntry "5.9.13" "https://dlmf.nist.gov/5.9.E13"
$$`\psi\left(z\right)=\ln z+\int_{0}^{\infty}\left(\frac{1}{t}-\frac{1}{1-e^{-t}} \right)e^{-tz}\,\mathrm{d}t,`

For x>0, this separates log x from an absolutely convergent Laplace correction and identifies their sum with digamma.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_13_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_13_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ (1 / t - 1 / (1 - Real.exp (-t))) *
      Real.exp (-t * x)) (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_13 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_13 {x : ℝ} (hx : 0 < x) :
    Complex.digamma x = Real.log x + ∫ t in Ioi (0 : ℝ),
      (1 / t - 1 / (1 - Real.exp (-t))) * Real.exp (-t * x)
```
:::
::::

::::dlmfEntry "5.9.14" "https://dlmf.nist.gov/5.9.E14"
$$`\psi\left(z\right)=\int_{0}^{\infty}\left(e^{-t}-\frac{1}{(1+t)^{z}}\right) \frac{\,\mathrm{d}t}{t},`

For $`x>0`, the cancellation between $`e^{-t}` and $`(1+t)^{-x}` makes the quotient integrable at
the origin.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_14_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_14_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ (Real.exp (-t) - (1 + t) ^ (-x)) / t) (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_14 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_14 {x : ℝ} (hx : 0 < x) :
    Complex.digamma x = ∫ t in Ioi (0 : ℝ), (Real.exp (-t) - (1 + t) ^ (-x)) / t
```
:::
::::

::::dlmfEntry "5.9.15" "https://dlmf.nist.gov/5.9.E15"
$$`\psi\left(z\right)=\ln z-\frac{1}{2z}-2\int_{0}^{\infty}\frac{t\,\mathrm{d}t}{ (t^{2}+z^{2})(e^{2\pi t}-1)}.`

For x>0, the differentiated Binet kernel is absolutely integrable and gives the displayed correction to log x−1/(2x).

:::leanStatement "Lean statement"
```anchor dlmf_5_9_15_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_15_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ t / ((t ^ 2 + x ^ 2) *
      (Real.exp (2 * Real.pi * t) - 1))) (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_15 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_15 {x : ℝ} (hx : 0 < x) :
    Complex.digamma x = (Real.log x - 1 / (2 * x) : ℝ) -
      (2 : ℂ) * (↑((∫ t in Ioi (0 : ℝ),
        (t / ((t ^ 2 + x ^ 2) * (Real.exp (2 * Real.pi * t) - 1)) : ℝ)) : ℝ) : ℂ)
```
:::
::::

::::dlmfEntry "5.9.16" "https://dlmf.nist.gov/5.9.E16"
$$`\psi\left(z\right)+\gamma=\int_{0}^{\infty}\frac{e^{-t}-e^{-zt}}{1-e^{-t}}\, \mathrm{d}t=\int_{0}^{1}\frac{1-t^{z-1}}{1-t}\,\mathrm{d}t.`

For x>0, both integrands are absolutely integrable and give the same value ψ(x)+γ. The two value identities are displayed independently.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_16_laplace_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_16_laplace_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ (Real.exp (-t) - Real.exp (-x * t)) /
      (1 - Real.exp (-t))) (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_16_unit_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_16_unit_integrable {x : ℝ} (hx : 0 < x) :
    IntegrableOn (fun t : ℝ ↦ (1 - t ^ (x - 1)) / (1 - t)) (Ioo 0 1)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_16_laplace (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_16_laplace {x : ℝ} (hx : 0 < x) :
    Complex.digamma x + Real.eulerMascheroniConstant =
      ∫ t in Ioi (0 : ℝ), (Real.exp (-t) - Real.exp (-x * t)) /
        (1 - Real.exp (-t))
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_16_unit (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_16_unit {x : ℝ} (hx : 0 < x) :
    Complex.digamma x + Real.eulerMascheroniConstant =
      ∫ t in Ioo (0 : ℝ) 1, (1 - t ^ (x - 1)) / (1 - t)
```
:::
::::

::::dlmfEntry "5.9.17" "https://dlmf.nist.gov/5.9.E17"
$$`\psi\left(z+1\right)=-\gamma+\frac{1}{2\pi i}\int_{-c-\infty i}^{-c+\infty i} \frac{\pi z^{-s-1}}{\sin\left(\pi s\right)}\zeta\left(-s\right)\,\mathrm{d}s,`

For x>0 and 1<c<2, this is the differentiated Mellin–Barnes formula along the upward vertical line Re s=−c.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_17_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_17_integrable {x c : ℝ} (hx : 0 < x) (hc1 : 1 < c) (hc2 : c < 2) :
    verticalLineIntegrable c (fun s ↦ Real.pi * (x : ℂ) ^ (-s - 1) /
      Complex.sin (Real.pi * s) * riemannZeta (-s))
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_17_converges (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_17_converges {x c : ℝ} (hx : 0 < x) (hc1 : 1 < c) (hc2 : c < 2) :
    verticalLineConverges c (fun s ↦ Real.pi * (x : ℂ) ^ (-s - 1) /
      Complex.sin (Real.pi * s) * riemannZeta (-s))
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_17 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_17 {x c : ℝ} (hx : 0 < x) (hc1 : 1 < c) (hc2 : c < 2) :
    Complex.digamma (x + 1) = -Real.eulerMascheroniConstant +
      verticalLineIntegral c (fun s ↦ Real.pi * (x : ℂ) ^ (-s - 1) /
        Complex.sin (Real.pi * s) * riemannZeta (-s)) / (2 * Real.pi * Complex.I)
```
:::
::::

::::dlmfEntry "5.9.18" "https://dlmf.nist.gov/5.9.E18"
$$`\gamma=-\int_{0}^{\infty}e^{-t}\ln t\,\mathrm{d}t=\int_{0}^{\infty}\left(\frac {1}{1+t}-e^{-t}\right)\frac{\,\mathrm{d}t}{t}=\int_{0}^{1}(1-e^{-t})\frac{\, \mathrm{d}t}{t}-\int_{1}^{\infty}e^{-t}\frac{\,\mathrm{d}t}{t}=\int_{0}^{ \infty}\left(\frac{e^{-t}}{1-e^{-t}}-\frac{e^{-t}}{t}\right)\,\mathrm{d}t.`

The potentially singular expressions are paired with the convergence facts needed to read them as genuine integrals.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_18_first_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_18_first_integrable :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-t) * Real.log t) (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_18_second_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_18_second_integrable :
    IntegrableOn (fun t : ℝ ↦ (1 / (1 + t) - Real.exp (-t)) / t) (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_18_third_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_18_third_integrable :
    IntegrableOn (fun t : ℝ ↦ (1 - Real.exp (-t)) / t) (Ioo 0 1)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_18_fourth_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_18_fourth_integrable :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-t) / t) (Ici 1)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_18_fifth_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_18_fifth_integrable :
    IntegrableOn (fun t : ℝ ↦ Real.exp (-t) / (1 - Real.exp (-t)) - Real.exp (-t) / t)
      (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_18_first (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_18_first :
    Real.eulerMascheroniConstant = -∫ t in Ioi (0 : ℝ), Real.exp (-t) * Real.log t
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_18_second (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_18_second :
    Real.eulerMascheroniConstant = ∫ t in Ioi (0 : ℝ),
      (1 / (1 + t) - Real.exp (-t)) / t
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_18_third (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_18_third :
    Real.eulerMascheroniConstant =
      (∫ t in Ioo (0 : ℝ) 1, (1 - Real.exp (-t)) / t) -
        ∫ t in Ici (1 : ℝ), Real.exp (-t) / t
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_18_fourth (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_18_fourth :
    Real.eulerMascheroniConstant = ∫ t in Ioi (0 : ℝ),
      Real.exp (-t) / (1 - Real.exp (-t)) - Real.exp (-t) / t
```
:::
::::

::::dlmfEntry "5.9.19" "https://dlmf.nist.gov/5.9.E19"
$$`{\Gamma}^{(n)}\left(z\right)=\int_{0}^{\infty}(\ln t)^{n}e^{-t}t^{z-1}\, \mathrm{d}t,`

For n≥0 and Re z>0, the nth complex derivative of Gamma is obtained by differentiating Euler’s integral under the integral sign; the logarithmic kernel is absolutely integrable.

:::leanStatement "Lean statement"
```anchor dlmf_5_9_19_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_19_integrable (n : ℕ) {z : ℂ} (hz : 0 < z.re) :
    IntegrableOn (fun t : ℝ ↦ (Real.log t : ℂ) ^ n * Real.exp (-t) *
      (t : ℂ) ^ (z - 1)) (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_19 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_19 (n : ℕ) {z : ℂ} (hz : 0 < z.re) :
    iteratedDeriv n Complex.Gamma z = ∫ t in Ioi (0 : ℝ),
      (Real.log t : ℂ) ^ n * Real.exp (-t) * (t : ℂ) ^ (z - 1)
```
:::
::::

::::dlmfEntry "5.9.20" "https://dlmf.nist.gov/5.9.E20"
$$`\int_{c}^{z}\Gamma\left(t\right)\,\mathrm{d}t=\int_{0}^{\infty}\frac{t^{z-1}-t ^{c-1}}{\ln t}{\mathrm{e}}^{-t}\,\mathrm{d}t,`

For c and z in the right half-plane, Gamma integrated along their straight segment equals the absolutely convergent real integral on the right. `complexSegmentIntegral` fixes the path explicitly. The quotient at the removable point $`t=1` is totalized in Lean; changing a single point does not affect the integral.

:::leanStatement "Lean statement"
```anchor complexSegmentContour (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
noncomputable def complexSegmentContour (a b : ℂ) : LMLF.Integral.C1Contour where
  point u := a + (u : ℂ) * (b - a)
  tangent _ := b - a
  start := a
  finish := b
  point_zero := by sorry
  point_one := by sorry
  hasDeriv := by sorry
  tangent_continuous := by fun_prop
```
:::

:::leanStatement "Lean statement"
```anchor complexSegmentIntegral (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
noncomputable def complexSegmentIntegral (f : ℂ → ℂ) (a b : ℂ) : ℂ :=
  (complexSegmentContour a b).integral f
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_20_integrable (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_20_integrable {c z : ℂ} (hc : 0 < c.re) (hz : 0 < z.re) :
    IntegrableOn (fun t : ℝ ↦ ((t : ℂ) ^ (z - 1) - (t : ℂ) ^ (c - 1)) /
      Real.log t * Real.exp (-t)) (Ioi 0)
```
:::

:::leanStatement "Lean statement"
```anchor dlmf_5_9_20 (module := LMLF.Blueprint.Gamma.Section59) -showProofStates
theorem dlmf_5_9_20 {c z : ℂ} (hc : 0 < c.re) (hz : 0 < z.re) :
    complexSegmentIntegral Complex.Gamma c z = ∫ t in Ioi (0 : ℝ),
      ((t : ℂ) ^ (z - 1) - (t : ℂ) ^ (c - 1)) /
        Real.log t * Real.exp (-t)
```
:::
::::
