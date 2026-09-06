# Independent specification referee report

## Review identity and scope

- **Reviewer:** `spec_final_referee_a`
- **Model:** `gpt-5.6-sol`
- **Issued:** `2026-09-05T17:38:40Z`
- **Exact specification commit:** `f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de`
- **Repository named in the assignment:** `/home/codex/Documents/Codex/2026-09-05/yo`
- **Primary review tree:** `/tmp/lmlf-spec-f6e88abf.ix3gUJ`
- **Isolation strength:** `manual_attestation`
- **Isolation method:** fresh independent agent context; the exact commit was exported with `git archive` into a new directory without `.git`; all compilation probes and adversarial mutations were created only in that disposable export. The original checkout was used only to resolve/export the requested commit and inspect its tracked tree through commit-addressed Git commands. It was not edited. The checkout reported untracked `LMLF/Audit/` and `LMLF/Definitions/`; I did not inspect those dirty paths and did not use them as evidence. No prior review-report content was viewed or interpreted; the historical file's byte digest was recomputed solely to verify the packet's binding. This was not a technically enforced clean room: the runtime had a shared, writable filesystem and network access.
- **Archive digest:** SHA-256 of `git archive f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de` was `2730025d0a80ef9e953d89da0a2abe60f5717496548b4ee5a55fda86d28a254f`.

I read the complete 1,753-line attached brief at `/home/codex/.codex/attachments/6740fc8c-818a-4ce2-95bb-67293a5ba2bf/pasted-text.txt`, then audited the exact-commit blueprint, review protocol/templates/rubrics/work packets, inventory validator and CSV data, package roots, pins, and CI. I applied the `referee-lean-library` architecture/API/dependency rubric and used `referee-lean-proof` for the exact QB-001 and DEF-001 target signatures.

## Verdicts

| Subject | Verdict | Reason |
|---|---|---|
| Overall specification at the exact SHA | **REQUEST_CHANGES** | The architecture and governance are largely strong, but the currently implemented source-inventory validator admits authoritative-looking `resolved`/`confirmed` locked-edition states backed only by the expressly uninspected placeholder snapshot. This defeats a central provenance firewall. Two smaller truth/reproducibility issues should also be corrected. |
| QB-001 theorem card revision 5 | **APPROVE** | The card, eight-signature artifact, packet target list, classifications, import seam, and mathematical plans agree; the exact signatures elaborate at the pin. A stale nonnormative sentence in the legacy dossier should be cleaned up, but the rev5 target binding and exclusions resolve scope sufficiently for this card. |
| DEF-001 theorem card revision 3 | **APPROVE** | The four wrappers match exact pinned Mathlib declarations, compile under the declared narrow import, state the right half-plane and pole-totalization semantics honestly, introduce no second Gamma object, and correctly use pre-Lean `not_required` for the two inapplicable proof/structural gates. |

No issue found requires **BLOCK**. The overall P1 is localized and repairable without redesigning the mathematical architecture or either bootstrap card.

## Findings

### [P1] The executable source firewall accepts a resolved locked-edition occurrence whose only snapshot is an uninspected placeholder

The normative prose is appropriately strict: `blueprint/function_inventory.md:20-24` distinguishes editions from inspected snapshots and says `SRC-OLV-1997-COLLATION-PENDING` is not evidence of acquisition or inspection; `blueprint/qualitative/source_recovery.md:261-281` repeats that discipline; `blueprint/automation/contract_linting.md:146-161` says a placeholder is legal for planning but blocks a manifest-or-later gate. The concrete snapshot row is candid: `blueprint/inventory/source_snapshots.csv:3` has kind `locked_copy_placeholder`, availability `pending`, empty provenance/access and digest data, unresolved digest, unresolved edition reconciliation, and unresolved page mapping. The Watson row still points to it and records only a DLMF locator (`blueprint/inventory/occurrences.csv:25`).

The current executable validator does not enforce that boundary:

- `scripts/validate_inventory.py:973-1057` checks that an occurrence's edition equals its snapshot edition and, for a `resolved` occurrence, checks only row-local transcription/reconciliation fields. It never requires a non-placeholder/available snapshot, matched snapshot reconciliation, usable provenance, page mapping, or source-appropriate evidence type.
- `scripts/validate_inventory.py:1058-1073` requires confirmed notation/entity links only for `target_class == source_definition`, not for a resolved source theorem such as Watson.
- `scripts/validate_inventory.py:849-871`, especially lines 861-862, treats any two snapshot records assigned to the same edition as compatible, even if one is an unavailable, unreconciled placeholder.
- `scripts/validate_inventory.py:1075-1115` lets notation become `resolved`/`verified` without checking its snapshot state, then uses the permissive compatibility predicate for confirmed occurrence-notation links.
- The seven negative fixtures at `scripts/validate_inventory.py:1375-1496` exercise cross-edition preview joins but contain no same-edition placeholder/unavailable-snapshot case.

I reproduced both failures by mutating only in-memory copies loaded from the archive:

1. I reassigned an existing notation row to `SRC-OLV-1997-COLLATION-PENDING`, marked it `resolved`/`verified`, and added a `confirmed` link to `OLV97-C03-WATSON`. `validate_tables` returned `validation_errors 0`.
2. Independently, I changed the Watson occurrence to `resolution_status=resolved`, supplied syntactically complete fake transcription metadata, and changed its row reconciliation to `matched`, while leaving the snapshot as `SRC-OLV-1997-COLLATION-PENDING` and the evidence type as `dlmf_locator`. `validate_tables` returned `resolved_placeholder_errors 0`.

This is not an allegation that the committed CSV rows currently overclaim: they remain honestly unresolved, and OLV-MVP-1 remains planning-only. It is a demonstrated failure of the claimed machine firewall and negative-test suite. A future ordinary CSV edit could manufacture a green `resolved` locked-edition state without any inspected locked source.

**Required repair:** make strong states depend on strong snapshot evidence. At minimum, reject `resolved` occurrences, resolved notation, confirmed links, and confirmed entity evidence when a participating snapshot is a placeholder, unavailable/pending, or unreconciled to its assigned edition. A resolved locked-edition source theorem must also require direct-source evidence and the notation/entity association completeness promised by `blueprint/source_manifest.md:165-168`, rather than accepting a DLMF locator. Replace unconditional same-edition compatibility with same qualified snapshot, or with a separately represented and fully reviewed snapshot-equivalence relation. Add negative fixtures for (a) direct resolution against the locked placeholder and (b) same-edition confirmed joins through the placeholder.

### [P2] One family status heading says DEF-001 is implemented even though the exact commit deliberately has no implementation

`blueprint/families/gamma_related.md:4` labels DEF-001 under **“Existing implemented/card boundary”** and says it covers four thin wrappers. That wording conflicts with the actual and otherwise consistently reported state: `README.md:9-16` says the public modules provide structure only; `blueprint/theorem_cards/DEF-001.yaml:11-16,172-186` says `implementation_status: not_started`, `prototype_status: absent`, and `declarations_present: false`; `blueprint/dependency_graph.md:89-101` says no prototype is present; and the exact commit contains no wrapper declarations.

The archive inventory found four Lean files, 30 lines, and zero declarations. Commit-addressed searches found no `def`, `theorem`, `lemma`, `abbrev`, `structure`, `class`, `instance`, `axiom`, `opaque`, or `inductive`, and no `sorry`, `admit`, `unsafe`, or `implemented_by` marker in any tracked Lean file.

**Required repair:** rename `blueprint/families/gamma_related.md:4` to something unambiguous such as **“Existing registered-card boundary”** or **“Current card boundary; implementation absent.”** Do not change the truthful card/packet lifecycle state.

### [P2] The Lean/Mathlib graph is pinned, but the CI program that produces the evidence is not immutable

The mathematical dependency pin is good: `lean-toolchain:1` selects Lean `v4.33.1`; `lakefile.toml:14-17` requests Mathlib `v4.33.1`; `lake-manifest.json:4-13` resolves it to `0df444a360eaa60ab8c11dca51a86af692955474`; all inherited dependencies also have full resolved SHAs. `lake update` preserved the committed manifest byte-for-byte (SHA-256 `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`), and `lake build` succeeded.

However, `.github/workflows/ci.yml:13,16,22` uses the floating `ubuntu-latest` image and mutable third-party action tags `actions/checkout@v5` and `leanprover/lean-action@v1`. This is weaker than the objective-evidence reproducibility goal at `blueprint/automation/testing_and_ci.md:11-24`: identical repository bytes can execute changed action code without a repository change.

**Required repair:** pin third-party actions to reviewed full commit SHAs (retaining comments with the human-readable releases). If bit-for-bit runner reproducibility is an intended claim, also use a digest-pinned container/image; otherwise narrow the documentation to say that the Lean/Mathlib dependency graph is pinned but the hosted runner environment is not hermetic.

### [P3/advisory] The legacy QB proof dossier still contains stale public-API language that conflicts with its rev5 binding

The operative scope is clear and consistent: `blueprint/theorem_cards/QB-001.yaml:35-67` enumerates exactly eight declarations and excludes conversion/equivalence/algebra results; `blueprint/theorem_cards/QB-001-signatures.md:8-10` says there is no ninth declaration; `review/work_packets/QB-001.yaml:403-411` excludes every other dossier result; and `blueprint/proofs/QB-001.md:1094-1105` recognizes that unmapped sections remain outside the bootstrap. This matches the legacy-artifact rule that only bound target sections are normative (`blueprint/automation/proof_artifact_schema.md:171-179,186-199`).

Nevertheless, inside QB-001.5, `blueprint/proofs/QB-001.md:268-280` still says seven displayed equivalences are public, assigns them stable names, and says those names “freeze the public scope”; later, `blueprint/proofs/QB-001.md:710-747` calls additional product estimates separate public results. Those statements are stale under rev5. They do not enlarge the target list, so I do not withhold QB-001 approval, but they are a foreseeable source of reviewer/implementer error.

**Recommended repair:** on the next material proof-artifact revision, label all non-target material as prospective/future and remove claims that it freezes current public API. That revision must receive a new digest and fresh review binding; do not silently edit the frozen revision.

## Architecture and governance assessment

### Scope and dependency direction

The project correctly treats the attached brief as a programme rather than as an implemented library. It preserves the finite, exact, nonnumerical core: no evaluation, interval arithmetic, tolerance selection, quadrature, solver, or floating-point layer is present. The future graph in `blueprint/dependency_graph.md:13-59` has the right direction—foundations/domain support to construction and identification, then methods, applications, zero/connection consumers, and finally audit-only qualitative recovery. The forbidden reverse edges are explicit. Source recovery is a consumer, not a semantic dependency (`blueprint/qualitative/source_recovery.md:36-73`). Tactics are post-theorem opt-in leaves (`blueprint/dependency_graph.md:331-346`).

The exact package graph is acyclic and narrow:

```text
Mathlib.Analysis.Normed.Group.Basic -> LMLF.Basic -> LMLF.Definitions -> LMLF.Results
                                                    \_________________________^
LMLF root imports Basic, Definitions, Results
```

There are no accepted semantic declarations whose dependency closure could conceal circularity. QB-001 proposes only `LMLF.Basic` as its input. DEF-001 imports the exact Mathlib Gamma file directly and proposes no dependency on an estimate or project identification layer. The blueprint also explicitly identifies and quarantines overlapping provisional Airy/Bessel IDs (`blueprint/dependency_graph.md:161-164`) instead of treating them as accepted duplicate constructions.

### Proof-before-Lean and status authority

The gate vocabulary and authority separation are coherent. `review/PROTOCOL.md:13-34,56-79,113-169` distinguishes reviewer `approve` from composite `pass`, and `not_applicable` applicability from externally recorded `gate_state: not_required`. Candidate artifacts may describe intrinsic completeness but cannot set `lean_ready`. `review/templates/review_envelope.yaml:32-61` can represent both required/pass and not-applicable/not-required paths. QB-001 requires theorem-card and proof review and justifies structural inapplicability (`review/work_packets/QB-001.yaml:304-334`). DEF-001 gives concrete reasons for both proof and structural inapplicability, and its composite gate requires `not_required` for each (`review/work_packets/DEF-001.yaml:183-220`). That is the correct pre-Lean representation; neither card pretends those external gates have already passed.

`BOOTSTRAP-0` being `execution_ready` is not misused as implementation authorization: `blueprint/source_manifest.md:124-151` explicitly separates manifest readiness from reviews and Lean authorization. The exact-card status fields are truthful except for the isolated gamma-family heading reported above.

### Classification v2 and consumers

`review/classifications-v2.json:13-82` correctly separates packet and declaration levels and three independent axes. Its semantic rules prohibit treating internal proof agreement as source equivalence and prohibit classification from implying review/coverage/release (`review/classifications-v2.json:122-136`). The authority digest in both cards and both work packets is correct: `698626606570827fcc8c78b69865d7cd4bc94de96bc6d5d45c23a5f6611aeeab`.

I manually compared every one of the eight QB target triples and four DEF target triples between card and work packet; all match. The packet summaries also match the required v2 examples. DEF's `equivalent_reformulation` values are reserved for the two expanded integral wrappers, while exact pinned-library statements use `source_equivalent`; QB's routine definitions and consequences use `non_novel`.

The current executable consumer is intentionally partial, and the documentation says so accurately. `blueprint/inventory/cards.csv:1-6` has only packet theorem/coverage columns. `scripts/validate_inventory.py:633-638,1322-1358` loads allowed values for those two axes and checks only the source-card examples QL-001, OLV-001, and SR-001. It does not validate registry novelty, the QB/DEF positive examples, target-level triples, YAML joins, or artifact digests. This is disclosed at `blueprint/README.md:265-279`, `blueprint/source_manifest.md:194-197`, and `review/README.md:73-83`; therefore I do not treat the missing broader linter as an overclaim. A green inventory job is only a green inventory job.

### Edition/provenance state and current coverage

The committed data itself is conservative. The 2010 preview and locked 1997 edition have separate IDs and snapshots; the relation is unresolved/non-equivalent; the preview contributes provisional leads only; the 1997 snapshot is explicitly pending; Watson is selected but unresolved; and OLV-MVP-1 is planning-only with a denominator of one and zero recovered source claims. The positive validator and all seven existing negative fixtures pass. The P1 finding concerns what those checks fail to reject, not a false current coverage numerator.

## Card-specific review

### QB-001 revision 5 — APPROVE

- **Boundedness/API:** exactly three predicates and five transport theorems. The target function in `HasErrorFamily` is fixed outside the order index; no convergence, finiteness representation, or monotone improvement is implied (`blueprint/theorem_cards/QB-001.yaml:81-103`). Empty domains are intentionally allowed for infrastructure. The majorant direction, additive transitivity, and `Set.MapsTo` precomposition are natural and reusable.
- **Mathematics:** direct unfolding, equality, triangle inequality, monotonicity, and function composition reach all eight targets. No target-sized assumption, choice, hidden domain shrink, or totalization trick appears.
- **API shape:** namespace and binder order are conventional; `ErrorOn.comp` is correctly precomposition rather than unjustified nonlinear postcomposition. The import `LMLF.Basic` is minimal for the frozen interface.
- **Classification/source:** all targets are reusable infrastructure and non-novel; no Olver occurrence or named-object claim is attached.
- **Signature feasibility:** I copied the exact eight signatures into a disposable file, supplied direct proofs, and `lake env lean CheckQB.lean` exited 0 against Lean/Mathlib v4.33.1. This is feasibility evidence, not implementation or authorization.
- **Digest checks:** card `de0ed8cae076e7dfe074b4eacc0e5a8875e245c1ddedf8230851bbfd920f0ce4`; signature artifact `93e4e30a93087de95342abdb1e986676924cd93512e771737d0d3f3ed7973b39`; proof artifact `3513fb1acf141066eb9a4920c1ea238c778d66976ff8479d31c742df93d3a2a5`. These match the packet bindings at `review/work_packets/QB-001.yaml:45-66`. The packet's ordinary SHA-256 is `fb4942e10968e9bb53badb9352e668bd5460d6c482c27ea678cc72175ea9a86a` and is correctly intended for an external envelope, not self-embedded.

The P3 stale legacy prose should be corrected in a successor, but the rev5 card's exact target map, signature artifact, exclusions, and priority rule are sufficiently determinate to approve this card.

### DEF-001 revision 3 — APPROVE

- **Source identity:** this is an `existing_lean` reuse packet, not an Olver-source card. The packet binds Mathlib commit `0df444a360eaa60ab8c11dca51a86af692955474` and source file SHA-256 `720a9a72d742fbe1c9a89601dc3a00d82c0261c7368c98cccb58307dbffe3bbf`; both independently matched.
- **Exact source declarations:** the pinned file states `Complex.GammaIntegral_convergent` at lines 87-103, expands `GammaIntegral` at 105-111, states `Complex.Gamma_eq_integral` at 319-320, documents and proves negative-natural totalization at 338-354, and states `Complex.Gamma_ofReal` at 419-420. The card cites precisely those facts.
- **Semantics:** the Euler pair keeps `0 < s.re`; the positive real integration variable makes the complex-power branch honest; global real agreement is exactly Mathlib's theorem; and `Gamma (-(n : ℂ)) = 0` is explicitly described as a totalized value at a classical pole, including `n=0`. No analytic-continuation theorem, pole-free identity, or source occurrence is overclaimed.
- **API/reuse:** one narrow definition-family module, exactly four readable wrappers, no second Gamma construction. The family plan leaves recurrence/reciprocal/incomplete-Gamma work to later bounded cards. This is a defensible bootstrap slice of the attached brief's Gamma audit surface.
- **Signature feasibility:** direct `simpa only`/`exact` proofs of all four exact signatures compiled with `lake env lean CheckDEF.lean` at the pin. This is feasibility evidence only.
- **Gate applicability:** a new natural-language mathematical proof and an independent structural/circularity gate are genuinely unnecessary for four transparent pinned wrappers; theorem-card review and later source/reuse/API implementation review remain required. The packet represents this with applicability `not_applicable` and external gate requirement `not_required`, never with candidate-owned `pass`.
- **Digest checks:** card `b6515349f7fb4d8d8dbc26bf7c24f3e1f6c6d02106ea8200c068282d6ada9dfc`, matching `review/work_packets/DEF-001.yaml:50-56`. The work packet SHA-256 is `b01d22701a0284a968465ebb79c05430289ce22ee7a575244ec05ba7e8dc38e8`.

## Build, pin, inventory, and implementation evidence

- `lake update` checked out Mathlib at the exact manifest SHA and did not change the manifest digest.
- `lake build` completed successfully: `Build completed successfully (1325 jobs).`
- `python3 scripts/validate_inventory.py` passed with 24 occurrences, 2 notations, 10 entities, 10 entity-evidence rows, 16 associations, and manifest totals `BOOTSTRAP-0=0`, `DEMO-0=0`, `OLV-MVP-1=1`.
- `python3 scripts/validate_inventory.py --negative-tests` reported seven intentionally invalid copied fixtures rejected, then the positive validation passed.
- Exact signature probes for QB-001 and DEF-001 both exited 0.
- The exact commit genuinely contains no semantic implementation. `LMLF/Basic.lean:1-7`, `LMLF/Definitions.lean:1-7`, and `LMLF/Results.lean:1-7` are import/doc stubs; `LMLF.lean:1-9` only imports them. The `lakefile.toml:19-21` target glob lists only those public modules. No dirty-worktree bytes were used.

## Commands recorded

The following are the material commands I ran. Inspection also used `nl -ba`, `sed -n`, `rg`, `find`, `wc -l`, and `sha256sum` on exact-archive files and the complete attached brief.

```sh
git -C /home/codex/Documents/Codex/2026-09-05/yo rev-parse f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de^{commit}
git -C /home/codex/Documents/Codex/2026-09-05/yo status --short --branch
git -C /home/codex/Documents/Codex/2026-09-05/yo worktree list --porcelain

review_tree=$(mktemp -d /tmp/lmlf-spec-f6e88abf.XXXXXX)
git -C /home/codex/Documents/Codex/2026-09-05/yo archive f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de | tar -x -C "$review_tree"
git -C /home/codex/Documents/Codex/2026-09-05/yo archive f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de | sha256sum
test ! -e "$review_tree/.git"

/home/codex/.codex/skills/referee-lean-library/scripts/library_inventory.sh "$review_tree"
git -C /home/codex/Documents/Codex/2026-09-05/yo ls-tree -r --name-only f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de
git -C /home/codex/Documents/Codex/2026-09-05/yo grep -n -E '(^|[^[:alnum:]_])(def|theorem|lemma|abbrev|structure|class|instance|axiom|opaque|inductive)[[:space:]]' f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de -- '*.lean'
git -C /home/codex/Documents/Codex/2026-09-05/yo grep -n -E '\b(sorry|admit|unsafe|implemented_by)\b' f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de -- '*.lean'

cd /tmp/lmlf-spec-f6e88abf.ix3gUJ
python3 scripts/validate_inventory.py
python3 scripts/validate_inventory.py --negative-tests
lake update
git -C .lake/packages/mathlib rev-parse HEAD
sha256sum .lake/packages/mathlib/Mathlib/Analysis/SpecialFunctions/Gamma/Basic.lean
lake build
lake env lean CheckQB.lean
lake env lean CheckDEF.lean
python3 CheckFirewall.py

sha256sum review/classifications-v1.yaml review/classifications-v2.json \
  blueprint/theorem_cards/QB-001.yaml \
  blueprint/theorem_cards/QB-001-signatures.md \
  blueprint/proofs/QB-001.md \
  blueprint/theorem_cards/DEF-001.yaml \
  review/work_packets/QB-001.yaml review/work_packets/DEF-001.yaml \
  lake-manifest.json
git -C /home/codex/Documents/Codex/2026-09-05/yo show f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de:lake-manifest.json | sha256sum
```

`CheckQB.lean`, `CheckDEF.lean`, and `CheckFirewall.py` existed only in the disposable archive tree. They were not added to or copied into the repository.

## Digest convention

An ordinary file cannot contain its own final SHA-256 without changing that digest. I therefore append below a payload digest covering every byte of this report before the digest line. The ordinary SHA-256 of the final file is recorded externally in the handoff that identifies this report.

**Report payload SHA-256 (all preceding bytes):** `70f7ddf32b4e53947933c6b85bc38a0bee31321494ff242f1eae9e246ebfd9be`
