# IMP-001 implementation and merge adjudication

**Decision:** `pass` for implementation review and merge  
**Exact candidate head:** `b8d2f731fcfd5cd0889d0732f13699eb94681c86`  
**Exact base/specification:** `3a1b16cae6d186a20530de3b883c1bb871ee76f6`

This is the decision of the primary Codex agent `/root`, acting under authority
explicitly delegated by the user, transcribed into external evidence. The
transcriber and adjudicator earn zero referee credit. This is not human review
or a seventh rubric verdict.

## Frozen authority

- Pending implementation envelope:
  `IMP-001-implementation-review-envelope-pending.yaml`, SHA-256
  `1c7874b190ada114c60853a880b2ec2a56bbaba3fed261ccf7ad57b30e012ab7`.
- Core passing pre-Lean envelope: `IMP-001-review-envelope-lean-ready.yaml`,
  SHA-256
  `3e4ca4b00adf36fc6b85315f74dcc4349abcd17eb6ebaf7282c374a0499a56f5`.
- Frozen work packet: `review/work_packets/IMP-001.yaml`, SHA-256
  `e0f16a660417d967312df0f7cc7ce12ea1243226801b409475548566d594796b`.
- Theorem card `TC-IMP-001-R7`, SHA-256
  `d81f8970bcba3bf1a489f8cb4fea8b303a3e3bf6d1ad3ade37b42f3094b528c4`.
- Core proof `NLP-IMP-001-R7`, SHA-256
  `941ca0f2a7e402e9dd3636d7c93744290b3f5b52b8705484c18630c6fe173548`.
- Signature artifact `SIG-IMP-001-R6-P2`, SHA-256
  `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d`.
- Classification schema v3, SHA-256
  `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`.
- Supplemental proof `NLP-IMP-001-REG-R2` at commit
  `0f4df472dd2c97267dbc2c2128975eb3277132e0`, SHA-256
  `316fc09bf3f35a5649f951ea0964ed1330e540d028a48c4706312d37c87ae7e9`;
  passing supplemental envelope SHA-256
  `ee3fb545a1772eae460cfaa39ecf45b1d7d4c075461f2424577ee273dce25d9c`
  and root adjudication SHA-256
  `b1b77b956d19ea8c0f741d2d7111f98b8c31e38d27b89d01cb811a3e1dbafb17`.
- Lean toolchain `leanprover/lean4:v4.33.1`, Mathlib revision
  `0df444a360eaa60ab8c11dca51a86af692955474`, and `lake-manifest.json`
  SHA-256 `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`.

The original core and supplemental pre-Lean gates remain exact immutable
authority. No card, target, premise, source, classification, or dependency pin
is amended by this decision.

## Independent implementation-review quorum

| Reviewer | Report SHA-256 | Approved rubric verdicts |
|---|---|---|
| `/root/imp_impl_referee_a` | `832b379546bf252507ee9a7b352c52dc63f676ae48abbfeb9ae03b0c847a2566` | quantitative correctness `182dcff935b82253a3b5d6ee3178da9f43a4097ae6bd9592f90cbb1defbe60f0`; proof quality `1674552c5fac63cf88d101c766682806ab3211a95253f4b30c2e1f4fdf6ae3b4` |
| `/root/imp_impl_referee_b` | `22cd053df8fa122cefe4b2684a13260abc4cc0ee1b6a1099cf26ffde2aff25c8` | Mathlib reuse `1234a53e8626e79fc334604bc58c2dcf34062519c75e4e71454f1e72747a43df`; API/dependency `d76babfb7d9bdb12f73dbc3c9297a25aca179b09c3d9a9120ca3f3b9bb4473ba` |
| `/root/imp_impl_referee_c` | `0a11bc596fc76e7e8bbad8cbbc3b0797d65e7c9230e66a9f31bde1d9193e86d7` | proof quality `1d38b4ef5a970e51bb350572137307d4b8c9c83ecfea1bccaf68e54db5092adc`; API/dependency `ca375b304b0a025b6fdb047a335aaa84dd68180d737474aebc153acb26b1b33b` |

All six verdicts are `approve` with empty findings. The union contains exactly
three distinct fresh agent reviewer IDs. The designated one-agent rubric
quorum is quantitative correctness by A, Mathlib reuse by B, API/dependency by
B, and proof quality by C; its union is A/B/C. API/dependency approval by C and
proof-quality approval by A are additional supporting verdicts, not a selected
two-agent rubric composition. This satisfies the frozen three-ID overall
quorum and the allowed exact `0` human/`1` agent composition for every required
rubric. Source fidelity is `not_applicable`/`not_required` because
IMP-001 is source-free reusable infrastructure with no DLMF or Olver source
occurrence, named source object, transcription, or coverage claim.

Referee A's signed correction
`imp_impl_referee_a-t02-correction-01.md`, SHA-256
`30287d616bf7d6e76c72b91d97a74f2dab18b1ad0e8055fe75c6774f68c6a76c`,
supersedes one false sentence in A's narrative. The implementation of T02 uses
direct canonical-component uniqueness in `Basic.lean:773-918`, not T08 or T05.
Root independently confirmed that route, and referees B and C independently
confirmed the direct route. The correction changes no candidate byte, creates
no finding or verdict, and supplies no additional reviewer credit.

The empty disposition ledger is
`IMP-001-implementation-disposition.yaml`, SHA-256
`da2779971d1f4482195d3305d1fc0a60a574133038a20a838f08ff1232aea197`.

## Candidate and acceptance evidence

| Candidate path | SHA-256 |
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

The final proposer acceptance matrix has SHA-256
`4852ace739c8dea0e2176004e6679b4c3aa968bd8143ed76794f099b87a11a63`.
The exact public API probe has SHA-256
`6b3aa43462802151d3bc88c4f0fdf515b0459eab110511a1ec8304cb62bfeaad`;
the private-name rejection probe has SHA-256
`bb95d0f333d29660b3bc99e76b326ed846e7531589e047d81010116e0bf70a83`.

Root independently reran the full local build: exit 0, 2766 jobs, no errors,
with only eight intentional `#check` informational lines. Root also confirmed
the public and headline regression axiom reports contain only `propext`,
`Classical.choice`, and `Quot.sound`. The three referees independently ran their
own builds, probes, validator checks, source inspections, and applicable pinned
Mathlib audits. Together with the exact matrix, the evidence establishes all
IMP-R01--IMP-R25 obligations and all 21 card-edge obligations at this head.

## Decision and execution condition

Root sets the implementation-review gate and merge gate to `pass` for exactly
candidate `b8d2f731fcfd5cd0889d0732f13699eb94681c86` over exact base
`3a1b16cae6d186a20530de3b883c1bb871ee76f6`.

Execution is authorized only if main is still clean at that exact base and the
candidate head, every candidate byte listed above, the frozen specification,
pre-Lean authorities, classification schema, Lean toolchain, and Mathlib pin
remain unchanged. Any new head or material mismatch invalidates these
implementation verdicts and this merge decision. This record authorizes no
source amendment, DLMF/Olver source coverage, QL/OLV implementation, numerical
scope, or different candidate.
