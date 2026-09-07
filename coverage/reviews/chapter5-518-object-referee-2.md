# Referee report: DLMF §5.18 object-first re-review

## Snapshot and files reviewed

Snapshot: `31b53f875c4884773698176b216809df59ea24a7`, with the repaired §5.18
files in the worktree.  I reviewed the official [DLMF §5.18
page](https://dlmf.nist.gov/5.18) and E1--E12 TeX endpoints,
`coverage/dlmf-4-10-source-inventory.json`,
`LMLF/Blueprint/Gamma/Section518.lean`,
`doc/LMLFManual/Chapter5/Section518.lean`, and
`coverage/sections/chapter5-518.json`.  Stale generated whole-site HTML was
not used for the source/API verdict.

## Independently computed formula IDs

The source inventory independently yields exactly:

`5.18.E1`, `5.18.E2`, `5.18.E3`, `5.18.E4`, `5.18.E5`, `5.18.E6`,
`5.18.E7`, `5.18.E8`, `5.18.E9`, `5.18.E10`, `5.18.E11`, `5.18.E12`.

The manifest expected and stated sets are byte-for-byte equal to this set, with
no omissions.  Its extra IDs use the repaired `5.18.qGammaDenomNeZero` name.

## Verdict: accept

Both prior P2 findings are repaired.  `qGammaDenomNeZero` is now honestly a
denominator-only guard, `QGammaPoint` carries the complete source base range
and that guard, and `qBeta_jackson_hasSum` is independent of `QBetaPoint` and
the later value identity.  The twelve numbered formulas and substantive prose
claims remain faithfully represented.

## Repair verification

### Domain objects

`LMLF/Blueprint/Gamma/Section518.lean:55-63` defines
`qGammaDenomNeZero` solely as `qGammaDenom q z ≠ 0`, and its docstring says
explicitly that it is not the complete source domain.  The complete
`QGammaPoint q z` at lines 78--83 carries `0 < q`, `q < 1`, and the guard.
This is mathematically the correct ordinary finite q-Gamma domain for the
real-base specialization: convergence and nonzero numerator/power factors
follow in the source base range, while the denominator guard excludes poles.

`QBetaPoint q` at lines 122--129 packages the three finite q-Gamma arguments
`a`, `b`, and `a+b`; `qBetaValue` consumes this object.  This is a readable,
explicit finite-value interface rather than an existential witness or opaque
`Classical.choose` construction.

### Convergence/value separation

`qGamma_products_hasProd` remains independent of `QGammaPoint`, taking only
`0 < q < 1` and an arbitrary complex `z`.  The repaired
`qBeta_jackson_hasSum` at lines 274--280 takes explicit `{q : ℝ} {a b : ℂ}`
and exactly `0 < q`, `q < 1`, `0 < a.re`, and `0 < b.re`; it no longer requires
the q-Beta value witness.  The separate E12 theorem at lines 284--289 uses
`QBetaPoint` and proves the value identity.  Thus product/sum convergence and
value identities are distinct declarations with reusable convergence APIs.

## Formula-by-formula fidelity

- **E1:** exact finite product, with complex `a,q` and `n : ℕ` (including the
  empty product).
- **E2:** exact q-factorial identity; `q ≠ 1` correctly accompanies the Lean
  reciprocal form.
- **E3:** named term/product objects followed by `HasProd` under `‖q‖ < 1`.
- **E4:** honest real-base (`0 < q < 1`) specialization with principal
  `Complex.cpow` and explicit totalized-quotient semantics.
- **E5--E7:** values, factorial relation, and recurrence use the readable
  pole-free `QGammaPoint` interface; E7 guards both shifted arguments.
- **E8--E9:** exact qualitative pair, preserving `0 < q < r < 1` and the
  disjoint real-axis regimes `0<x<1 ∨ x>2` and `1<x<2`.
- **E10:** correct real one-sided filter `nhdsWithin 1 (Iio 1)` for
  `q → 1⁻`, with totalized exceptional-value convention documented.
- **E11:** exact q-Beta quotient shape, with complex parameters and an honest
  real-base specialization.
- **E12:** exact Jackson integrand, summand, base range, and both
  `Re(a), Re(b) > 0` hypotheses; its convergence declaration is now separate.

The q-Gamma convexity and q-Bohr--Mollerup prose claims are represented by
`dlmf_5_18_convexity` and `dlmf_5_18_bohr_mollerup`.  The q-digamma and
generalized q-Gamma asymptotic references are explicitly identified as
unformalized.  No source table, caption, or graphic carries an additional
unreviewed mathematical claim.  No numbered formula calls for a quantitative
error companion; E8/E9 are a distinct qualitative pair.

## Panels, anchors, and hygiene

Every custom declaration is shown before later use in both focused files:
finite/infinite products precede q-Gamma objects; denominator guard precedes
`QGammaPoint`; q-Beta objects precede E11; Jackson definitions precede the
independent `HasSum` and E12.  The 33 Lean anchors and 33 manual anchor blocks
have identical declaration text after omitting proof bodies (`:= by sorry`).
All declarations are mapped under the current names in the manifest.  No
`#check`, `Classical.choose`, filler status prose, or displaced proof work is
present in the focused source/manual files.

## Verification

- `lake env lean LMLF/Blueprint/Gamma/Section518.lean`: **passed**; only the
  permitted `sorry` warnings and the existing unused proof-parameter linter
  warning for `qGammaValue`.
- `cd doc && lake env lean LMLFManual/Chapter5/Section518.lean`: **passed**.
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter5/Section518.lean`:
  **passed** (14 expressions).
- `node scripts/check_rendered_tex.mjs doc/_out/html-multi`: **passed** (864
  expressions); this is only a TeX sanity check because generated HTML is
  stale for source/API purposes.
