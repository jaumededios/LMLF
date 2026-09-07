import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section617
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section617
set_option verso.exampleProject "."

#doc (Manual) "§6.17 Physical Applications" =>
%%%
tag := "chapter-6-section-17"
%%%

:::dlmfChapter "https://dlmf.nist.gov/6.17"
Source: NIST Digital Library of Mathematical Functions, §6.17.
:::

# §6.17 Physical Applications
%%%
number := false
%%%

::::dlmfEntry "Physical-application survey" "https://dlmf.nist.gov/6.17#p1"
DLMF §6.17 is a literature survey connecting the exponential, sine, and
cosine integrals with physical problems. Geller and Ng (1969) cite uses in
diffusion theory, transport problems, radiative equilibrium of stellar
atmospheres, and exchange integrals in quantum mechanics. For astrophysics,
DLMF also points to van de Hulst (1980). Lebedev (1965) gives an
electromagnetic-theory application involving radiation from a linear
half-wave oscillator, where sine and cosine integrals occur.

The reusable vocabulary below records exactly the six application areas named
by the source. It is a bibliographic index, not a new analytic identity; the
cited references remain the source for the physical models.
:::leanStatement "DLMF 6.17 physical applications"
```anchor dlmf_6_17_p1 (module := LMLF.Blueprint.ExponentialIntegrals.Section617)
def citedPhysicalApplications : List PhysicalApplication :=
  [ .diffusionTheory
  , .transportProblems
  , .stellarRadiativeEquilibrium
  , .quantumExchangeIntegrals
  , .astrophysics
  , .electromagneticRadiation ]
```
:::
::::

The neighboring DLMF pages continue the chapter's mathematical applications
and computational methods: see [§6.16](https://dlmf.nist.gov/6.16) and
[§6.18](https://dlmf.nist.gov/6.18).
