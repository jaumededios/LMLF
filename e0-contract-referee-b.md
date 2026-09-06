# Independent exact-artifact review — Stage 1 Chapter 4 companion contract draft 02

## Controlled verdict

**Verdict:** `request_changes`

The proposed E0/E1 split is directionally sound and compatible with the accepted bounded Stage 1 architecture: E0 produces only structural candidate IDs and fixture-only synthetic targets; production `PartitionReady` and `Target` remain undefined until exact manual source/classification reviews and external root selection; cards, signatures, proofs, implementations, coverage, and integration retain their own later gates. The draft is not yet a sufficiently determinate executable contract, however. Three P1 gaps leave required E0 acceptance tests without a unique trustworthy implementation, and one P2 gap leaves “strict JSON” under-tested.

This is a fixable bounded-contract verdict. It does not reopen DD-021 revision 6, require global authority folding before the first finite source packet, or require CI, Verso, publication, a production census, or source-wide automation.

## Exact review binding and inspection scope

- Candidate: `/workspace/Documents/Codex/2026-09-05/LMLF-review-evidence/stage1-companion-schema-design-draft-02.md`, SHA-256 `271758691cf4e4cfd3753aaac55c972de66e9697cf96747f6d4613fc20d9fc35`, lines 1–283, read in full.
- Accepted scope: `/tmp/lmlf-stage1-scope.DbhM9YHt/blueprint/stage_1_dlmf-R7.md`, SHA-256 `4964a4ad79b8e8da0cdd376836383b189c32b38eaeecd9979dfdcca8cb54b4c2`, lines 1–1265, read in full.
- Root scope adjudication: `/tmp/lmlf-review-evidence.3kYJG0or/spec-aebe7968bd6d5dcd23ac949d5d5e0d8854334ca1-stage1/root-stage1-r7-adjudication.md`, SHA-256 `2af2a524ca8eadd26540dcd5acec95caddb6d9fb4c1078622522144ef6be7644`, read in full. It accepts the R7 artifact above at commit `aebe7968bd6d5dcd23ac949d5d5e0d8854334ca1` only for its bounded programme/architecture subjects and explicitly grants no schema, source, theorem, proof, implementation, or coverage authority.
- Repository snapshot: clean `main` at `b8d2f731fcfd5cd0889d0732f13699eb94681c86` (`origin/main` equal at inspection time).
- Existing protocol: `review/PROTOCOL.md`, SHA-256 `7453bc0ca6985d7ca2e8c525d9655a94e412c48e3850b92d9367a9f643d3177d`, read in full.
- Frozen classification artifact: `review/classifications-v3.json`, SHA-256 `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`, read in full.
- Current validator: `scripts/validate_inventory.py`, SHA-256 `c954ce39762b160e7328846dc3740df242deb381b4d5da7995df70cd74b90a75`; its header/key/enum/loading/foreign-key/semantic checks, negative-fixture mutation harness, and CLI/result paths were inspected. The 14 tracked `blueprint/inventory/*.csv` inputs and their current layout were inspected as the legacy input set.
- Local baseline evidence independently rerun: `python3 scripts/validate_inventory.py` passed; `python3 scripts/validate_inventory.py --negative-tests` passed all 25 current copied-data mutations. These runs establish only the present legacy validator behavior, not E0 implementation or source correctness.
- Referee identity: `/root/e0_contract_referee_b`. Isolation was a fresh agent task context; the filesystem was shared and writable, so this is a manual fresh-context attestation rather than a technically enforced clean room. No peer draft-02 review was read. The exposed model family is GPT-5; no exact serving build was exposed or independently verified.

## Prioritized findings

### G1 — P1 — The frozen legacy byte set and its golden identity are not defined

**Evidence.** Candidate lines 38–45 require ``function_inventory-v1`` and `review/classifications-v3.json` to remain byte-for-byte frozen, while lines 226–227 require golden SHA-256 checks to reject *any* byte change to “inventory-v1” or classifications-v3. ``function_inventory-v1`` is not an existing artifact or schema token in the inspected repository. The accepted R7 language instead identifies the existing `inventory-v1.0.0` **CSVs** (R7 lines 248–250). The actual legacy surface consists of 14 tracked CSV files under `blueprint/inventory/`, with documentation in `blueprint/function_inventory.md`; the draft neither enumerates which of those bytes are protected nor supplies an aggregate-manifest rule or exact golden digests. It also says the same validator must be extended (candidate lines 41–43 and 200–204), so “unchanged legacy validator” at line 226 cannot literally mean unchanged validator bytes. The current validator digest-pins classifications-v2 as v3's predecessor (`scripts/validate_inventory.py` lines 15–24 and 642–652), but it does not golden-pin its own v3 input or the inventory CSV set.

**Cost.** Two conforming implementers can protect different file sets while both claiming the required acceptance test. A changed legacy CSV could escape if only a schema label is checked, or E0 could accidentally freeze the validator/documentation itself and thereby contradict the authorized extension. This defeats the central non-regression boundary.

**Required bounded correction.** Replace ``function_inventory-v1`` with an exact repo-relative protected-file manifest. Bind each protected legacy CSV and `review/classifications-v3.json` to an ordinary SHA-256 digest, or define an unambiguous aggregate digest algorithm over an explicitly ordered path/digest manifest. State separately that `scripts/validate_inventory.py` is intentionally modified while the legacy inputs, legacy meanings, and legacy validation results remain unchanged. Bind the already known v3 digest `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`. E0 review should mutate one protected byte/path/digest at a time and prove rejection. No legacy migration is needed.

**Blast radius / confidence.** Contract text, the future descriptor/manifest, and focused golden tests only; no production data. Confidence: high.

### G2 — P1 — “Forward” authority references are not mechanically defined

**Evidence.** Candidate lines 173–190 correctly separate `predecessor_event_id` from `prior_selection_id`, reject timestamp precedence, and require all edges to point backward to already stored exact artifacts. Lines 208–211 then require E0 to check “ordered-backreference” semantics and reject forward edges, and lines 241–242 require forward/cyclic fixtures. But the required record fields at lines 178–185 contain no authoritative topological position, ordered bundle membership, catalog-predecessor binding, or genesis rule. Acyclicity alone distinguishes cycles from non-cycles; it cannot distinguish an acyclic “forward” reference from an acyclic valid dependency when issuance time is explicitly informational and file discovery order is non-authoritative. “Prior” and “post-event” therefore have no machine-checkable witness in the stated record families.

**Cost.** The E0 forward-edge negative can be implemented only by inventing an order (filesystem traversal, JSON list order, lexical ID order, timestamp, or an undocumented sequence field). Those choices have different authority semantics and some are mutable or replay-unstable. The resulting exact-digest DAG would not have one portable meaning.

**Required bounded correction.** Define one explicit structural order for an authority bundle, without implementing effective-state folding. A minimal design is an immutable ordered artifact index whose entries bind `(position, record_kind, artifact_id, exact_sha256)`; every authority edge must target a strictly smaller position, IDs are unique and typed, referenced bytes must hash exactly, and allowed edge kinds are enumerated. Define a genesis/empty-catalog case, the predecessor relation between catalog revisions (if catalogs are revised), the event → prior-catalog/view edge, catalog → earlier event/selection membership edges, and selection → post-event-catalog plus optional prior-selection edge. Keep each artifact's own digest outside the artifact it hashes. Then self, unknown, same/later-position, illegal-kind, and cyclic references are independently realizable negative tests. This is syntax/binding validation only; manual full review and root selection remain mandatory and authoritative.

**Blast radius / confidence.** External-record descriptor and synthetic JSON fixtures only; no authority fold or global automation. Confidence: high.

### G3 — P1 — The “missing leaf” rejection has no explicit structural oracle

**Evidence.** Candidate lines 24–30 and 52–63 require a finite content tree and source-owning leaves. Lines 89–100 correctly reserve semantic completeness for manual source review while asking E0 to enforce structural/relational parts. Lines 235–236 nevertheless require a missing-leaf fixture to be rejected. In the listed record families, the leaves themselves are the inventory: deleting a leaf together with its dependent appearance/membership rows can leave a smaller, internally closed tree with no dangling foreign key. No independent document-item enumeration, closed child list, declared leaf-key set/digest, or fixture payload oracle is required against which the validator can know that the absent leaf should exist. A dangling appearance is merely the separately listed broken-foreign-key case, not proof of source-payload exhaustiveness.

**Cost.** A weak E0 could pass the advertised missing-leaf test only because the hand-crafted mutation leaves another broken reference, while accepting the real structural omission the test purports to cover. Conversely, requiring E0 to infer omitted DLMF semantics would violate the draft's correct manual-review boundary.

**Required bounded correction.** Add a small explicit structural oracle for each synthetic document—e.g. normalized `document_item` keys with exactly one owning leaf, or an exact closed ordered item/leaf-key manifest—and require 1:1 coverage, uniqueness, and document/snapshot/schema-set agreement. The positive fixture should bind this oracle; the negative should delete the leaf and all dependent claim rows while retaining the expected item, proving a genuine missing-owner diagnostic. For production E0, label this only a structural reconciliation against supplied records; E1's complete manual review must still establish that the supplied document-item inventory exhausts the actual exact payload. No raw-source semantic parsing is requested.

**Blast radius / confidence.** One minimal descriptor/relation and two fixture mutations; no production census. Confidence: high.

### G4 — P2 — The strict-JSON acceptance set omits non-JSON numeric constants

**Evidence.** Candidate lines 72–74 and 208 require strict JSON, UTF-8, duplicate-key rejection, and exact-byte hashing, but the acceptance tests at lines 241–242 cover only duplicate keys and digest/DAG faults. Python's standard `json.load`, which the current validator uses at line 586, accepts non-standard `NaN`, `Infinity`, and `-Infinity` unless `parse_constant` rejects them. A duplicate-key hook alone would therefore not implement strict JSON despite satisfying the stated JSON negative.

**Cost.** External authority artifacts could differ across parsers and cease to be portable strict-JSON evidence.

**Required bounded correction.** State that RFC-JSON non-finite constants are rejected and add at least one `NaN`/`Infinity` negative. The implementation can remain standard-library-only by combining duplicate-key detection with `parse_constant` rejection and strict UTF-8 decoding. This does not require JSON semantic canonicalization; exact stored bytes remain the hash subject.

**Blast radius / confidence.** Parser helper and one small negative fixture. Confidence: high.

## Clear sections and do-not-expand decisions

- **Mathematical/programme intent:** clear. Candidate lines 14–15 preserve Chapters 4–10 specific-function success and Chapters 1–3 support-only status, matching accepted R7 lines 161–177.
- **E0/E1 gate direction:** clear. Candidate lines 118–148, 195–220, and 248–260 prevent E0 from emitting production readiness, target, proof, coverage, or completion; E1 retains complete exact manual source/classification reviews and root selection. Keep this boundary.
- **Classification architecture:** clear subject to G1's exact v3 binding. Candidate lines 150–171 preserve exactly the two successor classes, forbid a `mixed` escape hatch, require the ordinary mapping or the quantitative/recovery pair, and keep recovery downstream in `Audit/SourceRecovery`, matching R7 lines 726–841.
- **Legacy dependency direction:** clear. A companion namespace and extension of the existing standard-library validator is preferable to rewriting old-track rows or adding a second validator. Do not refactor the legacy tables into the DLMF model.
- **Deferred work:** correctly deferred. Deterministic effective-state folding, correction successors, global closure, support traversal, card linting, proof/coverage/completion, and integration need not precede the first finite Chapter 4 packet. The fixes above do not import any of them into E0.
- **Source rights boundary:** structurally adequate for this contract review: real E1 must bind exact notice bytes, time, digest, access, and contemplated use before retained real evidence. This review makes no legal determination and approves no source retention.
- **Lean/Mathlib architecture:** no Lean declaration, theorem statement, import change, or Mathlib-reuse claim is proposed in the candidate, so no proof-level or upstreaming finding applies.

## Minimal useful revision and implementation path

1. Revise only this bounded contract to resolve G1–G4: exact legacy freeze manifest, explicit authority artifact order/edge grammar, synthetic document-item coverage oracle, and strict-JSON non-finite rejection.
2. Obtain fresh exact-artifact reviews and root selection for that successor digest. This report cannot transfer approval to changed bytes.
3. In E0, add the reviewed companion descriptors and reviewed classification successor, then extend the existing validator behind a separate companion path while preserving the legacy validation path and outputs.
4. Add one `FX-`-namespaced positive finite Chapter 4-shaped fixture and focused adversarial copied-fixture mutations. Fixture IDs and fixture readiness witnesses must be unambiguously unable to collide with or authorize production IDs.
5. Rerun the unchanged legacy data checks, all legacy negative mutations, protected-byte golden checks, all companion positive/negative checks, and a real-data-mode smoke test showing only structural diagnostics plus candidate IDs.
6. Stop E0 there: no production DLMF rows, source approval, schema/classification approval by the implementer, readiness/coverage, card/proof/code authority, CI, Verso, commit, push, or publication follows from those tests.

## Authority limitation

This report reviews only the exact natural-language candidate digest named above against the named accepted scope and inspected repository seams. It is not a model-build attestation, root adjudication, implementation proposal acceptance, schema descriptor approval, classification-authority approval, source or rights review, source-census approval, production-data review, theorem-card or signature approval, natural-language-proof review, Lean implementation review, integration review, or coverage/completion evidence. The first actual source data, the exact implemented schemas and classification successor, and every later card/proof/code artifact require their own exact reviews and selections.
