# Independent contract review D — Stage 1 first finite Chapter 4 companion, draft 03

## Controlled verdict

`request_changes`

Draft 03 is close to a sufficient deterministic contract for the bounded synthetic E0 slice, but two accepted pre-existing gates are absent from the stated E0 contract. Both are bounded repairs. This verdict does not request a production census, an authoritative effective-state fold, global closure, proof/coverage automation, CI, Verso, or any Lean implementation.

## Exact artifact bindings

- Candidate: `stage1-companion-schema-design-draft-03.md`, 420 lines, SHA-256 `0ca695804d589d2fec652f265a87d2f9c95a6d0e0095056dae1d39719896bb6f`.
- Accepted scope authority inspected in full: `blueprint/stage_1_dlmf-R7.md` at accepted scope commit `aebe7968bd6d5dcd23ac949d5d5e0d8854334ca1`, SHA-256 `4964a4ad79b8e8da0cdd376836383b189c32b38eaeecd9979dfdcca8cb54b4c2`.
- Root acceptance inspected in full: `root-stage1-r7-adjudication.md`, SHA-256 `2af2a524ca8eadd26540dcd5acec95caddb6d9fb4c1078622522144ef6be7644`.
- Repository snapshot: clean `main` at `b8d2f731fcfd5cd0889d0732f13699eb94681c86`.
- Existing protocol inspected in full: `review/PROTOCOL.md`, SHA-256 `7453bc0ca6985d7ca2e8c525d9655a94e412c48e3850b92d9367a9f643d3177d`.
- Existing classification authority inspected in full: `review/classifications-v3.json`, SHA-256 `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`.
- Existing validator patterns inspected at `scripts/validate_inventory.py`, SHA-256 `c954ce39762b160e7328846dc3740df242deb381b4d5da7995df70cd74b90a75`.

## Findings

### G1 — P1 — The E0 classification successor omits R7's mandatory ordinary-class rationale

**Location:** candidate lines 183–199 and 291–294; acceptance tests lines 321–324. Accepted R7 lines 745–763, especially 756–759.

The draft makes `source_semantics_class` total and single-valued, rejects cross-axis tokens, and correctly refuses NLP inference. However, its proposed successor and its enumerated E0 checks require only class presence, uniqueness, axis separation, and a synthetic reviewed-class binding. They do not require the frozen, occurrence-specific reviewed explanation that accepted R7 mandates for every `ordinary_exact_or_structural` atom: why the assertion is not asymptotic/approximative and why the finite-plus-recovery pair is inapplicable.

This is not merely explanatory metadata. It is the accepted non-waiver control that prevents the quantitative subset from shrinking through an unjustified ordinary row. An exact reviewed class token alone does not implement that control. Because R7 says the classification migration may not weaken its total-classification semantics, an E0 descriptor conforming to draft 03 could be approved while lacking a required field/artifact and could not soundly support the first real batch.

**Required bounded repair:** require every effective ordinary classification to contain or exactly bind a nonempty, frozen, occurrence-specific rationale in the same atom, snapshot/schema-set, and classification view. The containing classification artifact/view must retain its exact ID and exact-byte digest binding; no separate rationale artifact is required. E0 should validate those structural bindings only, while manual source/classification reviewers and root remain the authority for the rationale's mathematical truth. Add positive fixture data and negative cases for missing/blank rationale, wrong atom/view binding, and digest mismatch. Preserve the existing test in which the syntactically valid ordinary token on the synthetic asymptotic atom fails against the exact supplied reviewed binding, not through NLP.

**Blast radius and order:** classification descriptor/successor, synthetic fixture, validator branch, and focused tests only. No legacy byte, v3 meaning, production row, or global machinery changes. Confidence: high.

### G2 — P1 — Exact-signature binding does not preserve the complete pre-signature review gate

**Location:** candidate lines 219–230 and 327–332. Accepted R7 lines 829–840 and 1188–1195; existing protocol lines 128–179.

Draft 03 permits external selection of `exact-signature-binding` after “every required complete natural-language proof review” has passed, and its negative-test contract rejects only an absent required complete proof review. Accepted R7 is stricter: exact Lean signature design/freezing follows the complete natural-language proof and all required fresh proof, quantitative, and architecture/structural reviews. The current protocol also makes `structural_circularity_review` a separate representable gate when applicable, with explicit reviewed `not_required` treatment otherwise. Saying that exact-signature binding is not `lean_ready` does not cure an earlier forbidden signature freeze.

The omission is material for exactly the Chapter 4 work this contract is intended to enable: construction, continuation, existence/uniqueness identification, nontrivial source recovery, zeros, and theorem-sized hypothesis packets can trigger structural-circularity review. The current grammar could structurally accept and externally select a frozen exact-signature packet after proof review while the required structural review is missing.

**Required bounded repair:** make `exact-signature-binding` reference the exact selected pre-signature gate bundle and require structural representation of all applicable accepted R7 reviews: the complete proof plus required proof/quantitative reviews, and applicable architecture/structural-circularity review, or an exact-bound reviewed `not_required` record where the protocol permits it. Bind artifact IDs/digests and the relevant reviewer IDs/perspectives; E0 may check only fixture structure and exact bindings, while real independence, correctness, and external selection remain manual/root authority. Add focused negative fixtures for a missing required perspective/gate and for silently treating an absent structural gate as inapplicable.

**Blast radius and order:** binding descriptor, synthetic exact-signature witness, validator branch, and focused tests. Repair after G1 or independently; neither requires implementation, proof, card, or production data. Confidence: high.

## Rubric disposition

- **Mathematical intent:** request changes only for G1 and G2. The draft otherwise preserves Chapters 4–10 as the mathematical programme, Chapters 1–3 as finite consumer-justified support, and exact Lean mathematics as the eventual success criterion.
- **Reusable seams:** clear for this contract stage. The normalized ownership, context-membership, role-mapping, and typed authority-edge families are justified by multiple consumers or by a real trust boundary; no additional abstraction is required before E0.
- **Public API and theorem shape:** no Lean API is proposed or approved. The three binding levels correctly distinguish a frozen source-facing target, a nonbinding sketch, an exact signature, and later `lean_ready`, subject to G2.
- **Module and dependency design:** clear. The recovery edge points downstream from `Audit/SourceRecovery` to the semantic finite producer, and the draft does not authorize backward imports.
- **Mathlib integration:** clear/not yet applicable. E0 is a standard-library data validator and no Mathlib replacement or new theorem is proposed.
- **Proof architecture:** clear except G2. Later proof and Lean review remain separate; E0 does not claim proof correctness.
- **Cost and durability:** clear. Extending the existing standard-library validator is compatible with its current table-loader, explicit semantic checks, copied-fixture mutation tests, and deterministic diagnostic pattern. Strict JSON will require deliberate `object_pairs_hook` and non-finite-constant rejection rather than the current permissive default loader, which the draft already tests.
- **Refactor risk:** clear. The exact fifteen protected legacy inputs and their independent digests match the inspected clean baseline. The validator itself is correctly outside the protected set so E0 can extend it. Existing local validation and all 25 copied negative mutations passed unchanged.

## Positive determinations and explicit do-not-expand decisions

- The canonical `document -> leaf -> appearance -> claim` chain, typed `whole_document`/`whole_leaf` closure, exact stored projection equality, and `document_item` oracle are sufficient deterministic structural controls for one supplied finite batch. They deliberately do not prove actual-source exhaustion; complete manual forward/reverse source review remains authoritative.
- `CandidateAtoms` is visibly non-authoritative, and production `Target(S4,B4.1)` remains a partial value defined only after exact-bound manual source/classification reviews and external root selection. Synthetic `FX-` readiness cannot transfer authority to real data.
- The ordered external-artifact index, explicit genesis, strict backward positions, separate predecessor-event and prior-selection fields, and closed source/target-kind grammar are sufficient for E0 structural backreference checking. They do not compute current effective state, and draft 03 correctly leaves adverse/suspension/withdrawal semantics to complete manual review and root selection until a reviewed fold successor exists.
- Production IDs are immutable, aliases cannot mint appearances, genuine repeated locations remain distinct, and the first production view admits no unimplemented correction. This is adequate for the first finite packet without pre-building the later global correction/evolution system.
- The legacy golden set is exactly fourteen tracked inventory CSVs plus `review/classifications-v3.json`; all fifteen observed digests match Appendix A. There is no need to protect documentation or the validator, and no global directory hash should be introduced.
- Do not require a Chapter 4–10 census, global denominator, global fold, support traversal, proof coverage, completion evaluation, card linting, CI, Pages, or Verso in E0. Those would reopen the accepted finite-slice boundary rather than resolve G1 or G2.

## Checks performed

- Read the candidate, accepted R7 scope, root adjudication, current protocol, classification v3, and relevant validator implementation paths.
- Ran the Lean-library inventory script against the clean repository snapshot: 16 Lean files, 4,623 lines, 29 definitions, 57 lemmas, and 128 theorems; no trust/resource markers were reported.
- Ran `python3 scripts/validate_inventory.py`: passed with 148 occurrences, 31 notations, 32 entities, 34 entity-evidence rows, 88 association rows, and the expected manifest totals.
- Ran `python3 scripts/validate_inventory.py --negative-tests`: all 25 intentionally invalid copied fixtures were rejected.
- Recomputed the fifteen Appendix A SHA-256 values; every value and path matches the candidate.

No build was run because the reviewed artifact is a natural-language pre-implementation contract and no Lean or repository code changed. No network retrieval, source audit, proof check, CI, commit, push, or publication was performed.

## Isolation, model exposure, and limitations

This was a fresh-context independent referee task with durable reviewer identity `/root/e0_contract_referee_d`. I did not read the peer C/D reports or reuse a peer verdict. I also did not read draft 02 or its referee reports; Appendix B was judged only as part of the candidate's own bytes. Isolation is a manual attestation, not technically enforced: the workspace is shared and writable, and no claim is made that plugins, credentials, network access, or other host facilities were technically excluded.

The dispatch requested a Sol-family reviewer. The runtime exposed only the GPT-5 family to this referee; no exact serving build or model ID was exposed or independently verified, so none is claimed. This report reviews contract logic and implementability, not actual DLMF bytes, source rights, mathematical classifications, theorem statements, proofs, Lean signatures, code, production data, or future reviewer independence.
