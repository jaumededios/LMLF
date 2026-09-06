# Fresh corrective-revision review: Watson IMP R6 / QL R4 / OLV R4

## Review identity and boundary

- Reviewer ID: `watson_r6_referee_d`
- Reviewer kind: `agent`
- Configured model: `gpt-5.6-sol`
- Configured reasoning effort: `high`
- Fork mode: `none`
- Isolation strength: `manual_attestation`
- Isolation method: fresh context; direct inspection of exact Git archives; no peer
  reports, agent outputs, agent listings, or pre-existing review-evidence contents
  were read; no subagent was used.
- Runtime/build-ID limitation: the orchestration environment exposes the configured
  model and effort but no independently verifiable runtime build ID. No stronger
  runtime identity is claimed.
- Old commit: `f5a5a6012a2d96d45ae365999fa778d61f38e522`
- New commit: `50dcded3b36e33632cf1e9734cac34c10a890d8a`
- Mathlib pin actually checked: `0df444a360eaa60ab8c11dca51a86af692955474`
- Lean toolchain recorded by the artifacts: `leanprover/lean4:v4.33.1`
- Review stage: `pre_lean`

The old and new trees were separately materialized with `git archive` into a
disposable directory. All comparisons and substantive readings below used those
archive trees, not mutable candidate files. The source PDF is absent from the new
archive, so this review does not perform or renew source-fidelity, page-image,
scalar-interpretation, or transcription approval.

## Exact primary artifact bindings

| Artifact | Old SHA-256 | New SHA-256 |
|---|---|---|
| `blueprint/proofs/IMP-001.md` | `3c45e55fb76bc03ddfb6fe772fd20e33ddefcaad3ed3f07a5f3523ceb93f483f` | `88f60d501c4261cba37b5d1f320406c258bde785ed3912720b3be897d6424f0e` |
| `blueprint/proofs/QL-001.md` | `e231233ae07d19702d5260b66e5ded9854477fb7e1a5dc188ecfc887c681019e` | `0e10900131fce62f2ed0256d4c0844ff6fb8b7a570fa25cf4ac4a05c33ea7116` |
| `blueprint/proofs/OLV-001.md` | `1b183323439cd06f4d049fd85594e02a5d4bb0e1d0103bc25e011ed100498db4` | `40e31aab68f1f065598ea3b7ea5a46616bb84f2ab44b1ca49632be523ed9ff0f` |
| `blueprint/theorem_cards/IMP-001.yaml` | `b5ca9b3c818237b243cabf2328b7d51c4a292366928873767de0e6584de5ef62` | `97e7af6b5d1919b45fef90dfea5cb86b1f041d26c447c51852271ad04fdd75a0` |
| `blueprint/theorem_cards/QL-001.yaml` | `538591bc51ac66e38eab1a9299fae1154bd40f1ce657a6a9a1f9f4b6af1de488` | `176dd5661eca3ef6c348a1557cf121e46921131c279a7f64846f78a8eef399e0` |
| `blueprint/theorem_cards/OLV-001.yaml` | `a70faa6c6e57c2acf745e0426a39374b9fc0a2e57a392da9dc23a56c38fb872a` | `442004db665f0f4eb20f7bac5708a50dc377566356841c2be2f0389d75a4bf1b` |

The card YAML parses successfully. Its internal card/proof revision pairs are
IMP `6/6`, QL `4/4`, and OLV `4/4`; target counts remain `8`, `2`, and `1`.
All three remain `draft / not_started / not_started` for
specification/review/implementation, with absent exact-signature artifacts and
absent authorization.

## Corrective-delta verification

I inspected the complete old-to-new diff for all six primary artifacts. The
only declaration-identity corrections are:

1. `intervalIntegral.intervalIntegrable_iff_integrableOn_Ioc_of_le` to root
   `intervalIntegrable_iff_integrableOn_Ioc_of_le` in IMP;
2. `Real.integrableOn_exp_mul_Ioi` to root `integrableOn_exp_mul_Ioi` in QL;
3. `Real.integral_exp_mul_Ioi` to root `integral_exp_mul_Ioi` in QL.

All other changes in those six files are revision numbers, supersession links,
dependency rebinding from IMP R5 to R6 and QL/OLV R3 to R4, or explicit
pending/no-authorization status prose. Every displayed proof formula, theorem
contract, quantifier order, hypothesis, constant, target classification,
consumer route, and mathematical/adversarial example is unchanged. OLV R4 has
no mathematical edit at all; it only rebinds the reviewed downstream drafts.

The corresponding current planning documents consistently report IMP R6,
QL R4, and OLV R4, the three root namespaces, and the absence of approval,
`lean_ready`, exact signatures, registry/manifest authorization, and
implementation authorization. Searches found no residual use of any of the
three incorrect qualified declaration names. The broader exact-commit diff has
no Lean source change.

The separate workflow change deletes only the `push` and `pull_request`
triggers. `workflow_dispatch` remains, and the permissions, single `build` job,
runner, pinned actions, inventory-positive step, 25-negative-fixture step, and
Lean build step are byte-identical after removal of those two trigger lines. I
did not invoke GitHub Actions or any paid CI.

## Pinned declaration probes

A disposable file containing imports and `#check` commands only compiled with
`lake env lean`. No candidate proof or signature prototype was created. The
pin reports the following contracts:

- root `intervalIntegrable_iff_integrableOn_Ioc_of_le`: for `a ≤ b`,
  `IntervalIntegrable f μ a b ↔ IntegrableOn f (Ioc a b) μ`;
- root `integrableOn_exp_mul_Ioi`: `a < 0` implies integrability of
  `x ↦ exp (a*x)` on `Ioi c`;
- root `integral_exp_mul_Ioi`: under `a < 0`, that integral equals
  `-exp (a*c) / a`;
- root `integrableOn_rpow_mul_exp_neg_mul_rpow`: `-1 < s`, `0 < p`, and
  `0 < b` imply integrability of `x^s * exp (-b*x^p)` on `Ioi 0`.

For cross-checking the unchanged formulas, the same probe confirmed
`Real.integral_rpow_mul_exp_neg_mul_Ioi` and
`isLittleO_exp_neg_mul_rpow_atTop`. The former gives the Gamma moment under
positive exponent and decay parameters; the latter gives exponential decay
as little-o of every real power for a positive exponential rate. These exact
types support the specializations stated in QL and OLV.

## Independent mathematical review

### IMP-001 R6 natural-language proof

`verdict: approve`

The T01 endpoint-component relation records regular-piece integrability and
independent one-sided limits, so it neither admits principal-value-only
cancellation nor relies on totalized nonintegrable values. The T05 primitive
contract has exactly the continuity, normalization, and every-regular-piece
increment law needed to glue components. The two directions of T08 construct
and recover the same finite telescope, including empty and multiple-exception
cases, without using T02--T07.

The downstream laws then have sound, noncircular proofs: T03 weakens each
primitive to the literal finite union and applies finite continuous-linear
combination; T04 changes the normalized primitive by the honest prepended
finite integral with the correct `J + I` orientation; T07 constructs the
canonical Ioi primitive only from an explicit `IntegrableOn` premise. The
private Fubini identity has the correct restricted-product integrability
obligation and the Abel signs are correct. The transformed primitive
`exp(-h t) • F(t) + h • ∫_k^t exp(-h u) • F(u) du` has the claimed increments
and limit, including the stated `h = 0` conditional case. I found no hidden
absolute-integrability strengthening, derivative premise, chosen integral
value, or quantitative conclusion.

### QL-001 R4 natural-language proof

`verdict: approve`

The local estimate correctly derives honest integrability on `(0,k]` from the
measure-relative a.e. strong measurability premise and the `β > 0` power
majorant before using the Gamma value. With `h = x-X > 0`, boundedness of the
baseline primitive gives both T06 side conditions. The exact root exponential
tail integral cancels the positive `h`, yielding `L exp(-h k)` with no lost
factor or unsafe division. T04 then produces the explicit full relation at
`J+T` and the triangle inequality gives the stated bound.

For T02, model integrability is established independently of the totalized
Gamma equality; T07 supplies honest relational values and generalized T03
transports and adds the complex coefficients. The value
`Q = R + Σ a_s Γ(β_s) x^(-β_s)` makes subtraction reduce exactly to `R`.
The `n = 0` path is genuinely empty and needs neither coefficients nor model
witnesses. No infinite sum/interchange or theorem-sized target hypothesis is
present.

### OLV-001 R4 natural-language proof

`verdict: approve`

This approval is conditional on the dossier's stated source semantics and is
not source-fidelity approval. Given those semantics, the route is correct:
one positive baseline `X` and value are chosen before `n`; order-zero local
control discharges T01's stronger honest-integrability requirement at zero;
each finite model is independently integrable; T03 forms the baseline
remainder; T04 moves to `k_n`; and T08 supplies a convergent continuous
primitive. Its global bound `L_n` is then derived from eventual boundedness
plus compact-prefix continuity, rather than smuggled into T08. QL T02 yields
the finite estimate. The later `n=0` choice plus T02 uniqueness correctly puts
all fixed-order estimates on one function, and exponential little-o closes
the qualitative fixed-order remainder. Quantifier dependence and the empty
order are sound.

## Structural-circularity and library rubric

`verdict: approve`

The dependency direction is acyclic and appropriately layered:

`Mathlib facts -> IMP Basic -> {IMP Bochner, IMP Abel} -> QL -> OLV -> future SR`.

T08 is proved directly from T01/T05 and is established before its use by T03,
T04, T07, and T06. QL consumes only the prospective public IMP surface. OLV
derives, rather than assumes, its baseline remainder primitive and flat bound.
The source asymptotic premise is used only to obtain local fixed-order control;
the desired Laplace estimate is not present in a structure field or
hypothesis. The one-function choice is downstream of existence and controlled
by uniqueness. No downstream-to-foundation import, source-sized hypothesis,
hidden exceptional-set enlargement, hidden order dependence, or circular
identification was found.

Across the library rubric, the three-module IMP split isolates the reusable
semantic core, the two bridges have demonstrated QL/OLV consumers, private
sorted/Fubini plumbing stays private, and QL/OLV remain specialized downstream
layers. The proposed public surface is justified by current consumers and does
not add compatibility aliases or an opaque value function. No P0--P3 finding
was found. This is structural/circularity clearance to begin exact-signature
design for these exact revisions, not approval of signatures that do not yet
exist.

## Executed checks and limitations

- Library inventory script: passed; 7 Lean files, 18 theorems, 3 definitions,
  and no trust/resource markers reported.
- Positive inventory validator: passed with 148 occurrences, 31 notations,
  32 entities, 34 evidence rows, and 88 associations.
- Negative inventory suite: passed; all 25 intentionally invalid copied
  fixtures were rejected, followed by a passing positive revalidation.
- Card YAML parsing: passed for all three current cards.
- Pinned `#check`-only probe: passed for all declarations listed above.
- Workflow inspection: manual-only trigger confirmed; jobs unchanged; no
  GitHub run was started.

The absence of the bound PDF prevents any new source-image or transcription
judgment. No exact Lean signatures exist, so no signature elaboration or
consumer compile regression has been reviewed. This report therefore grants
only the three natural-language-proof approvals and structural/circularity
clearance stated above. It does **not** grant a final theorem-card verdict,
`lean_ready`, implementation authorization, merge authorization, source
coverage, or source-fidelity approval.
