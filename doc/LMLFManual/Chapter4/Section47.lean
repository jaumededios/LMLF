import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section47
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.7 Derivatives and Differential Equations" =>
%%%
tag := "chapter-4-section-7"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.7"
Source: NIST Digital Library of Mathematical Functions, §4.7.
:::

# §4.7 Derivatives and Differential Equations
%%%
number := false
%%%

This section follows the two DLMF subsections: logarithms, then exponentials and
powers.  Complex formulas use Mathlib's principal `Complex.log`, `Complex.exp`,
and `Complex.cpow`; where DLMF discusses an arbitrary branch or a general
solution, the branch, antiderivative, or constants are explicit parameters.

## §4.7(i) Logarithms
%%%
number := false
%%%

::::dlmfEntry "4.7.1" "https://dlmf.nist.gov/4.7.E1"
$$`\frac{d}{dz}\ln z=\frac1z.`$$

For the principal logarithm, the derivative is `1 / z` on Mathlib's slit plane,
which excludes the branch cut and the origin.

:::leanStatement "Principal logarithm derivative"
```anchor dlmf_4_7_1 (module := LMLF.Blueprint.Elementary.Section47) -showProofStates
theorem principalLog_deriv {z : ℂ} (hz : z ∈ Complex.slitPlane) :
    deriv Complex.log z = 1 / z := by sorry
```
:::
::::

::::dlmfEntry "4.7.2" "https://dlmf.nist.gov/4.7.E2"
$$`\frac{d}{dz}\mathrm{Ln}\,z=\frac1z.`$$

Every selected branch of the general logarithm has the same local derivative;
the Lean statement records the branch through its `HasDerivAt` hypothesis.

:::leanStatement "General logarithm derivative"
```anchor dlmf_4_7_2 (module := LMLF.Blueprint.Elementary.Section47) -showProofStates
theorem generalLog_deriv (Ln : ℂ → ℂ) {z : ℂ} (hz : z ≠ 0)
    (hLn : HasDerivAt Ln (1 / z) z) :
    deriv Ln z = 1 / z := by sorry
```
:::
::::

::::dlmfEntry "4.7.3" "https://dlmf.nist.gov/4.7.E3"
$$`\frac{d^n}{dz^n}\ln z=(-1)^{n-1}(n-1)!z^{-n}.`$$

For a positive integer `n`, repeated differentiation gives the displayed
factorial coefficient and negative power.

:::leanStatement "Principal logarithm higher derivative"
```anchor dlmf_4_7_3 (module := LMLF.Blueprint.Elementary.Section47) -showProofStates
theorem principalLog_iteratedDeriv {z : ℂ} (n : ℕ) (hn : 0 < n)
    (hz : z ∈ Complex.slitPlane) :
    iteratedDeriv n Complex.log z =
      (-1 : ℂ) ^ (n - 1) * (n - 1).factorial * z ^ (-n : ℤ) := by sorry
```
:::
::::

::::dlmfEntry "4.7.4" "https://dlmf.nist.gov/4.7.E4"
$$`\frac{d^n}{dz^n}\mathrm{Ln}\,z=(-1)^{n-1}(n-1)!z^{-n}.`$$

The same higher-derivative formula holds for a general branch wherever its
first derivative is `1 / z`; this is a branch-explicit specialization.

:::leanStatement "General logarithm higher derivative"
```anchor dlmf_4_7_4 (module := LMLF.Blueprint.Elementary.Section47) -showProofStates
theorem generalLog_iteratedDeriv (Ln : ℂ → ℂ) (U : Set ℂ) {z : ℂ} (n : ℕ)
    (hUopen : IsOpen U) (hn : 0 < n) (hz : z ∈ U)
    (hLn : ∀ w ∈ U, HasDerivAt Ln (1 / w) w) :
    iteratedDeriv n Ln z = (-1 : ℂ) ^ (n - 1) * (n - 1).factorial * z ^ (-n : ℤ) := by sorry
```
:::
::::

::::dlmfEntry "4.7.5" "https://dlmf.nist.gov/4.7.E5"
$$`\frac{dw}{dz}=\frac{f'(z)}{f(z)}.`$$

For nonvanishing analytic `f`, this is the logarithmic differential equation
applied to a candidate `w` on an explicit domain `U`; the Lean API records the
equation as a reusable `HasDerivAt` predicate rather than asserting it for an
arbitrary function.

:::leanStatement "Logarithmic differential equation"
```anchor dlmf_4_7_5 (module := LMLF.Blueprint.Elementary.Section47) -showProofStates
def logarithmicDifferentialEquation (f w : ℂ → ℂ) (U : Set ℂ) : Prop :=
  ∀ z ∈ U, HasDerivAt w (deriv f z / f z) z
```
:::
::::

::::dlmfEntry "4.7.6" "https://dlmf.nist.gov/4.7.E6"
$$`w(z)=\mathrm{Ln}(f(z))+\text{constant}.`$$

On an open connected domain, if `w` and the chosen logarithm branch of `f` have
the same derivative, their difference is one additive constant.  This is a
local-domain statement, as in DLMF.

:::leanStatement "Logarithmic differential equation solution"
```anchor dlmf_4_7_6 (module := LMLF.Blueprint.Elementary.Section47) -showProofStates
theorem logarithmicSolution (f w Ln : ℂ → ℂ) (U : Set ℂ)
    (hUopen : IsOpen U) (hUconn : IsPreconnected U)
    (hODE : ∀ z ∈ U, HasDerivAt w (deriv f z / f z) z)
    (hLn : ∀ z ∈ U, HasDerivAt (fun u => Ln (f u)) (deriv f z / f z) z) :
    ∃ C : ℂ, ∀ z ∈ U, w z - Ln (f z) = C := by sorry
```
:::
::::

## §4.7(ii) Exponentials and Powers
%%%
number := false
%%%

::::dlmfEntry "4.7.7" "https://dlmf.nist.gov/4.7.E7"
$$`\frac{d}{dz}e^z=e^z.`$$

The complex exponential is its own derivative.

:::leanStatement "Exponential derivative"
```anchor dlmf_4_7_7 (module := LMLF.Blueprint.Elementary.Section47) -showProofStates
theorem exp_deriv (z : ℂ) : deriv Complex.exp z = Complex.exp z := by sorry
```
:::
::::

::::dlmfEntry "4.7.8" "https://dlmf.nist.gov/4.7.E8"
$$`\frac{d}{dz}e^{az}=ae^{az}.`$$

The chain rule inserts the constant multiplier `a`.

:::leanStatement "Scaled exponential derivative"
```anchor dlmf_4_7_8 (module := LMLF.Blueprint.Elementary.Section47) -showProofStates
theorem exp_mul_deriv (a z : ℂ) :
    deriv (fun w : ℂ => Complex.exp (a * w)) z = a * Complex.exp (a * z) := by sorry
```
:::
::::

::::dlmfEntry "4.7.9" "https://dlmf.nist.gov/4.7.E9"
$$`\frac{d}{dz}a^z=a^z\ln a,\qquad a\ne0.`$$

For principal complex powers, the logarithm is the principal `Complex.log`.
DLMF's general-power note replaces it by the branch used to define the power.

:::leanStatement "Principal constant-base power derivative"
```anchor dlmf_4_7_9 (module := LMLF.Blueprint.Elementary.Section47) -showProofStates
theorem cpow_deriv (a z : ℂ) (ha : a ≠ 0) :
    deriv (fun w : ℂ => a ^ w) z = a ^ z * Complex.log a := by sorry
```
:::
::::

::::dlmfEntry "4.7.10" "https://dlmf.nist.gov/4.7.E10"
$$`\frac{d}{dz}z^a=az^{a-1}.`$$

On a domain contained in the principal slit plane, differentiating the fixed
principal branch in the base gives the displayed rule.

:::leanStatement "Variable-base power derivative"
```anchor dlmf_4_7_10 (module := LMLF.Blueprint.Elementary.Section47) -showProofStates
theorem z_cpow_deriv (a : ℂ) (U : Set ℂ) {z : ℂ} (hz : z ∈ U)
    (hU : ∀ w ∈ U, w ∈ Complex.slitPlane) :
    deriv (fun w : ℂ => Complex.exp (a * Complex.log w)) z =
      a * Complex.exp (a * Complex.log z) / z := by sorry
```
:::
::::

::::dlmfEntry "4.7.11" "https://dlmf.nist.gov/4.7.E11"
$$`\frac{d^n}{dz^n}z^a=a(a-1)\cdots(a-n+1)z^{a-n}.`$$

The finite product records the descending factors for the `n`-th derivative on
the same explicit slit-plane branch domain.

:::leanStatement "Variable-base power higher derivative"
```anchor dlmf_4_7_11 (module := LMLF.Blueprint.Elementary.Section47) -showProofStates
theorem z_cpow_iteratedDeriv (a : ℂ) (U : Set ℂ) {z : ℂ} (n : ℕ)
    (hz : z ∈ U) (hU : ∀ w ∈ U, w ∈ Complex.slitPlane) :
    iteratedDeriv n (fun w : ℂ => Complex.exp (a * Complex.log w)) z =
      (∏ k : Fin n, (a - (k : ℂ))) * Complex.exp (a * Complex.log z) / z ^ n := by sorry
```
:::
::::

::::dlmfEntry "4.7.12" "https://dlmf.nist.gov/4.7.E12"
$$`\frac{dw}{dz}=f(z)w.`$$

This is the first-order linear equation whose coefficient is the function `f`.
It is represented as a candidate-solution predicate on a domain `U`.

:::leanStatement "Linear differential equation"
```anchor dlmf_4_7_12 (module := LMLF.Blueprint.Elementary.Section47) -showProofStates
def linearDifferentialEquation (f w : ℂ → ℂ) (U : Set ℂ) : Prop :=
  ∀ z ∈ U, HasDerivAt w (f z * w z) z
```
:::
::::

::::dlmfEntry "4.7.13" "https://dlmf.nist.gov/4.7.E13"
$$`w=\mathrm{exp}\left(\int f(z)\,dz\right)+\text{constant}.`$$

Writing `F' = f`, the complete nonvanishing solution family on an open
connected domain is a constant multiplier `C * exp(F)`, with `C ≠ 0`.

:::leanStatement "Linear equation exponential solution"
```anchor dlmf_4_7_13 (module := LMLF.Blueprint.Elementary.Section47) -showProofStates
theorem linearDifferentialSolution (f F w : ℂ → ℂ) (U : Set ℂ)
    (hUopen : IsOpen U) (hUconn : IsPreconnected U)
    (hF : ∀ z ∈ U, HasDerivAt F (f z) z)
    (hw : ∀ z ∈ U, HasDerivAt w (f z * w z) z)
    (hw0 : ∀ z ∈ U, w z ≠ 0) :
    (∃ C : ℂ, C ≠ 0 ∧ ∀ z ∈ U, w z = C * Complex.exp (F z)) := by sorry
```
:::
::::

::::dlmfEntry "4.7.14" "https://dlmf.nist.gov/4.7.E14"
$$`\frac{d^2w}{dz^2}=aw,\qquad a\ne0.`$$

The constant-coefficient second-order equation uses a nonzero complex constant `a` and
is represented as a candidate predicate with a `HasDerivAt` second derivative.

:::leanStatement "Second-order exponential equation"
```anchor dlmf_4_7_14 (module := LMLF.Blueprint.Elementary.Section47) -showProofStates
def secondOrderExponentialEquation (a : ℂ) (w : ℂ → ℂ) (U : Set ℂ) : Prop :=
  (a ≠ 0) ∧ ∀ z ∈ U, HasDerivAt (deriv w) (a * w z) z
```
:::
::::

::::dlmfEntry "4.7.15" "https://dlmf.nist.gov/4.7.E15"
$$`w=Ae^{\sqrt a z}+Be^{-\sqrt a z}.`$$

For nonzero `a`, with a chosen square-root branch satisfying `(sqrt a)^2 = a`, every solution on
an open connected domain is the linear combination of the two exponential modes,
with constants `A` and `B`.

:::leanStatement "Second-order exponential solution"
```anchor dlmf_4_7_15 (module := LMLF.Blueprint.Elementary.Section47) -showProofStates
theorem secondOrderExponentialSolution (a : ℂ) (w : ℂ → ℂ) (U : Set ℂ)
    (ha : a ≠ 0) (hUopen : IsOpen U) (hUconn : IsPreconnected U)
    (hsq : (Complex.sqrt a) ^ 2 = a)
    (hw : ∀ z ∈ U, HasDerivAt (deriv w) (a * w z) z) :
    (∃ A B : ℂ, ∀ z ∈ U, w z = A * Complex.exp (Complex.sqrt a * z) +
      B * Complex.exp (-Complex.sqrt a * z)) := by sorry
```
:::
::::
