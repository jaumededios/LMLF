# IMP-001 analytic-regression companion review instructions

Review only the supplemental natural-language companion bound by
`pending-envelope.yaml`, SHA-256
`fd13506194ddc37dbf8b5c5fe8e8f0380ac58981c030370b3c7909ceb53e0ba1`.
This is a fresh regression-mathematics review, not a reopening of the core
IMP-001 pre-Lean gate and not a review of current production Lean.

## Assigned reviewers and outputs

- `/root/imp_reg_nl_referee_a` starts from `referee-a.template.json`.
- `/root/imp_reg_nl_referee_b` starts from `referee-b.template.json`.

Each reviewer must preserve the template, fill a new verdict JSON, and write a
separate narrative report. Suggested immutable output names are
`IMP-001-REG-natural_language_review-imp_reg_nl_referee_a.json` plus
`imp_reg_nl_referee_a.md`, and the corresponding `_b` names.

The template is not a verdict. A null verdict, an unfilled reviewer identity,
or a report without its exact JSON binding counts as no review.

## Required isolation and inputs

Use a fresh context and an independently created detached checkout at exact
commit `9b3ad2e903bb182cafe8d7c13e7cbfe80f8538b7`. Record the actual runtime,
model, checkout, commands, and limitations. Isolation strength is
`manual_attestation`; do not claim technical sandboxing unless it was actually
enforced. Do not read the peer review or historical referee reports.

Review inputs are closed to:

1. `blueprint/proofs/IMP-001-REG.md` at revision 1 and SHA-256
   `c10dcbc498d80b98f24473a367546963c0b9d6713d99e73e21fd834ff8eedd4c`;
2. the exact bound core packet, card, R7 proof, R6-P2 signature artifact,
   classification schema, and toolchain listed in the pending envelope;
3. the immutable core lean-ready envelope and adjudication listed there;
4. pinned Mathlib sources needed to validate cited declarations; and
5. this pending envelope and these instructions.

Current production IMP code and tests are not review inputs. Ignore uncommitted
working-tree files. Do not inspect or assess QL, OLV, source-coverage, or
numerical implementations. Do not edit the candidate, run GitHub CI, commit, or
push.

## Mathematical review obligation

Independently rederive the complete companion mathematics for IMP-R04, R05,
R06, R11, the endpoint-law analytic part of R12, the nondifferentiable-example
analytic part of R13, R22, and R24. Check the R07 projection section for
consistency with the frozen core only; it is already core-covered and makes no
new Lean-authorization claim.

Confirm that:

- every global example and counterexample is exactly defined;
- convergence, divergence, measurability, interval integrability, substitutions,
  endpoint behavior, and strict inequalities are justified without hiding the
  target conclusion;
- every cited pinned Mathlib declaration exists with a usable type;
- the regression map reaches the stated nonpublic theorem content;
- no ninth public target, changed public premise, source claim, numerical scope,
  or current implementation claim is introduced; and
- R13 review is limited to its analytic nondifferentiable-example component,
  while the private `a=b` and `h=0` algebra remains core-owned.

Use verdict `approve` only if no material issue remains. Use `request_changes`
for a concrete fixable defect and `block` for a scope, trust, or mathematical
defect that prevents this companion from authorizing later regression
formalization. Record every finding with priority, exact location, evidence,
and required fix.

Each verdict counts only toward this supplemental two-review requirement. It
counts zero toward the already completed core pre-Lean quorum and grants no Lean
authorization by itself. Root adjudication remains required after both fresh
reviews complete.
