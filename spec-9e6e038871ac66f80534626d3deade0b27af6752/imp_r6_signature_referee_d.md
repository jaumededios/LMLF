# IMP-001 R6 exact-signature proposal revision 2 — independent referee report

## Verdict and scope

`verdict: approve`

I approve the exact-signature proposal revision 2 at the exact candidate commit
and artifact digest below, solely as a pre-Lean exact-signature/API design input.
I found no P0–P3 mathematical-intent, public-API, dependency-direction,
hypothesis/choice-laundering, or repaired-regression defect in this bounded
scope.

This is not approval of a final theorem card, work packet, registry row,
manifest entry, review quorum, `lean_ready`, implementation, merge, source
coverage, or production Lean. The final card must bind the exact proposal
digest and must explicitly bind the import interpretation recorded here:
consumer-side pinned Mathlib scalar support imports are allowed separately,
while private LMLF helpers and downstream QL/OLV/source modules are forbidden.
That clarification is explicit in the reviewed proposal and was not silently
inferred.

## Review identity and isolation

| Field | Value |
|---|---|
| Durable reviewer ID | `imp_r6_signature_referee_d` |
| Reviewer kind | `agent` |
| Configured model / effort | `gpt-5.6-sol` / `xhigh` |
| Review stage | `pre_lean` exact-signature/API repair review |
| Perspectives covered | `dependency_direction`, `source_to_target_reachability`, `hypothesis_and_choice_laundering` |
| Runtime | Codex desktop agent; Linux `x86_64`; `/bin/bash`; raw Lean executable listed below |
| Isolation strength | `manual_attestation` |
| Isolation method | Fresh agent context; clean detached candidate worktree; fresh disposable harness and mutant roots under `/tmp`; no old or peer referee/administrative report content read; no candidate or main-repository edit |
| Hardening | Not technically enforced and not a hardened clean-room runner |
| Subagents | None |
| Remote actions | None; no GitHub CI, network write, commit, or push |

The candidate was a clean detached worktree throughout. The main checkout was
also clean at the same commit at the final status check.

## Exact bindings and input hashes

| Artifact | Exact identity |
|---|---|
| Candidate commit | `9e6e038871ac66f80534626d3deade0b27af6752` |
| Reviewed proposal | `blueprint/theorem_cards/IMP-001-signatures-R6.md`, SHA-256 `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d` |
| Superseded repair base | commit `8af103fee3b2000033fc1e8c684645e529aaa841`; proposal SHA-256 `4b2b6f73a8a92c6b48e88e6ca7b3c1d252ed877f4df33257306c10cbab679ab0` |
| IMP card R6 | `blueprint/theorem_cards/IMP-001.yaml`, SHA-256 `97e7af6b5d1919b45fef90dfea5cb86b1f041d26c447c51852271ad04fdd75a0` |
| IMP proof R6 | `blueprint/proofs/IMP-001.md`, SHA-256 `88f60d501c4261cba37b5d1f320406c258bde785ed3912720b3be897d6424f0e` |
| QL card R4 | `blueprint/theorem_cards/QL-001.yaml`, SHA-256 `176dd5661eca3ef6c348a1557cf121e46921131c279a7f64846f78a8eef399e0` |
| QL proof R4 | `blueprint/proofs/QL-001.md`, SHA-256 `0e10900131fce62f2ed0256d4c0844ff6fb8b7a570fa25cf4ac4a05c33ea7116` |
| OLV card R4 | `blueprint/theorem_cards/OLV-001.yaml`, SHA-256 `442004db665f0f4eb20f7bac5708a50dc377566356841c2be2f0389d75a4bf1b` |
| OLV proof R4 | `blueprint/proofs/OLV-001.md`, SHA-256 `40e31aab68f1f065598ea3b7ea5a46616bb84f2ab44b1ca49632be523ed9ff0f` |
| Classification authority | `review/classifications-v3.json`, SHA-256 `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e` |
| Lean toolchain file | `lean-toolchain`, SHA-256 `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| Lake manifest | `lake-manifest.json`, SHA-256 `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404` |
| Review protocol | `review/PROTOCOL.md`, SHA-256 `7453bc0ca6985d7ca2e8c525d9655a94e412c48e3850b92d9367a9f643d3177d` |
| API/dependency rubric | `review/rubrics/api_dependency.md`, SHA-256 `4e5f947ed15f0101c46fe9bb0a12a013d66c7de3c7ed2c35fda817de8d92eb41` |
| Library global rubric | `references/global-rubric.md`, SHA-256 `990a183dc9e86a3d9580cfb2d5834d36d18afb8a06ad32a114d12b4d0716bb81` |

An exact `git diff --exit-code` from parent `8af103f…` to the candidate passed
for the IMP/QL/OLV cards and proofs, `lean-toolchain`, and
`lake-manifest.json`. Thus all reviewed card/proof/pin bytes are unchanged by
the repair commit. I also independently checked that the four authoritative
module/`Check.lean` blocks and the 286-line positive-regression prefix are
byte-identical to the parent. The positive-prefix SHA-256 is
`a26a56afe6a9985fdb9aa7fbfd128ab2887a3f88c76b639c638d40a12dba0215`.

## Independent mathematical and API audit

### Private T01 representation fidelity

The private sorted-list representation faithfully implements the card's
ordinary-improper semantics.

- For `S = ∅`, it separately requires `IntervalIntegrable f volume k b` for
  every `k ≤ b` and the `atTop` limit of `∫ k..b`; a totalized finite integral
  cannot supply the missing local L1 propositions.
- For nonempty `S`, the first component requires honest integrability from
  `k` and its own left limit at the first exception. Every bounded later
  component has a right-of-previous-exception limit and a distinct
  left-of-next-exception limit around an interior anchor. The final component
  has an independent right-of-last-exception limit and a separate `atTop`
  limit. The recursively accumulated value is the exact finite component sum.
- No two endpoint passages share a coupled cutoff, so a principal-value-only
  cancellation does not satisfy T01. The start-point clauses require local L1
  on every truncation and therefore do not admit a merely conditional non-L1
  singularity at `k`.
- `S.sort (· ≤ ·)` is canonical for the finite real set. The two recursive
  encodings are declared `private`; no constructor, eliminator, anchor,
  insertion lemma, sorted list, or value function is added to the public API.

### Exact eight public types

| Target | Independent conclusion |
|---|---|
| T01 | Exact `E, f, k, S, I` relation; visible `S ⊂ Ioi k`; honest regular-piece integrability and independent one-sided endpoints in its private definition |
| T02 | Uniqueness for two explicit values of the same `f,k,S`; no selected value function |
| T03 | Finite family in `E`, heterogeneous real CLMs `E →L[ℝ] H`, conclusion in `H`, and the literal `s.biUnion S` with the exactly mapped value |
| T04 | Explicit `a ≤ k`, `S` above `k`, honest `IntervalIntegrable f volume a k`, and the exact left value `(∫ a..k, f) + I` (`J + I`) |
| T05 | Only `S` above `k`, `ContinuousOn F (Ici k)`, `F k = 0`, and every regular-piece integrability/increment law; no limit and no bound |
| T06 | Arbitrary real `h`, arbitrary literal `S`, explicit weighted `IntegrableOn` and boundary-zero hypotheses, and the exact value `h • ∫ t in Ioi k, exp (-h*t) • F t`; no positivity, flat bound, or quantitative conclusion |
| T07 | Arbitrary finite `S` plus an actual `IntegrableOn f (Ioi k)` premise, concluding the relation at the honest Ioi set-integral value |
| T08 | An equivalence to `∃ F`, with exactly T05 and `Tendsto F atTop (nhds I)`; not a fixed-`F` theorem and no norm bound |

I found no target-sized circular hypothesis. T03 consumes only the natural
relations for its summands; T04 is the public split equivalence; T06 consumes
the independently meaningful weighted-primitive integrability and boundary
conditions; T07 consumes absolute integrability; and T08 is derived directly
from component semantics in the proof plan. There is no public
`Classical.choose`, chosen improper value, chosen exceptional enlargement, or
bound/target-value laundering.

The module direction is coherent:

`Mathlib → IMP Basic → {IMP Bochner, IMP Abel} → QL → OLV`.

`Abel` does not import `Bochner`; no IMP module imports QL, OLV, Watson,
Gamma, QB, DEF, an audit module, or an LMLF umbrella. The consumer imports only
the three public IMP modules plus the three separately declared pinned Mathlib
support modules for exponential integrability/limits/rescaling. Source search
found no occurrence of a private recursive name or `S.sort` in the consumer.

The QL R4 and OLV R4 routes genuinely use this surface: T07 establishes honest
model relations, T03 performs finite subtraction/recombination on the literal
union, T04 removes/prepends the local interval, T08 extracts an existential
primitive, topology outside IMP derives its flat bound, and T06 changes the
weight. This has the intended upstream direction and does not force a consumer
to unfold T01 or copy component recursion.

## Fresh reconstruction and runtime evidence

I reconstructed the authoritative sources with `apply_patch` in the fresh root
`/tmp/imp-r6-sig-ref-d.tf1RT3`; no author harness root was reused.

| Authoritative file | Lines | SHA-256 | Fresh result |
|---|---:|---|---|
| `LMLF/Integral/Improper/Basic.lean` | 106 | `9a88b646c652126230941c3bc5a033b47a6e514a25a5a37df43439d6a3745c8c` | exit 0 |
| `LMLF/Integral/Improper/Bochner.lean` | 20 | `33fd45c29a3ea0ec32638c01f7d098a633280c54f34d5b4843721e42020e4cd3` | exit 0 |
| `LMLF/Integral/Improper/Abel.lean` | 28 | `c96c1f97e0e123fea038dc3748b0164a6f911e8af863d9cde49c278b9457ab53` | exit 0 |
| `Check.lean` | 11 | `b1aa6e50c08a33509a9e60fa9d2ce583fbb4a88126428cd7dc56c214929b1e5d` | exit 0; all eight names and types printed |
| `Regressions.lean` | 307 | `93dff3d5c34874efad1894160a8beb7980b7431b2a473822051c19e38ba43f17` | exit 0 |

Runtime binding was independently checked:

- raw Lean:
  `/home/codex/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean`;
- reported runtime: Lean `4.33.1`, commit
  `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`, Release;
- resolved Mathlib checkout:
  `0df444a360eaa60ab8c11dca51a86af692955474`;
- `LEAN_PATH`: fresh root prepended to the cached absolute output of
  `lake env printenv LEAN_PATH` from the clean main checkout.

The executed order was the proposal's exact order, using raw Lean and `-R`:

```text
lean -o Basic.olean Basic.lean       -> 0
lean -o Bochner.olean Bochner.lean   -> 0
lean -o Abel.olean Abel.lean         -> 0
lean Check.lean                      -> 0
lean Regressions.lean                -> 0
```

`Regressions.lean` emitted only style linter warnings: an unused explicit
`hL`, two automatically included unused section instances, two unnecessary
`simpa` notices, and unused binders inside the negative examples. There was no
elaboration error. The three modules contain exactly six temporary target
axioms and two actual definitions: T01 and T05. Every consumer declaration in
`Regressions.lean` is a theorem with a proof body, but its reachability is
conditional on those six target axioms.

## Repaired negative-guard sensitivity

The parent guards were vacuous because their inner `exact` ran while the goal
was `True`. Revision 2 gives each inner `have` the prohibited target type. I
reconstructed both isolated mutants from the embedded sources and patches.

| Case | Exact hashes | Valid guard | Mutant module(s) | Same guard under mutant |
|---|---|---:|---:|---:|
| T07 without `IntegrableOn` | mutant Bochner `1dffc49ac37aa44a95847ff39fde9b4adf48071a505c67d2d238d4a75b643903`; guard `55421431513e1ba1f0e71a1ae5822eb77b5c6e8d82d9e640d3df100f6adbc758`; unchanged Basic `9a88…` | 0 | Basic 0; Bochner 0 | exactly 1 |
| T08 fixed `F` | mutant Basic `2d12d556ee52c0a5924b409b60a2b794f1ca46fee19e4b26b1cdc4b85cf1b5fa`; guard `24187270c6cb444de8387d6de50b2c7ba0bbcc474ef04ae4a67a2e5fab021983` | 0 | Basic 0 | exactly 1 |

The T07 mutant diagnostic was at `Guard.lean:13:2`, and the T08 diagnostic was
at `Guard.lean:12:2`. Each was exactly:

```text
The tactic provided to `fail_if_success` succeeded but was expected to fail:
```

In each case the displayed typed `have hbad` was the code whose unexpected
success triggered the diagnostic. Thus the valid controls reject the bad type,
the isolated prohibited signature makes that exact type elaborate, and the
failure is not an unrelated import, parse, or positive-consumer failure. The
repair is sensitive to the intended T07/T08 signature defects.

## Findings and rubric disposition

No actionable `G#` finding was produced under any section of the library-scale
rubric:

1. Mathematical intent: clear; T01/T05 and all eight types match the IMP R6
   card/proof semantics.
2. Reusable seams: clear; T03, T04, T06, T07, and T08 have concrete QL/OLV
   consumers; no extra public plumbing is justified.
3. Public API: clear; exact eight-target surface, correct quantifiers and
   orientations, with implementation details private.
4. Module/dependency design: clear; no reverse/downstream LMLF edge.
5. Mathlib integration: clear for signature elaboration and the separately
   declared consumer support imports at the exact pin.
6. Proof architecture: clear at proposal level; T08 owns stitching, T06 owns
   Abel composition, and consumer proofs stay at the public boundary.
7. Cost/durability: no performance claim is made before proof bodies exist;
   the proposed split localizes dependencies.
8. Refactor risk: clear; no compatibility alias or superseded six-target API is
   retained, and any byte change requires fresh review.

The final-card binding of the scalar-Mathlib-import clarification is a required
later gate, not an open defect in these proposal bytes.

## Limitations and withheld authorization

- Six target declarations are axioms in the disposable harness. This review
  establishes exact type elaboration and real consumer reachability, not a
  proof of T02–T04 or T06–T08.
- No mathematical counterexample theorem, target proof, production module,
  axiom-release audit, or proof-body import-minimality result is established.
- No PDF was available or reviewed. Source fidelity, transcription coverage,
  and the conditional OLV source adapter are outside scope.
- I did not review or authorize a final card, work packet, registry/manifest
  mutation, `lean_ready`, implementation, CI, merge, or release.

Within this deliberately narrow boundary, the exact-signature/API proposal and
its revision-2 negative-test repair are approved.
