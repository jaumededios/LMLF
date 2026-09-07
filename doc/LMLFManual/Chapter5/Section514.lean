import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section514
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§5.14 Multidimensional Integrals" =>
%%%
tag := "chapter-5-section-14"
%%%

This page follows all seven numbered records in [DLMF §5.14](https://dlmf.nist.gov/5.14).
The source permits complex parameters and states convergence using real parts.  The
displayed Lean declarations use real parameter specializations, with positivity hypotheses
where needed for convergence, and volume on the finite-dimensional real space Fin n → ℝ;
the specialization is stated explicitly for each entry.  The sets simplex, unitCube,
positiveOrthant, and dysonCube make the
integration domains visible.  Throughout this page, powers use Mathlib's totalized
`Real.rpow`: on zero-base boundary, endpoint, diagonal, or collision loci the displayed
functions are chosen as total a.e. representatives of the source integrands.  These loci
are volume-null, so this convention does not change `IntegrableOn` or the volume integral.

::::dlmfEntry "5.14.1" "https://dlmf.nist.gov/5.14.E1"
For ` Vₙ = {t₁ + ⋯ + tₙ ≤ 1, tₖ ≥ 0} ` and ` Re zₖ > 0 ` ,
$$` ∫_{Vₙ} t₁^(z₁−1)⋯tₙ^(zₙ−1) dt₁⋯dtₙ
 = Γ(z₁)⋯Γ(zₙ) / Γ(1+z₁+⋯+zₙ). `$$

The Lean statement uses real ` z i > 0 ` and ` 0 < n `, so it is a positive-real,
positive-dimensional specialization of the source range.  The simplex is integrated with
product Lebesgue measure, and ` IntegrableOn ` records convergence before the value of the
integral.  Its zero-coordinate boundary powers use the totalized representative described
above.

:::leanStatement "Lean statement · simplex beta integral"
```anchor simplex (module := LMLF.Blueprint.Gamma.Section514) -showProofStates
def simplex (n : ℕ) : Set (Fin n → ℝ) :=
  {t | (∀ i, 0 ≤ t i) ∧ ∑ i, t i ≤ 1}
```

```anchor dlmf_5_14_1 (module := LMLF.Blueprint.Gamma.Section514) -showProofStates
theorem dlmf_5_14_1 {n : ℕ} (hn : 0 < n) (z : Fin n → ℝ)
    (hz : ∀ i, 0 < z i) :
    IntegrableOn (fun t : Fin n → ℝ ↦
      ∏ i : Fin n, Real.rpow (t i) (z i - 1)) (simplex n) volume ∧
      (∫ t in simplex n, ∏ i : Fin n, Real.rpow (t i) (z i - 1)) =
        (∏ i : Fin n, Real.Gamma (z i)) /
          Real.Gamma (1 + ∑ i : Fin n, z i)
```
:::
::::

::::dlmfEntry "5.14.2" "https://dlmf.nist.gov/5.14.E2"
For the same simplex and ` Re zₖ > 0 `,
$$` ∫_{Vₙ}(1−∑ₖ₌₁ⁿtₖ)^(zₙ₊₁−1) ∏ₖ₌₁ⁿtₖ^(zₖ−1) dtₖ
 = Γ(z₁)⋯Γ(zₙ₊₁) / Γ(z₁+⋯+zₙ₊₁). `$$

The final barycentric coordinate is ` 1 - ∑ i, t i `, and z has type ` Fin (n+1) → ℝ `.
The hypothesis ` 0 < n ` makes this a positive-dimensional, real-positive specialization
of the complex source formula; the measure and integrability assertion are explicit.  The
totalized ` Real.rpow ` value on the simplex boundary is an a.e. representative.

:::leanStatement "Lean statement · full simplex beta integral"
```anchor dlmf_5_14_2 (module := LMLF.Blueprint.Gamma.Section514) -showProofStates
theorem dlmf_5_14_2 {n : ℕ} (hn : 0 < n) (z : Fin (n + 1) → ℝ)
    (hz : ∀ i, 0 < z i) :
    IntegrableOn (fun t : Fin n → ℝ ↦
      Real.rpow (1 - ∑ i : Fin n, t i) (z (Fin.last n) - 1) *
        ∏ i : Fin n, Real.rpow (t i) (z (Fin.castSucc i) - 1)) (simplex n) volume ∧
      (∫ t in simplex n,
          Real.rpow (1 - ∑ i : Fin n, t i) (z (Fin.last n) - 1) *
            ∏ i : Fin n, Real.rpow (t i) (z (Fin.castSucc i) - 1)) =
        (∏ i : Fin (n + 1), Real.Gamma (z i)) /
          Real.Gamma (∑ i : Fin (n + 1), z i)
```
:::
::::

::::dlmfEntry "5.14.3" "https://dlmf.nist.gov/5.14.E3"
The Vandermonde product is
$$` Δ(t₁,t₂,…,tₙ) = ∏₁≤ⱼ<ₖ≤ₙ (tⱼ−tₖ). `$$

The source definition is recorded for real coordinate vectors.  The nested ` Fin n `
products select exactly one factor for each pair ` j < k `; the conditional contributes 1
for the other ordered pairs.

:::leanStatement "Lean statement · Vandermonde product"
```anchor vandermonde (module := LMLF.Blueprint.Gamma.Section514) -showProofStates
def vandermonde (n : ℕ) (t : Fin n → ℝ) : ℝ :=
  ∏ j : Fin n, ∏ k : Fin n, if j < k then t j - t k else 1
```

```anchor dlmf_5_14_3 (module := LMLF.Blueprint.Gamma.Section514) -showProofStates
theorem dlmf_5_14_3 (n : ℕ) (t : Fin n → ℝ) :
    vandermonde n t = ∏ j : Fin n, ∏ k : Fin n, if j < k then t j - t k else 1
```
:::
::::

# Selberg-type integrals
%%%
number := false
%%%

::::dlmfEntry "5.14.4" "https://dlmf.nist.gov/5.14.E4"
For ` Re a, Re b > 0 ` and ` Re c > -min(1/n, Re a/(n-1), Re b/(n-1)) `,
$$` ∫_[0,1]ⁿ t₁⋯tₘ |Δ(t)|^(2c) ∏ₖ tₖ^(a−1)(1−tₖ)^(b−1) dtₖ `$$
$$` = Γ(1+c)^(-n) ∏ₖ₌₁ᵐ (a+(n−k)c)/(a+b+(2n−k−1)c)
 × ∏ₖ₌₁ⁿ Γ(a+(n−k)c)Γ(b+(n−k)c)Γ(1+kc) /
 Γ(a+b+(2n−k−1)c). `$$

The declaration uses positive real `a,b` and admissible real `c`, with ` 2 ≤ n ` making the displayed
` n−1 ` denominators literal and ` m ≤ n ` controlling the first-coordinate moment.  Lean's
` Fin n ` index is zero-based: ` selbergIndex n k ` is the real expression ` n - k.1 - 1 `,
which denotes the source ` n-k ` for source ` k = k.1+1 `.  Accordingly, the source
` 2n-k-1 ` factor is written ` selbergIndex n k + n - 1 `, with no truncated natural
subtraction.  ` unitCube n ` is ` [0,1]ⁿ `; its integrability and source value are stated
with volume, using the totalized real powers on null boundary and diagonal sets.

:::leanStatement "Lean statement · Selberg cube integral"
```anchor selbergCubeIntegrand (module := LMLF.Blueprint.Gamma.Section514) -showProofStates
def selbergCubeIntegrand {m n : ℕ} (hmn : m ≤ n) (a b c : ℝ)
    (t : Fin n → ℝ) : ℝ :=
  firstCoordinatesProduct hmn t * Real.rpow (|vandermonde n t|) (2 * c) *
    ∏ k : Fin n, Real.rpow (t k) (a - 1) * Real.rpow (1 - t k) (b - 1)
```

```anchor dlmf_5_14_4 (module := LMLF.Blueprint.Gamma.Section514) -showProofStates
theorem dlmf_5_14_4 {m n : ℕ} (hmn : m ≤ n) (hn : 2 ≤ n)
    {a b c : ℝ} (ha : 0 < a) (hb : 0 < b)
    (hc₁ : -1 / (n : ℝ) < c)
    (hc₂ : -(a / ((n : ℝ) - 1)) < c)
    (hc₃ : -(b / ((n : ℝ) - 1)) < c) :
    IntegrableOn (selbergCubeIntegrand hmn a b c) (unitCube n) volume ∧
      (∫ t in unitCube n, selbergCubeIntegrand hmn a b c t) =
        (∏ k : Fin m,
            (a + selbergIndex n (Fin.castLE hmn k) * c) /
              (a + b +
                (selbergIndex n (Fin.castLE hmn k) + (n : ℝ) - 1) * c)) *
          (∏ k : Fin n,
            Real.Gamma (a + selbergIndex n k * c) *
              Real.Gamma (b + selbergIndex n k * c) *
              Real.Gamma (1 + (k.1 + 1 : ℝ) * c) /
                Real.Gamma (a + b +
                  (selbergIndex n k + (n : ℝ) - 1) * c)) /
            (∏ _ : Fin n, Real.Gamma (1 + c))
```
:::
::::

::::dlmfEntry "5.14.5" "https://dlmf.nist.gov/5.14.E5"
When ` Re a > 0 ` and ` Re c > -min(1/n, Re a/(n-1)) `,
$$` ∫_[0,∞)ⁿ t₁⋯tₘ |Δ(t)|^(2c) ∏ₖ tₖ^(a−1)e^(−tₖ) dtₖ `$$
$$` = ∏ₖ₌₁ᵐ(a+(n−k)c) × ∏ₖ₌₁ⁿ Γ(a+(n−k)c)Γ(1+kc) / Γ(1+c)^n. `$$

The declaration uses positive real `a` and admissible real `c`.  Its ` m ≤ n ` moment,
` 2 ≤ n ` convention, positive orthant, and explicit ` IntegrableOn ` hypothesis are visible;
` Real.exp (-t k) ` is the source factor e^(−tₖ).  The real-power factors use the page's
totalized a.e. representative on boundary and diagonal null sets.

:::leanStatement "Lean statement · Laguerre/Selberg orthant integral"
```anchor laguerreIntegrand (module := LMLF.Blueprint.Gamma.Section514) -showProofStates
def laguerreIntegrand {m n : ℕ} (hmn : m ≤ n) (a c : ℝ)
    (t : Fin n → ℝ) : ℝ :=
  firstCoordinatesProduct hmn t * Real.rpow (|vandermonde n t|) (2 * c) *
    ∏ k : Fin n, Real.rpow (t k) (a - 1) * Real.exp (-t k)
```

```anchor dlmf_5_14_5 (module := LMLF.Blueprint.Gamma.Section514) -showProofStates
theorem dlmf_5_14_5 {m n : ℕ} (hmn : m ≤ n) (hn : 2 ≤ n)
    {a c : ℝ} (ha : 0 < a) (hc₁ : -1 / (n : ℝ) < c)
    (hc₂ : -(a / ((n : ℝ) - 1)) < c) :
    IntegrableOn (laguerreIntegrand hmn a c) (positiveOrthant n) volume ∧
      (∫ t in positiveOrthant n, laguerreIntegrand hmn a c t) =
        (∏ k : Fin m, (a + selbergIndex n (Fin.castLE hmn k) * c)) *
          (∏ k : Fin n,
            Real.Gamma (a + selbergIndex n k * c) *
              Real.Gamma (1 + (k.1 + 1 : ℝ) * c)) /
            (∏ _ : Fin n, Real.Gamma (1 + c))
```
:::
::::

::::dlmfEntry "5.14.6" "https://dlmf.nist.gov/5.14.E6"
For ` Re c > -1/n `,
$$` (2π)^(-n/2) ∫_(-∞,∞)ⁿ |Δ(t)|^(2c) ∏ₖ₌₁ⁿ exp(−tₖ²/2) dtₖ
 = ∏ₖ₌₁ⁿ Γ(1+kc) / Γ(1+c)^n. `$$

The declaration uses real ` c > -1/n ` and ` 0 < n `, hence it is the real,
positive-dimensional specialization of the source condition.  The whole space is ` Set.univ `
in ` Fin n → ℝ `, the Gaussian product is explicit, and Bochner integrability is recorded.
The Vandermonde power is totalized on its diagonal null set.

:::leanStatement "Lean statement · Gaussian Vandermonde integral"
```anchor gaussianVandermondeIntegrand (module := LMLF.Blueprint.Gamma.Section514) -showProofStates
def gaussianVandermondeIntegrand (n : ℕ) (c : ℝ) (t : Fin n → ℝ) : ℝ :=
  Real.rpow (|vandermonde n t|) (2 * c) *
    ∏ k : Fin n, Real.exp (-(1 / 2) * (t k) ^ 2)
```

```anchor dlmf_5_14_6 (module := LMLF.Blueprint.Gamma.Section514) -showProofStates
theorem dlmf_5_14_6 {n : ℕ} (hn : 0 < n) {c : ℝ}
    (hc : -1 / (n : ℝ) < c) :
    IntegrableOn (gaussianVandermondeIntegrand n c) Set.univ volume ∧
      (1 / (2 * Real.pi) ^ ((n : ℝ) / 2)) *
          (∫ t : Fin n → ℝ, gaussianVandermondeIntegrand n c t) =
        (∏ k : Fin n, Real.Gamma (1 + (k.1 + 1 : ℝ) * c)) /
          (∏ _ : Fin n, Real.Gamma (1 + c))
```
:::
::::

# Dyson's integral
%%%
number := false
%%%

::::dlmfEntry "5.14.7" "https://dlmf.nist.gov/5.14.E7"
For ` Re b > -1/n `, Dyson's integral is
$$` (2π)^(-n) ∫_[-π,π]ⁿ ∏₁≤ⱼ<ₖ≤ₙ |e^(iθⱼ)−e^(iθₖ)|^(2b) dθ₁⋯dθₙ
 = Γ(1+bn) / Γ(1+b)^n. `$$

The declaration takes real ` b ` and ` 0 < n `, so it is the real,
positive-dimensional specialization of the complex source parameter.  Complex exponentials
retain the source's unit-circle factors, while their norms and the real power ` 2*b ` make the
real-valued integrand explicit.  ` dysonCube n ` is ` [-π,π]ⁿ `, and its integrability is
stated with respect to volume.  The collision hyperplanes use the totalized real power as an
a.e. representative.

:::leanStatement "Lean statement · Dyson circular integral"
```anchor dysonIntegrand (module := LMLF.Blueprint.Gamma.Section514) -showProofStates
def dysonIntegrand (n : ℕ) (b : ℝ) (θ : Fin n → ℝ) : ℝ :=
  ∏ j : Fin n, ∏ k : Fin n, if j < k then
    Real.rpow (‖Complex.exp (Complex.I * (θ j : ℂ)) -
      Complex.exp (Complex.I * (θ k : ℂ))‖) (2 * b) else 1
```

```anchor dlmf_5_14_7 (module := LMLF.Blueprint.Gamma.Section514) -showProofStates
theorem dlmf_5_14_7 {n : ℕ} (hn : 0 < n) {b : ℝ}
    (hb : -1 / (n : ℝ) < b) :
    IntegrableOn (dysonIntegrand n b) (dysonCube n) volume ∧
      (1 / (2 * Real.pi) ^ (n : ℝ)) *
          (∫ θ in dysonCube n, dysonIntegrand n b θ) =
        Real.Gamma (1 + b * (n : ℝ)) /
          (∏ _ : Fin n, Real.Gamma (1 + b))
```
:::
::::
