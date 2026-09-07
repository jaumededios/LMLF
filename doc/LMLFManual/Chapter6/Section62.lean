import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section62
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual
set_option verso.exampleProject "."

#doc (Manual) "§6.2 Definitions and Interrelations" =>
%%%
tag := "chapter-6-section-2"
%%%

:::dlmfChapter "https://dlmf.nist.gov/6.2"
Source: NIST Digital Library of Mathematical Functions, §6.2.
:::

# §6.2 Definitions and Interrelations
%%%
number := false
%%%

This page follows DLMF §6.2. The complex functions use the principal cut
`(-∞,0]` where the source does, and the path specifications make paths avoid
that cut and the singular endpoint; the path vocabulary also requires
continuity and differentiability. A sine-tail path is regular and avoids only
the origin, since sin(t)/t has no logarithmic branch cut. The named maps
`principalE1`, `realEi`, `principalCi`, `si`, `principalChi`,
`principalAuxiliaryF`, and `principalAuxiliaryG` carry the displayed values;
branch, principal-value, and convergence hypotheses are stated separately.
Where Lean totalizes a branch map away from its mathematical domain, the
source-facing statements below retain the DLMF domain hypothesis; that
implementation value is not a DLMF branch value.
The line-integral definitions for `Ein`, `Si`, `Cin`, and `Shi` use removable
integrand values at the origin, matching their entire extensions.

## Principal exponential integrals
%%%
number := false
%%%

This group defines `E₁`, relates it to `Ein`, and records the real
principal-value formulas for `Ei` and `li`. The path and limit
vocabulary remains visible because DLMF's complex integral is not an arbitrary
interval integral.

::::dlmfEntry "E₁ by a principal path" "https://dlmf.nist.gov/6.2.E1"
$$` E_1(z)=\int_z^\infty \frac{e^{-t}}{t}\,dt,\qquad z\ne0.`
DLMF defines the principal `E₁(z)` for `z ≠ 0` by integrating
`exp (-t) / t` to infinity along an admissible path avoiding the cut and
the origin.
:::leanStatement "Principal E₁ value specification"
```anchor dlmf_6_2_1 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.1: principal E₁ is represented by a typed cut-avoiding ray. -/
theorem dlmf_6_2_1_spec (z : ℂ) (hz : principalCutDomain z) :
    ∃ γ : PrincipalE1Ray, γ.start = z ∧
      γ.toImproperC1Ray.HasImproperIntegral
        (fun u : ℂ => Complex.exp (-u) / u) (principalE1 z)
```
:::
::::

::::dlmfEntry "Ray representation of E₁" "https://dlmf.nist.gov/6.2.E2"
$$` E_1(z)=e^{-z}\int_0^\infty \frac{e^{-t}}{t+z}\,dt,\qquad |\operatorname{ph}z|<\pi.`
On the open principal-cut plane, the same value is the ray integral
`exp (-z) ∫₀^∞ exp (-t)/(t+z) dt`.
:::leanStatement "E₁ ray interrelation"
```anchor dlmf_6_2_2 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.2: the principal E₁ value equals its convergent ray form. -/
theorem dlmf_6_2_2_spec (z : ℂ) (hz : principalCutDomain z) :
    HasImproperIntegral
      (fun t : ℝ => Complex.exp (-(t : ℂ)) / ((t : ℂ) + z)) 0
      (Complex.exp z * principalE1 z)
```
:::
::::

::::dlmfEntry "Entire Ein" "https://dlmf.nist.gov/6.2.E3"
$$` \operatorname{Ein}(z)=\int_0^z \frac{1-e^{-t}}{t}\,dt.`
`Ein(z)` is entire and is represented by integrating
`(1-exp(-t))/t` from zero to `z`, with its removable value at zero.
:::leanStatement "Entire complementary integral"
```anchor dlmf_6_2_3 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.3: the entire complementary exponential integral. -/
def principalEin (z : ℂ) : ℂ :=
  ∫ t in (0 : ℝ)..1,
    (if t * z = 0 then 1 else (1 - Complex.exp (-(t * z))) / (t * z)) * z
```
:::
::::

::::dlmfEntry "E₁ and Ein" "https://dlmf.nist.gov/6.2.E4"
$$` E_1(z)=\operatorname{Ein}(z)-\ln z-\gamma.`
On the principal branch, `E₁(z) = Ein(z) - log z - γ`.
:::leanStatement "E₁/Ein relation"
```anchor dlmf_6_2_4 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.4: E₁ and Ein on the principal branch. -/
theorem dlmf_6_2_4_spec (z : ℂ) (hz : principalCutDomain z) :
    principalE1 z = principalEin z - Complex.log z -
      Real.eulerMascheroniConstant
```
:::
::::

::::dlmfEntry "Ei principal values" "https://dlmf.nist.gov/6.2.E5"
$$` \operatorname{Ei}(x)=-\operatorname{PV}\int_{-x}^{\infty}\frac{e^{-t}}{t}\,dt=\operatorname{PV}\int_{-\infty}^{x}\frac{e^t}{t}\,dt,\qquad x>0.`
For `x > 0`, DLMF gives both principal-value integrals for `Ei(x)`,
with the first on the negative ray and the second on the real line.
:::leanStatement "Two Ei principal-value forms"
```anchor dlmf_6_2_5 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.5: the two principal-value forms of real Ei. -/
theorem dlmf_6_2_5_spec (x : ℝ) (hx : 0 < x) :
    hasEiLowerPV x (realEi x) ∧ hasEiUpperPV x (realEi x)
```
:::
::::

::::dlmfEntry "Ei and E₁ on the negative axis" "https://dlmf.nist.gov/6.2.E6"
$$` \operatorname{Ei}(-x)=-\int_x^\infty\frac{e^{-t}}{t}\,dt=-E_1(x),\qquad x>0.`
For positive `x`, the negative-axis value `Ei(-x)` is the negative of the
ordinary positive-ray integral `∫ₓ^∞ e⁻ᵗ/t dt`, and hence equals `-E₁(x)`.
The values are carried in `ℂ` so that the principal-value specifications and
the real identity share one codomain; this is the positive-real specialization
of the source formula.
:::leanStatement "Negative-axis Ei relation"
```anchor dlmf_6_2_6 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.6: negative-real Ei equals minus the positive E₁ value. -/
theorem dlmf_6_2_6_spec (x : ℝ) (hx : 0 < x) :
    realEi (-x) = -realE1 x ∧
      HasImproperIntegral
        (fun t : ℝ => Complex.exp (-(t : ℂ)) / (t : ℂ)) x (realE1 x)
```
:::
::::

::::dlmfEntry "Ei and Ein on the real axis" "https://dlmf.nist.gov/6.2.E7"
$$` \operatorname{Ei}(\pm x)=-\operatorname{Ein}(\mp x)+\ln x+\gamma,\qquad x>0.`
For `x > 0`, both `Ei(±x)` values are expressed through `Ein`,
`log x`, and Euler's constant.
As in E6, the real positive-axis values are represented in `ℂ` to retain the
principal-value API.
:::leanStatement "Real Ei/Ein relations"
```anchor dlmf_6_2_7 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.7: both real Ei values in terms of Ein. -/
theorem dlmf_6_2_7_spec (x : ℝ) (hx : 0 < x) :
    realEi x = -principalEin (-x) + (Real.log x : ℂ) +
        Real.eulerMascheroniConstant ∧
      realEi (-x) = -principalEin x + (Real.log x : ℂ) +
        Real.eulerMascheroniConstant
```
:::
::::

::::dlmfEntry "Logarithmic integral" "https://dlmf.nist.gov/6.2.E8"
$$` \operatorname{li}(x)=\operatorname{PV}\int_0^x\frac{dt}{\ln t}=\operatorname{Ei}(\ln x),\qquad x>1.`
For `x > 1`, `li(x)` is the Cauchy principal value of
`∫₀ˣ dt/log t` and agrees with `Ei(log x)`. In the Lean specification,
the two finite-side integrability conditions are required only for the
admissible principal-value neighborhood `0 < ε < min 1 (x - 1)`; the displayed
truncation still converges as `ε → 0⁺`.
:::leanStatement "li/Ei relation"
```anchor dlmf_6_2_8 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.8: the logarithmic integral agrees with Ei of log x. -/
theorem dlmf_6_2_8_spec (x : ℝ) (hx : 1 < x) (li : ℝ)
    (hli : hasLogarithmicIntegralPV x li) :
    (li : ℂ) = realEi (Real.log x)
```
:::
::::

::::dlmfEntry "Olver notation note" "https://dlmf.nist.gov/6.2#i.info"
DLMF's notation note places these exponential-integral symbols in the standard
Olver notation system; the definitions retain the source's branch and
principal-value conventions.
::::

::::dlmfEntry "Complex E₁ path convention" "https://dlmf.nist.gov/6.2#i.p1"
The path description is part of the complex definition: the path must not cross
the negative-real cut `(-∞,0]` or pass through the origin. On the negative-real
cut `(-∞,0)`, the principal value is two-valued; the formal maps here therefore
state the open-cut specialization.
::::

::::dlmfEntry "Ein interrelation context" "https://dlmf.nist.gov/6.2#i.p2"
The source places the E₁/Ein relation beside the ray representation; the Lean
statements preserve the distinction between an integral value and an
interrelation.
::::

::::dlmfEntry "Positive-real Ei restriction" "https://dlmf.nist.gov/6.2#i.p3"
The real Ei formulas use `x > 0`, as in DLMF, and principal values at the
pole are written as symmetric limits.
::::

::::dlmfEntry "Ei domain note" "https://dlmf.nist.gov/6.2#i.p4"
The source says that `Ei(x)` is undefined at `x = 0` and when `x` is not real;
the singular point is therefore excluded from the real Ei value specification.
Its branch convention controls nonzero complex values.
::::

::::dlmfEntry "Generalized exponential integrals" "https://dlmf.nist.gov/6.2#i.p5"
Generalized `E_p` notation is developed later in DLMF §8.19; this page
records only the §6.2 functions and their displayed interrelations.
::::

## Sine and cosine integrals
%%%
number := false
%%%

The second group uses entire removable-integrand definitions for `Si` and
`Cin`, while `si` and `Ci` retain improper tail/path meanings. The
principal logarithm appears in the `Ci`/`Cin` relation, and real limits
are stated on the positive ray.

::::dlmfEntry "Sine integral" "https://dlmf.nist.gov/6.2.E9"
$$` \operatorname{Si}(z)=\int_0^z\frac{\sin t}{t}\,dt.`
`Si(z)` is the entire integral of `sin t/t` from zero to `z`.
:::leanStatement "Sine integral"
```anchor dlmf_6_2_9 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.9: the entire sine integral. -/
def principalSi (z : ℂ) : ℂ :=
  ∫ t in (0 : ℝ)..1,
    (if t * z = 0 then 1 else Complex.sin (t * z) / (t * z)) * z
```
:::
::::

::::dlmfEntry "si tail and Si" "https://dlmf.nist.gov/6.2.E10"
$$` \operatorname{si}(z)=-\int_z^\infty\frac{\sin t}{t}\,dt=\operatorname{Si}(z)-\frac{\pi}{2}.`
For `z ≠ 0`, a regular path avoiding only the origin gives the sine tail;
its negative is `si(z)`, and DLMF records `si(z)=Si(z)-π/2`.
:::leanStatement "si relation"
```anchor dlmf_6_2_10 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.10: the sine tail and its canonical `Si - π/2` value. -/
theorem dlmf_6_2_10_spec (z : ℂ) (hz : z ≠ 0) :
    si z = principalSi z - Real.pi / 2 ∧
      ∃ γ : SineTailRay, γ.start = z ∧
        γ.toImproperC1Ray.HasImproperIntegral
          (fun u : ℂ => Complex.sin u / u) (-si z)
```
:::
::::

::::dlmfEntry "Cosine integral tail" "https://dlmf.nist.gov/6.2.E11"
$$` \operatorname{Ci}(z)=-\int_z^\infty\frac{\cos t}{t}\,dt.`
`Ci(z)` is the negative of the corresponding cosine tail on the principal path.
:::leanStatement "Ci tail specification"
```anchor dlmf_6_2_11 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.11: principal Ci is minus a cut-avoiding cosine tail. -/
theorem dlmf_6_2_11_spec (z : ℂ) (hz : principalCutDomain z) :
    ∃ γ : PrincipalE1Ray, γ.start = z ∧
      γ.toImproperC1Ray.HasImproperIntegral
        (fun u : ℂ => Complex.cos u / u) (-principalCi z)
```
:::
::::

::::dlmfEntry "Cin entire integral" "https://dlmf.nist.gov/6.2.E12"
$$` \operatorname{Cin}(z)=\int_0^z\frac{1-\cos t}{t}\,dt.`
`Cin(z)` is the entire integral of `(1-cos t)/t` from zero to `z`.
:::leanStatement "Cin integral"
```anchor dlmf_6_2_12 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.12: the entire cosine integral Cin. -/
def principalCin (z : ℂ) : ℂ :=
  ∫ t in (0 : ℝ)..1,
    (if t * z = 0 then 0 else (1 - Complex.cos (t * z)) / (t * z)) * z
```
:::
::::

::::dlmfEntry "Ci and Cin" "https://dlmf.nist.gov/6.2.E13"
$$` \operatorname{Ci}(z)=-\operatorname{Cin}(z)+\ln z+\gamma.`
On the principal branch, `Ci(z)=-Cin(z)+log z+γ`.
:::leanStatement "Ci/Cin relation"
```anchor dlmf_6_2_13 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.13: principal Ci and the entire Cin function. -/
theorem dlmf_6_2_13_spec (z : ℂ) (hz : principalCutDomain z) :
    principalCi z = -principalCin z + Complex.log z +
      Real.eulerMascheroniConstant
```
:::
::::

::::dlmfEntry "Positive-real limits" "https://dlmf.nist.gov/6.2.E14"
$$` \lim_{x\to\infty}\operatorname{Si}(x)=\frac{\pi}{2},\qquad\lim_{x\to\infty}\operatorname{Ci}(x)=0.`
Along the positive real axis, `Si(x)` tends to `π/2` and `Ci(x)`
tends to zero.
:::leanStatement "Sine and cosine limits"
```anchor dlmf_6_2_14 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.14: positive-real limits of Si and Ci. -/
theorem dlmf_6_2_14_spec :
    Tendsto (fun x : ℝ => principalSi x) atTop (𝓝 (Real.pi / 2)) ∧
      Tendsto (fun x : ℝ => principalCi (x : ℂ)) atTop (𝓝 0)
```
:::
::::

::::dlmfEntry "Sine/cosine notation note" "https://dlmf.nist.gov/6.2#ii.info"
The source's notation note covers the Si, si, Ci, and Cin names; this page
distinguishes their entire and improper definitions explicitly.
::::

::::dlmfEntry "Sine/cosine prose" "https://dlmf.nist.gov/6.2#ii.p1"
Si and Cin are entire, and Si is odd, whereas the tail definitions of si and
Ci require the path and convergence specifications shown above.
::::

::::dlmfEntry "Ci path note" "https://dlmf.nist.gov/6.2#Px1.p1"
The Ci tail path follows the same principal-cut avoidance convention as E₁;
its singular endpoint is excluded explicitly.
::::

::::dlmfEntry "Cin entire note" "https://dlmf.nist.gov/6.2#Px2.p1"
The Cin integrand has a removable value at zero and defines an even entire
function, as reflected by the line-integral definition.
::::

## Hyperbolic integrals and auxiliary functions
%%%
number := false
%%%

The final group defines `Shi` and the principal `Chi` relation, then
records the auxiliary functions `f` and `g` and their reconstruction and
derivative identities. The reconstruction and derivative theorems use the
principal-cut domain, which excludes `z = 0` where the `1/z` term matters.

::::dlmfEntry "Hyperbolic sine integral" "https://dlmf.nist.gov/6.2.E15"
$$` \operatorname{Shi}(z)=\int_0^z\frac{\sinh t}{t}\,dt.`
`Shi(z)` is the entire integral of `sinh t/t` from zero to `z`.
:::leanStatement "Shi integral"
```anchor dlmf_6_2_15 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.15: the entire hyperbolic sine integral. -/
def principalShi (z : ℂ) : ℂ :=
  ∫ t in (0 : ℝ)..1,
    (if t * z = 0 then 1 else Complex.sinh (t * z) / (t * z)) * z
```
:::
::::

::::dlmfEntry "Hyperbolic cosine integral" "https://dlmf.nist.gov/6.2.E16"
$$` \operatorname{Chi}(z)=\gamma+\ln z+\int_0^z\frac{\cosh t-1}{t}\,dt.`
On the principal branch, `Chi(z)=γ+log z+∫₀ᶻ(cosh t-1)/t dt`.
:::leanStatement "Chi relation"
```anchor dlmf_6_2_16 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.16: principal Chi and its regular entire part. -/
theorem dlmf_6_2_16_spec (z : ℂ) (hz : principalCutDomain z) :
    principalChi z = Real.eulerMascheroniConstant + Complex.log z +
      principalChiRegular z
```
:::
::::

::::dlmfEntry "Auxiliary f" "https://dlmf.nist.gov/6.2.E17"
$$` f(z)=\operatorname{Ci}(z)\sin z-\operatorname{si}(z)\cos z.`
DLMF introduces `f(z)=Ci(z) sin z-si(z) cos z` for `z ≠ 0`.
:::leanStatement "Auxiliary f"
```anchor dlmf_6_2_17 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.17: the canonical auxiliary function f. -/
def principalAuxiliaryF (z : ℂ) : ℂ :=
  principalCi z * Complex.sin z - si z * Complex.cos z
```
:::
::::

::::dlmfEntry "Auxiliary g" "https://dlmf.nist.gov/6.2.E18"
$$` g(z)=-\operatorname{Ci}(z)\cos z-\operatorname{si}(z)\sin z.`
DLMF introduces `g(z)=-Ci(z) cos z-si(z) sin z` for `z ≠ 0`.
:::leanStatement "Auxiliary g"
```anchor dlmf_6_2_18 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.18: the canonical auxiliary function g. -/
def principalAuxiliaryG (z : ℂ) : ℂ :=
  -principalCi z * Complex.cos z - si z * Complex.sin z
```
:::
::::

::::dlmfEntry "Si reconstruction" "https://dlmf.nist.gov/6.2.E19"
$$` \operatorname{Si}(z)=\frac{\pi}{2}-f(z)\cos z-g(z)\sin z.`
The pair `f,g` reconstructs Si by `Si(z)=π/2-f(z)cos z-g(z)sin z`.
:::leanStatement "Si from f and g"
```anchor dlmf_6_2_19 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.19: the canonical auxiliary pair reconstructs Si. -/
theorem dlmf_6_2_19_spec (z : ℂ) (hz : principalCutDomain z) :
    principalSi z = Real.pi / 2 - principalAuxiliaryF z * Complex.cos z -
      principalAuxiliaryG z * Complex.sin z
```
:::
::::

::::dlmfEntry "Ci reconstruction" "https://dlmf.nist.gov/6.2.E20"
$$` \operatorname{Ci}(z)=f(z)\sin z-g(z)\cos z.`
The pair reconstructs Ci by `Ci(z)=f(z)sin z-g(z)cos z`.
:::leanStatement "Ci from f and g"
```anchor dlmf_6_2_20 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.20: the canonical auxiliary pair reconstructs Ci. -/
theorem dlmf_6_2_20_spec (z : ℂ) (hz : principalCutDomain z) :
    principalCi z = principalAuxiliaryF z * Complex.sin z -
      principalAuxiliaryG z * Complex.cos z
```
:::
::::

::::dlmfEntry "Auxiliary derivatives" "https://dlmf.nist.gov/6.2.E21"
$$` f'(z)=-g(z),\qquad g'(z)=f(z)-\frac{1}{z}.`
Off the origin, `f′=-g` and `g′=f-1/z`.
:::leanStatement "Derivative relations for f and g"
```anchor dlmf_6_2_21 (module := LMLF.Blueprint.ExponentialIntegrals.Section62)
/-- DLMF 6.2.21: derivative laws for the canonical auxiliary pair. -/
theorem dlmf_6_2_21_spec (z : ℂ) (hz : principalCutDomain z) :
    HasDerivAt principalAuxiliaryF (-principalAuxiliaryG z) z ∧
      HasDerivAt principalAuxiliaryG (principalAuxiliaryF z - 1 / z) z
```
:::
::::

::::dlmfEntry "Auxiliary-function context" "https://dlmf.nist.gov/6.2#iii.p1"
The auxiliary functions express the large-argument relations between Si, Ci,
and their tails; the identities retain their off-origin domain.
::::
