# DLMF §5.11 referee review (final independent re-review)

## Snapshot and files reviewed

- Snapshot: `f4176ce69852c435e838eeb0b6da69c510f81fef` (`docs: publish rebuilt
  LMLF site`), plus the current uncommitted §5.11 source, manual, manifest,
  and generated-site revisions in the shared worktree.
- Official source: [DLMF §5.11](https://dlmf.nist.gov/5.11), including
  [5.11.E1](https://dlmf.nist.gov/5.11.E1) through
  [5.11.E19](https://dlmf.nist.gov/5.11.E19) and subsection (i)--(iii)
  prose.
- Lean source: `LMLF/Blueprint/Gamma/Section511.lean`.
- Documentation source: `doc/LMLFManual/Chapter5/Section511.lean`.
- Manifest: `coverage/sections/chapter5-511.json`.
- Aggregators checked: `doc/LMLFManual.lean` and
  `doc/LMLFManual/Chapter5.lean`.
- Current generated pages checked under
  `doc/_out/html-multi/___5___11-Asymptotic-Expansions/`, including all three
  subsection pages. `doc/LMLFManual.lean` imports and includes
  `LMLFManual.Chapter5.Section511`.

## Formula inventory and final verdict

The official page and inventory contain exactly the nineteen records
`5.11.E1` through `5.11.E19`. The manifest has exactly this expected/stated
set (19/19, no omissions), and the standalone documentation has 19
`dlmfEntry` blocks. The current generated i/ii/iii pages collectively expose
all 19 DLMF source links and the revised anchors for E3 factorization,
`LnGammaDatum`, complex E1 bounds, generalized Bernoulli generation, and E19.

## Final verdict: accept

The last material issue from the preceding review is resolved. `LnGammaDatum`
now requires exponential compatibility, `AnalyticOnNhd` on each admissible
sector, overlap consistency, and agreement with `Real.log (Real.Gamma x)` on
the positive real ray. For each nonempty sector (0<δ<π), analyticity and the
nonvanishing Gamma value make two logarithm branches differ by a constant
integer multiple of (2πi); the positive-real normalization fixes that
constant. The complex E1 residual is defined from this selected normalized
general logarithm, while the explicit finite terms retain principal
`Complex.log z`, matching the DLMF branch distinction. The `δ≥π` cases are
vacuous or reduce to the positive ray under the stated sector predicate.

All earlier findings are resolved: E9 has bounded-set uniformity; E10/E11
carry sector/nonzero hypotheses and endpoint-safe behavior; complex E1/E2
first-neglected-term bounds have the correct source indexing and distinct
`sec^(2n)`/`sec^(2n+1)` exponents; E3 has an exact named factorization; the
coefficient specifications and generalized-Bernoulli generating relation are
visible; residuals and partial sums are explicit and readable; and the manual
anchors do not expose proof bodies.

## Branch and complex-bound verification

- `gammaSectorDomain δ z` states `z ≠ 0` and
  `|arg z| ≤ π − δ`.
- `LnGammaDatum.exp_eq_gamma` makes the selected function a logarithm of
  `Complex.Gamma` on every admissible sector.
- `LnGammaDatum.analytic_on` rules out arbitrary pointwise integer shifts.
- `LnGammaDatum.branch_consistent` identifies the sector-indexed values on
  overlaps.
- `LnGammaDatum.real_normalization` fixes the remaining constant branch shift
  on the positive real ray.
- `complexStirlingRemainder δ n z` uses `lnGamma δ z`, and
  `dlmf_5_11_1_complex_remainder_bound` has `n ≥ 1`, `δ > 0`, `z ≠ 0`, and
  `|arg z| ≤ π − δ`, with the first omitted term and `sec^(2n)(arg z/2)`.
- The E2 analogue independently uses `complexDigammaRemainder`, the same
  source-indexed truncation, and the distinct `sec^(2n+1)` exponent.

## Formula-by-formula disposition

- **E1/E2:** positive-real Poincaré expansions and sign/magnitude
  first-neglected-term pairs use `range n`; complex approximants use source
  index `n` and `Icc 1 (n−1)`, with the corrected distinct exponents.
- **E3:** `scaledGammaPrefactorReal`, the exact positive-real factorization,
  and the `g_k/x^k` Poincaré expansion are separate named declarations.
- **E4/E5/E6:** all seven displayed `g_k` values, the rising-factorial
  relation, the convolution recurrence, and `a₀ = √2/2` are exposed through
  `StirlingCoefficientSpec` and its projections.
- **E7/E8:** real-positive restrictions are stated honestly; E8's local
  `k+2` indexing represents the source sum beginning at `k=2`.
- **E9:** both imaginary directions are stated with explicit uniform relative
  error on every bornologically bounded real `x` set.
- **E10/E11:** E10 has explicit residual, `δ > 0`, nonzero-z, and sector
  conditions; E11's capped secant handles the admitted cosine-zero endpoint.
- **E12--E14:** positive-real quotient specializations preserve the powers,
  centered even indexing, and Poincaré relation.
- **E15/E16:** the three displayed initial `G` and `H` identities are present.
- **E17/E18:** generalized Bernoulli arguments and `2k` indexing are correct,
  and the selected values satisfy the explicit real generating-function
  specification `(t/(e^t-1))^α * e^(x*t) = Σ B_n^(α)(x) t^n/n!` for
  `|t|<2π`.
- **E19:** the positive-real Gamma-product term has the displayed signs,
  rising factorials, factorial, and shifted Gamma argument; the source's
  broader complex/sector setting is explicitly narrowed.

## Specializations, quantitative pairs, and readability

The page labels real-positive restrictions for E1, E2, E3, E7, E8, E9,
E12--E14, E17, E18, and E19. E10/E11 retain complex variables and their
sector/nonzero hypotheses; E4--E6 and E15--E16 state coefficient identities
over real parameters. The E1 prose and manifest explicitly distinguish the
general normalized `Ln Γ` on the left from principal `ln z` in the terms.

The genuinely distinct quantitative statements are all present: the real E1
and E2 sign/magnitude pairs and the complex E1/E2 sector bounds. Named
`seriesPartialSum`, `complexStirlingApprox`, `complexDigammaApprox`, and
`gammaRemainder` make truncation and residual indexing directly readable.

## Build, manifest, anchors, and integration

- `lake env lean LMLF/Blueprint/Gamma/Section511.lean`: passed with 28
  expected `sorry` warnings and no errors.
- Root `lake build`: passed (3265 jobs).
- Documentation `cd doc && lake build`: passed (6996 jobs), including
  `LMLFManual.Chapter5.Section511` and the final site executable.
- Manifest: 19 expected, 19 stated, empty omission list; 19 documentation
  `dlmfEntry` blocks.
- Generated pages: all 19 DLMF source links are present across the current
  subsection pages; revised E3, branch, complex-bound, generalized-Bernoulli,
  and E19 anchors are visible. No `by sorry` or `#check` occurs in the
  reader-facing §5.11 page.
- No unreviewed numbered candidates were found. The consequence
  `Γ* ∼ 1` follows from E3 and `gCoeff 0 = 1` and needs no separate numbered
  declaration.
