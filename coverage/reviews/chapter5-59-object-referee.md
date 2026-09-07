# Independent object-first referee — DLMF §5.9

## Snapshot and files reviewed

- Snapshot: `31b53f875c4884773698176b216809df59ea24a7` (`site/verso-dlmf-overlay`), with the §5.9 source, manual, manifest, shared contour API, and inventory modified in the worktree.
- Official source: [DLMF §5.9](https://dlmf.nist.gov/5.9), including the linked TeX records for E1–E20, Figure 5.9.1, and the source notes/proof sketches.
- Repository source inventory: `coverage/dlmf-4-10-source-inventory.json`.
- Author files: `LMLF/Blueprint/Gamma/Section59.lean`, `doc/LMLFManual/Chapter5/Section59.lean`, and `coverage/sections/chapter5-59.json`.
- Shared API and teaching page: `LMLF/Integral/Curve.lean` and `doc/LMLFManual/Chapter3.lean`.
- Prior design context: `coverage/reviews/chapter5-59-object-author.md` and the earlier §5.9 referee reports.
- The generated HTML tree was deliberately not used as evidence, per dispatch; it is a stale publication artifact rather than an authored source.

## Independently computed formula inventory

Filtering the source inventory for `kind = numbered_formula` and section `5.9` gives exactly 25 IDs, in document order:

`5.9.E1`, `5.9.E2`, `5.9.E2_5`, `5.9.E3`, `5.9.E4`, `5.9.E5`, `5.9.E6`, `5.9.E7`, `5.9.E8`, `5.9.E9`, `5.9.E10`, `5.9.E10_1`, `5.9.E10_2`, `5.9.E11`, `5.9.E11_1`, `5.9.E11_2`, `5.9.E12`, `5.9.E13`, `5.9.E14`, `5.9.E15`, `5.9.E16`, `5.9.E17`, `5.9.E18`, `5.9.E19`, `5.9.E20`.

The authored page has 25 numbered `dlmfEntry` blocks and 25 source-linked displays. The manifest expected/stated sets are exactly this set and `numbered_formula_ids_omitted` is empty.

## Verdict

**ACCEPT.** No P0 or P1 finding remains. The declarations are readable and source-faithful, all value identities have the appropriate preceding finite-integrability, summability, or improper-convergence layer, and the §5.9.2 branch-aware contour design is preserved. Two P2 API follow-ups and one P3 prose follow-up are recorded below; they do not block acceptance of the current §5.9 overlay.

## Formula and API audit

The following checks cover every numbered formula. Line references are to the current worktree files.

- **E1 — `5.9.E1`:** `Section59.lean:93–100` gives absolute `IntegrableOn` first, then `dlmf_5_9_1` at `:327–334` gives the exact generalized Euler value. The hypotheses `μ>0`, `Re ν>0`, and `Re z>0`, the real-positive `t^μ` on `Ioi 0`, and principal complex powers are preserved in the page prose and signature.
- **E2 — `5.9.E2`:** `Section59.lean:336–344` is the short source-oriented `HasHankelRepresentation` theorem. `Curve.lean:20–114` stores the point/tangent and branch lift; `:116–305` gives admissible radii, explicit lower-bank/circle/upper-bank specifications, join laws, finite-piece integrability, and the ordered outer-then-inner limits. The page at `Section59.lean:51–75` states the lower-bank start, positive circuit, upper-bank return, and continuous logarithm before the theorem, with the source normalization `1/(2πi)` visible.
- **Figure 5.9.1:** the inventory caption candidate is represented by the linked `dlmfEntry` and orientation caption at `Section59.lean:77–79`.
- **E2_5 — `5.9.E2_5`:** `temmePhase` precedes its use (`Section59.lean:78–82`, manual `:81–110`); `dlmf_5_9_2_5_integrable` (`:346–352`) is separate from the reciprocal-Gamma identity (`:354–361`). The `Re z>0` condition and finite interval `[-π,π]` are retained.
- **E3 — `5.9.E3`:** `dlmf_5_9_3_integrable` (`:363–368`) precedes the whole-real-axis value identity (`:370–376`). The `c>0`, `Re z>0`, real-axis path, `|t|^{2z-1}`, and Gaussian factor are faithful.
- **E4 — `5.9.E4`:** the tail `IntegrableOn` and correction-series `Summable` declarations (`:378–390`) precede the split value identity (`:392–399`). The hypothesis excludes exactly `z=0,-1,-2,…`, and the range/factorial indexing matches the source.
- **E5 — `5.9.E5`:** `dlmf_5_9_5_integrable` (`:401–410`) precedes the value identity (`:412–418`); `n : ℕ`, `-n-1 < Re z < -n`, and the degree-`n` exponential Taylor subtraction are explicit.
- **E6/E7 — `5.9.E6`, `5.9.E7`:** each source formula is a conditional improper-convergence/value assertion, and each is represented directly by a finite-cutoff `Tendsto` (`:420–434`) with the exact domains `0<Re z<1` and `-1<Re z<1`, respectively. A separate `IntegrableOn` theorem would misdescribe these conditional integrals.
- **E8/E9 — `5.9.E8`, `5.9.E9`:** the cutoff limits (`:436–450`) preserve the exact Gamma factors, phases, and `n≥2` regime (`n=2,3,…`).
- **E10/E10_1/E10_2 — `5.9.E10`, `5.9.E10_1`, `5.9.E10_2`:** the manual labels all three as positive-real specializations of the branch-sensitive Binet formulas (`:245–314`). Each has its own integrability declaration before the value theorem (`Section59.lean:452–503`), and the three distinct kernels and signs agree with the official TeX.
- **E11 — `5.9.E11`:** `verticalSegment`, `verticalLineIntegral`, finite-segment integrability, and convergence are introduced before use (`Section59.lean:43–76`; manual `:316–382`). The theorem uses the upward line `Re s=-c`, `1<c<2`, the kernel `π x^{-s}/(s sin πs) ζ(-s)`, and the source sign/normalization. It is honestly identified as the positive-real specialization of the general branch-sensitive formula.
- **E11_1/E11_2 — `5.9.E11_1`, `5.9.E11_2`:** `scaledGamma` precedes both entries (`Section59.lean:84–89`; manual `:385–458`). Each pair has separate `IntegrableOn` declarations for the two rays before the value identity. The `±ti` arguments, denominator sign swap, and `1/(2πi)` signs match the official formulas; the page honestly states the positive-real specialization.
- **E12–E15 — `5.9.E12`–`5.9.E15`:** the page explicitly says these are positive-real specializations (`manual:467–552`), and each kernel has an `IntegrableOn` declaration before its value theorem (`Section59.lean:104–165`). The cancellation, logarithm, Binet, and `-2` correction factors are all retained.
- **E16 — `5.9.E16`:** both source integrals are represented independently. The two `IntegrableOn` declarations (`Section59.lean:167–180`) precede the two value identities (`:182–197`), with the correct `Ioi 0` and `Ioo 0 1` domains.
- **E17 — `5.9.E17`:** the same typed vertical object as E11 is reused, with separate finite integrability and convergence (`:199–214`) before the differentiated Mellin–Barnes identity (`:216–223`). The exponent `-s-1`, zeta factor, upward orientation, `1<c<2`, and `1/(2πi)` normalization match the source; the positive-real specialization is stated explicitly.
- **E18 — `5.9.E18`:** the five distinct integrability facts (`:225–259`) precede the four value declarations (`:261–291`). The four source representations, including the `(0,1)`/`[1,∞)` split, are all present with no invented fifth value identity.
- **E19 — `5.9.E19`:** `IntegrableOn` (`:293–300`) precedes the `iteratedDeriv` value identity (`:301–307`); `n : ℕ` and `Re z>0` are visible.
- **E20 — `5.9.E20`:** `complexSegmentContour`/`complexSegmentIntegral` precede the separate right-hand integrability theorem and value identity (`:24–41`, `:309–324`; manual `:720–761`). The right-half-plane hypotheses, straight path, principal powers, and totalized removable quotient at `t=1` are disclosed.

## Findings (non-blocking)

### P2 — The reusable vertical-line object remains section-local

- **IDs:** `5.9.E11`, `5.9.E17`; declarations `LMLF.Blueprint.Gamma.Section59.verticalSegment`, `verticalLineIntegral`, `verticalLineIntegrable`, and `verticalLineConverges` at `LMLF/Blueprint/Gamma/Section59.lean:43–76`.
- **Evidence:** the two Mellin–Barnes entries correctly reuse one typed `C1Contour` object and the manual teaches it before use (`doc/LMLFManual/Chapter5/Section59.lean:316–382`, `:593–621`). However, unlike `C1Contour`, the branch/Hankel API, and `ImproperC1Ray`, this vertical finite-segment/improper-line layer is not in the shared Chapter 3 vocabulary. Its definition is also a totalized `limUnder` candidate; it becomes a genuine improper line integral only together with `verticalLineConverges`.
- **Repair:** when Mellin–Barnes lines recur, promote a named typed vertical-segment/improper-line interface to `LMLF.Integral.Curve` and teach the finite integrability plus convergence/value separation in Chapter 3. In the interim, replace the manual phrase “actual real-line Bochner integral” with “named limit of finite vertical-segment integrals,” which describes the current definition exactly.

### P2 — Scaled-Gamma normalization is duplicated across §5.9 and §5.11

- **IDs:** `5.9.E11_1`, `5.9.E11_2`; declaration `LMLF.Blueprint.Gamma.Section59.scaledGamma` at `LMLF/Blueprint/Gamma/Section59.lean:84–89`.
- **Evidence:** §5.9 defines a complex scaled-Gamma quotient locally, while §5.11 now exposes the positive-real canonical `scaledGammaReal` and its prefactor/factorization (`LMLF/Blueprint/Gamma/Section511.lean:41–60`). The §5.9 page is readable and labels its formulas as positive-real specializations, so this is not a source-fidelity error, but there is no bridge theorem showing that `scaledGamma (x : ℂ)` is the same object as `scaledGammaReal x` for `x>0`.
- **Repair:** either move the complex Γ* definition to shared Gamma vocabulary and prove the positive-real bridge, or use the §5.11 object directly for these positive-real specializations. Keep the displayed E11_1/E11_2 formulas short.

### P3 — E20’s official proof-sketch sentence is not repeated

- **Source candidate:** `dlmf:5.9#E20.info@proof-sketch-1`, [DLMF E20](https://dlmf.nist.gov/5.9.E20), “Both sides vanish when `z=c`, and for both sides the `z`-derivative is `Γ(z)`.”
- **Evidence:** the authored E20 prose explains the path and removable quotient (`doc/LMLFManual/Chapter5/Section59.lean:720–724`) but does not mention this short source proof sketch. This does not omit a numbered formula or change any hypothesis.
- **Repair:** add a brief source-linked note after the E20 theorem (or explicitly classify the proof sketch as out-of-scope editorial provenance). The E10_1 integration-by-parts note is already captured in the page prose.

## Correctly handled specializations and quantitative pairs

- Positive-real specializations are explicitly labeled for E10, E10_1, E10_2, E11, E11_1, E11_2, E12, E13, E14, E15, E16, and E17. Their source branch/phase conditions are respected by `x>0`; no specialization is presented as the full complex theorem.
- Exact/general statements are retained for E1–E9 and E18–E20, subject only to the source domains visible in the signatures/prose.
- No DLMF §5.9 formula has a genuinely distinct quantitative error/bound analogue. The manifest marks all 25 quantitative slots `not_applicable`; the E6–E9 and E11/E17 convergence declarations are analytic existence layers, not quantitative companions.

## Validation

- `lake env lean LMLF/Blueprint/Gamma/Section59.lean`: **pass**, with only permitted `sorry` warnings.
- From `doc/`, `lake build LMLFManual.Chapter5.Section59`: **pass** (3389 jobs; only permitted imported/source `sorry` warnings).
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter5/Section59.lean`: **pass**, KaTeX accepted all 43 source expressions.
- Independent source/manual anchor extraction: **67/67 exact byte matches**, with no source-only or manual-only anchors.
- `python3 -m json.tool coverage/sections/chapter5-59.json`: **pass**; independent inventory recomputation gives exactly 25 expected/stated IDs and no omissions.
- `python3 scripts/sync_chapter5_coverage.py --chapter 5 --first-section 9 --last-section 9 --expected-formulas 25 --dry-run`: **pass** (`formula_overrides=25`).
- No `#check`, `#eval`, filler status prose, TODO/FIXME markers, redundant `\\[...\\]` delimiters, or unsupported TeX commands were found in the authored §5.9 source/manual or the shared contour teaching page.
- Generated HTML was not used for this review, as requested; no rendered-site claim is made here.

## Unreviewed source candidates

No numbered formula is unreviewed. The inventory’s prose blocks were sampled against the official page: contour/orientation, phase, domains, branch conditions, and the section-wide `Re z>0` context are represented. The Figure 5.9.1 caption is linked and represented by the contour caption. Annotation/editorial notes are provenance/reference/addition notes rather than missing theorem-shaped mathematics; the only substantive proof-note omission is the P3 E20 sentence above.
