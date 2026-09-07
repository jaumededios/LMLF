# Final adversarial referee review: DLMF §4.2 Definitions

## Snapshot and files reviewed

Snapshot: `703f1ad1d96c360bbac555c43dc39f6ca64d1a7b` (workspace state based on
the assigned revision).

Reviewed independently:

- Official [DLMF §4.2](https://dlmf.nist.gov/4.2), including all E1–E37
  displays, branch-cut prose, Figure 4.2.1, numerical displays, and the
  multivalued/general-power conventions;
- `coverage/dlmf-4-10-source-inventory.json`;
- `LMLF/Blueprint/Elementary/Section42.lean`;
- `doc/LMLFManual/Chapter4/Section42.lean`; and
- `coverage/sections/chapter4-42.json`.

No rendered §4.2 page was available in the checked-in output tree. Anchor
syntax and declaration disclosures were checked directly in the manual source.

## Independently computed expected formula IDs

The source inventory has exactly 37 numbered records in §4.2:

`4.2.E1` through `4.2.E37` (with E31 represented by two component
declarations). The manifest expected and stated sets agree exactly, with no
omissions.

## Verdict: revise

The ID bookkeeping and compilation are sound, and several later declarations
are materially improved. However, P0/P1 source-fidelity failures remain in the
branch definitions, principal-domain distinctions, general-power scope, E36,
and E37. The section cannot be accepted.

## Findings

### P0 — E2 is still a reflexive proxy, not the principal logarithm definition

- **DLMF ID:** `4.2.E2`.
- **Declaration:** `dlmf_4_2_2` in
  `LMLF/Blueprint/Elementary/Section42.lean`.
- **Evidence:** DLMF defines the principal logarithm by the path integral
  avoiding `(-∞,0]`, with a single-valued analytic branch on the slit plane.
  The declaration concludes only `Complex.log z = Complex.log z`; the domain
  hypothesis is unused and no path, branch, analyticity, or real-positive
  property is stated. The manual consequently presents a source definition
  whose Lean anchor contains no defining mathematics.
- **Repair:** expose a named principal-log definition/domain relation or state
  the slit-plane branch proposition directly; retain the explicit path-avoidance
  and nonzero conditions. Do not use a reflexive equality as the E2 statement.

### P0 — E4 does not formalize the closed-cut extension

- **DLMF ID:** `4.2.E4`.
- **Declaration:** `dlmf_4_2_4`.
- **Evidence:** The source extends the principal value by taking `z=x` for
  every `x<0`. The Lean conclusion merely proves the coordinate facts
  `((x : ℂ).re = x ∧ (x : ℂ).im = 0)`, which is true for every real `x` and
  does not mention `principalLog`, its closed convention, or the value on the
  cut. The hypothesis `x<0` has no mathematical role in the conclusion.
- **Repair:** define/tag the closed cut point and state the corresponding
  principal-log value or an explicit upper/lower cut relation, so E4 connects
  the negative real parameter to the branch convention.

### P1 — E1/E5 branch semantics are incomplete or conflated

- **DLMF IDs:** `4.2.E1`, `4.2.E3`, `4.2.E5`, `4.2.E6`, `4.2.E7`.
- **Declarations:** `dlmf_4_2_1`, `dlmf_4_2_3`, `dlmf_4_2_5`,
  `dlmf_4_2_6`, and `dlmf_4_2_7`.
- **Evidence:** E1’s source mathematics is the path integral defining the
  multivalued logarithm; the Lean theorem only asserts that a value produced by
  the already-defined `generalLogValue` has its own defining expression. E3
  and E5 use the same principal `Complex.log` expression and the same open slit
  domain, so E5 does not encode the closed phase range `−π < ph z ≤ π`.
  E6/E7 correctly introduce integer values and upper/lower cut expressions,
  but the surrounding declarations do not connect those values to a branch
  path or state the open-versus-closed distinction. The manual’s prose claims
  these distinctions more strongly than the anchors establish.
- **Repair:** retain explicit open and closed domains, state the principal
  phase ranges, and model E1 as a path/general-value relation rather than a
  tautological expansion of a preselected value. Keep E7’s two cut sides and
  explain that they are tagged side values, not ordinary `Complex.log` at the
  same point.

### P1 — General-base API is not fully disclosed and its hypotheses are uneven

- **DLMF IDs:** `4.2.E8`–`4.2.E10`, `4.2.E14`–`4.2.E16`.
- **Declarations:** `logBase` and `dlmf_4_2_8` through `dlmf_4_2_16`.
- **Evidence:** The Lean definition `logBase` is hidden from the manual’s
  external disclosures; readers see theorem names referring to an opaque
  object rather than the complete base-log definition. E14–E16 omit the
  nonzero/nonunit and denominator conditions used in E8–E10, so their totalized
  field divisions silently cover invalid bases. E11/E14 also rely on the
  unqualified totalized expression `logBase (exp 1) z` without stating that the
  base is valid and `Complex.log (exp 1)=1` is the normalization being used.
- **Repair:** add anchored manual disclosures for `logBase` and carry explicit
  valid-base/nonzero-denominator hypotheses through E14–E16 (or state the
  natural real-positive specialization). Mark any totalized Lean convention
  explicitly.

### P1 — E26 is only the principal (`k=0`) branch but is marked exact

- **DLMF ID:** `4.2.E26`.
- **Declaration:** `dlmf_4_2_26` and `generalPowerValue`.
- **Evidence:** DLMF defines the general power using a general logarithm
  `Ln z`, hence all integer winding values. The theorem fixes the branch index
  to `0` and equates it to the principal `Complex.log`, while the manifest
  labels E26 `exact`. This is a deliberate principal-branch specialization,
  not the displayed general-power definition.
- **Repair:** either state E26 for arbitrary `k` using `generalLogValue`, or
  mark the current `k=0` declaration as `specialization` and say so in the
  manual and manifest.

### P0 — E36 repeats its assumption instead of expressing the principal phase
restriction

- **DLMF ID:** `4.2.E36`.
- **Declaration:** `dlmf_4_2_36`.
- **Evidence:** The source gives the principal-value condition as the actual
  conjunction `−π ≤ Im((1/a) log w) ≤ π` (under the relevant nonzero/branch
  conditions). The Lean theorem takes exactly that conjunction as `h` and
  returns the same conjunction, without any domain conditions or relation to
  principal-value selection. It is a proof-irrelevant restatement, not the
  displayed branch restriction.
- **Repair:** state the principal phase characterization with `a ≠ 0`, `w ≠ 0`
  and the appropriate branch expression, or define a predicate for the closed
  principal range and use it as the conclusion without repeating it as an
  assumption.

### P0 — E37’s square-root condition is false on the negative imaginary axis

- **DLMF ID:** `4.2.E37`.
- **Declaration:** `dlmf_4_2_37`.
- **Evidence:** The theorem claims
  `Complex.sqrt (z ^ 2) = if 0 ≤ z.re then z else -z` for every `z`. Take
  `z = -Complex.I`: the condition `0 ≤ z.re` is true, so the RHS is `-I`,
  while the principal square root of `(-I)^2 = -1` is `+I` under the closed
  convention. The source’s boundary case requires the sign of the imaginary
  part when `Re z = 0`; the current predicate cannot distinguish the two
  imaginary-axis directions.
- **Repair:** use the correct closed-boundary piecewise condition (positive
  real part, or zero real part with nonnegative imaginary part), and state the
  principal-square-root branch explicitly.

## Formula records handled correctly

The following portions are materially aligned after the redesign, subject to
the branch/API findings above:

- E3’s modulus/phase expression is structurally correct on the open slit
  domain.
- E6 and E7 now expose integer general values and both upper/lower cut values
  rather than collapsing them to one principal value.
- E9/E10 express the base-change identities with explicit nonzero-log
  hypotheses; E11–E13 include the numerical exponential normalization and the
  equivalent interval integral.
- E17/E18 retain numerical enclosures for `log₁₀ e` and `ln 10`.
- E19 correctly uses an infinite `HasSum` factorial series.
- E20–E22 correctly state period, reciprocal, and modulus identities.
- E23 uses an existential integer phase representative rather than the prior
  false universal principal-argument equation.
- E24 correctly gives the real-coordinate Cartesian decomposition.
- E25 uses a general-log value relation for the nonzero target.
- E27–E31 include explicit nonzero/principal-domain hypotheses and existential
  phase representatives; E31 is represented by both source components.
- E32–E35 expose the exponential-power relation, factorial series, and
  general-value inverse relation with nonzero conditions.

These correct portions do not offset the P0/P1 failures above.

## Quantitative pairs and specializations

No distinct quantitative analogue is required by §4.2. E11, E17, and E18 are
numerical enclosures rather than duplicate qualitative identities. E3, E7,
E24, E27, E31, and E37 use principal/closed-branch specializations and must
retain their branch labels and domains; E26 is currently mislabeled exact as
noted above.

## Verification

- `lake build LMLF.Blueprint.Elementary.Section42`: passed with expected
  `sorry` warnings (plus line-length linter warnings).
- `cd doc && lake env lean LMLFManual/Chapter4/Section42.lean`: passed.
- Inventory and manifest both contain 37 expected/stated IDs with zero omitted.
- Neither authored source contains `#check`.

Unreviewed source candidate: none. The remaining blockers are declaration
fidelity and branch semantics, not formula enumeration or compilation.
