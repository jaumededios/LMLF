# DLMF §4.6 final referee review

## Snapshot and files reviewed

Snapshot: `703f1ad1d96c360bbac555c43dc39f6ca64d1a7b`.

Reviewed independently:

- Official [DLMF §4.6](https://dlmf.nist.gov/4.6), including E1–E7 and the
  terminating-series note following E7;
- `coverage/dlmf-4-10-source-inventory.json`;
- `LMLF/Blueprint/Elementary/Section46.lean`;
- `doc/LMLFManual/Chapter4/Section46.lean`; and
- `coverage/sections/chapter4-46.json`.

No standalone rendered page was present in the checked-in output tree, so
anchor usability was checked against the manual source and its external-source
anchors. The previous referee findings were also checked against the revised
declarations.

## Independently computed expected formula IDs

Filtering the source inventory for numbered formulas in §4.6 gives exactly:

`4.6.E1`, `4.6.E2`, `4.6.E3`, `4.6.E4`, `4.6.E5`, `4.6.E6`, `4.6.E7`.

The manifest expected and stated sets are identical, with no omissions or
extras.

## Verdict: accept

No P0 or P1 finding remains. The seven source formulas are represented with
the correct hypotheses, branches, domains, indexing, factors, and limiting
regimes. The manual preserves the source displays and ordinary-language
constraints, and the reusable term/coefficient definitions are disclosed in
anchored Lean blocks before the formula entries.

## Formula-by-formula audit

- **4.6.E1 — clear.** `logOneAddTerm` gives the alternating terms beginning at
  `z`, and `dlmf_4_6_1` uses `‖z‖ ≤ 1` with `z ≠ -1`.
- **4.6.E2 — clear.** `logRatioTerm` starts at exponent `n+1`, so the
  `ℕ`-indexed sum is the source series beginning with `(z−1)/z`; the
  hypothesis `1/2 ≤ Re z` is retained.
- **4.6.E3 — clear.** `logSubOneTerm` has the alternating powers of `z−1`,
  and the closed-disk condition and exclusion `z ≠ 0` match the source.
- **4.6.E4 — repaired and clear.** `logSymmetricTerm` now includes the
  source factor `2`; `dlmf_4_6_4` states the right-half-plane domain
  `0 ≤ Re z` and `z ≠ 0`.
- **4.6.E5 — repaired and clear.** `logInverseOddTerm` now includes the
  source factor `2`; `dlmf_4_6_5` uses `‖z‖ ≥ 1` and excludes both `1` and
  `−1`.
- **4.6.E6 — clear specialization.** The page explicitly identifies the
  real-`a`, real-`z` specialization of the source condition `a > 0`,
  `Re z ≥ −a`, `z ≠ −a`; the displayed factor `2` and odd powers are present.
- **4.6.E7 — repaired and clear.** `generalizedBinomial` is the finite
  falling-factorial product divided by `n!`; the open-disk theorem covers
  arbitrary complex `a`, and `dlmf_4_6_7_terminating` states the unrestricted
  complex-`z` case for every nonnegative integral exponent.

## Reusable definitions and anchors

The manual provides complete anchored disclosures for all seven reusable
series-term definitions and `generalizedBinomial`. Each E1–E7 theorem and the
terminating E7 theorem has its own external-source anchor, and no declaration
is replaced by a bare name. Neither authored source contains `#check`, filler
status prose, or displaced proof work.

## Quantitative pairs and specializations

Section 4.6 supplies no distinct quantitative estimate or remainder bound, so
no quantitative analogue is required. E6 is honestly marked as a
specialization in both prose and manifest. E7’s terminating extension is
included as a consequence alongside the open-disk formula.

## Verification

- `lake build LMLF.Blueprint.Elementary.Section46`: passed; only the expected
  `sorry` warnings were emitted.
- `cd doc && lake env lean LMLFManual/Chapter4/Section46.lean`: passed.
- Manifest JSON parses successfully; expected/stated/omitted numbered-ID
  counts are `7/7/0`.

Unreviewed source candidate: none. The Hardy references and cross-references
are bibliographic/editorial material rather than additional mathematical
statements.
