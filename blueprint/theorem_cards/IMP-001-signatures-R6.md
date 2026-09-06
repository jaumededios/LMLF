# IMP-001 R6 exact Lean signature proposal

## Status and authority

| Field | Value |
|---|---|
| Work item | `IMP-001` |
| Artifact role | candidate exact-signature design after the revision-6 natural-language-proof and architecture quorum |
| Proposal revision | revision 2; supersedes only the negative-regression evidence in revision 1 at repository commit `8af103fee3b2000033fc1e8c684645e529aaa841`, artifact SHA-256 `4b2b6f73a8a92c6b48e88e6ca7b3c1d252ed877f4df33257306c10cbab679ab0` |
| Design input | exact repository head `50dcded3b36e33632cf1e9734cac34c10a890d8a` |
| Registry status | unregistered |
| Manifest status | planning only |
| Signature status | compiled candidate for independent exact-byte review |
| Theorem-card status | revision 6 remains unchanged and does not yet bind this artifact |
| Lean implementation | not started; no candidate production Lean file exists |
| `lean_ready` | pending; absent |
| Source coverage | none; reusable infrastructure only |

This artifact is an implementation-design input, not an implementation or an
approval record. It changes none of the reviewed revision-6 proof or card
bytes. It does not freeze `IMP-001`, authorize production Lean, register the
work item, admit it to a manifest, or satisfy `lean_ready`. Any accepted packet
must later bind the exact digest of this artifact externally, in accordance
with `review/PROTOCOL.md`.

Six theorem targets are represented by temporary `axiom` declarations only in
the disposable compilation harness described below; T01 and T05 are actual
definitions. The axioms establish elaboration and consumer type reachability
only. They are not proposed
production code, are not kernel proofs of any target, and must be replaced by
reviewed theorem bodies after a separate implementation authorization. No
`sorry`-filled pseudo-implementation was created.

## Exact reviewed inputs and quorum boundary

The following repository bytes were rehashed at the design input:

| Input | SHA-256 |
|---|---|
| `blueprint/proofs/IMP-001.md` | `88f60d501c4261cba37b5d1f320406c258bde785ed3912720b3be897d6424f0e` |
| `blueprint/theorem_cards/IMP-001.yaml` | `97e7af6b5d1919b45fef90dfea5cb86b1f041d26c447c51852271ad04fdd75a0` |
| `blueprint/proofs/QL-001.md` | `0e10900131fce62f2ed0256d4c0844ff6fb8b7a570fa25cf4ac4a05c33ea7116` |
| `blueprint/theorem_cards/QL-001.yaml` | `176dd5661eca3ef6c348a1557cf121e46921131c279a7f64846f78a8eef399e0` |
| `blueprint/proofs/OLV-001.md` | `40e31aab68f1f065598ea3b7ea5a46616bb84f2ab44b1ca49632be523ed9ff0f` |
| `blueprint/theorem_cards/OLV-001.yaml` | `442004db665f0f4eb20f7bac5708a50dc377566356841c2be2f0389d75a4bf1b` |

Signature design was cleared by two fresh exact-commit reports, read in full
and locally rehashed before this artifact was written:

| External report | Local path | SHA-256 | Relevant disposition |
|---|---|---|---|
| `watson_r6_referee_d` | `/workspace/Documents/Codex/2026-09-05/LMLF-review-evidence/spec-50dcded3b36e33632cf1e9734cac34c10a890d8a/watson_r6_referee_d.md` | `5d6b35c5c7c8b592044c2c8e934a9736494c63fcfff57e45049279d34ce4f505` | approves IMP R6, QL R4, conditional OLV R4 natural-language proofs and the structural/circularity architecture; clears exact-signature design only |
| `watson_r6_referee_e` | `/workspace/Documents/Codex/2026-09-05/LMLF-review-evidence/spec-50dcded3b36e33632cf1e9734cac34c10a890d8a/watson_r6_referee_e.md` | `ba29a71da49f14a7196fea7547b87b27ced7de832e8469928f3ef74132aaa39c` | independently gives the same bounded proof/architecture clearance and explicitly withholds final-card, `lean_ready`, and implementation approval |

The reports were subsequently published in the private review-evidence store
at reported commit `0d6813aba75cff17d983cb77ae39d1466361aeaf`; the
local evidence directory available to this design run is not itself a Git
checkout, so that publication commit was not independently verified here. The
report paths and bytes above were independently verified. The publication note
does not broaden the reports' stated scope.

The toolchain and dependency bindings are:

- Lean `4.33.1`, toolchain `leanprover/lean4:v4.33.1`;
- Mathlib commit `0df444a360eaa60ab8c11dca51a86af692955474`;
- `lake-manifest.json` SHA-256
  `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`.

The historical `blueprint/theorem_cards/IMP-001-signatures.md` was read only as
superseded implementation-design context. Its six-target, same-codomain T03,
public finite-piece T06 surface is not reused as authority for R6.

## Public architecture and import boundary

The exact public target count is eight. Ownership is fixed as follows:

| Module | Public targets |
|---|---|
| `LMLF.Integral.Improper.Basic` | T01, T05, T08, T02, T03, T04 |
| `LMLF.Integral.Improper.Bochner` | T07 |
| `LMLF.Integral.Improper.Abel` | T06 |

The proposed production import surfaces used by the disposable signature
harness are:

```lean
-- LMLF/Integral/Improper/Basic.lean
import Mathlib.Data.Finset.Sort
import Mathlib.MeasureTheory.Integral.DominatedConvergence
```

```lean
-- LMLF/Integral/Improper/Bochner.lean
import LMLF.Integral.Improper.Basic
import Mathlib.MeasureTheory.Integral.IntegralEqImproper
```

```lean
-- LMLF/Integral/Improper/Abel.lean
import LMLF.Integral.Improper.Basic
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
import Mathlib.MeasureTheory.Integral.Prod
import Mathlib.MeasureTheory.Integral.IntegralEqImproper
```

These imports elaborate all exact signatures. They match the reviewed proof
ledger, but their sufficiency for future production proof bodies is not claimed
until those bodies exist. `Abel` does not import `Bochner`; neither bridge needs
the other. No IMP module imports QL, OLV, Watson, Gamma, source, audit, QB, DEF,
or an LMLF umbrella.

The public-use regression imports the three public IMP modules and, separately,
these direct pinned Mathlib support modules:

```lean
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Order.Filter.AtTopBot.Field
```

Those direct Mathlib imports support the scalar exponential majorant, norm
limit, and positive-rescaling arguments in the consumer. They are not private
LMLF helpers and must not be added to production IMP merely to make them
transitively available. Accordingly, any reading of existing “public-IMP-only
consumer” prose as forbidding all direct Mathlib imports is ambiguous and must
be resolved explicitly in final-card review. The verified architectural reading
is: no private LMLF helper and no QL/OLV import, while direct pinned Mathlib
support remains legitimate and separately listed.

The dependency direction remains

```text
Mathlib -> IMP Basic -> {IMP Bochner, IMP Abel} -> QL -> OLV
```

## Exact private representation used to compile T01

The representation below is private and is not part of the consumer API. It
recurses over the canonical increasing list `S.sort (· ≤ ·)`. Each finite
exception has independent one-sided limits, the final component has a separate
atTop limit, and every regular truncated interval carries explicit
`IntervalIntegrable` evidence. The existential anchors are private witnesses;
no public constructor, recursion theorem, eliminator, insertion lemma, sorted
list, or improper-value function is exposed.

```lean
open Filter MeasureTheory Set
open scoped Interval

noncomputable section

namespace LMLF.Integral

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

private def HasImproperIntegralTailFromBreaks
    [CompleteSpace E] (f : ℝ → E) (c : ℝ) : List ℝ → E → Prop
  | [], I =>
      ∃ d : ℝ, ∃ L R : E, c < d ∧
        (∀ {a b : ℝ}, c < a → a ≤ b →
          IntervalIntegrable f volume a b) ∧
        Tendsto (fun a => ∫ t in a..d, f t)
          (nhdsWithin c (Ioi c)) (nhds L) ∧
        Tendsto (fun b => ∫ t in d..b, f t) atTop (nhds R) ∧
        I = L + R
  | d :: ds, I =>
      ∃ p : ℝ, ∃ L R J : E, c < p ∧ p < d ∧
        (∀ {a b : ℝ}, c < a → a ≤ b → b < d →
          IntervalIntegrable f volume a b) ∧
        Tendsto (fun a => ∫ t in a..p, f t)
          (nhdsWithin c (Ioi c)) (nhds L) ∧
        Tendsto (fun b => ∫ t in p..b, f t)
          (nhdsWithin d (Iio d)) (nhds R) ∧
        HasImproperIntegralTailFromBreaks f d ds J ∧
        I = L + R + J

private def HasImproperIntegralAtTopBreaks
    [CompleteSpace E] (f : ℝ → E) (k : ℝ) : List ℝ → E → Prop
  | [], I =>
      (∀ {b : ℝ}, k ≤ b → IntervalIntegrable f volume k b) ∧
      Tendsto (fun b => ∫ t in k..b, f t) atTop (nhds I)
  | c :: cs, I =>
      ∃ L J : E, k < c ∧
        (∀ {b : ℝ}, k ≤ b → b < c →
          IntervalIntegrable f volume k b) ∧
        Tendsto (fun b => ∫ t in k..b, f t)
          (nhdsWithin c (Iio c)) (nhds L) ∧
        HasImproperIntegralTailFromBreaks f c cs J ∧
        I = L + J
```

This is one acceptable private encoding of the reviewed endpoint semantics,
not an authorization to expose it. A future implementation may change private
proof plumbing only if the public definitions remain definitionally or
propositionally faithful as required by the accepted exact card; any public
signature or semantic change requires a new artifact and review.

## Exact eight public declarations

In the disposable harness, T01 and T05 have the displayed definition bodies.
The six theorem targets use `axiom` solely to validate these exact binders and
result types. Production must use `theorem` with proof bodies and must not add
premises.

### `LMLF.Integral.Improper.Basic`

```lean
/-- IMP-001-T01. -/
def HasImproperIntegralAtTopExcept
    [CompleteSpace E] (f : ℝ → E) (k : ℝ) (S : Finset ℝ) (I : E) : Prop :=
  (∀ c ∈ S, k < c) ∧
    HasImproperIntegralAtTopBreaks f k (S.sort (· ≤ ·)) I

/-- IMP-001-T05. -/
def IsFiniteExceptionalPrimitive
    [CompleteSpace E] (g : ℝ → E) (k : ℝ) (S : Finset ℝ) (F : ℝ → E) : Prop :=
  (∀ c ∈ S, k < c) ∧
    ContinuousOn F (Ici k) ∧
    F k = 0 ∧
    ∀ {a b : ℝ}, k ≤ a → a ≤ b →
      Disjoint (Icc a b) (↑S : Set ℝ) →
      IntervalIntegrable g volume a b ∧
        F b - F a = ∫ t in a..b, g t

/-- IMP-001-T08. Temporary axiom in the disposable signature harness only. -/
axiom hasImproperIntegralAtTopExcept_iff_exists_primitive
    [CompleteSpace E] {f : ℝ → E} {k : ℝ} {S : Finset ℝ} {I : E} :
    HasImproperIntegralAtTopExcept f k S I ↔
      ∃ F : ℝ → E,
        IsFiniteExceptionalPrimitive f k S F ∧
          Tendsto F atTop (nhds I)

/-- IMP-001-T02. Temporary axiom in the disposable signature harness only. -/
axiom HasImproperIntegralAtTopExcept.unique
    [CompleteSpace E] {f : ℝ → E} {k : ℝ} {S : Finset ℝ} {I J : E}
    (hI : HasImproperIntegralAtTopExcept f k S I)
    (hJ : HasImproperIntegralAtTopExcept f k S J) : I = J

/-- IMP-001-T03. Temporary axiom in the disposable signature harness only. -/
axiom HasImproperIntegralAtTopExcept.finset_clm
    {H : Type*} [NormedAddCommGroup H] [NormedSpace ℝ H]
    [CompleteSpace E] [CompleteSpace H]
    {A : Type*} (s : Finset A) (f : A → ℝ → E)
    (S : A → Finset ℝ) (I : A → E) (T : A → E →L[ℝ] H) {k : ℝ}
    (h : ∀ i ∈ s, HasImproperIntegralAtTopExcept (f i) k (S i) (I i)) :
    HasImproperIntegralAtTopExcept
      (fun t => ∑ i ∈ s, T i (f i t)) k
      (s.biUnion S) (∑ i ∈ s, T i (I i))

/-- IMP-001-T04. Temporary axiom in the disposable signature harness only. -/
axiom HasImproperIntegralAtTopExcept.split_regular
    [CompleteSpace E] (f : ℝ → E) {a k : ℝ} (S : Finset ℝ) (I : E)
    (hak : a ≤ k) (hS : ∀ c ∈ S, k < c)
    (hf : IntervalIntegrable f volume a k) :
    HasImproperIntegralAtTopExcept f a S ((∫ t in a..k, f t) + I) ↔
      HasImproperIntegralAtTopExcept f k S I
```

### `LMLF.Integral.Improper.Bochner`

```lean
open Filter MeasureTheory Set

noncomputable section

namespace LMLF.Integral

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- IMP-001-T07. Temporary axiom in the disposable signature harness only. -/
axiom HasImproperIntegralAtTopExcept.of_integrableOn_Ioi
    [CompleteSpace E] (f : ℝ → E) (k : ℝ) (S : Finset ℝ)
    (hS : ∀ c ∈ S, k < c) (hf : IntegrableOn f (Ioi k)) :
    HasImproperIntegralAtTopExcept f k S (∫ t in Ioi k, f t)
```

### `LMLF.Integral.Improper.Abel`

```lean
open Filter MeasureTheory Set
open scoped Interval

noncomputable section

namespace LMLF.Integral

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- IMP-001-T06. Temporary axiom in the disposable signature harness only. -/
axiom IsFiniteExceptionalPrimitive.hasImproperIntegralAtTopExcept_exp_smul
    [CompleteSpace E] {g F : ℝ → E} {k : ℝ} {S : Finset ℝ}
    (hF : IsFiniteExceptionalPrimitive g k S F) (h : ℝ)
    (hInt : IntegrableOn (fun t => Real.exp (-h * t) • F t) (Ioi k))
    (hLim : Tendsto (fun R => Real.exp (-h * R) • F R) atTop (nhds 0)) :
    HasImproperIntegralAtTopExcept
      (fun t => Real.exp (-h * t) • g t) k S
      (h • ∫ t in Ioi k, Real.exp (-h * t) • F t)
```

## Target-to-contract check

| Target | Exact signature property preserved |
|---|---|
| T01 | Binder order is `E, f, k, S, I`; `S : Finset ℝ` is visibly above `k`; the private clauses retain honest compact integrability and independent endpoint limits, including the direct empty-set atTop case. |
| T02 | Two witnesses for the same `f`, `k`, and `S` imply equality of their explicit proposed values; no choice-selected value function is added. |
| T03 | The input/value space `E` and output space `H` are arbitrary complete normed real vector spaces; the conclusion uses exactly `s.biUnion S`, the mapped integrand, and the correspondingly mapped value. |
| T04 | `a ≤ k`, the same literal `S`, and honest `IntervalIntegrable f volume a k` are explicit; the left value is exactly `(∫ a..k, f) + I`, with `J + I` orientation. |
| T05 | The explicit `F` records only `S` above `k`, continuity on `Ici k`, normalization, regular-piece integrability, and every regular-piece increment. It contains no atTop limit or norm bound. |
| T06 | The theorem is unbounded and unweighted in its primitive premise: it accepts arbitrary real `h` and exactly two explicit weighted tail propositions. Its result stays on the same literal `S` at exactly `h • ∫ t in Ioi k, exp (-h*t) • F t`. |
| T07 | An explicit `IntegrableOn f (Ioi k)` premise makes the set-integral value honest; arbitrary finite `S` is retained and no value at the single point `k` matters. |
| T08 | The right side is `∃ F`, not a statement about a fixed supplied `F`; it contains exactly T05 plus convergence to `I`, with no norm bound. |

The private finite-piece Abel identity remains absent from the public target
list. Likewise absent are public constructors, projections, sorted recursion,
anchors, regular-point insertion, representation eliminators, a value function,
and any Gamma, Watson, or source declaration.

## Disposable compilation evidence

All revision-2 prototype work was confined to the new directory
`/workspace/Documents/Codex/imp-r6-negative-fix.XT854T`, outside the candidate
repository. The harness files and exact final hashes are:

| Harness file | SHA-256 | Lines | Result |
|---|---|---:|---|
| `LMLF/Integral/Improper/Basic.lean` | `9a88b646c652126230941c3bc5a033b47a6e514a25a5a37df43439d6a3745c8c` | 106 | compiled, exit 0 |
| `LMLF/Integral/Improper/Bochner.lean` | `33fd45c29a3ea0ec32638c01f7d098a633280c54f34d5b4843721e42020e4cd3` | 20 | compiled, exit 0 |
| `LMLF/Integral/Improper/Abel.lean` | `c96c1f97e0e123fea038dc3748b0164a6f911e8af863d9cde49c278b9457ab53` | 28 | compiled, exit 0 |
| `Check.lean` | `b1aa6e50c08a33509a9e60fa9d2ce583fbb4a88126428cd7dc56c214929b1e5d` | 11 | imported Bochner and Abel; resolved and printed all eight exact names, exit 0 |
| `Regressions.lean` | `93dff3d5c34874efad1894160a8beb7980b7431b2a473822051c19e38ba43f17` | 307 | all unchanged positive consumers and both corrected negative guards elaborated, exit 0 with style-only linter warnings |

The modules were compiled in dependency order with the Lean executable from
the pinned toolchain and a `LEAN_PATH` consisting of the disposable harness
root followed by `lake env printenv LEAN_PATH`. `-R` was set to the disposable
root, and each public module emitted its `.olean` beside the temporary source.
`Check.lean` and `Regressions.lean` were then elaborated with the same root and
path. No GitHub workflow or paid CI was invoked.

Additional local repository checks passed: all 15 tracked YAML/YML files parsed
with the provided PyYAML environment; `python3 scripts/validate_inventory.py`
passed with 148 occurrences, 31 notations, 32 entities, 34 evidence rows, and
88 associations; and `python3 scripts/validate_inventory.py --negative-tests`
rejected all 25 intentionally invalid copied fixtures before the positive
revalidation passed. These checks validate repository mechanics only and add no
signature, proof, review, or authorization claim.

The final `#check` output confirmed:

- `[CompleteSpace E]` on every target and both `[CompleteSpace E]` and
  `[CompleteSpace H]` on T03;
- T03's literal `(s.biUnion S)` and heterogeneous `E →L[ℝ] H` maps;
- T04's exact interval-integral orientation and `J + I` value;
- T06's exact same-`S`, `h • Ioi-integral` conclusion and its two weighted
  premises;
- T07's explicit `IntegrableOn`; and
- T08's existential primitive.

The public consumer file contains no occurrence of either private recursive
definition, `S.sort`, a Watson/QL/OLV name, or a downstream LMLF import.

Revision 1's two negative checks were vacuous: each ran `exact` on a relation
or equivalence while the outer goal was `True`, so the inner tactic failed from
the unrelated goal mismatch even under the prohibited signature shape. That
evidence is superseded. Revision 2 gives the inner `have` its intended bad
type, checks that each guard succeeds against the valid API, and checks an
isolated prohibited mutant. Under each mutant the typed `have` succeeds, so
`fail_if_success` itself emits the specifically asserted diagnostic. No public
signature, import, definition, axiom, or positive consumer proof changed.

## Public-use regression results

| Regression | Verified compile-time result | Scope limit |
|---|---|---|
| Arbitrary-`S` R20 | From public T05, `h > 0`, `L ≥ 0`, and `‖F t‖ ≤ L` on `Ici k`, the consumer actually derives weighted `IntegrableOn` using root `integrableOn_exp_mul_Ioi`, derives boundary vanishing using `Real.tendsto_exp_neg_atTop_nhds_zero`, and invokes only public T06. | This proves consumer reachability assuming the temporary T06 axiom; it is not a proof of T06. |
| Arbitrary-`S` T07 and initial-point null irrelevance | The consumer changes `f k` with `Function.update`, proves equality on `Ioi k`, transports `IntegrableOn` and the set integral, and calls public T07 for the unchanged arbitrary `S`. | This is a signature-level null-set check, not a concrete singular-function theorem. |
| T03 cross-codomain and literal union | A fully generic theorem with complete `E` and `H` returns exactly the `s.biUnion S` relation for maps `E →L[ℝ] H`. One-model subtraction and recombination instances also compile solely through T03. | The generic T03 target remains axiomatic in this harness. |
| T04 then T08 extraction | Starting from the exact `J + I` left relation and honest local `IntervalIntegrable`, the consumer uses T04 to obtain the tail and T08 forward to obtain `∃ F`. | No unfolding of T01 or private recursion occurs. |
| Flat bound derived separately | A proved local consumer lemma derives `∃ L ≥ 0, ∀ t ≥ k, ‖F t‖ ≤ L` from `ContinuousOn F (Ici k)` and `Tendsto F atTop (nhds I)`, using eventual boundedness and compact-prefix boundedness. | The bound is absent from T08 and T05, as required. |
| Complete source-shaped chain | A compiled one-model finite instance starts from a baseline source relation and raw model `IntegrableOn`; uses T07/T03 subtraction; performs an honest T04 split; extracts T05 plus a finite limit through T08; derives `L`; applies the arbitrary-`S` R20/T06 route; prepends with T04; and applies target T07/T03 recombination. | This is an API reachability chain, not QL or OLV implementation. Arbitrary finite-family shape is checked separately by the generic T03 regression. |
| Negative: missing `IntegrableOn` | A typed `have hbad : HasImproperIntegralAtTopExcept f k S (∫ t in Ioi k, f t)` inside `fail_if_success` is rejected by the valid T07 signature. The guard-only valid control exits 0; an isolated T07 mutant without `IntegrableOn` compiles, then the same guard exits exactly 1 with the asserted `fail_if_success`-succeeded diagnostic. | Type-shape rejection only; no nonintegrable counterexample is claimed. |
| Negative: fixed `F` versus existential T08 | A typed `have hbad` for the fixed-`F` equivalence inside `fail_if_success` is rejected by the valid existential T08 signature. The guard-only valid control exits 0; an isolated fixed-`F` mutant compiles, then the same guard exits exactly 1 with the asserted diagnostic. | Type-shape rejection only; it does not prove a mathematical nonexistence result. |

No concrete principal-value, conditional-singularity, or nonintegrable
counterexample theorem was proved in this signature harness. Those remain
mathematical implementation regressions for a later authorized phase; the two
negative checks above are deliberately reported only as type-shape checks.

## Library-architecture audit disposition

Applying every section of the library-scale rubric to this design produced no
new `G#` finding:

1. Mathematical intent: the eight types match the reviewed T01--T08 route.
2. Reusable seams: T08, T07, generalized T03, and public T06 each have the
   recorded QL/OLV consumers; no additional wrapper has two justified clients.
3. Public API: the surface is exactly eight targets; private representation and
   finite-piece Abel plumbing remain private.
4. Modules: dependencies point from `Basic` to the independent `Bochner` and
   `Abel` bridges, never downstream.
5. Mathlib integration: direct pinned facts are reused at their exact root
   names; no project-local substitute is proposed.
6. Proof architecture: T08 owns component stitching, T06 owns weighted
   composition, and downstream consumers do not unfold T01.
7. Cost and durability: no performance claim is made before proof bodies exist;
   imports are narrow and proof-purpose-specific.
8. Refactor risk: no compatibility alias or historical six-target surface is
   retained; changing these candidate bytes requires fresh signature review.

Explicit do-not-refactor decisions are: do not expose sorted components or
anchors; do not merge `Bochner` and `Abel`; do not specialize T03 back to
`E → E`; do not place a bound in T05/T08; and do not replace T07's integrability
premise with a totalized value.

## Remaining gates and unresolved issues

1. Two independent reviewers must review this exact new artifact, including
   semantic fidelity of the private T01 encoding, every binder/result type,
   the eight-target count, module ownership, import boundary, and consumer
   regressions.
2. A later theorem-card revision and work packet must bind the accepted exact
   artifact digest. The current R6 card deliberately remains byte-for-byte
   unchanged and still says the signature artifact is absent.
3. Registry reconciliation, execution-manifest admission, an external frozen
   packet/envelope, and composite `lean_ready` remain absent.
4. Production implementation authorization remains absent. The six theorem
   targets in the harness are axioms, so no theorem target has a kernel-checked
   proof and no target axiom report is release evidence.
5. The proposed production imports compile the signatures and follow the
   reviewed dependency ledger, but proof-body sufficiency and minimality must be
   rechecked during an authorized implementation without importing downstream
   mathematics.
6. The meaning of “public-IMP-only consumer” must be frozen explicitly as
   excluding private/downstream LMLF modules while allowing separately declared
   pinned Mathlib support. A stronger reading forbidding direct Mathlib imports
   was not met and is not silently claimed.
7. Source collation/fidelity and the conditional OLV source adapter remain
   outside this source-independent signature design.

Until all applicable external gates pass, `IMP-001` remains planning-only,
unregistered, unimplemented, and not `lean_ready`.

## Reproducibility appendices

### Authoritative harness sources

Create each of the five files at the path named by its heading below by copying
the corresponding complete fenced block byte-for-byte, including its final
newline. The earlier partial code excerpts explain the contracts only and are
not assembly inputs.

### Complete three-module harness sources

The following complete files are authoritative for byte-level reconstruction.

#### Complete `LMLF/Integral/Improper/Basic.lean`

```lean
import Mathlib.Data.Finset.Sort
import Mathlib.MeasureTheory.Integral.DominatedConvergence

/-!
Disposable IMP-001 R6 exact-signature harness.

The private definitions below are a candidate sorted-component representation.
The public theorem targets are temporary axioms only because this harness checks
signature elaboration, not proofs. Nothing in this directory is production code.
-/

open Filter MeasureTheory Set
open scoped Interval

noncomputable section

namespace LMLF.Integral

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

private def HasImproperIntegralTailFromBreaks
    [CompleteSpace E] (f : ℝ → E) (c : ℝ) : List ℝ → E → Prop
  | [], I =>
      ∃ d : ℝ, ∃ L R : E, c < d ∧
        (∀ {a b : ℝ}, c < a → a ≤ b →
          IntervalIntegrable f volume a b) ∧
        Tendsto (fun a => ∫ t in a..d, f t)
          (nhdsWithin c (Ioi c)) (nhds L) ∧
        Tendsto (fun b => ∫ t in d..b, f t) atTop (nhds R) ∧
        I = L + R
  | d :: ds, I =>
      ∃ p : ℝ, ∃ L R J : E, c < p ∧ p < d ∧
        (∀ {a b : ℝ}, c < a → a ≤ b → b < d →
          IntervalIntegrable f volume a b) ∧
        Tendsto (fun a => ∫ t in a..p, f t)
          (nhdsWithin c (Ioi c)) (nhds L) ∧
        Tendsto (fun b => ∫ t in p..b, f t)
          (nhdsWithin d (Iio d)) (nhds R) ∧
        HasImproperIntegralTailFromBreaks f d ds J ∧
        I = L + R + J

private def HasImproperIntegralAtTopBreaks
    [CompleteSpace E] (f : ℝ → E) (k : ℝ) : List ℝ → E → Prop
  | [], I =>
      (∀ {b : ℝ}, k ≤ b → IntervalIntegrable f volume k b) ∧
      Tendsto (fun b => ∫ t in k..b, f t) atTop (nhds I)
  | c :: cs, I =>
      ∃ L J : E, k < c ∧
        (∀ {b : ℝ}, k ≤ b → b < c →
          IntervalIntegrable f volume k b) ∧
        Tendsto (fun b => ∫ t in k..b, f t)
          (nhdsWithin c (Iio c)) (nhds L) ∧
        HasImproperIntegralTailFromBreaks f c cs J ∧
        I = L + J

/-- IMP-001-T01. -/
def HasImproperIntegralAtTopExcept
    [CompleteSpace E] (f : ℝ → E) (k : ℝ) (S : Finset ℝ) (I : E) : Prop :=
  (∀ c ∈ S, k < c) ∧
    HasImproperIntegralAtTopBreaks f k (S.sort (· ≤ ·)) I

/-- IMP-001-T05. -/
def IsFiniteExceptionalPrimitive
    [CompleteSpace E] (g : ℝ → E) (k : ℝ) (S : Finset ℝ) (F : ℝ → E) : Prop :=
  (∀ c ∈ S, k < c) ∧
    ContinuousOn F (Ici k) ∧
    F k = 0 ∧
    ∀ {a b : ℝ}, k ≤ a → a ≤ b →
      Disjoint (Icc a b) (↑S : Set ℝ) →
      IntervalIntegrable g volume a b ∧
        F b - F a = ∫ t in a..b, g t

/-- IMP-001-T08. Temporary axiom in the disposable signature harness only. -/
axiom hasImproperIntegralAtTopExcept_iff_exists_primitive
    [CompleteSpace E] {f : ℝ → E} {k : ℝ} {S : Finset ℝ} {I : E} :
    HasImproperIntegralAtTopExcept f k S I ↔
      ∃ F : ℝ → E,
        IsFiniteExceptionalPrimitive f k S F ∧
          Tendsto F atTop (nhds I)

/-- IMP-001-T02. Temporary axiom in the disposable signature harness only. -/
axiom HasImproperIntegralAtTopExcept.unique
    [CompleteSpace E] {f : ℝ → E} {k : ℝ} {S : Finset ℝ} {I J : E}
    (hI : HasImproperIntegralAtTopExcept f k S I)
    (hJ : HasImproperIntegralAtTopExcept f k S J) : I = J

/-- IMP-001-T03. Temporary axiom in the disposable signature harness only. -/
axiom HasImproperIntegralAtTopExcept.finset_clm
    {H : Type*} [NormedAddCommGroup H] [NormedSpace ℝ H]
    [CompleteSpace E] [CompleteSpace H]
    {A : Type*} (s : Finset A) (f : A → ℝ → E)
    (S : A → Finset ℝ) (I : A → E) (T : A → E →L[ℝ] H) {k : ℝ}
    (h : ∀ i ∈ s, HasImproperIntegralAtTopExcept (f i) k (S i) (I i)) :
    HasImproperIntegralAtTopExcept
      (fun t => ∑ i ∈ s, T i (f i t)) k
      (s.biUnion S) (∑ i ∈ s, T i (I i))

/-- IMP-001-T04. Temporary axiom in the disposable signature harness only. -/
axiom HasImproperIntegralAtTopExcept.split_regular
    [CompleteSpace E] (f : ℝ → E) {a k : ℝ} (S : Finset ℝ) (I : E)
    (hak : a ≤ k) (hS : ∀ c ∈ S, k < c)
    (hf : IntervalIntegrable f volume a k) :
    HasImproperIntegralAtTopExcept f a S ((∫ t in a..k, f t) + I) ↔
      HasImproperIntegralAtTopExcept f k S I

end LMLF.Integral
```

#### Complete `LMLF/Integral/Improper/Bochner.lean`

```lean
import LMLF.Integral.Improper.Basic
import Mathlib.MeasureTheory.Integral.IntegralEqImproper

/-! Disposable IMP-001 R6 exact-signature harness; the target is an axiom here only. -/

open Filter MeasureTheory Set

noncomputable section

namespace LMLF.Integral

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- IMP-001-T07. Temporary axiom in the disposable signature harness only. -/
axiom HasImproperIntegralAtTopExcept.of_integrableOn_Ioi
    [CompleteSpace E] (f : ℝ → E) (k : ℝ) (S : Finset ℝ)
    (hS : ∀ c ∈ S, k < c) (hf : IntegrableOn f (Ioi k)) :
    HasImproperIntegralAtTopExcept f k S (∫ t in Ioi k, f t)

end LMLF.Integral
```

#### Complete `LMLF/Integral/Improper/Abel.lean`

```lean
import LMLF.Integral.Improper.Basic
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
import Mathlib.MeasureTheory.Integral.Prod
import Mathlib.MeasureTheory.Integral.IntegralEqImproper

/-! Disposable IMP-001 R6 exact-signature harness; the target is an axiom here only. -/

open Filter MeasureTheory Set
open scoped Interval

noncomputable section

namespace LMLF.Integral

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- IMP-001-T06. Temporary axiom in the disposable signature harness only. -/
axiom IsFiniteExceptionalPrimitive.hasImproperIntegralAtTopExcept_exp_smul
    [CompleteSpace E] {g F : ℝ → E} {k : ℝ} {S : Finset ℝ}
    (hF : IsFiniteExceptionalPrimitive g k S F) (h : ℝ)
    (hInt : IntegrableOn (fun t => Real.exp (-h * t) • F t) (Ioi k))
    (hLim : Tendsto (fun R => Real.exp (-h * R) • F R) atTop (nhds 0)) :
    HasImproperIntegralAtTopExcept
      (fun t => Real.exp (-h * t) • g t) k S
      (h • ∫ t in Ioi k, Real.exp (-h * t) • F t)

end LMLF.Integral
```
The public signatures above were checked together by the recorded disposable harness. The redundant
name-only `#check` listing has been omitted; the complete declarations are the useful review surface.

### Complete `Regressions.lean`

This is the exact checked consumer source. Its local helper theorems have real
proof bodies and are not imported LMLF APIs. Six theorem targets in the three
signature modules are temporary axioms; T01 and T05 are actual definitions.

```lean
import LMLF.Integral.Improper.Basic
import LMLF.Integral.Improper.Bochner
import LMLF.Integral.Improper.Abel
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Order.Filter.AtTopBot.Field

/-!
Disposable public-use regressions for the IMP-001 R6 exact signatures.
The imported IMP theorem declarations are axioms only in the separate signature
harness modules. Every theorem in this consumer file has an actual proof.
-/

open Filter MeasureTheory Set
open scoped Interval

noncomputable section

namespace LMLF.IMP001R6SignatureRegression

open LMLF.Integral

variable {E H : Type*}
  [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
  [NormedAddCommGroup H] [NormedSpace ℝ H] [CompleteSpace H]

/-- IMP-R20: arbitrary `S`, with both T06 side conditions derived from a
separate flat bound and `h > 0`. -/
theorem r20_arbitrary_S_from_bounded_primitive
    {g F : ℝ → E} {k h L : ℝ} {S : Finset ℝ}
    (hF : IsFiniteExceptionalPrimitive g k S F)
    (hh : 0 < h) (hL : 0 ≤ L)
    (hflat : ∀ t, k ≤ t → ‖F t‖ ≤ L) :
    HasImproperIntegralAtTopExcept
      (fun t => Real.exp (-h * t) • g t) k S
      (h • ∫ t in Ioi k, Real.exp (-h * t) • F t) := by
  have hscalar : Continuous (fun t : ℝ => Real.exp (-h * t)) :=
    Real.continuous_exp.comp (continuous_const.mul continuous_id)
  have hFcont : ContinuousOn F (Ioi k) :=
    hF.2.1.mono (fun _ ht => show k ≤ _ from ht.le)
  have hwcont : ContinuousOn (fun t => Real.exp (-h * t) • F t) (Ioi k) :=
    hscalar.continuousOn.smul hFcont
  have hexp : IntegrableOn (fun t : ℝ => Real.exp (-h * t)) (Ioi k) := by
    simpa using integrableOn_exp_mul_Ioi (a := -h) (neg_lt_zero.mpr hh) k
  have hmajorant :
      Integrable (fun t : ℝ => L * Real.exp (-h * t)) (volume.restrict (Ioi k)) :=
    hexp.const_mul L
  have hwInt : IntegrableOn (fun t => Real.exp (-h * t) • F t) (Ioi k) := by
    refine hmajorant.mono' (hwcont.aestronglyMeasurable measurableSet_Ioi) ?_
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
    rw [norm_smul, Real.norm_of_nonneg (Real.exp_pos _).le]
    calc
      Real.exp (-h * t) * ‖F t‖ ≤ Real.exp (-h * t) * L :=
        mul_le_mul_of_nonneg_left (hflat t ht.le) (Real.exp_pos _).le
      _ = L * Real.exp (-h * t) := mul_comm _ _
  have hexp0 : Tendsto (fun t : ℝ => Real.exp (-h * t)) atTop (nhds 0) := by
    have hscale : Tendsto (fun t : ℝ => h * t) atTop atTop :=
      tendsto_id.const_mul_atTop hh
    refine (Real.tendsto_exp_neg_atTop_nhds_zero.comp hscale).congr' ?_
    exact Eventually.of_forall fun t => by
      simp only [Function.comp_apply, neg_mul]
  have hwLim : Tendsto (fun t => Real.exp (-h * t) • F t) atTop (nhds 0) := by
    rw [tendsto_zero_iff_norm_tendsto_zero]
    refine squeeze_zero' (g := fun t => Real.exp (-h * t) * L)
      (Eventually.of_forall fun _ => norm_nonneg _) ?_ ?_
    · filter_upwards [eventually_ge_atTop k] with t ht
      rw [norm_smul, Real.norm_of_nonneg (Real.exp_pos _).le]
      exact mul_le_mul_of_nonneg_left (hflat t ht) (Real.exp_pos _).le
    · simpa using hexp0.mul_const L
  exact hF.hasImproperIntegralAtTopExcept_exp_smul h hwInt hwLim

/-- A finite limit and continuity give a flat bound, but the bound is derived
outside T08 and is not a field of either public predicate. -/
theorem flat_bound_of_continuousOn_Ici_of_tendsto
    {F : ℝ → E} {k : ℝ} {I : E}
    (hcont : ContinuousOn F (Ici k)) (hlim : Tendsto F atTop (nhds I)) :
    ∃ L : ℝ, 0 ≤ L ∧ ∀ t, k ≤ t → ‖F t‖ ≤ L := by
  rcases (Metric.tendsto_atTop.1 hlim 1 zero_lt_one) with ⟨N, hN⟩
  let r : ℝ := max k N
  have hcomp : IsCompact (F '' Icc k r) :=
    isCompact_Icc.image_of_continuousOn
      (hcont.mono fun _ ht => ht.1)
  rcases isBounded_iff_forall_norm_le.mp hcomp.isBounded with ⟨C, hC⟩
  refine ⟨max C (‖I‖ + 1), ?_, ?_⟩
  · exact le_trans (norm_nonneg I) (le_trans (le_add_of_nonneg_right zero_le_one) (le_max_right _ _))
  · intro t hkt
    by_cases htr : t ≤ r
    · exact (hC (F t) ⟨t, ⟨hkt, htr⟩, rfl⟩).trans (le_max_left _ _)
    · have hNt : N ≤ t :=
        (le_max_right k N).trans (le_of_lt (lt_of_not_ge htr))
      have hdist : ‖F t - I‖ ≤ 1 := by
        simpa [dist_eq_norm] using (hN t hNt).le
      calc
        ‖F t‖ = ‖(F t - I) + I‖ := by rw [sub_add_cancel]
        _ ≤ ‖F t - I‖ + ‖I‖ := norm_add_le _ _
        _ ≤ ‖I‖ + 1 := by linarith
        _ ≤ max C (‖I‖ + 1) := le_max_right _ _

/-- T07 works for arbitrary `S`; changing only the initial-point value leaves
both the `Ioi` integrability premise and honest set-integral value unchanged. -/
theorem r07_initial_point_value_irrelevant
    (f : ℝ → E) (k : ℝ) (S : Finset ℝ) (z : E)
    (hS : ∀ c ∈ S, k < c) (hf : IntegrableOn f (Ioi k)) :
    HasImproperIntegralAtTopExcept
      (Function.update f k z) k S (∫ t in Ioi k, f t) := by
  have heq : Set.EqOn (Function.update f k z) f (Ioi k) := by
    intro t ht
    have hkt : k < t := ht
    exact Function.update_of_ne (a := t) (a' := k) (ne_of_gt hkt) z f
  have hu : IntegrableOn (Function.update f k z) (Ioi k) :=
    hf.congr_fun heq.symm measurableSet_Ioi
  have hrel :=
    HasImproperIntegralAtTopExcept.of_integrableOn_Ioi
      (Function.update f k z) k S hS hu
  rw [setIntegral_congr_fun measurableSet_Ioi heq] at hrel
  exact hrel

/-- T03 retains the literal `biUnion` and supports a distinct complete output
codomain. -/
theorem r03_cross_codomain_literal_union
    {A : Type*} (s : Finset A) (f : A → ℝ → E)
    (S : A → Finset ℝ) (I : A → E) (T : A → E →L[ℝ] H) {k : ℝ}
    (h : ∀ i ∈ s, HasImproperIntegralAtTopExcept (f i) k (S i) (I i)) :
    HasImproperIntegralAtTopExcept
      (fun t => ∑ i ∈ s, T i (f i t)) k
      (s.biUnion S) (∑ i ∈ s, T i (I i)) :=
  HasImproperIntegralAtTopExcept.finset_clm s f S I T h

/-- A one-model finite subtraction instance used by the source-shaped chain.
It is proved only through T03; no relation representation is opened. -/
theorem subtract_one_model
    {q m : ℝ → E} {k : ℝ} {S : Finset ℝ} {Q M : E}
    (U : E →L[ℝ] E)
    (hq : HasImproperIntegralAtTopExcept q k S Q)
    (hm : HasImproperIntegralAtTopExcept m k ∅ M) :
    HasImproperIntegralAtTopExcept
      (fun t => q t - U (m t)) k S (Q - U M) := by
  let f : Fin 2 → ℝ → E := ![q, m]
  let sets : Fin 2 → Finset ℝ := ![S, ∅]
  let vals : Fin 2 → E := ![Q, M]
  let maps : Fin 2 → E →L[ℝ] E := ![ContinuousLinearMap.id ℝ E, -U]
  have hs : ∀ i ∈ (Finset.univ : Finset (Fin 2)),
      HasImproperIntegralAtTopExcept (f i) k (sets i) (vals i) := by
    intro i _
    fin_cases i
    · simpa [f, sets, vals] using hq
    · simpa [f, sets, vals] using hm
  have hunion : (Finset.univ : Finset (Fin 2)).biUnion sets = S := by
    ext x
    simp only [Finset.mem_biUnion, Finset.mem_univ, true_and]
    constructor
    · rintro ⟨i, hi⟩
      fin_cases i
      · simpa [sets] using hi
      · simpa [sets] using hi
    · intro hx
      exact ⟨0, by simpa [sets] using hx⟩
  have hcomb := HasImproperIntegralAtTopExcept.finset_clm
    (Finset.univ : Finset (Fin 2)) f sets vals maps hs
  rw [hunion] at hcomb
  simpa [f, vals, maps, Fin.sum_univ_two, sub_eq_add_neg] using hcomb

/-- A one-model finite recombination instance used by the source-shaped chain. -/
theorem add_one_model
    {r m : ℝ → E} {k : ℝ} {S : Finset ℝ} {R M : E}
    (U : E →L[ℝ] E)
    (hr : HasImproperIntegralAtTopExcept r k S R)
    (hm : HasImproperIntegralAtTopExcept m k ∅ M) :
    HasImproperIntegralAtTopExcept
      (fun t => r t + U (m t)) k S (R + U M) := by
  let f : Fin 2 → ℝ → E := ![r, m]
  let sets : Fin 2 → Finset ℝ := ![S, ∅]
  let vals : Fin 2 → E := ![R, M]
  let maps : Fin 2 → E →L[ℝ] E := ![ContinuousLinearMap.id ℝ E, U]
  have hs : ∀ i ∈ (Finset.univ : Finset (Fin 2)),
      HasImproperIntegralAtTopExcept (f i) k (sets i) (vals i) := by
    intro i _
    fin_cases i
    · simpa [f, sets, vals] using hr
    · simpa [f, sets, vals] using hm
  have hunion : (Finset.univ : Finset (Fin 2)).biUnion sets = S := by
    ext x
    simp only [Finset.mem_biUnion, Finset.mem_univ, true_and]
    constructor
    · rintro ⟨i, hi⟩
      fin_cases i
      · simpa [sets] using hi
      · simpa [sets] using hi
    · intro hx
      exact ⟨0, by simpa [sets] using hx⟩
  have hcomb := HasImproperIntegralAtTopExcept.finset_clm
    (Finset.univ : Finset (Fin 2)) f sets vals maps hs
  rw [hunion] at hcomb
  simpa [f, vals, maps, Fin.sum_univ_two] using hcomb

/-- T04 has the exact `J + I` orientation; T08 then extracts an existential
primitive, and its flat bound is proved by the separate theorem above. -/
theorem r04_split_then_r08_extract_and_bound
    (f : ℝ → E) {a k : ℝ} (S : Finset ℝ) (I : E)
    (hak : a ≤ k) (hS : ∀ c ∈ S, k < c)
    (hf : IntervalIntegrable f volume a k)
    (hrel : HasImproperIntegralAtTopExcept
      f a S ((∫ t in a..k, f t) + I)) :
    ∃ F : ℝ → E, ∃ L : ℝ,
      IsFiniteExceptionalPrimitive f k S F ∧
      Tendsto F atTop (nhds I) ∧
      0 ≤ L ∧ ∀ t, k ≤ t → ‖F t‖ ≤ L := by
  have htail : HasImproperIntegralAtTopExcept f k S I :=
    (HasImproperIntegralAtTopExcept.split_regular f S I hak hS hf).mp hrel
  rcases hasImproperIntegralAtTopExcept_iff_exists_primitive.mp htail with
    ⟨F, hprim, hlim⟩
  rcases flat_bound_of_continuousOn_Ici_of_tendsto hprim.2.1 hlim with
    ⟨L, hL, hflat⟩
  exact ⟨F, L, hprim, hlim, hL, hflat⟩

/-- A bounded, complete source-shaped path: baseline source relation; raw
absolutely integrable model; T07/T03 subtraction; honest local split; T08
extraction and separately proved flat bound; arbitrary-S T06; target prepend;
and target T07/T03 recombination. It mentions no private IMP helper. -/
theorem source_shaped_public_chain_one_model
    (q m : ℝ → E) (U : E →L[ℝ] E) (S : Finset ℝ)
    (QX : E) {k h : ℝ}
    (hSk : ∀ c ∈ S, k < c) (h0k : 0 ≤ k) (hh : 0 < h)
    (hsource : HasImproperIntegralAtTopExcept q 0 S QX)
    (hmodelX : IntegrableOn m (Ioi 0))
    (hlocalX : IntervalIntegrable (fun t => q t - U (m t)) volume 0 k)
    (hlocalTarget : IntervalIntegrable
      (fun t => Real.exp (-h * t) • (q t - U (m t))) volume 0 k)
    (hmodelTarget : IntegrableOn
      (fun t => Real.exp (-h * t) • m t) (Ioi 0)) :
    ∃ F : ℝ → E, ∃ L : ℝ,
      IsFiniteExceptionalPrimitive
          (fun t => q t - U (m t)) k S F ∧
      Tendsto F atTop
        (nhds (QX - U (∫ t in Ioi 0, m t) -
          ∫ t in (0 : ℝ)..k, q t - U (m t))) ∧
      0 ≤ L ∧
      (∀ t, k ≤ t → ‖F t‖ ≤ L) ∧
      HasImproperIntegralAtTopExcept
        (fun t =>
          Real.exp (-h * t) • (q t - U (m t)) +
            U (Real.exp (-h * t) • m t))
        0 S
        ((∫ t in (0 : ℝ)..k, Real.exp (-h * t) • (q t - U (m t))) +
          h • (∫ t in Ioi k, Real.exp (-h * t) • F t) +
          U (∫ t in Ioi 0, Real.exp (-h * t) • m t)) := by
  have hmX : HasImproperIntegralAtTopExcept
      m 0 ∅ (∫ t in Ioi 0, m t) :=
    HasImproperIntegralAtTopExcept.of_integrableOn_Ioi
      m 0 ∅ (by simp) hmodelX
  have hrem0 : HasImproperIntegralAtTopExcept
      (fun t => q t - U (m t)) 0 S
      (QX - U (∫ t in Ioi 0, m t)) :=
    subtract_one_model U hsource hmX
  let JX : E := ∫ t in (0 : ℝ)..k, q t - U (m t)
  let TX : E := QX - U (∫ t in Ioi 0, m t) - JX
  have hrem0' : HasImproperIntegralAtTopExcept
      (fun t => q t - U (m t)) 0 S (JX + TX) := by
    simpa [JX, TX, sub_eq_add_neg, add_assoc, add_left_comm, add_comm] using hrem0
  have htail : HasImproperIntegralAtTopExcept
      (fun t => q t - U (m t)) k S TX :=
    (HasImproperIntegralAtTopExcept.split_regular
      (fun t => q t - U (m t)) S TX h0k hSk hlocalX).mp hrem0'
  rcases hasImproperIntegralAtTopExcept_iff_exists_primitive.mp htail with
    ⟨F, hprim, hlim⟩
  rcases flat_bound_of_continuousOn_Ici_of_tendsto hprim.2.1 hlim with
    ⟨L, hL, hflat⟩
  have hweightedTail :=
    r20_arbitrary_S_from_bounded_primitive hprim hh hL hflat
  have hweightedFull : HasImproperIntegralAtTopExcept
      (fun t => Real.exp (-h * t) • (q t - U (m t))) 0 S
      ((∫ t in (0 : ℝ)..k, Real.exp (-h * t) • (q t - U (m t))) +
        h • ∫ t in Ioi k, Real.exp (-h * t) • F t) :=
    (HasImproperIntegralAtTopExcept.split_regular
      (fun t => Real.exp (-h * t) • (q t - U (m t))) S
      (h • ∫ t in Ioi k, Real.exp (-h * t) • F t)
      h0k hSk hlocalTarget).mpr hweightedTail
  have hmTarget : HasImproperIntegralAtTopExcept
      (fun t => Real.exp (-h * t) • m t) 0 ∅
      (∫ t in Ioi 0, Real.exp (-h * t) • m t) :=
    HasImproperIntegralAtTopExcept.of_integrableOn_Ioi
      (fun t => Real.exp (-h * t) • m t) 0 ∅ (by simp) hmodelTarget
  have hfinal := add_one_model U hweightedFull hmTarget
  exact ⟨F, L, hprim, by simpa [TX, JX] using hlim, hL, hflat, by
    simpa [add_assoc] using hfinal⟩

section NegativeTypeShapeChecks

example (f : ℝ → E) (k : ℝ) (S : Finset ℝ)
    (hS : ∀ c ∈ S, k < c) : True := by
  fail_if_success
    have hbad : HasImproperIntegralAtTopExcept
        f k S (∫ t in Ioi k, f t) :=
      HasImproperIntegralAtTopExcept.of_integrableOn_Ioi f k S hS
  trivial

example (f F : ℝ → E) (k : ℝ) (S : Finset ℝ) (I : E) : True := by
  fail_if_success
    have hbad :
      HasImproperIntegralAtTopExcept f k S I ↔
        IsFiniteExceptionalPrimitive f k S F ∧ Tendsto F atTop (nhds I) :=
      hasImproperIntegralAtTopExcept_iff_exists_primitive
  trivial

end NegativeTypeShapeChecks

end LMLF.IMP001R6SignatureRegression
```

### Negative-guard sensitivity evidence

The complete valid `Regressions.lean` above contains the corrected guards.
For sensitivity only, two separate disposable mutant roots were made from the
authoritative valid sources. Each mutant changes one prohibited type shape;
neither is a candidate declaration, proof, or production file. No positive
consumer was compiled against either mutant.

For T07, the mutant is obtained by applying exactly this patch to the complete
valid `LMLF/Integral/Improper/Bochner.lean` block above:

```diff
 axiom HasImproperIntegralAtTopExcept.of_integrableOn_Ioi
     [CompleteSpace E] (f : ℝ → E) (k : ℝ) (S : Finset ℝ)
-    (hS : ∀ c ∈ S, k < c) (hf : IntegrableOn f (Ioi k)) :
+    (hS : ∀ c ∈ S, k < c) :
     HasImproperIntegralAtTopExcept f k S (∫ t in Ioi k, f t)
```

The complete T07 guard-only source is:

```lean
import LMLF.Integral.Improper.Bochner

open Filter MeasureTheory Set

noncomputable section

open LMLF.Integral

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]

example (f : ℝ → E) (k : ℝ) (S : Finset ℝ)
    (hS : ∀ c ∈ S, k < c) : True := by
  fail_if_success
    have hbad : HasImproperIntegralAtTopExcept
        f k S (∫ t in Ioi k, f t) :=
      HasImproperIntegralAtTopExcept.of_integrableOn_Ioi f k S hS
  trivial
```

The T07 mutant uses the unchanged valid `Basic.lean` hash
`9a88b646c652126230941c3bc5a033b47a6e514a25a5a37df43439d6a3745c8c`,
the patched `Bochner.lean` hash
`1dffc49ac37aa44a95847ff39fde9b4adf48071a505c67d2d238d4a75b643903`,
and guard hash
`55421431513e1ba1f0e71a1ae5822eb77b5c6e8d82d9e640d3df100f6adbc758`.
The exact strengthened run was:

```bash
set -e
MUTANT_ROOT=/workspace/Documents/Codex/imp-r6-negative-fix.XT854T/mutants/t07
TOOL_LEAN=/home/codex/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean
PIN_LEAN_PATH="$MUTANT_ROOT:$(lake env printenv LEAN_PATH)"
env LEAN_PATH="$PIN_LEAN_PATH" "$TOOL_LEAN" -R "$MUTANT_ROOT" \
  -o "$MUTANT_ROOT/LMLF/Integral/Improper/Basic.olean" \
  "$MUTANT_ROOT/LMLF/Integral/Improper/Basic.lean"
env LEAN_PATH="$PIN_LEAN_PATH" "$TOOL_LEAN" -R "$MUTANT_ROOT" \
  -o "$MUTANT_ROOT/LMLF/Integral/Improper/Bochner.olean" \
  "$MUTANT_ROOT/LMLF/Integral/Improper/Bochner.lean"
set +e
MUTANT_OUTPUT="$(env LEAN_PATH="$PIN_LEAN_PATH" "$TOOL_LEAN" \
  -R "$MUTANT_ROOT" "$MUTANT_ROOT/Guard.lean" 2>&1)"
GUARD_STATUS=$?
set -e
printf '%s\n' "$MUTANT_OUTPUT"
printf 'T07 mutant guard exit: %s\n' "$GUARD_STATUS"
test "$GUARD_STATUS" -eq 1
printf '%s\n' "$MUTANT_OUTPUT" |
  rg -F 'succeeded but was expected to fail:'
```

Both mutant signature modules returned exit 0. The guard returned exactly 1,
and the fixed-string assertion matched this diagnostic:

```text
/workspace/Documents/Codex/imp-r6-negative-fix.XT854T/mutants/t07/Guard.lean:13:2: error: The tactic provided to `fail_if_success` succeeded but was expected to fail:
  have hbad : HasImproperIntegralAtTopExcept f k S (∫ t in Ioi k, f t) :=
      HasImproperIntegralAtTopExcept.of_integrableOn_Ioi f k S hS
```

For T08, the mutant is obtained by applying exactly this patch to the complete
valid `LMLF/Integral/Improper/Basic.lean` block above:

```diff
 axiom hasImproperIntegralAtTopExcept_iff_exists_primitive
-    [CompleteSpace E] {f : ℝ → E} {k : ℝ} {S : Finset ℝ} {I : E} :
+    [CompleteSpace E] {f F : ℝ → E} {k : ℝ} {S : Finset ℝ} {I : E} :
     HasImproperIntegralAtTopExcept f k S I ↔
-      ∃ F : ℝ → E,
-        IsFiniteExceptionalPrimitive f k S F ∧
-          Tendsto F atTop (nhds I)
+      IsFiniteExceptionalPrimitive f k S F ∧
+        Tendsto F atTop (nhds I)
```

The complete T08 guard-only source is:

```lean
import LMLF.Integral.Improper.Basic

open Filter MeasureTheory Set

noncomputable section

open LMLF.Integral

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]

example (f F : ℝ → E) (k : ℝ) (S : Finset ℝ) (I : E) : True := by
  fail_if_success
    have hbad :
      HasImproperIntegralAtTopExcept f k S I ↔
        IsFiniteExceptionalPrimitive f k S F ∧ Tendsto F atTop (nhds I) :=
      hasImproperIntegralAtTopExcept_iff_exists_primitive
  trivial
```

The patched T08 `Basic.lean` hash is
`2d12d556ee52c0a5924b409b60a2b794f1ca46fee19e4b26b1cdc4b85cf1b5fa`,
and the guard hash is
`24187270c6cb444de8387d6de50b2c7ba0bbcc474ef04ae4a67a2e5fab021983`.
The exact strengthened run was:

```bash
set -e
MUTANT_ROOT=/workspace/Documents/Codex/imp-r6-negative-fix.XT854T/mutants/t08
TOOL_LEAN=/home/codex/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean
PIN_LEAN_PATH="$MUTANT_ROOT:$(lake env printenv LEAN_PATH)"
env LEAN_PATH="$PIN_LEAN_PATH" "$TOOL_LEAN" -R "$MUTANT_ROOT" \
  -o "$MUTANT_ROOT/LMLF/Integral/Improper/Basic.olean" \
  "$MUTANT_ROOT/LMLF/Integral/Improper/Basic.lean"
set +e
MUTANT_OUTPUT="$(env LEAN_PATH="$PIN_LEAN_PATH" "$TOOL_LEAN" \
  -R "$MUTANT_ROOT" "$MUTANT_ROOT/Guard.lean" 2>&1)"
GUARD_STATUS=$?
set -e
printf '%s\n' "$MUTANT_OUTPUT"
printf 'T08 mutant guard exit: %s\n' "$GUARD_STATUS"
test "$GUARD_STATUS" -eq 1
printf '%s\n' "$MUTANT_OUTPUT" |
  rg -F 'succeeded but was expected to fail:'
```

The mutant signature module returned exit 0. The guard returned exactly 1,
and the fixed-string assertion matched this diagnostic:

```text
/workspace/Documents/Codex/imp-r6-negative-fix.XT854T/mutants/t08/Guard.lean:12:2: error: The tactic provided to `fail_if_success` succeeded but was expected to fail:
  have hbad :
      HasImproperIntegralAtTopExcept f k S I ↔ IsFiniteExceptionalPrimitive f k S F ∧ Tendsto F atTop (nhds I) :=
      hasImproperIntegralAtTopExcept_iff_exists_primitive
```

Finally, the same two complete guard sources were compiled with the valid
harness root first in `LEAN_PATH`; both returned exit 0 (with unused-binder
style warnings only):

```bash
set -e
VALID_ROOT=/workspace/Documents/Codex/imp-r6-negative-fix.XT854T
TOOL_LEAN=/home/codex/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean
PIN_LEAN_PATH="$VALID_ROOT:$(lake env printenv LEAN_PATH)"
env LEAN_PATH="$PIN_LEAN_PATH" "$TOOL_LEAN" -R "$VALID_ROOT/mutants/t07" \
  "$VALID_ROOT/mutants/t07/Guard.lean"
env LEAN_PATH="$PIN_LEAN_PATH" "$TOOL_LEAN" -R "$VALID_ROOT/mutants/t08" \
  "$VALID_ROOT/mutants/t08/Guard.lean"
```

Thus each corrected guard passes against the valid signature and fails against
only its isolated prohibited type-shape mutant because the intended typed
`have` becomes elaborable. This is sensitivity evidence, not a mathematical
counterexample proof.

### Exact local compile commands

Starting in `/workspace/Documents/Codex/2026-09-05/yo`, after assembling the
five files under the stated disposable root, the final successful run was:

```bash
set -e
HARNESS_ROOT=/workspace/Documents/Codex/imp-r6-negative-fix.XT854T
TOOL_LEAN=/home/codex/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean
PIN_LEAN_PATH="$HARNESS_ROOT:$(lake env printenv LEAN_PATH)"

env LEAN_PATH="$PIN_LEAN_PATH" "$TOOL_LEAN" -R "$HARNESS_ROOT" \
  -o "$HARNESS_ROOT/LMLF/Integral/Improper/Basic.olean" \
  "$HARNESS_ROOT/LMLF/Integral/Improper/Basic.lean"
env LEAN_PATH="$PIN_LEAN_PATH" "$TOOL_LEAN" -R "$HARNESS_ROOT" \
  -o "$HARNESS_ROOT/LMLF/Integral/Improper/Bochner.olean" \
  "$HARNESS_ROOT/LMLF/Integral/Improper/Bochner.lean"
env LEAN_PATH="$PIN_LEAN_PATH" "$TOOL_LEAN" -R "$HARNESS_ROOT" \
  -o "$HARNESS_ROOT/LMLF/Integral/Improper/Abel.olean" \
  "$HARNESS_ROOT/LMLF/Integral/Improper/Abel.lean"
env LEAN_PATH="$PIN_LEAN_PATH" "$TOOL_LEAN" -R "$HARNESS_ROOT" \
  "$HARNESS_ROOT/Check.lean"
env LEAN_PATH="$PIN_LEAN_PATH" "$TOOL_LEAN" -R "$HARNESS_ROOT" \
  "$HARNESS_ROOT/Regressions.lean"
```

The three module compilations, eight-name check, and consumer regressions all
returned exit code zero. `Regressions.lean` emitted only the style linter
warnings already disclosed in the evidence table; there was no elaboration
error. The SHA-256 rows above bind these exact reconstructed sources.
