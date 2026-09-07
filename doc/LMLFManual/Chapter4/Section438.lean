import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section438
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual
open LMLF.Blueprint.Elementary.Section438

set_option verso.exampleProject "."

#doc (Manual) "§4.38 Inverse Hyperbolic Functions: Further Properties" =>
%%%
tag := "chapter-4-section-38"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.38"
Source: NIST Digital Library of Mathematical Functions, §4.38.
:::

# §4.38 Inverse Hyperbolic Functions: Further Properties
%%%
number := false
%%%

The principal logarithmic APIs `arcsinh`, `arccosh`, and `arctanh` are defined
in the owned Lean module, together with reciprocal APIs `arccsch`, `arcsech`,
and `arccoth`.  Power-series statements retain the source convergence regions;
derivative formulas use principal square roots and explicitly avoid branch
points and poles.  Addition formulas are stated as branch-sensitive identities
over the complex numbers; as in DLMF, square roots may represent either value
and the equations are understood as multivalued correspondences.

::::dlmfEntry "4.38(i) derivation note" "https://dlmf.nist.gov/4.38#i.p1"
The source notes that E1 follows by expanding `(1+z²)⁻¹ᐟ²` with the binomial
theorem and integrating term by term; E2 uses the corresponding expansion in
`1/z` on `Re z>0`, with the constant fixed by the large-`z` behavior
`arcsinh z ~ ln(2z)`. E3 is obtained similarly, while E4–E7 follow from the
inverse-trigonometric series in [DLMF §4.24](https://dlmf.nist.gov/4.24).
::::

::::dlmfEntry "4.38(i) annotation" "https://dlmf.nist.gov/4.38#i.info@annotation-note-1"
The power-series subsection is the source context for the convergence regions
and branch restrictions recorded above; these conditions are part of each
display rather than optional editorial metadata.
::::

::::dlmfEntry "4.38(ii) derivative note" "https://dlmf.nist.gov/4.38#ii.p1"
The derivative formulas are obtained from the logarithmic forms in
[DLMF §4.37(iv)](https://dlmf.nist.gov/4.37.iv); the square roots in E9–E14
are principal values.
::::

::::dlmfEntry "4.38(ii) annotation" "https://dlmf.nist.gov/4.38#ii.info@annotation-note-1"
The derivative subsection records branch-point and pole exclusions together
with the half-plane signs required by the principal branches.
::::

::::dlmfEntry "4.38(iii) addition note" "https://dlmf.nist.gov/4.38#iii.p1"
The addition formulas use the same multivalued analysis as
[DLMF §4.24(iii)](https://dlmf.nist.gov/4.24.iii), rather than silently
selecting principal inverse values.
::::

::::dlmfEntry "4.38(iii) annotation" "https://dlmf.nist.gov/4.38#iii.info@annotation-note-1"
For E15–E19 every left-hand value corresponds to a right-hand value and vice
versa, and each displayed square root may take either value.
::::

## Power series

E1 is the `|z|<1` Maclaurin series for arcsinh.  E2 and E3 are the large-
argument logarithmic expansions, with `Re z>0` for E2 and `|z|>1` for E3;
E4 is the local arccosh expansion on `Re z>0, |z-1|≤2`, with its summation
starting at `n=1`.  E5–E7 give three
charts for arctanh, with their exact disk, half-plane, and hyperbola domains.
In E7 the coefficient is the product ratio `2·4···(2n+2)/(3·5···(2n+3))`,
not a geometric surrogate.

::::dlmfEntry "4.38.1" "https://dlmf.nist.gov/4.38.E1"
$$`\operatorname{arcsinh}z=z-\frac{z^3}{2\cdot3}+\frac{1\cdot3}{2\cdot4}\frac{z^5}{5}-\cdots,\quad |z|<1.`$$
:::leanStatement "Arcsinh Maclaurin series"
```anchor dlmf_4_38_1 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_1 (z : ℂ) (hz : ‖z‖ < 1) :
    arcsinh z = ∑' n : ℕ, ((-1 : ℂ) ^ n * (Nat.choose (2*n) n : ℂ) /
      ((4 : ℂ)^n * (2*n+1))) * z ^ (2*n+1) :=
```
:::
::::

::::dlmfEntry "4.38.2–4.38.8" "https://dlmf.nist.gov/4.38.E2"
The source links are [E2](https://dlmf.nist.gov/4.38.E2), [E3](https://dlmf.nist.gov/4.38.E3), [E4](https://dlmf.nist.gov/4.38.E4), [E5](https://dlmf.nist.gov/4.38.E5), [E6](https://dlmf.nist.gov/4.38.E6), [E7](https://dlmf.nist.gov/4.38.E7), and [E8](https://dlmf.nist.gov/4.38.E8).  The declarations below preserve each domain and series chart.
:::leanStatement "Large-argument, local, and hyperbola series"
```anchor dlmf_4_38_2 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_2 (z : ℂ) (hr : 0 < z.re) (hz : 1 < ‖z‖) :
    arcsinh z = Complex.log (2*z) + ∑' n : ℕ, ((-1 : ℂ) ^ n *
      (Nat.choose (2*(n+1)) (n+1) : ℂ) / ((4 : ℂ)^(n+1) * (2*(n+1)) * z^(2*(n+1)))) :=
```
```anchor dlmf_4_38_3 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_3 (z : ℂ) (hz : 1 < ‖z‖) :
    arccosh z = Complex.log (2*z) - ∑' n : ℕ, (
      (Nat.choose (2*(n+1)) (n+1) : ℂ) / ((4 : ℂ)^(n+1) * (2*(n+1)) * z^(2*(n+1)))) :=
```
```anchor dlmf_4_38_4 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_4 (z : ℂ) (hr : 0 < z.re) (hz : ‖z - 1‖ ≤ 2) :
    arccosh z = Complex.sqrt (2*(z-1)) * (1 + ∑' n : ℕ,
      arccoshLocalCoeff n * (z-1)^(n+1)) :=
```
```anchor dlmf_4_38_5 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_5 (z : ℂ) (hz : ‖z‖ ≤ 1) (hpm : z ≠ 1 ∧ z ≠ -1) :
    arctanh z = ∑' n : ℕ, z^(2*n+1) / (2*n+1) :=
```
```anchor dlmf_4_38_6 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_6 (z : ℂ) (hi : z.im ≠ 0) (hz : 1 ≤ ‖z‖) :
    arctanh z = Complex.I * (if 0 < z.im then 1 else -1) * (Real.pi/2) +
      ∑' n : ℕ, 1 / ((2*n+1 : ℕ) : ℂ) / z^(2*n+1) :=
```
```anchor dlmf_4_38_7 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_7 (z : ℂ) (hz : (z^2).re < 1/2) :
    arctanh z = z/(1-z^2) * (1 + ∑' n : ℕ,
      arctanhTransformedCoeff n * (z^2/(z^2-1))^(n+1)) :=
```
```anchor dlmf_4_38_8 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_8 (x y : ℝ) : x^2 - y^2 = 1/2 ↔
    (((x : ℂ) + Complex.I * (y : ℂ)) ^ 2).re = 1/2 :=
```
:::
::::

## Derivatives and addition formulas

E9–E14 use principal square roots and explicit complements of the principal
logarithmic branch cuts, in addition to branch-point and pole hypotheses.
E15–E19 are
multivalued addition correspondences: each square root may be either value,
and each displayed sign gives the corresponding value relation.  The Lean
API uses explicit `sqrtValue` and inverse-value predicates rather than
falsely identifying a principal logarithm with every multivalued value.

::::dlmfEntry "4.38.9–4.38.19" "https://dlmf.nist.gov/4.38.E9"
Direct source links: [E9](https://dlmf.nist.gov/4.38.E9), [E10](https://dlmf.nist.gov/4.38.E10), [E11](https://dlmf.nist.gov/4.38.E11), [E12](https://dlmf.nist.gov/4.38.E12), [E13](https://dlmf.nist.gov/4.38.E13), [E14](https://dlmf.nist.gov/4.38.E14), [E15](https://dlmf.nist.gov/4.38.E15), [E16](https://dlmf.nist.gov/4.38.E16), [E17](https://dlmf.nist.gov/4.38.E17), [E18](https://dlmf.nist.gov/4.38.E18), and [E19](https://dlmf.nist.gov/4.38.E19).
:::leanStatement "Derivative and addition APIs"
```anchor dlmf_4_38_9 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_9 (z : ℂ) (h : 1 + z^2 ≠ 0 ∧ arcsinhBranchDomain z) :
    HasDerivAt arcsinh (1 / Complex.sqrt (1 + z^2)) z :=
```
```anchor dlmf_4_38_10 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_10 (z : ℂ) (σ : ℂ) (hσ : σ = 1 ∨ σ = -1)
    (hbranch : (0 < z.re ∧ σ = 1) ∨ (z.re < 0 ∧ σ = -1))
    (h : z^2 - 1 ≠ 0 ∧ arccoshBranchDomain z) :
    HasDerivAt arccosh (σ / Complex.sqrt (z^2 - 1)) z :=
```
```anchor dlmf_4_38_11 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_11 (z : ℂ) (h : z^2 ≠ 1 ∧ arctanhBranchDomain z) :
    HasDerivAt arctanh (1 / (1-z^2)) z :=
```
```anchor dlmf_4_38_12 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_12 (z : ℂ) (σ : ℂ) (hσ : σ = 1 ∨ σ = -1)
    (hbranch : (0 < z.re ∧ σ = 1) ∨ (z.re < 0 ∧ σ = -1))
    (h : z ≠ 0 ∧ 1+z^2 ≠ 0 ∧ arcsinhBranchDomain (1 / z)) :
    HasDerivAt arccsch (-σ / (z * Complex.sqrt (1+z^2))) z :=
```
```anchor dlmf_4_38_13 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_13 (z : ℂ) (h : z ≠ 0 ∧ 1-z^2 ≠ 0 ∧ arccoshBranchDomain (1 / z)) :
    HasDerivAt arcsech (-(1 / (z * Complex.sqrt (1-z^2)))) z :=
```
```anchor dlmf_4_38_14 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_14 (z : ℂ) (h : z^2 ≠ 1 ∧ arctanhBranchDomain (1 / z)) :
    HasDerivAt arccoth (1 / (1-z^2)) z :=
```
```anchor dlmf_4_38_15 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_15 (ε : ℂ) (hε : ε ^ 2 = 1) (u v : ℂ) :
    ∀ w, (∃ x y, arcsinhValue u x ∧ arcsinhValue v y ∧ w = x + ε * y) ↔
      ∃ r s, sqrtValue (1 + v^2) r ∧ sqrtValue (1 + u^2) s ∧
        arcsinhValue (u * r + ε * v * s) w :=
```
```anchor dlmf_4_38_16 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_16 (ε : ℂ) (hε : ε ^ 2 = 1) (u v : ℂ) :
    ∀ w, (∃ x y, arccoshValue u x ∧ arccoshValue v y ∧ w = x + ε * y) ↔
      ∃ r s, sqrtValue (u^2 - 1) r ∧ sqrtValue (v^2 - 1) s ∧
        arccoshValue (u * v + ε * r * s) w :=
```
```anchor dlmf_4_38_17 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_17 (ε : ℂ) (hε : ε ^ 2 = 1) (u v : ℂ)
    (h : 1 + ε * u * v ≠ 0) :
    ∀ w, (∃ x y, arctanhValue u x ∧ arctanhValue v y ∧ w = x + ε * y) ↔
      arctanhValue ((u + ε * v) / (1 + ε * u * v)) w :=
```
```anchor dlmf_4_38_18 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_18 (ε : ℂ) (hε : ε ^ 2 = 1) (u v : ℂ) :
    ∀ w, (∃ x y, arcsinhValue u x ∧ arccoshValue v y ∧ w = x + ε * y) ↔
      ∃ r s, sqrtValue (1 + u^2) r ∧ sqrtValue (v^2 - 1) s ∧
        arcsinhValue (u * v + ε * r * s) w ∧
        arccoshValue (v * r + ε * u * s) w :=
```
```anchor dlmf_4_38_19 (module := LMLF.Blueprint.Elementary.Section438)
theorem dlmf_4_38_19 (ε : ℂ) (hε : ε ^ 2 = 1) (u v : ℂ)
    (h : v + ε * u ≠ 0 ∧ ε * u * v + 1 ≠ 0) :
    ∀ w, (∃ x y, arctanhValue u x ∧ arccothValue v y ∧ w = x + ε * y) ↔
      arctanhValue ((u * v + ε) / (v + ε * u)) w ∧
        arccothValue ((v + ε * u) / (u * v + ε)) w :=
```
:::
::::
