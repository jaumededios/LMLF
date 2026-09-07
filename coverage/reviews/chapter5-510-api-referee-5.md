# Referee report: DLMF §5.10 final API audit

## Snapshot and files reviewed

- Snapshot: `d6e983b4cd0480fdd162cb1eae0bdd9a92c3568f`; current worktree bytes
  include the repaired §5.10 manifest and manual/source changes.
- Official source: [DLMF §5.10](https://dlmf.nist.gov/5.10), version 1.2.7,
  including [5.10.E1](https://dlmf.nist.gov/5.10.E1) and
  [5.10.E2](https://dlmf.nist.gov/5.10.E2).
- Source inventory: `coverage/dlmf-4-10-source-inventory.json`.
- Lean files: `LMLF/Blueprint/Gamma/Section510.lean` and
  `LMLF/Definitions/ContinuedFraction.lean`.
- Manual files: `doc/LMLFManual/Chapter5/Section510.lean` and
  `doc/LMLFManual/Chapter2.lean`.
- Manifest: `coverage/sections/chapter5-510.json`.
- Generated HTML was not used for this verdict; its rebuild is parent-owned.

## Independently computed expected formula IDs

The official source and inventory contain exactly two numbered formula records
in section 5.10: `5.10.E1` (display `5.10.1`) and `5.10.E2` (display
`5.10.2`). E2 is one grouped display with components `5.10.E2a` through
`5.10.E2g`, corresponding to `a₀` through `a₆`. There are no omitted or extra
numbered formulas.

## Verdict

`accept`

The repaired source, manual, and manifest are now mutually consistent. The
manifest has the current declaration names, exact formula IDs, and the correct
proof flags (`5.10.2` proved by executable evaluation; `5.10.1` proof-pending).
The reusable interface is taught in Chapter 2, including optional offset,
zero-termination, the triangular recurrence, residual extraction, and the
finite-prefix theorem. Formal reconstruction/uniqueness are explicitly
conditional on regularity and are kept separate from analytic convergence.
No P0 or P1 finding remains.

## Findings

### P2 — Document the totalized zero-constant branch of the reciprocal helper

- **Declaration:** `LMLF/Definitions/ContinuedFraction.lean:53-68`,
  `normalizedReciprocalCoeff`.
- **Evidence:** its docstring calls the output “coefficients of `s(0) / S`,”
  but the implementation returns `1, 0, 0, …` when `s 0 = 0`; formal division
  by a nonunit series is not defined in that case. This does not invalidate the
  API's theorems: `CFracRegular` excludes a nonzero zero-constant residual, and
  reconstruction/uniqueness require that regularity hypothesis. It is only a
  minor readability caveat for users applying the total function directly.
- **Suggested polish:** amend the docstring to say “when `s 0 ≠ 0`, these are
  the coefficients of `s(0) / S`; the `s 0 = 0` branch is a totalizing value and
  is not used for nonzero regular residuals.”

## Formula-by-formula disposition

- **5.10.1 / E1:** The manual has the exact source link and continued-fraction
  display, preserves `\(\Re z>0\)`, and labels Lean's theorem as the
  positive-real specialization. It distinguishes DLMF's general `Ln Γ` from
  the real logarithm used for `x > 0`, then embeds the real limit in `ℂ`.
  `continuedFractionConvergent` is correctly oriented: index `n` uses
  numerators `offset` through `offset+n`, so the default `n=0` is `a₀/z` and
  increasing depth adds the next right-truncated numerator. The theorem is
  proof-pending by `sorry`, as accurately reflected by the manifest, but the
  statement itself is the intended analytic specialization rather than an
  existential or opaque proxy.
- **5.10.2 / E2:** The manual and Lean conjunction contain all seven source
  values in order. `gammaContinuedFractionCoeff` is the canonical Bernoulli /
  odd-Stirling extraction, and `native_decide` evaluates the displayed prefix.
  `cfracCoeff_congr_prefix` states the finite dependency needed for any
  requested index (`s n = t n` for `n ≤ k` implies equality at `k`).

## Object-first/API audit

- `continuedFraction` and `continuedFractionConvergent` are reusable generic
  evaluators with a default-zero optional offset. Both the definition comment
  and Chapter 2 explain tail indexing.
- `ZeroTerminated` and `CFCoefficients` package the stable invariant that a
  zero numerator ends the stream, eliminating arbitrary invisible tails.
- `normalizedReciprocalCoeff`, `cfracStep`, `cfracRemainder`, and
  `cfracCoeffValue` are exposed in both Chapter 2 and §5.10, so the executable
  triangular algorithm is inspectable rather than hidden behind a choice.
- Formal syntax/evaluation, formal-series reconstruction/uniqueness, and
  analytic convergence are separate declarations. `formalContinuedFraction_cfracCoeff`
  and `cfracCoeff_unique` require `CFracRegular`; the Gamma specialization
  supplies `gammaContinuedFractionCoeff_regular` separately. No theorem silently
  upgrades formal equality to analytic convergence.

## Correctly handled specializations and quantitative pairs

- E1 → `LMLF.Blueprint.Gamma.Section510.dlmf_5_10_1`: positive-real
  specialization of the source half-plane/general-logarithm statement.
- E2 → `LMLF.Blueprint.Gamma.Section510.dlmf_5_10_2`: exact grouped seven-value
  display, computed from the canonical rational coefficient map.
- The formal reconstruction and uniqueness results are reusable consequences,
  not additional DLMF numbered formulas.
- Neither numbered formula has a distinct quantitative analogue; both manifest
  entries correctly set `quantitative_analogue`, `quantitative_statement`, and
  `quantitative_proof` to false.

## Build, exact anchors, TeX, JSON, and source candidates

- `lake env lean LMLF/Blueprint/Gamma/Section510.lean`: passed; only the
  permitted `sorry` warnings occur for Gamma regularity and E1 convergence.
- `cd doc && lake env lean LMLFManual/Chapter5/Section510.lean`: passed,
  resolving all current external anchors, including the recurrence and
  finite-prefix declarations.
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter5/Section510.lean`:
  passed (6 expressions after the later-coefficient note); the same check passed
  for `doc/LMLFManual/Chapter2.lean` (4 expressions).
- Read-only JSON validation passed: exact IDs are `['5.10.1', '5.10.2']`,
  `omitted_ids` is empty, summary `lean_proofs` is `1`, E1 is `lean_proof: false`,
  E2 is `lean_proof: true`, and every listed declaration name exists in the
  current Lean source.
- No `#check`, filler status prose, or proof work displacing statement coverage
  was found. The source note now represents DLMF's Char (1980) pointer for exact
  `a₇`–`a₁₁` and 40-significant-digit values through `a₄₀`, while correctly
  explaining that those references are not additional §5.10 formulas. No
  unreviewed substantive source candidate remains; generated HTML is deferred
  to the parent-owned rebuild.
