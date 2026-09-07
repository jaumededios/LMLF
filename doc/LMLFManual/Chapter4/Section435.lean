import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section435
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.Elementary.Section435
set_option verso.exampleProject "."

#doc (Manual) "§4.35 Identities" =>
%%%
tag := "chapter-4-section-35"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.35"
Source: NIST Digital Library of Mathematical Functions, §4.35.
:::

# §4.35 Identities
%%%
number := false
%%%

DLMF §4.35 gives the addition, product, multiple-angle, and modulus identities for
the complex hyperbolic functions. Each display below links directly to its
formula-specific DLMF entry. Quotient identities include the nonvanishing
hypotheses needed for ordinary complex division.

The local `complexCoth` definition is a totalized quotient: at a zero of
`Complex.sinh`, Lean's division returns zero rather than an analytic pole.
Accordingly, the coth formulas below explicitly assume the relevant sinh
values are nonzero; outside that domain the definition is only a totalized
convenience, not a claim that coth is analytic there.

:::leanStatement "Shared vocabulary: complex coth"
```anchor complexCoth (module := LMLF.Blueprint.Elementary.Section435)
def complexCoth (z : ℂ) : ℂ := Complex.cosh z / Complex.sinh z
```
:::

::::dlmfEntry "4.35.E1" "https://dlmf.nist.gov/4.35.E1"
Addition of sinh arguments expands both the sum and difference with their signed cross terms.
:::leanStatement "DLMF 4.35.E1"
```anchor dlmf_4_35_1 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_1 (u v : ℂ) :
    Complex.sinh (u + v) = Complex.sinh u * Complex.cosh v + Complex.cosh u * Complex.sinh v ∧
    Complex.sinh (u - v) = Complex.sinh u * Complex.cosh v - Complex.cosh u * Complex.sinh v
```
:::
::::

::::dlmfEntry "4.35.E2" "https://dlmf.nist.gov/4.35.E2"
Addition of cosh arguments gives the corresponding even-function sum and difference forms.
:::leanStatement "DLMF 4.35.E2"
```anchor dlmf_4_35_2 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_2 (u v : ℂ) :
    Complex.cosh (u + v) = Complex.cosh u * Complex.cosh v + Complex.sinh u * Complex.sinh v ∧
    Complex.cosh (u - v) = Complex.cosh u * Complex.cosh v - Complex.sinh u * Complex.sinh v
```
:::
::::

::::dlmfEntry "4.35.E3" "https://dlmf.nist.gov/4.35.E3"
The tanh addition and subtraction quotients require nonzero cosh factors and displayed denominators.
:::leanStatement "DLMF 4.35.E3"
```anchor dlmf_4_35_3 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_3 (u v : ℂ)
    (hu : Complex.cosh u ≠ 0) (hv : Complex.cosh v ≠ 0)
    (hplus : 1 + Complex.tanh u * Complex.tanh v ≠ 0)
    (hminus : 1 - Complex.tanh u * Complex.tanh v ≠ 0) :
    Complex.tanh (u + v) = (Complex.tanh u + Complex.tanh v) /
      (1 + Complex.tanh u * Complex.tanh v) ∧
    Complex.tanh (u - v) = (Complex.tanh u - Complex.tanh v) /
      (1 - Complex.tanh u * Complex.tanh v)
```
:::
::::

::::dlmfEntry "4.35.E4" "https://dlmf.nist.gov/4.35.E4"
The coth addition and subtraction quotients are stated on the pole-free domain of the reciprocal vocabulary.
:::leanStatement "DLMF 4.35.E4"
```anchor dlmf_4_35_4 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_4 (u v : ℂ)
    (hu : Complex.sinh u ≠ 0) (hv : Complex.sinh v ≠ 0)
    (hplus : complexCoth u + complexCoth v ≠ 0)
    (hminus : complexCoth u - complexCoth v ≠ 0) :
    complexCoth (u + v) = (complexCoth u * complexCoth v + 1) /
      (complexCoth u + complexCoth v) ∧
    complexCoth (u - v) = (-complexCoth u * complexCoth v + 1) /
      (complexCoth u - complexCoth v)
```
:::
::::

::::dlmfEntry "4.35.E5" "https://dlmf.nist.gov/4.35.E5"
The sum of two sinh values is the product of sinh and cosh at the half-sum and half-difference.
:::leanStatement "DLMF 4.35.E5"
```anchor dlmf_4_35_5 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_5 (u v : ℂ) :
    Complex.sinh u + Complex.sinh v =
      2 * Complex.sinh ((u + v) / 2) * Complex.cosh ((u - v) / 2)
```
:::
::::

::::dlmfEntry "4.35.E6" "https://dlmf.nist.gov/4.35.E6"
The difference of two sinh values is the complementary cosh–sinh product at half arguments.
:::leanStatement "DLMF 4.35.E6"
```anchor dlmf_4_35_6 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_6 (u v : ℂ) :
    Complex.sinh u - Complex.sinh v =
      2 * Complex.cosh ((u + v) / 2) * Complex.sinh ((u - v) / 2)
```
:::
::::

::::dlmfEntry "4.35.E7" "https://dlmf.nist.gov/4.35.E7"
The sum of two cosh values factors into cosh at the half-sum and half-difference.
:::leanStatement "DLMF 4.35.E7"
```anchor dlmf_4_35_7 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_7 (u v : ℂ) :
    Complex.cosh u + Complex.cosh v =
      2 * Complex.cosh ((u + v) / 2) * Complex.cosh ((u - v) / 2)
```
:::
::::

::::dlmfEntry "4.35.E8" "https://dlmf.nist.gov/4.35.E8"
The difference of two cosh values factors into the corresponding sinh product.
:::leanStatement "DLMF 4.35.E8"
```anchor dlmf_4_35_8 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_8 (u v : ℂ) :
    Complex.cosh u - Complex.cosh v =
      2 * Complex.sinh ((u + v) / 2) * Complex.sinh ((u - v) / 2)
```
:::
::::

::::dlmfEntry "4.35.E9" "https://dlmf.nist.gov/4.35.E9"
The tanh sum and difference are written as sinh quotients under the nonzero cosh hypotheses.
:::leanStatement "DLMF 4.35.E9"
```anchor dlmf_4_35_9 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_9 (u v : ℂ) (hu : Complex.cosh u ≠ 0) (hv : Complex.cosh v ≠ 0) :
    Complex.tanh u + Complex.tanh v =
      Complex.sinh (u + v) / (Complex.cosh u * Complex.cosh v) ∧
    Complex.tanh u - Complex.tanh v =
      Complex.sinh (u - v) / (Complex.cosh u * Complex.cosh v)
```
:::
::::

::::dlmfEntry "4.35.E10" "https://dlmf.nist.gov/4.35.E10"
The coth sum and difference are written as sinh quotients under the nonzero sinh hypotheses.
:::leanStatement "DLMF 4.35.E10"
```anchor dlmf_4_35_10 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_10 (u v : ℂ) (hu : Complex.sinh u ≠ 0) (hv : Complex.sinh v ≠ 0) :
    complexCoth u + complexCoth v =
      Complex.sinh (v + u) / (Complex.sinh u * Complex.sinh v) ∧
    complexCoth u - complexCoth v =
      Complex.sinh (v - u) / (Complex.sinh u * Complex.sinh v)
```
:::
::::

::::dlmfEntry "4.35.E11" "https://dlmf.nist.gov/4.35.E11"
The fundamental hyperbolic Pythagorean identity relates the squared cosh and sinh values.
:::leanStatement "DLMF 4.35.E11"
```anchor dlmf_4_35_11 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_11 (z : ℂ) : Complex.cosh z ^ 2 - Complex.sinh z ^ 2 = 1
```
:::
::::

::::dlmfEntry "4.35.E12" "https://dlmf.nist.gov/4.35.E12"
Taking the reciprocal square of cosh yields the stated identity involving tanh.
:::leanStatement "DLMF 4.35.E12"
```anchor dlmf_4_35_12 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_12 (z : ℂ) (h : Complex.cosh z ≠ 0) :
    (1 / Complex.cosh z) ^ 2 = 1 - Complex.tanh z ^ 2
```
:::
::::

::::dlmfEntry "4.35.E13" "https://dlmf.nist.gov/4.35.E13"
Taking the reciprocal square of sinh yields the corresponding identity involving coth.
:::leanStatement "DLMF 4.35.E13"
```anchor dlmf_4_35_13 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_13 (z : ℂ) (h : Complex.sinh z ≠ 0) :
    (1 / Complex.sinh z) ^ 2 = complexCoth z ^ 2 - 1
```
:::
::::

::::dlmfEntry "4.35.E14" "https://dlmf.nist.gov/4.35.E14"
The product of two sinh values is recovered by subtracting the two cosh addition forms.
:::leanStatement "DLMF 4.35.E14"
```anchor dlmf_4_35_14 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_14 (u v : ℂ) :
    2 * Complex.sinh u * Complex.sinh v =
      Complex.cosh (u + v) - Complex.cosh (u - v)
```
:::
::::

::::dlmfEntry "4.35.E15" "https://dlmf.nist.gov/4.35.E15"
The product of two cosh values is recovered by adding the two cosh addition forms.
:::leanStatement "DLMF 4.35.E15"
```anchor dlmf_4_35_15 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_15 (u v : ℂ) :
    2 * Complex.cosh u * Complex.cosh v =
      Complex.cosh (u + v) + Complex.cosh (u - v)
```
:::
::::

::::dlmfEntry "4.35.E16" "https://dlmf.nist.gov/4.35.E16"
The mixed sinh–cosh product is recovered by adding the two sinh addition forms.
:::leanStatement "DLMF 4.35.E16"
```anchor dlmf_4_35_16 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_16 (u v : ℂ) :
    2 * Complex.sinh u * Complex.cosh v =
      Complex.sinh (u + v) + Complex.sinh (u - v)
```
:::
::::

::::dlmfEntry "4.35.E17" "https://dlmf.nist.gov/4.35.E17"
The difference of squared sinh values factors into sinh at the sum and difference arguments.
:::leanStatement "DLMF 4.35.E17"
```anchor dlmf_4_35_17 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_17 (u v : ℂ) :
    Complex.sinh u ^ 2 - Complex.sinh v ^ 2 =
      Complex.sinh (u + v) * Complex.sinh (u - v)
```
:::
::::

::::dlmfEntry "4.35.E18" "https://dlmf.nist.gov/4.35.E18"
The difference of squared cosh values has the same sum-and-difference factorization.
:::leanStatement "DLMF 4.35.E18"
```anchor dlmf_4_35_18 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_18 (u v : ℂ) :
    Complex.cosh u ^ 2 - Complex.cosh v ^ 2 =
      Complex.sinh (u + v) * Complex.sinh (u - v)
```
:::
::::

::::dlmfEntry "4.35.E19" "https://dlmf.nist.gov/4.35.E19"
The mixed sum of squared sinh and cosh values factors into a product of cosh terms.
:::leanStatement "DLMF 4.35.E19"
```anchor dlmf_4_35_19 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_19 (u v : ℂ) :
    Complex.sinh u ^ 2 + Complex.cosh v ^ 2 =
      Complex.cosh (u + v) * Complex.cosh (u - v)
```
:::
::::

::::dlmfEntry "4.35.E20" "https://dlmf.nist.gov/4.35.E20"
For nonnegative real x, the principal square-root branch gives the half-angle sinh identity.
:::leanStatement "DLMF 4.35.E20"
```anchor dlmf_4_35_20 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_20 {x : ℝ} (hx : 0 ≤ x) :
    Complex.sinh ((x : ℂ) / 2) =
      Complex.sqrt ((Complex.cosh (x : ℂ) - 1) / 2)
```
:::
::::

::::dlmfEntry "4.35.E21" "https://dlmf.nist.gov/4.35.E21"
For nonnegative real x, the principal square-root branch gives the half-angle cosh identity.
:::leanStatement "DLMF 4.35.E21"
```anchor dlmf_4_35_21 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_21 {x : ℝ} (hx : 0 ≤ x) :
    Complex.cosh ((x : ℂ) / 2) =
      Complex.sqrt ((Complex.cosh (x : ℂ) + 1) / 2)
```
:::
::::

::::dlmfEntry "4.35.E22" "https://dlmf.nist.gov/4.35.E22"
For positive real x, the principal half-angle square-root quotient agrees with both rational forms.
:::leanStatement "DLMF 4.35.E22"
```anchor dlmf_4_35_22 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_22 {x : ℝ} (hx : 0 < x) :
    Complex.tanh ((x : ℂ) / 2) =
      Complex.sqrt ((Complex.cosh (x : ℂ) - 1) /
        (Complex.cosh (x : ℂ) + 1)) ∧
    Complex.tanh ((x : ℂ) / 2) =
      (Complex.cosh (x : ℂ) - 1) / Complex.sinh (x : ℂ) ∧
    Complex.tanh ((x : ℂ) / 2) =
      Complex.sinh (x : ℂ) / (Complex.cosh (x : ℂ) + 1)
```
:::
::::

::::dlmfEntry "4.35.E23" "https://dlmf.nist.gov/4.35.E23"
Sinh is odd, giving the sign reversal under negation.
:::leanStatement "DLMF 4.35.E23"
```anchor dlmf_4_35_23 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_23 (z : ℂ) : Complex.sinh (-z) = -Complex.sinh z
```
:::
::::

::::dlmfEntry "4.35.E24" "https://dlmf.nist.gov/4.35.E24"
Cosh is even, so negating the argument leaves it unchanged.
:::leanStatement "DLMF 4.35.E24"
```anchor dlmf_4_35_24 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_24 (z : ℂ) : Complex.cosh (-z) = Complex.cosh z
```
:::
::::

::::dlmfEntry "4.35.E25" "https://dlmf.nist.gov/4.35.E25"
Tanh is odd, with the same totalized complex quotient convention as Mathlib.
:::leanStatement "DLMF 4.35.E25"
```anchor dlmf_4_35_25 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_25 (z : ℂ) : Complex.tanh (-z) = -Complex.tanh z
```
:::
::::

::::dlmfEntry "4.35.E26" "https://dlmf.nist.gov/4.35.E26"
The double-angle sinh identity includes its tanh quotient form under the displayed denominator condition.
:::leanStatement "DLMF 4.35.E26"
```anchor dlmf_4_35_26 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_26 (z : ℂ) (h : 1 - Complex.tanh z ^ 2 ≠ 0) :
    Complex.sinh (2 * z) = 2 * Complex.sinh z * Complex.cosh z ∧
    Complex.sinh (2 * z) = 2 * Complex.tanh z / (1 - Complex.tanh z ^ 2)
```
:::
::::

::::dlmfEntry "4.35.E27" "https://dlmf.nist.gov/4.35.E27"
The three equivalent double-angle cosh forms are valid throughout the complex domain.
:::leanStatement "DLMF 4.35.E27"
```anchor dlmf_4_35_27 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_27 (z : ℂ) :
    Complex.cosh (2 * z) = 2 * Complex.cosh z ^ 2 - 1 ∧
    Complex.cosh (2 * z) = 2 * Complex.sinh z ^ 2 + 1 ∧
    Complex.cosh (2 * z) = Complex.cosh z ^ 2 + Complex.sinh z ^ 2
```
:::
::::

::::dlmfEntry "4.35.E28" "https://dlmf.nist.gov/4.35.E28"
The double-angle tanh quotient requires the displayed nonzero denominator.
:::leanStatement "DLMF 4.35.E28"
```anchor dlmf_4_35_28 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_28 (z : ℂ) (h : 1 + Complex.tanh z ^ 2 ≠ 0) :
    Complex.tanh (2 * z) = 2 * Complex.tanh z / (1 + Complex.tanh z ^ 2)
```
:::
::::

::::dlmfEntry "4.35.E29" "https://dlmf.nist.gov/4.35.E29"
The triple-angle sinh polynomial is expressed in powers of sinh.
:::leanStatement "DLMF 4.35.E29"
```anchor dlmf_4_35_29 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_29 (z : ℂ) :
    Complex.sinh (3 * z) = 3 * Complex.sinh z + 4 * Complex.sinh z ^ 3
```
:::
::::

::::dlmfEntry "4.35.E30" "https://dlmf.nist.gov/4.35.E30"
The triple-angle cosh polynomial is expressed in powers of cosh.
:::leanStatement "DLMF 4.35.E30"
```anchor dlmf_4_35_30 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_30 (z : ℂ) :
    Complex.cosh (3 * z) = -3 * Complex.cosh z + 4 * Complex.cosh z ^ 3
```
:::
::::

::::dlmfEntry "4.35.E31" "https://dlmf.nist.gov/4.35.E31"
The quadruple-angle sinh expansion separates the two cubic mixed terms.
:::leanStatement "DLMF 4.35.E31"
```anchor dlmf_4_35_31 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_31 (z : ℂ) :
    Complex.sinh (4 * z) = 4 * Complex.sinh z ^ 3 * Complex.cosh z +
      4 * Complex.cosh z ^ 3 * Complex.sinh z
```
:::
::::

::::dlmfEntry "4.35.E32" "https://dlmf.nist.gov/4.35.E32"
The quadruple-angle cosh expansion is the symmetric fourth-degree expression.
:::leanStatement "DLMF 4.35.E32"
```anchor dlmf_4_35_32 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_32 (z : ℂ) :
    Complex.cosh (4 * z) = Complex.cosh z ^ 4 + 6 * Complex.sinh z ^ 2 * Complex.cosh z ^ 2 +
      Complex.sinh z ^ 4
```
:::
::::

::::dlmfEntry "4.35.E33" "https://dlmf.nist.gov/4.35.E33"
The integer-multiple formula identifies powers of cosh z plus or minus sinh z.
:::leanStatement "DLMF 4.35.E33"
```anchor dlmf_4_35_33 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_33 (n : ℤ) (z : ℂ) :
    Complex.cosh ((n : ℂ) * z) + Complex.sinh ((n : ℂ) * z) =
      (Complex.cosh z + Complex.sinh z) ^ n ∧
    Complex.cosh ((n : ℂ) * z) - Complex.sinh ((n : ℂ) * z) =
      (Complex.cosh z - Complex.sinh z) ^ n
```
:::
::::

::::dlmfEntry "4.35.E34" "https://dlmf.nist.gov/4.35.E34"
The sinh value on a complex argument is decomposed into its real and imaginary coordinates.
:::leanStatement "DLMF 4.35.E34"
```anchor dlmf_4_35_34 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_34 (x y : ℝ) :
    Complex.sinh ((x : ℂ) + Complex.I * y) =
      Real.sinh x * Real.cos y + Complex.I * (Real.cosh x * Real.sin y)
```
:::
::::

::::dlmfEntry "4.35.E35" "https://dlmf.nist.gov/4.35.E35"
The cosh value on a complex argument is decomposed into its real and imaginary coordinates.
:::leanStatement "DLMF 4.35.E35"
```anchor dlmf_4_35_35 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_35 (x y : ℝ) :
    Complex.cosh ((x : ℂ) + Complex.I * y) =
      Real.cosh x * Real.cos y + Complex.I * (Real.sinh x * Real.sin y)
```
:::
::::

::::dlmfEntry "4.35.E36" "https://dlmf.nist.gov/4.35.E36"
The tanh addition quotient at a doubled argument requires a nonzero cosh denominator.
:::leanStatement "DLMF 4.35.E36"
```anchor dlmf_4_35_36 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_36 (x y : ℝ) (h : Real.cosh (2 * x) + Real.cos (2 * y) ≠ 0) :
    Complex.tanh ((x : ℂ) + Complex.I * y) =
      (Real.sinh (2 * x) + Complex.I * Real.sin (2 * y)) /
        (Real.cosh (2 * x) + Real.cos (2 * y))
```
:::
::::

::::dlmfEntry "4.35.E37" "https://dlmf.nist.gov/4.35.E37"
The coth subtraction quotient at a doubled argument requires a nonzero sinh denominator.
:::leanStatement "DLMF 4.35.E37"
```anchor dlmf_4_35_37 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_37 (x y : ℝ) (h : Real.cosh (2 * x) - Real.cos (2 * y) ≠ 0) :
    complexCoth ((x : ℂ) + Complex.I * y) =
      (Real.sinh (2 * x) - Complex.I * Real.sin (2 * y)) /
        (Real.cosh (2 * x) - Real.cos (2 * y))
```
:::
::::

::::dlmfEntry "4.35.E38" "https://dlmf.nist.gov/4.35.E38"
The modulus of sinh is the square root of the sum of the squared real-coordinate terms.
:::leanStatement "DLMF 4.35.E38"
```anchor dlmf_4_35_38 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_38 (x y : ℝ) :
    ‖Complex.sinh ((x : ℂ) + Complex.I * y)‖ =
      Real.sqrt (Real.sinh x ^ 2 + Real.sin y ^ 2)
```
:::
::::

::::dlmfEntry "4.35.E39" "https://dlmf.nist.gov/4.35.E39"
The modulus of cosh is the square root of the sum of the squared real-coordinate terms.
:::leanStatement "DLMF 4.35.E39"
```anchor dlmf_4_35_39 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_39 (x y : ℝ) :
    ‖Complex.cosh ((x : ℂ) + Complex.I * y)‖ =
      Real.sqrt (Real.sinh x ^ 2 + Real.cos y ^ 2)
```
:::
::::

::::dlmfEntry "4.35.E40" "https://dlmf.nist.gov/4.35.E40"
The modulus of tanh is the square root of the quotient of the corresponding double-angle quantities, under the nonzero cosh condition.
:::leanStatement "DLMF 4.35.E40"
```anchor dlmf_4_35_40 (module := LMLF.Blueprint.Elementary.Section435)
theorem dlmf_4_35_40 (x y : ℝ) (h : Real.cosh (2 * x) + Real.cos (2 * y) ≠ 0) :
    ‖Complex.tanh ((x : ℂ) + Complex.I * y)‖ =
      Real.sqrt ((Real.cosh (2 * x) - Real.cos (2 * y)) /
        (Real.cosh (2 * x) + Real.cos (2 * y)))
```
:::
::::
