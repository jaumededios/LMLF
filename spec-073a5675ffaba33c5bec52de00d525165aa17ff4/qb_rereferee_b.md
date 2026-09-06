# QB-001 exact-specification re-referee report

## Review identity and isolation

- Reviewer ID: `qb_rereferee_b`
- Reviewer kind: agent
- Model: `gpt-5.6-sol` (Codex)
- Review stage: fresh independent pre-Lean specification re-review
- Exact specification commit: `073a5675ffaba33c5bec52de00d525165aa17ff4`
- Isolation strength: `manual_attestation`
- Isolation method: manual fresh read-only exact-commit isolation. I read only committed blobs through `git show 073a5675ffaba33c5bec52de00d525165aa17ff4:<path>`. I ignored every untracked working-tree file, made no repository edit, did not inspect an implementation candidate, and did not open `blueprint/reviews/QB-001-rev3.md` or any other referee report. This report is written outside the candidate repository.

The reviewed committed inputs were the QB-001 natural-language proof revision, theorem card, exact-signature artifact, work packet, `review/PROTOCOL.md`, and the five committed rubric files. The target set was limited to the normative subset identified by the card and packet; excluded sections of the larger proof dossier were not treated as authorizing declarations.

## Verdict

**APPROVE**

I found no mathematical, binder/typeclass, domain-direction, constant, digest, status, or scope defect in the eight frozen targets. There are no P0--P2 findings. This is approval of the exact specification above, not an implementation-stage build, axiom, regression, or proof-term verdict; the packet correctly leaves implementation review pending (`review/work_packets/QB-001.yaml:322-377`).

## Independent mathematical re-derivation of all eight targets

| Target | Re-derivation and adversarial check | Result |
|---|---|---|
| `QB-001-T01` / `QuantitativeAnalysis.ErrorOn` | The definition is exactly `forall x in D, norm (f x - a x) <= b x`. It quantifies only over the stated domain and makes no global sign or nonemptiness assertion. This matches the dossier definition (`blueprint/proofs/QB-001.md:25-41`), frozen signature (`blueprint/theorem_cards/QB-001-signatures.md:19-20`), and packet target (`review/work_packets/QB-001.yaml:57-80`). | Sound. |
| `QB-001-T02` / `QuantitativeAnalysis.NormBoundOn` | The definition is exactly `forall x in D, norm (f x) <= b x`, again allowing an empty domain and a signed majorant off-domain. It matches the dossier (`blueprint/proofs/QB-001.md:33-41`), signature (`blueprint/theorem_cards/QB-001-signatures.md:22-23`), and packet (`review/work_packets/QB-001.yaml:81-104`). | Sound. |
| `QB-001-T03` / `QuantitativeAnalysis.HasErrorFamily` | Expanding the telescope gives `forall n : Nat, ErrorOn (D n) f (a n) (b n)`. The target `f` is uniform in `n`; only approximant, domain, and majorant vary. Nothing entails convergence, finite-sum representation, cross-index compatibility, or monotonic improvement, exactly as warned in the dossier (`blueprint/proofs/QB-001.md:43-54`) and card (`blueprint/theorem_cards/QB-001.yaml:69-82`). The signature and packet agree (`blueprint/theorem_cards/QB-001-signatures.md:25-28`; `review/work_packets/QB-001.yaml:105-130`). | Sound. |
| `QB-001-T04` / `QuantitativeAnalysis.ErrorOn.exact` | Fix `x in D`. `Set.EqOn f a D` gives `f x = a x`; hence `f x - a x = 0`, so its norm is `0`, and `0 <= 0`. No converse or arbitrary-majorant claim is used. This is precisely the forward statement at `blueprint/proofs/QB-001.md:210-218,282-288`, the frozen signature at `blueprint/theorem_cards/QB-001-signatures.md:32-33`, and the packet target at `review/work_packets/QB-001.yaml:131-154`. | Sound. |
| `QB-001-T05` / `QuantitativeAnalysis.ErrorOn.restrict` | Fix `x in D'`. The hypothesis `D' subset D` sends membership to `x in D`, where the original estimate applies. The direction is deliberately from the larger domain to the smaller one; no reverse implication is smuggled in. This matches `blueprint/proofs/QB-001.md:66-92`, the signature at `blueprint/theorem_cards/QB-001-signatures.md:35-37`, and the packet at `review/work_packets/QB-001.yaml:155-178`. | Sound. |
| `QB-001-T06` / `QuantitativeAnalysis.ErrorOn.weaken` | At each `x in D`, the premises give `norm (f x - a x) <= b x` and `b x <= d x`; transitivity yields the desired bound by `d x`. The majorant comparison points in the necessary direction and is required exactly on the conclusion domain. No independent nonnegativity hypothesis is needed. This matches `blueprint/proofs/QB-001.md:94-132`, `blueprint/theorem_cards/QB-001-signatures.md:39-41`, and `review/work_packets/QB-001.yaml:179-202`. | Sound. |
| `QB-001-T07` / `QuantitativeAnalysis.ErrorOn.trans` | At each `x in D`, the exact additive-group identity `f x - c x = (f x - a x) + (a x - c x)` gives, by the norm triangle inequality, `norm (f x - c x) <= norm (f x - a x) + norm (a x - c x)`. Adding the two premise inequalities yields the advertised `b x + d x`. No sign premise on `b` or `d` is needed for `add_le_add`; the same intermediate `a` and same domain occur in both premises. This matches `blueprint/proofs/QB-001.md:134-178`, `blueprint/theorem_cards/QB-001-signatures.md:43-45`, and `review/work_packets/QB-001.yaml:203-227`. | Sound. |
| `QB-001-T08` / `QuantitativeAnalysis.ErrorOn.comp` | Fix `y in S`. `Set.MapsTo psi S D` has the correct pullback direction and gives `psi y in D`; applying `h` there yields `norm (f (psi y) - a (psi y)) <= b (psi y)`, definitionally the composed conclusion. No injectivity, surjectivity, continuity, or inverse-image equality is required. Composition is stable: if `phi` maps `T` to `S`, then `hpsi.comp hphi` maps `psi composed with phi` from `T` to `D`, and repeated use of this target gives the same result. This matches `blueprint/proofs/QB-001.md:326-355`, `blueprint/theorem_cards/QB-001-signatures.md:47-50`, and `review/work_packets/QB-001.yaml:228-253`. | Sound. |

## Binder, typeclass, and API audit

The single ambient assumption `[NormedAddCommGroup E]` is sufficient for every target: it supplies zero, subtraction, additive-group identities, the norm, norm of zero, and the triangle inequality. None of the declarations needs scalar multiplication, completeness, topology beyond that bundled with the norm, decidable membership, `DecidableEq`, classical choice, continuity, measurability, or domain nonemptiness. Arbitrary `X` is sufficient for T01--T07, and arbitrary `X` and `Y` are sufficient for T08. The real-valued majorants supply the required order and addition.

The frozen namespace, declaration order, binder order, implicitness, and conclusions at `blueprint/theorem_cards/QB-001-signatures.md:8-10,12-53` agree target-for-target with the expanded signatures at `review/work_packets/QB-001.yaml:56-253`. In particular, namespace-local `theorem exact` is the fully qualified `QuantitativeAnalysis.ErrorOn.exact`, and similarly for the other four lemmas. The `S` binder is implicit, `psi` is explicit, and `hpsi` follows it in T08 in both artifacts.

The API names match their logical content. `HasErrorFamily` is neutral rather than misnamed as an expansion or convergence predicate (`blueprint/theorem_cards/QB-001.yaml:69-82`; `review/rubrics/api_dependency.md:18-25`). The definitions are project-local quantitative seams while their ingredients reuse the canonical `Set.EqOn`, `Set.MapsTo`, `NormedAddCommGroup`, and `norm_add_le` dependencies recorded at `review/work_packets/QB-001.yaml:257-269`.

## Domain, majorant, and edge-case audit

- Empty domains are harmless: all three predicates/theorems quantify pointwise and remain conditional infrastructure. The card states this explicitly (`blueprint/theorem_cards/QB-001.yaml:78-82,124-132`), consistent with the quantitative rubric's empty-set rule (`review/rubrics/quantitative_correctness.md:16-25`).
- Restriction uses `D' subset D`, never its converse (`blueprint/proofs/QB-001.md:70-88`).
- Weakening uses `b <= d`, never a smaller replacement (`blueprint/proofs/QB-001.md:98-128`).
- Transitivity uses exactly `b + d`, with neither subtraction nor a hidden maximum/minimum (`blueprint/proofs/QB-001.md:138-174`).
- Precomposition requires exactly the reachability fact expressed by `Set.MapsTo psi S D`; the conclusion remains on `S` and does not claim a converse (`blueprint/proofs/QB-001.md:330-351`).
- A satisfied error bound already implies majorant nonnegativity on its domain, but none of the five transport lemmas improperly assumes or needs a global nonnegativity field (`blueprint/proofs/QB-001.md:56-64`; `blueprint/theorem_cards/QB-001.yaml:128-132`).

## Revision, digest, and status agreement

I recomputed SHA-256 over the exact committed blob bytes:

| Artifact | Committed revision/status | Recomputed SHA-256 | Agreement |
|---|---|---|---|
| `blueprint/proofs/QB-001.md` | revision 3, `proof_status: approved` (`:1-9`) | `653b6fba9e597f56e63cf7520b0dbf896b1c3a4980436f2a8c065993aa26754c` | Matches both packet entries at `review/work_packets/QB-001.yaml:18-29,45-49` and card binding at `blueprint/theorem_cards/QB-001.yaml:98-111`. |
| `blueprint/theorem_cards/QB-001.yaml` | artifact revision 3; specified, proof/review approved, implementation authorized (`:1-15`) | `ad68e05e764d9edcb51960fc00982192a4b964c37d5d342a4e8bb3ccf6f1587c` | Matches `review/work_packets/QB-001.yaml:35-40`. |
| `blueprint/theorem_cards/QB-001-signatures.md` | revision 1, specified (`:1-10`) | `1959a7787ddf31477321b75bec944938f6ac2f1d77c5c14702c33b3446684f12` | Matches card revision at `blueprint/theorem_cards/QB-001.yaml:32-35` and packet at `review/work_packets/QB-001.yaml:41-44`. |
| `review/work_packets/QB-001.yaml` | frozen (`:1-8`); pre-Lean evidence and `lean_ready` recorded pass (`:277-320`); implementation review pending (`:322-377`) | `6448ab4c11964e2976dec98ef61d75e8d031cb76c17d3fef98f8e60b4cfae574` | This report binds that exact packet blob to the exact specification commit. |

The card's `implementation_status: authorized` is not a claim of completion: its implementation block explicitly records `file: null` and `declarations_present: false` (`blueprint/theorem_cards/QB-001.yaml:164-172`), while the work packet keeps implementation review pending. The `pending_external_record_after_commit` baseline fields in the card and signature artifact are also deliberate rather than stale self-identifiers: the protocol requires the commit/path/digest binding to live externally (`review/PROTOCOL.md:50-66,137-149`).

The packet records an earlier review artifact at `review/work_packets/QB-001.yaml:50-54`; pursuant to the isolation instruction, I did not open it, did not verify its contents, and did not rely on its conclusions. The present verdict comes from the fresh derivations above.

## Strict scope check

The signature artifact freezes exactly three definitions and five theorems and explicitly rejects a ninth public declaration (`blueprint/theorem_cards/QB-001-signatures.md:8-10,19-50`). The same eight fully qualified names occur once each in the card (`blueprint/theorem_cards/QB-001.yaml:23-44`) and packet (`review/work_packets/QB-001.yaml:56-253,404-412`).

The card expressly excludes symmetry, congruence, the zero-error converses and conversion equivalences, arithmetic closure lemmas, scalar/finite-sum estimates, product/inverse/division estimates, and family wrappers (`blueprint/theorem_cards/QB-001.yaml:45-55`). The packet independently limits implementation to exactly the eight signatures and excludes every other dossier result (`review/work_packets/QB-001.yaml:390-398,418-422`). Thus the larger natural-language dossier does not enlarge QB-001, even though it discusses additional valid mathematics. No excluded statement was used to justify approval of an in-scope target.

## Verification boundary

No Lean build or implementation proof-term check is claimed. The exact object under review is a specification commit, and the permitted committed inputs contain signatures rather than an implementation candidate. Reading or building the untracked working tree would have violated the requested isolation. The later implementation referee must run the packet commands, inspect all eight declaration types and bodies, check the axiom allowlist, and verify the three regressions at the exact implementation head (`review/work_packets/QB-001.yaml:379-416`; `review/rubrics/proof_quality.md:13-45`).
