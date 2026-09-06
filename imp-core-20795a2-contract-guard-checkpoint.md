# IMP-001 contract-guard sensitivity checkpoint

Date: 2026-09-06 (UTC)

Status: proposer-side verification only. This is not fresh implementation
review quorum and contains no mathematical regression evidence.

## Scope and conclusion

This checkpoint reruns the frozen `SIG-IMP-001-R6-P2` isolated-mutant
protocol against the actual negative type-shape guards committed at
`20795a2a648ffffed846c13419d0f85eec3a3f46`.

The R21 missing-`IntegrableOn` guard and R23 fixed-primitive guard are both
sensitive:

1. each guard and a corresponding positive production application compile
   against the actual production signature;
2. each isolated weakened signature compiles by itself; and
3. the unchanged typed guard exits exactly 1 against its mutant because the
   inner `have` becomes elaborable, producing the asserted
   `fail_if_success`-succeeded diagnostic.

The same stronger check was also completed for the straightforward R07
missing-regular-truncation guard. Its actual full-field positive control and
guard compile, while an isolated characterization lacking the integrability
field makes the unchanged typed guard fail for the intended reason.

No candidate or production file was edited. The only axioms used are clearly
marked disposable type-level mocks under the external `/tmp` harness. They are
not imported by the candidate and are not mathematical evidence. No analytic
example was introduced.

## Frozen candidate bytes

Requested commit:

```text
20795a2a648ffffed846c13419d0f85eec3a3f46
```

Hashes read directly from that commit:

```text
ebced44ac790b40f5453946a917fdc78111f3a4814eca92d68223573901e99dd  LMLFTest/Integral/Improper/IMP001PublicUse.lean
07ac5caa5a4620c763293a257dded3a8fe3231020a9cb4edcfe5f150e4345a22  LMLFTest/Integral/Improper/IMP001Regressions.lean
c4f77d2616b5e8040f9fc1aa60d5301cf5a8f37decb6bb94b520fa2ea04fe35f  LMLF/Integral/Improper/Basic.lean
f3d4c4ddff91bb17a5f5e3325ff6779100e867f6fd7188a1b8a0d46c58182dcb  LMLF/Integral/Improper/Bochner.lean
```

The shared branch advanced concurrently from `20795a2...` to
`0f4df472dd2c97267dbc2c2128975eb3277132e0` while this diagnostic ran. The
intervening commit added only `blueprint/proofs/IMP-001-REG-R2.md`; `git diff
--name-status 20795a2... 0f4df47...` reported no production or test-file
change. The four hashes above remained identical, so the verification is
against the requested candidate bytes.

## Disposable sources

Root:

```text
/tmp/imp-core-20795a2-contract-guards.4ibq2x
```

Final source hashes:

```text
bee8c4073a30c86bdb607553659e5d4d1ea527a43e9743f5b4a2e6c19c131161  r07/Guard.lean
855e824a1d1492505d71c9c2aaab42ac8180e87e8300eeb925a76230f4c5a051  r07/LMLFTest/Integral/Improper/IMP001Regressions.lean
c808afb4b0b886c5b13f8ce4fc992b758f2c85f71eb83540df108912b8dbd53e  t07/Guard.lean
6a2aead8d7a6d1d95e34e29a7fe885f0876ae6814769939a30481bee17266dd8  t07/LMLF/Integral/Improper/Bochner.lean
e1626b3dc227608674ed76daf132f537155bbfcb367d862bbe6196385eebd6fe  t08/Guard.lean
ae1b02f0ad1ad384911d497cf8b64684907d06fe634459c812f115dc64d84122  t08/LMLF/Integral/Improper/Basic.lean
a0b193569546f85ebcfe99c4a4fdd17e07d0060f63f9bb0a768b019dcd844b75  valid/R07Guard.lean
9946f0759c8697d756341de5d34cbc2abd1b818feaa20172bf5a7a7e02f9f0ca  valid/T07Guard.lean
dd805ce4c2a10f9b0b4dcacc1c4fbe213f225ffbbc13b2545689d8cf2459b3d2  valid/T08Guard.lean
```

The `valid` sources import actual production/test modules. The `t07` mutant
imports an unchanged recompilation of production `Basic.lean` and replaces
only T07 by a disposable axiom with the `IntegrableOn` binder removed. The
`t08` mock module supplies only the two required predicate types and a
disposable fixed-`F` T08 axiom. The `r07` mock module imports actual production
T01 and supplies a disposable empty-set characterization whose right side
omits the regular-truncation field.

## Valid-signature controls

Run from `/tmp/lmlf-imp-core.aZgav6tR`:

```bash
lake env lean LMLFTest/Integral/Improper/IMP001PublicUse.lean
lake env lean LMLFTest/Integral/Improper/IMP001Regressions.lean
lake env lean /tmp/imp-core-20795a2-contract-guards.4ibq2x/valid/T07Guard.lean
lake env lean /tmp/imp-core-20795a2-contract-guards.4ibq2x/valid/T08Guard.lean
lake env lean /tmp/imp-core-20795a2-contract-guards.4ibq2x/valid/R07Guard.lean
```

Actual exits:

| Command | Expected | Actual |
|---|---:|---:|
| actual `IMP001PublicUse.lean` | 0 | 0 |
| actual `IMP001Regressions.lean` | 0 | 0 |
| valid T07 positive application plus negative guard | 0 | 0 |
| valid T08 existential application plus fixed-`F` guard | 0 | 0 |
| valid R07 full-field application plus missing-field guard | 0 | 0 |

Thus each current guard rejects the prohibited term under the valid API, and
the nearby positive control proves that the intended stronger application is
available.

## T07 isolated mutant

Exact final run:

```bash
set -e
IMP_T07_ROOT=/tmp/imp-core-20795a2-contract-guards.4ibq2x/t07
IMP_REPO=/tmp/lmlf-imp-core.aZgav6tR
IMP_LEAN=/home/codex/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean
IMP_BASE_PATH="$(lake env printenv LEAN_PATH)"
env LEAN_PATH="$IMP_BASE_PATH" "$IMP_LEAN" -R "$IMP_REPO" \
  -o "$IMP_T07_ROOT/LMLF/Integral/Improper/Basic.olean" \
  "$IMP_REPO/LMLF/Integral/Improper/Basic.lean"
IMP_T07_PATH="$IMP_T07_ROOT:$IMP_BASE_PATH"
env LEAN_PATH="$IMP_T07_PATH" "$IMP_LEAN" -R "$IMP_T07_ROOT" \
  -o "$IMP_T07_ROOT/LMLF/Integral/Improper/Bochner.olean" \
  "$IMP_T07_ROOT/LMLF/Integral/Improper/Bochner.lean"
env LEAN_PATH="$IMP_T07_PATH" "$IMP_LEAN" -R "$IMP_T07_ROOT" \
  "$IMP_T07_ROOT/Guard.lean"
```

Expected/actual:

| Step | Expected | Actual |
|---|---:|---:|
| unchanged production Basic recompilation | 0 | 0 |
| isolated weakened T07 signature | 0 | 0 |
| unchanged typed guard | 1 | 1 |
| fixed diagnostic-string match | success | success |

Full relevant diagnostic:

```text
/tmp/imp-core-20795a2-contract-guards.4ibq2x/t07/Guard.lean:14:2: error: The tactic provided to `fail_if_success` succeeded but was expected to fail:
  have hbad : HasImproperIntegralAtTopExcept _f k S (∫ t in Ioi k, _f t) :=
      HasImproperIntegralAtTopExcept.of_integrableOn_Ioi _f k S _hS
```

This establishes sensitivity because removing exactly the `IntegrableOn`
argument makes the actual bad typed `have` succeed. No other production
consumer is compiled against the mutant.

## T08 isolated mutant

Exact final run:

```bash
set -e
IMP_T08_ROOT=/tmp/imp-core-20795a2-contract-guards.4ibq2x/t08
IMP_LEAN=/home/codex/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean
IMP_BASE_PATH="$(lake env printenv LEAN_PATH)"
IMP_T08_PATH="$IMP_T08_ROOT:$IMP_BASE_PATH"
env LEAN_PATH="$IMP_T08_PATH" "$IMP_LEAN" -R "$IMP_T08_ROOT" \
  -o "$IMP_T08_ROOT/LMLF/Integral/Improper/Basic.olean" \
  "$IMP_T08_ROOT/LMLF/Integral/Improper/Basic.lean"
env LEAN_PATH="$IMP_T08_PATH" "$IMP_LEAN" -R "$IMP_T08_ROOT" \
  "$IMP_T08_ROOT/Guard.lean"
```

Expected/actual:

| Step | Expected | Actual |
|---|---:|---:|
| isolated fixed-`F` T08 signature | 0 | 0 |
| unchanged typed guard | 1 | 1 |
| fixed diagnostic-string match | success | success |

Full relevant diagnostic:

```text
/tmp/imp-core-20795a2-contract-guards.4ibq2x/t08/Guard.lean:13:2: error: The tactic provided to `fail_if_success` succeeded but was expected to fail:
  have hbad :
      HasImproperIntegralAtTopExcept _f _k _S _I ↔
        IsFiniteExceptionalPrimitive _f _k _S _F ∧ Tendsto _F atTop (nhds _I) :=
      hasImproperIntegralAtTopExcept_iff_exists_primitive
```

This establishes sensitivity because replacing the existentially quantified
primitive by exactly the prohibited fixed `F` makes the actual bad typed
equivalence succeed. No unrelated consumer is present in the mutant root.

## R07 isolated characterization mutant

Exact final run:

```bash
set -e
IMP_R07_ROOT=/tmp/imp-core-20795a2-contract-guards.4ibq2x/r07
IMP_LEAN=/home/codex/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean
IMP_BASE_PATH="$(lake env printenv LEAN_PATH)"
IMP_R07_PATH="$IMP_R07_ROOT:$IMP_BASE_PATH"
env LEAN_PATH="$IMP_R07_PATH" "$IMP_LEAN" -R "$IMP_R07_ROOT" \
  -o "$IMP_R07_ROOT/LMLFTest/Integral/Improper/IMP001Regressions.olean" \
  "$IMP_R07_ROOT/LMLFTest/Integral/Improper/IMP001Regressions.lean"
env LEAN_PATH="$IMP_R07_PATH" "$IMP_LEAN" -R "$IMP_R07_ROOT" \
  "$IMP_R07_ROOT/Guard.lean"
```

Expected/actual:

| Step | Expected | Actual |
|---|---:|---:|
| isolated weakened empty-set characterization | 0 | 0 |
| unchanged typed guard | 1 | 1 |
| fixed diagnostic-string match | success | success |

Full relevant diagnostic:

```text
/tmp/imp-core-20795a2-contract-guards.4ibq2x/r07/Guard.lean:16:2: error: The tactic provided to `fail_if_success` succeeded but was expected to fail:
  have hbad : HasImproperIntegralAtTopExcept _f _k ∅ _I := r02_empty_exceptional_set_iff.mpr _hLim
```

This establishes type-shape sensitivity only: after removing the honest
regular-truncation conjunct, the limit alone constructs the relation and the
guard intentionally trips. It is not a nonintegrability counterexample.

## Harness setup note

Before the final evidence run, two authoring-only T07 setup attempts failed:
the first placed a module doc comment before imports, which Lean rejects, and
the second shadowed the production module hierarchy without first providing
`Basic.olean`. The final source moved imports to the beginning and explicitly
recompiled unchanged production `Basic.lean` into the disposable root. These
setup failures occurred before the mutant guard was tested and do not count as
sensitivity evidence.

## Disposition

R21 and the fixed-`F` portion of R23 satisfy the frozen isolated-mutant
sensitivity requirement on the actual committed test bytes. R07 also has the
same evidence class. These checks establish non-vacuous compile-time guard
sensitivity only; they do not discharge any analytical regression, production
proof audit, or independent review requirement.
