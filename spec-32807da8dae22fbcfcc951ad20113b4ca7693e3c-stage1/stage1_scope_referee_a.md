# Independent Stage 1 scope review — referee A

## Review identity and bound snapshot

- **Verdict for this blueprint only:** `request_changes`
- **Reviewer identity:** fresh-context Sol referee; manual mathematical-scope and library-architecture review
- **Candidate commit:** `32807da8dae22fbcfcc951ad20113b4ca7693e3c`
- **Candidate file:** `blueprint/stage_1_dlmf.md`
- **Reviewed SHA-256:** `c494479f088d2be8eb3d724d8321593b7fba6563c5baefb613625645e9ad9205`
- **Reviewed size:** 554 lines
- **Snapshot check:** the clean checkout `/tmp/lmlf-stage1-scope.DbhM9YHt` was at the exact candidate commit; `git show <commit>:blueprint/stage_1_dlmf.md` reproduced the stated digest and line count.
- **Independence:** I did not read peer or historical referee reports and did not receive another referee's conclusions.

## Inputs and method

I read the exact committed bytes of `blueprint/stage_1_dlmf.md` and the relevant existing control documents: `blueprint/README.md`, `blueprint/roadmap.md`, `blueprint/source_manifest.md`, `blueprint/function_inventory.md`, and `blueprint/design_decisions.md`. I also ran the referee library inventory script as a read-only architectural orientation step. I spot-checked factual scope claims against official DLMF pages: the root, project news, errata, Chapter 4 through Chapter 10 landing pages, and selected omission-sensitive pages including §§4.13, 5.17, 5.18, 9.13, 9.14, and 10.46.

This is a programme-plan review, not a DLMF body audit, natural-language proof review, Lean authorization, code review, or claim that Chapters 4–10 have been exhaustively inspected. I did not run CI or Lean builds, inspect private source packets, edit the candidate checkout, or assess the separate preliminary Verso implementation.

## Findings

### G1 — P1 — The proposed supplement does not close normative precedence against the frozen control plane

**Evidence.** The supplement says that it supersedes the old roadmap's *programme priority* while preserving frozen artifacts (`stage_1_dlmf.md`, lines 24–37), and later asks that amendments be recorded as reviewed decisions (lines 510–515). The existing blueprint index, however, still declares `roadmap.md` the milestone authority and `design_decisions.md` the non-negotiable boundary authority (`blueprint/README.md`, lines 14–18). The frozen roadmap still states that the first source-coverage programme is Olver (`roadmap.md`, lines 8–16), while frozen DD-001 says the initial source programme is Olver and frozen DD-011 says the first true MVP is the Olver Watson occurrence (`design_decisions.md`, lines 8–16 and 107–116).

**Cost.** If this supplement is approved without an explicit precedence migration, the repository has two incompatible answers to which source programme and MVP govern execution. An implementer could legitimately follow the frozen index/roadmap/DD path and continue Olver-first, or follow the supplement and begin DLMF Stage 1. That is a programme-blocking dependency/order ambiguity even though the underlying Olver bytes and source identities are carefully preserved.

**Required change.** Make the supplement itself, or a simultaneously bound reviewed replacement decision, explicit about normative precedence. Enumerate the exact clauses being replaced (at least the Olver-first parts of roadmap scope/M5 and DD-001/DD-011), state when the replacement becomes effective, and say what happens to `OLV-MVP-1` scheduling. Update or require the update of the blueprint index so it names the new authority. Preserve the current strong rule that this scheduling change does not mutate Olver snapshots, occurrences, cards, proofs, reviews, implementation evidence, or coverage semantics.

**Blast radius and order.** Governance documents only: first approve the replacement decision, then update the index/roadmap/DD cross-references, then permit DLMF schema/audit packets. No existing theorem card, frozen packet, Lean declaration, or Olver inventory row needs alteration. Confidence: high.

### G2 — P2 — The omission-sensitive Lambert pilot's stated minimum entity seed omits entities explicitly defined on that page

**Evidence.** The Chapter 4 seed row names elementary families, generalized logarithms/exponentials, and every Lambert branch `W_k` (`stage_1_dlmf.md`, line 177); the next-step pilot calls §4.13 omission-sensitive (lines 522–524), and the paragraph after the seed says aliases are listed to force investigation (lines 185–188). But official [DLMF §4.13](https://dlmf.nist.gov/4.13) explicitly lists and defines not only the branch family but also the legacy real notations `Wp` and `Wm`, the Wright omega function, and the Tree T-function. In particular, the page gives the omega relation and `T(z) = -W(-z)`/`T exp(-T) = z`. These do not appear in the purported minimum entity leads.

**Cost.** The general body-census rule would eventually catch these objects, so this is not a scope-boundary failure. It does, however, weaken the very sentinel chosen to demonstrate that a generic family heading cannot hide specific named functions and aliases. It also leaves the pilot less effective at testing value-preserving aliases versus separately characterized derived functions.

**Required change.** Add `Wp`, `Wm`, Wright `omega`, and Tree `T` explicitly to the Chapter 4 seed/sentinel and require the pilot to classify their entity relationships and source occurrences. Treat `Wp`/`Wm` as alias candidates requiring domain/boundary-value review, not as pre-decided identities; treat omega and Tree T as separately named entities unless the reviewed entity schema supports a canonical construction plus explicit identification bridges.

**Blast radius and verification.** One seed/pilot paragraph in this blueprint, followed later by the planned Chapter 4 census. Verify it directly against the frozen §4.13 snapshot. Confidence: high.

No P0 or P3 findings.

## Clear architectural determinations

- **Mathematical scope completeness:** subject to G2, the proposed content-unit census is fit for the user's “every mathematical assertion” boundary. It includes displayed and inline formulas, prose assertions, domains and exceptions, tables, captions, applications, computation sections, repeat appearances, and independent review of every nonmathematical disposition. It correctly refuses to infer exhaustiveness from a TOC, notation list, or search index.
- **Quantitative-first versus qualitative recovery:** approved as an architecture. The finite explicit theorem is upstream; the exact DLMF qualitative meaning is recovered in consumer-only `Audit/SourceRecovery`; and a source that does not provide the bound creates honestly pending new mathematics rather than an assumed majorant. The carve-out for structural qualitative facts avoids distorting analyticity, continuation, monotonicity, uniqueness, and zero results into fake remainder claims.
- **Omissions and reference leads:** the four-way distinction among explicit assertions, internal cross-reference assertions, underspecified mathematical claims, and external mathematical reference leads is legitimate and materially important. The §10.46 example is faithful: DLMF explicitly defines generalized Bessel `phi` and Mittag–Leffler `E_(a,b)`, states without displaying the promised Laplace-transform relation, and merely refers outward for incomplete modified Bessel/Hankel functions. Blocking the underspecified claim while recording the latter as a lead avoids both omission and theorem invention.
- **Dependency closure:** the later-chapter support rule is sound. It requires an exact statement, locator, reason, consumers, and a transparent discharge route, awards no out-of-range chapter coverage, and permits an honest blocked state. Together with the explicit prohibition on target-shaped assumed records, it prevents dependency laundering.
- **Olver identity and frozen semantics:** the proposal preserves this correctly. DLMF and `SRC-OLV-*`/`OLV97-*` remain distinct source tracks; shared mathematics needs explicit per-source semantic mappings; coverage never transfers silently; `inventory-v1.0.0` remains frozen Olver-focused input; and DLMF machine authority waits for a reviewed multi-track migration. G1 concerns programme precedence, not any defect in those preservation rules.
- **Exact/non-numerical boundary:** the exclusion of evaluators, floating point, intervals, adaptive procedures, quadrature, root finding, recurrence strategies, tolerances, and software catalogues is consistent with DD-003, DD-012, and DD-020. Extracting exact identities, convergence/stability propositions, and error bounds from computational prose does not itself create a numerical implementation layer.
- **Factual spot checks:** the official DLMF root/news/errata identify Version 1.2.7 with release date 2026-06-15. Chapter titles and terminal computation/software section numbers in the Chapter 4–10 table match the official landing pages in the pages checked. This is only a spot check and not chapter-wide source certification.

## Acceptance condition

After G1 and G2 are repaired on exact reviewed bytes, I expect this blueprint to be approvable as the Stage 1 programme plan without weakening its source-audit, proof-before-Lean, manifest, provenance, dependency, or Olver-preservation controls. This verdict does not approve any future DLMF census, schema migration, theorem card, proof, signature, Lean implementation, coverage claim, or Verso presentation.
