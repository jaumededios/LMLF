import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section445
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.Elementary.Section445
set_option verso.exampleProject "."

#doc (Manual) "§4.45 Methods of Computation" =>
%%%
tag := "chapter-4-section-45"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.45"
Source: NIST Digital Library of Mathematical Functions, §4.45.
:::

# §4.45 Methods of Computation
%%%
number := false
%%%

DLMF §4.45 organizes practical computation by first reducing arguments to
stable ranges, then applying convergent series, recurrences, or direct
definitions. The declarations below preserve the source regimes and identify
finite recurrences, the convergent large-argument series, and a separately
marked remainder/enclosure strengthening of the worked numerical check.

## Real variables: logarithms and exponentials
%%%
number := false
%%%
::::dlmfEntry "4.45.1–5" "https://dlmf.nist.gov/4.45.i"
Logarithms use repeated square-root reduction and scaling; exponentials use decimal rescaling so the residual argument is small.
[DLMF 4.45.E1](https://dlmf.nist.gov/4.45.E1)
$$`y=x^{2^{-m}}-1,\qquad \frac{1}{10}\leq x\leq 10.`
:::leanStatement "DLMF 4.45.E1"
```anchor dlmf_4_45_1 (module := LMLF.Blueprint.Elementary.Section445)
theorem dlmf_4_45_1 {x : ℝ} (hx : 1 / 10 ≤ x) (hx' : x ≤ 10) (m : ℕ) :
    logRootReduction x m = Real.rpow x ((2 : ℝ) ^ (-(m : ℝ))) - 1
```
:::
[DLMF 4.45.E2](https://dlmf.nist.gov/4.45.E2)
$$`\ln x=2^m\ln(1+y).`
:::leanStatement "DLMF 4.45.E2"
```anchor dlmf_4_45_2 (module := LMLF.Blueprint.Elementary.Section445)
theorem dlmf_4_45_2 {x y : ℝ} (hx : 0 < x) (m : ℕ)
    (hy : y = logRootReduction x m) :
    Real.log x = (2 : ℝ) ^ (m : ℝ) * Real.log (1 + y)
```
:::
Here `m` is the selected number of square-root reductions in the numerical
method; the formal API restricts it to a natural number, as repeated
square-root steps require.
[DLMF 4.45.E3](https://dlmf.nist.gov/4.45.E3)
$$`\ln x=\ln \xi+m\ln 10,\qquad x=10^m\xi,\qquad \frac{1}{10}\leq \xi\leq 10.`
:::leanStatement "DLMF 4.45.E3"
```anchor dlmf_4_45_3 (module := LMLF.Blueprint.Elementary.Section445)
theorem dlmf_4_45_3 {x ξ : ℝ} (hx : 0 < x) (hξ : 1 / 10 ≤ ξ) (hξ' : ξ ≤ 10)
    (m : ℤ) (hscale : x = Real.rpow 10 (m : ℝ) * ξ) :
    Real.log x = Real.log ξ + (m : ℝ) * Real.log 10
```
:::
In this decimal-rescaling method, `m` is the selected integer that puts `ξ`
in the stated stable range, rather than a free computational choice.
The reusable API names this selected index `decimalReductionIndex`, its
residual `decimalReductionResidual`, and the bound
`decimalReductionRange`; E4 relates those objects directly.
[DLMF 4.45.E4](https://dlmf.nist.gov/4.45.E4)
$$`m=\left\lfloor\frac{x}{\ln 10}+\frac12\right\rfloor,\qquad y=x-m\ln 10.`
:::leanStatement "DLMF 4.45.E4"
```anchor dlmf_4_45_4 (module := LMLF.Blueprint.Elementary.Section445)
theorem dlmf_4_45_4 (x : ℝ) :
    x = (decimalReductionIndex x : ℝ) * Real.log 10 +
      decimalReductionResidual x ∧
      decimalReductionRange x
```
:::
[DLMF 4.45.E5](https://dlmf.nist.gov/4.45.E5)
$$`e^x=10^m e^y.`
:::leanStatement "DLMF 4.45.E5"
```anchor dlmf_4_45_5 (module := LMLF.Blueprint.Elementary.Section445)
theorem dlmf_4_45_5 (x y : ℝ) (m : ℤ)
    (h : y = x - (m : ℝ) * Real.log 10) :
    Real.exp x = Real.rpow 10 (m : ℝ) * Real.exp y
```
:::
::::

## Real variables: trigonometric functions
%%%
number := false
%%%
::::dlmfEntry "4.45.6–7" "https://dlmf.nist.gov/4.45.i"
Reduction modulo pi places sine and cosine in a bounded interval before
evaluation. The reusable API names the selected index
`trigonometricReductionIndex`, its residual
`trigonometricReductionResidual`, and the bound
`trigonometricReductionRange`.
[DLMF 4.45.E6](https://dlmf.nist.gov/4.45.E6)
$$`\xi=\frac{x}{\pi},\qquad m=\left\lfloor\xi+\frac12\right\rfloor,\qquad \theta=\pi(\xi-m).`
:::leanStatement "DLMF 4.45.E6"
```anchor dlmf_4_45_6 (module := LMLF.Blueprint.Elementary.Section445)
theorem dlmf_4_45_6 (x : ℝ) :
    x = Real.pi * trigonometricReductionIndex x +
      trigonometricReductionResidual x ∧
      trigonometricReductionRange x
```
:::
[DLMF 4.45.E7](https://dlmf.nist.gov/4.45.E7)
$$`\sin x=(-1)^m\sin\theta,\qquad \cos x=(-1)^m\cos\theta.`
:::leanStatement "DLMF 4.45.E7"
```anchor dlmf_4_45_7 (module := LMLF.Blueprint.Elementary.Section445)
theorem dlmf_4_45_7 (x θ : ℝ) (m : ℤ)
    (hθ : θ = Real.pi * (x / Real.pi - m)) :
    Real.sin x = (-1 : ℝ) ^ m * Real.sin θ ∧
    Real.cos x = (-1 : ℝ) ^ m * Real.cos θ
```
:::
::::

## Real variables: inverse trigonometric functions
%%%
number := false
%%%
::::dlmfEntry "4.45.8–14" "https://dlmf.nist.gov/4.45.i"
The corrected arctangent recurrence avoids cancellation; the large-argument
series is summed with its first term exactly once and is used only in its
convergent regime. The worked decimal values below are enclosures, not exact
decimal identities.
[DLMF 4.45.E8](https://dlmf.nist.gov/4.45.E8)
$$`2\arctan\left(\frac{x}{1+\sqrt{1+x^2}}\right)=\arctan x,\qquad 0<x<\infty.`
:::leanStatement "DLMF 4.45.E8"
```anchor dlmf_4_45_8 (module := LMLF.Blueprint.Elementary.Section445)
theorem dlmf_4_45_8 {x : ℝ} (hx : 0 < x) :
    2 * Real.arctan (x / (1 + Real.sqrt (1 + x ^ 2))) = Real.arctan x
```
:::
[DLMF 4.45.E9](https://dlmf.nist.gov/4.45.E9)
$$`x_n=\frac{x_{n-1}}{1+\sqrt{1+x_{n-1}^2}},\qquad n=1,2,\ldots.`
:::leanStatement "DLMF 4.45.E9"
```anchor dlmf_4_45_9 (module := LMLF.Blueprint.Elementary.Section445)
theorem dlmf_4_45_9 (x : ℝ) (n : ℕ) :
    arctanReduction x (n + 1) = arctanReduction x n /
      (1 + Real.sqrt (1 + arctanReduction x n ^ 2))
```
:::
[DLMF 4.45.E10](https://dlmf.nist.gov/4.45.E10)
$$`\arctan x=2^n\arctan x_n.`
:::leanStatement "DLMF 4.45.E10"
```anchor dlmf_4_45_10 (module := LMLF.Blueprint.Elementary.Section445)
theorem dlmf_4_45_10 {x : ℝ} (n : ℕ) :
    Real.arctan x = (2 : ℝ) ^ n * Real.arctan (arctanReduction x n)
```
:::
[DLMF 4.45.E11](https://dlmf.nist.gov/4.45.E11)
$$`\arctan x=\frac{\pi}{2}-\frac{1}{x}+\frac{1}{3x^3}-\frac{1}{5x^5}+\cdots,\qquad x>1.`
:::leanStatement "DLMF 4.45.E11"
```anchor dlmf_4_45_11 (module := LMLF.Blueprint.Elementary.Section445)
theorem dlmf_4_45_11 {x : ℝ} (hx : 1 < x) :
    Tendsto (fun N : ℕ => Real.pi / 2 -
      Finset.sum (Finset.range N) (fun k => (-1 : ℝ) ^ k /
        ((2 * k + 1 : ℕ) : ℝ) / x ^ (2 * k + 1)))
      atTop (𝓝 (Real.arctan x))
```
:::
[DLMF 4.45.E12](https://dlmf.nist.gov/4.45.E12)
$$`x=9.47376,\qquad x_1\approx0.90000,\quad x_2\approx0.38373,\quad x_3\approx0.18528,\quad x_4\approx0.09185.`
:::leanStatement "DLMF 4.45.E12"
```anchor dlmf_4_45_12 (module := LMLF.Blueprint.Elementary.Section445)
theorem dlmf_4_45_12 :
    let x : ℝ := 9.47376
    |arctanReduction x 1 - 0.90000| < 1 / 100000 ∧
      |arctanReduction x 2 - 0.38373| < 1 / 100000 ∧
      |arctanReduction x 3 - 0.18528| < 1 / 100000 ∧
      |arctanReduction x 4 - 0.09185| < 1 / 100000
```
:::
[DLMF 4.45.E13](https://dlmf.nist.gov/4.45.E13)
$$`\arctan(9.47376)=16\arctan x_4=1.46563\ldots.`
:::leanStatement "DLMF 4.45.E13"
```anchor dlmf_4_45_13 (module := LMLF.Blueprint.Elementary.Section445)
theorem dlmf_4_45_13 :
    let x : ℝ := 9.47376
    Real.arctan x = 16 * Real.arctan (arctanReduction x 4) ∧
      |Real.arctan x - 1.46563| < 1 / 100000
```
:::
[DLMF 4.45.E14](https://dlmf.nist.gov/4.45.E14)
$$`\arctan x=1.57079\ldots-0.10555\ldots+0.00039\ldots-\cdots=1.46563\ldots.`
:::leanStatement "DLMF 4.45.E14"
```anchor dlmf_4_45_14 (module := LMLF.Blueprint.Elementary.Section445)
theorem dlmf_4_45_14 :
    let x : ℝ := 9.47376
    ∃ r : ℝ, Real.arctan x = Real.pi / 2 - 1 / x +
      1 / (3 * x ^ 3) - 1 / (5 * x ^ 5) + r ∧ |r| ≤ 1 / (7 * x ^ 7) ∧
      |Real.arctan x - 1.46563| < 1 / 100000
```
:::
::::

## Complex variables and Lambert W
%%%
number := false
%%%
::::dlmfEntry "4.45.15–16" "https://dlmf.nist.gov/4.45.ii"
Complex logarithm and exponential use principal phase and real/imaginary
decomposition; E15 records the phase range explicitly. Lambert W computation
is described in prose below.
[DLMF 4.45.E15](https://dlmf.nist.gov/4.45.E15)
$$`\ln z=\ln|z|+i\operatorname{ph}z,\qquad -\pi\leq\operatorname{ph}z\leq\pi.`
:::leanStatement "DLMF 4.45.E15"
```anchor dlmf_4_45_15 (module := LMLF.Blueprint.Elementary.Section445)
theorem dlmf_4_45_15 {z : ℂ} (hz : z ≠ 0) :
    Complex.log z = Real.log ‖z‖ + Complex.I * Complex.arg z ∧
      principalPhaseRange z
```
:::
[DLMF 4.45.E16](https://dlmf.nist.gov/4.45.E16)
$$`e^z=e^{\operatorname{Re}z}\left(\cos(\operatorname{Im}z)+i\sin(\operatorname{Im}z)\right).`
:::leanStatement "DLMF 4.45.E16"
```anchor dlmf_4_45_16 (module := LMLF.Blueprint.Elementary.Section445)
theorem dlmf_4_45_16 (z : ℂ) :
    Complex.exp z = Real.exp z.re *
      (Real.cos z.im + Complex.I * Real.sin z.im)
```
:::
::::

## Computational context
%%%
number := false
%%%

The logarithm section begins with 1/10 ≤ x ≤ 10, repeatedly takes square roots
until the reduced y is small, and then restores the scale. Other positive
arguments are written as 10^m ξ with 1/10 ≤ ξ ≤ 10. Exponential evaluation
uses m = floor(x/ln 10 + 1/2), y = x − m ln 10, and e^x = 10^m e^y.
These are stable-range transformations, not additional convergence claims.

Trigonometric evaluation first computes ξ=x/π, rounds to m=floor(ξ+1/2),
and evaluates θ=π(ξ−m), where |θ|≤π/2. The remaining trigonometric
functions follow from the definitions cited by DLMF.

For inverse trigonometric functions, the source uses the corrected substitution
in E8 and recurrence E9 until the iterate is small, then applies E10. For
large positive x, E11 is a convergent alternating expansion; E12–E14 record
the source's worked x=9.47376 example and its recurrence/asymptotic check.
The explicit remainder bound and decimal enclosure in E14 are a rigorous
quantitative rendering of that check, marked separately from E11.

Hyperbolic functions are computed directly from §4.28. The inverse
hyperbolic functions use the logarithmic forms of §4.37, and reciprocal
inverse functions use the corresponding §4.37 formulas. Other numerical
methods cited by DLMF include Luther, Ziv, Cody and Waite, Rosenberg and
McNamee, Carlson, interval arithmetic, and Shift-and-Add/CORDIC references.

For complex variables, DLMF computes ln z and e^z from E15–E16, then refers
to the logarithmic forms for trigonometric and hyperbolic functions. The
principal phase satisfies −π≤ph z≤π.

In the Lambert W subsection, W₀(x) on the interval from -1/e through infinity
is computed by solving W e^W=x, for example by Newton iteration. Initial approximations come from
the power series near −1/e, the asymptotic expansion for large x, or numerical
integration of the differential equation elsewhere. The W₋₁ branch is treated
on the interval from -1/e up to but excluding 0, with the corresponding nonpositive parameter regime. The
subsection's version-1.2.2 editorial modification replaced the older Wp/Wm
labels by W₀/W₋₁.

::::dlmfEntry "Logarithm scaling" "https://dlmf.nist.gov/4.45#Px1.p1"
The logarithm can be computed from its ascending power series after preliminary
scaling. For `1/10 ≤ x ≤ 10`, repeated square roots make the reduced argument
`y` sufficiently small.
::::
::::dlmfEntry "Logarithm series step" "https://dlmf.nist.gov/4.45#Px1.p2"
After E1, compute `ln(1+y)` from the ascending series in DLMF §4.6 and restore
the scale using E2.
::::
::::dlmfEntry "Decimal logarithm rescaling" "https://dlmf.nist.gov/4.45#Px2.p1"
For other positive arguments write `x = 10^m ξ`, with integer `m` and
`1/10 ≤ ξ ≤ 10`, then use E3.
::::
::::dlmfEntry "Trigonometric reduction" "https://dlmf.nist.gov/4.45#Px3.p1"
For any real `x`, first compute `ξ = x/π`, choose
`m = floor(ξ+1/2)`, and form `θ = π(ξ-m)` as in E6.
::::
::::dlmfEntry "Bounded trigonometric evaluation" "https://dlmf.nist.gov/4.45#Px3.p2"
The reduced angle satisfies `|θ| ≤ π/2`; sine and cosine can then be computed
from the series in §4.19, while the other trigonometric functions follow from
their definitions.
::::
::::dlmfEntry "Arctangent computation" "https://dlmf.nist.gov/4.45#Px4.p1"
The arctangent is computed from its ascending power series after preliminary
transformations reduce the size of the real argument.
::::
::::dlmfEntry "E8 editorial correction" "https://dlmf.nist.gov/4.45#E8.info@editorial-change-note-1"
The current E8 substitution replaced the original formula effective with
DLMF version 1.0.7 because it gives a better numerical recurrence.
::::
::::dlmfEntry "E9 editorial correction" "https://dlmf.nist.gov/4.45#E9.info@editorial-change-note-1"
The current E9 recurrence replaced the original cancellation-prone recurrence
effective with DLMF version 1.0.7.
::::
::::dlmfEntry "Small arctangent iterate" "https://dlmf.nist.gov/4.45#Px4.p2"
Iterate E9 until the argument is sufficiently small, evaluate that final
arctangent using §4.24, and then restore the original value with E10.
::::
::::dlmfEntry "Large-argument arctangent series" "https://dlmf.nist.gov/4.45#Px4.p3"
For large positive `x`, a second method sums the alternating inverse-power
series displayed in E11.
::::
::::dlmfEntry "Worked arctangent example" "https://dlmf.nist.gov/4.45#Px4.p4"
The worked example takes `x = 9.47376` and records the four reduced iterates
shown in E12, here represented by explicit decimal enclosures.
::::
::::dlmfEntry "Arctangent recurrence check" "https://dlmf.nist.gov/4.45#Px4.p5"
The §4.24 small-argument evaluation gives `arctan x₄ = 0.09160...`; E10 then
produces the value recorded in E13.
::::
::::dlmfEntry "Arctangent asymptotic check" "https://dlmf.nist.gov/4.45#Px4.p6"
E14 checks the same value using the alternating asymptotic expansion. The
formal E14 declaration supplies a rigorous remainder bound and a decimal
enclosure for the source's ellipses.
::::
::::dlmfEntry "Other inverse trigonometric functions" "https://dlmf.nist.gov/4.45#Px5.p1"
The remaining inverse trigonometric functions can be computed using the
interrelations in the fourth row of Table 4.16.3; for example,
`arcsin x = arctan(x (1-x²)^(-1/2))` on its real domain.
::::
::::dlmfEntry "Hyperbolic computation" "https://dlmf.nist.gov/4.45#Px6.p1"
Hyperbolic functions use their definitions in §4.28. Inverse hyperbolic
functions use the logarithmic forms in §4.37, including the reciprocal inverse
functions.
::::
::::dlmfEntry "Complex logarithm and exponential" "https://dlmf.nist.gov/4.45#ii.p1"
For complex variables, compute `ln z` and `e^z` from E15 and E16; the phase in
E15 is the principal one with `-π ≤ ph z ≤ π`.
::::
::::dlmfEntry "Complex trigonometric methods" "https://dlmf.nist.gov/4.45#ii.p2"
Complex trigonometric functions use their definitions in §4.14, followed by
the logarithmic forms in §4.23; the same strategy applies to hyperbolic and
inverse hyperbolic functions using §§4.28 and 4.37.
::::
::::dlmfEntry "Complex numerical reference" "https://dlmf.nist.gov/4.45#ii.p3"
For another complex-variable method, DLMF refers to Miel (1981).
::::
::::dlmfEntry "Lambert W branch-label correction" "https://dlmf.nist.gov/4.45#iii.info@editorial-change-note-1"
Effective with DLMF version 1.2.2, the Lambert W subsection uses `W₀` and
`W₋₁` in place of the older `Wp` and `Wm` labels.
::::
::::dlmfEntry "Principal Lambert W computation" "https://dlmf.nist.gov/4.45#iii.p1"
For `x ∈ [-1/e,∞)`, compute the principal branch `W₀(x)` by solving
`W exp W = x`, for example by Newton iteration. Initial approximations may
come from the power series near `-1/e`, the large-argument asymptotic, or
numerical integration of the differential equation.
::::
::::dlmfEntry "Lower Lambert W computation" "https://dlmf.nist.gov/4.45#iii.p2"
The lower branch `W₋₁(x)` is treated on `[-1/e,0)`, with the nonpositive
parameter regime in the corresponding initial approximation.
::::
::::dlmfEntry "Lambert W references" "https://dlmf.nist.gov/4.45#iii.p3"
DLMF also cites Barry et al. (1995b) and Chapeau-Blondeau and Monir (2002)
for Lambert W computation methods.
::::
