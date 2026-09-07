import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section48
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.8 Identities" =>
%%%
tag := "chapter-4-section-8"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.8"
Source: NIST Digital Library of Mathematical Functions, §4.8.
:::

# §4.8 Identities
%%%
number := false
%%%

DLMF §4.8 gives identities for logarithms, exponentials, and powers. The formal
statements use real-positive or real-variable specializations when that makes the
complex branch convention explicit.

## §4.8(i) Logarithms
%%%
number := false
%%%

::::dlmfEntry "4.8.1" "https://dlmf.nist.gov/4.8.E1"
$$`\mathrm{Ln}(z_1z_2)=\mathrm{Ln}z_1+\mathrm{Ln}z_2.`
For nonzero real arguments this is the real logarithm product law.
:::leanStatement "Lean · logarithm product"
```anchor log_mul (module := LMLF.Blueprint.Elementary.Section48) -showProofStates
theorem log_mul {x y : ℝ} (hx : x ≠ 0) (hy : y ≠ 0) :
    Real.log (x * y) = Real.log x + Real.log y
```
:::
::::

::::dlmfEntry "4.8.2" "https://dlmf.nist.gov/4.8.E2"
$$`\ln(z_1z_2)=\ln z_1+\ln z_2,\quad-\pi\leq\operatorname{ph}z_1+\operatorname{ph}z_2\leq\pi.`
Positive real arguments have zero phase, so the principal condition is automatic.
:::leanStatement "Lean · principal logarithm product"
```anchor principal_log_mul (module := LMLF.Blueprint.Elementary.Section48) -showProofStates
theorem principal_log_mul {x y : ℝ} (hx : 0 < x) (hy : 0 < y) :
    Real.log (x * y) = Real.log x + Real.log y
```
:::
::::

::::dlmfEntry "4.8.3" "https://dlmf.nist.gov/4.8.E3"
$$`\mathrm{Ln}(z_1/z_2)=\mathrm{Ln}z_1-\mathrm{Ln}z_2.`
For nonzero real arguments this is the real logarithm quotient law.
:::leanStatement "Lean · logarithm quotient"
```anchor log_div (module := LMLF.Blueprint.Elementary.Section48) -showProofStates
theorem log_div {x y : ℝ} (hx : x ≠ 0) (hy : y ≠ 0) :
    Real.log (x / y) = Real.log x - Real.log y
```
:::
::::

::::dlmfEntry "4.8.4" "https://dlmf.nist.gov/4.8.E4"
$$`\ln(z_1/z_2)=\ln z_1-\ln z_2,\quad-\pi\leq\operatorname{ph}z_1-\operatorname{ph}z_2\leq\pi.`
Positive real arguments have zero phase in this principal specialization.
:::leanStatement "Lean · principal logarithm quotient"
```anchor principal_log_div (module := LMLF.Blueprint.Elementary.Section48) -showProofStates
theorem principal_log_div {x y : ℝ} (hx : 0 < x) (hy : 0 < y) :
    Real.log (x / y) = Real.log x - Real.log y
```
:::
::::

::::dlmfEntry "4.8.5" "https://dlmf.nist.gov/4.8.E5"
$$`\mathrm{Ln}(z^n)=n\,\mathrm{Ln}z,\quad n\in\mathbb Z.`
The integer exponent is represented by the real integer-power operation.
:::leanStatement "Lean · integer power logarithm"
```anchor log_zpow (module := LMLF.Blueprint.Elementary.Section48) -showProofStates
theorem log_zpow (x : ℝ) (n : ℤ) :
    Real.log (x ^ n) = (n : ℝ) * Real.log x
```
:::
::::

::::dlmfEntry "4.8.6" "https://dlmf.nist.gov/4.8.E6"
$$`\ln(z^n)=n\,\ln z,\quad n\in\mathbb Z,\quad-\pi\leq n\operatorname{ph}z\leq\pi.`
For a positive real base the phase condition is automatic.
:::leanStatement "Lean · principal integer power logarithm"
```anchor principal_log_zpow (module := LMLF.Blueprint.Elementary.Section48) -showProofStates
theorem principal_log_zpow {x : ℝ} (hx : 0 < x) (n : ℤ) :
    Real.log (x ^ n) = (n : ℝ) * Real.log x
```
:::
::::

::::dlmfEntry "4.8.7" "https://dlmf.nist.gov/4.8.E7"
$$`\ln(1/z)=-\ln z,\quad|\operatorname{ph}z|\leq\pi.`
For positive real arguments the principal phase condition is automatic.
:::leanStatement "Lean · reciprocal logarithm"
```anchor log_inv (module := LMLF.Blueprint.Elementary.Section48) -showProofStates
theorem log_inv {x : ℝ} (hx : 0 < x) :
    Real.log (1 / x) = -Real.log x
```
:::
::::

::::dlmfEntry "4.8.8" "https://dlmf.nist.gov/4.8.E8"
$$`\mathrm{Ln}(\exp z)=z+2k\pi\mathrm{i},\quad k\in\mathbb Z.`
The existential integer records the branch ambiguity of the complex logarithm.
:::leanStatement "Lean · logarithm exponential branch"
```anchor log_exp_branch (module := LMLF.Blueprint.Elementary.Section48) -showProofStates
theorem log_exp_branch (z : ℂ) :
    ∃ k : ℤ,
      Complex.log (Complex.exp z) = z + (2 * (k : ℂ) * Real.pi) * Complex.I
```
:::
::::

::::dlmfEntry "4.8.9" "https://dlmf.nist.gov/4.8.E9"
$$`\ln(\exp z)=z,\quad-\pi\leq\Im z\leq\pi.`
Mathlib's principal branch uses a strict lower boundary in the formal hypothesis.
:::leanStatement "Lean · principal logarithm exponential"
```anchor principal_log_exp (module := LMLF.Blueprint.Elementary.Section48) -showProofStates
theorem principal_log_exp {z : ℂ} (h₁ : -Real.pi < z.im) (h₂ : z.im ≤ Real.pi) :
    Complex.log (Complex.exp z) = z
```
:::
::::

::::dlmfEntry "4.8.10" "https://dlmf.nist.gov/4.8.E10"
$$`\exp(\ln z)=\exp(\mathrm{Ln}z)=z.`
For every nonzero complex argument, exponentiating its principal logarithm recovers it.
:::leanStatement "Lean · exponential logarithm"
```anchor exp_log (module := LMLF.Blueprint.Elementary.Section48) -showProofStates
theorem exp_log {z : ℂ} (hz : z ≠ 0) :
    Complex.exp (Complex.log z) = z
```
:::
::::

::::dlmfEntry "4.8.11" "https://dlmf.nist.gov/4.8.E11"
$$`\mathrm{Ln}(a^z)=z\,\mathrm{Ln}a+2k\pi\mathrm{i},\quad a\ne0.`
For positive real base and real exponent there is no branch ambiguity.
:::leanStatement "Lean · logarithm real power"
```anchor log_rpow_general_branch (module := LMLF.Blueprint.Elementary.Section48) -showProofStates
theorem log_rpow_general_branch {a x : ℝ} (ha : 0 < a) :
    Real.log (a ^ x) = x * Real.log a
```
:::
::::

::::dlmfEntry "4.8.12" "https://dlmf.nist.gov/4.8.E12"
$$`\ln(a^z)=z\,\ln a+2k\pi\mathrm{i},\quad a\ne0.`
The positive-real principal specialization removes the branch integer.
:::leanStatement "Lean · principal logarithm real power"
```anchor principal_log_rpow (module := LMLF.Blueprint.Elementary.Section48) -showProofStates
theorem principal_log_rpow {a x : ℝ} (ha : 0 < a) :
    Real.log (a ^ x) = x * Real.log a
```
:::
::::

::::dlmfEntry "4.8.13" "https://dlmf.nist.gov/4.8.E13"
$$`\ln(a^x)=x\ln a,\quad a>0.`
This is the source's real-variable identity in its natural positive-base form.
:::leanStatement "Lean · real logarithm positive power"
```anchor log_rpow (module := LMLF.Blueprint.Elementary.Section48) -showProofStates
theorem log_rpow {a x : ℝ} (ha : 0 < a) :
    Real.log (a ^ x) = x * Real.log a
```
:::
::::

## §4.8(ii) Powers
%%%
number := false
%%%

::::dlmfEntry "4.8.14" "https://dlmf.nist.gov/4.8.E14"
$$`a^{z_1}a^{z_2}=a^{z_1+z_2},\quad a\ne0.`
For positive real base and real exponents, this is the real power addition law.
:::leanStatement "Lean · common-base powers"
```anchor rpow_add (module := LMLF.Blueprint.Elementary.Section48) -showProofStates
theorem rpow_add {a x y : ℝ} (ha : 0 < a) :
    a ^ x * a ^ y = a ^ (x + y)
```
:::
::::

::::dlmfEntry "4.8.15" "https://dlmf.nist.gov/4.8.E15"
$$`a^z b^z=(ab)^z,\quad-\pi\leq\operatorname{ph}a+\operatorname{ph}b\leq\pi.`
Positive real bases have zero phase, so the branch condition is automatic.
:::leanStatement "Lean · two-base powers"
```anchor mul_rpow (module := LMLF.Blueprint.Elementary.Section48) -showProofStates
theorem mul_rpow {a b x : ℝ} (ha : 0 < a) (hb : 0 < b) :
    a ^ x * b ^ x = (a * b) ^ x
```
:::
::::

::::dlmfEntry "4.8.16" "https://dlmf.nist.gov/4.8.E16"
$$`\mathrm e^{z_1}\mathrm e^{z_2}=\mathrm e^{z_1+z_2}.`
The real-variable statement is the real slice of the complex identity.
:::leanStatement "Lean · exponential addition"
```anchor exp_add (module := LMLF.Blueprint.Elementary.Section48) -showProofStates
theorem exp_add (x y : ℝ) :
    Real.exp x * Real.exp y = Real.exp (x + y)
```
:::
::::

::::dlmfEntry "4.8.17" "https://dlmf.nist.gov/4.8.E17"
$$`(\mathrm e^{z_1})^{z_2}=\mathrm e^{z_1z_2},\quad-\pi\leq\Im z_1\leq\pi.`
For real variables the imaginary-part restriction is automatic, and the principal
power is the real power of a positive exponential.
:::leanStatement "Lean · power of an exponential"
```anchor exp_rpow (module := LMLF.Blueprint.Elementary.Section48) -showProofStates
theorem exp_rpow (x y : ℝ) :
    (Real.exp x) ^ y = Real.exp (x * y)
```
:::
::::
