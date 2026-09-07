# DLMF §5.7 referee review

## Snapshot and files reviewed

- Snapshot: `f4176ce69852c435e838eeb0b6da69c510f81fef` (the assigned Section 5.7 files are workspace additions in this worktree).
- Official source: [DLMF §5.7 Series Expansions](https://dlmf.nist.gov/5.7), including the numbered TeX endpoints `https://dlmf.nist.gov/5.7.E1.tex` through `E8.tex` (version 1.2.7, released 2026-06-15).
- Source inventory: `coverage/dlmf-4-10-source-inventory.json` (all §5.7 formula, prose, and annotation candidates).
- Lean author file: `LMLF/Blueprint/Gamma/Section57.lean`.
- Documentation author file: `doc/LMLFManual/Chapter5/Section57.lean`.
- Manifest: `coverage/sections/chapter5-57.json`.
- Rendered page: no §5.7 page is present in the checked-in `doc/_out/html-multi` tree, so rendered-page visual checks were unavailable. The standalone documentation source and all external anchors were checked by elaboration/highlight generation.

## Independently computed expected formula IDs

Filtering the source inventory to `section == "5.7"` and `kind == "numbered_formula"` gives, in document order,

`5.7.E1`, `5.7.E2`, `5.7.E3`, `5.7.E4`, `5.7.E5`, `5.7.E6`, `5.7.E7`, `5.7.E8`.

The authored page and manifest state exactly the corresponding display IDs `5.7.1` through `5.7.8`; there are no omissions, extras, or duplicate numbered entries. The manifest's declaration names, source links, and proof/quantitative status agree with the authored source.

## Verdict: accept

There are no P0, P1, or P2 findings. All eight formulas preserve the source equations, index shifts, domains/radii, and recurrence bounds. In particular, E3 uses a named branch selected by the expansion rather than incorrectly identifying the left side with the global composition `Complex.log (Complex.Gamma ·)`; the separate exponential bridge and explicit `z ≠ -1` make the pole/domain choice readable. The only remaining issue is P3 notation prose below.

## Findings

### P3 — State the subsection-wide meaning of `ζ`

The source prose candidate `dlmf:5.7#i.p1` says that throughout subsection (i), `ζ(k)` is the Riemann zeta function as defined in Chapter 25. The manual uses unqualified `ζ` in its displayed source formulas (for example `doc/LMLFManual/Chapter5/Section57.lean:60-67`) and never states this subsection-wide convention. The Lean declarations do use the explicit `riemannZeta` API, so this is documentation polish rather than a mathematical mismatch. Add a sentence near `doc/LMLFManual/Chapter5/Section57.lean:17-21`, such as “Throughout §5.7(i), `ζ` denotes the Riemann zeta function (DLMF Chapter 25).”

## Formula-by-formula disposition

- **5.7.1 / E1** — `reciprocalGamma_hasSum` uses the derivative-over-factorial coefficients of the reciprocal Gamma function and shifts `n + 1` to represent the source sum from `k = 1`; the two unnumbered source coefficients `c₁ = 1` and `c₂ = γ` are also stated. The all-complex domain and exact source link are present.
- **5.7.2 / E2** — `reciprocalGammaCoeff_recurrence` has the exact `k ≥ 3` hypothesis. `Finset.Icc 2 (k - 1)` expands the source ellipsis, with `(-1)^(j+1) ζ(j) c_(k-j)` giving the correct first sign and final `(-1)^k ζ(k-1)c₁` term.
- **5.7.3 / E3** — `logGammaOnePlusSeriesTerm`, `logGammaOnePlus`, `exp_logGammaOnePlus`, and `logGamma_one_add_hasSum` preserve the `|z| < 2` radius and the `k = 2` start. The selected branch is explicitly distinguished from principal `Complex.log ∘ Complex.Gamma`; `z ≠ -1` records the pole/`log 0` issue implicit in the source notation.
- **5.7.4 / E4** — `digamma_one_add_hasSum` has the exact `|z| < 1` disk, and `n + 2`/`n + 1` correctly represent the source `k = 2`/`k - 1` indices.
- **5.7.5 / E5** — `digamma_one_add_even_hasSum` has `|z| < 2` together with exactly `z ≠ 0, 1, -1`; its `n + 1` shift gives the source even powers `z^(2k)` and its target is the displayed elementary expression minus digamma.
- **5.7.6 / E6** — `digamma_partialFractions_hasSum` honestly packages the two convergent source series as a conjunction. The first starts at `k = 1`, the second at `k = 0`, and `∀ n : ℕ, z ≠ -(n : ℂ)` exactly excludes `0,-1,-2,…` for both denominators.
- **5.7.7 / E7** — `digamma_halfDifference_hasSum` carries the same nonpositive-integer exclusion from the source lead-in, includes the factor `2` in each summand, and preserves both shifted digamma arguments.
- **5.7.8 / E8** — `digamma_one_add_mul_I_im_hasSum` is the real-valued `y : ℝ` series with the source `k = 1` shift and the exact imaginary part of `Complex.digamma (1 + i y)`; no extra domain restriction is introduced.

All anchors enclose complete declarations and use `module := LMLF.Blueprint.Gamma.Section57`, while the declarations themselves live in `LMLF.Blueprint.Gamma`; this provides the required declaration and namespace context. No `#check` commands or proof work displacing statement coverage were found. The only proof placeholders are the permitted `sorry`s.

## Correctly handled specializations and quantitative pairs

- E1's two initial coefficient declarations are unnumbered consequences stated alongside the numbered series and are honestly described as such.
- E2's finite-sum recurrence is an exact expansion of the source ellipsis, not a specialization.
- E3's named branch and exponential-to-Gamma bridge are the appropriate branch-aware formulation of the source log-Gamma identity.
- E6 correctly combines both source series in one theorem, and E7 correctly reuses the preceding pole exclusion.
- No formula has a genuinely distinct quantitative analogue; finite truncation bounds would require new constants and domains, so the manifest's zero quantitative counts are correct.

## Build result and unreviewed candidates

- `lake env lean LMLF/Blueprint/Gamma/Section57.lean`: succeeds with the 11 expected `declaration uses sorry` warnings.
- `lake env lean LMLFManual/Chapter5/Section57.lean` from `doc/`: succeeds.
- `lake build` at the repository root: succeeds (2944 jobs).
- `lake build` in `doc/`: succeeds (6304 jobs).
- Highlighted-anchor output is present at `doc/.lake/build/highlighted/LMLF/Blueprint/Gamma/Section57.json`; the generated site tree has no rendered §5.7 page to inspect.

The source inventory's only mathematically substantive non-formula candidate is the subsection-wide Riemann-zeta notation note `dlmf:5.7#i.p1`, recorded above as P3. The remaining §5.7 prose/annotation candidates are bibliographic notes, section labels, or connective text (`and`, `Also`) and do not assert additional mathematics.
