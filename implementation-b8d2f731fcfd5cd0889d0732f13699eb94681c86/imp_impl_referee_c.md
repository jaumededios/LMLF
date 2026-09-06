# IMP-001 implementation review — referee C

## Verdict

**APPROVE** under both assigned rubrics, `proof_quality` and
`api_dependency`. I found no material defect and have no requested change.
The findings list is empty.

This verdict binds candidate
`b8d2f731fcfd5cd0889d0732f13699eb94681c86` against base/spec
`3a1b16cae6d186a20530de3b883c1bb871ee76f6`, the pending implementation
review envelope at SHA-256
`1c7874b190ada114c60853a880b2ec2a56bbaba3fed261ccf7ad57b30e012ab7`,
`proof_quality` rubric SHA-256
`55baddf430dc9d7530e644217630a4f0905317e2a5b7bd16126036910a22ca19`,
and `api_dependency` rubric SHA-256
`4e5f947ed15f0101c46fe9bb0a12a013d66c7de3c7ed2c35fda817de8d92eb41`.
Source fidelity is `not_applicable`: the frozen packet is source-free and
makes no source-occurrence or source-coverage claim.

## Reviewer independence and isolation

- Durable reviewer ID: `/root/imp_impl_referee_c`.
- Runtime: fresh Codex multi-agent model-context fork on Linux x86_64,
  `gpt-5.6-sol`, high reasoning effort.
- Isolation strength: `manual_attestation`.
- Candidate checkout: fresh detached worktree
  `/tmp/imp-impl-ref-c.hWDZJOAR/checkout`, exact `HEAD` above, initially and
  finally clean (`## HEAD (no branch)`). The candidate source was not edited.
- Dependency reuse: only the already-pinned `.lake/packages` directory was
  symlinked from `/tmp/lmlf-imp-core.aZgav6tR`; no download, update, or pin
  change was performed. Pinned Mathlib was clean at
  `0df444a360eaa60ab8c11dca51a86af692955474`.
- I did not read predecessor or peer implementation verdicts, Stage 1 output,
  Verso output, or uncommitted candidate work. I read the authorized gate
  records and, after the root supplied the final binding, the proposer matrix
  at SHA-256
  `4852ace739c8dea0e2176004e6679b4c3aa968bd8143ed76794f099b87a11a63`.
  That matrix received no review credit; every conclusion below was checked
  against source and fresh local runs.
- Manual-isolation limits: the filesystem and pinned package cache were shared,
  and network/tool availability was not technically disabled. Independence is
  therefore an attestation, not a hardened clean-room guarantee. No CI was
  started and no external state was changed except writing this report and the
  two companion verdict JSON records.

## Bound artifacts checked

The exact core lean-ready envelope passed at SHA-256
`3e4ca4b00adf36fc6b85315f74dcc4349abcd17eb6ebaf7282c374a0499a56f5`.
The regression-only R2 supplement passed at SHA-256
`ee3fb545a1772eae460cfaa39ecf45b1d7d4c075461f2424577ee273dce25d9c`;
its scope is nonpublic analytic regression evidence only and it does not alter
any public target or premise. I checked the full packet, theorem card R7,
signature R6/P2, NLP R7, NLP REG-R2, both assigned rubrics, protocol, and
artifact schema. Their candidate-tree hashes are:

| Artifact | SHA-256 |
|---|---|
| `review/work_packets/IMP-001.yaml` | `e0f16a660417d967312df0f7cc7ce12ea1243226801b409475548566d594796b` |
| `blueprint/theorem_cards/IMP-001.yaml` | `d81f8970bcba3bf1a489f8cb4fea8b303a3e3bf6d1ad3ade37b42f3094b528c4` |
| `blueprint/theorem_cards/IMP-001-signatures-R6.md` | `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d` |
| `blueprint/proofs/IMP-001-R7.md` | `941ca0f2a7e402e9dd3636d7c93744290b3f5b52b8705484c18630c6fe173548` |
| `blueprint/proofs/IMP-001-REG-R2.md` | `316fc09bf3f35a5649f951ea0964ed1330e540d028a48c4706312d37c87ae7e9` |

The base-to-head diff of the frozen packet, card, signature, and core NLP was
empty. Candidate changes are confined to the three production modules, their
maintained-root imports, six nonpublic tests, the authorized regression proof
files, and test reachability in `lakefile.toml`.

## Proof-quality audit

I read all 1,460 production lines and all 2,951 lines in the six IMP-001 test
modules.

- `Basic.lean:13-52` implements the frozen recursive finite-component
  semantics and exact T01 body. Empty, bounded, and terminal components use
  independent endpoint limits; no singular prefix is collapsed into a
  totalized integral across a break.
- `Basic.lean:55-63` is the exact T05 body: above-start, continuity on `Ici k`,
  normalization, and the every-regular-subinterval integrability/increment
  law. It contains no limit, norm bound, or bounding constant.
- T08 is proved directly at `Basic.lean:743-771`, before T02/T03/T04. Its
  forward and reverse constructions recurse over sorted breaks and glue
  continuous primitives with the exact telescoping values. T02
  (`Basic.lean:773-918`) separately proves component-value/anchor independence
  and uniqueness from the defining finite endpoint semantics; it does not use
  T08 as a uniqueness shortcut.
- T03 (`Basic.lean:933-1003`) obtains the T08 witnesses, privately weakens every
  T05 witness to literal `s.biUnion S`, builds the mapped finite-sum primitive,
  and closes with T08 reverse. The theorem supports heterogeneous codomains and
  does not expose the chosen primitives.
- T04 (`Basic.lean:1006-1135`) uses T08 in both directions. Its reverse glue is
  the local prefix primitive on `[a,k]` followed by `J + F`; the limit and
  conclusion have the frozen `J + I` orientation. The `a = k` and nonzero
  constant-prefix tests both compile.
- The private Abel kernel (`Abel.lean:16-83`) sets
  `ν = volume.restrict (uIoc a b)`, derives integrability of `w` and `g` under
  that measure, proves the triangular indicator kernel integrable under
  `ν.prod ν`, and passes exactly that hypothesis to
  `intervalIntegral_integral_swap`. No global `StronglyMeasurable` or
  `AEStronglyMeasurable` premise is smuggled into T06.
- The exponential FTC helper (`Abel.lean:85-101`) derives the derivative through
  `HasDerivAt.exp`, whose pinned Mathlib body delegates to
  `Real.hasDerivAt_exp`. It divides by neither `h` nor an interval length, so
  `h = 0` and degenerate finite intervals remain valid.
- The private finite-piece identity (`Abel.lean:103-185`) uses only continuity
  and the every-point increment law of `F`, not a derivative of `F`. The
  transformed primitive (`Abel.lean:187-256`) maintains the same exceptional
  set, proves regular increments componentwise, and uses only T06's stated
  weighted integrability and boundary-limit premises. Public T06 closes via
  T08 reverse at `Abel.lean:259-269`.
- T07 is a sibling theorem in `Bochner.lean:45-50`. Its private canonical
  primitive is built solely from honest `IntegrableOn f (Ioi k)` and the exact
  above-`k` condition; there is no cycle through Abel or any downstream LMLF
  development.
- Production automation is restrained: local arithmetic uses `linarith`, and
  module identities use `module`; there is no broad `simp_all`, `aesop`, opaque
  search, or resource override introduced by this candidate. The pre-existing
  project option `maxSynthPendingDepth = 3` is unchanged from the base. Fresh
  compilation was warning-free and completed in 14.641 seconds.

The public axiom audit reports exactly `[propext, Classical.choice, Quot.sound]`
for all eight declarations. Source scans found no `sorry`, `admit`, production
`axiom`, `unsafe`, or candidate-added `set_option`. The private use of
`Classical.choose` in T03 stays within the accepted axiom allowlist and does not
create a public selected-primitive API.

## API and dependency audit

The production declaration scan found exactly the frozen eight public
declarations and 29 private helpers:

1. `HasImproperIntegralAtTopExcept`
2. `IsFiniteExceptionalPrimitive`
3. `hasImproperIntegralAtTopExcept_iff_exists_primitive`
4. `HasImproperIntegralAtTopExcept.unique`
5. `HasImproperIntegralAtTopExcept.finset_clm`
6. `HasImproperIntegralAtTopExcept.split_regular`
7. `IsFiniteExceptionalPrimitive.hasImproperIntegralAtTopExcept_exp_smul`
8. `HasImproperIntegralAtTopExcept.of_integrableOn_Ioi`

There is no public ninth declaration, wrapper, constructor, eliminator, anchor
API, or value selector. The exact public API probe at SHA-256
`6b3aa43462802151d3bc88c4f0fdf515b0459eab110511a1ec8304cb62bfeaad`
compiled. The private-name probe at SHA-256
`bb95d0f333d29660b3bc99e76b326ed846e7531589e047d81010116e0bf70a83`
failed as intended with four `lean.unknownIdentifier` diagnostics for both
private representations and both private Abel helpers.

Dependency direction is acyclic and downward:

```text
Mathlib ──> Basic <── Bochner
              ^       
              └── Abel

LMLF.Results ──> Abel + Bochner
LMLFTest     ──> production modules (and Mathlib/test-only support)
```

`Basic` imports two Mathlib modules only. `Abel` and `Bochner` each import
`Basic` plus their direct Mathlib requirements; neither imports Results, QL,
OLV, Watson, source, Gamma, QB, DEF, or audit modules. `LMLF.Results` adds only
the two sibling module imports. All six tests are explicit `LMLFTest` globs and
are included in the default build. The one test-to-test edge, Oscillatory to
Regressions, remains entirely below the nonpublic test boundary.

I also inspected the pinned dependency implementations actually used by the
delicate proof seams: `Integrable.smul_prod` and
`intervalIntegral_integral_swap` in
`Mathlib/MeasureTheory/Integral/Prod.lean`, `Real.hasDerivAt_exp` and
`HasDerivAt.exp` in `Mathlib/Analysis/SpecialFunctions/ExpDeriv.lean`, the
`Ioi` improper-integral/change-of-variable lemmas in
`Mathlib/MeasureTheory/Integral/IntegralEqImproper.lean`, and the real Gamma
integral/convergence interface in
`Mathlib/Analysis/SpecialFunctions/Gamma/Basic.lean`. The candidate uses those
interfaces at their stated pinned types and does not duplicate a missing
Mathlib abstraction as public LMLF API.

## Regression obligations IMP-R01–IMP-R25

All 25 mandatory obligations were independently traced to compiled body,
consumer, guard, or authorized nonpublic analytic evidence:

| IDs | Verified evidence |
|---|---|
| R01–R03 | Exact T01 body; empty-set projection/equivalence/zero tests; T08 empty/multipoint directions and explicit two-point round-trip. |
| R04–R06 | `principalValueCutoff_rejected`, `conditionalFiniteCutoff`, and `sinDivTail_conditional` establish respectively PV-only rejection, independent conditionally convergent finite sides with non-L1 behavior, and conditional infinity without `IntegrableOn`. |
| R07–R10 | Honest regular-piece projections and failing totalization guard; the complete finite CLM suite (empty, two-term literal union, negation, real/complex maps and cross-codomain maps); split degenerate/sign tests; exact T05/no-bound guards. |
| R11–R13 | Discontinuous primitive and endpoint-only counterexamples; private degenerate algebra, public `h=0`, and the bounded eventually constant clipped primitive, including explicit nondifferentiability at both corners. |
| R14–R19 | Independent exceptional-component body; downward import/axiom audit; prior core and supplemental authorization gates; T03 weaken/map/T08 route; restricted-product local Fubini proof; pinned exponential derivative/no-division route. |
| R20–R21 | Arbitrary-S bounded-primitive public consumer and arbitrary-S T07 positive/negative `IntegrableOn` guard. |
| R22 | Translated square-root/Gamma positive example and conditional non-L1 initial-endpoint rejection. |
| R23–R24 | T08 existential/no-bound guards, below-`k` witness irrelevance, and full updates on `{k} ∪ S` transported through intervals, `Ioi`, T05, T08, T01, and T07. |
| R25 | `source_shaped_public_chain_one_model` starts with an explicit T01 witness, uses only public T07/T03/T04/T08/T06, derives the separate flat bound, and imports no downstream QL/OLV module. |

## All 21 theorem-card edge obligations

| # | Edge | Result |
|---:|---|---|
| 1 | Empty exceptional set gives ordinary right-endpoint semantics | PASS — R02 compiled equivalence. |
| 2 | T08 empty/multiple-point exact telescope | PASS — body plus R03 round-trip. |
| 3 | Amplitude on `S` plus smooth empty-set terms concludes on `S` | PASS — literal-union CLM and public consumer. |
| 4 | T03 cross-codomain scalar transports | PASS — real/complex and complex/real tests. |
| 5 | PV-only one-over-distance singularity rejected | PASS — R04 analytic theorem. |
| 6 | Conditional one-sided finite singularity accepted | PASS — R05 analytic theorem. |
| 7 | `sin(t)/t` not strengthened to absolute integrability | PASS — R06 analytic theorem. |
| 8 | Nonintegrable truncation cannot pass totalization | PASS — R07 projection and failing guard. |
| 9 | Square-root accepted versus conditional non-L1 initial singularity rejected | PASS — both R22 theorems. |
| 10 | Discontinuous componentwise primitive cannot telescope | PASS — R11 counterexample. |
| 11 | Endpoint equality cannot replace every-point increments | PASS — R12 counterexample. |
| 12 | Exceptional prefix is not one interval integral | PASS — recursive T01 and T06 body audit. |
| 13 | Exact restricted-product integrable kernel | PASS — `ν.prod ν` proof inspected. |
| 14 | Measure-local measurability without global premise | PASS — indicator/product integrability inspected. |
| 15 | `Real.hasDerivAt_exp`, no division by `h` | PASS — pinned source and helper inspected. |
| 16 | Private `a=b`/`h=0`, public `h=0`, nondifferentiable primitive | PASS — body and R13 tests. |
| 17 | Arbitrary-S QL-shaped public-only consumer | PASS — R20. |
| 18 | Arbitrary-S T07 and missing-`IntegrableOn` rejection | PASS — R21 positive and `fail_if_success` guard. |
| 19 | Existential T08 both ways, no quantitative bound | PASS — body, positive use, and two guards. |
| 20 | Endpoint and below-start witness values irrelevant | PASS — R23/R24 transport theorems. |
| 21 | T04 exact sign and value order | PASS — same-start and nonzero constant-prefix tests. |

## Fresh command record

- `lake build` — exit 0; `Build completed successfully (2766 jobs)`; wall
  `0m14.641s`, user `0m48.410s`, system `0m12.808s`.
- Direct `lake env lean` on each of `Basic.lean`, `Bochner.lean`, `Abel.lean`,
  and all six IMP-001 test modules — exit 0 as a set.
- `python3 scripts/validate_inventory.py` — exit 0; 148 occurrences, 31
  notations, 32 entities, 34 evidence rows, 88 associations.
- `python3 scripts/validate_inventory.py --negative-tests` — exit 0; all 25
  intentionally invalid copied fixtures rejected, then the positive inventory
  passed.
- Public API probe — exit 0. Private-name probe — expected exit 1, with exactly
  four unknown-identifier errors and no other diagnostic.
- Disposable eight-declaration `#print axioms` audit — exit 0; every result was
  exactly the accepted three axioms.
- Library inventory script — exit 0; 16 Lean files / 4,623 lines, expected
  import graph, and empty trust/resource-marker section.
- `git diff --check base..head` and frozen-artifact `git diff --exit-code` —
  exit 0. Trust/resource and public-declaration scans produced the results
  stated above.

Two preliminary command typos did not exercise candidate code: an unavailable
`/usr/bin/time` binary returned 127 before `lake` ran, and a first direct-compile
invocation used the non-existent pre-refactor path `LMLF/Improper/...` and
returned 1. I immediately used the shell `time` builtin and the correct
`LMLF/Integral/Improper/...` paths; the successful results above are from those
corrected fresh runs. A disposable axiom file likewise first named a
non-existent `LMLF.Integral.Improper.Results` umbrella, then compiled at exit 0
after importing the actual maintained root `LMLF.Results`.

Issued at `2026-09-06T18:30:00Z`.
