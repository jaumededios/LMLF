import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section614
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section614
set_option verso.exampleProject "."

#doc (Manual) "§6.14 Integrals" =>
%%%
tag := "chapter-6-section-14"
%%%

:::dlmfChapter "https://dlmf.nist.gov/6.14"
Source: NIST Digital Library of Mathematical Functions, §6.14.
:::

# §6.14 Integrals
%%%
number := false
%%%

Section 6.14(i) gives Laplace transforms of the exponential, cosine, and sine
integrals.  The parameter `a` is complex and the displayed real-part
conditions select the principal logarithm on the relevant half-plane.  The
Lean statements use the canonical §6.2 value APIs: `principalCiPositive` and
`principalSi - π/2` on the positive real ray, and the canonical `realE1` map
for the positive-real `E₁` value.  Each transform is expressed with
`HasImproperIntegral`, so the positive-ray limit is part of the statement.  In
E1, the quotient `log(1+a)/a` has its removable value `1` at `a=0`,
represented by `logOnePlusOver`; away from zero this is exactly the displayed
quotient.

::::dlmfEntry "6.14.1" "https://dlmf.nist.gov/6.14.E1"
$$`\int_0^\infty e^{-at}E_1(t)\,dt=\frac{1}{a}\ln(1+a),\qquad \Re a>-1`$$
For `Re a > -1`, the Laplace transform of the canonical positive-real `E₁`
value is `log(1+a)/a`, with the removable value at zero made explicit in the
Lean statement.  The totalized endpoint of `realE1` does not alter the
positive-ray improper integral.
:::leanStatement "DLMF 6.14.E1"
```anchor dlmf_6_14_1 (module := LMLF.Blueprint.ExponentialIntegrals.Section614)
/-- DLMF 6.14.E1: Laplace transform of E₁ on Re a > -1. -/
theorem dlmf_6_14_1 (a : ℂ) (ha : -1 < a.re) :
    HasImproperIntegral
      (fun t : ℝ => Complex.exp (-(a * (t : ℂ))) * realE1 t) 0
      (logOnePlusOver a)
```
:::
::::

::::dlmfEntry "6.14.2" "https://dlmf.nist.gov/6.14.E2"
$$`\int_0^\infty e^{-at}\operatorname{Ci}(t)\,dt=-\frac{1}{2a}\ln(1+a^2),\qquad \Re a>0`$$
For `Re a > 0`, the cosine-integral transform uses the canonical
`principalCiPositive` value, the principal logarithm of `1+a²`, and the
explicit factor `1/(2a)`.
:::leanStatement "DLMF 6.14.E2"
```anchor dlmf_6_14_2 (module := LMLF.Blueprint.ExponentialIntegrals.Section614)
/-- DLMF 6.14.E2: Laplace transform of Ci on Re a > 0. -/
theorem dlmf_6_14_2 (a : ℂ) (ha : 0 < a.re) :
    HasImproperIntegral
      (fun t : ℝ => Complex.exp (-(a * (t : ℂ))) * principalCiPositive t) 0
      (-(1 / (2 * a)) * Complex.log (1 + a ^ 2))
```
:::
::::

::::dlmfEntry "6.14.3" "https://dlmf.nist.gov/6.14.E3"
$$`\int_0^\infty e^{-at}\operatorname{si}(t)\,dt=-\frac{1}{a}\arctan a,\qquad \Re a>0`$$
For `Re a > 0`, the sine-integral transform uses the canonical tail value
`principalSi - π/2` and is `-arctan(a)/a` on the principal complex arctangent
branch.
:::leanStatement "DLMF 6.14.E3"
```anchor dlmf_6_14_3 (module := LMLF.Blueprint.ExponentialIntegrals.Section614)
/-- DLMF 6.14.E3: Laplace transform of si on Re a > 0. -/
theorem dlmf_6_14_3 (a : ℂ) (ha : 0 < a.re) :
    HasImproperIntegral
      (fun t : ℝ => Complex.exp (-(a * (t : ℂ))) *
        (principalSi t - Real.pi / 2)) 0 (-Complex.arctan a / a)
```
:::
::::

## Other integrals

The remaining identities are improper integrals over the positive real ray.
E4 is the square integral of the canonical positive-real `E₁`; E5 gives two
equal values `-π/4`; E6 gives the two square integrals `π/2`; and E7 gives the
mixed canonical `Ci`–`si` integral `ln 2`.  The source values are represented
by `principalCiPositive` and `principalSi - π/2`, and each declaration keeps
the improper-integral convergence semantics explicitly.

::::dlmfEntry "6.14.4" "https://dlmf.nist.gov/6.14.E4"
$$`\int_0^\infty E_1^2(t)\,dt=2\ln 2`$$
The square of the canonical positive-real `realE1` map has total integral
`2 log 2`; its totalized endpoint does not alter the improper integral.
:::leanStatement "DLMF 6.14.E4"
```anchor dlmf_6_14_4 (module := LMLF.Blueprint.ExponentialIntegrals.Section614)
/-- DLMF 6.14.E4: the square integral of E₁. -/
theorem dlmf_6_14_4 :
    HasImproperIntegral (fun t : ℝ => (realE1 t) ^ 2) 0 (2 * Real.log 2 : ℂ)
```
:::
::::

::::dlmfEntry "6.14.5" "https://dlmf.nist.gov/6.14.E5"
$$`\int_0^\infty \cos t\,\operatorname{Ci}(t)\,dt=\int_0^\infty \sin t\,\operatorname{si}(t)\,dt=-\frac{\pi}{4}`$$
The cosine-integral and sine-integral oscillatory products have the same value,
`-π/4`.
:::leanStatement "DLMF 6.14.E5"
```anchor dlmf_6_14_5 (module := LMLF.Blueprint.ExponentialIntegrals.Section614)
/-- DLMF 6.14.E5: the cosine/sine integral pair. -/
theorem dlmf_6_14_5 :
    HasImproperIntegral
        (fun t : ℝ => (Real.cos t : ℂ) * principalCiPositive t) 0
        (-Real.pi / 4) ∧
      HasImproperIntegral
        (fun t : ℝ => (Real.sin t : ℂ) * (principalSi t - Real.pi / 2)) 0
        (-Real.pi / 4)
```
:::
::::

::::dlmfEntry "6.14.6" "https://dlmf.nist.gov/6.14.E6"
$$`\int_0^\infty \operatorname{Ci}^2(t)\,dt=\int_0^\infty \operatorname{si}^2(t)\,dt=\frac{\pi}{2}`$$
The two square integrals are equal and each is `π/2`.
:::leanStatement "DLMF 6.14.E6"
```anchor dlmf_6_14_6 (module := LMLF.Blueprint.ExponentialIntegrals.Section614)
/-- DLMF 6.14.E6: the two square-integral identities. -/
theorem dlmf_6_14_6 :
    HasImproperIntegral (fun t : ℝ => principalCiPositive t ^ 2) 0
        (Real.pi / 2) ∧
      HasImproperIntegral
        (fun t : ℝ => (principalSi t - Real.pi / 2) ^ 2) 0 (Real.pi / 2)
```
:::
::::

::::dlmfEntry "6.14.7" "https://dlmf.nist.gov/6.14.E7"
$$`\int_0^\infty \operatorname{Ci}(t)\operatorname{si}(t)\,dt=\ln 2`$$
The mixed product has value `log 2`.
:::leanStatement "DLMF 6.14.E7"
```anchor dlmf_6_14_7 (module := LMLF.Blueprint.ExponentialIntegrals.Section614)
/-- DLMF 6.14.E7: the mixed cosine/sine integral. -/
theorem dlmf_6_14_7 :
    HasImproperIntegral
      (fun t : ℝ => principalCiPositive t * (principalSi t - Real.pi / 2)) 0
      (Real.log 2)
```
:::
::::

::::dlmfEntry "6.14(i) note" "https://dlmf.nist.gov/6.14#i.info"
The source records a historical note that an earlier reference omitted the
factor `1/2` in E2.  The displayed E2 formula above includes the corrected
factor.
::::

::::dlmfEntry "6.14(i) context" "https://dlmf.nist.gov/6.14#i.p1"
Section 6.14(i) groups E1--E3 as Laplace-transform formulas for the canonical
exponential, cosine, and sine integrals.
::::

::::dlmfEntry "6.14(ii) note" "https://dlmf.nist.gov/6.14#ii.info"
The source records a sign error in an earlier reference for E7; the displayed
E7 value here is the corrected positive `log 2`.
::::

::::dlmfEntry "6.14(ii) context" "https://dlmf.nist.gov/6.14#ii.p1"
Section 6.14(ii) collects the additional improper integrals E4--E7 over the
positive real ray.
::::

::::dlmfEntry "6.14(iii) references" "https://dlmf.nist.gov/6.14#iii.p1"
Section 6.14(iii) points to Apelblat, Bierens de Haan, Erdélyi, and other
integral compendia.  These bibliographic pointers add no numbered formula.
::::
