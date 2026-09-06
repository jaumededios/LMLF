# Independent final pre-Lean review J

## Verdict

**Overall: REQUEST_CHANGES.**

The frozen QB-001 and DEF-001 specifications are mathematically sound, bounded,
digest-consistent, and independently compilable against the recorded pin.  Their
individual pre-Lean reviews below are `APPROVE` (or a confirmed
`not_applicable`, where the frozen packet says so).  The overall commit cannot be
approved because a novel composed mutation exposes a material source-manifest
closure hole in the executable CSV validator: it accepts a closed,
`execution_ready`, positive-source manifest whose source selection is explicitly
unlocked and whose only member cards provide no source-target/recovery coverage.

This report does **not** set or imply `lean_ready`.  The repository correctly
records both packets as externally unreviewed and unauthorized, and the one
review recorded here cannot satisfy their two-distinct-reviewer theorem-card or
QB proof-review quorums.  A repair creates a new specification commit and, under
the repository's own invalidation rule, requires fresh bound verdicts.

## Review identity and isolation

- Reviewer ID: `prelean_final_j`.
- Model/runtime: OpenAI Codex, GPT-5 family, desktop agent runtime.  The runtime
  did not expose a more specific immutable backend model identifier, so none is
  invented here.
- Isolation strength: `manual_attestation`.
- Isolation method: fresh-context referee session; no other referee was
  contacted; a new `git archive` of the exact requested commit was extracted to
  `/tmp/lmlf-prelean-final-j.4qNB2x/source`; all generated Lean fixtures and
  dependency downloads remained in that disposable tree or its parent.
- Candidate repository: `/home/codex/Documents/Codex/2026-09-05/yo`.
- Exact reviewed commit: `3fa70a7e482ddfe03d3db77262f534dcd4b56a7e`.
- Commit tree: `7b514811cbd285e681d42815fc62e12572ef833f`.
- Commit parent: `d0aa1c55967d7cde7187f5c8b7a05b76d7043fe5`.
- Archive SHA-256:
  `b0349086e3e0f94d9a3f50dcfb25a9e0b7058ab33508cbb2b1f091cba6362d7e`.
- Live-worktree preflight reported untracked `LMLF/Audit/` and
  `LMLF/Definitions/`.  I did not open them and did not use them as evidence.
  I did not open the historical `blueprint/reviews/QB-001-rev3.md` review.
- Candidate edits: none.  The only persistent write is this external report.

I applied the full `referee-lean-library` rubric first, including its global
architecture, dependency, API, reuse, durability, and refactor-risk sections,
then the full `referee-lean-proof` rubric to the eight QB declarations and four
Gamma wrappers.  This ordering kept architectural decisions frozen before the
local independent compilations.

## Gate-by-gate decisions

| Scope | Referee decision | Reason |
|---|---|---|
| Overall exact commit | **REQUEST_CHANGES** | Finding G1 permits a false closed/ready source-manifest state. |
| Modular mathematical architecture and dependency/circularity plan | **APPROVE** | Layers flow from pins/source evidence to foundations/constructions/identifications/methods/applications/audits; the Watson path remains narrow; source recovery is downstream; no definition depends on its asymptotic consumer. |
| Classification-v2 artifact and present packet/card bindings | **APPROVE** | Frozen revision 2, separate packet/target axes, required-versus-illustrative registry semantics, immutable-v1 digest, and every current embedded v2 digest agree. |
| External gate representation and packet quorum rules | **APPROVE** | Required and inapplicable NLP/structural gates are representable as `pass` versus justified `not_required`; per-gate distinct-ID compositions, model minima, overall reviewer unions, exact artifact bindings, verdict perspectives, invalidation, and external storage are expressible. This is manual protocol, not an implemented quorum checker. |
| Current 78-row canonical CSV inventory state | **APPROVE** | Current rows truthfully remain provisional/unresolved where source bytes, collation, notation, or identity are missing; BOOTSTRAP-0 has zero source occurrences; positive validation passes. |
| Executable source-evidence/manifest validator | **REQUEST_CHANGES** | The 23 committed negative fixtures pass, but novel composed closure mutation G1 is accepted with zero diagnostics. |
| CI pinning and stated reproducibility boundary | **APPROVE** | Both actions are commit-pinned and match their named major tags; Lean/Mathlib pins and the Gamma source digest resolve exactly. The `ubuntu-latest` non-hermetic caveat is explicit and accurate. |
| QB-001 theorem-card review (card rev 7 / packet rev 4 / signatures rev 2) | **APPROVE** | Exactly three definitions plus five lemmas, correct classifications, imports, binders, fixed-target family semantics, assumptions, exclusions, and dependency direction. |
| QB-001 natural-language-proof review (proof rev 6) | **APPROVE** | Each target T01--T08 has one exact stable anchor; all five arguments rederive; edge cases and false nearby statements are correct; all other dossier material is explicitly prospective. |
| QB-001 structural-circularity applicability | **APPROVE `not_applicable` rationale** | Direct predicates and set/norm transports contain no construction, continuation, named identification, choice, or theorem-sized hypothesis object. |
| DEF-001 theorem-card/reuse/source-semantics review (card rev 4 / packet rev 3) | **APPROVE** | Four exact wrappers reuse `Complex.Gamma`; right-half-plane domains, Euler integrand, real agreement, and pole totalization match pinned source; no duplicate Gamma object is proposed. |
| DEF-001 natural-language-proof applicability | **APPROVE `not_applicable` rationale** | These are transparent, non-novel wrappers around four specifically named and digest-bound Mathlib facts. |
| DEF-001 structural-circularity applicability | **APPROVE `not_applicable` rationale** | No construction, analytic continuation, existence/uniqueness choice, or theorem-sized assumption is introduced. |
| Implementation-stage gates for QB-001 and DEF-001 | **NOT EVALUATED / NOT YET APPLICABLE** | Exact commit contains no implementation of either packet; candidate head and prior external `lean_ready` evidence do not exist. |

## Finding

### G1 / P1 — Closed source manifests do not require locked selection or an in-manifest source card

Files: `scripts/validate_inventory.py`, especially lines 1547--1578 and
1580--1652; contract contradicted by `blueprint/source_manifest.md`, especially
the closed-manifest rule at lines 68--84.

The validator checks source-dependent cards in the forward direction: a ready
source-dependent card must have source links.  It does not check the reverse
closure condition: a `source_coverage` occurrence in a closed/ready manifest
must be served by an exact-source or named-application card belonging to that
same manifest (and, where required, its source-recovery card).  Separately,
lines 1607--1620 reject `not_applicable` for a positive source total but accept
`occurrence_selection_locked: false` even when `scope_closed: true` and
`manifest_status: execution_ready`.

I constructed an in-memory copy of the valid tables, added a syntactically
source-ready locked-1997 Watson snapshot, an independently reviewed page audit
covering printed pages 71--72, verified transcription metadata, and compatible
confirmed notation/entity provenance.  I then moved the sole
`source_coverage` association to `BOOTSTRAP-0`, changed its declared source
total to 1, and set `occurrence_selection_locked` to `false`.  I left
BOOTSTRAP-0's only member cards as the existing `QB-001` infrastructure card and
`DEF-001` entity-identification card.  To preserve all unrelated totals I set
the now-empty planning OLV-MVP-1 source total to 0 and its selection state to
`not_applicable`.

Observed result:

```text
errors 0
```

Thus a green validator can describe this false state as a closed,
execution-ready source manifest despite unlocked occurrence selection and no
same-manifest source target.  This is not merely the documented inability to
verify inaccessible source bytes: every syntactic source-evidence premise was
made valid, and the bypass is in manifest/card closure.

Required repair:

1. For every positive-source manifest with `scope_closed: true` or status
   `execution_ready`, `active`, or `complete`, require
   `occurrence_selection_locked: true`.
2. For every `source_coverage` occurrence in such a manifest, require a
   confirmed `occurrence_cards` association to an appropriate
   `exact_source_generic` or `named_source_application` member card in the same
   manifest, with the role matching the coverage class.  Enforce any required
   `audit_source_recovery` member similarly at the lifecycle level where the
   contract demands it.
3. Add isolated negative fixtures for (a) unlocked closed selection, (b) a
   ready source occurrence attached to a manifest with only infrastructure or
   entity-identification cards, and (c) a source card associated to the
   occurrence but registered in a different manifest.
4. Rerun the positive suite, the existing 23 mutations, and the new mutations.

Confidence: high.  Blast radius is confined to source-manifest validation and
its tests; the present QB/DEF mathematics does not change.

## Classification and planning-row audit

- `review/classifications-v2.json`: artifact revision 2, frozen, SHA-256
  `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9`.
- Its recorded immutable v1 SHA-256
  `7a4f322bb56dbb40d5d44a7eceb50b5a49ea6ae69f414b920341e3b12ea9d71e`
  matches the committed `review/classifications-v1.yaml` bytes.
- The canonical inventory contains 78 data rows across 14 CSV tables.  The
  blueprint Markdown table universe contains exactly **88 unique first-column
  planning/control IDs** in 90 mentions; only `QB-001` and `DEF-001` occur
  twice, consistently as the two current registered items.  SHA-256 of the
  newline-separated sorted 88-ID set is
  `f30ec0589b375d29ca53bda9d806e6b4d7ceb2d44b24e186c83ebb3948fe76e7`.
- All packet-level classification values used in those tables are in the v2
  packet vocabulary.  Rows explicitly saying classification is pending remain
  planning prose rather than frozen card classifications.
- The five registry-required examples QB-001, DEF-001, QL-001, OLV-001, and
  SR-001 match `cards.csv`; illustrative `NAMED-EXAMPLE` correctly creates no
  row obligation.

## QB-001 independent proof audit

Bindings verified byte-for-byte:

| Artifact | Revision | SHA-256 |
|---|---:|---|
| `blueprint/theorem_cards/QB-001.yaml` | 7 | `827522349afc7374a8bec60b3d281c192a44189f8e8c08c24e453bf75e215667` |
| `blueprint/proofs/QB-001.md` | 6 | `42b027310a56ff70f4c56471de527aa9b6a3ac88810ad3ba17029953514c1589` |
| `blueprint/theorem_cards/QB-001-signatures.md` | 2 | `93e4e30a93087de95342abdb1e986676924cd93512e771737d0d3f3ed7973b39` |
| `review/work_packets/QB-001.yaml` | 4 | `7a56a1695d15ea2cedd525ee4270d20830e1706827bb592dfde293bcd7d54c39` |

Each exact anchor `qb-001-t01-erroron` through
`qb-001-t08-erroron-comp` occurs once as an HTML anchor and once in the
normative target table.  The card, packet, signatures, and proof map the same
target ID/declaration/anchor tuple.

I independently wrote and compiled all eight declarations from only
`import LMLF.Basic`; I did not use a prior prototype.  The exact signature
fixture SHA-256 was
`03d04f35b057efefb93067a81ebcb1314ffbbcb9543c4ac8256eda6c3678da86`.
Compilation exited 0 with empty stderr.  `#print axioms` reported exactly
`[propext, Classical.choice, Quot.sound]` for each declaration, within the
packet allowlist.  No warning remained after rejecting a linter-noisy local
candidate.  The proof skeletons were:

- T04: rewrite by `Set.EqOn`, then `norm_zero`;
- T05: apply the original bound after subset inclusion;
- T06: transitivity of `<=` pointwise;
- T07: the additive difference identity, `norm_add_le`, then `add_le_add`;
- T08: apply the original bound at `psi y` using `Set.MapsTo`.

No weaker structure than `NormedAddCommGroup E` naturally supports every
target together, and none of the proposed assumptions is unused or hides the
conclusion.  There is no local proof-quality finding.

## DEF-001 pinned-source and compilation audit

Bindings verified byte-for-byte:

| Artifact | Revision | SHA-256 |
|---|---:|---|
| `blueprint/theorem_cards/DEF-001.yaml` | 4 | `eff82b06afaa61b67d13c3a399494525ed452e42c203a390ba40e56b93ec9daa` |
| `review/work_packets/DEF-001.yaml` | 3 | `6dbda13f4f27dd4c0492c00ecc0a2d184f00fe85fa7096802cf93e9fdecf11e8` |
| pinned Mathlib `Gamma/Basic.lean` | commit below | `720a9a72d742fbe1c9a89601dc3a00d82c0261c7368c98cccb58307dbffe3bbf` |

Resolved Mathlib commit was exactly
`0df444a360eaa60ab8c11dca51a86af692955474`.  Direct source inspection
confirmed:

- `Complex.GammaIntegral_convergent` has hypothesis `0 < s.re` and the exact
  `Set.Ioi 0` complex Euler integrand;
- `Complex.Gamma_eq_integral` identifies `Complex.Gamma s` with
  `Complex.GammaIntegral s` on that half-plane;
- `Complex.Gamma_ofReal` holds for every real input under Mathlib's same total
  functions;
- `Complex.Gamma_neg_nat_eq_zero` states the exact proposed negative-natural
  equality, while its source comment explicitly says the classical function is
  undefined there and zero is assigned by convention.

I independently compiled the four exact proposed wrappers.  The fixture
SHA-256 was
`b049c734d252b255bcd637551b5abb6eb74af78097bc5a46a17e1b730bdabf7d`;
exit status was 0 with empty stderr.  Each axiom report was exactly
`[propext, Classical.choice, Quot.sound]`.  T01/T02 unfold only
`Complex.GammaIntegral`; T03/T04 directly reuse the named pinned theorems.
The Euler formulas are not extended outside `0 < s.re`; the real wrapper
correctly includes totalized exceptional inputs; and T04 calls zero a
totalization at classical poles.  The packet declares no project Gamma
definition, and the exact commit contains none.

## Exact implementation-state audit

`lake build` succeeded for the exact archive (`1325` jobs).  The only committed
files below `LMLF/` are:

```text
LMLF/Basic.lean
LMLF/Definitions.lean
LMLF/Results.lean
```

They contain imports and module documentation only.  The public root imports
those three skeleton modules.  A scan of committed Lean files found no
`sorry`, `admit`, `axiom`, `unsafe`, or `implemented_by`.  Neither
`LMLF/Quantitative/Basic.lean` nor `LMLF/Definitions/Gamma.lean` exists in the
commit.  Therefore QB-001 and DEF-001 remain specifications, not
implementations.

## Pins, actions, and hermeticity

- `lean-toolchain` SHA-256:
  `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71`;
  resolved runtime: Lean 4.33.1, compiler commit
  `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`.
- `lakefile.toml` SHA-256:
  `c7bb53018e97237f83c740be3e0e42cb9d848097fe20b894cef4e69ba145962b`;
  requested Mathlib revision `v4.33.1`.
- `lake-manifest.json` SHA-256:
  `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`;
  resolved Mathlib full commit
  `0df444a360eaa60ab8c11dca51a86af692955474`.
- CI SHA-256:
  `7f7b9323df569a2fe69b94540e721fbd51fb2d770868d4f9202c58361da20af2`.
- `actions/checkout@fbc6f3992d24b796d5a048ff273f7fcc4a7b6c09`
  exactly matched remote tag `v5`.
- `leanprover/lean-action@50fcf42d2e460296f1a34b402e990d1b24f8b596`
  exactly matched remote tag `v1`.

The reproducibility claim is appropriately limited.  The workflow uses the
moving `ubuntu-latest` image and an unpinned system `python3`; dependency and
tool downloads/caches are external services.  The blueprint explicitly says
the operating-system environment is not hermetic or bit-for-bit reproducible
and that inaccessible licensed source bytes cannot be certified by hash syntax.
No stronger claim is made.

## Commands and observed results

All commands ran in the isolated archive unless the path says otherwise.

```text
git rev-parse '3fa70a7e482ddfe03d3db77262f534dcd4b56a7e^{commit}'
  -> 3fa70a7e482ddfe03d3db77262f534dcd4b56a7e
git show -s --format='%H%n%T%n%P%n%ad%n%s' 3fa70a7e...
git archive --format=tar 3fa70a7e... -o /tmp/lmlf-prelean-final-j.4qNB2x/source.tar
sha256sum /tmp/lmlf-prelean-final-j.4qNB2x/source.tar
  -> b0349086e3e0f94d9a3f50dcfb25a9e0b7058ab33508cbb2b1f091cba6362d7e
/home/codex/.codex/skills/referee-lean-library/scripts/library_inventory.sh /tmp/lmlf-prelean-final-j.4qNB2x/source
  -> 4 Lean files, 30 lines; no trust/resource marker hit
python3 scripts/validate_inventory.py
  -> passed: 24 occurrences, 2 notations, 10 entities, 10 entity-evidence rows,
     16 occurrence associations; required examples QB/DEF/QL/OLV/SR;
     manifest totals BOOTSTRAP-0=0, DEMO-0=0, OLV-MVP-1=1
python3 scripts/validate_inventory.py --negative-tests
  -> all 23 intentionally invalid copied fixtures rejected; positive rerun passed
python3 planning-ID enumeration (all blueprint Markdown tables)
  -> 88 unique IDs / 90 mentions; duplicate mentions only QB-001 and DEF-001
python3 novel composed ready-source/manifest mutation via imported validator
  -> errors 0 (G1)
lake update
  -> checked out Mathlib 0df444a... and every manifest dependency at its full
     recorded revision; cache retrieval completed successfully
sha256sum .lake/packages/mathlib/Mathlib/Analysis/SpecialFunctions/Gamma/Basic.lean
  -> 720a9a72d742fbe1c9a89601dc3a00d82c0261c7368c98cccb58307dbffe3bbf
lake build LMLF.Basic
  -> success, 1321 jobs
lake env lean /tmp/lmlf-prelean-final-j.4qNB2x/ReviewQB.lean
  -> exit 0, empty stderr
lake env lean /tmp/lmlf-prelean-final-j.4qNB2x/ReviewGamma.lean
  -> exit 0, empty stderr
lake build
  -> success, 1325 jobs
rg -n --glob '*.lean' '\\b(sorry|admit|axiom|unsafe|implemented_by)\\b' . --glob '!.lake/**'
  -> no matches
git ls-remote https://github.com/actions/checkout.git refs/tags/v5
  -> fbc6f3992d24b796d5a048ff273f7fcc4a7b6c09
git ls-remote https://github.com/leanprover/lean-action.git refs/tags/v1
  -> 50fcf42d2e460296f1a34b402e990d1b24f8b596
```

The Olver brief reviewed in full had SHA-256
`6787cdb628a66783d81190939e9593525ebb2640a8c870d685d95ce26ba0cce3`.

## Rubric closure

- Mathematical intent: clear for the current bootstrap; G1 affects source
  release-state integrity, not the QB/DEF statements.
- Reusable seams/API shape: QB is the intended small lawful core; no premature
  product, inverse, family-wrapper, or typeclass surface enters its eight
  declarations.  DEF reuses the canonical Mathlib object.
- Module/dependency design: clear; only general-to-specialized imports exist in
  committed Lean; audit and tactic layers are not semantic dependencies.
- Mathlib integration: clear for QB and DEF at the pin; exact Gamma sources and
  theorem shapes were compared, not inferred from names.
- Proof architecture/local proof quality: clear; independent proofs compile,
  expose the mathematical skeleton, use no broad automation, and stay within
  the exact axiom allowlist.
- Cost/durability: no performance claim was made; the narrow imports compiled.
- Refactor risk/do-not-refactor: keep the QB eight-declaration boundary and the
  four-wrapper DEF boundary.  Repair G1 in the validator/tests only; do not
  widen either mathematical packet.

