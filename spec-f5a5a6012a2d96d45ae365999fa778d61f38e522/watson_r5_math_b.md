# Independent pre-Lean mathematical/API review: Watson R5 referee B

## Review identity and scope

- Reviewer ID: `watson_r5_math_b`
- Reviewer kind: agent
- Model: `gpt-5.6-sol`, reasoning effort `xhigh` (configuration reported by the spawning orchestrator; no backend build ID was exposed)
- Runtime: Codex desktop agent on Linux `5.15.0-190-generic` x86_64; Lean `4.33.1`, compiler commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`
- Review stage: pre-Lean, before exact-signature design
- Candidate/specification commit reviewed: `f5a5a6012a2d96d45ae365999fa778d61f38e522`
- Mathlib pin: `0df444a360eaa60ab8c11dca51a86af692955474`
- Isolation strength: `manual_attestation`

I attest that I began from a fresh agent context with `fork_turns none`, did not reuse a previous verdict, did not inspect any peer report, other agent output, or history diff, did not list agents, did not spawn a subagent, and did not edit the candidate. Before isolation, the candidate worktree was clean and its `HEAD` was the full commit above. I created `/tmp/lmlf-watson-r5-math-b.Z7HqBH` by streaming `git archive f5a5a6012a2d96d45ae365999fa778d61f38e522` into a new `mktemp -d` directory, made the extracted tree read-only with `chmod -R a-w`, and read candidate artifacts only from that snapshot. The ignored dependency checkout was necessarily read separately at `/workspace/Documents/Codex/2026-09-05/yo/.lake/packages/mathlib`; its clean `HEAD` was independently checked to be the stated pin.

This is a manual isolation attestation, not a claim of a technically enforced clean-room runner.

## Primary byte bindings

| Artifact | SHA-256 |
|---|---|
| `blueprint/proofs/IMP-001.md` | `3c45e55fb76bc03ddfb6fe772fd20e33ddefcaad3ed3f07a5f3523ceb93f483f` |
| `blueprint/theorem_cards/IMP-001.yaml` | `b5ca9b3c818237b243cabf2328b7d51c4a292366928873767de0e6584de5ef62` |
| `blueprint/proofs/QL-001.md` | `e231233ae07d19702d5260b66e5ded9854477fb7e1a5dc188ecfc887c681019e` |
| `blueprint/theorem_cards/QL-001.yaml` | `538591bc51ac66e38eab1a9299fae1154bd40f1ce657a6a9a1f9f4b6af1de488` |
| `blueprint/proofs/OLV-001.md` | `1b183323439cd06f4d049fd85594e02a5d4bb0e1d0103bc25e011ed100498db4` |
| `blueprint/theorem_cards/OLV-001.yaml` | `a70faa6c6e57c2acf745e0426a39374b9fc0a2e57a392da9dc23a56c38fb872a` |
| `blueprint/source_transcriptions/OLV97-C03-WATSON.md` | `94ea9bf00b291e82a315522fee099d0889d60967f0de0b815f92a1e1ce8b5b6b` |
| `review/classifications-v3.json` | `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e` |
| `lake-manifest.json` | `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404` |
| `review/PROTOCOL.md` | `7453bc0ca6985d7ca2e8c525d9655a94e412c48e3850b92d9367a9f643d3177d` |
| `review/rubrics/api_dependency.md` | `4e5f947ed15f0101c46fe9bb0a12a013d66c7de3c7ed2c35fda817de8d92eb41` |
| `review/rubrics/mathlib_reuse.md` | `dee214f219ccb03db63194208487f6cb69777b5bc780b608b6e717b729ee901a` |
| `review/rubrics/quantitative_correctness.md` | `1f77ffb3ac536c58875719ebae6cf9bbbcfd4fd027bd491867e0545660745062` |

I read all three bound proofs and cards in full, as well as the review protocol, all five review rubrics, the required `referee-lean-library` global rubric, the surviving Watson source transcription, the relevant dependency/roadmap/design documents, and the existing Lean root/import modules. The Olver PDF bytes named in the card are absent and were not inspected.

## Separate verdicts

| Review item | Verdict | Scope qualification |
|---|---|---|
| IMP-001 R5 natural-language mathematics, T01--T08 | **approve** | The mathematical proofs and stated side conditions reach all eight targets. A separate exact-API-ledger defect below must be corrected in the artifact bytes. |
| QL-001 R3 natural-language mathematics, T01--T02 | **approve** | Conditional on the approved mathematical semantics of IMP-001 R5. A separate exact-API-ledger defect below must be corrected in the artifact bytes. |
| OLV-001 R3 natural-language mathematics | **approve, conditional on the stated source semantics** | The finite estimate and one-function qualitative recovery follow from the source assumptions as transcribed, including the stated Riemann-to-Bochner adapter obligation. This is not a new PDF/source-fidelity approval. |
| Dependency direction and structural circularity | **approve** | The route `IMP -> QL -> OLV -> SR` is downward-only; no target conclusion, bound, primitive choice, or qualitative theorem is fed back into its producer. |
| Exact Mathlib/API dependency ledger at this commit | **request_changes** | Finding F1: three qualified declaration names are false at the exact pin, although the required declarations exist at the root namespace with exactly the needed statements. |

The mathematical and architectural arguments are clear for signature design, but the exact bytes at this commit are **not cleared to start exact-signature design** because F1 contradicts their exact pinned-dependency ledgers. After F1 is corrected and the corrected bytes receive the protocol-required fresh binding/review quorum, I see no mathematical or structural obstacle to starting exact-signature design. The deliberate absence of future signatures is not a mathematical defect; theorem-card/signature review and `lean_ready` remain pending by design.

## Finding F1 — incorrect namespace qualifications in exact pinned ledgers (`P2`, request changes)

The following cited constants do not exist under the names written at Mathlib commit `0df444a360eaa60ab8c11dca51a86af692955474`:

1. `intervalIntegral.intervalIntegrable_iff_integrableOn_Ioc_of_le` must be the root declaration `intervalIntegrable_iff_integrableOn_Ioc_of_le`.
2. `Real.integrableOn_exp_mul_Ioi` must be the root declaration `integrableOn_exp_mul_Ioi`.
3. `Real.integral_exp_mul_Ioi` must be the root declaration `integral_exp_mul_Ioi`.

The first error occurs in `blueprint/proofs/IMP-001.md` at the IMP-M14 ledger and its T07 proof citation, and in `blueprint/theorem_cards/IMP-001.yaml`. The latter two errors occur in `blueprint/proofs/QL-001.md` in the tail construction, tail evaluation, dependency ledger, and reuse ledger, and in `blueprint/theorem_cards/QL-001.yaml`.

This is not a mathematical gap: the root declarations have the exact required content and defining modules. It is nevertheless material at this proof-first stage because the artifacts expressly promise exact pinned names and because an exact-signature author following the ledger would receive unknown-constant errors. Correct every occurrence, regenerate the affected SHA-256 bindings, and bind any subsequent approval to the corrected commit.

## Independent reconstruction: IMP-001 R5

### T01 and T05: semantic predicates

T01's relation is mathematically coherent. Ordering a finite `S subset (k,infinity)` gives finitely many components. Requiring compact `IntervalIntegrable` evidence within every regular component prevents Mathlib's totalized integral from manufacturing values. The left and right endpoint limits are independent, so a symmetric principal value cannot pass. Changing an interior anchor adds one fixed interval integral to one side and subtracts it from the other, leaving the component sum invariant.

T05 records exactly the data needed downstream: continuity on `[k,infinity)`, normalization `F(k)=0`, and the integral increment law on every closed interval avoiding `S`. It does not contain boundedness, convergence at infinity, a target weight, or a target integral value. Continuity gives the two individual finite endpoint limits at every exceptional point; it is essential, as shown by a zero integrand with a jump in `F`.

### T08: equivalence with a convergent normalized primitive

The forward construction is sound. On the first component use the accumulated integral from `k`; at each exceptional point assign the preceding one-sided limiting cumulative value; on each subsequent component translate the anchored primitive by the cumulative prior component sum. The left anchored limit is the negative of the recorded left contribution and the right anchored limit is the recorded right contribution, so the pieces meet continuously. The last atTop contribution and the finite telescope give `F -> I`.

Conversely, T05 supplies every regular compact integral. Continuity yields the two separate endpoint limits, the atTop limit supplies the final contribution, and the finite sum telescopes from `F(k)=0` to `I`. The existential quantifier over `F` is necessary and correctly placed; the theorem neither promises that an arbitrary fixed `F` works nor chooses a public primitive.

### T02--T04: relation laws

- T02 follows from uniqueness of each limit on a nontrivial one-sided or atTop filter and the fixed finite sum. It does not use integrability across an exception.
- T03 is valid for the literal union `S_A = union_i S_i` and for cross-codomain CLMs `E ->L[R] H`. Apply T08 to each input, weaken each T05 witness from `S_i` to `S_A`, form the finite mapped sum of primitives, commute each CLM with the Bochner interval integral, and apply T08 backward. Empty, negation, scalar, real-to-complex, and complex-to-real cases all follow without an insertion API or chosen superset.
- T04 has the correct sign and value order. Prepending `[a,k]` shifts the primitive by `J = integral_a^k f`; restricting a primitive from `a` back to `k` subtracts `G(k)=J`. Intervals crossing `k` are justified by the supplied finite integrability and adjacent-interval additivity. Thus `HasImp(f,a,S,J+I) iff HasImp(f,k,S,I)`.

### T07: honest Bochner bridge

From `IntegrableOn f (Ioi k)`, the canonical primitive `P(t)=integral_k^t f` is continuous on `Ici k`, normalized, and has the exact increment law. Its atTop limit is the honest Ioi set integral. It is a T05 witness for every arbitrary finite marking set above `k`; T08 backward then proves T07. This route never infers convergence from a totalized integral expression and correctly ignores the singleton value at `k`.

### T06: finite-exception Abel composition

The private identity is correct for arbitrary real `h`:

`integral_a^b w g = w(b)F(b) - w(a)F(a) + h integral_a^b w F`, with `w(t)=exp(-h t)`.

Writing `F(t)=F(a)+integral_a^t g`, finite triangular Bochner Fubini is legitimate: on the restricted square the kernel is a.e. strongly measurable and dominated by a finite-measure multiple of `norm g`; no global strong-measurability premise and no infinite-domain interchange is needed. The scalar identity `h integral_u^v w = w(u)-w(v)` follows from FTC without division, including `h=0`. The constructed transformed primitive

`G(t)=w(t)F(t)+h integral_k^t w(u)F(u) du`

is continuous, normalized, and has the weighted regular-piece increment law. The two explicit T06 hypotheses make the set integral honest and give the exact atTop limit. T08 backward produces the relation on the same literal `S`. There is no derivative assumption on `F` and no recursive endpoint proof duplicated in T06.

All eight IMP targets therefore pass the mathematical review. The principal-value `1/(t-c)` counterexample is rejected; a cutoff `sin(1/(t-c))/(t-c)` is admitted when its two one-sided integrals converge; `sin t/t` at infinity is not strengthened to absolute integrability; `a=b` and `h=0` have the advertised semantics.

## Independent reconstruction: QL-001 R3

### T01: generic local-plus-tail bound

On `(0,k]`, restricted `AEStronglyMeasurable phi`, the pointwise bound `norm(phi t) <= K t^(beta-1)`, `beta>0`, and the pinned power-exponential integrability theorem give honest local Bochner integrability. Since `x>max(X,0)`, `x>0`. Norm domination and enlargement from `(0,k]` to `(0,infinity)` yield

`norm J <= K Gamma(beta) x^(-beta)`.

The Gamma identity is used only after integrability is proved. Values at zero remain null-set irrelevant, including `0<beta<1`.

For the tail put `h=x-X>0` and `g(t)=exp(-X t) phi(t)`. T05 gives the baseline primitive. Continuity of `F` on `Ici k` supplies restricted a.e. strong measurability of `exp(-h t)F(t)`, and the flat bound `norm F <= L` dominates it by the integrable scalar `L exp(-h t)`. The same domination plus exponential decay gives the boundary limit. T06 therefore constructs the exact tail value

`T = h integral_(k,infinity) exp(-h t) F(t) dt`,

and its norm is at most `L exp(-h k)`. T04 prepends the honestly integrable local interval, so `I=J+T` has the required relation and the triangle inequality gives exactly the stated bound. The assumptions contain baseline primitive control, not the requested target-`x` conclusion; a remote bump confirms why tail control is indispensable. Strict `x>X` is essential.

### T02: finite Watson decomposition

For each `s<n`, `beta_s=(s+lambda)/mu>0`, so the real model is independently `IntegrableOn (Ioi 0)`. T07 gives its exact relational value; the real Gamma formula then identifies it. Cross-codomain T03 transports the real values to complex values, applies the coefficients, and combines their empty (or explicitly marked) exceptional sets with the remainder set to the literal `S`. It constructs one explicit `Q=R+sum_s model_s`, and subtraction reduces its error exactly to `R`. At `n=0`, the model family is empty and no coefficient or Gamma witness is accessed. T02 uniqueness can identify any separately supplied value.

Both QL targets therefore pass the mathematical review. No infinite series/integral interchange, hidden sign, nonpositive majorant, target-dependent baseline primitive, or totalized conditional integral appears.

## Independent reconstruction: OLV-001 R3, conditional on stated source semantics

Assuming the transcription's source hypotheses and its stated finite-exception ordinary-Riemann-to-Bochner adapter obligation:

1. Positivity of `lambda,mu` gives every `beta_s>0` and `alpha_s>-1`, so every finite model moment is honestly integrable and has the stated Gamma value.
2. Eventual source convergence selects one `X>0` and one baseline related value before `n`. The `n=0` local expansion gives absolute local integrability at zero, so the stronger T01 initial-endpoint contract is legitimately discharged rather than assumed from a totalized integral.
3. After fixing `n`, finite subtraction of the independently integrable baseline models gives a baseline remainder relation through T07 and T03.
4. One-sided big-O supplies positive `k_n,K_n`; shrinking `k_n` below the least point of finite `S` preserves the bound. Proper compact Riemann regularity plus countable exhaustion is expressly retained as the source-adapter obligation providing restricted a.e. strong measurability. Local domination gives the honest interval integral needed by T04.
5. T04 removes the local prefix. T08 supplies a normalized continuous primitive tending to the tail value. Convergence gives eventual boundedness, continuity gives boundedness on the compact prefix, and their maximum supplies `L_n>=0`; no norm bound is hidden in T08.
6. QL T02 then gives the stated finite estimate for every `x>X`.

The quantifier order is correct: `X` is common and chosen before `n`; `k_n,K_n,L_n` may depend on `n`; `x` is later. The eventual qualitative recovery also uses one function: select `Q_{0,x}` from the order-zero existence result, then use T02 uniqueness to identify every `Q_{n,x}` with it. For fixed `n`, the exponential tail is little-o of `x^(-beta_n)`, giving the printed finite-order Poincare remainder meaning. No convergence in order is claimed.

The uploaded Olver PDF is absent after restart. I therefore make no fresh claim that the surviving transcription is faithful to the printed pages, no reconciliation claim for the snapshot digest, and no source-fidelity gate approval. The verdict here is exactly conditional on the source semantics stated in the bound transcription/card, including finite `S`, independent ordinary one-sided convergence, proper compact Riemann pieces, and the future Riemann-to-Bochner agreement theorem.

## Dependency, API shape, and structural circularity

The intended module split is well-founded:

- `Improper.Basic`: T01, T05, T08, then T02--T04;
- `Improper.Bochner`: imports Basic and owns T07;
- `Improper.Abel`: imports Basic and owns T06 plus private Fubini/FTC plumbing;
- `Integral.Watson`: imports the public IMP surface and pinned scalar-moment facts, and owns QL;
- `Olver1997.Chapter3.Watson`: consumes IMP/QL plus the explicit source adapter;
- `Audit/SourceRecovery`: consumes OLV for the qualitative bridge and is not imported back into semantic modules.

T08 is proved directly from component semantics before the laws that consume it. T03, T04, T06, and T07 use T08 but T08 uses none of them. QL does not construct or unfold sorted components. OLV derives `L_n` after obtaining a genuine finite-limit primitive. The future one-function choice uses existence followed by uniqueness and is downstream of the finite theorem. Thus there is no circular identification, target-sized hypothesis, hidden primitive selection, order-dependent target function, or downstream-to-foundation import edge.

The eight-target IMP surface is consumer-justified. T07 avoids duplicate absolute-integrability adapters for model moments; T08 removes duplicated endpoint stitching from OLV and T06; heterogeneous T03 is genuinely needed for real-to-complex models. Sorted sets, anchors, endpoint recursion, triangle kernels, and the finite-piece Abel lemma should remain private. I found no public-API gap beyond the exact namespace corrections in F1, and no reason to introduce a universal typeclass or a second integral definition.

## Pinned Mathlib verification and probe limitation

I inspected the exact defining sources at the pinned Mathlib commit and ran an allowed declaration-only `#check` probe using cached narrow defining imports. The probe confirmed the statements and namespaces of:

- interval additivity, CLM commutation, Hausdorff limit uniqueness, finite-sum limits, compact continuity-to-integrability, restricted-product interval Fubini, interval FTC, interval totalization, primitive continuity, and the exponential derivative;
- the Ioi improper-limit theorem, Ioi primitive continuity, Ioi subtraction, the real Gamma moment, norm/set-integral inequalities, exponential decay, complex real embedding, continuous bilinear multiplication, and exponential-vs-rpow little-o.

The same probe exposed F1. The module olean for `Mathlib.Analysis.SpecialFunctions.Gaussian.GaussianIntegral` was absent, so the single declaration `integrableOn_rpow_mul_exp_neg_mul_rpow` could not be included in the compiled `#check` run without building new artifacts. I did not build it. Its exact pinned source declaration was inspected directly: it assumes `-1<s`, `0<p`, and `0<b` and proves `IntegrableOn (fun x => x^s * exp(-b*x^p)) (Ioi 0)`, exactly matching the uses with `p=1`, `s=beta-1`, and positive coefficient. No candidate proof or signature prototype was attempted.

## Required disposition and clearance

1. Correct the three namespace qualifications in every proof/card ledger occurrence listed in F1.
2. Recompute the changed proof/card digests and bind review of the corrected bytes to their new exact commit. This report remains evidence only for the commit and bytes listed above.
3. Once the corrected proof/API artifacts have the required independent mathematical and structural quorum, exact-signature design may begin. Signature review must still compile the arbitrary-`S` downstream regressions, preserve the existential `F` in T08, the literal union and `E -> H` CLMs in T03, and the explicit related values in QL/OLV.
4. Keep final theorem-card/signature approval, source collation/reconciliation, registry/manifest admission, `lean_ready`, and Lean implementation pending. Their present absence is intentional and is not one of this review's mathematical findings.

No other mathematical, quantitative, API-architecture, hypothesis/choice-laundering, or dependency-circularity finding was identified.
