# IMP-001 final pre-Lean review — referee B

## Outcome

Reviewer `/root/imp_final_referee_b` independently approves both assigned
schema-4 rubric verdicts for the exact frozen IMP-001 specification at commit
`3a1b16cae6d186a20530de3b883c1bb871ee76f6`:

| Gate | Perspective / rubric | Verdict |
|---|---|---|
| theorem-card review | source semantics / source fidelity | `approve` |
| natural-language-proof review | proof correctness / quantitative correctness | `approve` |

No material finding remains in either assigned rubric. These are individual
pre-Lean verdicts only. They do not set either composite gate to `pass`, do not
authorize `lean_ready`, and do not approve an implementation. The pending
external envelope must adjudicate the required reviewer compositions,
structural perspectives, three-ID union, and composite gate states.

## Exact binding

- External envelope:
  `IMP-001-review-envelope-pending.yaml`, SHA-256
  `62d1d8e1530b02f63dedda505c925291d7453c16faf65d81919799a69f243b52`.
- Work packet: revision 1, SHA-256
  `e0f16a660417d967312df0f7cc7ce12ea1243226801b409475548566d594796b`.
- Theorem card `TC-IMP-001-R7`: revision 7, SHA-256
  `d81f8970bcba3bf1a489f8cb4fea8b303a3e3bf6d1ad3ade37b42f3094b528c4`.
- Signature artifact `SIG-IMP-001-R6-P2`: proposal revision 2 / semantic R6,
  SHA-256
  `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d`.
- Proof `NLP-IMP-001-R7`: revision 7, SHA-256
  `941ca0f2a7e402e9dd3636d7c93744290b3f5b52b8705484c18630c6fe173548`.
- Canonical mathematical predecessor `NLP-IMP-001-R6`: SHA-256
  `88f60d501c4261cba37b5d1f320406c258bde785ed3912720b3be897d6424f0e`.
- Classification authority: `lmlf-classification-v3`, artifact revision 3,
  SHA-256
  `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`.
- Toolchain: `leanprover/lean4:v4.33.1`; resolved Mathlib commit
  `0df444a360eaa60ab8c11dca51a86af692955474`; `lake-manifest.json`
  SHA-256
  `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`.
- Candidate base and head are both `null`: this is a pre-Lean specification
  review and no production IMP implementation exists.

The external proposer evidence was read at SHA-256
`3af2776b4b161461f7e9b72701a0b99ecccce9c4a03b730fbc0b8fb932eb0ec7`.
Its command erratum was read at SHA-256
`2a404f162911de09c272044c3dd752907b57235d62aa995277e0771ed2a38622`.
Both were treated as untrusted, non-quorum proposer material.

## Independent mathematical determinations

- T01's bound private sorted-component encoding gives honest
  `IntervalIntegrable` evidence on every regular finite truncation, separate
  left and right endpoint limits at every member of `S`, and a separate final
  `atTop` limit. The anchor-independence argument has the correct add/subtract
  cancellation and rules out principal-value-only convergence.
- T05 requires exactly above-`k`, continuity on `Ici k`, normalization at `k`,
  honest regular-piece integrability, and every regular-interval increment.
  It contains no bound, infinity limit, derivative, or weighted conclusion.
- T08 is genuinely existential in `F`, not an equivalence for a fixed supplied
  primitive. Both directions preserve the independent endpoint semantics; the
  cumulative primitive construction and reverse finite telescope are exact,
  impose no quantitative bound, and leave values below `k` unconstrained.
- T02 uses uniqueness on nontrivial one-sided and `atTop` filters and does not
  introduce a selected value.
- T03 supports a finite family of maps `E ->L[Real] H` with independently
  complete `E` and `H`, weakens each primitive only to the literal
  `s.biUnion S`, and produces exactly the mapped finite sum and value.
- T04 has the required `a <= k` orientation and the exact value order
  `(integral a..k f) + I` (`J + I`). Both implications follow through T08
  without collapsing an exceptional prefix to one improper finite integral.
- T07 retains the explicit `IntegrableOn f (Ioi k)` premise, so the totalized
  set integral cannot launder convergence. Its restriction through `Ioc`
  supplies local L1 integrability at the initial endpoint, while arbitrary
  finite regular markings above `k` are preserved.
- T06 is correct for arbitrary real `h`. Its private finite-piece proof uses
  the exact restricted product measure required by
  `MeasureTheory.intervalIntegral_integral_swap`; the stated domination gives
  product integrability, and `AEStronglyMeasurable` is required only for that
  product measure. The algebra derives
  `h * integral_u^v exp(-h*t) = exp(-h*u)-exp(-h*v)` without dividing by `h`,
  so `h = 0` is covered. The proof differentiates only the scalar exponential,
  never `F`; the transformed primitive has the exact increment law and tends
  to the stated `h`-scaled honest Ioi integral on the same literal `S`.

The dependency route is acyclic: Mathlib feeds `Basic`, `Bochner` and `Abel`
are sibling consumers of `Basic`, T08 alone owns endpoint stitching, and no
target assumes a downstream QL/OLV/Watson result. The hypotheses expose all
integrability, continuity, endpoint, and weighted-tail conditions instead of
moving a target conclusion into a field or hidden choice.

## Lifecycle and regression boundary

The R7-to-R6 diff has sixteen textual hunks, all confined to frontmatter and
lifecycle/binding/status regions. Independently extracted target-proof,
boundary/audit, regression, and reconstruction sections are byte-identical;
the last three reproduce the proposer-listed hashes
`f473ffd574af371ebc997b1985ca241a9837a65c4b287a2a12a02a66e23e1ddd`,
`ee11026250ade8f44983090253042389fd1b23c1f399aa6fa3c6de358adffc02`,
and `34adb090b096639e2df65ea6ec0844ac09112beb898a447bbe16e31fd5ef7737`.

All eight target signatures, declarations, classifications, and proof anchors
match across packet, card, proof, and signature artifact. All 25 regressions
remain separately present and `required_pending`; all 21 card-edge rows remain
mandatory. The packet truthfully distinguishes target-proof work from later
analytic example/counterexample formalization: the latter requires a complete,
separately hash-bound companion proof provisionally called
`NLP-IMP-001-REG` and at least two fresh independent approvals. The sketches in
the current dossier are not presented as Lean proofs. This is an honest staged
authorization boundary for exactly the eight core public targets and their
private proof support.

The six theorem axioms in the disposable harness were used only as type/API
evidence. The two public definitions elaborate with the bound bodies, but no
kernel proof of any theorem target, production module, regression completion,
or implementation acceptance is inferred. Future numerical use remains design
motivation and adds no current constructivity or evaluator requirement.

## Local evidence

The review used detached worktree `/tmp/imp-final-ref-b.5LxpEBA7` at the exact
specification commit. Relevant independent checks were:

- the `referee-lean-library` deterministic inventory and all eight sections of
  its global rubric;
- exact SHA-256 recomputation for every bound artifact, envelope, proposer
  record, erratum, toolchain file, manifest, and R6 predecessor;
- a direct R6/R7 diff plus independent section extraction and hashing;
- exact cross-artifact comparison of all eight signatures, declarations,
  classifications, and target anchors;
- direct source inspection and `#check` at the pinned Mathlib commit for
  `intervalIntegral.integral_add_adjacent_intervals`,
  `ContinuousLinearMap.intervalIntegral_comp_comm`,
  `MeasureTheory.intervalIntegral_integral_swap`,
  `ContinuousOn.intervalIntegrable_of_Icc`, `tendsto_nhds_unique`,
  `tendsto_finsetSum`,
  `intervalIntegral.integral_eq_sub_of_hasDerivAt_of_le`,
  `intervalIntegral.integral_undef`,
  `intervalIntegral.continuousOn_primitive_interval'`,
  `MeasureTheory.intervalIntegral_tendsto_integral_Ioi`,
  `MeasureTheory.IntegrableOn.continuousOn_Ici_primitive_Ioi`,
  `intervalIntegral.integral_Ioi_sub_Ioi`,
  `intervalIntegrable_iff_integrableOn_Ioc_of_le`, and
  `Real.hasDerivAt_exp`;
- byte-extraction of the five authoritative signature-harness blocks, which
  reproduced all five recorded hashes and line counts;
- in-memory reconstruction and pinned-Lean elaboration of the eight exact
  declarations, all eight packet type equalities, and the complete public-use
  regression harness; only the disclosed style warnings occurred;
- independent prohibited-signature mutations: removing T07's `IntegrableOn`
  and replacing T08's existential by a fixed `F` each made its typed
  `fail_if_success` guard fail with the expected diagnostic;
- `python3 scripts/validate_inventory.py` and its `--negative-tests` suite;
- `git diff --check HEAD^ HEAD`; and
- `lake build`, which completed successfully with 2756 jobs.

The exact tracked candidate remained clean and no production IMP declaration
was found.

## Library-scale rubric disposition

Every global-rubric section is clear. The declaration graph implements the
proof dossier; the eight public seams have concrete consumer roles; the API
uses natural explicit assumptions; imports point downward; pinned Mathlib
facts match by exact type rather than name; proof responsibilities are
separated; no performance claim is made before implementation; and no obsolete
compatibility layer is retained. There is no `G#` refactor finding. Explicit
do-not-refactor conclusions are to keep anchors, sorted recursion, and the
finite Abel identity private; keep `Bochner` and `Abel` as siblings; retain the
heterogeneous T03 codomain; and keep bounds out of T05/T08.

## Isolation attestation

Isolation strength is `manual_attestation`, not a technically enforced
sandbox. This was a fresh independent agent session, distinct from proposer
`/root/imp_r6_signature_author`, using reviewer ID
`/root/imp_final_referee_b`, model `gpt-5.6-sol`. No sibling or prior referee
report was read, no subagent was used, no candidate edit, commit, push, or
GitHub CI action occurred, and only the three assigned external review records
were written. Filesystem, network, credentials, plugins, and context exclusion
were not technically enforced. Lake materialized the exact pinned dependencies
inside the disposable worktree before the local build; all adjudicative checks
were local shell/Lean checks against the pinned bytes.

Issued at `2026-09-06T13:44:18Z`.
