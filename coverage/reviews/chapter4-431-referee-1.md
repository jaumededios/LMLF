# Referee report: DLMF §4.31 Special Values and Limits

## Snapshot and files reviewed

Snapshot: `958aad0d1078c589a3f7e30a52dc1a32ddf8062c` (the assigned §4.31
author files are working-tree additions at this snapshot).  I reread the
referee contract and independently reviewed the official [DLMF §4.31 page](https://dlmf.nist.gov/4.31),
the local source inventory, and exactly:

- `LMLF/Blueprint/Elementary/Section431.lean`;
- `doc/LMLFManual/Chapter4/Section431.lean`;
- `coverage/sections/chapter4-431.json`.

No standalone rendered §4.31 artifact was present in `doc/_out`.

## Independent inventory and verdict

The numbered inventory is exactly `4.31.E1`, `4.31.E2`, and `4.31.E3`.
The manifest expected, stated, and omitted arrays agree exactly: 3/3/0.
The non-formula inventory contains the Table 4.31.1 caption, its header and
seven rows, the §4.31 prose block, and the bibliography note; the manifest has
one corresponding declaration for each of these ten page-level items.

## Verdict: accept

The three limits preserve the source's complex-variable direction and puncture
at the origin.  The manual and Lean source cover the table caption, all seven
rows, every finite value, pole marker, and the infinity-column specialization,
with the real positive-axis limits identified honestly as specializations.
Anchors expose complete statements before their permitted proof bodies, and
the manifest relations distinguish exact limits, related prose/caption checks,
and table specializations.

## Formula and table audit

- **E1:** `Tendsto (sinh z / z)` from
  `nhdsWithin 0 ({0} : Set ℂ)ᶜ` to `nhds 1`, matching the punctured complex
  limit `z → 0`.
- **E2:** the same punctured complex filter for `tanh z / z → 1`.
- **E3:** the punctured complex limit of `(cosh z - 1) / z^2` to `1/2`, with
  the correct quadratic normalization and direction.

For Table 4.31.1, the source order and values are preserved:

- the header identifies `0`, `π i/2`, `π i`, `3π i/2`, and `∞`; the three
  nontrivial sample-point definitions are stated directly, while `0` appears
  literally in the rows and `∞` is represented by the row limits;
- the `sinh` row is `0, i, 0, -i` with `Real.sinh` tending to `+∞`;
- the `cosh` row is `1, 0, -1, 0` with `Real.cosh` tending to `+∞`;
- the `tanh` row records zero at the finite sample points, zeros of `cosh` as
  the two pole markers, and the real limit `1`;
- the `csch` row records zeros of `sinh` at its two poles, the finite values
  `-i` and `i`, and the real limit `0`;
- the `sech` row records `1`, `-1`, and zeros of `cosh` at the two poles, with
  real limit `0`;
- the `coth` row records zeros of `sinh` at its poles, zero at the other two
  sample points, and the real limit `1`.

The page explicitly explains that printed infinities are pole/limiting-value
markers rather than Lean's totalized division-by-zero values.  The `coth` row
uses `1 / Complex.tanh` for its two finite zero entries; this is marked as a
table specialization, and those entries agree with the direct value
`cosh z / sinh z = 0` while the separate `sinh = 0` clauses retain the actual
pole markers.  No unsupported directional sign is invented for the table's
infinity entries.

The caption theorem is deliberately a `related` cross-row check rather than a
claim to be the caption itself.  The prose and notes retain the two cited
references and the complex origin-limit context.  No distinct quantitative
companion declaration is warranted for this special-values-and-limits page.

## Anchors, manifest, and verification

All three numbered theorems and all ten non-formula declarations have matching
manual/source disclosures and module-qualified anchors.  The anchors stop
before `by sorry` and expose complete readable statements.  The note's
manifest `4.31#info` is the page's canonical note DOM ID and points to the
linked DLMF note; the source inventory's annotation suffix adds no separate
mathematical claim.  No `#check`, filler status prose, or displaced proof work
was found.

Both targeted builds passed, with only the permitted `sorry` warnings:

- `lake build LMLF.Blueprint.Elementary.Section431`;
- from `doc/`, `lake build LMLFManual.Chapter4.Section431`.

No unreviewed substantive formula, table row, caption, prose block, or note
candidate remains.
