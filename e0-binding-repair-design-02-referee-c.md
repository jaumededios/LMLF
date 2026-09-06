# E0 exact-binding repair design 02 — independent referee C

## Verdict

**`request_changes`**. The proposed repair has a coherent acyclic backbone and correctly preserves several important boundaries, but four concrete, bounded defects remain. In particular, the pre-signature review subject does not bind the mathematical dependency closure, the source-semantics instances do not bind the reviewed classification vocabulary, the retained source/evidence records cannot express all source-evidence facts required for E1, and the natural-language-proof `not_required` branch is narrower than the governing protocol. These defects are fixable without adding a production authority fold, global source ingestion, or Lean mathematics.

This is a design verdict only. It does not approve the dirty implementation candidate, set a protocol gate, establish quorum, or grant source, rights, proof, signature, coverage, implementation, or programme credit.

## Role, snapshot, and isolation

- Role: independent fresh-context design referee C; not proposer, author, merger, or adjudicator.
- Parent-attested requested configuration: `gpt-5.6-sol`, reasoning effort `high`, `fork_turns: none`. The actual serving model/build was not independently visible or verified.
- Runtime: Codex in a shared Linux workspace.
- Isolation strength: manual only, not technically enforced. The repositories and evidence directory were writable and shared, network capability existed, and no clean-room boundary was enforced. I made no network calls, commits, pushes, CI requests, or candidate edits. No peer report was supplied or deliberately opened; one broad local `rg` used to locate R7 returned incidental matching snippets from report files, so I do not claim exclusion from all peer-report text. I did not contact or ask the author.
- No applicable repository `AGENTS.md` was found. I read the complete `referee-lean-library` skill and its complete required global rubric and workflow basis before the audit.
- Candidate snapshot initially observed: `/tmp/lmlf-e0-fixes.Tx3HrElD`, branch `fix/e0-companion-candidate-02`, dirty at `HEAD 26f4051e13f3a7bc558c225138458f211bf31597` with only `review/companion-v1/README.md` and `scripts/companion_contract.py` modified. The shared worktree was not stable: during closing verification, another process advanced it to clean commit `de45ecf0e937906cfd3cd1c2d6bbe9c954dfb80f`. I did not make or request that change, did not review the later commit, and issue no verdict on it.
- Rejected baseline: clean `/tmp/lmlf-e0-companion.hFHPMOuG`, branch `impl/e0-companion-contract`, `HEAD 26f4051e13f3a7bc558c225138458f211bf31597`.

## Exact inputs

| Input | Exact identity |
|---|---|
| proposed repair design | `e0-binding-repair-design-02.md`; SHA-256 `c50fa7d136dfb63b3af4fc2deca84929028879c24b282b7b54c9daa8d30e93b7` |
| accepted companion design | `stage1-companion-schema-design-draft-04.md`; SHA-256 `e3dacb11c97ec059ae8f48e3fc81f3155fbf86c2cd5679c69541852c2d1fdc7b` |
| review protocol | `review/PROTOCOL.md`; SHA-256 `7453bc0ca6985d7ca2e8c525d9655a94e412c48e3850b92d9367a9f643d3177d` in both repositories |
| accepted R7 programme | `blueprint/stage_1_dlmf-R7.md`; commit `aebe7968bd6d5dcd23ac949d5d5e0d8854334ca1`; SHA-256 `4964a4ad79b8e8da0cdd376836383b189c32b38eaeecd9979dfdcca8cb54b4c2` |
| library-review skill | `referee-lean-library/SKILL.md`; SHA-256 `d4ce5aa5f1c7ebcf18da6f408c2fc2da98fe2dd906fa9c32b6b613b381aa0e9d` |
| initially observed dirty candidate delta | raw `git diff --binary` SHA-256 `e91cffb95ffd594a319f99eb69977b7455b13518f2ff6225672a042633884035` |
| initially observed dirty candidate files | README SHA-256 `293d01681afac5d15afbbfa53d09cf4f45ba735c99f8f2c4f13a013334a1fb5a`; contract script SHA-256 `5437775906d1b0df86e683b73c4a48ab6528ed370175f8bb18667d1374e4d77e` |
| unreviewed concurrent closing state | clean commit `de45ecf0e937906cfd3cd1c2d6bbe9c954dfb80f`; README SHA-256 `293d01681afac5d15afbbfa53d09cf4f45ba735c99f8f2c4f13a013334a1fb5a`; contract script SHA-256 `2c992afcc96e54fa4b7cffb5fe38aed5d5c5a40964fcae6ae5a89da77a2e5d20` |
| rejected-baseline files | README SHA-256 `c71a61ab67365b82c95b5c9ba4939574b5ca68b1dc708dcf0e09b83bc6ac6ed1`; contract script SHA-256 `3c9ff38f5cfecd2f9ef827b64de7f512aaee624c24270e671d6ad459935c075f` |
| inspected baseline descriptors | `schema-fields.csv` SHA-256 `73ae07721bed4c390526ca9f6895561665a89807ddee7e24118e362fe61d238b`; `schema-tables.csv` SHA-256 `5d895a91e5ebdfceeb92c887d2cf428c7252770bdeca9610130b5c62caa330b5`; proposed `classifications-v4.json` SHA-256 `5c3bebb40d640fe3e4824a50487e1c6e1ad0d8ddd0b872953685bd0cf877cbbb` |

I read the complete proposed design, accepted draft 04, protocol, and accepted 1,265-line R7 programme. I also inspected the initially observed exact dirty diff, the relevant baseline descriptor/fixture records, and the complete changed-file context needed to test implementability. Against that initially observed state, `python3 scripts/validate_inventory.py --companion-tests` passed with 113 focused adversarial fixtures; that is useful implementation context but cannot cure a missing design subject. The later concurrent commit was not an input to this verdict.

## Findings

### G1 — P1: pre-signature reviews are not bound to the mathematical dependency closure

The early `mathematical_subject_set` is specified as the batch-closure witness, claim, and role/card/source-target triples only (design lines 162–163). The complete pre-signature bundle then binds that subject and its proof/reviews (lines 173–180). By contrast, dependencies first appear as something the later exact-signature packet *may* bind (line 68), and dependency/support changes are absent from the explicit early invalidation list (line 180).

Consequently, an indirect support edge, hypothesis source, or pinned-library dependency can change after the natural-language proof and structural review while preserving the early subject digest. A later signature packet can then incorporate the changed dependency without the correspondence rule—currently role/card/target equality only at lines 184–186—rejecting it. That defeats the point of reviewing the proof route before signature design and conflicts with protocol requirements to review dependencies and missing infrastructure (`PROTOCOL.md` lines 136–149, 154–160, 181–184) and R7's finite least transitive reviewed support closure (`stage_1_dlmf-R7.md` lines 843–890 and 1188–1205).

Minimum repair:

1. Add an exact, immutable pre-signature mathematical-dependency/support-closure triple to each `mathematical_subject_set` (or make the bound frozen card explicitly and verifiably bind that complete closure). It must cover the exact finite nodes, typed edges, hypotheses/conventions, entity/notation prerequisites, and pinned-library interfaces used by the proof, but contain no Lean declaration signature.
2. Make the pre-signature bundle bind that closure and make any closure or dependency-pin change regenerate the early subject and invalidate its proof/gate/verdict chain.
3. Require late correspondence to show that the signature packet's dependency set and pins equal the reviewed early closure; it must not add a theorem-sized premise or support edge after review.
4. Add a negative fixture that changes one indirect dependency/pin while rehashing the late packet and proves that the preserved early review chain is rejected.

This keeps R7's required order—mathematical proof and architecture review before exact Lean signature—without moving a signature into the early subject.

### G2 — P1: source-semantics instances are not anchored to the exact classification authority

The proposed `source_semantics_instance` binds a claim, snapshot, schema set, classification view, class token, and rationale (design line 139), but it does not bind the exact versioned DLMF classification vocabulary. The manifest's exhaustive earlier-JSON set contains only rights, source-semantics, and issue-evidence records and separately binds only the *schema-set descriptor* (lines 133–144). The closure witness likewise repeats the schema descriptor but not the classification authority (lines 148–158).

Schema syntax and classification meaning are distinct authorities in accepted draft 04. The accepted design requires the DLMF successor to name its exact v3 path, schema version, and digest as an immutable predecessor (accepted draft lines 185–212), and R7 requires an independently approved versioned classification successor before DLMF cards freeze (R7 lines 726–763 and completion row 949). With the current proposal, identical instance bytes can be interpreted under a changed successor vocabulary without changing the manifest or closure witness.

Minimum repair:

1. Bind an exact classification-authority triple—kind/ID, schema version, and exact digest—either in every `source_semantics_instance` or once in the source-core manifest with a rule that every instance resolves to it.
2. Require that authority to bind the immutable v3 predecessor path, version, and digest exactly as accepted draft 04 requires.
3. Ensure the batch-closure witness reaches this binding transitively and that a classification-authority or v3-predecessor change invalidates the witness, decisions, verdict subjects, and selection.
4. Add negative tests for missing/wrong successor, changed token semantics under a stale digest, and a changed v3 predecessor.

### G3 — P1: the retained source/evidence surface cannot represent the required E1 retrieval and availability facts

The repair calls its changes a finite normalized-file delta (lines 70–92). Apart from changing `payload_evidence.csv`, it leaves the rejected baseline snapshot, alias, representation, and retrieval schemas unchanged. Their exact baseline headers carry only:

- snapshot: source name and version ID;
- alias: alias ID, document ID, and alias kind;
- representation: representation ID, document ID, and media type; and
- retrieval: retrieval ID, representation ID, retrieval time, and payload-evidence ID.

The new rights record adds source name, contemplated use, retention, exact notice evidence, retrieval time, and a manual note (line 137), but neither it nor the retained source records bind the canonical request locator, retrieval method, redirect chain, observed per-document version evidence, continuing availability, or access conditions. Those are not optional production automation: R7 requires them as exact source-evidence facts (R7 lines 204–246 and completion rows 940–941), while accepted draft 04 says E1 must bind rights notice, exact payload evidence, canonical documents, aliases, and the retrieval date/digest/redirect/version/evidence/rights/availability chain (accepted draft lines 72–76 and 374–380). E0 remains synthetic, but its reviewed descriptors must be capable of carrying the first real finite packet; the design lists no later evidence-schema successor.

Minimum repair:

1. Add normalized fields or an earlier immutable strict-JSON retrieval/evidence record for canonical locator, retrieval method, ordered redirect chain, observed version-evidence binding, continuing-availability state, access conditions, and rights/provenance.
2. Bind those records through the exact source-core manifest and make the batch witness reach every evidence object used by its documents. Retain the current raw-byte/path-boundary rules.
3. Add focused cross-document, missing-field, stale-digest, unavailable/expired, and redirect/version mismatch fixtures.

This is a small exact-evidence schema extension. It does not require fetching real DLMF content, making a rights determination, mirroring a chapter, or automating source exhaustiveness.

### G4 — P2: the NLP `not_required` branch excludes protocol-permitted cases

Design line 168 permits `nlp_not_required_record` only for a direct pinned-library reuse. The governing protocol permits natural-language-proof inapplicability for definitions, audit-only targets, and transparent non-novel wrappers around specifically bound pinned-library facts (`PROTOCOL.md` lines 140–150). These distinctions matter because `definition` and `audit_only` are explicit controlled target classifications (protocol lines 95–100), and the Stage 1 source surface includes definitions as ordinary targets. Accepted draft 04 deliberately requires a *protocol-permitted*, exact-bound, reviewed `not_required` record rather than a new narrower vocabulary (accepted draft lines 232–241 and 382–385).

Minimum repair:

1. Represent the complete protocol-eligible set for the natural-language-proof gate: definition, audit-only target, or transparent non-novel wrapper around an exact pinned fact.
2. Bind the exact frozen applicability subject and reason, and require the gate record and external verdicts to match it. Absence must remain invalid.
3. Keep structural-circularity applicability independent; an NLP exemption must never erase a required structural review.
4. Add one positive fixture for each permitted reason kind and negatives for an unclassified short proof, a nontransparent wrapper, and an unpinned library fact.

## Confirmed design boundaries

Subject to the findings above, the following parts are sound and should be preserved:

- The raw-byte identity rule and prohibition on direct or transitive self-hashing form an acyclic content DAG.
- Removing witness fields from `audit_batches.csv`, fixing the exact 28-member source-core manifest, and placing the batch-closure witness after that manifest removes the previous manifest/witness cycle.
- The closure witness transitively fixes the complete core bytes and explicitly projects candidates and noncandidate claims; changing a noncandidate claim, fidelity/exclusion row, issue evidence, source class, or closure member changes the manifest/witness even when the candidate atom set is unchanged.
- `source_spans.csv` uses the document-qualified item key, checks owner-consistent retrieval/payload reachability and byte bounds, and correctly leaves semantic adequacy and legitimate overlap to source reviewers.
- The proof/signature direction is right: raw proof and early reviews precede exact-signature design, while a later correspondence cannot rewrite the reviewed mathematical role/card/target triples.
- One validation level may be supplied alone. No lower-level history rows should be required, and shared endpoint IDs need agree only when multiple levels are actually present.
- Candidate-owned frozen/supplied markers, bundles, and validator output do not establish approval, selection, `lean_ready`, or effective authority.
- The immutable ordered authority index and backward typed-edge grammar remain unchanged. Adding exact closure-witness subject metadata to events, verdicts, and selections does not require a new authority edge or a production fold.
- E0 remains a tiny all-`FX-` structural contract. It grants no production IDs, real-source or rights result, theorem coverage, source exhaustiveness, reviewer independence, or programme completion. Chapters 4–10 remain the actual programme scope; Chapters 1–3 are finite consumer-justified support only.

## Final disposition

The repair is not blocked at the programme or architecture level. A successor design that makes the four minimum repairs above can remain a bounded E0 contract and should receive fresh exact-artifact review. Until then, design 02 should not authorize implementation work or be treated as resolving the rejected baseline.
