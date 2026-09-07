# Post-second-revision referee: DLMF §4.2 Definitions

Snapshot baseline: `703f1ad1d96c360bbac555c43dc39f6ca64d1a7` (`site/verso-dlmf-overlay`), with the latest working-tree revision reviewed after `coverage/reviews/chapter4-42-referee-4.md`.

Files reviewed:

- `LMLF/Blueprint/Elementary/Section42.lean`
- `doc/LMLFManual/Chapter4/Section42.lean`
- `coverage/sections/chapter4-42.json`
- prior reports `coverage/reviews/chapter4-42-referee-1.md` through `coverage/reviews/chapter4-42-referee-4.md`
- official [DLMF §4.2](https://dlmf.nist.gov/4.2), including every E1–E37 display, branch prose, numerical display, and Figure 4.2.1.

## Independently computed expected formula IDs

The official set is exactly:

`[4.2.E1, 4.2.E2, 4.2.E3, 4.2.E4, 4.2.E5, 4.2.E6, 4.2.E7, 4.2.E8, 4.2.E9, 4.2.E10, 4.2.E11, 4.2.E12, 4.2.E13, 4.2.E14, 4.2.E15, 4.2.E16, 4.2.E17, 4.2.E18, 4.2.E19, 4.2.E20, 4.2.E21, 4.2.E22, 4.2.E23, 4.2.E24, 4.2.E25, 4.2.E26, 4.2.E27, 4.2.E28, 4.2.E29, 4.2.E30, 4.2.E31, 4.2.E32, 4.2.E33, 4.2.E34, 4.2.E35, 4.2.E36, 4.2.E37]` (E31 has two displayed components). The revised manifest expected/stated sets agree and omit nothing.

## Verdict

**revise**

E37’s negative-imaginary-axis condition, E2’s inverse statement, E26’s arbitrary branch index, and E36’s named phase predicate are improvements. The current page still has a false numerical proposition, stale metadata/domain claims, a remaining tautological source proxy, and a failing manual build.

## Findings

### P0 — E17 remains numerically false

- DLMF ID: `4.2.E17`.
- Exact declaration: `LMLF/Blueprint/Elementary/Section42.lean:85-92`; manual anchor: `doc/LMLFManual/Chapter4/Section42.lean:101-103`; manifest: `coverage/sections/chapter4-42.json:38`.
- Evidence: DLMF gives `log₁₀ e = 1/ln 10 = 0.434294…`. The declaration still asserts `|Real.log 10⁻¹ - 0.43429| < 0.00001`; `Real.log (10⁻¹) = -Real.log 10 ≈ -2.302585`, so the inequality is false.
- Repair: replace `Real.log 10⁻¹` by `1 / Real.log 10` (or an explicitly rigorous interval around the displayed constant) and mark the coarse enclosure as a specialization.

### P0 — The authored manual does not elaborate after the revision

- Affected declarations: E5, E26, E36, E37, and the newly exposed `logBase` definition.
- Exact file/lines: `doc/LMLFManual/Chapter4/Section42.lean:47-49,68-72,146-148,179-184`.
- Evidence: `lake env lean LMLFManual/Chapter4/Section42.lean` fails with Verso “Mismatched code” for the truncated multiline E5/E26/E36/E37 anchors; it also reports `Anchor not found` for `logBase`. The snippets stop after a theorem colon and omit the conclusion/body in the source manual, so the external anchors cannot display the complete declarations. This violates the build and complete-anchor contract even though the Lean module itself compiles.
- Repair: restore each full declaration text exactly as Lean parses it, including the conclusion and `:= by sorry`, and ensure the `logBase` definition anchor is registered before its theorem uses.

### P1 — E1 is still a tautological expansion, not the displayed logarithm definition

- DLMF ID: `4.2.E1`.
- Exact declaration: `LMLF/Blueprint/Elementary/Section42.lean:20-23`; manual anchor: `doc/LMLFManual/Chapter4/Section42.lean:24-30`; manifest: `coverage/sections/chapter4-42.json:22`.
- Evidence: DLMF E1 defines `Ln z` as the path integral `∫₁ᶻ dt/t` along paths avoiding the origin. The declaration only proves `∃ k, generalLogValue z k = Complex.log z + 2*kπi`, which follows by unfolding `generalLogValue` and never mentions a path, integral, or branch-point condition. The manifest now honestly calls it a specialization, but the anchor remains a tautological proxy rather than a complete reusable statement.
- Repair: state a branch-value relation explicitly as the intended specialization (with a named relation and `z ≠ 0`) and say in the manual that the path-integral definition is not formalized, or introduce a genuine path-integral/continuation interface.

### P1 — Base-log formulas still silently totalize the logarithm at `z = 0`

- DLMF IDs: `4.2.E8`–`4.2.E16`.
- Exact declarations: `LMLF/Blueprint/Elementary/Section42.lean:49-92`; manual anchors: `doc/LMLFManual/Chapter4/Section42.lean:74-106`; manifest entries: `coverage/sections/chapter4-42.json:29-39`.
- Evidence: `logBase` uses totalized `Complex.log`, while E8–E16 quantify over arbitrary `z` and omit `z ≠ 0`/a declared totalized extension. Thus `logBase a 0` is accepted even though DLMF’s `ln 0` is at the branch point and undefined. E14–E16 also omit the valid-base/nonzero-denominator hypotheses carried by E8–E10. The prose says the Lean statements retain source domain restrictions, but these public statements do not.
- Repair: add `z ≠ 0` (and valid-base/denominator hypotheses) to E8–E16, or explicitly define and label a totalized extension in both prose and manifest.

### P1 — Off-cut and coarse specializations remain mislabeled as exact, and the manifest is stale

- DLMF IDs: `4.2.E11`, `4.2.E17`, `4.2.E18`, `4.2.E19`, `4.2.E28`–`4.2.E31`.
- Exact manifest entries: `coverage/sections/chapter4-42.json:32,38-40,49-52`.
- Evidence: E28–E31 use the off-cut `principalLogDomain`, while the source’s default closed convention also discusses cut-side values; the manifest still calls these `exact` without recording the restriction. E11/E18 are five-decimal inequalities, not the full displayed decimal formulas, yet remain `exact`; E17 is additionally false. E19 is now a correct infinite `HasSum`, but its note still says “finite series display with omitted tail represented by zero.” E26 is now all integer branches and can remain exact, while E27 is explicitly a `k=0`/nonzero specialization and is correctly labeled specialization.
- Repair: mark E28–E31 and coarse numerical enclosures as `specialization` with domain notes, correct E17, and replace the stale E19 note with the `HasSum` coverage description.

### P1 — Source prose still omits analytic/no-zero and closed-boundary caveats

- DLMF locations: prose following E19 and E28, and the final note after E37.
- Exact documentation: `doc/LMLFManual/Chapter4/Section42.lean:110-144`.
- Evidence: DLMF states that `exp` has no real or complex zeros; the manual says only that it is entire. DLMF states that the principal power is analytic off `(-∞,0]` and is two-valued/discontinuous on the cut unless the exponent is integral; the manual’s power paragraph omits these regimes. DLMF also notes that the E37 inequalities become strict for the non-closed convention; the manual does not preserve that qualification.
- Repair: restore the no-zero, analyticity/discontinuity, and open-versus-closed boundary prose and align the manifest/theorem domains with it. The Figure 4.2.1 link and direct E2–E7 links are present and are correctly retained.

### P2 — Range source links still use endpoint “through” links

- DLMF IDs: E9–E18, E20–E25, and E27–E37.
- Exact documentation: `doc/LMLFManual/Chapter4/Section42.lean:59,110,139-144` links only the first and last E IDs for each range. Individual theorem anchors are present, but declarations in the middle have no direct DLMF permalink.
- Repair: add one direct E-number link per declaration or split grouped entries.

## Correctly handled after this revision

- E2 now gives the principal inverse on the open slit domain instead of a reflexive identity.
- E6/E7 expose integer branch values and tagged upper/lower cut values.
- E8–E10 expose `logBase` with valid-base and denominator hypotheses; the reusable definition is now manually anchored (though the later z-domain issue remains).
- E19 is a genuine infinite `HasSum`; E23 and E25 use existential integer branch representatives.
- E26 quantifies over every integer logarithm branch; E29–E31 quantify phase wrapping on the principal domain; E32–E35 retain coherent principal/general distinctions.
- E36 is now a named closed-phase predicate equivalence, not the prior copied assumption.
- E37’s condition correctly distinguishes the negative imaginary-axis boundary (`z = -i` now yields `+i`).
- E12–E13, E20–E22, E24, and E34 remain correct ordinary identities.

## Quantitative pairs

None; §4.2 has no distinct finite-estimate pair, and all entries use `quantitative_analogue: "not_applicable"`.

## Build and unreviewed candidates

- `lake env lean LMLF/Blueprint/Elementary/Section42.lean`: passed, exit 0, with 37 expected `sorry` warnings.
- `lake env lean LMLFManual/Chapter4/Section42.lean` from `doc/`: failed, exit 1, with the anchor mismatches listed above.
- The checked-in `doc/_out` tree has no rendered §4.2 page; the authored sources and official DLMF page were checked directly.
- No `#check` command or unreviewed E-number source candidate was found.
