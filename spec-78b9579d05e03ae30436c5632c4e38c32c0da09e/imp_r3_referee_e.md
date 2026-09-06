# IMP-001 revision-3 exact-commit proof referee E

## Review identity and method

- Reviewer ID: `imp_r3_referee_e`
- Reviewer kind: agent
- Model: `gpt-5.6-sol`
- Reasoning effort: `xhigh`
- Runtime: OpenAI Codex subagent; service tier inherited/default; no build hash was exposed
- Review stage: pre-Lean
- Perspectives: proof correctness, quantitative/analytic correctness, dependency direction, source-to-target reachability, and hypothesis/choice laundering
- Candidate commit: `78b9579d05e03ae30436c5632c4e38c32c0da09e`
- Candidate tree: `c679e1f4f43b11c696a52b64cbea226762079a27`
- Candidate parent: `8993687d9600f644eddd4f5b3cb2725dcdf8d8f2`
- Candidate subject: `docs: correct improper refinement bookkeeping`
- Snapshot method: `git archive` of the exact candidate commit, expanded at `/tmp/imp-r3-referee-e.GTT4w8`; the candidate live worktree, prior-commit diffs, and existing external review/evidence files were not inspected.
- Isolation strength: manual attestation, not technically enforced.
- Isolation deviation: after completing the artifact reading and my independent T01--T06 derivation, I used the collaboration status listing solely to look for model metadata. Its response unexpectedly embedded completed agent outputs, including IMP-related material. I did not use that material, and the mathematical conclusions below had already been reached, but this violated the requested no-other-agent-output condition. Consequently this report must not count as an independent quorum approval. The separately spawned referee F was not affected.
- Repository mutation: none. No candidate file was edited and no Lean implementation/prototype was created.

## Exact artifact bindings

| Artifact | Revision/status | SHA-256 |
|---|---|---|
| Candidate `git archive --format=tar` stream | exact commit | `adbd421377cb89b68431f1811c71a1f86d44bbb529585b2d3f11267560e210b9` |
| User brief `pasted-text.txt` | 1,753 lines, read completely | `6787cdb628a66783d81190939e9593525ebb2640a8c870d685d95ce26ba0cce3` |
| `blueprint/theorem_cards/IMP-001.yaml` | card revision 3 | `35cb365a0de0492ddc7d6a62e66734400f92c7b79434afa08d9ea1ab2033dcb2` |
| `blueprint/proofs/IMP-001.md` | `NLP-IMP-001-R3`, read completely | `d97bd16bbdffeeaa34c2560111f38c714e91e09458d2fb3381535029ca4d431c` |
| `review/PROTOCOL.md` | read completely | `e1a85b683abce3072c3e4275ca9312716025d768c4d542aab9c556c6ccc542a3` |
| `review/classifications-v1.yaml` | superseded frozen vocabulary | `7a4f322bb56dbb40d5d44a7eceb50b5a49ea6ae69f414b920341e3b12ea9d71e` |
| `review/classifications-v2.json` | artifact revision 2, frozen | `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9` |
| `review/rubrics/api_dependency.md` | complete | `4e5f947ed15f0101c46fe9bb0a12a013d66c7de3c7ed2c35fda817de8d92eb41` |
| `review/rubrics/mathlib_reuse.md` | complete | `dee214f219ccb03db63194208487f6cb69777b5bc780b608b6e717b729ee901a` |
| `review/rubrics/proof_quality.md` | complete | `55baddf430dc9d7530e644217630a4f0905317e2a5b7bd16126036910a22ca19` |
| `review/rubrics/quantitative_correctness.md` | complete | `1f77ffb3ac536c58875719ebae6cf9bbbcfd4fd027bd491867e0545660745062` |
| `review/rubrics/source_fidelity.md` | complete | `6873853ce125346feef082d0e31d28808387ec0fa5fb0887ce0d300eba02c9a2` |
| `referee-lean-library/SKILL.md` | complete | `d4ce5aa5f1c7ebcf18da6f408c2fc2da98fe2dd906fa9c32b6b613b381aa0e9d` |
| `referee-lean-library/references/global-rubric.md` | complete | `990a183dc9e86a3d9580cfb2d5834d36d18afb8a06ad32a114d12b4d0716bb81` |

Downstream/status artifacts checked from the archive:

| Artifact | SHA-256 |
|---|---|
| `blueprint/dependency_graph.md` | `7c5ca4b66420982a228c7ad37f49c4b26ec6c2fac3cb3f863288455efa5d263b` |
| `blueprint/roadmap.md` | `2e76be8dceded6dfda5b578555ef3f32919de6789d797e02e6760e17a9ca3d2a` |
| `blueprint/methods/integral_laplace.md` | `f7862ccf3aa149b4fae34f552c1d0227379a3e9c99f611471b9027208517ad8b` |
| `blueprint/theorem_cards/README.md` | `718aaf94b635c40a2833c8b95acc2cba551f2b7ca228233a6fd79327b8d534e7` |
| `blueprint/inventory/cards.csv` | `61f46414e2d5f4c936fc0a1cb52aa4496bc847884936b9fd0b775d0a24138135` |
| `blueprint/inventory/manifests.csv` | `97f8d5e80fcd3019bf8cc7ae4fdeb885c206e0a12b7e4dc15190318cbeab3a19` |
| `blueprint/theorem_cards/QL-001.yaml` | `a85af11116ad2900bb4c7a01acfbfc1eb791a1f1f2a3755ccefa1f3e28ec471d` |
| `blueprint/proofs/QL-001.md` | `4b70ef576ff90e972ac2ea4e8beac91bca8a208b849f82f87c4afe06a14b5859` |
| `blueprint/theorem_cards/OLV-001.yaml` | `e1863ef77180b18ca02a107248c69913ac036d2f16e13ad282b17abe8f8cdbaa` |
| `blueprint/proofs/OLV-001.md` | `11b6d71aa9fba5699bc2703ead20bbee1db9208df5e83de0a969dbb51e87aaf7` |
| `blueprint/theorem_cards/OLV-002.yaml` | `c625207e0a75c6e6815f6cae603bf05e4761a1070856f65eee5917c0de99bf81` |
| `blueprint/proofs/OLV-002.md` | `015c16bf3ffa2fd981083f47029398961ac9773ac638d88c3698732e3a5b4d0d` |

Pinned environment:

- Lean toolchain: `leanprover/lean4:v4.33.1`; `lean-toolchain` SHA-256 `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71`.
- Mathlib commit: `0df444a360eaa60ab8c11dca51a86af692955474`.
- `lake-manifest.json` SHA-256: `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`.

Pinned Mathlib source was read from exact commit objects, not from its live checkout contents:

| Exact source file | SHA-256 |
|---|---|
| `Mathlib/MeasureTheory/Integral/Prod.lean` | `c7d4d23349591c5c65aa5b1b6024331fb0b7f22e9b2b08d6a1fe19b1c258ec5b` |
| `Mathlib/MeasureTheory/Integral/IntervalIntegral/Basic.lean` | `93908eb0c771ba8edcb47537dfe1a40e98a1545be9d427c1eb9823d44decdcd5` |
| `Mathlib/MeasureTheory/Integral/DominatedConvergence.lean` | `18b709ea5c9ef9136e3e75ded82a6135641e6e19688e0ca3abcb0af45648ab84` |
| `Mathlib/MeasureTheory/Integral/IntervalIntegral/FundThmCalculus.lean` | `5fd64054d9ae8bfce585ff809933a756bcf2d224ef144ae24c8fe8870c68050c` |
| `Mathlib/Analysis/SpecialFunctions/ExpDeriv.lean` | `7678c4712458f4129eb9b29ea7eb332467501cc8a6688547d1ed1b25f8849722` |
| `Mathlib/Topology/Algebra/Monoid.lean` | `cf858f52c0f84ad0f0f950ddc0c76128c4893ced7620d0c7a4cef1c9c3ddab56` |
| `Mathlib/Topology/Separation/Hausdorff.lean` | `4e6998adc898c3aac6d01e0c8bc916aa68794bf6cca0d3c57e43f76760151a87` |

The checked APIs include the exact restricted-product premise of `MeasureTheory.intervalIntegral_integral_swap`, `MeasureTheory.AEStronglyMeasurable.comp_snd`, `ContinuousLinearMap.intervalIntegral_comp_comm`, `intervalIntegral.integral_add_adjacent_intervals`, `intervalIntegral.continuousOn_primitive_interval'`, `intervalIntegral.integral_eq_sub_of_hasDerivAt_of_le`, and `Real.hasDerivAt_exp`.

## Separate verdicts

1. **Natural-language proof: APPROVE on mathematical content.** T01--T06 are reached without a missing mathematical or analytic step. **Does this report count as one valid approval toward the two approvals required to start exact-signature design? NO.** The only reason is the disclosed isolation breach after my independent derivation; the proof itself is approved.
2. **Structural/circularity: APPROVE on mathematical content.** The dependency route is `pinned Mathlib -> IMP-001 -> QL-001 -> OLV-001 -> SR-001`; OLV-002 is separate. No downstream result, target-weight conclusion, hidden selected improper value, or choice-selected primitive feeds back into IMP-001. Because of the same isolation breach, this report must not be counted in a structural quorum.
3. **Theorem card: REQUEST_CHANGES.** The sole content defect is the intentionally absent exact Lean signature artifact: exact representations, binder order, target types, visibility, and minimal import closure for all six declarations are not yet frozen. The draft/unregistered/no-authorization status correctly reflects that omission and is not a separate mathematical defect. The card should not be approved or marked `lean_ready` until signature design occurs after two valid proof approvals.

## Independent reconstruction and checks

### T01: finite-exceptional right-ray relation

Ordering the finite set `S = {c₁ < ... < cₘ}` decomposes `[k,∞)` into the first component, bounded interior components, and the final unbounded component. The proposed relation explicitly contains compact regular-piece `IntervalIntegrable` evidence, independent one-sided endpoint limits, the limit at infinity, and the finite sum of component values. Thus it cannot accept a principal-value-only singularity or use Mathlib's totalized value as convergence evidence.

Changing an interior anchor from `d` to `e` adds the fixed integral `∫ d..e f` to the left contribution and subtracts it from the right contribution. This proves anchor independence componentwise, including the final component, and makes T01 independent of the eventual Lean representation of the sorted set.

### T02: uniqueness

With the unique increasing enumeration and any fixed anchors, every candidate component contribution is a limit of the same function along the same nontrivial one-sided filter. Hausdorff uniqueness gives equality of every contribution, and the finite sum then gives `I = J`. No cross-singularity integrability is used.

### T03: exact refinement and finite CLM combination

For a regular point `d` inserted into the currently marked set, compact integrability across a neighborhood of `d` makes the indefinite integral continuous there. This yields the two new endpoint limits separately. The four positions are exhaustive:

1. With no old exception, split the sole `[k,∞)` component at `d`; additivity and subtraction of fixed compact pieces preserve the old infinity value.
2. In the first component `[k,c₁)`, let `B = lim_{x↑c₁} ∫ k..x f` and choose `d < v < c₁`. Put `A = ∫ k..d f` and `C = ∫ d..v f`. The new first value is `A`; the two individual values of the new bounded component are `C` and `B - ∫ k..v f`. Since `∫ k..v f = A + C`, that component is `C + B - (A + C) = B - A`, and adding the new first value gives exactly `B`. This is the corrected first-component bookkeeping, and the anchor `v` is essential to exhibit both endpoint values.
3. In a bounded interior component, the two old outer endpoint limits remain unchanged and the two new limits at `d` exist separately; additivity (equivalently anchor independence) makes the two refined component totals equal the old component total.
4. In the final component, the two limits at `d` exist separately; subtracting the fixed integral from the old anchor to a chosen `v > d` transports the old infinity limit, and the new bounded plus unbounded contributions equal the old final contribution.

For fixed `i`, enumerate the finite difference `S_A \ S_i` and insert its elements by finite induction. A later point remains regular: earlier insertions only subdivide its original regular component and no inserted points coincide. This yields `HasImp(f_i,k,S_A,I_i)`. On the common set, compact integrability is stable under each continuous real-linear map and finite sum; `ContinuousLinearMap.intervalIntegral_comp_comm` transports every regular integral, and continuity of the maps plus `tendsto_finsetSum` transports every endpoint limit. Interchanging only finite sums gives the advertised value. Empty sums, addition, negation, real scalar multiplication, and fixed complex multiplication as a real CLM are legitimate instances.

### T04: prepending a regular interval

For `a ≤ k`, set `J = ∫ a..k f`. Eventually every endpoint truncation lies beyond `k`, so adjacent-interval additivity gives `∫ a..R f = J + ∫ k..R f` in the empty-set case and `∫ a..b f = J + ∫ k..b f` near the first exception otherwise. All later component limits are identical. Regular-truncation integrability in the two relations is equivalent by restriction and concatenation with `[a,k]`. Hence `HasImp(f,a,S,J+I) <-> HasImp(f,k,S,I)` with the stated sign and order.

### T05: normalized finite-exceptional primitive

The proposed predicate contains exactly continuity of `F` on `[k,∞)`, `F(k)=0`, and the regular-subinterval integrability/increment law. At an exception `c`, continuity sends the left and right increment formulas independently to `F(c)-F(d)` and `F(e)-F(c)`. It contains neither a bound nor convergence at infinity and does not choose `F`; those remain downstream data/proofs.

### T06: Abel identity and restricted-product integrability

Let `ν = volume.restrict (Set.uIoc a b)` and `w(t)=exp(-h*t)`. With `a ≤ b`, define

`H(t,v) = 1_{a ≤ v ≤ t ≤ b} * (w(t) • g(v))`.

`IntervalIntegrable g volume a b` is integrability of `g` under `ν`. The measure `ν` is finite with mass `b-a`. Therefore, on `ν.prod ν`,

`norm (Function.uncurry H (t,v)) ≤ M * norm (g v)`

for the finite compact exponential bound `M = exp(|h| * max(|a|,|b|))`, and the right-hand side has finite product integral. For measurability, the integrability of `g` supplies only `AEStronglyMeasurable g ν`; the exact pinned `MeasureTheory.AEStronglyMeasurable.comp_snd` lifts this to `ν.prod ν`. The scalar exponential is continuous/measurable, the triangular set is measurable, and continuous scalar multiplication plus the indicator preserve AEStronglyMeasurable under that same restricted product measure. Thus the proof establishes exactly

`MeasureTheory.Integrable (Function.uncurry H) (ν.prod ν)`

without a global `StronglyMeasurable g` or global `StronglyMeasurable H` hypothesis. This is precisely the premise of the pinned `MeasureTheory.intervalIntegral_integral_swap` after specializing its inner measure to `ν`. The swapped sections give

`∫ a..b w(t) • (∫ a..t g) dt = ∫ a..b (∫ v..b w(t) dt) • g(v) dv`.

The derivative of `w` follows from `Real.hasDerivAt_exp` and the chain rule. FTC yields `h * ∫ u..v w = w(u)-w(v)` without division by `h`, so it remains valid at `h=0`. Substitution, finite Bochner linearity, the endpoint increment at `b`, and `F(t)=F(a)+∫ a..t g` give exactly

`∫ a..b w(t) • g(t) dt = w(b) • F(b) - w(a) • F(a) + h • ∫ a..b w(t) • F(t) dt`.

Continuity of `F` makes the weighted `F` term interval-integrable. When `a=b`, all integrals vanish and the boundary terms cancel. No derivative of `F` is used.

## Structural and rubric findings

- No candidate mathematical finding requires a proof revision.
- Mathematical intent: clear; the targets implement source-independent finite-exceptional semantics and the finite Abel identity required by QL-001.
- Reusable seam: justified even with one immediate consumer because it isolates ordinary-improper semantics and finite-product Fubini from the source application and prevents a reverse dependency.
- Proof architecture: exact finite identities, endpoint limits, integrability, primitive data, and downstream estimates remain separate.
- Mathlib reuse: the proof uses the canonical interval-integral, CLM, Fubini, continuity-of-primitive, FTC, exponential, finite-limit, and Hausdorff APIs at the pin. No duplicate proper-integral library is proposed.
- Dependency design: clear and acyclic; IMP-001 imports no QL/OLV/QB/DEF layer. OLV-002 is correctly off the IMP/QL/OLV-001 critical path.
- Hypothesis laundering: absent. T05's increment law is genuine primitive information and is weaker/different than T06's weighted identity; the downstream bound and baseline-primitive bound are not fields of IMP-001.
- Choice laundering: absent. Exceptional sets and their union, `F`, and proposed values are explicit. Sorting is canonical, anchors are immaterial, and no `Classical.choose`-defined integral-value function is introduced.
- Source fidelity: not applicable to IMP-001; it binds no Olver occurrence or named function and earns no source coverage.
- Cost/durability and implementation proof quality cannot yet be judged beyond the prospective two-module split because no signatures or Lean implementation exist.

## Acceptance and next gate

Mathematically, revision 3 repairs the first-component insertion gap and is ready for the signature-design stage once two genuinely isolated proof approvals exist. This referee's mathematical approval is not one of those valid approvals because of the disclosed process contamination. Exact signatures must next freeze the sorted/component representation, one-sided filters, all target binders and result types, helper visibility, and minimal imports. The theorem card remains `REQUEST_CHANGES` solely for that absent signature artifact; no Lean implementation is authorized by this report.

## Integrity

SHA-256 of the canonical report body through the final sentence of `Acceptance and next gate`, including that sentence's terminating newline but excluding the separating blank line and this `## Integrity` section: `2b55995d9b5f511f84ae81fee555fb6fc9aab2332dffdf52d349d0782269f367`.
