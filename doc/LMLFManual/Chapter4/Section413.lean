import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section413
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.Elementary.Section413

set_option verso.exampleProject "."

#doc (Manual) "§4.13 Lambert W-Function" =>
%%%
tag := "chapter-4-section-13"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.13"
Source: NIST Digital Library of Mathematical Functions, §4.13.
:::

# §4.13 Lambert W-Function
%%%
number := false
%%%

The Lambert function is multivalued: a value `w` satisfies `w exp w = z`.
The principal branch `W₀` is analytic on the complement of the excluded cut
`(-∞,-e⁻¹]`; the other branches are analytic on the complement of `(-∞,0]`.
The `LambertBoundaryBranch` API keeps the upper/lower `W_{±1}` boundary side
as an explicit argument of `boundaryValue`, records the corresponding
one-sided trace from the analytic branch (`W_{+1}` from below and `W_{-1}`
from above), and enforces the nonprincipal cut.  The asymptotic declarations require an indexed analytic branch whose
positive-real values eventually lie in the logarithmic strip around `2πk`;
this strip is the branch normalization, not merely an integer label.

::::dlmfEntry "4.13.1" "https://dlmf.nist.gov/4.13.E1"
For every complex `z`, the defining equation asks for a value `w` with
`w exp w = z`.
$$`W e^W=z`$$
:::leanStatement "DLMF 4.13.E1"
```anchor dlmf_4_13_1 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E1: a selected Lambert branch satisfies the defining equation. -/
theorem dlmf_4_13_1 (W : LambertBranch) (z : ℂ) (hz : z ∉ W.cut) :
    W.value z * Complex.exp (W.value z) = z
```
:::
::::

::::dlmfEntry "4.13.1-1" "https://dlmf.nist.gov/4.13.E1_1"
For branch index `k`, the large-argument expansion begins with
`lnₖ z - ln(lnₖ z)` and is recorded as asymptotic equivalence along the
explicit large-argument filter eventually inside the selected branch's cut
domain.  The indexed branch hypothesis includes eventual positive-real
logarithmic-strip normalization around `2πk`, which identifies the actual
`W_k` branch.
$$`W_k(z)=\operatorname{ln}_k(z)-\ln(\operatorname{ln}_k(z))+o(1)`$$
:::leanStatement "DLMF 4.13.E1_1"
```anchor dlmf_4_13_1_1 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E1_1: the additive branch expansion with an o(1) remainder. -/
theorem dlmf_4_13_1_1 (Wk : ℤ → LambertBranch) (k : ℤ) (l : Filter ℂ)
    (hbranch : indexedLambertBranch (Wk k) k)
    (hregime : l ≤ cocompact ℂ ∧ NeBot l ∧ ∀ᶠ z in l, z ∉ (Wk k).cut) :
    (fun z => (Wk k).value z - firstWExpansion k z) =o[l] (fun _ => (1 : ℂ))
```
:::
::::

::::dlmfEntry "4.13.1-2" "https://dlmf.nist.gov/4.13.E1_2"
The Wright omega function satisfies `ω + log ω = z`.
$$`\omega(z)+\ln(\omega(z))=z`$$
:::leanStatement "DLMF 4.13.E1_2"
```anchor dlmf_4_13_1_2 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E1_2: the selected Wright omega equation. -/
theorem dlmf_4_13_1_2 (ω : WrightOmega) (z : ℂ) :
    ω.value z + Complex.log (ω.value z) = z
```
:::
::::

::::dlmfEntry "4.13.1-3" "https://dlmf.nist.gov/4.13.E1_3"
The tree function satisfies `t exp(-t) = z`.
$$`T e^{-T}=z`$$
:::leanStatement "DLMF 4.13.E1_3"
```anchor dlmf_4_13_1_3 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E1_3: the selected tree-function equation. -/
theorem dlmf_4_13_1_3 (T : TreeFunction) (z : ℂ) :
    T.value z * Complex.exp (-T.value z) = z
```
:::
::::

::::dlmfEntry "4.13.2" "https://dlmf.nist.gov/4.13.E2"
At `-e⁻¹`, `0`, and `e`, the principal values are `-1`, `0`, and `1`; the
selected upper/lower nonprincipal boundary branch also takes the signed
branch-point value `-1`.  Because the principal branch cut contains
`-e⁻¹`, the Lean disclosure makes this endpoint normalization an explicit
hypothesis rather than deriving it from the off-cut Lambert equation.
$$`W_0(-e^{-1})=W_{\pm1}(-e^{-1}\mp0i)=-1,\qquad W_0(0)=0,\qquad W_0(e)=1`$$
:::leanStatement "DLMF 4.13.E2"
```anchor dlmf_4_13_2 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E2: principal and signed boundary-branch special values. -/
theorem dlmf_4_13_2 (W₀ : LambertBranch) (Wpm : LambertBoundaryBranch)
    (hprincipal : principalBranch W₀)
    (hbranchPoint : W₀.value branchPoint = -1)
    (hprincipalRange : ∀ x : ℝ, -Real.exp (-1) ≤ x → -1 ≤ (W₀.value x).re) :
    W₀.value branchPoint = -1 ∧
      Wpm.boundaryValue Wpm.side (-Real.exp (-1)) = -1 ∧
      W₀.value 0 = 0 ∧ W₀.value (Real.exp 1) = 1
```
:::
::::

::::dlmfEntry "4.13.3" "https://dlmf.nist.gov/4.13.E3"
The original E3 record is retained as the Wright-omega equation; the source
page now cross-references its moved display E1-2.
$$`\omega(z)+\ln(\omega(z))=z`$$
:::leanStatement "DLMF 4.13.E3"
```anchor dlmf_4_13_3 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E3: the moved Wright omega relation. -/
theorem dlmf_4_13_3 (ω : WrightOmega) (z : ℂ) :
    ω.value z + Complex.log (ω.value z) = z
```
:::
::::

::::dlmfEntry "4.13.3-1" "https://dlmf.nist.gov/4.13.E3_1"
On the real regime `x ≥ -1`, the principal real branch selects the solution
`W₀(x eˣ) = x`; the declaration carries both the Lambert equation and the
principal range condition.
$$`W_0(xe^x)=\begin{cases}x,&-1\le x,\\\text{no simpler form},&x<-1.\end{cases}`$$
:::leanStatement "DLMF 4.13.E3_1"
```anchor dlmf_4_13_3_1 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E3_1: the principal real simplification for x ≥ -1. -/
theorem dlmf_4_13_3_1 (W₀ : LambertBranch) (x : ℝ) (hx : -1 ≤ x)
    (hprincipal : principalBranch W₀)
    (hEq : W₀.value ((x : ℂ) * Complex.exp x) *
      Complex.exp (W₀.value ((x : ℂ) * Complex.exp x)) =
        (x : ℂ) * Complex.exp x)
    (hRange : -1 ≤ (W₀.value ((x : ℂ) * Complex.exp x)).re) :
    W₀.value ((x : ℂ) * Complex.exp x) = x
```
:::
::::

::::dlmfEntry "4.13.3-2" "https://dlmf.nist.gov/4.13.E3_2"
For `x < -1`, a side-indexed nonprincipal boundary branch selects
`W_{±1}(x eˣ ∓ 0i) = x`.  The `BoundarySide` value fixes both the branch
index and the opposite one-sided approach to the cut; its trace is therefore
not an arbitrary side-indexed root.
$$`W_{\pm1}(xe^x\mp0i)=\begin{cases}\text{no simpler form},&-1\le x,\\x,&x<-1.\end{cases}`$$
:::leanStatement "DLMF 4.13.E3_2"
```anchor dlmf_4_13_3_2 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E3_2: the signed W_{±1} simplification for x < -1. -/
theorem dlmf_4_13_3_2 (Wpm : LambertBoundaryBranch) (x : ℝ) (hx : x < -1)
    : Wpm.boundaryValue Wpm.side (x * Real.exp x) = x
```
:::
::::

::::dlmfEntry "4.13.4" "https://dlmf.nist.gov/4.13.E4"
Away from `z = 0` and `W = -1`, implicit differentiation gives
`W' = exp(-W)/(1+W) = W/(z(1+W))`.
$$`\frac{\mathrm dW}{\mathrm dz}=\frac{e^{-W}}{1+W}=\frac{W}{z(1+W)}`$$
:::leanStatement "DLMF 4.13.E4"
```anchor dlmf_4_13_4 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E4: derivative of a selected branch away from zero and -1. -/
theorem dlmf_4_13_4 (W : LambertBranch) (z : ℂ)
    (hz : z ∉ W.cut ∧ z ≠ 0) (hW : W.value z ≠ -1)
    (hderiv : HasDerivAt W.value (Complex.exp (-(W.value z)) / (1 + W.value z)) z) :
    deriv W.value z = Complex.exp (-(W.value z)) / (1 + W.value z) ∧
      Complex.exp (-(W.value z)) / (1 + W.value z) =
        W.value z / (z * (1 + W.value z))
```
:::
::::

::::dlmfEntry "4.13.4-1" "https://dlmf.nist.gov/4.13.E4_1"
For `n ≥ 1`, the nth derivative has the polynomial form
`exp(-nW) p_(n-1)(W)/(1+W)^(2n-1)`.
$$`\frac{\mathrm d^nW}{\mathrm dz^n}=\frac{e^{-nW}p_{n-1}(W)}{(1+W)^{2n-1}}`$$
:::leanStatement "DLMF 4.13.E4_1"
```anchor dlmf_4_13_4_1 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E4_1: the nth derivative with the canonical p_{n-1}. -/
theorem dlmf_4_13_4_1 (W : LambertBranch) (n : ℕ) (z : ℂ)
    (hn : 1 ≤ n) (hz : z ∉ W.cut) (hW : W.value z ≠ -1)
    (hregular : ContDiffAt ℂ n W.value z) :
    iteratedDeriv n W.value z =
      Complex.exp (-(n : ℂ) * W.value z) *
        derivativePolynomial (n - 1) (W.value z) /
          (1 + W.value z) ^ (2 * n - 1)
```
:::
::::

::::dlmfEntry "4.13.4-2" "https://dlmf.nist.gov/4.13.E4_2"
The derivative polynomials start at `p₀ = 1` and satisfy the displayed
derivative recurrence for every positive index.
$$`p_0(x)=1,\qquad p_n(x)=(1+x)p'_{n-1}(x)+(1-n(x+3))p_{n-1}(x)`$$
:::leanStatement "DLMF 4.13.E4_2"
```anchor dlmf_4_13_4_2 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E4_2: initial value and recurrence for p_n. -/
theorem dlmf_4_13_4_2 :
    derivativePolynomial 0 = (fun _ => 1) ∧
      ∀ n, 1 ≤ n → ∀ x,
        derivativePolynomial n x =
          (1 + x) * deriv (derivativePolynomial (n - 1)) x +
            (1 - (n : ℂ) * (x + 3)) * derivativePolynomial (n - 1) x
```
:::
::::

::::dlmfEntry "4.13.5" "https://dlmf.nist.gov/4.13.E5"
For `|z| < e⁻¹`, the principal branch has the Maclaurin series beginning at
`n = 1`, with coefficient `(-n)^(n-1)/n!`.
$$`W_0(z)=\sum_{n=1}^{\infty}\frac{(-n)^{n-1}}{n!}z^n`$$
:::leanStatement "DLMF 4.13.E5"
```anchor dlmf_4_13_5 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E5: the principal Maclaurin series, beginning at n = 1. -/
theorem dlmf_4_13_5 (W₀ : LambertBranch) (z : ℂ)
    (hz : z ∉ W₀.cut ∧ ‖z‖ < Real.exp (-1))
    (hprincipal : principalBranch W₀)
    (hbranch : W₀.value z * Complex.exp (W₀.value z) = z) :
    W₀.value z = ∑' n : ℕ, lambertMaclaurinCoeff n * z ^ n
```
:::
::::

::::dlmfEntry "4.13.5-1" "https://dlmf.nist.gov/4.13.E5_1"
For `a ∈ ℂ`, `|z| < e⁻¹`, and `z ≠ 0`, the parameterized power identity and
its convergent series are stated together.
$$`\left(\frac{W_0(z)}z\right)^a=e^{-aW_0(z)}=\sum_{n=0}^{\infty}\frac{a(n+a)^{n-1}}{n!}(-z)^n`$$
:::leanStatement "DLMF 4.13.E5_1"
```anchor dlmf_4_13_5_1 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E5_1: the parameterized principal series. -/
theorem dlmf_4_13_5_1 (W₀ : LambertBranch) (a z : ℂ)
    (hz : z ≠ 0 ∧ ‖z‖ < Real.exp (-1) ∧ z ∉ W₀.cut)
    (hprincipal : principalBranch W₀)
    (hbranch : W₀.value z * Complex.exp (W₀.value z) = z) :
    (W₀.value z / z) ^ a = Complex.exp (-a * W₀.value z) ∧
      Complex.exp (-a * W₀.value z) =
        ∑' n : ℕ, lambertParameterCoeff a n * (-z) ^ n
```
:::
::::

::::dlmfEntry "4.13.5-2" "https://dlmf.nist.gov/4.13.E5_2"
The reciprocal identity uses the `n = 0` series with coefficient `nⁿ/n!`.
$$`\frac1{1+W_0(-z)}=\sum_{n=0}^{\infty}\frac{n^n}{n!}z^n`$$
:::leanStatement "DLMF 4.13.E5_2"
```anchor dlmf_4_13_5_2 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E5_2: the reciprocal principal series. -/
theorem dlmf_4_13_5_2 (W₀ : LambertBranch) (z : ℂ)
    (hz : ‖z‖ < Real.exp (-1) ∧ -z ∉ W₀.cut)
    (hprincipal : principalBranch W₀)
    (hbranch : W₀.value (-z) * Complex.exp (W₀.value (-z)) = -z) :
    1 / (1 + W₀.value (-z)) =
      ∑' n : ℕ, ((n : ℂ) ^ n / (n.factorial : ℂ)) * z ^ n
```
:::
::::

::::dlmfEntry "4.13.5-3" "https://dlmf.nist.gov/4.13.E5_3"
The added square series starts at `n = 1` and has coefficient `n^(n-2)/n!`.
$$`(1+W_0(z))^2=1-2\sum_{n=1}^{\infty}\frac{n^{n-2}}{n!}(-z)^n`$$
:::leanStatement "DLMF 4.13.E5_3"
```anchor dlmf_4_13_5_3 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E5_3: the principal square series. -/
theorem dlmf_4_13_5_3 (W₀ : LambertBranch) (z : ℂ)
    (hz : ‖z‖ < Real.exp (-1) ∧ z ∉ W₀.cut)
    (hprincipal : principalBranch W₀)
    (hbranch : W₀.value z * Complex.exp (W₀.value z) = z) :
    (1 + W₀.value z) ^ 2 =
      1 - 2 * ∑' n : ℕ, lambertSquareCoeff n * (-z) ^ n
```
:::
::::

::::dlmfEntry "4.13.6" "https://dlmf.nist.gov/4.13.E6"
The branch-point expansion at `-e^(-1-t²/2)` uses the signed branch selected
by `t ≥ 0` or `t < 0` and has radius `|t| < 2√π`.
$$`W(-e^{-1-t^2/2})=\sum_{n=0}^{\infty}(-1)^{n-1}c_nt^n`$$
:::leanStatement "DLMF 4.13.E6"
```anchor dlmf_4_13_6 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E6: the signed branch-point expansion for |t| < 2 sqrt pi. -/
theorem dlmf_4_13_6 (W₀ : LambertBranch) (Wpm : LambertBoundaryBranch)
    (c : BranchPointCoefficients) (t : ℝ)
    (ht : ‖t‖ < 2 * Real.sqrt Real.pi)
    (hprincipal : principalBranch W₀)
    (hEq₀ : W₀.value ((-Real.exp (-1 - t ^ 2 / 2) : ℝ) : ℂ) *
      Complex.exp (W₀.value ((-Real.exp (-1 - t ^ 2 / 2) : ℝ) : ℂ)) =
        (-Real.exp (-1 - t ^ 2 / 2) : ℝ))
    (hEqpm : Wpm.boundaryValue Wpm.side (-Real.exp (-1 - t ^ 2 / 2)) *
      Complex.exp (Wpm.boundaryValue Wpm.side (-Real.exp (-1 - t ^ 2 / 2))) =
        (-Real.exp (-1 - t ^ 2 / 2) : ℝ))
    (hRange₀ : 0 ≤ t → -1 ≤
      (W₀.value ((-Real.exp (-1 - t ^ 2 / 2) : ℝ) : ℂ)).re)
    (hRangePm : t ≤ 0 → -1 ≥
      (Wpm.boundaryValue Wpm.side (-Real.exp (-1 - t ^ 2 / 2))).re) :
    (if 0 ≤ t then W₀.value ((-Real.exp (-1 - t ^ 2 / 2) : ℝ) : ℂ)
      else Wpm.boundaryValue Wpm.side (-Real.exp (-1 - t ^ 2 / 2))) =
      ∑' n : ℕ, (-1 : ℂ) ^ ((n : ℤ) - 1) * (c.value n : ℂ) * (t : ℂ) ^ n
```
:::
::::

::::dlmfEntry "4.13.7" "https://dlmf.nist.gov/4.13.E7"
The first coefficients are `c₀ = 1`, `c₁ = 1`, `c₂ = 1/3`, `c₃ = 1/36`, and
`c₄ = -1/270`.
$$`c_0=1,\quad c_1=1,\quad c_2=\tfrac13,\quad c_3=\tfrac1{36},\quad c_4=-\tfrac1{270}`$$
:::leanStatement "DLMF 4.13.E7"
```anchor dlmf_4_13_7 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E7: initial values of the branch-point coefficients. -/
theorem dlmf_4_13_7 (c : BranchPointCoefficients) :
    c.value 0 = 1 ∧ c.value 1 = 1 ∧ c.value 2 = 1 / 3 ∧
      c.value 3 = 1 / 36 ∧ c.value 4 = -(1 / 270)
```
:::
::::

::::dlmfEntry "4.13.8" "https://dlmf.nist.gov/4.13.E8"
The coefficients satisfy the finite convolution recurrence for every `n ≥ 2`.
$$`c_n=\frac{c_{n-1}}{n+1}-\frac12\sum_{k=2}^{n-1}c_kc_{n+1-k}`$$
:::leanStatement "DLMF 4.13.E8"
```anchor dlmf_4_13_8 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E8: recurrence of the branch-point coefficients. -/
theorem dlmf_4_13_8 (c : BranchPointCoefficients) :
    ∀ n, 2 ≤ n →
      c.value n = c.value (n - 1) / (n + 1) -
        (1 / 2) * Finset.sum (Finset.Icc 2 (n - 1))
          (fun k => c.value k * c.value (n + 1 - k))
```
:::
::::

::::dlmfEntry "4.13.9" "https://dlmf.nist.gov/4.13.E9"
The source's imported `gₙ` sequence is constrained to the named
`branchPointG(c,n)` values by the product `1·3·…·(2n+1)`.
$$`1\cdot3\cdot5\cdots(2n+1)c_{2n+1}=g_n`$$
:::leanStatement "DLMF 4.13.E9"
```anchor dlmf_4_13_9 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E9: relation to the named branchPointG sequence. -/
theorem dlmf_4_13_9 (c : BranchPointCoefficients) (g : ℕ → ℚ)
    (hG : ∀ n, g n = branchPointG c n) :
    ∀ n : ℕ,
      (Finset.prod (Finset.Icc 0 n) (fun j => (2 * (j : ℚ) + 1))) *
          c.value (2 * n + 1) = g n
```
:::
::::

::::dlmfEntry "4.13.9-1" "https://dlmf.nist.gov/4.13.E9_1"
Near the square-root branch point, `W₀(z)` expands in powers of
`(e z + 1)^(1/2)` under `|e z+1|<1` and the principal phase restriction.
$$`W_0(z)=\sum_{n=0}^{\infty}d_n(ez+1)^{n/2}`$$
:::leanStatement "DLMF 4.13.E9_1"
```anchor dlmf_4_13_9_1 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E9_1: the principal square-root branch-point series. -/
theorem dlmf_4_13_9_1 (W₀ : LambertBranch) (d : BranchPointDCoefficients) (z : ℂ)
    (hz : ‖Real.exp 1 * z + 1‖ < 1 ∧ z ∉ W₀.cut)
    (hphase : ‖(z + (Real.exp (-1) : ℂ)).arg‖ < Real.pi)
    (hprincipal : principalBranch W₀)
    (hbranch : W₀.value z * Complex.exp (W₀.value z) = z) :
    W₀.value z =
      ∑' n : ℕ, (d.value n : ℂ) *
        (Real.exp 1 * z + 1) ^ ((n : ℂ) / 2)
```
:::
::::

::::dlmfEntry "4.13.9-2" "https://dlmf.nist.gov/4.13.E9_2"
The branch-point coefficients `d₀` through `d₄` and their convolution
recurrence are recorded explicitly.
$$`d_0=-1,\quad d_1=\sqrt2,\quad d_2=-\tfrac23,\quad d_3=\tfrac{11}{36}\sqrt2,\quad d_4=-\tfrac{43}{135}`$$
$$`(n+2)d_1d_{n+1}=-2d_n+\frac n2\sum_{k=1}^{n-1}d_kd_{n-k}-\frac{n+2}{2}\sum_{k=1}^{n-1}d_{k+1}d_{n-k+1}`$$
:::leanStatement "DLMF 4.13.E9_2"
```anchor dlmf_4_13_9_2 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E9_2: initial values and recurrence of d_n. -/
theorem dlmf_4_13_9_2 (d : BranchPointDCoefficients) :
    d.value 0 = -1 ∧ d.value 1 = Real.sqrt 2 ∧
      d.value 2 = -(2 / 3) ∧ d.value 3 = (11 / 36) * Real.sqrt 2 ∧
      d.value 4 = -(43 / 135) ∧
      ∀ (n : ℕ), 1 ≤ n →
        ((n : ℝ) + 2) * d.value 1 * d.value (n + 1) =
          -2 * d.value n +
            ((n : ℝ) / 2) * Finset.sum (Finset.Icc 1 (n - 1))
              (fun k => d.value k * d.value (n - k)) -
            (((n : ℝ) + 2) / 2) * Finset.sum (Finset.Icc 1 (n - 1))
              (fun k => d.value (k + 1) * d.value (n - k + 1))
```
:::
::::

::::dlmfEntry "4.13.10" "https://dlmf.nist.gov/4.13.E10"
As `|z| → ∞`, the branch `Wₖ` is asymptotic to the complete Stirling-cycle
series in `ξₖ = log z + 2πik`.
$$`W_k(z)\sim\xi_k-\ln\xi_k+\sum_{n=1}^{\infty}\frac{(-1)^n}{\xi_k^n}\sum_{m=1}^n\left[{n\atop n-m+1}\right]\frac{(-\ln\xi_k)^m}{m!}`$$
:::leanStatement "DLMF 4.13.E10"
```anchor dlmf_4_13_10 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E10: complete Poincare expansion through every finite order. -/
theorem dlmf_4_13_10 (Wk : ℤ → LambertBranch) (k : ℤ) (l : Filter ℂ)
    (hbranch : indexedLambertBranch (Wk k) k)
    (hregime : l ≤ cocompact ℂ ∧ NeBot l ∧ ∀ᶠ z in l, z ∉ (Wk k).cut) :
    ∀ N : ℕ,
      (fun z => (Wk k).value z - largeWPartial k z N) =O[l]
        (fun z => (largeWScale k z N : ℂ))
```
:::
::::

::::dlmfEntry "4.13.11" "https://dlmf.nist.gov/4.13.E11"
As `x → 0⁻`, the signed `W_{±1}(x ∓ 0i)` branches are asymptotic to the
corresponding expansion in `η = log(-1/x)`.
$$`W_{\pm1}(x\mp0i)\sim-\eta-\ln\eta+\sum_{n=1}^{\infty}\frac1{\eta^n}\sum_{m=1}^n\left[{n\atop n-m+1}\right]\frac{(-\ln\eta)^m}{m!}`$$
:::leanStatement "DLMF 4.13.E11"
```anchor dlmf_4_13_11 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E11: the signed W_{±1} expansion as x approaches zero from below. -/
theorem dlmf_4_13_11 (Wpm : LambertBoundaryBranch) (l : Filter ℝ)
    (hregime : l = nhdsWithin 0 (Iio 0))
    : ∀ N : ℕ,
      (fun x => Wpm.boundaryValue Wpm.side x - negativeWPartial x N) =O[l]
        (fun x => (negativeWScale x N : ℂ))
```
:::
::::

::::dlmfEntry "4.13.12" "https://dlmf.nist.gov/4.13.E12"
With an antiderivative convention, integrating `W(z)` gives
`z/W(z) + zW(z) - z`, up to an additive constant.
$$`\int W(z)\,\mathrm dz=\frac z{W(z)}+zW(z)-z`$$
:::leanStatement "DLMF 4.13.E12"
```anchor dlmf_4_13_12 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E12: an antiderivative on a nonzero selected-branch domain. -/
theorem dlmf_4_13_12 (W : LambertBranch) (D : Set ℂ) (F : ℂ → ℂ)
    (hprincipal : principalBranch W)
    (hanalytic : analyticLambertBranch W)
    (hD : D = principalCutᶜ \ {0})
    (hW : ∀ z, z ∈ D → W.value z ≠ 0)
    (hF : ∀ z, z ∈ D → HasDerivAt F (W.value z) z) :
    ∃ C : ℂ, ∀ z, z ∈ D → F z = z / W.value z + z * W.value z - z + C
```
:::
::::

::::dlmfEntry "4.13.13" "https://dlmf.nist.gov/4.13.E13"
Away from `z = 0`, integrating `W(z)/z` gives `W(z)^2/2 + W(z)`, up to a
constant.
$$`\int\frac{W(z)}z\,\mathrm dz=\tfrac12W(z)^2+W(z)`$$
:::leanStatement "DLMF 4.13.E13"
```anchor dlmf_4_13_13 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E13: an antiderivative of W z / z on the nonzero domain. -/
theorem dlmf_4_13_13 (W : LambertBranch) (D : Set ℂ) (F : ℂ → ℂ)
    (hprincipal : principalBranch W)
    (hanalytic : analyticLambertBranch W)
    (hD : D = principalCutᶜ \ {0})
    (hW : ∀ z, z ∈ D → W.value z ≠ 0)
    (hF : ∀ z, z ∈ D → HasDerivAt F (W.value z / z) z) :
    ∃ C : ℂ, ∀ z, z ∈ D → F z = (W.value z) ^ 2 / 2 + W.value z + C
```
:::
::::

::::dlmfEntry "4.13.14" "https://dlmf.nist.gov/4.13.E14"
Integrating `sin(W(z))` gives the displayed trigonometric expression, with the
same nonzero-branch convention and an additive constant.
$$`2\int\sin(W(z))\,\mathrm dz=z\left(1+\frac1{W(z)}\right)\sin(W(z))-z\cos(W(z))`$$
:::leanStatement "DLMF 4.13.E14"
```anchor dlmf_4_13_14 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E14: an antiderivative of sin(W z) on the nonzero domain. -/
theorem dlmf_4_13_14 (W : LambertBranch) (D : Set ℂ) (F : ℂ → ℂ)
    (hprincipal : principalBranch W)
    (hanalytic : analyticLambertBranch W)
    (hD : D = principalCutᶜ \ {0})
    (hW : ∀ z, z ∈ D → W.value z ≠ 0)
    (hF : ∀ z, z ∈ D → HasDerivAt F (Complex.sin (W.value z)) z) :
    ∃ C : ℂ, ∀ z, z ∈ D →
      2 * F z = z * (1 + 1 / W.value z) * Complex.sin (W.value z) -
        z * Complex.cos (W.value z) + C
```
:::
::::

::::dlmfEntry "4.13.15" "https://dlmf.nist.gov/4.13.E15"
Off the principal excluded cut, the principal branch has the finite integral
representation over `0 ≤ t ≤ π` involving `tan`, `sin`, and `exp`.
The Lean `IntervalIntegrable` hypothesis deliberately records the totalized
Lean integrand convention at endpoint quotients and requires the displayed
finite interval integral to exist; it does not silently identify those
totalized endpoint values with an unproved improper-limit calculation.
$$`W_0(z)=\frac z\pi\int_0^\pi\frac{(1-t\cot t)^2+t^2}{z+te^{-t\cot t}\csc t}\,\mathrm dt`$$
:::leanStatement "DLMF 4.13.E15"
```anchor dlmf_4_13_15 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E15: the principal finite integral representation. -/
theorem dlmf_4_13_15 (W₀ : LambertBranch) (z : ℂ) (hz : z ∉ principalCut)
    (hprincipal : principalBranch W₀) (hanalytic : analyticLambertBranch W₀)
    (hI : IntervalIntegrable (fun t : ℝ =>
      (((1 - (t : ℂ) / Complex.tan (t : ℂ)) ^ 2 + (t : ℂ) ^ 2) /
        (z + (t : ℂ) * Complex.exp (-(t : ℂ) / Complex.tan (t : ℂ)) /
      Complex.sin (t : ℂ)))) MeasureTheory.volume 0 Real.pi) :
    W₀.value z = z / Real.pi *
      (∫ t in (0 : ℝ)..Real.pi,
        (((1 - (t : ℂ) / Complex.tan (t : ℂ)) ^ 2 + (t : ℂ) ^ 2) /
          (z + (t : ℂ) * Complex.exp (-(t : ℂ) / Complex.tan (t : ℂ)) /
            Complex.sin (t : ℂ))))
```
:::
::::

::::dlmfEntry "4.13.16" "https://dlmf.nist.gov/4.13.E16"
The second principal representation is the logarithmic integral over the same
interval, with the principal complex logarithm.
Here too, `IntervalIntegrable` is an explicit totalized Lean-domain guard for
the endpoint quotient and principal logarithm; the source's removable or
improper endpoint interpretation is disclosed rather than assumed by
totalized division.
$$`W_0(z)=\frac1\pi\int_0^\pi\ln\left(1+z\frac{\sin t}{t}e^{t\cot t}\right)\,\mathrm dt`$$
:::leanStatement "DLMF 4.13.E16"
```anchor dlmf_4_13_16 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13.E16: the principal logarithmic integral representation. -/
theorem dlmf_4_13_16 (W₀ : LambertBranch) (z : ℂ) (hz : z ∉ principalCut)
    (hprincipal : principalBranch W₀) (hanalytic : analyticLambertBranch W₀)
    (hI : IntervalIntegrable (fun t : ℝ =>
      Complex.log (1 + z * Complex.sin (t : ℂ) / (t : ℂ) *
        Complex.exp ((t : ℂ) / Complex.tan (t : ℂ)))) MeasureTheory.volume 0 Real.pi) :
    W₀.value z = 1 / Real.pi *
      (∫ t in (0 : ℝ)..Real.pi,
        Complex.log (1 + z * Complex.sin (t : ℂ) / (t : ℂ) *
          Complex.exp ((t : ℂ) / Complex.tan (t : ℂ))))
```
:::
::::


## Source proof sketches

The sketch after [E3-1](https://dlmf.nist.gov/4.13.E3_1) starts with a principal-branch value `x = W₀(t)` in the real regime, substitutes the defining relation `t = x exp x`, and then applies the principal selector at `x exp x`.  The signed sketch after [E3-2](https://dlmf.nist.gov/4.13.E3_2) makes the same substitution on the selected `W_{±1}` boundary side.  The sketch after [E9-1](https://dlmf.nist.gov/4.13.E9_1) substitutes the square-root series into the differential equation `z(1+W)W' = W`; the anchored declarations record these substitutions with the relevant branch and series hypotheses.

:::leanStatement "Proof-sketch substitutions"
```anchor dlmf_4_13_proof_E3_1 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13 proof sketch after E3_1: substitution into the principal branch. -/
theorem dlmf_4_13_proof_E3_1 (W₀ : LambertBranch) (t x : ℂ)
    (hx : x = W₀.value t)
    (hEq : W₀.value t * Complex.exp (W₀.value t) = t)
    (hSelector : W₀.value (x * Complex.exp x) = x) :
    x * Complex.exp x = t ∧ W₀.value (x * Complex.exp x) = x
```
```anchor dlmf_4_13_proof_E3_2 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13 proof sketch after E3_2: substitution on a signed side. -/
theorem dlmf_4_13_proof_E3_2 (Wpm : LambertBoundaryBranch) (t x : ℝ)
    (hx : x = Wpm.boundaryValue Wpm.side t)
    (hEq : Wpm.boundaryValue Wpm.side t * Complex.exp (Wpm.boundaryValue Wpm.side t) = t)
    (hSelector : Wpm.boundaryValue Wpm.side (x * Real.exp x) = x) :
    x * Real.exp x = t ∧ Wpm.boundaryValue Wpm.side (x * Real.exp x) = x
```
```anchor dlmf_4_13_proof_E9_1 (module := LMLF.Blueprint.Elementary.Section413)
/-- DLMF 4.13 proof sketch after E9_1: substitution into z(1+W)W' = W. -/
theorem dlmf_4_13_proof_E9_1 (W₀ : LambertBranch) (d : BranchPointDCoefficients)
    (z : ℂ)
    (hz : ‖Real.exp 1 * z + 1‖ < 1 ∧ z ∉ W₀.cut)
    (hprincipal : principalBranch W₀)
    (hseries : W₀.value z = branchPointSeries d z)
    (hderiv : HasDerivAt W₀.value (deriv W₀.value z) z)
    (hseriesDeriv : deriv W₀.value z = deriv (branchPointSeries d) z)
    (hode : z * (1 + W₀.value z) * deriv W₀.value z = W₀.value z) :
    z * (1 + branchPointSeries d z) * deriv (branchPointSeries d) z =
      branchPointSeries d z
```
:::

::::dlmfEntry "Figure 4.13.1" "https://dlmf.nist.gov/4.13.F1"
Figure 4.13.1 plots the principal real branch `W₀(x)` and the signed boundary
branches `W_{±1}(x ∓ 0i)`, including the two real solutions on
`(-e⁻¹,0)` and the branch point at `-e⁻¹`.
::::

::::dlmfEntry "Figure 4.13.2" "https://dlmf.nist.gov/4.13.F2"
Figure 4.13.2 depicts the first five Riemann sheets, their phase regions, and
the image curves under the Lambert map.  These are branch/cut disclosures,
not additional numbered equations.
::::

The source notes explain the radius of convergence at the square-root branch
point, the branch cuts `(-∞,-e⁻¹]` and `(-∞,0]`, and the substitution
`z = w exp w` used for the integral representations.  The formal declarations
retain the quantitative distinction between convergent series, asymptotic
equivalence, coefficient recurrences, and integral identities.
