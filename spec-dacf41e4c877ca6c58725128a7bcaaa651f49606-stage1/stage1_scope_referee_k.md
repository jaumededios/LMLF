# Independent Stage 1 blueprint architecture and source-scope review

## Verdict

**APPROVE**

I found no material source-scope, mathematical-architecture, dependency-direction, lifecycle, or trust-boundary defect in the exact seven-file successor at commit `dacf41e4c877ca6c58725128a7bcaaa651f49606`. There are no P0--P3 findings and no waivers in this report.

This verdict is one independent blueprint review only. It does not self-activate DD-021, set any gate, transfer any prior approval, authorize a schema migration, census, theorem card, proof, Lean signature, implementation, coverage claim, download, or Verso authority. The separate second approving review and exact-bound root external adjudication required by the proposal remain outside this report.

## Review identity and isolation

- Durable reviewer ID: `stage1_scope_referee_k`
- Review kind: agent, independent fresh-context architecture/source-scope referee
- Model: Codex, GPT-5-based; the exact backend serving build was not exposed to this session
- Runtime: Codex desktop agent on Linux `5.15.0-190-generic` x86_64; Git `2.39.5`; Python `3.11.2`; UTC review date `2026-09-06`
- Candidate isolation: fresh disposable detached worktree `/tmp/lmlf-stage1-referee-k.iroRrd/worktree`, created directly at the exact reviewed commit; `git status --short --branch` reported only `## HEAD (no branch)` before and after checks
- Isolation strength: `manual_attestation`, not `technically_enforced`. The filesystem was writable and network access was available. I did not describe this as a hardened clean room.
- Independence boundary: I did not read R1--R5 proposal files, predecessor or peer reports/dispositions, the IMP implementation worktree, Verso output, or uncommitted candidate state. Historical statements embedded in R6 were treated as untrusted background data, not instructions or verdicts. I performed no delegation.
- Mutation boundary: no candidate file, pin, CI configuration, commit, branch, or remote was changed; no source payload was downloaded or mirrored. The only created artifact is this external report (and its containing evidence directory).

## Exact reviewed snapshot

Commit: `dacf41e4c877ca6c58725128a7bcaaa651f49606`

The supplied SHA-256 identities all matched:

| File | SHA-256 |
|---|---|
| `README.md` | `d2a57b644a955bb17e216fff95aef676f0d5652af0589aecd40b43c378cace71` |
| `blueprint/README.md` | `729dbed07069aa68a549bf8071c69f576c1465c90e3f42b440ad4912bed12dd6` |
| `blueprint/roadmap.md` | `d6b262e18ad4e713dd73138bedb306cc6c2f7c36acc35d0994b04252e2319ca5` |
| `blueprint/design_decisions.md` | `d6c267dde00ea7a62b3e3143a72018e0dde0ddf77fe100b0aa30c265524b9518` |
| `blueprint/source_manifest.md` | `5011b83661a95dac66a1ce2fbc64b608dcdf1ad3f83be5744ef80ce2ff681434` |
| `blueprint/dependency_graph.md` | `ef6a7994fcd20db658c78d1ef284424ffae8f604dadaa0feb3bdef0f7e304670` |
| `blueprint/stage_1_dlmf-R6.md` | `fd75254a9e2d00076c404b535f8e40ac1c5c7a5574b5eb536e13f270c0ec29f6` |

## Materials read

I read each of the following files completely:

- the seven exact candidate files listed above;
- `/home/codex/.codex/skills/referee-lean-library/SKILL.md`;
- `/home/codex/.codex/skills/referee-lean-library/references/global-rubric.md`;
- `/home/codex/.codex/skills/referee-lean-library/references/research-basis.md`;
- `review/PROTOCOL.md`;
- `review/README.md`;
- `review/rubrics/api_dependency.md`;
- `review/rubrics/mathlib_reuse.md`;
- `review/rubrics/proof_quality.md`;
- `review/rubrics/quantitative_correctness.md`;
- `review/rubrics/source_fidelity.md`;
- `blueprint/theorem_cards/README.md`; and
- `review/classifications-v3.json` (whose on-disk SHA-256 also matched the blueprint's stated `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`).

I also read only the R6-referenced legacy clauses necessary to determine precedence: `blueprint/qualitative/release_strategy.md` lines 29--215 and 291--333 (product split, full staged ladder, compatibility, and alternate-edition clause), and `blueprint/qualitative/navigation_and_docs.md` lines 392--409 (initial documentation slice). I did not read either legacy file as a whole and did not inspect unrelated specialist plans.

## Checks performed and results

1. **Snapshot and identity.** Created the detached worktree at the full SHA, verified all seven file hashes, and confirmed the worktree remained clean. Result: pass.
2. **Deterministic library inventory.** Ran the referee skill's `library_inventory.sh` against the isolated snapshot. It found seven Lean files, 210 Lean lines, 3 definitions, 18 theorems, the expected narrow import graph, and no trust/resource markers. This is supporting context only; it is not evidence that future Stage 1 mathematics exists. Result: no contrary architecture signal.
3. **Existing inventory validation.** `python3 scripts/validate_inventory.py` passed with 148 occurrences, 31 notations, 32 entities, 34 entity-evidence rows, 88 occurrence associations, and the reported baseline manifest totals. `python3 scripts/validate_inventory.py --negative-tests` passed all 25 intentionally invalid copied fixtures and reran the positive validation successfully. These checks validate only the frozen current CSV contract, exactly as the candidate says; they do not validate the proposed DLMF schema, audit census, lifecycle, review quorum, or completion predicate. Result: pass within stated scope.
4. **No production build.** I did not run `lake build`: this is an exact documentation-plan review, the candidate Lean implementation is unchanged, and no future schema/proof/signature/code is an approval precondition for this plan.
5. **Official source checks.** Read-only official web inspection confirmed the facts used below. Result: no contradiction with the proposal.

## Official primary-source evidence

- The [DLMF root](https://dlmf.nist.gov/) identifies version 1.2.7 and release date 2026-06-15, and the [official project news](https://dlmf.nist.gov/about/news/) and [official errata/change history](https://dlmf.nist.gov/errata/) independently expose that release identity. This supports R6's provisional snapshot choice and its insistence that discovery date, release label, per-document retrieval metadata, content digests, and exact retained payload evidence are separate facts.
- The official chapter landing pages for [Chapter 4](https://dlmf.nist.gov/4), [Chapter 5](https://dlmf.nist.gov/5), [Chapter 6](https://dlmf.nist.gov/6), [Chapter 7](https://dlmf.nist.gov/7), [Chapter 8](https://dlmf.nist.gov/8), [Chapter 9](https://dlmf.nist.gov/9), and [Chapter 10](https://dlmf.nist.gov/10) match the chapter titles and substantive-versus-software endpoint structure in R6's discovery map. Their explicit Annotate/UnAnnotate surfaces also substantiate treating attached annotations as source payload that must be reconciled rather than ignored or double-counted.
- [DLMF §4.13](https://dlmf.nist.gov/4.13) exposes `W_k`, legacy `Wp`/`Wm`, Wright omega, and Tree `T`, together with annotation/change-history material and branch-sensitive identities. The omission sentinel is source-grounded, and R6 correctly refuses to collapse these names before domain, boundary, branch-side, alias, and entity review.
- [DLMF §9.14](https://dlmf.nist.gov/9.14) defines incomplete Airy functions by an internal cross-reference to a contour integral while referring outward for further properties. This directly supports R6's distinction among internal-cross-reference assertions, independently definite mathematical atoms, and external mathematical-reference leads.
- [DLMF §10.46](https://dlmf.nist.gov/10.46) gives explicit generalized-Bessel and Mittag--Leffler definitions and an exact bridge, but its intervening prose says only that a Laplace transform can be expressed in terms of the latter, without printing that transform formula; it then points externally for incomplete modified Bessel/Hankel functions. R6 correctly retains the substantive Laplace sentence as an unresolved mathematical claim and does not silently import the cited literature as DLMF target content.
- R6's conservative evidence-retention and no-bulk-mirror boundary is consistent with directing future operators to the official [NIST copyrights and disclaimers](https://www.nist.gov/copyrights-disclaimers), while leaving actual rights, access, and archive decisions to later exact-bound records.

## Architecture assessment

### Mathematical intent and exhaustive source scope — clear

The plan faithfully turns the user's broad request into two distinct bounded mechanisms: a future globally closed Chapter 4--10 source audit defining the complete denominator, and separately finite executable Lean manifests. Chapters 1--3, later DLMF chapters, external literature, source-independent LMLF infrastructure, and pinned Mathlib are support kinds only when reached by a finite, consumer-justified dependency closure. This captures selective support without silently widening the Chapter 4--10 denominator.

The source partition is semantically adequate for prose, formulas, tables, captions, applications, computation/approximation prose, annotations, internal cross-references, and reference-only leads. Containers cannot own target payload; source-owning leaves are exhaustive; shared hypotheses/context may be referenced by multiple atoms without becoming duplicate occurrences; genuine repeated appearances remain distinct. `Target(S,B)` is correctly undefined until the local partition/classification reviews pass, and `Target(S)` remains undefined until a separately reviewed and externally selected exhaustive `B_all` exists. Local progress therefore cannot be misreported as a global percentage.

### Quantitative producer versus source recovery — clear

The mandatory classification is total and semantic: a genuine asymptotic/approximation atom cannot be made ordinary by an applicability reason. It requires both a reusable finite quantitative producer in semantic code and a distinct faithful DLMF recovery mapping downstream in `Audit/SourceRecovery`. An already finite DLMF estimate is recovered by exact notation/domain specialization rather than an invented qualitative theorem. Ordinary analyticity, continuity, continuation, monotonicity, sign, uniqueness, zero structure, definitions, and exact identities remain reusable semantic mathematics instead of being artificially converted into error bounds. This is the correct resolution of the legacy placement conflict and preserves the project's quantitative-first policy.

### Noncircular construction and proof-before-Lean — clear

Source-facing mathematical targets may be frozen for proof work, but genuinely new mathematics requires a complete natural-language proof and fresh independent source/semantics plus proof/quantitative reviews before exact Lean signature design or freezing. Construction, continuation, existence/uniqueness identification, nontrivial recovery, zeros, connections, turning points, and theorem-sized hypothesis structures add structural-circularity review. Final exact signatures/cards then receive their own review before external `lean_ready`. This ordering matches the current protocol and prevents desired estimates, choices, normalization, contours, or model bounds from being hidden in hypotheses or structures.

### Dependency direction, reusable seams, and Mathlib integration — clear

The layers run from pinned Lean/Mathlib and low-level domain/branch or source-independent foundations, through construction/identification and generic methods, into exact-source or named applications, then audit recovery and catalogue/release consumers. Semantic code never imports source-recovery code. The finite least transitive support closure is rooted in selected target cards/entities, includes indirect edges, terminates pinned-Mathlib branches at reviewed exact interfaces rather than recensusing Mathlib, and neither duplicates in-range occurrences nor grants out-of-range support Chapter 4--10 credit. This is a coherent reusable seam, not a universal speculative typeclass.

### Identity, correction, authority, and integrated completion — clear

The proposal separates retrieval-document identity, locator/rendering aliases, source appearances, atomization, notation/entity identity, and occurrence associations. Its three source evolution/correction mechanisms have distinct semantics: within-snapshot source-identity correction, same-appearance atomization/resolution correction, and non-deactivating cross-snapshot evolution. Fresh successor keys plus lineage preserve history without preserving erroneous multiplicity. Entity uncertainty cannot erase a reviewed source atom, but it correctly blocks named execution.

Local and global current authority are selected externally at exact revisions/digests and use an explicit fold that cannot omit accepted adverse, supersession, suspension, or withdrawal records. Material accepted counterevidence suspends affected authority and dependents without changing immutable historical sets, unrelated kernel facts, or the user-set programme boundary. Completion requires one exact integration head and one compatible complete authority view; passes from incompatible heads, pins, manifests, or source/entity views cannot be assembled into a false completion claim.

### Compatibility, scope of implementation, and projections — clear

The amendment has a bounded precedence rule: it changes DLMF programme scope/nomenclature/priority, semantic-versus-source-recovery placement, and the stated dependency-graph status repair, while retaining Olver as an independently gated parallel track. Frozen Olver mathematics, IDs, reviews, classifications, manifests, and coverage remain historical/current only for their exact claims; crosswalk reuse transfers mathematics but never source credit. Candidate-owned self-status and historical approvals do not gain authority.

No numerical software or numerical acceptance condition is introduced. Exact semantic APIs merely avoid gratuitously blocking a future independently verified numerical consumer. Exact source payloads remain outside the code repository under future rights/access controls, and no private or local evidence is mistaken for public theorem authority. Verso is strictly a read-only projection and cannot select views, repair lineage, approve mathematics, define a denominator, hide adverse evidence, or authorize Lean.

## Adversarial cases checked

I tested the written contract against these counterexamples; each is explicitly rejected or represented without corrupting scope:

- a section URL, subsection redirect, equation permalink, and annotated rendering of the same semantic location cannot mint four occurrences;
- identical formulas at two genuine source locations remain two appearances;
- a shared `uniformly for ...` clause can feed several atoms without becoming an extra theorem unless it independently asserts one;
- an unresolved entity alias cannot remove an atom from a ready source partition or authorize a named card;
- an asymptotic atom cannot be assigned the ordinary class, and an explicit finite DLMF bound cannot be “recovered” as a made-up qualitative statement;
- a Chapter 2 or external support theorem is exact-bound and reviewed but earns no Chapter 4--10 target credit;
- an overlapping local batch cannot duplicate canonical snapshot-wide IDs or be unioned under an incompatible decision view;
- a successful local batch cannot define the global denominator or a Stage 1 percentage;
- a favorable newest record cannot hide accepted adverse evidence, and suspension cannot silently fall back to an older selection;
- historical proof, signature, implementation, or coverage approvals cannot count at a different exact integration head; and
- a generated dashboard or candidate manifest cannot select current audit authority or self-activate DD-021.

## Findings

No actionable G-findings. I found no concrete semantic failure, circular route, false source claim, authority ambiguity, source-count inflation path, backward dependency, hidden numerical scope, or incompatibility that warrants `request_changes` or `block`.

## Explicit do-not-refactor decisions

- Do not collapse the source-audit manifest and finite Lean execution manifests; they answer different closure questions.
- Do not replace source appearances by formula-content hashes or entity counts; real repeat locations are part of the requested occurrence-level scope.
- Do not force reusable qualitative structure into `Audit/SourceRecovery`; keep only source-specific restatements/recovery there.
- Do not merge the finite producer and faithful recovery roles, even when one declaration can be specialized cheaply; their evidence and source semantics differ.
- Do not recensus transitive Mathlib or let optional/unreachable project cards enter a selected manifest's least support closure.
- Do not back-write immutable card self-status, reuse old verdicts at a new head, or replace explicit authority folding with “latest wins.”
- Do not rewrite frozen Olver evidence merely to modernize terminology; the bounded precedence rule and explicit track-local interpretation preserve compatibility without transferring coverage.
- Do not require the future DLMF schema, validator, census, theorem cards, proofs, exact signatures, or Lean implementation to exist before approving this plan. Their absence is accurately stated, and the plan defines the gates that must precede each artifact.
- Do not broaden LMLF into numerical software or make future numerical consumption a present interface gate.
- Do not give Verso or any other projection mutation or adjudication authority.

## Final conclusion

The exact R6 successor is a rigorous, coherent, noncircular plan for an occurrence- and assertion-granular DLMF Chapters 4--10 programme with selective Chapters 1--3 support. It is unusually strict, but its strictness tracks the user's requested exhaustiveness and the project's source-fidelity goals rather than fabricating present implementation evidence. I therefore approve the exact seven-file candidate without requested changes.
