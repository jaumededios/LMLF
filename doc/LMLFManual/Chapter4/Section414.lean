import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section414
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.14 Definitions and Periodicity" =>
%%%
tag := "chapter-4-section-14"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.14"
Source: NIST Digital Library of Mathematical Functions, §4.14.
:::

The complex trigonometric functions are defined from the exponential, with
quotient functions interpreted away from their denominator zeros.  Sine and
cosine are entire; their zeros are integral and half-integral multiples of `π`,
respectively.  Consequently tangent, cosecant, secant, and cotangent are
meromorphic, with poles inherited from the corresponding denominator zeros.

::::dlmfEntry "4.14.1" "https://dlmf.nist.gov/4.14.E1"
$$`\sin z=\frac{e^{iz}-e^{-iz}}{2i}.`
The sine function is defined for complex `z` by the displayed exponential
quotient.
:::leanStatement "Complex sine definition"
```anchor dlmf_4_14_1 (module := LMLF.Blueprint.Elementary.Section414) -showProofStates
theorem dlmf_4_14_1 (z : ℂ) :
    Complex.sin z =
      (Complex.exp (Complex.I * z) - Complex.exp (-Complex.I * z)) /
        (2 * Complex.I)
```
:::
::::

::::dlmfEntry "4.14.2" "https://dlmf.nist.gov/4.14.E2"
$$`\cos z=\frac{e^{iz}+e^{-iz}}2.`
The cosine function is defined by the companion exponential expression.
:::leanStatement "Complex cosine definition"
```anchor dlmf_4_14_2 (module := LMLF.Blueprint.Elementary.Section414) -showProofStates
theorem dlmf_4_14_2 (z : ℂ) :
    Complex.cos z =
      (Complex.exp (Complex.I * z) + Complex.exp (-Complex.I * z)) / 2
```
:::
::::

::::dlmfEntry "4.14.3" "https://dlmf.nist.gov/4.14.E3"
$$`\cos z\pm i\sin z=e^{\pm iz}.`
The two signed combinations recover the positive and negative exponential
modes.
:::leanStatement "Exponential trigonometric combinations"
```anchor dlmf_4_14_3 (module := LMLF.Blueprint.Elementary.Section414) -showProofStates
theorem dlmf_4_14_3 (z : ℂ) :
    Complex.cos z + Complex.I * Complex.sin z = Complex.exp (Complex.I * z) ∧
      Complex.cos z - Complex.I * Complex.sin z = Complex.exp (-Complex.I * z)
```
:::
::::

::::dlmfEntry "4.14.4" "https://dlmf.nist.gov/4.14.E4"
$$`\tan z=\frac{\sin z}{\cos z}.`
Tangent is the quotient on the locus where cosine is nonzero.
:::leanStatement "Complex tangent definition"
```anchor dlmf_4_14_4 (module := LMLF.Blueprint.Elementary.Section414) -showProofStates
theorem dlmf_4_14_4 {z : ℂ} (hz : Complex.cos z ≠ 0) :
    Complex.tan z = Complex.sin z / Complex.cos z
```
:::
::::

::::dlmfEntry "4.14.5" "https://dlmf.nist.gov/4.14.E5"
$$`\csc z=\frac1{\sin z}.`
Cosecant is the reciprocal of sine away from sine's zeros.
:::leanStatement "Cosecant reciprocal"
```anchor csc (module := LMLF.Blueprint.Elementary.Section414) -showProofStates
noncomputable def csc (z : ℂ) : ℂ := 1 / Complex.sin z
```
```anchor dlmf_4_14_5 (module := LMLF.Blueprint.Elementary.Section414) -showProofStates
theorem dlmf_4_14_5 {z : ℂ} (hz : Complex.sin z ≠ 0) :
    csc z = 1 / Complex.sin z
```
:::
::::

::::dlmfEntry "4.14.6" "https://dlmf.nist.gov/4.14.E6"
$$`\sec z=\frac1{\cos z}.`
Secant is the reciprocal of cosine away from cosine's zeros.
:::leanStatement "Secant reciprocal"
```anchor sec (module := LMLF.Blueprint.Elementary.Section414) -showProofStates
noncomputable def sec (z : ℂ) : ℂ := 1 / Complex.cos z
```
```anchor dlmf_4_14_6 (module := LMLF.Blueprint.Elementary.Section414) -showProofStates
theorem dlmf_4_14_6 {z : ℂ} (hz : Complex.cos z ≠ 0) :
    sec z = 1 / Complex.cos z
```
:::
::::

::::dlmfEntry "4.14.7" "https://dlmf.nist.gov/4.14.E7"
$$`\cot z=\frac{\cos z}{\sin z}=\frac1{\tan z}.`
On the common domain of the quotients, cotangent has both displayed forms.
:::leanStatement "Cotangent reciprocal identity"
```anchor dlmf_4_14_7 (module := LMLF.Blueprint.Elementary.Section414) -showProofStates
theorem dlmf_4_14_7 {z : ℂ} (hs : Complex.sin z ≠ 0) (ht : Complex.tan z ≠ 0) :
    Complex.cos z / Complex.sin z = 1 / Complex.tan z
```
:::
::::

The zeros of sine are `kπ`, and the zeros of cosine are `(k+1/2)π`, for
integers `k`.  The quotient functions are therefore meromorphic; their poles
occur at the zeros of the denominator indicated in (4.14.4)–(4.14.7).

:::leanStatement "Sine and cosine zero sets"
```anchor sin_zero_iff (module := LMLF.Blueprint.Elementary.Section414) -showProofStates
theorem sin_zero_iff (z : ℂ) :
    Complex.sin z = 0 ↔ ∃ k : ℤ, z = (k : ℂ) * Real.pi
```

```anchor cos_zero_iff (module := LMLF.Blueprint.Elementary.Section414) -showProofStates
theorem cos_zero_iff (z : ℂ) :
    Complex.cos z = 0 ↔ ∃ k : ℤ, z = ((k : ℂ) + 1 / 2) * Real.pi
```
:::

::::dlmfEntry "4.14.8" "https://dlmf.nist.gov/4.14.E8"
$$`\sin(z+2k\pi)=\sin z,\qquad k\in\mathbb Z.`
Sine has period `2π` over the complex plane.
:::leanStatement "Sine periodicity"
```anchor dlmf_4_14_8 (module := LMLF.Blueprint.Elementary.Section414) -showProofStates
theorem dlmf_4_14_8 (z : ℂ) (k : ℤ) :
    Complex.sin (z + 2 * (k : ℂ) * Real.pi) = Complex.sin z
```
:::
::::

::::dlmfEntry "4.14.9" "https://dlmf.nist.gov/4.14.E9"
$$`\cos(z+2k\pi)=\cos z,\qquad k\in\mathbb Z.`
Cosine has the same period `2π`.
:::leanStatement "Cosine periodicity"
```anchor dlmf_4_14_9 (module := LMLF.Blueprint.Elementary.Section414) -showProofStates
theorem dlmf_4_14_9 (z : ℂ) (k : ℤ) :
    Complex.cos (z + 2 * (k : ℂ) * Real.pi) = Complex.cos z
```
:::
::::

::::dlmfEntry "4.14.10" "https://dlmf.nist.gov/4.14.E10"
$$`\tan(z+k\pi)=\tan z,\qquad k\in\mathbb Z.`
Tangent has period `π` wherever the shifted point is not a pole.
:::leanStatement "Tangent periodicity"
```anchor dlmf_4_14_10 (module := LMLF.Blueprint.Elementary.Section414) -showProofStates
theorem dlmf_4_14_10 {z : ℂ} (k : ℤ)
    (hz : Complex.cos (z + (k : ℂ) * Real.pi) ≠ 0) :
    Complex.tan (z + (k : ℂ) * Real.pi) = Complex.tan z
```
:::
::::
