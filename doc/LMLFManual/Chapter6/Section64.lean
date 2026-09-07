import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section64
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section64
set_option verso.exampleProject "."

#doc (Manual) "§6.4 Analytic Continuation" =>
%%%
tag := "chapter-6-section-4"
%%%

:::dlmfChapter "https://dlmf.nist.gov/6.4"
Source: NIST Digital Library of Mathematical Functions, §6.4.
:::

# §6.4 Analytic Continuation
%%%
number := false
%%%

Analytic continuation of the principal value of E1 has branch points at zero
and infinity.  The general value is indexed by the integer winding of the
general logarithm.  A `CutSide` records the upper or lower boundary side of
the negative-real-axis cut.  The `HalfTurnLift` object retains that side,
along with its source, nonzero condition, oriented path, endpoint limit,
continuity, and a continuous lifted logarithm whose endpoint records exactly
the signed half-turn.  Thus the ordinary endpoint may be the same point `-z`
for both sides while the branch data remain distinct.  `GeneralE1Continuation` separately
stores a lifted logarithm and its continuation limit, so the displayed
identities are laws about canonical continuation objects rather than aliases
for their right-hand sides.

::::dlmfEntry "General-value setup" "https://dlmf.nist.gov/6.4#p1"
The DLMF introduces the multi-valued continuation of E1 and its branch points
at zero and infinity before giving the general-value formula below.
::::

:::leanStatement "6.4 typed half-turn lift"
```anchor HalfTurnLift (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
structure HalfTurnLift where
  source : ℂ
  side : CutSide
  nonzero : source ≠ 0
  path : ℝ → ℂ
  path_start : path 0 = source
  path_endpoint : Tendsto path atTop (𝓝 (-source))
  path_continuous : Continuous path
  path_nonzero : ∀ t : ℝ, path t ≠ 0
  liftedLog : ℝ → ℂ
  liftedLog_continuous : Continuous liftedLog
  liftedLog_exp : ∀ t : ℝ, Complex.exp (liftedLog t) = path t
  liftedLog_start : liftedLog 0 = Complex.log source
  liftedLog_endpoint : Tendsto liftedLog atTop
    (𝓝 (Complex.log source + (sideSign side : ℂ) * (Real.pi : ℂ) * Complex.I))
```
:::

:::leanStatement "6.4 lifted general E₁ continuation"
```anchor GeneralE1Continuation (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
structure GeneralE1Continuation where
  source : ℂ
  winding : ℤ
  nonzero : source ≠ 0
  path : ℝ → ℂ
  path_start : path 0 = source
  path_endpoint : Tendsto path atTop (𝓝 source)
  path_nonzero : ∀ t : ℝ, path t ≠ 0
  liftedLog : ℝ → ℂ
  liftedLog_continuous : Continuous liftedLog
  liftedLog_exp : ∀ t : ℝ, Complex.exp (liftedLog t) = path t
  liftedLog_start : liftedLog 0 = Complex.log source
  liftedLog_endpoint : Tendsto liftedLog atTop (𝓝 (branchLog source winding))
  value : ℂ
  value_limit : Tendsto
    (fun t => LMLF.Blueprint.ExponentialIntegrals.Section62.principalEin (path t) -
      liftedLog t - (Real.eulerMascheroniConstant : ℂ))
    atTop (𝓝 value)
```
:::

:::leanStatement "6.4 canonical half-turn boundary limit"
```anchor HasHalfTurnLimit (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
def HasHalfTurnLimit (f : ℂ → ℂ → ℂ) (P : HalfTurnLift) (v : ℂ) : Prop :=
  Tendsto (fun t : ℝ => f (P.path t) (P.liftedLog t)) atTop (𝓝 v)
```
:::

:::leanStatement "6.4 lower-case sine-integral tail"
```anchor principalSiTailValue (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
def principalSiTailValue (z : ℂ) : ℂ :=
  LMLF.Blueprint.ExponentialIntegrals.Section62.principalSi z -
    (Real.pi : ℂ) / 2
```
:::

The continuation-side reconstructions of the auxiliary functions are named
separately from the canonical §6.2 pair.  The bridge statements below identify
them on the principal-cut domain; outside that domain the continuation-side
name keeps its branch context visible.

:::leanStatement "6.4 branch-side auxiliary f value"
```anchor principalContinuationFValue (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
def principalContinuationFValue (z : ℂ) : ℂ :=
  principalCiValue z * Complex.sin z -
    principalSiTailValue z * Complex.cos z
```
:::

:::leanStatement "6.4 branch-side auxiliary g value"
```anchor principalContinuationGValue (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
def principalContinuationGValue (z : ℂ) : ℂ :=
  -principalCiValue z * Complex.cos z -
    principalSiTailValue z * Complex.sin z
```
:::

:::leanStatement "6.4 principal-domain f bridge"
```anchor principalContinuationFValue_bridge (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
/-- DLMF 6.4.E6: principal-domain bridge for the branch-side f value. -/
theorem principalContinuationFValue_eq_principalAuxiliaryF (z : ℂ)
    (hz : Section62.principalCutDomain z) :
    principalContinuationFValue z = Section62.principalAuxiliaryF z
```
:::

:::leanStatement "6.4 principal-domain g bridge"
```anchor principalContinuationGValue_bridge (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
/-- DLMF 6.4.E7: principal-domain bridge for the branch-side g value. -/
theorem principalContinuationGValue_eq_principalAuxiliaryG (z : ℂ)
    (hz : Section62.principalCutDomain z) :
    principalContinuationGValue z = Section62.principalAuxiliaryG z
```
:::

:::leanStatement "6.4 branch-aware continuation expressions"
```anchor halfTurnE1Continuation (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
def halfTurnE1Continuation (z logz : ℂ) : ℂ :=
  LMLF.Blueprint.ExponentialIntegrals.Section62.principalEin z - logz -
    (Real.eulerMascheroniConstant : ℂ)
```

```anchor halfTurnCiContinuation (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
def halfTurnCiContinuation (z logz : ℂ) : ℂ :=
  -LMLF.Blueprint.ExponentialIntegrals.Section62.principalCin z + logz +
    (Real.eulerMascheroniConstant : ℂ)
```

```anchor halfTurnChiContinuation (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
def halfTurnChiContinuation (z logz : ℂ) : ℂ :=
  (Real.eulerMascheroniConstant : ℂ) + logz +
    LMLF.Blueprint.ExponentialIntegrals.Section62.principalChiRegular z
```

```anchor halfTurnFContinuation (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
def halfTurnFContinuation (z logz : ℂ) : ℂ :=
  halfTurnCiContinuation z logz * Complex.sin z -
    principalSiTailValue z * Complex.cos z
```

```anchor halfTurnGContinuation (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
def halfTurnGContinuation (z logz : ℂ) : ℂ :=
  -halfTurnCiContinuation z logz * Complex.cos z -
    principalSiTailValue z * Complex.sin z
```
:::

::::dlmfEntry "General value of E1" "https://dlmf.nist.gov/6.4.E1"
The DLMF writes the general value as

$$`E_{1}(z)=\operatorname{Ein}(z)-\operatorname{Ln}z-\gamma,\qquad
\operatorname{Ln}z=\ln z+2m\pi i,\quad m\in\mathbb Z.`$$

Here `generalE1Value` uses the canonical `principalEin` from §6.2, the
principal logarithm, Euler's constant, and the explicit integer branch index.

:::leanStatement "6.4.E1 general logarithmic value"
```anchor dlmf_6_4_E1 (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
theorem dlmf_6_4_E1 (L : GeneralE1Continuation) :
    L.value = generalE1Value L.source L.winding
```
:::
::::

::::dlmfEntry "Full-turn monodromy" "https://dlmf.nist.gov/6.4.E2"
For a full turn, the endpoint is written using z multiplied by the exponential
of 2m times pi times the imaginary unit, while the continuation retains the
integer winding and changes by the corresponding 2m pi i term:

$$`E_{1}(ze^{2m\pi i})=E_{1}(z)-2m\pi i,\qquad m\in\mathbb Z.`$$

The Lean statement uses a lifted path with an explicit endpoint and continuous
logarithm.  Its theorem records the branch change directly; the path and its
winding data remain in `GeneralE1Continuation` rather than being reconstructed
from an ordinary complex endpoint.

:::leanStatement "6.4.E2 full-turn branch change"
```anchor dlmf_6_4_E2 (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
theorem dlmf_6_4_E2 (L : GeneralE1Continuation) :
    L.value = generalE1Value L.source 0 -
      2 * (L.winding : ℂ) * (Real.pi : ℂ) * Complex.I
```
:::
::::

::::dlmfEntry "Half-turn boundary values" "https://dlmf.nist.gov/6.4.E3"
For a source point with phase bounded by pi, the two half-turns give the two
sides of the cut:

$$`E_{1}(ze^{\pm\pi i})=\operatorname{Ein}(-z)-\ln z-\gamma
\mp\pi i,\qquad |\operatorname{ph}z|\leq\pi.`$$

`HalfTurnLift.side` supplies the paired signs, while its continuous lifted
logarithm makes the continuation branch explicit. The Lean declaration states
the limit directly at the canonical right-hand side; a reader does not need to
introduce a separate variable for the value of the limit.

:::leanStatement "6.4.E3 half-turn sides"
```anchor dlmf_6_4_E3 (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
theorem dlmf_6_4_E3 (P : HalfTurnLift)
    : HasHalfTurnLimit
      halfTurnE1Continuation P
      (LMLF.Blueprint.ExponentialIntegrals.Section62.principalEin (-P.source) -
        Complex.log P.source - (Real.eulerMascheroniConstant : ℂ) -
          (sideSign P.side : ℂ) * (Real.pi : ℂ) * Complex.I)
```
:::
::::

::::dlmfEntry "Ci continuation" "https://dlmf.nist.gov/6.4.E4"
The cosine integral has the signed jump

$$`\operatorname{Ci}(ze^{\pm\pi i})=\pm\pi i+\operatorname{Ci}(z).`$$

`principalCiValue` is reconstructed from the canonical `Cin` and logarithm
relations in §6.2. The theorem identifies the side-indexed half-turn limit of
the branch-aware half-turn continuation expression, whose source-side value is
`principalCiValue`.

:::leanStatement "6.4.E4 Ci cut sides"
```anchor dlmf_6_4_E4 (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
theorem dlmf_6_4_E4 (P : HalfTurnLift)
    : HasHalfTurnLimit halfTurnCiContinuation P
      ((sideSign P.side : ℂ) * (Real.pi : ℂ) * Complex.I + principalCiValue P.source)
```
:::
::::

::::dlmfEntry "Chi continuation" "https://dlmf.nist.gov/6.4.E5"
Likewise,

$$`\operatorname{Chi}(ze^{\pm\pi i})=\pm\pi i+\operatorname{Chi}(z).`$$

The canonical principal value comes from the §6.2.E16 logarithmic relation.
The theorem identifies the side-indexed half-turn limit of the branch-aware
half-turn continuation expression, whose source-side value is
`principalChiValue`.

:::leanStatement "6.4.E5 Chi cut sides"
```anchor dlmf_6_4_E5 (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
theorem dlmf_6_4_E5 (P : HalfTurnLift)
    : HasHalfTurnLimit halfTurnChiContinuation P
      ((sideSign P.side : ℂ) * (Real.pi : ℂ) * Complex.I + principalChiValue P.source)
```
:::
::::

::::dlmfEntry "Auxiliary sine-integral continuation" "https://dlmf.nist.gov/6.4.E6"
For the auxiliary function f, the side-dependent exponential term is

$$`f(ze^{\pm\pi i})=\pi e^{\mp iz}-f(z).`$$

The source-side principal value is the §6.2.E17 combination of canonical Ci
and the lower-case tail `si(z)=Si(z)-π/2`. The theorem identifies the
side-indexed half-turn limit of the corresponding branch-aware half-turn
continuation expression.

:::leanStatement "6.4.E6 f cut sides"
```anchor dlmf_6_4_E6 (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
theorem dlmf_6_4_E6 (P : HalfTurnLift)
    : HasHalfTurnLimit halfTurnFContinuation P
      ((Real.pi : ℂ) * Complex.exp (-((sideSign P.side : ℂ) * Complex.I * P.source)) -
        principalContinuationFValue P.source)
```
:::
::::

::::dlmfEntry "Auxiliary cosine-integral continuation" "https://dlmf.nist.gov/6.4.E7"
For the auxiliary function g,

$$`g(ze^{\pm\pi i})=\mp\pi i e^{\mp iz}+g(z).`$$

The corresponding §6.2.E18 principal combination uses the same lower-case
tail and the typed half-turn limit is displayed by the following declaration.

:::leanStatement "6.4.E7 g cut sides"
```anchor dlmf_6_4_E7 (module := LMLF.Blueprint.ExponentialIntegrals.Section64)
theorem dlmf_6_4_E7 (P : HalfTurnLift)
    : HasHalfTurnLimit halfTurnGContinuation P
      (-((sideSign P.side : ℂ) * (Real.pi : ℂ) * Complex.I) *
          Complex.exp (-((sideSign P.side : ℂ) * Complex.I * P.source)) +
          principalContinuationGValue P.source)
```
:::
::::

::::dlmfEntry "Continuation dependencies and source note" "https://dlmf.nist.gov/6.4#info"
The source note cites Olver (1997b, p. 40).  It also records the dependency
split: E3 follows the continuation material in §§6.6(ii) and 6.6(iv), E4 and
E5 use the Ci and Chi relations in §§6.2(ii) and 6.2(iii), and E6 and E7 use
the auxiliary-function relations in §§6.2(iii), together with E4.
::::

::::dlmfEntry "Neighboring definitions" "https://dlmf.nist.gov/6.4#p2"
The formulas above therefore use the canonical §6.2 definitions and retain
their source dependencies rather than introducing arbitrary carrier
functions.  The branch-side object is local vocabulary for the continuation
boundary and does not assert that the two sides are equal as complex numbers.
::::

::::dlmfEntry "Principal-value convention" "https://dlmf.nist.gov/6.4#p3"
Unless indicated otherwise, E1, Ci, Chi, f, and g mean their principal values:
the branches real on the positive real axis, with the two boundary values
retained on the negative real axis. See also [§6.3](https://dlmf.nist.gov/6.3)
and [§6.5](https://dlmf.nist.gov/6.5).
::::

end LMLFManual.Chapter6
