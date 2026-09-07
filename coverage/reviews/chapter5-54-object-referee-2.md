# DLMF §5.4 object-first re-review

## Snapshot and files reviewed

- Snapshot: `31b53f875c4884773698176b216809df59ea24a7` plus the current working-tree §5.4 repair.
- Official source: [DLMF §5.4](https://dlmf.nist.gov/5.4), including E1–E20, the E2 `n=-1` note, Table 5.4.1, its correction note, and the Figure 5.3.1 cross-reference.
- Source inventory and manifest: `coverage/dlmf-4-10-source-inventory.json` and `coverage/sections/chapter5-54.json`.
- Authored Lean/manual files: `LMLF/Blueprint/Gamma/Section54.lean` and `doc/LMLFManual/Chapter5/Section54.lean`.
- Existing generated HTML was intentionally ignored for this source/API verdict; root will regenerate it after page acceptance.

## Independently computed expected formula IDs

Filtering the source inventory to section 5.4 and `kind == numbered_formula` gives exactly:

```text
5.4.E1, 5.4.E2, 5.4.E3, 5.4.E4, 5.4.E5,
5.4.E6, 5.4.E7, 5.4.E8, 5.4.E9, 5.4.E10,
5.4.E11, 5.4.E12, 5.4.E13, 5.4.E14, 5.4.E15,
5.4.E16, 5.4.E17, 5.4.E18, 5.4.E19, 5.4.E20
```

The manifest has exactly the same 20 expected and stated IDs and no omitted numbered IDs.

## Verdict: accept

The normalization repair resolves the prior E20 object/API blocker. The source now uses the source-index intervals `(1,2)` for `x₀` and `(-n,1-n)` for every `n > 0`, placing each point strictly between Gamma poles. The dependent `GammaExtremum n` carries interval membership and both critical-point equations; `GammaExtremaSequence` carries one point for every index. Existence and sequence uniqueness are stated separately, `gammaExtrema` is the canonical choice extracted from existence, and E20 refers directly to that same named sequence. The manual teaches all of these declarations before the E20 panel, with matching module-qualified anchors.

## Object/API audit

- `gammaExtremumInterval` at `LMLF/Blueprint/Gamma/Section54.lean:226-230` matches the DLMF table indexing: `x₀ ∈ (1,2)` and `xₙ ∈ (-n,1-n)` for `n > 0`.
- `GammaExtremum (n)` at lines 237–243 stores the stable interval invariant, `deriv Real.Gamma location = 0`, and `Complex.digamma (location : ℂ) = 0`. The strict interval excludes the totalized Gamma poles.
- `GammaExtremum.value` at lines 245–249 is the readable named map for the table's `Gamma(xₙ)` values.
- `GammaExtremaSequence` at lines 251–255 is an indexed dependent family rather than an arbitrary `ℕ → ℝ` witness, giving finite evaluation by `point n` while retaining the per-index invariant.
- `gamma_extrema_exists` (lines 257–262) and `gamma_extrema_unique` (lines 264–273) provide the qualitative existence/uniqueness interface. `gammaExtrema` (lines 275–280) is the canonical extraction from existence; uniqueness makes the classical choice independent of witness.
- `gamma_extrema_asymptotic` (lines 282–292) quantifies only the positive eventual constant and refers to `(gammaExtrema.point n).location`, so the quantitative E20 statement is connected to the canonical qualitative object rather than introducing a second existential sequence.
- The manual at `doc/LMLFManual/Chapter5/Section54.lean:326-367` explains the interval normalization and presents every custom definition/theorem before the E20 panel at lines 369–385.

## Formula and prose fidelity

E1–E19 remain faithful to the official source, including all parameter constraints, signs, finite sum ranges, branch-sensitive complex functions, and the E2 `n=-1` note. E6–E10 correctly treat printed decimal expansions as labelled enclosures rather than exact decimal equalities. The manual reproduces the eleven Table 5.4.1 rows, caption condition, correction note, and Figure 5.3.1 link. E20 preserves the exact approximation, `n → ∞` regime via `atTop`, and an explicit positive-constant eventual bound.

The specializations and quantitative separation are honest: E2/E3/E5/E6–E10/E11–E13/E14–E19/E20 are labelled specializations where applicable; E20 is the only distinct quantitative analogue needed. No additional quantitative declaration is required.

## Manifest, anchors, and checks

- Manifest `extra_statement_ids` includes `gammaExtremumInterval`, `GammaExtremum`, `GammaExtremum.value`, `GammaExtremaSequence`, `gamma_extrema_exists`, `gamma_extrema_unique`, and `gammaExtrema`; the E20 declaration names include all of these plus `gamma_extrema_asymptotic`.
- Independently compared every authored Lean anchor with its manual anchor body: all 29 declaration anchors match byte-for-byte (the only non-declaration anchor is the namespace context marker).
- No `#check`, filler status prose, or proof work displacing statement coverage occurs in either owned file.
- All 20 numbered IDs have source links and corresponding manual entries.

## Build results

- `lake env lean LMLF/Blueprint/Gamma/Section54.lean`: **pass**, with only the expected `sorry` warnings.
- From `doc/`, `lake env lean LMLFManual/Chapter5/Section54.lean`: **pass**.
- `lake build LMLFManual` from `doc/`: **pass** (3695 jobs).
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter5/Section54.lean`: **pass** (`KaTeX accepted all 21 source expressions`).
- Generated HTML was not used for this verdict, per dispatch; it should be regenerated by root and then checked for the new object panels/anchors.

## Unreviewed source candidates

The inventory also records prose/annotation/table-row items. The substantive caption, all eleven table rows, correction note, E2 exception note, and Figure 5.3.1 cross-reference are represented. Bibliographic and editorial annotation notes do not add mathematical statement obligations.
