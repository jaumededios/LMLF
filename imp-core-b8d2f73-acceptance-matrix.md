# IMP-001 implementation: exact-head proposer-side acceptance matrix

## Disposition

This evidence map is bound to the clean, pushed candidate
b8d2f731fcfd5cd0889d0732f13699eb94681c86 on branch impl/imp-001-core,
inspected at 2026-09-06T18:11:31Z. It records what production proof bodies,
compiled regression theorems and consumers, type-shape guards, private-name
probes, and local operational checks establish at that exact head.

At this proposer-side evidence level, all 25 frozen regression obligations and
all 21 theorem-card edge obligations have substantive Lean evidence. No
nonanalytic or analytic acceptance-content gap was found. This is not an
independent implementation review, final IMP-001 acceptance verdict, merge
authorization, or review-quorum credit. The core and supplemental pre-Lean
gates pass, but implementation review remains pending. The proposer, the
implementing agents, and the root adjudicator count as zero fresh implementation
referees for this matrix.

## Frozen authority and exact artifact bindings

| Item | Exact binding |
|---|---|
| Candidate | clean branch tip b8d2f731fcfd5cd0889d0732f13699eb94681c86; local branch equals origin/impl/imp-001-core |
| Frozen core specification | commit 3a1b16cae6d186a20530de3b883c1bb871ee76f6 |
| Work packet | review/work_packets/IMP-001.yaml; SHA-256 e0f16a660417d967312df0f7cc7ce12ea1243226801b409475548566d594796b |
| Theorem card | blueprint/theorem_cards/IMP-001.yaml, TC-IMP-001-R7; SHA-256 d81f8970bcba3bf1a489f8cb4fea8b303a3e3bf6d1ad3ade37b42f3094b528c4 |
| Exact signatures | blueprint/theorem_cards/IMP-001-signatures-R6.md, SIG-IMP-001-R6-P2; SHA-256 0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d |
| Core natural-language proof | blueprint/proofs/IMP-001-R7.md, NLP-IMP-001-R7; SHA-256 941ca0f2a7e402e9dd3636d7c93744290b3f5b52b8705484c18630c6fe173548 |
| Core pre-Lean pass | external spec-3a1b16cae6d186a20530de3b883c1bb871ee76f6/IMP-001-review-envelope-lean-ready.yaml; SHA-256 3e4ca4b00adf36fc6b85315f74dcc4349abcd17eb6ebaf7282c374a0499a56f5; composite lean_ready gate pass |
| Core pre-Lean disposition | external spec-3a1b16cae6d186a20530de3b883c1bb871ee76f6/IMP-001-prelean-disposition.yaml; SHA-256 90ca06ebbaf9eb7958eaa0450d55e2c00aec902e297e4e319379d50fb72123b1 |
| Reviewed analytic companion | blueprint/proofs/IMP-001-REG-R2.md at companion commit 0f4df472dd2c97267dbc2c2128975eb3277132e0; SHA-256 316fc09bf3f35a5649f951ea0964ed1330e540d028a48c4706312d37c87ae7e9 |
| Supplemental R2 pass | external supplement-imp-reg-r2-0f4df472dd2c97267dbc2c2128975eb3277132e0/lean-ready-envelope-r2.yaml; SHA-256 ee3fb545a1772eae460cfaa39ecf45b1d7d4c075461f2424577ee273dce25d9c; gate_state pass and formalization_authorized true for R04/R05/R06/R11/R12/R13/R22/R24 |
| Supplemental adjudication | external supplement-imp-reg-r2-0f4df472dd2c97267dbc2c2128975eb3277132e0/root-adjudication-r2.md; SHA-256 b1b77b956d19ea8c0f741d2d7111f98b8c31e38d27b89d01cb811a3e1dbafb17 |
| Basic source | LMLF/Integral/Improper/Basic.lean; SHA-256 c4f77d2616b5e8040f9fc1aa60d5301cf5a8f37decb6bb94b520fa2ea04fe35f |
| Abel source | LMLF/Integral/Improper/Abel.lean; SHA-256 cd189f0603e61cc04c9e58d81e7601466aa74ef99464826f8352f719ba235c19 |
| Bochner source | LMLF/Integral/Improper/Bochner.lean; SHA-256 f3d4c4ddff91bb17a5f5e3325ff6779100e867f6fd7188a1b8a0d46c58182dcb |
| Public-use test | LMLFTest/Integral/Improper/IMP001PublicUse.lean; SHA-256 ebced44ac790b40f5453946a917fdc78111f3a4814eca92d68223573901e99dd |
| Core regression test | LMLFTest/Integral/Improper/IMP001Regressions.lean; SHA-256 07ac5caa5a4620c763293a257dded3a8fe3231020a9cb4edcfe5f150e4345a22 |
| Endpoint-invariance test | LMLFTest/Integral/Improper/IMP001EndpointAE.lean; SHA-256 313171f874e6f89b3b5ed6d6b87e4670fe3a3d22dba0eeb378790a7b9ee4dd2e |
| Gamma-endpoint test | LMLFTest/Integral/Improper/IMP001GammaEndpoint.lean; SHA-256 9bcbed11516602f5685891d0228e7d73fc0c19baec149e5ee8e9895bc8333c70 |
| Abel-example test | LMLFTest/Integral/Improper/IMP001AbelExamples.lean; SHA-256 73b7cfcd90aee475ad0ae8e4bd68e843918672be470ef13f38431ebd4a88feee |
| Oscillatory test | LMLFTest/Integral/Improper/IMP001Oscillatory.lean; SHA-256 516e017e6b82b099f66129ba9eb309c9293301641bfb78c0d31095c662dfff71 |
| Build registration | lakefile.toml; SHA-256 4ade8caa4da73d9c13d7696bcc2f859e9261e1f29148ea31618537dc13248303; all six IMP test modules are LMLFTest globs at lines 34–39 |
| Dependency lock | lake-manifest.json; SHA-256 4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404; Mathlib commit 0df444a360eaa60ab8c11dca51a86af692955474 |

The frozen packet/card historical self-fields that say pending or not_started
describe the preimplementation snapshot. They are not current blockers. The
external core envelope is the authoritative core pre-Lean pass. The separate
R2 supplemental envelope is now a passing successor and authorized only the
listed nonproduction analytic regressions; it did not alter the eight public
targets or reopen the core R7 decision.

## Evidence-kind legend

- **BODY** means an actual production definition/theorem or private production
  proof body establishes the point.
- **TEST** means a compiled concrete nonproduction regression theorem
  establishes the proposition.
- **CONSUMER** means a compiled downstream theorem uses the public API without
  depending on its private representation.
- **GUARD** means a compiled fail_if_success assertion rejects a prohibited
  type shape. It is not substituted for an analytic counterexample.
- **PROBE** means an external import/name-resolution check at the exact head.
- **GATE** means a local operational check or an already-authoritative external
  review record.

## Exact public production API

The production surface remains exactly two public definitions plus six public
theorems. The direct public-declaration scan returns only these eight entries;
all other IMP declarations in the three production modules are private.

| Target | Public declaration | Production locus | Evidence |
|---|---|---|---|
| T01 | LMLF.Integral.HasImproperIntegralAtTopExcept | Basic.lean:49–52; exact private break representation Basic.lean:13–46 | definition BODY |
| T02 | LMLF.Integral.HasImproperIntegralAtTopExcept.unique | Basic.lean:913–918 | theorem BODY |
| T03 | LMLF.Integral.HasImproperIntegralAtTopExcept.finset_clm | Basic.lean:932–1003 | theorem BODY |
| T04 | LMLF.Integral.HasImproperIntegralAtTopExcept.split_regular | Basic.lean:1005–1135 | theorem BODY |
| T05 | LMLF.Integral.IsFiniteExceptionalPrimitive | Basic.lean:54–63 | definition BODY |
| T06 | LMLF.Integral.IsFiniteExceptionalPrimitive.hasImproperIntegralAtTopExcept_exp_smul | Abel.lean:258–269; private Abel engine Abel.lean:16–256 | theorem BODY |
| T07 | LMLF.Integral.HasImproperIntegralAtTopExcept.of_integrableOn_Ioi | Bochner.lean:44–50; private canonical package Bochner.lean:13–42 | theorem BODY |
| T08 | LMLF.Integral.hasImproperIntegralAtTopExcept_iff_exists_primitive | Basic.lean:742–771; private forward/reverse recursion Basic.lean:339–740 | theorem BODY |

Exact-type assertions for all eight compile at
IMP001Regressions.lean:23–76. The independent external positive import probe
also resolves all eight original names and prints their types.

## IMP-R01 through IMP-R25

| ID | Proposer-side state | Exact evidence and scope |
|---|---|---|
| IMP-R01 | EVIDENCED — BODY + type check | T01 has the frozen binder order and exact body at Basic.lean:13–52; its exact public type is checked at IMP001Regressions.lean:23–25, and the above-start premise projects at lines 82–87. |
| IMP-R02 | EVIDENCED — BODY + TEST | Empty S has a zero witness at IMP001Regressions.lean:102–110, projects to honest truncation integrability and the direct atTop limit at 115–128, and satisfies the exact iff in both directions at 130–172. |
| IMP-R03 | EVIDENCED — BODY + TEST | T08 is a real bidirectional recursive proof for an arbitrary canonically sorted finite set at Basic.lean:339–771. R02 covers empty behavior and IMP001Regressions.lean:191–199 specializes an arbitrary two-point set. |
| IMP-R04 | EVIDENCED — concrete TEST | principalValueCutoff_rejected at IMP001Oscillatory.lean:872–931 proves the symmetric principal-value sum tends to zero while every T01 value is rejected. Exact left/right cutoff identities are at 801–868; the finite-limit contradiction uses the public T08 primitive characterization and logarithmic divergence, not totalized improper semantics. |
| IMP-R05 | EVIDENCED — concrete TEST | conditionalFiniteCutoff at IMP001Oscillatory.lean:1304–1323 supplies the two independent finite side limits, the explicit T05 primitive, its atTop limit and exact T01 value 2·LQ, and failure of IntegrableOn on every neighborhood. The shared private side-limit/non-L1/primitive support is at 933–1300. |
| IMP-R06 | EVIDENCED — concrete TEST | sinDivTail_conditional at IMP001Oscillatory.lean:1331–1356 gives an empty-exceptional-set T01 value and proves failure of IntegrableOn on Ioi 1. The shared private Dirichlet convergence and absolute-divergence engine is at 54–585. |
| IMP-R07 | EVIDENCED — BODY + projection + GUARD | Honest truncation integrability is exposed and reconstructed by r02_empty_exceptional_set_iff at IMP001Regressions.lean:115–189. The typed guard at 377–382 rejects construction from a limit alone. This is the packet-authorized abstract/type-shape discharge; no redundant analytic wrapper is required. |
| IMP-R08 | EVIDENCED — BODY + CONSUMERS | T03 weakens each primitive to literal s.biUnion S and maps/sums the values at Basic.lean:943–1003. Tests cover empty and two-term unions, negation, real smul, complex multiplication, and both cross-codomain maps at IMP001Regressions.lean:210–287. The amplitude-on-S plus smooth-on-empty pattern compiles at IMP001PublicUse.lean:131–196. |
| IMP-R09 | EVIDENCED — BODY + TEST | T04 has exact J + I orientation at Basic.lean:1005–1135. The a=k and nonzero constant-prefix sign/order cases compile at IMP001Regressions.lean:289–316. |
| IMP-R10 | EVIDENCED — exact BODY + GUARD | Iff.rfl at IMP001Regressions.lean:89–100 exposes exactly the five T05 fields. The no-bounding-field guard is at 384–390. T05 contains no atTop limit, target value, derivative, or bundled flat bound. |
| IMP-R11 | EVIDENCED — concrete TEST | discontinuousPrimitive_counterexample at IMP001AbelExamples.lean:99–151 verifies every local primitive/weighted premise except continuity, computes the positive jump contribution exp(-1), proves the actual weighted improper value is uniquely zero, and rejects exp(-1). |
| IMP-R12 | EVIDENCED — concrete TEST | endpointOnly_counterexample at IMP001AbelExamples.lean:238–266 gives g=0 and a continuous compact bump with matching endpoints but a failed midpoint increment; every positive Abel weight detects the false endpoint-only formula. |
| IMP-R13 | EVIDENCED — BODY + TEST | The private finite-piece theorem is quantified over arbitrary h and a≤b at Abel.lean:85–185, covers a=b, and never divides by h. Public h=0 compiles at IMP001Regressions.lean:318–327. indicatorPrimitive_nondifferentiable at IMP001AbelExamples.lean:554–589 supplies the exact T05 clipped-ramp primitive, nondifferentiability at both corners, bounded/eventually-constant behavior, both T06 hypotheses, exact weighted values, and the public T06 conclusion for every h>0. |
| IMP-R14 | EVIDENCED — BODY | T01 is a sum of independently split components at Basic.lean:13–46. T06 builds a transformed T05 primitive on every regular interval and invokes T08 at Abel.lean:187–269; it never treats a singular prefix as one ordinary intervalIntegral. |
| IMP-R15 | EVIDENCED — trust/import GATE | Production imports remain the frozen surfaces; the direct trust scan finds no axiom, sorry, or admit in the three modules. Root exact-head verification reports all eight targets have exactly [propext, Classical.choice, Quot.sound] and no warnings. |
| IMP-R16 | EVIDENCED — external GATES | The core exact-hash envelope records lean_ready pass. The exact-hash R2 supplemental envelope records its separate regression-only pass and formalization authorization. Neither is an implementation acceptance, and neither changes the core target contract. |
| IMP-R17 | EVIDENCED — BODY | T03 chooses each T08 witness, weakens it to the literal union, constructs the mapped finite-sum primitive, and closes through T08 plus tendsto_finsetSum at Basic.lean:943–1003. No consumer depends on sorted/private representation. |
| IMP-R18 | EVIDENCED — BODY | The private Fubini kernel sets ν=volume.restrict (uIoc a b), proves Integrable (Function.uncurry K) (ν.prod ν), and passes that exact measure to intervalIntegral_integral_swap at Abel.lean:22–36 and 63–67. Measurability is local to that Integrable proof; no global StronglyMeasurable premise was added. |
| IMP-R19 | EVIDENCED — BODY | exp_mul_intervalIntegral derives the derivative of exp(-h·t) through HasDerivAt.exp at Abel.lean:85–101; at pinned Mathlib 0df444a this delegates to Real.hasDerivAt_exp in Mathlib/Analysis/SpecialFunctions/ExpDeriv.lean:304–306. There is no division by h, and the public h=0 test compiles. |
| IMP-R20 | EVIDENCED — CONSUMER | r20_arbitrary_S_from_bounded_primitive at IMP001PublicUse.lean:27–70 quantifies arbitrary S, derives the weighted IntegrableOn and boundary limit from h>0 plus a separate flat bound, and invokes only public T06. |
| IMP-R21 | EVIDENCED — BODY + CONSUMER + GUARD | T07 is proved via the private canonical primitive at Bochner.lean:13–50. Arbitrary-S positive use is at IMP001Regressions.lean:357–363; the missing-IntegrableOn type guard is at IMP001PublicUse.lean:286–295. |
| IMP-R22 | EVIDENCED — two concrete TESTS | initialEndpoint_integrable_example at IMP001GammaEndpoint.lean:49–94 proves honest open-ray integrability, exact positive Gamma(1/2) value, and public T07/T01 acceptance for arbitrary valid S. initialEndpoint_nonL1_example at IMP001Oscillatory.lean:1384–1407 proves a finite right-endpoint cutoff limit, failure of local IntervalIntegrable and whole-ray IntegrableOn, and rejection of every empty-set T01 value. These two named theorems jointly prove REG.44–REG.48. R2 explicitly makes planned nonpublic declaration names routing labels and their exact propositions normative, so a cosmetic combined initialEndpoint_examples wrapper is not required. |
| IMP-R23 | EVIDENCED — BODY + CONSUMERS + GUARDS | T08 proves both directions at Basic.lean:742–771. Below-k primitive replacement is at IMP001Regressions.lean:329–355 and existential positive use at 365–371. Fixed-F and bundled-bound shapes are rejected at IMP001PublicUse.lean:297–304 and IMP001Regressions.lean:392–402; the flat bound remains separately derived at IMP001PublicUse.lean:72–99. |
| IMP-R24 | EVIDENCED — generic TEST suite | IMP001EndpointAE.lean proves interval integrability/integral invariance at 35–45, open-ray IntegrableOn/set-integral invariance at 50–59, fixed-T05 invariance at 63–80, existential T08-right-side invariance at 84–97, full T01 iff at 102–118, and explicit two-sided T07 transport at 123–139. The change set is exactly {k} ∪ S and the T01 proof uses public T08 rather than private component recursion. |
| IMP-R25 | EVIDENCED — CONSUMER | source_shaped_public_chain_one_model at IMP001PublicUse.lean:218–284 begins from an explicit baseline T01 witness, uses T07/T03/T04/T08/T06 through public names, separately derives the flat bound, and recombines without QL/OLV imports. It is a generic source-shaped consumer, not an OLV implementation or downstream-final-review credit. |

Inventory result: 25 of 25 regression rows have substantive proposer-side
Lean evidence at the bound head. The classification says nothing about
independent proof quality or implementation-review quorum.

## Twenty-one theorem-card edge obligations

| # | Frozen edge | Linked regressions | Exact-head evidence |
|---:|---|---|---|
| 1 | Empty exceptional set reduces to ordinary right-endpoint limit | R02 | EVIDENCED: exact iff and both directions at IMP001Regressions.lean:115–172. |
| 2 | T08 empty and multiple-point exact telescope | R03 | EVIDENCED: recursive T08 BODY at Basic.lean:339–771, the R02 empty proof, and the two-point specialization at IMP001Regressions.lean:191–199. |
| 3 | Amplitude on S plus smooth terms on empty concludes on S | R08, R17 | EVIDENCED: subtraction/recombination consumers at IMP001PublicUse.lean:131–196 and literal-union BODY at Basic.lean:958–1003. |
| 4 | T03 cross-codomain scalar transports | R08 | EVIDENCED: generic E→L[ℝ]H consumer at IMP001PublicUse.lean:120–129 and named real/complex instances at IMP001Regressions.lean:252–287. |
| 5 | Principal-value-only singularity rejected | R04 | EVIDENCED: principalValueCutoff_rejected at IMP001Oscillatory.lean:872–931. Its normative statement is exact PV→0 plus ∀I ¬T01; an extra public conjunct spelling both divergences is unnecessary. |
| 6 | Conditionally convergent one-sided finite singularity accepted | R05 | EVIDENCED: conditionalFiniteCutoff at IMP001Oscillatory.lean:1304–1323, backed by the shared private side-limit and non-L1 engine. |
| 7 | sin(t)/t tail not strengthened to absolute integrability | R06 | EVIDENCED: sinDivTail_conditional at IMP001Oscillatory.lean:1331–1356. |
| 8 | Nonintegrable truncation cannot pass through totalization | R07 | EVIDENCED at the frozen abstract/type level: projection/iff at IMP001Regressions.lean:115–189 and typed guard at 377–382. |
| 9 | Square-root versus conditionally improper non-L1 initial singularities | R22 | EVIDENCED jointly by IMP001GammaEndpoint.lean:49–94 and IMP001Oscillatory.lean:1384–1407. Separate normative theorem names suffice. |
| 10 | Discontinuous componentwise primitive cannot telescope | R11 | EVIDENCED: IMP001AbelExamples.lean:99–151. |
| 11 | Endpoint equality cannot replace every-point increments | R12 | EVIDENCED: IMP001AbelExamples.lean:238–266, in addition to the T05/T06 production bodies. |
| 12 | Exceptional prefix is not one intervalIntegral | R14 | EVIDENCED: split-component T01 BODY at Basic.lean:13–46 and transformed-primitive T06 BODY at Abel.lean:187–269. |
| 13 | Exact restricted-product Integrable kernel | R18 | EVIDENCED: Abel.lean:22–36 and 63–67. |
| 14 | Measure-local AEStronglyMeasurable; no global premise | R18 | EVIDENCED inside the restricted-product Integrable construction at Abel.lean:28–36; no global measurability hypothesis appears in the public signature. |
| 15 | Real.hasDerivAt_exp route and no division by h | R19 | EVIDENCED: Abel.lean:85–101 and pinned Mathlib ExpDeriv.lean:304–306; arbitrary h remains explicit. |
| 16 | Private a=b, private/public h=0, and nondifferentiable primitive | R13 | EVIDENCED: generic private BODY Abel.lean:85–185, public h=0 regression IMP001Regressions.lean:318–327, and clipped-ramp/nondifferentiability theorem IMP001AbelExamples.lean:554–589. |
| 17 | Arbitrary-S QL-shaped public-only consumer | R20 | EVIDENCED: IMP001PublicUse.lean:27–70, with no QL/OLV or private IMP name. |
| 18 | Arbitrary-S T07 plus missing-IntegrableOn rejection | R21 | EVIDENCED: T07 BODY Bochner.lean:13–50, positive control IMP001Regressions.lean:357–363, and guard IMP001PublicUse.lean:286–295. |
| 19 | Existential T08, both directions, no bundled bound | R23 | EVIDENCED by the T08 BODY, existential/below-start consumers, and fixed-F/bound guards listed under R23. |
| 20 | Endpoint integrand values and below-k witness values irrelevant | R24, R23 | EVIDENCED: below-k witness irrelevance at IMP001Regressions.lean:329–355 and full {k}∪S integrand invariance for T01/T07/T08 throughout IMP001EndpointAE.lean:23–139. |
| 21 | T04 exact sign and value order | R09 | EVIDENCED: T04 BODY plus a=k and constant-prefix tests at IMP001Regressions.lean:289–316. |

Inventory result: 21 of 21 edge rows have substantive proposer-side Lean
evidence at the bound head. This is still not final-review credit.

## Private-helper boundary and operational probes

The implementation preserves the intended abstraction boundary:

- Basic.lean declares the actual HasImproperIntegralTailFromBreaks and
  HasImproperIntegralAtTopBreaks definitions private at lines 13 and 34.
- Abel.lean declares intervalIntegral_weighted_primitive_fubini and
  intervalIntegral_exp_smul_primitive private at lines 16 and 103; its other
  engine declarations are also private.
- Bochner.lean declares canonicalPrimitivePackage private at line 13.
- A no-consumer-reference scan over LMLFTest, LMLF/Results.lean, LMLF.lean,
  and lakefile.toml for the two break helpers, the two Abel helpers,
  transformedPrimitivePackage, canonicalPrimitivePackage, and S.sort returned
  exit 1 with no output, as expected.

Two disposable external files make the operational distinction explicit.
They are evidence artifacts only and are not candidate files:

| Probe | SHA-256 | Exact command and outcome |
|---|---|---|
| imp-core-b8d2f73-public-api-probe.lean | 6b3aa43462802151d3bc88c4f0fdf515b0459eab110511a1ec8304cb62bfeaad | From the candidate root, lake env lean /workspace/Documents/Codex/2026-09-05/LMLF-review-evidence/imp-core-b8d2f73-public-api-probe.lean; exit 0; both production sibling modules import successfully and all eight exact public names print valid types. |
| imp-core-b8d2f73-private-name-probe.lean | bb95d0f333d29660b3bc99e76b326ed846e7531589e047d81010116e0bf70a83 | From the candidate root, lake env lean /workspace/Documents/Codex/2026-09-05/LMLF-review-evidence/imp-core-b8d2f73-private-name-probe.lean; exit 1 solely with four lean.unknownIdentifier diagnostics, one each for the exact original names LMLF.Integral.HasImproperIntegralTailFromBreaks, LMLF.Integral.HasImproperIntegralAtTopBreaks, LMLF.Integral.intervalIntegral_weighted_primitive_fubini, and LMLF.Integral.intervalIntegral_exp_smul_primitive. No import, dependency, or environment diagnostic occurred. |

These probes use the properly namespace-qualified source names, not mangled
private names or misspellings. Their paired import baseline rules out an
environment failure as the reason for the negative result. No public wrapper
was introduced merely to make a private implementation detail testable.

## Trust, imports, Mathlib reuse, and exact-head checks

Production imports remain:

- Basic.lean: Mathlib.Data.Finset.Sort and
  Mathlib.MeasureTheory.Integral.DominatedConvergence.
- Bochner.lean: Basic plus
  Mathlib.MeasureTheory.Integral.IntegralEqImproper.
- Abel.lean: Basic plus the four frozen Mathlib Abel imports.
- Abel and Bochner remain independent siblings. LMLF/Results.lean imports
  both, and LMLF.lean reaches Results.

The test-only analytic imports stay in LMLFTest and do not enlarge the
production dependency surface. One important reuse should be explicit for
implementation referees: the R05/R22-negative non-L1 transport instantiates
Mathlib's integrableOn_Ioi_comp_rpow_iff at p=-1 in
IMP001Oscillatory.lean:625–636. The pinned implementation is
Mathlib/MeasureTheory/Integral/IntegralEqImproper.lean:1219–1243 at Mathlib
0df444a360eaa60ab8c11dca51a86af692955474; it is a legitimate
change-of-variables/integrability theorem, not an assumed regression result.
Likewise, the positive R22 example uses the pinned
Real.GammaIntegral_convergent and Real.Gamma_eq_integral at Mathlib
Analysis/SpecialFunctions/Gamma/Basic.lean:66–75 and 405–408; the local file
still proves the translation and integrand equality itself.

Exact-head operational record:

| Check | Result |
|---|---|
| Direct lake env lean on Basic.lean, Abel.lean, and Bochner.lean | all exit 0; no diagnostics |
| Direct lake env lean on the six registered IMP test modules | all exit 0; only IMP001Regressions intentionally prints the eight checked types |
| Positive and negative inventory validation | both exit 0; 148 occurrences, 31 notations, 32 entities, 34 evidence rows, 88 associations; all 25 intentionally invalid copied fixtures rejected |
| Forbidden-trust scan over the three production modules | rg exit 1 with no matches for production axiom, sorry, or admit |
| Public-declaration scan | exactly the frozen two definitions and six theorems listed above |
| git diff --check from 0f4df472 to the bound head | exit 0; no output |
| Final worktree/remote binding | git status shows no tracked or untracked changes and branch equals origin/impl/imp-001-core at b8d2f731fcfd5cd0889d0732f13699eb94681c86 |
| Implementer full local build | reported exit 0, Build completed successfully (2766 jobs); all six tests are default-target registered |
| Root direct/LSP verification | direct Oscillatory Lean exit 0/no output; all eight public declarations verified with scan_source=true, no warnings, and exactly propext, Classical.choice, Quot.sound |
| GitHub CI | not invoked; the implementation commits use skip-ci and the user requested local verification only |

The implementer build and root LSP results are separately reported primary
agent evidence. They are not claimed as this mapper's independent rerun or as
fresh implementation-referee credit. This mapper independently reran the nine
direct Lean module checks, both inventory modes, static audits, and the paired
public/private probes stated above.

## Remaining gate and completion path

No unmet substantive R01–R25 or 21-edge obligation was identified at the bound
head, and no theorem-name-only wrapper is recommended. In particular, the
separate positive/negative R22 theorems match the normative reviewed
propositions; the companion's planned combined name is routing metadata.

The remaining blocker is procedural and independent of this evidence map:
the exact candidate still needs the work-packet-required fresh implementation
review quorum and root disposition over that hash. Final reviewers should
review the actual proof bodies, test theorem statements, pinned Mathlib reuse,
trust/import/API boundary, and the operational evidence above. They may rerun
the bound commands locally. They should not reopen the already-passed core R7
natural-language gate or the separately passed R2 regression-only gate unless
they find a concrete binding or proof defect. This matrix itself counts as no
implementation review and does not authorize merge.
