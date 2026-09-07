# Referee report: DLMF §5.18 — re-review

## Snapshot and files reviewed

Re-review snapshot remains `f4176ce69852c435e838eeb0b6da69c510f81fef`
(`docs: publish rebuilt LMLF site`), with the revised author files uncommitted
in the worktree. I reviewed the official [DLMF §5.18 q-Gamma and q-Beta
Functions](https://dlmf.nist.gov/5.18) page and its twelve displays, source
inventory, revised manifest, revised Lean and manual section files, the revised
Chapter 5 integration (`LMLF.lean`, `doc/LMLFManual.lean`, and
`doc/LMLFManual/Chapter5.lean`), the highlighted artifact, and the regenerated
HTML output.

## Independently computed coverage set

The official source and `coverage/dlmf-4-10-source-inventory.json` contain
exactly:

`5.18.E1`, `5.18.E2`, `5.18.E3`, `5.18.E4`, `5.18.E5`, `5.18.E6`,
`5.18.E7`, `5.18.E8`, `5.18.E9`, `5.18.E10`, `5.18.E11`, `5.18.E12`.

`coverage/sections/chapter5-518.json` states exactly this numbered set, with no
omissions or extras. Its four extra source IDs cover the pole-free vocabulary,
the real-axis bridge, convexity, and the q-Bohr–Mollerup characterization. No
source display has a distinct quantitative companion.

## Verdict: accept

The prior P0 and P1 findings are resolved. E7 now excludes totalized poles,
the quotient/branch convention is explicit, the DLMF convexity and
Bohr–Mollerup prose is represented, all numbered and extra declarations are
manifested and anchored, and the integrated §5.18 pages render successfully.
No P0 or P1 finding remains. One stale parent-owned integration note remains
in the manifest's `known_gaps` (P3 below); it does not affect statement
coverage or acceptance, but should be removed when the manifest is next
refreshed.

## Resolved findings

### Resolved P0 — E7 pole recurrence

`LMLF.Blueprint.Gamma.Section518.dlmf_5_18_7` at
`LMLF/Blueprint/Gamma/Section518.lean:168-174` now requires
`qGammaPoleFree q z` and `qGammaPoleFree q (z + 1)`. The predicate is the
nonzero q-Pochhammer denominator (`qGammaDenom`), so the former counterexample
at `z=0` is excluded: Lean's totalized quotient gives `qGamma q 0 = 0`, while
E5 gives `qGamma q 1 = 1`. The revised introduction, E4 prose, and E7 prose
explicitly distinguish the totalized Lean quotient from the source's
meromorphic function and identify `Complex.cpow` as the principal branch.
Requiring both shifted denominators is a clear pointwise finite-value domain
for the recurrence.

### Resolved P1 — rendered page and anchors

The revised integration imports every standalone Chapter 5 section in
`doc/LMLFManual.lean` and includes `LMLFManual.Chapter5.Section518`; the
chapter index remains linked from `doc/LMLFManual/Chapter5.lean`. The generated
pages are now present:

- `doc/_out/html-multi/___5___18-q-Gamma-and-q-Beta-Functions/index.html`;
- its convexity/Bohr–Mollerup subpage; and
- its `DLMF-ID-manifest/index.html` page.

The rendered page contains all twelve `dlmf_5_18_1` through `dlmf_5_18_12`
anchors, with full declaration text and module-qualified interactive context.
The extra anchors `qGammaDenom`, `qGammaPoleFree`, `qGammaReal_coe`,
`dlmf_5_18_convexity`, and `dlmf_5_18_bohr_mollerup` are also rendered.

### Resolved P1 — omitted q-Gamma prose

The revised manual adds the source's assertion that `ln Γ_q(x)` is convex for
`x>0` and records the q-Bohr–Mollerup uniqueness characterization. It also
adds the source's post-E10 q-digamma notation and generalized asymptotic
references, explicitly labeling those references as not formalized here.

## Formula-by-formula audit

- **E1 — accepted.** The finite q-Pochhammer product is exact for complex `a`,
  `q`, and every `n : ℕ`, including the empty product at `n=0`.
- **E2 — accepted.** The complex q-factorial and q-Pochhammer identity retains
  the necessary `q ≠ 1` condition for Lean's reciprocal expression.
- **E3 — accepted.** `HasProd` states convergence of the infinite product for
  `‖q‖ < 1`, equivalent to the source `|q|<1`; no q>1 claim is added.
- **E4 — accepted specialization.** The real `0<q<1` product representation,
  complex arguments, principal `Complex.cpow`, and totalized-pole convention
  are all explicit.
- **E5 — accepted specialization.** Both values `Γ_q(1)=Γ_q(2)=1` and the
  real-base source range are retained.
- **E6 — accepted specialization.** Natural q-factorials are identified with
  q-Gamma values at `n+1`, with the complex coercion visible.
- **E7 — accepted after repair.** The recurrence has the full real-base range,
  complex argument, principal-power convention, and both pole-free hypotheses.
- **E8 — accepted specialization.** The complete `0<q<r<1` hypotheses and
  disjunctive `0<x<1` or `x>2` domain are retained through `qGammaReal`.
- **E9 — accepted specialization.** The reversed inequality and `1<x<2`
  interval are exact; the real-axis bridge documents its qGammaReal meaning.
- **E10 — accepted under the documented totalized representative convention.**
  `nhdsWithin 1 (Iio 1)` correctly models `q→1⁻`; the manual now explains the
  meromorphic source reading away from exceptional poles.
- **E11 — accepted specialization.** The complex-parameter q-Beta quotient and
  real `0<q<1` base are explicit, with totalized versus meromorphic readings
  distinguished.
- **E12 — accepted specialization.** The Jackson sum, both q-Pochhammer
  arguments, `Complex.cpow` on positive sampled points, and `Re(a),Re(b)>0`
  hypotheses match the source.

## Extra declarations, branches, pairs, and manifest

`qGammaDenom`/`qGammaPoleFree` give the denominator guard needed by E7;
`qGammaReal_coe` proves the real-part projection agrees with complex q-Gamma
on the guarded real axis; and the convexity and q-Bohr–Mollerup declarations
faithfully cover the source prose. The principal `Complex.cpow` branch and
the positivity of Jackson sample points are stated in the section introduction
and E4/E12 prose.

E8 and E9 are a genuinely distinct qualitative pair (opposite inequalities on
different `x` intervals), not quantitative analogues. No quantitative
declaration is required by the source.

The revised manifest maps all twelve numbered declarations plus the four extra
source IDs to the intended fully qualified names, with honest `exact`,
`specialization`, or `related` relations and `proof_status: missing`. The
remaining `known_gaps` entry saying that §5.18 registration is parent-owned is
now stale because registration and rendering have been verified; remove that
line as polish.

No `#check`, filler status prose, or proof work displacing statement coverage
was found. The highlighted artifact exposes all twelve numbered declarations
and all five extra declarations with module-qualified names.

## Verification

- `lake env lean LMLF/Blueprint/Gamma/Section518.lean`: **passed**, with only
  the permitted `sorry` warnings (15 revised declarations).
- `cd doc && lake env lean LMLFManual/Chapter5/Section518.lean`: **passed**.
- Root `lake build`: **passed** (3265 jobs).
- `cd doc && lake build`: **passed** (6996 jobs).
- `python3 scripts/validate_inventory.py`: **passed**.
- `cd doc && lake exe lmlf-site`: **passed**; regenerated §5.18 pages and
  interactive anchors were inspected as listed above.

No mathematically substantive source candidate remains unreviewed. The
q-digamma and asymptotic material is explicitly documented as an external
reference rather than silently omitted.
