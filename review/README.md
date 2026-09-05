# LMLF review package

This directory defines a manual proposer/referee process for formal-mathematics
changes. It supplies formats and decision rules, not an automated review service.
Filled review records must be stored outside the candidate head: for example in
a pull-request artifact or comment, a signed detached record, or a separately
addressed evidence store.

## Contents

- [`PROTOCOL.md`](PROTOCOL.md) defines roles, pre-Lean gates, external evidence,
  reviewer quorums, invalidation, dispositions, and strict merge rules.
- [`templates/work_packet.yaml`](templates/work_packet.yaml) specifies one
  bounded, possibly multi-declaration unit. It does not contain its own commit or
  digest.
- [`templates/review_envelope.yaml`](templates/review_envelope.yaml) externally
  binds the frozen packet and upstream artifacts to gate and candidate state.
- [`templates/verdict.json`](templates/verdict.json) is the output for one
  independent rubric review.
- [`templates/disposition_ledger.yaml`](templates/disposition_ledger.yaml) tracks
  findings outside the candidate head.
- [`classifications-v2.json`](classifications-v2.json) is the current frozen,
  machine-readable packet-level and target-level classification vocabulary; it
  supersedes but does not mutate `classifications-v1.yaml`.
- [`rubrics/`](rubrics/) contains focused referee instructions. Apply one rubric
  at a time.

## Manual workflow

1. Prepare theorem cards and natural-language proofs in the specification space.
   Record each artifact's revision and ordinary SHA-256 digest in a work packet.
2. Freeze the packet in a specification commit. Do not add that commit or the
   packet's own digest to the packet itself.
3. Create an external review envelope that binds `spec_commit`, packet path and
   packet digest, upstream artifacts, and the classification schema. Record
   theorem-card, natural-language-proof, and applicable structural-circularity
   reviews in external verdicts.
4. Set the envelope's `lean_ready` gate to `pass` only after its prerequisite
   pre-Lean gates, perspectives, and reviewer quorums pass. An inapplicable
   structural gate must be explicitly `not_required` with the packet reason.
   The same representation applies to an inapplicable natural-language-proof
   gate, including transparent non-novel pinned-library wrappers.
   `lean_ready` authorizes Lean work; it is not an implementation approval.
5. Implement the packet on a focused branch. At a candidate head, add the full
   base/head SHAs and reproducible evidence to the external envelope.
6. Run each required implementation rubric independently and store its JSON
   verdict outside the candidate head. Filled envelopes, verdicts, and
   disposition ledgers never become part of the candidate branch they judge.
7. Resolve findings in the external disposition ledger. Any new candidate commit
   invalidates all earlier implementation verdicts; issue fresh verdicts for the
   new SHA.
8. Merge only when every gate in `PROTOCOL.md` passes at the exact candidate head.

Templates use controlled values rather than invented placeholder enums:

- `lifecycle_state`: `draft`, `frozen`, `superseded`;
- `gate_state`: `pending`, `pass`, `fail`, `blocked`, `not_required`;
- requirement `applicability`: `required`, `not_applicable`;
- `verdict`: `approve`, `request_changes`, `block`;
- reviewer `kind`: `human`, `agent`;
- verdict `review_stage`: `pre_lean`, `implementation`;
- verdict `review_perspective`: `source_semantics`, `proof_correctness`,
  `dependency_direction`, `source_to_target_reachability`, or
  `hypothesis_and_choice_laundering`;
- reviewer `isolation_strength`: `manual_attestation`,
  `technically_enforced`;
- disposition `resolution_state`: `open`, `fixed_pending_rereview`,
  `resolved_by_fresh_approval`, `withdrawn_by_referee`, `packet_superseded`.

Replace textual `REPLACE_*` fields before use. Keep enum fields at one of their
documented values.

Candidate-owned cards, packets, proof metadata, and review summaries cannot set
authoritative `pass`, `lean_ready`, reviewer approval, or implementation
authorization.  They describe frozen scope and intrinsic proof completeness.
Only the externally stored envelope and bound verdicts establish gate state;
repository review ledgers are historical and count as zero reviewers.

Only the CSV inventory validator currently exists as executable contract
checking.  It consumes the v2 packet classification enums/examples and runs
positive and negative suites in CI.  Validation of YAML/Markdown lifecycle,
target-level card/packet joins, external bindings, and review quorums remains a
manual process specified for a future contract linter.

## Manual isolation is limited

A fresh checkout and a new agent session reduce contamination, but a manual
attestation does not prove that personal instructions, tools, credentials,
network access, or writable paths were excluded. Every verdict records the
reviewer model (if any), runtime, isolation method, and whether isolation was
manual or technically enforced. Use `technically_enforced` only when the runtime
actually provided the recorded boundaries.

Independent agent referees may use the same model. Distinct durable reviewer IDs
and fresh sessions are mandatory; model diversity is an optional strengthening
that a work packet may request.

## Attribution

This process is inspired by the public Tau Ceti separation between controlled
roadmaps, implementation, and independent rubric review. Its external artifacts
and manual workflow are an original adaptation; they neither reproduce nor claim
the hardened isolation or runner behavior of Tau Ceti Review.

- [Tau Ceti](https://github.com/TauCetiProject/TauCeti)
- [Tau Ceti Roadmap](https://github.com/TauCetiProject/TauCetiRoadmap)
- [Tau Ceti Review](https://github.com/TauCetiProject/TauCetiReview)
