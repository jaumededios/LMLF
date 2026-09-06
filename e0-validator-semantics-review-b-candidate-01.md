# E0 validator semantics review B — candidate 01

## Exact review identity and boundary

- Candidate: `/tmp/lmlf-e0-companion.hFHPMOuG`
- Base commit: `e3b4cafa7f8d1e8b033806737eab23e641a401d8`
- Reviewed clean HEAD: `26f4051e13f3a7bc558c225138458f211bf31597`
- Reviewed tree: `85bc0bbd802c2ae8044a3bf4f66e6f5cb00b542c`
- Changed paths: exactly 66 under `scripts/validate_inventory.py`, `scripts/companion_contract.py`, `review/classifications-v4.json`, and `review/companion-v1/**`
- Independently reproduced path-ordered ordinary-SHA/path-lines digest: `ada01f62cb31d08eb7dee69721b83b8ac07ac2876684a1b0dc1af1c8b2b70454`
- Contract: `stage1-companion-schema-design-draft-04.md`, independently reproduced SHA-256 `e3dacb11c97ec059ae8f48e3fc81f3155fbf86c2cd5679c69541852c2d1fdc7b`
- Unchanged protocol: `review/PROTOCOL.md`, SHA-256 `7453bc0ca6985d7ca2e8c525d9655a94e412c48e3850b92d9367a9f643d3177d`

I read the complete contract, unchanged protocol, all 66 candidate paths, and the relevant immutable base objects. I did not read proposer or other referee reports. I made no candidate edits and performed no Lean, `main`, site, commit, push, CI, publication, or external-API action. The candidate remained at the exact clean HEAD/tree above after review. The preparation-only note remains separate and carries no approval.

## Verdict

**`request_changes`**. The defects below are implementation/schema defects that appear repairable without reopening draft 04, so I do not issue `block`. The frozen candidate does not yet implement E0's exact source/subject bindings, level semantics, closed typed JSON surface, or a truthful production-mode representation strongly enough to enable the first finite real Chapter 4 batch.

No prior approval transfers to this head. This review grants no DLMF source, readiness, classification, theorem, proof, coverage, Lean, integration, or completion credit. E0 synthetic output remains zero programme-result credit.

## Findings

### G1 — Exact source, closure, rights, and root-selection subjects are not bound (`request_changes`, high)

The tables describe structural IDs, but an in-scope candidate is not required to have any representation → retrieval → exact-payload evidence chain. In a disposable copy I removed every row from `representations.csv`, `retrieval_observations.csv`, and `payload_evidence.csv`; validation still returned no errors and still emitted both `CandidateAtoms` and the synthetic fixture `Target` unchanged. This follows from `scripts/companion_contract.py:349-367`, where supplied evidence is checked, but no batch/snapshot/document/candidate completeness relation requires that evidence.

The schema also has no exact rights-notice binding usable by E1, no source locator/span or source-record artifact binding on a document item, appearance, or claim, and no binding from a schema-set ID to exact schema-descriptor bytes. The validator's own real-mode positive control proves the last point by accepting `E0TEST-SCHEMA-1` although the only descriptor identity is `FX-SCHEMA-1` (`scripts/companion_contract.py:22`, `328-345`). Thus a production row can name an unreviewed schema set.

Most importantly, neither the synthetic readiness witness nor the external authority sequence binds the exact batch revision, table-byte set, ownership closure, or all included claims. The witness binds only snapshot/schema/batch/view IDs and `candidate_atoms` (`scripts/companion_contract.py:716-729`); the event/selection records resolve locator IDs/digests but not the selected batch's exact records (`918-952`). I added a new excluded mathematical-reference claim to the selected closure and matching view/projection rows while leaving the readiness witness and all authority bytes untouched; the same `Target` was accepted. Separately, a fully rehashed event with unrelated `subject_kind`, unrelated `subject_id`, and a reviewer ID that disagreed with its bound verdict was accepted.

This is not merely deferred authority folding. Draft 04 permits folding to remain manual, but requires the source/classification reviews and root selection to bind the exact snapshot, batch revision, ownership closure, candidate set, fidelity/exclusion decisions, and source view. There is currently no exact artifact subject on which that manual selection can operate. Before acceptance, add a closed, exact-byte batch/schema/rights/source binding (or equivalent normalized bindings), require every in-scope source owner to reach its exact payload evidence, and make authority subjects/reviewer records resolve to those exact typed artifacts and IDs.

### G2 — Real mode requires synthetic claims instead of separating fixture and production records (`request_changes`, high)

`role_bindings.csv.synthetic_fixture` and `validation_levels.csv.synthetic_selected_witness` accept only the string `true` (`scripts/companion_contract.py:114-116`), and every exact-signature gate bundle is required to say `synthetic_fixture: true` and `selected: true` regardless of mode (`772-775`). Conversely, real-mode validation rejects only FX-prefixed IDs and batch-level readiness witness fields; it does not reject synthetic booleans on production-shaped artifacts/rows (`337-345`, `736-737`). The built-in real-mode positive control consequently passes only by renaming the FX IDs while retaining all synthetic `true` flags.

This prevents truthful E1 records: a real role/level must falsely claim to be a synthetic selected witness, while a non-FX bundle carrying synthetic self-status is accepted. The inverse check is also missing: after changing `readiness-witness.json.synthetic_fixture` from JSON `true` to `false` and consistently rebinding its digest, fixture validation still emitted the fixture `Target` (`artifact_schemas` checks key sets only at `495-507`; witness content checks omit the flag at `721-729`).

Require mode-consistent typed booleans (synthetic true only for FX fixtures; production false/absent as designed), keep candidate-owned `selected` from acting as production selection, and make fixture `Target` conditional on an explicitly true, exact-bound synthetic witness.

### G3 — Same-level endpoint states and simultaneously supplied transitions are internally contradictory (`request_changes`, high)

The level-specific checks do not implement the stated endpoint state machine:

- Replacing the ordinary `source-batch` role row with its otherwise unchanged exact-signature row—frozen card, frozen declaration, exact signature packet, and gate bundle—was accepted. Lines `624-637` explicitly permit a `frozen_card` at source-batch and do not prohibit declaration/signature/gate fields when `endpoint_state=bound`, contrary to “No card, declaration, or signature is frozen here.”
- Changing a complete `card-binding` row's `endpoint_state` from `bound` to `pending` was accepted, as was the same mutation at `exact-signature-binding`; lines `638-678` never relate `endpoint_state` to those levels' required bindings.
- With all three rows simultaneously supplied, changing the card-binding proposed declaration from `FX-DECL-ORDINARY` to `FX-DECL-DIFFERENT` while leaving the exact-signature declaration as `FX-DECL-ORDINARY` was accepted. There is no cross-level carry-forward consistency check.

Per root's architectural clarification, I do **not** treat a request containing only one level as defective merely because duplicate lower-level history rows are absent. The finding is limited to contradictions within a requested level and drift among levels that are simultaneously supplied. Implement a closed per-level field/state matrix and compare carried endpoint identities across supplied levels.

### G4 — The selected pre-signature bundle does not bind a complete proof/review subject (`request_changes`, high)

The exact-signature role binds a gate-bundle digest, but the bundle has no batch, claim, card, declaration, or signature-packet subject. A single subjectless fixture bundle is reused across the ordinary role and both quantitative roles. Its purported natural-language proof is a `reviewed_gate_artifact` containing only `record_kind`, `artifact_id`, `artifact_kind`, and `synthetic_fixture`; it contains or binds no proof content, target, or proof-artifact digest (`artifact_schemas` at `495-503`; fixture `artifacts/gate-nlp.json`). Consequently, the exact-signature binding does not select the complete natural-language proof or demonstrate that reviews concern the relevant target.

Although gate-review rows check reviewer ID and verdict subject ID/digest, reviewer-verdict field types and verdict vocabulary are not validated. I changed a bound verdict's `verdict` from `"approve"` to `[]`, updated every affected digest, and the bundle passed. In the authority path, reviewer rows check only locator kind/digest (`940-949`), not the verdict's declared reviewer/subject. Issue events have the same problem: `issue_evidence.issue_id` is never compared with the event's issue; a rehashed wrong-issue artifact passed (`509-516`).

E0 need not establish real passage, independence, freshness, applicability truth, quorum, or perspective sufficiency. It must nevertheless bind the actual complete proof and typed review records to the exact relevant subject. Add exact subject/content bindings and validate the controlled record types while retaining the external human/root authority boundary.

### G5 — Structured JSON schemas and field types are only partially closed (`request_changes`, medium)

The strict byte parser itself is good, but successful parsing is often followed only by a top-level key-set test or a few selected values:

- `classifications-v4.json` validation ignores its exact top-level key set and the types/values of `record_kind`, `artifact_revision`, `status`, `ordinary_rationale`, `semantics`, `axis.level`, `axis.cardinality`, and nested extra keys (`scripts/companion_contract.py:234-250`). A disposable copy with wrong container/scalar types and extra keys at all those locations produced no descriptor error.
- `authority-index.json` checks its top-level key set but not the types/values of `schema_version`, `record_kind`, `artifact_id`, or `external_digest_binding_notice` (`867-875`). Replacing them with `[]`, `42`, and `null` passed.
- Nested exact-signature declaration objects have no closed schema; adding an unknown field to a selected declaration and rebinding the packet digest passed (`675-678`).
- Gate perspectives require a subset but permit unknown controlled-vocabulary values; adding `not_in_protocol` passed (`815-827`).
- Known artifact schemas compare keys but generally do not check each field's JSON type/value (`495-507`), enabling the wrong-type verdict above.

Complete recursive closed-shape/type/enum validation is required. Python boolean-versus-integer separation is correctly handled for authority positions and should be used consistently elsewhere.

## Independently confirmed positive properties

- All fifteen Appendix A protected paths reproduce their exact contract digests. The constants are embedded outside the candidate manifest, and the built-in self-edit/path-set/protected-byte mutations reject as intended.
- The legacy default path passes unchanged, and all exactly 25 legacy negative mutations retain their results.
- `source_semantics_class` is a distinct atom-level axis with exactly the two required tokens; v3 remains byte-identical and continues through the old loader. Missing/duplicate class rows, cross-axis tokens, ordinary blank/wrong-owner rationale, vocabulary digest drift, and separately bound synthetic class mismatch are rejected.
- The positive ordinary rationale is nonblank and its classification record is exact-byte, claim, snapshot, schema-set, and classification-view bound through the normalized row. This confirms useful local machinery, subject to G1's missing exact source/batch selection binding.
- Ownership, typed foreign keys, parent acyclicity, item oracle, document/leaf closure, exact optional projections, context non-expansion, claim-kind reconciliation, distinct appearances, well-posed/contradicted retention, and fixture candidate enumeration behave as expected in the supplied and focused mutations.
- Ordinary/quantitative role cardinalities, distinct quantitative cards/declarations, recovery dependency direction, frozen card/source target membership, exact declaration membership, required gate presence, explicit reviewed `not_required`, and missing required perspectives are checked in the intended direction, subject to G3–G5.
- The strict JSON decoder independently rejected top-level and nested duplicate keys, invalid UTF-8, `NaN`, `Infinity`, `-Infinity`, overflow-to-infinity, comments, and trailing commas. Exact-byte whitespace/digest mutation and artifact-root traversal/symlink escapes reject.
- The ordered authority index correctly rejects self/same-or-forward/unknown/digest-mismatched/wrong-kind/illegal edges, noncontiguous or noninteger positions, self-indexing, and predecessor-field conflation. No effective-state fold is claimed.
- Real-mode stdout omits `Target`, and all supplied notices correctly deny authority, readiness, `lean_ready`, coverage, implementation acceptance, and completion.

## Commands and evidence

All commands were local at the exact HEAD. Relevant results:

```text
python3 scripts/validate_inventory.py
  exit 0; unchanged legacy summary

python3 scripts/validate_inventory.py --negative-tests --companion-tests
  exit 0
  negative invariant tests passed: 25
  CandidateAtoms={"FX-B4.1": ["FX-O1", "FX-O2"]}
  Target[synthetic_fixture_only]={"FX-B4.1": ["FX-O1", "FX-O2"]}
  real-mode positive control: CandidateAtoms only; Target omitted
  companion negative tests passed: 74

python3 -m compileall -q scripts
python3 -m tabnanny scripts/validate_inventory.py scripts/companion_contract.py
git diff --check e3b4cafa7f8d1e8b033806737eab23e641a401d8 HEAD
  all exit 0
```

Independent adversarial runner: `/tmp/e0_review_b_adversarial.py`, SHA-256 `50b8bd59efee8fb02c3eef117d2a0d74f51f03a4ee28a9f2d145046422cbc2fc`. It used temporary copied bundles/artifacts, recomputed affected exact digests and authority-chain hashes where applicable, and did not edit the candidate. It reproduced every acceptance described in G1–G5. The malformed strict-JSON cases were also rerun directly against `strict_json_bytes` and all rejected.

`lake build` was intentionally not run: the delegated review explicitly excluded Lean, the 66-path E0 change contains no Lean files, and this verdict neither challenges nor grants any separate accepted Lean/build evidence.

## Finite first-packet implementability judgment

The normalized finite-scope tables, closure computation, role cardinalities, and local real-mode CLI are bounded and do not inherently require a Chapter 4–10 census, global event fold, global support traversal, card linting, proof coverage engine, or other deferred automation. That part of the design is implementable for one `B4.1`.

However, this exact implementation is **not yet usable for the first real packet**: it cannot truthfully represent non-synthetic role/level/gate records; it does not require or bind the DLMF rights notice and exact payload chain to in-scope candidates; and it provides no immutable exact batch/closure artifact for source/classification review and root selection. Fixing G1–G5 is therefore required before E1 production rows or IDs are added.
