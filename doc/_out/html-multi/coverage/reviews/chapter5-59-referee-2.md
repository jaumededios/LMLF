# DLMF §5.9 referee 2 report

## Snapshot and files reviewed

- Snapshot: `f4176ce69852c435e838eeb0b6da69c510f81fef` (`docs: publish rebuilt LMLF site`); the §5.9 author files are workspace additions at review time.
- Official source: [DLMF §5.9](https://dlmf.nist.gov/5.9), version 1.2.7 (release 2026-06-15), including the TeX endpoints linked from each formula and Figure 5.9.1.
- Source inventory: `coverage/dlmf-4-10-source-inventory.json` (all §5.9 numbered formulas and prose/figure/annotation candidates).
- Lean author file: `LMLF/Blueprint/Gamma/Section59.lean`.
- Documentation author file: `doc/LMLFManual/Chapter5/Section59.lean`.
- Manifest author file: `coverage/sections/chapter5-59.json`.
- The committed rendered output has no standalone §5.9 page (the §5.9 source is not imported by the current `Chapter5.lean`); consequently no rendered §5.9 page was available to inspect. Standalone Lean elaboration of both author files was available and was checked.

## Independently computed expected formula IDs

Filtering the source inventory for `kind = numbered_formula` and `location.section = "5.9"` gives, in document order:

`5.9.E1`, `5.9.E2`, `5.9.E2_5`, `5.9.E3`, `5.9.E4`, `5.9.E5`, `5.9.E6`, `5.9.E7`, `5.9.E8`, `5.9.E9`, `5.9.E10`, `5.9.E10_1`, `5.9.E10_2`, `5.9.E11`, `5.9.E11_1`, `5.9.E11_2`, `5.9.E12`, `5.9.E13`, `5.9.E14`, `5.9.E15`, `5.9.E16`, `5.9.E17`, `5.9.E18`, `5.9.E19`, `5.9.E20`.

The manifest and page state exactly this set: no numbered IDs are omitted or added.

## Verdict

`accept`

The previous P0 Hankel-branch finding and P2 removable-singularity finding are resolved. The revised declarations are source-faithful, the positive-real specializations are labeled honestly, the manifest agrees with the declarations, and both author files elaborate. No P0/P1/P2/P3 findings remain.

## Resolution checks

- **5.9.E2 branch and contour:** `LMLF/Blueprint/Gamma/Section59.lean:27-43` now defines the Hankel contour directly for `z`. On the lower bank it uses `log r - π i` and differential `exp(-π i)`, on the circle it uses the continuous argument `log ε + θ i` with `θ ∈ [-π,π]` and the correct `dt` factor, and on the upper bank it uses `log r + π i` and differential `exp(+π i)`. The orientations remain `R..ε`, `-π..π`, and `ε..R`, matching the contour in [DLMF 5.9.E2](https://dlmf.nist.gov/5.9.E2). The theorem at `:59-65` uses the repaired helper, and the documentation at `doc/LMLFManual/Chapter5/Section59.lean:48-74` explicitly explains the two continuous bank arguments and both limits. The manifest now records E2 as `exact` with a branch-aware note.
- **5.9.E2_5 removable value:** `temmePhase` is documented at `LMLF/Blueprint/Gamma/Section59.lean:69-74` and `doc/LMLFManual/Chapter5/Section59.lean:82-98` as having a totalized value at the removable point `t=0` that is immaterial to the interval integral.
- **5.9.E20 removable quotient:** `LMLF/Blueprint/Gamma/Section59.lean:339-346` and `doc/LMLFManual/Chapter5/Section59.lean:486-502` explicitly state that the totalized quotient at `t=1` differs only on a measure-zero set and does not affect the integral.

## Formula-by-formula disposition

- **5.9.E1** — Correct generalized Euler integral: `μ > 0`, `Re ν > 0`, `Re z > 0`, positive-real `t^μ`, principal complex powers, and an explicit `IntegrableOn` conjunct.
- **5.9.E2** — Correct branch-aware finite Hankel contour, orientation, two limiting processes, and reciprocal-Gamma normalization.
- **5.9.E2_5** — Correct `Re z > 0` phase representation on `[-π,π]`, with the removable-value convention documented.
- **5.9.E3** — Correct `c > 0`, `Re z > 0`, real-axis path, absolute/Bochner integrability, and principal power applied to `|t|`.
- **5.9.E4** — Correct exclusion of exactly `z = 0,-1,-2,…`, tail integral from 1, and summable correction series.
- **5.9.E5** — Correct `n : ℕ`, `-n-1 < Re z < -n`, range `0..n` Taylor subtraction, and integrability on `(0,∞)`.
- **5.9.E6/E7** — Correct conditional convergence domains and finite-cutoff `Tendsto` formulations; the positive-real integration path is represented by intervals `(0,R)`.
- **5.9.E8/E9** — Correct integer regime `n ≥ 2` (equivalent to `n=2,3,…`) and cosine/sine Gamma values.
- **5.9.E10/E10_1/E10_2** — Correctly labeled positive-real specializations of the branch-sensitive Binet formulas; `x > 0` makes `Real.log (Real.Gamma x)` the corresponding real logarithm and the kernels are paired with `IntegrableOn`.
- **5.9.E11** — Correct positive-real specialization with `1 < c < 2`; `verticalLineIntegral` parameterizes the line `Re s = -c` upward and the integrability assertion uses the same differential factor `i`. The source phase restriction is automatically satisfied by `x > 0` and the specialization is stated honestly.
- **5.9.E11_1/E11_2** — Correctly labeled positive-real specializations; the two ray arguments `±t i`, denominator sign swaps, scaled-Gamma normalization, and both convergence assertions match the source.
- **5.9.E12–E16** — Correct positive-real specializations, including the cancellation kernels, `(0,1)` interval for the second E16 integral, and explicit integrability assertions.
- **5.9.E17** — Correct positive-real specialization of the upward Mellin–Barnes line with `1 < c < 2`; exponent `-s-1`, zeta factor, and `1/(2πi)` normalization match the source.
- **5.9.E18** — All four Euler-constant representations are retained, with the five needed convergence assertions and the split `(0,1)`/`[1,∞)` integrals.
- **5.9.E19** — Correct `n ≥ 0`, `Re z > 0`, logarithmic kernel, and `iteratedDeriv n Complex.Gamma` formulation.
- **5.9.E20** — Correct right-half-plane hypotheses and explicit straight-segment path; the removable quotient at `t=1` is now explained.

## Correctly handled specializations and quantitative pairs

Correctly labeled positive-real specializations are E10, E10_1, E10_2, E11, E11_1, E11_2, E12, E13, E14, E15, E16, and E17. Their source branch/phase restrictions are implied by `x > 0`, and the documentation says that these are specializations rather than full complex formulas. E1–E9 and E18–E20 are presented as the corresponding complex/general statements.

No DLMF §5.9 formula requires a distinct quantitative declaration. The manifest correctly marks every `quantitative_analogue` as `not_applicable`; no second declaration has been introduced.

## Build and source-candidate checks

- `lake env lean LMLF/Blueprint/Gamma/Section59.lean`: **passed**, with the 25 expected `sorry` warnings and no errors.
- `lake build LMLF`: **passed**.
- `lake env lean LMLFManual/Chapter5/Section59.lean` from `doc/`: **passed** after the root library build.
- Manifest recomputation confirms exact equality of expected/stated IDs, no omitted IDs, E2 relation `exact`, and no quantitative declarations.
- The rendered §5.9 page is unavailable because the standalone page is not imported into the current main manual; this is recorded rather than charged as a source-file elaboration failure.
- Neither author source contains `#check`, filler status prose, or displaced proof work.
- The inventory’s prose candidates `5.9#i.p1`, `5.9#Px1.p1`, `5.9#Px1.p2`, `5.9#Px2.p1`, `5.9#Px2.p2`, `5.9#ii.p1`, and `5.9#ii.p2` are sampled and their mathematical domain/contour assertions are represented in the page. Figure caption `5.9#F1@caption` (“t-plane. Contour for Hankel’s loop integral”) is represented by the repaired E2 contour prose and helper. Inventory annotation/editorial/proof-note candidates only record provenance, additions, or references and do not add omitted theorem-shaped mathematics.
