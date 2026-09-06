# Fresh-context scope review — Stage 1 DLMF through Chapter 10

## Verdict

**REQUEST_CHANGES** for this blueprint only.

The proposed programme boundary is mathematically coherent and unusually careful about atomic prose/formula coverage, source provenance, cross-source non-transfer, quantitative-first theorem architecture, read-only presentation, and the separation between a broad programme and finite executable packets. I found no hidden numerical-implementation scope and no P0 issue. Two P1 specification gaps remain: the completion predicate does not require successful terminal values on the orthogonal workflow axes, and the supplement does not yet establish an unambiguous versioned amendment to the frozen Olver-first decisions it says it supersedes. One P2 denominator/schema clarification should be made at the same time.

This verdict does not review or authorize any Lean theorem, proof, implementation, source audit, manifest, schema migration, or Verso implementation.

## Review identity and independence

- Reviewer: **Sol**, manual fresh-context blueprint referee B.
- Method: independent read-only review; no peer or historical referee report was accessed.
- No subagent was used.
- Candidate edits: none.
- CI/build/validator: not run, because the reviewed artifact is a plan-only Markdown supplement and the assignment expressly excludes CI and implementation authorization. The library inventory helper was run only to understand the existing module/dependency surface; its output was treated as leads, not proof of any finding.

## Exact review snapshot

- Repository checkout: `/tmp/lmlf-stage1-scope.DbhM9YHt`
- Git commit: `32807da8dae22fbcfcc951ad20113b4ca7693e3c`
- Commit subject: `docs: propose DLMF through chapter 10 stage-one boundary [skip ci]`
- Reviewed file: `blueprint/stage_1_dlmf.md`
- File length: 554 lines
- Verified file SHA-256: `c494479f088d2be8eb3d724d8321593b7fba6563c5baefb613625645e9ad9205`
- Checkout state: clean; branch `docs/stage-1-dlmf-through-10` at the exact commit.

## Evidence inspected

I read the complete committed `blueprint/stage_1_dlmf.md` and the relevant existing normative context:

- `blueprint/roadmap.md`;
- `blueprint/source_manifest.md`;
- `blueprint/function_inventory.md`;
- `blueprint/design_decisions.md`; and
- `blueprint/theorem_cards/README.md`.

I also inspected repository status/history and ran the read-only library inventory supplied by the `referee-lean-library` skill. It reported the small current Lean surface (7 Lean files, 210 lines, 18 theorems and 3 definitions), consistent with treating this review as programme architecture rather than an implementation audit.

As limited source corroboration, I inspected the official DLMF root, project-news, errata, Chapter 4, Chapter 10, and §10.46 pages. They support the blueprint's provisional Version 1.2.7 / 2026-06-15 identity, the sampled chapter titles and section ranges, and the important §10.46 distinction: equations explicitly define the generalized Bessel and Mittag–Leffler functions, the Laplace-transform prose makes a substantive but incompletely stated mathematical claim, and the final incomplete-Bessel/Hankel sentence is an external-reference lead. Relevant official URLs are <https://dlmf.nist.gov/>, <https://dlmf.nist.gov/about/news/>, <https://dlmf.nist.gov/errata/>, <https://dlmf.nist.gov/4>, <https://dlmf.nist.gov/10>, and <https://dlmf.nist.gov/10.46>.

This was not a chapter-body audit. I did not verify every Chapter 1–10 page, every function seed, every section boundary, every prose claim, or the eventual source denominator. The report therefore makes no full-chapter or source-completeness claim.

## Findings

### G1 — P1 — The Stage 1 completion predicate permits failed or merely pending workflow states

**Location:** `blueprint/stage_1_dlmf.md`, especially §§6.4, 8, and 9 (lines 345–358, 406–413, and 449–470).

The blueprint correctly declares specification, proof, review, implementation, coverage, and manifest state to be orthogonal. Its final acceptance predicate, however, does not require successful terminal values on those axes:

- it requires every card to be in a finite **closed** manifest, but `source_manifest.md` explicitly defines `scope_closed` independently of `manifest_status`; a closed manifest can therefore still be planning-only or merely execution-ready;
- it requires that review and external-envelope gates be **present**, not that their verdicts approve/pass for the exact bytes;
- it requires declarations to compile, but not that implementation review pass or that `implementation_status` reach the intended accepted terminal value;
- it refers to reconciliation reports but never directly requires every applicable card's `coverage_status` to be `reconciled`; and
- §8 lists an honest `blocked` state as a support-dependency disposition, while the completion bullets require only one explicit disposition and zero silent dependencies, not zero blocked dependencies.

Consequently, the written acceptance criteria admit a formally bad state: all cards are in closed manifests, failed review envelopes exist, implementations merely compile, a support dependency is explicitly blocked, and the structural counts reconcile—yet every bullet can still be read as satisfied. This defeats the purpose of the orthogonal statuses and makes “Stage 1 complete” non-auditable.

**Required change:** define the exact completion value (or accepted value set) for every applicable axis and relation. At minimum, require frozen specifications; complete or validly not-required proofs; all required reviews and external gates to have passing/approved verdicts bound to exact bytes; no blocked or unresolved target/support dependency; accepted implementation-review state for every required declaration; `coverage_status=reconciled` for every target occurrence; and `manifest_status=complete` for every Stage 1 execution manifest. Preserve `scope_closed` as a separate prerequisite rather than treating it as completion. If `released` versus `audited`, or `complete` versus another terminal label, is intentionally policy-dependent, name the accepted set explicitly.

**Verification:** construct negative fixtures for (a) a present `changes_requested` envelope, (b) a closed `execution_ready` manifest, (c) a compiled-unreviewed implementation, (d) a selected but unreconciled occurrence, and (e) an explicitly blocked support dependency; each must make the Stage 1 completion predicate false.

### G2 — P1 — The authority/precedence change is not yet a versioned amendment to the frozen Olver-first decisions

**Location:** `blueprint/stage_1_dlmf.md` §§1, 10, and 12 (notably lines 24–28, 510–515, and 548–554), against `blueprint/roadmap.md` (“Mission and fixed scope,” “First true quantitative-Olver MVP”) and `blueprint/design_decisions.md` DD-001 and DD-011.

The supplement says the DLMF boundary now supersedes the roadmap's Olver-first **programme priority**, while also stating that it does not rewrite frozen artifacts. The existing frozen documents do more than provide historical evidence: DD-001 says the initial source programme is Olver, DD-011 says the first true MVP is the Olver Watson theorem, and the roadmap presents both as current normative direction. `design_decisions.md` itself says frozen decisions remain in force until amended by a reviewed replacement entry. The supplement does not identify DD-001/DD-011 as amended, allocate a successor decision/version, or say exactly which portions remain operative. Its bounded next step asks for a new reviewed decision later, leaving two simultaneously normative programme orders in the meantime.

This does not endanger the frozen Olver evidence bytes—the supplement is commendably explicit about preserving those—but it does make work prioritization and the meaning of “Stage 1” authority-dependent on which document a future contributor reads.

**Required change:** make the transition an explicit versioned design-decision amendment (in this supplement or a separately bound successor) that names the superseded clauses in DD-001, DD-011, and the roadmap; states that Olver artifacts, coverage, and any still-valid bounded manifests remain a distinct non-transferring track; and states whether `OLV-MVP-1` remains an eligible parallel packet, is deferred, or is outside the new Stage 1 programme. Give the new decision an unambiguous precedence/effective rule tied to external review of exact bytes. The old documents may remain immutable historical inputs, but the current authority must have one deterministic resolution.

**Verification:** a reviewer starting from any of the roadmap, design-decision index, source manifest, or this supplement should resolve the same current Stage 1 priority without relying on oral/user-session context.

### G3 — P2 — Make the target-occurrence denominator a machine-definable role-filtered set

**Location:** `blueprint/stage_1_dlmf.md` §§5.1, 6.1, 6.4, and 9 (lines 236–272, 278–292, 330–348, and 434–454).

The prose makes the right conceptual distinctions: the first two fidelity roles create theorem occurrences; an underspecified claim stays unresolved; a mathematical reference lead remains provenance without theorem credit; and nonmathematical material receives a disposition. The acceptance section nevertheless alternates among “occurrence,” “target-occurrence set,” “reference lead,” and metadata record without stating the exact machine predicate that determines denominator membership. In particular, “every Chapter 4–10 occurrence” must map to a theorem card, while a reference lead must not require one; the schema therefore must say whether reference leads occupy a distinct record table or occurrence rows excluded by role. Likewise, an underspecified row must have a deterministic transition into a theorem occurrence or a reference-only record without reuse or loss of its original identity/lineage.

This is not evidence that the intended denominator is wrong; it is a request to make the already sound intention auditable and to prevent future association-row, citation-lead, or metadata counts from becoming the denominator.

**Required change:** state a set expression or equivalent schema rule for the Chapter 4–10 target denominator. For example: immutable atomic rows whose final fidelity role is `explicit_mathematical_assertion` or `internal_cross_reference_assertion`, plus any `underspecified_mathematical_claim` only after a reviewed resolution promotes it to one of those roles; exclude `mathematical_reference_lead` and nonmathematical metadata while retaining them in separately reconciled census totals. Define the immutable transition/lineage rule rather than changing a row's historical meaning in place. Qualify “every card” and “orphan cards” as Stage 1 target/support cards so unrelated frozen Olver or source-free infrastructure cards cannot affect the DLMF denominator.

**Verification:** include a mixed prose block, a repeated formula, an internal cross-reference, a genuine reference lead, and an underspecified claim that is later resolved; derive content-unit total, theorem-occurrence denominator, association-row total, and deduplicated covered-occurrence total without ambiguity.

## Sections clear under the library-review rubric

- **Mathematical intent:** clear apart from G1/G2. Chapters 4–10 are the exhaustive mathematical-assertion programme; Chapters 1–3 are consumer-justified support, not blanket coverage.
- **Reusable seams/API shape:** clear at blueprint level. Canonical entities, occurrence-local notation, identification bridges, generic infrastructure, exact-source/named applications, and source recovery are kept distinct. No premature universal special-function abstraction is introduced.
- **Module/dependency direction:** clear. Definitions and quantitative semantic results point downstream to consumer-only `Audit/SourceRecovery`; audit/presentation layers do not flow backward into mathematical definitions.
- **Mathlib integration:** clear as a policy. Reuse requires exact declaration and semantic audit, and no source credit follows from reuse alone. I did not perform declaration-level Mathlib searches because no new theorem signature or implementation is authorized here.
- **Proof architecture:** clear. New quantitative bounds are openly classified as new mathematics, cannot be laundered through hypotheses or opaque majorants, and retain source recovery as a separate downstream obligation.
- **Cost/durability:** no concrete performance finding is possible or warranted for this plan-only artifact.
- **Refactor risk:** clear. The supplement preserves frozen Olver/BOOTSTRAP/IMPROPER artifacts and forbids cross-source coverage transfer; G2 concerns only the missing normative precedence record.
- **Numerical boundary:** clear. Exact stability/error/convergence mathematics remains eligible, but evaluators, floating point, interval arithmetic, adaptive methods, solver strategies, and numerical APIs remain outside LMLF Stage 1. Quantitative-first work is mathematical strengthening with its own review burden, not numerical implementation.
- **Verso handoff:** clear. Verso is a read-only projection over versioned authority, shows independent status axes and provenance, labels provisional counts, and cannot change mathematical/source/review truth.
- **Broad programme versus execution:** clear. The chapter scope is explicitly not a manifest; the first audit packet is limited to a Chapter 4 census and the first implementation packet must be separately finite, closed, reviewed, and authorized.

## Disposition

No P0 findings. Resolve G1 and G2 before approving this blueprint as the operative Stage 1 scope. G3 can be resolved in the same revision or in the explicitly bound schema-migration decision, provided this blueprint points to that exact denominator rule and cannot be used independently to claim completion.
