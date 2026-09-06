# Administrative disposition: IMP R6 signature review round 1

**Bound snapshot:** `8af103fee3b2000033fc1e8c684645e529aaa841`  
**Disposition:** `ROOT-SIG-N1` remains open and unresolved  
**Authority:** primary Codex adjudication under the user's delegated project authority

This is an administrative disposition, not a referee report, mathematical
proof, peer-review verdict, quorum record, or human review. It counts as zero
reviewers.

## Preserved review result

Two completed independent reports bind the frozen snapshot:

- `imp_r6_signature_referee_a.md`, SHA-256
  `9e91462c473eae99a14ddfd9865c7c0c644304417b18bccf6f5c6f14800e2214`;
- `imp_r6_signature_referee_b.md`, SHA-256
  `d28bacef264aa47196c8bd910c7ba4cdb514569a3aeac6596ab47f0a1c6cd857`.

Both reports independently approve the semantic, API, and architectural design
only and reproduce the original disposable harness. Neither report detected the
outer-`True` defect in the two negative type-shape guards. Their exact bytes and
their compilation evidence are preserved unchanged as historical review
evidence.

## Primary adjudication

The two approvals do not resolve `ROOT-SIG-N1`. In particular, assertions that
the original negative checks establish missing-argument or fixed-witness
rejection do not answer the primary finding: with outer goal `True`, those
checks succeed for a reason unrelated to the intended target type shape.

Accordingly, the primary Codex agent does not accept the frozen signature
proposal. No final-card, work-packet, registry/manifest, external `lean_ready`,
production-implementation, or other downstream authorization follows from this
round, and this record does not claim that any quorum is satisfied.

The original author is preparing isolated guard repairs and signature mutants
outside the candidate. No new production mathematics is being created or
authorized. A repaired proposal must be frozen as new exact bytes and receive
fresh independent exact-byte review before the primary finding can be closed or
signature-proposal acceptance reconsidered. Older reports remain historical and
do not transfer approval to the repaired artifact.
