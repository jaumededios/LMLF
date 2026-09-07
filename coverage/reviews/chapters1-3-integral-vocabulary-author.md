# Chapters 1–3 integral vocabulary author report

## Scope

This audit addressed the generic interfaces surfaced by §§5.9, 5.13, and
5.14, using the §5.9 and §5.14 object-first referee reports and the author
contract/design exemplar. The active §5.12 referee was treated as read-only:
no §5.12 E11 branch, winding, or convergence semantics were changed.

## Shared API

- `LMLF.Integral.C1Contour` remains the canonical finite C¹ contour and is now
  accompanied by `VerticalLine` in `LMLF/Integral/Curve.lean`. The shared
  vertical API provides `point`, `tangent`, `integrand`, ordinary whole-line
  `integral`, and `Integrable`.
- Symmetric finite vertical cutoffs are shared as
  `VerticalLine.symmetricSegment`, `symmetricSegmentIntegral`,
  `symmetricSegmentIntegrable`, `symmetricSegmentValue`, and
  `symmetricSegmentConverges`. The finite cutoff, totalized candidate value,
  and convergence predicate remain separate objects.
- `LMLF/Integral/Domain.lean` introduces `MultidimensionalDomain`,
  `domainIntegral`, and `domainIntegrable` for real-valued volume integrals on
  `Fin n → ℝ`. The fixed coordinate type and explicit carrier prevent silent
  dimension/measure changes.
- The generic definitions are taught in Chapter 3 with expandable exact Lean
  panels and ordinary prose. §§5.13 and 5.14 now consume the shared objects;
  §5.9 keeps only thin wrappers preserving its historical positive parameter
  `c` and the contour `Re s = -c`.
- `PiecewiseC1Contour` is also shared in `LMLF/Integral/Curve.lean` for
  branch-aware multi-piece paths. Its finite breaks are constrained to
  `[0,1]`, the path is globally continuous, endpoints are explicit, and the
  stored tangent is the derivative and is continuous away from joins. The
  two-log integral and integrability combinators moved with it. §5.12 E12 now
  consumes this shared object; E10 and all E11 branch semantics were left
  unchanged.

## Scaled Gamma decision

No scaled-Gamma definition was promoted. §5.9 uses a complex-valued object at
imaginary arguments, while §5.11 uses a positive-real object for its
asymptotic expansion. They are not the same typed reusable object, and no
second page currently consumes the complex definition. The §5.9 manifest
records this as an intentional follow-up rather than introducing needless
abstraction.

## Files changed

- `LMLF/Integral/Curve.lean`
- `LMLF/Integral/Domain.lean`
- `LMLF/Blueprint/Gamma/Section59.lean`
- `LMLF/Blueprint/Gamma/Section513.lean`
- `LMLF/Blueprint/Gamma/Section514.lean`
- `LMLF/Blueprint/Gamma/Section512.lean`
- `LMLF.lean`
- `doc/LMLFManual/Chapter3.lean`
- `doc/LMLFManual/Chapter5/Section59.lean`
- `doc/LMLFManual/Chapter5/Section513.lean`
- `doc/LMLFManual/Chapter5/Section514.lean`
- `doc/LMLFManual/Chapter5/Section512.lean`
- `coverage/sections/chapter5-59.json`
- `coverage/sections/chapter5-513.json`

No aggregate coverage file, generated site, or §5.12-specific declaration was
edited.

## Verification

- `lake build LMLF.Integral.Domain LMLF.Integral.Curve
  LMLF.Blueprint.Gamma.Section513 LMLF.Blueprint.Gamma.Section514
  LMLF.Blueprint.Gamma.Section59 LMLF.Blueprint.Gamma.Section512`: passed;
  only contract-allowed `sorry`
  warnings remain.
- `cd doc && lake build LMLFManual.Chapter3
  LMLFManual.Chapter5.Section513 LMLFManual.Chapter5.Section514
  LMLFManual.Chapter5.Section59 LMLFManual.Chapter5.Section512`: passed.
- `check_source_tex.mjs` passed for Chapter 3 and §§5.9, 5.13, and 5.14
  plus §5.12 (16, 43, 5, 9, and 12 source expressions respectively).
- No `#check` declarations were added; no generated-site or aggregate build
  was run.
