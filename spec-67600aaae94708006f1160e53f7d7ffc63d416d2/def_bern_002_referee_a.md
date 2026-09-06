# Independent pre-signature referee report: DEF-BERN-002

## Decision

| Review surface | Verdict |
|---|---|
| Theorem card `DEF-BERN-002`, revision 1 | **APPROVE** |
| Natural-language proof `NLP-BERN-002-R1`, revision 1 | **APPROVE** |
| Bound-source identification and pinned-Mathlib reuse | **APPROVE** |
| Dependency direction / source-to-target reachability / hypothesis-and-choice laundering | **APPROVE** |

**Independent pre-signature approval:** **YES - this report counts as one independent pre-signature approval** for the exact card, proof, and source/reuse identification bound below. It is one reviewer identity and therefore counts at most once in any distinct-reviewer union.

This approval does **not** itself set a repository-protocol gate to `pass`, make the draft `frozen`, register the card, create a work packet or external review envelope, accept the upstream `DEF-BERN-001` dependency, authorize Lean work, or satisfy the required two-reviewer quorums. Those controls are correctly left external to the reviewed artifacts.

## Review identity and isolation

- Work item: `DEF-BERN-002`
- Reviewer ID: `/root/def_bern_002_referee_a`
- Reviewer kind: agent
- Model/runtime: Codex agent, GPT-5 family (the exact serving model identifier was not exposed in-session), Codex desktop runtime
- Issued at: `2026-09-06T02:38:26Z`
- Independence: fresh agent context; independent of the proposer; no other referee report was read and no other reviewer was contacted
- Isolation strength: `manual_attestation`
- Candidate access: read-only exact-commit review; no candidate or Mathlib edits
- Isolation method: repository evidence was read only from a disposable extraction made with `git archive 67600aaae94708006f1160e53f7d7ffc63d416d2`; pinned Mathlib was independently extracted with `git archive 0df444a360eaa60ab8c11dca51a86af692955474`; the private Olver PDF and original brief were read from their supplied immutable paths. The only generated Lean file and rendered page images lived in the disposable `/tmp` extraction.

## Exact bindings

### Specification and primary artifacts

| Artifact | Exact identity / SHA-256 |
|---|---|
| Specification commit | `67600aaae94708006f1160e53f7d7ffc63d416d2` |
| Git tree | `d7f8fa3ffb015d275fe469419acfeb1543ac82a0` |
| Deterministic `git archive --format=tar` | `33be2d547c1d2836310eac7a0b7ec5c765df2e13b6945d839d01373afcb812a3` |
| `blueprint/theorem_cards/DEF-BERN-002.yaml` | `566868cfa5d837b390ac0416a86758b7cb72f110237e58149cbd992d51595bd3` |
| `blueprint/proofs/DEF-BERN-002.md` | `e74e8a5af3cc65e3b487360dbce5e300c813ea6d60ebcab51445c6f2a8824ffd` |
| `blueprint/source_transcriptions/OLV97-C08-EULER-MACLAURIN.md` | `f0d1113204c984096f04af658037aed6ddb9012fbcca5fb6dfdfb84c4bdadb99` |
| Private Olver PDF | `08e1844d29a5ad21f89b9b600249ce18ac1665a5845be2d4e4219a3ededdc909` |
| Full original brief | `6787cdb628a66783d81190939e9593525ebb2640a8c870d685d95ce26ba0cce3` |
| `review/PROTOCOL.md` | `e1a85b683abce3072c3e4275ca9312716025d768c4d542aab9c556c6ccc542a3` |
| `review/classifications-v2.json` | `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9` |
| `review/classifications-v1.yaml` | `7a4f322bb56dbb40d5d44a7eceb50b5a49ea6ae69f414b920341e3b12ea9d71e` |

The v2 schema's recorded v1 supersession digest matches the actual v1 bytes.

### Upstream, audit, and inventory context

| Artifact | SHA-256 |
|---|---|
| `blueprint/theorem_cards/DEF-BERN-001.yaml` | `344078c22e3525fe6dcd1c11c83962d52bad496a62c48bdce3e6fb47b53b507b` |
| `blueprint/proofs/DEF-BERN-001.md` | `91acc0f38731738eaec1317ef50af9831f89a674d9512bb16bcafc6d454eef3d` |
| `blueprint/mathlib_audit.md` | `6b0aab27aac6711894567048c3f232f6ab3345b5d0c79b5b3402e0ecad38378c` |
| `blueprint/source_manifest.md` | `678d90804362dfc4e1a29ed8790ad5885c8c5b9cb8714f37b9cfe128776d7940` |
| `blueprint/function_inventory.md` | `462d781f571d94f20781397d7cf5b5b9a00b5d509ae8e33b42ea1faa14875599` |
| `blueprint/dependency_graph.md` | `7c5ca4b66420982a228c7ad37f49c4b26ec6c2fac3cb3f863288455efa5d263b` |
| `blueprint/inventory/source_snapshots.csv` | `50dcbe401b9c00f81197def8dea95c355c98480987526da62490cd94ba4d3338` |
| `blueprint/inventory/page_audits.csv` | `e2875f0408ed9725460d31922e69acea86b3374d84d4253670d59d877432276e` |
| `blueprint/inventory/occurrences.csv` | `3ee3217162aad8830ba5a4066a8c8b44dd99b96d4eb99eb68a8cebc4d3ec7758` |
| `blueprint/inventory/entities.csv` | `6fd00196e7054b3366f90f785ffb4bf0119e633f927793fe3f68cf636bcdad91` |
| `blueprint/inventory/entity_evidence.csv` | `bee0913f4a5e8af8f36d15bcc560775351e334b537acc32f4ca77d3ca4a5e1df` |
| `blueprint/inventory/notation.csv` | `71c5207de8572c8efc1a8deb7c76dd3bb2df6d730ecbb34e35823f3d7c139ac0` |
| `blueprint/inventory/occurrence_entities.csv` | `461bb841ddc552accd5bd93f2539f1f599b697a5693d865184622a1d05070d5a` |
| `blueprint/inventory/occurrence_notations.csv` | `b1f8324f0ba92c09b26218c64fb12eef28c75c8e6f1ae0cead99d3cefe5f68e9` |
| `blueprint/inventory/occurrence_cards.csv` | `dc33f603d23cba66f0cf7f41e2e1c78b7c30c8b895b01fb630206485d7ab3f8d` |
| `blueprint/inventory/occurrence_manifests.csv` | `901fb438b52ddfabff2358deca710efb3e98cf3d59b51768921041b8e9c5f100` |

The inventory consistently leaves this work unregistered, planning-only, outside all manifests, and `transcribed_unreconciled`; no card or manifest association is fabricated.

### Toolchain and pinned Mathlib

- `lean-toolchain`: `leanprover/lean4:v4.33.1`, file SHA-256 `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71`
- Resolved Mathlib commit: `0df444a360eaa60ab8c11dca51a86af692955474`
- `lake-manifest.json`: `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`
- Lean runtime: `4.33.1`, Lean commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`

All card-bound Mathlib source digests matched an independent archive of the pin:

| Pinned source | SHA-256 |
|---|---|
| `Mathlib/NumberTheory/Bernoulli.lean` | `25e02401c1ccb47d6a7db4637cdaf15cf1d3d89539b8de0755887b3aa88376d1` |
| `Mathlib/NumberTheory/BernoulliPolynomials.lean` | `936ad39ef25a9dc336836d1f564e7a369cea0ea1978a8bbf0ed565c5cef335cf` |
| `Mathlib/NumberTheory/ZetaValues.lean` | `491a1fc741734e2eb5a79684542bc0b57bc6333e0dc7619c47fecbaa366d8b73` |
| `Mathlib/Topology/Instances/AddCircle/Defs.lean` | `7de9890e577f8c3bd6ba6b30975a3f8e13f0bc5819086d68ab8856f6fd83575e` |
| `Mathlib/Topology/Instances/AddCircle/Real.lean` | `7fec0ee52acda634f28458e2aadda46873aa4b00e0d7b8b447fb1d7680a62b5f` |
| `Mathlib/Algebra/Order/Floor/Ring.lean` | `d46979d7e9a446825f04b9b8ee080d303812c01083406ed9e76a296454a5387f` |

## Independent mathematical and API findings

### Source identification and normalization: clear

Rendered inspection of PDF pages 292-297 (printed pp. 279-284) confirms the exact source chain used by the dossier:

1. Olver defines `[x]` so that, including for negative `x`, it is the integer in `(x-1,x]`; hence it is the ordinary floor and `x-[x]` is the representative in `[0,1)`.
2. The source defines `omega_1(x)=x-[x]-1/2`, so `omega_1(k)=-1/2` at an integer, with right limit `-1/2` and left limit `+1/2`.
3. Equations (1.01)-(1.03) fix higher `omega_s` as periodic zero-mean primitives.
4. Equation (1.05) uses the ordinary generating series `sum omega_s(x) t^s`; equation (1.06) uses `sum B_s(x)t^s/s!`; equation (1.07) therefore states exactly
   `s! * omega_s(x) = B_s(x-[x]) = B_s({x})`.
5. The source prints `B_1=-1/2`, `B_1(x)=x-1/2`, and the derivative range `s >= 1`. No branch, pole, analytic continuation, or derivative-through-the-jump claim is part of this packet.

The card and proof preserve the factorial in the correct direction. They identify Mathlib's object with the **unscaled** periodic polynomial `B_s({x}) = s! * omega_s(x)`, not with `omega_s`; the `s=2` regression detects the distinction. The source location, edition, page map, equation range, endpoint policy, index-first argument order, real domain, and exceptional regularity index are faithful.

### `liftIco` / `Int.fract` bridge: clear

At the exact Mathlib pin:

- `_root_.periodizedBernoulli (k : Nat) : UnitAddCircle -> Real` is defined in `Mathlib.NumberTheory.ZetaValues` by `AddCircle.liftIco 1 0 (bernoulliFun k)`.
- `AddCircle.equivIco` and `AddCircle.liftIco` in `Mathlib.Topology.Instances.AddCircle.Defs` use the half-open interval `[a,a+p)`.
- `AddCircle.coe_equivIco_mk_apply` computes the representative as `Int.fract (x/p) * p`; at `p=1` this simplifies to `Int.fract x`.
- `Int.fract_nonneg`, `Int.fract_lt_one`, and `Int.fract_intCast` have the names and roles recorded in the card.

A disposable Lean theorem compiled under the pin:

```lean
theorem pber_pullback (s : Nat) (x : Real) :
    periodizedBernoulli s (x : UnitAddCircle) =
      bernoulliFun s (Int.fract x) := by
  simp [periodizedBernoulli, AddCircle.liftIco]
```

This also shows that the proof's arbitrary-real equality is not relying on an invented bridge name. `AddCircle.liftIco_zero_coe_apply` separately gives agreement on every `y in Ico 0 1`, and `AddCircle.equivIco 1 0` is an equivalence whose inverse is the quotient map, so the real pullback reaches and determines every circle point.

### Endpoint and continuity semantics: clear

The exact declarations `bernoulliFun_one`, `bernoulliFun_eval_zero`, `bernoulli_one`, `bernoulliFun_endpoints_eq_of_ne_one`, `periodizedBernoulli.continuous`, and `AddCircle.continuous_mk'` all exist with the recorded orientations and defining imports.

For an integer `k`, the pullback bridge and `Int.fract_intCast` give `bernoulliFun 1 0=-1/2`. On representatives `y -> 0+`, `bernoulliFun 1 y=y-1/2 -> -1/2`; on representatives `y -> 1-`, it tends to `+1/2`. If the circle function were continuous at the integer class, composition with the continuous quotient map would be continuous, contradicting these pullback limits. Conversely, endpoint equality for `s != 1` is precisely the hypothesis used by pinned `periodizedBernoulli.continuous`. The dossier neither averages the jump nor differentiates through it.

### Quantifiers, classifications, scope, and dependencies: clear

The fixed-source/fixed-pin data precede universal `s : Nat` and `x : Real`; no representative is chosen after those binders. The identification is global on the real pullback and, by the quotient equivalence, on all `UnitAddCircle`. The target classifications `identification` / `source_prerequisite` / `source_equivalent` are valid under classification v2, while packet-level `definition_identification` / `entity_identification` / `non_novel` correctly makes no theorem-occurrence coverage claim.

The dependency direction is sound:

```text
DEF-BERN-001 -> DEF-BERN-002 -> BER-001
                                 |
                                 v
                               EM-001
```

`DEF-BERN-001` supplies the polynomial normalization; it is explicitly pending rather than laundered. Neither `BER-001`, `EM-001`, Fourier facts, zeta values, nor an Euler-Maclaurin identity flows backward into the identification. No theorem-sized hypothesis or post-hoc choice is present.

The declaration-free boundary is exact: the card has `candidate_module: null`, an empty public-declaration list, and no signature artifact; the archived `LMLF` Lean sources contain no Bernoulli declaration, alias, wrapper, or notation. Reusing the canonical circle-valued object is preferable to creating a real-line facade in this packet. `Mathlib.NumberTheory.ZetaValues` is the narrow existing module that actually defines both `bernoulliFun` and `periodizedBernoulli`; the lower facts are correctly attributed to their defining files.

### Proof completeness and regressions: clear

The natural-language proof reaches its sole target without circularity: accepted polynomial identification + pinned half-open lift + fractional-part computation yields the full pullback, surjectivity yields the full circle object, and source equation (1.07) supplies the factorial relation. Endpoint and continuity checks independently expose the only normalization-sensitive exception.

Disposable pinned-Lean checks passed for:

- every `PBER-M00` through `PBER-M15` name and type/role;
- the arbitrary-real pullback equality;
- agreement on `[0,1)`;
- `s=0` constant value `1`;
- `s=1` integer value `-1/2`;
- negative input `-1/4`, whose representative is `3/4` and whose first-periodized value is `1/4`;
- `s=2` matching values `1/6` at quotient inputs `0` and `1`;
- continuity for `s != 1`.

The false alternatives - `liftIoc` at the integer, missing the factorial, truncation toward zero, or continuity at `s=1` - are all observably rejected by these semantics.

## Prioritized findings and exact acceptance conditions

**Material findings:** none (`P0`: none; `P1`: none; `P2`: none; `P3`: none). No change to the card, proof, source transcription, reuse decision, or dependency graph is requested.

The following are pre-existing gate conditions, not defects in the reviewed artifacts:

1. **AC1 - exact binding.** Any counted approval must bind specification commit `67600aaae94708006f1160e53f7d7ffc63d416d2`, card SHA-256 `566868...95bd3`, proof SHA-256 `e74e8a...24ffd`, transcription SHA-256 `f0d111...adb99`, source PDF SHA-256 `08e184...dc909`, classification SHA-256 `8c9f8d...23e9`, toolchain `v4.33.1`, and Mathlib `0df444...55474`. Any byte or pin change requires fresh review.
2. **AC2 - upstream acceptance.** `DEF-BERN-001` revision 1 at card/proof digests `344078...507b` and `91acc0...ef3d` must be independently accepted before `DEF-BERN-002` can freeze or authorize anything. This report does not accept that separate packet.
3. **AC3 - external protocol record.** A frozen, non-self-referential work packet and external review envelope must bind the exact artifacts before any repository-protocol theorem-card, proof, structural, or `lean_ready` gate may pass.
4. **AC4 - quorum.** The card requires two source-collation, two theorem-card, and two natural-language-proof reviewers, with required structural perspectives. This report supplies only one distinct reviewer ID.
5. **AC5 - preserve the boundary.** Acceptance remains declaration-free. Any LMLF wrapper, real-line facade, calculus/envelope theorem, Euler-Maclaurin result, Fourier/zeta use, or other extra target belongs in a separately reviewed later packet.
6. **AC6 - inventory truthfulness.** Until the proper external reconciliation/registration process occurs, the inventory must continue to make no manifest or theorem-occurrence coverage claim merely from this approval.

## Reproducible checks

- Visual render/read of private-PDF pages 292-297 (printed 279-284) with PyMuPDF from the bundled PDF runtime; all six page images were inspected.
- Independent SHA-256 verification of the private PDF, card, proof, transcription, upstream bindings, protocol/schema, inventory context, manifest/toolchain, and six pinned Mathlib source files.
- Exact declaration-source inspection from an archive of Mathlib commit `0df444a360eaa60ab8c11dca51a86af692955474`.
- `lake env lean ApiCheck.lean`: passed after compiling the declaration checks and regressions listed above. `ApiCheck.lean` was disposable and is not a candidate artifact.
- `python3 scripts/validate_inventory.py`: passed (`29 occurrences`, `31 notations`, `32 entities`, `34 entity evidence rows`, `88 occurrence associations`).
- `lake build`: passed (`2748 jobs`) on the isolated specification archive with the pinned dependency build products.

## Final conclusion

`DEF-BERN-002` revision 1 is mathematically faithful, source-identifying rather than theorem-covering, correctly scaled, endpoint-correct, non-circular, API-accurate at the exact pin, and appropriately declaration-free. I approve the exact card, proof, and source/reuse decision as one independent pre-signature approval, subject only to AC1-AC6 and the repository's external quorum/authorization process.

## Final SHA-256

Embedded payload SHA-256: `37cf8eb1868695e5d8cd352293beacc4653ba4a0950d447635653b0da5327b07`.

Checksum convention: this is SHA-256 of the exact UTF-8 report bytes from byte 0 through the newline immediately preceding the `## Final SHA-256` heading. The ordinary SHA-256 of the complete final file is necessarily external to the file it hashes and is supplied in the completion handoff.
