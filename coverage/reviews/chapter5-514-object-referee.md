# DLMF §5.14 object-first referee

## Snapshot and files reviewed

Review snapshot: `31b53f875c4884773698176b216809df59ea24a7` (the assigned
source files are object-repair worktree changes on top of this commit).

Reviewed independently:

- `LMLF/Blueprint/Gamma/Section514.lean`
- `doc/LMLFManual/Chapter5/Section514.lean`
- `coverage/sections/chapter5-514.json`
- `coverage/dlmf-4-10-source-inventory.json`
- the official DLMF [§5.14 page](https://dlmf.nist.gov/5.14)
- the generated highlighted declaration artifact under
  `doc/.lake/build/highlighted/LMLF/Blueprint/Gamma/Section514.json`

## Independently computed coverage and verdict

Filtering the source inventory to `kind = numbered_formula` and
`location.section = "5.14"` gives exactly:

`5.14.E1`, `5.14.E2`, `5.14.E3`, `5.14.E4`, `5.14.E5`, `5.14.E6`, `5.14.E7`.

The section manifest and manual state exactly this set; omitted and extra
numbered-ID sets are empty.

**Verdict: accept.**

There is no P0 or P1 finding. The one API-teaching item below is P2 advisory
and does not block this section: the section itself gives the new typed-domain
vocabulary a readable introduction and uses it consistently.

## Findings

### P2 — shared-vocabulary follow-up for typed domains

`MultidimensionalDomain`, `domainIntegral`, `domainIntegrable`, and
`firstCoordinateSelection` are reusable interfaces, but they currently occur
only in `LMLF/Blueprint/Gamma/Section514.lean` and this page; Chapters 1–3 do
not teach or index them, and `shared_vocabulary_requests` is empty. This is a
reader/API follow-up rather than a §5.14 fidelity defect because the opening
panel and prose explain the objects before any formula uses them.

If these interfaces are intended as general LMLF vocabulary, add a short
foundational treatment in Chapters 1–3 and move or re-export the definitions
from a shared module. Otherwise explicitly keep them section-local and record
that decision in the manifest review. No formula or declaration needs to be
changed for the current §5.14 acceptance.

## Formula-by-formula audit

- **5.14.E1:** `simplex` is the nonnegative coordinate simplex, the real
  specialization has `0 < n` and `0 < z i`, and the named integrand,
  `domainIntegrable` convergence claim, volume integral, and Gamma quotient
  agree with the source. Boundary `Real.rpow` is honestly documented as an
  a.e. representative.
- **5.14.E2:** `fullSimplexBetaIntegrand` places the residual coordinate at
  `Fin.last n` and the ordinary coordinates at `Fin.castSucc`; the real,
  positive-dimensional specialization, simplex, convergence declaration, and
  Gamma quotient are all present.
- **5.14.E3:** `vandermonde` is the source-defined product over exactly the
  pairs `j < k`; the nested `Fin` product contributes one factor per pair and
  one for all other ordered pairs. The equality theorem is intentionally
  definition-backed because E3 itself defines the source object.
- **5.14.E4:** the unit cube, first `m` coordinates, absolute Vandermonde
  power, endpoint powers, positive `a,b`, and all three lower bounds on real
  `c` are present. For zero-based `k : Fin n`,
  `selbergIndex n k = n - k.1 - 1` in `ℝ`, so both Gamma denominators and the
  moment ratio use exactly the source `2n-k-1`. `firstCoordinateSelection` is
  `Fin.castLE hmn`, hence the canonical first-coordinate inclusion rather
  than an existential or arbitrary coordinate witness.
- **5.14.E5:** the positive orthant, Laguerre factor `exp (-t k)`, first
  coordinates, `n-k` and `1+kc` factors, denominator
  `Gamma(1+c)^n`, and both real convergence bounds are source-faithful.
- **5.14.E6:** the typed whole space, Gaussian product,
  `(2*pi)^(-n/2)` normalization, real `c > -1/n`, and Gamma product match
  the source; diagonal `Real.rpow` behavior is disclosed.
- **5.14.E7:** the typed `[-pi,pi]^n` cube, complex unit-circle exponentials
  followed by norms, pairwise `j < k` product, real `b > -1/n`, normalization,
  and Gamma quotient match the source; collision hyperplanes are disclosed
  as the a.e. totalized-power convention.

The integral records have independent convergence/value declarations for E1,
E2, E4, E5, E6, and E7. E3 is a product definition and has no convergence
claim; its quantitative analogue is correctly `not_applicable`.

## Object/API, panels, anchors, and manifest

`MultidimensionalDomain n` fixes the point type `Fin n → ℝ` and its carrier;
`domainIntegral` and `domainIntegrable` both use restricted product Lebesgue
volume, with convergence kept separate from value identities. The named
integrand objects avoid repeating opaque plumbing. The canonical coordinate
map and real-valued `selbergIndex` make the source indexing explicit and avoid
truncated natural subtraction. No declaration is a remainder or an arbitrary
function constrained only by a repeated tautology.

All 31 Lean anchors have matching manual anchors, with no duplicates; every
custom helper panel appears before its first formula use. The manifest has all
seven expected/stated IDs, no omissions, the correct fully qualified names,
and honest specialization/`missing` proof statuses. There are no `#check`,
`#eval`, filler-status prose, or proof bodies inside the statement panels.

## Candidate statements and quantitative pairs

The non-formula source candidates (`p1`, `Px1.p1`, `Px1.p2`, `Px1.p3`, and
`Px2.p1`) were sampled against the authored introduction, section headings,
and entry prose. They add only the simplex/Selberg/Dyson transitions and
conditions already represented on the page; no additional substantive
assertion or graphic caption is unreviewed. The DLMF notes are bibliographic.

No §5.14 display calls for a quantitative error analogue. E1, E2, E4, E5,
E6, and E7 are correctly marked `quantitative_analogue: not_applicable`; E3
is likewise a definition, not an approximation or bound.

## Verification

- `lake env lean LMLF/Blueprint/Gamma/Section514.lean`: **passed** (only the
  permitted `sorry` warnings for the 13 theorem declarations).
- `cd doc && lake build LMLFManual.Chapter5.Section514`: **passed**.
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter5/Section514.lean`:
  **passed** (all 9 source expressions accepted).
- Manifest JSON parsing and independent ID comparison: **passed**.
- Current checked-in `doc/_out/html-multi` is stale/incomplete for this repair
  and lacks the runtime KaTeX bundle expected by
  `check_rendered_tex.mjs`; rendered-site correspondence was therefore not
  treated as evidence, per dispatch. Source-level TeX and anchor checks pass.
