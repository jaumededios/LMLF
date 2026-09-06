# Independent IMP-001 R6 exact-signature review

## Verdict record

- `verdict`: **approve**
- `review_stage`: `pre_lean`
- `review_perspectives`: `source_semantics`, `dependency_direction`, `source_to_target_reachability`, `hypothesis_and_choice_laundering`
- `scope`: exact-signature semantic and library-architecture design only
- `reviewer_id`: `imp_r6_signature_referee_a`
- `reviewer_kind`: `agent`
- `configured_model`: `gpt-5.6-sol`
- `configured_reasoning_effort`: `xhigh`
- `review_date_utc`: `2026-09-06`
- `isolation_strength`: `manual_attestation`
- `isolation_method`: fresh-context agent review in the detached worktree `/tmp/lmlf-imp-r6-sig-ref-a.wAmi8yzk`, with an independently created disposable harness at `/tmp/lmlf-imp-r6-sig-ref-a-harness.pAAT0kDv`
- `runtime`: Codex desktop agent on Linux `5.15.0-190-generic` x86_64; Lean `4.33.1` (`819816b2e0a3bf405af45ae5c7af2491d8f5bee6`); Lake `5.0.0-src+819816b`

This is a manual fresh-context attestation, not hardened or technically enforced isolation. The host filesystem and tools were available normally. I did not open or read any prior or peer referee report, evidence report, process listing, or agent message containing another review. References to prior reports occurring inside the mandatory proposal text were treated as untrusted author claims and were not used as evidence. I did not spawn a subagent.

## Exact binding

The reviewed candidate was a clean detached checkout:

- commit: `8af103fee3b2000033fc1e8c684645e529aaa841`
- primary artifact: `blueprint/theorem_cards/IMP-001-signatures-R6.md`
- primary artifact SHA-256: `4b2b6f73a8a92c6b48e88e6ca7b3c1d252ed877f4df33257306c10cbab679ab0`
- primary artifact length: 971 lines

Relevant unchanged card/proof inputs were independently read in full and rehashed:

| Input | Revision | Lines | SHA-256 |
|---|---:|---:|---|
| `blueprint/theorem_cards/IMP-001.yaml` | 6 | 444 | `97e7af6b5d1919b45fef90dfea5cb86b1f041d26c447c51852271ad04fdd75a0` |
| `blueprint/proofs/IMP-001.md` | 6 | 1302 | `88f60d501c4261cba37b5d1f320406c258bde785ed3912720b3be897d6424f0e` |
| `blueprint/theorem_cards/QL-001.yaml` | 4 | 250 | `176dd5661eca3ef6c348a1557cf121e46921131c279a7f64846f78a8eef399e0` |
| `blueprint/proofs/QL-001.md` | 4 | 668 | `0e10900131fce62f2ed0256d4c0844ff6fb8b7a570fa25cf4ac4a05c33ea7116` |
| `blueprint/theorem_cards/OLV-001.yaml` | 4 | 244 | `442004db665f0f4eb20f7bac5708a50dc377566356841c2be2f0389d75a4bf1b` |
| `blueprint/proofs/OLV-001.md` | 4 | 596 | `40e31aab68f1f065598ea3b7ea5a46616bb84f2ab44b1ca49632be523ed9ff0f` |

Tool/dependency binding:

- `lean-toolchain`: `leanprover/lean4:v4.33.1`
- resolved local Mathlib commit: `0df444a360eaa60ab8c11dca51a86af692955474`
- `lake-manifest.json` SHA-256: `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`

The main candidate stayed clean throughout. No `review/work_packets/IMP-001.yaml` exists, the R6 card still says `exact_signatures_artifact: absent...` and `signature_authorization: absent`, and no proposed IMP declaration occurs in production `LMLF/*.lean` sources.

## Findings

No actionable `P0`, `P1`, `P2`, or `P3` finding was identified in the reviewed exact-signature semantic/architecture design.

The verdict is deliberately narrow. It does not approve theorem proofs, a final theorem card, a work packet, registry or manifest admission, `lean_ready`, production imports, production Lean, source/PDF fidelity, or source coverage. Six targets are axioms in the harness, so compilation cannot establish their mathematics.

## Semantic and exact-signature audit

### T01 private representation

The two private definitions faithfully encode the card's ordinary independent one-sided convergence.

- `S.sort (· ≤ ·)` canonically enumerates the duplicate-free finite set increasingly. The public conjunct `∀ c ∈ S, k < c`, together with sorted distinct entries, supplies the strict component order used by the private recursion.
- With `S = ∅`, the definition requires `IntervalIntegrable f volume k b` for every `b ≥ k` and the ordinary atTop limit of `∫ k..b`; it does not infer meaning from a totalized integral alone.
- With a first exception `c`, the first component requires honest integrability on every `[k,b]` with `b<c` and a left limit at `c`. Requiring intervals from `k` is equivalent to compact regular integrability within that component by restriction and intentionally enforces the stronger, honest local contract at the initial endpoint.
- A bounded recursive component from `c` to the next exception `d` has a private anchor `p` with `c<p<d`, honest integrability on every `c<a≤b<d`, a right-sided limit at `c`, and a left-sided limit at `d`. These limits are independent; no shared cutoff can create principal-value cancellation.
- The final component has an anchor strictly above its finite endpoint, a right-sided limit there, and a separate atTop limit. Its integrability clause covers every compact subinterval of the open final component.
- The recursive equalities add precisely the first component, each bounded component's two one-sided contributions, and the final component. Anchor changes only add and subtract the same honest compact integral, so the existential anchors add no chosen public value or mathematical assumption.
- Values at `k` and the finite exceptional points are null-set irrelevant, while behavior approaching them is not ignored. A finite exceptional point may support conditional convergence on each side; a merely conditionally improper non-`L1` singularity at the initial `k` is intentionally excluded.

Thus the representation is neither principal value nor a coupled-limit encoding, and it does not launder nonintegrable finite intervals through Mathlib totalization.

### T05 and T08 coherence

`IsFiniteExceptionalPrimitive g k S F` contains exactly: exceptions above `k`, `ContinuousOn F (Ici k)`, `F k = 0`, and, on every closed regular interval, both `IntervalIntegrable` and the increment identity. It contains no atTop convergence, flat bound, exponential parameter, or target value.

The T01/T05 equivalence in T08 is semantically exact:

- T01's independent component limits construct a cumulative primitive continuous from both sides at every exception; on the final component its finite telescope tends to `I`.
- Conversely, T05 continuity supplies the independent endpoint limits, its increment law supplies all honest compact integrals, and `Tendsto F atTop (nhds I)` supplies the final endpoint; the component values telescope to `I-F k=I`.
- The right side is `∃ F`, not a claim about an arbitrary preselected `F`. No public `choose`-defined primitive or improper-value function is introduced, and the witness remains unconstrained below `k`.

### Eight public signatures

| Target | Result of exact quantifier/value review |
|---|---|
| T01 | Correct binder order `f, k, S, I` under complete real normed `E`; the public value is relational and the exception-domain condition is inside the predicate. |
| T02 | Compares two explicit values for identical `f,k,S`; concludes only `I=J` and selects no value. |
| T03 | Quantifies complete input/value space `E` and distinct complete output space `H`; each `T i : E →L[ℝ] H`; the exception set is literally `s.biUnion S`, and integrand/value use the same finite mapped sum. |
| T04 | Requires `a≤k`, the same literal `S` strictly above `k`, and honest `IntervalIntegrable f volume a k`; its value is exactly `(∫ a..k, f) + I` with the correct orientation. |
| T05 | Exact primitive data described above; no hidden limit or bound. |
| T06 | Accepts arbitrary real `h` and arbitrary finite `S` through T05; separately requires honest `IntegrableOn` for the weighted primitive and boundary vanishing; concludes on the same `S` at exactly `h • ∫_(Ioi k) exp(-h*t) • F t`. |
| T07 | Accepts arbitrary finite `S` above `k`; explicit `IntegrableOn f (Ioi k)` makes the set-integral value honest. It neither infers integrability from that totalized expression nor claims a converse. |
| T08 | Exact existential primitive equivalence; no fixed witness, bound, or selected value. |

T06 is the correct integration-by-parts/Abel identity: for `w(t)=exp(-h*t)`, the private finite-piece relation is `∫ w g = w(b)F(b)-w(a)F(a)+h∫wF`. The proposed transformed primitive `wF+h∫_k^t wF` has the T05 increment law and the explicit two tail premises give its stated atTop value. This remains valid for arbitrary `h` when those premises hold, including `h=0`; no division by `h` occurs.

## Architecture and downstream reachability

The module split is coherent and acyclic:

```text
Mathlib -> Improper.Basic -> {Improper.Bochner, Improper.Abel} -> QL -> OLV
```

`Basic` owns T01/T05/T08 and their core laws T02--T04. `Bochner` owns only the absolute-integrability bridge T07. `Abel` owns only T06 and does not import `Bochner`. No proposed IMP module imports QL, OLV, Watson, Gamma, source, audit, QB, DEF, or an LMLF umbrella. The sorted representation, anchors, component recursion, finite-piece Abel identity, and value construction remain private.

The complete QL/OLV inputs support the intended chain: baseline T01 relation; T07 for independently proved absolutely integrable model moments; heterogeneous T03 subtraction on the literal union; honest T04 prefix removal; existential T08 primitive extraction; a flat bound derived downstream from continuity plus finite atTop convergence; T06 at the target weight; T04 prepend; and T07/T03 model recombination. This route neither assumes the selected primitive nor imports a downstream result into IMP.

The regression's direct imports of
`Mathlib.Analysis.SpecialFunctions.ImproperIntegrals`,
`Mathlib.Analysis.SpecificLimits.Normed`, and
`Mathlib.Order.Filter.AtTopBot.Field` merely make pinned lemmas available to prove T06's already explicit side conditions from `h>0` and a separate flat bound. They add no mathematical hypothesis, object, or conclusion. Therefore the coherent meaning of “public IMP only” is “no private or downstream LMLF helper”, while separately listed direct pinned Mathlib support remains permitted. This clarification is mathematically conservative, but it must be stated explicitly in the eventual final card/work packet; this approval does not itself freeze that later obligation.

## Reproduction and tool evidence

I created a new directory, `/tmp/lmlf-imp-r6-sig-ref-a-harness.pAAT0kDv`, and added the five authoritative sources with `apply_patch`. I did not use the author's disposable directory. Reconstructed bytes were:

| Source | Lines | SHA-256 |
|---|---:|---|
| `LMLF/Integral/Improper/Basic.lean` | 106 | `9a88b646c652126230941c3bc5a033b47a6e514a25a5a37df43439d6a3745c8c` |
| `LMLF/Integral/Improper/Bochner.lean` | 20 | `33fd45c29a3ea0ec32638c01f7d098a633280c54f34d5b4843721e42020e4cd3` |
| `LMLF/Integral/Improper/Abel.lean` | 28 | `c96c1f97e0e123fea038dc3748b0164a6f911e8af863d9cde49c278b9457ab53` |
| `Check.lean` | 11 | `b1aa6e50c08a33509a9e60fa9d2ce583fbb4a88126428cd7dc56c214929b1e5d` |
| `Regressions.lean` | 304 | `b016c4b894597605029a99350ca41d33f3e692c1c38782622848c08ce2d53dc4` |

All five hashes and line counts exactly match the proposal. Four `diff -u` comparisons also returned exit 0, confirming that the earlier private-definition, Basic-public, Bochner-public, and Abel-public excerpts agree byte-for-byte with the corresponding portions of the authoritative full blocks.

Compilation used the cached dependency path returned by the main repository's `lake env printenv LEAN_PATH`, prepended the independent harness, and invoked the pinned executable:

```bash
env LEAN_PATH="$HARNESS_ROOT:$(lake env printenv LEAN_PATH)" \
  /home/codex/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean \
  -R "$HARNESS_ROOT" ...
```

Results, in required order:

1. `Basic.lean` -> `.olean`: exit 0.
2. `Bochner.lean` -> `.olean`: exit 0.
3. `Abel.lean` -> `.olean`: exit 0.
4. `Check.lean`: exit 0 and printed all eight exact declarations with the advertised `CompleteSpace`, `E→H`, `biUnion`, local-split, weighted-value, `IntegrableOn`, and existential-`F` types.
5. `Regressions.lean`: exit 0. Diagnostics were style-only unused-variable/unused-section-variable and unnecessary-`simpa` linter warnings at the disclosed locations; there was no elaboration error.

A source scan found exactly the six deliberate temporary theorem `axiom` declarations T02/T03/T04/T06/T07/T08 and no `sorry`, `admit`, or `unsafe` declaration. T01 and T05 have definition bodies. The source-shaped consumer, arbitrary-`S` T06 use, arbitrary-`S` T07 use, heterogeneous T03 use, T04/T08 extraction, and flat-bound lemma have real proof bodies, but all remain conditional on those six axioms. They establish type reachability, not the target mathematics. The two `fail_if_success` checks establish only missing-argument/existential type shape; they are not mathematical counterexamples.

The pinned Mathlib checkout itself was clean at `0df444a360eaa60ab8c11dca51a86af692955474`. Local source inspection confirmed the cited root/namespace placements and exact roles of the interval-integrability conversion, CLM/interval-integral commutation, primitive-continuity, Ioi improper-limit, finite-product/Fubini, FTC, and exponential-integrability declarations used by the architecture. No online source or GitHub workflow was used.

The required library inventory script reported the candidate snapshot at the exact detached head, seven maintained Lean files/210 lines, the existing foundation-to-results import edges, and no trust/resource marker. This was inventory context only, not proof evidence.

## Global library-rubric disposition

1. **Mathematical intent:** clear; the private representation and all eight public types implement the written ordinary-improper/primitive/Abel plan.
2. **Reusable seams:** clear; T08, T03, T04, T06, and T07 correspond to real QL/OLV consumers, while representation plumbing remains private.
3. **Public API:** clear; exact binders, orientations, values, existential placement, and literal union are coherent.
4. **Module/dependency design:** clear; imports flow upward without a cycle or umbrella dependency.
5. **Mathlib integration:** clear at signature-design scope; canonical Bochner interval/set integrals and pinned calculus results are reused. Proof-body import sufficiency/minimality remains an implementation-stage check.
6. **Proof architecture:** clear as a design; T08 owns component stitching, T06 owns Abel composition, and consumers do not unfold T01. The axiomatic harness proves no theorem body.
7. **Cost/durability:** no unsupported performance conclusion; the proposed surfaces are narrow and isolate likely Mathlib-sensitive plumbing.
8. **Refactor risk:** clear; no compatibility alias or obsolete six-target surface is retained. Changing a public signature or semantics requires fresh review.

Explicit do-not-refactor decisions for this interface are to keep sorted-component/anchor plumbing private, keep `Bochner` and `Abel` independent above `Basic`, retain heterogeneous T03 rather than specialize it to `E→E`, keep the flat bound outside T05/T08, and retain T07's explicit `IntegrableOn` premise. No local-proof handoff is appropriate before implementation authorization.

## Scope limitations and remaining obligations

- No final work packet or external envelope binds this proposal, and no final card binds its digest.
- `lean_ready` and production implementation authorization remain absent.
- The six theorem targets remain mathematically unproved in this review; production must replace every harness axiom with an axiom-compliant theorem body and recheck proof imports, regressions, and `#print axioms`.
- This source-independent review makes no PDF-fidelity, source-collation, named-function, QL theorem, OLV theorem, or source-coverage determination.
- The final card/work packet must explicitly preserve the direct-Mathlib-import clarification above and bind the exact accepted signature artifact; doing so adds no mathematical assumption.

Within that bounded scope, the exact signature proposal at commit `8af103fee3b2000033fc1e8c684645e529aaa841` is approved.
