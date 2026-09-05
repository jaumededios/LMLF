# Theorem cards

**Normative owner:** `jaumededios`  
**Document specification status:** `specified`  
**Baseline specification commit:** recorded externally after the specification
commit exists; it is never self-referentially written into that same commit.

A theorem card is the frozen scope, semantics, and review record for one bounded
declaration packet.  It is not a `sorry`-backed Lean interface.

## Two classifications, not one

Every card has independent fields:

- `theorem_class` describes the mathematical shape, for example
  `foundational_calculus`, `definition_identification`,
  `finite_remainder_bound`, `existence_uniqueness`, or `qualitative_bridge`.
- `coverage_class` describes the coverage claim:
  - `infrastructure`: no source-occurrence credit;
  - `entity_identification`: identifies an entity but covers no source theorem;
  - `exact_source_generic`: covers a source theorem quantified over generic
    data, such as Watson's lemma;
  - `named_source_application`: proves an estimate for an identified named
    function and discharges all generic hypotheses;
  - `audit_source_recovery`: derives the exact printed qualitative statement in
    `Audit/SourceRecovery`.

`exact_source_generic` is not a named-function application.  Conversely, a
theorem mentioning a named function earns no source credit unless its occurrence
is in a closed manifest and reconciled.

## Orthogonal statuses

Do not use one overloaded `status`.  Cards use these axes:

| Axis | Vocabulary |
|---|---|
| `specification_status` | `draft`, `specified`, `frozen`, `superseded` |
| `proof_status` | `not_required`, `draft`, `complete`, `under_review`, `approved`, `blocked` |
| `review_status` | `not_started`, `under_review`, `approved`, `changes_requested`, `blocked` |
| `implementation_status` | `not_started`, `authorized`, `in_progress`, `compiled`, `audited`, `released` |
| `prototype_status` | `absent`, `present_uncompiled`, `compiled_unreviewed` |
| `coverage_status` | `not_applicable`, `selected`, `transcribed`, `proved`, `reconciled` |
| `manifest_membership_status` | `planning_only`, `execution_ready`, `active`, `complete`, `superseded` |

Natural-language proof frontmatter records `proof_status` directly.  QB-001
revision 3 is currently `approved` by the distinct reviewers `proof_referee_a`
and `proof_referee_b`; its card is also `proof_status: approved`,
`review_status: approved`, and `implementation_status: authorized`.  This
authorization covers only the eight frozen signatures.  In general, manifest
execution readiness does not by itself authorize implementation.
`prototype_status` records code that exists outside the authorized lifecycle;
it never advances `implementation_status` or `review_status` by itself.

## Required fields

Each YAML card records:

- stable ID, normative owner, both classifications, and every status axis;
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
- independent reviews and implementation/audit evidence;
- adversarial, boundary, and constant-regression tests.

Use `not_applicable` explicitly.  A named source application may not mark domain
reachability, majorant nonnegativity, or identification as not applicable.

## Review and authorization

Genuinely new mathematics needs a complete natural-language proof and two
independent approvals before `implementation_status` becomes `authorized`.
Definition/continuation, transition, zero, and connection packets require the
additional structural review stated by the roadmap.  Reports are independent
and tied to the frozen artifact revision.  A material edit resets affected
reviews.  Compilation does not substitute for review.

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

The corresponding frozen execution packets are
`review/work_packets/QB-001.yaml` and `review/work_packets/DEF-001.yaml`.
QB-001 is Lean-ready after its two proof/card approvals; DEF-001 has no
natural-language proof requirement but its card and implementation reviews are
still pending.  A matching DEF-001 Lean prototype exists and builds, but its
status is `compiled_unreviewed`; it is not authorized, approved, or released.
