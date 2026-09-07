# Referee 3 — DLMF §4.43 Cubic Equations

## Snapshot and files reviewed

Reviewed the current working tree at snapshot `9cf5090`, the shared referee
contract, prior reports `chapter4-443-referee-1.md` and
`chapter4-443-referee-2.md`, the official [DLMF §4.43](https://dlmf.nist.gov/4.43),
and exactly:

- `LMLF/Blueprint/Elementary/Section443.lean`;
- `doc/LMLFManual/Chapter4/Section443.lean`;
- `coverage/sections/chapter4-443.json`.

## Independent inventory and verdict

The numbered inventory is exactly `4.43.E1` and `4.43.E2`. The nine exact
nonformula records are all present in the manifest and manual:

`4.43#info@annotation-note-1`, `4.43#info@editorial-change-note-1`,
`4.43#p1`, `4.43#E1.info@editorial-change-note-1`,
`4.43#E2.info@editorial-change-note-1`, `4.43#I3.ix1.p1`,
`4.43#I3.ix2.p1`, `4.43#I3.ix3.p1`, and `4.43#p2`.

The source and manual each have five anchors: E1, the complete E2, and
separate E2a/E2b/E2c case disclosures. Every anchor is statement-only: source
`ANCHOR_END` markers precede `:= by sorry`, and manual anchor fences contain
no proof bodies.

**Verdict: accept.** No P0 or P1 findings remain.

## Correctness and coverage checks

- E1 preserves `p ≠ 0` and the source absolute-value scale conventions
  `A = √(-4p/3)` for `p < 0` and `B = √(4p/3)` for `p > 0`.
- The numbered E2 statement contains all three corrected regimes: sine with
  `4p³+27q² ≤ 0`, hyperbolic cosine with `p<0`, `q<0`, and positive
  discriminant, and hyperbolic sine with `p>0`.
- E2 retains the exact phase equations and all three root triples, with real
  shifts `a+2π/3`, `a+4π/3` in the sine case and imaginary shifts
  `a+2πi/3`, `a+4πi/3` in the hyperbolic cases.
- E2a, E2b, and E2c separately repeat the complete polynomial-root
  conjunctions with their exact regime hypotheses and phase equations; their
  manifest declaration mappings are present and honest.
- Reader-facing prose separately links the nine annotation, erratum, case, and
  concluding records, including the corrected discriminant regimes and the
  real-versus-conjugate-pair distinction.
- No separate quantitative companion is warranted for this cubic-root page.

## Build and hygiene status

- `lake build LMLF.Blueprint.Elementary.Section443`: **pass** with permitted
  `sorry` warnings.
- From `doc/`, `lake build LMLFManual.Chapter4.Section443`: **pass**.
- `node scripts/check_rendered_tex.mjs`: **pass** (`KaTeX accepted all 394
  generated expressions`).
- The manifest parses; expected/stated/omitted formula IDs are 2/2/0.
- No `#check`, `#eval`, or forbidden `\\[...\\]` delimiters were found.
