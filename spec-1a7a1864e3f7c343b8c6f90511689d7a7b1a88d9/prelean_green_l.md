# Independent final pre-Lean referee report: `prelean_green_l`

## Review identity and scope

- Reviewer ID: `prelean_green_l` (Codex task `/root/prelean_green_l`)
- Model: OpenAI Codex, GPT-5 family; the runtime did not expose a more specific deployment identifier, so none is invented here.
- Issued UTC: `2026-09-05T18:47:18Z`
- Verdict target: exact commit `1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9`
- Commit tree: `33932352e1d514cbd604a16a947dfc6d99d80a97`
- Parent: `3fa70a7e482ddfe03d3db77262f534dcd4b56a7e`
- Commit subject: `test: enforce source manifest role closure`
- Repository: `/home/codex/Documents/Codex/2026-09-05/yo`
- Olver brief: `/home/codex/.codex/attachments/6740fc8c-818a-4ce2-95bb-67293a5ba2bf/pasted-text.txt`, SHA-256 `6787cdb628a66783d81190939e9593525ebb2640a8c870d685d95ce26ba0cce3`
- Report SHA-256: reported externally after finalization; embedding the full-file digest in this file would be self-referential.

This is a fresh-context, read-only pre-Lean review. I applied the complete `referee-lean-library` protocol first and then the complete `referee-lean-proof` protocol. The repository candidate was not edited.

### Isolation attestation

Isolation strength is `manual_attestation`, not `technically_enforced`. I created `/tmp/olver-prelean-green-l.PGneE5` solely by streaming `git archive` from the exact commit, before inspecting candidate contents. The archive contained no `.git` metadata. Builds, independent Lean reconstructions, dependency checkout, synthetic card files, and validator mutations occurred only in that disposable archive. The archive's initial 76-file SHA-256 manifest has digest `ba0c16b25e2795ab8fbf0e2fe76093ff42782a3e608490b2a1799937b42cb80c`.

I did not read the dirty/live worktree contents, any untracked prototype, any other reviewer output, or the historical `blueprint/reviews/QB-001-rev3.md`. The historical filename and digest appear in normative current artifacts, but the historical report itself was excluded. Network access and the broader filesystem were technically available, so this review does not claim hardened clean-room isolation.

## Verdicts

| Review object | Exact binding | Verdict |
|---|---|---|
| Overall architecture and pre-Lean package | commit `1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9` | **approve** |
| QB theorem card | `QB-001`, card revision 7, SHA-256 `827522349afc7374a8bec60b3d281c192a44189f8e8c08c24e453bf75e215667` | **approve** |
| QB natural-language proof | `NLP-QB-001-R6`, revision 6, SHA-256 `42b027310a56ff70f4c56471de527aa9b6a3ac88810ad3ba17029953514c1589` | **approve** |
| QB structural/circularity applicability | work packet revision 4 | **confirm `not_applicable`; external gate should be `not_required`** |
| DEF theorem card | `DEF-001`, card revision 4, SHA-256 `eff82b06afaa61b67d13c3a399494525ed452e42c203a390ba40e56b93ec9daa` | **approve** |
| DEF natural-language-proof applicability | work packet revision 3 | **confirm `not_applicable`; external gate should be `not_required`** |
| DEF structural/circularity applicability | work packet revision 3 | **confirm `not_applicable`; external gate should be `not_required`** |

No actionable `G#` architecture finding or `L#` local-proof finding remains. I found no P0--P3 defect requiring a specification change. The explicit manual boundaries below are accurately disclosed by the repository and are not represented as implemented automation.

### External `lean_ready` adjudication

**Yes: the reviewed evidence permits external `lean_ready` adjudication for both QB-001 and DEF-001, without this report setting either gate.** This report supplies one independent fresh-context approval covering the QB card and QB proof, one independent approval covering the DEF card, and confirmation of the frozen inapplicability reasons. An external adjudicator must still bind this report/verdict and the other required independent verdict(s) to the exact specification commit, work-packet digests, upstream artifact revisions/digests, classification digest, toolchain, and durable reviewer IDs; verify the required distinct-ID compositions and absence of adverse verdicts; mirror the applicable `not_applicable` fields as `gate_state: not_required`; and only then decide the composite gate. I did not inspect another review and therefore do not independently assert that the external quorum has already been assembled.

## Architecture and governance audit

### Layering and planning taxonomy

The plan faithfully refines the Olver brief into the following forward-only architecture:

```text
pinned Lean/Mathlib + locked source evidence
  -> finite quantitative core / low-level branch support
  -> constructions (only when reuse is insufficient)
  -> conventional definitions and proved identification
  -> generic finite methods
  -> exact-source generic theorems or discharged named applications
  -> Audit/SourceRecovery qualitative bridges
  -> catalogue and closed-release evidence
```

The forbidden reverse directions are explicit: the quantitative core does not import named functions; constructions do not import estimates that consume them; residual identities are not solution estimates; semantic modules do not import audits or tactics; and qualitative source recovery is a downstream, separately built consumer. The Watson critical path is narrow and correctly excludes Airy, Cauchy transport, ODE, transitions, zeros/connections, and tactics.

The taxonomy is appropriately orthogonal:

- packet and declaration theorem shape are separate from coverage role and novelty;
- `exact_source_generic`, `named_source_application`, and `audit_source_recovery` are coverage roles, not theorem shapes;
- specification, proof, review, implementation, prototype, coverage, and manifest membership have distinct state axes;
- packet-local concepts (`ErrorOn`, `NormBoundOn`, `HasErrorFamily`) are not laundered into source-entity inventory;
- provisional planning IDs are repeatedly disclaimed as neither cards nor authorization;
- overlapping coarse and granular future handles such as `DEF-002` versus `DEF-AIR-*` are explicitly flagged for reconciliation before registration.

This matches the brief's finite-inequality core, definitions/identification gate, source-faithful but downstream qualitative layer, exact constant/domain policy, and rejection of premature universal typeclasses or tactics.

### Truthful current state

The current state is stated literally and consistently:

- `BOOTSTRAP-0` is closed and `execution_ready` only in the sense of bounded specification membership; it has zero source occurrences and does not authorize Lean.
- QB-001 is frozen at card R7, proof R6, signatures R2, with review and implementation `not_started` in candidate-owned metadata.
- DEF-001 is frozen at card R4, has proof `not_required`, review/implementation `not_started`, and prototype `absent` in this exact snapshot.
- `OLV-MVP-1` has a locked one-occurrence selection but open scope, planning-only cards, an uninspected 1997 placeholder, and no source credit.
- The 2010 preview is assigned a distinct edition/snapshot. Its relation to the locked 1997 edition is unresolved on content and page locators and consequently `join_semantics: non_equivalent`.
- No Olver quantitative theorem, named source application, qualitative recovery, chapter, or book coverage is claimed.

### Exact source-evidence and manifest joins

The normalized tables explicitly model editions, edition relations, source snapshots, page audits, occurrences, notation, entities and entity evidence, cards, manifests, and all many-to-many associations. The positive validator run reports 24 occurrences, 2 notations, 10 entities, 10 entity-evidence rows, 16 associations, and manifest totals `BOOTSTRAP-0=0`, `DEMO-0=0`, `OLV-MVP-1=1`.

For source-ready records the validator requires a non-placeholder available snapshot, verified lowercase SHA-256 metadata, matched edition reconciliation and page mapping, independently reviewed complete page audit, verified occurrence transcription and reconciliation, and direct source evidence. It rejects same-edition joins between distinct snapshots because this schema has no snapshot-equivalence relation. Cross-edition joins require both ready snapshots plus one deterministic fully matched content-and-page edition relation marked equivalent.

For every closed or ready source-bearing manifest, it enforces all of the requested closure conditions:

1. occurrence selection is locked;
2. each source-coverage occurrence is source-ready;
3. all manifest member cards have ready status and a file at the canonical `blueprint/theorem_cards/<id>.yaml` path;
4. the occurrence has a confirmed, same-manifest ready canonical card pairing of either `exact_source_target` with `exact_source_generic` or `named_application` with `named_source_application`; and
5. the occurrence also has a confirmed, same-manifest ready canonical `source_recovery` / `audit_source_recovery` card.

Confirmed roles in another manifest cannot satisfy those checks.

The built-in suite passed all 25 intentionally invalid copied fixtures. I additionally constructed a full synthetic transition from the current planning state to a source-ready, closed, `execution_ready` manifest and exercised seven composed cases:

- positive: same-manifest `exact_source_generic` plus `audit_source_recovery` with locked selection and canonical ready card paths;
- positive: same-manifest `named_source_application` alternative plus `audit_source_recovery`;
- negative: unlocked ready source selection;
- negative: missing confirmed exact-source/named-application role;
- negative: missing confirmed source-recovery role;
- negative: both valid roles exist only in another manifest;
- negative: the same-manifest exact-source card points away from its canonical path.

Both positives passed and all five negatives produced the required diagnostics. Thus the composed state transition and anti-laundering logic—not merely isolated field checks—behaved as specified.

### Residual manual boundary

The remaining automation boundary is material but accurately documented. The current validator checks CSV structure and relational metadata; it does not prove that an inaccessible source digest names the inspected bytes, parse or semantically validate the YAML/Markdown cards and proofs, compare card contents with their registry rows, validate card/work-packet revisions and digests, authenticate reviewer identities, calculate quorum, validate an instantiated external envelope, or inspect Lean declarations. The synthetic positive transition confirms that a canonical card check means path plus file existence, not valid card contents. Page-audit and reviewer identifiers are also assertions until externally authenticated.

Those facts are not a hidden green-light path: the README, protocol, source-manifest policy, function-inventory specification, cards, packets, CI plan, and validator all say that these broader checks remain manual/planned and that passing inventory validation establishes neither source truth nor review/authorization. This report therefore treats them as the declared human adjudication boundary, not as automated certification.

## QB-001 card and proof audit

### Frozen binding

- Card R7: `827522349afc7374a8bec60b3d281c192a44189f8e8c08c24e453bf75e215667`
- Signature artifact R2: `93e4e30a93087de95342abdb1e986676924cd93512e771737d0d3f3ed7973b39`
- Natural-language proof R6: `42b027310a56ff70f4c56471de527aa9b6a3ac88810ad3ba17029953514c1589`
- Work packet R4: `7a56a1695d15ea2cedd525ee4270d20830e1706827bb592dfde293bcd7d54c39`
- Classification authority R2: `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9`

All embedded current-artifact hashes and revisions reproduce exactly. The classification authority's superseded-v1 digest also reproduces as `7a4f322bb56dbb40d5d44a7eceb50b5a49ea6ae69f414b920341e3b12ea9d71e`.

### Independent mathematical rederivation

The eight-target boundary is exact and stable: three definitions and five lemmas, with no ninth declaration authorized.

- `ErrorOn` is exactly the pointwise inequality `forall x in D, norm (f x - a x) <= b x`.
- `NormBoundOn` is exactly `forall x in D, norm (f x) <= b x`.
- `HasErrorFamily` fixes one target `f` outside the order quantifier and only packages order-indexed finite bounds. It implies neither a finite-sum representation nor convergence, monotonicity, domain reachability, or inter-order compatibility.
- `ErrorOn.exact` follows from `Set.EqOn`, subtraction of equal values, and norm zero. No arbitrary signed majorant is smuggled in.
- `.restrict` uses only the forward inclusion `D' subset D`; the reverse direction is correctly rejected.
- `.weaken` has the required direction `b <= d` on exactly the conclusion domain.
- `.trans` uses the exact identity `f-c = (f-a)+(a-c)`, the norm triangle inequality, and pointwise addition of the two majorants. Neither maximum nor one bound alone suffices.
- `.comp` is precomposition and requires exactly `Set.MapsTo psi S D`; it assumes no injectivity, surjectivity, continuity, or derivative data.

Empty generic domains are intentionally permitted. Any satisfied error bound already entails pointwise majorant nonnegativity on its domain, but the definition does not assert unrelated global nonnegativity. `NormedAddCommGroup E` is a natural stable analysis boundary for these declarations. The dossier's many later algebraic observations are unmistakably labelled prospective and are excluded by the normative anchor table, card, signature artifact, and packet.

### Independent Lean reconstruction

I independently supplied proof bodies for the exact eight signatures in a disposable `QB001Independent.lean`, importing only `LMLF.Basic`. It compiled with no diagnostics under the pinned toolchain. The file digest was `1716c40bd0b8e16101b9d9bf5f3dec74260b6ab201323be1eb4c9c113abfa536`.

`#print axioms` for all eight declarations reported exactly:

```text
[propext, Classical.choice, Quot.sound]
```

This is precisely the packet allowlist. There was no `sorry`, `admit`, custom axiom, `unsafe`, heartbeat override, extra import, or extra public declaration.

### QB structural-gate judgment

The frozen `not_applicable` reason is sound. QB-001 defines three elementary predicates and proves direct set/order/norm transports; it constructs or identifies no source or named object, performs no continuation or existence/uniqueness selection, uses no choice, asserts no source coverage, and introduces no record capable of hiding a model, contour, normalization, or desired named estimate. Although later theorems may take `ErrorOn` as an explicit hypothesis, that is the transparent proposition being reasoned about, not a laundering structure. Later exact-source and named cards remain responsible for discharging their concrete hypotheses. The external envelope should record `structural_circularity_review.applicability: not_applicable` and `gate_state: not_required` with the frozen packet reason.

## DEF-001 card audit

### Frozen binding and pin

- Card R4: `eff82b06afaa61b67d13c3a399494525ed452e42c203a390ba40e56b93ec9daa`
- Work packet R3: `6dbda13f4f27dd4c0492c00ecc0a2d184f00fe85fa7096802cf93e9fdecf11e8`
- Classification authority R2: `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9`
- Toolchain: `leanprover/lean4:v4.33.1`; observed Lean commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`
- Requested Mathlib tag: `v4.33.1`
- Resolved Mathlib commit: `0df444a360eaa60ab8c11dca51a86af692955474`
- Pinned source: `Mathlib/Analysis/SpecialFunctions/Gamma/Basic.lean`
- Pinned source SHA-256: `720a9a72d742fbe1c9a89601dc3a00d82c0261c7368c98cccb58307dbffe3bbf`

The checked-out dependency HEAD and source-file digest exactly match the packet. `lake update` in the disposable archive preserved `lake-manifest.json` digest `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`.

### Exact four-wrapper rederivation

The pinned source contains all four named facts with the required orientations:

- `Complex.GammaIntegral_convergent` has the complex Euler integrand and hypothesis `0 < s.re`;
- `Complex.Gamma_eq_integral` concludes `Complex.Gamma s = Complex.GammaIntegral s` on that half-plane;
- `Complex.Gamma_ofReal` gives complex/real agreement for every real input;
- `Complex.Gamma_neg_nat_eq_zero` records Mathlib's totalization at `-(n : ℂ)`.

I independently implemented the exact proposed wrappers in disposable `DEF001Independent.lean`, importing only `Mathlib.Analysis.SpecialFunctions.Gamma.Basic`. Both expanded-integrand wrappers close by definitional simplification of the pinned declarations; the real-agreement and pole-totalization wrappers close directly. The file compiled cleanly and has SHA-256 `057d56d3ab4995d70798573b3739c2b7f2056bd594853ba8afb0f82314b9ff28`.

All four `#print axioms` reports were exactly:

```text
[propext, Classical.choice, Quot.sound]
```

The card correctly restricts the Euler formula to `0 < s.re`, makes the positive-real integration path/complex-power convention visible, distinguishes totalized zero from a classical finite pole value (including `n = 0`), reuses rather than duplicates `Complex.Gamma`, and claims entity-identification infrastructure but no Olver occurrence.

### DEF proof and structural-gate judgments

The natural-language-proof gate is correctly `not_applicable`: these are transparent presentational wrappers around four exact, specifically pinned facts, with no new mathematical argument. The external envelope should mirror it as `gate_state: not_required` with the frozen reason; it must not fabricate an empty proof artifact.

The structural/circularity gate is also correctly `not_applicable`: the packet introduces no new function, series, integral construction, analytic continuation, existence/uniqueness identification, hidden choice, theorem-sized hypothesis record, or asymptotic dependency. It imports the narrow pinned Gamma module and exports four one-way wrappers. The external gate should be `not_required` with the frozen reason.

## Pins, build, and absence of implementation

The project pins Lean in `lean-toolchain`, Mathlib by tag in `lakefile.toml`, and the resolved dependency graph in `lake-manifest.json`. GitHub Actions pins `actions/checkout` to `fbc6f3992d24b796d5a048ff273f7fcc4a7b6c09` and `leanprover/lean-action` to `50fcf42d2e460296f1a34b402e990d1b24f8b596`; direct `git ls-remote` checks confirmed those exact objects are the current `v5` and `v1` tag refs respectively. The CI plan truthfully disclaims the moving `ubuntu-latest` OS image as non-hermetic.

`lake build` at the archived commit completed successfully (`1325 jobs`; public modules `LMLF.Basic`, `LMLF.Definitions`, `LMLF.Results`, and `LMLF`). This is only a stub-package build, exactly as documented.

The exact commit contains only these Lean files:

```text
LMLF.lean
LMLF/Basic.lean
LMLF/Definitions.lean
LMLF/Results.lean
```

They total 30 lines. A declaration scan found zero `def`, `theorem`, `lemma`, `axiom`, `opaque`, `structure`, `class`, or `instance` declarations and zero trust/resource markers. Their SHA-256 digests are:

```text
8451f612d9f9ba7fee64ecbc678df5d76b0b56f422c506582eb514e1148154d9  LMLF.lean
3ceac6d68d0e3dac83238b3a6d8c7e826fff35b2d19ebf70556ff86d7ad1b38a  LMLF/Basic.lean
d2e4402e02427d84e1fb6e865c957186028e886a8ee75a316cdf19b2ab54d95d  LMLF/Definitions.lean
17e05adfe200215a653defcb7d6edaa7b0058e0227ac25f86b9c06a8c5d5a070  LMLF/Results.lean
```

Therefore the exact commit contains no QB-001 implementation, no DEF-001 implementation or prototype, and no semantic implementation of any later plan. The recorded `not_started`/`absent` statuses are truthful.

## Reproducible commands and results

The material checks were:

```bash
git -C /home/codex/Documents/Codex/2026-09-05/yo rev-parse '1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9^{commit}'
git -C /home/codex/Documents/Codex/2026-09-05/yo show -s --format='%H%n%T%n%P%n%aI%n%cI%n%s' 1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9
git -C /home/codex/Documents/Codex/2026-09-05/yo archive 1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9 | tar -x -C /tmp/olver-prelean-green-l.PGneE5
/home/codex/.codex/skills/referee-lean-library/scripts/library_inventory.sh /tmp/olver-prelean-green-l.PGneE5
python3 scripts/validate_inventory.py
python3 scripts/validate_inventory.py --negative-tests
python3 IndependentValidatorStress.py
lake update
git -C .lake/packages/mathlib rev-parse HEAD
sha256sum .lake/packages/mathlib/Mathlib/Analysis/SpecialFunctions/Gamma/Basic.lean lake-manifest.json
lake env lean --version
lake build
/home/codex/.codex/skills/referee-lean-proof/scripts/check_lean_file.sh QB001Independent.lean
/home/codex/.codex/skills/referee-lean-proof/scripts/check_lean_file.sh DEF001Independent.lean
git ls-remote https://github.com/actions/checkout.git refs/tags/v5
git ls-remote https://github.com/leanprover/lean-action.git refs/tags/v1
git -C /home/codex/Documents/Codex/2026-09-05/yo ls-tree -r --name-only 1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9
```

Observed results: exact commit resolution passed; the deterministic inventory found four Lean files/30 lines/no declarations/no trust markers; positive inventory validation passed; all 25 built-in negative fixtures passed; the independent composed suite passed 2 positives and 5 negatives; dependency HEAD/source digest matched; Lean version was 4.33.1; the public package build passed; both independent declaration suites compiled with clean allowed-axiom reports; and both action tag refs matched the pinned SHAs.

## Final judgment

The specification is unusually disciplined about the distinction between finite mathematics, source coverage, named-function identification, qualitative recovery, and authorization. The exact bootstrap is bounded, its states are truthful, the artifacts and pins reproduce, the QB proof is mathematically and mechanically feasible at its frozen signatures, the Gamma wrapper surface exactly matches the pinned source, and the structural `not_applicable` decisions are justified. The source-manifest validator survives both its own adversarial suite and independent composed transition tests, including same-manifest role closure and cross-manifest anti-laundering.

**Final verdict: approve the architecture, QB-001 card R7, QB-001 NLP R6, and DEF-001 card R4; confirm the specified QB structural and DEF NLP/structural gates as `not_required`; permit the external adjudicator to decide `lean_ready` once the exact external bindings and required independent-review quorums are verified. This report does not itself set `lean_ready` and does not authorize any implementation beyond an externally passing gate.**
