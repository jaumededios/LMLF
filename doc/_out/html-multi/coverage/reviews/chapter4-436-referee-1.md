# Referee report: DLMF §4.36 Infinite Products and Partial Fractions

## Snapshot and files reviewed

Snapshot: `958aad0d1078c589a3f7e30a52dc1a32ddf8062c`. I reread the referee
contract, independently checked the official [DLMF §4.36](https://dlmf.nist.gov/4.36)
and the local source inventory, and reviewed exactly:

- `LMLF/Blueprint/Elementary/Section436.lean`;
- `doc/LMLFManual/Chapter4/Section436.lean`;
- `coverage/sections/chapter4-436.json`.

## Independent inventory and formula parity

The numbered inventory is exactly `4.36.E1` through `4.36.E5`. The manifest
expected/stated sets agree 5/5 with no omitted formulas. All five source
formulas have individual DLMF links and matching source/manual anchors.

## Formula and convergence audit

- **E1:** `sinhProduct` uses the source factor `z(1+z²/(n²π²))`, ordered by
  positive `n`, and its `Tendsto` target is `Complex.sinh z` for every complex
  `z`.
- **E2:** `coshProduct` uses the odd positive factors
  `1+4z²/((2n-1)²π²)` in increasing-index order and converges to `cosh z`.
- **E3:** `cothPartial` includes the `1/z` term and positive-index sum with
  the exact coefficient `2z`; the premise excludes every lattice pole
  `z = kπi`, and the target is the explicit quotient `cosh z/sinh z`.
- **E4:** `cschSqPartial` is a genuinely symmetric finite approximant over
  `n = -N,…,N`, preserving the source's symmetric summation convention. Its
  all-integer pole exclusion and target `(1/sinh z)^2` are explicit.
- **E5:** `cschPartial` has the source alternating factor `(-1)^n`, positive
  index order, `1/z` term, and the same complete pole-free lattice domain.

The finite products and partial sums avoid asserting a raw infinite product or
series as a Lean value at a pole. The symmetric E4 ordering is visible in the
definition rather than left to an unspecified infinite-sum convention. No
distinct quantitative remainder or truncation bound appears in the DLMF page,
so no quantitative companion is required.

## Prose and non-formula inventory

The ordinary-language page states that variables are complex, identifies the
pole lattice for E3–E5, explains the finite-approximant interpretation, and
preserves the source note that §4.36 follows from §4.22 after replacing `z` by
`i z`. The inventory also contains one annotation-note record for that same
source note; it is represented in prose, though not as a separate manifest
declaration. This is a minor bookkeeping/API issue only, since there is no
additional mathematical claim beyond the linked source note.

The helper definitions are readable and directly expose the product/partial
sum order. They are used by the anchored formula disclosures rather than
serving as opaque predicates.

## Verification

- `lake build LMLF.Blueprint.Elementary.Section436` — passed;
- from `doc/`, `lake env lean LMLFManual/Chapter4/Section436.lean` — passed;
- formula anchors: 5 source / 5 manual;
- no `#check`, filler status prose, or proof work displacing statement
  coverage.

The source emits two long-line style warnings on helper definitions and the
expected `sorry` warnings; neither affects elaboration or source fidelity.

## Verdict: accept

All five infinite-product/partial-fraction formulas are represented with
correct finite approximants, ordering, pole domains, and convergence targets.
No P0 or P1 finding remains.
