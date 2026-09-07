# Chapter 6 global final referee B

## Snapshot and scope

Snapshot: `31b53f875c4884773698176b216809df59ea24a7` plus the current dirty
worktree bytes. This was an independent final pass after the section-level
repairs. I read the referee contract and the object-first exemplar in full and
reviewed:

- `LMLF/Blueprint/ExponentialIntegrals/Section61.lean` through `Section621.lean`;
- `doc/LMLFManual/Chapter6/Section61.lean` through `Section621.lean`;
- all `coverage/sections/chapter6-*.json` manifests;
- the regenerated Chapter 6 routes under `doc/_out/html-multi/`; and
- the official DLMF pages and numbered formula records for §§6.1–6.21.

The source comparison was made against the official [DLMF Chapter 6
index](https://dlmf.nist.gov/6) and each section's source page, especially the
formula and prose records at [§6.2](https://dlmf.nist.gov/6.2),
[§6.12](https://dlmf.nist.gov/6.12), and [§6.18](https://dlmf.nist.gov/6.18).

## Independent formula inventory

The expected numbered IDs are exactly:

| Section | Numbered formula IDs |
|---|---|
| 6.1 | none |
| 6.2 | `6.2.E1`–`6.2.E21` |
| 6.3 | none (graphics) |
| 6.4 | `6.4.E1`–`6.4.E7` |
| 6.5 | `6.5.E1`–`6.5.E7` |
| 6.6 | `6.6.E1`–`6.6.E6` |
| 6.7 | `6.7.E1`–`6.7.E16` |
| 6.8 | `6.8.E1`–`6.8.E3` |
| 6.9 | `6.9.E1` |
| 6.10 | `6.10.E1`–`6.10.E8` |
| 6.11 | `6.11.E1`–`6.11.E3` |
| 6.12 | `6.12.E1`–`6.12.E8` |
| 6.13 | `6.13.E1`–`6.13.E2` |
| 6.14 | `6.14.E1`–`6.14.E7` |
| 6.15 | `6.15.E1`–`6.15.E4` |
| 6.16 | `6.16.E1`–`6.16.E5` |
| 6.17 | none (applications prose) |
| 6.18 | `6.18.E1`–`6.18.E2` |
| 6.19 | none (tables/bibliography) |
| 6.20 | none (approximations bibliography) |
| 6.21 | none (software bibliography) |

Total: 100 numbered formulas. The expected, stated, and omitted sets in all
21 manifests agree exactly. The source/manual anchor sets cover every
numbered formula and every manifest declaration; definitions used as the
reader-facing statement (for example `principalEin`, `fRemainder`, and
`sineRemainder`) are displayed as complete declarations rather than hidden
behind a theorem alias.

## Verdict

**ACCEPT.** No P0 or P1 finding remains. The pages read as DLMF pages first,
with complete expandable Lean declarations adjacent to the source formulas.
The remaining `sorry`s are proof placeholders in the blueprint, as permitted
by the project phase, and are not presented as prose status claims.

## Global UX and object-first audit

- Chapter 6 uses canonical named maps (`principalE1`, `realEi`, `principalSi`,
  `principalCi`, `principalAuxiliaryF`, and `principalAuxiliaryG`) rather than
  repeatedly quantifying arbitrary function/value carriers.
- The genuinely persistent data are typed: cut-avoiding C¹ rays and sine-tail
  rays in §6.2, lifted branch paths in §6.4, principal-cut paths in §6.7,
  sector margins in §6.12, ordered positive-zero families in §6.13, and the
  right-half-plane domain in §6.18.
- Improper integration, path integration, principal values, series
  convergence, asymptotic order, and error control are separate interfaces.
  In particular, §6.18 now defines the A/B/C maps directly from the positive
  ray Bochner integrals and states convergence separately, rather than exposing
  repeated `Classical.choose` witnesses.
- §6.4 E3–E7 state half-turn limits at their canonical side values. §6.7 E12,
  E15, and E16 likewise state path integrals at the values fixed by the source
  identities. The two remaining existential `HasSum` targets in §6.10 E4 and
  E8 are justified exceptions: their displayed prefactors can vanish, so a
  globally canonical quotient-derived sum value would be misleading.
- §6.12 E5/E6 use named finite partial sums and named residuals as definitions;
  the substantive integral characterizations and error bounds are E7/E8, not
  tautological “definition plus itself” theorems.
- §6.13 keeps the source's ellipsis honest: the printed coefficient prefix is
  explicit, while a shared coefficient-continuation object carries the
  all-orders data used by both zero families. No false recurrence for omitted
  coefficients is invented.
- §6.16's `sawtoothValue` is a simple totalized sign map, but the theorem
  retains the exact source domain `-π < x < π`; the manual explicitly explains
  that outside-domain values are implementation totalization, not extra DLMF
  claims.

## Quantitative declarations

Distinct quantitative companions are present where the page supplies a
separate error statement:

- §6.12 E1: sector/first-neglected-term bounds and same-sign clause;
- §6.12 E2: the `χ(n+1)` next-term bound on the positive ray;
- §6.12 E7 and E8: phase-dependent remainder bounds and same-sign clauses;
- §6.13 E1: the 30-digit enclosure of the unique positive `Ei` zero; and
- §6.13 E2: the next-term absolute and same-sign remainder bound.

The numbered §6.16 E4 and E5 entries are themselves the source's separate
quantitative statements (remainder order and the Riemann-hypothesis error
order), while E3 and the logarithmic-integral definition provide the
qualitative objects they quantify. Identity, definition, graphics, table,
software, and method-survey entries correctly have no fabricated quantitative
panel.

## Non-formula source coverage

The manifests and pages preserve the source-linked notes, captions, and
prose candidates: notation and branch conventions, figure ranges/captions,
Olver provenance, continuation and asymptotic notes, physical-application
survey data, numerical-method descriptions, table records, approximation
references, and software records. No unreviewed numbered formula or
mathematically substantive non-formula candidate was found. The Chapter 6
coverage dry-run reports 100 formula overrides, 352 source-item overrides, and
16 explicit no-claim source rows.

## Rendered routes and hygiene

All 21 Chapter 6 routes are present under
`Exponential___-Logarithmic___-Sine___-and-Cosine-Integrals/___6___…/`, and
each manifest formula declaration has a rendered, module-qualified Lean
anchor. The generated page contains no stale `hankelTruncation` or Chapter 6
compatibility-witness block. No `#check`, `#eval`, TODO/FIXME, proof filler,
or forbidden `\[...\]` wrapper occurs in the Chapter 6 sources.

## Validation

- `lake env lean LMLF/Blueprint/ExponentialIntegrals.lean`: pass.
- From `doc/`, `lake build LMLFManual`: pass, 3690 jobs.
- From `doc/`, `lake exe lmlf-site`: pass; all 21 Chapter 6 routes generated.
- `node scripts/check_source_tex.mjs` on every TeX-bearing Chapter 6 source:
  pass for all expressions; prose-only pages correctly report no expressions.
- `node scripts/check_rendered_tex.mjs doc/_out/html-multi`: pass, all 864
  generated expressions accepted by KaTeX.
- `python3 scripts/validate_inventory.py`: pass.
- `python3 scripts/sync_chapter5_coverage.py --chapter 6 --first-section 1
  --last-section 21 --expected-formulas 100 --dry-run`: pass.

No source candidate remains unreviewed.
