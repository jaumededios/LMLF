# Stage 1 R6 migration reuse audit — proposer preparation only

## Status and fixed snapshot

This is a bounded, read-only reuse inventory for a possible later migration. It is **not** an independent review of R6, an approved schema, a source audit, a migration, an authorization to mint DLMF records, or review/quorum credit. I did not inspect the other R6 reviews or predecessor reviews.

- Accepted implementation checkout: `/workspace/Documents/Codex/2026-09-05/yo`, clean `main` at `b8d2f731fcfd5cd0889d0732f13699eb94681c86`.
- Proposed scope checkout: `/tmp/lmlf-stage1-scope.DbhM9YHt`, clean `docs/stage-1-dlmf-through-10` at `dacf41e4c877ca6c58725128a7bcaaa651f49606`.
- Proposed plan: `blueprint/stage_1_dlmf-R6.md`, SHA-256 `fd75254a9e2d00076c404b535f8e40ac1c5c7a5574b5eb536e13f270c0ec29f6`.
- The current inventory/validator/review files named below have no diff between those two heads. They also have no diff from R6's stated frozen baseline `3a1b16cae6d186a20530de3b883c1bb871ee76f6` to accepted main.
- Key current digests: `function_inventory.md` `db5e43f2d8a828e05ea7b227ee8b4a361cd4753b58fb38b1418bc1af9121b1f3`; `validate_inventory.py` `c954ce39762b160e7328846dc3740df242deb381b4d5da7995df70cd74b90a75`; `classifications-v3.json` `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`; `review/PROTOCOL.md` `7453bc0ca6985d7ca2e8c525d9655a94e412c48e3850b92d9367a9f643d3177d`.

R6 itself says the plan has no operative authority and authorizes no schema migration (`stage_1_dlmf-R6.md:10-19,30-49,1119-1121`). Its migration requirement is expressly future and must leave the Olver v1 rows and v3 classifications unchanged (`:248-250,629-633,1019-1027`).

## Existing data contracts worth reusing

### Normalized inventory substrate

`blueprint/function_inventory.md:59-101` already establishes useful invariants: exact table headers, a schema version on every row, normalized many-to-many joins, distinct edition/snapshot identities, and separate occurrence, notation, entity, card, and manifest facts. The authoritative machine inputs are these 14 files under `blueprint/inventory/`:

| Table | Rows | Existing contract that transfers |
|---|---:|---|
| `editions.csv` | 2 | bibliographic identity distinct from inspected bytes |
| `edition_relations.csv` | 1 | deterministic relation per unordered pair; equivalence is explicit |
| `source_snapshots.csv` | 3 | immutable snapshot ID, provenance, digest, reconciliation, mapping, rights |
| `page_audits.csv` | 13 | inspected ranges and independent completion review |
| `occurrences.csv` | 148 | stable occurrence identity, locator, evidence, transcription and reconciliation axes |
| `notation.csv` | 31 | glyph/binders/type/branch/normalization/exception details |
| `entities.csv` | 32 | canonical object, aliases, source basis, normalization and Lean-identification state |
| `entity_evidence.csv` | 34 | normalized entity-to-snapshot provenance |
| `cards.csv` | 6 | card registry with orthogonal packet classification and artifact state |
| `manifests.csv` | 4 | scope closure, selection lock, lifecycle, declared source total |
| four `occurrence_*.csv` joins | 88 total | explicit occurrence↔notation/entity/card/manifest relations |

Representative current state matters for compatibility: all 148 occurrences have `reconciliation_status=unresolved`; none is `resolved`; 125 are `transcribed_unreconciled`. All 31 notations and 32 entities remain unresolved/provisional. The two complete page-audit rows are independently reviewed Bessel bounded audits. `OLV-MVP-1` has one selected source occurrence but remains open/planning-only; `BOOTSTRAP-0` and `IMPROPER-0` are closed source-free `execution_ready` specifications (`function_inventory.md:86-88,116-165`; `manifests.csv:2-5`). These facts must not be upgraded by migration.

The best reusable conceptual seams are:

- edition versus byte snapshot and non-transfer (`function_inventory.md:20-28,65-69`);
- occurrence resolution independent from proof/card lifecycle (`:71-88`);
- normalized association tables and exact-provenance confirmation (`:90-101`);
- selected occurrence scope distinct from truth, execution, and coverage (`:158-165,213-224`);
- project extras excluded from source counts (`:248-262`).

### Validator implementation seams

`scripts/validate_inventory.py` is standard-library-only and already factors the pieces a successor can adapt:

- `HEADERS`, `PRIMARY_KEYS`, `REQUIRED`, `ENUMS` (`:46-570`) provide a declarative per-table registry.
- `load_classification_authority` (`:578-749`) validates the frozen v3 metadata, checks the exact v2 predecessor digest, loads packet/target enums, and derives registry requirements from `registry_binding` rather than a hardcoded card list.
- `read_tables`, `check_rows`, `index_by`, `check_foreign_keys` (`:752-905`) provide exact-header parsing, line-aware diagnostics, uniqueness, required-field/enumeration checking, and joins.
- `parse_page_pair`, `is_lowercase_sha256`, and readiness predicates (`:908-1053`) isolate range, digest, snapshot, audit, canonical-card, occurrence, and provenance rules.
- `check_semantics` (`:1056-1801`) already enforces deterministic edition relations, immutable pending-placeholder state, source/occurrence digest syntax, independent page review, printed-range coverage, exact-snapshot/equivalent-edition joins, confirmed entity/notation gates, canonical card artifacts, role/class compatibility, and same-manifest source closure.
- `check_manifest_totals`, `check_classification_examples`, and `validate_tables` (`:1803-1887`) are clean aggregation/orchestration seams.
- `run_negative_invariant_tests` (`:1890-2583`) uses deep-copied in-memory mutations; the current run reports 25 rejected invalid fixtures. This mechanism is reusable, although its fixtures are coupled to named Olver seed rows and should remain a legacy suite rather than become the only DLMF fixture mechanism.

Do not treat the current pass as more than structural validation. `source_snapshot_is_ready` checks recorded syntax/state but not mounted bytes (`:964-974`); `function_inventory.md:67` explicitly says that truth and inspection require separate evidence.

### Classification, lifecycle, and evidence formats

- `review/classifications-v3.json` is a frozen, machine-readable versioned authority. Its separate packet/target axes, `supersedes` binding, `registry_binding`, and required-versus-illustrative examples are directly reusable patterns (`classifications-v3.json:1-13,14-103,104-165`). Its bytes and existing allowed values are not a place to insert R6 roles.
- The seven orthogonal card/lifecycle axes already exist in `blueprint/theorem_cards/README.md:49-79`. Candidate-owned fields are temporal self-descriptions; external records establish effective approval/authorization. That separation matches R6 (`stage_1_dlmf-R6.md:802-816`).
- `review/PROTOCOL.md:56-79` supplies non-self-referential packet binding and the candidate-versus-authority boundary; `:186-210` supplies structural quorum; `:212-257` separates envelope, verdict, proposer evidence, and disposition; `:275-327` supplies exact-head invalidation and strict merge checks.
- `review/templates/work_packet.yaml` schema 4 already carries exact source, upstream artifact digests, target-level classifications, exact signatures, dependency pins, review compositions, regressions, and verification commands (`:1-45,46-97,98-238`).
- `review/templates/review_envelope.yaml` schema 3 binds frozen specification, classification authority, toolchain, candidate head, pre-Lean gates, implementation verdicts, disposition ledger, and merge decision (`:1-71`).
- `review/templates/verdict.json` schema 4 binds exact artifacts/head/rubric to durable reviewer identity, isolation, verdict, rerun evidence, and findings (`:1-74`). `disposition_ledger.yaml` schema 1 supplies append-like finding disposition with confirming verdict/supersession references (`:1-18`).

These formats are reusable as versioned predecessors and binding patterns. They are not currently executable lifecycle validation: `review/README.md:83-92` and `blueprint/automation/contract_linting.md:11-22` state that only the CSV inventory validator exists.

## What the current validator checks, and what R6 genuinely adds

| R6 requirement | Reusable present check | Genuinely missing capability |
|---|---|---|
| stable source bytes and provenance (`R6:195-250`) | snapshot IDs, SHA-256 syntax, edition/page reconciliation, rights fields | DLMF release identity; canonical retrieval documents; aliases/redirect chains; representations; per-retrieval method/date/version evidence; retained exact-payload evidence and `non_reproducible`/`expired` state; digest recomputation when bytes are supplied |
| exact source partition (`R6:319-393`) | occurrence IDs, locators, page audits, distinct repeated rows | content hierarchy/containers; exclusive source-owning leaves; annotations; shared contexts; source appearances; atom ordinals and ownership keys; mathematical/mixed/nonmathematical dispositions and fidelity roles; exhaustion/nonduplication certification |
| append-only repair (`R6:394-477`) | immutable reserved placeholder; edition relations; no implicit same-edition snapshot equivalence | typed document/appearance correction, same-appearance atomization/resolution lineage, cross-snapshot evolution, notation/entity/association correction, fresh-ID constraints, effective-record selection by a pinned view |
| local/global denominator (`R6:479-612`) | deduplicated manifest association totals; locked source selection | separate source-audit batches/revisions and Lean execution manifests; `PartitionReady`; undefined-versus-empty `Target(S,B)`; global `B_all^r`; overlap/view compatibility; explicit external selection and suspension |
| total obligation classification (`R6:627-742`) | v3 versioned packet/target enums and registry binding; card-role compatibility | v3 successor with per-atom single-valued source semantics; ordinary inapplicability reason; exact ordinary/finite/recovery role cardinality and declaration/evidence bindings; rejection of `mixed` for new DLMF source obligations |
| support closure (`R6:744-800`) | card↔manifest and occurrence↔card FKs | finite least transitive dependency closure, edge-complete witness, target-versus-support roles, cycle/consumer checks, pinned Mathlib interface terminal nodes, many-manifest card membership |
| stable effective state/current authority (`R6:802-871`) | orthogonal candidate status vocabularies; exact-head envelopes and verdicts specified manually | selected external authority view; complete event fold over accepted adverse/supersession/suspension/withdrawal records; precision of affected dependents; no fallback; compatibility of all heads/pins/views; automated quorum and lifecycle evaluation |
| completion fixtures (`R6:873-933`) | mutation-based negative harness and 25 present legacy fixtures | the R6 fixture set, positive tiny accounting fixture, structured diagnostics, validation levels, and tests independent of production Olver IDs |

Two current behaviors must not be generalized accidentally. `source_provenance_is_compatible` permits an explicitly equivalent cross-edition join (`validate_inventory.py:1028-1053`), while R6 requires a DLMF/Olver crosswalk that never transfers coverage (`R6:797-800`). Also, current manifest totals are always integers (`validate_inventory.py:1803-1841`), while R6's local/global targets are partial values and remain undefined until their respective partition/selection gates pass (`R6:493-568`).

## Candidate separately reviewable migration work packages

These are dependency boundaries, not approval of a table layout or a universal framework.

1. **Legacy compatibility fixture.** Input: exact v1 files and v3 authority above. Output: recorded byte digests, row/count/status golden results, and the untouched current positive/negative suite. Tests: both existing validator commands must retain their exact successful result; mutation of any frozen Olver ID/data/classification is rejected or shown as a versioned successor, never silently normalized.
2. **Schema-set loader and diagnostics.** Input: existing `HEADERS`/key/enum/read/check helpers plus an approved persistence decision. Output: versioned table registry, explicit input roots, stable diagnostic codes/JSON alongside text, and isolated synthetic fixtures. Tests: v1-only compatibility; mixed approved schema-set parsing; unknown version/header/field, duplicate ID, bad FK, and root-escape rejection. No DLMF production rows.
3. **DLMF snapshot/document/evidence identity.** Input: R6 §2 contract and synthetic records only. Output: records/checks for release snapshot, canonical retrieval document, aliases/redirects/representations, retrieval facts, and exact-payload evidence availability/rights. Tests: locator aliases cannot mint payloads; representation mismatch blocks readiness; changed bytes require a new snapshot; digest-only unavailable evidence cannot renew approval.
4. **Partition, appearances, atoms, lineage, and pinned source views.** Input: approved identity layer and R6 tiny fixture (`R6:938-1017`). Output: hierarchy/leaf, appearance/context/atom, disposition/fidelity, typed append-only corrections, immutable audit revision, and effective-view checks. Tests: encode the positive five-target fixture and the corresponding omission, duplicate ownership, illegal cross-appearance merge, ID reuse, zero-successor, repeat-location, and predecessor-plus-successor failures.
5. **Classification successor and obligation mappings.** Input: frozen v3 bytes plus the approved atom model. Output: separately versioned successor authority and explicit per-atom classification/mapping records; old cards stay bound to v3. Tests: total/single-valued effective classification; semantic rejection of missing/duplicate roles; exact declaration/evidence binding; `mixed`/entity-identification cannot earn DLMF target credit. This package needs independent schema/source-classification approval before any DLMF card freezes.
6. **Audit batches, execution manifests, and support closure.** Input: pinned source/classification/entity views and normalized joins. Output: separate finite audit-revision membership, execution-manifest membership, target/support mapping, and finite closure witness. Tests: `Target` undefined before readiness; no chapter wildcard; overlap deduplicates only under compatible views; local count is not global; orphan/blocked/cyclic/omitted support fails; one card may belong to multiple manifests without mutating a historical card row.
7. **External authority and effective lifecycle fold.** Input: versioned successors to envelope/verdict/disposition formats and explicit external evidence roots. Output: records/checks for local/global selection, prior selection, accepted adverse evidence, suspension/withdrawal, affected dependents, exact integration head, and effective status projection. Tests: adverse omission, mutable-latest selection, silent fallback, stale-head quorum, candidate self-selection, incomplete bindings, and compiled-only completion all fail.
8. **One-head integration gate.** Input: all previously approved packages. Output: a read-only completion report binding the exact schema set, source/audit/entity/classification views, execution manifests, external authority set, repository head, Lean toolchain, and Mathlib pin. Tests: legacy validator plus all new fixture suites; incompatible head/view/pin aggregation fails. Keep GitHub CI out of scope unless separately authorized.

Each package should have its own frozen inputs/digests and independent review before the next depends on it. The current pure helper functions can be moved or parameterized only when a concrete second consumer exists; there is no need to invent a general database framework before the fixture proves the contract.

## Compatibility hazards and decisions for root

1. **Persistence/versioning decision (material).** Exact v1 headers are enforced (`validate_inventory.py:46-233,771-779`), and R6 freezes existing Olver rows/IDs. The lowest-risk default is to leave every `inventory-v1.0.0` CSV and v3 byte-identical and add versioned multitrack companion tables/readers, with an explicit compatibility projection. The alternative—copying old rows into a new monolithic schema—needs a reviewed one-to-one migration ledger and risks making a rewritten row look authoritative. Root should choose before package 2; this note does not choose it.
2. **Authority-record decision (material).** Existing external templates have no fields for audit revision/view selection, adverse-event completeness, suspension/withdrawal, exact-payload availability, or global closure. Root must choose a canonical versioned external record encoding and durable storage/reference contract before package 7. In-place reinterpretation of old envelope/verdict/ledger schemas would invalidate historical meaning.
3. **Status projection decision.** `cards.csv` currently requires one `manifest_id` and literal `registration_status == manifest_status` (`validate_inventory.py:1569-1578`); R6 requires immutable candidate self-status, external effective state, and potentially several manifest memberships. Preserve the old rule for v1 only. Root should decide whether new card/manifest relations live entirely in companion tables or behind a versioned adapter; do not back-write old cards.
4. **ID policy.** Preserve every existing human-readable `OLV*` identifier and its evidence. Apply opaque never-reused IDs to new records prospectively, with explicit track/source kind and a non-credit DLMF↔Olver crosswalk. Do not rename old rows to make the namespace cosmetically uniform.
5. **Meaning of availability.** Existing `availability_status=available` records availability at inspection, not necessarily present rerunnable bytes now (`function_inventory.md:20-26,67`). A future exact-payload evidence state must not retroactively downgrade or upgrade the historical snapshot row; it is a separately time-bound authority input.
6. **Role compatibility.** Existing roles/classes (`exact_source_target`, `source_recovery`, `exact_source_generic`, etc.) remain valid for their Olver artifacts. R6's ordinary/finite/recovery roles are new DLMF obligations, not aliases that can silently reclassify old records. Likewise, v3 SHA-256 `975e08b8...c4b5e` is embedded in all three current review templates and must remain a valid historical binding.

## Commands rerun

```text
/home/codex/.codex/skills/referee-lean-library/scripts/library_inventory.sh /workspace/Documents/Codex/2026-09-05/yo
  PASS: clean b8d2f731... snapshot inventory produced; no trust/resource markers reported.

python3 scripts/validate_inventory.py
  PASS: 148 occurrences, 31 notations, 32 entities, 34 entity-evidence rows,
        88 occurrence associations; manifest totals 0/0/0/1 as recorded.

python3 scripts/validate_inventory.py --negative-tests
  PASS: 25 intentionally invalid copied fixtures rejected; same positive totals.

git diff --name-status 3a1b16c..b8d2f73 -- <audited inventory/validator/review paths>
git diff --stat b8d2f73..dacf41e -- <audited inventory/validator/review paths>
  PASS: both empty.
```

No source bytes were accessed, no DLMF pages were audited or downloaded, no schema/data/status was changed, and no mathematics, Lean, Verso, commit, push, CI run, or authorization was produced.
