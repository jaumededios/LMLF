# E0 exact-binding repair design 01 — proposed, unreviewed

## Status and boundary

This is a bounded architecture proposal subordinate to accepted `stage1-companion-schema-design-draft-04.md`, exact SHA-256 `e3dacb11c97ec059ae8f48e3fc81f3155fbf86c2cd5679c69541852c2d1fdc7b`.
It addresses referee-B findings G1 and G4 against rejected candidate HEAD `26f4051e13f3a7bc558c225138458f211bf31597`.
It is not an approval, source census, rights determination, review result, quorum result, authority fold, card, proof, signature, coverage claim, or production selection.
E0 additions remain small `FX-` synthetic fixtures only. Real source payloads, real notice evidence, rights approval, and production IDs remain E1 work after an E0 repair is accepted.
The validator checks closed types, exact bytes, reachability, and finite set equality only. Source truth, source exhaustiveness, mathematical completeness, reviewer independence, review passage, quorum, and effective authority remain manual.

## Design rule: identities form a one-way exact-byte DAG

SHA-256 means ordinary SHA-256 of the raw stored bytes. JSON parsing never supplies an alternative semantic identity; whitespace, key order, Unicode spelling, and line endings matter.
No object contains its own digest, directly or transitively. Artifact paths are bounded-root locators, not identities. Each reference carries `(record_kind, artifact_id, exact_sha256)` and must resolve to bytes declaring the same kind and ID.

Source/core tables are immutable inputs to a later manifest. Locator, witness, role, gate, and authority-binding tables are not members of that core table set.
In particular, `audit_batches.csv` must not contain a witness ID or witness digest. This removes the rejected cycle:

```text
batch manifest -> audit_batches witness hash -> witness -> batch manifest digest
```

The replacement order is:

```text
raw source/notice bytes       schema table/field descriptor bytes
          |                                  |
          v                                  v
payload/rights records             schema-set descriptor
          \                                  /
           v                                v
          immutable source/core CSV bytes
                         |
                         v
              source-core manifest
                         |
source artifact locators + exact located bytes
                         |
                         v
              batch-closure witness
                         |
                         v
       review verdicts / catalog / root selection
```

Gate binding is a separate downstream DAG:

```text
card + source-facing target + exact-signature packet
                         |
                         v
              pre-signature subject set
                    /             \
       raw proof Markdown      typed review records
                    \             /
                     v           v
                    gate bundle
                         |
                         v
             exact-signature role binding
```

An exact-signature packet may bind its cards, targets, declarations, and dependencies. It must not name or hash the gate bundle, subject set, verdicts, or the role row that later selects it.
## Small finite file and field delta

### Existing normalized files

1. Change `audit_batches.csv` to `(schema_version, schema_set_id, snapshot_id, batch_id, batch_revision, source_view_id, classification_view_id)`. Remove both synthetic-witness columns.

2. Change `payload_evidence.csv`: remove `artifact_path`; retain `exact_sha256`, and add `byte_length`, `rights_record_id`, and `rights_record_sha256`.

3. Keep `artifact_bindings.csv` as a later bounded-root locator table. Add closed kinds for
   schema descriptors, rights records/notices, raw payloads, core manifests, closure witnesses,
   proof bodies/metadata, pre-signature subject sets, gate records, verdicts, and bundles.
   A locator row's digest must equal both the referenced subject digest and the located bytes.

4. Change `role_bindings.csv` only as needed to point to the exact gate bundle and enforce the level rules below. It is not included in a source-core manifest.

### New normalized file

5. Add `source_spans.csv` with exact header `(schema_version, schema_set_id, snapshot_id, subject_kind, subject_id, span_ordinal, payload_evidence_id, byte_start_inclusive, byte_end_exclusive)`.

`subject_kind` is closed to `document_item`, `appearance`, or `claim`. Ordinals are contiguous positive integers per typed subject. Ranges are integers satisfying `0 <= start < end <= byte_length`; overlap is allowed only when two typed subjects genuinely cite the same bytes.

Every document item and claim has at least one span; an appearance span is optional but checked if supplied. Its payload evidence must be reachable through a representation and retrieval owned by the same exact document, snapshot, and schema set. Because every leaf owns an item, every source-owning leaf reaches actual checked payload bytes. Claims receive finite occurrence-specific evidence without duplicating the item and claim spans again at the appearance level.

### New strict-JSON artifact kinds

6. `schema_set_descriptor` declares its ID, `schema_set_id`, schema revision, and the exact IDs, kinds, and digests of `schema-tables.csv` and `schema-fields.csv`. Every supplied row's `schema_set_id` must resolve to this descriptor; an unknown renamed production-shaped ID fails.

7. `rights_record` declares its ID, source name, contemplated-use token, retention token, notice-evidence ID/kind/digest, notice retrieval time, and a nonempty manual-review note. E0 checks only exact binding and closed values. The E0 positive uses an `FX-` notice. E1 can later bind a limited internal exact notice copy without copying or fetching a real source for this E0 repair.

8. `source_core_manifest` declares its ID, schema-set descriptor triple, and a path-sorted array
of `(relative_path, record_family, exact_sha256)` for exactly the finite source/core CSV set.
It does not list itself, `artifact_bindings.csv`, `role_bindings.csv`, `validation_levels.csv`,
any witness, gate file, verdict, authority record, or authority index.

The core set is the supplied snapshot/evidence identities; source structure and spans; audit
issues/events, batch/scope/projections, and source views; notation/entity/context memberships;
and source-semantics rows. The validator compares the member path set exactly, not as a subset.

9. `batch_closure_witness` declares its ID, synthetic boolean, source-core manifest triple,
schema-set descriptor triple, exact batch ID/revision, snapshot, source view, classification view,
and the exact closure projections:

- ordered scope subjects;
- ordered document, leaf, appearance, and all-claim ID sets;
- ordered claim-ID sets for all four claim kinds;
- ordered candidate atom IDs; and
- ordered noncandidate claim IDs.

It also lists the exact payload-evidence and rights-record triples reached by that closure.
The validator derives every set from the manifest-bound core bytes and requires equality.
Fidelity roles, exclusion/resolution decisions, and classifications need not be copied into the
witness: their exact rows are fixed by the core manifest, while the witness fixes the affected IDs.

10. `pre_signature_subject_set` is one finite subject for one exact claim and requested
`exact-signature-binding`. It declares the batch-closure-witness triple and an ordered role array.
Each role entry contains the claim ID, role/subtype, frozen-card triple, source-facing-target
triple, declaration ID, and exact-signature-packet triple. Its role set must equal the roles
required for that claim; quantitative producer and recovery endpoints remain distinct.

11. `natural_language_proof_metadata` declares its ID, the subject-set triple, raw Markdown body
ID/kind/digest, and the ordered role keys that body claims to cover. The body is a nonempty regular
file below the bounded artifact root; its raw bytes, not rendered or normalized Markdown, are hashed.
Across the bundle's proof metadata, covered role keys must equal the subject set, with no unknown
claim or endpoint. E0 does not judge whether the prose is genuinely complete or correct.

12. Replace subjectless reviewed-gate artifacts with closed `gate_review_record` JSON. Each record
declares gate kind, applicability, gate state, subject-set triple, proof-metadata triples when
applicable, required controlled perspectives, and applicability reason when `not_required`.

13. Close `reviewer_verdict`: require string-valued protocol enums and exact reviewer identity;
require its `(subject_kind, subject_id, subject_sha256)` to match the gate record it judges.
The gate bundle lists exact gate-record and verdict triples and the exact reviewer IDs named by
those verdicts. E0 checks correspondence, not independence, passage, perspective sufficiency, or
quorum.

14. `pre_signature_gate_bundle` declares its own ID, the exact subject-set triple, proof metadata
and body triples, gate-record triples, and reviewer-verdict triples. It does not hash itself.
A role row may use the bundle only when the bundle's subject set exactly contains that row and the
entire required role set for its claim. Different claims therefore cannot reuse a subjectless bundle.

## Authority subjects

Keep the accepted finite ordered-index/backward-edge grammar. Add `subject_sha256` everywhere an
event, catalog member, root selection, or reviewer verdict names a subject, and close allowed
subject kinds for this repair.

Source/classification decisions and the synthetic root selection use the exact
`batch_closure_witness` triple as their subject. That witness transitively fixes the schema set,
source/core table bytes, payload evidence, rights record, full ownership closure, source view,
classification view, candidates, and excluded/noncandidate claims.

The authority validator requires every subject triple to resolve, every bound verdict's declared
reviewer ID to equal the enclosing reviewer ID, and every verdict subject triple to equal the
event/selection subject it supports. An unrelated or merely same-named subject is rejected.

The ordered authority index still never indexes itself. Its digest remains bound by a separate
external envelope. E0 does not compute which event is effective and does not turn a structurally
valid synthetic selection into production authority.

## Validation-level interpretation

A request may supply only one validation level. It must satisfy that level's complete obligations;
the validator must not require duplicate lower-level rows merely as history.

At `source-batch`, every required role exists. Card and declaration endpoints are independently
`pending` (empty) or `supplied` with typed IDs and, if present, exact artifact references consistent
with the claim/role. A supplied artifact may intrinsically describe itself as draft or frozen; that
metadata remains checkable, but this row's state stays `supplied` and grants no freezing, approval,
or selection. A `bound` endpoint claim, required frozen target, exact-signature semantics, signature
packet, and gate bundle are forbidden at this level. This preserves typed-supplied-endpoint controls.

At `card-binding`, the same requested row itself binds the exact frozen-card and source-facing-target
bytes. A declaration is pending or a typed proposed ID with a nonbinding sketch; no exact-signature
or gate claim is permitted.

At `exact-signature-binding`, the requested row itself binds the frozen card/target, exact declaration
in the exact packet, subject set, and gate bundle. A separate `source-batch` or `card-binding` row is
not required. If several levels are simultaneously supplied, shared logical endpoint IDs must agree;
the earlier level's absence of a digest is not freezing, and a later digest does not retroactively
make the earlier row frozen.

## One complete synthetic dependency chain

```text
FX payload bytes
 -> FX-PE1 digest/length
 -> FX-REP1 -> FX-RET1 -> FX-PE1
 -> FX item/appearance/claim byte spans
 -> exact source/core CSV members
 -> FX-CORE-MANIFEST-1
 -> FX-BATCH-CLOSURE-1 for FX-B4.1 revision 1
 -> exact source/classification verdict subjects
 -> FX catalog -> FX root selection

FX-O-CARD + FX-TARGET-O + FX-SIGNATURE-PACKET-1
 -> FX-O-SUBJECT-SET-1
FX proof.md -> FX-O-PROOF-METADATA-1 -> typed gate reviews/verdicts
 -> FX-O-GATE-BUNDLE-1
 -> FX-O1 exact-signature role binding
```

## Required focused tests

Positive: one all-`FX-` batch resolves both schema descriptors, an `FX-` rights notice, every in-scope
document through representation/retrieval/payload, and every required item/claim through bounded
byte spans. Recomputed closure and candidates exactly match the witness; authority and gate subjects
resolve; ordinary and two-role quantitative exact-signature rows pass without duplicate lower rows.

Negative source/evidence tests:

- remove all representation/retrieval/evidence rows, remove one document's chain, use another
  document's payload, omit a span, use an out-of-range span, or escape/symlink the artifact root;
- change one raw source byte under the old digest; then update only its evidence digest; then update
  the core manifest but not the closure witness; each stage fails at its first stale exact binding;
- whitespace-change a schema descriptor or rights record/notice, use an unknown schema-set ID, use
  a notice digest of the wrong kind, or let a payload omit its exact rights-record reference.

Negative closure/authority tests:

- independently add or alter a noncandidate reference/provisional/remainder claim inside selected
  scope while leaving candidates unchanged: stale core manifest fails; after rehashing it, stale
  closure witness fails; after rehashing that, the old verdict/root-selection subject fails;
- independently change a scope, leaf, appearance, claim-kind projection, source view, exclusion,
  fidelity role, or classification while retaining the old witness or authority subject;
- use a right ID with a wrong kind/digest, a verdict whose reviewer differs from its enclosing row,
  a verdict about another subject, or a selection with only matching IDs but wrong exact digest.

Negative proof/card/signature tests:

- change one raw Markdown byte; update its digest only in metadata but not verdict/gate/bundle; use
  empty Markdown, a path escape, normalized bytes, or metadata with an extra/wrong-typed field;
- independently change frozen card or source-target bytes; update the card locator but not the
  subject set, proof metadata, verdict, gate bundle, and role binding in required downstream order;
- omit the quantitative recovery role, substitute another claim/card/target/declaration/signature,
  add an unrelated claim, reuse the ordinary bundle for the quantitative claim, or leave a required
  gate subjectless;
- make the exact-signature packet name/hash its downstream gate bundle, use a verdict array instead
  of a protocol string, add an unknown perspective, or silently omit an inapplicable gate.

Positive level-isolation tests: a complete `source-batch`-only request with a typed supplied-card ID
passes without freezing it; a complete `card-binding`-only request passes without a lower row; and a
complete `exact-signature-binding`-only request passes while still binding all obligations of that
requested level.

These tests establish only the proposed E0 synthetic binding behavior. They grant no real-source,
rights, review, authority, proof, target, implementation, or programme-result credit.
