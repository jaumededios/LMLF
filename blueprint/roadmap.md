# LMLF roadmap

**Normative owner:** `jaumededios`  
**Document specification status:** `frozen`  
**Baseline specification commit:** recorded externally after this specification
commit exists; it is not embedded self-referentially in that commit.

## Mission and fixed scope

LMLF is a Lean/mathlib library of exact special-function definitions, finite
approximants, and explicit error bounds.  It should be navigable like the
[DLMF](https://dlmf.nist.gov/), but its first source-coverage programme is the
corrected 1997 reprint of F. W. J. Olver, *Asymptotics and Special Functions*,
ISBN **1-56881-069-5**.  NIST records both the corrected-reprint status and the
ISBN in its [DLMF bibliography](https://dlmf.nist.gov/bib/O) and contemporary
[book notice](https://math.nist.gov/opsf/books/olver.html).

The initial project is exact analysis only.  It does not include floating-point
evaluation, interval arithmetic, adaptive truncation, quadrature, solvers, or
tolerance-driven APIs.

A released quantitative result has the form

\[
  \forall n\;\forall x\in D_n,\qquad
  \lVert F(x)-A_n(x)\rVert\le B_n(x),
\]

with the actual function, finite approximant, order convention, domain,
thresholds, branches, exceptional values, constants, and parameter dependence
all explicit.  Exact expressions involving factorials, exponentials, or finite
sums are final bounds; decimal evaluation is not required.

## Release accounting

Each executable release is governed by a **closed manifest**: a finite list of source
occurrences, generic infrastructure packets, and named applications.  “Related
results” and open-ended chapter claims are forbidden.  Adding an item requires
a manifest revision.

`DEMO-0` is currently a planning queue, not closed or execution-ready, because
most candidate packets do not yet have theorem cards.  The first execution-ready
manifest is `BOOTSTRAP-0`, containing only the fully bounded, frozen QB-001 and
DEF-001 cards.  Manifest readiness does not authorize Lean: each member still
passes its externally recorded review gates.

Three inventories support every closed manifest:

1. **Occurrence inventory:** every scoped theorem, formula, exercise, table
   entry, definition, and normalization check, including repeat occurrences.
2. **Notation inventory:** each symbol at each occurrence, its binder order,
   ambient type, branch, and overload resolution.
3. **Entity inventory:** canonical mathematical objects and aliases, with the
   actual Lean object, conventional specification, and identification theorem.

Coverage is reported against occurrences, not filenames or broad chapter
headings.  See [source_manifest.md](source_manifest.md).

## Proof-before-Lean gate

Packet state is recorded on orthogonal axes, never one overloaded status:
specification, natural-language proof, review, implementation, coverage, and
manifest membership.  The vocabulary is normative in
[`theorem_cards/README.md`](theorem_cards/README.md).  Candidate-owned status
fields are temporal and nonauthoritative.  QB-001 card revision 7 and proof
revision 6 are
currently `specification_status: frozen`, `proof_status: complete`,
`review_status: not_started`, and `implementation_status: not_started`.  Its
revision-3 repository ledger is historical, non-quorum context.  Only an
external envelope bound to the frozen commit and digests may establish review
pass or Lean authorization.

New mathematics includes a new explicit constant or threshold, stronger
uniformity or derivative conclusion, a new continuation or exceptional-value
argument, a new normal form or stability theorem, or any result not directly
recoverable from the locked source or pinned mathlib.

Before Lean work begins on new mathematics, the packet must contain a complete
natural-language proof: quantified statement, dependencies, exact identities,
all analytic side conditions, every constant loss, edge cases, and an
adversarial test.  At least two reviewers independently assess it before seeing
each other's reports:

- a source/semantics reviewer checks occurrence fidelity, notation,
  normalization, branches, exceptional values, and quantifiers;
- a proof/quantitative reviewer re-derives the estimates, constants, domains,
  and edge cases.

Construction, continuation, identification through existence/uniqueness,
nontrivial source recovery, turning-point, zero, connection, and theorem-sized
hypothesis packets also require a separately represented
`structural_circularity_review`.  A thin packet may mark it not applicable only
with a concrete frozen reason.  A substantive edit
to the statement or proof invalidates affected approvals.  No `sorry` skeleton,
axiom, or structure field asserting the desired theorem is a substitute for
this gate.

## Theorem shape and coverage are independent

`theorem_class` describes mathematical shape, such as foundational calculus,
definition identification, finite remainder bound, or qualitative bridge.
`coverage_class` separately says whether the packet is infrastructure, entity
identification, an `exact_source_generic` theorem, a named source application,
or audit-only source recovery.

The frozen machine authority for both packet-level and target-level values is
artifact revision 2 of
[`lmlf-classification-v2`](../review/classifications-v2.json).  It supersedes
immutable v1; coverage roles never appear on the theorem-shape axis.  Its
machine-readable `registry_binding` determines which examples require card
registry rows and which are merely illustrative.

Watson's lemma is generic in its amplitude and parameters.  Its coverage class
is `exact_source_generic`, not `named_source_application`.  Named-function
applications alone must identify a named function, discharge every generic
hypothesis, and prove a nonempty/reachable domain and majorant nonnegativity.
Qualitative filter/Landau recovery remains confined to `Audit/SourceRecovery`.

Hypothesis laundering is rejected: a named result cannot move the difficult
model bound, contour, normalization, or existence theorem into an assumed
record and then claim source coverage.  Choice laundering is likewise rejected:
choice may select an object only after existence and the relevant uniqueness
are proved, and the selected object must have a public characterization.

## Dependency architecture

```text
pinned Lean/mathlib
  |-- low-level branch/domain support
  |     `-- constructions -> definitions -> model properties
  `-- finite quantitative core
        |-- finite sums and coefficient algebra
        |-- complex derivative transport
        |-- integrals and summation
        `-- ODE residuals and stability

identified functions + generic methods
  `-- exact-source generic theorems or named applications -> zeros/connections

finite exact-source theorems and named applications
  `-- Audit/SourceRecovery (qualitative bridges only)
```

The quantitative core never imports named functions.  Definitions may import
minimal exact branch support but not remainder methods.  A construction never
imports an asymptotic theorem that consumes it.  Audits are separately built
consumers, not semantic dependencies.

## Bounded infrastructure demonstrator: M0-M4

M0-M4 test the architecture; they are not the first Olver result and must not
expand into an indefinite foundations project.  `DEMO-0` remains planning-only
until every chosen packet has a complete card; only `BOOTSTRAP-0` may currently
be executed through review.

### M0 — locked contracts and inventories

Deliver:

- the edition lock, planning-only DEMO-0, and execution-ready BOOTSTRAP-0;
- occurrence, notation, and entity inventory schemas;
- theorem-card schema, novelty rubric, and independent-review records;
- pinned Lean/mathlib declaration audit;
- explicit policy for constants, domains, imports, and allowed foundational
  axioms.

Exit: QB-001 and DEF-001 have exact bounded cards owned by `jaumededios`; the
MVP source occurrence is selected for later direct collation.  No other DEMO-0
candidate is implied to be execution-ready.

### M1 — foundational finite calculus

The BOOTSTRAP-0 slice is exactly the eight signatures in
[`QB-001-signatures.md`](theorem_cards/QB-001-signatures.md): `ErrorOn`,
`NormBoundOn`, `HasErrorFamily`, and `ErrorOn.exact`, `.restrict`, `.weaken`,
`.trans`, and `.comp`.  Binder order and the single `LMLF.Basic` import are
frozen there.  Algebra, congruence, finite sums, products, inverses, and family
wrappers require later cards.

`HasErrorFamily` replaces the misleading name `HasFiniteExpansion`: it asserts
a family of finite error bounds and makes no convergence-in-order claim.

Exit: the eight declarations pass their frozen review.  Empty-domain behavior is
intentional because this is generic infrastructure; concrete source and named
cards own reachability requirements.

### M2 — auditable definitions pilot

BOOTSTRAP-0 contains only DEF-001: four thin wrappers around the pinned
mathlib `Complex.Gamma` construction, covering Euler-integral convergence and
identification, real agreement, and the totalization convention at negative
naturals.  It creates no second Gamma object and claims no Olver occurrence.
The exact specification snapshot contains no DEF-001 Lean implementation or
prototype: `implementation_status` is `not_started`, `prototype_status` is
`absent`, and review is `not_started`.  Bytes in another commit or dirty
worktree have no standing until an external review envelope binds them.

Airy construction and broader definition sheets remain DEMO-0 planning items
until independently carded.  Exit: DEF-001 passes reuse, semantic, and API
review without importing downstream asymptotics.

### M3 — complex derivative transport

Deliver:

- explicit half-plane/sector/disk containment and boundary norm comparisons;
- real/complex agreement and derivative-restriction wrappers;
- a wrapper around mathlib's quantitative Cauchy estimate;
- proportional-radius and fixed-radius corollaries;
- exact regression results comparing the natural factor
  `11 * (11 / 10)^10 < 29` with the weaker half-radius factor `2048`;
- the counterexample showing that a real-axis remainder bound plus entire
  extension does not control derivatives at the same scale.

Exit: one generic complex bound yields a real derivative estimate with all
radius, threshold, and domain losses visible.

M3 is a parallel architecture demonstrator and is not on the Watson critical
path.  It cannot delay the first source MVP.

### M4 — finite integral core demonstrator

Deliver:

- exact exponential moments and finite polynomial integration;
- an explicit cutoff/tail identity with integrability hypotheses;
- a generic finite Laplace remainder identity and bound;
- a divergent factorial example proving valid finite bounds without implying
  convergence in order;
- Gamma facts from DEF-001 only if the selected moment proof actually uses them.

Exit: the finite integral packets have their own closed cards before execution.
No Airy, Cauchy, ODE, comparison hierarchy, or custom tactic is a dependency.

## First true quantitative-Olver MVP: M5

M5 formalizes exactly one locked source occurrence:

> **OLV97-C03-WATSON:** Watson's lemma as printed in Olver (1997), Chapter 3,
> pp. 71-72, whose location is independently corroborated by
> [DLMF 2.3(ii)](https://dlmf.nist.gov/2.3.ii).

M0 must transcribe its exact hypotheses, notation, conclusion, and surrounding
normalization from the locked copy; DLMF is a cross-reference, not a substitute
for that collation.  M5 then delivers:

- a generic conditional finite Laplace-remainder identity and explicit bound;
- an `exact_source_generic` quantitative theorem matching the collated generic
  Watson hypotheses and discharging the finite-core obligations;
- a source-recovery theorem, confined to `Audit/SourceRecovery`, proving the
  exact printed Watson conclusion from the finite bound;
- a reconciliation record for the single manifest occurrence.

Watson is not a named-function application.  Only completion of this exact
source-generic packet is the first quantitative-Olver MVP.

The critical path is deliberately short, with collation and QB-001 proceeding
as parallel predecessors:

```text
locked 1997 collation -----\
                            +-> selected QL-001 -> OLV-001 -> SR-001
QB-001 finite core --------/
DEF-001 / Gamma facts - - -> QL-001 or OLV-001
                           only if the collated formulation uses Gamma moments
```

Airy, Cauchy derivative transport, residual algebra, ODE stability, and
comparison systems are parallel work and are explicitly not prerequisites.

## Multi-year programme after the MVP

The following are parallel tracks, not one giant sequential milestone.

### Track A — definitions and entity identification (Years 1-3)

Proceed by closed family waves: Gamma/incomplete Gamma; exponential, error, and
Fresnel functions; Bessel/Hankel; hypergeometric and parabolic-cylinder;
additional Legendre/Whittaker families only when selected source occurrences
need them.  Each wave supplies conventional formulas, convergence or
integrability, continuation, exceptional values, uniqueness, real agreement,
and independent normalization audits.

### Track B — integral and summation methods (Years 1-2)

Develop exact tails, local/global Laplace bounds, oscillatory integration by
parts, stationary/saddle methods, contour estimates, summation by parts,
Euler-Maclaurin, and coefficient transfer.  Every method first lands as generic
conditional infrastructure, then earns coverage through an exact-source generic
card or a named application, according to the collated occurrence.

### Track C — ODE and comparison systems (Years 1-4)

Develop exact Liouville transformations, residual identities, contraction and
Volterra stability, normalized fixed solutions, progressive-path construction,
regular/irregular singularities, and Airy/pole comparison systems.  A small
residual never substitutes for stability and normalization.

### Track D — parameter transitions and derivatives (Years 2-4)

Add explicit turning-point and pole-transition regions, zero-safe envelopes,
scaled state bounds, parameter holomorphy, mixed derivatives, and later
logarithmic-cover support.  Spatial and parameter derivatives remain distinct.

### Track E — zeros, connections, and coverage releases (Years 3+)

Separate local zero displacement from global indexing.  Prove exact connection
matrices, normalization changes, cocycles, and scale-sensitive bounds.  Release
source coverage in finite closed batches, each with a complete reconciliation
report.

## Tactics

Implementation is theorem-driven.  Add `bound_calc` only after three stable
manual consumers, `cauchy_bound` only after several explicit-radius proofs, and
`residual_nf` only after two distinct ODE families share the same exact
normalization pattern.  Tactics apply proved rules and expose remaining side
conditions; they do not invent constants, branches, admissibility, or model
bounds.

## Acceptance and audits

Every named estimate must ship with:

- its definition identification theorem;
- domain-reachability and nonemptiness witness;
- majorant nonnegativity on the domain;
- all generic hypotheses discharged without laundering;
- exact constant/domain regression cases;
- a source occurrence and notation reconciliation;
- independent proof-review records.

Repository audits should reject unfinished public declarations, custom axioms,
backward imports, duplicate named functions, unidentified aliases, open release
manifests, and source-coverage claims backed only by generic conditional
theorems.  Compile cost, import cost, readability, reuse, constant quality, and
version robustness are tracked separately.

Only the CSV inventory validator is implemented at present; it consumes v2
packet classification enums and derives required registry rows from
`registry_binding`; CI runs its positive and negative suites.  Broader
YAML/Markdown lifecycle, target-level classification, digest,
and external-review contract checks remain manual/planned; passing inventory
checks cannot establish any review or authorization gate.

## Risk register

| Risk | Priority | Required control |
|---|---:|---|
| Scope silently expands from Olver to “all DLMF” | P1 | edition lock, occurrence counts, and closed release manifests |
| A generic implication is advertised as a source theorem | P0 | separate theorem/coverage classes and exact-source reconciliation gate |
| A desired bound is moved into a hypothesis or chosen object | P0 | hypothesis/choice-laundering review and named discharge ledger |
| Wrong normalization, branch, argument order, or exceptional value | P0 | entity identification plus independent expanded definition audits |
| A named estimate is vacuous or has a negative majorant | P0 | reachable/nonempty-domain and majorant-nonnegativity declarations |
| Different solutions are constructed for different orders | P0 | fixed normalization, uniqueness, and all-orders compatibility theorem |
| Real-axis bounds are differentiated without neighborhood control | P0 | explicit disk geometry and a permanent negative regression example |
| Totalized inverse or integral hides an invalid classical formula | P0 | explicit nonvanishing/integrability hypotheses and exceptional-value tests |
| Constants or domains degrade during refactoring | P1 | exact constant, threshold, and domain regression theorems |
| Definitions depend circularly on later asymptotics | P0 | import DAG and declaration-dependency audits |
| Premature typeclasses or tactics harden the wrong abstraction | P2 | multiple-consumer threshold and theorem-first implementation |
| Mathlib drift breaks bridges or causes duplicate constructions | P1 | pinned-source audit and per-family reuse review |
| Independent review becomes nominal | P0 | frozen artifact digests, blind reports, distinct reviewers, invalidation on change |
| M0-M4 become an endless foundations programme | P1 | two-packet BOOTSTRAP-0, planning-only DEMO-0, and M5 source-MVP exit criterion |
