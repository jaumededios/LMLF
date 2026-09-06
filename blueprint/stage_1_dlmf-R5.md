# Proposed Stage 1: DLMF through Chapter 10 — revision 5

**Normative owner:** `jaumededios`
**Document status:** proposed operative implementation plan; pending fresh review and external adjudication
**Decision proposed here:** `DD-021`, revision 4
**Scope decision date:** 2026-09-06
**Discovery access date:** 2026-09-06; not an audit-wide retrieval date
**Provisional source target:** NIST DLMF version 1.2.7, released 2026-06-15

This is the complete revision-5 successor proposal to
[`blueprint/stage_1_dlmf-R4.md`](stage_1_dlmf-R4.md). Revisions 1--4 remain
immutable historical review inputs. R4's exact bytes received two
`request_changes` reviews identifying bounded specification defects; neither
verdict is a claim of a current production emergency. No predecessor proposal
has operative authority. This document authorizes no source census, schema
migration, theorem card, Lean implementation, coverage claim, or Verso
authority.

## DD-021 revision 4 — proposed Stage 1 programme and architecture amendment

### Decision and effective rule

The user has authorized the broad programme boundary: Stage 1 is DLMF through
Chapter 10 at specific-function and atomic mathematical-assertion granularity,
with Chapters 1--3 treated selectively as infrastructure and Chapters 4--10
audited for essentially every mathematical website statement, including prose.

This **operative plan is still pending**. DD-021 revision 4 takes effect only
after both of the following exist for the exact same six-file successor bytes,
identified by these repo-relative paths:

- `README.md`;
- `blueprint/README.md`;
- `blueprint/roadmap.md`;
- `blueprint/design_decisions.md`;
- `blueprint/source_manifest.md`; and
- `blueprint/stage_1_dlmf-R5.md`.

1. two fresh, independent blueprint reviews with approving verdicts, each bound
   to the exact commit and artifact digests; and
2. a root external adjudication recording acceptance, also bound to that exact
   commit, the six artifact digests, and the two review identities.

Candidate-owned prose cannot satisfy either condition. Until both conditions
hold, the existing frozen control-plane text remains operative and this R5 is
planning-only. A material edit resets the reviews and adjudication requirement.

### Exact bounded amendment once effective

When the effective rule is satisfied, DD-021's subject-matter boundary is
exhaustively limited to (a) DLMF programme scope, nomenclature, priority, and
scheduling and (b) the placement boundary between reusable semantic
mathematics and source-specific recovery. Within those two subjects, this
accepted successor prevails over every older statement that assigns a
conflicting global programme meaning or an incompatible layer rule. The
concrete sites below are audited, traceable examples;
they are not the sole precedence mechanism, so an omitted legacy phrase cannot
revive another global meaning of Stage 1 or the source target. This is not
authority to supersede unrelated requirements.

Programme priority and scheduling:

- the opening scope sentence in repo-root `README.md` that globally calls the
  corrected 1997 Olver reprint LMLF's first source-coverage programme;
- the `blueprint/roadmap.md` “Mission and fixed scope” sentence that calls Olver (1997)
  the first source-coverage programme;
- the `blueprint/roadmap.md` M3 sentence saying that work cannot delay “the first source
  MVP,” plus the M5 heading and scheduling language that make the first true
  source MVP the quantitative Olver Watson packet;
- the first sentence of `blueprint/design_decisions.md` DD-001 that calls Olver the
  initial source programme; and
- the `blueprint/design_decisions.md` DD-011 scheduling statement that makes the first
  true MVP the Olver Watson theorem;
- the sentence in `blueprint/qualitative/release_strategy.md`, under
  “Alternate editions and corrections,” calling the 1997 corrected reprint the
  initial source target; and
- the sentence in `blueprint/qualitative/navigation_and_docs.md`, under
  “Initial documentation slice,” calling the Watson page the first true
  source-facing success.

The replacement scheduling rule is: the DLMF Stage 1 programme described here
has programme priority, while executable work proceeds only through separately
closed, reviewed, authorized finite manifests.

Scope terminology:

- the `blueprint/README.md` field `Source target`, which is narrowed to
  `Olver-track source target`; and
- the complete staged-release ladder in
  `blueprint/qualitative/release_strategy.md`, including its
  “Stage 1 — single-occurrence source pilot” heading and every stage-completion
  or stage-release use governed by that ladder.

After activation, unqualified programme **Stage 1** means only the DLMF
Chapters 4--10 programme defined here. Every stage label in that immutable
legacy release ladder is interpreted as `Olver release stage N`; in
particular, its one-occurrence Watson pilot is `Olver release stage 1`, not
completion or release of DLMF Stage 1. This is a track-local interpretation of
the preserved bytes, not a rewrite of their historical evidence.

Structural API placement:

- the `blueprint/README.md` introductory statement that reusable public
  mathematics is finite and quantitative and source-faithful qualitative
  consequences live under `Audit/SourceRecovery`;
- `blueprint/design_decisions.md` DD-003, “Quantitative public theorem
  shapes”; and
- the `Semantic core` and `Audit companion` rows of the product split in
  `blueprint/qualitative/release_strategy.md`.

Those clauses are clarified as follows. Reusable exact or structural
mathematics—including analyticity, continuity, analytic continuation,
monotonicity, sign, uniqueness, zero structure, and exact identities—belongs
in semantic modules alongside finite quantitative producers. Source-specific
notation restatements and faithful source-recovery statements belong in
`Audit/SourceRecovery` and consume semantic declarations; semantic modules
never import them backwards. This clarification admits reusable qualitative
structure to the semantic API but does not weaken quantitative-first
architecture: every genuine asymptotic or approximation atom still has the
mandatory finite quantitative producer and separate faithful recovery required
by §5, and a qualitative-only theorem cannot substitute for that producer.

No subject outside those two bounded areas is superseded or narrowed. Legacy
source-specific mathematics, the Olver edition lock, source-snapshot and
edition relations, occurrence/notation/entity IDs, transcriptions, theorem
cards, natural-language proofs, review records, classifications, manifests,
implementation evidence, and coverage semantics remain unchanged. In
particular, every frozen artifact and CSV row whose baseline is commit
`3a1b16cae6d186a20530de3b883c1bb871ee76f6` remains immutable historical and
operative evidence for its own claim.

Olver-labelled phrases that are already track-local remain true in that narrow
sense: in particular, “first true quantitative-Olver MVP” in
`blueprint/README.md` and “OLV-MVP-1 — first source theorem planning manifest”
in `blueprint/source_manifest.md` describe ordering inside the parallel Olver
track, not global programme priority. The two qualitative-document clauses
listed above likewise remain usable only as Olver-track-local ordering after
DD-021 becomes effective. All other unqualified stage labels governed by the
legacy qualitative release ladder are likewise Olver-track-local. This scopes
programme language and clarifies API placement; it does not alter historical
status evidence or imply acceptance of IMP or any other artifact.

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

The broad boundary is neither a closed source-audit manifest nor a closed Lean
execution manifest. A finite source-audit batch can establish only its own
reviewed local denominator and counts; those are always batch-scoped and never
a Stage 1 percentage. The whole-programme denominator does not exist until the
separate global closure described in §4. Every executable batch still requires
a finite closed Lean execution manifest; chapter wildcards and “related
results” are forbidden there.

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

Each finite reviewed source-audit manifest must enumerate every payload-owning
canonical retrieval document in its explicit closed batch. The global
`B_all^r` manifest must enumerate the full canonical Chapter 4--10 retrieval-
document census. Each actual retrieval is bound to its retrieval date, content
digest, retrieval method, redirect chain, and observed version evidence. A root
version label is not a per-document digest.
If the website changes during the audit, a new snapshot plus explicit versioned
schema/data migration is required; changed bytes are never silently assigned to
the 1.2.7 snapshot. Snapshot successors use append-only cross-snapshot evolution
(`unchanged`, `modified`, `split`, `merged`, `added`, or `removed`).

Before issuing any source-appearance or occurrence ID, an exact-bound source
review establishes one payload-owning canonical retrieval-document identity
for each DLMF content family after redirect normalization. It reconciles
aggregation pages versus genuinely distinct documents and records every known
request alias. Fragments, equation/subsection permalinks, redirecting shorthand
paths, format variants, and query/customization variants are locators or
representations of that document unless an exact-byte audit proves that they
carry genuinely distinct payload. Neither another locator nor another rendering
may mint an occurrence.

HTML/MathML, TeX, and image fallbacks are representations of one payload unless
a reviewed audit finds a substantive mismatch. Mismatches remain explicitly
unresolved until reconciled. The census follows proved payload identity rather
than assuming a numeric section tier: a genuinely distinct item such as
`7.SB1` must be retained even if the site serves it outside the usual section
hierarchy. Store locators, hashes, audit metadata, short indispensable
fragments, and independent mathematical paraphrases; do not mirror bulk prose,
tables, or figures. Follow the official
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
among all four kinds of lead. `Wp` and `Wm` are alias candidates whose
domains, boundary values, and branch-side conventions require review; this plan
does not prejudge their branch identities. Wright omega and Tree `T` remain
distinct named-entity candidates unless the reviewed entity schema chooses a
canonical construction plus explicit identification bridges. No generic
“Lambert W” row can stand in for this audit.

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

## 4. Reviewed source partition and exact denominator

### Containers, source-owning leaves, and atomic claims

Give every chapter, section, subsection, formula block, prose block, table,
caption, figure, application block, computation block, software block, and
reference block a stable content-unit ID. A hierarchy/container record supplies
navigation and parentage but owns no source payload and cannot enter a target
denominator. Beneath the hierarchy, source-owning leaf records account for the
complete payload of every canonical retrieval document. Each leaf receives a
reviewed
disposition `mathematical`, `mixed`, or `nonmathematical`; every
mathematical piece receives a fidelity role:

- `explicit_mathematical_assertion`: a self-contained formula, definition, or
  sufficiently definite prose proposition;
- `internal_cross_reference_assertion`: a mathematical assertion defined by
  an exact DLMF cross-reference and specialization;
- `underspecified_mathematical_claim`: substantive mathematics whose faithful
  target is not yet sufficiently stated; or
- `mathematical_reference_lead`: a report that external literature treats a
  named topic/regime without reproducing a theorem.

Leaf ownership is exclusive and exhaustive at the level of source payload:
every canonical retrieval-document item has one source-owning leaf. This does
**not** require
literal character ranges, displayed hypotheses, notation, or contextual spans
to be disjoint. Several atomic claims in one formula or prose block may cite
the same exact-bound context record, including a shared “uniformly for” clause.
The context is retained once with exact provenance and referenced by every
dependent atom. It is not counted again as a theorem occurrence unless it
itself makes a separately reviewed assertion. Container/child overlap is
likewise navigation, never duplicate payload ownership.

Every mathematical or mixed leaf has an exact-bound atomicization record whose
external source review certifies a complete semantic decomposition: all and
only its mathematical assertions are represented, no semantic claim is omitted
or owned twice, and its reference-only and nonmathematical remainder is
explicitly reconciled. This is semantic nonoverlap, not a requirement for
nonoverlapping source spans or hypotheses.

Each source appearance has a canonical immutable identity within its snapshot
and payload-owning retrieval document. Locator and representation aliases are
reconciled before this identity is minted.
Every atomic record owns exactly one canonical immutable key

`(snapshot_id, source_appearance_id, atom_ordinal)`.

`source_appearance_id` binds its canonical retrieval-document identity, leaf,
semantic location, locator/span evidence, representation digests, and
appearance ordinal. Redirects, fragments, equation/subsection permalinks,
formats, or query/customization aliases for that semantic location reuse the
same appearance ID. By contrast, two genuine printed/served semantic locations
of the same formula or prose claim—even within one retrieval document—have
different appearance identities and remain distinct occurrences. Within one
appearance, each semantic atom has one ordinal and one effective occurrence ID
in a selected correction view; two IDs for the same ownership key in that view
are forbidden. Human-readable locators may change without changing the key.

Forward and reverse/checklist passes reconcile all headings, equations,
notations, figures, tables, leaves, and containers. Contents, indices, search,
notation lists, and TOCs are discovery aids, not denominators. An independent
source reviewer checks every retrieval-document/alias reconciliation, source
partition, atomicization, fidelity-role, exclusion, and provisional-resolution
decision against the exact snapshot.

### Append-only correction, resolution, and snapshot evolution

Record kinds are immutable. Real atomic targets, provisional unresolved claims,
mathematical reference leads, nonmathematical records, source leaves, and
containers remain distinct; no effective-state reconstruction relabels a
historical row. Three typed append-only relations have different effects.

A **within-snapshot source-identity correction** repairs a mistaken
canonical-retrieval-document or source-appearance partition without inventing a
new source-byte snapshot. It may map predecessor document/appearance/atom sets
to successor sets in the same snapshot. An erroneous pair of alias appearances
may coalesce into one fresh successor appearance; one appearance that wrongly
collapsed two genuine semantic locations may split into two fresh successor
appearances. The exact-bound external review proves that successor sets
preserve and exhaust the **actual distinct source payload and semantic
locations**, without preserving an erroneous record multiplicity or losing a
real repeat. Equal formula bytes are never sufficient reason to coalesce
genuinely different locations. The old records remain historical and become
non-effective only in an audit revision that pins the approved correction.

A **within-snapshot same-appearance atomization/resolution correction** selects
an effective atomic decomposition after source identity is fixed. Its split or
merge endpoints must all have the same `snapshot_id` and
`source_appearance_id`. A split names a nonempty successor set and proves
that successors' semantic claim ownership is pairwise nonduplicative and
exactly exhausts the predecessor. A merge proves that its successor owns
exactly the union of its named predecessors, without loss or duplication.
Shared context references remain permitted, and the correction proof must
retain or explicitly map their exact hypotheses and provenance. A
zero-successor correction is forbidden unless an exact-bound reviewed
exclusion accounts for the whole former payload; it can never silently resolve
a substantive claim. This atom-level relation cannot collapse distinct source
appearances.

No correction rebinds or recycles an immutable document, appearance,
occurrence, or ownership identity. Every source-identity successor receives
fresh, never-used document/appearance IDs as applicable, and every atom under a
fresh or corrected appearance receives a fresh ordinal, ownership key, and
occurrence ID. Every same-appearance atom successor likewise receives a fresh,
never-used `atom_ordinal`, ownership key, and occurrence ID. Predecessor
identities and evidence remain intact. The audit revision's selected view
determines which immutable records are effective, never what those records
identify.

A **cross-snapshot evolution** relation records `unchanged`, `modified`,
`split`, `merged`, `added`, or `removed` provenance between possibly
set-valued atom sets when website structure changes. It never supersedes,
deactivates, rewrites, or changes the target membership of an earlier snapshot.
Each snapshot retains its own immutable occurrence keys and reviewed correction
view; the snapshot filter prevents cross-snapshot co-counting. Thus an
evolution merge may relate several old appearances to a new one without making
any one atom own multiple appearance keys.

An underspecified claim remains `provisional_unresolved_claim` and blocks the
applicable correction view. Review may resolve it within the same snapshot and
appearance by append-only creation of one or more real atomic target records,
or by an exact-bound decision showing that the complete payload is
reference-only/nonmathematical. The provisional ID never enters the target set
and is never relabeled. Thus resolving fixture `FX-P1` by creating `FX-O5`
can add only `FX-O5`; the pair can never both count in one selected view.

### Batch partition readiness and role-filtered target sets

A source-audit batch `B` is a finite, exact-bound audit manifest naming its
snapshot, canonical retrieval documents/source-owning leaves, alias
reconciliations, shared contexts, and all required hierarchy needed to
interpret them. It also pins by exact ID/digest the complete within-snapshot
source-identity, atomization/resolution, lineage, fidelity/exclusion, and
obligation-classification decision view used for its result; it never performs
a mutable “latest record” lookup. Its membership is explicit:
chapter wildcards, open-ended “related content,” and discovery-only TOC ranges
are not closed audit membership.

For snapshot `S` and audit batch `B`, `PartitionReady(S,B)` holds only
when `B` is successfully scope-closed and independently reviewed and every
retrieval document and leaf it names is exact-bound. All of `B`'s document-
alias, source-identity-correction, source-partition, atomicization,
fidelity-role, exclusion, effective-resolution/lineage, and classification
reviews must be present and approving for the pinned view, with no unresolved
or invalid lineage inside the batch. Missing, pending, `changes_requested`,
or failed review makes it false.

`Target(S,B)` is a **partial value**. It is undefined—not the empty set—
unless `PartitionReady(S,B)` holds. Once it holds:

```text
Target(S,B) = {
  o.occurrence_id |
    o.record_kind = atomic_target_occurrence
    and o.snapshot_id = S
    and o source appearance is a member of B
    and 4 <= o.chapter <= 10
    and o is effective and successfully resolved in B's pinned view
    and o has exactly one canonical ownership key
    and o.immutable_fidelity_role in {
      explicit_mathematical_assertion,
      internal_cross_reference_assertion
    }
}
```

`Target(S,B)` is a set of immutable effective atomic IDs, not a count of pages,
leaves, association rows, cards, declarations, or entities. Reference-only and
nonmathematical records remain outside it but must reconcile separately.
Repeated source appearances remain different atoms. Superseded predecessors
remain historical but cannot be counted with their effective successors in the
same pinned view. One occurrence
may need several cards and one card may cover several occurrences; source
totals use the deduplicated target set.

Canonical source-appearance and atom identities are snapshot-wide, not
batch-local. If two reviewed audit batches overlap, the same source appearance
and semantic atom must reuse the same canonical IDs; batch membership cannot
mint a duplicate occurrence. The deduplicated union therefore collapses the
same appearance across batches while retaining genuinely repeated appearances
at distinct source locations. Counts from overlapping batches may be unioned
only when their pinned correction/resolution/classification views agree on the
overlap; incompatible views require explicit reconciliation and fresh review.

The source snapshot identifies retrieved website bytes. The immutable audit
revision identifies the reviewed decision view over those bytes. A correction
does not by itself create a new source-byte snapshot: it creates a new audit-
manifest revision with a newly pinned view. Every earlier exact-bound audit
revision and its denominator remain reproducible and unchanged.

A separately reviewed global closure audit revision `B_all^r` must prove that
its canonical retrieval-document/leaf membership exhausts Chapters 4--10, that
all document aliases are reconciled, and that the source union has neither gaps
nor duplicate ownership. Only when `PartitionReady(S,B_all^r)` succeeds may
that exact closure revision be explicitly selected for the whole-programme
value:

```text
Target(S) = Target(S,B_all^r)
```

Before that global gate and explicit selection, `Target(S)` is undefined even
when one or more local `Target(S,B)` values exist. The shorthand always names
the one selected exact closure revision; a later audit correction/revision does
not silently mutate it. Selecting a different successful closure is an
explicit reviewed successor decision, and the prior denominator remains
reproducible.

Selection or replacement of the global closure is authoritative only through
an external root adjudication record. It binds the exact source snapshot `S`,
the selected `B_all` revision ID and digest, the complete pinned decision-view
ID and digest, the prior selection record if one exists, and the identities and
approving verdicts of two fresh independent global-closure reviewers. Those
reviews verify global exhaustion and reconciliation and may rely on completed,
exact-bound per-document/per-leaf reviews; they need not repeat a second bulk
source census. Candidate-owned prose, manifests, dashboards, or self-status
cannot select or replace the closure.

Acceptance of material counterevidence that undermines the selected closure
must, in the same exact-bound root external record, withdraw or suspend its
current authority. The root may also suspend on recorded, justified material
doubt. A positive review quorum is not required for conservative suspension;
an unreviewed allegation alone is not accepted counterevidence and makes no
binding change. Withdrawal or suspension immediately makes current `Target(S)`
authority undefined and Stage 1 completion false/pending until a valid
successor closure is reviewed and selected; it never silently falls back to an
older selection. The immutable
historical set `Target(S,B_old)` and its evidence remain reproducible, but may no
longer be presented as valid current completed coverage. Selection and
withdrawal cannot change the user-authorized Chapters 4--10 material boundary.
A material scope amendment again requires two fresh independent blueprint
approvals and root external adjudication bound to the exact successor bytes.

Reviewed finite audit batches may nevertheless
feed separately authorized finite Lean execution manifests, together with
explicitly closed support dependencies, without waiting for unrelated chapters.
An audit manifest establishes source partition and a local denominator; a Lean
execution manifest controls proof/implementation work. Neither substitutes for
the other.

Every member gets a paraphrased statement with explicit binders, domains,
branches, orientations, normalizations, exceptional values, limiting modes,
shared-context references, and occurrence-local notation/entity associations.
Ambiguity remains unresolved rather than being repaired by plausible inference.

Every canonical entity record specifies aliases, argument order, parameter
roles, branches, singularities and totalization, real/complex agreement, and
the intended accepted Lean object with a proved identification theorem.
Value-changing normalizations remain distinct unless a reviewed equivalence
decision supplies the exact conversion without conflating values. Named
definitions are noncircular: they do not depend on later asymptotic,
approximation, or source-recovery results.

## 5. Total obligation classification and quantitative-first architecture

Every member of any defined `Target(S,B)` has exactly one immutable
source-semantics classification effective in `B`'s pinned view:

- `finite_quantitative_plus_source_recovery`; or
- `ordinary_exact_or_structural`.

The class is determined by mathematical meaning, not by scheduling or the
desired proof shape: every genuine asymptotic or approximation assertion
**must** be `finite_quantitative_plus_source_recovery`. An
`ordinary_exact_or_structural` row cannot waive that rule, even when it
contains a reason. The external source reviewer must verify the occurrence's
meaning and the classification against the exact source bytes. An ordinary
class includes a frozen, occurrence-specific reviewed explanation showing why
the assertion is not asymptotic or approximative and why the pair is
inapplicable. Missing, duplicate-effective, semantically wrong, pending, failed,
or `changes_requested` classification blocks the local execution packet and
Stage 1 completion. A correction supersedes a classification append-only; it
never alters historical meaning. Thus the quantitative subset cannot shrink
merely because an applicability row was omitted or mislabeled.

Every occurrence classified
`finite_quantitative_plus_source_recovery` has exactly two designated,
exact-bound primary obligation mappings:

1. role `semantic_finite_quantitative`, naming the occurrence, bounded target
   card, accepted Lean declaration, and accepted evidence for a result exposing
   the target function, finite approximant, remainder/error majorant, order,
   domain, thresholds, constants, branches, exceptional values, and parameter
   dependence; and
2. role `faithful_source_recovery`, naming the same occurrence, a distinct
   bounded recovery card, accepted Lean declaration, and accepted evidence
   recovering the exact assertion printed by DLMF.

Each role has exactly one designated mapping; helper cards and declarations may
exist but cannot substitute for either mapping or create extra source credit.
Both cards, declarations, roles, exact bytes, and external approvals are named
in the occurrence record's accepted evidence. The recovery declaration is a
downstream consumer in `Audit/SourceRecovery`: it imports the semantic finite
result, while definitions and semantic results never import recovery backwards.

The printed source assertion may itself be a finite estimate, or it may be a
qualitative/filter/Landau statement. For the latter, recovery derives that
statement from the finite result. For an already explicit finite source bound,
the faithful recovery may be an exact identity, restatement, or specialization
bridge from the reusable semantic theorem to the source's notation and domain;
it must not invent a qualitative claim absent from the source or duplicate the
finite mathematics merely to fill two roles.

A proof only of `O`, `o`, `~`, or another qualitative approximation does
not complete the finite deliverable. A finite theorem without the faithful
recovery bridge, or recovery without the finite theorem, is also incomplete. If
DLMF supplies no explicit bound, the finite strengthening is new mathematics
and remains pending until its complete natural-language proof and reviews
succeed. It may not be laundered through an assumed majorant, opaque
target-shaped hypothesis, or chosen object. This is exact mathematics, not
numerical code.

Structural qualitative properties such as analyticity, continuation,
monotonicity, sign, uniqueness, and zero structure remain ordinary semantic
targets when the reviewed classification says so; they are not artificially
converted into error bounds.

The placement rule has these representative cases:

| Source assertion | Required placement |
|---|---|
| direct analyticity, continuity, or analytic-continuation theorem | reusable ordinary structural declaration in a semantic module |
| direct monotonicity or sign theorem | reusable ordinary structural declaration in a semantic module |
| direct uniqueness or zero-structure theorem | reusable ordinary structural declaration in a semantic module |
| ordinary exact identity | reusable exact declaration in a semantic module; any source-notation-only restatement is a downstream audit consumer |
| genuine asymptotic or approximation assertion | finite quantitative producer in a semantic module **and** the distinct faithful source bridge in `Audit/SourceRecovery` |

Source occurrence credit still requires exact source identification and all
applicable reviews; placement in a reusable semantic module does not turn a
generic theorem into source evidence by itself.

Lifecycle clarification: references in §§4--7 to accepted Lean declarations,
proved entity identifications, and accepted implementation evidence are
**completion obligations**, not preconditions for a source census or for
beginning the proofs that will discharge them. Planning records and selected
cards may instead name proposed Lean objects, frozen signature targets, and
explicitly pending identification or implementation obligations. This does not
lower any gate: new mathematics still requires its complete natural-language
proof, fresh proof reviews, and external `lean_ready: pass` on the exact frozen
packet, all before implementation.

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
content-unit, source-appearance, occurrence, notation, entity, card, decision,
and lineage IDs. Human-readable locators may change; IDs do not. DLMF/Olver
equivalence uses an explicit crosswalk and never transfers coverage.

No overloaded status is permitted. The exact existing vocabularies from
[`theorem_cards/README.md`](theorem_cards/README.md) remain authoritative:
`specification_status`, `proof_status`, `review_status`,
`implementation_status`, `prototype_status`, `coverage_status`, and
`manifest_membership_status`; manifests separately expose `scope_closed`
and `manifest_status`.

Candidate-owned historical fields are immutable temporal self-descriptions.
Completion uses the **effective state reconstructed from exact-bound external
authority**, not literal rewrites of those fields. A frozen card may therefore
retain `review_status: not_started` and
`implementation_status: not_started` while an external envelope proves later
approval and accepted implementation for exact bytes. R3 never requires
back-writing such a card.

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
| source snapshot | a successfully reviewed source-snapshot record binds the selected DLMF release/version identity and full canonical Chapter 4--10 retrieval-document census, with every redirect/locator/representation alias reconciled and each actual retrieval's date, content digest, method, redirect chain, and version evidence bound; no document, alias, or snapshot review remains missing, failed, or unresolved |
| global audit closure | one exact global audit revision `B_all^r` proves that its canonical retrieval-document/leaf membership exhausts Chapters 4--10; `PartitionReady(S,B_all^r)` holds for its pinned decision view, with complete hierarchy/leaf inventory and semantic atomization exact-bound, exhaustive, nonduplicative, and all document-alias, source-identity-correction, partition, atomicization, role, exclusion, classification, and resolution/lineage reviews approving |
| global selection authority | an external root adjudication selects that exact closure and binds `S`, the `B_all` revision ID/digest, full decision-view ID/digest, any prior selection, and two fresh independent global-closure review identities and approving verdicts; no candidate-owned self-selection is effective |
| current closure validity | no exact-bound root withdrawal accepting counterevidence is in force; if one is, current `Target(S)` is undefined and completion is false/pending with no fallback, while the withdrawn historical batch set remains reproducible but not current completed coverage |
| source census | every Chapter 4--10 leaf and container is reconciled; reference/nonmathematical totals reconcile separately; no underspecified or otherwise unresolved target remains |
| target denominator | `Target(S) = Target(S,B_all^r)` is defined by §4 from atoms effective in the selected closure revision's pinned view; every member has confirmed applicable notation/entity links and complete card/declaration coverage; older closure revisions retain their exact historical denominators |
| target/card equality | every required Stage 1 target/support card belongs to a finite closed complete execution manifest; the deduplicated union of those cards' **target-role** occurrence mappings equals `Target(S)`, with zero missing or extra source claims; support-only mappings earn no target credit and no Stage 1 target/support orphan remains |
| obligation classification | every member of `Target(S)` has exactly one immutable §5 classification effective in the selected closure revision's pinned view, with approving exact-bound external source review; every ordinary target has its reviewed frozen inapplicability reason |
| quantitative mappings | every quantitative-class target has exactly one accepted named card/declaration/evidence mapping for each §5 role, and the recovery dependency points from `Audit/SourceRecovery` to the semantic finite result |
| module placement | reusable exact/structural declarations and finite quantitative producers obey §5's semantic-module rule; source-specific notation/recovery declarations live in `Audit/SourceRecovery`, which consumes semantic modules and is never imported backwards |
| entities | every applicable canonical entity has the complete §4 specification, an accepted Lean object, and a proved reviewed identification; aliases/normalizations are resolved and definitions are noncircular |
| specification | `specification_status: frozen` for every required card |
| natural-language proof | `proof_status: complete`, or `proof_status: not_required` only where the frozen applicability reason is valid and an exact-bound external envelope confirms `not_required` |
| review | effective `review_status: approved`; every applicable source/semantics, proof/quantitative, structural-circularity, signature/card, and implementation review has an approving verdict bound to the exact bytes |
| authorization gates | every applicable external gate, including `lean_ready`, records `pass` for the same exact artifacts and dependency/pin state |
| implementation | effective `implementation_status` is `audited` or `released`, with a passing exact-byte implementation review; `compiled`, `compiled_unreviewed`, or prototype existence is insufficient |
| coverage | `coverage_status: reconciled` for every Stage 1 target occurrence; support-only cards use their correct non-source-credit disposition and cannot inflate `Target(S)` |
| manifests | every required Stage 1 target/support card belongs to at least one finite execution manifest having both `scope_closed: true` and `manifest_status: complete`; every required card's effective `manifest_membership_status` is `complete` |
| dependencies | zero blocked, unresolved, missing, or silently assumed target/support dependencies; all later-chapter and external-source support nodes have successful explicit discharge |

The effective state is the join of immutable candidate artifacts with external
records that bind their exact commit, digests, classifications, dependency
state, Lean/mathlib pins, review identities, and verdicts. A mismatched or later
artifact receives no inherited pass. Compilation, a closed scope, a present
envelope, a defined denominator, or a rendered dashboard proves only itself.

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
| a mathematical assertion in a batch leaf has no atom | that semantic source partition is not exhaustive and `Target(S,B)` is undefined; if it occurs in selected `B_all^r`, `Target(S)` is also undefined |
| two occurrence IDs claim one ownership key, or parent and child both claim one semantic payload | duplicate semantic ownership invalidates the partition |
| two atoms legitimately share hypotheses/spans but the context is counted as another occurrence without its own reviewed assertion | shared context is provenance, not automatic target duplication |
| any partition, atomicization, fidelity-role, exclusion, classification, or resolution review is missing, pending, failed, or `changes_requested` | no unapproved row can disappear from the denominator or obligation set |
| a within-snapshot **same-appearance atomization/resolution** split/merge has a semantic gap, duplicate/overlapping claim ownership, an unjustified zero-successor result, or endpoints from different canonical appearances | that atom-level correction does not preserve one appearance's semantic payload and ownership key |
| a provisional record is retained as active alongside its target successor | immutable history cannot double-count effective targets |
| a target has no obligation classification, or has two classifications effective in the pinned view | classification is not total and single-valued |
| an asymptotic/approximation target is assigned the ordinary role, or only receives a qualitative `O`/`o`/`~` proof | the mandatory semantic classification or finite quantitative deliverable is evaded or absent |
| a quantitative target's mapping is missing, pending, rejected, names the wrong role/occurrence, or lacks accepted exact-byte evidence | role names and mere artifact presence do not prove discharge |
| a quantitative target has an accepted finite result but no accepted recovery, or accepted recovery but no accepted finite result | both designated obligation roles are mandatory |
| every manifest is complete but one required Stage 1 target/support card belongs to none of them | successful manifests do not cover an orphan card |
| a finite reviewed audit batch exists but its local count is reported as the whole Stage 1 denominator or percentage | `Target(S,B)` does not define `Target(S)` without a reviewed, explicitly selected `B_all^r` |
| an audit batch and a Lean execution manifest are treated as the same gate, or the execution manifest contains a chapter wildcard | source closure does not authorize an open-ended implementation packet |
| overlapping audit batches mint different IDs for the same source appearance/atom | batch membership cannot duplicate snapshot-wide canonical identity |
| a genuinely asymptotic/approximation assertion is assigned ordinary status despite a present reviewed “reason” | semantic meaning makes the quantitative/recovery class mandatory and non-waivable |
| an explicit finite source estimate is “recovered” as an invented qualitative claim | recovery must match the exact printed source assertion |
| `/10.61`, redirecting `/10.61.i`, and `/10.61.E1` mint separate appearances for the one displayed formula they locate | redirect/locator aliases do not own separate payload |
| two genuinely distinct semantic locations printing the same formula are collapsed into one appearance | true repeated locations require two source appearances; content equality is not alias identity |
| a correction successor reuses a predecessor's atom ordinal, ownership key, or occurrence ID | immutable identities are never rebound; fresh successors receive fresh keys with lineage |
| a within-snapshot **same-appearance atomization/resolution** merge attempts to collapse otherwise valid atoms at two distinct source appearances | atom-level correction merges are appearance-local; source-identity correction has its separate exact-location rules and still cannot coalesce genuine repeats |
| accepting a successor snapshot deactivates or changes the earlier snapshot's closed target set | cross-snapshot evolution is non-deactivating provenance |
| a later audit correction or “latest” lookup changes an earlier batch's reported denominator | every audit revision pins its exact decision view; a new revision cannot mutate the old one |
| overlapping batch counts are unioned despite incompatible pinned decision views | overlap requires compatible views or explicit reconciliation and fresh review |
| a one-occurrence Olver release is labelled unqualified “Stage 1 complete” or the blueprint's Olver source field is read as the global DLMF target | legacy release stages and source-target wording are Olver-track-local |
| a reusable analyticity, monotonicity/sign, uniqueness, zero-structure, or exact-identity theorem is forced into `Audit/SourceRecovery` merely because it is qualitative | reusable structural mathematics belongs in semantic modules |
| a source-specific restatement is placed in the semantic producer layer or semantic code imports `Audit/SourceRecovery` | source recovery is a downstream audit consumer |
| mistaken alias appearances cannot be coalesced without rebinding an old ID, or a collapsed pair of genuine locations cannot be split | the typed source-identity correction must create fresh successors preserving actual source multiplicity |
| equal formulas at genuinely distinct locations are coalesced by source-identity correction | content equality cannot erase a true repeated appearance |
| a candidate manifest or dashboard selects/replaces global closure, or the external record omits any required snapshot/revision/view/prior-selection/reviewer binding | only a complete external root adjudication can select current global authority |
| a root record accepts material counterevidence undermining the selected closure but does not suspend it in that same record, or suspension leaves completion true or silently falls back | accepted material counterevidence requires conservative suspension without mutating historical sets |
| a closure-selection record changes the Chapters 4--10 material boundary | closure chooses an audited view, not programme scope |

These are design requirements only; no validator or schema code is authorized
by this plan.

## 8. Tiny schema design fixture

The following invented records test accounting semantics. They are not DLMF
audit evidence, allocated production IDs, or real source counts.

| Unit | Fixture content and final disposition |
|---|---|
| `FX-H1` | hierarchy container; owns no payload |
| `FX-U1` | source-owning mixed leaf at appearance `FX-A1`: explicit atom `FX-O1` plus nonmathematical remainder `FX-N1` |
| `FX-U2` | source-owning formula leaf at `FX-A2`: atom `FX-O2`, with a context reference shared with `FX-O1` |
| `FX-U3` | repeat appearance at `FX-A3`: separate atom `FX-O3` despite equivalent formula content |
| `FX-U4` | internal-cross-reference leaf at `FX-A4`: atom `FX-O4` |
| `FX-U5` | external reference-lead leaf `FX-R1`, excluded from theorem targets |
| `FX-U6` | underspecified provisional leaf `FX-P1`; append-only resolution creates atom `FX-O5` and lineage `FX-P1 -> FX-O5`, without changing or counting `FX-P1` |

Let `FX-D1` be the payload-owning canonical retrieval document for this
fixture. Redirecting path `FX-D1.i`, fragment `FX-D1#i`, equation permalink
`FX-D1.E1`, and alternate rendering `FX-D1?type=mathml` are reconciled
aliases and cannot mint more appearances. Let `FX-B^1` be a finite audit
revision containing these six leaves and pinning correction/decision view
`FX-V1`. The five
effective atoms have distinct canonical keys
`(FX-S,FX-A1,1)` through `(FX-S,FX-A4,1)` and
`(FX-S,FX-A6,1)`; the shared context has one provenance identity. Only after
all fixture batch-partition reviews approve is the following local design value
defined:

```text
Target(FX-S,FX-B^1) = {FX-O1, FX-O2, FX-O3, FX-O4, FX-O5}
```

Suppose `FX-CARD-A` associates with `FX-O1,FX-O2,FX-O3`,
`FX-CARD-B` with `FX-O4,FX-O5`, and `FX-CARD-C` also with `FX-O5`.
There are six association rows but the deduplicated covered-occurrence set has
five members and equals `Target(FX-S,FX-B^1)`. This shows that many-to-many
associations do not inflate source counts. Before `FX-P1` is successfully
resolved and the batch partition gate passes, `Target(FX-S,FX-B^1)` is
undefined, not an empty or partial set. The whole-programme `Target(FX-S)`
also remains undefined unless a separate fixture `FX-B-all^r` receives
reviewed global closure and is explicitly selected; this small example makes no
such claim. `FX-O2` and `FX-O3` remain a positive repeated-location pair:
they occupy genuinely different semantic locations even if their formula bytes
agree.

The source-identity correction fixture has two valid repairs. First, suppose a
bad audit view minted alias locators as appearances `FX-A7` and `FX-A8` for one
actual semantic location. A reviewed coalescing correction creates fresh
successor appearance `FX-A9` and fresh successor atom/key records representing
that one actual location; it never reuses `A7`/`A8` identities or preserves
their erroneous multiplicity. Second, suppose `FX-A10` wrongly collapsed two
actual source locations. A reviewed splitting correction creates fresh
appearances `FX-A11`,`FX-A12` and fresh atoms/keys, preserving both genuine
locations. A successor audit revision may pin those repairs while the earlier
view remains exactly replayable. By contrast, a proposal to coalesce the valid
repeated-location pair `FX-A2`,`FX-A3` merely because their formulas agree must
be rejected. The same fresh-identity and exact-payload rules apply if the error
was at canonical retrieval-document rather than appearance level.

For the classification fixture, let `FX-O2` be quantitative and designate
exactly `FX-Q-CARD/FX.q` for `semantic_finite_quantitative` and
`FX-R-CARD/FX.recover` for `faithful_source_recovery`. The latter depends
on the former. The other four atoms have one approved ordinary classification
and individual frozen reasons. These are schema-design examples only, not
audited DLMF totals, production rows, or readiness evidence.

## 9. Audit and review protocol

1. Create the reviewed multi-track schema migration and DLMF source-manifest
   format without modifying frozen Olver rows or meanings. The representation
   may vary, but it may not weaken §§2, 4, and 5's canonical-document, alias,
   partition, ownership, typed-lineage, pinned-view, or total-classification
   semantics.
2. Create a finite, explicit Chapter 4 source-audit batch `B` and retrieve
   its retrieval-document/content-unit census, recording actual
   per-document dates, digests, redirect chains, and version evidence.
   Reconcile aliases before minting appearances, build the
   container/source-leaf inventory, pin the exact decision view, and perform
   forward and reverse passes. Obtain independent exact-bound review of
   document identity/aliases, any source-identity corrections, source
   partitions, semantic atomization, fidelity roles, exclusions,
   classifications, and resolutions. Publish counts only as
   `B`-scoped values after `PartitionReady(S,B)`; do not report a Stage 1
   percentage.
3. Use [§4.13](https://dlmf.nist.gov/4.13) as the omission-sensitive pilot. It
   must classify `W_k`, `Wp`, `Wm`, Wright omega, and Tree `T`
   occurrence and entity relationships without assuming the answer from their
   names.
4. Extract atomic statements, shared context, local notation, entities,
   aliases, normalizations, branches, exceptions, domains, cross-references,
   tables, captions, and prose. Keep ambiguity and underspecification explicit.
   Assign and externally review exactly one obligation classification for every
   target atom.
5. Select only finite closed target/support batches from a reviewed local
   `Target(S,B)`, with explicit support closure. Record their Lean execution
   manifests separately from the source-audit manifest; neither manifest may
   authorize open-ended chapter membership. New mathematics needs a
   complete natural-language proof before signature design and at least two
   fresh independent pre-Lean reviews: source/semantics and proof/quantitative.
   Construction, continuation, identification through existence/uniqueness,
   nontrivial recovery, zeros, connections, turning points, and theorem-sized
   hypothesis packets add structural-circularity review.
6. After external `lean_ready: pass`, implement only the exact frozen packet,
   then obtain build/regression/import/axiom and implementation reviews and
   reconcile coverage. A material change invalidates affected approvals.
7. Independently of local packet progress, when a candidate `B_all` revision
   eventually closes, obtain two fresh independent global-closure reviews and
   a root external selection record with every §4 binding. The reviewers may
   rely on exact-bound completed leaf reviews rather than repeat the census.
   Record later replacement or conservative withdrawal only through the same
   external authority rules; a root record that accepts material
   counterevidence must suspend current completion in that same record while a
   corrected successor is pending.

Bibliographic, software, and visual-media records are never advertised as
proved theorems. Pure reference leads receive no theorem credit, while
independent source review must ensure that substantive mathematics was not
evaded by misclassifying it as reference-only.

## 10. Verso handoff

A preliminary Verso site may read future snapshot, hierarchy/leaf,
retrieval-document/alias, source-appearance, context, occurrence, obligation,
notation, entity, card, dependency, typed decision/lineage, external-review,
immutable audit-revision, and Lean execution manifest records. It should filter
by chapter/section/function; show source,
proof, review, implementation, coverage, and manifest axes separately; expose
undefined, unresolved, and failed states; distinguish local `Target(S,B)`
from global `Target(S)`, distinguish DLMF from Olver, and label fixture or
provisional counts unmistakably.

Verso is a read-only projection. Stable IDs back links, but the underlying
versioned records and exact-bound external authorities determine truth. A
dashboard cannot approve mathematics, alter lineage, authorize Lean, define an
otherwise undefined denominator, select/replace/withdraw global closure, choose
a mutable “latest” decision view, or turn a reference lead into coverage.

## 11. Present truth

The user-authorized broad Stage 1 boundary is recorded, and the official DLMF
pages above were used for limited discovery verification of version, chapter
structure, and named sentinels. No full page census, reviewed source-audit
batch, reviewed source partition, defined local or global production
denominator, real occurrence count, total obligation classification, schema
migration, source reconciliation, theorem-card set, proof set, review quorum,
global-closure selection, external gate, closed/complete DLMF execution
manifest, Lean implementation, or coverage percentage is claimed.

DD-021 revision 4 and this six-file successor remain pending until the exact
effective rule at the start of this document is satisfied. Until then they are
not operative programme authority.
