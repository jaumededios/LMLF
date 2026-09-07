# Referee 1: DLMF §4.3 Graphics

Snapshot reviewed: `703f1ad1d96c360bbac555c43dc39f6ca64d1a7b` (`site/verso-dlmf-overlay`).

Files reviewed:

- `LMLF/Blueprint/Elementary/Section43.lean`
- `doc/LMLFManual/Chapter4/Section43.lean`
- `coverage/sections/chapter4-43.json`
- official [DLMF §4.3](https://dlmf.nist.gov/4.3), including [F1](https://dlmf.nist.gov/4.3.F1), [F2](https://dlmf.nist.gov/4.3.F2), [F3](https://dlmf.nist.gov/4.3.F3), and [F4](https://dlmf.nist.gov/4.3.F4), their source captions, F2's correspondence table, and the plotted axes/features in all four graphics.

## Independently computed source inventory

DLMF §4.3 contains four figure identifiers (`4.3.F1` through `4.3.F4`) and no numbered equation identifiers (`4.3.E1`, etc.). Therefore the expected numbered formula IDs are `[]`; stated and omitted numbered IDs are also `[]`. The authored page includes all four graphics with working source links. The source graphics show, respectively, the real inverse curves and tangent/symmetry lines; the F2 strip/slit-plane map and its nine-point correspondence table; the F3 modulus surface over the displayed `x,y` window (with branch-cut discontinuity and phase colors); and the F4 exponential-modulus surface over its displayed `x,y` window (with periodic phase-color bands).

## Verdict

**revise**

There are no P0 findings, and the numbered-ID inventory is exact, but two P1 fidelity/usability issues remain.

## Findings

### P1 — F2 correspondence table is not completely formalized

- DLMF ID: `4.3.F2`.
- Evidence: The official figure's table has nine rows/columns of corresponding points: `0 → 1`, `r → e^r`, `r+iπ → -e^r+i0`, `r−iπ → -e^r−i0`, `iπ → -1+i0`, `−iπ → -1−i0`, `−r+iπ → -e^(−r)+i0`, `−r−iπ → -e^(−r)−i0`, and `−r → e^(−r)`, for `r ∈ (0,∞)`. The prose at `doc/LMLFManual/Chapter4/Section43.lean:73-78` mentions all of these only in compressed form (dropping the `±i0` sides), while `LMLF/Blueprint/Elementary/Section43.lean:46-50` proves only four selected boundary values and omits the interior points `0`, `r`, and `−r`, the lower boundary values `−iπ` and `−r−iπ`, and the side-of-cut distinctions.
- Repair: Add a readable Lean declaration (or explicitly label the current theorem as a partial boundary-only specialization) covering all nine table entries with `r > 0`, preserving the two sides as complex values/limits where appropriate. The surrounding prose should state that any reduced theorem is selected coverage, not imply that the source table has been fully represented.

### P1 — F3 declaration is a tautological proxy for the plotted quantity

- DLMF ID: `4.3.F3`.
- Evidence: DLMF captions the plotted function as `|ln(x+i y)|`; the subsection says surface height is the absolute value and color is phase, and the figure visibly includes the negative-real-axis branch cut. The documentation prose at `doc/LMLFManual/Chapter4/Section43.lean:110-119` correctly describes this. However, `LMLF/Blueprint/Elementary/Section43.lean:54-57` declares only `0 ≤ ‖Complex.log (...)‖`, a generic norm nonnegativity fact. It does not state the plotted height as a value/function, nor expose the branch-cut/domain feature in Lean; the manifest’s `relation: "exact"` at `coverage/sections/chapter4-43.json:40-47` consequently overstates the source correspondence.
- Repair: Introduce a named surface-height expression (or a declaration whose conclusion directly identifies the F3 height with `‖Complex.log (x + y * I)‖`) and state the branch-cut/domain convention in surrounding prose or hypotheses. Keep nonnegativity as a consequence rather than the sole F3 statement, and mark it as a consequence/specialization in the manifest.

## Correctly handled specializations

- F1: `real_log_exp_inverse` gives `log (exp x) = x` for every real `x`; `real_exp_log_inverse` gives the reverse direction under the required positive-real hypothesis.
- F2: `complex_exp_principal_log_inverse` captures the principal inverse on the slit-plane condition `|arg z| < π`; `principal_log_exp_on_strip` captures the inverse on `−π < Im z < π`. The boundary theorem correctly includes the two `r±iπ` values, `iπ`, and `−r+iπ`, but is incomplete as table coverage (P1 above).
- F4: `complex_exp_surface_height` correctly states `|exp(x+i y)| = exp x`, matching the height dependence on the real coordinate; the documentation also records the phase-color bands.

## Quantitative pairs

None. This is a graphics-only DLMF section with no finite estimate or second quantitative declaration; all manifest entries correctly use `quantitative_analogue: "not_applicable"`.

## Build and source-candidate status

- `lake env lean LMLF/Blueprint/Elementary/Section43.lean`: passed (exit 0; seven expected `sorry` warnings).
- `lake env lean LMLFManual/Chapter4/Section43.lean` from `doc/`: passed (exit 0).
- No rendered Section 4.3 page was present in the checked-in `doc/_out` tree, so visual inspection was performed on the four official DLMF PNGs; the source manual's image links and captions were checked directly.
- No `#check`, filler status prose, or displaced proof work was found in either authored source file.
- No unreviewed numbered-equation candidate remains: the official page has only F1–F4, all four graphics were inspected, and F2's table was explicitly checked.
