# Independent exact-signature review: IMP-001 R6 proposal revision 2

## Controlled verdict

`approve`

This approval is limited to the semantic fidelity, public API shape, dependency
architecture, compiled consumer reachability, and repaired negative-guard
sensitivity of the exact artifact reviewed below. It is not an approval of a
final theorem card, work packet, registry entry, execution manifest,
`lean_ready`, production implementation, proof bodies, source coverage, or
merge.

No material `P0`, `P1`, `P2`, or `P3` finding remains in this bounded review.

## Review identity and isolation

- Reviewer ID: `imp_r6_signature_referee_c`
- Reviewer kind: `agent`
- Configured model: `gpt-5.6-sol`
- Configured reasoning effort: `xhigh`
- Review stage: `pre_lean` exact-signature design
- Perspectives: exact-signature semantics and public API;
  `dependency_direction`; `source_to_target_reachability` limited to the
  QL/OLV consumer route; `hypothesis_and_choice_laundering`
- Isolation strength: `manual_attestation`
- Isolation method: fresh-context/no-peer isolation (not enforced)
- Attestation: I reviewed the specified detached checkout in a fresh context.
  I did not open or read any earlier/peer referee or administrative report,
  did not inspect other agents or process listings, and treated every author
  assertion as untrusted. References to external reports embedded in the
  proposal were encountered only as proposal text and were not consulted.
- Subagents: none
- Review date: `2026-09-06` UTC

## Exact snapshot and bound inputs

- Detached review worktree:
  `/tmp/lmlf-imp-r6-sig-ref-c.N1uNlvfY`
- Candidate commit:
  `9e6e038871ac66f80534626d3deade0b27af6752`
- Worktree state before review: clean, detached `HEAD`
- Reviewed artifact:
  `blueprint/theorem_cards/IMP-001-signatures-R6.md`
- Reviewed artifact SHA-256:
  `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d`
- Parent proposal commit:
  `8af103fee3b2000033fc1e8c684645e529aaa841`
- Parent proposal SHA-256:
  `4b2b6f73a8a92c6b48e88e6ca7b3c1d252ed877f4df33257306c10cbab679ab0`
- Design-input commit recorded by the artifact:
  `50dcded3b36e33632cf1e9734cac34c10a890d8a`

The input hashes were independently recomputed and match the proposal:

| Input | SHA-256 |
|---|---|
| `blueprint/proofs/IMP-001.md` | `88f60d501c4261cba37b5d1f320406c258bde785ed3912720b3be897d6424f0e` |
| `blueprint/theorem_cards/IMP-001.yaml` | `97e7af6b5d1919b45fef90dfea5cb86b1f041d26c447c51852271ad04fdd75a0` |
| `blueprint/proofs/QL-001.md` | `0e10900131fce62f2ed0256d4c0844ff6fb8b7a570fa25cf4ac4a05c33ea7116` |
| `blueprint/theorem_cards/QL-001.yaml` | `176dd5661eca3ef6c348a1557cf121e46921131c279a7f64846f78a8eef399e0` |
| `blueprint/proofs/OLV-001.md` | `40e31aab68f1f065598ea3b7ea5a46616bb84f2ab44b1ca49632be523ed9ff0f` |
| `blueprint/theorem_cards/OLV-001.yaml` | `442004db665f0f4eb20f7bac5708a50dc377566356841c2be2f0389d75a4bf1b` |
| `lake-manifest.json` | `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404` |
| `review/classifications-v3.json` | `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e` |

Review authorities read completely:

| Review input | SHA-256 |
|---|---|
| `review/PROTOCOL.md` | `7453bc0ca6985d7ca2e8c525d9655a94e412c48e3850b92d9367a9f643d3177d` |
| `review/rubrics/api_dependency.md` | `4e5f947ed15f0101c46fe9bb0a12a013d66c7de3c7ed2c35fda817de8d92eb41` |
| `referee-lean-library/SKILL.md` | `d4ce5aa5f1c7ebcf18da6f408c2fc2da98fe2dd906fa9c32b6b613b381aa0e9d` |
| library global rubric | `990a183dc9e86a3d9580cfb2d5834d36d18afb8a06ad32a114d12b4d0716bb81` |

I read the complete 1,159-line proposal, complete IMP-001 R6 card and
1,302-line natural-language proof, and the complete QL-001 R4 and OLV-001 R4
cards and proofs relevant to the consumer route. No PDF was available or used.

## Runtime and reconstruction

- Lean executable:
  `/home/codex/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean`
- Actual version output: `Lean (version 4.33.1, x86_64-unknown-linux-gnu,
  commit 819816b2e0a3bf405af45ae5c7af2491d8f5bee6, Release)`
- Mathlib checkout actually resolved by the main environment:
  `0df444a360eaa60ab8c11dca51a86af692955474`
- Main environment used only to obtain the pinned dependency path:
  `/workspace/Documents/Codex/2026-09-05/yo`, itself clean at the exact
  reviewed commit; it was not edited.
- Fresh independently created harness root:
  `/tmp/imp-r6-signature-ref-c.gdn8hO`
- Construction method: all five valid source files, both guard-only sources,
  and both isolated mutant source trees were created with `apply_patch`. No
  author/referee harness was copied or reused.
- `LEAN_PATH`: the fresh valid or mutant root was prepended, as applicable, to
  the absolute value returned by `lake env printenv LEAN_PATH` in the main
  pinned checkout:

```text
/workspace/Documents/Codex/2026-09-05/yo/.lake/packages/Cli/.lake/build/lib/lean:/workspace/Documents/Codex/2026-09-05/yo/.lake/packages/batteries/.lake/build/lib/lean:/workspace/Documents/Codex/2026-09-05/yo/.lake/packages/Qq/.lake/build/lib/lean:/workspace/Documents/Codex/2026-09-05/yo/.lake/packages/aesop/.lake/build/lib/lean:/workspace/Documents/Codex/2026-09-05/yo/.lake/packages/proofwidgets/.lake/build/lib/lean:/workspace/Documents/Codex/2026-09-05/yo/.lake/packages/importGraph/.lake/build/lib/lean:/workspace/Documents/Codex/2026-09-05/yo/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/workspace/Documents/Codex/2026-09-05/yo/.lake/packages/plausible/.lake/build/lib/lean:/workspace/Documents/Codex/2026-09-05/yo/.lake/packages/mathlib/.lake/build/lib/lean:/workspace/Documents/Codex/2026-09-05/yo/.lake/build/lib/lean:/home/codex/.elan/toolchains/leanprover--lean4---v4.33.1/lib/lean
```

The reconstructed valid sources exactly match the authoritative hashes and
line counts:

| File | Lines | SHA-256 | Status |
|---|---:|---|---|
| `LMLF/Integral/Improper/Basic.lean` | 106 | `9a88b646c652126230941c3bc5a033b47a6e514a25a5a37df43439d6a3745c8c` | exit 0 |
| `LMLF/Integral/Improper/Bochner.lean` | 20 | `33fd45c29a3ea0ec32638c01f7d098a633280c54f34d5b4843721e42020e4cd3` | exit 0 |
| `LMLF/Integral/Improper/Abel.lean` | 28 | `c96c1f97e0e123fea038dc3748b0164a6f911e8af863d9cde49c278b9457ab53` | exit 0 |
| `Check.lean` | 11 | `b1aa6e50c08a33509a9e60fa9d2ce583fbb4a88126428cd7dc56c214929b1e5d` | exit 0 |
| `Regressions.lean` | 307 | `93dff3d5c34874efad1894160a8beb7980b7431b2a473822051c19e38ba43f17` | exit 0; style-only warnings |

The valid run compiled `Basic`, `Bochner`, and `Abel` in dependency order with
explicit output `.olean` paths, then elaborated `Check.lean` and the complete
307-line `Regressions.lean`. `Check.lean` printed all eight declaration types.
Because the run used `set -e`, each of those five invocations independently
returned exit 0. The regression warnings were unused-variable/section-variable
and unnecessary-`simpa` style warnings only; there was no elaboration error.

## Revision-2 delta and negative-guard sensitivity

I compared parent `8af103f...` directly to the reviewed commit.

- The authoritative `Basic.lean`, `Bochner.lean`, `Abel.lean`, and `Check.lean`
  fenced blocks have identical hashes at parent and head; the four hashes are
  exactly those in the valid-source table above.
- The positive `Regressions.lean` prefix, from its imports through the complete
  `source_shaped_public_chain_one_model` proof and stopping before
  `section NegativeTypeShapeChecks`, is byte-identical at parent and head. Its
  independently streamed SHA-256 is
  `a26a56afe6a9985fdb9aa7fbfd128ab2887a3f88c76b639c638d40a12dba0215`
  at both commits.
- Within the authoritative harness sources, the only changes are the two
  negative guards. The surrounding proposal updates their evidence and
  accurately discloses the revision-1 defect. No public import, signature,
  definition body, temporary axiom type, or positive consumer proof changed.

The revision-1 guards were indeed vacuous. They attempted `exact` with a
relation/equivalence term while the enclosing example's goal was `True`.
Consequently the guarded tactic failed from a goal-type mismatch even if the
prohibited public type shape was substituted. Revision 2 instead creates a
typed local declaration:

```lean
have hbad : intended-type := prohibited-application
```

This tests whether the prohibited term inhabits its intended relation or
equivalence, rather than whether it proves the unrelated outer `True` goal.

The two complete guard-only valid controls were separately elaborated with the
valid harness root first in `LEAN_PATH`; each returned exit 0. Then I applied
exactly one advertised mutation in each isolated root and rehashed it:

| Isolated case | Source SHA-256 | Signature build | Guard SHA-256 | Guard result |
|---|---|---:|---|---|
| T07 without `IntegrableOn` | valid `Basic` `9a88b...`; mutant `Bochner` `1dffc49ac37aa44a95847ff39fde9b4adf48071a505c67d2d238d4a75b643903` | both exit 0 | `55421431513e1ba1f0e71a1ae5822eb77b5c6e8d82d9e640d3df100f6adbc758` | exactly exit 1 |
| T08 fixed supplied `F` instead of `∃ F` | mutant `Basic` `2d12d556ee52c0a5924b409b60a2b794f1ca46fee19e4b26b1cdc4b85cf1b5fa` | exit 0 | `24187270c6cb444de8387d6de50b2c7ba0bbcc474ef04ae4a67a2e5fab021983` | exactly exit 1 |

No positive consumer was compiled against either mutant. Both failures came
only after their mutant signature modules compiled successfully. The exact
diagnostics were:

```text
mutants/t07/Guard.lean:13:2: error: The tactic provided to `fail_if_success` succeeded but was expected to fail:
  have hbad : HasImproperIntegralAtTopExcept f k S (∫ t in Ioi k, f t) :=
      HasImproperIntegralAtTopExcept.of_integrableOn_Ioi f k S hS

mutants/t08/Guard.lean:12:2: error: The tactic provided to `fail_if_success` succeeded but was expected to fail:
  have hbad :
      HasImproperIntegralAtTopExcept f k S I ↔ IsFiniteExceptionalPrimitive f k S F ∧ Tendsto F atTop (nhds I) :=
      hasImproperIntegralAtTopExcept_iff_exists_primitive
```

Thus neither missing imports, unrelated consumer errors, nor an arbitrary
nonzero exit can account for sensitivity. In each mutant, the intended typed
`have` becomes elaborable, causing `fail_if_success` itself to emit its expected
failure diagnostic.

These are negative type-shape tests only. They are not analytic counterexamples
to a totalized nonintegrable integral and do not prove nonexistence of a fixed
primitive.

## Exact signature and semantic review

The public surface has exactly eight targets and the proposed ownership is
coherent:

| Module | Targets | Result |
|---|---|---|
| `LMLF.Integral.Improper.Basic` | T01, T05, T08, T02, T03, T04 | approve |
| `LMLF.Integral.Improper.Bochner` | T07 | approve |
| `LMLF.Integral.Improper.Abel` | T06 | approve |

T01 and T05 are actual definitions in the harness. T02, T03, T04, T06, T07,
and T08 are explicitly temporary axioms used only to validate exact types and
consumer elaboration.

### T01 private semantics

The private sorted recursion is faithful to the reviewed ordinary-improper
contract.

- `S.sort (· ≤ ·)` is canonical increasing order; the finite set is duplicate
  free and the pinned `Finset.sortedLT_sort` infrastructure confirms strict
  increasing behavior for the default order.
- Public T01 separately requires every marked point to be strictly above `k`.
- With no breaks, it requires `IntervalIntegrable f volume k b` for every
  `k ≤ b` and the independent `atTop` limit of `∫ k..b`.
- With breaks, the first component uses a left limit at the first exception.
  Each bounded later component has its own right-of-previous and
  left-of-next endpoint limits, and the last component has its own
  right-of-last and `atTop` limits. No cutoff is coupled across an exception.
- Every regular compact truncation has honest `IntervalIntegrable` evidence.
  In particular, the first-component evidence includes `k`, enforcing the
  intended local Bochner `L1` behavior at the initial point while leaving the
  value at the singleton `k` irrelevant.
- Component values are added in the reviewed orientation. Interior anchors are
  private existential witnesses and no sorted list, anchor, recursion,
  constructor, or value-selection API is public.

### T05 and T08

T05 records exactly the exceptional-set condition, `ContinuousOn F (Ici k)`,
`F k = 0`, and honest integrability plus the increment identity on every
ordered closed interval disjoint from `S`. It includes no bound, atTop limit,
target weight, or derivative assumption.

T08 is exactly an equivalence between T01 and existence of some T05 witness
converging to `I`. Its `∃ F` is literal, `F` is not a supplied arbitrary
parameter, and neither T05 nor T08 contains a norm bound. This matches the
reviewed component-to-continuous-primitive telescope in both directions.

### T02 through T04

- T02 compares explicit values for the same `f`, `k`, and literal `S`; it does
  not create a choice-selected integral function.
- T03 accepts a finite family in a complete input/value space `E`, continuous
  real-linear maps `E →L[ℝ] H`, and an independently complete output space
  `H`. Its result uses the literal `s.biUnion S` and the correspondingly mapped
  integrand and value. The generic regression and the proved one-model
  subtraction/recombination consumers elaborate without unfolding T01.
- T04 assumes `a ≤ k`, the same literal `S`, its strict-above-`k` condition,
  and honest local `IntervalIntegrable`. Its equivalence has exactly
  `(∫ a..k, f) + I` on the `a` side, so the reviewed `J + I` split/prepend sign
  and order are preserved.

### T07 and T06

T07 retains arbitrary finite `S` and an explicit
`IntegrableOn f (Ioi k)` premise before relating `f` to its honest Ioi set
integral. The valid negative guard and the isolated mutant prove that this
premise is present in the public type and is not replaceable by the totalized
integral expression alone.

T06 accepts explicit `g`, `k`, literal `S`, explicit T05 witness `F`, and every
real `h`. It adds exactly the two reviewed weighted premises:

1. `IntegrableOn (fun t => exp (-h*t) • F t) (Ioi k)`; and
2. `Tendsto (fun R => exp (-h*R) • F R) atTop (nhds 0)`.

Its conclusion stays on the same literal `S` and has exact value
`h • ∫ t in Ioi k, exp (-h*t) • F t`. It assumes neither `h > 0` nor a bound on
`F`; downstream QL supplies positive `h` and derives the two premises from a
separate flat bound. The private finite-piece Abel identity remains outside the
public target list.

## Consumer reachability and dependency architecture

The complete compiled positive consumer demonstrates the required public path,
conditional on the six temporary target axioms:

```text
baseline source relation
  -> T07 honest model relation
  -> T03 model subtraction on the literal union
  -> T04 local split
  -> T08 existential primitive extraction
  -> continuity + finite limit gives a separately derived flat bound
  -> derived weighted L1 and boundary-vanishing premises
  -> T06 Abel composition
  -> T04 prepend
  -> T07 + T03 model recombination
```

The one-model source-shaped chain is a real elaborated consumer term, and the
separate generic T03 regression checks arbitrary finite-family and `E → H`
shape. The consumer never names the private recursive definitions, uses
`S.sort`, imports QL/OLV/Watson, or imports a private/downstream LMLF helper.

Direct pinned Mathlib imports in the consumer are separately visible:

- `Mathlib.Analysis.SpecialFunctions.ImproperIntegrals`
- `Mathlib.Analysis.SpecificLimits.Normed`
- `Mathlib.Order.Filter.AtTopBot.Field`

Those imports support the downstream exponential majorant and limit arguments;
they do not reverse an LMLF dependency edge. I approve the artifact's clarified
architectural reading: “public IMP only” excludes private or downstream LMLF
helpers, not direct pinned Mathlib support. The eventual final card/work packet
must bind that clarification explicitly; no such final artifact is approved
here.

The module imports are acyclic and downward only:

```text
Mathlib -> IMP Basic -> {IMP Bochner, IMP Abel} -> QL -> OLV
```

`Abel` and `Bochner` both depend only on `Basic` and their stated Mathlib
support, not on each other. No proposed IMP module imports QL, OLV, Watson,
Gamma, source, audit, QB, DEF, or an LMLF umbrella. The repository contains no
production declaration with either proposed public predicate name.

## Library-rubric disposition

| Rubric area | Disposition |
|---|---|
| Mathematical intent | Clear. The two definitions and six theorem types match the complete IMP R6 card/proof and preserve the one-sided ordinary-improper semantics. |
| Reusable seams | Clear. T08 isolates semantic conversion, T07 honest Bochner conversion, T03 finite mapped union, T04 local splitting, and T06 Abel composition; each has a concrete QL/OLV use. |
| Public API/theorem shape | Clear. Binder order, literal sets, existential primitive, exact value orientation, and explicit analytic premises match the reviewed consumers without added fields or public representation plumbing. |
| Module/dependency design | Clear. The three-module split is acyclic and places generic semantics in `Basic`, the honest Bochner adapter in `Bochner`, and weighted composition in `Abel`. |
| Mathlib integration | Clear for signature elaboration and the demonstrated consumers. Direct pinned Mathlib support is explicit. Future proof-body sufficiency/minimality is untested. |
| Proof architecture | Clear as a proposal. T08 owns component stitching; T06 consumes T05 and uses private finite-piece mathematics; consumers do not unfold the relation. |
| Cost/durability | No performance claim is supported or needed at this stage. Private representation localizes likely proof changes, while public consumers depend only on eight names. |
| Refactor risk | Clear. Parent comparison proves the repair did not change public types or positive consumer proofs. No historical compatibility API is retained. |

Explicit do-not-refactor decisions accepted for this design: do not expose the
sorted recursion or anchors; do not specialize T03 back to `E → E`; do not add
a bound to T05/T08; do not weaken T07 to a totalized value; do not merge Abel
with Bochner merely for convenience; and do not expose the private finite-piece
Abel identity as a ninth public target.

## Findings

No actionable severity finding was identified.

- `P0`: none
- `P1`: none
- `P2`: none
- `P3`: none

The requirement that a later final card bind the direct-Mathlib-import
clarification is a deliberately disclosed future gate, not a defect in this
exact design artifact and not an authorization supplied by this verdict.

## Untested limits and withheld approvals

- Six targets are temporary axioms. Successful elaboration proves only exact
  type consistency and conditional consumer reachability; it proves none of
  the six analytic theorems and supplies no acceptable public axiom report.
- No production proof body exists, so proof-body import sufficiency/minimality,
  kernel trust, elaboration cost, theorem proof quality, and Mathlib-version
  durability remain untested.
- The positive consumer terms are conditional on those temporary axioms. They
  are not QL-001 or OLV-001 implementations and do not establish the final
  Watson estimate or source theorem.
- The two repaired negative guards are type-shape tests, not concrete analytic
  counterexamples. No principal-value, conditional-singularity, initial-point
  non-L1, or divergent-integral theorem was run in this review.
- No PDF was available. Source collation, PDF fidelity, source coverage, and
  the conditional Riemann-to-Bochner OLV adapter were not reviewed or
  reapproved.
- No final R6 theorem card binds this proposal digest. No IMP-001 work packet,
  registry reconciliation, execution-manifest admission, external
  `lean_ready`, implementation authorization, or production Lean file exists.
- No GitHub CI, remote write, commit, push, production edit, new mathematics,
  or test expansion was performed.
- Manual fresh-context/no-peer isolation was attested, not technically
  enforced.

Accordingly, the controlled verdict remains `approve` only for exact-signature
semantic/API/architecture design and the revision-2 negative-guard repair at
commit `9e6e038871ac66f80534626d3deade0b27af6752`, artifact SHA-256
`0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d`.
