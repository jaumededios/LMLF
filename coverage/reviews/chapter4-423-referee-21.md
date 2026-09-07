# Independent terminal referee — DLMF §4.23

## Snapshot and files reviewed

Snapshot: `caebaa8c5f312e026a04d8e77dcdc29bee7b92d8` (current working-tree
page files reviewed).

I independently reviewed:

- `LMLF/Blueprint/Elementary/Section423.lean`;
- `doc/LMLFManual/Chapter4/Section423.lean`;
- `coverage/sections/chapter4-423.json`;
- the schema-v2 source inventory and official [DLMF §4.23](https://dlmf.nist.gov/4.23).

No author or manifest file was edited.

## Inventory and anchor parity

The independently recomputed numbered inventory is exactly `4.23.E1` through
`4.23.E42`, with no gaps.  The manifest expected and stated sets are both
42/42 and the omitted set is empty.  The source inventory contains 37 exact
nonformula records.  The current manifest's additional declaration vocabulary
and source records are all present; source and manual anchor sets match exactly
at 56/56, with no duplicate anchors.

## Mathematical audit

E1–E3 are direct existence statements for oriented, function-specific paths:
E1 uses `SqrtPath 0 z`, E2 uses `SqrtPath z 1`, and E3 uses `RationalPath 0 z`
with the source's `z ≠ ±i` restrictions.  `SqrtContinuation` fixes a real
reference point in `(-1,1)`, its principal square-root value, and a continued
branch; both path structures store within-derivatives, continuous tangents,
interior forbidden-point conditions, and explicit `IntervalIntegrable`
certificates.  The path integrals therefore no longer rely on a totalized
ambient derivative for merely continuous curves.

E4–E6 are genuine reciprocal general-value equivalences with independent
`z,w` values.  E4/E5 retain `z ≠ 0`; E6 retains `z ≠ 0` and the tangent poles
`z ≠ ±i`.  The adjacent prose and path vocabulary preserve the corresponding
`0 → 1/z`, `1/z → 1`, and `0 → 1/z` endpoint/orientation data.

E7–E18 preserve principal reciprocal/reflection domains, cut predicates, and
the real-part split for arccotangent.  E19–E27 use the correct open-ray
principal domain, exact two-square-root/logarithmic E23 identity, real-cut
endpoint hypotheses, signed one-sided boundary objects, and the imaginary-cut
arctangent regime.  E28–E33 retain solution-set semantics and independently
quantified integer/sign choices.  E34–E38 preserve the alpha/beta coordinate
definitions, open-ray exclusion, sign-of-imaginary-part branch selection, and
the unit-disc arctangent specialization.

E39 and E41 expose the two interval-integral definitions with their source
domains.  E40 contains the complete seven-member Gudermannian equivalence
chain, including both logarithmic and hyperbolic reciprocal terms; its
`x ≠ 0` hypothesis is an honest specialization for `coth`/`csch`.  E42
contains the complete eight-member inverse-Gudermannian chain, with
`-π/2 < x < π/2` and `x ≠ 0` explicitly stated for the `cot`/`csc` terms.
These are readable conjunctions over the shared value rather than opaque
arbitrary witnesses.  No distinct quantitative companion is claimed.

The table's six row disclosures, seven-cell header, one-sided zero arccotangent
entry, dashes, and figure caption/panel labels are represented by the 56
proof-free source/manual anchors and the 37 nonformula inventory records.

## Anchor, TeX, and build validation

- All 42 formula anchors and all 14 additional reusable vocabulary/table/figure
  anchors are statement-only; no proof body occurs inside an external anchor.
- Source/manual anchor names match exactly 56/56.  Manifest JSON parses with
  exact 42-formula parity and the expected nonformula inventory coverage.
- `lake build LMLF.Blueprint.Elementary.Section423`: **pass**; only permitted
  `sorry` and long-line warnings.
- `cd doc && lake build LMLFManual.Chapter4.Section423`: **pass**; only the
  corresponding permitted warnings.
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter4/Section423.lean`:
  **pass**, all 42 source expressions accepted.
- `node scripts/check_rendered_tex.mjs`: **pass**, all 424 generated
  expressions accepted.
- No `#check`, `#eval`, `sorryAx`, or forbidden `\[...\]` delimiters were found.

## Verdict: ACCEPT

No P0 or P1 finding remains.
