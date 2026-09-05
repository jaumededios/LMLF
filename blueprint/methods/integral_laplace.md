# Integral and Laplace methods

**Document status:** planning blueprint; no packet in this file is authorized for Lean  
**Scope:** real half-line integrals, exact exponential moments, finite Laplace
remainders, and the deliberately narrow Watson source path  
**Out of scope here:** oscillatory and contour arguments (see
`oscillatory_contour.md`), summation, ODE stability, named-function
construction, numerical quadrature, and order selection algorithms

This file turns the integral portion of Track B into bounded,
dependency-ordered natural-language work.  A displayed integral denotes a
classically valid Bochner or improper integral only under the hypotheses stated
with it.  The fact that Lean assigns a value to a nonintegrable Bochner-integral
expression is never used as a theorem of convergence.

## 1. Frozen conventions

- The scalar parameter in a real Laplace kernel is `x : ℝ` with `0 < x`.
  The integration variable is `t : ℝ`, and the half-line is `Set.Ioi 0`.
  Endpoints may be changed to `Ici 0` only through the measure-zero endpoint
  lemma, not by definitional equality.
- A finite polynomial model has exactly `N` terms,
  \(P_N(t)=\sum_{j=0}^{N-1}c_jt^j\).  Thus `N = 0` means the empty sum and
  remainder equal to the full amplitude.
- Vector-valued statements use a complete normed real vector space `E` and
  Bochner integration.  Scalar complex corollaries may use `E = ℂ`.  Scalar
  multiplication is written explicitly when a real kernel multiplies an
  `E`-valued coefficient.
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
registry. `EX-002` and every other additional ID in this file are provisional.
Listing an ID is not a card, manifest entry, source claim, or implementation
authorization.

| Order | Provisional card | Theorem / coverage / novelty class | Depends on | Status |
|---:|---|---|---|---|
| 1 | QL-001 | `finite_remainder_bound` / `infrastructure` / provisionally `novel` | QB-001 | planning only; registered but not specified |
| 2 | QL-002 | `finite_remainder_bound` / `infrastructure` / provisionally `generalized` | QL-001; DEF-001 only if the public proof is routed through Gamma | provisional |
| 3 | QL-003 | `finite_remainder_bound` / `infrastructure` / provisionally `novel` | the smallest accepted slice of QL-001/QL-002 | provisional |
| 4 | EX-002 | `finite_remainder_bound` / `infrastructure` / `equivalent_reformulation` of the finite geometric identity | QL-001 | provisional; not registered and no card exists |
| 5 | OLV-001 | `finite_remainder_bound` / `exact_source_generic` / unclassified until collation | locked occurrence, QB-001, and only the selected Laplace targets | planning only; source transcription absent |
| 6 | SR-001 | `qualitative_bridge` / `audit_source_recovery` / intended `source_equivalent`, subject to collation | OLV-001 | planning only; audit module only |

`QL-002` and `QL-003` may be merged into a later revision of `QL-001` only if
the resulting card remains bounded and its exact declarations are all needed by
Watson.  Otherwise they remain parallel reusable infrastructure.

The Watson critical path is intentionally no larger than

```text
locked 1997 occurrence and verified mathematical transcription --+
                                                               +-> selected minimal QL-001 slice
QB-001 finite core ---------------------------------------------+             |
                                                                             v
QL-002 / DEF-001 -- conditional, only if generalized Gamma moments are used -+
                                                                             |
                                                                             v
                                                          OLV-001 exact_source_generic
                                                                             |
                                                                             v
                                                          SR-001 in Audit/SourceRecovery
```

In particular, Watson does **not** depend on Airy, a named-function catalogue
wave beyond an actually used Gamma bridge, complex derivative transport,
oscillatory integration by parts, contour deformation, Euler--Maclaurin, ODEs,
or a custom tactic.

The classification shorthand above is nonnormative.  A multi-target card
classifies each declaration separately under the theorem-card and work-packet
vocabularies; OLV-001 receives no novelty value until comparison with the
verified transcription makes that value meaningful.

### Planned proof artifacts

New-mathematics dossiers use the schema in
`blueprint/automation/proof_artifact_schema.md`.  The first proposed revisions
are `NLP-QL-001-R1`, `NLP-QL-002-R1`, `NLP-QL-003-R1`,
`NLP-EX-002-R1`, `NLP-OLV-001-R1`, and `NLP-SR-001-R1`.  Each artifact binds
exact target IDs, card/signature revisions, the resolved Mathlib commit,
accepted work-item commits, and source IDs where applicable.  Its body contains
the quantifier ledger, dependency ledger, numbered exact identities, analytic
side-condition ledger, constant-loss ledger, target proofs,
hypothesis/choice-laundering audit, regressions, trust/import boundary, and
exclusions.  These IDs reserve no file and confer no status; a dossier exists
only when its complete artifact is created and frozen.

## 3. QL-001 — finite half-line and polynomial Laplace core

### QL-001.A — semantics and cutoff identity

For an integrable `E`-valued function \(f\) on \((0,\infty)\), and
\(0\le T\), prove the exact decomposition

\[
 \int_{(0,\infty)} f(t)\,dt
 =\int_{(0,T]} f(t)\,dt+\int_{(T,\infty)}f(t)\,dt.
\]

Supply variants expressed with the interval integral from `0` to `T`, and prove
the endpoint conversions.  The target records `IntegrableOn f (Ioi 0)`; the
summands inherit integrability by restriction.  A companion inequality is

\[
 \left\|\int_{(T,\infty)} f(t)\,dt\right\|
 \le \int_{(T,\infty)}\|f(t)\|\,dt.
\]

This small target prevents every later proof from silently mixing set,
interval, and improper-limit conventions.

### QL-001.B — natural exponential moments

For every \(n\in\mathbb N\) and `0 < x`, prove integrability and

\[
 \int_0^\infty e^{-xt}t^n\,dt=\frac{n!}{x^{n+1}}. \tag{IL.1}
\]

The no-Gamma proof route is induction on `n` using integration by parts, with
the two boundary limits proved explicitly.  The alternative route specializes
Mathlib's Gamma moment and `Real.Gamma_nat_eq_factorial`.  The theorem card must
choose one route: the first keeps DEF-001 off the dependency path; the second
must list the exact Gamma declarations and DEF-001 if it consumes project
wrappers.

For `0 ≤ T`, prove the exact polynomial-exponential tail

\[
 Q_n(x,T):=\int_T^\infty e^{-xt}t^n\,dt
 =e^{-xT}\sum_{j=0}^{n}
   \frac{n!}{(n-j)!}\frac{T^{n-j}}{x^{j+1}}. \tag{IL.2}
\]

Every summand on the right is nonnegative.  Required regressions are
\(Q_0=e^{-xT}/x\),
\(Q_1=e^{-xT}(T/x+1/x^2)\), and `T = 0`, which recovers (IL.1).

### QL-001.C — exact global remainder and bound

Let \(c_0,\ldots,c_{N-1}\in E\), define

\[
 P_N(t)=\sum_{j<N}t^j c_j,\qquad r_N(t)=a(t)-P_N(t).
\]

Assume `0 < x`, the amplitude is strongly measurable on `Ioi 0`, and

\[
 \|r_N(t)\|\le M t^N\quad(t>0),\qquad 0\le M. \tag{IL.3}
\]

Dominated integrability is part of the proof, not an additional conclusion
hidden in notation.  Prove the exact identity

\[
 \int_0^\infty e^{-xt}a(t)\,dt
 -\sum_{j<N}\frac{j!}{x^{j+1}}c_j
 =\int_0^\infty e^{-xt}r_N(t)\,dt, \tag{IL.4}
\]

and then

\[
 \left\|\int_0^\infty e^{-xt}a(t)\,dt
 -\sum_{j<N}\frac{j!}{x^{j+1}}c_j\right\|
 \le \frac{M N!}{x^{N+1}}. \tag{IL.5}
\]

The public theorem quantifies one fixed `a` before `N`; it is compatible with
`HasErrorFamily` and asserts no convergence as `N → ∞`.  At `N = 0`, (IL.5)
is the ordinary bound by `M/x` under \(\|a(t)\|\le M\).

### QL-001.D — local polynomial identity

Assume (IL.3) only for `0 < t ≤ T`, and separately assume integrability of
the amplitude tail.  With `Q_j` from (IL.2), prove

\[
\begin{aligned}
 &\int_0^\infty e^{-xt}a(t)\,dt
   -\sum_{j<N}\frac{j!}{x^{j+1}}c_j\\
 &=\int_0^T e^{-xt}r_N(t)\,dt
   +\int_T^\infty e^{-xt}a(t)\,dt
   -\sum_{j<N}c_jQ_j(x,T).
\end{aligned}\tag{IL.6}
\]

If

\[
 \left\|\int_T^\infty e^{-xt}a(t)\,dt\right\|\le E_a(x,T),
 \qquad 0\le E_a(x,T),
\]

then the natural bound is

\[
 M\int_0^T e^{-xt}t^N\,dt
 +E_a(x,T)+\sum_{j<N}\|c_j\|Q_j(x,T). \tag{IL.7}
\]

Export this formula before weakening the local moment to \(MN!/x^{N+1}\).
The polynomial-tail term is essential: subtracting the full model moments while
using only a local model creates exactly this contribution.

### QL-001 proof dossier and gate

The planned artifact `blueprint/proofs/QL-001.md` must derive each equality
before taking norms; prove strong measurability and integrability of every
summand; state all endpoint-null-set conversions; show every finite sum/integral
interchange; prove the boundary limits in (IL.2); and expand the cases `N = 0`,
`N = 1`, and `T = 0`.  It must compare the induction and Gamma proof routes and
freeze one dependency choice.

Before Lean, two independent reviewers inspect the same frozen card and dossier:

1. an integral-semantics/quantitative referee checks measurability,
   integrability, endpoints, constants, powers, and majorant nonnegativity;
2. a Mathlib/API referee checks the pinned declarations, binder order, finite
   sum convention, import boundary, and whether QL-001 is still bounded.

A substantive change to a formula, endpoint convention, ambient space, or
Gamma dependency resets both approvals.  Implementation later receives the
full quantitative-correctness, Mathlib-reuse, API/dependency, and proof-quality
rubrics at the exact candidate head.

## 4. QL-002 — generalized power moments

This packet is optional on the Watson path until direct collation shows the
printed exponent lattice.  For `α > -1` and `0 < x`, Mathlib already supports the
real moment

\[
 \int_0^\infty t^\alpha e^{-xt}\,dt
 =x^{-(\alpha+1)}\Gamma(\alpha+1). \tag{IL.8}
\]

The packet must freeze whether the theorem is real-valued, complex-valued with
real exponent, or complex-power-valued.  These are not interchangeable APIs.
For a positive spacing `μ` and offset `λ > 0`, the candidate model terms are

\[
 t^{(j+\lambda)/\mu-1},\qquad
 \int_0^\infty e^{-xt}t^{(j+\lambda)/\mu-1}\,dt
 =\Gamma((j+\lambda)/\mu)x^{-(j+\lambda)/\mu}. \tag{IL.9}
\]

All powers use the positive-real convention.  The assumptions `0 < μ`,
`0 < λ`, and `0 < x` make the endpoint and infinity integrability explicit.
A remainder bounded by \(M t^{(N+\lambda)/\mu-1}\) then receives exactly the
corresponding Gamma majorant.

The dossier must prove the exponent inequalities at zero, the scaling
substitution, branch agreement, positivity of the Gamma majorant, and the
integer specialization back to QL-001.  Two independent pre-Lean reviews are
mandatory.  If a complex parameter or branch is added, require a third
source/branch-semantics reviewer.

## 5. QL-003 — explicit local Watson envelope

This packet combines QL-001.D or QL-002 with a reusable tail hypothesis that is
strictly weaker than assuming the desired final estimate.  A first concrete
tail lemma is:

\[
 \|a(t)\|\le C e^{\rho t}\quad(t\ge T),\quad C\ge0,
 \quad x>\rho
 \Longrightarrow
 \left\|\int_T^\infty e^{-xt}a(t)\,dt\right\|
 \le \frac{C e^{-(x-\rho)T}}{x-\rho}. \tag{IL.10}
\]

Here `x - ρ > 0` is a theorem hypothesis, not rescued by totalized division.
The local part uses the exact incomplete moment when available, and (IL.7)
retains amplitude-tail and model-tail terms separately.  An application must
prove its own `C`, `ρ`, and `T`; QL-003 does not package them in a structure that
asserts the target bound.

The proof dossier must include a counterexample showing why agreement with the
same local polynomial on `[0,T]` gives no uniform tail control: add an
arbitrarily large nonnegative bump supported in `[T+1,T+2]`.  This is a
permanent anti-laundering regression.

## 6. OLV-001 and SR-001 — Watson without scope creep

`OLV97-C03-WATSON` is still unresolved in the source inventory.  No formula in
this methods blueprint is represented as Olver's exact printed theorem.  Before
either card is specified, direct collation against the locked 1997 copy must
record the printed label, full mathematical transcription, quantifier order,
endpoint convention, exponent lattice, coefficient normalization, conclusion,
notation/entity associations, copy identifier, and transcription hash.

The card split is fixed:

- `OLV-001` is `exact_source_generic`, never a named-function application.  It
  instantiates only the generic Laplace targets required by the transcription
  and may add an explicit finite strengthening.  Any stronger hypotheses are
  reported as stronger hypotheses, not as a stronger theorem.
- `SR-001` lives only under `Audit/SourceRecovery` and derives the exact printed
  qualitative statement from OLV-001.  It is not imported by the semantic
  public root.

The OLV-001 proof dossier must contain a line-by-line source-hypothesis discharge
ledger, the exact finite remainder formula, all local and tail estimates, and a
proof that the finite result implies the printed conclusion.  Its pre-Lean gate
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
- a pointwise bound without measurability is insufficient for Bochner
  integrability.

## 8. Pinned Mathlib reuse and known gaps

Reuse after exact signature checks:

- `MeasureTheory.norm_integral_le_integral_norm`, set-integral restriction and
  union lemmas, `intervalIntegral.integral_interval_add_Ioi`,
  `intervalIntegral_tendsto_integral_Ioi`, and the endpoint-null-set lemmas;
- `MeasureTheory.integral_Ioi_mul_deriv_eq_deriv_mul` and finite-interval
  integration by parts for the induction proof;
- `Complex.integral_cpow_mul_exp_neg_mul_Ioi`,
  `Real.integral_rpow_mul_exp_neg_mul_Ioi`,
  `integral_rpow_mul_exp_neg_mul_rpow`, and Gamma's natural-value facts where
  their exact conventions fit;
- `Complex.Gamma` through DEF-001 only when a project-level identification is
  actually consumed.

No ready-made theorem was found in the pinned snapshot for QL-001's vector-valued
finite Laplace remainder, the exact polynomial-exponential tail (IL.2), the
local split (IL.6)--(IL.7), or the collated Watson theorem.  These are project
proofs, not renamed Mathlib declarations.  A pre-Lean reuse search must be
repeated at the then-current pin and recorded in the card.

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
