# Watson corrective review — referee E

## Binding and verdict summary

- Reviewer ID: `watson_r6_referee_e`
- Review stage: `pre_lean`
- Reviewed head: `50dcded3b36e33632cf1e9734cac34c10a890d8a`
- Comparison baseline: `f5a5a6012a2d96d45ae365999fa778d61f38e522`
- Lean toolchain: `leanprover/lean4:v4.33.1`
- Resolved Mathlib: `0df444a360eaa60ab8c11dca51a86af692955474`
- Overall verdict for the requested corrective scope: **approve**
- Material findings: none.

Separate fresh verdicts:

| Review surface | Verdict | Scope qualification |
|---|---|---|
| IMP-001 R6 theorem card and natural-language proof | **approve** | All T01--T08 mathematics and the three-module public architecture were reviewed. |
| QL-001 R4 theorem card and natural-language proof | **approve** | Both quantitative targets, constants, domains, analytic premises, and the IMP consumer route were reviewed. |
| OLV-001 R4 theorem card and natural-language proof | **approve** | Conditional on the already recorded transcription: this is a proof/architecture verdict, not a fresh source-fidelity or edition-reconciliation verdict. |
| Exact pinned Mathlib API ledgers | **approve** | The corrected root namespaces and the other cited upstream declarations were checked at the exact pin with narrow imports. |
| Structural circularity, dependency direction, source-to-target reachability, and hypothesis/choice laundering | **approve** | No reverse edge, theorem-sized premise, hidden bound, selected improper-value function, or downstream/private-recursion dependency was found. |

These exact bytes clear this referee's natural-language-proof and architecture precondition for proceeding to signature design. This report alone does not establish the required distinct-reviewer quorum, does not freeze a packet, and does not set `lean_ready`: the deliberately absent R6/R4 final exact signatures and final card/work-packet/envelope bindings, registry admission, and remaining external approvals keep `lean_ready` pending. Their absence is expected at this stage and is not a defect in this verdict.

## Exact six primary artifacts

SHA-256 at the reviewed head:

| Artifact | SHA-256 |
|---|---|
| `blueprint/proofs/IMP-001.md` | `88f60d501c4261cba37b5d1f320406c258bde785ed3912720b3be897d6424f0e` |
| `blueprint/theorem_cards/IMP-001.yaml` | `97e7af6b5d1919b45fef90dfea5cb86b1f041d26c447c51852271ad04fdd75a0` |
| `blueprint/proofs/QL-001.md` | `0e10900131fce62f2ed0256d4c0844ff6fb8b7a570fa25cf4ac4a05c33ea7116` |
| `blueprint/theorem_cards/QL-001.yaml` | `176dd5661eca3ef6c348a1557cf121e46921131c279a7f64846f78a8eef399e0` |
| `blueprint/proofs/OLV-001.md` | `40e31aab68f1f065598ea3b7ea5a46616bb84f2ab44b1ca49632be523ed9ff0f` |
| `blueprint/theorem_cards/OLV-001.yaml` | `442004db665f0f4eb20f7bac5708a50dc377566356841c2be2f0389d75a4bf1b` |

Supporting bindings checked: `lake-manifest.json` has SHA-256 `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`; `review/classifications-v3.json` has SHA-256 `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`; and the repository transcription `blueprint/source_transcriptions/OLV97-C03-WATSON.md` has SHA-256 `94ea9bf00b291e82a315522fee099d0889d60967f0de0b815f92a1e1ce8b5b6b`.

## Corrective-delta audit

I inspected independent `git archive` snapshots of both full commits and audited every zero-context hunk in the six primary artifacts and all eleven other changed files. For the primary artifacts:

- all displayed mathematical blocks are byte-identical to the baseline: 56 IMP blocks (aggregate SHA-256 `9eef34138ae1de5cf1994c85e962c75f68915a7fb983796f19d2054ae585e7ee`), 24 QL blocks (`6aa880092500c60a22d2d54f8ebe30fd27369589228bf820b97db57f4d6d686b`), and 29 OLV blocks (`c4d9425d5e3d9a2802bcc6d2d9406f73d05c14f1b81df85934c32225f5c3e37a`);
- the IMP and QL mathematical contracts, all three target-classification lists, all public-target lists, the OLV quantitative contract, and the IMP module/dependency architecture compare equal as parsed data;
- OLV's parsed `source_contract` differs only because its prose now says that Revision 4 makes no new source or reconciliation claim; the source hypotheses and formulas did not change;
- the proof hunks otherwise change artifact/card revisions, supersession and dependency references, status/blocker language, and exactly the three namespace corrections;
- the repository-wide ledgers consistently say IMP R6, QL R4, and OLV R4, preserve historical R3/R5 references only as superseded history, and continue to state draft/planning-only/no-authorization status.

The three corrected declarations are exactly root declarations:

- `intervalIntegrable_iff_integrableOn_Ioc_of_le` — not `intervalIntegral.intervalIntegrable_iff_integrableOn_Ioc_of_le`;
- `integrableOn_exp_mul_Ioi` — not `Real.integrableOn_exp_mul_Ioi`;
- `integral_exp_mul_Ioi` — not `Real.integral_exp_mul_Ioi`.

No stale occurrence of any rejected prefixed name remains in the reviewed snapshot. The additional documentation changes accurately update revision/dependency/status ledgers and correct the already-existing validator description from v2 to its actual v3 authority. The only operational delta is intentional: `.github/workflows/ci.yml` removes `push` and `pull_request`, retains only `workflow_dispatch`, and preserves the same validation, negative-test, and Lean build job steps. I did not start GitHub CI.

## Independent mathematical reconstruction

IMP's semantic core is sound. T01 requires honest interval integrability on each regular compact truncation, independent one-sided limits at every marked finite exceptional point, and the final one-sided limit at infinity. T05 records only a continuous normalized primitive and its increment law on intervals avoiding the exceptional set. The two directions of T08 reconstruct one another by a finite telescope: endpoint limits define a globally continuous accumulated primitive, while continuity and the increment law recover every independent component limit. T03 then enlarges each primitive certificate to the literal finite union and applies a finite family of continuous real-linear maps `E → H`; T04 prepends the exact oriented value `∫ a..k f`; T07 obtains the canonical primitive and limit only from an explicit `IntegrableOn (Ioi k)` premise.

The IMP Abel formula has the correct signs and boundary terms:

`∫_a^b e^(-h t) • g(t) dt = e^(-h b) • F(b) - e^(-h a) • F(a) + h • ∫_a^b e^(-h t) • F(t) dt`.

Its proof route uses the increment law, a finite restricted-product triangular Fubini argument, and the scalar identity `h ∫_u^v e^(-h t) dt = e^(-h u) - e^(-h v)` without division by `h`. The transformed primitive is normalized because `F(k)=0`; weighted integrability and boundary vanishing then give the exact T06 tail value. No derivative of `F`, absolute integrability through an exceptional point, positivity of arbitrary T06's `h`, or public recursion helper is assumed.

QL correctly sets `h=x-X>0`. Restricted-volume `AEStronglyMeasurable` plus the local power majorant and `β>0` gives the honest local interval. Public T06 gives the tail relation; the exact norm computation is `h L ∫_k^∞ e^(-h t)dt = L e^(-h k)`. Public T04 prepends the local interval. For the finite Watson target, the root power-exponential integrability theorem is used before the totalized Gamma-value equality, T07 turns each honest model integral into the relation, and generalized T03 constructs the complex amplitude value. The resulting bound is exactly

`K Γ(β) x^(-β) + L exp (-(x-X)k)`.

OLV chooses one positive baseline `X` before `n`. At each fixed order, the local source big-O supplies `k_n,K_n`; the baseline source relation minus the independently integrable finite Gamma models is formed through T07/T03; T04 removes the honest local interval; T08 supplies a primitive tending to a finite value; continuity on a compact prefix plus eventual boundedness derives `L_n` outside T08. QL T02 then supplies the target-weight value and finite bound. The future single-function route chooses only the `n=0` related value and uses T02 uniqueness to transport every fixed-order estimate. Thus the target function and `X` are not order-dependent, whereas `k_n,K_n,L_n` visibly may be.

The public source-to-target route is therefore:

`baseline T01 → model T07 → finite subtraction T03 → local split T04 → primitive extraction T08 → derive L_n → QL T02 (internally T05/T06/T04/T03) → uniqueness T02`.

QL and OLV refer to private sorting/Fubini machinery only to document its encapsulation; neither consumes it. No LMLF Lean declaration for these prospective APIs exists at the reviewed head, so there is no downstream code or hidden import edge contradicting the documented route.

## Pinned API and local validation evidence

Using the exact installed Mathlib checkout, narrow-import `#check` files in `/tmp` typechecked every named IMP dependency and the QL support surface. In particular, the following resolved with the recorded namespaces and stated mathematical types:

- root `intervalIntegrable_iff_integrableOn_Ioc_of_le` from `IntervalIntegral.Basic`;
- root `integrableOn_rpow_mul_exp_neg_mul_rpow` from `Gaussian.GaussianIntegral`;
- `Real.integral_rpow_mul_exp_neg_mul_Ioi` from `Gamma.Basic`;
- root `integrableOn_exp_mul_Ioi` and `integral_exp_mul_Ioi` from `ImproperIntegrals`;
- root `isLittleO_exp_neg_mul_rpow_atTop`;
- the cited interval additivity, CLM/integral commutation, Fubini swap, FTC, primitive continuity, Ioi-limit, tail-primitive, uniqueness, finite-sum limit, totalization warning, `Complex.ofRealCLM`, `ContinuousLinearMap.mul`, norm/set-integral bounds, and exponential limit declarations.

Local results:

- `lake build`: passed, 2748 jobs;
- `python3 scripts/validate_inventory.py --negative-tests`: passed, including all 25 intentionally invalid fixtures;
- PyYAML parsing via `/tmp/lmlf-yaml.qK8wcdah`: all 15 YAML/YML files parsed;
- parsed CI trigger map: only `workflow_dispatch`;
- deterministic library inventory: 7 Lean files, 18 theorem declarations, 3 definitions, no trust/resource markers;
- worktree remained clean at exact head after the checks.

No candidate Lean proof, signature prototype, generated declaration, edit, commit, push, or remote CI run was made.

## Isolation, source, and runtime limits

Isolation strength is `manual_attestation`, not `technically_enforced`. The candidate and baseline were read from separately extracted `git archive` directories (`/tmp/lmlf-new.rNj9zC` and `/tmp/lmlf-base.xkBX2U`). Pinned API checks and the local package build used the shared workspace's already-built Mathlib oleans. Temporary read/check files lived only in `/tmp`; the candidate source tree was not patched. This environment did not technically exclude other writable paths, credentials, plugins, or network capability, so the review does not claim hardened clean-room equivalence.

Per orchestration metadata, the configured reviewer model/runtime was `gpt-5.6-sol`, reasoning `high`, with `fork none`; that configuration is attributed to orchestration rather than independently introspected by this reviewer. I used no subagents and did not inspect peer reports, prior referee verdicts, or other review outputs.

No PDF exists in the reviewed archive. The OLV source snapshot bytes are explicitly recorded as absent from the repository. I reviewed the bound repository transcription and the mathematical route from its stated hypotheses, but made no fresh PDF, source-image, edition, page, or source-transcription reconciliation claim. Independent source collation/fidelity review remains pending and is outside this approval.

## Rubric closure

The global library rubric is clear in each requested dimension: mathematical intent is implemented by the written route; the only reusable seam added is the justified IMP layer with real QL and OLV consumers; public targets are minimal and naturally scoped; dependencies run from Basic to Bochner/Abel to QL to OLV; pinned Mathlib is reused rather than duplicated; proof architecture separates semantics, exact identities, estimates, and source application; no performance claim is made without profiling; and the current change is clerical with no migration blast radius beyond revised draft bindings. No `G#` refactor finding or proof-handoff finding is warranted.
