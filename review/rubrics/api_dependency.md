# Rubric: API and dependency design

## Scope

Judge public theorem shape, abstraction boundaries, discoverability, and
dependency direction. Review the intended downstream consumers and frozen work
packet before recommending a more general API.

## Required checks

1. Inspect every item in the packet's `targets` list. Verify its exact signature,
   independent `theorem_class`, `coverage_class`, and `novelty_class`, scope, and
   real intended consumer. Implementation helpers should be private or narrowly
   namespaced.
2. Prefer the weakest natural assumptions and strongest reusable conclusion, but
   do not remove hypotheses that intentionally define a stable abstraction
   boundary without checking downstream intent.
3. Check binder order, implicit arguments, conclusion orientation, namespaces,
   names, coercions, and attributes against project and Mathlib conventions.
4. Ensure an API name matches its logical content. In particular, a family of
   arbitrary approximants is not a "finite expansion" unless finiteness or a
   finite constructor is actually represented.
5. Keep exact identities separate from estimates, definitions separate from
   applications, and general quantitative infrastructure independent of named
   special functions.
6. Reconstruct the import graph. Dependencies must flow from foundations to
   definitions to methods to applications. Reject umbrella-import cycles,
   downstream imports in construction/identification files, and tactic imports
   in semantic foundations.
7. Check that branch support, source-function construction, identification,
   comparison envelopes, and asymptotic applications remain distinct layers.
   Baseline identification may not depend on the estimate that uses the object.
8. Require coherent reusable seams rather than a speculative universal
   typeclass. Conversely, factor repeated concepts when two consumers exist or a
   split removes a substantial dependency.
9. Inspect import and migration blast radius for public changes. Verify every
   in-repository call site and maintained root import.
10. Confirm that the implementation follows the packet's dependency IDs and does
    not silently perform a later milestone or create an undocumented prerequisite.
11. At pre-Lean review, reject a target list whose exact signatures, theorem-card
    bindings, proof-artifact bindings, or dependency order are incomplete. Such a
    packet is not `lean_ready` even if its prose is persuasive.

## Findings and verdict

Use `block` for a circular definition/estimate dependency, a misplaced
foundational object that reverses the roadmap DAG, or an incompatible public API
requiring packet redesign. Use `request_changes` for fixable theorem-shape,
placement, naming, visibility, or import issues. Do not report taste preferences
without a concrete downstream or maintenance cost.

Return the verdict outside the candidate head, bound to the external review
identity and exact reviewer/runtime/isolation metadata.
