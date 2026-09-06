# QB-001 independent pre-Lean proof review

## Review identity and binding

- Reviewer ID: `qb_d0_referee_h`
- Reviewer kind/model: agent, `gpt-5.6-sol`
- Review stage: `pre_lean`
- Reviewed specification commit: `d0aa1c55967d7cde7187f5c8b7a05b76d7043fe5`
- Commit tree: `399f98c79ccf07cf35ac1c92a8d74edb3b29db46`
- Completed UTC: `2026-09-05T18:06:58Z`
- Isolation strength: `manual_attestation`
- Isolation method: fresh-context review in a disposable archive created with
  `git archive d0aa1c55967d7cde7187f5c8b7a05b76d7043fe5` from
  `/home/codex/Documents/Codex/2026-09-05/yo`, extracted as
  `/tmp/qb-d0-referee-h.LbboR4`. The archive had no working-tree metadata.
  I did not inspect the source working tree, any untracked file, any prior
  review, or the historical non-quorum review named by the packet. Temporary
  Lean harnesses and fetched pinned dependencies existed only in the disposable
  archive. No candidate repository file was edited.

This is a manual isolation attestation, not a technically enforced clean-room
claim.

## Frozen artifact verification

| Artifact | Required revision | Observed revision | SHA-256 | Result |
|---|---:|---:|---|---|
| `review/work_packets/QB-001.yaml` | 3 | 3 | `6eaeea14a581d4b60c7933afb2c9bb24a633df135a935b7c7e4af11c9845cf87` | match |
| `blueprint/theorem_cards/QB-001.yaml` | 6 | 6 | `7e83195fd3b6ff9ea884e29f6d857a4673c9de5fe44327d914e595e6b798468f` | match |
| `blueprint/proofs/QB-001.md` | 5 | 5 | `167629f117dc0609809162b5a5247d05e0c9a193d96b84d9cda5247e930ecd4c` | match |
| `blueprint/theorem_cards/QB-001-signatures.md` | 2 | 2 | `93e4e30a93087de95342abdb1e986676924cd93512e771737d0d3f3ed7973b39` | match |

The packet records exactly those upstream revisions and digests. Its
classification-schema digest also matches revision 2 of
`review/classifications-v2.json`:
`8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9`.
The packet contains no self path, commit, or digest. The registry values
`foundational_calculus / infrastructure / non_novel` are admitted by, and match
the required QB-001 example in, the frozen classification vocabulary.

## Verdicts

- Theorem card revision 6: **REQUEST_CHANGES**.
- Natural-language proof revision 5: **REQUEST_CHANGES**.
- Structural-circularity classification: **N/A CONFIRMED**. The packet has only
  three thin predicates and five direct transports. It performs no named-object
  identification, construction, continuation, existence/uniqueness argument,
  source-recovery bridge, hidden choice, or theorem-sized hypothesis packaging.
  An external envelope may therefore record this gate as `not_required` for the
  exact frozen artifacts after adjudication.
- `lean_ready`: **NOT AUTHORIZED BY THIS REVIEW**. A referee verdict is not the
  composite authorization gate, and the two request-changes verdicts would in
  any event prevent it from passing.

The mathematical targets and frozen Lean signatures are sound. The blocking
issue is specification/proof scope integrity, not the five proof arguments.

## Actionable findings

### L1 (P1) — the proof labels a current frozen target as prospective

Files/fields:

- `blueprint/proofs/QB-001.md`, QB-001.5, lines 268–283;
- `blueprint/theorem_cards/QB-001.yaml`, `scope.public_declarations` and
  `natural_language_proof.note`, lines 49–57 and 123–126.

Evidence: `QuantitativeAnalysis.ErrorOn.exact` is frozen target T04 in the
packet, card, and signature artifact. The proof's “Prospective declaration
names outside QB-001” list nevertheless includes `ErrorOn.exact` for equality
on the domain implying zero error, then says that the listed names are not
QB-001 targets, are not current public API, are provisional, and require a
later card. That is the exact statement and name of T04, not one of the excluded
equivalences. The card simultaneously claims that revision 5 correctly labels
all non-target discussions as prospective.

Required local repair: state explicitly that forward exactness and the name
`ErrorOn.exact` are the current QB-001 target; apply the prospective paragraph
only to `eq_zero_iff`, `iff_nonneg_of_eqOn`, and the conversion/zero-norm
equivalences. Update artifact revisions/digests and all bindings required by the
protocol.

Expected effect: restores a single unambiguous status for T04 and makes the
card's description of its proof artifact truthful. Verification status:
**failed by direct artifact comparison**; no candidate edit was made.

### L2 (P2) — excluded results inside mapped sections are not unambiguously prospective

Files/fields:

- `blueprint/proofs/QB-001.md`, Scope and QB-001.1/.2/.3/.7 plus artifact-status
  lines 1102–1112;
- `blueprint/theorem_cards/QB-001.yaml`, `scope_note` and
  `natural_language_proof.normative_sections`, lines 64–68 and 116–126.

Evidence: revision 5 claims to label every non-target declaration discussion
as prospective, but several present-tense statements inside sections that the
card itself marks normative have no such label. Examples include preliminary
majorant nonnegativity (proof lines 56–64), the `NormBoundOn` restriction and
domain-equality results (78–80), `NormBoundOn` weakening and combined
restriction/weakening (112–124), intersection-domain transitivity (152), and
the `NormBoundOn` and preimage forms of precomposition (342–344). The closing
sentence that “all sections not mapped” stay outside the manifest does not
resolve extra statements *inside* QB-001.1, .2, .3, and .7, because the card
maps those sections as normative. Unmapped sections are also mostly written as
completed present results rather than marked prospectively; only the QB-001.5
name list and part of the product discussion use explicit prospective wording.

Required local repair: add an up-front normative-target table or banner saying
that exactly T01–T08 are current and every other statement, variant,
counterpart, wrapper, and proposed declaration in the dossier is prospective;
then make the card's proof bindings target-specific rather than naming whole
mixed-content sections. Explicit per-section labels would be even clearer.
Update frozen revisions/digests and the packet/envelope bindings as required.

Expected effect: prevents non-target results from being mistaken for reviewed
current obligations while retaining the dossier as future design material.
Verification status: **failed by exhaustive section audit**; no candidate edit
was made.

## Independent derivation of all eight targets

| Target | Independent proof skeleton | Assumptions actually used |
|---|---|---|
| T01 `ErrorOn` | Define `∀ x ∈ D, ‖f x - a x‖ ≤ b x`. | Norm and subtraction on `E`; no property of `D` or sign premise on `b`. |
| T02 `NormBoundOn` | Define `∀ x ∈ D, ‖f x‖ ≤ b x`. | Norm on `E`; no nonemptiness or global nonnegativity. |
| T03 `HasErrorFamily` | Define `∀ n, ErrorOn (D n) f (a n) (b n)`. | T01 only; `f` is fixed, while `a`, `D`, and `b` depend on `n`. No cross-index relation. |
| T04 `ErrorOn.exact` | For `x ∈ D`, use `h x hx` to rewrite `f x = a x`; `sub_self` and `norm_zero` give `0 ≤ 0`. | `h` at the same point. No nonempty domain and no norm definiteness. |
| T05 `ErrorOn.restrict` | For `x ∈ D'`, `hD hx : x ∈ D`; apply `h x`. | Both `h` and the direction `D' ⊆ D`. |
| T06 `ErrorOn.weaken` | Chain `h x hx : ‖…‖ ≤ b x` with `hbd x hx : b x ≤ d x`. | Both hypotheses on exactly `D`; comparison direction is essential. |
| T07 `ErrorOn.trans` | Rewrite `f x - c x = (f x - a x) + (a x - c x)`, apply `norm_add_le`, then `add_le_add` to the two premises. | Both error premises on the same point/domain, additive group algebra, and triangle inequality. |
| T08 `ErrorOn.comp` | For `y ∈ S`, `hψ hy : ψ y ∈ D`; apply `h (ψ y)` and unfold the three compositions. | `h`, `ψ`, and `MapsTo`; no injectivity, surjectivity, continuity, or nonemptiness. |

No conclusion is assumed in a hypothesis, and no choice is used. Every explicit
transport hypothesis is used. The only overstrength observation is that all
eight declarations also compile after uniformly replacing
`NormedAddCommGroup E` with `SeminormedAddCommGroup E`; norm separation is not
used by this eight-target slice. I treat the frozen stronger class as an
explicit, conservative API choice rather than hidden hypothesis laundering.

## Boundary and adversarial checks

- Import boundary: the exact harness has the single import `LMLF.Basic`; that
  module imports only `Mathlib.Analysis.Normed.Group.Basic` at this commit.
- Namespace boundary: the three predicates elaborate in
  `QuantitativeAnalysis`; the five theorems elaborate in
  `QuantitativeAnalysis.ErrorOn` with exactly the frozen fully qualified names.
  The ambient `Y` binder appears only in `ErrorOn.comp`.
- Public-count boundary: the exact harness contains exactly three `def` and five
  `theorem` commands, in the frozen order, with no ninth public declaration.
  Nonpublic checks were `example`s in a separate disposable namespace.
- Domain: compiled tests confirm empty-domain vacuity and a counterexample to
  reversing restriction from `∅` to `univ`.
- Majorants/order: compiled tests confirm that negative values off an empty
  domain are harmless, comparison must go from `b` to the larger `d`, and a
  smaller majorant can fail. A one-point conditional example witnesses why a
  transitive bound cannot generally be replaced by either component bound.
- `MapsTo`: a compiled example has a vacuous source-domain error bound but a
  false pullback bound on `univ`; the corresponding map is not `MapsTo`. Thus
  the signature has the necessary direction and source/target sets.
- Family semantics: a compiled family with approximants `n • z` and bounds
  `‖n • z‖` has a fixed zero target, is valid at every order, is nonexact at
  order one, and has `b 0 < b 1` when `0 < ‖z‖`. Another valid family has empty
  domains and negative bounds. Hence `HasErrorFamily` entails neither
  convergence, exactness, nonempty/eventual domains, nor order improvement.
- Trust scan: no `sorry`, `admit`, `axiom`, `unsafe`, `maxHeartbeats`, or
  `maxRecDepth` occurred in any disposable Lean harness.

## Compiler, diagnostics, and axioms

- Lean: `4.33.1`, commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`.
- Lake: `5.0.0-src+819816b`.
- Resolved Mathlib checkout: `0df444a360eaa60ab8c11dca51a86af692955474`,
  exactly the packet/manifest pin.
- `lake build LMLF.Basic`: passed (`1321/1321`).
- `lake build`: passed (`1325` jobs).
- Exact independent proof harness: passed with zero final diagnostics.
- Adversarial semantic harness: passed with zero final diagnostics.
- Weaker-assumption diagnostic harness: passed with zero final diagnostics.
- Axiom reports for each of all eight frozen declarations were exactly
  `[propext, Classical.choice, Quot.sound]`, equal to the packet allowlist.

Disposable harness digests:

- `QB001Frozen.lean`:
  `85186df24d4efb2b96f4e97fc145fe648f90bf99a50d45b5d7f9004f646f428f`
- `QB001Adversarial.lean`:
  `42c8ef883b5684856faf2131085e2a57441b3a562cbf1d4fcba4969588c66564`
- `QB001WeakerAssumption.lean`:
  `ae4bdc57ceb8304e17aa4a0c6b54f9c5e8f83a254730fbec6ef63c6a0cc3101e`

## Commands executed

```text
git -C /home/codex/Documents/Codex/2026-09-05/yo rev-parse d0aa1c55967d7cde7187f5c8b7a05b76d7043fe5^{commit}
git -C /home/codex/Documents/Codex/2026-09-05/yo show -s --format=... d0aa1c55967d7cde7187f5c8b7a05b76d7043fe5
git -C /home/codex/Documents/Codex/2026-09-05/yo archive d0aa1c55967d7cde7187f5c8b7a05b76d7043fe5 | tar -x -C /tmp/qb-d0-referee-h.LbboR4
sha256sum review/work_packets/QB-001.yaml blueprint/theorem_cards/QB-001.yaml blueprint/proofs/QB-001.md blueprint/theorem_cards/QB-001-signatures.md LMLF/Basic.lean
sed/nl/rg (only the frozen packet, card, proof, signatures, protocol/rubric, classification vocabulary, and tracked boundary files in the archive)
elan which lean
lean --version
lake --version
lake update
lake exe cache get
lake build LMLF.Basic
lake env lean QB001Frozen.lean
lake env lean QB001Adversarial.lean
lake env lean QB001WeakerAssumption.lean
lake build
/home/codex/.codex/skills/referee-lean-proof/scripts/check_lean_file.sh QB001Frozen.lean
/home/codex/.codex/skills/referee-lean-proof/scripts/check_lean_file.sh QB001Adversarial.lean
/home/codex/.codex/skills/referee-lean-proof/scripts/check_lean_file.sh QB001WeakerAssumption.lean
python3 scripts/validate_inventory.py
```

All commands above returned exit status 0 except an initial disposable
`QB001Frozen.lean` check performed before `lake build LMLF.Basic`, which reported
the expected missing local `LMLF` olean; building `LMLF.Basic` resolved it. An
initial proof candidate used `simpa` for T04 and produced only the
`unnecessarySimpa` linter; replacing it with `simp` yielded the recorded clean
final harness. Early adversarial-test drafts also exposed that the narrow
`LMLF.Basic` import intentionally does not supply a concrete real normed-group
instance; the final tests are polymorphic and compile under the required single
import. No failed draft affected the frozen source or final conclusions.

## Report hash

The report hash is non-self-referential: replace the 64 hexadecimal characters
in the `normalized_report_sha256` field below with 64 ASCII zeroes, then compute
SHA-256 over the entire resulting file bytes.

normalized_report_sha256: 33ba5a41c0c73199412f1c6967567b56f0eab8dfa2567a3a6a551a7ee7803a74
