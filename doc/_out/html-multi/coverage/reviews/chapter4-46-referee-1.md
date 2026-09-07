# DLMF §4.6 referee review

## Snapshot and files reviewed

- Snapshot: `703f1ad1d96c360bbac555c43dc39f6ca64d1a7b` (the assigned §4.6
  author files are workspace additions in this worktree).
- Official source: [DLMF §4.6](https://dlmf.nist.gov/4.6), including
  [4.6.E1](https://dlmf.nist.gov/4.6.E1) through
  [4.6.E7](https://dlmf.nist.gov/4.6.E7).
- Source inventory: `coverage/dlmf-4-10-source-inventory.json`.
- Lean author file: `LMLF/Blueprint/Elementary/Section46.lean`.
- Documentation author file: `doc/LMLFManual/Chapter4/Section46.lean`.
- Manifest: `coverage/sections/chapter4-46.json`.
- Rendered page: no standalone §4.6 page is present in the checked-in
  `doc/_out/html-multi` tree; the Chapter 4 aggregator does not import the
  workspace-added Section46 page, so visual anchor checks were unavailable.

## Independently computed expected formula IDs

Filtering the source inventory for `kind = numbered_formula` and
`location.section = "4.6"` gives exactly:

`4.6.E1`, `4.6.E2`, `4.6.E3`, `4.6.E4`, `4.6.E5`, `4.6.E6`, and `4.6.E7`.

The manifest and documentation state all seven IDs with no omissions or extras.

## Verdict: revise

The page has the correct seven source links, domains, index starts, and series
convergence mode in most declarations, and the §4.6.6 real-variable
specialization is labeled honestly.  However, E4 and E5 omit the factor 2 in
their Lean series terms, so their `HasSum` conclusions are false as statements
of the displayed DLMF formulas.  E7 also documents the source's unrestricted
terminating-polynomial case without formalizing it.  These are material source
fidelity issues.

## Findings

### P0 — `4.6.E4`: the Lean symmetric logarithm series is missing the factor 2

- Files/declarations: `LMLF/Blueprint/Elementary/Section46.lean`,
  `logSymmetricTerm` and `dlmf_4_6_4`; the corresponding page is the
  `4.6.4` entry in `doc/LMLFManual/Chapter4/Section46.lean`.
- Evidence: [DLMF 4.6.E4](https://dlmf.nist.gov/4.6.E4) states
  `ln z = 2 * (w + w^3/3 + w^5/5 + ...)`, where
  `w = (z-1)/(z+1)`, for `Re z >= 0` and `z != 0`.
- Problem: `logSymmetricTerm` is only `w^(2*n+1)/(2*n+1)`, but
  `dlmf_4_6_4` asserts `HasSum (logSymmetricTerm z) (Complex.log z)`.
  The Lean conclusion therefore gives the inner series the value of the full
  logarithm, while the displayed source formula gives twice that inner series
  the value of the logarithm.
- Repair: either include the factor `2` in `logSymmetricTerm`, or state the
  current term's sum as `Complex.log z / 2`; retain the source-level `2` in the
  documentation and update the manifest declaration notes consistently.

### P0 — `4.6.E5`: the Lean inverse odd-power series is missing the factor 2

- Files/declarations: `LMLF/Blueprint/Elementary/Section46.lean`,
  `logInverseOddTerm` and `dlmf_4_6_5`; the corresponding page is the
  `4.6.5` entry in `doc/LMLFManual/Chapter4/Section46.lean`.
- Evidence: [DLMF 4.6.E5](https://dlmf.nist.gov/4.6.E5) states
  `ln((z+1)/(z-1)) = 2 * (1/z + 1/(3z^3) + 1/(5z^5) + ...)`, for
  `|z| >= 1` and `z != +/-1`.
- Problem: `logInverseOddTerm` is only `1/((2*n+1) * z^(2*n+1))`, but
  `dlmf_4_6_5` asserts that its sum is the full logarithm.  As in E4, the
  Lean statement is off by a factor of two even though the prose display is
  correct.
- Repair: multiply the reusable term by `2`, or change the theorem target to
  `Complex.log ((z + 1) / (z - 1)) / 2` and explain that it is the inner-series
  form.  The first option keeps the declaration closest to the source display.

### P1 — `4.6.E7`: the source's terminating-polynomial domain extension is only prose

- Files/declarations: `LMLF/Blueprint/Elementary/Section46.lean`,
  `dlmf_4_6_7`; the `4.6.7` prose in
  `doc/LMLFManual/Chapter4/Section46.lean` says that when `a` is a
  nonnegative integer the series terminates and is valid for every `z`.
- Evidence: the post-formula source note on
  [DLMF §4.6](https://dlmf.nist.gov/4.6) says E7 is valid for `|z| < 1`,
  and that for `a = 0,1,2,...` the series terminates and `z` is unrestricted.
- Problem: `dlmf_4_6_7` only states the open-disk theorem
  `(hz : ‖z‖ < 1)`, while the page presents the unrestricted terminating case
  as part of the source coverage.  The manifest calls E7 `exact`, although the
  Lean statement is at best the open-disk specialization of the full source
  discussion.
- Repair: add a distinct natural-`a` theorem with arbitrary complex `z` and
  the same finite-product coefficient (or explicitly narrow the prose and mark
  the existing entry as a specialization, recording the omitted terminating
  extension in `known_gaps`).

### P2 — Reusable series-term definitions are not disclosed on the manual page

- Files/declarations: `logOneAddTerm`, `logRatioTerm`, `logSubOneTerm`,
  `logSymmetricTerm`, `logInverseOddTerm`, `logShiftedTerm`, and
  `generalizedBinomial` in the Lean file.  The page anchors only the seven
  theorem statements, which refer to these definitions by name.
- Evidence: the author contract requires an open Lean disclosure with the
  complete declaration for each displayed mathematical result and says not to
  replace a declaration by its name.  No standalone §4.6 rendering was
  available to verify whether the term declarations are discoverable through
  the theorem anchors.
- Repair: add unique external-source anchors for the reusable term definitions
  in the relevant Lean disclosures (or inline their complete definitions before
  each theorem), so a reader can inspect the exact coefficient, exponent, and
  factor rather than relying on an unexpanded name.  This also makes the E4/E5
  factor-of-two correction auditable.

## Correctly handled specializations and quantitative pairs

- E1, E2, and E3 use the source closed-disk/half-plane hypotheses and the
  natural-number index `n` with the correct `n+1` term alignment.  `HasSum`
  records ordinary convergence, including the conditional boundary cases.
- E4 uses the correct right-half-plane domain `Re z >= 0`, `z != 0`, and E5
  uses the correct exterior domain `|z| >= 1`, `z != +/-1`; only their missing
  factors of two block acceptance.
- E6 is explicitly documented as a real `a,z` specialization of the source's
  `a > 0`, `Re z >= -a`, `z != -a` statement.  Its outer factor 2 is present.
- E7 uses Mathlib's `Complex.cpow`, matching the principal complex-power
  convention, and the finite-product coefficient has the correct falling
  factorial over `n!`.
- No distinct quantitative analogue is supplied by DLMF §4.6, so the absence
  of a second quantitative declaration is appropriate.

## Build and source-candidate checks

- `lake env lean LMLF/Blueprint/Elementary/Section46.lean`: succeeds with the
  seven expected `sorry` warnings.
- From `doc/`, `lake env lean LMLFManual/Chapter4/Section46.lean`: succeeds.
- The manifest's independently expected and stated numbered-ID sets are equal,
  with no omissions.
- Neither assigned source file contains `#check`, filler status prose, or proof
  work displacing statement coverage.
- The E7 terminating-polynomial note is the substantive non-formula source
  candidate not fully represented in Lean; the source's Hardy references are
  bibliographic rather than additional mathematical claims.
