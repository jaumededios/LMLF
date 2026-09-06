# Independent Stage 1 blueprint architecture and source-scope review — referee J

## Verdict

`request_changes`

The proposal has the right high-level architecture: Chapters 4--10 are an
assertion-level DLMF programme; Chapters 1--3 and later material are finite,
consumer-justified support; reusable structural mathematics and finite
quantitative producers live in semantic modules; source-specific recovery is a
downstream audit consumer; local source-audit manifests and Lean execution
manifests are distinct; the global denominator is undefined until reviewed
closure and external selection; Olver and DLMF source credit do not transfer;
and numerical software is excluded while future verified numerics remains a
downstream design consumer. I found no P0 trust or scope reversal.

Approval is nevertheless premature. Four P1 contract gaps remain in identity
repair, local authority withdrawal, durable source evidence, and proof-before-
signature ordering. Two P2 defects weaken the promised specific-function
omission controls and leave a linked execution-status document contradictory.
All are bounded blueprint repairs; none requires a census, schema
implementation, validator, theorem card, proof, Lean implementation, Verso
implementation, production build, or CI run.

## Review identity and snapshot

- Reviewer ID: `stage1_scope_referee_j`
- Reviewer kind: `agent`
- Model: `gpt-5.6-sol`
- Reasoning effort: `high`
- Review time: `2026-09-06T18:33:35Z`
- Runtime: Codex desktop agent on Linux `5.15.0-190-generic x86_64`; Git
  `2.39.5`; Python `3.11.2`; curl `7.88.1`
- Candidate repository supplied: `/tmp/lmlf-stage1-scope.DbhM9YHt`
- Review checkout: `/tmp/stage1-scope-referee-j.AHIetl/checkout`
- Candidate commit: `3bb4c48056332a7cd0cc87f240d012c415c6114d`
- Snapshot state: clean detached `HEAD`; no repository `AGENTS.md` was present.
- Isolation strength: `manual_attestation`, not technically enforced. I used a
  new detached worktree and did not inspect predecessor Stage 1 plans R1--R4,
  predecessor/peer reports or dispositions, an IMP worktree, uncommitted work,
  or Verso. The runtime nevertheless had network access, a shared filesystem,
  tools, and visibility of other worktree paths; plugins, credentials, personal
  instructions, and writable paths were not technically excluded. This review
  therefore makes no clean-room claim.
- Mutation boundary: no candidate edits, branch/pin changes, downloads, CI,
  commits, pushes, or delegation. The only substantive file written is this
  report; the disposable detached worktree and its parent directory were
  created for read-only inspection.

## Exact six-file binding

All six candidate artifacts were read in full and matched the supplied
SHA-256 digests:

| Artifact | SHA-256 |
|---|---|
| `blueprint/stage_1_dlmf-R5.md` | `51dc2f8789e72e2a627ce1d6ff7ec11b1ec403b248c139e04246175a09dc53b6` |
| `README.md` | `84ca0315b6ce1f3d92d45666cdd83cf5580df7ebed0fd9c60929ede8fc93b5ce` |
| `blueprint/README.md` | `3459b27051fe365c09d0f5bc437a8f790bfe90ffcdf3ec2fe70648e9ba2b1386` |
| `blueprint/roadmap.md` | `a5e3263b16c5d0ab6650a928d1acf03e97acdfad824e0358ea59b09d04a8771c` |
| `blueprint/design_decisions.md` | `6aeac975c7f1bff56225c5046133c6af126f763ae19ad01643cae50e220dcecb` |
| `blueprint/source_manifest.md` | `e2f57c27f137e9fc0c74a9255aafbdb0cd81ee97bb29eeec4ad7c38e2e5b62de` |

No approval transfers from any earlier commit, proposal, report, disposition,
or review conversation. This verdict binds only the exact commit and six
digests above.

## Prioritized findings

### G1 — P1 — Entity and notation identity are immutable but not repairable

**Location.** `blueprint/stage_1_dlmf-R5.md:262-268`, `329-405`, `417-432`,
`529-540`, `646-649`, and `683-693`.

**Evidence.** The Lambert pilot deliberately leaves `Wp`/`Wm` alias identity,
domains, boundary values, and branch-side conventions for reviewed resolution.
The plan then defines typed append-only correction only for retrieval-document,
source-appearance, and atom identities, plus cross-snapshot atom evolution.
The audit revision's pinned view enumerates source identity, atomization,
lineage, fidelity/exclusion, and obligation classification, but not the
effective notation/entity identity and association view. Section 6 allocates
never-reused notation and entity IDs, while completion merely requires their
links to be confirmed. There is no rule for repairing a mistakenly merged
entity, coalescing two mistaken aliases, changing a value-preserving alias into
a value-changing normalization relation, or correcting an occurrence-to-entity
association without rebinding or mutating an immutable ID.

The existing Olver inventory makes the gap concrete rather than hypothetical:
`blueprint/function_inventory.md` represents notation ownership and
occurrence/entity associations, but its status changes do not supply the
append-only, selected-view lineage now required for DLMF. The first DLMF pilot
is explicitly built around exactly this sort of uncertain entity decision.

**Cost.** A reviewed early interpretation of `Wp`, `Wm`, Wright omega, Tree
`T`, a real/complex restriction, or a scaled normalization can become
irreparable except by mutation or parallel competing canonical rows. The
denominator may remain stable while its semantic entity identity silently
changes, and Verso cannot reconstruct the entity view authoritative for a past
audit revision.

**Bounded fix.** Add typed append-only within-snapshot correction relations for
notation identity, entity identity, and occurrence-to-notation/entity
associations. Require fresh never-reused successor IDs for split/coalesce
repairs, preserve predecessor records, distinguish literal aliasing from
value-changing equivalence, and pin the complete effective notation/entity
decision view by ID/digest in every audit revision. State whether these repairs
block `PartitionReady` or only execution/completion; whichever boundary is
chosen must prevent a target from entering an execution manifest with an
unreviewed branch/entity view. Add negative fixtures for mistaken alias
coalescence, mistaken entity collapse, normalization reclassification, and a
past revision being changed by a later entity repair.

**Blast radius and verification.** Blueprint/schema contract and future Verso
reader only; no present CSV migration or code is needed for this plan review.
A fresh referee should verify that the Lambert fixture can be corrected in both
directions without mutation, duplicate effective canonical entities, or
historical-view drift. Confidence: high.

### G2 — P1 — A compromised local audit batch has no current-authority withdrawal path

**Location.** `blueprint/stage_1_dlmf-R5.md:417-477`, `490-524`, `683-701`, and
`848-867`.

**Evidence.** A reviewed local `Target(S,B)` may feed a separately authorized
Lean execution manifest before global closure. Corrections create a new audit
revision and never mutate the old one. The only defined selection,
replacement, suspension, and counterevidence mechanism is for the global
`B_all^r`/`Target(S)` authority. There is no corresponding current-validity
record for a local batch revision and no rule invalidating dependent execution
authorization or local coverage when accepted counterevidence shows that the
batch's document identity, partition, atomicization, role, classification, or
entity reading was wrong.

The older release policy can withdraw a released coverage status, but that
does not make `PartitionReady(S,B)` non-authoritative as an input to pending or
already authorized execution, nor does it identify the affected dependent
manifests. The immutable historical local denominator should remain replayable;
the missing concept is its *current authority*, not deletion.

**Cost.** The plan can correctly suspend global completion while still allowing
an invalid local batch to authorize further proof and implementation work. A
later correction cannot silently mutate the pinned execution manifest, but
nothing requires that manifest's authorization to be suspended.

**Bounded fix.** Give each local audit revision used by an execution manifest an
external selection/current-validity record. Accepted material counterevidence
must conservatively suspend that local authority and every dependent
`lean_ready`, coverage, and release gate until an exact successor batch is
reviewed and explicitly selected; no fallback. Preserve the historical
`Target(S,B_old)` as a replayable record. Add a negative fixture in which a
local batch is later contradicted while no global closure exists.

**Blast radius and verification.** Audit/execution authority contract and
future validator/Verso projection. It need not alter mathematical declarations.
Verify a dependency walk from a withdrawn local batch to all exact-bound
execution envelopes and ensure unaffected batches remain usable. Confidence:
high.

### G3 — P1 — Hash-only source retention cannot support the promised exact-byte reproducibility

**Location.** `blueprint/stage_1_dlmf-R5.md:186-222` and `473-477`.

**Evidence.** Every retrieval is to be bound by date, digest, method, redirect
chain, and observed version evidence, but the retention rule stores only
locators, hashes, metadata, short fragments, and paraphrases and forbids
mirroring bulk prose, tables, or figures. The plan then says every earlier
exact-bound audit revision and denominator remains reproducible. A digest binds
bytes that someone possessed; it does not reconstruct them or let a later
reviewer re-check atomicization, prose, table cells, captions, or
representation mismatches after the live DLMF page changes. The official DLMF
site exposes a current release label rather than a commit-addressed historical
payload for each page, so a future locator plus old hash is not a usable source
snapshot.

This matters particularly because version 1.2.7 itself contains page-level
changes and the proposal correctly requires a new snapshot for changed bytes.
Without retained exact payload evidence, the old/new difference and old
atomicization cannot be independently re-audited.

**Bounded fix.** Require each source-snapshot record to bind an immutable,
access-controlled evidence object containing the exact retrieved payloads and
representations needed to repeat the audit (or a legally authorized archival
reference that guarantees those bytes). Keep bulk material out of the public
repository and apply the NIST/third-party rights policy. If retention is not
permitted, narrow the claim to “decision-view and denominator replayable, but
source audit not reproducible,” record that limitation, and forbid renewed
source approval once the reviewed bytes are unavailable. A hash alone must not
be described as rerunnable source evidence.

**Blast radius and verification.** Source-snapshot/evidence contract only; no
source download is requested now. A fresh reviewer should be able to resolve
each recorded digest to the exact reviewed bytes or observe an explicit
non-reproducible/expired state. Confidence: high.

### G4 — P1 — The lifecycle clause permits a frozen signature before the mandatory proof reviews

**Location.** `blueprint/stage_1_dlmf-R5.md:620-628` versus
`blueprint/stage_1_dlmf-R5.md:848-857`, `blueprint/README.md:71-85`, and
`blueprint/roadmap.md:98-114`.

**Evidence.** The established lifecycle is unambiguous: complete the natural-
language proof, freeze/review proof and architecture, and only then design the
exact Lean signature. R5's lifecycle clarification instead says that planning
records and selected cards may name “frozen signature targets,” and its next
sentence protects only the proof/review/`lean_ready` gates “before
implementation.” Read literally, it authorizes signature freezing before the
pre-signature mathematical reviews, contrary to both R5's own audit protocol
and the operative project lifecycle.

**Cost.** A future packet can cite this exception to harden a Lean-facing API
before proof review discovers missing hypotheses, branch conditions, or a
different natural theorem shape—the precise sequencing failure the project is
designed to avoid.

**Bounded fix.** Replace “frozen signature targets” with “frozen source-facing
mathematical target statements (not exact Lean signatures),” or explicitly say
that proposed names/types are nonbinding sketches and that no exact Lean
signature is designed or frozen until all required proof/architecture reviews
approve. Reassert both the pre-signature and pre-implementation gates in the
same paragraph.

**Blast radius and verification.** One lifecycle paragraph and any future card
template terminology; no existing Lean signature is implicated. Verify the
resulting order is identical in R5, the blueprint index, roadmap, dependency
graph, and review protocol. Confidence: high.

### G5 — P2 — The “specific-function map” omits known in-scope named entities

**Location.** `blueprint/stage_1_dlmf-R5.md:228-286`.

**Evidence.** The table is explicitly a “scope checklist” with “mandatory
function leads,” yet its Chapter 8 and Chapter 10 rows omit several named
functions directly defined on official in-scope pages:

- [DLMF §8.22](https://dlmf.nist.gov/8.22) defines the terminant function
  `F_p(z)` and the incomplete Riemann zeta function `zeta_x(s)`, and names
  related Debye functions.
- [DLMF §10.21(xiii)](https://dlmf.nist.gov/10.21.xiii) defines the Rayleigh
  function `sigma_n(nu)`.
- [DLMF §10.43(iii)](https://dlmf.nist.gov/10.43.iii) defines the Bickley
  function `Ki_alpha(x)` and its analytic continuation.

The universal assertion sweep at lines 246--250 should eventually catch them,
so this is not a denominator-definition failure. It is nevertheless concrete
evidence that the advertised specific-function omission checklist is not yet
complete. These are stronger examples than bibliography-only neighbor names:
they are definitions or explicit mathematical relations inside Chapters 8 and
10.

**Bounded fix.** Add these entities (including relevant alternative notations
such as the Chapter 8 Prym names) to the mandatory leads/sentinels. More
importantly, define the discovery cross-check that closes the function lead
map: chapter landing page plus special-notation page plus every `Defines`
annotation and a reverse pass through the official notation/index pages. Keep
that lead-map closure distinct from the final atomic denominator.

**Blast radius and verification.** Discovery checklist only. Verify the added
sentinels against the exact 1.2.7 payload and demonstrate that the reverse
function pass discovers them without relying on free-text memory. Confidence:
high.

### G6 — P2 — A linked execution-order document contradicts the current canonical IMP status

**Location.** `blueprint/README.md:27-30` links
`blueprint/dependency_graph.md` as the execution-order authority;
`blueprint/dependency_graph.md:91-120` omits `IMP-001` from “Current registered
nodes” and calls it an unregistered R6 draft. In contrast,
`blueprint/source_manifest.md:181-216`, `blueprint/inventory/cards.csv`, and
`blueprint/inventory/manifests.csv` record frozen R7 `IMP-001` as the sole
member of closed, specification-only `IMPROPER-0`.

**Evidence and scope.** R5 correctly says the programme amendment does not
transfer or rewrite unrelated legacy status. That restraint means activation
does not repair this contradiction. The dependency graph itself says canonical
inventory/external records determine lifecycle truth, so the stale paragraph
is subordinate, but its “current” heading and concrete next edge remain
operationally misleading in the document the index tells readers to use for
execution order.

**Bounded fix.** Either include a corrected dependency graph in the exact
successor artifact set (which necessarily resets digests/review) or add an
exact bounded amendment stating that the identified stale IMP status paragraph
has no current authority and naming the canonical replacement status/next
edge. Do not transfer the older signature approvals into final-packet quorum.

**Blast radius and verification.** Documentation/status only. Re-run the
inventory validator and manually reconcile every “current node” row against
the canonical card/manifest inventories and external authority. Confidence:
high.

## Rubric disposition

| Review area | Result |
|---|---|
| Mathematical intent and full scope | Correct programme boundary and assertion-level denominator design; G5 weakens the specific-function discovery guard. |
| Reusable seams and Mathlib integration | Clear at plan level. The proposal appropriately requires project-first/pinned-Mathlib reuse and per-entity identification without pre-choosing speculative universal abstractions. No extraction is authorized or needed here. |
| Public API and theorem shape | The finite producer/source-recovery split and ordinary structural semantic placement are sound. G4 must remove the pre-signature lifecycle ambiguity. |
| Module/dependency direction | Sound semantic-to-audit direction; no numerical layer. G6 is a status/execution-document inconsistency, not a request to change the mathematical DAG. |
| Proof architecture | Exact quantitative first for genuine asymptotic/approximation atoms, faithful recovery second, and separate ordinary structural classification are coherent. Natural constants, domains, branches, totalization, reachability, and nonnegativity remain explicit. |
| Source identity and audit closure | Atomic ownership, repeated appearances, alias normalization, local/global denominator separation, pinned audit views, and global selection/withdrawal are strong. G1--G3 are required durability/current-authority completions. |
| Refactor risk and compatibility | Olver records remain immutable and source credit is non-transferable. The proposed fixes should extend the successor contract rather than rewrite historical rows. |
| Verso handoff | The read-only projection, local/global distinction, orthogonal statuses, and prohibition on dashboard authority are correct. It must consume the entity view and local-authority state added by G1/G2 and expose unavailable source evidence from G3. |

## Explicit do-not-refactor decisions

- Do not collapse the finite quantitative producer and faithful source recovery
  into one declaration or one status.
- Do not move reusable analyticity, continuation, monotonicity, sign,
  uniqueness, zero structure, or exact identities into `Audit/SourceRecovery`.
- Do not make Chapters 1--3 a blanket target denominator; retain finite named
  support closure.
- Do not turn the DLMF programme into numerical software or impose a current
  numerical API. Exact finite results should remain usable by a later verified
  numerical consumer.
- Do not merge repeated semantic locations merely because formulas agree, and
  do not let locator/format aliases mint occurrences.
- Do not transfer DLMF coverage to the Olver track, Olver coverage to DLMF, or
  any earlier approval to changed bytes.
- Do not require future schema, validator, theorem-card, proof, Lean, or Verso
  implementation as a condition for accepting a corrected semantic plan.

## Checks and evidence consulted

### Repository instructions and review controls

Read completely:

- `/home/codex/.codex/skills/referee-lean-library/SKILL.md`
- `/home/codex/.codex/skills/referee-lean-library/references/global-rubric.md`
- `/home/codex/.codex/skills/referee-lean-library/references/research-basis.md`
- `review/PROTOCOL.md`
- `review/README.md`
- all five files under `review/rubrics/`
- `blueprint/theorem_cards/README.md`

Read relevant operative/status/legacy sections from:

- `blueprint/function_inventory.md`
- `blueprint/dependency_graph.md`
- `blueprint/qualitative/release_strategy.md`
- `blueprint/qualitative/navigation_and_docs.md`
- `blueprint/qualitative/source_recovery.md`
- canonical `blueprint/inventory/cards.csv` and
  `blueprint/inventory/manifests.csv` status rows
- `review/work_packets/IMP-001.yaml` and
  `blueprint/theorem_cards/IMP-001.yaml` only through targeted status searches

No predecessor Stage 1 plan was opened.

### Official primary DLMF evidence

- [DLMF root](https://dlmf.nist.gov/),
  [project news](https://dlmf.nist.gov/about/news/), and
  [errata](https://dlmf.nist.gov/errata/) confirmed version `1.2.7`, release
  date `2026-06-15`.
- Official Chapter 4--10 landing pages were used to check section ranges and
  software tails.
- [§4.13](https://dlmf.nist.gov/4.13),
  [§9.12](https://dlmf.nist.gov/9.12),
  [§9.14](https://dlmf.nist.gov/9.14),
  [§10.46](https://dlmf.nist.gov/10.46),
  [§10.47](https://dlmf.nist.gov/10.47), and
  [§10.61](https://dlmf.nist.gov/10.61) confirmed the named sentinels and the
  formula/prose/reference distinctions.
- [Sidebar 7.SB1](https://dlmf.nist.gov/7.SB1) returned a distinct `200` page,
  validating the nonnumeric-document sentinel.
- HTTP header checks confirmed `/10.61.i` and `/10.61.E1` return `302` to
  `/10.61#i` and `/10.61#E1`, while `/10.61` returns `200`, validating the
  locator-alias negative fixture.
- [§8.22](https://dlmf.nist.gov/8.22),
  [§10.21(xiii)](https://dlmf.nist.gov/10.21.xiii), and
  [§10.43(iii)](https://dlmf.nist.gov/10.43.iii) supplied the omitted function
  evidence in G5.

### Commands run

- `git rev-parse HEAD`, `git status --short --branch`, `git branch
  --show-current`, `git worktree list --porcelain`, and `git log -5 --oneline
  --decorate`
- `mktemp -d` followed by `git worktree add --detach ...
  3bb4c48056332a7cd0cc87f240d012c415c6114d`
- `/home/codex/.codex/skills/referee-lean-library/scripts/library_inventory.sh
  <checkout>`
- `sha256sum` and `wc -l -c` for all six bound artifacts
- `sed`/`nl -ba` full reads of the six artifacts and instruction/rubric files;
  targeted `sed`, `rg`, and `rg --files` for referenced controls and status
- `git show --stat --oneline --decorate --no-renames HEAD`
- `git diff --check HEAD^ HEAD -- <six artifacts>` (no output)
- `python3 scripts/validate_inventory.py`
- `python3 scripts/validate_inventory.py --negative-tests`
- official-domain web searches/opens and nonpersistent `curl -sS -D - -o
  /dev/null` header checks for URL identity
- `date -u`, `uname -srmo`, and tool-version queries

The existing validator passed with 148 occurrences, 31 notations, 32 entities,
34 entity-evidence rows, 88 occurrence associations, and all 25 existing
negative fixtures rejected. That validates only the frozen Olver CSV structure;
it does not discharge any finding above or claim a DLMF census. No production
build was needed for this documentation-only review.

## Acceptance condition

Issue a materially revised, exactly hash-bound successor that resolves G1--G6,
then obtain fresh independent review and root adjudication under its own
activation rule. This report is `request_changes` and cannot count as an
approval for the current six-file bytes.
