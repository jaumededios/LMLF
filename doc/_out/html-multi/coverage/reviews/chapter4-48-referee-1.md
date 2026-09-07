# DLMF §4.8 referee report

## Snapshot and files reviewed

- Snapshot: `703f1ad1d96c360bbac555c43dc39f6ca64d1a7b`.
- Official source: [DLMF §4.8](https://dlmf.nist.gov/4.8), including the
  logarithm and powers subsections, branch notes, and the E14 erratum.
- Source inventory: `coverage/dlmf-4-10-source-inventory.json`.
- Lean source: `LMLF/Blueprint/Elementary/Section48.lean`.
- Documentation: `doc/LMLFManual/Chapter4/Section48.lean`.
- Manifest: `coverage/sections/chapter4-48.json`.
- No rendered standalone §4.8 page is present in the checked-in
  `doc/_out/html-multi` tree; source-level elaboration and anchors were checked.

## Independently computed expected IDs and verdict

The official page and inventory contain exactly `4.8.E1` through `4.8.E17`.
The manifest and documentation state exactly this set, with no omissions or
extras.

**Verdict: accept.** No P0 or P1 findings remain. The page gives honest
positive-real/real-variable specializations for the complex branch identities,
preserves the phase and nonzero constraints in its prose, and provides readable
anchored declarations.

## Formula-by-formula audit

- **E1–E4:** The general logarithm product/quotient laws and the principal
  phase-constrained laws are represented by real nonzero and positive-real
  specializations. The manifest labels these as specializations rather than
  exact complex identities; the page states why the positive-real phase is
  automatic.
- **E5–E7:** Integer powers, the principal phase condition, and reciprocal
  logarithm are represented with real `zpow` or positive-real arguments. The
  nonzero/integer hypotheses and principal-branch specialization are retained.
- **E8:** `log_exp_branch` records the general logarithm ambiguity with an
  existential integer `k` and the correct `2πki` term.
- **E9:** The principal logarithm of an exponential uses `−π < Im z ≤ π`.
  This is a deliberate Mathlib boundary convention: the source prints the
  inclusive interval, while the lower endpoint is on the principal branch cut.
  The page and manifest disclose this strengthening.
- **E10:** `exp_log` correctly states recovery of every nonzero complex
  argument by exponentiating the principal logarithm.
- **E11–E13:** The general and principal complex-power formulas are honestly
  specialized to positive real base and real exponent, while E13 is the source
  real-variable identity in its natural `a > 0` domain. The page and manifest
  distinguish the specializations from E13's direct real statement.
- **E14–E15:** The common-base and two-base power identities use positive real
  bases, which automatically satisfy the source branch/phase restrictions.
  E14's source nonzero condition is strengthened to positive base; E15's phase
  condition is explained as automatic.
- **E16–E17:** The real exponential addition and real power-of-an-exponential
  statements are valid slices of the complex identities, with the E17 imaginary
  part restriction automatic for real `x`.

All 17 source formulas appear with their stable `.E` links, source displays,
ordinary-language branch/domain explanations, and external-source anchors. The
Lean statements expose actual equations rather than tautological wrappers or
opaque proxies.

## Findings

### P2 — Repeated specializations could be consolidated

`log_rpow_general_branch`, `principal_log_rpow`, and `log_rpow` have identical
real-positive statements, as do the product/quotient pairs E1/E2 and E3/E4.
This is not a correctness or usability failure: each declaration is tied to a
different source display and the manifest labels the complex cases honestly.
If the API is later consolidated, retain source-specific aliases only when
cross-reference value outweighs duplication.

## Correctly handled specializations and quantitative pairs

- Complex general/principal logarithm identities E1–E7 and E11–E12 are clearly
  marked as real or positive-real specializations.
- E9's strict lower boundary is explicitly documented as a Mathlib convention,
  not silently presented as the source's inclusive interval.
- E14 and E15 use positive real bases to discharge the source branch conditions.
- E16 and E17 are explicitly described as real slices of complex identities.
- No second quantitative declaration is warranted: §4.8 consists solely of
  identities and branch conditions.

## Verification

- `lake env lean LMLF/Blueprint/Elementary/Section48.lean`: passed, with 17
  permitted `sorry` warnings.
- From `doc/`, `lake env lean LMLFManual/Chapter4/Section48.lean`: passed.
- No `#check`, proof work displacing statement coverage, or prohibited filler
  prose was found.
- The source page has no additional mathematical prose candidates beyond the
  branch interpretation of E1 and the E17 integer-exponent note; the page
  records both branch interpretation and the real specialization.
