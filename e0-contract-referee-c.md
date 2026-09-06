# Independent exact-artifact review — Stage 1 Chapter 4 companion contract draft 03

## Controlled verdict

**Verdict:** `approve`

I found no material logical, trust-boundary, scope, dependency, or implementability defect in the
exact draft-03 artifact. The contract is sufficiently determinate for the next bounded E0 proposal:
a standard-library extension of the existing inventory validator, versioned companion descriptors,
an exact protected-input guard, and synthetic positive/adversarial fixtures. Approval is limited to
this natural-language contract. It does not approve the future schemas, classification successor,
fixture data, validator implementation, real source records, cards, signatures, proofs, Lean code,
or any production authority.

## Exact review binding and isolation disclosure

- Candidate: `/workspace/Documents/Codex/2026-09-05/LMLF-review-evidence/stage1-companion-schema-design-draft-03.md`,
  SHA-256 `0ca695804d589d2fec652f265a87d2f9c95a6d0e0095056dae1d39719896bb6f`,
  lines 1–420, read in full.
- Accepted scope: `/tmp/lmlf-stage1-scope.DbhM9YHt/blueprint/stage_1_dlmf-R7.md`,
  SHA-256 `4964a4ad79b8e8da0cdd376836383b189c32b38eaeecd9979dfdcca8cb54b4c2`,
  lines 1–1265, read in full at commit
  `aebe7968bd6d5dcd23ac949d5d5e0d8854334ca1`.
- Scope acceptance: `/tmp/lmlf-review-evidence.3kYJG0or/spec-aebe7968bd6d5dcd23ac949d5d5e0d8854334ca1-stage1/root-stage1-r7-adjudication.md`,
  SHA-256 `2af2a524ca8eadd26540dcd5acec95caddb6d9fb4c1078622522144ef6be7644`,
  read in full.
- Complete protocol: `review/PROTOCOL.md`, SHA-256
  `7453bc0ca6985d7ca2e8c525d9655a94e412c48e3850b92d9367a9f643d3177d`, read in full.
- Frozen legacy classification authority: `review/classifications-v3.json`, SHA-256
  `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`, read in full.
- Validator seam: `scripts/validate_inventory.py`, SHA-256
  `c954ce39762b160e7328846dc3740df242deb381b4d5da7995df70cd74b90a75`; I inspected its
  headers, exact classification loader, standard-library parsing path, relational checks,
  25-case copied-data negative harness, and CLI/result path.
- Linting workflow basis: `blueprint/automation/contract_linting.md`, SHA-256
  `bb998a2f9d3934d7d953c60ec1ad02d1ac71bd4fd7921fc5fc1edf0fcc9cad9a`, read in full.
- Repository snapshot: clean `main` at
  `b8d2f731fcfd5cd0889d0732f13699eb94681c86`, equal to `origin/main` at inspection time.
- Reviewer identity: `/root/e0_contract_referee_c`.

This was a fresh agent task context, but the filesystem was shared, writable, and unrestricted.
Isolation is therefore a manual fresh-context separation, not a technically enforced clean room.
The runtime exposed only the OpenAI GPT-5 model family to this reviewer; no exact serving build was
exposed or independently verified, so this report makes no exact-model-build attestation. After
forming my independent assessment of draft 03, I read only the allowed historical referee A/B
reports on draft 02 to check that their adverse cases were actually closed. I did not read any peer
report judging draft 03.

## Prioritized findings

No actionable `P0`, `P1`, `P2`, or `P3` finding remains. In particular, I do not convert future
implementation choices—exact filenames, headers, field spelling, or fixture layout, expressly left
to the next proposal at lines 43–46—into defects in this bounded logical contract.

## Exact sufficiency findings

### Source ownership, whole-scope closure, and the structural oracle — clear

Candidate lines 76–109 give a single typed ownership chain from canonical document through leaf and
appearance to exactly one claim kind. They require same-snapshot/schema-set owner agreement and
forbid aliases, representations, containers, contexts, notation, and entities from minting claims.
Lines 91–105 make `whole_document` and `whole_leaf` mutually explicit scope discriminators, derive
all leaf/appearance/claim membership, require equality for any stored projection, and deduplicate
overlap. This is enough to make the cherry-pick fixtures at lines 310–318 deterministic without
asking E0 to decide semantic source completeness.

Candidate lines 111–126 supply the formerly missing independent structural witness:
`document_item` keys are total and single-valued over supplied leaf owners, every leaf owns an item,
and document/snapshot/schema-set agreement is mandatory. Retaining an expected item while deleting
its leaf and dependents therefore has the requested unique `missing_leaf_owner` failure. The draft
correctly leaves proof that the supplied item inventory exhausts the actual payload to exact-payload
forward/reverse source review, rather than fabricating source exhaustiveness from a validator pass.

### Production partiality and synthetic-only computation — clear

Candidate lines 155–177 define the structural candidate filter and place complete source and
source-semantics review plus external root selection before production `PartitionReady` and
`Target`. Reference leads, provisional claims, and nonmathematical remainder stay in batch
reconciliation but outside the candidate set. A well-posed contradicted atom remains in the defined
denominator, while an unresolved substantive claim keeps the production target undefined. Lines
179–181 confine any E0-computed target to `FX-` fixtures with a synthetic witness and expressly
forbid global or production authority. This faithfully implements the accepted distinction among
structural enumeration, reviewed local target selection, and later coverage/completion.

### Orthogonal source semantics and role direction — clear

Candidate lines 183–199 define exactly one new atom-level axis,
`source_semantics_class`, with exactly the two accepted tokens and no `mixed` escape hatch. They bind
the unchanged v3 path/version/digest as an immutable predecessor/dependency, preserve all v3
packet/target theorem, coverage, and novelty axes, retain the old v3 loader for legacy cards, and
make cross-axis token placement an error. This removes any plausible interpretation under which the
new two-token axis replaces v3 or mutates old-track meaning.

Candidate lines 201–230 preserve the accepted cardinalities and dependency direction: one ordinary
role with its direct/named subtype, or the distinct semantic-finite and faithful-recovery roles with
recovery downstream in `Audit/SourceRecovery`. The three levels now separate representable pending
endpoints, frozen source-facing card targets plus nonbinding declaration sketches, and independently
reviewed exact-signature packets. Exact-signature selection remains after complete natural-language
proof review and before, not instead of, external `lean_ready`. Helpers, identity bridges, and every
validator result receive no source, proof, coverage, or completion credit.

### Exact legacy preservation — clear and independently checked

Candidate lines 33–41 and Appendix A, lines 374–395, name exactly fourteen CSV inputs plus the v3
JSON authority and give an independent ordinary SHA-256 assertion for each. All fifteen observed
digests match Appendix A. The guard source is explicitly outside the candidate manifest, so editing
both protected bytes and candidate-owned claimed hashes cannot self-authorize. The validator is
intentionally editable while the legacy loader, inputs, meanings, fixtures, and results remain the
protected compatibility surface. Separate namespaces and typed cross-track links avoid a second
validator or a universal migration.

### External binding order and strict bytes — clear

Candidate lines 232–266 define an immutable ordered artifact index with unique typed IDs, positive
positions, exact byte digests, strict backward edges, an externally bound non-self-hashed index, and
a closed source-kind/edge-kind/target-kind grammar. This makes self, same-position, forward,
unknown-ID, digest, wrong-kind, illegal-edge, and cycle tests structural and portable without using
timestamps, filenames, lexical order, filesystem discovery, or JSON object order. It deliberately
does not claim to fold effective authority; complete manual review and root selection remain the
authority.

Candidate lines 268–277 fully specify strict UTF-8 JSON for this slice: duplicate keys at every
depth, invalid UTF-8, comments, trailing commas, and all three non-JSON numeric constants are
rejected, while hashes cover exact stored bytes without semantic canonicalization. These checks are
implementable with Python's standard library using strict byte decoding, an object-pairs hook, and a
rejecting `parse_constant` callback.

### Finite implementation and tests — realizable

Candidate lines 279–343 bound E0 to descriptors, one small synthetic batch, copied adversarial
fixtures, and an extension of the current validator. The enumerated checks are finite relational,
set-equality, digest, strict-parser, cardinality, and typed-order checks. None requires natural-
language inference, a production census, authoritative state folding, global closure, support-DAG
traversal, proof checking, card linting, coverage, completion, CI, Pages, or Verso. Lines 345–372
correctly defer real source rows and successor correction/global machinery to separately reviewed
work. This is compatible with the current standard-library validator's explicit-table and copied-
mutation design.

## Read-only verification evidence

- `python3 scripts/validate_inventory.py`: exit 0; 148 occurrences, 31 notations, 32 entities,
  34 entity-evidence rows, 88 occurrence associations.
- `python3 scripts/validate_inventory.py --negative-tests`: exit 0; all 25 existing intentionally
  invalid copied fixtures rejected.
- The deterministic library inventory found 7 Lean files, 210 lines, 3 definitions, 18 theorems,
  and no trust/resource marker. This is repository context only, not proof or build evidence.

No Lean build was run or claimed: the candidate changes no Lean or schema implementation. No
candidate, repository, source, schema, fixture, classification, theorem card, proof, signature, or
validator file was edited. No commit, push, CI, publication, download, source retrieval, or Verso
action was performed.

## Do-not-expand decisions and authority limitation

- Keep E0 synthetic and structural. Do not require production `PartitionReady`, a global target,
  correction/effective-state folding, full quorum automation, or programme-wide completion.
- Keep Chapters 4–10 as the mathematical programme and Chapters 1–3 as finite explicit support only.
- Keep reusable exact/structural and finite quantitative declarations in semantic layers, with
  source-specific recovery downstream; E0 does not predesign the future Lean APIs.
- Keep local tests public and authorized, with no CI, Pages, Verso, commit, push, or publication work.
- Review the exact future schema descriptors, classification successor, fixtures, implementation,
  real E1 source data, cards, proofs, exact signatures, Lean changes, and one-head integration on
  their own bytes. This approval cannot be transferred to any of them and supplies no quorum by
  itself.

