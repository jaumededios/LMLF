# IMP R6 signature-guard repair session-resume checkpoint

**Checkpoint kind:** operational handoff only  
**Candidate snapshot:** `9e6e038871ac66f80534626d3deade0b27af6752`  
**Repository state:** clean, pushed, and verified private  
**Primary finding state:** `ROOT-SIG-N1: fixed_pending_rereview`

This note was prepared administratively by the primary Codex agent acting under
the user's delegated project authority. It is not a referee report,
mathematical proof, peer-review verdict, quorum record, or human review, and it
counts as zero reviewers.

## Repaired exact proposal

The candidate contains revision 2 of
`blueprint/theorem_cards/IMP-001-signatures-R6.md`, SHA-256
`0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d`.
The primary Codex agent read the full delta and independently verified that all
five embedded files are byte-identical to the repaired author harness at
`/workspace/Documents/Codex/imp-r6-negative-fix.XT854T`.

The valid `Basic`, `Bochner`, `Abel`, and `Check` file hashes are unchanged from
the frozen 8af proposal, and the positive consumer prefix is unchanged. The
repaired 307-line `Regressions` file has SHA-256
`93dff3d5c34874efad1894160a8beb7980b7431b2a473822051c19e38ba43f17`.

The author reproduced each valid guard with exit status 0. For each isolated
signature mutant, the mutant module exits 0 and its guard exits exactly 1 with
an asserted, specific `fail_if_success`-success diagnostic. The exact repaired
sources and reproduction procedure are durable in proposal revision 2.

This repair addresses the mechanism identified by `ROOT-SIG-N1`, but the
finding is only `fixed_pending_rereview`: it is not resolved, closed, or
accepted at this checkpoint.

## Unchanged candidate state

The primary Codex agent checked that all six IMP/QL/OLV card and proof files,
the historical R3 signature artifact, classification v3, production Lean
sources, and toolchain/manifest bytes remain unchanged from snapshot
`50dcded3b36e33632cf1e9734cac34c10a890d8a`.

No new source-free manifest name has been chosen. Do not add this packet to the
closed `BOOTSTRAP-0` manifest or infer a manifest or registry update from this
checkpoint.

## Local verification and CI policy

- Local `lake build`: green.
- Inventory validator negative suite: 25/25 green.
- The repaired valid guards and isolated mutants have the exact outcomes
  recorded above.

These checks are local feasibility and regression evidence only. They are not
review approval, quorum, a final-card gate, or `lean_ready`.

The GitHub workflow remains manual `workflow_dispatch` only under the current
local-testing-only policy. Do not start GitHub CI. The repository remains
private, and no GitHub run is represented by this checkpoint.

## Pending independent rereview

Two fresh Sol/xhigh reviewers are independently reviewing exact snapshot
`9e6e038871ac66f80534626d3deade0b27af6752`:

- referee C uses `/tmp/lmlf-imp-r6-sig-ref-c.N1uNlvfY` and is expected to write
  `spec-9e6e038871ac66f80534626d3deade0b27af6752/imp_r6_signature_referee_c.md`;
- referee D uses `/tmp/lmlf-imp-r6-sig-ref-d.Yo53Vbm3` and is expected to write
  `spec-9e6e038871ac66f80534626d3deade0b27af6752/imp_r6_signature_referee_d.md`.

Both are independently reconstructing the valid files and isolated mutants.
Their reports are pending: no partial report was read, and no finding, verdict,
or approval is inferred.

The prior 8af referee A/B reports, `ROOT-SIG-N1` finding, and round-one
administrative disposition are preserved as historical evidence at private
evidence commit `059c7c0`. Their approvals bind 8af only and do not transfer to
the repaired proposal.

## Remaining gates and source state

There is no production authorization, revised final card, frozen work packet,
registry/manifest authorization, external `lean_ready`, or source-fidelity gate
for this repair. No new production mathematics is introduced by the guard
repair.

The previously inspected and hash-bound private source PDF remains absent from
the current environment. New source-image work requires recovery or
reattachment; source-independent signature work may continue within its bounded
scope.

## Next safe steps

1. Wait for C and D to complete without consuming partial reports.
2. Have the primary Codex agent read and verify both completed exact-snapshot
   reports, then archive their exact bytes separately.
3. Adjudicate `ROOT-SIG-N1` against the repaired artifact and completed rereview;
   do not treat `fixed_pending_rereview` as closure or acceptance.
4. Only after repair approval, design a revised final theorem card and frozen,
   non-self-referential work packet.
5. Freeze their exact bytes in a new final-specification snapshot and obtain all
   required fresh final-specification quorums. Historical 8af approvals do not
   transfer.
6. Do not authorize production implementation or external `lean_ready` until
   every later gate is satisfied without an open change request or block.

No candidate modification, evidence commit, push, GitHub CI run, scratch Lean
archive, or PDF archive is represented by this checkpoint.
