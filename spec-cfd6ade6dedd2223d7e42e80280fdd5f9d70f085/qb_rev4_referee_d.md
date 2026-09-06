# QB-001 revision 4 — independent pre-Lean review D

## Verdict

**APPROVE** (`approve`). I found no P0–P3 defect in the frozen three-definition/five-lemma specification, its normative natural-language proof routes, its classification, or its review-governance boundary.

This is one external pre-Lean referee verdict. It does **not** itself set the composite `lean_ready` gate or authorize implementation; only a conforming external review envelope may do that after the packet's quorum requirements are met.

## Exact binding and isolation attestation

- Reviewer ID: `qb_rev4_referee_d`
- Model/runtime: `gpt-5.6-sol`
- Method: **manual fresh read-only exact commit/exact SHA**
- Repository used as the Git object source: `/home/codex/Documents/Codex/2026-09-05/yo`
- Exact specification commit: `cfd6ade6dedd2223d7e42e80280fdd5f9d70f085`
- Exact commit tree: `283fd199890c36c8fb1d7af8f618af8e5982c3e1`
- Work packet: `review/work_packets/QB-001.yaml`
- Work-packet SHA-256: `5c45ca1bafdcbc96054ca11bf239bd66d04540464bbc80525af1546b7b63ae9e`

I reviewed only committed blobs obtained with `git show`/`git cat-file` at the exact SHA and a disposable `git archive` of that SHA. I ignored all untracked Gamma/Audit material, did not inspect any other review report, and made no repository edit. The content of the historical rev-3 review was not opened; its packet-recorded digest was checked mechanically against the committed blob stream only. The compile harness and generated build products lived under `/tmp/qb_rev4_referee_d.L1pA3N`.

## Artifact identity, revision, and freeze audit

All recorded SHA-256 values reproduce exactly from the committed bytes:

| Artifact | Recorded revision/state | Recomputed SHA-256 | Result |
|---|---|---|---|
| `review/classifications-v1.yaml` | schema `lmlf-classification-v1`, frozen | `7a4f322bb56dbb40d5d44a7eceb50b5a49ea6ae69f414b920341e3b12ea9d71e` | match |
| `blueprint/theorem_cards/QB-001.yaml` | revision 4, frozen | `f470845b382e563ea23dbc850ab223cc5a11bc1504fe97cfb399eb9f457b6d46` | match |
| `blueprint/theorem_cards/QB-001-signatures.md` | revision 2, frozen | `93e4e30a93087de95342abdb1e986676924cd93512e771737d0d3f3ed7973b39` | match |
| `blueprint/proofs/QB-001.md` | revision 4, frozen/complete | `3513fb1acf141066eb9a4920c1ea238c778d66976ff8479d31c742df93d3a2a5` | match |
| historical `blueprint/reviews/QB-001-rev3.md` | revision 2, authority `none`, non-quorum | `4b0e8157ebaeb5101916154515094dc82ddffbace4b753ba8b892877cc0df055` | match |

The work packet is schema version 3 and `lifecycle_state: frozen`; it deliberately omits its own path, commit, and digest so an external envelope can bind them without self-reference (`review/work_packets/QB-001.yaml:1-7`). The theorem card is revision 4 and frozen (`blueprint/theorem_cards/QB-001.yaml:1-21`), the proof is revision 4 and frozen/complete (`blueprint/proofs/QB-001.md:1-9`), and the signature artifact is revision 2 and frozen (`blueprint/theorem_cards/QB-001-signatures.md:3-10,56-65`). The packet's artifact IDs, revisions, and hashes are internally consistent (`review/work_packets/QB-001.yaml:35-65`).

## Exact public API audit

The signature artifact contains exactly eight declarations in the frozen order: three definitions followed by five lemmas, and no ninth declaration (`blueprint/theorem_cards/QB-001-signatures.md:8-53`). The work packet independently lists the same targets and exact signatures (`review/work_packets/QB-001.yaml:67-264`), while the theorem card lists the identical public names and explicitly excludes the dossier's later results (`blueprint/theorem_cards/QB-001.yaml:33-65`).

### Definitions

1. `ErrorOn D f a b := ∀ x ∈ D, ‖f x - a x‖ ≤ b x` is the intended pointwise error predicate.
2. `NormBoundOn D f b := ∀ x ∈ D, ‖f x‖ ≤ b x` is the intended pointwise norm-majorant predicate.
3. `HasErrorFamily f a D b := ∀ n, ErrorOn (D n) f (a n) (b n)` fixes `f` outside the natural-number binder and indexes only `a`, `D`, and `b`.

These reproduce the proof dossier's definitions (`blueprint/proofs/QB-001.md:25-54`) and the exact Lean text (`blueprint/theorem_cards/QB-001-signatures.md:17-28`). Domains may be empty, and no continuity, measurability, decidability, or global majorant nonnegativity is smuggled into the predicates. Satisfaction itself forces majorant nonnegativity only on the active domain, as correctly explained at `blueprint/proofs/QB-001.md:56-64`.

The fixed-target semantics are unambiguous: `f : X → E` does not depend on `n`; the definition asserts only one finite inequality per index. It entails no convergence of `a n` to `f`, no decay or monotonicity of `b n`, no eventual domain membership, and no finite-expansion representation (`blueprint/proofs/QB-001.md:43-54`; `blueprint/theorem_cards/QB-001.yaml:79-96`).

### Lemmas and proof routes

1. `ErrorOn.exact`: from `Set.EqOn f a D`, each residual is zero, so its norm is zero and the zero majorant is exact. This is only the forward exactness statement selected from QB-001.5 (`blueprint/proofs/QB-001.md:214-218`; `blueprint/theorem_cards/QB-001.yaml:61-65`).
2. `ErrorOn.restrict`: `hD : D' ⊆ D` transports membership from the conclusion domain to the premise domain. The direction is correct—large domain to subset—and remains valid vacuously on empty domains (`blueprint/proofs/QB-001.md:70-92`).
3. `ErrorOn.weaken`: the required comparison is `b x ≤ d x` on `D`, so `‖f x-a x‖ ≤ b x ≤ d x`. This enlarges, rather than strengthens, the majorant (`blueprint/proofs/QB-001.md:98-132`).
4. `ErrorOn.trans`: the shared intermediate `a` gives `f x-c x = (f x-a x)+(a x-c x)`; `norm_add_le` and addition monotonicity yield exactly the additive loss `b x + d x`. Neither `max` nor either summand would suffice in general (`blueprint/proofs/QB-001.md:138-178`).
5. `ErrorOn.comp`: `Set.MapsTo ψ S D` has the necessary direction `y ∈ S → ψ y ∈ D`; applying the source estimate at `ψ y` gives the three precomposed functions and bound. This is pullback/precomposition only, with no false postcomposition, injectivity, surjectivity, continuity, or differentiability requirement (`blueprint/proofs/QB-001.md:330-355`).

The dossier contains broader mathematics, and QB-001.5 itself discusses additional equivalences, but the frozen card makes only forward exactness normative and says extra dossier sections do not enlarge this bootstrap (`blueprint/theorem_cards/QB-001.yaml:55-65,108-122`). The packet likewise excludes every other dossier result (`review/work_packets/QB-001.yaml:402-410`). Therefore the bounded 3+5 scope is not ambiguous.

## Binder, typeclass, dependency, and import audit

- Binder order, implicitness, and conclusions match the frozen signature artifact exactly. `#check @...` in the disposable build confirmed implicit `X`, `Y`, and `E` type parameters where used, the `NormedAddCommGroup E` instance, the declared argument order, and the explicit `ψ` following implicit `S` in `comp`.
- `NormedAddCommGroup E` supplies subtraction, norm, and the triangle inequality. It is sufficient and coherent with the stated ambient contract, and no field, scalar, topology, measurability, decidability, nonempty-domain, or classical hypothesis is missing. (A seminormed group could support this forward-only subset, but the frozen choice of a genuine normed group is not a correctness or usability defect.)
- The sole allowed import is `LMLF.Basic`; at the exact commit it imports only `Mathlib.Analysis.Normed.Group.Basic` (`LMLF/Basic.lean:1`). That import exposes `Set`, `Set.EqOn`, `Set.MapsTo`, function composition, ordered real bounds, subtraction, `norm_add_le`, and the needed additive/order laws.
- The committed toolchain is Lean `4.33.1`; the manifest pins Mathlib to `0df444a360eaa60ab8c11dca51a86af692955474`, matching `review/work_packets/QB-001.yaml:268-280` and the local dependency used for the disposable check.
- There are no accepted LMLF work-item dependencies, so the import direction is foundational and acyclic.

Disposable verification from the exact archive:

- `lake build LMLF.Basic` — success (`1321/1321` jobs).
- `lake env lean QB001Review.lean` — success, no diagnostics. The harness reproduced the exact eight signatures and supplied independent direct proofs for all five lemmas.
- `#print axioms` for all eight declarations reported exactly `[propext, Classical.choice, Quot.sound]`, the packet's allowed set (`review/work_packets/QB-001.yaml:412-428`). No `sorry`, `admit`, custom axiom, `unsafe`, heartbeat override, or extra import was used.

## Classification and governance audit

`non_novel` is the correct packet- and target-level classification. The controlled vocabulary defines it for definitions, routine consequences, and direct wrappers with no claim of new mathematics, while `source_equivalent` requires a specifically bound external source (`review/classifications-v1.yaml:66-85`). These three local predicates and five elementary set/norm transports fit that definition exactly. The packet assigns every target `non_novel` with relationship prose and makes no external source-coverage claim (`review/work_packets/QB-001.yaml:14-42,67-264`).

The structural-circularity review is properly `not_applicable`: there is no named-source identification, continuation, existence/uniqueness construction, hidden choice, or theorem-sized carrier capable of assuming a desired analytic result. Every conclusion follows by direct unfolding, membership transport, order transitivity, a norm triangle inequality, or pullback. The packet gives this concrete reason and requires external `not_required` for the gate (`review/work_packets/QB-001.yaml:317-332`), consistent with the protocol's criteria (`review/PROTOCOL.md:125-150`).

The historical-nonquorum firewall is explicit and adequate. The recorded rev-3 artifact has `authority: none` and `counts_toward_quorum: false` (`review/work_packets/QB-001.yaml:59-65`); the card records no current external verdict and explains why the historical ledger cannot establish identity, isolation, exact-revision binding, quorum, or authorization (`blueprint/theorem_cards/QB-001.yaml:195-204`). The proof repeats that it neither approves revision 4 nor authorizes Lean work (`blueprint/proofs/QB-001.md:1094-1105`).

Finally, authorization is external-only and currently absent from candidate-owned state. The card's review and implementation statuses remain `not_started`, its baseline commit is intentionally pending external binding, and its status-authority clause reserves approval to an external envelope (`blueprint/theorem_cards/QB-001.yaml:5-21`). The implementation block requires an envelope binding this frozen commit, card revision 4, proof revision 4, and signature revision 2 with the requisite gate results (`blueprint/theorem_cards/QB-001.yaml:206-214`). The work packet likewise states that fresh verdicts and any `lean_ready` authorization must live in an external envelope bound to the exact commit and digests (`review/work_packets/QB-001.yaml:430-436`).

## Disposition

No findings. I approve both the frozen theorem-card/signature contract and its normative natural-language proof routes at exact commit `cfd6ade6dedd2223d7e42e80280fdd5f9d70f085`, and I confirm the packet's structural-circularity `not_applicable` classification. This verdict may be referenced by the external envelope as one independent referee record; it must not be interpreted alone as composite `lean_ready` authorization.
