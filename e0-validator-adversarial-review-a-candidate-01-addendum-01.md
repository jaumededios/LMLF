# Addendum 01 to E0 validator adversarial review A — candidate 01

## Exact artifact amended

This is an append-only clarification of `e0-validator-adversarial-review-a-candidate-01.md` and does not alter that report or the candidate.

- original report SHA-256: `48e2d6915ab6fdb0a47c6a941df622795eea791cdb8cd06f12a935ec5421068f`
- candidate commit: `26f4051e13f3a7bc558c225138458f211bf31597`
- candidate tree: `85bc0bbd802c2ae8044a3bf4f66e6f5cb00b542c`
- accepted contract SHA-256: `e3dacb11c97ec059ae8f48e3fc81f3155fbf86c2cd5679c69541852c2d1fdc7b`

## Reviewer and isolation metadata

- durable reviewer ID: `e0-validator-adversarial-review-a`
- Codex task identity: `/root/e0_validator_adversarial_review_a`
- requested model: `gpt-5.6-sol`
- requested reasoning effort: `high`
- serving build: not independently verified; none claimed
- runtime: Codex desktop agent in the supplied Linux workspace/container
- reviewer kind: `agent`
- isolation strength: `manual_attestation`
- isolation method: fresh-context exact-head review; repository inputs treated as untrusted; local tools only; no external API or network calls; no other referee reports read; no candidate edits; adversarial mutations performed in memory or in automatically removed temporary directories

## Withdrawal of one A1 subclaim

I withdraw only the original A1 subclaim that a `card-binding` or `exact-signature-binding` request must also store separate rows for every lower level, and I withdraw the associated requested correction to enforce cumulative level presence.

There is no exact normative sentence in draft-04 requiring cumulative historical rows. The sentence “Validation has exactly these ordered levels” defines the increasing obligations and accepted states of the three level tokens; it does not say that validating a higher level requires duplicating lower-level rows. The later statement that ordinary and quantitative cardinalities “remain invariant at all levels” is correctly read as applying at each level that is requested/supplied, not as a requirement that all three levels always be present.

A precise valid interpretation is therefore:

- a `source-batch`-only request is valid when all required role rows for that level exist and its card/declaration endpoints are explicitly pending, or any supplied endpoint is typed and consistent, with no frozen card, declaration, or signature claimed at that level;
- a `card-binding`-only request is valid when all required role rows for that level bind exact frozen cards and frozen source-facing targets, quantitative cards are distinct, and each declaration is either explicitly pending or is a proposed declaration with a nonbinding signature sketch;
- an `exact-signature-binding`-only request is valid when all required role rows for that level bind exact frozen cards, distinct cards/declarations for a quantitative atom, exact declarations in an independently reviewed frozen signature packet, and the exact selected pre-signature gate bundle;
- if multiple levels are supplied, each supplied level must independently satisfy its own field/state/cardinality obligations. Their semantic ordering does not require persisted lower-level history.

Accordingly, my two tests showing acceptance of `card-binding`-only and `exact-signature-binding`-only data are not defects under the accepted minimum and should not be used in disposition or adjudication.

## Findings and verdict that remain unchanged

The seven independently reproduced contradictory A1 state combinations remain valid findings. They concern the obligations of the level actually supplied, not missing lower-level history:

1. `source-batch`, `endpoint_state=pending`, but `card_state=frozen`;
2. `source-batch`, `endpoint_state=pending`, but `declaration_state=frozen`;
3. `source-batch`, `endpoint_state=pending`, but `signature_kind=exact_signature`;
4. `card-binding` with bound card/target data but `endpoint_state=pending`;
5. `card-binding` with a named/sketched declaration but `declaration_state=pending`;
6. `card-binding` with `declaration_state=frozen` and `signature_kind=none`;
7. `exact-signature-binding` with `endpoint_state=pending`.

Those accepted combinations still violate the explicit per-level state distinctions. The required A1 correction is limited to enforcing a closed, internally consistent field/state matrix for each requested level and adding focused tests for those seven cases; it does not require lower-level rows.

A2 and A3 remain unchanged. The exact-head verdict remains **`request_changes`** for candidate `26f4051e13f3a7bc558c225138458f211bf31597`.

This addendum creates no approval, review quorum, source/coverage/Lean/integration credit, or authority. A corrected successor candidate still requires fresh exact-head review.
