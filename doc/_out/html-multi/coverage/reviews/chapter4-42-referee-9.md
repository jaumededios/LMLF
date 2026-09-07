# Final referee B: DLMF §4.2 Definitions

## Snapshot and files reviewed

Snapshot: `7d39f17cef5d56ab37efd6ab9e607fff60f9d7a1`; the three assigned files
were reviewed in their current working-tree state.  I independently checked the
official [DLMF §4.2](https://dlmf.nist.gov/4.2), including the numbered
displays, branch-cut prose, numerical displays, Figure 4.2.1, and the closed
square-root convention; the repository source inventory; and prior reports
`coverage/reviews/chapter4-42-referee-1.md` through
`coverage/reviews/chapter4-42-referee-7.md`.

Files reviewed:

- `LMLF/Blueprint/Elementary/Section42.lean`
- `doc/LMLFManual/Chapter4/Section42.lean`
- `coverage/sections/chapter4-42.json`

## Independent formula inventory and verdict

The official numbered set is exactly `4.2.E1` through `4.2.E37` (E31 is one
two-component display).  The source, documentation, and manifest each cover
all 37 IDs, with no omitted or extra IDs.  Every ID also has a direct
`https://dlmf.nist.gov/4.2.E*` URL somewhere in the documentation's source-link
sentences, although the entries are grouped rather than pairing each URL
directly with its anchor.

**Verdict: revise.**  The page is buildable and substantially improved, but E36
is a false universal theorem and several branch/cut declarations still do not
faithfully state the numbered source formulas or their domains.

## Findings

### P0 — E36 asserts a phase condition that is not universally true

- **DLMF ID:** `4.2.E36`.
- **Declaration:** `LMLF/Blueprint/Elementary/Section42.lean:188-190`,
  documentation anchor at `doc/LMLFManual/Chapter4/Section42.lean:197-201`,
  manifest entry at `coverage/sections/chapter4-42.json:57`.
- **Evidence:** DLMF E36 states the condition
  `-π ≤ Im((1/a) Ln w) ≤ π` for the branch of `Ln w` under which the
  principal power is being considered.  The Lean declaration instead claims
  that condition for every `a ≠ 0` and `w ≠ 0`, using `Complex.log w`.  Take
  `a = 1/2` and `w = -1`: Mathlib's principal logarithm has imaginary part
  `π`, so `Im((1/a) * Complex.log w) = 2π`, violating the upper bound.  The
  theorem is therefore false, not merely a principal-branch specialization.
- **Repair:** make the displayed inequality a named predicate/assumption (or
  state an implication/equivalence that uses it), and explicitly quantify the
  selected `generalLogValue w k` if the general branch is intended.  A theorem
  that concludes the inequality needs additional hypotheses strong enough to
  establish it; `ha` and `hw` alone do not.  Keep the manifest's
  `specialization` label only after the proposition is no longer universal and
  the prose explains the selected branch.

### P1 — E1 and E2 replace the numbered path-integral definitions with branch consequences

- **DLMF IDs:** `4.2.E1` and `4.2.E2`.
- **Declarations:** `dlmf_4_2_1` at source lines 27-29 and `dlmf_4_2_2` at
  lines 30-33; documentation anchors at lines 24-40.
- **Evidence:** E1 defines `Ln z` by the integral along paths avoiding the
  origin and E2 defines the principal branch by the corresponding path
  integral.  The current E1 theorem only proves that `Complex.log z` is one
  witness in the already-defined existential `generalLogBranch`; E2 only
  proves `exp (Complex.log z) = z` on an open slit domain.  These are useful
  branch-value/inverse consequences, but neither declaration contains a path,
  integral, continuation, or winding construction.  The manual says “The
  general logarithm is the path integral” immediately above a Lean anchor that
  does not formalize that assertion, and gives no explicit limitation note.
- **Repair:** either expose a path-integral/continuation relation, or state in
  the E1 and E2 prose that the anchors are narrow branch/inverse
  specializations of the DLMF definitions.  Preserve the current honest
  `specialization` manifest relations and do not present the anchors as the
  path-integral definitions themselves.

### P1 — E4 is still the wrong numbered formula and is definitionally vacuous as a cut convention

- **DLMF ID:** `4.2.E4` (with the related cut-value issue in E7).
- **Declarations:** `dlmf_4_2_4` at source lines 39-42 and
  `dlmf_4_2_7` at lines 53-56; `closedCutPoint` is defined at source line 16
  but is never used.  The corresponding documentation is lines 33-58.
- **Evidence:** DLMF E4 records the closed-cut convention `z = x` for
  `x < 0`, after which E5 gives the closed phase formula and E7 gives the two
  side values.  The current E4 instead proves
  `upperCutLog x - lowerCutLog x = 2πi`; this identity follows by unfolding
  the two definitions for every real `x` (so `hx` has no semantic role), and
  it never states `z = x`, a cut embedding, or a boundary-side selection.  E7
  similarly exposes explicit helper values rather than relating them to the
  closed principal logarithm or a limiting side.  Thus the manual's source
  link for E4 points at a branch-jump consequence, while the actual numbered
  convention remains absent.
- **Repair:** add a direct tagged/side-aware cut-point statement using
  `closedCutPoint` (or clearly mark the jump identity as an E7-derived
  specialization and add a separate E4 convention declaration).  Keep the
  `x < 0` domain meaningful in the declaration rather than proving an
  identity that is true outside the cut as well.

### P1 — The closed phase predicate does not match the documented half-open convention, and E6 totalizes the forbidden origin

- **DLMF IDs:** `4.2.E5` and `4.2.E6`.
- **Declarations:** `closedPrincipalPhase` at source line 15,
  `dlmf_4_2_5` at lines 44-48, and `dlmf_4_2_6` at lines 49-52; manifest
  entries are `coverage/sections/chapter4-42.json:26-27`.
- **Evidence:** The manual introduction correctly says the closed convention
  is `-π < ph z ≤ π`, but `closedPrincipalPhase` is the closed interval
  `-π ≤ u.im ∧ u.im ≤ π`, admitting the excluded lower endpoint.  E5 then
  assumes this mismatched predicate.  Separately, DLMF E6 is a general
  logarithm value only for `z ≠ 0`, while `dlmf_4_2_6 (z) (k)` has no nonzero
  hypothesis and relies on totalized `Complex.log 0`.  Its equality is true by
  unfolding the helper definition at zero, but that is precisely a value where
  the source logarithm is undefined; the manifest currently calls E6 exact.
- **Repair:** use the half-open closed-branch predicate (or explicitly label a
  wider Mathlib convention), add `z ≠ 0` to E6 and its documentation, and keep
  the totalized-at-zero behavior as an explicit Lean limitation rather than a
  DLMF value.

### P2 — Grouped entries weaken source-to-anchor pairing

The documentation has one `dlmfEntry` URL for each range E2–E7, E8–E18,
E19–E25, and E26–E37, then lists all individual URLs in a prose “Source
links” sentence.  The direct URLs are present for all 37 IDs, so this is not a
coverage omission, but placing each E URL adjacent to its declaration (or
splitting the grouped entries) would make the per-formula provenance
unambiguous to readers.

## Correctly handled material

- The numbered-ID inventory is exact: source, documentation, and manifest all
  contain E1–E37, and E31 is represented by both `dlmf_4_2_31a` and
  `dlmf_4_2_31b`.
- `generalLogBranch` and `generalLogValue` are readable explicit relations,
  rather than the earlier collapse of all branches to one principal value.
  E23 and E25 use existential branch representatives; E26 and E33 expose
  indexed general values; E35 has the needed nonzero `z`, `a`, and `w`
  hypotheses and a genuine inverse relation.
- E3, E5, E7, E9-E10, E12-E16, E20-E22, E24, E27, E29-E31, E32, E34, and
  E37 have readable mathematical statements with their current
  specializations or branch restrictions visible in the declarations.  In
  particular, E15 contains both displayed equalities, E27 contains both the
  finite-power and reciprocal components, and E37 resolves the imaginary-axis
  boundary for Mathlib's principal square root.
- E11, E17, and E18 are correctly identified as coarse numerical
  specializations (not full decimal expansions), and the corrected E17 quantity
  is `1 / Real.log 10`.
- No distinct quantitative analogue pair is required by §4.2; all manifest
  entries correctly use `quantitative_analogue: "not_applicable"`.
- Neither authored source file contains `#check`, filler/status prose, or a
  proof-displacing statement.  The existing branch-point, exponential no-zero,
  power analyticity/discontinuity, and open-versus-closed prose is present;
  the remaining issue is alignment of the declarations with that prose.

## Verification and source candidates

- `lake env lean LMLF/Blueprint/Elementary/Section42.lean`: passed; all
  37 theorem bodies use the permitted `sorry`s and only style/`sorry` warnings
  remain.
- `lake build LMLF.Blueprint.Elementary.Section42`: passed.
- From `doc/`, `lake env lean LMLFManual/Chapter4/Section42.lean`: passed.
- From `doc/`, `lake build LMLFManual.Chapter4.Section42`: passed.
- No rendered §4.2 page was present in `doc/_out/html-multi`; source-level
  anchors and both standalone/build elaborations were therefore used.
- The inventory's numbered formulas, Figure 4.2.1 caption/branch-cut content,
  numerical displays, and surrounding §4.2 prose candidates were checked;
  there is no unreviewed numbered source candidate.  The report is `revise`
  solely because of the P0 E36 statement and the P1 source-fidelity/domain
  findings above.
