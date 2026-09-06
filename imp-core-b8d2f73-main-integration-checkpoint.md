# IMP-001 exact-head main-integration checkpoint

**Recorded state:** `2026-09-06T18:50:31Z`  
**Integrated main head:** `b8d2f731fcfd5cd0889d0732f13699eb94681c86`  
**Exact base:** `3a1b16cae6d186a20530de3b883c1bb871ee76f6`  
**Evidence archive commit:** `b8a53e3f1e35d2f20f6bdd835e256fcb9aff0cbd`

This is operational evidence only. It is not an independent review, a new
gate, or quorum credit. It records observations made by the primary Codex
agent `/root`, acting under authority delegated by the user; the transcriber
did not rerun the checks.

## Authority and integration

- Passing implementation envelope:
  `implementation-b8d2f731fcfd5cd0889d0732f13699eb94681c86/IMP-001-review-envelope-implementation-pass.yaml`,
  SHA-256
  `bef995a73d1695238ddcfea92a5ac54926f4a7185317f824ab62e179a21e64e3`.
- Root implementation/merge decision:
  `implementation-b8d2f731fcfd5cd0889d0732f13699eb94681c86/root-adjudication.md`,
  SHA-256
  `996426b436f18ff6e28f5f78e678e1e0f31c35f28ceca11f2b43e0075d9c4223`.
- The private evidence archive was accepted and pushed at exact commit
  `b8a53e3f1e35d2f20f6bdd835e256fcb9aff0cbd`; root read all newly archived
  records and verified all `205/205` checksums.
- Root fast-forwarded main from exact base
  `3a1b16cae6d186a20530de3b883c1bb871ee76f6` to the already reviewed exact
  candidate head `b8d2f731fcfd5cd0889d0732f13699eb94681c86` without a merge commit or new
  source bytes. The local and remote private-repository main heads are now that
  exact commit, and the main worktree is clean.

## Root-observed post-integration checks

- `lake build` passed locally: 2766 jobs, no errors, with only eight intentional
  `#check` informational messages.
- The production diff check passed.
- `scripts/validate_inventory.py --negative-tests` passed: all 25 intentionally
  invalid fixtures were rejected, followed by a valid inventory of 148
  occurrences, 31 notations, 32 entities, 34 entity-evidence rows, and 88
  occurrence associations. These 25 invalid fixtures are distinct from the 25
  mathematical regression obligations already reviewed for IMP-001.
- The GitHub repository was verified private. The workflow remains
  manual-dispatch-only; no GitHub CI was started. The latest run remains
  `34011366556`, created `2026-09-06T04:23:14Z` for old head
  `f5a5a6012a2d96d45ae365999fa778d61f38e522`.

During archive staging, an ordinary diff check identified trailing whitespace
inside immutable referee C diagram text and intentional Markdown hard breaks.
Those signed evidence bytes were preserved exactly. A command-local
`core.whitespace=-blank-at-eol` diff check then passed; no persistent Git
configuration or source byte was changed.

## Scope boundary

This checkpoint records only the exact accepted source-free IMP-001
integration. Stage 1 R5 remains `request_changes`; its separately authored R6
repair is not accepted here. Nothing in this checkpoint grants DLMF or Olver
source coverage, numerical scope, or any additional implementation authority.
