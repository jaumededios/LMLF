# DLMF §5.10 referee 2 final re-review

## Snapshot and files reviewed

- Snapshot: `f4176ce69852c435e838eeb0b6da69c510f81fef` (`docs: publish rebuilt LMLF site`); the assigned §5.10 author files are workspace additions in this worktree.
- Official source: [DLMF §5.10](https://dlmf.nist.gov/5.10), version 1.2.7 (release 2026-06-15), including [5.10.E1](https://dlmf.nist.gov/5.10.E1) and [5.10.E2](https://dlmf.nist.gov/5.10.E2).
- Source inventory: `coverage/dlmf-4-10-source-inventory.json`.
- Lean author file: `LMLF/Blueprint/Gamma/Section510.lean`.
- Documentation author file: `doc/LMLFManual/Chapter5/Section510.lean`.
- Manifest: `coverage/sections/chapter5-510.json`.
- Rendered page: no standalone §5.10 page is present in the checked-in `doc/_out/html-multi` tree; `doc/LMLFManual/Chapter5.lean` does not import the standalone page, so visual anchor checks were unavailable.
- Re-review scope: the third revision of the three assigned author files, with special attention to whether the existence/choice API is non-circular, exposes the E2 values, and carries the full-coefficient convergence assertion used by E1.

## Independently computed expected formula IDs

Filtering the source inventory for `kind = numbered_formula` and `location.section = "5.10"` gives exactly `5.10.E1` (display `5.10.1`) and `5.10.E2` (display `5.10.2`). E2 is one grouped display whose seven TeX components `5.10.E2a`–`5.10.E2g` give `a₀` through `a₆`. The manifest and documentation contain exactly these two display IDs, with no omitted or extra numbered formula.

## Final verdict

`accept`

The third revision removes the arbitrary tail premise. The independent theorem `exists_gammaContinuedFractionCoeff` asserts existence of one full coefficient sequence with the seven displayed E2 values and the E1 convergence/value property for every positive real argument. `gammaContinuedFractionCoeff` is the `Classical.choose` witness, and `gammaContinuedFractionCoeff_spec` is obtained directly from `Classical.choose_spec`; E1 and E2 are then separate projections of that specification. This dependency is non-circular at the declaration level: the existential assertion precedes and does not refer to either downstream declaration. The finite-convergent recursion, truncation orientation, positive-real specialization, E2 arithmetic, coverage, and builds all pass.

## Findings

No P0, P1, P2, or P3 findings remain.

The former arbitrary-tail defect is resolved by moving the convergence/value property into the existential source assertion itself. This is not a circular premise in the API under review: `exists_gammaContinuedFractionCoeff` does not invoke `gammaContinuedFractionCoeff`, `gammaContinuedFractionCoeff_spec`, `dlmf_5_10_1`, or `dlmf_5_10_2`; the latter three declarations occur afterward and only consume `Classical.choose_spec`. The existential predicate constrains the entire chosen function through `∀ x : ℝ, 0 < x → Tendsto ...`, while separately exposing all seven source coefficients. Its proof remains pending (`sorry`), as recorded by the manifest, but that is the single source-level convergence assertion rather than an arbitrary coefficient premise or a hidden downstream assumption.

The recursive construction itself is correctly oriented. Unfolding gives
`continuedFractionConvergent coeff z 0 = a₀/z`, then
`a₀/(z + a₁/z)`, then `a₀/(z + a₁/(z + a₂/z))`. This is the standard right-truncation at the final denominator `z` of DLMF's `a₀/(z+) a₁/(z+) …` notation, and `atTop` correctly expresses increasing depth. No truncation-direction or off-by-one defect was found.

## Formula-by-formula disposition

- **5.10.1 / E1** — The source link, `Re z > 0` context in the documentation, finite-convergent construction, and positive-real specialization are represented. `0 < x` is the right restriction for `Real.log x` and `Real.log (Real.Gamma x)`; the page explicitly says this is not the full complex general-logarithm statement. The chosen full sequence and its convergence/value property come from `gammaContinuedFractionCoeff_spec.2`, without a circular dependence on E1.
- **5.10.2 / E2** — The seven values are grouped as one source record, and the Lean conjunction has the exact source values:
  `1/12`, `1/30`, `53/210`, `195/371`, `22999/22737`, `29944523/19733142`, and `109535241009/48264275462`. The index order and rational embedding into `ℂ` are correct. The source's note that exact later values can be found in external references does not add another numbered formula or quantitative companion.

No distinct quantitative declaration is warranted for either source formula, and the manifest's `quantitative_analogue: false` entries are appropriate.

## Build and source-candidate checks

- `lake env lean LMLF/Blueprint/Gamma/Section510.lean`: passed with one expected `sorry` warning for `exists_gammaContinuedFractionCoeff`; E1 and E2 are proved by direct `choose_spec` projections.
- From `doc/`, `lake env lean LMLFManual/Chapter5/Section510.lean`: passed.
- From `doc/`, `lake build lmlf-site`: passed.
- The anchor snippets expose the complete declarations and include the module namespace; neither assigned author file contains `#check`, filler status prose, or proof work displacing statement coverage.
- Sampled source candidates: the section-wide `Re z > 0` prose, E1's editorial note distinguishing general `Ln Γ` from principal `ln Γ`, E2's seven component formulas, and E2's later-coefficient/reference note. All are represented: the page explicitly says that later coefficients are supplied existentially because the source refers to external tables rather than printing them. No additional numbered formula or quantitative companion is omitted.
