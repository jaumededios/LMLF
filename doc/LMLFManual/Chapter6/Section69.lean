import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section69
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section69

set_option verso.exampleProject "."

#doc (Manual) "§6.9 Continued Fraction" =>
%%%
tag := "chapter-6-section-9"
%%%

:::dlmfChapter "https://dlmf.nist.gov/6.9"
Source: NIST Digital Library of Mathematical Functions, §6.9.
:::

# §6.9 Continued Fraction
%%%
number := false
%%%

DLMF §6.9 records the principal exponential integral `E_1(z)` as a
continued fraction in the open principal cut plane
`|\operatorname{ph}z|<\pi`, with `z ≠ 0` as required by the defining
exponential-integral value. The display uses the standard alternating
partial denominators `(z,1,z,1,\ldots)` and repeated numerators
`(1,1,2,2,3,3,\ldots)`. Its convergence is represented below through the
shared finite continued-fraction evaluator, with the principal `E_1` value specified by the
canonical §6.2 map `principalE1`.

::::dlmfEntry "6.9.1" "https://dlmf.nist.gov/6.9.E1"
The continued fraction has the exact DLMF form
$$`E_1(z)=\frac{e^{-z}}{z+\cfrac{1}{1+\cfrac{1}{z+\cfrac{2}{1+\cfrac{2}{z+\cfrac{3}{1+\cfrac{3}{z+\cdots}}}}}}},\qquad |\operatorname{ph}z|<\pi.`$$
Here `\operatorname{ph}z` is the principal phase; its strict bound excludes the
negative-real cut, while the explicit nonzero hypothesis excludes the origin.
The Lean disclosure uses the shared
`continuedFractionConvergent` evaluator with denominator stream `z,1,z,1,...`
and numerator stream `1,1,2,2,3,3,...`; its optional offset remains available
for genuine tails. The theorem states that the resulting convergents tend to
the canonical principal `E_1` map.
:::leanStatement "DLMF 6.9.E1"
```anchor dlmf_6_9_1 (module := LMLF.Blueprint.ExponentialIntegrals.Section69)
theorem dlmf_6_9_1 (z : ℂ) (hz0 : z ≠ 0) (hz : ‖Complex.arg z‖ < Real.pi) :
    Tendsto (e1Convergent z) atTop
      (𝓝 (LMLF.Blueprint.ExponentialIntegrals.Section62.principalE1 z))
```
:::
::::

::::dlmfEntry "6.9 section note" "https://dlmf.nist.gov/6.9#info"
The source cites Nielsen (1906b, pp. 42–44) and Lorentzen and Waadeland
(1992, p. 577) for the continued fraction.
::::

::::dlmfEntry "6.9 context" "https://dlmf.nist.gov/6.9#p1"
Section 6.9 presents the continued fraction for the principal exponential
integral in the strict principal-phase domain `|ph z| < π`.
::::

::::dlmfEntry "6.9 further reference" "https://dlmf.nist.gov/6.9#p2"
The source also points to Cuyt et al. (2008, pp. 287–290) for this continued
fraction.
::::
