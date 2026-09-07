# Final referee report: DLMF §4.28

## Snapshot and files reviewed

I reread the referee contract and `coverage/reviews/chapter4-428-referee-1.md`,
then audited the official [DLMF §4.28](https://dlmf.nist.gov/4.28) and the
current:

- `LMLF/Blueprint/Elementary/Section428.lean`;
- `doc/LMLFManual/Chapter4/Section428.lean`;
- `coverage/sections/chapter4-428.json`.

## Inventory and verdict

The numbered inventory is exactly `4.28.E1` through `4.28.E13` (13 formulas),
with manifest expected/stated equality 13/13 and no omissions.  The
unnumbered periodicity/zeros candidate is also represented.

**Verdict: accept.**  The prior zero-set P1 is repaired: the periodicity
declaration now states genuine bidirectional characterizations

- `sinh z = 0 ↔ ∃ k : ℤ, z = k π i`, and
- `cosh z = 0 ↔ ∃ k : ℤ, z = (k + 1/2) π i`,

in addition to the `2πi` periods of sinh/cosh and the `πi` period of tanh.
These match the DLMF zero sets and retain the integer indexing explicitly.

## Formula audit

- **E1–E3:** exponential definitions and both signed combinations are direct
  complex identities.
- **E4–E7:** quotient and reciprocal definitions use transparent complex
  vocabulary, with prose explaining meromorphic poles and Lean's totalized
  division convention.
- **E8–E10:** imaginary-argument sine, cosine, and tangent identities have
  the correct factors and signs over complex `z`.
- **E11–E13:** cosecant, secant, and cotangent correspondences use the local
  reciprocal definitions where Mathlib lacks dedicated names; the `-i`
  factors and coth relation are correct, including the totalized convention.
- **Periodicity/zeros:** all three periods and both exact iff zero-set
  characterizations are stated in one reusable proposition.

The reciprocal vocabulary is honestly classified in the manifest, no
quantitative companion is warranted, and the surrounding prose preserves the
complex domain, pole convention, source subsection context, and cited
references.

## Anchors, manifest, and build

Every numbered formula has a matching DLMF source link, source anchor, manual
anchor, and manifest declaration.  The manual displays all 13 declarations
and the periodicity/zero-set proposition; extra vocabulary anchors are also
present.  No `#check`, filler status prose, or unreviewed mathematical
candidate was found.

`lake build LMLF.Blueprint.Elementary.Section428` passes with only permitted
`sorry` warnings.  From `doc/`, `lake build LMLFManual.Chapter4.Section428`
and standalone manual elaboration pass as well.

No P0 or P1 findings remain.  **Accept.**
