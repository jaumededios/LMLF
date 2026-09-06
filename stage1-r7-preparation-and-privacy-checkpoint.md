# R7 preparation and repository-privacy checkpoint

Recorded by `/root` on 2026-09-06. This is an operational/preparation note,
not a referee verdict, schema approval, source review, or implementation gate.

## Frozen work

- Accepted integral core: main `b8d2f731fcfd5cd0889d0732f13699eb94681c86`,
  locally clean and still the remote main head when checked.
- Stage 1 R7 proposal: `aebe7968bd6d5dcd23ac949d5d5e0d8854334ca1`, pushed
  on `docs/stage-1-dlmf-through-10`. R7 SHA-256:
  `4964a4ad79b8e8da0cdd376836383b189c32b38eaeecd9979dfdcca8cb54b4c2`.
  Two fresh independent reviewers M and N were dispatched with requested model
  `gpt-5.6-sol`, high reasoning, no conversation fork. Their reviews are pending
  at this checkpoint; no R7 approval or operative DD-021 authority is claimed.
- Published evidence archive head:
  `d93ee57e611036436b0e725a9bb58a2fe2eaacf3`, with 210 verified manifest entries.
- The inventory validator's positive checks and all 25 negative fixtures
  passed on the R7 documentation candidate. No GitHub CI was requested by this
  task. No Verso files were edited by this task.

## Preliminary schema-design feedback

`stage1-companion-schema-design-draft-01.md`, SHA-256
`9aa892bb57f1868be20cbea0ec463b74f0104335e9733a2f3fc295fdca2b2bb3`, is
immutable, preliminary proposer preparation, not an approved implementation
contract. Root read it completely and supplied these choices/corrections:

1. Preserve frozen v1 inventory and v3 classification bytes. Add typed,
   versioned companion readers within the existing validator lineage; retain
   old one-manifest rules only for the legacy track.
2. Prefer flat normalized CSV and strict JSON for new structured external
   records. Bind exact stored UTF-8 bytes with ordinary digests; do not require
   semantic JSON canonicalization. Reject duplicate JSON keys.
3. Use explicit effective-membership manifests together with typed immutable
   decisions, rather than either a mutable latest lookup or an uncheckable
   materialized view alone.
4. Repair the draft's potential catalog/event hash cycle before freezing any
   successor: an event may reference a prior catalog/view; a post-event catalog
   may list that event's digest but excludes itself; a later external root view
   selector may bind that catalog but is not a member of the same catalog.
   Still later catalogs may include earlier selectors. The reference graph
   must remain acyclic, with no self-referential digest requirement.
5. Distinguish `prior_selection_id` from `predecessor_event_id`, particularly
   when restoring authority after suspension or withdrawal.

These are preparation instructions, not reviewed schema authority. No actual
schema, data migration, DLMF census, theorem card, or Lean work is authorized by
this note. A successor design still needs fresh exact-byte review.

## Unexpected public visibility and separate Verso deployment

GitHub reported `private: false`, `visibility: public`, and repository
`updated_at: 2026-09-06T19:18:53Z`. At the same inspection a separate Verso
commit, `1c9613ae7e079c416e884edbf216dd64e10821c3`, had triggered the workflow
`Deploy LMLF Verso site`, run `34054508954`, by push at
`2026-09-06T19:18:59Z`. The run was in progress. That commit's parent is
`3a1b16cae6d186a20530de3b883c1bb871ee76f6`; its changed files concern the
Verso documentation and `.github/workflows/pages.yml`, not this task's main
implementation head. This observation does not establish who changed
visibility or what authorization the separate task received.

To honor this task's existing private-repository/local-testing instructions,
root restored private visibility via the repository API and submitted a
cancellation request for that exact deployment run. The API confirmed private
visibility and accepted the cancellation request. At 19:24:36 UTC visibility
was still private, but the workflow still reported `in_progress`; successful
request submission is not a claim of final cancellation.

No Verso branch, workflow, or source file was changed. Root paused further
pushes, attempted to locate the separate task for coordination, and asked the
user asynchronously whether public visibility and Pages CI were newly
authorized. The public exposure duration, content accessed, and any prior
third-party access are unknown; restoring privacy cannot undo past access.
