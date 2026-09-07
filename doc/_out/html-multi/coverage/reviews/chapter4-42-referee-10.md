# Final referee report: DLMF §4.2 Definitions

## Snapshot and files reviewed

I read the referee contract, all prior §4.2 reports (referee-1 through
referee-9), the official [DLMF §4.2](https://dlmf.nist.gov/4.2), and the
current:

- `LMLF/Blueprint/Elementary/Section42.lean`;
- `doc/LMLFManual/Chapter4/Section42.lean`;
- `coverage/sections/chapter4-42.json`.

Both current Lean artifacts elaborate.  No rendered standalone page was
available, so the manual source, external-anchor checks, and standalone build
were used for the page audit.

## Independently computed formula IDs

The official numbered set is exactly `4.2.E1` through `4.2.E37`; E31 is one
numbered display with two components.  The manifest expected/stated sets agree
exactly (`37/37`) and `numbered_formula_ids_omitted` is empty.

## Verdict: revise

The fifth revision fixes the former finite-series error, adds branch-value and
cut-side vocabulary, repairs E35's nonzero hypotheses, corrects the E37
negative-imaginary-axis boundary, restores E15's second equality, and makes
the numerical records honest coarse enclosures.  The source and documentation
build, and the declarations are now substantially readable.  Two material
issues remain: E36 is still false at the closed lower phase boundary, and E4
and the closed-phase predicate do not state the numbered cut convention that
the page claims to formalize.  Therefore acceptance is not justified.

## Formula-by-formula audit

- **E1:** `generalLogBranch` records a nonzero branch-value specialization of
  the path-integral general logarithm; the prose honestly identifies the
  missing path/winding construction.
- **E2–E3:** The inverse and Cartesian principal-log formulas have the open
  slit-domain predicate `principalLogDomain`.
- **E4:** The declaration gives the difference between upper and lower cut
  values, while the numbered source display establishes the closed convention
  `z=x` for negative real `x`; the latter is not stated by the E4 anchor.
- **E5:** The logarithm decomposition is present, but its named phase predicate
  uses `-π ≤ Im u ≤ π`, not the source's half-open closed convention
  `-π < ph z ≤ π`.
- **E6–E7:** The nonzero condition and integer branch values are present, and
  both signed cut values are exposed.
- **E8–E10:** `logBase` is defined as the logarithm quotient and the valid-base,
  nonzero-argument, and denominator hypotheses are carried.  The E8 theorem is
  an unfolding restatement, but the underlying reusable definition is present.
- **E11–E18:** Natural-log identities and the integral characterization are
  present; E11, E17, and E18 are correctly coarse numerical specializations.
  E14–E16 carry nonzero argument and decimal-denominator conditions.
- **E19–E25:** E19 is a genuine infinite `HasSum`; periodicity, reciprocal,
  modulus, existential phase representative, Cartesian decomposition, and the
  general-log inverse relation are all stated.
- **E26–E27:** General integer logarithm branches and both integer-power
  components are represented with `z ≠ 0`.
- **E28–E31:** Principal-power formulas use the open slit-domain predicate;
  modulus and wrapped phase are readable, and E31 has both displayed parts.
- **E32–E35:** The `e^z` specialization, factorial series, general branch
  identity, and inversion relation are present with nonzero hypotheses.
- **E36:** The phase hypothesis and principal-power inversion are intended to
  be conditional, but the inclusive lower boundary makes the theorem false.
- **E37:** The principal square-root formula now has the correct closed
  boundary condition `0 < z.re ∨ (z.re = 0 ∧ 0 ≤ z.im)`.

## Findings

### P0 — E36 is false on the included lower phase boundary

`LMLF/Blueprint/Elementary/Section42.lean:188-193`, anchor
`dlmf_4_2_36`, assumes
`-π ≤ Im((1/a) * Complex.log w) ≤ π` and concludes
`principalPower (exp ((1/a) * log w)) a = w`.  The lower boundary is not valid
for Mathlib's principal argument: `Complex.arg` selects `+π` on the negative
real axis, so a value whose computed phase is `-π` is mapped to the opposite
cut-side representative before the principal power is taken.  A concrete
family is obtained by choosing nonzero `a` and positive `w` so that
`((1/a) * log w).im = -π`; the exponential lands on the negative axis and
`principalPower` uses the `+π` representative, so the asserted equality need
not hold.  The manual repeats the same inclusive condition at its E36 anchor.

Repair E36 with a genuinely valid principal-domain condition: either use the
half-open condition compatible with Mathlib's `Complex.arg` and explicitly
exclude the lower cut-side boundary, or state an implication only after adding
the corresponding `principalLogDomain`/boundary-side hypothesis.  Keep the
condition conditional; do not assert it for arbitrary `a,w`.

### P1 — E4 does not state the numbered closed-cut convention

`dlmf_4_2_4` currently proves
`upperCutLog x - lowerCutLog x = 2πi` for `x < 0`.  That is a useful cut-jump
consequence, but DLMF E4's numbered statement is the convention that the cut
point is represented by `z=x` for negative real `x` under the closed principal
phase.  The source declaration `closedCutPoint` exists but is not used by the
E4 theorem, so the anchor and manifest relation do not cover the numbered
statement they label.  Add a direct E4 declaration involving
`closedCutPoint x` and its `x < 0` condition, retaining the jump relation as a
separate anchored consequence if desired.

### P1 — E5's closed-phase predicate has the wrong endpoint semantics

`closedPrincipalPhase` at `Section42.lean:15` is
`-π ≤ u.im ∧ u.im ≤ π`, and E5 merely assumes that predicate.  The documented
closed convention is half-open (`-π < ph z ≤ π`), with the lower boundary
assigned to the opposite cut side.  Although `Complex.log` itself has a
principal range, the public predicate is used as the formal branch condition
and currently admits the forbidden lower endpoint.  Replace it with the
half-open predicate and synchronize the E5 prose/manifest notes; this also
makes the E36 repair expressible using the same branch convention.

## Correct specializations and quantitative pairs

- E1 is honestly labeled a branch-value specialization rather than a full
  path-integral construction.
- E2–E3 are open principal-log specializations; E4/E7 expose cut-side values.
- E8–E10 and E14–E16 carry base, argument, and denominator restrictions.
- E11, E17, and E18 are explicitly coarse numerical enclosures.
- E19 uses an infinite `HasSum`, not a finite polynomial substitute.
- E24 is a real-coordinate specialization; E27 is the `k=0` integer-power
  specialization with both positive and reciprocal components.
- E28–E31 and E36 are principal-branch specializations; E31 contains both
  components of the source display.
- E37 is the closed principal-square-root specialization with the corrected
  imaginary-axis boundary.
- No distinct quantitative companion declarations are warranted; the decimal
  inequalities are the source's own numerical statements.

## Verification and remaining candidates

- `lake build LMLF.Blueprint.Elementary.Section42`: passes with only expected
  `sorry` and style warnings.
- `cd doc && lake env lean LMLFManual/Chapter4/Section42.lean`: passes.
- Source/document anchors are present for `logBase`, E1–E30, E31a/E31b, and
  E32–E37; no `#check` or filler status prose was found.

The remaining unreviewed source candidates are the exact path-integral
construction behind E1 and the raster branch-cut figure; both are disclosed in
the page prose.  The P0 E36 boundary error and P1 E4/E5 convention gaps must be
repaired before acceptance.
