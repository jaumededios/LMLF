# DLMF §4.2 final referee report

## Snapshot and files reviewed

- Snapshot: `7d39f17cef5d56ab37efd6ab9e607fff60f9d7a1` (current working-tree
  versions of the assigned files were reviewed).
- Official source: [DLMF §4.2](https://dlmf.nist.gov/4.2), including all E1–E37
  displays, the open/closed branch conventions, cut-side prose, numerical
  displays, and Figure 4.2.1.
- Source inventory: `coverage/dlmf-4-10-source-inventory.json`.
- Lean source: `LMLF/Blueprint/Elementary/Section42.lean`.
- Documentation: `doc/LMLFManual/Chapter4/Section42.lean`.
- Manifest: `coverage/sections/chapter4-42.json`.
- Prior reports: `coverage/reviews/chapter4-42-referee-1.md` through
  `coverage/reviews/chapter4-42-referee-7.md`.
- No rendered §4.2 page is present in `doc/_out/html-multi`; source-level
  anchors and standalone elaboration were checked directly.

## Independently computed expected formula IDs and anchor count

The official source inventory contains exactly `4.2.E1` through `4.2.E37`,
with E31 one two-component display. The manifest expected and stated arrays
agree exactly and have no omitted IDs. The Lean and documentation sources each
contain exactly 39 anchors: `logBase`, E1–E30, E31a, E31b, and E32–E37; the
source/document anchor sets are identical.

**Verdict: revise.** The fourth revision fixes E35's `z ≠ 0`, E15's second
equality, E27's reciprocal component, E11/E36's manifest specialization
labels, all 39 anchors, the build, and the principal/open-closed prose. But
E36 is still a false universal theorem, and two domain/source-fidelity gaps
remain.

## Findings

### P0 — E36 asserts a false phase condition for arbitrary `a,w`

- **DLMF ID:** `4.2.E36`.
- **Exact declaration:**
  `LMLF/Blueprint/Elementary/Section42.lean:178-182`, disclosed at
  `doc/LMLFManual/Chapter4/Section42.lean:205-209`; manifest entry
  `coverage/sections/chapter4-42.json` for E36.
- **Evidence:** The source display is a condition under which the principal
  value is also valid for a selected general logarithm branch. The current
  theorem takes only `ha : a ≠ 0` and `hw : w ≠ 0` and concludes
  `-π ≤ Im((1/a) Complex.log w) ≤ π` for every such pair. Take
  `a = 1/2` and `w = -1`: `Complex.log (-1) = π i`, so the imaginary part is
  `2π`, violating the upper bound. Calling this a `specialization` in the
  manifest and prose does not make the declaration true.
- **Repair:** Make E36 a predicate/definition for the principal-phase
  condition, or add the condition as an explicit hypothesis to a substantive
  principal-power inversion consequence. If a selected principal branch is
  intended, retain `a ≠ 0`, `w ≠ 0`, and state clearly that the condition is
  assumed rather than proved for all inputs.

### P1 — E1 is only an algebraic branch-membership specialization, while the page presents the path-integral definition

- **DLMF ID:** `4.2.E1`.
- **Exact declaration:** `generalLogBranch` and
  `dlmf_4_2_1` at `LMLF/Blueprint/Elementary/Section42.lean:19-28`, with the
  manual disclosure at `doc/LMLFManual/Chapter4/Section42.lean:24-29`.
- **Evidence:** DLMF E1 defines `Ln z` by the path integral
  `∫₁ᶻ dt/t` along paths avoiding the origin and explains its multivalued
  continuation. The Lean relation `generalLogBranch z w` is a useful,
  non-reflexive branch-value relation, and the manifest correctly calls E1 a
  `specialization`, but `dlmf_4_2_1` only witnesses the principal value with
  the trivial branch index `k = 0`; it contains no path, integral, winding, or
  continuation data. The manual currently says “The general logarithm is the
  path integral” immediately before this narrower declaration without stating
  that the path-integral construction is not formalized.
- **Repair:** Either formalize a path/continuation relation, or explicitly
  label the displayed Lean statement as an algebraic branch-membership
  specialization and say that the DLMF path-integral definition is prose-only.
  Preserve the existing `z ≠ 0` hypothesis and integer branch vocabulary.

### P1 — E6 still admits the totalized branch point

- **DLMF ID:** `4.2.E6`.
- **Exact declaration:** `dlmf_4_2_6` at
  `LMLF/Blueprint/Elementary/Section42.lean:57-60`; manual anchor at
  `doc/LMLFManual/Chapter4/Section42.lean:55-57`.
- **Evidence:** E6 follows E1's `z ≠ 0` definition of the general logarithm.
  The current declaration has no `hz : z ≠ 0`, and `generalLogValue z k` is
  defined using totalized `Complex.log`, including `Complex.log 0 = 0`.
  Thus the public E6 API silently assigns branch values at the branch point
  even though the manual introduction says the Lean statements retain the
  DLMF nonzero/domain restrictions.
- **Repair:** Add `hz : z ≠ 0` to E6 (and retain it in any reusable branch-value
  definition or relation), or explicitly document a separate totalized Lean
  extension rather than presenting it as the DLMF general logarithm.

### P1 — A substantive source prose assertion is omitted

- **DLMF location:** prose immediately after E3 in §4.2(i), “The only zero of
  `ln z` is at `z=1`.”
- **Exact documentation:** `doc/LMLFManual/Chapter4/Section42.lean:17-20,31-38`
  contains the branch domains and E3 formula but never records this assertion.
- **Evidence and repair:** This is a mathematical source claim, not merely
  editorial metadata. Add it to the logarithm prose and, if desired, provide
  a separate Lean declaration; do not imply that the current E3 statement
  supplies it. The existing prose correctly covers the branch point, Figure
  4.2.1 link, upper/lower cut values, exponential zero-free property,
  principal-power discontinuity, and the open-versus-closed E37 convention.

## Correctly handled repairs, specializations, and quantitative pairs

- E2/E3 use the open slit domain `principalLogDomain`; E5 uses the closed
  nonzero domain plus the closed phase range; E4/E7 retain explicit signed
  upper/lower cut values. The open/closed distinction and E37 boundary rule
  are disclosed in ordinary-language prose.
- E8–E10 carry valid-base and nonzero-denominator hypotheses; E14–E16 carry
  `z ≠ 0` and the decimal-log denominator condition, avoiding silent use of
  totalized logarithms at `z=0`. E15 now contains both displayed equalities.
- E11, E17, and E18 are coarse numerical enclosures and are honestly marked
  `specialization`; E17 now uses `1 / Real.log 10` with the correct sign.
- E19 is a genuine infinite factorial `HasSum`; E20–E25 preserve period,
  reciprocal, modulus, existential phase, Cartesian decomposition, and the
  general-log inverse relation.
- E26 quantifies every integer logarithm branch; E27 includes both the finite
  integer-power and reciprocal components with `z ≠ 0`; E28–E31 use the
  principal off-cut domain and wrapped phase, and E31 has both components.
- E32–E35 maintain the principal/general distinction; E35 now includes
  `z ≠ 0`, `a ≠ 0`, and `w ≠ 0`. E37 has the corrected closed-boundary
  square-root condition.
- No distinct quantitative analogue is required by §4.2; all manifest entries
  correctly use `quantitative_analogue: "not_applicable"`.

## Verification

- `lake env lean LMLF/Blueprint/Elementary/Section42.lean`: passed with the
  permitted `sorry` warnings (and style long-line warnings).
- `lake build LMLF.Blueprint.Elementary.Section42`: passed.
- From `doc/`, `lake env lean LMLFManual/Chapter4/Section42.lean`: passed.
- Independent scans found 37/37 expected and stated numbered IDs, 39/39
  matching source/document anchors, and 37 manifest declaration records (E31
  names two declarations). E1–E37 all have DLMF links in the manual, with
  grouped source-link lists for each range.
- Neither authored source contains `#check`, filler status prose, or proof
  work displacing statement coverage.
- The inventory's substantive branch, numerical, exponential, power, and
  figure-caption content is represented except for the explicitly identified
  “only zero of `ln`” prose assertion; annotation notes and cross-reference
  metadata require no Lean declaration.
