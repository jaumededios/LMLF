# DLMF §5.13 object-first author review

## Scope

This pass repairs only `LMLF/Blueprint/Gamma/Section513.lean`,
`doc/LMLFManual/Chapter5/Section513.lean`, and
`coverage/sections/chapter5-513.json`. The five numbered displays in the source
inventory are all covered: 5.13.E1–5.13.E5.

## Object/API changes

- `VerticalLine` packages the real offset, point, constant upward tangent,
  pulled-back integrand, whole-line integral, and integrability predicate. The
  main Barnes theorem therefore has no raw curve or `deriv` hypothesis.
- `PrincipalPowerPoint` packages the nonzero principal-phase base used by E1.
- Each formula has typed domain data and a named integrand. E1, E2, E3, E4,
  and E5 each expose an independent `*_integrable` declaration before the
  value identity, rather than a conjunction that mixes convergence and value.
- `BarnesBetaDomain.integral` names the normalized E3 integral, so its value
  theorem does not repeat the implementation-level integral expression.
- `PoleFreeGammaPoint` and `DeBrangesWilsonDomain` carry the pole-free
  parameter invariant for E5. The E5 kernel uses reciprocal Gamma factors,
  giving the removable totalized extension at `t = 0` while agreeing with the
  displayed quotient away from that point.

The local `VerticalLine` vocabulary is intentional: the shared Chapter 3
interface does not yet provide a whole-line vertical contour. The manifest asks
for promotion of this API before migrating the analogous §5.9, §5.12, and
§5.14 statements.

## Coverage and relations

Expected and stated numbered IDs are both 5 (`5.13.E1` through `5.13.E5`); no
numbered formula is omitted. E1, E3, E4, and E5 retain the source's complex
domains. E2 remains the source's real-parameter specialization. E5's
reciprocal-Gamma kernel is an a.e.-equal, pole-free presentation of the source
quotient, with the same ordinary integral.

## Checks

- `lake env lean LMLF/Blueprint/Gamma/Section513.lean`: passes; only the ten
  intended theorem proofs report `sorry` warnings.
- `cd doc && lake build LMLFManual.Chapter5.Section513`: passes after adding
  source-side anchors for the reusable object API and synchronizing every
  external declaration panel byte-for-byte.
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter5/Section513.lean`:
  passes; all five TeX displays are accepted.
- An independent source/manual anchor comparison reports 33/33 exact matches,
  with no missing or extra anchor names.
- Neither owned file contains `#check`.

## Remaining gap

The five mathematical identities and their convergence interfaces remain
proof-pending by contract (`by sorry`). Shared promotion of `VerticalLine` is a
future Chapter 3 migration and is recorded in the manifest rather than applied
outside this task's file ownership.
