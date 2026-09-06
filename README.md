# LMLF

> **Proposed successor-authority notice (pending).** The user-authorized broad
> DLMF-through-Chapter-10 boundary is specified by proposed
> [`blueprint/stage_1_dlmf-R4.md`](blueprint/stage_1_dlmf-R4.md), DD-021
> revision 3. Its exact six-file successor, enumerated there by repo-relative
> path, takes effect only after two fresh independent blueprint approvals and a
> root external adjudication bind the exact successor commit and digests. Until
> then, the predecessor control plane remains operative. Once effective,
> DD-021 changes only the enumerated programme-priority/scheduling clauses;
> frozen Olver evidence and semantics remain unchanged, and `OLV-MVP-1`
> remains an eligible parallel Olver-track packet, not a DLMF prerequisite or
> target.

LMLF is a Lean 4 and [mathlib](https://github.com/leanprover-community/mathlib4) library for exact
special-function definitions, finite approximants, and explicit error bounds. Its locked Olver
source-coverage track uses the corrected 1997 reprint of F. W. J. Olver's *Asymptotics and
Special Functions*. The [project blueprint](blueprint/README.md) records the detailed scope,
specifications, and release gates.

## Current status

The reviewed BOOTSTRAP-0 implementation at commit
`515b742f7ad5472c17cfdf0fda7cbc83c5585da1` exposes foundational finite-error predicates and
transport lemmas and transparent wrappers around Mathlib's Gamma function. Its external evidence
records the exact accepted candidate; later planning commits do not alter those Lean declarations.

The exact 1997 Olver PDF was previously inspected and hash-bound outside version control, and its
mathematical transcriptions survive. The original uploaded bytes are not present in this restarted
environment; any new source-image audit requires reattachment or recovery. This does not block the
source-independent IMP/QL work. Theorem 3.1 on Watson's lemma has a mathematical transcription.
The source-free IMP layer is now bounded by frozen card revision 7, the new
metadata-only proof successor `NLP-IMP-001-R7`, and work-packet revision 1 in
the separate closed `IMPROPER-0` manifest. The successor preserves the R6
mathematical proof and equations while updating only lifecycle/binding/status
metadata; canonical `blueprint/proofs/IMP-001.md` R6 remains unchanged
historical mathematical input and the dependency recorded by the QL/OLV
drafts. The frozen specification also binds the accepted eight-signature, three-module
[IMP R6 signature proposal revision 2](blueprint/theorem_cards/IMP-001-signatures-R6.md),
SHA-256 `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d`.
Fresh exact-byte referees C and D approved only that signature proposal at
`9e6e038871ac66f80534626d3deade0b27af6752`; the root negative-guard finding
was resolved only for those bytes. The records are archived at private
[`review-evidence` commit `d0d4fb4`](https://github.com/jaumededios/LMLF/commit/d0d4fb4895733b5de8396794e81cbe1a19657bdb).
This is prerequisite-stage evidence, not final-packet quorum. `execution_ready`
means only that the source-free specification is closed and fully bounded.
The compiled-unreviewed prototype uses temporary axiomatic theorem stubs only;
it is not production Lean.
Fresh final pre-Lean reviews and an external envelope are still pending; no
`lean_ready`, implementation, PDF-fidelity, or source-coverage claim follows.
QL-001 and OLV-001 remain unchanged revision-4 planning drafts. The old IMP
revision-3 signature artifact remains superseded evidence. The eight-target IMP surface preserves
independent endpoint semantics and exposes only the primitive-equivalence, arbitrary-exception
Bochner, continuous-linear-map, local-splitting, and Abel bridges needed to close the QL/OLV
consumer route; its finite-piece Abel engine remains private. Bounded Airy,
Euler--Maclaurin/Bernoulli, and Bessel source transcriptions are also present, together with
unregistered Bernoulli identification drafts. Two independent source referees approved the exact
revision-2 Bessel transcriptions, and all 119 proposed Bessel occurrences are now integrated
one-for-one into the normalized inventory. Those rows remain `transcribed_unreconciled`: no Bessel
notation or entity association, theorem card, manifest membership, coverage credit, reconciliation,
or Lean work is authorized. The source ledgers are still far from a complete book inventory, and the
project claims no quantitative Olver theorem or source coverage yet.

Current planning classifications use version 3, which records the classical QL-001 mathematics as
`non_novel`; frozen version-2 artifacts remain unchanged, and this metadata correction grants no
review or implementation approval.

Historical review reports are preserved at the private repository's
[`review-evidence` commit `5c8ec1b`](https://github.com/jaumededios/LMLF/commit/5c8ec1b301f656df35ffa8850e002639807995cd).
Those records bind only their own recorded commits and do not determine the status of later drafts.

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
4. Run `lake build` and
   `python3 scripts/validate_inventory.py --negative-tests` locally before
   opening a pull request.
5. Keep commits small enough that definitions, statements, and proofs can be reviewed together.

GitHub Actions is explicit manual-only via `workflow_dispatch`; it does not
run on pushes or pull requests. Routine checks are the local `lake build` and
`python3 scripts/validate_inventory.py --negative-tests` commands.

## License

LMLF is released under the MIT License. See [LICENSE](LICENSE).
