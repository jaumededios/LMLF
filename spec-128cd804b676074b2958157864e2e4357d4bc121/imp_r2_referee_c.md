# Independent pre-Lean referee report: IMP-001 revision 2

## Executive disposition

**Reviewed specification commit:** `128cd804b676074b2958157864e2e4357d4bc121`

| Review object | Verdict | Reason |
|---|---|---|
| IMP-001 theorem card, revision 2 | **REQUEST_CHANGES** | The mathematical boundary and classifications are coherent, but the exact Lean signature artifact, binder order, representation, and import closure are intentionally absent. Under the repository's API/dependency rubric, a theorem card cannot be approved without them. This is the sole theorem-card defect found. |
| IMP-001 natural-language proof, revision 2 | **REQUEST_CHANGES** | The revised regular-point insertion argument correctly establishes the two individual endpoint limits, but its first-component case states one wrong endpoint-limit value. That breaks the displayed bookkeeping needed to justify the preservation claim and hence the T03 refinement proof as written. The repair is local and does not require changing any target. |
| Structural/circularity review | **APPROVE** | The dependency direction, source-to-target reachability, and hypothesis/choice boundary are sound. No circular dependency or laundering was found. |

**Unambiguous signature-gate answer: NO. Exact-signature design may not start from these bytes.** The proof must first correct finding `IMP-R2-C-01`, receive a fresh review against its new digest, and then satisfy the card's requirement of two independent proof approvals. After that repair, I see no mathematical or structural reason to redesign the six-target boundary before signature work.

## Review identity, method, and isolation

- Reviewer ID: `/root/imp_r2_referee_c`
- Reviewer kind: agent
- Review stage: `pre_lean`
- Perspectives: `proof_correctness`, `dependency_direction`, `source_to_target_reachability`, `hypothesis_and_choice_laundering`
- Model: OpenAI Codex, GPT-5 family. The exact deployment/build identifier is not exposed to this reviewer and is therefore not invented here.
- Runtime: Codex desktop agent environment, Linux container
- Isolation strength: `manual_attestation`
- Isolation method: I extracted the exact commit with `git archive` into the disposable directory `/tmp/imp-r2-referee-c.SZeduG`. I did not inspect the live dirty worktree, did not switch any worktree, did not read `blueprint/reviews/**`, and did not read another referee's report or evidence. The pinned Mathlib source was independently extracted by `git archive` at its exact commit into `/tmp/imp-r2-referee-c.SZeduG-pinned-mathlib`. This was not a technically enforced clean-room runner.
- Mutation boundary: no repository file was edited. This report is outside the repository.
- Skill/rubric method: I read the full `referee-lean-library` skill, its full global rubric and research-basis note, the full 1,753-line user brief, all repository review rubrics, the protocol and both classification artifacts, the exact IMP/QL/OLV cards and proof dossiers, the Laplace method and dependency/status documents, and the cited Mathlib source at the pin. I then rederived all six IMP targets independently before comparing the dossier's route.
- Mechanical checks: `python3 scripts/validate_inventory.py` and `python3 scripts/validate_inventory.py --negative-tests` both exited 0 in the archived tree. The negative suite rejected all 25 intentionally invalid fixtures. This confirms inventory structure only; it is not proof or gate evidence.
- Lean build status: not applicable at this stage. IMP-001 has no declarations or exact signature artifact, so there is no IMP implementation to compile or axiom-audit.

## Exact artifact bindings

### Governing inputs

| Artifact | SHA-256 |
|---|---|
| User brief, `pasted-text.txt` (1,753 lines) | `6787cdb628a66783d81190939e9593525ebb2640a8c870d685d95ce26ba0cce3` |
| `referee-lean-library/SKILL.md` | `d4ce5aa5f1c7ebcf18da6f408c2fc2da98fe2dd906fa9c32b6b613b381aa0e9d` |
| `references/global-rubric.md` | `990a183dc9e86a3d9580cfb2d5834d36d18afb8a06ad32a114d12b4d0716bb81` |
| `references/research-basis.md` | `162256b64da8b6ddec71f55f30dd66d35ab2958ba53ddaee55f0cccb9fe241ed` |

### Reviewed repository artifacts at `128cd804b676074b2958157864e2e4357d4bc121`

| Repository-relative artifact | SHA-256 |
|---|---|
| `blueprint/theorem_cards/IMP-001.yaml` | `70a1a227da5bbfd217c7e1e91b6fc9f9d77a274b704d668895509d0e4bb2cb9e` |
| `blueprint/proofs/IMP-001.md` | `b16460f7286500efce6360ce4f7f0adae4eeedc989dd956e7a253e0804c83d06` |
| `blueprint/theorem_cards/QL-001.yaml` | `64a395c99c79ca2e3dc92bb39cb531dc0ce25494f1ea48311069deb30dcef3fb` |
| `blueprint/proofs/QL-001.md` | `4b70ef576ff90e972ac2ea4e8beac91bca8a208b849f82f87c4afe06a14b5859` |
| `blueprint/theorem_cards/OLV-001.yaml` | `e1863ef77180b18ca02a107248c69913ac036d2f16e13ad282b17abe8f8cdbaa` |
| `blueprint/proofs/OLV-001.md` | `11b6d71aa9fba5699bc2703ead20bbee1db9208df5e83de0a969dbb51e87aaf7` |
| `review/PROTOCOL.md` | `e1a85b683abce3072c3e4275ca9312716025d768c4d542aab9c556c6ccc542a3` |
| `review/classifications-v1.yaml` | `7a4f322bb56dbb40d5d44a7eceb50b5a49ea6ae69f414b920341e3b12ea9d71e` |
| `review/classifications-v2.json` | `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9` |
| `review/rubrics/api_dependency.md` | `4e5f947ed15f0101c46fe9bb0a12a013d66c7de3c7ed2c35fda817de8d92eb41` |
| `review/rubrics/mathlib_reuse.md` | `dee214f219ccb03db63194208487f6cb69777b5bc780b608b6e717b729ee901a` |
| `review/rubrics/proof_quality.md` | `55baddf430dc9d7530e644217630a4f0905317e2a5b7bd16126036910a22ca19` |
| `review/rubrics/quantitative_correctness.md` | `1f77ffb3ac536c58875719ebae6cf9bbbcfd4fd027bd491867e0545660745062` |
| `review/rubrics/source_fidelity.md` | `6873853ce125346feef082d0e31d28808387ec0fa5fb0887ce0d300eba02c9a2` |
| `review/questions/OLV97-C03-WATSON.md` | `29980153caa5378727c972eb3a0829cbc768f542f95d8035e6a0ec031f6c1abc` |
| `blueprint/methods/integral_laplace.md` | `a82590826bebb9c00e15aa70a84afebc60365a7e547eab3117b3a6f36dc5e413` |
| `blueprint/dependency_graph.md` | `1a8a555642ea136b699f00263fd7eb61b28d35144e0b76086f4d94a82f1b201c` |
| `blueprint/design_decisions.md` | `e3a0d2049f755e28f81d1588c3bd2925bd67b8fc9103c4e83444c0b369a944d7` |
| `blueprint/theorem_cards/README.md` | `23ae93df7c799a757296e16893e652d066516fd8003f4d3ec561a52725455793` |
| `blueprint/source_manifest.md` | `09c62ea76ab7ecc83d8685a876fed1ba001aec5af9aa91e81dd7467568c95fc9` |
| `blueprint/function_inventory.md` | `cf2e356e34a58e8530500603db6a63f1ec5f025d8988dffe6652f2c816caa50d` |
| `blueprint/roadmap.md` | `2e76be8dceded6dfda5b578555ef3f32919de6789d797e02e6760e17a9ca3d2a` |
| `blueprint/README.md` | `1643ccb676956dc7c8ad8cf0cebd67866701c022eddc997a2ed61c86e8bf86e8` |
| `README.md` | `ed6b081dd8e3deafa6e7c9a4dd9f9efd88a0066e644e594eb18648eb1f3d9ba1` |
| `blueprint/mathlib_audit.md` | `6b0aab27aac6711894567048c3f232f6ab3345b5d0c79b5b3402e0ecad38378c` |
| `lake-manifest.json` | `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404` |
| `lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `lakefile.toml` | `787bac6de4002b375a6bfbc840589d72ea3e1f2a440a33352973f268815da562` |

### Pinned toolchain/source binding

- Lean toolchain: `leanprover/lean4:v4.33.1`
- Resolved Mathlib commit: `0df444a360eaa60ab8c11dca51a86af692955474`
- The resolved pin in `lake-manifest.json` matches the card and dossier.

| Pinned Mathlib source file | SHA-256 |
|---|---|
| `Mathlib/MeasureTheory/Integral/IntervalIntegral/Basic.lean` | `93908eb0c771ba8edcb47537dfe1a40e98a1545be9d427c1eb9823d44decdcd5` |
| `Mathlib/MeasureTheory/Integral/DominatedConvergence.lean` | `18b709ea5c9ef9136e3e75ded82a6135641e6e19688e0ca3abcb0af45648ab84` |
| `Mathlib/MeasureTheory/Integral/Prod.lean` | `c7d4d23349591c5c65aa5b1b6024331fb0b7f22e9b2b08d6a1fe19b1c258ec5b` |
| `Mathlib/MeasureTheory/Integral/IntervalIntegral/FundThmCalculus.lean` | `5fd64054d9ae8bfce585ff809933a756bcf2d224ef144ae24c8fe8870c68050c` |
| `Mathlib/Analysis/SpecialFunctions/ExpDeriv.lean` | `7678c4712458f4129eb9b29ea7eb332467501cc8a6688547d1ed1b25f8849722` |
| `Mathlib/Topology/Algebra/Monoid.lean` | `cf858f52c0f84ad0f0f950ddc0c76128c4893ced7620d0c7a4cef1c9c3ddab56` |
| `Mathlib/Topology/Separation/Hausdorff.lean` | `4e6998adc898c3aac6d01e0c8bc916aa68794bf6cca0d3c57e43f76760151a87` |

The cited declarations exist at the stated defining imports and have the needed orientation: `intervalIntegral.integral_add_adjacent_intervals`, `ContinuousLinearMap.intervalIntegral_comp_comm`, `tendsto_nhds_unique`, `tendsto_finsetSum`, `ContinuousOn.intervalIntegrable_of_Icc`, `MeasureTheory.intervalIntegral_integral_swap`, `intervalIntegral.integral_eq_sub_of_hasDerivAt_of_le`, `intervalIntegral.integral_undef`, `intervalIntegral.continuousOn_primitive_interval'`, and `Real.hasDerivAt_exp`.

## Independent mathematical reconstruction

### T01: finite-exceptional right-ray relation

The proposed relation is mathematically coherent. For ordered `S = {c_1 < ... < c_m}`, it requires integrability on every compact subinterval of each regular component, independent one-sided limits on both sides of every finite exception, and a separate limit at `+infinity`. It then sums the component values. This rejects principal-value-only cancellation and prevents Mathlib's totalized integral value from being mistaken for existence.

Anchor independence is correct. Moving an interior anchor from `d` to `e` changes the left component limit by `+ integral_d^e f` and the right component limit by `- integral_d^e f`; their sum is unchanged. The same calculation applies to the final unbounded component.

### T02: uniqueness

For a fixed ordered exceptional set, each witness uses the same finite-interval function on the same nontrivial one-sided filter. `tendsto_nhds_unique` identifies each first, left, right, and final endpoint value. The finite component sums are therefore equal. This proves relational uniqueness without selecting an integral value and without introducing absolute integrability.

### IMP-I02 and T03: individual regular-point limits and finite-union iteration

The core analytic repair in revision 2 is valid. If `d` is regular, choose `p < d < q` in its component and define `P(x) = integral_p^x f`. Pinned `intervalIntegral.continuousOn_primitive_interval'` makes `P` continuous on `[p,q]`. Consequently, for fixed `u < d < v`,

`integral_u^x f -> integral_u^d f` as `x` approaches `d` from below, and

`integral_x^v f -> integral_d^v f` as `x` approaches `d` from above.

These are the two individual limits needed by ordinary improper semantics, not merely a limit of their sum.

The four insertion positions then work as follows:

1. Empty `S`: the new first contribution is `integral_k^d f`; the new final component has left contribution `integral_d^v f` and outer contribution `old_total - integral_k^d f - integral_d^v f`.
2. First component `[k,c_1)`: with a chosen new-component anchor `v in (d,c_1)`, the new first contribution is `integral_k^d f`, the new component's left contribution is `integral_d^v f`, and its right contribution is `old_first - integral_k^v f`. These sum exactly to `old_first`.
3. Bounded interior component `(c_i,c_{i+1})`: choose anchors `u < d < v`; the new limits at `d` are `integral_u^d f` and `integral_d^v f`, while the pre-existing limits at `c_i` and `c_{i+1}` persist after fixed-integral translations. The four pieces telescope to the old component.
4. Final component `(c_m,infinity)`: the two new limits at `d` are as above; the old outer limit, translated by a fixed compact integral, supplies the new outer limit. The bounded and final contributions telescope to the old one.

This also validates the T03 iteration strategy. For fixed `i`, enumerate the finite set `S_A \ S_i`. At each stage the next point is absent from the current marked set and lies in a regular component for `f_i`; previous insertions only subdivide that component. Finite induction therefore refines `S_i` to the literal union `S_A`. Once all summands use `S_A`, continuous-real-linear maps commute with each regular Bochner integral and finite sums commute with every endpoint limit. The intended combined value follows. No simultaneous choice or infinite limit/sum interchange occurs.

However, the dossier does not state item 2 correctly; see `IMP-R2-C-01` below.

### T04: regular prepend/split orientation

The orientation is correct. For `a <= k`, let `J = integral_a^k f`. Additivity gives

`integral_a^R f = J + integral_k^R f`,

and, before the first exception, `integral_a^b f = J + integral_k^b f`. Thus the relation from `a` has value `J + I` exactly when the relation from `k` has value `I`. The proof neither reverses an interval nor changes the sign; the `a = k` case reduces to `J = 0`.

### T05: normalized primitive and laundering audit

T05 contains exactly the right qualitative data: explicit `g`, `k`, `S`, and `F`; continuity of `F` on the ray; `F(k)=0`; integrability and the increment law on every regular compact interval. Continuity converts the increment law into independent finite endpoint values at each exceptional point. It does not assert a bound on `F`, a limit at infinity, a target weight, a Gamma moment, or the QL remainder estimate. `F` is an explicit input, not `Classical.choose`. This is not hypothesis or choice laundering.

The downstream separation is sound: QL-001 supplies the flat baseline `X`, target `x`, and bound `L`; OLV-001 derives the bounded primitive from baseline convergence rather than assuming the target estimate.

### T06: restricted-product Fubini, orientation, and `h = 0`

Let `G(t) = integral_a^t g`, `w(t) = exp(-h*t)`, and use the triangular kernel

`H(t,v) = 1_{a <= v <= t <= b} w(t) • g(v)`.

With `nu = volume.restrict (Set.uIoc a b)`, `IntervalIntegrable g volume a b` gives integrability of `norm g` under `nu`; `nu` is finite; the triangle is measurable; and `w` is continuous and bounded on `[a,b]`. Thus domination proves the exact premise

`Integrable (uncurry H) ((volume.restrict (uIoc a b)).prod (volume.restrict (uIoc a b)))`

required by pinned `MeasureTheory.intervalIntegral_integral_swap`. Indicator sections and null endpoints then give

`integral_a^b w(t) • G(t) dt = integral_a^b (integral_v^b w(t) dt) • g(v) dv`.

The exponential FTC yields, for every real `h` and `u <= v`,

`h * integral_u^v w(t) dt = w(u) - w(v)`.

No division by `h` occurs. Multiplying the Fubini identity by `h`, using `integral_a^b g = F(b)-F(a)`, then adding the constant part of `F(t)=F(a)+G(t)` gives

`h • integral_a^b w(t) • F(t) dt = integral_a^b w(t) • g(t) dt - w(b) • F(b) + w(a) • F(a)`,

which rearranges to T06. At `h=0`, the target is exactly the increment law at `b`; at `a=b`, all integrals vanish and the endpoint terms cancel. The argument uses no derivative of `F`.

For QL-001, applying this identity separately on regular truncated components is correct. Continuity makes the two `w(c)F(c)` boundary terms at each exceptional point cancel only after the independent one-sided limits have been taken. The later `R -> infinity` passage and bounded-primitive estimate remain downstream in QL-001.

## Findings

### `IMP-R2-C-01` — P1 / major: wrong right-endpoint value in first-component insertion

**Location:** `blueprint/proofs/IMP-001.md`, archived lines 288-293, especially 290-292.

The dossier says that, after inserting `d` into `[k,c_1)`, the new bounded component's right limit at `c_1` is the old first-component limit minus `integral_k^d f`. That is false for the required interior anchor.

Let `B = lim_{b up-arrow c_1} integral_k^b f`, and choose the new component's anchor `v` with `d < v < c_1`. Its individual endpoint values are

- left at `d`: `integral_d^v f`;
- right at `c_1`: `B - integral_k^v f`, not `B - integral_k^d f`.

Their sum is `B - integral_k^d f`; only after adding the new first-component value `integral_k^d f` does one recover `B`. Under the text's stated right-limit value, adding its already asserted left contribution produces an extra `integral_d^v f`, so the claimed “hence” does not follow.

This is a local correction, not a counterexample to IMP-I02 or T03. The surrounding continuity argument supplies the missing correct value, and the finite iteration over `S_A \ S_i` remains valid after correction. It is nevertheless material because the revised proof advertises explicit treatment of all four positions, and T03 relies on exact value preservation at every insertion.

**Acceptance conditions:**

1. Replace the first-component calculation by the three-value bookkeeping above, with an explicit interior anchor `v in (d,c_1)`.
2. State separately the new left-at-`d` and right-at-`c_1` limits, then show the component sum and total sum telescope.
3. Keep the regression obligation for all four positions and both individual limits.
4. Increment the proof artifact revision/digest as required and obtain a fresh proof verdict on the corrected bytes.

Confidence: high.

### `IMP-R2-C-02` — required theorem-card completion, not a mathematical defect

**Location:** `blueprint/theorem_cards/IMP-001.yaml`, archived lines 53-76 and 297-306.

The exact signature artifact is deliberately withheld until two proof approvals. Accordingly, exact binders, implicit parameters, the concrete finite-set/component representation, declarations, and minimal imports cannot yet be checked. The repository's `api_dependency` rubric item 11 requires a theorem-card `request_changes` verdict in this state.

**Acceptance conditions:** after the corrected proof obtains the prerequisite approvals, create and digest-bind an exact signature artifact for all six targets; record binder order, namespace, concrete representation, and minimal imports; reconcile the ID/registry boundary; then submit the card for fresh review. This finding does not request premature signature design and is the sole theorem-card-specific blocker found.

Confidence: certain.

## Clear sections and do-not-refactor decisions

- Mathematical intent: clear except for `IMP-R2-C-01`; the six targets match the stated Watson prerequisite.
- Reusable seams: keep T01 and T05 as the two predicates, T02/T03/T04 as relation laws, and T06 as the sole analytic identity. This is a coherent small layer with a real QL-001 consumer.
- Public API shape: no additional public regular-point-insertion theorem is justified yet; IMP-I02 can remain private unless a second consumer appears. Do not split addition, negation, scalar multiplication, and complex coefficient multiplication into separate public targets; T03 subsumes them cleanly.
- Module/dependency design: the proposed `Improper.Basic` for T01-T05 and `Improper.Abel` for T06 is sound, with Abel importing Basic and no reverse edge.
- Mathlib reuse: the cited pinned declarations are real fits, not name-only matches. No ready-made pinned finite-exceptional ordinary-improper relation replaces T01/T05.
- Proof architecture: the semantic insertion helper and triangular Fubini helper name genuine boundaries. T06 appropriately isolates the finite-piece identity from QL's infinite-tail estimate.
- Cost/durability: no performance claim is made before implementation. Narrow defining imports are identified; exact transitive imports must wait for signatures.
- Refactor risk: no implementation or call-site migration exists yet. QL-001 and OLV-001 remain drafts and consume the intended direction only.

## Structural/circularity disposition

**APPROVE.** The graph is strictly

`pinned integration/limit facts -> IMP-001 -> QL-001 -> OLV-001 -> SR-001`,

with the pinned Gamma moment entering QL-001 directly. IMP-001 binds no source occurrence and earns no source coverage. It does not import or assume QL-001, OLV-001, Gamma, QB-001, or DEF-001. T05 does not contain QL's boundedness or target-weight conclusion; T06 derives Abel from regular increment data rather than assuming a derivative or the weighted result; T03 uses the literal finite union; values and primitives are explicit inputs; sorting is canonical; and no chosen improper-integral function is created. The local arithmetic defect in `IMP-R2-C-01` is a proof-correctness issue, not a circularity or boundary defect.

## Final gate statement

This review does **not** count as a proof approval. The proof verdict is **REQUEST_CHANGES**, and the theorem-card verdict is independently **REQUEST_CHANGES** because exact signatures are absent. The structural/circularity perspective is **APPROVE**. Therefore signature design is **not authorized to start** from commit `128cd804b676074b2958157864e2e4357d4bc121`.

The whole-file SHA-256 is intentionally recorded in the external delivery message after this file is closed; embedding a file's own final digest in its contents would be self-referential and would change that digest.
