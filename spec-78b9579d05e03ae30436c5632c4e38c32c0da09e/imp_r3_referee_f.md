# IMP-001 revision-3 exact-commit pre-Lean referee report

## Binding, identity, and method

- Review timestamp (UTC): `2026-09-06T02:17:43Z`.
- Candidate specification commit: `78b9579d05e03ae30436c5632c4e38c32c0da09e`.
- Work item: `IMP-001`, theorem-card revision 3, natural-language-proof artifact `NLP-IMP-001-R3`.
- Reviewer durable ID: `imp_r3_referee_f` (canonical task identity `/root/imp_r3_referee_e/imp_r3_referee_f`).
- Reviewer kind: agent.
- Runtime/model: OpenAI Codex, GPT-5 family; the exact service model identifier is not exposed to this agent.
- Proposer identity: `jaumededios`; the reviewer ID is distinct from the proposer identity recorded in the artifacts.
- Isolation strength: `manual_attestation`, not `technically_enforced`.
- Isolation method: I extracted only the named commit with `git archive` into a new disposable directory. I did not inspect the live worktree, a prior-commit diff, prior review reports/evidence, or another agent's output. I separately fetched Mathlib commit `0df444a360eaa60ab8c11dca51a86af692955474` into a new disposable checkout and inspected its source. No repository file was edited. This report is external to the candidate head.
- Review stage: pre-Lean.
- Perspectives covered: proof correctness / quantitative-integral correctness; dependency direction; source-to-target reachability; hypothesis-and-choice laundering; theorem-card/API completeness.

## Exact artifact digests

### Governing brief and review instructions

| Artifact | SHA-256 |
|---|---|
| `/home/codex/.codex/attachments/6740fc8c-818a-4ce2-95bb-67293a5ba2bf/pasted-text.txt` (1,753 lines, read completely) | `6787cdb628a66783d81190939e9593525ebb2640a8c870d685d95ce26ba0cce3` |
| `referee-lean-library/SKILL.md` | `d4ce5aa5f1c7ebcf18da6f408c2fc2da98fe2dd906fa9c32b6b613b381aa0e9d` |
| `referee-lean-library/references/global-rubric.md` | `990a183dc9e86a3d9580cfb2d5834d36d18afb8a06ad32a114d12b4d0716bb81` |
| `review/PROTOCOL.md` | `e1a85b683abce3072c3e4275ca9312716025d768c4d542aab9c556c6ccc542a3` |
| `review/rubrics/api_dependency.md` | `4e5f947ed15f0101c46fe9bb0a12a013d66c7de3c7ed2c35fda817de8d92eb41` |
| `review/rubrics/mathlib_reuse.md` | `dee214f219ccb03db63194208487f6cb69777b5bc780b608b6e717b729ee901a` |
| `review/rubrics/proof_quality.md` | `55baddf430dc9d7530e644217630a4f0905317e2a5b7bd16126036910a22ca19` |
| `review/rubrics/quantitative_correctness.md` | `1f77ffb3ac536c58875719ebae6cf9bbbcfd4fd027bd491867e0545660745062` |
| `review/rubrics/source_fidelity.md` | `6873853ce125346feef082d0e31d28808387ec0fa5fb0887ce0d300eba02c9a2` |
| `review/classifications-v1.yaml` | `7a4f322bb56dbb40d5d44a7eceb50b5a49ea6ae69f414b920341e3b12ea9d71e` |
| `review/classifications-v2.json` | `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9` |

### Reviewed IMP-001 and downstream/status artifacts

| Artifact | SHA-256 |
|---|---|
| `blueprint/proofs/IMP-001.md` | `d97bd16bbdffeeaa34c2560111f38c714e91e09458d2fb3381535029ca4d431c` |
| `blueprint/theorem_cards/IMP-001.yaml` | `35cb365a0de0492ddc7d6a62e66734400f92c7b79434afa08d9ea1ab2033dcb2` |
| `blueprint/proofs/QL-001.md` | `4b70ef576ff90e972ac2ea4e8beac91bca8a208b849f82f87c4afe06a14b5859` |
| `blueprint/theorem_cards/QL-001.yaml` | `a85af11116ad2900bb4c7a01acfbfc1eb791a1f1f2a3755ccefa1f3e28ec471d` |
| `blueprint/proofs/OLV-001.md` | `11b6d71aa9fba5699bc2703ead20bbee1db9208df5e83de0a969dbb51e87aaf7` |
| `blueprint/theorem_cards/OLV-001.yaml` | `e1863ef77180b18ca02a107248c69913ac036d2f16e13ad282b17abe8f8cdbaa` |
| `blueprint/proofs/OLV-002.md` | `015c16bf3ffa2fd981083f47029398961ac9773ac638d88c3698732e3a5b4d0d` |
| `blueprint/theorem_cards/OLV-002.yaml` | `c625207e0a75c6e6815f6cae603bf05e4761a1070856f65eee5917c0de99bf81` |
| `blueprint/dependency_graph.md` | `7c5ca4b66420982a228c7ad37f49c4b26ec6c2fac3cb3f863288455efa5d263b` |
| `blueprint/methods/integral_laplace.md` | `f7862ccf3aa149b4fae34f552c1d0227379a3e9c99f611471b9027208517ad8b` |
| `lake-manifest.json` | `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404` |
| `lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |

The manifest resolves Lean `v4.33.1` and Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`, matching the proof and card.

### Exact pinned Mathlib source inspected

| Mathlib source at `0df444a360eaa60ab8c11dca51a86af692955474` | SHA-256 |
|---|---|
| `Mathlib/MeasureTheory/Integral/IntervalIntegral/Basic.lean` | `93908eb0c771ba8edcb47537dfe1a40e98a1545be9d427c1eb9823d44decdcd5` |
| `Mathlib/MeasureTheory/Integral/DominatedConvergence.lean` | `18b709ea5c9ef9136e3e75ded82a6135641e6e19688e0ca3abcb0af45648ab84` |
| `Mathlib/MeasureTheory/Integral/Prod.lean` | `c7d4d23349591c5c65aa5b1b6024331fb0b7f22e9b2b08d6a1fe19b1c258ec5b` |
| `Mathlib/MeasureTheory/Integral/IntervalIntegral/FundThmCalculus.lean` | `5fd64054d9ae8bfce585ff809933a756bcf2d224ef144ae24c8fe8870c68050c` |
| `Mathlib/Analysis/SpecialFunctions/ExpDeriv.lean` | `7678c4712458f4129eb9b29ea7eb332467501cc8a6688547d1ed1b25f8849722` |
| `Mathlib/Topology/Algebra/Monoid.lean` | `cf858f52c0f84ad0f0f950ddc0c76128c4893ced7620d0c7a4cef1c9c3ddab56` |
| `Mathlib/Topology/Separation/Hausdorff.lean` | `4e6998adc898c3aac6d01e0c8bc916aa68794bf6cca0d3c57e43f76760151a87` |
| `Mathlib/MeasureTheory/Integral/IntegralEqImproper.lean` (closest general improper-integral infrastructure checked) | `9b23ece88109c97647472e92ac73478da988c81436efc63e17a2acfb2db15353` |

All ten declarations in the IMP dependency ledger exist at the stated pin and in the stated defining modules. In particular, the exact `MeasureTheory.intervalIntegral_integral_swap` premise is

```text
Integrable (uncurry f) ((volume.restrict (Set.uIoc a b)).prod μ)
```

and specializing `μ` to `ν := volume.restrict (Set.uIoc a b)` produces exactly the restricted product measure asserted in IMP.14a. `intervalIntegral.continuousOn_primitive_interval'` takes `IntervalIntegrable f μ b₁ b₂` and an anchor in `[[b₁,b₂]]`; `ContinuousLinearMap.intervalIntegral_comp_comm`, `intervalIntegral.integral_add_adjacent_intervals`, `ContinuousOn.intervalIntegrable_of_Icc`, `intervalIntegral.integral_eq_sub_of_hasDerivAt_of_le`, `intervalIntegral.integral_undef`, `Real.hasDerivAt_exp`, and `tendsto_nhds_unique` have the required orientations. `tendsto_finsetSum` is generated in `Topology/Algebra/Monoid.lean` by the additive counterpart of `tendsto_finsetProd`. The closest pinned `IntegralEqImproper` infrastructure concerns recovering proper integrals/FTC facts from interval limits and does not provide a finite-exception, independently one-sided, conditionally improper value relation. The project-local seam is therefore justified.

## Verdict summary

1. **Natural-language proof (`NLP-IMP-001-R3`): APPROVE.** Yes, this is one valid independent approval toward the two approvals required before starting exact-signature design. It is not a second approval, is not theorem-card approval, does not make `lean_ready` pass, and does not authorize Lean implementation.
2. **Structural/circularity: APPROVE** for all three required perspectives: dependency direction, source-to-target reachability, and hypothesis-and-choice laundering.
3. **Theorem card (`IMP-001`, revision 3): REQUEST_CHANGES.** The sole material card issue is the deliberately absent exact Lean signature artifact (including concrete representation, exact binders, exact target types, and verified minimal import closure). The card correctly records that absence. Under `review/rubrics/api_dependency.md` check 11 and `review/PROTOCOL.md`, a pre-Lean theorem-card gate cannot approve without exact signatures. No independent mathematical, classification, dependency, scope, or convention defect was found in the card.

## Independent rederivation of T01--T06

### T01: finite-exception right-ray relation

Increasingly enumerate the finite set `S` above `k`. Require honest `IntervalIntegrable` evidence on every compact interval inside a regular component, independent one-sided limits at each finite break, and an independent limit at positive infinity. Sum the first component, both sides of every interior/final component, and the final outer limit. This defines a partial relation on a proposed value; it neither uses a totalized nonintegrable integral nor couples the two sides as a principal value.

Changing a component anchor from `d` to `e` changes the left component limit by `+∫_d^e f` and the right component limit by `-∫_d^e f`, so their sum is invariant. The same calculation works in the final unbounded component. Thus the deterministic anchors in the prose do not change the relation.

### Regular-point insertion and the four cases

Let `d` be a new regular marked point. Choose `p < d < q` within its old component. `IntervalIntegrable f p q` and pinned `intervalIntegral.continuousOn_primitive_interval'` make `P(x)=∫_p^x f` continuous on `[p,q]`. Additivity then gives the two separate endpoint limits

```text
∫_u^x f -> ∫_u^d f  as x ↑ d,
∫_x^v f -> ∫_d^v f  as x ↓ d.
```

These are individual limits, not only a convergent sum. The total bookkeeping is exact in every position:

- Empty old set: for fixed `v>d`, the old value is
  `∫_k^d f + ∫_d^v f + lim_{R→∞} ∫_v^R f`; these are exactly the new first contribution and the two contributions of the new final component.
- First component: if `B = lim_{x↑c₁} ∫_k^x f` and `d<v<c₁`, the new contributions are
  `∫_k^d f`, `∫_d^v f`, and `B-∫_k^v f`. Their sum is
  `∫_k^d f + ∫_d^v f + B - ∫_k^v f = B`.
  This is the required corrected first-component bookkeeping with explicit anchor `v`; both new component limits have been computed separately.
- Bounded interior component `(c_i,c_{i+1})`: choose `u<d<v` inside it and express the old component value as
  `L_u + ∫_u^d f + ∫_d^v f + R_v`. The two new component values are
  `L_u+∫_u^d f` and `∫_d^v f+R_v`, hence sum to the old value.
- Final component `(c_m,∞)`: with `u<d<v`, express the old value as
  `L_u + ∫_u^d f + ∫_d^v f + R_v^∞`. The new bounded and final component values are
  `L_u+∫_u^d f` and `∫_d^v f+R_v^∞`, again preserving the old value.

Restriction supplies every new compact integrability fact, and unaffected outer limits remain literal old limits. Thus insertion is reversible at a point known regular.

### T02: uniqueness

Use the same canonical increasing enumeration and deterministic anchors for two witnesses. Each proposed component limit is the limit of the same function along the same nontrivial one-sided filter. Hausdorff uniqueness identifies every component value, after which the same finite sum identifies the two totals. No cross-singularity integrability or principal-value reasoning is used.

### T03: finite-union refinement and finite CLM linearity

For each summand `i`, let `Δ_i = S_A \ S_i`, where `S_A` is the literal finite union. Enumerate the finite set `Δ_i` and induct on its cardinal/list length. At each successor step, the next point is outside the original `S_i` and distinct from previously inserted points, so it remains in one current regular component. Apply the four-case insertion lemma. The proposed value and all old outer limits are invariant at each step. Finite induction yields a witness for `f_i` on the common set `S_A`.

On every `S_A`-regular compact interval, all refined summands are interval integrable. Continuous real-linear maps commute with the interval integral, finite sums preserve integrability, and `tendsto_finsetSum` passes the finite sum through each endpoint limit. Interchanging the two finite sums is algebraic, giving exactly `Σ_i T_i(I_i)`. The empty-index, addition, negation, real scaling, and fixed-complex-multiplication cases all follow without an infinite limit/sum interchange.

### T04: prepend/split a regular compact interval

For `a≤k`, put `J=∫_a^k f`. On every sufficiently far/right regular truncation, interval additivity gives

```text
∫_a^R f = J + ∫_k^R f
```

in the empty-set case, and the analogous identity up to the first exceptional point otherwise. All later component limits are unchanged. Taking or subtracting the fixed vector `J` proves both directions of

```text
HasImp(f,a,S,J+I) <-> HasImp(f,k,S,I).
```

The assumptions also give the compact integrability clauses that cross `k`. The orientation and the displayed order `J+I` are correct, including `a=k`.

### T05: normalized finite-exception primitive

The predicate exposes only: `S⊂(k,∞)`, continuity of explicit `F` on the ray, `F(k)=0`, and the regular-piece integrability/increment identity. At a finite exceptional point `c`, continuity gives independently

```text
∫_d^b g -> F(c)-F(d)  as b ↑ c,
∫_a^e g -> F(e)-F(c)  as a ↓ c.
```

Hence the certificate supports the T01 finite-endpoint semantics but deliberately supplies no limit at infinity and no bound. It does not contain the QL-001 conclusion.

### T06: finite Abel identity and exact restricted-product integrability

Let `ν = volume.restrict (Set.uIoc a b)` and `G(t)=∫_a^t g`. For

```text
H(t,v) = 1_{a≤v≤t≤b} * (w(t) • g(v)),   w(t)=exp(-h*t),
```

the exact Fubini obligation is `Integrable (Function.uncurry H) (ν.prod ν)`. It follows without a global `StronglyMeasurable g` assumption:

1. `IntervalIntegrable g volume a b` and `a≤b` give `Integrable g ν`, hence `AEStronglyMeasurable g ν`.
2. The pinned product API lifts this to `g ∘ snd` under `ν.prod ν`. Continuity/measurability of `w ∘ fst`, measurability of the triangle, continuous scalar multiplication, and measurable-set indication preserve `AEStronglyMeasurable` under that exact product measure.
3. On the restricted square, `||H(t,v)|| ≤ M ||g(v)||` with finite `M = exp(|h| max(|a|,|b|))`. Since `ν` is finite and `||g||` is integrable under `ν`, the product majorant has finite integral. Bochner domination therefore gives exactly `Integrable (uncurry H) (ν.prod ν)`.

Pinned `MeasureTheory.intervalIntegral_integral_swap`, with its inner measure specialized to `ν`, now applies. Indicator sections and null endpoints give

```text
∫_a^b w(t) • G(t) dt
  = ∫_a^b (∫_v^b w(t) dt) • g(v) dv.
```

From `Real.hasDerivAt_exp` and the chain rule, `w'=-h w`. The pinned FTC theorem yields, without dividing by `h`,

```text
h * ∫_u^v w(t) dt = w(u)-w(v),
```

including `h=0`. Multiplying the Fubini identity by `h` and using the increment law at `b` gives IMP.17. Since `F(t)=F(a)+G(t)` on the whole interval, the constant part contributes `(w(a)-w(b))•F(a)`. Adding and rearranging yields precisely

```text
∫_a^b w(t) • g(t) dt
  = w(b)•F(b) - w(a)•F(a) + h•∫_a^b w(t)•F(t) dt.
```

The proof uses neither a pointwise derivative of `F` nor a whole-prefix interval integral across an exceptional point. Degenerate `a=b`, zero `h`, and continuous nondifferentiable primitives remain included.

## Structural/circularity audit

- Dependency direction: the pinned analytic/topological facts feed `IMP-001`; `IMP-001` feeds `QL-001`; `QL-001` feeds `OLV-001`; source recovery remains downstream. `OLV-002` is a separate direct-majorant branch. No reviewed IMP target imports or invokes QL, OLV, Gamma, QB, DEF, audit, or tactic material.
- Source-to-target reachability: IMP-001 binds no source occurrence and explicitly earns no source coverage. Its first actual consumer is the QL-001 bounded-baseline-primitive route; OLV-001 derives that primitive and its bound from one baseline source convergence statement. Nothing downstream is used to establish an IMP premise.
- Hypothesis laundering: T01's integrability and independent limits define the intended ordinary-improper relation. T05's increment law is strictly weaker/different than the requested weighted tail conclusion, carries no `L`, no target weight `x`, and no infinity limit. T06 consumes only finite-piece integrability, continuity, and the all-intermediate-point increment law. These are genuine upstream primitive data, not restatements of the Abel conclusion.
- Choice laundering: exceptional sets and their finite union are explicit; sorting is canonical; anchor dependence cancels; values are relational and unique; `F` is explicit input; there is no `Classical.choose` value function or hidden choice of a target weight/constant.
- Reusable seam: the finite-exception relation and primitive predicate form a recognizable source-independent integration boundary, isolate conditional convergence from QL estimates, and already have the direct QL consumer plus the indirect OLV route. They are not tuple-renaming wrappers around the pinned absolute-integral API.

Verdict: **APPROVE**.

## Global library-rubric sweep

| Rubric area | Result |
|---|---|
| Mathematical intent | Clear: all six targets implement the documented conditional-improper semantics and exact finite Abel route; no source or quantitative claim is added. |
| Reusable seams | Clear: T01/T05 isolate a real mathematical boundary used by QL; T02--T04 are the minimal relation laws; T06 is a separate analytic identity. |
| Public API/theorem shape | One blocking card-completeness finding: exact signatures are absent. No prose-level shape defect found. |
| Module/dependency design | Clear: prospective `Improper.Basic` then `Improper.Abel`, followed by QL/OLV; no reverse edge. |
| Mathlib integration | Clear at the proof-plan level: exact pin and exact declarations checked; no pinned finite-exception relation replaces T01/T05. |
| Proof architecture | Clear: semantics, anchor/insertion, finite refinement, split, primitive certificate, Fubini, scalar FTC, and final rearrangement are separated by mathematical role. |
| Cost/durability | No implementation exists, so no elaboration/import-performance claim is made. The planned narrow source modules are appropriate. |
| Refactor risk | Exact representation and signatures must be frozen before implementation; no current consumer migration is authorized. |

## Finding and acceptance condition

### `IMP3-F-01` — P1 — theorem card lacks exact Lean signatures

The card lists only prospective declaration names and explicitly defers the concrete representation of ordered components/endpoint filters, binder order, target types, and minimal transitive imports. The API/dependency rubric requires those exact signatures for theorem-card approval. This is not a defect in the natural-language proof and is consistent with the project's deliberate proof-before-signature sequence.

Acceptance condition: after a second independent approval of the unchanged revision-3 natural-language proof, add an exact compiled signature artifact for all six targets, bind its digest and exact imports in a new theorem-card revision, and obtain fresh theorem-card/API review of those bytes. The signature must preserve the reviewed semantics, especially the individual endpoint limits, literal finite union, T04 orientation, all-`t` T06 increment law, and the restricted-product Fubini obligation without a global measurability premise.

No other material finding is open in this review.

## Acceptance statement

I approve the mathematical natural-language proof `NLP-IMP-001-R3` at commit `78b9579d05e03ae30436c5632c4e38c32c0da09e`. **Yes, this verdict is one valid independent proof approval toward starting exact-signature design.** The structural/circularity perspectives also approve. I request changes on theorem-card revision 3 solely because exact Lean signatures are intentionally absent. This combined report does not declare the composite `lean_ready` gate passed and does not authorize implementation.

## Integrity

Canonical report SHA-256 (computed over this UTF-8 file with the 64 hexadecimal characters in the next field replaced by 64 zeroes):

`284739ac14d9c19aaa1ec4cd5b761c24ae962592d2d61fa57d238b6135810909`
