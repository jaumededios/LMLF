# Final object-first referee review: DLMF §5.13

## Snapshot and files reviewed

- Snapshot commit: `31b53f875c4884773698176b216809df59ea24a7` with the current
  uncommitted §5.13 repair in the working tree.
- Official source: [DLMF §5.13](https://dlmf.nist.gov/5.13), version 1.2.7
  (release 2026-06-15), including Notes, path prose, headings, and E1--E5.
- Lean source: `LMLF/Blueprint/Gamma/Section513.lean`.
- Manual source: `doc/LMLFManual/Chapter5/Section513.lean`.
- Manifest: `coverage/sections/chapter5-513.json`.
- Source inventory: `coverage/dlmf-4-10-source-inventory.json`.
- Stale generated HTML was intentionally ignored, per dispatch.

## Formula-ID parity and verdict

Independent source/inventory extraction gives exactly:

`5.13.E1`, `5.13.E2`, `5.13.E3`, `5.13.E4`, `5.13.E5`.

The manual entries, Lean source links, and manifest expected/stated sets agree
exactly; the manifest has no omissions. Verdict: **ACCEPT**.

## Repair verification

- Source/manual anchor sets are exactly **33/33**, with all 33 declaration
  bodies byte-identical. This includes the newly anchored `VerticalLine`,
  principal-phase, pole-free, domain, named-integrand, integral, and
  integrability declarations, as well as E1--E5 value theorems.
- Every custom object panel appears before the first formula that uses it.
- Each formula has a standalone `Integrable` declaration before its value
  identity; no convergence claim is hidden inside a value theorem.
- No `#check`, `#eval`, proof body inside an anchor, filler status prose, or
  redundant `\[...\]` delimiters were found.

## Formula/object audit

- **E1:** `BarnesFirstDomain` packages `Re(a+b)>0` and
  `-Re(a)<c<Re(b)`; `PrincipalPowerPoint` packages nonzero `z` and
  `|arg z|<π`; `VerticalLine` exposes `s=c+it`, the upward tangent `i`,
  pulled-back integrand, integral, and ordinary integrability. The displayed
  Gamma factors, principal powers, normalization, and RHS match DLMF.
- **E2:** correctly marked in the manifest as a specialization. Real `a,b`,
  `a>0`, `0<b<π`, modulus square, exponential weight, real Gamma, sine,
  real power, and `1/(2π)` are all preserved. The manual and manifest record
  DLMF's `c=0`, `b=a`, `s=it`, `z=exp(i(π−2b))` derivation and the harmless
  `t↦−t` reorientation.
- **E3:** all four complex parameters and positive real-part hypotheses are
  retained, with the four `+it/-it` Gamma factors and normalized whole-line
  integral separated from convergence and value.
- **E4:** only `Re(a+b+c+d)>3` is assumed, exactly as in DLMF. The reciprocal
  four-Gamma integrand, shifts, unnormalized integral, and four denominator
  factors are faithful.
- **E5:** `Fin 4` retains four parameters and exactly six `j<k` pair factors;
  positivity and the pole-free parameter invariant are explicit. The
  reciprocal-Gamma factors provide the totalized removable value at `t=0`,
  with ordinary integrability kept separate from the value identity.

The object-first factoring is readable and reusable: persistent contour,
branch, pole, and parameter invariants are typed once; no raw curve/derivative
soup or opaque existential witness appears. No formula needs a second
quantitative declaration; all five manifest entries correctly use
`quantitative_analogue: "not_applicable"`.

## Build and TeX results

- `lake env lean LMLF/Blueprint/Gamma/Section513.lean` from the repository:
  **passed**, with only the ten expected `sorry` warnings.
- `lake build LMLF` from the repository: **passed** (3371 jobs).
- `cd doc && lake env lean LMLFManual/Chapter5/Section513.lean`:
  **passed**.
- `cd doc && lake build LMLFManual.Chapter5.Section513`:
  **passed** (2975 jobs).
- `cd doc && lake build`: **passed** (7356 jobs).
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter5/Section513.lean`:
  **passed** (`KaTeX accepted all 5 source expressions`).
- Rendered-page checks were not used because the checked-in HTML is stale, as
  required by dispatch.

## Non-formula candidates and quantitative status

The source inventory's annotation and final compendia paragraph are
bibliographic, not missing mathematical claims. The straight-path note,
Barnes/Ramanujan/de Branges--Wilson headings, and E2 source-dependency note
are represented in the authored manual. E2 is the only specialization; E1,
E3, E4, and E5 are exact identities over typed domain data. No quantitative
pair is mathematically called for in §5.13.

No P0, P1, P2, or P3 finding remains.
