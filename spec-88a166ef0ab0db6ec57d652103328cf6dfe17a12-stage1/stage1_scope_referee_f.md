# Stage 1 DLMF R3 blueprint review — referee F

## Final disposition

- **Verdict:** `approve`
- **Material findings:** none
- **Review state:** `finalized`
- **Reviewed commit:** `88a166ef0ab0db6ec57d652103328cf6dfe17a12`
- **Reviewer ID:** `stage1_scope_referee_f`
- **Reviewer kind:** `agent`
- **Actual model:** `gpt-5.6-sol`
- **Reasoning effort:** `high`
- **Review time (UTC):** `2026-09-06`
- **Isolation strength:** `manual_attestation`

This is one fresh independent blueprint approval, not the root external
adjudication and not a claim that DD-021 revision 2 is already effective. The
five-file successor still requires the other exact-byte approval and a root
external acceptance record satisfying the proposal's own effective rule.

## Exact review identity

The five normative inputs were read in full from a clean detached worktree at
the reviewed commit. Their SHA-256 digests are:

| Artifact | SHA-256 |
|---|---|
| `blueprint/stage_1_dlmf-R3.md` | `764c5d01707e6c0ed1e10b318a7d8891ce1bb24d00f556faa4cc26dab65a0dd0` |
| `blueprint/README.md` | `e98e8f69ac08462e18c29f305c4868d2db3581b3b690508e49a1993bf82a728a` |
| `blueprint/roadmap.md` | `144ec070b30c3ac0ae6e0bf482a29d73336beaf832b14e76b67f7bd38c80d9ce` |
| `blueprint/design_decisions.md` | `e5a014ec20fdba9d6cc1ad1919bcb9f4f1067803892fcfa9201f93c04189abfe` |
| `blueprint/source_manifest.md` | `140652cae9cf5a632cbd4f86eed175b791661e28e960956227e9bf5ef28825a9` |

The detached checkout was
`/tmp/lmlf-stage1-referee-f-6EAC2i`; `git status --short --branch` returned only
`## HEAD (no branch)`, and `git rev-parse HEAD` returned the full reviewed SHA.
No `AGENTS.md` was present under the repository or its dated workspace parent.

## Independence attestation

I reviewed in a fresh agent context and a newly created detached checkout. I did
not read the R1 or R2 proposal files, peer reviews, predecessor reports,
predecessor findings, the Verso worktree/content, or any uncommitted candidate
work. I did not receive another referee's conclusion. I made no candidate edit,
schema or census artifact, validator or CI change, Lean implementation, commit,
push, or delegation. The only authored artifact is this external report.

This is a manual attestation, not technically enforced isolation. The runtime
still had ordinary filesystem, tool, credential, and network capabilities; I do
not claim a hardened clean-room boundary.

## Scope and source checks

I reviewed the complete five-file normative plan and, where needed, the existing
status/review/source framework: `blueprint/theorem_cards/README.md`,
`blueprint/function_inventory.md`, `review/README.md`, and
`review/PROTOCOL.md`. I also read the complete `referee-lean-library` skill,
global rubric, and workflow research basis and ran its deterministic inventory
script. The inventory found seven Lean files, 210 lines, three definitions and
eighteen theorems; this confirms that the present question is the normative
programme design, not implemented DLMF coverage.

I made limited live checks against official DLMF pages, not a census. On
2026-09-06 the root and project-news pages reported version 1.2.7 with release
date 2026-06-15. The official chapter pages confirmed the Chapter 4--10 titles,
terminal linked sections 4.48, 5.24, 6.21, 7.25, 8.28, 9.20 and 10.77, and that
those terminal sections are software sections. Official section pages also
confirmed the omission-sensitive leads at 4.13, 5.17, 5.18, 9.12, 9.14, 10.46,
10.47 and 10.61. In particular, §4.13 exposes the branch notation plus `Wp`,
`Wm`, Wright omega and Tree T; §9.14 defines incomplete Airy functions through
an internal contour-integral cross-reference and then gives external literature
leads; and §10.46 contains generalized Bessel/Mittag-Leffler mathematics, a
substantive Laplace-transform sentence, and a separate incomplete-function
reference lead. These checks support the proposal's discovery map and its
formula/prose/reference-role distinctions.

## Normative-plan audit

### Mathematical intent and exact scope — clear

The proposal states the requested boundary without claiming premature closure:
all mathematical assertions in the selected DLMF snapshot's Chapters 4--10,
including formulas and mathematical prose in tables, captions, application and
computation areas, while Chapters 1--3, later chapters and other sources are
finite consumer-justified support only (`stage_1_dlmf-R3.md:74-106`). It keeps
exact definitions, identities, convergence statements, finite approximants and
error bounds in scope while excluding numerical evaluator/software development.
The software/metadata rule still extracts any mathematics embedded in that
material. This matches the quantitative-first exact-mathematics objective and
does not silently turn it into a numerical implementation programme.

The chapter/function table is explicitly a discovery checklist rather than a
denominator (`:138-160`), and the hidden-family sentinels make representative
omissions difficult without pretending to be a completed function census
(`:162-196`). Present truth expressly denies a census, denominator, counts,
schema migration, card/proof set, authorization, implementation or percentage
(`:644-657`).

### Source partition, fidelity and source-to-target closure — clear

The plan distinguishes navigation containers from exclusive source-owning
leaves and forbids containers from entering the denominator (`:198-228`). Each
mathematical or mixed leaf needs an exact-bound, independently reviewed semantic
decomposition covering all and only its mathematical assertions, with explicit
reconciliation of the remainder (`:230-235`). The four fidelity roles separate
self-contained assertions, exact internal-cross-reference assertions,
underspecified claims and external mathematical reference leads (`:209-218`).
Only the first two successfully resolved roles enter `Target(S,B)`; the others
remain visible and separately reconciled rather than disappearing (`:298-323`).

The treatment of shared hypotheses is correct. Shared exact-bound context may be
referenced by multiple atoms without either duplicating semantic ownership or
requiring artificial disjoint source spans; it becomes its own occurrence only
if independently reviewed as a separate assertion (`:221-235`, negative fixture
at `:526`). This avoids both parent/child double counting and loss of uniformity,
domain or branch clauses shared across nearby formulas.

The closure equation is precise at the plan level. A reviewed global `B_all`
must exhaust canonical Chapter 4--10 URLs/leaves without gaps or duplicate
ownership; only then is `Target(S) = Target(S,B_all)` defined (`:332-347`). The
completion predicate additionally requires the deduplicated union of target-role
card mappings to equal `Target(S)`, with no missing/extra claim and no target or
support orphan (`:482-504`). Support-only associations earn no source credit.
The negative fixtures exercise the important ways these equalities can fail.

### Local audit batches versus the global denominator — clear

`PartitionReady(S,B)` requires a finite explicit exact-bound source-audit batch,
successful scope closure, complete approving partition/atomicization/role/
exclusion/resolution review, and valid lineage (`:283-315`). Its target value is
undefined rather than empty until that gate passes. Overlapping local batches
reuse snapshot-wide appearance and atom IDs (`:325-330`). Local reviewed batches
may feed separately closed Lean execution manifests, but neither those batches
nor their counts define a Stage 1 percentage before `B_all` (`:332-347`). The
audit protocol and negative fixtures restate this distinction, so incremental
work cannot be advertised as global completion.

### Stable identity and append-only lineage — clear

Every source appearance/atom has one immutable ownership key
`(snapshot_id, source_appearance_id, atom_ordinal)`; repeat appearances remain
distinct while duplicate IDs for one key are forbidden (`:237-247`). Record
kinds remain immutable and corrections use append-only decisions and lineage.
Split/merge successors must exactly preserve semantic ownership without gaps or
duplication, and zero-successor transitions require an exact reviewed removal or
exclusion accounting (`:255-281`). Snapshot replacement is also append-only and
does not silently assign changed bytes to 1.2.7 (`:117-125`). The fixture
correctly keeps provisional history inactive beside a created target successor
and deduplicates many-to-many card associations (`:544-585`).

### Non-waivable quantitative architecture and recovery — clear

Every target has exactly one active, externally source-reviewed classification.
A genuine asymptotic or approximation claim must be
`finite_quantitative_plus_source_recovery`; a written reason under the ordinary
class cannot waive semantic applicability (`:362-382`). Every quantitative
target has exactly one designated mapping for each of two distinct obligations:
the finite semantic result and faithful recovery of the printed DLMF assertion,
both with exact-bound accepted card/declaration/evidence (`:384-410`). The
recovery imports the semantic result from `Audit/SourceRecovery`, never the
reverse. A qualitative-only proof, finite result without recovery, or recovery
without the finite result remains incomplete; absent source bounds require new
mathematics and may not be laundered through a chosen/assumed majorant
(`:412-424`). The completion table and negative fixtures make this classification
totality and two-role mapping enforceable as a normative requirement.

### Proof-before-code and effective completion authority — clear

References to accepted declarations and identifications are explicitly terminal
completion obligations, not census prerequisites or evidence that code already
exists (`:426-434`). New mathematics still requires a complete natural-language
proof and independent source/semantics plus proof/quantitative review before
signature design, with structural-circularity review for the enumerated risky
classes, and external `lean_ready: pass` before exact-packet implementation
(`:587-621`; reinforced by the existing roadmap and review protocol). This
avoids circular acceptance based on prototype or compiled code.

Stage 1 completion requires successful effective terminal states on every
source, partition, denominator, card mapping, classification, entity,
specification, proof, review, authorization, implementation, coverage, manifest
and dependency axis (`:482-510`). Candidate self-status cannot establish a pass;
effective truth is reconstructed only from exact-bound external authority.
Compiled/prototype states, failed or changes-requested verdicts, blocked support,
or merely closed/execution-ready manifests are nonterminal (`:512-542`). The
existing protocol supplies distinct reviewer identities, structural quorum and
exact-artifact invalidation semantics; the R3 plan incorporates those project-
wide controls rather than inventing a weaker parallel review authority.

### Dependency direction, reuse and later support — clear

Every prerequisite is either a Stage 1 support card or exact pinned-Mathlib
reuse. A Chapter 11+ or other out-of-range source dependency is represented as a
bounded support node with exact locator, statement, reason, consumers and status;
it neither imports an entire later chapter nor earns later coverage, and an
unresolved node blocks completion (`:436-455`, `:503-504`). Definitions remain
noncircular, semantic quantitative results do not import recovery modules, and
the generic-to-specialized direction from the existing roadmap remains intact.
This is appropriately consumer-driven rather than an unbounded foundations
programme.

At this planning stage no specific new Lean declaration or Mathlib replacement
is proposed, so there is no honest call-site-based extraction, import-cost or
performance finding to raise. The planned reusable seam—a source-independent
finite quantitative theorem with source recovery as a downstream consumer—is
the right architecture. Future family packets still owe pinned-Mathlib searches,
exact signature reviews, profiling claims where relevant, and consumer evidence
before abstractions or tactics are added.

### DLMF/Olver non-transfer and DD-021 authority — clear

The selected DLMF snapshot requires per-page retrieval dates, digests, methods
and observed version evidence; a root version label is not substituted for page
identity (`:108-136`). Existing `inventory-v1.0.0` rows remain frozen Olver-track
authority, and DLMF records wait for a reviewed multi-track migration. DLMF and
Olver coverage never transfer; shared mathematics requires an explicit semantic
crosswalk (`:59-72`, `:452-455`). This preserves source identity while allowing
mathematical reuse.

DD-021 revision 2 is unambiguously pending. It becomes effective only after two
fresh independent approvals and a root external adjudication all bind this exact
commit and the same five digests; material edits reset the process
(`:18-39`). Once effective it supersedes only the four enumerated Olver-first
priority/scheduling clauses and replaces them with DLMF Stage 1 priority plus
finite separately authorized execution manifests (`:41-57`). It does not erase
the Olver edition lock, evidence or coverage meanings, and `OLV-MVP-1` remains an
eligible parallel Olver packet with independent credit. The identical pending
successor notice in the other four reviewed files makes the precondition visible
from every existing authority entry point.

### Verso presentation boundary — clear

The handoff permits a useful filterable projection while requiring separate
source/proof/review/implementation/coverage/manifest axes, explicit unresolved
and failed states, local/global target distinction, source-track distinction and
unmistakable fixture/provisional labels (`:628-637`). Verso is expressly
read-only and cannot approve mathematics, mutate lineage, authorize Lean, create
a denominator or promote a reference lead (`:639-642`). No presentation system
is treated as authority.

### Global library rubric summary — clear

- **Mathematical intent:** the declaration programme is faithful to the stated
  exact-analysis and source-coverage goal; provisional states are isolated.
- **Reusable seams/API shape:** finite semantic theorems, entity identification,
  and source recovery have distinct roles; no speculative universal function or
  asymptotic typeclass is required.
- **Module/dependency design:** general mathematics points toward named functions
  and audit consumers; recovery and out-of-range support cannot point backward.
- **Mathlib integration:** exact pinned reuse remains a first-class support
  discharge, while named definitions require reviewed semantic identification.
- **Proof architecture:** new mathematics is proved and reviewed before signature
  design and authorized implementation; construction/recovery risks add a
  structural-circularity gate.
- **Cost/durability:** finite audit and execution batches bound work; the plan
  makes no unsupported performance claim and delays abstractions/tactics until
  consumer evidence exists.
- **Refactor risk:** immutable IDs, append-only corrections, exact-byte review
  invalidation and the narrow scheduling-only DD-021 override localize change.

No concrete long-term cost, missed capability, trust defect, source-fidelity gap,
dependency inversion or completion loophole meeting P0--P3 finding standards
remains in these exact plan bytes.

## Findings

None.

## Commands and limitations

Material commands/evidence actions were:

```text
find /workspace/Documents/Codex/2026-09-05 -name AGENTS.md -print
sed -n ... referee-lean-library/SKILL.md
sed -n ... references/global-rubric.md references/research-basis.md
mktemp -d /tmp/lmlf-stage1-referee-f-XXXXXX
git worktree add --detach <fresh-dir> 88a166ef0ab0db6ec57d652103328cf6dfe17a12
git status --short --branch
git rev-parse HEAD
git worktree list --porcelain
git log -5 --oneline --decorate
sha256sum <the five reviewed artifacts>
wc -l -w -c <the five reviewed artifacts>
bash referee-lean-library/scripts/library_inventory.sh <fresh-dir>
nl -ba <each reviewed file> | sed -n <successive complete ranges>
rg -n <authority/target/lineage/classification/completion/dependency terms> <the five artifacts>
curl -L --fail --silent --show-error --max-time 30 <official DLMF URLs>
```

The official URLs checked were the DLMF root, `/about/news/`, chapter landings
`/4` through `/10`, terminal software sections, and sentinel sections `/4.13`,
`/5.17`, `/5.18`, `/9.12`, `/9.14`, `/10.46`, `/10.47`, and `/10.61`.

Limitations: this was a normative blueprint audit and limited official-source
fact check, not the future canonical URL/page/leaf census, semantic atomization,
schema migration, source review, Lean API design, proof review, implementation
review, validator execution or coverage computation. I did not claim that the
spot-checked live bytes constitute the selected production snapshot. The
deterministic inventory is only a structural lead, not approval evidence. No
build or CI run was needed to assess these documentation-only plan bytes.

## Stable handoff

`approve` is final for exactly the commit and five digests recorded above. A
material change invalidates it. Root adjudication must verify that this report
and the other qualifying approval are independent, exact-bound, stable external
artifacts before recording DD-021 revision 2 acceptance.
