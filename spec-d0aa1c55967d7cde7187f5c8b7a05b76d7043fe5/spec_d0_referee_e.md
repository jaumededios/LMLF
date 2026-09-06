# Independent final specification review — exact commit `d0aa1c55967d7cde7187f5c8b7a05b76d7043fe5`

## Review identity and verdicts

- Reviewer identity/model: **gpt-5.6-sol**, independent referee `spec_d0_referee_e`.
- Review kind: read-only, exact-commit specification review. This is one external reviewer opinion; it is not an external review envelope and does not by itself satisfy any quorum or set `lean_ready`.
- **Overall specification verdict: REQUEST CHANGES (one P2 executable-enforcement defect).** The mathematical/card/proof architecture is approvable, but the current CSV validator accepts a forged closed/execution-ready source manifest whose card artifacts remain `planned`; the exact commit therefore does not fully enforce its own source-card/manifest readiness invariant.
- **QB-001 theorem card revision 6: APPROVE.**
- **QB-001 natural-language proof revision 5: APPROVE.**
- **QB-001 structural/circularity review: NOT APPLICABLE / `not_required`.** The packet adds three elementary predicates and five local consequences; it introduces no construction, continuation, existence/uniqueness route, or theorem-sized hypothesis object that could conceal a dependency cycle.
- **DEF-001 theorem card revision 4: APPROVE.**
- **DEF-001 natural-language proof review: NOT APPLICABLE / `not_required`.** The four declarations are direct wrappers around four named, pinned Mathlib declarations; no new mathematical argument is proposed.
- **DEF-001 structural/circularity review: NOT APPLICABLE / `not_required`.** The packet is a transparent pinned-library reuse leaf.
- **Lean implementation review: NOT APPLICABLE for this commit.** No candidate implementation or prototype exists in the exact tree. A successful review of frozen signatures in temporary files is evidence that the specification elaborates; it is not an implementation approval.
- **Composite `lean_ready`: NOT ESTABLISHED.** The exact commit correctly leaves external envelopes, independent-review quorums, and implementation review outstanding.

These verdicts are consistent with the distinction the repository draws among card review, proof review, structural review, source review, implementation review, and the externally owned composite gate.

## Isolation and reviewed material

I did not inspect the live worktree, dirty files, untracked files, or any prior review report. I resolved the requested object and streamed only `git archive d0aa1c55967d7cde7187f5c8b7a05b76d7043fe5` into a disposable directory, `/tmp/spec-d0aa-e-oZSuki`. All repository reads, validation, dependency restoration, build work, source inspection, and temporary Lean files occurred under that archive. The only repository command outside it beyond archive creation was exact-object metadata/tree resolution; it did not expose worktree state.

The reviewed commit metadata was:

```text
commit  d0aa1c55967d7cde7187f5c8b7a05b76d7043fe5
tree    399f98c79ccf07cf35ac1c92a8d74edb3b29db46
parent  f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de
date    2026-09-05T17:54:28+00:00
subject docs: harden specification evidence gates
```

I read the complete attached baseline, `/home/codex/.codex/attachments/6740fc8c-818a-4ce2-95bb-67293a5ba2bf/pasted-text.txt`, in four non-overlapping ranges through EOF. It is 1,753 lines, 92,020 bytes, SHA-256 `6787cdb628a66783d81190939e9593525ebb2640a8c870d685d95ce26ba0cce3`. The exact commit preserves its finite quantitative-library objective while refining it into bounded modules, packet contracts, proof dossiers, source firewalls, and explicit review states.

I applied the `referee-lean-library` rubric to architecture, dependency direction, public boundaries, reuse, and implementation absence, and the `referee-lean-proof` rubric to the two frozen declaration sets, exact signatures, assumptions, proof directness, elaboration, and axiom output. Lean LSP tools were not available in this environment, so exact pinned-toolchain compilation, `#check`, `#print axioms`, and direct pinned-source inspection supplied the declaration-level evidence.

## Findings

### P2 — ready source manifest does not require ready card artifacts

In `scripts/validate_inventory.py`, manifest/card consistency checks only `registration_status == manifest_status`, and the closed/ready source checks only occurrence readiness. `artifact_status` is checked for path consistency, but a card with `artifact_status = planned` is not rejected when its registration and manifest are promoted to `execution_ready`. I constructed a single in-memory transition that (a) made the locked source row look byte-ready using arbitrary syntactically valid SHA-256 values, (b) resolved/verified the occurrence, notation, entity evidence, and links, and (c) changed OLV-MVP-1 plus QL-001/OLV-001/SR-001 registrations to closed/`execution_ready` while deliberately leaving all three card artifacts `planned`. `validate_tables` returned **zero errors**.

This is narrower than an authorization bypass—the external-review envelope remains authoritative, and YAML/Markdown lifecycle linting is honestly described as future/manual—but it contradicts the current CSV-level claim that closed source manifests require complete member cards. The checked-in negative mutation for a ready OLV manifest only proves rejection while its source occurrence remains unresolved; it does not isolate card-artifact readiness. Required correction: for every closed or ready manifest, reject each member whose `artifact_status` is not `file_present` (and require the path); add a negative fixture that first satisfies source readiness, then keeps a member artifact planned. This P2 is why the overall exact-commit verdict is `REQUEST CHANGES`; it does not alter the separate approvals of the frozen QB-001/DEF-001 mathematics.

The following are documented residual risks/design notes rather than additional findings:

1. The checked-in Python validator is intentionally not a source-byte authenticity checker or a complete YAML/Markdown lifecycle/envelope linter. A syntactically well-formed fabricated SHA-256 can therefore be labeled `verified` in a mutated in-memory fixture. External/source reviewers must compare the declared digest to the actual authorized bytes.
2. The current CI is not hermetic at the operating-system level: `ubuntu-latest` moves, and dependency/toolchain bootstrap may require network/cache state. The specification says this honestly and pins all project-controlled action, Lean, and dependency inputs.
3. QB-001's revision-5 dossier contains explicitly non-normative prospective material beyond the eight frozen targets. The packet's exact section locator and target map prevent scope expansion, but a future editorial split would reduce irrelevant digest invalidation. This is maintainability advice, not a card-approval condition.

## Architecture and natural-language modularity

The natural-language development is modular in the mathematical sense, not merely by file count:

- domains, cuts, branches, roots, powers, and approach-side conventions are placed below analytic constructions;
- derivative transport is separated from Laplace bounds, oscillatory/contour methods, summation, ODE residual stability, turning-point/pole methods, and zero/connection results;
- named-function families depend on independently identified objects plus generic method packets rather than embedding source-specific facts in the reusable core;
- qualitative source recovery is confined to downstream `Audit/SourceRecovery` material and cannot back-feed source credit into public semantics;
- automation is leaf-only and cannot define mathematical semantics or discharge review gates;
- hypotheses, finite order conventions, branch choices, exceptional inputs, normalizations, source relationships, and negative tests are explicit instead of being hidden in tactics or bundled opaque structures.

The declared dependency graph has the right direction: pin/basic domains → construction/identification → generic methods → named applications → zeros/connections and downstream audit. I found no specification-level circularity. The exact Lean import graph is also acyclic and minimal:

```text
Mathlib.Analysis.Normed.Group.Basic
  -> LMLF.Basic
  -> LMLF.Definitions
  -> LMLF.Results

LMLF.lean imports Basic, Definitions, Results.
```

The deliberately narrow Watson path does not silently import Airy, Cauchy-contour, ODE, zero, or named-family machinery. The dependency direction and scoped imports are suitable for later library-scale implementation.

## Classification-v2 audit

`review/classifications-v2.json` is frozen schema `lmlf-classification-v2`, artifact revision 2, SHA-256 `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9`. Its theorem-shape, source/infrastructure coverage, and novelty axes are genuinely independent; none is defined to confer review approval, source credit, or implementation authorization. Its supersession link binds v1 by digest instead of rewriting it.

I audited the requested **88 distinct planning rows** by planning ID: 59 family rows, 23 method rows, and six additional planning candidates that occur only in `source_manifest.md` (`QA-002`, `DEF-002`, `QC-001`, `EX-001`, `OLV-001`, and `SR-001`). Repeated appearances of QL-001 and EX-002 are joins, not extra rows; the already-frozen QB-001 and DEF-001 bootstrap entries are not counted as planning rows. Every explicit class literal belongs to the appropriate packet-level vocabulary. `ILT-001` is the one intentionally unclassified method row and says so explicitly pending occurrence collation; that is an honest boundary, not an invalid class. I audited the six classification-authority examples separately: all are expressible; the five `required` examples join exactly to the five `cards.csv` rows, while `NAMED-EXAMPLE` is explicitly illustrative and requires no registry row.

The five required packet rows match exactly:

| ID | theorem class | coverage class | novelty class |
|---|---|---|---|
| QB-001 | `foundational_calculus` | `infrastructure` | `non_novel` |
| DEF-001 | `definition_identification` | `entity_identification` | `non_novel` |
| QL-001 | `finite_remainder_bound` | `infrastructure` | `novel` |
| OLV-001 | `finite_remainder_bound` | `exact_source_generic` | `strengthened_conclusion` |
| SR-001 | `qualitative_bridge` | `audit_source_recovery` | `source_equivalent` |

I separately inspected every frozen packet/target consumer: QB-001's packet triple and eight target triples, and DEF-001's packet triple and four target triples, in both theorem-card and work-packet representations. The 14 target records use only target-level values, contain relationship prose, and preserve their card/proof IDs. Packet summaries agree with the registry and authority. There is no laundering of an internal proof dossier into `source_equivalent`; QB is uniformly `non_novel`, while DEF's two `source_equivalent` targets are exact wrappers of pinned Mathlib facts.

The validator also checks all three canonical registry axes independently. I mutated each axis in memory; theorem and novelty drift each produced one error, and coverage drift produced two because it also violated the source-dependent readiness constraint.

## Source snapshot, edition, association, and readiness firewall

The exact data are conservative and coherent:

- `SRC-OLV-2010-PREVIEW` is partial, lacks a stored digest, and has unresolved page mapping. It may support only preview-scoped assertions.
- `SRC-OLV-1997-COLLATION-PENDING` is a `locked_copy_placeholder`, unavailable, undigested, unreconciled, and explicitly not an inspected snapshot.
- `REL-OLV-2010-TO-1997` records only `later_reprint_of`; both content and locator equivalence remain unresolved, and its join semantics are `non_equivalent`.
- A ready snapshot must be non-placeholder, available, use a lowercase 64-hex `sha256`, have digest status `verified`, and have both edition reconciliation and page mapping `matched`.
- A ready occurrence must additionally be resolved, transcription-verified, reconciled, and attached to that ready snapshot.
- Source provenance joins are permitted for the exact same snapshot, or for distinct editions only when both reconciliation directions are matched and an explicit edition relation is fully equivalent. Distinct snapshots of the same edition do not join merely because edition IDs or even digest strings match.
- Confirmed notation requires a ready occurrence, a resolved and verified notation row on a ready snapshot, and compatible provenance.
- Confirmed entity associations require compatible confirmed evidence and a locked-target confirmed occurrence association.
- Source-dependent card readiness requires its occurrence association and ready occurrence; a closed/ready source manifest requires every coverage occurrence to be ready and card/manifest statuses to agree.

The current rows respect these predicates. `BOOTSTRAP-0` is closed and `execution_ready` with zero source occurrences; it contains the two complete bootstrap cards but explicitly does not claim external source coverage. `OLV-MVP-1` has locked occurrence selection but is open and `planning_only`; QL-001, OLV-001, and SR-001 remain planned. The phrase `execution_ready` is therefore a bounded specification state, not a review approval or implementation authorization.

### Fifteen checked-in negative mutations

`python3 scripts/validate_inventory.py --negative-tests` confirms that all 15 deliberately invalid copied fixtures are rejected. I inspected the mutations themselves and confirmed coverage of:

1. occurrence edition/snapshot mismatch;
2. preview-only evidence used to confirm an entity;
3. an unresolved edition relation marked equivalent;
4. a preview occurrence given a locked-edition page prefix;
5. an incorrect manifest denominator;
6. Watson/2010-preview notation association;
7. Watson/2010-preview entity association;
8. a verified source digest with unsupported `md5`/uppercase form;
9. a verified transcription digest with unsupported `md5`/uppercase form;
10. Watson marked resolved on a placeholder snapshot;
11. a same-edition placeholder notation join;
12. confirmed notation with unresolved summary-only endpoints;
13. a closed/ready source manifest with unresolved occurrence/member/cards;
14. QL-001 novelty drift from the classification authority; and
15. a confirmed association between distinct ready same-edition snapshots.

### Additional adversarial state transitions

I exercised further in-memory mutations without changing any archived source file:

- **Fake well-formed hashes:** arbitrary lowercase 64-hex values pass syntax when the rows are also labeled `verified`. This is expected because source bytes are unavailable to the CSV checker; it is why external source attestation remains mandatory.
- **Placeholder promotion:** changing status fields alone does not make the locked placeholder ready; `snapshot_kind = locked_copy_placeholder` is an absolute veto.
- **Same snapshot:** exact-snapshot associations are accepted, as intended.
- **Same edition, distinct snapshots:** rejected even when I gave the two rows identical digest strings. This prevents silent snapshot-equivalence inference.
- **Confirmed endpoints:** confirmation fails when notation/entity endpoints are unresolved, preview-only, or lack compatible ready evidence; the built-in mutations cover both notation and entity cases.
- **Classification drift:** independent theorem, coverage, and novelty mutations are all detected.
- **Source-card/manifest readiness:** unresolved source members cannot be promoted through the ordinary predicates. In a deliberately forged composite state, however, I supplied arbitrary syntactically valid source/transcription hashes, manually labeled all endpoints resolved/verified, added compatible confirmed links, and promoted `OLV-MVP-1` plus its card registration statuses while leaving the three card artifacts `planned`. `validate_tables` returned zero errors. Trusting asserted digest status is the documented source-byte boundary; failing to reject the still-planned card artifacts is the P2 executable-enforcement defect above. The exact committed data make no false promotion, but the validator accepts one.

## Frozen artifacts and digest/revision joins

All checked packet-embedded upstream bindings reproduce byte-for-byte:

| Artifact | Frozen revision | SHA-256 |
|---|---:|---|
| classification authority | 2 | `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9` |
| QB-001 theorem card | 6 | `7e83195fd3b6ff9ea884e29f6d857a4673c9de5fe44327d914e595e6b798468f` |
| QB-001 NLP dossier | 5 | `167629f117dc0609809162b5a5247d05e0c9a193d96b84d9cda5247e930ecd4c` |
| QB-001 signature artifact | 2 | `93e4e30a93087de95342abdb1e986676924cd93512e771737d0d3f3ed7973b39` |
| QB-001 work packet | 3 | `6eaeea14a581d4b60c7933afb2c9bb24a633df135a935b7c7e4af11c9845cf87` |
| DEF-001 theorem card | 4 | `eff82b06afaa61b67d13c3a399494525ed452e42c203a390ba40e56b93ec9daa` |
| DEF-001 work packet | 3 | `6dbda13f4f27dd4c0492c00ecc0a2d184f00fe85fa7096802cf93e9fdecf11e8` |

Both work packets intentionally omit their own path, commit, and digest. This is correct anti-self-reference design: an external envelope must bind reviewer identity/model, work item, exact spec commit, packet path and SHA, upstream revisions/SHAs, applicability states, and verdict. No such envelope is present in this exact commit, so no quorum is claimed.

## QB-001 card revision 6 and proof revision 5

The card freezes exactly three definitions and five theorems:

1. `ErrorOn`, `NormBoundOn`, and `HasErrorFamily`;
2. `ErrorOn.exact`, `.restrict`, `.weaken`, `.trans`, and `.comp`.

The statements are appropriately general over types and normed additive commutative groups. Empty domains are intentionally allowed for reusable infrastructure; no convergence-in-order claim is smuggled into `HasErrorFamily`; the target function is fixed across the family; weakening has the majorant inequality in the correct direction; transitivity yields `b x + d x`; and precomposition requires `Set.MapsTo ψ S D`.

The packet locates the normative proof material exactly: scope/standing assumptions; QB-001.1, .2, .3; forward exactness in .5; and .7. I realized the frozen signatures with those direct proofs in a temporary archived-tree file. All eight exact declarations compiled. `#check` printed the intended types, and each of the five theorem proofs reported only Mathlib's ordinary `[propext, Classical.choice, Quot.sound]` axioms. There was no `sorry`, `admit`, extra axiom, broadened import, strengthened hypothesis, hidden nonemptiness, or proof-fragility issue.

**QB-001 card verdict: APPROVE.**  
**QB-001 NLP proof verdict: APPROVE.**  
**QB-001 structural verdict: NOT APPLICABLE / `not_required`.**

## DEF-001 card revision 4

The four signatures compile unchanged against `Mathlib.Analysis.SpecialFunctions.Gamma.Basic` at the pinned commit:

- `gamma_eulerIntegrable` is a transparent presentation of `Complex.GammaIntegral_convergent` using `simpa only [Complex.GammaIntegral]`;
- `gamma_eq_eulerIntegral` similarly presents `Complex.Gamma_eq_integral` with the integrand expanded;
- `gamma_ofReal` is the exact pinned real/complex agreement fact; and
- `gamma_neg_nat_eq_zero` is the exact pinned totalization fact.

The card's domain and branch prose is accurate: `0 < s.re` is the Euler-integral half-plane; `t ∈ Set.Ioi 0` avoids zero and the standard cut for the complex power; no equality is asserted outside convergence for the first two results. The pole semantics are especially careful: `Complex.Gamma (-(n : ℂ)) = 0` includes `n = 0`, is identified as Mathlib's totalization convention at classical poles, and is not described as assigning a classical finite value.

All four temporary realizations compiled with their exact signatures. `#print axioms` reported `[propext, Classical.choice, Quot.sound]` for each. The pinned source file's digest and declarations match the packet.

**DEF-001 card verdict: APPROVE.**  
**DEF-001 NLP verdict: NOT APPLICABLE / `not_required`.**  
**DEF-001 structural verdict: NOT APPLICABLE / `not_required`.**

## Toolchain, CI pins, and reproducibility boundary

- `lean-toolchain`: `leanprover/lean4:v4.33.1`, file SHA-256 `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71`.
- Lean used: 4.33.1, commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`, Release.
- Lake used: `5.0.0-src+819816b`.
- `lakefile.toml` requests Mathlib `v4.33.1`, SHA-256 `c7bb53018e97237f83c740be3e0e42cb9d848097fe20b894cef4e69ba145962b`.
- `lake-manifest.json` SHA-256 `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`; the resolved Mathlib checkout is exactly `0df444a360eaa60ab8c11dca51a86af692955474`, and transitive inputs are full commits.
- The pinned Gamma source digest is `720a9a72d742fbe1c9a89601dc3a00d82c0261c7368c98cccb58307dbffe3bbf`.
- `actions/checkout` is pinned to `fbc6f3992d24b796d5a048ff273f7fcc4a7b6c09` (commented v5).
- `leanprover/lean-action` is pinned to `50fcf42d2e460296f1a34b402e990d1b24f8b596` (commented v1).
- CI runs the positive inventory validator, all negative fixtures, and `build: true` with read-only repository permissions.

`lake update` in the disposable archive resolved the lock without changing `lean-toolchain`, `lakefile.toml`, or `lake-manifest.json`; the restored Mathlib checkout was clean. `lake build` completed all 1,325 jobs. This is strong reproducibility evidence for project-controlled inputs, but not a claim of a bit-for-bit hermetic OS: the workflow deliberately uses moving `ubuntu-latest`, and bootstrap/cache/network availability remains environmental. The specification states this limitation explicitly.

## Absence of implementation in the exact commit

The library inventory found four Lean files and 30 lines total. They contain imports and documentation comments only. An exact-tree scan found no `def`, `theorem`, `lemma`, `axiom`, `opaque`, `unsafe`, `sorry`, `admit`, or `implemented_by` declaration in tracked Lean source. The requested future paths such as `LMLF/Quantitative/Basic.lean`, `LMLF/Definitions/Gamma.lean`, and the associated audit/test/tactic modules do not exist in the commit tree. This agrees with both packets' `implementation_status: not_started`/prototype-absent claims.

The temporary `QB001Review.lean` and `DEF001Review.lean` files were created only in `/tmp/spec-d0aa-e-oZSuki` to test frozen signatures; they are not repository artifacts and provide no implementation status.

## Reproducible command record

The principal commands were:

```bash
tmpdir=$(mktemp -d /tmp/spec-d0aa-e-XXXXXX)
git -C /home/codex/Documents/Codex/2026-09-05/yo rev-parse 'd0aa1c55967d7cde7187f5c8b7a05b76d7043fe5^{commit}'
git -C /home/codex/Documents/Codex/2026-09-05/yo archive d0aa1c55967d7cde7187f5c8b7a05b76d7043fe5 | tar -x -C "$tmpdir"
git -C /home/codex/Documents/Codex/2026-09-05/yo show -s --format='%H%n%T%n%P%n%aI%n%s' d0aa1c55967d7cde7187f5c8b7a05b76d7043fe5

wc -l -c /home/codex/.codex/attachments/6740fc8c-818a-4ce2-95bb-67293a5ba2bf/pasted-text.txt
sha256sum /home/codex/.codex/attachments/6740fc8c-818a-4ce2-95bb-67293a5ba2bf/pasted-text.txt
sed -n '1,450p'   /home/codex/.codex/attachments/6740fc8c-818a-4ce2-95bb-67293a5ba2bf/pasted-text.txt
sed -n '451,900p' /home/codex/.codex/attachments/6740fc8c-818a-4ce2-95bb-67293a5ba2bf/pasted-text.txt
sed -n '901,1350p' /home/codex/.codex/attachments/6740fc8c-818a-4ce2-95bb-67293a5ba2bf/pasted-text.txt
sed -n '1351,1800p' /home/codex/.codex/attachments/6740fc8c-818a-4ce2-95bb-67293a5ba2bf/pasted-text.txt

/home/codex/.codex/skills/referee-lean-library/scripts/library_inventory.sh /tmp/spec-d0aa-e-oZSuki
python3 scripts/validate_inventory.py
python3 scripts/validate_inventory.py --negative-tests
sha256sum review/classifications-v2.json blueprint/theorem_cards/QB-001.yaml blueprint/proofs/QB-001.md blueprint/theorem_cards/QB-001-signatures.md review/work_packets/QB-001.yaml blueprint/theorem_cards/DEF-001.yaml review/work_packets/DEF-001.yaml lean-toolchain lakefile.toml lake-manifest.json

lake update
git -C .lake/packages/mathlib rev-parse HEAD
git -C .lake/packages/mathlib status --porcelain
sha256sum .lake/packages/mathlib/Mathlib/Analysis/SpecialFunctions/Gamma/Basic.lean
lake env lean --version
lake --version
lake build
lake env lean QB001Review.lean
lake env lean DEF001Review.lean
```

I also ran read-only Python snippets in the archive to parse and deduplicate the 88 planning rows, check the six authority examples, mutate each registry axis, and exercise the additional source-state transitions described above. Baseline validation produced zero errors. The positive validator reported 24 occurrences, two notations, ten entities, ten entity-evidence rows, 16 occurrence associations, and manifest totals `BOOTSTRAP-0=0`, `DEMO-0=0`, `OLV-MVP-1=1`. The negative suite reported all 15 invalid fixtures rejected.

## Final conclusion

Commit `d0aa1c55967d7cde7187f5c8b7a05b76d7043fe5` has strong mathematical module boundaries, an acyclic dependency plan, exact classification and artifact bindings, conservative source/edition joins, honest external-only review gates, pinned controlled inputs, and no hidden candidate implementation. QB-001 revision 6 plus NLP revision 5 and DEF-001 revision 4 are ready for their respective external card/proof verdict aggregation. The exact commit nevertheless needs the P2 card-artifact readiness check and focused negative fixture before the executable specification as a whole is approved. Implementation remains correctly unauthorized until that correction, external envelopes, and declared quorums exist.

## Report integrity

The ordinary SHA-256 of the final report file is computed only after the last byte is written and is therefore supplied in the external delivery record. Embedding that same ordinary digest in the bytes it hashes would be self-referential; no false self-digest is asserted here.
