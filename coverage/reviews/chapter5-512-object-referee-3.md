# §5.12 object-first referee final review

## Snapshot and scope

This is a read-only final audit of the current dirty worktree. The reviewed
objects are `LMLF/Blueprint/Gamma/Section512.lean`,
`doc/LMLFManual/Chapter5/Section512.lean`, `LMLF/Integral/Curve.lean`,
`doc/LMLFManual/Chapter3.lean`, and `coverage/sections/chapter5-512.json`.
Other worktree changes and generated HTML were ignored. The source reference
is [DLMF §5.12](https://dlmf.nist.gov/5.12), version 1.2.7.

**Verdict: ACCEPT.** No P0, P1, or P2 blocker remains in the repaired §5.12
object layer.

## Formula and manifest coverage

The source-inventory numbered formulas are exactly `5.12.E1` through
`5.12.E12`; the manifest has `formula_count: 12`, the same 12 `included_ids`,
and no omissions. A dry-run of the chapter coverage synchronizer accepted all
12 formula overrides and found no source-item no-claim mismatch. The manifest
maps E12's contour declarations to the shared
`LMLF.Integral.PiecewiseC1Contour` API.

The formula-level audit is:

- **E1--E4:** typed Euler domain, named integrand and integral, separate
  interval-integrability statement, and the stated values are present.
- **E5--E6:** named cosine and sine/Fourier integrands and integrals have the
  displayed intervals, factors, transformed beta arguments, and explicit
  conservative Gamma-quotient specialization domains.
- **E7:** the hyperbolic condition, named half-line integrand/integral, and
  `4^(a-1) B(a+b,a-b)` value are preserved.
- **E8--E9:** the vertical and Barnes integrands, orientations, convergence
  conditions, normalization factors, and quotient values are present; E9's
  extra `b ≠ 0` is visible.
- **E10:** the shared `C1Contour` stores the loop and tangent; the manual now
  correctly says it starts at `t=0`, circles `1` counterclockwise, returns to
  `0`, and uses pointwise principal powers.
- **E11:** `SecondLoopLogBranch` has coherent incoming, circle, and outgoing
  lifts. The canonical circle lift is `log ε + θ i`, the outgoing `t` lift
  carries `+2πi`, and `1+t` returns to its principal lift. The incoming and
  outgoing positive-ray pieces, explicit truncation family, and joins are
  named. `SecondLoopDomain` carries `Re b > 0`, `a ∉ ℤ`, and a cut point in
  `(-1,0)`. `SecondLoopIntegralData` stores a value together with the actual
  `Tendsto` convergence proof; the named integral is that supplied value, so
  nonexistence is not hidden by `limUnder`.
- **E12:** the explicit four-piece curve has positive loops `(1+,0+)`, then
  negative loops `(1-,0-)`, starts and ends at arbitrary `P ∈ (0,1)`, and the
  two continuous logarithm lifts are principal at `P`. The integral and
  integrability declarations use the shared two-log API.

E1--E4 and E7 are exact relations to the source hypotheses. E5, E6, E8,
E9, E10, E11, and E12 are explicitly labelled specializations because they
use the conservative `GammaQuotientDefined` guard (and E9 also requires
`b ≠ 0`). All 12 manifest entries have no quantitative analogue; no fake
error-bound companion was introduced.

## Resolution of prior findings

- **E11 P0s resolved.** The prior impossible endpoint constraints were
  replaced by a mathematically consistent winding branch. The canonical
  branch object is inhabited in the blueprint and its explicit formulas have
  the correct exponential, continuity, endpoint, and monodromy laws. The
  convergence/value split is now an honest explicit certificate over a named
  truncation family, with the source hypotheses carried by
  `SecondLoopDomain`.
- **E11/E12 prose P1 resolved.** The manual states the global principal-value
  convention, E11's cut between `-1` and `0`, principal initial powers,
  `+2πi` monodromy, and E12's full loop order and return to `P`. E10's
  starting-point description now agrees with its contour object and DLMF
  notation.
- **Gamma guard P2 resolved.** `GammaQuotientDefined` is conservatively and
  accurately documented as a sufficient all-three-Gamma nonvanishing guard,
  not as the exact finite meromorphic-beta locus. No stale `PoleFreeBeta` or
  “pole-free” description remains in §5.12.
- **Shared contour P2 resolved.** `PiecewiseC1Contour` now lives in
  `LMLF.Integral.Curve`, with finite breakpoints constrained to `[0,1]`, path
  continuity, endpoint/start compatibility, derivative agreement off the
  break set, and tangent continuity off the break set. Its `integral₂` and
  `Integrable₂` combinators are shared. Chapter 3 teaches the same structure
  and declarations, and E12 reuses them rather than embedding derivative
  plumbing or raw tangent fields in a section-local API.

## Anchors, ordering, and hygiene

Independent extraction finds exactly **71 unique anchors in the §5.12 Lean
source and 71 matching anchors in the §5.12 manual source**, with identical
sets and no duplicates. The three shared piecewise-contour anchors are
defined and taught in `LMLF.Integral.Curve`/Chapter 3, not duplicated in §5.12.
Panels precede first use: domains precede integrands, the Gamma guard precedes
transformed values, named integrals precede formula statements, and all E11
and E12 branch/contour objects precede their convergence/value declarations.
The focused §5.12 files contain no `#check` and no `limUnder`; no fake
quantitative panel is present.

## Validation

- `lake build LMLF.Blueprint.Gamma.Section512`: **passed**; this also builds
  the promoted `LMLF.Integral.Curve` API. Only the repository's existing
  `sorry`-based blueprint obligations produced warnings.
- From `doc/`, `lake env lean LMLFManual/Chapter5/Section512.lean`:
  **passed**.
- From `doc/`, `lake env lean LMLFManual/Chapter3.lean`: **passed**.
- `node scripts/check_source_tex.mjs
  doc/LMLFManual/Chapter5/Section512.lean`: **passed**; KaTeX accepted all
  12 source expressions.
- `python3 scripts/sync_chapter5_coverage.py --root . --chapter 5
  --first-section 12 --last-section 12 --expected-formulas 12 --dry-run`:
  **passed** (`formula_overrides: 12`, `source_item_no_claim: 0`).

Generated-site checks were intentionally not used because the generated HTML
is stale relative to the current source tree.
