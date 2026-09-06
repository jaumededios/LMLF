# Watson R5 / QL R3 / OLV R3 architecture review C

## Review identity and binding

- Durable reviewer ID: `watson_r5_arch_c`
- Stage: pre-Lean library architecture and structural-circularity review, before exact-signature design
- Perspectives: `dependency_direction`, `source_to_target_reachability`, and `hypothesis_and_choice_laundering`
- Configured model: `gpt-5.6-sol`, reasoning effort `xhigh`, and `fork_turns=none`, as reported by the root orchestration metadata; no backend build ID is exposed to this reviewer
- Runtime: Codex desktop subagent; Linux `5.15.0-190-generic` x86_64; GNU bash `5.2.15`; Python `3.11.2`
- Pinned proof environment inspected read-only: Lean `4.33.1` (`819816b2e0a3bf405af45ae5c7af2491d8f5bee6`), Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`
- Isolation: fresh-context manual isolation (`fork_turns=none`), not technically enforced. I did not consult peer reports, agent outputs, external review-evidence contents, or previous diffs; I did not list or contact agents. I made no candidate edit, commit, push, Lean implementation, or signature prototype.
- Candidate commit: `f5a5a6012a2d96d45ae365999fa778d61f38e522`
- Candidate tree: `ae40988d28bc9316917dad586c92b6c52c82c2c7`
- Deterministic `git archive --format=tar` SHA-256: `990ff8e18cd14b21cbf80c29d8496d8f2c64d33db58cf52a553455c5cc970679`
- Review copy: extracted from that archive at `/tmp/watson_r5_arch_c.RURGYB`; substantive candidate inspection used this archive, not the mutable checkout. The checkout was clean and happened to point at the same commit.

I read the complete required `referee-lean-library` skill and its complete global rubric. Skill SHA-256: `d4ce5aa5f1c7ebcf18da6f408c2fc2da98fe2dd906fa9c32b6b613b381aa0e9d`; global-rubric SHA-256: `990a183dc9e86a3d9580cfb2d5834d36d18afb8a06ad32a114d12b4d0716bb81`.

The source PDF is absent. I reviewed the repository transcription only and make no fresh PDF, edition, page, or source-reconciliation claim. The OLV verdict below is conditional on the explicitly unreconciled transcription; source review remains a separate gate.

## Verdicts

### Architectural / structural-circularity verdict: **approve**

No P0-P2 architectural, mathematical, dependency, hypothesis-laundering, or choice-laundering defect was found in the R5/R3 design. The graph is genuinely one-way:

`Mathlib -> IMP.Basic -> {IMP.Bochner, IMP.Abel} -> QL.Watson -> OLV.Watson -> Audit/SourceRecovery`.

T08 is proved directly from T01/T05 component semantics; T03, T04, T07, and T06 then consume T08. T08 does not depend back on those convenience theorems. Abel does not depend on Bochner or QL, and no IMP module depends on QL, OLV, source, audit, QB, or DEF material. I found no disguised cycle.

The main theorem-sized-looking inputs are legitimate abstraction boundaries rather than hidden conclusions:

- T05 contains continuity, normalization, regular-piece integrability, and an increment law, but no bound, new-weight value, or Watson remainder.
- T06 takes weighted-primitive integrability and boundary vanishing openly; QL derives both from `h = x - X > 0` and the separate flat bound.
- QL's baseline primitive bound is not assumed by the source adapter: OLV obtains a baseline T01 relation, invokes T08, and derives boundedness from convergence plus compact-prefix continuity.
- Model moment relations are constructed from separately proved `IntegrableOn` facts via T07; a totalized integral equality is never used as convergence evidence.

Logical choice is also properly located. T08 exposes existence without defining a chosen primitive or improper-integral value. The later qualitative OLV route chooses a value from the `n = 0` existence theorem and uses T02 uniqueness to transport every fixed-order estimate to that one function. It chooses no bound, contour, object with the desired estimate, or order-dependent source function.

### Public-consumer reachability verdict: **approve at the architecture/pre-signature level**

All eight public IMP targets have a concrete consumer, and the three-module split is consumer-complete without exposing or duplicating the finite-component representation:

| Target | Owner | Public role and reachable consumer |
|---|---|---|
| T01 | `Improper.Basic` | canonical independent-one-sided ordinary-improper relation used by source-facing OLV and throughout the chain |
| T02 | `Improper.Basic` | value uniqueness used for supplied-value transport and the future one-function qualitative bridge |
| T03 | `Improper.Basic` | finite union plus heterogeneous `E ->L[ℝ] H` transport used for real-to-complex Gamma models and model subtraction |
| T04 | `Improper.Basic` | exact regular-prefix prepend/remove used at both baseline and target weights |
| T05 | `Improper.Basic` | normalized continuous primitive contract consumed by T06 and QL |
| T06 | `Improper.Abel` | representation-independent arbitrary-`S` exponential composition used by QL |
| T07 | `Improper.Bochner` | honest absolute-Bochner constructor used for every Gamma/model moment |
| T08 | `Improper.Basic` | T01 iff existence of a convergent normalized primitive, used by OLV and by public relation laws |

The finite-piece Abel/Fubini identity, sorted endpoint recursion, anchors, and regular-point insertion remain private. QL and OLV consume only public semantic outputs. QL's brief mathematical explanation of the private Abel identity is not a second endpoint-stitching implementation; all exceptional-set assembly is delegated to T08/T06.

The complete source-shaped route is reachable:

1. source baseline convergence is represented by T01 at one common `X`, chosen before `n`;
2. every finite Gamma model is proved `IntegrableOn`, valued by the pinned Gamma theorem, and injected by T07;
3. T03 constructs the baseline remainder relation on the literal finite exceptional set;
4. local restricted-volume a.e. measurability and the power bound give honest interval integrability, then T04 moves the start to `k_n`;
5. T08 extracts a continuous normalized primitive tending to the baseline tail value, and OLV derives `L_n`;
6. QL derives T06's side conditions, changes to the target weight, prepends the local interval with T04, and combines target-weight Gamma models via T07/T03;
7. T02 supports the later single-function qualitative route.

This is reachability of the proposed public mathematical surface. Exact binder order, coercions, imports, names, and compiled no-unfolding regressions cannot be approved until the exact-signature artifact exists; those are the next signature-review and implementation gates, not failures of this deliberately pre-signature review.

### Structural precondition to exact-signature design: **CLEARED**

The snapshot clears the requested structural precondition to begin exact-signature design. This does **not** set `lean_ready`, authorize Lean implementation, register IMP-001, admit a manifest, approve source reconciliation, or waive later exact-signature/card/proof quorums. Exact signatures are intentionally absent at this stage and their absence is not counted as a mathematical defect.

## Mathematical scrutiny

I found no definite mathematical error. In particular:

- T08 forward constructs a cumulative primitive whose separate left/right endpoint limits glue continuously; the reverse direction recovers each independent component value and telescopes exactly to `I`. It neither admits principal-value-only cancellation nor implies absolute integrability.
- The private Abel calculation has the correct sign:
  `∫_a^b e^(-ht) • g(t) = e^(-hb) • F(b) - e^(-ha) • F(a) + h • ∫_a^b e^(-ht) • F(t)`.
  The Fubini argument is finite, uses the exact restricted product measure, and requires only local a.e. strong measurability. It does not differentiate `F` and remains valid at `a=b` and `h=0`.
- T06's transformed primitive tends to the exact value `h • ∫_(k,∞) e^(-ht) • F(t)`, so the public result reuses T08 rather than rebuilding component limits.
- In QL, `x > max X 0` gives both `x>0` and `h=x-X>0`. The local estimate follows from restricted-volume a.e. strong measurability plus the integrable power-exponential majorant. The tail norm is exactly bounded by `L exp (-(x-X)k)` after the legitimate cancellation of positive `h`.
- The Gamma moment integrability theorem and Gamma value theorem are kept separate. The finite model calculation uses only finitely many terms and works at `n=0` without coefficient access.
- OLV chooses one baseline `X` and value before `n`; `k_n`, `K_n`, and `L_n` may depend on `n`. The source adapter derives local integrability at zero from the `n=0` remainder bound, and for general `n` derives the stated constants and primitive bound rather than assuming the target estimate.
- For each fixed `n`, the exponential tail is little-o of `x^(-beta_n)`, and uniqueness places all fixed-order estimates on the same chosen Laplace function. No uniform-in-`n` conclusion is claimed.

Pinned Mathlib source inspection at the exact commit confirmed the stated forms and intended uses of the power-exponential `IntegrableOn` theorem, the real Gamma moment, exponential-ray integrability/value, interval-to-Ioi convergence, Ioi primitive continuity/difference, interval-integral CLM commutation, finite-product Fubini, and exponential-vs-rpow little-o theorem. This was source inspection only; no candidate Lean signature or implementation was prototyped.

## Generality, seams, and do-not-refactor decisions

- The ordinary-improper relation is truly source-independent: arbitrary real start, arbitrary finite marking set above it, generic complete normed real vector values, and no Gamma/Watson/source fields.
- T03's distinct output space `H` is justified by existing real/complex transports; restricting it to endomorphisms would recreate adapter lemmas in consumers.
- T06 is naturally stronger than the immediate QL application because it permits every real `h` for which its exact explicit side conditions hold. Positivity and boundedness belong in QL, where they are used to discharge those conditions.
- T07 is correctly one-way. Replacing T01 by a whole-ray Bochner integral would lose the intended conditional cases; adding a converse would be false.
- T08 is existential and carries no norm bound. A public selected primitive/value function or bounded certificate would introduce unnecessary choice or hypothesis laundering.
- Keeping the finite-piece Abel identity and ordered endpoint representation private is the right boundary. There is no evidence for another public representation-level theorem.
- QL T01's complete-normed-real-vector-space generality and restricted-volume `AEStronglyMeasurable` premise are the weakest natural Bochner interface used by the proof. OLV's complex source theorem plus real corollary is the correct source boundary under the unverified transcription.
- Do not collapse `Basic`, `Bochner`, and `Abel`: their import needs and consumers are distinct, and the split prevents foundational semantics from acquiring Fubini/FTC or absolute-integral dependencies unnecessarily.

## Classification and preservation check

The v3 classification change is structurally sound:

- recursive JSON comparison found unchanged packet-level axes, target-level axes, and `registry_binding` vocabulary;
- the only example classification change is `QL-001.novelty_class: novel -> non_novel`, with all non-QL examples identical;
- the remaining differences are the schema/artifact revision, predecessor binding/reason, and the historical-artifact-aware validation rule;
- v3's recorded predecessor digest `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9` exactly matches the present frozen v2 bytes;
- v2's predecessor digest exactly matches the present v1 bytes (`7a4f322bb56dbb40d5d44a7eceb50b5a49ea6ae69f414b920341e3b12ea9d71e`);
- QL R3 card, proof, v3 required example, and `cards.csv` all say `non_novel`; IMP R5 and all eight targets say `non_novel`; OLV remains `strengthened_conclusion`;
- current work-packet, review-envelope, and verdict templates all bind v3 at its exact digest, while historical frozen QB/DEF cards and work packets still bind v2 at its exact digest;
- the current validator reads v3, verifies the v2 predecessor hash, derives required registry rows from `registry_binding`, and passed both its positive validation and all 25 negative mutations.

No historical accepted/frozen artifact is overwritten within the snapshot's hash chain: v1 and v2 remain present at their recorded bytes; QB/DEF remain frozen on v2; and the superseded IMP R3 signature proposal remains a separate historical file rather than being treated as R5 input.

### G1 — P3 — stale validator-version sentence

- File: `blueprint/theorem_cards/README.md:163`
- Evidence: it says the inventory validator “consumes v2 packet classification enums,” but `scripts/validate_inventory.py:18-24` binds v3 as current authority and v2 only as the frozen predecessor. The validator, templates, registry, and cards themselves are consistent.
- Cost: a reader could mistake the current authority despite the machine checks being correct.
- Required fix: change the sentence to say the validator consumes the current v3 packet enums and verifies the frozen v2 predecessor.
- Blast radius: documentation only; no signature-design blocker. Confidence: high.

There are no reusable-extraction, API-generality, module-dependency, deletion, or local-proof handoff findings. The explicit do-not-refactor decisions above should be retained through signature design.

## Global rubric disposition

1. Mathematical intent: clear; the declaration graph implements the stated finite-exception Watson route, subject to the separately pending source review.
2. Reusable seams: clear; T01/T05/T08, T07, and T06 are coherent seams with real consumers, while representation helpers remain private.
3. Public API/theorem shape: clear for the pre-signature mathematical boundary; exact Lean ergonomics remain the next gate.
4. Module/dependency design: clear; one-way, no umbrella or audit feedback edge.
5. Mathlib integration: clear at the source-inspection level; stated pinned candidates exist with compatible mathematical roles.
6. Proof architecture: clear; construction, semantic equivalence, absolute adapter, Abel transform, quantitative estimate, source adapter, and qualitative audit remain separated.
7. Cost/durability: clear prospectively; the three-module split localizes heavy imports and representation churn. No performance claim is made.
8. Refactor risk: clear for this stage; freeze the accepted mathematical map before signatures, then run compiled public-consumer regressions IMP-R20--R25 before authorization.

## Primary SHA-256 bindings

| Artifact | SHA-256 |
|---|---|
| `blueprint/theorem_cards/IMP-001.yaml` | `b5ca9b3c818237b243cabf2328b7d51c4a292366928873767de0e6584de5ef62` |
| `blueprint/proofs/IMP-001.md` | `3c45e55fb76bc03ddfb6fe772fd20e33ddefcaad3ed3f07a5f3523ceb93f483f` |
| `blueprint/theorem_cards/QL-001.yaml` | `538591bc51ac66e38eab1a9299fae1154bd40f1ce657a6a9a1f9f4b6af1de488` |
| `blueprint/proofs/QL-001.md` | `e231233ae07d19702d5260b66e5ded9854477fb7e1a5dc188ecfc887c681019e` |
| `blueprint/theorem_cards/OLV-001.yaml` | `a70faa6c6e57c2acf745e0426a39374b9fc0a2e57a392da9dc23a56c38fb872a` |
| `blueprint/proofs/OLV-001.md` | `1b183323439cd06f4d049fd85594e02a5d4bb0e1d0103bc25e011ed100498db4` |
| `blueprint/design_decisions.md` | `8b200b00c03eefd5f50ba2e77490be86013f2614479f571213f5dba09a6f1b5c` |
| `blueprint/dependency_graph.md` | `680473c3a64f6b01987f9885c2982fa4f55d3e5db945246cce4964a610dbd91a` |
| `blueprint/methods/integral_laplace.md` | `4df521ebcba5902ea2855bf6705958a27c94ddf68d8abbaf61fee6dec7f48c95` |
| `review/PROTOCOL.md` | `7453bc0ca6985d7ca2e8c525d9655a94e412c48e3850b92d9367a9f643d3177d` |
| `blueprint/source_transcriptions/OLV97-C03-WATSON.md` | `94ea9bf00b291e82a315522fee099d0889d60967f0de0b815f92a1e1ce8b5b6b` |
| `review/classifications-v2.json` | `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9` |
| `review/classifications-v3.json` | `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e` |
| `blueprint/inventory/cards.csv` | `0f58afbb6cff4f66f4380a47a2e803346c9b06577d87c45c4089c7cb78ccc8d8` |
| `review/templates/work_packet.yaml` | `324f2da374b3b093407ecc20920647e9e9dd743d11f63fb2112265027aa5e948` |
| `review/templates/review_envelope.yaml` | `0c57f433c7e66f49cfa902b27d3e20600b6ef263cb8c4ed0ac3e064b465ae71b` |
| `review/templates/verdict.json` | `c1859f7122b537588969fca3dd10454a3dcd483176c82b770a875f2b6fc00486` |
| `lake-manifest.json` | `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404` |

## Checks run

- deterministic library inventory on the archived tree: 7 Lean files, 210 lines, 21 declarations, and no trust/resource markers;
- `python3 scripts/validate_inventory.py`: pass;
- `python3 scripts/validate_inventory.py --negative-tests`: 25 intentionally invalid copied fixtures rejected, then validation pass;
- read-only search of archived Lean files: none of the prospective IMP/QL/OLV declarations exists; no `sorry`, `admit`, or `axiom` marker exists;
- exact pinned Mathlib commit verification and declaration-source inspection as listed above.

No build was attempted because there is intentionally no candidate implementation, and no signature harness was created.
