# §5.18 object-first repair

## Scope

This repair addresses G5-7 and G5-13 from the Chapter 5 global object audit.
Only the §5.18 blueprint, standalone manual page, and §5.18 coverage manifest
were changed.

## Changes

- E1, E4, and E11 now expose the canonical `qPochhammer`, `qGamma`, and
  `qBeta` definitions directly under their DLMF anchors; the former theorem
  panels that merely unfolded those definitions were removed.
- `QGammaPoint` packages `0 < q < 1` and a nonzero q-Pochhammer denominator.
  `qGammaValue` is the pole-free value interface, while `qGamma` remains a
  clearly documented totalized implementation representative.
- `QBetaPoint` packages the three pole-free q-Gamma arguments needed by the
  quotient, and `qBetaValue` is the corresponding finite-value interface.
- Named q-Pochhammer, q-Gamma numerator/denominator, and Jackson summand
  objects are displayed before use.  `qGamma_products_hasProd` provides the
  paired product-convergence layer before E5--E7, and
  `qBeta_jackson_hasSum` provides an independent Jackson-series convergence
  layer before E12; it takes only the q-base and real-part convergence
  hypotheses, not a q-Beta value witness.
- E5--E7, the real-axis bridge, and E12 consume the pole-free value objects;
  the DLMF displays and prose domains remain visible, with real-axis
  inequalities retained as the explicitly documented `qGammaReal` proxy.
- The manifest keeps all twelve numbered IDs, records the new object and
  convergence vocabulary under extra IDs, and marks the definition-based
  entries as canonical definitions rather than tautological theorems.
- The denominator-only guard is named `qGammaDenomNeZero`; `QGammaPoint` is
  the complete source-domain object carrying both `0 < q < 1` and that guard.

## Verification

- Numbered formula sets: 12 expected, 12 stated, no omissions.
- `lake env lean LMLF/Blueprint/Gamma/Section518.lean`: passed; only the
  permitted `sorry` warnings and one harmless unused-proof linter warning.
- `cd doc && lake env lean LMLFManual/Chapter5/Section518.lean`: passed.
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter5/Section518.lean`:
  passed; all 14 source expressions accepted.
- No `#check`, `Classical.choose`, or existential convergence witness remains
  in the focused source/manual files.

The parent integration remains responsible for shared Chapter 5 registration
and aggregate coverage wiring; those files were intentionally not touched.

## Referee repair pass

- Decoupled `qBeta_jackson_hasSum` from `QBetaPoint`: it now takes explicit
  `q`, `a`, and `b` with exactly `0 < q < 1`, `0 < Re(a)`, and `0 < Re(b)`.
  The later E12 equality remains the separate `qBetaValue` statement.
- Renamed `qGammaPoleFree` to `qGammaDenomNeZero` and documented it as a
  denominator-only guard.  `QGammaPoint` remains the complete source-domain
  object carrying the q-base range plus that guard.
- Rechecked the focused source Lean build, standalone manual Lean build, and
  source TeX checker after both API repairs; all pass.
