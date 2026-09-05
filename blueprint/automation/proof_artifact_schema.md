# Natural-language proof and review artifact schema

**Status:** schema design for future packets; no lifecycle automation is
implemented or authorized

**Format:** Markdown with machine-readable YAML frontmatter

**Principle:** a proof artifact is a complete, immutable mathematical argument
bound to exact targets; review approval is a separate external fact

This schema makes the roadmap's proof-before-Lean rule testable without
pretending that schema validation proves mathematics.  It applies to new
mathematics: new explicit constants or thresholds, strengthened uniformity or
derivative conclusions, continuation or exceptional-value arguments, normal
forms, stability theorems, and results not directly recoverable from the locked
source or pinned Mathlib.

Routine reuse wrappers may record `proof_status: not_required` in their theorem
card and work packet with an explicit reason.  In that case there is no empty
proof artifact.  An artifact that exists must contain an argument.

## 1. Artifact graph and storage boundary

```text
source snapshots + inventories
          |
          v
theorem card + exact signature artifact
          |
          v
natural-language proof revision
          |
          v
frozen work packet
          |
          v
external review envelope
   |                 |
   v                 v
pre-Lean verdicts    later candidate implementation verdicts
   |                 |
   +-------> external disposition ledger
                         |
                         v
                  external merge decision
```

The theorem card, proof, signature artifact, packet template/packet, and human-
readable design documents may live in the specification repository.  A frozen
work packet does not contain its own path, commit, or digest.  The external
review envelope binds those after the specification commit exists.

Filled verdicts, review envelopes judging a candidate, disposition ledgers, and
merge decisions live outside the candidate head.  A repository review summary
may describe history, but it is not quorum evidence unless the governing
protocol explicitly binds it as an immutable external record.

## 2. Identity and digest rules

Each proof has:

- a stable `artifact_id`, conventionally `NLP-<work-item>-R<revision>`;
- the stable `work_item_id` it supports;
- a positive integer `revision`;
- an `artifact_state` of `draft`, `frozen`, or `superseded`; and
- a `proof_status` from the theorem-card vocabulary: `draft`, `complete`,
  `under_review`, `approved`, or `blocked`.

`artifact_state` concerns byte immutability.  `proof_status` concerns the
mathematical/review lifecycle.  They are not interchangeable.  A proof is
normally `frozen` before its status becomes `under_review` or `approved`.

The proof does not contain its own SHA-256 or commit.  After freezing, its exact
stored bytes are hashed with ordinary SHA-256 and the digest is recorded in the
work packet and external envelope.  Newlines and frontmatter are part of those
bytes; “editorial-only” edits invalidate the digest.  No canonicalization step
is inferred unless a future schema explicitly defines one.

A mathematical or editorial change creates a new revision.  The preceding
artifact stays available as superseded historical evidence.  It is never
silently overwritten while retaining its approvals.

## 3. Frontmatter schema

The target shape is:

```yaml
---
schema_version: nl-proof-v1
artifact_id: NLP-QC-001-R1
work_item_id: QC-001
title: Explicit Cauchy transport for finite remainders
owner: REPLACE_WITH_NORMATIVE_OWNER
revision: 1
artifact_state: draft        # draft | frozen | superseded
proof_status: draft          # draft | complete | under_review | approved | blocked

theorem_card_bindings:
  - card_id: QC-001
    card_revision: 1
    signature_artifact_id: SIG-QC-001-R1

target_bindings:
  - target_id: QC-001-T01
    declaration: QuantitativeAnalysis.errorOn_iteratedDeriv_of_disks
    proof_section: target-qc-001-t01
    theorem_class: generic_quantitative
    coverage_class: reusable_infrastructure

source_bindings:
  occurrences: []
  entities: []
  notations: []
  snapshots: []

dependency_bindings:
  mathlib_revision: REPLACE_WITH_RESOLVED_FULL_SHA
  accepted_work_items:
    - work_item_id: QB-001
      declaration: QuantitativeAnalysis.ErrorOn
      accepted_commit: REPLACE_WITH_FULL_SHA

supersedes: null
approved_by: []              # convenience summary only; external verdicts are authoritative
---
```

This is illustrative data, not an authorized QC-001 card or theorem signature.

### 3.1 Required frontmatter fields

At `frozen` state the artifact requires:

- known `schema_version`;
- globally unique `artifact_id` and matching positive `revision` suffix;
- `work_item_id`, title, normative owner, `artifact_state`, and `proof_status`;
- every theorem-card revision and signature artifact used;
- every target ID, qualified declaration, exact body anchor, theorem class, and
  coverage class;
- source occurrence/entity/notation/snapshot IDs, even when their lists are
  explicitly empty for infrastructure;
- exact resolved Mathlib revision;
- every accepted project dependency with declaration and accepted commit;
- `supersedes`, either null for revision one or the exact prior artifact ID; and
- `approved_by`, empty until external approvals exist and nonauthoritative even
  after it is populated in a later metadata-only successor.

An artifact never names a target missing from its theorem card.  A card can bind
several proof artifacts only when its target-to-section mapping makes the split
complete and nonoverlapping.

### 3.2 Legacy artifacts

Already frozen proof artifacts such as QB-001 remain interpreted under their
recorded format and external bindings.  They are not edited merely to adopt
`nl-proof-v1`, because that would invalidate their digests and approvals.  Any
substantive successor uses this schema or the then-current reviewed version.
The contract linter therefore supports explicit legacy versions; it does not
quietly treat missing new fields as present.

## 4. Required proof body

Headings may include explanatory text, but each mandatory section has a stable
anchor and machine-readable tables where specified.

### 4.1 Scope and exact target map

For every `target_id`, state:

- all quantifiers in order and which data are uniform;
- the complete mathematical conclusion;
- exact approximant and order convention;
- domain, thresholds, derivative variable and scaling;
- branches, normalization, exceptional values, and totalization behavior; and
- theorem, coverage, and novelty classifications with a short justification.

The map distinguishes proved targets from background definitions and from
corollaries excluded from the work packet.  A proof dossier may discuss future
results, but only bound target sections are normative.

### 4.2 Source and named-object reconciliation

For a source-bearing target, reproduce or precisely bind the collated source
statement and explain every reformulation.  Resolve printed notation through
the inventory and identify all named functions through accepted entity cards.

For a strengthening or generalization, say exactly what is new and give the
route recovering the printed source theorem.  A generic conditional result must
not be narrated as a named-function application.

For infrastructure with no source occurrence, state that it earns no source
coverage.  Do not invent an Olver entity for a packet-local predicate.

### 4.3 Standing assumptions and quantifier ledger

Use a table with at least these columns:

| ID | Binder/data | Type | Quantifier position | Depends on | Mathematical role |
|---|---|---|---:|---|---|

The ledger must make visible whether a target function is fixed across all
orders, whether a radius or threshold depends on the center/order/parameter,
and which bounds are uniform.  It lists typeclass assumptions separately from
analytic hypotheses.

### 4.4 Dependency ledger

Every non-elementary step cites one of:

- a pinned Mathlib declaration with exact import and resolved revision;
- an accepted project declaration with work-item ID and commit;
- a directly collated external theorem with its complete consumed statement; or
- an internal lemma proved in a bound section of this artifact.

The ledger records the orientation and exact part used.  “Standard,” “by
compactness,” “by asymptotics,” “by Cauchy,” or “by stability” is not a
dependency.

A dependency may not be a future packet, a `sorry` skeleton, an unreviewed
prototype, or a structure field equivalent to the desired conclusion.

### 4.5 Exact identities

Before inequalities, prove the finite algebra used by the target:

- additive/product decompositions;
- finite-sum splits, shifts, endpoint terms, and coefficient recurrences;
- differential-operator and residual identities;
- chain/product/coordinate transformations;
- normalization, Wronskian, or integral identities; and
- coefficient cancellations in the exact coefficient ring.

Each identity gets a stable step ID such as `QC-001-I03`.  Later estimates cite
that ID.  A residual identity is not described as a solution approximation.

### 4.6 Analytic side-condition ledger

Every use of a totalized or analytic operation is justified.  Record:

| Side-condition ID | Exact proposition | Needed by step/target | Proof or dependency | Status |
|---|---|---|---|---|

Typical entries are set membership/inclusion, domain nonemptiness, radius
positivity, disk or contour containment, differentiability, analyticity,
continuity on a closure, integrability, nonvanishing, denominator margin,
branch avoidance, endpoint behavior, and parameter regularity.

For Cauchy transport, the ledger includes the boundary-sphere estimate and any
boundary-to-center weight comparison.  For ODE work, it separately lists
existence, normalization, uniqueness, and stability.  For named applications,
domain reachability and majorant nonnegativity cannot be omitted.

### 4.7 Estimate and constant-loss ledger

Each inequality is derived line by line from exact identities and cited bounds.
Every controlling quantity receives an entry:

| Loss ID | Expression before | Applied fact | Side conditions | Expression after | Natural or weakened |
|---|---|---|---|---|---|

The ledger exposes factorials, powers, geometric margins, operator norms,
envelopes, supremum/integral bounds, and threshold changes.  The natural bound
comes first.  Optional simpler rational or closed-form corollaries are marked
`weakened` and proved separately.

An existential constant, an unevaluated control integral that determines the
headline estimate, or an unspecified eventual threshold does not satisfy the
ledger.  Exact elementary expressions need not be converted to decimals.

### 4.8 Target proofs

Each frontmatter `proof_section` is a complete argument for exactly one target
or an explicitly enumerated coherent group.  It cites identities, side
conditions, losses, and accepted dependencies by stable IDs.

The last paragraph reconstructs the target's quantifier order and conclusion,
so a reviewer can see that no hypothesis was lost and no smaller domain was
used.  If the proof establishes a stronger intermediate statement, it explicitly
derives the frozen target.

### 4.9 Boundary and adversarial cases

Every artifact tests relevant cases, including:

- empty generic domains versus inhabited concrete applications;
- order zero, first nontrivial order, small orders, vanishing coefficients, and
  terminating expansions;
- endpoints and strict versus weak inequalities;
- zero denominators, poles, cuts, removable singularities, and totalization;
- branch and orientation changes;
- spatial versus parameter derivatives;
- cancellation or zeros of a leading approximation;
- fixed-solution versus order-dependent-solution quantifiers; and
- an explicit false nearby statement or counterexample.

The proof explains why the target survives each applicable case.  “Handled by
Lean” is not an analysis.

### 4.10 Hypothesis- and choice-laundering audit

List each substantial hypothesis and show why it is legitimate input for the
target classification.  For a named application, name the accepted theorem
that discharges it.  A card remains conditional if a model bound, contour,
normalization, path, or stability result is still assumed.

If choice occurs, prove existence and the uniqueness or characterization needed
downstream before selecting the object.  State why the choice cannot select a
different target at each truncation order.

### 4.11 Regression obligations

List exact planned theorem regressions and what each protects:

- signatures and binder order;
- constants, domains, and thresholds;
- source normalization and exceptional values;
- order-zero/small-order algebra;
- negative examples and expected tactic failures; and
- axiom/import boundaries.

An adversarial example in prose is still required even when a future Lean test
will encode it.

### 4.12 Trust, imports, and exclusions

State the narrow intended imports, public/private boundary, and allowed
foundational axioms.  Explain any noncomputability or choice without confusing
it with an axiom.

Every artifact repeats the relevant project exclusions: no floating-point or
interval proof, numerical evaluator, tolerance selection, adaptive truncation,
quadrature, solver, or external numerical certificate.  Use of exact rational
arithmetic in a proof is not numerical automation.

## 5. Completeness by target class

The base sections above are mandatory; these additions depend on target shape.

| Target class | Additional required content |
|---|---|
| Definition/identification | construction, familiar specification, validity, regularity, uniqueness, normalization, real agreement, exceptions, independent audit identity |
| Finite remainder bound | exact remainder identity, majorant provenance/sign, order/domain/threshold, natural and weakened bounds |
| Complex derivative transport | chosen radius, disk geometry, boundary estimate, factorial/radius loss, real restriction if used |
| Integral/summation | precise integral semantics, integrability, endpoints/orientation, boundary terms, exact tail or remainder |
| ODE solution estimate | operator transform, residual identity and bound, actual solution, normalization, existence, uniqueness, stability |
| Named application | accepted identification, all generic hypotheses discharged, reachable domain, nonnegative majorant, source reconciliation |
| Zero/connection theorem | local/global distinction, normalization/basis compatibility, nondegeneracy or counting, scale-sensitive estimates |
| Tactic packet | separate automation contract, readiness consumers, rule provenance, emitted obligations, failure classes, trust story |

If a field is genuinely inapplicable, the proof says why.  Silence is not
`not_applicable`.

## 6. Lifecycle

### 6.1 Authoring

1. The owner creates revision 1 with `artifact_state: draft` and
   `proof_status: draft`.
2. Contract lint runs at `draft` level.  It may check shape and references but
   cannot pronounce the proof correct.
3. When every target and mandatory section is complete, the owner sets
   `proof_status: complete`.
4. The artifact is frozen in a specification commit.  Its bytes no longer
   change and `artifact_state` becomes `frozen` before the externally bound
   review round begins.

Changing the file to update status after its digest is bound is itself a new
revision.  Operational systems should therefore prefer external status records
once freezing occurs.

### 6.2 Pre-Lean review

The external review envelope binds the specification commit, work packet, card,
signature, proof revision, and all digests.  Independent reviewers receive the
same frozen artifacts.

For new quantitative mathematics, the minimum composition is:

- one source/semantics review, checking source occurrence, notation, named
  objects, normalization, branches, exceptions, and quantifiers; and
- one proof/quantitative review, independently re-deriving exact identities,
  constants, domains, side conditions, and adversarial cases.

At least two distinct durable reviewer IDs are required, subject to the exact
work-packet quorum.  Definition/continuation, named-function construction,
turning-point, zero, and connection work also requires the third
structural/circularity review specified by the roadmap.  A reviewer may cover
multiple rubrics only if the packet's overall distinct-ID rule still passes.

Reviewers do not edit the artifact they judge.  Their verdicts use
`review/templates/verdict.json`, live outside the candidate head, and record
actual model/runtime/isolation metadata.  Two runs under one ID or session count
once.

### 6.3 Changes requested

A material finding leaves the gate nonpassing.  The owner creates a new proof
revision, updates every affected card/signature/dependency binding, and freezes
new bytes.  The old proof is superseded; old approvals remain history and count
zero toward the new quorum.

`fixed_pending_rereview` is a proposer claim in the external disposition ledger,
not resolution.  Only a fresh verdict on the current binding can resolve or
withdraw a finding.

### 6.4 Approval and `lean_ready`

When all required external verdicts approve the same frozen revision, the
external proof gate may become `pass`; the card's review summaries may later be
updated only through the project's versioned metadata policy.  Proof approval
does not authorize more declarations than the frozen target list.

`lean_ready` is a composite external authorization.  It additionally requires a
frozen packet, theorem-card review, dependency availability, structural quorum,
and no outstanding `request_changes` or `block`.  It is not a reviewer verdict
and not an implementation approval after code changes.

### 6.5 Implementation feedback

Lean elaboration may reveal a missing assumption, false identity, wrong import,
or awkward signature.  If the mathematical statement or proof changes, return
to a new proof/card revision and repeat pre-Lean review.  The implementer may not
add a premise or shrink a domain only in Lean.

Proof-preserving implementation choices do not edit the frozen natural-language
artifact.  Implementation verdicts bind the exact candidate head separately.

### 6.6 Release and supersession

Release requires candidate builds, regressions, import/axiom audits, external
implementation approvals, terminal dispositions, and any source reconciliation.
The proof artifact remains frozen evidence for that released declaration.

A later theorem revision supersedes rather than erases it.  Releases record
which exact proof artifact and review envelope they used.

## 7. Invalidation matrix

| Change | Proof approvals | `lean_ready` | Implementation verdicts | Required action |
|---|---|---|---|---|
| proof bytes or revision | invalid | invalid | invalid if target evidence changes | new artifact and full bound review |
| theorem card or signature | invalid | invalid | invalid | new card/proof bindings and review |
| source snapshot/transcription | invalid for affected targets | invalid | invalid | recollate and rereview |
| accepted dependency/pin | invalid | invalid | invalid | re-audit proof and implementation |
| pre-Lean rubric | invalid | invalid | unchanged only if genuinely unrelated and protocol permits | fresh pre-Lean verdicts |
| candidate head only | unchanged | unchanged | invalid | rerun implementation review |
| prose in external verdict | old verdict replaced, not edited in place | recompute gate | as applicable | issue a new immutable record |

Historical evidence is retained but never counted at the new binding.

## 8. Review-artifact minimum content

The existing verdict template remains normative.  For a natural-language proof
review, each verdict additionally makes evident in its inspected-files and
findings fields:

- exact proof artifact ID, revision, and SHA-256;
- all target IDs reviewed;
- source/card/signature/dependency bindings checked;
- rubric and rubric revision;
- whether constants were independently recalculated;
- which edge and adversarial cases were inspected;
- reviewer durable ID, kind, model/runtime, isolation strength and method; and
- `approve`, `request_changes`, or `block`, with actionable findings.

An `approve` verdict has an empty findings list.  A report that only says “Lean
will check it” cannot approve a natural-language proof.

## 9. Lintable completeness versus mathematical approval

The contract linter may establish that all sections, IDs, bindings, tables, and
statuses exist and agree.  It may detect a missing radius row or a digest
mismatch.  It cannot establish that a contour really lies in the domain, that a
constant follows from the preceding inequality, or that an IVP identifies Airy
Ai.  Those are the reasons for independent proof and source review.

Conversely, a persuasive review does not excuse a broken binding.  Mathematical
approval and artifact integrity are both necessary and neither substitutes for
the other.

## 10. No automated proof or review generation

The schema supports authoring and checking; it does not authorize a system to
generate a proof, fill a missing source transcription, assign an approval, or
advance a card.  Future tooling may present fields or compute ordinary digests.
Every mathematical assertion and every review verdict remains an explicitly
owned artifact.

No part of this lifecycle introduces numerical evaluation, interval
certificates, floating-point tolerances, adaptive order selection, or numerical
solvers.  The artifacts describe exact mathematics and its review history.
