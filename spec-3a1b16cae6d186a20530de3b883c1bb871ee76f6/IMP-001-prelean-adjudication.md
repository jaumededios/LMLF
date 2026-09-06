# IMP-001 final pre-Lean adjudication

**Decision authority:** primary Codex agent `/root`, acting under the user's delegated project authority  
**Specification commit:** `3a1b16cae6d186a20530de3b883c1bb871ee76f6`  
**Pending envelope:** `IMP-001-review-envelope-pending.yaml`, SHA-256 `62d1d8e1530b02f63dedda505c925291d7453c16faf65d81919799a69f243b52`  
**Decision:** final pre-Lean gates `pass`; composite `lean_ready` `pass`

This administrative adjudication counts as zero reviewers and is not human
review. It records the gate decision supported by the exact external referee
verdicts below. It does not alter any report or verdict.

## Exact specification binding

| Bound item | Revision | SHA-256 or exact value |
|---|---:|---|
| `review/work_packets/IMP-001.yaml` | 1 | `e0f16a660417d967312df0f7cc7ce12ea1243226801b409475548566d594796b` |
| `blueprint/theorem_cards/IMP-001.yaml` / `TC-IMP-001-R7` | 7 | `d81f8970bcba3bf1a489f8cb4fea8b303a3e3bf6d1ad3ade37b42f3094b528c4` |
| `blueprint/proofs/IMP-001-R7.md` / `NLP-IMP-001-R7` | 7 | `941ca0f2a7e402e9dd3636d7c93744290b3f5b52b8705484c18630c6fe173548` |
| `blueprint/theorem_cards/IMP-001-signatures-R6.md` / `SIG-IMP-001-R6-P2` | 2 | `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d` |
| `review/classifications-v3.json` / `lmlf-classification-v3` | 3 | `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e` |
| Lean toolchain | — | `leanprover/lean4:v4.33.1` |
| Resolved Mathlib revision | — | `0df444a360eaa60ab8c11dca51a86af692955474` |

Candidate implementation `base_sha` and `head_sha` are null because this is a
pre-Lean specification decision. The packet is source-free `IMPROPER-0`: one
card, eight targets, and zero source occurrences.

The primary agent independently rehashed every report and verdict and
programmatically joined every packet, card, proof, signature, classification,
toolchain, rubric, reviewer, and pending-envelope binding. All seven verdicts
are `approve` with empty findings.

## Exact referee evidence

| Reviewer | Artifact | Gate or role | SHA-256 |
|---|---|---|---|
| `/root/imp_final_referee_a` | `imp_final_referee_a.md` | report | `cd55528c1d0290938c1af4e0c78298a74c344498116137130c86cc93e2cc0a52` |
| `/root/imp_final_referee_a` | `IMP-001-theorem_card_review-imp_final_referee_a.json` | theorem-card review | `aa892f84d567df30bb4750da382881fd14cae12f904f4eb5a3a0d28dda9dae32` |
| `/root/imp_final_referee_a` | `IMP-001-natural_language_proof_review-imp_final_referee_a.json` | natural-language-proof review | `7931dae4a4df7eda90c7c445733373ec76851967252e94f72038634980bfd838` |
| `/root/imp_final_referee_b` | `imp_final_referee_b.md` | report | `60767187050513725a036fb777b920833cef3b67effac54c2d2ca8e5988ba60e` |
| `/root/imp_final_referee_b` | `IMP-001-theorem_card_review-imp_final_referee_b.json` | theorem-card review | `bef190f91d3d90188e0c049145a26b8a3104e2c49129e8af85385e4d7e0ffc87` |
| `/root/imp_final_referee_b` | `IMP-001-natural_language_proof_review-imp_final_referee_b.json` | natural-language-proof review | `2d1c4b077ec71e09284d7a8cc4d23cedb9dc302132fd0b90e9dbfe782a3d9498` |
| `/root/imp_final_referee_c` | `imp_final_referee_c.md` | report | `24a708e4154db6d30ea676ac9ab9984d5b2af5914354b114a4efbd3c0ef311f2` |
| `/root/imp_final_referee_c` | `IMP-001-structural-dependency_direction-imp_final_referee_c.json` | dependency direction | `4465ae9563ddfe212457163708124e97cf59e24bd18c10e2c0dd1065af74ba00` |
| `/root/imp_final_referee_c` | `IMP-001-structural-source_to_target_reachability-imp_final_referee_c.json` | source-to-target reachability | `b46b8ca8fbf308627c58da7875d5f31914af0dd2f1c4798570d88fd66dc66feb` |
| `/root/imp_final_referee_c` | `IMP-001-structural-hypothesis_and_choice_laundering-imp_final_referee_c.json` | hypothesis and choice laundering | `d9ec7dfc4f8b419fed8e6e1f62d2f4077f4d3c13bb4d87f7827bb9c03db47642` |

Every verdict binds the immutable pending envelope, exact specification commit,
packet/card/proof/signature/classification/toolchain identities above, null
candidate SHAs, and its declared rubric. Integer and string renderings of
revision values normalize to the same positive revisions; no JSON byte was
rewritten.

## Quorum and isolation adjudication

The reviewer union is exactly three distinct fresh agent IDs:

- `/root/imp_final_referee_a`;
- `/root/imp_final_referee_b`; and
- `/root/imp_final_referee_c`.

No proposer, author, primary adjudicator, or evidence archiver identity counts
toward the union. No human review credit is claimed.

- Theorem-card gate: `/root/imp_final_referee_a` and
  `/root/imp_final_referee_b`; selected composition 0 humans, 2 agents, minimum
  1 distinct agent model.
- Natural-language-proof gate: the same two distinct IDs; selected composition
  0 humans, 2 agents, minimum 1 distinct agent model.
- Structural-circularity gate: `/root/imp_final_referee_c`; selected composition
  0 humans, 1 agent, minimum 1 distinct agent model; all required perspectives
  `dependency_direction`, `source_to_target_reachability`, and
  `hypothesis_and_choice_laundering` are represented by three verdicts.
- Overall union: 3 distinct reviewer IDs, satisfying the packet minimum.

All three reviewers used `gpt-5.6-sol`. Their isolation strength is accurately
recorded as `manual_attestation`, not technical sandboxing. Fresh sessions and
distinct durable IDs satisfy the selected compositions; no model-diversity or
human-review waiver is used.

## Root decision and exact scope

The primary Codex agent adjudicates the theorem-card,
natural-language-proof, and structural-circularity gates `pass`, and authorizes
composite `lean_ready: pass`, only for the exact eight IMP-001 core targets and
their private proof support at specification commit
`3a1b16cae6d186a20530de3b883c1bb871ee76f6`.

This authorization permits the bounded production Lean implementation stage;
it is not production implementation acceptance. This gate supplies no Lean
authorization for QL, OLV, new analytic examples, or the future analytic-
regression companion, and it grants no source-coverage or numerical scope.
Drafting and refereeing that companion remains an allowed separate next step
under the existing project scope.

All IMP-R01 through IMP-R25 mathematical regression obligations remain
mandatory under their packet stages. Before any future new analytic example or
counterexample is formalized, a complete separately bound natural-language
companion must be frozen and receive at least two fresh independent reviews.

No finding is waived: all seven final verdicts contain empty findings. The
separate disposition ledger therefore has `findings: []`. Implementation and
merge review gates remain pending, and no merge decision follows from this
pre-Lean adjudication.
