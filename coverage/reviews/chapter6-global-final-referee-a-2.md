# Chapter 6 global final referee A — second review

**Verdict: ACCEPT.**  All four findings from
`chapter6-global-final-referee-a.md` are resolved in the current source and
manual.  I found no P0 or P1 issue.  One P3 linter cleanup is recorded below;
it does not block acceptance.

## Snapshot and scope

The review covers the current worktree at commit
`31b53f875c4884773698176b216809df59ea24a7`, with the Chapter 6 repair changes
present as uncommitted work.  Generated HTML was not used as evidence, per the
review instruction; source/manual files and the Lean builds were checked
directly.

The independently recomputed official numbered inventory is exactly 100:

| section | numbered formulas |
|---|---|
| 6.1 | none |
| 6.2 | E1–E21 (21) |
| 6.3 | none |
| 6.4 | E1–E7 (7) |
| 6.5 | E1–E7 (7) |
| 6.6 | E1–E6 (6) |
| 6.7 | E1–E16 (16) |
| 6.8 | E1–E3 (3) |
| 6.9 | E1 (1) |
| 6.10 | E1–E8 (8) |
| 6.11 | E1–E3 (3) |
| 6.12 | E1–E8 (8) |
| 6.13 | E1–E2 (2) |
| 6.14 | E1–E7 (7) |
| 6.15 | E1–E4 (4) |
| 6.16 | E1–E5 (5) |
| 6.17 | none |
| 6.18 | E1–E2 (2) |
| 6.19–6.21 | none |

Every Chapter 6 manifest has exact expected/stated parity and an empty omitted
set; the recomputed total is 100.  The manual contains exactly 100 numbered
DLMF formula links, each pointing to its corresponding official `.E#` URL.

## Resolution of prior findings

### Prior P1 — duplicate Poincaré interface: resolved

`Section612.lean` no longer defines a local `HasPoincareExpansion`.  Its E1,
E3, and E4 declarations use the shared
`QuantitativeAnalysis.HasPoincareExpansion` through `∼ₚ`, imported from
`LMLF.Quantitative.Series`; §6.13 uses the same shared interface.  The manual
explicitly explains the shared retained-term indexing separately from the
finite remainder indexing used by E5–E8.  There is now one public
Poincaré-expansion vocabulary rather than two definitions with the same name.

### Prior P2 — competing auxiliary-function APIs: resolved

`Section62.principalAuxiliaryF/G` are the sole canonical public pair.
`Section64` now calls its branch-side values
`principalContinuationFValue/GValue` and supplies explicit
`principalContinuation*Value_eq_principalAuxiliary*` bridge theorems on the
principal-cut domain.  `Section67` no longer shadows the canonical names, and
`Section611.auxiliaryF/G` are direct aliases of the §6.2 canonical pair.  The
manual teaches the distinction and displays both bridge statements.

### Prior P2 — arbitrary §6.13 continuation as the primary result: resolved

`dlmf_6_13_2` now states the finite displayed-prefix expansion using
`HasSix13DisplayedExpansion`, and
`dlmf_6_13_2_remainder` is its distinct displayed-prefix quantitative
companion.  The arbitrary coefficient continuation and all-orders remainder
are explicitly named auxiliary declarations (`*_all_orders_auxiliary`) and are
described as such in the manual.  The reader-facing theorem therefore exposes
all coefficients actually printed by DLMF without selecting hidden data.

### Prior P3 — globally totalized §6.16 sawtooth: resolved

The exported helper is now
`sawtoothValueOnDomain (x) (hx : -π < x ∧ x < π)`.  The E1 theorem passes its
interval proof, and the manual shows the same domain in the Lean statement.
No outside-domain value is exported.

## Fidelity and object-first audit

I re-sampled every section and exhaustively rechecked the repaired §§6.2,
6.4, 6.7, 6.9, 6.12, 6.13, 6.16, and 6.18 against the official source.  The
100 displayed formulas retain their signs, factors, indices, branch choices,
domains, and limiting regimes.  The continued-fraction offset remains
optional with default zero.  The §6.12 finite remainders are named source
objects, not theorem wrappers that merely subtract their own definition.  The
path witnesses in §6.2 and §6.7 remain tied to genuine contour hypotheses.

The qualitative/quantitative split is now readable: asymptotic statements use
the shared Poincaré vocabulary where appropriate, while bounds, same-sign
claims, decimal enclosures, and next-term estimates are separate declarations.
§6.13’s quantitative theorem is visibly about the finite displayed prefix,
not an opaque continuation choice.

The distinct qualitative/quantitative pairs are:

* §6.12.E1: `dlmf_6_12_1` with `dlmf_6_12_1_bounds` and
  `dlmf_6_12_1_same_sign`;
* §6.12.E2: `dlmf_6_12_2` with `dlmf_6_12_2_bound`;
* §6.12.E7: `dlmf_6_12_7` with its bounds and same-sign declarations;
* §6.12.E8: `dlmf_6_12_8` with its bounds and same-sign declarations;
* §6.13.E1: `dlmf_6_13_1` with the decimal enclosure
  `dlmf_6_13_1_approx`;
* §6.13.E2: the finite-prefix `dlmf_6_13_2` with
  `dlmf_6_13_2_remainder`.

The other Chapter 6 formulas are exact identities, definitions, convergence
statements, or already-quantitative inequalities, so a second quantitative
snippet would be redundant; their manifests correctly mark no distinct pair.

Correctly handled specializations include the typed principal/cut-avoiding
paths of §6.2, the branch-aware half-turn continuation of §6.4, the
principal-domain specialization of the §6.7 contour formulas, the optional
zero-offset continued fraction of §6.9, the normalized recurrence families in
§6.10, and the direct canonical Bochner-integral recurrence values in §6.18.

No `Classical.choose` public API or avoidable output witness was found.  The
remaining existential statements are either typed path representations,
ordered-zero completeness, or justified recurrence-family certificates.

## Anchors, nonformula candidates, and checks

* All Lean `-- ANCHOR:` labels in Chapter 6 have exactly matching manual
  anchors, including the newly introduced repair declarations.
* Listed-only prose, notes, captions, graphics, and source-item candidates
  remain represented in the manifests and manual without being misclassified
  as numbered formulas.
* No `#check`, `#eval`, TODO/FIXME placeholder, `sorryAx`, or filler status
  marker occurs in the Chapter 6 authored source/manual.
* `lake env lean LMLF/Blueprint/ExponentialIntegrals.lean` passes.
* `lake build LMLF.Blueprint.ExponentialIntegrals` passes (3223 jobs).
* `cd doc && lake build LMLFManual.Chapter6` passes (3476 jobs).
* Every TeX-bearing Chapter 6 manual source passes
  `scripts/check_source_tex.mjs`; the only no-expression pages are the
  expected prose/graphics-only §§6.1, 6.3, and 6.17.

## P3 polish

`Section616.lean` emits Lean’s harmless `unusedVariables` warning for the
proof parameter `hx` in `sawtoothValueOnDomain`; the proof is intentionally
present to enforce the source domain.  Renaming it `_hx` would silence the
warning, but this is not a correctness, fidelity, or usability blocker.
