# LMLF blueprint index

> **Proposed successor-authority notice (pending).** The user-authorized broad
> DLMF-through-Chapter-10 boundary is specified by proposed
> [DD-021 revision 2](stage_1_dlmf-R3.md). Its operative five-file plan takes
> effect only after two fresh independent blueprint approvals and a root
> external adjudication bind the exact successor commit and digests. Until then,
> the frozen text below remains operative. Once effective, DD-021 supersedes
> only the Olver-first programme-priority/scheduling clauses it enumerates;
> frozen Olver evidence and semantics remain unchanged, and `OLV-MVP-1` remains
> an eligible parallel Olver-track packet, not a DLMF prerequisite or target.

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
| `BOOTSTRAP-0` | exactly `QB-001` and `DEF-001` | closed with zero source occurrences; externally authorized and implemented; no tagged release is claimed here |
| `IMPROPER-0` | exactly `IMP-001`: eight public targets, zero source occurrences | closed and `execution_ready` as a specification only; frozen card R7, metadata-only proof successor R7, and work packet R1 await fresh final pre-Lean review and an external envelope; no `lean_ready` or implementation authorization |
| `QB-001` | eight signatures only | immutable card revision 7/proof revision 6/signature revision 2 retain their pre-authorization self-status; external review accepted the exact implementation at commit `515b742f7ad5472c17cfdf0fda7cbc83c5585da1` |
| `DEF-001` | four Gamma reuse wrappers | immutable card revision 4 retains its specification-snapshot self-status; external review accepted the exact implementation at commit `515b742f7ad5472c17cfdf0fda7cbc83c5585da1` |
| `OLV-MVP-1` | one selected Watson occurrence | open and `planning_only`; QL-001 and OLV-001 remain revision-4 planning drafts; the separate upstream IMP specification has no `lean_ready`, implementation authorization, PDF-fidelity renewal, or coverage claim |
| Parallel source collations | Chapter 2 `Ai` and `J`/`I`; Chapter 11 real Airy/auxiliaries; Chapter 12 real Bessel auxiliaries; Chapter 8 Euler--Maclaurin/Bernoulli | hash-bound mathematical transcriptions are present; two independent source referees approved the exact Bessel revision-2 files and all 119 Bessel occurrence rows are integrated provisionally; Airy, Bernoulli, and Bessel remain unreconciled, Bernoulli has unregistered identification drafts, and no Bessel notation/entity link, card, manifest membership, coverage, or Lean authorization exists |
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

The frozen cards do not back-write external verdicts or later candidate state.
Current implementation truth is therefore recorded in this index and the root
README, while the original card fields remain immutable evidence of the state
that was reviewed.

Historical reports are preserved on the private repository's
[`review-evidence` commit `5c8ec1b`](https://github.com/jaumededios/LMLF/commit/5c8ec1b301f656df35ffa8850e002639807995cd).
Each report or approval binds only the commit and bytes it records; this archive
is evidence preservation, not current status authority.

## Mandatory packet lifecycle

For genuinely new mathematics, work proceeds in this order:

```text
source/reuse evidence and a bounded target
  -> complete natural-language proof
  -> frozen proof/architecture bytes and externally recorded digests
  -> multiple independent proof/architecture reviews, including structural-circularity when applicable
  -> exact Lean signature design
  -> independent signature and theorem-card reviews
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

The current classification authority is artifact revision 3 of
[`lmlf-classification-v3`](../review/classifications-v3.json). It supersedes
but does not mutate immutable v2, keeps packet theorem shapes separate from
source coverage roles, and marks registry examples as required or illustrative
in machine-readable form. Its SHA-256 is
`975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`.
Immutable historical cards and packets retain the
authority to which they were frozen; the IMP R6 and QL/OLV R4 drafts bind v3.

The canonical normalized tables live in [`inventory/`](inventory/).  Closed
release manifests have finite card and occurrence membership, exact totals,
and no wildcard such as “related results.”  DLMF is a locator and convention
cross-check, not a substitute for direct collation of the locked 1997 edition.

The current QL-001 registry row uses v3's corrected `non_novel` value for its
classical bounded-primitive mathematics. This was a versioned correction;
frozen v2 remains unchanged, and the new classification grants no review or
implementation approval.

## Milestones and critical path

M0--M4 are a bounded infrastructure demonstrator, not Olver coverage:

| Milestone | Bounded outcome | Dependency role |
|---|---|---|
| M0 | edition/pin lock, inventories, cards, review protocol | governance foundation |
| M1 | `QB-001` finite-error predicates and five transport lemmas | minimal quantitative foundation |
| M2 | `DEF-001` Gamma reuse/audit pilot | parallel audit wrapper; not consumed by the revision-4 Watson proof |
| M3 | explicit complex-domain and Cauchy derivative transport demonstrator | parallel, off Watson path |
| M4 | finite integral/Laplace identities and bounds | direct Watson prerequisite |
| M5 | one exact-source quantitative Watson theorem plus audit recovery | first true quantitative-Olver MVP |

The M5 mathematical critical path is:

```text
locked 1997 collation ------------------------------------\
                                                           +-> OLV-001 -> SR-001
pinned integration/limit facts -> IMP-001 -> QL-001 ------/
pinned Real Gamma moment -----------------------> QL-001
```

`IMP-001` is the sole member of the separate, source-free `IMPROPER-0`
milestone. Frozen card revision 7 and work-packet revision 1 bind the new
metadata-only proof successor `NLP-IMP-001-R7` and the accepted exact-signature
proposal revision 2,
SHA-256 `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d`.
The R7 proof successor preserves the R6 mathematics and equations while
updating only lifecycle/binding/status metadata; canonical
`proofs/IMP-001.md` R6 remains unchanged historical mathematical input and
the dependency recorded by QL/OLV R4.
Its eight targets were selected by consumer completion, not by a hard schema
cap. `Basic` owns T01/T05/T08/T02/T03/T04, `Bochner` owns
the arbitrary-exception absolute bridge T07, and `Abel` owns T06 while keeping
the finite-piece engine private. T01 retains independent endpoint semantics;
T08 is the public equivalence with existence of a normalized continuous
primitive tending to the same value; and T03 permits continuous linear maps
`E -> H`. Revision 6 corrects only the root namespace of one pinned Mathlib
declaration; QL revision 4 corrects two more root namespaces, and OLV revision
4 only rebinds those revised dependencies. The mathematical targets, proofs,
architecture, a.e. local premise, finite-dimensional source adapter, eight
public targets, and three IMP modules are unchanged. Fresh exact-byte referees C
and D approved the
[revision-2 proposal](theorem_cards/IMP-001-signatures-R6.md) at commit
`9e6e038871ac66f80534626d3deade0b27af6752`; the root negative-guard finding
was resolved only for those exact proposal bytes. The reports and disposition
are archived at private
[`review-evidence` commit `d0d4fb4`](https://github.com/jaumededios/LMLF/commit/d0d4fb4895733b5de8396794e81cbe1a19657bdb).
Those approvals are prerequisite-stage input to card/work-packet freezing, not
final-packet quorum. The closed manifest's `execution_ready` status means
specification readiness only. Its compiled-unreviewed prototype uses temporary
axiomatic theorem stubs only and is not production Lean. Fresh final pre-Lean
reviews and an external
envelope remain pending; no `lean_ready`, production implementation,
PDF-fidelity, or source-coverage claim follows. The historical
revision-3 exact-signature artifact is untouched,
superseded changes-requested evidence and is not an R6 signature input.
QL-001 uses T06 for its tail, T07 for model terms, and T04 for the local/tail
join. OLV-001 uses T07/T03/T04/T08 to obtain the baseline primitive, derives
the flat bound `L` itself, and then invokes QL-001.
QB-001 and DEF-001 may later support optional error-predicate packaging or a
Gamma audit wrapper, but the revision-4 QL/OLV proofs consume neither.

Watson is generic in an amplitude and parameters.  `OLV-001` is therefore
`exact_source_generic`, not `named_source_application`.  It is source-facing
over complex scalars, has a real corollary, and preserves Olver's ordinary
improper meaning by independent one-sided limits at a finite exceptional set.
The Lean-facing finite pieces use Mathlib Bochner `intervalIntegral` with
explicit integrability evidence; no second proper-Riemann library is planned.
It chooses one common `X > 0` before `n`.  Airy, Cauchy
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
| Bootstrap | `QB-001`, `DEF-001` | closed, externally accepted, and implemented at the exact `515b742...` candidate |
| Improper integration infrastructure | `IMP-001` | sole member of separate closed `IMPROPER-0`; frozen card R7, metadata-only proof successor R7, work packet R1, and eight signatures are `execution_ready` as a specification only, pending fresh final pre-Lean review and external envelope |
| Demonstrator candidates | `QA-002`, `DEF-002`, `QC-001`, `QL-001`, `EX-001`, `EX-002` | `DEMO-0` planning; only IDs with complete cards may move to a revised closed manifest |
| Watson source pilot | registered `QL-001`, `OLV-001`, `SR-001`; upstream `IMP-001` lives in `IMPROPER-0` | QL-001 and OLV-001 remain revision-4 planning drafts; final acceptance of the upstream IMP packet, `lean_ready`, implementation authorization, and SR-001 carding remain absent |
| Domain/branch support | `QC-DOM`, `CB-PRINCIPAL`, `CB-GENERIC`, `QC-REAL`, `QC-LOGCOORD` | provisional in [complex domains](methods/complex_domains_branches.md) |
| Derivative transport | `QC-CAUCHY`, `QC-RADIUS`, `EX-001`, `QC-NEG-DERIV`, `QC-JET`, `QC-MIXED`, `QC-GAUGE` | provisional except manifest candidate `EX-001`; M3 uses only the bounded initial slice |
| Laplace | `IMP-001`; `QL-001`--`QL-003`, `EX-002`, `OLV-001`, `OLV-002`, `SR-001` | IMP-001 in separate `IMPROPER-0` -> QL-001 -> OLV-001 -> SR-001 is the MVP route; OLV-002 is a separate unselected section 9 bound |
| Oscillatory/contour | `OI-001`--`OI-003`, `CT-001`--`CT-002`, `SP-001`--`SP-002`, `SD-001`, `COAL-001` | provisional and off the Watson path |
| Summation/transfer | `SUM-001`, `BER-001`, `EM-001`--`EM-002`, `CF-001`--`CF-002`, `DAR-001`, `ILT-001` | provisional; `ILT-001` waits for a direct source selection |
| ODE/stability | `ODE-001`--`ODE-011` | separate bounded planning packets; named variants escalate to the three-review gate |
| Turning/pole comparisons | `TP-001`--`TP-009`, `BP-001`--`BP-002`, with `DEF-002`/`DEF-003` dependencies | provisional; all transition packets use the three-review gate |
| Zeros/connections | `ZERO-001`--`ZERO-008`, `CONN-001`--`CONN-006` | provisional; local zeros, global indexing, and connections remain separate packets |
| Gamma family | `DEF-GAM-002`--`DEF-GAM-005`, `DEF-IGAM-001`--`DEF-IGAM-003`, `AUD-GAM-001` | provisional; does not widen `DEF-001` |
| Airy/Scorer family | `CON-AIR-001`, `DEF-AIR-001`--`DEF-AIR-003`, `DEF-SCO-001`, `CMP-AIR-001`--`CMP-AIR-002`, `AUD-AIR-001` | provisional; bounded `Ai`/`Bi` and real-auxiliary formulas are transcribed but source review, construction choice, and normalization reconciliation remain unresolved |
| Bessel/cylinder family | `DEF-HG0F1-001`, `DEF-BES-001`--`DEF-BES-007`, `CMP-BES-001`--`CMP-BES-002`, `AUD-BES-001` | provisional; exceptional-order continuation is separate work |
| Hypergeometric/Legendre | `DEF-HG0F1-001`, `DEF-HG-001`--`DEF-HG-004`, `DEF-KUM-001`--`DEF-KUM-002`, `DEF-LEG-001`--`DEF-LEG-003`, `DEF-WHI-001`--`DEF-WHI-002`, `AUD-HGLEG-001` | provisional; local series substrates are not global identified functions |
| Remaining families | `DEF-EI-*`, `DEF-ERF-*`, `DEF-DAW-001`, `DEF-FRE-001`, `DEF-PCY-*`, per-member `DEF-ORTH-*`, `DEF-ZETA-*`, `DEF-BERN-*`, `DEF-ANGER-*`, `DEF-STRUVE-*`, `DEF-NICH-*`, per-entity auxiliary queues and matching audits | patterns are not wildcard cards; each waits for a finite member split |
| Automation | `bound_calc`, `cauchy_bound`, `residual_nf`; validator rollout phases | no tactic/linter implementation authorized; admission waits for the stable-manual-consumer thresholds |

Provisional `APP-*` names in method documents are discovery targets, not
applications, source cards, or coverage.  Each must eventually bind one exact
occurrence and either become an exact-source generic theorem or identify a
named function and discharge all generic hypotheses.

## Work that may proceed in parallel

- Independent Watson collation review remains pending. Two external
  fresh-context Sol reports approved the exact IMP-001 R6, QL-001 R4, and
  OLV-001 R4 natural-language proof/architecture bytes at `50dcded3` solely
  to begin bounded signature design. Fresh referees C and D then approved the
  exact signature-proposal revision 2 bytes at `9e6e038`; frozen IMP card R7,
  metadata-only proof successor R7, and work packet R1 now await fresh final
  pre-Lean review and an external envelope.
  `OLV-001` cannot freeze until the source
  and integral-semantics choices are independently approved and IMP-001 and
  QL-001 are accepted.
- M3 complex derivative transport can proceed beside M4 and M5.  It must not be
  inserted into Watson's prerequisites.
- Future Gamma or finite-error extensions may proceed independently, but each
  new card still needs an external `lean_ready` envelope before implementation.
  The accepted QB-001 and DEF-001 bootstrap declarations are optional
  packaging/audit joins rather than dependencies of the revision-4 Watson proof.
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

The earlier unavailable-source blocker was closed for the completed collation:
the exact 1997 PDF was inspected and hash-bound outside version control,
printed pp. 71-72 were mapped to PDF pp. 84-85, and a copyright-safe
mathematical transcription plus notation/entity records survive. The original
uploaded PDF is not present in this restarted environment, so any new source-
image audit requires reattachment or recovery; source-independent IMP/QL work
is unaffected. The occurrence remains `transcribed_unreconciled`, because its page
audit, scalar interpretation, conditional-improper-integral semantics, and
transcription have not received independent approval.  Same-edition source
evidence now supports a complex source-facing statement with a real corollary,
and the revision-4 architecture represents the ordinary source meaning by
one-sided limits at a finite exceptional set, using Mathlib
`intervalIntegral` on regular finite pieces and a continuous normalized
primitive.  No separate proper-Riemann implementation is planned.  It chooses
one common baseline `X > 0` before `n`; the whole-set Bochner route is only an
absolute-integrability adapter. QL-001 and OLV-001 revision-4 cards and
complete draft proof dossiers expose those choices; neither is frozen or
Lean-authorized. The separate `IMPROPER-0` milestone now freezes upstream
IMP-001 card R7, metadata-only proof successor R7, and work packet R1 around
the unchanged R6 mathematics and accepted signature-proposal revision 2.
Canonical proof R6 remains the unchanged historical input used by QL/OLV, not
a newly frozen artifact. The final pre-Lean reviews, external envelope,
`lean_ready`, and implementation authorization remain absent. This
review stage does not renew PDF fidelity or establish source coverage. The
occurrence-card association uses
`exact_source_target`, matching the card's `exact_source_generic` coverage
class, but structural metadata agreement is not source certification.

The future Airy/Bessel planning names also need a non-mathematical registry
reconciliation before any card is created: the demonstrator/transition plans
use coarse handles `DEF-002` and `DEF-003`, while the family plans deliberately
split that work into `DEF-AIR-*` and `DEF-BES-*`.  These are alternative queue
names, not accepted dependencies or duplicate cards.  One finite canonical ID
set must be chosen when the first exact signatures are frozen.

Across the wider programme, the full locked 1997 snapshot was previously
available and bounded Airy and Euler--Maclaurin/Bernoulli source transcriptions joined
the Watson pilot, but its mathematical body audit is overwhelmingly incomplete.
Many existing family leads still come only from a later publisher preview's contents pages. Exact
member lists, normalizations, branch cuts, parameter order, derivative
variables, exceptional values, and edition differences therefore remain open.
The authoritative research queue starts with:

- `RQ-SRC-001`: independent approval of the exact locked Watson collation;
- `RQ-WAT-001`: review of the IMP-001/QL-001/OLV-001 architecture and freezing
  of the finite theorem justified by precisely those hypotheses;
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

Only the CSV inventory validator is implemented today; it consumes v3 packet
classification enums and derives required registry rows from machine-readable
`registry_binding` values; v2 is only the frozen predecessor. Routine checks
run locally with `lake build` and
`python3 scripts/validate_inventory.py --negative-tests`. GitHub Actions is
explicit manual-only via `workflow_dispatch`, not push/PR automation.
YAML/Markdown lifecycle, target-level card/packet classification, digest, and
external-review validation remains manual/planned; the contract-linter rules
describe future behavior, not a gate that has already run.

Release reporting follows [the release strategy](qualitative/release_strategy.md):
Stage 0 bootstrap, a single-occurrence Watson pilot, bounded definition and
method waves, selected-result chapter checkpoints, and only eventually an
edition-level qualitative companion.  Every report gives an exact numerator
and closed denominator.  “Chapter formalized” and “function supported” are
forbidden when the corresponding occurrence or entity universe is unresolved.
