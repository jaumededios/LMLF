# Zeros, indexing, and connection matrices

**Document role:** planning blueprint only.  Queue entries are not frozen cards,
the referenced proof dossiers do not yet exist, and no Lean implementation or
source coverage is authorized.

**Programme position:** Track E, downstream of identified named functions and
accepted finite quantitative estimates.  Every zero or connection packet uses
the three-review gate.

This refines the zero/connection portions of the attached *Explicit
Quantitative Olver in Lean* blueprint.  It is subordinate to the current
[roadmap](../roadmap.md), [design decisions](../design_decisions.md),
[source policy](../source_manifest.md), [function
inventory](../function_inventory.md), pinned [Mathlib
audit](../mathlib_audit.md), and [review protocol](../../review/PROTOCOL.md).
The current source inventory is incomplete, so all named source applications
remain blocked on direct collation even when their generic methods are ready.

## 1. Non-negotiable separations

This programme keeps four conclusions distinct:

1. **local zero existence/displacement:** a particular neighborhood contains a
   zero near a comparison zero;
2. **local multiplicity/uniqueness:** that neighborhood contains exactly the
   stated number of zeros, counted with multiplicity;
3. **global indexing:** every relevant zero is captured once, the labels have
   the claimed order, and there are no extra zeros in the stated region;
4. **connection data:** two normalized solution frames are related by an exact
   constant matrix, with an independently identified normalization.

None implies the next automatically.  Disjoint local disks around candidate
zeros do not prove exhaustivity.  A close approximation on an overlap does not
prove an exact Stokes multiplier.  A matrix calculated from two approximate
frames is not the connection matrix of the exact named solutions without
normalization and a limiting or exact Wronskian argument.

All zero theorems quantify one fixed named or characterized function.  If `N`
is an approximation order, the required form is

\[
  \exists F_p\;\mathsf{IdentifiedNormalized}(p,F_p)
  \quad\text{then}\quad
  \forall N\ \forall k\in I_{p,N},\ \cdots F_p\cdots.
\]

An order-dependent `F_{p,N}` is rejected.

## 2. Local zero programme

### 2.1 Real simple-zero displacement

The low-dependency pilot works on a real interval.  Suppose a comparison
function `a` has `a(alpha)=0`, its derivative has fixed sign and
`|a'| >= m > 0` on `[alpha-r,alpha+r]`, and
`|F-a| <= epsilon < m*r` there, with `F` continuous on that interval.
Endpoint signs at `alpha +/- epsilon/m` yield at least one zero of `F` within
distance `epsilon/m` (with the exact closed/open endpoint convention proved).
Uniqueness requires additional information about `F`, such as a one-sided
derivative bound or strict monotonicity; it does not follow from a value error
alone.

A stronger jet hypothesis

\[
  |F-a|\le\varepsilon_0,
  \qquad |F'-a'|\le\varepsilon_1<m

\]

gives monotonicity of `F`, a unique simple zero, and an explicit derivative
lower bound at that zero.  The theorem should export the natural
`epsilon_0/(m-epsilon_1)`-style estimate only if that is what the exact endpoint
argument derives; constants are not guessed in the blueprint.

### 2.2 Complex local zero counting

The natural complex route is Rouché's theorem.  On the boundary of a closed
disk or Jordan domain,

\[
  |F-A|<|A|

\]

implies equal zero counts inside, with multiplicity, provided both functions are
holomorphic on a neighborhood of the closure and the contour/counting theorem
is available.  To isolate exactly one zero near a simple comparison zero, the
card must additionally prove:

- the comparison function has exactly one zero in the disk;
- it has no boundary zero and an explicit positive boundary lower bound;
- the approximation bound is strict on that boundary;
- the disk lies in the common holomorphy and branch domain.

The pinned Mathlib availability of a directly usable Rouché/argument-principle
API must be audited before freezing this route.  If missing, the initial real
programme should proceed independently; a new complex zero-counting foundation
is a substantial packet, not a local helper hidden in a named theorem.

### 2.3 Families of local disks

For candidate zeros `alpha_k`, use explicit radii `r_k` and prove

\[
  \overline D(\alpha_j,r_j)\cap
  \overline D(\alpha_k,r_k)=\varnothing\quad(j\ne k).
\]

Each disk theorem then gives an injective local labeling `z_k`.  It still gives
no surjectivity onto all zeros.  Uniform statements must show every boundary
margin and residual bound is uniform in the expanded parameter and index range;
an existential radius depending opaquely on `k` does not yield a quantitative
zero asymptotic.

## 3. Global indexing programme

Global indexing requires an independent mechanism chosen for the geometry.

### 3.1 Real ODE route

For real zeros of real solutions, possible ingredients are Sturm separation and
comparison, phase monotonicity, sign alternation at explicit brackets, and an
anchor identifying the first index.  The packet must prove:

- the solution is real on the interval and nontrivial;
- all indexed zeros are simple (or give the exact multiplicity convention);
- labels are strictly ordered;
- every interval between successive comparison landmarks contains the claimed
  zero count;
- the finite initial range is reconciled with the asymptotic tail;
- there are no additional zeros before, between, or after the covered ranges.

An asymptotic formula as `k -> infinity` does not determine whether the first
captured zero is numbered `k`, `k+1`, or another shift.

### 3.2 Complex contour route

For complex sectors, global indexing may combine disjoint local disks with a
large-contour argument-principle count and explicit exclusion regions.  The
large contour must avoid cuts, poles, and boundary zeros, and every connecting
arc needs an explicit lower bound.  Letting the contour radius tend to infinity
requires a uniform tail argument; it cannot be replaced by “all sufficiently
large zeros are near the approximants” unless exhaustivity is already in the
hypotheses.

### 3.3 Index objects and public API

The first public representation should be modest:

- a zero sequence on the exact index set actually proved;
- membership, vanishing, simplicity/multiplicity, and strict-order lemmas;
- a local displacement bound;
- a separate exhaustion theorem.

Do not create a global `ZeroEnumeration` structure that contains exhaustion,
simplicity, and the target asymptotic as fields.  Such a record merely launders
the hard theorems.  Choice may define `z_k` only after existence and uniqueness
in its local region, and a public `mem_disk` plus uniqueness characterization
must eliminate dependence on the choice.

## 4. Connection frames and exact matrices

### 4.1 Fundamental frames

On a connected overlap domain, let

\[
  \mathcal F_\alpha(z)=
  \begin{pmatrix}
    y_{\alpha,1}(z)&y_{\alpha,2}(z)\\
    y'_{\alpha,1}(z)&y'_{\alpha,2}(z)
  \end{pmatrix}

\]

be a frame for one common first-order system, with its determinant identified
as the correctly oriented Wronskian and proved nonzero.  Freeze the convention

\[
  \mathcal F_\beta=\mathcal F_\alpha C_{\alpha\beta},
  \qquad
  C_{\alpha\beta}=\mathcal F_\alpha^{-1}\mathcal F_\beta.
\]

Column order, derivative variable, and whether the derivative is scaled are
part of the definition.  If scaled jets vary by chart, insert the exact change
of-scale matrix before calling two frames comparable.

The first constancy proof can define `C` at an anchor and use IVP uniqueness to
show `F_alpha*C=F_beta` on the overlap.  This avoids differentiating a matrix
inverse.  A later holomorphic derivative proof may be useful for local
constancy, but still needs connectedness to obtain one global constant.

### 4.2 Algebra of connections

With the convention above, prove exactly

\[
 C_{\alpha\alpha}=I,\qquad
 C_{\beta\alpha}=C_{\alpha\beta}^{-1},\qquad
 C_{\alpha\gamma}=C_{\alpha\beta}C_{\beta\gamma}.
\]

If the frame normalization changes by
`\widetilde{\mathcal F}_\alpha=\mathcal F_\alpha N_\alpha`, then

\[
  \widetilde C_{\alpha\beta}
    =N_\alpha^{-1}C_{\alpha\beta}N_\beta.
\]

These orientation regressions must be evaluated on noncommuting symbolic or
concrete matrices; diagonal examples do not detect reversed multiplication.

### 4.3 Scalar coefficients from Wronskians

For `y=a*u+b*v` and
`W(u,v)=u v'-u'v != 0`, the exact coefficients are

\[
  a=\frac{W(y,v)}{W(u,v)},\qquad
  b=\frac{W(u,y)}{W(u,v)}.
\]

This is often the cleanest bridge from normalized named solutions to a
connection matrix.  It requires exact Wronskians and nonvanishing, not only
asymptotic estimates.  Fractions are stated only on the nonzero domain; Lean's
totalized inverse is not evidence.

### 4.4 Sectorial and Stokes connections

Canonical sectorial solutions normalized at infinity must first be constructed
and shown unique in exact growth classes.  On sector overlaps, exact uniqueness
produces connection coefficients.  Their numerical identification may use:

- exact rotated-function formulas;
- evaluation of initial data at a regular anchor;
- exact Wronskians;
- a justified limiting formula where the remainder tends to zero.

A finite `O(u^-m)`-style or explicit small bound at one parameter value cannot
be rounded to an exact coefficient.  If a limit is used, its convergence,
nonzero denominators, sector, order of limits, and uniformity in other
parameters are separate obligations.

## 5. Quantitative connection stability

Sometimes the goal is not the exact connection matrix but a bound comparing it
with an approximant.  If `F=F0+Delta` and
`||F0^-1 Delta|| <= eta < 1`, the inverse perturbation/Neumann estimate gives an
explicit bound for `F^-1` and hence for
`C=F_alpha^-1 F_beta`.  The natural theorem should retain the condition number,
scale matrices, and `(1-eta)^-1` factors before any simplification.

This theorem is downstream of exact matrix orientation and scaled-frame
definitions.  It does not identify an exact Stokes multiplier.  Near zeros,
frame bounds or scaled jets are mandatory; entrywise relative errors can be
meaningless.

## 6. Proposed module seams

```text
LMLF.Quantitative.Basic
  + LMLF.ODE.NormalizedSolution
  + accepted named definition/identification
  + accepted value/jet estimate
      -> LMLF.Zeros.RealLocal
      -> LMLF.Zeros.ComplexLocal
      -> LMLF.Zeros.Indexing

LMLF.ODE.PathSystem + normalized named frames
      -> LMLF.Connections.Frame
      -> LMLF.Connections.Matrix
      -> LMLF.Connections.Wronskian
      -> LMLF.Connections.Sectorial
      -> LMLF.Connections.Stability

Zeros.Indexing + Connections.* -> named/source applications -> Audit.*
```

Generic local-zero results do not import Airy/Bessel modules.  Named zero
applications do.  Connection algebra does not import zero indexing.  A later
source theorem may consume both, but neither foundational direction is reversed.

## 7. Theorem-card queue, proof dossiers, and three-review gate

Every row below is new mathematics or high-risk zero/connection work.  Its
future frozen theorem card and complete NLP both require **three independent
approvals**: source/named-semantics (or explicit infrastructure classification),
proof/quantitative correctness, and structural/circularity.  Reviewer IDs are
distinct, reports are blind/fresh, and any material change invalidates all
approvals under the repository protocol.

| Queue ID | Genuinely new result and bounded scope | NLP dossier | Gate | Depends on | Acceptance IDs |
|---|---|---|---:|---|---|
| ZERO-001 | Real existence/displacement near one simple comparison zero from value error and derivative lower bound; no uniqueness | `blueprint/proofs/ZERO-001.md` | 3 | QB-001 + real calculus | ZC-T01–T05 |
| ZERO-002 | Unique simple real zero from a scaled-jet error and strict derivative margin | `blueprint/proofs/ZERO-002.md` | 3 | ZERO-001 + derivative estimate | ZC-T06–T10 |
| ZERO-003 | Complex Rouché/counting foundation on one explicit disk/Jordan class | `blueprint/proofs/ZERO-003.md` | 3 | pinned complex-analysis audit | ZC-T11–T16 |
| ZERO-004 | One-zero complex localization around a simple comparison zero with explicit boundary margin | `blueprint/proofs/ZERO-004.md` | 3 | ZERO-003 + named/identified comparison function | ZC-T17–T22 |
| ZERO-005 | Disjoint local-disk family and injective zero labeling with public choice-independent characterization | `blueprint/proofs/ZERO-005.md` | 3 | ZERO-002 or ZERO-004 | ZC-T23–T27 |
| ZERO-006 | Real global indexing/exhaustion using one frozen Sturm/phase/bracketing route | `blueprint/proofs/ZERO-006.md` | 3 | ZERO-005 + real ODE theory | ZC-T28–T34 |
| ZERO-007 | Complex global count/exhaustion on one sector using explicit contours and exclusion regions | `blueprint/proofs/ZERO-007.md` | 3 | ZERO-003 + ZERO-005 | ZC-T35–T41 |
| ZERO-008 | Named zero asymptotic/displacement theorem for one fixed identified solution and one exact index convention | `blueprint/proofs/ZERO-008.md` | 3 | ZERO-005 + ZERO-006/007 + accepted finite estimate | ZC-T42–T47 |
| CONN-001 | Fundamental-frame predicate, exact Wronskian/determinant orientation, and anchor-defined constant connection matrix | `blueprint/proofs/CONN-001.md` | 3 | ODE-003/007 + matrix audit | ZC-T48–T53 |
| CONN-002 | Identity, inverse, cocycle, and normalization-change laws for connection matrices | `blueprint/proofs/CONN-002.md` | 3 | CONN-001 | ZC-T54–T58 |
| CONN-003 | Exact scalar connection coefficients from Wronskian quotients | `blueprint/proofs/CONN-003.md` | 3 | CONN-001 | ZC-T59–T63 |
| CONN-004 | Sectorially normalized fixed solutions and exact overlap connections in one explicit sector cover | `blueprint/proofs/CONN-004.md` | 3 | ODE-008/009 + CONN-001 | ZC-T64–T70 |
| CONN-005 | Identification of one named Airy/Bessel/Hankel connection matrix from exact rotations, anchor data, Wronskians, or justified limits | `blueprint/proofs/CONN-005.md` | 3 | CONN-003/004 + named definitions | ZC-T71–T77 |
| CONN-006 | Quantitative scaled-frame perturbation bound for an approximate connection matrix | `blueprint/proofs/CONN-006.md` | 3 | ODE-010/011 + CONN-002 | ZC-T78–T83 |

ZERO-003 should be split further if Mathlib lacks the needed argument-principle
foundation; one card may not silently contain contour integration, multiplicity
theory, winding numbers, and Rouché plus a named application.

Implementation review applies all applicable repository rubrics to the exact
candidate head and requires the packet's overall distinct-reviewer quorum.
Source fidelity is mandatory for every named zero, normalization, sector,
connection, or source-indexing claim.  Filled review records remain external;
changing a card, dossier, source snapshot, pin, or candidate commit invalidates
the affected approvals.

## 8. Dependency DAG

```text
QB-001 + real calculus ----------------> ZERO-001 ---> ZERO-002
complex-analysis audit ----------------> ZERO-003 ---> ZERO-004
ZERO-002 or ZERO-004 ------------------> ZERO-005
ZERO-005 + real ODE/phase --------------> ZERO-006 --+
ZERO-003 + ZERO-005 + contour bounds ---> ZERO-007 --+--> ZERO-008
accepted fixed named solution + finite estimate ------------------^

ODE-003/007 + matrix audit ------------> CONN-001 ---> CONN-002 ---> CONN-006
                                           |             ^             ^
                                           +-> CONN-003   |             |
ODE-008/009 + CONN-001 -------------------> CONN-004 ----+             |
CONN-003/004 + named identifications -----> CONN-005                   |
ODE-010/011 + accepted frame estimates --------------------------------+
```

ZERO-008 depends on an exhaustion route, not merely local labeling.  CONN-005
depends on exact named identifications and cannot be used to construct those
same named objects.

## 9. Acceptance tests and negative regressions

| ID | Required check |
|---|---|
| ZC-T01 | Exact comparison `F=A` returns the comparison zero with zero displacement. |
| ZC-T02 | The endpoint sign calculation uses `epsilon < m*r` with the exact strictness needed by IVT. |
| ZC-T03 | Radius and slope constants are positive and denominators are proved nonzero. |
| ZC-T04 | A value-close oscillatory perturbation demonstrates that existence does not imply uniqueness. |
| ZC-T05 | The real interval lies in the validity domain and is nonempty. |
| ZC-T06 | `epsilon_1 < m` produces the exact positive derivative margin. |
| ZC-T07 | The unique root is simple and its derivative lower bound is exported. |
| ZC-T08 | The displacement constant is re-derived from the actual endpoint/mean-value argument. |
| ZC-T09 | A boundary equality case is either proved or deliberately excluded. |
| ZC-T10 | Value and derivative estimates concern the same fixed `F`. |
| ZC-T11 | Holomorphy holds on a neighborhood of the closed contour, not just its interior. |
| ZC-T12 | Boundary orientation and interior convention are explicit. |
| ZC-T13 | Zero multiplicities are counted; poles are either absent or separately included by a meromorphic theorem. |
| ZC-T14 | Strict boundary inequality is not weakened to a non-strict one without an additional theorem. |
| ZC-T15 | A boundary zero is rejected. |
| ZC-T16 | The disk/Jordan domain is contained in the branch domain. |
| ZC-T17 | The comparison zero is proved unique in the disk, not assumed from its center label. |
| ZC-T18 | An explicit positive lower bound for `|A|` is proved on the boundary. |
| ZC-T19 | The error bound is strictly smaller than that lower bound. |
| ZC-T20 | The conclusion counts exactly one zero with multiplicity. |
| ZC-T21 | Simplicity is deduced explicitly from total multiplicity one, not from spatial uniqueness alone. |
| ZC-T22 | A zero-safe absolute/frame envelope is used; no division by the comparison function occurs at its zero. |
| ZC-T23 | Closed disks for distinct labels are disjoint with an explicit spacing inequality. |
| ZC-T24 | Choice of the local zero follows existence and uniqueness. |
| ZC-T25 | The chosen zero has public membership, vanishing, and uniqueness characterizations. |
| ZC-T26 | The labeling is injective; no exhaustivity claim appears yet. |
| ZC-T27 | Parameter/index uniformity is expanded and every radius dependence is visible. |
| ZC-T28 | The named solution is real and nontrivial on the indexing interval. |
| ZC-T29 | Simplicity or exact multiplicity of all indexed zeros is proved. |
| ZC-T30 | Consecutive labels are strictly ordered. |
| ZC-T31 | Initial finite indices are anchored directly. |
| ZC-T32 | Every gap between landmarks has the claimed zero count. |
| ZC-T33 | No zeros exist outside the union of the finite anchor and asymptotic tail regions. |
| ZC-T34 | The index shift is regression-tested at the first two labels. |
| ZC-T35 | The large contour avoids every cut, pole, and candidate boundary zero. |
| ZC-T36 | Each contour segment has an explicit comparison lower bound. |
| ZC-T37 | The argument-principle count equals the sum of local multiplicities. |
| ZC-T38 | Exclusion regions cover the complement of local disks in the claimed sector. |
| ZC-T39 | Passage to unbounded radius has uniform tail control. |
| ZC-T40 | Sector boundary inclusion/exclusion is explicit. |
| ZC-T41 | No global claim is inferred solely from infinitely many disjoint local disks. |
| ZC-T42 | The exact zero sequence belongs to one fixed named function independent of truncation order. |
| ZC-T43 | `N=0` and the first two zero labels follow frozen conventions. |
| ZC-T44 | The displacement majorant is nonnegative and finite on the stated index range. |
| ZC-T45 | Every fractional power/logarithm in the approximant has a frozen branch. |
| ZC-T46 | Domain/index range is nonempty and reachable for the named parameter regime. |
| ZC-T47 | Local displacement and global exhaustion appear as separate cited dependencies. |
| ZC-T48 | Frame columns solve the same equation using the same derivative variable. |
| ZC-T49 | Determinant equals the Wronskian with the frozen column/sign convention. |
| ZC-T50 | Nonzero Wronskian proves invertibility on the entire connected overlap. |
| ZC-T51 | Anchor-defined `C` satisfies `F_beta=F_alpha*C` at the anchor. |
| ZC-T52 | IVP uniqueness extends the identity through the exact overlap domain. |
| ZC-T53 | A disconnected overlap does not silently receive one common matrix without component data. |
| ZC-T54 | `C_aa=I` and `C_ba=C_ab^-1`. |
| ZC-T55 | `C_ac=C_ab*C_bc` is checked with noncommuting matrices. |
| ZC-T56 | Reversing the frame convention reverses multiplication and fails the frozen regression. |
| ZC-T57 | Normalization change gives `N_a^-1*C_ab*N_b`. |
| ZC-T58 | Basis permutation and diagonal rescaling examples expose column/order errors. |
| ZC-T59 | `W(y,v)/W(u,v)` recovers the coefficient of `u`. |
| ZC-T60 | `W(u,y)/W(u,v)` recovers the coefficient of `v`. |
| ZC-T61 | Swapping the Wronskian arguments flips the recorded sign. |
| ZC-T62 | Denominator nonvanishing is an explicit hypothesis/theorem. |
| ZC-T63 | Coefficients are constant by the common ODE and normalization, not by pointwise choice. |
| ZC-T64 | Every sectorial solution has a precise endpoint/growth normalization. |
| ZC-T65 | Improper Volterra integrals and limits converge on the exact sector. |
| ZC-T66 | Uniqueness holds in the declared weighted class. |
| ZC-T67 | Progressive paths exist and avoid cuts/singularities. |
| ZC-T68 | Sector overlaps are nonempty with explicit witnesses. |
| ZC-T69 | Connection matrices are constant on each connected overlap. |
| ZC-T70 | Monodromy around excluded singularities is not erased by an unjustified global path-independence claim. |
| ZC-T71 | Named functions are identified before their connection formula is used. |
| ZC-T72 | Rotated arguments include every chain-rule scale in derivative rows. |
| ZC-T73 | Exact anchor values or Wronskians reproduce the claimed coefficients. |
| ZC-T74 | If limits are used, remainder convergence is strong and uniform enough to identify the coefficient exactly. |
| ZC-T75 | Exceptional parameters and vanishing Gamma/trigonometric denominators are handled explicitly. |
| ZC-T76 | Real/complex and branch conventions agree on the overlap. |
| ZC-T77 | A merely small finite error is permanently rejected as evidence of exact connection data. |
| ZC-T78 | The inverse perturbation premise has `eta < 1` and avoids totalized `1/(1-eta)`. |
| ZC-T79 | Scale matrices and condition numbers are explicit. |
| ZC-T80 | Exact frames give zero matrix error. |
| ZC-T81 | Errors from both frames and both inverses appear with correct multiplication order. |
| ZC-T82 | The bound remains meaningful at zeros of individual frame entries. |
| ZC-T83 | The quantitative theorem is not labeled an exact Stokes-multiplier identification. |

## 10. Mathlib reuse checkpoints

Before ZERO-001/002, inspect real IVT, monotonicity, mean-value, derivative, and
root APIs at the pinned revision.  Before ZERO-003, search exact local sources
for Rouché, argument principle, winding number, zero multiplicity, isolated
zeros, contour boundary regularity, and meromorphic counting.  Record exact
declarations and imports; name similarity is insufficient.

A repository-wide source search at the current resolved pin found no declaration
named for Rouché's theorem or the argument principle.  Mathlib does contain
substantial nearby infrastructure—`meromorphicOrderAt`, divisors, logarithmic
zero counting, and Jensen's formula—but this audit has not established that
those APIs yield the disk theorem above without a substantial bridge.  ZERO-003
therefore remains a genuine feasibility/reuse investigation; it must not cite a
ready-made Rouché theorem on the evidence currently available.

Before CONN-001, compare matrix, determinant, inverse, linear-equivalence, and
continuous-linear-map representations.  Reuse an existing Wronskian or linear
ODE uniqueness theorem only after checking derivative convention, commutativity
assumptions, and domain shape.  A local two-by-two helper is preferable to a
large matrix abstraction only if connection applications remain its sole real
consumer.

## 11. Known hard research questions

1. Can pinned Mathlib's divisor, `meromorphicOrderAt`, zero-counting, and Jensen
   infrastructure support a short Rouché/argument-principle bridge, or is a new
   independently reusable complex-zero foundation required?
2. What quantitative boundary lower bounds for Airy/Bessel comparison functions
   are available without circularly invoking the zero theorem being proved?
3. Can local disks be chosen uniformly in parameters while preserving explicit
   constants and branch domains?
4. Which real global-indexing route is shortest and most source-faithful: Sturm
   comparison, Prüfer/phase variables, or direct sign brackets plus exclusion?
5. How can finite initial zeros be anchored without importing a numerical
   evaluator into this exact-analysis project?
6. What contour geometry proves complex exhaustion with tractable lower bounds
   on every arc and Stokes boundary?
7. What representation of zero multiplicity integrates cleanly with chosen
   sequences and named-function exceptional parameters?
8. Should connection frames be matrices over functions, continuous linear
   equivalences, or ordered pairs plus Wronskians?  Which choice minimizes
   normalization and import friction across Airy and Bessel consumers?
9. Can frame constancy on complex domains be proved entirely from pathwise IVP
   uniqueness, including non-star-shaped overlaps, or is analytic continuation
   infrastructure necessary?
10. How should sector covers and their cocycles represent nontrivial monodromy
    without accidentally asserting global single-valuedness?
11. Which exact limits identify Stokes multipliers while retaining uniformity in
    the large parameter and avoiding interchange-of-limit gaps?
12. Can scaled-frame perturbation bounds retain natural constants, or will a
    generic matrix norm introduce unacceptable dimension/conditioning losses?
13. Which zero and connection results are source-equivalent after collation and
    which are genuinely novel quantitative strengthenings requiring separate
    recovery theorems?

## 12. Exit criteria

A named zero release requires identified function semantics, one fixed-solution
quantifier order, local existence and uniqueness/multiplicity, a separate
global exhaustion/index theorem, explicit domain reachability, nonnegative
majorants, branch and exceptional-value regressions, source reconciliation, and
three independent pre-Lean approvals for every new packet.

A named connection release requires identified normalized frames, exact common
ODE and derivative conventions, nonzero Wronskians, a connected overlap, the
frozen matrix orientation and cocycle laws, exact coefficient identification,
all branch/exception cases, and three independent approvals.  Quantitative
matrix closeness alone never satisfies this exit.
