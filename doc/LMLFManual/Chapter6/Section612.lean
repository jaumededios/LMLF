import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section612
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section612
set_option verso.exampleProject "."

#doc (Manual) "§6.12 Asymptotic Expansions" =>
%%%
tag := "chapter-6-section-12"
%%%

:::dlmfChapter "https://dlmf.nist.gov/6.12"
Source: NIST Digital Library of Mathematical Functions, §6.12, Asymptotic Expansions.
:::

# §6.12 Asymptotic Expansions
%%%
number := false
%%%

The DLMF presents these as Poincaré expansions: after every fixed finite
number of terms the remainder has the order of the first omitted term. The
phase restrictions are part of each statement; `z → ∞` means escape to infinity
inside the displayed sector. The declarations use the canonical §6.2 maps
`principalE1`, `realEi`, `principalAuxiliaryF`, and `principalAuxiliaryG`
directly, and use a `SectorMargin` to retain `0 < δ < angle` rather than
admitting an empty sector. Their asymptotic declarations use the shared
Chapter 2 `QuantitativeAnalysis.HasPoincareExpansion` relation: its index `n`
retains terms `0` through `n`, while the finite E5–E8 remainders retain the
source's first `n` terms and therefore keep the first-omitted-term index `n`.

## Exponential and logarithmic integrals
%%%
number := false
%%%

For `E₁(z)`, the expansion holds for `|ph z| ≤ 3π/2 − δ`, with
`0 < δ < 3π/2`, on the open principal-cut domain. This is the explicit
open-cut specialization of the principal-branch statement. The positive-real
expansion for `Ei(x)` uses the real part of the canonical §6.2 map `realEi` and
is stated as `x → +∞`. The first-neglected-term estimates are recorded
separately: E₁ has a unit factor for `|ph z| ≤ π/2` and a
`csc(|ph z|)` factor for `π/2 ≤ |ph z| < π`, with the same-sign property on
the positive axis. When the Ei expansion is retained through term index `n`,
the next term has index `n+1` and the remainder bound has factor
`1 + χ(n+1)`, where χ is the Gamma quotient from §9.7.3.

The same-sign Lean companions use the explicit `SameRealSign` convention:
both quantities are real and their product is nonnegative. Thus “same sign” is
read as “not opposite signs”; the totalized predicate also includes the case
where one of the values is zero.

::::dlmfEntry "6.12.1" "https://dlmf.nist.gov/6.12.E1"
$$`E_{1}(z)\sim e^{-z}z^{-1}\sum_{k\ge0}(-1)^k k!z^{-k}`$$
:::leanStatement "Poincaré expansion of E₁ in a sector"
```anchor dlmf_6_12_1 (module := LMLF.Blueprint.ExponentialIntegrals.Section612)
theorem dlmf_6_12_1 (δ : SectorMargin (3 * Real.pi / 2)) :
    principalE1 ∼ₚ[sectorAtInfinity (3 * Real.pi / 2) δ] e1Term
```
:::
::::

::::leanStatement "DLMF 6.12.1 first-neglected-term bounds"
```anchor dlmf_6_12_1_bounds (module := LMLF.Blueprint.ExponentialIntegrals.Section612)
theorem dlmf_6_12_1_bounds (n : ℕ) :
    (∀ z : ℂ, z ≠ 0 → ‖Complex.arg z‖ ≤ Real.pi / 2 →
      ‖e1Remainder n z‖ ≤ ‖e1Term n z‖) ∧
    (∀ z : ℂ, z ≠ 0 → Real.pi / 2 ≤ ‖Complex.arg z‖ →
      ‖Complex.arg z‖ < Real.pi →
      ‖e1Remainder n z‖ ≤
        realCsc (‖Complex.arg z‖) * ‖e1Term n z‖)
```
::::

::::leanStatement "DLMF 6.12.1 same-sign property on the positive ray"
```anchor dlmf_6_12_1_same_sign (module := LMLF.Blueprint.ExponentialIntegrals.Section612)
theorem dlmf_6_12_1_same_sign (n : ℕ) :
    ∀ x : ℝ, 0 < x →
      SameRealSign (e1Remainder n (x : ℂ)) (e1Term n (x : ℂ))
```
::::

::::dlmfEntry "6.12.2" "https://dlmf.nist.gov/6.12.E2"
$$`Ei(x)\sim e^x x^{-1}(1+1!x^{-1}+2!x^{-2}+\cdots)`$$
:::leanStatement "Poincaré expansion of Ei on the positive real axis"
```anchor dlmf_6_12_2 (module := LMLF.Blueprint.ExponentialIntegrals.Section612)
theorem dlmf_6_12_2 :
    ∀ n : ℕ, (fun x : ℝ => eiRemainder n x) =O[atTop]
      (eiTerm n)
```
:::
::::

::::leanStatement "DLMF 6.12.2 next-term bound"
```anchor dlmf_6_12_2_bound (module := LMLF.Blueprint.ExponentialIntegrals.Section612)
theorem dlmf_6_12_2_bound (n : ℕ) :
    ∀ x : ℝ, 0 < x →
      |eiRemainder (n + 1) x| ≤ (1 + chi (n + 1)) * eiTerm (n + 1) x
```
::::

## Sine and cosine integrals
%%%
number := false
%%%

The auxiliary functions `f` and `g` have expansions in
`|ph z| ≤ π − δ`, with `0 < δ < π`. Their even- and odd-factorial
coefficients are recorded explicitly. The declarations use the canonical
§6.2 maps `principalAuxiliaryF` and `principalAuxiliaryG`; their source
integral characterizations remain separate in §6.11.

::::dlmfEntry "6.12.3" "https://dlmf.nist.gov/6.12.E3"
$$`f(z)\sim z^{-1}(1-2!z^{-2}+4!z^{-4}-\cdots)`$$
:::leanStatement "Expansion of f"
```anchor dlmf_6_12_3 (module := LMLF.Blueprint.ExponentialIntegrals.Section612)
theorem dlmf_6_12_3 (δ : SectorMargin Real.pi) :
    principalAuxiliaryF ∼ₚ[sectorAtInfinity Real.pi δ] fTerm
```
:::
::::

::::dlmfEntry "6.12.4" "https://dlmf.nist.gov/6.12.E4"
$$`g(z)\sim z^{-2}(1-3!z^{-2}+5!z^{-4}-\cdots)`$$
:::leanStatement "Expansion of g"
```anchor dlmf_6_12_4 (module := LMLF.Blueprint.ExponentialIntegrals.Section612)
theorem dlmf_6_12_4 (δ : SectorMargin Real.pi) :
    principalAuxiliaryG ∼ₚ[sectorAtInfinity Real.pi δ] gTerm
```
:::
::::

For each `n = 0,1,2,…`, DLMF writes a finite expansion together with a named
remainder. These formulas are source-domain statements for `z ≠ 0`: the
displayed powers contain inverse powers of `z`. The Lean page gives the finite
sums `fPartial` and `gPartial`, then defines `fRemainder` and `gRemainder` as
the residual source objects. The definitions are totalized by Lean's field
division at `z = 0` for convenient reuse, but the DLMF formulas are read on the
explicit nonzero domain below. This keeps the notation used in E5–E8 tied to
the same canonical functions; E7 and E8 are the substantive integral
characterizations of those remainders.

::::dlmfEntry "6.12.5" "https://dlmf.nist.gov/6.12.E5"
$$`f(z)=z^{-1}\sum_{m=0}^{n-1}(-1)^m(2m)!z^{-2m}+R_n^{(f)}(z)`$$
:::leanStatement "Finite expansion for f"
```anchor dlmf_6_12_5 (module := LMLF.Blueprint.ExponentialIntegrals.Section612)
def fPartial (n : ℕ) (z : ℂ) : ℂ := ∑ k ∈ Finset.range n, fTerm k z
def fRemainder (n : ℕ) (z : ℂ) : ℂ := principalAuxiliaryF z - fPartial n z
```
:::
::::

::::leanStatement "Source domain of the finite f and g expansions"
```anchor dlmf_6_12_finite_domain (module := LMLF.Blueprint.ExponentialIntegrals.Section612)
def finiteExpansionDomain : Set ℂ := {z : ℂ | z ≠ 0}
```
::::

::::dlmfEntry "6.12.6" "https://dlmf.nist.gov/6.12.E6"
$$`g(z)=z^{-2}\sum_{m=0}^{n-1}(-1)^m(2m+1)!z^{-2m}+R_n^{(g)}(z)`$$
:::leanStatement "Finite expansion for g"
```anchor dlmf_6_12_6 (module := LMLF.Blueprint.ExponentialIntegrals.Section612)
def gPartial (n : ℕ) (z : ℂ) : ℂ := ∑ k ∈ Finset.range n, gTerm k z
def gRemainder (n : ℕ) (z : ℂ) : ℂ := principalAuxiliaryG z - gPartial n z
```
:::
::::

The exact remainder integrals require `Re z > 0`, which is the convergence
domain used by the formal statements. The powers are even for f and odd for g,
and the factor `(-1)^n` is outside the integral in both cases.

::::dlmfEntry "6.12.7" "https://dlmf.nist.gov/6.12.E7"
$$`R_n^{(f)}(z)=(-1)^n\int_0^\infty e^{-zt}t^{2n}(t^2+1)^{-1}dt`$$
:::leanStatement "Improper-integral remainder for f"
```anchor dlmf_6_12_7 (module := LMLF.Blueprint.ExponentialIntegrals.Section612)
theorem dlmf_6_12_7 (n : ℕ) (z : ℂ) (hz : 0 < z.re) :
    Section62.HasImproperIntegral
        (fun t : ℝ => Complex.exp (-(z * t)) * (t : ℂ) ^ (2 * n) /
          ((t : ℂ) ^ 2 + 1)) 0 ((-1 : ℂ) ^ n * fRemainder n z)
```
:::
::::

::::leanStatement "DLMF 6.12.7 first-neglected-term bounds"
```anchor dlmf_6_12_7_bounds (module := LMLF.Blueprint.ExponentialIntegrals.Section612)
theorem dlmf_6_12_7_bounds (n : ℕ) :
    (∀ z : ℂ, 0 < z.re → z ≠ 0 → ‖Complex.arg z‖ ≤ Real.pi / 4 →
      ‖fRemainder n z‖ ≤ ‖fTerm n z‖) ∧
    (∀ z : ℂ, 0 < z.re → z ≠ 0 → Real.pi / 4 ≤ ‖Complex.arg z‖ →
      ‖Complex.arg z‖ < Real.pi / 2 →
      ‖fRemainder n z‖ ≤
        realCsc (2 * ‖Complex.arg z‖) * ‖fTerm n z‖)
```
::::

::::leanStatement "DLMF 6.12.7 same-sign property on the positive ray"
```anchor dlmf_6_12_7_same_sign (module := LMLF.Blueprint.ExponentialIntegrals.Section612)
theorem dlmf_6_12_7_same_sign (n : ℕ) :
    ∀ x : ℝ, 0 < x →
      SameRealSign (fRemainder n (x : ℂ)) (fTerm n (x : ℂ))
```
::::

::::dlmfEntry "6.12.8" "https://dlmf.nist.gov/6.12.E8"
$$`R_n^{(g)}(z)=(-1)^n\int_0^\infty e^{-zt}t^{2n+1}(t^2+1)^{-1}dt`$$
:::leanStatement "Improper-integral remainder for g"
```anchor dlmf_6_12_8 (module := LMLF.Blueprint.ExponentialIntegrals.Section612)
theorem dlmf_6_12_8 (n : ℕ) (z : ℂ) (hz : 0 < z.re) :
    Section62.HasImproperIntegral
        (fun t : ℝ => Complex.exp (-(z * t)) * (t : ℂ) ^ (2 * n + 1) /
          ((t : ℂ) ^ 2 + 1)) 0 ((-1 : ℂ) ^ n * gRemainder n z)
```
:::
::::

::::leanStatement "DLMF 6.12.8 first-neglected-term bounds"
```anchor dlmf_6_12_8_bounds (module := LMLF.Blueprint.ExponentialIntegrals.Section612)
theorem dlmf_6_12_8_bounds (n : ℕ) :
    (∀ z : ℂ, 0 < z.re → z ≠ 0 → ‖Complex.arg z‖ ≤ Real.pi / 4 →
      ‖gRemainder n z‖ ≤ ‖gTerm n z‖) ∧
    (∀ z : ℂ, 0 < z.re → z ≠ 0 → Real.pi / 4 ≤ ‖Complex.arg z‖ →
      ‖Complex.arg z‖ < Real.pi / 2 →
      ‖gRemainder n z‖ ≤
        realCsc (2 * ‖Complex.arg z‖) * ‖gTerm n z‖)
```
::::

::::leanStatement "DLMF 6.12.8 same-sign property on the positive ray"
```anchor dlmf_6_12_8_same_sign (module := LMLF.Blueprint.ExponentialIntegrals.Section612)
theorem dlmf_6_12_8_same_sign (n : ℕ) :
    ∀ x : ℝ, 0 < x →
      SameRealSign (gRemainder n (x : ℂ)) (gTerm n (x : ℂ))
```
::::

::::dlmfEntry "§6.12(i) source note" "https://dlmf.nist.gov/6.12#i.info"
The source note points to Olver (1997b, p. 227) for the positive-real `Ei`
expansion recorded in E2.
::::

::::dlmfEntry "§6.12(i) E₁ remainder notes" "https://dlmf.nist.gov/6.12#i.p1"
For the first phase range, the source records the same-sign property on the
positive axis, the `csc(|ph z|)` factor in the outer phase range, and Olver's
remainder treatment on pp. 109–112 with α = 0. Re-expansions in larger sectors,
exponential improvement, and smooth Stokes transitions are referred to
§§2.11(ii)–(iv), with p = 1.
::::

::::dlmfEntry "§6.12(i) E2 remainder note" "https://dlmf.nist.gov/6.12#i.p2"
The source bounds the remainder after the retained term `n` by
`1 + χ(n+1)` times the next term `n+1`; χ is the Gamma quotient of §9.7(i).
::::

::::dlmfEntry "§6.12(i) logarithmic-integral note" "https://dlmf.nist.gov/6.12#i.p3"
The source notes that the asymptotic expansion of `li(x)` follows from §6.2.8
together with E2.
::::

::::dlmfEntry "§6.12(ii) derivation note" "https://dlmf.nist.gov/6.12#ii.info"
E3 and E4 follow from §6.7.13 and §6.7.14 by Watson's lemma (§2.4(i)).
E5–E8 use those identities together with the finite geometric identity
`(t^2+1)^(-1) = sum_(m=0)^(n-1) (-1)^m t^(2m) +
(-1)^n t^(2n) (t^2+1)^(-1)`. The error bounds arise after setting
`t = √τ`, rotating the integration path in the `τ`-plane through `-2 ph z`,
and replacing `|τ+1|` by its minimum.
::::

::::dlmfEntry "§6.12(ii) Si/Ci note" "https://dlmf.nist.gov/6.12#ii.p1"
The source gives the corresponding asymptotic expansions of `Si` and `Ci` in
§6.2.19 and §6.2.20 together with E3 and E4.
::::

::::dlmfEntry "§6.12(ii) remainder note" "https://dlmf.nist.gov/6.12#ii.p2"
The remainder terms used in the finite expansions are given by E5–E8.
::::

::::dlmfEntry "§6.12(ii) phase and improvement note" "https://dlmf.nist.gov/6.12#ii.p3"
For `|ph z| ≤ π/4`, the f and g remainders are bounded in magnitude by their
respective first neglected terms and have the same signs as those terms when
`ph z = 0`; for `π/4 ≤ |ph z| < π/2`, they are bounded by
`csc(2|ph z|)` times the respective first neglected terms. Other phase ranges
are referred to §6.4.6 and §6.4.7. Exponentially improved forms are referred
to §6.5.5 and §6.5.6 together with §6.12(i).
::::

The csc bounds and the `χ` factor are separate quantitative controls rather
than additional asymptotic identities.

end LMLFManual.Chapter6
