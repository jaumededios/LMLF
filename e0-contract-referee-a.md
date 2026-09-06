# Independent E0 companion-contract review — referee A

## Verdict

`request_changes`

The draft has the right bounded architecture and is close to implementable, but three normative
relations remain ambiguous enough that two conforming E0 implementations could disagree about
the local candidate set, the meaning of the DLMF classification successor, or when an exact Lean
signature is required. Those are contract defects, not requests for production data or global
automation. No P0 finding was identified.

## Exact review binding

- Candidate: `stage1-companion-schema-design-draft-02.md`
- Candidate SHA-256: `271758691cf4e4cfd3753aaac55c972de66e9697cf96747f6d4613fc20d9fc35`
- Accepted scope: `blueprint/stage_1_dlmf-R7.md` at
  `aebe7968bd6d5dcd23ac949d5d5e0d8854334ca1`
- Accepted-scope SHA-256:
  `4964a4ad79b8e8da0cdd376836383b189c32b38eaeecd9979dfdcca8cb54b4c2`
- External scope adjudication:
  `spec-aebe7968bd6d5dcd23ac949d5d5e0d8854334ca1-stage1/root-stage1-r7-adjudication.md`
- Adjudication SHA-256:
  `2af2a524ca8eadd26540dcd5acec95caddb6d9fb4c1078622522144ef6be7644`
- Repository snapshot inspected: clean `main` at
  `b8d2f731fcfd5cd0889d0732f13699eb94681c86`, equal to `origin/main` at review time.

Reviewer identity: `/root/e0_contract_referee_a`.

Model/runtime disclosure: OpenAI GPT-5-family Codex agent in a fresh subagent context. The dispatch
requested a Sol referee, but no exact serving build identifier was exposed to this reviewer, so
this report makes no serving-build attestation. Isolation was manual fresh-context separation,
not a technically enforced clean room: the filesystem was shared and unrestricted. I did not read
other draft-02 referee reports.

## Findings

### G1 — P1 — Batch membership is not normatively closed through the source-ownership chain

Candidate lines 56–59 list content units, source-owning leaves, appearances, and claim kinds, and
lines 93–101 require document coverage and claim uniqueness. But lines 120–126 define
`CandidateAtoms(S4,B4.1,V)` by an appearance being “explicitly in `B4.1`,” without requiring the
batch membership to be induced by a typed chain

`batch -> canonical retrieval document -> source-owning leaf -> appearance -> claim`.

The generic “audit membership” family at lines 62–63 does not say which subjects it may contain or
enforce that every appearance has exactly one owning leaf in the same canonical document and that
every claim-kind row has that same owner. Consequently, a structurally plausible implementation
can give the batch only selected appearance memberships while leaving another leaf or appearance
of an included document outside the candidate calculation. Manual review would then be asked to
repair a structural ambiguity instead of reviewing a fixed local partition.

This conflicts with the accepted source model: R7 lines 369–385 bind each appearance to its
canonical document and leaf, and lines 580–590 define a batch by exact document/leaf membership.
R7 lines 550–552 forbid carving difficult payload out of an included document or leaf. This does
not require semantic completeness automation: E0 only needs the synthetic relational closure.

Required change: state the cardinalities and same-owner constraints explicitly. At minimum, every
appearance must reference exactly one source-owning leaf and its one canonical document; every
atom, provisional claim, reference lead, and nonmathematical remainder must reference exactly one
appearance/owning leaf consistently; batch membership must name the document/leaf scope and derive
or validate appearance membership from that scope. Add a negative fixture in which an otherwise
valid appearance is cherry-picked while a sibling leaf/appearance of the included source scope is
omitted. Confidence: high. Blast radius: schema keys, membership checks, candidate enumeration,
and a small fixture only.

### G2 — P1 — The DLMF two-token class has no explicit orthogonal placement relative to v3

Candidate lines 152–159 call the new artifact a “successor” that binds the exact v3 digest and then
say it provides exactly two class tokens. They do not state whether those tokens form a new
occurrence-level `source_semantics_class` axis, replace one of v3's target-level axes, or replace
the v3 authority wholesale. Lines 161–166 correctly make `direct_source_target` and
`named_source_target` mapping subtypes and keep the quantitative roles distinct, but that alone
does not preserve v3's independent theorem/coverage/novelty classifications.

The ambiguity is concrete in the existing extension point. `review/classifications-v3.json`
lines 60–92 define three target-level axes, and `scripts/validate_inventory.py` lines 578–749 load
that artifact as the active packet/card authority. An implementer could reasonably replace that
loader with the two-token successor or place the tokens on the existing coverage axis. Either
choice would conflate source semantics with card classification and risk changing old-track
meaning despite candidate lines 38–45.

Required change: declare that the two tokens are one new, mandatory, single-valued
atom/occurrence-level source-semantics axis for DLMF records; that v3's packet-level and
target-level theorem/coverage/novelty axes remain orthogonal and unchanged; and that the successor
binds v3 as an immutable predecessor/dependency rather than interpreting the two tokens as a
replacement axis for old cards. State which artifact is loaded for legacy cards and which is
loaded for DLMF atom classifications. Add a negative fixture showing that a valid source-semantics
token cannot occupy a v3 coverage/theorem/novelty field and vice versa. Confidence: high. Blast
radius: classification descriptor/loader and synthetic fixtures; no v3 byte or legacy row changes.

### G3 — P1 — `card-binding` collapses a permitted pre-proof state into exact signature binding

Candidate lines 168–171 correctly allow role endpoints to be pending at `source-batch`, but then
say that at `card-binding` each endpoint resolves to an exact frozen card and a “reviewed intended
declaration/signature.” That phrase has no state separating a nonbinding signature sketch or
proposed Lean object from a reviewed and frozen exact Lean signature.

R7 lines 829–840 deliberately preserve this separation: a selected card may freeze a
source-facing mathematical target while identification, exact signature, and implementation remain
pending; an exact Lean signature freezes only after the complete natural-language proof and its
required reviews, and implementation begins only after external `lean_ready: pass`. The draft's
current wording can therefore make a conforming E0 validator reject a legitimate card-binding
record before proof review, or—worse—treat a merely “reviewed intended” signature as the exact
signature gate.

Required change: define separate endpoint states. `card-binding` should require the exact frozen
card/source-facing target while permitting a proposed declaration and nonbinding signature sketch
or an explicit pending endpoint. A later exact-signature binding must require the reviewed frozen
signature packet, and no role row or card binding may imply `lean_ready`, proof, coverage, or
completion. Add positive and negative synthetic fixtures for these two levels. Confidence: high.
Blast radius: role-endpoint schema, cardinality/state checks, and fixtures; no cards or proofs are
requested in E0.

## Affirmed contract decisions / do not refactor

- Candidate versus authority is correctly separated. Candidate lines 120–148 keep E0 enumeration
  non-authoritative, make production `Target(S4,B4.1)` partial on manual exact-bound review and
  external root selection, and limit computed targets to fixture-only synthetic witnesses.
- Source fidelity and classification are correctly placed before production partition readiness;
  entity/notation, cards, proofs, coverage, and completion remain later gates (lines 128–145).
- The exact role set and dependency direction are otherwise faithful: one ordinary mapping with a
  direct/named subtype, or the two distinct quantitative/recovery mappings, with recovery downstream
  in `Audit/SourceRecovery` (lines 161–171). Helpers receive no source credit.
- The first-slice correction boundary is sound: production IDs are immutable, unsupported
  correction types suspend only affected work, old views remain replayable, and no production row
  is edited in place (lines 109–116, 262–275).
- The external event/catalog/selection graph avoids self-hash authority and mutable-latest status:
  edges point to prior stored artifacts, catalogs exclude their own digest, and root selection is a
  later external record (lines 173–193). E0 need not automate the authoritative fold.
- The legacy companion strategy is directionally correct: separate namespaces and explicit typed
  cross-track links avoid a universal replacement of `inventory-v1.0.0` or v3 (lines 36–45).
  Exact filenames and golden manifests can remain an implementation-proposal detail once G2 fixes
  which authority each loader consumes.
- E0 is only a synthetic parser/relational contract. I do not request a production census,
  production readiness computation, global closure, support traversal, card linting, proof review,
  coverage/completion logic, CI, Pages, or Verso work. The existing manual protocol remains the
  authority path for deferred semantic and quorum checks.

## Inspected artifacts and checks

I read the complete candidate, complete accepted R7 scope, scope adjudication,
`review/PROTOCOL.md`, `review/classifications-v3.json`, the relevant loader/header/negative-test
sections of `scripts/validate_inventory.py`, and the complete `referee-lean-library` skill rubric
and workflow basis. I also inspected repository status, branches/worktrees, recent history, and ran
the skill's deterministic library inventory.

Read-only baseline commands passed:

- `python3 scripts/validate_inventory.py`: 148 occurrences, 31 notations, 32 entities, 34 entity
  evidence rows, 88 associations; exit 0.
- `python3 scripts/validate_inventory.py --negative-tests`: 25 intentionally invalid copied
  fixtures rejected; exit 0.

Observed supporting hashes:

- `review/classifications-v3.json`:
  `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`
- `scripts/validate_inventory.py`:
  `c954ce39762b160e7328846dc3740df242deb381b4d5da7995df70cd74b90a75`

No candidate file, repository file, Lean source, schema, data, card, proof, or validator was edited.
No commit, push, CI, publication, source retrieval, or Verso action was performed. This report is
only one independent review artifact and supplies no schema selection, source/classification
approval, implementation authorization, theorem/proof/coverage credit, integration acceptance, or
quorum by itself.
