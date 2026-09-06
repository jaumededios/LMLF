# IMP-001 R2 analytic-regression supplemental adjudication

**Decision authority:** primary Codex agent `/root`, acting under the user's delegated project authority  
**Supplement:** `IMP-001-REG-R2`  
**Companion commit:** `0f4df472dd2c97267dbc2c2128975eb3277132e0`  
**Companion SHA-256:** `316fc09bf3f35a5649f951ea0964ed1330e540d028a48c4706312d37c87ae7e9`  
**Pending envelope SHA-256:** `701b26b3ce0daa1c67183fd38c72f610190a4016966be1894e1eaf1face41f00`  
**Decision:** supplemental regression natural-language gate `pass`; bounded formalization authorization `true`

This is the primary agent's administrative adjudication, transcribed under the
user's explicit delegation. It is not an independent referee report or human
review and counts as zero reviewers. It neither changes nor replaces the core
IMP-001 pre-Lean authority.

## Exact core and companion binding

The pending envelope binds the unchanged core specification commit
`3a1b16cae6d186a20530de3b883c1bb871ee76f6` and these exact identities:

| Bound item | Revision | SHA-256 or exact value |
|---|---:|---|
| `review/work_packets/IMP-001.yaml` | 1 | `e0f16a660417d967312df0f7cc7ce12ea1243226801b409475548566d594796b` |
| `blueprint/theorem_cards/IMP-001.yaml` / `TC-IMP-001-R7` | 7 | `d81f8970bcba3bf1a489f8cb4fea8b303a3e3bf6d1ad3ade37b42f3094b528c4` |
| `blueprint/proofs/IMP-001-R7.md` / `NLP-IMP-001-R7` | 7 | `941ca0f2a7e402e9dd3636d7c93744290b3f5b52b8705484c18630c6fe173548` |
| `blueprint/theorem_cards/IMP-001-signatures-R6.md` / `SIG-IMP-001-R6-P2` | 2 | `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d` |
| `review/classifications-v3.json` | 3 | `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e` |
| Core lean-ready envelope | — | `3e4ca4b00adf36fc6b85315f74dcc4349abcd17eb6ebaf7282c374a0499a56f5` |
| Core pre-Lean adjudication | — | `ee625aeea238a1e6c87c7d715372860c23a109d9852588e3f5847aef96017be3` |
| Lean toolchain | — | `leanprover/lean4:v4.33.1` |
| Resolved Mathlib revision | — | `0df444a360eaa60ab8c11dca51a86af692955474` |
| `lake-manifest.json` | — | `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404` |

The reviewed companion is `blueprint/proofs/IMP-001-REG-R2.md`, artifact
`NLP-IMP-001-REG-R2`, revision 2, at the exact commit and digest stated above.
It has no public target binding and changes no public target or premise.

## Exact fresh review evidence

| Reviewer | Artifact | SHA-256 | Result |
|---|---|---|---|
| `/root/imp_reg_nl_referee_c` | `imp_reg_nl_referee_c.md` | `852b9f408946b7b53d5f7793e67d7872f6fb32f31f20869a13f161211a8b0439` | report supporting approval |
| `/root/imp_reg_nl_referee_c` | `IMP-001-REG-R2-natural_language_review-imp_reg_nl_referee_c.json` | `48a36b67d7acfbd6f6ccbbccb490779c250149afd9b1d195605d834b3726d42e` | `approve`; no findings |
| `/root/imp_reg_nl_referee_d` | `imp_reg_nl_referee_d.md` | `e0fcf6d82f483ced496a7fc5a2070bbecd3048845a391e643450fa6a35ea38b6` | report supporting approval |
| `/root/imp_reg_nl_referee_d` | `IMP-001-REG-R2-natural_language_review-imp_reg_nl_referee_d.json` | `eac147c1fe49bfd8751b310df60502b28baf0036856049b5858b2f665de9b7b7` | `approve`; no findings |

Both verdicts retain the exact `review_identity` object from their immutable
templates. They bind the same pending envelope, core identities, companion
commit and digest, pinned toolchain and Mathlib revision, and regression-only
scope. Both reviewers are fresh, distinct `gpt-5.6-sol` agent identities using
`manual_attestation`; each records no peer or predecessor report access.

The selected supplemental composition is 0 humans and 2 agents with at least
one distinct agent model. No predecessor, historical, core-gate, proposer,
root-adjudicator, or evidence-archiver credit is used. The two fresh verdicts
satisfy the frozen supplemental minimum of two distinct reviewer IDs.

## Root decision and exact authorization scope

The primary agent accepts both no-finding approval verdicts and adjudicates the
R2 supplemental regression natural-language gate `pass`. Formalization is
authorized only for nonpublic analytic regression content supplied by R2 for:

- IMP-R04, IMP-R05, IMP-R06, and IMP-R11;
- the analytic endpoint-law component of IMP-R12;
- the nondifferentiable interval-indicator component of IMP-R13;
- IMP-R22; and
- IMP-R24.

IMP-R07 is already covered by the core type/projection argument and receives no
new authorization or scope from this decision. The eight core public targets,
their premises, and the existing core `lean_ready` pass remain unchanged.

This supplemental pass is a hard pre-code gate for the listed new analytic
regressions, but it is not an implementation acceptance, implementation-review
verdict, merge approval, public-API expansion, source-coverage claim, numerical
authorization, or QL/OLV authorization. Any resulting nonpublic Lean code must
still match the reviewed mathematics and pass its applicable implementation and
acceptance checks. Unlisted IMP regression obligations retain their frozen
packet status.

R1 remains immutable historical changes-required evidence. Its reports and
verdicts count zero here, and no R1 approval or investigation was inherited.
