# Referee review: DLMF §5.14

## Re-review snapshot and files

Review snapshot remains `f4176ce69852c435e838eeb0b6da69c510f81fef` (`docs:
publish rebuilt LMLF site`), with revised assigned author files uncommitted in
the worktree. Re-reviewed:

- the official [DLMF §5.14 Multidimensional Integrals](https://dlmf.nist.gov/5.14)
  page and all seven numbered displays;
- the §5.14 records in `coverage/dlmf-4-10-source-inventory.json`;
- `LMLF/Blueprint/Gamma/Section514.lean`;
- `doc/LMLFManual/Chapter5/Section514.lean`;
- `coverage/sections/chapter5-514.json`;
- `doc/LMLFManual/Chapter5.lean`; and
- the generated highlighted declaration artifact
  `doc/.lake/build/highlighted/LMLF/Blueprint/Gamma/Section514.json`.

## Independently computed coverage set and verdict

The official page and source inventory contain exactly:

`5.14.E1`, `5.14.E2`, `5.14.E3`, `5.14.E4`, `5.14.E5`, `5.14.E6`, `5.14.E7`.

The manual and manifest state exactly this set, with no omissions or extras.

## Verdict: accept

The prior E4 P0 is resolved. `selbergIndex` is now a real-valued expression
`(n : ℝ) - k.1 - 1`, and both E4 denominator families use
`selbergIndex n k + (n : ℝ) - 1`, which is exactly `2n-k-1` for source
`k = k.1+1`, without natural-number truncation. The revised prose and
manifest honestly disclose the positive-dimension restrictions and the
totalized `Real.rpow` a.e. convention. All assigned source files elaborate
with the permitted `sorry`s. Chapter 5 registration and static-site wiring
remain parent-owned integration work and are not scored as a section finding
in this re-review.

## Formula-by-formula audit

- **5.14.E1 — accepted.** The simplex domain, real-positive `z`, explicit
  `0 < n`, product volume, integrability assertion, Gamma quotient, and the
  totalized boundary representative are all visible and honestly labeled.
- **5.14.E2 — accepted.** The residual barycentric coordinate, `Fin.last n`,
  `Fin.castSucc`, simplex domain, real-positive/positive-dimensional
  specialization, measure, integrability, and Gamma quotient match the
  source.
- **5.14.E3 — accepted.** The nested finite products select exactly one
  `t j - t k` factor for each `j < k`; the real-coordinate presentation is
  identified as such.
- **5.14.E4 — accepted after repair.** For zero-based `k : Fin n`,
  `selbergIndex n k = n-k.1-1` in `ℝ`, hence
  `selbergIndex n k + n - 1 = 2n-(k.1+1)-1 = 2n-k_source-1`.
  This corrected factor appears in both the `Fin m` moment ratio and the
  `Fin n` Gamma denominator. The unit-cube domain, first-coordinate moment,
  absolute Vandermonde power, endpoint powers, positivity, convergence
  conditions, and `IntegrableOn` statement are source-faithful.
- **5.14.E5 — accepted.** The positive orthant, Laguerre exponential,
  `n-k` and `1+k c` factors, denominator `Gamma(1+c)^n`, moment product,
  convergence conditions, and totalized a.e. power convention are explicit.
- **5.14.E6 — accepted.** The whole-space domain, Gaussian factor,
  `(2π)^(-n/2)` normalization, `k=1,...,n` Gamma product, real `c`,
  positive dimension, and diagonal a.e. convention match the source.
- **5.14.E7 — accepted.** The `[-π,π]^n` domain, pairwise unit-circle norm
  product, real `b`, positive dimension, normalization, Gamma quotient, and
  collision-hyperplane a.e. convention are explicit.

No declaration is an opaque proxy: the theorem anchors show complete
statements, and the helper integrands and domains expose the mathematical
objects. The seven `sorry`s are the manifest's declared proof-pending
placeholders and are permitted by the referee contract.

## Correct specializations and quantitative pairs

- E1, E2, E4, E5, E6, and E7 are honestly labeled real/positive-real
  specializations of the source's complex-parameter formulas; E3 is recorded
  directly over real coordinate vectors.
- E1/E2 and E6/E7 now disclose their `0 < n` restriction; E4/E5 disclose the
  `2 ≤ n` convention needed for the displayed `n-1` bounds.
- The page-wide prose and manifest notes correctly explain that Mathlib's
  totalized `Real.rpow` values on zero-base boundary, endpoint, diagonal, or
  collision loci are a.e. representatives and do not change the volume
  integrals.
- No DLMF display requires a second quantitative declaration. All seven
  manifest entries correctly use `quantitative_analogue: not_applicable`.

## Manifest, anchors, prose, and hygiene

The manifest's expected/stated ID sets are exact, every declaration name
resolves to the intended namespace, all proof statuses are honestly `missing`,
and the specialization labels and notes agree with the revised statements.
Lean and manual formula anchors agree one-for-one and include
`module := LMLF.Blueprint.Gamma.Section514`; the highlighted artifact contains
all seven fully qualified theorem declarations, including the corrected E4
signature. No `#check`, filler status prose, or proof work displacing
statement coverage was found.

The current `Chapter5.lean` aggregator still does not import/register the
standalone §5.14 page, so no rendered §5.14 page was available. This is the
parent-owned integration item described above, not a defect in the revised
section source.

## Verification and unreviewed candidates

- `lake env lean LMLF/Blueprint/Gamma/Section514.lean`: **passed**, with the
  seven expected `sorry` warnings.
- `lake build LMLF` from the repository root: **passed** (2929 jobs).
- `lake env lean LMLFManual/Chapter5/Section514.lean` from `doc/`: **passed**.
- `lake build` from `doc/`: **passed** (6304 jobs).

The sampled source prose candidates (`p1`, `Px1.p1`, `Px1.p2`, `Px1.p3`, and
`Px2.p1`) are represented by the authored introductory text and entries; the
section Notes are bibliographic. No additional substantive unreviewed source
candidate remains. The eventual rendered-page check is parent-owned.
