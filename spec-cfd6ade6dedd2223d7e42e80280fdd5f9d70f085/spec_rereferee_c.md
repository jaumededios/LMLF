# LMLF exact-snapshot architecture/source re-review

- Reviewer ID: `spec_rereferee_c`
- Model: `gpt-5.6-sol`
- Review mode: manual fresh read-only isolation
- Reviewed repository: `/home/codex/Documents/Codex/2026-09-05/yo`
- Exact reviewed commit: `cfd6ade6dedd2223d7e42e80280fdd5f9d70f085`
- Scope isolation: all input was obtained from `git show` or a fresh `git archive` of the exact commit. Untracked Gamma/Audit files and other referee reports were not read. The repository was not edited.
- Review lenses: architecture, source fidelity, dependency direction, trust boundaries, library/API quality, and a separate pre-Lean theorem-card/reuse review of `DEF-001` revision 2.

## Verdicts

**Overall exact-snapshot verdict: REQUEST_CHANGES.**

The package pin and empty specification-stage Lean package are reproducibly buildable, and the governance/source architecture is substantially sound. However, the frozen classification authority contradicts the normative registry and validator, and the inventory validator accepts a forbidden confirmed 1997-occurrence-to-2010-preview-notation join. Those are specification-integrity defects, not editorial preferences.

**Separate DEF-001 revision-2 theorem-card verdict: APPROVE.**

This is one pre-Lean referee approval of the frozen card and its exact four signatures. It is not a composite gate pass, does not satisfy the two-reviewer quorum by itself, and does not authorize implementation.

## Required changes

### RC-1 — The frozen packet-level classification vocabulary is split-brain

Severity: high; specification-wide.

`review/classifications-v1.yaml:11-27` declares itself frozen but puts `exact_source_generic`, `named_application`, and `audit_source_recovery` under packet-level `theorem_class`, while packet-level `coverage_class` instead contains `direct_source`, `named_function`, and `audit_only`. That conflicts with all three of the following committed authorities:

- `blueprint/theorem_cards/README.md:19-30`, which treats `finite_remainder_bound` and `qualitative_bridge` as theorem classes and `exact_source_generic`, `named_source_application`, and `audit_source_recovery` as coverage classes;
- `blueprint/source_manifest.md:46-63` and `blueprint/function_inventory.md:112-118`, which prescribe the same separation; and
- the executable enum in `scripts/validate_inventory.py:470-482`, plus actual registry rows `blueprint/inventory/cards.csv:4-6`.

Consequently, future QL-001, OLV-001, and SR-001 artifacts cannot simultaneously conform to the declared frozen vocabulary and to the registry/validator. The current DEF-001 and QB-001 values happen to lie in the common subset, so ordinary validation does not expose the conflict.

Required disposition: issue a new classification schema revision (or correct and deliberately refreeze v1 before relying on it), make theorem-card prose, inventory documentation, registries, work-packet templates, and validator consume that single authority, and add a consistency test that every executable classification enum equals the frozen schema.

### RC-2 — The validator permits the exact cross-edition association that policy forbids

Severity: high; source provenance and future coverage credit.

The policy is unambiguous: the 2010 preview and locked 1997 edition are distinct, their relation is unresolved/non-equivalent, and no occurrence, transcription, notation, entity confirmation, or coverage may transfer (`blueprint/function_inventory.md:18-24`; `blueprint/inventory/edition_relations.csv:2`). The checked rows are currently honest and separate.

The enforcement is incomplete. `scripts/validate_inventory.py:722-742` checks the relation's own `join_semantics`, and `:793-820` checks only an occurrence against its own snapshot. It never checks whether an `occurrence_notations.csv` endpoint belongs to the occurrence's edition/snapshot or is connected through a fully matched equivalent edition relation. In a copied exact-snapshot table set, I added a `confirmed` association from locked occurrence `OLV97-C03-WATSON` to preview notation `OLV10P-N0001`; `validate_tables` returned zero errors. The five mutation tests at `scripts/validate_inventory.py:1105-1180` contain no cross-edition association case.

Required disposition: validate association provenance. Ordinarily, occurrence and notation snapshot editions should match; any cross-edition join must require an explicitly matched `equivalent` relation and whatever reconciliation evidence the policy selects. Add a negative fixture for the concrete 1997-Watson-to-2010-preview-notation mutation. Run the mutation suite in CI as well: `.github/workflows/ci.yml:17-18` currently invokes the validator without `--negative-tests`, although the suite only runs under that flag (`scripts/validate_inventory.py:1183-1210`). Apply the same provenance rule to every association table capable of transferring semantic confirmation or coverage.

## Smaller consistency corrections

These do not change the two principal reasons for `REQUEST_CHANGES`, but they should be fixed with the same specification revision.

1. `blueprint/theorem_cards/README.md:43-55,68-72` says every YAML card records every status axis, but frozen `blueprint/theorem_cards/QB-001.yaml:8-17` omits `prototype_status`. Record the intended value explicitly (apparently `absent`) or relax the normative requirement consistently.
2. `blueprint/theorem_cards/QB-001.yaml:209-212` says the packet awaits a *passing* structural-circularity gate. The frozen packet correctly marks that review `not_applicable` and requires external `not_required` (`review/work_packets/QB-001.yaml:317-332`); the protocol reserves `pass` for required composite gates and specifies `not_required` here (`review/PROTOCOL.md:31-34,125-149`). Correct the card prose so it cannot be read as demanding or accepting the wrong gate state.
3. `blueprint/automation/testing_and_ci.md:3` says current CI is only a baseline Lean build, while `.github/workflows/ci.yml:17-18` also runs the positive inventory validator. Update the status sentence when the validator/negative-suite enforcement is corrected.

## DEF-001 revision-2 pre-Lean theorem-card/reuse review

### Evidence identity

- Card: `blueprint/theorem_cards/DEF-001.yaml`, revision 2, committed SHA-256 `d0417e324649c3c89419d8bed84708c998a81a9b83e5a84e34ac0270caf4b7b3`, matching `review/work_packets/DEF-001.yaml:49-55`.
- Toolchain: `lean-toolchain:1`, `leanprover/lean4:v4.33.1`.
- Dependency request: `lakefile.toml:14-17`, Mathlib `v4.33.1`.
- Resolved Mathlib: `lake-manifest.json:4-13`, commit `0df444a360eaa60ab8c11dca51a86af692955474`; the local clean checkout used for the isolated build was exactly that commit, and `git ls-remote` mapped tag `v4.33.1` to it.
- Pinned source file SHA-256: `720a9a72d742fbe1c9a89601dc3a00d82c0261c7368c98cccb58307dbffe3bbf`, matching `review/work_packets/DEF-001.yaml:29-43`.

### Exact signature feasibility

I reproduced the four signatures at `review/work_packets/DEF-001.yaml:57-152` verbatim in a disposable file importing only `Mathlib.Analysis.SpecialFunctions.Gamma.Basic`. The following direct implementations compiled with no diagnostics under the exact pin:

| Target | Pinned Mathlib evidence | Verified implementation shape |
|---|---|---|
| `gamma_eulerIntegrable` | `Complex.GammaIntegral_convergent`, `Mathlib/Analysis/SpecialFunctions/Gamma/Basic.lean:84-103` | `exact Complex.GammaIntegral_convergent hs` |
| `gamma_eq_eulerIntegral` | exposed `Complex.GammaIntegral`, `:105-111`, and `Complex.Gamma_eq_integral`, `:319-320` | `simpa only [Complex.GammaIntegral] using Complex.Gamma_eq_integral hs` |
| `gamma_ofReal` | `Complex.Gamma_ofReal`, `:419-420` | `exact Complex.Gamma_ofReal s` |
| `gamma_neg_nat_eq_zero` | `Complex.Gamma_neg_nat_eq_zero`, `:338-351` | `exact Complex.Gamma_neg_nat_eq_zero n` |

The apparent `Real.exp`/complex coercions and the negative-natural coercion elaborate exactly; no stronger imports, added hypotheses, custom axioms, hidden choice, or duplicate Gamma object are needed. The two expanded-integrand targets are truthfully `equivalent_reformulation`; the two exact wrappers are truthfully `source_equivalent` because the external Mathlib target is specifically bound by revision, path, and digest. The natural-language-proof gate is correctly not required for these non-novel direct wrappers (`review/work_packets/DEF-001.yaml:197-203`), and the structural-circularity `not_applicable` reason is concrete and adequate (`:204-219`).

Therefore the separate card verdict is **APPROVE**.

## Build, digest, and baseline checks

- A fresh archive of the exact commit built successfully: `lake build` completed 1325 jobs.
- `python3 scripts/validate_inventory.py --negative-tests` passed the committed positive data and all five existing mutation fixtures: 24 occurrences, 2 notations, 10 entities, 16 associations; manifest totals `BOOTSTRAP-0=0`, `DEMO-0=0`, `OLV-MVP-1=1`.
- Every dependency checkout used by the isolated build matched the exact revision in `lake-manifest.json`; Mathlib's checkout was clean.
- Referenced frozen SHA-256 values for the classification schema, DEF card, QB card, QB signature artifact, QB proof, historical QB ledger, and pinned Gamma source all matched their committed bytes.
- The independently reproduced eight-signature QB surface compiled importing only `LMLF.Basic`. The wording at `blueprint/mathlib_audit.md:250-271` correctly limits that evidence to signature elaboration and explicitly denies implementation, proof-body, review, or authorization status.

## Areas verified clear

- **Trust boundary and timing:** `review/PROTOCOL.md:56-79,106-149` places commit/path/digest binding and all pass/authorization states in an external envelope after the candidate artifact is frozen. Candidate-owned status is explicitly nonauthoritative. No self-authorized passing gate was found.
- **2010 preview versus locked 1997 identity:** the actual committed occurrence/notation rows remain separated and provisional; the defect is the missing validator guard, not present contamination.
- **Structural/circularity schema:** representable, independently reviewed, perspective-aware, and correctly set to `not_required` only after a frozen `not_applicable` reason. The QB card sentence noted above is the sole inconsistency found.
- **EX-002:** `blueprint/methods/integral_laplace.md:42-54,325-335` labels it provisional, unregistered, and cardless; no registry row or source-credit claim exists.
- **Watson DAG:** the locked 1997 transcription and QB core feed only the selected minimal QL slice, with DEF/QL-002 conditional on the Gamma route, then OLV-001 and audit-only SR-001 (`blueprint/dependency_graph.md:103-128`; `blueprint/methods/integral_laplace.md:60-79,297-323`). No Airy/ODE/contour or audit-to-semantics inversion appears.
- **Bessel DAG:** the proposed route starts from a shared regularized `0F1` substrate, separates `J`/`I`, nonintegral `Y`/`K`, parameter continuation at integral orders, Hankel combinations, and later envelopes/applications (`blueprint/families/bessel_cylinder.md:158-194`). Its negative tests reject totalized sine division, equation-only identification, branch erasure, and circular imports (`:203-218`).
- **Library architecture:** the root package is intentionally a tiny specification-stage umbrella; definitions do not depend on estimates, generic methods do not import named applications, and audit/source-recovery modules are planned as downstream consumers. The empty current implementation makes no false theorem or release claim.

The requested corrections require a new frozen specification snapshot and fresh review binding; they must not be patched into an already reviewed digest in place.
