# LMLF design decisions

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
For the revision-2 Watson programme the mathematical path is
`IMP-001 -> QL-001 -> OLV-001 -> SR-001`; the real Gamma-moment identity is a
direct pinned-Mathlib reuse inside QL-001.  The accepted QB-001 and DEF-001
bootstrap declarations are optional packaging and audit joins, not Watson
dependencies.  Airy, Cauchy derivative transport, exact ODE residuals, and
ODE/comparison systems are parallel tracks, not blockers.

## DD-018 — Classification and review authority are versioned

Artifact revision 2 of `review/classifications-v2.json` separately controls packet-level and
declaration-level theorem, coverage, and novelty values.  Every frozen card and
packet carries exact target classifications.  `non_novel` is canonical for
routine internal definitions and consequences; `source_equivalent` requires a
bound external source target or pinned-library statement.

Version 2 supersedes the immutable v1 file.  Its machine-readable
`registry_binding` distinguishes required registry examples from illustrative
ones.  Packet theorem classes are mathematical shapes such as
`exact_identity`, `finite_remainder_bound`, `qualitative_support`,
`qualitative_bridge`, and `audit_regression`; `mixed` records packets whose
principal targets span more than one shape.
packet coverage classes carry roles such as `exact_source_generic`,
`named_source_application`, and `audit_source_recovery`.

Passing review, `lean_ready`, and authorization exist only in an external
envelope that binds the frozen specification commit and artifact digests.
Candidate-owned ledgers are historical and count as zero reviewers.  Only the
CSV inventory validator is implemented today; broader schema/lifecycle and
review-contract validation remains manual/planned.
