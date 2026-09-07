# Fresh adversarial referee report: DLMF §4.2 Definitions

## Snapshot and files reviewed

Reviewed the current working-tree state at commit `7d39f17`, independently of
the earlier referee-A reports:

- official [DLMF §4.2](https://dlmf.nist.gov/4.2), including E1–E37, the
  open/closed branch conventions, cut-side discussion, numerical displays,
  infinite series, and Figure 4.2.1;
- `LMLF/Blueprint/Elementary/Section42.lean`;
- `doc/LMLFManual/Chapter4/Section42.lean`;
- `coverage/sections/chapter4-42.json`; and
- prior reports `coverage/reviews/chapter4-42-referee-1.md` through
  `coverage/reviews/chapter4-42-referee-5.md`.

No rendered standalone §4.2 page is present in `doc/_out/html-multi`.

## Independent formula enumeration

The official numbered set is exactly `4.2.E1` through `4.2.E37`, with E31 a
single two-component display. The manifest expected/stated sets agree exactly
and contain no omissions.

## Verdict: revise

The current redesign substantially improves branch vocabulary, general-log
values, base-log naming, phase representatives, infinite series, and the E37
boundary condition. However, the assigned artifacts still have a P0 build
failure and P1 directness/branch-domain defects, so they cannot be accepted.

## Findings

### P0 — The standalone manual does not elaborate and anchors are out of sync

The command `cd doc && lake env lean LMLFManual/Chapter4/Section42.lean` fails.
The E1 manual anchor still contains the former conclusion
`∃ k, generalLogValue z k = Complex.log z + ...`, while the current Lean
declaration concludes `generalLogBranch z (Complex.log z)`. The manual also
requests a `logBase` anchor, but `logBase` has no source-side `-- ANCHOR` block,
so Verso reports `Anchor not found`. These are direct violations of the
complete-anchor and build requirements.

Repair the E1 snippet to exactly match the current declaration, add source
anchors around the `logBase` definition, and rerun the standalone build before
claiming coverage.

### P1 — E1 remains only a branch-value proxy for the path-integral definition

DLMF 4.2.E1 defines the multivalued logarithm by a path integral along paths
avoiding the origin. `dlmf_4_2_1` only asserts
`generalLogBranch z (Complex.log z)`, where `generalLogBranch` is defined by an
existential over the preselected `generalLogValue`; it contains no path,
integral, winding, or continuation data. This is an honest specialization only
if the prose explicitly says the path-integral construction is not formalized.
Either expose a path-integral/continuation relation or label this as a narrow
branch-value specialization and remove any implication that E1 itself is
formalized.

### P1 — E4 and E36 are self-defining proxies

For E4, `closedCutPoint x` is defined as `(x : ℂ)`, and
`dlmf_4_2_4` merely proves that definition back to itself (plus its real part).
It does not state the closed-cut phase convention or connect the negative-real
parameter to an upper/lower boundary value. The documentation's cut prose is
therefore unsupported by the E4 anchor.

For E36, `closedPrincipalPhase` is defined as exactly the conjunction returned
by `dlmf_4_2_36`; the theorem is a reflexive equivalence with no inversion or
principal-power content. Replace E4 with a meaningful cut-side/closed-phase
relation and E36 with a substantive predicate application or equivalence that
uses the principal branch condition rather than repeating its definition.

### P1 — Closed/open branch semantics remain conflated in E5 and powers

`principalLogDomain` excludes the entire closed cut, while
`closedPrincipalLogDomain` is only `z ≠ 0`; E5 then assumes an additional
`closedPrincipalPhase (Complex.log z)` rather than expressing the source's
closed convention or cut-side values. E28–E31 use only the open slit-domain
predicate and therefore are specializations, not exact closed-convention
statements. The manual correctly mentions both conventions, but the manifest
and declarations must consistently label these as off-cut specializations and
state what is omitted on the cut. In particular, avoid presenting totalized
`Complex.log 0` or principal powers at the branch point as DLMF values.

### P1 — Base-log and decimal claims need precise source-domain/relationship
  accounting

E8–E16 now carry useful base and denominator hypotheses, and E14–E16 include
`z ≠ 0`; these are improvements. Nevertheless, E8 is still merely the
unfolding of `logBase`, so the manual should identify it as the definition
specialization rather than an independent base-change result. The numerical
E11, E17, and E18 declarations are coarse inequalities rather than the full
displayed decimal expansions and must remain marked `specialization` in the
manifest (E17's corrected `1 / Real.log 10` quantity is numerically aligned).

### P2 — Grouped entries rely on prose links rather than per-anchor source links

The manual groups E2–E7, E8–E18, E19–E25, and E26–E37 under one `dlmfEntry`
URL and supplies a later “Source links” sentence. This is usable but weaker than
one direct DLMF permalink per formula, especially for 37 independently audited
anchors. Splitting entries or placing the direct E URL adjacent to each
declaration would make the page's source pairing unambiguous.

## Correctly handled material

- E2 uses the principal inverse on the open slit domain.
- E3 records the principal modulus/argument expression.
- E6 carries an integer general-log branch value, and E7 carries both upper and
  lower negative-axis values.
- E9–E10 expose a named `logBase` API with valid-base and denominator
  conditions; E12–E13 give the natural-log identity and interval integral.
- E19 is a genuine factorial `HasSum`, not a finite truncation.
- E20–E24 preserve exponential periodicity, reciprocal, modulus, existential
  phase, and Cartesian decomposition; E25 uses existential general-log values.
- E26 quantifies all integer power branches; E27–E31 carry nonzero/open-domain
  hypotheses and phase representatives; E32–E35 maintain the principal/general
  distinction.
- E37 now handles the negative imaginary-axis boundary correctly (`z = -i`
  selects `-z`, matching the principal square root).

No distinct quantitative companion pair is required by §4.2. The source's
decimal displays are numerical enclosures, not separate error-majorant pairs.

## Verification and source candidates

- `lake env lean LMLF/Blueprint/Elementary/Section42.lean`: passes with the
  expected `sorry` warnings.
- `cd doc && lake env lean LMLFManual/Chapter4/Section42.lean`: **fails** with
  the E1 mismatch and missing `logBase` anchor described above.
- No `#check` was found in the assigned source files.
- The source prose about the exponential having no zeros, principal-power
  analyticity off the cut and discontinuity on the cut, and the open-versus-
  closed E37 inequalities is present only partially; these claims should be
  retained precisely in the manual or explicitly recorded as prose-only gaps.
- Figure 4.2.1 is linked in the introduction; no additional figure or table
  candidate is present.
