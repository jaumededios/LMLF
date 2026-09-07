# Final referee: DLMF §4.19 Maclaurin and Laurent Series

## Snapshot and files reviewed

Snapshot: `7d39f17cef5d56ab37efd6ab9e607fff60f9d7a1`, with the current
working-tree revision reviewed after `coverage/reviews/chapter4-419-referee-1.md`.
I independently checked the official [DLMF §4.19](https://dlmf.nist.gov/4.19),
the repository source inventory, and:

- `LMLF/Blueprint/Elementary/Section419.lean`;
- `doc/LMLFManual/Chapter4/Section419.lean`; and
- `coverage/sections/chapter4-419.json`.

No rendered standalone §4.19 page is present in `doc/_out`; source-level
anchors and both standalone/build elaborations were checked instead.

## Independent formula inventory and verdict

The official numbered set is exactly
`4.19.E1`, `4.19.E2`, `4.19.E3`, `4.19.E4`, `4.19.E5`, `4.19.E6`,
`4.19.E7`, `4.19.E8`, and `4.19.E9`.  The source and documentation contain
all nine theorem anchors, and the manifest expected/stated sets agree exactly
with no omitted or extra numbered IDs.

**Verdict: accept.**  The prior Bernoulli/Euler API, vocabulary-manifest, and
removable-center concerns are resolved.  All E1–E9 displays are represented by
readable `HasSum` declarations with the source coefficients, domains, and
Laurent principal parts preserved.

## Findings

No P0, P1, P2, or P3 findings.

## Formula-by-formula audit

- **E1–E2:** The sine and cosine declarations use the exact alternating
  factorial coefficients and `HasSum` at every `z : ℂ`, matching the entire
  Maclaurin series.
- **E3:** `tanTerm` reindexes the source from `n = 1` to `m = n + 1` and
  retains `(-1)^(m-1) 2^(2m) (2^(2m)-1) B_(2m)/(2m)!` with the strict disk
  `‖z‖ < π/2`.
- **E4:** `cscTerm` gives the Bernoulli tail after the explicit principal part;
  `HasSum (cscTerm z) (csc z - 1/z)` and `0 < ‖z‖ < π` preserve the Laurent
  regime.
- **E5:** `secTerm` uses `(-1)^n E_(2n)/(2n)! z^(2n)` on `‖z‖ < π/2`.
- **E6:** `cotTerm` correctly reindexes the negative Bernoulli tail and the
  target subtracts `1/z`; both strict punctured-disk inequalities are present.
- **E7:** The Bernoulli coefficient and even powers are exact on `‖z‖ < π`.
  `sinRatio` explicitly sets the removable center to `1`, so the anchored
  target is `Complex.log (sinRatio z)` and gives `log 1 = 0` at `z = 0`.
- **E8:** The principal-log cosine series has the exact
  `(-1)^n 2^(2n-1)(2^(2n)-1) B_(2n)/(n(2n)!)` coefficient and disk
  `‖z‖ < π/2`.
- **E9:** The principal-log tangent-ratio series has the exact
  `(-1)^(n-1) 2^(2n)(2^(2n-1)-1) B_(2n)/(n(2n)!)` coefficient and disk
  `‖z‖ < π/2`; `tanRatio 0 = 1` is explicit in both Lean and prose.

## Vocabulary and manifest audit

- `bernoulliNumber` is a transparent complex cast of Mathlib's canonical
  `bernoulli` sequence, whose convention has `B₀ = 1` and `B₁ = -1/2`.
- `eulerNumber` is no longer opaque: its terminating recurrence gives
  `E₀ = 1`, vanishing odd values, and each positive even value as the negative
  binomial sum of preceding even values, matching the DLMF secant convention
  (`E₂ = -1`, `E₄ = 5`, and so on).
- The manifest lists every anchored helper: `bernoulliNumber`, `eulerNumber`,
  `csc`, `sec`, `sinRatio`, `tanRatio`, and all seven summand definitions
  (`tanTerm`, `cscTerm`, `secTerm`, `cotTerm`, `logSinRatioTerm`,
  `logCosTerm`, `logTanRatioTerm`).  Each has a matching source anchor and
  complete documentation anchor; all manifest declaration names resolve.
- The reciprocal `csc`/`sec` notation is used only in domains where the stated
  series is valid, and the two removable quotient centers are explicit rather
  than relying on Mathlib's totalized division.
- No separate quantitative companion declaration is warranted: §4.19 gives
  exact series and convergence domains, not an independent estimate/remainder
  pair.  Every manifest entry correctly uses
  `quantitative_analogue: "not_applicable"`.

## Verification and source candidates

- `lake env lean LMLF/Blueprint/Elementary/Section419.lean`: passed, with only
  the permitted `sorry` warnings on E1–E9.
- `lake build LMLF.Blueprint.Elementary.Section419`: passed.
- From `doc/`, `lake env lean LMLFManual/Chapter4/Section419.lean`: passed.
- From `doc/`, `lake build LMLFManual.Chapter4.Section419`: passed.
- Direct DLMF source links are present for every E1–E9 entry, and all source
  anchors display complete declarations with namespace context.
- The inventory has no figure, table, or additional numbered source candidate
  for §4.19; its prose note identifying the Bernoulli and Euler sequences is
  represented in the manual.  No `#check`, filler/status prose, or
  proof-displacing source content was found.
