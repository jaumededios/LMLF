# DLMF §5.10 referee review

## Snapshot and files reviewed

- Snapshot: `f4176ce69852c435e838eeb0b6da69c510f81fef` (the assigned §5.10 author
  files are untracked in this worktree).
- Official source: [DLMF §5.10](https://dlmf.nist.gov/5.10), including the source
  records [5.10.E1](https://dlmf.nist.gov/5.10.E1) and
  [5.10.E2](https://dlmf.nist.gov/5.10.E2); E2 is split into the seven source
  components `5.10.E2a` through `5.10.E2g`.
- Source inventory: `coverage/dlmf-4-10-source-inventory.json`.
- Lean author file: `LMLF/Blueprint/Gamma/Section510.lean`.
- Documentation author file: `doc/LMLFManual/Chapter5/Section510.lean`.
- Manifest: `coverage/sections/chapter5-510.json`.
- Rendered page: no rendered §5.10 page is present in the checked-in
  `doc/_out/html-multi` tree; the standalone page is not imported by
  `doc/LMLFManual/Chapter5.lean`, so visual anchor checks were unavailable.

## Independently computed expected formula IDs

The inventory and official page contain exactly two numbered records:

`5.10.E1` (display number `5.10.1`) and `5.10.E2` (display number `5.10.2`).
The latter is one grouped display with seven source components, `E2a`–`E2g`,
for `a₀` through `a₆`. The documentation and manifest state exactly the two
display IDs (`5.10.1`, `5.10.2`), with no omissions or extras.

## Verdict: accept

The third revision fixes the earlier coefficient-stream and circular-premise
issues. The proof-pending existential records a full source coefficient
sequence with the seven displayed values and the positive-real convergence
claim; `Classical.choose` selects that sequence, and its choose-spec supplies
both reader-facing projections. E1 is a direct projection of the convergence
part and E2 a direct projection of the seven-value part. Coverage, convergent
direction, domain specialization, grouping, anchors, and builds are complete.

## Findings

No P0, P1, P2, or P3 findings.

The recursive direction itself is correct: unfolding gives
`continuedFractionConvergent coeff z 0 = a₀/z`, then
`a₀/(z + a₁/z)`, then `a₀/(z + a₁/(z + a₂/z))`. The theorem's `0 < x` is the
honest positive-real specialization of DLMF's `Re z > 0`, and the page clearly
labels `Real.log (Real.Gamma x)` as a specialization of DLMF's general
`Ln Γ(z)` branch. No direction or branch-label defect was found. The
existential/choice chain is non-circular: `exists_gammaContinuedFractionCoeff`
does not refer to the chosen definition or either derived numbered theorem;
`gammaContinuedFractionCoeff_spec` is `Classical.choose_spec`, E1 uses its `.2`
projection, and E2 uses its `.1` projection. The later coefficients remain an
honest proof-pending existential because §5.10 refers to external tables rather
than printing them.

## Correctly handled specializations and quantitative pairs

- `5.10.1` → `LMLF.Blueprint.Gamma.Section510.dlmf_5_10_1` is explicitly
  labeled as a positive-real specialization. It retains the strict positivity
  hypothesis and embeds the real value into `ℂ`; it does not claim to cover the
  full complex general-logarithm convention. Its conclusion is the positive-real
  convergence projection from the chosen full source sequence.
- `5.10.2` → `LMLF.Blueprint.Gamma.Section510.dlmf_5_10_2` records all seven
  source components as one conjunction. The exact rational values, including
  the grouped-digit `a₅` and `a₆` numerators/denominators, match the source.
  Treating E2a–E2g as one grouped source record is correct; no second
  quantitative declaration is warranted.
- No quantitative analogue exists for either numbered formula, and the
  manifest correctly marks both as absent.

## Build result and source candidates

- `lake env lean LMLF/Blueprint/Gamma/Section510.lean`: succeeds with one
  expected `sorry` warning for the proof-pending existential; E1 and E2 are
  proved by projections, and no unused-variable warnings remain.
- From `doc/`, `lake env lean LMLFManual/Chapter5/Section510.lean`: succeeds.
- From `doc/`, `lake build lmlf-site`: succeeds.
- The anchors name the complete declarations and include the module namespace
  (`LMLF.Blueprint.Gamma.Section510`); no `#check` or filler status prose was
  found in either assigned source file. The auxiliary definitions are readable
  and their depth/offset comments agree with the unfolding above.
- Source candidates sampled: the section-wide `Re z > 0` statement, E1's
  editorial note changing `ln Γ` to the general `Ln Γ`, E2's seven coefficient
  components, and the note pointing to exact `a₇`–`a₁₁`/40S values in external
  references. The editorial/reference material adds no omitted numbered
  formula or separate quantitative bound. The authored page makes the
  later-coefficient gap explicit through the existential full sequence, so no
  unreviewed substantive source candidate remains.
