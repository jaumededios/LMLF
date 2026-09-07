# Referee report: DLMF §5.5

## Snapshot and files reviewed

- Snapshot: `f4176ce69852c435e838eeb0b6da69c510f81fef`.
- Lean source: `LMLF/Blueprint/Gamma/Section55.lean`.
- Manual source: `doc/LMLFManual/Chapter5/Section55.lean`.
- Coverage manifest: `coverage/sections/chapter5-55.json`.
- Independently consulted source inventory: `coverage/dlmf-4-10-source-inventory.json` and
  `coverage/dlmf-4-10.json`.
- Official source: [DLMF §5.5 Functional Relations](https://dlmf.nist.gov/5.5), including the
  individual formula links E1–E9 and [§5.5(iv)](https://dlmf.nist.gov/5.5.iv).

## Independently computed coverage

Filtering the source inventory to `section == "5.5"` and `kind == "numbered_formula"` gives,
in document order,

`5.5.E1, 5.5.E2, 5.5.E3, 5.5.E4, 5.5.E5, 5.5.E6, 5.5.E7, 5.5.E8, 5.5.E9`.

The manual has one `dlmfEntry` and one corresponding Lean declaration for every one of these IDs;
none is omitted or duplicated. It also handles the unnumbered Bohr–Mollerup result as
`5.5.iv.BohrMollerup`.

## Verdict: accept

On re-review, the numbered mathematics is complete and readable, the E9-from-E6 source note is
present, the manifest is aligned, and both Lean source and the standalone Section55 manual file
elaborate with the permitted `sorry`s. Top-level manual integration/rendering is explicitly
parent-owned and is not a finding in this re-review.

## Findings

### Re-review disposition

No P0–P3 findings remain for the assigned source files. The previously reported DLMF §5.5(iii)
source-note issue is resolved at
`doc/LMLFManual/Chapter5/Section55.lean:194-195`, which now states that E9 follows from E6 by
logarithmic differentiation while keeping the two pointwise declarations separate. Top-level
manual integration and rendered-site wiring are parent-owned for this pass.

## Formula, prose, and API audit

- E1, `gamma_recurrence` (`LMLF/Blueprint/Gamma/Section55.lean:23`), matches
  `Gamma(z+1)=z Gamma(z)` and explicitly excludes exactly the nonpositive-integer poles.
- E2, `digamma_recurrence` (`:31`), matches the reciprocal term and uses the same pole-free
  domain; the prose correctly identifies digamma as Gamma’s logarithmic derivative.
- E3 and E4, `gamma_reflection` (`:39`) and `digamma_reflection` (`:48`), match the reflection
  formulas and correctly encode `z` not an integer with `∀ k : ℤ`.
- E5, `gamma_duplication` (`:57`), matches Legendre’s formula. The complex `^` expressions are
  the principal complex powers, and the prose correctly explains the positive bases and the
  condition `2z` not a nonpositive integer.
- E6, `gamma_multiplication` (`:67`), has the correct `(2π)^((1-n)/2)`, `n^(nz-1/2)`, and
  `Finset.range n` product. The positive-natural hypothesis is the meaningful nonzero-
  denominator domain of the source’s nonnegative-integer notation.
- E7, `gamma_rational_product` (`:79`), uses `Finset.Ico 1 n`, exactly representing
  `k = 1, ..., n-1`; the `n = 1` empty-product explanation is correct. Its real-valued form is
  honestly labelled in the manual.
- E8 and E9, `digamma_duplication` (`:88`) and `digamma_multiplication` (`:97`), preserve the
  principal logarithm and the finite-value pole restrictions. Their averaging and finite index
  ranges agree with the DLMF formulas.
- The unnumbered Bohr–Mollerup entry, `bohrMollerup_unique` (`:110`), faithfully states positivity,
  normalized recurrence, log-convexity on `Set.Ioi 0`, and equality with `Real.Gamma` on that set.
  The `Set.EqOn` conclusion does not accidentally claim anything about `f` outside the positive
  axis.

No declaration is an opaque proxy: every statement displays the source expression. No `#check`,
filler status prose, or proof work displacing statement coverage was found in either authored
source file.

## Correct specializations and quantitative-pair audit

- Correctly classified specializations: E1 and E2 (ordinary pole-free pointwise forms of the
  meromorphic recurrences), and E8 and E9 (pointwise forms where all displayed digamma values are
  finite).
- Correctly handled exact relations: E3, E4, E5, E6, E7 (the positive-real presentation of the
  same proper-fraction identity), and the unnumbered Bohr–Mollerup theorem. The manifest names the
  declarations at the exact namespace paths and records `proof_status: missing`, consistent with
  the ten `sorry` placeholders.
- No genuinely distinct quantitative declaration exists or is required; all ten entries correctly
  use `quantitative_analogue: not_applicable`.

## Build result and unreviewed candidates

- `lake build` at the repository root: pass (2944 jobs).
- `lake env lean LMLF/Blueprint/Gamma/Section55.lean`: pass, with only the ten expected
  `declaration uses sorry` warnings.
- `lake build` in `doc/`: pass (6304 jobs).
- The standalone Section55 source was also checked directly with `lake env lean`; it elaborated
  without errors. The rendered-site integration was not re-audited because it is parent-owned.

No mathematically substantive sampled source candidate remains unrepresented in the authored prose.
The remaining sampled candidates are section metadata, bibliographic notes, the E5/E6 domain
lead-ins already repeated in the manual, or the Bohr–Mollerup prose already captured by the extra
statement.
