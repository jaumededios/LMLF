import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section420
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.20 Derivatives and Differential Equations" =>
%%%
tag := "chapter-4-section-20"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.20"
Source: NIST Digital Library of Mathematical Functions, §4.20.
:::

# §4.20 Derivatives and Differential Equations
%%%
number := false
%%%

The derivative statements below use the complex variable `z`.  The quotients
secant, cosecant, and cotangent are defined by their displayed complex
quotients, so their derivative formulas explicitly exclude the corresponding
zeros of cosine or sine.

:::leanStatement "Complex trigonometric vocabulary"
```anchor sec (module := LMLF.Blueprint.Elementary.Section420)
def sec (z : ℂ) : ℂ := 1 / Complex.cos z
```
```anchor csc (module := LMLF.Blueprint.Elementary.Section420)
def csc (z : ℂ) : ℂ := 1 / Complex.sin z
```
```anchor cot (module := LMLF.Blueprint.Elementary.Section420)
def cot (z : ℂ) : ℂ := Complex.cos z / Complex.sin z
```
:::

::::dlmfEntry "4.20.1" "https://dlmf.nist.gov/4.20.E1"
$$`\frac{d}{dz}\sin z=\cos z.`

Sine differentiates to cosine throughout the complex plane.

:::leanStatement "Derivative of sine"
```anchor dlmf_4_20_1 (module := LMLF.Blueprint.Elementary.Section420)
theorem dlmf_4_20_1 (z : ℂ) : deriv Complex.sin z = Complex.cos z
```
:::
::::

::::dlmfEntry "4.20.2" "https://dlmf.nist.gov/4.20.E2"
$$`\frac{d}{dz}\cos z=-\sin z.`

Cosine differentiates to the negative of sine.

:::leanStatement "Derivative of cosine"
```anchor dlmf_4_20_2 (module := LMLF.Blueprint.Elementary.Section420)
theorem dlmf_4_20_2 (z : ℂ) : deriv Complex.cos z = -Complex.sin z
```
:::
::::

::::dlmfEntry "4.20.3" "https://dlmf.nist.gov/4.20.E3"
$$`\frac{d}{dz}\tan z=\sec ^2z.`

At points where `cos z` is nonzero, tangent has derivative `sec z` squared.

:::leanStatement "Derivative of tangent away from poles"
```anchor dlmf_4_20_3 (module := LMLF.Blueprint.Elementary.Section420)
theorem dlmf_4_20_3 {z : ℂ} (hz : Complex.cos z ≠ 0) :
    deriv Complex.tan z = sec z ^ 2
```
:::
::::

::::dlmfEntry "4.20.4" "https://dlmf.nist.gov/4.20.E4"
$$`\frac{d}{dz}\csc z=-\csc z\cot z.`

The cosecant derivative is stated away from the zeros of sine.

:::leanStatement "Derivative of cosecant away from poles"
```anchor dlmf_4_20_4 (module := LMLF.Blueprint.Elementary.Section420)
theorem dlmf_4_20_4 {z : ℂ} (hz : Complex.sin z ≠ 0) :
    deriv csc z = -csc z * cot z
```
:::
::::

::::dlmfEntry "4.20.5" "https://dlmf.nist.gov/4.20.E5"
$$`\frac{d}{dz}\sec z=\sec z\tan z.`

The secant derivative is valid away from the zeros of cosine.

:::leanStatement "Derivative of secant away from poles"
```anchor dlmf_4_20_5 (module := LMLF.Blueprint.Elementary.Section420)
theorem dlmf_4_20_5 {z : ℂ} (hz : Complex.cos z ≠ 0) :
    deriv sec z = sec z * Complex.tan z
```
:::
::::

::::dlmfEntry "4.20.6" "https://dlmf.nist.gov/4.20.E6"
$$`\frac{d}{dz}\cot z=-\csc ^2z.`

Cotangent differentiates to negative cosecant squared wherever sine is
nonzero.

:::leanStatement "Derivative of cotangent away from poles"
```anchor dlmf_4_20_6 (module := LMLF.Blueprint.Elementary.Section420)
theorem dlmf_4_20_6 {z : ℂ} (hz : Complex.sin z ≠ 0) :
    deriv cot z = -(csc z) ^ 2
```
:::
::::

::::dlmfEntry "4.20.7" "https://dlmf.nist.gov/4.20.E7"
$$`\frac{d^n}{dz^n}\sin z=\sin\left(z+\frac12n\pi\right).`

For every natural number `n`, the `n`th derivative is a phase-shifted sine.
The Lean statement uses `iteratedDeriv` and the complex cast of `n`.

:::leanStatement "All derivatives of sine"
```anchor dlmf_4_20_7 (module := LMLF.Blueprint.Elementary.Section420)
theorem dlmf_4_20_7 (n : ℕ) (z : ℂ) :
    iteratedDeriv n Complex.sin z =
      Complex.sin (z + (n : ℂ) * (Real.pi / 2))
```
:::
::::

::::dlmfEntry "4.20.8" "https://dlmf.nist.gov/4.20.E8"
$$`\frac{d^n}{dz^n}\cos z=\cos\left(z+\frac12n\pi\right).`

The corresponding formula for every derivative of cosine has the same phase
shift.

:::leanStatement "All derivatives of cosine"
```anchor dlmf_4_20_8 (module := LMLF.Blueprint.Elementary.Section420)
theorem dlmf_4_20_8 (n : ℕ) (z : ℂ) :
    iteratedDeriv n Complex.cos z =
      Complex.cos (z + (n : ℂ) * (Real.pi / 2))
```
:::
::::

For the differential equations, `a` is a nonzero complex constant.  The
following explicit candidates make the solution-family distinction visible;
the differential equations are asserted for these candidates rather than for
an unconstrained arbitrary function.

:::leanStatement "Differential-equation candidates"
```anchor secondOrderCandidate (module := LMLF.Blueprint.Elementary.Section420)
def secondOrderCandidate (a A B z : ℂ) : ℂ :=
  A * Complex.cos (a * z) + B * Complex.sin (a * z)
```
```anchor energyCandidate (module := LMLF.Blueprint.Elementary.Section420)
def energyCandidate (a c z : ℂ) : ℂ := (1 / a) * Complex.sin (a * z + c)
```
```anchor riccatiCandidate (module := LMLF.Blueprint.Elementary.Section420)
def riccatiCandidate (a c z : ℂ) : ℂ := (1 / a) * Complex.tan (a * z + c)
```
:::

::::dlmfEntry "4.20.9" "https://dlmf.nist.gov/4.20.E9"
$$`\frac{d^2w}{dz^2}+a^2w=0.`

The displayed equation is evaluated on the explicit sine-cosine candidate
family.  The source's standing parameter condition is `a ≠ 0`, even though
the differential identity itself also makes sense at `a = 0`.

:::leanStatement "Second-order trigonometric equation"
```anchor dlmf_4_20_9 (module := LMLF.Blueprint.Elementary.Section420)
theorem dlmf_4_20_9 (a A B z : ℂ) (ha : a ≠ 0) :
    deriv (fun z => deriv (fun z => secondOrderCandidate a A B z) z) z +
      a ^ 2 * secondOrderCandidate a A B z = 0
```
:::
::::

::::dlmfEntry "4.20.10" "https://dlmf.nist.gov/4.20.E10"
$$`\left(\frac{dw}{dz}\right)^2+a^2w^2=1.`

The first-order energy equation is evaluated on its phase-shifted sine
candidate, under the same standing condition `a ≠ 0`.

:::leanStatement "First-order energy equation"
```anchor dlmf_4_20_10 (module := LMLF.Blueprint.Elementary.Section420)
theorem dlmf_4_20_10 (a c z : ℂ) (ha : a ≠ 0) :
    (deriv (fun z => energyCandidate a c z) z) ^ 2 +
      a ^ 2 * (energyCandidate a c z) ^ 2 = 1
```
:::
::::

::::dlmfEntry "4.20.11" "https://dlmf.nist.gov/4.20.E11"
$$`\frac{dw}{dz}-a^2w^2=1.`

The Riccati equation is evaluated on the tangent family at points where
`cos(az+c)` is nonzero; the standing parameter condition is again `a ≠ 0`.

:::leanStatement "Riccati equation"
```anchor dlmf_4_20_11 (module := LMLF.Blueprint.Elementary.Section420)
theorem dlmf_4_20_11 (a c z : ℂ) (ha : a ≠ 0)
    (hcos : Complex.cos (a * z + c) ≠ 0) :
    deriv (fun z => riccatiCandidate a c z) z -
      a ^ 2 * (riccatiCandidate a c z) ^ 2 = 1
```
:::
::::

The general solution families of these three equations are given next.  The
Lean equivalences characterize every globally differentiable solution in the
first two cases.  The Riccati family is local on an explicitly open,
preconnected domain, because tangent solutions have poles.  In the first
family `A` and `B` are arbitrary complex constants; in the latter two `c` is
arbitrary.

::::dlmfEntry "4.20.12" "https://dlmf.nist.gov/4.20.E12"
$$`w=A\cos(az)+B\sin(az).`

Every globally differentiable solution is represented by a choice of the
displayed sine-cosine family parameters; conversely every such choice solves
the equation.

:::leanStatement "General second-order solution family"
```anchor dlmf_4_20_12 (module := LMLF.Blueprint.Elementary.Section420)
theorem dlmf_4_20_12 (a : ℂ) (ha : a ≠ 0) :
    ∀ w : ℂ → ℂ,
      (Differentiable ℂ w ∧
        (∀ z, deriv (fun z => deriv w z) z + a ^ 2 * w z = 0)) ↔
      ∃ A B : ℂ, ∀ z, w z = secondOrderCandidate a A B z
```
:::
::::

::::dlmfEntry "4.20.13" "https://dlmf.nist.gov/4.20.E13"
$$`w=\frac1a\sin(az+c).`

Every globally differentiable nonconstant solution of the energy equation has
the phase-shifted sine form, parametrized by an arbitrary complex constant `c`.
The two constant equilibrium solutions `w=1/a` and `w=-1/a` are included
separately, and every listed family solves the equation.

:::leanStatement "General energy-equation solution family"
```anchor dlmf_4_20_13 (module := LMLF.Blueprint.Elementary.Section420)
theorem dlmf_4_20_13 (a : ℂ) (ha : a ≠ 0) :
    ∀ w : ℂ → ℂ,
      (Differentiable ℂ w ∧
        (∀ z, (deriv w z) ^ 2 + a ^ 2 * (w z) ^ 2 = 1)) ↔
      (∃ c : ℂ, ∀ z, w z = energyCandidate a c z) ∨
        (∀ z, w z = 1 / a) ∨ (∀ z, w z = -(1 / a))
```
:::
::::

::::dlmfEntry "4.20.14" "https://dlmf.nist.gov/4.20.E14"
$$`w=\frac1a\tan(az+c).`

On an open preconnected domain `U`, every nonconstant differentiable solution
of the Riccati equation is a tangent family with parameter `c`, provided the
domain avoids the finite poles.  The constant equilibria `w=I/a` and
`w=-I/a` are included separately; conversely each listed family solves the
equation on `U`.

:::leanStatement "General Riccati solution family"
```anchor dlmf_4_20_14 (module := LMLF.Blueprint.Elementary.Section420)
theorem dlmf_4_20_14 (a : ℂ) (ha : a ≠ 0) (U : Set ℂ)
    (hUopen : IsOpen U) (hUconn : IsPreconnected U) :
    ∀ w : ℂ → ℂ,
      (DifferentiableOn ℂ w U ∧
        (∀ z ∈ U, (derivWithin w U z) - a ^ 2 * (w z) ^ 2 = 1)) ↔
      (∃ c : ℂ, (∀ z ∈ U, w z = riccatiCandidate a c z) ∧
        (∀ z ∈ U, Complex.cos (a * z + c) ≠ 0)) ∨
        (∀ z ∈ U, w z = Complex.I / a) ∨
        (∀ z ∈ U, w z = -Complex.I / a)
```
:::
::::
