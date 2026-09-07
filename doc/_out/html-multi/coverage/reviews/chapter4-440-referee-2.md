# Terminal referee report: DLMF §4.40 (Integrals)

## Snapshot and files reviewed

- Snapshot: `1d1efec0955d428f64793b00fe0b35fbf20087b2` (working tree includes the
  three revised §4.40 files).
- Referee contract: `blueprint/agent-prompts/dlmf-section-referee.md`.
- Official source: [DLMF §4.40](https://dlmf.nist.gov/4.40), including the
  introduction, indefinite/definite/inverse-function subsections, notes, and
  compendia paragraph.
- Authored files:
  `LMLF/Blueprint/Elementary/Section440.lean`,
  `doc/LMLFManual/Chapter4/Section440.lean`, and
  `coverage/sections/chapter4-440.json`.
- The repository has no separate `coverage/dlmf-4-40-source-inventory.json`
  file in this checkout; I independently recomputed the official numbered
  inventory from the DLMF page.

## Independent inventory and verdict

The official numbered inventory is exactly
`4.40.E1` through `4.40.E16`. The manifest expected/stated sets agree
(16/16), the omitted set is empty, and each ID names its corresponding
declaration.

**Verdict: accept.** The prior E9 singularity is repaired by the explicit
continuation `e9Value`, which has value (4) at (a=0), and the open
domain (-1<a<1) is retained. Every formula now has a formula-specific
manual entry, DLMF URL, source-level prose, and statement-only Lean anchor.
No P0 or P1 findings remain.

## Formula and domain audit

- E1--E2 state the real (sinh/cosh) derivative primitives on all real
  (x), matching the source.
- E3 states the (log(cosh x)) derivative with the positive-cosh hypothesis;
  this is valid on the full real line.
- E4 and E6 retain the source interval (x>0), with the logarithms and
  reciprocal derivative values shown directly.
- E5 exposes the concrete Gudermannian definition
  `gd x = 2 * arctan (exp x) - pi/2` and its sech derivative on all real
  (x), with the manual's source note to DLMF 4.23.39--4.23.40.
- E7 preserves (a
e0), the ([1/R,R]) endpoint truncation, and the
  (rac{pi}{2}coth(rac{pi a}{2})-rac1a) value.
- E8 preserves (-pi<a<pi), the ([1/R,R]) truncation, and
  (rac12	an(a/2)).
- E9 preserves (-1<a<1) and symmetric ([-R,R]) truncation. Its
  `e9Value` is (4) at (a=0), and otherwise
  (4pi a/sin(pi a)), correctly handling Lean's totalized (0/0).
- E10 preserves (a>0,b>0), the ([1/R,R]) truncation, and
  (log(a/b)).
- E11--E16 preserve the inverse-hyperbolic real branches and exact source
  domains: all-real arsinh, (x>1) arcosh, (-1<x<1) artanh, (x>0)
  arcsch, (0<x<1) arcsech, and (x>1) arcoth.

The declarations are direct `HasDerivAt` or explicit truncated-limit
propositions rather than opaque proxies. The definite formulas are honestly
marked as real specializations in the manifest. No distinct quantitative
companion declarations are warranted.

## Source fidelity and reader UX

Each E1--E16 has its own `::::dlmfEntry` with the corresponding
`https://dlmf.nist.gov/4.40.En` URL and formula-specific prose. The page
also explicitly covers:

- real-variable scope and complex continuation via continuous branches
  avoiding singularities;
- the Gudermannian cross-reference for E5;
- Copson (1935, p. 155) for the definite integrals; and
- the named Apelblat, Bierens de Haan, Gröbner--Hofreiter,
  Gradshteyn--Ryzhik, and Prudnikov compendia.

All 16 source anchors and all 16 manual snippets are proof-free, and the
manual disclosures match the source declarations. No `#check`, `#eval`,
filler status prose, or displaced proof work appears in the authored files.

## Verification

- `lake build LMLF.Blueprint.Elementary.Section440`: passed.
- From `doc/`, `lake build LMLFManual.Chapter4.Section440`: passed.
- Manifest parses as JSON; expected/stated/declaration counts are 16/16/16
  with no numbered omissions.
- Independent anchor check found 16 source anchors and 16 manual snippets,
  zero proof text inside source anchor ranges, and zero `by sorry` inside
  manual snippets.
- No whitespace errors were observed in the reviewed files.
- No fresh route-specific rendered §4.40 page was available for visual review;
  the standalone manual target elaborated successfully.
- No unreviewed numbered or substantive source candidate remains.

## Correctly handled specializations and quantitative scope

- E4/E6 are real positive-interval specializations of the source logarithmic
  primitives.
- E7--E10 are real-parameter specializations represented by explicit endpoint
  limits; E9 additionally uses the mathematically necessary removable
  continuation at (a=0).
- E1--E6 and E11--E16 are qualitative derivative encodings, not quantitative
  estimates. No quantitative pairs are required.
