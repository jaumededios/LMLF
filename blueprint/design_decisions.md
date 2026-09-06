# LMLF design decisions

> **Proposed successor-authority notice (pending).** The user-authorized broad
> DLMF-through-Chapter-10 boundary is specified by proposed
> [`blueprint/stage_1_dlmf-R5.md`](stage_1_dlmf-R5.md), DD-021 revision 4.
> Its exact six-file successor, enumerated there by repo-relative path, takes
> effect only after two fresh independent blueprint approvals and a root
> external adjudication bind the exact successor commit and digests. Until then,
> the frozen text below remains operative. Once effective, DD-021 changes only
> the bounded DLMF programme scope/nomenclature/priority and semantic-versus-
> source-recovery placement subjects defined there. Legacy release stages are
> Olver-track-local; frozen source mathematics, IDs, proof gates, evidence, and
> coverage semantics remain unchanged, and `OLV-MVP-1` remains a parallel
> Olver-track packet, not a DLMF prerequisite or target.

**Normative owner:** `jaumededios`  
**Document specification status:** `frozen`  
**Baseline specification commit:** recorded in an external review/release record
after the specification commit exists, never self-referentially in that commit.

These decisions are frozen until amended by a reviewed replacement entry.

## DD-001 — Source edition

The initial source programme is F. W. J. Olver, *Asymptotics and Special
Functions*, corrected 1997 A K Peters reprint, ISBN **1-56881-069-5**.  See the
[DLMF bibliography](https://dlmf.nist.gov/bib/O) and the
[NIST reprint notice](https://math.nist.gov/opsf/books/olver.html).  Page and
equation references are checked against this edition, not silently transferred
from the 1974 printing.

## DD-002 — Closed coverage

Every executable release has a closed manifest and occurrence, notation, and
entity inventories where source coverage is involved.  Coverage is counted by
reconciled occurrences.  New entries require a manifest revision; “and related
results” is not a scope declaration.  A bounded planning queue is not closed or
execution-ready merely because its candidate rows have been listed.

## DD-003 — Finite quantitative API

Public mathematical results use finite identities and explicit inequalities on
ordinary sets.  No unnamed constants, unspecified thresholds, or filter/Landau
statement may replace a required bound.

Qualitative source-recovery bridges are allowed only in
`Audit/SourceRecovery`.  That audit module is built but not imported by the
semantic public root.

## DD-004 — `HasErrorFamily`

The family contract is named `HasErrorFamily`, not `HasFiniteExpansion`:

```text
forall n, ErrorOn (D n) f (a n) (b n)
```

It asserts finite bounds for one fixed target and does not suggest that the
approximants converge as the order increases.

## DD-005 — New mathematics is reviewed before Lean

Genuinely new mathematics receives a complete natural-language proof and at
least two independent external reviews before Lean implementation begins.
Construction, continuation, identification through existence/uniqueness,
nontrivial source recovery, and theorem-sized hypothesis structures require a
separately represented `structural_circularity_review`.  Every packet marks it
required or supplies a reviewable inapplicability reason.  Kernel checking does
not replace mathematical review.

## DD-006 — Theorem class is not coverage class

`theorem_class` records mathematical shape; `coverage_class` independently
records `infrastructure`, `entity_identification`, `exact_source_generic`,
`named_source_application`, or `audit_source_recovery`.

A generic conditional infrastructure theorem may assume visible analytic data
and earns no source coverage.  A generic theorem matching a collated source
occurrence, such as Watson's lemma, uses `exact_source_generic`; it is not
misclassified as a named-function application.  A named source application
identifies the actual named function and discharges all generic hypotheses.

Named estimates additionally prove:

- the stated domain is nonempty or is reached from the printed source
  hypotheses in the intended parameter regime;
- the displayed majorant is nonnegative on that domain.

## DD-007 — No hypothesis or choice laundering

A structure field asserting the missing contour, model bound, normalization,
or target estimate cannot be used to claim named source coverage.  It remains
an honest conditional theorem until a named instance proves the field.

Choice may be used only after existence and the relevant uniqueness are proved.
The chosen function or path must have a public characterization.  A choice of
“some object with the desired estimate” is not an implementation of the
estimate.

## DD-008 — One identified object per named function

Reuse mathlib objects where their semantics match.  Otherwise separate actual
construction, conventional specification, and proved identification.  An ODE
without enough normalization data is not an identification theorem.  Named
function definitions never depend on their later asymptotic estimates.

## DD-009 — Domains, branches, and totalization

Branches, cuts, integral orientations, exceptional parameters, and real/complex
agreement are public facts.  Lean's totalized division and integral definitions
do not extend classical formulas through poles, cuts, or nonintegrable inputs.

## DD-010 — Preserve natural constants

Export the natural bound before a simpler corollary.  Exact cancellations and
residual identities precede norms.  Constant and domain losses receive
regression theorems; a smaller constant on a substantially smaller domain is not
automatically an improvement.

## DD-011 — Bounded demonstrator, then source MVP

M0-M4 are a bounded infrastructure demonstrator and do not count as Olver
coverage.  DEMO-0 is planning-only until every selected candidate has a complete
card.  BOOTSTRAP-0 is the initial execution-ready manifest and contains only the
fully specified QB-001 and DEF-001 cards.

The first true MVP is the `exact_source_generic` Watson theorem recovering the
exact Olver occurrence on pp. 71-72; it is not a named-function application.
Its qualitative source bridge remains in `Audit/SourceRecovery`.

## DD-012 — One package, no numerical layer

The project begins as one Lean package.  Numerical evaluators, interval
certificates, floating point, tolerance routing, quadrature, and solvers are
separate future projects and impose no present interfaces.

## DD-013 — Abstractions and tactics follow evidence

Ordinary functions and small predicates are preferred to a universal special-
function or asymptotic typeclass.  A comparison structure requires multiple
substantial consumers.  Custom tactics are added only after repeated manual
proof patterns stabilize.

## DD-014 — Multi-year work is split into tracks

Definitions, integral/summation methods, ODE/comparison methods, transitions,
and zeros/connections progress as separately gated tracks.  A blocked family
does not stop generic work, but it blocks every named theorem about that family.

## DD-015 — Status axes are orthogonal

Specification, proof, review, implementation, coverage, and manifest membership
use separate controlled vocabularies from `theorem_cards/README.md`.
Candidate-owned review and implementation fields are temporal descriptions,
not gate evidence.  QB-001 card revision 7 and proof revision 6 are frozen and
complete as applicable, while their self-fields retain the pre-authorization
state.  Its revision-3 repository review summary is historical and non-quorum.
DEF-001 revision 4 likewise remains frozen with
`implementation_status: not_started` and `prototype_status: absent` for the
exact specification snapshot.  Manifest execution readiness never implies Lean
authorization; separate external records later authorized and accepted the
exact BOOTSTRAP-0 implementation at
`515b742f7ad5472c17cfdf0fda7cbc83c5585da1` without rewriting either card.

## DD-016 — Packet concepts are not source entities

Local API devices such as `ErrorOn` and `HasErrorFamily` are listed as
`packet_local_concepts`.  They are not placed in the Olver source entity
inventory unless a collated occurrence genuinely denotes that entity.  Source
entity, notation, and occurrence IDs remain reserved for source reconciliation.

## DD-017 — Watson has a narrow critical path

The edition/occurrence collation and the selected finite integral/Laplace
infrastructure are independent, parallel predecessors of the source adapter.
For the revision-4 Watson programme the mathematical path is
`IMP-001 -> QL-001 -> OLV-001 -> SR-001`; the real Gamma-moment identity is a
direct pinned-Mathlib reuse inside QL-001.  The accepted QB-001 and DEF-001
bootstrap declarations are optional packaging and audit joins, not Watson
dependencies.  Airy, Cauchy derivative transport, exact ODE residuals, and
ODE/comparison systems are parallel tracks, not blockers.

## DD-018 — Classification and review authority are versioned

Current artifact revision 3 of `review/classifications-v3.json` separately controls packet-level and
declaration-level theorem, coverage, and novelty values. Every newly frozen card
and packet carries exact target classifications. Historical frozen artifacts
retain their recorded v2 authority. `non_novel` is canonical for
routine internal definitions and consequences; `source_equivalent` requires a
bound external source target or pinned-library statement.

Version 3 supersedes without mutating the immutable v2 file. Its machine-readable
`registry_binding` distinguishes required registry examples from illustrative
ones.  Packet theorem classes are mathematical shapes such as
`exact_identity`, `finite_remainder_bound`, `qualitative_support`,
`qualitative_bridge`, and `audit_regression`; `mixed` records packets whose
principal targets span more than one shape.
packet coverage classes carry roles such as `exact_source_generic`,
`named_source_application`, and `audit_source_recovery`.

Version 3 corrects QL-001 and its two classical targets from `novel` to
`non_novel`. That versioned disposition is classification metadata only; it
does not approve the current R4 card/proof, signatures, or implementation.

Passing review, `lean_ready`, and authorization exist only in an external
envelope that binds the frozen specification commit and artifact digests.
Candidate-owned ledgers are historical and count as zero reviewers.  Only the
CSV inventory validator is implemented today; broader schema/lifecycle and
review-contract validation remains manual/planned.

## DD-019 — Consumer-complete finite-exception integration surface

The primary architecture decision for the next unregistered `IMP-001` draft is
an eight-target public surface justified by completion of the `QL-001` and
`OLV-001` consumer chain, not by a hard packet-size or classification-schema
cap. `Basic` owns T01/T05/T08/T02/T03/T04, `Bochner` owns T07, and `Abel` owns
T06. T01 retains independent one-sided endpoint semantics because that is the
collated ordinary source meaning and forbids principal-value cancellation. T08 exposes the
public equivalence between T01 and existence of a normalized continuous
finite-exceptional primitive tending to the same value; T07 bridges absolute
Bochner integrability to T01 for an arbitrary finite exceptional set. Together
those two bridges let the source adapter, Gamma models, and bounded-primitive
tail use one relation without totalizing conditional integrals.

T08 owns all endpoint stitching and the equivalence between component limits
and a convergent normalized primitive. T06 owns only a private finite-piece
Bochner-Fubini identity; it constructs the transformed primitive `G` and invokes
the reverse direction of T08, rather than duplicating sorted endpoint recursion.
No consumer needs the finite-piece representation as public API. The flat
primitive norm bound remains visible data owned by `QL-001`
and derived by `OLV-001`; it is not laundered into a T08 structure field. T03
uses continuous real-linear maps `E ->L[R] H`, rather than endomorphisms only,
because the model-subtraction consumer genuinely changes codomain.

QL-001's local premise is `AEStronglyMeasurable` for
`volume.restrict (Ioc 0 k)`, paired with the local norm majorant. Requiring a
globally Borel representative would unnecessarily exclude proper-Riemann source
data after null modifications; the restricted almost-everywhere premise is the
Bochner condition actually consumed by the local estimate.

Rejected alternatives are preserving an arbitrary historical six-target count,
exposing sorted recursion or anchor machinery as public API, and replacing the
source ordinary-improper relation with a totalized whole-set Bochner integral.
This is a primary-agent architectural decision embodied in draft artifacts. It
is not mathematical review, code review, gate evidence, or Lean authorization.

The current IMP revision 6 and QL revision 4 correct only the exact namespaces
of three pinned Mathlib declarations: root
`intervalIntegrable_iff_integrableOn_Ioc_of_le`, root
`integrableOn_exp_mul_Ioi`, and root `integral_exp_mul_Ioi`. OLV revision 4
only rebinds its IMP/QL dependencies. The eight public targets, three IMP
modules, mathematical proofs, dependency direction, QL restricted-volume
`AEStronglyMeasurable` premise, and finite-dimensional source adapter are
unchanged. New exact-commit checks are pending; this correction creates no
approval, exact signature, implementation authorization, or `lean_ready`
claim.

**Status clarification (2026-09-06; superseding status prose only).** The
opening description of IMP-001 as the "next unregistered" draft records the
revision-6 design input and is no longer the current registration status.
IMP-001 is the sole member of the new closed, source-free `IMPROPER-0`
manifest. Its `execution_ready` registration records only that the final
eight-target specification scope is bounded and frozen for external review.
Final review, an external `lean_ready` gate, implementation authorization,
implementation, and source coverage remain absent. This status clarification
does not alter DD-019's mathematical decisions, public surface, dependency
direction, or revision-6 input history.

## DD-020 — Preserve verified numerical consumption as downstream work

**Status (2026-09-06):** candidate decision frozen for external review; no
approval or gate pass is recorded here.

DD-003, DD-010, and DD-012 remain unchanged. The semantic library preserves
finite explicit quantities together with their exact domains and hypotheses,
proves exact identities before passing to estimates, and keeps every passage
to norms and every constant or domain loss visible and tracked. These
properties are intended to support later independently verified numerical
consumers without adding a numerical layer to the present package.

This intent creates no current numerical implementation or new numerical
interface, and it does not require every semantic definition to be computable.
Classical or noncomputable analysis remains acceptable when the resulting
objects are publicly characterized and choice does not hide a target theorem
or estimate. Numerical algorithms, interval certificates, floating-point and
tolerance policies, quadrature, and solvers remain separate downstream work,
requiring their own bounded scope, interfaces, and review before they can
consume these semantic results.
