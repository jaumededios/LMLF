# LMLF

LMLF is a Lean 4 and [mathlib](https://github.com/leanprover-community/mathlib4) library for exact
special-function definitions, finite approximants, and explicit error bounds. Its first
source-coverage programme is the corrected 1997 reprint of F. W. J. Olver's *Asymptotics and
Special Functions*. The [project blueprint](blueprint/README.md) records the detailed scope,
specifications, and release gates.

## Current status

The repository contains a candidate implementation of the externally authorized BOOTSTRAP-0
packets QB-001 and DEF-001. The candidate exposes foundational finite-error predicates and transport
lemmas and transparent wrappers around Mathlib's Gamma function. It is awaiting implementation
review and release; these declarations must not yet be described as accepted or released. The
source ledgers are initial audit seeds, not a complete source inventory, and the project claims no
quantitative Olver theorem or source coverage yet.

Planning and review artifacts are kept explicit:

- [Roadmap](blueprint/roadmap.md)
- [Source manifest and inventory policy](blueprint/source_manifest.md)
- [Function inventory protocol](blueprint/function_inventory.md)
- [Manual review package](review/README.md)

## Library layout

- `LMLF/Basic.lean` provides narrow shared imports for foundational quantitative algebra.
- `LMLF/Definitions/Gamma.lean` provides the four candidate wrappers around `Complex.Gamma`.
- `LMLF/Quantitative/Basic.lean` provides the eight candidate finite-error declarations.
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

1. Start from a frozen, bounded work packet whose externally stored review envelope records `lean_ready: pass` under the [review workflow](review/README.md).
2. Create a focused branch and add declarations in the narrowest suitable module.
3. Import public semantic modules through the appropriate umbrella; keep audit modules separate.
4. Run `lake build` locally before opening a pull request.
5. Keep commits small enough that definitions, statements, and proofs can be reviewed together.

GitHub Actions validates the specification inventory and builds the public Lean package for pushes
and pull requests.

## License

LMLF is released under the MIT License. See [LICENSE](LICENSE).
