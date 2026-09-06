# QB-001 independent pre-Lean referee report

## Verdict

- **Theorem-card gate: APPROVE.**
- **Natural-language-proof gate: APPROVE.**
- **Structural-circularity gate: N/A confirmed.** The frozen packet's
  `not_applicable` classification is justified; an external envelope must record
  this gate as `not_required`.
- **Lean-readiness prerequisites: content and dependency prerequisites confirmed
  by this referee, but `lean_ready` is not set here.** This report is one
  independent referee record. The external envelope must bind the exact packet
  and artifacts, aggregate the required second distinct reviewer, establish the
  composite gate states, and alone authorize implementation.

No actionable P0--P3 finding was found.

## Review identity and isolation

- Work item: `QB-001`
- Reviewer ID: `qb_final_referee_c`
- Reviewer kind: agent
- Model: `gpt-5.6-sol`
- Review stage: `pre_lean`
- Review time: `2026-09-05T17:29:38Z`
- Exact specification commit:
  `f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de`
- Isolation strength: `manual_attestation`
- Isolation method: I created a new disposable directory with `mktemp -d` and
  populated it only with `git archive` of
  `f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de`. All specification inspection,
  dependency resolution, fixture generation, and compilation occurred in that
  archive. I did not inspect the historical QB-001 review report, external
  referee reports, dirty tracked changes, or untracked repository content. I
  made no change to the candidate repository. The generated fixture and build
  products existed only in the disposable archive.
- Referee rubric: the complete `referee-lean-proof` skill, including
  `local-rubric.md` and `lsp-playbook.md`, was read before the audit. No Lean
  LSP endpoint was available in this session, so exact compiler elaboration,
  `#check`, and `#print axioms` supplied the declaration and trust evidence.

## Frozen artifact binding

| Artifact | Required revision | Observed SHA-256 | Result |
|---|---:|---|---|
| `review/work_packets/QB-001.yaml` | 2 | `fb4942e10968e9bb53badb9352e668bd5460d6c482c27ea678cc72175ea9a86a` | frozen; exact packet reviewed |
| `blueprint/theorem_cards/QB-001.yaml` | 5 | `de0ed8cae076e7dfe074b4eacc0e5a8875e245c1ddedf8230851bbfd920f0ce4` | matches packet |
| `blueprint/theorem_cards/QB-001-signatures.md` | 2 | `93e4e30a93087de95342abdb1e986676924cd93512e771737d0d3f3ed7973b39` | matches packet |
| `blueprint/proofs/QB-001.md` | 4 | `3513fb1acf141066eb9a4920c1ea238c778d66976ff8479d31c742df93d3a2a5` | matches packet/source snapshot |
| `review/classifications-v2.json` | `lmlf-classification-v2` | `698626606570827fcc8c78b69865d7cd4bc94de96bc6d5d45c23a5f6611aeeab` | matches packet and card |

The packet deliberately has no self-path, self-commit, or self-digest. This
report supplies the external exact-commit and packet-digest binding without
modifying frozen content.

The toolchain declaration is `leanprover/lean4:v4.33.1`. The manifest requests
Mathlib `v4.33.1` and resolves it to
`0df444a360eaa60ab8c11dca51a86af692955474`. The disposable environment
reported Lean 4.33.1 (Lean commit
`819816b2e0a3bf405af45ae5c7af2491d8f5bee6`) and the checked-out Mathlib
repository reported exactly the resolved commit. `lake update` left the
manifest digest at
`4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`.

## Scope and classification audit

The controlling scope is exactly three definitions and five `ErrorOn`
transport theorems, in the order frozen by signature artifact revision 2. No
ninth public declaration is authorized. The theorem card, work packet, and
signature artifact agree on names, module, namespace, import layer, binder
order, and conclusions.

The packet summary values are valid and accurate:

- `foundational_calculus` is an allowed packet theorem class and describes the
  small calculus of error predicates.
- `infrastructure` is an allowed packet coverage class; no named/source
  coverage is claimed.
- `non_novel` is appropriate for local definitions and elementary set/order/norm
  consequences and does not misuse the internal dossier as an external source.

At target level, T01--T03 correctly use `definition`; T04--T08 correctly use
`generic_quantitative`. All eight correctly use
`reusable_infrastructure` and `non_novel`. These values occur on their proper
classification axes and imply neither source recovery nor gate authorization.

The natural-language dossier is broader than this bootstrap. The packet's
`scope.included`, `scope.excluded`, exact target list, and signature freeze
resolve that breadth unambiguously: only the three definitions, ErrorOn
restriction, ErrorOn weakening, common-domain ErrorOn transitivity, forward
zero exactness, and ErrorOn precomposition are normative targets. In
particular, the analogous `NormBoundOn` transports, intersection variants,
preimage specialization, converse/equivalence exactness results, symmetry,
congruence, algebraic closure rules, finite sums, minima, products, and
`HasErrorFamily` wrappers in the dossier do not enter QB-001. This audit does
not treat any of them as a ninth declaration or readiness prerequisite.

## Independent derivation of all eight declarations

1. **`ErrorOn`.** For `D : Set X`, `f a : X → E`, and `b : X → ℝ`,
   define the proposition `∀ x ∈ D, ‖f x - a x‖ ≤ b x`. Quantification is only
   over `D`; empty domains are therefore valid and vacuous.
2. **`NormBoundOn`.** Define `∀ x ∈ D, ‖f x‖ ≤ b x`. It is independent of an
   approximant and again imposes nothing outside `D`.
3. **`HasErrorFamily`.** Define
   `∀ n, ErrorOn (D n) f (a n) (b n)`. The target `f` is outside the
   `n`-indexed arguments and is fixed; only `a`, `D`, and `b` vary.
   There is no cross-index relation.
4. **`ErrorOn.exact`.** Given `h : Set.EqOn f a D`, take `x ∈ D`.
   Rewriting by `h x` changes `f x - a x` to zero, so its norm is zero and
   the required zero-majorant inequality is equality.
5. **`ErrorOn.restrict`.** Given `h : ErrorOn D f a b` and
   `hD : D' ⊆ D`, take `x ∈ D'`. Then `hD x` puts `x` in `D`, where
   `h` supplies the same bound. The inclusion direction cannot be reversed.
6. **`ErrorOn.weaken`.** At `x ∈ D`, compose
   `‖f x - a x‖ ≤ b x` with `b x ≤ d x`. Thus the conclusion majorant is
   the larger `d`, and comparison is required only on `D`.
7. **`ErrorOn.trans`.** At `x ∈ D`, use
   `f x - c x = (f x - a x) + (a x - c x)`, the triangle inequality, and
   `add_le_add` on the two premise bounds. The conclusion is exactly
   `b x + d x`; both premises use the same domain and the same intermediate
   function `a`.
8. **`ErrorOn.comp`.** For `y ∈ S`, the hypothesis
   `Set.MapsTo ψ S D` gives `ψ y ∈ D`. Apply `h` at `ψ y`; unfolding
   composition produces exactly `f ∘ ψ`, `a ∘ ψ`, and `b ∘ ψ`. The
   direction `ψ : Y → X` is precomposition/pullback, not unsupported outer
   postcomposition.

## Adversarial checks

### Typeclasses and binders

`NormedAddCommGroup E` supplies subtraction, zero, a genuine norm, and the
triangle inequality used by the eight declarations. It does not add an
unmentioned scalar, ring, completeness, topology, continuity, measurability,
decidability, or nonemptiness premise. Although some individual transport
lemmas could be stated under weaker local structures, the frozen common API
assumption is mathematically sound and introduces no theorem-sized hypothesis.

With `relaxedAutoImplicit = false`, the fixture elaborated the explicit
parameter order as follows:

- all non-composition declarations: implicit `X`, implicit `E`, then the
  `NormedAddCommGroup E` instance, followed by the frozen declaration binders;
- composition: implicit `X`, implicit `Y`, implicit `E`, the instance,
  `D,f,a,b,h,S,ψ,hψ` in the frozen order.

No unused global `Y` leaked into T01--T07, and no hidden binder was synthesized.

### Domains, order, MapsTo, and family semantics

Simple singleton countermodels reject the nearby wrong directions:

- restriction cannot extend from `∅` to `Set.univ`;
- a residual of norm one bounded by `b=1` is not bounded by a smaller `d=0`;
- successive scalar residuals one and one require sum two, so `max b d=1`
  cannot replace `b+d`;
- without `MapsTo ψ S D`, a vacuous estimate on empty `D` cannot be pulled
  back to a nonempty `S`.

The family definition accepts every arbitrary approximant family `a` with the
tautological majorant `b n x = ‖f x - a n x‖`. This independently confirms
that it constrains each order separately, keeps only `f` fixed, and asserts
neither convergence nor monotone improvement. Majorants need not be globally
nonnegative; a satisfied bound forces nonnegativity only on the relevant
domain. None of the five proofs silently uses values outside that domain.

## Lean verification

I generated `QB001Fixture.lean` in the disposable archive. Its first and only
import was exactly:

```lean
import LMLF.Basic
```

The fixture reproduced the eight frozen declarations and signatures, supplied
independently derived proofs, printed all eight axiom dependencies, and printed
the fully explicit elaborated types. There were exactly eight public
`def`/`theorem` commands.

The first fixture invocation was intentionally recorded transparently: before
the archive's local `LMLF.Basic` had been built, Lean reported
`unknown module prefix 'LMLF'`. After `lake build LMLF.Basic`, the same
fixture compiled successfully with exit code 0 and no diagnostics. The final
`lake build` also completed successfully.

For every declaration, `#print axioms` reported exactly:

```text
[propext, Classical.choice, Quot.sound]
```

This equals the packet allowlist. There was no `sorry`, `admit`, custom
`axiom`, `opaque`, `unsafe`, resource override, or extra import in the
fixture.

## Gate analysis

### Theorem-card gate — APPROVE

The exact mathematical targets, quantifiers, domain directions, majorant
orientation/arithmetic, fixed-target family semantics, typeclass assumptions,
dependencies, classifications, and Lean signatures are coherent and correct.
The card is frozen and its scope is exactly bounded by the signature artifact.

### Natural-language-proof gate — APPROVE

The normative proof routes reach all eight targets directly. They do not assume
a target conclusion, use missing infrastructure, hide a domain or sign
condition, confuse fixed and indexed targets, or rely on an excluded theorem.
The additive identity and triangle/order steps for transitivity are sufficient;
all other target proofs are definitional or direct transports.

### Structural-circularity gate — N/A confirmed

The packet introduces transparent predicates and direct consequences of
equality, inclusion, order transitivity, the additive identity, the triangle
inequality, and `Set.MapsTo`. It has no named-function identification,
continuation, existence/uniqueness construction, hidden choice, source-recovery
bridge, or hypothesis object capable of storing the desired conclusion.
Accordingly, the packet's concrete N/A reason is valid.

### Lean readiness — prerequisites confirmed, authorization not set

This referee confirms the frozen identities/digests, dependency pins,
compilability, exact signatures, trust allowlist, classifications, scope, and
three gate judgments above. I do **not** set `lean_ready`. Under the packet and
protocol, the external envelope must still:

1. bind this exact commit, packet path/digest, upstream revisions/digests,
   classification schema, and dependency pins;
2. aggregate at least two distinct reviewer IDs in an allowed composition for
   both required pre-Lean gates and meet the overall distinct-reviewer minimum;
3. record the structural gate as `not_required`;
4. ensure no current pre-Lean verdict is `request_changes` or `block`; and
5. set the composite `lean_ready` state itself.

## Commands recorded

The following commands (with the five `sed` ranges used to read the entire
1,105-line proof artifact) were run. Fixture creation and report creation used
the provided patching tool, not repository writes.

```sh
sed -n '1,260p' /home/codex/.codex/skills/referee-lean-proof/SKILL.md
cat /home/codex/.codex/skills/referee-lean-proof/references/local-rubric.md
cat /home/codex/.codex/skills/referee-lean-proof/references/lsp-playbook.md
review_tmp=$(mktemp -d /tmp/qb-final-referee-c.XXXXXX)
git -C /home/codex/Documents/Codex/2026-09-05/yo archive f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de | tar -x -C "$review_tmp"
rg --files | sort
sed -n '1,320p' review/work_packets/QB-001.yaml
sed -n '321,700p' review/work_packets/QB-001.yaml
cat blueprint/theorem_cards/QB-001.yaml
cat blueprint/theorem_cards/QB-001-signatures.md
sed -n '1,220p' blueprint/proofs/QB-001.md
sed -n '221,440p' blueprint/proofs/QB-001.md
sed -n '441,660p' blueprint/proofs/QB-001.md
sed -n '661,880p' blueprint/proofs/QB-001.md
sed -n '881,1120p' blueprint/proofs/QB-001.md
cat review/classifications-v2.json
sed -n '1,280p' review/PROTOCOL.md
sed -n '281,620p' review/PROTOCOL.md
sha256sum review/work_packets/QB-001.yaml blueprint/theorem_cards/QB-001.yaml blueprint/theorem_cards/QB-001-signatures.md blueprint/proofs/QB-001.md review/classifications-v2.json lean-toolchain lake-manifest.json
git -C /home/codex/Documents/Codex/2026-09-05/yo rev-parse 'f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de^{commit}'
cat lean-toolchain
cat lake-manifest.json
cat lakefile.toml
sed -n '1,260p' LMLF/Basic.lean
rg -n "sub_add_sub_cancel" .lake/packages/mathlib/Mathlib .lake/packages/mathlib/Mathlib.lean
lake --version
lean --version
lake update
lake env lean QB001Fixture.lean
lake build LMLF.Basic
lake env lean QB001Fixture.lean
lean --version
git -C .lake/packages/mathlib rev-parse HEAD
sha256sum lake-manifest.json
sed -n '1,3p' QB001Fixture.lean
rg -n "^(axiom|opaque|unsafe|theorem|def) " QB001Fixture.lean
lake build
date -u +'%Y-%m-%dT%H:%M:%SZ'
```

## Report integrity

The SHA-256 of this finalized Markdown report is recorded externally in the
adjacent `qb_final_referee_c.md.sha256` sidecar and in the referee handoff.
It is necessarily outside the self-hashed report.
