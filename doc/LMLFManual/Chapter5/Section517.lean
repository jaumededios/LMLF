import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section517
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§5.17 Barnes' G-Function (Double Gamma Function)" =>
%%%
tag := "chapter-5-section-17"
%%%

:::dlmfChapter "https://dlmf.nist.gov/5.17"
Source: NIST Digital Library of Mathematical Functions, §5.17.
:::

DLMF §5.17 introduces Barnes' `G`-function, also called the double gamma
function.  Its canonical product (5.17.3) displays the factors and the zeros
they contribute.  The logarithms in (5.17.4) and (5.17.5) are the source
branches: principal on the positive real axis and continued by continuity.
The positive-real specializations use the filter `atTop` on `x > 0` for the
sector in (5.17.5).

```anchor barnesGProductTerm (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
noncomputable def barnesGProductTerm (z : ℂ) (k : {n : ℕ // 1 ≤ n}) : ℂ :=
  (1 + z / (k.1 : ℂ)) ^ k.1 *
    Complex.exp (-z + z ^ 2 / (2 * (k.1 : ℂ)))
```

```anchor barnesGProductPrefactor (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
noncomputable def barnesGProductPrefactor (z : ℂ) : ℂ :=
  Complex.exp ((z / 2) * Complex.log (2 * Real.pi) -
    (1 / 2) * z * (z + 1) -
      (1 / 2) * (Real.eulerMascheroniConstant : ℂ) * z ^ 2)
```

The finite canonical products and their infinite product value are separate
objects.  The `HasProd` and `Tendsto` declarations below record convergence;
the Barnes function itself is then defined using the named product value.

```anchor barnesGProductPartialProduct (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
noncomputable def barnesGProductPartialProduct (z : ℂ) (N : ℕ) : ℂ :=
  ∏ k ∈ Finset.range N,
    barnesGProductTerm z ⟨k + 1, Nat.succ_le_succ (Nat.zero_le k)⟩
```

```anchor barnesGProduct (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
noncomputable def barnesGProduct (z : ℂ) : ℂ :=
  ∏' k : {n : ℕ // 1 ≤ n}, barnesGProductTerm z k
```

The Glaisher data used by the later asymptotic panel are also named here.  The
logarithmic constant is anchored to the zeta-derivative value, while the
renormalized finite expression is retained as the sequence whose convergence
is stated in (5.17.7).

```anchor glaisherPartialExpression (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
noncomputable def glaisherPartialExpression (n : ℕ) : ℝ :=
  (∑ k ∈ Finset.Icc 1 n, (k : ℝ) * Real.log (k : ℝ)) -
    ((1 / 2 : ℝ) * (n : ℝ) ^ 2 + (1 / 2 : ℝ) * (n : ℝ) + 1 / 12) *
      Real.log (n : ℝ) +
    (1 / 4 : ℝ) * (n : ℝ) ^ 2
```

```anchor glaisherLogConstant (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
noncomputable def glaisherLogConstant : ℝ :=
  ((1 / 12 : ℂ) - deriv riemannZeta (-1 : ℂ)).re
```

```anchor glaisherConstant (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
noncomputable def glaisherConstant : ℝ := Real.exp glaisherLogConstant
```

```anchor barnesG (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
noncomputable def barnesG (z : ℂ) : ℂ :=
  barnesGProductPrefactor (z - 1) *
    barnesGProduct (z - 1)
```

::::dlmfEntry "5.17.1" "https://dlmf.nist.gov/5.17.E1"
$$`
G(z+1)=\Gamma(z)G(z),\qquad G(1)=1.
`

Away from the nonpositive integers, Barnes' function satisfies the first-order
recurrence with the Gamma function; its normalization at one is one.  The
pole-free guard is explicit because Mathlib totalizes `Complex.Gamma` by
assigning zero at its poles.  The recurrence also keeps the zero structure of
the canonical function explicit: zeros at nonpositive integers are not
silently replaced by a nonvanishing surrogate.

:::leanStatement "Barnes recurrence"
```anchor dlmf_5_17_1 (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
theorem dlmf_5_17_1 (z : ℂ) (hz : ∀ m : ℕ, z ≠ -(m : ℂ)) :
    barnesG (z + 1) = Complex.Gamma z * barnesG z
```

```anchor barnesG_one (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
theorem barnesG_one : barnesG 1 = 1
```
:::
::::

::::dlmfEntry "5.17.2" "https://dlmf.nist.gov/5.17.E2"
$$`
G(n)=(n-2)!(n-3)!\cdots1!,\qquad n=2,3,\ldots.
`

At each integer `n ≥ 2`, repeated use of the recurrence gives the finite
factorial product beginning with `(n−2)!` and ending with `1!`.  The finite
product over `Finset.Icc 1 (n−2)` is empty at `n=2`, hence equals one as
required.

:::leanStatement "Lean statement · integer values"
```anchor barnesIntegerProduct (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
noncomputable def barnesIntegerProduct (n : ℕ) : ℂ :=
  ∏ k ∈ Finset.Icc 1 (n - 2), (k.factorial : ℂ)
```

```anchor dlmf_5_17_2 (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
theorem dlmf_5_17_2 {n : ℕ} (hn : 2 ≤ n) :
    barnesG (n : ℂ) = barnesIntegerProduct n
```
:::
::::

::::dlmfEntry "5.17.3" "https://dlmf.nist.gov/5.17.E3"
$$`
G(z+1)=(2\pi)^{z/2}\exp\!\left(-\frac12z(z+1)-\frac12\gamma z^2\right)
\prod_{k=1}^{\infty}\left(\left(1+\frac zk\right)^k
\exp\!\left(-z+\frac{z^2}{2k}\right)\right).
`

For complex `z`, the canonical product multiplies the exponential prefactor
by the factors indexed from `k=1`.  The index `{n : ℕ // 1 ≤ n}` records that
lower limit directly.  Convergence of the product is stated independently
from the value identity.

:::leanStatement "Lean statement · canonical product"
```anchor barnesGProduct_hasProd (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
theorem barnesGProduct_hasProd (z : ℂ) :
    HasProd (fun k : {n : ℕ // 1 ≤ n} ↦ barnesGProductTerm z k) (barnesGProduct z)
```

```anchor barnesGProduct_partialProduct_tendsto (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
theorem barnesGProduct_partialProduct_tendsto (z : ℂ) :
    Tendsto (barnesGProductPartialProduct z) atTop (nhds (barnesGProduct z))
```

```anchor dlmf_5_17_3 (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
theorem dlmf_5_17_3 (z : ℂ) :
    barnesG (z + 1) =
      barnesGProductPrefactor z *
        barnesGProduct z
```
:::
::::

::::dlmfEntry "5.17.4" "https://dlmf.nist.gov/5.17.E4"
$$`
\operatorname{Ln}G(z+1)=\frac12z\ln(2\pi)-\frac12z(z+1)
+z\operatorname{Ln}\Gamma(z+1)-\int_0^z\operatorname{Ln}\Gamma(t+1)\,dt.
`

The source identity is complex and uses a path from `0` to `z`, with the
specified continuation of the general logarithms.  For real `x>0`, the path
integral is the interval integral along the positive real axis and the
principal logarithms agree with the continued branch there.

:::leanStatement "Lean statement · positive-real integral specialization"
```anchor dlmf_5_17_4 (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
theorem dlmf_5_17_4 {x : ℝ} (hx : 0 < x) :
    Complex.log (barnesG ((x + 1 : ℝ) : ℂ)) =
      (x : ℂ) / 2 * Complex.log (2 * Real.pi) -
        (1 / 2 : ℂ) * (x : ℂ) * ((x : ℂ) + 1) +
        (x : ℂ) * Complex.log (Complex.Gamma ((x + 1 : ℝ) : ℂ)) -
        ∫ t in (0 : ℝ)..x, Complex.log (Complex.Gamma ((t + 1 : ℝ) : ℂ))
```
:::
::::

::::dlmfEntry "5.17.5" "https://dlmf.nist.gov/5.17.E5"
$$`
\operatorname{Ln}G(z+1)\sim\frac14z^2+z\operatorname{Ln}\Gamma(z+1)
-\left(\frac12z(z+1)+\frac1{12}\right)\ln z-\ln A
+\sum_{k=1}^{\infty}\frac{B_{2k+2}}{2k(2k+1)(2k+2)z^{2k}}.
`

As `z` tends to infinity in `|ph z| ≤ π−δ` with `δ>0`, DLMF gives a
Poincaré expansion in Bernoulli numbers, with `A` Glaisher's constant.  On
the positive real axis, `x → +∞` lies in every such sector, and the source
index `k=1,2,…` corresponds to index `n=0,1,…` in
`barnesGAsymptoticTerm`.  DLMF also points to Nemes for error
  bounds and an exponentially improved extension.

:::leanStatement "Lean statement · positive-real Poincare specialization"
```anchor barnesGAsymptoticMain (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
noncomputable def barnesGAsymptoticMain (x : ℝ) : ℂ :=
  (1 / 4 : ℂ) * (x : ℂ) ^ 2 +
    (x : ℂ) * Complex.log (Complex.Gamma ((x + 1 : ℝ) : ℂ)) -
    ((1 / 2 : ℂ) * (x : ℂ) * ((x : ℂ) + 1) + 1 / 12) *
      Complex.log (x : ℂ) -
    Complex.log (glaisherConstant : ℂ)
```

```anchor barnesGAsymptoticTerm (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
noncomputable def barnesGAsymptoticTerm (n : ℕ) (x : ℝ) : ℂ :=
  (bernoulli (2 * n + 4) : ℂ) /
    (((2 * n + 2 : ℕ) : ℂ) * ((2 * n + 3 : ℕ) : ℂ) *
      ((2 * n + 4 : ℕ) : ℂ) * (x : ℂ) ^ (2 * n + 2))
```

```anchor dlmf_5_17_5 (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
theorem dlmf_5_17_5 :
    (fun x : ℝ ↦
      Complex.log (barnesG ((x + 1 : ℝ) : ℂ)) - barnesGAsymptoticMain x) ∼ₚ[atTop]
        barnesGAsymptoticTerm
```
:::
::::

::::dlmfEntry "5.17.6" "https://dlmf.nist.gov/5.17.E6"
$$`
A=e^C=1.28242\,71291\,00622\,63687\ldots.
`

Glaisher's constant `A` is the exponential of the constant `C`; the displayed
digits give its decimal expansion.

:::leanStatement "Lean statement · Glaisher constant"
```anchor dlmf_5_17_6 (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
theorem dlmf_5_17_6 :
    glaisherConstant = Real.exp glaisherLogConstant
```
:::
::::

::::dlmfEntry "5.17.7" "https://dlmf.nist.gov/5.17.E7"
$$`
C=\lim_{n\to\infty}\left(\sum_{k=1}^n k\ln k-
\left(\frac12n^2+\frac12n+\frac1{12}\right)\ln n+\frac14n^2\right)
=\frac{\gamma+\ln(2\pi)}{12}-\frac{\zeta'(2)}{2\pi^2}
=\frac1{12}-\zeta'(-1).
`

The constant `C` is the limit of the renormalized weighted logarithmic sum,
and the source gives two equivalent forms in terms of derivatives of the
Riemann zeta function.  The finite sum uses `Finset.Icc 1 n`, preserving the
source lower limit, and the two derivatives are taken at `2` and `−1`.

:::leanStatement "Lean statement · Glaisher logarithm"
```anchor glaisherPartialExpression_tendsto (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
theorem glaisherPartialExpression_tendsto :
    Tendsto glaisherPartialExpression atTop (nhds glaisherLogConstant)
```

```anchor dlmf_5_17_7 (module := LMLF.Blueprint.Gamma.Section517) -showProofStates
theorem dlmf_5_17_7 :
    (glaisherLogConstant : ℂ) =
        ((Real.eulerMascheroniConstant : ℂ) + Complex.log (2 * Real.pi)) / 12 -
          deriv riemannZeta (2 : ℂ) / (2 * (Real.pi : ℂ) ^ 2) ∧
      (glaisherLogConstant : ℂ) =
        (1 / 12 : ℂ) - deriv riemannZeta (-1 : ℂ)
```
:::
::::
