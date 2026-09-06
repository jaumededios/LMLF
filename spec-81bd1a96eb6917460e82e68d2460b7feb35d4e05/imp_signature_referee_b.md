# IMP-001 exact-signature referee B

## Verdict

**REQUEST_CHANGES** on the frozen exact-signature proposal.

The six displayed declarations elaborate at the pinned toolchain, and their mathematical content agrees with the revision-3 card/proof on ordinary-improper semantics, finite unions, orientations, primitive data, and the finite Abel identity. One material API defect remains: the only representation through which a downstream module can construct or eliminate `HasImproperIntegralAtTopExcept` is private, while the six-declaration public surface supplies no constructor/eliminator or finite-exception composition bridge. The first declared consumer, QL-001, must construct the relation for an arbitrary finite `S` from `IsFiniteExceptionalPrimitive` and T06. With the proposed surface it can do that only by unfolding the public wrapper and duplicating the inaccessible private recursion. That is a representation leak across the advertised `Basic -> Abel -> QL-001` boundary, not a cosmetic preference.

This is a fixable signature/API issue, not a rejection of the R3 mathematics.

## Review identity and exact bindings

- Reviewer ID: `imp_signature_referee_b`
- Reviewer kind: agent
- Runtime: Codex desktop agent, GPT-5-based model; exact deployment model ID was not exposed to the reviewer
- Review stage: pre-Lean exact-signature/theorem-card API review
- Perspectives: source semantics not applicable; proof correctness/semantic reachability; dependency direction; hypothesis-and-choice laundering
- Isolation strength: `manual_attestation`
- Isolation method: exact commit obtained only through `git archive` into `/tmp/imp-referee-b.W79qEM`; a second archive `/tmp/imp-referee-b-baseline.JIWfm4` was used to confirm the candidate had no Lean declarations with the six proposed names. No live-worktree file content was read, no prior referee report was read, and no repository file was edited. Harnesses and generated `.olean` files existed only in `/tmp`.
- Review timestamp: `2026-09-06T03:12:39Z`
- Reviewed specification commit: `81bd1a96eb6917460e82e68d2460b7feb35d4e05`
- Exact signature artifact: `blueprint/theorem_cards/IMP-001-signatures.md`
- Exact signature artifact SHA-256: `454dc16dbe924d895d723aba90c0f280baaa6496a3dbf0e4083d0804775191f8` (verified)
- Artifact-stated design-input commit: `78b9579d05e03ae30436c5632c4e38c32c0da09e`
- IMP-001 card: revision 3, SHA-256 `35cb365a0de0492ddc7d6a62e66734400f92c7b79434afa08d9ea1ab2033dcb2`
- IMP-001 proof: `NLP-IMP-001-R3`, revision 3, SHA-256 `d97bd16bbdffeeaa34c2560111f38c714e91e09458d2fb3381535029ca4d431c`
- QL-001 downstream card: revision 2, SHA-256 `a85af11116ad2900bb4c7a01acfbfc1eb791a1f1f2a3755ccefa1f3e28ec471d`
- QL-001 downstream proof: `NLP-QL-001-R2`, revision 2, SHA-256 `4b70ef576ff90e972ac2ea4e8beac91bca8a208b849f82f87c4afe06a14b5859`
- Classification schema: `review/classifications-v2.json`, `lmlf-classification-v2` revision 2, SHA-256 `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9`
- Toolchain: `leanprover/lean4:v4.33.1`; observed Lean commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`
- Resolved Mathlib commit: `0df444a360eaa60ab8c11dca51a86af692955474`
- `lake-manifest.json` SHA-256: `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`
- Source bindings: none; IMP-001 is source-independent reusable infrastructure and earns no source coverage.
- Accepted LMLF dependency bindings: none.

The complete governing material was read before judgment: the full IMP-001 R3 card and proof, the exact-signature artifact, QL-001 R2 card and proof, the integral/Laplace and dependency blueprints, the repository review protocol and all five repository rubrics, and both Lean referee skills with their complete global/local rubrics, research basis, and LSP playbook.

## Exact target binding audit

| Target | Public declaration | Kind / classifications | Result |
|---|---|---|---|
| IMP-001-T01 | `LMLF.Integral.HasImproperIntegralAtTopExcept` | definition; `reusable_infrastructure`; `non_novel` | Semantics match R3, subject to the public/private defect below. |
| IMP-001-T02 | `LMLF.Integral.HasImproperIntegralAtTopExcept.unique` | existence/uniqueness; `reusable_infrastructure`; `non_novel` | Exact same-`f,k,S` uniqueness statement; mathematically plausible from anchor independence and Hausdorff uniqueness. |
| IMP-001-T03 | `LMLF.Integral.HasImproperIntegralAtTopExcept.finset_clm` | exact identity; `reusable_infrastructure`; `non_novel` | Exact literal `s.biUnion S`; finite sums use `T : A -> E ->L[ℝ] E`; common `k`; no hidden superset or output-space generalization. |
| IMP-001-T04 | `LMLF.Integral.HasImproperIntegralAtTopExcept.split_regular` | exact identity; `reusable_infrastructure`; `non_novel` | Correct `a <= k`, explicit compact integrability, value `intervalIntegral f a k + I`, and correct equivalence orientation. |
| IMP-001-T05 | `LMLF.Integral.IsFiniteExceptionalPrimitive` | definition; `reusable_infrastructure`; `non_novel` | Contains exactly `S` above `k`, continuity on `Ici k`, normalization, and honest regular-piece integrability/increments. No bound, atTop limit, target weight, or convergence conclusion is hidden. |
| IMP-001-T06 | `LMLF.Integral.intervalIntegral_exp_smul_eq_of_integral_eq_sub` | exact identity; `reusable_infrastructure`; `non_novel` | Correct sign and boundary orientation. The signature has finite-piece integrability, continuity, and an all-point increment law; it has no derivative, absolute-continuity, exceptional-set, bound, global `StronglyMeasurable`, or infinity hypothesis. |

Exactly two definitions and four theorem signatures are proposed. No extra public target is present in the archived candidate, because implementation has not begun.

## Independent compile and pinned-source evidence

The exact two private recursive definition bodies, exact T01 and T05 bodies, and exact types of T02-T04/T06 were regenerated in the isolated Mathlib environment. As in the proposal, temporary `axiom` declarations represented only the four absent proof bodies.

- `lake env lean -o .lake/build/lib/lean/LMLF/Integral/Improper/Basic.olean LMLF/Integral/Improper/Basic.lean`: exit 0.
- `lake env lean -o .lake/build/lib/lean/LMLF/Integral/Improper/Abel.olean LMLF/Integral/Improper/Abel.lean`: exit 0.
- `lake env lean CheckIMP.lean`: exit 0 and printed all six expected types. The independent `CheckIMP.lean` SHA-256 was `910ef61988215a9c38bb7339d43ec63574b613d199335292d0d1abee579630ed`, equal to the proposal's recorded check-file digest.
- A dependency-only harness using the two exact Basic imports resolved `intervalIntegral.integral_add_adjacent_intervals`, `ContinuousLinearMap.intervalIntegral_comp_comm`, `tendsto_nhds_unique`, `tendsto_finsetSum`, `intervalIntegral.integral_undef`, `intervalIntegral.continuousOn_primitive_interval'`, and `Finset.sortedLT_sort`: exit 0.
- A dependency-only harness using the exact Abel imports resolved `ContinuousOn.intervalIntegrable_of_Icc`, `MeasureTheory.intervalIntegral_integral_swap`, `intervalIntegral.integral_eq_sub_of_hasDerivAt_of_le`, and `Real.hasDerivAt_exp`: exit 0.

Pinned source inspection confirmed the claimed defining files and exact Fubini premise. `Finset.sort` is pairwise increasing, nodup, preserves membership and cardinality, reduces empty to `[]` and singleton to `[c]`, and has `Finset.sortedLT_sort`; thus the non-strict comparator plus finset nodup gives the needed strict adjacent ordering. The closest Mathlib `IntegrableAtFilter` infrastructure is absolute-integrability based and is not a replacement for the intended conditionally convergent finite-exception relation. No pinned `HasImproperIntegral...Except` or finite-exception primitive analogue was found.

The proposed import graph is downward-only: Basic directly imports only `Mathlib.Data.Finset.Sort` and `Mathlib.MeasureTheory.Integral.DominatedConvergence`; Abel imports Basic plus the three stated Mathlib files. It imports no QL, Olver, Gamma, QB, DEF, Audit, tactic, or umbrella `Mathlib` module.

Compilation proves elaboration and import availability only. It is not evidence that T02-T04/T06 have Lean proof bodies.

## Semantic and adversarial checks

- **Empty set / atTop:** the empty sorted list reduces to honest compact `IntervalIntegrable` evidence for every `[k,b]`, followed by the direct `atTop` limit of `integral k..b`. There is no selected anchor, paired cutoff, or whole-set totalized integral.
- **Singleton / breakpoint:** a compiled zero-integrand witness for `S = {c}` confirmed the head left limit, a separate final-component right limit, and a separate infinity limit. The recursive clauses require compact integrability only inside regular components. Values at isolated exceptional points remain irrelevant, while principal-value-only cancellation is rejected.
- **General finite set:** membership/cardinality/sortedLT invariants at the pin make the recursion enumerate every exception once in increasing order. Strict existential anchors make the one-sided real filters nontrivial. The first, bounded, and last clauses have the endpoint roles claimed by R3.
- **Honest integrability:** T01 explicitly pairs every limit route with compact regular-piece `IntervalIntegrable`; T05 and T06 likewise carry finite-piece integrability. Mathlib's `intervalIntegral.integral_undef` therefore cannot manufacture convergence from a totalized nonintegrable term.
- **Uniqueness:** two witnesses may choose different anchors, but R3's additivity argument transports each one to a common anchor; all left/right/atTop filters are nontrivial in `ℝ`, so `tendsto_nhds_unique` applies componentwise. No choice-selected improper value is introduced.
- **T03:** the exact printed type confirms literal `s.biUnion S`, common `k`, matching mapped integrand/value sums, and real continuous-linear self-maps. `A` requires no exported `Fintype` or `DecidableEq` premise.
- **T04:** exact printed type confirms `integral a..k + I`, not subtraction or reversed endpoints; `a = k` is included.
- **T05:** exact unfolding confirms no `L`, no norm bound, no target weight, no target integral, and no convergence/atTop clause. `F` and `S` are explicit inputs.
- **T06 orientation:** direct integration-by-parts algebra gives `w(b) • F(b) - w(a) • F(a) + h • integral(w • F)` for `w(t)=exp(-h*t)`, exactly as printed.
- **T06 edge behavior:** an isolated positive harness compiled both `a = b` and `h = 0` specializations. At `h = 0`, `simpa` reduces the theorem to the increment law at `b`; no division by `h` occurs.
- **T06 all-point law:** an expected-failure harness supplied only `F b - F a = integral a..b g`; Lean rejected it because the required type is `forall t in Icc a b, F t - F a = integral a..t g`.
- **T06 forbidden hypotheses:** the printed type has no pointwise derivative and no global `StronglyMeasurable`. R3's proposed proof derives only `AEStronglyMeasurable` and `Integrable (Function.uncurry H)` under `(volume.restrict (uIoc a b)).prod (volume.restrict (uIoc a b))`, matching the exact argument expected by the pinned `intervalIntegral_integral_swap`.
- **Circularity/laundering:** T05 records baseline primitive data only; it neither contains a bound nor asserts target-weight convergence. QL adds a flat bound and a distinct target weight `x > X`, so its conclusion is not stored in IMP. T06's increment law is the natural unweighted primitive premise, not the weighted conclusion except at the deliberately included boundary `h = 0`. Sorting does not select an integral value; `F`, `S`, and all proposed values are explicit. No downstream LMLF theorem is used to justify IMP.

## Finding B1 — P2 — downstream construction is trapped behind private representation

**Files/declarations:** `blueprint/theorem_cards/IMP-001-signatures.md`; proposed `LMLF.Integral.HasImproperIntegralAtTopExcept`; downstream `QL-001-T01` proof route.

T01's public definition exposes only the conjunction with an application of private `HasImproperIntegralAtTopBreaks`; that helper recursively calls private `HasImproperIntegralTailFromBreaks`. The proposal then explicitly excludes every public constructor, projection, sorted-list helper, regular insertion lemma, and finite-exception Abel composition theorem.

This is not merely hidden implementation. QL-001 has an arbitrary finite `S`, a T05 certificate for `g(t)=exp(-X*t) • phi(t)`, a flat bound on `F`, and T06 on each regular component. Its stated conclusion includes existence of the target-weight T01 relation. To establish it, QL must assemble the first, interior, final and atTop witnesses. None of T02-T04 constructs such a witness from T05/T06, and no public eliminator exposes the endpoint witnesses.

The failure is concrete in the compiled environment:

- after importing Basic, `#check LMLF.Integral.HasImproperIntegralAtTopBreaks` and `#check LMLF.Integral.HasImproperIntegralTailFromBreaks` both fail with `unknownIdentifier`;
- `#print HasImproperIntegralAtTopExcept` shows the imported private constant only as `HasImproperIntegralAtTopBreaks✝`;
- even the empty zero-integrand witness could not be discharged by `simp [HasImproperIntegralAtTopExcept]`; the successful test had to rewrite `Finset.sort_empty` and restate the entire private base clause with `change`;
- the singleton test likewise had to restate the private terminal clause verbatim.

For symbolic `S`, QL would have to induct on `S.sort`, repeatedly restate private recursive clauses by definitional equality, and thereby couple itself byte-for-byte to the hidden representation. A later harmless change to anchors or component packing would break the first consumer despite no intended public semantic change. This conflicts with the repository rubric requiring a minimal constructor/eliminator API and with the stated purpose of keeping IMP as a reusable layer rather than smuggling its implementation into QL.

**Required remedy:** revise the public signature surface so QL can build and use the arbitrary-finite-`S` relation solely through named public declarations. Acceptable designs include a reviewed public constructor/eliminator layer for T01, or a reviewed public finite-exception Abel/composition theorem with exactly the hypotheses QL has. Merely documenting that QL may unfold the private recursion is not sufficient. Because the proposal freezes both exact target count and every public signature, this remedy requires a new signature-artifact revision and a corresponding card revision, not an implementation-time helper added silently.

## Exact acceptance conditions

1. Supersede the current exact-signature artifact with revised frozen bytes that resolve B1 by providing a named, representation-independent path for QL-001 to construct and consume T01 on arbitrary finite `S` from the T05/T06 data it actually has.
2. Update the IMP-001 theorem card to a new revision that binds the revised signature artifact's exact path and SHA-256, exact public target count, exact binder order, imports, module ownership, card/proof bindings, and downstream QL use. If the target count changes, update the target map and classifications explicitly; do not call added public API “private plumbing.”
3. Add a disposable compile regression for a QL-shaped arbitrary-finite-`S` consumer. It must import the advertised public modules, use only public names, not unfold `HasImproperIntegralAtTopExcept`, not reproduce either private recursion, and reach the finite-exception tail relation from a primitive certificate plus the separate flat hypotheses.
4. Re-run the exact-signature harness at Lean 4.33.1 / Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`, including all six current edge obligations (or their explicitly revised replacements), exact imports, printed types, empty/singleton/atTop behavior, T03 literal union/CLM shape, T04 sign, T05 no-bound/no-convergence shape, and T06 `a=b`, `h=0`, all-point increment, no derivative, and no global `StronglyMeasurable`.
5. Obtain fresh independent exact-signature/theorem-card approvals bound to the new artifact and card digests. The present changes-requested review cannot approve changed bytes.
6. Separately complete registry reconciliation, the required natural-language-proof and structural-circularity gates, external envelope binding, reviewer quorum, and only then the composite `lean_ready` gate. No Lean implementation may begin before that authorization.

## Gate accounting

This report **does count as an independent exact-signature/theorem-card API review record** for commit `81bd1a96eb6917460e82e68d2460b7feb35d4e05` and signature SHA-256 `454dc16dbe924d895d723aba90c0f280baaa6496a3dbf0e4083d0804775191f8`. Because its verdict is `REQUEST_CHANGES`, it **does not count as an approving vote toward exact-signature acceptance or theorem-card approval**. It supplies revision evidence only; any changed signature or card bytes require fresh review.

This report does **not** set, imply, or contribute an independent authority to set `lean_ready`. Compilation of the axiom harness is not proof implementation, theorem-card acceptance, registry reconciliation, implementation authorization, or merge evidence. IMP-001 remains unregistered, planning-only, not implemented, and not `lean_ready`.
