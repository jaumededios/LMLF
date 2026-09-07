# Referee report: DLMF §5.4

## Snapshot and files reviewed

- Snapshot: `f4176ce69852c435e838eeb0b6da69c510f81fef` (`site/verso-dlmf-overlay`).
- Official source: [DLMF §5.4 Special Values and Extrema](https://dlmf.nist.gov/5.4), including the E1–E20 formula pages, the §5.4(ii)/(iii) notes, and Table 5.4.1.
- Source inventory: `coverage/dlmf-4-10-source-inventory.json` and the section inventory records for `dlmf:5.4`.
- Author files: `LMLF/Blueprint/Gamma/Section54.lean`, `doc/LMLFManual/Chapter5/Section54.lean`, and `coverage/sections/chapter5-54.json`.
- Integration files inspected: `doc/LMLFManual.lean`, `doc/LMLFManual/Chapter5.lean`, and the existing `doc/_out/html-multi` tree.
- The assigned source, manual, manifest, and review files are working-tree additions at this snapshot. There is no rendered standalone §5.4 page in the existing HTML tree, so external-anchor rendering could only be checked at source level; standalone documentation elaboration was checked below.

## Independently computed formula IDs

Filtering the official source inventory to `section == "5.4"` and `kind == "numbered_formula"` gives exactly:

```text
5.4.E1, 5.4.E2, 5.4.E3, 5.4.E4, 5.4.E5,
5.4.E6, 5.4.E7, 5.4.E8, 5.4.E9, 5.4.E10,
5.4.E11, 5.4.E12, 5.4.E13, 5.4.E14, 5.4.E15,
5.4.E16, 5.4.E17, 5.4.E18, 5.4.E19, 5.4.E20
```

The manifest has the same expected and stated sets and no omitted or extra numbered IDs. Every `dlmfEntry` in the manual has the corresponding official source URL.

## Verdict: accept (re-review)

The author resolved all prior P1/P2 findings. E11–E13 now preserve the displayed signed derivative identities, E20 now states both Gamma-derivative and digamma zero conditions, the manual reproduces all eleven Table 5.4.1 data rows as labelled approximations, and the E2 `n = -1` note is explicit. Numbered-ID coverage remains exact, anchors and manifest names agree, and both authored Lean/documentation files elaborate with the permitted `sorry`s. No open P0/P1/P2/P3 finding remains.

## Findings

### Resolved P1 — E11–E13 preserve the signs of the displayed derivatives

- DLMF E11 is `Gamma'(1) = -gamma` ([source](https://dlmf.nist.gov/5.4.E11)); E12 is `psi'(1) = pi^2/6`; and E13 is `psi'(1/2) = pi^2/2` ([E12](https://dlmf.nist.gov/5.4.E12), [E13](https://dlmf.nist.gov/5.4.E13)). The vertical bars visible in the HTML table extraction are column delimiters, not absolute-value symbols; the official E11 TeX is `\[\Gamma'\left(1\right)=-\gamma.\]`.
- `LMLF/Blueprint/Gamma/Section54.lean:113-136` now states `deriv Real.Gamma 1 = -Real.eulerMascheroniConstant`, `deriv Complex.digamma 1 = Real.pi ^ 2 / 6`, and `deriv Complex.digamma (1 / 2 : ℂ) = Real.pi ^ 2 / 2`. The manual at `doc/LMLFManual/Chapter5/Section54.lean:168-207` now uses signed-derivative prose, and the E11–E13 manifest notes explicitly record the signed identities. The source signs are preserved; finding closed.

### Resolved P1 — The extrema result formalizes the critical-point characterization and table

- The official Table 5.4.1 caption states `Gamma'(x_n) = psi(x_n) = 0` and gives eleven data rows (`n = 0,...,10`) with decimal values for both `x_n` and `Gamma(x_n)`; see [Table 5.4.1](https://dlmf.nist.gov/5.4#T1). The table’s correction note also says the `x_n` entries were corrected and ten extra decimal places added.
- `LMLF/Blueprint/Gamma/Section54.lean:213-224` (`gamma_extrema_asymptotic`) now asserts, for every `n`, both `deriv Real.Gamma (x n) = 0` and `Complex.digamma (x n : ℂ) = 0`. The manual at `doc/LMLFManual/Chapter5/Section54.lean:294-333` reproduces all eleven rows `n = 0,...,10`, labels them corrected decimal approximations, records the correction note, and links Figure 5.3.1. The E20 manifest note and known-gap text now describe the rows and derivative condition accurately; finding closed.

### Resolved P2 — E2 records the exceptional `n = -1` source note

- After E2, DLMF explicitly notes that the odd line also applies at `n = -1` ([E2](https://dlmf.nist.gov/5.4.E2), immediately following the formula), despite the symbol glossary’s ordinary nonnegative-integer convention.
- `doc/LMLFManual/Chapter5/Section54.lean:48-72` now states the DLMF `n = -1` extension and explicitly scopes the Lean specialization to `n : ℕ`; the corresponding Lean comment at `LMLF/Blueprint/Gamma/Section54.lean:34-38` and manifest note record the same boundary. No separate integer theorem is needed for this statement-coverage page; finding closed.

## Formula/API audit

- E1 (`gamma_special_factorial`) has the correct Gamma-at-one and factorial-at-`n+1` identities for nonnegative `n`; the complex presentation is an honest exact specialization.
- E2 (`doubleFactorial`, `gamma_doubleFactorial_even`, `gamma_doubleFactorial_odd`) has the correct finite same-parity product and even/odd powers, Gamma argument, and parity hypotheses for natural `n`; the exceptional source note and specialization boundary are now recorded above.
- E3 (`gamma_imaginary_modulus`) preserves the real `y` line and makes the necessary `y ≠ 0` condition explicit for the quotient.
- E4 (`gamma_half_line_product`) preserves both the conjugate product/squared norm equality and the `pi/cosh(pi*y)` value; the real norm square is explicitly cast to `Complex`.
- E5 (`gamma_quarter_shift_product`) has the correct quarter-shifted complex product and denominator for real `y`.
- E6–E10 (`gamma_half_value`, `gamma_third_value`, `gamma_two_thirds_value`, `gamma_quarter_value`, `gamma_three_quarters_value`) preserve the listed Gamma arguments and decimals; the exact half-value is paired with a clearly stated numerical enclosure, and the other four are honestly presented as real numerical enclosures rather than exact decimal equalities.
- E11–E13 now preserve the source’s signed derivative formulas in both Lean and prose.
- E14 (`digamma_nat_value`) uses `Finset.range n` with `k+1`, exactly representing the source sum `k=1,...,n` for nonnegative `n`.
- E15 (`digamma_half_nat_value`) has the source’s `n=1,2,...` condition (`0 < n`) and the odd reciprocal sum through `2n-1`.
- E16 and E18 (`digamma_imaginary_part`, `digamma_one_shift_imaginary_part`) preserve the reciprocal signs and rewrite `coth` as `cosh/sinh`, with `y ≠ 0` made explicit.
- E17 (`digamma_half_shift_imaginary_part`) preserves the real-line formula and rewrites `tanh` as `sinh/cosh`; no nonzero hypothesis is needed.
- E19 (`digamma_rational_value`) is honestly labelled a natural-number specialization of the integer `0 < p < q` formula. `Finset.Ico 1 q` is exactly `k=1,...,q-1`, and complex `log`, `cos`, and `cot` preserve the principal-function presentation.
- E20 (`gamma_extrema_asymptotic`) states both critical-point equations and correctly turns the displayed `O(1/(n(log n)^2))` into a positive-constant eventual bound, with `n → ∞` represented by `∀ᶠ ... in atTop`; the manual’s eleven table rows are separately labelled approximations.

All manual anchors are present and source-level names match the declarations and manifest entries, including the separate `doubleFactorial` definition and both E2 parity theorems. No `#check`, filler status prose, or proof work displacing statement coverage was found. The source declarations are readable and expose the displayed expressions rather than opaque certificates.

## Correctly handled specializations and quantitative pairs

- Honest specializations: E2 (natural/real double-factorial form), E3 (real nonzero imaginary-axis parameter), E5 (real parameter in the complex product), E6–E10 (real Gamma values with decimal enclosures), E14–E19 (real/natural parameter forms of the complex digamma identities), and E20 (real critical-point sequence plus explicit eventual bound). E1 and E4 are direct exact formulations in the chosen complex representation.
- E11–E13 are correctly labelled specializations in the manifest, with notes explicitly identifying the signed derivative identities now retained by the statements.
- No genuinely distinct second quantitative declaration is present or required. The E6–E10 enclosures are part of the same special-value declarations, and E20’s explicit eventual bound is the quantitative content of the single asymptotic formula. Every manifest `quantitative_analogue` is therefore correctly `not_applicable`.
- The source table rows, table correction note, subsection bibliography, and “compare Figure 5.3.1” cross-reference were sampled. The table rows/caption and E2 `n=-1` note are now represented; the bibliography and figure cross-reference are non-declaration prose.

## Build result

- Root `lake build`: **passed** (2944 jobs).
- `lake env lean LMLF/Blueprint/Gamma/Section54.lean`: **passed**, with the expected 21 `declaration uses sorry` warnings (E2 has two parity declarations).
- Documentation `lake build`: **passed** (6304 jobs).
- `lake env lean LMLFManual/Chapter5/Section54.lean`: **passed**.
- Rendered-page/interactive-anchor check: **unavailable** for §5.4 because no standalone Section54 page exists in the committed `doc/_out/html-multi` tree; all source-level anchors and module-qualified declarations were checked.
