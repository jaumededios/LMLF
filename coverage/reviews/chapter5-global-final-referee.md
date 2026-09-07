# Chapter 5 global final object-first referee

## Snapshot and scope

Review snapshot: `31b53f875c4884773698176b216809df59ea24a7` (`site/verso-dlmf-overlay`), with the current worktree repairs and regenerated `doc/_out/html-multi` output.  This is a read-only audit; the only file written by this review is this report.

Reviewed:

- `blueprint/agent-prompts/dlmf-section-referee.md`, `blueprint/design-exemplars/object-first-statements.md`, and `coverage/reviews/chapter5-global-object-audit.md`;
- all authored Chapter 5 Lean/manual files for §§5.1–5.18, all `coverage/sections/chapter5-*.json` manifests, `coverage/dlmf-4-10-source-inventory.json`, the aggregate ledgers, and the Chapter 5 aggregator;
- the shared Chapter 2/3 vocabulary (`LMLF/Integral/Curve.lean`, `LMLF/Integral/Domain.lean`, `doc/LMLFManual/Chapter3.lean`, and the continued-fraction/Poincare vocabulary);
- the regenerated Chapter 5 route pages and the accepted/final object-referee reports for §§5.4, 5.9, 5.11–5.14, 5.17, and 5.18.

The target overlay is §§5.1–5.18.  The source inventory also contains nine Chapter 5 formulas in §§5.19–5.20; those sections have no authored local pages and are outside the stated 160-formula overlay target.

## Independent coverage result

Filtering the schema-v2 inventory to numbered formulas in §§5.1–5.18 gives exactly 160 formulas, with the following counts:

| section | formulas |
|---|---:|
| 5.1, 5.3 | 0 each (notation/figure sources) |
| 5.2 | 9 |
| 5.4 | 20 |
| 5.5 | 9 |
| 5.6 | 9 |
| 5.7 | 8 |
| 5.8 | 5 |
| 5.9 | 25 |
| 5.10 | 2 |
| 5.11 | 19 |
| 5.12 | 12 |
| 5.13 | 5 |
| 5.14 | 7 |
| 5.15 | 9 |
| 5.16 | 2 |
| 5.17 | 7 |
| 5.18 | 12 |

The independent source/manual comparison gives exact expected/stated equality for all 160 IDs (`5.2.E1`–`5.18.E12`, including `5.9.E2_5`, `5.9.E10_1`, `5.9.E10_2`, `5.9.E11_1`, and `5.9.E11_2`).  A dry run of `scripts/sync_chapter5_coverage.py --chapter 5 --first-section 1 --last-section 18 --expected-formulas 160` reports `formula_overrides: 160`; the aggregate ledger has 160 Chapter 5 statements in this scope and no missing `lean_statement`.

## Verdict

**ACCEPT.** No P0 or P1 finding remains in the current Chapter 5 source, manual, manifests, aggregate coverage, or regenerated site.  All prior global object-audit blockers in the repaired pages are resolved.  Remaining items below are P2 API/maintenance follow-ups or P3 source-note polish.

## Resolved global blockers

- **Canonical extrema (§5.4 E20):** `GammaExtremum` stores the normalized pole interval and both critical-point conditions; `GammaExtremaSequence`, existence, uniqueness, canonical `gammaExtrema`, and the eventual asymptotic bound are separate and E20 refers to the canonical sequence.
- **Integral/contour separation:** §§5.9, 5.12, 5.13, and 5.14 expose named integrands/contours and separate finite integrability or improper convergence from value identities.  `C1Contour`, `PiecewiseC1Contour`, `LogLiftedC1Contour`, `VerticalLine`, Hankel convergence, and the §5.12 loop certificates are rendered and taught in shared Chapter 3 vocabulary.
- **§5.11 coefficient/branch APIs:** `aCoeffState`/`aCoeff` is a canonical finite-state construction with recurrence, uniqueness, and prefix declarations; generalized Bernoulli values are formal coefficient maps with generating and prefix declarations.  `LnGammaDatum` is supplied explicitly to complex remainder statements.  No `Classical.choose` remains in the §5.11 public API.
- **Barnes/Glaisher (§5.17):** named factors, finite partial products, `HasProd`, finite-prefix `Tendsto`, the canonical product value, and the Barnes value identity are distinct.  Glaisher's canonical zeta-derivative value, sequence convergence, and E7 identities are distinct.  The regenerated §5.17 route contains the repaired anchors; it is not the stale page described by the earlier report.
- **q domains/products/sums (§5.18):** `QGammaPoint` carries `0<q<1` and the denominator guard; `QBetaPoint` carries all three q-Gamma points; q-Pochhammer and q-Gamma products use `HasProd`; Jackson convergence uses an independent `HasSum` before E12's value identity.  The totalized quotients are explicitly documented as implementation representatives.
- **Shared Chapter 3 vocabulary:** the repaired contour, branch, vertical-line, multidimensional-domain, and Poincare/continued-fraction teaching panels are available before their Chapter 5 uses.

## Remaining findings

### P0 — none

### P1 — none

### P2 — legacy display-number labels remain in four old-schema manifests

`coverage/sections/chapter5-57.json`, `chapter5-58.json`, `chapter5-510.json`, and `chapter5-512.json` retain `included_ids` such as `5.7.1` rather than the schema-v2 IDs `5.7.E1`.  The coverage synchronizer canonicalizes these labels, so the aggregate ledger and the 160-formula audit are correct; this is not a coverage loss.  For direct consumers and byte-level referee checks, rewrite these old-schema `included_ids`, entry `id`s, and notes to canonical `E` IDs (or migrate those four manifests to the newer `numbered_formula_ids_expected/stated` shape).

### P2 — repeated regular-Gamma predicates are still pointwise plumbing

The same `∀ n : ℕ, z ≠ -(n : ℂ)` condition remains expanded in §§5.2, 5.5, 5.8, 5.15, and 5.17.  This is faithful and usable today, but a shared `GammaRegularPoint`/`GammaNoPole` object would make the invariant reusable across recurrence, products, polygamma, and Barnes statements.  This is the remaining G5-11 API follow-up, not a source-fidelity defect.

### P2 — §5.9 has reusable wrappers that could be promoted further

`Section59.verticalLineIntegral`/`verticalLineConverges` are thin wrappers over the shared `VerticalLine`, while `Section59.scaledGamma` duplicates the positive-real `scaledGammaReal` vocabulary in §5.11.  A future shared Mellin–Barnes/complex-scaled-Gamma module should provide the bridge and remove the duplicate names.  Current declarations preserve the convergence/value split and are readable.

### P2 — local finite-coordinate/coefficient conveniences remain

§5.14's `firstCoordinateSelection` and §5.11's real `risingFactorial`/`generalizedBinomial` are canonical functions, but remain section-local rather than a fully unified coordinate/coefficient API.  The current pages expose the source objects and no longer repeat opaque interval/measure plumbing; promotion is a reuse improvement only.

### P2 — q-limit domain can be made visually explicit

`dlmf_5_18_10` uses `nhdsWithin 1 (Iio 1)`.  This is eventually inside `0<q<1` because the filter converges to 1, and therefore is not a mathematical failure, but a subtype or `nhdsWithin 1 (Ioo 0 1)` presentation would make the source base range visible directly in the q-Gamma limit panel.

### P3 — one source proof-sketch sentence is not repeated

The §5.9 E20 manual entry does not include the DLMF proof-sketch note that both sides vanish at `z=c` and have `z`-derivative `Γ(z)`.  This does not affect numbered coverage or theorem hypotheses; add it as a short source-linked note if proof-sketch provenance is intended to be complete.

## Rendered routes, panels, and hygiene

All 18 authored Chapter 5 section routes linked from the chapter page exist, including the special slugs for §§5.3, 5.4, 5.6, and 5.17.  The generated route pages contain all 160 numbered DLMF source links and rendered Lean panels; the repaired §5.4, §5.11, §5.12, §5.13, §5.14, §5.17, and §5.18 object panels are present in the current HTML.  No authored Chapter 5 source/manual file contains `#check`, `#eval`, filler status prose, or redundant `\[...\]` delimiters.

Validation results:

- `lake build LMLF`: **pass** (3086 jobs; permitted `sorry` warnings only).
- From `doc/`, `lake build LMLFManual`: **pass** (3696 jobs; permitted `sorry` warnings only).
- `python3 scripts/validate_inventory.py`: **pass**.
- `python3 scripts/sync_chapter5_coverage.py --chapter 5 --first-section 1 --last-section 18 --expected-formulas 160 --dry-run`: **pass** (`formula_overrides: 160`, `source_item_no_claim: 3`, `source_item_overrides: 355`).
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter5`: **pass** (295 expressions).
- `node scripts/check_rendered_tex.mjs doc/_out/html-multi`: **pass** (862 generated expressions).

The only unreviewed Chapter 5 inventory material consists of editorial/reference notes and the out-of-scope §§5.19–5.20 formulas.  Within §§5.1–5.18, all numbered formulas, §5.1 notation/table items, §5.3 figure captions, §5.4 table rows/correction note, and the substantive source prose identified by the manifests are represented; no additional theorem-shaped source candidate blocks acceptance.
