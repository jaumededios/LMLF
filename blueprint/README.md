# LMLF blueprint index

**Normative owner:** `jaumededios`  
**Blueprint state:** bounded specification plus planning queues  
**Source target:** F. W. J. Olver, *Asymptotics and Special Functions*,
corrected A K Peters reprint, 1997, ISBN **1-56881-069-5**

This directory is the project control plane for an exact-analysis Lean/mathlib
library that is navigable like the [DLMF](https://dlmf.nist.gov/) but reports
source coverage occurrence by occurrence.  Its reusable public mathematics is
finite and quantitative.  Source-faithful qualitative consequences are
separate, kernel-checked consumers under `Audit/SourceRecovery`.

The [roadmap](roadmap.md) is the milestone authority, the
[design decisions](design_decisions.md) fix the non-negotiable boundaries, and
the [dependency graph](dependency_graph.md) gives the execution order.  A
planning ID in any specialist document is not a theorem card, manifest member,
review authorization, or source claim.

## Current truth

As of this specification:

| Item | Scope | Honest state |
|---|---|---|
| `DEMO-0` | candidate M0--M4 work | open and `planning_only`; not execution-ready |
| `BOOTSTRAP-0` | exactly `QB-001` and `DEF-001` | closed and `execution_ready`; zero source occurrences |
| `QB-001` | eight signatures only | card revision 7, proof revision 6, and signature revision 2 are frozen; proof complete, external review not started, no Lean authorization |
| `DEF-001` | four Gamma reuse wrappers | card revision 4 frozen; proof not required, external review not started, implementation not started, prototype absent in the exact specification snapshot |
| `OLV-MVP-1` | one selected Watson occurrence | open and `planning_only`; occurrence selected but the locked text is not yet collated |
| Olver theorem coverage | none | no quantitative Olver theorem or qualitative source recovery is currently claimed |

The exact bootstrap specifications are the
[`QB-001` card](theorem_cards/QB-001.yaml), its
[eight-signature artifact](theorem_cards/QB-001-signatures.md), the
[`DEF-001` card](theorem_cards/DEF-001.yaml), and their bounded
[`QB-001`](../review/work_packets/QB-001.yaml) and
[`DEF-001`](../review/work_packets/DEF-001.yaml) work packets.  The
[QB proof](proofs/QB-001.md) is complete and frozen.  The
[revision-3 review ledger](reviews/QB-001-rev3.md) is historical, non-quorum
context and records no current gate.  The theorem-card
[status vocabulary](theorem_cards/README.md) is normative: specification,
proof, review, implementation, prototype, coverage, and manifest membership
are independent axes.

## Mandatory packet lifecycle

For genuinely new mathematics, work proceeds in this order:

```text
source/reuse evidence and a bounded target
  -> exact theorem card and public-signature artifact
  -> complete natural-language proof
  -> frozen bytes and externally recorded digests
  -> independent theorem-card, proof, and applicable structural-circularity reviews
  -> explicit external lean_ready authorization
  -> Lean implementation of only the frozen targets
  -> build, regression, import, axiom, and implementation reviews
  -> source reconciliation, audit bridge, and closed release manifest as applicable
```

Two independent pre-Lean reviewers are the minimum for new mathematics: one
checks source/semantics and one independently re-derives the proof, domains,
constants, and edge cases.  Named-function construction, continuation,
turning-point, zero, and connection work adds a third
separately represented `structural_circularity_review`.  A packet marks this
gate required or gives an exact inapplicability reason.  A material statement,
proof, dependency,
source-snapshot, pin, or candidate-head change invalidates the affected
approval.  Filled review envelopes and verdicts stay external to the candidate
head; the baseline specification commit is likewise recorded externally after
the commit exists, never self-referentially inside it.

Transparent non-novel pinned-library reuse can set packet
`natural_language_proof_review.applicability: not_applicable` with a concrete
reason; the external envelope mirrors it as `gate_state: not_required`.  It
still needs a bounded card, exact pin/signatures, semantic review, and
implementation review.  Compilation is evidence, not approval.

Candidate-owned cards, packets, proof metadata, and repository review summaries
cannot certify reviewer pass, quorum, `lean_ready`, or authorization.  Those
facts exist only in an external envelope bound to the frozen specification
commit, packet, artifacts, classification schema, and digests.

Every finite named estimate additionally proves all of the following rather
than storing them as desired fields:

- the named object is the accepted identified implementation;
- every generic hypothesis is discharged;
- the advertised domain is inhabited or reachable in the stated regime;
- the public majorant is nonnegative on that domain;
- branches, orientation, exceptional values, derivative variables, and
  normalization match the source occurrence; and
- the target function is fixed across truncation orders.

This is the project-wide defense against hypothesis and choice laundering.

## Manifest and source controls

The [source-manifest policy](source_manifest.md) and
[function/occurrence inventory protocol](function_inventory.md) distinguish:

- source occurrences, including repeated definitions, theorems, exercises,
  formulas, and normalization checks;
- occurrence-local notation, binder order, branches, orientation, and scale;
- canonical source entities and aliases; and
- packet-local concepts such as `ErrorOn` and `HasErrorFamily`, which are not
  source entities merely because the project uses them.

The sole current classification authority is frozen artifact revision 2 of the
[`lmlf-classification-v2`](../review/classifications-v2.json) JSON artifact.
It supersedes immutable v1, keeps packet theorem shapes separate from source
coverage roles, and marks registry examples as required or illustrative in
machine-readable form.

The canonical normalized tables live in [`inventory/`](inventory/).  Closed
release manifests have finite card and occurrence membership, exact totals,
and no wildcard such as “related results.”  DLMF is a locator and convention
cross-check, not a substitute for direct collation of the locked 1997 edition.

## Milestones and critical path

M0--M4 are a bounded infrastructure demonstrator, not Olver coverage:

| Milestone | Bounded outcome | Dependency role |
|---|---|---|
| M0 | edition/pin lock, inventories, cards, review protocol | governance foundation |
| M1 | `QB-001` finite-error predicates and five transport lemmas | minimal quantitative foundation |
| M2 | `DEF-001` Gamma reuse/audit pilot | optional Watson moment dependency |
| M3 | explicit complex-domain and Cauchy derivative transport demonstrator | parallel, off Watson path |
| M4 | finite integral/Laplace identities and bounds | direct Watson prerequisite |
| M5 | one exact-source quantitative Watson theorem plus audit recovery | first true quantitative-Olver MVP |

The M5 critical path has two independent predecessors which join at the selected
Laplace slice:

```text
locked 1997 collation -----\
                            +-> selected QL-001 -> OLV-001 -> SR-001
QB-001 finite core --------/
DEF-001 / Gamma facts - - -> QL-001 or OLV-001
                           only if the collated formulation uses Gamma moments
```

Watson is generic in an amplitude and parameters.  `OLV-001` is therefore
`exact_source_generic`, not `named_source_application`.  Airy, Cauchy
transport, oscillatory/contour work, summation, ODE stability, turning points,
and custom tactics are all off this critical path.

## Programme map

The multi-year programme is split into parallel tracks.  The linked documents
hold bounded proposal queues, prerequisite seams, proof-dossier obligations,
and adversarial tests; unless an ID appears in the canonical card inventory it
remains unregistered planning shorthand.

| Track | Years | Planning documents | Queue summary |
|---|---:|---|---|
| A: definitions and entity identification | 1--3 | [family overview](families/README.md), [Gamma-related](families/gamma_related.md), [Airy/Scorer](families/airy_scorer.md), [Bessel/cylinder](families/bessel_cylinder.md), [hypergeometric/Legendre/Whittaker](families/hypergeometric_legendre.md), [remaining portfolios](families/remaining_families.md) | bounded `CON-*`, `DEF-*`, `CMP-*`, and `AUD-*` proposals; each source family waits for locked body evidence |
| B: integral and summation methods | 1--2 | [Laplace](methods/integral_laplace.md), [oscillatory/contour](methods/oscillatory_contour.md), [summation/coefficient transfer](methods/summation.md) | `QL-*`, `OI-*`, `CT-*`, `SP-*`, `SD-*`, `COAL-*`, `SUM-*`, `BER-*`, `EM-*`, `CF-*`, `DAR-*`, `ILT-*` |
| C: ODE and comparison systems | 1--4 | [residuals and stability](methods/ode_residual_stability.md), [turning points and pole models](methods/turning_points.md) | `ODE-001`--`ODE-011`, `TP-001`--`TP-009`, `BP-001`--`BP-002`, plus separately gated Airy/Bessel identifications |
| D: transitions and derivatives | 2--4 | [complex domains and branches](methods/complex_domains_branches.md), [derivative transport](methods/derivative_transport.md), [turning points](methods/turning_points.md) | `QC-*`, `CB-*`, `EX-001`, later jets/mixed derivatives/gauges, and the transition queues |
| E: zeros, connections, and coverage | 3+ | [zeros and connections](methods/zeros_connections.md), [source recovery](qualitative/source_recovery.md), [release strategy](qualitative/release_strategy.md) | `ZERO-001`--`ZERO-008`, `CONN-001`--`CONN-006`, then finite `SR-*` and release batches |

Cross-track control documents are the pinned
[Mathlib feasibility audit](mathlib_audit.md), the
[proof-artifact schema](automation/proof_artifact_schema.md),
[contract linting](automation/contract_linting.md),
[testing and CI](automation/testing_and_ci.md), and the
[tactic admission plan](automation/tactics.md).  Public navigation and release
reporting are specified by [navigation and documentation](qualitative/navigation_and_docs.md).
The [open research queue](qualitative/open_research_questions.md) keeps genuine
mathematical uncertainty out of theorem cards until a reviewed answer exists.

## Queue directory

The directory below is exhaustive at the document-family level.  Exact target
descriptions, proofs required, dependencies, and acceptance IDs live in the
linked document.

| Queue | Planning IDs | Registration/status boundary |
|---|---|---|
| Bootstrap | `QB-001`, `DEF-001` | the only current closed, fully specified manifest members |
| Demonstrator candidates | `QA-002`, `DEF-002`, `QC-001`, `QL-001`, `EX-001`, `EX-002` | `DEMO-0` planning; only IDs with complete cards may move to a revised closed manifest |
| Watson source pilot | `QL-001`, `OLV-001`, `SR-001` | registered as planning rows; no complete cards or source transcription yet |
| Domain/branch support | `QC-DOM`, `CB-PRINCIPAL`, `CB-GENERIC`, `QC-REAL`, `QC-LOGCOORD` | provisional in [complex domains](methods/complex_domains_branches.md) |
| Derivative transport | `QC-CAUCHY`, `QC-RADIUS`, `EX-001`, `QC-NEG-DERIV`, `QC-JET`, `QC-MIXED`, `QC-GAUGE` | provisional except manifest candidate `EX-001`; M3 uses only the bounded initial slice |
| Laplace | `QL-001`--`QL-003`, `EX-002`, `OLV-001`, `SR-001` | only the minimal source-selected slice is on the Watson path |
| Oscillatory/contour | `OI-001`--`OI-003`, `CT-001`--`CT-002`, `SP-001`--`SP-002`, `SD-001`, `COAL-001` | provisional and off the Watson path |
| Summation/transfer | `SUM-001`, `BER-001`, `EM-001`--`EM-002`, `CF-001`--`CF-002`, `DAR-001`, `ILT-001` | provisional; `ILT-001` waits for a direct source selection |
| ODE/stability | `ODE-001`--`ODE-011` | separate bounded planning packets; named variants escalate to the three-review gate |
| Turning/pole comparisons | `TP-001`--`TP-009`, `BP-001`--`BP-002`, with `DEF-002`/`DEF-003` dependencies | provisional; all transition packets use the three-review gate |
| Zeros/connections | `ZERO-001`--`ZERO-008`, `CONN-001`--`CONN-006` | provisional; local zeros, global indexing, and connections remain separate packets |
| Gamma family | `DEF-GAM-002`--`DEF-GAM-005`, `DEF-IGAM-001`--`DEF-IGAM-003`, `AUD-GAM-001` | provisional; does not widen `DEF-001` |
| Airy/Scorer family | `CON-AIR-001`, `DEF-AIR-001`--`DEF-AIR-003`, `DEF-SCO-001`, `CMP-AIR-001`--`CMP-AIR-002`, `AUD-AIR-001` | provisional; source names/normalizations unresolved |
| Bessel/cylinder family | `DEF-HG0F1-001`, `DEF-BES-001`--`DEF-BES-007`, `CMP-BES-001`--`CMP-BES-002`, `AUD-BES-001` | provisional; exceptional-order continuation is separate work |
| Hypergeometric/Legendre | `DEF-HG0F1-001`, `DEF-HG-001`--`DEF-HG-004`, `DEF-KUM-001`--`DEF-KUM-002`, `DEF-LEG-001`--`DEF-LEG-003`, `DEF-WHI-001`--`DEF-WHI-002`, `AUD-HGLEG-001` | provisional; local series substrates are not global identified functions |
| Remaining families | `DEF-EI-*`, `DEF-ERF-*`, `DEF-DAW-001`, `DEF-FRE-001`, `DEF-PCY-*`, per-member `DEF-ORTH-*`, `DEF-ZETA-*`, `DEF-BERN-*`, `DEF-ANGER-*`, `DEF-STRUVE-*`, `DEF-NICH-*`, per-entity auxiliary queues and matching audits | patterns are not wildcard cards; each waits for a finite member split |
| Automation | `bound_calc`, `cauchy_bound`, `residual_nf`; validator rollout phases | no tactic/linter implementation authorized; admission waits for the stable-manual-consumer thresholds |

Provisional `APP-*` names in method documents are discovery targets, not
applications, source cards, or coverage.  Each must eventually bind one exact
occurrence and either become an exact-source generic theorem or identify a
named function and discharge all generic hypotheses.

## Work that may proceed in parallel

- Direct Watson collation, a narrow pinned-Mathlib reuse audit, and drafting the
  generic finite Laplace proof may proceed together.  `OLV-001` cannot freeze
  until the collation fixes its exact statement, and only the required QL
  subset enters the source critical path.
- M3 complex derivative transport can proceed beside M4 and M5.  It must not be
  inserted into Watson's prerequisites.
- Gamma specification review can proceed independently.  Implementation may
  start only after an external envelope grants `lean_ready`; Watson waits for
  `DEF-001` only if the selected moment proof consumes its public facts.
- Within Track B, elementary summation, circle-coefficient, finite oscillatory,
  and finite contour infrastructure have deliberately separate roots.
- ODE residual algebra, finite-IVP support, path systems, and representation
  audits can progress beside source collation.  Named comparison theorems wait
  for both method and family-identification gates.
- Family waves may proceed independently after their own locked-body and reuse
  audits.  A blocked family blocks only cards that name it.
- Contract fixtures and documentation projections may be designed while math
  work proceeds, but they cannot award mathematical or source approval.

## Unresolved source and research gates

The immediate source blocker is not Lean: the exact 1997 Watson proposition is
untranscribed.  The occurrence still lacks the inspected snapshot identity,
printed label and complete proposition, notation/entity resolution, and an
independent collation review.  The current occurrence-card association also
uses `exact_source_target`, matching the card's `exact_source_generic` coverage
class; the inventory validator now rejects a named/source-recovery role
mismatch.  This metadata agreement does not resolve the missing transcription.

The future Airy/Bessel planning names also need a non-mathematical registry
reconciliation before any card is created: the demonstrator/transition plans
use coarse handles `DEF-002` and `DEF-003`, while the family plans deliberately
split that work into `DEF-AIR-*` and `DEF-BES-*`.  These are alternative queue
names, not accepted dependencies or duplicate cards.  One finite canonical ID
set must be chosen when the first exact signatures are frozen.

Across the wider programme, the locked 1997 body scan is incomplete.  Many
family leads come only from a later publisher preview's contents pages.  Exact
member lists, normalizations, branch cuts, parameter order, derivative
variables, exceptional values, and edition differences therefore remain open.
The authoritative research queue starts with:

- `RQ-SRC-001`: exact locked Watson collation;
- `RQ-WAT-001`: the finite theorem justified by precisely those hypotheses;
- `RQ-QUAL-001`: the exact eventual-domain and scale bridge;
- `RQ-INT-001` and `RQ-CAUCHY-001`: explicit tails and derivative radii;
- `RQ-AIRY-001`, `RQ-BESSEL-001`, and `RQ-PARAM-001`: noncircular
  construction, continuation, and parameter regularity;
- `RQ-CODE-001`, `RQ-FIXED-001`, `RQ-PATH-001`, `RQ-TURN-001`, and
  `RQ-POLE-001`: ODE/transition foundations;
- `RQ-SUM-001`, `RQ-FROB-001`, and `RQ-COAL-001`: later exact methods; and
- `RQ-ZERO-001`, `RQ-INDEX-001`, and `RQ-CONN-001`: local zeros, global
  indexing, and scale-sensitive connection data.

These questions block only packets that cite them.  A research answer earns no
release or coverage status until converted into exact cards, complete proof
artifacts, independent reviews, and accepted Lean declarations.

## Verification and release evidence

The target pipeline is specified in [testing and CI](automation/testing_and_ci.md):
schema/source-contract checks precede narrow and semantic builds, separate
audit builds, exact mathematical regressions, axiom reports, import/declaration
dependency audits, review-consistency checks, and an immutable proposer-evidence
bundle.  The [contract linter](automation/contract_linting.md) may reject an
incomplete or inconsistent artifact, but it cannot decide truth, source
fidelity, proof correctness, or reviewer independence.

Only the CSV inventory validator is implemented today; it consumes v2 packet
classification enums and derives required registry rows from machine-readable
`registry_binding` values.  CI runs its positive and negative suites.
YAML/Markdown lifecycle, target-level card/packet classification, digest, and
external-review validation remains manual/planned; the contract-linter rules
describe future behavior, not a gate that has already run.

Release reporting follows [the release strategy](qualitative/release_strategy.md):
Stage 0 bootstrap, a single-occurrence Watson pilot, bounded definition and
method waves, selected-result chapter checkpoints, and only eventually an
edition-level qualitative companion.  Every report gives an exact numerator
and closed denominator.  “Chapter formalized” and “function supported” are
forbidden when the corresponding occurrence or entity universe is unresolved.
