# DLMF §5.11 object-first repair

## Scope

This repair is limited to the §5.11 Lean source, Verso source, and section
manifest. It addresses the Chapter 5 global object audit findings G5-3 and
G5-4, plus the §5.11 object-referee blockers: coefficient streams and
generalized Bernoulli data were previously exposed through `Classical.choice`
projections, and the sector branch was also selected globally.

## Object/API changes

- `aCoeffStep` isolates the new coefficient in the DLMF convolution, and
  `aCoeffState` is a finite-state prefix computation. `aCoeff` is the
  canonical stream map, while `gCoeff` is reconstructed from it by the
  DLMF rising-factorial formula.
- `aCoeff_recurrence`, `aCoeff_initial`, `aCoeff_unique`, and `aCoeff_prefix`
  expose the semantic recurrence, normalization, uniqueness boundary, and
  finite-prefix access before the asymptotic theorems use the stream.
- `generalizedBernoulliFormal` is the canonical formal binomial/exponential
  generating series over `PowerSeries ℝ`. `generalizedBernoulli` reads its
  factorial-scaled coefficient, with separate
  `generalizedBernoulli_generating` and `generalizedBernoulli_prefix`
  declarations. The old `GeneralizedBernoulliSpec`, existence theorem, and
  selected projection are removed.
- The exact scaled-Gamma factorization remains separate from its Poincaré
  expansion, and the real/complex first-neglected-term bounds remain separate
  quantitative statements.
- `LnGammaDatum` is now an explicit argument to `lnGamma` and the complex E1
  remainder bound; `existsLnGammaDatum` remains only as an honest existence
  boundary, with no selected `Classical.choice` branch.
- `gammaRemainder` remains a named residual only because it is paired with the
  substantive E11 sector bound and `gammaRemainder_tendsto_zero` on the
  positive ray. The E10 identity is documented as bookkeeping rather than
  treated as the error content.
- `scaledGammaReal_asymptotic_one` makes the positive-real consequence
  `Γ*(x) ∼ 1` explicit using ordinary asymptotic-equivalence notation.
- The manual moves `risingFactorial` and `generalizedBinomial` panels into
  the introductory vocabulary block before their first use.

The sectorial `LnGammaDatum` remains an honest branch datum with its own
existence boundary; this task did not conflate branch selection with the
coefficient/data maps being repaired.

## Coverage

- Numbered formulas expected/stated: 19/19.
- Numbered formulas omitted: none.
- Manual `dlmfEntry` blocks: 19.
- Extra manifest entries now include the finite-state coefficient objects,
  formal generalized-Bernoulli map/prefix/generating declarations,
  `scaledGammaReal_asymptotic_one`, and the substantive remainder decay.

## Verification

- `lake env lean LMLF/Blueprint/Gamma/Section511.lean` passed; only the
  intended proof-pending `sorry` warnings remain.
- `cd doc && lake build LMLFManual.Chapter5.Section511` passed.
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter5/Section511.lean`
  passed: KaTeX accepted all source expressions.
- Focused searches found no `Classical.choice`, `#check`, or obsolete selected
  coefficient/generalized-Bernoulli specification names in the owned
  source/manual/manifest files.

## Remaining gaps

The recurrence uniqueness, analytic generalized-Bernoulli generating theorem,
branch-datum existence theorem, complex remainder bounds, and positive-ray
remainder decay are intentionally `by sorry` under the section-author
contract. The section's documented positive-real specializations remain
recorded in the manifest. Rendered HTML is intentionally not regenerated here;
the root task owns that aggregate build.
