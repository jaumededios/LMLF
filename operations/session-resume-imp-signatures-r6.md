# IMP R6 exact-signature session-resume checkpoint

**Checkpoint kind:** operational handoff only  
**Candidate snapshot:** `8af103fee3b2000033fc1e8c684645e529aaa841`  
**Recorded state:** clean and pushed to the private `jaumededios/LMLF` repository; repository privacy was independently verified by the primary Codex agent

This note was prepared administratively by a Codex agent under the user's
delegated project authority. It is not a referee report, verdict, review
envelope, quorum record, final specification, or authorization, and it counts
as zero reviewers.

## Exact-signature proposal state

The exact candidate snapshot adds
`blueprint/theorem_cards/IMP-001-signatures-R6.md`, a 971-line proposal with
SHA-256
`4b2b6f73a8a92c6b48e88e6ca7b3c1d252ed877f4df33257306c10cbab679ab0`.
It embeds all five exact disposable-harness source files and their reproduction
commands. The primary Codex agent independently verified that the embedded
sources are byte-identical to the signature author's harness.

The harness has two actual definitions and six temporary theorem axioms,
covering eight targets across three modules. Its consumer proofs are genuine
proofs conditional on those stub axioms; they are not implementations of the
six proposed theorem bodies. The proposal and harness were prepared by
`imp_r6_signature_author`.

The six prior card/proof artifacts remain byte-identical:

| Artifact | SHA-256 |
|---|---|
| `blueprint/theorem_cards/IMP-001.yaml` | `97e7af6b5d1919b45fef90dfea5cb86b1f041d26c447c51852271ad04fdd75a0` |
| `blueprint/proofs/IMP-001.md` | `88f60d501c4261cba37b5d1f320406c258bde785ed3912720b3be897d6424f0e` |
| `blueprint/theorem_cards/QL-001.yaml` | `176dd5661eca3ef6c348a1557cf121e46921131c279a7f64846f78a8eef399e0` |
| `blueprint/proofs/QL-001.md` | `0e10900131fce62f2ed0256d4c0844ff6fb8b7a570fa25cf4ac4a05c33ea7116` |
| `blueprint/theorem_cards/OLV-001.yaml` | `442004db665f0f4eb20f7bac5708a50dc377566356841c2be2f0389d75a4bf1b` |
| `blueprint/proofs/OLV-001.md` | `40e31aab68f1f065598ea3b7ea5a46616bb84f2ab44b1ca49632be523ed9ff0f` |

The superseded historical R3 signature artifact remains unchanged with
SHA-256
`454dc16dbe924d895d723aba90c0f280baaa6496a3dbf0e4083d0804775191f8`.
Classification v3 remains unchanged at
`975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`,
and classification v2 remains frozen historical evidence. The candidate
`lake-manifest.json` remains unchanged at
`4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`.

## Local verification and CI policy

The primary Codex agent locally verified:

- `lake build`: green;
- inventory validator with `--negative-tests`: 25/25 green; and
- inventory count: 148 occurrences.

These checks show local consistency and conditional elaboration only. They are
not referee approval, theorem proof, final-card approval, `lean_ready`, or
production authorization.

No GitHub run was started. Commit
`20a99e5adb484d45190679147100639ff1308af5` left the workflow manual
`workflow_dispatch` only, and current user policy is local testing only: do not
start GitHub CI. GitHub confirms the repository remains private and its last
run remains the f5a5a6 run from before that policy.

## Active independent review

Two fresh Sol/xhigh, fork-none exact-signature referees are independently
reviewing exact snapshot `8af103fee3b2000033fc1e8c684645e529aaa841`:

- referee A is expected to write
  `spec-8af103fee3b2000033fc1e8c684645e529aaa841/imp_r6_signature_referee_a.md`
  and uses `/tmp/lmlf-imp-r6-sig-ref-a.wAmi8yzk`;
- referee B is expected to write
  `spec-8af103fee3b2000033fc1e8c684645e529aaa841/imp_r6_signature_referee_b.md`
  and uses `/tmp/lmlf-imp-r6-sig-ref-b.GjES8xdz`.

Both reconstruct their own harness and make no candidate writes. Their reports
are pending at this checkpoint: no partial report was inspected, and no verdict
or approval is inferred or counted.

## Missing gates and source state

No final theorem card, frozen work packet, registry or manifest authorization,
external `lean_ready` authorization, production implementation, or final
source-fidelity gate exists for this proposal.

The previously inspected and hash-bound private source PDF is absent from the
current environment. New source-image audits require recovery or reattachment;
source-independent signature and IMP/QL work may continue within their existing
scope.

## Next safe steps

1. Wait for both exact-signature referees to finish. Do not consume partial
   reports or infer a result from their progress.
2. After the primary Codex agent reads and verifies completed reports, archive
   only their exact bytes and record any administrative disposition separately.
3. Adjudicate the signature proposal against those exact-snapshot findings.
4. If the proposal is accepted, create a revised final theorem card and a
   frozen, non-self-referential work packet binding the exact signatures,
   cards, unchanged proof digests, classification-v3 digest, dependencies,
   regressions, and review requirements.
5. Create an external envelope for the resulting exact final-specification
   commit and obtain fresh final-card/signature and API/dependency gates. Older
   approvals remain historical and do not automatically transfer to changed
   card, signature, packet, envelope, registry, or manifest bytes.
6. Do not authorize production implementation or set external `lean_ready`
   until every final-specification gate and distinct-reviewer requirement has
   passed without a current change request or block.

No candidate modification, commit, push, GitHub CI run, scratch Lean archive,
or PDF archive is represented by this checkpoint.
