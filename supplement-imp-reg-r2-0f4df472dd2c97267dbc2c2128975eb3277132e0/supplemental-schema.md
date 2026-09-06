# Supplemental regression-review schema 1: R2 instance

This external schema is a narrow extension used because the core schema-3
envelope and schema-4 verdict cannot express a later regression-only proof
review without making it look like the core natural-language gate was replaced
or reopened. It implements only the `later_mathematical_regression_authorization`
clause of the frozen IMP-001 packet.

## Envelope requirements

`pending-envelope.yaml` must contain:

- the supplemental schema version and record kind, stable R2 supplement ID,
  parent work-item ID, lifecycle state, and explicit extension purpose;
- exact core commit, packet, card, core proof, signature, classification,
  toolchain, passing-envelope, and core-adjudication bindings;
- exact R2 commit, path, artifact ID, revision, digest, empty target bindings,
  and false public-target/public-premise change flags;
- the R1 artifact and changes-required disposition only as administrative
  lineage, with no verdict inheritance or quorum credit;
- the closed regression list and partial-scope qualifications for R07, R12,
  and R13;
- explicit exclusion of production Lean and explicit non-effects on core gates,
  source coverage, and numerical scope;
- a pending two-distinct-reviewer requirement with historical, predecessor,
  core, proposer, and adjudicator credit excluded; and
- pending root adjudication and false formalization authorization.

The pending envelope becomes immutable once referees are dispatched. A passing
successor may bind its digest and the completed R2 verdicts; it must not edit or
replace this pending envelope.

## Verdict requirements

A filled verdict must retain every `review_identity` binding from its template,
set `template_state` to `filled`, and record:

- the allocated durable reviewer ID and actual agent model/runtime;
- `manual_attestation`, actual isolation method, and limitations;
- independence from the proposer, read-only candidate treatment, and no peer,
  predecessor, or historical report context;
- rubric `mathematical_correctness` and perspective
  `analytic_regression_proof_correctness`;
- one of `approve`, `request_changes`, or `block`;
- inspected files, rerun commands, pinned-source checks, summary, findings, and
  an UTC issuance time; and
- `counts_toward_core_prelean_quorum: false` and
  `authorization_effect: none_without_root_adjudication` unchanged.

## Quorum and closed world

Exactly two fresh distinct reviewer IDs are required. The allocated composition
is 0 humans and 2 agents, with at least one distinct agent model. Same-model
fresh sessions are permitted. Each referee must work without peer or R1-review
context. Historical and predecessor reviewers, core-gate reviewers, the
proposer, root adjudicator, and evidence archiver count zero.

Only artifacts enumerated as review inputs in the pending envelope are usable.
Production code, uncommitted files, peer/predecessor/historical reports, and
downstream project areas are outside this review. Approval can support only a
later root decision about nonpublic Lean formalization of the reviewed R2
analytic regressions; it cannot change core `lean_ready` or authorize any public
target, source, numerical, QL, or OLV scope.
