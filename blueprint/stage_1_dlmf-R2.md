# Proposed Stage 1: DLMF through Chapter 10 — revision 2

**Normative owner:** `jaumededios`
**Document status:** proposed operative implementation plan; pending fresh review and external adjudication
**Decision proposed here:** `DD-021`, revision 1
**Scope decision date:** 2026-09-06
**Discovery access date:** 2026-09-06; not an audit-wide retrieval date
**Provisional source target:** NIST DLMF version 1.2.7, released 2026-06-15

This is the complete revision-2 successor proposal to
[`stage_1_dlmf.md`](stage_1_dlmf.md). Revision 1 remains immutable historical
review input; its exact reviewed bytes received two `request_changes` verdicts
and have no operative authority. This document authorizes no source census,
schema migration, theorem card, Lean implementation, coverage claim, or Verso
authority.

## DD-021 revision 1 — proposed Stage 1 programme precedence

### Decision and effective rule

The user has authorized the broad programme boundary: Stage 1 is DLMF through
Chapter 10 at specific-function and atomic mathematical-assertion granularity,
with Chapters 1--3 treated selectively as infrastructure and Chapters 4--10
audited for essentially every mathematical website statement, including prose.

This **operative plan is still pending**. DD-021 revision 1 takes effect only
after both of the following exist for the exact same five-file successor bytes
(`stage_1_dlmf-R2.md` and the successor notices in `README.md`, `roadmap.md`,
`design_decisions.md`, and `source_manifest.md`):

1. two fresh, independent blueprint reviews with approving verdicts, each bound
   to the exact commit and artifact digests; and
2. a root external adjudication recording acceptance, also bound to that exact
   commit, the five artifact digests, and the two review identities.

Candidate-owned prose cannot satisfy either condition. Until both conditions
hold, the existing frozen control-plane text remains operative and this R2 is
planning-only. A material edit resets the reviews and adjudication requirement.

### Clauses superseded once effective

When the effective rule is satisfied, DD-021 supersedes **only programme
priority and scheduling**, specifically:

- the `roadmap.md` “Mission and fixed scope” sentence that calls Olver (1997)
  the first source-coverage programme;
- the `roadmap.md` M5 heading and scheduling language that make the first true
  source MVP the quantitative Olver Watson packet;
- the first sentence of `design_decisions.md` DD-001 that calls Olver the
  initial source programme; and
- the `design_decisions.md` DD-011 scheduling statement that makes the first
  true MVP the Olver Watson theorem.

The replacement scheduling rule is: the DLMF Stage 1 programme described here
has programme priority, while executable work proceeds only through separately
closed, reviewed, authorized finite manifests.

No other clause is superseded. The Olver edition lock, source-snapshot and
edition relations, occurrence/notation/entity IDs, transcriptions, theorem
cards, natural-language proofs, review records, classifications, manifests,
implementation evidence, and coverage semantics remain unchanged. In
particular, every frozen artifact and CSV row whose baseline is commit
`3a1b16cae6d186a20530de3b883c1bb871ee76f6` remains immutable historical and
operative evidence for its own claim.

`OLV-MVP-1` remains an eligible parallel **Olver-track** planning packet under
its own source, proof, review, authorization, and manifest gates. It is neither
a prerequisite of DLMF Stage 1 nor a DLMF target occurrence, and it earns no
DLMF coverage. DLMF work similarly earns no locked-Olver coverage. Shared
mathematics may be reused only through explicit semantic crosswalks, never by
transferring source credit.

## 1. Stage 1 boundary

LMLF remains one exact-analysis Lean/mathlib library. Stage 1 comprises:

- every mathematical assertion in the selected DLMF snapshot's Chapters
  4--10, including atomic assertions in formulas, prose, tables, captions,
  applications, and computation/approximation sections; and
- only finite, explicitly consumer-justified exact-mathematics support from
  Chapters 1--3 and later chapters or other sources.

The broad boundary is not a closed executable manifest. No denominator, count,
percentage, readiness, or coverage claim exists until the audited, reviewed
content-unit and atomic-occurrence records exist. Every executable batch still
requires a finite closed manifest; chapter wildcards and “related results” are
forbidden.

### Exact mathematics, not numerical software

Stage 1 may define exact functions and prove exact identities, inequalities,
convergence, finite approximants and remainder bounds, qualitative structural
properties, and source-faithful recovery statements. It does not implement
floating-point or arbitrary-precision evaluators, interval arithmetic,
tolerance routing, adaptive truncation, quadrature or root-finding procedures,
recurrence-evaluation strategies, performance models, or software catalogues.

Exact identities, stability propositions, convergence theorems, and error
bounds embedded in computational prose remain mathematical occurrences. The
algorithm or software package around them is not an LMLF implementation target.
A future verified numerical library is only a design consumer: present APIs
should not gratuitously obstruct it, but it imposes no numerical interface or
acceptance criterion on LMLF.

## 2. Source identity and non-transfer

The 2026-09-06 discovery pass consulted the official
[DLMF root](https://dlmf.nist.gov/),
[project news](https://dlmf.nist.gov/about/news/), and
[errata](https://dlmf.nist.gov/errata/). Those pages displayed version 1.2.7
with release date 2026-06-15. The discovery date does not assert that all future
audit pages were retrieved or frozen then.

The reviewed source-audit manifest must enumerate every canonical URL and bind
each actual retrieval to its retrieval date, content digest, retrieval method,
and observed version evidence. A root version label is not a per-page digest.
If the website changes during the audit, a new snapshot plus explicit versioned
schema/data migration is required; changed bytes are never silently assigned to
the 1.2.7 snapshot. Snapshot successors use append-only occurrence lineage
(`unchanged`, `modified`, `split`, `merged`, `added`, or `removed`).

HTML/MathML, TeX, and image fallbacks are representations of one occurrence
unless a reviewed audit finds a substantive mismatch. Mismatches remain
explicitly unresolved until reconciled. Store locators, hashes, audit metadata,
short indispensable fragments, and independent mathematical paraphrases; do
not mirror bulk prose, tables, or figures. Follow the official
[NIST copyright and permissions notice](https://www.nist.gov/copyrights-disclaimers).

The existing `inventory-v1.0.0` CSVs remain frozen Olver-focused authority.
DLMF records require a reviewed multi-track schema migration; no ad hoc DLMF
rows or unofficial competing coverage ledger may be introduced beforehand.

## 3. Chapter and specific-function map

Official chapter landing pages establish the following discovery map. It is a
scope checklist, not the final occurrence denominator.

| Chapter | Official title | Treatment and mandatory function leads |
|---|---|---|
| 1 | [Algebraic and Analytic Methods](https://dlmf.nist.gov/1) | Selective infrastructure only: notation, algebra, calculus, inequalities, series/products, complex analysis, continued fractions, ODEs, transforms, distributions, and spectral material only when named Stage 1 consumers justify a finite support card. |
| 2 | [Asymptotic Approximations](https://dlmf.nist.gov/2) | Selective method support only: exact asymptotic definitions, integral/Mellin/differential/difference/summation methods, remainders, and Stokes material only for named finite consumers. |
| 3 | [Numerical Methods](https://dlmf.nist.gov/3) | No blanket algorithm programme. Only consumer-justified exact assertions about error measures, conditioning/stability, interpolation/approximation identities, convergence/error bounds, continued fractions, or mathematical constants. |
| 4 | [Elementary Functions](https://dlmf.nist.gov/4) | Audit mathematical assertions in §§4.1--4.47; §4.48 software entries are metadata-only unless surrounding prose asserts mathematics. Leads include `ln`, multivalued `Ln`, `exp`, complex powers; trigonometric, inverse-trigonometric, hyperbolic, and inverse-hyperbolic families; generalized logarithms/exponentials; and the full Lambert §4.13 sentinel below. |
| 5 | [Gamma Function](https://dlmf.nist.gov/5) | Audit §§5.1--5.23; treat §5.24 analogously. Leads include Gamma and reciprocal Gamma, psi/digamma and polygamma, beta, multidimensional integrals, [Barnes G/double Gamma](https://dlmf.nist.gov/5.17), Glaisher's constant, and [q-factorials, q-Gamma, q-digamma claims, and q-Beta](https://dlmf.nist.gov/5.18). |
| 6 | [Exponential, Logarithmic, Sine, and Cosine Integrals](https://dlmf.nist.gov/6) | Audit §§6.1--6.20; treat §6.21 analogously. Leads include `Ei`, `E_1`, `Ein`, `li`, `Si`, `si`, `Ci`, `Cin`, hyperbolic variants, and chapter-defined auxiliaries. |
| 7 | [Error Functions, Dawson's and Fresnel Integrals](https://dlmf.nist.gov/7) | Audit §§7.1--7.24; treat §7.25 analogously. Leads include `erf`, `erfc`, complex/Faddeeva `w`, Dawson `F`, Fresnel functions, Goodwin--Staton `G`, generalized and inverse error functions, repeated erfc integrals, probability/scaled normalizations, and Voigt `U`,`V`. |
| 8 | [Incomplete Gamma and Related Functions](https://dlmf.nist.gov/8) | Audit §§8.1--8.27; treat §8.28 analogously. Leads include `gamma(a,z)`, `Gamma(a,z)`, `gamma*(a,z)`, `P`, `Q`, their [generalizations](https://dlmf.nist.gov/8.16), incomplete beta `B_x`,`I_x`, generalized exponential `E_p`, and generalized sine/cosine integrals. |
| 9 | [Airy and Related Functions](https://dlmf.nist.gov/9) | Audit §§9.1--9.19; treat §9.20 analogously. Leads include `Ai`, `Bi`, derivatives, modulus/phase auxiliaries, [Scorer `Gi`,`Hi`](https://dlmf.nist.gov/9.12), generalized Airy `A_n`,`B_n`,`U_m`,`V_m`, and the internal-cross-reference definition plus external-reference leads in [incomplete Airy §9.14](https://dlmf.nist.gov/9.14). |
| 10 | [Bessel Functions](https://dlmf.nist.gov/10) | Audit §§10.1--10.76; treat §10.77 analogously. Leads include `J_nu`,`Y_nu`, Hankel `H_nu^(1,2)`, modified `I_nu`,`K_nu`, imaginary-order forms and order derivatives; §10.46 as distinguished below; spherical and modified spherical Bessel functions; Kelvin `ber`,`bei`,`ker`,`kei` and modulus/phase auxiliaries. |

“Audit” means every mathematical formula and prose assertion, not merely the
named leads. Bibliographic entries, historical attribution, software entries,
and visual media are provenance records rather than theorem targets, but any
mathematical claim embedded in them is extracted. Captions and table cells can
contain proof obligations; sampled pixels and plots are never proofs.

### Lambert §4.13 sentinel

The [official §4.13 body](https://dlmf.nist.gov/4.13) supplies all of these
mandatory leads:

- the multivalued Lambert function and branch notations `W_k`;
- legacy real notations `Wp` and `Wm`;
- the separately named Wright omega function; and
- the separately named Tree `T` function.

The census and pilot must record the occurrences and classify the relationships
among all four kinds of lead. `Wp` and `Wm` are alias candidates whose domains,
boundary values, and branch-side conventions require review; this plan does not
prejudge their branch identities. Wright omega and Tree `T` remain distinct
named-entity candidates unless the reviewed entity schema chooses a canonical
construction plus explicit identification bridges. No generic “Lambert W” row
can stand in for this audit.

### Other hidden-family sentinels

- [§9.12](https://dlmf.nist.gov/9.12): Scorer functions;
- §§9.13--[9.14](https://dlmf.nist.gov/9.14): explicit generalized/incomplete
  Airy content distinguished from external reference leads;
- [§10.46](https://dlmf.nist.gov/10.46): explicit generalized Bessel
  `phi(rho,beta;z)` and Mittag--Leffler `E_(a,b)(z)`, the substantive but
  underspecified Laplace-transform prose, and the separate reference-only lead
  for incomplete modified Bessel/Hankel functions;
- [§10.47](https://dlmf.nist.gov/10.47): spherical and modified spherical
  Bessel functions; and
- [§10.61](https://dlmf.nist.gov/10.61): Kelvin functions.

The §10.46 Laplace statement cannot disappear, but it remains unresolved until
source-faithful review supplies an exact target. The incomplete-function
sentence does not silently import the cited paper. Apply the same formula versus
prose-claim versus reference-lead distinction throughout.

## 4. Census roles and exact denominator

### Content-unit census

Give every chapter, section, subsection, formula block, prose block, table,
caption, figure, application block, computation block, software block, and
reference block a stable content-unit ID. Each unit receives a reviewed
disposition `mathematical`, `mixed`, or `nonmathematical`; every mathematical
piece receives a fidelity role:

- `explicit_mathematical_assertion`: a self-contained formula, definition, or
  sufficiently definite prose proposition;
- `internal_cross_reference_assertion`: a mathematical assertion defined by an
  exact DLMF cross-reference and specialization;
- `underspecified_mathematical_claim`: substantive mathematics whose faithful
  target is not yet sufficiently stated; or
- `mathematical_reference_lead`: a report that external literature treats a
  named topic/regime without reproducing a theorem.

Forward and reverse/checklist passes reconcile all headings, equations,
notations, figures, tables, and content units. An independent source reviewer
checks every `nonmathematical` and reference-only disposition. Contents,
indices, search, notation lists, and TOCs are discovery aids, not denominators.

### Role-filtered target set

For selected source snapshot `S`, define the Stage 1 target-occurrence
denominator exactly as

```text
Target(S) = {
  o.occurrence_id |
    o.record_kind = atomic_target_occurrence
    and o.snapshot_id = S
    and 4 <= o.chapter <= 10
    and o.atomic = true
    and o.immutable_fidelity_role in {
      explicit_mathematical_assertion,
      internal_cross_reference_assertion
    }
    and fidelity_role_review(o.occurrence_id) = approved
}
```

`Target(S)` ranges only over real atomic target-occurrence records. Content-unit,
nonmathematical, reference-lead, and provisional unresolved records have
different immutable `record_kind` values and cannot enter this comprehension,
even if a later resolution record points to them. `Target(S)` is a set of
immutable atomic IDs, not a count of pages, content units, association rows,
cards, declarations, or entities. Repeat appearances are different atomic
occurrence IDs. One occurrence may need several cards and one card may cover
several occurrences; source totals use the deduplicated set.

Reference-only and nonmathematical records are excluded from `Target(S)` but
must be separately and completely reconciled in the census. An underspecified
claim has `record_kind = provisional_unresolved_claim` and blocks Stage 1
completion. Review resolves it append-only by creating a successor resolution
record that either creates a **new** `atomic_target_occurrence` with one of the
two included immutable fidelity roles or creates/confirms a reference lead. The
original provisional row, role, text meaning, and ID remain unchanged and are
linked to the successor. Thus resolving fixture `FX-P1` by creating `FX-O5`
can add only `FX-O5` to `Target(FX-S)`; `FX-P1` can never count, and the pair can
never double-count through reconstructed role state. Historical records are
never relabeled or overwritten. All later decisions, splits, merges, and
snapshot changes follow the same append-only lineage rule.

Every member of `Target(S)` gets a paraphrased statement with explicit binders,
domains, branches, orientations, normalizations, exceptional values, limiting
modes, and occurrence-local notation/entity associations. Ambiguity remains
unresolved rather than being repaired by plausible inference.

Every canonical entity record specifies aliases, argument order, parameter
roles, branches, singularities and totalization, real/complex agreement, and
the intended accepted Lean object with a proved identification theorem.
Value-changing normalizations remain distinct unless a reviewed equivalence
decision supplies the exact conversion without conflating values. Named
definitions are noncircular: they do not depend on later asymptotic,
approximation, or source-recovery results.

## 5. Quantitative-first theorem architecture

Every asymptotic or approximation member of `Target(S)` has two separately
visible deliverables:

1. a semantic exact result exposing the target function, finite approximant,
   remainder/error majorant, order, domain, thresholds, constants, branches,
   exceptional values, and parameter dependence; and
2. a faithful bridge recovering the exact DLMF qualitative/filter/Landau
   statement from the finite result.

The recovery bridge is a downstream consumer in `Audit/SourceRecovery`.
Definitions and semantic results never import audit recovery backwards. A
proof only of `O`, `o`, `~`, or another qualitative approximation does not
complete the quantitative deliverable. If DLMF supplies no explicit bound,
the finite strengthening is new mathematics and remains pending until its
complete natural-language proof and reviews succeed. It may not be laundered
through an assumed majorant, opaque target-shaped hypothesis, or chosen object.
This is exact mathematics, not numerical code.

Structural qualitative properties such as analyticity, continuation,
monotonicity, sign, uniqueness, and zero structure remain ordinary semantic
targets; they are not artificially converted into error bounds.

## 6. Cards, support closure, and stable state

Each Stage 1 target occurrence maps to at least one bounded Stage 1 target card.
Each prerequisite maps to a Stage 1 support card or exact pinned-mathlib reuse
record. “Every card,” “orphan card,” and completeness checks in this document
mean only those Stage 1 target/support records, never unrelated Olver,
BOOTSTRAP-0, IMPROPER-0, or other project cards.

A function or result invoked from Chapter 11 or later creates one explicit
support node with exact locator, statement, reason, consumers, and status. It
does not import the whole later chapter or earn later-chapter coverage. Support
is discharged only by exact pinned reuse, a bounded source-independent card, a
bounded out-of-range source-support card, or an honest unresolved/blocked
state. The last state permits planning progress but makes Stage 1 completion
false.

The reviewed schema migration allocates opaque, never-reused snapshot,
content-unit, occurrence, notation, entity, card, decision, and lineage IDs.
Human-readable locators may change; IDs do not. DLMF/Olver equivalence uses an
explicit crosswalk and never transfers coverage.

No overloaded status is permitted. The exact existing vocabularies from
[`theorem_cards/README.md`](theorem_cards/README.md) remain authoritative:
`specification_status`, `proof_status`, `review_status`,
`implementation_status`, `prototype_status`, `coverage_status`, and
`manifest_membership_status`; manifests separately expose `scope_closed` and
`manifest_status`.

Candidate-owned historical fields are immutable temporal self-descriptions.
Completion uses the **effective state reconstructed from exact-bound external
authority**, not literal rewrites of those fields. A frozen card may therefore
retain `review_status: not_started` and `implementation_status: not_started`
while an external envelope proves later approval and accepted implementation
for exact bytes. R2 never requires back-writing such a card.

The project-wide correctness controls in [`roadmap.md`](roadmap.md),
[`design_decisions.md`](design_decisions.md), and
[`theorem_cards/README.md`](theorem_cards/README.md) apply to every Stage 1
target/support card, not only asymptotic cards. Each applicable target preserves
exact natural constants and domains, proves advertised domain
reachability/nonemptiness and public-majorant nonnegativity, makes branches and
exceptional/totalized cases explicit, and forbids choice laundering or an
assumed target-shaped hypothesis. A non-applicable obligation needs the exact
frozen reason required by the card schema; it is never silently omitted.

## 7. Exact Stage 1 completion predicate

Stage 1 is complete iff all of the following hold for the selected snapshot and
all Stage 1 target/support records:

| Axis | Required effective terminal state |
|---|---|
| source snapshot | a successfully reviewed source-snapshot record binds the selected DLMF release/version identity and the full canonical Chapter 4--10 URL census, with each actual retrieval's date, content digest, method, and version evidence; no URL or snapshot review remains missing, failed, or unresolved |
| source census | every Chapter 4--10 content unit has a reviewed disposition; reference/nonmathematical totals reconcile separately; no underspecified or otherwise unresolved target remains |
| target denominator | `Target(S)` is derived by the §4 record-kind/role predicate; every member has confirmed applicable notation/entity links and complete card/declaration coverage; the deduplicated union of target-role occurrence mappings from all required Stage 1 target/support cards equals `Target(S)`, with zero missing or extra source claims; no Stage 1 target/support orphan remains |
| entities | every applicable canonical entity has the complete §4 specification, an accepted Lean object, and a proved reviewed identification; aliases/normalizations are resolved and definitions are noncircular |
| specification | `specification_status: frozen` for every required card |
| natural-language proof | `proof_status: complete`, or `proof_status: not_required` only where the frozen applicability reason is valid and an exact-bound external envelope confirms `not_required` |
| review | effective `review_status: approved`; every applicable source/semantics, proof/quantitative, structural-circularity, signature/card, and implementation review has an approving verdict bound to the exact bytes |
| authorization gates | every applicable external gate, including `lean_ready`, records `pass` for the same exact artifacts and dependency/pin state |
| implementation | effective `implementation_status` is `audited` or `released`, with a passing exact-byte implementation review; `compiled`, `compiled_unreviewed`, or prototype existence is insufficient |
| coverage | `coverage_status: reconciled` for every Stage 1 target occurrence; support-only cards use their correct non-source-credit disposition and cannot inflate `Target(S)` |
| manifests | every required Stage 1 target/support card belongs to at least one finite execution manifest having both `scope_closed: true` and `manifest_status: complete`; every required card's effective `manifest_membership_status` is `complete` |
| dependencies | zero blocked, unresolved, missing, or silently assumed target/support dependencies; all later-chapter and external-source support nodes have successful explicit discharge |
| quantitative asymptotics | every asymptotic/approximation target has both the accepted finite quantitative result and the accepted downstream faithful source-recovery bridge |

The effective state is the join of immutable candidate artifacts with external
records that bind their exact commit, digests, classifications, dependency
state, Lean/mathlib pins, review identities, and verdicts. A mismatched or later
artifact receives no inherited pass. Compilation, a closed scope, a present
envelope, or a rendered dashboard proves only itself.

### Mandatory negative fixtures

The eventual lifecycle/coverage validator must demonstrate that each fixture
below makes the completion predicate false:

| Fixture | Required rejection reason |
|---|---|
| an envelope is present but its review verdict is `changes_requested` or its gate verdict fails | presence is not approval/pass |
| a manifest has `scope_closed: true` but `manifest_status: execution_ready` | specification readiness is not completed execution |
| code has only `implementation_status: compiled` or `prototype_status: compiled_unreviewed` | compilation/prototype state is not `audited` or `released` with passing implementation review |
| a target occurrence is `selected`, `transcribed`, or `proved` but not `coverage_status: reconciled` | partial source progress is not terminal coverage |
| a required support node is explicitly `blocked` | an honest block remains incompatible with completion |

These are design requirements only; no validator or schema code is authorized
by this plan.

## 8. Tiny schema design fixture

The following invented records test accounting semantics. They are not DLMF
audit evidence, allocated production IDs, or real source counts.

| Unit | Fixture content and final disposition |
|---|---|
| `FX-U1` | mixed prose: explicit mathematical occurrence `FX-O1` plus nonmathematical metadata `FX-N1` |
| `FX-U2` | displayed formula occurrence `FX-O2` |
| `FX-U3` | a repeat appearance of that formula, retained separately as `FX-O3` |
| `FX-U4` | internal-cross-reference occurrence `FX-O4` |
| `FX-U5` | genuine external reference lead `FX-R1`, excluded from theorem targets |
| `FX-U6` | underspecified provisional row `FX-P1`; append-only review resolution creates explicit occurrence `FX-O5` and a lineage edge `FX-P1 -> FX-O5`, without changing `FX-P1` |

Fixture-only derived values are:

```text
content-unit total                 = 6
Target(FX-S)                       = {FX-O1, FX-O2, FX-O3, FX-O4, FX-O5}
theorem-occurrence denominator     = 5
reference-lead set                 = {FX-R1}
nonmathematical metadata set       = {FX-N1}
```

Suppose `FX-CARD-A` associates with `FX-O1,FX-O2,FX-O3`, `FX-CARD-B` with
`FX-O4,FX-O5`, and `FX-CARD-C` also with `FX-O5`. There are six association
rows but the deduplicated
covered-occurrence set has five members and equals `Target(FX-S)`. This proves
that many-to-many associations do not inflate source counts. Before the
append-only resolution of `FX-P1`, completion is false.

## 9. Audit and review protocol

1. Create the reviewed multi-track schema migration and DLMF source-manifest
   format without modifying frozen Olver rows or meanings.
2. Retrieve a bounded Chapter 4 URL/content-unit census, recording actual
   per-page dates, digests, and version evidence. Perform forward and reverse
   passes and independent review of exclusions. Publish counts only after that
   review.
3. Use [§4.13](https://dlmf.nist.gov/4.13) as the omission-sensitive pilot. It
   must classify `W_k`, `Wp`, `Wm`, Wright omega, and Tree `T` occurrence and
   entity relationships without assuming the answer from their names.
4. Extract atomic statements, local notation, entities, aliases,
   normalizations, branches, exceptions, domains, cross-references, tables,
   captions, and prose. Keep ambiguity and underspecification explicit.
5. Select only finite closed target/support batches. New mathematics needs a
   complete natural-language proof before signature design and at least two
   fresh independent pre-Lean reviews: source/semantics and proof/quantitative.
   Construction, continuation, identification through existence/uniqueness,
   nontrivial recovery, zeros, connections, turning points, and theorem-sized
   hypothesis packets add structural-circularity review.
6. After external `lean_ready: pass`, implement only the exact frozen packet,
   then obtain build/regression/import/axiom and implementation reviews and
   reconcile coverage. A material change invalidates affected approvals.

Bibliographic, software, and visual-media records are never advertised as
proved theorems. Pure reference leads receive no theorem credit, while
independent source review must ensure that substantive mathematics was not
evaded by misclassifying it as reference-only.

## 10. Verso handoff

A preliminary Verso site may read future snapshot, content-unit, occurrence,
notation, entity, card, dependency, decision/lineage, external-review, and
manifest records. It should filter by chapter/section/function; show source,
proof, review, implementation, coverage, and manifest axes separately; expose
unresolved and failed states; distinguish DLMF from Olver; and label fixture or
provisional counts unmistakably.

Verso is a read-only projection. Stable IDs back links, but the underlying
versioned records and exact-bound external authorities determine truth. A
dashboard cannot approve mathematics, alter lineage, authorize Lean, or turn a
reference lead into coverage.

## 11. Present truth

The user-authorized broad Stage 1 boundary is recorded, and the official DLMF
pages above were used for limited discovery verification of version, chapter
structure, and named sentinels. No full page census, real occurrence count,
schema migration, source reconciliation, theorem-card set, proof set, review
quorum, external gate, closed/complete DLMF manifest, Lean implementation, or
coverage percentage is claimed.

DD-021 revision 1 and this five-file successor remain pending until the exact
effective rule at the start of this document is satisfied. Until then they are
not operative programme authority.
