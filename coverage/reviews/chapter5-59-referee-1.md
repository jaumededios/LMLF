# DLMF §5.9 referee review

## Snapshot and files reviewed

- Snapshot: `f4176ce69852c435e838eeb0b6da69c510f81fef` (the assigned §5.9 author files are untracked in this worktree).
- Official source: [DLMF §5.9](https://dlmf.nist.gov/5.9), including the numbered TeX sources `https://dlmf.nist.gov/5.9.E1.tex` through `E20.tex`.
- Source inventory: `coverage/dlmf-4-10-source-inventory.json`.
- Lean author file: `LMLF/Blueprint/Gamma/Section59.lean`.
- Documentation author file: `doc/LMLFManual/Chapter5/Section59.lean`.
- Manifest: `coverage/sections/chapter5-59.json`.
- Rendered page: no rendered §5.9 page is present in the checked-in `doc/_out/html-multi` tree; the standalone file is not imported by `doc/LMLFManual/Chapter5.lean`, so visual page checks were unavailable.

## Independently computed expected formula IDs

The inventory and official page contain exactly these 25 numbered records:

`5.9.E1`, `5.9.E2`, `5.9.E2_5`, `5.9.E3`, `5.9.E4`, `5.9.E5`, `5.9.E6`, `5.9.E7`, `5.9.E8`, `5.9.E9`, `5.9.E10`, `5.9.E10_1`, `5.9.E10_2`, `5.9.E11`, `5.9.E11_1`, `5.9.E11_2`, `5.9.E12`, `5.9.E13`, `5.9.E14`, `5.9.E15`, `5.9.E16`, `5.9.E17`, `5.9.E18`, `5.9.E19`, `5.9.E20`.

The documentation and manifest state the same set (no omissions or extras).

## Verdict: accept (after re-review)

The prior P0 source-fidelity error in the Hankel contour encoding and P2 documentation/API issue have been repaired. The module elaborates, the numbered-ID coverage is complete, and no active P0/P1/P2/P3 findings remain.

## Findings from the prior review (resolved)

### Resolved P0 — `5.9.E2`: explicit `−π`/`+π` Hankel bank branches

- Files/declarations: `LMLF/Blueprint/Gamma/Section59.lean:27-37`, `LMLF.Blueprint.Gamma.Section59.hankelTruncation`, used by `dlmf_5_9_2` at lines 53–59; the corresponding display is `doc/LMLFManual/Chapter5/Section59.lean:45-70`.
- Evidence: DLMF [5.9.E2](https://dlmf.nist.gov/5.9.E2) specifies a loop from `-∞` below the cut, around the origin, and back above it, with `t^{-z}` taking the continuous principal branch on the two banks. The author prose claims that `hankelTruncation` fixes this branch continuously.
- Resolution: `hankelTruncation` now takes `z` directly and uses `Real.log r - π i` on the lower bank, `Real.log r + π i` on the upper bank, and `Real.log ε + θ i` on the circle. The differentials and orientations are explicit, and `dlmf_5_9_2` now calls `hankelTruncation z R ε`. The documentation names all three branch arguments. This preserves the distinct boundary values required by [DLMF 5.9.E2](https://dlmf.nist.gov/5.9.E2).

### Resolved P2 — public auxiliary definitions now name their DLMF IDs

- Files/declarations: `LMLF/Blueprint/Gamma/Section59.lean:21-25` (`complexSegmentIntegral`), `:27-37` (`hankelTruncation`), and `:179-183` (`verticalLineIntegral`).
- Resolution: the comments now name `5.9.20`, `5.9.2`, and `5.9.11`/`5.9.17`, respectively.

## Correctly handled specializations and quantitative pairs

- `5.9.E10`, `5.9.E10_1`, and `5.9.E10_2` are honestly labeled positive-real specializations of the branch-sensitive Binet formulas; the prose and manifest do not call them exact complex matches.
- `5.9.E11`, `5.9.E11_1`, `5.9.E11_2`, and `5.9.E12`–`5.9.E17` are likewise honestly labeled positive-real specializations. The declarations retain the contour/integrability conditions (`1 < c < 2` where applicable) and the source displays preserve the source links.
- `5.9.E1`–`5.9.E9`, `5.9.E18`–`5.9.E20` are presented as direct statements, with E2 now using the repaired explicit branch-aware contour. E1, E3–E7, E19, and E20 include the relevant convergence/integrability or limiting-domain assertions.
- No second quantitative declaration is warranted: §5.9 supplies identities and convergence statements, not distinct finite error bounds or enclosures. The manifest correctly marks all quantitative analogues `not_applicable`.

## Build result and source candidates

- `lake env lean LMLF/Blueprint/Gamma/Section59.lean`: succeeds with 25 expected `sorry` warnings.
- From `doc/`, after building the root `LMLF` dependency, `lake env lean LMLFManual/Chapter5/Section59.lean`: succeeds.
- From `doc/`, `lake build lmlf-site`: succeeds.
- No `#check` or prohibited filler-status prose was found in either assigned source file.
- The inventory's substantive source candidates were sampled: section-wide domain/branch prose, all numbered-equation constraints, the Hankel Figure 5.9.1 caption, and the §5.9.20 addition note. The caption only identifies the contour; the authored page describes it in prose and now implements its two explicit bank branches. Bibliographic/editorial notes and proof sketches add no separate mathematical declaration. No additional numbered or substantive source candidate remains unreviewed.

## Re-review checks

- All 25 expected IDs still match the documentation and manifest; no omissions or extras.
- All 30 Lean anchors are balanced and have corresponding documentation anchors.
- The revised totalized removable-value prose covers `temmePhase` at `t=0` and the `5.9.20` quotient at `t=1`; changing a single point does not affect the relevant integral.
- `lake build LMLF`, `lake env lean LMLF/Blueprint/Gamma/Section59.lean`, `lake build LMLF` from `doc/`, `lake env lean LMLFManual/Chapter5/Section59.lean`, and `lake build lmlf-site` all succeed.
