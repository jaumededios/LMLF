# IMP-001 R2 analytic-regression companion review instructions

Review only the supplemental natural-language companion bound by
`pending-envelope.yaml`, SHA-256
`701b26b3ce0daa1c67183fd38c72f610190a4016966be1894e1eaf1face41f00`.
This is a fresh, full R2 regression-mathematics review. It is not a reopening of
the core IMP-001 pre-Lean gate and not a review of current production Lean.

## Assigned reviewers and outputs

- `/root/imp_reg_nl_referee_c` starts from `referee-c.template.json`.
- `/root/imp_reg_nl_referee_d` starts from `referee-d.template.json`.

Each reviewer must preserve the template, fill a new verdict JSON, and write a
separate narrative report. Suggested output names are
`IMP-001-REG-R2-natural_language_review-imp_reg_nl_referee_c.json` plus
`imp_reg_nl_referee_c.md`, and the corresponding `_d` names.

The template is not a verdict. A null verdict, unfilled reviewer identity, or
report without its exact JSON binding counts as no review.

## Required isolation and inputs

Use a fresh context and an independently created detached checkout at exact
commit `0f4df472dd2c97267dbc2c2128975eb3277132e0`. Record the actual runtime,
model, checkout, commands, and limitations. Isolation strength is
`manual_attestation`; do not claim technical sandboxing unless it was actually
enforced. Do not read the peer review, the R1 referee reports or verdicts, or
other historical reviews. No R1 approval or investigation is inherited.

Review inputs are closed to:

1. `blueprint/proofs/IMP-001-REG-R2.md` at revision 2 and SHA-256
   `316fc09bf3f35a5649f951ea0964ed1330e540d028a48c4706312d37c87ae7e9`;
2. the exact bound core packet, card, R7 proof, R6-P2 signature artifact,
   classification schema, and toolchain listed in the pending envelope;
3. the immutable core lean-ready envelope and adjudication listed there;
4. pinned Mathlib sources needed to validate every cited declaration; and
5. this pending envelope and these instructions.

The R1 artifact and disposition are bound only as administrative lineage and
are not mathematical review inputs. Current production IMP code and tests are
not inputs. Ignore uncommitted working-tree files. Do not inspect or assess QL,
OLV, source-coverage, or numerical implementations. Do not edit the candidate,
run GitHub CI, commit, or push.

## Mathematical review obligation

Independently review the full R2 mathematics and pinned APIs for IMP-R04, R05,
R06, R11, the endpoint-law analytic part of R12, the nondifferentiable-example
analytic part of R13, R22, and R24. Check the R07 projection section for
consistency with the frozen core only; it is already core-covered and makes no
new Lean-authorization claim.

Confirm that:

- every global example and counterexample is exactly defined;
- convergence, divergence, measurability, interval integrability, substitutions,
  endpoint behavior, and strict inequalities are justified without hiding the
  target conclusion;
- the corrected local-continuity substitution theorem and its complete
  side-condition ledger match the exact pinned Mathlib APIs for both
  orientations and absolute-value uses;
- every other cited pinned declaration exists with a usable type;
- the regression map reaches the stated nonpublic theorem content;
- no ninth public target, changed public premise, source claim, numerical scope,
  or current implementation claim is introduced; and
- R13 review is limited to its analytic nondifferentiable-example component,
  while the private `a=b` and `h=0` algebra remains core-owned.

Use verdict `approve` only if no material issue remains. Use `request_changes`
for a concrete fixable defect and `block` for a scope, trust, or mathematical
defect that prevents R2 from authorizing later regression formalization. Record
every finding with priority, exact location, evidence, and required fix.

Each verdict counts only toward this R2 supplemental two-review requirement. It
counts zero toward the completed core pre-Lean quorum and grants no Lean
authorization by itself. Root adjudication remains required after both fresh
reviews complete.
