# LMLF

LMLF is a Lean 4 and [mathlib](https://github.com/leanprover-community/mathlib4) library for exact
special-function definitions, finite approximants, and explicit error bounds. Its first
source-coverage programme is the corrected 1997 reprint of F. W. J. Olver's *Asymptotics and
Special Functions*. The [project blueprint](blueprint/README.md) records the detailed scope,
specifications, and release gates.

## Current status

The reviewed BOOTSTRAP-0 implementation at commit
`515b742f7ad5472c17cfdf0fda7cbc83c5585da1` exposes foundational finite-error predicates and
transport lemmas and transparent wrappers around Mathlib's Gamma function. Its external evidence
records the exact accepted candidate; later planning commits do not alter those Lean declarations.

The exact 1997 Olver PDF is now available as a private, hash-bound source snapshot outside version
control. Theorem 3.1 on Watson's lemma has a mathematical transcription, revision-2 QL-001 and
OLV-001 draft cards, and complete revision-2 natural-language proof dossiers. Bounded Airy,
Euler--Maclaurin/Bernoulli, and Bessel source transcriptions are also present, together with
unregistered Bernoulli identification drafts. Two independent source referees approved the exact
revision-2 Bessel transcriptions, and all 119 proposed Bessel occurrences are now integrated
one-for-one into the normalized inventory. Those rows remain `transcribed_unreconciled`: no Bessel
notation or entity association, theorem card, manifest membership, coverage credit, reconciliation,
or Lean work is authorized. The source ledgers are still far from a complete book inventory, and the
project claims no quantitative Olver theorem or source coverage yet.

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
