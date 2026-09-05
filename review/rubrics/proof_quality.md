# Rubric: proof quality

## Scope

Judge trust, robustness, readability, regression coverage, and proof-checking
cost. Keep theorem statements frozen unless another rubric identifies a statement
defect.

This is normally an implementation-stage rubric. Confirm that the external
envelope's pre-Lean gates, including `lean_ready`, passed for the same packet and
upstream artifact digests before judging the Lean proof.

## Required checks

1. Confirm that all affected modules build at the recorded head with the pinned
   toolchain. Inspect the exact command output rather than a prose assertion.
2. Search for `sorry`, `admit`, new `axiom` declarations, unsafe trust shortcuts,
   and theorem bodies replaced by assumptions. Check the axiom report for every
   changed public declaration against the packet allowlist.
3. Ensure proofs use actual regularity, integrability, nonvanishing, and domain
   hypotheses rather than favorable behavior of totalized operations.
4. Prefer named mathematical intermediate results that isolate construction,
   exact identity, residual, estimate, transport, and packaging. Reject a
   monolithic proof only when the mixture creates a concrete audit or reuse risk;
   reject fragmentation with no semantic role.
5. Check simplification hygiene: no global unfolding of special functions,
   uncontrolled simp sets, brittle dependence on incidental normal forms, or
   repeated coercion-heavy calculations that should occur in an exact coefficient
   ring.
6. Inspect reliance on declaration names, imports, typeclass search, and broad
   automation for version robustness. Ask for profiling evidence before claiming
   an elaboration-performance defect.
7. Verify exact regression declarations for order zero and small orders,
   exceptional values, endpoints, branch conventions, constants, and thresholds.
   Tests should derive from public declarations instead of reproducing private
   implementation details.
8. Confirm that documented proof status matches the code and that every maintained
   module is reachable from the intended build target or explicitly built as a
   separate audit consumer.
9. Check that custom tactics, if any, only automate repeated proved steps and
   expose side conditions. They must not invent constants, domains, or missing
   hypotheses.
10. Check every exact target signature in a multi-declaration packet and record
    missing or extra declarations. A proof of a nearby statement does not satisfy
    the packet.

## Findings and verdict

Use `block` for an unapproved axiom/trust extension, concealed unfinished proof,
or proof artifact that does not establish the claimed public theorem. Use
`request_changes` for unstable proofs, missing mandatory regressions, hidden
side-condition reliance, or concrete elaboration/import durability problems.
Approve when the implementation is axiom-compliant, auditable, and proportionally
tested at the exact reviewed head.

Return the verdict outside the candidate head. Record whether isolation was a
manual attestation or technically enforced; do not describe a fresh manual
checkout as equivalent to a hardened clean-room runner.
