# Referee report: DLMF §4.2 — Definitions

## Snapshot and files reviewed

Snapshot: `703f1ad1d96c360bbac555c43dc39f6ca64d1a7b`.  I reviewed the official
[DLMF §4.2 page](https://dlmf.nist.gov/4.2) and its E1–E37 displays (including
the two components of E31), the source-inventory records,
`LMLF/Blueprint/Elementary/Section42.lean`,
`doc/LMLFManual/Chapter4/Section42.lean`, and
`coverage/sections/chapter4-42.json`.  No rendered §4.2 page was available in
`doc/_out`.

## Independently computed formula set and verdict

The official numbered set is exactly `4.2.E1` through `4.2.E37`; E31 is a
single multi-part display.  The manifest expected/stated sets agree and no IDs
are omitted.

**Verdict: revise.** The page has multiple P0/P1 mathematical and API failures,
despite complete identifier bookkeeping.  Several declarations are tautologies
or false unrestricted propositions rather than formalizations of the displayed
mathematics.

## Findings

### P0 — branch and logarithm definitions are not represented

- **E1–E2, E6:** `generalLog` and `principalLog` are both defined as
  `Complex.log`.  Consequently E1/E2 are tautologies, while E6 asserts
  `Complex.log z = Complex.log z + 2*k*pi*I` for every integer `k`, which is
  false.  DLMF E1 defines the path integral/multivalued logarithm and E2 the
  principal path integral avoiding `(-∞,0]`; E6 adds the winding number term.
  Define readable general/principal objects or state honest branch-domain
  propositions, and do not label these declarations exact while the general
  branch is collapsed to the principal one.
- **E4:** `principalLog (x : ℂ) = (x : ℂ)` is a reflexive equality and does not
  express DLMF's cut convention `z=x`, `−∞<x<0`.  This is missing source
  mathematics and a decorative declaration.
- **E7:** the source gives both signed cut values
  `ln(x ± i0)=ln|x| ± iπ` for every `x<0`; the declaration gives only the
  upper value and has no lower-side statement.  The documentation claims both
  signs, so it is materially incomplete.

### P0 — general-base logarithm declarations are tautological or have wrong domains

- **E8:** `log z / log a = log z / log a` is reflexive and does not define
  `log_a z = ln z / ln a`; the hypotheses should reflect DLMF's `a,b ≠ 0,1`.
- **E9–E10:** the quotient identities use only `Complex.log` and insufficient
  hypotheses (`Complex.log b ≠ 0`), while field division silently totalizes
  poles and the displayed formulas require the relevant bases to be valid.
- **E14–E16:** E14 is `Complex.log z = Complex.log z`; E15 is the same quotient
  on both sides; E16 asserts cancellation without a nonzero `log 10` condition.
  None expresses the source's general-base notation or its definition.

### P0 — exponential series and phase declarations do not state the source

- **E19:** `exp z = 1 + z + z²/2 + z³/6 + 0` is a finite polynomial identity,
  not DLMF's infinite factorial power series.  Replace it with a `HasSum`
  statement over `n : ℕ`.
- **E23:** `arg (exp z) = Im z + 2*k*pi` for every `k : ℤ` is false for a
  principal `Complex.arg`; the source describes the general phase.  Use an
  existential/general-phase proposition or a clearly named multivalued phase.
- **E25:** the source says `exp z = ζ ↔ z = Ln ζ` for `ζ ≠ 0`; because `generalLog`
  is collapsed to the principal log, this loses all logarithm branches.

### P0 — power formulas have false unrestricted domains and proxy definitions

- **E26:** the `z ≠ 0` hypothesis is not reflected in the definition itself,
  and E27 claims the general complex power equals a natural power without the
  branch/domain conditions needed by DLMF.  Since `generalPower` is defined by
  the collapsed `generalLog`, this is not a valid general-power API.
- **E29–E31:** modulus and phase formulas are asserted for all `z`, including
  `z = 0`, where logarithmic/argument branch conventions require care.  E31's
  two components are present, but the page/manifest should identify them as the
  two parts of one multi-part display and state the needed domains explicitly.
- **E35:** the inverse-power assertion omits the branch/winding conditions and
  does not correctly express the DLMF equation's principal/general choices.
- **E36:** this is merely an implication whose antecedent is repeated in the
  conclusion; it does not state the source's principal-value phase restriction
  and is false as a universal characterization of arbitrary `a,w`.
- **E37:** `principalSqrt` is defined as `if 0 ≤ z.re then z else -z`, so the
  theorem is definitionally tautological rather than a square-root branch
  result.  It does not define or relate the principal square root to the
  principal power/logarithm and needs a mathematically meaningful API.

### P1 — branch-cut and source prose are overclaimed

The introduction says the closed-boundary branch convention is retained, but
the Lean declarations do not encode the open/closed phase ranges, path
avoidance, winding number, or both cut-side values.  The documentation groups
E2–E7 and E8–E18 under broad prose while several declarations are reflexive
placeholders.  The source also includes the branch-cut graphic/caption; if the
page does not reproduce it, the branch-cut geometry must at least be stated
precisely in mathematical prose rather than asserted as already formalized.

## Correctly handled portions and quantitative pairs

E3's principal-log expression is close to the source formula, E12–E13 capture
the natural-log base and integral characterization, E20–E22 and E24 capture
the periodicity, reciprocal identity, modulus, and Cartesian decomposition,
and E28 records the principal-power definition.  These need surrounding domain
and branch repairs before acceptance.  E31 is correctly split into two named
components, with no second quantitative analogue required by the source.

## Verification

`lake env lean LMLF/Blueprint/Elementary/Section42.lean` elaborates only because
all results use `sorry`; that build result does not mitigate the false and
tautological statements above.  Neither source file contains `#check`, but the
statement-coverage failures are substantive and require author revision.
