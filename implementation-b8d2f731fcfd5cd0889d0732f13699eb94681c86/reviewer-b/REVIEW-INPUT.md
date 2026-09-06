# IMP-001 implementation review input — referee B

This pending bundle allocates durable ID `/root/imp_impl_referee_b`; it does
not assert that the reviewer has started and contributes no credit. If
dispatched, use a fresh Sol context, a read-only exact candidate, actual manual
isolation metadata, and no peer implementation reports or candidate edits.

Assigned rubrics and exact revisions:

- `mathlib_reuse`: `dee214f219ccb03db63194208487f6cb69777b5bc780b608b6e717b729ee901a`;
- `api_dependency`: `4e5f947ed15f0101c46fe9bb0a12a013d66c7de3c7ed2c35fda817de8d92eb41`.

Review head `b8d2f731fcfd5cd0889d0732f13699eb94681c86` against base/spec
`3a1b16cae6d186a20530de3b883c1bb871ee76f6`. Bind
`../IMP-001-implementation-review-envelope-pending.yaml`, SHA-256
`1c7874b190ada114c60853a880b2ec2a56bbaba3fed261ccf7ad57b30e012ab7`.
Read that envelope for the complete immutable packet/card/proof/signature,
classification, toolchain, pre-Lean-pass, and supplemental REG-R2 bindings.

Inspect all eight exact public declarations and every helper/import/call site
needed to assess reuse, namespace and binder shape, visibility, module layering,
the exact three production import surfaces, `LMLF/Results.lean` reachability,
test-only imports, and the absence of downstream/private leakage. Compare
against pinned Mathlib source at revision
`0df444a360eaa60ab8c11dca51a86af692955474`; similar names are not enough.
Inspect all six nonpublic test modules and all 25 regression/21 edge mappings
where they bear on API and dependency claims. Source fidelity is packet-declared
`not_applicable` for this source-free, zero-coverage infrastructure packet.

Candidate changed-file hashes are in referee A's sibling input and must be
recomputed, not trusted. The proposer says the complete implementation and test
suite compile, but supplies no final hash-bound acceptance matrix yet.
`imp-core-b8d2f73-acceptance-matrix.md` is pending and is not part of this
immutable input. Root may later supply a separately bound final proposer bundle.

The proposer-only contract-guard, interim-matrix, endpoint, and Abel checkpoints
have SHA-256 values respectively
`55ddd5213244946644fa5e14ba9e171c04f75903a29a83670cc72c4e96f8198a`,
`6c2b7516ebf9da74ffc9646c90d1108224032019d379c22d1d1598fa9c6cbba3`,
`973cddb6759846fa1b1a3fade42e07a30e97333995bf3ef4a7cb6e877c2ac864`,
and `f42684d18300625756afbba705469ef2d636bb68d8723c0bd197f8f4a8633ed0`.
They are untrusted support and earn no independent credit.

Use both JSON templates in this directory, replacing all defaults with actual
evidence. Approval requires an empty findings list. Verification is local-only;
do not invoke GitHub CI.
