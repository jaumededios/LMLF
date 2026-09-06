# Independent pre-Lean referee report: IMP-001 revision 2

## Review identity and binding

- Reviewer ID: `imp_r2_referee_d` (canonical task identity `/root/imp_r2_referee_d`)
- Reviewer kind: agent
- Model: OpenAI Codex, GPT-5 family; the runtime did not expose a more specific deployment/model ID, so none is invented here
- Runtime: Codex desktop subagent, Linux container, UTC, review date 2026-09-06
- Review stage: `pre_lean`
- Perspectives: `proof_correctness`, `dependency_direction`, `source_to_target_reachability`, and `hypothesis_and_choice_laundering`
- Isolation strength: `manual_attestation`
- Isolation method: fresh agent context; exact repository commit extracted with `git archive` into `/tmp/imp-r2-ref-d.sPl8pF`; exact pinned Mathlib files separately extracted by `git archive` into `/tmp/mathlib-imp-r2-ref-d.EBHF6B`; no live-worktree source was reviewed; no prior referee report, disposition record, or other evidence output was read
- Repository: `/home/codex/Documents/Codex/2026-09-05/yo`
- Reviewed commit: `128cd804b676074b2958157864e2e4357d4bc121`
- Commit tree: `2abd6f829f55ed8ead66b9953cc00f3e1a21357f`
- Parent: `586e8c6609aaf2446c9996f4dd61f514d8428450`
- Commit subject: `docs: repair finite-exceptional integration proof`
- Commit author/time: Jaume de Dios Pont, `2026-09-06T01:56:03+00:00`

This report judges the exact archived bytes above. It makes no claim about the live worktree, later commits, implementation, or source coverage.

## Bound artifacts and SHA-256 digests

Primary external brief:

- `/home/codex/.codex/attachments/6740fc8c-818a-4ce2-95bb-67293a5ba2bf/pasted-text.txt`: `6787cdb628a66783d81190939e9593525ebb2640a8c870d685d95ce26ba0cce3` (1,753 lines; read completely)

Primary IMP-001 R2 artifacts:

- `blueprint/theorem_cards/IMP-001.yaml`: `70a1a227da5bbfd217c7e1e91b6fc9f9d77a274b704d668895509d0e4bb2cb9e`
- `blueprint/proofs/IMP-001.md`: `b16460f7286500efce6360ce4f7f0adae4eeedc989dd956e7a253e0804c83d06`

Downstream QL/OLV consumers read completely:

- `blueprint/theorem_cards/QL-001.yaml`: `64a395c99c79ca2e3dc92bb39cb531dc0ce25494f1ea48311069deb30dcef3fb`
- `blueprint/proofs/QL-001.md`: `4b70ef576ff90e972ac2ea4e8beac91bca8a208b849f82f87c4afe06a14b5859`
- `blueprint/theorem_cards/OLV-001.yaml`: `e1863ef77180b18ca02a107248c69913ac036d2f16e13ad282b17abe8f8cdbaa`
- `blueprint/proofs/OLV-001.md`: `11b6d71aa9fba5699bc2703ead20bbee1db9208df5e83de0a969dbb51e87aaf7`
- `blueprint/methods/integral_laplace.md`: `a82590826bebb9c00e15aa70a84afebc60365a7e547eab3117b3a6f36dc5e413`

Governance, dependency, status, and pinned-reuse artifacts read:

- `README.md`: `ed6b081dd8e3deafa6e7c9a4dd9f9efd88a0066e644e594eb18648eb1f3d9ba1`
- `blueprint/README.md`: `1643ccb676956dc7c8ad8cf0cebd67866701c022eddc997a2ed61c86e8bf86e8`
- `blueprint/roadmap.md`: `2e76be8dceded6dfda5b578555ef3f32919de6789d797e02e6760e17a9ca3d2a`
- `blueprint/source_manifest.md`: `09c62ea76ab7ecc83d8685a876fed1ba001aec5af9aa91e81dd7467568c95fc9`
- `blueprint/dependency_graph.md`: `1a8a555642ea136b699f00263fd7eb61b28d35144e0b76086f4d94a82f1b201c`
- `blueprint/design_decisions.md`: `e3a0d2049f755e28f81d1588c3bd2925bd67b8fc9103c4e83444c0b369a944d7`
- `blueprint/function_inventory.md`: `cf2e356e34a58e8530500603db6a63f1ec5f025d8988dffe6652f2c816caa50d`
- `blueprint/theorem_cards/README.md`: `23ae93df7c799a757296e16893e652d066516fd8003f4d3ec561a52725455793`
- `blueprint/mathlib_audit.md`: `6b0aab27aac6711894567048c3f232f6ab3345b5d0c79b5b3402e0ecad38378c`
- `review/PROTOCOL.md`: `e1a85b683abce3072c3e4275ca9312716025d768c4d542aab9c556c6ccc542a3`
- `review/README.md`: `1bdce8ab0c9355c292a91dc29687422f927b721f54ea59c54acfba86b9e90df9`
- `review/classifications-v2.json`: `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9`
- `review/rubrics/api_dependency.md`: `4e5f947ed15f0101c46fe9bb0a12a013d66c7de3c7ed2c35fda817de8d92eb41`
- `review/rubrics/mathlib_reuse.md`: `dee214f219ccb03db63194208487f6cb69777b5bc780b608b6e717b729ee901a`
- `review/rubrics/proof_quality.md`: `55baddf430dc9d7530e644217630a4f0905317e2a5b7bd16126036910a22ca19`
- `review/rubrics/quantitative_correctness.md`: `1f77ffb3ac536c58875719ebae6cf9bbbcfd4fd027bd491867e0545660745062`
- `review/rubrics/source_fidelity.md`: `6873853ce125346feef082d0e31d28808387ec0fa5fb0887ce0d300eba02c9a2`
- `lake-manifest.json`: `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`
- `lean-toolchain`: `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71`

Referee skill and global rubric:

- `/home/codex/.codex/skills/referee-lean-library/SKILL.md`: `d4ce5aa5f1c7ebcf18da6f408c2fc2da98fe2dd906fa9c32b6b613b381aa0e9d`
- `/home/codex/.codex/skills/referee-lean-library/references/global-rubric.md`: `990a183dc9e86a3d9580cfb2d5834d36d18afb8a06ad32a114d12b4d0716bb81`

The complete skill and every section of its global rubric were read before judgment. The project protocol and all five focused review rubrics were also read completely.

## Exact pinned Mathlib source

The manifest resolves Mathlib to `0df444a360eaa60ab8c11dca51a86af692955474`, and the dependency checkout's `HEAD` was exactly that commit. The following exact files were archived from that commit and inspected around every cited declaration:

| File | Git blob | SHA-256 |
|---|---|---|
| `Mathlib/MeasureTheory/Integral/IntervalIntegral/Basic.lean` | `4092210205f534fd53ca3139589e2aa26f88a00d` | `93908eb0c771ba8edcb47537dfe1a40e98a1545be9d427c1eb9823d44decdcd5` |
| `Mathlib/MeasureTheory/Integral/Prod.lean` | `78ec1994b9fa11e71f65fe9064d1aa5f90b13ff2` | `c7d4d23349591c5c65aa5b1b6024331fb0b7f22e9b2b08d6a1fe19b1c258ec5b` |
| `Mathlib/MeasureTheory/Integral/DominatedConvergence.lean` | `e01402b504d1b8f96ed88bdd18266da7def493aa` | `18b709ea5c9ef9136e3e75ded82a6135641e6e19688e0ca3abcb0af45648ab84` |
| `Mathlib/MeasureTheory/Integral/IntervalIntegral/FundThmCalculus.lean` | `82d269a5e9269d791f5581f5f0da29cfc125541a` | `5fd64054d9ae8bfce585ff809933a756bcf2d224ef144ae24c8fe8870c68050c` |
| `Mathlib/MeasureTheory/Integral/Bochner/Basic.lean` | `5aab70490dd61ebcfaf9c50ef26dcb612c25091b` | `f81a06eab17faccbc4b671a93e7af73332f5fd3946f7690e7c2a3cfee77d28c8` |
| `Mathlib/Analysis/SpecialFunctions/ExpDeriv.lean` | `65e0c15f2921a9dfd6bea14c06d2b46699dccc2a` | `7678c4712458f4129eb9b29ea7eb332467501cc8a6688547d1ed1b25f8849722` |
| `Mathlib/Topology/Algebra/Monoid.lean` | `0dac831950493b3a8af9373f5f9c6cd99b6f4538` | `cf858f52c0f84ad0f0f950ddc0c76128c4893ced7620d0c7a4cef1c9c3ddab56` |
| `Mathlib/Topology/Separation/Hausdorff.lean` | `035464532dbc48a094702ce5046ec3a46ed23824` | `4e6998adc898c3aac6d01e0c8bc916aa68794bf6cca0d3c57e43f76760151a87` |

Exact findings from the source comparison:

- `intervalIntegral.continuousOn_primitive_interval'` has precisely the needed hypotheses: `IntervalIntegrable f μ b₁ b₂` and an anchor in `[[b₁,b₂]]`; for volume, the required singleton-null property is available. It returns continuity of the variable upper-endpoint primitive on the whole unoriented interval.
- `MeasureTheory.intervalIntegral_integral_swap` requires exactly `Integrable (uncurry f) ((volume.restrict (Set.uIoc a b)).prod μ)`. Specializing `μ` to the same restricted-volume measure gives exactly IMP.14a.
- `intervalIntegral.integral_add_adjacent_intervals`, `ContinuousLinearMap.intervalIntegral_comp_comm`, `ContinuousOn.intervalIntegrable_of_Icc`, `tendsto_nhds_unique`, `tendsto_finsetSum`, `intervalIntegral.integral_eq_sub_of_hasDerivAt_of_le`, `intervalIntegral.integral_undef`, and `Real.hasDerivAt_exp` all exist at the stated pin with compatible orientation and hypotheses.
- No existing project or Mathlib declaration supplies the proposed finite-exceptional relation or its exact finite-union API. The local abstraction is justified by a concrete QL-001 consumer and a meaningful semantic boundary.

No IMP declaration or exact signature exists, so no implementation build or signature-elaboration claim is made. The deterministic library-inventory script found only the existing 210-line bootstrap Lean surface and no IMP implementation or trust marker.

## Executive verdicts

| Review surface | Controlled verdict | Reason |
|---|---|---|
| Mathematical/theorem-card content of IMP-001 R2 | **APPROVE for the signature-design phase** | The six-target scope, quantifiers, orientations, exceptional semantics, dependency boundary, and classifications are coherent and sufficient to design exact signatures. |
| Formal theorem-card gate | **REQUEST_CHANGES / not yet passable** | The card is deliberately a draft, unregistered, and has no exact-signature artifact, exact binder representation, frozen packet, or external binding. The project rubric expressly forbids a theorem-card gate from passing without those items. This is procedural and not a mathematical rejection. |
| Natural-language proof `NLP-IMP-001-R2` | **APPROVE** | T01--T06 are reached without circularity, hidden differentiation, absolute-integrability strengthening, principal-value coupling, or target-bound laundering. |
| Structural/circularity review | **APPROVE** | Dependencies point from pinned integration facts to IMP, then to QL and OLV. T05's increment law is exact primitive data, not the QL bound; all choices and exceptional sets are explicit or canonical. |

There is no P0, P1, or P2 mathematical finding.

### Does this authorize exact-signature design?

**This report is a fresh `APPROVE` verdict on the exact R2 natural-language proof and is eligible to count as one of the two independent proof approvals required before exact-signature design. It is not, by itself, the required two-reviewer quorum.** Exact-signature design may begin only when a second distinct, current approval binds the same commit and the same card/proof hashes. Even then, implementation remains forbidden until the resulting exact signatures, registered/frozen packet, structural requirements, and external `lean_ready` envelope pass.

## Independent reconstruction of T01--T06

### T01: finite-exceptional ordinary-improper relation

The proposed relation has the right semantics. For ordered `S = {c₁ < ... < cₘ}`, it requires honest Bochner `intervalIntegral` integrability on every compact interval wholly inside a regular component, separate left and right endpoint limits at each `cᵢ`, and a separate limit at `+∞`. The value is the finite sum of those component contributions. When `S` is empty this reduces to the ordinary one-sided limit of `∫ k..R f` plus compact integrability. Nothing uses the totalized value of a nonintegrable integral, and no common cutoff couples two sides of an exception.

Anchor independence is exact. If `l < d < e < r`, adjacent-interval additivity changes the left contribution by `+∫ d..e f` and the right contribution by `-∫ d..e f`. These cancel. The argument is unchanged in the final unbounded component because only its outer endpoint filter changes from a finite one to `atTop`.

### Repaired regular-point insertion

The R2 repair is sufficient.

1. **Existence of `p < d < q`.** Since `S` is finite, `d ∉ S`, and `k < d`, the component of `[k,∞) \ S` containing `d` has a strict lower endpoint and either a strict finite upper endpoint or no upper endpoint. In a bounded component, choose points between the endpoint and `d` and between `d` and the endpoint. In a final component, choose any `q > d`; in the empty-set case the lower endpoint is `k`. Thus a compact `[p,q]` inside the original regular component always exists. No compactness, choice of an exceptional value, or order-dependent selection is hidden here.
2. **Continuity theorem hypotheses.** T01's regularity clause gives `IntervalIntegrable f volume p q`. The anchor `p` belongs to `[[p,q]]`. The exact pinned theorem therefore makes `P(x)=∫ p..x f` continuous on `[p,q]`. Full relative continuity at the interior point `d` implies both the left and right `Tendsto` facts.
3. **Separate limits.** Adjacent-interval additivity gives `∫ u..x f = P(x)-P(u)` and `∫ x..v f = P(v)-P(x)` for fixed regular `u<d<v`. Continuity at `d` produces the two limits separately, with values `∫ u..d f` and `∫ d..v f`; the proof does not merely obtain their sum.
4. **Empty case.** Inserting `d` into `[k,∞)` gives the new first limit at `d`, the new final left limit at `d`, and the new outer limit by subtracting fixed compact pieces from the old `R→∞` limit. The new contributions sum to the old value.
5. **First component.** Inserting `d` in `[k,c₁)` splits the old first contribution into the `k→d` part and the `d→c₁` part. The old left limit at `c₁` is preserved after subtracting `∫ k..d f`; every later exceptional and infinite endpoint is unchanged.
6. **Bounded interior component.** Inserting `d` in `(cᵢ,cᵢ₊₁)` preserves the old outer limits at `cᵢ` and `cᵢ₊₁`, adds the two separate limits at `d`, and changes only the choice of fixed compact pieces. The four new pieces telescope to the old two-piece component value.
7. **Final unbounded component.** Inserting `d` in `(cₘ,∞)` gives both limits at `d`; the old infinity limit supplies the new final outer limit after subtracting a fixed compact integral. Earlier components are untouched.

These four positions are exhaustive. Integrability on all new regular compact intervals follows by restriction and adjacent transitivity.

### T02: uniqueness

For a fixed representation of components/anchors, each candidate witness gives a limit of the same function along the same left, right, or `atTop` filter. Those filters are nontrivial because all endpoint inequalities are strict and the real line is dense; `tendsto_nhds_unique` therefore identifies every component limit. Finite sums then identify the total. If exact signatures allow witness-selected anchors, the implementation must first transport both witnesses to a common canonical anchor using I01; the card already treats canonical sorting/anchors as the intended design.

### T03: finite union and continuous-linear combination

For fixed `i`, every point of `S_A \ S_i` is genuinely regular for `f_i`. Enumerating this finite difference and applying I02 one point at a time is valid. Previously inserted points merely subdivide the original `S_i`-regular component and do not destroy the original compact-integrability fact used for the next insertion. The invariant at every stage is: the improper value is unchanged, all prior outer limits are retained, and both limits at every new mark exist independently. Hence the induction reaches the literal union `S_A`, not an arbitrary enlargement.

Once all summands share `S_A`, finite integrability and `ContinuousLinearMap.intervalIntegral_comp_comm` give the compact-piece identity, while continuity of each map and `tendsto_finsetSum` transport every endpoint limit. The empty-index case gives zero; two identity maps give addition; negation and fixed scalar multiplication are continuous real-linear maps. For complex multiplication the real-linear formulation is correct. No infinite interchange occurs.

### T04: regular prefix splitting

With `a ≤ k` and `J=∫ a..k f`, adjacent-interval additivity gives `∫ a..R f = J + ∫ k..R f`, or its corresponding first-component formula before `c₁`. Later components are identical. Therefore the equivalence has value order `J + I`, not `I - J` and not a reversed interval. At `a=k`, `J=0`. The stated integrability assumption on `[a,k]` plus the old regular-piece integrability supplies every new first-component compact interval.

### T05: primitive certificate

The predicate records exactly continuity on `[k,∞)`, normalization `F(k)=0`, and the regular-piece increment law with explicit `IntervalIntegrable` evidence. For `c∈S`, the increment law on each adjacent regular component and continuity of `F` give the two finite endpoint limits independently. It contains no bound on `F`, no limit at infinity, no target Laplace parameter, and no weighted-tail conclusion. Thus it is a legitimate primitive interface rather than QL-001 packed into a hypothesis.

### T06: finite Abel identity

Let `G(t)=∫ a..t g`, `w(t)=exp(-h t)`, and `ν=volume.restrict (uIoc a b)`. Since `a≤b`, `uIoc a b=Ioc a b`; the interval orientation is positive and `ν` is finite with mass `b-a`.

For the triangle kernel

`H(t,v) = 1_{a≤v≤t≤b} w(t) • g(v)`,

`IntervalIntegrable g volume a b` gives integrability of `g` and `‖g‖` under `ν`. The scalar weight is bounded on `[a,b]`, the triangle is measurable, and scalar multiplication is continuous. Thus `uncurry H` is a.e. strongly measurable and its norm is dominated by an integrable function on `ν.prod ν`. This proves the exact product-integrability premise required by `MeasureTheory.intervalIntegral_integral_swap`; separate sectionwise integrability is not being substituted for it.

After swapping, the sections give

`∫ a..b w(t) • G(t) dt = ∫ a..b (∫ v..b w(t) dt) • g(v) dv`.

Endpoint differences between the restricted set integrals and interval integrals are null. There is no sign reversal because `a≤b` is explicit.

The scalar identity `h * ∫ u..v exp(-h t) dt = w(u)-w(v)` follows from the derivative of the exponential and finite FTC without dividing by `h`. Consequently it is valid for negative, positive, and zero `h`. Multiplying the triangular identity by `h` gives

`h • ∫ wG = ∫ wg - w(b) • (F(b)-F(a))`.

Using `F=F(a)+G` and the same scalar identity for the constant term gives

`h • ∫ wF = ∫ wg - w(b) • F(b) + w(a) • F(a)`,

which rearranges to the exact target sign

`∫ wg = w(b) • F(b) - w(a) • F(a) + h • ∫ wF`.

When `a=b`, all interval integrals vanish and the two boundary terms cancel. When `h=0`, the identity reduces exactly to `∫ a..b g = F(b)-F(a)`. No division by `h` is present.

The proof never assumes or needs a pointwise derivative of `F`. It assumes `g` is interval integrable on the finite component and the all-`t` increment law; that is precisely the finite primitive data used by Fubini. It does not assume local integrability across a point in `S`, because T06 is applied separately on regular components. It does not use a principal value: downstream composition takes independent endpoint limits and uses continuity of `F` only to cancel the resulting boundary values.

## Downstream reachability and structural audit

The intended dependency chain is mathematically sound:

`pinned finite integration/limit facts → IMP-001 → QL-001 → OLV-001 → SR-001`.

- QL-001 applies T06 only on regular finite pieces, then takes the T01 independent endpoint limits. T05 continuity cancels opposite boundary values at each exception. It does not replace the split value with a totalized single `intervalIntegral` across `S`.
- T03 is exactly what is needed to subtract finitely many smooth model moments (empty exceptional set) from an amplitude with exceptional set `S`; T04 attaches the regular local interval to the tail with the correct sign.
- OLV-001 derives, rather than assumes, the T05 primitive and its order-dependent bound from convergence at one common baseline `X`; `X` is chosen before `n`. Nothing in IMP depends on QL, OLV, Gamma, QB, DEF, a named function, or a source theorem.
- T05's explicit `F` avoids choice laundering. Finite-set sorting is canonical, auxiliary anchors are proved immaterial, and T03's output exception set is the literal finite union.
- The proposed `Basic`/`Abel` module split has the correct direction. The project-local finite-exceptional relation has a real downstream consumer and isolates a semantic boundary not present in Mathlib, so it is not a speculative wrapper.

The exact-signature phase should preserve one crucial distinction in names/types: expressions such as the downstream `∫ k..R` in prose denote the finite sum of split component values whenever exceptions intervene, not one Mathlib interval integral. A relational value or component-sum object should keep that distinction syntactically visible.

## Findings and nonblocking observations

### G1 — P3 — stale R1 status in the blueprint index

`blueprint/README.md` lines 153--156 say that IMP-001 has a “revision-1 draft card,” while the same archived index and all authoritative IMP/status artifacts identify revision 2. This is a low-impact status typo, not a mathematical or dependency defect. Correct it when the next specification bytes are prepared; doing so will change the artifact hash and require the normal review binding discipline.

### N1 — implementation wording: a.e. strong measurability

In `blueprint/proofs/IMP-001.md` lines 576--583, the Fubini paragraph says “Strong measurability follows.” From `IntervalIntegrable`, the directly available Mathlib fact is `AEStronglyMeasurable` under the restricted measure, which is exactly what `Integrable` needs. The product-kernel argument works with this a.e. form. Exact signatures/proofs should use the a.e.-strong terminology and should not accidentally add a global `StronglyMeasurable g` hypothesis. This is not a mathematical gap and does not change the proof verdict.

## Global library-rubric disposition

1. Mathematical intent: clear; all six targets implement the written source-independent infrastructure plan.
2. Reusable seams: clear; T01/T05 name genuine semantics, T03 has a current consumer, and T06 isolates the finite analytic identity.
3. Public API shape: mathematical shape clear; exact Lean signature review remains pending by design.
4. Module/dependency design: clear; no reverse or circular edge found.
5. Mathlib integration: clear at the pinned source; cited declarations and hypotheses match.
6. Proof architecture: clear; semantic insertion, finite linearity, prefix splitting, primitive data, and Abel/Fubini are separated coherently.
7. Cost/durability: no implementation exists, so no elaboration or import-cost claim is made; narrow proposed imports are plausible.
8. Refactor risk: no refactor or edit is authorized; downstream QL/OLV requirements have been traced and must be preserved during signature design.

## Final acceptance statement

`NLP-IMP-001-R2` at SHA-256 `b16460f7286500efce6360ce4f7f0adae4eeedc989dd956e7a253e0804c83d06` receives **APPROVE** from reviewer `imp_r2_referee_d`. The structural/circularity surface receives **APPROVE**. The mathematical theorem-card content is approved to enter exact-signature design, while the formal theorem-card gate remains **REQUEST_CHANGES/not passable** until exact signatures and the other declared governance artifacts exist.

This approval counts as one, not two, independent proof approvals. It does not set `lean_ready`, authorize Lean implementation, register IMP-001, or establish source coverage.

The whole-file SHA-256 of this final report is recorded in the external handoff that binds this artifact. Embedding a whole-file digest in the file itself would be self-referential.
