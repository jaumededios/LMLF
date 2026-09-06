# Integral and Laplace methods

**Document status:** planning blueprint; no packet in this file is authorized for Lean  
**Scope:** real-half-line vector and complex integrals, exact exponential
moments, finite Laplace remainders, and the deliberately narrow Watson source path
**Out of scope here:** oscillatory and contour arguments (see
`oscillatory_contour.md`), summation, ODE stability, named-function
construction, numerical quadrature, and order selection algorithms

This file turns the integral portion of Track B into bounded,
dependency-ordered natural-language work.  A displayed integral denotes a
classically valid Bochner integral or a value of an explicitly stated ordinary-
improper relation.  Those are different interfaces: Mathlib's totalized value
for a nonintegrable Bochner-integral expression is never used as evidence of
convergence, and principal value is never inferred from ordinary convergence.

## 1. Track conventions and revision-4 planning choices

- The scalar parameter in a real Laplace kernel is `x : ℝ` with `0 < x`.
  The integration variable is `t : ℝ`, and the half-line is `Set.Ioi 0`.
  Endpoints may be changed to `Ici 0` only through the measure-zero endpoint
  lemma, not by definitional equality.
- A finite polynomial model has exactly `N` terms,
  \(P_N(t)=\sum_{j=0}^{N-1}c_jt^j\).  Thus `N = 0` means the empty sum and
  remainder equal to the full amplitude.
- The revision-4 generic local-tail kernel uses a complete normed real vector
  space `E`.  Its source-facing Watson specialization uses `E = ℂ`; the real
  theorem is a corollary, not the source boundary.  Scalar multiplication is
  explicit when the real kernel multiplies an `E`-valued value.
- An ordinary improper integral with finite exceptional set `S` is a relation:
  split at the ordered points of `S`, take independent one-sided limits at
  every finite exceptional endpoint and at infinity, and forbid cancellation
  across a singularity.  The Lean-facing relation uses Mathlib's Bochner
  `intervalIntegral` on each compact regular piece, with explicit
  `IntervalIntegrable` evidence; only the endpoint passages are improper.  No
  second proper-Riemann integral implementation is planned.  A Cauchy principal
  value is a separate later adapter.
- The conditional tail interface is a continuous normalized primitive with an
  integral-increment law on compact regular pieces.  A local-Bochner
  construction may populate that certificate when absolute integrability is
  available, but is not the general source semantics.
- Every conditional full-ray value is an explicit value in the finite-
  exceptional ordinary-improper relation.  Mathlib set integrals appear as
  such values only after separate `IntegrableOn` evidence and the public
  absolute-Bochner bridge; a totalized expression never denotes a conditional
  value.
- All public bounds are real and visibly nonnegative.  Parameters called
  \(M,C,T,x\) carry, respectively, `0 ≤ M`, `0 ≤ C`, `0 ≤ T`, and
  `0 < x` unless a stronger condition is displayed.
- A local expansion on \([0,T]\) does not control the tail.  Tail assumptions
  and their provenance are separate fields in every application card.
- Real powers use `Real.rpow`; complex powers use one declared logarithm branch.
  For \(t>0\), the positive-real branch agreement is an explicit lemma.
- Exact identities are separate targets from norm estimates.  This allows the
  same identity to be reused with a sharp tail bound, a simpler tail bound, or a
  named-function estimate.

## 2. Dependency order and packet queue

`QL-001`, `OLV-001`, and `SR-001` have planning rows in the canonical card
registry.  IMP-001 and OLV-002 have draft planning artifacts but no registry
row; QL-002, QL-003, and EX-002 are provisional handles.  Listing an ID is not a
manifest entry, source claim, or implementation authorization.

| Order | Provisional card | Packet theorem / coverage / novelty class | Depends on | Status |
|---:|---|---|---|---|
| 1 | IMP-001 | `mixed` / `infrastructure` / `non_novel` | pinned integration and limit facts | concurrent unregistered revision-6 card/proof with eight prospective targets; R6 corrects one pinned root namespace only; fresh exact-commit checks and proof/API review required before exact signatures; historical R3 signature proposal superseded |
| 2 | QL-001 | `finite_remainder_bound` / `infrastructure` / v3 successor value `non_novel` | accepted IMP-001, pinned Gamma-model integrability, and the direct pinned real Gamma moment | revision-4 draft card and complete draft proof; R4 corrects two pinned root namespaces only; exact-commit checks, classification binding, and mathematical proof review remain pending before exact signatures |
| 3 | OLV-001 | `finite_remainder_bound` / `exact_source_generic` / `strengthened_conclusion` | locked occurrence and accepted QL-001 | concurrent revision-4 dependency rebinding against IMP R6 and QL R4; mathematical target/proof/source adapter unchanged; exact signatures and reviews pending |
| 4 | SR-001 | `qualitative_bridge` / `audit_source_recovery` / intended `source_equivalent` | accepted OLV-001 | planning only; audit module only |
| off path | OLV-002 | `finite_remainder_bound` / `exact_source_generic` / `source_equivalent` | separate section 9.1--9.2 occurrence and pinned Gamma moment | revision-2 planning card/proof; not registered or selected by OLV-MVP-1 |
| optional | QL-002, QL-003 | additional moment and exponential-envelope infrastructure | accepted QL-001 only where genuinely reused | provisional; neither is needed by the revision-4 Watson proof |
| regression | EX-002 | `finite_remainder_bound` / `infrastructure` / `equivalent_reformulation` of the finite geometric identity | finite integration facts | provisional; not registered and no card exists |

The version-3 classification successor records `QL-001` and both targets as
`non_novel`, matching the classical bounded-primitive and finite-decomposition
arguments.  It preserves the frozen v2 bytes and awaits independent review;
this planning document claims no schema approval.  The QL-002/QL-003 planning
labels remain available only for additional reusable adapters and must not be
used to restate the revision-4 core.

The Watson critical path is intentionally no larger than

```text
pinned integration and limit facts -> IMP-001 ordinary-improper layer
                                                  |
                                                  v
pinned model integrability and Real Gamma moment -> QL-001 R4 local-tail kernel
                                                  |
locked 1997 occurrence and reviewed transcription |
                         +------------------------+
                         v
              OLV-001 R4 exact_source_generic -> SR-001 in Audit/SourceRecovery

separate section 9.1--9.2 occurrence -> OLV-002 supplied-global-majorant bound
```

QB-001 and DEF-001 may later join for optional error-predicate packaging or a
project-level Gamma audit wrapper.  Neither is consumed by the revision-4
QL/OLV proofs or lies on their mathematical critical path.

In particular, Watson does **not** depend on Airy, a named-function catalogue
wave, a project Gamma wrapper, complex derivative transport,
oscillatory integration by parts, contour deformation, Euler--Maclaurin, ODEs,
or a custom tactic.

The classification shorthand above is nonnormative.  A multi-target card
classifies each declaration separately under the theorem-card and work-packet
vocabularies.  Any correction to the v2 registry is a new schema revision, not
an editorial change to existing frozen bytes.

### Planned proof artifacts

New-mathematics dossiers use the schema in
`blueprint/automation/proof_artifact_schema.md`.  The active Watson drafts are
`NLP-QL-001-R4` and the concurrent `NLP-OLV-001-R4`; the separate global-majorant draft is
`NLP-OLV-002-R2`.  QL-002, QL-003, EX-002, and SR-001 reserve no proof revision
until an artifact is actually created.  Each artifact binds
exact target IDs, card/signature revisions, the resolved Mathlib commit,
accepted work-item commits, and source IDs where applicable.  Its body contains
the quantifier ledger, dependency ledger, numbered exact identities, analytic
side-condition ledger, constant-loss ledger, target proofs,
hypothesis/choice-laundering audit, regressions, trust/import boundary, and
exclusions.  These IDs reserve no file and confer no status; a dossier exists
only when its complete artifact is created and frozen.  The QL/OLV revision-4
Watson artifacts and OLV-002 revision 2 are drafts, not frozen evidence or
Lean authorization.

## 3. IMP-001 revision 6 and QL-001 revision 4 — ordinary-improper local-tail kernel

`IMP-001` is a concurrent unregistered revision-6 draft.  Its prospective
public surface retains the finite-exceptional value relation, normalized
continuous primitive certificate, uniqueness, generalized finite CLM
linearity, regular splitting, and arbitrary-exception Abel composition.  It
adds an absolute-Bochner bridge at the exact set-integral value and an
equivalence between the endpoint relation and existence of a normalized
continuous primitive tending to the related value.  The eight-target boundary
is provisional pending fresh natural-language and architecture review.  The
historical revision-3 six-declaration signature proposal is superseded design
evidence and supplies neither approval nor an implementation contract.

QL-001 revision 4 is the first full public-API consumer.  It must not hide IMP
inside an application-specific structure, unfold IMP's endpoint
representation, or begin with model improper witnesses already assumed.

### QL-001.A — standing data and ordinary-improper semantics

Let `E` be a complete normed real vector space and
\(\phi:\mathbb R\to E\).  Supply \(\beta>0\), \(k>0\), \(K,L\ge0\), a
baseline \(X\in\mathbb R\), and a finite exceptional set
\(S\subset(k,\infty)\).  The target parameter satisfies
\(x>\max(X,0)\).

The tail is not encoded as an everywhere locally Bochner-integrable function.
It is an ordinary-improper relation obtained by splitting at the ordered points
of `S` and requiring independent one-sided limits.  There is no cross-point or
principal-value cancellation.  Proper integrals are used only on compact
regular pieces, and those are represented by Mathlib `intervalIntegral` rather
than by a project-local Riemann integral.

### QL-001.B — continuous primitive certificate

The supplied certificate is a continuous \(F:[k,\infty)\to E\) such that
\(F(k)=0\), \(\|F(t)\|\le L\), and, whenever
\([a,b]\subset[k,\infty)\) avoids `S`,

\[
 F(b)-F(a)=\int_a^b e^{-Xv}\phi(v)\,dv. \tag{IL.1}
\]

Continuity is the gluing datum for the independent endpoint limits.  On each
regular component, IMP's private finite-piece Abel/Fubini lemma derives the
weighted increment identity from the primitive law without assuming a
pointwise derivative of `F`.  QL itself proves, from \(h=x-X>0\) and the flat
bound, that \(e^{-ht}F(t)\) is `IntegrableOn (Ioi k)` and tends to zero at
infinity.  Public IMP T06 then constructs the arbitrary-`S` tail relation at
the exact value

\[
 h\mathbin{\bullet}\int_{(k,\infty)}e^{-ht}F(t)\,dt.
\]

Norm domination and the exact exponential integral give

\[
 \left\|\int_k^\infty e^{-xt}\phi(t)\,dt\right\|
 \le L e^{-(x-X)k}. \tag{IL.2}
\]

The certificate does not contain the requested related value at `x`; it records a
bounded primitive at the one baseline `X`.  A local-Bochner adapter may derive
it from absolute integrability and an ordinary integral primitive, but that
adapter is strictly narrower and must not claim the conditionally convergent
interior-singularity cases accepted by the core.

For the source route, public IMP T08 converts baseline endpoint convergence
into existence of a normalized continuous primitive tending to that value.
Continuity and convergence then supply the global bound used here.  This keeps
the ordered finite-component construction inside IMP.

### QL-001.C — local Gamma majorant

Assume
`AEStronglyMeasurable phi (volume.restrict (Set.Ioc 0 k))` and

\[
 \|\phi(t)\|\le Kt^{\beta-1}\qquad(0<t\le k). \tag{IL.3}
\]

A.e. strong measurability for restricted volume together with \(\beta>0\) and
the displayed majorant supplies honest `IntegrableOn` evidence on \((0,k]\),
which is converted to `IntervalIntegrable` on \([0,k]\).  Generic QL takes the
a.e. statement directly.  Only the complex-valued finite-dimensional Olver
source adapter derives it from proper-Riemann hypotheses on a countable
exhaustion of \((0,k]\); no implication from arbitrary Banach-valued Riemann
integrability is used.  Pointwise `StronglyMeasurable` or Borel regularity can
still fail after a null-set modification.  The pinned declaration
`integrableOn_rpow_mul_exp_neg_mul_rpow`, specialized to \(p=1\), separately
proves whole-ray integrability of the scalar majorant.  Enlarging the positive
scalar integral to the whole ray and using
`Real.integral_rpow_mul_exp_neg_mul_Ioi` yields

\[
 \left\|\int_0^k e^{-xt}\phi(t)\,dt\right\|
 \le K\Gamma(\beta)x^{-\beta}. \tag{IL.4}
\]

Public IMP T04 prepends this honestly integrable local interval to the T06
tail.  It produces an explicit value \(I\) in the split ordinary-improper
relation and the generic bound

\[
 \left\|\int_0^\infty e^{-xt}\phi(t)\,dt\right\|
 \le K\Gamma(\beta)x^{-\beta}+Le^{-(x-X)k}. \tag{IL.5}
\]

### QL-001.D — finite Watson decomposition

For \(\lambda,\mu>0\), complex coefficients \(a_s\), and
\(\beta_s=(s+\lambda)/\mu\), define

\[
 p_n(t)=\sum_{s<n}a_st^{\beta_s-1},\qquad
 \phi_n(t)=q(t)-p_n(t).
\]

For every \(s<n\), first use
`integrableOn_rpow_mul_exp_neg_mul_rpow` to prove absolute integrability of the
model and only then use public IMP T07 to obtain its ordinary-improper value at
the exact set integral.  The real Gamma moment identifies that value.
Generalized IMP T03 transports the real values through continuous real-linear
maps, applies the complex coefficients, and combines the model relations with
the remainder relation on the literal finite union `S`.  It constructs an
explicit \(Q\) satisfying

\[
 \int_0^\infty e^{-xt}q(t)\,dt
 -\sum_{s<n}a_s\Gamma(\beta_s)x^{-\beta_s}
 =\int_0^\infty e^{-xt}\phi_n(t)\,dt. \tag{IL.6}
\]

Every full-ray integral in (IL.6) is relational shorthand for the explicit
value just constructed; it is not a totalized conditional set integral.
Public IMP T02 identifies any other value satisfying the same relation.
Specializing (IL.5) to `E = ℂ` and \(\beta=\beta_n\) yields

\[
 \exists Q,\quad \operatorname{HasImp}(e^{-x\cdot}q,0,S,Q)\quad\text{and}
\]

\[
 \left\|Q-\sum_{s<n}a_s\Gamma(\beta_s)x^{-\beta_s}\right\|
 \le K\Gamma(\beta_n)x^{-\beta_n}+Le^{-(x-X)k}.
\]

At `n = 0`, no model witness or coefficient is accessed.  The generic kernel
remains vector-valued over real scalars; the source-facing theorem is complex
and has a separate real corollary.

### QL-001 proof dossier and gate

[`NLP-QL-001-R4`](../proofs/QL-001.md) is a complete draft proof, not a frozen
specification.  Review must independently check the relational improper
integral, honest local interval integrability, the derived T06 hypotheses,
T04 prepending, separate model integrability, T07 value construction,
generalized T03 finite union, T02 uniqueness, real-scalar Banach generality,
complex specialization, constants, powers, and the `n = 0` case.  An
end-to-end regression must begin with the Gamma model functions rather than
assume their relation witnesses.  IMP R6 and QL R4 both require fresh review;
exact QL signatures are deliberately deferred.  The v3 successor binding and
its `non_novel` disposition await independent review, claim no schema
approval, and leave the frozen v2 bytes unchanged.

## 4. Optional moment adapters beyond QL-001

QL-001 already contains the positive-real power moment needed by Watson.  A
future QL-002 may package other moment families only when at least two accepted
consumers justify it.  Complex powers, complex parameters, and logarithm-branch
choices are separate APIs and require their own source and branch review; they
are not implicit generalizations of the real-exponent theorem.

## 5. QL-003 — optional exponential tail adapter

This provisional packet supplies an absolutely integrable exponential-growth
tail adapter.  It is not used to represent Olver's conditionally convergent
finite-exceptional source hypothesis.  A first concrete lemma is:

\[
 \|a(t)\|\le C e^{\rho t}\quad(t\ge T),\quad C\ge0,
 \quad x>\rho
 \Longrightarrow
 \left\|\int_T^\infty e^{-xt}a(t)\,dt\right\|
 \le \frac{C e^{-(x-\rho)T}}{x-\rho}. \tag{IL.10}
\]

Here `x - ρ > 0` is a theorem hypothesis, not rescued by totalized division.
An application must
prove its own `C`, `ρ`, and `T`; QL-003 does not package them in a structure that
asserts the target bound.

The proof dossier must include a counterexample showing why agreement with the
same local polynomial on `[0,T]` gives no uniform tail control: add an
arbitrarily large nonnegative bump supported in `[T+1,T+2]`.  This is a
permanent anti-laundering regression.

## 6. OLV-001, OLV-002, and SR-001 — Watson without scope creep

`OLV97-C03-WATSON` now has a direct first collation against a hash-bound 1997
snapshot, including the printed label, mathematical transcription, quantifier
and exponent ledger, endpoint notes, provisional notation/entity associations,
copy identifier, and transcription hash.  It remains
`transcribed_unreconciled` until independent source review approves the
transcription and semantic interpretation.  Same-edition evidence supports a
complex finite-dimensional amplitude and the bookwide Riemann convention; ordinary convergence is
provisionally read as independent one-sided convergence at the finite
exceptional set, with principal value reserved for a separate extension.
Revision-4 QL-001 and the concurrent OLV-001 revision-4 adaptation implement
that planning choice against IMP R6, but are not frozen specifications or
review verdicts.

The revision-4 planning split is:

- `OLV-001` is `exact_source_generic`, never a named-function application.  It
  instantiates QL-001 for a complex amplitude and exposes one common baseline
  \(X>0\) chosen before `n`; the witnesses \(k_n,K_n,L_n\) may depend on `n`.
  Its real-valued statement is a corollary.  Any stronger hypotheses are
  reported as stronger hypotheses, not laundered into Theorem 3.1.
- `OLV-002` is a separate, unselected planning packet for the direct
  section 9.1 global-majorant implication to the section 9.2 Gamma bound.  It
  is not a dependency of OLV-001 and does not alter OLV-MVP-1 membership.
- `SR-001` lives only under `Audit/SourceRecovery` and derives the exact printed
  qualitative statement from OLV-001.  It is not imported by the semantic
  public root.

[`NLP-OLV-001-R4`](../proofs/OLV-001.md) contains the source-hypothesis
discharge ledger, exact finite remainder formula, local and tail estimates,
common-`X` quantifier order, and the route to the printed conclusion.  Its
pre-Lean gate
requires at least two distinct independent reviewers: one source/semantics
reviewer and one quantitative proof reviewer.  Because a source occurrence is
at stake, source-fidelity requires two independent approvals in the later
implementation round.  Any change to the source snapshot or transcription
invalidates the entire round.

## 7. Required prototypes and counterexamples

### EX-002 — divergent factorial expansion

For `u > 0`, set

\[
 F(u)=\int_0^\infty\frac{e^{-t}}{1+t/u}\,dt.
\]

The finite geometric identity gives

\[
 F(u)=\sum_{j<N}\frac{(-1)^j j!}{u^j}
 +(-1)^N\int_0^\infty
   \frac{e^{-t}(t/u)^N}{1+t/u}\,dt,
\qquad
 |R_N(u)|\le\frac{N!}{u^N}. \tag{IL.11}
\]

Test `N = 0`, `N = 1`, positivity of the denominator, and the exact ratio
\(B_{N+1}/B_N=(N+1)/u\).  At `u = 16`, the majorant is minimal at both
`N = 15` and `N = 16`, and
\(16!/16^{16}=638512875/562949953421312>2^{-20}\).  This proves that an
all-orders family of valid finite bounds neither converges nor improves
monotonically.

Additional negative regressions:

- `x = 0` is rejected even though Lean's totalized integral term is syntactic;
- a local Taylor bound with no amplitude tail does not imply (IL.5);
- a negative `M` is not accepted as a majorant;
- replacing `Ioi 0` by a finite interval changes the model moment;
- a pointwise bound without the required restricted-volume a.e. strong
  measurability is insufficient for Bochner integrability.

## 8. Pinned Mathlib reuse and known gaps

Reuse after exact signature checks:

- `MeasureTheory.norm_integral_le_of_norm_le`, set-integral restriction,
  `MeasureTheory.setIntegral_mono_set`, and
  `intervalIntegrable_iff_integrableOn_Ioc_of_le` for the honest local estimate;
- finite-interval Bochner integration and Fubini facts for the `IMP-001`
  finite-piece Abel identity; no infinite-interval integration-by-parts theorem
  is a dependency of the generic Banach-space interface;
- root `integrableOn_rpow_mul_exp_neg_mul_rpow` from
  `Mathlib.Analysis.SpecialFunctions.Gaussian.GaussianIntegral`, specialized
  to `p = 1`, for model convergence, separately from
  `Real.integral_rpow_mul_exp_neg_mul_Ioi` for its positive-real value;
- root `integrableOn_exp_mul_Ioi`, root `integral_exp_mul_Ioi`, and
  `Real.tendsto_exp_neg_atTop_nhds_zero` for the T06 side conditions and tail
  bound;
- `MeasureTheory.intervalIntegral_tendsto_integral_Ioi` underlies IMP T07's
  absolute-Bochner bridge; QL consumes T07 rather than rebuilding it;
- `isLittleO_exp_neg_mul_rpow_atTop` for qualitative recovery;
- `Complex.Gamma` through DEF-001 only when a project-level identification is
  actually consumed.

No ready-made theorem was found in the pinned snapshot for the finite-
exceptional ordinary-improper relation, its endpoint/primitive equivalence,
the arbitrary-exception Abel composition, the vector-valued local-tail
theorem, or the collated Watson theorem.  IMP R6 prospectively supplies those
project interfaces and the absolute-Bochner adapter T07.  T07 is a
sufficient constructor under norm integrability, not a replacement for the
conditional source-facing relation.  A pre-Lean reuse search must be repeated
at the then-current pin and recorded in the card.

## 9. Named Olver consumers after Watson

These are discovery targets from Olver's contents and the present occurrence
inventory, not source-coverage claims.  Each needs a locked body occurrence,
an exact-source card, and, where named, a proved entity identification before
the application may be reported complete.

| Provisional application card | Named consumer | Expected method input |
|---|---|---|
| APP-GAMMA-LAPLACE-001 | Gamma function of large argument, Chapter 3 | real Laplace method plus identified Gamma |
| APP-IGAMMA-LAPLACE-001 | incomplete Gamma functions, Chapters 2 and 4 | endpoint/local Laplace bounds; upper/lower and normalized form must be resolved |
| APP-AIRY-INTEGRAL-001 | Airy integral/functions, Chapters 2 and 4 | model integral and later contour work; exact rotation/normalization unresolved |
| APP-GAMMA-RATIO-001 | ratio of two Gamma functions, Chapter 4 | loop-Watson variant, branch and pole exclusions |
| APP-BESSEL-INTEGRAL-001 | Bessel functions of large argument and order, Chapter 4 | saddle/Laplace instance plus J/Y/H normalization |
| APP-NICHOLSON-001 | Nicholson integral for the Bessel combination in Chapter 9 | nonnegative or oscillatory kernel after exact formula collation |
| APP-ANGER-001 | Anger functions of large order, Chapter 9 | generalized Laplace/saddle/coalescing analysis and source-specific normalization |

None of these named applications is a prerequisite for OLV-001.  Their cards
must prove domain reachability/nonemptiness, majorant nonnegativity, every
generic hypothesis, and the actual function identification without hypothesis
or choice laundering.

## 10. Exit criteria

This track is ready to implement a packet only when its card freezes exact
declarations, imports, binder order, domains, integrability semantics, and proof
artifact digest, and the required independent pre-Lean approvals are external
and current.  The method track itself is successful when exact identities and
finite bounds exist for its accepted cards; it does not require quadrature,
floating-point evaluation, or adaptive truncation.
