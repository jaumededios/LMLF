import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section513
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§5.13 Integrals" =>
%%%
tag := "chapter-5-section-13"
%%%

:::dlmfChapter "https://dlmf.nist.gov/5.13"
Source: NIST Digital Library of Mathematical Functions, §5.13.
:::

The first identity is parameterized along its straight vertical contour.  The remaining
identities are ordinary whole-line integrals.  Complex powers in the first identity use
Mathlib's principal complex-power operation; the second identity is stated for its real
parameters, as in the source inequalities.

::::dlmfEntry "5.13.1" "https://dlmf.nist.gov/5.13.E1"
$$`\frac{1}{2\pi i}\int_{c-i\infty}^{c+i\infty}
\Gamma(s+a)\Gamma(b-s)z^{-s}\,\mathrm{d}s
=\frac{\Gamma(a+b)z^a}{(1+z)^{a+b}},\qquad
\Re(a+b)>0,\quad-\Re a<c<\Re b,\quad|\mathrm{ph}\,z|<\pi.`

The path is the straight line parallel to the imaginary axis with real part `c`, oriented
upward.  Writing `s=c+it` contributes `ds=i,dt`, which is exposed by
`verticalLineIntegral`; the inequalities are exactly the source conditions.  The source
phase domain is for nonzero `z`, so the Lean statement makes `z ≠ 0` explicit alongside
the principal phase restriction, which keeps `z` away from the negative real axis.

:::leanStatement "Lean statement · vertical contour"
```anchor verticalLineIntegral (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
noncomputable def verticalLineIntegral (c : ℝ) (f : ℂ → ℂ) : ℂ :=
  ∫ t : ℝ, f ((c : ℂ) + (t : ℂ) * Complex.I) * Complex.I
```

```anchor dlmf_5_13_1 (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
theorem dlmf_5_13_1 {a b z : ℂ} {c : ℝ}
    (hab : 0 < (a + b).re) (hc : -a.re < c) (hc' : c < b.re) (hz0 : z ≠ 0)
    (hz : |Complex.arg z| < Real.pi) :
    Integrable (fun t : ℝ ↦
      Complex.Gamma ((c : ℂ) + (t : ℂ) * Complex.I + a) *
        Complex.Gamma (b - ((c : ℂ) + (t : ℂ) * Complex.I)) *
        z ^ (-((c : ℂ) + (t : ℂ) * Complex.I)) * Complex.I) ∧
      (1 / (2 * Real.pi * Complex.I)) *
          verticalLineIntegral c (fun s : ℂ ↦
            Complex.Gamma (s + a) * Complex.Gamma (b - s) * z ^ (-s)) =
        Complex.Gamma (a + b) * z ^ a / (1 + z) ^ (a + b)
```
:::
::::

::::dlmfEntry "5.13.2" "https://dlmf.nist.gov/5.13.E2"
$$`\frac{1}{2\pi}\int_{-\infty}^{\infty}
|\Gamma(a+it)|^2e^{(2b-\pi)t}\,\mathrm{d}t
=\frac{\Gamma(2a)}{(2\sin b)^{2a}},\qquad a>0,\quad0<b<\pi.`

For real `a` and `b` in the stated ranges, the modulus square is an ordinary real-valued
integrand.  The whole-line integral converges in the ordinary (absolutely integrable)
sense, with the same normalization and powers as
the source display.  DLMF notes that this display follows from 5.13.1 by setting
`c=0`, `b=a`, `s=it`, and `z=exp(i(π-2b))`, with the harmless change `t ↦ -t`
accounting for the displayed orientation of the exponential weight.

:::leanStatement "Lean statement · real Barnes integral"
```anchor dlmf_5_13_2 (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
theorem dlmf_5_13_2 {a b : ℝ} (ha : 0 < a) (hb0 : 0 < b) (hbπ : b < Real.pi) :
    Integrable (fun t : ℝ ↦
      ‖Complex.Gamma ((a : ℂ) + (t : ℂ) * Complex.I)‖ ^ 2 *
        Real.exp ((2 * b - Real.pi) * t)) ∧
      (1 / (2 * Real.pi : ℝ)) *
          ∫ t : ℝ,
            ‖Complex.Gamma ((a : ℂ) + (t : ℂ) * Complex.I)‖ ^ 2 *
              Real.exp ((2 * b - Real.pi) * t) =
        Real.Gamma (2 * a) / (2 * Real.sin b) ^ (2 * a)
```
:::
::::

# §5.13(i) Barnes' Beta Integral
%%%
number := false
%%%

::::dlmfEntry "5.13.3" "https://dlmf.nist.gov/5.13.E3"
$$`\frac{1}{2\pi}\int_{-\infty}^{\infty}
\Gamma(a+it)\Gamma(b+it)\Gamma(c-it)\Gamma(d-it)\,\mathrm{d}t
=\frac{\Gamma(a+c)\Gamma(a+d)\Gamma(b+c)\Gamma(b+d)}
{\Gamma(a+b+c+d)},\qquad
\Re a,\Re b,\Re c,\Re d>0.`

All four parameters may be complex.  Positivity of each real part is the source
condition; under it the product of four Gamma factors is ordinarily integrable on the
real line, and the displayed quotient is exactly the normalized Barnes beta value.

:::leanStatement "Lean statement · Barnes beta integral"
```anchor dlmf_5_13_3 (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
theorem dlmf_5_13_3 {a b c d : ℂ}
    (ha : 0 < a.re) (hb : 0 < b.re) (hc : 0 < c.re) (hd : 0 < d.re) :
    Integrable (fun t : ℝ ↦
      Complex.Gamma (a + (t : ℂ) * Complex.I) *
        Complex.Gamma (b + (t : ℂ) * Complex.I) *
        Complex.Gamma (c - (t : ℂ) * Complex.I) *
        Complex.Gamma (d - (t : ℂ) * Complex.I)) ∧
      (1 / (2 * Real.pi : ℂ)) *
          ∫ t : ℝ,
            Complex.Gamma (a + (t : ℂ) * Complex.I) *
              Complex.Gamma (b + (t : ℂ) * Complex.I) *
              Complex.Gamma (c - (t : ℂ) * Complex.I) *
              Complex.Gamma (d - (t : ℂ) * Complex.I) =
        Complex.Gamma (a + c) * Complex.Gamma (a + d) *
          Complex.Gamma (b + c) * Complex.Gamma (b + d) /
            Complex.Gamma (a + b + c + d)
```
:::
::::

# §5.13(ii) Ramanujan's Beta Integral
%%%
number := false
%%%

::::dlmfEntry "5.13.4" "https://dlmf.nist.gov/5.13.E4"
$$`\int_{-\infty}^{\infty}
\frac{\mathrm{d}t}{\Gamma(a+t)\Gamma(b+t)\Gamma(c-t)\Gamma(d-t)}
=\frac{\Gamma(a+b+c+d-3)}
{\Gamma(a+c-1)\Gamma(a+d-1)\Gamma(b+c-1)\Gamma(b+d-1)},\qquad
\Re(a+b+c+d)>3.`

The reciprocal Gamma product is integrated ordinarily over the real line.  The source
requires only the displayed real-part inequality on the sum.

:::leanStatement "Lean statement · Ramanujan beta integral"
```anchor dlmf_5_13_4 (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
theorem dlmf_5_13_4 {a b c d : ℂ} (hs : 3 < (a + b + c + d).re) :
    Integrable (fun t : ℝ ↦
      1 / (Complex.Gamma (a + (t : ℂ)) * Complex.Gamma (b + (t : ℂ)) *
        Complex.Gamma (c - (t : ℂ)) * Complex.Gamma (d - (t : ℂ)))) ∧
      ∫ t : ℝ,
          1 / (Complex.Gamma (a + (t : ℂ)) * Complex.Gamma (b + (t : ℂ)) *
            Complex.Gamma (c - (t : ℂ)) * Complex.Gamma (d - (t : ℂ))) =
        Complex.Gamma (a + b + c + d - 3) /
          (Complex.Gamma (a + c - 1) * Complex.Gamma (a + d - 1) *
            Complex.Gamma (b + c - 1) * Complex.Gamma (b + d - 1))
```
:::
::::

# §5.13(iii) de Branges--Wilson Beta Integral
%%%
number := false
%%%

::::dlmfEntry "5.13.5" "https://dlmf.nist.gov/5.13.E5"
$$`\frac{1}{4\pi}\int_{-\infty}^{\infty}
\frac{\prod_{k=1}^{4}\Gamma(a_k+it)\Gamma(a_k-it)}
{\Gamma(2it)\Gamma(-2it)}\,\mathrm{d}t
=\frac{\prod_{1\le j<k\le4}\Gamma(a_j+a_k)}
{\Gamma(a_1+a_2+a_3+a_4)},\qquad\Re(a_k)>0.`

The four parameters are represented by `a : Fin 4 → ℂ`; the finite products therefore
retain all four factors and all six pairwise Gamma factors.  The positivity condition is
imposed for every index.  At `t=0`, Mathlib's totalized Gamma and division operations assign
the displayed quotient its removable value `0` (the reciprocal-Gamma product has the
same limit); changing one point does not affect this ordinary integral.

:::leanStatement "Lean statement · de Branges--Wilson beta integral"
```anchor deBrangesWilsonNumerator (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
noncomputable def deBrangesWilsonNumerator (a : Fin 4 → ℂ) (t : ℝ) : ℂ :=
  ∏ k : Fin 4, Complex.Gamma (a k + (t : ℂ) * Complex.I) *
    Complex.Gamma (a k - (t : ℂ) * Complex.I)
```

```anchor dlmf_5_13_5 (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
theorem dlmf_5_13_5 (a : Fin 4 → ℂ) (ha : ∀ k : Fin 4, 0 < (a k).re) :
    Integrable (fun t : ℝ ↦
      deBrangesWilsonNumerator a t /
        (Complex.Gamma (2 * (t : ℂ) * Complex.I) *
          Complex.Gamma (-2 * (t : ℂ) * Complex.I))) ∧
      (1 / (4 * Real.pi : ℝ)) *
          ∫ t : ℝ,
            deBrangesWilsonNumerator a t /
              (Complex.Gamma (2 * (t : ℂ) * Complex.I) *
                Complex.Gamma (-2 * (t : ℂ) * Complex.I)) =
        (∏ j : Fin 4, ∏ k : Fin 4, if j < k then Complex.Gamma (a j + a k) else 1) /
          Complex.Gamma (∑ k : Fin 4, a k)
```
:::
::::
