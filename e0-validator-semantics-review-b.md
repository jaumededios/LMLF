# E0 validator semantics review B — preparation only

## Status

Preparation only. No candidate implementation was inspected and no verdict, approval, source/readiness/coverage credit, or Lean result is issued here. The implementation worktree was still changing when this note was prepared. A final review begins only after root supplies one exact frozen implementation identity.

Reviewer scope is validator semantics and bounded implementability. This reviewer will not inspect other reviewer reports and will not perform Lean, `main`, site, commit, push, CI, publication, or external-API work.

## Bound inputs already checked

- Contract: `/workspace/Documents/Codex/2026-09-05/LMLF-review-evidence/stage1-companion-schema-design-draft-04.md`
- Contract SHA-256: `e3dacb11c97ec059ae8f48e3fc81f3155fbf86c2cd5679c69541852c2d1fdc7b` (locally reproduced)
- Candidate base: `e3b4cafa7f8d1e8b033806737eab23e641a401d8`
- Candidate path reserved for the later frozen review: `/tmp/lmlf-e0-companion.hFHPMOuG`
- Base inspection was through the named Git object, not changing worktree bytes.
- No applicable `AGENTS.md` was found in the workspace ancestor path or base tree.
- The base validator is one Python standard-library validation path and contains exactly 25 legacy negative mutation cases.
- The base v3 authority is `review/classifications-v3.json`, schema `lmlf-classification-v3`; the contract binds its SHA-256 as `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`.

## Freeze intake required before review

Root must provide an exact freeze identity (preferably commit ID; otherwise an exact tree/diff/artifact digest plus an explicit changed-path list). Before reading implementation bytes, this reviewer will:

1. reproduce that identity and record `git status --short`, the exact base, changed paths, and diff summary;
2. reject review drift if bytes change during review;
3. compute ordinary SHA-256 for every new or changed descriptor, vocabulary, fixture, and external artifact used by a passing case;
4. verify the contract remains the exact digest above; and
5. verify the fourteen protected CSVs plus v3 against Appendix A independently of candidate-owned manifests.

## Independent review and test matrix

### 1. Classification successor and v3 orthogonality

- Confirm the successor names the exact v3 path, schema, and digest as an immutable predecessor/dependency and that the old loader still reads the unchanged v3 file.
- Confirm `source_semantics_class` is a distinct mandatory atom-level axis with exactly the two contract tokens, is single-valued in the effective fixture view, and never changes packet/target v3 semantics.
- Mutate each DLMF token into representative v3 packet and target theorem/coverage/novelty fields; mutate representative v3 tokens into `source_semantics_class`; require failure for axis placement rather than semantic inference.
- Require missing and duplicate effective class rows to fail.
- For the ordinary atom, independently verify the nonblank occurrence-specific rationale binds the exact atom, snapshot, schema set, classification view, containing artifact ID, and the digest of the actual referenced bytes. Test missing/blank rationale and each binding independently.
- Change the synthetic asymptotic atom to the syntactically valid ordinary token while preserving the externally reviewed fixture binding; require the declared binding mismatch to fail without NLP or mathematical inference.

### 2. Exact artifact, subject, and digest bindings

- Enumerate every record that purports to bind payload, rights, classification, review verdict, card, frozen source-facing target, natural-language proof, gate bundle, signature packet, authority target, or root selection.
- For every positive binding, open the exact referenced bytes, reproduce SHA-256, decode under the declared record format, and match declared record kind, artifact ID, and subject kind/ID. A merely well-formed digest string is insufficient.
- Substitute an unrelated but valid artifact, subject, kind, ID, digest, and (for indexed authority records) position one at a time; require fail-closed diagnostics.
- Require lowercase 64-hex SHA-256 where the schema claims SHA-256. Verify a whitespace-only rewrite under the old digest fails.
- Check that the authority index does not index/hash itself and that its own digest is bound only by the separate external review/root envelope.
- Exercise the complete closed typed-edge grammar, including the non-aliasing of `predecessor_event` and `prior_selection`, exact target position, and strict backward order.

### 3. Validation levels, roles, and endpoints

- Check the only levels are ordered `source-batch`, `card-binding`, and `exact-signature-binding`; no shared permissive row shape may silently admit fields or states from another level.
- At every level, require exactly one ordinary role and exactly the two quantitative roles. Pending endpoints must not excuse missing or duplicate roles.
- At `source-batch`, test explicit pending card/declaration endpoints and typed consistent supplied endpoints; reject frozen/exact claims that bypass later levels.
- At `card-binding`, require the exact frozen card and frozen source-facing mathematical target. Permit only pending declaration or proposed declaration plus explicitly nonbinding sketch. Reject unfrozen cards, absent target bindings, and purported exact signatures. Require distinct quantitative cards.
- At `exact-signature-binding`, require exact declaration identity inside an independently reviewed frozen exact-signature packet and the exact selected pre-signature bundle. Require distinct quantitative cards and declarations and validate producer/consumer direction for source recovery.
- Mutate role, subtype, endpoint state, card, declaration, packet, and bundle bindings separately. Verify helpers, entity identifications, notation equivalences, and implicit cross-track links cannot substitute for a required role or claim source credit.

### 4. Complete selected pre-signature gate bundle

- Verify the positive bundle structurally contains the complete natural-language proof plus every required proof/quantitative and architecture/structural-circularity perspective named by the descriptor/protocol.
- Every gate must bind exact artifact ID/digest, relevant reviewer ID, controlled perspective, and permitted status. Absence must never mean inapplicable.
- A `not_required` gate must be protocol-permitted, exact-bound, reviewed, and carry a nonblank applicability reason.
- Delete each required gate/perspective in turn; mutate status, reviewer, perspective, subject, artifact, and digest; require failure. Specifically delete or relabel structural-circularity and require failure.
- Confirm E0 checks only supplied structure and does not claim real passage, freshness, independence, applicability, perspective sufficiency, quorum, or root authority.

### 5. Closed schemas and malformed-record handling

- Inventory every CSV header and every JSON object/array shape. Require unknown files/fields, missing required fields, duplicate logical keys, wrong nesting, wrong scalar/container types, nulls where disallowed, and invalid enum values to fail rather than be ignored.
- Pay special attention to Python type traps (`true` accepted as integer), blank strings, whitespace-only IDs/rationales, zero/negative/duplicate/nonintegral positions, and heterogeneous arrays.
- For every structured JSON parser entry point, independently test invalid UTF-8, duplicate keys at top level and nested depth, comments, trailing commas, `NaN`, `Infinity`, and `-Infinity`.
- For CSV, test invalid UTF-8, exact header mismatch, duplicate header names, extra/missing columns, blank rows, malformed quoting, and schema-set drift.
- Confirm malformed records cannot survive as partially loaded objects, candidates, targets, endpoints, gates, or authority edges after an error; failures must be nonzero and fail closed rather than crash with a traceback.

### 6. Ownership, closure, candidates, and human authority

- Recompute canonical document → leaf → appearance → claim ownership independently and compare all repeated snapshot/document/leaf/schema-set keys.
- Test whole-document and whole-leaf closure, overlap deduplication, exact equality of optional projections, context-only document non-expansion, and sibling cherry-pick rejection.
- Test the document-item oracle: missing leaf owner after leaf/dependent deletion, duplicate and cross-document ownership, empty leaf, and container-owned payload.
- Confirm all four reconciled claim kinds remain members, while only eligible atomic targets enter `CandidateAtoms`; provisional/reference/remainder rows must not disappear from scope.
- Confirm the two positive fixture appearances/atoms remain distinct, share context only through explicit membership, include one ordinary and one quantitative atom, retain a well-posed false atom without fake credit, and leave an underdefined claim's target undefined despite diagnostic closure.
- Require every fixture ID and every synthetic readiness/selection witness to be explicitly `FX-`/synthetic. Production-shaped or non-`FX-` data must never receive synthetic `Target` treatment.
- Inspect all stdout/stderr and data fields for forbidden implications: production `PartitionReady`, production/global `Target`, `lean_ready`, proof/source/coverage credit, implementation acceptance, completion, or authoritative effective state.
- Confirm timestamps, filenames, lexical IDs, JSON order, filesystem discovery, row recency, diagnostic status, and candidate-owned booleans never confer authority.

### 7. Protected legacy behavior

- Run the unchanged legacy path and legacy `--negative-tests`; require the same successful summary and exactly 25 rejected mutations.
- Independently recompute the Appendix A path set and all fifteen digests from constants outside candidate-owned input.
- Mutate a protected byte, remove/add/rename/duplicate a protected entry, and self-edit any candidate-owned golden manifest to match; every case must still fail. Restore only in an isolated disposable copy.
- Confirm the validator itself is intentionally changeable and that no legacy CSV meaning, fixture, classification axis, or result was migrated into the companion.

### 8. First finite real Chapter 4 batch implementability

- Determine whether the frozen schemas can represent one bounded production `B4.1` with exact snapshot/payload/rights evidence, canonical documents and aliases, structural items/leaves, appearances and all claim kinds, contexts/notations/entities, audit issues/events, effective view membership, reviewed class rows, roles, and external exact-artifact selections.
- Confirm validation can operate on that finite batch without a Chapters 4–10 census, global view/fold, support traversal, coverage engine, card linting, or global automation.
- Confirm deferred correction handling is operationally safe: an unsupported production correction cannot mutate an existing row and instead suspends the affected batch/dependents pending a reviewed successor.
- Confirm real-data mode emits only structural diagnostics and proposed candidate IDs; the manual source/classification review and external root selection remain necessary to establish `PartitionReady` and `Target`.
- Treat E0 synthetic results as zero DLMF source/readiness/coverage/Lean credit. The programme outcome remains accepted Lean completion of selected exact functions/assertions in DLMF Chapters 4–10.

## Planned evidence form after freeze

The final report will bind the exact reviewed implementation identity, list commands and mutation outcomes, separate code/schema findings from contract-boundary observations, state any remaining manual/deferred obligations, and issue exactly one evidence-based verdict only after all tests above are run against unchanged frozen bytes.
