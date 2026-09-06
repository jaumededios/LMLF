# Independent Stage 1 scope/architecture review — referee H

## Verdict

**`request_changes`**

The proposal is substantially stronger than an ordinary roadmap: it gives the
Chapter 4--10 source universe a semantic occurrence denominator, keeps Chapters
1--3 and later chapters consumer-bounded, separates source-audit batches from
Lean execution manifests, makes quantitative obligations non-waivable, and
keeps source recovery downstream. Its DLMF discovery claims checked out.

Three bounded specification defects remain. G1 leaves the append-only identity
lifecycle unable to recover from exactly the source-appearance mistakes that
the required negative fixtures detect. G2 leaves two incompatible unqualified
meanings of “Stage 1” operative. G3 does not identify the authority or exact
external binding needed to replace or withdraw the selected global closure,
even though that decision changes the current whole-programme denominator.

This verdict reviews a plan, not a source census, schema implementation, theorem
card set, Lean implementation, or Verso implementation. None of those absent
artifacts was treated as required evidence of plan validity.

## Review identity and snapshot

- Reviewer ID: `stage1_scope_referee_h`
- Reviewer kind: `agent`
- Model: `gpt-5.6-sol`
- Reasoning effort: `high`
- Review stage/perspective: blueprint architecture and source-scope review;
  principally `source_semantics` and `dependency_direction`
- Timestamp: `2026-09-06T18:12:39Z`
- Runtime: Codex desktop agent in a Linux 5.15.0-190-generic x86_64 container;
  Git 2.39.5, Python 3.11.2, curl 7.88.1
- Isolation strength: `manual_attestation`
- Isolation method: fresh agent context and a new detached worktree at
  `/tmp/lmlf-stage1-referee-h.m3W9es`, checked out directly at the reviewed
  commit. This was not a technically enforced clean room. The runtime had
  network access, credentials/tools may have existed, and the filesystem was
  shared and writable. I did not delegate any part of the review.
- Reviewed commit: `cc6da0e521c149f59ac98784d181f0d3f74b92a3`
- Candidate state observed before and after checks: detached, clean HEAD at the
  reviewed commit
- Restrictions observed: no fetch, pin mutation, candidate edit, commit, push,
  GitHub CI, production build, predecessor-scope-plan inspection, peer-report
  inspection, disposition inspection, other-worktree content inspection, or
  Verso-work inspection

## Exact reviewed successor bytes

All six requested SHA-256 digests matched:

| Path | SHA-256 |
|---|---|
| `blueprint/stage_1_dlmf-R4.md` | `31bebd1880ea64b4e5dccc2683bf9e243cd975ce76a11ce566035a108d689afb` |
| `README.md` | `1b6a75a6fa64352014f256aa22750ae099ef4626795962f8e1c47189c1180be5` |
| `blueprint/README.md` | `a5fd4385ab8c4012307564a879ab85f05313db887610a0e831201821b86f90f2` |
| `blueprint/roadmap.md` | `e2dc5b9d1efe9af013158af511456d6a7b13538d82637a3fa1a40a6a34cb377f` |
| `blueprint/design_decisions.md` | `fd8bf1fb4befb2929816b1a4558f4ed1f24c510a75348e3d46047639250436a7` |
| `blueprint/source_manifest.md` | `d91f7aed03454ce24ed0a63e1f055848eb63e1a7fea1a3147b99ee1479b97d23` |

## Materials read

I read all six successor files in full. I also read the applicable current
control material needed to interpret their operative clauses:

- `blueprint/theorem_cards/README.md`
- `blueprint/function_inventory.md`
- `review/README.md`
- `review/PROTOCOL.md`
- all five current review rubrics under `review/rubrics/`
- the “Alternate editions and corrections” clause of
  `blueprint/qualitative/release_strategy.md`, plus that document's purpose,
  manifest, and staged-release clauses needed to assess continuing authority
- the “Initial documentation slice” and anti-overclaiming clauses of
  `blueprint/qualitative/navigation_and_docs.md`
- `lakefile.toml`, `lean-toolchain`, and the resolved Mathlib entry in
  `lake-manifest.json`
- the complete `referee-lean-library` skill, its complete global rubric, and
  its research-basis reference

No applicable `AGENTS.md` existed in the checkout or its `/tmp` ancestors.
I did not open `stage_1_dlmf-R2.md`, `stage_1_dlmf-R3.md`, any earlier scope
plan, any predecessor report/disposition, any peer report, or any Verso work.

Official primary pages inspected on 2026-09-06:

- <https://dlmf.nist.gov/>
- <https://dlmf.nist.gov/about/news/>
- <https://dlmf.nist.gov/errata/>
- chapter landing pages <https://dlmf.nist.gov/4> through
  <https://dlmf.nist.gov/10>
- <https://dlmf.nist.gov/4.13>
- <https://dlmf.nist.gov/9.12>, <https://dlmf.nist.gov/9.14>
- <https://dlmf.nist.gov/10.46>, <https://dlmf.nist.gov/10.47>,
  <https://dlmf.nist.gov/10.61>
- <https://dlmf.nist.gov/7.SB1>
- redirect probes <https://dlmf.nist.gov/10.61.i> and
  <https://dlmf.nist.gov/10.61.E1>

## Checks and observations

- `git diff --name-status <parent> <reviewed>` showed exactly the five companion
  files modified and `blueprint/stage_1_dlmf-R4.md` added.
- `git diff --check <parent> <reviewed>` passed.
- The library-inventory helper reported 7 Lean files, 210 lines, 18 theorems,
  3 definitions, the intended semantic-to-audit import direction, and no
  `sorry`, `admit`, `axiom`, `unsafe`, or resource-limit marker.
- `python3 scripts/validate_inventory.py --negative-tests` passed: the current
  Olver inventory validated and all 25 copied invalid fixtures were rejected.
  This does not validate the proposed future DLMF schema or lifecycle, and the
  proposal correctly says so.
- No Lean build was run because the candidate is documentation-only and the
  user excluded GitHub CI.
- The pinned environment is Lean/mathlib `v4.33.1`; the resolved Mathlib commit
  recorded in `lake-manifest.json` is
  `0df444a360eaa60ab8c11dca51a86af692955474`.
- Official DLMF pages report version 1.2.7 with release date 2026-06-15. The
  chapter landing pages confirm the proposed terminal mathematical/approximation
  and software sections: 4.47/4.48, 5.23/5.24, 6.20/6.21, 7.24/7.25,
  8.27/8.28, 9.19/9.20, and 10.76/10.77.
- Official §4.13 exposes the multivalued Lambert function, `Wp`, `Wm`, Wright
  omega, and Tree `T`; the page explicitly relates the legacy real notations to
  branch values, so the proposal is appropriately conservative in requiring
  domain and branch-side review rather than collapsing them by name.
- Official §9.14 defines incomplete Airy functions through an internal reference
  to the §9.5 contour integral and separately points to external literature.
- Official §10.46 defines the generalized Bessel `phi` and Mittag--Leffler
  function, states only that a Laplace transform “can be expressed” in terms of
  the latter, and separately gives a literature-only lead for incomplete
  modified Bessel and Hankel functions. The proposal's three-way treatment is
  source-faithful.
- `/10.61.i` returned HTTP 302 to `/10.61#i`; `/10.61.E1` returned HTTP 302 to
  `/10.61#E1`; both then returned the §10.61 document. This supports the
  proposal's locator-versus-payload negative fixture.
- `7.SB1` is a genuine separately served sidebar document outside the ordinary
  numeric section sequence. Its explicit sentinel is justified.

## Architecture assessment

| Area | Assessment |
|---|---|
| Scope completeness | Clear for Chapters 4--10: formulas, prose, tables, captions, application and computation material are included; software/bibliography/reference material is separated by whether it actually asserts mathematics. Chapters 1--3 and out-of-range material are consumer-bounded support only. G2 must be fixed so this is the only unqualified Stage 1 meaning. |
| Denominator and lifecycle | The leaf/atom distinction, semantic atomicization, partial local target set, reviewed global closure, pinned decision views, repeated-location handling, and deduplicated many-to-many coverage are strong. G1 is a missing closure case in the correction algebra. |
| Quantitative/source recovery | Clear: genuine asymptotic or approximation atoms have mandatory finite semantic and faithful recovery roles; qualitative-only proofs cannot discharge them; exact finite source bounds are not forced through invented Landau claims. Recovery imports semantic results, never conversely. |
| Entity/branch/normalization | Clear: aliases, argument order, parameter roles, branches, singularities, totalization, real/complex agreement, value-changing normalizations, and noncircular identification are explicit completion obligations. |
| Finite execution | Clear and important: reviewed finite audit batches may feed separately closed finite Lean execution manifests without waiting for `B_all^r`; neither batch type substitutes for the other. There is no whole-census implementation bottleneck. |
| Immutable identities and authority | Audit revisions and source-byte snapshots are properly distinct, historical denominators remain reproducible, and coverage does not transfer across tracks. G1 and G3 concern the two remaining identity/authority transitions. |
| Source-track isolation | Clear: DLMF and locked-Olver occurrences earn only their own coverage; shared mathematics requires explicit semantic crosswalks. |
| Proof-before-Lean | Clear and consistent with the current protocol: complete natural-language proof, independent source and proof review, structural-circularity review where applicable, exact signature/card review, then external `lean_ready`. |
| Mathlib integration | Adequate at plan level: support may close by exact pinned reuse, canonical named objects require identification, and the existing DD-008/per-family reuse rules continue to apply. No unsubmitted schema or code was demanded. |
| Verso | Clear: it is a read-only projection and cannot approve, mutate lineage, define a denominator, choose “latest,” or confer coverage. |

## Findings

### G1 — P1 — The correction algebra cannot repair source-appearance identity mistakes that its own fixtures reject

**Evidence.** R4 lines 285--294 make `source_appearance_id` the immutable owner
of canonical document, leaf, and semantic-location identity. Lines 310--327
permit within-snapshot split/merge only when every endpoint has the same
`source_appearance_id`; lines 329--336 reserve the cross-snapshot relation for
website evolution. Yet lines 620 and 623--626 require rejection of both a
duplicate ID for one real appearance and erroneous collapse/separation of
locator aliases versus genuinely distinct locations.

These are not merely invalid inputs. They are realistic audit corrections. If
one real appearance was accidentally minted twice, a merge is forbidden because
the two IDs differ. If two real locations were accidentally collapsed into one
appearance, atom splitting preserves the wrong single appearance ID. The source
bytes have not changed, so cross-snapshot evolution is the wrong relation. The
new audit revision can detect the error but the specified append-only relations
cannot produce a corrected effective appearance partition without either
rebinding an immutable ID, discarding substantive payload through an exclusion,
or fabricating a new source snapshot.

**Required change.** Add a typed, append-only **within-snapshot source-identity
correction** relation (at canonical-document and/or appearance level as needed)
that can split an erroneously collapsed appearance or coalesce aliases
erroneously minted as different appearances. It should:

1. preserve the old IDs and exact evidence historically;
2. allocate fresh successor appearance/atom IDs rather than rebinding any key;
3. prove payload/semantic-location preservation and nonduplication across the
   predecessor/successor sets;
4. be pinned by each audit revision's decision view and independently reviewed;
5. make old records non-effective only in the successor view, not historically;
6. forbid coalescing genuinely repeated locations merely because content is
   equal; and
7. add positive and negative fixtures for both mistaken alias separation and
   mistaken genuine-location collapse.

**Blast radius/order.** R4 §§2, 4, 7--9 and the eventual DLMF schema contract.
Define the correction semantics before freezing the multi-track migration.
No current Olver row needs mutation. Confidence: high.

### G2 — P1 — A different unqualified “Stage 1” remains operative in the release authority

**Evidence.** R4 lines 23--26 and 99--107 define Stage 1 as the DLMF-through-10
programme. R4 lines 50--69 enumerate the only clauses superseded, and line 75
says no other clause is superseded. The only release-strategy clause listed is
the sentence at `blueprint/qualitative/release_strategy.md` lines 314--319 about
the initial 1997 source target.

But the same still-operative release strategy says it defines what may be
packaged and advertised “at each stage” (lines 19--22), and lines 98--120 define
unqualified “Stage 1” as the single-occurrence Olver Watson pilot. Thus after
DD-021 takes effect, “Stage 1 complete/released” has two materially different
operative meanings: all Chapter 4--10 DLMF targets complete under R4 §7, or one
Olver occurrence released under the older strategy. R4 explicitly makes
`OLV-MVP-1` parallel and not a DLMF prerequisite, so these cannot be sequential
descriptions of the same milestone.

**Required change.** In the six-file successor, explicitly supersede the old
unqualified staged-release nomenclature or declare every old release-stage label
track-local. Prefer renaming it “Olver release stage 1”/`OLV-MVP-1` and reserving
unqualified “Stage 1” for DD-021. The operative rule must make it impossible for
one Watson release to be advertised as completion of the new Stage 1.

**Blast radius/order.** R4's supersession list and any generated status language;
the historical release-strategy bytes may remain immutable if R4 unambiguously
narrows their authority. Confidence: high.

### G3 — P2 — Replacement or withdrawal of the selected global closure lacks a named external authority

**Evidence.** The initial DD-021 activation has an exact rule: two fresh
approvals plus root external adjudication bound to the commit and six digests
(R4 lines 28--46). By contrast, lines 409--425 make `Target(S)` depend on one
explicitly selected `B_all^r` and say a different successful closure needs an
“explicit reviewed successor decision,” but do not identify who may make that
selection, its quorum, or the exact external record/digests it must bind. R4
lines 589--593 require exact-bound external authority generally, but do not close
this selection rule. The current review protocol also says candidate-owned
status cannot establish authority.

This matters because replacing the selected closure changes the current global
denominator even while older denominators correctly remain reproducible. A
known omission or invalid identity also needs to withdraw the current completion
claim while a successor is pending; preserving the historical report must not
leave it current by inertia.

**Required change.** State which actor selects, replaces, or withdraws
`B_all^r`; require an external exact-bound selection record naming snapshot,
audit-revision ID/digest, decision-view ID/digest, reviews, and verdict; specify
the minimum independent review/adjudication rule; and state that accepted
counterevidence makes current Stage 1 completion pending/false until a reviewed
successor is selected, without mutating the historical denominator. Distinguish
this audit correction from amendment of the user-authorized broad Chapter 4--10
scope; the latter must repeat the DD-021 material-amendment authority path.

**Blast radius/order.** R4 §§4, 7, and 9 plus the future external audit-selection
envelope. This is a semantic authority rule, not a request for a particular
serialization. Confidence: medium-high.

## Explicit do-not-change conclusions

- Do not require global `B_all^r` before starting a finite reviewed Lean packet;
  the present two-manifest design correctly avoids that bottleneck.
- Do not weaken the rule that every genuine asymptotic/approximation atom needs
  both a finite semantic theorem and faithful source recovery.
- Do not merge DLMF and Olver source credit. Shared semantic declarations are
  reusable; occurrences and coverage are not transferable.
- Do not make Verso authoritative or writable.
- Do not require numerical evaluators, interval arithmetic, tolerances, or
  algorithm APIs in Stage 1.
- Do not infer that the passing current inventory validator proves the future
  DLMF schema. The proposal correctly labels that implementation as absent.

## Acceptance condition for a successor

A successor is approvable from this review's perspective when G1--G3 are fixed
in exact successor bytes and receive a fresh independent review. The strong
parts listed in the architecture assessment should remain intact. No approval
from this report transfers to changed bytes.
