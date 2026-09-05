# Release strategy for quantitative results and qualitative recovery

**Normative owner:** `jaumededios`

**Programme status:** planning only

**Release principle:** small closed manifests, immutable evidence, and exact
occurrence-level claims

## Purpose

The project has a multi-year destination—a source-facing qualitative edition
close to Olver backed by stronger finite theorems—but releases must remain
small, useful, and literally true along the way. A release therefore does not
claim a chapter or function family merely because foundational code exists. It
ships a finite set of declarations and source occurrences whose cards, proofs,
reviews, implementation, and reconciliation all close at one exact commit.

This strategy complements the main roadmap. The roadmap orders mathematical
tracks; this document defines what may be packaged and advertised at each
stage. Proposed stage names below are planning labels, not registered manifests
unless they already appear in `blueprint/inventory/manifests.csv`.

Qualitative recovery semantics are specified in
[source recovery](source_recovery.md), the public presentation in
[navigation and documentation](navigation_and_docs.md), and unsolved
mathematical dependencies in the [research queue](open_research_questions.md).

## Release unit

Every release is bound to four independent identities:

1. **Code version:** the immutable repository tag and full commit SHA.
2. **Dependency version:** Lean toolchain and resolved Mathlib commit.
3. **Manifest version:** the exact closed set of cards and, where applicable,
   source occurrences.
4. **Documentation version:** the generated catalogue snapshot for those same
   records and commits.

A semantic-version increment does not itself enlarge source coverage. A
manifest revision does not imply that its members have been implemented. The
release record binds both and reports each status axis explicitly.

The physical release bundle has three coordinated products:

| Product | Contents | Import status |
|---|---|---|
| Semantic core | Identified functions, exact identities, finite approximants, explicit bounds | Imported through maintained semantic roots |
| Audit companion | Expanded definition checks, qualitative source-recovery bridges, dependency and regression audits | Built and shipped, never imported by the semantic root |
| Catalogue snapshot | DLMF-like functions, methods, theorem, source, proof, and release pages | Generated from the frozen metadata graph |

All three use the same tag. The audit companion is not an optional untested
appendix: a source-coverage release fails if its required audit modules do not
build. Conversely, deleting it from an installation must not alter the semantic
API.

## Manifest rules

Only a closed manifest can be a release manifest. Closure requires:

- a finite, frozen member list with no wildcard or “related results” row;
- complete cards with exact declarations, imports, binders, exclusions,
  dependencies, and owners;
- occurrence selection and exact source denominator fixed where source coverage
  is claimed;
- theorem, proof, review, implementation, coverage, and membership statuses
  recorded independently;
- an external envelope binding the frozen specification and candidate commit;
- no unresolved release-blocking finding at that commit.

Planning queues may be published as roadmaps, but their members do not appear
in released theorem counts and their source occurrences do not enter a claimed
recovered numerator. Adding work to a closed manifest requires a reviewed
manifest revision; it is never smuggled into a release because a file happens
to compile.

## Staged releases

### Stage 0 — specification and bootstrap

**Purpose:** establish the package, inventories, review protocol, and the
smallest finite-error/definition slice without an Olver theorem claim.

The current `BOOTSTRAP-0` manifest is the model: bounded infrastructure and
entity-identification cards, zero source occurrences. A Stage 0 release may say
exactly which generic predicates or wrappers are available and that source
coverage is zero. It may not describe the project as a formalization of
Watson's lemma, Gamma in Olver, or any chapter.

Exit evidence includes:

- exact public declaration list and axiom reports;
- pinned dependency build;
- implementation rubrics at the candidate head;
- generated card and function pages showing no source overclaim;
- manifest validation with declared source-occurrence total zero.

### Stage 1 — single-occurrence source pilot

**Purpose:** exercise the complete quantitative-to-qualitative path on one
generic source theorem.

`OLV-MVP-1` is planned around `OLV97-C03-WATSON`. It becomes releasable only
after direct 1997 collation and completion of the finite Laplace infrastructure,
the exact-source quantitative theorem, and the audit-only qualitative bridge.
Its release bundle must support this complete navigation path:

```text
locked Watson occurrence
  -> collated notation and generic data
  -> finite quantitative theorem with explicit remainder
  -> qualitative theorem matching the printed conclusion
  -> proof/review evidence and released Lean declarations
```

The release note says “one selected Watson occurrence recovered” with the exact
manifest denominator. It does not say “Chapter 3 formalized.” Watson remains an
`exact_source_generic` result, not a named-function application.

### Stage 2 — definition waves and source-facing catalogue

**Purpose:** make the function catalogue genuinely useful while keeping source
and implementation identity separate.

Proceed through bounded family manifests, initially favouring families needed
by near-term applications. A wave may contain:

- reconciled definition and normalization occurrences;
- one actual function object per entity;
- conventional specification and identification theorems;
- branch, exceptional-value, real-agreement, and normalization audits;
- selected exact identities or finite applications with separate cards.

It is legitimate to release a family as **identified** before its asymptotic
applications are ready. The release then claims entity identification and the
specific resolved definition occurrences, not “all asymptotics for the family.”
Similarly, a Mathlib wrapper may ship with zero Olver source credit until the
source conventions are reconciled.

Possible waves include Gamma-related functions; exponential, error, and
Fresnel functions; Airy; Bessel/Hankel; and hypergeometric/parabolic-cylinder
families. These names describe planning portfolios, not manifest wildcards.
Every actual wave lists exact cards and occurrences.

### Stage 3 — method releases with selected source applications

**Purpose:** grow reusable finite analysis and immediately demonstrate it on
closed source batches.

Integral, summation, ODE, derivative-transport, and comparison work may ship in
parallel trains. Each method release separates:

- generic infrastructure, earning no source credit;
- exact-source generic results, if the source theorem itself is generic;
- named applications, which require identified objects and discharged
  hypotheses;
- qualitative source bridges for each credited occurrence.

A method release should normally include at least one end-to-end consumer
before the abstraction is advertised as stable. This is especially important
for comparison-system structures and custom tactics. Open research on one
family does not block a release whose closed manifest has no dependency on it.

### Stage 4 — chapter checkpoints

**Purpose:** publish coherent source-order reading units without claiming an
entire book prematurely.

A chapter checkpoint is allowed only after the chapter's scan universe is
defined and the checkpoint manifest selects an exact finite subset. Two kinds
of checkpoint must be named differently:

- **selected-results checkpoint:** all selected occurrences are reconciled and
  recovered, while unselected or unaudited chapter material remains visible;
- **complete-chapter checkpoint:** every in-scope page is completely audited,
  every lead is resolved or excluded, and every occurrence required by the
  chapter-completion policy is reconciled.

The first kind is expected for a long time and is scientifically useful. It
must never be shortened in release prose to “Chapter N complete.” The
catalogue's source-order view shows gaps and source issues explicitly.

### Stage 5 — qualitative Olver edition

**Purpose:** deliver the chapter-by-chapter qualitative companion envisioned by
the user, backed throughout by finite mathematics.

This is an edition-level release, not merely a large code tag. Its gate requires:

- complete page audits for the locked scan universe with independent review;
- every source occurrence resolved, excluded with reason, or marked as a
  documented source issue;
- every claimed qualitative statement kernel checked in
  `Audit/SourceRecovery`;
- every recovered statement connected to a released quantitative producer;
- named functions identified with exact conventions;
- all edition discrepancies and authoritative errata reconciled;
- a generated source-order catalogue with no dangling theorem/proof/card links;
- zero unexplained difference between manifest, occurrence, and generated
  coverage totals.

“Extremely close to Olver” is evaluated occurrence by occurrence: ordering,
notation, quantifiers, hypotheses, scale, uniformity, branches, exceptions, and
normalizations are compared against the locked edition. The release may contain
stronger quantitative pages alongside the source-facing statement, but it may
not replace the latter by a modern reformulation without an exact recovery
proof.

This final stage can honestly include a source-issue ledger. A false or
ambiguous printed statement is not made true by formalization; preserving the
printed proposition and explaining why it is not recovered is more faithful
than silently repairing it.

## Per-card release gates

All released cards satisfy the common build and review protocol. Additional
gates depend on coverage class.

| Coverage class | Additional release requirement |
|---|---|
| `infrastructure` | Exact bounded API, real downstream consumer or justified dependency seam, no source claim |
| `entity_identification` | Actual object, conventional specification, validity, uniqueness where needed, branches/exceptions, independent definition audits |
| `exact_source_generic` | Resolved occurrence, exact source quantifiers and conventions, finite theorem discharging the collated hypotheses |
| `named_source_application` | Accepted identification, all generic hypotheses discharged, reachable/nonempty domain, nonnegative majorant, exact source association |
| `audit_source_recovery` | Quantitative producer accepted in the same release or an earlier one, eventual-domain and scale bridge proved, source proposition matched exactly, audit import boundary preserved |

A source occurrence receives release credit only when its manifest-specified
required set of cards is released. A helper's success cannot compensate for a
missing named application or source bridge.

## Release evidence checklist

The immutable release record contains or links:

- tag, full candidate SHA, base SHA, Lean toolchain, and resolved Mathlib SHA;
- manifest ID/version and a digest of its frozen member set;
- exact public declarations, modules, imports, and axiom reports;
- theorem-card, proof-dossier, signature, and work-packet revisions/digests;
- external pre-Lean and implementation verdicts for the released head;
- build, lint, inventory, link, and dependency-audit output;
- source snapshot IDs, page-audit evidence, transcription hashes, and
  reconciliation outcomes for credited occurrences;
- exact regression statements for constants, domains, branches, exceptional
  values, order zero, and small orders;
- generated catalogue artifact digest;
- known limitations, source issues, open research dependencies, and superseded
  results.

External verdicts and envelopes remain external to the candidate head, as the
review protocol requires. The release record uses immutable references rather
than copying mutable summaries.

## Release notes and metrics

Every release note begins with exact outcomes, not aspirations. Report at least:

| Metric | Required presentation |
|---|---|
| Semantic declarations | Count by definition, exact identity, finite bound, and other theorem class |
| Identified entities | Numerator/denominator within this manifest; never an inferred whole-book denominator |
| Selected source occurrences | Exact manifest denominator |
| Quantitatively proved occurrences | Count with producer complete |
| Qualitatively recovered occurrences | Count with `SR-*` bridge complete |
| Source issues/unresolved items | Explicit count and links |
| Planning items | Separate non-release count, omitted from success totals |

Counts are accompanied by stable links to their members. Do not publish a
percentage when the scan universe or denominator is not closed. Do not combine
definition occurrences, theorem occurrences, exercises, and repeated uses into
one unexplained total.

Permitted release language includes:

- “This release adds an explicit finite Watson bound and recovers one collated
  qualitative occurrence.”
- “Gamma is identified with the reused Mathlib object for the four listed
  wrappers; Olver normalization reconciliation remains pending.”
- “The Airy family is a planning wave and contributes no current coverage.”

Forbidden release language includes:

- “Olver is formalized” before the edition-level gate;
- “Chapter 3 complete” for a selected-results checkpoint;
- “Bessel supported” when only a series kernel or contents lead exists;
- “stronger theorem” when the result uses stronger hypotheses without an exact
  source recovery theorem;
- “reviewed” without naming the frozen artifact and candidate head.

## Versioning and compatibility

Semantic API compatibility and source-catalogue compatibility are tracked
separately.

- Removing or changing a released semantic declaration follows ordinary API
  deprecation and versioning policy.
- Correcting a source locator, transcription, notation, or edition relation
  increments the relevant inventory/manifest revision and invalidates affected
  source reviews.
- A theorem may remain mathematically valid while its coverage claim is
  withdrawn because source reconciliation changed. The next release reports
  that distinction.
- Superseded cards and declarations retain redirect/tombstone pages so old
  release links remain meaningful.
- Generated pages always link Lean source at the released commit, never the
  moving branch tip.

Natural bounds are kept before simplified corollaries. A refactor that worsens
a released constant, threshold, or domain requires an explicit compatibility
decision and changed regression, even if the theorem type remains broadly
similar.

## Alternate editions and corrections

The 1997 corrected reprint remains the initial source target. Auditing another
printing or reprint creates a new edition-specific occurrence layer and release
manifest. Shared entity and quantitative theorems may be reused, but source
coverage is transported only through reviewed edition-equivalence records.

When editions differ materially:

- publish separate source-facing propositions;
- identify which edition corrects which formula or hypothesis;
- retain both locators and reconciliation evidence;
- avoid rewriting historical release counts as if the discrepancy never
  existed.

When a released source claim is later found wrong, issue an erratum release.
Withdraw the affected coverage status, preserve the old immutable artifact,
link the counterevidence, and re-run every downstream source bridge. A green
semantic theorem may remain released if its own statement is still correct.

## Research and partial progress

The open research queue is not a release manifest. A question can be important,
well studied, or supported by experiments and still contribute zero released
theorems. Research items block only manifests that name them as dependencies.

Useful intermediate products may be released under their true class:

- a generic conditional estimate without a named application;
- an exact transform without stability;
- a local zero theorem without global indexing;
- a branch-specific theorem without continuation across other charts;
- an identified function without an asymptotic expansion.

This compositional policy keeps the library moving while preventing local
success from being advertised as completion of the harder downstream result.

## Final release audit

Before tagging, a fresh release audit verifies:

1. the manifest is closed and its member digest matches the release record;
2. the code, audit, and documentation products are generated from the same
   commit and metadata;
3. all required review quorums approve that exact candidate head;
4. semantic modules have no dependency on `LMLF.Audit`;
5. every source-credit occurrence has a released quantitative producer and
   qualitative bridge;
6. every named application links a released identification theorem;
7. occurrence, notation, entity, card, manifest, and declaration links are
   bidirectionally complete;
8. all declared counts and denominators reproduce from canonical inventories;
9. source snapshots and cross-edition claims satisfy the reconciliation policy;
10. release prose passes the anti-overclaiming language check.

If any check fails, publish neither the tag nor the coverage claim. The work may
remain available as a planning branch or prerelease with the failed gate stated
explicitly.
