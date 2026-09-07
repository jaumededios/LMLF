# Referee re-review: DLMF §5.17

## Snapshot and files reviewed

Re-review snapshot: `f4176ce` (`docs: publish rebuilt LMLF site`), branch
`site/verso-dlmf-overlay`, with the revised assigned author files and coverage
packet present as uncommitted worktree additions. I re-read:

- the official [DLMF §5.17 Barnes' G-function page](https://dlmf.nist.gov/5.17),
  including all formula links, branch conventions, and the E5 error-bound note;
- the §5.17 records in `coverage/dlmf-4-10-source-inventory.json`;
- `LMLF/Blueprint/Gamma/Section517.lean`;
- `doc/LMLFManual/Chapter5/Section517.lean`;
- `coverage/sections/chapter5-517.json`; and
- the highlighted declaration artifact
  `doc/.lake/build/highlighted/LMLF/Blueprint/Gamma/Section517.json`.

Per the re-review assignment, Chapter 5 site registration and aggregate
coverage-ledger updates are parent-owned integration work and are not scored
as findings here.

## Independently computed formula IDs and verdict

The official DLMF page and source inventory contain exactly:

`5.17.E1`, `5.17.E2`, `5.17.E3`, `5.17.E4`, `5.17.E5`, `5.17.E6`, `5.17.E7`.

The manifest states exactly this set, with no omissions or extras. **Verdict:
accept.** The prior P0 E1 totalization error and P3 E5 source-note omission
are resolved. No P0/P1 issue remains in the assigned author files.

## Resolution checks

### Resolved P0 — E1 now has a pole-free recurrence and separate normalization

`LMLF/Blueprint/Gamma/Section517.lean:95-108` now gives

```lean
theorem dlmf_5_17_1 (z : ℂ) (hz : ∀ m : ℕ, z ≠ -(m : ℂ)) :
    barnesG (z + 1) = Complex.Gamma z * barnesG z

theorem barnesG_one : barnesG 1 = 1
```

The same guarded statement and separate anchor appear in the manual at
`doc/LMLFManual/Chapter5/Section517.lean:54-70`. The guard excludes every
nonpositive integer, including `z=0`, where Mathlib assigns
`Complex.Gamma 0 = 0` by convention. Thus the former specialization to
`z=0` no longer produces `1=0`; the source's meromorphic recurrence is now
represented on the ordinary pole-free pointwise domain, while normalization is
usable without a dummy parameter. The revised prose explicitly explains the
totalization convention and the guard.

The manifest correctly names both declarations for E1, changes the relation
to `specialization`, and records the guard rationale at
`coverage/sections/chapter5-517.json:23-38`.

### Resolved P3 — E5 now records the omitted source capability

The E5 prose at `doc/LMLFManual/Chapter5/Section517.lean:147-153` and the
section manifest at `:248-253` now state that Nemes supplies both error bounds
and an exponentially improved extension, and that neither refinement is
formalized. The known-gap entry likewise records both omissions while keeping
the honest `quantitative_analogue: not_applicable` status.

## Formula-by-formula audit

- **5.17.E1 — accepted after the guard repair.** The recurrence is now
  restricted to `z` away from all nonpositive integers, and `barnesG_one`
  separately records `G(1)=1`. This is the appropriate pointwise
  specialization of the source meromorphic identity under Mathlib's totalized
  Gamma.
- **5.17.E2 — clear.** `dlmf_5_17_2` preserves `n ≥ 2`; the product over
  `Finset.Icc 1 (n - 2)` is empty at `n=2` and otherwise gives exactly
  `(n-2)! ... 1!`.
- **5.17.E3 — clear.** The prefactor, Euler constant, factor
  `(1+z/k)^k`, exponential correction, and lower limit `k=1` are all visible;
  the subtype `{n : ℕ // 1 ≤ n}` and `∏'` retain the source indexing.
- **5.17.E4 — clear as an honest specialization.** The theorem takes `x>0`,
  uses the interval path `0..x`, and uses principal `Complex.log` on the
  positive real axis. The page explains the source's continued-log branch.
- **5.17.E5 — clear as an honest specialization.** The `atTop` positive-real
  theorem preserves the main term, `-log A`, and the Bernoulli-term sequence;
  local `n=0,1,...` maps to source `k=1,2,...`, with first term
  `B₄/(2·3·4·x²)`. The sector restriction and omitted refinements are stated
  honestly.
- **5.17.E6 — clear.** The exact relation `A = exp C` is formalized and the
  printed decimal expansion is retained as prose, not treated as a finite
  bound.
- **5.17.E7 — clear as statement coverage.** The renormalized sum, its limit,
  and both zeta-derivative forms are preserved; `Finset.Icc 1 n` keeps the
  source lower limit. The eight pending proof declarations (guarded E1,
  `barnesG_one`, and E2–E7) are honestly marked `proof_status: missing`.

No declaration is an opaque formula proxy: product factors, the Glaisher
partial expression, asymptotic main term, and asymptotic term sequence remain
visible and reusable. No quantitative companion is needed for any display;
the E5 external error-bound reference is not itself a finite quantitative
declaration.

## Manifest, anchors, prose, and hygiene

`coverage/sections/chapter5-517.json` has exact expected/stated ID equality,
the correct fully qualified names (including `barnesG_one`), honest E1/E4/E5
specialization labels, and the E5 known-gap note. The Lean and manual anchor
labels agree one-for-one. The highlighted artifact contains complete
namespace-qualified signatures for `dlmf_5_17_1`, `barnesG_one`, and
`dlmf_5_17_2` through `dlmf_5_17_7`. No `#check`, filler status prose, or
proof work displacing statement coverage was found.

The source inventory still independently yields seven numbered formulas, three
prose blocks, two annotation notes, and three editorial-change notes. The
branch convention, positive-real specializations, pole guard, and E5 source
note are all represented. Remaining site rendering and aggregate-ledger
checks are intentionally deferred to the parent-owned integration pass.

## Verification

- `lake env lean LMLF/Blueprint/Gamma/Section517.lean`: **passed**, with the
  eight intentional `sorry` warnings.
- Root `lake build LMLF`: **passed** (2929 jobs; only existing project
  `sorry` warnings elsewhere).
- From `doc/`, `lake env lean LMLFManual/Chapter5/Section517.lean`:
  **passed**.
- From `doc/`, `lake build`: **passed** (6304 jobs).

The standalone source and declarations are therefore accepted. Chapter 5
registration, rendered-page/anchor inspection, and synchronization of
`coverage/dlmf-4-10.json` remain unreviewed parent-owned integration tasks.
