import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section52
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§5.2 Definitions" =>
%%%
tag := "chapter-5-section-2"
%%%

:::dlmfChapter "https://dlmf.nist.gov/5.2"
Source: NIST Digital Library of Mathematical Functions, §5.2.
:::

# §5.2(i) Gamma and Psi Functions
%%%
number := false
%%%

DLMF begins with Euler's integral and then extends the resulting Gamma function meromorphically.
The Lean declarations use Mathlib's `Complex.Gamma`; at the classical poles, Mathlib's totalized
function has value zero, while statements about poles are expressed through punctured limits.

::::dlmfEntry "5.2.1" "https://dlmf.nist.gov/5.2.E1"
$$`\Gamma(z)=\int_0^\infty e^{-t}t^{z-1}\,dt,\qquad \Re z>0.`

For $`\Re z>0`$, the integrand is integrable on the positive real axis and its integral is Gamma.
Lean records convergence separately from the value identity so later integral arguments can use the
stronger fact directly.

:::leanStatement "Lean · Euler integral and convergence"
```anchor gammaContext (module := LMLF.Definitions.Gamma) -showProofStates
namespace LMLF.Definitions
```

```anchor gamma_eulerIntegrable (module := LMLF.Definitions.Gamma) -showProofStates
theorem gamma_eulerIntegrable {s : ℂ} (hs : 0 < s.re) :
    MeasureTheory.IntegrableOn
      (fun t : ℝ ↦ (Real.exp (-t) : ℂ) * (t : ℂ) ^ (s - 1))
      (Set.Ioi 0)
```

```anchor gamma_eq_eulerIntegral (module := LMLF.Definitions.Gamma) -showProofStates
theorem gamma_eq_eulerIntegral {s : ℂ} (hs : 0 < s.re) :
    Complex.Gamma s =
      ∫ t in Set.Ioi (0 : ℝ), (Real.exp (-t) : ℂ) * (t : ℂ) ^ (s - 1)
```
:::

Away from the nonpositive integers, Gamma has no zeros. At $`z=-n`$ it has a simple pole with
residue $`(-1)^n/n!`; equivalently, $`(z+n)\Gamma(z)`$ tends to that residue. Its reciprocal is an
entire function whose simple zeros occur at those same points.

:::leanStatement "Lean · continuation, poles, and reciprocal Gamma"
```anchor meromorphic_gamma (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem meromorphic_gamma : Meromorphic Complex.Gamma
```

```anchor gamma_ne_zero_away_from_poles (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem gamma_ne_zero_away_from_poles {z : ℂ} (hz : ∀ n : ℕ, z ≠ -(n : ℂ)) :
    Complex.Gamma z ≠ 0
```

```anchor gamma_totalized_at_pole (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem gamma_totalized_at_pole (n : ℕ) :
    Complex.Gamma (-(n : ℂ)) = 0
```

```anchor tendsto_gamma_residue_neg_nat (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem tendsto_gamma_residue_neg_nat (n : ℕ) :
    Tendsto
      (fun z : ℂ ↦ (z + n) * Complex.Gamma z)
      (nhdsWithin (-(n : ℂ)) {-(n : ℂ)}ᶜ)
      (nhds ((-1 : ℂ) ^ n / n.factorial))
```

```anchor differentiable_one_div_gamma (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem differentiable_one_div_gamma :
    Differentiable ℂ (fun z : ℂ ↦ (Complex.Gamma z)⁻¹)
```

```anchor one_div_gamma_eq_zero_iff (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem one_div_gamma_eq_zero_iff (z : ℂ) :
    (Complex.Gamma z)⁻¹ = 0 ↔ ∃ n : ℕ, z = -(n : ℂ)
```

```anchor one_div_gamma_hasSimpleZero_neg_nat (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem one_div_gamma_hasSimpleZero_neg_nat (n : ℕ) :
    (Complex.Gamma (-(n : ℂ)))⁻¹ = 0 ∧
      deriv (fun z : ℂ ↦ (Complex.Gamma z)⁻¹) (-(n : ℂ)) ≠ 0
```
:::
::::

::::dlmfEntry "5.2.2" "https://dlmf.nist.gov/5.2.E2"
$$`\psi(z)=\frac{\Gamma'(z)}{\Gamma(z)},\qquad z\ne0,-1,-2,\ldots.`

The psi, or digamma, function is Gamma's logarithmic derivative. The exclusion precisely removes
Gamma's poles. Digamma itself is meromorphic and has a simple pole of residue $`-1`$ at each
nonpositive integer.

:::leanStatement "Lean · logarithmic derivative and residues"
```anchor section52Context (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
namespace LMLF.Blueprint.Gamma

open Filter Finset Polynomial
open scoped BigOperators
```

```anchor digamma_eq_gamma_deriv_div (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem digamma_eq_gamma_deriv_div {z : ℂ} (hz : ∀ n : ℕ, z ≠ -(n : ℂ)) :
    Complex.digamma z = deriv Complex.Gamma z / Complex.Gamma z
```

```anchor meromorphic_digamma (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem meromorphic_digamma : Meromorphic Complex.digamma
```

```anchor tendsto_digamma_residue_neg_nat (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem tendsto_digamma_residue_neg_nat (n : ℕ) :
    Tendsto
      (fun z : ℂ ↦ (z + n) * Complex.digamma z)
      (nhdsWithin (-(n : ℂ)) {-(n : ℂ)}ᶜ)
      (nhds (-1))
```
:::
::::

# §5.2(ii) Euler's Constant
%%%
number := false
%%%

::::dlmfEntry "5.2.3" "https://dlmf.nist.gov/5.2.E3"
$$`\gamma=\lim_{n\to\infty}\left(1+\frac12+\frac13+\cdots+\frac1n-\ln n\right)
=0.57721\,56649\,01532\,86060\ldots.`

Euler's constant is the limit of the harmonic sum after subtracting its logarithmic growth. The
second declaration turns the displayed decimal into a rigorous enclosure: the error is less than
one unit in its final displayed decimal place.

:::leanStatement "Lean · definition by a limit"
```anchor tendsto_harmonic_sub_log_eulerMascheroni (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem tendsto_harmonic_sub_log_eulerMascheroni :
    Tendsto
      (fun n : ℕ ↦ (∑ k ∈ Icc 1 n, (k : ℝ)⁻¹) - Real.log n)
      atTop (nhds Real.eulerMascheroniConstant)
```
:::

:::leanStatement "Lean · twenty-decimal enclosure"
```anchor eulerMascheroni_decimal (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem eulerMascheroni_decimal :
    |Real.eulerMascheroniConstant - 0.57721566490153286060| < 1 / 10 ^ 20
```
:::
::::

# §5.2(iii) Pochhammer's Symbol
%%%
number := false
%%%

The Pochhammer symbol $`(a)_n`$ is the rising factorial. The Lean definition evaluates Mathlib's
ascending Pochhammer polynomial, so it works uniformly over commutative semirings and agrees with
the standard finite product.

::::dlmfEntry "5.2.4" "https://dlmf.nist.gov/5.2.E4"
$$`(a)_0=1,\qquad (a)_n=a(a+1)(a+2)\cdots(a+n-1).`

The empty product gives $`(a)_0=1`$. For positive indices the factors advance by one, beginning at
$`a` and ending at $`a+n-1`.

:::leanStatement "Lean · Pochhammer symbol and finite product"
```anchor pochhammerSymbol (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
noncomputable def pochhammerSymbol {R : Type*} [CommSemiring R] (a : R) (n : ℕ) : R :=
  (ascPochhammer R n).eval a
```

```anchor pochhammerSymbol_zero (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem pochhammerSymbol_zero (a : ℂ) : pochhammerSymbol a 0 = 1
```

```anchor pochhammerSymbol_eq_prod (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem pochhammerSymbol_eq_prod (a : ℂ) (n : ℕ) :
    pochhammerSymbol a n = ∏ k ∈ range n, (a + k)
```
:::
::::

::::dlmfEntry "5.2.5" "https://dlmf.nist.gov/5.2.E5"
$$`(a)_n=\frac{\Gamma(a+n)}{\Gamma(a)},\qquad a\ne0,-1,-2,\ldots.`

When $`a` is not a pole of Gamma, the rising factorial is the quotient of two Gamma values. The
Lean hypothesis states the excluded set directly rather than hiding it behind a side-condition
predicate.

:::leanStatement "Lean · Gamma quotient"
```anchor pochhammerSymbol_eq_gamma_div (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem pochhammerSymbol_eq_gamma_div {a : ℂ} (n : ℕ)
    (ha : ∀ m : ℕ, a ≠ -(m : ℂ)) :
    pochhammerSymbol a n = Complex.Gamma (a + n) / Complex.Gamma a
```
:::
::::

::::dlmfEntry "5.2.6" "https://dlmf.nist.gov/5.2.E6"
$$`(-a)_n=(-1)^n(a-n+1)_n.`

Reversing the signs in a rising product turns it into the same number of factors starting at
$`a-n+1`; extracting one minus sign from every factor produces $`(-1)^n`.

:::leanStatement "Lean · reversal identity"
```anchor pochhammerSymbol_neg (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem pochhammerSymbol_neg (a : ℂ) (n : ℕ) :
    pochhammerSymbol (-a) n = (-1 : ℂ) ^ n * pochhammerSymbol (a - n + 1) n
```
:::
::::

::::dlmfEntry "5.2.7" "https://dlmf.nist.gov/5.2.E7"
$$`(-m)_n=
\begin{cases}
\dfrac{(-1)^n m!}{(m-n)!},&0\le n\le m,\\[4pt]
0,&n>m.
\end{cases}`

For a nonnegative integer $`m`, the product terminates once a zero factor is reached. Before that
point it is a signed quotient of factorials. Natural-number indices make $`0\le n` automatic in
Lean.

:::leanStatement "Lean · terminating negative-integer case"
```anchor pochhammerSymbol_neg_nat (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem pochhammerSymbol_neg_nat (m n : ℕ) :
    pochhammerSymbol (-(m : ℂ)) n =
      if n ≤ m then
        (-1 : ℂ) ^ n * m.factorial / (m - n).factorial
      else 0
```
:::
::::

::::dlmfEntry "5.2.8" "https://dlmf.nist.gov/5.2.E8"
$$`(a)_{2n}=2^{2n}\left(\frac a2\right)_n
\left(\frac{a+1}{2}\right)_n,`
$$`(a)_{2n+1}=2^{2n+1}\left(\frac a2\right)_{n+1}
\left(\frac{a+1}{2}\right)_n.`

Separating a rising product into its even and odd factors gives these duplication identities. The
two declarations retain the even and odd cases separately, matching the two lines of the source.

:::leanStatement "Lean · even and odd duplication identities"
```anchor pochhammerSymbol_two_mul (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem pochhammerSymbol_two_mul (a : ℂ) (n : ℕ) :
    pochhammerSymbol a (2 * n) =
      (2 : ℂ) ^ (2 * n) * pochhammerSymbol (a / 2) n *
        pochhammerSymbol ((a + 1) / 2) n
```

```anchor pochhammerSymbol_two_mul_add_one (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem pochhammerSymbol_two_mul_add_one (a : ℂ) (n : ℕ) :
    pochhammerSymbol a (2 * n + 1) =
      (2 : ℂ) ^ (2 * n + 1) * pochhammerSymbol (a / 2) (n + 1) *
        pochhammerSymbol ((a + 1) / 2) n
```
:::
::::

::::dlmfEntry "5.2.9" "https://dlmf.nist.gov/5.2.E9"
$$`(x)_n=\sum_{k=0}^n L(n,k)\,x(x-1)\cdots(x-k+1),`
$$`x(x-1)\cdots(x-n+1)=
\sum_{k=0}^n(-1)^{n-k}L(n,k)(x)_k,`
where
$$`L(n,k)=\binom{n-1}{k-1}\frac{n!}{k!}`
is the unsigned Lah number.

The falling factorial in the source is the signed rising factorial
$`(-1)^n(-x)_n=x(x-1)\cdots(x-n+1)`$. Lean records this bridge explicitly, while defining the
falling factorial through Mathlib's descending Pochhammer polynomial. The Lah numbers are the
change-of-basis coefficients between rising and falling factorials. These identities are stated
over the reals, exactly as in the DLMF display; their polynomial form admits later generalization
to other coefficient rings. The Lean definition also supplies the boundary convention
$`L(0,0)=1` and $`L(n,0)=0` for $`n>0`$, which is needed for sums beginning at zero.

:::leanStatement "Lean · Lah numbers and factorial basis changes"
```anchor fallingFactorial (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
noncomputable def fallingFactorial {R : Type*} [CommRing R] (x : R) (n : ℕ) : R :=
  (descPochhammer R n).eval x
```

```anchor fallingFactorial_eq_neg_one_pow_mul_pochhammerSymbol_neg (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem fallingFactorial_eq_neg_one_pow_mul_pochhammerSymbol_neg
    {R : Type*} [CommRing R] (x : R) (n : ℕ) :
    fallingFactorial x n = (-1 : R) ^ n * pochhammerSymbol (-x) n
```

```anchor lahNumber (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
def lahNumber (n k : ℕ) : ℕ :=
  if k = 0 then if n = 0 then 1 else 0
  else Nat.choose (n - 1) (k - 1) * n.factorial / k.factorial
```

```anchor pochhammerSymbol_eq_sum_lah_fallingFactorial (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem pochhammerSymbol_eq_sum_lah_fallingFactorial (x : ℝ) (n : ℕ) :
    pochhammerSymbol x n =
      ∑ k ∈ range (n + 1), (lahNumber n k : ℝ) * fallingFactorial x k
```

```anchor fallingFactorial_eq_sum_lah_pochhammerSymbol (module := LMLF.Blueprint.Gamma.Section52) -showProofStates
theorem fallingFactorial_eq_sum_lah_pochhammerSymbol (x : ℝ) (n : ℕ) :
    fallingFactorial x n =
      ∑ k ∈ range (n + 1),
        (-1 : ℝ) ^ (n - k) * lahNumber n k * pochhammerSymbol x k
```
:::
::::
