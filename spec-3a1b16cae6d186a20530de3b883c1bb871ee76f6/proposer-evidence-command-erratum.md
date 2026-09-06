# Erratum: IMP-001 R7 proposer-evidence reproduction command

**Corrected record:** `proposer-evidence.md`  
**Corrected record SHA-256:** `3af2776b4b161461f7e9b72701a0b99ecccce9c4a03b730fbc0b8fb932eb0ec7`  
**Specification commit:** `3a1b16cae6d186a20530de3b883c1bb871ee76f6`

This is an administrative proposer-evidence erratum. It is not a referee
report, gate verdict, quorum record, approval, or human review, and it counts as
zero reviewers. The corrected source record remains immutable.

## Correction

The reproduction command printed in `proposer-evidence.md` was not the command
used. In particular, `/workspace/Documents/Codex/imp-r6-negative-fix.XT854T`
is not a Lake project, so the instruction to run `lake env lean` from that root
is incorrect.

Root and the author actually started in
`/workspace/Documents/Codex/2026-09-05/yo` and ran:

```sh
LMLF_FREEZE_CHECK_PATH="/workspace/Documents/Codex/imp-r6-negative-fix.XT854T:$(lake env printenv LEAN_PATH)"
env LEAN_PATH="$LMLF_FREEZE_CHECK_PATH" /home/codex/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean -R /tmp/lmlf-imp-r7-freeze-check.1lNWr1lA /tmp/lmlf-imp-r7-freeze-check.1lNWr1lA/PacketTypes.lean
```

That raw-Lean command exited 0 with 17 unused-binder style warnings. A referee
who independently reconstructs the check should substitute the referee's own
temporary harness and `PacketTypes.lean` paths while retaining the same
toolchain and `LEAN_PATH` construction.

The exact disposable source and its SHA-256 remain unchanged. The candidate,
packet, card, proof, signature, classification, dependency, and toolchain
bindings also remain unchanged. This correction grants no approval and changes
no pending gate state.
