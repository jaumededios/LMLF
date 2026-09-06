# Independent contract review F — Stage 1 first finite Chapter 4 companion, draft 04

## Controlled verdict

`approve`

I found no P0--P3 defect in the exact draft-04 artifact. It is a logically sufficient and implementable bounded contract for the synthetic E0 slice. This approval is only for the natural-language contract bytes identified below. It is not approval of any descriptor, classification successor, validator patch, production source record, theorem card, proof, Lean signature, implementation, review quorum, authority fold, coverage claim, or integration head.

## Exact artifact bindings

- Candidate: `stage1-companion-schema-design-draft-04.md`, 466 lines, SHA-256 `e3dacb11c97ec059ae8f48e3fc81f3155fbf86c2cd5679c69541852c2d1fdc7b`.
- Accepted programme authority inspected in full: `blueprint/stage_1_dlmf-R7.md` at accepted scope commit `aebe7968bd6d5dcd23ac949d5d5e0d8854334ca1`, SHA-256 `4964a4ad79b8e8da0cdd376836383b189c32b38eaeecd9979dfdcca8cb54b4c2`.
- Root acceptance inspected in full: `root-stage1-r7-adjudication.md`, SHA-256 `2af2a524ca8eadd26540dcd5acec95caddb6d9fb4c1078622522144ef6be7644`.
- Actual implementation/validator snapshot: clean `main` at `b8d2f731fcfd5cd0889d0732f13699eb94681c86`.
- Existing protocol inspected in full: `review/PROTOCOL.md`, SHA-256 `7453bc0ca6985d7ca2e8c525d9655a94e412c48e3850b92d9367a9f643d3177d`.
- Existing classification authority inspected in full: `review/classifications-v3.json`, SHA-256 `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`.
- Existing validator patterns inspected at `scripts/validate_inventory.py`, SHA-256 `c954ce39762b160e7328846dc3740df242deb381b4d5da7995df70cd74b90a75`.

## Findings

No actionable P0, P1, P2, or P3 finding remains in this contract.

### Line-specific determinations

1. **Bounded source ownership and closure are sufficient.** Candidate lines 78--111 give a single `canonical_document -> source_owning_leaf -> appearance -> claim` ownership chain, typed `whole_document`/`whole_leaf` scope, derived membership, and exact equality for any stored projections. Lines 109--111 correctly reserve real-payload exhaustion and semantic atomicization for production source review. This preserves accepted R7 lines 319--392 and 578--641 without demanding global census work before a finite packet.

2. **The item oracle makes the deletion fixture meaningful.** Candidate lines 113--128 require a finite nonempty item set per supplied document, total single-valued item-to-leaf ownership, at least one item per leaf, and no container payload. Therefore the lines 337--339 mutation can retain an independently expected item while deleting its owner and must diagnose `missing_leaf_owner`; it is stronger than a coincidental dangling-reference test while still expressly not proving real-source exhaustion.

3. **Production target semantics remain partial and externally controlled.** Candidate lines 157--183 restrict E0 to visibly non-authoritative structural candidates and fixture-only target computation. Lines 169--179 require exact-bound source and classification review plus root selection before production `PartitionReady` and `Target` exist. Underdefined claims remain outside an undefined target, while reviewed false atoms remain in a defined denominator with zero proof credit (lines 145--148, 165--179, and tests 342--343). This matches accepted R7 lines 471--478, 592--630, and 1141--1144.

4. **The ordinary classification cannot silently waive quantitative work.** Candidate lines 185--212 make `source_semantics_class` mandatory, single-valued, atom-level, and orthogonal to all unchanged v3 axes. Lines 197--206 require a nonempty frozen occurrence-specific rationale covering both required propositions and exact atom/snapshot/schema-set/view/artifact bindings; E0 checks structure only, while source/classification reviewers decide truth. The focused failures at lines 344--350 include absence, blank content, wrong identity/view/digest, and a syntactically valid but externally mismatched ordinary assignment. That is the accepted non-waiver control from R7 lines 728--763. In the concrete implementation, the containing artifact's digest must be supplied by its external binding/index rather than by a self-referential field; candidate lines 64--70 and 255--262 already provide that non-self-authorizing arrangement.

5. **The three role levels preserve lifecycle separation and the applicable pre-signature gates.** Candidate lines 214--253 keep ordinary cardinality one and quantitative cardinality two at every level; allow only typed explicit pending endpoints at `source-batch`; require distinct frozen cards at `card-binding`; and require distinct exact declarations plus an independently reviewed exact-signature packet at `exact-signature-binding`. Lines 237--241 bind the complete natural-language proof and the applicable fresh proof/quantitative and architecture/structural-circularity review records, with an exact reviewed `not_required` record where permitted and no absence-as-inapplicability shortcut. Source/semantics review and root selection are already separate prerequisites at lines 169--179; theorem-card/exact-signature review and composite `lean_ready` remain later external gates under lines 232--249. Thus no accepted review is replaced by E0 fixture syntax, and the negative cases at lines 351--363 exercise the material distinctions.

6. **The authority syntax is a structural DAG, not a fabricated effective-state engine.** Candidate lines 255--289 use an externally bound immutable ordered index, exact `(position, kind, id, digest)` target matching, strict backward edges, and a closed source-kind/edge-kind/target-kind grammar. Separate predecessor-event and prior-selection fields prevent role conflation. Lines 251--253 and 287--289 explicitly deny chronology, applicability, quorum, independence, and effective-current-authority conclusions. This is adequate for E0's reproducible backreference checks while correctly deferring the authoritative event/catalog/root fold.

7. **Strict JSON and exact-byte identity are implementable in the existing standard-library path.** Candidate lines 291--300 require invalid UTF-8, duplicate keys at every nesting depth, comments/trailing commas, and all three non-finite constants to fail, while hashing exact stored bytes without normalization. Python's current default `json.load` accepts duplicate keys and non-finite constants, but the standard library supports the required extension through a duplicate-detecting `object_pairs_hook`, rejecting `parse_constant`, and byte-first UTF-8 decoding. The focused cases at lines 367--368 prevent a permissive parser from being mistaken for compliance.

8. **The legacy boundary is exact and non-self-adjusting.** Candidate lines 35--43 and Appendix A lines 406--427 name exactly fourteen inventory CSVs plus classification v3, with independent baseline constants outside the candidate manifest. All fifteen recomputed digests match. The validator is intentionally outside the protected set so the companion path can be added, while tests at lines 327--329 require protected-byte, path-set, and matching-self-edited-manifest failures. The current v3 loader and old-track semantics remain separate from the successor axis.

9. **The package and tests remain within the accepted first finite slice.** Candidate lines 302--321 authorize descriptors, a validator extension, one positive `FX-` fixture, and adversarial copies, with no production rows or IDs. Lines 323--370 cover the high-risk ownership, classification, role, authority, parser, and false/underdefined cases and prohibit real-data readiness or completion output. Lines 374--404 leave real source data, corrections, global fold/closure, support traversal, coverage, completion, and integration to later reviewed successors. Lines 372 and 382--389 keep tests local and preserve the ultimate Chapters 4--10 Lean objective, with Chapters 1--3 only as finite consumer-justified support.

## Rubric disposition

- **Mathematical intent:** clear. The contract enables one Chapter 4 packet while keeping accepted Lean completion of Chapters 4--10 as the programme goal.
- **Reusable seams:** clear. Ownership, context membership, normalized role mappings, and typed authority edges each isolate a real many-row or trust-boundary relation; no additional abstraction is justified at E0.
- **Public API and theorem shape:** clear/not yet applicable to Lean declarations. The contract freezes source-facing targets separately from nonbinding sketches and later exact signatures.
- **Module and dependency design:** clear. The faithful-recovery declaration is a downstream consumer of the semantic finite producer; no backward import is authorized.
- **Mathlib integration:** clear/not yet applicable. E0 uses Python's standard library and proposes no theorem replacement or Mathlib API.
- **Proof architecture:** clear. Complete proof and applicable pre-signature reviews precede exact signature freezing, and `lean_ready`, implementation review, and exact-head integration remain distinct.
- **Cost and durability:** clear. The work fits the existing explicit loader/check/negative-mutation architecture without requiring a second validator or global database framework.
- **Refactor risk:** clear. Exact legacy bytes and behavior are guarded, and only the validator plus separately namespaced companion artifacts are intended to change.

## Checks performed

- Read the exact candidate, accepted R7 programme, root adjudication, current protocol, classification v3, relevant current-main validator paths, root imports, module docstrings, and dependency direction.
- Ran the Lean-library inventory script on clean current main: 16 Lean files, 4,623 lines, 29 definitions, 57 lemmas, and 128 theorems; it reported no trust/resource markers.
- Ran `python3 scripts/validate_inventory.py`: passed with 148 occurrences, 31 notations, 32 entities, 34 entity-evidence rows, 88 associations, and the expected manifest totals.
- Ran `python3 scripts/validate_inventory.py --negative-tests`: all 25 intentionally invalid copied legacy fixtures were rejected.
- Recomputed every Appendix A SHA-256 value; all fifteen paths and digests match the candidate and current-main files.
- Confirmed experimentally that the current default Python JSON loader accepts duplicate keys and `NaN`/`Infinity`/`-Infinity`, so draft 04's strict-parser tests are substantive rather than vacuous.

No Lean build was run because the reviewed artifact is a pre-implementation natural-language contract and no Lean source changed. No DLMF payload/source audit, legal determination, schema implementation, production classification, theorem/signature/proof review, CI, Verso, commit, push, or publication was performed.

## Isolation, model exposure, and limitations

This was a fresh-context independent referee task with durable reviewer identity `/root/e0_contract_referee_f`. I did not read any peer E or peer F report. I inspected draft 03 and historical referee D only as explicitly permitted historical context; neither verdict transferred, and draft 04 was judged against its own exact bytes and the accepted authorities. Isolation is a manual attestation, not technically enforced: the workspace is shared and writable, and I do not claim that plugins, credentials, network access, or other host facilities were technically excluded.

The dispatch requested a fresh Sol-family referee. The runtime exposed no independently verifiable exact serving build or model ID to this reviewer, so none is claimed. The `referee-lean-library` rubric made this an architecture-, dependency-, authority-, and durability-first audit rather than a tactic-level proof review. Future exact schema, validator code, source records, classifications, cards, proofs, signatures, Lean implementations, and integration heads require their own exact-artifact reviews.
