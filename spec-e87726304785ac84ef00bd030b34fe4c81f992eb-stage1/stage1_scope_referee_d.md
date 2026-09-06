# LMLF Stage 1 source/scope/completion blueprint review — referee D

## Verdict

**`request_changes`**

The proposed programme boundary, source/prose distinctions, finite-support
discipline, external-authority lifecycle, and read-only Verso contract are
substantively sound. Two specification gaps nevertheless make the stated Stage
1 completion predicate unsound: it can be evaluated over a target set that is
not proved to be an exact partition of the audited mathematical source, and it
does not define a total, reviewed classification that determines which target
occurrences owe the quantitative-plus-recovery pair. These are material because
both gaps admit a false completion result while violating the user-authorized
scope.

This verdict is only one independent blueprint review. Even after two approving
reviews exist, DD-021 revision 1 still requires the separately recorded root
external adjudication bound to the exact commit, all five artifact digests, and
both review identities. This report does not supply that adjudication and does
not make DD-021 operative.

## Review identity and isolation attestation

- Reviewer ID: `stage1_scope_referee_d`
- Reviewer kind: `agent`
- Model: `OpenAI Codex GPT-5`
- Runtime: Codex desktop, Linux `5.15.0-190-generic` x86_64
- Review time: 2026-09-06 UTC
- Isolation strength: `manual_attestation`
- Isolation method: I created a fresh detached Git worktree at
  `/tmp/lmlf-stage1-ref-d.4kwwuA2B/checkout` from the exact requested commit.
  `git status --porcelain=v2 --branch` reported detached HEAD at the bound SHA
  and no worktree changes. The candidate was treated as read-only; I made no
  candidate edit.
- Isolation limitations: this was not a technically enforced clean-room run.
  The shared host filesystem, ordinary tools, network access, and the parent
  conversation remained available.
- Independence attestation: I did not delegate any portion of the review. I did
  not read `blueprint/stage_1_dlmf.md`, any R1 proposal, any old or peer Stage 1
  referee report, any inherited finding/disposition set, or the separately
  prepared Verso projection. I independently derived the findings below.

## Exact snapshot binding

- Candidate commit:
  `e87726304785ac84ef00bd030b34fe4c81f992eb`
- Commit subject: `Specify Stage 1 DLMF boundary and scoped programme amendment R2 [skip ci]`
- Review scope: complete, line-by-line review of all five exact successor
  artifacts:

| Artifact | SHA-256 |
|---|---|
| `blueprint/stage_1_dlmf-R2.md` | `edb086372ac577223df12f77ea80e872c187b3cd03c3a74f24e8a135606a326e` |
| `blueprint/README.md` | `aa88e13f707e4c0347e6f44863049e92777e0b1ffcd196692d8fcaa95b0358ed` |
| `blueprint/roadmap.md` | `fbce9c54502d344ba536c59b33b67e8eac79349914b4046aa56595e020c0d501` |
| `blueprint/design_decisions.md` | `a181e582451d6f7841e1a120f8c1956e355cdf53b62e0e0b306d61fc126a3b7b` |
| `blueprint/source_manifest.md` | `473d82d349d40b9c800458f88c34412b8700d3943951e50328ce91657847b537` |

All five computed digests matched the supplied bindings. `git show --name-status`
also confirmed that this commit changes exactly those five files.

## Material findings

### D1 — P0 — the target denominator is not closed by a reviewed source-to-atom partition

**Location:** `blueprint/stage_1_dlmf-R2.md:197-257`, especially the
content-unit census at lines 197-215 and `Target(S)` at lines 219-244; completion
rows at lines 348-350; fixture at lines 384-412.

**Issue:** `Target(S)` is exact only relative to whatever rows happen to exist.
The proposal requires every content unit to receive a disposition and says that
every mathematical piece receives a fidelity role, but it never defines or
requires a total, unique, reviewed relation from source-bearing leaf content to
atomic occurrence records. In particular, it does not distinguish container
units (chapter/section/subsection) from disjoint source-owning leaves, define an
atomicity/splitting rule, require every mathematical leaf payload to be exhausted
by atoms, or prohibit two distinct atomic IDs from denoting the same source
appearance. Deduplicating occurrence IDs prevents duplicate association rows
from inflating coverage; it does not prevent two different IDs for one source
atom. Conversely, an omitted atom is absent from both `Target(S)` and the
card-union equality, so that equality can still pass.

The review predicate creates another escape hatch: an existing explicit or
internal-cross-reference occurrence whose `fidelity_role_review` is pending,
failed, or changes-requested is excluded from `Target(S)`, while the completion
table does not explicitly require every atomization and fidelity-role review to
reach an approving terminal state. The append-only provisional mechanism is
directionally correct, but it likewise lacks a checked rule saying that the
active successor set exactly partitions the original claim and that the
original has a successful effective resolution. Without that rule, zero,
duplicate, or overlapping successors can respectively omit or inflate content.

**Evidence:** The content-unit list nests chapters, sections, subsections, and
their formula/prose/table/caption children, so ownership cannot be inferred from
the unit kind alone. The fixture tests repeated appearances and duplicate
card-association rows, but not an omitted atom, duplicate IDs for one source
appearance, overlapping parent/child ownership, a non-approved role review, or
an invalid provisional split. The official DLMF pages make this non-hypothetical:
[§4.13](https://dlmf.nist.gov/4.13) interleaves formulae, branch prose, figures,
and assertions; [§9.14](https://dlmf.nist.gov/9.14) contains an internal-cross-
reference definition plus a separate literature lead; and
[§10.46](https://dlmf.nist.gov/10.46) contains explicit definitions and an
identity, an underspecified Laplace-transform assertion, and reference-only
literature leads on the same short page. A reviewed partition, not mere row-ID
deduplication, is needed to show that such mixed content is neither lost nor
counted twice.

**Required fix:** Before approval, make the source-to-denominator closure an
explicit normative invariant and completion gate. At minimum:

1. define container versus source-owning leaf units and a canonical source-span
   or equivalent ownership key;
2. require a reviewed atomicization record for every mathematical/mixed leaf,
   with its mathematical payload partitioned exhaustively and without overlap;
3. require every active atom to own exactly one `(snapshot, source appearance,
   atom ordinal)` (or an equally strong immutable key), while different source
   appearances remain distinct occurrences;
4. require every atomization, fidelity-role, exclusion, and effective
   provisional-resolution review to be approving and exact-bound at completion;
5. define append-only split/merge successor coverage so the active successors
   are an exact partition rather than merely linked rows; and
6. add mandatory negative fixtures for an omitted mathematical atom, duplicate
   IDs for one atom, overlapping parent/child ownership, a pending/failing role
   review, and zero/overlapping provisional successors.

`Target(S)` and its card-union equality must be derived only after this partition
gate succeeds. A later schema review may choose the concrete representation,
but it must not be allowed to weaken these semantics.

### D2 — P1 — the quantitative-obligation subset is not total or exact-bound

**Location:** `blueprint/stage_1_dlmf-R2.md:272-294` and
`blueprint/stage_1_dlmf-R2.md:343-360`.

**Issue:** The plan correctly requires two deliverables for every
“asymptotic or approximation member of `Target(S)`,” but neither the target-set
definition nor the completion table defines how that subset is represented,
reviewed, and proved total over `Target(S)`. The existing packet and target
theorem classes describe implemented theorem shape; they do not by themselves
constitute a source-occurrence-level applicability decision. A target can
therefore evade the finite quantitative theorem and downstream recovery bridge
if no record marks it as asymptotic/approximation, with no missing join for the
completion predicate to detect. The same gap makes the intended exemption for
analyticity, monotonicity, signs, uniqueness, and zero structure dependent on
unrecorded interpretation.

**Evidence:** `Target(S)` filters only record kind, snapshot, chapter,
atomicity, fidelity role, and role-review approval. The completion table repeats
the informal subset name but does not demand a reviewed occurrence-level
obligation classification or an exact mapping from each member of that subset
to both required deliverable roles. None of the mandatory negative fixtures
tests a qualitative-only asymptotic target or a missing recovery bridge. This
matters on DLMF pages such as [§4.13](https://dlmf.nist.gov/4.13), which mixes
branch/analyticity facts, exact identities, series, and asymptotic expansions,
and [§10.46](https://dlmf.nist.gov/10.46), where formula assertions must be
distinguished from underspecified or reference-only asymptotic prose.

**Required fix:** Add a total, immutable, source-semantics-reviewed obligation
classification (or an equally strong reviewed applicability relation) for every
member of `Target(S)`. It must distinguish at least targets requiring the
finite-quantitative-plus-source-recovery pair from ordinary exact/structural
semantic targets, record an exact frozen reason for any inapplicability, and
make pending/failing classification review block completion. Require an
exact-bound mapping from every quantitative-class occurrence to an accepted
semantic finite-result declaration/card and an accepted downstream faithful
recovery declaration/card; neither role may be inferred merely from a packet
summary. Add negative fixtures for an unclassified target, a qualitative-only
asymptotic proof, a finite result without recovery, and recovery without the
finite result.

## Independent DLMF discovery check

This was a bounded corroboration of the proposal's chapter/function leads and
formula/prose/reference distinctions, not a census and not source-review
approval for any future occurrence row.

- The official [DLMF root](https://dlmf.nist.gov/) and
  [errata](https://dlmf.nist.gov/errata/) reported version `1.2.7`, release date
  `2026-06-15`, matching the proposal's provisional source target.
- Official chapter landing pages corroborated the Chapter 4-10 section ranges
  and the software-terminal pattern, including [Chapter 4](https://dlmf.nist.gov/4),
  [Chapter 7](https://dlmf.nist.gov/7), [Chapter 8](https://dlmf.nist.gov/8),
  [Chapter 9](https://dlmf.nist.gov/9), and
  [Chapter 10](https://dlmf.nist.gov/10).
- [§4.13](https://dlmf.nist.gov/4.13) corroborated the multivalued branch
  family, legacy `Wp`/`Wm`, Wright omega, Tree `T`, and substantive prose claims.
- [§5.18](https://dlmf.nist.gov/5.18) corroborated q-factorials, q-Gamma,
  q-Beta, and the prose definition/reference lead for q-digamma/q-psi.
- [§9.14](https://dlmf.nist.gov/9.14) corroborated the proposal's important
  separation between an incomplete-Airy definition via exact internal
  cross-reference and external leads for further results.
- [§10.46](https://dlmf.nist.gov/10.46) corroborated explicit generalized
  Bessel and Mittag-Leffler formulae, the substantive but underspecified
  Laplace-transform statement, and the separate literature-only lead for
  incomplete modified Bessel/Hankel functions.

I found no material error in the bounded chapter/function discovery map. It is
properly labelled as leads rather than a final denominator.

## Clear areas / no finding

- DD-021's pending/effective rule is explicit: exact-five-file approvals are
  necessary but insufficient without root external adjudication. Its programme
  precedence is narrowly separated from preserved Olver edition evidence,
  transcriptions, cards, manifests, implementation evidence, and coverage.
- Chapters 4-10 are put in full mathematical-assertion scope, including prose,
  tables, captions, applications, and computation sections; Chapters 1-3 and
  later/external sources are limited to explicit consumer-justified support.
- Numerical software is excluded without discarding exact finite approximants,
  convergence/stability mathematics, or error bounds embedded in computational
  prose.
- Snapshot provenance is honestly prospective and per-retrieval. The document
  makes no false present census, count, coverage, implementation, or review
  claim.
- Required target/support cards, explicit out-of-range support nodes,
  exact-pinned reuse, successful dependency discharge, accepted named-object
  identifications, exact-byte external reviews and gates, audited/released
  implementation state, reconciled coverage, and finite manifests in
  `manifest_status: complete` are all required rather than inferred from
  compilation or manifest closure.
- Named-object identity, branches, totalization, normalization, reachability,
  majorant nonnegativity, noncircular definitions, and hypothesis/choice
  laundering controls are preserved.
- Verso is correctly specified as a read-only projection with no authority to
  change lineage, approve mathematics, authorize Lean, or award coverage.
- The five-file change preserves current Olver status prose rather than
  rewriting frozen historical self-status. No code, schema migration, census,
  theorem card, implementation, CI, or source-coverage action is authorized by
  this proposal.

## Commands and materials inspected

Representative commands rerun from the detached checkout:

```text
git -C /workspace/Documents/Codex/2026-09-05/yo status --short --branch
git -C /workspace/Documents/Codex/2026-09-05/yo worktree list --porcelain
git -C /workspace/Documents/Codex/2026-09-05/yo show -s --format=... e87726304785ac84ef00bd030b34fe4c81f992eb
git -C /workspace/Documents/Codex/2026-09-05/yo worktree add --detach /tmp/lmlf-stage1-ref-d.4kwwuA2B/checkout e87726304785ac84ef00bd030b34fe4c81f992eb
git status --porcelain=v2 --branch
git rev-parse HEAD
sha256sum blueprint/stage_1_dlmf-R2.md blueprint/README.md blueprint/roadmap.md blueprint/design_decisions.md blueprint/source_manifest.md
wc -l blueprint/stage_1_dlmf-R2.md blueprint/README.md blueprint/roadmap.md blueprint/design_decisions.md blueprint/source_manifest.md
/home/codex/.codex/skills/referee-lean-library/scripts/library_inventory.sh .
sed -n ... <each of the five exact files and relevant authority files>
nl -ba blueprint/stage_1_dlmf-R2.md
rg -n ... blueprint/stage_1_dlmf-R2.md blueprint/README.md blueprint/roadmap.md blueprint/design_decisions.md blueprint/source_manifest.md
git show --stat --oneline --decorate --no-renames HEAD
git show --format=fuller --name-status --no-renames HEAD
git diff --check HEAD^ HEAD
```

Relevant existing authority inspected included
`blueprint/theorem_cards/README.md`, `review/PROTOCOL.md`, `review/README.md`,
`review/templates/review_envelope.yaml`, `review/templates/verdict.json`,
`review/templates/work_packet.yaml`, `blueprint/function_inventory.md`, and the
referee-lean-library global rubric. No Lean build, inventory validator, CI,
candidate implementation, census generation, or schema mutation was performed.

