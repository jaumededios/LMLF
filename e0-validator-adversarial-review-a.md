# E0 validator adversarial review A — preparation only

## Status

**PREPARATION — NOT APPROVAL, NOT AN IMPLEMENTATION VERDICT.**

This checklist was prepared independently before candidate freeze. It does not review or approve the active work-in-progress in `/tmp/lmlf-e0-companion.hFHPMOuG`. An implementation verdict will be issued only after root supplies an exact frozen implementation identity.

Authority reviewed for preparation:

- accepted contract: `stage1-companion-schema-design-draft-04.md`
- exact contract SHA-256: `e3dacb11c97ec059ae8f48e3fc81f3155fbf86c2cd5679c69541852c2d1fdc7b`
- candidate base named by root: `e3b4cafa7f8d1e8b033806737eab23e641a401d8`

The programme objective is actual accepted Lean formalization of selected exact mathematical functions and assertions in DLMF Chapters 4–10. E0 is only a finite synthetic executable contract. Passing E0 cannot supply real DLMF coverage, source authority, `PartitionReady`, a production `Target`, proof credit, `lean_ready`, implementation acceptance, or completion.

## Frozen-candidate intake gate

Before judging implementation:

1. Record the exact frozen artifact identity supplied by root: commit or immutable tree/archive identity, full changed-path set, and exact digests of all changed/untracked candidate files.
2. Verify the review checkout matches that identity and has no later or unrelated edits. Review the exact diff from base `e3b4cafa7f8d1e8b033806737eab23e641a401d8`.
3. Confirm scope contains no Lean source changes, production DLMF census/IDs, main/website/publication changes, CI/Pages/Verso work, commits, or pushes attributable to E0.
4. Recompute the contract digest above. Treat any contract-byte change as a new review subject.
5. Do not import author assertions, other reviewer verdicts, or candidate-owned “pass” state as evidence.

## A. Legacy boundary and immutable golden inputs

- Confirm the protected set is exactly the fourteen `blueprint/inventory/*.csv` paths plus `review/classifications-v3.json` listed in Appendix A—no wildcard, directory digest, or candidate-defined set.
- Recompute every ordinary SHA-256 and compare it with fixed validator-side reviewed constants outside the candidate manifest.
- Confirm missing, extra, renamed, duplicated, and digest-mismatched protected entries fail independently.
- Mutate one protected file and also edit the candidate-owned protected manifest to match; validation must still fail.
- Confirm the intentionally extended `scripts/validate_inventory.py` is not itself treated as a protected legacy input.
- Run the unchanged legacy validation path and all 25 existing negative mutations; compare exact pass/fail behavior with the base checkout.
- Confirm legacy v3 continues to be loaded through the old-track loader at digest `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`, with no v1/v3 semantic reinterpretation or implicit cross-track authority.
- Check that the DLMF successor is separately named/versioned and depends on, rather than supersedes, v3.

## B. Typed identity, ownership, and source authority separation

- Check uniqueness is per declared record type and every reference resolves to the expected type, snapshot, and schema set; adversarially reuse lexical IDs across types to ensure type, not spelling, controls resolution.
- Verify the only ownership path is `canonical_document -> source_owning_leaf -> appearance -> claim`.
- Every leaf has exactly one canonical document; every appearance exactly one leaf and repeats the derived document owner; every claim exactly one appearance and repeats the derived leaf/document/snapshot/schema-set keys.
- Aliases, representations, containers, contexts, notations, and entities must not own or mint appearances/claims. Test forged owner rows and alias-created claims.
- Content-unit typed parents must be optional-single, same-owner/schema, and acyclic. Test self-parent, two-node cycle, cross-document parent, wrong parent type, and container payload.
- Each mathematical/mixed/nonmathematical leaf has exactly its accepted disposition. Claim kinds remain distinct: atomic target, provisional unresolved claim, mathematical reference lead, nonmathematical remainder.
- Ensure equal source text/formula at two genuine appearances remains two identities; no textual deduplication.
- Provisional claims cannot receive invented atom replacements or be relabeled in place.
- Shared contexts are linked only by normalized membership and do not alter ownership.
- Issue status is not inferred from event recency. `closed_with_documented_issues` remains reopenable and confers no readiness.
- A well-posed false/contradicted atom remains denominator/target-eligible with zero fake proof credit.
- All synthetic identifiers use `FX-`; production IDs/data must be absent from E0 fixtures.

## C. Structural item oracle and batch closure

- Every canonical document has a finite nonempty `document_item` set; every item has exactly one owning leaf in the same document/snapshot/schema; every leaf owns at least one item; containers own none.
- Delete a leaf and all dependent references while retaining its item: require a specific `missing_leaf_owner` failure, not merely success after cascading deletion.
- Also test duplicate item ownership, cross-document owner, unknown owner, duplicate item key, empty leaf, and container-owned item.
- Each scope row has exactly one discriminator/subject: `whole_document` xor `whole_leaf`. Reject both/neither/wrong-type subjects.
- `whole_document` derives all declared leaves, appearances, and all four claim kinds. `whole_leaf` derives every owned appearance/claim for that leaf only.
- Overlapping document/leaf scopes deduplicate membership without minting identities.
- Any explicit appearance, leaf, or claim projection must equal the derived set exactly—reject both omissions and extras.
- Cherry-picking one appearance while omitting an in-scope sibling leaf/appearance/claim must fail.
- A document referenced only to interpret an included leaf remains context and must not silently expand to `whole_document`.
- Confirm structural closure is explicitly not a proof that the supplied production inventory exhausts the real payload.

## D. Candidate enumeration and partial per-batch `Target`

- Candidate enumeration is visibly labeled non-authoritative and parameterized by exact `(snapshot, batch, view)`.
- Verify filters jointly require atomic target kind, exact snapshot, derived batch appearance membership, Chapters 4–10, effective successful resolution in the view, exactly one canonical ownership key, and accepted fidelity role.
- Reference leads, provisional claims, and nonmathematical remainder stay outside candidates but inside reconciled closure when owned.
- Positive synthetic B4.1 contains exactly two distinct appearances/atoms, shared context, one ordinary atom, one quantitative atom, and complete required roles. Fixture target output must be exactly those two fixture atom IDs.
- An underdefined claim must keep the fixture target undefined even if its issue says `closed_with_documented_issues`.
- A false but well-posed fixture atom remains in the target and receives no proof/coverage credit.
- E0 may compute `Target` only for explicitly synthetic `FX-` data with a supplied synthetic readiness witness. Ensure the witness cannot be accepted for non-`FX-` data or converted into production authority.
- No command may output `Target(S4)`, a Chapters 4–10/global target, global audit closure, or union batches into an authoritative target. The only target is partial per batch.
- Missing/pending/adverse/changed/incomplete production source or classification review leaves production `Target` undefined; candidate/self-status Booleans cannot override that.

## E. Classification-axis and role-binding integrity

- Every candidate atom has exactly one effective `source_semantics_class`; accepted tokens are only `ordinary_exact_or_structural` and `finite_quantitative_plus_source_recovery`.
- Reject missing/duplicate class, v3 token in this axis, and DLMF token in every v3 theorem/coverage/novelty axis.
- Ordinary classification carries a nonblank occurrence-specific rationale bound to exact atom/snapshot/schema-set/view and to containing artifact ID/exact digest. Reject wrong atom/view/schema/snapshot, absent/blank rationale, and artifact digest mismatch.
- A syntactically ordinary token on the synthetic asymptotic atom fails only against the supplied reviewed synthetic binding; verify there is no prose/NLP inference.
- Ordinary atom: exactly one `ordinary_source_target`, subtype direct or named. Quantitative atom: exactly one `semantic_finite_quantitative` plus exactly one `faithful_source_recovery`.
- Required role cardinality is invariant at all three levels; pending endpoints never excuse missing/duplicate roles.
- At `source-batch`, explicit pending card/declaration endpoints pass; any supplied endpoint is typed and consistent.
- At `card-binding`, each role has an exact frozen card digest and frozen source-facing target; pending declaration or explicitly nonbinding sketch is allowed, but unfrozen card or purported exact signature is rejected. Quantitative cards are distinct.
- At `exact-signature-binding`, every role names an independently reviewed frozen packet and exact selected pre-signature gate bundle; quantitative cards and declarations are pairwise distinct as required.
- Missing required proof/quantitative or architecture/structural-circularity gate, missing perspective, wrong declaration, missing packet, and silent absence-as-inapplicable all fail. A permitted `not_required` must be explicit, reviewed, exact-bound, and justified.
- Helpers/entity/notation equivalences cannot substitute for roles or claim coverage. No level emits or implies `lean_ready`, proof/coverage credit, implementation acceptance, or completion.

## F. External structural authority grammar

- The immutable ordered index has unique positive contiguous/declared-order positions and exactly `(position, record_kind, artifact_id, exact_sha256)` per entry; artifact IDs are unique within kind.
- Indexed bytes exist, pass strict decoding, self-declare the indexed kind/ID, and match exact digest. The index never lists/hashes itself; its digest must be bound externally.
- Every authority edge repeats target ID/kind/digest/position exactly and points strictly backward.
- Enforce only the closed grammar: empty genesis; non-genesis catalog with exactly one earlier catalog predecessor; event with one earlier catalog/selection prior, optional distinct predecessor event, optional distinct prior selection; post-event catalog with required earlier catalog and one-or-more earlier event/selection members; selection with exactly one earlier post-event catalog and optional earlier selection.
- Reject self, same-position, forward, cycle, unknown ID, digest mismatch, wrong kind, illegal edge kind, self-index, noncontiguous/duplicate position, and conflation of predecessor-event with prior-selection.
- Verify timestamps, filenames, lexical order, JSON key order, filesystem discovery, and storage time never establish authority.
- Confirm this validates syntax/backreferences only; it does not fold effective authority, chronology, reviewer independence/quorum, adverse state, suspension, or restoration.

## G. Strict JSON and exact-byte identity

- All structured companion/external authority JSON is decoded as strict UTF-8.
- Reject duplicate keys at root and nested depths, comments, trailing commas, invalid UTF-8, and each of `NaN`, `Infinity`, `-Infinity` wherever a value can occur.
- Exercise every JSON-loading path, including classification, authority index, indexed records, verdict/gate/signature/card/target bindings—not merely one helper unit test.
- SHA-256 must cover stored bytes before/independent of parsing. Change only whitespace, key order, line endings, Unicode normalization, or numeric spelling under the old digest and require failure.
- Ensure no decode/re-encode, semantic canonicalization, text-mode newline conversion, or Unicode normalization can satisfy an exact-byte binding.
- Raw payload evidence may remain binary and is hashed as bytes; CSV/JSON must be UTF-8.

## H. Real-data mode output and non-authority boundary

- Run real-data mode on a minimal structurally valid non-`FX-` packet and capture stdout, stderr, JSON/result object, and exit status.
- It may emit only structural diagnostics and proposed candidate IDs. It must never emit or serialize production `PartitionReady`, production `Target`, proof/coverage credit, `lean_ready`, accepted implementation, completion, global closure, or source authority.
- Probe field names, booleans, nested metadata, summaries, logs, and exit-code meanings for authority-shaped leakage—not just headline CLI text.
- Feed candidate-owned “approved”, “selected”, “complete”, or review-looking fields and confirm they are rejected/ignored rather than elevated.
- Confirm synthetic higher-level witnesses are explicitly fixture-only and the validator states only structural/digest validity, never actual review passage, independence, freezing, or root selection.

## I. Regression, test quality, and verdict standard

- Run the repository-prescribed legacy and E0 test commands from a clean exact frozen checkout and record full transcripts plus environment/toolchain identity.
- Inspect tests for vacuity: mutations must reach the intended check, assert the specific failure class, and not pass merely because an earlier unrelated parse/FK error fires.
- Confirm positive fixtures actually exercise all required paths and hashes are recomputed after frozen artifact construction rather than bypassed.
- Confirm adversarial copies do not mutate shared positive fixtures in place or introduce order-dependent results.
- Compare implementation coverage against every bullet in the contract’s `E0 acceptance tests`; an untested normative requirement remains a gap even if code inspection looks plausible.
- Separate findings into blocking contract violations, nonblocking robustness/documentation issues, and explicitly deferred E1/successor concerns.
- Final verdict must name the exact frozen candidate identity. `PASS` means only that the finite synthetic E0 contract is implemented and legacy behavior preserved; it conveys no real DLMF authority or Lean progress.

## Readiness

Ready to review an exact frozen candidate. Required from root: immutable candidate identity/digest set and the canonical local commands expected to demonstrate the unchanged legacy path, 25 legacy negatives, positive fixture, focused E0 adversarial suite, and real-data mode.
