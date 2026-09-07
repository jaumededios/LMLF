# Referee report: DLMF §4.12

## Snapshot and files reviewed

Reviewed at commit `7d39f17`:

- official [DLMF §4.12](https://dlmf.nist.gov/4.12), including all numbered
  displays, the generalized-function monotonicity prose, the iterated-log
  notation, and the continuous-differentiability statement;
- `LMLF/Blueprint/Elementary/Section412.lean`;
- `doc/LMLFManual/Chapter4/Section412.lean`;
- `coverage/sections/chapter4-412.json`.

No rendered standalone §4.12 page is present under `doc/_out/html-multi`, so
source elaboration and anchor-level inspection were used.

## Independently computed coverage

The official page contains exactly:

`4.12.E1`, `4.12.E2`, `4.12.E3`, `4.12.E4`, `4.12.E5`, `4.12.E6`,
`4.12.E7`, `4.12.E8`, `4.12.E9`, `4.12.E10`.

The manifest expected/stated sets agree exactly and there are no omitted
numbered formulas. The page also contains substantive unnumbered claims that
the generalized exponential and logarithm are strictly increasing on `[0,1]`
and that both functions are continuously differentiable.

## Verdict: revise

The iteration definitions are transparent and E10 preserves the positive
iteration count and half-open interval, but E2–E9 are largely self-fulfilling:
their hypotheses assume the very equation presented as the conclusion. This
does not provide reusable generalized-function statements and conflicts with
the contract's prohibition on tautological coverage. The source's monotonicity
and differentiability claims are also absent from the authored page. These are
P1 API/source-fidelity failures.

## Formula-by-formula audit

- **4.12.E1:** The recurrence and domain `-1 < x` are present. The theorem
  takes the recurrence as a hypothesis and specializes it at `x`; this is a
  reasonable interface for a defining relation.
- **4.12.E2:** `dlmf_4_12_2` assumes `hφ : φ 0 = 0` and concludes exactly
  `φ 0 = 0`. It is a projection tautology, not a normalization statement on a
  generalized exponential. The same issue occurs for E4.
- **4.12.E3:** The all-real shift domain is correct, but `hψ` already contains
  the exact target equation and the theorem merely returns it.
- **4.12.E4:** The origin normalization is again assumed verbatim and returned
  verbatim.
- **4.12.E5:** The closed unit interval is correct and both identity equations
  are shown, but the assumptions `hφ` and `hψ` already state the conclusions.
  The page also calls this the “simplest” choice without representing the
  source's preceding non-uniqueness/monotonicity context.
- **4.12.E6:** The interval `-1 < x < 0` and real logarithm expression are
  correct, but `hφ` assumes the exact continuation formula pointwise.
- **4.12.E7:** The condition `x > 1`, natural floor, fractional part, and
  explicit iterated exponential are readable. However, `hφ` again assumes the
  exact displayed continuation for every `x` and the theorem only projects it.
- **4.12.E8:** The negative-half-line domain and `exp x − 1` value are correct,
  but the hypothesis is the conclusion verbatim.
- **4.12.E9:** The existence of a positive integer iteration count and the
  explicit iterated logarithm are represented, but `hψ` assumes exactly the
  existential conclusion, making the theorem vacuous as coverage.
- **4.12.E10:** The theorem directly states unique `l : ℕ` with `0 < l` and
  `0 ≤ iteratedLog l x < 1` for `x > 1`, preserving the source's half-open
  interval and local positive-integer convention. This is the strongest and
  most substantive declaration in the section.

The public iteration definitions are transparent recursive definitions and are
used in the displayed declarations. Anchors are module-qualified and enclose
the declarations before their `sorry` proofs. No `#check` or filler status
prose was found.

## Findings

### P1 — E2 is a self-fulfilling normalization theorem

`LMLF/Blueprint/Elementary/Section412.lean:dlmf_4_12_2` assumes
`hφ : φ 0 = 0` and concludes `φ 0 = 0`; the manual reproduces the same
projection. State the normalization as part of the generalized-exponential
structure/interface, or use a declaration for a designated generalized
exponential whose normalization is not passed as the theorem's target
hypothesis.

### P1 — E3–E9 are tautological projections of their own conclusions

The declarations `dlmf_4_12_3`, `dlmf_4_12_4`, `dlmf_4_12_5`,
`dlmf_4_12_6`, `dlmf_4_12_7`, `dlmf_4_12_8`, and `dlmf_4_12_9` each pass a
hypothesis that already contains the displayed conclusion (pointwise or
existentially). This makes the declarations non-reusable and fails the direct,
non-opaque statement requirement. Replace the repeated hypotheses with a
minimal generalized-function structure or state the defining relations directly
as declarations for the chosen `φ`/`ψ`; E9 should expose existence of `l` from
the stated function/domain assumptions rather than assume the existential
result.

### P1 — Source monotonicity and differentiability claims are omitted

The official page states that both generalized functions are strictly
increasing on `[0,1]` and, after E10, that both are continuously differentiable.
Neither `doc/LMLFManual/Chapter4/Section412.lean` nor the Lean module contains
these substantive assertions. Add direct declarations (with readable
monotonicity and `ContDiff`/`ContinuousOn` propositions) and anchored reader
disclosures, or record concrete omissions in the manifest.

## Specializations and quantitative pairs

- The real-variable setting, integer floors, positive iteration counts, and
  half-open unit-interval condition are faithful to the source; E7–E10 do not
  hide a complex specialization.
- The principal real logarithm is represented by `Real.log`; the page should
  retain its totalized behavior when iterates leave the positive domain.
- No quantitative companion declarations are warranted: the section contains
  definitions, recurrences, and qualitative monotonicity/regularity claims,
  not separate error bounds.

## Verification and remaining source candidates

- `lake env lean LMLF/Blueprint/Elementary/Section412.lean`: passes with the
  expected `sorry` warnings.
- `cd doc && lake env lean LMLFManual/Chapter4/Section412.lean`: passes.
- `#check` search in both assigned source files: no hits.
- Manifest formula counts are `10/10/0`; extra vocabulary entries are listed
  for `iterateRealFunction`, `iteratedExp`, and `iteratedLog`.
- Remaining unreviewed source candidates are exactly the omitted monotonicity,
  non-uniqueness context, and continuous-differentiability assertions noted
  above; no table, figure, or caption occurs on this page.
