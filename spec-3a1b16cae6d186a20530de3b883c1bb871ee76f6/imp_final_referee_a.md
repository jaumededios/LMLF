# IMP-001 final pre-Lean referee A report

## Outcome

Reviewer `/root/imp_final_referee_a` independently gives both requested
rubric verdicts **approve**:

- theorem-card review: `source_fidelity` / `source_semantics`;
- natural-language-proof review: `quantitative_correctness` /
  `proof_correctness`.

I found no material semantic, quantitative, proof-completeness, dependency,
choice, or hypothesis-laundering defect in the frozen eight-target
specification. These are individual rubric verdicts only. They do not set a
composite gate to `pass`, do not certify `lean_ready`, do not authorize
implementation by themselves, and do not constitute implementation review.

## Reviewer and isolation attestation

- Durable reviewer ID: `/root/imp_final_referee_a`
- Reviewer kind: agent
- Model: `gpt-5.6-sol`
- Runtime: Codex desktop, fresh-context review session
- Independent of proposer: yes; proposer ID is
  `/root/imp_r6_signature_author`
- Isolation strength: `manual_attestation`
- Candidate snapshot: a reviewer-created disposable detached worktree at
  `/tmp/imp-final-ref-a.0nYyMBoi`, exact HEAD
  `3a1b16cae6d186a20530de3b883c1bb871ee76f6`
- Candidate mutation: no tracked candidate byte was edited. Temporary check
  sources and `.olean` outputs were confined to the disposable worktree and
  removed before verdict; the detached worktree ended clean.
- External writes: only this report and the two requested schema-4 verdicts
  in the bound external evidence directory
- Network and GitHub CI: unused
- Peer/predecessor reports: not read or relied upon

This was manual isolation, not a technically enforced clean room. The shared
filesystem and existing dependency checkout were available, as required by
the actual environment.

## Exact binding and hashes verified

The external review envelope was read in full and independently rehashed:

`/workspace/Documents/Codex/2026-09-05/LMLF-review-evidence/spec-3a1b16cae6d186a20530de3b883c1bb871ee76f6/IMP-001-review-envelope-pending.yaml`

SHA-256:
`62d1d8e1530b02f63dedda505c925291d7453c16faf65d81919799a69f243b52`.

The envelope correctly keeps `base_sha` and `head_sha` null for the pre-Lean
stage, has empty reviewer sets, and leaves every composite and merge state
pending.

| Artifact | Verified SHA-256 |
|---|---|
| `review/work_packets/IMP-001.yaml` | `e0f16a660417d967312df0f7cc7ce12ea1243226801b409475548566d594796b` |
| `blueprint/theorem_cards/IMP-001.yaml` | `d81f8970bcba3bf1a489f8cb4fea8b303a3e3bf6d1ad3ade37b42f3094b528c4` |
| `blueprint/theorem_cards/IMP-001-signatures-R6.md` | `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d` |
| `blueprint/proofs/IMP-001-R7.md` | `941ca0f2a7e402e9dd3636d7c93744290b3f5b52b8705484c18630c6fe173548` |
| canonical `blueprint/proofs/IMP-001.md` R6 | `88f60d501c4261cba37b5d1f320406c258bde785ed3912720b3be897d6424f0e` |
| `review/classifications-v3.json` | `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e` |
| `review/PROTOCOL.md` | `7453bc0ca6985d7ca2e8c525d9655a94e412c48e3850b92d9367a9f643d3177d` |
| `review/templates/verdict.json` | `c1859f7122b537588969fca3dd10454a3dcd483176c82b770a875f2b6fc00486` |
| `review/rubrics/source_fidelity.md` | `6873853ce125346feef082d0e31d28808387ec0fa5fb0887ce0d300eba02c9a2` |
| `review/rubrics/quantitative_correctness.md` | `1f77ffb3ac536c58875719ebae6cf9bbbcfd4fd027bd491867e0545660745062` |
| `lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `lake-manifest.json` | `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404` |

The resolved Mathlib checkout itself is detached and clean at
`0df444a360eaa60ab8c11dca51a86af692955474`, and raw Lean reported version
`4.33.1`.

I also read and rehashed the untrusted proposer bundle:

- `proposer-evidence.md`:
  `3af2776b4b161461f7e9b72701a0b99ecccce9c4a03b730fbc0b8fb932eb0ec7`;
- `proposer-evidence-command-erratum.md`:
  `2a404f162911de09c272044c3dd752907b57235d62aa995277e0771ed2a38622`.

The original proposer evidence contains a non-working convenience command
because the harness root is not a Lake project. The immutable erratum gives the
actual raw-Lean invocation with the project-derived `LEAN_PATH`. I reran the
correct form independently. This is an evidence-command correction, not a
candidate, packet, card, proof, signature, rubric, classification, toolchain,
or dependency change.

## R7 preservation of R6 mathematics

An independent unified diff between R6 and R7 has exactly five hunks. They are
confined to frontmatter/lifecycle bindings, the opening status paragraph, a
status paragraph before the pinned dependency ledger, one prospective/frozen
module-lifecycle sentence, and the final remaining-gates section. No target
argument, equation, dependency use, analytic condition, adversarial case, or
regression obligation changed.

Independent section hashes further confirm preservation:

| Compared section | R6 SHA-256 | R7 SHA-256 |
|---|---|---|
| all target proof sections T01 through T06, ending before the analytic ledger | `2dce7639f74d68c2fc689b9f1e57adc616f6fe69b91c11c163044dd31a71779c` | same |
| analytic ledger through regression/consumer material, ending at the trust heading | `2be4ceaa7f7392a164eb5957acfba15bb04dcac2eebb00af5c8429bdeaa5b5a5` | same |
| reconstruction of all eight targets | `34adb090b096639e2df65ea6ec0844ac09112beb898a447bbe16e31fd5ef7737` | same |

The canonical R6 file stayed at its required whole-file digest. R7 is therefore
an honest metadata/status successor and not an undisclosed mathematical
revision.

## Theorem-card and exact-semantics review

The packet, card, and proof frontmatter contain exactly eight matching target
IDs and proof anchors. The packet and card contain eight byte-identical exact
signature blocks. The exact harness sources extracted from the signature
artifact are byte-identical to the disclosed disposable files with hashes
`9a88b646...` (Basic), `33fd45c2...` (Bochner), and `c96c1f97...`
(Abel). I compiled those exact sources into reviewer-local `.olean` outputs,
then compiled the eight-name check, the complete `PacketTypes.lean`, and the
public-use regressions. All exited zero; warnings were lint/style-only.

The harness has exactly two real definitions, T01 and T05, plus six explicitly
disclosed temporary axioms. Its compilation establishes definition bytes,
signature elaboration, and consumer type shape only. It proves none of the six
theorem targets and supplies no implementation acceptance evidence.

### Target findings

| Target | Independent conclusion |
|---|---|
| T01 | The exact sorted recursive body has the intended ordinary-improper semantics. `S` is above `k`; compact intervals in each regular component have honest `IntervalIntegrable` evidence; each finite endpoint is approached independently from its two sides; the final endpoint is `atTop`; and the value is the exact finite component sum. The initial component requires local L1/Bochner integrability through every interval `k..b`, so an L1 endpoint singularity is allowed while a merely conditional non-L1 singularity at `k` is rejected. A principal-value-only cancellation cannot satisfy the two separate filters. |
| T05 | The exact body contains only above-`k`, continuity on `Ici k`, `F k = 0`, regular-piece integrability, and the exact all-intermediate-point increment law. It contains no bound, atTop limit, derivative, weighted value, or target theorem. Values below `k` are unconstrained. |
| T08 | Both directions reach the exact existential statement. Forward construction cumulatively stitches the independent T01 component values and uses continuity at every exception; reverse extraction gives the exact one-sided values and telescopes to `I - F(k) = I`. Empty and multiple-point cases are covered, and the witness is existential rather than a fixed supplied primitive. |
| T02 | Uniqueness is valid. Because the private encoding existentially quantifies anchors, each witness is first normalized to the common deterministic component anchors using IMP-I01; uniqueness of limits then compares the same functions on the same nontrivial filters. This normalization is supplied by the standing proof context even though the short T02 paragraph compresses that step. No principal-value cancellation is used. |
| T03 | The signature genuinely separates input/value space `E` from complete output space `H`, and the conclusion is on exactly `s.biUnion S`. The proof extracts T05 witnesses through T08, weakens each only to the literal union, forms the finite mapped sum, commutes CLMs with honest interval integrals, takes finite-sum limits, and returns through T08. It neither exposes nor depends on representation-specific insertion. |
| T04 | The proof preserves the exact oriented value `(integral a..k f) + I`. The forward construction glues the proper prefix to the normalized tail at `k`; the reverse construction subtracts `G(k) = integral a..k f`. The `a = k` case is included, and no silently reversed interval is used. |
| T07 | `IntegrableOn f (Ioi k)` is explicit and essential. The canonical primitive is continuous on `Ici k`, has honest regular increments by restriction to `Ioc`, and tends to the exact Ioi set integral. T05 and T08 therefore produce the conclusion for every supplied finite marking set `S` above `k`; no canonical enlargement and no converse to absolute integrability is asserted. |
| T06 | The conclusion remains on the same literal `S` and has exactly value `h • integral_(Ioi k) (exp(-h*t) • F t)`. Its only tail premises are weighted-primitive `IntegrableOn` and boundary vanishing, with arbitrary real `h` and no division by `h`. The finite-piece proof uses a Bochner triangular kernel under exactly `(volume.restrict (uIoc a b)).prod (volume.restrict (uIoc a b))`, measure-local `AEStronglyMeasurable`, compact domination, and Fubini. Only the scalar exponential is differentiated. The transformed primitive has the exact increment identity and T08 alone stitches it across exceptions. |

### Source and classification fidelity

IMP-001 is correctly classified as source-independent reusable infrastructure.
It binds no external source occurrence, named function, source notation, branch,
or exceptional source value and earns no source coverage. The internal frozen
proof artifact is reproducibly identified, but it is not misclassified as an
external source.

All declaration-level values are allowed by classification v3 and are
consistent across packet, card, and proof: T01/T05 are definitions, T02 is
existence/uniqueness, T07 is qualitative support, T03/T04/T06/T08 are exact
identities; every coverage class is `reusable_infrastructure`, and every
novelty class is `non_novel`. Packet-level `mixed / infrastructure /
non_novel` is accurate because the principal target shapes differ while no new
mathematical novelty or source coverage is claimed.

## Natural-language proof review

### Proof dependency and circularity

The proof graph is acyclic:

`T01 + T05 -> T08 -> {T02, T03, T04, T07, T06}`.

T08 is constructed directly from the definition semantics and does not use any
later convenience theorem. T03, T04, T07, and T06 use T08 only after that
direct proof. Production dependencies point from pinned Mathlib to Basic and
then independently to the Bochner and Abel sibling modules. No IMP target uses
QL, OLV, Watson, Gamma, QB, DEF, source, or audit modules. The later QL/OLV
consumer narrative is motivation and reachability evidence, not a premise.

There is no conclusion-sized field. T05 lacks convergence, bounds, derivatives,
and weighted results. T06's two explicit tail propositions make its displayed
set integral and terminal boundary passage honest but do not contain the target
relation. T07 retains absolute integrability rather than inferring it from a
totalized value. T08 asserts ordinary mathematical existence without exporting
a selected primitive or selected improper value. Finite sorting is canonical;
interior anchors are private existentials whose public irrelevance is proved.

### Exact Abel algebra

The triangular Fubini step has the correct kernel orientation. After the swap,
the inner scalar integral is from `v` to `b`. The FTC identity

`h * integral_u^v exp(-h*t) dt = exp(-h*u) - exp(-h*v)`

is derived from `Real.hasDerivAt_exp` without dividing by `h`, so it remains
valid at `h = 0`. Splitting `F(t) = F(a) + G(t)` gives the exact boundary signs
and rearranges to

`integral_a^b w(t) • g(t) = w(b) • F(b) - w(a) • F(a) + h • integral_a^b w(t) • F(t)`.

Consequently the transformed primitive

`w(t) • F(t) + h • integral_k^t w(u) • F(u)`

has precisely the weighted-`g` increment, and its atTop limit is precisely the
public T06 value. No derivative of `F` is assumed or inferred.

### Pinned Mathlib source inspection

I inspected the actual declarations at the pinned Mathlib commit and compiled
`#check` statements for all IMP-M01 through IMP-M14. Their namespaces,
orientations, hypotheses, and defining imports match the dossier. In
particular:

- `intervalIntegral_integral_swap` requires exactly product integrability with
  outer `volume.restrict (uIoc a b)`;
- `integral_eq_sub_of_hasDerivAt_of_le` has the stated orientation;
- `intervalIntegral_tendsto_integral_Ioi` requires honest `IntegrableOn` and a
  bound tending to `atTop`;
- `continuousOn_Ici_primitive_Ioi`, `integral_Ioi_sub_Ioi`, and
  `intervalIntegrable_iff_integrableOn_Ioc_of_le` support T07 exactly;
- `intervalIntegral_comp_comm`, `tendsto_finsetSum`, and
  `tendsto_nhds_unique` have the required complete/Hausdorff hypotheses.

## Regression and staging assessment

The packet contains 25 distinct mandatory regression IDs and 21 explicit card
edge-obligation rows. None is marked complete by the current specification.
That staging is honest:

- a passing final pre-Lean envelope may separately authorize implementation of
  only the exact eight public targets and their private proof support;
- all IMP-R01 through IMP-R25 and all card edge obligations remain mandatory
  before implementation acceptance;
- the new analytic examples/counterexamples identified in R04, R05, R06, R11,
  R12, the nondifferentiable-example part of R13, R22, the concrete part of R07,
  and the full invariance result in R24 first require a separately hash-bound
  complete `NLP-IMP-001-REG` companion and two fresh independent reviews;
- the current signature harness supplies only partial type/consumer evidence
  and cannot discharge target proofs or these mathematical regressions.

The packet also truthfully permits two future `LMLF/Results.lean` imports for
Bochner and Abel so the default build reaches all three IMP modules; Basic is
reached transitively. No production IMP file exists now. Future verified
numerical use is only motivation and introduces no numerical or constructivity
obligation.

## Library-scale rubric disposition

I applied every section of the `referee-lean-library` global rubric after the
deterministic inventory. No `G#` finding resulted.

1. Mathematical intent: all eight declarations implement the written route.
2. Reusable seams: T08, T03, T07, and T06 are justified semantic boundaries;
   the finite Abel identity and endpoint recursion correctly remain private.
3. Public API: the exact two-definition/six-theorem surface is minimal for the
   stated consumers and adds no selected-value API.
4. Modules/dependencies: `Mathlib -> Basic -> {Bochner, Abel}` is acyclic and
   keeps independent bridges as siblings.
5. Mathlib integration: the exact pinned facts fit the required hypotheses and
   orientations; no duplicate local foundation is proposed.
6. Proof architecture: T08 owns stitching, T06 owns weighted composition, and
   downstream consumers need not unfold T01.
7. Cost/durability: imports are purpose-specific; no unsupported performance
   claim is made before proof bodies exist.
8. Refactor risk: keep sorted components, anchors, and Fubini plumbing private;
   do not merge Bochner and Abel, specialize T03 back to one codomain, or add a
   bound to T05/T08.

## Commands independently rerun

- `git status --short --branch`, `git worktree list --porcelain`, and
  `git rev-parse HEAD` for the candidate and detached review worktree
- SHA-256 checks for the envelope, proposer bundle and erratum, packet, card,
  signature, R7 proof, canonical R6 proof, classification schema, protocol,
  verdict template, both rubrics, toolchain, and Lake manifest
- full `diff -u` of R6 and R7 plus independent section extraction/hashing
- `/home/codex/.codex/skills/referee-lean-library/scripts/library_inventory.sh`
- byte comparisons between every authoritative complete harness block and the
  disclosed harness file; byte comparison of all eight packet/card signature
  blocks
- pinned Mathlib `git rev-parse`, status, declaration-source inspection, and a
  raw-Lean file containing `#check` for IMP-M01 through IMP-M14
- pinned raw-Lean compilation of exact Basic, Bochner, and Abel harness sources
  to reviewer-local `.olean` files; exact eight-name `Check.lean`;
  `PacketTypes.lean`; and the complete public-use `Regressions.lean`
- `python3 scripts/validate_inventory.py`
- `python3 scripts/validate_inventory.py --negative-tests`
- `git diff --check`
- `lake build` at exact main HEAD, which completed successfully with 2748 jobs

The inventory reported seven current Lean source files, 210 lines, three
definitions, eighteen theorems, and no trust/resource markers. The default
build is evidence only for the current repository; because production IMP files
do not exist, it is not IMP theorem-proof evidence.

## Findings

No material findings. The two schema-4 verdict records therefore have empty
`findings` arrays and verdict `approve`.
