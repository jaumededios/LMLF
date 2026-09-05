# LMLF

LMLF is a Lean 4 and [mathlib](https://github.com/leanprover-community/mathlib4) library for exact
special-function definitions, finite approximants, and explicit error bounds. Its first
source-coverage programme is the corrected 1997 reprint of F. W. J. Olver's *Asymptotics and
Special Functions*. The [project blueprint](blueprint/README.md) records the detailed scope,
specifications, and release gates.

## Current status

The repository is at the specification stage. No semantic declaration has passed the project's
acceptance gates, so the public Lean modules currently provide package structure only. QB-001 and
DEF-001 remain specification work items awaiting their required external pre-Lean,
implementation-review, and release gates. The source ledgers are initial audit seeds, not a
complete source inventory, and the project claims no quantitative Olver theorem or source coverage
yet.

Planning and review artifacts are kept explicit:

- [Roadmap](blueprint/roadmap.md)
- [Source manifest and inventory policy](blueprint/source_manifest.md)
- [Function inventory protocol](blueprint/function_inventory.md)
- [Manual review package](review/README.md)

## Library layout

- `LMLF/Basic.lean` provides narrow shared imports for foundational quantitative algebra.
- `LMLF/Definitions.lean` is an empty public umbrella reserved for accepted definitions.
- `LMLF/Results.lean` is an empty public umbrella reserved for accepted semantic results.
- `LMLF.lean` imports the public package modules.

The `LMLF` library target lists only these public modules. Keep semantic dependencies flowing from
shared foundations to definitions to results.

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
