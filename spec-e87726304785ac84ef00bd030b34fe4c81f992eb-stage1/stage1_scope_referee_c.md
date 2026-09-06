# Stage 1 DLMF scope blueprint — fresh referee C

## Verdict

`approve`

I found no material P0--P3 defect in the exact five-file successor reviewed
below. This is one independent blueprint verdict only. It does not make
DD-021 effective, authorize a census/schema/card/Lean implementation, certify
source coverage, or substitute for the second fresh approval and root external
adjudication required by the proposal itself.

## Exact review binding

- Repository: `/workspace/Documents/Codex/2026-09-05/yo`
- Reviewed commit: `e87726304785ac84ef00bd030b34fe4c81f992eb`
- Parent: `32807da8dae22fbcfcc951ad20113b4ca7693e3c`
- Commit subject: `Specify Stage 1 DLMF boundary and scoped programme amendment R2 [skip ci]`
- Detached review checkout:
  `/tmp/lmlf-stage1-scope-referee-c.urzDNTeo/checkout`
- Checkout state: clean, detached `HEAD`; `git symbolic-ref -q HEAD` failed as
  expected and the explicit fallback printed `DETACHED`.

Exact artifact SHA-256 bindings:

| Artifact | SHA-256 |
|---|---|
| `blueprint/stage_1_dlmf-R2.md` | `edb086372ac577223df12f77ea80e872c187b3cd03c3a74f24e8a135606a326e` |
| `blueprint/README.md` | `aa88e13f707e4c0347e6f44863049e92777e0b1ffcd196692d8fcaa95b0358ed` |
| `blueprint/roadmap.md` | `fbce9c54502d344ba536c59b33b67e8eac79349914b4046aa56595e020c0d501` |
| `blueprint/design_decisions.md` | `a181e582451d6f7841e1a120f8c1956e355cdf53b62e0e0b306d61fc126a3b7b` |
| `blueprint/source_manifest.md` | `473d82d349d40b9c800458f88c34412b8700d3943951e50328ce91657847b537` |

`git diff-tree` confirmed that the reviewed commit changes exactly those five
files: four successor notices and the new R2 plan. `git diff --check` was clean.

## Reviewer and isolation attestation

- Reviewer ID: `stage1_scope_referee_c`
- Reviewer kind: agent
- Actual dispatch model: `gpt-5.6-sol`, high reasoning, `fork_turns: none`
  (dispatch metadata supplied by root; this runtime did not expose a separate
  independently queryable model identifier)
- Runtime: Codex desktop container
- Review stage: blueprint/pre-implementation architecture and scope review
- Isolation strength: `manual_attestation`
- Isolation method: a fresh local clone created with `mktemp -d`, checked out
  detached at the exact commit, in a fresh referee task. The host filesystem,
  network, tools, credentials, and writable paths were not technically excluded,
  so this is not a hardened clean room and I do not claim
  `technically_enforced` isolation.
- Independence: I did not delegate any part of this review. I did not open the
  R1 proposal, old R1 referee reports, peer reports, or existing disposition
  reports, and did not inherit their findings or verdicts. The R2 artifact's
  own historical-status sentence was necessarily visible as reviewed content.

No applicable `AGENTS.md` was present in the repository or its inspected parent
workspace path. I read the complete `referee-lean-library` skill, its required
`global-rubric.md`, and its workflow `research-basis.md` before concluding the
review.

## Material review scope and conclusions

This was a full architecture/scope review of all five bound files, not a diff
skim and not a source census. I also read the complete authoritative status and
review context needed to interpret them:

- `blueprint/theorem_cards/README.md`;
- `blueprint/function_inventory.md`;
- `review/README.md` and `review/PROTOCOL.md`;
- `review/classifications-v3.json` (observed SHA-256
  `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`);
- `review/rubrics/source_fidelity.md`, `api_dependency.md`, and
  `quantitative_correctness.md`.

The repository does not contain the skill's suggested
`scripts/library_inventory.sh`; I therefore used `rg --files`, the repository
tree, commit statistics, targeted cross-file searches, and the existing
inventory/control-plane documents as read-only inventory evidence. I did not
run or modify CI, implement a validator, or treat the existing CSV validator as
proof of this proposed schema.

### Authority and exact programme boundary — clear

DD-021 is correctly pending rather than self-enacting. Its effective rule
requires two fresh independent approvals and a root external adjudication, all
bound to the same commit and five digests; candidate prose cannot satisfy those
conditions, and a material edit resets them. The identical prominent successor
notice appears in each of the four previously frozen control-plane documents.

Once effective, the amendment narrowly supersedes only four identified
Olver-first priority/scheduling clauses. It does not overwrite Olver's edition
lock, evidence, IDs, transcriptions, cards, reviews, manifests, or coverage
semantics. `OLV-MVP-1` remains an independently gated parallel Olver-track
packet, cannot become a DLMF prerequisite or occurrence, and cannot transfer
coverage in either direction. I found no competing frozen source authority:
the still-visible Olver-first prose is expressly current while R2 is pending
and expressly subordinate only on the enumerated scheduling points if DD-021
becomes effective.

The substantive boundary matches the requested programme: every mathematical
assertion in DLMF Chapters 4--10, including formulas and hidden prose in tables,
captions, applications, and computation/approximation material; Chapters 1--3
and later/outside material enter only as finite, named-consumer support. The
plan separates exact mathematical claims embedded in numerical discussions
from algorithms and software. It creates no floating-point, interval,
tolerance, quadrature, root-finding, or performance implementation obligation;
a future verified numerical library is only a downstream design consumer.

### DLMF discovery verification — clear, deliberately not a census

I independently consulted official NIST DLMF pages only. The
[DLMF root](https://dlmf.nist.gov/),
[citation guide](https://dlmf.nist.gov/help/cite), and
[errata page](https://dlmf.nist.gov/errata/) all identify release 1.2.7 dated
2026-06-15. Chapter landing pages confirm the listed titles and terminal
computation/software section structure for Chapters
[4](https://dlmf.nist.gov/4), [5](https://dlmf.nist.gov/5),
[6](https://dlmf.nist.gov/6), [7](https://dlmf.nist.gov/7),
[8](https://dlmf.nist.gov/8), [9](https://dlmf.nist.gov/9), and
[10](https://dlmf.nist.gov/10).

Focused source checks confirm the omission-sensitive leads:

- [DLMF 4.13](https://dlmf.nist.gov/4.13) exposes multivalued `W_k`, legacy
  `Wp`/`Wm`, Wright omega, and Tree `T`, including conventions that justify not
  prejudging aliases from names alone.
- [DLMF 9.12](https://dlmf.nist.gov/9.12) contains Scorer `Gi`/`Hi`, and
  [DLMF 9.14](https://dlmf.nist.gov/9.14) combines an internal-cross-reference
  definition of incomplete Airy functions with external literature leads.
- [DLMF 10.46](https://dlmf.nist.gov/10.46) contains the generalized Bessel
  series, Mittag--Leffler series, the underspecified Laplace-transform sentence,
  and a separate literature-only sentence about incomplete modified
  Bessel/Hankel functions. The R2 four-role treatment preserves those distinct
  obligations without importing cited papers.
- [DLMF 10.47](https://dlmf.nist.gov/10.47) confirms spherical and modified
  spherical Bessel families, and [DLMF 10.61](https://dlmf.nist.gov/10.61)
  confirms the Kelvin-family sentinel.
- I also used the non-numbered
  [Chapter 7 sidebar 7.SB1](https://dlmf.nist.gov/7.SB1) as an adversarial
  hidden-content check. R2's chapter-wide rule and content-unit treatment of
  prose, figures, and captions include its mathematical assertion; scope is not
  limited to formula permalinks or the named lead table.

These checks support the discovery map only. They do not certify a full URL,
page, content-unit, or occurrence census, which R2 correctly says does not yet
exist. Per-retrieval digests, dates, methods, observed version evidence,
representation reconciliation, and append-only successor snapshots prevent a
root version label from masquerading as page identity.

### Denominator, lineage, and entity semantics — clear

The target denominator is explicitly a set of immutable atomic occurrence IDs,
filtered by snapshot, Chapter 4--10, `record_kind`, atomicity, one of the two
included fidelity roles, and approving fidelity-role review. It is not a count
of pages, units, links, cards, declarations, or entities; repeated appearances
remain distinct occurrences while many-to-many card mappings are deduplicated.

Content units, nonmathematical records, reference leads, and provisional
underspecified claims have separate immutable record kinds. Resolution is
append-only: an underspecified row stays historical and creates a new atomic
target or reference-lead successor, so it can neither be relabeled into the
denominator nor double-count with the successor. The fixture demonstrates the
intended five-target/six-association result. Completion additionally requires
reviewed content dispositions, separate reconciliation of excluded totals, no
unresolved target, approved applicable source/semantics reviews, complete
target/card equality, and zero extra claims. I therefore found no approval or
atomicity escape around the denominator.

Canonical entities preserve argument and parameter roles, aliases, branches,
singularities/totalization, real/complex agreement, and distinct
value-changing normalizations. Each applicable entity must terminate in an
accepted Lean object and a proved, reviewed identification, while named
definitions are forbidden from depending on their later asymptotic or recovery
theorems.

### Dependency direction, support closure, and completion — clear

Each target has a bounded target card; every prerequisite has either a bounded
support card or exact pinned-Mathlib reuse. Out-of-range DLMF or external-source
support is one explicit, consumer-justified node and earns no target coverage.
Blocked or unresolved support is honest planning state and makes completion
false. Finite closed manifests remain the only executable units, avoiding a
chapter wildcard implementation.

For every asymptotic/approximation occurrence, the semantic finite result owns
the approximant, remainder/majorant, order, domains, thresholds, constants,
branches, exceptions, and parameters. A separate faithful DLMF recovery bridge
is downstream in `Audit/SourceRecovery`; definitions and semantic mathematics
cannot import it backwards. A DLMF qualitative statement without an explicit
bound therefore creates reviewed new mathematics rather than an assumed
majorant or target-shaped certificate. Structural qualitative assertions stay
ordinary exact targets instead of being distorted into error-bound claims.

The completion predicate is genuinely terminal and effective-state based. It
requires successful source snapshot and census review, exact denominator
equality, entity identification, frozen cards, complete or valid externally
confirmed `not_required` proofs, exact-byte approvals, passing external gates,
audited/released implementations, reconciled coverage, complete closed
manifests, discharged support, and both quantitative and recovery deliverables.
The mandatory negative fixtures reject envelope presence without approval,
`execution_ready` without completion, compiled/prototype-only code,
unreconciled occurrences, and blocked support. Candidate fields, compilation,
a closed scope, an envelope's mere existence, and a rendered dashboard cannot
self-certify any gate.

The §4.13 pilot names every required Lambert-family lead and requires its
occurrence/entity relationships to be reviewed. Verso is explicitly a
read-only projection of versioned authoritative records; it cannot alter
lineage, approve mathematics, authorize Lean, or turn reference leads into
coverage.

### Global library rubric disposition

- Mathematical intent: clear; the declaration programme matches the stated
  exact-analysis and source-recovery architecture.
- Reusable seams: clear at blueprint level; generic quantitative/support cards
  remain independent of named-source applications, with reuse driven by real
  consumers rather than a universal function typeclass.
- Public API/theorem shape: clear; exact results, identification, named
  applications, and audit recovery are separate roles with orthogonal statuses
  and classifications.
- Module/dependency design: clear; foundations/definitions/methods/applications
  flow forward and audit recovery is downstream.
- Mathlib integration: clear for this planning decision; exact pinned reuse is
  a terminal support option, while named objects still require semantic
  identification. No unverified claim of a specific new Mathlib replacement is
  made here.
- Proof architecture: clear; quantitative construction and qualitative
  recovery remain separately reviewable deliverables.
- Cost/durability: clear; stable opaque IDs, append-only lineage, immutable
  historical evidence, versioned schemas, and finite manifests localize future
  change.
- Refactor risk: clear; DD-021 preserves historical evidence and narrows its
  supersession and migration surface. No refactor or deletion is recommended.

## Findings

None. In particular, I found no material source-scope omission, competing
authority, denominator inflation/erasure path, circular entity construction,
backward recovery dependency, support-closure escape, self-certifying gate,
false completion state, pilot omission, or Verso authority leak.

## Reproducible commands and tool actions

Read-only shell commands used, with the detached checkout as working directory
unless stated otherwise:

```text
pwd
rg --files -g 'AGENTS.md' -g '!blueprint/stage_1_dlmf-R1.md' -g '!**/*referee*' -g '!**/*report*' | sort
sed -n '1,240p' /home/codex/.codex/skills/referee-lean-library/SKILL.md
sed -n '1,320p' /home/codex/.codex/skills/referee-lean-library/references/global-rubric.md
sed -n '1,360p' /home/codex/.codex/skills/referee-lean-library/references/research-basis.md
git status --short --branch
git worktree list --porcelain
git log -5 --oneline --decorate --no-renames
review_root=$(mktemp -d /tmp/lmlf-stage1-scope-referee-c.XXXXXXXX)
git clone --quiet --no-hardlinks --no-checkout /workspace/Documents/Codex/2026-09-05/yo "$review_root/checkout"
git -C "$review_root/checkout" checkout --quiet --detach e87726304785ac84ef00bd030b34fe4c81f992eb
git -C "$review_root/checkout" status --short --branch
git -C "$review_root/checkout" rev-parse HEAD
git -C "$review_root/checkout" show -s --format='%H%n%P%n%ad%n%s' --date=iso-strict HEAD
find "$review_root/checkout" -name AGENTS.md -print
rg --files | sort
wc -l blueprint/stage_1_dlmf-R2.md blueprint/README.md blueprint/roadmap.md blueprint/design_decisions.md blueprint/source_manifest.md blueprint/theorem_cards/README.md blueprint/function_inventory.md review/PROTOCOL.md review/README.md review/classifications-v3.json
sed -n '1,520p' blueprint/stage_1_dlmf-R2.md
sed -n '1,430p' blueprint/README.md
sed -n '1,520p' blueprint/roadmap.md
sed -n '1,340p' blueprint/design_decisions.md
sed -n '1,380p' blueprint/source_manifest.md
sed -n '1,240p' blueprint/theorem_cards/README.md
sed -n '1,320p' blueprint/function_inventory.md
sed -n '1,380p' review/PROTOCOL.md
sed -n '1,180p' review/README.md
sed -n '1,240p' review/classifications-v3.json
sed -n '1,240p' review/rubrics/source_fidelity.md
sed -n '1,240p' review/rubrics/api_dependency.md
sed -n '1,260p' review/rubrics/quantitative_correctness.md
sha256sum blueprint/stage_1_dlmf-R2.md blueprint/README.md blueprint/roadmap.md blueprint/design_decisions.md blueprint/source_manifest.md review/classifications-v3.json
git show --stat --oneline --decorate --no-renames e87726304785ac84ef00bd030b34fe4c81f992eb
git diff-tree --no-commit-id --name-status -r e87726304785ac84ef00bd030b34fe4c81f992eb
git log -1 --format='%H' -- blueprint/stage_1_dlmf-R2.md blueprint/README.md blueprint/roadmap.md blueprint/design_decisions.md blueprint/source_manifest.md
rg -n 'Proposed successor-authority notice|DD-021|stage_1_dlmf-R2|Olver-first|first source-coverage programme|first true.*MVP|DLMF Stage 1|Verso|Target\(S\)|fidelity_role_review|atomic' blueprint/stage_1_dlmf-R2.md blueprint/README.md blueprint/roadmap.md blueprint/design_decisions.md blueprint/source_manifest.md
nl -ba blueprint/stage_1_dlmf-R2.md | sed -n '1,500p'
git diff --check e87726304785ac84ef00bd030b34fe4c81f992eb^ e87726304785ac84ef00bd030b34fe4c81f992eb -- blueprint/stage_1_dlmf-R2.md blueprint/README.md blueprint/roadmap.md blueprint/design_decisions.md blueprint/source_manifest.md
git status --porcelain=v1
git symbolic-ref -q HEAD || printf 'DETACHED\n'
```

Official-web discovery used read-only search/open requests restricted to
`dlmf.nist.gov` for the root, news/errata/citation metadata, Chapters 4--10,
the terminal software sections, §§4.13, 9.12, 9.14, 10.46, 10.47, 10.61, and
the Chapter 7 sidebar. No web result was treated as a full census.

No candidate file was edited. No schema, census, theorem card, Lean code,
validator, CI, commit, or push was created or run by this review. The only file
written is this external referee report.
