# IMP-001 independent architecture and proof review

## Review identity and isolation

- Candidate specification commit: `586e8c6609aaf2446c9996f4dd61f514d8428450` (`docs: specify finite-exceptional improper integration`, parent `0c74ee38689de6c6941603a14ef5af09ef1294d0`).
- The candidate was read only from a disposable `git archive` extracted at `/tmp/imp-architecture-586e8c66.LE0Sps`. I did not inspect the dirty live repository worktree and did not inspect any other referee report.
- Theorem card: `blueprint/theorem_cards/IMP-001.yaml`, SHA-256 `537051e1e23a446636d5dbf8e2d8113792818b0b5b8c7736db88f23c6de0cbfa` (matches the requested binding).
- Natural-language proof: `blueprint/proofs/IMP-001.md`, SHA-256 `c714c16c2e462bdf3bb09bc8ff91258d3061cc4084f1f4c555c19cda9789439d` (matches the requested binding).
- Pinned Mathlib: `0df444a360eaa60ab8c11dca51a86af692955474`, Lean `v4.33.1`; the local Mathlib dependency repository was itself at that exact commit.
- I read the complete protocol, v2 classification artifact, theorem-card README, proof schema, integral/Laplace method plan, dependency graph, IMP card/proof, and the QL-001, OLV-001, and OLV-002 cards/proofs. I also inspected the relevant pinned Mathlib source and ran disposable `#check`/minimal-import checks outside the repository.
- `scripts/validate_inventory.py` passed on the archive. The library inventory found 7 Lean files, 210 Lean lines, 3 definitions, 18 theorems, and no trust/resource markers.

## Verdicts

| Gate | Verdict | Reason |
|---|---|---|
| Theorem card, revision 1 | **REQUEST_CHANGES** | The mathematical boundary is coherent, but the card deliberately omits the exact Lean signatures, binder order, representation, and import contract which the governing theorem-card gate requires. See G1 and G3. |
| Complete natural-language proof, revision 1 | **REQUEST_CHANGES** | The Abel argument and the five other target arguments are mathematically credible, but the regular-point insertion step needed by T03 does not actually derive the new one-sided endpoint limits or cite the required continuity-of-indefinite-integral fact. See G2. |
| Structural-circularity gate | **APPROVE** | The dependency direction is one-way, the packet is genuinely source-independent, the primitive certificate is at a baseline integrand and does not contain the requested weighted tail result, and no improper value or primitive is choice-selected. |
| Overall | **REQUEST_CHANGES** | No P0 defect and no reason to block the design. The bounded changes below are required before a frozen card/proof can receive approval or `lean_ready`. |

## Findings

### G1 — P1 — The card has no reviewable exact public interface

Files/locations: `blueprint/theorem_cards/IMP-001.yaml:46-83, 273-303`; `blueprint/proofs/IMP-001.md:86-92, 786-799`.

The card identifies six prospective names, but every signature is `prospective_only`; `exact_signatures_artifact` is pending, representation of sorted exceptional points and endpoint filters is deferred, and exact imports/binder order are expressly not frozen. This status is truthful, but under `review/PROTOCOL.md` a theorem-card referee must check the exact proposed Lean signatures. Consequently the current artifact cannot pass the theorem-card gate.

This is not a complaint about the six-target mathematical scope. The issue is that important API choices remain undecidable from names alone: whether `S` is a `Finset ℝ` or a set with finiteness evidence; whether `S ⊆ Set.Ioi k` is an explicit premise or a predicate field; the exact independent one-sided filters; the quantification of component witnesses; the index/union encoding in `finset_clm`; and whether implementation helpers are reducible parts of the public relation.

Acceptance condition: produce an exact signature artifact bound to a new/current IMP card revision. It must give all binders in order, universes/typeclasses, `Finset`/set and ordered-component representation, all endpoint filters, exact union expression, result orientation for T04 and T06, declarations' namespaces/visibility, and the imports of each of `LMLF.Integral.Improper.Basic` and `.Abel`. Compile those signatures in a disposable pinned environment, including `S = ∅`, an inserted regular point, an empty indexing finset for T03, and T04 with `a = k`. Bind the resulting artifact ID and digest before freezing. Re-review the exact bytes.

### G2 — P1 — Regular-point insertion does not prove the individual new endpoint limits

File/location: `blueprint/proofs/IMP-001.md:240-248`, consumed again at `:265-266` and in T03.

IMP-I02 says that splitting truncations at a regular point with `intervalIntegral.integral_add_adjacent_intervals` “gives two endpoint limits whose sum is the old component limit.” Additivity identifies sums of finite integrals; by itself it does not establish the two newly required one-sided limits at the inserted point. Those limits follow because an interval-integrable function has a continuous indefinite interval integral on a containing compact interval, but this fact is neither proved nor entered in the dependency/side-condition ledger.

This is essential rather than cosmetic. T03 first refines every `S_i` to the literal finite union by repeated regular-point insertion. Without the individual endpoint-limit construction, the central refinement premise `HasImp(f_i,k,S_A,I_i)` is not established, so the finite-union/CLM target has an incomplete proof.

Pinned Mathlib contains a suitable exact route: `intervalIntegral.continuousOn_primitive_interval'` (and the lower-level `intervalIntegral.continuousWithinAt_primitive`) in `Mathlib.MeasureTheory.Integral.DominatedConvergence`. A disposable pinned `#check` confirmed their signatures. Other equivalent pinned routes are acceptable.

Acceptance condition: revise IMP-I02 into a complete argument which, for each insertion, constructs both one-sided limits at the regular point from compact `IntervalIntegrable` evidence, preserves the outer endpoint limits, and proves the component sums agree. Cover first, bounded-interior, and final-unbounded components, as well as insertion into the empty-exception case. Add the exact pinned dependency (or prove an internal endpoint-continuity lemma), add the missing side-condition row, and then explicitly iterate over `S_A \ S_i` to close T03. Re-review the new proof digest.

### G3 — P2 — The pinned names are real, but the import/dependency closure is incomplete

Files/locations: `blueprint/theorem_cards/IMP-001.yaml:240-260`; `blueprint/proofs/IMP-001.md:250-266, 568-587, 786-795`.

All eight named candidates exist at the pinned commit, with the stated namespaces, and their listed defining source files are substantially correct:

- `intervalIntegral.integral_add_adjacent_intervals`, `ContinuousLinearMap.intervalIntegral_comp_comm`, `ContinuousOn.intervalIntegrable_of_Icc`, and `intervalIntegral.integral_undef` are in `Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic`;
- `tendsto_nhds_unique` is in `Mathlib.Topology.Separation.Hausdorff`;
- `tendsto_finsetSum` is in `Mathlib.Topology.Algebra.Monoid`;
- `MeasureTheory.intervalIntegral_integral_swap` is in `Mathlib.MeasureTheory.Integral.Prod` and requires product integrability in the exact restricted-measure form shown by its signature;
- `intervalIntegral.integral_eq_sub_of_hasDerivAt_of_le` is in `Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus`.

Two dependencies are nevertheless missing from the claimed complete ledger. First, G2 needs the dominated-convergence primitive-continuity API in `Basic`. Second, the FTC theorem M07 does not supply the derivative of the exponential. A disposable file importing only `FundThmCalculus` and `Prod` failed with `Unknown constant Real.hasDerivAt_exp`; adding `Mathlib.Analysis.SpecialFunctions.ExpDeriv` made the exact declaration available. Thus the final Abel proof needs `Real.hasDerivAt_exp` plus that import (or a separately checked alternative theorem/import).

The Fubini choice is mathematically compatible with the proof: the indicator kernel can be extended by zero in the inner variable, making `MeasureTheory.intervalIntegral_integral_swap` applicable. The exact obligation is not merely “a finite rectangle,” however; it is `Integrable (Function.uncurry f) ((volume.restrict (Set.uIoc a b)).prod μ)`. The signature/prototype must expose a proof of precisely that obligation.

Acceptance condition: update the exact dependency ledger and module import contract with the endpoint-continuity and exponential-derivative facts actually used; compile pinned proof fragments demonstrating the exponential FTC identity for arbitrary `h` (including `h = 0`) and the exact product-integrability hypothesis passed to the chosen swap theorem. Do not freeze a broad umbrella import in place of this audit.

## Architecture conclusions and explicit do-not-refactor decisions

### Six-target minimality: accepted

The six targets form a defensible minimal public slice for the stated Watson consumer:

- T01 is the core relational semantics.
- T02 is the necessary uniqueness/eliminator theorem for a relation-valued integral API, even though QL-001 does not presently call it directly.
- T03 deliberately combines private refinement with the only needed finite CLM law. Keeping regular-point insertion private is reasonable while there is one consumer.
- T04 is exactly the prepend/split bridge QL-001 needs to combine an honest local integral with the exceptional tail.
- T05 is the baseline primitive certificate consumed by QL-001.
- T06 is the one analytic Abel identity.

Do not split T03 into a public proliferation of zero/add/neg/smul/refinement lemmas now. Implement its regular-point refinement as a named private helper; promote it only after another real consumer appears. Do not add a project-local Riemann integral, an improper-value function, a bounded-tail field, a Gamma theorem, or a Watson theorem to IMP-001.

### Basic/Abel split and dependency direction: accepted

Putting T01-T05 in `LMLF.Integral.Improper.Basic` and T06 in `LMLF.Integral.Improper.Abel` is coherent. `Basic` must remain independent of `Abel`, QL, OLV, QB, DEF, Gamma, and Audit. T06's statement is mathematically independent of T01-T05, so `.Abel` need not import `.Basic` unless an actual implementation helper requires it; if it does import it, the only permissible project edge is `Basic -> Abel`. The downstream graph `IMP -> QL -> OLV -> Audit/SourceRecovery` is acyclic and matches both the dependency graph and the QL/OLV dossiers.

### Source independence, classifications, and status truth: accepted

IMP-001 binds no occurrence, entity, notation, or snapshot; every target is `reusable_infrastructure`; the packet claims no coverage. `mixed / infrastructure / non_novel` is representable under classification v2 and is appropriate for a packet mixing definition, uniqueness, and exact-identity target shapes while claiming only classical infrastructure. No source collation gate is needed.

The lifecycle metadata is accurate: draft specification, author-complete but draft proof, no review, no prototype, no implementation, planning-only, absent authorization. IMP-001 is correctly absent from `blueprint/inventory/cards.csv`; the method and dependency documents consistently call it unregistered. The inventory validator passes. Registration and an execution manifest remain prerequisites to implementation, not evidence against the mathematical design.

### Structural circularity and laundering: accepted

There is no reverse dependency on QL/OLV. T05 takes an explicit `F`; it does not choose one. Its increment law is at the baseline integrand and contains neither boundedness, convergence at the target weight, nor the QL error bound. Continuity at exceptional points is genuine gluing data. T06 converts the increment law by a finite Fubini identity; QL later supplies boundedness and the passage to infinity. T03 takes the literal finite union, not a chosen enlargement. The proposed integral value remains an explicit relation argument and uniqueness is proved separately. These facts satisfy dependency-direction, source-to-target-reachability, and hypothesis/choice-laundering perspectives.

### Public API usability and performance risk

Subject to G2 and exact signatures, the union-of-exception sets plus regular-piece clauses are sufficient for the current public consumer. They let QL place a singular amplitude and smooth finite model terms on their literal union, retain independent endpoint convergence, and prepend the locally Bochner-integrable segment. The clauses do not accidentally demand norm-integrability across exceptional points and correctly reject principal-value-only cancellation.

Lean representability is plausible at the pinned version: all interval-integral, finite-sum continuity, CLM commutation, Hausdorff uniqueness, Fubini, and FTC primitives exist. The main implementation risk is proof engineering around sorting/refining a `Finset ℝ`, not mathematical expressibility. Keep ordered-component/anchor machinery private and opaque enough that simplification does not repeatedly unfold sorting. No performance defect can responsibly be asserted before the exact representation exists; profile the T03 union proof and T01 unfolding in the disposable signature prototype rather than changing the six-target boundary preemptively.

## Consolidated acceptance checklist

1. Resolve G1 with a compiled, digest-bound exact signature/import artifact for all six targets and update the card binding/status truthfully.
2. Resolve G2 with a complete individual-endpoint-limit proof for regular-point insertion, an exact pinned dependency or internal lemma, and a closed T03 refinement proof.
3. Resolve G3 by recording and checking the actual primitive-continuity, exponential-derivative, Fubini product-integrability, and FTC imports/declarations.
4. Run the specified edge cases against the exact signatures, especially `S = ∅`, regular-point insertion, empty T03 index, `a = k`, `a = b`, `h = 0`, and the principal-value negative case.
5. Freeze a new/current card and proof revision, record exact SHA-256 bindings externally, reconcile IMP-001 with the registry/manifest, and obtain fresh required independent card/proof approvals. The structural-circularity perspective reviewed here needs no mathematical redesign.

No IMP Lean implementation should be written before those acceptance conditions and the protocol's external `lean_ready` authorization are satisfied.
