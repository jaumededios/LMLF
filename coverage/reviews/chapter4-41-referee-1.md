# Referee report: DLMF §4.1 — Special Notation

## Snapshot and files reviewed

Snapshot: `703f1ad1d96c360bbac555c43dc39f6ca64d1a7b`.  I reviewed the official
[DLMF §4.1 page](https://dlmf.nist.gov/4.1), the §4.1 records in
`coverage/dlmf-4-10-source-inventory.json`,
`LMLF/Blueprint/Elementary/Section41.lean`,
`doc/LMLFManual/Chapter4/Section41.lean`, and
`coverage/sections/chapter4-41.json`.  No rendered §4.1 page was present in
`doc/_out` to inspect.

## Independently computed coverage and verdict

The inventory contains no numbered formulas in §4.1.  The source has one
notation table and the surrounding prose describing the complex-function
families and naming conventions.  The manifest's empty expected/stated/omitted
formula sets are therefore correct.

**Verdict: accept.**  No P0 or P1 finding remains.  The page preserves the
table rows, complex-coordinate convention, natural-logarithm base, elementary
function families, and the lowercase/uppercase and `arc`/`−1` naming caveats.

## Source-fidelity audit

- The table maps `k,m,n` to integers, `a,c` to real or complex constants,
  `x,y` to real variables, `z=x+iy` to a complex variable, and `e` to the
  natural-logarithm base.  The corresponding Lean declarations are useful
  domain vocabulary, coordinate projections, and positivity of `exp 1`, rather
  than opaque function aliases.
- The documentation explicitly distinguishes the real-input background from
  the chapter's extension to complex arguments and lists logarithmic,
  exponential, circular, inverse circular, hyperbolic, and inverse hyperbolic
  families as in the source.
- The prose preserves the source warning that `ln`/`Ln` and lowercase/uppercase
  inverse-function names can be interchanged in the literature, and that an
  index `−1` may replace `arc`.
- `ComplexFunction := ℂ → ℂ` is a small reusable shared-domain abbreviation;
  it does not claim to define the later elementary functions.

## Specializations and quantitative pairs

There are no quantitative statements or numbered equations in this notation
section.  `RealOrComplexConstant := ℂ` is an honest representation of a value
that may be real or complex, with real values inserted by coercion.  The
coordinate and `e = exp 1` declarations are exact formalizations of the table.

## P2/P3 notes

### P2 — proof-state display flags

The manual's external anchors use `-showProofStates`.  This does not change the
mathematical statements or coverage, but it exposes proof-state rendering in a
notation page and is unnecessary for these declarations.  If the author wave
adopts the cleaner anchor convention, remove the flag from the anchors in
`doc/LMLFManual/Chapter4/Section41.lean`.

No P3 issue is material to source fidelity.  Neither source file contains
`#check`, filler status prose, or displaced proof work.

## Verification

`lake env lean LMLF/Blueprint/Elementary/Section41.lean` passes with the three
expected `sorry` warnings.  The manifest and source inventory agree on the
empty numbered-formula set.  The only unreviewed artifact is rendered HTML,
which was not available in the worktree.
