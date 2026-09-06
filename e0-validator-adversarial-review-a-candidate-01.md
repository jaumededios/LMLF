# E0 validator adversarial review A — candidate 01

## Exact review subject

- candidate commit: `26f4051e13f3a7bc558c225138458f211bf31597`
- candidate tree: `85bc0bbd802c2ae8044a3bf4f66e6f5cb00b542c`
- base commit: `e3b4cafa7f8d1e8b033806737eab23e641a401d8`
- changed paths: 66
- independently recomputed SHA-256 of the 66 path-sorted `sha256sum` lines, including final LF: `ada01f62cb31d08eb7dee69721b83b8ac07ac2876684a1b0dc1af1c8b2b70454`
- accepted contract: `stage1-companion-schema-design-draft-04.md`
- accepted contract SHA-256 independently recomputed: `e3dacb11c97ec059ae8f48e3fc81f3155fbf86c2cd5679c69541852c2d1fdc7b`
- unchanged protocol reviewed: `review/PROTOCOL.md`
- isolation: fresh-context manual exact-head review; local tools only; no other referee verdicts read; candidate not edited; mutations performed in memory or in automatically removed temporary directories

The candidate was clean at intake. Root reported and I independently reproduced the corrected aggregate above; the earlier proposer aggregate did not reproduce, but this evidence-record correction did not change candidate bytes.

## Verdict

**`request_changes`** for exact candidate `26f4051e13f3a7bc558c225138458f211bf31597`.

The implementation passes its bundled suite and preserves the legacy/Lean boundary, but it does not yet implement the contract's required structural state, type, and identity checks. Fully digest-rebound malformed records are accepted with zero validation errors. These are validator gaps, not merely missing tests or untrusted-proposer-report issues.

No finding grants or withholds source truth, real DLMF coverage/authority, `PartitionReady`, a production `Target`, proof or coverage credit, `lean_ready`, Lean implementation acceptance, integration, or Chapters 4–10 completion. E0 remains synthetic enabling infrastructure only.

## Material findings

### A1 — validation-level endpoint state machine is not enforced

Contract requirements are explicit:

- `source-batch` permits explicitly pending card/declaration endpoints and freezes no card, declaration, or signature;
- `card-binding` has a bound frozen card/target and either a pending declaration or a proposed declaration with only a nonbinding sketch;
- `exact-signature-binding` binds the exact declaration and exact-signature packet; and
- the three levels are ordered, with role cardinality invariant at every level.

The implementation checks only selected fragments of those combinations in `scripts/companion_contract.py:624-678`. Independent mutations of the positive tables were passed directly through `validate_bundle` without touching candidate files. Each of the following returned `ACCEPTED 0 []`:

1. `source-batch`, `endpoint_state=pending`, but `card_state=frozen`;
2. `source-batch`, `endpoint_state=pending`, but `declaration_state=frozen`;
3. `source-batch`, `endpoint_state=pending`, but `signature_kind=exact_signature`;
4. `card-binding` with all bound data but `endpoint_state=pending`;
5. `card-binding` with a named/sketched declaration but `declaration_state=pending`;
6. `card-binding` with `declaration_state=frozen` and `signature_kind=none`;
7. `exact-signature-binding` with `endpoint_state=pending`.

In addition, removing both lower levels from the ordinary atom while retaining only `exact-signature-binding` was accepted, as was retaining only `card-binding`. The current `selected_levels` check at lines 697-714 requires merely a nonempty subset of the three tokens; it does not enforce ordered progression or complete per-level representation.

This allows internally contradictory endpoint claims and permits a higher level to bypass the lower structural stages. It directly defeats the distinctions draft-04 introduced to prevent sketches, frozen cards, and exact signatures from being conflated.

Required correction: validate a closed field-state matrix for every level, reject fields/states that are forbidden or inconsistent at that level, and enforce the intended level ordering/presence. Add focused cases for every accepted-invalid combination above, not just one representative.

### A2 — exact-bound nested artifacts are key-checked but not adequately type/value-checked

The contract says E0 checks supplied bindings' required fields, **types**, IDs, exact digests, and synthetic selected-record witnesses. The `artifact_schemas` block at lines 495-507 checks only exact key sets. Several consumers then inspect only a subset of values. Fully reserialized and digest-rebound temporary artifacts were accepted with zero errors in each independent reproduction:

1. `signature-packet.json` with `synthetic_fixture: false`;
2. a bound `reviewer_verdict` with `verdict: []` rather than a controlled string/token;
3. a bound `source_facing_target` with `target_text: []` rather than a nonempty frozen mathematical-target string.

For the verdict reproduction I recomputed the verdict digest, rebound it in `artifact_bindings.csv` and its gate review binding, then recomputed/rebound the gate-bundle digest in all exact-signature role rows. For the target reproduction I recomputed/rebound the target, updated and rebound its card, and updated all role digests. Therefore these were not expected exact-byte failures; the malformed exact-bound content itself was accepted.

The same general omission affects other fields admitted by the closed key sets. Requiring a key called `synthetic_fixture`, `verdict`, or `target_text` is not equivalent to validating its type and value. In particular, acceptance of `synthetic_fixture: false` contradicts the required explicit synthetic labeling of higher-level E0 witnesses.

Required correction: define and enforce closed per-record schemas, including scalar/container types, nonempty identity/text fields where required, controlled tokens, boolean values, nested declaration uniqueness/types, and `synthetic_fixture is true` for fixture-only artifacts. Add digest-rebound adversarial tests, because unrebound mutations only prove the digest guard.

### A3 — evidence and authority reviewer identities are not tied to the exact-bound records

Two distinct exact identity failures were accepted:

1. I changed the sole issue's ID from `FX-I1` to `FX-I2` and changed its event's `issue_id` to `FX-I2`, while leaving the exact-bound `issue_evidence` artifact declaring `issue_id: FX-I1`. Validation returned no errors. Lines 509-516 verify only that the event's evidence locator has record kind `issue_evidence`; they do not load-check the evidence's declared issue against the event/issue.
2. In a disposable artifact copy I changed the root-view selection's `reviewer_bindings[0].reviewer_id` to `FX-REVIEWER-WRONG`, recomputed the selection digest, and rebound both its locator and index entry. The referenced exact-bound verdict still declared `FX-REVIEWER-S`. Validation returned no errors. Lines 940-949 check only verdict locator kind/digest, not the reviewer's declared identity or relevant subject binding.

These are precisely the kind of binding-equality checks E0 is supposed to perform without deciding semantic truth, independence, quorum, or effective authority. A digest proves which bytes were supplied; it does not prove that the IDs asserted beside the digest agree with those bytes.

Required correction: for issue events, require the loaded exact-bound evidence to declare the same issue ID (and expected synthetic/type properties). For authority reviewer bindings, require the loaded verdict's reviewer ID to match and validate the verdict's exact subject ID/digest relationship appropriate to the authority record. Add fully rebound negative tests for both, so the asserted diagnostic cannot be satisfied merely by an old digest.

## Positive evidence independently established

### Candidate identity and scope

- clean exact head/tree and 66-path count matched the supplied freeze;
- all 66 individual file bytes produced the corrected aggregate `ada01f62...`;
- `git diff --exit-code base HEAD -- blueprint/inventory review/classifications-v3.json` passed;
- the changed-path query over `*.lean`, `lakefile.toml`, `lean-toolchain`, `lake-manifest.json`, `.github`, `website`, and `docs` was empty;
- no production DLMF census rows or production IDs were found in the checked-in fixture; checked-in companion IDs use `FX-`.

### Canonical commands

All independently run at the exact candidate head:

```text
$ python3 scripts/validate_inventory.py
inventory validation passed: 148 occurrences, 31 notations, 32 entities, 34 entity evidence rows, 88 occurrence associations; classification examples [DEF-001, OLV-001, QB-001, QL-001, SR-001]; manifest totals [BOOTSTRAP-0=0, DEMO-0=0, IMPROPER-0=0, OLV-MVP-1=1]

$ python3 scripts/validate_inventory.py --negative-tests --companion-tests
negative invariant tests passed: 25 intentionally invalid copied fixtures rejected
companion structural validation passed (no authority or readiness implied)
CandidateAtoms={"FX-B4.1": ["FX-O1", "FX-O2"]}
Target[synthetic_fixture_only]={"FX-B4.1": ["FX-O1", "FX-O2"]}
companion real-mode positive control passed: CandidateAtoms={"E0TEST-B4.1": ["E0TEST-O1", "E0TEST-O2"]}; Target omitted
companion negative tests passed: 74 focused adversarial fixtures rejected
inventory validation passed: 148 occurrences, 31 notations, 32 entities, 34 entity evidence rows, 88 occurrence associations; classification examples [DEF-001, OLV-001, QB-001, QL-001, SR-001]; manifest totals [BOOTSTRAP-0=0, DEMO-0=0, IMPROPER-0=0, OLV-MVP-1=1]

$ python3 -m compileall -q scripts
[exit 0, no output]

$ python3 -m tabnanny scripts/validate_inventory.py scripts/companion_contract.py
[exit 0, no output]

$ lake build
Build completed successfully (2766 jobs).
```

I also extracted base `e3b4cafa7f8d1e8b033806737eab23e641a401d8` into a temporary directory and ran its default and `--negative-tests` commands. Both exited 0 with the same default inventory summary and the same `25 intentionally invalid copied fixtures rejected` result. This confirms behavioral legacy preservation independently of the protected-byte diff.

### Checks that appear sound within reviewed scope

- fixed in-code protection of exactly the fourteen legacy inventory CSVs plus immutable v3, including the self-edited candidate-manifest attack;
- strict UTF-8 JSON parser with duplicate-key rejection at nested depth, rejection of `NaN`, `Infinity`, `-Infinity`, overflow-to-infinity, and trailing comma;
- exact stored-byte hashing and path containment/symlink escape checks;
- structural ownership, parent-cycle, item-oracle, and exact batch-projection mechanisms for the supplied rows;
- fixture candidate set and partial per-batch synthetic target output;
- real-mode CLI output surface: success prints the structural disclaimer and `CandidateAtoms` only; the code path omits `Target` and the bundled real-mode control confirms that behavior;
- candidate enumeration does not infer mathematics from prose;
- external authority index uses explicit positive positions and strict backward edge checks rather than timestamps or filesystem order;
- no emitted `PartitionReady`, global `Target(S4)`, `lean_ready`, proof/coverage credit, implementation acceptance, or completion result was found.

These positives do not cure A1-A3: the contract requires both exact-byte binding and validation that the rebound bytes have the required structural meaning.

## Disposition needed

This verdict is non-approving and exact-head-specific. A successor candidate must receive a fresh exact-artifact review. At minimum it should add the A1 state-matrix/order checks, closed nested artifact type/value checks, issue-evidence identity equality, and authority reviewer/verdict identity equality, together with fully rebound adversarial reproductions. Any new commit invalidates this verdict for approval purposes; this report remains historical evidence only.

