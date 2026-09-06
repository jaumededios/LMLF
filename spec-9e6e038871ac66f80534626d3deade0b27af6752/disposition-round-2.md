# Administrative disposition: IMP R6 signature repair round 2

**Bound snapshot:** `9e6e038871ac66f80534626d3deade0b27af6752`  
**Proposal SHA-256:** `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d`  
**Finding disposition:** `ROOT-SIG-N1: resolved_by_fresh_approval` for these repaired bytes only  
**Authority:** primary Codex adjudication under the user's delegated project authority

This is an administrative disposition, not a referee report, mathematical
proof, peer-review verdict, quorum record, or human review. It counts as zero
reviewers.

## Fresh repair review preserved

Two fresh Sol/xhigh manual-attestation reports bind the repaired snapshot:

- `imp_r6_signature_referee_c.md`, SHA-256
  `7def592798b899019a46c70022be4145960b305f2541264b7110f22caedd588d`;
- `imp_r6_signature_referee_d.md`, SHA-256
  `f54c46241d8288d51a6b74c79a2dd71d8cc4aeb53c764e9485ce38920d4547f8`.

Both independently approve the eight public target types, private T01 engine,
consumer-facing API architecture, and negative-guard repair. Each reproduces
the valid five-file harness, each valid guard with exit status 0, and each
isolated-mutant module with exit status 0 followed by its guard with exit status
exactly 1 and the asserted specific diagnostic. Both verify that parent target
types and the positive consumer prefix are unchanged.

Neither report grants final-card, external `lean_ready`, production
implementation, or source-fidelity approval. The reports are preserved in
their exact unchanged bytes.

## Primary adjudication

The primary Codex agent closes `ROOT-SIG-N1` as
`resolved_by_fresh_approval` only for snapshot
`9e6e038871ac66f80534626d3deade0b27af6752` and proposal digest
`0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d`.
This proposal is accepted only as input to final theorem-card and work-packet
design.

The original 8af finding, referee A/B reports, and round-one disposition remain
unchanged historical evidence. Their approvals do not transfer to repaired
bytes, and this resolution does not rewrite their scope.

No protocol final-card, natural-language-proof, structural, or composite gate
is declared passed without a frozen final packet. No production implementation,
registry/manifest change, external `lean_ready`, or source-fidelity gate is
authorized by this disposition.

## Architecture carried forward

- The proposal has eight public targets across three modules: `Basic` owns
  T01/T05/T08/T02/T03/T04, `Bochner` owns T07, and `Abel` owns T06.
- Sorted finite-piece recursion and anchor plumbing remain private; neither is
  exposed as public API.
- Consumer modules may import separately required pinned Mathlib modules
  directly. They must not depend on private implementation modules or
  downstream LMLF modules.
- T05 and T08 do not acquire a norm-bound field or conclusion.
- T07 retains actual integrability, not merely a value equality.

## Required next specification stage

The final theorem card must bind this exact signature digest, the unchanged
IMP-001 revision-6 proof, classification v3, and the applicable toolchain pins.
The candidate-owned card and work packet record review requirements, not
completed reviewer identities or verdicts. Completed identities and verdicts
belong in the external review envelope.

A new exact final-specification packet and external envelope must be frozen and
receive all required fresh final-specification quorums before production work.
The default template requirements—three distinct reviewers overall, two card
reviews, two natural-language-proof reviews, and one structural review—must be
verified against the actual final packet rather than assumed from earlier
rounds.

No new manifest name has been chosen. Do not expand the accepted scope of the
closed `BOOTSTRAP-0` manifest.
