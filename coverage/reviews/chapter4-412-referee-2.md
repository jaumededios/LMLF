# Referee report: DLMF §4.12 (final audit after revision)

## Scope and files reviewed

I read the referee contract and the previous report, then reviewed the current
official [DLMF §4.12](https://dlmf.nist.gov/4.12), the revised
`LMLF/Blueprint/Elementary/Section412.lean`,
`doc/LMLFManual/Chapter4/Section412.lean`, and
`coverage/sections/chapter4-412.json`.

The official page has exactly the ten numbered displays 4.12.E1--E10.  The
manifest's expected and stated sets agree (`10/10`, with no omissions), and it
also records the iteration vocabulary, generalized-function interfaces,
monotonicity claim, and continuous-differentiability claim.

## Verdict: revise

The revision successfully addresses the prior tautology findings: the
generalized-function structures package the recurrence, normalizations,
branches, monotonicity, and regularity as reusable data, while E2--E9 state
the source equations directly as projections of those interfaces.  The
monotonicity and `ContDiff` claims are present in both Lean and the manual,
with matching anchors and manifest entries.  E1--E9 retain the source domains,
branches, floors, positive integer conditions, and half-open interval
inequalities.

There is nevertheless a P0 correctness failure in E10, and a P1 source/API
gap concerning the asserted inverse relationship.  Therefore this revision
cannot be accepted.

## Formula-by-formula audit

- **E1:** `-1 < x` and the recurrence `φ (x+1) = exp (φ x)` are direct and
  correctly readable.
- **E2:** The origin normalization is a direct projection from
  `GeneralizedExponential.zero`, not a self-fulfilling theorem hypothesis.
- **E3:** The all-real logarithm shift relation is direct from
  `GeneralizedLogarithm.shift`.
- **E4:** The logarithm origin normalization is a direct structure field.
- **E5:** The closed interval `[0,1]` is represented by `Icc`, and both
  identity equations are directly stated.  The current interface forces this
  identity data for every packaged function, which is coherent with the
  selected simplest choice.
- **E6:** The exact branch `-1 < x < 0` and `Real.log (x+1)` are retained.
- **E7:** The `x > 1` domain, natural floor, fractional part, and explicit
  natural-number iteration of `Real.exp` are retained.
- **E8:** The negative-half-line branch `Real.exp x - 1` is direct and has the
  correct domain.
- **E9:** The positive integer witness and explicit iterated logarithm are
  directly exposed by the generalized-logarithm interface.
- **E10:** The statement preserves `x > 1`, `0 < l`, and the half-open
  condition `0 ≤ iteratedLog l x < 1`, but its uniqueness claim is invalid for
  the chosen totalized iteration.

## Findings

### P0 — E10 uniqueness is false for totalized `Real.log`

`iteratedLog` is an unrestricted iteration of Mathlib's totalized `Real.log`.
Take `x = exp (exp 1)`.  Then the iterates are

```
iteratedLog 2 x = 1
iteratedLog 3 x = 0
iteratedLog 4 x = Real.log 0 = 0
```

so both positive integers `l = 3` and `l = 4` satisfy the displayed
half-open condition.  Consequently
`dlmf_4_12_10`'s `∃! l` proposition is false as written, despite elaborating
with `sorry`.  The source's iteration count must be represented with a
positivity/domain guard (or a first-hit/minimality condition, or a partial
iterated-log interface) so that iteration stops before totalization at zero
can create duplicate witnesses.

### P1 — The claimed inverse relationship is not represented

The manual says that `ψ` is the inverse of `φ`, but
`GeneralizedExponential` and `GeneralizedLogarithm` are independent structures
and no declaration relates their `toFun`s by either inverse-composition
identity (or an equivalent paired-interface field).  E5--E9 can therefore be
instantiated with unrelated functions satisfying separately packaged fields.
Either add the inverse relation to a paired generalized-function interface (and
use it in the prose/API), or weaken the prose so it does not assert an
unrepresented inverse.  The source's surrounding non-uniqueness context for
generalized exponentials should likewise be stated rather than implying that
the packaged identity choice is canonical.

## Prose, anchors, manifest, and verification

The manual has DLMF links and reader-facing displays for all E1--E10.  The
revised explanatory prose explicitly mentions strict increase on `[0,1]` and
continuous differentiability, and the two corresponding statements are
anchored and listed in the manifest.  Anchors are module-qualified and the
source contains no `#check` or filler/status prose.  The public iteration
definitions are transparent and are used by E7, E9, and E10.

`lake env lean LMLF/Blueprint/Elementary/Section412.lean` succeeds with only
the expected `sorry` warnings.  The standalone manual source also builds via
`cd doc && lake env lean LMLFManual/Chapter4/Section412.lean`.  These builds do
not discharge the false E10 proposition, since all theorem proofs remain
`sorry`.

No quantitative companion is needed for this qualitative section.  Once E10's
totalization/uniqueness issue and the inverse-interface/source-prose gap are
repaired, a further audit should be able to reconsider acceptance.
