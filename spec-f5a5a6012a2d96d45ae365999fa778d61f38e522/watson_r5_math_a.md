# Independent pre-Lean mathematical and structural review

## Review identity and isolation

- Durable reviewer ID: `watson_r5_math_a`
- Model: `gpt-5.6-sol`, as recorded by the root orchestrator's explicit spawn configuration; the agent's internal identity exposed only the generic GPT-5/Codex family, and no backend build ID was exposed
- Reasoning effort: `xhigh`, as recorded by the root orchestrator's explicit spawn configuration
- Context fork: `fork_turns: none`, as recorded by the root orchestrator's explicit spawn configuration
- Runtime: Codex desktop agent runtime on Linux, with Bash and read-only use of the candidate repository and pinned Mathlib checkout; no more specific backend runtime/build identifier was exposed
- Review stage: `pre_lean`
- Isolation strength: `manual_attestation`
- Actual isolation method: fresh agent context; no subagents; no other referee reports, agent outputs, previous diffs, or files in the evidence directory were inspected. I made a disposable `git archive` extraction of the exact candidate commit under `/tmp/watson-r5-math-a.Ip4SPs` and read candidate artifacts only from that archive. The live candidate worktree was queried only to verify the commit/worktree state and to inspect the separately pinned `.lake/packages/mathlib` source at its exact commit. No candidate file was edited and no candidate proof or signature was prototyped.
- Candidate commit reviewed: `f5a5a6012a2d96d45ae365999fa778d61f38e522`
- Candidate commit subject/date: `docs: complete Watson integration blueprint interfaces`, 2026-09-06 04:23:11 +0000
- Candidate worktree state at review start: clean; `HEAD` was the exact reviewed commit.
- Pinned Mathlib commit independently verified: `0df444a360eaa60ab8c11dca51a86af692955474`
- Pinned `lake-manifest.json` SHA-256 independently verified: `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`
- Web/source-image use: none. The private PDF bytes were absent and were not inspected. I inspected the surviving bound transcription but make no new source-image, PDF, collation, or source-reconciliation approval.

## Bound artifact digests

Primary scoped artifacts:

| Artifact | SHA-256 |
|---|---|
| `blueprint/proofs/IMP-001.md` | `3c45e55fb76bc03ddfb6fe772fd20e33ddefcaad3ed3f07a5f3523ceb93f483f` |
| `blueprint/theorem_cards/IMP-001.yaml` | `b5ca9b3c818237b243cabf2328b7d51c4a292366928873767de0e6584de5ef62` |
| `blueprint/proofs/QL-001.md` | `e231233ae07d19702d5260b66e5ded9854477fb7e1a5dc188ecfc887c681019e` |
| `blueprint/theorem_cards/QL-001.yaml` | `538591bc51ac66e38eab1a9299fae1154bd40f1ce657a6a9a1f9f4b6af1de488` |
| `blueprint/proofs/OLV-001.md` | `1b183323439cd06f4d049fd85594e02a5d4bb0e1d0103bc25e011ed100498db4` |
| `blueprint/theorem_cards/OLV-001.yaml` | `a70faa6c6e57c2acf745e0426a39374b9fc0a2e57a392da9dc23a56c38fb872a` |

Source/review authorities materially used:

| Artifact | SHA-256 |
|---|---|
| `blueprint/source_transcriptions/OLV97-C03-WATSON.md` | `94ea9bf00b291e82a315522fee099d0889d60967f0de0b815f92a1e1ce8b5b6b` |
| `review/classifications-v3.json` | `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e` |
| `review/PROTOCOL.md` | `7453bc0ca6985d7ca2e8c525d9655a94e412c48e3850b92d9367a9f643d3177d` |
| `review/rubrics/api_dependency.md` | `4e5f947ed15f0101c46fe9bb0a12a013d66c7de3c7ed2c35fda817de8d92eb41` |
| `review/rubrics/mathlib_reuse.md` | `dee214f219ccb03db63194208487f6cb69777b5bc780b608b6e717b729ee901a` |
| `review/rubrics/proof_quality.md` | `55baddf430dc9d7530e644217630a4f0905317e2a5b7bd16126036910a22ca19` |
| `review/rubrics/quantitative_correctness.md` | `1f77ffb3ac536c58875719ebae6cf9bbbcfd4fd027bd491867e0545660745062` |
| `review/rubrics/source_fidelity.md` | `6873853ce125346feef082d0e31d28808387ec0fa5fb0887ce0d300eba02c9a2` |

I read every line of all six primary scoped artifacts. I also read the protocol, all five listed repository rubrics, the required referee-lean-library global rubric, the surviving Watson transcription, the local Lean modules and root imports, and the relevant architecture/dependency material. The skill inventory found seven Lean files, 210 lines, 18 theorems, three definitions, no trust/resource markers, and no existing Watson/improper-integral declaration in the project.

## Verdicts

| Gate under review | Verdict | May proceed to exact-signature design? |
|---|---|---|
| IMP-001 R5 natural-language proof, all eight targets | `approve` | Yes |
| QL-001 R3 natural-language proof, both targets | `approve` | Yes, after treating approved IMP semantics as its upstream contract |
| OLV-001 R3 natural-language proof, conditional on the explicitly stated source semantics | `approve` | Yes, conditional on those semantics and with source reconciliation still pending |
| Structural/circularity architecture across IMP -> QL -> OLV | `approve` | Yes |

No P0-P3 actionable mathematical, API-architecture, reuse, or circularity finding remains in the reviewed natural-language bytes. These approvals do not set `lean_ready`: the cards are drafts, exact signatures are deliberately absent, the source collation is unreconciled, IMP is unregistered, and external quorum/envelope work remains. The intentionally deferred signatures are not treated as a mathematical defect in this review.

## Independent reconstruction: IMP-001 R5

### T01/T05/T08 semantic equivalence

T01 is a partial-value relation, not a totalized integral: it requires regular finite-piece `IntervalIntegrable` evidence, independent one-sided limits at each marked point, a separate limit at positive infinity, and an exact finite sum. The deterministic anchors do not change the sum because moving an anchor adds one fixed compact integral to one side and subtracts it from the other.

From T01, the cumulative primitive is well-defined component by component. On the first component it is the integral from `k`; at a marked point it is assigned the incoming finite limit; on the next component the left endpoint contribution supplies exactly the offset needed for continuity. The right endpoint contribution advances the cumulative value. The last infinity limit makes the constructed primitive tend to `I`. Conversely, a continuous normalized primitive with the regular-piece increment law supplies each separate endpoint limit by continuity; the component contributions telescope to `I - F(k) = I`. This proves exactly

`HasImp f k S I <-> exists F, IsFiniteExceptionalPrimitive f k S F and Tendsto F atTop (nhds I)`.

The existential order is essential and is correct. T08 does not claim the equivalence for an arbitrary preselected `F`, does not expose a choice-selected integral function, and contains no bound on `F`. Values of `F` below `k` are irrelevant.

### T02-T04, T07

- T02 follows from uniqueness of each limit on the same nontrivial one-sided filter and equality of the fixed finite sum. No principal-value cancellation is used.
- T03 is valid after weakening every primitive certificate from `S_i` to the literal finite union. A finite sum of continuous-linear images remains continuous and normalized; finite interval integrability and the increment law commute with the maps. T08 reverse then gives the claimed relation in the output Banach space. Empty, unary, subtraction, real-to-complex, and complex-to-real cases are all covered without an infinite interchange.
- T04 has the correct orientation. Prepending `[a,k]` adds `J = intervalIntegral f a k`, while restricting a primitive subtracts `G(k)=J`; both directions preserve normalization and give the stated `J + I` value. The cases `a=k` and a nonzero constant prefix agree with the sign.
- T07 uses `IntegrableOn f (Ioi k)` as genuine convergence evidence. The canonical primitive is continuous, has the exact increment law, and tends to the honest Ioi set integral. Marking arbitrary finitely many regular points is harmless. No converse to absolute integrability is claimed.

### T06 Abel composition

For a regular finite interval, write `F(t)=F(a)+integral_a^t g`. The triangular kernel is Bochner integrable under the exact restricted-product measure because the continuous exponential is bounded on the compact interval and the norm is dominated by a finite-measure multiple of the integrable norm of `g`; only measure-relative a.e. strong measurability is required. Fubini gives the reversed iterated integral. The scalar identity

`h * integral_u^v exp(-h*t) dt = exp(-h*u) - exp(-h*v)`

comes from the exponential derivative without division by `h`, so it includes `h=0`. Separating the constant part yields the stated finite Abel identity without assuming a derivative of `F`.

The transformed primitive

`G(t) = exp(-h*t) • F(t) + h • integral_k^t exp(-h*u) • F(u) du`

is continuous, normalized, and has the target increment law on every regular component. The two explicit public hypotheses make its set-integral term honest and force the boundary term to zero; its exact limit is therefore the T06 value. T08 reverse stitches the same literal `S`. This route is acyclic and does not conceal the desired target relation inside either tail premise.

### IMP boundary checks

The relation correctly accepts `S` empty, a locally L1 endpoint singularity at `k`, conditionally convergent separate one-sided singularities at marked interior points, and conditional convergence at infinity. It rejects a principal-value-only pole and any nonintegrable regular truncation hidden by Mathlib integral totalization. The `h=0`, degenerate finite interval, nondifferentiable primitive, discontinuous pseudo-primitive, and endpoint-only increment counterexamples all have the claimed behavior.

## Independent reconstruction: QL-001 R3

For `beta>0` and `x>0`, the local scalar majorant is honestly integrable on `(0,infinity)`. Restricted-volume a.e. strong measurability of `phi` and the pointwise norm bound therefore give an honest local Bochner integral, including `0<beta<1`; the value at zero is null-set irrelevant. Norm domination and enlargement of the nonnegative scalar integral give

`norm J <= K * Gamma(beta) * x^(-beta)`.

For the tail, `h=x-X>0`. Continuity of `F` on the right ray and `norm(F t)<=L` imply a.e. strong measurability and domination of `exp(-h*t) • F(t)` by the integrable scalar `L*exp(-h*t)`. The same bound gives the boundary limit zero. IMP T06 returns the exact tail value

`T = h • integral_(k,infinity) exp(-h*t) • F(t) dt`,

and honest norm domination plus the exact exponential integral gives `norm T <= L*exp(-h*k)`. IMP T04 prepends the local interval, and the triangle inequality yields T01's exact stated bound.

For T02, every model exponent `beta_s=(s+lambda)/mu` is positive and `alpha_s=beta_s-1>-1`. Absolute model integrability is established separately from the Gamma-value identity. IMP T07 turns the honest model set integral into the same relation, and T03 performs the real-to-complex transport, coefficient multiplication, and finite union with the remainder relation. The resulting `Q` satisfies the exact decomposition, so subtracting the model sum leaves the T01 remainder. At `n=0` the model family is empty and no coefficient or Gamma witness is needed.

No target parameter is laundered: `F`, `L`, `X`, and the finite exceptional set are fixed before `x`; the generic certificate contains no target-`x` value or requested error. The generic Banach theorem and complex scalar Watson layer are a coherent general/specialized split.

## Independent reconstruction: OLV-001 R3, conditional source verdict

This verdict assumes, but does not independently source-verify, the card's stated semantics: complex or real `q`; positive `lambda,mu`; fixed-order expansion at zero; one fixed finite exceptional set with proper compact Riemann pieces and separate ordinary one-sided limits; and convergence of the full Laplace integral for all sufficiently large positive `x`.

Under those assumptions the proof reaches the target. Choose one baseline `X>0` and baseline related value before `n`. The `n=0` expansion with exponent greater than `-1`, together with proper compact Riemann regularity, supplies local absolute Bochner integrability at zero; the stated Riemann-to-Bochner adapter then supplies the baseline T01 relation. After fixing `n`, the finitely many baseline model moments are absolutely integrable, so T07 and T03 give the baseline remainder relation. Shrink `k_n` below all positive exceptional points and obtain `K_n>0` from one-sided big-O. T04 removes the honest local prefix. T08 produces a continuous normalized primitive converging to the baseline tail value. Convergence bounds the eventual tail, compact-prefix continuity bounds the remainder, and their maximum is a finite `L_n>=0`. Applying QL T02 gives the claimed `Q_{n,x}` and estimate for every `x>X`.

The quantifier order is correct:

`q,a,lambda,mu,S` fixed; `exists X>0`; `forall n, exists k_n,K_n,L_n`; `forall x>X, exists Q_(n,x)`.

`X` is independent of `n` and the target `x`; `k_n,K_n,L_n` may depend on `n`; `F_n` and `L_n` do not depend on the later target `x`. In the later qualitative bridge, choosing the `n=0` value for each `x` and applying T02 uniqueness legitimately places all fixed-order estimates on one function. Exponential decay is little-o of `x^(-beta_n)` because `k_n>0`, so the printed fixed-order asymptotic conclusion follows.

The source-facing edge cases are sound: `n=0`, `0<lambda<mu`, zero coefficients, conditional finite singularities, and remote bumps. No section 9 global majorant, order-uniform constant, infinite-series interchange, or totalized conditional set integral enters the argument.

The surviving transcription is internally consistent with this route and has the bound digest recorded above, but it is expressly `transcribed_unreconciled`. Because the private PDF bytes were absent, this report does not attest that the transcription, page map, complex-codomain interpretation, or ordinary finite-exception semantics matches the book. OLV approval here is conditional only, exactly as requested.

## Pinned Mathlib and local-reuse audit

The local project contains no competing improper-integral, finite-exception, Watson, or local-tail declaration. The proposed IMP abstraction therefore isolates a real semantic boundary rather than renaming an existing local API.

At the pinned Mathlib commit I inspected the defining sources and exact hypotheses of the important candidates. In particular:

- `integrableOn_rpow_mul_exp_neg_mul_rpow` requires exponent `s>-1`, power `p>0`, and coefficient `b>0`, exactly matching the `p=1` local/model uses.
- `Real.integral_rpow_mul_exp_neg_mul_Ioi` requires positive Gamma parameter and positive exponential coefficient and returns `(1/r)^a * Gamma a`, equivalent to the displayed positive-real power form.
- `Real.integrableOn_exp_mul_Ioi` and `Real.integral_exp_mul_Ioi` require a negative exponential coefficient, supplied by `-h<0`.
- `MeasureTheory.intervalIntegral_tendsto_integral_Ioi`, `IntegrableOn.continuousOn_Ici_primitive_Ioi`, `intervalIntegral.integral_Ioi_sub_Ioi`, and `intervalIntegrable_iff_integrableOn_Ioc_of_le` have the needed Ioi/finite-interval orientation.
- `MeasureTheory.intervalIntegral_integral_swap` takes precisely an `Integrable (Function.uncurry K)` premise under `(volume.restrict (uIoc a b)).prod mu`; the dossier records that exact obligation.
- `ContinuousLinearMap.intervalIntegral_comp_comm`, `intervalIntegral.continuousOn_primitive_interval'`, and the interval FTC declaration match the finite linearity, primitive continuity, and exponential identity uses.
- `Complex.ofRealCLM` and the curried `ContinuousLinearMap.mul` provide the stated real-to-complex and fixed-coefficient continuous real-linear maps.
- `isLittleO_exp_neg_mul_rpow_atTop` has exactly the positive decay-rate premise used in qualitative recovery.

Mathlib has improper-limit theorems and totalized set integrals but no matching finite-exception relation or its primitive equivalence. The proposed local layer is justified. The three-way module split is also justified: `Basic` owns the semantics and laws, `Bochner` owns the absolute bridge, and `Abel` owns composition and its private analytic engine.

## Structural/circularity and global-library rubric

- Mathematical intent: clear. The target graph implements the written proof route and keeps provisional/source obligations visible.
- Reusable seams: clear. T08 has multiple actual consumers (T03, T04, T06, and OLV); T03, T04, T06, and T07 each have a concrete QL/OLV call site. Private ordered-component and Fubini plumbing should remain private. No speculative certificate typeclass is warranted.
- Public API shape: clear at natural-language level. A complete normed real vector space is a natural Banach boundary for the shared kernel. T03's `E -> H` generality is used by scalar transport. Flat QL witnesses are preferable to a one-consumer structure. Exact binder syntax remains for the next gate.
- Module/dependency design: clear. Dependencies flow `pinned Mathlib -> IMP Basic/Bochner/Abel -> QL -> OLV -> future audit`. There is no OLV/QL import into IMP and no use of the source theorem to prove IMP or QL.
- Mathlib integration: clear. Canonical finite Bochner integration, Gamma, exponential, limit, CLM, and Fubini infrastructure are reused; only the missing project-specific conditional relation and bridges are proposed locally.
- Proof architecture: clear. Endpoint stitching is centralized in T08; Abel's finite engine is separate from infinity passage; QL separates local domination, tail composition, and model packing; OLV separately derives each generic premise.
- Cost/durability: clear at this stage. Narrow prospective imports and private representation reduce version and migration exposure. No unsubstantiated elaboration-performance claim is made.
- Refactor risk: clear. There is no implementation or public API to migrate. The next phase must freeze exact signatures before Lean work.

The main circularity attack fails: OLV derives `L_n` from a genuine baseline related value via T08 and topology, before applying QL at a later `x`; QL's primitive premise contains neither the target relation nor its bound; T06 derives the target relation from two independently proved weighted-tail conditions. Likewise, model-value existence comes from absolute integrability plus T07, not from a totalized Gamma equality. No conclusion has been moved into a structure field or opaque choice.

## Exact-signature handoff constraints

All four reviewed gates may proceed to exact-signature design. Approval is contingent on signatures preserving the reviewed mathematics:

1. T01 must expose regular-piece integrability, independent one-sided endpoint limits, the at-top limit, and the exact sum; no coupled principal-value cutoff.
2. T08 must quantify `exists F` inside the equivalence, constrain only the right ray, and contain no norm bound or public choice function.
3. T03 must use the literal finite union and support continuous real-linear maps from the common input space to a possibly different output space.
4. T06 must take weighted-primitive `IntegrableOn` and boundary vanishing as separate hypotheses and return the exact relation/value for the same `S`.
5. QL T01 must quantify `x` after `X,F,L,S`, with `x>max(X,0)`, and return one explicit related value plus the stated bound. QL T02 must bind the relation and estimate to the same `Q`.
6. OLV must preserve one `X` before `n`, order-dependent `k_n,K_n,L_n`, and `x` after those witnesses. The Riemann-to-Bochner/source premise boundary must remain explicit and separately reviewable.
7. Signature-level API/reuse review and public-only consumer compilation remain mandatory. This report supplies no final theorem-card approval, `lean_ready`, source reconciliation, implementation authorization, or merge evidence.
