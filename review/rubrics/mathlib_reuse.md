# Rubric: Mathlib reuse

## Scope

Judge whether the proposal reuses the pinned Mathlib and existing project library
appropriately. Search the checked-out sources; do not infer compatibility from a
name or from current online documentation.

This rubric may run before Lean implementation to decide whether the packet and
natural-language proof cite the right reusable foundations. Bind such a verdict
to the exact theorem-card/proof revisions and packet digest.

## Required checks

1. Confirm the exact resolved Mathlib commit and inspect local project
   declarations before searching Mathlib.
2. For each proposed definition, structure, theorem family, or analytic helper,
   record concrete search evidence and the closest candidates found.
3. Compare candidate hypotheses, conclusions, orientation, namespaces, implicit
   arguments, coercions, domains, normalizations, attributes, and required
   imports. A similar name is not a replacement.
4. Reuse canonical Mathlib objects for named functions, calculus, integrals,
   polynomials, finite sums, branches, and normed algebra when their exact API
   fits. Prefer a proved bridge theorem over a second public definition.
5. Accept a local abstraction only when it has a genuine project-specific role,
   at least two real consumers, plausible independent reuse, or isolates a
   meaningful dependency boundary. Reject wrappers that merely rename a tuple or
   obscure a canonical theorem.
6. Check whether an adapter introduces more normalization/domain noise than a
   small local theorem would. Reuse is not mandatory when the mismatch is
   mathematically material; document that decision.
7. Verify imports against the pinned source. Do not solve discovery by importing a
   broad umbrella when a stable narrow import is available.
8. If a new special-function construction is proposed, require a per-family
   availability audit before construction begins, including any Tau Ceti or other
   dependency explicitly permitted by the packet.
9. Check every target in a multi-declaration packet. A reuse decision for the
   headline theorem does not cover auxiliary definitions or general lemmas.

## Findings and verdict

Use `block` only when the work packet authorizes a duplicate/incompatible
foundational object that requires redesign. Use `request_changes` for missing
search evidence, an exact reusable declaration that was overlooked, unnecessary
heavy imports, or an unjustified wrapper. Approve when reuse decisions are based
on exact signature and dependency comparisons at the pinned revision.

Return an external verdict. Record the referee ID and, for an agent, exact model,
runtime, and actual isolation method so the structural quorum can be checked.
