---
schema_version: nl-proof-v1
artifact_id: NLP-IMP-001-REG-R1
work_item_id: IMP-001
title: Analytic and adversarial regression companion for finite-exceptional improper integration
owner: jaumededios
revision: 1
artifact_role: analytic_regression_companion
artifact_state: frozen
proof_status: complete

theorem_card_bindings:
  - card_id: IMP-001
    card_revision: 7
    signature_artifact_id: SIG-IMP-001-R6-P2

target_bindings: []

regression_bindings:
  - regression_id: IMP-R04
    proof_section: regression-imp-r04
    planned_nonpublic_declaration: LMLFTest.Integral.Improper.principalValueCutoff_rejected
    theorem_class: audit_regression
    coverage_class: audit_only
    novelty_class: non_novel
  - regression_id: IMP-R05
    proof_section: regression-imp-r05
    planned_nonpublic_declaration: LMLFTest.Integral.Improper.conditionalFiniteCutoff
    theorem_class: audit_regression
    coverage_class: audit_only
    novelty_class: non_novel
  - regression_id: IMP-R06
    proof_section: regression-imp-r06
    planned_nonpublic_declaration: LMLFTest.Integral.Improper.sinDivTail_conditional
    theorem_class: audit_regression
    coverage_class: audit_only
    novelty_class: non_novel
  - regression_id: IMP-R07
    proof_section: regression-imp-r07
    planned_nonpublic_declaration: LMLFTest.Integral.Improper.emptySet_intervalIntegrable_projection
    theorem_class: audit_regression
    coverage_class: audit_only
    novelty_class: non_novel
  - regression_id: IMP-R11
    proof_section: regression-imp-r11
    planned_nonpublic_declaration: LMLFTest.Integral.Improper.discontinuousPrimitive_counterexample
    theorem_class: audit_regression
    coverage_class: audit_only
    novelty_class: non_novel
  - regression_id: IMP-R12
    proof_section: regression-imp-r12
    planned_nonpublic_declaration: LMLFTest.Integral.Improper.endpointOnly_counterexample
    theorem_class: audit_regression
    coverage_class: audit_only
    novelty_class: non_novel
  - regression_id: IMP-R13
    proof_section: regression-imp-r13
    planned_nonpublic_declaration: LMLFTest.Integral.Improper.indicatorPrimitive_nondifferentiable
    theorem_class: audit_regression
    coverage_class: audit_only
    novelty_class: non_novel
  - regression_id: IMP-R22
    proof_section: regression-imp-r22
    planned_nonpublic_declaration: LMLFTest.Integral.Improper.initialEndpoint_examples
    theorem_class: audit_regression
    coverage_class: audit_only
    novelty_class: non_novel
  - regression_id: IMP-R24
    proof_section: regression-imp-r24
    planned_nonpublic_declaration: LMLFTest.Integral.Improper.finiteEndpoint_update_iff
    theorem_class: audit_regression
    coverage_class: audit_only
    novelty_class: non_novel

source_bindings:
  occurrences: []
  entities: []
  notations: []
  snapshots: []

dependency_bindings:
  lean_toolchain: leanprover/lean4:v4.33.1
  mathlib_revision: 0df444a360eaa60ab8c11dca51a86af692955474
  lake_manifest_sha256: 4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404
  accepted_work_items: []
  bound_natural_language_inputs:
    - artifact_id: NLP-IMP-001-R7
      sha256: 941ca0f2a7e402e9dd3636d7c93744290b3f5b52b8705484c18630c6fe173548
      consumed_sections:
        - target-imp-001-t01
        - target-imp-001-t05
        - target-imp-001-t06
        - target-imp-001-t07
        - target-imp-001-t08
      role: >-
        Bound reviewed natural-language target mathematics only; no current,
        future, or unaccepted production Lean declaration is used as evidence.

classification_schema_binding:
  path: review/classifications-v3.json
  schema_version: lmlf-classification-v3
  artifact_revision: 3
  sha256: 975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e

frozen_specification_binding:
  commit: 3a1b16cae6d186a20530de3b883c1bb871ee76f6
  theorem_card:
    path: blueprint/theorem_cards/IMP-001.yaml
    artifact_id: TC-IMP-001-R7
    sha256: d81f8970bcba3bf1a489f8cb4fea8b303a3e3bf6d1ad3ade37b42f3094b528c4
  target_proof:
    path: blueprint/proofs/IMP-001-R7.md
    artifact_id: NLP-IMP-001-R7
    sha256: 941ca0f2a7e402e9dd3636d7c93744290b3f5b52b8705484c18630c6fe173548
  signature_artifact:
    path: blueprint/theorem_cards/IMP-001-signatures-R6.md
    artifact_id: SIG-IMP-001-R6-P2
    sha256: 0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d
  work_packet:
    path: review/work_packets/IMP-001.yaml
    packet_revision: 1
    sha256: e0f16a660417d967312df0f7cc7ce12ea1243226801b409475548566d594796b
  binding_rule: >-
    All four bound artifacts remain unchanged. This companion supplies only
    the later analytic regression evidence required by the frozen packet and
    neither revises nor authorizes any public target.

structural_circularity_review:
  applicability: not_applicable
  inapplicable_reason: >-
    This companion adds no public declaration, project dependency, source
    reachability claim, chosen improper-integral value, or target hypothesis.
    It proves source-free nonpublic examples against the already frozen public
    interface. The packet still requires at least two fresh independent
    mathematical reviews of this companion before any such regression is
    formalized.
  required_perspectives: []

supersedes: null
---

# IMP-001 analytic regression companion

## Status, scope, and exact boundary

This revision is the intrinsically complete frozen natural-language analytic
support requested by the `later_mathematical_regression_authorization` clause
of the frozen IMP-001 work packet. Its author status is
`proof_status: complete`, while its lifecycle status remains
`artifact_state: frozen`: its exact bytes are frozen pending independent
review, and it claims no approval or authorization to write the new
regressions in Lean. At least two fresh independent reviewers must rederive
the mathematics before any regression whose new mathematics is supplied here
is written in Lean.

The companion proves exactly the analytic content needed by IMP-R04, IMP-R05,
IMP-R06, the abstract type-shape version of IMP-R07, IMP-R11, the endpoint-law
part of IMP-R12, the nondifferentiable-example part of IMP-R13, IMP-R22, and
IMP-R24. The already reviewed target proof owns the private \(a=b\) and \(h=0\)
algebra in IMP-R13; this companion does not duplicate it. It does not address
the remaining implementation-shape regressions, which require no new analytic
example.

There are **no public target bindings**. Every proposed theorem supported here
belongs in a nonpublic regression file. None may become a ninth public IMP
declaration, a constructor or eliminator for a private representation, or a
new premise of T01--T08.

## Exact regression map

| Regression | Exact mathematical conclusion proved here | Public target tested |
|---|---|---|
| `IMP-R04` | The compactly cut off \(1/(t-c)\) model has symmetric principal value \(0\), but its two one-sided component integrals diverge and therefore no T01 value exists. | T01 independent endpoints |
| `IMP-R05` | The compactly cut off \(\sin(1/(t-c))/(t-c)\) model has two independent finite sides, satisfies T01 at an exact limit-defined value, has an explicit T05 primitive, and is not locally \(L^1\) across \(c\). | T01 and T05 conditional finite singularities |
| `IMP-R06` | The exact tail \(t\mapsto\sin t/t\) from \(1\) satisfies T01 for the empty exceptional set at its Dirichlet limit but is not `IntegrableOn` the ray. | T01 is weaker than absolute integrability |
| `IMP-R07` | For empty \(S\), T01 projects an `IntervalIntegrable` witness for every truncation; a totalized integral equality cannot replace that field. | T01 type shape and totalization resistance |
| `IMP-R11` | A specified discontinuous componentwise primitive satisfies every weakened component law and both exponential tail conditions, yet the T06 value is wrong by \(e^{-1}>0\). | T05 continuity is essential |
| `IMP-R12` | A compactly supported endpoint-matching function for \(g=0\) violates the all-intermediate increment law, and the Abel identity fails by a strictly positive integral. | T05 increment law is not endpoint-only |
| `IMP-R13` | A clipped-ramp primitive of an interval indicator is T05, bounded, eventually constant, and nondifferentiable; for every \(h>0\), T06 applies at an explicitly evaluated value. | no derivative premise on \(F\) |
| `IMP-R22` | A translated \(e^{-u}/\sqrt u\) endpoint singularity is positive and \(L^1\), hence accepted, while a one-sided copy of the conditional cutoff has a finite ordinary endpoint limit but is non-\(L^1\) and rejected. | initial endpoint is locally Bochner integrable |
| `IMP-R24` | Changing an arbitrary Banach-valued integrand on the entire finite set \(\{k\}\cup S\) preserves T01, the T07 premise and value, every fixed-\(F\) T05 statement, and both sides of T08. | full finite endpoint null invariance |

These are audit regressions with `coverage_class: audit_only`. They earn no
source occurrence coverage and make no claim of mathematical novelty.

## Source and named-object reconciliation

Not applicable. IMP-001 and this companion are source-free infrastructure.
The symbols introduced below are packet-local test functions, not Olver
entities or named source objects. No source snapshot, branch convention,
asymptotic normalization, or exceptional value is consumed.

## Standing assumptions and quantifier ledger

All scalar examples use real Lebesgue volume and ordinary Mathlib Bochner
integrals. The null-invariance theorem additionally allows a complete normed
real vector space \(E\).

| ID | Binder/data | Type and range | Quantifier position | Depends on | Role |
|---|---|---|---:|---|---|
| `REG-D01` | \(c\) | real | outermost in R04/R05 | nothing | finite exceptional point |
| `REG-D02` | \(k_c=c-2\) | real | determined by \(c\) | `REG-D01` | regular start with one unit of zero padding |
| `REG-D03` | \(\chi\) | \(\mathbb R\to\mathbb R\) | fixed once | nothing | exact compact cutoff |
| `REG-D04` | \(L_D\) | real | uniquely characterized after the Dirichlet proof | nothing | limit of \(\int_1^B\sin u/u\,du\) |
| `REG-D05` | \(L_Q\) | real | uniquely characterized after `REG-D04` | `REG-D03`, `REG-D04` | limit for the cut-off reciprocal oscillation |
| `REG-D06` | \(\delta\) | \(0<\delta<1\) | local truncation variable | relevant center | endpoint/PV cutoff |
| `REG-D07` | \(A,B\) | \(1\le A\le B\) | universal in the base lemma | nothing | Dirichlet tail bounds |
| `REG-D08` | \(k\) | real | outermost in R22/R24 | nothing | initial endpoint |
| `REG-D09` | \(h\) | \(0<h\) | universal in R13 | nothing | exponential weight |
| `REG-D10` | \(S\) | `Finset ℝ` | after \(k\) in R24 | `REG-D08` | endpoint-update set |
| `REG-D11` | \(E\) | complete normed real vector space | outermost in R24 | nothing | arbitrary T01/T05/T07 codomain |
| `REG-D12` | \(f,\widetilde f\) | \(\mathbb R\to E\) | after \(E,k,S\) | `REG-D10`, `REG-D11` | functions equal off the finite endpoint set |
| `REG-D13` | \(I,F\) | \(E\), \(\mathbb R\to E\) | after integrands | all preceding data | proposed value and fixed primitive |

No example depends on a truncation order. \(L_D\) and \(L_Q\) are not opaque
choices: the Cauchy estimates below prove existence, and Hausdorff uniqueness
characterizes each value. A Lean regression may bind them by an existential
theorem rather than define global constants.

## Exact test functions and behavior outside their active domains

Define the continuous even cutoff

\[
 \chi(x)=\max(1-x^2,0).
 \tag{REG.1}
\]

Thus \(\chi(x)=1-x^2\) for \(|x|<1\), \(\chi(\pm1)=0\), and
\(\chi(x)=0\) for \(|x|>1\). Its topological support is exactly
\([-1,1]\).

For a center \(c\), put \(x=t-c\) and define, at **every** real \(t\),

\[
 p_c(t)=
 \begin{cases}
   0,&x=0,\\
   \chi(x)/x,&x\ne0,
 \end{cases}
 \qquad
 q_c(t)=
 \begin{cases}
   0,&x=0,\\
   \chi(x)\sin(1/x)/x,&x\ne0.
 \end{cases}
 \tag{REG.2}
\]

Both vanish outside \([c-1,c+1]\), vanish at \(c-1,c,c+1\),
and have topological support exactly \([c-1,c+1]\). The function \(p_c\)
is odd about \(c\); \(q_c\) is even about \(c\).

For the infinite-tail example define

\[
 d(t)=\begin{cases}0,&t<1,\\ \sin t/t,&t\ge1.\end{cases}
 \tag{REG.3}
\]

The value at \(1\) is \(\sin 1\); \(d\) vanishes on
\((-\infty,1)\), and its topological support is \([1,\infty)\) despite
its discrete zero set.

For the positive initial-endpoint example, for arbitrary \(k\), define

\[
 s_k(t)=\begin{cases}
 0,&t\le k,\\
 e^{-(t-k)}/\sqrt{t-k},&t>k.
 \end{cases}
 \tag{REG.4}
\]

It is zero on \((-\infty,k]\), strictly positive on \((k,\infty)\), and
has topological support \([k,\infty)\). For the negative initial-endpoint
example define

\[
 n_k(t)=\begin{cases}q_k(t),&t>k,\\0,&t\le k.\end{cases}
 \tag{REG.5}
\]

It is zero off \((k,k+1)\), is assigned zero at both \(k\) and \(k+1\),
and has topological support \([k,k+1]\).

The R11 discontinuous primitive and zero integrand are

\[
 g_J(t)=0,\qquad
 F_J(t)=\begin{cases}0,&t\le1,\\1,&t>1.\end{cases}
 \tag{REG.6}
\]

The ordinary function support of \(g_J\) is empty. The function \(F_J\)
vanishes on \((-\infty,1]\), is nonzero on \((1,\infty)\), and therefore
has topological support \([1,\infty)\); the specified value is \(F_J(1)=0\).

The R12 endpoint-only candidate is

\[
 g_B(t)=0,\qquad
 F_B(t)=\begin{cases}t(1-t),&0\le t\le1,\\0,&t<0\text{ or }t>1.
 \end{cases}
 \tag{REG.7}
\]

It is continuous on all of \(\mathbb R\), is zero at both support endpoints,
and has topological support \([0,1]\).

Finally define the R13 indicator and clipped ramp by

\[
 g_I(t)=\begin{cases}1,&1\le t\le2,\\0,&t<1\text{ or }t>2,\end{cases}
 \qquad
 F_I(t)=\min(\max(t-1,0),1).
 \tag{REG.8}
\]

Equivalently, \(F_I=0\) on \((-\infty,1]\), \(F_I=t-1\) on
\((1,2)\), and \(F_I=1\) on \([2,\infty)\). Endpoint values of \(g_I\)
are explicitly one; they do not affect any Lebesgue integral. The support of
\(g_I\) is \([1,2]\). The function \(F_I\) vanishes on \((-\infty,1]\),
is nonzero on \((1,\infty)\), and has topological support \([1,\infty)\).

## Pinned dependency ledger

The following declarations exist at the bound Mathlib revision. They are
implementation aids, not additional public IMP dependencies. A regression
file may import their defining Mathlib modules directly; none is to be added
to a production IMP module merely for transitive availability.

| ID | Exact declaration | Defining import | Exact use |
|---|---|---|---|
| `REG-M01` | `intervalIntegral.integral_mul_deriv_eq_deriv_mul_of_hasDerivAt` | `Mathlib.MeasureTheory.Integral.IntervalIntegral.IntegrationByParts` | derive the Dirichlet identity without invoking an unbound convergence theorem |
| `REG-M02` | `intervalIntegral.integral_comp_mul_deriv` | same import | justify the reciprocal and translation substitutions on compact intervals bounded away from zero |
| `REG-M03` | `intervalIntegral.integral_eq_sub_of_hasDerivAt_of_le` | `Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus` | evaluate logarithmic, power, ramp, and exponential finite integrals |
| `REG-M04a` | `Real.hasDerivAt_sin`, `Real.hasDerivAt_cos` | `Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv` | derivatives used in REG-I01 |
| `REG-M04b` | `Real.hasDerivAt_exp` | `Mathlib.Analysis.SpecialFunctions.ExpDeriv` | exponential derivatives in R11--R13 |
| `REG-M04c` | `Real.hasDerivAt_log` | `Mathlib.Analysis.SpecialFunctions.Log.Deriv` | logarithmic antiderivative in R04 |
| `REG-M05` | `exp_neg_integrableOn_Ioi` | `Mathlib.MeasureTheory.Integral.ExpDecay` | exponential tails in R11 and R13 |
| `REG-M06` | `Real.GammaIntegral_convergent`, `Real.Gamma_eq_integral`, and `Real.Gamma_pos_of_pos` | `Mathlib.Analysis.SpecialFunctions.Gamma.Basic` | direct integrability, exact value, and positivity for the translated square-root example |
| `REG-M07a` | `intervalIntegrable_congr_ae` and `intervalIntegral.integral_congr_ae` | `Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic` | compact-interval integrability and integral invariance under endpoint updates |
| `REG-M07b` | `integrableOn_congr_fun_ae` | `Mathlib.MeasureTheory.Integral.IntegrableOn` | open-ray integrability invariance under endpoint updates |
| `REG-M07c` | `setIntegral_congr_ae` | `Mathlib.MeasureTheory.Integral.Bochner.Set` | open-ray set-integral equality under endpoint updates |
| `REG-M08` | `Set.Finite.measure_zero` | `Mathlib.MeasureTheory.Measure.Typeclasses.NullSingletonClass` | the set \(\{k\}\cup S\) has volume zero |
| `REG-M09` | `intervalIntegral.integral_undef` | `Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic` | R07 totalization guard |
| `REG-M10` | `MeasureTheory.setIntegral_pos_iff_support_of_nonneg_ae` | `Mathlib.MeasureTheory.Integral.Bochner.Set` | positivity in R12 and R22 |
| `REG-M11` | `Real.tendsto_log_nhdsGT_zero` | `Mathlib.Analysis.SpecialFunctions.Log.Basic` | the two logarithmic one-sided divergences in R04 |
| `REG-M12` | `Real.tendsto_exp_atBot` | `Mathlib.Analysis.SpecialFunctions.Exp` | exponential boundary limits in R11--R13 |
| `REG-M13` | `Real.strictMonoOn_sin`, `Real.sin_pi_div_six`, `Real.sin_pi_sub`, and `Real.sin_add_nat_mul_pi` | `Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic` | the lower bound on each harmonic-test interval in REG-I03 |
| `REG-N01` | T01, T05, and T08 proofs at `target-imp-001-t01`, `target-imp-001-t05`, and `target-imp-001-t08` in `NLP-IMP-001-R7` | frozen artifact SHA-256 `941ca0f2a7e402e9dd3636d7c93744290b3f5b52b8705484c18630c6fe173548` | interpret the examples against the exact relation and primitive semantics |
| `REG-N02` | T06 proof at `target-imp-001-t06` in `NLP-IMP-001-R7` | same frozen artifact and digest | apply the exact exponential-composition conclusion in R13 |
| `REG-N03` | T07 proof at `target-imp-001-t07` in `NLP-IMP-001-R7` | same frozen artifact and digest | pass honest Ioi integrability to T01 in R22 |

`REG-N01`--`REG-N03` are bound natural-language mathematical inputs, not
citations to the concurrently developed or any future production Lean code.
The elementary harmonic-series divergence, the two Cauchy estimates, all
piecewise identities, and every example theorem are proved internally below.
No future LMLF work item is a dependency.

## Reusable Dirichlet and non-\(L^1\) base proof

This section is the single analytic base used by R05, R06, and the negative
half of R22.

### `REG-I01` -- exact integration-by-parts identity

For \(1\le A\le B\), set

\[
 D(A,B)=\int_A^B\frac{\sin u}{u}\,du.
\]

On \([A,B]\), the functions involved are continuously differentiable and

\[
 \frac{d}{du}\left(-\frac{\cos u}{u}\right)
 =\frac{\sin u}{u}+\frac{\cos u}{u^2}.
\]

Integrating this equality and rearranging gives the exact identity

\[
 D(A,B)=\frac{\cos A}{A}-\frac{\cos B}{B}
          -\int_A^B\frac{\cos u}{u^2}\,du.
 \tag{REG.9}
\]

There is no improper step here: \(A\ge1\) keeps every denominator nonzero,
and all three integrands are continuous on the compact interval. Using
\(|\cos u|\le1\) and
\(\int_A^B u^{-2}du=A^{-1}-B^{-1}\),

\[
 |D(A,B)|
 \le A^{-1}+B^{-1}+(A^{-1}-B^{-1})
 =\frac2A.
 \tag{REG.10}
\]

### `REG-I02` -- Cauchy limit at infinity

Let \(H(R)=\int_1^R\sin u/u\,du\). Given \(\varepsilon>0\), choose
\(A\ge\max(1,4/\varepsilon)\). For \(R,S\ge A\), suppose first
\(R\le S\). Adjacent-interval additivity and REG.10 give

\[
 |H(S)-H(R)|=|D(R,S)|\le2/R\le2/A\le\varepsilon/2<\varepsilon.
\]

If \(S<R\), interchange them; the absolute difference is unchanged. Thus the
atTop net \(H\) is Cauchy. Completeness of \(\mathbb R\) supplies a real
number \(L_D\) such that

\[
 \int_1^R\frac{\sin u}{u}\,du\longrightarrow L_D
 \quad(R\to+\infty).
 \tag{REG.11}
\]

Hausdorff uniqueness makes \(L_D\) unique. This is the only meaning of the
symbol \(L_D\); no special-function evaluation is assumed.

### `REG-I03` -- divergence of the absolute integral

For every integer \(n\ge1\), let

\[
 J_n=[n\pi+\pi/6,\ n\pi+5\pi/6].
\]

The intervals \(J_n\) have pairwise disjoint interiors. To derive the needed
sine bound, `Real.strictMonoOn_sin` on
\([-\pi/2,\pi/2]\) and `Real.sin_pi_div_six` give
\(\sin\theta\ge\sin(\pi/6)=1/2\) for
\(\pi/6\le\theta\le\pi/2\). For
\(\pi/2\le\theta\le5\pi/6\), `Real.sin_pi_sub`,
\(\sin\theta=\sin(\pi-\theta)\), reduces to the first interval. Writing
\(u=n\pi+\theta\), `Real.sin_add_nat_mul_pi` gives
\(\sin u=(-1)^n\sin\theta\), hence
\(|\sin u|\ge1/2\) on \(J_n\). Also
\(u\le(n+1)\pi\) there. Hence

\[
 \int_{J_n}\frac{|\sin u|}{u}\,du
 \ge \frac12\frac{|J_n|}{(n+1)\pi}
 =\frac1{3(n+1)}.
 \tag{REG.12}
\]

For \(N\ge1\), positivity and disjointness therefore give

\[
 \int_1^{(N+1)\pi}\frac{|\sin u|}{u}\,du
 \ge\sum_{n=1}^{N}\frac1{3(n+1)}.
 \tag{REG.13}
\]

The right side is unbounded without any analytic black box. For each
\(j\ge1\), the block \(2^j\le n+1<2^{j+1}\) corresponds to
\(n=2^j-1,\ldots,2^{j+1}-2\), all of which satisfy \(n\ge1\). It has
\(2^j\) terms, and each actual summand \(1/(3(n+1))\) is at least
\(1/(3\cdot2^{j+1})\). Hence every such block contributes at least
\(1/6\), and the first \(m\) blocks, \(j=1,\ldots,m\), contribute at
least \(m/6\). Consequently

\[
 u\mapsto\sin u/u\quad\text{is not `IntegrableOn` }(1,\infty).
 \tag{REG.14}
\]

This proves nonintegrability rather than merely observing sign changes:
Bochner integrability of a real function entails finiteness of the integral of
its norm, which here is the absolute value contradicted by REG.13.

### `REG-I04` -- cutoff correction and its Cauchy limit

For \(1\le A\le B\), define

\[
 C(A,B)=\int_A^B\frac{\sin u}{u^3}\,du.
\]

It is absolutely controlled by

\[
 |C(A,B)|\le\int_A^B u^{-3}du
 =\frac1{2A^2}-\frac1{2B^2}\le\frac1{2A^2}.
 \tag{REG.15}
\]

Thus \(C(1,B)\) is Cauchy atTop. Combining REG.10 and REG.15 shows that

\[
 Q(B)=\int_1^B(1-u^{-2})\frac{\sin u}{u}\,du
 \tag{REG.16}
\]

is Cauchy, with the explicit tail bound

\[
 |Q(B)-Q(A)|\le\frac2A+\frac1{2A^2}
 \quad(1\le A\le B).
 \tag{REG.17}
\]

Let \(L_Q\) be its unique finite limit.

For \(u\ge\sqrt2\), \(1-u^{-2}\ge1/2\). Therefore

\[
 (1-u^{-2})\frac{|\sin u|}{u}
 \ge\frac12\frac{|\sin u|}{u}.
\]

REG.13 then proves

\[
 \int_1^B(1-u^{-2})\frac{|\sin u|}{u}\,du\to+\infty.
 \tag{REG.18}
\]

So the cutoff-tail limit is conditional and not absolute.

## Measurability and compact regular-piece lemma

The cutoff \(\chi\) is continuous. Away from a center \(c\), the reciprocal,
sine, multiplication, and division operations in REG.2 are continuous.
Assigning a value at the singleton \(\{c\}\), and using zero outside the Borel
set \([c-1,c+1]\), preserves Borel measurability. Thus \(p_c\) and \(q_c\)
are strongly measurable as real-valued functions. The functions
\(d,s_k,n_k,F_J,F_B,g_I,F_I\) are likewise piecewise continuous across finitely many
Borel pieces, hence Borel and strongly measurable.

If a compact interval \(K\) has positive distance from \(c\), then \(p_c\) and
\(q_c\) are bounded on \(K\): the denominator is bounded below and every
other factor is bounded. A bounded strongly measurable function on a finite-
measure compact interval is Bochner integrable. This proves every regular-
piece `IntervalIntegrable` proposition used in R04 and R05, including pieces
crossing a cutoff endpoint \(c\pm1\). The point discontinuities of \(d,g_I\)
and the endpoint values of all examples are also harmless by finite-set nullity.

## Exact substitutions

For \(0<\delta<1\), translation \(x=t-c\), followed on the positive side by
\(u=1/x\), has differential \(dx=-u^{-2}du\). Direct substitution gives

\[
 \int_{c+\delta}^{c+1}q_c(t)\,dt
 =\int_{\delta}^{1}(1-x^2)\frac{\sin(1/x)}x\,dx
 =\int_1^{1/\delta}(1-u^{-2})\frac{\sin u}{u}\,du.
 \tag{REG.19}
\]

Because \(q_c(c-x)=q_c(c+x)\), the orientation change \(x=c-t\) gives the
identical left-side formula

\[
 \int_{c-1}^{c-\delta}q_c(t)\,dt
 =\int_1^{1/\delta}(1-u^{-2})\frac{\sin u}{u}\,du.
 \tag{REG.20}
\]

Replacing the integrand by its absolute value yields exactly the expression
in REG.18, not merely an inequality. These compact substitutions are justified
before taking a limit; every transformed integrand is continuous on the
finite interval \([1,1/\delta]\).

For R22, the translation \(u=t-k\) preserves Lebesgue measure and maps
\((k,\infty)\) to \((0,\infty)\):

\[
 \int_{(k,\infty)}s_k(t)\,dt
 =\int_{(0,\infty)}e^{-u}u^{-1/2}\,du.
 \tag{REG.21}
\]

On \(u>0\), \(u^{-1/2}=1/\sqrt u\). This is the Gamma integrand with
parameter \(1/2\). The convergence theorem in `REG-M06` proves honest
integrability, `Real.Gamma_eq_integral` proves that its integral is
\(\Gamma(1/2)\), and `Real.Gamma_pos_of_pos` proves
\(\Gamma(1/2)>0\). No value at \(u=0\) enters the set integral.

## Analytic side-condition ledger

| ID | Exact proposition | Used by | Proof/dependency | Status |
|---|---|---|---|---|
| `REG-A01` | \(c-2<c\) and \(c\in\{c\}\) lies strictly above the chosen start | R04/R05 | real arithmetic | discharged |
| `REG-A02` | \(p_c,q_c\) are strongly measurable | R04/R05 | piecewise-Borel argument above | discharged |
| `REG-A03` | \(p_c,q_c\) are interval integrable on every compact regular piece avoiding \(c\) | R04/R05 | compact boundedness lemma above | discharged |
| `REG-A04` | all reciprocal substitutions occur on \([\delta,1]\) with \(\delta>0\) | R05/R22-negative | REG.19--REG.20 | discharged |
| `REG-A05` | the Dirichlet and cutoff tails are Cauchy with explicit moduli | R05/R06/R22-negative | REG.10 and REG.17 | discharged |
| `REG-A06` | the absolute Dirichlet and cutoff integrals diverge | R05/R06/R22-negative | REG.12--REG.18 | discharged |
| `REG-A07` | \(s_k\) is strongly measurable and `IntegrableOn` \((k,\infty)\) | R22-positive | REG.21 and `REG-M06` | discharged |
| `REG-A08` | \(\int_{(k,\infty)}s_k>0\) | R22-positive | REG.21 and `REG-M06` | discharged |
| `REG-A09` | \(e^{-t}F_J(t)\) is integrable on \((0,\infty)\) and tends pointwise to zero at infinity | R11 | exact piecewise formula plus `REG-M05` | discharged |
| `REG-A10` | \(e^{-ht}F_B(t)>0\) on \((0,1)\) for \(h>0\) and is interval integrable | R12 | continuity, positivity, `REG-M10` | discharged |
| `REG-A11` | \(F_I\) is continuous, bounded by one, and eventually constant | R13 | exact clipped-ramp formula | discharged |
| `REG-A12` | \(e^{-ht}F_I(t)\) is integrable on \((0,\infty)\) and tends to zero for \(h>0\) | R13 | domination by \(e^{-ht}\), `REG-M05` | discharged |
| `REG-A13` | \(\{k\}\cup S\) has volume zero | R24 | `REG-M08` | discharged |
| `REG-A14` | finite endpoint changes give a.e. equality under every interval/ray restriction | R24 | `REG-A13` | discharged |

## Exact identity, estimate, and loss ledger

No regression weakens a constant. The inequalities are evidence for
convergence, divergence, or positivity rather than public estimates.

| ID | Expression before | Applied fact | Side conditions | Expression after | Kind |
|---|---|---|---|---|---|
| `REG-L01` | \(D(A,B)\) | integration by parts REG.9 | \(1\le A\le B\) | \(|D(A,B)|\le2/A\) | exact natural tail bound |
| `REG-L02` | \(\int_A^B\sin u/u^3\) | \(|\sin u|\le1\) and power FTC | \(1\le A\le B\) | at most \(1/(2A^2)\) in norm | exact natural tail bound |
| `REG-L03` | cutoff tail \(Q(B)-Q(A)\) | `REG-L01` + `REG-L02` | \(1\le A\le B\) | at most \(2/A+1/(2A^2)\) | exact natural bound |
| `REG-L04` | \(\int_{J_n}|\sin u|/u\) | sine lower bound and endpoint maximum | \(n\ge1\) | at least \(1/(3(n+1))\) | explicit divergence bound |
| `REG-L05` | cutoff absolute tail | \(1-u^{-2}\ge1/2\) | \(u\ge\sqrt2\) | at least half the base absolute tail | explicit divergence transfer |
| `REG-L06` | square-root set integral | translation and Gamma identity | \(u>0\) | \(\Gamma(1/2)>0\) | exact value and sign |
| `REG-L07` | \(e^{-ht}F_I(t)\) | \(0\le F_I\le1\) | \(t\ge0,h>0\) | bounded by \(e^{-ht}\) | integrability/limit domination |
| `REG-L08` | endpoint-modified integral | a.e. congruence off a finite null set | finite \(S\) | identical interval and set integrals | exact |

<a id="regression-imp-r04"></a>
## IMP-R04 -- principal-value-only cancellation is rejected

Fix \(c\in\mathbb R\), take \(k=c-2\), \(S=\{c\}\), and use \(p_c\) from
REG.2. On \(0<|x|<1\),

\[
 p_c(c+x)=\frac{1-x^2}{x}=\frac1x-x.
\]

An antiderivative on either punctured side is
\(\log|x|-x^2/2\). Thus, for \(0<\delta<1\),

\[
 \int_{c-1}^{c-\delta}p_c(t)\,dt
 =\log\delta+\frac{1-\delta^2}{2}\longrightarrow-\infty,
 \tag{REG.22}
\]

\[
 \int_{c+\delta}^{c+1}p_c(t)\,dt
 =-\log\delta-\frac{1-\delta^2}{2}\longrightarrow+\infty.
 \tag{REG.23}
\]

The zero padding on \([c-2,c-1]\) and \([c+1,\infty)\) changes neither
formula. Each finite truncation bounded away from \(c\) is honestly interval
integrable by `REG-A03`.

Adding REG.22 and REG.23 gives exactly zero for every \(\delta\), hence

\[
 \int_{c-1}^{c-\delta}p_c+
 \int_{c+\delta}^{c+1}p_c\longrightarrow0.
 \tag{REG.24}
\]

This is a genuine symmetric Cauchy principal value. Nevertheless, the first
T01 component requires the left expression to tend to a finite real value,
and the tail component requires the right expression to tend to a finite real
value independently. REG.22 and REG.23 contradict both requirements. Hence

\[
 \forall I\in\mathbb R,\quad
 \neg\operatorname{HasImproperIntegralAtTopExcept}
       (p_c,c-2,\{c\},I),
 \tag{REG.25}
\]

while REG.24 records the nearby false PV semantics. The example does not rely
on a nonintegrable regular truncation or Mathlib totalization.

<a id="regression-imp-r05"></a>
## IMP-R05 -- a genuinely conditional finite singularity is accepted

Use \(q_c\), \(k=c-2\), and \(S=\{c\}\). By REG.19--REG.20 and the
definition of \(L_Q\), both independent one-sided integrals tend to \(L_Q\):

\[
 \int_{c-2}^{c-\delta}q_c(t)dt\longrightarrow L_Q,
 \qquad
 \int_{c+\delta}^{c+1}q_c(t)dt\longrightarrow L_Q.
 \tag{REG.26}
\]

The first equality uses that \(q_c=0\) on \([c-2,c-1]\). Choosing the final
component anchor \(c+1\), its atTop integral is identically zero. All regular
truncations are interval integrable by `REG-A03`; \(c>c-2\); and the exact
component sum is \(L_Q+(L_Q+0)=2L_Q\). Therefore

\[
 \operatorname{HasImproperIntegralAtTopExcept}
      (q_c,c-2,\{c\},2L_Q).
 \tag{REG.27}
\]

For a direct T05 witness, define \(P_c:\mathbb R\to\mathbb R\) everywhere by

\[
 P_c(t)=
 \begin{cases}
 0,&t\le c-1,\\
 \int_{c-1}^{t}q_c(v)dv,&c-1<t<c,\\
 L_Q,&t=c,\\
 2L_Q-\int_t^{c+1}q_c(v)dv,&c<t<c+1,\\
 2L_Q,&t\ge c+1.
 \end{cases}
 \tag{REG.28}
\]

At \(c-1\) and \(c+1\), ordinary compact integral continuity makes adjacent
formulas agree. At \(c\), REG.26 makes both one-sided limits equal \(L_Q\),
so \(P_c\) is continuous. It is zero at \(k=c-2\). Any closed interval in
\([c-2,\infty)\) disjoint from \(\{c\}\) lies wholly on one side of \(c\).
On each side, adjacent-interval additivity applied to REG.28 gives

\[
 P_c(b)-P_c(a)=\int_a^bq_c(t)dt,
\]

with the integrability supplied by `REG-A03`. Consequently

\[
 \operatorname{IsFiniteExceptionalPrimitive}
      (q_c,c-2,\{c\},P_c),
 \qquad P_c(t)\longrightarrow2L_Q.
 \tag{REG.29}
\]

The endpoint limit in REG.29 is immediate because \(P_c=2L_Q\) on
\([c+1,\infty)\), and T08 reverse independently recovers REG.27.

For nonabsolute behavior, the reciprocal substitution with absolute values
is REG.18. Hence each one-sided absolute integral adjacent to \(c\) is
infinite. More strongly, for every \(\eta>0\), choose
\(0<r<\min(\eta,1/\sqrt2)\). The absolute integral over
\((c-r,c+r)\) already contains a reciprocal tail on which REG.18 diverges.
Thus

\[
 \forall\eta>0,\quad
 \neg\operatorname{IntegrableOn}
    (q_c,(c-\eta,c+\eta)).
 \tag{REG.30}
\]

REG.27 and REG.30 together are the exact regression: conditional convergence
at a marked finite singularity is accepted without laundering it into local
Bochner integrability across that singularity.

<a id="regression-imp-r06"></a>
## IMP-R06 -- conditional convergence at infinity is not strengthened

Use \(d\) from REG.3, start \(k=1\), and \(S=\varnothing\). For every
\(R\ge1\), \(d\) is continuous on \([1,R]\), hence interval integrable, and

\[
 \int_1^R d(t)dt=H(R)\longrightarrow L_D
\]

by REG.11. The empty-list clause of T01 therefore gives

\[
 \operatorname{HasImproperIntegralAtTopExcept}
       (d,1,\varnothing,L_D).
 \tag{REG.31}
\]

On \((1,\infty)\), \(d(t)=\sin t/t\), so REG.14 gives

\[
 \neg\operatorname{IntegrableOn}(d,(1,\infty)).
 \tag{REG.32}
\]

The totalized set integral of \(d\) is therefore not asserted to equal
\(L_D\), and T07 cannot be invoked. This proves precisely that T01's empty-set
ordinary-improper semantics is not silently strengthened to absolute
integrability.

<a id="regression-imp-r07"></a>
## IMP-R07 -- abstract projection defeats totalization

The packet permits an abstract type-shape regression, so no extra concrete
nonintegrable function is needed. Simplify the public T01 definition in the
nonpublic regression file at \(S=\varnothing\). Its empty-break semantics is
exactly the conjunction

\[
 \left(\forall b,\ k\le b\longrightarrow
   \operatorname{IntervalIntegrable}(f,[k,b])\right)
 \ \wedge\
 \operatorname{Tendsto}
   \left(b\mapsto\int_k^b f\right)\mathrm{atTop}\,(\mathcal N I).
\]

Therefore the exact positive projection is

\[
 \operatorname{HasImproperIntegralAtTopExcept}(f,k,\varnothing,I)
 \Longrightarrow
 \forall b\ge k,
   \operatorname{IntervalIntegrable}(f,[k,b]).
 \tag{REG.33}
\]

This theorem is polymorphic in every complete normed real vector space and
does not name a private helper. It tests the public proposition's field shape,
not a particular implementation constructor.

For the negative guard, `REG-M09` states that if
\(f\) is not interval integrable on \([k,b]\), Mathlib's totalized expression
\(\int_k^b f\) is nevertheless assigned zero. Thus an equality
\(\int_k^b f=0\), or even convergence of a family of such totalized values,
does not entail the left conjunct of REG.33. The negative elaboration test
supplies only a limit/equality hypothesis and must fail exactly at the missing
`IntervalIntegrable` field. This abstract projection is sufficient for the
packet's exact R07 row and avoids introducing unrelated counterexample
mathematics.

<a id="regression-imp-r11"></a>
## IMP-R11 -- a discontinuous componentwise primitive cannot telescope

Take \(k=0\), \(S=\{1\}\), and \(g_J,F_J\) from REG.6. The exceptional point
lies above the start and \(F_J(0)=0\). If \(0\le a\le b\) and
\([a,b]\cap\{1\}=\varnothing\), connectedness of the interval implies either
\(b<1\) or \(1<a\). In either case \(F_J\) is constant on \([a,b]\), so

\[
 F_J(b)-F_J(a)=0=\int_a^b g_J(t)dt,
 \tag{REG.34}
\]

and \(g_J\) is interval integrable. Thus every T05 clause except continuity is
satisfied. Continuity fails: \(1+1/n\to1\), while
\(F_J(1+1/n)=1\to1\ne F_J(1)=0\).

Set \(h=1\). Then

\[
 e^{-t}F_J(t)=\begin{cases}0,&t\le1,\\e^{-t},&t>1,
 \end{cases}
\]

is integrable on \((0,\infty)\), tends to zero atTop, and has exact integral

\[
 \int_{(0,\infty)}e^{-t}F_J(t)dt
 =\int_1^\infty e^{-t}dt=e^{-1}>0.
 \tag{REG.35}
\]

The value predicted by T06 after deleting continuity would therefore be
\(e^{-1}\). But the weighted integrand \(e^{-t}g_J(t)\) is identically zero.
Every T01 component integral and endpoint limit is zero, so its only T01 value
is zero. Hence

\[
 \neg\operatorname{HasImproperIntegralAtTopExcept}
   (t\mapsto e^{-t}g_J(t),0,\{1\},e^{-1}).
 \tag{REG.36}
\]

Equivalently, when the two regular-component Abel identities are added, the
one-sided boundary values at \(1\) leave the uncancelled jump
\(e^{-1}(F_J(1+)-F_J(1-))=e^{-1}\). REG.36 proves that continuity at the
exception cannot be dropped.

<a id="regression-imp-r12"></a>
## IMP-R12 -- endpoint equality is not an increment law

Use \(g_B,F_B\) from REG.7 on \([0,1]\). Both endpoint values vanish, so

\[
 F_B(1)-F_B(0)=0=\int_0^1g_B(t)dt.
 \tag{REG.37}
\]

This single endpoint equality does not extend to intermediate points. At
\(b=1/2\),

\[
 F_B(1/2)-F_B(0)=1/4\ne0=\int_0^{1/2}g_B(t)dt.
 \tag{REG.38}
\]

Thus \(F_B\) cannot populate T05 for \(g_B,k=0,S=\varnothing\).

The private Abel identity also detects the failure without appealing to its
definition. Fix \(h>0\). Its left side and both boundary terms are zero. On
\((0,1)\), however, \(t(1-t)>0\) and \(e^{-ht}>0\). Their product is
continuous and nonnegative on \([0,1]\), positive on a set of positive measure,
so `REG-M10` gives

\[
 h\int_0^1e^{-ht}F_B(t)dt>0.
 \tag{REG.39}
\]

The asserted Abel equality would read \(0=\) the strictly positive quantity
in REG.39, a contradiction. This proves that the all-\(a,b\) increment law,
not endpoint matching, is the consumed hypothesis.

<a id="regression-imp-r13"></a>
## IMP-R13 -- bounded eventually constant nondifferentiable primitive

Take \(k=0\), \(S=\varnothing\), and \(g_I,F_I\) from REG.8. The clipped ramp
is continuous, satisfies \(F_I(0)=0\), and obeys \(0\le F_I\le1\). For every
\(0\le a\le b\), split \([a,b]\) at any of \(1,2\) which it crosses. On a
piece left of \(1\), both the increment and integral are zero; on a piece
inside \([1,2]\), both equal its oriented length; on a piece right of \(2\),
both are zero. Adjacent additivity then gives, in all configurations,

\[
 F_I(b)-F_I(a)=\int_a^b g_I(t)dt.
 \tag{REG.40}
\]

The bounded Borel indicator is interval integrable on every compact interval.
Thus

\[
 \operatorname{IsFiniteExceptionalPrimitive}
      (g_I,0,\varnothing,F_I).
 \tag{REG.41}
\]

Nevertheless \(F_I\) is not differentiable at \(1\): for \(0<r<1\), the
right difference quotient is
\((F_I(1+r)-F_I(1))/r=1\), whereas for \(-1<r<0\) it is zero. The two limits
differ. The analogous left/right slopes at \(2\) are one and zero.

Now fix arbitrary \(h>0\). Since \(0\le F_I(t)\le1\) for \(t\ge0\),

\[
 0\le e^{-ht}F_I(t)\le e^{-ht}.
\]

The majorant is integrable on \((0,\infty)\), so the weighted primitive is
integrable. The same bound and \(e^{-hR}\to0\) prove
\(e^{-hR}F_I(R)\to0\). These are exactly the two T06 tail hypotheses.

For a completely explicit value, split at \(1,2\) and integrate the two
pieces:

\[
 \int_0^\infty e^{-ht}F_I(t)dt
 =\int_1^2e^{-ht}(t-1)dt+\int_2^\infty e^{-ht}dt
 =\frac{e^{-h}-e^{-2h}}{h^2}.
 \tag{REG.42}
\]

The first equality uses the exact outside-domain clauses in REG.8. The second
follows from the antiderivative
\(-e^{-ht}((t-1)/h+1/h^2)\) on \([1,2]\) and
\(-e^{-ht}/h\) on the tail. Multiplying by \(h\), T06 gives

\[
 \operatorname{HasImproperIntegralAtTopExcept}
 \left(t\mapsto e^{-ht}g_I(t),0,\varnothing,
       \frac{e^{-h}-e^{-2h}}h\right).
 \tag{REG.43}
\]

Directly, the weighted indicator is supported on \([1,2]\), and its ordinary
integral is the same quotient. The point of REG.41--REG.43 is that public T06
applies although \(F_I\) is not differentiable; no derivative premise may be
inserted. The private \(a=b\), private \(h=0\), and public \(h=0\) algebraic
regressions remain owned by the reviewed target proof and are not reproved here.

<a id="regression-imp-r22"></a>
## IMP-R22 -- positive local-\(L^1\) square root versus conditional non-\(L^1\) start

Fix \(k\in\mathbb R\). For \(s_k\), REG.21 and `REG-M06` show

\[
 \operatorname{IntegrableOn}(s_k,(k,\infty)),\qquad
 \int_{(k,\infty)}s_k(t)dt=\Gamma(1/2)>0.
 \tag{REG.44}
\]

This also has an elementary domination check: on \(0<u\le1\),
\(e^{-u}/\sqrt u\le u^{-1/2}\), whose integral is \(2\); on \(u\ge1\),
\(e^{-u}/\sqrt u\le e^{-u}\), whose integral is \(e^{-1}\). These two
bounds independently verify local integrability at the singular endpoint and
tail integrability. Positivity is not inferred from a totalized value: the
integrand is strictly positive on every interval inside \((k,\infty)\), and
REG.44 uses an honest integrability proof.

T07 with \(S=\varnothing\) therefore gives the exact accepted relation

\[
 \operatorname{HasImproperIntegralAtTopExcept}
       (s_k,k,\varnothing,\Gamma(1/2)).
 \tag{REG.45}
\]

Changing the assigned value \(s_k(k)=0\) would not change this conclusion.

For \(n_k\), take \(0<\delta<1\). Its right-endpoint truncation satisfies

\[
 \int_{k+\delta}^{k+1}n_k(t)dt=Q(1/\delta)\longrightarrow L_Q.
 \tag{REG.46}
\]

Thus the singularity has an ordinary finite one-sided improper value. But the
absolute version is exactly the divergent cutoff integral in REG.18, so

\[
 \neg\operatorname{IntervalIntegrable}(n_k,[k,k+1]),
 \qquad
 \neg\operatorname{IntegrableOn}(n_k,(k,\infty)).
 \tag{REG.47}
\]

The empty-set T01 clause requires the `IntervalIntegrable` assertion ruled out
by REG.47 for the truncation \(b=k+1\). Hence

\[
 \forall I\in\mathbb R,\quad
 \neg\operatorname{HasImproperIntegralAtTopExcept}
       (n_k,k,\varnothing,I),
 \tag{REG.48}
\]

and T07 is unavailable by the second proposition. REG.45 versus REG.48 is the
exact initial-endpoint contract: absolute local integrability, not merely a
conditional improper endpoint limit, is required at \(k\).

<a id="regression-imp-r24"></a>
## IMP-R24 -- full finite endpoint null invariance

Let \(E\) be a complete normed real vector space, fix \(k\in\mathbb R\), a
finset \(S:\mathrm{Finset}\,\mathbb R\), and functions
\(f,\widetilde f:\mathbb R\to E\).
Put

\[
 A=\{k\}\cup(S:\operatorname{Set}\mathbb R)
\]

and assume

\[
 \widetilde f(t)=f(t)\quad\text{for every }t\notin A.
 \tag{REG.49}
\]

No equality is required at \(k\) or at any member of \(S\); the new values may
be arbitrary and mutually unrelated.

The set \(A\) is finite, hence `REG-M08` gives
\(\mathrm{volume}(A)=0\). Therefore REG.49 is an almost-everywhere equality
globally and under the restriction of volume to every interval or measurable
ray. `REG-M07a` yields, for all real \(a,b\),

\[
 \operatorname{IntervalIntegrable}(f,[a,b])
 \Longleftrightarrow
 \operatorname{IntervalIntegrable}(\widetilde f,[a,b]),
 \qquad
 \int_a^b f=\int_a^b\widetilde f,
 \tag{REG.50}
\]

and, using `REG-M07b` and `REG-M07c`, on the open ray,

\[
 \operatorname{IntegrableOn}(f,(k,\infty))
 \Longleftrightarrow
 \operatorname{IntegrableOn}(\widetilde f,(k,\infty)),
 \qquad
 \int_{(k,\infty)}f=\int_{(k,\infty)}\widetilde f.
 \tag{REG.51}
\]

The integral equalities hold even if neither function is integrable, because
the Bochner integral is a.e.-congruent; REG.51's integrability equivalence is
recorded separately so the T07 use is honest.

For a fixed \(F:\mathbb R\to E\), the non-integrand clauses of T05 are the
same for \(f\) and \(\widetilde f\). On a regular interval, REG.50 preserves
both integrability and the integral on the right of the increment equation.
Thus

\[
 \operatorname{IsFiniteExceptionalPrimitive}(f,k,S,F)
 \Longleftrightarrow
 \operatorname{IsFiniteExceptionalPrimitive}(\widetilde f,k,S,F).
 \tag{REG.53}
\]

Existentially quantifying the same \(F\) and retaining the identical
\(\operatorname{Tendsto} F\,\mathrm{atTop}\,(\mathcal N I)\) clause shows the
full T08 right-hand-side invariance:

\[
 \begin{aligned}
 &\exists F,\ \operatorname{IsFiniteExceptionalPrimitive}(f,k,S,F)
              \land \operatorname{Tendsto}F\,\mathrm{atTop}\,(\mathcal N I)\\
 &\qquad\Longleftrightarrow
 \exists F,\ \operatorname{IsFiniteExceptionalPrimitive}(\widetilde f,k,S,F)
              \land \operatorname{Tendsto}F\,\mathrm{atTop}\,(\mathcal N I).
 \end{aligned}
 \tag{REG.54}
\]

Now apply the already reviewed public T08 equivalence to \(f\), use REG.54,
and apply the reverse direction of public T08 to \(\widetilde f\). For every
\(I\in E\), this gives

\[
 \begin{aligned}
 &\operatorname{HasImproperIntegralAtTopExcept}(f,k,S,I)\\
 &\quad\Longleftrightarrow
   \exists F,\ \operatorname{IsFiniteExceptionalPrimitive}(f,k,S,F)
             \land \operatorname{Tendsto}F\,\mathrm{atTop}\,(\mathcal N I)\\
 &\quad\Longleftrightarrow
   \exists F,\ \operatorname{IsFiniteExceptionalPrimitive}
                         (\widetilde f,k,S,F)
             \land \operatorname{Tendsto}F\,\mathrm{atTop}\,(\mathcal N I)\\
 &\quad\Longleftrightarrow
   \operatorname{HasImproperIntegralAtTopExcept}(\widetilde f,k,S,I).
 \end{aligned}
 \tag{REG.52}
\]

This T05--T08 chain is the normative formalization route for REG.52. It uses
only public T05 and T08 statements and does not unfold, name, or induct on the
private representation of T01. Semantically, REG.50 also explains why every
finite component integral is unchanged, but that observation is only a
cross-check, not the prescribed external-consumer proof.

Finally assume the explicit T07 domain condition \(k<c\) for every \(c\in S\)
and either side of the integrability equivalence REG.51. T07 applies to both
functions, their honest Ioi values are equal by REG.51, and their conclusions
correspond by REG.52. This proves full invariance for T01, T07, and T08 at
\(k\) and **every** exceptional point, rather than only an initial-point
special case.

## Boundary and adversarial cases

- The cutoff endpoints \(c\pm1\), the singular point \(c\), the initial point
  \(k\), and the indicator endpoints \(1,2\) all have explicit assigned
  values. Null-set invariance is proved rather than used silently.
- R04 separates a coupled symmetric limit from both one-sided limits. The
  coupled limit exists exactly and neither one-sided finite limit exists.
- R05 supplies each side independently and proves failure of every local
  \(L^1\) neighborhood across \(c\); it is not an absolutely integrable example
  disguised by notation.
- R06 uses \(S=\varnothing\) and tests the actual empty-break base semantics.
- R07 uses the exact empty-break projection and makes no claim that a
  totalized value carries integrability evidence.
- R11 chooses the discontinuity value \(F_J(1)=0\) explicitly; choosing one
  instead would merely move the mismatch to the opposite side.
- R12 uses every \(h>0\), not a numerically selected parameter, and derives
  strict positivity on a positive-measure open interval.
- R13 gives all interval configurations for the increment law and checks both
  corners of the nondifferentiable primitive. Its \(h>0\) conclusion is
  separate from the already reviewed \(h=0\) algebra.
- R22 proves both the local-\(L^1\) behavior near \(k\) and the exponential
  tail, and contrasts it with a function possessing a genuine conditional
  endpoint limit.
- R24 permits \(S=\varnothing\), arbitrary multiple-point \(S\), and arbitrary
  replacement values. If \(S\) contains a point at or below \(k\), both T01
  sides remain false for the same unchanged domain reason; the equivalence is
  still correct.

The nearby false statements are: PV convergence implies T01 (R04), T01 implies
whole-ray `IntegrableOn` (R06), totalized values imply interval integrability
(R07), componentwise increments imply Abel telescoping without continuity
(R11), endpoint equality implies all increments (R12), T05 implies
differentiability (R13), a conditional singularity may occur at the unmarked
initial endpoint (R22), and finite endpoint values affect the relations
(R24). Each is contradicted by an exact example or projection above.

## Hypothesis- and choice-laundering audit

| Item | Legitimate use | Prohibited inference avoided here |
|---|---|---|
| compact regular-piece integrability | bounded measurable functions away from the displayed singularity | no integrability through \(c\) |
| Cauchy completeness | produces \(L_D,L_Q\) from explicit moduli | no unevaluated convergence assumption |
| harmonic divergence | proves failure of norm integrability | no appeal to oscillation alone |
| Gamma convergence in R22 | concise pinned proof of an honest positive integral | no Gamma dependency in production IMP modules |
| exponential domination | discharges T06 tail hypotheses for the clipped ramp | no bound added to T05 |
| endpoint-only hypotheses in R11/R12 | deliberately weakened adversarial premises | never passed off as T05 |
| finite-set nullity | transfers integrals and integrability by a.e. equality | no claim that behavior approaching an endpoint is irrelevant |
| existential limit values | local notation for uniquely characterized limits | no public value function or `Classical.choose` API |

The examples fix their functions once and for all; no function is selected
depending on an order, endpoint truncation, or desired conclusion. R24 uses
arbitrary supplied replacement values rather than choosing them. No source,
model estimate, or downstream QL/OLV assertion is smuggled into an IMP premise.

## Regression obligations and proposed nonpublic theorem content

After this artifact is frozen and receives the packet-required two fresh
independent approvals, a nonpublic regression file may formalize exactly:

1. REG.25 together with the symmetric PV identity REG.24 (`IMP-R04`).
2. REG.27, REG.29, and REG.30 (`IMP-R05`).
3. REG.31 and REG.32 (`IMP-R06`).
4. The polymorphic projection REG.33 and a negative elaboration test missing
   its `IntervalIntegrable` input (`IMP-R07`).
5. REG.34--REG.36 (`IMP-R11`).
6. REG.37--REG.39 (`IMP-R12`).
7. REG.41, nondifferentiability at \(1\), the two tail hypotheses, REG.42, and
   REG.43 for arbitrary \(h>0\) (`IMP-R13` analytic part only).
8. REG.44--REG.48 (`IMP-R22`).
9. REG.50--REG.54 plus the explicit two-sided T07 use (`IMP-R24`).

The reusable supporting declarations corresponding to REG-I01--REG-I04 must
remain private to the regression namespace/file. The R05, R06, and R22 proofs
must call that shared support rather than reprove Dirichlet convergence or
absolute divergence three times. The `planned_nonpublic_declaration` names in
the frontmatter are routing names for the future audit file, not additions to
the frozen production API; their exact propositions, rather than their names,
are normative. No ninth public declaration is permitted.

## Trust, intended imports, and exclusions

The intended regression-only Mathlib surface is the existing public IMP
modules plus the defining imports in `REG-M01`--`REG-M13`. In particular,
`Mathlib.Analysis.SpecialFunctions.Gamma.Basic` is permitted only in the
nonpublic R22 regression; it is not a production IMP dependency. A leaner
implementation may replace the convergence part of REG-M06 by the elementary
two-piece domination after REG.44. The exact value in REG.44 still uses
`Real.Gamma_eq_integral`, and its sign still uses
`Real.Gamma_pos_of_pos`.

All proof content is exact real analysis. Classical completeness or a local
existential witness is ordinary foundational reasoning, not an added axiom.
Future axiom reports remain governed by the frozen work packet. This artifact
contains no Lean code, generated proof, `sorry`, `admit`, axiom, or external
certificate.

The exclusions of the frozen packet remain in force: no public helper or ninth
target; no production import of QL, OLV, Watson, source, Gamma, QB, or DEF; no
principal-value API; no whole-line or two-sided-infinity API; no selected
improper-integral value function; no bound field in T05 or T08; and no
floating-point evaluation, interval arithmetic, quadrature, tolerance,
adaptive truncation, optimizer, solver, or numerical certificate.

## Author completeness and review gate

Every requested analytic regression has an exact global function definition,
support and endpoint convention, exact proposition, and complete
measurability, compact integrability, substitution, Cauchy, nonintegrability,
positivity, or a.e.-invariance argument. R07 deliberately uses the packet's
authorized abstract projection option. No mathematical gap is knowingly left
open.

The author status is `proof_status: complete`: no theorem-sized gap is known.
The lifecycle status is `artifact_state: frozen` pending independent review;
no external approval or Lean authorization is claimed. Reviewers must check in particular the signs
in REG.22--REG.23, the reciprocal Jacobian in REG.19--REG.20, the harmonic
lower bound REG.12, the exact T01 component sum in REG.27, the discontinuity
mismatch REG.35--REG.36, the explicit value REG.42, and every a.e. transport
in REG.50--REG.54. The frozen bytes and their SHA-256 may now be recorded in
external review envelopes.
