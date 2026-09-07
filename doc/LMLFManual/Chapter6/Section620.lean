import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section620
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section620

set_option verso.exampleProject "."

#doc (Manual) "§6.20 Approximations" =>
%%%
tag := "chapter-6-section-20"
%%%

:::dlmfChapter "https://dlmf.nist.gov/6.20"
Source: NIST Digital Library of Mathematical Functions, §6.20, Approximations.
:::

# §6.20 Approximations
%%%
number := false
%%%

DLMF §6.20 is a literature survey rather than a sequence of numbered
identities. It organizes approximation data by elementary-function formulas,
Chebyshev expansions, and Padé-type or rational expansions. The source
descriptions below retain the cited families together with their mathematical
scope, domains, and accuracy claims.

## 6.20(i) Approximations in Terms of Elementary Functions
%%%
number := false
%%%

Hastings (1955) gives several minimax polynomial and rational approximations
for $`E_1(x)+\ln x`, $`x e^x E_1(x)`, and the auxiliary functions $`f(x)` and
$`g(x)`; these are included in Abramowitz and Stegun (1964), Chapter 5. Cody
and Thacher (1968) provides minimax rational approximations for
$`E_1(x)` with accuracies up to 20S, while their 1969 paper does the same for
$`\operatorname{Ei}(x)`, also up to 20S. MacLeod (1996b) provides rational
approximations for the sine and cosine integrals and for $`f` and $`g`, with
accuracies up to 20S.

::::dlmfEntry "§6.20(i) source survey" "https://dlmf.nist.gov/6.20.i"
The reusable list below records the four elementary-approximation source
families in the order used by DLMF. It is a bibliographic index; the cited
papers, not this list, supply the approximation coefficients and error data.

:::leanStatement "DLMF 6.20(i) elementary approximation sources"
```anchor dlmf_6_20_i_p1 (module := LMLF.Blueprint.ExponentialIntegrals.Section620)
def elementaryApproximationSources : List ElementaryApproximationSource :=
  [ .hastings1955
  , .codyThacher1968
  , .codyThacher1969
  , .macleod1996b ]
```
:::
::::

## 6.20(ii) Expansions in Chebyshev Series
%%%
number := false
%%%

Clenshaw (1962) gives Chebyshev coefficients for $`-E_1(x)-\ln|x|` on
$`-4\leq x\leq 4` and for $`e^xE_1(x)` on $`x\geq 4`, with 20D accuracy.
Luke and Wimp (1963) cover $`\operatorname{Ei}(x)` for $`x\leq -4` (20D),
and $`\operatorname{Si}(x)` and $`\operatorname{Ci}(x)` for $`x\geq 4` (20D).

Luke (1969b, pp. 41–42) gives Chebyshev expansions of
$`\operatorname{Ein}(ax)`, $`\operatorname{Si}(ax)`, and
$`\operatorname{Cin}(ax)` for $`-1\leq x\leq 1`, with $`a\in\mathbb{C}`; the
coefficients are expressed through series of Bessel functions. On pp. 321–322
the same source covers $`\operatorname{Ein}(x)` and
$`-\operatorname{Ein}(-x)` for $`0\leq x\leq 8` (20D), $`E_1(x)` for $`x\geq 5`
(20D), and $`\operatorname{Ei}(x)` for $`x\geq 8` (15D). Its sine- and
cosine-integral coefficients are given on pp. 325–327.

Luke (1969b, p. 25) gives a Chebyshev expansion near infinity for the
confluent hypergeometric function $`U` (see [DLMF §13.2(i)](https://dlmf.nist.gov/13.2.i)).
Using [DLMF 6.11.2](https://dlmf.nist.gov/6.11.E2) and
[DLMF 6.11.3](https://dlmf.nist.gov/6.11.E3), expansions near infinity for
$`E_1(z)`, $`f(z)`, and $`g(z)` follow. Luke supplies a recursion for the
coefficients of the $`U` expansions; when $`|\operatorname{ph}z|<\pi`, it can
be used backward.

::::dlmfEntry "§6.20(ii) source survey" "https://dlmf.nist.gov/6.20.ii"
The list records the five Chebyshev-expansion source families named by DLMF.
The domains, digit accuracies, Bessel-series description, and backward-recursion
condition are stated in the surrounding prose above.

:::leanStatement "DLMF 6.20(ii) Chebyshev sources"
```anchor dlmf_6_20_ii_p1 (module := LMLF.Blueprint.ExponentialIntegrals.Section620)
def chebyshevApproximationSources : List ChebyshevApproximationSource :=
  [ .clenshaw1962
  , .lukeWimp1963
  , .luke1969b_smallInterval
  , .luke1969b_realRanges
  , .luke1969b_infinity ]
```
:::
::::

## 6.20(iii) Padé-Type and Rational Expansions
%%%
number := false
%%%

Luke (1969b, pp. 402, 410, and 415–421) gives main diagonal Padé
approximations for $`\operatorname{Ein}(z)`, $`\operatorname{Si}(z)`, and
$`\operatorname{Cin}(z)` valid near the origin, and for $`E_1(z)` valid for
large $`|z|`; approximate errors are supplied for selected values of $`z`.
On pp. 411–414, Luke also gives rational approximations for
$`\operatorname{Ein}(z)`.

::::dlmfEntry "§6.20(iii) source survey" "https://dlmf.nist.gov/6.20.iii"
The list records the two rational-approximation source families in the order
used by DLMF. The near-origin/large-argument regimes and selected-value error
information belong to the cited Luke references.

:::leanStatement "DLMF 6.20(iii) rational sources"
```anchor dlmf_6_20_iii_p1 (module := LMLF.Blueprint.ExponentialIntegrals.Section620)
def rationalApproximationSources : List RationalApproximationSource :=
  [ .luke1969b_pade
  , .luke1969b_einRational ]
```
:::
::::
