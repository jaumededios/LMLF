# DLMF §5.6 referee 2 report

## Snapshot and files reviewed

- Snapshot: `f4176ce69852c435e838eeb0b6da69c510f81fef` (`docs: publish rebuilt LMLF site`); the Section 5.6 author files are workspace additions at review time.
- Official source: [DLMF §5.6](https://dlmf.nist.gov/5.6), including the TeX endpoints `https://dlmf.nist.gov/5.6.E1.tex` through `5.6.E9.tex` (version 1.2.7, release 2026-06-15).
- Source inventory: `coverage/dlmf-4-10-source-inventory.json` (all §5.6 items, including prose and annotation candidates).
- Lean author file: `LMLF/Blueprint/Gamma/Section56.lean`.
- Documentation author file: `doc/LMLFManual/Chapter5/Section56.lean`.
- Manifest author file: `coverage/sections/chapter5-56.json`.
- A rendered Section 5.6 page was not present under `doc/_out/html-multi` at review time (the checked-in output contains §5.2 and §5.11 pages but no `Gamma-Function/___5___6-*` page). The standalone documentation source nevertheless elaborates, and the highlighted Lean artifact is present.

## Independently computed expected formula IDs

The numbered-formula items in the source inventory, in document order, are exactly:

`5.6.E1`, `5.6.E2`, `5.6.E3`, `5.6.E4`, `5.6.E5`, `5.6.E6`, `5.6.E7`, `5.6.E8`, `5.6.E9`.

The manifest and authored page state exactly this same set, with no omissions or extras among numbered formulas.

## Final verdict

`accept`

The E7 prose now explicitly identifies the displayed factor as the square root of
`sech(π y)`, resolving the only prior P2 finding. There are no P0, P1, P2, or P3
findings. The additional `realDigamma` declaration is honestly marked as related in
the manifest and is useful API vocabulary.

## Findings

No findings remain after revision. In particular, the revised E7 explanation at
`doc/LMLFManual/Chapter5/Section56.lean:168-171` now says that
`Real.sqrt ((Real.cosh (Real.pi * y))⁻¹)` is the square root of `sech(π y)`, matching
the DLMF formula and the Lean declaration at
`LMLF/Blueprint/Gamma/Section56.lean:88-90`.

## Formula-by-formula disposition

- **5.6.E1** — Exact positive-real hypothesis (`hx : 0 < x`), strict two-sided inequality, `Real.rpow` interpretation, source link, and declaration all match.
- **5.6.E2** — Exact positive-real reciprocal-Gamma inequality and source link; the subsection-wide `x > 0` is stated and also explicit in Lean.
- **5.6.E3** — Exact squared reciprocal-Gamma inequality and source link; no loss of the square or the reciprocal argument.
- **5.6.E4** — Exact Gautschi inequality, with both subsection `x > 0` and local `0 < s < 1` represented explicitly; strictness is preserved.
- **5.6.E5** — Exact Kershaw bounds and non-strictness; `realDigamma` is a transparent real-axis restriction and all displayed digamma arguments are positive under the hypotheses.
- **5.6.E6** — Faithful specialization with `x,y : ℝ`; the added `∀ n : ℕ, x ≠ -(n : ℝ)` explicitly excludes the nonpositive-integer poles required for the classical right-hand side, which Mathlib totalizes to zero. This specialization is honestly labeled in the manifest.
- **5.6.E7** — Exact `x ≥ 1/2` domain, square-root hyperbolic-secant factor, and now precise explanatory wording.
- **5.6.E8** — Exact conditions `a ≥ 0`, `b-a ≥ 1`, `Re z > 0`, and exact quotient bound; coordinate condition `x > 0` is correctly expressed as `0 < z.re`.
- **5.6.E9** — Faithful coordinate-free form using `z.re` and `z.im`; `z ≠ 0` explicitly records the source pole/`|z|⁻¹` domain at the origin and is honestly labeled as a specialization.

## Specializations and quantitative pairs

Correctly handled specializations:

- E6: real `x,y` and explicit exclusion of all nonpositive-integer real poles.
- E9: `x,y` replaced by `z.re,z.im`, with explicit `z ≠ 0` at the closed-half-plane pole.
- E7: named `sech` rendered as the transparent real expression `sqrt(cosh(πy)⁻¹)`, with the prose explicitly retaining the outer square root.
- E8: source coordinates `z=x+iy` replaced by the equivalent coordinate-free `0 < z.re`.
- `5.6.realDigamma`: related API definition, not a numbered formula, correctly marked `related` rather than `exact`.

There are no quantitative declaration pairs in this section, and the manifest correctly marks every formula as `not_applicable` for `quantitative_analogue`.

## Build and source-candidate checks

- `lake env lean LMLF/Blueprint/Gamma/Section56.lean` succeeds with the nine permitted `sorry` warnings and no errors after the revision.
- `lake env lean LMLFManual/Chapter5/Section56.lean` (from `doc/`) succeeds with no errors after the revision.
- Neither author source contains `#check` or filler status prose; proof placeholders are exactly the permitted statement-coverage `sorry`s.
- Source-inventory prose candidates `5.6#i.p1`, `5.6#Px1.p1`, `5.6#Px2.p1`, `5.6#Px2.p2`, `5.6#ii.p1`, `5.6#ii.p2`, and `5.6#ii.p3` were sampled against the official page. Their mathematically substantive domain statements (global `x>0`, local `0<s<1`, `b-a≥1`, `a≥0`, `x>0`, and `x≥0`) are represented in the authored page/declarations. The remaining inventory candidates are reference/annotation/editorial notes, not omitted mathematical assertions. No unreviewed substantive source candidate was found.
