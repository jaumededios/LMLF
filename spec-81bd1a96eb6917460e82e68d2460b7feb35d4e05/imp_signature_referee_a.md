# IMP-001 exact-signature/API referee A

## Verdict

**APPROVE.** The exact signature proposal at commit
`81bd1a96eb6917460e82e68d2460b7feb35d4e05` is faithful to the frozen
revision-3 mathematical contract, has exactly the intended six public
declarations, and elaborates independently on the pinned toolchain.

This signature review **passes toward a future versioned IMP-001 theorem-card
revision** that binds these bytes and this review. It does **not** make the
packet `lean_ready`, approve any theorem implementation, change the current
revision-3 card's `changes_requested` state, register `IMP-001`, or admit it to
an execution manifest.

## Independent scope and protocol

I reviewed only a disposable `git archive` of the exact commit. I did not use
the live worktree, prior referee reports, or another agent's analysis. I read
the complete original brief, the complete frozen revision-3 card and proof,
the exact signature artifact, and the complete required rubrics/references.
For downstream reachability I also read the archived QL-001 revision-2 card
and proof.

I applied `referee-lean-library` first to dependency direction, abstraction
boundaries, public API shape, downstream reuse, and laundering risks; I then
applied `referee-lean-proof` to exact declaration types, trust boundaries,
elaboration, and proof-obligation visibility. No theorem or proof was
implemented and no repository file was edited.

## Exact snapshot and input evidence

| Item | Exact identity / SHA-256 |
|---|---|
| Reviewed commit | `81bd1a96eb6917460e82e68d2460b7feb35d4e05` |
| Reviewed tree | `3a02b49b9548ae8da7c70b02fcd1df089ef08de1` |
| `IMP-001-signatures.md` | `454dc16dbe924d895d723aba90c0f280baaa6496a3dbf0e4083d0804775191f8` (14,387 bytes; expected hash matched) |
| Frozen design commit | `78b9579d05e03ae30436c5632c4e38c32c0da09e` |
| Frozen `IMP-001.yaml` | `35cb365a0de0492ddc7d6a62e66734400f92c7b79434afa08d9ea1ab2033dcb2` (16,698 bytes; expected hash matched) |
| Frozen `proofs/IMP-001.md` | `d97bd16bbdffeeaa34c2560111f38c714e91e09458d2fb3381535029ca4d431c` (46,570 bytes; expected hash matched) |
| `lake-manifest.json` | `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404` |
| `lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `lakefile.toml` | `787bac6de4002b375a6bfbc840589d72ea3e1f2a440a33352973f268815da562` |
| Original brief | `6787cdb628a66783d81190939e9593525ebb2640a8c870d685d95ce26ba0cce3` |
| Archived QL-001 card / proof | `a85af11116ad2900bb4c7a01acfbfc1eb791a1f1f2a3755ccefa1f3e28ec471d` / `4b70ef576ff90e972ac2ea4e8beac91bca8a208b849f82f87c4afe06a14b5859` |

Git blob identities were independently resolved as
`1b8d88905c675f0079d0c82cf3e1773f683df8c1` for the signature artifact,
`ce238897293edf2aaef5dc7207d6358a43c6e71c` for the frozen card, and
`aba81081067c44a32e7aaac4e6748852e4163970` for the frozen proof.

Protocol hashes: library skill
`d4ce5aa5f1c7ebcf18da6f408c2fc2da98fe2dd906fa9c32b6b613b381aa0e9d`,
global rubric
`990a183dc9e86a3d9580cfb2d5834d36d18afb8a06ad32a114d12b4d0716bb81`,
research basis
`162256b64da8b6ddec71f55f30dd66d35ab2958ba53ddaee55f0cccb9fe241ed`,
proof skill
`6a258eea74c0264b38abb4282199ae068384916fac52fae451ac557750a6e835`,
local rubric
`dd90c97f85a6041b92b64ed5ae4c69d8f5798b92f15d246e0649b1f5ea62ab08`,
and LSP playbook
`c13fd66475b62dc29b69ddb7f7fffe351be4403e1e6c63226d3c6b33ad7dd140`.

## Independent compilation

I reconstructed the two private recursive definitions and all six displayed
public declaration types in the archive. T01 and T05 used their exact bodies;
T02--T04 and T06 were temporary harness axioms solely to test their types.

- Lean: `4.33.1`, compiler commit
  `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`.
- Mathlib checkout:
  `0df444a360eaa60ab8c11dca51a86af692955474`.
- Final compile run: `2026-09-06T03:03:31Z` setup, followed by a clean
  dependency-ordered build and an independent repeat.
- `Basic.lean`: SHA-256
  `ea6b7a8f2372e78a549e95066a122dc9eb460f49ee8f9c3fd3f0dc670a74232a`,
  87 lines, exit 0; repeated exit 0 in 2.154 s.
- `Abel.lean`: SHA-256
  `522f36fa88ea7b721d325adc88dcc7a81276bc58129a9a18c83a3ef83965c111`,
  25 lines, exit 0; repeated exit 0 in 1.988 s.
- `CheckIMP001.lean`: SHA-256
  `910ef61988215a9c38bb7339d43ec63574b613d199335292d0d1abee579630ed`,
  8 lines, exit 0; repeated exit 0 in 2.056 s.

The independent Basic source uses the same declaration bodies and types but a
separately formatted file, so its source hash is not the proposal's historical
82-line harness hash
`944b9d9c76da61964bb7f3fd0b5c3db4ac57a186627b76d4775b1e0f85d9f9ea`.
The proposal's historical Abel and Check hashes are the two hashes above.
This difference is whitespace/documentation layout, not an AST or elaborated
type difference. The importing check printed the exact public types, including
`{E : Type u}`, then `[NormedAddCommGroup E] [NormedSpace ℝ E]
[CompleteSpace E]`; T03's independent `{A : Type v}`; argument order
`f,k,S,I`; literal `s.biUnion S`; and the stated T04/T06 orientations.

A first driver attempt elaborated Basic without placing its `.olean` on the
module search path, so the dependent invocations correctly reported `unknown
module prefix 'LMLF'`. Compiling Basic explicitly to
`.lake/build/lib/lean/LMLF/Integral/Improper/Basic.olean` fixed that harness
orchestration error; all final commands above exited 0 with no warnings.

The direct declaration scan found exactly six non-private declarations: two
definitions (T01, T05) and four temporary theorem-type axioms (T02--T04, T06).
The two recursive representation declarations were `private` and did not add
to the public target count.

## Semantic and adversarial findings

There are **no actionable P0, P1, P2, or P3 findings**.

1. **T01 representation — clear.** `S.sort (· ≤ ·)` is the canonical
   increasing, duplicate-free enumeration; at this pin `Finset.sortedLT_sort`,
   `mem_sort`, and `sort_nodup` expose the needed invariants. The outer
   `∀ c ∈ S, k < c` and strict anchor inequalities prevent vacuous one-sided
   filters. The head, bounded recursion, and terminal clause jointly require
   honest `IntervalIntegrable` evidence on every regular compact truncation,
   independent left/right limits at each finite exception, and a separate
   `atTop` limit. The empty list is the direct regular-truncation plus
   right-endpoint-limit case. No paired cutoff or principal value can satisfy
   this representation merely through cancellation.

2. **T02 uniqueness — reachable.** The sorted list is identical in both
   witnesses. On a fixed anchor, Hausdorff limit uniqueness identifies every
   component value. Different existential anchors are connected by one fixed
   regular interval integral; its addition to one side and subtraction from
   the other preserves the component sum. Real one-sided neighborhood filters
   and `atTop` are nontrivial under the stored strict inequalities. Thus the
   explicit proposed totals are equal without choosing an improper value.

3. **T03 finite combination — clear, including the empty family.** Every
   element of the literal `s.biUnion S` lies above the common `k`. Iterated
   insertion of points in `(s.biUnion S) \ S i` is legitimate because each is
   regular for `f i`; it creates two individual endpoint limits, not a hidden
   simultaneous cutoff. `E →L[ℝ] E` is sufficient for the reviewed complex
   use (fixed complex multiplication is real-continuous-linear), while avoiding
   unreviewed codomain generality. With `s = ∅`, union, integrand sum, and value
   sum are all definitionally empty/zero, and T01's empty-list case supplies
   the conclusion.

4. **T04 orientation — clear.** `a ≤ k`, `S ⊂ (k,∞)`, and integrability on
   `[a,k]` are explicit. Interval additivity gives exactly
   `(∫ t in a..k, f t) + I` from start `a`; the equivalence and sign are not
   reversed. The case `a = k` reduces correctly.

5. **T05 minimality and gluing — clear.** The predicate contains only the
   above-`k` exceptional-set condition, `ContinuousOn F (Ici k)`, `F k = 0`,
   and the regular-piece integrability/increment law. It contains no bound,
   target weight, infinity limit, target integral, or conclusion. Continuity
   supplies the common endpoint value required to glue the separately taken
   component limits; normalization removes only the additive constant and
   does not choose `F`.

6. **T06 — clear in all requested edge cases.** The public type has no
   derivative or absolute-continuity premise on `F` and no global
   `StronglyMeasurable` premise. `hg` supplies local Bochner measurability and
   integrability; the triangular kernel needs only
   `AEStronglyMeasurable` under the displayed restricted product measure.
   The all-`t` increment law is present and includes `t = b`. The exponential
   FTC identity is multiplied by `h` rather than divided by it, so `h = 0`
   remains valid. For `a = b`, all interval integrals vanish and the boundary
   terms cancel. Nothing differentiates `F`.

7. **QL-001 reachability — clear.** QL can instantiate T05 with
   `g(t)=exp(-X*t) • phi(t)`, apply T06 independently on every regular finite
   component, cancel finite exceptional boundary terms by T05 continuity,
   take the separately represented limits, use the separately supplied bound
   on `F` for the `atTop` step, and use T04 to prepend the proper local piece.
   T03 supplies finite model subtraction/continuous-linear combination on the
   literal union and handles the empty truncation family. No IMP premise
   contains QL's target-weight convergence or quantitative bound.

8. **Dependency, laundering, and durability — clear.** Direct imports are
   exactly two Mathlib imports for Basic and `Basic` plus the three displayed
   Mathlib imports for Abel. They compile without an umbrella import and point
   `Basic → Abel → QL`; no QL, Olver, Gamma, QB, DEF, source-recovery, audit,
   or tactic dependency occurs below IMP. Sorting is canonical; anchors and
   component limits are proof witnesses whose effect is shown invariant; `F`,
   `S`, every `S i`, and all proposed values are explicit inputs. No
   `Classical.choose` value function or disguised target hypothesis appears.
   The helper names remain private and no public signature exposes a mangled
   private name. The public reducible relation may be unfolded internally for
   construction, but adding public constructors/projections would be an API
   change and is neither necessary nor justified by a second consumer.

## Rubric disposition

All global-rubric sections are clear: mathematical intent, reusable seams,
public API/theorem shape, module direction, pinned Mathlib integration, proof
architecture, cost/durability, and refactor risk. The deliberate same-codomain
T03 and private concrete representation are supported by the current sole
consumer and should not be generalized or exposed speculatively.

All applicable local-rubric sections are clear for a signature-only artifact:
statement integrity, mathematical skeleton, verified reuse names, binder and
coercion hygiene, warnings, and elaboration. Tactic golf and proof-performance
judgments are inapplicable because no production proof exists. Temporary
axioms are compile-harness placeholders only and provide no trust or proof
evidence.

## Acceptance conditions and next gate

1. A new theorem-card revision must bind commit
   `81bd1a96eb6917460e82e68d2460b7feb35d4e05`, signature SHA-256
   `454dc16dbe924d895d723aba90c0f280baaa6496a3dbf0e4083d0804775191f8`,
   and this report's digest, while retaining exactly these six public targets.
2. Production must replace the four harness axioms with reviewed theorem
   proofs, preserve all binders/result types and the two-module import
   boundary, keep representation/insertion/Fubini plumbing private, and add no
   `sorry`, `admit`, axiom, unsafe escape hatch, or global measurability premise.
3. Implementation review must rerun the listed edge regressions, especially
   all four insertion positions, principal-value rejection, T03's empty and
   complex-CLM cases, T04 sign, T06 at `a=b` and `h=0`, the nondifferentiable
   primitive, exact restricted-product Fubini integrability, and a separate
   downstream QL consumer compilation that does not expose private names.
4. Registry reconciliation, manifest admission, proof review, axiom/import
   audit, and an external `lean_ready` envelope remain separate mandatory
   gates. This approval supplies none of them.

No signature change is required by this review.

Report body SHA-256 (all bytes preceding this line): `8b59acb8c6f4de8b11f848d362a2d0021043504bcb43db246ce7bc26ce13fa76`
