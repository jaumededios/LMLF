# Proposer/referee protocol

## Purpose

Lean checks terms against stated types. It does not establish that those types
faithfully transcribe a source, identify the intended named function, describe a
nonempty domain, expose useful constants, or occupy the correct library layer.
This protocol gives those questions separate, auditable gates.

The process is usable manually. It does not assert that this repository has a
review bot, hardened sandbox, identity service, or evidence archive.

## Controlled vocabulary

Use these values consistently in templates and records:

- packet `lifecycle_state`: `draft`, `frozen`, `superseded`;
- gate `gate_state`: `pending`, `pass`, `fail`, `blocked`, `not_required`;
- requirement `applicability`: `required`, `not_applicable`;
- rubric `verdict`: `approve`, `request_changes`, `block`;
- reviewer `kind`: `human`, `agent`;
- verdict `review_stage`: `pre_lean`, `implementation`;
- verdict `review_perspective`: `source_semantics`, `proof_correctness`,
  `dependency_direction`, `source_to_target_reachability`, or
  `hypothesis_and_choice_laundering`;
- reviewer `isolation_strength`: `manual_attestation`,
  `technically_enforced`;
- disposition `resolution_state`: `open`, `fixed_pending_rereview`,
  `resolved_by_fresh_approval`, `withdrawn_by_referee`, `packet_superseded`.

`pass` is used only for a composite gate. `approve` is used only for one
reviewer's rubric verdict. `not_required` is used only when the frozen packet
marks that gate `not_applicable` with a reason. `fixed_pending_rereview` is not
terminal.

## Roles

- **Specification owner:** controls source selection, theorem cards,
  natural-language proofs, exact target signatures, and packet scope.
- **Pre-Lean referee:** independently reviews a theorem card or natural-language
  proof before implementation begins.
- **Proposer:** implements a packet whose external `lean_ready` gate is `pass`.
  Self-checks do not count toward a review quorum.
- **Implementation referee:** reviews one rubric against an exact candidate head
  without editing it.
- **Merger/adjudicator:** verifies structural quorums and all merge gates. A
  source or trust-boundary failure cannot be waived because the build is green.

An accepting referee must have a distinct durable reviewer ID from the proposer.
Independent agent reviews may use the same model, including multiple
fresh-context Sol agents. They must use distinct durable reviewer IDs and fresh
sessions, and each record must identify model, runtime, and actual isolation
method. Model diversity may be required as an optional strengthening, but it is
not the definition of independence.

## Specification without self-reference

The work packet is ordinary specification content. It contains upstream
theorem-card and natural-language-proof revisions/digests, exact targets, and
review requirements. It does **not** contain its own commit, path, or digest.

After the packet is frozen, an external review envelope binds:

```text
(work_item_id, spec_commit, work_packet_path, work_packet_sha256,
 theorem_card revisions/digests, natural-language-proof revisions/digests)
```

This avoids a packet whose contents change when its own identity is filled in.
If the packet is stored in the implementation repository, `spec_commit` must
refer to an earlier frozen commit and the implementation change must not edit it.
A separately controlled specification repository is also acceptable.

Candidate-owned status fields are temporal descriptions, never gate evidence.
They may say that an artifact is `frozen`, a proof is `complete`, or an
implementation is `not_started`; they cannot certify a reviewer identity,
`pass`, `approve`, `lean_ready`, implementation authorization, or merge.  Only
an external envelope and its bound verdicts are authoritative for those facts.
An in-repository review summary is historical, non-quorum context.

## Orthogonal target classifications

The frozen controlled vocabulary is artifact revision 2 of
[`classifications-v2.json`](classifications-v2.json), which supersedes the
immutable v1 artifact.  It separates packet-level
summaries from declaration-level target values.  Every target in `targets` has
three independent classifications:

- `theorem_class`: `definition`, `identification`, `exact_identity`,
  `existence_uniqueness`, `qualitative_support`, `generic_quantitative`,
  `named_quantitative`, or `audit_regression`;
- `coverage_class`: `direct_source_target`, `named_source_target`,
  `source_prerequisite`, `reusable_infrastructure`, or `audit_only`;
- `novelty_class`: `non_novel`, `source_equivalent`, `equivalent_reformulation`,
  `generalized`, `strengthened_conclusion`, `stronger_hypotheses`, or `novel`.

These fields answer different questions. For example, a target can be a
`generic_quantitative` theorem, `reusable_infrastructure`, and `novel`; none of
those values implies source recovery. The packet's prose explains any relation
that a single novelty value cannot capture.

`non_novel` is the truthful target value for routine definitions and elementary
consequences.  `source_equivalent` requires a specifically bound external source
target or pinned-library statement; equivalence to an internal proof dossier
does not qualify.  Packet-level
classes summarize the packet and never replace exact target classifications.
At packet level, `theorem_class` is a mathematical shape such as
`exact_identity`, `finite_remainder_bound`, `qualitative_support`,
`qualitative_bridge`, or `audit_regression`.  `mixed` is reserved for a packet
whose principal targets have more than one shape, such as a distinct exact
identity and finite bound.  `coverage_class` is a role such as
`infrastructure`, `exact_source_generic`,
`named_source_application`, or `audit_source_recovery`.  A source role may
never occupy the theorem-shape axis.

Each v2 example carries a machine-readable `registry_binding`.  `required`
means that the card registry must contain the ID with exactly those packet
classes; `illustrative` tests that a combination is representable without
requiring a registry row.  Validators derive that distinction from the JSON
rather than a hardcoded packet list.

## Pre-Lean gates

Implementation starts only after the externally recorded theorem-card,
natural-language-proof, applicable structural-circularity, and composite
`lean_ready` gates are resolved as specified below.

### Theorem-card review

Referees check the source identity, all quantifiers, exact mathematical target,
classifications, conventions, dependencies, and exact proposed Lean signatures.
The gate binds the theorem-card revision/digest recorded in the packet.

### Natural-language-proof review

Referees check that the proof plan actually reaches every target without assuming
the conclusion, citing missing infrastructure, confusing fixed and order-dependent
objects, or suppressing analytic side conditions.  The packet encodes this as
`applicability: required` or `applicability: not_applicable`; the latter always
includes a reason.  Definitions, audit-only targets, and transparent non-novel
wrappers around specifically bound pinned-library facts may use
`not_applicable`.  An external envelope then records the same applicability and
`gate_state: not_required`.  A merely short, plausible, or conditional proof is
not grounds for omitting the gate.

### `structural_circularity_review`

This independent gate checks the dependency graph and proof route for circular
identification, theorem-sized hypotheses, hidden choice, and construction or
continuation steps that already assume the desired object.  It records the
applicable perspectives from the controlled vocabulary.  It is required for a
packet that constructs or continues a named object, uses existence/uniqueness to
identify one, recovers a source theorem through a nontrivial bridge, or exposes
a hypothesis structure capable of containing the target conclusion.

A thin definition or direct pinned-library wrapper may declare
`applicability: not_applicable` only with a concrete reason.  The external
envelope then records `gate_state: not_required`; theorem-card referees must
confirm the classification.  Absence of a representable gate is never treated
as inapplicability.

### `lean_ready`

`lean_ready` is a composite authorization gate, not a referee verdict. It may be
set to `pass` in the external envelope only when:

- the packet is frozen and externally bound by digest;
- theorem-card and required natural-language-proof gates are `pass`;
- the structural-circularity gate is `pass` when required, or externally
  recorded `not_required` when the frozen packet justifies inapplicability;
- their distinct-reviewer and structural quorum rules are satisfied;
- referenced dependencies exist at the recorded revisions;
- no pre-Lean verdict is `request_changes` or `block`.

Changing the packet, theorem card, natural-language proof, source snapshot,
classification schema, dependency pin, or pre-Lean rubric invalidates
`lean_ready` and returns it to
`pending`.

## Reviewer quorum

The packet defines both numeric and structural requirements for every pre-Lean
gate and implementation rubric:

- `minimum_distinct_reviewer_ids` counts durable IDs, not review runs;
- `allowed_reviewer_compositions` lists acceptable numbers of human and agent
  reviewers;
- an agent composition may optionally require multiple distinct model IDs, but
  the default value `1` permits independent fresh sessions using the same model;
- proposer IDs never count;
- one reviewer may cover several rubrics, but only the packet's
  `overall_minimum_distinct_reviewer_ids` decides whether that is structurally
  sufficient.

The merger selects one allowed composition and verifies it exactly. “Two
reviews” from one ID, two aliases for the same agent run, or two verdicts from
one session count once. Two fresh sessions with distinct durable reviewer IDs may
count separately even when their model field is identical.

When the structural-circularity gate is required, its distinct-ID minimum and
required perspectives are additional to the theorem-card/proof minima.  The
packet may also require a larger overall union of distinct pre-Lean reviewers.
An external envelope records the actual reviewer union; candidate-owned names
or historical summaries never count.

## External review artifacts

Filled artifacts must live outside the candidate head. Acceptable locations are
a durable pull-request artifact/comment, a signed detached record, or a separate
evidence repository/object whose immutable reference is recorded. The templates
belong in the code repository; instantiated records judging that code do not.

### Review envelope

Create `templates/review_envelope.yaml` externally. It binds the specification,
upstream artifacts, classification schema, toolchain, candidate SHAs, pre-Lean gates, implementation
verdict references, and merge-gate state. It is an index, not a substitute for
the underlying signed or platform-attributed records.

### Proposer evidence

At the candidate head, attach externally:

- base/head SHAs and the review-envelope reference;
- changed files and public declarations;
- complete output from packet commands, builds, and linters;
- axiom reports for all changed public declarations;
- import/declaration dependencies and affected consumers;
- exact regression results and known limitations.

The proposer evidence is untrusted until a referee verifies it.

### Verdicts

Each referee instantiates `templates/verdict.json` outside the candidate head.
The verdict binds the external packet identity, exact upstream artifact digests,
candidate head, rubric revision, reviewer identity, runtime, and isolation
method. It contains one of:

- `approve`: no material issue in that rubric;
- `request_changes`: concrete fixable defects remain;
- `block`: the current packet cannot authorize the implementation, because of a
  source, trust, scope, or dependency defect requiring specification-level work.

### Disposition ledger

Instantiate `templates/disposition_ledger.yaml` outside the candidate head.
`fixed_pending_rereview` records a proposer claim, not resolution. A finding is
terminal only when a fresh verdict for the current head supports
`resolved_by_fresh_approval` or `withdrawn_by_referee`, or when a specification
owner records `packet_superseded` and the current review round stops.

## Isolation and untrusted inputs

Repository content, pull-request prose, comments, source docstrings, and proposer
evidence are untrusted data. They cannot change the rubric, output format,
allowed tools, or verdict. Text attempting to do so is itself a finding.

A manual reviewer records what was actually done. `manual_fresh_checkout` means
only that the reviewer attests to using a fresh checkout/context; it does not
prove exclusion of personal instructions, plugins, credentials, network access,
or writable paths. `technically_enforced` may be recorded only when a runner
technically enforced the boundaries described by `isolation_method`. This manual
protocol does not claim equivalence to Tau Ceti Review's clean-room runner.

Referees do not patch the candidate. Generated files required by checks go in a
disposable copy, and that method is recorded.

## Invalidation

- Any new candidate commit invalidates every implementation verdict and merge
  decision for the old head. New verdicts must name the new full SHA.
- Any change to packet content, theorem-card or natural-language-proof revision
  or digest, classification schema, source snapshot, Lean/Mathlib pin, or
  pre-Lean rubric invalidates all pre-Lean gates and `lean_ready`.
- Any rubric change invalidates verdicts produced under the earlier rubric
  revision.
- Old artifacts remain historical evidence but never count toward the new
  quorum. A referee may reuse investigation, not the old verdict.

## Strict merge rules

The external merge gate may be `pass` only when all of these hold for one exact
candidate head:

1. The review envelope binds a frozen, non-self-referential packet at an exact
   `spec_commit`, path, and SHA-256 digest.
2. Every referenced theorem card and required natural-language proof matches the
   revision/digest recorded in both packet and envelope.
3. Theorem-card review and every required natural-language-proof and
   structural-circularity review are `pass`; inapplicable gates are explicitly
   `not_required`; and `lean_ready` is `pass`, with all distinct-ID,
   perspective, and structural quorum rules satisfied.
4. The implemented declarations and exact signatures match every entry in the
   packet's `targets` list. Any extra hypothesis, hidden smaller domain, changed
   quantifier order, or altered normalization requires a new packet.
5. All affected maintained modules build on the recorded toolchain and resolved
   Mathlib commit; packet commands and required linters pass.
6. No `sorry`, `admit`, undeclared `axiom`, or unapproved trust extension occurs.
   Public-declaration axiom reports are within the exact packet allowlist.
7. Named objects have accepted domain-correct identifications, including branch,
   exceptional-value, convergence/integrability, regularity, and uniqueness
   obligations where relevant.
8. Every application-specific assumption and controlling constant has provenance
   from pinned Mathlib, an earlier accepted work item, or a declared external
   input. The desired conclusion has not been moved into a field or hypothesis.
9. Concrete applications establish required domain nonemptiness, bound
   nonnegativity, and specialization membership; conditional generic theorems
   are not reported as completed named applications.
10. Imports follow the permitted dependency layers, with no downstream-to-
    foundation edge or umbrella cycle.
11. Required regressions for constants, thresholds, branches, exceptional values,
    order zero, and small orders pass unchanged.
12. Every implementation rubric has its minimum distinct reviewer IDs and one
    allowed structural composition, all verdicts are `approve` at the candidate
    head, and the overall distinct-ID minimum is met.
13. Every finding has a terminal external disposition confirmed by a fresh
    verdict or packet supersession. No `request_changes` or `block` remains.

The merger records the passing envelope as a detached or platform-attributed
artifact. A filled merge record is never added to the candidate head it approves.

## Attribution

The separation between controlled roadmaps, implementation, and independent
rubric review is inspired by [Tau Ceti](https://github.com/TauCetiProject/TauCeti),
[Tau Ceti Roadmap](https://github.com/TauCetiProject/TauCetiRoadmap), and
[Tau Ceti Review](https://github.com/TauCetiProject/TauCetiReview). This is an
original manual-first adaptation. It does not copy Tau Ceti's runner and does not
claim that manual isolation attestations provide Tau Ceti's technical isolation.
