# §5.9 object-first author review

## Scope

This repair covers `LMLF/Blueprint/Gamma/Section59.lean`,
`doc/LMLFManual/Chapter5/Section59.lean`, and
`coverage/sections/chapter5-59.json`. The 25 inventory records are all stated:
E1, E2, E2_5, E3–E9, E10, E10_1, E10_2, E11, E11_1, E11_2, and E12–E20.

## Object/API decisions

- The existing branch-aware §5.9.2 API is preserved. `HasHankelRepresentation`
  remains the short value-facing theorem while `C1Contour`,
  `LogLiftedC1Contour`, `HankelContour`, and `HasHankelIntegral` carry the
  typed path, branch lift, finite integrability, and ordered limits.
- §5.9.20 now uses `complexSegmentContour : ℂ → ℂ → C1Contour` and
  `complexSegmentIntegral`; the theorem no longer expands a raw curve.
- Mellin–Barnes formulas use `verticalSegment : ℝ → ℝ → C1Contour` together
  with `verticalLineIntegral`, `verticalLineIntegrable`, and
  `verticalLineConverges`. This records the finite C¹ path and the improper
  limit separately instead of exposing an arbitrary `ℝ → ℂ` curve.
- Temme's phase and scaled Gamma normalization are shown before use.
- Ordinary formulas with meaningful finite/whole-domain convergence now have
  separate `_integrable`/`_summable` declarations and value declarations.
  Conditional cutoff formulas (E6–E9) retain one Tendsto statement because
  the source claim is already a convergence-to-value assertion. E16 and E18
  expose each distinct integral/value pair separately.

All branch-sensitive entries E10–E17 remain honest positive-real
specializations, as recorded in the manifest; no quantitative error bound is
present in DLMF §5.9, so no second quantitative theorem was invented.

## Validation

- `lake env lean LMLF/Blueprint/Gamma/Section59.lean` passes with only the
  permitted proof `sorry`s.
- From `doc/`, `lake env lean LMLFManual/Chapter5/Section59.lean` passes.
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter5/Section59.lean`
  accepts all 43 source expressions.
- Source and manual have exactly 67 matching anchors; neither contains
  `#check` or prohibited status filler.
- Manifest JSON parses, and expected/stated formula ID sets are equal with no
  omissions.

## Remaining shared-vocabulary requests

If later Mellin–Barnes pages reuse this path, promote the vertical finite-
segment/improper-line layer to Chapter 3. Consolidate the scaled Gamma
normalization with §5.11 when that page receives its complex-variable API.
