# Theorem cards

**Normative owner:** `jaumededios`  
**Document specification status:** `frozen`  
**Baseline specification commit:** recorded externally after the specification
commit exists; it is never self-referentially written into that same commit.

A theorem card is the frozen scope and semantics for one bounded declaration
packet.  It is not a `sorry`-backed Lean interface and it is not authoritative
review evidence.

## Three classifications, two levels

The current versioned vocabulary is artifact revision 3 of
[`review/classifications-v3.json`](../../review/classifications-v3.json), which
supersedes without mutating immutable v2. Historical frozen artifacts retain
their recorded authority; the IMP R5 and QL/OLV R3 drafts bind v3. It
separates packet-level summary values from declaration-level target values.
Every card has three independent axes:

- `theorem_class` describes the mathematical shape, for example
  `foundational_calculus`, `definition_identification`,
  `exact_identity`, `finite_remainder_bound`, `existence_uniqueness`,
  `qualitative_support`, `qualitative_bridge`, or `audit_regression`.
  `mixed` applies only when principal targets span more than one shape.
- `coverage_class` describes the coverage claim:
  - `infrastructure`: no source-occurrence credit;
  - `entity_identification`: identifies an entity but covers no source theorem;
  - `exact_source_generic`: covers a source theorem quantified over generic
    data, such as Watson's lemma;
  - `named_source_application`: proves an estimate for an identified named
    function and discharges all generic hypotheses;
  - `audit_source_recovery`: derives the exact printed qualitative statement in
    `Audit/SourceRecovery`.
- `novelty_class` describes the relation to existing mathematics.  In
  particular, `non_novel` is canonical for routine definitions and elementary
  consequences, while `source_equivalent` requires a bound external source or
  pinned-library statement and never means merely “matches our internal proof.”

Each public target repeats exact target-level theorem, coverage, and novelty
values.  Packet summaries do not replace those rows or earn source credit.

`exact_source_generic` is not a named-function application.  Conversely, a
theorem mentioning a named function earns no source credit unless its occurrence
is in a closed manifest and reconciled.

## Orthogonal statuses

Do not use one overloaded `status`.  Cards use these axes:

| Axis | Vocabulary |
|---|---|
| `specification_status` | `draft`, `specified`, `frozen`, `superseded` |
| `proof_status` | `not_required`, `draft`, `complete`, `blocked` |
| `review_status` | `not_started`, `under_review`, `approved`, `changes_requested`, `blocked` |
| `implementation_status` | `not_started`, `authorized`, `in_progress`, `compiled`, `audited`, `released` |
| `prototype_status` | `absent`, `present_uncompiled`, `compiled_unreviewed` |
| `coverage_status` | `not_applicable`, `selected`, `transcribed`, `proved`, `reconciled` |
| `manifest_membership_status` | `planning_only`, `execution_ready`, `active`, `complete`, `superseded` |

Natural-language proof frontmatter records intrinsic `proof_status` directly.
Review and implementation fields in a candidate-owned card are temporal,
nonauthoritative projections; only an externally stored envelope and bound
verdicts can establish reviewer quorum, gate pass, or Lean authorization.
QB-001 card revision 7 and proof revision 6 are `complete`/`frozen` as
applicable, and their candidate-owned fields retain the pre-authorization
self-status.  Their revision-3 repository ledger is historical context and
counts as zero reviewers.  Separately stored external records later authorized
and accepted the exact BOOTSTRAP-0 implementation at commit
`515b742f7ad5472c17cfdf0fda7cbc83c5585da1`; manifest readiness alone did not
authorize that implementation.
Historical reports are preserved at private
[`review-evidence` commit `5c8ec1b`](https://github.com/jaumededios/LMLF/commit/5c8ec1b301f656df35ffa8850e002639807995cd),
but each record binds only its recorded commit and is not mutable status
authority.
`prototype_status` records code that exists outside the authorized lifecycle;
it never advances `implementation_status` or `review_status` by itself.

## Required fields

Each YAML card records:

- stable ID, normative owner, all three classifications, and every status axis;
- manifest membership and any source occurrence, notation, and source-entity
  IDs;
- packet-local concepts separately from source entities;
- exact imports and a reviewed public-signature artifact, including binder
  order;
- mathematical statement, normalization, domain, order, branch, derivative,
  and exceptional-value conventions;
- visible assumptions and the exact-source or named packet responsible for
  discharging them;
- majorant nonnegativity and domain reachability/nonemptiness obligations;
- dependency and downstream-consumer lists;
- novelty classification and natural-language proof artifact;
- exact natural-language-proof review applicability, with a reason and no empty
  proof artifact when it is `not_applicable`;
- external review-envelope references and implementation/audit evidence when
  those externally bound records exist;
- adversarial, boundary, and constant-regression tests.

Use `not_applicable` explicitly.  A named source application may not mark domain
reachability, majorant nonnegativity, or identification as not applicable.

## Review and authorization

Genuinely new mathematics needs a complete natural-language proof and multiple
independent proof/architecture approvals before exact Lean signature design.
The resulting signatures and theorem card then receive their own independent
reviews before an envelope may set `lean_ready: pass`.
Packets involving construction, continuation, identification through
existence/uniqueness, nontrivial source recovery, or theorem-sized hypothesis
structures require the separately represented `structural_circularity_review`.
Every packet marks that gate `required` or gives an exact
`not_applicable` reason.  Reports are independent and tied to the frozen
artifact revision.  A material edit resets affected external reviews.
Compilation does not substitute for review.

The baseline specification commit is added to an external review identity,
release record, or immutable ledger only after the commit has been created.  A
card may contain `pending_external_record_after_commit`; attempting to embed its
own commit hash would be self-referential.

## Bootstrap cards

- `QB-001.yaml` is a bounded, eight-declaration infrastructure packet.  Its
  exact signatures live in `QB-001-signatures.md`; additional results discussed
  in the proof dossier are future packets.
- `DEF-001.yaml` is a bounded reuse/identification audit for the current mathlib
  Gamma object.

The corresponding frozen, bounded execution specifications are
`review/work_packets/QB-001.yaml` and `review/work_packets/DEF-001.yaml`.
Neither packet self-certifies a passing gate.  QB-001 has a complete frozen
proof, while DEF-001 has no natural-language-proof requirement.  Both are
immutable specifications whose own fields record the earlier unreviewed and
unauthorized state.  The exact specification snapshot has no DEF-001
implementation or prototype; its later external envelope and implementation
reviews bind and accept commit
`515b742f7ad5472c17cfdf0fda7cbc83c5585da1` without rewriting the frozen card.

## Unregistered planning cards

`IMP-001.yaml`, `OLV-002.yaml`, `DEF-BERN-001.yaml`, and
`DEF-BERN-002.yaml` are planning artifacts, not registry entries or manifest
members. IMP-001 revision 5 has eight prospective integration targets justified
by the QL/OLV consumer chain rather than a schema limit. The immutable
[revision-3 exact-signature proposal](IMP-001-signatures.md) and its historical
reviews are superseded, changes-requested evidence; they are not R5 input.
No R5 proof/card/signature review or authorization exists. QL-001 and OLV-001
revision 3 are registered planning drafts with complete author proofs, likewise
without current review quorum, exact signatures, or Lean authorization.
OLV-002 revision 2 has a complete draft proof.
DEF-BERN-001 revision 1 and DEF-BERN-002 revision 1 are declaration-free and
have complete draft identification proofs, respectively covering the
number/polynomial normalization and the existing periodized object. Two
independent fresh-context reviews approve the exact DEF-BERN-002 mathematical,
source, and reuse content at commit `67600aaae94708006f1160e53f7d7ffc63d416d2`;
the upstream DEF-BERN-001 acceptance, frozen packet, external envelope, and
registry/status work remain outstanding. None has exact implementation
authorization merely because its file exists.

Only the CSV inventory validator currently exists.  It consumes v2 packet
classification enums and derives required registry rows from each example's
`registry_binding`; CI runs positive and negative suites.  The
YAML/Markdown lifecycle, target-level card/packet joins, digest, and review-
quorum validation described by the blueprint remains manual/planned.
