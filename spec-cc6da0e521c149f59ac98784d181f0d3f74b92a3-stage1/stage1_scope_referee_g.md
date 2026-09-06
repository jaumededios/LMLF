# Stage 1 DLMF-through-10 architecture/source-scope review — referee G

## Verdict

`request_changes`

The proposal has a strong source-accounting and quantitative-first architecture, and the official DLMF discovery checks support its factual sentinels. Two bounded but material control-plane conflicts remain: the repository would retain two incompatible global meanings of “Stage 1,” and it does not give direct qualitative/structural DLMF targets an unambiguous library layer. These are specification defects, not demands for the absent census, schema serialization, validator, theorem cards, or Lean implementation.

## Review identity and snapshot

- Reviewer ID: `stage1_scope_referee_g`
- Reviewer kind: `agent`
- Model: `gpt-5.6-sol`
- Reasoning effort: `high`
- Review perspective: complete blueprint architecture/source-scope review, with source semantics, dependency direction, quantitative obligations, and lifecycle authority checked together
- Candidate commit: `cc6da0e521c149f59ac98784d181f0d3f74b92a3`
- Candidate subject: `Freeze Stage 1 canonical source and audit revision plan R4 [skip ci]`
- Review started: `2026-09-06T18:06:50Z`
- Review completed: `2026-09-06T18:14:11Z`
- Review runtime: `441 seconds` (`00:07:21`)
- Isolation strength: `manual_attestation`
- Isolation method: a newly created clean detached Git worktree at `/tmp/lmlf-ref-g.UZw8VN/wt`, checked out at the exact candidate commit; fresh reviewer session; read-only candidate inspection; report written only to the external evidence path.
- Isolation limits: this was not a hardened clean-room runner. The runtime had network access and writable filesystem access and did not technically exclude personal instructions, plugins, credentials, or visibility of shared filesystem metadata. I did not inspect predecessor R1/R2/R3 plan contents, predecessor reports/dispositions, peer reports, uncommitted candidate work, other worktree contents, or Verso work. Recent history was viewed only as commit subjects/SHAs, and the exact candidate commit was viewed only as a six-path name/status list.
- No predecessor approval or peer verdict was transferred.

## Exact six-file binding

All supplied SHA-256 values matched bytes in the detached snapshot.

| Artifact | SHA-256 |
|---|---|
| `blueprint/stage_1_dlmf-R4.md` | `31bebd1880ea64b4e5dccc2683bf9e243cd975ce76a11ce566035a108d689afb` |
| `README.md` | `1b6a75a6fa64352014f256aa22750ae099ef4626795962f8e1c47189c1180be5` |
| `blueprint/README.md` | `a5fd4385ab8c4012307564a879ab85f05313db887610a0e831201821b86f90f2` |
| `blueprint/roadmap.md` | `e2dc5b9d1efe9af013158af511456d6a7b13538d82637a3fa1a40a6a34cb377f` |
| `blueprint/design_decisions.md` | `fd8bf1fb4befb2929816b1a4558f4ed1f24c510a75348e3d46047639250436a7` |
| `blueprint/source_manifest.md` | `d91f7aed03454ce24ed0a63e1f055848eb63e1a7fea1a3147b99ee1479b97d23` |

`git show --name-status` confirms that the pinned commit modifies/adds exactly those six paths. The worktree remained detached and clean after all checks.

## Material findings

### G1 — P1 — The successor leaves two operative global definitions of “Stage 1”

**Evidence.** `blueprint/stage_1_dlmf-R4.md:23-26` defines Stage 1 as the DLMF-through-Chapter-10 programme. Its precedence rule at `:48-90` says that only enumerated programme-priority/scheduling clauses are superseded and expressly says, “No other clause is superseded.” The enumerated qualitative-document changes cover only the “initial source target” sentence in `blueprint/qualitative/release_strategy.md:314-319` and the Watson “first true source-facing success” sentence in `blueprint/qualitative/navigation_and_docs.md:392-408`.

However, the still-operative release authority has a heading `Stage 1 — single-occurrence source pilot` and defines it as the one-occurrence Olver Watson release at `blueprint/qualitative/release_strategy.md:98-120`. That entire Stage 1 definition is not among the superseded or expressly track-local clauses. In the six-file successor itself, `blueprint/README.md:14-17` also continues to state the unqualified global metadata field `Source target: F. W. J. Olver ... 1997`; R4 neither supersedes nor explicitly narrows that field, even though R4 names DLMF 1.2.7 as the provisional Stage 1 source target.

**Cost.** Once DD-021 becomes effective, “Stage 1 complete,” “Stage 1 release,” and “Stage 1 source target” would have incompatible authoritative readings: full DLMF Chapters 4–10 versus one Olver occurrence. That ambiguity reaches release manifests, completion claims, dashboard labels, and amendment authority; it is not merely terminology.

**Required change.** Give the legacy release ladder a clearly qualified namespace (for example, “Olver release stage 1”) or add its `Stage 1 — single-occurrence source pilot` definition and the global `blueprint/README.md` source-target field to DD-021’s exact track-local/superseded list. The resulting authority should make it impossible for an unqualified “Stage 1” to mean Watson after DD-021 activates, while preserving `OLV-MVP-1` as a parallel Olver-track packet.

**Blast radius and verification.** Documentation/control-plane only; no census, schema, or Lean change is needed. Re-run a repository search for unqualified `Stage 1`, `source target`, `initial source`, and `first source` claims and verify that every surviving use is either the DLMF programme or explicitly Olver-track-local. Confidence: high.

### G2 — P1 — Direct structural DLMF targets have no unambiguous semantic-versus-audit placement

**Evidence.** R4 creates `ordinary_exact_or_structural` as a primary obligation class (`blueprint/stage_1_dlmf-R4.md:445-465`) and expressly says that analyticity, continuation, monotonicity, sign, uniqueness, and zero structure remain ordinary semantic targets rather than being converted to error bounds (`:504-507`). Stage 1 completion then requires accepted declarations and reviewed evidence for the target/card set (`:565-587`).

The retained package contract points the other way. `blueprint/README.md:19-23` says the reusable public mathematics is finite and quantitative and that source-faithful qualitative consequences are separate consumers under `Audit/SourceRecovery`. DD-003 (`blueprint/design_decisions.md:38-46`) says public mathematical results use finite identities and explicit inequalities, with qualitative source-recovery bridges allowed only in `Audit/SourceRecovery`. The release product split likewise describes the semantic core as identified functions, exact identities, finite approximants, and explicit bounds, while assigning qualitative source recovery to the audit companion (`blueprint/qualitative/release_strategy.md:44-55`). R4 says no non-enumerated clause is superseded.

**Cost.** A direct DLMF assertion such as analyticity, monotonicity, or uniqueness is explicitly a Stage 1 target but can be read as forbidden from the semantic public layer or forced into the audit-only recovery layer. That would either reverse the intended dependency direction (reusable mathematics living under `Audit`) or leave ordinary structural occurrences without a legal declaration placement. This affects a large class of Chapter 4–10 claims and therefore blocks a stable module/API map.

**Required change.** State one rule consistently across R4, DD-003, the blueprint index, and the release-product contract. The natural resolution is: direct reusable exact/structural theorems belong to semantic modules; only source-notation restatements or qualitative consequences whose role is `faithful_source_recovery` belong to `Audit/SourceRecovery`; the audit layer may import the structural semantic theorem, never conversely. If a different placement is intended, R4’s target mappings and completion predicate must say so explicitly.

**Blast radius and verification.** Bounded architecture prose now, but it determines later module boundaries. Test the clarified rule on at least one direct analyticity occurrence, one monotonicity/sign occurrence, one uniqueness occurrence, one ordinary exact identity, and one asymptotic occurrence with finite producer plus recovery consumer. Confidence: high.

## Checks performed

- Read all six bound artifacts in full (2,337 lines, 143,343 bytes total).
- Searched the detached snapshot for applicable `AGENTS.md`; none exists.
- Read the complete local `referee-lean-library` skill, its complete global rubric, and its workflow research basis.
- Read the complete current theorem-card status contract, function/occurrence inventory protocol, review package index, proposer/referee protocol, all five current review rubrics, and local Mathlib feasibility audit.
- Read the operative legacy release-strategy and navigation clauses needed to test DD-021’s exact supersession list, including the existing staged-release definition and source-target/documentation clauses.
- Ran the skill’s deterministic library inventory. It found seven Lean files, 210 lines, three definitions, eighteen theorems, the intended foundation → definitions/results direction, and a separately consuming audit module; no trust/resource marker was reported.
- Ran `python3 scripts/validate_inventory.py`: exit 0; 148 occurrences, 31 notations, 32 entities, 34 entity-evidence rows, 88 occurrence associations; manifest totals validated.
- Ran `python3 scripts/validate_inventory.py --negative-tests`: exit 0; all 25 intentionally invalid copied fixtures were rejected.
- Ran `git diff --check`: exit 0.
- Rechecked `git status --short --branch`: clean detached `HEAD`.
- Recomputed all six SHA-256 values after checks: unchanged and matching.
- Did not run GitHub CI. No production build was necessary for this docs-only scope review; no Lean implementation is submitted by this candidate.

## Official DLMF discovery verification

Only official primary DLMF/NIST pages were used for web verification.

- The [DLMF root](https://dlmf.nist.gov/) and [project news](https://dlmf.nist.gov/about/news/) report version 1.2.7 with release date 2026-06-15; the [errata](https://dlmf.nist.gov/errata/) page was also consulted.
- Official chapter landings [4](https://dlmf.nist.gov/4), [5](https://dlmf.nist.gov/5), [6](https://dlmf.nist.gov/6), [7](https://dlmf.nist.gov/7), [8](https://dlmf.nist.gov/8), [9](https://dlmf.nist.gov/9), and [10](https://dlmf.nist.gov/10) support the titles and terminal numbered sections stated in R4, including software sections 4.48, 5.24, 6.21, 7.25, 8.28, 9.20, and 10.77.
- [DLMF §4.13](https://dlmf.nist.gov/4.13) explicitly contains branches `W_k`, legacy `Wp`/`Wm`, Wright omega, and Tree `T`, with branch-side conventions that justify R4’s cautious entity/alias treatment.
- [DLMF §5.18](https://dlmf.nist.gov/5.18) contains q-factorials, q-Gamma, the prose q-digamma/q-psi lead, and q-Beta.
- [DLMF 7.SB1](https://dlmf.nist.gov/7.SB1) is a standalone sidebar payload with a mathematical Fresnel-intensity assertion, validating the need not to assume only numeric section tiers.
- [DLMF §9.12](https://dlmf.nist.gov/9.12) contains Scorer functions. [DLMF §9.14](https://dlmf.nist.gov/9.14) defines incomplete Airy functions by internal cross-reference and separately points outward for further results, matching R4’s assertion/reference-lead distinction.
- [DLMF §10.46](https://dlmf.nist.gov/10.46) explicitly defines generalized Bessel `phi` and Mittag–Leffler `E`, contains the underspecified Laplace-transform sentence, and gives only an external-reference lead for incomplete modified Bessel/Hankel functions. [§10.47](https://dlmf.nist.gov/10.47) and [§10.61](https://dlmf.nist.gov/10.61) support the spherical/modified-spherical and Kelvin sentinels.
- Direct opens showed that `https://dlmf.nist.gov/10.61.i` and `https://dlmf.nist.gov/10.61.E1` both redirect to `https://dlmf.nist.gov/10.61`, supporting R4’s locator-versus-payload negative fixture.

These checks validate discovery facts only. They are not a production source census, per-document byte snapshot, complete atomicization, or occurrence denominator.

## Rubric disposition

- Mathematical intent and scope: clear apart from G1. The Chapters 1–3 selective-support boundary and Chapters 4–10 exhaustive mathematical-assertion boundary match the user-authorized programme.
- Source occurrence denominator and lifecycle: clear. Source-owning leaves, semantic atomicization, repeated appearances, shared context, partial local targets, explicit global closure, and typed append-only correction/evolution are coherently separated.
- Quantitative/source-recovery architecture: clear. Every asymptotic/approximation target has a mandatory finite producer and distinct faithful recovery consumer, without inventing qualitative claims for already finite source estimates.
- Entity, branch, normalization, and totalization treatment: clear. The Lambert sentinel is especially useful and source-supported.
- Finite execution without a whole-census bottleneck: clear. Reviewed local `Target(S,B)` values can feed separate finite Lean manifests before global `Target(S)` exists.
- Immutable source/audit identity and source-track isolation: clear. IDs are snapshot-wide, audit revisions pin exact views, predecessor identities remain historical, and DLMF/Olver credit cannot transfer without an explicit semantic crosswalk.
- Scope amendment authority: clear after G1 is repaired. The exact six-file activation gate, material-edit invalidation, and root external adjudication are otherwise adequate.
- Proof-before-Lean and trust boundary: clear. New mathematics requires complete natural-language proof and fresh external reviews before signatures/Lean, and candidate-owned status cannot self-authorize.
- Mathlib integration: clear at blueprint level. Existing controls require local/pinned reuse checks, accepted object identification, narrow dependencies, and explicit support closure; no function-by-function implementation audit is required in this planning candidate.
- Module/dependency design and read-only Verso: clear apart from G2. Quantitative semantics flow into `Audit/SourceRecovery`, and R4 correctly makes Verso a read-only projection that cannot approve, mutate, or define truth.
- Reusable extraction/deletion/local-proof handoff: no action at this docs-only planning stage. There is no submitted Stage 1 Lean surface to refactor, delete, or golf.

## Acceptance condition for rereview

A fresh exact-byte review should confirm that both global naming/authority and structural-target placement are single-valued after the amendments. Passing the existing inventory checks again is useful regression evidence but cannot itself resolve either finding.
