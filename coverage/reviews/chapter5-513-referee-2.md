# Referee review: DLMF §5.13

## Snapshot and files reviewed

- Snapshot: `f4176ce69852c435e838eeb0b6da69c510f81fef` (2026-09-06; the
  Section 5.13 files are uncommitted additions at this snapshot).
- Official source: [DLMF §5.13](https://dlmf.nist.gov/5.13), version 1.2.7
  (release 2026-06-15), including the section notes and E1–E5 endpoints.
- Lean source: `LMLF/Blueprint/Gamma/Section513.lean`.
- Manual source: `doc/LMLFManual/Chapter5/Section513.lean`.
- Section manifest: `coverage/sections/chapter5-513.json`.
- Source inventory: `coverage/dlmf-4-10-source-inventory.json`; the §5.13
  candidates are the section prose/note records and the five numbered formulas
  E1–E5.
- Rendered page: no standalone §5.13 page is present in the checked-in
  `doc/_out/html-multi` tree, and `doc/LMLFManual/Chapter5.lean` does not
  currently import this standalone source. Visual anchor inspection was
  therefore unavailable.

## Independently computed formula IDs and verdict

The official page and source inventory contain exactly:

`5.13.E1`, `5.13.E2`, `5.13.E3`, `5.13.E4`, `5.13.E5`.

The manual and manifest state exactly this set, with no omitted or extra
numbered IDs. Final verdict after re-review: **accept**. The prior E1 domain,
E5 endpoint-convention, subsection-heading, and E2 source-note findings are
all repaired in the revised Lean source, manual, and manifest. No P0/P1 finding
remains.

## Re-review of prior findings

- **E1 P0 — resolved.** `dlmf_5_13_1` now includes `hz0 : z ≠ 0` at
  `LMLF/Blueprint/Gamma/Section513.lean:43-45`; the manual explains the
  nonzero phase domain at `doc/LMLFManual/Chapter5/Section513.lean:35-39`, and
  the manifest note records the same repair. The former `z = 0` counterexample
  is therefore excluded.
- **E5 P2 — resolved.** The manual now states at
  `doc/LMLFManual/Chapter5/Section513.lean:172-177` that Mathlib's totalized
  quotient assigns the removable value `0` at `t = 0`, and that changing one
  point does not affect the ordinary integral. The manifest E5 note records the
  same convention. This remains an ordinary integral, not a PV integral.
- **P3 source navigation — resolved.** The manual now has explicit headings
  `§5.13(ii) Ramanujan's Beta Integral` and `§5.13(iii) de Branges--Wilson Beta
  Integral` at lines 128 and 160.
- **P3 E2 source dependency — resolved.** The manual E2 prose at lines 71-73
  and the manifest E2 note record the DLMF specialization
  `c = 0`, `b = a`, `s = it`, `z = exp(i(π - 2b))`, with `t ↦ -t` explaining
  the displayed weight orientation.

## Findings

### P0 — E1 admits `z = 0` and is false there (resolved)

- Files/declaration: `LMLF/Blueprint/Gamma/Section513.lean:43-53`,
  `LMLF.Blueprint.Gamma.Section513.dlmf_5_13_1`; manual entry at
  `doc/LMLFManual/Chapter5/Section513.lean:29-58`.
- DLMF [5.13.1](https://dlmf.nist.gov/5.13.E1) uses `|ph z| < π`, where the
  phase is the argument of a nonzero complex variable and the cut is excluded.
  The Lean hypothesis `|Complex.arg z| < Real.pi` alone admits `z = 0`, because
  Mathlib defines `Complex.arg 0 = 0`.
- This is a semantic counterexample, not merely missing prose. Take
  `a = 0`, `b = 1`, `c = 1/2`, and `z = 0`. The three real-part/contour
  inequalities and the `arg` inequality all hold. For every real `t`, the
  exponent `-((c : ℂ) + (t : ℂ) * Complex.I)` is nonzero, so Mathlib's
  `Complex.zero_cpow` makes the vertical-line integrand zero and its integral
  zero. The right side is
  `Complex.Gamma 1 * (0 : ℂ)^0 / 1^1 = 1`, using `0^0 = 1` in Mathlib.
- Resolution: `hz0 : z ≠ 0` is now explicit in the theorem, manual prose, and
  manifest note. With this repair, the `Integrable` assertion expresses the
  ordinary absolutely convergent vertical-contour integral; no Cauchy
  principal value is needed.

### P2 — E5's removable endpoint value is implicit and undocumented (resolved)

- Files/declaration: `LMLF/Blueprint/Gamma/Section513.lean:113-124`,
  `dlmf_5_13_5`; manual entry at
  `doc/LMLFManual/Chapter5/Section513.lean:152-183`.
- DLMF [5.13.5](https://dlmf.nist.gov/5.13.E5) displays
  `1/(Γ(2it) Γ(-2it))`. At `t = 0`, both Gamma factors are poles. Mathlib
  totalizes `Complex.Gamma 0` to `0`, and totalized division therefore assigns
  the quotient the value `0` at that point. This agrees with the removable
  limit (the reciprocal Gamma product is `O(t^2)`), and changing one point does
  not affect the ordinary Bochner integral, so this is not a principal-value
  issue. However, the authored prose says only “ordinary and integrable” and
  does not tell a reader what pointwise convention makes the displayed Lean
  function meaningful.
- Resolution: the manual and manifest now document Mathlib's totalized
  removable value `0` at `t = 0` and its irrelevance to the ordinary Bochner
  integral. The existing ordinary `Integrable` statement is retained; it is
  not a PV integral.

### P3 — Source note/headings are only partly represented (resolved)

- The manual now includes the DLMF headings for the Ramanujan and
  de Branges--Wilson displays.
- The manual and manifest now include the DLMF E2-from-E1 specialization note,
  including the harmless `t ↦ -t` change in the exponential weight. No extra
  quantitative declaration is required.

## Formula-by-formula audit

- **E1:** The contour is upward, `s = c + it` contributes the explicit `I`
  factor, and `1/(2π i)`, the Gamma arguments, principal complex powers, the
  explicit `z ≠ 0` condition, and three source inequalities are transcribed
  correctly. The intended integral is ordinary/absolutely convergent, not a PV
  integral.
- **E2:** The real specialization, `a > 0`, `0 < b < π`, modulus square,
  exponent `(2b - π)t`, `1/(2π)` normalization, Real Gamma, sine, and real
  power match [E2](https://dlmf.nist.gov/5.13.E2). The whole-line integral is
  ordinary and absolutely integrable; no endpoint singularity occurs in the
  open parameter range.
- **E3:** The four complex parameters, all four positive-real-part conditions,
  `+it/-it` signs, quotient, and `1/(2π)` normalization match
  [E3](https://dlmf.nist.gov/5.13.E3). Gamma decay gives an ordinary absolutely
  integrable whole-line integrand; no PV interpretation is needed.
- **E4:** The sole source condition `Re(a+b+c+d) > 3` is retained, with no
  invented positivity assumptions. The four `+t/-t` shifts, reciprocal Gamma
  product, unnormalized integral, and four denominator factors on the right
  match [E4](https://dlmf.nist.gov/5.13.E4). Reciprocal Gamma removes apparent
  poles, and the stated condition gives ordinary absolute convergence.
- **E5:** `Fin 4 → ℂ` retains all four parameters; the numerator has all four
  `±it` pairs and the nested `j < k` product has exactly six pairwise Gamma
  factors. The universal `Re(a_k) > 0` condition, `1/(4π)` factor, and sum in
  the denominator match [E5](https://dlmf.nist.gov/5.13.E5). The ordinary
  whole-line integral is appropriate, and the removable `t = 0` convention is
  now explicit; there is no PV requirement.

No formula declaration is an opaque proxy: `verticalLineIntegral` exposes the
contour parameterization and `deBrangesWilsonNumerator` exposes the finite
product. Every formula anchor displays a complete declaration and supplies the
module context. No `#check`, filler status prose, or proof work displacing
statement coverage was found. The five `sorry`s are the manifest's declared
proof-pending placeholders and are permitted by the referee contract.

## Correctly handled specializations and quantitative pairs

- E2 is honestly marked `relation: "specialization"` in the manifest because
  its Lean parameters are explicitly real, as required by its inequalities.
  E1, E3, E4, and E5 retain the source's complex domains, with E1's nonzero
  phase-domain condition explicit.
- `verticalLineIntegral` and `deBrangesWilsonNumerator` are useful structural
  helpers, not quantitative companions.
- No §5.13 display calls for a second quantitative declaration; all five
  manifest entries correctly use `quantitative_analogue: "not_applicable"`.

## Build result and unreviewed candidates

- `lake env lean LMLF/Blueprint/Gamma/Section513.lean`: **passed**, with the
  five expected `declaration uses sorry` warnings.
- `lake env lean LMLFManual/Chapter5/Section513.lean` from `doc/`: **passed**.
- `lake build LMLF`: **passed** (2929 jobs).
- `lake build` from `doc/`: **passed** (6304 jobs).
- No rendered §5.13 page was available because the standalone page is not
  imported by the current Chapter 5 aggregator; this is parent-owned site
  integration rather than a standalone-file elaboration failure.

The sampled section prose is covered sufficiently for the straight vertical
path, endpoint convention, source dependency note, headings, and formula
displays. The remaining source notes are bibliographic. Parent-owned Chapter 5
aggregation/rendered-site integration remains outside this standalone review.
