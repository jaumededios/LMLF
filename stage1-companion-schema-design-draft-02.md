# Stage 1 first finite Chapter 4 packet companion contract — draft 02

## Status and authority boundary

This is a bounded natural-language proposal for the smallest executable source-inventory and classification contract that could enable one finite Chapter 4 implementation packet. It is a
successor to, and does not alter, `stage1-companion-schema-design-draft-01.md`.

It is informed by accepted DD-021 revision 6 at scope head `aebe7968bd6d5dcd23ac949d5d5e0d8854334ca1`, its adjudication and evidence chain published at
archive head `4898cbe809abac51c0f05e701ceaa0e288ee2b2f`, and the corrections in `stage1-r7-preparation-and-privacy-checkpoint.md`.

It does not reopen or summarize the accepted scope. It is not an approved schema, implementation, source census, classification authority, theorem card, proof, Lean change, or coverage claim.
It needs two fresh independent exact-artifact reviews before root selection; those do not review any later implementation or production data.

The programme succeeds by accepted Lean completion of selected exact mathematical functions and assertions in DLMF Chapters 4–10. Schema, evidence, documentation, and rendering only enable or
report that work. Chapters 1–3 enter only through finite, explicit support obligations for selected Chapters 4–10 consumers.

## The minimum useful boundary

The first implementation should support one finite Chapter 4 source batch `B4.1`, not a global
census. It must be able to:

1. bind a fixed DLMF snapshot and exact stored payload evidence;
2. represent canonical source identity separately from URL aliases and representations;
3. inventory a finite content tree, source-owning leaves, appearances, atomic/provisional/reference
   records, reconciled nonmathematical remainder, shared contexts, notations, and entities;
4. record source-audit issues and append-only issue events;
5. enumerate a non-authoritative structural candidate set without inventing atoms;
6. record complete source-semantics classifications for independent review;
7. bind each atom to the required implementation roles; and
8. expose exact records for the already accepted manual review protocol to select or reject.

It need not first automate global closure, every future correction type, external-authority event
folding, full review-quorum evaluation, card linting, proof review, or programme-wide completion.
Those gates remain mandatory and are discharged manually where automation is deferred.

## Preserved legacy boundary

`function_inventory-v1` and `review/classifications-v3.json` remain byte-for-byte frozen; their
readers, invariants, fixtures, manifests, cards, and old-track meanings continue unchanged.

The DLMF contract is a typed, versioned companion read by an extension of the existing
standard-library validator. It is not a rewrite of the legacy tables, a second validator, or a
universal graph/database framework. Old one-manifest registry semantics remain `oldtrack` only.
New source views, audit batches, and execution manifests use separate namespaces and may refer to
legacy objects only through explicit typed cross-track links.

## Proposed logical record families

Exact filenames, headers, and field spellings remain for the implementation proposal, but that
proposal may not omit these record families or merge their identities:

- **Snapshot and evidence:** snapshot, canonical document, document alias, representation,
  retrieval observation, and exact payload-evidence records. A retrieval is evidence, not source
  identity. Hashes cover exact stored bytes. CSV/JSON are UTF-8; raw source payload may be binary
  and must not be transcoded before hashing. JSON has no semantic-canonicalization rule.
- **Source structure:** content unit with typed parent; exclusive source-owning leaf with
  `mathematical`, `mixed`, or `nonmathematical` disposition; appearance; atomic target,
  provisional claim, mathematical reference lead, and nonmathematical remainder; shared context;
  and normalized claim-context membership. Containers own no source payload.
- **Mathematical identity:** notation, named entity, and normalized claim-notation and
  claim-entity memberships. Entity/notation identity is not a display-name string.
- **Audit state:** issue plus append-only issue event, audit batch, audit membership, source view,
  and explicit effective-view membership. Status is never silently inferred from row recency.
- **Classification and execution binding:** one effective classification per atom, explicit
  mapping rows for required implementation roles, and typed links to later card or execution
  artifacts. A pending card link may be represented at source-audit level but cannot pass the
  card-binding level.
- **External authority:** strict-JSON decision event, immutable catalog, and root-view selection
  records held in durable external evidence storage and cited by exact digest. With authorization,
  original reviews and authority JSON may be public; candidate-owned records cannot self-authorize.

Flat companion data uses normalized CSV. Structured external records use strict JSON: UTF-8,
duplicate object keys rejected, and hashes over the exact stored bytes. A whitespace-only JSON
rewrite is therefore a different artifact and requires a new binding.

## Source rights and evidence placement

Before real `E1` data is retained, its rights record must bind an exact retrieved copy of the DLMF-specific notice at `https://dlmf.nist.gov/about/notices`, including retrieval time and digest.
Reviewers check contemplated storage and use against it. The presently observed notice permits limited copying and internal research/teaching distribution but prohibits bulk copying or
redistribution and commercial copying.

A bounded first research packet may therefore retain only limited internal evidence justified by that binding; raw DLMF or book payload stays access-controlled outside the public repository.
Repeated “small” retrievals do not authorize a full Chapters 4–10 mirror. Global bulk retention needs a separately authorized archive or permission path; otherwise evidence uses the accepted
`non_reproducible` or `expired` fallback and cannot support fake current-completion claims. No full mirror, payload download, or NIST permission request is asserted here. This does not prevent one
properly bounded first function packet.

## First-slice source invariants

The contract requires these invariants for fixtures and a later real `B4.1`. E0 enforces structural/relational parts; manual source review and root authority enforce semantic completeness
and review-dependent parts:

- IDs are unique in their type; every reference resolves to the expected type and schema set.
- Each content unit has one document owner and at most one typed parent; parent edges are acyclic.
- Source-owning leaves exclusively and exhaustively cover every item in each named canonical
  retrieval document. Every mathematical/mixed leaf completely decomposes its semantic payload
  into atomic, provisional, reference-lead, and nonmathematical remainder records without gap or
  duplicate semantic ownership.
- Every atomic semantic claim belongs to exactly one atom at one appearance. Repeated equal source
  text or formula at two appearances remains two appearances and is not deduplicated.
- Aliases and representations cannot mint new appearances or claims.
- Context sharing uses explicit membership and cannot duplicate ownership.
- Atomic targets, provisional claims, mathematical reference leads, and nonmathematical records
  remain distinct. A provisional claim has no invented replacement atom.
- Issue events are append-only and evidence-relative. `closed_with_documented_issues` is a local
  diagnostic disposition, remains reopenable, and does not by itself establish partition,
  target, proof, or completion readiness.
- A well-posed but false or contradicted atom remains an atom and, when the containing target is
  defined, remains in its denominator. Its proof coverage is zero; diagnosis never deletes it.
- Canonical retrieval-document and alias reconciliation is externally reviewed before production
  appearance or atom IDs are allocated; wholly synthetic fixture IDs are exempt. Once any
  production ID is allocated it is immutable, even before selection or freeze.
- The first selected production view has no correction of a type not yet implemented. Discovery
  suspends only the affected batch and dependents until a reviewed successor exists, preserving
  every ID and old view; no production row is edited in place.

The last restriction minimizes this slice without weakening append-only correction semantics or claiming that correction machinery is unnecessary later.

## Candidate enumeration and the production partial target

For exact snapshot `S4` and explicit batch `B4.1`, E0 may enumerate only a visibly labeled,
non-authoritative `CandidateAtoms(S4,B4.1,V)`. It applies these structural filters to the supplied
candidate view `V`: record kind is atomic target occurrence; snapshot is exactly `S4`; the source
appearance is explicitly in `B4.1`; chapter is 4–10; the atom is effective and resolved in `V`;
there is exactly one canonical ownership key; and immutable fidelity role is
`explicit_mathematical_assertion` or `internal_cross_reference_assertion`. Reference leads,
provisional claims, and nonmathematical records stay outside but must reconcile completely.

Structural validity is necessary but cannot establish production `PartitionReady`. E1 does so
only when full manual source review and complete approving source-semantics classification review
bind the exact snapshot, batch revision, candidate set, fidelity/exclusion decisions, and source
view, and root selects those exact records through external authority. Any missing, pending,
adverse, or changed source/classification review leaves the production target undefined.

No trusted self-status Boolean or opaque candidate certificate may stand for those reviews. A
diagnostic disposition cannot establish readiness. Missing/duplicate/improperly owned leaves,
incomplete payload reconciliation, provisional atomization, inadequate evidence, or unresolved
partition-blocking issues likewise keep `PartitionReady` false and `Target` undefined.

After that manual selection, `Target(S4,B4.1)` is exactly the reviewed filtered set, including any
well-posed false or contradicted atom. Card/declaration mapping, entity/notation resolution, proof,
coverage, and completion are later gates that do not alter membership. Classification is not a
later gate: approving source-semantics classification is part of `PartitionReady`.

E0 may compute a target only inside synthetic tests supplied with an explicit synthetic readiness
witness. Such output is marked fixture-only and provides no production authority.

No first-slice command may report `Target(S4)` or global source-audit closure. Combining local
batches into a global view is a later, separately reviewed operation.

## Classification and role contract

The DLMF classification authority is a versioned successor that binds the exact v3 digest rather than modifying v3. It provides exactly the two accepted class tokens for this slice:

- `ordinary_exact_or_structural`; and
- `finite_quantitative_plus_source_recovery`.

No third class or `mixed` escape hatch is valid. Every candidate atom needs exactly one effective,
independently approved source-semantics class before `PartitionReady`; an externally reviewed exact
class is data, while the validator does not infer mathematical meaning from prose.

Role mappings are normalized rows. An ordinary atom requires exactly one `ordinary_source_target`
mapping with required subtype `direct_source_target` or `named_source_target`; direct/named is a
mapping subtype, never a class refinement. A quantitative atom requires exactly one
`semantic_finite_quantitative` mapping and exactly one `faithful_source_recovery` mapping to
distinct cards and declarations. The recovery declaration is downstream in `Audit/SourceRecovery`
and consumes the semantic finite producer. Helpers cannot substitute or claim source coverage.

The immutable source fidelity role and source-semantics class cannot be pending at production
readiness. Implementation-role endpoints may be pending at structural `source-batch` level. At
`card-binding`, each resolves to an exact frozen card and reviewed intended declaration/signature.
No row alone establishes `lean_ready`, proof, coverage, or completion; all accepted later gates apply.

## Manual authority before an automated fold

The existing review protocol may authorize the first batch manually after the validator passes.
Its external records nevertheless contain the fields a future deterministic fold needs:

- record kind, immutable event ID, subject kind and ID;
- exact artifact IDs and byte digests;
- `predecessor_event_id` for event-chain order;
- separately, `prior_selection_id` for restoration or replacement of a selected view;
- the prior catalog or view digest seen by the event;
- reviewer identities, verdict artifact IDs and digests, and the root decision;
- affected dependent IDs and the disposition of each; and
- an informational issuance time that never overrides graph order.

The hash graph is acyclic. An event may bind only a prior catalog/view. A post-event immutable
catalog may list that event digest but excludes its own digest. A later root-view selection binds
the post-event catalog and is not a member of that same catalog. A still later catalog may include
the earlier selection. Every edge points backward to an already stored exact artifact.

For the first packet, two fresh reviewers and root check those fields, exact digests, the DAG, and the applicable protocol gates directly. The validator checks syntax and bindings but does not
compute authoritative effective state. Later fold automation must reproduce the manually selected result and must never use mutable “latest status.”

## Exact next implementation package

After this proposal is independently accepted, the next repository change is only `E0`, a
synthetic executable contract:

1. add reviewed versioned companion schema descriptors and a reviewed DLMF classification successor;
2. extend `scripts/validate_inventory.py` using its existing header, key, enum, load, foreign-key, semantic-check, and negative-fixture patterns;
3. add no production DLMF census rows;
4. add one small positive synthetic `B4.1` fixture and adversarial synthetic fixtures; and
5. preserve every legacy file byte and every legacy validation result.

The first-slice validator implements only:

- normalized CSV and strict-JSON parsing, including duplicate-key rejection and exact-byte hashes;
- primary keys, foreign keys, enums, schema-set and snapshot binding;
- syntactic binding-DAG and ordered-backreference checks: no self/forward/cyclic reference, and
  `predecessor_event_id` remains distinct from `prior_selection_id`; this is not authority folding;
- source ownership, hierarchy, appearance/claim separation, and context membership;
- issue/event consistency needed for structural diagnostics;
- structural candidate enumeration and fixture-only synthetic readiness/target evaluation;
- presence and uniqueness of supplied source-semantics classifications; and
- role cardinality and typed endpoint mapping at `source-batch` and `card-binding` levels.

It does not implement production census, correction or external-authority folding, authoritative
production readiness/target selection, global closure, review quorum, support traversal, proof
coverage, completion, or integration.

## `E0` acceptance tests

The implementation review must see local command transcripts proving:

- the unchanged legacy validator and all existing negative fixtures still pass;
- golden SHA-256 checks reject any byte change to inventory-v1 or classifications-v3;
- the positive synthetic batch has a fully supplied synthetic readiness witness, two distinct
  appearances/atoms, shared context, one ordinary atom, one quantitative atom, and required roles;
- its fixture-only target is exactly those two atom IDs and is never labeled authoritative;
- a synthetic underdefined claim makes its fixture target undefined even if its issue is marked
  `closed_with_documented_issues`;
- a well-posed false atom stays in the fixture target; fake proof/coverage/completion-credit fields
  are rejected and E0 emits no such credit (the zero-credit real-source rule remains manual);
- duplicate ownership, container payload, alias-created claims, missing leaves, duplicate
  classifications, and broken foreign keys are rejected;
- an asymptotic fixture labeled ordinary is rejected only when that label mismatches its exact
  externally reviewed source-semantics class binding; missing semantic/recovery roles, duplicate
  roles, helper fake-credit claims, and implicit cross-track transfers are also rejected, with no
  NLP or mathematical classification inference;
- duplicate JSON keys, a wrong exact-byte digest, a self-referential catalog, a forward/cyclic
  authority edge, and conflated predecessor-event/prior-selection fields are rejected; and
- real-data mode emits only structural diagnostics and proposed candidate IDs, never production
  `PartitionReady`, `Target`, proof/coverage credit, or Lean completion.

All tests are local. No CI, Pages, Verso, commit, or publication action is part of this proposal.

## First real packet after `E0`

Only after `E0` and its exact schemas/classification authority receive their own reviews may `E1`
add a finite real Chapter 4 batch. It first binds and externally reviews canonical documents and
alias reconciliation, then allocates immutable production appearance/atom IDs and passes local
structural checks. Complete manual source and classification reviews plus root selection bind the
exact candidate set and establish production `PartitionReady` and `Target` for card authoring.

Cards, dependency closure, signature review, proof review, and final exact-head integration follow
as separately reviewable packages under the accepted protocol. Necessary Chapter 1–3 support is
added only through an explicit finite consumer manifest. This ordering permits actual Chapter 4
function work after one sound finite packet; it does not wait for Chapter 4–10-wide automation and
does not waive any approved source, architecture, signature, proof, or integration gate.

## Deferred successor dependencies

Only three schema successors are anticipated before they are actually needed:

1. typed append-only source-identity, atomization, notation, entity, association, and class
   corrections plus deterministic effective-view folding;
2. automated external authority/event/catalog/root-selection folding with suspension and
   restoration semantics; and
3. non-deactivating cross-snapshot evolution and multi-batch/global target, support-closure,
   coverage, completion, and integration projections.

Each must consume the immutable IDs and exact-digest bindings defined by the accepted first-slice
contract. None may retroactively mutate frozen source facts, reinterpret legacy v1/v3 rows, turn
diagnostic closure into readiness, or transfer authority from candidate-owned state.

## Review request

Two fresh independent reviewers should judge this exact draft for logical sufficiency,
implementability within the existing validator, compatibility with DD-021 revision 6, and absence
of omitted gates. Root must resolve any disagreement and explicitly select an exact digest before
`E0` begins. This author supplies preparation only and receives no schema-approval, source-audit,
classification, theorem, proof, integration, or quorum credit.
