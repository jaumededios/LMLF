# Turning points, Airy comparison, and adjacent Bessel transitions

**Document role:** planning blueprint only.  The queue entries are not theorem
cards, their named natural-language proof dossiers do not yet exist, and no Lean
implementation is authorized.

**Programme position:** Tracks C and D, downstream of the generic ODE method
layer and independent of the Watson MVP.  All transition, named construction,
and continuation work uses the three-review gate.

This refines the transition/comparison portions of the attached *Explicit
Quantitative Olver in Lean* blueprint.  It is subordinate to the current
[roadmap](../roadmap.md), [design decisions](../design_decisions.md),
[source policy](../source_manifest.md), [function
inventory](../function_inventory.md), pinned [Mathlib
audit](../mathlib_audit.md), and [review protocol](../../review/PROTOCOL.md).
The source inventory presently contains only unresolved Airy/Bessel leads, so
no formula below is represented as a collated Olver occurrence.

## 1. Scope and separation of comparison regimes

The first transition programme treats a **simple turning point** of

\[
  w''(z)=\{u^2 f(z)+g(z)\}w(z),
\]

where `f(z0)=0` and `f'(z0) != 0`.  Its comparison equation is Airy's equation.
The adjacent programme treats a **simple pole** of the leading coefficient; its
comparison equation is Bessel or modified Bessel.  These regimes share ODE
stability and scaled-jet infrastructure, but their coordinates, singular
corrections, normalizations, branches, and envelopes are not one theorem with a
tag parameter.

Initial scope is deliberately narrower than the literature:

- `u` is positive real with an explicit lower threshold;
- one simply connected complex chart around one simple turning point;
- no coalescing turning points, multiple turning points, or turning point
  meeting a pole;
- spatial derivatives first; parameter holomorphy and mixed derivatives later;
- one finite Airy comparison ansatz and explicit remainder, not an infinite
  asymptotic-series object;
- source coverage only after the exact Olver occurrences and auxiliary
  functions have been collated from the locked edition.

## 2. Simple-turning-point transformation

### 2.1 Branch-aware coordinate

The coordinate `zeta` is characterized by

\[
  \zeta(z)(\zeta'(z))^2=f(z),\qquad
  \zeta(z_0)=0,
\]

with one explicit cube-root orientation.  Away from `z0`, this agrees with

\[
  \frac23\zeta(z)^{3/2}
   =\int_{z_0}^{z}\sqrt{f(t)}\,dt,
\]

on declared branches.  The integral formula is not used at the branch point
until removable continuation has been proved.  The construction packet must
prove that `zeta` is holomorphic, `zeta'(z0) != 0`, and the displayed algebraic
identity holds on the entire chart.  Assuming a function with exactly these
properties is legitimate only for generic conditional infrastructure and earns
no turning-point or named coverage.

The cube-root choice is part of the data.  Replacing `zeta` by a cubic rotation
changes Airy sectors and connection coefficients; it is not a definitional
equality to be hidden by simplification.

### 2.2 Liouville normal form

Put

\[
  W(\zeta)=\sqrt{\zeta'(z)}\,w(z)
  \quad\text{or equivalently}\quad
  w(z)=(\zeta'(z))^{-1/2}W(\zeta(z)).
\]

Using ODE-002 and `f=\zeta(\zeta')^2`, obtain the exact equation

\[
  \frac{d^2W}{d\zeta^2}
   =\{u^2\zeta+\psi(\zeta)\}W,
\]

where, expressed in the original chart,

\[
  \psi(\zeta(z))=
    \frac{g(z)}{(\zeta'(z))^2}
    +\frac12\frac{\{\zeta,z\}}{(\zeta'(z))^2}.
\]

The proof must first establish the expanded derivative identity and then this
compact form.  It must also establish the regularity and bound of `psi` on the
actual transition region.  Totalized division at a point where `zeta'=0` is not
an extension theorem.

### 2.3 Airy scaling and scaled jet

Set `x=u^(2/3) zeta` and `U(x)=W(u^(-2/3)x)`.  Then exactly

\[
  U''(x)=\{x+u^{-4/3}\psi(u^{-2/3}x)\}U(x).
\]

The natural state is

\[
  J_u W(\zeta)=\binom{W(\zeta)}{u^{-2/3}W'(\zeta)}
              =\binom{U(x)}{U'(x)}.
\]

This equality is a scale-regression theorem, not documentation.  In original
variables, the derivative component also contains the exact derivatives of
`sqrt(zeta')`; a value error for `W` cannot simply be labeled a derivative error
for `w`.

## 3. Airy comparison system

### 3.1 Named Airy objects first

The pinned Mathlib has no named `Ai` or `Bi`.  DEF-002 must therefore audit a
construction before any named turning-point theorem.  The preferred first
substrate is Mathlib's entire regularized `0F1` kernel, sharing coefficient and
analyticity work with Bessel constructions.  DEF-002 must separately prove:

- entire construction and the Airy differential equation;
- conventional values at zero and derivative values at zero;
- identification of `Ai` and `Bi` (or another frozen basis) with conventional
  formulas;
- linear independence and exact Wronskian normalization;
- cubic-rotation formulas and real-axis agreement;
- exact exceptional/branch policy (Airy functions themselves are entire; any
  powers used in formulas still carry branches).

For the conventional `(Ai,Bi)` basis, the normalization target from the
attachment is

\[
\begin{aligned}
 \operatorname{Ai}(0)&=\frac{1}{3^{2/3}\Gamma(2/3)},&
 \operatorname{Ai}'(0)&=-\frac{1}{3^{1/3}\Gamma(1/3)},\\
 \operatorname{Bi}(0)&=\frac{1}{3^{1/6}\Gamma(2/3)},&
 \operatorname{Bi}'(0)&=\frac{3^{1/6}}{\Gamma(1/3)}.
\end{aligned}
\]

These are candidate target constants until DEF-002 is frozen and independently
checked against the selected authoritative convention.  The powers of positive
real `3` are real powers coerced to `ℂ`, not implicit complex powers.

An ODE equation without enough normalization data is not identification.  The
definition module must not import a turning-point error theorem.

### 3.2 Frames, kernels, and zero-safe envelopes

For a comparison basis `(A,B)`, use the Airy frame

\[
  \Phi_A(x)=
  \begin{pmatrix}A(x)&B(x)\\A'(x)&B'(x)\end{pmatrix}.
\]

The exact Wronskian proves invertibility.  The primary kernel majorant is

\[
  K(x,t)=\|S_x\Phi_A(x)\Phi_A(t)^{-1}S_t^{-1}\|,
\]

for explicitly positive diagonal scalings.  This operator-norm form is valid
at zeros of an individual Airy function and should precede source-specific
modulus/phase simplifications.

For a single comparison solution, never divide by `|A(x)|` on a region
containing its zeros.  A basic zero-safe jet envelope is

\[
  E_s[A](x)=\left(|A(x)|^2+s(x)^{-2}|A'(x)|^2\right)^{1/2}.
\]

Its strict positivity follows from “a nonzero solution and its derivative do
not vanish simultaneously”, itself derived from IVP uniqueness.  For complex
paths or two-solution estimates, frame/operator envelopes are preferred.  Any
Olver modulus, phase, weight, or auxiliary envelope becomes a named source
entity only after direct collation; a project envelope is marked
`project_extra`.

### 3.3 Finite Airy ansatz and residual

A candidate finite uniform approximant has the schematic form

\[
  A_N(u,\zeta)=
  \operatorname{Ai}(u^{2/3}\zeta)
       \sum_{s<N}\frac{A_s(\zeta)}{u^{2s}}
  +\frac{\operatorname{Ai}'(u^{2/3}\zeta)}{u^{4/3}}
       \sum_{s<N}\frac{B_s(\zeta)}{u^{2s}}.
\]

This formula is not frozen until the selected source occurrence fixes whether
there are `N` terms or last index `N`, which coefficients are included at
`N=0`, and the exact powers of `u`.  The first packet proves a purely exact
residual identity from explicit coefficient recurrences.  A second packet
bounds that residual and proves removability/regularity of every coefficient at
`zeta=0`.  Only then may generic ODE stability produce a remainder estimate.

No `residual_nf` tactic is planned until two distinct families exhibit the same
normalization and at least two exact residual proofs have been accepted.

## 4. Uniform transition estimate

The target theorem has the quantifier shape

\[
 \forall p\ \exists! w_p\;\mathsf{NormalizedSolution}(p,w_p),
 \quad
 \forall N\ \forall u\ge u_0\ \forall z\in D_{p,N,u},
\]

\[
  \left\|J_uW_p(\zeta(z))-J_uA_{p,N}(u,\zeta(z))\right\|
     \le B_{p,N}(u,z).
\]

The same `w_p` is used for every `N` and `u` unless `u` is itself part of the
equation parameter `p`; in that case the exact solution may depend on `u` but
still not on truncation order.  The theorem card must spell out this distinction
as an expanded quantifier list.

The majorant `B` must expose:

- the exact residual majorant;
- the Airy-frame propagator or source envelope;
- the progressive-path control integral;
- the Volterra resolvent loss (`1/(1-kappa)` or an exponential/factorial
  analogue);
- any normalization mismatch;
- every power of `u`, `zeta'`, and the chosen jet scale.

The transition domain contains `z0` and must have a concrete witness.  A bound
valid only after deleting all zeros of `Ai` is not a uniform Airy transition
bound.

## 5. Matching to outer regions

An Airy transition theorem and an outer Liouville--Green/WKB theorem are
independent results.  Matching requires a nonempty overlap on which:

1. both coordinate branches and both normalizations are identified;
2. both finite bounds hold for the same exact solution;
3. the comparison functions have an exact connection/asymptotic formula;
4. the two majorants are transported to a common scaled jet;
5. the overlap thresholds and sector inequalities are proved compatible.

Transitivity of error bounds then yields an explicit mismatch estimate.  It
does not by itself prove an exact connection coefficient; exact coefficients
come from Wronskians or normalization uniqueness as described in
`zeros_connections.md`.

## 6. Adjacent simple-pole/Bessel programme

If `f` has a simple pole, a Langer coordinate is characterized on a punctured
chart by

\[
  (\xi')^2=4\sigma\xi f,
  \qquad \sigma\in\{+1,-1\},
\]

with branch/orientation fixed by an integral of `sqrt(sigma*f)`.  The model
equation is of the form

\[
  V''(\xi)=\left\{
    \frac{\sigma u^2}{4\xi}
    +\frac{\nu^2-1}{4\xi^2}
  \right\}V(\xi),

\]

whose solutions are scaled ordinary or modified Bessel functions after
`x=u*sqrt(xi)`.  The sign, square-root branch, Bessel order, and normalization
must be verified from the selected equation; they are not inferred from the
word “Bessel”.

The exact transformed coefficient generally contains a singular correction.
The programme must isolate its principal part, prove the claimed remainder is
removable or integrable in the precise weighted space, and state whether the
endpoint itself belongs to the domain.  Ordinary Bessel, modified Bessel,
Hankel, and rotated bases have different continuation and connection data; one
generic frame theorem may consume them, but their named definitions and
identifications stay separate.

The preferred construction audit again starts from regularized hypergeometric
kernels.  It must not conflate `J`, `Y`, `I`, `K`, or Hankel functions, and must
handle exceptional orders and logarithmic continuation explicitly.  This is a
separate queue after the Airy pilot, not a condition on it.

## 7. Proposed module and dependency seams

```text
LMLF.ODE.* accepted generic layer
  |-- LMLF.Definitions.Airy --------------------+
  |                                             |
  +-> LMLF.Transition.TurningPoint.Chart        |
       -> LMLF.Transition.TurningPoint.NormalForm
       -> LMLF.Transition.Airy.Frame <----------+
       -> LMLF.Transition.Airy.Residual
       -> LMLF.Transition.Airy.Stability
       -> LMLF.Transition.Airy.OriginalVariable
       -> named applications / Audit regressions

LMLF.ODE.* accepted generic layer
  |-- LMLF.Definitions.Bessel
  `-> LMLF.Transition.SimplePole.* -> named applications
```

Definitions depend on construction substrates and identification facts only.
Transition methods may import definitions.  A named application imports both,
and audit modules consume the result.  No edge points from Airy/Bessel
definitions to transition estimates.

## 8. Theorem-card queue, dossiers, and three-review gate

Every row contains genuinely new formal mathematics or high-risk named
identification and therefore needs the complete future NLP shown.  **Gate 3**
means three independent approvals of both frozen theorem-card semantics and the
complete NLP: source/normalization, proof/quantitative, and
structure/circularity.  The source reviewer may mark source fidelity
`not_applicable` only for an honestly project-generic card, but the third
transition review still applies.

| Queue ID | Genuinely new result and bounded scope | NLP dossier | Gate | Depends on | Acceptance IDs |
|---|---|---|---:|---|---|
| DEF-002 | Construct and identify one Airy basis, including ODE, initial values, Wronskian, rotations, and real agreement; no asymptotics | `blueprint/proofs/DEF-002.md` | 3 | regularized `0F1` substrate audit | TP-T01–T05 |
| TP-001 | Construct the simple-turning coordinate on one explicit chart and prove `zeta*(zeta')^2=f`, branch, and nonvanishing derivative | `blueprint/proofs/TP-001.md` | 3 | branch support | TP-T06–T11 |
| TP-002 | Exact Liouville normal form and regular transformed `psi` on the chart | `blueprint/proofs/TP-002.md` | 3 | ODE-002 + TP-001 | TP-T12–T16 |
| TP-003 | Airy frame, inverse, scaled propagator kernel, and zero-safe jet envelope | `blueprint/proofs/TP-003.md` | 3 | DEF-002 + ODE-010 | TP-T17–T22 |
| TP-004 | Exact Airy finite-ansatz residual for one frozen order convention and recurrence | `blueprint/proofs/TP-004.md` | 3 | DEF-002 + TP-002 | TP-T23–T27 |
| TP-005 | Explicit residual majorant, coefficient removability at `zeta=0`, and progressive-path integral bound | `blueprint/proofs/TP-005.md` | 3 | TP-003 + TP-004 + ODE-009 | TP-T28–T32 |
| TP-006 | Uniform scaled-jet stability for one fixed normalized transformed solution | `blueprint/proofs/TP-006.md` | 3 | ODE-011 + TP-003 + TP-005 | TP-T33–T38 |
| TP-007 | Transport the bound to original values and spatial derivatives with every `zeta'`/gauge factor | `blueprint/proofs/TP-007.md` | 3 | TP-002 + TP-006 | TP-T39–T43 |
| TP-008 | Explicit nonempty overlap and quantitative matching with one accepted outer expansion | `blueprint/proofs/TP-008.md` | 3 | TP-007 + outer WKB card | TP-T44–T48 |
| TP-009 | Parameter-holomorphy and mixed-derivative bounds, with parameter/spatial variables separated | `blueprint/proofs/TP-009.md` | 3 | TP-006 + Cauchy/parameter integral infrastructure | TP-T49–T52 |
| DEF-003 | Construct/identify the first required Bessel or modified-Bessel basis, including exceptional order and continuation policy | `blueprint/proofs/DEF-003.md` | 3 | regularized hypergeometric substrate | BP-T01–T06 |
| BP-001 | Construct one simple-pole coordinate and prove the exact singular normal form/principal part | `blueprint/proofs/BP-001.md` | 3 | ODE-002 + branch support | BP-T07–T12 |
| BP-002 | Bessel-frame envelope and explicit Volterra stability on one punctured/endpoint domain | `blueprint/proofs/BP-002.md` | 3 | DEF-003 + BP-001 + ODE-011 | BP-T13–T19 |

TP-004 is carded only after direct source collation if it is intended to match
an Olver recurrence.  Before that, a project-generic recurrence may be carded
with `coverage_class: infrastructure` and `novelty_class: novel`; it earns no
source occurrence credit.

After Lean implementation, every used packet receives all applicable
implementation rubrics at the exact candidate head.  In particular,
source-fidelity and quantitative-correctness review the branch, normalization,
parameter power, domain, and constant independently; API/dependency review
checks that `Definitions.Airy`/`Definitions.Bessel` do not import transition
estimates.  Review artifacts remain external, and any card, dossier, source
snapshot, dependency pin, or candidate-head change invalidates approvals.

## 9. Dependency DAG

```text
regularized 0F1 audit ---> DEF-002 ---------------------> TP-003
branch support ----------> TP-001 ---> TP-002 ----------> TP-004 ---> TP-005
ODE-002 ------------------------------^                    ^          |
ODE-009 + ODE-010 ----------------------------------------+----------+
                                                                   |
ODE-011 ----------------------------------------------------------> TP-006
TP-002 + TP-006 --------------------------------------------------> TP-007
outer WKB card + TP-007 ------------------------------------------> TP-008
Cauchy/parameter infrastructure + TP-006 ------------------------> TP-009

regularized hypergeometric audit -> DEF-003 -> BP-002
branch support + ODE-002 ----------> BP-001 ---> BP-002
ODE-011 ----------------------------------------> BP-002
```

Airy definition work and turning-coordinate work can proceed independently.
The Airy and Bessel branches share accepted generic ODE infrastructure, not
each other's named theorems.

## 10. Acceptance tests

### Airy and turning-point tests

| ID | Required check |
|---|---|
| TP-T01 | The constructed Airy objects satisfy `A''(z)=z*A(z)` globally. |
| TP-T02 | Values and first derivatives at zero match the frozen conventional constants. |
| TP-T03 | The Wronskian has the exact sign and constant fixed by the basis order. |
| TP-T04 | Cubic rotation formulas are expanded at `z=0` to detect swapped roots of unity. |
| TP-T05 | Real agreement and reality on the real axis are proved from the construction. |
| TP-T06 | Model `f(z)=z`, `z0=0` gives `zeta=z` for the chosen orientation. |
| TP-T07 | Model `f(z)=a*z` exposes the chosen cube root and derivative at zero. |
| TP-T08 | `zeta(z0)=0`, `zeta'(z0)!=0`, and `zeta*(zeta')^2=f` all hold at the turning point by continuation, not division. |
| TP-T09 | Replacing the cube root by another branch changes the recorded sector labels predictably. |
| TP-T10 | The chart domain is open, simply connected as required, and visibly contains `z0` plus a nontrivial point. |
| TP-T11 | A double zero of `f` fails the simple-turning hypotheses. |
| TP-T12 | For `f(z)=z`, `g=0`, the transformed perturbation `psi` is exactly zero. |
| TP-T13 | Identity/affine coordinate cases match ODE-002 with no lost gauge factor. |
| TP-T14 | Every occurrence of `(zeta')^-1` is guarded by nonvanishing on the full region. |
| TP-T15 | The scaled equation has perturbation exactly `u^(-4/3)*psi`, checked algebraically. |
| TP-T16 | The `u^(2/3)` and `u^(-2/3)` derivative conversions are exact at `u=1` and symbolic positive `u`. |
| TP-T17 | The frame determinant equals the accepted Airy Wronskian. |
| TP-T18 | Frame inverse multiplication is tested in both orders. |
| TP-T19 | The envelope remains positive at a zero of `Ai` because `Ai'` is nonzero there. |
| TP-T20 | A forbidden relative bound dividing by `|Ai|` fails on a disk containing an Airy zero. |
| TP-T21 | Scaling matrices and their inverses are nonzero/positive on the stated domain. |
| TP-T22 | Kernel orientation and basis-column order preserve the Wronskian sign. |
| TP-T23 | `N=0` has an explicit convention and residual. |
| TP-T24 | The first two nontrivial orders are expanded directly and agree with the recurrence. |
| TP-T25 | Exact cancellations occur before any triangle inequality. |
| TP-T26 | Apparent coefficient singularities at `zeta=0` are removed by proved numerator vanishing, not totalized division. |
| TP-T27 | Terminating/vanishing coefficients produce the expected exact residual. |
| TP-T28 | Every residual majorant is nonnegative on the exact transition domain. |
| TP-T29 | The progressive path exists for the base point and at least one nontrivial endpoint. |
| TP-T30 | The control integral is finite across `zeta=0`. |
| TP-T31 | Sector boundaries and Stokes rays use explicit weak/strict inequalities and endpoint policy. |
| TP-T32 | No selected path crosses the branch cut or a singularity of `psi`. |
| TP-T33 | Zero perturbation and matching normalization give zero remainder. |
| TP-T34 | Initial/endpoint normalization mismatch appears explicitly when nonzero. |
| TP-T35 | The fixed exact solution is outside the `N` quantifier. |
| TP-T36 | The estimate is finite and zero-safe at `zeta=0` and at comparison-function zeros. |
| TP-T37 | The natural bound is exported before any weakened constant/threshold corollary. |
| TP-T38 | The domain is nonempty and the public majorant is proved nonnegative. |
| TP-T39 | Original value transport includes `(zeta')^-1/2` exactly. |
| TP-T40 | Original derivative transport includes both the derivative of the gauge and the derivative of the composition. |
| TP-T41 | Spatial derivative is not silently replaced by the `zeta` or scaled-`x` derivative. |
| TP-T42 | Any square-root gauge branch is shown consistent across the whole chart. |
| TP-T43 | A direct exact-model example agrees before and after transport. |
| TP-T44 | The overlap region has an explicit witness for every admitted parameter range. |
| TP-T45 | Both expansions concern the same normalized solution. |
| TP-T46 | Threshold and sector conditions from both sides are jointly proved. |
| TP-T47 | Error transitivity exposes the sum/product of all scale factors. |
| TP-T48 | Exact connection constants are not inferred from a merely small overlap error. |
| TP-T49 | Parameter and spatial variables have separately named derivative operators. |
| TP-T50 | Differentiation under integrals/series has an explicit uniform majorant. |
| TP-T51 | Cauchy parameter estimates use an explicit disk contained in parameter space. |
| TP-T52 | Mixed derivative order and factorial/radius losses are frozen and tested at order zero. |

### Bessel/simple-pole tests

| ID | Required check |
|---|---|
| BP-T01 | The selected `J/I`-type object satisfies the correct signed Bessel equation. |
| BP-T02 | Series normalization and the value-changing regularization factor are explicit. |
| BP-T03 | `J`, `Y`, `I`, `K`, and Hankel objects are not identified by aliases. |
| BP-T04 | Integer/exceptional order and logarithmic continuation cases have exact policies. |
| BP-T05 | The basis Wronskian has the exact sign, scale, and branch. |
| BP-T06 | Real/complex agreement is proved on the actual cut domain. |
| BP-T07 | A simple-pole model gives `xi` linear at the pole under the chosen orientation. |
| BP-T08 | The identity `(xi')^2=4*sigma*xi*f` is proved without evaluating a punctured formula illegally at the pole. |
| BP-T09 | Substitution `x=u*sqrt(xi)` produces exactly the displayed Bessel model coefficient. |
| BP-T10 | The principal `xi^-2` term fixes `nu`; totalized powers at `xi=0` do not hide it. |
| BP-T11 | The remainder's removability or weighted integrability is proved. |
| BP-T12 | Endpoint inclusion/exclusion and boundary normalization are explicit. |
| BP-T13 | Frame determinant and inverse are valid on the exact punctured/continued domain. |
| BP-T14 | Kernel integrability at the singular endpoint is proved with the selected weight. |
| BP-T15 | Ordinary versus modified sign is tested on a constant-coefficient reduction. |
| BP-T16 | The bound is stable at zeros by using a frame/jet envelope. |
| BP-T17 | Order-zero and first-order finite approximants have explicit residuals. |
| BP-T18 | The exact solution is fixed independently of truncation order. |
| BP-T19 | Every named specialization proves domain reachability and majorant nonnegativity. |

## 11. Known hard research questions

1. Which local complex-analytic inverse theorem best constructs `zeta` with
   quantitative domain control and a chosen cube root on the pinned Mathlib?
2. What hypotheses on `f` and `g` are both natural and Lean-manageable for
   proving regularity of `psi` at a simple turning point?
3. Should the first Airy basis be `(Ai,Bi)` or rotated `Ai` solutions?  The
   choice changes sector symmetry, real normalization, and connection matrices.
4. Can regularized `0F1` yield conventional Airy and Bessel normalizations with
   tolerable Gamma/complex-power bridge overhead?
5. How should Olver's modulus, phase, weight, and envelope functions be encoded
   so they are zero-safe, source-faithful, and not duplicated by generic frame
   norms?
6. What is the sharpest kernel bound that remains practical in a matrix/operator
   norm and preserves Olver's natural constants?
7. Which coefficient recurrence has removable values at `zeta=0`, and what
   finite algebra best proves the cancellation without quotient totalization?
8. Can progressive paths be constructed uniformly over a full transition
   region, including Stokes boundaries, without a large bespoke planar-topology
   library?
9. How should complex `u` and its fractional powers be introduced later without
   invalidating the positive-real pilot's signatures?
10. For the simple-pole case, what is the exact principal-part condition linking
    `g` and Bessel order `nu`, especially at exceptional orders?
11. Can a single frame-envelope interface serve Airy and Bessel consumers while
    keeping source-specific auxiliary functions and constants visible?
12. What overlap theorem is strong enough to connect transition and outer
    expansions without using approximate matching to assert exact Stokes data?

## 12. Exit criteria

The Airy pilot is complete only when the named Airy objects are independently
identified; the turning chart and transformed potential are exact; the finite
residual is checked at zero and small order; the scaled-jet stability theorem is
uniform at the turning point and Airy zeros; and a named application discharges
path existence, normalization, nonempty-domain, and majorant obligations.  Every
used packet must have its frozen dossier and three independent approvals.

The Bessel programme has a separate exit.  Success of Airy infrastructure does
not establish a simple-pole theorem, Bessel definition, exceptional-order
continuation, or connection formula.
