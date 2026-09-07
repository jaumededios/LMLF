import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section421
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.21 Definitions and Elementary Properties" =>
%%%
tag := "chapter-4-section-21"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.21"
Source: NIST Digital Library of Mathematical Functions, §4.21.
:::

# §4.21 Definitions and Elementary Properties
%%%
number := false
%%%

This page records the elementary trigonometric identities in their complex
form.  Unless real coordinates are displayed explicitly, `z`, `u`, and `v` are
complex.  Quotient identities state the corresponding denominator exclusions;
this matters because Lean's division is totalized, while the DLMF formulas are
identities on their analytic domains.  The half-angle square-root displays are
branch-sensitive: the formal existential statements retain the square relation
without silently choosing a sign.  Product, multiple-angle, De Moivre, and
real/imaginary-coordinate formulas are all recorded with the source indexing
and equivalent components intact.
Every quotient theorem below also excludes the poles of its input and output
trigonometric functions, so its hypotheses describe an honest meromorphic
chart rather than a totalized division artifact.

::::dlmfEntry "4.21.1" "https://dlmf.nist.gov/4.21.E1"
$$`\sin u\mathbin{\pm}\cos u=\sqrt2\sin(u\mathbin{\pm}\pi/4).`$$

Quarter-period translation gives both signs at once.

:::leanStatement "Quarter-period sine identities"
```anchor dlmf_4_21_E1 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E1 (u : ℂ) :
    Complex.sin u + Complex.cos u = Complex.sqrt 2 * Complex.sin (u + Real.pi / 4) ∧
    Complex.sin u - Complex.cos u = Complex.sqrt 2 * Complex.sin (u - Real.pi / 4) ∧
    Complex.sin u + Complex.cos u = Complex.sqrt 2 * Complex.cos (u - Real.pi / 4) ∧
    Complex.sin u - Complex.cos u = -Complex.sqrt 2 * Complex.cos (u + Real.pi / 4) := by sorry
```
:::
::::

::::dlmfEntry "4.21.1_5" "https://dlmf.nist.gov/4.21.E1_5"
$$`A\cos u+B\sin u=\sqrt{A^2+B^2}\cos(u-\operatorname{ph}(A+Bi)).`$$

For real coefficients this is the amplitude-phase form; `Complex.arg` supplies
the principal phase used by the formal specialization.

:::leanStatement "Amplitude-phase form"
```anchor dlmf_4_21_E1_5 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E1_5 (A B : ℝ) (u : ℝ) :
    (A : ℂ) * Complex.cos u + (B : ℂ) * Complex.sin u =
      Real.sqrt (A ^ 2 + B ^ 2) * Complex.cos (u - Complex.arg (A + B * Complex.I)) := by sorry
```
:::
::::

::::dlmfEntry "4.21.2" "https://dlmf.nist.gov/4.21.E2"
$$`\sin(u\pm v)=\sin u\cos v\pm\cos u\sin v.`$$
:::leanStatement "Sine addition and subtraction"
```anchor dlmf_4_21_E2 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E2 (u v : ℂ) :
    Complex.sin (u + v) = Complex.sin u * Complex.cos v + Complex.cos u * Complex.sin v ∧
    Complex.sin (u - v) = Complex.sin u * Complex.cos v - Complex.cos u * Complex.sin v := by sorry
```
:::
::::

::::dlmfEntry "4.21.3" "https://dlmf.nist.gov/4.21.E3"
$$`\cos(u\pm v)=\cos u\cos v\mp\sin u\sin v.`$$
:::leanStatement "Cosine addition and subtraction"
```anchor dlmf_4_21_E3 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E3 (u v : ℂ) :
    Complex.cos (u + v) = Complex.cos u * Complex.cos v - Complex.sin u * Complex.sin v ∧
    Complex.cos (u - v) = Complex.cos u * Complex.cos v + Complex.sin u * Complex.sin v := by sorry
```
:::
::::

::::dlmfEntry "4.21.4" "https://dlmf.nist.gov/4.21.E4"
$$`\tan(u\pm v)=\frac{\tan u\pm\tan v}{1\mp\tan u\tan v}.`$$
The two denominator hypotheses identify the analytic domains of the quotients.
:::leanStatement "Tangent addition and subtraction"
```anchor dlmf_4_21_E4 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E4 (u v : ℂ)
    (hcosu : Complex.cos u ≠ 0) (hcosv : Complex.cos v ≠ 0)
    (hcosAdd : Complex.cos (u + v) ≠ 0) (hcosSub : Complex.cos (u - v) ≠ 0)
    (hplus : 1 - Complex.tan u * Complex.tan v ≠ 0)
    (hminus : 1 + Complex.tan u * Complex.tan v ≠ 0) :
    Complex.tan (u + v) = (Complex.tan u + Complex.tan v) / (1 - Complex.tan u * Complex.tan v) ∧
    Complex.tan (u - v) = (Complex.tan u - Complex.tan v) / (1 + Complex.tan u * Complex.tan v) := by sorry
```
:::
::::

::::dlmfEntry "4.21.5" "https://dlmf.nist.gov/4.21.E5"
$$`\cot(u\pm v)=\frac{\cot u\cot v-1}{\cot u\pm\cot v}`$$
The cotangent forms likewise retain both denominator exclusions.
:::leanStatement "Cotangent addition and subtraction"
```anchor dlmf_4_21_E5 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E5 (u v : ℂ)
    (hsinu : Complex.sin u ≠ 0) (hsinv : Complex.sin v ≠ 0)
    (hsinAdd : Complex.sin (u + v) ≠ 0) (hsinSub : Complex.sin (u - v) ≠ 0)
    (hplus : Complex.cot u + Complex.cot v ≠ 0)
    (hminus : Complex.cot u - Complex.cot v ≠ 0) :
    Complex.cot (u + v) = (Complex.cot u * Complex.cot v - 1) / (Complex.cot u + Complex.cot v) ∧
    Complex.cot (u - v) = (-Complex.cot u * Complex.cot v - 1) / (Complex.cot u - Complex.cot v) := by sorry
```
:::
::::

::::dlmfEntry "4.21.6–4.21.11" "https://dlmf.nist.gov/4.21.E6"
The sum-to-product and quotient identities below preserve the signs and
argument order of displays 4.21.6–4.21.11.
:::leanStatement "Sum, difference, and quotient identities"
The individual source displays are [4.21.E6](https://dlmf.nist.gov/4.21.E6),
[4.21.E7](https://dlmf.nist.gov/4.21.E7),
[4.21.E8](https://dlmf.nist.gov/4.21.E8),
[4.21.E9](https://dlmf.nist.gov/4.21.E9),
[4.21.E10](https://dlmf.nist.gov/4.21.E10), and
[4.21.E11](https://dlmf.nist.gov/4.21.E11).
```anchor dlmf_4_21_E6 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E6 (u v : ℂ) :
    Complex.sin u + Complex.sin v = 2 * Complex.sin ((u + v) / 2) * Complex.cos ((u - v) / 2) := by sorry
```
```anchor dlmf_4_21_E7 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E7 (u v : ℂ) :
    Complex.sin u - Complex.sin v = 2 * Complex.cos ((u + v) / 2) * Complex.sin ((u - v) / 2) := by sorry
```
```anchor dlmf_4_21_E8 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E8 (u v : ℂ) :
    Complex.cos u + Complex.cos v = 2 * Complex.cos ((u + v) / 2) * Complex.cos ((u - v) / 2) := by sorry
```
```anchor dlmf_4_21_E9 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E9 (u v : ℂ) :
    Complex.cos u - Complex.cos v = -2 * Complex.sin ((u + v) / 2) * Complex.sin ((u - v) / 2) := by sorry
```
```anchor dlmf_4_21_E10 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E10 (u v : ℂ)
    (hcosu : Complex.cos u ≠ 0) (hcosv : Complex.cos v ≠ 0) :
    Complex.tan u + Complex.tan v = Complex.sin (u + v) / (Complex.cos u * Complex.cos v) ∧
    Complex.tan u - Complex.tan v = Complex.sin (u - v) / (Complex.cos u * Complex.cos v) := by sorry
```
```anchor dlmf_4_21_E11 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E11 (u v : ℂ)
    (hsinu : Complex.sin u ≠ 0) (hsinv : Complex.sin v ≠ 0) :
    Complex.cot u + Complex.cot v = Complex.sin (v + u) / (Complex.sin u * Complex.sin v) ∧
    Complex.cot u - Complex.cot v = Complex.sin (v - u) / (Complex.sin u * Complex.sin v) := by sorry
```
:::
::::

::::dlmfEntry "4.21.12–4.21.20" "https://dlmf.nist.gov/4.21.E12"
The Pythagorean, reciprocal, product-to-sum, and square-difference displays
are grouped here; each equivalent component is retained in the declarations.
:::leanStatement "Pythagorean and product identities"
The individual source displays are [4.21.E12](https://dlmf.nist.gov/4.21.E12),
[4.21.E13](https://dlmf.nist.gov/4.21.E13),
[4.21.E14](https://dlmf.nist.gov/4.21.E14),
[4.21.E15](https://dlmf.nist.gov/4.21.E15),
[4.21.E16](https://dlmf.nist.gov/4.21.E16),
[4.21.E17](https://dlmf.nist.gov/4.21.E17),
[4.21.E18](https://dlmf.nist.gov/4.21.E18),
[4.21.E19](https://dlmf.nist.gov/4.21.E19), and
[4.21.E20](https://dlmf.nist.gov/4.21.E20).
```anchor dlmf_4_21_E12 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E12 (z : ℂ) : Complex.sin z ^ 2 + Complex.cos z ^ 2 = 1 := by sorry
```
```anchor dlmf_4_21_E13 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E13 (z : ℂ) (hcos : Complex.cos z ≠ 0) :
    (1 / Complex.cos z) ^ 2 = 1 + Complex.tan z ^ 2 := by sorry
```
```anchor dlmf_4_21_E14 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E14 (z : ℂ) (hsin : Complex.sin z ≠ 0) :
    (1 / Complex.sin z) ^ 2 = 1 + Complex.cot z ^ 2 := by sorry
```
```anchor dlmf_4_21_E15 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E15 (u v : ℂ) : 2 * Complex.sin u * Complex.sin v = Complex.cos (u - v) - Complex.cos (u + v) := by sorry
```
```anchor dlmf_4_21_E16 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E16 (u v : ℂ) : 2 * Complex.cos u * Complex.cos v = Complex.cos (u - v) + Complex.cos (u + v) := by sorry
```
```anchor dlmf_4_21_E17 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E17 (u v : ℂ) : 2 * Complex.sin u * Complex.cos v = Complex.sin (u - v) + Complex.sin (u + v) := by sorry
```
```anchor dlmf_4_21_E18 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E18 (u v : ℂ) : Complex.sin u ^ 2 - Complex.sin v ^ 2 = Complex.sin (u + v) * Complex.sin (u - v) := by sorry
```
```anchor dlmf_4_21_E19 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E19 (u v : ℂ) : Complex.cos u ^ 2 - Complex.cos v ^ 2 = -Complex.sin (u + v) * Complex.sin (u - v) := by sorry
```
```anchor dlmf_4_21_E20 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E20 (u v : ℂ) : Complex.cos u ^ 2 - Complex.sin v ^ 2 = Complex.cos (u + v) * Complex.cos (u - v) := by sorry
```
:::
::::

::::dlmfEntry "4.21.21–4.21.43" "https://dlmf.nist.gov/4.21.E21"
The remaining displays give half-angle branches, parity and multiple-angle
polynomials, De Moivre/product parametrizations, and the real-coordinate
complex formulas. E36 also records the local derivative of the inverse chart
`z = 2 arctan t`, rather than assuming the differential equality as an input.
Their formal declarations are kept together below so that
the indexing and all equivalent forms remain reusable.
:::leanStatement "Half-angle, multiple-angle, and coordinate formulas"
The individual source displays are linked as [4.21.E21](https://dlmf.nist.gov/4.21.E21),
[4.21.E22](https://dlmf.nist.gov/4.21.E22),
[4.21.E23](https://dlmf.nist.gov/4.21.E23), [4.21.E24](https://dlmf.nist.gov/4.21.E24),
[4.21.E25](https://dlmf.nist.gov/4.21.E25), [4.21.E26](https://dlmf.nist.gov/4.21.E26),
[4.21.E27](https://dlmf.nist.gov/4.21.E27), [4.21.E28](https://dlmf.nist.gov/4.21.E28),
[4.21.E29](https://dlmf.nist.gov/4.21.E29), [4.21.E30](https://dlmf.nist.gov/4.21.E30),
[4.21.E31](https://dlmf.nist.gov/4.21.E31), [4.21.E32](https://dlmf.nist.gov/4.21.E32),
[4.21.E33](https://dlmf.nist.gov/4.21.E33), [4.21.E34](https://dlmf.nist.gov/4.21.E34),
[4.21.E35](https://dlmf.nist.gov/4.21.E35), [4.21.E36](https://dlmf.nist.gov/4.21.E36),
[4.21.E37](https://dlmf.nist.gov/4.21.E37), [4.21.E38](https://dlmf.nist.gov/4.21.E38),
[4.21.E39](https://dlmf.nist.gov/4.21.E39), [4.21.E40](https://dlmf.nist.gov/4.21.E40),
[4.21.E41](https://dlmf.nist.gov/4.21.E41), [4.21.E42](https://dlmf.nist.gov/4.21.E42), and
[4.21.E43](https://dlmf.nist.gov/4.21.E43).
For E34 the declaration gives the integer-indexed form.  DLMF also records
the fractional and complex-index continuation on the principal strip
`-π ≤ Re z ≤ π`; that analytic continuation is intentionally documented here
but not conflated with the integer-power Lean statement.
```anchor dlmf_4_21_E21 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E21 (z : ℂ) :
    ∃ ε : ℂ, ε ^ 2 = 1 ∧ Complex.sin (z / 2) = ε * Complex.sqrt ((1 - Complex.cos z) / 2) := by sorry
```
```anchor dlmf_4_21_E22 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E22 (z : ℂ) :
    ∃ ε : ℂ, ε ^ 2 = 1 ∧ Complex.cos (z / 2) = ε * Complex.sqrt ((1 + Complex.cos z) / 2) := by sorry
```
```anchor dlmf_4_21_E23 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E23 (z : ℂ)
    (h : Complex.sin z ≠ 0 ∧ 1 + Complex.cos z ≠ 0 ∧ Complex.cos (z / 2) ≠ 0) :
    (∃ ε : ℂ, ε ^ 2 = 1 ∧ Complex.tan (z / 2) =
      ε * Complex.sqrt ((1 - Complex.cos z) / (1 + Complex.cos z))) ∧
    Complex.tan (z / 2) = (1 - Complex.cos z) / Complex.sin z ∧
      Complex.tan (z / 2) = Complex.sin z / (1 + Complex.cos z) := by sorry
```
```anchor dlmf_4_21_E24 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E24 (z : ℂ) : Complex.sin (-z) = -Complex.sin z := by sorry
```
```anchor dlmf_4_21_E25 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E25 (z : ℂ) : Complex.cos (-z) = Complex.cos z := by sorry
```
```anchor dlmf_4_21_E26 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E26 (z : ℂ) : Complex.tan (-z) = -Complex.tan z := by sorry
```
```anchor dlmf_4_21_E27 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E27 (z : ℂ) (hcos : Complex.cos z ≠ 0)
    (hden : 1 + Complex.tan z ^ 2 ≠ 0) :
    Complex.sin (2 * z) = 2 * Complex.sin z * Complex.cos z ∧
    Complex.sin (2 * z) = 2 * Complex.tan z / (1 + Complex.tan z ^ 2) := by sorry
```
```anchor dlmf_4_21_E28 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E28 (z : ℂ) (hcos : Complex.cos z ≠ 0)
    (hden : 1 + Complex.tan z ^ 2 ≠ 0) :
    Complex.cos (2 * z) = 2 * Complex.cos z ^ 2 - 1 ∧
    Complex.cos (2 * z) = 1 - 2 * Complex.sin z ^ 2 ∧
    Complex.cos (2 * z) = Complex.cos z ^ 2 - Complex.sin z ^ 2 ∧
    Complex.cos (2 * z) = (1 - Complex.tan z ^ 2) / (1 + Complex.tan z ^ 2) := by sorry
```
```anchor dlmf_4_21_E29 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E29 (z : ℂ)
    (hcos : Complex.cos z ≠ 0) (hsin : Complex.sin z ≠ 0)
    (hcos2 : Complex.cos (2 * z) ≠ 0)
    (h₁ : 1 - Complex.tan z ^ 2 ≠ 0)
    (h₂ : Complex.cot z ^ 2 - 1 ≠ 0)
    (h₃ : Complex.cot z - Complex.tan z ≠ 0) :
    Complex.tan (2 * z) = 2 * Complex.tan z / (1 - Complex.tan z ^ 2) ∧
    Complex.tan (2 * z) = 2 * Complex.cot z / (Complex.cot z ^ 2 - 1) ∧
    Complex.tan (2 * z) = 2 / (Complex.cot z - Complex.tan z) := by sorry
```
```anchor dlmf_4_21_E30 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E30 (z : ℂ) : Complex.sin (3 * z) = 3 * Complex.sin z - 4 * Complex.sin z ^ 3 := by sorry
```
```anchor dlmf_4_21_E31 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E31 (z : ℂ) : Complex.cos (3 * z) = -3 * Complex.cos z + 4 * Complex.cos z ^ 3 := by sorry
```
```anchor dlmf_4_21_E32 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E32 (z : ℂ) : Complex.sin (4 * z) = 8 * Complex.cos z ^ 3 * Complex.sin z - 4 * Complex.cos z * Complex.sin z := by sorry
```
```anchor dlmf_4_21_E33 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E33 (z : ℂ) : Complex.cos (4 * z) = 8 * Complex.cos z ^ 4 - 8 * Complex.cos z ^ 2 + 1 := by sorry
```
```anchor dlmf_4_21_E34 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E34 (n : ℤ) (z : ℂ) :
    Complex.cos (n * z) + Complex.I * Complex.sin (n * z) =
      (Complex.cos z + Complex.I * Complex.sin z) ^ n := by sorry
```
```anchor dlmf_4_21_E35 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E35 {n : ℕ} (hn : 1 ≤ n) (z : ℂ) :
    Complex.sin (n * z) = 2 ^ (n - 1) * ∏ k : Fin n, Complex.sin (z + (k : ℂ) * Real.pi / n) := by sorry
```
```anchor dlmf_4_21_E36 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E36 (z t : ℂ) (ht : t = Complex.tan (z / 2))
    (hhalf : Complex.cos (z / 2) ≠ 0) (hden : 1 + t ^ 2 ≠ 0)
    :
    Complex.sin z = 2 * t / (1 + t ^ 2) ∧
      Complex.cos z = (1 - t ^ 2) / (1 + t ^ 2) ∧
      HasDerivAt (fun s : ℂ => 2 * Complex.arctan s)
        (2 / (1 + t ^ 2)) t := by sorry
```
```anchor dlmf_4_21_E37 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E37 (x y : ℝ) :
    Complex.sin ((x : ℂ) + Complex.I * y) =
      Real.sin x * Real.cosh y + Complex.I * (Real.cos x * Real.sinh y) := by sorry
```
```anchor dlmf_4_21_E38 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E38 (x y : ℝ) :
    Complex.cos ((x : ℂ) + Complex.I * y) =
      Real.cos x * Real.cosh y - Complex.I * (Real.sin x * Real.sinh y) := by sorry
```
```anchor dlmf_4_21_E39 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E39 (x y : ℝ) (h : Real.cos (2 * x) + Real.cosh (2 * y) ≠ 0) :
    Complex.tan ((x : ℂ) + Complex.I * y) =
      (Real.sin (2 * x) + Complex.I * Real.sinh (2 * y)) /
        (Real.cos (2 * x) + Real.cosh (2 * y)) := by sorry
```
```anchor dlmf_4_21_E40 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E40 (x y : ℝ) (h : Real.cosh (2 * y) - Real.cos (2 * x) ≠ 0) :
    Complex.cot ((x : ℂ) + Complex.I * y) =
      (Real.sin (2 * x) - Complex.I * Real.sinh (2 * y)) /
        (Real.cosh (2 * y) - Real.cos (2 * x)) := by sorry
```
```anchor dlmf_4_21_E41 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E41 (x y : ℝ) :
    ‖Complex.sin ((x : ℂ) + Complex.I * y)‖ =
      Real.sqrt (Real.sin x ^ 2 + Real.sinh y ^ 2) ∧
    ‖Complex.sin ((x : ℂ) + Complex.I * y)‖ =
      Real.sqrt ((Real.cosh (2 * y) - Real.cos (2 * x)) / 2) := by sorry
```
```anchor dlmf_4_21_E42 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E42 (x y : ℝ) :
    ‖Complex.cos ((x : ℂ) + Complex.I * y)‖ =
      Real.sqrt (Real.cos x ^ 2 + Real.sinh y ^ 2) ∧
    ‖Complex.cos ((x : ℂ) + Complex.I * y)‖ =
      Real.sqrt ((Real.cosh (2 * y) + Real.cos (2 * x)) / 2) := by sorry
```
```anchor dlmf_4_21_E43 (module := LMLF.Blueprint.Elementary.Section421) -showProofStates
theorem dlmf_4_21_E43 (x y : ℝ) (h : Real.cosh (2 * y) + Real.cos (2 * x) ≠ 0) :
    ‖Complex.tan ((x : ℂ) + Complex.I * y)‖ =
      Real.sqrt ((Real.cosh (2 * y) - Real.cos (2 * x)) /
        (Real.cosh (2 * y) + Real.cos (2 * x))) := by sorry
```
:::
::::
