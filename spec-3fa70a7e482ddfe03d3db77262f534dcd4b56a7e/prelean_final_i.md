# Independent pre-Lean referee report — final I (exact specification)

## Review identity and binding

- **Model:** `gpt-5.6-sol`
- **Review type:** fresh, independent pre-Lean specification review
- **Exact specification commit:** `3fa70a7e482ddfe03d3db77262f534dcd4b56a7e`
- **Repository:** LMLF
- **Review date:** 2026-09-05 UTC
- **Attachment reviewed in full:** `/home/codex/.codex/attachments/6740fc8c-818a-4ce2-95bb-67293a5ba2bf/pasted-text.txt`
- **Attachment SHA-256:** `6787cdb628a66783d81190939e9593525ebb2640a8c870d685d95ce26ba0cce3`
- **Skills used:** `referee-lean-library` for the repository-scale architecture, governance, dependency, API, and integration audit; then `referee-lean-proof` for the frozen QB-001 and DEF-001 declarations, proof routes, assumptions, compilation, and axiom checks.

The review was performed from a disposable archive at `/tmp/lmlf-prelean-final-i.nNPeHo`, created with `git archive` from the exact object above. I did not inspect the dirty worktree, untracked repository files, or prior review reports. Scratch Lean files and adversarial fixture files were created only inside the disposable archive. The only durable file written is this report, outside the repository.

## Verdicts

| Scope | Verdict | Reason |
|---|---|---|
| Overall exact specification commit | **REQUEST CHANGES** | One P1 source-manifest role-closure escape remains in the executable validator. The blueprint is otherwise modular, status-honest, pinned, and well governed. |
| QB-001 theorem card revision 7 | **APPROVE** | The card freezes exactly three definitions and five lemmas, with coherent signatures, hypotheses, classifications, and scope. |
| QB-001 NLP revision 6 | **APPROVE** | Every one of the eight targets has a complete noncircular proof, exact anchor binding, and a successful independent Lean reconstruction. |
| QB-001 structural/circularity review | **NOT APPLICABLE / `not_required` is correct** | These are direct predicates and elementary transports. There is no named-object construction, continuation, uniqueness identification, hidden choice, or theorem-sized hypothesis record. |
| DEF-001 theorem card revision 4 | **APPROVE** | All four targets are exact, transparent wrappers around specifically pinned Mathlib facts, with accurate domain and totalization semantics. |
| DEF-001 NLP review | **NOT APPLICABLE / `not_required` is correct** | The targets are transparent non-novel reuse wrappers; a separate natural-language proof would add no mathematical route beyond the four bound upstream declarations. |
| DEF-001 structural/circularity review | **NOT APPLICABLE / `not_required` is correct** | DEF-001 neither constructs nor identifies Gamma anew and introduces no existence, choice, continuation, or target-bearing structure. |
| Prerequisites for external `lean_ready` adjudication | **NO at this exact specification commit; not set here** | QB-001 and DEF-001 are individually mathematically acceptable, but the repository-scale P1 governance defect must be fixed and independently rereviewed before composite authorization. Only an external adjudicator may then bind immutable evidence and verify each packet's distinct-reviewer, composition, and overall quorum rules. |

The requested decision is therefore **request changes**. This report is evidence for an external adjudicator; it does not mutate or purport to set `lean_ready`.

## Findings

### [P1] A closed source manifest can omit every source-target role and still validate

The executable inventory validator checks that a closed/ready manifest is nonempty, that its card artifacts are canonical, that its counted source occurrences are source-ready, and that the role of each *existing* occurrence-card edge agrees with the linked card's coverage class. It does **not** close the graph in the other direction: for each `source_coverage` occurrence counted by a closed/ready manifest, it does not require a confirmed same-manifest `exact_source_target` or `named_application`, nor a `source_recovery` target where the manifest calls for recovery.

I reproduced the escape using only in-memory copies of the exact committed tables:

1. made the Watson occurrence structurally source-ready with a new exact-edition snapshot, verified-looking hashes, confirmed notation/entity links, and an independent covering page audit;
2. added `ROLE-ESCAPE-1` with `scope_closed=true`, `manifest_status=execution_ready`, and declared source total 1;
3. associated Watson to that manifest as `source_coverage`;
4. moved QB-001 into it as its sole card, leaving that card classified only as `infrastructure`; and
5. provided no occurrence-card target edge from Watson to a card in `ROLE-ESCAPE-1`.

`validate_tables` returned **zero errors** and reported `ROLE-ESCAPE-1=1`. The manifest therefore passes as closed and execution-ready even though it contains no exact-source/named target and no recovery target for its counted occurrence.

This contradicts the deterministic closure contract in `blueprint/automation/contract_linting.md` §6.5: every direct source occurrence must have the required exact-source or named target and, where specified, an audit-source-recovery target; infrastructure cannot receive theorem-occurrence credit. It also undercuts the release rule that a source occurrence receives credit only when its manifest-specified required card set is released. Unlike authentication of source bytes or reviewer identities, this is a purely structural relation over tables already available to the validator.

**Required repair:** for every closed/ready manifest and each `occurrence_manifests.csv` row with `coverage_role=source_coverage`, validate the required confirmed occurrence-card role set and require every satisfying card to be a status-consistent member of that same manifest. At minimum require one `exact_source_target` or `named_application`; require `source_recovery` whenever that manifest's declared policy/occurrence contract calls for qualitative recovery. If optional role sets cannot be inferred without ambiguity, add an explicit per-manifest-occurrence required-role field/table. Also reject infrastructure-only closure and add negative fixtures for missing roles, cross-manifest roles, unconfirmed roles, and target/recovery cards linked to a different ready occurrence.

No P0 or P2 finding was identified. This P1 is fixable but release/authorization significant, so the overall verdict is request changes.

## Repository-scale audit

### Architecture and dependency direction

The attachment's central contract—finite exact identities and explicit inequalities, definitions/identification separated from estimates, no numerical-validation layer, and a dependency DAG—is faithfully reflected in the committed blueprint. The planning documents consistently distinguish:

- reusable quantitative semantics from downstream qualitative source-recovery audits;
- generic methods from named-function definitions and named/source applications;
- exact identities from bounds;
- local zero location from multiplicity, global indexing, and exact connection data;
- mathematical dependencies from source order and documentation navigation;
- current frozen work from provisional queues and research questions.

The proposed DAGs have the right orientation. Definitions consume construction substrates and identification facts; methods may consume definitions; named applications consume both; `LMLF.Audit.SourceRecovery` consumes semantic results but is never imported by the semantic root. Airy/Bessel definitions do not depend on turning-point estimates. Zero indexing and connection algebra are separate. No planned downstream theorem is used to justify its own named object or quantitative producer.

The committed Lean package itself is deliberately only a scaffold:

```text
LMLF.Basic
  -> LMLF.Definitions
       -> LMLF.Results
            -> LMLF
```

There is no reverse or audit import. The exact archive contains only `LMLF.lean`, `LMLF/Basic.lean`, `LMLF/Definitions.lean`, and `LMLF/Results.lean`. A declaration/trust-marker search found no project `def`, `theorem`, `lemma`, `axiom`, `constant`, `structure`, `class`, `instance`, `inductive`, `abbrev`, `sorry`, `admit`, or `unsafe`. Thus **no QB-001 or DEF-001 implementation or prototype exists in this exact commit**, matching the recorded statuses.

### Governance, classification, status, and registries

`review/PROTOCOL.md`, the v2 classification schema, work packets, theorem-card registry, occurrence/edition/snapshot/evidence tables, page audits, and manifests form a coherent governance boundary.

- The three classification axes are orthogonal: theorem shape, source/coverage role, and novelty relationship. Required examples are registry-bound and validated against the authoritative v2 schema.
- Packet lifecycle, card state, implementation state, review state, coverage state, and release membership are not collapsed into one status.
- Planned artifacts have no asserted file path; file-present and ready artifacts must use the canonical `blueprint/theorem_cards/<ID>.yaml` path.
- Closed/ready manifests require members and source-dependent manifests require resolved, verified, independently audited occurrences. The missing role-closure check described in the P1 finding prevents this from being a complete source-manifest closure guarantee.
- The reserved pending 1997 snapshot is immutable as a placeholder. Acquisition must create a new snapshot identity.
- Cross-edition relations keep content and locator equivalence independent. Transfer semantics is enabled only when both are matched; duplicate unordered edition pairs are prohibited.
- Occurrence evidence is edition- and snapshot-specific. A preview, DLMF lead, summary-only record, or a distinct same-edition snapshot cannot silently satisfy locked-edition provenance.
- External review evidence is correctly kept outside the candidate commit. Candidate-owned names, historical summaries, and self-review cannot manufacture quorum.

The blueprint is explicit about what is current versus planned. QB-001 and DEF-001 are frozen specification packets but unimplemented. QL-001, OLV-001, and SR-001 remain planning registrations. The locked 1997 source copy remains unresolved. All family, turning-point, zero/connection, catalogue, release, and open-research queues say that they authorize neither implementation nor source coverage. The declared manifest occurrence totals are exact: `BOOTSTRAP-0=0`, `DEMO-0=0`, and `OLV-MVP-1=1`.

### Pin and CI boundary

The pin is coherent across the toolchain, Lake configuration/manifest, work packets, and Mathlib audit. A clean `lake update` in the disposable archive resolved Mathlib commit `0df444a360eaa60ab8c11dca51a86af692955474`; it did not change the committed manifest digest. Lean reported version `4.33.1`, compiler commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`. `lake exe cache get` and the full `lake build` succeeded.

The CI claim is honest. The workflow currently performs inventory validation, all built-in negative fixtures, and the baseline pinned build. The documentation explicitly leaves YAML/Markdown cross-artifact parsing, digest recomputation, dependency/import audits, proof/axiom checks, source-byte authentication, and external-gate/quorum adjudication as planned or manual. The remaining `ubuntu-latest` runner-image variability is also disclosed. I found no claim that present CI enforces those future controls.

## Inventory validator and adversarial testing

The positive inventory run passed with:

```text
24 occurrences, 2 notations, 10 entities, 10 entity-evidence rows,
16 occurrence associations; required examples DEF-001, OLV-001, QB-001,
QL-001, SR-001; manifest totals BOOTSTRAP-0=0, DEMO-0=0, OLV-MVP-1=1.
```

The committed negative suite passed: **all 23 intentionally invalid copied fixtures were rejected**. The exercised mutations were:

1. edition/snapshot mismatch;
2. preview-only entity confirmation;
3. unresolved edition relation treated as equivalent;
4. preview occurrence using a locked-edition prefix;
5. incorrect manifest denominator;
6. Watson joined to 2010-preview notation;
7. Watson joined to a 2010-preview entity;
8. verified source with an unsupported digest algorithm/uppercase hash;
9. verified transcription with an unsupported digest algorithm/uppercase hash;
10. resolved Watson occurrence on the uninspected reserved placeholder;
11. same-edition notation confirmation through that placeholder;
12. confirmed notation with unresolved summary-only endpoints;
13. ready/closed source manifest with unresolved member/cards;
14. registry novelty disagreeing with the required QL-001 classification example;
15. distinct ready snapshots of the same edition used as though equivalent;
16. conflicting duplicate relation for one unordered edition pair;
17. promotion of the reserved placeholder in place;
18. completed page audit reviewed by its auditor;
19. file-present card pointing to an arbitrary existing file;
20. closed/complete empty manifest;
21. ready bootstrap member losing its canonical artifact;
22. composed fake-ready source with no complete page audit; and
23. composed fake-ready source with a noncovering page audit.

I also ran independent in-memory mutations against the validator:

| Mutation | Result |
|---|---|
| Change QB-001 packet theorem axis from `foundational_calculus` to `exact_identity` | Rejected |
| Change QB-001 coverage axis from `infrastructure` to `audit_source_recovery` | Rejected |
| Change QB-001 novelty axis from `non_novel` to `novel` | Rejected |
| Use a missing/noncanonical card path | Rejected |
| Build a syntactically ready source with zero audit rows | Rejected |
| Add a complete but noncovering audit | Rejected |
| Make a covering audit self-reviewed | Rejected |
| Reverse the direction label of one otherwise self-consistent `later_reprint_of` relation | Accepted |
| Assert a self-consistent but evidentially fabricated `matched/matched/equivalent` relation | Accepted |
| Fabricate internally complete metadata, plausible hashes, distinct auditor/reviewer IDs, and content-free files at canonical card paths | Accepted once all syntactic invariants were satisfied |
| Close an execution-ready source manifest around a counted Watson occurrence with only QB-001 infrastructure and no same-manifest exact-source/named/recovery role | **Accepted with zero diagnostics (P1)** |

The first three accepted probes identify the **honest residual manual boundary**: the validator does not semantically prove relation direction, authenticate bibliographic evidence or reviewer identity, recompute unavailable source bytes, or parse theorem-card contents merely because a canonical path exists. The governance documents explicitly reserve those matters for external review or future CI expansion.

The final accepted probe is different. Required role closure is a deterministic graph property over the existing CSV tables, is promised by the manifest contract, and is necessary to stop an infrastructure-only card from standing in for a source target. It is the P1 finding above, not a permissible manual semantic boundary.

## QB-001 revision audit

### Frozen artifact binding and target bijection

The packet revision 4 binds theorem card revision 7, signature sheet revision 2, and NLP revision 6 by exact SHA-256. The NLP contains exactly eight normative HTML anchors, each exactly once:

1. `qb-001-t01-erroron` — `QuantitativeAnalysis.ErrorOn`;
2. `qb-001-t02-normboundon` — `QuantitativeAnalysis.NormBoundOn`;
3. `qb-001-t03-haserrorfamily` — `QuantitativeAnalysis.HasErrorFamily`;
4. `qb-001-t04-erroron-exact` — `ErrorOn.exact`;
5. `qb-001-t05-erroron-restrict` — `ErrorOn.restrict`;
6. `qb-001-t06-erroron-weaken` — `ErrorOn.weaken`;
7. `qb-001-t07-erroron-trans` — `ErrorOn.trans`; and
8. `qb-001-t08-erroron-comp` — `ErrorOn.comp`.

The card target list, signature sheet, packet targets, NLP normative-scope table, and anchor set are bijective. There is no ninth target. All surrounding commentary, future corollaries, suggested declarations, and generic development advice are explicitly prospective and outside QB-001.

### Independent proof review

I independently rederived and compiled all eight declarations in a scratch file importing **only `LMLF.Basic`**.

- `ErrorOn` and `NormBoundOn` use the intended pointwise norm inequalities on a domain.
- `HasErrorFamily` keeps the exact same target function `f` across orders and makes no convergence or asymptotic-scale claim.
- `exact` uses equality on the domain to reduce the error norm to zero.
- `restrict` has the correct subset direction.
- `weaken` has the correct pointwise order direction `b x ≤ d x`.
- `trans` uses the exact additive decomposition and triangle inequality, yielding `b x + d x`; no missing normalization is hidden.
- `comp` requires the correct `MapsTo` premise and transports the existing bound by precomposition.

Empty domains are intentionally permitted at this generic infrastructure layer; the source/named application gates separately require reachability. Likewise, global nonnegativity is not needlessly stored in the predicate, while satisfaction of an error bound implies local nonnegativity where used. The `NormedAddCommGroup` assumptions, implicit/explicit binder order, namespace, and import seam are appropriate.

Compilation succeeded. `#print axioms` for each of the eight declarations reported exactly:

```text
[propext, Classical.choice, Quot.sound]
```

This matches the packet allowlist and introduces no project axiom.

## DEF-001 revision audit

The packet revision 3 and theorem card revision 4 freeze exactly four transparent wrappers. I checked them against the pinned source file `Mathlib/Analysis/SpecialFunctions/Gamma/Basic.lean` and compiled their exact signatures/proofs independently:

1. `LMLF.Definitions.gamma_eulerIntegrable` directly reuses `Complex.GammaIntegral_convergent`, expanding the Euler integrand, under exactly `0 < s.re`.
2. `LMLF.Definitions.gamma_eq_eulerIntegral` directly reuses `Complex.Gamma_eq_integral` while exposing `Complex.GammaIntegral` as the corresponding integral.
3. `LMLF.Definitions.gamma_ofReal` is exactly `Complex.Gamma_ofReal`.
4. `LMLF.Definitions.gamma_neg_nat_eq_zero` is exactly `Complex.Gamma_neg_nat_eq_zero`.

The semantics are accurate. The Euler formula is restricted to the right half-plane; the positive integration variable makes the complex-power branch convention appropriate; real agreement uses Mathlib's total functions; and `n = 0` is intentionally included in the nonpositive-integer zero theorem, with the prose correctly distinguishing classical poles from Mathlib's totalized value zero. No construction, continuation, uniqueness, or duplicate Gamma object is introduced.

Compilation succeeded. `#print axioms` for each wrapper again reported exactly `[propext, Classical.choice, Quot.sound]`. The exact pinned Mathlib source file digest matches the packet.

## Global and local rubric disposition

Under the library-scale rubric, the scope boundary, module ownership, dependency orientation, API placement, reuse of Mathlib, theorem generality, and status model are acceptable for a pre-implementation specification. There is no duplicated semantic implementation or inappropriate audit-to-core dependency to refactor. The source-manifest role-closure escape is nevertheless a P1 governance/architecture defect because the executable gate can certify a structurally incomplete source manifest.

Under the proof-scale rubric, every QB-001 hypothesis is used in the expected direction, every proof reaches its exact target without laundering the conclusion, and the proofs elaborate cheaply with ordinary term/tactic structure. DEF-001 is exact upstream reuse rather than a new proof. Direct isolated compilation and inspection of the exact pinned dependency source supplied the relevant diagnostics; no LSP-only diagnostic was needed.

## Commands and result ledger

Representative commands, all run against the disposable archive except the initial object/archive operation and this external report write:

```bash
git rev-parse 3fa70a7e482ddfe03d3db77262f534dcd4b56a7e
git cat-file -t 3fa70a7e482ddfe03d3db77262f534dcd4b56a7e
git archive --format=tar 3fa70a7e482ddfe03d3db77262f534dcd4b56a7e | tar -xf - -C "$archive"

sha256sum /home/codex/.codex/attachments/6740fc8c-818a-4ce2-95bb-67293a5ba2bf/pasted-text.txt
rg --files
rg -n '^(axiom|constant|def|theorem|lemma|structure|class|instance|inductive|abbrev)\b|sorry|admit|unsafe' LMLF.lean LMLF/*.lean

python3 scripts/validate_inventory.py
python3 scripts/validate_inventory.py --negative-tests
# plus an isolated Python harness importing validate_inventory.py and applying the extra mutations listed above

lake update
lake exe cache get
lake build
lake env lean --version
lake env lean QBReview.lean
lake env lean DEFReview.lean
```

Results: exact Git object resolved; positive inventory passed; all 23 committed negative fixtures passed; the extra mutations behaved as tabulated, including the zero-diagnostic P1 role-closure counterexample; dependency resolution and cache retrieval succeeded; full project build succeeded; both scratch proof files compiled with zero errors; all twelve checked declarations had only the permitted standard axioms.

## Hash ledger

| Artifact | SHA-256 / exact revision |
|---|---|
| Specification commit | `3fa70a7e482ddfe03d3db77262f534dcd4b56a7e` |
| Attached blueprint text | `6787cdb628a66783d81190939e9593525ebb2640a8c870d685d95ce26ba0cce3` |
| Review protocol | `e1a85b683abce3072c3e4275ca9312716025d768c4d542aab9c556c6ccc542a3` |
| Classification schema v2 | `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9` |
| Inventory validator | `7d4dc57e56256d045903014ff0ec41dde28c7ec1ebe56cf65a33698b479021fc` |
| CI workflow | `7f7b9323df569a2fe69b94540e721fbd51fb2d770868d4f9202c58361da20af2` |
| `lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `lakefile.toml` | `c7bb53018e97237f83c740be3e0e42cb9d848097fe20b894cef4e69ba145962b` |
| `lake-manifest.json` | `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404` |
| Resolved Mathlib commit | `0df444a360eaa60ab8c11dca51a86af692955474` |
| Pinned Mathlib Gamma source | `720a9a72d742fbe1c9a89601dc3a00d82c0261c7368c98cccb58307dbffe3bbf` |
| QB-001 card revision 7 | `827522349afc7374a8bec60b3d281c192a44189f8e8c08c24e453bf75e215667` |
| QB-001 signatures revision 2 | `93e4e30a93087de95342abdb1e986676924cd93512e771737d0d3f3ed7973b39` |
| QB-001 NLP revision 6 | `42b027310a56ff70f4c56471de527aa9b6a3ac88810ad3ba17029953514c1589` |
| QB-001 work packet revision 4 | `7a56a1695d15ea2cedd525ee4270d20830e1706827bb592dfde293bcd7d54c39` |
| DEF-001 card revision 4 | `eff82b06afaa61b67d13c3a399494525ed452e42c203a390ba40e56b93ec9daa` |
| DEF-001 work packet revision 3 | `6dbda13f4f27dd4c0492c00ecc0a2d184f00fe85fa7096802cf93e9fdecf11e8` |

## Final authorization statement

At exact specification commit `3fa70a7e482ddfe03d3db77262f534dcd4b56a7e`, the individual QB-001 revision 7 / NLP revision 6 / packet revision 4 and DEF-001 revision 4 / packet revision 3 mathematics receive the approvals stated above. The overall specification is **not yet eligible** for external `lean_ready` adjudication because the P1 source-manifest role-closure escape remains. After a fix and fresh binding review, an external adjudicator must still verify the packet-prescribed distinct reviewer unions and allowed human/agent compositions, record the QB and DEF structural/NLP inapplicabilities as `not_required`, and confirm that no contrary pre-Lean verdict exists. I do **not** set `lean_ready` in this report.
