import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section423
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.Elementary.Section423
set_option verso.exampleProject "."

#doc (Manual) "§4.23 Inverse Trigonometric Functions" =>
%%%
tag := "chapter-4-section-23"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.23"
Source: NIST Digital Library of Mathematical Functions, §4.23.
:::

# §4.23 Inverse Trigonometric Functions
%%%
number := false
%%%

DLMF §4.23 separates multivalued inverse relations from principal branches.
The formulas state their real and complex domains, exceptional points,
cut predicates, and signed boundary parameters. The table and figure records
are formalized as source-linked disclosures.

The typed path objects below make the DLMF continuation data visible at the
point of use: every curve has oriented endpoints, a stored tangent with a
within-derivative certificate on `[0,1]`, interior avoidance conditions, and
the continued square-root branch. Their `integrable` fields require the
displayed ordinary interval integrands to be `IntervalIntegrable`; this is the
finite-integral encoding used here when a DLMF endpoint is a branch point. An
endpoint branch point is therefore allowed only when the resulting improper
singularity has an integrable representative; no totalized ambient `deriv` is
used.

:::leanStatement "DLMF 4.23 — square-root continuation object"
```anchor SqrtContinuation (module := LMLF.Blueprint.Elementary.Section423)
structure SqrtContinuation (a : ℂ) where
  referencePoint : ℝ
  referenceInterior : -1 < referencePoint ∧ referencePoint < 1
  curve : ℝ → ℂ
  start : curve 0 = (referencePoint : ℂ)
  finish : curve 1 = a
  continuous : Continuous curve
  tangent : ℝ → ℂ
  hasDeriv : ∀ t ∈ Set.Icc (0 : ℝ) 1,
    HasDerivWithinAt curve (tangent t) (Set.Icc 0 1) t
  tangentContinuous : ContinuousOn tangent (Set.Icc (0 : ℝ) 1)
  avoids : ∀ t, 0 < t → t < 1 → curve t ≠ 1 ∧ curve t ≠ -1
  squareRootBranch : ℝ → ℂ
  branchContinuous : Continuous squareRootBranch
  principalAtReference : squareRootBranch 0 =
    Complex.sqrt (1 - (referencePoint : ℂ) ^ 2)
  branchEquation : ∀ t, squareRootBranch t ^ 2 = 1 - (curve t) ^ 2
```
:::
:::leanStatement "DLMF 4.23 — continued square-root path"
```anchor SqrtPath (module := LMLF.Blueprint.Elementary.Section423)
structure SqrtPath (a b : ℂ) where
  curve : ℝ → ℂ
  start : curve 0 = a
  finish : curve 1 = b
  continuous : Continuous curve
  tangent : ℝ → ℂ
  hasDeriv : ∀ t ∈ Set.Icc (0 : ℝ) 1,
    HasDerivWithinAt curve (tangent t) (Set.Icc 0 1) t
  tangentContinuous : ContinuousOn tangent (Set.Icc (0 : ℝ) 1)
  avoids : ∀ t, 0 < t → t < 1 → curve t ≠ 1 ∧ curve t ≠ -1
  squareRootBranch : ℝ → ℂ
  branchContinuous : Continuous squareRootBranch
  branchEquation : ∀ t, squareRootBranch t ^ 2 = 1 - (curve t) ^ 2
  continuation : SqrtContinuation a
  branchAtContinuation : squareRootBranch 0 = continuation.squareRootBranch 1
  integrable : IntervalIntegrable
    (fun t => tangent t / squareRootBranch t) volume 0 1
```
:::
:::leanStatement "DLMF 4.23 — square-root path integral"
```anchor SqrtPath.integral (module := LMLF.Blueprint.Elementary.Section423)
def SqrtPath.integral (P : SqrtPath a b) : ℂ :=
  ∫ t in (0 : ℝ)..1, P.tangent t / P.squareRootBranch t
```
:::
:::leanStatement "DLMF 4.23 — rational continuation path"
```anchor RationalPath (module := LMLF.Blueprint.Elementary.Section423)
structure RationalPath (a b : ℂ) where
  curve : ℝ → ℂ
  start : curve 0 = a
  finish : curve 1 = b
  continuous : Continuous curve
  tangent : ℝ → ℂ
  hasDeriv : ∀ t ∈ Set.Icc (0 : ℝ) 1,
    HasDerivWithinAt curve (tangent t) (Set.Icc 0 1) t
  tangentContinuous : ContinuousOn tangent (Set.Icc (0 : ℝ) 1)
  avoids : ∀ t, 0 < t → t < 1 → curve t ≠ Complex.I ∧ curve t ≠ -Complex.I
  integrable : IntervalIntegrable
    (fun t => tangent t / (1 + curve t ^ 2)) volume 0 1
```
:::
:::leanStatement "DLMF 4.23 — rational path integral"
```anchor RationalPath.integral (module := LMLF.Blueprint.Elementary.Section423)
def RationalPath.integral (P : RationalPath a b) : ℂ :=
  ∫ t in (0 : ℝ)..1, P.tangent t / (1 + P.curve t ^ 2)
```
:::

::::dlmfEntry "4.23.1–9" "https://dlmf.nist.gov/4.23.E1"
General values are explicit sine, cosine, tangent, and reciprocal equations.
Source formula: https://dlmf.nist.gov/4.23.E1
$$`\operatorname{Arcsin}z=\int_{0}^{z}\frac{\,\mathrm{d}t}{(1-t^{2})^{1/2}},`
:::leanStatement "DLMF 4.23.E1 — https://dlmf.nist.gov/4.23.E1"
```anchor dlmf_4_23_1 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_1 (z : ℂ) :
    ∃ P : SqrtPath 0 z, Complex.sin P.integral = z
```
:::
Source formula: https://dlmf.nist.gov/4.23.E2
$$`\operatorname{Arccos}z=\int_{z}^{1}\frac{\,\mathrm{d}t}{(1-t^{2})^{1/2}},`
:::leanStatement "DLMF 4.23.E2 — https://dlmf.nist.gov/4.23.E2"
```anchor dlmf_4_23_2 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_2 (z : ℂ) :
    ∃ P : SqrtPath z 1, Complex.cos P.integral = z
```
:::
Source formula: https://dlmf.nist.gov/4.23.E3
$$`\operatorname{Arctan}z=\int_{0}^{z}\frac{\,\mathrm{d}t}{1+t^{2}},`
:::leanStatement "DLMF 4.23.E3 — https://dlmf.nist.gov/4.23.E3"
```anchor dlmf_4_23_3 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_3 (z : ℂ) (hz : z ≠ Complex.I) (hz' : z ≠ -Complex.I) :
    ∃ P : RationalPath 0 z, Complex.tan P.integral = z
```
:::
Source formula: https://dlmf.nist.gov/4.23.E4
$$`\operatorname{Arccsc}z=\operatorname{Arcsin}\left(1/z\right),`
:::leanStatement "DLMF 4.23.E4 — https://dlmf.nist.gov/4.23.E4"
```anchor dlmf_4_23_4 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_4 (z w : ℂ) (hz : z ≠ 0) :
    generalArccscValue z w ↔ generalArcsinValue (1 / z) w
```
:::
Source formula: https://dlmf.nist.gov/4.23.E5
$$`\operatorname{Arcsec}z=\operatorname{Arccos}\left(1/z\right).`
:::leanStatement "DLMF 4.23.E5 — https://dlmf.nist.gov/4.23.E5"
```anchor dlmf_4_23_5 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_5 (z w : ℂ) (hz : z ≠ 0) :
    generalArcsecValue z w ↔ generalArccosValue (1 / z) w
```
:::
Source formula: https://dlmf.nist.gov/4.23.E6
$$`\operatorname{Arccot}z=\operatorname{Arctan}\left(1/z\right).`
:::leanStatement "DLMF 4.23.E6 — https://dlmf.nist.gov/4.23.E6"
```anchor dlmf_4_23_6 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_6 (z w : ℂ) (hz : z ≠ 0) (hi : z ≠ Complex.I) (hi' : z ≠ -Complex.I) :
    generalArccotValue z w ↔ generalArctanValue (1 / z) w
```
:::
Source formula: https://dlmf.nist.gov/4.23.E7
$$`\operatorname{arccsc}z=\operatorname{arcsin}\left(1/z\right),`
:::leanStatement "DLMF 4.23.E7 — https://dlmf.nist.gov/4.23.E7"
```anchor dlmf_4_23_7 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_7 (z : ℂ) (hz : z ≠ 0) : principalArccsc z = principalArcsin (1 / z)
```
:::
Source formula: https://dlmf.nist.gov/4.23.E8
$$`\operatorname{arcsec}z=\operatorname{arccos}\left(1/z\right).`
:::leanStatement "DLMF 4.23.E8 — https://dlmf.nist.gov/4.23.E8"
```anchor dlmf_4_23_8 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_8 (z : ℂ) (hz : z ≠ 0) : principalArcsec z = principalArccos (1 / z)
```
:::
Source formula: https://dlmf.nist.gov/4.23.E9
$$`\operatorname{arccot}z=\operatorname{arctan}\left(1/z\right),`
:::leanStatement "DLMF 4.23.E9 — https://dlmf.nist.gov/4.23.E9"
```anchor dlmf_4_23_9 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_9 (z : ℂ) (hz : z ≠ Complex.I) (hz' : z ≠ -Complex.I) : principalArccot z = principalArctan (1 / z)
```
:::
::::

The general inverse functions E1--E6 are multivalued continuations. E1 uses a
continued square-root path from `0` to `z`, E2 one from `z` to `1`, and E3 a
rational path from `0` to `z` avoiding `±i`. The reciprocal formulas E4--E6
carry the corresponding endpoints `0` to `1/z`, `1/z` to `1`, and `0` to
`1/z`; their forbidden points and branch equations are therefore not silently
identified. Each square-root path carries a continuation from a real reference
point in `(-1,1)`, where the principal square root is fixed, to its path start;
its integral uses the continued branch along the defining path. The stored
tangent and explicit `IntervalIntegrable` field make these ordinary interval
integrals honest even when a DLMF endpoint is a branch point: the endpoint is
allowed only when the corresponding improper singularity has a finite
integrable representative. The arctangent and arccotangent path statements
explicitly exclude `±i`.

DLMF principal values are used throughout unless explicitly stated otherwise.
The principal branches are analytic on their displayed cut-plane domains,
two-valued on the cuts, and real on the surviving real-axis pieces. Figure
4.23.1 records these branch cuts in its four panels. Thus the principal
specializations E7--E27 are single-valued only off the cuts; their boundary
formulas use an explicit side sign and are not evaluations of one totalized
value on a cut.

The logarithmic identity E19 and its analogues are verified by the same
inverse-function/logarithm argument, with the stated principal domains and
cuts. In E34--E36, `z = x + i y` and the displayed hypotheses specialize the
coordinate formulas to the corresponding cut-plane or disk domains. The
corrected editorial convention uses `sign(y)` and the generalized cut
condition in E34--E35; this page records those corrected forms. The associated
annotation cites Dempsey (2025). The E38 annotation cites Fletcher et al.; its
formula is checked by differentiation together with the value at zero.

For E31--E33, the integer shifts and the arccosine sign are existentially
selected for a given solution. The table distinguishes dashes, ordinary
values, and the one-sided arccotangent zero entry. Figure 4.23.1 records the
branch cuts for the principal functions; the geometric drawing itself is not
an additional formal object.

::::dlmfEntry "4.23.10–18" "https://dlmf.nist.gov/4.23.E10"
Branch identities include both E18 sign alternatives.
Source formula: https://dlmf.nist.gov/4.23.E10
$$`\operatorname{arcsin}\left(-z\right)=-\operatorname{arcsin}z,`
:::leanStatement "DLMF 4.23.E10 — https://dlmf.nist.gov/4.23.E10"
```anchor dlmf_4_23_10 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_10 (z : ℂ) (hz : principalArcsinDomain z) : principalArcsin (-z) = -principalArcsin z
```
:::
Source formula: https://dlmf.nist.gov/4.23.E11
$$`\operatorname{arccos}\left(-z\right)=\pi-\operatorname{arccos}z.`
:::leanStatement "DLMF 4.23.E11 — https://dlmf.nist.gov/4.23.E11"
```anchor dlmf_4_23_11 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_11 (z : ℂ) (hz : principalArcsinDomain z) : principalArccos (-z) = Real.pi - principalArccos z
```
:::
Source formula: https://dlmf.nist.gov/4.23.E12
$$`\operatorname{arctan}\left(-z\right)=-\operatorname{arctan}z,`
:::leanStatement "DLMF 4.23.E12 — https://dlmf.nist.gov/4.23.E12"
```anchor dlmf_4_23_12 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_12 (z : ℂ) (hz : principalArctanDomain z) (hz' : principalArctanDomain (-z)) : principalArctan (-z) = -principalArctan z
```
:::
Source formula: https://dlmf.nist.gov/4.23.E13
$$`\operatorname{arccsc}\left(-z\right)=-\operatorname{arccsc}z,`
:::leanStatement "DLMF 4.23.E13 — https://dlmf.nist.gov/4.23.E13"
```anchor dlmf_4_23_13 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_13 (z : ℂ) (hz : z ≠ 0) (hc : principalArcsinDomain (1 / z)) (hc' : principalArcsinDomain (-1 / z)) : principalArccsc (-z) = -principalArccsc z
```
:::
Source formula: https://dlmf.nist.gov/4.23.E14
$$`\operatorname{arcsec}\left(-z\right)=\pi-\operatorname{arcsec}z.`
:::leanStatement "DLMF 4.23.E14 — https://dlmf.nist.gov/4.23.E14"
```anchor dlmf_4_23_14 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_14 (z : ℂ) (hz : z ≠ 0) (hc : principalArcsinDomain (1 / z)) (hc' : principalArcsinDomain (-1 / z)) : principalArcsec (-z) = Real.pi - principalArcsec z
```
:::
Source formula: https://dlmf.nist.gov/4.23.E15
$$`\operatorname{arccot}\left(-z\right)=-\operatorname{arccot}z,`
:::leanStatement "DLMF 4.23.E15 — https://dlmf.nist.gov/4.23.E15"
```anchor dlmf_4_23_15 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_15 (z : ℂ) (hz : z ≠ 0) (hc : principalArctanDomain (1 / z)) (hc' : principalArctanDomain (-1 / z)) : principalArccot (-z) = -principalArccot z
```
:::
Source formula: https://dlmf.nist.gov/4.23.E16
$$`\operatorname{arccos}z=\tfrac{1}{2}\pi-\operatorname{arcsin}z,`
:::leanStatement "DLMF 4.23.E16 — https://dlmf.nist.gov/4.23.E16"
```anchor dlmf_4_23_16 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_16 (z : ℂ) (hz : principalArcsinDomain z) : principalArccos z = Real.pi / 2 - principalArcsin z
```
:::
Source formula: https://dlmf.nist.gov/4.23.E17
$$`\operatorname{arcsec}z=\tfrac{1}{2}\pi-\operatorname{arccsc}z.`
:::leanStatement "DLMF 4.23.E17 — https://dlmf.nist.gov/4.23.E17"
```anchor dlmf_4_23_17 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_17 (z : ℂ) (hz : z ≠ 0) (hd : principalArcsinDomain (1 / z)) : principalArcsec z = Real.pi / 2 - principalArccsc z
```
:::
Source formula: https://dlmf.nist.gov/4.23.E18
$$`\operatorname{arccot}z=\pm\tfrac{1}{2}\pi-\operatorname{arctan}z,`
:::leanStatement "DLMF 4.23.E18 — https://dlmf.nist.gov/4.23.E18"
```anchor dlmf_4_23_18 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_18 {z : ℂ} (hz : z.re ≠ 0) (he : z ≠ Complex.I) (he' : z ≠ -Complex.I) : (0 < z.re → principalArccot z = Real.pi / 2 - principalArctan z) ∧ (z.re < 0 → principalArccot z = -Real.pi / 2 - principalArctan z)
```
:::
::::

::::dlmfEntry "4.23.19–27" "https://dlmf.nist.gov/4.23.E19"
Principal logarithms, transformed cuts, and boundary signs are explicit.
Source formula: https://dlmf.nist.gov/4.23.E19
$$`\operatorname{arcsin}z=-i\ln\left((1-z^{2})^{1/2}+iz\right),`
:::leanStatement "DLMF 4.23.E19 — https://dlmf.nist.gov/4.23.E19"
```anchor dlmf_4_23_19 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_19 {z : ℂ} (hcut : principalArcsinDomain z) : principalArcsin z = -Complex.I * Complex.log (Complex.sqrt (1 - z ^ 2) + Complex.I * z)
```
:::
Source formula: https://dlmf.nist.gov/4.23.E20
$$`\operatorname{arcsin}x=\tfrac{1}{2}\pi\pm i\ln\left((x^{2}-1)^{1/2}+x\right),`
:::leanStatement "DLMF 4.23.E20 — https://dlmf.nist.gov/4.23.E20"
```anchor dlmf_4_23_20 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_20 {x s : ℝ} (hx : 1 ≤ x) (hs : boundarySign s) : boundaryLimit principalArcsin x s (Real.pi / 2 + s * Complex.I * Complex.log (Real.sqrt (x ^ 2 - 1) + x))
```
:::
Source formula: https://dlmf.nist.gov/4.23.E21
$$`\operatorname{arcsin}x=-\tfrac{1}{2}\pi\pm i\ln\left((x^{2}-1)^{1/2}-x\right),`
:::leanStatement "DLMF 4.23.E21 — https://dlmf.nist.gov/4.23.E21"
```anchor dlmf_4_23_21 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_21 {x s : ℝ} (hx : x ≤ -1) (hs : boundarySign s) : boundaryLimit principalArcsin x s (-Real.pi / 2 + s * Complex.I * Complex.log (Real.sqrt (x ^ 2 - 1) - x))
```
:::
Source formula: https://dlmf.nist.gov/4.23.E22
$$`\operatorname{arccos}z=\tfrac{1}{2}\pi+i\ln\left((1-z^{2})^{1/2}+iz\right),`
:::leanStatement "DLMF 4.23.E22 — https://dlmf.nist.gov/4.23.E22"
```anchor dlmf_4_23_22 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_22 {z : ℂ} (hcut : principalArcsinDomain z) : principalArccos z = Real.pi / 2 + Complex.I * Complex.log (Complex.sqrt (1 - z ^ 2) + Complex.I * z)
```
:::
Source formula: https://dlmf.nist.gov/4.23.E23
$$`\operatorname{arccos}z=-2i\ln\left(\left(\frac{1+z}{2}\right)^{1/2}+i\left(\frac{1-z}{2}\right)^{1/2}\right),`
:::leanStatement "DLMF 4.23.E23 — https://dlmf.nist.gov/4.23.E23"
```anchor dlmf_4_23_23 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_23 {z : ℂ} (hcut : principalArcsinDomain z) :
    principalArccos z = -2 * Complex.I * Complex.log
      (Complex.sqrt ((1 + z) / 2) + Complex.I * Complex.sqrt ((1 - z) / 2))
```
:::
Source formula: https://dlmf.nist.gov/4.23.E24
$$`\operatorname{arccos}x=\mp i\ln\left((x^{2}-1)^{1/2}+x\right),`
:::leanStatement "DLMF 4.23.E24 — https://dlmf.nist.gov/4.23.E24"
```anchor dlmf_4_23_24 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_24 {x s : ℝ} (hx : 1 ≤ x) (hs : boundarySign s) : boundaryLimit principalArccos x s (s * Complex.I * Complex.log (Real.sqrt (x ^ 2 - 1) + x))
```
:::
Source formula: https://dlmf.nist.gov/4.23.E25
$$`\operatorname{arccos}x=\pi\mp i\ln\left((x^{2}-1)^{1/2}-x\right),`
:::leanStatement "DLMF 4.23.E25 — https://dlmf.nist.gov/4.23.E25"
```anchor dlmf_4_23_25 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_25 {x s : ℝ} (hx : x ≤ -1) (hs : boundarySign s) : boundaryLimit principalArccos x s (Real.pi + s * Complex.I * Complex.log (Real.sqrt (x ^ 2 - 1) - x))
```
:::
Source formula: https://dlmf.nist.gov/4.23.E26
$$`\operatorname{arctan}z=\frac{i}{2}\ln\left(\frac{i+z}{i-z}\right),`
:::leanStatement "DLMF 4.23.E26 — https://dlmf.nist.gov/4.23.E26"
```anchor dlmf_4_23_26 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_26 {z : ℂ} (hcut : principalArctanDomain z) : principalArctan z = Complex.I / 2 * Complex.log ((Complex.I + z) / (Complex.I - z))
```
:::
Source formula: https://dlmf.nist.gov/4.23.E27
$$`\operatorname{arctan}\left(iy\right)=\pm\frac{1}{2}\pi+\frac{i}{2}\ln\left(\frac{y+1}{y-1}\right),`
:::leanStatement "DLMF 4.23.E27 — https://dlmf.nist.gov/4.23.E27"
```anchor dlmf_4_23_27 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_27 {y s : ℝ} (hy : y < -1 ∨ 1 < y) (hs : boundarySign s) : imaginaryCutBoundaryLimit principalArctan y s (s * Real.pi / 2 + Complex.I / 2 * Complex.log ((y + 1) / (y - 1)))
```
:::
::::

::::dlmfEntry "4.23.28–33" "https://dlmf.nist.gov/4.23.E28"
Solution sets retain integer shifts and the two arccosine signs.
Source formula: https://dlmf.nist.gov/4.23.E28
$$`z=\sin w,`
:::leanStatement "DLMF 4.23.E28 — https://dlmf.nist.gov/4.23.E28"
```anchor dlmf_4_23_28 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_28 {z w : ℂ} : w ∈ {u : ℂ | Complex.sin u = z} ↔ generalArcsinValue z w
```
:::
Source formula: https://dlmf.nist.gov/4.23.E29
$$`z=\cos w,`
:::leanStatement "DLMF 4.23.E29 — https://dlmf.nist.gov/4.23.E29"
```anchor dlmf_4_23_29 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_29 {z w : ℂ} : w ∈ {u : ℂ | Complex.cos u = z} ↔ generalArccosValue z w
```
:::
Source formula: https://dlmf.nist.gov/4.23.E30
$$`z=\tan w,`
:::leanStatement "DLMF 4.23.E30 — https://dlmf.nist.gov/4.23.E30"
```anchor dlmf_4_23_30 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_30 {z w : ℂ} : w ∈ {u : ℂ | Complex.tan u = z} ↔ generalArctanValue z w
```
:::
Source formula: https://dlmf.nist.gov/4.23.E31
$$`w=\operatorname{Arcsin}z=(-1)^{k}\operatorname{arcsin}z+k\pi,`
:::leanStatement "DLMF 4.23.E31 — https://dlmf.nist.gov/4.23.E31"
```anchor dlmf_4_23_31 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_31 {z w : ℂ} (h : generalArcsinValue z w) : ∃ k : ℤ, w = (-1 : ℂ) ^ k * principalArcsin z + k * Real.pi
```
:::
Source formula: https://dlmf.nist.gov/4.23.E32
$$`w=\operatorname{Arccos}z=\pm\operatorname{arccos}z+2k\pi,`
:::leanStatement "DLMF 4.23.E32 — https://dlmf.nist.gov/4.23.E32"
```anchor dlmf_4_23_32 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_32 {z w : ℂ} (h : generalArccosValue z w) : ∃ k : ℤ, ∃ ε : ℤ, (ε = 1 ∨ ε = -1) ∧ w = (if ε = 1 then (1 : ℂ) else -1) * principalArccos z + 2 * k * Real.pi
```
:::
Source formula: https://dlmf.nist.gov/4.23.E33
$$`w=\operatorname{Arctan}z=\operatorname{arctan}z+k\pi,`
:::leanStatement "DLMF 4.23.E33 — https://dlmf.nist.gov/4.23.E33"
```anchor dlmf_4_23_33 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_33 {z w : ℂ} (hz : z ≠ Complex.I) (hz' : z ≠ -Complex.I) (h : generalArctanValue z w) : ∃ k : ℤ, w = principalArctan z + k * Real.pi
```
:::
::::

::::dlmfEntry "4.23.34–38" "https://dlmf.nist.gov/4.23.E34"
Coordinate formulas use the open real-ray exclusion and disk domain.
Source formula: https://dlmf.nist.gov/4.23.E34
$$`\operatorname{arcsin}z=\operatorname{arcsin}\beta+\mathrm{i}\operatorname{sign}\left(y\right)\ln\left(\alpha+(\alpha^{2}-1)^{1/2}\right),`
:::leanStatement "DLMF 4.23.E34 — https://dlmf.nist.gov/4.23.E34"
```anchor dlmf_4_23_34 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_34 {x y : ℝ} (hcut : ¬ openRealRay (x + Complex.I * y)) : principalArcsin (x + Complex.I * y) = Real.arcsin (beta x y) + Complex.I * (if 0 < y then (1 : ℝ) else if y < 0 then -1 else 0) * Real.log (alpha x y + Real.sqrt (alpha x y ^ 2 - 1))
```
:::
Source formula: https://dlmf.nist.gov/4.23.E35
$$`\operatorname{arccos}z=\operatorname{arccos}\beta-\mathrm{i}\operatorname{sign}\left(y\right)\ln\left(\alpha+(\alpha^{2}-1)^{1/2}\right),`
:::leanStatement "DLMF 4.23.E35 — https://dlmf.nist.gov/4.23.E35"
```anchor dlmf_4_23_35 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_35 {x y : ℝ} (hcut : ¬ openRealRay (x + Complex.I * y)) : principalArccos (x + Complex.I * y) = Real.arccos (beta x y) - Complex.I * (if 0 < y then (1 : ℝ) else if y < 0 then -1 else 0) * Real.log (alpha x y + Real.sqrt (alpha x y ^ 2 - 1))
```
:::
Source formula: https://dlmf.nist.gov/4.23.E36
$$`\operatorname{arctan}z=\tfrac{1}{2}\operatorname{arctan}\left(\frac{2x}{1-x^{2}-y^{2}}\right)+\tfrac{1}{4}i\ln\left(\frac{x^{2}+(y+1)^{2}}{x^{2}+(y-1)^{2}}\right),`
:::leanStatement "DLMF 4.23.E36 — https://dlmf.nist.gov/4.23.E36"
```anchor dlmf_4_23_36 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_36 {x y : ℝ} (h : x ^ 2 + y ^ 2 < 1) : principalArctan (x + Complex.I * y) = (1 / 2 : ℝ) * Real.arctan (2 * x / (1 - x ^ 2 - y ^ 2)) + Complex.I * (1 / 4 : ℝ) * Real.log ((x ^ 2 + (y + 1) ^ 2) / (x ^ 2 + (y - 1) ^ 2))
```
:::
Source formula: https://dlmf.nist.gov/4.23.E37
$$`\alpha=\tfrac{1}{2}\left((x+1)^{2}+y^{2}\right)^{1/2}+\tfrac{1}{2}\left((x-1)^{2}+y^{2}\right)^{1/2},`
:::leanStatement "DLMF 4.23.E37 — https://dlmf.nist.gov/4.23.E37"
```anchor dlmf_4_23_37 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_37 (x y : ℝ) : alpha x y = (Real.sqrt ((x + 1) ^ 2 + y ^ 2) + Real.sqrt ((x - 1) ^ 2 + y ^ 2)) / 2
```
:::
Source formula: https://dlmf.nist.gov/4.23.E38
$$`\beta=\tfrac{1}{2}\left((x+1)^{2}+y^{2}\right)^{1/2}-\tfrac{1}{2}\left((x-1)^{2}+y^{2}\right)^{1/2}.`
:::leanStatement "DLMF 4.23.E38 — https://dlmf.nist.gov/4.23.E38"
```anchor dlmf_4_23_38 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_38 (x y : ℝ) : beta x y = (Real.sqrt ((x + 1) ^ 2 + y ^ 2) - Real.sqrt ((x - 1) ^ 2 + y ^ 2)) / 2
```
:::
::::

::::dlmfEntry "4.23.39–42" "https://dlmf.nist.gov/4.23.E39"
The E40 and E42 anchors expose every member of the official equivalence
chains, not only the first logarithmic/integral equality. E40 is stated for
`x ≠ 0` because `coth x` and `csch x` occur; E42 uses
`-π/2 < x < π/2` and `x ≠ 0` because `cot x` and `csc x` occur.
Source formula: https://dlmf.nist.gov/4.23.E39
$$`\operatorname{gd}\left(x\right)=\int_{0}^{x}\operatorname{sech}t\,\mathrm{d}t,`
:::leanStatement "DLMF 4.23.E39 — https://dlmf.nist.gov/4.23.E39"
```anchor dlmf_4_23_39 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_39 (x : ℝ) : gudermannian x = ∫ t in (0 : ℝ)..x, 1 / Real.cosh t
```
:::
Source formula: https://dlmf.nist.gov/4.23.E40
$$`\begin{aligned}\operatorname{gd}\left(x\right)&=2\operatorname{arctan}\left(e^{x}\right)-\tfrac{1}{2}\pi\\ &=\operatorname{arcsin}\left(\tanh x\right)=\operatorname{arccsc}\left(\operatorname{coth}x\right)\\ &=\operatorname{arccos}\left(\operatorname{sech}x\right)=\operatorname{arcsec}\left(\cosh x\right)\\ &=\operatorname{arctan}\left(\sinh x\right)=\operatorname{arccot}\left(\operatorname{csch}x\right).\end{aligned}`
:::leanStatement "DLMF 4.23.E40 — https://dlmf.nist.gov/4.23.E40"
```anchor dlmf_4_23_40 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_40 {x : ℝ} (hx : x ≠ 0) :
    (gudermannian x : ℂ) = ((2 * Real.arctan (Real.exp x) - Real.pi / 2 : ℝ) : ℂ) ∧
      (gudermannian x : ℂ) = principalArcsin (Real.tanh x) ∧
      (gudermannian x : ℂ) = principalArccsc (realCoth x) ∧
      (gudermannian x : ℂ) = principalArccos (realSech x) ∧
      (gudermannian x : ℂ) = principalArcsec (Real.cosh x) ∧
      (gudermannian x : ℂ) = principalArctan (Real.sinh x) ∧
      (gudermannian x : ℂ) = principalArccot (realCsch x)
```
:::
Source formula: https://dlmf.nist.gov/4.23.E41
$$`{\operatorname{gd}^{-1}}\left(x\right)=\int_{0}^{x}\sec t\,\mathrm{d}t,`
:::leanStatement "DLMF 4.23.E41 — https://dlmf.nist.gov/4.23.E41"
```anchor dlmf_4_23_41 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_41 {x : ℝ} (hx : -Real.pi / 2 < x) (hx' : x < Real.pi / 2) : inverseGudermannian x = ∫ t in (0 : ℝ)..x, 1 / Real.cos t
```
:::
Source formula: https://dlmf.nist.gov/4.23.E42
$$`\begin{aligned}{\operatorname{gd}^{-1}}\left(x\right)&=\ln\tan\left(\tfrac{1}{2}x+\tfrac{1}{4}\pi\right)=\ln\left(\sec x+\tan x\right)\\ &=\operatorname{arcsinh}\left(\tan x\right)=\operatorname{arccsch}\left(\cot x\right)=\operatorname{arccosh}\left(\sec x\right)\\ &=\operatorname{arcsech}\left(\cos x\right)=\operatorname{arctanh}\left(\sin x\right)=\operatorname{arccoth}\left(\csc x\right).\end{aligned}`
:::leanStatement "DLMF 4.23.E42 — https://dlmf.nist.gov/4.23.E42"
```anchor dlmf_4_23_42 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_42 {x : ℝ} (hx : -Real.pi / 2 < x) (hx' : x < Real.pi / 2)
    (hx0 : x ≠ 0) :
    (inverseGudermannian x : ℂ) =
        (Real.log (Real.tan (x / 2 + Real.pi / 4)) : ℂ) ∧
      (inverseGudermannian x : ℂ) =
        (Real.log (realSec x + Real.tan x) : ℂ) ∧
      (inverseGudermannian x : ℂ) = principalArcsinh (Real.tan x) ∧
      (inverseGudermannian x : ℂ) = principalArccsch (realCot x) ∧
      (inverseGudermannian x : ℂ) = principalArccosh (realSec x) ∧
      (inverseGudermannian x : ℂ) = principalArcsech (Real.cos x) ∧
      (inverseGudermannian x : ℂ) = principalArctanh (Real.sin x) ∧
      (inverseGudermannian x : ℂ) = principalArccoth (realCsc x)
```
:::
::::

::::dlmfEntry "4.23.T1" "https://dlmf.nist.gov/4.23.T1"
Table 4.23.1 has a seven-cell header followed by five six-cell special-value
rows. Dashes are distinct from values, and the zero-row arccot entry is the
one-sided pair +pi/2 from above and -pi/2 from below.
:::leanStatement "Table 4.23.1"
```anchor dlmf_4_23_T1_caption (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_T1_caption : tableHeader.length = 7 ∧ tableRowNegInf.length = 6 ∧ tableRowPosInf.length = 6
```
```anchor dlmf_4_23_T1_t1_r1 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_T1_t1_r1 : tableHeader = ["x", "arcsin x", "arccos x", "arctan x", "arccsc x", "arcsec x", "arccot x"]
```
```anchor dlmf_4_23_T1_t1_r2 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_T1_t1_r2 : tableRowNegInf = [.dash, .dash, .value (-Real.pi / 2), .value 0, .value (Real.pi / 2), .value 0]
```
```anchor dlmf_4_23_T1_t1_r3 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_T1_t1_r3 : tableRowNegOne = [.value (-Real.pi / 2), .value Real.pi, .value (-Real.pi / 4), .value (-Real.pi / 2), .value Real.pi, .value (-Real.pi / 4)]
```
```anchor dlmf_4_23_T1_t1_r4 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_T1_t1_r4 : tableRowZero = [.value 0, .value (Real.pi / 2), .value 0, .oneSided (Real.pi / 2) (-Real.pi / 2), .dash, .dash]
```
```anchor dlmf_4_23_T1_t1_r5 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_T1_t1_r5 : tableRowOne = [.value (Real.pi / 2), .value 0, .value (Real.pi / 4), .value (Real.pi / 2), .value 0, .value (Real.pi / 4)]
```
```anchor dlmf_4_23_T1_t1_r6 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_T1_t1_r6 : tableRowPosInf = [.dash, .dash, .value (Real.pi / 2), .value 0, .value (Real.pi / 2), .value 0]
```
:::
::::

::::dlmfEntry "4.23.F1" "https://dlmf.nist.gov/4.23.F1"
The figure caption and all four branch-cut panel labels are formalized below.
:::leanStatement "Figure 4.23.1"
```anchor dlmf_4_23_F1_t1_r1 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_F1_t1_r1 : figureCaption = "z-plane. Branch cuts for the inverse trigonometric functions."
```
```anchor dlmf_4_23_F1_t1_r2 (module := LMLF.Blueprint.Elementary.Section423)
theorem dlmf_4_23_F1_t1_r2 : figurePanelLabels = ["(i) arcsin/arccos", "(ii) arctan", "(iii) arccsc/arcsec", "(iv) arccot"]
```
:::
::::
