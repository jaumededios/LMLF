# Pre-Lean authorization and disposition

- Adjudicator: `/root/prelean_envelope`
- Issued UTC: `2026-09-05T19:05:46Z`
- Specification commit: `1a7a1864e3f7c343b8c6f90511689d7a7b1a88d9`
- Toolchain: `leanprover/lean4:v4.33.1` (observed Lean 4.33.1)
- Mathlib revision: `0df444a360eaa60ab8c11dca51a86af692955474`
- Reviewer union: `/root/prelean_green_k`, `prelean_green_l` (two distinct fresh-context agent reviewers; selected composition: 0 humans, 2 agents, minimum 1 distinct agent model)
- Supplemental narrative evidence: [`prelean_green_k.md`](prelean_green_k.md), SHA-256 `a537ee0cf5f04ccacb475877c1e2443c9f2e3cded91ada44bd07ced4aa411fa4`; [`prelean_green_l.md`](prelean_green_l.md), SHA-256 `7a616cb60f7e20dc398e60f206ab1db8ad56e7bb26e26b7271ae36191b9da1f0`

## Structured verdict set

| Work item / gate | Reviewer | Verdict record and ordinary SHA-256 |
|---|---|---|
| QB theorem card | `/root/prelean_green_k` | [`QB-001-theorem_card_review-prelean_green_k.json`](QB-001-theorem_card_review-prelean_green_k.json), `b15ea2f3d58c770a70276c8d1379450ec576682892c787c4e4cfd60ed20f7e6a` |
| QB theorem card | `prelean_green_l` | [`prelean_green_l.QB-001.theorem_card_review.json`](prelean_green_l.QB-001.theorem_card_review.json), `0ac7712ea63961be4868cd9adb8cc19a5036d7ceeca02c46a82d8ebb23297c16` |
| QB NLP | `/root/prelean_green_k` | [`QB-001-natural_language_proof_review-prelean_green_k.json`](QB-001-natural_language_proof_review-prelean_green_k.json), `9e050695900a4eabcfc61d6779db476e922e107d9062786001d457d295c5eab1` |
| QB NLP | `prelean_green_l` | [`prelean_green_l.QB-001.natural_language_proof_review.json`](prelean_green_l.QB-001.natural_language_proof_review.json), `9794f6c997a21b07a9a59eab4b9bbfab722029fde3a363ea21026add547dad2c` |
| QB structural | `/root/prelean_green_k` | [`QB-001-structural_circularity_review-prelean_green_k.json`](QB-001-structural_circularity_review-prelean_green_k.json), `dfca27e088528112521e4f929bea1c35f0237c3edabd06e7b260dfc0c9d7cb46` |
| QB structural | `prelean_green_l` | [`prelean_green_l.QB-001.structural_circularity_review.json`](prelean_green_l.QB-001.structural_circularity_review.json), `272e316f21db772e3d24fe2e2e0303ee50ee8e8f0b6e869709ac93df746e8aee` |
| DEF theorem card | `/root/prelean_green_k` | [`DEF-001-theorem_card_review-prelean_green_k.json`](DEF-001-theorem_card_review-prelean_green_k.json), `92aa3ccf4e84adf7804422ffd7727bf4a97ea6e925cc40aec9875aca9f19af2b` |
| DEF theorem card | `prelean_green_l` | [`prelean_green_l.DEF-001.theorem_card_review.json`](prelean_green_l.DEF-001.theorem_card_review.json), `2468ea1f76f34e830be2469c5bd229290623f2f628a9dbadb5505ad05a6d3310` |
| DEF NLP | `/root/prelean_green_k` | [`DEF-001-natural_language_proof_review-prelean_green_k.json`](DEF-001-natural_language_proof_review-prelean_green_k.json), `6a89baa5e39b0aebbdb4f3175b026e921e8d0813ed7ddbf4d4050bb41511d36a` |
| DEF NLP | `prelean_green_l` | [`prelean_green_l.DEF-001.natural_language_proof_review.json`](prelean_green_l.DEF-001.natural_language_proof_review.json), `4a4c320f451e016e9e6bf067df566d5cff171bfe27c8192da95ec0ffbd7d2f0c` |
| DEF structural | `/root/prelean_green_k` | [`DEF-001-structural_circularity_review-prelean_green_k.json`](DEF-001-structural_circularity_review-prelean_green_k.json), `4e4503bcb4797d5fb7de177ecb5c9488f4eff68b6ef747d34817b068096fe9b2` |
| DEF structural | `prelean_green_l` | [`prelean_green_l.DEF-001.structural_circularity_review.json`](prelean_green_l.DEF-001.structural_circularity_review.json), `4512b826d3132a8c00eabb011d308952de89acd786a493b60195efa9e95b74b0` |

## QB-001

The frozen packet, card R7, signature artifact R2, proof R6, classification R2, and dependency pins reproduce their bound digests. Both reviewers approve the theorem card and required natural-language proof, satisfying both two-agent quorums. Both confirm the packet's structural-review inapplicability. The external envelope therefore records theorem-card `pass`, NLP `pass`, structural `not_required`, and composite `lean_ready: pass`.

Disposition: no P0--P3 or other actionable pre-Lean finding is reported; the finding set is empty, so no open disposition remains. Candidate binding is null. Implementation review and merge remain pending.

## DEF-001

The frozen packet, card R4, classification R2, and dependency pins reproduce their bound digests. Both reviewers approve the theorem card, satisfying its two-agent quorum. Both confirm the packet's NLP and structural-review inapplicability. The external envelope therefore records theorem-card `pass`, NLP `not_required`, structural `not_required`, and composite `lean_ready: pass`.

Disposition: no P0--P3 or other actionable pre-Lean finding is reported; the finding set is empty, so no open disposition remains. Candidate binding is null. Implementation review and merge remain pending.
