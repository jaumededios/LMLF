# Source manifests and inventories

**Normative owner:** `jaumededios`  
**Document specification status:** `specified`  
**Baseline specification commit:** `pending_external_record_after_commit`

The baseline commit is placed in an external immutable review or release record
after this specification commit exists.  Embedding the hash in the commit it
identifies would be self-referential.

## Edition lock

- **Author:** F. W. J. Olver
- **Title:** *Asymptotics and Special Functions*
- **Edition:** corrected A K Peters reprint, 1997
- **ISBN:** 1-56881-069-5
- **Authoritative checks:** [DLMF bibliography](https://dlmf.nist.gov/bib/O),
  [NIST reprint notice](https://math.nist.gov/opsf/books/olver.html)

No page, equation, or exercise locator is accepted until checked against this
printing.  DLMF links corroborate, but do not replace, direct collation.

## Manifest state

Manifest scope and packet progress are different facts.

| Field | Values | Meaning |
|---|---|---|
| `scope_closed` | `true`, `false` | whether membership is finite, fully carded, and frozen |
| `manifest_status` | `planning_only`, `execution_ready`, `active`, `complete`, `superseded` | whether the manifest can be executed through its gates |
| card `specification_status` | `draft`, `specified`, `frozen`, `superseded` | statement/signature readiness |
| card `proof_status` | `not_required`, `draft`, `complete`, `under_review`, `approved`, `blocked` | natural-language proof state |
| card `review_status` | `not_started`, `under_review`, `approved`, `changes_requested`, `blocked` | independent review state |
| card `implementation_status` | `not_started`, `authorized`, `in_progress`, `compiled`, `audited`, `released` | Lean work state |
| card `prototype_status` | `absent`, `present_uncompiled`, `compiled_unreviewed` | observed code outside the authorized lifecycle |
| card `coverage_status` | `not_applicable`, `selected`, `transcribed`, `proved`, `reconciled` | source-occurrence coverage state |

`execution_ready` means every member is bounded and fully specified; it does not
bypass proof/review gates or authorize Lean.

## Classification fields

Every card records both:

- `theorem_class`: its mathematical shape;
- `coverage_class`: one of `infrastructure`, `entity_identification`,
  `exact_source_generic`, `named_source_application`, or
  `audit_source_recovery`.

Watson's lemma is `exact_source_generic`: it is a source theorem quantified over
generic amplitudes and parameters, not an application to a named special
function.

## Closed-manifest rule

A manifest is closed only when every member has a card with exact boundaries,
imports, declaration signatures, dependencies, and owner.  No wildcard,
open-ended chapter, or “related results” entry is permitted.  Additions require
a reviewed manifest revision.

For source coverage, each occurrence row records:

```text
occurrence_id, edition, page, chapter/section, printed label, kind,
transcription hash, notation IDs, source-entity IDs, theorem-card IDs,
theorem class, coverage class, novelty class, coverage status,
reconciliation result
```

Repeated appearances remain separate occurrences.

## Inventory separation

- **Occurrence inventory:** printed definitions, theorems, formulas, exercises,
  tables, normalization checks, and cross-references.  Reconciled occurrences
  are the coverage denominator.
- **Notation inventory:** printed glyph, local meaning, binder/argument order,
  ambient type, spatial/parameter role, branch, orientation, scaling,
  exception policy, and canonical source entity.
- **Source entity inventory:** canonical source object and aliases, conventional
  specification, validity, implementation/identification, real agreement,
  singularity/totalization policy, and dependent occurrences.
- **Packet-local concepts:** project API devices such as `ErrorOn` or a local
  integrand abbreviation.  They stay in their theorem cards and are not source
  entity rows unless a collated occurrence actually denotes them.

## DEMO-0 — bounded planning queue

- `owner`: `jaumededios`
- `scope_closed`: `false`
- `manifest_status`: `planning_only`
- `Olver coverage`: none

DEMO-0 lists candidate M0-M4 work, but it is neither closed nor execution-ready
until every selected candidate has a fully specified card.  Listing a row does
not authorize review or Lean.

| Candidate | Coverage class | Planning target |
|---|---|---|
| QB-001 | infrastructure | finite error predicates and basic transport |
| QA-002 | infrastructure | later algebra, inversion, and nonlinear composition |
| DEF-001 | entity_identification | current mathlib Gamma reuse slice |
| DEF-002 | entity_identification | possible Airy construction and identification |
| QC-001 | infrastructure | explicit disk geometry and Cauchy transport |
| QL-001 | infrastructure | finite integral/Laplace core |
| EX-001 | infrastructure | geometric constant regression |
| EX-002 | infrastructure | divergent factorial finite-bound example |

Only QB-001 and DEF-001 currently have full cards.  They are executed under the
separate BOOTSTRAP-0 manifest; the remaining rows stay candidates.

## BOOTSTRAP-0 — initial execution-ready manifest

- `owner`: `jaumededios`
- `scope_closed`: `true`
- `manifest_status`: `execution_ready`
- `member_count`: 2
- `Olver coverage`: none
- `baseline_spec_commit`: `pending_external_record_after_commit`
- `work_packets`: `review/work_packets/QB-001.yaml`,
  `review/work_packets/DEF-001.yaml`

| Card | Theorem class | Coverage class | Specification | Proof | Review | Implementation |
|---|---|---|---|---|---|---|
| QB-001 | foundational_calculus | infrastructure | specified | approved | approved | authorized |
| DEF-001 | definition_identification | entity_identification | specified | not_required | not_started | compiled |

Scope is exactly the eight signatures in
[`QB-001-signatures.md`](theorem_cards/QB-001-signatures.md) and the four Gamma
wrappers in [`DEF-001.yaml`](theorem_cards/DEF-001.yaml).  Execution begins with
the mandated reviews.  QB-001 is authorized for only its eight signatures;
DEF-001 remains unauthorized while its implementation reviews are pending.
Its implementation status records the observed build as `compiled`, while the
separate
`prototype_status` is `compiled_unreviewed`; this grants no approval or release
credit.

## OLV-MVP-1 — first source theorem planning manifest

- `owner`: `jaumededios`
- `scope_closed`: `false` because cards are incomplete
- `occurrence_selection_locked`: `true`
- `manifest_status`: `planning_only`
- `occurrence_count`: 1

| Occurrence | Locked locator | Coverage class | Cross-check |
|---|---|---|---|
| OLV97-C03-WATSON | Chapter 3, pp. 71-72, Watson's lemma | exact_source_generic | [DLMF §2.3(ii)](https://dlmf.nist.gov/2.3.ii) cites these pages |

Before execution readiness, direct collation must add the exact printed label,
mathematical transcription, copy identifier, and transcription hash.  Every
bound variable, endpoint, exponent, and coefficient sequence must resolve in
the notation and source-entity inventories.

Planned cards are finite but not yet specified:

| Card | Theorem class | Coverage class | Obligation |
|---|---|---|---|
| QL-001 | finite_remainder_bound | infrastructure | reusable finite Laplace identity and bound |
| OLV-001 | finite_remainder_bound | exact_source_generic | match the collated Watson hypotheses and prove the explicit quantitative strengthening |
| SR-001 | qualitative_bridge | audit_source_recovery | recover the exact printed qualitative conclusion in `Audit/SourceRecovery` |

Watson earns occurrence coverage only when OLV-001 and SR-001 are proved and
reconciled.  It requires no named-function application.

Its critical path is:

```text
edition lock + direct occurrence collation
  -> QB-001 finite core
  -> QL-001 finite integral/Laplace core
  -> DEF-001 only if Gamma moments are used
  -> OLV-001 -> SR-001
```

Airy, Cauchy transport, coefficient residual automation, ODE stability, and
comparison systems are explicitly off this path.

## Future manifests

Future releases select finite occurrence batches after an occurrence audit and
close only after every member has a complete card.  Real integrals, contours,
regular and irregular singularities, summation, parameter-dependent ODEs,
turning points, poles, and connections are planning tracks, not present coverage
claims.
