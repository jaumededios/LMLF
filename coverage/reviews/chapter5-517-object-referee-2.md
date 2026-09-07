# DLMF §5.17 object-first referee re-review

## Snapshot and files reviewed

Snapshot commit: `31b53f875c4884773698176b216809df59ea24a7` (current worktree
files reviewed; unrelated worktree changes are outside this audit).

Reviewed:

- official [DLMF §5.17](https://dlmf.nist.gov/5.17), including
  `5.17.E1.tex`–`5.17.E7.tex`;
- `coverage/dlmf-4-10-source-inventory.json`;
- `LMLF/Blueprint/Gamma/Section517.lean`;
- `doc/LMLFManual/Chapter5/Section517.lean`;
- `coverage/sections/chapter5-517.json`; and
- regenerated
  `doc/_out/html-multi/Gamma-Function/___5___17-Barnes___-G-Function-_LPAR_Double-Gamma-Function_RPAR_/index.html`.

## Coverage and verdict

Independent inventory extraction gives exactly:

`5.17.E1`, `5.17.E2`, `5.17.E3`, `5.17.E4`, `5.17.E5`, `5.17.E6`,
`5.17.E7`.

The manifest's expected and stated arrays are exactly equal to this list, with
no omissions. The source and manual each contain 22 anchors, and all 22 anchor
bodies match byte-for-byte after removing only their enclosing markers and
surrounding whitespace. The regenerated page contains all 22 corresponding
namespace-qualified anchor IDs.

**Verdict: ACCEPT.** No P0, P1, P2, or P3 finding remains in the assigned
source, manual, manifest, or regenerated §5.17 page.

## Regenerated-page checks

- `barnesGProductPartialProduct`, `barnesGProduct`,
  `barnesGProduct_hasProd`, and `barnesGProduct_partialProduct_tendsto` all
  render with external anchors.
- The `barnesG` definition and E3 value identity use the named
  `barnesGProduct`; the E3 value identity no longer expands to a raw `∏'`.
  The raw `∏'` remains only in the intentionally transparent definition of
  the named product object.
- The old `limUnder` definition is absent from the regenerated page. E7
  renders separate convergence and value declarations:
  `glaisherPartialExpression_tendsto` and `dlmf_5_17_7`, as two distinct
  anchored Lean code blocks in the Glaisher logarithm statement panel.
- The regenerated page retains all seven DLMF source links and displays the
  complete namespace-qualified declarations at the external anchors.

## Formula-by-formula audit

- **5.17.E1:** Correct recurrence with the explicit ordinary pole-free guard
  `∀ m : ℕ, z ≠ -(m : ℂ)` and separate `barnesG_one`; the manifest honestly
  marks this Mathlib-totalization specialization.
- **5.17.E2:** Correct `n ≥ 2` factorial product, with the empty product at
  `n = 2`.
- **5.17.E3:** Correct prefactor, factor syntax, lower index `k = 1`, named
  product value, semantic `HasProd`, and finite-prefix `Tendsto`.
- **5.17.E4:** Correct positive-real `x > 0` interval-path specialization;
  principal/continued-log behavior and the omitted general complex path are
  disclosed.
- **5.17.E5:** Correct positive-real `x → +∞` specialization of the source
  sector, including the Bernoulli sequence and source-index shift
  `k = n + 1`; Nemes error-bound/exponential-improvement references are
  retained as an unformalized gap.
- **5.17.E6:** Correct `A = exp C`; the displayed decimal remains prose and
  is not misrepresented as a numerical enclosure.
- **5.17.E7:** Correctly separates the finite renormalized sequence's
  convergence from the two zeta-derivative value identities and preserves the
  source lower limit `k = 1`.

## Object-first and quantitative discipline

Barnes product factors, prefactor, finite approximants, canonical product
value, `HasProd`, and finite-prefix convergence are distinct readable objects.
Glaisher's finite expression, canonical zeta-derivative value, convergence,
and exponential constant are likewise separate. Syntax/evaluation,
convergence, and value identities are not collapsed into opaque proxies.
Poincaré vocabulary is introduced in Chapter 2 before §5.17 uses it.

No genuinely distinct finite quantitative companion is required. The only
quantitative-looking material is DLMF's external E5 error-bound reference;
the manifest correctly records `quantitative_analogue: not_applicable` and the
manual records the omitted Nemes refinement.

## Verification

- `lake env lean LMLF/Blueprint/Gamma/Section517.lean`: **passed**, with 11
  intentional `sorry` warnings.
- From `doc/`, `lake env lean LMLFManual/Chapter5/Section517.lean`:
  **passed**.
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter5/Section517.lean`:
  **passed** (`KaTeX accepted all 7 source expressions`).
- `node scripts/check_rendered_tex.mjs doc/_out/html-multi`: **passed**
  (`KaTeX accepted all 862 generated expressions`).
- Independent parity check: `22` source anchors, `22` manual anchors, `22`
  exact body matches; inventory/manifest formula-ID equality: **passed**.
- No `#check`, `#eval`, filler status prose, or proof work displacing
  statement coverage was found.

## Unreviewed/non-substantive source candidates

The inventory's §5.17 annotation/reference metadata, E5 errata, E6 OEIS
“more digits” note, and bibliographic prose block `dlmf:5.17#p3` remain
non-substantive source candidates. They introduce no additional mathematical
claim requiring a Lean declaration; the mathematically substantive branch,
error-bound, and zeta-derivative prose is represented on the authored page.
