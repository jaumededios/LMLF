# LMLF exact-specification architecture/source review

- Reviewer ID: `spec_referee_a`
- Model: `gpt-5.6-sol`
- Isolation: `manual_fresh_context/read_only_exact_commit`
- Commit: `073a5675ffaba33c5bec52de00d525165aa17ff4`
- Repository: `/home/codex/Documents/Codex/2026-09-05/yo`
- Review disposition: independent architecture/source referee; no candidate edits
- Verdict: **REQUEST_CHANGES/BLOCK**

## Executive assessment

The long-range architecture is substantially better than a typical speculative
formalization roadmap. It keeps finite quantitative mathematics upstream of
source-facing qualitative recovery, uses occurrence-level rather than chapter-
level coverage, separates generic infrastructure from named applications, keeps
Airy/ODE/contour work off the Watson critical path, and repeatedly rejects
hypothesis and choice laundering. The locked-1997/later-preview distinction is
also stated clearly in the prose.

I nevertheless cannot approve this exact specification commit. The bootstrap's
first purported authorization crosses the repository's own trust boundary:
`QB-001` records its proof and review as approved and its implementation as
authorized inside the same root commit that first creates the allegedly frozen
packet, while the governing protocol says that the packet must first exist in a
specification commit and then be bound and approved by external artifacts. The
packet even stores `lean_ready: pass` internally, although the protocol assigns
that state exclusively to the external envelope. This is a proof-before-Lean
gate failure, not a documentation nicety.

Four other material consistency defects reinforce the block: the exact commit
does not contain the dependency-pin or Lean files that committed prose says the
repository contains; the feasibility audit compiled an obsolete API rather than
the frozen eight-signature API; preview-only named-function evidence is promoted
to `confirmed` entities against the stated source policy; and frozen work packets
use known-incompatible classification vocabularies without the mapping that the
contract specification itself requires. A smaller registry contradiction calls
`EX-002` registered although it is absent from the canonical card registry.

## Scope and read-only evidence

I read all 60 files in the committed tree, including every committed blueprint,
family, method, automation, qualitative, inventory, proof/card/packet, protocol,
rubric, and review-template file. I reviewed only Git blobs at the SHA above.
The working tree's untracked Lean project/scaffold was not treated as evidence,
and I did not inspect another referee report.

Read-only checks established:

- `git rev-parse HEAD` returned the reviewed SHA.
- `git rev-list --parents -n 1 <SHA>` returned only that SHA: this is the root
  commit, with no earlier committed specification state.
- `git ls-tree -r --name-only <SHA>` listed 60 files and no `lean-toolchain`,
  `lakefile.toml`, `lake-manifest.json`, `LMLF.lean`, or `.lean` file.
- The tracked `blueprint/`, `review/`, and `scripts/` trees have no diff from the
  reviewed commit. The visible Lean/toolchain files are all untracked and were
  excluded.
- `python3 scripts/validate_inventory.py` passed: 24 occurrences, 2 notations,
  10 entities, 16 associations, with manifest totals `BOOTSTRAP-0=0`,
  `DEMO-0=0`, and `OLV-MVP-1=1`.
- SHA-256 recomputation from exact Git blobs matched all packet-recorded upstream
  digests: QB proof `653b6f...6754c`, QB card `ad68e0...1587c`, QB signatures
  `1959a7...4f12`, QB review ledger `2fe44a...be9a9`, and DEF card
  `97d3c7...3b024`. The exact QB and DEF packet digests are respectively
  `6448ab...e574` and `aca9a6...396d`; neither has yet been bound by an external
  envelope in the reviewed record.

The inventory-validator success is appropriately narrow. Its input table list is
only the normalized CSV corpus (`scripts/validate_inventory.py:18-169`), and its
card checks concern registry paths/statuses rather than YAML card, packet, proof,
or external-review lifecycle consistency (`scripts/validate_inventory.py:772-825`).
It therefore does not mitigate the findings below.

## Prioritized findings

### P0 — BLOCK: `QB-001` self-certifies the external proof-before-Lean gate

The normative workflow requires the packet to be frozen in a specification
commit, followed by an external envelope binding the exact `spec_commit`, packet
path/digest, and upstream artifact revisions/digests; only that envelope may set
`lean_ready` to pass (`review/README.md:25-45`,
`review/PROTOCOL.md:50-66`, `review/PROTOCOL.md:85-115`). Filled envelopes and
verdicts must live outside the candidate head, and each verdict must bind the
packet identity, exact upstream digests, reviewer identity, model/runtime, and
actual isolation method (`review/PROTOCOL.md:137-174`). The proof schema says the
same thing and explicitly warns that a repository review summary is not quorum
evidence unless the protocol binds it as an immutable external record
(`blueprint/automation/proof_artifact_schema.md:48-56`).

The exact commit instead does all of the following internally:

- the proof frontmatter says `approved` and lists two approver names
  (`blueprint/proofs/QB-001.md:1-10`);
- the card says proof/review `approved`, implementation `authorized`, and
  membership `execution_ready` while its baseline commit is still
  `pending_external_record_after_commit`
  (`blueprint/theorem_cards/QB-001.yaml:5-16`);
- the card repeats the approvals and turns on `lean_allowed`
  (`blueprint/theorem_cards/QB-001.yaml:98-112`,
  `blueprint/theorem_cards/QB-001.yaml:142-172`);
- the committed review ledger declares authorization, but itself concedes that it
  does not replace the external baseline-commit record
  (`blueprint/reviews/QB-001-rev3.md:1-13`,
  `blueprint/reviews/QB-001-rev3.md:41-80`); and
- most directly, the frozen work packet stores internal `gate_evidence.state:
  pass` and `lean_ready.state: pass`, then justifies authorization from the two
  in-repository summaries (`review/work_packets/QB-001.yaml:305-320`,
  `review/work_packets/QB-001.yaml:418-422`). The v2 packet template specifies
  requirements but deliberately has no such internal gate state
  (`review/templates/work_packet.yaml:87-123`); the external envelope owns those
  states (`review/templates/review_envelope.yaml:28-42`).

Because this is the root commit, there was no earlier committed frozen packet to
which the claimed round-three reviews could have been bound under this protocol.
No supplied external reference identifies verdict records with the required
commit, packet digest, upstream digests, rubric revision, durable reviewer
metadata, and isolation data. Reviewer names and prose summaries inside the
candidate are untrusted convenience data, not a quorum.

**Required correction:** make all candidate-owned review/gate facts
nonauthoritative. At minimum, remove `lean_ready.state`, internal pass evidence,
and authorization claims from the packet/card/manifest projections; set the QB
review/implementation axes to states no stronger than the externally supported
record permits; and freeze one coherent successor specification whose card,
signature, proof, and packet states agree. After that commit exists, create an
external envelope binding its full SHA and exact packet/upstream digests, obtain
the required independent verdicts with complete reviewer/runtime/isolation
metadata, and let only that external envelope advance `lean_ready`. If the old
mathematical reviews are retained as history, label them non-quorum historical
input; do not use them to authorize Lean unless independently rebound by current
external verdicts.

### P1 — The committed reproducibility and prototype facts are not facts about this exact commit

The Mathlib audit states that the pin is already expressed by the repository's
`lean-toolchain`, `lakefile.toml`, and `lake-manifest.json`, and that the cached
Mathlib checkout is clean at the named SHA
(`blueprint/mathlib_audit.md:21-38`). Both work packets depend on that pin and
advertise `lake` verification commands (`review/work_packets/QB-001.yaml:257-269`,
`review/work_packets/QB-001.yaml:400-403`,
`review/work_packets/DEF-001.yaml:149-162`,
`review/work_packets/DEF-001.yaml:283-286`). But none of those pin files is in the
exact commit.

Likewise, the committed current-truth table says the DEF code exists and builds
(`blueprint/README.md:20-31`), and the card and packet record a compiled prototype
at `LMLF/Definitions/Gamma.lean`
(`blueprint/theorem_cards/DEF-001.yaml:136-148`,
`review/work_packets/DEF-001.yaml:10-19`). The exact tree contains neither that
file nor any Lean source. This review was expressly required to ignore the
untracked scaffold, so the claimed compilation cannot be reproduced or tied to
immutable prototype bytes at this SHA.

This does not mean a specification commit must contain implementation code. It
means committed status language must distinguish an external, unbound observation
from exact-commit evidence. Presently it does not.

**Required correction:** either include the toolchain/lake pin in the reviewed
specification baseline (and later bind candidate Lean bytes separately), or
replace “already expressed by the repository” with an exact immutable external
pin reference. For DEF-001, downgrade `implementation_status: compiled` and
`declarations_present: true` in this exact-commit projection, or bind the exact
prototype tree/blob and build log externally and name that reference. Every
reproducibility command must say which committed or externally immutable tree it
runs against.

### P1 — The feasibility audit does not validate the frozen QB API it is used to support

The compiled-spike section says it checked `ErrorOn`, `NormBoundOn`, the obsolete
`HasFiniteExpansion`, and only four transport lemmas
(`blueprint/mathlib_audit.md:238-256`). Its “recommended smallest foundation”
again names `HasFiniteExpansion` (`blueprint/mathlib_audit.md:337-347`). The
roadmap, however, explicitly says that `HasErrorFamily` replaced that misleading
name (`blueprint/roadmap.md:157-167`), and the frozen signature artifact consists
of `HasErrorFamily`, an additional `.exact` theorem, and a single `LMLF.Basic`
import (`blueprint/theorem_cards/QB-001-signatures.md:8-53`).

Thus the audit is useful historical exploration but is not compile evidence for
the exact eight-signature contract being authorized. In particular, it does not
establish that the exact signatures elaborate under the exact proposed import
surface at the recorded pin. This matters because the protocol requires referenced
dependencies to exist before `lean_ready` and invalidates the gate when the pin
changes (`review/PROTOCOL.md:102-115`).

**Required correction:** rerun a disposable, exact-signature compilation against
the externally bound Lean/Mathlib pin; record the command, imports, full SHA, and
output outside the candidate; and update the audit so its current recommendation
uses `HasErrorFamily` and all eight declarations. Keep any old-name spike only as
explicitly superseded history.

### P1 — Preview-only source evidence is promoted to `confirmed` entities

The source policy is otherwise admirably explicit: the inspected publisher
preview is a 2010 CRC reprint whose reconciliation and page mapping to the locked
1997 edition are unresolved, and it may support discovery/provisional body
location but cannot close the locked edition
(`blueprint/function_inventory.md:9-24`). The family-wide evidence table is even
more specific: direct 2010-preview body material may evidence “a provisional
occurrence or entity,” not a reconciled locked occurrence/formula/notation/
normalization (`blueprint/families/README.md:22-34`). The qualitative recovery
contract likewise says the preview can generate leads and provisional
transcriptions only (`blueprint/qualitative/source_recovery.md:259-279`).

Nevertheless, Gamma, reciprocal Gamma, Beta, digamma, trigamma, and tetragamma
are all assigned `identity_status=confirmed` solely from 2010-preview evidence
(`blueprint/inventory/entities.csv:2-7`), even though every link from the
corresponding purported Olver occurrence to those entities is still
`provisional` (`blueprint/inventory/occurrence_entities.csv:2-7`). The entity
vocabulary has only `provisional`, `confirmed`, and `excluded`
(`blueprint/function_inventory.md:95-110`), so an unqualified `confirmed` badge
has no place to preserve “confirmed only in the later preview.” This is exactly
the sort of axis collapse that can later leak into catalogue and manifest claims.

**Required correction:** change these entity identities to `provisional` until a
locked-edition body occurrence is reconciled, or add separate, validated axes for
“identified in inspected snapshot” and “confirmed for locked edition.” Extend the
inventory validator so a locked-programme `confirmed` entity requires a qualifying
confirmed association/reconciled snapshot, rather than allowing all occurrence
links to remain provisional.

### P1 — Frozen/closed metadata uses a known lossy classification model and inconsistent freeze states

The contract-linting specification acknowledges that theorem cards and work
packets use different theorem/coverage vocabularies and prohibits guessing the
mapping. It requires a versioned mapping or canonical vocabulary, with a missing
or ambiguous map diagnosed as `SCHEMA-CLASS-001` at freeze level
(`blueprint/automation/contract_linting.md:75-104`). No such mapping is present.

The consequence is already visible, not hypothetical. The frozen QB packet says
its per-target novelty is `source_equivalent` only because the template has no
`non_novel` value, while simultaneously explaining that no source equivalence or
new mathematics is claimed (`review/work_packets/QB-001.yaml:7-20`). Its card uses
`non_novel` (`blueprint/theorem_cards/QB-001.yaml:88-101`). DEF similarly maps a
card-level `entity_identification` to packet-target `source_prerequisite` without
a machine-defined relation (`blueprint/theorem_cards/DEF-001.yaml:8-16`,
`review/work_packets/DEF-001.yaml:46-80`). A controlled value that is knowingly
semantically false is not repaired by a prose caveat.

Freeze state is also inconsistent. `scope_closed` is defined as finite, fully
carded, and frozen, and BOOTSTRAP-0 sets it true
(`blueprint/source_manifest.md:23-39`,
`blueprint/source_manifest.md:112-126`). Both work packets say `frozen`, but both
cards say `specification_status: specified`, and the QB signature artifact also
says `specified` while calling itself frozen
(`review/work_packets/QB-001.yaml:3-8`,
`review/work_packets/DEF-001.yaml:3-8`,
`blueprint/theorem_cards/QB-001.yaml:5-15`,
`blueprint/theorem_cards/DEF-001.yaml:5-16`,
`blueprint/theorem_cards/QB-001-signatures.md:3-10`). Because `specified` and
`frozen` are distinct controlled values, a consumer cannot infer which one was
intended.

**Required correction:** freeze a versioned cross-artifact map or consolidate the
vocabularies before calling these packets frozen. Add a truthful `non_novel`/
`routine_reuse` target novelty value rather than overloading `source_equivalent`.
Define the transition between `specified` and `frozen`, then make card, signature,
packet, manifest, and external-envelope states agree. Add rejected fixtures for
exactly these mismatches when the contract linter is implemented; until then,
state explicitly that execution readiness is manually asserted and structurally
unvalidated.

### P2 — `EX-002` is called registered but is absent from the canonical registry

The integral/Laplace plan says `EX-002` is one of four “already registered” IDs
and labels it a “registered candidate”
(`blueprint/methods/integral_laplace.md:40-53`). The authoritative card registry
contains only QB-001, DEF-001, QL-001, OLV-001, and SR-001
(`blueprint/inventory/cards.csv:1-6`). The source manifest instead presents
`EX-002` merely as a DEMO-0 candidate and says only QB-001 and DEF-001 currently
have full cards (`blueprint/source_manifest.md:87-110`).

**Required correction:** either remove “already registered”/“registered
candidate” from the method document, or add an explicit planning registry row
under a documented rule that does not imply a complete card. Do not leave
registration as a prose-only status.

## Architecture observations that are not findings

- The semantic/audit dependency direction is correct and explicit. Quantitative
  finite theorems feed `Audit/SourceRecovery`, never conversely
  (`blueprint/qualitative/source_recovery.md:36-75`).
- The Watson path is bounded and genuinely useful: locked collation, QB, the
  minimum required QL slice, optional Gamma moments only if consumed, OLV, then
  SR. Airy, Cauchy transport, contour, ODE, turning-point, zero, and tactic tracks
  are kept off it (`blueprint/dependency_graph.md:103-128`,
  `blueprint/source_manifest.md:166-177`).
- Source recovery has the right proof obligations: an accepted quantitative
  producer, eventual-domain witness, exact scale comparison, notation/
  normalization equality, and exact source conclusion
  (`blueprint/qualitative/source_recovery.md:107-173`).
- Tactic staging is appropriately downstream of stable hand proofs and multiple
  consumers; the exact commit does not authorize tactic implementation. I found
  no tactic-first dependency inversion.
- The oversized QB dossier is bounded by the card's exact eight declarations and
  explicit exclusions (`blueprint/theorem_cards/QB-001.yaml:23-55`). That scope
  boundary is sound. Once the P0 gate defect is repaired, splitting the normative
  eight-target proof from the much larger future-results dossier would still
  reduce accidental approval reuse and digest churn, but I do not make that a
  separate blocker.
- No Olver theorem coverage is currently claimed, and the unresolved Watson
  collation is honestly represented. The P1 entity-status issue is narrower: it
  concerns `confirmed` named entities derived only from the later preview.

## Re-review conditions

A fresh review can consider approval after a successor exact commit satisfies all
of the following:

1. QB's candidate-owned approval/authorization/pass fields are removed or
   downgraded, and one coherent frozen artifact graph is produced.
2. An external envelope binds the successor `spec_commit`, both packet paths and
   digests, all upstream revisions/digests, the pin, and actual independent
   verdicts with complete reviewer/runtime/isolation metadata.
3. Exact pin and exact-signature compilation evidence is reproducible and the
   obsolete `HasFiniteExpansion` audit recommendation is superseded.
4. DEF prototype status is either downgraded or bound to immutable candidate/build
   evidence distinct from the spec commit.
5. Preview-only entities are provisional or represented on separate snapshot and
   locked-edition confirmation axes.
6. Classification and freeze-state mappings are made machine-unambiguous, and the
   EX-002 registry wording is reconciled.
7. The inventory validator and all digest checks pass again; any changed artifact
   receives a new revision/digest and invalidates prior gates as the protocol
   requires.

Until those conditions are met, implementation must not proceed on the authority
of the committed `QB-001` pass/approval fields.
