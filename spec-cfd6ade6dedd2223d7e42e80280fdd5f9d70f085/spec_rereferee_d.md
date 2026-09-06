# Independent adversarial specification re-review D

## Verdicts

- **Overall specification verdict: REQUEST_CHANGES.** Two P1 governance-contract contradictions remain. They are fixable, and I found no mathematical, source-edition, dependency-pin, inventory-data, DAG, boundedness, anti-laundering, tactic, or digest defect in the committed bootstrap content.
- **Separate DEF-001 revision-2 theorem-card / Mathlib-reuse / semantic verdict: APPROVE.** The four proposed signatures are faithful, bounded wrappers around declarations at the pinned Mathlib commit, and all four exact signatures compile in an independent disposable probe. This card verdict is not an implementation authorization: finding P1-02 prevents a protocol-conforming `lean_ready` record until the gate representation is repaired.

## Review identity and isolation

- Reviewer: `spec_rereferee_d`
- Model: `gpt-5.6-sol`
- Repository: `/home/codex/Documents/Codex/2026-09-05/yo`
- Exact reviewed commit: `cfd6ade6dedd2223d7e42e80280fdd5f9d70f085`
- Isolation: fresh context; read-only exact-commit review. I resolved the commit as a Git object and produced a disposable snapshot with `git archive cfd6ade6dedd2223d7e42e80280fdd5f9d70f085`. I did not inspect or rely on the live worktree, did not edit the repository, and wrote only a disposable Lean probe plus this external report.
- Prior-review exclusion: I did not open or read `blueprint/reviews/QB-001-rev3.md` or any current/prior referee report. The committed tree advertised that historical path, so I explicitly excluded it from all searches and reading.

## Findings

### P1-01 — The frozen packet classification vocabulary cannot express the source-card classes required by the normative blueprint

**Exact references:**

- `review/classifications-v1.yaml:11-37` defines packet-level theorem classes as `foundational_calculus`, `definition_identification`, `exact_source_generic`, `named_application`, `audit_source_recovery`, and `mixed`, and packet-level coverage classes as `infrastructure`, `entity_identification`, `direct_source`, `named_function`, `audit_only`, and `mixed`.
- `blueprint/source_manifest.md:46-63` says every card uses that frozen vocabulary, but requires packet coverage values `exact_source_generic`, `named_source_application`, and `audit_source_recovery`.
- `blueprint/function_inventory.md:99-118` and `blueprint/inventory/cards.csv:4-6` use theorem classes `finite_remainder_bound` and `qualitative_bridge` and the latter coverage vocabulary for planned QL-001, OLV-001, and SR-001.
- `blueprint/qualitative/source_recovery.md:167-173` requires an SR card with `theorem_class: qualitative_bridge` and `coverage_class: audit_source_recovery`.
- `blueprint/qualitative/release_strategy.md:215-225` uses the same coverage classes as release-gate discriminants.
- `blueprint/automation/contract_linting.md:81-105` says the future linter will validate every field against the proper frozen table and reject a mismatch as `SCHEMA-CLASS-001`.

The existing bootstrap cards happen to use values in the intersection, but the selected Stage-1 architecture cannot create OLV-001 or SR-001 while satisfying both the frozen schema and the normative source/release documents. The schema also places coverage-like concepts (`exact_source_generic`, `audit_source_recovery`) under packet `theorem_class`, while omitting the declared mathematical shapes (`finite_remainder_bound`, `qualitative_bridge`). This is a real contract contradiction, not merely alternate prose terminology.

**Required fix:** choose one packet-level theorem vocabulary and one packet-level coverage vocabulary; update `classifications-v1.yaml`, every normative consumer, the inventory enum validator, and templates together. Bump the classification schema identity/digest and all frozen packets/cards whose bindings are thereby invalidated. A conforming OLV-001 and SR-001 row must validate without translating the same value between incompatible axes.

### P1-02 — DEF-001's `natural_language_proof_review: not_required` state is not representable under the governing protocol/template

**Exact references:**

- `review/PROTOCOL.md:31-34` permits `not_required` only when the frozen packet marks the gate `applicability: not_applicable` with a reason.
- `review/PROTOCOL.md:118-123` says definitions or audit-only targets may mark the natural-language-proof gate inapplicable.
- `review/work_packets/DEF-001.yaml:182-219` instead records `natural_language_proof_review.required: false`, supplies a reason, but has no `applicability: not_applicable`; it then requires the envelope state `natural_language_proof_review: not_required`.
- DEF-001's targets are `qualitative_support`, `identification`, and `exact_identity`, all with `coverage_class: source_prerequisite` (`review/work_packets/DEF-001.yaml:44-151`), not definition or audit-only targets under the protocol's stated exception.
- `review/templates/review_envelope.yaml:39-43` has no NLP applicability or inapplicability-reason fields, and its gate-state comment does not include `not_required`; only the structural gate at lines 44-51 represents that state and its justification.

Thus an external envelope cannot both follow the controlled protocol and satisfy DEF-001's own `lean_ready.requires_gate_states`. The mathematical reason for omitting a proof is sensible for direct pinned-library wrappers, but the normative protocol never grants that exception in its NLP section and the record schemas use two incompatible representations (`required: false` versus `applicability: not_applicable`).

**Required fix:** either (a) explicitly extend the protocol's NLP exception to non-novel direct pinned-library wrappers, use `applicability: not_applicable` consistently in packet and envelope, and add `not_required` to the envelope's NLP state vocabulary, or (b) require and bind a minimal NLP artifact/review for DEF-001. Revise and re-digest the frozen packet/card as required by the invalidation policy before setting `lean_ready`.

## DEF-001 revision-2 card review

**Verdict: APPROVE (theorem-card / reuse / source-semantics scope).**

### Pinned-source evidence

- Lean toolchain: `leanprover/lean4:v4.33.1`.
- Resolved Mathlib commit: `0df444a360eaa60ab8c11dca51a86af692955474`, reproduced by `lake update` in the disposable exact-commit snapshot and equal to the lockfile revision.
- `Mathlib/Analysis/SpecialFunctions/Gamma/Basic.lean` SHA-256: `720a9a72d742fbe1c9a89601dc3a00d82c0261c7368c98cccb58307dbffe3bbf`, exactly matching `review/work_packets/DEF-001.yaml`.
- The inspected pinned declarations are `Complex.GammaIntegral_convergent`, `Complex.Gamma_eq_integral`, `[expose] Complex.GammaIntegral`, `Complex.Gamma_ofReal`, and `Complex.Gamma_neg_nat_eq_zero`.

### Semantic and reuse assessment

- `gamma_eulerIntegrable` is an equivalent expansion of `Complex.GammaIntegral_convergent`; the half-plane hypothesis `0 < s.re`, real integration domain `Set.Ioi 0`, exponential, and complex power all match.
- `gamma_eq_eulerIntegral` follows by `Complex.Gamma_eq_integral` and unfolding `Complex.GammaIntegral`; no scale or normalization factor is missing.
- `gamma_ofReal` and `gamma_neg_nat_eq_zero` are exact aliases of the pinned facts.
- The card correctly distinguishes Mathlib's total value zero at nonpositive integers from a classical finite Gamma value at a pole.
- The positive integration variable lies away from zero and the usual complex-power cut; no continuation outside `0 < s.re` is claimed.
- The packet reuses one actual `Complex.Gamma`, imports only `Mathlib.Analysis.SpecialFunctions.Gamma.Basic`, introduces no new Gamma object, theorem-sized hypothesis, choice, continuation assumption, or source-occurrence claim, and is bounded to exactly four public declarations.
- The thin wrappers are transparent rather than competing constructions: the exact upstream declarations and relationships are recorded per target. No more general or more canonical pinned declaration was found for the requested readable expanded-integrand surface.

### Independent exact-signature probe

In the disposable snapshot I compiled a scratch namespace containing the four signatures verbatim. The first proof used `simpa only [Complex.ofReal_exp, Complex.ofReal_neg]` from `Complex.GammaIntegral_convergent`; the second rewrote by `Complex.Gamma_eq_integral` and closed by reflexivity; the last two applied the exact source facts. `lake env lean DEF001Scratch.lean` completed with no diagnostics.

The substantive structural-circularity inapplicability is also sound: these statements do not construct or identify a selected solution through existence/uniqueness. P1-02 concerns the governance encoding of the separate NLP gate, not a hidden mathematical route in the card.

## Other invariant results

| Area | Result | Evidence |
|---|---|---|
| Governance/status authority | Pass except P1-02 | Candidate-owned fields remain `not_started`/pending and explicitly defer pass/authorization to external artifacts; the committed historical QB report is marked non-quorum. |
| Source edition/reconciliation | Pass | The 1997 A K Peters corrected reprint is the locked target; the 2010 CRC preview is a distinct comparison-only edition; the relation is unresolved/non-equivalent; the 1997 placeholder is not represented as inspected. |
| Classification | **Fail: P1-01** | Current QB-001 and DEF-001 target rows match their packet rows, but the frozen packet vocabulary contradicts the planned source-card vocabulary. |
| Structural review / anti-circularity | Pass except gate encoding in P1-02 | Required versus inapplicable cases have substantive reasons; construction, source-recovery, theorem-sized-data, and named-identification plans require the stronger gate. |
| Dependency DAG | Pass | Definitions precede methods and named applications; audit/source-recovery modules are downstream-only; fixed-target/order and local-zero/global-indexing separations are explicit; no planned reverse edge was found. |
| Dependency pin / reproducibility | Pass | Lockfile unchanged by resolution; exact Mathlib SHA reproduced; pinned source digest matched; exact archive built successfully. |
| Inventory and source joins | Pass | `python3 scripts/validate_inventory.py` reports 24 occurrences, 2 notations, 10 entities, 16 associations, and totals BOOTSTRAP=0, DEMO=0, OLV=1. |
| Inventory negative tests | Pass | `python3 scripts/validate_inventory.py --negative-tests` passes all five deliberate edition-join, entity-confirmation, ID-prefix, and manifest-total mutations. |
| Boundedness | Pass | BOOTSTRAP-0 is exactly two cards, QB-001 exactly eight declarations, DEF-001 exactly four; future queues are repeatedly marked planning-only and non-authorizing. |
| Hypothesis/choice laundering | Pass | Generic conditional data never earns named/source coverage; construction, reachability, nonnegative-majorant, path, normalization, fixed-solution, and source-bridge duties are separately required. |
| Tactic deferral | Pass | Tactics require repeated accepted proof shapes and explicit negative tests; no tactic is treated as trusted or currently authorized. |
| Digests | Pass | Classification, QB card/signature/proof, and DEF card digests match their work-packet bindings. The packet self-binding is correctly externalized. |
| Package build/trust scan | Pass | `lake build` completed all 1325 jobs. The committed Lean package contains only the stated scaffold and no `sorry`, `admit`, custom `axiom`, `unsafe`, or trust-extension marker. |

Nonblocking hardening note: `.github/workflows/ci.yml:17-18` invokes only the positive inventory validator, although the committed validator already has a cheap `--negative-tests` mode. The negative suite passes manually, and `blueprint/automation/testing_and_ci.md:1-4` candidly labels current CI a baseline, so I do not treat this omission as a contradiction in this specification verdict; enabling it would keep those mutation guards from silently rotting.

## Acceptance condition for re-review

Resolve P1-01 and P1-02 in one coherent revision, update every invalidated schema/card/packet digest, and demonstrate that a template-instantiated external envelope can represent DEF-001's intended NLP gate while a sample OLV-001/SR-001 classification validates on the correct theorem and coverage axes. The remaining exact-commit checks above need only be rerun where their inputs change.
