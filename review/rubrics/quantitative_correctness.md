# Rubric: quantitative correctness

## Scope

Judge the mathematical integrity of finite identities, domains, constants,
thresholds, remainders, and derivative estimates. Do not accept a theorem merely
because Lean checks it: look for vacuity, totalization, hidden constants, and a
desired conclusion moved into the hypotheses.

For pre-Lean natural-language-proof review, apply the same checks to the proof
artifact recorded by revision and digest. A plan that omits a required analytic
or dependency step does not make the packet `lean_ready`.

## Required checks

1. Expand the quantifier order. Verify which data are uniform, which depend on
   truncation order, and whether the theorem concerns one fixed target function
   for all orders or an order-dependent family of targets.
2. Check the exact approximant and order convention at `N = 0`, small orders,
   terminating or vanishing coefficients, and boundary parameter values.
3. Verify domain inclusions, positivity/nonvanishing hypotheses, threshold
   changes, branch domains, and a nonempty witness for each concrete application.
   Generic results may be valid on empty sets but must remain labeled conditional.
4. Verify nonnegativity of every public majorant where it is used algebraically.
   Totalized division, derivatives, sums, and integrals must not hide missing
   hypotheses.
5. Trace every controlling constant, envelope, operator norm, supremum, integral,
   and threshold to an explicit input or earlier proved estimate. An existential
   constant, arbitrary structure field, or assumption equivalent to the desired
   application is hypothesis laundering.
6. Check exact algebra and cancellation before inequalities. Confirm exponent,
   factorial, geometric-margin, and scaling factors directly.
7. For integrals, verify the intended improper/Bochner semantics,
   measurability/integrability, endpoints, orientations, boundary terms, and tail
   estimates. A totalized integral expression alone is not evidence of existence.
8. For derivative transport, require neighborhood control, an explicit positive
   radius, disk or polydisk containment, boundary-to-center weight comparison,
   and the correct factorial/radius loss. Real-axis bounds plus holomorphy are
   insufficient.
9. For ODE estimates, separate residual identity, residual bound, existence,
   normalization, uniqueness, and stability. A small residual alone proves no
   solution approximation.
10. Check the packet's exact constant/domain regressions and any known negative
    examples. A smaller constant on an unrecorded smaller domain is not a
    preserved result.
11. For every entry in the packet's `targets` list, compare the reviewed proof
    plan and implementation with its exact signature and independent theorem,
    coverage, and novelty classifications. One correct helper cannot stand in
    for an unfinished named application in the same packet.

## Findings and verdict

Use `block` for a false or vacuous headline claim, forbidden trust shortcut, or
conclusion smuggled into hypotheses. Use `request_changes` for repairable missing
conditions, incorrect constants, insufficient regressions, or unproved domain
transport. Approve only when every controlling quantity and side condition has
auditable provenance.

Return the verdict outside the candidate head and bind it to the external packet
identity, artifact digests, exact candidate SHA when applicable, reviewer ID,
model/runtime, and actual isolation method.
