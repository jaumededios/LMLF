# Final referee report: DLMF §4.34 Derivatives and Differential Equations

## Snapshot and files reviewed

Snapshot: `4c16e1da2c62b9eb5d69cab6fdd52f201570b17d`. I reread the referee
contract and `coverage/reviews/chapter4-434-referee-1.md`, independently
checked the official [DLMF §4.34](https://dlmf.nist.gov/4.34) and the local
inventory, and reviewed exactly:

- `LMLF/Blueprint/Elementary/Section434.lean`;
- `doc/LMLFManual/Chapter4/Section434.lean`;
- `coverage/sections/chapter4-434.json`.

## Inventory and formula parity

The independent numbered inventory is exactly `4.34.E1` through `4.34.E14`.
Manifest expected/stated sets agree 14/14, with no omissions. Each formula has
an individual source link and a matching source/manual anchor.

## ODE-predicate repair

The prior P0 is repaired. `secondOrderODE`, `quadraticPlusODE`,
`quadraticMinusODE`, and `riccatiODE` are now transparent reusable predicates,
and E7–E10 prove those predicates only for named hyperbolic families:

- E7 uses `A cosh(az) + B sinh(az)`;
- E8 uses `sinh(az+c)/a`;
- E9 uses `cosh(az+c)/a`;
- E10 uses `tanh(az+c)/a`.

Thus no declaration asserts an ODE for an arbitrary unconstrained function.
The manual explains this candidate/family distinction, and the manifest names
both each predicate and its family theorem with honest `specialization`
relations.

## Formula audit

- **E1–E2:** direct complex derivatives of `sinh` and `cosh`.
- **E3–E6:** reciprocal derivatives expose the relevant nonzero denominator
  and pole hypotheses, with the source derivative expressions preserved.
- **E7–E10:** the four source differential equations are represented by the
  transparent predicates and instantiated on the corresponding families with
  `a ≠ 0`.
- **E11:** the complete `A cosh(az)+B sinh(az)` second-order family is stated
  directly and tied to the equation.
- **E12–E13:** the sinh and cosh parametrizations retain arbitrary `c` and
  nonzero scale `a`, with the displayed local derivative consequences.
- **E14:** the coth parametrization retains `a ≠ 0` and excludes zeros of
  `sinh(az+c)` before differentiating.

The complex-variable specialization matches the source. §4.34 contains no
distinct error estimate, truncation bound, or other quantitative companion.
The introductory ODE prose and Kamke reference are represented; the latter is
bibliographic context and needs no Lean declaration.

## Verification

- `lake build LMLF.Blueprint.Elementary.Section434` — passed with permitted
  `sorry` warnings;
- from `doc/`, `lake env lean LMLFManual/Chapter4/Section434.lean` — passed;
- formula anchors: 14 source / 14 manual;
- no `#check`, filler status prose, or displaced proof work.

## Verdict: accept

The E7–E10 false-global-classification blocker is resolved. All E1–E14 retain
their domains, derivative/pole hypotheses, readable family semantics, manifest
parity, proof-free anchors, and successful source/manual builds. No P0 or P1
finding remains.
