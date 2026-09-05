# Contract linting and source-card validation

**Status:** planning specification; no linter implementation is authorized

**Purpose:** deterministic checks for theorem cards, source inventories, work
packets, proof artifacts, review bindings, and later Lean declarations

**Authority boundary:** a linter can reject structurally incomplete evidence; it
cannot approve mathematics, source fidelity, or review independence

The linter is a read-only consistency checker over frozen artifacts.  It does
not create theorem cards, invent missing fields, select a source occurrence,
write reviewer verdicts, or advance a lifecycle state.  Its result is evidence
for a human or independently authorized merger.

## 1. Inputs and identities

One lint run receives explicit roots and never discovers scope from prose:

- `blueprint/theorem_cards/*.yaml` and any signature artifacts they bind;
- `blueprint/proofs/*` natural-language proof artifacts;
- `blueprint/inventory/*.csv` occurrence, notation, entity, manifest, and join
  tables;
- `blueprint/source_manifest.md` only as a human-readable cross-check, not as
  the machine source of row counts;
- `review/work_packets/*.yaml`;
- an optional external review envelope, verdict set, and disposition ledger;
- the pinned `lean-toolchain` and resolved Mathlib revision;
- later, an explicit Lean environment and declaration list at a candidate head;
  and
- exact source-snapshot paths only when rights and repository policy permit the
  linter to read those bytes.

Every run records a schema-set version, input file digests, repository commit or
explicit dirty-tree marker, and tool version.  It must not silently fetch a
source, consult a mutable web page, or update a digest.  Network access is not
part of validation.

## 2. Validation levels

Checks are grouped so that a planning artifact is not falsely judged by a
release rule.

| Level | Intended use | What may fail the level |
|---|---|---|
| `parse` | authoring | invalid YAML/CSV/JSON, duplicate key, invalid UTF-8 |
| `draft` | card/proof drafting | missing stable IDs, invalid enums, broken local references |
| `freeze` | artifact review | incomplete target fields, unresolved proof/signature bindings, self-reference |
| `manifest` | close or activate a release manifest | open membership, unresolved occurrence graph, wrong status/classification |
| `lean_ready` | authorize implementation | missing pre-Lean approvals, digest mismatch, unaccepted dependencies |
| `candidate` | implementation review | declaration/signature/import/axiom/regression mismatch |
| `release` | final reconciliation | incomplete review quorum, open dispositions, coverage or audit failure |

A command always names one level.  Passing `draft` says nothing about
`lean_ready`; passing `candidate` does not make a review verdict `approve`.

## 3. Diagnostics

Diagnostics have stable codes, one primary artifact location, related locations,
and one of three severities:

- `error`: a deterministic contract violation that blocks the requested level;
- `warning`: a review-required ambiguity or a planning-state condition that is
  legal at the requested level; and
- `info`: coverage counts, unresolved queues, or suggested next evidence.

Exit code is nonzero exactly when an `error` exists.  Human-readable text and a
versioned JSON report are required; SARIF may be added later.  CI assertions use
diagnostic codes and structured fields, never the complete English message.

Suppressions, if ever added, must be local, code-specific, justified, expiring,
and reviewed in the same work packet.  No blanket path suppression is allowed
for source fidelity, trust, digest, or review-quorum errors.

## 4. Schema and vocabulary checks

The linter validates:

1. a known `schema_version` on every machine artifact;
2. required keys, scalar/list/object shape, unique mapping keys, and explicit
   use of `not_applicable` where the schema requires a decision;
3. stable IDs and uniqueness in their namespace;
4. controlled status and verdict vocabularies from `theorem_cards/README.md` and
   `review/PROTOCOL.md`;
5. valid SHA-256 syntax and immutable positive revision identifiers;
6. repository-relative normalized paths with no root escape;
7. no placeholder tokens such as `REPLACE_*` at `freeze` or later;
8. no artifact claiming its own path, commit, or digest where the protocol
   requires an external binding; and
9. no unknown field at frozen levels unless the schema explicitly permits an
   extension namespace.

The repository currently uses different classification vocabularies at
different layers.  Theorem cards use coverage values such as `infrastructure`,
`entity_identification`, and `exact_source_generic`; review packet targets use
values such as `reusable_infrastructure`, `source_prerequisite`, and
`direct_source_target`.  A validator must not compare these raw strings or
guess a mapping.  Before cross-artifact classification linting is activated, a
versioned mapping table or one canonical vocabulary must be frozen.  Missing or
ambiguous mapping is `SCHEMA-CLASS-001` at `freeze` level.

Likewise, roadmap terms such as `foundational_calculus` and review-protocol
terms such as `generic_quantitative` answer related but nonidentical questions.
Their relation must be explicit rather than inferred from names.

## 5. Reference-integrity checks

All joins are checked in both directions where closure is claimed:

- every card manifest exists in `manifests.csv`;
- every `source_occurrence`, `source_notation`, and `source_entity` ID exists in
  its inventory;
- every join-table endpoint exists and duplicate join rows are rejected;
- every work-packet target names a card and proof artifact declared in
  `upstream_artifacts`;
- every artifact ID/revision/digest in a work packet agrees with the external
  review envelope;
- every dependency work item names an accepted commit and public declaration;
- every downstream consumer is either a present card or explicitly marked
  planning-only by schema;
- every signature artifact path exists and has the recorded digest when the
  schema binds one; and
- every source snapshot ID exists and has a compatible edition ID.

An orphan inventory row is reported, but whether it blocks depends on its queue
and manifest state.  A dangling reference is always an error at `freeze` or
later.

## 6. Source-card validators

Here “source card” means the linked occurrence, notation, entity, theorem-card,
and manifest records for one scoped source obligation.  It is not only the YAML
file bearing a theorem ID.

### 6.1 Source snapshot and edition

For every source-bearing occurrence, validate:

- exact edition ID, author/title identity through the manifest record, and a
  page/section/equation/exercise locator appropriate to the occurrence kind;
- a source snapshot whose edition reconciliation and page mapping satisfy the
  requested gate;
- digest algorithm and digest value when a stable byte snapshot is claimed;
- recomputed digest equality when bytes are locally available;
- access date and provenance; and
- no substitution of a DLMF link or later-edition preview for direct collation
  against the locked Olver 1997 occurrence.

A placeholder snapshot is legal in a planning queue and blocks `manifest` or
later.  A cross-check URL is supporting evidence only.

### 6.2 Occurrence identity and transcription

The validator requires each closed-manifest occurrence to have:

- a unique, case-stable occurrence ID;
- source kind, printed label where present, context role, and exact page range;
- a transcription status compatible with a nonempty transcription hash;
- a notation and entity resolution for every symbol or named object used by the
  target statement;
- a theorem-card link whose role agrees with the card's coverage class; and
- a reconciliation result at release.

Repeated printed occurrences remain separate.  The validator rejects merging
them merely because they share a mathematical formula.

An OLV-001 row using `named_application` would conflict with the roadmap's
`exact_source_generic` classification and must be reported as `SRC-ROLE-001`,
not silently normalized.  The current row uses `exact_source_target`.

### 6.3 Notation resolution

Every notation row linked to a closed occurrence supplies:

- printed symbol and binder/argument order;
- ambient type and parameter versus spatial roles;
- branch/domain, orientation, scale, and normalization where applicable;
- exceptional-value policy;
- derivative variable when primes or subscripts denote derivatives;
- canonical entity ID; and
- evidence and transcription status appropriate to the gate.

Blank values are accepted only when the field is semantically inapplicable and
the schema records that explicitly.  `unresolved` or preview-only notation
blocks source reconciliation.

### 6.4 Entity identification

A named-source application must resolve every named object to:

- one canonical source entity and all aliases used by the occurrence;
- one actual public Lean declaration;
- a conventional, domain-correct specification;
- a proved identification or characterization theorem;
- convergence/integrability, regularity, and uniqueness obligations required by
  that specification;
- branch, parameter-order, normalization, real-agreement, singularity, and
  totalization policies; and
- at least one independently recognizable audit identity where the card
  requires it.

The linter can check that these fields and declaration references exist.  It
cannot decide that the formula identifies the classical function; that remains
a source-fidelity review.

### 6.5 Manifest closure and coverage

When `scope_closed: true`, membership is finite and exact:

- declared occurrence and card totals equal distinct joined rows;
- every member has a frozen complete card and exact dependencies;
- there are no wildcard, directory, chapter-wide, or “related results” members;
- the manifest status transition is allowed;
- every direct source occurrence has the required exact-source or named target
  and, where specified, an `audit_source_recovery` target;
- infrastructure and entity-identification cards receive no theorem-occurrence
  credit; and
- no generic conditional theorem is counted as a named application.

Planning-only rows may be incomplete, but their incompleteness is reported as
inventory debt and never as execution readiness.

## 7. Theorem-card semantic-shape lint

At `freeze`, each target must have exact public signatures and explicit
mathematical fields.  Checks depend on classification.

All targets require quantifier order, module/namespace, binder order, imports,
dependencies, scope exclusions, target/coverage/novelty classifications, and a
real downstream consumer or a justified independent role.

A finite quantitative target additionally requires:

- the actual fixed target function and finite approximant;
- exact order convention, including `N = 0`;
- complete domain and threshold formulas;
- the bound formula and provenance of every controlling quantity;
- a majorant-nonnegativity obligation;
- domain nonemptiness or reachability for concrete applications;
- derivative variable/order/scaling;
- branches and exceptional values; and
- exact constant, threshold, domain, and adversarial regressions.

An ODE remainder target must separately identify residual identity, residual
bound, actual solution, normalization, existence, uniqueness, and stability
dependencies.  Presence of only the first two cannot satisfy a solution-error
card.

A Cauchy derivative target requires positive radius, explicit disk geometry,
boundary or disk norm control, boundary-to-center comparison, and the resulting
threshold loss.  Real-axis control plus “entire” is rejected as an incomplete
contract.

A named application cannot mark identification, reachability, or majorant
nonnegativity `not_applicable`.

These are completeness checks.  Mathematical truth and sharpness still require
the natural-language proof and independent review.

## 8. Proof-artifact and review lifecycle lint

The proof schema is specified in `proof_artifact_schema.md`.  The linter checks:

- card, work-packet, proof, and review-envelope artifact IDs and revisions agree;
- the digest is computed over exact stored bytes and appears only in the
  artifact that externally binds the proof;
- every target requiring a proof has a target-to-proof-section mapping;
- every claimed dependency is accepted at the pinned revision;
- proof status, review status, implementation status, and manifest status are
  kept on separate axes;
- approval counts distinct durable reviewer IDs, never runs or aliases;
- proposer IDs do not count toward a quorum;
- reviewer composition and optional model-diversity requirements match one
  allowed composition exactly;
- a substantive proof/card/source/dependency change invalidates prior gates;
- implementation verdicts bind the exact candidate head and rubric revision;
- filled review artifacts are external to the candidate head; and
- every finding has a terminal disposition before release.

The linter does not certify that two reviewers were mentally independent.  It
checks recorded identity, session, runtime, isolation, and structural quorum;
the attestation remains evidence subject to adjudication.

## 9. Lean candidate checks

Candidate-level linting is activated only after an external `lean_ready: pass`.
Against the pinned environment it checks:

- each target declaration exists exactly once at the promised qualified name;
- its elaborated type matches the frozen signature modulo a documented,
  reviewed comparison policy—not by pretty-printed string coincidence alone;
- no extra public declaration silently expands packet scope;
- imports respect the permitted dependency layers and narrow-import contract;
- semantic foundations do not import tactic or audit umbrellas;
- no `sorry`, `admit`, undeclared `axiom`, unsafe trust extension, or theorem
  body replaced by an assumption occurs;
- public declaration axiom reports stay within the packet allowlist;
- named-object references point to accepted identification declarations; and
- every required regression declaration exists and is reachable from a CI
  target.

Exact axiom and import procedures are specified in `testing_and_ci.md`.

## 10. Tactic-contract lint

For a future `bound_calc`, `cauchy_bound`, or `residual_nf` packet, the linter
also validates the readiness evidence in `tactics.md`:

- the minimum number and diversity of accepted manual consumers;
- accepted commits for every registered rule;
- no semantic module imports the tactic as a foundational dependency;
- stable side-condition and failure-class declarations;
- positive and expected-failure fixtures;
- bounded deterministic search configuration; and
- no numerical or external-solver dependency.

The tactic registry must be a subset of the declarations authorized by its work
packet.  A new rule requires a registry revision and invalidates affected tactic
review evidence.

## 11. What linting cannot decide

The following always remain review questions:

- whether a source transcription is mathematically faithful;
- whether an ODE plus stated normalization uniquely identifies the intended
  function;
- whether a constant is useful or sharp enough;
- whether a hypothesis is natural rather than laundered;
- whether a branch convention is the one intended by the source;
- whether a proof's estimates are correct; and
- whether a new abstraction has sufficient mathematical value.

The linter should say `requires_review`, not manufacture certainty.

## 12. Rollout plan

Implementation, if later authorized, proceeds in bounded packets:

1. schema parsing and controlled vocabulary;
2. local references and digest verification;
3. source-inventory joins and manifest closure;
4. theorem-card/proof/review lifecycle checks;
5. Lean declaration, axiom, and import inspection; and
6. tactic-registry and regression checks.

Each phase requires fixtures containing both accepted and rejected artifacts.
The validators initially run in report-only mode on planning queues, but
`freeze` violations are errors from the first enforced release.  There is no
auto-repair mode: changing a mathematical contract is specification work.

## 13. Permanent numerical exclusion

No validator executes special functions, samples domains, estimates a supremum
numerically, runs interval arithmetic, chooses a truncation order for a
tolerance, or accepts a floating-point comparison as proof of a constant.
Exact digest computation and exact rational theorem regressions are bookkeeping
and mathematics respectively; they are not numerical automation.
