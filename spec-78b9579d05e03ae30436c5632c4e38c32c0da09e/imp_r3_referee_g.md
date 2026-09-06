# IMP-001 revision-3 exact-commit pre-Lean referee report

## Binding, identity, and method

- Reviewed candidate commit: `78b9579d05e03ae30436c5632c4e38c32c0da09e`
- Candidate tree: `c679e1f4f43b11c696a52b64cbea226762079a27`
- Deterministic `git archive` SHA-256: `adbd421377cb89b68431f1811c71a1f86d44bbb529585b2d3f11267560e210b9`
- Reviewer ID: `imp_r3_referee_g`
- Canonical agent identity: `/root/imp_r3_referee_e/imp_r3_referee_f/imp_r3_referee_g`
- Reviewer kind: `agent`
- Runtime/model: Codex, GPT-5 family. The exact serving-model deployment ID was not exposed to this session, so I do not invent a narrower model label.
- Review stage: `pre_lean`
- Isolation strength: `manual_attestation`
- Isolation method: fresh agent context; the candidate was read only from a disposable extraction produced by `git archive 78b9579...`; no live-worktree status, files, diff, earlier commit, prior review report, `LMLF-review-evidence` content, or other agent output was inspected. Pinned Mathlib was fetched at the exact manifest revision without checkout and the needed source files were separately extracted by `git archive`. No candidate or repository file was edited.
- Skill applied: `referee-lean-library`, including every section of its global rubric. Its architectural emphasis led me to check the predicate boundary, the IMP -> QL -> OLV dependency direction, Mathlib reuse, and hypothesis/choice laundering separately from local proof validity.

## Exact inputs and hashes

Primary review inputs:

| Artifact | SHA-256 |
|---|---|
| user brief, 1,753 lines, `pasted-text.txt` | `6787cdb628a66783d81190939e9593525ebb2640a8c870d685d95ce26ba0cce3` |
| `referee-lean-library/SKILL.md` | `d4ce5aa5f1c7ebcf18da6f408c2fc2da98fe2dd906fa9c32b6b613b381aa0e9d` |
| `references/global-rubric.md` | `990a183dc9e86a3d9580cfb2d5834d36d18afb8a06ad32a114d12b4d0716bb81` |
| `review/PROTOCOL.md` | `e1a85b683abce3072c3e4275ca9312716025d768c4d542aab9c556c6ccc542a3` |
| `review/classifications-v1.yaml` | `7a4f322bb56dbb40d5d44a7eceb50b5a49ea6ae69f414b920341e3b12ea9d71e` |
| `review/classifications-v2.json` | `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9` |
| `blueprint/theorem_cards/IMP-001.yaml` (revision 3) | `35cb365a0de0492ddc7d6a62e66734400f92c7b79434afa08d9ea1ab2033dcb2` |
| `blueprint/proofs/IMP-001.md` (`NLP-IMP-001-R3`) | `d97bd16bbdffeeaa34c2560111f38c714e91e09458d2fb3381535029ca4d431c` |
| `lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `lake-manifest.json` | `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404` |

Downstream and status/dependency inputs:

| Artifact | SHA-256 |
|---|---|
| `blueprint/dependency_graph.md` | `7c5ca4b66420982a228c7ad37f49c4b26ec6c2fac3cb3f863288455efa5d263b` |
| `blueprint/theorem_cards/QL-001.yaml` | `a85af11116ad2900bb4c7a01acfbfc1eb791a1f1f2a3755ccefa1f3e28ec471d` |
| `blueprint/proofs/QL-001.md` | `4b70ef576ff90e972ac2ea4e8beac91bca8a208b849f82f87c4afe06a14b5859` |
| `blueprint/theorem_cards/OLV-001.yaml` | `e1863ef77180b18ca02a107248c69913ac036d2f16e13ad282b17abe8f8cdbaa` |
| `blueprint/proofs/OLV-001.md` | `11b6d71aa9fba5699bc2703ead20bbee1db9208df5e83de0a969dbb51e87aaf7` |
| `blueprint/theorem_cards/OLV-002.yaml` | `c625207e0a75c6e6815f6cae603bf05e4761a1070856f65eee5917c0de99bf81` |
| `blueprint/proofs/OLV-002.md` | `015c16bf3ffa2fd981083f47029398961ac9773ac638d88c3698732e3a5b4d0d` |
| `blueprint/inventory/cards.csv` | `61f46414e2d5f4c936fc0a1cb52aa4496bc847884936b9fd0b775d0a24138135` |
| `blueprint/inventory/manifests.csv` | `97f8d5e80fcd3019bf8cc7ae4fdeb885c206e0a12b7e4dc15190318cbeab3a19` |
| `blueprint/theorem_cards/README.md` | `718aaf94b635c40a2833c8b95acc2cba551f2b7ca228233a6fd79327b8d534e7` |
| `blueprint/methods/integral_laplace.md` | `f7862ccf3aa149b4fae34f552c1d0227379a3e9c99f611471b9027208517ad8b` |

Pinned dependency: Mathlib commit `0df444a360eaa60ab8c11dca51a86af692955474` (the fetched `v4.33.1` head resolved to exactly this SHA). Source-file SHA-256 values:

| Pinned Mathlib source | SHA-256 |
|---|---|
| `Mathlib/MeasureTheory/Integral/IntervalIntegral/Basic.lean` | `93908eb0c771ba8edcb47537dfe1a40e98a1545be9d427c1eb9823d44decdcd5` |
| `Mathlib/MeasureTheory/Integral/DominatedConvergence.lean` | `18b709ea5c9ef9136e3e75ded82a6135641e6e19688e0ca3abcb0af45648ab84` |
| `Mathlib/MeasureTheory/Integral/Prod.lean` | `c7d4d23349591c5c65aa5b1b6024331fb0b7f22e9b2b08d6a1fe19b1c258ec5b` |
| `Mathlib/MeasureTheory/Integral/IntervalIntegral/FundThmCalculus.lean` | `5fd64054d9ae8bfce585ff809933a756bcf2d224ef144ae24c8fe8870c68050c` |
| `Mathlib/Analysis/SpecialFunctions/ExpDeriv.lean` | `7678c4712458f4129eb9b29ea7eb332467501cc8a6688547d1ed1b25f8849722` |
| `Mathlib/Topology/Algebra/Monoid.lean` | `cf858f52c0f84ad0f0f950ddc0c76128c4893ced7620d0c7a4cef1c9c3ddab56` |
| `Mathlib/Topology/Separation/Hausdorff.lean` | `4e6998adc898c3aac6d01e0c8bc916aa68794bf6cca0d3c57e43f76760151a87` |
| `Mathlib/MeasureTheory/Integral/IntegralEqImproper.lean` (reuse search) | `9b23ece88109c97647472e92ac73478da988c81436efc63e17a2acfb2db15353` |

## Verdicts

1. **Natural-language proof: APPROVE.** I found no material mathematical, analytic-side-condition, or reachability defect in `NLP-IMP-001-R3`. **Yes**, this is one valid independent exact-commit approval toward the two approvals required before exact-signature design. It is not a `lean_ready` authorization and does not approve a future signature by anticipation.
2. **Structural/circularity: APPROVE / pass on the reviewed semantic route.** Required perspectives `dependency_direction`, `source_to_target_reachability`, and `hypothesis_and_choice_laundering` are all clear. IMP depends only on pinned foundational Mathlib facts; QL consumes IMP; OLV-001 consumes QL; OLV-002 is independent. No downstream conclusion, chosen improper value, hidden target weight, or theorem-sized quantitative certificate feeds back into IMP.
3. **Theorem card: REQUEST_CHANGES.** The sole material theorem-card defect I found is the intentionally absent exact Lean signature artifact (including exact representation, binder order, and target import closure). The target semantics, classifications, six-target boundary, downstream role, exclusions, dependency pin, and blockers are otherwise coherent. The card must remain unapproved until those signatures are designed after the required two proof approvals and reviewed on their exact bytes.

The draft/unregistered/no-envelope statuses are truthfully recorded governance state, not additional mathematical defects. They still prevent `lean_ready` and implementation.

## Independent derivation of T01--T06

### T01: relation semantics

For finite `S = {c_1 < ... < c_m}` above `k`, the proposed value is the finite sum of: the left limit from `k` to `c_1`; two independently convergent anchored pieces on every bounded open component; and two independently convergent anchored pieces on the final component, the last ending at `+infinity`. For `S = empty`, it is just the limit of honest compact `intervalIntegral` values from `k` to `R`. Requiring `IntervalIntegrable` on every compact regular truncation prevents Mathlib's totalized integral value from witnessing false convergence. This is ordinary improper convergence, not principal value.

Changing an interior anchor from `d` to `e` adds the fixed compact integral `integral d..e` to the left contribution and subtracts it from the right contribution. Additivity therefore preserves each component sum. This proves that the mathematical relation does not depend on the displayed anchor convention.

### T02: uniqueness

Use the unique increasing order of the same finite set and the same deterministic anchors. Strict gaps make every finite one-sided filter nontrivial; `atTop` is nontrivial. Each pair of witnesses is a pair of limits of the same truncation function into the Hausdorff normed space, hence has equal limits by `tendsto_nhds_unique`. Equality of every component value and the finite total gives `I = J`. No integrability through an exception is used.

### T03: regular insertion and finite-union induction

Let `d` be a point above `k` not currently marked exceptional. Choose `p < d < q` inside its old regular component. Compact regular integrability on `[p,q]` and `continuousOn_primitive_interval'` make `P(x) = integral p..x f` continuous there. Consequently, for fixed regular `u < d < v`,

`integral u..x f -> integral u..d f` as `x` approaches `d` from the left, and
`integral x..v f -> integral d..v f` as `x` approaches `d` from the right.

These are the two new endpoint limits individually. The four insertion positions preserve the total as follows.

1. If the old set is empty, choose `v > d` (the deterministic choice `d+1` works). The new first value is `integral k..d f`; the new final left value is `integral d..v f`; and the new infinity value is the old value minus `integral k..d f` and `integral d..v f`. Their sum is the old value.
2. If `d` lies in `[k,c_1)`, write `B = lim_(x up c_1) integral k..x f` and choose the required anchor `d < v < c_1`. The new first value is `integral k..d f`. The two values of the new bounded component are `integral d..v f` and `B - integral k..v f`. Since `integral k..v f = integral k..d f + integral d..v f`, the bounded component contributes `B - integral k..d f`; adding the new first contribution recovers exactly `B`. This is the repaired first-component bookkeeping, and it is correct.
3. If `d` lies in `(c_i,c_{i+1})`, choose `u < d < v` there. Preserve the old outer limits at `c_i` and `c_{i+1}`. The two refined component totals are `(old-left-to-u + integral u..d f)` and `(integral d..v f + old-v-to-right)`. Their sum is the old outer pieces plus `integral u..v f`, exactly the old component value by additivity/anchor independence.
4. If `d` lies in `(c_m,+infinity)`, the same calculation uses the preserved left limit at `c_m`, the two fixed pieces through `d`, and the old infinity limit shifted to an anchor `v>d`. The new bounded and unbounded totals sum to the old final component total.

Restriction supplies every refined regular-truncation integrability field, and no old exceptional endpoint is crossed. Deletion of a marked regular point reverses these equalities.

For fixed `i`, enumerate the finite difference `S_A \ S_i`. Induct over that finite enumeration, applying the preceding insertion lemma once per point. A later point remains regular: it was not in the original `S_i`, and earlier insertions only subdivide the original regular component. Thus the induction reaches the literal union `S_A` without choosing a larger set and preserves `I_i`. Once all summands share `S_A`, compact integrability is closed under each continuous real-linear map and finite sums; `ContinuousLinearMap.intervalIntegral_comp_comm` commutes maps with each finite integral; continuity of each map and `tendsto_finsetSum` commute with every endpoint limit. The two finite sums (components and summands) interchange algebraically, giving exactly `sum_i T_i(I_i)`.

### T04: prepend/split a regular interval

For `a <= k`, put `J = integral a..k f`. When `S` is empty, additivity gives `integral a..R f = J + integral k..R f`; taking or subtracting the fixed `J` proves both directions. When `S` is nonempty, the same identity applies for truncations before `c_1`, shifting only the first-component value by `J`; every later endpoint contribution is unchanged. Integrability on regular truncations transfers by restriction and transitivity with the assumed integrability on `[a,k]`. The value order is `J + I`, with the correct sign.

### T05: normalized finite-exceptional primitive

The predicate records only `S subset (k,+infinity)`, continuity of explicit `F` on `[k,+infinity)`, `F(k)=0`, and the regular-piece increment identity with its `IntervalIntegrable` witness. At an exceptional `c`, the left and right truncations tend independently to `F(c)-F(d)` and `F(e)-F(c)` by continuity, so the predicate supplies the finite endpoint gluing needed downstream. It supplies neither a limit nor a bound at infinity; QL-001 must provide those separately. `F` is an input, not a chosen object.

### T06: finite Abel identity and exact restricted-product integrability

Set `w(t)=exp(-h*t)`, `G(t)=integral a..t g`, and `nu = volume.restrict (Set.uIoc a b)`. Since `a <= b`, `nu` is the finite measure on `(a,b]`. Define

`H(t,v) = (1_{a <= v <= t <= b} * w(t)) smul g(v)`.

The exact hypothesis to the pinned `MeasureTheory.intervalIntegral_integral_swap` is

`Integrable (Function.uncurry H) ((volume.restrict (Set.uIoc a b)).prod nu)`,

which here is `Integrable (Function.uncurry H) (nu.prod nu)`.

This follows without global `StronglyMeasurable g`. `IntervalIntegrable g volume a b` gives `Integrable g nu`, hence a `nu`-a.e. strongly measurable representative. Because `nu` is finite, lifting its null disagreement set along the second projection gives a `nu.prod nu`-null set. Therefore `(t,v) -> g(v)` is `AEStronglyMeasurable` for exactly `nu.prod nu`. The triangle is Borel measurable, `w` is continuous, and scalar multiplication is continuous, so `Function.uncurry H` is `AEStronglyMeasurable` under exactly that product measure. On the restricted product,

`norm (H(t,v)) <= M * norm (g(v))`, with `M = exp(|h| * max(|a|,|b|))`.

The right side is integrable because `nu` has finite mass and `norm g` is integrable under `nu`. The domination criterion proves the precise product-integrability premise, including the zero-measure case `a=b`. Thus the dossier neither assumes nor needs global strong measurability.

Fubini and null endpoint changes then give

`integral a..b (w(t) smul G(t)) dt = integral a..b ((integral v..b w(t) dt) smul g(v)) dv`.

From `Real.hasDerivAt_exp` and the chain rule, `w'=-h*w`. The pinned FTC theorem yields, without division by `h`,

`h * integral u..v w(t) dt = w(u)-w(v)`.

Multiplying the triangular identity by `h` gives

`h smul integral a..b w(t) smul G(t) dt = integral a..b w(v) smul g(v) dv - w(b) smul integral a..b g(v) dv`.

The all-`t` increment law gives `F(t)=F(a)+G(t)` and `integral g = F(b)-F(a)`. Applying the same scalar identity to the constant `F(a)` part and rearranging yields exactly

`integral a..b w(t) smul g(t) dt = w(b) smul F(b) - w(a) smul F(a) + h smul integral a..b w(t) smul F(t) dt`.

This derivation covers `h=0`, `a=b`, and continuous nondifferentiable `F`; it never uses `F'=g`.

## Pinned Mathlib API audit

The named declarations and orientations used by the proof exist at the pin:

- `intervalIntegral.integral_add_adjacent_intervals` takes integrability on the two adjacent intervals and returns the correctly oriented sum.
- `ContinuousLinearMap.intervalIntegral_comp_comm` commutes a continuous linear map with an `intervalIntegral` under `IntervalIntegrable`; its completeness assumptions match the standing Banach-space assumptions.
- `intervalIntegral.continuousOn_primitive_interval'` takes `IntervalIntegrable f mu b1 b2` and an anchor in `[[b1,b2]]`, exactly supporting both variable-endpoint limits in regular-point insertion.
- `MeasureTheory.intervalIntegral_integral_swap` requires `Integrable (uncurry f) ((volume.restrict (uIoc a b)).prod mu)`. Specializing `mu := nu` gives exactly the product premise recorded in IMP-A10.
- `intervalIntegral.integral_eq_sub_of_hasDerivAt_of_le` has the required `a <= b`, continuity, pointwise derivative on the open interval, and derivative-integrability premises.
- `Real.hasDerivAt_exp`, `tendsto_nhds_unique`, `tendsto_finsetSum`, `ContinuousOn.intervalIntegrable_of_Icc`, and `intervalIntegral.integral_undef` exist with the claimed roles.

The pinned `IntegralEqImproper.lean` supplies bridges from proper integrability to endpoint limits but no existing finite-exceptional, independently one-sided relational API replacing T01--T05. The project-local seam is therefore justified rather than duplicative.

## Structural, downstream, and global-rubric assessment

- Mathematical intent: T01--T06 implement the stated finite-exceptional ordinary-improper and Abel layer faithfully. No source coverage is claimed.
- Reusable seams/API: T01 and T05 are meaningful predicates; T02, T03, T04, and T06 are exactly the reusable laws already consumed by QL. T03's finite-union/finite-CLM theorem avoids a proliferation of ad hoc addition, negation, scalar, and refinement targets.
- Dependency/module direction: the proposed `Basic` then `Abel` split is acyclic and foundational. The archived status graph correctly has pinned Mathlib -> IMP -> QL -> OLV-001 -> SR-001, with OLV-002 off-path. No implemented IMP declarations are present at this commit.
- Proof architecture: insertion is isolated as an internal semantic lemma, followed by finite induction; T06 isolates finite Fubini and scalar FTC before algebraic rearrangement. This is appropriately factored.
- Hypothesis laundering: T05's increment law is unweighted local primitive information, not T06 or QL's target; it contains no bound, target parameter, or convergence conclusion. T06 derives the weighted identity. QL adds the baseline bound and positive decay gap. No desired conclusion has been moved into a structure.
- Choice laundering: finite sorting and displayed anchors do not choose an improper value, anchor independence removes presentation dependence, T03 uses the literal union, and `F` is explicit.
- Cost/durability: no performance claim is made before implementation. The exact pinned declarations are appropriate, and keeping the restricted-product measurability obligation explicit localizes the most fragile analytic interface.
- Refactor risk: there is no code to refactor. Exact signatures must preserve the semantic clauses below.

## Finding and acceptance conditions

### G1 (P1): exact theorem signatures are absent

`IMP-001.yaml` deliberately records `exact_signatures_artifact: not_created-design_only_after-two-proof-approvals`. Under the protocol, a theorem-card approval must check exact proposed Lean signatures, imports, binder order, and representation. That check is impossible on the current bytes. This is the only reason for the theorem-card `REQUEST_CHANGES` verdict.

After the second independent revision-3 proof approval, signature design may start. For later card acceptance, the exact signatures must preserve:

1. `S subset (k,+infinity)` and regular-truncation `IntervalIntegrable` evidence in T01/T05;
2. separate nontrivial filters for every left/right endpoint and `+infinity`, never a coupled cutoff;
3. anchor-independent component totals and exact empty-set behavior;
4. T03's literal finite union, finite induction/refinement, and continuous real-linear finite combination;
5. T04's `a <= k` orientation and value `integral a..k f + I`;
6. T06's all-intermediate-point increment law and no derivative premise;
7. product integrability and `AEStronglyMeasurable` under exactly `(volume.restrict (uIoc a b)).prod (volume.restrict (uIoc a b))`, with no global `StronglyMeasurable` strengthening.

No proof change is requested.

## Final acceptance statement

`NLP-IMP-001-R3` at commit `78b9579d05e03ae30436c5632c4e38c32c0da09e`, SHA-256 `d97bd16bbdffeeaa34c2560111f38c714e91e09458d2fb3381535029ca4d431c`, is **APPROVED** as a complete natural-language proof and counts as one approval toward beginning exact-signature design. The semantic dependency/circularity route is **APPROVED**. The revision-3 theorem card is **REQUEST_CHANGES solely for the absent exact-signature artifact**. No implementation or `lean_ready` authorization follows from this report.

Finalized-content SHA-256 (all report bytes through the newline immediately preceding this checksum line): `4e585e09d90dc6e6aa10a5b5401eb9b9f5a2a6473136d4fec7be784346c3c553`
