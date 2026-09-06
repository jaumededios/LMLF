# BOOTSTRAP-0 publication evidence: QB-001 and DEF-001

This issue records the detached review evidence authorizing publication of the exact reviewed commit for [jaumededios/LMLF](https://github.com/jaumededios/LMLF). It is an evidence index, not a claim of Olver source coverage.

## Exact binding and decision

- Frozen specification/base: [`1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9`](https://github.com/jaumededios/LMLF/commit/1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9)
- Reviewed and publication-authorized head: [`515b742f7ad5472c17cfdf0fda7cbc83c5585da1`](https://github.com/jaumededios/LMLF/commit/515b742f7ad5472c17cfdf0fda7cbc83c5585da1)
- Rejected predecessor: [`3dbfcc8ef8a2b2c9b721bbf8570493a112b413f6`](https://github.com/jaumededios/LMLF/commit/3dbfcc8ef8a2b2c9b721bbf8570493a112b413f6)
- Candidate tree: `1d7c671375da286295467428bf563b876dd1dc73`
- Deterministic candidate archive SHA-256: `707662db3b03778cf4c7208e81a17c56140fcb2616796ccbbfb6114ea90801f4`
- Base-to-head full-index diff SHA-256: `4e08f221bf3a162e90ff3c4007fb1a061f575dac1a095492357c54dbf5d7b102`
- Toolchain: Lean `4.33.1` via `leanprover/lean4:v4.33.1`, compiler commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`
- Resolved Mathlib revision: `0df444a360eaa60ab8c11dca51a86af692955474`
- Final adjudication: both implementation-review gates and the exact-head merge gate are `pass`; no material finding remains open.

Any new commit invalidates this implementation authorization and requires fresh candidate-bound review.

## Reviewed surface: 12 semantic declarations and 9 audit declarations

QB-001 contributes eight semantic declarations:

1. `QuantitativeAnalysis.ErrorOn`
2. `QuantitativeAnalysis.NormBoundOn`
3. `QuantitativeAnalysis.HasErrorFamily`
4. `QuantitativeAnalysis.ErrorOn.exact`
5. `QuantitativeAnalysis.ErrorOn.restrict`
6. `QuantitativeAnalysis.ErrorOn.weaken`
7. `QuantitativeAnalysis.ErrorOn.trans`
8. `QuantitativeAnalysis.ErrorOn.comp`

DEF-001 contributes four semantic declarations:

1. `LMLF.Definitions.gamma_eulerIntegrable`
2. `LMLF.Definitions.gamma_eq_eulerIntegral`
3. `LMLF.Definitions.gamma_ofReal`
4. `LMLF.Definitions.gamma_neg_nat_eq_zero`

The separately built, downstream-only audit surface contains nine declarations:

- `LMLFTest.QB001.emptyDomain`
- `LMLFTest.QB001.exactZero`
- `LMLFTest.QB001.transSum`
- `LMLFTest.Definitions.Gamma.eulerIntegrable`
- `LMLFTest.Definitions.Gamma.eulerFormula`
- `LMLFTest.Definitions.Gamma.eulerAtOne`
- `LMLFTest.Definitions.Gamma.realAgreement`
- `LMLFTest.Definitions.Gamma.conjugation`
- `LMLFTest.Definitions.Gamma.poleTotalization`

The audit module consumes the semantic modules and is not imported by the semantic library root.

## Pre-Lean authorization evidence

Two distinct external reviewers approved the applicable pre-Lean gates. QB-001 has theorem-card `pass`, natural-language-proof `pass`, structural-circularity `not_required`, and composite `lean_ready: pass`. DEF-001 has theorem-card `pass`, natural-language-proof `not_required`, structural-circularity `not_required`, and composite `lean_ready: pass`.

All hashes below are ordinary SHA-256 digests of the detached artifact bytes.

| Artifact | SHA-256 |
|---|---|
| `prelean_green_k.md` | `a537ee0cf5f04ccacb475877c1e2443c9f2e3cded91ada44bd07ced4aa411fa4` |
| `prelean_green_l.md` | `7a616cb60f7e20dc398e60f206ab1db8ad56e7bb26e26b7271ae36191b9da1f0` |
| pre-Lean `QB-001-review-envelope.yaml` | `dbcf16abb033bfc87f353b75125470788c92b28580bf52ffc125bcf0d0a7562a` |
| pre-Lean `DEF-001-review-envelope.yaml` | `1cb983db8cb2affdab0d3628df5bcc61ea92006d3739edfa26a9ab5e69c89acf` |
| `prelean_authorization.md` | `f30686bd60e672f46a607d470f697ffa279944d8203d82a881dafe742c546194` |

## Proposer evidence and predecessor disposition

- Current proposer report `bootstrap_implementer.md`: `2fe11b62dca1a5994df3d3847097401a1dd9591651d4a5a54996643c95717aef`
- Predecessor disposition `predecessor_disposition.md`: `0d8689d1e8034d741591c2e980733805ce8294e58ff624bf57e1fde0275ad5f2`
- Rejected predecessor report `impl_review_m.md`: `5fb14c7d231e42b4c7bc0e88e524d60ac4f59b8a0b91eda095b368c44ee39faf`
- Rejected DEF source-fidelity verdict `DEF-001-source_fidelity-impl_review_m.json`: `782ad40feae664c72e5d4d01fbed2ec7a67e9c9262de51aa8eed73776d1e673c`
- Rejected DEF proof-quality verdict `DEF-001-proof_quality-impl_review_m.json`: `0dd92988e32127c6d2a2d0c4b9914179958461a9f98cf0bb3882d02034f82e0f`

The predecessor finding `M1` (P2) identified that `LMLFTest.Definitions.Gamma.eulerAtOne` bypassed the public `LMLF.Definitions.gamma_eq_eulerIntegral` wrapper. The superseding commit changes only `LMLF/Audit/Definitions.lean`; the repaired proof uses that public wrapper and `Complex.GammaIntegral_one`. Three fresh exact-head reviewers independently confirmed the repair, so the final external disposition is `resolved_by_fresh_approval`, not merely `fixed_pending_rereview`.

## Fresh implementation review

The distinct reviewer union is `/root/impl_final_p`, `/root/impl_final_q`, and `/root/impl_final_r`. Each was an independent fresh-session agent using `gpt-5.6-sol`, manual isolation attestation, and read-only disposable Git archives. All 24 candidate-bound structured verdicts are `approve` with empty findings. Each packet meets its overall minimum of three distinct reviewer IDs and every per-rubric minimum and allowed composition. The narratives also confirm the packet-level N/A rubrics: QB-001 `source_fidelity` and DEF-001 `quantitative_correctness`.

Narrative digests:

| Artifact | SHA-256 |
|---|---|
| `impl_final_p.md` | `7a151cb388222bbcb7fd7af4f87c134f79a066bd70207194e968c888320e588e` |
| `impl_final_q.md` | `f0e3980e32d1bbdefda9b27b5595bc159f5a9a8e202c2627f4c72303ad74f0d6` |
| `impl_final_r.md` | `8a249ffd749b00830f3db8874a2831cfe29cf9a75766b6834790c954def9126c` |

Structured verdict digests:

| Verdict artifact | SHA-256 |
|---|---|
| `QB-001-quantitative_correctness-impl_final_p.json` | `eb647f4edd5d5bbf8b84e4df6fce6899794a745ecb5d24dd2561992929d8d4ca` |
| `QB-001-quantitative_correctness-impl_final_q.json` | `9faf1c6b156efdaba64e16f3d850d274509421bb479acf0902413f79e7d31b7b` |
| `QB-001-quantitative_correctness-impl_final_r.json` | `34f741c4b95369f6d81d8f9286f6cb3f347a5be019b73ac90df698bad1d54657` |
| `QB-001-mathlib_reuse-impl_final_p.json` | `cef43a653d32dab3926742819691bf404d187628b5a6531e9842d321cfe29fd5` |
| `QB-001-mathlib_reuse-impl_final_q.json` | `a1b4f18d6f2ef6e023cecc5f3002143024662bab79d084c1c99ecf508c4a9ccc` |
| `QB-001-mathlib_reuse-impl_final_r.json` | `77071d2e39fab96f751a08285a451b262b8d4217311baf0cf5a4b0e04b1b7373` |
| `QB-001-api_dependency-impl_final_p.json` | `c6fb067dd158454c0a3d88b5b6b1799792f7106b757b01b30b238ecadd7413bb` |
| `QB-001-api_dependency-impl_final_q.json` | `46b993741c154cc0a2287ce05280981d80edf9e2bd49618ec8a655e50bca5c53` |
| `QB-001-api_dependency-impl_final_r.json` | `fc2f0d11775494a4b03ca195beddbb44c38cc6382cc6075602380906620ca931` |
| `QB-001-proof_quality-impl_final_p.json` | `6ed98829fc3bf3f6b2b2d52efa6ad7d0947a101fca3e909270969aba040c43b8` |
| `QB-001-proof_quality-impl_final_q.json` | `26af6816cbf62ea48886b34fbcc2558f148f39b84d8a5e2c266bd2082d6f3f39` |
| `QB-001-proof_quality-impl_final_r.json` | `e5ebbd74e1f6060fc8825cd98b0dc95238e58374ae3dcf28afde3cd747373ea8` |
| `DEF-001-source_fidelity-impl_final_p.json` | `e171267377733b6f6d8b6151a4cd8a071dd1481185b568d2a78d5b8ee692a985` |
| `DEF-001-source_fidelity-impl_final_q.json` | `4b4ca5b0305a16faf5fb95d2f5dddc0f2c561e03b588cf514f85340ae0731b43` |
| `DEF-001-source_fidelity-impl_final_r.json` | `f6562286553c45c9108b3eba1d59cff7dbdf88979a24c46f5653731511b6d560` |
| `DEF-001-mathlib_reuse-impl_final_p.json` | `331cc8dfce70b021ad7326d0daea1a579c17466f0a7e5b87a979ed3ee54b7dd1` |
| `DEF-001-mathlib_reuse-impl_final_q.json` | `3f67f9c01709e14e180dc8d26877b3a92375da10eb646e483590ada258c96126` |
| `DEF-001-mathlib_reuse-impl_final_r.json` | `828b4ce994ed6c20d5b82bcbe76e58ba08f2fb76434869c07f26edfd7c2fc137` |
| `DEF-001-api_dependency-impl_final_p.json` | `5fbc7101fe4dbc101371e1c63718382ddad56ca529e1737006ed460d2e712b98` |
| `DEF-001-api_dependency-impl_final_q.json` | `dcdc04e7d6e846f28658f768fbf310ab1d12176d61bf154916977fce2d0e7d0e` |
| `DEF-001-api_dependency-impl_final_r.json` | `90d36aac24ca8c74ae9b26b24dd9cf87a14ce21307a5d0a4e92091d7f4da3d11` |
| `DEF-001-proof_quality-impl_final_p.json` | `d52a0ef6889d45b078c53b3b35ddb2576371b8377dba9b1231b74434f76c21bc` |
| `DEF-001-proof_quality-impl_final_q.json` | `b96bda0c9f5ce07b5aafece3556ff5c1138753117fe556afb7713658016c631a` |
| `DEF-001-proof_quality-impl_final_r.json` | `96381daf9b23864054913b3c5f0759c5f17beff9e3379bcec370dad463eb686d` |

## Final detached adjudication artifacts

| Artifact | SHA-256 |
|---|---|
| candidate-bound `QB-001-review-envelope.yaml` | `702f37c934b7a22e35fe60ae66508db4f61df028b36ade99e9ee621e5252521e` |
| candidate-bound `DEF-001-review-envelope.yaml` | `61086fb9b90d760ccf1e8530cedded2ec8a460f3731a5954f50784d336447226` |
| `disposition_ledger.yaml` | `ce306517063be8e756ec478c6c0adc447e38ab2c9a01fa1acaff0a1ad2ec8624` |
| `merge_decision.md` | `eceb4cfa94732485fc2f07e82e02ac3f780e5fa194dd5068ff6f7f17c164678c` |

## Build, validator, signature, and trust results

- Exact-head repository status was clean, and HEAD was exactly `515b742f7ad5472c17cfdf0fda7cbc83c5585da1`.
- Full builds succeeded in the independent review packages; reported job counts ranged from 2,748 to 2,756 according to cache state. Direct compilation of both semantic modules and the audit module also succeeded.
- Exact declaration counting found 8 QB and 4 DEF semantic declarations, with no extra semantic declaration forms.
- `scripts/validate_inventory.py` passed with 24 occurrences, 2 notations, 10 entities, 10 entity-evidence rows, and 16 occurrence associations.
- The negative validator suite rejected all 25 intentionally invalid fixtures.
- Exact `#check` signatures for all 12 declarations matched the frozen packet statements.
- `#print axioms` for all 12 declarations, and for the repaired `eulerAtOne` audit, reported only the frozen allowlist: `propext`, `Classical.choice`, and `Quot.sound`.
- Trust scans found no `sorry`, `admit`, undeclared `axiom`, `opaque`, or `unsafe`, and no duplicate project-local Gamma definition.
- The elaborated `eulerAtOne` proof term depends on both `LMLF.Definitions.gamma_eq_eulerIntegral` and `Complex.GammaIntegral_one`.

## Scope limit and locked 1997 Watson blocker

This BOOTSTRAP-0 publication receives **zero Olver source-coverage credit**. QB-001 is finite reusable error-bound infrastructure, and DEF-001 is a transparent wrapper layer around the pinned Mathlib Gamma object. Neither is an Olver theorem occurrence, a quantitative Olver result, qualitative source recovery, chapter coverage, or book coverage.

The first intended quantitative-Olver MVP remains blocked on `OLV97-C03-WATSON`: Watson's lemma as printed on pp. 71–72 of F. W. J. Olver, *Asymptotics and Special Functions*, corrected A K Peters reprint (1997), ISBN `1-56881-069-5`. `RQ-SRC-001` is still open because the locked-edition snapshot identity, printed label, complete proposition, notation/entity reconciliation, copyright-safe mathematical transcription with digest, and independent collation review are missing. The later 2010 preview and DLMF locator are corroborating leads only and cannot substitute for direct collation of the locked 1997 edition.

## Process attribution

The external-envelope and independent-rubric workflow is an original manual-first adaptation inspired by [Tau Ceti](https://github.com/TauCetiProject/TauCeti), [Tau Ceti Roadmap](https://github.com/TauCetiProject/TauCetiRoadmap), and [Tau Ceti Review](https://github.com/TauCetiProject/TauCetiReview). It does not copy their runner and does not equate manual isolation attestations with technically enforced clean-room isolation.
