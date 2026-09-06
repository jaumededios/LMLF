# Stage 1 typed companion schema — natural-language design draft 01

## Status, authority, and design inputs

This is a bounded proposer-preparation draft. It is **not** a frozen schema, implementation authorization, DLMF census, theorem-card plan, source or mathematical review, external adjudication, or review/quorum credit. Every actual schema, controlled vocabulary, fixture encoding, and authority template requires fresh exact-byte review before use.

Inputs are limited to:

- accepted main `b8d2f731fcfd5cd0889d0732f13699eb94681c86`;
- frozen proposed R6 at `dacf41e4c877ca6c58725128a7bcaaa651f49606`, `blueprint/stage_1_dlmf-R6.md` SHA-256 `fd75254a9e2d00076c404b535f8e40ac1c5c7a5574b5eb536e13f270c0ec29f6`;
- the prior reuse audit `stage1-r6-migration-reuse-audit.md`, SHA-256 `c34c155c364f2f609496740f320ffd873774ce7beb2e432ec8a92f1799f636e7`; and
- root's supplied design clarification. No live R7 edits were accessed.

Root choices treated as fixed here:

1. Preserve every `inventory-v1.0.0` CSV and `review/classifications-v3.json` byte-for-byte.
2. Add typed, versioned DLMF companion tables and readers. Do not rewrite v1, and do not build a universal graph/database framework.
3. Keep the old one-manifest registry as an old-track contract. New many-manifest membership and effective-state projections are separate records.
4. Keep authority records external, immutable, and append-only in a durable private evidence archive, referenced by exact ordinary digests. Candidate-owned records never authorize or select themselves.
5. Preserve strict Stage 1 theorem completion. Add a separate local/global source-audit closure state `closed_with_documented_issues`; it is not completion, proof coverage, `PartitionReady`, or a defined target set.

## Desired shape: one validator, two read domains

Retain `scripts/validate_inventory.py` as the single executable validation lineage. Refactor only enough to add a schema-set registry and typed companion readers around its present parsing, key/FK, digest, readiness, manifest-total, classification-binding, and copied-fixture helpers. Do not create a second validator with competing semantics.

The validator exposes two disjoint input domains and a joined read-only projection:

```text
immutable legacy v1 + frozen v3 ── legacy reader ───────────────┐
                                                               ├─ validated projection
versioned DLMF companion records ─ companion typed readers ────┘
external evidence archive/index ─ authority-event reader ──────┘
```

- The legacy reader validates the current exact files with current rules and adds only an in-memory `legacy_olver` track tag. It never writes, renames, reclassifies, or promotes a row.
- Companion readers require an explicit schema-set identity and explicit roots; they never discover scope from prose, directories, timestamps, or a mutable web page.
- Cross-track records are typed crosswalks. They may relate mathematical objects or provenance but carry `coverage_transfer = forbidden`; no DLMF coverage can arise from Olver rows and vice versa.
- The joined projection is disposable output. It is not an authority record and cannot be fed back as a source of truth.

## Logical record families and data boundaries

Names below are provisional logical names, not frozen filenames or field schemas. Every record has a versioned kind, an opaque never-reused ID, a track/source namespace, and exact foreign keys. Its own digest is never embedded self-referentially; an external binding records artifact bytes after creation.

### A. Schema-set and legacy compatibility

`schema_set` binds the exact member schema versions and file digests accepted in one run. `legacy_binding` binds the immutable v1 inventory file set and frozen v3 digest. A compatibility projection exposes legacy IDs and states without assigning them companion identities or effective DLMF status.

Hard rules:

- current v1 headers, row bytes, IDs, roles, status meanings, and the v3 digest remain unchanged;
- the old `cards.csv.manifest_id` and literal card/manifest status-equality rule apply only inside the legacy reader;
- no companion row may shadow a legacy primary key; a crosswalk uses its own ID and two immutable endpoints;
- a new classification authority is a versioned successor binding v3 as predecessor, not an edit to v3.

### B. DLMF source identity and retained evidence

Use separate typed records for:

- `source_snapshot`: selected DLMF release identity and observed version evidence;
- `retrieval_document`: one payload-owning canonical document within that snapshot;
- `document_locator_alias`: request URI, fragment/permalink, redirecting shorthand, or query/customization alias pointing to a canonical document;
- `document_representation`: HTML/MathML, TeX, or image rendering plus representation digest and reconciliation state;
- `retrieval_observation`: actual retrieval date, method, redirect chain, response identity, content digest, and observed version evidence; and
- `exact_payload_evidence`: immutable private archive reference, payload digest, access conditions, rights/provenance, and evidence availability state.

Snapshot, document, retrieval, representation, and retained-evidence facts remain distinct. A root version label is not a document digest; a digest without available authorized bytes is historical metadata, not renewed reproducible source approval. Changed bytes allocate a new snapshot. Locators and renderings do not mint documents or occurrences.

### C. Source partition and semantic ownership

Use separate typed records for:

- `content_unit`: hierarchy node with parent, canonical document, semantic locator, and kind `container` or `source_leaf`;
- `leaf_partition`: exclusive payload ownership and reviewed disposition `mathematical`, `mixed`, or `nonmathematical`;
- `source_appearance`: one genuine semantic location within one source-owning leaf, with reconciled locator/span/representation evidence;
- `shared_context`: exact-bound hypotheses, notation, or annotations referenced by atoms without automatically becoming target atoms;
- `source_claim`: immutable kind `atomic_target`, `provisional_unresolved_claim`, `mathematical_reference_lead`, or `nonmathematical_record`; and
- `claim_context`: many-to-many atom/provisional-claim to shared-context association.

An `atomic_target` owns exactly one unique `(snapshot_id, source_appearance_id, atom_ordinal)` key. Equal formulas at different genuine appearances remain separate atoms. One appearance may own several semantically disjoint atoms with shared context. Containers own no payload. Attached annotations are partitioned as payload; they mint an atom only when independently asserting mathematics.

Record kind is immutable. In particular, a provisional claim is never relabeled into an atom, and a false but well-posed atom is never relabeled as nonmathematical.

### D. Typed append-only corrections and pinned views

Do not use a generic edge table. Use typed correction headers plus typed predecessor/successor membership relations for exactly these families:

1. `source_identity_correction`: within one snapshot, repairs canonical-document or source-appearance identity; successors use fresh document/appearance/claim IDs.
2. `atomization_resolution_correction`: within one snapshot and one appearance, splits, merges, resolves, or reviewed-excludes claim payload; every successor receives a fresh ordinal/key/claim ID.
3. `snapshot_evolution`: cross-snapshot provenance with relation `unchanged`, `modified`, `split`, `merged`, `added`, or `removed`; it never changes an earlier snapshot's effective set.
4. `notation_identity_correction`, `entity_identity_correction`, and `association_correction`: repair only their named semantic layer with fresh successor IDs and explicit lineage.

Each correction binds an exact review reference and an exhaustiveness/nonduplication witness appropriate to its type. Corrections never mutate predecessors. A `source_decision_view` explicitly lists the corrections, exclusions, resolutions, fidelity decisions, and classifications it selects; an `object_decision_view` separately selects notation/entity/association decisions. Both have externally bound IDs and digests. No reader asks for the “latest” row.

### E. Issues and the two kinds of incomplete source truth

`source_issue` identifies a concrete issue, exact evidence scope, affected records, and material effect. `issue_event` is append-only with the minimal actions `observed`, `dispositioned`, and `reopened`; a disposition is explicitly relative to the bound evidence and audit revision. “Documented” never means permanently irreducible, and later evidence may reopen an issue without rewriting its history.

The two critical cases are different:

- **Underdefined mathematics:** retain a `provisional_unresolved_claim`; do not invent a target atom. A local or global source audit may be `closed_with_documented_issues`, but `PartitionReady` is false and `Target(S,B)` (or global `Target(S)`) is undefined. A later reviewed resolution creates fresh atom successor(s), or a reviewed full-payload reference/nonmathematical exclusion, and a new pinned decision view.
- **False but well-posed assertion:** retain the immutable `atomic_target` in the source denominator and bind the reviewed falsity issue/assessment. The partition and target set may be defined if every source-partition requirement otherwise passes, but accepted proof coverage for that atom is zero and strict Stage 1 theorem completion is false. Neither deletion, exclusion, proof of a different statement, nor a later corrected snapshot grants coverage for the original atom.

Source-audit scope status is independently `open`, `closed`, or `closed_with_documented_issues` for both local and global audits. `PartitionReady`, target definedness, proof coverage, and Stage 1 completion are derived separate results, never synonyms for this status.

### F. Notation, entities, and obligation classification

Companion notation/entity records reuse the present normalized separation and many-to-many associations, adding exact view membership and append-only correction lineage. Value-preserving aliases remain distinct from value-changing normalization bridges; cross-track entity crosswalks carry no source credit.

The reviewed successor classification authority supplies, without changing v3:

- exactly one effective per-atom source-semantics class: `ordinary_exact_or_structural` or `finite_quantitative_plus_source_recovery`;
- an occurrence-specific reviewed inapplicability reason for every ordinary atom; and
- designated mapping roles `ordinary_source_target`, `semantic_finite_quantitative`, and `faithful_source_recovery`, with ordinary direct/named subtype where applicable.

Mapping records bind atom, card, declaration (when it exists), evidence, role, and state. Helpers and entity-identification records cannot occupy a designated target role or earn source credit. Classification and mappings are separate: source census can precede declarations, while completion requires accepted exact-byte declaration evidence.

### G. Audit revisions, target sets, cards, and execution manifests

`source_audit_revision` is a finite local batch or global closure revision. It binds snapshot, explicit canonical-document/leaf membership, source and classification views, object view, issue set, external review references, and source-audit scope status. Membership tables are explicit; chapter wildcards are invalid.

`PartitionReady(S,B)` is a derived Boolean with reasons. `Target(S,B)` is a derived partial set: undefined unless partition readiness passes, otherwise the deduplicated effective `atomic_target` IDs with the two target fidelity roles. A global target set additionally requires a reviewed exhaustive `B_all` revision and explicit external selection. Local counts never become global percentages.

New DLMF card and manifest data use separate records:

- `card_registry` for immutable card identity/classification bindings;
- `execution_manifest_revision` for one finite implementation packet;
- `card_manifest_membership` for many-to-many membership with `target` or `support` role;
- `occurrence_target_mapping` for designated source-credit roles; and
- `support_edge` plus `support_closure_witness` for the finite least transitive closure and exact consumer justification.

Legacy `cards.csv` remains in the old-track adapter. It is not rewritten to support many manifests. Source-audit revisions and execution manifests are different record kinds and gates.

### H. External authority events and effective state

External authority payloads live only in the durable private evidence archive. Repository records contain immutable archive references and ordinary digests, never candidate-owned approval. The minimal authority event kinds are:

- `selection`: initially selects or explicitly replaces one classification, local-audit, or global-audit authority; replacement names the exact prior selection for that subject;
- `suspension`: binds accepted material counterevidence or justified material doubt, the targeted selection, and precisely affected dependents; it creates no fallback;
- `withdrawal`: terminates the targeted selection and affected authority without deleting history; and
- `integration_acceptance`: binds one exact repository head, toolchain/Mathlib pin, active classification/audit selections and views, execution manifests, review evidence, and completion result.

Every event binds its predecessor authority event where applicable, exact subject artifacts and digests, root adjudicator identity, exact reviewer/verdict references, and archive catalog/view digest. Material accepted counterevidence is bound in the same `suspension` or `withdrawal` event, so it cannot be accepted while leaving affected authority current.

The effective-state fold is deterministic:

1. Input is one explicitly selected, digest-bound authority view containing an exact ordered event-ID set; timestamps do not select or order authority.
2. Verify event uniqueness, type, signatures/attribution as applicable, digest bindings, causal predecessor closure, exact subject consistency, and completeness against the bound archive catalog/view.
3. `selection` establishes only its named authority; replacement is valid only when its prior-selection reference equals the chain's current terminal selection.
4. `suspension` makes that selection and named dependents noncurrent; it never revives an older selection. `withdrawal` leaves no current authority.
5. Only a new exact reviewed `selection` whose predecessor is the suspended/withdrawn terminal event can restore authority.
6. `integration_acceptance` is valid only if every bound selection is active in that same fold and every head/pin/view/manifest digest is mutually compatible.

Candidate dashboards and generated effective-state reports are read-only projections of this fold. They cannot choose the authority view, omit an adverse event, repair lineage, or write a status back to a frozen card.

## Dependency-ordered migration slices

Each slice is separately frozen and reviewed; only synthetic DLMF fixtures are permitted until the corresponding schema and validator contract are approved.

| Slice | Inputs | Output | Required tests before dependency use |
|---|---|---|---|
| 0. Legacy golden boundary | exact v1/v3 bytes and current validator | digest manifest, row/status/count goldens, untouched legacy positive and 25-negative-fixture results | any byte/ID/status/class drift fails; current commands remain green with exact totals |
| 1. Schema-set/readers | slice 0; current parse/key/FK helpers | one validator entry point, schema-set registry, explicit roots, typed companion loader, stable text/JSON diagnostics | v1-only mode; approved mixed schema-set; bad version/header/key/FK/root; no repository writes |
| 2. Source identity/evidence | slice 1; R6 §2 contract | snapshot/document/alias/representation/retrieval/evidence records and checks | alias/format duplication, redirect ambiguity, changed-byte reuse, missing per-document digest, unavailable digest-only evidence |
| 3. Partition/lineage/issues/views | slice 2; R6 tiny fixture | units/leaves/appearances/contexts/claims, typed corrections, issue history, pinned source view | exact five-target positive fixture; missing atom, double ownership, true repeat collapse, illegal merge/split, reused successor ID, predecessor+successor, underdefined/false cases |
| 4. Objects/classification/mappings | slice 3; frozen v3 predecessor | companion notation/entity/association views, reviewed classification successor, designated role mappings | v3 unchanged; total single class; asymptotic mislabeled ordinary; missing/duplicate/wrong role; alias versus normalization; identification cannot earn credit |
| 5. Audit and target computation | slices 3–4 | local/global audit revisions, closure-with-issues, `PartitionReady`, partial target computation | closed-with-issues is not readiness; underdefined target undefined; false atom retained; overlap compatible-only; local/global nontransfer; candidate cannot select `B_all` |
| 6. Execution manifests/support | slices 4–5 | many-manifest membership, target/support mappings, finite closure witness | wildcard, orphan, omitted indirect edge, unjustified cycle, blocked support, duplicate support credit, old one-manifest mutation |
| 7. Authority fold/integration | slices 1–6; versioned external format | external event reader, explicit fold, effective-state and one-head completion report | mutable-latest, omitted adverse event, stale predecessor, silent fallback, overbroad suspension, candidate self-selection, stale-head quorum, incompatible head/pin/view, compiled-only completion |

Slice 1 should parameterize or extract current pure helpers only where the new typed reader is the concrete second consumer. The later slices add table-specific semantic checks to the same validator orchestration; they do not route around it.

## Genuine remaining architectural choices

1. **Physical encoding and canonical digest rules.** Recommended default: normalized CSV for flat repository companion tables, canonical JSON for nested external authority/evidence records, and YAML only for human-authored candidate specifications. Exact encodings, canonicalization, and schemas remain proposals until separately reviewed.
2. **Pinned-view representation.** Recommended default: append-only typed decisions plus a digest-bound explicit effective-membership manifest. This preserves replay while letting the validator check the selected set directly; a fold-only view risks hidden omission, and a materialized-only view loses lineage.
3. **External archive catalog binding.** Recommended default: each selected authority view binds an immutable full catalog snapshot/digest and exact included event IDs, with root attestation of completeness. A bare list of favorable event references cannot prove that applicable adverse/suspension/withdrawal records were not omitted.

Routine choices—opaque IDs, explicit join tables, exact FKs, no wildcards, non-self-referential digests, stable diagnostics, synthetic fixtures, and preservation of old-track semantics—follow from the fixed constraints and need not reopen architecture.

No repository file, schema, data row, status, source record, theorem card, Lean code, Verso artifact, commit, push, download, or CI state was created or changed by this draft.
