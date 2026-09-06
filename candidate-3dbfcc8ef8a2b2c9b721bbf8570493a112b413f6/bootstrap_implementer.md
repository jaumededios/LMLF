# BOOTSTRAP-0 proposer evidence: `/root/bootstrap_implementer`

Status: frozen candidate commit awaiting independent implementation review and release. This is
proposer evidence, not a referee verdict or merge authorization.

## Exact candidate binding

- Repository: `/home/codex/Documents/Codex/2026-09-05/yo`
- Branch: `main`
- Specification/base commit: `1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9`
- Candidate/head commit: `3dbfcc8ef8a2b2c9b721bbf8570493a112b413f6`
- Candidate parent: `1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9`
- Candidate tree: `c7bd8b3fc8f1a21b6a2793902271246833703461`
- Candidate archive SHA-256 (`git archive --format=tar HEAD`):
  `e54d018f52a034437cce21d9930a03545ecb4ee61230431bc986d437421ab685`
- Exact full-index base-to-head diff SHA-256:
  `86bc8bccfaaa9af0916086ad9ad450652e2c4064e9f7b3110e0ea59115efe32f`
- Proposer ID: `/root/bootstrap_implementer`
- Lean: `4.33.1`, commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`
- Resolved Mathlib checkout: `0df444a360eaa60ab8c11dca51a86af692955474`
- Verification execution method: commands were rerun in the repository worktree after proving
  `HEAD` equals the candidate commit and `git status --porcelain=v1` is empty. The committed tree
  and deterministic Git archive were separately hashed above.

Commands and results:

```text
$ git rev-parse HEAD
3dbfcc8ef8a2b2c9b721bbf8570493a112b413f6
$ git rev-parse HEAD^
1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9
$ git rev-parse 'HEAD^{tree}'
c7bd8b3fc8f1a21b6a2793902271246833703461
$ git status --porcelain=v1
[exit 0; no output; zero status bytes]
```

## Frozen specification and authorization binding

The frozen artifacts at the base commit reproduce these ordinary SHA-256 digests:

```text
7a56a1695d15ea2cedd525ee4270d20830e1706827bb592dfde293bcd7d54c39  review/work_packets/QB-001.yaml
6dbda13f4f27dd4c0492c00ecc0a2d184f00fe85fa7096802cf93e9fdecf11e8  review/work_packets/DEF-001.yaml
827522349afc7374a8bec60b3d281c192a44189f8e8c08c24e453bf75e215667  blueprint/theorem_cards/QB-001.yaml
93e4e30a93087de95342abdb1e986676924cd93512e771737d0d3f3ed7973b39  blueprint/theorem_cards/QB-001-signatures.md
42b027310a56ff70f4c56471de527aa9b6a3ac88810ad3ba17029953514c1589  blueprint/proofs/QB-001.md
eff82b06afaa61b67d13c3a399494525ed452e42c203a390ba40e56b93ec9daa  blueprint/theorem_cards/DEF-001.yaml
8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9  review/classifications-v2.json
```

External pre-Lean artifacts:

```text
dbcf16abb033bfc87f353b75125470788c92b28580bf52ffc125bcf0d0a7562a  QB-001-review-envelope.yaml
1cb983db8cb2affdab0d3628df5bcc61ea92006d3739edfa26a9ab5e69c89acf  DEF-001-review-envelope.yaml
f30686bd60e672f46a607d470f697ffa279944d8203d82a881dafe742c546194  prelean_authorization.md
```

All twelve structured verdict records and both reviewer narratives reproduced the hashes recorded
by the envelopes. QB-001 records theorem-card `pass`, required natural-language-proof `pass`,
structural `not_required`, and composite `lean_ready: pass`. DEF-001 records theorem-card `pass`,
natural-language-proof `not_required`, structural `not_required`, and composite
`lean_ready: pass`.

The command below returned exit 0 with no output, proving that the candidate did not change any
frozen blueprint, review, validator, inventory, or CI path:

```text
$ git diff --exit-code 1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9..3dbfcc8ef8a2b2c9b721bbf8570493a112b413f6 -- blueprint review scripts .github
[exit 0; no output]
```

## Changed files and committed objects

```text
$ git diff --name-status 1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9..3dbfcc8ef8a2b2c9b721bbf8570493a112b413f6
A  LMLF/Audit/Definitions.lean
M  LMLF/Definitions.lean
A  LMLF/Definitions/Gamma.lean
A  LMLF/Quantitative/Basic.lean
M  LMLF/Results.lean
M  README.md
M  lakefile.toml
```

Committed Git modes, object kinds, blob IDs, and paths:

```text
100644 blob e0e0e99a0fd30051cd83167eefa599b1db60ba0d  LMLF/Audit/Definitions.lean
100644 blob 1bfd4588fb1246bd630ae2fde22700a75648342d  LMLF/Definitions.lean
100644 blob c8f0e3ac7a5daaaa68f2ae938ca45c6fff6e87e7  LMLF/Definitions/Gamma.lean
100644 blob ebd06b8a8abd12986e70e09fa6182c9f919857f7  LMLF/Quantitative/Basic.lean
100644 blob 9c3ebd9f33fe3132e9b9c956576e17c9cea23680  LMLF/Results.lean
100644 blob 218c4acd3edd91a2d94471e93cbeb3cf1959f438  README.md
100644 blob 4118afade75495a60423509258692d54c996fa46  lakefile.toml
```

Ordinary SHA-256 hashes of the committed file bytes:

```text
d62575afef8ab515c11183afba162c7beff103592eccac7e97d30e7ffe7ee6ed  LMLF/Audit/Definitions.lean
1627b2ea10bb50a660c8637dafd17348e0a4c7126dadf537afb4e7fab5053abe  LMLF/Definitions.lean
7e061d20e717939b11092f538f7471dc699ca3bf86c576a871ba61e685e7d660  LMLF/Definitions/Gamma.lean
85d6c94ea7c9e2322745d0c902fd0144369f34e8efc486a73c7290ec620f5c3a  LMLF/Quantitative/Basic.lean
0cf4a1c67640cb5d0d0ea66f3353f9e0ab574c77b8346e68afc69edfe33f315f  LMLF/Results.lean
1945b536047d31b185cf771794d11add44457cb737237fff544f99ab1536a86c  README.md
787bac6de4002b375a6bfbc840589d72ea3e1f2a440a33352973f268815da562  lakefile.toml
```

Diff summary:

```text
LMLF/Audit/Definitions.lean  | 71 ++++++++++++++++++++++++++++++++++++++++++++
LMLF/Definitions.lean        |  4 +--
LMLF/Definitions/Gamma.lean  | 39 ++++++++++++++++++++++++
LMLF/Quantitative/Basic.lean | 68 ++++++++++++++++++++++++++++++++++++++++++
LMLF/Results.lean            |  3 +-
README.md                    | 28 +++++++++--------
lakefile.toml                | 10 ++++++-
7 files changed, 207 insertions(+), 16 deletions(-)
```

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

Audit-only declarations:

- `LMLFTest.QB001.emptyDomain`
- `LMLFTest.QB001.exactZero`
- `LMLFTest.QB001.transSum`
- `LMLFTest.Definitions.Gamma.eulerIntegrable`
- `LMLFTest.Definitions.Gamma.eulerFormula`
- `LMLFTest.Definitions.Gamma.eulerAtOne`
- `LMLFTest.Definitions.Gamma.realAgreement`
- `LMLFTest.Definitions.Gamma.conjugation`
- `LMLFTest.Definitions.Gamma.poleTotalization`

Source counting found exactly eight semantic declarations in
`LMLF/Quantitative/Basic.lean` and exactly four in `LMLF/Definitions/Gamma.lean`, with no extra
semantic declaration form.

## Verification at exact candidate head

Exact module compiles:

```text
$ lake env lean LMLF/Quantitative/Basic.lean
[exit 0; no output]
$ lake env lean LMLF/Definitions/Gamma.lean
[exit 0; no output]
$ lake env lean LMLF/Audit/Definitions.lean
[exit 0; no output]
```

Full build:

```text
$ lake build
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

Diff whitespace check:

```text
$ git diff --check 1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9..3dbfcc8ef8a2b2c9b721bbf8570493a112b413f6
[exit 0; no output]
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

## Exact signature transcript

Command: `lake env lean /tmp/lmlf_bootstrap_checks.lean`. The temporary check file imported
`LMLF.Results`, issued `#check @...` for all twelve declarations, and issued `#print axioms ...`
for all twelve.

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

## Import direction and affected consumers

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

Semantic flow is foundation/dependency to definitions and results. The audit module only consumes
semantic modules; no semantic module and no `LMLF.lean` imports the audit module.

## Known limitations and diagnostics

- Independent implementation review, candidate-envelope binding, disposition, merge authorization,
  and release remain pending. The immutable pre-Lean envelopes intentionally retain null candidate
  bindings; this report binds proposer evidence to the exact implementation commit.
- QB-001 is finite-bound infrastructure only. `HasErrorFamily` asserts no convergence, asymptotic
  expansion structure, monotonicity, or source coverage.
- DEF-001 only wraps the pinned Mathlib Gamma object. It does not construct a new Gamma function,
  extend Euler's integral beyond `0 < s.re`, or treat totalized zeros as classical finite pole
  values.
- The audit module is intentionally outside the semantic import root and is a separately built
  regression consumer, not public semantic API.
- All exact-head verification commands above completed without warnings or errors.
- Before the candidate was frozen, one development-only direct audit compile read a stale umbrella
  object file and reported missing Gamma identifiers. Rebuilding the umbrella and a subsequent
  clean 2,748-job build resolved that environment artifact. It is not reproducible at the exact
  candidate head; all exact-head checks above pass.

## Exact base-to-head diff

Command:

```text
git diff --full-index --no-ext-diff 1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9..3dbfcc8ef8a2b2c9b721bbf8570493a112b413f6
```

Output:

````diff
diff --git a/LMLF/Audit/Definitions.lean b/LMLF/Audit/Definitions.lean
new file mode 100644
index 0000000000000000000000000000000000000000..e0e0e99a0fd30051cd83167eefa599b1db60ba0d
--- /dev/null
+++ b/LMLF/Audit/Definitions.lean
@@ -0,0 +1,71 @@
+import LMLF.Definitions
+import LMLF.Quantitative.Basic
+
+/-!
+# Definition audits
+
+This separately built consumer expands the Gamma identification theorem and records inexpensive
+checks of the conventions inherited from Mathlib.  It is deliberately not imported by the semantic
+library root.
+
+These checks audit the selected Mathlib object.  They do not resolve the blueprint's outstanding
+source-wide questions about Olver's analytic continuation and exceptional-value conventions.
+-/
+
+namespace LMLFTest.QB001
+
+open QuantitativeAnalysis
+
+/-- Empty-domain semantics remain vacuous. -/
+theorem emptyDomain {X E : Type*} [NormedAddCommGroup E]
+    (f a : X → E) (b : X → ℝ) : ErrorOn (∅ : Set X) f a b := by
+  intro x hx
+  exact hx.elim
+
+/-- Equality on the domain produces exactly the zero majorant. -/
+theorem exactZero {X E : Type*} [NormedAddCommGroup E]
+    {D : Set X} {f a : X → E} (h : Set.EqOn f a D) :
+    ErrorOn D f a (fun _ ↦ 0) := by
+  exact ErrorOn.exact h
+
+/-- Transitivity exposes the sum majorant in the conclusion. -/
+theorem transSum {X E : Type*} [NormedAddCommGroup E]
+    {D : Set X} {f a c : X → E} {b d : X → ℝ}
+    (hfa : ErrorOn D f a b) (hac : ErrorOn D a c d) :
+    ErrorOn D f c (fun x ↦ b x + d x) := by
+  exact ErrorOn.trans hfa hac
+
+end LMLFTest.QB001
+
+namespace LMLFTest.Definitions.Gamma
+
+/-- The integrand in the public Euler formula is integrable on its stated half-plane. -/
+theorem eulerIntegrable {s : ℂ} (hs : 0 < s.re) :
+    MeasureTheory.IntegrableOn
+      (fun x : ℝ ↦ (Real.exp (-x) : ℂ) * (x : ℂ) ^ (s - 1)) (Set.Ioi 0) := by
+  exact LMLF.Definitions.gamma_eulerIntegrable hs
+
+/-- Expanded regression check for the public Euler-integral identification. -/
+theorem eulerFormula {s : ℂ} (hs : 0 < s.re) :
+    Complex.Gamma s =
+      ∫ x : ℝ in Set.Ioi 0, (Real.exp (-x) : ℂ) * (x : ℂ) ^ (s - 1) := by
+  exact LMLF.Definitions.gamma_eq_eulerIntegral hs
+
+/-- The Euler normalization gives `Gamma 1 = 1`. -/
+theorem eulerAtOne : Complex.Gamma 1 = 1 := by
+  exact Complex.Gamma_one
+
+/-- The complex and real Mathlib Gamma functions agree on real inputs. -/
+theorem realAgreement (s : ℝ) : Complex.Gamma (s : ℂ) = Real.Gamma s := by
+  exact LMLF.Definitions.gamma_ofReal s
+
+/-- Gamma respects complex conjugation. -/
+theorem conjugation (s : ℂ) :
+    Complex.Gamma (starRingEnd ℂ s) = starRingEnd ℂ (Complex.Gamma s) := by
+  exact Complex.Gamma_conj s
+
+/-- Mathlib totalizes Gamma to zero at every nonpositive integer. -/
+theorem poleTotalization (n : ℕ) : Complex.Gamma (-(n : ℂ)) = 0 := by
+  exact LMLF.Definitions.gamma_neg_nat_eq_zero n
+
+end LMLFTest.Definitions.Gamma
diff --git a/LMLF/Definitions.lean b/LMLF/Definitions.lean
index 9026419baab1d798648c36868b8bf375b026267d..1bfd4588fb1246bd630ae2fde22700a75648342d 100644
--- a/LMLF/Definitions.lean
+++ b/LMLF/Definitions.lean
@@ -1,7 +1,7 @@
-import LMLF.Basic
+import LMLF.Definitions.Gamma
 
 /-!
 # LMLF.Definitions
 
-Empty semantic umbrella reserved for accepted definitions.
+Public umbrella for candidate semantic definitions.
 -/
diff --git a/LMLF/Definitions/Gamma.lean b/LMLF/Definitions/Gamma.lean
new file mode 100644
index 0000000000000000000000000000000000000000..c8f0e3ac7a5daaaa68f2ae938ca45c6fff6e87e7
--- /dev/null
+++ b/LMLF/Definitions/Gamma.lean
@@ -0,0 +1,39 @@
+import Mathlib.Analysis.SpecialFunctions.Gamma.Basic
+
+/-!
+# The complex Gamma function
+
+LMLF reuses `Complex.Gamma`; it does not define a second Gamma function.  The theorems below make
+its Euler integral, convergence domain, real agreement, and totalization at nonpositive integers
+available through the definitions API.
+
+This is an identification with the Euler integral only when `0 < s.re`.  It does not assert that
+the integral defines Gamma outside that half-plane.
+-/
+
+namespace LMLF.Definitions
+
+/-- Euler's integrand for `s` is integrable on the positive real axis when `0 < re s`. -/
+theorem gamma_eulerIntegrable {s : ℂ} (hs : 0 < s.re) :
+    MeasureTheory.IntegrableOn
+      (fun t : ℝ ↦ (Real.exp (-t) : ℂ) * (t : ℂ) ^ (s - 1))
+      (Set.Ioi 0) := by
+  exact Complex.GammaIntegral_convergent hs
+
+/-- On the half-plane `0 < re s`, Mathlib's complex Gamma function is Euler's integral. -/
+theorem gamma_eq_eulerIntegral {s : ℂ} (hs : 0 < s.re) :
+    Complex.Gamma s =
+      ∫ t in Set.Ioi (0 : ℝ), (Real.exp (-t) : ℂ) * (t : ℂ) ^ (s - 1) := by
+  simpa only [Complex.GammaIntegral] using Complex.Gamma_eq_integral hs
+
+/-- Mathlib's complex and real Gamma functions agree on every real input. -/
+theorem gamma_ofReal (s : ℝ) :
+    Complex.Gamma (s : ℂ) = (Real.Gamma s : ℂ) := by
+  exact Complex.Gamma_ofReal s
+
+/-- Mathlib totalizes Gamma to zero at its poles at the nonpositive integers. -/
+theorem gamma_neg_nat_eq_zero (n : ℕ) :
+    Complex.Gamma (-(n : ℂ)) = 0 := by
+  exact Complex.Gamma_neg_nat_eq_zero n
+
+end LMLF.Definitions
diff --git a/LMLF/Quantitative/Basic.lean b/LMLF/Quantitative/Basic.lean
new file mode 100644
index 0000000000000000000000000000000000000000..ebd06b8a8abd12986e70e09fa6182c9f919857f7
--- /dev/null
+++ b/LMLF/Quantitative/Basic.lean
@@ -0,0 +1,68 @@
+import LMLF.Basic
+
+/-!
+# Foundational quantitative predicates
+
+Finite pointwise error and norm bounds, together with their basic transport rules.
+-/
+
+namespace QuantitativeAnalysis
+
+variable {X Y E : Type*} [NormedAddCommGroup E]
+
+/-- `ErrorOn D f a b` means that `a` approximates `f` with pointwise error at most `b` on `D`. -/
+def ErrorOn (D : Set X) (f a : X → E) (b : X → ℝ) : Prop :=
+  ∀ x ∈ D, ‖f x - a x‖ ≤ b x
+
+/-- `NormBoundOn D f b` means that the norm of `f` is pointwise at most `b` on `D`. -/
+def NormBoundOn (D : Set X) (f : X → E) (b : X → ℝ) : Prop :=
+  ∀ x ∈ D, ‖f x‖ ≤ b x
+
+/-- A family of finite pointwise error estimates for one fixed target function. -/
+def HasErrorFamily
+    (f : X → E) (a : ℕ → X → E)
+    (D : ℕ → Set X) (b : ℕ → X → ℝ) : Prop :=
+  ∀ n, ErrorOn (D n) f (a n) (b n)
+
+namespace ErrorOn
+
+/-- Functions equal on a domain have zero error there. -/
+theorem exact {D : Set X} {f a : X → E} (h : Set.EqOn f a D) :
+    ErrorOn D f a (fun _ ↦ 0) := by
+  intro x hx
+  simpa only [h hx, sub_self, norm_zero] using (le_refl (0 : ℝ))
+
+/-- An error bound restricts to a smaller domain. -/
+theorem restrict {D D' : Set X} {f a : X → E} {b : X → ℝ}
+    (h : ErrorOn D f a b) (hD : D' ⊆ D) :
+    ErrorOn D' f a b := by
+  intro x hx
+  exact h x (hD hx)
+
+/-- An error bound remains valid after pointwise enlargement of its majorant. -/
+theorem weaken {D : Set X} {f a : X → E} {b d : X → ℝ}
+    (h : ErrorOn D f a b) (hbd : ∀ x ∈ D, b x ≤ d x) :
+    ErrorOn D f a d := by
+  intro x hx
+  exact (h x hx).trans (hbd x hx)
+
+/-- Successive error bounds compose with the sum of their majorants. -/
+theorem trans {D : Set X} {f a c : X → E} {b d : X → ℝ}
+    (hfa : ErrorOn D f a b) (hac : ErrorOn D a c d) :
+    ErrorOn D f c (fun x ↦ b x + d x) := by
+  intro x hx
+  calc
+    ‖f x - c x‖ = ‖(f x - a x) + (a x - c x)‖ := by rw [sub_add_sub_cancel]
+    _ ≤ ‖f x - a x‖ + ‖a x - c x‖ := norm_add_le _ _
+    _ ≤ b x + d x := add_le_add (hfa x hx) (hac x hx)
+
+/-- An error bound pulls back along a map into its original domain. -/
+theorem comp {D : Set X} {f a : X → E} {b : X → ℝ}
+    (h : ErrorOn D f a b) {S : Set Y} (ψ : Y → X)
+    (hψ : Set.MapsTo ψ S D) :
+    ErrorOn S (f ∘ ψ) (a ∘ ψ) (b ∘ ψ) := by
+  intro y hy
+  exact h (ψ y) (hψ hy)
+
+end ErrorOn
+end QuantitativeAnalysis
diff --git a/LMLF/Results.lean b/LMLF/Results.lean
index b1d1361f4e3f7621f084e814411ddbbc092d02ee..9c3ebd9f33fe3132e9b9c956576e17c9cea23680 100644
--- a/LMLF/Results.lean
+++ b/LMLF/Results.lean
@@ -1,7 +1,8 @@
 import LMLF.Definitions
+import LMLF.Quantitative.Basic
 
 /-!
 # LMLF.Results
 
-Empty semantic umbrella reserved for accepted results.
+Public umbrella for candidate semantic results.
 -/
diff --git a/README.md b/README.md
index c986bcb66f8efae45a19aaf529321d773aee8486..218c4acd3edd91a2d94471e93cbeb3cf1959f438 100644
--- a/README.md
+++ b/README.md
@@ -8,12 +8,12 @@ specifications, and release gates.
 
 ## Current status
 
-The repository is at the specification stage. No semantic declaration has passed the project's
-acceptance gates, so the public Lean modules currently provide package structure only. QB-001 and
-DEF-001 remain specification work items awaiting their required external pre-Lean,
-implementation-review, and release gates. The source ledgers are initial audit seeds, not a
-complete source inventory, and the project claims no quantitative Olver theorem or source coverage
-yet.
+The repository contains a candidate implementation of the externally authorized BOOTSTRAP-0
+packets QB-001 and DEF-001. The candidate exposes foundational finite-error predicates and transport
+lemmas and transparent wrappers around Mathlib's Gamma function. It is awaiting implementation
+review and release; these declarations must not yet be described as accepted or released. The
+source ledgers are initial audit seeds, not a complete source inventory, and the project claims no
+quantitative Olver theorem or source coverage yet.
 
 Planning and review artifacts are kept explicit:
 
@@ -25,12 +25,16 @@ Planning and review artifacts are kept explicit:
 ## Library layout
 
 - `LMLF/Basic.lean` provides narrow shared imports for foundational quantitative algebra.
-- `LMLF/Definitions.lean` is an empty public umbrella reserved for accepted definitions.
-- `LMLF/Results.lean` is an empty public umbrella reserved for accepted semantic results.
-- `LMLF.lean` imports the public package modules.
-
-The `LMLF` library target lists only these public modules. Keep semantic dependencies flowing from
-shared foundations to definitions to results.
+- `LMLF/Definitions/Gamma.lean` provides the four candidate wrappers around `Complex.Gamma`.
+- `LMLF/Quantitative/Basic.lean` provides the eight candidate finite-error declarations.
+- `LMLF/Definitions.lean` and `LMLF/Results.lean` are the public semantic umbrellas.
+- `LMLF/Audit/Definitions.lean` is a separately built regression consumer and is not imported by
+  `LMLF.lean`.
+- `LMLF.lean` imports only the public semantic package modules.
+
+The `LMLF` library target explicitly lists both semantic and audit modules. Semantic dependencies
+flow from shared foundations to definitions and results; the audit module only consumes semantic
+modules.
 
 ## Getting started
 
diff --git a/lakefile.toml b/lakefile.toml
index 640bae6c00a26f8bf19e4140d8af152a40e63bc9..4118afade75495a60423509258692d54c996fa46 100644
--- a/lakefile.toml
+++ b/lakefile.toml
@@ -18,4 +18,12 @@ rev = "v4.33.1"
 
 [[lean_lib]]
 name = "LMLF"
-globs = ["LMLF", "LMLF.Basic", "LMLF.Definitions", "LMLF.Results"]
+globs = [
+  "LMLF",
+  "LMLF.Basic",
+  "LMLF.Definitions",
+  "LMLF.Definitions.Gamma",
+  "LMLF.Quantitative.Basic",
+  "LMLF.Results",
+  "LMLF.Audit.Definitions",
+]
````
