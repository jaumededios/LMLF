# §5.4 object-first repair

## Scope

This pass addresses the Chapter 5 global object audit finding for DLMF §5.4
only. The owned source, manual, and manifest preserve all twenty numbered
formula entries and the source-linked Table 5.4.1 prose.

## Changes

- Replaced the E20 existential raw function with a normalized
  `GammaExtremaSequence`. Its indexed points are `GammaExtremum n` records
  carrying the source-index interval and persistent conditions `Gamma'(x) = 0`
  and `psi(x) = 0`.
- Added the named `GammaExtremum.value` map for the table's displayed
  `Gamma(xₙ)` values.
- Added `gamma_extrema_exists`, `gamma_extrema_unique`, and the canonical
  extractor `gammaExtrema`; E20 now estimates that same extracted sequence,
  rather than introducing a fresh existential family.
- Updated the manual to show every custom definition before it is referenced,
  while preserving the source formula, table approximations, correction note,
  and real-variable specialization prose.
- Updated the manifest's extra declarations and E20 names/notes to record the
  structured objects and the qualitative/quantitative split.

## Validation

- `lake env lean LMLF/Blueprint/Gamma/Section54.lean` passes; only the
  statement-phase `sorry` warnings remain.
- From `doc/`, `lake env lean LMLFManual/Chapter5/Section54.lean` passes.
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter5/Section54.lean`
  accepts all 21 source expressions.
- No `#check` occurs in either owned source file.
- Manifest parsing reports 20 expected IDs, 20 stated IDs, and zero omitted
  IDs.
- The generated HTML was intentionally not regenerated; root will publish the
  stale-page refresh after the focused source/API repair.

## Remaining gaps

The mathematical proofs remain `sorry` by design. The rounded Table 5.4.1
cells remain documented approximations rather than invented exact decimal
equalities. Rendered-site validation was not run, so no generated output was
edited.
