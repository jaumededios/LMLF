# Referee review: DLMF §5.13

## Snapshot and files reviewed

- Snapshot: `f4176ce69852c435e838eeb0b6da69c510f81fef` (2026-09-06).
- Official source: [DLMF §5.13](https://dlmf.nist.gov/5.13), version 1.2.7 (release
  2026-06-15), including the section notes and all five formula endpoints.
- Lean source: `LMLF/Blueprint/Gamma/Section513.lean`.
- Manual source: `doc/LMLFManual/Chapter5/Section513.lean`.
- Section manifest: `coverage/sections/chapter5-513.json`.
- Source inventory: `coverage/dlmf-4-10-source-inventory.json` (the §5.13
  candidates are the `p1`, `Px1.p1`, `Px2.p1`, `Px3.p1`, and `Px3.p2` prose or
  note records plus E1–E5).
- Rendered page: no standalone §5.13 page is present in the checked-in
  `doc/_out/html-multi` tree; the standalone source is not imported by the
  current `doc/LMLFManual/Chapter5.lean`. The parent-owned site integration was
  therefore not available for visual anchor inspection.

## Independently computed formula IDs and verdict

The official page and source inventory contain exactly:

`5.13.E1`, `5.13.E2`, `5.13.E3`, `5.13.E4`, `5.13.E5`.

The manual and manifest state exactly this set, with no omitted or extra numbered
IDs. Verdict: **accept**. The three findings from the initial review are
resolved, and no P0–P3 finding remains in the assigned source files.

## Resolution checks

### Resolved P0 — E1 nonzero phase domain

- Files/declaration: `LMLF/Blueprint/Gamma/Section513.lean:43-53`,
  `LMLF.Blueprint.Gamma.Section513.dlmf_5_13_1`; documentation at
  `doc/LMLFManual/Chapter5/Section513.lean:29-59`.
- The theorem now has `hz0 : z ≠ 0` in addition to
  `|Complex.arg z| < Real.pi`, and the prose explicitly says that the phase
  domain is for nonzero `z`. This closes the counterexample from the first
  review (`a=0`, `b=1`, `c=1/2`, `z=0`) under Mathlib's totalized `cpow`.
- The manifest's E1 note also records the explicit nonzero domain. The vertical
  contour, upward orientation, `ds = i dt`, principal powers, normalization,
  and all three source inequalities remain faithful.

### Resolved P2 — E5 removable value at `t = 0`

- Files/declaration: `LMLF/Blueprint/Gamma/Section513.lean:113-124`,
  `dlmf_5_13_5`; documentation at
  `doc/LMLFManual/Chapter5/Section513.lean:165-199`.
- The page now explains that Mathlib's totalized Gamma/division operations give
  the quotient its removable value `0` at `t=0`, that the reciprocal-Gamma
  product has the same limit, and that changing one point does not affect the
  ordinary Lebesgue integral. The manifest records the same convention.

### Resolved P3 — headings and E2 source relation

- The manual now labels E4 and E5 with the source headings “Ramanujan's Beta
  Integral” and “de Branges--Wilson Beta Integral” at lines 128 and 160.
- The E2 prose at lines 71–73 records the DLMF specialization from E1
  (`c=0`, `b=a`, `s=it`, `z=exp(i(π-2b))`) and explains the harmless `t ↦ -t`
  orientation change. The manifest notes the same relationship.

## Formula-by-formula audit

- **E1** — `dlmf_5_13_1` matches the source contour formula and now has the
  required nonzero phase-domain hypothesis. `Integrable` expresses ordinary
  (absolute/Bochner) convergence; no Cauchy principal value is used.
- **E2** — `dlmf_5_13_2` honestly specializes to real `a,b`, preserving
  `a > 0`, `0 < b < π`, the modulus square, exponential weight, real Gamma,
  real power, and normalization. The whole-line integral is ordinary and
  absolutely integrable, not a principal value.
- **E3** — `dlmf_5_13_3` preserves all four complex parameters and their
  positive-real-part conditions, the `+it/-it` signs, quotient, and `1/(2π)`
  factor. Its whole-line integral is ordinary Bochner integrability.
- **E4** — `dlmf_5_13_4` retains only the source condition
  `Re(a+b+c+d) > 3`; the reciprocal Gamma product, shifts, quotient, and
  unnormalized whole-line integral match the source. Reciprocal Gamma removes
  the apparent Gamma poles, so no principal value is needed.
- **E5** — `dlmf_5_13_5` uses `Fin 4 → ℂ` for all four parameters, all four
  `±it` numerator pairs, and a nested `j < k` product for exactly six pairwise
  Gamma factors. The positive-real-part condition, `1/(4π)` factor, ordinary
  integral, and removable-point convention match the source.

No declaration is an opaque proxy: the contour and numerator helpers expose
the actual parameterizations/products, and every formula theorem displays the
integrand and right-hand side. All anchors enclose complete declarations and
specify `module := LMLF.Blueprint.Gamma.Section513`; no `#check`, filler status
prose, or proof work displacing statement coverage was found. The five
`sorry`s are the manifest's declared proof-pending placeholders and are
permitted by the referee contract.

## Correctly handled specializations and quantitative pairs

- E2 is correctly classified as the real-parameter specialization, with its
  E1 derivation note stated honestly. E1, E3, E4, and E5 retain the source's
  complex parameter domains; E1 additionally makes the nonzero phase domain
  explicit for Lean.
- `verticalLineIntegral` and `deBrangesWilsonNumerator` are useful, genuinely
  distinct vocabulary rather than quantitative companions.
- No DLMF §5.13 display calls for a second quantitative declaration; all five
  manifest entries correctly use `quantitative_analogue: not_applicable`.

## Build result and unreviewed candidates

- `lake env lean LMLF/Blueprint/Gamma/Section513.lean`: **passed**, with the
  five expected `declaration uses sorry` warnings.
- Root `lake build LMLF`: **passed** (2929 jobs).
- From `doc/`, `lake env lean LMLFManual/Chapter5/Section513.lean`: **passed**.
- From `doc/`, `lake build`: **passed** (6304 jobs).
- No rendered §5.13 page was available because the standalone page is not
  imported by the current Chapter 5 aggregator; this is parent-owned
  integration, not a standalone-file elaboration failure.

The sampled `p1` prose (straight vertical path) is represented by the E1
description and `verticalLineIntegral`. The three source beta-integral headings
and the E2-from-E1 note are now represented. The final `Px3.p2` compendia
paragraph is bibliographic, not a missing mathematical declaration. No other
mathematically substantive source candidate remains unreviewed.
