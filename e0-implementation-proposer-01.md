# E0 implementation proposer evidence 01

## Status and immutable bindings

- Role: implementation proposer only. This document supplies no review approval, source approval, quorum credit, or integration authority.
- Candidate status: implementation bytes frozen for fresh independent review. Any later repository-file edit invalidates the digest set and requires rerunning the recorded checks.
- Worktree: /tmp/lmlf-e0-companion.hFHPMOuG.
- Branch: impl/e0-companion-contract.
- Base commit / current uncommitted HEAD: e3b4cafa7f8d1e8b033806737eab23e641a401d8.
- Base tree: 59c60301b9d89c8dc470391b990f78de66f19f17.
- Main integration baseline named by the assignment: b8d2f731fcfd5cd0889d0732f13699eb94681c86; this worktree has not modified main.
- Accepted R7 source: blueprint/stage_1_dlmf-R7.md, incorporated into the local base before this implementation assignment.
- Contract: stage1-companion-schema-design-draft-04.md, SHA-256 e3dacb11c97ec059ae8f48e3fc81f3155fbf86c2cd5679c69541852c2d1fdc7b.
- Adjudication: root-e0-contract-draft04-adjudication.md, SHA-256 cf8ada65adcce2f14ad0805e042b98f3ae3de00d40b6057dd096d385badab91b.
- Pinned project state remains Lean 4.33.1 and Mathlib 0df444a360eaa60ab8c11dca51a86af692955474; no pin or Lean source was changed.
- No commit, push, CI action, Verso action, or network retrieval was performed.

## Implemented E0 surface

- Kept scripts/validate_inventory.py as the only CLI and added explicit --companion-check, --companion-tests, and --companion-real BUNDLE --artifact-root ROOT entry points.
- Added one bounded internal helper, scripts/companion_contract.py, for strict companion parsing and structural validation without refactoring the legacy validator.
- Added normalized companion schema descriptors, a protected-input baseline guard for the 15 immutable legacy inputs, and the proposed successor review/classifications-v4.json with source semantics separate from the immutable v3 axes.
- Added a synthetic FX positive fixture with two distinct atoms, shared context, ordinary and quantitative roles, an ordinary contradiction retained in the candidate set, typed level-specific bindings, exact external artifact digests, and a fixture-only readiness witness.
- Added strict JSON/UTF-8 handling, closed record and authority grammars, canonical ownership and atom-ordinal checks, document-scoped item identity, complete foreign-key and snapshot/schema checks, artifact-root containment, symlink-escape rejection, exact digest/type/linkage validation, and structural representation of multiple reviewer verdicts and protocol-permitted not_required natural-language-proof review states.
- Real mode emits only structural diagnostics and CandidateAtoms; it cannot accept FX identities or publish Target. Fixture mode rejects non-FX identity namespaces and represents Target per batch, including explicit undefined state.
- The validator deliberately does not compute review truth, reviewer independence, quorum, authority fold, source meaning, proof correctness, coverage credit, or completion.

## Verification transcript

All commands ran in the dedicated worktree against the frozen bytes:

    $ python3 -m compileall -q scripts
    [exit 0; no output]

    $ python3 -m tabnanny scripts/validate_inventory.py scripts/companion_contract.py
    [exit 0; no output]

    $ python3 scripts/validate_inventory.py
    inventory validation passed: 148 occurrences, 31 notations, 32 entities, 34 evidence records, 88 occurrence-evidence associations
    [the command also reported the expected frozen classifications and manifest checks; exit 0]

    $ python3 scripts/validate_inventory.py --negative-tests --companion-tests
    negative tests passed: 25 focused adversarial fixtures rejected
    companion validation passed: CandidateAtoms={"FX-B4.1": ["FX-O1", "FX-O2"]}; Target={"FX-B4.1": ["FX-O1", "FX-O2"]} (fixture-only)
    companion real-mode positive control passed: CandidateAtoms={"E0TEST-B4.1": ["E0TEST-O1", "E0TEST-O2"]}; Target omitted
    companion negative tests passed: 74 focused adversarial fixtures rejected
    [exit 0]

    $ git diff --check e3b4cafa7f8d1e8b033806737eab23e641a401d8
    [exit 0; no output]

    $ lake build
    Build completed successfully (2766 jobs; cached/replayed project build).
    [exit 0]

The real-mode positive control is generated ephemerally by the companion test runner from the valid fixture using a non-FX test namespace. It leaves no production identity or retained source payload in the repository.

The 15 protected legacy inputs were byte-checked against the contract's hardcoded Appendix A path/hash pairs. The legacy positive invocation and all 25 pre-existing negative cases remain successful. git diff --check is clean, including preservation of historical Markdown hard breaks outside this E0 change.

## Exact changed-file digest inventory

- File count: 66.
- Canonical digest-set SHA-256 (SHA/path lines below, UTF-8, sorted by path): 2e5926ef10a7e3022fd9100c0bedbfa138ca43b397251d8dab3b8e6d05472d79.

    5c3bebb40d640fe3e4824a50487e1c6e1ad0d8ddd0b872953685bd0cf877cbbb  review/classifications-v4.json
    c71a61ab67365b82c95b5c9ba4939574b5ca68b1dc708dcf0e09b83bc6ac6ed1  review/companion-v1/README.md
    e867c752e3a4bc1dfa0f8d3fa1ee5f0acc6d249ff56465004ba84a6b7d81f139  review/companion-v1/fixtures/positive/appearances.csv
    b5cff925f2f9ae27afe47576ff39f47a525721210793a4e1dd7e1658c8baaab9  review/companion-v1/fixtures/positive/artifact_bindings.csv
    c923a0db0ee1bf8f7d8420104c717f37a1123699a1f9d5b5fd0971b37ca3680f  review/companion-v1/fixtures/positive/artifacts/authority/event.json
    ba41900b7d59bd9838e2ca022ae8b0361b1159918c5e701ca6a8fd32ea109bf2  review/companion-v1/fixtures/positive/artifacts/authority/genesis.json
    2b17e2ab89b11c929b5c47ea4ea1022dda143d4041094b8d8c306579d54b9807  review/companion-v1/fixtures/positive/artifacts/authority/post-catalog.json
    4af8c481cd9daf381fcdb75bc383c9a6dc26e4a4479ee3891e43f6e3fcf212b4  review/companion-v1/fixtures/positive/artifacts/authority/selection.json
    43d2fa55b096e18d0b19cbc6eca6aeebcb8e226127b89714b22edec9e12f39bf  review/companion-v1/fixtures/positive/artifacts/card-o.json
    1a18d86fc3b26609d6573f78721a3707d74b715e5aed1d1d81e170d6580285ff  review/companion-v1/fixtures/positive/artifacts/card-q.json
    d27922713c9d28b36c8859b91c47caa543684a789b24c83998e30bff1c625e2e  review/companion-v1/fixtures/positive/artifacts/card-r.json
    4586a9adad53bfe1e5c8262f13462c4a6a7c591e47732a34de275746345f0e1f  review/companion-v1/fixtures/positive/artifacts/class-o1.json
    6b6041e43c232ded442d58e420c3a512ab3efada6c7a3743cfc805c1fa6f829a  review/companion-v1/fixtures/positive/artifacts/class-o2.json
    719e0f9d69a0c2a84fb0b8f636da726f4199247117a5fb121590ae76fba5c6d3  review/companion-v1/fixtures/positive/artifacts/evidence/fx-payload.txt
    48e572140a321e32156f1fbbcd8a902ed216f349a7804989af49e71d14593292  review/companion-v1/fixtures/positive/artifacts/gate-bundle.json
    f60daac535af41070e227fe4f947b8c0179dc5ac3200e5fb493bd86fcadf211d  review/companion-v1/fixtures/positive/artifacts/gate-nlp.json
    7aec35e36763ede041b00427e5b2cc411953d32d0fdf4944b077c91222e60e99  review/companion-v1/fixtures/positive/artifacts/gate-proof.json
    c7c44a7c94882e08c717ef3f65f0e7a912a1ef77eb90582fe3695f63c6b6f2d6  review/companion-v1/fixtures/positive/artifacts/gate-quant.json
    a547fda1a59cb4719fb3c0e0f840f1ce7e66c528c4b11c3ccb270288464199e2  review/companion-v1/fixtures/positive/artifacts/gate-source.json
    a8d96ca5074dc54c06f67c1b583573f903cc34e6d22a04bbeca6ddc633c2a5de  review/companion-v1/fixtures/positive/artifacts/gate-struct.json
    af5165afdcd7d89715ab7f36078e236abc2a79996f78588525685f74d5863ea9  review/companion-v1/fixtures/positive/artifacts/issue-evidence.json
    0fa54fff90d5e9f8fa9a311fabe975e4a8276dd7ec6416a9cb3402015cf759a3  review/companion-v1/fixtures/positive/artifacts/readiness-witness.json
    cb5cdb2cfaf76760cf70327c3bbd966bfd4f87501efecff170d4f4fdf6791b75  review/companion-v1/fixtures/positive/artifacts/signature-packet.json
    30706016a944c38c4ce654d7c694377263df097f7bef12d52af1ba694e7c14bc  review/companion-v1/fixtures/positive/artifacts/target-o.json
    2430a94a3141f10f4e55e0a0f71638abd541ddf0257de0e02e366af7bc6dc987  review/companion-v1/fixtures/positive/artifacts/target-q.json
    db32328972f1811bab89ba705bf57c01158751c8b7839e0fec7c78c81cee27f8  review/companion-v1/fixtures/positive/artifacts/target-r.json
    72f07aaa4c34a6ac41caa2b5a631fe6fedf1a4329fb5d850c859d995c5d828f1  review/companion-v1/fixtures/positive/artifacts/verdict-nlp.json
    aa8776e68c006e90665c28b1c6601a83d4e766f12c52bffaaaef18d3a2377be2  review/companion-v1/fixtures/positive/artifacts/verdict-proof-b.json
    69808ed3822d074e80a011d66dccf7a530e9db00917dd4d4e21070cbb3d773c0  review/companion-v1/fixtures/positive/artifacts/verdict-proof.json
    9ba5b0db1340984fdaae9789c3e5f51703245c6f741906fd53ad28f0029aa1ab  review/companion-v1/fixtures/positive/artifacts/verdict-quant.json
    a947d03f555aa172a17ee77e4ec387a2def3ca7a4674cfded56283853d3c170e  review/companion-v1/fixtures/positive/artifacts/verdict-source.json
    8631b0d1b6d0c413626838f05f0852b300d21e1f95d94e4593791ce9bd9974eb  review/companion-v1/fixtures/positive/artifacts/verdict-struct.json
    d570d0ddcac4147f8aad99926ebd6ab5301d9e47c8a4e74999c4dbb4edae8f90  review/companion-v1/fixtures/positive/audit_batches.csv
    5036daffe0763d409071c7483b9671b9519f10116d64f0cea5394c9db363da67  review/companion-v1/fixtures/positive/authority-index.json
    b9843564074636a2445d0fea7dc67920c0720809dbdb974887dc9670f0960d55  review/companion-v1/fixtures/positive/batch_appearances.csv
    8d43a0cd447bd8ad7a02f3672edb26afd4c859941c9f40c6dd1dfff7b8ef7578  review/companion-v1/fixtures/positive/batch_claims.csv
    c90df04f8405a3d4f3d090c86071f52219cbad3d3a73a71d543f74cf5d1ced58  review/companion-v1/fixtures/positive/batch_leaves.csv
    da747026f97474e8fcd463c5d4996e262d3a6cafabf79b8b5365e28094065ba4  review/companion-v1/fixtures/positive/batch_scopes.csv
    5470570054e26c2c0be1790b0c2d2b92540246681854dd41c7c374de3b2ee981  review/companion-v1/fixtures/positive/canonical_documents.csv
    a024c68806b00b047d6b09cedc8f75a8463aeb7c330ffe66ca5d3adcf232729f  review/companion-v1/fixtures/positive/claim_contexts.csv
    40f3fab1811ea7f91866a64dd8aa57e6aa8fd26ec7dd1b4143f2423cb72493d7  review/companion-v1/fixtures/positive/claim_entities.csv
    1da816e8c5e0aea820af9f2b57f0c595a5d381aadf517ade7baf6f9b7d37c263  review/companion-v1/fixtures/positive/claim_notations.csv
    d4a545c49813af762cbf020ba15905c615d1ddecbeb5f8005574432651ad214c  review/companion-v1/fixtures/positive/claims.csv
    bb1778544ed291d241f39c65fa277ae9a9af37c800d4626eba9dede6129d3bbe  review/companion-v1/fixtures/positive/content_units.csv
    a1af74cbac3f883300069734044f7d5b3a661d10b4b816910b8c738adf8bf072  review/companion-v1/fixtures/positive/contexts.csv
    1dbc7688ddc6991a79650341ae0a1320a26246484bb65132054287f305bf5614  review/companion-v1/fixtures/positive/document_aliases.csv
    ee44274faea8e3d45975ba7d40482936569606f015bf52b8cd7789281e00937a  review/companion-v1/fixtures/positive/document_items.csv
    708d29d2c3792584fe1937246f5b678c508d4350b7a85ccc155fbb74ecee6ad4  review/companion-v1/fixtures/positive/effective_view_claims.csv
    f21c7d541be009735ebeeca5039aeb87e9e6d206d198b6928c5da3afcb2e841f  review/companion-v1/fixtures/positive/entities.csv
    5733f69d46b600db17126d447598aa6130bbac925f488228d83a6bc03856c117  review/companion-v1/fixtures/positive/issue_events.csv
    63c23dc91191ffe2d000f292147ee05b0df56e8b3be387e7f8ff30edf3b2c6b2  review/companion-v1/fixtures/positive/issues.csv
    8ee936f0b03cd4d682a34fe9e858c479e38597a6ac9a7d78dc14bb917253149f  review/companion-v1/fixtures/positive/leaves.csv
    d34c672d189857e2e4f475e5111492ea95f0071a133c9bec4e929661a855c136  review/companion-v1/fixtures/positive/notations.csv
    026c5fd0524ea064e35ea285de103b54a15a10cee323b9a0933f4f6843dc7471  review/companion-v1/fixtures/positive/payload_evidence.csv
    4da0cd53ef166ccfbb231a07fd509d540c97a09f25103d86705738f1b9ad274d  review/companion-v1/fixtures/positive/representations.csv
    e617d697822625a895ce1c09296ce9fab57eb8a4957f50a26bbaeaf11007a30f  review/companion-v1/fixtures/positive/retrieval_observations.csv
    651375edebe1042463163226935a941eaec79789817d5d0b5c6351eedd01fbb4  review/companion-v1/fixtures/positive/role_bindings.csv
    ac45e0911401eddb5ceeee1048546520d9a8534446228f2f17192026851f1a55  review/companion-v1/fixtures/positive/snapshots.csv
    1bf553fabee4020cbe44aebe58bb9051485dd6fcb0eec4a4e83fcacdf7fb7779  review/companion-v1/fixtures/positive/source_semantics.csv
    271f984810ad281b38232dadf144d987af0675797f4197796f06f0f8d9e9e0ec  review/companion-v1/fixtures/positive/source_views.csv
    e2a3376649155b9e12c742a1f6e6a1c9000da7e9b58a19c2fc4bcc461adfff60  review/companion-v1/fixtures/positive/validation_levels.csv
    c1bfd75c0a4de8122151d624f1f42ce620073e06d9c4762dbcff9ac223ea5f5e  review/companion-v1/protected-inputs.json
    73ae07721bed4c390526ca9f6895561665a89807ddee7e24118e362fe61d238b  review/companion-v1/schema-fields.csv
    5d895a91e5ebdfceeb92c887d2cf428c7252770bdeca9610130b5c62caa330b5  review/companion-v1/schema-tables.csv
    3c9ff38f5cfecd2f9ef827b64de7f512aaee624c24270e671d6ad459935c075f  scripts/companion_contract.py
    a068dd817b9a292a652e091c79ad049abfc6323298f7e7005e544567075e987d  scripts/validate_inventory.py

Current git status --short shape at freeze:

     M scripts/validate_inventory.py
    ?? review/classifications-v4.json
    ?? review/companion-v1/
    ?? scripts/companion_contract.py

## Explicit stop line and deferred work

- This is E0 structural tooling over synthetic data. It creates no production DLMF IDs, production companion rows, source payload, census/card authority, source-function success, theorem claim, natural-language proof, Lean proof, or coverage/completion assertion.
- classifications-v4.json and every new schema/fixture byte remain a proposal pending exact independent review. The fixture's class-review, gate, verdict, authority, target, and readiness artifacts are synthetic structure demonstrations, not factual approvals.
- Production rights/provenance decisions, manual source interpretation, actual classification review, reviewer-independence and quorum judgments, authority/effective-selection folds, PartitionReady, production Target, and global/support automation remain outside E0 and deferred.
- No E1 work is attempted. No accepted scope document, R7 document, historical review record, protocol/classification-v3 file, legacy inventory CSV, Lean file, dependency pin, CI configuration, or Verso artifact was edited.
- The implementation candidate stops here, with these exact bytes, for fresh independent schema and implementation review before any integration or production use.

