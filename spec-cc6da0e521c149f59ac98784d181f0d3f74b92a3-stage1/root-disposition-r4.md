# Stage 1 DLMF programme-plan R4 root disposition

**Reviewed commit:** `cc6da0e521c149f59ac98784d181f0d3f74b92a3`  
**Parent commit:** `88a166ef0ab0db6ec57d652103328cf6dfe17a12`  
**Outcome:** `changes_required`; R4 is not accepted and DD-021 remains nonoperative

This record transcribes the decision of the primary Codex agent `/root`, acting
under authority explicitly delegated by the user. The transcriber is not a
referee. This administrative disposition earns zero review credit and is not
human review, source review, theorem approval, or implementation authority.

## Exact six-file binding

| Artifact | SHA-256 |
|---|---|
| `blueprint/stage_1_dlmf-R4.md` | `31bebd1880ea64b4e5dccc2683bf9e243cd975ce76a11ce566035a108d689afb` |
| `README.md` | `1b6a75a6fa64352014f256aa22750ae099ef4626795962f8e1c47189c1180be5` |
| `blueprint/README.md` | `a5fd4385ab8c4012307564a879ab85f05313db887610a0e831201821b86f90f2` |
| `blueprint/roadmap.md` | `e2dc5b9d1efe9af013158af511456d6a7b13538d82637a3fa1a40a6a34cb377f` |
| `blueprint/design_decisions.md` | `fd8bf1fb4befb2929816b1a4558f4ed1f24c510a75348e3d46047639250436a7` |
| `blueprint/source_manifest.md` | `d91f7aed03454ce24ed0a63e1f055848eb63e1a7fea1a3147b99ee1479b97d23` |

## Exact R4 review evidence

| Reviewer report | SHA-256 | Verdict |
|---|---|---|
| `stage1_scope_referee_g.md` | `0d5bbb5e09d0dc53e7d49489b2bd2098fb30c5584537de3f79797ed18005dab0` | `request_changes` |
| `stage1_scope_referee_h.md` | `088f3320dabe2e51db8ea5dfd7056a3dcdf8cdce887756039aef19e9e8cce87e` | `request_changes` |

Root sustains referee G's G1 and referee H's G2 as the same P1 conflict between
global programme/source terminology and legacy stage names. Root also sustains
G's G2 as a P1 semantic structural-placement defect, H's G1 as a P1
source-identity-correction gap, and H's G3 as a P2 selection/withdrawal-
authority gap. These are specification risks, not current-production
emergencies. The priority characterization does not alter either immutable
report.

## Required bounded repairs

1. **Subject-matter precedence and stage terminology.** Define precedence by
   subject matter, covering programme scope, source target, unqualified Stage 1
   terminology, priority, and semantic-versus-recovery layering. Enumerated
   legacy clauses are auditable examples, not an exhaustive source of
   precedence. Preserve the legacy release ladder as explicitly Olver-local;
   after activation, unqualified Stage 1 denotes the DLMF programme and legacy
   Olver release stages cannot supply a competing global meaning.

2. **Semantic versus recovery placement.** Ordinary reusable exact and
   structural mathematics—including genuine analyticity, continuation,
   monotonicity, sign, uniqueness, and zero-structure theorems—belongs in the
   semantic layer. Source-notation restatements and faithful source-recovery
   consumers belong downstream in `Audit/SourceRecovery`. Every genuine
   asymptotic or approximation occurrence retains the mandatory finite
   quantitative result plus separately mapped source-recovery obligation; the
   clarification may not reclassify such an occurrence as ordinary structure
   to evade either half.

3. **Typed within-snapshot source-identity corrections.** Add an append-only
   correction mechanism for erroneous payload/appearance identity decisions.
   Corrections use fresh IDs and immutable, explicitly pinned correction views;
   they never rewrite a previously closed view. They must preserve genuinely
   distinct printed source locations and repeated appearances rather than
   coalescing them merely because payload bytes or mathematics coincide.
   Canonical-alias correction and true repeated-location identity must be
   separately typed and testable.

4. **Global-closure selection, replacement, and withdrawal authority.** A
   selected global closure requires an external root record bound to the exact
   source snapshot `S`, audit/closure artifact digests, immutable correction-
   view digest, prior selection when replacing one, and two independent
   global-closure approvals. Those approvals may rely on already approved leaf
   reviews but must independently judge the complete closure.

   Withdrawal requires an external root counterevidence record and does not
   require a positive approval quorum. It must make current completion false,
   move the withdrawn selection out of the current set into pending or
   historical state as appropriate, preserve the full replayable history, and
   never fall back implicitly to an older selection. A replacement becomes
   current only through its own fully bound selection record and required
   approvals.

## Disposition boundary

R4 is not accepted, and DD-021 remains pending and nonoperative. This record
authorizes no DLMF census, schema, card/proof programme, Lean implementation,
source-coverage claim, numerical layer, global closure, or Verso projection.

An immutable R5 successor is being prepared separately. It is not bound,
reviewed, or authorized here. No R4 approval or clear-area assessment transfers
to R5; the successor requires fresh exact-byte review and root adjudication.
