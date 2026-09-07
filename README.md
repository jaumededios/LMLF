# LMLF

LMLF is a Lean 4 and [mathlib](https://github.com/leanprover-community/mathlib4) library for exact
special-function definitions, finite approximants, and explicit error bounds. Its first
source-coverage programme is the corrected 1997 reprint of F. W. J. Olver's *Asymptotics and
Special Functions*. The [project blueprint](blueprint/README.md) records the detailed scope,
specifications, and release gates.

## Current status

The current programme targets source-statement coverage of Olver's book,
starting with Chapter 5. See the [current direction](blueprint/current_direction.md),
the [Chapter 5 checklist](blueprint/olver/chapter05.md), and the approved
[Wronskian/Abel natural-language blueprint](blueprint/olver/chapter05-wronskians.md).
The first accepted Lean slice checks exactly `C05-01-08`–`C05-01-11`: the
Wronskian derivative, Abel identity, zero/nowhere-zero alternative, and
constant-Wronskian corollary. Chapter 5 therefore stands at `4/108 = 3.70%`
of the disclosed claim-component inventory, `0/13` whole numbered theorems,
and `0/44` exercises. The full fundamental-pair equivalence in Theorem 1.2
remains pending.

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

At the current baseline commit `b8d2f731fcfd5cd0889d0732f13699eb94681c86`,
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
- `LMLF/Quantitative/Basic.lean` provides the eight candidate finite-error declarations.
- [`LMLF/ODE/Wronskian.lean`](LMLF/ODE/Wronskian.lean) provides the accepted real-variable
  Wronskian and Abel API for complex- and real-valued solutions.
- [`LMLFTest/ODE/Wronskian.lean`](LMLFTest/ODE/Wronskian.lean) provides the nonpublic
  hypergeometric and associated-Legendre equation consumers.
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
