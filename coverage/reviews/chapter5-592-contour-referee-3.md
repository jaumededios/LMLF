# DLMF §5.9.2 contour referee review (post-repair)

## Verdict

**Accept.** No P0 or P1 issue remains in the contour vocabulary or the §5.9.2
statement. Repair text: none.

This is a final audit of the current post-repair tree. The generated HTML was
not used as a rejection criterion because its regeneration is parent-owned.

## Scope and source comparison

- Reviewed `LMLF/Integral/Curve.lean`,
  `LMLF/Blueprint/Gamma/Section59.lean`, `doc/LMLFManual/Chapter3.lean`,
  `doc/LMLFManual/Chapter5/Section59.lean`, and
  `coverage/sections/chapter5-59.json`.
- DLMF 5.9.E2 is
  `1/Gamma(z) = (1/(2*pi*i)) integral_{-infty}^{(0+)} exp(t)t^(-z) dt`;
  the official text specifies a positively circling contour around zero,
  returning to `-infty`, with the power continued along the contour. The
  manual's prose, source TeX, and Lean statement preserve this source
  normalization and branch interpretation.
- The section manifest has all 25 numbered source IDs (`5.9.E1` through
  `5.9.E20`, including the `_1`, `_2`, and `_5` IDs), with none omitted. The
  E2 declaration names and notes agree with the current contour API.

## Mathematical/API findings

### C¹ and branch-aware integration

`C1Contour` stores the point, a continuous tangent, named endpoints, and a
`HasDerivWithinAt` law on `Icc 0 1`. `C1Contour.integral` is exactly the
parameterized `∫ f (gamma t) * tangent t`, and its `IntervalIntegrable`
predicate is explicit. This avoids silently totalizing an ambient derivative at
an endpoint. `LogLiftedC1Contour` adds a continuous logarithm lift and the
exponential compatibility equation; its integral and integrability predicate
accept both point and lift, which is the needed semantics for `exp(-z Log t)`.

### Orientation, radii, and branch formulas

`HankelRadii` enforces `0 < inner < outer`; `PositiveRadius` and
`OuterRadius epsilon` prevent invalid finite contours from entering the limits.
The three current specifications are faithful:

- lower bank: `-r_-(u)`, with `r_-` decreasing from `R` to `epsilon`, positive
  real tangent `R - epsilon`, and lift `log(r_-) - pi*i`;
- inner circle: `epsilon * exp(i*(-pi + 2*pi*u))`, tangent equal to the point
  times `2*pi*i`, hence counterclockwise from argument `-pi` to `+pi`, with the
  continuous lift `log epsilon + i*(-pi + 2*pi*u)`;
- upper bank: `-r_+(u)`, with `r_+` increasing from `epsilon` to `R`, negative
  real tangent `-(R - epsilon)`, and lift `log(r_+) + pi*i`.

`HankelContour` now stores lower/circle and circle/upper point joins, closure,
and both logarithm-lift join equalities. Thus the generic three-piece value
cannot silently splice incompatible branch lifts; the canonical
`hankelContour` supplies these fields for the displayed formulas.

### Improper convergence and normalization

`HankelContour.Integrable` requires integrability on all three finite pieces.
`HasHankelIntegral` quantifies every admissible finite pair, takes the outer
radius limit at fixed positive inner radius, and only then takes the positive
inner-radius limit via `positiveRadiusAtZero`. This is the required ordered
two-stage interpretation of the Hankel loop. `HasHankelRepresentation` states
`value = normalization * integral`; §5.9.2 uses
`normalization = 1/(2*pi*I)` and `value = 1/Gamma z`, exactly matching the
printed DLMF formula.

## Documentation, anchors, and checks

- The Chapter 3 disclosure teaches the stored tangent, branch lift, explicit
  three-piece geometry, endpoint/branch joins, admissible radii, piecewise
  integrability, and ordered limits. The Chapter 5 disclosure repeats the
  three exact bank/circle specs and the E2 normalization.
- Anchor blocks are balanced and resolve to the current declarations. The
  source files contain no `#check`, filler/status prose, or TODO markers in
  the reviewed contour/E2 material.
- `lake build` completed successfully at the repository root (including
  `LMLF.Integral.Curve` and `LMLF.Blueprint.Gamma.Section59`) and in `doc/`
  (including the Chapter 3/5 manuals and site target; only expected blueprint
  `sorry` warnings remain).
- `node scripts/check_source_tex.mjs` accepted all 16 Chapter 3 expressions
  and all 44 Chapter 5 expressions. `node scripts/check_rendered_tex.mjs`
  accepted all 394 generated expressions. The rendered page still reflects a
  parent-owned pre-regeneration snapshot in places; this is stale output, not
  a source/manual/manifest defect for this review.

No additional repair is requested.
