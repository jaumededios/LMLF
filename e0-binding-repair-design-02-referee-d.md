# Independent design referee D — E0 exact-binding repair design 02

## Verdict

`request_changes`

The proposal has the right bounded architecture: it repairs the manifest/witness cycle, keeps exact signatures later than mathematical proof review, treats raw bytes differently from strict JSON, permits a requested validation level without persisted lower-level rows, and grants no production/source/proof authority. Three implementation-determinism defects remain. They are local schema repairs, not reasons to add an authority fold, global completeness engine, or mathematical-truth automation.

## Review identity, inputs, and isolation

- Reviewer task identity: `/root/e0_binding_design02_referee_d`.
- Parent-attested requested configuration: `gpt-5.6-sol`, `reasoning_effort: high`, `fork_turns: none`. The actual serving build/model identifier was not exposed to this referee and is therefore unavailable rather than inferred.
- Runtime: Codex in a shared Linux workspace.
- Proposed design reviewed in full: `e0-binding-repair-design-02.md`, SHA-256 `c50fa7d136dfb63b3af4fc2deca84929028879c24b282b7b54c9daa8d30e93b7`.
- Accepted controlling companion design reviewed in full: `stage1-companion-schema-design-draft-04.md`, SHA-256 `e3dacb11c97ec059ae8f48e3fc81f3155fbf86c2cd5679c69541852c2d1fdc7b`.
- Repository protocol reviewed in full from rejected baseline: `review/PROTOCOL.md`, SHA-256 `7453bc0ca6985d7ca2e8c525d9655a94e412c48e3850b92d9367a9f643d3177d`.
- Relevant programme authority checked: `blueprint/stage_1_dlmf-R7.md` at commit `aebe7968bd6d5dcd23ac949d5d5e0d8854334ca1`, SHA-256 `4964a4ad79b8e8da0cdd376836383b189c32b38eaeecd9979dfdcca8cb54b4c2`; preparation/privacy checkpoint SHA-256 `f0bf1f8c72b68ec9e721ad7d7b642b5d5850473440120b3532e52ed623b020f7`.
- Exact rejected baseline: clean `/tmp/lmlf-e0-companion.hFHPMOuG` at `26f4051e13f3a7bc558c225138458f211bf31597`.
- Context-only implementation worktree: `/tmp/lmlf-e0-fixes.Tx3HrElD`, same HEAD, dirty in `review/companion-v1/README.md` and `scripts/companion_contract.py`. It was not an immutable review input and was not edited.
- No applicable repository `AGENTS.md` was present. I used the complete `referee-lean-library` instructions and global rubric. The deterministic inventory script was run read-only.
- Isolation was manual, not technically enforced: this was a new no-fork task context and no peer reports were supplied or read, but the filesystem was shared and writable and network capability existed. I did not contact the design author, use network services, run CI, commit, push, or modify either repository. The only write is this report.

## Findings

### G1 — P1 — `reviewer_verdict` has mutually incompatible subjects without a discriminated variant

Design clause 16 says a `reviewer_verdict` subject triple must equal the early `gate_review_record` it judges and that its proof/NLP-not-required references must match that gate. Clauses 3 and 204–208 instead require source/classification decision verdicts to carry the `batch_closure_witness` subject triple. Both uses name the same `reviewer_verdict` artifact family, and the proposal supplies neither a discriminator nor a closed subject-kind matrix.

Consequently, a literal implementation must either reject the required authority verdicts because their subject is not a gate, or weaken clause 16 and admit verdict shapes whose required proof references and permitted consumers are unknown. This is not merely a quorum question: the exact bytes cannot be typed consistently before any manual authority decision occurs.

Minimal repair: define two recursively closed variants under one explicit discriminator (for example `verdict_scope: pre_signature_gate | batch_closure`) or two record kinds. The gate variant must require an exact gate subject and the gate's proof/NLP-NR correspondence fields and be consumable only by the pre-signature bundle. The closure variant must require the exact closure-witness subject, forbid proof/NLP-NR fields, carry only the allowed source/classification perspectives, and be consumable by the corresponding decision event/root-selection path. Add cross-use negative fixtures in both directions. No authority edge change is needed.

### G2 — P1 — the claimed closed wire contract is not yet recursively specified

The design promises closed types and recursively closed schemas, but clause 4 gives only categories of artifact kinds, not the exact `record_kind` tokens or a kind-to-codec dispatch. Clauses 7–9 and 11–18 describe most JSON records semantically but do not give exact root and nested key sets, scalar/null/Boolean rules, digest syntax, reference-target kinds, uniqueness rules, or optional-field encoding. Only `issue_evidence` receives an exact key set. The “exact ordered projections” in the closure witness also lack canonical sort keys even though the text later speaks of recomputed sets.

The normalized delta has the same problem. Exact headers are supplied for `audit_batches.csv` and `source_spans.csv`, but not for the changed `payload_evidence.csv`, `source_semantics.csv`, or `role_bindings.csv`. This matters directly at source-batch: clause 192 requires card and declaration endpoints to be independently `pending` or `supplied`, while clause 92 does not identify the two state columns or their exact artifact-reference columns. Two reasonable validators could disagree about a supplied declaration with a pending card, whether the existing single `endpoint_state` remains, and whether an intrinsically frozen supplied card is accepted without treating its target as bound.

Minimal repair: add one bounded wire-schema appendix and regenerate the two descriptor CSVs from it. It should list each exact record-kind token, encoding (`raw` or strict JSON), exact root/nested fields and types, enum values, absent-versus-null convention, reference target kinds, ID uniqueness key, array order/deduplication rule, and raw-byte length/digest obligations. Give exact replacement CSV headers. For `role_bindings.csv`, state the independent card/declaration source-batch state matrix and test all four pending/supplied combinations, including a supplied artifact whose intrinsic lifecycle is `frozen` but whose row remains nonbinding. This is a local finite table, not a general schema framework.

### G3 — P1 — per-role proof versus direct-reuse `not_required` is not mapped deterministically to review gates

Clauses 13–14 give proof metadata and NLP-NR records role-key sets, and clause 171 correctly requires those sets to partition every role. But the source of each role's `required` versus `not_applicable` assignment is only partially stated: the NR path must match its frozen card, while the required path has no symmetric explicit correspondence rule. More importantly, clause 15 gives each `gate_review_record` one applicability/state and “proof-metadata or NLP-NR triples as applicable,” without saying whether a claim with one proved role and one direct pinned-Mathlib-reuse role has one mixed gate or multiple role gates, how either choice is keyed, or what exact set equality the pre-signature bundle enforces.

That ambiguity is observable in the required positive behavior: clause 229 asks an actual raw-Markdown role and a separate direct-reuse NLP-NR role to reach a bundle, but does not require them to be roles of the same claim. A validator could pass that fixture while being unable to represent the mixed lifecycle for the two roles of one quantitative claim. It could also bind a reviewed NR record while omitting another role's proof review, yet still have a syntactically present bundle.

Minimal repair: choose and specify one local representation. Either (a) make the NLP gate explicitly per role with a required `role_key` and exactly one proof or NR binding, or (b) make one per-claim NLP gate carry two exact arrays whose disjoint union equals the subject's role set, with explicit aggregate applicability/state semantics. In either form, the frozen card's applicability must agree for both the required and NR branches; the bundle must require exact role-set equality with no duplicate or extra paths; every verdict must judge that exact gate; and structural-circularity remains a separate gate. Add a same-claim mixed-path positive fixture plus omitted, duplicated, swapped-role, and wrong-card-applicability negatives. The direct Mathlib path should terminate at an exact pinned revision/interface identity, as R7 requires, without recensusing Mathlib.

## Clear checks and bounded approval conditions

- The source/core graph is acyclic as written: removing witness fields from `audit_batches.csv`, keeping locators outside the manifest, placing earlier immutable JSON under the manifest, and placing the closure witness after the manifest remove the prior transitive hash cycle.
- The proof/signature graph is also acyclic: cards/targets precede the early subject and proofs; the signature packet cannot name the early review chain; correspondence follows both; the role row follows correspondence. The unchanged backward-position authority grammar and externally bound, non-self-indexing authority index remain sound.
- Raw payload, notice, Markdown, and descriptor bytes are correctly treated as typed external objects rather than fake self-declaring JSON. Digest-before-CSV-parse and no transcode/re-encode identity are the right rules. G2 asks only that the finite kind/codec table be made exact.
- Source spans, the 28-member core manifest, and closure projections establish typed synthetic reachability and finite equality only. They do not establish semantic evidence adequacy, actual source exhaustion, rights, or production selection.
- Source-batch correctly grants no freezing or authority from intrinsic artifact lifecycle metadata; card binding and exact-signature correspondence remain later stages. Exact-signature-only validation is explicitly compatible with the accepted E0 rule that lower-level history rows are not mandatory.
- The proposal correctly reserves NLP `not_required` for reviewed direct pinned-library reuse and does not use it to erase structural-circularity review. No concrete Mathlib declaration is proposed, so there is no theorem analogue to verify in the pinned environment at this design stage.
- The programme boundary remains Chapters 4–10, with Chapters 1–3 only as finite consumer-justified support. E0 remains synthetic and does not claim actual source coverage or final programme progress.

After G1–G3 are incorporated into new exact bytes and independently re-reviewed, I see no need to expand this repair beyond the accepted E0 boundary.
