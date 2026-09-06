# QB-001 scratch build evidence

- Purpose: compile-only evidence for the unchanged eight public signatures; this is not a
  repository implementation or an acceptance verdict.
- Specification commit: `073a5675ffaba33c5bec52de00d525165aa17ff4`
- Frozen signature artifact SHA-256:
  `1959a7787ddf31477321b75bec944938f6ac2f1d77c5c14702c33b3446684f12`
- Scratch source: `QB-001-signatures.lean`
- Scratch source SHA-256:
  `d468fea8b1191bbd441a3f8fc3873fa69292b5743c176878c7946fa176bc92cd`
- Lean pin: `leanprover/lean4:v4.33.1`; resolved Lean commit
  `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`
- Mathlib pin: `v4.33.1`; resolved commit
  `0df444a360eaa60ab8c11dca51a86af692955474`
- Project manifest SHA-256:
  `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`
- Command, run from the pinned project root:
  `lake env lean /home/codex/Documents/Codex/2026-09-05/LMLF-review-evidence/scratch/QB-001-signatures.lean`
- Exit status: `0`
- Standard output and standard error: empty.

The scratch source reproduces the artifact's declaration order, namespaces, binders, implicit
arguments, and conclusions. Proof bodies are present solely to elaborate the signatures in the
pinned environment.
