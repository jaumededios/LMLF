# IMP-001 implementation review — referee B

- Reviewer: `/root/imp_impl_referee_b`
- Model/runtime: `gpt-5.6-sol` with high reasoning; Codex desktop agent runtime on Linux x86_64
- Isolation: `manual_attestation`
- Candidate: `b8d2f731fcfd5cd0889d0732f13699eb94681c86`
- Base/specification: `3a1b16cae6d186a20530de3b883c1bb871ee76f6`
- Toolchain: Lean 4.33.1 (`819816b2e0a3bf405af45ae5c7af2491d8f5bee6`), Lake 5.0.0
- Mathlib: `0df444a360eaa60ab8c11dca51a86af692955474`
- Review scope: `mathlib_reuse` and `api_dependency`
- Issued: `2026-09-06T18:28:25Z`

## Verdict

**Approve `mathlib_reuse`. Approve `api_dependency`.** I found no material rubric-scoped defect and have no actionable findings.

Source fidelity is not applicable: this is the source-free reusable-infrastructure packet recorded by the frozen work packet. The regression results below establish implementation and boundary behavior only; they do not claim source coverage.

## Binding and isolation

I reviewed a fresh detached worktree at `/tmp/imp-impl-ref-b.6zMdrSC6/checkout`, independently resolved `HEAD` to the candidate SHA, and reused only the already-pinned package checkout by a disposable ignored `.lake/packages` symlink. I made no candidate changes, did not run CI, did not delegate, and did not read peer/predecessor verdict reports, Stage 1/Verso material, or uncommitted candidate files. Temporary probes were created outside the checkout. The original candidate checkout remained clean at the bound head.

The review is bound to:

- implementation review envelope SHA-256 `1c7874b190ada114c60853a880b2ec2a56bbaba3fed261ccf7ad57b30e012ab7`;
- work packet SHA-256 `e0f16a660417d967312df0f7cc7ce12ea1243226801b409475548566d594796b`;
- theorem card R7 SHA-256 `d81f8970bcba3bf1a489f8cb4fea8b303a3e3bf6d1ad3ade37b42f3094b528c4`;
- frozen signatures R6/P2 SHA-256 `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d`;
- core proof R7 SHA-256 `941ca0f2a7e402e9dd3636d7c93744290b3f5b52b8705484c18630c6fe173548`;
- supplemental regression proof R2 SHA-256 `316fc09bf3f35a5649f951ea0964ed1330e540d028a48c4706312d37c87ae7e9`;
- core authorization envelope SHA-256 `3e4ca4b00adf36fc6b85315f74dcc4349abcd17eb6ebaf7282c374a0499a56f5`;
- supplemental authorization envelope SHA-256 `ee3fb545a1772eae460cfaa39ecf45b1d7d4c075461f2424577ee273dce25d9c`;
- `lake-manifest.json` SHA-256 `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`.

I read the final proposer matrix at SHA-256 `4852ace739c8dea0e2176004e6679b4c3aa968bd8143ed76794f099b87a11a63` only as untrusted proposer evidence and independently checked its relevant claims.

## Mathlib reuse audit

I searched the existing project before the pinned Mathlib source. No pre-existing LMLF declaration provides finite-exceptional ordinary-improper endpoint semantics or the normalized primitive predicate. In pinned Mathlib, searches for `HasImproperIntegral`, `ImproperIntegral`, finite exceptional primitives, interval-integral limits, and the named analytic seams found support for ordinary set integrals and their limits, but no substitute for T01, T05, or T08.

| Candidate family | Closest pinned/local candidates and exact comparison | Assessment |
|---|---|---|
| T01 `HasImproperIntegralAtTopExcept` | Mathlib's `MeasureTheory.intervalIntegral_tendsto_integral_Ioi` starts from `IntegrableOn f (Ioi a)` and yields one regular at-top limit. It has no finite sorted breakpoints or independent one-sided endpoint limits. No local predecessor exists. | Project-local relation is necessary; the exact frozen recursive component semantics are implemented privately. |
| T05 and T08 | `intervalIntegral.continuousOn_primitive_interval'` and `IntegrableOn.continuousOn_Ici_primitive_Ioi` supply canonical continuity facts but do not express a normalized continuous primitive across finitely many exceptional points or its equivalence to T01. | Local abstraction is justified by multiple consumers (T03, T04, T06, T07 and tests); canonical continuity lemmas are reused inside it. |
| T02 uniqueness | `tendsto_nhds_unique` and `intervalIntegral.integral_add_adjacent_intervals` are the canonical componentwise tools. | Reused directly. T02 is proved from private component-value uniqueness and does not route through T08. |
| T03 finite CLM law | Closest exact pieces are `Finset.biUnion`, `IntervalIntegrable.sum`, `tendsto_finsetSum`, `ContinuousLinearMap.integrable_comp`, and `ContinuousLinearMap.intervalIntegral_comp_comm`. None knows the project relation or exceptional-set weakening. | All canonical algebra/integration pieces are reused. The only local adapter, `IsFiniteExceptionalPrimitive.weaken`, is private and needed to reach the literal `s.biUnion S` before T08 reverse. |
| T04 regular split | Mathlib has interval additivity and primitive continuity, but no split theorem for T01. | Local bridge is required and reuses interval-integral additivity; the value orientation remains exactly `prefix + I`. |
| T06 Abel bridge | Closest exact facts are `MeasureTheory.intervalIntegral_integral_swap`, `intervalIntegral.integral_eq_sub_of_hasDerivAt_of_le`, `Real.hasDerivAt_exp`, interval additivity, and `MeasureTheory.intervalIntegral_tendsto_integral_Ioi`. Mathlib has no theorem with the finite-exception primitive hypotheses and exact target value. | The private finite-piece identity is an appropriate dependency boundary. Its Fubini kernel is integrable only under `(volume.restrict (uIoc a b)).prod ...`; no global measurability premise is added, and the exponential proof divides by neither `h` nor any derivative. |
| T07 Bochner bridge | The exact Mathlib backbone is `IntegrableOn.continuousOn_Ici_primitive_Ioi`, `intervalIntegral.integral_Ioi_sub_Ioi`, `intervalIntegrable_iff_integrableOn_Ioc_of_le`, interval additivity, and `intervalIntegral_tendsto_integral_Ioi`. | The public theorem is a justified bridge into the project relation, not a duplicate integral theory. Its construction package stays private. |
| Analytic regression support | Pinned `MeasureTheory.integrableOn_Ioi_comp_rpow_iff`, `Real.GammaIntegral_convergent`, `Real.Gamma_eq_integral`, and `Real.Gamma_pos_of_pos` are used in nonpublic tests. | Reuse is direct and test-only; no Gamma, P-series, periodicity, or source dependency leaks into production. |

The final `MathlibSeamProbe.lean` checked all named declarations above at the resolved pin and exited 0. The production imports are narrow and exactly frozen: Basic imports `Mathlib.Data.Finset.Sort` and `Mathlib.MeasureTheory.Integral.DominatedConvergence`; Abel imports Basic plus ExpDeriv, FundThmCalculus, Prod, and IntegralEqImproper; Bochner imports Basic plus IntegralEqImproper. I found no overlooked exact theorem, duplicate foundational object, unjustified wrapper, or unnecessary production umbrella import.

## API and dependency audit

All eight target signatures, binder orders, namespaces, implicit arguments, hypotheses, conclusions, theorem/coverage/novelty classifications, and intended consumers match the frozen card. The source-declaration inventory is exactly two definitions plus six theorems:

1. `HasImproperIntegralAtTopExcept`
2. `IsFiniteExceptionalPrimitive`
3. `hasImproperIntegralAtTopExcept_iff_exists_primitive`
4. `HasImproperIntegralAtTopExcept.unique`
5. `HasImproperIntegralAtTopExcept.finset_clm`
6. `HasImproperIntegralAtTopExcept.split_regular`
7. `IsFiniteExceptionalPrimitive.hasImproperIntegralAtTopExcept_exp_smul`
8. `HasImproperIntegralAtTopExcept.of_integrableOn_Ioi`

Lean may generate internal elaboration/simplifier auxiliaries such as `.congr_simp` and theorem proof auxiliaries; there is no ninth source declaration, wrapper, constructor/eliminator, anchor API, or value function. The positive public probe at SHA-256 `6b3aa43462802151d3bc88c4f0fdf515b0459eab110511a1ec8304cb62bfeaad` resolved all eight. The negative probe at SHA-256 `bb95d0f333d29660b3bc99e76b326ed846e7531589e047d81010116e0bf70a83` exited 1 with four expected `Unknown identifier` diagnostics for the two recursive representation names and the two Abel finite-piece names.

Dependency direction is:

```text
Mathlib
   ↓
Improper.Basic
   ├──→ Improper.Abel
   └──→ Improper.Bochner
             ↓
        LMLF.Results (imports both siblings)
```

Abel and Bochner are independent siblings: neither imports nor references the other's public bridge. Basic imports neither sibling. No production IMP module imports QL, OLV, Watson, source, Gamma, QB, DEF, Audit, or a downstream test module. `LMLF.Results` adds only the two required IMP sibling imports and no declaration. The six nonpublic regression modules are a separate `LMLFTest` library; their authorized Mathlib and one test-to-test import do not inflate production dependencies.

The prescribed proof-route boundaries also hold:

- T08 alone implements the forward/reverse primitive equivalence over the private sorted representation.
- T02 is independently componentwise and does not call T08.
- T03 extracts T05 witnesses through T08, weakens each to literal `s.biUnion S`, builds the cross-codomain CLM sum, and invokes T08 reverse.
- T06 owns its private restricted-product Fubini/Abel machinery and invokes T08 reverse.
- T07 owns its private canonical Bochner primitive package and invokes T08 reverse.
- The T06 and T07 packages share Basic but are independent siblings.

## Regression and edge audit

I read all six test modules completely and compiled them independently. IMP-R01 through IMP-R25 are all represented by either exact target/body inspection, static architectural inspection, a positive theorem, or a typed negative guard. The mapping checked was:

- R01–R03: exact T01/T05 shape, empty-set semantics, and two-point T08 round trip in `IMP001Regressions`.
- R04–R06: PV rejection, conditional finite singularity, and conditionally convergent non-L1 tail in `IMP001Oscillatory`.
- R07–R10: honest integrability/totalization guard, all specified finite CLM cases, split orientation/degeneracy, and T05 field boundary in `IMP001Regressions`.
- R11–R13: discontinuous primitive, endpoint-only failure, `h = 0`, and nondifferentiable clipped primitive in `IMP001AbelExamples` plus `IMP001Regressions`.
- R14–R19: private recursive component semantics, import/axiom boundary, authorization records, T03 literal-union route, restricted-product Fubini kernel, and the exact exponential derivative/no-division route by production inspection.
- R20–R21: arbitrary-`S` public Abel consumer, arbitrary-`S` T07, and the missing-integrability guard in `IMP001PublicUse`/`IMP001Regressions`.
- R22: positive square-root/Gamma endpoint and conditionally improper non-L1 endpoint in `IMP001GammaEndpoint` and `IMP001Oscillatory`.
- R23–R25: below-`k` primitive irrelevance, fixed-witness T08 negative guard, finite-endpoint invariance, separate flat-bound derivation, and the full source-shaped public chain in `IMP001Regressions`, `IMP001EndpointAE`, and `IMP001PublicUse`.

This also discharges the 21 card-edge obligations: each edge maps to one or more of the inspected R02–R24 checks, while R25 verifies the downstream public route. The supplemental analytic mathematics is within the passing R2 authorization and introduces no public target or premise change.

## Commands and results

| Check | Result |
|---|---|
| `library_inventory.sh <fresh-worktree>` | exit 0; 16 Lean files, 4623 lines, no trust/resource markers |
| `lake build` | exit 0; 2766 jobs, both `LMLF` and `LMLFTest` targets built |
| `lake env lean` on Basic, Abel, Bochner, `LMLF/Results.lean`, and all six IMP001 test modules | ten correct module invocations, each exit 0 |
| final public API probe | exit 0 |
| private-name negative probe | exit 1 as required; exactly four unknown identifiers |
| eight-declaration `#print axioms` probe | exit 0; every report is exactly within `[propext, Classical.choice, Quot.sound]` |
| final pinned Mathlib seam/signature probe | exit 0 |
| public namespace environment inventory | exit 0; eight source declarations plus generated proof/simp auxiliaries, no authored extra API |
| `python3 scripts/validate_inventory.py` | exit 0; 148 occurrences, 31 notations, 32 entities, 34 evidence rows, 88 associations |
| `python3 scripts/validate_inventory.py --negative-tests` | exit 0; all 25 invalid fixtures rejected, then inventory validation passed |
| `git diff --check base..head` | exit 0 |
| forbidden production import and sibling-cycle scans | no matches (each `rg` exit 1, the expected no-match status) |
| trust-marker scan over production/tests | zero matches |
| original candidate `git status --short` | exit 0, empty |

For completeness, an initial probe before building project oleans failed with `unknown module prefix LMLF`; after the isolated `lake build`, the same public probe passed. I also initially entered the nonexistent path `LMLF/Integral/Improper/Results.lean` (exit 1); the maintained root is `LMLF/Results.lean`, whose corrected invocation exited 0. Neither diagnostic reflects a candidate defect.

The library-referee workflow materially shaped this review: it required the fixed-snapshot inventory, local-before-Mathlib search, exact pinned-source signature comparison, full import graph, public/private boundary, and all-target reuse assessment rather than accepting the proposer matrix or build alone.
