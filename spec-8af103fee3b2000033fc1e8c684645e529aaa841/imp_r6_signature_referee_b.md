# IMP-001 R6 exact-signature referee B

## Verdict and bounded scope

- `verdict`: **approve**
- `approved_object`: the exact-signature semantic/API/architecture design in `blueprint/theorem_cards/IMP-001-signatures-R6.md` at the bound commit and digest below
- `review_stage`: `pre_lean`, exact-signature substage only
- `review_perspectives`: `source_semantics`, `dependency_direction`, `source_to_target_reachability`, `hypothesis_and_choice_laundering`
- `reviewer_id`: `imp_r6_signature_referee_b`
- `reviewer_kind`: `agent`
- `configured_model`: `gpt-5.6-sol`
- `configured_reasoning_effort`: `xhigh`
- `isolation_strength`: `manual_attestation`
- `manual_attestation`: fresh-context/no-peer isolation; I did not read prior or peer referee reports, did not inspect other agents or process listings, and did not receive their conclusions. This was a manual practice, **not technically enforced**.

This approval is deliberately narrower than approval of an IMP theorem card or
natural-language proof gate. It does **not** approve a final theorem card, work
packet, review envelope, registry or manifest admission, composite
`lean_ready`, production imports, implementation, implementation proofs, merge,
or source coverage. Those objects or gates are absent. A later final card and
packet must bind these exact signature bytes and resolve the import-language
clarification recorded below before any implementation authorization.

## Exact bindings

- Candidate/specification commit reviewed:
  `8af103fee3b2000033fc1e8c684645e529aaa841` (detached, clean worktree).
- Parent/design-input commit:
  `50dcded3b36e33632cf1e9734cac34c10a890d8a`.
- Proposal:
  `blueprint/theorem_cards/IMP-001-signatures-R6.md`, 971 lines,
  SHA-256 `4b2b6f73a8a92c6b48e88e6ca7b3c1d252ed877f4df33257306c10cbab679ab0`.
- Protocol:
  `review/PROTOCOL.md`,
  SHA-256 `7453bc0ca6985d7ca2e8c525d9655a94e412c48e3850b92d9367a9f643d3177d`.
- Applicable pre-Lean rubric:
  `review/rubrics/api_dependency.md`,
  SHA-256 `4e5f947ed15f0101c46fe9bb0a12a013d66c7de3c7ed2c35fda817de8d92eb41`.
- Library-scale rubric used in full:
  `/home/codex/.codex/skills/referee-lean-library/references/global-rubric.md`,
  SHA-256 `990a183dc9e86a3d9580cfb2d5834d36d18afb8a06ad32a114d12b4d0716bb81`.
- Toolchain: `leanprover/lean4:v4.33.1`; raw runtime reported
  `Lean (version 4.33.1, x86_64-unknown-linux-gnu, commit 819816b2e0a3bf405af45ae5c7af2491d8f5bee6, Release)`.
- Mathlib pin: `0df444a360eaa60ab8c11dca51a86af692955474`.
- `lake-manifest.json` SHA-256:
  `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`.

The six relevant input artifacts retained the following exact bytes:

| Input artifact | Revision | SHA-256 |
|---|---:|---|
| `blueprint/proofs/IMP-001.md` | 6 | `88f60d501c4261cba37b5d1f320406c258bde785ed3912720b3be897d6424f0e` |
| `blueprint/theorem_cards/IMP-001.yaml` | 6 | `97e7af6b5d1919b45fef90dfea5cb86b1f041d26c447c51852271ad04fdd75a0` |
| `blueprint/proofs/QL-001.md` | 4 | `0e10900131fce62f2ed0256d4c0844ff6fb8b7a570fa25cf4ac4a05c33ea7116` |
| `blueprint/theorem_cards/QL-001.yaml` | 4 | `176dd5661eca3ef6c348a1557cf121e46921131c279a7f64846f78a8eef399e0` |
| `blueprint/proofs/OLV-001.md` | 4 | `40e31aab68f1f065598ea3b7ea5a46616bb84f2ab44b1ca49632be523ed9ff0f` |
| `blueprint/theorem_cards/OLV-001.yaml` | 4 | `442004db665f0f4eb20f7bac5708a50dc377566356841c2be2f0389d75a4bf1b` |

I read the complete proposal, complete IMP card and proof, and complete QL and
OLV cards and proofs independently. Repository inventory confirmed that this
commit contains no proposed production IMP modules: the reviewed artifact is a
design proposal, not an implementation.

## Concrete severity findings

No actionable `G#` finding was found.

- `P0`: none.
- `P1`: none.
- `P2`: none.
- `P3`: none.

The approval rests on the following adversarial checks of the exact design.

### T01 ordinary endpoint semantics

The exact `S.sort (\x y => x ≤ y)` recursion has the required meaning.

- With `S = ∅`, the start clause separately requires
  `IntervalIntegrable f volume k b` for every `b ≥ k` and the one-sided
  `atTop` limit of `∫ t in k..b, f t`. Thus the start is locally L1 in the
  intended Bochner sense; a merely conditionally improper non-L1 singularity
  at `k` cannot enter through a totalized integral value.
- With a first exception `c`, the start clause requires honest integrability
  of every `[k,b]` with `b < c` and a left-of-`c` limit. Every recursive bounded
  component chooses an interior `p`, requires honest integrability strictly
  between its two adjacent exceptions, and records two independent limits:
  `a ↓ c` from the right and `b ↑ d` from the left.
- The final component separately records its right-of-last-exception limit and
  its `atTop` limit. No filter or cutoff couples the two sides of an exception,
  so the clauses do not encode a Cauchy principal value.
- The sorted Finset contains no duplicate points, and the displayed strict
  anchor inequalities therefore implement ordinary independent endpoint
  semantics rather than order-dependent choice. The recursive definitions are
  private. A downstream attempt to unfold only the public definition stopped
  at the private generated constant, which is consistent with the intended
  public abstraction boundary.

The absence of compiled analytic examples for a principal-value-only
singularity is an untested mathematical regression, recorded below; it is not
being replaced by the two type-shape negative checks.

### T05/T08 primitive semantics and choice

T05 exposes exactly the finite-exception primitive information needed by the
consumer: all exceptions are above `k`, `ContinuousOn F (Ici k)`, `F k = 0`,
and honest interval integrability plus the increment identity on every closed
regular interval. It contains no limit, flat bound, target weight, target
integral, or estimate.

T08 has the essential existential orientation

`HasImproperIntegralAtTopExcept f k S I ↔ ∃ F, T05 f k S F ∧ Tendsto F atTop (nhds I)`.

It does not assert the equivalence for a preselected `F`, define a chosen
primitive, or define a selected improper-integral value. The forward consumer
may destruct the existential and derive a bound from that witness's continuity
and finite limit; it cannot launder a caller-selected `F` or a bound through
T08.

### T03/T04/T07 exact transport

- T03 accepts complete input/value space `E` and independently complete output
  space `H`, maps `E →L[ℝ] H`, and concludes on the literal `s.biUnion S` at
  the exactly mapped finite sum. It therefore supports `E ≠ H` and does not
  choose an exceptional-set enlargement.
- T04 has explicit `a ≤ k`, the same literal `S`, the above-`k` proof, and
  honest `IntervalIntegrable f volume a k`; its left value is exactly
  `(∫ t in a..k, f t) + I`. This is the sign and order required both to remove
  and later prepend the local interval.
- T07 cannot be invoked from the totalized set-integral expression alone. Its
  explicit `IntegrableOn f (Ioi k)` premise makes the value honest while
  retaining any arbitrary finite regular marking set `S` above `k`.

### T06 exact Abel composition

T06 quantifies an arbitrary real `h`. Its only weighted tail assumptions are
exactly
`IntegrableOn (fun t => exp (-h*t) • F t) (Ioi k)` and
`Tendsto (fun R => exp (-h*R) • F R) atTop (nhds 0)`. With T05 as the
unweighted primitive premise, it returns the same literal `S` and the exact
value
`h • ∫ t in Ioi k, exp (-h*t) • F t`.

No positivity, bound, differentiability, global integrability of `g`, or
downstream Watson hypothesis has been hidden in the public signature. The type
therefore covers every real `h` satisfying the explicit side conditions; QL's
actual `h > 0` route derives those conditions separately.

### Public source-to-target reachability

The checked consumer establishes the intended one-model chain from public
interfaces:

1. baseline source T01 plus raw model `IntegrableOn`;
2. T07 for the honest model value;
3. T03 subtraction on the literal union;
4. honest T04 removal of `[0,k]`;
5. forward T08 extraction of an existential T05 witness and finite limit;
6. a separately proved real theorem deriving `L ≥ 0` and the flat bound from
   continuity plus convergence;
7. derivation, for `h > 0`, of both T06 weighted hypotheses using direct pinned
   Mathlib results;
8. T06 on the unchanged `S`, followed by T04 prepend; and
9. target-model T07 plus T03 recombination.

The generic T03 consumer independently checks arbitrary finite families and
the `E → H` result shape. The one-model theorem is an API reachability result,
not a proof of any IMP theorem and not an implementation of QL or OLV.

### Public surface and dependency architecture

All eight targets have real recorded consumers: T01 and T05 are the two
semantic predicates; T08 is the representation-independent bridge; T02 is
needed for OLV's one-function reconciliation; T03 handles model subtraction
and recombination; T04 handles the local/tail split; T07 handles absolutely
integrable model moments; and T06 handles the weight change. I found no
redundant public constructor, projection, sorted-recursion helper, anchor API,
chosen value, finite-piece Abel lemma, or compatibility alias.

The module direction is acyclic:

`Mathlib → IMP Basic → {IMP Bochner, IMP Abel} → QL → OLV`.

`Abel` and `Bochner` independently import `Basic`; neither imports the other or
any QL, OLV, Watson, Gamma, source, audit, QB, DEF, or LMLF umbrella module.
The public consumer contains no private recursion name, `S.sort`, or downstream
LMLF import.

The consumer's three additional pinned Mathlib imports are legitimate direct
support dependencies, and were listed separately:

- `Mathlib.Analysis.SpecialFunctions.ImproperIntegrals`;
- `Mathlib.Analysis.SpecificLimits.Normed`;
- `Mathlib.Order.Filter.AtTopBot.Field`.

Here “public IMP only” means no private or downstream **LMLF** helper; it does
not prohibit a consumer from importing pinned Mathlib facts directly. This
interpretation is part of this bounded approval, but the current R6 card does
not bind the new signature artifact. The later final card/work packet must
explicitly bind the proposal digest and this import-boundary meaning. Until it
does, no final-card gate or `lean_ready` gate has passed.

## Independent runtime evidence

I created a new disposable root with `mktemp` at
`/tmp/lmlf-imp-r6-sig-ref-b-harness.PYNOoEkZ` and reconstructed all five
authoritative fenced files myself via `apply_patch`. I did not use the author's
disposable harness. Rehashing after reconstruction and again after compilation
gave exact parity:

| Reconstructed file | Lines | SHA-256 |
|---|---:|---|
| `LMLF/Integral/Improper/Basic.lean` | 106 | `9a88b646c652126230941c3bc5a033b47a6e514a25a5a37df43439d6a3745c8c` |
| `LMLF/Integral/Improper/Bochner.lean` | 20 | `33fd45c29a3ea0ec32638c01f7d098a633280c54f34d5b4843721e42020e4cd3` |
| `LMLF/Integral/Improper/Abel.lean` | 28 | `c96c1f97e0e123fea038dc3748b0164a6f911e8af863d9cde49c278b9457ab53` |
| `Check.lean` | 11 | `b1aa6e50c08a33509a9e60fa9d2ce583fbb4a88126428cd7dc56c214929b1e5d` |
| `Regressions.lean` | 304 | `b016c4b894597605029a99350ca41d33f3e692c1c38782622848c08ce2d53dc4` |

I obtained the cached absolute `LEAN_PATH` from
`lake env printenv LEAN_PATH` in
`/workspace/Documents/Codex/2026-09-05/yo`, prepended only my harness root,
and invoked
`/home/codex/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean` directly
with `-R` set to that root.

- `Basic.lean`: exit 0, emitted its `.olean`.
- `Bochner.lean`: exit 0, emitted its `.olean`.
- `Abel.lean`: exit 0, emitted its `.olean`.
- `Check.lean`: exit 0 and printed all eight fully elaborated public names.
- `Regressions.lean`: exit 0. Output contained only unused-variable,
  unused-section-variable, and unnecessary-`simpa` style warnings.

The eight-name output confirmed all complete-space hypotheses, T03's distinct
`E`/`H` and literal union, T04's exact value orientation, T06's arbitrary-real
parameter and exact weighted value, T07's explicit `IntegrableOn`, and T08's
existential primitive.

The two embedded `fail_if_success` checks ran in the 304-line file. I also ran
equivalent standalone failing forms to inspect the actual diagnostics:

- Omitting T07's `IntegrableOn` argument left a function
  `IntegrableOn f (Ioi k) → HasImproperIntegralAtTopExcept ...` where `True`
  was expected; Lean exited 1 with a type mismatch.
- Ascribing T08 to a fixed-`F` right side produced a type mismatch between the
  actual existential and the preselected witness; Lean exited 1.

These are **type-shape checks only**. I do not count either as a mathematical
nonintegrability or nonexistence counterexample.

An independent `#print axioms` audit showed:

- T01 and T05 have actual definition bodies and only the standard imported
  `propext`, `Classical.choice`, and `Quot.sound` trust dependencies.
- Each of T02, T03, T04, T06, T07, and T08 self-reports its intentionally
  declared temporary harness axiom in addition to standard dependencies.
- `flat_bound_of_continuousOn_Ici_of_tendsto` has a real proof body and only
  standard dependencies.
- `source_shaped_public_chain_one_model` has a real proof body but depends on
  the five temporary theorem axioms it actually calls: T03, T04, T06, T07,
  and T08. It does not prove those targets.

No GitHub CI or remote workflow was triggered. The candidate and main
repository were not edited.

## Global rubric disposition

1. **Mathematical intent:** clear for the exact design. T01/T05/T08 encode the
   stated ordinary-improper and primitive semantics; the remaining public laws
   reach the QL/OLV route without moving a target conclusion into a hypothesis.
2. **Reusable seams:** clear. Each public bridge has a concrete existing
   consumer; the lower-level sorted and Abel plumbing has no justified public
   client and remains private.
3. **Public API/theorem shape:** clear. Binder order, namespaces, codomains,
   exact values, quantifiers, and conclusion orientation match the R6/R4
   consumer contracts.
4. **Modules/dependencies:** clear. The three-module split is coherent and has
   no reverse or umbrella dependency.
5. **Mathlib integration:** clear at signature and consumer reachability level.
   Direct Mathlib support is reused rather than wrapped in speculative LMLF
   helpers.
6. **Proof architecture:** clear as a design. T08 owns component stitching and
   T06 owns weighted composition; downstream consumers do not unfold T01.
7. **Cost/durability:** no performance finding is supportable before theorem
   bodies exist. The proposed signatures elaborate with narrow, explicit
   ownership, and the consumer imports are separately accountable.
8. **Refactor risk:** clear for this stage. There is no existing production API
   or migration surface; any change to these proposed bytes requires fresh
   review and later explicit card/packet binding.

## Untested limits and withheld gates

- The six target theorem declarations are temporary axioms. No target proof,
  proof-body import sufficiency/minimality, axiom release audit, or production
  implementation was tested or approved.
- The compiled consumer establishes type/API reachability conditional on those
  axioms. It is not QL-001 or OLV-001 implementation and does not verify their
  quantitative constants or source adapter.
- The harness does not prove the planned mathematical negative/edge examples:
  a principal-value-only pole, a genuinely conditional finite singularity,
  the conditional `sin t / t` tail, a non-L1 initial singularity, T01/T08
  endpoint-value invariance, the nondifferentiable primitive example, `h = 0`,
  or the full production regressions R01--R25. These remain implementation
  obligations; the type-shape failures were not substituted for them.
- No PDF was available after restart. This source-independent review did not
  renew Olver source fidelity, page coverage, transcription reconciliation, or
  the conditional OLV source adapter.
- The R6 theorem card still says the signature artifact is absent. No final
  card/work packet binds this proposal; registry reconciliation, manifest
  admission, external envelope/quorum, and composite `lean_ready` remain
  absent.
- No production IMP module exists at the reviewed commit. Module proof costs,
  transitive import fanout after implementation, implementation theorem
  generality, and compatibility blast radius therefore remain unmeasured.

Subject to those explicit boundaries, I approve the exact eight-signature
semantic/API/architecture proposal at the bound commit and digest.
