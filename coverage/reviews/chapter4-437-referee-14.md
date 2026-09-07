# Independent terminal referee 14 — DLMF §4.37

## Snapshot and files reviewed

Snapshot: `caebaa8c5f312e026a04d8e77dcdc29bee7b92d8` (the three assigned page
files are uncommitted in this worktree).  I reread the referee contract,
independently checked the official [DLMF §4.37](https://dlmf.nist.gov/4.37),
and reviewed exactly:

- `LMLF/Blueprint/Elementary/Section437.lean`;
- `doc/LMLFManual/Chapter4/Section437.lean`; and
- `coverage/sections/chapter4-437.json`.

The independently recomputed numbered inventory is exactly
`4.37.E1`–`4.37.E31` (31 formulas).  The repository inventory has 56 records:
31 numbered formulas and 25 prose/annotation/table/figure/editorial records.
The manifest has exact expected/stated formula parity, no omissions, and maps
all 25 nonformula IDs (its additional 23 IDs are explicitly named reusable
local vocabulary declarations).

## Verdict

**accept**

No P0 or P1 finding remains.  Every numbered formula has a direct DLMF link,
raw display, readable statement, and matching proof-free anchor.  The source
anchors end before the permitted `sorry` proofs, and the manual disclosures
contain no proof bodies.

## Formula and domain audit

- E1–E6 honestly identify the Lean declarations as equation-level
  specializations of the DLMF path-integral/general-value definitions.  The
  surrounding prose retains path avoidance, branch-point, and principal-value
  conventions.  E3 carries the source `z ≠ ±1` restriction.
- E6 is correctly restricted only by `z ≠ 0` in the Lean reciprocal encoding.
  The official E6 display itself has no additional `±1` condition; neither the
  source/manual anchor nor the manifest now invents one.
- E7/E8 retain `z ≠ 0`.  E9, unlike E6, retains `z ≠ 0` together with the
  explicit `z ≠ 1` and `z ≠ -1` exclusions required by the official E9 pole
  condition.  E15 and E31 likewise retain their official `z ≠ ±1`
  restrictions (with E15's additional reciprocal/cut specialization premise).
- E10–E15 preserve the reflection identities and cut-side distinctions.  In
  particular E11 selects `-π i` for `Im z > 0` and `+π i` for `Im z < 0`,
  while E14 selects the opposite corrections, matching DLMF's `±/∓` signs.
- E16–E18 preserve the logarithmic arcsinh domain and both cut-side values;
  E19/E21 preserve the open `\mathbb C \setminus (-\infty,1)` domain and
  branch-aware radical vocabulary; E20 correctly separates positive and
  negative imaginary-axis values.
- E22/E23 and E25 expose both boundary values with `CutSide` and preserve the
  real intervals.  E24 states the principal arctanh logarithmic form off the
  real cuts.
- E26–E28 expose the fundamental hyperbolic equations as consequences into
  the reusable inverse-value sets.  E29–E31 provide readable integer/sign
  family characterizations, honestly classified as specializations or
  consequences in the manifest.

The manual contains exactly one E24 declaration and one E24 anchor; no duplicate
was found in the current bytes.  The 25 nonformula disclosures cover the
source's path/branch prose, principal-value and figure material, annotation
and editorial notes, Dempsey/Kahan context, fundamental-property prose, and
interrelations.  No distinct quantitative companion is warranted for this
identity/branch-value page; all declarations correctly mark quantitative
analogues as not applicable.

## Verification

- `lake build LMLF.Blueprint.Elementary.Section437`: passes with only
  permitted `sorry` and existing style-long-line warnings.
- From `doc/`, `lake build LMLFManual.Chapter4.Section437`: passes with only
  permitted imported warnings and existing link-conversion informational
  messages.
- `python3 -m json.tool coverage/sections/chapter4-437.json`: passes.
- Independent inventory check: 31/31 expected and stated formulas, omitted
  list empty, and all 25 nonformula IDs present in the manifest.
- Anchor/display check: 31 source anchors, 31 manual anchors, and 31 raw
  DLMF displays; manual has zero `by sorry` and zero `#check` occurrences.
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter4/Section437.lean`:
  `KaTeX accepted all 31 source expressions.`
- `node scripts/check_rendered_tex.mjs`:
  `KaTeX accepted all 424 generated expressions.`

No unreviewed source candidate or P0/P1 issue remains.
