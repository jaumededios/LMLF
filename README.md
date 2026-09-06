# LMLF review evidence archive

This orphan branch preserves review reports, review envelopes, verdicts, and related review records imported from the existing `LMLF-review-evidence` archive on 2026-09-06.

The initial 93 imported files are byte-for-byte copies of the source archive,
using an allowlist limited to Markdown, JSON, YAML, and YML. Later operational
checkpoints and completed external review records may be added in separate
commits without rewriting historical evidence. `SHA256SUMS` records every
archived evidence and operational file currently in this tree; it intentionally
excludes this README and itself.

This tree is historical evidence only. It is not candidate implementation, and it is not an authority for current implementation or review status. Any historical approval binds only the commit recorded in that approval; it does not transfer to a later commit.

Evidence for `spec-a955c06` is absent from the source archive, even though the review conversation reported a completed mathematical approval. No record for that approval has been recreated here, and this archive does not claim that it was archived.

Excluded source artifacts:

- `scratch/QB-001-signatures.lean` (Lean source; outside the evidence-file allowlist)
- `spec-f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de/qb_final_referee_c.md.sha256` (legacy checksum sidecar; regenerated checksums are provided centrally)

Source PDFs, OCR output, page images, credentials, and caches are not archived
in this tree.
