# Referee report: DLMF §5.16

## Re-review snapshot and files

Review snapshot remains `f4176ce` (`docs: publish rebuilt LMLF site`), branch
`site/verso-dlmf-overlay`, with revised uncommitted author files in the
assigned worktree.  Re-reviewed:

- the official [DLMF §5.16 Sums](https://dlmf.nist.gov/5.16) page and its E1/E2
  displays, symbol notes, and prose;
- the §5.16 records in `coverage/dlmf-4-10-source-inventory.json`;
- `LMLF/Blueprint/Gamma/Section516.lean`;
- `doc/LMLFManual/Chapter5/Section516.lean`;
- `coverage/sections/chapter5-516.json`;
- `doc/LMLFManual/Chapter5.lean` and the committed
  `doc/_out/html-multi` tree; and
- the pinned Mathlib summation-filter definitions and generated highlighted
  artifact `.lake/build/highlighted/LMLF/Blueprint/Gamma/Section516.json`.

The prior P0 convergence finding is resolved.  Chapter 5 site registration is
parent-owned integration work and is intentionally not scored as a finding in
this re-review; the committed site remains unchanged until that parent-owned
work is performed.

## Independently computed coverage set

The official DLMF page and source inventory contain exactly:

`5.16.E1`, `5.16.E2`.

The manifest states exactly this set, with no omissions or extras.  Neither
display has a distinct quantitative companion.

## Verdict: accept

Both numbered displays are now modeled with the appropriate summation
semantics, the documentation explains the conditional-versus-unconditional
choice, the manifest records it, and all assigned source files elaborate.  No
P0/P1 issue remains in the section deliverables.  The eventual Chapter 5
registration and generated-page check remain parent-owned integration work.

## Formula-by-formula audit

- **5.16.E1 — accepted.**  The display
  `∑_{k=1}^∞ (-1)^k ψ'(k) = -π²/8` is reproduced with the correct source link
  and value.  `LMLF/Blueprint/Gamma/Section516.lean:28-34` now uses
  `HasSum (L := SummationFilter.conditional {n : ℕ // 1 ≤ n})`.  In pinned
  Mathlib, `conditional` on an ordered, locally finite type with an order bot
  is the filter of finite lower intervals (`Finset.Iic`); the positive-natural
  subtype has order bot `1`, so these are exactly the ordinary partial sums
  over `k = 1, …, N`.  This is the correct ordered semantics for the
  conditionally convergent alternating trigamma series.  The highlighted
  declaration signature confirms the explicit conditional filter.
- **5.16.E2 — accepted.**  The display
  `∑_{k=1}^∞ k⁻¹ ψ'(k+1) = ζ(3) = -ψ''(1)/2` is reproduced at
  `LMLF/Blueprint/Gamma/Section516.lean:39-46` and
  `doc/LMLFManual/Chapter5/Section516.lean:51-69`.  Its ordinary default
  `HasSum` is appropriate because the reciprocal-weighted trigamma terms are
  absolutely convergent (order `1/k²`), so unconditional and ordered sums
  agree.  The conjunction preserves both equalities in the source chain.

For both displays, `{n : ℕ // 1 ≤ n}` exactly models the lower limit `k = 1`.
The E2 denominator is nonzero on this subtype, and the `k + 1` argument is
formed in `ℕ` before its cast to `ℂ`.  No source domain, branch, or limiting
condition is lost.  The local `polygamma` vocabulary is explicitly identified
as the iterated derivative of the digamma function introduced in §5.15.

## Correct specializations and quantitative pairs

- The positive-natural subtype is an exact index modeling of both source
  ranges, not an unannounced summand specialization.
- E1 is exact with ordered conditional summation; the manual and manifest both
  state that choice honestly.
- E2 is exact with ordinary default `HasSum`; absolute convergence justifies
  its ordering independence.
- No quantitative analogue is present or needed: the source contains two exact
  identities and no truncation bound or enclosure.

## Manifest, anchors, prose, and hygiene

`coverage/sections/chapter5-516.json` has equal expected/stated ID sets,
correct fully qualified names, `relation: exact` for both entries, and a
manifest note for E1's conditional ordered partial sums.  Lean anchors
`dlmf_5_16_1` and `dlmf_5_16_2` and the matching manual anchors agree
one-for-one.  Each source anchor ends before its proof body, and the generated
highlighted artifact exposes the complete declarations with module-qualified
names.

The section introduction now distinguishes E1's conditional ordered series
from E2's absolutely convergent default `HasSum`; the per-entry prose retains
the source formulas, lower limit, functions, and constants.  The DLMF notes and
trailing prose are bibliographic pointers rather than omitted mathematical
claims.  No `#check`, filler status prose, or proof work displacing statement
coverage is present.

## Verification

- `lake build LMLF` from the repository root: **passed** (2929 jobs; only
  pre-existing `sorry` warnings elsewhere).
- `lake env lean LMLF/Blueprint/Gamma/Section516.lean`: **passed**, with the
  two intentional `sorry` warnings.
- `cd doc && lake env lean LMLFManual/Chapter5/Section516.lean`: **passed**.
- `cd doc && lake build`: **passed** (6304 jobs; only expected project
  `sorry` warnings).
- The highlighted artifact contains both declarations and explicitly records
  `SummationFilter.conditional` in E1's type.

Unreviewed parent-owned integration artifact: the committed
`doc/_out/html-multi` tree still has no standalone §5.16 page or interactive
anchor because `Chapter5.lean` has not yet registered this section.  Once the
parent integrates it, regenerate the site and confirm the two already-checked
anchors render there.
