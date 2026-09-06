# Signed correction/addendum 01 — IMP-001 referee A, T02 dependency route

## Disposition

This is a correction to one factual sentence in my finalized report, not a newly discovered candidate defect. The implementation satisfies the frozen direct component-uniqueness architecture for T02. My two existing verdicts remain **approve** with empty findings and do not need successor verdict records.

The incorrect report sentence is the T02 row in `imp_impl_referee_a.md`:

> `unique` reduces through the primitive characterization and uniqueness of the at-top limit; it proves uniqueness of the claimed value rather than assuming it.

That dependency description is false. It should be read as superseded by:

> `unique` projects both T01 witnesses to the same canonical sorted-break representation and proves equality directly by uniqueness of the matching one-sided component limits, anchor-change cancellation, and induction over the finite break list. It does not invoke T08 or T05.

No other statement in the prior report or either verdict JSON is changed by this addendum.

## Bound prior artifacts

This correction binds, without modifying, the following finalized evidence:

- Exact candidate: `b8d2f731fcfd5cd0889d0732f13699eb94681c86`.
- Base/specification: `3a1b16cae6d186a20530de3b883c1bb871ee76f6`.
- Prior report `imp_impl_referee_a.md`: SHA-256 `832b379546bf252507ee9a7b352c52dc63f676ae48abbfeb9ae03b0c847a2566`.
- Quantitative-correctness verdict `IMP-001-quantitative_correctness-imp_impl_referee_a.json`: SHA-256 `182dcff935b82253a3b5d6ee3178da9f43a4097ae6bd9592f90cbb1defbe60f0`.
- Proof-quality verdict `IMP-001-proof_quality-imp_impl_referee_a.json`: SHA-256 `1674552c5fac63cf88d101c766682806ab3211a95253f4b30c2e1f4fdf6ae3b4`.
- Candidate `LMLF/Integral/Improper/Basic.lean`: SHA-256 `c4f77d2616b5e8040f9fc1aa60d5301cf5a8f37decb6bb94b520fa2ea04fe35f`.
- Frozen R7 proof: SHA-256 `941ca0f2a7e402e9dd3636d7c93744290b3f5b52b8705484c18630c6fe173548`.
- Pending implementation envelope: SHA-256 `1c7874b190ada114c60853a880b2ec2a56bbaba3fed261ccf7ad57b30e012ab7`.

## Independent dependency trace

I re-read the exact frozen T02 section in `blueprint/proofs/IMP-001-R7.md:579-593`, the packet T02 entry at `review/work_packets/IMP-001.yaml:204-222`, and candidate `Basic.lean:773-918` from the detached exact-head worktree.

The candidate dependency chain is:

1. Public `HasImproperIntegralAtTopExcept.unique` (`Basic.lean:914-918`) calls only private `HasImproperIntegralAtTopBreaks.unique hI.2 hJ.2`. The common list is definitionally the same canonical `S.sort (· ≤ ·)` from T01.
2. `HasImproperIntegralAtTopBreaks.unique` (`899-911`) inducts on that break list:
   - empty list: `tendsto_nhds_unique hI.2 hJ.2` compares the same direct at-top interval-integral function;
   - nonempty list: `tendsto_nhds_unique hLI hLJ` compares the first left-endpoint component, then `HasImproperIntegralTailFromBreaks.unique` compares the remaining tail, and the component values are rewritten into the two proposed totals.
3. `HasImproperIntegralTailFromBreaks.unique` (`882-897`) also inducts directly:
   - final unbounded component: calls `atTopComponentValue_unique`;
   - bounded component followed by a tail: calls `boundedComponentValue_unique`, applies the induction hypothesis to the tail, and rewrites both equalities into equality of totals.
4. `atTopComponentValue_unique` (`807-821`) orders the two existential anchors with `le_total` and delegates to `atTopComponentValue_eq_of_anchor_le` (`773-805`). That lemma uses honest compact `IntervalIntegrable` evidence, `intervalIntegral.integral_add_adjacent_intervals`, and `tendsto_nhds_unique` on the left one-sided and at-top limits. The fixed compact anchor-change integral is added to one side and subtracted from the other, so the component sums agree.
5. `boundedComponentValue_unique` (`862-880`) similarly orders the anchors and delegates to `boundedComponentValue_eq_of_anchor_le` (`823-860`). It uses the two nontrivial one-sided endpoint filters, compact interval additivity, and `tendsto_nhds_unique`; the same anchor-change term cancels.

The complete T02 support slice `Basic.lean:773-918` contains no reference to `hasImproperIntegralAtTopExcept_iff_exists_primitive`, `forwardInitialPrimitive`, `reverseInitialPrimitive`, or `IsFiniteExceptionalPrimitive`. A compiled public-body print with private names enabled confirms that T02's body is exactly the private `HasImproperIntegralAtTopBreaks.unique` call. Its axiom report remains exactly `[propext, Classical.choice, Quot.sound]`.

This matches the frozen R7 argument: use the same unique increasing enumeration, prove uniqueness of each same-function component limit via `tendsto_nhds_unique` (`IMP-M03`), and conclude equality of the finite total. It also preserves the intended direction that T08 is proved independently and does not use T02.

## Recheck commands

- `lake env lean /tmp/imp-impl-ref-a.a93BMmNq/T02DependencyAudit.lean`: exit 0; printed the public body as the direct private-break uniqueness call and the allowed axiom set.
- `sed -n '773,918p' LMLF/Integral/Improper/Basic.lean | rg 'hasImproperIntegralAtTopExcept_iff_exists_primitive|forwardInitialPrimitive|reverseInitialPrimitive|IsFiniteExceptionalPrimitive'`: expected `rg` exit 1 with no matches.
- Source inspection of `Basic.lean:773-918`: completed; dependency trace above.

## Reviewer attestation

I attest that this correction is my independent conclusion from the exact candidate and frozen artifacts, without inheriting a root disposition. The conflict was a report-summary error caused by conflating the primitive-based routes used elsewhere with T02's separate direct route; it was not a missed implementation constraint. Since the implementation itself follows the required direct argument, neither assigned rubric acquires a finding and both existing approvals stand.

Signed by reviewer `/root/imp_impl_referee_a` using model `gpt-5.6-sol`, Codex desktop child-agent runtime, high reasoning effort, manual-attestation isolation.

Issued at `2026-09-06T18:29:52Z`.
