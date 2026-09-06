# IMP-001 disposable contract-guard source manifest

**Bound candidate commit:** `20795a2a648ffffed846c13419d0f85eec3a3f46`  
**Bound checkpoint:** `../imp-core-20795a2-contract-guard-checkpoint.md`  
**Checkpoint SHA-256:** `55ddd5213244946644fa5e14ba9e171c04f75903a29a83670cc72c4e96f8198a`

This directory is an external evidence copy of nine disposable Lean source
files from `/tmp/imp-core-20795a2-contract-guards.4ibq2x`. The files are
preserved byte-for-byte under their original relative paths.

The sources containing axioms are non-authoritative signature-shape mocks used
only to test compile-time guard sensitivity. None is a production candidate
file or candidate import, and none is Lean theorem, mathematical proof,
analytic-regression, implementation-review, or acceptance evidence. The
`valid` files are positive controls against actual production/test modules; the
`r07`, `t07`, and `t08` trees isolate deliberately weakened mock interfaces.

## Exact source inventory

| Relative path | SHA-256 | Evidence role |
|---|---|---|
| `r07/Guard.lean` | `bee8c4073a30c86bdb607553659e5d4d1ea527a43e9743f5b4a2e6c19c131161` | unchanged typed guard against isolated R07 mock |
| `r07/LMLFTest/Integral/Improper/IMP001Regressions.lean` | `855e824a1d1492505d71c9c2aaab42ac8180e87e8300eeb925a76230f4c5a051` | disposable weakened R07 characterization mock |
| `t07/Guard.lean` | `c808afb4b0b886c5b13f8ce4fc992b758f2c85f71eb83540df108912b8dbd53e` | unchanged typed guard against isolated T07 mock |
| `t07/LMLF/Integral/Improper/Bochner.lean` | `6a2aead8d7a6d1d95e34e29a7fe885f0876ae6814769939a30481bee17266dd8` | disposable T07 missing-`IntegrableOn` axiom mock |
| `t08/Guard.lean` | `e1626b3dc227608674ed76daf132f537155bbfcb367d862bbe6196385eebd6fe` | unchanged typed guard against isolated T08 mock |
| `t08/LMLF/Integral/Improper/Basic.lean` | `ae1b02f0ad1ad384911d497cf8b64684907d06fe634459c812f115dc64d84122` | disposable fixed-primitive T08 axiom mock |
| `valid/R07Guard.lean` | `a0b193569546f85ebcfe99c4a4fdd17e07d0060f63f9bb0a768b019dcd844b75` | actual-signature positive control and guard |
| `valid/T07Guard.lean` | `9946f0759c8697d756341de5d34cbc2abd1b818feaa20172bf5a7a7e02f9f0ca` | actual-signature positive control and guard |
| `valid/T08Guard.lean` | `dd805ce4c2a10f9b0b4dcacc1c4fbe213f225ffbbc13b2545689d8cf2459b3d2` | actual-signature positive control and guard |

These hashes match the checkpoint's final source-hash ledger. Generated
`.olean` files, command output, caches, credentials, and unrelated temporary
files are intentionally excluded.
