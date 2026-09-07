import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section419
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.19 Maclaurin Series and Laurent Series" =>
%%%
tag := "chapter-4-section-19"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.19"
Source: NIST Digital Library of Mathematical Functions, §4.19.
:::

The trigonometric functions have entire Maclaurin series for sine and cosine,
while tangent and secant have their nearest poles at `±π/2`.  Cosecant and
cotangent are represented by Laurent series with their principal parts at the
origin.  The final three displays are power series for the principal complex
logarithm.  In every entry, `HasSum` records both the coefficient sequence and
its convergence to the stated function value.  The Bernoulli coefficients use
Mathlib's canonical `bernoulli` sequence (with `B₀=1` and `B₁=-1/2`).  The
Euler coefficients use the transparent DLMF recurrence: `E₀=1`, odd Euler
numbers vanish, and each positive even `Eₙ` is the negative binomial sum of
the preceding even values.

:::leanStatement "Bernoulli, Euler, and Laurent-series vocabulary"
```anchor bernoulliNumber (module := LMLF.Blueprint.Elementary.Section419)
def bernoulliNumber (n : ℕ) : ℂ := (bernoulli n : ℂ)
```
```anchor eulerNumber (module := LMLF.Blueprint.Elementary.Section419)
def eulerNumber : ℕ → ℂ
  | 0 => 1
  | n + 1 =>
      if Even (n + 1) then
        -(∑ k : Fin ((n + 1) / 2),
          (Nat.choose (n + 1) (2 * k.1) : ℂ) * eulerNumber (2 * k.1))
      else 0
termination_by n => n
decreasing_by
  simp_wf
  omega
```
```anchor csc (module := LMLF.Blueprint.Elementary.Section419)
def csc (z : ℂ) : ℂ := 1 / Complex.sin z
```
```anchor sec (module := LMLF.Blueprint.Elementary.Section419)
def sec (z : ℂ) : ℂ := 1 / Complex.cos z
```
```anchor sinRatio (module := LMLF.Blueprint.Elementary.Section419)
def sinRatio (z : ℂ) : ℂ := if z = 0 then 1 else Complex.sin z / z
```
```anchor tanRatio (module := LMLF.Blueprint.Elementary.Section419)
def tanRatio (z : ℂ) : ℂ := if z = 0 then 1 else Complex.tan z / z
```
```anchor tanTerm (module := LMLF.Blueprint.Elementary.Section419)
def tanTerm (z : ℂ) (n : ℕ) : ℂ :=
  let m := n + 1
  ((-1 : ℂ) ^ (m - 1) * (2 : ℂ) ^ (2 * m) *
      ((2 : ℂ) ^ (2 * m) - 1) * bernoulliNumber (2 * m) /
      (Nat.factorial (2 * m) : ℂ)) * z ^ (2 * m - 1)
```
```anchor cscTerm (module := LMLF.Blueprint.Elementary.Section419)
def cscTerm (z : ℂ) (n : ℕ) : ℂ :=
  let m := n + 1
  ((-1 : ℂ) ^ (m - 1) * 2 *
      ((2 : ℂ) ^ (2 * m - 1) - 1) * bernoulliNumber (2 * m) /
      (Nat.factorial (2 * m) : ℂ)) * z ^ (2 * m - 1)
```
```anchor secTerm (module := LMLF.Blueprint.Elementary.Section419)
def secTerm (z : ℂ) (n : ℕ) : ℂ :=
  (-1 : ℂ) ^ n * eulerNumber (2 * n) /
      (Nat.factorial (2 * n) : ℂ) * z ^ (2 * n)
```
```anchor cotTerm (module := LMLF.Blueprint.Elementary.Section419)
def cotTerm (z : ℂ) (n : ℕ) : ℂ :=
  -(((-1 : ℂ) ^ n) * (2 : ℂ) ^ (2 * (n + 1)) *
      bernoulliNumber (2 * (n + 1)) / (Nat.factorial (2 * (n + 1)) : ℂ) *
      z ^ (2 * (n + 1) - 1))
```
```anchor logSinRatioTerm (module := LMLF.Blueprint.Elementary.Section419)
def logSinRatioTerm (z : ℂ) (n : ℕ) : ℂ :=
  let m := n + 1
  ((-1 : ℂ) ^ m * (2 : ℂ) ^ (2 * m - 1) * bernoulliNumber (2 * m) /
      ((m : ℂ) * (Nat.factorial (2 * m) : ℂ))) * z ^ (2 * m)
```
```anchor logCosTerm (module := LMLF.Blueprint.Elementary.Section419)
def logCosTerm (z : ℂ) (n : ℕ) : ℂ :=
  let m := n + 1
  ((-1 : ℂ) ^ m * (2 : ℂ) ^ (2 * m - 1) *
      ((2 : ℂ) ^ (2 * m) - 1) * bernoulliNumber (2 * m) /
      ((m : ℂ) * (Nat.factorial (2 * m) : ℂ))) * z ^ (2 * m)
```
```anchor logTanRatioTerm (module := LMLF.Blueprint.Elementary.Section419)
def logTanRatioTerm (z : ℂ) (n : ℕ) : ℂ :=
  let m := n + 1
  ((-1 : ℂ) ^ (m - 1) * (2 : ℂ) ^ (2 * m) *
      ((2 : ℂ) ^ (2 * m - 1) - 1) * bernoulliNumber (2 * m) /
      ((m : ℂ) * (Nat.factorial (2 * m) : ℂ))) * z ^ (2 * m)
```
:::

::::dlmfEntry "4.19.1" "https://dlmf.nist.gov/4.19.E1"
$$`
\sin z=\sum_{n=0}^{\infty}\frac{(-1)^n z^{2n+1}}{(2n+1)!}.
`

This series converges for every complex `z`, so sine is entire.

:::leanStatement "Sine Maclaurin series"
```anchor dlmf_4_19_1 (module := LMLF.Blueprint.Elementary.Section419)
theorem dlmf_4_19_1 (z : ℂ) :
    HasSum (fun n : ℕ ↦ (-1 : ℂ) ^ n * z ^ (2 * n + 1) /
      (Nat.factorial (2 * n + 1) : ℂ)) (Complex.sin z) := by sorry
```
:::
::::

::::dlmfEntry "4.19.2" "https://dlmf.nist.gov/4.19.E2"
$$`
\cos z=\sum_{n=0}^{\infty}\frac{(-1)^n z^{2n}}{(2n)!}.
`

The cosine series is also entire and converges for every complex `z`.

:::leanStatement "Cosine Maclaurin series"
```anchor dlmf_4_19_2 (module := LMLF.Blueprint.Elementary.Section419)
theorem dlmf_4_19_2 (z : ℂ) :
    HasSum (fun n : ℕ ↦ (-1 : ℂ) ^ n * z ^ (2 * n) /
      (Nat.factorial (2 * n) : ℂ)) (Complex.cos z) := by sorry
```
:::
::::

::::dlmfEntry "4.19.3" "https://dlmf.nist.gov/4.19.E3"
$$`
\tan z=\sum_{n=1}^{\infty}
\frac{(-1)^{n-1}2^{2n}(2^{2n}-1)B_{2n}}{(2n)!}z^{2n-1},
\qquad |z|<\frac{\pi}{2}.
`

The tangent series is a power series about zero with radius `π/2`; its
coefficient is written using the Bernoulli numbers `B₂ₙ`.

:::leanStatement "Tangent power series"
```anchor dlmf_4_19_3 (module := LMLF.Blueprint.Elementary.Section419)
theorem dlmf_4_19_3 {z : ℂ} (hz : ‖z‖ < Real.pi / 2) :
    HasSum (tanTerm z) (Complex.tan z) := by sorry
```
:::
::::

::::dlmfEntry "4.19.4" "https://dlmf.nist.gov/4.19.E4"
$$`
\csc z=\frac1z+\sum_{n=1}^{\infty}
\frac{(-1)^{n-1}2(2^{2n-1}-1)B_{2n}}{(2n)!}z^{2n-1},
\qquad 0<|z|<\pi.
`

This is a Laurent series on the punctured disk `0 < |z| < π`; the explicit
`1/z` is its principal part at the origin.

:::leanStatement "Cosecant Laurent series"
```anchor dlmf_4_19_4 (module := LMLF.Blueprint.Elementary.Section419)
theorem dlmf_4_19_4 {z : ℂ} (hz0 : 0 < ‖z‖) (hzπ : ‖z‖ < Real.pi) :
    HasSum (cscTerm z) (csc z - 1 / z) := by sorry
```
:::
::::

::::dlmfEntry "4.19.5" "https://dlmf.nist.gov/4.19.E5"
$$`
\sec z=\sum_{n=0}^{\infty}\frac{(-1)^nE_{2n}}{(2n)!}z^{2n},
\qquad |z|<\frac{\pi}{2}.
`

The Euler numbers `E₂ₙ` give the even-power secant series, convergent in the
disk bounded by the nearest poles.

:::leanStatement "Secant power series"
```anchor dlmf_4_19_5 (module := LMLF.Blueprint.Elementary.Section419)
theorem dlmf_4_19_5 {z : ℂ} (hz : ‖z‖ < Real.pi / 2) :
    HasSum (secTerm z) (sec z) := by sorry
```
:::
::::

::::dlmfEntry "4.19.6" "https://dlmf.nist.gov/4.19.E6"
$$`
\cot z=\frac1z-\sum_{n=1}^{\infty}
\frac{(-1)^{n-1}2^{2n}B_{2n}}{(2n)!}z^{2n-1},
\qquad 0<|z|<\pi.
`

As with cosecant, the cotangent expansion is Laurent rather than Maclaurin:
the `1/z` term is separated from the convergent series on the punctured disk.

:::leanStatement "Cotangent Laurent series"
```anchor dlmf_4_19_6 (module := LMLF.Blueprint.Elementary.Section419)
theorem dlmf_4_19_6 {z : ℂ} (hz0 : 0 < ‖z‖) (hzπ : ‖z‖ < Real.pi) :
    HasSum (cotTerm z) (Complex.cot z - 1 / z) := by sorry
```
:::
::::

::::dlmfEntry "4.19.7" "https://dlmf.nist.gov/4.19.E7"
$$`
\ln\left(\frac{\sin z}{z}\right)=\sum_{n=1}^{\infty}
\frac{(-1)^n2^{2n-1}B_{2n}}{n(2n)!}z^{2n},
\qquad |z|<\pi.
`

Here `ln` denotes the principal complex logarithm.  The disk `|z|<π` is the
convergence domain of the even-power expansion.  The Lean `sinRatio` name
extends `sin z/z` at the removable center by setting `sinRatio 0 = 1`, so the
left side is explicitly `log 1 = 0` at `z=0`.

:::leanStatement "Logarithm of sine over its argument"
```anchor dlmf_4_19_7 (module := LMLF.Blueprint.Elementary.Section419)
theorem dlmf_4_19_7 {z : ℂ} (hz : ‖z‖ < Real.pi) :
    HasSum (logSinRatioTerm z) (Complex.log (sinRatio z)) := by sorry
```
:::
::::

::::dlmfEntry "4.19.8" "https://dlmf.nist.gov/4.19.E8"
$$`
\ln(\cos z)=\sum_{n=1}^{\infty}
\frac{(-1)^n2^{2n-1}(2^{2n}-1)B_{2n}}{n(2n)!}z^{2n},
\qquad |z|<\frac{\pi}{2}.
`

The principal-logarithm series for cosine stops at the nearest zero of cosine,
giving the radius `π/2`.

:::leanStatement "Logarithm of cosine"
```anchor dlmf_4_19_8 (module := LMLF.Blueprint.Elementary.Section419)
theorem dlmf_4_19_8 {z : ℂ} (hz : ‖z‖ < Real.pi / 2) :
    HasSum (logCosTerm z) (Complex.log (Complex.cos z)) := by sorry
```
:::
::::

::::dlmfEntry "4.19.9" "https://dlmf.nist.gov/4.19.E9"
$$`
\ln\left(\frac{\tan z}{z}\right)=\sum_{n=1}^{\infty}
\frac{(-1)^{n-1}2^{2n}(2^{2n-1}-1)B_{2n}}{n(2n)!}z^{2n},
\qquad |z|<\frac{\pi}{2}.
`

The final expansion is again for the principal logarithm, now of the
even analytic quotient `tan z / z`; its disk ends at `|z|=π/2`.  The Lean
`tanRatio` definition makes the removable center explicit with `tanRatio 0 = 1`,
so the logarithm at zero is again `0`.

:::leanStatement "Logarithm of tangent over its argument"
```anchor dlmf_4_19_9 (module := LMLF.Blueprint.Elementary.Section419)
theorem dlmf_4_19_9 {z : ℂ} (hz : ‖z‖ < Real.pi / 2) :
    HasSum (logTanRatioTerm z) (Complex.log (tanRatio z)) := by sorry
```
:::
::::
