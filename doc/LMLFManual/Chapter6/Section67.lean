import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section67
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section67
set_option verso.exampleProject "."

#doc (Manual) "§6.7 Relations to Other Functions" =>
%%%
tag := "chapter-6-section-7"
%%%

:::dlmfChapter "https://dlmf.nist.gov/6.7"
Source: NIST Digital Library of Mathematical Functions, §6.7.
:::

# §6.7 Relations to Other Functions
%%%
number := false
%%%

This page gives the integral representations in DLMF §6.7.  The first six
identities use the canonical `principalE1` and `realEi` maps from §6.2.  Their
infinite tails are stated with `HasImproperIntegral` at those canonical values,
so convergence is explicit without introducing arbitrary value carriers.  The finite representations use the
canonical `principalEin`, `principalSi`, and `principalCin` objects from §6.2.
The auxiliary functions `f` and `g` are the canonical
`principalAuxiliaryF` and `principalAuxiliaryG` combinations from §6.2; §6.4
uses separately named continuation-side values and explicit bridges to these
maps.  E12 uses
the typed `DlmfPrincipalPath`, which records only the admissible path geometry;
the `HasImproperPathIntegral` target is written directly at the value determined
by the displayed identity.  For
E15 and E16, `principalK0Value` is the positive-real principal `K₀` API,
characterized for positive arguments by the convergent integral
`∫₀^∞ exp(-x cosh u) du` and assigned the harmless value zero at `x = 0`.

::::dlmfEntry "6.7.1" "https://dlmf.nist.gov/6.7.E1"
$$`\int_0^\infty \frac{e^{-at}}{t+b}\,dt=\int_0^\infty \frac{e^{iat}}{t+ib}\,dt=e^{ab}E_1(ab)`$$
:::leanStatement "E1 integral relation"
```anchor dlmf_6_7_1 (module := LMLF.Blueprint.ExponentialIntegrals.Section67)
theorem dlmf_6_7_1 (a b : ℝ) (ha : 0 < a) (hb : 0 < b) :
    HasImproperIntegral
        (fun t : ℝ => Complex.exp (-(a : ℂ) * t) / (t + b)) 0
        (Complex.exp (a * b) * principalE1 (a * b)) ∧
      HasImproperIntegral
        (fun t : ℝ => Complex.exp (Complex.I * a * t) /
          (t + Complex.I * b)) 0
        (Complex.exp (a * b) * principalE1 (a * b))
```
:::
::::

::::dlmfEntry "6.7.2" "https://dlmf.nist.gov/6.7.E2"
$$`e^x\int_0^\alpha\frac{e^{-xt}}{1-t}\,dt=\operatorname{Ei}(x)-\operatorname{Ei}((1-\alpha)x)`$$
:::leanStatement "Ei finite-interval relation"
```anchor dlmf_6_7_2 (module := LMLF.Blueprint.ExponentialIntegrals.Section67)
theorem dlmf_6_7_2 (x α : ℝ) (hx : 0 < x) (hα₀ : 0 ≤ α) (hα₁ : α < 1) :
    Complex.exp x *
        (∫ t in (0 : ℝ)..α, Complex.exp (-(x : ℂ) * t) / (1 - t)) =
      realEi x - realEi ((1 - α) * x)
```
:::
::::

::::dlmfEntry "6.7.3" "https://dlmf.nist.gov/6.7.E3"
$$`\int_x^\infty\frac{e^{it}}{a^2+t^2}\,dt=\frac{i}{2a}\left(e^aE_1(a-ix)-e^{-a}E_1(-a-ix)\right)`$$
:::leanStatement "Oscillatory quadratic denominator"
```anchor dlmf_6_7_3 (module := LMLF.Blueprint.ExponentialIntegrals.Section67)
theorem dlmf_6_7_3 (a x : ℝ) (ha : 0 < a) (hx : 0 < x) :
    HasImproperIntegral
        (fun t : ℝ => Complex.exp (Complex.I * t) / (a ^ 2 + t ^ 2)) x
        (Complex.I / (2 * a) *
          (Complex.exp a * principalE1 (a - Complex.I * x) -
            Complex.exp (-a) * principalE1 (-a - Complex.I * x)))
```
:::
::::

::::dlmfEntry "6.7.4" "https://dlmf.nist.gov/6.7.E4"
$$`\int_x^\infty\frac{t e^{it}}{a^2+t^2}\,dt=\tfrac12\left(e^aE_1(a-ix)+e^{-a}E_1(-a-ix)\right)`$$
:::leanStatement "Weighted oscillatory relation"
```anchor dlmf_6_7_4 (module := LMLF.Blueprint.ExponentialIntegrals.Section67)
theorem dlmf_6_7_4 (a x : ℝ) (ha : 0 < a) (hx : 0 < x) :
    HasImproperIntegral
        (fun t : ℝ => (t : ℂ) * Complex.exp (Complex.I * t) /
          (a ^ 2 + t ^ 2)) x
        ((Complex.exp a * principalE1 (a - Complex.I * x) +
            Complex.exp (-a) * principalE1 (-a - Complex.I * x)) / 2)
```
:::
::::

::::dlmfEntry "6.7.5" "https://dlmf.nist.gov/6.7.E5"
$$`\int_x^\infty\frac{e^{-t}}{a^2+t^2}\,dt=-\frac{e^{ia}E_1(x+ia)-e^{-ia}E_1(x-ia)}{2ai}`$$
:::leanStatement "Decaying quadratic denominator"
```anchor dlmf_6_7_5 (module := LMLF.Blueprint.ExponentialIntegrals.Section67)
theorem dlmf_6_7_5 (a x : ℝ) (ha : 0 < a) :
    HasImproperIntegral
        (fun t : ℝ => Complex.exp (-t) / (a ^ 2 + t ^ 2)) x
        (-(Complex.exp (Complex.I * a) * principalE1 (x + Complex.I * a) -
            Complex.exp (-Complex.I * a) * principalE1 (x - Complex.I * a)) /
          (2 * a * Complex.I))
```
:::
::::

::::dlmfEntry "6.7.6" "https://dlmf.nist.gov/6.7.E6"
$$`\int_x^\infty\frac{t e^{-t}}{a^2+t^2}\,dt=\tfrac12\left(e^{ia}E_1(x+ia)+e^{-ia}E_1(x-ia)\right)`$$
:::leanStatement "Weighted decaying relation"
```anchor dlmf_6_7_6 (module := LMLF.Blueprint.ExponentialIntegrals.Section67)
theorem dlmf_6_7_6 (a x : ℝ) (ha : 0 < a) :
    HasImproperIntegral
        (fun t : ℝ => (t : ℂ) * Complex.exp (-t) /
          (a ^ 2 + t ^ 2)) x
        ((Complex.exp (Complex.I * a) * principalE1 (x + Complex.I * a) +
          Complex.exp (-Complex.I * a) * principalE1 (x - Complex.I * a)) / 2)
```
:::
::::

::::dlmfEntry "6.7.7" "https://dlmf.nist.gov/6.7.E7"
$$`\int_0^1e^{-at}\frac{\sin(bt)}t\,dt=\Im\operatorname{Ein}(a+ib)`$$
:::leanStatement "Ein sine relation"
```anchor dlmf_6_7_7 (module := LMLF.Blueprint.ExponentialIntegrals.Section67)
theorem dlmf_6_7_7 (a b : ℝ) :
    (∫ t in (0 : ℝ)..1,
      Complex.exp (-(a : ℂ) * t) * Complex.sin (b * t) / t) =
      (principalEin (a + Complex.I * b)).im
```
:::
::::

::::dlmfEntry "6.7.8" "https://dlmf.nist.gov/6.7.E8"
$$`\int_0^1e^{-at}\frac{1-\cos(bt)}t\,dt=\Re\operatorname{Ein}(a+ib)-\operatorname{Ein}(a)`$$
:::leanStatement "Ein cosine relation"
```anchor dlmf_6_7_8 (module := LMLF.Blueprint.ExponentialIntegrals.Section67)
theorem dlmf_6_7_8 (a b : ℝ) :
    (∫ t in (0 : ℝ)..1,
      Complex.exp (-(a : ℂ) * t) * (1 - Complex.cos (b * t)) / t) =
      (principalEin (a + Complex.I * b)).re - (principalEin a).re
```
:::
::::

::::dlmfEntry "6.7.9" "https://dlmf.nist.gov/6.7.E9"
$$`\operatorname{si}(z)=-\int_0^{\pi/2}e^{-z\cos t}\cos(z\sin t)\,dt`$$
:::leanStatement "Sine integral representation"
```anchor dlmf_6_7_9 (module := LMLF.Blueprint.ExponentialIntegrals.Section67)
theorem dlmf_6_7_9 (z : ℂ) :
    si z =
      -(∫ t in (0 : ℝ)..(Real.pi / 2),
        Complex.exp (-z * Complex.cos t) * Complex.cos (z * Complex.sin t))
```
:::
::::

::::dlmfEntry "6.7.10" "https://dlmf.nist.gov/6.7.E10"
$$`\operatorname{Ein}(z)-\operatorname{Cin}(z)=\int_0^{\pi/2}e^{-z\cos t}\sin(z\sin t)\,dt`$$
:::leanStatement "Ein-Cin representation"
```anchor dlmf_6_7_10 (module := LMLF.Blueprint.ExponentialIntegrals.Section67)
theorem dlmf_6_7_10 (z : ℂ) :
    principalEin z - principalCin z =
      ∫ t in (0 : ℝ)..(Real.pi / 2),
        Complex.exp (-z * Complex.cos t) * Complex.sin (z * Complex.sin t)
```
:::
::::

::::dlmfEntry "6.7.11" "https://dlmf.nist.gov/6.7.E11"
$$`\int_0^1\frac{(1-e^{-at})\cos(bt)}t\,dt=\Re\operatorname{Ein}(a+ib)-\operatorname{Cin}(b)`$$
:::leanStatement "Ein-Cin finite integral"
```anchor dlmf_6_7_11 (module := LMLF.Blueprint.ExponentialIntegrals.Section67)
theorem dlmf_6_7_11 (a b : ℝ) :
    (∫ t in (0 : ℝ)..1,
      (1 - Complex.exp (-(a : ℂ) * t)) * Complex.cos (b * t) / t) =
      (principalEin (a + Complex.I * b)).re - (principalCin b).re
```
:::
::::

::::dlmfEntry "6.7.12" "https://dlmf.nist.gov/6.7.E12"
$$`g(z)+if(z)=e^{-iz}\int_z^\infty\frac{e^{it}}t\,dt`$$
Here $`|\operatorname{ph}z|\leq\pi`; `DlmfPrincipalPath` stores this phase
bound together with the source's cut-avoiding path to infinity.  The Lean
statement writes the path integral at the value forced by the displayed
identity, so readers can inspect the integral result directly without
unpacking an auxiliary existential.
:::leanStatement "Auxiliary-function tail"
```anchor dlmf_6_7_12 (module := LMLF.Blueprint.ExponentialIntegrals.Section67)
theorem dlmf_6_7_12 (P : DlmfPrincipalPath) :
    HasImproperPathIntegral
        (fun u : ℂ => Complex.exp (Complex.I * u) / u) P.path 0
        (Complex.exp (Complex.I * P.z) *
          (principalAuxiliaryG P.z + Complex.I * principalAuxiliaryF P.z))
```
:::
::::

::::dlmfEntry "6.7.13" "https://dlmf.nist.gov/6.7.E13"
$$`f(z)=\int_0^\infty\frac{\sin t}{t+z}\,dt=\int_0^\infty\frac{e^{-zt}}{t^2+1}\,dt`$$
:::leanStatement "f integral pair"
```anchor dlmf_6_7_13 (module := LMLF.Blueprint.ExponentialIntegrals.Section67)
theorem dlmf_6_7_13 (z : ℝ) (hz : 0 < z) :
    HasImproperIntegral (fun t : ℝ => Complex.sin t / (t + z)) 0
        (principalAuxiliaryF z) ∧
      HasImproperIntegral
        (fun t : ℝ => Complex.exp (-(z : ℂ) * t) / (t ^ 2 + 1)) 0
        (principalAuxiliaryF z)
```
:::
::::

::::dlmfEntry "6.7.14" "https://dlmf.nist.gov/6.7.E14"
$$`g(z)=\int_0^\infty\frac{\cos t}{t+z}\,dt=\int_0^\infty\frac{te^{-zt}}{t^2+1}\,dt`$$
:::leanStatement "g integral pair"
```anchor dlmf_6_7_14 (module := LMLF.Blueprint.ExponentialIntegrals.Section67)
theorem dlmf_6_7_14 (z : ℝ) (hz : 0 < z) :
    HasImproperIntegral (fun t : ℝ => Complex.cos t / (t + z)) 0
        (principalAuxiliaryG z) ∧
      HasImproperIntegral
        (fun t : ℝ => (t : ℂ) * Complex.exp (-(z : ℂ) * t) /
          (t ^ 2 + 1)) 0 (principalAuxiliaryG z)
```
:::
::::

::::dlmfEntry "6.7.15" "https://dlmf.nist.gov/6.7.E15"
$$`f(z)=2\int_0^\infty K_0(2\sqrt{zt})\cos t\,dt`$$
For the stated positive-real specialization, the canonical kernel is
`principalK0Value (2 * Real.sqrt (z * t))`; the real square root is used for
`z,t > 0`, with the defined endpoint value at `t = 0`.  The outer integral is
explicitly an improper integral in the Lean statement, at the value
`principalAuxiliaryF z / 2` forced by the factor 2 in the DLMF formula.
:::leanStatement "Bessel-kernel cosine transform"
```anchor dlmf_6_7_15 (module := LMLF.Blueprint.ExponentialIntegrals.Section67)
theorem dlmf_6_7_15 (z : ℝ) (hz : 0 < z) :
    HasImproperIntegral
        (fun t : ℝ => principalK0Value (2 * Real.sqrt (z * t)) *
          Complex.cos t) 0 (principalAuxiliaryF z / 2)
```
:::
::::

::::dlmfEntry "6.7.16" "https://dlmf.nist.gov/6.7.E16"
$$`g(z)=2\int_0^\infty K_0(2\sqrt{zt})\sin t\,dt`$$
The sine transform uses the same canonical positive-real `K₀` kernel and real
square-root convention, with the outer improper convergence exposed by
`HasImproperIntegral` at `principalAuxiliaryG z / 2`.
:::leanStatement "Bessel-kernel sine transform"
```anchor dlmf_6_7_16 (module := LMLF.Blueprint.ExponentialIntegrals.Section67)
theorem dlmf_6_7_16 (z : ℝ) (hz : 0 < z) :
    HasImproperIntegral
        (fun t : ℝ => principalK0Value (2 * Real.sqrt (z * t)) *
          Complex.sin t) 0 (principalAuxiliaryG z / 2)
```
:::
::::

::::dlmfEntry "§6.7(i) derivation note" "https://dlmf.nist.gov/6.7#i.info"
The section-i note states that E1 and E2 follow from the definitions in
§6.2(i), E3–E6 follow by differentiation with respect to `x`, and E7–E8
follow by replacing the trigonometric functions by exponentials.
::::
::::dlmfEntry "§6.7(i) formula-block domains" "https://dlmf.nist.gov/6.7#i.p1"
The first section-i formula block records E1–E8 together with their stated
domains: `a>0, b>0` for E1; `0≤α<1, x>0` for E2; `a>0, x>0` for E3–E4;
`a>0, x∈ℝ` for E5–E6; and `a,b∈ℝ` for E7–E8.
::::
::::dlmfEntry "§6.7(i) Lebedev note" "https://dlmf.nist.gov/6.7#i.p2"
Lebedev (1965, p. 42) is cited for the fact that many integrals of the form
`∫ exp(z) R(z) dz`, with `R(z)` an arbitrary rational function, can be
represented in finite form using `E₁(z)` and elementary functions.
::::
::::dlmfEntry "§6.7(ii) Nielsen note" "https://dlmf.nist.gov/6.7#ii.info"
The section-ii note refers to Nielsen (1906b, p. 13) and warns that there are
sign errors in Eq. (27).
::::
::::dlmfEntry "§6.7(ii) complex-variable preface" "https://dlmf.nist.gov/6.7#ii.p1"
After the preface `z∈ℂ`, section 6.7(ii) gives E9–E10 for the complex
variable `z`; E11 then gives the finite Ein/Cin integral with `a,b∈ℝ`.
::::
::::dlmfEntry "§6.7(iii) derivation note" "https://dlmf.nist.gov/6.7#iii.info"
The section-iii note records that E12–E14 follow from §6.5.7, §6.2.1, and
§6.2.2; the second equations in E13 and E14 are referred to Temme (1996b,
pp. 187–188); and E15–E16 use §10.32.10.
::::
::::dlmfEntry "§6.7(iii) path condition" "https://dlmf.nist.gov/6.7#iii.p1"
The section-iii paragraph states that the path of integration in the E12
auxiliary-function representation does not cross the negative real axis or
pass through the origin.
::::
::::dlmfEntry "§6.7(iii) Bessel-transform note" "https://dlmf.nist.gov/6.7#iii.p2"
The first integrals on the right-hand sides of E13 and E14 apply when
`|ph z|<π`; the second ones apply when `Re z≥0` and, for E14, `z≠0`.  The
preface for E15–E16 is again `|ph z|<π`, and the section closes with the
reference “For K₀ see §10.25(ii).”
::::
::::dlmfEntry "§6.7(iv) compendia" "https://dlmf.nist.gov/6.7#iv.p1"
For collections of integral representations, DLMF cites Bierens de Haan
(1939, pp. 56–59, 72–73, 82–84, 121, 133–136, 155, 179–181, 223, 225–227,
230, 259–260, 374, 377, 397–398, 408, 416, 424, 431, 438–439, 442–444,
488, 496–500, 567–571, 585, 602, 638, 675–677), Corrington (1961), Erdélyi et al.
(1954a, vol. 1, pp. 267–270), Geller and Ng (1969), Nielsen (1906b),
Oberhettinger (1974, pp. 244–246), Oberhettinger and Badii (1973,
pp. 364–371), and Watrasiewicz (1967).
::::
