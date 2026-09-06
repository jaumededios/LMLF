# IMP-001 core implementation: interim acceptance matrix

## Disposition

This is a read-only acceptance mapping for candidate head
`0f4df472dd2c97267dbc2c2128975eb3277132e0` (`impl/imp-001-core`). It records
what the current production proof bodies, local consumers, type-shape guards,
and operational checks actually establish. It is **not** an independent
implementation review, final acceptance verdict, merge authorization, or
review-quorum credit.

Interim result: all eight frozen public declarations are present with real
production bodies and the exact frozen public types. The nonanalytic core
obligations have evidence at this head. The analytic examples/counterexamples
for IMP-R04, R05, R06, R11, the analytic endpoint-law example in R12, the
nondifferentiable-indicator part of R13, R22, and full endpoint-value invariance
in R24 remain unimplemented and cannot be credited from the companion prose.
Accordingly, IMP-001 is **not yet eligible for final implementation
acceptance**.

## Frozen and candidate bindings

| Item | Exact binding |
|---|---|
| Candidate review snapshot | clean branch tip `impl/imp-001-core` at `0f4df472dd2c97267dbc2c2128975eb3277132e0`; inspected 2026-09-06T17:04:22Z |
| Frozen core specification commit | `3a1b16cae6d186a20530de3b883c1bb871ee76f6` |
| Work packet | `review/work_packets/IMP-001.yaml`, SHA-256 `e0f16a660417d967312df0f7cc7ce12ea1243226801b409475548566d594796b` |
| Theorem card | `blueprint/theorem_cards/IMP-001.yaml` (TC-IMP-001-R7), SHA-256 `d81f8970bcba3bf1a489f8cb4fea8b303a3e3bf6d1ad3ade37b42f3094b528c4` |
| Exact signatures | `blueprint/theorem_cards/IMP-001-signatures-R6.md` (SIG-IMP-001-R6-P2), SHA-256 `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d` |
| Core natural-language proof | `blueprint/proofs/IMP-001-R7.md` (NLP-IMP-001-R7), SHA-256 `941ca0f2a7e402e9dd3636d7c93744290b3f5b52b8705484c18630c6fe173548` |
| Core pre-Lean authority | external `spec-3a1b16cae6d186a20530de3b883c1bb871ee76f6/IMP-001-review-envelope-lean-ready.yaml`, SHA-256 `3e4ca4b00adf36fc6b85315f74dcc4349abcd17eb6ebaf7282c374a0499a56f5`; records card, core NL, structural, and composite `lean_ready` gates as `pass` |
| Basic source | `LMLF/Integral/Improper/Basic.lean`, SHA-256 `c4f77d2616b5e8040f9fc1aa60d5301cf5a8f37decb6bb94b520fa2ea04fe35f` |
| Abel source | `LMLF/Integral/Improper/Abel.lean`, SHA-256 `cd189f0603e61cc04c9e58d81e7601466aa74ef99464826f8352f719ba235c19` |
| Bochner source | `LMLF/Integral/Improper/Bochner.lean`, SHA-256 `f3d4c4ddff91bb17a5f5e3325ff6779100e867f6fd7188a1b8a0d46c58182dcb` |
| Public-use tests | `LMLFTest/Integral/Improper/IMP001PublicUse.lean`, SHA-256 `ebced44ac790b40f5453946a917fdc78111f3a4814eca92d68223573901e99dd` |
| Regression tests | `LMLFTest/Integral/Improper/IMP001Regressions.lean`, SHA-256 `07ac5caa5a4620c763293a257dded3a8fe3231020a9cb4edcfe5f150e4345a22` |
| Build registration | `lakefile.toml`, SHA-256 `489de51d2251ff5cac985d8cd800f92a8b86a565158c26dac15558d53e139677`; `defaultTargets = ["LMLF", "LMLFTest"]`, with both IMP test modules at lines 31–36 |
| Dependency lock | `lake-manifest.json`, SHA-256 `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`; Mathlib `0df444a360eaa60ab8c11dca51a86af692955474` |

The candidate-owned `not_started`/`pending` historical fields in the frozen
card and packet describe their frozen preimplementation snapshot. They do not
override the later external core `lean_ready` envelope. Conversely, that core
envelope authorizes the eight-target implementation; it does not accept this
implementation or authorize the later analytic-regression formalization.

The current analytic companion is `blueprint/proofs/IMP-001-REG-R2.md` at this
candidate head, SHA-256
`316fc09bf3f35a5649f951ea0964ed1330e540d028a48c4706312d37c87ae7e9`.
The external supplemental envelope remains `lifecycle_state: pending_review`,
`gate_state: pending`, and `formalization_authorized: false` (pending-envelope
SHA-256 `701b26b3ce0daa1c67183fd38c72f610190a4016966be1894e1eaf1face41f00`).
One referee-C approval exists, but the frozen supplemental rule requires two
fresh reviewers and root adjudication. The companion therefore supplies no
current proof or authorization credit.

## Exact public API and implementation loci

The production surface is exactly two public definitions plus six public
theorems. Every other IMP declaration in the three production files is
`private`.

| Target | Public declaration | Production locus | Evidence kind |
|---|---|---|---|
| T01 | `LMLF.Integral.HasImproperIntegralAtTopExcept` | `Basic.lean:49–52`, backed by the exact private sorted representation at `Basic.lean:13–46` | exact definition body |
| T02 | `LMLF.Integral.HasImproperIntegralAtTopExcept.unique` | `Basic.lean:913–918` | theorem proof body |
| T03 | `LMLF.Integral.HasImproperIntegralAtTopExcept.finset_clm` | `Basic.lean:932–1003` | theorem proof body |
| T04 | `LMLF.Integral.HasImproperIntegralAtTopExcept.split_regular` | `Basic.lean:1005–1135` | theorem proof body |
| T05 | `LMLF.Integral.IsFiniteExceptionalPrimitive` | `Basic.lean:54–63` | exact definition body |
| T06 | `LMLF.Integral.IsFiniteExceptionalPrimitive.hasImproperIntegralAtTopExcept_exp_smul` | `Abel.lean:258–269`, with private Fubini/Abel engine at `Abel.lean:16–256` | theorem plus private proof bodies |
| T07 | `LMLF.Integral.HasImproperIntegralAtTopExcept.of_integrableOn_Ioi` | `Bochner.lean:44–50`, with private canonical primitive package at `Bochner.lean:13–42` | theorem plus private proof body |
| T08 | `LMLF.Integral.hasImproperIntegralAtTopExcept_iff_exists_primitive` | `Basic.lean:742–771`, with forward/reverse component recursion at `Basic.lean:339–740` | theorem plus private proof bodies |

The exact-type `#check` assertions for all eight names are at
`IMP001Regressions.lean:23–76` and compiled at the bound source/test hashes.
The T01 and T05 bodies match the frozen authoritative bodies, including
`S.sort (· ≤ ·)`, above-start membership, continuous normalization, honest
regular-piece `IntervalIntegrable`, and the all-intermediate-point increment
law.

## Evidence-status legend

- **BODY**: a production definition/theorem or private proof body establishes
  the property; this is stronger than signature reachability but is not a
  referee verdict.
- **CONSUMER**: a compiled downstream theorem uses only the public IMP API plus
  its separately listed direct Mathlib support.
- **GUARD**: a compiled `fail_if_success` check rejects a prohibited type shape;
  it is not a mathematical counterexample.
- **GATE**: a local build/audit or the already-authoritative external core
  pre-Lean record.
- **PARTIAL / PENDING-REG**: the listed core fragment exists, but the concrete
  analytic example/counterexample still requires the reviewed supplemental
  path and Lean implementation.

## IMP-R01 through IMP-R25

| ID | Interim state | Exact evidence and scope |
|---|---|---|
| IMP-R01 | EVIDENCED — BODY + type check | T01 uses the frozen binder order and exact bound body at `Basic.lean:13–52`; the exact public type is checked at `IMP001Regressions.lean:23–25`, and above-start projection is proved at `IMP001Regressions.lean:82–87`. |
| IMP-R02 | EVIDENCED — BODY + regression proofs | Empty `S` has a zero witness (`IMP001Regressions.lean:102–110`), projects to honest truncation integrability and the direct atTop interval-integral limit (`115–128`), and is characterized by the exact iff in both directions (`130–172`). This consumes the actual T08 proof, not a harness axiom. |
| IMP-R03 | EVIDENCED — BODY + generic specialization | T08 is a genuine bidirectional proof over the canonically sorted arbitrary finite set (`Basic.lean:339–771`); the recursive forward and reverse constructions account for every bounded component and final tail. Empty behavior is separately exercised by R02, and an arbitrary two-point set is specialized at `IMP001Regressions.lean:191–199`. The latter is a generic API specialization, while the exact multipoint telescope is in the production recursion. |
| IMP-R04 | PENDING-REG | No Lean theorem implements the cutoff `1/(t-c)` principal-value rejection. Companion prose is not proof or authorization. |
| IMP-R05 | PENDING-REG | No Lean theorem implements the independently convergent cutoff `sin(1/(t-c))/(t-c)` example or its local non-L1 result. |
| IMP-R06 | PENDING-REG | No Lean theorem implements conditional convergence of the `sin t / t` tail together with failure of whole-ray absolute integrability. |
| IMP-R07 | EVIDENCED — BODY + projection + GUARD | Honest regular truncations are exposed and reconstructed by `r02_empty_exceptional_set_iff` (`IMP001Regressions.lean:115–189`). The typed `fail_if_success` guard at `377–382` rejects attempting construction from a limit alone. This is the packet-authorized abstract/type-shape discharge; it does not claim a concrete nonintegrable analytic example. |
| IMP-R08 | EVIDENCED — BODY + CONSUMERS | T03 weakens each primitive to the literal `s.biUnion S`, constructs the mapped finite sum, and invokes T08 reverse (`Basic.lean:943–1003`). Tests cover empty family (`IMP001Regressions.lean:210–216`), two-term literal union (`218–250`), negation (`252–257`), real smul (`259–264`), complex multiplication (`266–272`), `ℝ → ℂ` (`274–280`), and `ℂ → ℝ` (`282–287`). The amplitude-on-`S` plus smooth-on-`∅` consumer pattern is exercised by subtraction and recombination at `IMP001PublicUse.lean:131–196`. |
| IMP-R09 | EVIDENCED — BODY + regressions | T04's exact `J + I` orientation is in `Basic.lean:1005–1135`. The `a = k` case compiles at `IMP001Regressions.lean:289–296`; the nonzero constant prefix and `(k-a) • v + I` sign/order compile at `298–316`. |
| IMP-R10 | EVIDENCED — exact definition + GUARD | `Iff.rfl` at `IMP001Regressions.lean:89–100` exposes exactly the five frozen T05 fields. The no-bounding-field guard is at `384–390`. There is no atTop limit, `L`, derivative, or target value in T05. |
| IMP-R11 | PENDING-REG | No Lean counterexample implements failure of exceptional telescoping for a discontinuous componentwise primitive. The production T05 continuity field exists, but that alone is not the required analytic regression. |
| IMP-R12 | PENDING-REG | The all-intermediate-point law is present definitionally (`Basic.lean:60–63`) and used for every subinterval by the private Abel engine (`Abel.lean:220–231`), but no Lean theorem implements the specified `g = 0`, `F(t)=t(1-t)` endpoint-only counterexample. |
| IMP-R13 | PARTIAL — BODY + h=0 regression; indicator PENDING-REG | The private finite-piece theorem is quantified by arbitrary `h` and `a ≤ b` (`Abel.lean:85–185`), includes `a=b`, and never divides by `h`. Public T06 at `h=0` under its exact two tail premises is proved in `IMP001Regressions.lean:318–327`. The bounded eventually constant nondifferentiable indicator/clipped-ramp example for `h>0` is not implemented. |
| IMP-R14 | EVIDENCED — BODY | T01 is a sum of independent recursively split components (`Basic.lean:13–46`). T06 constructs a transformed T05 primitive on each regular interval and then invokes T08 (`Abel.lean:187–269`); it never replaces an exceptional prefix by one `intervalIntegral` across a singular point. This is proof-body evidence; there is no separate public consumer assertion for the private representation. |
| IMP-R15 | EVIDENCED — GATE | Imports exactly match the frozen surfaces; no production IMP module imports QL, OLV, Watson, source, Gamma, QB, DEF, audit, or an umbrella. The eight `#print axioms` reports all return exactly `[propext, Classical.choice, Quot.sound]`. Text audit found no production `axiom`, `sorry`, or `admit`. |
| IMP-R16 | EVIDENCED — external operational GATE | The authoritative core envelope bound to spec commit `3a1b16c…` records `lean_ready: pass`; implementation commits follow that base. Frozen candidate-owned historical pending fields do not negate this external authority. This says only that the proof-before-Lean gate passed, not that implementation acceptance passed. |
| IMP-R17 | EVIDENCED — BODY | T03 chooses each T08 witness (`Basic.lean:943–957`), proves the literal-union above-start property and weakens each T05 witness (`958–969`), builds the mapped-sum primitive (`970–1000`), and closes with T08 reverse plus `tendsto_finsetSum` (`970–1003`). No consumer depends on sorted/private representation. |
| IMP-R18 | EVIDENCED — BODY | The private Fubini kernel sets `ν = volume.restrict (uIoc a b)` and proves `Integrable (Function.uncurry K) (ν.prod ν)` (`Abel.lean:22–36`), exactly the measure passed to `intervalIntegral_integral_swap` (`63–67`). Measurability is obtained inside that `Integrable` proof by the measurable triangular indicator; there is no global `StronglyMeasurable` premise. |
| IMP-R19 | EVIDENCED — BODY | `exp_mul_intervalIntegral` derives the derivative of `exp (-h*t)` with `HasDerivAt.exp` (`Abel.lean:85–101`); at the pinned Mathlib revision that declaration delegates directly to `Real.hasDerivAt_exp` (`Mathlib/Analysis/SpecialFunctions/ExpDeriv.lean:304–306`). The proof applies the FTC and performs no division by `h`, so `h=0` remains in scope. Public `h=0` is separately compiled by R13. |
| IMP-R20 | EVIDENCED — CONSUMER | `r20_arbitrary_S_from_bounded_primitive` (`IMP001PublicUse.lean:27–70`) quantifies arbitrary `S`, derives weighted `IntegrableOn` and boundary vanishing from `h>0` plus a separate flat bound, then invokes only public T06. Its direct Mathlib imports are separately declared and permitted. It does not unfold T01 or name private recursion. |
| IMP-R21 | EVIDENCED — BODY + CONSUMER + GUARD | T07 has an actual proof through the canonical primitive (`Bochner.lean:13–50`). Arbitrary-`S` positive use is at `IMP001Regressions.lean:357–363`; the typed missing-`IntegrableOn` guard is at `IMP001PublicUse.lean:286–295`. This guard establishes signature rejection only, while the proof body establishes the positive bridge. |
| IMP-R22 | PENDING-REG | No Lean theorem implements acceptance of the exponentially cut off square-root endpoint singularity or rejection of the conditionally improper non-L1 endpoint model. |
| IMP-R23 | EVIDENCED — BODY + CONSUMERS + GUARDS | T08 is an actual iff proof in both directions (`Basic.lean:742–771`). Below-`k` primitive replacement is proved at `IMP001Regressions.lean:329–355`; existential positive use is at `365–371`. The fixed-`F` and bundled-bound shapes are rejected at `IMP001PublicUse.lean:297–304` and `IMP001Regressions.lean:392–402`. The separately derived flat-bound theorem is `IMP001PublicUse.lean:72–99`. |
| IMP-R24 | PARTIAL; full result PENDING-REG | Initial-point update invariance for the honest T07 bridge is proved at `IMP001PublicUse.lean:101–118`. There is no Lean theorem for simultaneous changes of `f` at `k` and every point of `S`, nor the required full preservation route for T01, T07, and T08. R23's below-`k` primitive result does not discharge this distinct integrand-invariance obligation. |
| IMP-R25 | EVIDENCED — CONSUMER | `source_shaped_public_chain_one_model` (`IMP001PublicUse.lean:218–284`) starts with an explicit baseline T01 witness, uses T07/T03/T04/T08/T06 through public names, derives the flat bound separately, and recombines without QL/OLV imports. It is intentionally a generic source-shaped consumer, not an OLV implementation and not downstream final-review credit. |

Interim count: 17 regression rows are fully evidenced at the stated core
scope; 2 are partial (R13, R24); 6 are wholly pending analytic Lean
regressions (R04, R05, R06, R11, R12, R22). This count is an evidence inventory,
not an acceptance score.

## Twenty-one theorem-card edge obligations

| # | Frozen edge | Linked regressions | Interim state and exact evidence |
|---:|---|---|---|
| 1 | Empty exceptional set reduces to ordinary right-endpoint limit | R02 | EVIDENCED: exact iff and both directions at `IMP001Regressions.lean:115–172`. |
| 2 | T08 empty and multiple-point exact telescope | R03 | EVIDENCED by T08 recursive BODY (`Basic.lean:339–771`), R02 empty proof, and two-point specialization (`IMP001Regressions.lean:191–199`). |
| 3 | Amplitude on `S` plus smooth terms on `∅` concludes on `S` | R08, R17 | EVIDENCED: subtraction/recombination consumers `IMP001PublicUse.lean:131–196`; literal-union BODY `Basic.lean:958–1003`. |
| 4 | T03 cross-codomain scalar transports | R08 | EVIDENCED: generic `E →L[ℝ] H` consumer `IMP001PublicUse.lean:120–129` and named complex/real instances `IMP001Regressions.lean:252–287`. |
| 5 | Principal-value-only singularity rejected | R04 | PENDING-REG: no concrete Lean theorem. |
| 6 | Conditionally convergent one-sided finite singularity accepted | R05 | PENDING-REG: no concrete Lean theorem. |
| 7 | `sin(t)/t` tail not strengthened to absolute integrability | R06 | PENDING-REG: no concrete Lean theorem. |
| 8 | Nonintegrable truncation cannot pass through totalization | R07 | EVIDENCED at authorized abstract/type level: projection/iff `IMP001Regressions.lean:115–189` plus typed guard `377–382`; no concrete analytic counterexample claimed. |
| 9 | Square-root vs conditionally improper non-L1 initial singularities | R22 | PENDING-REG: no concrete Lean theorem. |
| 10 | Discontinuous componentwise primitive cannot telescope | R11 | PENDING-REG: no concrete Lean theorem. |
| 11 | Endpoint equality cannot replace every-point increments | R12 | PENDING-REG for the specified analytic counterexample; T05 and T06 bodies do enforce/use the every-point law. |
| 12 | Exceptional prefix is not one `intervalIntegral` | R14 | EVIDENCED by split-component T01 BODY `Basic.lean:13–46` and transformed-primitive T06 BODY `Abel.lean:187–269`. |
| 13 | Exact restricted-product `Integrable` kernel | R18 | EVIDENCED at `Abel.lean:22–36,63–67`. |
| 14 | Measure-local `AEStronglyMeasurable`; no global premise | R18 | EVIDENCED inside the restricted-product `Integrable` construction at `Abel.lean:28–36`; production signature has no global measurability hypothesis. |
| 15 | `Real.hasDerivAt_exp` route and no division by `h` | R19 | EVIDENCED by `Abel.lean:85–101`; its `HasDerivAt.exp` call delegates to `Real.hasDerivAt_exp` in pinned Mathlib `ExpDeriv.lean:304–306`, and arbitrary `h` remains explicit. |
| 16 | Private `a=b`, private/public `h=0`, and nondifferentiable primitive | R13 | PARTIAL: generic private BODY covers `a=b` and `h=0`; public `h=0` regression compiles at `IMP001Regressions.lean:318–327`; nondifferentiable indicator example is PENDING-REG. |
| 17 | Arbitrary-`S` QL-shaped public-only consumer | R20 | EVIDENCED by `IMP001PublicUse.lean:27–70`; no QL/OLV or private IMP import/name. |
| 18 | Arbitrary-`S` T07 plus missing-`IntegrableOn` rejection | R21 | EVIDENCED by T07 BODY `Bochner.lean:13–50`, positive control `IMP001Regressions.lean:357–363`, and GUARD `IMP001PublicUse.lean:286–295`. |
| 19 | Existential T08, both directions, no bundled bound | R23 | EVIDENCED by T08 BODY, existential/below-start consumers, and fixed-`F`/bound GUARDS listed under R23. |
| 20 | Endpoint integrand values and below-`k` witness values irrelevant | R24, R23 | PARTIAL: below-`k` witness irrelevance is proved (`IMP001Regressions.lean:329–355`) and T07 initial-point update is proved (`IMP001PublicUse.lean:101–118`); full `f`-value invariance at `{k} ∪ S` for T01/T07/T08 is PENDING-REG. |
| 21 | T04 exact sign and value order | R09 | EVIDENCED by T04 BODY plus `a=k` and constant-prefix regressions `IMP001Regressions.lean:289–316`. |

Thus 13 edge rows are fully evidenced, 2 are partial (16 and 20), and 6 are
pending (5, 6, 7, 9, 10, 11). Again, these labels do not confer final-review
credit.

## Trust, imports, API, and local verification

The following commands were rerun locally at the exact candidate head; no
GitHub CI was invoked:

| Check | Result |
|---|---|
| `lake build` | exit 0; `Build completed successfully (2754 jobs)`; default build replayed the registered IMP regression target |
| Direct `lake env lean` on `Basic.lean`, `Bochner.lean`, and `Abel.lean` | all exit 0 |
| Direct `lake env lean` on both IMP test modules | both exit 0; exact public types printed by the regression module |
| `python3 scripts/validate_inventory.py` | exit 0; 148 occurrences, 31 notations, 32 entities, 34 evidence rows, 88 associations |
| `python3 scripts/validate_inventory.py --negative-tests` | exit 0; all 25 intentionally invalid copied fixtures rejected, followed by positive validation |
| Eight `#print axioms` reports | each reports only `propext`, `Classical.choice`, `Quot.sound`, exactly the packet allowlist |
| Forbidden-trust text scan | no production `axiom`, `sorry`, or `admit` in the three IMP modules |

Production import audit:

- `Basic.lean:1–2`: exactly `Mathlib.Data.Finset.Sort` and
  `Mathlib.MeasureTheory.Integral.DominatedConvergence`.
- `Bochner.lean:1–2`: exactly `LMLF.Integral.Improper.Basic` and
  `Mathlib.MeasureTheory.Integral.IntegralEqImproper`.
- `Abel.lean:1–5`: exactly `Basic` plus the four frozen Mathlib Abel imports.
- `Abel` and `Bochner` are independent siblings; neither imports the other.
- `LMLF/Results.lean:2–3` imports Abel and Bochner, so the maintained LMLF root
  reaches all three IMP modules.
- Test-only Mathlib support remains in the two `LMLFTest` modules and has not
  inflated the production imports.

Library-scale audit disposition: the mathematical layering is still
`Mathlib → Basic → {Bochner, Abel} → later consumers`; T08 owns endpoint
stitching, T06 owns weighted composition, all representation helpers remain
private, and the public surface contains exactly the frozen eight names. No
actionable nonanalytic API, trust, dependency, or regression gap was found in
this bounded mapping. The remaining gaps are precisely the supplemental
analytic Lean obligations identified above.

## Completion path without reopening the core proof

1. Complete the second fresh R2 supplemental natural-language review and root
   adjudication against the already bound R2 companion. This is a separate
   regression-only gate; do not reopen or replace the passed core R7
   `lean_ready` decision.
2. Only after that supplemental authorization, implement the pending analytic
   regressions for R04, R05, R06, R11, R12, the indicator part of R13, R22, and
   full R24 as nonpublic local tests. Do not change any of the eight public
   declarations or their premises.
3. Rerun the exact local build, direct module/test checks, inventory checks,
   import audit, and eight-name axiom audit at the resulting exact head.
4. Obtain the packet-required independent implementation-review quorum over
   that hash-bound candidate. This interim matrix must not be counted as one
   of those reviews.
