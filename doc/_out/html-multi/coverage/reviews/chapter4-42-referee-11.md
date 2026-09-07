# Final referee report: DLMF §4.2 Definitions

## Snapshot and files reviewed

Reviewed the referee contract, referee reports 1–10, the official [DLMF §4.2](https://dlmf.nist.gov/4.2), and the current:

- `LMLF/Blueprint/Elementary/Section42.lean`;
- `doc/LMLFManual/Chapter4/Section42.lean`;
- `coverage/sections/chapter4-42.json`.

The current source is the post-referee-10 state: `closedPrincipalPhase` is half-open and E36 uses the same half-open hypothesis.

## Independently computed formula IDs

The official numbered set is exactly `4.2.E1` through `4.2.E37`, with E31 one numbered display containing two components. The manifest expected/stated sets agree exactly (37/37), with no omitted IDs.

## Verdict

**accept**

No P0 or P1 finding remains in the current files.

## Formula-by-formula audit

- **E1:** The manual explicitly labels `dlmf_4_2_1` as the algebraic principal-branch-value specialization; it does not claim to formalize the path integral or winding construction. The nonzero hypothesis is present.
- **E2–E3:** `dlmf_4_2_2` and `dlmf_4_2_3` state the principal inverse and Cartesian logarithm formulas on the open slit-domain predicate.
- **E4:** `dlmf_4_2_4` directly records the closed-cut point `closedCutPoint x = (x : ℂ)` for `x < 0`, and additionally records the upper/lower jump. This now covers the numbered closed-cut convention.
- **E5:** `closedPrincipalPhase` is exactly `-π < Im u ∧ Im u ≤ π`; `dlmf_4_2_5` carries the phase hypothesis and states the closed principal-log decomposition.
- **E6–E7:** The integer branch-value formula and signed upper/lower cut values are both stated with nonzero/negative-real hypotheses.
- **E8–E10:** The reusable `logBase` definition and base-change/reciprocal identities carry valid-base, nonzero-argument, and nonzero-denominator hypotheses.
- **E11–E18:** Natural-log normalization, the integral identity, decimal identities, and all three numerical enclosures are represented. The numerical declarations are honest coarse inequalities rather than claims of the full decimal expansions.
- **E19–E25:** E19 is a genuine `HasSum` factorial power series; periodicity, reciprocal law, modulus, existential general phase, Cartesian decomposition, and the nonzero-target exponential/general-log inverse relation are all present.
- **E26–E27:** General integer logarithm branches and both integer-power components are represented, with `z ≠ 0`.
- **E28–E31:** Principal-power definition, modulus, wrapped phase, and both E31 components are stated on the principal open slit domain.
- **E32–E35:** The natural-base exponential specialization, factorial series for `e`, all integer general-power branches, and the inversion equivalence are present with the required nonzero assumptions.
- **E36:** The theorem is conditional and uses the exact half-open phase condition `-π < Im((1/a) log w) ≤ π`; it does not assert that this condition holds universally.
- **E37:** The closed principal-square-root branch condition includes the positive-imaginary-axis boundary and excludes the negative-imaginary-axis boundary as required.

## Specializations and quantitative pairs

Correctly disclosed specializations include E1, E2–E3, E7, E11, E17–E18, E24, E27–E31, E36, and E37. E31 has two genuinely distinct declarations (`dlmf_4_2_31a` and `dlmf_4_2_31b`). E15 retains both equalities from its display. No additional quantitative companion is warranted.

The manual also preserves the branch-cut figure link, the open versus closed phase distinction, totalization caveats for Mathlib’s `Complex.log`, and the honest E1 path-integral gap.

## Anchors, manifest, and builds

- DLMF theorem anchors: 38 (E1–E30, E31a/E31b, E32–E37).
- Shared reusable anchor: `logBase`.
- Total source/document anchor set: 39, with exact equality.
- No `#check` or filler status prose appears in either authored file.
- `lake build LMLF.Blueprint.Elementary.Section42`: passes.
- `cd doc && lake env lean LMLFManual/Chapter4/Section42.lean`: passes.

No unreviewed numbered source candidate remains. The only deliberately unformalized material is the path/winding construction behind E1, which the manual discloses explicitly as a gap rather than misrepresenting the specialization as the full definition.
