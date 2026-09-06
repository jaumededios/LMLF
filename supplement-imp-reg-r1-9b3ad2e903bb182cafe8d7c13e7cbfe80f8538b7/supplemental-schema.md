# Supplemental regression-review schema 1

This external schema is a narrow extension used because the core schema-3
envelope and schema-4 verdict cannot express a later regression-only proof
review without making it look like the core natural-language gate was replaced
or reopened. It implements only the `later_mathematical_regression_authorization`
clause of the frozen IMP-001 packet.

## Envelope requirements

`pending-envelope.yaml` must contain:

- `schema_version: 1`, the supplemental record kind, stable supplement and
  parent work-item IDs, and an explicit extension purpose;
- exact core commit, packet, card, core proof, signature, classification,
  toolchain, core passing-envelope, and core adjudication bindings;
- exact companion commit, path, artifact ID, revision, digest, empty target
  bindings, and false public-target/public-premise change flags;
- the closed regression list and the partial-scope qualifications for R07, R12,
  and R13;
- explicit exclusion of production Lean and explicit non-effects on core gates,
  source coverage, and numerical scope;
- a pending two-distinct-reviewer requirement with historical, core, proposer,
  and adjudicator credit excluded; and
- pending root adjudication and false formalization authorization.

The pending envelope becomes immutable once referees are dispatched. A passing
successor may bind its digest and the completed verdicts; it must not edit or
replace the pending envelope.

## Verdict requirements

A filled verdict must retain every `review_identity` binding from its template,
set `template_state` to `filled`, and record:

- the allocated durable reviewer ID and actual agent model/runtime;
- `manual_attestation` plus the actual isolation method and limitations;
- independence from the proposer, read-only candidate treatment, and no peer
  report context;
- rubric `mathematical_correctness` and perspective
  `analytic_regression_proof_correctness`;
- one of `approve`, `request_changes`, or `block`;
- inspected files, rerun commands, source checks, summary, findings, and an UTC
  issuance time; and
- `counts_toward_core_prelean_quorum: false` and
  `authorization_effect: none_without_root_adjudication` unchanged.

## Quorum and closed world

Exactly two fresh distinct reviewer IDs are required. The allocated composition
is 0 humans and 2 agents, with at least one distinct agent model. Same-model
fresh sessions are permitted. Each referee must work without peer-report
context. Historical reviewers, core-gate reviewers, the proposer, root
adjudicator, and evidence archiver count zero.

Only artifacts enumerated in the pending envelope are review inputs. Production
code, uncommitted files, peer or historical reports, and downstream project
areas are outside this supplemental review. Approval can support only a later
root decision about nonpublic Lean formalization of the reviewed analytic
regressions; it cannot change the core `lean_ready` state or authorize any
public target, source, numerical, QL, or OLV scope.
