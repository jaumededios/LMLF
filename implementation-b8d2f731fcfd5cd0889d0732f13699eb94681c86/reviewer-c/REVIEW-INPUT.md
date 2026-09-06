# IMP-001 implementation review input — referee C

This pending bundle allocates durable ID `/root/imp_impl_referee_c`; it does
not assert a started review or confer credit. If dispatched, use a fresh Sol
context, review the exact candidate read-only, record actual manual-isolation
limits, do not read peer implementation reports, and do not patch the candidate.

Assigned rubrics and exact revisions:

- `proof_quality`: `55baddf430dc9d7530e644217630a4f0905317e2a5b7bd16126036910a22ca19`;
- `api_dependency`: `4e5f947ed15f0101c46fe9bb0a12a013d66c7de3c7ed2c35fda817de8d92eb41`.

Review head `b8d2f731fcfd5cd0889d0732f13699eb94681c86` against base/spec
`3a1b16cae6d186a20530de3b883c1bb871ee76f6`. Bind
`../IMP-001-implementation-review-envelope-pending.yaml`, SHA-256
`1c7874b190ada114c60853a880b2ec2a56bbaba3fed261ccf7ad57b30e012ab7`.
Read that envelope for all exact upstream, pre-Lean-pass, toolchain, and
supplemental REG-R2 bindings.

Independently audit all eight exact target bodies, every private support layer,
all six nonpublic test modules, the 25 regression obligations, and all 21 edge
obligations. Check no `sorry`, `admit`, production `axiom`, unsafe shortcut, or
unapproved trust extension; rerun axiom reports; verify maintained-root and test
reachability; inspect simplification and elaboration robustness; and reconstruct
the public/private and Basic-to-sibling dependency graph. Confirm exact
signatures, absence of a ninth public target, and no downstream LMLF dependency.
Source fidelity is packet-declared `not_applicable` because the packet is
source-free and claims no source occurrence or coverage.

The claimed successful compilation is untrusted. The final proposer acceptance
matrix `imp-core-b8d2f73-acceptance-matrix.md` is still pending and deliberately
unbound. Root may later provide it by separate exact digest; it cannot replace
your own checks. Earlier guard/interim/endpoint/Abel checkpoints are likewise
proposer-only support and count zero.

Use both JSON templates in this directory and replace all template fields with
actual commands, inspected declarations, isolation method, findings, verdict,
and timestamp. Approval requires an empty findings list. Run local checks only;
do not start GitHub CI.
