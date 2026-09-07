# Final referee report: DLMF §4.2 Definitions

## Snapshot and files reviewed

- Snapshot: `7d39f17cef5d56ab37efd6ab9e607fff60f9d7a1` (working-tree files were reviewed as supplied).
- Official source: [DLMF §4.2](https://dlmf.nist.gov/4.2), including E1–E37, branch-cut prose, numerical displays, and Figure 4.2.1.
- Source inventory: `coverage/dlmf-4-10-source-inventory.json`.
- Lean source: `LMLF/Blueprint/Elementary/Section42.lean`.
- Documentation: `doc/LMLFManual/Chapter4/Section42.lean`.
- Manifest: `coverage/sections/chapter4-42.json`.
- Prior reports: `coverage/reviews/chapter4-42-referee-1.md` through `coverage/reviews/chapter4-42-referee-5.md`.
- No rendered §4.2 page is present in `doc/_out/html-multi`; source-level anchor checks and standalone elaboration were used.

## Independently computed expected formula IDs

The official source inventory contains exactly `4.2.E1` through `4.2.E37`;
E31 is one two-component display. The manifest expected/stated sets both contain
all 37 IDs, with no omissions or extras. The Lean and manual sources contain the
38 corresponding anchors (E31a/E31b counted separately).

**Verdict: revise.** The third revision fixes E17's sign/value, exposes a named
`generalLogBranch`, carries the requested E8–E16 nonzero/base/denominator
hypotheses, and restores the complete E5/E26/E36/E37 declarations and analytic
prose. Nevertheless, the manual does not build, E35 is false at the totalized
zero input, and E11/E15/E36 still have material coverage or manifest mismatches.

## Findings

### P0 — E35 is false because `z ≠ 0` is missing

- **DLMF ID:** `4.2.E35`.
- **Declaration:** `LMLF/Blueprint/Elementary/Section42.lean:174-176`, with the
  manual anchor at `doc/LMLFManual/Chapter4/Section42.lean:185-187` and the
  manifest entry at `coverage/sections/chapter4-42.json:56`.
- **Evidence:** The theorem assumes only `ha : a ≠ 0` and `hw : w ≠ 0`, but
  `generalPowerValue` and `generalLogValue` are defined using totalized
  `Complex.log`. Take `z = 0`, `w = 1`, `a = 1`: the left side holds with branch
  index `k = 0` because `Complex.log 0 = 0` in Mathlib and hence
  `generalPowerValue 0 1 0 = 1`. The right side would require
  `0 = exp(generalLogValue 1 k) = exp(2 k π i)` for some integer `k`, which is
  impossible. DLMF's general-power inversion presupposes the nonzero power
  arguments.
- **Repair:** Add `(hz : z ≠ 0)` to E35 (and retain `ha` and `hw`), or define a
  non-totalized general-power relation whose domain excludes zero. Keep the
  `generalLogValue` branch relation explicit.

### P1 — The manual does not elaborate: E1 is stale and `logBase` has no resolved anchor

- **Affected IDs/declarations:** E1 `dlmf_4_2_1` and the shared `logBase`
  definition.
- **Exact evidence:** In `LMLF/Blueprint/Elementary/Section42.lean:26`, E1 is
  `generalLogBranch z (Complex.log z)`. The manual at
  `doc/LMLFManual/Chapter4/Section42.lean:27-29` still discloses the older
  existential expression
  `∃ k, generalLogValue z k = Complex.log z + 2 * k * Real.pi * Complex.I`.
  Standalone `lake env lean LMLFManual/Chapter4/Section42.lean` reports this
  as a `Mismatched code` error. The same build reports `Anchor not found` for
  the manual's `logBase` anchor at line 71, despite the definition at
  `LMLF/Blueprint/Elementary/Section42.lean:18`.
- **Repair:** Replace the E1 code block with the exact current
  `generalLogBranch` declaration, and make the `logBase` definition externally
  discoverable (for example by registering a source anchor or using the exact
  supported declaration disclosure). The corrected `generalLogBranch` is a
  substantive branch relation and is honestly marked a specialization of the
  path-integral source definition; preserve that explanation.

### P1 — E11 is a coarse inequality but remains marked `exact`

- **DLMF ID:** `4.2.E11`.
- **Declaration:** `LMLF/Blueprint/Elementary/Section42.lean:72-74`; manifest
  entry `coverage/sections/chapter4-42.json:32`.
- **Evidence:** DLMF E11 displays the decimal expansion
  `e = 2.71828 18284 59045 23536…`. The declaration instead proves only
  `|Real.exp 1 - 2.71828| < 0.00001`. That is a valid coarse numerical
  consequence, but it is not the displayed decimal expansion, unlike the
  manifest's `relation: "exact"` claim.
- **Repair:** Mark E11 `specialization` and say that it retains only a coarse
  enclosure, or state the displayed finite prefix with a rigorous remainder
  bound/interval.

### P1 — E15 omits the second equality in the numbered display

- **DLMF ID:** `4.2.E15`.
- **Declaration:** `LMLF/Blueprint/Elementary/Section42.lean:88-90`; manual
  anchor `doc/LMLFManual/Chapter4/Section42.lean:101-103`; manifest entry
  `coverage/sections/chapter4-42.json:36`.
- **Evidence:** DLMF gives
  `log₁₀ z = ln z / ln 10 = (log₁₀ e) ln z`. The Lean declaration states only
  `logBase 10 z = Complex.log z / Real.log 10`; it omits the displayed
  `(log₁₀ e) ln z` equality while the manifest calls the declaration exact.
- **Repair:** Add the second equality with the appropriate nonzero hypotheses,
  or mark the current quotient-only statement `specialization` and state in
  the prose that it deliberately retains only the first equality.

### P1 — E36 is a principal-log specialization but is marked `exact`

- **DLMF ID:** `4.2.E36`.
- **Declaration:** `LMLF/Blueprint/Elementary/Section42.lean:178-183`; manual
  anchor `doc/LMLFManual/Chapter4/Section42.lean:188-193`; manifest entry
  `coverage/sections/chapter4-42.json:57`.
- **Evidence:** The source condition is on the branch `Ln w` used to construct
  the general power. The current theorem uses `Complex.log w`, i.e. one chosen
  principal branch, and proves an equivalence with the unfolded
  `closedPrincipalPhase` predicate. This is a readable named condition and no
  longer the prior copied-assumption placeholder, but it is a principal-branch
  specialization rather than an exact formalization of the source's arbitrary
  branch condition.
- **Repair:** Mark E36 `specialization` and note explicitly that `Complex.log w`
  is the selected principal branch; alternatively quantify a `generalLogValue`
  branch in the condition.

### P2 — E27 records only one part of the multi-equality display

- **DLMF ID:** `4.2.E27`.
- **Declaration:** `LMLF/Blueprint/Elementary/Section42.lean:138-141`; manifest
  entry `coverage/sections/chapter4-42.json:48`.
- **Evidence:** DLMF displays both the finite integer product and
  `1/z^{-a}`. The current natural-exponent, `k = 0` theorem captures the first
  power identity and is honestly marked a specialization, but the manifest note
  only says “Integer exponent” and the manual does not disclose that the inverse
  identity is omitted.
- **Repair:** Either include the reciprocal identity or identify the selected
  finite-power component and its `k = 0`, `z ≠ 0` specialization in the prose
  and manifest note.

## Correctly handled specializations and quantitative pairs

- E1 now has a substantive `generalLogBranch` relation with `z ≠ 0`; only its
  stale manual disclosure prevents the page build.
- E2–E7 expose the open/closed domains, general branch index, and tagged upper
  and lower cut values; E37 uses the corrected imaginary-axis boundary test.
- E8–E10 carry nonzero/nonunit base hypotheses and nonzero logarithm denominators;
  E14–E16 carry the relevant nonzero argument and decimal-log hypotheses.
- E17 now has the corrected positive quantity `1 / Real.log 10`; E18 has the
  corresponding coarse enclosure for `Real.log 10`.
- E19 is a genuine infinite factorial `HasSum`; E23 uses an existential phase
  representative; E25 uses the general integer-log branch relation.
- E26 quantifies every integer logarithm branch. E28–E31 explicitly state the
  principal off-cut domain and wrap principal phases; E31 has both source
  components. E32–E34 retain the principal/general exponential-power and
  factorial-series identities.
- E36 has complete source/manual anchors and a readable named closed-phase
  predicate, subject to the branch-specialization metadata issue above.
- No distinct quantitative analogue is required by §4.2; all entries use
  `quantitative_analogue: "not_applicable"`.

## Verification

- `lake build LMLF.Blueprint.Elementary.Section42`: passed on retry, with the
  permitted `sorry` and long-line warnings.
- `lake env lean LMLF/Blueprint/Elementary/Section42.lean`: passed.
- From `doc/`, `lake env lean LMLFManual/Chapter4/Section42.lean`: failed with
  the E1 mismatched-code error and unresolved `logBase` anchor described above.
- Expected/stated numbered IDs: 37/37; omitted IDs: 0.
- E5, E26, E36, and E37 disclosures contain complete declarations; the build
  failures are specifically the stale E1 disclosure and `logBase` registration.
- No `#check`, filler status prose, or proof-displacing work was found.
- The branch-cut figure is linked, and the inventory's substantive §4.2 prose
  candidates are represented; no table, caption, or numbered source candidate is
  unreviewed.
