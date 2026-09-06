# Independent Stage 1 blueprint review — referee M

## Controlled verdict

**Verdict: `request_changes`**

**Reviewer ID:** `/root/stage1_scope_referee_m`  
**Review kind:** independent agent blueprint/architecture review; no implementation review and no operative design-decision authority  
**Model disclosure:** GPT-5, as exposed by the Codex system/developer context; no more specific backend model identifier was exposed, so none is inferred  
**Runtime:** Codex desktop agent in a Linux 5.15.0-190-generic x86_64 container; Python 3.11.2; Git 2.39.5  
**Isolation strength:** `manual_attestation`  
**Isolation method:** fresh disposable `git clone --no-hardlinks`, detached at the exact candidate commit, with a fresh review context. The candidate checkout was not edited. The only write was this external report.  
**Isolation limits:** the runtime had network access, credentials/tooling may have been available, and filesystem write access was not technically restricted. This is not a hardened clean-room execution and is not represented as `technically_enforced`.

This is one independent blueprint verdict. It does not approve or reject any Lean implementation rubric, transfer any prior approval to a new head, select DD-021 as operative authority, or substitute for the second required blueprint approval and root external adjudication.

## Exact candidate binding

- Candidate repository supplied for review: `/tmp/lmlf-stage1-scope.DbhM9YHt`
- Disposable detached checkout reviewed: `/tmp/lmlf-stage1-referee-m.mDjmMT/repo`
- Candidate commit: `aebe7968bd6d5dcd23ac949d5d5e0d8854334ca1`
- Review state: detached `HEAD`; clean (`git status --porcelain=v1` produced no paths)

All seven required successor files matched the supplied SHA-256 values:

| File | SHA-256 |
|---|---|
| `README.md` | `96de77b4745c40eb100a576a376b1a939ef9a89b4a3edf32ca840d25cec704ab` |
| `blueprint/README.md` | `318953bf35984662ed74c36d3b71aff34cb43471ea93a2e63df1bd4417b35b83` |
| `blueprint/stage_1_dlmf-R7.md` | `4964a4ad79b8e8da0cdd376836383b189c32b38eaeecd9979dfdcca8cb54b4c2` |
| `blueprint/roadmap.md` | `e7b060f55660000e00af64eee6df33b2ddfcf37aec9e5a403cd149f95b95cb85` |
| `blueprint/design_decisions.md` | `a74eadcd08bf2e4823f51e2aaf7d2e9994f81d3c647d293334411a99fffb537c` |
| `blueprint/source_manifest.md` | `a85e02c3cc4ac259bab4cb5474d9449884973240370e0af446b0725b56d887f2` |
| `blueprint/dependency_graph.md` | `7eb4c218af5e1b00a59facd8793b703928325077d06ce8c4e33358fd8e25bd9b` |

## Scope and materials read

I read all seven successor files completely. I also read completely:

- `/home/codex/.codex/skills/referee-lean-library/SKILL.md` and its required `references/global-rubric.md`;
- `review/PROTOCOL.md`;
- `review/classifications-v3.json`;
- all five current rubrics in `review/rubrics/`;
- `blueprint/theorem_cards/README.md`; and
- `review/README.md`.

I read the directly necessary legacy control clauses in `blueprint/qualitative/release_strategy.md` (product split, staged-release ladder, and alternate-edition rule) and `blueprint/qualitative/navigation_and_docs.md` (initial documentation slice and anti-overclaiming rules). I did not read R1–R6 Stage 1 plans, predecessor or peer review reports/dispositions, uncommitted work, an implementation worktree, design/migration drafts, or Verso implementation material.

The two expressly permitted operational IMP inputs were hash-verified and read:

- `imp-core-b8d2f73-main-integration-checkpoint.md`, SHA-256 `7ca0faec39ded02e621b0db2dd697c97e0dec7a030641e213a474958a98ea040`;
- `implementation-b8d2f731fcfd5cd0889d0732f13699eb94681c86/IMP-001-review-envelope-implementation-pass.yaml`, SHA-256 `bef995a73d1695238ddcfea92a5ac54926f4a7185317f824ab62e179a21e64e3`.

Those records were used only as factual current-state inputs. I did not inspect the underlying referee reports and do not transfer their approval to this blueprint candidate or to any later integration head.

## Primary-source challenge

I checked the proposal's discovery claims directly against official NIST DLMF pages. This was a focused challenge, not a full source census or a retained exact-payload source audit.

Primary URLs consulted:

- <https://dlmf.nist.gov/>
- <https://dlmf.nist.gov/about/news/>
- <https://dlmf.nist.gov/errata/>
- <https://dlmf.nist.gov/4>, <https://dlmf.nist.gov/5>, <https://dlmf.nist.gov/6>, <https://dlmf.nist.gov/7>, <https://dlmf.nist.gov/8>, <https://dlmf.nist.gov/9>, <https://dlmf.nist.gov/10>
- <https://dlmf.nist.gov/4.13>, <https://dlmf.nist.gov/5.18>, <https://dlmf.nist.gov/8.22>, <https://dlmf.nist.gov/9.14>, <https://dlmf.nist.gov/10.21#xiii>, <https://dlmf.nist.gov/10.43#iii>, <https://dlmf.nist.gov/10.46>, and <https://dlmf.nist.gov/10.61>

The official root/news/errata pages confirm version 1.2.7 and release date 2026-06-15. The chapter landing pages confirm the titles and section endpoints used by the Chapter 4–10 map. The focused pages support the proposal's omission-sensitive sentinels: §4.13 exposes `W_k`, the legacy `Wp`/`Wm` relations, Wright omega, Tree `T`, prose properties, annotations, and asymptotic formulas; §9.14 defines incomplete Airy functions by cross-reference and then gives external-reference leads; §10.46 separately contains the generalized Bessel series, its relation to `I_ν`, the Mittag–Leffler definition, the under-specified Laplace-transform sentence, and a reference-only incomplete-Bessel/Hankel lead. I found no source-fidelity defect in these checked claims.

## Architecture assessment

Apart from G1 below, the successor is semantically strong and appropriately cautious.

- The user boundary is represented exactly: Chapters 4–10 are the exhaustive mathematical-assertion programme, including prose, annotations, tables, captions, applications, and mathematical content in computational sections; Chapters 1–3 and later/external material are finite consumer-justified support only.
- Exact mathematics is cleanly separated from numerical software. Future verified numerics is only a downstream design consumer; no algorithm, tolerance, evaluation, interval, or performance API is frozen here.
- The source model separates canonical retrieval documents, source-owning leaves, appearances, atomic claims, shared contexts, representations, and locator aliases. It preserves genuine repeat occurrences while preventing fragment/rendering duplication.
- The partial-denominator design is sound: `Target(S,B)` is undefined until `PartitionReady`, local denominators cannot be advertised globally, and `Target(S)` exists only after a separately reviewed and externally selected exhaustive closure.
- Within-snapshot source-identity repair, same-appearance atomization repair, cross-snapshot evolution, and notation/entity/association repairs are typed, append-only, and use fresh identities. Source identity is not conflated with object identity.
- Obligation classification is total and semantic. Ordinary exact/structural targets remain distinct from genuine asymptotic/approximation targets; the latter require both a reusable finite quantitative producer and a faithful downstream source-recovery declaration.
- The finite least transitive support closure prevents hidden Chapter 1–3/later/external prerequisites, preserves source dependence, and terminates pinned Mathlib branches at reviewed exact interfaces rather than recensusing Mathlib.
- External authority, adverse evidence, suspension, invalidation, and one-head integration are coherently separated from candidate-owned status fields.
- The diagnostic `AuditClosedWithIssues` state is correctly distinct from `PartitionReady`, theorem denominators, source credit, and strict Stage 1 completion. Underdetermined claims remain provisional; contradicted well-posed atoms remain in the denominator with zero theorem/coverage credit.

No schema, validator, census, theorem-card, proof, or Lean implementation is required to exist in this proposal, and I did not treat its planned absence as a finding. Routine implementation-format choices likewise remain unfrozen.

## Finding

### G1 — P1 — The successor's current IMP lifecycle and dependency state contradict accepted exact-bound operational authority

**Concrete failure.** The proposal says its bounded status repair replaces stale IMP lifecycle and dependent-next-step descriptions (`blueprint/stage_1_dlmf-R7.md:126–131`), but the exact seven-file successor still repeatedly states that IMP-001 awaits final pre-Lean review and an external envelope, has no `lean_ready`, has no production implementation, and exists only as a compiled-unreviewed axiomatic prototype. Examples include:

- `README.md:48–53`;
- `blueprint/README.md:43`, `:46`, `:205–211`, `:263–266`, and `:289–295`;
- `blueprint/roadmap.md:63–67` and `:327–336`;
- `blueprint/design_decisions.md:260–267`;
- `blueprint/source_manifest.md:213–218` and `:267–270`; and
- `blueprint/dependency_graph.md:112–114`, `:129–144`, `:232–236`, and `:439–442`.

The permitted exact-bound operational records establish the opposite limited fact before the candidate commit was created: IMP-001's frozen R7 specification received passing pre-Lean gates and `lean_ready`; its eight-target source-free implementation received all required implementation approvals; the merge gate passed; and exact candidate `b8d2f731fcfd5cd0889d0732f13699eb94681c86` was fast-forwarded to main with a locally observed 2766-job build pass. The checkpoint explicitly grants no DLMF or Olver source coverage, so correcting the status does not broaden source claims.

The Git graph reinforces the integration defect. Candidate `aebe7968...` and accepted main `b8d2f73...` have merge base `3a1b16cae6d186a20530de3b883c1bb871ee76f6`; `b8d2f73...` is on `origin/main`, but is not an ancestor of this candidate. Thus this proposed current-truth successor was authored from the pre-implementation base and does not itself contain the accepted IMP integration it is meant to describe.

**Cost/risk.** The dependency map leaves QL planners with the wrong prerequisite state and can cause redundant final IMP review/signature work, while the top-level “current truth” pages falsely deny an accepted semantic layer. More seriously, accepting the candidate as the authoritative seven-file successor without reconciling it with accepted main would make the control plane and implementation history disagree. This is an architecture/integration defect, not merely editorial staleness.

**Bounded fix.** Reissue the exact seven-file successor on top of accepted main `b8d2f731fcfd5cd0889d0732f13699eb94681c86` (or otherwise produce a successor whose full tree includes that accepted integration), and reconcile only the repeated IMP current-state/next-edge prose:

1. preserve the immutable card/work-packet self-status and historical prerequisite-review descriptions;
2. record the external effective state separately: exact IMP specification binding, `lean_ready: pass`, audited implementation/merge at `b8d2f73...`, and the two permitted evidence references/digests;
3. change the QL next edge from “obtain/verify whether final IMP acceptance exists” to “pin and reuse the accepted IMP interface, then perform QL's own still-required reviews and exact-head integration checks”;
4. preserve the explicit facts that IMP is source-free and earns no DLMF or Olver coverage; and
5. state that a later combined head still requires its own exact-head build/integration review, without pretending that this transfers or recreates the old IMP verdict.

Because DD-021 activation is bound to exact commit and seven-file digests, this material correction necessarily creates a new candidate identity and requires fresh blueprint verdicts and root adjudication for those new bytes.

**Confidence:** high.

## Rubric disposition

- Mathematical intent: clear except G1's false prerequisite/current-state description.
- Reusable seams: clear; ordinary structural mathematics, finite quantitative producers, and source-specific recovery have appropriate reusable boundaries.
- Public API/theorem shape: clear at blueprint level; the proposal does not prematurely freeze routine schema representation or Lean signatures.
- Module/dependency design: `request_changes` because of G1; the abstract direction is otherwise sound.
- Mathlib integration: clear at this proposal level; exact pinned-interface termination is specified, with no demand to recensus Mathlib.
- Proof architecture: clear at this proposal level; no implementation proof is under review.
- Cost/durability: clear apart from G1's stale control-plane state.
- Refactor risk: the bounded fix above preserves immutable evidence and requires fresh exact-byte review; no broad redesign is requested.

## Commands and results

- Fresh isolation: `git clone --no-hardlinks /tmp/lmlf-stage1-scope.DbhM9YHt <temp>/repo`; `git checkout --detach aebe7968...` — succeeded.
- Snapshot: `git status --short --branch`; `git rev-parse HEAD`; `git worktree list`; `git log -5 --oneline` — detached clean candidate at the required SHA; only the disposable checkout was attached there.
- Hash binding: `sha256sum` over the seven required files — all seven matched exactly.
- Skill inventory: `library_inventory.sh <repo>` — 7 Lean files, 210 lines, 3 definitions, 18 theorems, no trust/resource markers; used only as review leads.
- Positive inventory validation: `python3 scripts/validate_inventory.py` — pass; 148 occurrences, 31 notations, 32 entities, 34 entity-evidence rows, 88 occurrence associations; manifest totals `BOOTSTRAP-0=0`, `DEMO-0=0`, `IMPROPER-0=0`, `OLV-MVP-1=1`.
- Negative inventory validation: `python3 scripts/validate_inventory.py --negative-tests` — pass; all 25 intentionally invalid copied fixtures rejected, followed by the same valid inventory totals.
- Operational evidence binding: `sha256sum` over the two permitted IMP records — both matched the supplied digests.
- Integration check: `git merge-base b8d2f73... aebe796...` returned `3a1b16ca...`; `git merge-base --is-ancestor b8d2f73... aebe796...` returned false; `git branch -r --contains b8d2f73...` listed `origin/main` and `origin/impl/imp-001-core`.
- Official DLMF pages were opened directly at the URLs listed above; no bulk download was performed.

No `lake build` or CI run was performed because this is a documentation-only blueprint review and the requested local validator checks passed.

