# Referee report: DLMF §5.15

## Snapshot and files reviewed

Review snapshot: `f4176ce` (`docs: publish rebuilt LMLF site`), branch
`site/verso-dlmf-overlay`, with the shared integration edits uncommitted in the
worktree.  No unrelated committed source was changed by this review.

Reviewed independently:

- DLMF [§5.15 Polygamma Functions](https://dlmf.nist.gov/5.15), including its
  section prose and the E1–E9 displays;
- `coverage/dlmf-4-10.json` source-inventory rows for `5.15.E1` through
  `5.15.E9`;
- `LMLF/Blueprint/Gamma/Section515.lean`;
- `doc/LMLFManual/Chapter5/Section515.lean`;
- `coverage/sections/chapter5-515.json`; and
- `doc/LMLFManual/Chapter5.lean` and the generated `doc/_out/html-multi`
  tree for page registration and anchors.

## Independently computed coverage set

The source inventory and the official DLMF page contain exactly these numbered
records in §5.15:

`5.15.E1`, `5.15.E2`, `5.15.E3`, `5.15.E4`, `5.15.E5`, `5.15.E6`,
`5.15.E7`, `5.15.E8`, `5.15.E9`.

The authored manifest states exactly the same set, with no omissions or extra
numbered records.  No quantitative pair is present or required.

## Verdict: accept

The nine statements are source-faithful, the Lean module elaborates with the
declared `sorry`s, and the shared integration now renders §5.15 with all nine
source links and namespace-qualified external anchors.  The E8/E9 Bernoulli
tail repair is also correct: both term functions now map zero-based `k=2` to
`B₂`, and E9 at `n=1` recovers the E8 term sequence.  No P0/P1 finding remains.

## Findings

The previous P0 on E8/E9 indexing is resolved in
`LMLF/Blueprint/Gamma/Section515.lean:38-56`: the `else` branches use
`j := k - 1`, giving `B₂/x³` at E8 term index `k=2` and
`((n+1)!/(2!) * B₂)/x^(n+2)` at E9 term index `k=2`.  Substituting `n=1`
gives exactly the E8 term sequence.  No current actionable finding remains.

## Non-formula source prose

The page retains the substantive definition (successive derivatives of the
digamma function), identifies trigamma, and explains the positive-real
specialization of E8/E9.  DLMF's additional tetra-/penta-/hexagamma names and
its observation that the properties follow by differentiation are terminology
and orientation rather than independent mathematical claims; their omission
does not warrant a finding.

## Formula-by-formula audit

All nine entries below have the correct DLMF link and corresponding source
display, and all nine Lean statements align mathematically after the E8/E9
repair.

- **5.15.E1 — clear.** `dlmf_5_15_1` in
  `LMLF/Blueprint/Gamma/Section515.lean:60` uses `HasSum` for
  `1 / (k + z)^2`, with `∀ k : ℕ, z ≠ -(k : ℂ)`, exactly excluding
  `0,-1,-2,...` and retaining convergence plus value.
- **5.15.E2 — clear.** `dlmf_5_15_2` at line 70 has
  `(-1)^(n+1) * n! * ζ(n+1)` and `1 ≤ n`, matching the section-wide
  `n=1,2,...` convention.
- **5.15.E3 — clear.** `dlmf_5_15_3` at line 79 has the same sign/factorial
  and the correct odd-part factor `2^(n+1)-1` at `1/2`.
- **5.15.E4 — clear.** `dlmf_5_15_4` at line 89 uses
  `Finset.Ico 1 n`, hence exactly `k=1,...,n-1`; the natural subtraction
  `2*k-1` is safe on that range and the empty sum at `n=1` is preserved.
- **5.15.E5 — clear.** `dlmf_5_15_5` at line 101 has the correct recurrence
  correction `(-1)^n n! / z^(n+1)` and excludes all nonpositive integer poles.
- **5.15.E6 — clear.** `dlmf_5_15_6` at line 111 has the correct
  `(-1)^(n-1)` left-hand factor and `(-1)^n π dⁿ(cot(πz))/dzⁿ` right-hand
  side.  Excluding every integer is the union of the cotangent and both
  polygamma pole sets; `cotPiDerivative` exposes the derivative rather than
  hiding it in a certificate.
- **5.15.E7 — clear.** `dlmf_5_15_7` at line 121 has the correct factor
  `m^(-(n+1))`, range `0,...,m-1`, and positive `m,n` hypotheses.  The single
  condition that `m*z` avoid nonpositive integers also excludes every
  translated summand pole.
- **5.15.E8 — clear.** `dlmf_5_15_8` at line 134 records the positive-real
  specialization; `trigammaAsymptoticTerm` now yields `1/x`, `1/(2x²)`, and
  `B₂/x³` at its first three zero-based indices, followed by the correct
  Bernoulli tail.
- **5.15.E9 — clear.** `dlmf_5_15_9` at line 142 has the correct overall sign,
  factorial terms, and Bernoulli tail; its `k=2` term is
  `((n+1)!/(2!) * B₂)/x^(n+2)`, and `n=1` agrees with E8.

The `realPolygamma` real-part wrapper is transparent and the page labels E8/E9
as positive-real specializations; no separate quantitative declaration is
claimed.  The local polygamma family should remain section-local until a second
consumer justifies a shared API extraction.

## Manifest, declarations, and hygiene

`coverage/sections/chapter5-515.json` names the correct nine declarations,
marks E8/E9 as specializations, records no quantitative analogue, and honestly
records all nine proofs as pending.  Anchor labels in the Lean and manual
files agree one-for-one.  No `#check`, filler status prose, or proof attempt
displacing statement coverage was found; the only proof placeholders are the
nine intentional `sorry`s.

## Verification

- `lake build LMLF.Blueprint.Gamma.Section515` (repository root): **passed**;
  only the expected `sorry` warnings (plus the pre-existing series warning).
- `lake build` (repository root): **passed** on retry after one transient
  parallel-artifact race; the retry built all 3265 jobs successfully.
- `cd doc && lake env lean LMLFManual/Chapter5/Section515.lean`: **passed**;
  this directly elaborates the standalone manual source.
- `cd doc && lake build`: **passed**, including the registered Section515
  manual module.
- `cd doc && lake exe lmlf-site`: **passed**.  The rendered page is
  `doc/_out/html-multi/___5___15-Polygamma-Functions/index.html`; each of the
  nine DLMF source links and each namespace-qualified anchor
  `LMLF___Blueprint___Gamma___Section515___dlmf_5_15_1` through
  `..._9` occurs exactly once, and the rendered declarations include the full
  theorem signatures and `sorry` diagnostics.  Rendering/integration passes,
  but it does not mask the E8/E9 term-index defect above.

Unreviewed source candidate: none.
