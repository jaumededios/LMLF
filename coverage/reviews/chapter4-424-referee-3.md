# Final referee report: DLMF §4.24 Further Properties

## Snapshot and files reviewed

Snapshot: `4c16e1da2c62b9eb5d69cab6fdd52f201570b17d`. I reread the referee
contract and `coverage/reviews/chapter4-424-referee-2.md`, independently checked
the official [DLMF §4.24](https://dlmf.nist.gov/4.24) and the local source
inventory, and reviewed exactly:

- `LMLF/Blueprint/Elementary/Section424.lean`;
- `doc/LMLFManual/Chapter4/Section424.lean`;
- `coverage/sections/chapter4-424.json`.

## Inventory and formula parity

The independent numbered inventory is exactly `4.24.E1` through `4.24.E17`.
The manifest expected and stated sets agree exactly, with no omissions. All
seventeen formulas have individual DLMF links and matching source/manual
anchors.

## Domain and branch audit

- **E1–E3:** The direct `HasSum` declarations preserve the source coefficients,
  closed convergence domains, and branch-point exclusions.
- **E4:** The exterior expansion is a genuine inverse-power series, with the
  sign selected by the nonzero real-part half-plane and the source condition
  `|z| ≥ 1`.
- **E5–E6:** The transformed series uses `Re(z²) > -1/2`, and E6 records its
  real-coordinate hyperbola boundary.
- **E7–E8:** The principal arcsine/arccosine derivatives use the explicit
  complement of the real cuts `(-∞,-1]` and `[1,∞)`.
- **E9:** `principalArctanDomain` excludes both full imaginary branch rays
  `i[1,∞)` and `i(-∞,-1]`, not only the points `±i`.
- **E10–E11:** The hypotheses retain `z ≠ 0, ±1`, the open-half-plane sign
  condition, and both cut exclusions: `z.re ≠ 0` excludes the imaginary-axis
  cut while `principalArcCscSecDomain` excludes the real segment `[-1,1]`.
- **E12:** The explicit `z ≠ 0` reciprocal-domain condition is combined with
  `principalArccotDomain`, which excludes the complete pulled-back imaginary
  segment `[-i,i]` (and hence its poles).
- **E13–E14:** The inverse-sine and inverse-cosine relations are pointwise
  membership equivalences, quantify `σ = ±1`, and retain both square-root
  choices.
- **E15:** The signed tangent relation has the explicit premise
  `1 - σ*u*v ≠ 0`.
- **E16:** The mixed sine/cosine relation retains both right-hand descriptions
  and both square-root witnesses.
- **E17:** The mixed tangent/cotangent relation has both required denominator
  premises `v - σ*u ≠ 0` and `u*v + σ ≠ 0`.

The reusable `arctanValues` and `arccotValues` predicates require respectively
`Complex.cos w ≠ 0` and `Complex.sin w ≠ 0`, so totalized tangent/cotangent
values at poles cannot enter the multivalued relations. The manual explains
these domains and conventions as mathematical content rather than hiding them
in opaque proxies. All E7–E12 specializations are honestly labeled as
principal-branch declarations in the manifest.

## Prose, quantitative coverage, and API

The manual covers the source subsection prose, series/derivative branch
conventions, and multivalued interpretation. The manifest has no omitted
numbered IDs and no unreviewed mathematical source candidate. DLMF §4.24
contains no distinct error bound, truncation estimate, or other quantitative
companion requiring a second declaration. Definitions for branch domains,
series terms, value sets, and signed sums are transparent and reusable.

## Verification

- `lake build LMLF.Blueprint.Elementary.Section424` — passed;
- from `doc/`, `lake env lean LMLFManual/Chapter4/Section424.lean` — passed;
- formula anchors: 17 source / 17 manual;
- no `#check`, filler status prose, or displaced proof work.

## Verdict: accept

The prior syntax, branch-domain, denominator, and totalized-pole blockers are
all repaired. E1–E17 are covered with complete readable declarations, exact
manifest parity, and successful source/manual builds. No P0 or P1 finding
remains.
