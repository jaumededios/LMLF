import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section54
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "Gamma Function · §5.4 Special Values and Extrema" =>
%%%
tag := "chapter-5-section-5-4"
%%%

:::dlmfChapter "https://dlmf.nist.gov/5.4"
Source: NIST Digital Library of Mathematical Functions, §5.4, Special Values and Extrema.
:::

# §5.4 Special Values and Extrema
%%%
number := false
%%%

The statements below follow the twenty numbered equations in the official
[DLMF §5.4](https://dlmf.nist.gov/5.4), with exact real or complex specializations
made explicit in the accompanying prose.

## §5.4(i) Gamma Function
%%%
number := false
%%%

::::dlmfEntry "5.4.1" "https://dlmf.nist.gov/5.4.E1"
$$`\Gamma(1)=1,\qquad n!=\Gamma(n+1).`
For every nonnegative integer n, Gamma at n+1 is the factorial of n.
:::leanStatement "Lean · integer Gamma values"
```anchor gamma_special_factorial (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem gamma_special_factorial :
    Complex.Gamma 1 = 1 ∧
      ∀ n : ℕ, Complex.Gamma (n + 1) = (n.factorial : ℂ)
```
:::
::::

::::dlmfEntry "5.4.2" "https://dlmf.nist.gov/5.4.E2"
$$`n!!=2^{n/2}\Gamma(n/2+1)` for even n, and
$$`n!!=\pi^{-1/2}2^{n/2+1/2}\Gamma(n/2+1)` for odd n.
Here n!! is the finite same-parity product; the definition and both parity cases are exposed.
The source notes that the odd line also applies at the exceptional index `n = -1`.
The Lean specialization below uses `n : ℕ`, so it covers the nonnegative indices only.
:::leanStatement "Lean · double factorial"
```anchor doubleFactorial (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
def doubleFactorial (n : ℕ) : ℕ :=
  ∏ k ∈ Finset.range (n / 2 + n % 2), (n - 2 * k)
```
```anchor gamma_doubleFactorial_even (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem gamma_doubleFactorial_even {n : ℕ} (hn : n % 2 = 0) :
    (doubleFactorial n : ℝ) =
      (2 : ℝ) ^ ((n : ℝ) / 2) * Real.Gamma ((n : ℝ) / 2 + 1)
```
```anchor gamma_doubleFactorial_odd (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem gamma_doubleFactorial_odd {n : ℕ} (hn : n % 2 = 1) :
    (doubleFactorial n : ℝ) =
      Real.pi ^ (-((1 : ℝ) / 2)) *
        (2 : ℝ) ^ ((n : ℝ) / 2 + 1 / 2) * Real.Gamma ((n : ℝ) / 2 + 1)
```
:::
::::

::::dlmfEntry "5.4.3" "https://dlmf.nist.gov/5.4.E3"
$$`|\Gamma(iy)|=\left(\frac{\pi}{y\sinh(\pi y)}\right)^{1/2}.`
For nonzero real y, this is the positive square root of the displayed quotient.
:::leanStatement "Lean · imaginary-axis modulus"
```anchor gamma_imaginary_modulus (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem gamma_imaginary_modulus {y : ℝ} (hy : y ≠ 0) :
    ‖Complex.Gamma (Complex.I * (y : ℂ))‖ =
      Real.sqrt (Real.pi / (y * Real.sinh (Real.pi * y)))
```
:::
::::

::::dlmfEntry "5.4.4" "https://dlmf.nist.gov/5.4.E4"
$$`\Gamma(\tfrac12+iy)\Gamma(\tfrac12-iy)=|\Gamma(\tfrac12+iy)|^2=\frac{\pi}{\cosh(\pi y)}.`
The conjugate product equals the squared modulus and then pi over cosh(pi times y); the real norm square is cast into ℂ.
:::leanStatement "Lean · half-line Gamma product"
```anchor gamma_half_line_product (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem gamma_half_line_product (y : ℝ) :
    Complex.Gamma ((1 / 2 : ℂ) + Complex.I * y) *
        Complex.Gamma ((1 / 2 : ℂ) - Complex.I * y) =
      (‖Complex.Gamma ((1 / 2 : ℂ) + Complex.I * y)‖ ^ 2 : ℝ) ∧
    (‖Complex.Gamma ((1 / 2 : ℂ) + Complex.I * y)‖ ^ 2 : ℝ) =
      Real.pi / Real.cosh (Real.pi * y)
```
:::
::::

::::dlmfEntry "5.4.5" "https://dlmf.nist.gov/5.4.E5"
$$`\Gamma(\tfrac14+iy)\Gamma(\tfrac34-iy)=\frac{\pi\sqrt2}{\cosh(\pi y)+i\sinh(\pi y)}.`
This complex product identity holds for every real y.
:::leanStatement "Lean · quarter-shifted product"
```anchor gamma_quarter_shift_product (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem gamma_quarter_shift_product (y : ℝ) :
    Complex.Gamma ((1 / 4 : ℂ) + Complex.I * y) *
        Complex.Gamma ((3 / 4 : ℂ) - Complex.I * y) =
      (Real.pi * Real.sqrt 2 : ℂ) /
        (Complex.cosh (Real.pi * y) + Complex.I * Complex.sinh (Real.pi * y))
```
:::
::::

::::dlmfEntry "5.4.6" "https://dlmf.nist.gov/5.4.E6"
$$`\Gamma(\tfrac12)=\sqrt\pi=1.77245385090551602729\ldots.`
The exact value is sqrt(pi); the displayed decimal is represented as a twenty-decimal enclosure.
:::leanStatement "Lean · Gamma at one-half"
```anchor gamma_half_value (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem gamma_half_value :
    Real.Gamma (1 / 2 : ℝ) = Real.sqrt Real.pi ∧
      |Real.Gamma (1 / 2 : ℝ) - 1.77245385090551602729| < 1 / 10 ^ 20
```
:::
::::

::::dlmfEntry "5.4.7" "https://dlmf.nist.gov/5.4.E7"
$$`\Gamma(\tfrac13)=2.67893853470774763365\ldots.`
The source decimal is a twenty-decimal enclosure for real Gamma(1/3).
:::leanStatement "Lean · Gamma at one-third"
```anchor gamma_third_value (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem gamma_third_value :
    |Real.Gamma (1 / 3 : ℝ) - 2.67893853470774763365| < 1 / 10 ^ 20
```
:::
::::

::::dlmfEntry "5.4.8" "https://dlmf.nist.gov/5.4.E8"
$$`\Gamma(\tfrac23)=1.35411793942640041694\ldots.`
This is the corresponding enclosure for real Gamma(2/3).
:::leanStatement "Lean · Gamma at two-thirds"
```anchor gamma_two_thirds_value (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem gamma_two_thirds_value :
    |Real.Gamma (2 / 3 : ℝ) - 1.35411793942640041694| < 1 / 10 ^ 20
```
:::
::::

::::dlmfEntry "5.4.9" "https://dlmf.nist.gov/5.4.E9"
$$`\Gamma(\tfrac14)=3.62560990822190831193\ldots.`
This is the corresponding enclosure for real Gamma(1/4).
:::leanStatement "Lean · Gamma at one-quarter"
```anchor gamma_quarter_value (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem gamma_quarter_value :
    |Real.Gamma (1 / 4 : ℝ) - 3.62560990822190831193| < 1 / 10 ^ 20
```
:::
::::

::::dlmfEntry "5.4.10" "https://dlmf.nist.gov/5.4.E10"
$$`\Gamma(\tfrac34)=1.22541670246517764512\ldots.`
This is the corresponding enclosure for real Gamma(3/4).
:::leanStatement "Lean · Gamma at three-quarters"
```anchor gamma_three_quarters_value (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem gamma_three_quarters_value :
    |Real.Gamma (3 / 4 : ℝ) - 1.22541670246517764512| < 1 / 10 ^ 20
```
:::
::::

::::dlmfEntry "5.4.11" "https://dlmf.nist.gov/5.4.E11"
$$`\Gamma'(1)=-\gamma.`
The signed derivative of real Gamma at one is minus Euler's constant.
:::leanStatement "Lean · Gamma derivative at one"
```anchor gamma_deriv_one_value (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem gamma_deriv_one_value :
    deriv Real.Gamma 1 = -Real.eulerMascheroniConstant
```
:::
::::

## §5.4(ii) Psi Function
%%%
number := false
%%%

Source: [DLMF §5.4(ii)](https://dlmf.nist.gov/5.4.ii).

The psi identities use Complex.digamma; real constants are embedded into ℂ, and imaginary-part formulas
are stated on the indicated real lines.

::::dlmfEntry "5.4.12" "https://dlmf.nist.gov/5.4.E12"
$$`\psi(1)=-\gamma,\qquad \psi'(1)=\tfrac16\pi^2.`
At one, psi is the negative Euler constant. The signed derivative specialization is positive and equals pi^2/6.
:::leanStatement "Lean · psi at one"
```anchor digamma_one_values (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem digamma_one_values :
    Complex.digamma 1 = (-Real.eulerMascheroniConstant : ℂ) ∧
      deriv Complex.digamma 1 = Real.pi ^ 2 / 6
```
:::
::::

::::dlmfEntry "5.4.13" "https://dlmf.nist.gov/5.4.E13"
$$`\psi(\tfrac12)=-\gamma-2\ln2,\qquad \psi'(\tfrac12)=\tfrac12\pi^2.`
At one-half, psi has correction -2 ln 2. The signed derivative specialization is positive and equals pi^2/2.
:::leanStatement "Lean · psi at one-half"
```anchor digamma_half_values (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem digamma_half_values :
    Complex.digamma (1 / 2 : ℂ) =
        (-(Real.eulerMascheroniConstant : ℝ) - 2 * Real.log 2 : ℂ) ∧
      deriv Complex.digamma (1 / 2 : ℂ) = Real.pi ^ 2 / 2
```
:::
::::

::::dlmfEntry "5.4.14" "https://dlmf.nist.gov/5.4.E14"
$$`\psi(n+1)=\sum_{k=1}^n\frac1k-\gamma.`
For nonnegative n, the finite harmonic sum through n differs from psi at n+1 by Euler's constant.
:::leanStatement "Lean · integer psi values"
```anchor digamma_nat_value (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem digamma_nat_value (n : ℕ) :
    Complex.digamma (n + 1) =
      (∑ k ∈ Finset.range n, (1 / ((k + 1 : ℕ) : ℂ))) -
        (Real.eulerMascheroniConstant : ℂ)
```
:::
::::

::::dlmfEntry "5.4.15" "https://dlmf.nist.gov/5.4.E15"
$$`\psi(n+\tfrac12)=-\gamma-2\ln2+2\sum_{k=1}^n\frac1{2k-1}.`
For positive n, this is the odd reciprocal sum through 1/(2n-1).
:::leanStatement "Lean · half-integer psi values"
```anchor digamma_half_nat_value (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem digamma_half_nat_value {n : ℕ} (hn : 0 < n) :
    Complex.digamma ((n : ℂ) + 1 / 2) =
      (-(Real.eulerMascheroniConstant : ℝ) - 2 * Real.log 2 : ℂ) +
        2 * ∑ k ∈ Finset.range n, (1 / ((2 * k + 1 : ℕ) : ℂ))
```
:::
::::

::::dlmfEntry "5.4.16" "https://dlmf.nist.gov/5.4.E16"
$$`\Im\psi(iy)=\frac1{2y}+\frac\pi2\coth(\pi y).`
For nonzero real y, Lean writes coth as cosh/sinh.
:::leanStatement "Lean · imaginary-axis psi"
```anchor digamma_imaginary_part (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem digamma_imaginary_part {y : ℝ} (hy : y ≠ 0) :
    (Complex.digamma (Complex.I * (y : ℂ))).im =
      1 / (2 * y) + Real.pi / 2 * (Real.cosh (Real.pi * y) / Real.sinh (Real.pi * y))
```
:::
::::

::::dlmfEntry "5.4.17" "https://dlmf.nist.gov/5.4.E17"
$$`\Im\psi(\tfrac12+iy)=\frac\pi2\tanh(\pi y).`
On the line through one-half, the imaginary part is pi*tanh(pi*y)/2.
:::leanStatement "Lean · half-shifted psi"
```anchor digamma_half_shift_imaginary_part (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem digamma_half_shift_imaginary_part (y : ℝ) :
    (Complex.digamma ((1 / 2 : ℂ) + Complex.I * y)).im =
      Real.pi / 2 * (Real.sinh (Real.pi * y) / Real.cosh (Real.pi * y))
```
:::
::::

::::dlmfEntry "5.4.18" "https://dlmf.nist.gov/5.4.E18"
$$`\Im\psi(1+iy)=-\frac1{2y}+\frac\pi2\coth(\pi y).`
On the line through one, the reciprocal term is negative and coth is cosh/sinh.
:::leanStatement "Lean · one-shifted psi"
```anchor digamma_one_shift_imaginary_part (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem digamma_one_shift_imaginary_part {y : ℝ} (hy : y ≠ 0) :
    (Complex.digamma (1 + Complex.I * (y : ℂ))).im =
      -1 / (2 * y) + Real.pi / 2 * (Real.cosh (Real.pi * y) / Real.sinh (Real.pi * y))
```
:::
::::

::::dlmfEntry "5.4.19" "https://dlmf.nist.gov/5.4.E19"
$$`\psi(\tfrac pq)=-\gamma-\ln q-\tfrac\pi2\cot(\tfrac{\pi p}q)
+\tfrac12\sum_{k=1}^{q-1}\cos(\tfrac{2\pi kp}q)\ln(2-2\cos(\tfrac{2\pi k}q)).`
For naturals with 0 < p < q, this finite Gauss sum gives the value at p/q; the Lean version uses
complex logarithm and functions with index set 1 <= k < q.
:::leanStatement "Lean · rational psi value"
```anchor digamma_rational_value (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem digamma_rational_value {p q : ℕ} (hp : 0 < p) (hpq : p < q) :
    Complex.digamma ((p : ℂ) / q) =
      -(Real.eulerMascheroniConstant : ℂ) - Complex.log q -
        (Real.pi : ℂ) / 2 * Complex.cot ((Real.pi : ℂ) * p / q) +
        (1 / 2 : ℂ) * ∑ k ∈ Finset.Ico 1 q,
          Complex.cos (2 * (Real.pi : ℂ) * k * p / q) *
            Complex.log (2 - 2 * Complex.cos (2 * (Real.pi : ℂ) * k / q))
```
:::
::::

## §5.4(iii) Extrema
%%%
number := false
%%%

Source: [DLMF §5.4(iii)](https://dlmf.nist.gov/5.4.iii).

The source table lists real critical points x-sub-n of Gamma, characterized by Gamma'(x-sub-n)=psi(x-sub-n)=0.
Its eleven rows below reproduce the source's corrected decimal approximations for x-sub-n and Gamma(x-sub-n);
they are displayed data, not exact decimal equalities. The source correction note records that several x-sub-n
entries were corrected in their last two or three digits and ten extra decimal places were added. The final
numbered formula gives their large-n location; the Lean statement writes its O term as an eventual bound with
some positive C.

| n | xₙ | Γ(xₙ) |
|---:|---:|---:|
| 0 | `1.46163214496836234126` | `0.88560319441088870028` |
| 1 | `-0.50408300826445540926` | `-3.54464361115500508912` |
| 2 | `-1.57349847316239045878` | `2.30240725833968013582` |
| 3 | `-2.61072086844414465000` | `-0.88813635840124192010` |
| 4 | `-3.63529336643690109784` | `0.24512753983436625044` |
| 5 | `-4.65323776174314244171` | `-0.05277963958731940076` |
| 6 | `-5.66716244155688553585` | `0.00932459448261485052` |
| 7 | `-6.67841821307342674283` | `-0.00139739660894976730` |
| 8 | `-7.68778832503162603744` | `0.00018187844490940419` |
| 9 | `-8.69576416381640126649` | `-0.00002092529044652667` |
| 10 | `-9.70267254000186373608` | `0.00000215741610452285` |

Compare [Figure 5.3.1](https://dlmf.nist.gov/5.3#F1) for the corresponding graph.

::::dlmfEntry "5.4.20" "https://dlmf.nist.gov/5.4.E20"
$$`x_n=-n+\frac1\pi\arctan\left(\frac\pi{\ln n}\right)
+O\left(\frac1{n(\ln n)^2}\right),\qquad n\to\infty.`
There is a real critical-point sequence whose difference from the displayed approximation is eventually
bounded by a constant multiple of 1/(n(ln n)^2); this is the real sequence specialization.
:::leanStatement "Lean · extrema locations"
```anchor gamma_extrema_asymptotic (module := LMLF.Blueprint.Gamma.Section54) -showProofStates
theorem gamma_extrema_asymptotic :
    ∃ x : ℕ → ℝ,
      (∀ n : ℕ,
        deriv Real.Gamma (x n) = 0 ∧
          Complex.digamma (x n : ℂ) = 0) ∧
        ∃ C : ℝ, 0 < C ∧
          ∀ᶠ n : ℕ in atTop,
            |x n - (-n + 1 / Real.pi * Real.arctan (Real.pi / Real.log n))| ≤
              C / (n * (Real.log n) ^ 2)
```
:::
::::
