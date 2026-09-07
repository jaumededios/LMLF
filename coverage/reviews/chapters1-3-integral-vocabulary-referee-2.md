# Chapters 1–3 piecewise-contour vocabulary referee re-review

## Verdict

**ACCEPT.** The promoted `PiecewiseC1Contour`, `integral₂`, and `Integrable₂`
API is now in the shared contour module, is taught exactly in Chapter 3, and
is consumed by the §5.12 Pochhammer migration without a competing local
implementation. The continuity, join, endpoint, derivative, and tangent
invariants are coherent for finite piecewise-
`C¹` paths. I found no P0, P1, P2, or P3 finding.

## Snapshot and files reviewed

The review covers branch `site/verso-dlmf-overlay...origin/site/verso-dlmf-overlay`
at commit `31b53f8` (`Complete Chapter 4 DLMF statement overlay`) with the
shared, uncommitted changes in the worktree. Generated site output was ignored.
I reviewed:

* official [DLMF §5.12](https://dlmf.nist.gov/5.12), including the global
  principal-value convention and the E10–E12 path prose/captions;
* `LMLF/Integral/Curve.lean`;
* `LMLF/Blueprint/Gamma/Section512.lean` and
  `coverage/sections/chapter5-512.json`;
* `doc/LMLFManual/Chapter3.lean` and
  `doc/LMLFManual/Chapter5/Section512.lean`;
* the §5.12 author report and prior object-first referee report.

The independently computed numbered formula IDs are exactly
`5.12.E1`–`5.12.E12`. The manifest and manual state exactly this set, with
matching DLMF links and no quantitative companions.

## Shared API audit

`LMLF/Integral/Curve.lean:48–87` now contains the sole shared piecewise
contour vocabulary. The structure has the following invariant layers:

* `breaks : Finset ℝ` is finite, and `breaks_mem` places every possible join
  in `Icc 0 1`;
* `point_zero` and `point_one` expose endpoint compatibility with `start` and
  `finish`;
* `point_continuous : ContinuousOn point (Icc 0 1)` gives path continuity at
  every join, including the finite break points;
* `hasDerivOffBreaks` stores the tangent as the actual ambient derivative at
  every parameter in the interval outside the break set;
* `tangent_continuous_off_breaks` gives continuity of the tangent on each
  remaining piece, while allowing tangent jumps at joins.

This is the correct piecewise-
`C¹` boundary: the path itself is continuous, the tangent/derivative law is
required exactly where smoothness is expected, and finite exceptional points
need no derivative certificate because interval integrals ignore their values.
The endpoint equations do not overclaim differentiability or tangent
continuity at a break endpoint. An empty break set is also a valid smooth
special case.

`PiecewiseC1Contour.integral₂` and `.Integrable₂` use the same interval
orientation and stored tangent as `C1Contour`, while adding exactly the two
logarithm arguments needed by E12. Syntax/evaluation (`integral₂`) and the
integrability obligation (`Integrable₂`) remain separate declarations. No
raw `deriv` call, local tangent plumbing, or duplicate `PiecewiseC1Contour`
definition remains in §5.12.

Chapter 3’s prose at `doc/LMLFManual/Chapter3.lean:312–316` states the same
invariants in reader-facing terms: finite break set in `[0,1]`, path
continuity across joins, endpoint compatibility, derivative away from
breaks, and tangent continuity on the remaining pieces. The three new panels
at lines `319–347` are byte-for-byte equal to their source anchors. In the
Pochhammer migration, `PochhammerLogBranch.contour` is the shared object;
`curve_eq` ties its path to the canonical four-piece
`betaPochhammerCurve`, and the shared endpoint equations plus the explicit
curve give the return to `P`. The branch-specific log laws and principal
values remain in §5.12, where they belong.

## §5.12 migration audit

All twelve expected formulas are present and the new contour API is used at
the correct boundary:

* E1–E9 retain their typed domains, named integrands, separate integrability
  declarations, and guarded Gamma-quotient specializations.
* E10 correctly uses the existing shared `C1Contour` (a smooth loop), with an
  explicit stored tangent and finite-contour integrability.
* E11 keeps its coherent logarithm-lift object, explicit positive winding,
  source convergence conditions, finite truncation family, and supplied
  convergence datum; it does not reintroduce an unconditional `limUnder`
  value.
* E12 uses `PochhammerLogBranch.contour.integral₂` and
  `.Integrable₂`. The declaration preserves arbitrary `P ∈ (0,1)`, the
  `(1+, 0+, 1−, 0−)` order, return to `P`, continuous logarithm lifts, and
  principal values at the starting point. The conservative
  `GammaQuotientDefined` guard is consistently labeled as a specialization.

The old section-local `PiecewiseC1Contour`, `integral₂`, `Integrable₂`, and
raw derivative-based contour integral are absent. `rg` finds only the shared
definitions and the §5.12 calls to them. The promotion therefore has the
intended dependency direction: generic geometry in `LMLF.Integral.Curve`,
branch-specific path/log data in §5.12.

## Anchor and source checks

Independent anchor extraction found 38 source anchors in `Curve.lean`; all 35
reader-facing shared declarations represented in Chapter 3 match exactly.
The three omitted internal Hankel constructors remain intentionally exposed
through their public specification panels. The three new piecewise anchors
all match exactly. §5.12 has 71 source anchors and 71 manual anchors, with no
source-only, manual-only, or body-different anchor.

`node scripts/check_source_tex.mjs doc/LMLFManual/Chapter3.lean
doc/LMLFManual/Chapter5/Section512.lean` accepted all 28 source expressions.
No `#check`, filler status prose, or raw local `contourIntegral` remains in
the reviewed files.

## Build verification

All builds passed, with only the repository’s existing permitted `sorry` and
linter warnings:

* focused root: `lake build LMLF.Integral.Curve
  LMLF.Blueprint.Gamma.Section512` (2789 jobs);
* focused manual: `lake build LMLFManual.Chapter3
  LMLFManual.Chapter5.Section512` (3027 jobs);
* full root `lake build` (3379 jobs);
* full manual `lake build` (7358 jobs).

There are no unreviewed numbered §5.12 candidates relevant to this promotion.
The only generated-site changes were ignored as requested.
