# Independent library-scale referee report: exact commit `d0aa1c55967d7cde7187f5c8b7a05b76d7043fe5`

## Review identity and binding

- Reviewer ID: `spec_d0_referee_f`
- Reviewer kind: agent
- Model: `GPT-5 (Codex)`; the runtime exposed no more specific model build identifier
- Review stage: pre-Lean specification and library-architecture review, with isolated feasibility compilation of the frozen signatures
- Candidate repository: `/home/codex/Documents/Codex/2026-09-05/yo`
- Exact candidate commit: `d0aa1c55967d7cde7187f5c8b7a05b76d7043fe5`
- Attached brief: `/home/codex/.codex/attachments/6740fc8c-818a-4ce2-95bb-67293a5ba2bf/pasted-text.txt`
- Skills/rubrics applied: `referee-lean-library` in full; `referee-lean-proof` and the repository's proof-quality, quantitative-correctness, source-fidelity, Mathlib-reuse, and API/dependency rubrics where applicable
- Isolation strength: `manual_attestation`
- Isolation method: I read the complete brief and skill rubrics, inspected only Git metadata in the supplied source checkout, exported the exact object with `git archive`, and conducted the review in the archive-only tree `/tmp/spec-d0-referee-f.EM118e/archive`, which had no `.git`. I did not inspect uncommitted file contents or prior review reports. Disposable compilation fixtures were outside the archive. Network and ordinary host credentials were not technically excluded, so this is not a hardened clean-room claim.
- Source-worktree observation: `git status --short` showed untracked `LMLF/Audit/` and `LMLF/Definitions/` paths. Their contents were not read and they are absent from the exact-commit archive.
- Coordination: I sent only status and concrete counterexamples to the review coordinator; I did not communicate with other referees or read their work.

The archive tar SHA-256 before dependency restoration/build was:

```text
4b13cd851274a23742f312bf97bbb3ee16a3e9b2f3908e7e91eb173fa174c08c  source.tar
```

The brief SHA-256 was:

```text
6787cdb628a66783d81190939e9593525ebb2640a8c870d685d95ce26ba0cce3  pasted-text.txt
```

## Verdicts

| Review item | Verdict | Reason |
|---|---|---|
| Overall exact-commit specification | **REQUEST CHANGES** | The architecture and frozen cards are strong, but four reproducible inventory/provenance contract gaps remain in the exact d0 validator/schema. Three allow states that contradict normative provenance or closure rules. |
| `QB-001` theorem card revision 6 / signatures revision 2 | **APPROVE** | The card is bounded to exactly eight coherent declarations, accurately classified, dependency-minimal, and explicit about exclusions and non-coverage. All exact signatures admit transparent implementations under the pinned toolchain. |
| `QB-001` natural-language proof revision 5 | **APPROVE** | Every one of the five target lemmas follows by the stated elementary pointwise argument; the proof uses the actual hypotheses and does not infer convergence or source coverage. |
| `QB-001` structural-circularity gate | **NOT REQUIRED — N/A ACCEPTED** | The packet introduces three thin predicates and five elementary transports, with no construction, choice, continuation, identification, theorem-sized hypothesis structure, or reverse dependency. |
| `DEF-001` theorem card revision 4 | **APPROVE** | The exact four-wrapper API matches the pinned Mathlib declarations and their domains, normalization, real agreement, and totalized pole semantics. The narrow import suffices. |
| `DEF-001` natural-language-proof gate | **NOT REQUIRED — N/A ACCEPTED** | These are transparent non-novel wrappers around four specifically bound pinned declarations; no new mathematical argument is proposed. |
| `DEF-001` structural-circularity gate | **NOT REQUIRED — N/A ACCEPTED** | No object is constructed or continued, no existence/uniqueness identification route is introduced, and no theorem-sized input can contain the conclusion. |

These approvals are referee conclusions bound to the exact artifacts below. They are not, by themselves, the protocol's composite `lean_ready` authorization, do not satisfy a multi-reviewer quorum alone, and do not change the candidate-owned `review_status` or `implementation_status`.

## Material findings

### F1 — High: contradictory edition relations are accepted, and any matching row authorizes the join

`scripts/validate_inventory.py:212-226` makes only `edition_relation_id` unique. It does not make an edition endpoint pair unique or reject multiple rows with inconsistent states. Lines 952-972 validate each row internally, but lines 867-884 implement edition equivalence existentially: one `matched`/`matched`/`equivalent` row returns `True`, even when another row for the same pair remains `unresolved`/`unresolved`/`non_equivalent`.

Novel copied-table mutation:

1. retain the real unresolved `REL-OLV-2010-TO-1997` row;
2. append a second relation with a new ID, the same two endpoints, and `matched`, `matched`, `equivalent`;
3. run `validate_tables`; and
4. call `editions_are_fully_equivalent` on the endpoint pair.

Observed result: validation accepted the contradictory ledger, and the equivalence predicate returned true. Thus a later confirmed notation/entity join could be authorized by one favorable duplicate while contrary provenance remains live. This conflicts with `blueprint/function_inventory.md:22`, which says notes cannot override the relational fields, and with the intended separately represented equivalence trust boundary.

Required repair: canonicalize the unordered or directed endpoint key and reject duplicate/conflicting active relations, or require all applicable relation records to agree under an explicit version/supersession rule. The join predicate must consume one unambiguous authoritative relation. Add a negative test containing both favorable and unfavorable rows for the same pair and an association that attempts the cross-edition join.

### F2 — High: a `complete` page audit can be self-reviewed

`scripts/validate_inventory.py:1029-1052` requires only nonempty `reviewed_by` and `review_date` for a complete page audit. It never distinguishes `reviewed_by` from `audited_by`. Changing an audit to `complete` and copying its auditor identity into `reviewed_by` is accepted.

That state directly contradicts the whole-edition completion gate in `blueprint/function_inventory.md:185-195`, especially “every page ... has a complete page audit and an independent reviewer,” and the audit workflow's second-collator model at lines 170-175. A future zero-debt/whole-book report could therefore be founded on self-review.

Required repair: for `audit_status=complete`, require nonempty auditor/reviewer identities and `audited_by != reviewed_by`. If durable identities have aliases, enforce independence at the identity layer rather than by display string alone. Add an explicit self-review negative fixture.

### F3 — High: the reserved locked-copy placeholder can be promoted in place to source-ready evidence

The prose gives `SRC-OLV-1997-COLLATION-PENDING` special immutable meaning: `blueprint/function_inventory.md:24` says replacing it requires a **new concrete snapshot row**. The validator instead recognizes a placeholder only from mutable row fields. `source_snapshot_is_ready` at `scripts/validate_inventory.py:891-901` excludes the row only while `snapshot_kind == locked_copy_placeholder` and otherwise trusts its mutable availability/digest/reconciliation fields.

Novel copied-table mutation changed that same reserved row to `local_scan`, supplied a syntactically valid verified SHA-256, and marked availability, edition reconciliation, and page mapping ready. Validation accepted the mutation. The reserved pending identity could then satisfy downstream source-readiness tests without the new concrete snapshot identity required by policy.

Required repair: reject any ready/evidentiary state for the reserved `SRC-OLV-1997-COLLATION-PENDING` ID (or model immutable placeholder identity explicitly), and require a new snapshot ID for acquired bytes. Add a negative fixture that attempts in-place promotion with otherwise valid fields.

### F4 — Medium: closed-manifest card membership and artifact identity are not executable invariants

The specification says a closed manifest has finite exact card membership and totals (`blueprint/README.md:116-119`, `blueprint/source_manifest.md:68-73`) and the target linter says declared card totals equal distinct joined rows (`blueprint/automation/contract_linting.md:224-239`; `testing_and_ci.md:79-99`). The current `manifests.csv` schema has only `declared_source_occurrence_total`, not a declared card total. The validator counts only source-occurrence links at lines 1491-1529.

Two copied-table mutations were accepted:

- `DEMO-0` could be changed to closed/execution-ready while still having no registered cards or declared card denominator.
- Planned card `QL-001` could be marked `file_present` with `target_path=README.md`; lines 1341-1362 check only that the target is an existing regular file, not that it is the claimed card, contains the matching stable ID, or parses at the required lifecycle level.

The documentation honestly says the current program is only an inventory-table validator and the broader YAML/Markdown contract linter is future work (`review/README.md:81-87`, `blueprint/function_inventory.md:207-216`). Therefore this is not a claim that d0 falsely certified source coverage. It is a blueprint/schema gap: the advertised future closure invariant cannot yet be represented by the manifest table, and a green current run cannot substantiate artifact identity.

Required repair: add and validate a declared distinct-card total (or an equivalent explicit manifest-card association contract), require every closed member to resolve to a frozen card with exact boundaries, and make `file_present` parse/bind the card ID rather than checking arbitrary file existence. Until then, label all green output explicitly as inventory shape/provenance checks, not manifest-card closure.

### F5 — Low, defense in depth: checkout credentials remain persisted while candidate code runs

`.github/workflows/ci.yml:16-20` checks out candidate content and then executes the candidate-controlled validator. The exact pinned `actions/checkout` revision defaults `persist-credentials` to true and documents that its token is persisted in local Git configuration. No authenticated Git operation is needed afterward. Set `persist-credentials: false`.

Risk is mitigated: this is a `pull_request`/`push` workflow, not `pull_request_target`, and top-level permissions are restricted to `contents: read`. The recommendation is therefore low severity, not a release blocker. Exact upstream evidence: [checkout action definition](https://raw.githubusercontent.com/actions/checkout/fbc6f3992d24b796d5a048ff273f7fcc4a7b6c09/action.yml) and [checkout documentation](https://raw.githubusercontent.com/actions/checkout/fbc6f3992d24b796d5a048ff273f7fcc4a7b6c09/README.md).

## Architecture and library-scale assessment

### Blueprint coverage and dependency direction

The blueprint is unusually complete for a specification-only head. Its global DAG separates pinned foundations, source evidence, finite quantitative infrastructure, domain/branch support, constructions, identification, generic methods, applications, zeros/connections, source-recovery audits, and release documentation. The forbidden reverse edges are explicit in `blueprint/dependency_graph.md:47-59`. The queues cover finite Laplace methods, oscillatory/contour methods, summation and coefficient transfer, complex derivative transport, ODE residual/stability, turning points, zeros/connections, and all named-function portfolios requested by the brief.

Important non-dependencies are also correct:

- quantitative foundations do not depend on named functions;
- constructions do not depend on their later identification or asymptotic consumers;
- residual identities are separate from stability/error transfer;
- audit and source-recovery consumers do not feed semantic foundations;
- tactic automation is postponed until repeated stable manual proofs exist; and
- the Watson MVP excludes Airy, Cauchy transport, contours, summation, ODE, turning points, zeros/connections, and tactics from its critical path (`dependency_graph.md:103-128`).

The family queues are planning handles, not wildcard authorizations. The blueprint even flags overlapping coarse and granular handles (`DEF-002`/`DEF-003` versus `DEF-AIR-*`/`DEF-BES-*`) for reconciliation before registration. I found no circular mathematical dependency or premature universal typeclass. A single package with narrow future modules is proportionate at this stage.

The only architectural request for change is F4: the closure design promises an exact card denominator that the current normalized schema cannot express.

### Classification schema, registries, and planning tables

Classification revision 2 correctly supersedes rather than rewrites frozen v1. It separates:

- packet theorem shape;
- packet source/infrastructure coverage role;
- mathematical novelty/relation to prior work; and
- the analogous, separately enumerated target-level axes.

It also makes `registry_binding` executable: the five `required` examples (`QB-001`, `DEF-001`, `QL-001`, `OLV-001`, `SR-001`) exist with exact packet-level triples, while illustrative `NAMED-EXAMPLE` creates no registry row. The baseline validator checks drift on all three required axes. No class implies approval, readiness, implementation, or source coverage. This resolves the v1 category error cleanly.

The occurrence, notation, entity, entity-evidence, card, manifest, and association tables are normalized and mostly use orthogonal status axes. Planning-only Watson relationships are explicit without being promoted to source truth. F1-F4 are validator/closure omissions around this otherwise sound model, not a need to collapse these tables or invent a large framework.

### Trust boundary and lifecycle envelopes

The prose trust boundary is coherent:

- candidate-owned status can describe intrinsic completeness but cannot issue approval or authorization;
- external envelopes bind exact commits and ordinary digests without self-reference;
- `approve` is a referee verdict, `pass` is a composite gate state, and `not_required` is representable only for a frozen `not_applicable` requirement with reason;
- manual fresh-checkout claims are explicitly weaker than technically enforced isolation;
- new artifact, rubric, pin, or candidate revisions invalidate the relevant prior gates; and
- implementation begins only after externally bound `lean_ready` and still requires exact-head implementation review.

The QB and DEF packets follow those rules. Neither candidate-owned card claims an authoritative review, `lean_ready`, implementation, or release. The recorded historical QB review is explicitly non-quorum. F2 is material precisely because the source-inventory validator currently fails to enforce the independent-review concept that the broader protocol gets right.

### Source provenance and coverage restraint

At the actual d0 data state, provenance is conservative:

- the 2010 publisher preview is a distinct edition/snapshot and remains partial, undigested, and page-unmapped;
- its relation to the locked 1997 edition is unresolved/non-equivalent;
- the locked 1997 snapshot is explicitly a pending placeholder;
- the Watson occurrence is untranscribed/unreconciled and has no promoted notation/entity truth;
- DLMF is used as locator/convention evidence, not as a substitute for the locked source; and
- project extras are separated from source-coverage counts.

The current inventory is a seeded queue, not an exhaustive book scan. Its completion section requires pagewise audit, independent review, direct body reconciliation, verified transcriptions, notation/entity normalization, reverse API audit, and zero unresolved source rows. No full-function, whole-edition, theorem-source, or named-application coverage is claimed at d0. The manifest counts produced by the validator are denominators for the currently registered manifests only.

F1-F3 are forward-integrity counterexamples: the current rows are truthful, but future state transitions can bypass the written trust contract unless the validator is strengthened.

### CI, pins, and reproducibility

The committed toolchain/lock is coherent:

- Lean toolchain: `leanprover/lean4:v4.33.1`
- observed Lean commit: `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`
- resolved Mathlib commit: `0df444a360eaa60ab8c11dca51a86af692955474`
- checkout and Lean actions are pinned to full commit SHAs, not floating tags.

The clean archive built successfully with 1,333 jobs. Both inventory commands passed. The exact pinned Lean action definition confirms that `build: true` drives the Lake build and automatically recognizes a Mathlib cache; axiom audit is available but not enabled by default: [lean-action definition](https://raw.githubusercontent.com/leanprover/lean-action/50fcf42d2e460296f1a34b402e990d1b24f8b596/action.yml) and [documentation](https://raw.githubusercontent.com/leanprover/lean-action/50fcf42d2e460296f1a34b402e990d1b24f8b596/README.md).

The CI document accurately calls the present job a baseline, labels the larger pipeline target design, and disclaims a hermetic/bit-for-bit OS environment because `ubuntu-latest` moves. It does not claim that CI performs reviewer identity, source certification, YAML/Markdown contract lint, axiom audit, import audit, regressions, or future tactic checks today. That restraint is appropriate. F5 is the only concrete workflow hardening point.

### Exact absence of Lean implementation at d0

The archive contains only:

```text
LMLF.lean                 9 lines
LMLF/Basic.lean           7 lines
LMLF/Definitions.lean     7 lines
LMLF/Results.lean         7 lines
```

The layer chain is `LMLF.Basic -> LMLF.Definitions -> LMLF.Results -> LMLF`. There are no semantic declarations for QB-001 or DEF-001, no `LMLF/Quantitative/Basic.lean`, no `LMLF/Definitions/Gamma.lean`, and no audit/test/tactic implementation. A scan found no project `def`, `theorem`, `lemma`, `structure`, `class`, `inductive`, `axiom`, `sorry`, or `admit` in the four archived Lean roots. The successful package build establishes skeletal package health only. It is not implementation evidence or source/function coverage.

## `QB-001` detailed review

Bindings reviewed:

- theorem card revision 6: `7e83195fd3b6ff9ea884e29f6d857a4673c9de5fe44327d914e595e6b798468f`
- signatures revision 2: `93e4e30a93087de95342abdb1e986676924cd93512e771737d0d3f3ed7973b39`
- natural-language proof revision 5: `167629f117dc0609809162b5a5247d05e0c9a193d96b84d9cda5247e930ecd4c`
- work packet revision 3: `6eaeea14a581d4b60c7933afb2c9bb24a633df135a935b7c7e4af11c9845cf87`

### Card/API verdict: approve

The packet contains exactly three definitions and five theorems:

1. `QuantitativeAnalysis.ErrorOn`
2. `QuantitativeAnalysis.NormBoundOn`
3. `QuantitativeAnalysis.HasErrorFamily`
4. `QuantitativeAnalysis.ErrorOn.exact`
5. `QuantitativeAnalysis.ErrorOn.restrict`
6. `QuantitativeAnalysis.ErrorOn.weaken`
7. `QuantitativeAnalysis.ErrorOn.trans`
8. `QuantitativeAnalysis.ErrorOn.comp`

The fixed target function in `HasErrorFamily` makes the quantifier order clear; only approximant, domain, and majorant vary with `n`. The name avoids a false “finite expansion” claim, and the card explicitly disclaims convergence, monotonic improvement, finite-sum representation, nonempty generic domains, and source coverage. Binder order and namespaces are coherent. `Set.EqOn`, subset inclusion, pointwise majorant ordering, the additive norm bound, and `Set.MapsTo` are exactly the weakest natural interfaces for the five transports. The sole declared downstream consumer is the planned `QL-001`, so the seam is reusable without being speculative.

Prospective symmetry, congruence, algebraic closure, inverse/division, finite-sum, and family-wrapper material in the dossier is explicitly excluded from this card. I found no extra target smuggled into the normative scope.

### Natural-language proof verdict: approve

The normative proof sections cover every theorem and no more:

- `exact`: rewrite by pointwise equality and use `norm_zero`;
- `restrict`: apply the original pointwise bound after subset inclusion;
- `weaken`: compose the original norm inequality with `b x <= d x`;
- `trans`: write `f-c = (f-a) + (a-c)`, apply `norm_add_le`, then add the two hypotheses;
- `comp`: use `MapsTo` to place `u x` in the original domain and specialize the bound.

The transitivity argument has the correct majorant `b + d` and does not rely on cancellation or sign assumptions. Empty domains remain valid for generic infrastructure. No proof step assumes a desired application, no totalized operation hides a missing condition, and no convergence-in-order conclusion is inferred from per-order finite bounds.

### Isolated exact-signature compilation

I constructed a disposable fixture outside the archive containing exactly the eight signatures and direct implementations of the reviewed arguments. It compiled with no diagnostics:

```text
lake env lean /tmp/spec-d0-referee-f.EM118e/QB001Exact.lean
```

Fixture SHA-256:

```text
5c6cfac40f148b9d246066e9852b16309c9db261dcff9db1665f3602727eeab9
```

`#print axioms` reported, for each of the eight declarations, exactly:

```text
[propext, Classical.choice, Quot.sound]
```

This is compatibility/feasibility evidence for the frozen API, not a claim that the candidate commit implements QB-001.

## `DEF-001` detailed review

Bindings reviewed:

- theorem card revision 4: `eff82b06afaa61b67d13c3a399494525ed452e42c203a390ba40e56b93ec9daa`
- work packet revision 3: `6dbda13f4f27dd4c0492c00ecc0a2d184f00fe85fa7096802cf93e9fdecf11e8`
- pinned Mathlib Gamma source: `720a9a72d742fbe1c9a89601dc3a00d82c0261c7368c98cccb58307dbffe3bbf`

### Card/API and Mathlib-reuse verdict: approve

The packet proposes exactly four declarations under the narrow import `Mathlib.Analysis.SpecialFunctions.Gamma.Basic`:

1. `LMLF.Definitions.gamma_eulerIntegrable`
2. `LMLF.Definitions.gamma_eq_eulerIntegral`
3. `LMLF.Definitions.gamma_ofReal`
4. `LMLF.Definitions.gamma_neg_nat_eq_zero`

At resolved Mathlib commit `0df444a360eaa60ab8c11dca51a86af692955474`, I inspected the exact local source for `Complex.GammaIntegral_convergent`, the `Complex.GammaIntegral` definition, `Complex.Gamma_eq_integral`, `Complex.Gamma_neg_nat_eq_zero`, and root-level `Complex.Gamma_ofReal`. Their hypotheses, conclusion orientations, coercions, and namespace placement support the four wrapper types exactly.

The first two wrappers correctly retain `0 < s.re`; the integral is over `Set.Ioi 0`, so the positive real base avoids zero and the complex-power branch cut. The equality is not extended through the poles or outside the convergence half-plane. The real-agreement theorem is correctly stated for all reals in Mathlib's totalized semantics. The negative-natural zero wrapper clearly documents zero as Mathlib's totalization at classical poles, not as a classical finite Gamma value. No scale, sign, argument, or normalization mismatch was found.

These wrappers provide a stable project presentation seam for a specifically identified downstream Gamma-moment dependency and do not duplicate the Gamma object or its analytic development. Broader reciprocal, incomplete-Gamma, reflection, duplication, Stirling, or asymptotic work is excluded.

### Isolated exact-signature compilation

I restored the pinned dependency cache and constructed a disposable fixture outside the archive with the exact four signatures. The wrappers compiled transparently via the named facts, using only the minimal normalizations required to expose the Euler integrand:

```text
lake env lean /tmp/spec-d0-referee-f.EM118e/DEF001Exact.lean
```

Fixture SHA-256:

```text
0473ebcf4a8fb58955bf0cdc64ad6477077299cd99fc4f1e10251552e07571cf
```

`#print axioms` reported, for each wrapper, exactly:

```text
[propext, Classical.choice, Quot.sound]
```

This validates the proposed narrow API against the pinned dependency. It does not convert the absent d0 implementation into candidate code or waive the required external gates and future exact-head implementation review/regressions.

## Validator stress-test record

Baseline commands:

```text
python3 scripts/validate_inventory.py
python3 scripts/validate_inventory.py --negative-tests
```

Baseline results:

```text
inventory validation passed: 24 occurrences, 2 notations, 10 entities,
10 entity evidence rows, 16 occurrence associations;
classification examples [DEF-001, OLV-001, QB-001, QL-001, SR-001];
manifest totals [BOOTSTRAP-0=0, DEMO-0=0, OLV-MVP-1=1]

negative invariant tests passed: 15 intentionally invalid copied fixtures rejected
```

I then loaded the same tables and classification authority through the validator's public module functions, deep-copied them independently per case, applied one novel mutation, and called `validate_tables`. The baseline files were never changed. Results:

| Novel mutation | Result at d0 |
|---|---|
| Contradictory equivalent and unresolved relations for the same edition pair | **ACCEPTED** |
| Promote reserved `SRC-OLV-1997-COLLATION-PENDING` in place to a ready local scan | **ACCEPTED** |
| Complete a page audit with `reviewed_by == audited_by` | **ACCEPTED** |
| Mark `QL-001` `file_present` at unrelated `README.md` | **ACCEPTED** |
| Make zero-member `DEMO-0` closed/execution-ready | **ACCEPTED** |

The existing 15 negative tests are useful and did reject malformed hashes, placeholder resolution, unresolved endpoints, premature source-card/manifest readiness, all-axis registry drift, cross-edition Watson links, and distinct same-edition snapshot joins. The novel cases exercise ambiguity, actor independence, reserved identity, semantic artifact identity, and card-denominator closure, none of which those fixtures cover.

## Reproducibility commands and results

The material commands used, with the working directory shown where it matters, were:

```bash
# Supplied checkout: metadata only
git status --short
git branch --show-current
git rev-parse HEAD
git cat-file -t d0aa1c55967d7cde7187f5c8b7a05b76d7043fe5
git archive --format=tar --output=/tmp/spec-d0-referee-f.EM118e/source.tar \
  d0aa1c55967d7cde7187f5c8b7a05b76d7043fe5
tar -xf /tmp/spec-d0-referee-f.EM118e/source.tar \
  -C /tmp/spec-d0-referee-f.EM118e/archive
sha256sum /tmp/spec-d0-referee-f.EM118e/source.tar \
  /home/codex/.codex/attachments/6740fc8c-818a-4ce2-95bb-67293a5ba2bf/pasted-text.txt
find /tmp/spec-d0-referee-f.EM118e/archive -name .git -print

# Archive-only inspection and validation
cd /tmp/spec-d0-referee-f.EM118e/archive
bash /home/codex/.codex/skills/referee-lean-library/scripts/library_inventory.sh .
python3 scripts/validate_inventory.py
python3 scripts/validate_inventory.py --negative-tests
sha256sum review/classifications-v1.yaml review/classifications-v2.json \
  blueprint/theorem_cards/QB-001.yaml \
  blueprint/theorem_cards/QB-001-signatures.md \
  blueprint/proofs/QB-001.md blueprint/reviews/QB-001-rev3.md \
  blueprint/theorem_cards/DEF-001.yaml \
  review/work_packets/QB-001.yaml review/work_packets/DEF-001.yaml \
  lake-manifest.json lean-toolchain .github/workflows/ci.yml \
  scripts/validate_inventory.py

# Exact toolchain/dependency/build checks
lake --version
lean --version
lake exe cache get
lake build
git -C .lake/packages/mathlib rev-parse HEAD
sha256sum .lake/packages/mathlib/Mathlib/Analysis/SpecialFunctions/Gamma/Basic.lean

# Disposable exact-signature compilation and axiom reports
lake env lean /tmp/spec-d0-referee-f.EM118e/QB001Exact.lean
lake env lean /tmp/spec-d0-referee-f.EM118e/DEF001Exact.lean
sha256sum /tmp/spec-d0-referee-f.EM118e/QB001Exact.lean \
  /tmp/spec-d0-referee-f.EM118e/DEF001Exact.lean
```

Observed tool versions/results:

```text
Lake version 5.0.0-src+819816b (Lean version 4.33.1)
Lean 4.33.1, x86_64-unknown-linux-gnu,
commit 819816b2e0a3bf405af45ae5c7af2491d8f5bee6, Release
Mathlib HEAD: 0df444a360eaa60ab8c11dca51a86af692955474
lake build: Build completed successfully (1333 jobs)
QB exact fixture: exit 0
DEF exact fixture: exit 0
```

## Frozen/input digest audit

Every embedded frozen digest checked below matched its file bytes:

| Artifact | SHA-256 |
|---|---|
| `review/classifications-v1.yaml` | `7a4f322bb56dbb40d5d44a7eceb50b5a49ea6ae69f414b920341e3b12ea9d71e` |
| `review/classifications-v2.json` | `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9` |
| `blueprint/theorem_cards/QB-001.yaml` | `7e83195fd3b6ff9ea884e29f6d857a4673c9de5fe44327d914e595e6b798468f` |
| `blueprint/theorem_cards/QB-001-signatures.md` | `93e4e30a93087de95342abdb1e986676924cd93512e771737d0d3f3ed7973b39` |
| `blueprint/proofs/QB-001.md` | `167629f117dc0609809162b5a5247d05e0c9a193d96b84d9cda5247e930ecd4c` |
| `blueprint/reviews/QB-001-rev3.md` | `4b0e8157ebaeb5101916154515094dc82ddffbace4b753ba8b892877cc0df055` |
| `blueprint/theorem_cards/DEF-001.yaml` | `eff82b06afaa61b67d13c3a399494525ed452e42c203a390ba40e56b93ec9daa` |
| `review/work_packets/QB-001.yaml` | `6eaeea14a581d4b60c7933afb2c9bb24a633df135a935b7c7e4af11c9845cf87` |
| `review/work_packets/DEF-001.yaml` | `6dbda13f4f27dd4c0492c00ecc0a2d184f00fe85fa7096802cf93e9fdecf11e8` |
| `lake-manifest.json` | `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404` |
| `lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `.github/workflows/ci.yml` | `7f7b9323df569a2fe69b94540e721fbd51fb2d770868d4f9202c58361da20af2` |
| `scripts/validate_inventory.py` | `83c7fab5ea37b2784dd8467e27d8e213b59ca5573cec78719fcf89eaf17d0091` |
| pinned Mathlib `Gamma/Basic.lean` | `720a9a72d742fbe1c9a89601dc3a00d82c0261c7368c98cccb58307dbffe3bbf` |

## Final assessment

The exact d0 commit succeeds at its central discipline: it is a specification-only library blueprint, not a disguised implementation or coverage claim. Its module DAG, source/function separation, orthogonal classification model, external-review trust boundary, frozen QB and DEF packets, and explicit future CI/test plan are all credible. Both bounded APIs compile exactly and are mathematically sound against the pinned environment.

The overall verdict remains **REQUEST CHANGES** because the executable provenance/closure layer accepts contradictory relation authority, self-reviewed completion, in-place promotion of a reserved placeholder, and closure/artifact states without exact card identity or a card denominator. These defects are localized and repairable; they do not require redesigning QB-001, DEF-001, the global dependency DAG, or the source-coverage philosophy. A later repaired commit requires a fresh exact-head validation and cannot inherit this d0 overall verdict.
