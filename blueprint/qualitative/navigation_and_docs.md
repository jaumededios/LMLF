# Navigation and documentation architecture

**Normative owner:** `jaumededios`

**Programme status:** planning only

**Design goal:** DLMF-like discovery with theorem-level proof and source
provenance

## Documentation contract

LMLF should be browsable by mathematical subject, named function, method,
source order, or Lean declaration without conflating those views. The website
is a projection of reviewed inventories and theorem cards, not an independent
source of status or mathematical claims.

The design borrows the useful navigational idea of the
[DLMF](https://dlmf.nist.gov/): stable fine-grained anchors, section browsing,
formula-level links, nearby definitions, and cross-references. LMLF adds the
provenance required by formalization: each displayed result links to its source
occurrence, quantitative theorem, source-recovery theorem when one exists,
natural-language proof, review evidence, Lean declaration, dependency graph,
and release manifest.

The site serves three distinct questions:

1. **What mathematics is available?** Browse functions, methods, finite
   estimates, derivatives, zeros, and connection results.
2. **What part of Olver has been recovered?** Browse the locked edition in
   source order and see exact occurrence-level status.
3. **Why should I trust this page?** Follow the theorem/card/proof/review/source
   chain and inspect the precise version shipped in a release.

No page may answer all three with one undifferentiated “formalized” status.
The mathematical meaning of the qualitative view is fixed in
[source recovery](source_recovery.md); release badges follow the
[release strategy](release_strategy.md), and unresolved work comes from the
[research queue](open_research_questions.md).

## One metadata graph, several projections

Canonical facts remain in the normalized inventory, theorem cards, work
packets, proof dossiers, external review references, and release manifests. The
documentation generator reads those records and constructs a graph. It must not
maintain handwritten copies of coverage tables or proof statuses.

The important node classes are:

| Node | Stable identifier | Canonical source |
|---|---|---|
| Edition | `edition_id` | source policy and snapshot inventory |
| Snapshot and page audit | `source_snapshot_id`, `page_audit_id` | `blueprint/inventory/` |
| Source occurrence | `occurrence_id` | occurrence inventory |
| Source notation | `notation_id` | notation inventory |
| Mathematical entity | `entity_id` | entity inventory |
| Theorem card | card ID such as `OLV-001` or `SR-001` | theorem-card artifact |
| Proof dossier | proof artifact ID and revision | `blueprint/proofs/` or bound external artifact |
| Lean declaration | fully qualified declaration name | compiled environment plus card |
| Review packet and verdict | work item ID and immutable external reference | review envelope/evidence store |
| Manifest and release | manifest ID and released tag | manifest inventory and release record |

Associations are first-class edges. The generator must support many-to-many
relations: one generic theorem can recover several occurrences; one occurrence
can need several finite lemmas; one entity can occur under several notations;
and one declaration can be a prerequisite for several cards.

The site build fails on a dangling ID, ambiguous primary declaration, duplicate
stable URL, invalid status value, impossible manifest count, or a source-
coverage page whose association chain is incomplete.

## Primary navigation

The top-level navigation has six entries.

### 1. Functions

An alphabetical and family-organized catalogue of identified named functions,
normalizations, named derivatives, and clearly separated project auxiliaries.
Each family landing page shows:

- the conventional defining formula or characterization;
- actual LMLF/Mathlib object and identification theorem;
- argument order, domain, branches, totalization, and exceptional parameters;
- real/complex agreement and derivative meaning;
- exact identities, finite expansions, derivative estimates, zeros, and
  connections currently released;
- all Olver occurrences using the entity;
- related DLMF pages as convention cross-checks, visibly not source evidence;
- open research questions and planned cards, clearly marked non-released.

A provisional contents-only candidate does not appear among “identified
functions.” It appears in a separately labelled audit queue with its current
evidence class.

### 2. Methods

Browse reusable mathematics independently of named functions: finite error
calculus, finite sums, complex derivative transport, Laplace and oscillatory
integrals, contour and saddle methods, summation, ODE residuals and stability,
turning-point comparison, zeros, and connection matrices.

Each method page distinguishes:

- exact identities from inequalities;
- generic conditional infrastructure from exact-source generic results and
  named applications;
- semantic quantitative theorems from audit-only qualitative bridges;
- established prerequisites from open research dependencies.

This view prevents the source chapter order from creating false code
dependencies.

### 3. Olver 1997

An edition-specific source explorer follows the locked book's chapter,
section, and occurrence order. It is the main interface for the desired
qualitative edition close to Olver.

For every occurrence, display:

- printed locator and label;
- copyright-safe mathematical transcription or a clear `not transcribed`
  state;
- local notation with a link to canonical entities;
- the source-facing qualitative proposition;
- quantitative strengthening and its explicit finite bound, if proved;
- source-recovery bridge, if proved;
- reconciliation with alternate snapshots or editions;
- all orthogonal status axes and the release containing the occurrence.

Chapter completion is calculated from reconciled occurrence totals. A chapter
heading, a contents scan, or several prominent theorems cannot produce a
percentage claim about unaudited pages. Unscanned areas are visible, not
silently absent.

### 4. Theorems

The theorem catalogue supports search and filtering by:

- target function or generic method;
- theorem and coverage class;
- source edition, chapter, and occurrence;
- quantitative/qualitative view;
- domain shape, large parameter, order convention, derivative variables, and
  branch chart;
- implementation, proof, review, coverage, and release status;
- dependencies and downstream consumers.

The default result list includes only released declarations. A visible switch
may include planned, specified, or under-review cards, but these never use the
same visual treatment as released theorems.

### 5. Coverage and releases

Show closed manifest membership, exact occurrence denominators, resolved and
recovered counts, source issues, withdrawals, and release-to-release deltas.
Infrastructure and entity-identification counts are separate from Olver
theorem coverage. Open planning queues appear on a separate page and contribute
zero to release coverage.

### 6. Contributing and review

Explain the theorem-card lifecycle, proof-before-Lean gates, source collation,
review isolation limits, external evidence, allowed status values, and local
build commands. Contributors should be able to go from an open occurrence or
research question to the exact card template without reverse-engineering the
repository.

## Stable URL scheme

Stable IDs, not titles or current file locations, determine permalinks. A
recommended scheme is:

| Page | Stable path pattern | Example |
|---|---|---|
| Entity | `/functions/{entity_id}` | `/functions/gamma` |
| Method | `/methods/{method_id}` | `/methods/laplace` |
| Theorem card | `/theorems/{card_id}` | `/theorems/OLV-001` |
| Lean declaration | `/declarations/{qualified-name}` | declaration-specific generated path |
| Edition | `/sources/{edition_id}` | `/sources/olver_1997b` |
| Occurrence | `/sources/{edition_id}/occurrences/{occurrence_id}` | Watson occurrence page |
| Chapter/section | `/sources/{edition_id}/chapters/{chapter}/{section}` | source-order landing page |
| Research item | `/research/{rq_id}` | `/research/RQ-ODE-003` |
| Manifest/release | `/releases/{manifest-or-tag}` | `/releases/OLV-MVP-1` |

Human-readable slugs may redirect to these paths, but IDs remain canonical.
Renaming a theorem or moving a file does not break an occurrence link. A
superseded card retains a tombstone page linking its replacement and the last
release that contained it.

Formula and declaration anchors are also stable. They use a registered formula
or target ID rather than a generated heading number, so a reader can link
directly to a bound, definition, or recovered qualitative statement.

## The theorem page

Every substantial theorem page uses the same anatomy.

### Header

Show the mathematical title, stable card ID, theorem class, coverage class, and
release status. Display separate badges for specification, proof, review,
implementation, coverage, and manifest membership. Do not compress these into
one status.

### Statement views

Use adjacent views, not competing pages:

1. **Source view:** exact occurrence locator, source notation, and the
   copyright-safe collated mathematical proposition.
2. **Qualitative view:** the kernel-checked audit statement close to Olver, or a
   precise reason it is absent.
3. **Quantitative view:** finite approximant, explicit majorant, domain,
   thresholds, order, and parameter dependence.
4. **Lean view:** fully qualified declaration, rendered signature, import, and
   source link at the released commit.

The source and qualitative tabs appear only for associated source cards.
Generic infrastructure pages are not made to look incomplete merely because
they have no source occurrence.

### Conditions panel

Give branches, exceptional values, derivative variable and scaling,
normalization, nonempty/reachable domain evidence, and majorant nonnegativity.
The panel is generated from reviewed card fields and links to the relevant
proof declarations.

### Bound provenance

Display the bound without decimalizing it. Expand its contributions and link
every controlling constant, threshold, envelope, integral, or norm to an input
or upstream theorem. Mark natural bounds and simplified corollaries separately.

### Proof and review

Link the natural-language proof revision, exact work packet, external review
envelope/verdict references, candidate and release commits, axiom report, build
evidence, regressions, and known limitations. External review evidence is
linked; it is not copied into or inferred from the candidate branch.

### Dependency and use graph

Provide two compact graphs:

- mathematical dependencies, separating definition, exact identity, estimate,
  source recovery, and audit nodes;
- downstream consumers, so a proposed API change has visible blast radius.

Collapsed graphs must still expose a text list for accessibility and machine
indexing.

## The occurrence page

The occurrence is the atomic source-coverage page. It answers questions that a
theorem page cannot:

- Which exact printed object was inspected?
- Is the locator body evidence, contents-only, or a DLMF lead?
- Has the locked edition been reconciled?
- Which symbols and named objects occur locally?
- Is the source theorem exact, corrected, disputed, or unresolved?
- Which finite theorem and qualitative bridge cover it?

Its status timeline should be reconstructed from durable records:

```text
lead -> located -> transcribed -> independently collated
     -> carded -> quantitative theorem proved -> qualitative bridge proved
     -> reconciled -> released
```

Missing stages remain visible. This timeline is descriptive; the canonical
controlled values remain those in the inventories and theorem cards.

## Function-definition sheets

Definition pages follow the seven-part definition-sheet order fixed by the main
blueprint:

1. name and arguments;
2. classical formula or normalized characterization;
3. conventions;
4. actual implementation and identification;
5. validity, regularity, and uniqueness;
6. real agreement and derivative meaning;
7. source, declaration, audit, and status data.

Every identity displayed on the page links to a declaration or is labelled
“expository only.” Never render a source formula as proved merely because it is
stored in a Markdown catalogue. Project-extra envelopes and phases use a
visually distinct label and do not enter Olver entity-completeness counts.

## Cross-link requirements

A released quantitative source result must have a complete route in both
directions:

```text
source occurrence
  <-> notation and entities
  <-> quantitative theorem card
  <-> natural-language proof and work packet
  <-> Lean declaration and implementation commit
  <-> implementation reviews and regressions
  <-> qualitative source-recovery card and declaration
  <-> closed manifest and release
```

The generator validates at least these rules:

- every card page links its actual artifact and each public declaration;
- every proof names the card revision it proves;
- every declaration belongs to a bounded target or is marked private/internal;
- every occurrence-credit claim has an `SR-*` link and a quantitative producer;
- every named application links the function's accepted identification theorem;
- every source bridge links its eventual-domain and scale-comparison evidence;
- every release page names exact counts and the manifest version;
- every source locator links back to all released cards that claim it;
- every research item links to its prospective dependencies without appearing
  among released results.

Broken reverse links are build failures, not documentation polish items.

## Status language and visual rules

Use the controlled status vocabularies verbatim. User-facing explanations may
be added, but badges do not invent summaries such as `mostly formalized`.

Recommended visual treatment:

- released/audited: solid color with release tag;
- proved but unreconciled: distinct warning treatment;
- specified or under review: outline treatment;
- planning only: neutral treatment;
- blocked, source issue, or withdrawn: explicit text and reason;
- unresolved source evidence: visibly hatched/unknown rather than red failure.

Counts always include their denominator and category. Examples of acceptable
labels are “1 of 1 selected occurrences reconciled in OLV-MVP-1” and “0 named
applications released.” “Chapter 3 formalized” is forbidden unless the entire
chapter scan universe and manifest justify it.

## Search and comparison

Search indexes mathematical notation, aliases, source labels, declaration
names, card IDs, and prose summaries. It preserves distinctions that ordinary
full-text search loses:

- `J` as Bessel argument notation versus a declaration name;
- order parameter versus spatial variable;
- ordinary versus regularized normalization;
- real restriction versus complex continuation;
- quantitative producer versus qualitative bridge;
- exact-source generic theorem versus named application.

The comparison view can place two statements side by side: source versus
recovered, qualitative versus quantitative, two editions, or two releases. It
highlights binder order, domain, scale, constant, branch, normalization, and
exception changes. It never declares equivalence from textual similarity; only
an accepted equivalence certificate permits that badge.

## Edition browsing and source reconciliation

The 1997 source tree is canonical for the initial programme. The 2010 preview
may appear as an evidence overlay showing pages inspected and provisional
leads, not as a second copy of the 1997 tree. When another edition is audited,
users may switch editions while stable entity and theorem pages remain shared.

Cross-edition links display one of the reviewed outcomes from the source-
recovery policy: verbatim mathematics, proved equivalent rewording, corrected,
mismatch, or unresolved. Pagination changes alone do not alter the mathematical
entity, but they do require separate occurrence locators.

## Build products

Documentation is generated in three modes.

1. **Current main:** may show planning and active work, always with precise
   status.
2. **Release snapshot:** immutable navigation for one tag and manifest version;
   all Lean source and evidence links are commit-pinned.
3. **Audit report:** machine-readable tables of dangling links, occurrence
   totals, source-resolution states, card/declaration mismatches, and forbidden
   dependency edges.

The release snapshot can include rendered formulas and prose checked into a
site artifact, but canonical source transcriptions remain copyright-safe and
the book PDF or page images are never published from the repository.

## Initial documentation slice

The smallest honest slice contains:

- project scope and dependency architecture;
- current manifest table with zero source overstatement;
- pages for QB-001 and DEF-001 generated from their cards;
- Gamma's provisional entity/definition sheet with its unresolved Olver
  normalization visibly separated from the Mathlib identification wrapper;
- the Watson occurrence page marked uncollated and unrecovered;
- a skeleton source-order table generated from audited occurrence rows only;
- a research queue landing page.

The first true source-facing success is the Watson page after OLV-001 and SR-001
are released. It should let a reader move in one click from the printed
qualitative proposition to the explicit finite bound and back, while making
clear that this is one recovered occurrence rather than a completed chapter.

## Documentation anti-overclaiming checks

The site build and release review reject:

- coverage inferred from file, chapter, or declaration names;
- planned cards mixed into released search results by default;
- DLMF links displayed as direct Olver evidence;
- a function page marked identified without its accepted bridge theorem;
- a source page marked recovered without a quantitative producer and `SR-*`
  proof;
- a single status badge replacing orthogonal workflow axes;
- hidden empty-domain or negative-majorant conditions;
- proof links that do not bind the displayed statement revision;
- review links for an obsolete candidate commit;
- source prose or page images that violate the copyright-safe policy;
- stale URLs after renames or supersession;
- generated diagrams that introduce edges not present in canonical metadata.

The documentation succeeds when it is pleasant to explore but conservative
enough that every green claim can be followed to a kernel-checked theorem and a
reconciled source occurrence.
