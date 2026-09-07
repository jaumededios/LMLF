# Final referee report: DLMF §4.29 Graphics

## Snapshot and files reviewed

Snapshot: `958aad0d1078c589a3f7e30a52dc1a32ddf8062c`. I reread the referee
contract and reports `coverage/reviews/chapter4-429-referee-1.md` and
`coverage/reviews/chapter4-429-referee-2.md`, independently checked the
official [DLMF §4.29](https://dlmf.nist.gov/4.29), the local inventory, and
exactly:

- `LMLF/Blueprint/Elementary/Section429.lean`;
- `doc/LMLFManual/Chapter4/Section429.lean`;
- `coverage/sections/chapter4-429.json`.

## Independent inventory and verdict

There are no numbered formulas. The nine substantive records are the six
figure captions F1–F6, the two complex-argument prose blocks `ii.p1` and
`ii.p2`, and the `i.info` annotation note. The manifest contains exactly nine
matching extra IDs/declarations; numbered expected/stated/omitted sets are all
empty.

## Final F4 pole audit

The prior P1 is repaired in
`LMLF/Blueprint/Elementary/Section429.lean`, declaration `dlmf_4_29_F4`.
The interior arccoth clause now requires
`Complex.sinh y ≠ 0` before using
`Complex.cosh y / Complex.sinh y = x`. This excludes the totalized witness
`y = 0`, where Lean would otherwise turn the pole quotient into `0`. The
matching manual anchor and manifest note explicitly disclose this exclusion.
The real range clause separately states existence only for `|x| > 1` and
nonexistence for `|x| ≤ 1`, correctly handling the unattained boundary values
`±1`.

## Caption and prose audit

- **F2:** records the real cosh range, nonexistence below `1`, and the direct
  complex-preimage condition `y.im ≠ 0` below `1`, matching the caption's
  principal arccosh complex region.
- **F4:** records arctanh's exterior complex region, arccoth's interior
  complex region with the pole denominator excluded, and the exact real coth
  boundary behavior.
- **F6:** records the real sech range `(0,1]` and non-real complex preimages
  for arcsech targets `x < 0 ∨ x > 1`.
- **F1, F3, F5:** retain the strict sinh/cosh ordering, bounded tanh and
  reciprocal coth relation, and csch/sech pole facts.
- **§4.29(ii):** the two prose disclosures state the sine/sinh, cosine/cosh,
  and tangent/tanh rotation identities, with the manual preserving the source
  discussion of conformal maps and analogous complex surfaces.
- **Annotation:** the NIST graph-production note and principal real branch
  facts are represented directly.

The page has no distinct quantitative estimate or truncation companion. The
inverse-branch claims are honestly marked as real/complex specializations, not
as a full implementation of principal inverse-hyperbolic functions.

## Anchors and verification

All nine inventory records have manual source links, complete anchored Lean
statements, and manifest declarations. Anchors stop before `by sorry`; no
`#check`, filler status prose, or displaced proof work was found.

Both assigned builds pass with only permitted `sorry` warnings:

- `lake build LMLF.Blueprint.Elementary.Section429`;
- from `doc/`, `lake env lean LMLFManual/Chapter4/Section429.lean`.

Anchor parity is 9 source / 9 manual, and no additional unreviewed figure,
caption, or substantive prose candidate remains.

## Verdict: accept

The F4 totalized-pole blocker is resolved, the boundary `|x| = 1` remains
correctly excluded, all F2/F4/F6 inverse-branch caption facts are present, and
the page passes manifest, anchor, and build gates with no P0/P1 finding.
