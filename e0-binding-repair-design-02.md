# E0 exact-binding repair design 02 — proposed, unreviewed

## Status and fixed boundary

This is a bounded repair proposal subordinate to accepted `stage1-companion-schema-design-draft-04.md`, exact SHA-256 `e3dacb11c97ec059ae8f48e3fc81f3155fbf86c2cd5679c69541852c2d1fdc7b`.
It replaces design draft01 as a review candidate but does not alter draft01's preserved exact bytes.
It addresses referee-B G1 and G4 for rejected implementation HEAD `26f4051e13f3a7bc558c225138458f211bf31597`.
It is not an approval, source census, rights determination, review result, quorum result, authority fold, card, proof, signature, coverage claim, or production selection.
All E0 additions remain small `FX-` synthetic fixtures. Real source payloads, real notice evidence, rights approval, and production IDs remain E1 work after E0 acceptance.
E0 validates closed types, raw-byte digests, typed reachability, and finite set equality only. Source truth, semantic evidence adequacy, source exhaustiveness, proof completeness/correctness, reviewer independence, review passage, quorum, and effective authority remain manual.

## Exact-byte and acyclicity rules

Every SHA-256 is over raw stored bytes. Parsing never creates an alternative semantic identity; whitespace, Unicode spelling, object-key order, numeric spelling, and line endings remain significant.
No object hashes itself directly or transitively. A content object's identity is `(record_kind, artifact_id, exact_sha256)`; a filesystem path is only a bounded-root locator.
Strict JSON data records self-declare `record_kind` and `artifact_id`, which must match external binding metadata.
Raw payload, rights-notice, Markdown, and CSV descriptor bytes cannot be required to self-declare JSON fields. Their typed external binding metadata supplies kind and ID; the raw bytes supply only their exact digest and length where required.
Raw bytes are never decoded and re-encoded to check identity. CSV descriptor bytes may be parsed only after their raw digest succeeds; raw source/notice/Markdown remains untranscoded evidence/content.

Source/core CSV and earlier immutable data artifacts flow into a manifest. Locator, witness, role, gate, verdict, selection, and authority-index files are not core-manifest members.
`audit_batches.csv` does not contain a manifest/witness ID or digest. Therefore there is no `manifest -> audit_batches witness -> witness -> manifest` cycle.

The source order is:

```text
raw source/notice bytes   raw schema CSV descriptors
          |                         |
          v                         v
payload/rights data        schema-set descriptor data
          \                         /
           v                       v
 immutable class/issue/source/core data
                    |
                    v
          source-core manifest
                    |
                    v
          batch-closure witness
                    |
                    v
 decision-event/reviewer subjects -> catalog -> root-selection subject
```

The proof/signature order is deliberately two-stage:

```text
claim + roles + frozen mathematical cards/targets
                    |
                    v
       early mathematical subject set
              /                 \
 raw proof + metadata      reviewed justified NLP-NR
              \                 /
               v               v
        pre-signature review bundle
                    |
                    v
 exact declaration + exact-signature packet
                    |
                    v
       late signature-correspondence record
                    |
                    v
         exact-signature role binding
```

The early subject set, proof content, and their reviews exist before exact-signature design. The late correspondence cannot replace, rewrite, or broaden their subjects and implies no approval.
An exact-signature packet may bind cards, targets, declarations, and dependencies, but must not name/hash the early subject set, proof metadata, pre-signature bundle, late correspondence, verdicts, or selecting role row.

## Finite normalized-file delta

1. Change `audit_batches.csv` to exactly `(schema_version, schema_set_id, snapshot_id, batch_id, batch_revision, source_view_id, classification_view_id)`. Remove both synthetic-witness columns.

2. Change `payload_evidence.csv`: remove `artifact_path`; retain its content digest and add `byte_length`, `rights_record_id`, and `rights_record_sha256`.

3. Change `source_semantics.csv` so it names an immutable proposed `source_semantics_instance_id` and digest, not a classification review/verdict. The instance contains the claim-bound class and ordinary rationale data. Later manual classification verdicts target the exact closure witness; they are not core data.

4. Keep `artifact_bindings.csv` outside the core manifest as the bounded-root locator table. Closed kinds cover raw schema descriptors, strict-JSON schema/rights/class/issue records, raw notice/source payloads, core manifest, closure witness, cards/targets, raw proof bodies, strict-JSON proof/review/bundle records, signature packets/correspondence, verdicts, and authority records.

5. Add `source_spans.csv` with exact header:

```text
schema_version,schema_set_id,snapshot_id,document_id,subject_kind,subject_id,span_ordinal,payload_evidence_id,byte_start_inclusive,byte_end_exclusive
```

`subject_kind` is closed to `document_item`, `appearance`, or `claim`. The typed key always includes `document_id`; for `document_item`, identity is the composite `(snapshot_id, schema_set_id, document_id, subject_id)`, never an encoded string or globally assumed item ID.
For appearance/claim rows, `document_id` must equal the resolved owner's document. Ordinals are contiguous positive integers per complete typed subject key.
Ranges satisfy integer `0 <= start < end <= payload byte_length`. Every document item and claim has at least one span; appearance spans are optional but checked if supplied.
The referenced payload must be reached through a representation/retrieval owned by the same document, snapshot, and schema set. Since each leaf owns an item, every source-owning leaf reaches checked exact payload bytes.
E0 checks bounds, owners, and typed foreign keys only. Whether a span is genuine semantic evidence and whether overlap is legitimate remain manual source-review questions.

6. `role_bindings.csv` may acquire only the IDs/digests needed for the early subject, pre-signature bundle, and late correspondence at the applicable level. It remains outside the core manifest.

## Exact source/core CSV member set

`source_core_manifest` contains exactly these path-sorted CSV members, neither a subset nor a discovered directory:

```text
appearances.csv
audit_batches.csv
batch_appearances.csv
batch_claims.csv
batch_leaves.csv
batch_scopes.csv
canonical_documents.csv
claim_contexts.csv
claim_entities.csv
claim_notations.csv
claims.csv
content_units.csv
contexts.csv
document_aliases.csv
document_items.csv
effective_view_claims.csv
entities.csv
issue_events.csv
issues.csv
leaves.csv
notations.csv
payload_evidence.csv
representations.csv
retrieval_observations.csv
snapshots.csv
source_semantics.csv
source_spans.csv
source_views.csv
```

It excludes `artifact_bindings.csv`, `role_bindings.csv`, `validation_levels.csv`, schema descriptor CSVs, itself, every witness, proof/gate/verdict file, authority record, and authority index.

## Earlier immutable data artifacts

All strict-JSON artifacts referenced by core CSV rows are earlier immutable data, never reviews or authority. Their recursively closed schemas forbid manifest/witness IDs or digests and all later proof, verdict, gate, signature-correspondence, catalog, selection, and authority references.

7. `schema_set_descriptor` self-declares its ID/kind, `schema_set_id`, schema revision, and typed external-binding triples for the raw exact bytes of `schema-tables.csv` and `schema-fields.csv`. Every core row's schema-set ID resolves to it. The CSV descriptor bytes themselves do not self-declare JSON identity.

8. `rights_record` self-declares ID/kind, source name, contemplated-use token, retention token, raw notice-evidence triple, retrieval time, and nonempty manual-review note. It does not grant rights. The E0 positive uses only an `FX-` notice; E1 may later bind a limited internal exact real notice copy.

9. `source_semantics_instance` self-declares ID/kind and exact claim, snapshot, schema-set, classification-view, class token, and required ordinary rationale. It is proposed classification data, not an approving review.

10. E0 `issue_evidence` has the closed keys `(record_kind, artifact_id, issue_id, evidence_kind, synthetic_fixture, note)`, with typed strings, Boolean fixture marker, and nonempty note. Its issue ID must match the referencing event. It has no verdict or authority fields.

The manifest has two closed arrays: the exact 28 CSV path/family/digest members above and the exact typed ID/digest set of all referenced earlier `rights_record`, `source_semantics_instance`, and `issue_evidence` JSON. It separately binds the schema-set descriptor triple.
Raw payloads, notice bytes, and schema descriptor CSV bytes are exact dependencies reached from those earlier JSON/core records through external locator metadata; they are not forced into a JSON self-declaration model.

## Exact batch-closure subject

11. `batch_closure_witness` self-declares ID/kind, synthetic boolean, source-core-manifest triple, schema-set-descriptor triple, batch ID/revision, snapshot, source view, classification view, and exact ordered projections:

- scope subjects;
- document, leaf, appearance, and all-claim IDs;
- claim IDs partitioned across the four claim kinds;
- candidate atom IDs; and
- noncandidate claim IDs.

It also lists exact payload-evidence and rights-record triples reached by that closure. The validator recomputes all sets from manifest-bound bytes and requires equality.
Fidelity roles, resolution/exclusion decisions, and proposed source-semantics fields are not copied: their rows/instances are exact under the manifest, while the witness fixes every affected ID.
Adding or changing a noncandidate claim therefore changes the core manifest and witness subject even when the candidate set stays identical.

## Early proof subjects and protocol-permitted `not_required`

12. `mathematical_subject_set` is per claim and self-declares ID/kind, batch-closure-witness triple, exact claim ID, and ordered required roles. Each role has role/subtype, frozen-card triple, and frozen source-facing-target triple only.
It contains no declaration ID, signature sketch, exact-signature packet, or late correspondence. Its role set equals the classification-required role set; quantitative producer/recovery cards and targets remain distinct.

13. `natural_language_proof_metadata` self-declares ID/kind, mathematical-subject-set triple, raw Markdown body triple, and exact covered role keys. The body is a nonempty regular file below the bounded root and is hashed as raw bytes.
Across required proof records, covered role keys must equal the roles assigned the `required` NLP path, with no extras. E0 binds actual content but does not decide whether it is complete/correct.

14. `nlp_not_required_record` is permitted only for a protocol-eligible direct pinned-library reuse. It self-declares ID/kind, mathematical-subject-set triple, exact role keys, `applicability: not_applicable`, nonempty concrete reason, and exact pinned-library fact/dependency identity.
It contains no fabricated Markdown. The subject set's frozen card is its applicability subject and must declare matching `not_applicable` and reason; the pre-signature bundle binds the exact reviewing gate record/verdicts. E0 checks correspondence only; reviewers decide eligibility and truth.

For every role, exactly one path is present: actual raw proof coverage, or an exact-bound reviewed justified `nlp_not_required_record`. Neither absence nor a candidate Boolean means `not_required`. NLP `not_required` does not silently waive a required structural-circularity gate.

15. `gate_review_record` self-declares ID/kind, gate kind, applicability, gate state, early subject-set triple, proof-metadata or NLP-NR triples as applicable, required controlled perspectives, and reason for any reviewed `not_required` state.

16. `reviewer_verdict` has recursively closed protocol string enums and an exact reviewer identity. Its `(subject_kind, subject_id, subject_sha256)` must equal the early gate record it judges, and its proof/NLP-NR references must match that gate.

17. `pre_signature_review_bundle` self-declares ID/kind and binds only the early mathematical subject, exact proof metadata/raw bodies or NLP-NR records, gate-review records, reviewer-verdicts, and named reviewer IDs.
It contains no declaration/signature subject and does not self-certify passage, freshness, independence, perspectives, or quorum.

Changing a card, source-facing target, role set, claim, or closure produces a new early subject digest and invalidates all affected proof metadata, NLP-NR records, gate records, verdicts, bundle, and later correspondence. A late signature change does not rewrite the preserved early proof/review subject.

## Late signature correspondence

18. `signature_correspondence_record` self-declares ID/kind, early mathematical-subject-set triple, pre-signature-review-bundle triple, and an ordered role array. Each late role repeats the exact early role key/card/target triples and adds exact declaration ID and exact-signature-packet triple.
The validator requires exact role-set equality and unchanged mathematical triples. Quantitative declarations remain distinct and recovery consumes the producer in the accepted direction.
The signature packet predates this correspondence and cannot hash it or any earlier gate artifact. The correspondence may be replaced for a changed signature without pretending the earlier proof/reviews judged that signature; actual signature correspondence/review authority stays external.

## Validation-level interpretation

A request may supply only one level. It satisfies that level's complete obligations without duplicated lower-level history rows.

At `source-batch`, every required role exists. Card and declaration endpoints are independently `pending` or `supplied` with typed IDs and, if present, exact artifact references consistent with the claim/role.
A supplied artifact's intrinsic lifecycle metadata may truthfully say draft or frozen and is checkable as artifact data. The role row remains `supplied`: source-batch grants no freezing, approval, selection, or signature correspondence.
A `bound` endpoint claim, required frozen target, exact-signature semantics, pre-signature bundle, signature packet, and late correspondence are forbidden at source-batch. This preserves valid typed-supplied-endpoint controls without accepting a higher-level row in disguise.

At `card-binding`, the requested row binds the exact frozen card and mathematical source target. A declaration remains pending or is a typed proposed ID with nonbinding sketch. No exact-signature or gate/correspondence claim is allowed.

At `exact-signature-binding`, the requested row itself binds the early subject, pre-signature bundle, and late signature correspondence. Separate lower-level rows are not required. When multiple levels are supplied, shared logical endpoint IDs agree; later authority does not retroactively freeze/approve an earlier row.

## Authority subjects without changing authority edges

The accepted immutable ordered-index and backward-edge grammar remains exactly unchanged. This proposal adds no edge kind, changes no source/target-kind combination, and does not reinterpret catalog membership.

Only non-authority subject metadata is strengthened:

- a source/classification decision event carries the exact `batch_closure_witness` subject triple;
- its reviewer verdicts carry the same exact subject triple and matching reviewer IDs; and
- a root-view selection carries the exact closure-witness subject triple it selects.

Catalog predecessor/member edges remain as accepted. A genesis catalog is empty and names no witness, event, selection, or later subject. Post-event catalogs aggregate only through the already accepted earlier-member edges; they do not acquire a new subject relation.
The authority index still never indexes itself, and its digest remains externally bound. E0 verifies backreferences and subject correspondence but performs no authority/effective-state fold and grants no production selection.

## Synthetic dependency examples

```text
FX payload -> FX evidence/rights/source spans -> exact 28 core CSVs + early JSON data
 -> FX-CORE-MANIFEST-2 -> FX-BATCH-CLOSURE-2
 -> FX decision/verdict subjects -> unchanged catalog edges -> FX selection subject

FX claim/roles + frozen cards/targets -> FX-MATH-SUBJECT-2
 -> (FX proof.md + metadata OR reviewed FX-NLP-NR) -> FX-PRE-SIG-BUNDLE-2
 -> FX signature packet/declarations -> FX-SIG-CORRESPONDENCE-2 -> role binding
```

## Focused positive and negative tests

Positive source: the all-`FX-` batch resolves the schema descriptor, `FX-` rights notice, each document through representation/retrieval/payload, every required item/claim span through the composite document key, all 28 exact core CSV members, all earlier JSON data, and exact recomputed closure/candidates.

Positive proof: one role uses actual nonempty raw Markdown bound before signature design; a separate direct pinned-reuse role uses no Markdown and has an exact reviewed justified NLP-NR path. Both reach a pre-signature bundle, then a later exact correspondence. Exact-signature-only validation passes without duplicate lower rows.

Negative source/evidence:

- remove evidence chains; cross documents; omit a required span; collide same item ID in two documents without composite resolution; use wrong owner, out-of-range span, path escape, or symlink;
- independently change raw payload/notice bytes, schema CSV whitespace, rights/class/issue JSON, or one core CSV; stale binding, manifest, witness, and authority subjects fail in downstream order;
- use an unknown schema-set ID, wrong raw kind/digest, JSON ID/kind mismatch, re-encoded raw content, core JSON referencing a later witness/verdict/gate, or an extra/missing core CSV member;
- independently add/change a noncandidate claim, scope, closure projection, fidelity/exclusion decision, source view, or proposed class while candidates stay fixed; unchanged manifest/witness/selection fails.

Negative lifecycle/proof/signature:

- place a declaration/signature packet in the early subject, make proof metadata depend on late correspondence, or make a signature packet hash the bundle/correspondence;
- change raw Markdown, card, or source target independently; stale metadata/gate/verdict/bundle/correspondence fails in exact dependency order;
- omit a role's proof and NLP-NR paths, supply both, fabricate empty Markdown for NR, omit pinned fact/reason/review, treat absence as NR, or use NLP-NR to erase a required structural gate;
- omit/substitute/add a claim, role, card, target, declaration, or signature in correspondence; reuse another claim's bundle; use wrong reviewer/subject/digest, wrong JSON type, or unknown protocol enum;
- replace a source-batch typed `supplied` endpoint with `bound`, or infer source-batch authority from an intrinsically frozen card artifact.

These tests establish only proposed synthetic E0 exact-binding behavior. They grant no real-source, rights, review, authority, proof, target, signature, implementation, or programme-result credit.
