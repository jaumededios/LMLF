# DLMF §5.14 object-author handoff

## Scope

Repaired only the §5.14 Lean source, manual page, and section manifest:

- `LMLF/Blueprint/Gamma/Section514.lean`
- `doc/LMLFManual/Chapter5/Section514.lean`
- `coverage/sections/chapter5-514.json`

The seven numbered records remain covered: `5.14.E1` through `5.14.E7`.

## Object/API changes

- Added `MultidimensionalDomain n`, whose carrier is a set of points of the
  typed space `Fin n → ℝ`.
- Added `domainIntegral` and `domainIntegrable`, separating a value identity
  from its Bochner convergence assertion while retaining explicit volume
  measure.
- Recast `simplex`, `unitCube`, `positiveOrthant`, `wholeSpace`, and
  `dysonCube` as typed domain objects rather than bare sets.
- Added `firstCoordinateSelection hmn : Fin m → Fin n` and used it in the
  Selberg/Laguerre moment factors.  This is the canonical first-coordinate
  inclusion, not an arbitrary coordinate witness.
- Added named simplex integrands and exposed every custom definition before
  its use in the manual.
- Split all seven conjunction-shaped numbered declarations into independent
  `_integrable` and value declarations.  The formulas remain real,
  positive-parameter specializations of the complex source, as documented in
  the manifest and page prose.

No additional pole-free subtype is needed in this section: the displayed
parameter hypotheses are real positivity/lower-bound conditions, and the
reusable typed-domain object is the persistent domain invariant used by all
seven formulas.

## Coverage and verification

- Expected formula IDs: 7.
- Stated formula IDs: 7.
- Omitted formula IDs: 0.
- Numbered declarations: 14 (seven convergence declarations and seven value
  declarations), all intentionally `by sorry`.
- Source anchors: 31; manual anchors: 31.
- `lake env lean LMLF/Blueprint/Gamma/Section514.lean`: passed.
- `lake build LMLFManual.Chapter5.Section514` from `doc/`: passed.
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter5/Section514.lean`:
  passed (9 source expressions accepted).
- No `#check` occurrences in the owned source or manual.
- Manifest JSON parses and expected/stated ID sets agree.

## Remaining gap

The section intentionally specializes DLMF's complex parameters and real-part
conditions to real parameters with positivity/lower-bound hypotheses.  Proofs
remain pending by the statement-coverage contract.
