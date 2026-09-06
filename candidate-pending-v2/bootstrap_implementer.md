# BOOTSTRAP-0 pending-v2 proposer evidence: `/root/bootstrap_implementer`

Status: uncommitted single-finding correction based on candidate
`3dbfcc8ef8a2b2c9b721bbf8570493a112b413f6`, awaiting a new frozen candidate commit and fresh
implementation review. This is proposer evidence, not a referee verdict.

## Finding and resolution

- Confirmed finding: P2 in `LMLFTest.Definitions.Gamma.eulerAtOne`.
- Original proof: `exact Complex.Gamma_one`.
- Defect: the regression did not consume
  `LMLF.Definitions.gamma_eq_eulerIntegral`, so it could not detect a changed public Euler
  integrand or normalization.
- Scope of correction: only the proof body in `LMLF/Audit/Definitions.lean`; theorem name,
  statement, attributes, namespace, imports, all semantic declarations, and all other files are
  unchanged.
- Accepted proof:

```lean
theorem eulerAtOne : Complex.Gamma 1 = 1 := by
  rw [LMLF.Definitions.gamma_eq_eulerIntegral (s := 1) (by norm_num)]
  simpa only [Complex.GammaIntegral] using Complex.GammaIntegral_one
```

The first line specializes and rewrites through the public LMLF Euler wrapper at `s = 1`. The
second line identifies the resulting expanded integral with Mathlib's canonical normalized
`GammaIntegral_one` result. This checks both the public integrand and the normalization rather than
bypassing the wrapper.

Rejected experiment: the referee-suggested broad terminal `simp` was tested after the same rewrite,
but left this goal unsolved:

```text
⊢ ∫ (t : ℝ) in Set.Ioi 0, Complex.exp (-↑t) = 1
```

The accepted `simpa only [Complex.GammaIntegral] using Complex.GammaIntegral_one` is explicit,
deterministic, and compiled successfully.

## Exact binding and worktree scope

```text
$ git rev-parse HEAD
3dbfcc8ef8a2b2c9b721bbf8570493a112b413f6
$ git status --short
 M LMLF/Audit/Definitions.lean
$ git diff --name-only
LMLF/Audit/Definitions.lean
```

The exact full-index dirty diff has SHA-256
`c0cfee85d552a2b19c3063724ea2ea993c96261e2682599594c7bbb9fe5f75e7`.

The following command returned exit 0 with no output, confirming that semantic modules,
umbrellas, documentation, Lake configuration, frozen artifacts, validators, and CI are unchanged:

```text
$ git diff --exit-code -- LMLF/Quantitative/Basic.lean LMLF/Definitions/Gamma.lean LMLF/Definitions.lean LMLF/Results.lean README.md lakefile.toml blueprint review scripts .github
[exit 0; no output]
```

Relevant file SHA-256 values after the correction:

```text
9494998c23a14af1815e2779e06d6a24986f80946c2a3218464530c3a50a78c6  LMLF/Audit/Definitions.lean
85d6c94ea7c9e2322745d0c902fd0144369f34e8efc486a73c7290ec620f5c3a  LMLF/Quantitative/Basic.lean
7e061d20e717939b11092f538f7471dc699ca3bf86c576a871ba61e685e7d660  LMLF/Definitions/Gamma.lean
```

The two semantic hashes are identical to candidate `3dbfcc8...`.

## Exact diff

```diff
diff --git a/LMLF/Audit/Definitions.lean b/LMLF/Audit/Definitions.lean
index e0e0e99a0fd30051cd83167eefa599b1db60ba0d..bf1c148befa2ad4c0caaddcbfb384c21702d1b26 100644
--- a/LMLF/Audit/Definitions.lean
+++ b/LMLF/Audit/Definitions.lean
@@ -53,7 +53,8 @@ theorem eulerFormula {s : ℂ} (hs : 0 < s.re) :
 
 /-- The Euler normalization gives `Gamma 1 = 1`. -/
 theorem eulerAtOne : Complex.Gamma 1 = 1 := by
-  exact Complex.Gamma_one
+  rw [LMLF.Definitions.gamma_eq_eulerIntegral (s := 1) (by norm_num)]
+  simpa only [Complex.GammaIntegral] using Complex.GammaIntegral_one
 
 /-- The complex and real Mathlib Gamma functions agree on real inputs. -/
 theorem realAgreement (s : ℝ) : Complex.Gamma (s : ℂ) = Real.Gamma s := by
```

Diff summary:

```text
LMLF/Audit/Definitions.lean | 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)
```

`git diff --check` returned exit 0 with no output.

## Proof dependency verification

Command: `lake env lean /tmp/lmlf_euler_dependency.lean`, where the temporary checker imports
`LMLF.Audit.Definitions`, prints the theorem, and prints its axioms.

```text
theorem LMLFTest.Definitions.Gamma.eulerAtOne : Complex.Gamma 1 = 1 :=
Eq.mpr
  (id
    (congrArg (fun _a => _a = 1)
      (LMLF.Definitions.gamma_eq_eulerIntegral (of_eq_true (Eq.trans zero_lt_one._simp_1 (eq_true True.intro))))))
  Complex.GammaIntegral_one
'LMLFTest.Definitions.Gamma.eulerAtOne' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The elaborated proof term explicitly depends on both the public LMLF Euler wrapper and the
normalized Mathlib Euler integral theorem. Its axioms are exactly within the approved allowlist.

## Verification results

The `referee-lean-proof` deterministic preflight was used because this is a proof-only local
correction. It reported the target file, SHA-256, 72 lines, the unchanged nine audit declarations,
no trust/resource markers, and a successful Lean check in 2.522 seconds.

Direct audit compile:

```text
$ lake env lean LMLF/Audit/Definitions.lean
[exit 0; no output]
```

Full build:

```text
$ lake build
✔ [2747/2748] Built LMLF.Audit.Definitions (1.7s)
Build completed successfully (2748 jobs).
```

Inventory validation:

```text
$ python3 scripts/validate_inventory.py
inventory validation passed: 24 occurrences, 2 notations, 10 entities, 10 entity evidence rows, 16 occurrence associations; classification examples [DEF-001, OLV-001, QB-001, QL-001, SR-001]; manifest totals [BOOTSTRAP-0=0, DEMO-0=0, OLV-MVP-1=1]
$ python3 scripts/validate_inventory.py --negative-tests
negative invariant tests passed: 25 intentionally invalid copied fixtures rejected
inventory validation passed: 24 occurrences, 2 notations, 10 entities, 10 entity evidence rows, 16 occurrence associations; classification examples [DEF-001, OLV-001, QB-001, QL-001, SR-001]; manifest totals [BOOTSTRAP-0=0, DEMO-0=0, OLV-MVP-1=1]
```

Trust search:

```text
$ rg -n '\b(sorry|admit|axiom|opaque|unsafe)\b' LMLF/Quantitative/Basic.lean LMLF/Definitions/Gamma.lean LMLF/Audit/Definitions.lean
[exit 1; no matches]
```

Semantic API counts remain frozen:

```text
$ rg -c '^\s*(def|theorem)\s+' LMLF/Quantitative/Basic.lean
8
$ rg -c '^\s*(def|theorem)\s+' LMLF/Definitions/Gamma.lean
4
```

Import graph:

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

The audit-to-semantic dependency direction is preserved, and the root semantic module still does
not import the audit module. No warning was emitted by the accepted proof or final checks.
