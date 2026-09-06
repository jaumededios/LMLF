# IMP-001 implementation review input — referee A

This is a pending external review bundle for durable reviewer ID
`/root/imp_impl_referee_a`. No reviewer has been started or credited by this
file. If dispatched, use a fresh Sol context, review the candidate read-only,
and report actual model, runtime, isolation method, and limitations. Do not read
peer implementation reports or edit the candidate.

Assigned rubrics:

- `quantitative_correctness`, revision
  `1f77ffb3ac536c58875719ebae6cf9bbbcfd4fd027bd491867e0545660745062`;
- `proof_quality`, revision
  `55baddf430dc9d7530e644217630a4f0905317e2a5b7bd16126036910a22ca19`.

Review exact candidate `b8d2f731fcfd5cd0889d0732f13699eb94681c86`
against base/specification `3a1b16cae6d186a20530de3b883c1bb871ee76f6`.
Bind the immutable pending envelope
`../IMP-001-implementation-review-envelope-pending.yaml`, SHA-256
`1c7874b190ada114c60853a880b2ec2a56bbaba3fed261ccf7ad57b30e012ab7`.
The core external `lean_ready` authority remains `pass`; implementation review
and merge remain pending.

The frozen core bindings are packet `e0f16a660417d967312df0f7cc7ce12ea1243226801b409475548566d594796b`,
card `d81f8970bcba3bf1a489f8cb4fea8b303a3e3bf6d1ad3ade37b42f3094b528c4`,
core proof `941ca0f2a7e402e9dd3636d7c93744290b3f5b52b8705484c18630c6fe173548`,
signature artifact `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d`,
and classification schema `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`.
The reviewed supplemental proof is `NLP-IMP-001-REG-R2` at commit
`0f4df472dd2c97267dbc2c2128975eb3277132e0`, SHA-256
`316fc09bf3f35a5649f951ea0964ed1330e540d028a48c4706312d37c87ae7e9`,
authorized only by envelope `ee3fb545a1772eae460cfaa39ecf45b1d7d4c075461f2424577ee273dce25d9c`
and adjudication `b1b77b956d19ea8c0f741d2d7111f98b8c31e38d27b89d01cb811a3e1dbafb17`.

Inspect all eight exact public declarations, their private proof support, and
all six nonpublic test modules. Independently check all IMP-R01--R25 and the 21
card-edge obligations, exact improper/Bochner endpoint semantics, quantifier
order, totalization resistance, the Abel/Fubini calculation, analytical
examples and counterexamples, trust/axiom allowlist, and test reachability.
Source fidelity is packet-declared `not_applicable`: this is source-free
infrastructure with no source occurrence, named source object, transcription,
or coverage claim.

The proposer claims that the eight targets and six test modules compile. That
claim is untrusted and must be rerun or independently checked. A final
`imp-core-b8d2f73-acceptance-matrix.md` is still being written and is not bound
or asserted to exist by this bundle. Root may supply it later as separately
hash-bound proposer evidence; it never substitutes for independent review.

Existing proposer-only checkpoints may be consulted as untrusted support:
contract guards `55ddd5213244946644fa5e14ba9e171c04f75903a29a83670cc72c4e96f8198a`,
interim matrix `6c2b7516ebf9da74ffc9646c90d1108224032019d379c22d1d1598fa9c6cbba3`,
endpoint regressions `973cddb6759846fa1b1a3fade42e07a30e97333995bf3ef4a7cb6e877c2ac864`,
and Abel regressions `f42684d18300625756afbba705469ef2d636bb68d8723c0bd197f8f4a8633ed0`.
They earn no referee credit.

Use the two JSON templates in this directory. Replace every template verdict,
finding, isolation method, command list, inspected-file list, and timestamp
with actual review evidence. An approval has an empty findings list. Do not
start GitHub CI; all verification is local-only.

## Exact candidate file digest ledger

| Path | SHA-256 |
|---|---|
| `LMLF/Integral/Improper/Abel.lean` | `cd189f0603e61cc04c9e58d81e7601466aa74ef99464826f8352f719ba235c19` |
| `LMLF/Integral/Improper/Basic.lean` | `c4f77d2616b5e8040f9fc1aa60d5301cf5a8f37decb6bb94b520fa2ea04fe35f` |
| `LMLF/Integral/Improper/Bochner.lean` | `f3d4c4ddff91bb17a5f5e3325ff6779100e867f6fd7188a1b8a0d46c58182dcb` |
| `LMLF/Results.lean` | `03f847fb44bc1ef023b6db3fc72bb1eb0c7b593dc84cab64d9073f7caa4f0455` |
| `LMLFTest/Integral/Improper/IMP001AbelExamples.lean` | `73b7cfcd90aee475ad0ae8e4bd68e843918672be470ef13f38431ebd4a88feee` |
| `LMLFTest/Integral/Improper/IMP001EndpointAE.lean` | `313171f874e6f89b3b5ed6d6b87e4670fe3a3d22dba0eeb378790a7b9ee4dd2e` |
| `LMLFTest/Integral/Improper/IMP001GammaEndpoint.lean` | `9bcbed11516602f5685891d0228e7d73fc0c19baec149e5ee8e9895bc8333c70` |
| `LMLFTest/Integral/Improper/IMP001Oscillatory.lean` | `516e017e6b82b099f66129ba9eb309c9293301641bfb78c0d31095c662dfff71` |
| `LMLFTest/Integral/Improper/IMP001PublicUse.lean` | `ebced44ac790b40f5453946a917fdc78111f3a4814eca92d68223573901e99dd` |
| `LMLFTest/Integral/Improper/IMP001Regressions.lean` | `07ac5caa5a4620c763293a257dded3a8fe3231020a9cb4edcfe5f150e4345a22` |
| `blueprint/proofs/IMP-001-REG-R2.md` | `316fc09bf3f35a5649f951ea0964ed1330e540d028a48c4706312d37c87ae7e9` |
| `blueprint/proofs/IMP-001-REG.md` | `c10dcbc498d80b98f24473a367546963c0b9d6713d99e73e21fd834ff8eedd4c` |
| `lakefile.toml` | `4ade8caa4da73d9c13d7696bcc2f859e9261e1f29148ea31618537dc13248303` |
