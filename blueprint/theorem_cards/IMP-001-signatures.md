# IMP-001 exact Lean signature proposal

## Status and authority

| Field | Value |
|---|---|
| Work item | `IMP-001` |
| Artifact role | exact-signature proposal after the revision-3 proof quorum |
| Registry status | unregistered |
| Manifest status | planning only |
| Signature status | frozen for exact-byte signature review |
| Theorem-card status | changes requested until these signatures receive independent API review and are bound by a new card revision |
| Lean implementation | not started |
| `lean_ready` | false |
| Source coverage | none; reusable infrastructure only |

Here, “frozen for exact-byte signature review” applies only to this proposal.
It does not freeze or approve the revision-3 theorem card, authorize proof
implementation, register `IMP-001`, or admit it to an execution manifest. A
change to any binder, type, representation clause, import, or target count
requires a new signature-artifact revision and fresh review.

## Frozen inputs and proof-quorum check

The design input is the exact candidate commit
`78b9579d05e03ae30436c5632c4e38c32c0da09e`.

| Input | SHA-256 | Disposition |
|---|---|---|
| `blueprint/theorem_cards/IMP-001.yaml` at the candidate commit | `35cb365a0de0492ddc7d6a62e66734400f92c7b79434afa08d9ea1ab2033dcb2` | revision-3 card; changes requested solely because this artifact did not yet exist |
| `blueprint/proofs/IMP-001.md` at the candidate commit | `d97bd16bbdffeeaa34c2560111f38c714e91e09458d2fb3381535029ca4d431c` | complete revision-3 natural-language proof |
| external `imp_r3_referee_f.md` | `2bb328d81b15e144d1854037e6e111a63243755ad4c20de40a2d8bd344a0639e` | approves the unchanged proof and the required structural perspectives |
| external `imp_r3_referee_g.md` | `8fe3b4419ec5b1315e08a9d2700b13e48ee1b5ced63c840534b118322a3742b9` | independently approves the unchanged proof and the required structural perspectives |

Only referee reports F and G are used for the proof quorum. The contaminated
report E is not an input to this artifact. Both accepted reports say that
their theorem-card verdict remains `REQUEST_CHANGES` until exact signatures
receive their own review; neither report supplies `lean_ready` authorization.
The verified external files are
`/workspace/Documents/Codex/2026-09-05/LMLF-review-evidence/spec-78b9579d05e03ae30436c5632c4e38c32c0da09e/imp_r3_referee_f.md`
and the sibling `imp_r3_referee_g.md`.

The toolchain and dependency pins are:

- Lean `4.33.1`, toolchain `leanprover/lean4:v4.33.1`;
- Mathlib commit `0df444a360eaa60ab8c11dca51a86af692955474`;
- frozen `lake-manifest.json` SHA-256
  `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`.

## Module and import boundary

The proposed production split is exactly:

```lean
-- LMLF/Integral/Improper/Basic.lean
import Mathlib.Data.Finset.Sort
import Mathlib.MeasureTheory.Integral.DominatedConvergence
```

`Basic` owns T01--T05 and all private sorting, component, anchor-independence,
regular-point-insertion, and endpoint-limit helpers. The dominated-convergence
import is the narrow defining import of the pinned continuity theorem for
variable-endpoint interval-integral primitives used by the insertion proof; it
already imports the interval-integral basics.

```lean
-- LMLF/Integral/Improper/Abel.lean
import LMLF.Integral.Improper.Basic
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
import Mathlib.MeasureTheory.Integral.Prod
```

`Abel` owns only T06 and private finite-triangle/Fubini and scalar-exponential
helpers. Dependency direction is `Basic -> Abel -> QL-001`; neither module may
import QL, Olver, Gamma, QB, DEF, source-recovery, audit, or tactic modules.
There is no umbrella `Mathlib` import.

## Exact private representation underlying T01

These helpers are module-private and do not increase the public target count.
They structurally recurse over the canonical increasing list
`S.sort (· ≤ ·)`.
Existential anchors are proof witnesses only; no improper value function is
defined by choice. The two endpoint limits in each bounded component occur as
two different `Tendsto` propositions, and the final component has a separate
right-side limit and `atTop` limit.

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

For `S = ∅`, the representation is exactly compact
`IntervalIntegrable` evidence plus the direct `atTop` limit. For nonempty
`S`, the head clause supplies the left limit at the first exception, each
recursive bounded clause supplies independent right-at-`c` and left-at-`d`
limits, and the terminal clause supplies the independent right-at-the-last-
exception and infinity limits. No paired cutoff or principal-value limit
appears. The strict anchor inequalities make every one-sided filter used by
the proof nontrivial. The separate proof of anchor independence in
`NLP-IMP-001-R3` makes existential anchor choice semantically immaterial.

## Exactly six public declarations

The production declaration kinds are two definitions, T01 and T05, and four
theorems, T02--T04 and T06. The following is the exact compiled signature
harness. `axiom` is used only in the disposable harness in place of the four
future theorem proof bodies; no axiom is proposed for repository code. Apart
from replacing those four `axiom` keywords by `theorem` and supplying reviewed
proofs, their binders and result types must remain byte-for-byte equivalent.

### `LMLF.Integral.Improper.Basic`

```lean
/-- IMP-001-T01. -/
def HasImproperIntegralAtTopExcept
    [CompleteSpace E] (f : ℝ → E) (k : ℝ) (S : Finset ℝ) (I : E) : Prop :=
  (∀ c ∈ S, k < c) ∧
    HasImproperIntegralAtTopBreaks f k (S.sort (· ≤ ·)) I

/-- IMP-001-T02. -/
axiom HasImproperIntegralAtTopExcept.unique
    [CompleteSpace E] {f : ℝ → E} {k : ℝ} {S : Finset ℝ} {I J : E}
    (hI : HasImproperIntegralAtTopExcept f k S I)
    (hJ : HasImproperIntegralAtTopExcept f k S J) : I = J

/-- IMP-001-T03. -/
axiom HasImproperIntegralAtTopExcept.finset_clm
    [CompleteSpace E] {A : Type*} (s : Finset A) (f : A → ℝ → E)
    (S : A → Finset ℝ) (I : A → E) (T : A → E →L[ℝ] E) {k : ℝ}
    (h : ∀ i ∈ s, HasImproperIntegralAtTopExcept (f i) k (S i) (I i)) :
    HasImproperIntegralAtTopExcept
      (fun t => ∑ i ∈ s, T i (f i t)) k (s.biUnion S) (∑ i ∈ s, T i (I i))

/-- IMP-001-T04. -/
axiom HasImproperIntegralAtTopExcept.split_regular
    [CompleteSpace E] (f : ℝ → E) {a k : ℝ} (S : Finset ℝ) (I : E)
    (hak : a ≤ k) (hS : ∀ c ∈ S, k < c)
    (hf : IntervalIntegrable f volume a k) :
    HasImproperIntegralAtTopExcept f a S ((∫ t in a..k, f t) + I) ↔
      HasImproperIntegralAtTopExcept f k S I

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
```

### `LMLF.Integral.Improper.Abel`

```lean
open MeasureTheory Set
open scoped Interval

noncomputable section

namespace LMLF.Integral

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- IMP-001-T06. -/
axiom intervalIntegral_exp_smul_eq_of_integral_eq_sub
    [CompleteSpace E] (g F : ℝ → E) {a b : ℝ} (h : ℝ)
    (hab : a ≤ b) (hg : IntervalIntegrable g volume a b)
    (hF : ContinuousOn F (Icc a b))
    (hinc : ∀ t ∈ Icc a b, F t - F a = ∫ v in a..t, g v) :
    (∫ t in a..b, Real.exp (-h * t) • g t) =
      Real.exp (-h * b) • F b - Real.exp (-h * a) • F a +
        h • (∫ t in a..b, Real.exp (-h * t) • F t)
```

No public constructor, projection, anchor, sorted-list helper, regular-point
insertion lemma, finite-exception Abel composition theorem, whole-set bridge,
or improper-value function is added. Those are either private proof plumbing
or explicitly outside the revision-3 packet.

## Target-to-contract map

| Target | Exact role and preserved constraint |
|---|---|
| T01 | The argument order is `E, f, k, S, I`; `S : Finset ℝ` is explicitly above `k`; every regular compact piece is honestly `IntervalIntegrable`; each exceptional side and infinity has its own limit; `S = ∅` is direct. |
| T02 | Two witnesses for exactly the same `f`, `k`, and `S` imply equality of explicit proposed values; no choice-selected value function is introduced. |
| T03 | All summands share `k`, retain individual `S i`, and conclude on the literal finite union `s.biUnion S`; the integrand and value are the matching finite sums of continuous real-linear images. The same `E` on both sides preserves the reviewed target rather than adding unreviewed codomain generality. |
| T04 | `a ≤ k` and `IntervalIntegrable f volume a k` are explicit; `hS` ensures the same `S` is above the new tail start `k`; the left value is exactly `(intervalIntegral f a k) + I`, in that order and orientation. |
| T05 | The predicate contains only `S` above `k`, `ContinuousOn F (Ici k)`, `F k = 0`, and, on every closed `S`-free regular piece, both `IntervalIntegrable` and the increment identity. It contains no bound, limit at infinity, target weight, or target integral. |
| T06 | The theorem assumes `a ≤ b`, finite-piece integrability, continuity, and the increment law for every `t ∈ Icc a b`. It assumes no pointwise derivative, absolute continuity, global `StronglyMeasurable`, exceptional set, infinity limit, or quantitative bound. The all-point law includes `t = b`; `a = b` and `h = 0` remain in scope. |

For T06, the proof must derive, rather than expose publicly, the exact Fubini
premise

```lean
MeasureTheory.Integrable (Function.uncurry H)
  ((volume.restrict (Set.uIoc a b)).prod
    (volume.restrict (Set.uIoc a b)))
```

and only the corresponding measure-local `AEStronglyMeasurable` fact. Adding
`StronglyMeasurable g` to T06 is a forbidden signature strengthening.

## Disposable compile evidence

The signature harness was compiled at `2026-09-06T02:43:00Z` in the disposable
directory `/tmp/lmlf-imp-signatures-8sMxp3`. It contained no proof
implementation: T01 and T05 used the exact displayed definition bodies, and
T02--T04/T06 used temporary `axiom` declarations with the exact proposed
types.

| Harness file | SHA-256 | Lines | Result |
|---|---|---:|---|
| `LMLF/Integral/Improper/Basic.lean` | `944b9d9c76da61964bb7f3fd0b5c3db4ac57a186627b76d4775b1e0f85d9f9ea` | 82 | exit 0 |
| `LMLF/Integral/Improper/Abel.lean` | `522f36fa88ea7b721d325adc88dcc7a81276bc58129a9a18c83a3ef83965c111` | 25 | exit 0 |
| `Check.lean` importing `Abel` and checking all six names | `910ef61988215a9c38bb7339d43ec63574b613d199335292d0d1abee579630ed` | 8 | exit 0 |

`Basic.lean` was compiled first to the module path
`LMLF/Integral/Improper/Basic.olean`; `Abel.lean` then compiled while importing
that object and the three displayed Mathlib modules. Finally, `Check.lean`
imported only `LMLF.Integral.Improper.Abel` and resolved all six declarations.
The printed types retained `[CompleteSpace E]` on every public declaration and
confirmed the exact T03 union and T04/T06 orientations. No warning, error, or
repository Lean file was produced.

## Remaining risks and next gate

1. The private recursive representation is intentionally concrete. Its proof
   implementation still has nontrivial anchor-independence and four-position
   regular-insertion bookkeeping. A proof obstruction requires a versioned
   signature revision, not an unreviewed representation swap.
2. T03 deliberately targets `E →L[ℝ] E`, not a more general output space.
   This exactly matches the reviewed packet and handles fixed complex
   multiplication by viewing `ℂ` as a real normed space. Generalizing the
   codomain is deferred until a reviewed consumer requires it.
3. The most fragile proof obligation is T06's integrability and
   `AEStronglyMeasurable` argument under the exact restricted product measure.
   The signature correctly does not export that plumbing or strengthen it to
   global measurability.
4. The compile harness checks elaboration, binder inference, imports, and
   namespace resolution only. Temporary axioms are not evidence that any Lean
   proof has been implemented.
5. Independent reviewers must now review these exact bytes for semantic
   fidelity, API shape, target count, import closure, and downstream QL-001
   usability. A later theorem-card revision must bind the accepted artifact
   digest. Registry reconciliation, an external `lean_ready` envelope, and a
   separate implementation authorization remain mandatory.

Until all of those gates pass, `IMP-001` remains planning-only, unregistered,
and not `lean_ready`.
