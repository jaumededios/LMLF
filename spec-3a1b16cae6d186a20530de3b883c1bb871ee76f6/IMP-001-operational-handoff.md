# IMP-001 R7 pre-Lean operational handoff

**Specification commit:** `3a1b16cae6d186a20530de3b883c1bb871ee76f6`  
**Authoritative external envelope:** `IMP-001-review-envelope-lean-ready.yaml`  
**Envelope SHA-256:** `3e4ca4b00adf36fc6b85315f74dcc4349abcd17eb6ebaf7282c374a0499a56f5`  
**Decision:** exact bounded core implementation is `lean_ready`

This is an operational handoff, not a referee report, additional gate verdict,
or human review. It counts as zero reviewers. The authoritative decision is the
hash-bound external envelope and its supporting adjudication and verdicts.

## Current state

The primary Codex agent `/root`, acting under the user's delegated project
authority, adjudicated every final pre-Lean gate `pass` and set composite
`lean_ready: pass` for exactly the eight IMP-001 targets and their private proof
support at the specification commit above. All three fresh final referees and
all seven verdicts are complete; after this archival handoff no author or
referee task is expected to remain active for the final-specification round.

Main is clean, pushed, and remotely verified at
`3a1b16cae6d186a20530de3b883c1bb871ee76f6`. The GitHub repository is private.
The evidence archive parent for the records being added is
`a92b0e70d4068036269309bb2c5f0b8d4d430f77`; that is explicitly the parent,
not the future evidence commit that will contain this handoff.

The GitHub Actions workflow remains manual `workflow_dispatch` only. The most
recent GitHub run remains historical run `34011366556`, created
`2026-09-06T04:23:14Z` at head
`f5a5a6012a2d96d45ae365999fa778d61f38e522`; no new CI run was started. User
policy remains local tests only.

Root's main-snapshot local `lake build` completed successfully in 2748 jobs.
The inventory validator passed, and its 25 negative-test fixtures were each
intentionally invalid inputs that were successfully rejected. Those 25 fixture
checks are not the packet's 25 unfinished IMP-R01 through IMP-R25 mathematical
regression obligations; every mathematical obligation remains mandatory at its
recorded stage.

Root rechecked that the main tracked files contain no production IMP module.
Candidate-owned `pending` status prose records the historical frozen
specification state and was not rewritten after external review. The new
external lean-ready envelope is authoritative for the current pre-Lean gate
state.

## Exact authorization boundary

The next authorized step is bounded production Lean implementation of the
exact eight public core targets and their private proof support. This is not
implementation acceptance or merge approval. This gate supplies no Lean
authorization for QL, OLV, new analytic examples, or the future analytic-
regression companion, and it grants no source-coverage or numerical scope.

All future new analytic examples and counterexamples first require a complete,
separately bound natural-language regression companion and at least two fresh
independent reviews before their Lean formalization. Drafting and refereeing
that companion remains an allowed separate next step under the existing project
scope; its provisional mention in the packet is not Lean authorization.

DD-020 records numerical consumption as design motivation only. It does not
authorize numerical interfaces, evaluators, certificates, algorithms, or any
production implementation beyond the exact reviewed IMP core.

The previously inspected and hash-bound source PDF remains absent. The
source-free IMP work is not blocked, but a future source-image audit requires
reattachment or recovery of the original source bytes.

Implementation must remain on an exact, reviewable candidate head, use local
tests under the manual-CI policy, and later receive every required
implementation rubric and merge adjudication. The external envelope keeps
implementation and merge gates pending.
