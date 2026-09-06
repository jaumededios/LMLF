# QB-001 clean-room natural-language mathematics re-review

- **Verdict:** APPROVE
- **Reviewer ID:** `qb_rereferee_a`
- **Model:** `gpt-5.6-sol`
- **Review stage:** `pre_lean`
- **Isolation:** `manual_fresh_context/read_only_exact_commit`
- **Isolation strength:** `manual_attestation`
- **Specification commit:** `073a5675ffaba33c5bec52de00d525165aa17ff4`
- **Repository:** `/home/codex/Documents/Codex/2026-09-05/yo`
- **Disposition:** No actionable mathematical, quantitative, signature, domain, fixed-target, convergence-scope, artifact-integrity, or authorization-scope findings.

## Review boundary and method

I reviewed Git objects at the exact specification commit, not working-tree files. I inspected only the committed versions of:

- `blueprint/proofs/QB-001.md`;
- `blueprint/theorem_cards/QB-001.yaml`;
- `blueprint/theorem_cards/QB-001-signatures.md`;
- `review/work_packets/QB-001.yaml`;
- `review/PROTOCOL.md`, `review/README.md`, and the relevant committed rubrics `quantitative_correctness.md`, `api_dependency.md`, `mathlib_reuse.md`, and `proof_quality.md`.

I did not inspect the content of any prior review. I recomputed the recorded prior-review artifact's SHA-256 from its committed blob solely to check the packet's digest binding; no review text was displayed or used as evidence. I made no repository edits.

The applicable protocol requires a pre-Lean referee to check every proof plan against its exact target, including quantifier order, fixed versus order-dependent data, domain transport, constants, and side conditions (`review/PROTOCOL.md:85-115`; `review/rubrics/quantitative_correctness.md:10-18,21-30,46-57`). It also requires exact target/signature bindings and strict prevention of extra hypotheses, smaller domains, changed quantifier order, or altered normalization (`review/PROTOCOL.md:217-238`; `review/rubrics/api_dependency.md:9-25,40-42`).

## Artifact-integrity check

All packet-recorded SHA-256 values match the bytes of the corresponding blob at the exact specification commit:

| Artifact | Packet location | Recorded SHA-256 | Recomputed SHA-256 | Result |
|---|---:|---|---|---|
| `blueprint/proofs/QB-001.md` source snapshot | `review/work_packets/QB-001.yaml:27-29` | `653b6fba9e597f56e63cf7520b0dbf896b1c3a4980436f2a8c065993aa26754c` | same | match |
| `blueprint/proofs/QB-001.md` NLP artifact | `review/work_packets/QB-001.yaml:45-49` | `653b6fba9e597f56e63cf7520b0dbf896b1c3a4980436f2a8c065993aa26754c` | same | match |
| `blueprint/theorem_cards/QB-001.yaml` | `review/work_packets/QB-001.yaml:35-40` | `ad68e05e764d9edcb51960fc00982192a4b964c37d5d342a4e8bb3ccf6f1587c` | same | match |
| `blueprint/theorem_cards/QB-001-signatures.md` | `review/work_packets/QB-001.yaml:41-44` | `1959a7787ddf31477321b75bec944938f6ac2f1d77c5c14702c33b3446684f12` | same | match |
| `blueprint/reviews/QB-001-rev3.md` (digest only; content not inspected) | `review/work_packets/QB-001.yaml:50-54` | `2fe44a08209a79c8e37b5d88a9d5aec95f975195d63d4e2b3a123bb0038be9a9` | same | match |

The work packet's own recomputed SHA-256 is `6448ab4c11964e2976dec98ef61d75e8d031cb76c17d3fef98f8e60b4cfae574`. Its omission from the packet is intentional rather than a missing binding: the packet says it contains no self path/commit/digest (`review/work_packets/QB-001.yaml:3-4`), consistently with the anti-self-reference protocol (`review/PROTOCOL.md:50-66`). This is the value an external envelope should use when binding this exact packet blob.

Artifact revisions are mutually consistent: theorem card revision 3 (`blueprint/theorem_cards/QB-001.yaml:5`), natural-language proof revision 3 (`blueprint/proofs/QB-001.md:4-6`), signature artifact revision 1 (`blueprint/theorem_cards/QB-001-signatures.md:3-6`), and the same revisions in the packet (`review/work_packets/QB-001.yaml:35-49`).

## Exact authorization and signature check

The signature artifact explicitly freezes imports, namespace, declaration order, binder order, implicit arguments, and conclusions and states that no ninth public declaration is in scope (`blueprint/theorem_cards/QB-001-signatures.md:8-10`). It contains exactly three definitions and five theorems (`blueprint/theorem_cards/QB-001-signatures.md:19-50`). The packet independently lists exactly eight targets, QB-001-T01 through QB-001-T08 (`review/work_packets/QB-001.yaml:56-253`), in the same order and namespace.

Expanding the signature artifact's namespace and section variables, the exact public declarations are:

```lean
def QuantitativeAnalysis.ErrorOn {X E : Type*} [NormedAddCommGroup E]
    (D : Set X) (f a : X → E) (b : X → ℝ) : Prop

def QuantitativeAnalysis.NormBoundOn {X E : Type*} [NormedAddCommGroup E]
    (D : Set X) (f : X → E) (b : X → ℝ) : Prop

def QuantitativeAnalysis.HasErrorFamily {X E : Type*} [NormedAddCommGroup E]
    (f : X → E) (a : ℕ → X → E)
    (D : ℕ → Set X) (b : ℕ → X → ℝ) : Prop

theorem QuantitativeAnalysis.ErrorOn.exact
    {X E : Type*} [NormedAddCommGroup E]
    {D : Set X} {f a : X → E} (h : Set.EqOn f a D) :
    ErrorOn D f a (fun _ => 0)

theorem QuantitativeAnalysis.ErrorOn.restrict
    {X E : Type*} [NormedAddCommGroup E]
    {D D' : Set X} {f a : X → E} {b : X → ℝ}
    (h : ErrorOn D f a b) (hD : D' ⊆ D) : ErrorOn D' f a b

theorem QuantitativeAnalysis.ErrorOn.weaken
    {X E : Type*} [NormedAddCommGroup E]
    {D : Set X} {f a : X → E} {b d : X → ℝ}
    (h : ErrorOn D f a b) (hbd : ∀ x ∈ D, b x ≤ d x) : ErrorOn D f a d

theorem QuantitativeAnalysis.ErrorOn.trans
    {X E : Type*} [NormedAddCommGroup E]
    {D : Set X} {f a c : X → E} {b d : X → ℝ}
    (hfa : ErrorOn D f a b) (hac : ErrorOn D a c d) :
    ErrorOn D f c (fun x => b x + d x)

theorem QuantitativeAnalysis.ErrorOn.comp
    {X Y E : Type*} [NormedAddCommGroup E]
    {D : Set X} {f a : X → E} {b : X → ℝ}
    (h : ErrorOn D f a b) {S : Set Y} (ψ : Y → X)
    (hψ : Set.MapsTo ψ S D) :
    ErrorOn S (f ∘ ψ) (a ∘ ψ) (b ∘ ψ)
```

These agree declaration-for-declaration and binder-for-binder with packet T01-T08 (`review/work_packets/QB-001.yaml:68-70,92-94,116-119,142-145,166-169,190-193,214-218,239-244`) and with the canonical code block (`blueprint/theorem_cards/QB-001-signatures.md:12-53`). The only presentational difference is that the signature artifact supplies `X`, `Y`, `E`, and the typeclass in an enclosing `variable` command and supplies the namespace lexically; unused `Y` is not an argument of declarations that do not mention it. No extra mathematical assumption is introduced.

All eight targets use the same and only ambient structural assumption, `[NormedAddCommGroup E]`, recorded by the packet as explicit input (`review/work_packets/QB-001.yaml:271-275`). No topology, continuity, measurability, decidability, nonemptiness, order convergence, scalar structure, source-function identity, branch, derivative, or exceptional-value assumption occurs. The source dossier makes precisely the same standing-assumption claim (`blueprint/proofs/QB-001.md:14-16,41-54`).

## Independent derivation of every authorized target

### QB-001-T01: `ErrorOn`

The declared body is

\[
  \forall x,\ x\in D \to \lVert f(x)-a(x)\rVert\le b(x).
\]

This is well-typed for arbitrary `X`, functions `f a : X → E`, real majorant `b : X → ℝ`, and `[NormedAddCommGroup E]`; subtraction and norm are available in `E`, while the comparison is in `ℝ`. The domain may be empty, in which case the proposition is correctly vacuous. It asserts nothing at points outside `D`. This exactly matches the dossier definition (`blueprint/proofs/QB-001.md:25-31,41`) and frozen body (`blueprint/theorem_cards/QB-001-signatures.md:19-20`).

### QB-001-T02: `NormBoundOn`

The declared body is

\[
  \forall x,\ x\in D \to \lVert f(x)\rVert\le b(x).
\]

The same typing and domain observations apply. No approximant is present, and no nonnegativity premise is needed to define the predicate. If it is inhabited at `x ∈ D`, norm nonnegativity and transitivity imply `0 ≤ b x`; nothing follows about `b` outside `D`. This matches `blueprint/proofs/QB-001.md:33-41,56-64` and `blueprint/theorem_cards/QB-001-signatures.md:22-23`.

### QB-001-T03: `HasErrorFamily`

Expanding both definitions gives the complete quantifier order

\[
  \forall n:\mathbb N,\ \forall x,\ x\in D_n \to
  \lVert f(x)-a_n(x)\rVert\le b_n(x).
\]

The target `f : X → E` is bound once outside `n` and is therefore fixed for every order. Exactly `a n`, `D n`, and `b n` depend on `n`. The signature contains no limit, filter, eventuality, summability, finite-sum constructor, monotonicity, or compatibility clause. This is exactly the explicit semantic warning in the dossier (`blueprint/proofs/QB-001.md:43-54`), theorem card (`blueprint/theorem_cards/QB-001.yaml:69-82`), packet (`review/work_packets/QB-001.yaml:116-129`), and frozen body (`blueprint/theorem_cards/QB-001-signatures.md:25-28`). Values at `n = 0` and every small order have the same supplied-predicate semantics; no special base case is silently imposed.

### QB-001-T04: `ErrorOn.exact`

Let `x ∈ D`. From `h : Set.EqOn f a D`, obtain `f x = a x`. Hence `f x - a x = 0`, so

\[
  \lVert f(x)-a(x)\rVert = \lVert 0\rVert = 0 \le 0.
\]

Thus `ErrorOn D f a (fun _ => 0)`. The proof uses exactly the stated `Set.EqOn` premise and norm-zero fact, and needs neither domain nonemptiness nor a separate majorant-sign assumption. This is only the forward exactness statement at `blueprint/proofs/QB-001.md:210-218`, justified at lines 282-284, and matches the frozen signature at `blueprint/theorem_cards/QB-001-signatures.md:32-33`.

### QB-001-T05: `ErrorOn.restrict`

Assume `h : ErrorOn D f a b` and `hD : D' ⊆ D`. For arbitrary `x ∈ D'`, `hD` gives `x ∈ D`; applying `h` gives `‖f x - a x‖ ≤ b x`. Universally quantifying over `x ∈ D'` proves `ErrorOn D' f a b`. Empty `D'` is handled vacuously; no reverse implication is claimed. This is exactly the proof at `blueprint/proofs/QB-001.md:66-92` and signature at `blueprint/theorem_cards/QB-001-signatures.md:35-37`.

### QB-001-T06: `ErrorOn.weaken`

For arbitrary `x ∈ D`, the two premises give

\[
  \lVert f(x)-a(x)\rVert\le b(x)
  \quad\text{and}\quad b(x)\le d(x).
\]

Transitivity of `≤` in `ℝ` yields `‖f x - a x‖ ≤ d x`. The majorant comparison is required on exactly the conclusion domain `D`, in the correct direction, with no global sign condition. This is `blueprint/proofs/QB-001.md:94-132` and `blueprint/theorem_cards/QB-001-signatures.md:39-41`.

### QB-001-T07: `ErrorOn.trans`

For arbitrary `x ∈ D`, the exact additive identity is

\[
  f(x)-c(x)=(f(x)-a(x))+(a(x)-c(x)).
\]

The triangle inequality followed by addition of the two premise inequalities gives

\[
\begin{aligned}
  \lVert f(x)-c(x)\rVert
  &\le \lVert f(x)-a(x)\rVert+\lVert a(x)-c(x)\rVert\\
  &\le b(x)+d(x).
\end{aligned}
\]

The intermediate function is the same `a` in both premises; both premises and the conclusion use exactly `D`; and the public majorant is exactly `fun x => b x + d x`, not a maximum, minimum, subtraction, or hidden constant. No independent nonnegativity premises are needed for the addition-of-inequalities step (and successful premise bounds already entail pointwise nonnegativity on `D`). This is the dossier derivation at `blueprint/proofs/QB-001.md:134-178` and frozen signature at `blueprint/theorem_cards/QB-001-signatures.md:43-45`.

### QB-001-T08: `ErrorOn.comp`

Let `y ∈ S`. `hψ : Set.MapsTo ψ S D` gives `ψ y ∈ D`. Applying `h` there yields

\[
  \lVert f(\psi(y))-a(\psi(y))\rVert\le b(\psi(y)),
\]

which is definitionally the desired inequality for `(f ∘ ψ)`, `(a ∘ ψ)`, and `(b ∘ ψ)` at `y`. No injectivity, surjectivity, continuity, differentiability, or converse is asserted. `S` may be empty. The domain map is explicit and in the correct direction. This is `blueprint/proofs/QB-001.md:326-355` and `blueprint/theorem_cards/QB-001-signatures.md:47-50`.

## Domain, fixedness, and quantitative audit

- All domains are ordinary `Set`s and may be empty; these are explicitly classified as reusable generic infrastructure, not completed concrete applications (`blueprint/theorem_cards/QB-001.yaml:78-82,124-132`; `review/work_packets/QB-001.yaml:73-75,97-99,123-125`). Hence there is no vacuous named/source result and no missing nonempty witness.
- `restrict` has the stated inclusion `D' ⊆ D`; `weaken` compares majorants on exactly `D`; `trans` uses a common `D`; and `comp` has the explicit sufficient forward transport premise `Set.MapsTo ψ S D`. No conclusion is silently moved to a smaller unrecorded domain.
- The only controlling quantitative expression introduced by an authorized lemma is the transitivity majorant `b x + d x`. It is derived by the exact cancellation identity and triangle inequality, has coefficient one on each premise bound, and matches the packet regression requirement (`review/work_packets/QB-001.yaml:383-388`).
- Signed real majorants are intentional. The predicates do not bundle nonnegativity, but any successful bound entails nonnegativity on its own domain (`blueprint/proofs/QB-001.md:56-64`; `blueprint/theorem_cards/QB-001.yaml:128-132`). None of the five authorized lemmas performs multiplication, division, integration, or another operation that would require an omitted sign condition.
- The fixed-target family semantics are unambiguous: `f` is outside the `∀ n`; only approximant, domain, and majorant vary with order. The specification repeatedly disclaims convergence or monotone improvement (`blueprint/proofs/QB-001.md:43-54`; `blueprint/theorem_cards/QB-001.yaml:74-77`; `review/work_packets/QB-001.yaml:120-123`).

## Excluded-dossier firewall

The dossier is intentionally broader than this bootstrap, but the normative boundary is redundant and exact:

1. The theorem card lists the only eight public declarations (`blueprint/theorem_cards/QB-001.yaml:36-44`) and explicitly excludes symmetry, congruence, zero/conversion equivalences, algebraic closure rules, minimum/product/bilinear/inverse/division estimates, and all `HasErrorFamily` wrappers (`blueprint/theorem_cards/QB-001.yaml:45-50`).
2. The theorem card makes only the standing assumptions, QB-001.1, QB-001.2, QB-001.3, forward exactness in QB-001.5, and QB-001.7 normative, and says every additional declaration requires a later card and manifest revision (`blueprint/theorem_cards/QB-001.yaml:51-55,98-111`).
3. The implementation authorization repeats that only the eight declarations in signature artifact revision 1 are allowed (`blueprint/theorem_cards/QB-001.yaml:164-170`).
4. The signature artifact states that no ninth public declaration is in scope and freezes declaration order and conclusions (`blueprint/theorem_cards/QB-001-signatures.md:8-10,56-62`).
5. The work packet scopes implementation to exactly the eight targets and explicitly excludes every other dossier result, named/source coverage, convergence, infinite sums, products, inverses, derivatives, and tactics (`review/work_packets/QB-001.yaml:390-399`). Its acceptance note repeats that authorization is limited to the eight frozen signatures (`review/work_packets/QB-001.yaml:418-422`).

Consequently, excluded dossier mathematics is explanatory/non-normative for this work item and cannot satisfy or enlarge any target. An implementation containing any extra public dossier declaration, convergence theorem/claim, wrapper, or algebraic estimate would violate the frozen target count and require a new specification revision; it must not be accepted under QB-001.

## Final finding set

No P0-P3 actionable findings. The eight authorized targets are mathematically valid under their exact stated assumptions; domains and quantifier order are correct; `HasErrorFamily` fixes the target and asserts no convergence; all bound expressions have explicit derivations; the exact signature/card/packet bindings agree; recorded artifact digests match the exact commit; and the excluded dossier material is expressly outside the implementation authorization.

**Final verdict: APPROVE.**
