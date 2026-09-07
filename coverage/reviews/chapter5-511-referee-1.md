# DLMF §5.11 referee review (final re-review)

## Snapshot and files reviewed

- Snapshot: `f4176ce69852c435e838eeb0b6da69c510f81fef`, plus the revised §5.11
  author files currently untracked in this worktree.
- Official source: [DLMF §5.11](https://dlmf.nist.gov/5.11), including
  [E1](https://dlmf.nist.gov/5.11.E1) through
  [E19](https://dlmf.nist.gov/5.11.E19) and the subsection prose.
- Source inventory: `coverage/dlmf-4-10-source-inventory.json`.
- Lean source: `LMLF/Blueprint/Gamma/Section511.lean`.
- Documentation source: `doc/LMLFManual/Chapter5/Section511.lean`.
- Manifest: `coverage/sections/chapter5-511.json`.
- Integration: `doc/LMLFManual.lean`, `doc/LMLFManual/Chapter5.lean`, and the
  rendered tree under `doc/_out/html-multi/___5___11-Asymptotic-Expansions/`.

## Coverage and verdict

The official page and inventory contain exactly the nineteen numbered records
`5.11.E1` through `5.11.E19`. The manifest has 19 expected, 19 stated, and 0
omitted IDs; the manual has one matching `dlmfEntry` and source link for each.
All 25 manifest declaration names resolve in the Lean module.

## Final verdict: accept

No P0, P1, P2, or P3 finding remains. The final revision closes the remaining
branch-specification and integration concerns while preserving the prior fixes
for coefficient generation, factorization, uniformity, endpoint safety,
sector hypotheses, remainder definitions, quantitative exponents, and indexing.

## Final branch and coefficient audit

- **Sectorial general logarithm:** `LnGammaDatum` now requires all four laws
  needed by the E1 source reading: `exp_eq_gamma` identifies the exponential
  with `Complex.Gamma`; `analytic_on` gives `AnalyticOnNhd ℂ` on each admissible
  sector; `branch_consistent` identifies overlapping sector choices; and
  `real_normalization` fixes the value to
  `(Real.log (Real.Gamma x) : ℂ)` for positive real `x`. `lnGamma` projects
  this datum, and `complexStirlingRemainder` uses `lnGamma δ z` rather than
  principal `Complex.log (Complex.Gamma z)`. The explicit finite terms retain
  principal `Complex.log z`, matching the source distinction.
- **Generalized Bernoulli data:** `GeneralizedBernoulliSpec` carries a genuine
  `HasSum` generating-function constraint for
  `(t/(exp t−1))^α exp(x t)` on `|t| < 2π`; E17/E18 coefficients are projected
  from the selected datum. The proof-pending existence theorem is explicit in
  the manifest, not an unconstrained opaque stream.
- **Positive-real E3:** `scaledGammaPrefactorReal`, `scaledGammaReal`, and the
  named `scaledGammaReal_factorization` theorem expose the exact factorization
  separately from the `g_k/x^k` Poincaré expansion.

## Formula-by-formula audit

- **E1/E2:** positive-real `∼ₚ` expansions, named finite approximants, and
  first-neglected-term sign/magnitude bounds are present. Real local index zero
  maps to E1 source `k=1` and E2's `-1/(2x)`. Complex helpers use one-based
  source `n`, truncate through `n−1`, and provide distinct bounds with powers
  `2*n` and `2*n+1`.
- **E3:** positive-real scaled Gamma, exact prefactor identity, and coefficient
  series are separated and correctly indexed.
- **E4–E6:** all seven `g_k` values, the rising-factorial relation, recurrence,
  and `a₀=√2/2` are carried by `StirlingCoefficientSpec` and its projections.
- **E7/E8:** fixed real `a>0,b` and fixed real `h` specializations are stated;
  E8 starts at source `k=2`.
- **E9:** both imaginary directions are represented, with uniform relative
  convergence on every bornologically bounded real-`x` set.
- **E10/E11:** E10 retains `δ>0`, `z≠0`, and `|arg z|≤π−δ`, with explicit
  principal prefactor, finite sum, and residual remainder. E11 retains its
  nonzero-z sector and uses `cappedSecant` to make the included
  `|arg z|=π/2` endpoint safe.
- **E12–E14:** positive-real quotient specializations preserve ordinary and
  centered powers and Poincaré notation.
- **E15/E16:** all displayed initial `G` and `H` identities are present.
- **E17/E18:** generalized-Bernoulli order, argument, and `2*k` indexing are
  correct and constrained by the generating-function datum.
- **E19:** the positive-real Gamma-product term has the correct sign,
  factorial, rising factorials, and shifted Gamma argument.

No further distinct quantitative pair is warranted: E1/E2's real finite
first-omitted-term bounds and their separate complex sector bounds are the
source's distinct estimates; E11 is the numbered bound for E10.

## Anchors, prose, manifest, and integration

- The source has 69 balanced `-- ANCHOR` pairs and the manual has exactly 69
  matching `anchor` blocks. The full structure/specification fields are shown
  in the reader-facing anchors, with no literal `sorry`, `#check`, or filler
  status prose in the manual source.
- The Lean module has 28 expected proof-pending `sorry` warnings; the rendered
  interactive code exposes the corresponding warning metadata. This is the
  manifest's explicit proof-status gap, not hidden or displaced coverage.
- `doc/LMLFManual.lean` imports and includes `Section511`; the generated
  top-level navigation links the standalone §5.11 page, and the three rendered
  subsection pages contain the revised branch, E3, E9–E11, coefficient, and
  E1–E19 anchors. The manifest no longer carries a stale parent-integration
  known-gap entry.

## Build and validation checks

- `lake env lean LMLF/Blueprint/Gamma/Section511.lean`: succeeds with only the
  28 expected `sorry` warnings.
- Root `lake build`: succeeds (3265 jobs).
- From `doc/`, `lake build`: succeeds (6996 jobs), and
  `lake env lean LMLFManual/Chapter5/Section511.lean` succeeds after the
  dependency graph is built.
- `python3 scripts/validate_inventory.py`: passes.
- No assigned-file declaration uses `opaque`, `#check`, or contract-prohibited
  filler; manifest `proof_status: missing` entries honestly record the pending
  theorem proofs and specification-existence boundaries.
