# QB-001 independent final referee report D

## Outcome

- **Theorem-card verdict:** `approve` for frozen theorem card revision 5.
- **Natural-language-proof verdict:** `approve` for the card's normative subset of frozen proof revision 4.
- **Structural-circularity classification:** confirm `not_applicable`; an external envelope may record this gate as `not_required` with the frozen packet's reason.
- **Lean elaboration verdict:** all 3 definitions and 5 lemmas elaborate with the exact frozen signatures, import, namespace, and declaration count on the pinned toolchain. Diagnostics are clean. Every axiom report is exactly the packet allowlist.
- **Actionable findings:** none (`P0`–`P3`); no `G-HANDOFF`.
- **External `lean_ready`:** not set here. This review finds the mathematical, binding, dependency, and structural prerequisites sound, but this report is one reviewer record. The packet requires two distinct reviewer IDs overall and two for each required pre-Lean gate. A merger must bind this report and at least one other qualifying independent verdict in an external envelope, record structural review as `not_required`, verify reviewer composition, and only then decide `lean_ready`.

## Review identity and isolation

- Reviewer ID: `qb_final_referee_d`
- Reviewer kind: `agent`
- Model: OpenAI Codex, GPT-5 family (the exact serving/deployment identifier was not exposed to this session)
- Issued UTC: `2026-09-05T17:33:06Z`
- Host runtime: `Linux 5.15.0-190-generic x86_64`; Git `2.39.5`; Lake `5.0.0-src+819816b`
- Isolation strength: `manual_attestation`
- Isolation method: a fresh agent context and two disposable trees made with `git archive` from the exact specification commit. Artifact inspection used `/tmp/qb_final_referee_d.DGUHEX`; Lean reconstruction and tests used the independently re-created `/tmp/qb_final_referee_d_run.Me1pXv`. I did not inspect `blueprint/reviews/QB-001-rev3.md`, any earlier referee report, any other agent output, or any dirty-worktree prototype. The repository was not edited. All generated Lean files and build outputs were confined to the disposable archive.
- Dependency-store limitation: the validation archive symlinked the existing `.lake/packages` store to avoid fetching. This is not technically enforced isolation. Before use, the Mathlib checkout HEAD was independently verified as the packet's exact resolved commit.
- One abandoned setup probe in the first archive invoked `lake env lean --version` before the dependency symlink existed and began a Mathlib clone. I abandoned that environment and re-created the validation archive from `git archive`; no result from the partial clone was used.

The proof-referee skill and its complete local rubric and LSP playbook were read before review. No Lean LSP interface was exposed in this session, so deterministic `lake env lean`, `lake build`, source scanning, printed elaborated declarations, and `#print axioms` supplied the Lean evidence.

## Exact specification binding

- Specification repository: `/home/codex/Documents/Codex/2026-09-05/yo`
- Requested and resolved specification commit: `f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de`
- Packet lifecycle: revision `2`, `frozen`
- Card lifecycle: artifact revision `5`, `frozen`
- Signatures artifact: revision `2`, `frozen`
- Natural-language proof: revision `4`, `frozen`

| Artifact | Packet-recorded SHA-256 | Independently computed SHA-256 | Result |
|---|---|---|---|
| `review/work_packets/QB-001.yaml` | externally bound (packet deliberately has no self-digest) | `fb4942e10968e9bb53badb9352e668bd5460d6c482c27ea678cc72175ea9a86a` | exact external binding value |
| `blueprint/theorem_cards/QB-001.yaml` (`TC-QB-001-R5`) | `de0ed8cae076e7dfe074b4eacc0e5a8875e245c1ddedf8230851bbfd920f0ce4` | `de0ed8cae076e7dfe074b4eacc0e5a8875e245c1ddedf8230851bbfd920f0ce4` | match |
| `blueprint/theorem_cards/QB-001-signatures.md` (`SIG-QB-001-R2`) | `93e4e30a93087de95342abdb1e986676924cd93512e771737d0d3f3ed7973b39` | `93e4e30a93087de95342abdb1e986676924cd93512e771737d0d3f3ed7973b39` | match |
| `blueprint/proofs/QB-001.md` (`NLP-QB-001-R4`) | `3513fb1acf141066eb9a4920c1ea238c778d66976ff8479d31c742df93d3a2a5` | `3513fb1acf141066eb9a4920c1ea238c778d66976ff8479d31c742df93d3a2a5` | match |
| `review/classifications-v2.json` | `698626606570827fcc8c78b69865d7cd4bc94de96bc6d5d45c23a5f6611aeeab` | `698626606570827fcc8c78b69865d7cd4bc94de96bc6d5d45c23a5f6611aeeab` | match |

Supporting frozen-file digests: `LMLF/Basic.lean` = `3ceac6d68d0e3dac83238b3a6d8c7e826fff35b2d19ebf70556ff86d7ad1b38a`; `lean-toolchain` = `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71`; `lake-manifest.json` = `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`; `lakefile.toml` = `c7bb53018e97237f83c740be3e0e42cb9d848097fe20b894cef4e69ba145962b`; `review/PROTOCOL.md` = `a0260b13d2e41398eb1e14e74f4f05ffb5b16f3ef46b6de2a7696817a2faa99c`.

The packet's revision IDs, paths, digests, classification schema version (`lmlf-classification-v2`), Lean pin, and Mathlib pin agree with the archived bytes. The packet correctly leaves its own commit/path/digest to the external envelope, avoiding self-reference. The historical non-quorum artifact was deliberately not read or used.

## Toolchain and import boundary

- Frozen Lean toolchain: `leanprover/lean4:v4.33.1`
- Observed compiler: `Lean 4.33.1`, commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`
- Frozen/resolved Mathlib revision: `0df444a360eaa60ab8c11dca51a86af692955474`
- Observed Mathlib checkout HEAD: `0df444a360eaa60ab8c11dca51a86af692955474`
- Reconstructed implementation import: exactly `import LMLF.Basic`
- `LMLF.Basic` itself imports `Mathlib.Analysis.Normed.Group.Basic` and contains no project declaration.

The exact-signature reconstruction has SHA-256 `d44c356bea4954179f56945f25c3e7be1f06ee571ff30ed6dd4b14182c4480d6` and 55 lines. This is disposable referee evidence, not a repository implementation.

## Independent mathematical re-derivation

### Definitions

1. `ErrorOn D f a b` is exactly `∀ x ∈ D, ‖f x - a x‖ ≤ b x`. Empty `D` is vacuous; no statement is made outside `D`.
2. `NormBoundOn D f b` is exactly `∀ x ∈ D, ‖f x‖ ≤ b x`. Again, no nonemptiness or global sign premise is needed.
3. `HasErrorFamily f a D b` is exactly `∀ n, ErrorOn (D n) f (a n) (b n)`. Only `a`, `D`, and `b` vary with `n`; `f` is fixed. There is no cross-index condition.

### Five lemmas

1. `ErrorOn.exact`: for `x ∈ D`, `Set.EqOn` gives `f x = a x`, hence `f x - a x = 0`, so its norm is `0 ≤ 0`.
2. `ErrorOn.restrict`: for `x ∈ D'`, `hD : D' ⊆ D` supplies `x ∈ D`, after which the original pointwise estimate applies. The direction cannot be reversed.
3. `ErrorOn.weaken`: at `x ∈ D`, concatenate `‖f x-a x‖ ≤ b x` with `b x ≤ d x`. The required orientation is exactly `b ≤ d` on `D`.
4. `ErrorOn.trans`: use the exact additive identity `f x-c x = (f x-a x)+(a x-c x)`, then `norm_add_le`, then `add_le_add` on the two premises. The result is exactly `b x + d x`, with both bounds used at the same point and on the same domain.
5. `ErrorOn.comp`: for `y ∈ S`, `hψ : Set.MapsTo ψ S D` gives `ψ y ∈ D`. Apply `h` at `ψ y` and unfold the three compositions. No injectivity, surjectivity, regularity, or postcomposition property is used.

These proofs reach the frozen conclusions directly and do not assume any target conclusion, named-function identity, existence theorem, continuation principle, or hidden choice.

## Adversarial edge checks

The disposable `QB001Adversarial.lean` (SHA-256 `cdc0e06ae39c11fe5f785ec685d9bf43605a30611e64440685b95414d4e8eff1`) compiled with no diagnostics and checked all of the following:

- `ErrorOn ∅ f a b` for completely arbitrary `f`, `a`, and signed `b`.
- Exact zero error on an arbitrary, possibly empty, `D`.
- A countermodel to reverse restriction: with a nonzero `z`, the zero bound holds vacuously on `∅` but fails on `Set.univ`.
- A countermodel to reversed weakening: the constant error `z` is bounded by `‖z‖` but not by `0` when `0 < ‖z‖`.
- A type-exact application of transitivity whose conclusion is syntactically `fun x => b x + d x`.
- Generic precomposition with the stated `Set.MapsTo` premise.
- A countermodel showing that `MapsTo` is substantive: a Boolean map sends the sole source point outside `{false}`, where the original zero bound supplies no control, and the pulled-back zero bound fails.
- A genuine no-convergence countermodel: on `Unit`, fix target `0`, every approximant equal to a nonzero `z`, every domain `Set.univ`, and every majorant `‖z‖`. `HasErrorFamily` holds for every order, while Lean proves `¬ Filter.Tendsto (fun _ : ℕ => z) Filter.atTop (nhds 0)` via `tendsto_const_nhds_iff`. Thus neither convergence nor shrinking bounds are latent in the definition.

This covers empty and arbitrary domains, inequality direction, exact additive majorant, required domain mapping, and the deliberately weak order-family semantics.

## Assumptions actually used

The frozen common assumption `[NormedAddCommGroup E]` is sufficient, coherent, and the only typeclass input in the exact public declarations. No continuity, measurability, decidable membership, domain nonemptiness, majorant nonnegativity, completeness, scalar action, or topology hypothesis is smuggled into the signatures.

The disposable `QB001Assumptions.lean` (SHA-256 `9525a497bab86adc41308be80ebb5abf14948d1a6bced3846f1f59d12555e631`) also compiled and separates proof-theoretic minima from the intentionally frozen API:

- the raw `ErrorOn` formula needs only subtraction and a real-valued norm;
- the raw `NormBoundOn` formula needs only a real-valued norm;
- `restrict`, `weaken`, and `comp` remain valid under those raw operations;
- `exact` and `trans` compile under `SeminormedAddCommGroup E`; norm definiteness is not used by these two forward lemmas.

Therefore `NormedAddCommGroup` is stronger than the mathematical minimum for this bounded eight-declaration slice, but it is explicit rather than hidden, matches the card and signatures exactly, and is a reasonable frozen uniform foundation for the larger dossier. Weakening it would be an API/specification redesign, not a correction needed for this packet; I recommend no change in this proof-only review.

## Namespace, public surface, and classifications

- Namespace: exactly `QuantitativeAnalysis`, with theorem namespace `QuantitativeAnalysis.ErrorOn`.
- Public declaration order and count: exactly eight—`ErrorOn`, `NormBoundOn`, `HasErrorFamily`, `ErrorOn.exact`, `ErrorOn.restrict`, `ErrorOn.weaken`, `ErrorOn.trans`, `ErrorOn.comp`.
- No unused global `Y` leaks into declarations other than `ErrorOn.comp`; printed universes and implicit binders confirm this.
- Binder order, implicitness, domains, codomains, and conclusions printed by Lean match signature artifact revision 2.
- No ninth public declaration is implied. Proof-dossier material outside “Scope and standing assumptions,” QB-001.1–.3, forward exactness in .5, and QB-001.7 is explicitly non-normative for this bootstrap. Although the wider dossier proposes later API names, the card and packet unambiguously exclude them here.
- Packet classification `foundational_calculus` / `infrastructure` / `non_novel` and all target classifications are legal v2 values and accurately describe routine reusable infrastructure. No value claims external source coverage.
- `named_objects: []`, source kind `original`, and coverage claim `none` agree with the mathematics.

## Diagnostics, trust, and axioms

The deterministic preflight found eight declarations, no `sorry`, `admit`, `axiom`, `unsafe`, `maxHeartbeats`, or `maxRecDepth` marker, and no compiler warning or error after `LMLF.Basic` was built. `lake build` completed successfully (`1325` jobs in the disposable archive).

Lean's `#print axioms` result for each of the eight declarations was identical:

```text
[propext, Classical.choice, Quot.sound]
```

This is exactly the packet's allowed-axiom list. The definitions' reports include imported typeclass foundations, not any candidate-added axiom. No custom trust extension is present.

## Referee-skill rubric disposition

- Correctness/trust: clear.
- Mathematical skeleton: clear and direct for all five lemmas.
- Theorem reuse: canonical `Set.EqOn`, `Set.MapsTo`, `norm_add_le`, real-order transitivity, and `add_le_add` suffice.
- Tactic robustness and goal hygiene: verified reconstruction uses rigid introductions, explicit domain transport, a three-line `calc` for transitivity, and composition normalization only.
- Casts/coercions: none of concern.
- Performance: no slowness observed; no profiling or resource overrides warranted.
- Presentation/public API: exact frozen order, names, namespaces, imports, and statements.
- Findings: none. No local replacement is required.

## Pre-Lean gate assessment

### Theorem card revision 5

`approve`. Quantifiers, fixed versus indexed objects, domain conventions, majorant orientation, exact zero statement, `b+d`, `MapsTo`, dependencies, classifications, exact Lean signatures, scope exclusions, and no-convergence caveat are correct and mutually consistent. Empty domains are intentionally allowed and cause no false positive source claim.

### Natural-language proof revision 4

`approve` for the normative subset selected by the card. Each of the five target proof plans reaches its conclusion by the stated elementary identity/order/set argument. The transitivity proof has the correct intermediate function and additive majorant. The precomposition proof uses precisely the domain-mapping premise. The exactness review is forward-only as required. Non-normative later sections do not enlarge the packet.

### Structural circularity

Confirm packet classification `applicability: not_applicable`. The packet defines transparent predicates and proves direct transports. It does not identify or construct a named object, invoke existence/uniqueness or continuation, recover a source theorem through a bridge, expose a structure capable of containing the target conclusion, or make a choice. `Set.EqOn` in `ErrorOn.exact` is an explicit elementary premise, not a packaged copy of the desired bound. The frozen reason is concrete and adequate, so the external gate representation should be `not_required`, not absent.

### External `lean_ready` prerequisites

Substantively supported by this audit:

- exact frozen packet and upstream artifacts are digest-bindable;
- required card and proof reviews receive `approve` from this reviewer;
- structural inapplicability is justified;
- pinned Lean and Mathlib dependencies exist and compile;
- no `request_changes` or `block` verdict arises here.

Not established by this report alone:

- a filled immutable external review envelope;
- a second distinct durable reviewer ID for each required card/proof gate;
- the packet's overall two-reviewer union and selected allowed composition;
- external recording of structural `not_required`;
- the merger's composite authorization decision.

Accordingly, this report can support, but does not itself set or fully establish, an external `lean_ready: pass` decision.

## Reproduction commands

The material commands were run exactly as follows (paths shown literally; generated files contained the exact declarations/proofs and probes described above):

```bash
cd /home/codex/Documents/Codex/2026-09-05/yo
git rev-parse f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de^{commit}
d=$(mktemp -d /tmp/qb_final_referee_d.XXXXXX)
git archive f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de | tar -x -C "$d"

d=$(mktemp -d /tmp/qb_final_referee_d_run.XXXXXX)
git archive f6e88abf5c249681d1d1e9e55f1639ba2cc8b3de | tar -x -C "$d"
mkdir -p "$d/.lake"
ln -s /home/codex/Documents/Codex/2026-09-05/yo/.lake/packages "$d/.lake/packages"
mkdir -p "$d/LMLF/Quantitative"

cd /tmp/qb_final_referee_d_run.Me1pXv
git -C .lake/packages/mathlib rev-parse HEAD
lake env lean --version
sha256sum review/work_packets/QB-001.yaml blueprint/theorem_cards/QB-001.yaml blueprint/theorem_cards/QB-001-signatures.md blueprint/proofs/QB-001.md review/classifications-v2.json LMLF/Basic.lean lean-toolchain lake-manifest.json lakefile.toml
lake build LMLF.Basic
bash /home/codex/.codex/skills/referee-lean-proof/scripts/check_lean_file.sh LMLF/Quantitative/Basic.lean
lake build LMLF.Quantitative.Basic
lake env lean QB001Inspect.lean
lake env lean QB001Adversarial.lean
lake env lean QB001Assumptions.lean
lake env lean LMLF/Quantitative/Basic.lean
lake build
sha256sum LMLF/Quantitative/Basic.lean QB001Adversarial.lean QB001Assumptions.lean QB001Inspect.lean
rg -n '^(import|namespace|end |def |theorem )' LMLF/Quantitative/Basic.lean
```

`QB001Inspect.lean` printed all eight elaborated declarations and all eight axiom reports. `QB001Adversarial.lean` and `QB001Assumptions.lean` were referee-only, disposable probes and did not modify the repository.

## Report integrity

- Canonical report-body SHA-256: `7c6c36c1a608e8a85619c01cc67505e446d6010400f4596242acd24bb4702e80`
- Hash rule: run `sed '/^## Report integrity$/,$d' qb_final_referee_d.md | sha256sum`. This hashes every UTF-8 byte before this section and avoids a self-referential embedded digest.
