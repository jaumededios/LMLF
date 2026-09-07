import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section440
import LMLFManual.Components
open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.Elementary.Section440
set_option verso.exampleProject "."
#doc (Manual) "§4.40 Integrals" =>
%%%
tag := "chapter-4-section-40"
%%%
:::dlmfChapter "https://dlmf.nist.gov/4.40"
Source: NIST Digital Library of Mathematical Functions, §4.40.
:::
# §4.40 Integrals
%%%
number := false
%%%
The real formulas below use derivative identities for indefinite integrals and
explicit endpoint truncations for improper integrals. Each source formula has
its own link and preserves the source domain.
::::dlmfEntry "4.40.1" "https://dlmf.nist.gov/4.40.E1"
The derivative of sinh is cosh.
:::leanStatement "DLMF 4.40.E1"
```anchor dlmf_4_40_1 (module := LMLF.Blueprint.Elementary.Section440)
theorem dlmf_4_40_1 (x : ℝ) : HasDerivAt Real.cosh (Real.sinh x) x
```
:::
::::
::::dlmfEntry "4.40.2" "https://dlmf.nist.gov/4.40.E2"
The derivative of cosh is sinh.
:::leanStatement "DLMF 4.40.E2"
```anchor dlmf_4_40_2 (module := LMLF.Blueprint.Elementary.Section440)
theorem dlmf_4_40_2 (x : ℝ) : HasDerivAt Real.sinh (Real.cosh x) x
```
:::
::::
::::dlmfEntry "4.40.3" "https://dlmf.nist.gov/4.40.E3"
The logarithmic primitive of cosh is valid on the real line.
:::leanStatement "DLMF 4.40.E3"
```anchor dlmf_4_40_3 (module := LMLF.Blueprint.Elementary.Section440)
theorem dlmf_4_40_3 {x : ℝ} (hx : 0 < Real.cosh x) : HasDerivAt (fun t => Real.log (Real.cosh t)) (Real.tanh x) x
```
:::
::::
::::dlmfEntry "4.40.4" "https://dlmf.nist.gov/4.40.E4"
The logarithm of tanh(t/2) has derivative 1/sinh x on x > 0.
:::leanStatement "DLMF 4.40.E4"
```anchor dlmf_4_40_4 (module := LMLF.Blueprint.Elementary.Section440)
theorem dlmf_4_40_4 {x : ℝ} (hx : 0 < x) : HasDerivAt (fun t => Real.log (Real.tanh (t / 2))) (1 / Real.sinh x) x
```
:::
::::
::::dlmfEntry "4.40.5" "https://dlmf.nist.gov/4.40.E5"
The Gudermannian derivative is sech x.
:::leanStatement "DLMF 4.40.E5"
```anchor dlmf_4_40_5 (module := LMLF.Blueprint.Elementary.Section440)
theorem dlmf_4_40_5 (x : ℝ) : HasDerivAt gd (1 / Real.cosh x) x
```
:::
::::
::::dlmfEntry "4.40.6" "https://dlmf.nist.gov/4.40.E6"
The logarithmic primitive of sinh is stated for x > 0.
:::leanStatement "DLMF 4.40.E6"
```anchor dlmf_4_40_6 (module := LMLF.Blueprint.Elementary.Section440)
theorem dlmf_4_40_6 {x : ℝ} (hx : 0 < x) : HasDerivAt (fun t => Real.log (Real.sinh t)) (1 / Real.tanh x) x
```
:::
::::
::::dlmfEntry "4.40.7" "https://dlmf.nist.gov/4.40.E7"
For a nonzero real a, the integral over zero to infinity is the limit over the
truncated endpoints 1/R and R
and equals pi divided by 2 tanh(pi times a divided by 2), minus 1/a.
:::leanStatement "DLMF 4.40.E7"
```anchor dlmf_4_40_7 (module := LMLF.Blueprint.Elementary.Section440)
theorem dlmf_4_40_7 {a : ℝ} (ha : a ≠ 0) : ∃ L : ℝ, Tendsto (fun R => truncatedIntegral (fun x => Real.exp (-x) * Real.sin (a * x) / Real.sinh x) (1 / R) R) atTop (𝓝 L) ∧ L = Real.pi / 2 * (1 / Real.tanh (Real.pi * a / 2)) - 1 / a
```
:::
::::
::::dlmfEntry "4.40.8" "https://dlmf.nist.gov/4.40.E8"
For -pi < a < pi, endpoint truncation at 1/R and R converges to tan(a/2)/2.
:::leanStatement "DLMF 4.40.E8"
```anchor dlmf_4_40_8 (module := LMLF.Blueprint.Elementary.Section440)
theorem dlmf_4_40_8 {a : ℝ} (ha₁ : -Real.pi < a) (ha₂ : a < Real.pi) : ∃ L : ℝ, Tendsto (fun R => truncatedIntegral (fun x => Real.sinh (a * x) / Real.sinh (Real.pi * x)) (1 / R) R) atTop (𝓝 L) ∧ L = 1 / 2 * Real.tan (a / 2)
```
:::
::::
::::dlmfEntry "4.40.9" "https://dlmf.nist.gov/4.40.E9"
For -1 < a < 1, the symmetric limit from -R to R equals the continuous
extension of 4 pi a divided by sin(pi a), with value 4 at a=0.
:::leanStatement "DLMF 4.40.E9"
```anchor dlmf_4_40_9 (module := LMLF.Blueprint.Elementary.Section440)
theorem dlmf_4_40_9 {a : ℝ} (ha₁ : -1 < a) (ha₂ : a < 1) : ∃ L : ℝ, Tendsto (fun R => symmetricTruncatedIntegral (fun x => Real.exp (a * x) / (Real.cosh (x / 2)) ^ 2) R) atTop (𝓝 L) ∧ L = e9Value a
```
:::
::::
::::dlmfEntry "4.40.10" "https://dlmf.nist.gov/4.40.E10"
For positive a,b, endpoint truncation of (tanh(a*x)-tanh(b*x))/x converges to log(a/b).
:::leanStatement "DLMF 4.40.E10"
```anchor dlmf_4_40_10 (module := LMLF.Blueprint.Elementary.Section440)
theorem dlmf_4_40_10 {a b : ℝ} (ha : 0 < a) (hb : 0 < b) : ∃ L : ℝ, Tendsto (fun R => truncatedIntegral (fun x => (Real.tanh (a * x) - Real.tanh (b * x)) / x) (1 / R) R) atTop (𝓝 L) ∧ L = Real.log (a / b)
```
:::
::::
::::dlmfEntry "4.40.11" "https://dlmf.nist.gov/4.40.E11"
The arsinh antiderivative is valid for every real x.
:::leanStatement "DLMF 4.40.E11"
```anchor dlmf_4_40_11 (module := LMLF.Blueprint.Elementary.Section440)
theorem dlmf_4_40_11 (x : ℝ) : HasDerivAt (fun t => t * arsinh t - Real.sqrt (1 + t ^ 2)) (arsinh x) x
```
:::
::::
::::dlmfEntry "4.40.12" "https://dlmf.nist.gov/4.40.E12"
The arcosh primitive uses the real branch for x > 1.
:::leanStatement "DLMF 4.40.E12"
```anchor dlmf_4_40_12 (module := LMLF.Blueprint.Elementary.Section440)
theorem dlmf_4_40_12 {x : ℝ} (hx : 1 < x) : HasDerivAt (fun t => t * arcosh t - Real.sqrt (t ^ 2 - 1)) (arcosh x) x
```
:::
::::
::::dlmfEntry "4.40.13" "https://dlmf.nist.gov/4.40.E13"
The artanh primitive uses -1 < x < 1.
:::leanStatement "DLMF 4.40.E13"
```anchor dlmf_4_40_13 (module := LMLF.Blueprint.Elementary.Section440)
theorem dlmf_4_40_13 {x : ℝ} (hx₁ : -1 < x) (hx₂ : x < 1) : HasDerivAt (fun t => t * artanh t + (1 / 2 : ℝ) * Real.log (1 - t ^ 2)) (artanh x) x
```
:::
::::
::::dlmfEntry "4.40.14" "https://dlmf.nist.gov/4.40.E14"
The arcsch primitive is given on x > 0.
:::leanStatement "DLMF 4.40.E14"
```anchor dlmf_4_40_14 (module := LMLF.Blueprint.Elementary.Section440)
theorem dlmf_4_40_14 {x : ℝ} (hx : 0 < x) : HasDerivAt (fun t => t * arcsch t + arsinh t) (arcsch x) x
```
:::
::::
::::dlmfEntry "4.40.15" "https://dlmf.nist.gov/4.40.E15"
The arsech primitive uses 0 < x < 1.
:::leanStatement "DLMF 4.40.E15"
```anchor dlmf_4_40_15 (module := LMLF.Blueprint.Elementary.Section440)
theorem dlmf_4_40_15 {x : ℝ} (hx₁ : 0 < x) (hx₂ : x < 1) : HasDerivAt (fun t => t * arsech t + Real.arcsin t) (arsech x) x
```
:::
::::
::::dlmfEntry "4.40.16" "https://dlmf.nist.gov/4.40.E16"
The arcoth primitive uses the real branch for x > 1.
:::leanStatement "DLMF 4.40.E16"
```anchor dlmf_4_40_16 (module := LMLF.Blueprint.Elementary.Section440)
theorem dlmf_4_40_16 {x : ℝ} (hx : 1 < x) : HasDerivAt (fun t => t * arcoth t + (1 / 2 : ℝ) * Real.log (t ^ 2 - 1)) (arcoth x) x
```
:::
::::

Complex continuation in DLMF 4.40(ii) and 4.40(iv) requires continuous
logarithm and inverse-hyperbolic branches along paths avoiding singularities;
the declarations above are honest real specializations. Formula E5 is the
Gudermannian identity cross-referenced by DLMF 4.23.39--4.23.40. Copson
(1935, p. 155) is cited for the definite integrals. The compendia paragraph
names Apelblat, Bierens de Haan, Gröbner--Hofreiter, Gradshteyn--Ryzhik, and
Prudnikov as sources for further integral tables.
