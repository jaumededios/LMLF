# Olver occurrence and function inventory

**Schema version:** `inventory-v1.0.0`

This document defines the canonical normalized inventory used by the source manifests and by the narrower “all named functions in Olver” audit. The CSV files under `blueprint/inventory/` are authoritative for machine checks. Prose tables in other blueprint documents select or summarize those rows; they do not form a second inventory.

The current rows are deliberately incomplete. `inventory-v1.0.0` defines an audit protocol and a small evidence-backed seed, not a completed book audit.

## Edition lock and source snapshots

The target edition is:

- `edition_id`: `olver_1997b`
- F. W. J. Olver, *Asymptotics and Special Functions*, A K Peters, 1997.
- ISBN `1-56881-069-5`.
- Corrected reprint of the 1974 Academic Press original.

The locked bibliographic identity is supported by the [DLMF bibliography entry for Olver (1997b)](https://dlmf.nist.gov/bib/O). The separate [publisher preview](https://api.pageplace.de/preview/DT0400.9781439864548_A38306604/preview-9781439864548_A38306604.pdf) exposes copyright and reprint metadata but is not treated as the locked edition.

An edition is bibliographic; a source snapshot is the exact physical or digital object inspected. `editions.csv` therefore gives the preview its own `edition_id`, `olver_crc_2010_preview`, distinct from `olver_1997b`. Every occurrence has both `edition_id` and `source_snapshot_id`, and those identities must agree. The preview snapshot `SRC-OLV-2010-PREVIEW` can support discovery and provisional body-location claims for its own 2010 edition. Its digest and printed-page mapping remain unresolved.

`edition_relations.csv` records the 2010-to-1997 relation separately. An unordered pair of edition endpoints may have exactly one relation row; reversing the endpoints does not create a second relation slot. This makes the reconciliation decision deterministic and prevents a later `matched` row from silently overriding an unresolved or contradictory row. Both mathematical-content and page-locator equivalence are currently `unresolved`, so its `join_semantics` is `non_equivalent`. This forbids transferring an occurrence, transcription, notation, entity confirmation, or coverage credit across the relation. Notes that two printings “look similar” cannot override the relational fields.

`SRC-OLV-1997-COLLATION-PENDING` is a reserved placeholder for the locked copy required by the source manifest. It is not evidence that a copy has been acquired or inspected. Its locked-edition identity, `locked_copy_placeholder` kind, `pending` availability, absent digest/access metadata, unresolved digest/edition/page states, and `unknown` rights state are immutable schema invariants. Acquisition must create a new concrete snapshot ID and row, with a digest when legally and technically available, followed by occurrence reassignment or an explicit reconciliation record; the reserved row must never be promoted in place.

`SRC-OLV-1997-USER-PDF-20260905` is the concrete private snapshot previously inspected. Its title, copyright page, corrected-reprint preface, contents, and selected Watson, Airy, Chapter 8, and Bessel printed/PDF page maps were inspected, and its exact bytes were bound by ordinary SHA-256. The original uploaded bytes are not present in the restarted environment; the surviving transcriptions and historical snapshot metadata do not permit a new source-image audit without reattachment or recovery. The full book bytes, OCR, and rendered page images remain outside version control. Most mathematical page audits remain `partial`; the Chapter 2 Bessel pages 55--61 and Chapter 12 Bessel pages 435--438 have complete, independently reviewed bounded audits. Complete page review does not by itself reconcile notation or entities, so the 119 Bessel occurrences remain `transcribed_unreconciled`, with no Bessel notation or entity association added.

Locators always use printed chapter, section, equation, example, exercise, or page labels. PDF page coordinates belong in `page_audits.csv`, never in the printed-page fields unless a page map has been verified.

## Meaning of “all named functions”

“Olver functions” is ambiguous: it could mean functions invented by Olver, functions conventionally bearing his name, or functions used in his book. The project claim is the last of these:

> Every distinct named special-function object and named normalization occurring mathematically in the locked 1997 corrected edition, plus separately reported comparison objects introduced by this project.

The source scan universe is the mathematical body of Chapters 1–14, worked examples, exercises, supplied answers, and mathematically substantive captions or tables. Contents and indexes are discovery aids. A contents-only row must remain `occurrence_unresolved` until a mathematical body occurrence is inspected in a reconciled snapshot.

An entity is in scope when the book uses it mathematically as a defined function, theorem target, coefficient, kernel, named comparison solution, named auxiliary, or named normalization. Apply these identity rules:

- A named derivative is a distinct entity when the source gives it a conventional name, such as trigamma. An unnamed prime is notation on the base entity.
- A value-changing normalization is a distinct entity even when related by one gamma or power factor. Ordinary and regularized hypergeometric functions may not be conflated.
- Literal alternate names on the same arguments and domain are aliases. A nontrivial parameter conversion is recorded as a relation, not erased.
- Real and complex restrictions normally remain one entity unless the source defines genuinely different continuations.
- Repeated definitions, uses, exercises, and normalization checks are separate occurrences connected to the same entity.

The following do not enter merely by being mentioned: arbitrary local functions; unnamed ODE solutions; elementary primitives; bibliography, historical-note, citation-title, contents-only, or index-only names; every neighbor on a DLMF page; or a modern name retroactively attached to an unnamed expression. Retain doubtful leads as unresolved occurrences rather than promoting or deleting them by inference.

### Queue classes

Named-function entities use four queue classes:

1. `seed`: introductory families concentrated in Chapter 2.
2. `cross_cutting`: named comparison, modulus, phase, envelope, or control functions used across methods.
3. `later_family`: named families developed after Chapter 2.
4. `project_extra`: a project-named object absent from the source, reported outside source-completeness totals.

The occurrence table also permits `source_theorem`, because it is the common occurrence substrate for closed manifests. The Watson occurrence is not thereby classified as a special function.

## Canonical normalized schema

Every CSV has an exact header checked by `scripts/validate_inventory.py`, and every row begins with `schema_version=inventory-v1.0.0`. Empty strings represent unresolved optional data; invented placeholders are forbidden.

### Core tables

`editions.csv` records bibliographic identities and whether an edition is the locked target or comparison-only. `edition_relations.csv` records directed reprint/correction relations, mathematical-content status, page-locator status, and join semantics, with at most one row per unordered endpoint pair. Only a relation with both equivalence axes `matched` may be marked `equivalent`; every unresolved or mismatching relation is machine-non-equivalent.

`source_snapshots.csv` records the exact objects inspected: provenance, access date, availability at inspection, digest state, reconciliation to its assigned edition, page mapping, and rights note. A digest marked `verified` must use `sha256` and exactly 64 lowercase hexadecimal digits. `unresolved` means no digest claim is made. A source-ready snapshot is non-placeholder, recorded `available`, digest-verified in that format, reconciled to its assigned edition, and has `page_mapping_status=matched`; `partial` previews and `pending` placeholders are never source-ready. These are structural and historical-provenance checks: a syntactically valid digest or recorded availability does not establish that the bytes are mounted in the current environment or were truthfully inspected. When CI cannot access the licensed bytes, digest truth and source inspection require separately retained external/manual evidence.

`page_audits.csv` records ranges actually inspected in a snapshot. Snapshot coordinates and printed coordinates are separate. `partial` means candidate discovery, OCR review, or a non-exhaustive pass; only `complete` plus independent review can contribute to the whole-book completion gate. A complete row must name a nonempty `reviewed_by` identifier distinct from `audited_by`, as well as a review date. Every resolved occurrence and every confirmed entity-evidence row requires such an audit for its exact source snapshot. When an occurrence records printed-page bounds, a complete audit for that snapshot must contain the entire inclusive printed range; a complete audit of some other page is insufficient.

`occurrences.csv` records printed definitions, theorems, formulas, exercises, tables, normalization checks, cross-references, and unresolved contents/index leads. Required source-manifest data are explicit columns:

- immutable occurrence and snapshot ids;
- edition, chapter/section, printed-page range, locator, and printed label;
- kind, target class, novelty class, role, and evidence type;
- `resolution_status`, which describes source resolution only;
- transcription state, hash metadata, collator, and date;
- reconciliation status, result, and notes.

`resolution_status` does **not** contain proof or theorem-card workflow. The proof progression (`inventoried -> specified -> ... -> released`) remains in theorem-card/release records. An occurrence may be selected by a locked but still-open planning manifest while unresolved. A `resolved` source occurrence requires a source-ready snapshot, verified SHA-256 transcription metadata, matched occurrence reconciliation, and direct source evidence (`direct_formula` or `direct_prose`). Resolved source definitions and source theorems also require confirmed notation and entity links.

`notation.csv` records exact glyph, binder/argument order, ambient type, parameter roles, branch, normalization, exceptional values, and derivative variable. A notation row is omitted when OCR cannot safely identify the glyph.

`entities.csv` records canonical mathematical objects, aliases, object kind, a concise source-basis summary, normalization state, a DLMF cross-check, possible Lean reuse, and identification-bridge state. DLMF is a convention check, not source-occurrence evidence. `entity_evidence.csv` is the normalized provenance ledger: every evidence row binds one entity to an edition and source snapshot and records whether that evidence is provisional or confirmed. The evidence edition must equal the snapshot's edition.

`cards.csv` and `manifests.csv` are small target registries. Cards keep `theorem_class`, `coverage_class`, and `novelty_class` orthogonal: mathematical shape and relationship to prior work are not source-coverage claims. `registration_status` mirrors manifest membership readiness, while `artifact_status` says only whether a card file is present. A `file_present` card must point exactly to `blueprint/theorem_cards/<card_id>.yaml`; pointing to some other existing repository file is invalid. A card registered as `execution_ready`, `active`, or `complete` must have that canonical file-present artifact. Neither field duplicates proof, review, implementation, or coverage workflow axes from the cards themselves. Manifests separately record `scope_closed`, `occurrence_selection_locked`, and `manifest_status`, plus the source-occurrence total against which the validator counts normalized associations.

The current manifest states follow `source_manifest.md`: `DEMO-0` is an open `planning_only` queue; `BOOTSTRAP-0` is closed and `execution_ready` with two cards and zero source occurrences; `IMPROPER-0` is a separate closed, source-free `execution_ready` specification with one card, eight public targets, and zero source occurrences; and `OLV-MVP-1` is `planning_only` with incomplete card scope but a locked one-occurrence selection. For `IMPROPER-0`, `execution_ready` means only that the specification is bounded and closed; final pre-Lean review, an external envelope, `lean_ready`, and implementation authorization remain absent. “Selection locked” freezes the chosen occurrence; it does not imply that the manifest is closed or executable.

### Association tables

All many-to-many relationships are explicit:

- `occurrence_notations.csv`: occurrence ↔ notation, including role and whether the link is confirmed or provisional.
- `occurrence_entities.csv`: occurrence ↔ entity.
- `occurrence_cards.csv`: occurrence ↔ theorem card, with roles such as exact-source target, source recovery, or generic dependency.
- `occurrence_manifests.csv`: occurrence ↔ closed manifest and its coverage role.

There are no comma-packed id lists and no `notation_id`, `entity_id`, `card_id`, or `manifest_id` columns in `occurrences.csv`. `notation.entity_id` remains a normalized many-to-one ownership relation; occurrence meaning is still expressed through both association tables.

A `confirmed` occurrence↔notation link requires both the occurrence and notation to be resolved/verified on source-ready snapshots. Ordinary confirmation requires the exact same `source_snapshot_id`; merely sharing an edition is insufficient, even when both snapshots are ready. This schema has no snapshot-equivalence table, so two different snapshots of one edition cannot transfer confirmation. Across distinct editions, both snapshots must be ready and reconciled and an explicit edition-relation row must have `matched` mathematical-content and page-locator equivalence plus `join_semantics=equivalent`. A `confirmed` occurrence↔entity link likewise requires a source-ready resolved/verified occurrence and a `confirmed` `entity_evidence.csv` row with compatible ready provenance. The current 2010-to-1997 relation is unresolved and `non_equivalent`, so neither preview notation nor preview entity evidence can be transferred to `OLV97-C03-WATSON`.

## Enumerated statuses

Occurrence `resolution_status`:

- `occurrence_unresolved`: locator lead only, or a body occurrence not yet securely identified.
- `located_untranscribed`: the mathematical body location was inspected, but an audit transcription is not verified.
- `transcribed_unreconciled`: a transcription exists but has not been reconciled to the locked edition and local notation/entities.
- `resolved`: location, transcription, notation/entities, and edition reconciliation are complete.
- `excluded_name_only`: inspected and excluded under the scope rule.
- `project_extra`: project-defined rather than a source occurrence.

Transcription status is independently one of `not_started`, `locator_only`, `summary_only`, `mathematical_transcription`, or `verified`. A `verified` transcription uses `sha256`, exactly 64 lowercase hexadecimal digits, a collator, and a date. Reconciliation status is `unresolved`, `matched`, `mismatch`, or `not_applicable`.

### Bessel revision-2 queue normalization

The two approved Bessel transcription queues use richer planning labels than
`inventory-v1.0.0`. Their 119 rows are normalized without changing this schema:

| Planning source kind / target / evidence | Inventory-v1 source kind | Inventory-v1 target | Inventory-v1 evidence | Transcription state |
|---|---|---|---|---|
| `body_definition` / `source_definition` / `direct_formula` | `body_definition` | `source_definition` | `direct_formula` | `verified` |
| `displayed_formula` / `source_formula` / `direct_formula` | `displayed_formula` | `source_formula` | `direct_formula` | `verified` |
| `source_property` / `qualitative_support` / `direct_prose` | `body_use` | `source_formula` | `direct_prose` | `verified` |
| `exercise` / `exercise_target` / `direct_formula` | `exercise` | `source_exercise` | `direct_formula` | `verified` |
| `notation_definition` / `source_notation` / direct evidence | `body_definition` | `source_definition` | the original `direct_formula` or `direct_prose` | `verified` |
| `normalization_check` / `source_formula` / `direct_formula` | `displayed_formula` | `source_formula` | `direct_formula` | `verified` |
| `cross_reference` / `source_reference` / `direct_prose` | `cross_reference` | `inventory_lead` | `direct_prose` | `verified` |
| `footnote` / `qualitative_support` or `source_report` / `direct_prose` | `body_use` | `source_formula` | `direct_prose` | `verified` |
| `footnote` / `source_reference` / `direct_prose` | `cross_reference` | `inventory_lead` | `direct_prose` | `verified` |
| `table` / `source_table_metadata` / `direct_table` | `table` | `source_table` | `direct_prose` | `summary_only`; numerical contents omitted |
| `figure` / `source_auxiliary_geometry` / `direct_figure` | `cross_reference` | `inventory_lead` | `direct_prose` | `summary_only`; geometry omitted |

The identifier mapping is the identity function: for every one of the 58 IDs
in the exact Chapter 2 queue and every one of the 61 IDs in the exact Chapter
12 queue, `inventory_occurrence_id(proposed_id) = proposed_id`. There are no
renames, merges, splits, collisions, or deferred rows; `occurrences.csv` is the
authoritative complete list. The Chapter 2 rows bind transcription SHA-256
`f157c9fc8688da02a680661c185a8a5458a24ba5b6dd77641190a4393d6e5439`,
and the Chapter 12 rows bind
`13d223d6e088582f2eb9c4fbc282cb4d1a8acf29abd32d6f28e26918d42acc5b`.
Both were approved at commit
`4147deda85688ac5e6e7dc0868a45c0f60dc7036` by external reports
`bessel_source_r2_referee_c.md` (SHA-256
`0910abe97f77c8291b3d6651d3a35bd136fdc654a43bff12d45c86df072e8e06`)
and `bessel_source_r2_referee_d.md` (SHA-256
`46f90b5ecffd8f5851d24153bf56818c0ed2e47904b4283da8a41fea823c807f`).
Every inserted row keeps `resolution_status=transcribed_unreconciled`,
`reconciliation_status=unresolved`, and `novelty_class=source_recovery`.
No notation/entity association, theorem card, occurrence-card link, manifest
membership, coverage claim, or Lean authorization follows from this mapping.

Notation resolution is `normalization_unresolved` or `resolved`. Entity identity is `provisional`, `confirmed`, or `excluded`; entity normalization is `unresolved`, `resolved`, or `not_applicable`. `confirmed` requires a confirmed association to a resolved, reconciled occurrence in a locked-target edition. A direct body hit in a comparison-only preview is still only `provisional` for this programme. Implementation identification is `not_assessed`, `reuse_candidate`, `construction_planned`, `bridge_pending`, or `proved`.

Association link status is `provisional` or `confirmed`. A provisional association is useful planning data, not a resolved semantic claim.

Card theorem, coverage, and novelty classes are not duplicated in the inventory validator. Their executable allowed sets come directly from current [`review/classifications-v3.json`](../review/classifications-v3.json) packet-level axes; immutable historical artifacts retain their older recorded authority. The validator derives its required registry set from each example's `registry_binding`: every `required` row (`QB-001`, `DEF-001`, `QL-001`, `OLV-001`, and `SR-001` currently) must exist in `cards.csv` with all three axes equal, while an `illustrative` row such as `NAMED-EXAMPLE` must not create a registry requirement. `IMP-001` is additionally registered as the sole `IMPROPER-0` member. Registry status is `planning_only`, `execution_ready`, `active`, `complete`, or `superseded`; artifact status is `planned` or `file_present`.

The v3-required `QL-001` novelty value is now `non_novel`, matching the classical bounded-primitive argument; frozen v2 remains unchanged, and the versioned correction claims no approval. `IMP-001` is registered in the separate source-free `IMPROPER-0` manifest through frozen card revision 7, metadata-only proof successor `NLP-IMP-001-R7`, and work-packet revision 1. The successor preserves the R6 mathematical proof and equations while changing only lifecycle/binding/status metadata; canonical `blueprint/proofs/IMP-001.md` R6 remains unchanged historical mathematical input and the dependency recorded by QL/OLV R4, without becoming frozen or inheriting approvals. The card binds exact-signature proposal revision 2 at SHA-256 `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d`. Fresh referees C and D approved only those proposal bytes at `9e6e038871ac66f80534626d3deade0b27af6752`, and the root negative-guard finding was resolved only for that snapshot; the records are archived at private [`review-evidence` commit `d0d4fb4`](https://github.com/jaumededios/LMLF/commit/d0d4fb4895733b5de8396794e81cbe1a19657bdb). This prerequisite-stage evidence is not final-packet quorum. `execution_ready` is specification-only: fresh final pre-Lean reviews and an external envelope remain pending, with no `lean_ready`, implementation authorization, production Lean, or source-coverage claim. The eight-target/three-module architecture and QL/OLV R4 planning drafts are otherwise unchanged; the revision-3 signature artifact remains immutable superseded evidence.

The `IMPROPER-0` compiled-unreviewed prototype uses temporary axiomatic
theorem stubs only and is not production Lean.

Manifest status is `planning_only`, `execution_ready`, `active`, `complete`, or `superseded`. `scope_closed` is an independent Boolean. `occurrence_selection_locked` is `true`, `false`, or `not_applicable`, because a zero-source bootstrap has no occurrence selection to lock. Every closed manifest and every manifest in a ready state (`execution_ready`, `active`, or `complete`) must have at least one registered member card, and every member card's registration status must equal the manifest status and have its canonical file-present card artifact. If such a manifest declares or links any source-coverage occurrence, its occurrence selection must be locked. Each source-coverage occurrence must have confirmed links to ready canonical cards in that same manifest for (i) an `exact_source_target`/`exact_source_generic` or `named_application`/`named_source_application` pair and (ii) a `source_recovery`/`audit_source_recovery` pair. A role link to a card in another manifest cannot satisfy closure. `generic_dependency` is not an additional coverage gate: in the normative Watson plan it is an implementation-DAG dependency, while the source manifest explicitly assigns occurrence coverage to the exact-source and source-recovery cards. A closed or ready manifest cannot contain an unresolved/unverified source occurrence. A source-dependent card cannot enter a ready registration state while any bound source occurrence is not source-ready.

## Audit queue

The queue is seeded only by direct publisher-preview pages, its contents, or cited DLMF locator pages. It is not an exhaustive result.

### Seed families

| Queue item | Evidence | Required audit |
|---|---|---|
| Gamma, reciprocal Gamma, Beta | Direct Chapter 2 §1 body pages in the 2010 preview | reconcile to 1997; integral domain, continuation, poles/zeros, parameter order |
| Psi/digamma, trigamma, tetragamma | Direct Chapter 2 §2.1 preview page | reconcile glyphs and named-derivative convention |
| Exponential, logarithmic, sine, cosine integrals | Chapter 2 §3 contents; exponential-integral definition begins in preview | exact member split, `Ei`/`E1`, cuts, principal values |
| Error functions, Dawson's integral, Fresnel integrals | Chapter 2 §4 contents | variants, scalings, continuation |
| Incomplete gamma functions | Chapter 2 §5 and Chapter 4 contents | upper/lower, normalized forms, parameter order |
| Orthogonal/classical orthogonal polynomials | Chapter 2 §§6–7 contents | enumerate only body occurrences, not the DLMF family tree |
| Airy integral/functions | Direct locked-1997 Chapter 2 §§8.1–8.3 transcription plus later contents leads | independently review the real/contour `Ai` identification, normalization, rotations, and derivative meaning |
| Bessel `J` and modified Bessel `I` | Independently approved locked-1997 Chapter 2 §§9–10 transcription with 58 atomic occurrence rows | reconcile notation, entities, branches, origin regimes, and exercise-domain/path semantics; rows remain `transcribed_unreconciled` |
| Zeta function | Chapter 2 §11 contents | confirm Riemann zeta identity and notation |

Authoritative convention cross-checks include DLMF [Gamma](https://dlmf.nist.gov/5.2), [exponential integrals](https://dlmf.nist.gov/6.2), [error/Fresnel](https://dlmf.nist.gov/7.2), [incomplete gamma](https://dlmf.nist.gov/8.2), [Airy](https://dlmf.nist.gov/9.2), [Bessel](https://dlmf.nist.gov/10.2), [modified Bessel](https://dlmf.nist.gov/10.25), [orthogonal polynomials](https://dlmf.nist.gov/18.1), and [zeta](https://dlmf.nist.gov/25.2).

### Cross-cutting comparison functions

| Queue item | Evidence | Required audit |
|---|---|---|
| Elementary exponential comparison solutions | Chapter 10 contents | separate unnamed expressions from named project wrappers |
| Airy functions, derivatives, modulus/phase, auxiliaries | Direct locked-1997 Chapter 11 §§1.1–2.4 transcription; [DLMF §9.8](https://dlmf.nist.gov/9.8) cross-check | independently review the enumerated `Ai`, `Bi`, `E`, `M`, `theta`, `N`, `omega`, `c`, `lambda`, `mu_1`, and `mu_2` records |
| Bessel/modified-Bessel simple-pole models | Independently approved locked-1997 Chapter 12 §1 transcription with 61 atomic occurrence rows; [DLMF §2.8](https://dlmf.nist.gov/2.8) is only a convention cross-check | reconcile basis identity, normalization, phase construction, exceptional orders, and real/complex auxiliary bridges |
| Inhomogeneous Airy/Scorer-type models | Chapters 10–11 contents; [DLMF §9.12](https://dlmf.nist.gov/9.12) supplies Olver page locators | direct source scan before confirming each Scorer notation |
| Coalescing-saddle and endpoint models | Chapter 9 CFU/Bleistein sections; [DLMF §2.4](https://dlmf.nist.gov/2.4) gives modern taxonomy | verify which modern names occur in the edition |
| Envelope/control objects | Chapters 11–12 auxiliary headings and project design | separate source entities from `project_extra` |

### Later families

| Source area | Contents-confirmed queue | Convention cross-check |
|---|---|---|
| Chapter 5 | hypergeometric, generalized hypergeometric, associated Legendre, Legendre, Ferrers | [DLMF §15.1](https://dlmf.nist.gov/15.1), [§14.1](https://dlmf.nist.gov/14.1) |
| Chapter 6 | parabolic cylinder | [DLMF §12.1](https://dlmf.nist.gov/12.1) |
| Chapter 7 | Hankel, Bessel `Y`, other cylinder, modified Bessel, confluent hypergeometric, Whittaker, Struve | [DLMF §10.4](https://dlmf.nist.gov/10.4), [§13.1](https://dlmf.nist.gov/13.1), [§13.2](https://dlmf.nist.gov/13.2), [§11.1](https://dlmf.nist.gov/11.1) |
| Chapter 8 | Direct locked-1997 §1 transcription of periodic primitives, Bernoulli numbers/polynomials, finite Euler--Maclaurin, and positive-even zeta; later material remains discovery-only | [DLMF §24.2](https://dlmf.nist.gov/24.2) |
| Chapter 9 | Nicholson Bessel combination and Anger functions | [DLMF §11.11](https://dlmf.nist.gov/11.11) |
| Chapter 14 | exponential integral and confluent hypergeometric revisited | reconcile to earlier entities |

DLMF distinguishes regularized Gauss `\mathbf F` in [DLMF (15.1.2)](https://dlmf.nist.gov/15.1.E2) and regularized Kummer `\mathbf M` in [DLMF (13.2.3)](https://dlmf.nist.gov/13.2.E3), with the ordinary-`M` relation in [DLMF (13.2.4)](https://dlmf.nist.gov/13.2.E4). The [Anger–Weber notes](https://dlmf.nist.gov/11.11) flag an Olver-specific factor convention. These are normalization warnings, not evidence that every notation occurs in the book.

Goodwin–Staton, incomplete beta, Faddeeva, generalized exponential integrals, spherical Bessel, conical, Lommel, Lambert `W`, and similar relatives remain unpromoted until a direct locked-edition body occurrence is found.

## Audit workflow

1. Register the exact source snapshot without claiming a digest or page map that has not been obtained.
2. Record page ranges actually inspected; distinguish discovery passes from exhaustive, independently reviewed audits.
3. Seed contents/index leads as `occurrence_unresolved` and `locator_only`.
4. Inspect the mathematical body in order and create a separate occurrence for each definition, theorem, formula, exercise, table, use, and normalization check in manifest scope.
5. Produce a copyright-safe mathematical transcription, record its hash, and have a second collator verify it against the exact snapshot.
6. Create notation rows for each local glyph; capture binders, types, argument order, branch, normalization, and exceptional values.
7. Consolidate entities only after aliases and value-changing normalizations are compared.
8. Use DLMF to detect convention hazards, never to backfill a missing source occurrence.
9. Associate occurrences with cards and manifests. Manifest selection freezes scope, not truth or proof progress.
10. Reverse-audit theorem cards and public APIs for unlinked names, then reconcile totals and index-only exclusions.

For `OLV97-C03-WATSON`, the concrete locked snapshot, printed Theorem 3.1 label, mathematical transcription and hash, page map, and provisional notation/entity records now exist. The revision-4 design is source-facing over complex scalars with a real corollary; it represents ordinary convergence by independent one-sided limits at a finite exceptional set and a continuous normalized primitive with regular-piece increments. Lean-facing regular pieces use Mathlib Bochner `intervalIntegral` with explicit integrability evidence, while only endpoint passages are improper; no second proper-Riemann library is planned. QL-001 consumes IMP T06 for its tail, T07 for model terms, and T04 for the local join. OLV-001 chooses one common baseline `X > 0` before `n`, uses T07/T03/T04/T08 to obtain the baseline primitive, derives `L` itself, and then invokes QL-001. Independent approval and confirmed associations remain unresolved. Draft QL-001 and OLV-001 revision-4 cards/proofs remain planning-only without frozen signatures or authorization. Their upstream IMP-001 specification now lives separately in source-free `IMPROPER-0`; its readiness does not authorize QL/OLV or earn source coverage. The related `OLV97-C03-WATSON-BOUNDS` row separately records section 9.1-9.2's stronger global-majorant formulas; its draft OLV-002 packet is unregistered and neither occurrence nor packet is selected into the one-occurrence MVP manifest.

Four additional exact locked-edition occurrence rows bind the Chapter 2 `Ai`,
Chapter 11 real Airy/basis, Chapter 11 real auxiliaries, and Chapter 8
Euler--Maclaurin/Bernoulli transcriptions. Their hashes and partial page maps
are recorded, but every source, normalization, entity, and association state
remains unreconciled or provisional. Airy remains uncarded. The Bernoulli
numbers/polynomials and periodic identification have separate unregistered
revision-1 planning cards and proofs, `DEF-BERN-001` and `DEF-BERN-002`;
two independent reviewers approve the exact DEF-BERN-002 source/reuse content,
but its formal packet, upstream acceptance, registry, and source-status gates
remain open. Accordingly,
there is no `cards.csv` or occurrence-card association and no manifest selects
any of these four occurrences.

The two independently approved Bessel revision-2 transcriptions contribute a
further 119 atomic occurrence rows: 58 for Chapter 2 `J`/`I` and 61 for Chapter
12 real comparison bases and auxiliaries. They are hash-bound and source-
verified, but remain `transcribed_unreconciled` with unresolved reconciliation.
No notation, entity, card, occurrence-card, or manifest association was added,
and the rows provide neither source coverage nor Lean authorization.

## Completion gates

The whole-edition function inventory is complete only when:

- every page in the scan universe has a `complete` page audit and an independent reviewer;
- every contents/index lead is resolved or justified as `excluded_name_only`;
- no source occurrence remains `occurrence_unresolved`, `located_untranscribed`, or `transcribed_unreconciled`;
- every resolved occurrence has verified transcription metadata and matched edition reconciliation;
- every resolved named-function occurrence has confirmed notation and entity associations;
- all branches, orientations, parameter orders, aliases, derivatives, continuations, exceptional values, and normalizations are resolved;
- reverse-auditing released theorem cards and public APIs finds no unlinked named object;
- project extras are separated from source counts;
- manifest totals validate and a whole-book report gives zero unresolved source rows.

An implementation claim has an additional gate: the entity's conventional specification and identification bridge are `proved`. Occurrence resolution and theorem workflow remain separate.

## Copyright-safe documentation policy

The publisher preview carries an all-rights-reserved notice. Store bibliographic facts, short names, source locators, audit metadata, independently written paraphrases, and only mathematical formulas needed to specify formal objects. Do not commit the book PDF, page images, bulk OCR, copied exercises or answers, tables, figures, or extended source prose.

When a source theorem needs exact collation, store a fresh mathematical transcription rather than prose, cite the snapshot and printed locator, and hash the transcription. Do not reconstruct contiguous pages through accumulated notes. Local scans and OCR remain outside version control.

DLMF is cited for normalization checks and locators. Follow the [NIST copyright and permissions notice](https://www.nist.gov/copyrights-disclaimers), preserve attribution, and check separately marked third-party material. Prefer links and independent summaries over copied prose or tables.

## Validation

Run:

```bash
python3 scripts/validate_inventory.py
python3 scripts/validate_inventory.py --negative-tests
```

The validator uses only the Python standard library. It loads all three packet class enums and the complete required registry binding from the frozen classification JSON, then checks schema versions and exact headers, primary/composite-key uniqueness, SHA-256 syntax, edition/snapshot identity and readiness, one deterministic relation per unordered edition pair, the reserved placeholder's immutable state, non-equivalent unresolved edition relations, exact-snapshot confirmation, preview-specific IDs, entity-evidence provenance, locked-edition confirmation gates, foreign keys, association targets, independently reviewed complete page audits and printed-range coverage, canonical artifact readiness for cards and their closed/ready manifests, resolved occurrence/notation gates, nonempty and status-consistent closed/ready manifests, locked source selection, same-manifest exact/named and recovery coverage roles, source-dependent card/manifest readiness, and manifest source-occurrence totals. `--negative-tests` mutates independent in-memory copies to prove that twenty-five high-risk fixtures are rejected, including unlocked ready source selection and a fully source-ready occurrence attempting to launder exact/recovery roles across manifests, the composed fake-ready-source case with no complete audit or card artifacts, a non-covering page audit, ready registration without an artifact, conflicting duplicate edition relations, in-place placeholder promotion, self-reviewed complete page audits, arbitrary existing card paths, empty closed manifests, invalid hashes, resolution against the locked placeholder, placeholder and distinct-ready-snapshot joins within one edition, unresolved confirmed endpoints, premature source-card/manifest readiness, all-three-axis registry drift, and the earlier cross-edition Watson links. Routine checks run locally with `lake build` and `python3 scripts/validate_inventory.py --negative-tests`; GitHub Actions is explicit manual-only via `workflow_dispatch`, not push/PR automation. This is an inventory-table validator only; a green result validates recorded structure, not the truth of inaccessible source bytes, source certification, a broader contract-lint result, or a Lean/review gate.
