import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section512
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§5.12 Beta Function" =>
%%%
tag := "chapter-5-section-12"
%%%

Fractional powers have principal values unless a contour record explicitly carries
continuous logarithm lifts.  `Complex.betaIntegral` denotes the convergent Euler
integral; the meromorphic continuation is represented by `meromorphicBeta`, with
`meromorphicBetaDefined` excluding its Gamma poles.  The integral records state their
convergence conditions explicitly.

:::leanStatement "Lean vocabulary · meromorphic beta continuation"
```anchor meromorphicBeta (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def meromorphicBeta (a b : ℂ) : ℂ :=
  Complex.Gamma a * Complex.Gamma b / Complex.Gamma (a + b)
```
:::

:::leanStatement "Lean vocabulary · finite meromorphic-beta locus"
```anchor meromorphicBetaDefined (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
def meromorphicBetaDefined (a b : ℂ) : Prop :=
  Complex.Gamma a ≠ 0 ∧ Complex.Gamma b ≠ 0 ∧ Complex.Gamma (a + b) ≠ 0
```
:::

::::dlmfEntry "5.12.1" "https://dlmf.nist.gov/5.12.E1"
For `Re a > 0` and `Re b > 0`,
$$`\mathrm{B}(a,b)=\int_0^1t^{a-1}(1-t)^{b-1}\,dt
 =\frac{\Gamma(a)\Gamma(b)}{\Gamma(a+b)}.`

The local `Complex.betaIntegral` is Mathlib's complex beta integral, so the declaration
records both the defining interval integral and its Gamma quotient.  This is an exact
complex statement, with the source half-plane restrictions retained.

:::leanStatement "Lean statement · Euler beta integral"
```anchor dlmf_5_12_1 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_1 {a b : ℂ} (ha : 0 < a.re) (hb : 0 < b.re) :
    Complex.betaIntegral a b =
        ∫ t in (0 : ℝ)..1, (t : ℂ) ^ (a - 1) * (1 - (t : ℂ)) ^ (b - 1) ∧
      Complex.betaIntegral a b = Complex.Gamma a * Complex.Gamma b / Complex.Gamma (a + b)
```
:::
::::

::::dlmfEntry "5.12.2" "https://dlmf.nist.gov/5.12.E2"
$$`\int_0^{\pi/2}\sin^{2a-1}\theta\,\cos^{2b-1}\theta\,d\theta
 =\tfrac12\mathrm{B}(a,b).`

The interval integrability assertion is explicit in Lean.  Complex parameters and their
principal powers are retained, so this is an exact statement of the source formula.

:::leanStatement "Lean statement · trigonometric beta integral"
```anchor dlmf_5_12_2 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_2 {a b : ℂ} (ha : 0 < a.re) (hb : 0 < b.re) :
    IntervalIntegrable
        (fun θ : ℝ ↦ (Complex.sin (θ : ℂ)) ^ (2 * a - 1) *
          (Complex.cos (θ : ℂ)) ^ (2 * b - 1)) volume 0 (Real.pi / 2) ∧
      (∫ θ in (0 : ℝ)..(Real.pi / 2),
          (Complex.sin (θ : ℂ)) ^ (2 * a - 1) *
            (Complex.cos (θ : ℂ)) ^ (2 * b - 1)) = Complex.betaIntegral a b / 2
```
:::
::::

::::dlmfEntry "5.12.3" "https://dlmf.nist.gov/5.12.E3"
$$`\int_0^\infty\frac{t^{a-1}}{(1+t)^{a+b}}\,dt=\mathrm{B}(a,b).`

The improper integral is written over `Ioi 0`, and `IntegrableOn` records its convergence
on the positive half-line.  The statement keeps the exact complex parameters and the
standing positive-real-part hypotheses.

:::leanStatement "Lean statement · half-line beta integral"
```anchor dlmf_5_12_3 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_3 {a b : ℂ} (ha : 0 < a.re) (hb : 0 < b.re) :
    IntegrableOn
        (fun t : ℝ ↦ (t : ℂ) ^ (a - 1) / (1 + (t : ℂ)) ^ (a + b)) (Ioi 0) ∧
      (∫ t in Ioi (0 : ℝ), (t : ℂ) ^ (a - 1) / (1 + (t : ℂ)) ^ (a + b)) =
        Complex.betaIntegral a b
```
:::
::::

::::dlmfEntry "5.12.4" "https://dlmf.nist.gov/5.12.E4"
For `|ph z|<π`,
$$`\int_0^1\frac{t^{a-1}(1-t)^{b-1}}{(t+z)^{a+b}}\,dt
 =\mathrm{B}(a,b)(1+z)^{-a}z^{-b}.`

`z ≠ 0` records that the source phase condition excludes the branch point itself, while
`Complex.arg z` is the principal phase used for the source condition.  The finite-interval
integrability and the branch-sensitive shifted integrand are both visible in the exact
complex declaration.

:::leanStatement "Lean statement · shifted beta integral"
```anchor dlmf_5_12_4 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_4 {a b z : ℂ} (ha : 0 < a.re) (hb : 0 < b.re)
    (hz0 : z ≠ 0) (hz : |Complex.arg z| < Real.pi) :
    IntervalIntegrable
        (fun t : ℝ ↦ (t : ℂ) ^ (a - 1) * (1 - (t : ℂ)) ^ (b - 1) /
          ((t : ℂ) + z) ^ (a + b)) volume 0 1 ∧
      (∫ t in (0 : ℝ)..1,
          (t : ℂ) ^ (a - 1) * (1 - (t : ℂ)) ^ (b - 1) /
            ((t : ℂ) + z) ^ (a + b)) =
        Complex.betaIntegral a b * (1 + z) ^ (-a) * z ^ (-b)
```
:::
::::

::::dlmfEntry "5.12.5" "https://dlmf.nist.gov/5.12.E5"
For `Re a>0`,
$$`\int_0^{\pi/2}(\cos t)^{a-1}\cos(bt)\,dt
 =\frac{\pi}{2^a}\frac{1}{a\,\mathrm{B}((a+b+1)/2,(a-b+1)/2)}.`

The complex parameter `b` is unrestricted by the source display, while the stated
half-plane condition on `a` is preserved.  Since the two beta arguments on the right
need not both have positive real part, `meromorphicBeta` records DLMF's meromorphic
continuation rather than Mathlib's interval integral; `meromorphicBetaDefined` keeps the
displayed quotient away from its Gamma poles.  The right side is parsed as
`(π/2^a)/(a B(...))`, exactly as in DLMF.

:::leanStatement "Lean statement · cosine-power beta integral"
```anchor dlmf_5_12_5 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_5 {a b : ℂ} (ha : 0 < a.re) (ha0 : a ≠ 0)
    (hβ : meromorphicBetaDefined ((a + b + 1) / 2) ((a - b + 1) / 2)) :
    IntervalIntegrable
        (fun t : ℝ ↦ (Complex.cos (t : ℂ)) ^ (a - 1) * Complex.cos (b * t)) volume 0
          (Real.pi / 2) ∧
      (∫ t in (0 : ℝ)..(Real.pi / 2),
          (Complex.cos (t : ℂ)) ^ (a - 1) * Complex.cos (b * t)) =
        Real.pi / (2 : ℂ) ^ a /
          (a * meromorphicBeta ((a + b + 1) / 2) ((a - b + 1) / 2))
```
:::
::::

::::dlmfEntry "5.12.6" "https://dlmf.nist.gov/5.12.E6"
For `Re a>0`,
$$`\int_0^\pi(\sin t)^{a-1}e^{ibt}\,dt
 =\frac{\pi}{2^{a-1}}\frac{e^{i\pi b/2}}{a\,\mathrm{B}((a+b+1)/2,(a-b+1)/2)}.`

This is the corresponding complex Fourier form.  Its finite-interval convergence is
stated explicitly, while the source's single condition `Re a>0` is unchanged; the beta
quotient is written as `meromorphicBeta` because `b` is unrestricted, with
`meromorphicBetaDefined` excluding its poles and `a=0` excluding the displayed divisor.

:::leanStatement "Lean statement · sine-power Fourier integral"
```anchor dlmf_5_12_6 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_6 {a b : ℂ} (ha : 0 < a.re) (ha0 : a ≠ 0)
    (hβ : meromorphicBetaDefined ((a + b + 1) / 2) ((a - b + 1) / 2)) :
    IntervalIntegrable
        (fun t : ℝ ↦ (Complex.sin (t : ℂ)) ^ (a - 1) * Complex.exp (Complex.I * b * t)) volume 0
          Real.pi ∧
      (∫ t in (0 : ℝ)..Real.pi,
          (Complex.sin (t : ℂ)) ^ (a - 1) * Complex.exp (Complex.I * b * t)) =
        Real.pi / (2 : ℂ) ^ (a - 1) * Complex.exp (Complex.I * Real.pi * b / 2) /
          (a * meromorphicBeta ((a + b + 1) / 2) ((a - b + 1) / 2))
```
:::
::::

::::dlmfEntry "5.12.7" "https://dlmf.nist.gov/5.12.E7"
For `Re a>|Re b|`,
$$`\int_0^\infty\frac{\cosh(2bt)}{(\cosh t)^{2a}}\,dt
 =4^{a-1}\mathrm{B}(a+b,a-b).`

The strict inequality is written as `|b.re| < a.re`; `IntegrableOn (Ioi 0)` makes the
improper convergence domain part of the declaration.  No real-variable specialization
has been introduced.

:::leanStatement "Lean statement · hyperbolic beta integral"
```anchor dlmf_5_12_7 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_7 {a b : ℂ} (hab : |b.re| < a.re) :
    IntegrableOn
        (fun t : ℝ ↦ Complex.cosh (2 * b * t) / (Complex.cosh (t : ℂ)) ^ (2 * a)) (Ioi 0) ∧
      (∫ t in Ioi (0 : ℝ),
          Complex.cosh (2 * b * t) / (Complex.cosh (t : ℂ)) ^ (2 * a)) =
        (4 : ℂ) ^ (a - 1) * Complex.betaIntegral (a + b) (a - b)
```
:::
::::

::::dlmfEntry "5.12.8" "https://dlmf.nist.gov/5.12.E8"
For `Re(a+b)>1`, `Re w>0`, and `Re z>0`,
$$`\frac1{2\pi}\int_{-\infty}^{\infty}
\frac{dt}{(w+it)^a(z-it)^b}
 =\frac{(w+z)^{1-a-b}}{(a+b-1)\mathrm{B}(a,b)}.`

The vertical Fourier integral is expressed over the real parameter `t`; its integrability
and all three source domain constraints are explicit.  The source allows `a` and `b`
outside the two positive half-planes, so the right side uses the meromorphic continuation
`meromorphicBeta` rather than `Complex.betaIntegral`; `meromorphicBetaDefined` excludes
the Gamma pole locus.

:::leanStatement "Lean statement · vertical-line beta integral"
```anchor dlmf_5_12_8 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_8 {a b w z : ℂ} (hab : 1 < (a + b).re) (hw : 0 < w.re) (hz : 0 < z.re)
    (hβ : meromorphicBetaDefined a b) :
    Integrable
        (fun t : ℝ ↦ 1 / ((w + Complex.I * t) ^ a * (z - Complex.I * t) ^ b)) ∧
      (1 / (2 * Real.pi : ℂ)) *
          (∫ t : ℝ, 1 / ((w + Complex.I * t) ^ a * (z - Complex.I * t) ^ b)) =
        (w + z) ^ (1 - a - b) /
          ((a + b - 1) * meromorphicBeta a b)
```
:::
::::

::::dlmfEntry "5.12.9" "https://dlmf.nist.gov/5.12.E9"
For `0<c<1` and `Re(a+b)>0`,
$$`\frac1{2\pi i}\int_{c-i\infty}^{c+i\infty}
t^{-a}(1-t)^{-1-b}\,dt=\frac1{b\,\mathrm{B}(a,b)}.`

Writing the contour parameter as `t=c+iy` contributes the factor `i` in the integrand.
The real-line integrability assertion, strip condition, and half-plane condition are all
retained.  Because `b` is unrestricted, the denominator uses the meromorphic continuation
`meromorphicBeta`; the explicit `b ≠ 0` and `meromorphicBetaDefined` hypotheses keep the
displayed quotient finite.

:::leanStatement "Lean statement · Barnes contour"
```anchor dlmf_5_12_9 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_9 {a b : ℂ} {c : ℝ} (hc0 : 0 < c) (hc1 : c < 1)
    (hab : 0 < (a + b).re) (hb0 : b ≠ 0) (hβ : meromorphicBetaDefined a b) :
    Integrable
        (fun y : ℝ ↦ (c + Complex.I * y) ^ (-a) *
          (1 - (c + Complex.I * y)) ^ (-1 - b) * Complex.I) ∧
      (1 / (2 * Real.pi * Complex.I)) *
          (∫ y : ℝ, (c + Complex.I * y) ^ (-a) *
            (1 - (c + Complex.I * y)) ^ (-1 - b) * Complex.I) =
        1 / (b * meromorphicBeta a b)
```
:::
::::

::::dlmfEntry "5.12.10" "https://dlmf.nist.gov/5.12.E10"
For `Re a>0`, with the contour circling `1` positively as shown in DLMF Figure 5.12.1,
$$`\frac1{2\pi i}\int_0^{(1+)}t^{a-1}(t-1)^{b-1}\,dt
 =\frac{\sin(\pi b)}\pi\mathrm{B}(a,b).`

`betaFirstLoopIntegral` records the oriented loop and keeps the branch-sensitive
integrand visible.  E10 uses the source's pointwise principal powers; its explicit
continuous-branch exception begins only in E11 and E12.  The unrestricted second beta
parameter is represented by `meromorphicBeta`.

:::leanStatement "Lean statement · first loop integral"
```anchor contourIntegral (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def contourIntegral (f : ℂ → ℂ) (curve : ℝ → ℂ) : ℂ :=
  ∫ u in (0 : ℝ)..1, f (curve u) * deriv curve u
```

```anchor betaFirstLoopIntegral (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaFirstLoopIntegral (f : ℂ → ℂ) : ℂ :=
  contourIntegral f (fun u : ℝ ↦
    1 + Complex.exp ((Real.pi + 2 * Real.pi * (u : ℂ)) * Complex.I))
```

```anchor dlmf_5_12_10 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_10 {a b : ℂ} (ha : 0 < a.re)
    (hβ : meromorphicBetaDefined a b) :
    (1 / (2 * Real.pi * Complex.I)) *
        betaFirstLoopIntegral (fun t : ℂ ↦ t ^ (a - 1) * (t - 1) ^ (b - 1)) =
        Complex.sin (Real.pi * b) / Real.pi * meromorphicBeta a b
```
:::
::::

::::dlmfEntry "5.12.11" "https://dlmf.nist.gov/5.12.E11"
When `Re b>0`, `a` is not an integer, and the cut lies between `-1` and `0`,
$$`\frac1{e^{2\pi ia}-1}\int_\infty^{(0+)}
t^{a-1}(1+t)^{-a-b}\,dt=\mathrm{B}(a,b).`

The theorem preserves the nonintegrality hypothesis as `a ≠ n` for every integer `n`.
`betaSecondLoopIntegral` is the limit of finite Hankel truncations: an incoming positive
ray from `R` to `ε`, a positively oriented circle around `0`, and an outgoing positive
ray from `ε` back to `R`.  `SecondLoopLogBranch` carries one global pair of logarithm
lifts: continuity on the positive-ray/small-circle domains, pointwise exponential
equations for `t` and `1+t` there, principal values on the incoming ray, and
endpoint/monodromy equations at the circle joins.  Every finite
truncation restricts this same datum, so branch choices cannot vary with `R`.  The
meromorphic beta quotient is used on the right, with `meromorphicBetaDefined` excluding
its poles.

:::leanStatement "Lean statement · second loop integral"
```anchor SecondLoopLogBranch (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
structure SecondLoopLogBranch (a b : ℂ) where
  logTIncoming : ℝ → ℂ
  logOnePlusIncoming : ℝ → ℂ
  logTCircle : ℝ → ℝ → ℂ
  logOnePlusCircle : ℝ → ℝ → ℂ
  logTOutgoing : ℝ → ℂ
  logOnePlusOutgoing : ℝ → ℂ
  incoming_t_continuous : ContinuousOn logTIncoming (Ioi 0)
  incoming_one_continuous : ContinuousOn logOnePlusIncoming (Ioi 0)
  circle_t_continuous : ∀ ε : ℝ, 0 < ε → ε < 1 → Continuous (logTCircle ε)
  circle_one_continuous : ∀ ε : ℝ, 0 < ε → ε < 1 → Continuous (logOnePlusCircle ε)
  outgoing_t_continuous : ContinuousOn logTOutgoing (Ioi 0)
  outgoing_one_continuous : ContinuousOn logOnePlusOutgoing (Ioi 0)
  incoming_t_exp : ∀ r : ℝ, 0 < r →
    Complex.exp (logTIncoming r) = (r : ℂ)
  incoming_one_exp : ∀ r : ℝ, 0 < r →
    Complex.exp (logOnePlusIncoming r) = 1 + (r : ℂ)
  circle_t_exp : ∀ ε θ : ℝ, 0 < ε → ε < 1 →
    Complex.exp (logTCircle ε θ) = (ε : ℂ) * Complex.exp ((θ : ℂ) * Complex.I)
  circle_one_exp : ∀ ε θ : ℝ, 0 < ε → ε < 1 →
    Complex.exp (logOnePlusCircle ε θ) =
      1 + (ε : ℂ) * Complex.exp ((θ : ℂ) * Complex.I)
  outgoing_t_exp : ∀ r : ℝ, 0 < r →
    Complex.exp (logTOutgoing r) = (r : ℂ)
  outgoing_one_exp : ∀ r : ℝ, 0 < r →
    Complex.exp (logOnePlusOutgoing r) = 1 + (r : ℂ)
  incoming_t_principal : ∀ r : ℝ, 0 < r →
    logTIncoming r = Complex.log (r : ℂ)
  incoming_one_principal : ∀ r : ℝ, 0 < r →
    logOnePlusIncoming r = Complex.log (1 + (r : ℂ))
  circle_t_starts : ∀ ε : ℝ, 0 < ε → ε < 1 →
    logTCircle ε 0 = logTIncoming ε
  circle_one_starts : ∀ ε : ℝ, 0 < ε → ε < 1 →
    logOnePlusCircle ε 0 = logOnePlusIncoming ε
  outgoing_t_starts : ∀ ε : ℝ, 0 < ε → ε < 1 →
    logTOutgoing ε = logTCircle ε (2 * Real.pi)
  outgoing_one_starts : ∀ ε : ℝ, 0 < ε → ε < 1 →
    logOnePlusOutgoing ε = logOnePlusCircle ε (2 * Real.pi)
```

```anchor betaSecondLoopTruncation (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaSecondLoopTruncation {a b : ℂ}
    (branch : SecondLoopLogBranch a b) (R : ℝ) (_hR : 1 < R) : ℂ :=
  let ε : ℝ := 1 / R
  ∫ r in R..ε,
      Complex.exp ((a - 1) * branch.logTIncoming r) *
        Complex.exp ((-a - b) * branch.logOnePlusIncoming r) +
    ∫ θ in (0 : ℝ)..(2 * Real.pi),
      (Complex.exp ((a - 1) * branch.logTCircle ε θ) *
        Complex.exp ((-a - b) * branch.logOnePlusCircle ε θ)) *
        ((ε : ℂ) * Complex.I * Complex.exp ((θ : ℂ) * Complex.I)) +
    ∫ r in (ε : ℝ)..(R : ℝ),
      Complex.exp ((a - 1) * branch.logTOutgoing r) *
        Complex.exp ((-a - b) * branch.logOnePlusOutgoing r)
```

```anchor betaSecondLoopIntegral (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaSecondLoopIntegral {a b : ℂ}
    (branch : SecondLoopLogBranch a b) : ℂ :=
  Filter.limUnder atTop (fun R : ℝ ↦
    if hR : 1 < R then betaSecondLoopTruncation branch R hR else 0)
```

```anchor dlmf_5_12_11 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_11 {a b : ℂ}
    (branch : SecondLoopLogBranch a b)
    (hb : 0 < b.re) (ha : ∀ n : ℤ, a ≠ n) (hβ : meromorphicBetaDefined a b) :
    1 / (Complex.exp (2 * Real.pi * Complex.I * a) - 1) *
        betaSecondLoopIntegral branch = meromorphicBeta a b
```
:::
::::

::::dlmfEntry "5.12.12" "https://dlmf.nist.gov/5.12.E12"
For arbitrary `a,b∈ℂ`, with the Pochhammer contour starting at `P∈(0,1)` and traversing
the loops `(1+,0+,1-,0-)`,
$$`\int_P^{(1+,0+,1-,0-)}t^{a-1}(1-t)^{b-1}\,dt
 =-4e^{\pi i(a+b)}\sin(\pi a)\sin(\pi b)\mathrm{B}(a,b).`

`betaPochhammerCurve` parameterizes the source's arbitrary base point `P ∈ (0,1)` and
the four loops `(1+,0+,1-,0-)`.  `PochhammerLogBranch` supplies continuous logarithm
lifts on the parameter interval, tied pointwise to both `t` and `1-t` under `0<P<1`,
with principal logarithms at `P`; the theorem
therefore does not replace continuation by independent pointwise principal powers.  The
beta factor is the meromorphic `meromorphicBeta` quotient, with
`meromorphicBetaDefined` making this an explicit specialization away from poles.

:::leanStatement "Lean statement · Pochhammer integral"
```anchor PochhammerLogBranch (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
structure PochhammerLogBranch (a b : ℂ) (P : ℝ) where
  logT : ℝ → ℂ
  logOneMinusT : ℝ → ℂ
  t_continuous : ContinuousOn logT (Icc 0 1)
  one_minus_t_continuous : ContinuousOn logOneMinusT (Icc 0 1)
  t_exp : ∀ u : ℝ, 0 < P → P < 1 →
    Complex.exp (logT u) = betaPochhammerCurve P u
  one_minus_t_exp : ∀ u : ℝ, 0 < P → P < 1 →
    Complex.exp (logOneMinusT u) = 1 - betaPochhammerCurve P u
  t_principal_at_start : 0 < P → P < 1 → logT 0 = Complex.log (P : ℂ)
  one_minus_t_principal_at_start : 0 < P → P < 1 →
    logOneMinusT 0 = Complex.log (1 - (P : ℂ))
```

```anchor betaPochhammerIntegral (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
noncomputable def betaPochhammerIntegral {a b : ℂ} {P : ℝ}
    (branch : PochhammerLogBranch a b P) : ℂ :=
  ∫ u in (0 : ℝ)..1,
    (Complex.exp ((a - 1) * branch.logT u) *
      Complex.exp ((b - 1) * branch.logOneMinusT u)) * deriv (betaPochhammerCurve P) u
```

```anchor dlmf_5_12_12 (module := LMLF.Blueprint.Gamma.Section512) -showProofStates
theorem dlmf_5_12_12 (a b : ℂ) {P : ℝ}
    (hP0 : 0 < P) (hP1 : P < 1) (branch : PochhammerLogBranch a b P)
    (hβ : meromorphicBetaDefined a b) :
    betaPochhammerIntegral branch =
      -4 * Complex.exp (Real.pi * Complex.I * (a + b)) * Complex.sin (Real.pi * a) *
        Complex.sin (Real.pi * b) * meromorphicBeta a b
```
:::
::::
