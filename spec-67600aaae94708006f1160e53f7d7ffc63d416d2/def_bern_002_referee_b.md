# Independent referee B report: LMLF DEF-BERN-002

## Decision

I approve the mathematical content of the exact-commit `DEF-BERN-002` theorem card, its revision-1 natural-language proof, the relevant Chapter 8 source transcription, and the decision to reuse pinned Mathlib's existing `periodizedBernoulli` without adding an LMLF declaration.

This is a valid independent fresh-context pre-signature technical approval of the exact bytes bound below. It is not, by itself, an authoritative protocol verdict, a passed external gate, a signature, `lean_ready` authorization, source-coverage credit, or implementation authorization. Those stronger statuses remain unavailable because the card and proof are draft/unregistered planning artifacts, `DEF-BERN-001` is not yet accepted, there is no frozen `DEF-BERN-002` work packet or external review envelope, and the runtime isolation used here was a manual attestation rather than a technically enforced clean room.

The distinction is deliberate: no mathematical or API correction is required before signature, but the governance acceptance conditions in this report must be completed before the project records formal approval. Any change to the exact commit or any bound artifact byte invalidates this pre-signature approval unless a later external record explicitly demonstrates unchanged reviewed artifact digests and the governing process permits that reuse.

Verdicts:

- Theorem card: **approve for pre-signature**. Its target, classification, quantifiers, conventions, exclusions, dependencies, and declaration-free boundary are mathematically sound.
- Natural-language proof: **approve for pre-signature**. It reaches the identification without circularity or hidden analytic assumptions and treats every convention-sensitive edge case correctly.
- Source transcription: **approve for the Chapter 8 section 1 formula-level collation inspected here**, including the periodic Bernoulli material on printed pages 279-284. Its retained ambiguity notes are appropriate. Formal inventory reconciliation still requires the project's external quorum and status update.
- Mathlib reuse and API/dependency design: **approve**. Direct reuse is the canonical boundary; a project definition, alias, notation, wrapper, theorem, or real-line facade would be duplication in this packet.
- Formal gate state: **not yet pass**. This report supplies independent pre-signature evidence only; it cannot override the candidate-owned `draft`, `not_started`, `planning_only`, or `transcribed_unreconciled` statuses.

No P0 or P1 mathematical, source-fidelity, trust, circularity, or dependency finding was found. No change to the reviewed card, proof, or transcription is requested on mathematical grounds.

## Review identity and isolation

Reviewer identity: `/root/def_bern_002_referee_b`; reviewer kind: agent; runtime: Codex desktop agent runtime; model: GPT-5-family Codex deployment, with no more specific deployment identifier exposed to this session.

Isolation strength is `manual_attestation`. I used a disposable `git archive` of exact commit `67600aaae94708006f1160e53f7d7ffc63d416d2` and a separate disposable clone of exact Mathlib revision `0df444a360eaa60ab8c11dca51a86af692955474`. I did not inspect the live dirty worktree, other referee reports, or any prior review output. I did not list or query sibling agents. The only inter-agent communication was a concise status checkpoint sent to the parent after the parent explicitly requested it; that exchange supplied no mathematical evidence or prior verdict. No repository file was modified. Disposable PDF renderings, dependency checkouts, and a Lean audit file were created only under `/tmp`.

I read the complete 1,753-line project brief, both required referee skills, both required local/global rubrics, the project source/reuse/API/proof rubrics, and the relevant governance protocol. I visually inspected the supplied PDF pages 292-297, corresponding to printed pages 279-284, rather than relying only on extracted text.

## Exact bindings

Reviewed specification commit:

- Git commit: `67600aaae94708006f1160e53f7d7ffc63d416d2`.
- Card: `blueprint/theorem_cards/DEF-BERN-002.yaml`, card revision 1, SHA-256 `566868cfa5d837b390ac0416a86758b7cb72f110237e58149cbd992d51595bd3`.
- Proof: `blueprint/proofs/DEF-BERN-002.md`, artifact `NLP-BERN-002-R1`, revision 1, SHA-256 `e74e8a5af3cc65e3b487360dbce5e300c813ea6d60ebcab51445c6f2a8824ffd`.
- Source transcription: `blueprint/source_transcriptions/OLV97-C08-EULER-MACLAURIN.md`, SHA-256 `f0d1113204c984096f04af658037aed6ddb9012fbcca5fb6dfdfb84c4bdadb99`.
- Private source snapshot: `SRC-OLV-1997-USER-PDF-20260905`, SHA-256 `08e1844d29a5ad21f89b9b600249ce18ac1665a5845be2d4e4219a3ededdc909`.
- Source occurrence: `OLV97-C08-EULER-MACLAURIN`; source entity: `periodic_bernoulli_functions`; notation: `OLV97-N-EM-OMEGA`.
- Source edition/location: F. W. J. Olver, *Asymptotics and Special Functions*, corrected A K Peters reprint, 1997, ISBN 1-56881-069-5, Chapter 8 section 1, printed pages 279-284, PDF pages 292-297.
- Original project brief: SHA-256 `6787cdb628a66783d81190939e9593525ebb2640a8c870d685d95ce26ba0cce3`.

Governance and dependency bindings:

- Classification registry: `review/classifications-v2.json`, schema `lmlf-classification-v2`, artifact revision 2, SHA-256 `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9`.
- Mathlib audit: `blueprint/mathlib_audit.md`, SHA-256 `6b0aab27aac6711894567048c3f232f6ab3345b5d0c79b5b3402e0ecad38378c`.
- Lean toolchain: `leanprover/lean4:v4.33.1`; `lean-toolchain` SHA-256 `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71`.
- Mathlib tag: `v4.33.1`; resolved revision: `0df444a360eaa60ab8c11dca51a86af692955474`.
- Project `lake-manifest.json` SHA-256: `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`.
- Draft prerequisite `DEF-BERN-001` card revision 1: SHA-256 `344078c22e3525fe6dcd1c11c83962d52bad496a62c48bdce3e6fb47b53b507b`.
- Draft prerequisite proof `NLP-BERN-001-R1`: SHA-256 `91acc0f38731738eaec1317ef50af9831f89a674d9512bb16bcafc6d454eef3d`.

The six frozen Mathlib source hashes all matched a fresh exact-revision clone:

- `Mathlib/NumberTheory/Bernoulli.lean`: `25e02401c1ccb47d6a7db4637cdaf15cf1d3d89539b8de0755887b3aa88376d1`.
- `Mathlib/NumberTheory/BernoulliPolynomials.lean`: `936ad39ef25a9dc336836d1f564e7a369cea0ea1978a8bbf0ed565c5cef335cf`.
- `Mathlib/NumberTheory/ZetaValues.lean`: `491a1fc741734e2eb5a79684542bc0b57bc6333e0dc7619c47fecbaa366d8b73`.
- `Mathlib/Topology/Instances/AddCircle/Defs.lean`: `7de9890e577f8c3bd6ba6b30975a3f8e13f0bc5819086d68ab8856f6fd83575e`.
- `Mathlib/Topology/Instances/AddCircle/Real.lean`: `7fec0ee52acda634f28458e2aadda46873aa4b00e0d7b8b447fb1d7680a62b5f`.
- `Mathlib/Algebra/Order/Floor/Ring.lean`: `d46979d7e9a446825f04b9b8ee080d303812c01083406ed9e76a296454a5387f`.

## Independent mathematical derivation

Olver first fixes the saw-tooth by

\[
\omega_1(x)=x-[x]-\tfrac12=\{x\}-\tfrac12,
\qquad 0\leq \{x\}<1,
\]

where the negative-input footnote makes `[x]` the ordinary floor. The higher `omega_s` are zero-mean periodic primitives. Comparing the ordinary coefficient series with the Bernoulli exponential generating series gives the source equation (1.07)

\[
s!\,\omega_s(x)=B_s(x-[x])=B_s(\{x\}).
\]

This equation identifies the unscaled periodic Bernoulli polynomial `B_s({x})`; it does not identify `omega_s` without the factorial.

At the pin, `UnitAddCircle` is `AddCircle (1 : Real)` and

\[
\operatorname{periodizedBernoulli}(s)
=\operatorname{AddCircle.liftIco}(1,0)(\operatorname{bernoulliFun}(s)).
\]

For a real `x`, `AddCircle.coe_equivIco_mk_apply` computes the chosen representative as

\[
\operatorname{Int.fract}(x/1)\,1=\operatorname{Int.fract}(x).
\]

The pinned `Int.fract_nonneg` and `Int.fract_lt_one` put it in `[0,1)`. Consequently

\[
\operatorname{periodizedBernoulli}(s)(x:\operatorname{UnitAddCircle})
=\operatorname{bernoulliFun}(s)(\operatorname{Int.fract}x).
\]

On `y` in `[0,1)`, the representative is `y` itself, so the circle function restricts to `bernoulliFun s y`. Conditional only on accepting `DEF-BERN-001`, this is Olver's `B_s(y)`. Every circle point has a unique `[0,1)` representative, so agreement there identifies the entire circle-valued function. Combining this with Olver (1.07) yields

\[
\operatorname{periodizedBernoulli}(s)(x:\operatorname{UnitAddCircle})
=B_s(\{x\})=s!\,\omega_s(x).
\]

The direction of the normalization is therefore correct: `omega_s` is the pullback divided by `s!`. At `s=2`, for example, `periodizedBernoulli 2 = 2! omega_2`; omitting the factorial is observably false.

## Edge cases and adversarial checks

At `s=0`, `bernoulliFun_zero` gives the constant `1`; the half-open lift is therefore the constant circle function `1`. This agrees with the source's later `omega_0=1` convention because `0!=1`.

At `s=1`, `bernoulliFun_one` gives `B_1(y)=y-1/2`. For every integer `k`, `Int.fract (k : Real)=0`, hence the assigned value is `-1/2`. Approaching `k` from the right makes the representative tend to `0` and the value tend to `-1/2`; approaching from the left makes the representative tend to `1` from below and the value tend to `+1/2`. Thus the right-minus-left jump is `-1`. A lift through `(0,1]` would assign `+1/2` and is not extensionally interchangeable with the pinned `[0,1)` lift.

At `s=2`, `bernoulliFun_two` gives `y^2-y+1/6`, whose endpoint values both equal `1/6`; the pinned circle function is continuous. More generally, `bernoulliFun_endpoints_eq_of_ne_one` and `periodizedBernoulli.continuous` give global circle continuity only when `s != 1`. The dossier separately proves that the exclusion is genuine at `s=1` from the unequal one-sided pullback limits.

For negative inputs, `Int.fract` uses floor, not truncation toward zero. In particular, `Int.fract (-1/4)=3/4`, which lies in the required fundamental interval.

The proof makes no false global derivative claim. It distinguishes the ordinary polynomial derivative from cellwise derivatives of the real periodic pullback and expressly reserves real-line calculus for `BER-001`. It does not differentiate through the `B_1` jump.

The proof makes no false global continuity claim. Its only global circle-continuity theorem carries the exact condition `s != 1`, and it adversarially rejects the all-index statement.

The proof makes no analytic convergence claim about `periodizedBernoulli`, no claim that a finite Euler-Maclaurin family converges in order, and no boundary-convergence claim for the Bernoulli generating series. The transcription faithfully records the source's strict interior condition `|t|<2 pi`; this series fact is not used to infer periodic differentiability or any Euler-Maclaurin remainder bound.

The packet claims no Euler-Maclaurin theorem, primitive/integral/envelope API, Fourier expansion, zeta value, or numerical result. None is smuggled in as identification evidence.

## Exact pinned API and import check

A disposable Lean 4.33.1 check containing only `import Mathlib.NumberTheory.ZetaValues` compiled successfully at Mathlib revision `0df444a360eaa60ab8c11dca51a86af692955474`. It checked all card names and compiled proofs of the arbitrary-real pullback, `[0,1)` agreement, the integer `s=1` value, the constant `s=0` function, the negative fractional-part example, the `s=1` endpoint values, the `s=2` endpoint equality, and conditional continuity.

The exact checked declarations were:

- `_root_.periodizedBernoulli (k : Nat) : UnitAddCircle -> Real`.
- `_root_.bernoulliFun (k : Nat) (x : Real) : Real`.
- `AddCircle.liftIco` and `AddCircle.liftIco_zero_coe_apply`.
- `AddCircle.coe_equivIco_mk_apply`.
- `Int.fract_nonneg`, `Int.fract_lt_one`, and `Int.fract_intCast`.
- `_root_.bernoulliFun_one`, `_root_.bernoulliFun_eval_zero`, and `_root_.bernoulli_one`.
- `_root_.bernoulliFun_endpoints_eq_of_ne_one` and `_root_.periodizedBernoulli.continuous`.
- `_root_.bernoulliFun_zero` and `_root_.bernoulliFun_two`.
- `AddCircle.continuous_mk'`.

The precise `bernoulliFun_eval_zero` type coerces the rational `bernoulli k` to `Real`; the card's expected shape is semantically correct. The precise quadratic theorem writes the constant as `6^-1`; the card's `1/6` description is definitionally the same real value.

`Mathlib.NumberTheory.ZetaValues` publicly imports `Mathlib.NumberTheory.BernoulliPolynomials`, interval-integral basics, polynomial `ContDiff` and derivative support, Fourier support on the additive circle, and p-series support. The audited declaration itself is defined only in `ZetaValues`, so using that module is unavoidable at this pin even though it is broader than the foundational Bernoulli files. Because `DEF-BERN-002` creates no LMLF module or declaration, it adds no project import fanout. The card correctly records narrower defining sources for additive-circle and fractional-part facts rather than pretending they originate in `ZetaValues`.

A repository-wide source search in the exact Mathlib checkout found one definition of `periodizedBernoulli` and one definition of `bernoulliFun`, both in `Mathlib/NumberTheory/ZetaValues.lean`. A search of the exact LMLF archive found no Bernoulli definition, alias, notation, theorem, or wrapper. The declaration-free choice is therefore architecturally sound and prevents a duplicate foundational object. The dependency direction

\[
\text{DEF-BERN-001}\longrightarrow\text{DEF-BERN-002}\longrightarrow\text{BER-001}\longrightarrow\text{EM-001}
\]

is also sound: polynomial normalization precedes periodization identification; a later real facade/calculus layer consumes that identification; Euler-Maclaurin consumes both. No downstream Fourier, zeta, `BER-001`, or `EM-001` fact is used backward to identify the object.

## Source transcription verdict

Visual comparison of PDF pages 292-297 with the complete 401-line transcription confirmed the material relevant to this packet and the neighboring formula context:

- the half-weighted endpoint convention and first cellwise integration-by-parts identity;
- the unusual-looking but ordinary-floor negative-input footnote;
- the continuous, zero-mean periodic primitive construction;
- finite Euler-Maclaurin equation (1.04) and its exact integral remainder, with no source remainder inequality;
- periodic generating series (1.05), Bernoulli exponential generating series (1.06), and strict radius `|t|<2 pi`;
- factorial normalization (1.07), derivative and zero-mean range `s >= 1`;
- negative `B_1`, coefficient, reflection, recurrence, low values, midpoint identity, and positive-even zeta formula;
- the fact that exercises and section 2.1 lie outside the collated numbered-equation boundary.

The transcription's derived half-open Euler-Maclaurin rearrangement and Bernoulli rewrites have the correct signs and factorials. They are clearly labelled as derived, not printed equation numbers. The transcription correctly retains unresolved questions about the source's informal `slowly varying` hypothesis, scalar codomain, recursive-index range, the phrase about uniformity in `x`, and the exact real/complex scope of nearby `x` prose. None affects the direct periodization identification.

## Findings and acceptance conditions

### F1 — P2 governance/index freshness, non-mathematical

The exact commit deliberately keeps `DEF-BERN-002` unregistered and planning-only, and there is no `review/work_packets/DEF-BERN-002.yaml`, `cards.csv` entry, or occurrence-card association. That is consistent with the card's own status and is not a defect at the current planning boundary. However, some navigation prose is stale or incomplete: `blueprint/theorem_cards/README.md` enumerates unregistered planning cards without naming `DEF-BERN-002`, and `blueprint/function_inventory.md` mentions the revision-1 Bernoulli number/polynomial card while omitting the separate periodization card. The top-level and blueprint README files refer only generically to a Bernoulli identification draft.

Acceptance condition: before promotion or a formal gate, reconcile the navigation/registry truth, create the bounded non-self-referential work packet required by protocol, and add the appropriate card/occurrence associations if the packet is being registered. Keep source coverage at zero and the occurrence `transcribed_unreconciled` until the external source quorum actually passes. This condition does not require changing the reviewed mathematical card/proof text.

### F2 — Required upstream and external gate state, not a content defect

`DEF-BERN-001` revision 1 is a draft prerequisite, and the source polynomial identification is intentionally conditional on its acceptance. No external review envelope currently binds this exact card/proof pair, classification schema, source bytes, pin, and packet. Therefore formal approval and `lean_ready` are correctly absent.

Acceptance condition: accept `DEF-BERN-001` at the exact bound card/proof revisions or rebind and rereview any replacement; freeze and externally bind the `DEF-BERN-002` packet, card, proof, source, classification schema, and pin; satisfy the card's two-source-collator, two-card-referee, two-proof-referee, and required structural-circularity quorum; record durable reviewer/model/runtime/isolation metadata; and set any composite gate only in the external envelope. This report may support that process as pre-signature evidence but cannot self-certify it.

### F3 — Preserve the declaration-free boundary

There is no implementation missing from this packet. The target is an exact identification of an existing pinned declaration, not a request for a wrapper theorem.

Acceptance condition: retain an empty LMLF declaration list; do not add a new Bernoulli object, real facade, compatibility alias, notation, source-identification theorem, or broad project import under `DEF-BERN-002`. Any later real pullback facade and cellwise calculus belong in separately reviewed `BER-001`; Euler-Maclaurin identities and bounds belong later still.

## Rubric conclusion

All global-library sections are clear except the bounded P2 governance/index handoff F1. The mathematical intent, reusable seam, public-API boundary, dependency direction, Mathlib integration, proof architecture, cost/durability, and refactor risk all favor keeping this packet declaration-free.

All local-proof sections applicable to a natural-language, no-implementation packet are clear. There is no trust escape, hidden conclusion, global derivative misuse, totalization exploit, simplifier fragility, performance claim, or public-statement drift to report. Lean implementation proof-quality review is not applicable because the packet intentionally proposes no Lean declaration.

Final disposition: **approve exact card/proof/source-reuse content for pre-signature, subject only to the explicit governance acceptance conditions above; do not record an authoritative gate pass from this report alone.**

The final SHA-256 of this report is intentionally supplied out of band after the file is closed, because embedding a file's own digest in that same file would be self-referential.
