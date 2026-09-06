# QB-001 pre-Lean referee report — exact commit d0aa1c5

## Identity and verdict

- Work item: `QB-001`
- Specification commit: `d0aa1c55967d7cde7187f5c8b7a05b76d7043fe5`
- Git tree: `399f98c79ccf07cf35ac1c92a8d74edb3b29db46`
- Reviewer ID: `qb_d0_referee_g`
- Reviewer kind: `agent`
- Model: `gpt-5.6-sol`
- Review stage: `pre_lean`
- Issued UTC: `2026-09-05T18:04:38Z`

Verdicts:

| Gate or classification | This referee's verdict | Reason |
|---|---|---|
| Theorem-card review | **APPROVE** | The frozen target is coherent, exactly bounded to three definitions and five lemmas, correctly classified, and its exact signatures compile at the dependency pin. |
| Natural-language-proof review | **APPROVE** | The proof plan reaches all five lemmas directly, with correct domains, inequality directions, intermediate function, additive constant, and precomposition hypothesis. |
| Structural circularity review | **CONFIRM `not_applicable`** | There is no named-object identification, construction/continuation, existence/uniqueness route, choice, or theorem-sized hypothesis capable of containing the desired conclusions. |
| `lean_ready` | **NOT SET** | The substantive prerequisites support an external `lean_ready` decision. The external envelope must still bind this report and verify the required distinct-reviewer quorums; this single referee report cannot set the composite gate. |

No actionable mathematical, signature, scope, classification, dependency, or trust finding was found.

## Isolation

Isolation strength is `manual_attestation`, not `technically_enforced`. I read the `referee-lean-proof` skill and its complete local rubric, then created a fresh disposable archive with `git archive` from the exact commit. All review and Lean compilation occurred under:

`/tmp/qb-d0-referee-g.QEBvXu`

The supplied checkout contained pre-existing/concurrent dirty paths. The archive excluded them. I did not read the untracked `LMLF/Audit/` or `LMLF/Definitions/` prototypes and made no repository edit. I did not read the historical report; I only computed its bytes' ordinary SHA-256 because the work packet binds that digest with `authority: none` and `counts_toward_quorum: false`.

Environment:

- Linux x86_64, kernel `5.15.0-190-generic`
- Git `2.39.5`
- GNU coreutils `sha256sum` `9.1`
- Lean `4.33.1`, commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`
- Lake `5.0.0-src+819816b`
- Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`

## Artifact/revision and ordinary SHA-256 binding audit

The artifact revisions are exactly packet revision 3, card revision 6, proof revision 5, signatures revision 2, and classification artifact revision 2. All ordinary SHA-256 bindings encountered in the selected artifacts, including the classification schema's superseded-v1 binding, match:

| Artifact | Expected | Observed | Result |
|---|---|---|---|
| `review/classifications-v1.yaml` (bound by v2 schema) | `7a4f322bb56dbb40d5d44a7eceb50b5a49ea6ae69f414b920341e3b12ea9d71e` | same | match |
| `review/classifications-v2.json` | `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9` | same | match |
| `blueprint/proofs/QB-001.md` (source snapshot and NLP binding) | `167629f117dc0609809162b5a5247d05e0c9a193d96b84d9cda5247e930ecd4c` | same | match |
| `blueprint/theorem_cards/QB-001.yaml` | `7e83195fd3b6ff9ea884e29f6d857a4673c9de5fe44327d914e595e6b798468f` | same | match |
| `blueprint/theorem_cards/QB-001-signatures.md` | `93e4e30a93087de95342abdb1e986676924cd93512e771737d0d3f3ed7973b39` | same | match |
| `blueprint/reviews/QB-001-rev3.md` (hash only; non-quorum) | `4b0e8157ebaeb5101916154515094dc82ddffbace4b753ba8b892877cc0df055` | same | match |

The packet deliberately has no self-digest. Its observed external-binding digest is:

`review/work_packets/QB-001.yaml` = `6eaeea14a581d4b60c7933afb2c9bb24a633df135a935b7c7e4af11c9845cf87`

## Independent mathematical re-derivation

Exactly the three frozen definitions were re-derived:

1. `ErrorOn D f a b` is `∀ x ∈ D, ‖f x - a x‖ ≤ b x`.
2. `NormBoundOn D f b` is `∀ x ∈ D, ‖f x‖ ≤ b x`.
3. `HasErrorFamily f a D b` is `∀ n : ℕ, ErrorOn (D n) f (a n) (b n)`.

Exactly the five frozen lemmas were then derived:

1. `ErrorOn.exact`: for `x ∈ D`, `Set.EqOn f a D` gives `f x = a x`; hence the remainder and its norm are zero.
2. `ErrorOn.restrict`: for `x ∈ D'`, the hypothesis `D' ⊆ D` supplies `x ∈ D`, so the original pointwise estimate applies.
3. `ErrorOn.weaken`: concatenate `‖f x-a x‖ ≤ b x` with the on-domain comparison `b x ≤ d x`.
4. `ErrorOn.trans`: use the exact identity `f x-c x = (f x-a x)+(a x-c x)`, the triangle inequality, and `add_le_add`; the result is exactly `b x+d x`.
5. `ErrorOn.comp`: for `y ∈ S`, `Set.MapsTo ψ S D` gives `ψ y ∈ D`; apply the original estimate at `ψ y` and unfold all three compositions.

### Adversarial semantic checks

- Binders/typeclasses: the compiled types contain only arbitrary `Type*` domains and `[NormedAddCommGroup E]`. There is no hidden `Nonempty`, decidability, topology, measurability, continuity, or additional scalar-space instance. Unused `Y` is absent from all declarations except `comp`. `NormedAddCommGroup` is a coherent common boundary for this error calculus, although some individual declarations could be generalized in isolation.
- Empty/arbitrary domains: all three predicates are meaningful on arbitrary sets; `ErrorOn ∅ f a b` and `NormBoundOn ∅ f b` are vacuous. No concrete-source nonemptiness claim is made, so the packet's `nonempty_witness` treatment is correct.
- `EqOn`: the hypothesis is equality only at members of `D`, exactly what the forward zero-error theorem needs. It neither assumes global equality nor proves the excluded converse.
- Restriction direction: `D' ⊆ D` is necessary. On `X = Unit`, a bound on `D' = ∅` need not extend to `D = univ`; take `f=1`, `a=0`, `b=0`.
- Weakening direction: `b ≤ d` on `D` is necessary. On `Unit`, error `1` is bounded by `b=1` but not by `d=0`; knowing `d ≤ b` would go the wrong way.
- Transitive constant: `b+d` follows with no extra sign premise, because each premise already forces its own majorant nonnegative on `D`. It is sharp in the elementary sense that on `Unit`, `f=2`, `a=1`, `c=0`, and `b=d=1` satisfy both premises while a replacement by `max b d = 1` fails.
- Precomposition: `MapsTo ψ S D` is exactly the needed direction and no injectivity/surjectivity/regularity is required. Without it, take `D=∅`, `S=univ`, `f=1`, `a=0`, `b=0`; the premise is vacuous but the pullback bound fails.
- Fixed target/no convergence: `f` lies outside the `∀ n`; only `a n`, `D n`, and `b n` vary. For example, `f=0`, `a n=1`, `D n=univ`, `b n=1` on `Unit → ℝ` satisfies `HasErrorFamily` at every order while the approximants remain constantly one. Thus the definition implies no convergence, monotonic improvement, expansion structure, or cross-index compatibility.

## Scope and prospective dossier material

The packet target list, card public-declaration list, and signature artifact agree on exactly eight declarations and explicitly deny a ninth. The source mapping selects the three definitions plus ErrorOn restriction, weakening, transitivity, forward exactness only, and precomposition. All other dossier statements are excluded by the card's freeze rule and the packet's blanket exclusion of every other discussed result.

In particular, this audit grants no authorization for the preliminary nonnegativity consequence as a public theorem; `NormBoundOn` transports; combined restriction/weakening or intersection variants; symmetry; exactness converses/equivalences and predicate conversions; congruence; addition/subtraction/negation; scalar multiplication; finite sums; minimum; products/biadditive estimates; or any `HasErrorFamily` wrapper. The dossier's discussion of those results does not enlarge the manifest.

The target classifications also match the frozen v2 vocabulary: the first three are `definition`, the five lemmas are `generic_quantitative`, all eight are `reusable_infrastructure` and `non_novel`, and the packet is `foundational_calculus` / `infrastructure` / `non_novel`. No internal dossier is misused as evidence of `source_equivalent` coverage.

## Exact compiled types

The audit file contains only `import LMLF.Basic`, the three definition bodies, the five independently supplied proof bodies, `#check` commands, and `#print axioms` commands. Lean printed:

```text
QuantitativeAnalysis.ErrorOn.{u_1, u_3} {X : Type u_1} {E : Type u_3} [NormedAddCommGroup E] (D : Set X) (f a : X → E)
  (b : X → ℝ) : Prop
QuantitativeAnalysis.NormBoundOn.{u_1, u_3} {X : Type u_1} {E : Type u_3} [NormedAddCommGroup E] (D : Set X) (f : X → E)
  (b : X → ℝ) : Prop
QuantitativeAnalysis.HasErrorFamily.{u_1, u_3} {X : Type u_1} {E : Type u_3} [NormedAddCommGroup E] (f : X → E)
  (a : ℕ → X → E) (D : ℕ → Set X) (b : ℕ → X → ℝ) : Prop
QuantitativeAnalysis.ErrorOn.exact.{u_1, u_3} {X : Type u_1} {E : Type u_3} [NormedAddCommGroup E] {D : Set X}
  {f a : X → E} (h : Set.EqOn f a D) : ErrorOn D f a fun x => 0
QuantitativeAnalysis.ErrorOn.restrict.{u_1, u_3} {X : Type u_1} {E : Type u_3} [NormedAddCommGroup E] {D D' : Set X}
  {f a : X → E} {b : X → ℝ} (h : ErrorOn D f a b) (hD : D' ⊆ D) : ErrorOn D' f a b
QuantitativeAnalysis.ErrorOn.weaken.{u_1, u_3} {X : Type u_1} {E : Type u_3} [NormedAddCommGroup E] {D : Set X}
  {f a : X → E} {b d : X → ℝ} (h : ErrorOn D f a b) (hbd : ∀ x ∈ D, b x ≤ d x) : ErrorOn D f a d
QuantitativeAnalysis.ErrorOn.trans.{u_1, u_3} {X : Type u_1} {E : Type u_3} [NormedAddCommGroup E] {D : Set X}
  {f a c : X → E} {b d : X → ℝ} (hfa : ErrorOn D f a b) (hac : ErrorOn D a c d) : ErrorOn D f c fun x => b x + d x
QuantitativeAnalysis.ErrorOn.comp.{u_1, u_2, u_3} {X : Type u_1} {Y : Type u_2} {E : Type u_3} [NormedAddCommGroup E]
  {D : Set X} {f a : X → E} {b : X → ℝ} (h : ErrorOn D f a b) {S : Set Y} (ψ : Y → X) (hψ : Set.MapsTo ψ S D) :
  ErrorOn S (f ∘ ψ) (a ∘ ψ) (b ∘ ψ)
```

These match the frozen declaration order, binder order, plicity, namespace, and conclusions.

## Axiom report

Lean printed the following for each declaration:

```text
'QuantitativeAnalysis.ErrorOn' depends on axioms: [propext, Classical.choice, Quot.sound]
'QuantitativeAnalysis.NormBoundOn' depends on axioms: [propext, Classical.choice, Quot.sound]
'QuantitativeAnalysis.HasErrorFamily' depends on axioms: [propext, Classical.choice, Quot.sound]
'QuantitativeAnalysis.ErrorOn.exact' depends on axioms: [propext, Classical.choice, Quot.sound]
'QuantitativeAnalysis.ErrorOn.restrict' depends on axioms: [propext, Classical.choice, Quot.sound]
'QuantitativeAnalysis.ErrorOn.weaken' depends on axioms: [propext, Classical.choice, Quot.sound]
'QuantitativeAnalysis.ErrorOn.trans' depends on axioms: [propext, Classical.choice, Quot.sound]
'QuantitativeAnalysis.ErrorOn.comp' depends on axioms: [propext, Classical.choice, Quot.sound]
```

This is exactly within the packet allowlist. The final scratch source has no `sorry`, `admit`, `axiom`, `unsafe`, heartbeat override, or recursion-depth override. A first discarded proof experiment used a bare `norm_zero.le` after rewriting `EqOn`; Lean correctly rejected it because the normed type metavariable was no longer inferable. Replacing that scratch line with the explicitly contextual simplification `simp [h hx]` produced a clean proof. This was an audit-harness elaboration issue, not a defect in any frozen signature.

## Commands and outcomes

Representative exact commands (run in the disposable archive unless a path says otherwise):

```sh
git -C /home/codex/Documents/Codex/2026-09-05/yo rev-parse HEAD
audit_dir=$(mktemp -d /tmp/qb-d0-referee-g.XXXXXX)
git -C /home/codex/Documents/Codex/2026-09-05/yo archive d0aa1c55967d7cde7187f5c8b7a05b76d7043fe5 | tar -x -C "$audit_dir"

sha256sum review/classifications-v1.yaml review/classifications-v2.json \
  blueprint/proofs/QB-001.md blueprint/theorem_cards/QB-001.yaml \
  blueprint/theorem_cards/QB-001-signatures.md \
  blueprint/reviews/QB-001-rev3.md review/work_packets/QB-001.yaml

git -C .lake/packages/mathlib rev-parse HEAD
lake --version
lake env lean --version
lake build LMLF.Basic
lake env lean QB001SignatureAudit.lean
/home/codex/.codex/skills/referee-lean-proof/scripts/check_lean_file.sh QB001SignatureAudit.lean
rg -n '^import ' QB001SignatureAudit.lean LMLF/Basic.lean
rg -n '\b(sorry|admit|axiom|unsafe)\b' QB001SignatureAudit.lean
```

Outcomes:

- `lake build LMLF.Basic`: success, 1321 jobs in the fresh archive.
- Final `lake env lean QB001SignatureAudit.lean`: exit 0.
- Deterministic skill preflight: exit 0; 75 lines; exactly 3 `def` and 5 `theorem` declarations; elapsed 1.614 seconds.
- Audit scratch SHA-256: `9753464d92b09697901075930f86d46451e0fddd0c8f7c8f69ab0dd3ac65e86d`.
- Imports: audit scratch imports only `LMLF.Basic`; that module imports `Mathlib.Analysis.Normed.Group.Basic`.

## External gate conclusion

This referee approves both required pre-Lean subjects and confirms the structural-review N/A classification. The frozen content and dependency pin are suitable inputs to an external `lean_ready` adjudication. The adjudicator must still verify the packet/envelope binding, count this as only one durable reviewer ID, satisfy the two-distinct-reviewer compositions for both required gates, and record structural circularity as `not_required`. I do not set `lean_ready` here.
