# Referee 2: DLMF §4.2 Definitions

Snapshot reviewed: `703f1ad1d96c360bbac555c43dc39f6ca64d1a7b` (`site/verso-dlmf-overlay`).

Files reviewed:

- `LMLF/Blueprint/Elementary/Section42.lean`
- `doc/LMLFManual/Chapter4/Section42.lean`
- `coverage/sections/chapter4-42.json`
- official [DLMF §4.2](https://dlmf.nist.gov/4.2), including every E1–E37 formula, its branch/cut prose, and Figure 4.2.1.

## Independently computed expected formula IDs

The official page has exactly `4.2.E1` through `4.2.E37`. Thus the independently computed expected set is:

`[4.2.E1, 4.2.E2, 4.2.E3, 4.2.E4, 4.2.E5, 4.2.E6, 4.2.E7, 4.2.E8, 4.2.E9, 4.2.E10, 4.2.E11, 4.2.E12, 4.2.E13, 4.2.E14, 4.2.E15, 4.2.E16, 4.2.E17, 4.2.E18, 4.2.E19, 4.2.E20, 4.2.E21, 4.2.E22, 4.2.E23, 4.2.E24, 4.2.E25, 4.2.E26, 4.2.E27, 4.2.E28, 4.2.E29, 4.2.E30, 4.2.E31, 4.2.E32, 4.2.E33, 4.2.E34, 4.2.E35, 4.2.E36, 4.2.E37]`.

The manifest and source declare the same ID set (E31 is represented by the two component declarations `dlmf_4_2_31a` and `dlmf_4_2_31b`), with no omitted or extra numbered IDs.

## Verdict

**revise**

The ID inventory is complete and both source files elaborate, but the Lean statements contain several false theorems and many tautological stand-ins for the displayed mathematics. This requires revision before acceptance.

## Findings

### P0 — Multivalued `Ln` and general powers are replaced by principal `Complex.log`

- DLMF IDs: `4.2.E1`, `4.2.E6`, `4.2.E25`, `4.2.E26`, `4.2.E27`, `4.2.E35`.
- Exact declarations: `LMLF/Blueprint/Elementary/Section42.lean:10-16,22,42,120,125,129,165`; corresponding anchors are in `doc/LMLFManual/Chapter4/Section42.lean:23-27,48-50,120-122,131-136,161-163`.
- Evidence: DLMF E1 defines a path-integral, multivalued general logarithm; E6 says its values are `ln z + 2 k π i`; E25 uses that general `Ln`; E26 defines the general power with `exp(a Ln z)`; E27 gives integer powers; E35 inverts the general value. Here `generalLog` is definitionally the single-valued principal `Complex.log`, and `generalPower` is built from it. The resulting E6 is false, e.g. `z = 1, k = 1` would assert `0 = 2πi`; E25 is false for `ζ = 1, z = 2πi`; E27 is false at `z = 0, n = 1` (`generalPower 0 1 = 1` under Mathlib's totalized `log 0`, while `0^1 = 0`).
- Repair: model a general-log value as `Complex.log z + 2*k*π*I` (with `z ≠ 0`) or as a set-valued relation, and define general powers through that relation. State E25/E35 with the resulting multivalued relation. Keep `z ≠ 0` and the positive-integer conditions from the source explicit; do not identify the general value with principal `Complex.log`.

### P0 — E4 is a reflexive filler and E7 drops the lower cut value

- DLMF IDs: `4.2.E4`, `4.2.E7`.
- Exact declarations: `dlmf_4_2_4` at `LMLF/Blueprint/Elementary/Section42.lean:32-35` and `dlmf_4_2_7` at `:44-47`; documentation anchors at `doc/LMLFManual/Chapter4/Section42.lean:42-53`.
- Evidence: E4 states that the cut extension uses `z = x` for `-∞ < x < 0`; the Lean conclusion `(x : ℂ) = (x : ℂ)` says nothing about `z` and would remain true without `hx`. E7 is the two-sided DLMF value `ln(x ± i0) = ln|x| ± iπ`; the declaration gives only the upper `+iπ` value at the ordinary point `(x : ℂ)` and cannot express the lower side. The surrounding prose claims both sides, so this is not an honest complete specialization.
- Repair: introduce explicit cut-side notation/limits (or a tagged upper/lower relation), and state the E4 embedding/extension rather than a reflexive identity. Mark a one-sided theorem as a specialization if it is intentionally retained.

### P1 — Open versus closed principal branch is conflated and cut semantics are unformalized

- DLMF IDs: `4.2.E2`, `4.2.E3`, `4.2.E5`, `4.2.E7`.
- Exact declarations: `principalLog` at `LMLF/Blueprint/Elementary/Section42.lean:12`, `dlmf_4_2_2` at `:24-27`, `dlmf_4_2_3` at `:28-31`, `dlmf_4_2_5` at `:36-39`, and `dlmf_4_2_7` at `:44-47`; prose at `doc/LMLFManual/Chapter4/Section42.lean:17-20,31-34`.
- Evidence: DLMF E2/E3 use the open analytic branch with `-π < ph z < π` off `(-∞,0]`; E4/E5 discuss the closed convention `-π < ph z ≤ π`; E7 explicitly treats the cut as two side points. `principalLog := Complex.log` supplies one totalized value and the E3/E5 expressions do not state the required phase range or domain. The documentation describes the distinctions but the anchors do not preserve them, and no declaration represents the branch-cut figure's two sides.
- Repair: distinguish open-domain theorems from the closed principal convention, add `z ∉ (-∞,0]`/`z ≠ 0` hypotheses where required, and represent upper/lower cut limits separately. Document Mathlib's totalized value at zero rather than silently presenting it as DLMF's branch function.

### P0 — General-base logarithms and numerical formulas are replaced by tautologies

- DLMF IDs: `4.2.E8`–`4.2.E10`, `4.2.E11`, `4.2.E14`–`4.2.E18`.
- Exact declarations: `LMLF/Blueprint/Elementary/Section42.lean:49-92`; documentation anchors at `doc/LMLFManual/Chapter4/Section42.lean:57-94`.
- Evidence: E8–E10 define `log_a` and its base-change identities under the source's `a,b ≠0,1` conditions. No `log_a`/`log_10` definition exists. E8, E14, and E15 are reflexive quotient identities; E9/E10 are only quotient algebra and do not state a logarithm-to-base function. E11, E17, and E18 are decimal equalities of a numeral to itself, not approximations/identifications of `e`, `log_10 e`, or `ln 10`. E16 is merely `x = c*(x/c)` and has no `log_10` term. Consequently the page's claim that these statements identify common and natural logarithms is unsupported.
- Repair: define `logBase a z := Complex.log z / Complex.log a`, retain `a,b ≠0,1` and nonzero denominator hypotheses, and state E8–E10/E14–E16 with that definition. Tie E11/E17/E18 to `Real.exp 1`, `Real.log 10`, and the common-log constant using rigorous interval bounds or explicit approximation predicates.

### P0 — E19 is a false finite cubic equality instead of the infinite exponential series

- DLMF ID: `4.2.E19`.
- Exact declaration: `LMLF/Blueprint/Elementary/Section42.lean:94-97`; documentation anchor at `doc/LMLFManual/Chapter4/Section42.lean:98-104`.
- Evidence: DLMF displays `exp z = 1 + z/1! + z^2/2! + z^3/3! + \cdots`. The declaration asserts `exp z = 1 + z + z^2/2 + z^3/6 + 0` for every `z`, which is false already at `z = 1` (the omitted positive tail is not zero). The manifest calls this a specialization, but no finite truncation or error statement is present.
- Repair: state the convergent infinite sum `Complex.exp z = ∑' n, z^n / n!` (or a `HasSum` declaration), and if a finite truncation is desired give a separate explicitly labeled approximation with a remainder/error bound.

### P0 — E23 confuses principal `arg` with the general phase

- DLMF ID: `4.2.E23`.
- Exact declaration: `LMLF/Blueprint/Elementary/Section42.lean:110-113`; documentation anchor at `doc/LMLFManual/Chapter4/Section42.lean:114-116`.
- Evidence: DLMF's `ph(exp z) = Im z + 2 k π` is a general phase with `k ∈ ℤ`. Mathlib `Complex.arg` is principal and bounded, so the declaration's universal equality for every supplied `k` is false (take `z = 0, k = 1`: left side is `0`, right side is `2π`).
- Repair: use an existential `∃ k : ℤ, ph = ...`, or define a general-phase relation; use `Complex.arg` only for a principal phase with a corresponding range/wrap condition.

### P0 — Principal-power modulus/phase formulas omit domains and phase wrapping

- DLMF IDs: `4.2.E27` (also above), `4.2.E28`, `4.2.E29`, `4.2.E30`, `4.2.E31`.
- Exact declarations: `LMLF/Blueprint/Elementary/Section42.lean:127-150`; documentation anchors at `doc/LMLFManual/Chapter4/Section42.lean:134-151`.
- Evidence: E28–E31 concern principal powers on the branch domain and explicitly discuss the cut and phase conventions. The declarations quantify over all `z,a` without excluding `z = 0` or representing the cut. E29 is false at `z = 0, a = 1`: the totalized definition gives `principalPower 0 1 = 1`, while the RHS is `0`. E30 and E31b are false because `Complex.arg` wraps: for `z = i, a = 3` the RHS is `3π/2`, while `arg(principalPower i 3) = arg(-i) = -π/2`. E31a has the same zero-domain problem for positive real exponents.
- Repair: state `z ≠ 0` and the precise principal branch, use a wrapped/modulo phase statement (or a general phase), and treat `z = 0` separately if a totalized Lean definition is desired. Keep E28's analyticity/discontinuity claims in the prose or formalize them separately.

### P0 — E33, E35, E36, and E37 are mathematically wrong under the declared totalized definitions

- DLMF IDs: `4.2.E33`, `4.2.E35`, `4.2.E36`, `4.2.E37`.
- Exact declarations: `LMLF/Blueprint/Elementary/Section42.lean:155-174`; documentation anchors at `doc/LMLFManual/Chapter4/Section42.lean:155-169`.
- Evidence: E33 describes general values of `e^z`; the declaration uses Lean's single principal complex power on the left but asserts the equality for every `k`, which is false for nonzero `k`. E35 again uses the principal-collapsed `generalPower`, so it cannot state the general-value inversion. E36 should be the conjunction `-π ≤ Im(...) ≤ π`; the declaration instead asserts the false implication `lower bound → upper bound` for arbitrary `a,w` (take `a = 1/2` and `w = -1`, which gives imaginary part `2π`). E37's `principalSqrt` is defined as `if 0 ≤ z.re then z else -z`, not as a square-root function; moreover the theorem tests `(z^2).re` through that definition, not `z.re`. For `z = i`, the RHS is `i` but `principalSqrt (i^2) = principalSqrt (-1) = 1`.
- Repair: model E33/E35 as general-value relations with `k`/branch data, state E36 as a conjunction with the principal branch condition, and define `principalSqrt` using the actual principal square root (with the closed-boundary convention) before stating the piecewise E37 result.

### P1 — Substantive source prose is compressed or omitted

- DLMF locations: prose surrounding E1–E7, E19–E20, E26–E28, and E37.
- Exact documentation: `doc/LMLFManual/Chapter4/Section42.lean:17-20,23,31-34,98-100,126-129`.
- Evidence: DLMF states that the general-log path avoids the origin and has a branch point at zero; the principal log is analytic on `ℂ \ (-∞,0]` and real on positive reals; `exp` is entire and has no zeros; general powers have a branch point and are discontinuous on the cut unless the exponent is integral; and E37 depends on the closed definition (otherwise strict inequalities are required). The manual mentions only portions of these facts and presents the defective anchors as if they preserve them. Figure 4.2.1 is also not reproduced or linked from the authored page.
- Repair: restore the source's analytic-domain/zero/branch-point statements and link or embed Figure 4.2.1; distinguish prose-only source facts from formal declarations and label any deliberate specialization.

### P2 — Grouped entries do not provide the correct external source link for every formula

- DLMF IDs: `4.2.E3`–`4.2.E7`, `4.2.E9`–`4.2.E18`, `4.2.E20`–`4.2.E25`, and `4.2.E27`–`4.2.E37`.
- Exact file: `doc/LMLFManual/Chapter4/Section42.lean:31,57,98,126` uses one `dlmfEntry` URL (`E2`, `E8`, `E19`, or `E26`) for each whole range. The individual anchors show theorem names but do not supply the corresponding DLMF permalink.
- Repair: either split entries by formula or add direct E-number links for every declaration, while retaining enough namespace context in each external anchor.

## Correctly handled specializations

The following declarations match their displayed identities as ordinary single-valued Mathlib facts, subject to the caveat that they do not repair the surrounding branch model: E12 (`log(exp 1)=1`), E13 (the interval integral from `1` to `exp 1`), E20 (period `2πi`), E21 (reciprocal exponential), E22 (exponential modulus), E24 (real/imaginary Cartesian decomposition), E32 (principal complex power of positive `e`), and E34 (the factorial series for `e`). E3/E5 and E28 are definitionally aligned with `Complex.log`, but they still need the source's open/closed domains and branch semantics described above.

## Quantitative pairs

None. This section has no finite-estimate pair; all manifest entries correctly use `quantitative_analogue: "not_applicable"`.

## Build and source-candidate status

- `lake env lean LMLF/Blueprint/Elementary/Section42.lean`: passed (exit 0; 37 expected `sorry` warnings).
- `lake env lean LMLFManual/Chapter4/Section42.lean` from `doc/`: passed (exit 0).
- No rendered Section 4.2 page was present in the checked-in `doc/_out` tree; the authored source and official DLMF page were inspected directly.
- No `#check` command was found. The numeric declarations marked as “displayed identity” are not status prose, but several are tautological fillers or false proxies as detailed above.
- No unreviewed numbered source candidate remains: all E1–E37 IDs and the surrounding branch/prose statements were checked.
