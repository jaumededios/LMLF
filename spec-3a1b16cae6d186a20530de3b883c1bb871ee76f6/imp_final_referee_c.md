# IMP-001 final structural/circularity review — referee C

## Outcome

I approve all three required structural perspectives for the exact frozen
pre-Lean specification at commit
`3a1b16cae6d186a20530de3b883c1bb871ee76f6`:

- `dependency_direction`
- `source_to_target_reachability`
- `hypothesis_and_choice_laundering`

All three verdicts use the `api_dependency` rubric and the same durable reviewer
ID, `/root/imp_final_referee_c`; together they count as one independent
reviewer. I found no material structural issue. These approvals do not set or
self-certify the composite `lean_ready` gate, implementation authorization, an
implementation review, or merge readiness.

## Exact review identity

| Item | Exact binding |
|---|---|
| Specification commit | `3a1b16cae6d186a20530de3b883c1bb871ee76f6` |
| Parent commit | `9e6e038871ac66f80534626d3deade0b27af6752` |
| Pending envelope | `IMP-001-review-envelope-pending.yaml`, SHA-256 `62d1d8e1530b02f63dedda505c925291d7453c16faf65d81919799a69f243b52` |
| Work packet | `review/work_packets/IMP-001.yaml`, revision 1, SHA-256 `e0f16a660417d967312df0f7cc7ce12ea1243226801b409475548566d594796b` |
| Theorem card | `TC-IMP-001-R7`, revision 7, SHA-256 `d81f8970bcba3bf1a489f8cb4fea8b303a3e3bf6d1ad3ade37b42f3094b528c4` |
| Frozen proof | `NLP-IMP-001-R7`, revision 7, SHA-256 `941ca0f2a7e402e9dd3636d7c93744290b3f5b52b8705484c18630c6fe173548` |
| Mathematical predecessor | `NLP-IMP-001-R6`, revision 6, SHA-256 `88f60d501c4261cba37b5d1f320406c258bde785ed3912720b3be897d6424f0e` |
| Signature proposal | `SIG-IMP-001-R6-P2`, proposal revision 2, SHA-256 `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d` |
| Classification authority | `lmlf-classification-v3`, artifact revision 3, SHA-256 `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e` |
| API/dependency rubric | SHA-256 `4e5f947ed15f0101c46fe9bb0a12a013d66c7de3c7ed2c35fda817de8d92eb41` |
| Toolchain | Lean `4.33.1`; Mathlib `0df444a360eaa60ab8c11dca51a86af692955474` |
| Proposer evidence | SHA-256 `3af2776b4b161461f7e9b72701a0b99ecccce9c4a03b730fbc0b8fb932eb0ec7` |
| Command erratum | SHA-256 `2a404f162911de09c272044c3dd752907b57235d62aa995277e0771ed2a38622` |

The envelope has the correct pre-Lean `base_sha: null` and `head_sha: null`.
The packet is non-self-referential. The candidate contains no production IMP
module or IMP test file.

## Isolation and inspection

This was a fresh independent agent session using model `gpt-5.6-sol`. I used a
new detached worktree at `/tmp/imp-final-ref-c.tthMwP8K`, fixed at the exact
specification commit and made filesystem read-only. I did not read any peer or
predecessor referee report, did not spawn another agent, did not edit the
candidate, did not commit or push, and did not invoke GitHub CI. The isolation
strength is `manual_attestation`: the runtime did not technically exclude the
shared filesystem, tools, credentials, or repository history.

I read the complete protocol, verdict template, API/dependency rubric,
library-scale rubric, packet, R7 card, R7 proof, R6 signature proposal, and the
actual QL-001, OLV-001, and OLV-002 proof plans and cards. A full `diff -u` of
R6 and R7 confirms that the successor changes only the declared lifecycle,
binding, and remaining-gate sections; the mathematical body is otherwise
unchanged. This comparison is evidence of preservation, not inherited review
approval.

## Perspective: dependency direction

The frozen production DAG is coherent and acyclic:

```text
Mathlib -> IMP Basic -> {IMP Bochner, IMP Abel} -> QL-001 -> OLV-001 -> SR-001
```

`LMLF.Integral.Improper.Basic` owns exactly T01, T05, T08, T02, T03, and
T04. `Bochner` owns T07 and imports only `Basic` plus its direct pinned Mathlib
support. `Abel` owns T06 and imports only `Basic` plus its direct pinned Mathlib
support; it does not import `Bochner`. No IMP module is permitted to import QL,
OLV, Watson, source, audit, Gamma, QB, DEF, or an umbrella module.

T08 is proved directly from the T01/T05 semantics before the convenience
results and is the sole endpoint-stitching owner. T03, T04, T07, and T06 route
through T08 rather than duplicating or reverse-importing the sorted component
representation. T06's finite-piece Abel/Fubini theorem remains private and is
not a ninth target. Future imports of `Abel` and `Bochner` by
`LMLF/Results.lean` point upward into the maintained public umbrella and make
the modules reachable from the default build; no IMP module imports that
umbrella in reverse.

The consumer-only Mathlib imports in the disposable regression are legitimate
direct pinned support, not private or downstream LMLF dependencies, and the
packet correctly forbids inflating production IMP imports merely to re-export
them transitively.

IMP-R25 is not an acceptance cycle. It is a generic, source-shaped public
consumer that takes a baseline T01 witness as an explicit premise, applies T08
forward, and proves boundedness separately from continuity plus the finite
limit. It imports no QL or OLV implementation. Actual QL/OLV implementation is
explicitly not an IMP acceptance prerequisite. OLV-002 is separately recorded
as independent of IMP/QL/OLV-001. DD-020 supplies only downstream numerical
motivation and adds no numerical module, speculative API, or constructivity
requirement.

## Perspective: source-to-target reachability

IMP-001 is correctly source-free: `IMPROPER-0` has one card, eight targets, and
zero source occurrences. It earns no source coverage and binds no source
snapshot, named object, branch, approximant, or source normalization.

All eight exact packet signatures are byte-identical to their card signature
blocks after YAML indentation removal, have one matching R7 proof anchor, and
elaborate against the pinned signature harness. Their classifications are
independent and valid under v3. The minimal public boundary is consumer-complete:

| Target | Reachability role |
|---|---|
| T01 | explicit relational ordinary-improper value with independent endpoints |
| T05 | explicit normalized continuous primitive with regular increments |
| T08 | existential equivalence between T01 and a convergent T05 witness |
| T02 | uniqueness of an explicit related value |
| T03 | literal finite union and heterogeneous `E ->L[Real] H` combination |
| T04 | exact regular prefix removal/prepending with `J + I` orientation |
| T07 | honest `IntegrableOn (Ioi k)` model value for arbitrary finite marking |
| T06 | same-`S` Abel composition at the exact weighted primitive integral |

The actual QL plan derives local `IntervalIntegrable`, weighted-primitive
`IntegrableOn`, and boundary vanishing before invoking T04/T06. It separately
proves every Gamma model `IntegrableOn` before T07, then uses T03. The actual
OLV plan starts from source convergence encoded as an explicit baseline T01
witness, obtains model witnesses through T07, subtracts through T03, proves the
local interval premise, moves to `k_n` through T04, extracts the primitive and
limit through T08, and only then derives the flat bound used by QL. Neither plan
imports or reconstructs private IMP helpers or assumes the target-weight
relation.

The compiled source-shaped regression confirms API reachability only. Six of
the eight harness targets are temporary axioms, so this evidence supplies no
kernel proof of T02/T03/T04/T06/T07/T08 and no implementation acceptance.

## Perspective: hypothesis and choice laundering

The public hypotheses do not contain a requested downstream conclusion:

- T01 exposes `S` above `k`, honest regular-piece integrability, every
  independent one-sided limit, the atTop limit, and the explicit proposed
  value. It neither totalizes divergence nor selects a value.
- T05 contains only the above-`k` condition, continuity on `Ici k`, `F k = 0`,
  honest regular-piece integrability, and the all-intermediate-point increment
  law. It has no atTop limit, norm bound, weighted value, or Watson conclusion.
- T06 takes weighted-primitive `IntegrableOn` and boundary vanishing as two
  explicit premises. It contains no positivity, flat bound, estimate, or hidden
  target relation; QL derives both premises from `h > 0` and its separate flat
  bound.
- T07 requires `IntegrableOn f (Ioi k)` explicitly before using the exact set
  integral. The repaired negative guard is sensitive to removing that premise.
- T08 quantifies `exists F`; it does not expose a fixed arbitrary primitive,
  selected improper value, selected primitive function, or quantitative bound.
  The repaired negative guard is sensitive to replacing the existential by a
  fixed `F`.
- T03 retains exactly `s.biUnion S` and the exact mapped value in an independent
  complete codomain `H`; it does not choose a larger exceptional set.

The private sorted list is canonical. Private component anchors are
existential proof witnesses, and the explicit anchor-independence calculation
shows their component sums are invariant. No public constructor, eliminator,
anchor API, `Classical.choose` value function, or selected integral appears.
Internal classical choice needed to assemble finite witnesses is within the
declared axiom policy and does not escape through the public API.

## Regression and authorization boundary

All IMP-R01 through IMP-R25 and all 21 card-edge mappings remain mandatory and
pending for implementation acceptance. The external final pre-Lean pass, if
the full quorum is later adjudicated, authorizes only the exact eight targets
and their private proof support. New analytical example/counterexample proofs
identified by the packet require a separately complete, hash-bound
`NLP-IMP-001-REG` and two fresh reviews before their Lean work. That later gate
does not expand or feed back into core-target authorization; a discovered
target-type or semantic change instead requires a new frozen specification.

## Independent local checks

- Verified all frozen artifact, classification, toolchain, manifest, envelope,
  proposer-evidence, and erratum hashes.
- Confirmed detached HEAD, clean worktrees, exact parent, and absence of
  production IMP declarations/files.
- Ran the library inventory script and reconstructed the current import graph.
- Ran `lake build`: `Build completed successfully (2748 jobs).`
- Ran both inventory commands: positive validation passed; all 25 negative
  fixtures were rejected and positive revalidation passed.
- Inspected the pinned Mathlib source and independently `#check`ed IMP-M01
  through IMP-M14 under the exact per-module import surfaces. Lean is 4.33.1
  and the local Mathlib checkout is exactly the bound commit.
- Recompiled the exact-hash Basic, Bochner, and Abel signature harness into a
  fresh disposable olean root, then reran `Check.lean` and the complete
  `Regressions.lean`; all exited 0 with style-only warnings.
- Reran the exact-hash `PacketTypes.lean` against the fresh harness using the
  corrected raw-Lean/`LEAN_PATH` procedure; it exited 0 with unused-binder
  warnings only.
- Reran the isolated T07 and T08 prohibited-signature mutants; both sensitivity
  guards failed exactly as expected.

The original proposer evidence printed an unusable `lake env lean` location
for `PacketTypes.lean`. The immutable erratum accurately records the raw-Lean
procedure that was actually used. My corrected independent rerun succeeded, so
the administrative command error does not alter the frozen candidate,
signature bytes, type-only evidence boundary, or any structural verdict.

## Findings

None.

