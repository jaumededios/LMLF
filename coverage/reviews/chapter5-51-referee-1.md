# Referee review: DLMF §5.1

## Snapshot and files reviewed

- Snapshot: `f4176ce69852c435e838eeb0b6da69c510f81fef` (`docs: publish rebuilt LMLF
  site`, 2026-09-06); the assigned Section 5.1 files are uncommitted in this
  worktree.
- Official source: [DLMF §5.1 Special Notation](https://dlmf.nist.gov/5.1), including
  all eight notation-table rows, the principal-function paragraph, and the historical
  alternative-notation paragraph (DLMF version 1.2.7, released 2026-06-15).
- Source inventory: `coverage/dlmf-4-10-source-inventory.json` (Section 5.1 has
  `prose_block: 4` and `table_row: 8`, and no numbered formulas).
- Author manifest: `coverage/sections/chapter5-51.json`.
- Lean statement file: `LMLF/Blueprint/Gamma/Section51.lean`.
- Manual source file: `doc/LMLFManual/Chapter5/Section51.lean`.
- Assembly source: `doc/LMLFManual/Chapter5.lean` and `doc/LMLFManual.lean`.
- Rendered artifact: a generated
  `___5___1-Special-Notation/___5___1-Special-Notation/index.html` page was inspected
  after registration and contained the Section51 declaration anchors.  A later full-doc
  rebuild attempt was stopped by an unrelated shared dependency failure, so the current
  tree does not provide a newly regenerated page for the revised prose.

## Independently computed coverage and verdict

The official page and source inventory contain no numbered formulas.  The independently
computed expected formula-ID set is therefore empty:

`{}`

The manifest's `numbered_formula_ids_expected`, `numbered_formula_ids_stated`, and
`numbered_formula_ids_omitted` are all empty, so the numbered-ID equality check passes.
The eight table rows and both substantive prose paragraphs are represented by the five
manifest statement groups (`5.1.variables`, `5.1.delta`, `5.1.functions`,
`5.1.alternatives`, and `5.1.constants`).  The beta domain wording now distinguishes
Mathlib's Euler integral from the meromorphic continuation; the factorial declaration is
marked as a `specialization`; the `deriv` totalization caveat is stated in both source and
manual; and the page is registered in the assembled manual.  The Lean module, standalone
manual source are all available; the registered rendered anchors were verified in the
generated page before the later shared rebuild attempt.

Verdict: **accept**.

## Findings

No P0, P1, P2, or P3 finding remains after revision.  The revised beta wording states
that `Complex.betaIntegral` is Mathlib's Euler interval integral and gives its
positive-real-part convergence conditions, while directing meromorphic continuation to
§5.12.  The revised factorial prose and manifest relation explicitly identify
`gamma_nat_succ_eq_factorial` as the `Nat` specialization of the source's general-complex
factorial notation.  The revised derivative prose/docstrings disclose Mathlib's
totalized `deriv` and restrict its intended use to established differentiability domains.
Finally, the Section51 manual is imported and included by `LMLFManual.lean`, and the
generated page inspected after registration exposed complete module-qualified declaration
anchors.

## Correctly handled specializations and quantitative pairs

- `5.1.variables` covers all eight table rows: `j,m,n` and ordinary `k` indices use
  `ℕ`, the §5.20 exception is called out, `x,y` are real, `z=x+i y` is represented by
  explicit real coordinates, and real-or-complex parameters use `ℂ` with canonical
  coercions.  The complex q restriction is `‖q‖ < 1`, with the real-q equivalence
  stated separately.
- `5.1.delta` is honestly recorded as a consequence: for each positive tolerance it
  exhibits a positive smaller `δ`, matching “arbitrary small positive constant.”
- `5.1.functions` correctly names Gamma, psi/digamma, beta, and q-Gamma; q-Gamma is
  deferred to §5.18 rather than duplicated.  Gamma and psi wrappers point to
  `Complex.Gamma` and `Complex.digamma`.
- `5.1.alternatives` correctly defines Gauss's shifted `Π`, Gauss's shifted `Ψ`, Davis's
  `Ψ`, and Pairman's shifted `𝖥`, and the three shift identities are source-faithful.
  The ordinary-factorial line is explicitly labeled as the `Nat` specialization of the
  source's general-complex notation.
- `5.1.constants` correctly exposes Euler's constant and the prime/`deriv` convention,
  with the totalization caveat made explicit in both source and manual.

There are no numbered formulas and no genuinely distinct quantitative declaration pairs
in §5.1.  The manifest's `quantitative_analogue: not_applicable` entries are appropriate.

## Manifest, anchors, hygiene, and source candidates

All 21 manifest declaration names resolve to declarations in the Lean source.  The
source-side Lean anchors are complete and module-qualified; the standalone manual source
has matching anchors for all of them, and the generated §5.1 page inspected after
registration exposed the complete declarations with namespace context.  No `#check`,
filler status prose, or proof work
displacing notation coverage was found.  The eight permitted `sorry`s are confined to the
proof bodies of the expected proof-pending declarations.

The remaining Section 5.1 inventory candidates are the table rows and prose already
sampled above.  The “For other notation” link and historical author/date citations are
bibliographic/navigation metadata, not missing mathematical declarations.  No additional
substantive source candidate remains unreviewed.

## Build result

- `lake env lean LMLF/Blueprint/Gamma/Section51.lean`: **passed**, with the eight
  expected `sorry` warnings.
- From `doc/`, `lake env lean LMLFManual/Chapter5/Section51.lean`: **passed**.
- `lake build LMLF.Blueprint.Gamma.Section51`: **passed** (2799 jobs).
- From `doc/`, `lake build LMLFManual.Chapter5.Section51`: **passed** (3032 jobs).
- The full `lake build LMLFManual` currently stops on unrelated moving full-doc
  dependencies (Section 5.11 anchor mismatches in the earlier attempt, and then a missing
  root `LMLF.Integral.Improper.Bochner.olean` during the later attempt); these shared
  failures are not charged to Section 5.1.  The previously generated Section51 page was
  inspected after registration; regenerating it with the latest prose awaits the shared
  full-doc build repair.
- `python3 scripts/validate_inventory.py`: **passed**.
