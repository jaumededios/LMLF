# Independent library-scale specification review B

## Review identity and decision

- Model: `gpt-5.6-sol`.
- Runtime: Codex desktop agent, read-only referee role.
- Reviewed commit: `f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de`.
- Commit tree: `3dd0452a57e6dfff55c11c0157361d0fcc0b8d08`.
- Commit parent: `cfd6ade6dedd2223d7e42e80280fdd5f9d70f085`.
- Commit subject/date: `docs: unify review and source contracts`, 2026-09-05T17:24:39+00:00.
- Isolation: manual fresh-archive attestation. I inspected Git metadata in the supplied worktree, created `/tmp/olver-spec-final-b.sh7iQ9NV` with `mktemp -d`, and populated it solely with `git archive f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de | tar -x -C ...`. All repository-content reads, dependency restoration, builds, scratch compilation, and mutation experiments used that archive. I did not inspect the dirty worktree's untracked or modified file contents. Initial status showed only untracked `LMLF/Audit/` and `LMLF/Definitions/`; many tracked modifications appeared concurrently by the final status check. All were ignored. No repository file was edited by this review.
- Independence: fresh review; no other referee report was read and no other referee was consulted.
- Brief reviewed completely: `/home/codex/.codex/attachments/6740fc8c-818a-4ce2-95bb-67293a5ba2bf/pasted-text.txt`, 1,753 lines / 92,020 bytes, SHA-256 `6787cdb628a66783d81190939e9593525ebb2640a8c870d685d95ce26ba0cce3`.
- Rubrics: `referee-lean-library` was applied first and completely; `referee-lean-proof` was then used only for the two bounded signature/proof-feasibility checks.

**Overall verdict: REQUEST_CHANGES.** There is no P0/blocking mathematical defect, both frozen bootstrap cards are individually approvable, the architecture and trust boundary are sound, and the exact package builds. The requested change is driven by one P1 source-contract validation gap: the only executable inventory checker and the CI mutation suite accept fabricated source/manifest terminal states. Two P2 classification/metadata consistency defects should be fixed in the same specification revision.

| Scope | Verdict | Reason |
|---|---|---|
| Whole exact specification commit | **REQUEST_CHANGES** | G1 is a material but localized integrity gap; G2/G3 are controlled-vocabulary and frozen-registry drift. |
| QB-001 theorem card revision 5 / signature revision 2 / proof revision 4 | **APPROVE** | Exactly eight coherent, non-novel infrastructure declarations; exact signatures elaborate at the pin; proof route is complete and noncircular. |
| DEF-001 theorem card revision 3 | **APPROVE** | Exactly four faithful wrappers around specifically named pinned Mathlib declarations; source hash and exact signatures check; no duplicate Gamma implementation. |

This report is one independent referee result, not a filled protocol envelope, quorum proof, or `lean_ready` authorization. The external-only gate protocol must still be followed.

## Findings

### G1 — P1 — the executable source validator accepts false source and manifest terminal states

**Files:** `scripts/validate_inventory.py`, especially lines 903–918, 973–1072, 1179–1266, and 1375–1496; `.github/workflows/ci.yml`, lines 17–22; contract target in `blueprint/automation/contract_linting.md`, lines 146–173 and 217–232; mutation policy in `blueprint/automation/testing_and_ci.md`, lines 267–286.

**Evidence.** The committed current data are conservative and truthful: the locked 1997 Watson snapshot is explicitly pending (`blueprint/inventory/source_snapshots.csv:3`), the 2010-to-1997 relation is unresolved and `non_equivalent` (`edition_relations.csv:2`), Watson is `occurrence_unresolved` with DLMF only as a locator (`occurrences.csv:25`), and OLV-MVP-1 is open/planning-only (`manifests.csv:4`). The edition/snapshot compatibility code also correctly rejects unmatched cross-edition transfers (`validate_inventory.py:829–871`, `1096–1143`).

The failure is at the state-transition boundary. `digest_status=verified` checks only that the algorithm/value strings are nonempty. A `resolved` occurrence is not joined to snapshot availability, digest verification, edition reconciliation, or page mapping. Manifest `execution_ready` checks only `scope_closed=true`, registration equality, and a count; it does not require the member source graph to be resolved or the member cards to be present/frozen. The built-in negative suite contains seven useful mutations, but not its own documented high-priority “closing a manifest with an unresolved notation/entity” case.

I ran independent in-memory mutations over deep copies of the parsed archived tables. Each of the following returned **0 validation errors**:

1. Set the pending 1997 snapshot to `digest_status=verified`, algorithm `sha256`, value `x`.
2. Set `OLV97-C03-WATSON` to `resolved` / transcription `verified` / reconciliation `matched`, supplying hash `x`, while its snapshot remains pending and unreconciled with unresolved page mapping and digest.
3. Set OLV-MVP-1 to `scope_closed=true`, `manifest_status=execution_ready`, and its three member registry statuses to `execution_ready`, while Watson remains unresolved and the cards remain planned.
4. Add a summary-only, normalization-unresolved notation on the pending 1997 snapshot and a confirmed Watson link; this was also accepted. This fourth mutation is not independently terminal, but combined with mutation 3 demonstrates the absent closure join.

Thus the CI job can remain green after a source-bearing manifest is falsely advanced to executable. The documents honestly label the fuller contract linter as planned/manual (`contract_linting.md:11–17`), which limits the blast radius, but it does not make a false positive in the current executable state model safe.

**Requested change.** Extend the current validator before treating its source state as CI evidence: validate supported digest syntax (and equality where bytes exist); make `resolved` source occurrences require a non-placeholder, gate-compatible snapshot and appropriate transcription/reconciliation data; make closed/execution-ready source manifests traverse their occurrence/notation/entity/card joins and reject unresolved or planned members; and add minimal negative fixtures for each transition. Keep the zero-source BOOTSTRAP-0 exception explicit.

**Expected effect / blast radius / verification.** Only the inventory validator, source CSV semantics, and CI fixtures need change; no Lean API changes. Re-run both stock modes plus the four mutations above, expecting stable nonzero diagnostics. Confidence: high.

### G2 — P2 — packet/target classification levels drift in planning prose, and frozen bootstrap examples are not protected by the validator

**Files:** `review/classifications-v2.json:13–82,84–136`; `blueprint/methods/summation.md:38–50`; `blueprint/methods/oscillatory_contour.md:39–53`; `scripts/validate_inventory.py:19,552–639,1322–1358`; `blueprint/inventory/cards.csv:1–3`.

**Evidence.** The authority deliberately separates packet and target levels. Packet theorem values are `foundational_calculus`, `definition_identification`, `finite_remainder_bound`, `existence_uniqueness`, `qualitative_bridge`, or `mixed`; target-only values include `exact_identity` and `audit_regression`. Rule 1 requires every field to use its own table, and `mixed` is allowed only when targets actually use more than one value.

Nevertheless, packet/card queue rows classify EM-001, CT-002, and SP-001 as `exact_identity`, and CF-001 as “`exact_identity` plus `finite_remainder_bound`”. These are presented under a `Card` and “Theorem / coverage / novelty class” heading, not as target rows. They are only provisional planning rows, so no frozen card is mislabeled yet, but the current machine vocabulary cannot represent the advertised single-target packet summaries without either choosing another packet shape or being versioned.

Separately, `required_packet_examples` includes QB-001 and DEF-001 with their three exact packet axes, but `REQUIRED_SOURCE_CARD_EXAMPLES` contains only QL-001, OLV-001, and SR-001. As a result, changing QB-001's registry theorem class from `foundational_calculus` to the allowed-but-wrong `finite_remainder_bound`, or DEF-001's coverage from `entity_identification` to the allowed-but-wrong `infrastructure`, produced **0 validation errors**. The current exact CSV/YAML/work-packet values do agree; the defect is that the advertised frozen examples are not invariant under mutation. `cards.csv` also omits the novelty axis, so that axis necessarily remains manual today.

**Requested change.** Make every prose queue use packet-level vocabulary (or issue a versioned classification successor that deliberately adds an appropriate packet shape), and add validator mutations/bindings for QB-001 and DEF-001 registry values. If novelty remains outside the CSV by design, say explicitly where its executable join will eventually live rather than implying all required examples are checked.

**Expected effect / blast radius / verification.** Documentation and classification/validator fixtures only; a schema successor is needed only if `exact_identity` is intentionally admitted at packet level. Re-run the two mutations above and search every “class” table against the correct level. Confidence: high.

### G3 — P2 — QB-001's canonical registry note gives the wrong proof revision

**File:** `blueprint/inventory/cards.csv:2`.

The note says “Card/proof revision 5 and signature revision 2”. The frozen facts are card revision 5, proof revision 4, and signature revision 2 (`blueprint/theorem_cards/QB-001.yaml:5,44–47,110–124`; `review/work_packets/QB-001.yaml:45–59`; `blueprint/theorem_cards/README.md:62`). This is prose rather than a parsed revision column, but it sits in the canonical registry and can misdirect a human envelope author.

**Requested change.** Replace that clause with “Card revision 5, proof revision 4, and signature revision 2”. Blast radius: one CSV note. Verify by searching all QB-001 revision prose. Confidence: high.

## Architecture, dependency direction, and reuse

The blueprint is unusually complete for a specification-only snapshot. It covers the requested finite quantitative core, constructions, family definitions/identifications, integral/contour/summation/ODE/turning-point/zero/connection methods, source recovery, automation, and CI, while repeatedly excluding numerical evaluation and solver infrastructure. The one-package decision is reflected in `lakefile.toml` and there is no numerical subpackage or external numerical dependency.

The global DAG in `blueprint/dependency_graph.md:13–59` has the right direction: pin/source evidence feeds low-level domains and construction; construction feeds identification; the finite core and domains feed methods; identified functions plus methods feed applications; applications feed zero/connection and audit recovery; audit never feeds semantic proofs. The explicit forbidden reverse edges cover the main laundering paths. The per-track graphs preserve these seams, conditional Gamma use is not forced into the Watson path, residual identities are separated from stability, and source recovery is downstream only. Provisional overlaps are named as unresolved planning work rather than silently accepted dependencies.

There is no reusable-extraction candidate to implement at this commit: there are no project declarations or two live consumers. QB-001 is itself the correct small reusable seam, and DEF-001 correctly reuses Mathlib instead of introducing an `LMLF` Gamma object. I found no exact existing Mathlib definitions named `ErrorOn`, `NormBoundOn`, or `HasErrorFamily` at the pin. No upstreaming claim is justified before consumers exist.

## QB-001 revision 5 card review — APPROVE

The card freezes exactly three definitions and five lemmas in `LMLF.Quantitative.Basic`, all imported only from `LMLF.Basic`. The definitions have the right weak natural assumption, `[NormedAddCommGroup E]`; domains are arbitrary sets; real-valued majorants are not globally burdened with nonnegativity; and `HasErrorFamily` fixes the target `f` while asserting no convergence, truncation semantics, or monotone improvement. The five lemmas have their natural directions:

- `exact` uses `Set.EqOn` and a zero majorant;
- `restrict` needs `D' ⊆ D`;
- `weaken` compares bounds only on `D`;
- `trans` exposes the sum majorant from the triangle inequality; and
- `comp` requires `Set.MapsTo ψ S D` and pulls back every function.

The card, signature artifact, proof, and work packet agree on names, binder order, classifications, scope exclusions, and hashes. The proof dossier's extra sections are expressly non-normative, so they do not enlarge the eight-declaration packet. There is no source-coverage claim, named object, hidden choice, construction, or theorem-sized hypothesis. Marking structural review `not_applicable` with the concrete reason in `review/work_packets/QB-001.yaml:318–333` is justified; the natural-language proof gate remains required.

I instantiated all eight exact signatures in a disposable `ScratchQB.lean` with direct proofs and compiled it successfully at the pin. The sole diagnostic was an `unnecessarySeqFocus` style warning in my scratch proof, not in the frozen artifacts or commit. No statement/API change is recommended.

## DEF-001 revision 3 card review — APPROVE

The card is a bounded four-wrapper reuse packet, not a new Gamma construction. Its only permitted import is `Mathlib.Analysis.SpecialFunctions.Gamma.Basic`; it binds Mathlib commit `0df444a360eaa60ab8c11dca51a86af692955474` and source-file SHA-256 `720a9a72d742fbe1c9a89601dc3a00d82c0261c7368c98cccb58307dbffe3bbf`, both independently reproduced.

At that exact source, `Complex.GammaIntegral_convergent` gives the expanded Euler integrand on `Set.Ioi 0` under `0 < s.re`; `Complex.Gamma_eq_integral` identifies `Gamma` with `GammaIntegral`; `Complex.Gamma_ofReal` gives exact real agreement for all real inputs; and `Complex.Gamma_neg_nat_eq_zero` records Mathlib's totalization. The card correctly states that zero at nonpositive integers is a convention at classical poles, not a finite classical Gamma value. It preserves the convergence half-plane and standard complex-power branch semantics.

I instantiated the four exact signatures in a disposable `ScratchDEF.lean` as transparent wrappers around those four declarations. After building the pinned Gamma module, the file compiled successfully. The `equivalent_reformulation` labels for the expanded integrand/integral and `source_equivalent` labels for exact pinned facts are accurate. Natural-language proof and structural-circularity gates are legitimately `not_applicable`, with `not_required` representable in the external envelope (`review/work_packets/DEF-001.yaml:198–220`). No local proof or API change is recommended.

## Trust boundary, circularity, and gate representability

Clear. `review/PROTOCOL.md:56–79` forbids self-referential packet identity and gives candidate-owned statuses no approval authority. Lines 113–169 define theorem-card, proof, structural-circularity, and composite `lean_ready` gates; lines 197–242 keep filled envelopes, verdicts, and dispositions external. The templates bind spec commit, packet/card/proof/classification hashes, toolchain, Mathlib revision, candidate SHAs, reviewer identity/isolation, perspectives, and verdicts.

Both required and inapplicable cases are representable: packet requirements use `applicability: required | not_applicable`; the external envelope uses `gate_state: pass` for a satisfied required gate and `not_required` only for justified inapplicability. QB-001 requires card and proof passes but explicitly records structural `not_required`; DEF-001 requires card pass and explicitly records proof/structural `not_required`. No candidate-owned field can manufacture `lean_ready`.

I found no circularity or hypothesis/choice laundering in either frozen card. The wider blueprint explicitly routes high-risk named constructions, continuations, connections, and source recovery through structural review and rejects structures that assume desired geometry, stability, or identification conclusions.

## Frozen artifacts and dependency pin

All recorded hashes checked exactly:

| Artifact | SHA-256 |
|---|---|
| `review/classifications-v1.yaml` | `7a4f322bb56dbb40d5d44a7eceb50b5a49ea6ae69f414b920341e3b12ea9d71e` |
| `review/classifications-v2.json` | `698626606570827fcc8c78b69865d7cd4bc94de96bc6d5d45c23a5f6611aeeab` |
| `blueprint/theorem_cards/QB-001.yaml` | `de0ed8cae076e7dfe074b4eacc0e5a8875e245c1ddedf8230851bbfd920f0ce4` |
| `blueprint/theorem_cards/QB-001-signatures.md` | `93e4e30a93087de95342abdb1e986676924cd93512e771737d0d3f3ed7973b39` |
| `blueprint/proofs/QB-001.md` | `3513fb1acf141066eb9a4920c1ea238c778d66976ff8479d31c742df93d3a2a5` |
| `blueprint/theorem_cards/DEF-001.yaml` | `b6515349f7fb4d8d8dbc26bf7c24f3e1f6c6d02106ea8200c068282d6ada9dfc` |
| `review/work_packets/QB-001.yaml` | `fb4942e10968e9bb53badb9352e668bd5460d6c482c27ea678cc72175ea9a86a` |
| `review/work_packets/DEF-001.yaml` | `b01d22701a0284a968465ebb79c05430289ce22ee7a575244ec05ba7e8dc38e8` |
| `lakefile.toml` | `c7bb53018e97237f83c740be3e0e42cb9d848097fe20b894cef4e69ba145962b` |
| `lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `lake-manifest.json` | `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404` |
| `scripts/validate_inventory.py` | `b3b878357f525780f5c1f9b4c87f39f54bb516f3ffd056dcf415476e1e9759c2` |
| pinned Mathlib `Gamma/Basic.lean` | `720a9a72d742fbe1c9a89601dc3a00d82c0261c7368c98cccb58307dbffe3bbf` |

The v2 authority's recorded v1 predecessor hash matches. Every work-packet card/proof/signature binding matches the bytes. `lean-toolchain` is `leanprover/lean4:v4.33.1`; `lakefile.toml` requests Mathlib `v4.33.1`; `lake-manifest.json` resolves it to `0df444a360eaa60ab8c11dca51a86af692955474`; and the restored dependency checkout had that exact HEAD. `lake env lean --version` reported Lean 4.33.1, commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`.

## Package, CI, and absence of implementation

`lake build` from a single-process post-`lake clean` state succeeded: 1,325 jobs, including `LMLF.Basic`, `LMLF.Definitions`, `LMLF.Results`, and `LMLF`. An earlier attempted clean build was accidentally overlapped with a second build process; the resulting output-file race was discarded, both processes were allowed/stopped safely, and the reported result is the later single-process clean run.

Both committed validator modes pass: 24 occurrences, 2 notations, 10 entities, 10 entity-evidence rows, 16 associations, and manifest totals BOOTSTRAP-0=0, DEMO-0=0, OLV-MVP-1=1; all seven committed invalid mutations were rejected. `python3 -m py_compile scripts/validate_inventory.py` passes. The checked-in workflow runs precisely those two validator modes and `leanprover/lean-action@v1` build. No Git remote is configured in the supplied repository, so no hosted run/status could be independently queried; this report asserts only the reproduced local checks.

The commit is correctly specification-only. Its complete project Lean surface is four files and 30 lines: `LMLF.lean`, `LMLF/Basic.lean`, `LMLF/Definitions.lean`, and `LMLF/Results.lean`. There are no project declarations and no `sorry`, `admit`, project `axiom`, `unsafe`, or `implemented_by`. `LMLF/Quantitative/Basic.lean` and `LMLF/Definitions/Gamma.lean` are absent. This matches the cards' `implementation_status: not_started` and `prototype_status: absent`; scratch files existed only in the disposable archive and are not candidate implementation.

## Refactor map and do-not-refactor decisions

1. **Reusable extraction candidates:** none before implementation. Preserve QB-001 as the narrow shared seam.
2. **API/generality changes:** G2 only; settle packet classification representation. Do not change the eight QB or four DEF signatures.
3. **Module/dependency changes:** none. Preserve the global forward DAG, separate audit root, conditional DEF-to-QL dependency, and narrow imports.
4. **Cleanup:** G3; correct the QB proof revision note. G1 is validator hardening, not a Lean refactor.
5. **Do not refactor:** do not add QB convenience lemmas to the bootstrap; do not create a project Gamma definition; do not move audit/source recovery into semantic roots; do not materialize provisional family breadth as empty Lean modules; do not add numerical infrastructure.
6. **Local-proof handoffs:** none in the commit. Exact scratch implementations show feasibility, but implementation remains unauthorized until external gates pass.

## Commands and test record

Significant commands, run from the original repository only for Git metadata and otherwise from the disposable archive:

```text
git status --short
git worktree list --porcelain
git show -s --format=... f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de
git ls-tree -r --name-only f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de
mktemp -d /tmp/olver-spec-final-b.XXXXXXXX
git archive f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de | tar -x -C /tmp/olver-spec-final-b.sh7iQ9NV
wc -l -c /home/codex/.codex/attachments/.../pasted-text.txt
sed -n '1,600p' .../pasted-text.txt
sed -n '601,1200p' .../pasted-text.txt
sed -n '1201,1753p' .../pasted-text.txt
/home/codex/.codex/skills/referee-lean-library/scripts/library_inventory.sh /tmp/olver-spec-final-b.sh7iQ9NV
find, rg, nl -ba, and sed over the archived blueprint/review/package sources
sha256sum [all artifacts listed above]
lake update
git -C .lake/packages/mathlib rev-parse HEAD
lake env lean --version
lake clean
lake build
python3 scripts/validate_inventory.py
python3 scripts/validate_inventory.py --negative-tests
python3 -m py_compile scripts/validate_inventory.py
python3 - <<'PY' ... deepcopy/validate_tables mutation matrix ... PY
rg for ErrorOn/NormBoundOn/HasErrorFamily in pinned Mathlib
rg/nl for the four Gamma declarations in pinned Gamma/Basic.lean
lake env lean ScratchQB.lean
lake build Mathlib.Analysis.SpecialFunctions.Gamma.Basic
lake env lean ScratchDEF.lean
wc/find/rg over only the archived committed LMLF Lean files
git remote -v
```

`lake update` restored the exact locked dependencies and left the manifest hash unchanged. The two scratch Lean files were created only in the disposable archive. No source file in the commit or dirty worktree was changed.

## Report integrity

Canonical report SHA-256: `92930158a9f6e880e111884f741a17c071d5b2a70e79acd2d6775ada9801b2c5`

Hash convention: UTF-8 bytes of this file with the 64 hexadecimal characters in the preceding field replaced by 64 ASCII zeroes, and with the final newline included. This avoids a self-referential hash while recording a reproducible digest inside the report.
