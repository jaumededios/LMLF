# Independent Stage 1 scope review — referee N

## Verdict

**approve**

I found no P0, P1, P2, or actionable P3 defect in the exact seven-file Stage 1
successor at commit
`aebe7968bd6d5dcd23ac949d5d5e0d8854334ca1`. The proposal is a coherent
future semantic contract for the user-authorized programme: Chapters 1--3 are
selective support; Chapters 4--10 exhaustively cover atomic mathematical
website assertions, including prose and attached annotations; genuine
asymptotic/approximation atoms require finite quantitative producers and exact
source recovery; reusable ordinary exact and structural mathematics remains in
the semantic library; numerical-algorithm implementation is excluded.

This is one blueprint verdict only. It neither activates DD-021 revision 6 nor
supplies the second independent approval or root adjudication required by the
proposal.

## Exact review binding

- candidate commit:
  `aebe7968bd6d5dcd23ac949d5d5e0d8854334ca1`
- review snapshot: clean detached checkout at
  `/tmp/stage1-scope-referee-n.qKeZMbNa/checkout`
- `README.md`:
  `96de77b4745c40eb100a576a376b1a939ef9a89b4a3edf32ca840d25cec704ab`
- `blueprint/README.md`:
  `318953bf35984662ed74c36d3b71aff34cb43471ea93a2e63df1bd4417b35b83`
- `blueprint/roadmap.md`:
  `e7b060f55660000e00af64eee6df33b2ddfcf37aec9e5a403cd149f95b95cb85`
- `blueprint/design_decisions.md`:
  `a74eadcd08bf2e4823f51e2aaf7d2e9994f81d3c647d293334411a99fffb537c`
- `blueprint/source_manifest.md`:
  `a85e02c3cc4ac259bab4cb5474d9449884973240370e0af446b0725b56d887f2`
- `blueprint/dependency_graph.md`:
  `7eb4c218af5e1b00a59facd8793b703928325077d06ce8c4e33358fd8e25bd9b`
- `blueprint/stage_1_dlmf-R7.md`:
  `4964a4ad79b8e8da0cdd376836383b189c32b38eaeecd9979dfdcca8cb54b4c2`

All seven digests matched the supplied review contract both before and after
the review. The checkout remained detached and clean. Local-link validation of
the seven files found no missing repository target.

## Reviewer identity, runtime, and isolation

- durable reviewer identity: `/root/stage1_scope_referee_n`
- reviewer kind: `agent`
- model: `GPT-5`, the model family exposed by the system instructions; no
  serving/build identifier was exposed, so none is asserted
- runtime: Codex desktop agent in the provided Linux container
- isolation strength: `manual_attestation`
- isolation method: a new local `git clone --no-hardlinks` from the supplied
  candidate checkout, followed by detached checkout of the exact candidate
  commit; fresh task context; no delegation or subagents

I did not read predecessor R1--R6 plan contents, peer/predecessor Stage 1
reports or dispositions, uncommitted work, implementation worktrees, migration
schema drafts, or Verso work. I did read the two explicitly permitted IMP
operational records listed below. The filesystem, network, credentials, and
plugins were not technically isolated, so this review does not claim a
hardened clean-room environment.

## Material reviewed

I read completely:

- `referee-lean-library/SKILL.md`, its mandatory `global-rubric.md`, and
  `research-basis.md`;
- `review/PROTOCOL.md`;
- all five current rubrics: API/dependency, Mathlib reuse, proof quality,
  quantitative correctness, and source fidelity;
- `review/classifications-v3.json`;
- `blueprint/theorem_cards/README.md`; and
- every byte of the seven bound candidate files above.

I additionally read only the directly needed legacy clauses in
`blueprint/qualitative/release_strategy.md` (product split, complete staged
ladder, and alternate-edition/source-target wording) and
`blueprint/qualitative/navigation_and_docs.md` (initial documentation slice and
Watson-first wording). This was sufficient to test R7's explicit overlay and
track-local reinterpretation without consulting predecessor Stage 1 plans.

The two permitted operational records were:

- `imp-core-b8d2f73-main-integration-checkpoint.md`, verified SHA-256
  `7ca0faec39ded02e621b0db2dd697c97e0dec7a030641e213a474958a98ea040`;
- `IMP-001-review-envelope-implementation-pass.yaml`, verified SHA-256
  `bef995a73d1695238ddcfea92a5ac54926f4a7185317f824ab62e179a21e64e3`.

They support the limited operational fact that source-free IMP-001 was
accepted on main at exact head
`b8d2f731fcfd5cd0889d0732f13699eb94681c86`. I did not treat either record as
Stage 1 R7 quorum. The candidate correctly requires applicability of that
external acceptance to be checked at a dependent head and ultimately requires
all products to coexist at one newly reviewed exact integration head.

## Primary-source verification

I retrieved only official NIST/DLMF pages, without bulk mirroring. The following
claims used by the blueprint were confirmed:

- the [DLMF root](https://dlmf.nist.gov/) displays version 1.2.7;
- [DLMF news](https://dlmf.nist.gov/about/news/) identifies version 1.2.7 and
  the 2026-06-15 release date;
- the official chapter landing pages have the stated titles and enumerate the
  claimed terminal sections: [Chapter 4](https://dlmf.nist.gov/4) through
  4.48, [Chapter 5](https://dlmf.nist.gov/5) through 5.24,
  [Chapter 6](https://dlmf.nist.gov/6) through 6.21,
  [Chapter 7](https://dlmf.nist.gov/7) through 7.25,
  [Chapter 8](https://dlmf.nist.gov/8) through 8.28,
  [Chapter 9](https://dlmf.nist.gov/9) through 9.20, and
  [Chapter 10](https://dlmf.nist.gov/10) through 10.77;
- [DLMF 4.13](https://dlmf.nist.gov/4.13) exposes Lambert `W`, legacy `Wp` and
  `Wm`, Tree `T`, and Wright omega, supporting the omission-sensitive sentinel;
- the other checked hidden-family claims are present on the official pages:
  [5.18](https://dlmf.nist.gov/5.18),
  [7.19](https://dlmf.nist.gov/7.19),
  [8.22](https://dlmf.nist.gov/8.22),
  [9.12](https://dlmf.nist.gov/9.12),
  [9.14](https://dlmf.nist.gov/9.14),
  [10.21](https://dlmf.nist.gov/10.21),
  [10.43](https://dlmf.nist.gov/10.43),
  [10.46](https://dlmf.nist.gov/10.46),
  [10.47](https://dlmf.nist.gov/10.47), and
  [10.61](https://dlmf.nist.gov/10.61).

In particular, 10.46 contains the generalized Bessel and Mittag--Leffler
definitions, an underspecified Laplace-transform sentence, and a distinct
external-reference lead for incomplete modified Bessel/Hankel functions. R7's
formula/prose/reference-lead distinction is therefore grounded in the actual
page rather than invented from a table of contents.

These checks validate the discovery claims only. They are not a page census,
source partition, retained exact-payload archive, source approval, or coverage
claim; R7 states the same limitation.

## Referee findings by architectural concern

### Scope exhaustion and hidden source claims — clear

The chapter table is expressly a nonexhaustive discovery map, while normative
scope is every mathematical atom in Chapters 4--10. Closure requires canonical
retrieval-document and leaf exhaustion, forward and reverse passes, special
notation, `Defines`/symbol annotations, current editorial notes, tables,
captions, applications, computation and software prose, the official index,
and the notation list. Consequently, omission of a named lead cannot shrink the
programme denominator. Chapters 1--3 and later/external material can enter only
as finite, consumer-justified support and earn no extra Chapter 4--10 credit.

The contract also cleanly excludes numerical implementations while retaining
the exact identities, stability facts, convergence statements, and error bounds
that occur in computational prose. This matches the requested exact-mathematics
boundary.

### Canonical identity, aliasing, ownership, and atomization — clear

Canonical retrieval documents, source-owning leaves, semantic appearances,
shared context, and atomic claims are distinct. Locator, fragment, equation,
subsection, redirect, query, and representation aliases cannot mint duplicate
occurrences. Genuine repeated semantic locations remain distinct even with
identical formula bytes. The immutable ownership key
`(snapshot_id, source_appearance_id, atom_ordinal)` and exclusive leaf-payload
ownership together rule out both alias multiplication and parent/child double
counting, while permitting atoms to share exact-bound hypotheses and spans.

The fixture and mandatory negative cases exercise the important counterexamples:
`/10.61`, `/10.61.i`, and `/10.61.E1` cannot become three appearances for one
displayed formula; equal formulas at genuinely distinct locations cannot be
coalesced; and shared context cannot become an extra theorem occurrence without
its own reviewed assertion.

### Typed repair and deduplication — clear

R7 separates within-snapshot source-identity repair, same-appearance atom
split/merge resolution, cross-snapshot evolution, notation identity, entity
identity, and occurrence-association repair. Successors receive fresh IDs and
explicit lineage; predecessor identities remain immutable. Source-identity
repair may correct erroneous multiplicity but cannot erase a real repeated
location. Atom repair cannot cross appearance boundaries. Notation aliases are
separated from value-changing normalization bridges. This is sufficient to
avoid ID rebinding, semantic loss, and historical denominator mutation.

Overlapping batches deduplicate by snapshot-wide canonical atom identity and
may be unioned only under compatible pinned decision views. Many-to-many
card/occurrence associations do not inflate source counts.

### Diagnostic audit versus strict mathematical completion — clear

`AuditClosedWithIssues` is a separate diagnostic predicate with exact finite
accounting, two independent source reviews per selected issue, root selection,
and zero pending investigations. An underdetermined item stays provisional,
keeps `PartitionReady` false, and leaves `Target` undefined. A well-posed
contradicted assertion remains a real denominator atom but earns zero
theorem/coverage credit. Neither route makes strict Stage 1 true. Freshly
derived counterexamples require proof/architecture review, while exact Lean
signature and `lean_ready` gates apply only if code is attempted. This closes
diagnostic work without manufacturing a proposition, deleting a false source
statement, or weakening strict truth.

### Total classification and quantitative-first obligations — clear

The planned successor classification is total and single-valued at each
effective atom: `finite_quantitative_plus_source_recovery` or
`ordinary_exact_or_structural`. Genuine asymptotic or approximation meaning
forces the former and cannot be waived by a reason row or scheduling choice.
It requires exactly one finite semantic producer and exactly one faithful
source-recovery mapping with accepted exact-byte evidence. An explicit finite
source statement is recovered by an exact notation/domain bridge rather than a
fabricated qualitative theorem. Ordinary structural results get exactly one
direct/named source-target mapping, and an occurrence-specific reviewed reason
why the quantitative pair is inapplicable.

The module rule is correctly asymmetric: reusable exact, analytic,
continuity, monotonicity, sign, uniqueness, zero, and other structural results
live in semantic modules; source-specific restatements and faithful recovery
consume those declarations under `Audit/SourceRecovery`; semantic code never
imports the audit layer. This preserves quantitative-first treatment of actual
approximation atoms without forcing ordinary exact mathematics into fake error
bounds.

### Support closure, API seams, and anti-laundering — clear

Each execution manifest has a finite least transitive reviewed closure rooted
in selected target cards/entities and follows mathematical, definitional,
identity, proof, recovery, and project-import edges. Every source-dependent
support node remains exact-bound and receives the same semantic classification;
out-of-range support earns no Chapter 4--10 credit. Pinned Mathlib reuse ends at
a reviewed exact revision/interface instead of recursively recataloguing
Mathlib. Cycles cannot justify their own membership, while a legitimate mutual
cluster must be explicit and externally justified.

Entity construction, conventional specification, identification, branches,
exceptions, totalization, reachability/nonemptiness, majorant nonnegativity,
fixed-across-order semantics, and hypothesis/choice laundering remain explicit
gates. The proposal does not introduce a speculative universal special-function
typeclass or conflate helpers, entity identification, source targets, and
coverage credit.

### Proof-before-signature order — clear

R7 explicitly permits pre-proof source-facing mathematical target statements
but prohibits freezing exact Lean signatures for new mathematics until a
complete natural-language proof and the required fresh proof, quantitative,
source, and architecture/structural reviews have succeeded. Final exact packets
still require external `lean_ready: pass` before implementation. The fact that
future concrete schemas, censuses, cards, proofs, or validators do not yet exist
is accurately reported as future work, not falsely claimed completion.

### External authority and coherent integration — clear

Local/global closure selection, issue selection, replacement, suspension, and
withdrawal are external, exact-bound authority decisions, never candidate-owned
status. The selected authority is an explicit fold that must include accepted
adverse, supersession, suspension, and withdrawal records; accepted material
counterevidence conservatively suspends affected authority and dependents in
the same record, with no silent fallback. Historical views remain replayable
without remaining current.

Strict completion additionally requires one external root record binding one
exact integration head, one toolchain/Mathlib state, the selected global
closure, every execution manifest and decision view, and passing build, import,
axiom, regression, occurrence, and recovery joins. Historical approvals from
incompatible heads cannot be aggregated. This supplies the requested
single-head integration rule while preserving exact-head invalidation.

## Commands and results

- `git clone --no-hardlinks ...` and detached checkout of the candidate:
  succeeded.
- `git status --short --branch`, `git rev-parse HEAD`, and branch check:
  detached, clean, exact requested head.
- `sha256sum` over all seven files: all supplied digests matched twice.
- `git diff --name-status` and bounded seven-file diff inspection: the intended
  seven successor files were identified; predecessor plan contents were not
  opened.
- `referee-lean-library/scripts/library_inventory.sh`: completed; 7 Lean files,
  210 lines, 3 definitions, 18 theorems; import direction showed semantic
  foundations/results with the audit module only consuming semantic modules;
  no trust/resource marker was reported.
- `python3 scripts/validate_inventory.py --negative-tests`: passed; 25 invalid
  fixtures rejected and the existing inventory validated at 148 occurrences,
  31 notations, 32 entities, 34 entity-evidence rows, and 88 occurrence
  associations.
- local Markdown target check across the seven bound files: no missing local
  target.
- targeted official-page retrieval with `curl -LfsS` and text extraction:
  confirmed the version/date, chapter ranges/titles, and sentinels recorded
  above.
- `lake build`: not run, because this is a docs-only future-contract review and
  the task expressly did not require a production build.

## Findings and bounded fixes

No actionable findings. No candidate fix is required for this verdict.

## Limitations and non-claims

- This review evaluates the future semantic programme contract, not an
  unimplemented schema, source census, theorem-card population, proof corpus,
  DLMF source archive, validator, Verso projection, or Lean implementation.
- The official-page checks were targeted primary-source verification, not the
  exhaustive source audit R7 itself requires.
- The accepted IMP operational evidence is an upstream dependency fact only;
  it grants no DLMF source claim and is not R7 review quorum.
- Activation still requires another fresh independent approval and a root
  external adjudication bound to this exact commit and all seven exact digests.

