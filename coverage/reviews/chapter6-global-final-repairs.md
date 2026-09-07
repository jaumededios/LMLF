# Chapter 6 global final repairs

Implemented the four repairs from `chapter6-global-final-referee-a.md`.

## §6.12 shared Poincaré interface

`Section612` now imports `LMLF.Quantitative.Series` and uses
`QuantitativeAnalysis.HasPoincareExpansion` with the library argument order
`(filter, function, term)`. The competing local definition was removed. The
manual explains the shared retained-term indexing (`0` through `n`) separately
from the source finite-remainder indexing used by E5–E8.

## Canonical auxiliary functions

The §6.2 `principalAuxiliaryF` and `principalAuxiliaryG` definitions are the
only canonical public pair. §6.4 continuation-side values are now named
`principalContinuationFValue` and `principalContinuationGValue`, with explicit
principal-domain bridge theorems to the §6.2 pair. §6.7 no longer shadows the
§6.2 names, and §6.11's `auxiliaryF/G` aliases consume the §6.2 canonical
objects.

## §6.13 displayed prefix

`dlmf_6_13_2` now states the finite displayed-prefix expansion for the Ci and
si zero families. The arbitrary coefficient continuation and its all-orders
remainder theorem are retained under explicitly auxiliary names. The primary
quantitative companion `dlmf_6_13_2_remainder` now uses the displayed-prefix
remainder predicate, while the all-orders quantitative result is auxiliary.

## §6.16 sawtooth domain

The global `sawtoothValue` helper was replaced by
`sawtoothValueOnDomain`, which takes the strict source interval proof as an
argument. The E1 theorem and manual panel expose the domain explicitly; no
outside-domain value is exported.

## Verification

- Lean source builds pass for Sections 6.11, 6.12, 6.13, 6.16, 6.4, and 6.7.
- `lake build LMLFManual.Chapter6` passes.
- Source TeX checks pass for Sections 6.11, 6.12, 6.13, 6.16, and 6.4.
- `scripts/validate_inventory.py` passes.
- No `#check` declarations were introduced; all new declarations have source
  doc comments and expandable manual panels before their theorem use.
