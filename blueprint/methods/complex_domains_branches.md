# Complex domains, branch charts, and real/complex agreement

**Document status:** planning specification; not a theorem card and not Lean authorization

**Roadmap position:** low-level support for M3 and later definition, transition, and connection work

**Coverage class:** infrastructure; this document claims no Olver occurrence

**Authoritative dependency snapshot:** Lean/Mathlib `v4.33.1`, resolved Mathlib commit
`0df444a360eaa60ab8c11dca51a86af692955474`

This document refines the domain and branch portions of the attached *Explicit Quantitative Olver in
Lean* blueprint. It is subordinate to the repository's [roadmap](../roadmap.md),
[design decisions](../design_decisions.md), [source policy](../source_manifest.md), and
[review protocol](../../review/PROTOCOL.md). All declaration names and signatures below are candidates
for future frozen theorem cards. None is authorized merely by appearing here.

## 1. Scope and fixed rules

The layer has four jobs:

1. express half-planes, radial regions, sector-like regions, disks, and their quantitative margins as
   ordinary sets and inequalities;
2. carry an actual complex extension, not only an existential extension;
3. make logarithm branches, their normalizations, and changes of chart explicit;
4. connect complex functions and derivatives to their real restrictions on genuine neighborhoods.

It does not construct named special functions, prove remainder estimates, implement a Riemann-surface
framework, or infer a usable radius from openness. Definitions may import the branch layer, while the
branch and domain files must not import named definitions, quantitative remainder methods, applications,
or tactics.

The following rules are frozen for future cards.

- A disk used analytically has a named center and a strictly positive radius. State separately whether
  the open ball, closed ball, or boundary sphere must lie in the validity domain.
- A branch-sensitive identity is an `EqOn` statement on its branch domain. Lean's totalized `log`,
  power, inverse, and derivative operations do not continue identities across a cut, zero, or a pole.
- A source sector and a proof-friendly conic region may coexist, but an equivalence theorem must connect
  them before one silently replaces the other in a source application.
- A concrete application proves domain reachability or nonemptiness. Generic containment lemmas may be
  vacuously true on an empty set.
- Spatial and parameter variables are labelled in every analytic statement. A spatial branch does not
  automatically provide parameter analyticity.
- Natural quantitative margins are exported before simplified constants.

## 2. Proposed module boundary and dependency direction

```text
Mathlib metric/set/complex basics
  |
  +--> LMLF.Complex.Domain
  |
  +--> LMLF.Complex.Branch
  |       `-- principal chart and generic chart laws
  |
  +--> LMLF.Complex.RealRestriction
  |
  `--> LMLF.Complex.LogCoordinates        (later, only when a real consumer exists)

Domain + RealRestriction + accepted QB finite-error core
  `--> LMLF.Complex.CauchyRemainder

Branch
  `--> individual LMLF.Construction.* / LMLF.Definitions.* files
```

Candidate narrow Mathlib imports are:

| Project file | Candidate imports | Prohibited downward dependency |
|---|---|---|
| `LMLF/Complex/Domain.lean` | `Mathlib.Analysis.Complex.HalfPlane`, metric-ball and complex-norm basics | branches, definitions, estimates |
| `LMLF/Complex/Branch.lean` | `Mathlib.Analysis.SpecialFunctions.Complex.Analytic`; add `Mathlib.Analysis.Complex.BranchLogRoot` only for the generic existence theorem | named functions, Cauchy remainders |
| `LMLF/Complex/RealRestriction.lean` | `Mathlib.Analysis.Complex.RealDeriv`, iterated-derivative lemmas only when the all-orders bridge is carded | named functions, applications |
| `LMLF/Complex/LogCoordinates.lean` | accepted `Branch` plus calculus chain rules | application-specific continuation |

Do not put these imports into `LMLF.Basic`. Implementations should use individual modules; a later public
umbrella may import the accepted files without becoming a dependency of them.

## 3. Domain representation and geometric lemmas

### 3.1 Canonical sets

Use Mathlib's `Metric.ball`, `Metric.closedBall`, and `Metric.sphere` directly. Use literal half-plane
sets such as `{z : ℂ | c < z.re}` unless at least two consumers show that a small abbreviation improves
discoverability. Mathlib already proves their openness; a duplicate half-plane structure would add no
value.

An argument-free sector surrogate is useful for estimates. For a unit complex axis `u` and aperture
parameter `κ`, use the conic inequality

\[
  \operatorname{ConicSector}(u,\kappa)
  =\{z:\operatorname{Re}(\overline u z)>\kappa |z|\}.
\]

For `0 ≤ κ < 1`, this is the open cone around the ray through `u` with half-angle
`arccos κ`. The inequality form avoids principal-argument wraparound and gives a linear disk margin.
Source-facing angular sectors can be defined separately using the collated convention; their bridge to
`ConicSector` is a theorem, not definitional equality.

Candidate definitions, after a compile spike fixes namespaces and coercions:

```lean
namespace LMLF.ComplexDomain

def conicSector (u : ℂ) (kappa : ℝ) : Set ℂ :=
  {z | kappa * ‖z‖ < (starRingEnd ℂ u * z).re}

def openAnnulus (rho R : ℝ) : Set ℂ :=
  {z | rho < ‖z‖ ∧ ‖z‖ < R}

end LMLF.ComplexDomain
```

Do not make the axis normalization an invisible field. Theorems using `conicSector u κ` state
`‖u‖ = 1`; applications then expose rotations and scaling explicitly.

### 3.2 The minimum disk-geometry API

The first domain packet should freeze theorem shapes equivalent to the following facts. Names are
provisional, but each conclusion is part of the proposed public contract.

| Candidate | Exact mathematical conclusion | Essential hypotheses |
|---|---|---|
| `norm_sub_radius_le_of_mem_closedBall` | `‖z‖ - r ≤ ‖w‖` | `0 ≤ r`, `w ∈ closedBall z r` |
| `norm_le_add_radius_of_mem_closedBall` | `‖w‖ ≤ ‖z‖ + r` | same |
| `closedBall_subset_compl_zero` | `closedBall z r ⊆ {0}ᶜ` | `0 ≤ r`, `r < ‖z‖` |
| `closedBall_subset_re_gt` | `closedBall z r ⊆ {w | c < w.re}` | `0 ≤ r`, `r < z.re - c` |
| `closedBall_subset_openAnnulus` | `closedBall z r ⊆ openAnnulus ρ R` | `0 ≤ r`, `ρ + r < ‖z‖`, `‖z‖ + r < R` |
| `closedBall_subset_conicSector` | `closedBall z r ⊆ conicSector u κ` | `0 ≤ r`, `‖u‖=1`, `0≤κ`, `(1+κ)r < Re(conj u*z)-κ‖z‖` |

The conic-sector margin follows from

\[
 \operatorname{Re}(\overline u w)\ge
 \operatorname{Re}(\overline u z)-r,
 \qquad |w|\le |z|+r.
\]

The strict inequality deliberately puts the closed ball inside an open domain. A non-strict version
belongs only with a closed target region.

For a positive real center `x` and proportional radius `θx`, add focused corollaries:

\[
  x>0,\quad 0<\theta<1
  \Longrightarrow
  \overline B(x,\theta x)\subset\{z:\operatorname{Re}z>0\},
\]

and, for `w` in that closed ball or its sphere,

\[
  (1-\theta)x\le |w|\le(1+\theta)x.
\]

These are the geometry inputs for the optimized Cauchy bounds. Keeping them in `Domain` prevents the
Cauchy file from accumulating application-specific complex arithmetic.

### 3.3 Boundary-to-center weight comparisons

Turn the radial inequalities into reusable order-sensitive comparisons, without defining a universal
weight typeclass. Initial candidates are:

- if `0 < L` and `L ≤ ‖w‖`, then `‖w‖⁻ⁿ ≤ L⁻ⁿ` for `n : ℕ`;
- on `sphere (x : ℂ) (θ*x)` with `x>0` and `0<θ<1`,
  `‖w‖⁻ⁿ ≤ ((1-θ)*x)⁻ⁿ`;
- corresponding upper-power comparisons when the weight grows like `‖w‖ⁿ`;
- a named lemma that converts an original threshold `R₀ ≤ ‖w‖` into the center condition
  `R₀ ≤ (1-θ)x`.

More elaborate weights stay application-local until two independent consumers share the same exact
comparison. Positivity of a real envelope does not make it holomorphic.

### 3.4 Source-sector reconciliation

Every source card using a sector must record:

- whether the source uses a principal argument, an unwrapped argument, or inequalities in real and
  imaginary parts;
- inclusion or exclusion of the origin and boundary rays;
- the axis, opening, orientation, and any parameter dependence;
- the exact theorem mapping the source sector into the proof domain;
- the residual angular/radial margin supporting each Cauchy disk.

An optimized radius may be reduced by a sector boundary. Constant optimization never overrides disk
containment.

## 4. Branch charts and normalization

### 4.1 A small coherent branch object

A branch is one of the few places where a structure packages genuine coherent data. The initial object
should remain small:

```lean
namespace LMLF.ComplexBranch

structure LogBranchOn (U : Set ℂ) (g : ℂ → ℂ) where
  log : ℂ → ℂ
  analyticOnNhd_log : AnalyticOnNhd ℂ log U
  exp_log : Set.EqOn (Complex.exp ∘ log) g U

def LogBranchOn.NormalizedAt
    {U : Set ℂ} {g : ℂ → ℂ} (L : LogBranchOn U g)
    (z₀ ℓ₀ : ℂ) : Prop :=
  z₀ ∈ U ∧ L.log z₀ = ℓ₀

def LogBranchOn.cpow
    {U : Set ℂ} {g : ℂ → ℂ} (L : LogBranchOn U g)
    (alpha z : ℂ) : ℂ :=
  Complex.exp (alpha * L.log z)

end LMLF.ComplexBranch
```

`IsOpen U`, connectedness, nonemptiness, and a base point are theorem hypotheses rather than redundant
stored fields. This lets the same branch data be restricted to smaller sets without rebuilding it.
The first actual constructor should be the principal branch for `g = id` on `Complex.slitPlane`.

The branch-power API should prove, on `U`:

- exponent zero and exponent addition;
- exponent one equals `g` by `exp_log`;
- agreement with integer powers, including the needed nonvanishing consequence of `exp_log`;
- analyticity in `z` for fixed exponent;
- parameter analyticity in the exponent only when the parameter is explicitly complex and the joint
  map is the one being differentiated;
- the derivative formula with every occurrence of `L.log` and `deriv L.log` visible.

Do not register global simp rules that unfold named functions or every branch power into exponentials.

### 4.2 Principal chart reuse

On the pinned Mathlib commit, the following are verified existing APIs:

- `Complex.slitPlane`, `Complex.isOpen_slitPlane`, `Complex.slitPlane_ne_zero`, and
  `Complex.exp_log`;
- root `analyticAt_clog`, `AnalyticOnNhd.clog`, `AnalyticAt.cpow`, and
  `AnalyticOnNhd.cpow` from `Mathlib.Analysis.SpecialFunctions.Complex.Analytic`;
- `Complex.cpow_def_of_ne_zero` from `Mathlib.Analysis.SpecialFunctions.Pow.Complex`;
- `Complex.hasDerivAt_sqrt` and `Complex.differentiableOn_sqrt` for the principal square root.

Therefore the principal `LogBranchOn Complex.slitPlane id` is a thin project constructor, not a new
logarithm. Named definitions should reuse `Complex.log`/`Complex.cpow` on this chart when the convention
matches, and prove a bridge instead of defining a second principal object.

### 4.3 Generic existence is new work

`Complex.exists_continuousOn_eqOn_exp_comp` in
`Mathlib.Analysis.Complex.BranchLogRoot` gives a *continuous* logarithm lift of a continuous nonvanishing
map on an open simply connected set. It does not return `AnalyticOnNhd`. The project must not cite it as
if it directly constructed `LogBranchOn` above.

A later proof dossier may target:

```lean
theorem exists_logBranchOn_of_isSimplyConnected
    (hUo : IsOpen U) (hUc : IsSimplyConnected U)
    (hg : AnalyticOnNhd ℂ g U) (hzero : 0 ∉ g '' U) :
    Nonempty (LogBranchOn U g)
```

The missing mathematical step is to upgrade the continuous lift locally through logarithm charts and
then glue the local analytic descriptions. This is high-risk branch infrastructure and is not required
for the first Cauchy-transport packet, whose examples can remain on the principal chart or use directly
supplied analytic functions.

### 4.4 Uniqueness and changes of chart

For two branches `L₁,L₂` of the same `g`, Mathlib's
`Complex.exp_eq_exp_iff_exists_int` gives a pointwise integer multiple of `2πi` between their values.
Promoting the pointwise integer to one constant integer needs connectedness and continuity.

Candidate theorems are:

1. On a preconnected `U`, if `L₁` and `L₂` agree at one point of `U`, then
   `Set.EqOn L₁.log L₂.log U`.
2. On a nonempty preconnected `U`, there exists `m : ℤ` such that throughout `U`,
   \[
     L_2(z)=L_1(z)+2\pi i m.
   \]
3. On the overlap of two branch charts, their branch powers differ by
   `exp (2 * π * I * m * α)`; for integral `α`, the powers agree.
4. Transition integers satisfy identity, inverse, and cocycle laws on each specified nonempty
   preconnected overlap.

Do not state one transition integer for a disconnected overlap. Either choose a connected component or
carry separate overlap pieces. A normalized chart records its base point and base value in the theorem
card; normalization cannot be reconstructed later from the exponential equation alone.

### 4.5 Continuation policy

Initial continuation is by finite compatible chart chains:

```text
normalized starting chart
  -> nonempty connected overlap + transition integer
  -> next chart
  -> finite cocycle calculation
  -> EqOn/branch-factor theorem on the terminal chart
```

This is sufficient for many connection arguments and remains auditable. A logarithmic-cover coordinate
`z = exp w` is permitted later; its physical derivative is
`∂_z = exp (-w) ∂_w`, with the factor and chart image stated explicitly. Do not build a general
Riemann-surface library until a concrete closed packet requires more than finite charts or a logarithmic
cover.

## 5. Actual extensions and real agreement

### 5.1 Agreement predicate

The proposed scalar relation is intentionally lightweight:

```lean
def AgreesOnReal (I : Set ℝ) (f : ℝ → ℝ) (F : ℂ → ℂ) : Prop :=
  ∀ x ∈ I, F (x : ℂ) = (f x : ℂ)
```

An application names the actual `F`, proves its analytic domain, and proves `AgreesOnReal`. It may not
hide the extension behind `∃ F`. Existing real and complex Mathlib functions remain distinct canonical
objects connected by an agreement theorem; LMLF does not replace them with a duplicate definition.

Reality is also a theorem. Defining `f x = (F x).re` does not prove that `F x` has zero imaginary part.
Conjugation symmetry or a conventional identification theorem must supply that fact when the complex
value itself is claimed to equal a real coercion.

### 5.2 Derivative restriction

The pinned import `Mathlib.Analysis.Complex.RealDeriv` verifies:

- `HasDerivAt.comp_ofReal`: a complex-valued function restricted along `ℝ → ℂ` has the same first
  derivative;
- `HasDerivAt.real_of_complex`: the real part has derivative equal to the real part of the complex
  derivative;
- `HasDerivAt.ofReal_comp`, `ContDiffAt.real_of_complex`, and
  `Differentiable.real_of_complex`.

`Mathlib.Analysis.SpecialFunctions.Complex.Analytic` also provides
`AnalyticOnNhd.re_ofReal` and `.im_ofReal`. These facts should underpin project wrappers; there is no
reason to reproduce first-order real/complex calculus.

The exact project theorem needed downstream is stronger than pointwise agreement. A candidate shape is:

```lean
theorem AgreesOnReal.iteratedDeriv_eq
    (hI : IsOpen I) (hx : x ∈ I) (hagree : AgreesOnReal I f F)
    (hF : AnalyticAt ℂ F (x : ℂ)) (hf : ContDiffAt ℝ k f x) :
    iteratedDeriv k F (x : ℂ) =
      (iteratedDeriv k f x : ℂ)
```

The exact minimal regularity and whether `hf` follows from `hagree`, `hI`, and `hF` must be settled by a
compile spike and proof review. No direct all-orders theorem with this conclusion was found in the local
pin. The proof should proceed from neighborhood agreement and the existing first-order restriction,
then induct; it must not rely on totalized derivatives away from differentiability.

For a closed real target domain `D`, carry an open real neighborhood `I` with `D ⊆ I`. Endpoint results
are ordinary derivatives of the extension on that neighborhood. If the intended statement is one-sided,
use within-derivatives and state it separately.

## 6. Required negative examples and regressions

Each accepted packet retains regressions that reject nearby false designs.

- **Openness is not a quantitative radius.** An open-domain hypothesis alone cannot yield the explicit
  radius required by a derivative estimate.
- **Point agreement is not derivative agreement.** Two analytic functions may agree at one real point
  and have different derivatives there; `AgreesOnReal` must hold on a neighborhood for an ordinary
  derivative bridge.
- **A cut identity is not global.** `Complex.exp_log` requires nonzero input, while analyticity of
  `Complex.log` uses `Complex.slitPlane`; total values on the cut do not extend the branch law.
- **Disconnected overlaps have no single transition integer.** A branch difference can take different
  `2πi` multiples on distinct components.
- **A positive envelope is not an analytic normalization.** Cauchy may be applied to an actual analytic
  remainder or analytic factor, not to division by `‖z‖`, an absolute value, or an arbitrary positive
  weight.
- **Sector replacement needs a bridge.** A proof on `conicSector u κ` does not recover a source theorem
  on a differently normalized angular sector without an explicit inclusion/equivalence.

## 7. Candidate work packets and dossiers

These labels are planning handles, not registered card IDs. Before implementation, the specification
owner must either create frozen cards under these or replace them with bounded IDs in a revised manifest.

| Slice | Proposed declarations | Required predecessors | Required dossier |
|---|---|---|---|
| `QC-DOM` | radial, half-plane, annulus, conic-sector disk lemmas | none beyond pinned Mathlib | exact inequalities, strict-boundary cases, nonempty witnesses |
| `CB-PRINCIPAL` | `LogBranchOn`, principal chart, branch-power laws | pinned log/analytic APIs | expanded principal convention, zero/cut cases, no duplicate log |
| `CB-GENERIC` | analytic branch existence, uniqueness, overlap integers | `CB-PRINCIPAL` or independent local lemmas | full continuation proof and adversarial disconnected-overlap case |
| `QC-REAL` | `AgreesOnReal` and first/all-orders derivative bridges | pinned `RealDeriv` | neighborhood quantifiers, order zero/one checks, endpoint policy |
| `QC-LOGCOORD` | finite chart-chain and `z=exp w` derivative laws | accepted branch uniqueness | chart images, base normalization, cocycles, chain-rule factors |

Every dossier records exact signatures, binder order, imports, proof decomposition, source/notation links
when any source convention is involved, branch and exceptional-value policy, and downstream consumers.
The branch-existence and continuation dossiers must include a proof that no field or hypothesis merely
asserts the desired named continuation. The artifact itself follows the repository's
[proof-artifact schema](../automation/proof_artifact_schema.md), including stable identity,
side-condition, and constant-loss ledgers.

## 8. Review and authorization gates

No slice is Lean-ready until its card and natural-language proof are frozen and externally bound by
digest as required by [the review protocol](../../review/PROTOCOL.md).

- Domain geometry and real restriction need two independent pre-Lean approvals for new mathematics.
- Branch construction, generic continuation, and chart cocycles require the roadmap's additional third
  structural/circularity review. That reviewer checks normalization, uniqueness, chart overlap, and that
  definitions do not depend on later estimates.
- The pinned-source reviewer verifies exact imports and declarations rather than online documentation.
- Implementation review applies `mathlib_reuse`, `api_dependency`, `quantitative_correctness`, and
  `proof_quality`; `source_fidelity` is also required whenever a source or named-family branch convention
  is claimed.
- Filled verdicts and disposition ledgers remain external to the candidate head. Any packet, proof,
  source snapshot, dependency pin, or candidate-head change invalidates the affected approvals.
- Release checks include `lake build`, axiom reports, import-DAG inspection, exact branch/domain
  regressions, and maintained audit consumers. Compilation alone is not approval.

## 9. Pinned Mathlib findings and non-reuse decisions

The local repository and `blueprint/mathlib_audit.md` were checked against the resolved pin, not against
the older Mathlib commit mentioned in the attached version-0.4 blueprint.

| Need | Pinned result | Decision |
|---|---|---|
| open right/left/upper/lower half-planes | `Complex.isOpen_re_gt`, `.isOpen_re_lt`, `.isOpen_im_gt`, `.isOpen_im_lt` | reuse; do not build a half-plane structure |
| principal cut and principal log/power | `Complex.slitPlane`, `analyticAt_clog`, `AnalyticOnNhd.clog`, `.cpow` | reuse and wrap only to record coherent project branch data |
| continuous branch existence | `Complex.exists_continuousOn_eqOn_exp_comp` | reuse as existence input, not as an analytic branch theorem |
| root branch existence | `Complex.exists_continuousOn_pow_eq` | reuse when continuity is sufficient; do not advertise analytic roots from it |
| first-order real restriction | `HasDerivAt.comp_ofReal`, `.real_of_complex`, `.ofReal_comp` | reuse directly |
| all-orders real/complex agreement | no matching ready-made wrapper found | project theorem after an exact signature spike |
| source-oriented sector package | no matching reusable complex-sector API found | small project definitions and bridge lemmas, only when carded |
| general logarithmic cover | no matching project-ready package found | defer beyond finite charts unless a consumer forces it |

## 10. Open research and implementation risks

1. **Analytic lift upgrade (P1):** converting Mathlib's continuous logarithm lift into a globally
   analytic branch needs a careful local-to-global proof.
2. **Overlap components (P1):** chart transition integers are componentwise; APIs that suppress this can
   state false cocycle theorems.
3. **Sector convention (P1):** argument-based source sectors and inequality-based proof sectors may
   differ at the cut, origin, or boundary rays.
4. **All-orders real restriction (P1):** regularity, coercions, and `iteratedDeriv` normal forms must be
   frozen without an accidental pointwise-agreement hypothesis.
5. **Moving branches (P1):** parameter-dependent domains may cross cuts or change normalization even
   when each fixed-parameter slice has a branch.
6. **Import pressure (P2):** `BranchLogRoot` is heavier than the principal-log API; keep it out of the
   base branch file if generic existence is split into a later module.
7. **Premature abstraction (P2):** neither a universal domain language nor a Riemann-surface typeclass is
   justified by current consumers.
8. **Mathlib drift (P1):** branch and analytic declaration namespaces are version-sensitive; every card
   records and rechecks the full resolved commit.

## 11. Exit criteria

The initial domain/branch slice is complete only when:

- the proportional disk and radial boundary lemmas feed a Cauchy wrapper without application-local
  geometric duplication;
- the principal branch is visibly Mathlib's object and its cut, zero policy, and normalization are
  independently audited;
- one real restriction example derives an ordinary real derivative statement from neighborhood
  agreement and complex calculus;
- all branch and domain losses remain explicit in theorem conclusions or hypotheses;
- no source coverage, named continuation, or derivative claim is inferred from a merely conditional
  structure; and
- every implemented slice has passed its independent pre-Lean and exact-head implementation gates.
