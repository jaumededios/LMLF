# IMP-001 implementation review — referee A

## Verdict

Candidate `b8d2f731fcfd5cd0889d0732f13699eb94681c86` is **approved** under both assigned rubrics:

| Rubric | Verdict | Findings |
|---|---|---:|
| `quantitative_correctness` | `approve` | 0 |
| `proof_quality` | `approve` | 0 |

I found no false, vacuous, totalization-dependent, unauditable, or trust-extending implementation claim. The eight frozen public declarations match their signatures, the production arguments match the reviewed core R7 mathematics, and all 25 frozen regressions plus all 21 theorem-card edge obligations have substantive compiled evidence. The separately authorized R2 analytic regressions do not change a public target or premise.

## Identity, binding, and isolation

- Reviewer: `/root/imp_impl_referee_a`; model `gpt-5.6-sol`, high reasoning effort, Codex desktop child-agent runtime.
- Isolation: manual attestation, not a hardened clean-room runner. I created detached worktree `/tmp/imp-impl-ref-a.a93BMmNq/checkout` from the supplied candidate repository and verified its exact HEAD. I reused only the already-pinned package checkout by symlinking `.lake/packages` to `/workspace/Documents/Codex/2026-09-05/yo/.lake/packages`.
- Candidate/source files were not edited. Local Lean compilation generated ignored `.lake/build` artifacts. The candidate worktree remained clean after review. I did not invoke CI, commit, push, delegate, or read any peer/predecessor implementation report or Stage-1/Verso review.
- Base/specification: `3a1b16cae6d186a20530de3b883c1bb871ee76f6`.
- Candidate: `b8d2f731fcfd5cd0889d0732f13699eb94681c86`.
- Pending implementation envelope: SHA-256 `1c7874b190ada114c60853a880b2ec2a56bbaba3fed261ccf7ad57b30e012ab7`.
- Work packet: SHA-256 `e0f16a660417d967312df0f7cc7ce12ea1243226801b409475548566d594796b`.
- Theorem card/signature artifact: `d81f8970bcba3bf1a489f8cb4fea8b303a3e3bf6d1ad3ade37b42f3094b528c4` / `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d`.
- Core/supplemental natural-language proofs: `941ca0f2a7e402e9dd3636d7c93744290b3f5b52b8705484c18630c6fe173548` / `316fc09bf3f35a5649f951ea0964ed1330e540d028a48c4706312d37c87ae7e9`.
- Core/supplemental passing authorization envelopes: `3e4ca4b00adf36fc6b85315f74dcc4349abcd17eb6ebaf7282c374a0499a56f5` / `ee3fb545a1772eae460cfaa39ecf45b1d7d4c075461f2424577ee273dce25d9c`.
- Toolchain: `leanprover/lean4:v4.33.1`; manifest SHA-256 `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`; Mathlib exact HEAD `0df444a360eaa60ab8c11dca51a86af692955474`.
- Final proposer matrix was read only after independent source/test inspection and is treated as untrusted supporting evidence: SHA-256 `4852ace739c8dea0e2176004e6679b4c3aa968bd8143ed76794f099b87a11a63`. Its public/private probe hashes were independently verified as `6b3aa43462802151d3bc88c4f0fdf515b0459eab110511a1ec8304cb62bfeaad` and `bb95d0f333d29660b3bc99e76b326ed846e7531589e047d81010116e0bf70a83`.
- Source fidelity is not applicable: the packet is source-free and makes no source-occurrence, transcription, or coverage claim.

## Public targets and mathematical review

I read the full bodies of all three production modules and checked every public target against the frozen signatures and R7 proof.

| Target | Independent assessment |
|---|---|
| T01 | `HasImproperIntegralAtTopExcept` is the exact finite-break relation: honest interval integrability on each regular piece, independent one-sided limits, and the correct component sum. It does not accept a totalized integral alone. |
| T02 | `unique` reduces through the primitive characterization and uniqueness of the at-top limit; it proves uniqueness of the claimed value rather than assuming it. |
| T03 | `finset_clm` selects T08 witnesses, weakens each primitive to the literal `s.biUnion S`, forms the continuous-linear-map finite sum, and proves the summed at-top limit. Empty and cross-codomain cases are genuine public consumers. |
| T04 | `split_regular` has the frozen `a ≤ k` orientation and value `(∫ a..k, f) + I`; the constant-prefix regression verifies the sign and order, including `a = k`. |
| T05 | `IsFiniteExceptionalPrimitive` has exactly the five authorized components. It contains no target limit, derivative premise, or bundled quantitative bound. |
| T06 | The Abel proof uses a private restricted-product Fubini identity with precisely `(volume.restrict (uIoc a b)).prod ν`, the scalar FTC from `HasDerivAt.exp`, and a transformed primitive passed to T08. It never divides by `h`; `h = 0`, `a = b`, and the nondifferentiable clipped-ramp primitive are covered. |
| T07 | The Bochner bridge constructs the canonical primitive from an actual `IntegrableOn f (Ioi k)` hypothesis and then uses T08. It does not rely on favorable totalization. |
| T08 | Both directions are explicit finite-break recursion over the canonical order. Empty and multiple-break telescoping, continuity at breaks, below-start irrelevance, and existential quantifier shape are exercised. |

The direct public declaration scan found exactly two definitions and six theorems, with no extra public declaration in the three production modules. The two sibling modules remain independent and are both reached from `LMLF/Results.lean`.

## Regression and edge coverage

I independently read all six test modules and checked the theorem statements and supporting proofs, rather than crediting names or the proposer matrix alone.

| Regression | Verified evidence |
|---|---|
| R01 | Exact T01 binder/body and above-start premise projection. |
| R02 | Empty-set zero witness and exact iff with honest truncation integrability plus limit. |
| R03 | Empty and arbitrary two-point specialization of real T08 recursion. |
| R04 | Symmetric principal value tends to zero while every T01 value is rejected. |
| R05 | Two finite one-sided limits, explicit T05 primitive, exact T01 value, and non-`L¹` behavior on every neighborhood. |
| R06 | `sin t / t` obtains T01 convergence and proves failure of `IntegrableOn (Ioi 1)`. |
| R07 | Honest integrability projection/reconstruction plus a compiled missing-integrability type guard. |
| R08 | Empty/two-term union, negation, real smul, complex multiplication, and both cross-codomain maps. |
| R09 | `a = k` and nonzero constant-prefix orientation/sign. |
| R10 | Exact T05 fields and compiled rejection of a nonexistent bound field. |
| R11 | Discontinuous primitive satisfies the other local/weighted premises but yields a jump contradiction. |
| R12 | Endpoint agreement without every-point increments fails at an interior point and under every positive Abel weight. |
| R13 | Private arbitrary-`h`/degenerate-interval route, public `h = 0`, and exact nondifferentiable clipped-ramp example. |
| R14 | Split-component T01 body and transformed-primitive T06 body avoid treating a singular prefix as one ordinary integral. |
| R15 | Frozen imports, no trust markers, and allowed axiom set only. |
| R16 | Exact-hash core gate passes; separate R2 gate authorizes only the stated nonpublic analytic regressions. |
| R17 | Literal-union T03 implementation and no consumer reliance on sorted/private representation. |
| R18 | Exact restricted-product `Integrable` kernel and measure-local measurability. |
| R19 | Pinned `Real.hasDerivAt_exp` route with no division by `h`. |
| R20 | Public-only arbitrary-`S` consumer derives integrability and boundary limit from separate hypotheses. |
| R21 | Arbitrary-`S` T07 positive use and compiled omission-of-`IntegrableOn` guard. |
| R22 | Positive square-root/Gamma endpoint and conditional non-`L¹` negative endpoint examples. |
| R23 | Existential T08 in both directions, below-`k` witness replacement, fixed-primitive and bundled-bound guards. |
| R24 | Generic `{k} ∪ S` endpoint AE invariance for interval/set integrals, T05, T08, T01, and T07 transport. |
| R25 | Source-shaped public chain uses T07/T03/T04/T08/T06 and derives the flat bound separately. |

The 21 card edges are all independently discharged: (1) empty reduction R02; (2) empty/multiple telescope R03; (3) amplitude-on-`S` recombination R08/R17; (4) cross-codomain maps R08; (5) principal-value rejection R04; (6) accepted conditional finite singularity R05; (7) nonabsolute sine tail R06; (8) totalization resistance R07; (9) positive/negative initial endpoints R22; (10) discontinuous primitive R11; (11) endpoint-only insufficiency R12; (12) no singular-prefix ordinary integral R14; (13) exact product measure R18; (14) measure-local measurability R18; (15) exponential derivative/no division R19; (16) `a=b`, `h=0`, and nondifferentiability R13; (17) arbitrary-`S` public consumer R20; (18) arbitrary-`S` T07 guard R21; (19) existential/no-bound T08 R23; (20) endpoint and below-start irrelevance R24/R23; and (21) exact T04 sign/value order R09.

## Proof quality, trust, and dependency inspection

- The private helpers have distinct mathematical roles: break decomposition, interval reconstruction, finite recursion, canonical primitive construction, restricted-product Fubini, scalar weighted FTC, and transformed primitive packaging. The long Basic proof is segmented by these roles and its public theorem is short and auditable.
- Production uses focused rewriting, `simp`, and elementary `linarith`; there is no broad search automation, custom tactic, global special-function unfolding, heartbeat/recursion escape, or fragile coercion-heavy computation.
- A lexical scan of all three production files and all six tests found no `sorry`, `admit`, `axiom`, `unsafe`, `maxHeartbeats`, or `maxRecDepth` marker.
- A disposable `#print axioms` audit covered all eight public declarations and the headline analytic regression theorems. Every entry reported exactly `[propext, Classical.choice, Quot.sound]`.
- I inspected the pinned source statements and proofs for `intervalIntegral_integral_swap` (`Mathlib/MeasureTheory/Integral/Prod.lean:487`), `integrableOn_Ioi_comp_rpow_iff` (`IntegralEqImproper.lean:1220`), `Real.GammaIntegral_convergent` (`Gamma/Basic.lean:66`), `Real.Gamma_eq_integral` (`Gamma/Basic.lean:405`), and `Real.hasDerivAt_exp` / `HasDerivAt.exp` (`ExpDeriv.lean:267,304`). Their use matches the same mathematical substeps and does not import a regression conclusion.
- All six tests are explicit `LMLFTest` globs and part of the default build. Public-use tests consume public names; private helpers remain inaccessible. The negative probe failed only with the four expected `lean.unknownIdentifier` diagnostics.

## Commands and outcomes

All commands ran from the detached fresh worktree unless an absolute probe path is shown.

| Command/check | Outcome |
|---|---|
| `git rev-parse HEAD`; base resolution; `git diff --check base..HEAD` | exit 0; exact bound SHAs; no whitespace error |
| Initial fresh `lake build` | exit 0; `Build completed successfully (2766 jobs)` |
| Final `lake build` | exit 0; all 2,766 jobs valid; only the intentional eight `#check` info messages |
| `lake env lean` on `Basic.lean`, `Bochner.lean`, and `Abel.lean` | each exit 0 |
| `lake env lean` on all six exact `IMP001*.lean` test modules | each exit 0 |
| `python3 scripts/validate_inventory.py` | exit 0; 148 occurrences, 31 notations, 32 entities, 34 evidence rows, 88 associations |
| `python3 scripts/validate_inventory.py --negative-tests` | exit 0; all 25 invalid copied fixtures rejected, then inventory passed |
| Library inventory script | exit 0; 16 Lean files, 4,623 lines, no trust/resource marker |
| Exact public-declaration scan | exit 0; exactly 8 entries |
| Trust/resource `rg` scan | exit 1 with no matches, expected |
| Disposable public probe | exit 0; all eight exact public names resolve with expected types |
| Disposable private probe | exit 1, expected; exactly four unknown-identifier errors and no environment error |
| Disposable `#print axioms` audit | exit 0; allowlist only for public API and headline regressions |
| SHA-256 ledger verification | exit 0; all candidate and supplied evidence hashes matched |
| Pinned Mathlib HEAD/status and source inspection | exit 0; exact revision, clean package checkout |
| Final candidate `git status --short` | exit 0 with no output |

One initial direct-test loop used the nonexistent paths `PublicUse.lean` and `Regressions.lean` without the required `IMP001` filename prefix; it stopped at the first missing file with exit 1. This was a command typo, not a Lean diagnostic. I reran all six exact registered paths listed in `lakefile.toml`, each exit 0, as recorded above.

No action is required for either assigned rubric. This approval is limited to the exact candidate, artifacts, toolchain, and dependency pin recorded here.
