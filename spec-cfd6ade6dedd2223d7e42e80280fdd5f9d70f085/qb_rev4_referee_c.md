# QB-001 revision 4 — independent pre-Lean proof/quantitative review

## Verdict

**APPROVE**

No material proof, quantitative, signature, classification, dependency, scope,
or governance defect was found in the eight-target QB-001 bootstrap slice at
the exact specification commit below. Findings: **none**.

This is one independent pre-Lean referee verdict. It does not by itself set the
theorem-card gate, natural-language-proof gate, or composite `lean_ready` gate
to `pass`, and it does not authorize implementation. Those states remain facts
of an external review envelope after all packet quorums are met.

## Review identity and isolation

- Reviewer ID: `qb_rev4_referee_c`
- Reviewer kind: `agent`
- Review stage: `pre_lean`
- Primary perspective: `proof_correctness`
- Model: `gpt-5.6-sol` (specified by the orchestrator; lower-level serving
  metadata was not independently exposed in the subagent runtime)
- Runtime: Codex desktop subagent; `codex-cli 0.147.0`
- Issued UTC: `2026-09-05T17:05:29Z`
- Exact specification commit:
  `cfd6ade6dedd2223d7e42e80280fdd5f9d70f085`
- Isolation strength: `manual_attestation`
- Isolation method: fresh independent subagent task; repository inputs were
  read only as `git show <exact-sha>:<path>` blobs; untracked paths were ignored;
  the candidate repository was not edited; no prior or current referee report
  was opened; proof elaboration used a disposable `/tmp` tree produced by
  `git archive` of the exact SHA. The filesystem was writable and this was not a
  hardened clean-room runner, so `technically_enforced` is not claimed.
- External/proposer scratch evidence: not consulted. Pinned Mathlib source and
  a fresh local elaboration were checked directly.

The initial worktree `HEAD` equaled the requested SHA. Its tracked diff from
that SHA was empty before and after review. The pre-existing untracked paths
`LMLF/Audit/` and `LMLF/Definitions/` were neither used nor modified.

## Bound artifacts and digest audit

All digests below are ordinary SHA-256 values of the exact bytes stored at the
reviewed commit, including newlines and frontmatter.

| Artifact | Recorded state/revision | Recomputed SHA-256 | Result |
|---|---|---|---|
| `blueprint/proofs/QB-001.md` | frozen, revision 4, complete | `3513fb1acf141066eb9a4920c1ea238c778d66976ff8479d31c742df93d3a2a5` | matches packet |
| `blueprint/theorem_cards/QB-001.yaml` | frozen, artifact revision 4 | `f470845b382e563ea23dbc850ab223cc5a11bc1504fe97cfb399eb9f457b6d46` | matches packet |
| `blueprint/theorem_cards/QB-001-signatures.md` | frozen, artifact revision 2 | `93e4e30a93087de95342abdb1e986676924cd93512e771737d0d3f3ed7973b39` | matches packet |
| `review/classifications-v1.yaml` | frozen, `lmlf-classification-v1` | `7a4f322bb56dbb40d5d44a7eceb50b5a49ea6ae69f414b920341e3b12ea9d71e` | matches packet |
| `review/work_packets/QB-001.yaml` | schema 3, frozen | `5c45ca1bafdcbc96054ca11bf239bd66d04540464bbc80525af1546b7b63ae9e` | recomputed for later external binding |

The packet correctly omits its own path, commit, and digest. Its proof, card,
signature, and classification bindings all agree. The card's
`baseline_spec_commit: pending_external_record_after_commit` is consistent with
the non-self-referential external-envelope protocol.

Revision-history claims were checked from committed blobs without opening the
historical review report. Against parent specification commit
`073a5675ffaba33c5bec52de00d525165aa17ff4`:

- the signature code block has the same SHA-256 in revisions 1 and 2,
  `c453cdb86697fc00ddad325e8a5915eca5357e3aa06a6c0769d10f58b6829126`;
- the proof's mathematical body has the same SHA-256 in revisions 3 and 4,
  `615c744e22d09cba97494698902eee2a8de72d0b73e43e00bfae6199def681bf`;
- the changes are governance/frontmatter and terminal status prose, consistent
  with the current artifacts' stated revision histories.

## Exact target and signature audit

The signature artifact contains exactly eight declarations, in the same order
as the card's `public_declarations` and the packet's `targets`. The packet's
per-target signatures elaborate to the frozen signature artifact without an
extra hypothesis, a changed binder, a changed conclusion, or a narrowed domain.

| Target | Independent re-derivation and exact-contract check |
|---|---|
| `QB-001-T01` — `QuantitativeAnalysis.ErrorOn` | Exactly `∀ x ∈ D, ‖f x - a x‖ ≤ b x`, with arbitrary `D : Set X`, `f a : X → E`, `b : X → ℝ`, and only `[NormedAddCommGroup E]`. No domain inhabitance or majorant sign field is bundled. |
| `QB-001-T02` — `QuantitativeAnalysis.NormBoundOn` | Exactly `∀ x ∈ D, ‖f x‖ ≤ b x`, on the same arbitrary-set and real-majorant conventions and the same sole typeclass assumption. |
| `QB-001-T03` — `QuantitativeAnalysis.HasErrorFamily` | Exactly `∀ n, ErrorOn (D n) f (a n) (b n)`. The target `f : X → E` is outside and fixed across the `n` quantifier; only approximant, domain, and majorant vary with `n`. The type contains no convergence, summability, finite-expansion, compatibility, monotonicity, or eventual-domain proposition. Natural order includes `n = 0` without a shift. |
| `QB-001-T04` — `ErrorOn.exact` | For `x ∈ D`, `Set.EqOn f a D` gives `f x = a x`; hence `f x - a x = 0` and its norm is `0 ≤ 0`. This establishes precisely the zero majorant on all of `D`; no nonnegativity premise is missing. |
| `QB-001-T05` — `ErrorOn.restrict` | For `x ∈ D'`, the explicit premise `D' ⊆ D` supplies `x ∈ D`, so the original pointwise inequality applies unchanged. The direction is restriction, not extension, and no nonemptiness assumption is introduced. |
| `QB-001-T06` — `ErrorOn.weaken` | At each `x ∈ D`, transitivity gives `‖f x-a x‖ ≤ b x ≤ d x`. The comparison is required exactly on the conclusion domain `D` and has the correct `b ≤ d` orientation. |
| `QB-001-T07` — `ErrorOn.trans` | The exact additive identity is `f x-c x = (f x-a x)+(a x-c x)`. `norm_add_le`, followed by addition of the two premise inequalities, gives exactly `b x+d x` on the unchanged common domain `D`. No sign assumption on `b` or `d` is needed for this addition step. |
| `QB-001-T08` — `ErrorOn.comp` | For `y ∈ S`, the explicit `Set.MapsTo ψ S D` premise gives `ψ y ∈ D`; evaluating the source bound there gives the conclusion after unfolding composition. The MapsTo direction is exactly `ψ : S → D`; `S` is not silently replaced by a preimage and no injectivity, surjectivity, continuity, or differentiability premise is needed. |

All three definitions and five lemmas retain the sole ambient codomain instance
`[NormedAddCommGroup E]`. Target T08 alone also quantifies `Y`, and its binder
order remains source bound `h`, implicit source set `S`, explicit map `ψ`, then
the `Set.MapsTo ψ S D` certificate. There are no attributes or ninth public
declaration in the frozen artifact.

The broader dossier discusses symmetry, conversions, algebraic closure,
products, inverse/division estimates, and family wrappers, but the theorem card
and work packet expressly exclude them. Only the definitions and QB-001.1,
QB-001.2, QB-001.3, forward exactness in QB-001.5, and QB-001.7 are normative.
The extra mathematical discussion therefore does not enlarge this bootstrap.

## Boundary and adversarial rechecks

- Empty domains make all three predicates and all five transports vacuous in
  the expected way; none of the proofs assumes a witness. Singleton domains
  reduce to the stated one-point inequalities.
- Restriction cannot be reversed: on a two-point type, an error may vanish on a
  singleton `D'` and be nonzero at the point in `D \ D'` while the majorant is
  zero.
- Weakening cannot use the reverse comparison: a unit-domain remainder of norm
  `1` is bounded by `b = 1` but not by `d = 0`, even though `d ≤ b`.
- The transitive constant cannot generally be `max b d`: on a unit domain over
  `ℝ`, take `f = 2`, `a = 1`, `c = 0`, and `b = d = 1`; the composed error is
  `2`, while the maximum is `1`. The frozen `b + d` bound is sharp for this
  data.
- `Set.MapsTo` is necessary: if `D` omits a point at which the source error is
  nonzero and `ψ` maps an element of `S` to that point, the source bound on `D`
  supplies no pulled-back estimate.
- `HasErrorFamily` does not imply convergence: on a unit domain, a fixed target
  `f = 0`, approximants alternating between `0` and `1`, and constant majorant
  `1` satisfy the family predicate but the approximants do not converge to the
  target. The definition likewise permits worsening bounds and arbitrary
  order-dependent domains.
- Exactness uses the zero majorant, so it is not the false claim that equality
  yields a bound by an arbitrary signed function.

These cases cover the packet's listed empty/singleton, zero-bound, order-zero,
restriction, additive-majorant, and MapsTo regressions and the dossier's most
relevant false-nearby statements for the eight frozen targets.

## Classification, structural applicability, and lifecycle audit

- Packet classification
  `foundational_calculus / infrastructure / non_novel` uses allowed packet-level
  values and accurately describes the slice.
- T01–T03 are target-level `definition`; T04–T08 are
  `generic_quantitative`; all eight are `reusable_infrastructure / non_novel`.
  Those are allowed target-level values. No internal proof artifact is
  misclassified as an external source-equivalence claim.
- Source occurrence/entity/notation lists and named-object lists are empty;
  coverage is explicitly none/not applicable. Source-fidelity review is thus
  structurally inapplicable, not silently passed.
- The structural/circularity gate's `not_applicable` classification is justified:
  these targets define direct predicates or transport an already supplied
  pointwise inequality. They construct or identify no named object, perform no
  continuation or existence/uniqueness step, make no choice, and expose no
  theorem-sized structure capable of laundering a named application. The
  external envelope must still record this gate as `not_required`.
- The substantial premise `[NormedAddCommGroup E]` is explicit. Each remaining
  premise is exactly the local datum consumed by its transport theorem; none is
  equivalent to a hidden named-function conclusion.
- Card status is `review_status: not_started` and `implementation_status:
  not_started`; current external verdict references are empty. The proof and
  packet call the in-repository historical record non-quorum. No candidate-owned
  field claims `approve`, `pass`, `lean_ready`, or implementation authorization.
- The packet requires two distinct IDs for theorem-card review and two for the
  natural-language-proof review, with an overall pre-Lean minimum of two. This
  approval is only one such ID. Implementation review and its larger quorum are
  separate and remain pending.

## Pinned dependency and elaboration evidence

The committed package boundary is narrow and internally consistent:

- `LMLF/Basic.lean` imports only
  `Mathlib.Analysis.Normed.Group.Basic` and declares no accepted project object.
- `lean-toolchain` is exactly `leanprover/lean4:v4.33.1`.
- `lakefile.toml` requests Mathlib `v4.33.1`.
- `lake-manifest.json` resolves Mathlib to
  `0df444a360eaa60ab8c11dca51a86af692955474`, exactly the revision in the work
  packet. The local pinned Mathlib checkout had that HEAD and a clean status.
- A source search of the pinned `Mathlib/` tree found no declaration named
  `ErrorOn`, `NormBoundOn`, or `HasErrorFamily`; the local abstractions therefore
  do not duplicate same-named canonical Mathlib API. The packet directly reuses
  `Set.EqOn`, `Set.MapsTo`, `NormedAddCommGroup`, and `norm_add_le`.

In `/tmp/qb001-referee-c.BCt3Gu`, an exact `git archive` of the reviewed commit
was given an independently written implementation of precisely the eight frozen
signatures. The existing package cache was used only for the resolved pinned
dependencies. Results:

- `lake build LMLF.Basic`: success;
- `lake env lean LMLF/Quantitative/Basic.lean`: success;
- `lake build LMLF.Quantitative.Basic`: success;
- `lake env lean InspectQB001.lean`: success, with printed declaration types
  matching the frozen binder order and conclusions;
- `lake build`: success for the disposable tree;
- axiom reports for all five theorem proofs were exactly
  `[propext, Classical.choice, Quot.sound]`, within the packet allowlist.

This compilation is a feasibility and signature check, not a candidate
implementation review and not a substitute for the required external gates.
No repository implementation file exists in the reviewed commit, as the packet
correctly states.

## Rubric and protocol binding

The review used the protocol and all committed rubric files at the exact
specification commit. Relevant SHA-256 revisions were:

- `review/PROTOCOL.md`: `8c9209b1f284ed7bbc2d2abab7b36408ac69fb220680bc89331e8d302d9e276e`
- `review/rubrics/quantitative_correctness.md`: `1f77ffb3ac536c58875719ebae6cf9bbbcfd4fd027bd491867e0545660745062`
- `review/rubrics/api_dependency.md`: `4e5f947ed15f0101c46fe9bb0a12a013d66c7de3c7ed2c35fda817de8d92eb41`
- `review/rubrics/mathlib_reuse.md`: `dee214f219ccb03db63194208487f6cb69777b5bc780b608b6e717b729ee901a`
- `review/rubrics/proof_quality.md`: `55baddf430dc9d7530e644217630a4f0905317e2a5b7bd16126036910a22ca19`
- `review/rubrics/source_fidelity.md`: `6873853ce125346feef082d0e31d28808387ec0fa5fb0887ce0d300eba02c9a2`

The source-fidelity rubric yields no source-semantic finding because QB-001 is
explicitly original reusable infrastructure with no source or named-object
claim. Proof-quality checks here were limited to pre-Lean feasibility, trust,
imports, signature shape, and planned regressions; full implementation-stage
proof-quality review remains outside this verdict.

## Final finding list

Empty.

**Final verdict: APPROVE.**
