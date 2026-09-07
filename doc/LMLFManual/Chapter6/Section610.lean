import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section610
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section610
set_option verso.exampleProject "."

#doc (Manual) "§6.10 Other Series Expansions" =>
%%%
tag := "chapter-6-section-10"
%%%

:::dlmfChapter "https://dlmf.nist.gov/6.10"
Source: NIST Digital Library of Mathematical Functions, §6.10.
:::

# §6.10 Other Series Expansions
%%%
number := false
%%%

The first subsection gives an inverse-factorial expansion for the exponential
integral.  The coefficients are fixed by their initial values and a finite
recurrence.  The second subsection records expansions in spherical and
modified spherical Bessel functions; the real formula for Ei
is stated away from its logarithmic singularity at zero.

The Lean disclosures use the canonical §6.2 relations for E1, Ei, Si, Cin,
and Ein.  The inverse-factorial coefficients are an
executable finite-prefix construction.  Spherical and modified spherical
Bessel functions are represented by normalized families whose initial values
and recurrences identify the DLMF functions; this is the reusable interface
needed because Mathlib does not currently provide these two families as named
maps.

::::dlmfEntry "Inverse-factorial subsection" "https://dlmf.nist.gov/6.10#i.p1"
The inverse-factorial subsection introduces the coefficient family used in
E1--E3; the first three displays below give its expansion, initial values, and
finite recurrence.
::::

::::dlmfEntry "Inverse-factorial source note" "https://dlmf.nist.gov/6.10#i.info"
The source note cites Nielsen (1906a, p. 283).  It also records that the
recurrence in E3 follows from the generating function
`1/(1-ln(1-t)) = Σₖ cₖ tᵏ`, and points to the related result in §6.18(i).
For the more general incomplete-gamma and logarithmic-integral results, the
same source note warns that Nielsen's Formula (3) is incorrect.
::::

::::dlmfEntry "Inverse-factorial generating function" "https://dlmf.nist.gov/6.10#i.p2"
The generating-function specification fixes the same coefficients used by the
executable finite-prefix construction, so the recurrence is not an arbitrary
sequence assumption.
::::

::::dlmfEntry "Inverse-factorial expansion" "https://dlmf.nist.gov/6.10.E1"
For complex z with positive real part, the inverse-factorial series is

$$`\operatorname{E}_{1}(z)=e^{-z}\left(\frac{c_{0}}{z}+\frac{c_{1}}{z(z+1)}+\frac{2!c_{2}}{z(z+1)(z+2)}+\frac{3!c_{3}}{z(z+1)(z+2)(z+3)}+\cdots\right).`$$

:::leanStatement "6.10.E1 inverse-factorial expansion"
```anchor dlmf_6_10_1 (module := LMLF.Blueprint.ExponentialIntegrals.Section610)
theorem dlmf_6_10_1 (z : ℂ) (hz : 0 < z.re) :
    HasSum (inverseFactorialTerm z)
      (Complex.exp z *
        LMLF.Blueprint.ExponentialIntegrals.Section62.principalE1 z)
```
:::
::::

The coefficient stream is executable: `inverseFactorialPrefix (n + 1)` stores
the first (n+1) coefficients, and `inverseFactorialCoeff n` reads its last
entry.  The next entry is computed by the finite sum in the recurrence, so
the API does not quantify over an arbitrary sequence.

:::leanStatement "6.10 coefficient prefix algorithm"
```anchor inverseFactorialPrefix (module := LMLF.Blueprint.ExponentialIntegrals.Section610)
def inverseFactorialPrefix : ℕ → List ℂ
  | 0 => []
  | 1 => [1]
  | n + 2 =>
      let xs := inverseFactorialPrefix (n + 1)
      xs ++ [inverseFactorialNext xs]
```
:::

:::leanStatement "6.10 coefficient map"
```anchor inverseFactorialCoeff (module := LMLF.Blueprint.ExponentialIntegrals.Section610)
def inverseFactorialCoeff (n : ℕ) : ℂ :=
  ((inverseFactorialPrefix (n + 1))[n]?).getD 0
```
:::

::::dlmfEntry "Initial inverse-factorial coefficients" "https://dlmf.nist.gov/6.10.E2"
The first coefficients are

$$`c_{0}=1,\qquad c_{1}=-1,\qquad c_{2}=\frac{1}{2},\qquad c_{3}=-\frac{1}{3},\qquad c_{4}=\frac{1}{6}.`$$

:::leanStatement "6.10.E2 initial coefficients"
```anchor dlmf_6_10_2 (module := LMLF.Blueprint.ExponentialIntegrals.Section610)
theorem dlmf_6_10_2 :
    inverseFactorialCoeff 0 = 1 ∧ inverseFactorialCoeff 1 = -1 ∧
      inverseFactorialCoeff 2 = (1 / 2 : ℂ) ∧
      inverseFactorialCoeff 3 = -(1 / 3 : ℂ) ∧ inverseFactorialCoeff 4 = 1 / 6
```
:::
::::

::::dlmfEntry "Coefficient recurrence" "https://dlmf.nist.gov/6.10.E3"
The subsequent coefficients satisfy

$$`c_{k}=-\sum_{j=0}^{k-1}\frac{c_{j}}{k-j},\qquad k\geq 1.`$$

:::leanStatement "6.10.E3 coefficient recurrence"
```anchor dlmf_6_10_3 (module := LMLF.Blueprint.ExponentialIntegrals.Section610)
theorem dlmf_6_10_3 :
    ∀ k : ℕ, 1 ≤ k → inverseFactorialCoeff k =
      -(Finset.sum (Finset.range k) fun j =>
        inverseFactorialCoeff j / ((k - j : ℕ) : ℂ))
```
:::
::::

The next subsection uses the standard spherical-Bessel notation of §10.47(ii).

::::dlmfEntry "Spherical-Bessel subsection" "https://dlmf.nist.gov/6.10#ii.p1"
For the notation in E4--E8, consult the DLMF definition of spherical and
modified spherical Bessel functions in [§10.47(ii)](https://dlmf.nist.gov/10.47#ii).
The series statements below expose convergence with `HasSum` and then state
the corresponding value identity, rather than relying on a totalized infinite
sum.
::::

The normalized spherical-Bessel interface records the two initial values and
the three-term recurrence, including the nonzero argument condition.  The
modified-family recurrence is recorded in
[§10.51(ii)](https://dlmf.nist.gov/10.51#ii), while the notation and
normalization are given in [§10.47(ii)](https://dlmf.nist.gov/10.47#ii).
Thus a formula below cannot silently substitute an unrelated spherical-Bessel
sequence.

:::leanStatement "6.10 normalized spherical-Bessel family"
```anchor SphericalBesselFamily (module := LMLF.Blueprint.ExponentialIntegrals.Section610)
structure SphericalBesselFamily where
  value : ℕ → ℂ → ℂ
  value_zero : value 0 0 = 1
  higher_at_zero : ∀ n : ℕ, 0 < n → value n 0 = 0
  initial_zero : ∀ z : ℂ, z ≠ 0 → value 0 z = Complex.sin z / z
  initial_one : ∀ z : ℂ, z ≠ 0 →
    value 1 z = Complex.sin z / z ^ 2 - Complex.cos z / z
  recurrence : ∀ (n : ℕ) (z : ℂ), z ≠ 0 →
    value (n + 2) z = ((2 * (n + 1) + 1 : ℂ) / z) * value (n + 1) z - value n z
```
:::

:::leanStatement "6.10 normalized modified spherical-Bessel family"
```anchor ModifiedSphericalBesselFamily (module := LMLF.Blueprint.ExponentialIntegrals.Section610)
structure ModifiedSphericalBesselFamily where
  value : ℕ → ℂ → ℂ
  value_zero : value 0 0 = 1
  higher_at_zero : ∀ n : ℕ, 0 < n → value n 0 = 0
  initial_zero : ∀ z : ℂ, z ≠ 0 → value 0 z = Complex.sinh z / z
  initial_one : ∀ z : ℂ, z ≠ 0 →
    value 1 z = Complex.cosh z / z - Complex.sinh z / z ^ 2
  recurrence : ∀ (n : ℕ) (z : ℂ), z ≠ 0 →
    value (n + 2) z = value n z -
      ((2 * (n + 1) + 1 : ℂ) / z) * value (n + 1) z
```
:::

:::leanStatement "6.10 coefficient map from digamma"
```anchor modifiedSphericalCoeff (module := LMLF.Blueprint.ExponentialIntegrals.Section610)
def modifiedSphericalCoeff (n : ℕ) : ℝ :=
  (2 * n + 1 : ℝ) *
    (1 - (-1 : ℝ) ^ n +
      (Complex.digamma ((n + 1 : ℕ) : ℂ)).re - (Complex.digamma (1 : ℂ)).re)
```
:::

::::dlmfEntry "Sine integral" "https://dlmf.nist.gov/6.10.E4"
The sine integral has the spherical-Bessel expansion

$$`\operatorname{Si}(z)=z\sum_{n=0}^{\infty}\left(\mathsf{j}_{n}\left(\tfrac{1}{2}z\right)\right)^{2}.`$$

:::leanStatement "6.10.E4 sine-integral expansion"
```anchor dlmf_6_10_4 (module := LMLF.Blueprint.ExponentialIntegrals.Section610)
theorem dlmf_6_10_4 (J : SphericalBesselFamily) (z : ℂ) :
    ∃ s : ℂ,
      HasSum (fun n : ℕ => (J.value n (z / 2)) ^ 2) s ∧
        LMLF.Blueprint.ExponentialIntegrals.Section62.principalSi z = z * s
```
:::
::::

::::dlmfEntry "Cosine integral" "https://dlmf.nist.gov/6.10.E5"
The cosine integral is expanded as

$$`\operatorname{Cin}(z)=\sum_{n=1}^{\infty}a_{n}\left(\mathsf{j}_{n}\left(\tfrac{1}{2}z\right)\right)^{2}.`$$

:::leanStatement "6.10.E5 cosine-integral expansion"
```anchor dlmf_6_10_5 (module := LMLF.Blueprint.ExponentialIntegrals.Section610)
theorem dlmf_6_10_5 (J : SphericalBesselFamily) (z : ℂ) :
    HasSum
        (fun n : ℕ => (modifiedSphericalCoeff (n + 1) : ℂ) *
          (J.value (n + 1) (z / 2)) ^ 2)
        (LMLF.Blueprint.ExponentialIntegrals.Section62.principalCin z)
```
:::
::::

::::dlmfEntry "Exponential integral" "https://dlmf.nist.gov/6.10.E6"
For real x≠0, the modified spherical-Bessel expansion is stated directly for
the canonical §6.2 map `realEi`:

$$`\operatorname{Ei}(x)=\gamma+\ln|x|+\sum_{n=0}^{\infty}(-1)^{n}(x-a_{n})\left({\mathsf{i}^{(1)}_{n}}\left(\tfrac{1}{2}x\right)\right)^{2}.`$$

:::leanStatement "6.10.E6 exponential-integral expansion"
```anchor dlmf_6_10_6 (module := LMLF.Blueprint.ExponentialIntegrals.Section610)
theorem dlmf_6_10_6 (I : ModifiedSphericalBesselFamily) (x : ℝ) (hx : x ≠ 0) :
    HasSum
        (fun n : ℕ => (-1 : ℂ) ^ n *
          ((x : ℂ) - (modifiedSphericalCoeff n : ℂ)) *
          (I.value n ((x : ℂ) / 2)) ^ 2)
        (LMLF.Blueprint.ExponentialIntegrals.Section62.realEi x -
          (Real.eulerMascheroniConstant : ℂ) - (Real.log |x| : ℂ))
```
:::
::::

::::dlmfEntry "Coefficient formula" "https://dlmf.nist.gov/6.10.E7"
The coefficients in the preceding expansion are

$$`a_{n}=(2n+1)\left(1-(-1)^{n}+\psi(n+1)-\psi(1)\right).`$$

:::leanStatement "6.10.E7 coefficient formula"
```anchor dlmf_6_10_7 (module := LMLF.Blueprint.ExponentialIntegrals.Section610)
theorem dlmf_6_10_7 (n : ℕ) :
    modifiedSphericalCoeff n = (2 * n + 1 : ℝ) *
      (1 - (-1 : ℝ) ^ n +
        (Complex.digamma ((n + 1 : ℕ) : ℂ)).re - (Complex.digamma (1 : ℂ)).re)
```
:::
::::

::::dlmfEntry "Complementary exponential integral" "https://dlmf.nist.gov/6.10.E8"
Finally,

$$`\operatorname{Ein}(z)=ze^{-z/2}\left({\mathsf{i}^{(1)}_{0}}\left(\tfrac{1}{2}z\right)+\sum_{n=1}^{\infty}\frac{2n+1}{n(n+1)}{\mathsf{i}^{(1)}_{n}}\left(\tfrac{1}{2}z\right)\right).`$$

:::leanStatement "6.10.E8 complementary exponential-integral expansion"
```anchor dlmf_6_10_8 (module := LMLF.Blueprint.ExponentialIntegrals.Section610)
theorem dlmf_6_10_8 (I : ModifiedSphericalBesselFamily) (z : ℂ) :
    ∃ s : ℂ,
      HasSum
          (fun n : ℕ => (2 * (n + 1) + 1 : ℂ) /
            ((n + 1 : ℂ) * (n + 2)) * I.value (n + 1) (z / 2)) s ∧
        LMLF.Blueprint.ExponentialIntegrals.Section62.principalEin z =
          z * Complex.exp (-z / 2) * (I.value 0 (z / 2) + s)
```
:::
::::

::::dlmfEntry "Spherical-Bessel references" "https://dlmf.nist.gov/6.10#ii.p2"
For E4--E8 and further results, the source cites Harris (2000) and Luke
(1969b, pp. 56--57).  It also notes that an expansion for `E₁(z)` follows by
combining [§6.2.E4](https://dlmf.nist.gov/6.2.E4) with E8, and points to the
related expansions in §6.18(i).
::::

end LMLFManual.Chapter6
