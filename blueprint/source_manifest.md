# Source manifests and inventories

> **Proposed successor-authority notice (pending).** The user-authorized broad
> DLMF-through-Chapter-10 boundary is specified by proposed
> [`blueprint/stage_1_dlmf-R4.md`](stage_1_dlmf-R4.md), DD-021 revision 3.
> Its exact six-file successor, enumerated there by repo-relative path, takes
> effect only after two fresh independent blueprint approvals and a root
> external adjudication bind the exact successor commit and digests. Until then,
> the frozen text below remains operative. Once effective, DD-021 changes only
> the enumerated programme-priority/scheduling clauses; frozen Olver evidence
> and semantics remain unchanged, and `OLV-MVP-1` remains an eligible parallel
> Olver-track packet, not a DLMF prerequisite or target.

**Normative owner:** `jaumededios`  
**Document specification status:** `frozen`  
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

The exact private PDF was previously inspected and hash-bound, but its original
uploaded bytes are absent from the restarted environment. Existing
transcriptions and historical collation metadata survive; new source-image
audits require reattachment or recovery. Source-independent IMP/QL drafting is
not blocked by that runtime absence.

## Manifest state

Manifest scope and packet progress are different facts.

| Field | Values | Meaning |
|---|---|---|
| `scope_closed` | `true`, `false` | whether membership is finite, fully carded, and frozen |
| `manifest_status` | `planning_only`, `execution_ready`, `active`, `complete`, `superseded` | whether the manifest can be executed through its gates |
| card `specification_status` | `draft`, `specified`, `frozen`, `superseded` | statement/signature readiness |
| card `proof_status` | `not_required`, `draft`, `complete`, `blocked` | intrinsic natural-language proof state |
| card `review_status` | `not_started`, `under_review`, `approved`, `changes_requested`, `blocked` | independent review state |
| card `implementation_status` | `not_started`, `authorized`, `in_progress`, `compiled`, `audited`, `released` | Lean work state |
| card `prototype_status` | `absent`, `present_uncompiled`, `compiled_unreviewed` | observed code outside the authorized lifecycle |
| card `coverage_status` | `not_applicable`, `selected`, `transcribed`, `proved`, `reconciled` | source-occurrence coverage state |

`execution_ready` means every member is bounded and fully specified; it does not
bypass proof/review gates or authorize Lean.

Card review and implementation fields are temporal, nonauthoritative summaries.
Only an external review envelope bound to the specification commit, packet,
artifacts, and their digests can establish gate pass or Lean authorization.
Repository review ledgers are historical context and count as zero reviewers.
The private
[`review-evidence` commit `5c8ec1b`](https://github.com/jaumededios/LMLF/commit/5c8ec1b301f656df35ffa8850e002639807995cd)
preserves historical records; an approval binds only its recorded commit and
does not establish current status for later bytes.

## Classification fields

Every newly revised card records theorem, coverage, and novelty axes under
artifact revision 3 of the
[`lmlf-classification-v3`](../review/classifications-v3.json) vocabulary, which
supersedes rather than mutates frozen v2. Historical frozen cards retain their
recorded authority. The current vocabulary
schema distinguishes packet summaries from exact declaration-level target
values and marks registry examples `required` or `illustrative` in a
machine-readable field.  In particular, a routine target uses `non_novel`; it
cannot use `source_equivalent` merely because it matches an internal proof.

Packet-level coverage values include:

- `theorem_class`: its mathematical shape;
- `coverage_class`: one of `infrastructure`, `entity_identification`,
  `exact_source_generic`, `named_source_application`, or
  `audit_source_recovery`.

Watson's lemma is `exact_source_generic`: it is a source theorem quantified over
generic amplitudes and parameters, not an application to a named special
function.

The v3 registry corrects `QL-001` to `non_novel`, matching its classical
bounded-primitive mathematics. Frozen v2 remains byte-for-byte historical; the
versioned correction itself supplies no mathematical approval, review quorum,
or implementation authorization.

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

| Candidate | Packet coverage class | Planning target |
|---|---|---|
| QB-001 | infrastructure | finite error predicates and basic transport |
| QA-002 | infrastructure | later algebra, inversion, and nonlinear composition |
| DEF-001 | entity_identification | current mathlib Gamma reuse slice |
| DEF-002 | entity_identification | possible Airy construction and identification |
| QC-001 | infrastructure | explicit disk geometry and Cauchy transport |
| QL-001 | infrastructure | finite integral/Laplace core |
| EX-001 | infrastructure | geometric constant regression |
| EX-002 | infrastructure | divergent factorial finite-bound example |

QB-001 and DEF-001 are the only frozen, externally accepted cards in this
queue. QL-001 and OLV-001 have registered planning drafts; OLV-002 and
DEF-BERN-001 have unregistered planning drafts; SR-001 remains planned. Only
QB-001 and DEF-001 belong to the separate BOOTSTRAP-0 manifest.

## BOOTSTRAP-0 — initial execution-ready manifest

- `owner`: `jaumededios`
- `scope_closed`: `true`
- `manifest_status`: `execution_ready`
- `member_count`: 2
- `Olver coverage`: none
- `baseline_spec_commit`: `1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9`
- `work_packets`: `review/work_packets/QB-001.yaml`,
  `review/work_packets/DEF-001.yaml`

| Card | Packet theorem class | Packet coverage class | Frozen specification self-status | External gate | Accepted implementation |
|---|---|---|---|---|---|
| QB-001 | foundational_calculus | infrastructure | frozen; proof complete | pass | `515b742f7ad5472c17cfdf0fda7cbc83c5585da1` |
| DEF-001 | definition_identification | entity_identification | frozen; proof not required | pass | `515b742f7ad5472c17cfdf0fda7cbc83c5585da1` |

Scope is exactly the eight signatures in
[`QB-001-signatures.md`](theorem_cards/QB-001-signatures.md) and the four Gamma
wrappers in [`DEF-001.yaml`](theorem_cards/DEF-001.yaml).  Both specifications
were subsequently bound by external pre-Lean records, implemented, and accepted
after independent implementation review at the exact commit shown above.
QB-001's in-repository revision-3 review ledger remains historical and
non-quorum; it is not the authority for that result.  DEF-001's transparent
non-novel pinned-library wrappers used the frozen `not_applicable` proof-review
reason, mirrored externally as `not_required`.  The immutable card fields still
record the earlier specification-snapshot state by design and are not rewritten
with later external verdicts.

## IMPROPER-0 — source-free improper-integration specification

- `owner`: `jaumededios`
- `scope_closed`: `true`
- `occurrence_selection_locked`: `not_applicable`
- `manifest_status`: `execution_ready`
- `member_count`: 1
- `public_target_count`: 8
- `Olver coverage`: none
- `work_packets`: `review/work_packets/IMP-001.yaml`

The sole member is frozen `IMP-001` card revision 7. Work-packet revision 1
binds the new metadata-only proof successor
[`NLP-IMP-001-R7`](proofs/IMP-001-R7.md) and the accepted
[exact-signature proposal revision 2](theorem_cards/IMP-001-signatures-R6.md),
SHA-256 `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d`.
The R7 successor preserves the R6 mathematical proof and equations while
changing only lifecycle/binding/status metadata. Canonical
[`IMP-001.md` R6](proofs/IMP-001.md) remains byte-for-byte historical
mathematical input and the dependency recorded by QL/OLV R4; it does not become
frozen or inherit approvals.
Fresh exact-byte referees C and D approved only that proposal at
`9e6e038871ac66f80534626d3deade0b27af6752`; the root negative-guard finding
was resolved only for those bytes. The reports and disposition are archived at
private
[`review-evidence` commit `d0d4fb4`](https://github.com/jaumededios/LMLF/commit/d0d4fb4895733b5de8396794e81cbe1a19657bdb).
This evidence satisfies a prerequisite stage, not final-packet quorum.
`execution_ready` means only that this source-free specification is closed
and bounded. Fresh final pre-Lean reviews and an external envelope remain
pending; there is no `lean_ready`, implementation authorization, production
Lean, source occurrence, or source-coverage claim. The compiled-unreviewed
prototype uses temporary axiomatic theorem stubs only.

## OLV-MVP-1 — first source theorem planning manifest

- `owner`: `jaumededios`
- `scope_closed`: `false` because cards are incomplete
- `occurrence_selection_locked`: `true`
- `manifest_status`: `planning_only`
- `occurrence_count`: 1

| Occurrence | Locked locator | Planned packet coverage class | Cross-check |
|---|---|---|---|
| OLV97-C03-WATSON | Chapter 3, pp. 71-72, Watson's lemma | exact_source_generic | [DLMF §2.3(ii)](https://dlmf.nist.gov/2.3.ii) cites these pages |

Direct first collation has added the exact printed label, mathematical
transcription, hash-bound private copy identifier, page map, and provisional
notation/source-entity records.  Before execution readiness, a distinct
reviewer must verify the page audit, transcription, and proposed semantic
reading, then promote every required link from provisional to confirmed.  The
revision-4 proposal is source-facing over complex scalars with a real
corollary.  It reads ordinary source convergence as independent one-sided
convergence at a finite exceptional set and uses a continuous normalized
primitive with a regular-piece increment law.  Lean-facing regular pieces use
Mathlib's Bochner `intervalIntegral` with explicit integrability evidence; only
endpoint passages are improper, and no second proper-Riemann implementation is
planned.  Principal value is separate, and a whole-set Bochner integral is only
a narrower absolute-integrability adapter.

The two OLV-MVP implementation-path cards now exist as non-frozen drafts;
SR-001 remains uncarded:

| Card | Packet theorem class | Packet coverage class | Obligation |
|---|---|---|---|
| QL-001 | finite_remainder_bound | infrastructure | revision-4 draft supplied-constant local-tail theorem and finite Gamma-moment decomposition; exact API namespace correction only |
| OLV-001 | finite_remainder_bound | exact_source_generic | revision-4 draft derivation of visible witnesses and a finite bound from the collated Watson hypotheses; dependency rebinding only |
| SR-001 | qualitative_bridge | audit_source_recovery | recover the exact printed qualitative conclusion in `Audit/SourceRecovery` |

`IMP-001` is now frozen separately in source-free `IMPROPER-0`, upstream of
QL-001. Its eight public targets are justified by consumer completion rather
than a hard schema cap: T01 keeps independent endpoint semantics; T08 equates
it with existence of a normalized continuous primitive tending to the same
value; T07 is the arbitrary-exception absolute Bochner bridge; T03 maps
`E -> H`; and T06 exposes Abel composition while its finite-piece engine stays
private. `Basic` owns T01/T05/T08/T02/T03/T04, `Bochner` T07, and `Abel` T06.
IMP R6 and QL R4 correct only three root namespace entries in the pinned API
ledger, while OLV R4 only rebinds those draft dependencies. The mathematical
targets, proofs, architecture, QL a.e. local premise, finite-dimensional source
adapter, target count, and module split are unchanged.
The historical revision-3 signature artifact is untouched and superseded.
The frozen IMP card/work packet still awaits fresh final pre-Lean reviews and
an external envelope, while QL/OLV R4 remain planning drafts; no `lean_ready`,
implementation authorization, or source coverage follows from
`IMPROPER-0`.
QL-001 uses T06 for the bounded-primitive tail, T07 for the absolutely
integrable model terms, and T04 to prepend the local interval. OLV-001 chooses
one common baseline `X > 0` before `n`, uses T07/T03/T04/T08 to obtain the
baseline remainder primitive, derives its flat bound `L_n`, and only then calls
QL-001; `k_n`, `K_n`, and `L_n` may depend on `n`.

Watson earns occurrence coverage only when OLV-001 and SR-001 are proved and
reconciled.  It requires no named-function application.

The separately inventoried `OLV97-C03-WATSON-BOUNDS` occurrence records
section 9.1-9.2, printed pp. 89-90.  It is not selected into this one-occurrence
manifest.  Its global exponential majorant is a stronger hypothesis and must
not be laundered into the Theorem 3.1 recovery path.  The revision-2 OLV-002
card/proof is an unregistered, unselected planning packet for that direct
implication and remains separate from OLV-001.

The locked Chapter 2 `Ai`, Chapter 11 real Airy/basis and auxiliary, and
Chapter 8 Euler--Maclaurin/Bernoulli transcriptions are likewise inventoried as
`transcribed_unreconciled`. They remain outside every manifest. Airy has no
theorem card; Bernoulli has an unregistered revision-1 planning card/proof but
no inventory occurrence-card association. A draft file is neither registration
nor coverage.

Two additional locked-body revision-2 collations cover Chapter 2 `J`/`I` and
Chapter 12 real Bessel/comparison auxiliaries. Two independent source referees
approved the exact revision-2 files, and all 119 proposed occurrences (58 plus
61) are integrated one-for-one into the normalized inventory. Every row remains
`transcribed_unreconciled` and `unresolved`. The integration creates no notation
or entity link, theorem card, occurrence-card link, manifest membership,
coverage credit, reconciliation, or implementation authorization.

Its mathematical critical path is:

```text
locked 1997 collation ------------------------------------\
                                                           +-> OLV-001 -> SR-001
pinned integration/limit facts -> IMP-001 -> QL-001 ------/
pinned Real Gamma moment -----------------------> QL-001
```

QB-001 and DEF-001 may later join for optional error-predicate packaging or a
project-level Gamma audit wrapper.  The revision-4 QL/OLV proofs do not consume
them, so neither is a critical dependency.

Airy, Cauchy transport, coefficient residual automation, ODE stability, and
comparison systems are explicitly off this path.

Only the CSV inventory validator currently exists.  It consumes all three v3
packet-classification axes and derives required registry rows from
`registry_binding`; v2 is only the frozen predecessor. Routine checks run
locally with `lake build` and
`python3 scripts/validate_inventory.py --negative-tests`. GitHub Actions is
explicit manual-only via `workflow_dispatch`, not push/PR automation.
YAML/Markdown lifecycle, target-level card/packet joins, digest, and external-
review-envelope validation remains manual/planned.

## Future manifests

Future releases select finite occurrence batches after an occurrence audit and
close only after every member has a complete card.  Real integrals, contours,
regular and irregular singularities, summation, parameter-dependent ODEs,
turning points, poles, and connections are planning tracks, not present coverage
claims.
