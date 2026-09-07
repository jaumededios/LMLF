# Referee report: DLMF §5.18 (re-review)

## Snapshot and files reviewed

Snapshot: `f4176ce69852c435e838eeb0b6da69c510f81fef` (`docs: publish rebuilt
LMLF site`), with revised Section 5.18 files and parent-owned manual wiring in
the worktree.  I re-reviewed the official [DLMF §5.18 page](https://dlmf.nist.gov/5.18)
and E1--E12 TeX endpoints, the §5.18 source-inventory records,
`LMLF/Blueprint/Gamma/Section518.lean`,
`doc/LMLFManual/Chapter5/Section518.lean`,
`coverage/sections/chapter5-518.json`, the Chapter 5/manual aggregators, and
the generated highlighted/rendered declaration artifacts.  The generated site
was regenerated transiently and inspected before restoring generated outputs.

## Formula IDs and verdict

The independently recomputed numbered set is exactly:

`5.18.E1`, `5.18.E2`, `5.18.E3`, `5.18.E4`, `5.18.E5`, `5.18.E6`,
`5.18.E7`, `5.18.E8`, `5.18.E9`, `5.18.E10`, `5.18.E11`, `5.18.E12`.

The manifest has exact expected/stated equality and no omitted or extra
numbered IDs.  **Verdict: accept.** All prior P0/P1 issues are resolved: E7
now excludes totalized poles, pole conventions are explicit, q-Gamma prose
claims are represented or marked unformalized, the real/complex bridge is
present, and manual integration renders the complete declaration anchors.

## Prior findings and resolution

- **E7 P0 — resolved.** `dlmf_5_18_7` at
  `LMLF/Blueprint/Gamma/Section518.lean:181-187` now requires both
  `qGammaPoleFree q z` and `qGammaPoleFree q (z + 1)`.  At the former
  counterexample `z = 0`, `qGammaDenom q 0 = qPochhammerInf 1 q` has its
  `k = 0` factor equal to zero, so the first hypothesis is uninhabited.  The
  false totalized equality `qGamma q 1 = 0` cannot be instantiated.  The two
  nonzero denominator hypotheses are sufficient for the product shift and
  cancellation on `0 < q < 1`; the positive-base `Complex.cpow` branch has no
  additional branch ambiguity.
- **Pole/branch P1 — resolved.** The module docstring and manual introduction
  explicitly distinguish totalized field quotients (Lean returns `0` at a
  zero denominator) from the source meromorphic functions.  `qGammaDenom` and
  `qGammaPoleFree` are public vocabulary, E4/E10/E11 prose and manifest notes
  state the totalized-versus-meromorphic reading, and the manual records the
  principal `Complex.cpow` branch and positive Jackson sample points.
- **Missing q-Gamma prose P1 — resolved.** The manual and Lean source now
  include the source prose candidates: `dlmf_5_18_convexity` and
  `dlmf_5_18_bohr_mollerup`.  The subsequent asymptotic-expansion and
  q-digamma references are explicitly documented as mathematically
  substantive but unformalized, rather than silently omitted.
- **`qGammaReal` API P2 — resolved.**
  `qGammaReal_coe` now states, under `qGammaPoleFree`, that the real-part
  specialization coerces back to complex `qGamma`; E8/E9 prose and manifest
  notes point to this bridge.
- **Rendered integration P1 — resolved.** `doc/LMLFManual.lean` imports and
  includes `LMLFManual.Chapter5.Section518`.  A regenerated site contains a
  standalone `___5___18-q-Gamma-and-q-Beta-Functions` page, the separate
  convexity/Bohr--Mollerup page, and anchors displaying complete declarations
  including `dlmf_5_18_1`, `dlmf_5_18_7`, `qGammaReal_coe`, and
  `dlmf_5_18_bohr_mollerup` with namespace context.

## Formula-by-formula audit

- **E1:** accepted.  `Finset.range n` gives exactly `k=0,…,n−1`, including
  the empty product at `n=0`; complex `a,q` are retained.
- **E2:** accepted.  Nested ranges give the q-integer factors with the source
  indexing; `q ≠ 1` is the necessary reciprocal-domain condition.
- **E3:** accepted.  `HasProd` uses the source complex disk `‖q‖ < 1`, with
  arbitrary complex `a`; no q>1 convergence claim is made.
- **E4:** accepted as the documented real-base specialization.  Complex
  `z`, principal powers, products, and the totalized/pole-free distinction
  are all explicit.
- **E5:** accepted.  The values at `1` and `2` and `0 < q < 1` are retained.
- **E6:** accepted.  `n : ℕ` and the cast of `n+1` preserve the source
  nonnegative indexing.
- **E7:** accepted after the pole-free repair described above; the recurrence
  factor and principal positive-real-base power are correct.
- **E8:** accepted specialization.  `0 < q < r < 1` and exactly
  `0 < x < 1 ∨ x > 2` are retained via `qGammaReal`.
- **E9:** accepted specialization.  The inequality reversal and `1 < x < 2`
  interval are exact, with the real/complex bridge documented.
- **E10:** accepted.  `nhdsWithin 1 (Iio 1)` is the correct real one-sided
  limit; the totalized exceptional-value convention is explicit.
- **E11:** accepted specialization.  Complex `a,b`, real `0 < q < 1`, and
  the `a+b` quotient are exact, with pole semantics documented.
- **E12:** accepted specialization.  The Jackson sum, complex powers,
  q-Pochhammer factors, `0 < q < 1`, and `Re(a),Re(b)>0` hypotheses match.

No source caption, table, or graphic candidate occurs in this section.  The
non-numbered convexity and q-Bohr--Mollerup results are formalized; the
source's asymptotic and q-digamma references are explicitly identified as
unformalized.

## Specializations, quantitative pairs, manifest, and hygiene

The manifest's specialization labels are honest for the real q-Gamma/q-Beta
base, real-axis inequalities, and Jackson integral.  `qGammaDenom`,
`qGammaPoleFree`, `qGammaReal_coe`, convexity, and the q-Bohr--Mollerup result
are correctly listed as extra non-numbered statement IDs.  No display calls
for a distinct finite error estimate; all twelve quantitative analogue fields
remain `not_applicable`.  Anchors in Lean and manual source agree, and the
rendered page shows complete declarations.  No `#check`, filler status prose,
or proof work displacing statement coverage was found.  The remaining `sorry`s
are the permitted proof-pending placeholders.

## Verification

- `lake env lean LMLF/Blueprint/Gamma/Section518.lean`: **passed** (15
  expected `sorry` warnings, including the added support/prose statements).
- `lake build LMLF`: **passed** (3258 jobs).
- `lake env lean LMLFManual/Chapter5/Section518.lean`: **passed**.
- `lake build` from `doc/`: **passed** (6995 jobs).
- `lake exe lmlf-site`: **passed**; the regenerated standalone §5.18 page
  and convexity/Bohr--Mollerup page contained the inspected anchors.

No unreviewed numbered formula or substantive source candidate remains.  The
only intentionally unformalized source material is the explicitly documented
generalized q-Gamma asymptotics and q-digamma reference prose.
