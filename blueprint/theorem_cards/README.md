# Theorem cards

**Normative owner:** `jaumededios`  
**Document specification status:** `frozen`  
**Baseline specification commit:** recorded externally after the specification
commit exists; it is never self-referentially written into that same commit.

A theorem card is the frozen scope and semantics for one bounded declaration
packet.  It is not a `sorry`-backed Lean interface and it is not authoritative
review evidence.

## Three classifications, two levels

The versioned vocabulary is
[`review/classifications-v1.yaml`](../../review/classifications-v1.yaml).  It
separates packet-level summary values from declaration-level target values.
Every card has three independent axes:

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
- `novelty_class` describes the relation to existing mathematics.  In
  particular, `non_novel` is canonical for routine definitions and elementary
  consequences, while `source_equivalent` requires a bound external source and
  never means merely “matches our internal proof.”

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
QB-001 revision 4 is `complete` and `frozen`, but externally unreviewed and
unauthorized.  Its revision-3 repository ledger is historical context and
counts as zero reviewers.  Manifest execution readiness never authorizes
implementation.
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
- external review-envelope references and implementation/audit evidence when
  those externally bound records exist;
- adversarial, boundary, and constant-regression tests.

Use `not_applicable` explicitly.  A named source application may not mark domain
reachability, majorant nonnegativity, or identification as not applicable.

## Review and authorization

Genuinely new mathematics needs a complete natural-language proof and two
independent external approvals before an envelope may set `lean_ready: pass`.
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
externally unreviewed and unauthorized.  The exact specification snapshot has
no DEF-001 implementation or prototype; bytes in another commit or dirty
worktree have no review status until an external envelope binds them.

Only the CSV inventory validator currently exists.  The YAML/Markdown schema,
lifecycle, classification, digest, and review-quorum validation described by
the blueprint remains manual/planned.
