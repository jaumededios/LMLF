# Final referee: DLMF §4.2 after redesign

Snapshot baseline: `703f1ad1d96c360bbac555c43dc39f6ca64d1a7b` (`site/verso-dlmf-overlay`), with the post-redesign working-tree files reviewed below.

Files reviewed:

- `LMLF/Blueprint/Elementary/Section42.lean`
- `doc/LMLFManual/Chapter4/Section42.lean`
- `coverage/sections/chapter4-42.json`
- prior reports `coverage/reviews/chapter4-42-referee-1.md` and `coverage/reviews/chapter4-42-referee-2.md`
- official [DLMF §4.2](https://dlmf.nist.gov/4.2), including E1–E37, the branch prose, and Figure 4.2.1.

## Independently computed formula IDs

The official numbered set is exactly `4.2.E1` through `4.2.E37` (E31 is one two-component display):

`[4.2.E1, 4.2.E2, 4.2.E3, 4.2.E4, 4.2.E5, 4.2.E6, 4.2.E7, 4.2.E8, 4.2.E9, 4.2.E10, 4.2.E11, 4.2.E12, 4.2.E13, 4.2.E14, 4.2.E15, 4.2.E16, 4.2.E17, 4.2.E18, 4.2.E19, 4.2.E20, 4.2.E21, 4.2.E22, 4.2.E23, 4.2.E24, 4.2.E25, 4.2.E26, 4.2.E27, 4.2.E28, 4.2.E29, 4.2.E30, 4.2.E31, 4.2.E32, 4.2.E33, 4.2.E34, 4.2.E35, 4.2.E36, 4.2.E37]`.

The revised Lean file and documentation contain all 37 anchors, and the manifest expected/stated sets agree with no omitted or extra IDs.

## Verdict

**revise**

The redesign fixes the main multivalued-log, infinite-series, phase-quantification, and base-power API failures, but remaining P0/P1 issues prevent acceptance.

## Findings

### P0 — E17 is numerically false

- DLMF ID: `4.2.E17`.
- Exact declaration: `LMLF/Blueprint/Elementary/Section42.lean:85-92`; documentation anchor: `doc/LMLFManual/Chapter4/Section42.lean:92-97`; manifest entry: `coverage/sections/chapter4-42.json:38`.
- Evidence: DLMF E17 gives `log₁₀ e = 1/ln 10 = 0.434294…`. The declaration asserts `|Real.log 10⁻¹ - 0.43429| < 0.00001`. But `Real.log (10⁻¹) = -Real.log 10 ≈ -2.302585`, so the asserted inequality is false. This is not merely a coarse specialization; it has the wrong sign and quantity.
- Repair: state `|1 / Real.log 10 - 0.43429| < 0.00001` (or a rigorous interval around the full displayed decimal), and mark the coarse bound as `specialization` in the manifest.

### P0 — E37 still fails at the closed-boundary branch

- DLMF ID: `4.2.E37`.
- Exact declaration: `LMLF/Blueprint/Elementary/Section42.lean:173-176`; documentation anchor: `doc/LMLFManual/Chapter4/Section42.lean:175-177`.
- Evidence: Replacing the ad hoc definition with `Complex.sqrt` fixed the former non-square-root proxy, but the unconditional piecewise equality is still false under Mathlib's single-valued principal square root. Take `z = -Complex.I`: `z.re = 0`, so the RHS chooses `-Complex.I`, whereas `Complex.sqrt (z^2) = Complex.sqrt (-1) = Complex.I`. DLMF's closed-cut display permits the two boundary-side readings; a single `if 0 ≤ z.re then ... else ...` cannot represent both at `Re z = 0`.
- Repair: restrict the branches to strict half-planes and state the imaginary-axis boundary separately, or use a tagged/set-valued closed-cut square-root relation. The manifest's specialization note must explain that boundary convention.

### P1 — E1/E2 and E36 remain tautological proxies rather than source mathematics

- DLMF IDs: `4.2.E1`, `4.2.E2`, `4.2.E36`.
- Exact declarations: `LMLF/Blueprint/Elementary/Section42.lean:20-27,166-172`; documentation anchors: `doc/LMLFManual/Chapter4/Section42.lean:24-30,33-40,169-174`.
- Evidence: E1 is the path-integral definition of `Ln z` (with paths avoiding the origin), but `dlmf_4_2_1` merely proves `∃ k, generalLogValue z k = Complex.log z + 2*kπi`, which follows by unfolding its own definition and does not relate to a path integral. E2 similarly states `Complex.log z = Complex.log z`; it has no principal-path/integral content. E36 takes the desired two-sided phase condition as a hypothesis and returns that identical condition, so it contributes no reusable branch predicate or inversion statement. These are precisely the tautological anchors the prior review required to remove.
- Repair: expose named predicates/relations for the path-integral and principal/general branch values, with `z ≠ 0` and path/cut data; for E36 define a reusable `principalPowerInversionCondition` (or state an equivalence/consequence) rather than an assumption copied into the conclusion. Change manifest relations from `exact` where a branch-aware specialization is all that is formalized.

### P1 — Principal closed-cut formulas and totalized base logs still omit source domains

- DLMF IDs: `4.2.E5`, `4.2.E8`–`4.2.E16`, `4.2.E28`–`4.2.E31`.
- Exact declarations: `LMLF/Blueprint/Elementary/Section42.lean:36-39,49-84,131-149`; manifest entries: `coverage/sections/chapter4-42.json:26,29-37,49-52`.
- Evidence: `principalLogDomain` deliberately excludes `(-∞,0]`, so E5, E28, and E29–E31 are only off-cut specializations even though the page introduction claims the closed convention. The manifest marks E5 and E28–E31 `exact` and does not record the omitted cut values. The general-base declarations E8–E16 quantify over `z` without `z ≠ 0`; Mathlib's totalized `Complex.log 0` makes these declarations silently assign a value at the branch point where DLMF's logarithms are undefined. The revised prose acknowledges totalization at zero globally, but each public theorem still accepts those invalid inputs.
- Repair: add explicit `z ≠ 0`/off-cut hypotheses (or clearly state a deliberate totalized extension) and mark off-cut statements as `specialization`. If the closed convention is intended, add tagged upper/lower cut formulas to the power/base-log APIs rather than excluding the cut while calling the result exact.

### P1 — Decimal and finite-precision repairs are not labeled honestly in the manifest

- DLMF IDs: `4.2.E11`, `4.2.E17`, `4.2.E18`, `4.2.E19`, `4.2.E26`–`4.2.E27`.
- Exact manifest entries: `coverage/sections/chapter4-42.json:22,38-40,47-48`.
- Evidence: E11 and E18 now give coarse five-decimal inequalities rather than the displayed decimal expansions, so they are consequences/specializations, not `relation: "exact"`. E17 is additionally false (P0 above). E19 is now a correct `HasSum`, but its manifest note still says “finite series display with omitted tail represented by zero,” describing the removed false theorem. E26 fixes only the `k = 0` branch (`generalPowerValue z a 0`), while E27 also fixes one branch and adds `z ≠ 0`; both are honest specializations of the general-value source formulas but E26 remains marked `exact`.
- Repair: update relations and notes to `specialization` where appropriate, remove the stale E19 note, and document the branch index/domain reduction for E26/E27.

### P1 — Source prose still omits substantive analytic claims

- DLMF locations: prose after E19 and E28, and the E37 closing note.
- Exact documentation: `doc/LMLFManual/Chapter4/Section42.lean:101-104,130-134`.
- Evidence: DLMF says `exp` is entire *and has no real or complex zeros*; the revised exponential paragraph says only “entire” and lists identities. DLMF says the principal power is analytic off the cut and two-valued/discontinuous on the cut unless the exponent is integral; the revised powers paragraph states the definitions and formulas but omits those analytic/discontinuity regimes. DLMF also explains that E37's inequalities become strict under the non-closed convention; the page does not preserve that caveat. Figure 4.2.1 is now linked, which repairs the earlier missing-figure issue.
- Repair: restore the no-zero, analyticity, discontinuity, and open-versus-closed boundary statements in ordinary-language prose, and align theorem hypotheses/manifest relations with them.

### P2 — Range links are still not individual source links

- DLMF IDs: `4.2.E9`–`4.2.E18`, `4.2.E20`–`4.2.E25`, and `4.2.E27`–`4.2.E37`.
- Exact documentation: `doc/LMLFManual/Chapter4/Section42.lean:59,101,130-134` says “through” with only endpoint links for each range. Individual anchors are present, but a reader cannot click directly from each displayed declaration to its own DLMF permalink.
- Repair: provide one direct DLMF E-number link per declaration (or split each grouped entry), while retaining the current namespace-bearing external anchors.

## Correctly handled redesign portions

- `generalLogValue` plus the integer branch index repairs the prior single-valued collapse for E6, E25, E33, and E35; E7 now has explicit upper/lower tagged values.
- E8–E10 now name `logBase` and carry nonzero/non-unit base and denominator hypotheses.
- E19 is a genuine `HasSum` for the full factorial series.
- E23 uses an existential integer phase, and E25 uses existential logarithm branches.
- E29–E31 add an off-cut nonzero domain and quantify phase wrapping; E32–E35 use the principal/general distinction coherently (subject to the domain/manifest issues above).
- E12–E13, E20–E22, E24, and E34 remain correct ordinary Mathlib identities.

## Quantitative pairs

None. Section §4.2 has no finite-estimate pair; all entries use `quantitative_analogue: "not_applicable"`.

## Build and source-candidate status

- `lake env lean LMLF/Blueprint/Elementary/Section42.lean`: passed, exit 0, with 37 expected `sorry` warnings.
- `lake env lean LMLFManual/Chapter4/Section42.lean` from `doc/`: passed, exit 0.
- The checked-in `doc/_out` tree still has no rendered §4.2 page; visual/rendered-page verification was therefore unavailable. The authored files and official DLMF page were checked directly.
- No `#check` command or proof-displacing filler prose was found. The remaining tautological declarations and stale manifest metadata are coverage/API defects, not build defects.
