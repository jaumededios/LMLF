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

The formulas use named integrands and typed domain data. The shared Chapter 3
vocabulary `LMLF.Integral.VerticalLine` fixes the point, upward tangent, whole-line
integral, and integrability predicate from its real offset. Integrability is stated
separately from each value identity.

::::dlmfEntry "5.13.1" "https://dlmf.nist.gov/5.13.E1"
$$`\frac{1}{2\pi i}\int_{c-i\infty}^{c+i\infty}
\Gamma(s+a)\Gamma(b-s)z^{-s}\,\mathrm{d}s
=\frac{\Gamma(a+b)z^a}{(1+z)^{a+b}},\qquad
\Re(a+b)>0,\quad-\Re a<c<\Re b,\quad|\mathrm{ph}\,z|<\pi.`

The domain object packages the source inequalities and the nonzero principal-phase base.
The upward tangent `i` is part of the contour integral.

:::leanStatement "Lean statement · section-specific Barnes data"
```anchor PrincipalPowerPoint (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
structure PrincipalPowerPoint where
  value : ℂ
  nonzero : value ≠ 0
  phase : |Complex.arg value| < Real.pi
```
```anchor principalPowerPointCoe (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
instance principalPowerPointCoe : Coe PrincipalPowerPoint ℂ :=
  ⟨PrincipalPowerPoint.value⟩
```
```anchor BarnesFirstDomain (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
structure BarnesFirstDomain where
  a : ℂ
  b : ℂ
  z : PrincipalPowerPoint
  c : ℝ
  hab : 0 < (a + b).re
  lower : -a.re < c
  upper : c < b.re
```
```anchor BarnesFirstDomain.integrand (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
def BarnesFirstDomain.integrand (p : BarnesFirstDomain) : ℂ → ℂ := fun s ↦
  Complex.Gamma (s + p.a) * Complex.Gamma (p.b - s) *
    (p.z : ℂ) ^ (-s)
```
```anchor dlmf_5_13_1_integrable (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
theorem dlmf_5_13_1_integrable (p : BarnesFirstDomain) :
    (verticalLine p.c).Integrable p.integrand
```
```anchor dlmf_5_13_1 (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
theorem dlmf_5_13_1 (p : BarnesFirstDomain) :
    (1 / (2 * Real.pi * Complex.I)) *
        (verticalLine p.c).integral p.integrand =
      Complex.Gamma (p.a + p.b) * (p.z : ℂ) ^ p.a /
        (1 + (p.z : ℂ)) ^ (p.a + p.b)
```
:::
::::

::::dlmfEntry "5.13.2" "https://dlmf.nist.gov/5.13.E2"
$$`\frac{1}{2\pi}\int_{-\infty}^{\infty}
|\Gamma(a+it)|^2e^{(2b-\pi)t}\,\mathrm{d}t
=\frac{\Gamma(2a)}{(2\sin b)^{2a}},\qquad a>0,\quad0<b<\pi.`

For real `a` and `b` in the source ranges, the named real integrand has its own
ordinary whole-line convergence declaration. DLMF obtains this display from 5.13.1 by
setting `c=0`, the Barnes parameter `b=a`, `s=it`, and
`z=\exp(i(\pi-2b))`, with `t\mapsto-t` accounting for the displayed weight.

:::leanStatement "Lean statement · modulus-square integral"
```anchor BarnesModulusDomain (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
structure BarnesModulusDomain where
  a : ℝ
  b : ℝ
  a_pos : 0 < a
  b_pos : 0 < b
  b_lt_pi : b < Real.pi
```
```anchor BarnesModulusDomain.integrand (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
def BarnesModulusDomain.integrand (p : BarnesModulusDomain) (t : ℝ) : ℝ :=
  ‖Complex.Gamma ((p.a : ℂ) + (t : ℂ) * Complex.I)‖ ^ 2 *
    Real.exp ((2 * p.b - Real.pi) * t)
```
```anchor dlmf_5_13_2_integrable (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
theorem dlmf_5_13_2_integrable (p : BarnesModulusDomain) :
    MeasureTheory.Integrable p.integrand
```
```anchor dlmf_5_13_2 (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
theorem dlmf_5_13_2 (p : BarnesModulusDomain) :
    (1 / (2 * Real.pi : ℝ)) * (∫ t : ℝ, p.integrand t) =
      Real.Gamma (2 * p.a) / (2 * Real.sin p.b) ^ (2 * p.a)
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
{\Gamma(a+b+c+d)},\qquad\Re a,\Re b,\Re c,\Re d>0.`

All four parameters may be complex. `BarnesBetaDomain` carries the source's four
positive real-part conditions. Its named normalized integral, convergence declaration,
and value identity are separate objects.

:::leanStatement "Lean statement · Barnes beta integral"
```anchor BarnesBetaDomain (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
structure BarnesBetaDomain where
  a : ℂ
  b : ℂ
  c : ℂ
  d : ℂ
  a_pos : 0 < a.re
  b_pos : 0 < b.re
  c_pos : 0 < c.re
  d_pos : 0 < d.re
```
```anchor BarnesBetaDomain.integrand (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
def BarnesBetaDomain.integrand (p : BarnesBetaDomain) (t : ℝ) : ℂ :=
  Complex.Gamma (p.a + (t : ℂ) * Complex.I) *
    Complex.Gamma (p.b + (t : ℂ) * Complex.I) *
    Complex.Gamma (p.c - (t : ℂ) * Complex.I) *
    Complex.Gamma (p.d - (t : ℂ) * Complex.I)
```
```anchor BarnesBetaDomain.integral (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
noncomputable def BarnesBetaDomain.integral (p : BarnesBetaDomain) : ℂ :=
  (1 / (2 * Real.pi : ℂ)) * ∫ t : ℝ, p.integrand t
```
```anchor dlmf_5_13_3_integrable (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
theorem dlmf_5_13_3_integrable (p : BarnesBetaDomain) :
    MeasureTheory.Integrable p.integrand
```
```anchor dlmf_5_13_3 (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
theorem dlmf_5_13_3 (p : BarnesBetaDomain) :
    p.integral =
      Complex.Gamma (p.a + p.c) * Complex.Gamma (p.a + p.d) *
        Complex.Gamma (p.b + p.c) * Complex.Gamma (p.b + p.d) /
          Complex.Gamma (p.a + p.b + p.c + p.d)
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

The domain has exactly the source's real-part condition on the sum. The reciprocal-Gamma
integrand is named before its convergence and value declarations.

:::leanStatement "Lean statement · Ramanujan beta integral"
```anchor RamanujanBetaDomain (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
structure RamanujanBetaDomain where
  a : ℂ
  b : ℂ
  c : ℂ
  d : ℂ
  sum_gt_three : 3 < (a + b + c + d).re
```
```anchor RamanujanBetaDomain.integrand (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
def RamanujanBetaDomain.integrand (p : RamanujanBetaDomain) (t : ℝ) : ℂ :=
  1 / (Complex.Gamma (p.a + (t : ℂ)) * Complex.Gamma (p.b + (t : ℂ)) *
    Complex.Gamma (p.c - (t : ℂ)) * Complex.Gamma (p.d - (t : ℂ)))
```
```anchor dlmf_5_13_4_integrable (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
theorem dlmf_5_13_4_integrable (p : RamanujanBetaDomain) :
    MeasureTheory.Integrable p.integrand
```
```anchor dlmf_5_13_4 (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
theorem dlmf_5_13_4 (p : RamanujanBetaDomain) :
    (∫ t : ℝ, p.integrand t) =
      Complex.Gamma (p.a + p.b + p.c + p.d - 3) /
        (Complex.Gamma (p.a + p.c - 1) * Complex.Gamma (p.a + p.d - 1) *
          Complex.Gamma (p.b + p.c - 1) * Complex.Gamma (p.b + p.d - 1))
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

The four parameters carry both positivity and a pole-free invariant. The finite products
retain all four parameters and all six pairwise Gamma factors. Reciprocal Gamma factors
give the removable extension at `t = 0`; away from that point the named kernel is the
source quotient and the whole-line integral is unchanged.

:::leanStatement "Lean statement · de Branges--Wilson beta integral"
```anchor PoleFreeGammaPoint (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
structure PoleFreeGammaPoint where
  value : ℂ
  not_pole : ∀ n : ℕ, value ≠ -(n : ℂ)
```
```anchor poleFreeGammaPointCoe (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
instance poleFreeGammaPointCoe : Coe PoleFreeGammaPoint ℂ :=
  ⟨PoleFreeGammaPoint.value⟩
```
```anchor DeBrangesWilsonDomain (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
structure DeBrangesWilsonDomain where
  parameter : Fin 4 → PoleFreeGammaPoint
  positive : ∀ k : Fin 4, 0 < ((parameter k : ℂ).re)
```
```anchor DeBrangesWilsonDomain.numerator (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
def DeBrangesWilsonDomain.numerator (p : DeBrangesWilsonDomain) (t : ℝ) : ℂ :=
  ∏ k : Fin 4,
    Complex.Gamma ((p.parameter k : ℂ) + (t : ℂ) * Complex.I) *
      Complex.Gamma ((p.parameter k : ℂ) - (t : ℂ) * Complex.I)
```
```anchor DeBrangesWilsonDomain.integrand (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
def DeBrangesWilsonDomain.integrand (p : DeBrangesWilsonDomain) (t : ℝ) : ℂ :=
  p.numerator t *
    (1 / Complex.Gamma (2 * (t : ℂ) * Complex.I)) *
    (1 / Complex.Gamma (-2 * (t : ℂ) * Complex.I))
```
```anchor dlmf_5_13_5_integrable (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
theorem dlmf_5_13_5_integrable (p : DeBrangesWilsonDomain) :
    MeasureTheory.Integrable p.integrand
```
```anchor dlmf_5_13_5 (module := LMLF.Blueprint.Gamma.Section513) -showProofStates
theorem dlmf_5_13_5 (p : DeBrangesWilsonDomain) :
    (1 / (4 * Real.pi : ℝ)) * ∫ t : ℝ, p.integrand t =
      (∏ j : Fin 4, ∏ k : Fin 4,
        if j < k then Complex.Gamma ((p.parameter j : ℂ) + (p.parameter k : ℂ)) else 1) /
        Complex.Gamma (∑ k : Fin 4, (p.parameter k : ℂ))
```
:::
::::
