# DLMF §5.11 object-first referee (second review)

## Snapshot and files reviewed

- Snapshot: `31b53f875c4884773698176b216809df59ea24a7`, together with the
  current uncommitted repairs in the assigned files.
- Official source: [DLMF §5.11](https://dlmf.nist.gov/5.11), including the
  subsection prose and numbered formulas E1--E19.
- Independent inventory: `coverage/dlmf-4-10-source-inventory.json`.
- Lean source: `LMLF/Blueprint/Gamma/Section511.lean`.
- Manual source: `doc/LMLFManual/Chapter5/Section511.lean`.
- Manifest: `coverage/sections/chapter5-511.json`.
- Aggregation context: `doc/LMLFManual/Chapter5.lean` and
  `doc/LMLFManual.lean`.

The assignment explicitly says to ignore stale generated HTML for this
re-review; the verdict below is therefore based on the current Lean source,
manual source, manifest, inventory, and build/anchor checks.

## Formula inventory and verdict

Independent recomputation gives exactly:

`5.11.E1`, `5.11.E2`, `5.11.E3`, `5.11.E4`, `5.11.E5`, `5.11.E6`,
`5.11.E7`, `5.11.E8`, `5.11.E9`, `5.11.E10`, `5.11.E11`, `5.11.E12`,
`5.11.E13`, `5.11.E14`, `5.11.E15`, `5.11.E16`, `5.11.E17`, `5.11.E18`,
`5.11.E19`.

The manifest has the same 19 expected and stated IDs and an empty omission
list.  The manual contains 19 `dlmfEntry` blocks, each linking to the matching
DLMF formula URL.

**Verdict: ACCEPT.** No P0, P1, P2, or P3 blocker remains after the repair.

## Findings

There are no findings requiring revision.

### Resolved object-first issue: explicit logarithm datum

`LnGammaDatum` at
`LMLF/Blueprint/Gamma/Section511.lean:286-298` carries the value map and its
exponential compatibility, analyticity, overlap/branch consistency, and
positive-real normalization fields.  The existence theorem at lines 301--303
is not projected through `Classical.choice`; instead, `lnGamma` at lines
306--312 takes an explicit `datum : LnGammaDatum`, and the complex remainder
and bound APIs likewise take that datum (`complexStirlingRemainder` at
lines 330--334 and its consumers).  The manual explains this boundary at
`doc/LMLFManual/Chapter5/Section511.lean:421-463`.

This is an honest interface: it does not pretend that a canonical global
branch has been constructed, and it does not hide an arbitrary witness in a
public definition.  A branch construction/proof remains proof-pending, as
declared by the manifest, but that is not an object-selection defect.

### Resolved object-first issue: remainder semantics

The E10 residual is still a transparent finite-expansion remainder, but it is
no longer the only semantic content exposed for that object.  The reconstruction
statement `dlmf_5_11_10` is paired with the substantive sectorial quantitative
bound `dlmf_5_11_11` (Lean lines 511--520; manual lines 543--550), preserving
the source hypotheses `K ≥ 1`, `z ≠ 0`, and
`|arg z| ≤ π/2`, including the K=1 replacement and capped secant factor.
The positive-real family also has the separate convergence statement
`gammaRemainder_tendsto_zero` (Lean lines 522--525; manual lines 556--560).
Thus syntax/reconstruction, quantitative control, and asymptotic convergence
are separate declarations rather than a merely tautological remainder API.

### Resolved prose assertion: scaled Gamma tends to one

The DLMF prose assertion following E3 is now represented by
`scaledGammaReal_asymptotic_one` at
`LMLF/Blueprint/Gamma/Section511.lean:379-382` and explained in the manual at
`doc/LMLFManual/Chapter5/Section511.lean:246-253`.  It uses ordinary Mathlib
`~[atTop]` for equivalence to the constant function `1`; it does not confuse
that relation with the Chapter 2 `∼ₚ` Poincaré-expansion notation.  The
manifest records it as `5.11.scaledGammaReal-asymptotic-one`.

### Declaration ordering and canonical coefficient objects

The manual's shared vocabulary block introduces `risingFactorial` and
`generalizedBinomial` before `aCoeff`/`gCoeff` and the ratio APIs
(`doc/LMLFManual/Chapter5/Section511.lean:37-48`).  The coefficient API is
reader-usable in order: `aCoeffStep`, the finite-state `aCoeffState`,
canonical `aCoeff`, direct `gCoeff`, recurrence, initial value, uniqueness,
and prefix statements precede the numbered uses.  The Lean source has the
same dependency-safe order.

`aCoeff` is a canonical finite recurrence map, not a selected sequence:
`aCoeffStep` isolates the new coefficient, `aCoeffState` uses finite
`Nat.rec`, and the recurrence/initial/uniqueness/prefix declarations expose
its semantics and finite dependence.  `gCoeff` is the stated direct
reconstruction.  These are noncomputable real-valued definitions because of
the real constants involved, but they are canonical mathematical maps and
not hidden arbitrary choices.

The generalized Bernoulli API is likewise canonical.  At
`LMLF/Blueprint/Gamma/Section511.lean:141-170`,
`generalizedBernoulliFormal` is the formal binomial/exponential generating
series, `generalizedBernoulli` is its factorial-scaled coefficient, and the
generating-function and prefix declarations expose the analytic and finite
interfaces separately.  No `Classical.choice` or opaque selected
`GeneralizedBernoulliSpec` remains.

## Correctly handled specializations and source fidelity

- E1/E2 preserve the positive-real logarithmic/digamma specializations and
  the source's one-based complex index with truncation through `n - 1`; the
  first-neglected-term bounds and the distinct complex sector bounds retain
  the source's `sec^(2n)` and `sec^(2n+1)` powers.
- E3 states the positive-real scaled-Gamma specialization, its exact
  prefactor factorization, the coefficient expansion, and the explicit
  `Γ* ~ 1` consequence.
- E4--E6 retain the seven displayed coefficient values, rising-factorial
  relation, convolution recurrence, and normalized initial value.
- E7/E8 label the fixed-real-parameter positive-real specializations and
  preserve E8's local source index beginning at `k = 2`.
- E9 represents both `y → +∞` and `y → -∞` directions and quantifies uniform
  relative error over every bounded real-x set.
- E10/E11 preserve the complex prefactor, finite sum, `δ > 0`, nonzero-z, and
  sector hypotheses; E11 retains the K=1 replacement and endpoint-safe capped
  secant.
- E12--E14 and E19 are explicitly labeled positive-real quotient/product
  specializations; E15--E18 retain the real coefficient identities and the
  generalized-Bernoulli representation.

## Quantitative-pair discipline

The E1 and E2 first-neglected-term bounds are distinct from their complex
sector bounds and are recorded as separate manifest extras.  E11 is the
distinct quantitative companion to E10, while
`gammaRemainder_tendsto_zero` is qualitative convergence rather than a second
bound.  No redundant quantitative declaration was found.

## Build, anchors, and source hygiene

- `lake env lean LMLF/Blueprint/Gamma/Section511.lean`: succeeds with the
  expected 32 proof-pending (`sorry`) warnings and no errors.
- From `doc/`, `lake build LMLFManual.Chapter5.Section511`: succeeds (3470
  jobs; same intentional proof-pending warnings).
- `node scripts/check_source_tex.mjs
  doc/LMLFManual/Chapter5/Section511.lean`: passes; all 21 source expressions
  are accepted.
- `python3 scripts/validate_inventory.py`: passes.
- The current Lean/manual anchor inventories each contain 74 anchors with
  exact set parity.  The repaired manual order is dependency-safe, including
  all shared custom declarations before their first use.
- No `Classical.choice`, `#check`, filler status prose, or unsupported TeX
  delimiter was found in the assigned source/manual files.

All numbered source candidates are covered by E1--E19.  The only intentionally
unmodeled material is editorial/reference prose rather than a mathematical
claim requiring a public declaration.  Proofs remain marked `missing` in the
manifest as expected; this review audits statement fidelity and object/API
design, not theorem completion.
