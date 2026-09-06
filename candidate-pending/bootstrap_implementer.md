# BOOTSTRAP-0 proposer evidence: `/root/bootstrap_implementer`

Status: uncommitted candidate implementation, awaiting independent implementation review and
release. This is proposer evidence and is not a review verdict.

## Candidate and specification binding

- Repository: `/home/codex/Documents/Codex/2026-09-05/yo`
- Branch: `main`
- Worktree base / current `HEAD`: `1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9`
- Candidate head SHA: unavailable because the authorized task explicitly forbids committing; the
  candidate is the dirty worktree diff recorded below.
- Lean: `4.33.1`, commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`
- Resolved Mathlib checkout: `0df444a360eaa60ab8c11dca51a86af692955474`
- Proposer ID: `/root/bootstrap_implementer`

The exact frozen sources were read from specification commit
`1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9` before the dirty prototypes were inspected. Their
ordinary SHA-256 digests reproduced as follows:

```text
7a56a1695d15ea2cedd525ee4270d20830e1706827bb592dfde293bcd7d54c39  review/work_packets/QB-001.yaml
6dbda13f4f27dd4c0492c00ecc0a2d184f00fe85fa7096802cf93e9fdecf11e8  review/work_packets/DEF-001.yaml
827522349afc7374a8bec60b3d281c192a44189f8e8c08c24e453bf75e215667  blueprint/theorem_cards/QB-001.yaml
93e4e30a93087de95342abdb1e986676924cd93512e771737d0d3f3ed7973b39  blueprint/theorem_cards/QB-001-signatures.md
42b027310a56ff70f4c56471de527aa9b6a3ac88810ad3ba17029953514c1589  blueprint/proofs/QB-001.md
eff82b06afaa61b67d13c3a399494525ed452e42c203a390ba40e56b93ec9daa  blueprint/theorem_cards/DEF-001.yaml
8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9  review/classifications-v2.json
```

External authorization artifacts:

```text
dbcf16abb033bfc87f353b75125470788c92b28580bf52ffc125bcf0d0a7562a  QB-001-review-envelope.yaml
1cb983db8cb2affdab0d3628df5bcc61ea92006d3739edfa26a9ab5e69c89acf  DEF-001-review-envelope.yaml
f30686bd60e672f46a607d470f697ffa279944d8203d82a881dafe742c546194  prelean_authorization.md
```

All twelve structured verdict records and both supporting reviewer narratives also reproduced the
hashes recorded by the envelopes. The QB envelope records theorem-card `pass`, required
natural-language-proof `pass`, structural `not_required`, and composite `lean_ready: pass`. The
DEF envelope records theorem-card `pass`, natural-language-proof `not_required`, structural
`not_required`, and composite `lean_ready: pass`.

## Changed files

- Added `LMLF/Quantitative/Basic.lean`: exactly the eight frozen QB-001 semantic declarations.
- Added `LMLF/Definitions/Gamma.lean`: exactly the four frozen DEF-001 wrappers around
  `Complex.Gamma`; no second Gamma definition.
- Added `LMLF/Audit/Definitions.lean`: separately built QB regressions and Gamma
  convergence/formula/normalization/real/conjugation/pole consumers.
- Updated `LMLF/Definitions.lean`: imports `LMLF.Definitions.Gamma`.
- Updated `LMLF/Results.lean`: imports `LMLF.Definitions` and `LMLF.Quantitative.Basic`.
- Updated `lakefile.toml`: explicitly lists the root, semantic, and audit modules.
- Updated `README.md`: describes an implemented candidate awaiting implementation review/release.

No frozen blueprint, theorem card, proof, work packet, classification, inventory, validator, CI,
protocol, or rubric file was edited. `LMLF.lean` was not edited and does not import the audit
module.

## Public semantic declarations

QB-001, in frozen order:

1. `QuantitativeAnalysis.ErrorOn`
2. `QuantitativeAnalysis.NormBoundOn`
3. `QuantitativeAnalysis.HasErrorFamily`
4. `QuantitativeAnalysis.ErrorOn.exact`
5. `QuantitativeAnalysis.ErrorOn.restrict`
6. `QuantitativeAnalysis.ErrorOn.weaken`
7. `QuantitativeAnalysis.ErrorOn.trans`
8. `QuantitativeAnalysis.ErrorOn.comp`

DEF-001, in frozen order:

1. `LMLF.Definitions.gamma_eulerIntegrable`
2. `LMLF.Definitions.gamma_eq_eulerIntegral`
3. `LMLF.Definitions.gamma_ofReal`
4. `LMLF.Definitions.gamma_neg_nat_eq_zero`

Source declaration counting found exactly `8` declarations in
`LMLF/Quantitative/Basic.lean` and exactly `4` in `LMLF/Definitions/Gamma.lean`; no extra `def`,
`theorem`, `lemma`, `abbrev`, `structure`, `class`, `instance`, `opaque`, `axiom`, or `inductive`
declaration occurs in either semantic file.

Audit-only declarations are:

- `LMLFTest.QB001.emptyDomain`
- `LMLFTest.QB001.exactZero`
- `LMLFTest.QB001.transSum`
- `LMLFTest.Definitions.Gamma.eulerIntegrable`
- `LMLFTest.Definitions.Gamma.eulerFormula`
- `LMLFTest.Definitions.Gamma.eulerAtOne`
- `LMLFTest.Definitions.Gamma.realAgreement`
- `LMLFTest.Definitions.Gamma.conjugation`
- `LMLFTest.Definitions.Gamma.poleTotalization`

## Signature check transcript

Command: `lake env lean /tmp/lmlf_bootstrap_checks.lean`

The check file imported `LMLF.Results`, issued `#check @...` for all twelve semantic declarations,
and issued `#print axioms ...` for all twelve. Signature output:

```text
@QuantitativeAnalysis.ErrorOn : {X : Type u_1} →
  {E : Type u_2} → [NormedAddCommGroup E] → Set X → (X → E) → (X → E) → (X → ℝ) → Prop
@QuantitativeAnalysis.NormBoundOn : {X : Type u_1} →
  {E : Type u_2} → [NormedAddCommGroup E] → Set X → (X → E) → (X → ℝ) → Prop
@QuantitativeAnalysis.HasErrorFamily : {X : Type u_1} →
  {E : Type u_2} → [NormedAddCommGroup E] → (X → E) → (ℕ → X → E) → (ℕ → Set X) → (ℕ → X → ℝ) → Prop
@QuantitativeAnalysis.ErrorOn.exact : ∀ {X : Type u_1} {E : Type u_2} [inst : NormedAddCommGroup E] {D : Set X}
  {f a : X → E}, Set.EqOn f a D → QuantitativeAnalysis.ErrorOn D f a fun x => 0
@QuantitativeAnalysis.ErrorOn.restrict : ∀ {X : Type u_1} {E : Type u_2} [inst : NormedAddCommGroup E] {D D' : Set X}
  {f a : X → E} {b : X → ℝ}, QuantitativeAnalysis.ErrorOn D f a b → D' ⊆ D → QuantitativeAnalysis.ErrorOn D' f a b
@QuantitativeAnalysis.ErrorOn.weaken : ∀ {X : Type u_1} {E : Type u_2} [inst : NormedAddCommGroup E] {D : Set X}
  {f a : X → E} {b d : X → ℝ},
  QuantitativeAnalysis.ErrorOn D f a b → (∀ x ∈ D, b x ≤ d x) → QuantitativeAnalysis.ErrorOn D f a d
@QuantitativeAnalysis.ErrorOn.trans : ∀ {X : Type u_1} {E : Type u_2} [inst : NormedAddCommGroup E] {D : Set X}
  {f a c : X → E} {b d : X → ℝ},
  QuantitativeAnalysis.ErrorOn D f a b →
    QuantitativeAnalysis.ErrorOn D a c d → QuantitativeAnalysis.ErrorOn D f c fun x => b x + d x
@QuantitativeAnalysis.ErrorOn.comp : ∀ {X : Type u_1} {Y : Type u_2} {E : Type u_3} [inst : NormedAddCommGroup E]
  {D : Set X} {f a : X → E} {b : X → ℝ},
  QuantitativeAnalysis.ErrorOn D f a b →
    ∀ {S : Set Y} (ψ : Y → X), Set.MapsTo ψ S D → QuantitativeAnalysis.ErrorOn S (f ∘ ψ) (a ∘ ψ) (b ∘ ψ)
@LMLF.Definitions.gamma_eulerIntegrable : ∀ {s : ℂ},
  0 < s.re → MeasureTheory.IntegrableOn (fun t => ↑(Real.exp (-t)) * ↑t ^ (s - 1)) (Set.Ioi 0) MeasureTheory.volume
@LMLF.Definitions.gamma_eq_eulerIntegral : ∀ {s : ℂ},
  0 < s.re → Complex.Gamma s = ∫ (t : ℝ) in Set.Ioi 0, ↑(Real.exp (-t)) * ↑t ^ (s - 1)
LMLF.Definitions.gamma_ofReal : ∀ (s : ℝ), Complex.Gamma ↑s = ↑(Real.Gamma s)
LMLF.Definitions.gamma_neg_nat_eq_zero : ∀ (n : ℕ), Complex.Gamma (-↑n) = 0
```

These reproduce the frozen binder order, implicitness, domains, majorants, integral normalization,
real coercions, and exceptional-value statement.

## Axiom report

The complete `#print axioms` output for the twelve public semantic declarations is:

```text
'QuantitativeAnalysis.ErrorOn' depends on axioms: [propext, Classical.choice, Quot.sound]
'QuantitativeAnalysis.NormBoundOn' depends on axioms: [propext, Classical.choice, Quot.sound]
'QuantitativeAnalysis.HasErrorFamily' depends on axioms: [propext, Classical.choice, Quot.sound]
'QuantitativeAnalysis.ErrorOn.exact' depends on axioms: [propext, Classical.choice, Quot.sound]
'QuantitativeAnalysis.ErrorOn.restrict' depends on axioms: [propext, Classical.choice, Quot.sound]
'QuantitativeAnalysis.ErrorOn.weaken' depends on axioms: [propext, Classical.choice, Quot.sound]
'QuantitativeAnalysis.ErrorOn.trans' depends on axioms: [propext, Classical.choice, Quot.sound]
'QuantitativeAnalysis.ErrorOn.comp' depends on axioms: [propext, Classical.choice, Quot.sound]
'LMLF.Definitions.gamma_eulerIntegrable' depends on axioms: [propext, Classical.choice, Quot.sound]
'LMLF.Definitions.gamma_eq_eulerIntegral' depends on axioms: [propext, Classical.choice, Quot.sound]
'LMLF.Definitions.gamma_ofReal' depends on axioms: [propext, Classical.choice, Quot.sound]
'LMLF.Definitions.gamma_neg_nat_eq_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
```

Every reported axiom is on the frozen allowlist; no other axiom appears.

## Verification commands and results

Exact module compiles, run after the clean full build:

```text
$ lake env lean LMLF/Quantitative/Basic.lean
[exit 0; no output]
$ lake env lean LMLF/Definitions/Gamma.lean
[exit 0; no output]
$ lake env lean LMLF/Audit/Definitions.lean
[exit 0; no output]
```

Fresh full build (project-relevant build lines and completion):

```text
$ lake clean
[exit 0; no output]
$ lake build
✔ [2216/2748] Built LMLF.Quantitative.Basic
✔ [2742/2748] Built Mathlib.Analysis.SpecialFunctions.Gamma.Basic
✔ [2743/2748] Built LMLF.Definitions.Gamma
✔ [2744/2748] Built LMLF.Definitions
✔ [2745/2748] Built LMLF.Results
✔ [2746/2748] Built LMLF.Audit.Definitions
✔ [2747/2748] Built LMLF
Build completed successfully (2748 jobs).
$ lake build
Build completed successfully (2748 jobs).
$ lake build
✔ [2743/2748] Built LMLF.Basic
✔ [2744/2748] Built LMLF.Quantitative.Basic
✔ [2745/2748] Built LMLF.Results
✔ [2746/2748] Built LMLF.Audit.Definitions
✔ [2747/2748] Built LMLF
Build completed successfully (2748 jobs).
```

Inventory validator:

```text
$ python3 scripts/validate_inventory.py
inventory validation passed: 24 occurrences, 2 notations, 10 entities, 10 entity evidence rows, 16 occurrence associations; classification examples [DEF-001, OLV-001, QB-001, QL-001, SR-001]; manifest totals [BOOTSTRAP-0=0, DEMO-0=0, OLV-MVP-1=1]
$ python3 scripts/validate_inventory.py --negative-tests
negative invariant tests passed: 25 intentionally invalid copied fixtures rejected
inventory validation passed: 24 occurrences, 2 notations, 10 entities, 10 entity evidence rows, 16 occurrence associations; classification examples [DEF-001, OLV-001, QB-001, QL-001, SR-001]; manifest totals [BOOTSTRAP-0=0, DEMO-0=0, OLV-MVP-1=1]
```

Trust-boundary and duplicate-implementation searches:

```text
$ rg -n '\b(sorry|admit|axiom|opaque|unsafe)\b' LMLF/Quantitative/Basic.lean LMLF/Definitions/Gamma.lean LMLF/Audit/Definitions.lean
[exit 1; no matches]
$ rg -n '(^|[^[:alnum:]_])(def|abbrev|opaque)\s+[^\n]*Gamma|Complex\.Gamma\s*:=' LMLF
[exit 1; no matches]
```

Declaration count/API search:

```text
$ rg -c '^\s*(def|theorem)\s+' LMLF/Quantitative/Basic.lean
8
$ rg -c '^\s*(def|theorem)\s+' LMLF/Definitions/Gamma.lean
4
```

Whitespace/diff check:

```text
$ git diff --check
[exit 0; no output]
```

## Dependency direction and affected consumers

Observed imports:

```text
LMLF/Basic.lean:import Mathlib.Analysis.Normed.Group.Basic
LMLF/Quantitative/Basic.lean:import LMLF.Basic
LMLF/Definitions/Gamma.lean:import Mathlib.Analysis.SpecialFunctions.Gamma.Basic
LMLF/Definitions.lean:import LMLF.Definitions.Gamma
LMLF/Results.lean:import LMLF.Definitions
LMLF/Results.lean:import LMLF.Quantitative.Basic
LMLF/Audit/Definitions.lean:import LMLF.Definitions
LMLF/Audit/Definitions.lean:import LMLF.Quantitative.Basic
LMLF.lean:import LMLF.Basic
LMLF.lean:import LMLF.Definitions
LMLF.lean:import LMLF.Results
```

Thus semantic flow is foundation/dependency to definitions and results. The audit module only
consumes semantic modules; no semantic module and no `LMLF.lean` imports the audit module.

## Worktree status and diff summary

Final status before writing this detached report:

```text
 M LMLF/Definitions.lean
 M LMLF/Results.lean
 M README.md
 M lakefile.toml
?? LMLF/Audit/
?? LMLF/Definitions/
?? LMLF/Quantitative/
```

Tracked diff summary (untracked new files are listed separately above):

```text
LMLF/Definitions.lean |  4 ++--
LMLF/Results.lean     |  3 ++-
README.md             | 28 ++++++++++++++++------------
lakefile.toml         | 10 +++++++++-
4 files changed, 29 insertions(+), 16 deletions(-)
```

New-file sizes are 68 lines for `LMLF/Quantitative/Basic.lean`, 39 lines for
`LMLF/Definitions/Gamma.lean`, and 71 lines for `LMLF/Audit/Definitions.lean`.

## Known limitations and diagnostics

- This candidate is deliberately uncommitted, so the external envelopes still have null candidate
  bindings and no immutable candidate head. Independent implementation review, disposition,
  candidate binding, merge authorization, and release all remain pending.
- QB-001 is only finite-bound infrastructure. `HasErrorFamily` asserts no convergence, asymptotic
  expansion structure, monotonicity, or source coverage.
- DEF-001 only wraps the pinned Mathlib Gamma object. It does not construct a new Gamma function,
  extend Euler's integral beyond `0 < s.re`, or treat totalized zeros as classical finite pole
  values.
- The audit module is intentionally outside the semantic import root and therefore is available as
  a separately built regression consumer, not as public semantic API.
- Final exact compiles, the fresh full build, validators, signature checks, axiom reports, and
  searches produced no warnings.
- During development, the first direct audit compile read a stale pre-change `LMLF.Definitions`
  object file and reported missing Gamma identifiers. Rebuilding the changed umbrella resolved that
  transient state; a subsequent `lake clean` plus complete 2,748-job build and all post-clean checks
  succeeded, so no candidate diagnostic remains.
