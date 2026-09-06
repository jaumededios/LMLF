# Stage 1 first finite Chapter 4 packet companion contract — draft 03

## Status and authority boundary

This is a bounded natural-language proposal for the smallest executable source-inventory and classification contract that could enable one finite Chapter 4 implementation packet. It succeeds, and does not alter, `stage1-companion-schema-design-draft-02.md`.

It is informed by accepted DD-021 revision 6 at scope commit `aebe7968bd6d5dcd23ac949d5d5e0d8854334ca1`, whose accepted file has SHA-256 `4964a4ad79b8e8da0cdd376836383b189c32b38eaeecd9979dfdcca8cb54b4c2`, and by repository baseline commit `b8d2f731fcfd5cd0889d0732f13699eb94681c86`.

It does not reopen or summarize the accepted scope. It is not an approved schema, implementation, source census, classification authority, theorem card, signature, proof, Lean change, or coverage claim. It needs two fresh independent exact-artifact reviews before root selection; those reviews do not review any later implementation or production data.

The programme succeeds by accepted Lean completion of selected exact mathematical functions and assertions in DLMF Chapters 4–10. Schema, evidence, documentation, and rendering only enable or report that work. Chapters 1–3 enter only through finite, explicit support obligations for selected Chapters 4–10 consumers.

## The minimum useful boundary

The first implementation supports one finite Chapter 4 source batch `B4.1`, not a global census. It must be able to:

1. bind a fixed DLMF snapshot and exact stored payload evidence;
2. distinguish canonical source identity from URL aliases and representations;
3. inventory a finite content tree, structural document items, source-owning leaves, appearances,
   atomic/provisional/reference records, reconciled nonmathematical remainder, contexts, notations,
   and entities;
4. close batch membership through the declared document/leaf ownership scope;
5. record source-audit issues and append-only issue events;
6. enumerate a non-authoritative structural candidate set without inventing atoms;
7. record complete source-semantics classifications for independent review;
8. bind each atom to required implementation roles through three explicit validation levels; and
9. expose exact records for the accepted manual review protocol to select or reject.

It need not automate global closure, every future correction type, authoritative event folding,
full review-quorum evaluation, card linting, proof review, or programme-wide completion. Those gates
remain mandatory and are discharged manually where automation is deferred.

## Preserved legacy boundary and exact protected bytes

The legacy input set is exactly the fourteen tracked `blueprint/inventory/*.csv` paths and `review/classifications-v3.json` enumerated in Appendix A, at repository commit `b8d2f731fcfd5cd0889d0732f13699eb94681c86`. Each path and its exact ordinary SHA-256 digest is an independent golden assertion; there is no unspecified directory hash or aggregate-manifest rule.

Those fifteen input files, their readers' old-track meanings, fixtures, and validation results remain byte-for-byte and behaviorally unchanged. The DLMF contract is a typed, versioned companion read by an intentional extension of `scripts/validate_inventory.py`. The validator itself is not protected against those reviewed edits. The legacy load path remains the v3 load path and continues to read the exact immutable v3 artifact whose SHA-256 is `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`.

The protected-file guard compares path set and digest values against the exact reviewed baseline constants outside the candidate manifest being validated. Editing a protected CSV and editing a candidate-owned golden manifest to match it must still fail. Missing, extra, renamed, duplicated, or digest-mismatched protected entries fail independently. This contract does not protect documentation or the validator and does not authorize any legacy migration.

The companion is not a rewrite of legacy tables, a second validator, or a universal graph/database framework. Old one-manifest registry semantics remain `oldtrack` only. New source views, audit batches, and execution manifests use separate namespaces and may refer to legacy objects only through explicit typed cross-track links.

## Proposed logical record families

Exact filenames, headers, and field spellings remain for the implementation proposal, but it may not
omit these families or merge their identities:

- **Snapshot and evidence:** snapshot, canonical document, document alias, representation,
  retrieval observation, and exact payload-evidence records. A retrieval is evidence, not source
  identity. Hashes cover exact stored bytes; raw payload may be binary and is not transcoded.
- **Source structure:** content unit with typed parent; `document_item` structural-oracle row;
  exclusive source-owning leaf; appearance; atomic target, provisional claim, mathematical reference
  lead, and nonmathematical remainder; shared context; and normalized claim-context membership.
- **Audit state:** issue plus append-only issue event, audit batch, typed batch scope member, optional
  explicit appearance membership, source view, and explicit effective-view membership. Status is
  never inferred from row recency.
- **Mathematical identity:** notation, named entity, and normalized claim-notation and claim-entity
  memberships. Entity and notation identity are not display-name strings.
- **Classification and execution binding:** one effective DLMF `source_semantics_class` per target
  atom, normalized role mappings, three validation-level records, and typed links to later exact card
  or signature artifacts.
- **External authority:** strict-JSON decision event, immutable catalog, root-view selection, and
  immutable ordered artifact index held in durable external evidence storage and cited by exact
  digest. Candidate-owned records cannot self-authorize.

Flat companion data uses normalized CSV. Structured external records use strict JSON. Exact stored
bytes, not a semantic JSON canonicalization, are hashed; even a whitespace-only rewrite is a new
artifact and needs a new binding.

## Source rights and evidence placement

Before real `E1` data is retained, its rights record binds an exact retrieved copy of the DLMF-specific notice at `https://dlmf.nist.gov/about/notices`, including retrieval time and digest. Reviewers check contemplated storage and use against it. The observed notice permits limited copying and internal research/teaching distribution but prohibits bulk copying or redistribution and commercial copying.

A bounded research packet may retain only limited internal evidence justified by that binding. Raw DLMF or book payload stays access-controlled outside the public repository. Repeated small retrievals do not authorize a Chapters 4–10 mirror. Global bulk retention needs a separately authorized archive or permission path; otherwise evidence uses the accepted `non_reproducible` or `expired` fallback and cannot support current-completion claims. No full mirror, payload download, or permission request is asserted here. This does not prevent one properly bounded first function packet.

## Normative source ownership and batch closure

The canonical ownership chain is:

```text
canonical_document -> source_owning_leaf -> appearance -> claim
```

Here `claim` means exactly one of atomic target, provisional unresolved claim, mathematical reference
lead, or nonmathematical remainder. Every leaf belongs to exactly one canonical document in the same
snapshot and schema set. Every appearance belongs to exactly one leaf and repeats that leaf's one
canonical-document owner. Every claim belongs to exactly one appearance, and its stored leaf,
document, snapshot, and schema-set keys must equal the owners derived through that appearance. An
alias, representation, container, context, notation, or entity cannot own an appearance or claim.

Each batch scope row has exactly one scope discriminator and subject:

- `whole_document` names one canonical document; or
- `whole_leaf` names one source-owning leaf.

For `whole_document`, derived membership contains every declared leaf owned by that document and all
appearances and claims owned by those leaves. For `whole_leaf`, it contains every appearance and claim
owned by the named leaf. A document reference needed only to interpret a selected leaf is context, not
a `whole_document` scope row, and never silently imports all leaves of that document.

If explicit batch appearance memberships are stored, their set must equal—not merely be a subset of—
the appearances derived from the typed scope rows. The same equality is checked for any stored leaf
or claim membership projection. Thus an included scope cannot omit a difficult sibling leaf,
appearance, provisional claim, reference lead, or remainder. Overlapping document and leaf scope rows
deduplicate to one canonical membership set and never mint new identities.

These are structural closure rules over supplied records. Production reviewers still establish that
the supplied canonical-document and leaf inventories exhaust the actual exact source payload and
that semantic atomicization is complete.

## Minimal `document_item` structural oracle

Each supplied canonical document has a finite nonempty set of `document_item` rows keyed within the
same `(snapshot_id, canonical_document_id, schema_set_id)`. An item is a structural payload slot, not
a semantic claim or copied source text. Each item is owned by exactly one source-owning leaf in that
same document, snapshot, and schema set. Each source-owning leaf owns at least one item. Containers
own no item and no payload.

Item keys are unique, and the item-to-leaf relation is total and single-valued in the supplied
inventory. Deleting a leaf and every reference to it while retaining its expected item must therefore
produce a genuine `missing_leaf_owner` diagnostic, not merely a dangling foreign key. Duplicate item
ownership, cross-document ownership, empty leaves, and container ownership also fail.

This oracle makes the synthetic missing-leaf test mechanically meaningful. A supplied production
item inventory is not proof that every actual source item was supplied; exact-payload source review
and forward/reverse census passes remain the production source-exhaustiveness authority.

## First-slice source invariants

In addition to the closure and oracle above, E0 enforces structural/relational parts while manual
source review and root authority enforce semantic completeness and review-dependent parts:

- IDs are unique in their type; every reference resolves to the expected type and schema set.
- Content units have one document owner and at most one typed parent; parent edges are acyclic.
- Leaves have exactly one of `mathematical`, `mixed`, or `nonmathematical` disposition.
- Mathematical/mixed leaves decompose into the four claim kinds without duplicate ownership; source
  reviewers, not E0 inference, certify that there is no semantic gap.
- Every atomic semantic claim has exactly one atom at one appearance. Equal text or formula at two
  genuine appearances remains two appearances and is not deduplicated.
- Aliases and representations cannot mint appearances or claims; contexts may be shared only by
  explicit membership and cannot duplicate ownership.
- A provisional claim has no invented replacement atom. Claim kinds are never relabeled in place.
- Issue events are append-only and evidence-relative. `closed_with_documented_issues` is reopenable
  and does not establish partition, target, proof, or completion readiness.
- A well-posed false or contradicted atom remains in a defined denominator with zero proof coverage;
  diagnosis never deletes it.
- Canonical document/alias reconciliation is externally reviewed before production appearance or
  atom IDs are allocated. All E0 fixture IDs use an `FX-` namespace and are not production IDs.
- Once allocated, a production ID is immutable. The first selected production view admits no
  correction type not implemented; discovery suspends only the affected batch and dependents until
  a reviewed successor exists, without editing any production row in place.

The correction restriction minimizes E0 without weakening append-only correction semantics.

## Candidate enumeration and the production partial target

For exact snapshot `S4`, batch `B4.1`, and view `V`, E0 may enumerate only visibly labeled,
non-authoritative `CandidateAtoms(S4,B4.1,V)`. It uses the membership closure above and filters for:
atomic target kind; exact snapshot `S4`; appearance in the derived batch closure; chapter 4–10;
effective successful resolution in `V`; exactly one canonical ownership key; and immutable fidelity
role `explicit_mathematical_assertion` or `internal_cross_reference_assertion`.

Reference leads, provisional claims, and nonmathematical records stay outside the candidate set but
remain mandatory members of the reconciled batch scope where owned. Structural validity cannot
establish production `PartitionReady`.

E1 establishes `PartitionReady(S4,B4.1)` only when complete manual source review and complete
approving source-semantics classification review bind the exact snapshot, batch revision, ownership
closure, candidate set, fidelity/exclusion decisions, and source view, and root selects those exact
records externally. Missing, pending, adverse, changed, or incomplete source/classification review
leaves production `Target` undefined. No trusted self-status Boolean, diagnostic disposition, or
opaque candidate certificate may replace those reviews.

After selection, `Target(S4,B4.1)` is exactly the reviewed filtered set, including every well-posed
false or contradicted atom. Card/declaration mapping, entity/notation resolution, proof, coverage, and
completion are later gates and do not alter membership. Approving source-semantics classification is
part of `PartitionReady`, not a later gate.

E0 may compute a target only for synthetic `FX-` data carrying an explicit synthetic readiness
witness. Such output is fixture-only and never production authority. No first-slice command reports
`Target(S4)` or global source-audit closure. Combining batches into a global view is deferred.

## Orthogonal DLMF classification axis

The DLMF successor introduces one mandatory, single-valued, atom-level axis named exactly
`source_semantics_class`. Its only accepted tokens are:

- `ordinary_exact_or_structural`; and
- `finite_quantitative_plus_source_recovery`.

There is no third token or `mixed` escape hatch. Every candidate atom has exactly one effective value
before `PartitionReady`. The value is externally reviewed source-semantics data; E0 does not infer
mathematical meaning from prose.

This axis is orthogonal to every unchanged v3 packet-level and target-level theorem, coverage, and novelty axis. The successor names the exact v3 path, schema version, and digest above as an immutable dependency/predecessor; it does not supersede, reinterpret, or replace v3. Legacy cards continue to load v3 through the existing loader. DLMF atom classifications load the separately named successor and its `source_semantics_class` axis.

A v3 theorem/coverage/novelty token in `source_semantics_class`, or either DLMF token in any v3 axis,
is a cross-token axis-placement error even if the spelling happens to resemble a role subtype.
Packet/target classification remains subject to v3 independently of the DLMF source-semantics value.

## Role cardinalities and three validation levels

Role mappings are normalized rows. An ordinary atom has exactly one `ordinary_source_target` role
with subtype `direct_source_target` or `named_source_target`. A quantitative atom has exactly one
`semantic_finite_quantitative` role and exactly one `faithful_source_recovery` role. The two roles
eventually bind distinct cards and distinct Lean declarations. The recovery declaration is a
downstream consumer in `Audit/SourceRecovery` and consumes the semantic finite producer. Helpers,
entity identifications, and notation equivalences cannot substitute or claim source coverage.

Validation has exactly these ordered levels:

1. **`source-batch`:** required role rows and their atom/card/declaration endpoint states are
   representable; card and declaration endpoints may be explicitly `pending`. Any supplied endpoint
   must be typed and consistent. No card, declaration, or signature is frozen here.
2. **`card-binding`:** each role binds an exact frozen card digest and that card's frozen
   source-facing mathematical target. The declaration may remain explicitly `pending`, or may name a
   proposed declaration with a nonbinding signature sketch. A sketch is not an exact signature.
   Quantitative roles already bind two distinct cards.
3. **`exact-signature-binding`:** each role binds the exact declaration in an independently reviewed,
   frozen exact-signature packet. It may be externally selected only after every required complete
   natural-language proof review has passed. Quantitative roles bind two distinct declarations as
   well as two distinct cards.

No level, row, endpoint, card, sketch, signature packet, or validator result implies `lean_ready`,
proof correctness, source/proof coverage, implementation acceptance, or completion. Exact-signature
binding precedes and does not replace external composite `lean_ready: pass`. Ordinary cardinality one
and quantitative cardinality two remain invariant at all levels; pending endpoints never excuse a
missing or duplicate role.

E0 checks only the structure of supplied bindings: required fields, types, IDs, exact digests, cardinalities, and synthetic selected-record witnesses in fixtures. Independent manual reviewers and root authority establish actual card/signature freezing, review passage, reviewer independence, and production selection. A validator result or candidate/self-claimed review status cannot certify them.

## Explicit structural order for external authority bindings

Each finite external authority bundle has an immutable ordered artifact index. Every index entry has
exactly `(position, record_kind, artifact_id, exact_sha256)`. Positions are unique positive integers
forming the bundle's declared order; artifact IDs are unique within kind. Indexed bytes must exist,
decode under their record's strict format, declare the indexed ID and kind, and hash to the indexed
digest. The index never lists or hashes itself. Its own exact-byte digest is bound by a separate
external review/root envelope, so a self-changed index cannot authorize itself.

An authority edge names target ID, target kind, target digest, and target position. All four must
equal the indexed target, and the target position must be strictly smaller than the source position.
Timestamps, filenames, lexical IDs, filesystem discovery order, JSON object order, and storage time
have no authority-order meaning.

The complete E0 typed-edge grammar is:

- a genesis catalog is empty: it has no catalog predecessor and no event or selection members;
- every non-genesis catalog binds exactly one earlier catalog as `catalog_predecessor`;
- an event binds one earlier `prior_catalog_or_view` target of kind catalog or root-view selection,
  may bind one earlier event as `predecessor_event`, and may bind one earlier root-view selection as
  `prior_selection`;
- a post-event catalog binds one or more earlier event/root-view-selection members and its required
  earlier catalog predecessor; and
- a root-view selection binds exactly one earlier post-event catalog and may bind one earlier
  root-view selection as `prior_selection`.

No other authority edge kind/source-kind/target-kind combination is valid. In particular,
`predecessor_event_id` and `prior_selection_id` are separate optional fields and cannot populate,
alias, or substitute for one another. The index and these bindings mechanically reject self,
same-position, forward, unknown-ID, digest-mismatched, wrong-kind, illegal-edge-kind, and cyclic
references; strict backward position also makes a cycle impossible in accepted data.

The order grammar supplements rather than replaces manual decision metadata. Each event or selection retains record kind and immutable ID; subject kind and ID; exact artifact IDs and digests; reviewer identities plus verdict artifact IDs and digests; root decision; affected dependent IDs and each disposition; and an informational issuance time that never controls order or effective state.

This order proves only reproducible structural backreferences. It is not evidence of real publication chronology, does not compute effective state, and does not decide which adverse, suspension, or withdrawal records control. Complete manual external reviews and root selection remain authoritative. External non-authority payload, rights, reviewer-verdict, card, natural-language-proof, and signature packet bindings still name exact IDs, types, and byte digests and are checked directly; they are not silently imported into a universal authority graph.

## Strict JSON and exact-byte identity

All structured companion and external authority JSON is strict UTF-8 JSON. The parser rejects invalid
UTF-8, duplicate object keys at any nesting depth, and the non-JSON constants `NaN`, `Infinity`, and
`-Infinity`. It accepts no parser extension for comments, trailing commas, or non-finite numeric
values. CSV/JSON text is UTF-8; raw payload evidence may be binary.

SHA-256 always covers exact stored bytes. Parsing does not normalize Unicode, whitespace, object-key
order, numeric spelling, or line endings, and no semantic canonicalization can satisfy an exact-byte
binding for different bytes.

## Exact next implementation package

Only after this draft is independently accepted may the next repository change be `E0`, a synthetic
executable contract:

1. add reviewed versioned companion descriptors, the fixed protected-file baseline, and a reviewed
   DLMF classification successor;
2. extend `scripts/validate_inventory.py` through its existing standard-library validation path;
3. add no production DLMF census rows or production IDs;
4. add one small positive `FX-` synthetic `B4.1` fixture and focused adversarial copies; and
5. preserve all legacy input bytes, meanings, fixtures, and validation results.

E0 implements parsing; keys, enums, schema/snapshot binding, typed foreign keys; ownership and batch
closure; the structural item oracle; context membership; issue/event consistency; structural
candidate enumeration and fixture-only readiness; class presence/uniqueness/axis separation; the
three role-binding levels; protected-byte guards; and ordered authority-binding syntax.

E0 does not implement a production census, correction or authoritative effective-state fold,
production readiness/selection, global closure, review quorum, support traversal, proof coverage,
completion, card linting, or integration.

## `E0` acceptance tests

Local command transcripts must prove:

- the unchanged legacy data path and all 25 existing negative mutations retain their results;
- each Appendix A path and digest is guarded, while the intentionally changed validator is not;
  protected-byte mutation, path-set mutation, and a matching self-edited candidate manifest fail;
- the positive `FX-` batch has a fully supplied synthetic witness, two distinct appearances/atoms,
  shared context, one ordinary atom, one quantitative atom, and all required roles;
- fixture-only target output is exactly those two atom IDs and is never authoritative;
- `whole_document` includes all declared leaves, `whole_leaf` includes all owned appearances and
  claims, and an explicit appearance projection exactly matches the derived closure;
- cherry-picking one appearance while omitting an included sibling leaf/appearance fails, while a
  document used only as leaf context does not silently expand scope;
- deleting one leaf and all its dependent references while retaining its `document_item` fails with
  `missing_leaf_owner`; duplicate/cross-document item ownership, empty leaf, and container payload
  also fail;
- duplicate ownership, alias-created claims, inconsistent claim owner keys, broken typed foreign
  keys, and incomplete required claim-kind reconciliation fail;
- an underdefined claim keeps its fixture target undefined despite
  `closed_with_documented_issues`; a well-posed false atom stays in the target with no fake credit;
- a DLMF token in a v3 theorem/coverage/novelty field and a v3 token in
  `source_semantics_class` both fail; missing or duplicate effective source classes fail;
- a syntactically valid ordinary token on the synthetic asymptotic atom fails only because it
  mismatches the exact supplied synthetic reviewed source-semantics binding, never by NLP inference;
- the ordinary atom has exactly one role; the quantitative atom has exactly two roles and distinct
  cards at `card-binding`, then distinct exact declarations at `exact-signature-binding`;
- `source-batch` accepts explicit pending endpoints; `card-binding` accepts a frozen source-facing
  target plus pending declaration/nonbinding sketch but rejects an unfrozen card or purported exact
  signature; exact-signature binding rejects a missing independent frozen packet, absent required
  complete proof review, wrong declaration, or duplicate quantitative declaration;
- those higher-level fixture witnesses are explicitly synthetic; E0 validates their structure and
  digests but cannot certify actual review passage, independence, freezing, or root selection;
- no role or level emits `lean_ready`, proof/coverage credit, implementation acceptance, or
  completion, and helpers or implicit cross-track transfers cannot claim source credit;
- a valid indexed genesis/catalog/event/selection sequence passes, while self, same/forward,
  cyclic, unknown-ID, digest mismatch, wrong-kind, illegal typed edge, self-index, and conflated
  predecessor-event/prior-selection fixtures fail;
- duplicate JSON keys at nesting depth, invalid UTF-8, each of `NaN`, `Infinity`, and `-Infinity`,
  a wrong exact-byte digest, and a whitespace-only changed artifact under the old digest fail; and
- real-data mode emits only structural diagnostics and proposed candidate IDs, never production
  `PartitionReady`, `Target`, proof/coverage credit, or Lean completion.

All tests are local. No CI, Pages, Verso, commit, push, or publication action belongs to E0.

## First real packet after `E0`

Only after E0 and its exact descriptors/classification successor receive their own reviews may `E1`
add a finite real Chapter 4 batch. E1 first binds the rights notice, canonical documents, structural
item inventory, and alias reconciliation, then allocates immutable production appearance/atom IDs and
passes structural checks. Complete manual source and classification reviews plus root selection bind
the exact closure and candidate set and establish production `PartitionReady` and `Target`.

Cards, dependency closure, complete natural-language proofs, exact-signature review, `lean_ready`,
implementation, proof review, and final exact-head integration follow as separately reviewable gates.
Necessary Chapters 1–3 support enters only through an explicit finite consumer manifest. This permits
actual Chapter 4 work after one sound finite packet without waiting for Chapter 4–10-wide automation
or waiving any accepted gate.

## Deferred successor dependencies

Only three successors are anticipated before they are needed:

1. typed append-only source-identity, atomization, notation, entity, association, and class
   corrections plus deterministic effective-view folding;
2. automated external authority/event/catalog/root-selection folding with suspension and
   restoration semantics; and
3. non-deactivating cross-snapshot evolution and multi-batch/global target, support-closure,
   coverage, completion, and integration projections.

They consume immutable IDs and exact-digest bindings from the accepted first slice. None may mutate
frozen facts, reinterpret legacy v1/v3 rows, turn diagnostic closure into readiness, transfer
authority from candidate-owned state, or enlarge E0 retroactively.

## Appendix A — exact protected legacy input manifest

These are the only protected baseline inputs for E0, each at repository commit
`b8d2f731fcfd5cd0889d0732f13699eb94681c86`:

```text
cca3ecf49092b622cb12e84697b6b9be1438b5a39c2304e3261043717133af9f  blueprint/inventory/cards.csv
cd18718c58e5b2ea0079595cce9621d8dfb17d8b28f830ab61973e4c3912e859  blueprint/inventory/edition_relations.csv
74a52d39f1c324c1e611410d53f78cff08ccf3755ac408fb5cf68ded5b8eb528  blueprint/inventory/editions.csv
6fd00196e7054b3366f90f785ffb4bf0119e633f927793fe3f68cf636bcdad91  blueprint/inventory/entities.csv
bee0913f4a5e8af8f36d15bcc560775351e334b537acc32f4ca77d3ca4a5e1df  blueprint/inventory/entity_evidence.csv
f86d49dcf4a6de88e43bc9e98371deba8c7f46a514edfd089761e0601fc3f2c9  blueprint/inventory/manifests.csv
71c5207de8572c8efc1a8deb7c76dd3bb2df6d730ecbb34e35823f3d7c139ac0  blueprint/inventory/notation.csv
dc33f603d23cba66f0cf7f41e2e1c78b7c30c8b895b01fb630206485d7ab3f8d  blueprint/inventory/occurrence_cards.csv
461bb841ddc552accd5bd93f2539f1f599b697a5693d865184622a1d05070d5a  blueprint/inventory/occurrence_entities.csv
901fb438b52ddfabff2358deca710efb3e98cf3d59b51768921041b8e9c5f100  blueprint/inventory/occurrence_manifests.csv
b1f8324f0ba92c09b26218c64fb12eef28c75c8e6f1ae0cead99d3cefe5f68e9  blueprint/inventory/occurrence_notations.csv
4f22741f26c134c86698794b19723eb112e82fea9170ecb93a52c4e7a6e48a4e  blueprint/inventory/occurrences.csv
3db2595d8c7cad010a76b9ef4e1b202ba6b819b05d2a262b4b1e24226345a7d7  blueprint/inventory/page_audits.csv
50dcbe401b9c00f81197def8dea95c355c98480987526da62490cd94ba4d3338  blueprint/inventory/source_snapshots.csv
975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e  review/classifications-v3.json
```

## Appendix B — disposition of draft-02 findings

1. Referee A G1 is accepted in **Normative source ownership and batch closure** and its focused E0
   tests: exact owner cardinalities, typed scope discrimination, derived closure, and no cherry-pick.
2. Referee B G3 is accepted in **Minimal `document_item` structural oracle** and its deletion test;
   production source exhaustiveness remains manual.
3. Referee A G2 is accepted in **Orthogonal DLMF classification axis**: the new atom-level axis is
   separate from unchanged v3 axes and cross-token placement is rejected.
4. Referee A G3 is accepted in **Role cardinalities and three validation levels**: source-batch,
   card-binding, and exact-signature-binding no longer conflate sketches with frozen signatures.
5. Referee B G1 is accepted in **Preserved legacy boundary** and Appendix A: fifteen exact path/hash
   assertions protect fourteen CSVs plus v3 without preventing intended validator edits.
6. Referee B G2 is accepted in **Explicit structural order for external authority bindings**: an
   externally bound ordered index and closed typed-edge grammar define backreferences without a fold.
7. Referee B G4 is accepted in **Strict JSON and exact-byte identity** and focused parser tests:
   duplicate keys, invalid UTF-8, and all three non-finite constants are rejected.

## Review request

Two fresh independent reviewers should judge this exact draft for logical sufficiency,
implementability within the existing validator, compatibility with accepted DD-021 revision 6, and
absence of omitted gates. Root must resolve disagreement and select an exact digest before E0 begins.
This author supplies preparation only and receives no schema, source-audit, classification, theorem,
signature, proof, integration, or quorum credit.
