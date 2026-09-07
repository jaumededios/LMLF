import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section46
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.6 Power Series" =>
%%%
tag := "chapter-4-section-6"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.6"
Source: NIST Digital Library of Mathematical Functions, §4.6.
:::

Section [DLMF §4.6](https://dlmf.nist.gov/4.6) develops power series for the
principal logarithm and for complex powers.  The logarithm is understood on its
principal branch.  The endpoint hypotheses below are those stated by DLMF;
they include conditional-convergence boundary cases as well as open disks.

The recurring summands and generalized binomial coefficient are displayed here
so that each series below has its coefficient and indexing convention visible.

:::leanStatement "Series terms and generalized binomial coefficient"
```anchor logOneAddTerm (module := LMLF.Blueprint.Elementary.Section46)
def logOneAddTerm (z : ℂ) (n : ℕ) : ℂ :=
  (-1 : ℂ) ^ n * z ^ (n + 1) / (n + 1 : ℂ)
```
```anchor logRatioTerm (module := LMLF.Blueprint.Elementary.Section46)
def logRatioTerm (z : ℂ) (n : ℕ) : ℂ :=
  ((z - 1) / z) ^ (n + 1) / (n + 1 : ℂ)
```
```anchor logSubOneTerm (module := LMLF.Blueprint.Elementary.Section46)
def logSubOneTerm (z : ℂ) (n : ℕ) : ℂ :=
  (-1 : ℂ) ^ n * (z - 1) ^ (n + 1) / (n + 1 : ℂ)
```
```anchor logSymmetricTerm (module := LMLF.Blueprint.Elementary.Section46)
def logSymmetricTerm (z : ℂ) (n : ℕ) : ℂ :=
  2 * (((z - 1) / (z + 1)) ^ (2 * n + 1) / (2 * n + 1 : ℂ))
```
```anchor logInverseOddTerm (module := LMLF.Blueprint.Elementary.Section46)
def logInverseOddTerm (z : ℂ) (n : ℕ) : ℂ :=
  2 * (1 / ((2 * n + 1 : ℕ) : ℂ) / z ^ (2 * n + 1))
```
```anchor logShiftedTerm (module := LMLF.Blueprint.Elementary.Section46)
def logShiftedTerm (a z : ℝ) (n : ℕ) : ℂ :=
  (((z : ℂ) / (2 * a + z)) ^ (2 * n + 1)) / (2 * n + 1 : ℂ)
```
```anchor generalizedBinomial (module := LMLF.Blueprint.Elementary.Section46)
def generalizedBinomial (a : ℂ) (n : ℕ) : ℂ :=
  (∏ k ∈ Finset.range n, (a - k)) / (n.factorial : ℂ)
```
:::

# §4.6(i) Logarithms
%%%
number := false
%%%

::::dlmfEntry "4.6.1" "https://dlmf.nist.gov/4.6.E1"
$$`\[ \ln(1+z)=z-\frac{z^2}{2}+\frac{z^3}{3}-\cdots,\qquad |z|\leq1,\quad z\ne-1.\]`

This is the alternating logarithm series at `1`.  It converges throughout the
closed unit disk except at the singular endpoint `z = -1`.

:::leanStatement "Logarithm series at one"
```anchor dlmf_4_6_1 (module := LMLF.Blueprint.Elementary.Section46)
theorem dlmf_4_6_1 {z : ℂ} (hz : ‖z‖ ≤ 1) (hz1 : z ≠ -1) :
    HasSum (logOneAddTerm z) (Complex.log (1 + z)) := by
  sorry
```
:::
::::

::::dlmfEntry "4.6.2" "https://dlmf.nist.gov/4.6.E2"
$$`\[ \ln z=\frac{z-1}{z}+\frac12\left(\frac{z-1}{z}\right)^2+\frac13\left(\frac{z-1}{z}\right)^3+\cdots,\qquad \mathop{\rm Re}z\geq\frac12.\]`

Writing `w = (z−1)/z`, this is the geometric logarithm series
`Σₙ₌₁^∞ wⁿ/n`.  The half-plane `Re z ≥ 1/2` keeps `w` in the closed unit
disk and selects the principal logarithm value.

:::leanStatement "Logarithm series in a half-plane"
```anchor dlmf_4_6_2 (module := LMLF.Blueprint.Elementary.Section46)
theorem dlmf_4_6_2 {z : ℂ} (hz : 1 / 2 ≤ z.re) :
    HasSum (logRatioTerm z) (Complex.log z) := by
  sorry
```
:::
::::

::::dlmfEntry "4.6.3" "https://dlmf.nist.gov/4.6.E3"
$$`\[ \ln z=(z-1)-\frac12(z-1)^2+\frac13(z-1)^3-\cdots,\qquad |z-1|\leq1,\quad z\ne0.\]`

This is the alternating expansion about `z = 1`.  Its closed-disk domain
excludes `z = 0`, the logarithmic singularity at the opposite endpoint.

:::leanStatement "Logarithm series about one"
```anchor dlmf_4_6_3 (module := LMLF.Blueprint.Elementary.Section46)
theorem dlmf_4_6_3 {z : ℂ} (hz : ‖z - 1‖ ≤ 1) (hz0 : z ≠ 0) :
    HasSum (logSubOneTerm z) (Complex.log z) := by
  sorry
```
:::
::::

::::dlmfEntry "4.6.4" "https://dlmf.nist.gov/4.6.E4"
$$`\[ \ln z=2\left(\frac{z-1}{z+1}+\frac13\left(\frac{z-1}{z+1}\right)^3+\frac15\left(\frac{z-1}{z+1}\right)^5+\cdots\right),\qquad \mathop{\rm Re}z\geq0,\quad z\ne0.\]`

The odd-power expansion uses `w = (z−1)/(z+1)` and converges in the right
half-plane, including its boundary away from the origin.

:::leanStatement "Symmetric logarithm series"
```anchor dlmf_4_6_4 (module := LMLF.Blueprint.Elementary.Section46)
theorem dlmf_4_6_4 {z : ℂ} (hz : 0 ≤ z.re) (hz0 : z ≠ 0) :
    HasSum (logSymmetricTerm z) (Complex.log z) := by
  sorry
```
:::
::::

::::dlmfEntry "4.6.5" "https://dlmf.nist.gov/4.6.E5"
$$`\[ \ln\left(\frac{z+1}{z-1}\right)=2\left(\frac1z+\frac1{3z^3}+\frac1{5z^5}+\cdots\right),\qquad |z|\geq1,\quad z\ne\pm1.\]`

This is the inverse odd-power form of the preceding symmetric expansion.  The
closed exterior disk excludes the two points where the displayed quotient has
its exceptional values.

:::leanStatement "Inverse-power logarithm series"
```anchor dlmf_4_6_5 (module := LMLF.Blueprint.Elementary.Section46)
theorem dlmf_4_6_5 {z : ℂ} (hz : 1 ≤ ‖z‖) (hz1 : z ≠ 1) (hzneg1 : z ≠ -1) :
    HasSum (logInverseOddTerm z) (Complex.log ((z + 1) / (z - 1))) := by
  sorry
```
:::
::::

::::dlmfEntry "4.6.6" "https://dlmf.nist.gov/4.6.E6"
$$`\[ \ln(z+a)=\ln a+2\left(\frac{z}{2a+z}+\frac13\left(\frac{z}{2a+z}\right)^3+\cdots\right),\quad a>0,\quad \mathop{\rm Re}z\geq-a,\quad z\ne-a.\]`

For the readable real-variable specialization used here, `a` is positive and
`z` is real with `z ≥ −a`; the same odd-power expression then expands the
shifted logarithm about the positive point `a`.

:::leanStatement "Shifted logarithm series"
```anchor dlmf_4_6_6 (module := LMLF.Blueprint.Elementary.Section46)
theorem dlmf_4_6_6 {a : ℝ} {z : ℝ} (ha : 0 < a) (hz : -a ≤ z) (hza : z ≠ -a) :
    Complex.log ((z + a : ℂ)) = Complex.log (a : ℂ) +
      2 * ∑' n, logShiftedTerm a z n := by
  sorry
```
:::
::::

# §4.6(ii) Powers
%%%
number := false
%%%

## Binomial Expansion
%%%
number := false
%%%

::::dlmfEntry "4.6.7" "https://dlmf.nist.gov/4.6.E7"
$$`\[ (1+z)^a=1+\frac{a}{1!}z+\frac{a(a-1)}{2!}z^2+\frac{a(a-1)(a-2)}{3!}z^3+\cdots.\]`

For arbitrary real or complex `a`, the principal complex power has its binomial
series on `|z| < 1`.  When `a` is a nonnegative integer the coefficients vanish
after finitely many terms, so the resulting polynomial is valid for every `z`.

:::leanStatement "Generalized binomial expansion"
```anchor dlmf_4_6_7 (module := LMLF.Blueprint.Elementary.Section46)
theorem dlmf_4_6_7 (a z : ℂ) (hz : ‖z‖ < 1) :
    Complex.cpow (1 + z) a = ∑' n, generalizedBinomial a n * z ^ n := by
  sorry
```
:::
:::leanStatement "Terminating generalized binomial expansion"
```anchor dlmf_4_6_7_terminating (module := LMLF.Blueprint.Elementary.Section46)
theorem dlmf_4_6_7_terminating (m : ℕ) (z : ℂ) :
    Complex.cpow (1 + z) (m : ℂ) =
      ∑' n, generalizedBinomial (m : ℂ) n * z ^ n := by
  sorry
```
:::
::::
