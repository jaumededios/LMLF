# Independent Stage 1 DLMF architecture and source-scope review — referee E

## Verdict

**`request_changes`**

The R3 proposal is substantially stronger than the currently operative control
plane: it cleanly separates local source-audit closure from global closure,
requires semantic rather than span-disjoint atom ownership, preserves shared
context without double-counting, makes quantitative applicability total and
non-waivable, requires distinct finite and source-recovery roles, keeps
definitions below recovery, closes support explicitly, and makes Verso a
read-only projection. I nevertheless found three specification-level defects
that can change programme authority or the source denominator. They must be
repaired and freshly reviewed before DD-021 revision 2 becomes operative.

This verdict is not an external root adjudication and does not authorize a
source census, schema migration, theorem-card creation, Lean work, coverage, or
the Verso projection.

## Reviewer and isolation metadata

| Field | Value |
|---|---|
| reviewer ID | `stage1_scope_referee_e` |
| reviewer kind | `agent` |
| actual model | `gpt-5.6-sol` |
| reasoning effort | `high` |
| review kind | independent full architecture/source-scope blueprint review |
| runtime | Codex desktop agent; shell and network tools available |
| fresh dispatch | `fork_turns=none`, as recorded by the dispatching root task |
| isolation strength | `manual_attestation` |
| checkout | independently created detached worktree `/tmp/stage1-scope-referee-e.h1ZTr8` |
| reviewed commit | `88a166ef0ab0db6ec57d652103328cf6dfe17a12` |
| review date (UTC) | 2026-09-06 |

Manual attestation: I reviewed a clean detached checkout at the exact commit
above. I did not open the R1 or R2 proposal, any predecessor or peer review,
any finding/disposition from an earlier round, any uncommitted successor work,
or the separate Verso worktree. The workspace and network boundaries were not
technically isolated, so I do not claim clean-room enforcement. No applicable
`AGENTS.md` was present in the repository or its workspace ancestors.

## Exact artifact binding

All five supplied SHA-256 values matched bytes read from the detached commit.

| Artifact | SHA-256 |
|---|---|
| `blueprint/stage_1_dlmf-R3.md` | `764c5d01707e6c0ed1e10b318a7d8891ce1bb24d00f556faa4cc26dab65a0dd0` |
| `blueprint/README.md` | `e98e8f69ac08462e18c29f305c4868d2db3581b3b690508e49a1993bf82a728a` |
| `blueprint/roadmap.md` | `144ec070b30c3ac0ae6e0bf482a29d73336beaf832b14e76b67f7bd38c80d9ce` |
| `blueprint/design_decisions.md` | `e5a014ec20fdba9d6cc1ad1919bcb9f4f1067803892fcfa9201f93c04189abfe` |
| `blueprint/source_manifest.md` | `140652cae9cf5a632cbd4f86eed175b791661e28e960956227e9bf5ef28825a9` |

The candidate commit changes exactly these five paths relative to its parent
`e87726304785ac84ef00bd030b34fe4c81f992eb`. The protected Olver inventory,
cards, proofs, packets, and classification artifact have no path changes from
the preserved baseline `3a1b16cae6d186a20530de3b883c1bb871ee76f6`
to the reviewed commit.

## Scope reviewed

I read all five bound artifacts in full. Supporting authority inspected was
limited to the current root status in `README.md`,
`blueprint/theorem_cards/README.md`, `review/README.md`,
`review/PROTOCOL.md`, all five review rubrics, the current function/inventory
protocol and relevant normalized registries, the Lean root/import modules, and the
pinned toolchain/manifest. I also applied the complete
`referee-lean-library` global rubric and its research-basis instructions.

Official-source discovery was deliberately sampled rather than treated as a
census. The official DLMF root and news page confirm version 1.2.7 and release
date 2026-06-15. Direct checks of §§4.13, 9.14, 10.46, and 10.61 support the
named sentinel distinctions in R3: Lambert branch/alias, Wright omega, and Tree
T content; the internal-definition versus external-reference structure of
incomplete Airy; the underspecified Laplace-transform sentence and separate
incomplete-Bessel reference lead; and Kelvin-family mathematical prose.

## Findings

### G1 — P1 — The activation boundary leaves the root project authority saying Olver is still first

**Locations:** `blueprint/stage_1_dlmf-R3.md:27-39`,
`blueprint/stage_1_dlmf-R3.md:41-59`, and `README.md:3-7`.

R3 says that the exact five-file successor takes effect only after its review
and adjudication conditions, then supersedes *only* the enumerated programme
priority/scheduling clauses; it expressly says that no other clause is
superseded. The repository's public root README is not in that five-file set,
has no pending-successor notice, and still unqualifiedly says that LMLF's first
source-coverage programme is the corrected 1997 Olver reprint. That is the
opposite programme-order statement from R3's replacement rule that DLMF Stage 1
has programme priority.

This is not merely stale presentation. The root README is the repository entry
point and directs readers to the blueprint as the detailed scope authority. On
the proposed effective state, a planner can follow the root status and schedule
Olver first while another follows DD-021 and schedules DLMF first; the exact
five-artifact adjudication cannot change or bind the omitted root bytes.

**Required repair:** make the root programme sentence part of the successor.
Prefer adding a pending/effective DD-021 notice and rewriting the global
Olver-first sentence as an Olver-track-local statement. Update the activation
artifact list and digests accordingly (which will require fresh exact-byte
reviews). If the owner deliberately keeps a five-file activation set, DD-021
must at minimum identify the exact root README clause it supersedes and the root
document must cease presenting that clause as current global truth. Verify by a
repository-wide search that every surviving “first programme/MVP” statement is
either the DLMF rule or explicitly scoped to the parallel Olver track.

**Blast radius:** governance/documentation only, but it changes the identity of
the successor review packet. **Confidence:** high.

### G2 — P1 — “Canonical URL” does not determine a unique DLMF payload universe

**Locations:** `blueprint/stage_1_dlmf-R3.md:117-129`,
`blueprint/stage_1_dlmf-R3.md:202-247`, and
`blueprint/stage_1_dlmf-R3.md:332-339`.

The global closure is defined by exhaustively enumerating canonical Chapter
4--10 URLs/leaves, while a source appearance binds its canonical URL and
different appearances receive different occurrences. The plan does not define
which DLMF URL level owns payload or how redirect, fragment, equation-permalink,
query/customization, and alternate-format aliases are canonicalized before
appearance IDs are minted.

This ambiguity is observable on the official site, not hypothetical:

- <https://dlmf.nist.gov/10.61.i> redirects to
  `<https://dlmf.nist.gov/10.61#i>` and renders the same full §10.61 document as
  <https://dlmf.nist.gov/10.61>, including formula 10.61.1 and later
  subsections.
- <https://dlmf.nist.gov/4.13.E1_2> redirects to
  `<https://dlmf.nist.gov/4.13#E1_2>` and renders the full §4.13 document rather
  than an independent equation payload.

Consequently, an implementation can reasonably enumerate section,
subsection, and equation permalinks as separate “canonical URLs” and mint
duplicate source appearances for one payload. Alternatively it can choose only
one URL tier without any normative rule proving that the omitted tier is an
alias rather than an unaudited page. Exact leaf ownership and a reviewed
`B_all` do not repair the circularity, because the universe that `B_all` must
exhaust is itself underdetermined.

**Required repair:** specify the semantic document canonicalization contract in
the plan (the full production schema/census is not needed). It must identify
one payload-owning retrieval document for each DLMF content family after
redirect normalization; treat fragments, equation/subsection permalinks,
format variants, and customization/query variants as locators or
representations unless an exact-byte audit proves distinct payload; and require
alias reconciliation before issuing `source_appearance_id`. Add a negative
fixture in which `/10.61`, `/10.61.i`, and `/10.61.E1` cannot create three
appearances of formula 10.61.1, while two genuinely repeated locations within
the canonical payload remain two occurrences.

**Expected benefit:** `B_all` has one reproducible source universe, overlapping
batches reuse identities deterministically, and exact URL expansion cannot
inflate or shrink `Target(S)`. **Blast radius:** future DLMF schema, retriever,
and census only; no Olver record changes. **Confidence:** high.

### G3 — P1 — One lineage relation cannot safely serve both atom correction and snapshot evolution

**Locations:** `blueprint/stage_1_dlmf-R3.md:123-125`,
`blueprint/stage_1_dlmf-R3.md:237-247`,
`blueprint/stage_1_dlmf-R3.md:255-274`, and
`blueprint/stage_1_dlmf-R3.md:317-330`.

R3 gives each atom exactly one key
`(snapshot_id, source_appearance_id, atom_ordinal)`, requires repeated source
appearances to remain distinct, defines an active atom as one not superseded,
and excludes superseded predecessors from targets. It also permits unrestricted
split/merge lineage and says the same lineage vocabulary is used between
snapshot successors. These rules leave two incompatible cases unresolved.

First, within one snapshot, let `O1` and `O2` be the same formula printed at
distinct appearances `A1` and `A2`. The merge rule as written permits
`{O1,O2} -> O3` if a reviewer attests that `O3` owns their union. `O3` cannot
then have exactly one appearance key without either dropping `A1`/`A2`, owning
two keys, or collapsing the repeated appearances that R3 requires to remain
distinct.

Second, suppose snapshot `S2` records a `modified` successor of an atom in
`S1`. If this supersedes the `S1` atom under the single global definition of
“active”, the later snapshot causes `Target(S1)` to lose a historically valid
member. If it does not supersede the old atom, the rule that predecessors cannot
be counted alongside successors is not well-defined. The target filter by `S`
already prevents cross-snapshot co-counting, so deactivating old-snapshot atoms
is both unnecessary and destructive to reproducible historical coverage.

**Required repair:** type the relations separately.

1. A within-snapshot correction/atomicization supersession relation may change
   effective atomization for that snapshot; restrict split/merge endpoints to
   the same source appearance (and snapshot) so every successor still owns one
   canonical key.
2. A cross-snapshot evolution relation may be `unchanged`, `modified`, `split`,
   `merged`, `added`, or `removed`, including set-valued mappings when page
   structure changes, but it must never deactivate or rewrite the predecessor
   snapshot's effective target set. Define activity relative to the selected
   snapshot and its own reviewed correction state.

Add negative fixtures proving that a same-snapshot merge across distinct
appearances is rejected and that accepting a successor snapshot leaves the
previously closed `Target(S_old)` byte-for-byte/set-for-set unchanged.

**Expected benefit:** immutable snapshot claims remain reproducible while real
site-version splits and merges can still be represented. **Blast radius:**
future DLMF lineage schema and completion validator; no frozen Olver semantics
need change. **Confidence:** high.

## Rubric disposition

| Rubric area | Disposition |
|---|---|
| mathematical intent | `request_changes` for G1--G3; the broad Chapters 4--10 target and selective support intent is otherwise faithful |
| reusable seams | clear; the occurrence/entity/card separation, shared-context references, and semantic/recovery split are justified reusable boundaries |
| public API/theorem shape | clear at plan level; no exact DLMF Lean signatures are proposed or authorized yet |
| module/dependency design | clear; finite semantics flow to `Audit/SourceRecovery`, never backwards, and Verso remains downstream/read-only |
| Mathlib integration | clear for this scope; the plan correctly defers exact per-card reuse audits and does not authorize duplicate named-function construction |
| proof architecture | clear; construction, identification, finite quantitative semantics, and faithful recovery have separate obligations and structural-circularity review where applicable |
| cost/durability | `request_changes` for the denominator and historical-state instability in G2--G3 |
| refactor risk | bounded repairs above; no implementation or Olver-data migration should be coupled to them |

Explicit do-not-refactor decisions from this review:

- Keep the narrow DD-021 change as scheduling/priority only; do not mutate or
  transfer Olver evidence, occurrence credit, or source semantics.
- Keep local `Target(S,B)` partial and batch-scoped and global `Target(S)`
  undefined until separately reviewed `B_all`; do not demand the prospective
  census or validator as a condition of approving a repaired plan.
- Keep the two designated obligations for every asymptotic/approximation atom:
  reusable finite quantitative semantics and exact source recovery.
- Keep support closure explicit and finite, including Chapters 1--3 and
  out-of-range references, without granting those nodes Chapter 4--10 credit.
- Keep the current semantic/audit import direction and the non-authoritative,
  read-only Verso boundary.

There is no local-proof handoff: this review concerns the normative architecture,
not tactic-level Lean changes.

## Verification evidence

Commands were run from `/tmp/stage1-scope-referee-e.h1ZTr8` unless shown
otherwise.

```text
git rev-parse HEAD
# 88a166ef0ab0db6ec57d652103328cf6dfe17a12

git status --short --branch
# ## HEAD (no branch)

sha256sum blueprint/stage_1_dlmf-R3.md blueprint/README.md \
  blueprint/roadmap.md blueprint/design_decisions.md \
  blueprint/source_manifest.md
# all five values matched the binding table above

git diff-tree --no-commit-id --name-status -r HEAD
# M blueprint/README.md
# M blueprint/design_decisions.md
# M blueprint/roadmap.md
# M blueprint/source_manifest.md
# A blueprint/stage_1_dlmf-R3.md

git diff --name-only \
  3a1b16cae6d186a20530de3b883c1bb871ee76f6 HEAD -- \
  blueprint/inventory blueprint/theorem_cards blueprint/proofs \
  review/work_packets review/classifications-v3.json
# no output

git diff --check HEAD^ HEAD
# no output

/home/codex/.codex/skills/referee-lean-library/scripts/library_inventory.sh \
  /tmp/stage1-scope-referee-e.h1ZTr8
# clean detached 88a166e snapshot; 7 Lean files, 210 lines, 3 defs,
# 18 theorems; import edges agree with the intended semantic/audit split

python3 scripts/validate_inventory.py --negative-tests
# negative invariant tests passed: 25 intentionally invalid copied fixtures rejected
# inventory validation passed: 148 occurrences, 31 notations, 32 entities,
# 34 entity evidence rows, 88 occurrence associations
```

A cold-cache `lake build` was started in the disposable checkout and stopped on
the root coordinator's direction after dependency download and 1743/2756
upstream compilation tasks. It produced no project failure, but it is
intentionally **not** recorded as a passing build. A full implementation build
is unnecessary evidence for this documentation-only plan verdict and is being
checked separately. The tracked checkout remained clean after interruption.

Official web pages inspected on 2026-09-06:

- <https://dlmf.nist.gov/>
- <https://dlmf.nist.gov/about/news/>
- <https://dlmf.nist.gov/errata/>
- <https://dlmf.nist.gov/4.13>
- <https://dlmf.nist.gov/4.13.E1_2>
- <https://dlmf.nist.gov/9.14>
- <https://dlmf.nist.gov/10.46>
- <https://dlmf.nist.gov/10.61>
- <https://dlmf.nist.gov/10.61.i>

## Acceptance condition for a successor

A successor is ready for fresh blueprint review when it (1) removes the root
programme-authority conflict and binds the corrected artifact set, (2) fixes a
unique DLMF payload/canonical-URL universe before appearance IDs are minted,
and (3) separates snapshot-local correction activity from cross-snapshot
evolution so repeated appearances and historical `Target(S)` values cannot be
collapsed. All existing strong closure, classification, dual-obligation,
support, authorization, completion, Olver non-transfer, and presentation
clauses should remain materially unchanged.
