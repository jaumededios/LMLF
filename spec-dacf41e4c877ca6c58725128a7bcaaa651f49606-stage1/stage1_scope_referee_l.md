# Independent Stage 1 scope and architecture review

## Verdict

**`request_changes`**

The proposed seven-file successor is careful and unusually strong on source identity, atomic accounting, quantitative obligations, dependency closure, proof-before-signature ordering, and exact-head authority. One P1 specification gap nevertheless prevents approval: a substantive but irreducibly underspecified or false DLMF assertion has no faithful terminal state. The proposal itself supplies a concrete instance, the Laplace-transform sentence in DLMF §10.46. Under the current rules a reviewer must either invent an exact theorem, misclassify the statement as reference-only/nonmathematical, or leave the global denominator and Stage 1 completion permanently undefined. This report does not activate DD-021; root adjudication owns that decision.

## Review identity and isolation

- Reviewer ID: `/root/stage1_scope_referee_l`
- Reviewer kind: independent fresh-context agent
- Model: OpenAI Codex, GPT-5 family; the runtime did not expose a more specific serving-model identifier to the reviewer
- Runtime: Codex desktop Linux container, 2026-09-06 session
- Isolation strength: `manual_attestation`
- Isolation method: I made a new local `git clone --no-local --no-checkout` from the supplied candidate, checked out the requested commit detached at `/tmp/lmlf-stage1-review.0GvvHc/repo`, and treated the supplied candidate path as read-only. The environment was not a hardened clean-room: filesystem and network access existed, and manual isolation cannot prove exclusion of credentials, plugins, personal instructions, or other writable paths. I made no candidate edits, commits, pins, CI runs, pushes, source bulk downloads, or delegations.
- Exclusions honored: I did not read the R1--R5 plan contents, predecessor or peer scope-review reports/dispositions, the IMP implementation worktree, uncommitted work, or Verso implementation. After a factual state clarification from root, I read only the permitted IMP operational integration checkpoint and its passing envelope, not the underlying referee reports or dispositions.

## Exact reviewed snapshot

- Candidate commit: `dacf41e4c877ca6c58725128a7bcaaa651f49606`
- Checkout state: detached HEAD, clean (`## HEAD (no branch)`)

| Required file | SHA-256 |
|---|---|
| `blueprint/stage_1_dlmf-R6.md` | `fd75254a9e2d00076c404b535f8e40ac1c5c7a5574b5eb536e13f270c0ec29f6` |
| `README.md` | `d2a57b644a955bb17e216fff95aef676f0d5652af0589aecd40b43c378cace71` |
| `blueprint/README.md` | `729dbed07069aa68a549bf8071c69f576c1465c90e3f42b440ad4912bed12dd6` |
| `blueprint/roadmap.md` | `d6b262e18ad4e713dd73138bedb306cc6c2f7c36acc35d0994b04252e2319ca5` |
| `blueprint/design_decisions.md` | `d6c267dde00ea7a62b3e3143a72018e0dde0ddf77fe100b0aa30c265524b9518` |
| `blueprint/source_manifest.md` | `5011b83661a95dac66a1ce2fbc64b608dcdf1ad3f83be5744ef80ce2ff681434` |
| `blueprint/dependency_graph.md` | `ef6a7994fcd20db658c78d1ef284424ffae8f604dadaa0feb3bdef0f7e304670` |

## Material read and checks performed

I read all seven required files completely (3,155 lines total). I also read completely:

- `/home/codex/.codex/skills/referee-lean-library/SKILL.md` and both required references, `global-rubric.md` and `research-basis.md`;
- `review/PROTOCOL.md`, `review/README.md`, and all five current rubrics (`api_dependency`, `mathlib_reuse`, `proof_quality`, `quantitative_correctness`, and `source_fidelity`);
- `blueprint/theorem_cards/README.md` and the current authority `review/classifications-v3.json`;
- the complete legacy staged-release/product/edition clauses in `blueprint/qualitative/release_strategy.md` and the directly referenced “Initial documentation slice” clause in `blueprint/qualitative/navigation_and_docs.md`;
- the canonical `IMP-001`, `QL-001`, and `OLV-001` rows in `blueprint/inventory/cards.csv` and `IMPROPER-0` in `blueprint/inventory/manifests.csv`.

For the later external IMP state clarification, I verified and read:

- `imp-core-b8d2f73-main-integration-checkpoint.md`, SHA-256 `7ca0faec39ded02e621b0db2dd697c97e0dec7a030641e213a474958a98ea040`;
- `implementation-b8d2f731fcfd5cd0889d0732f13699eb94681c86/IMP-001-review-envelope-implementation-pass.yaml`, SHA-256 `bef995a73d1695238ddcfea92a5ac54926f4a7185317f824ab62e179a21e64e3`.

Those records bind source-free IMP specification commit `3a1b16cae6d186a20530de3b883c1bb871ee76f6`, accepted implementation head `b8d2f731fcfd5cd0889d0732f13699eb94681c86`, passing pre-Lean and implementation gates, and merge pass. They are operational evidence, not scope-review credit.

### Commands and results

- `git clone --quiet --no-local --no-checkout ...` followed by `git checkout --quiet --detach dacf41e...`: succeeded; exact detached HEAD obtained without registering a worktree in the candidate repository.
- `git rev-parse HEAD`, `git status --short --branch`, `git worktree list --porcelain`: reported exact HEAD `dacf41e4c877ca6c58725128a7bcaaa651f49606`, detached, clean, with only the disposable checkout listed.
- `sha256sum` over the seven required files: all seven hashes matched the supplied values above.
- `wc -l` and chunked `sed -n` reads: 1,121 + 126 + 401 + 443 + 289 + 332 + 443 = 3,155 required-file lines read.
- `git log -5 --oneline --decorate`: inspected commit metadata only; no predecessor plan contents or diffs were opened.
- `/home/codex/.codex/skills/referee-lean-library/scripts/library_inventory.sh /tmp/lmlf-stage1-review.0GvvHc/repo`: 7 Lean files, 210 Lean lines, 3 `def`s, 18 `theorem`s; import edges point from roots to definitions/results and from the separate audit consumer to semantic modules; no trust/resource marker was reported.
- `python3 scripts/validate_inventory.py --negative-tests`: passed; all 25 intentionally invalid copied fixtures were rejected, followed by the valid inventory summary of 148 occurrences, 31 notations, 32 entities, 34 entity-evidence rows, 88 occurrence associations, and manifest source totals `BOOTSTRAP-0=0`, `DEMO-0=0`, `IMPROPER-0=0`, `OLV-MVP-1=1`.
- Targeted `rg -n`/`nl -ba` checks confirmed the candidate's IMP pending self-status, the canonical inventory state, the external-lookup language in the dependency graph, and the exact §10.46/partition/completion/source-issue clauses cited below.
- No production build was run because the candidate change is a documentation-only programme proposal and the existing deterministic inventory checks were sufficient for this review.

## Official primary-source verification

I used only official NIST/DLMF pages for source claims relied on here:

- [DLMF root](https://dlmf.nist.gov/) and [project news](https://dlmf.nist.gov/about/news/) confirm version 1.2.7 and release date 2026-06-15.
- [DLMF errata](https://dlmf.nist.gov/errata/) confirms the 1.2.7 update and shows that current prose as well as equations can be versioned changes (notably the added remainder remark after 6.13.2).
- Chapter landings [4](https://dlmf.nist.gov/4), [5](https://dlmf.nist.gov/5), [6](https://dlmf.nist.gov/6), [7](https://dlmf.nist.gov/7), [8](https://dlmf.nist.gov/8), [9](https://dlmf.nist.gov/9), and [10](https://dlmf.nist.gov/10) confirm the titles and section ranges used by the discovery map.
- [§4.13](https://dlmf.nist.gov/4.13) confirms the plan's Lambert sentinels: branch notation `W_k`, legacy `Wp`/`Wm`, Wright omega, Tree `T`, mathematical prose, attached `Defines` metadata, and change annotations.
- [Sidebar 7.SB1](https://dlmf.nist.gov/7.SB1) is a concrete payload outside the ordinary numbered-section hierarchy and contains the mathematical intensity-distribution assertion described by the plan's sidebar safeguard.
- [§8.22](https://dlmf.nist.gov/8.22) confirms terminant, incomplete-zeta, and Debye-related prose; [§9.14](https://dlmf.nist.gov/9.14) confirms the internal-cross-reference definition plus external-reference leads distinction.
- [§10.43(iii)](https://dlmf.nist.gov/10.43#iii), [§10.47](https://dlmf.nist.gov/10.47), and [§10.61](https://dlmf.nist.gov/10.61) support the Bickley, spherical/modified-spherical, and Kelvin sentinels. Direct opens of `/10.61.i` and `/10.61.E1` redirected to `/10.61`, validating the candidate's locator-versus-payload warning.
- [§10.46](https://dlmf.nist.gov/10.46) is the decisive counterexample below: it prints definitions of the generalized Bessel/Wright and Mittag--Leffler functions but says only that the Laplace transform “can be expressed” in terms of the latter, with no transform variable, kernel, formula, or validity hypotheses.

## Findings

### G1 — P1 — The completion algebra has no faithful terminal state for a substantive source issue

**Files/clauses:** `blueprint/stage_1_dlmf-R6.md` §§3--4 and §7, especially lines 300--310, 333--340, 471--477, 493--526, and 835--856; preserved legacy `blueprint/qualitative/release_strategy.md` lines 192--214.

**Evidence.** R6 correctly distinguishes an `underspecified_mathematical_claim` from a `mathematical_reference_lead` and explicitly identifies the §10.46 Laplace-transform sentence as “substantive but underspecified,” says it “cannot disappear,” and says the cited incomplete-function literature does not silently import its paper. The official [§10.46 page](https://dlmf.nist.gov/10.46) confirms the problem: after defining `phi(rho,beta;z)`, it merely states that its Laplace transform can be expressed through `E_(a,b)` and then defines `E_(a,b)`; it supplies no exact transform proposition.

The only R6 resolution paths for an underspecified record are (a) create one or more real atomic targets at the same appearance or (b) decide that the complete payload is reference-only/nonmathematical (lines 471--477). Path (b) contradicts R6's own exact classification of this sentence as substantive mathematics that cannot disappear. Path (a) is unavailable when the source bytes do not determine the transform variable, integrand, scaling, formula, or domain: choosing those data would be mathematical reconstruction, not source-faithful atomicization.

There is then no third terminal state. `PartitionReady(S,B)` requires “no unresolved source claim” (lines 493--500), so `Target(S,B)` remains undefined. The Stage 1 completion table additionally requires no underspecified target, complete card/declaration coverage for every denominator member, one ordinary or paired quantitative mapping, reconciled coverage for every target, and zero unresolved dependencies (lines 835--856). This also loses the preserved legacy principle that a false or ambiguous printed assertion may terminate as a documented source issue rather than being silently repaired (`release_strategy.md` lines 192--214).

**Concrete failure case.** An exact-bound §10.46 reviewer refuses to infer an absent transform formula. Keeping the record provisional makes the local partition, global `B_all^r`, `Target(S)`, and Stage 1 completion impossible forever. Creating a guessed formula violates source fidelity. Reclassifying the prose as reference-only/nonmathematical violates the candidate's sentinel and its “all mathematical prose assertions” boundary. Every permitted branch is therefore either invalid or nonterminal.

**Bounded fix.** Add one reviewed terminal contract path for irreducibly ambiguous or false mathematical source assertions. It must preserve the source appearance/atom and exact bytes, distinguish `documented_source_issue` (or an equivalent immutable role) from reference-only/nonmathematical exclusion, forbid theorem or coverage credit, and expose the unresolved mathematical content in reporting. Then choose and state one of two coherent completion semantics:

1. Stage 1 may complete with a finite, separately counted source-issue set, matching the preserved legacy fidelity rule; update `PartitionReady`, `Target`, the §7 completion rows, and one negative/positive fixture accordingly; or
2. theorem-complete Stage 1 remains strict and source issues block it, but add a separately named “global audit closed with source issues” terminal milestone and state explicitly that §10.46 may end there without a fabricated target.

This is not a request for a particular YAML serialization, validator, census, card, proof, or Lean implementation. It is a missing semantic branch demonstrated by a current official source sentence and must be fixed at the plan/contract level before downstream schemas freeze.

**Blast radius and verification.** The repair is local to source-record roles, partition readiness, completion/reporting semantics, and fixtures. It need not weaken canonical payload ownership, quantitative-first duties for well-posed asymptotic atoms, card gates, or exact-head authority. Acceptance requires a dry-run of the §10.46 sentence showing that (i) it remains visibly mathematical, (ii) no theorem or coverage is fabricated, (iii) the audit denominator/report is defined under the chosen semantics, and (iv) theorem-completion status remains truthful.

**Confidence:** high.

## Areas found correct; do not refactor in response to G1

- **Programme boundary:** Chapters 4--10 are globally exhaustive at atomic mathematical-assertion granularity, while Chapters 1--3 and external/later material enter only through finite consumer-rooted support. The official chapter structure and the nonstandard 7.SB1 payload support this design.
- **Exact mathematics versus numerics:** exact definitions, identities, convergence, finite approximants, and bounds are in scope; numerical algorithms and software are out of scope while future verified numerics remains a downstream design consumer. DD-020 preserves useful exact constants/domains without imposing computability.
- **Canonical source identity:** payload-owning retrieval documents, request aliases, representations, appearances, shared context, repeated locations, current annotations, and cross-snapshot evolution are separated correctly. Keep `Target(S,B)` partial before review closure; do not replace undefined with zero.
- **Typed repair:** source-identity, same-appearance atomization, notation, entity, and association corrections are append-only, allocate fresh identities, preserve actual repeated locations, and pin exact decision views. Do not collapse these into one generic supersession relation.
- **Local/global authority:** finite local batches cannot claim a Stage 1 percentage; global closure requires an exhaustive `B_all^r`, two fresh reviewers, and external root selection. Suspension/withdrawal is conservative, exact-bound, non-fallback, and does not mutate historical sets.
- **Audit versus execution manifests:** a source-audit denominator and a finite Lean execution manifest are separate gates. Keep that separation and the ban on chapter wildcards in execution manifests.
- **Finite support closure:** the least transitive closure is finite, edge-complete, consumer-rooted, and topologically executable; optional unreachable cards are excluded, in-range reused targets are deduplicated without losing their independent target obligation, and pinned Mathlib reuse terminates at an exact reviewed interface rather than recensoring Mathlib.
- **Classification and placement:** ordinary exact/structural mathematics belongs in reusable semantic modules; genuine asymptotic/approximation atoms require a semantic finite producer plus faithful downstream recovery; source-specific restatements remain in `Audit/SourceRecovery`. Entity identification cannot earn theorem credit. Do not weaken the finite-plus-recovery pair while repairing G1.
- **Proof lifecycle:** new mathematics requires a complete natural-language proof and multiple fresh source/proof/architecture reviews before exact Lean signature design, followed by independent signature/card review and external `lean_ready`. This is correctly noncircular and blocks theorem-shaped hypotheses or choice laundering.
- **Named functions:** construction/continuation, conventional specification, regularity/uniqueness, branches/exceptions, and identification are kept upstream of asymptotics and recovery. The plan does not transfer Olver evidence or coverage into DLMF, or vice versa.
- **Coherent integration:** final authority binds one exact integration head, toolchain/Mathlib pins, global and local decision views, all required finite manifests, and a complete adverse/supersession/suspension fold. Historical verdicts cannot be transferred to a new head.
- **IMP lifecycle wording:** do not change the dependency graph merely because this documentation head preserves pending candidate-owned fields. The separately verified external envelope now accepts IMP at exact implementation head `b8d2f731fcfd5cd0889d0732f13699eb94681c86`; the graph's instruction to verify that exact external acceptance against the selected downstream dependency head is therefore correct, while its refusal to count old signature reviews as final-packet credit remains necessary.
- **Plan-only maturity:** the absence of future schemas, validators, census data, theorem cards, proofs, signatures, Lean code, or Verso implementation is not a finding. The proposal correctly states that none is authorized or already complete.

No reusable-extraction, local-proof, Mathlib-replacement, import-performance, or production-code finding is made in this documentation-only scope review.
