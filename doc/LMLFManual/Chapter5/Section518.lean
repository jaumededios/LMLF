import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section518
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§5.18 q-Gamma and q-Beta Functions" =>
%%%
tag := "chapter-5-section-18"
%%%

:::dlmfChapter "https://dlmf.nist.gov/5.18"
Source: NIST Digital Library of Mathematical Functions, §5.18.
:::

Section [DLMF §5.18](https://dlmf.nist.gov/5.18) introduces finite and infinite
q-Pochhammer products, q-factorials, q-Gamma, and q-Beta functions.  The finite
products make sense for arbitrary complex `q`.  The infinite product and all
q-Gamma/q-Beta formulas below use the source's convergence range `0 < q < 1`
(with `‖q‖ < 1` for the complex-base product); `q > 1` is not silently folded
into that range.  The q-Gamma formulas use complex arguments, while the
two inequalities are stated on the real axis through `qGammaReal`, an explicit
real-valued specialization of the source function.  All complex powers in the
q-Gamma and q-Beta displays use Mathlib's principal `Complex.cpow` branch;
in the Jackson sum, the sampled bases `t=q^k` are positive real numbers.

The local `qGamma` and `qBeta` definitions retain Lean's totalized field-valued
quotients as implementation representatives.  The denominator-only guard
`qGammaDenomNeZero` is deliberately distinct from the complete source-domain
object `QGammaPoint`, which packages `0<q<1` together with a nonzero
q-Pochhammer denominator.  `QBetaPoint` packages the three such q-Gamma
arguments, and `qGammaValue`/`qBetaValue` expose ordinary finite meromorphic
values.  The product and Jackson-sum `HasProd`/`HasSum` declarations appear
before the value identities that consume them.  The real-axis inequalities
continue to use the totalized `qGammaReal` proxy, with `qGammaReal_coe`
recording its agreement with a pole-free `QGammaPoint`.

::::dlmfEntry "5.18.1" "https://dlmf.nist.gov/5.18.E1"
$$` (a;q)_n=\prod_{k=0}^{n-1}(1-aq^k),\qquad n=0,1,2,\ldots .`

The finite q-Pochhammer symbol is the product of the first `n` factors
`1 − aqᵏ`; for `n = 0` the range is empty and the product is `1`.  This finite
identity is valid for complex `a` and `q` without an infinite-product
convergence assumption.

:::leanStatement "Finite q-Pochhammer product"
```anchor dlmf_5_18_1 (module := LMLF.Blueprint.Gamma.Section518)
def qPochhammer (a q : ℂ) (n : ℕ) : ℂ :=
  ∏ k ∈ Finset.range n, (1 - a * q ^ k)
```
:::
::::

::::dlmfEntry "5.18.2" "https://dlmf.nist.gov/5.18.E2"
$$` n!_q=1(1+q)\cdots(1+q+\cdots+q^{n-1})=(q;q)_n(1-q)^{-n}.`

The q-factorial is the product of the q-integers `1 + q + ⋯ + qᵏ` for
`k = 0, …, n−1`, and equals the q-Pochhammer expression.  The displayed
negative power is represented as `(1 − q)⁻¹ ^ n`, with the necessary
`q ≠ 1` condition for that reciprocal form.

:::leanStatement "q-factorial product"
```anchor qFactorial (module := LMLF.Blueprint.Gamma.Section518)
def qFactorial (q : ℂ) (n : ℕ) : ℂ :=
  ∏ k ∈ Finset.range n, ∑ j ∈ Finset.range (k + 1), q ^ j
```

```anchor dlmf_5_18_2 (module := LMLF.Blueprint.Gamma.Section518)
theorem dlmf_5_18_2 (q : ℂ) (n : ℕ) (hq : q ≠ 1) :
    qFactorial q n = qPochhammer q q n * (1 - q)⁻¹ ^ n
```
:::
::::

::::dlmfEntry "5.18.3" "https://dlmf.nist.gov/5.18.E3"
$$` (a;q)_\infty=\prod_{k=0}^{\infty}(1-aq^k),\qquad |q|<1.`

For a complex base with norm below one, the infinite q-Pochhammer product is
convergent, with value denoted by `qPochhammerInf`.  This condition is
intentionally not extended to `q > 1`; the source only gives the product in
the disk `|q|<1`.

:::leanStatement "Infinite q-Pochhammer product"
```anchor qPochhammerTerm (module := LMLF.Blueprint.Gamma.Section518)
def qPochhammerTerm (a q : ℂ) (k : ℕ) : ℂ := 1 - a * q ^ k
```

```anchor qPochhammerInf (module := LMLF.Blueprint.Gamma.Section518)
noncomputable def qPochhammerInf (a q : ℂ) : ℂ :=
  ∏' k : ℕ, qPochhammerTerm a q k
```

```anchor dlmf_5_18_3 (module := LMLF.Blueprint.Gamma.Section518)
theorem dlmf_5_18_3 {a q : ℂ} (hq : ‖q‖ < 1) :
    HasProd (qPochhammerTerm a q) (qPochhammerInf a q)
```
:::
::::

:::leanStatement "q-Gamma denominator and pole guard"
```anchor qGammaDenom (module := LMLF.Blueprint.Gamma.Section518)
noncomputable def qGammaDenom (q : ℝ) (z : ℂ) : ℂ :=
  qPochhammerInf (Complex.cpow (q : ℂ) z) (q : ℂ)
```

```anchor qGammaDenomNeZero (module := LMLF.Blueprint.Gamma.Section518)
def qGammaDenomNeZero (q : ℝ) (z : ℂ) : Prop :=
  qGammaDenom q z ≠ 0
```

This is only the denominator/pole guard.  The complete source domain, including
`0 < q < 1`, is carried by `QGammaPoint` below.
:::

::::dlmfEntry "5.18.4" "https://dlmf.nist.gov/5.18.E4"
$$` \Gamma_q(z)=(q;q)_\infty(1-q)^{1-z}/(q^z;q)_\infty,\qquad 0<q<1.`

For a real base strictly between zero and one, q-Gamma is given by the ratio of
two q-Pochhammer products and the complex power `(1−q)^{1−z}`.  The function
`qGamma` uses the principal `Complex.cpow` branch for the complex powers and the
same infinite product convention as 5.18.3.  This is a transparent real-base
specialization of the source formula, with totalized division at a zero
denominator; the meromorphic reading uses a `QGammaPoint` (whose denominator
field is the `qGammaDenomNeZero` guard).

:::leanStatement "q-Gamma product definition"
```anchor dlmf_5_18_4 (module := LMLF.Blueprint.Gamma.Section518)
noncomputable def qGamma (q : ℝ) (z : ℂ) : ℂ :=
  qPochhammerInf (q : ℂ) (q : ℂ) *
      Complex.cpow (1 - (q : ℂ)) (1 - z) /
    qGammaDenom q z
```
:::
::::

:::leanStatement "q-Gamma pole-free point and value"
```anchor QGammaPoint (module := LMLF.Blueprint.Gamma.Section518)
structure QGammaPoint (q : ℝ) (z : ℂ) : Prop where
  base_pos : 0 < q
  base_lt_one : q < 1
  denominator_ne_zero : qGammaDenomNeZero q z
```

```anchor qGammaValue (module := LMLF.Blueprint.Gamma.Section518)
noncomputable def qGammaValue {q : ℝ} {z : ℂ} (p : QGammaPoint q z) : ℂ :=
  qGamma q z
```

The subtype-like point carries the source base range and the pole-free
denominator; later identities use `qGammaValue p` rather than exposing a raw
quotient at an arbitrary complex argument.
:::

:::leanStatement "q-Gamma product terms"
```anchor qGammaNumerator (module := LMLF.Blueprint.Gamma.Section518)
noncomputable def qGammaNumerator (q : ℝ) : ℂ :=
  qPochhammerInf (q : ℂ) (q : ℂ)
```

```anchor qGammaNumeratorTerm (module := LMLF.Blueprint.Gamma.Section518)
def qGammaNumeratorTerm (q : ℝ) (k : ℕ) : ℂ :=
  qPochhammerTerm (q : ℂ) (q : ℂ) k
```

```anchor qGammaDenominatorTerm (module := LMLF.Blueprint.Gamma.Section518)
def qGammaDenominatorTerm (q : ℝ) (z : ℂ) (k : ℕ) : ℂ :=
  qPochhammerTerm (Complex.cpow (q : ℂ) z) (q : ℂ) k
```
:::

:::leanStatement "q-Gamma product convergence"
```anchor qGamma_products_hasProd (module := LMLF.Blueprint.Gamma.Section518)
theorem qGamma_products_hasProd {q : ℝ} (hq₀ : 0 < q) (hq₁ : q < 1) (z : ℂ) :
    HasProd (qGammaNumeratorTerm q) (qGammaNumerator q) ∧
      HasProd (qGammaDenominatorTerm q z) (qGammaDenom q z)
```

This paired `HasProd` statement names convergence of the numerator and
denominator products before q-Gamma value identities are invoked.
:::

::::dlmfEntry "5.18.5" "https://dlmf.nist.gov/5.18.E5"
$$` \Gamma_q(1)=\Gamma_q(2)=1.`

At the first two positive integer arguments, q-Gamma has value one.  The base
is kept in the source range `0 < q < 1`.

:::leanStatement "First q-Gamma values"
```anchor dlmf_5_18_5 (module := LMLF.Blueprint.Gamma.Section518)
theorem dlmf_5_18_5 {q : ℝ} (p₁ : QGammaPoint q 1) (p₂ : QGammaPoint q 2) :
    qGammaValue p₁ = 1 ∧ qGammaValue p₂ = 1
```
:::
::::

::::dlmfEntry "5.18.6" "https://dlmf.nist.gov/5.18.E6"
$$` n!_q=\Gamma_q(n+1),\qquad n=0,1,2,\ldots .`

Every q-factorial is the q-Gamma value at the corresponding positive integer.
The natural parameter is unrestricted because the source convention already
sets `n` to be a nonnegative integer.

:::leanStatement "q-factorial and q-Gamma"
```anchor dlmf_5_18_6 (module := LMLF.Blueprint.Gamma.Section518)
theorem dlmf_5_18_6 {q : ℝ} (n : ℕ) (p : QGammaPoint q (n + 1 : ℕ)) :
    qFactorial (q : ℂ) n = qGammaValue p
```
:::
::::

::::dlmfEntry "5.18.7" "https://dlmf.nist.gov/5.18.E7"
$$` \Gamma_q(z+1)=\frac{1-q^z}{1-q}\Gamma_q(z),\qquad 0<q<1.`

Shifting the complex argument by one multiplies q-Gamma by the q-integer
factor `(1−qᶻ)/(1−q)`.  Because the quotient is totalized at a zero
denominator, the pointwise statement takes `QGammaPoint q z` and
`QGammaPoint q (z+1)`; these package the base range and the two pole-free
denominators.  This excludes, for example, the source pole at `z=0` rather
than asserting the false totalized equality `qGamma q 1 = 0`.

:::leanStatement "q-Gamma recurrence"
```anchor dlmf_5_18_7 (module := LMLF.Blueprint.Gamma.Section518)
theorem dlmf_5_18_7 {q : ℝ} {z : ℂ} (p : QGammaPoint q z)
    (p₁ : QGammaPoint q (z + 1)) :
    qGammaValue p₁ =
      ((1 - Complex.cpow (q : ℂ) z) / (1 - (q : ℂ))) * qGammaValue p
```
:::
::::

# §5.18(ii) Convexity and the q-Bohr--Mollerup characterization
%%%
number := false
%%%

Source: [DLMF §5.18(ii)](https://dlmf.nist.gov/5.18#ii.p2).

::::dlmfEntry "§5.18(ii) convexity and characterization" "https://dlmf.nist.gov/5.18#ii.p2"
DLMF states that $`\ln\Gamma_q(x)` is convex for $`x>0` and that the
Bohr--Mollerup characterization has a q-analogue.  The statements below use
the real-axis value `qGammaReal`; the bridge `qGammaReal_coe` records that this
real-part projection agrees with the complex q-Gamma value on the pole-free
real axis.  The function is convex, and the positive, normalized, log-convex
solution of the q-recurrence
`f(x+1)=((1−qˣ)/(1−q))f(x)` is unique.

:::leanStatement "Real-axis q-Gamma proxy"
```anchor qGammaReal (module := LMLF.Blueprint.Gamma.Section518)
noncomputable def qGammaReal (q x : ℝ) : ℝ :=
  (qGamma q (x : ℂ)).re
```
:::

:::leanStatement "q-Gamma real-axis bridge"
```anchor qGammaReal_coe (module := LMLF.Blueprint.Gamma.Section518)
theorem qGammaReal_coe {q x : ℝ} (p : QGammaPoint q (x : ℂ)) :
    qGammaValue p = (qGammaReal q x : ℂ)
```
:::

:::leanStatement "q-Gamma log-convexity"
```anchor dlmf_5_18_convexity (module := LMLF.Blueprint.Gamma.Section518)
theorem dlmf_5_18_convexity {q : ℝ} (hq₀ : 0 < q) (hq₁ : q < 1) :
    ConvexOn ℝ (Set.Ioi (0 : ℝ)) (fun x : ℝ ↦ Real.log (qGammaReal q x))
```
:::

:::leanStatement "q-Bohr--Mollerup characterization"
```anchor dlmf_5_18_bohr_mollerup (module := LMLF.Blueprint.Gamma.Section518)
theorem dlmf_5_18_bohr_mollerup {q : ℝ} (hq₀ : 0 < q) (hq₁ : q < 1) {f : ℝ → ℝ}
    (hf_pos : ∀ {x : ℝ}, 0 < x → 0 < f x)
    (hf_recurrence : ∀ {x : ℝ}, 0 < x →
      f (x + 1) = ((1 - Real.rpow q x) / (1 - q)) * f x)
    (hf_one : f 1 = 1)
    (hf_logConvex : ConvexOn ℝ (Set.Ioi (0 : ℝ)) (Real.log ∘ f)) :
    Set.EqOn f (qGammaReal q) (Set.Ioi 0)
```
:::
::::

::::dlmfEntry "5.18.8" "https://dlmf.nist.gov/5.18.E8"
$$` \Gamma_q(x)<\Gamma_r(x),\qquad 0<q<r<1,\quad 0<x<1\ \text{or}\ x>2.`

When the bases satisfy `0 < q < r < 1`, q-Gamma is strictly smaller at base
`q` than at base `r` for `0 < x < 1` and again for `x > 2`.  `qGammaReal`
records the real-axis specialization needed for this order comparison.  The
bridge `qGammaReal_coe` identifies it with the complex q-Gamma value whenever
the q-Pochhammer denominator is nonzero; this avoids treating a totalized pole
as an ordinary real value.

:::leanStatement "q-Gamma base monotonicity below one and above two"
```anchor dlmf_5_18_8 (module := LMLF.Blueprint.Gamma.Section518)
theorem dlmf_5_18_8 {q r x : ℝ} (hq : 0 < q) (hqr : q < r) (hr : r < 1)
    (hx : (0 < x ∧ x < 1) ∨ 2 < x) :
    qGammaReal q x < qGammaReal r x
```
:::
::::

::::dlmfEntry "5.18.9" "https://dlmf.nist.gov/5.18.E9"
$$` \Gamma_q(x)>\Gamma_r(x),\qquad 0<q<r<1,\quad 1<x<2.`

On the intervening interval `1 < x < 2`, the inequality reverses: the value at
the smaller base is strictly larger.  As in 5.18.8, this is the real-axis
specialization of q-Gamma, with the same pole-free convention
recorded by `qGammaReal_coe`.

:::leanStatement "q-Gamma base monotonicity between one and two"
```anchor dlmf_5_18_9 (module := LMLF.Blueprint.Gamma.Section518)
theorem dlmf_5_18_9 {q r x : ℝ} (hq : 0 < q) (hqr : q < r) (hr : r < 1)
    (hx₀ : 1 < x) (hx₁ : x < 2) :
    qGammaReal q x > qGammaReal r x
```
:::
::::

::::dlmfEntry "5.18.10" "https://dlmf.nist.gov/5.18.E10"
$$` \lim_{q\to1^-}\Gamma_q(z)=\Gamma(z).`

As the real base approaches one from below, q-Gamma converges to the ordinary
complex Gamma function at each complex argument.  `nhdsWithin 1 (Iio 1)` is the
filter for the one-sided approach `q → 1⁻`.  This is a statement about the
totalized representatives at exceptional arguments; the source's
meromorphic interpretation is read away from its poles, as for E4.

:::leanStatement "q-Gamma limit at one"
```anchor dlmf_5_18_10 (module := LMLF.Blueprint.Gamma.Section518)
theorem dlmf_5_18_10 (z : ℂ) :
    Tendsto (fun q : ℝ ↦ qGamma q z)
      (nhdsWithin 1 (Iio 1)) (𝓝 (Complex.Gamma z))
```
:::
::::

The source also gives generalized asymptotic expansions of `ln Γ_q(z)` as
`|z| → ∞` and introduces the q-digamma notation
`ψ_q(z)=Γ'_q(z)/Γ_q(z)`; these results are not developed here.

:::leanStatement "q-Beta pole-free point and value"
```anchor QBetaPoint (module := LMLF.Blueprint.Gamma.Section518)
structure QBetaPoint (q : ℝ) where
  a : ℂ
  b : ℂ
  gamma_a : QGammaPoint q a
  gamma_b : QGammaPoint q b
  gamma_sum : QGammaPoint q (a + b)
```

```anchor qBetaValue (module := LMLF.Blueprint.Gamma.Section518)
noncomputable def qBetaValue (p : QBetaPoint q) : ℂ :=
  qBeta q p.a p.b
```

`QBetaPoint` makes the three q-Gamma denominators used by the quotient
explicit, so the source value is not confused with a totalized pole.
:::

::::dlmfEntry "5.18.11" "https://dlmf.nist.gov/5.18.E11"
$$` B_q(a,b)=\frac{\Gamma_q(a)\Gamma_q(b)}{\Gamma_q(a+b)}.`

The q-Beta function is the quotient of the two q-Gamma values at `a` and `b`
by the value at their sum.  The notation keeps `a` and `b` complex and
uses a real base in the section's `0 < q < 1` range.  As with E4, this is a
totalized quotient identity; the source meromorphic q-Beta is represented on
the locus where the three displayed q-Gamma denominators are nonzero.

:::leanStatement "q-Beta quotient definition"
```anchor dlmf_5_18_11 (module := LMLF.Blueprint.Gamma.Section518)
noncomputable def qBeta (q : ℝ) (a b : ℂ) : ℂ :=
  qGamma q a * qGamma q b / qGamma q (a + b)
```
:::
::::

::::dlmfEntry "5.18.12" "https://dlmf.nist.gov/5.18.E12"
$$` B_q(a,b)=\int_0^1\frac{t^{a-1}(tq;q)_\infty}{(tq^b;q)_\infty}\,d_qt,
\qquad 0<q<1,\quad \operatorname{Re}a>0,\quad \operatorname{Re}b>0.`

For positive real base and positive real parts of both parameters, q-Beta has a
Jackson q-integral representation.  The local `qJacksonIntegral` is the
standard sum `(1−q) Σₖ qᵏ f(qᵏ)` on `[0,1]`; principal `Complex.cpow` represents
the complex power `t^{a−1}` at the positive sampled points, and the two
q-Pochhammer factors match the displayed integrand exactly.  The real-base
restriction and both real-part convergence hypotheses are part of this
specialization.

:::leanStatement "Jackson integral and q-Beta summand"
```anchor qJacksonIntegral (module := LMLF.Blueprint.Gamma.Section518)
noncomputable def qJacksonIntegral (q : ℝ) (f : ℝ → ℂ) : ℂ :=
  (1 - (q : ℂ)) * ∑' k : ℕ, (q : ℂ) ^ k * f (q ^ k)
```

```anchor qBetaJacksonIntegrand (module := LMLF.Blueprint.Gamma.Section518)
def qBetaJacksonIntegrand (q : ℝ) (a b : ℂ) (t : ℝ) : ℂ :=
  Complex.cpow (t : ℂ) (a - 1) *
    qPochhammerInf ((t : ℂ) * (q : ℂ)) (q : ℂ) /
      qPochhammerInf ((t : ℂ) * Complex.cpow (q : ℂ) b) (q : ℂ)
```

```anchor qBetaJacksonTerm (module := LMLF.Blueprint.Gamma.Section518)
def qBetaJacksonTerm (q : ℝ) (a b : ℂ) (k : ℕ) : ℂ :=
  (1 - (q : ℂ)) * (q : ℂ) ^ k * qBetaJacksonIntegrand q a b (q ^ k)
```
:::

:::leanStatement "q-Beta Jackson-sum convergence"
```anchor qBeta_jackson_hasSum (module := LMLF.Blueprint.Gamma.Section518)
theorem qBeta_jackson_hasSum {q : ℝ} {a b : ℂ}
    (hq₀ : 0 < q) (hq₁ : q < 1) (ha : 0 < a.re) (hb : 0 < b.re) :
    HasSum (qBetaJacksonTerm q a b)
      (qJacksonIntegral q (qBetaJacksonIntegrand q a b))
```

This `HasSum` declaration depends only on the Jackson convergence regime; it
is independent of the later q-Beta quotient value and its `QBetaPoint`.
:::

:::leanStatement "q-Beta Jackson integral"
```anchor dlmf_5_18_12 (module := LMLF.Blueprint.Gamma.Section518)
theorem dlmf_5_18_12 {q : ℝ} (p : QBetaPoint q)
    (ha : 0 < p.a.re) (hb : 0 < p.b.re) :
    qBetaValue p = qJacksonIntegral q (qBetaJacksonIntegrand q p.a p.b)
```
:::
::::
