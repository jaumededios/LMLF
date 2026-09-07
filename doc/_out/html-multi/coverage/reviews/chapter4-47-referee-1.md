# DLMF §4.7 referee report

## Snapshot and files reviewed

- Snapshot: `703f1ad1d96c360bbac555c43dc39f6ca64d1a7b`.
- Official source: [DLMF §4.7](https://dlmf.nist.gov/4.7), including the
  logarithm and exponential/power subsections and their notes.
- Source inventory: `coverage/dlmf-4-10-source-inventory.json`.
- Lean source: `LMLF/Blueprint/Elementary/Section47.lean`.
- Documentation: `doc/LMLFManual/Chapter4/Section47.lean`.
- Manifest: `coverage/sections/chapter4-47.json`.
- No rendered §4.7 page is present in the checked-in `doc/_out/html-multi`
  tree; standalone source elaboration was checked directly.

## Independently computed expected IDs and verdict

The official page and inventory contain exactly
`4.7.E1` through `4.7.E15`.  The manifest and documentation contain exactly
that same set, with no omissions or extras.

**Verdict: revise.** P0 findings remain in the principal-logarithm and
variable-base-power declarations, and P1 findings remain in the differential-
equation declarations. The numbered coverage count is complete, but the
current API does not faithfully state several source results.

## Findings

### P0 — principal-logarithm domain is too broad (E1, E3)

`LMLF/Blueprint/Elementary/Section47.lean:23-36` states `deriv Complex.log z`
and all iterated derivatives for every `z ≠ 0`. The DLMF principal logarithm
is a branch-domain statement; its principal branch cut must be excluded (or a
local holomorphic branch/domain hypothesis supplied). At a nonzero point on
the negative real axis, the principal `Complex.log` is not holomorphic in a
neighborhood, so the displayed derivative assertions are not valid with only
`z ≠ 0`. The documentation repeats this overbroad claim at E1 and E3.

Repair by restricting `z` to a branch domain (for example, `z ∉ Set.Iic 0`
for the standard principal branch, with the exact Mathlib domain theorem), or
by using a local `HasDerivAt`/`HasDerivAtIterated` hypothesis. Apply the same
domain to E3; retain `n > 0` and the displayed factorial and power.

### P0 — variable-base complex power uses no branch-domain hypothesis (E10, E11)

`z_cpow_deriv` and `z_cpow_iteratedDeriv` at lines 76-88 use Mathlib's
principal `Complex.cpow` with only `z ≠ 0`, while the page prose says “a fixed
power branch.” Principal `cpow` is not holomorphic across its branch cut, so
the derivative and higher derivatives are false at/through the cut under the
declared hypotheses. E11 additionally needs the same local branch conditions
for every derivative order. This is a material mismatch between the formal
statement and both DLMF's branch convention and the prose.

Repair by making the branch explicit (a local branch function with derivative
`a / z`, or a domain hypothesis excluding the cut) and stating the derivative
on that domain. Update the manifest relation/notes to identify the resulting
specialization honestly.

### P1 — E5, E6, E12, E13, E14, and E15 are tautological wrappers

The declarations at lines 48-62, 91-117 assume exactly the proposition they
return: `logarithmicDifferentialEquation` returns `hODE`,
`logarithmicSolution` returns `hsol`, and the same pattern occurs in
`linearDifferentialEquation`, `linearDifferentialSolution`,
`secondOrderExponentialEquation`, and `secondOrderExponentialSolution`.
`hf`, `hnz`, `hF`, and `ha` are either unused or do not connect the hypotheses
to a derived conclusion. These do not express the DLMF differential equations
or their solution forms as reusable mathematics, and violate the contract's
prohibition on opaque wrapper predicates.

Repair E5/E12 with actual equations whose hypotheses establish analyticity and
the relevant derivative relation; repair E6/E13 with a local logarithm or
antiderivative hypothesis and a conclusion derived from it. For E14/E15,
state the second-order equation and a genuine solution characterization (with
the chosen square-root branch and arbitrary constants), rather than repeating
the equation/solution as an assumption.

### P2 — E4's branch hypothesis is stronger and less readable than needed

`generalLog_iteratedDeriv` takes `hLn : ∀ w ≠ 0, HasDerivAt Ln (1 / w) w`,
which describes a globally chosen derivative on all nonzero points even though
a general logarithm branch is local. The declaration is readable and the
manifest labels it a specialization, but a local branch/domain hypothesis
would better match the source and avoid suggesting a globally single-valued
logarithm on `ℂ ∖ {0}`.

## Correctly handled items and quantitative pairs

- E2 correctly exposes an arbitrary branch through `HasDerivAt` and derives
  the derivative value with `deriv`.
- E7 and E8 correctly use complex differentiation of `exp z` and `exp (a z)`.
- E9 correctly records the principal constant-base power and `a ≠ 0`, with
  `Complex.log a` in the derivative.
- E3/E4 retain the positive-integer condition `n > 0`, factorial coefficient,
  and `z⁻ⁿ` shape, subject to the branch-domain repair above.
- All 15 source formulas appear in the documentation with the corresponding
  stable `.E` links and open anchors; no second quantitative declaration is
  warranted by §4.7.

## Verification

- `lake env lean LMLF/Blueprint/Elementary/Section47.lean`: passed, with 15
  permitted `sorry` warnings.
- From `doc/`, `lake env lean LMLFManual/Chapter4/Section47.lean`: passed.
- Neither source file contains `#check` or proof work displacing coverage.
- No rendered page was available for visual anchor inspection. The source's
  substantive prose candidates (the local-solution transitions before E5/E6,
  E12/E13, and E14/E15) are represented in the page, but their Lean APIs need
  the repairs above.
