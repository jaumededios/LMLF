# Independent Stage 1 blueprint review — referee I

## Verdict

`request_changes`

The proposal is substantially stronger than an ordinary roadmap: it gives Chapters 4--10 an atomic, occurrence-based denominator; separates local audit closure from global closure; keeps source recovery downstream of reusable semantic mathematics; makes asymptotic and approximation claims carry a finite quantitative producer; preserves immutable source identities through typed corrections; and prevents Olver/DLMF credit transfer. The official DLMF discovery claims checked below are accurate.

Approval is nevertheless withheld because the completion predicate can currently aggregate implementation/status evidence that never coexists at one reviewed code head, and because the new DLMF target classes do not yet have a complete card-classification and support-closure contract. These are specification defects, not objections to missing census, schema code, theorem cards, Lean code, or a production build. No prior approval is transferred to these bytes.

## Review identity and isolation

| Field | Value |
|---|---|
| reviewer ID | `stage1_scope_referee_i` |
| review kind | independent agent blueprint/library-architecture review |
| model | `gpt-5.6-sol` |
| reasoning effort | `high` |
| runtime | OpenAI Codex desktop agent runtime on Linux `5.15.0-190-generic`, x86_64 |
| review completed | `2026-09-06T18:32:22Z` |
| isolation strength | `manual_attestation` |
| isolation method | fresh agent context and fresh detached Git worktree `/tmp/stage1-scope-referee-i.22lIZm/checkout` at the exact candidate commit |

This was not technically enforced clean-room isolation. The runtime had ordinary instructions, tools, network access, credentials/environment visibility, and writable filesystem access. I did not edit the candidate, change a pin, commit, push, invoke CI, delegate, or download a source file. I did not open any Stage 1 R1--R4 plan, predecessor/peer report or disposition, uncommitted work, IMP worktree, or Verso worktree. Repository worktree metadata was enumerated before the detached checkout was created; no other worktree content was inspected.

## Exact snapshot and reviewed artifacts

Detached `HEAD` and requested candidate were both:

`3bb4c48056332a7cd0cc87f240d012c415c6114d`

`git status --short --branch` returned only `## HEAD (no branch)`. The following six requested files were read in full, and their computed SHA-256 digests matched the supplied values:

| Artifact | SHA-256 |
|---|---|
| `README.md` | `84ca0315b6ce1f3d92d45666cdd83cf5580df7ebed0fd9c60929ede8fc93b5ce` |
| `blueprint/README.md` | `3459b27051fe365c09d0f5bc437a8f790bfe90ffcdf3ec2fe70648e9ba2b1386` |
| `blueprint/roadmap.md` | `a5e3263b16c5d0ab6650a928d1acf03e97acdfad824e0358ea59b09d04a8771c` |
| `blueprint/design_decisions.md` | `6aeac975c7f1bff56225c5046133c6af126f763ae19ad01643cae50e220dcecb` |
| `blueprint/source_manifest.md` | `e2f57c27f137e9fc0c74a9255aafbdb0cd81ee97bb29eeec4ad7c38e2e5b62de` |
| `blueprint/stage_1_dlmf-R5.md` | `51dc2f8789e72e2a627ce1d6ff7ec11b1ec403b248c139e04246175a09dc53b6` |

Applicable repository instructions: no `AGENTS.md` exists in the detached worktree. I read the complete `referee-lean-library` skill, its complete global rubric and research basis, and the applicable repository protocol/rubrics/status authorities: `review/README.md`, `review/PROTOCOL.md`, all five files under `review/rubrics/`, `blueprint/theorem_cards/README.md`, `review/classifications-v3.json`, the relevant legacy clauses in `blueprint/qualitative/release_strategy.md` and `blueprint/qualitative/navigation_and_docs.md`, and the current seven Lean source/root modules. I also consulted `blueprint/function_inventory.md` and the contract/testing documents for the relevant inventory, status, reviewer, and source-link semantics; I did not treat their planned serialization as a requirement on this plan.

## Findings

### G1 — P0 — Stage 1 completion is not bound to one coherent code/dependency state

**Evidence.** `blueprint/stage_1_dlmf-R5.md:689-701` defines completion by the union of cards across finite complete execution manifests and by per-card terminal states. Lines 703--707 then describe effective state as a join of immutable candidate artifacts and external records, but do not select one repository commit/tag, Lean toolchain, Mathlib commit, or one exact external decision view at which all required declarations and audit consumers coexist. The legacy release rule does bind an individual release to one code version, dependency version, manifest version, and documentation version (`blueprint/qualitative/release_strategy.md:29-42`), but the Stage 1 predicate can range over several manifests/releases and does not require their union to be present and passing together.

**Concrete failure mode.** Manifest A can retain an accepted implementation at commit X, a later commit can remove or incompatibly change A, and manifest B can be accepted at commit Y. The current predicate can still join A's historical external pass with B's pass even if no reviewed head contains both. The same defect permits incompatible Mathlib pins or a later accepted adverse verdict to coexist with an earlier pass without a selected status view. This can make the headline `Stage 1 complete` claim true without an integrated library that builds or exposes the claimed API.

**Bounded fix.** Add a Stage 1 completion/release authority record, external to the candidate, that selects:

- one exact integration commit/tag and one Lean/Mathlib dependency state;
- the exact global source-closure selection and exact revisions/digests of every contributing execution manifest;
- one versioned effective external-evidence view, including explicit supersession/suspension/withdrawal of card, proof, implementation, entity-identification, and coverage decisions; and
- passing semantic-root build, separately built audit consumers, declaration/occurrence joins, axiom/import audits, and required regressions at that integration head.

Earlier implementation reviews may be reused only through an explicit, reviewed declaration-byte/dependency-equivalence rule; otherwise revalidate them at the integration head. Do not transfer an approval merely because a card ID or theorem name is unchanged.

**Blast radius and order.** This changes only the completion/evidence contract and future validator fixtures: define the external record and effective-view fold first, then reference it from §7 and the Verso handoff. No census, theorem statement, or Lean edit is needed. Add negative fixtures in which (a) two individually complete manifests have no common code head, (b) their pins differ, and (c) a later accepted adverse record exists. Each must keep Stage 1 incomplete. **Confidence: high.**

### G2 — P1 — The retained card coverage vocabulary does not cover the new ordinary-source and finite-recovery cases

**Evidence.** R5 deliberately makes direct analyticity, monotonicity/sign, uniqueness/zero structure, and exact identities ordinary semantic source targets (`blueprint/stage_1_dlmf-R5.md:601-618`). It also requires a faithful recovery card for an explicit finite source estimate, where the recovery may be an identity, restatement, or specialization and must not invent a qualitative claim (`:584-590`). The current packet coverage vocabulary, however, gives:

- `entity_identification`, which earns no source-theorem credit;
- `exact_source_generic`, described around a theorem generic in source data such as Watson;
- `named_source_application`, described as a named estimate discharging generic hypotheses; and
- `audit_source_recovery`, defined as deriving an exact printed **qualitative** statement

(`blueprint/theorem_cards/README.md:28-47`, `review/classifications-v3.json:35-44,148-154`). It therefore has no unambiguous packet class for a named ordinary exact/structural source assertion, and its recovery definition conflicts with R5's required finite-source restatement case. Target-level `direct_source_target`/`named_source_target` values do not cure an undefined or misleading packet summary. R5 requires a reviewed multi-track migration, but does not state that the successor card vocabulary must close these two representability gaps; its non-transfer clause also correctly leaves existing classifications unchanged.

**Bounded fix.** Make the plan require a new, versioned classification authority for DLMF cards, leaving v3 and every artifact frozen under it byte-for-byte historical. The successor needs semantically total packet coverage roles for (a) ordinary exact/structural source targets, including named-function statements, and (b) faithful source recovery independent of whether the printed result is qualitative or already finite. One reasonable design is `ordinary_source_target` plus a broadened `faithful_source_recovery`; exact names are not material. Specify the mapping to the existing target-level roles and forbid use of `mixed` merely to hide a missing primitive value.

**Blast radius and verification.** This is a classification-contract amendment before any DLMF cards freeze. Add positive fixtures for a named exact identity, a direct analyticity theorem, and a finite printed error bound with a source-notation audit bridge; add negative fixtures rejecting `entity_identification` as theorem credit and rejecting a fabricated qualitative recovery. Existing Olver/v3 cards do not migrate automatically. **Confidence: high.**

### G3 — P1 — Selective Chapters 1--3 and other support do not have a defined, auditable closure universe

**Evidence.** The source target set explicitly filters to Chapters 4--10 (`blueprint/stage_1_dlmf-R5.md:439-452`). Section 6 says each prerequisite maps to a support card or pinned reuse, but gives the explicit source-support-node rule only for Chapter 11 or later (`:632-644`). The completion row names later-chapter and external-source support nodes, not Chapters 1--3 (`:701`). Terms such as “every required support card” and “explicit support closure” (`:689-701,848-851`) are consequently quantified over a self-declared set: the plan gives no root-and-edge construction by which an omitted direct or indirect Chapter 1--3 dependency becomes detectably required. Nor does §5's total finite-quantitative/ordinary classification explicitly range over source-support atoms outside `Target(S,B)`.

**Concrete failure mode.** A target card can depend mathematically on a Chapter 2 asymptotic assertion through an intermediate entity or method card, omit the source-support node, and still satisfy the literal target-set equality because Chapter 2 atoms are outside `Target(S)`. This undermines the user-authorized “selective infrastructure” boundary and can also route an asymptotic support assertion around the quantitative-first classification.

**Bounded fix.** Define a finite `Support(S,M)` (or equivalent) for each execution manifest as the least reviewed transitive closure of dependency edges rooted at its selected target cards and required entity identifications. Every DLMF Chapter 1--3 or post-10 source assertion in that closure must have an exact-bound source-support atom/card, locator, inclusion reason, named consumers, classification, and terminal discharge while earning zero Chapters 4--10 target credit. Pinned Mathlib reuse and genuinely source-independent new mathematics remain distinct support kinds. Stage 1 completion should quantify over the deduplicated union of these selected support closures and reject undeclared proof, import, entity, or recovery dependencies.

**Blast radius and verification.** This adds a semantic set and completion join, not a full Chapter 1--3 census. Add negative fixtures for a missing indirect Chapter 2 dependency, an unused support card presented as required, and an asymptotic source support mislabeled ordinary. **Confidence: high.**

### G4 — P1 — Entity and notation identities have no repair lineage or defined effect on accepted claims

**Evidence.** R5 gives precise append-only split/merge/coalescence semantics for retrieval documents, source appearances, and atoms (`blueprint/stage_1_dlmf-R5.md:354-405`) and allocates opaque never-reused notation and entity IDs (`:646-649`). It requires complete branch, alias, normalization, and accepted-object identification (`:529-540,693`). But it defines no corresponding correction relation for a mistaken entity or notation partition. This is not hypothetical: the Lambert sentinel intentionally leaves `Wp`/`Wm` branch-side identity and the distinction among `W_k`, Wright omega, and Tree `T` to source/entity review (`:252-268`). A later discovery that one entity ID conflated two branch conventions, or that two IDs were aliases, currently has no specified immutable split/merge path, occurrence-link migration, or deterministic invalidation of the affected identification and coverage evidence.

**Bounded fix.** Add typed append-only entity-identity and notation-identity correction relations. Corrections must mint fresh successor IDs; permit reviewed one-to-many/many-to-one repair where mathematically justified; preserve old records; map occurrence associations and normalization/branch evidence explicitly; and invalidate or suspend affected entity-identification, theorem-card, implementation, recovery, and coverage authorities until exact successor reviews pass. Pin the effective entity/notation correction view in audit and execution manifests. Such a repair must not change the source-atom denominator unless a separate source-identity/atomization correction justifies that change.

**Blast radius and verification.** This extends the future lineage contract and Verso inputs. Add fixtures for a split caused by different branch-side boundary values, an alias merge with value-preserving conversion, an attempted in-place entity rebind, and an entity correction that incorrectly leaves old named coverage current. **Confidence: high.**

### G5 — P2 — The scope of DLMF annotations and erratum/change-note mathematics is not decided

**Evidence.** The stated boundary is every mathematical website assertion, including prose. R5 enumerates source-owning formula/prose/table/caption/figure/application/computation/software/reference blocks (`blueprint/stage_1_dlmf-R5.md:290-320`) and records that the errata page was consulted for discovery (`:184-191`), but it never states whether attached `ⓘ` annotations, editor notes, addition/rearrangement notes, or historical errata are part of the selected Chapter 4--10 payload or provenance only. This matters in the live source: the official [§4.13 page](https://dlmf.nist.gov/4.13) exposes Annotate/UnAnnotate views and includes a mathematical radius-of-convergence note plus added/rearranged equations, while the [Chapter 7 landing page](https://dlmf.nist.gov/7) links an erratum and the standalone [7.SB1](https://dlmf.nist.gov/7.SB1) carries a mathematical caption. Treating customization variants as mere representations does not itself decide which of these semantics belongs to snapshot 1.2.7.

**Bounded fix.** Add an explicit source-layer rule: current attached annotations containing mathematics are either source-owning leaves in the selected snapshot or explicitly excluded with a reviewed rationale consistent with “every website assertion”; historical errata/change history should be provenance unless the plan intentionally makes them target occurrences. Bind annotated/unannotated representation reconciliation and add a sentinel whose mathematical assertion appears only in an annotation. **Confidence: medium-high.**

## Confirmed design decisions and explicit do-not-refactor conclusions

- Keep the batch-local `Target(S,B)` partial and distinct from a separately reviewed and externally selected global `Target(S)`. The no-fallback withdrawal rule is sound.
- Keep the atomic denominator based on effective occurrence IDs, not pages, entities, declarations, cards, or association rows. Shared context and genuine repeated appearances are handled correctly.
- Keep the two-role requirement for genuine asymptotic/approximation atoms. A qualitative-only proof, assumed majorant, or invented recovery must not satisfy it.
- Keep ordinary reusable analyticity, continuation, monotonicity/sign, uniqueness, zero structure, and exact identities in semantic modules; keep source-notation restatements and faithful recovery in the downstream audit layer. The dependency direction is correct.
- Keep the explicit branch, exceptional-value, normalization, domain-reachability, majorant-nonnegativity, fixed-target-across-orders, and hypothesis/choice-laundering controls.
- Keep the DLMF/Olver programme and coverage ledgers nontransferable. The subject-limited DD-021 amendment and Olver-track-local reinterpretation are adequate.
- Keep natural-language proof and multiple independent reviews before exact Lean signature design for new mathematics. No blueprint defect requires relaxing that gate.
- Keep numerical evaluation, interval arithmetic, adaptive procedures, solvers, and performance models out of Stage 1. Treating a future verified numerical library only as a downstream design consumer is coherent.
- Keep Verso a read-only projection. Once G1 and G4 are repaired, it should consume the selected effective authority view explicitly rather than infer “current” from a latest timestamp.
- No reusable Lean extraction, module deletion, compatibility cleanup, performance claim, or local-proof handoff is justified by this documentation-only change. The current semantic/audit import split matches the written architecture.

## Official-source checks

All web checks used official NIST DLMF pages. They confirmed:

- [DLMF root](https://dlmf.nist.gov/) and [Project News](https://dlmf.nist.gov/about/news/) report version 1.2.7, released 2026-06-15; [Errata](https://dlmf.nist.gov/errata/) is a separate versioned correction/history surface.
- Official chapter landing pages [4](https://dlmf.nist.gov/4), [5](https://dlmf.nist.gov/5), [6](https://dlmf.nist.gov/6), [7](https://dlmf.nist.gov/7), [8](https://dlmf.nist.gov/8), [9](https://dlmf.nist.gov/9), and [10](https://dlmf.nist.gov/10) support the stated chapter titles, terminal computation/approximation/software sections, and broad section ranges.
- [§4.13](https://dlmf.nist.gov/4.13) confirms `W_k`, legacy `Wp`/`Wm`, Wright omega, and Tree `T`; the plan is right not to collapse them before entity/branch review.
- [7.SB1](https://dlmf.nist.gov/7.SB1) is a genuinely served standalone sidebar with a mathematical caption, validating the nonnumeric-document sentinel.
- [§9.12](https://dlmf.nist.gov/9.12), [§9.13](https://dlmf.nist.gov/9.13), and [§9.14](https://dlmf.nist.gov/9.14) confirm Scorer, generalized Airy, and the terse incomplete-Airy/reference-lead cases.
- [§10.46](https://dlmf.nist.gov/10.46) confirms the generalized Bessel function, the explicit Mittag--Leffler definition, the underspecified Laplace-transform prose, and the separate external reference for incomplete modified Bessel/Hankel functions. Keeping the Laplace claim unresolved rather than inventing a target is correct.
- [§10.47](https://dlmf.nist.gov/10.47) and [§10.61](https://dlmf.nist.gov/10.61) confirm spherical/modified spherical and Kelvin families. Requests for `/10.61.i` and `/10.61.E1` both resolved to the full `/10.61` document, supporting the locator-alias negative fixture.

No contrary discovery fact was found.

## Commands and checks actually run

- `git rev-parse --show-toplevel`, `git status --short --branch`, `git worktree list --porcelain`, `git log -5 --oneline --decorate --no-renames`, and `git rev-parse HEAD`.
- `mktemp -d /tmp/stage1-scope-referee-i.XXXXXX` followed by `git worktree add --detach ... 3bb4c48056332a7cd0cc87f240d012c415c6114d`.
- `find ... -name AGENTS.md -print` (no result).
- `/home/codex/.codex/skills/referee-lean-library/scripts/library_inventory.sh <detached-worktree>`.
- `sha256sum` and `wc -l` over the six reviewed artifacts.
- `nl -ba` and bounded `sed -n` reads covering every line of all six artifacts and the protocol/rubric/status/supporting files named above; `rg -n` cross-checks for completion commits, effective state, support closure, correction/lineage, withdrawal, annotations, and legacy stage clauses.
- `python3 scripts/validate_inventory.py --negative-tests`: passed; 25 intentionally invalid copied fixtures were rejected, and the baseline inventory reported 148 occurrences, 31 notations, 32 entities, 34 entity-evidence rows, and 88 occurrence associations.
- Read-only official-page opens/finds for the DLMF sources listed above. No page or artifact was saved locally.

No production build was run: the candidate is a six-file documentation plan, the task explicitly does not submit Lean or schema implementation, and the existing local inventory validator plus its negative fixtures were the proportionate executable check.
