# LMLF

LMLF is a Lean 4 and [mathlib](https://github.com/leanprover-community/mathlib4) library for exact
special-function definitions, finite approximants, and explicit error bounds. Its first
source-coverage programme is the corrected 1997 reprint of F. W. J. Olver's *Asymptotics and
Special Functions*. The [project blueprint](blueprint/README.md) records the detailed scope,
specifications, and release gates.

## Current status

The current programme targets source-statement coverage of Olver's book,
starting with Chapter 5. See the [current direction](blueprint/current_direction.md),
the [Chapter 5 checklist](blueprint/olver/chapter05.md), the approved
[Wronskian/Abel blueprint](blueprint/olver/chapter05-wronskians.md), and the accepted
[global-IVP](blueprint/olver/chapter05-global-ivp.md) and
[fundamental-pair](blueprint/olver/chapter05-fundamental-pairs.md) blueprints, the accepted
[first-order blueprint](blueprint/olver/chapter05-first-order.md), and the accepted
[local Gauss-series](blueprint/olver/chapter05-hypergeometric-series.md) and
[local Gauss-ODE](blueprint/olver/chapter05-hypergeometric-ode.md) blueprints.
The first accepted Lean slice checks exactly `C05-01-08`–`C05-01-11`: the
Wronskian derivative, Abel identity, zero/nowhere-zero alternative, and
constant-Wronskian corollary. The accepted Theorem 1.1 slice now also checks
`C05-01-02` and `C05-01-03`: global `C²` existence, uniqueness for arbitrary
initial value and derivative, and infinitely many solutions. The accepted Theorem 1.2 slice checks
`C05-01-04`--`C05-01-07`: interval-relative spanning and linear independence, the existing
Wronskian definition, the full three-way equivalence, explicit Cramer representations, and the
normalized canonical pair. The accepted first-order slice completes `C05-01-01`, and the accepted
local Gauss-series and ODE slices complete `C05-09-01` and `C05-09-02`. Chapter 5 therefore stands
at `13/108 = 12.04%` of the disclosed claim-component inventory, `2/13 = 15.38%` whole numbered
theorems, and `0/44` exercises. All eleven claim components in §1 are now checked; its two
exercises remain unproved.

The [accepted global-IVP blueprint](blueprint/olver/chapter05-global-ivp.md) records the proof and
its correspondence with the six public real/complex phase, `C²`, uniqueness, and infinitude
declarations in [`LMLF/ODE/LinearSecondOrder.lean`](LMLF/ODE/LinearSecondOrder.lean), together with
the two Wronskian-reuse consumers in
[`LMLFTest/ODE/LinearSecondOrder.lean`](LMLFTest/ODE/LinearSecondOrder.lean).

The accepted [fundamental-pair blueprint](blueprint/olver/chapter05-fundamental-pairs.md) records the
reviewed mathematics, the root-resolved spanning-predicate name, the accepted real/complex API,
and its verification evidence. The implementation and focused consumers are in
[`LMLF/ODE/FundamentalPair.lean`](LMLF/ODE/FundamentalPair.lean) and
[`LMLFTest/ODE/FundamentalPair.lean`](LMLFTest/ODE/FundamentalPair.lean).

The accepted first-order implementation and tests are in
[`LMLF/ODE/LinearFirstOrder.lean`](LMLF/ODE/LinearFirstOrder.lean) and
[`LMLFTest/ODE/LinearFirstOrder.lean`](LMLFTest/ODE/LinearFirstOrder.lean). The accepted Abel
formulas now consume the first-order classification API directly without changing their public
statements.

The accepted local-series implementation and tests are in
[`LMLF/Definitions/Hypergeometric.lean`](LMLF/Definitions/Hypergeometric.lean) and
[`LMLFTest/Definitions/Hypergeometric.lean`](LMLFTest/Definitions/Hypergeometric.lean).
The accepted local ODE implementation and tests are in
[`LMLF/ODE/Hypergeometric.lean`](LMLF/ODE/Hypergeometric.lean) and
[`LMLFTest/ODE/Hypergeometric.lean`](LMLFTest/ODE/Hypergeometric.lean). They complete `C05-09-02`
by proving the unnormalized Gauss equation for the regularized series at every parameter and for
the ordinary series under its denominator hypothesis, throughout the open unit disk and including
the origin. `C05-09-03` remains pending; its separate natural-language packet is not a Lean
implementation and earns no coverage credit.

Both bounded A/B candidates were mathematically correct and built
successfully. The Sol candidate was selected because it had cleaner public
hypotheses and helper boundaries, explicit `Or` and `Xor` forms of the global
alternative, and zero warnings. The Luna candidate had two linter warnings and
would have required additional API and cleanup work. This is a comparison of
those two implementations, not a broader model ranking.

The corrected 1997 A K Peters DjVu of Olver's *Asymptotics and Special
Functions* has been restored, identified, and retained privately outside the
repository. Public files contain only source citations and original
mathematical exposition, not book scans, OCR, or page renderings.

At the historical pre-Chapter-5 baseline commit `b8d2f731fcfd5cd0889d0732f13699eb94681c86`,
the accepted Lean library already contains the improper-integral core and its
regression consumers, together with the foundational finite-error predicates,
transport lemmas, and transparent Mathlib Gamma wrappers. These are real Lean
implementations rather than axiomatic placeholders. Their historical proof
plans and signature records remain available, including
[IMP-001](blueprint/proofs/IMP-001.md) and the
[IMP R6 signature proposal](blueprint/theorem_cards/IMP-001-signatures-R6.md).

Earlier DLMF-oriented, E0, schema, manifest, and authority plans are preserved
as historical records, not as prerequisites for current mathematics. Relevant
records are linked below. Older source transcriptions remain available for
their own scopes but do not establish present Chapter 5 coverage.

Planning and review artifacts are kept explicit:

- [Roadmap](blueprint/roadmap.md)
- [Source manifest and inventory policy](blueprint/source_manifest.md)
- [Function inventory protocol](blueprint/function_inventory.md)
- [Manual review package](review/README.md)
- [Watson source transcription](blueprint/source_transcriptions/OLV97-C03-WATSON.md)
- [Questions for independent Watson review](review/questions/OLV97-C03-WATSON.md)

## Library layout

- `LMLF/Basic.lean` provides narrow shared imports for foundational quantitative algebra.
- `LMLF/Definitions/Gamma.lean` provides the four candidate wrappers around `Complex.Gamma`.
- [`LMLF/Definitions/Hypergeometric.lean`](LMLF/Definitions/Hypergeometric.lean) provides the
  accepted ordinary and regularized local Gauss-series API on the open unit disk.
- [`LMLFTest/Definitions/Hypergeometric.lean`](LMLFTest/Definitions/Hypergeometric.lean) provides
  its nonpublic coefficient, convergence, exceptional-parameter, and analyticity consumers.
- [`LMLF/ODE/Hypergeometric.lean`](LMLF/ODE/Hypergeometric.lean) provides the accepted ordinary and
  all-parameter regularized Gauss differential equations on the open unit disk.
- [`LMLFTest/ODE/Hypergeometric.lean`](LMLFTest/ODE/Hypergeometric.lean) provides local consumers at
  the origin, exceptional denominator parameters, and terminating numerator parameters, including
  a combined analyticity, twice-differentiability, and ODE consumer at `c = -N`.
- `LMLF/Quantitative/Basic.lean` provides the eight candidate finite-error declarations.
- [`LMLF/ODE/LinearFirstOrder.lean`](LMLF/ODE/LinearFirstOrder.lean) provides the accepted real and
  complex exponential-of-an-integral solution and classification API.
- [`LMLFTest/ODE/LinearFirstOrder.lean`](LMLFTest/ODE/LinearFirstOrder.lean) provides its nonpublic
  multiplier, orientation, unbounded-interval, and `EqOn` consumers.
- [`LMLF/ODE/Wronskian.lean`](LMLF/ODE/Wronskian.lean) provides the accepted real-variable
  Wronskian and Abel API for complex- and real-valued solutions.
- [`LMLFTest/ODE/Wronskian.lean`](LMLFTest/ODE/Wronskian.lean) provides the nonpublic
  hypergeometric and associated-Legendre equation consumers.
- [`LMLF/ODE/LinearSecondOrder.lean`](LMLF/ODE/LinearSecondOrder.lean) provides the accepted global
  real and complex linear-IVP API in phase and source forms, plus infinitude.
- [`LMLFTest/ODE/LinearSecondOrder.lean`](LMLFTest/ODE/LinearSecondOrder.lean) provides its nonpublic
  real and complex Wronskian-reuse consumers.
- [`LMLF/ODE/FundamentalPair.lean`](LMLF/ODE/FundamentalPair.lean) provides the accepted real and
  complex fundamental-pair equivalences, Cramer representations, and normalized canonical pairs.
- [`LMLFTest/ODE/FundamentalPair.lean`](LMLFTest/ODE/FundamentalPair.lean) provides its nonpublic
  off-domain-invariance and canonical-pair consumers.
- `LMLF/Definitions.lean` and `LMLF/Results.lean` are the public semantic umbrellas.
- `LMLF/Audit/Definitions.lean` is a separately built regression consumer and is not imported by
  `LMLF.lean`.
- `LMLF.lean` imports only the public semantic package modules.

The `LMLF` library target explicitly lists both semantic and audit modules. Semantic dependencies
flow from shared foundations to definitions and results; the audit module only consumes semantic
modules.

## Getting started

Install [elan](https://github.com/leanprover/elan), then run:

```sh
lake update
lake exe cache get
lake build
```

The `lean-toolchain` file selects the supported Lean release. The mathlib revision is pinned in
`lakefile.toml`, while `lake-manifest.json` records the fully resolved dependency graph.

## Development workflow

1. Start from an identified source statement and record its exact hypotheses,
   conventions, and coverage boundary.
2. Reuse the pinned Mathlib where its verified declaration, domain, and
   hypotheses match. Before attempting genuinely new mathematics in Lean,
   write a complete natural-language proof and obtain multiple fresh,
   independent reviews.
3. Implement on a focused branch in the narrowest suitable module. Keep public
   semantic imports flowing through the appropriate umbrella and keep
   regression consumers outside the public dependency cone.
4. Demonstrate reuse with real downstream consumers where natural, and map
   accepted declarations back to the corresponding source-checklist rows.
5. Run focused builds and regression tests locally, followed by a full
   `lake build` before integration. Verification for this programme is local;
   GitHub CI is not part of the acceptance path.
6. Keep implementation and review units small enough that statements, proofs,
   assumptions, and consumers can be assessed together.

The older E0/schema and authority workflows remain historical documentation;
they do not gate current source mathematics.

## License

LMLF is released under the MIT License. See [LICENSE](LICENSE).
