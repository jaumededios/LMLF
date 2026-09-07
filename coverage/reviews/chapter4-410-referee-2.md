# DLMF §4.10 final referee review

## Snapshot and files reviewed

- Snapshot: `7d39f17cef5d56ab37efd6ab9e607fff60f9d7a1` (current revised
  workspace).
- Official source: [DLMF §4.10](https://dlmf.nist.gov/4.10), including E1–E13,
  endpoint conventions, the E7 Cauchy-principal-value note, and the complex
  Gaussian condition.
- Prior review: `coverage/reviews/chapter4-410-referee-1.md`.
- Lean source: `LMLF/Blueprint/Elementary/Section410.lean`.
- Documentation: `doc/LMLFManual/Chapter4/Section410.lean`.
- Manifest: `coverage/sections/chapter4-410.json`.

## Independent coverage and verdict

The official source and inventory contain exactly `4.10.E1` through
`4.10.E13`. The manifest expected/stated sets still agree exactly, with no
omissions or extras.

**Verdict: accept.** The prior P0/P1 findings are resolved. E7 now exposes a
genuine symmetric-cutoff Cauchy principal-value limit, and E9/E10 carry the
nonzero and principal-log branch-domain conditions needed by their derivative
statements.

## Resolution and formula audit

- **E1–E4:** The derivative statements use `HasDerivAt`, retain nonzero
  arguments, and exclude the nonpositive-real principal-log cut through
  `im ≠ 0 ∨ 0 < re`. E3 retains the integer condition `n ≠ -1`.
- **E5–E6:** The interval integrals use the positive interval `(0,1)` and the
  stated values `−π²/6` and `−π²/12`.
- **E7:** `logarithmicIntegral` is defined by the symmetric cutout

  `∫(0,1−ε) 1/log t + ∫(1+ε,x) 1/log t`

  and `dlmf_4_10_7` states its `Tendsto` to the named value as positive
  `ε → 0`, under `x > 1`. This is a substantive CPV characterization rather
  than an unfolding equality; the interior singularity at `t=1`, the two
  matching cutoffs, and the endpoint regime are visible in the proposition and
  prose.
- **E8:** The exponential antiderivative correctly requires `a ≠ 0`.
- **E9:** The theorem now requires `a,b ≠ 0`, a nonzero logarithm argument, and
  `im ≠ 0 ∨ 0 < re` for that argument. This is the exact principal-log slit
  domain needed for the displayed `HasDerivAt` specialization.
- **E10:** The theorem separately guards the rational denominator and the
  half-exponential logarithm argument, and supplies the same off-cut principal
  branch condition for the latter. The resulting derivative matches the
  source quotient.
- **E11:** The complex Gaussian keeps `Re c > 0` and principal complex square
  root notation.
- **E12–E13:** The Bose and Fermi improper integrals retain their source
  endpoints and values.

All thirteen source links, displays, ordinary-language explanations, and
module-qualified anchors are present. No declaration is an opaque proxy, and
no second quantitative declaration is warranted by this section.

## Specializations and remaining source candidates

E1–E4 and E8–E10 are honestly marked principal-branch/derivative
specializations. E5–E6 and E12–E13 preserve real interval domains; E11
preserves the complex Gaussian domain. E7's real-positive CPV limit is marked
as a specialization while retaining the source's symmetric interpretation.
No tables, figures, or additional substantive prose candidates remain
unrepresented.

## Verification

- `lake env lean LMLF/Blueprint/Elementary/Section410.lean`: passed, with 13
  permitted `sorry` warnings.
- From `doc/`, `lake env lean LMLFManual/Chapter4/Section410.lean`: passed.
- Formula count: 13 expected / 13 stated / 0 omitted.
- Neither source contains `#check`, filler status prose, or proof work that
  displaces statement coverage.
