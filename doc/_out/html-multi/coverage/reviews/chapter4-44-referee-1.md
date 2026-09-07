# Referee report: DLMF §4.4 — Special Values and Limits

## Snapshot and files reviewed

Snapshot: `703f1ad1d96c360bbac555c43dc39f6ca64d1a7b`.  I independently reviewed
the official [DLMF §4.4 page](https://dlmf.nist.gov/4.4) and E1–E19 source
displays, the §4.4 inventory records, `LMLF/Blueprint/Elementary/Section44.lean`,
`doc/LMLFManual/Chapter4/Section44.lean`, and
`coverage/sections/chapter4-44.json`.  No rendered §4.4 page was present in
`doc/_out` to inspect.

## Independently computed formula set and verdict

The official source and inventory contain exactly:

`4.4.E1`, `4.4.E2`, `4.4.E3`, `4.4.E4`, `4.4.E5`, `4.4.E6`, `4.4.E7`,
`4.4.E8`, `4.4.E9`, `4.4.E10`, `4.4.E11`, `4.4.E12`, `4.4.E13`, `4.4.E14`,
`4.4.E15`, `4.4.E16`, `4.4.E17`, `4.4.E18`, `4.4.E19`.

The manifest has exact expected/stated equality and no omissions.

**Verdict: accept.** No P0 or P1 finding remains. Every display has its DLMF
link, mathematical prose, and a corresponding anchored Lean declaration.

## Formula-by-formula audit

- **E1–E3:** The principal-logarithm value at `1`, the two one-sided boundary
  values at `−1 ± i0`, and the values at `±i` are all retained.  E2 uses the
  right-hand filter `𝓝[>] 0` for each approach and preserves the signs `±πi`.
- **E4–E11:** The zero, half-turn, quarter-turn, integral-turn, sixth-turn,
  third-turn, eighth-turn, and three-eighths-turn exponential values preserve
  both signs and all real/imaginary components.  The integer parameter in E7
  is `k : ℤ`; the square-root and principal complex-power conventions are
  explicit in the page prose and Lean expressions.
- **E12:** The principal complex powers at `i` and `−i` give the two real
  exponentials `e^{∓π/2}` with the correct signs.
- **E13–E15:** The positive-real paths and limits at `+∞`/`0⁺` are expressed
  using `atTop` and `𝓝[>] 0`.  E13 and E14 retain `Re a > 0`; E15 correctly
  permits arbitrary complex `a`.
- **E16:** The source sector condition
  `|ph z| ≤ π/2 − δ`, `δ ∈ (0,π/2]`, is retained by hypotheses
  `0 < δ` and `δ ≤ π/2`.  The declaration follows one boundary ray, and both
  the prose and manifest honestly label this as a sectorial specialization,
  rather than claiming the full two-dimensional sector limit.
- **E17–E18:** The complex sequence limit for fixed `z : ℂ` and the real
  `z = 1` specialization are correctly separated, with natural-number
  indexing and `atTop`.
- **E19:** The harmonic sum is indexed by `k ∈ Icc 1 n`, exactly matching
  `k = 1,…,n`, and converges to `Real.eulerMascheroniConstant`.

## API, anchors, and manifest

The declarations use canonical `Complex.log`, `Complex.exp`, complex powers,
`Tendsto`, `atTop`, and the one-sided neighborhood filter.  No opaque wrapper
predicates replace the displayed mathematics.  The source anchors are unique,
module-qualified, and stop before the proof bodies; all declarations elaborate
with the permitted `sorry`s.  E16 is the only genuine specialization, and the
manifest labels E13–E16 and E18 according to their positive-real or ray-path
specialization.  No distinct quantitative companion is supplied by DLMF.

## P2/P3 notes

No P2 issue affects usability or source fidelity.  As a P3 polish item, E19's
prose omits DLMF's optional ten-decimal numerical approximation to Euler's
constant; the exact limiting identity and named constant are present, so this
does not affect coverage.

## Verification and remaining gaps

`lake env lean LMLF/Blueprint/Elementary/Section44.lean` passes with the 19
expected `sorry` warnings.  Neither source file contains `#check`, filler
status prose, or displaced proof work.  No mathematically substantive source
candidate beyond E1–E19 was found; rendered HTML could not be inspected because
the §4.4 output page was absent from the worktree.
