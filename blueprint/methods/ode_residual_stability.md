# ODE residuals, stability, and normalized fixed solutions

**Document role:** planning blueprint; no theorem card, proof dossier, review,
or Lean implementation is created by this document.  All queue entries below
remain `planning_only` and `implementation_status: not_started`.

**Programme position:** Track C, parallel to the Watson critical path.  Nothing
in this file is a prerequisite of OLV-MVP-1.

This refines the ODE portions of the attached *Explicit Quantitative Olver in
Lean* blueprint.  It is subordinate to the repository
[roadmap](../roadmap.md), [design decisions](../design_decisions.md),
[source policy](../source_manifest.md), pinned
[Mathlib audit](../mathlib_audit.md), and [review
protocol](../../review/PROTOCOL.md).  Where the older attachment and current
repository differ, the current `LMLF` names, pin, manifests, and gates control.

## 1. Contract and non-claims

This programme turns a formal approximation to a second-order linear ODE into a
bound for one identified, normalized solution.  It must keep five logically
different assertions separate:

1. an exact change-of-variable or gauge identity;
2. an exact residual identity for a finite approximant;
3. a pointwise or integral bound on that residual;
4. existence, normalization, and uniqueness of the exact solution;
5. a stability theorem converting the residual and normalization mismatch into
   a solution or scaled-jet error.

A residual bound alone is not a solution estimate.  For example, for `y'' = 0`
both `y = 0` and `a = 1` have residual zero, but their distance is one.  Even
with matching initial data, a small forcing can be amplified by a long path or
an ill-conditioned propagator.  Every released application must therefore show
the normalization term and the propagator/Volterra constant explicitly.

The first implementation wave is finite-path and parameterized over a real
interval.  Improper endpoints, sectorial normalization at infinity, and
path-independence are later packets; they must not be hidden inside an assumed
`SolutionData` structure.  Complex independent-variable ODEs are handled first
by pulling them back along a piecewise `C^1` path to a real-time system in a
complex state space.  A genuinely holomorphic ODE package is a possible later
refactor, not a prerequisite.

## 2. Exact algebra before estimates

### 2.1 Scalar operator and residual

On a domain `D`, fix the monic operator

\[
  L_{p,q}y := y'' + p y' + q y
\]

and its inhomogeneous equation `L y = h`.  The signed residual convention is

\[
  \operatorname{resid}_{L,h}(a) := L a-h.
\]

This sign is frozen before any Green-kernel formula.  Linearity should be
exported as exact identities, including

\[
  \operatorname{resid}_{L,h}(y-a)
    =-\operatorname{resid}_{L,h}(a)
  \quad\text{when }Ly=h,
\]

and the corresponding identity for an order-indexed finite approximant.  Norms
are taken only after these cancellations.

The initial API should use ordinary functions and predicates.  A universal
`LinearODE` typeclass is explicitly deferred until at least two substantial
second-order families need the same bundled laws.

### 2.2 General gauge and variable change

Let `z = gamma(t)`, let `y(z) = chi(z) Y(xi(z))`, and write a dot for the
derivative in the new variable.  Wherever the displayed derivatives exist,

\[
\begin{aligned}
 y' &= \chi'Y+\chi\xi'\dot Y,\\
 y''&=\chi(\xi')^2\ddot Y
       +(2\chi'\xi'+\chi\xi'')\dot Y+\chi''Y.
\end{aligned}
\]

For the Schrödinger form `y'' = Qy`, take
`chi = (xi')^{-1/2}` on a declared square-root branch.  Then

\[
  Y=\sqrt{\xi'}\,y,
  \qquad
  \ddot Y=left(
    \frac{Q}{(\xi')^2}
    +\frac12\frac{\{\xi,z\}}{(\xi')^2}
  \right)Y,
\]

where

\[
  \{\xi,z\}=\frac{\xi'''}{\xi'}
      -\frac32\left(\frac{\xi''}{\xi'}\right)^2
\]

is the Schwarzian derivative.  The first theorem should prove the expanded
formula; the Schwarzian form is a corollary.  This makes denominator,
nonvanishing, branch, and differentiability obligations visible and avoids
depending on a premature Schwarzian abstraction.

The residual must transform exactly as well.  If `A` is a comparison function
in the `xi` variable and `a = chi * (A \circ xi)`, then the original residual is
`chi * (xi')^2` times the transformed residual after the first-derivative term
has been cancelled.  That multiplier is part of every later majorant.

### 2.3 First-order path system and scaled jets

For `y'' = Qy+r`, choose a positive scale `s(z)` only when it is useful and set

\[
  J_s y(z)=\binom{y(z)}{s(z)y'(z)}.
\]

For constant `s`, this gives an exact first-order system.  For variable `s`, the
`s' y'` term must be retained; it is not a harmless norm equivalence.  Along a
path `gamma : [0,1] -> D`, an unscaled state satisfies

\[
  \frac d{dt}\binom{y}{y'}(\gamma(t))
  =\gamma'(t)
   \begin{pmatrix}0&1\\Q(\gamma(t))&0\end{pmatrix}
   \binom{y}{y'}(\gamma(t))
   +\gamma'(t)\binom0r.
\]

This path pullback is the bridge to Mathlib's real-time ODE library.  It needs a
separate chain-rule theorem and must record whether derivatives at path corners
are one-sided or the path is treated piecewise.

## 3. Residual-to-solution bridges

### 3.1 Fundamental-matrix/Duhamel route

Let `Phi` be a fundamental matrix for `X' = A X` on `[a,b]`, with an explicit
proof that `Phi(t)` is invertible.  For an approximate state `U` with residual
`R = U'-AU` and the exact state `X` normalized at `a`, the exact gap formula is

\[
  X(t)-U(t)=
  \Phi(t)\Phi(a)^{-1}(X(a)-U(a))
  -\int_a^t\Phi(t)\Phi(s)^{-1}R(s)\,ds.
\]

Consequently,

\[
 \|X(t)-U(t)\|
 \le K(t,a)\|X(a)-U(a)\|
    +\int_a^t K(t,s)\|R(s)\|\,ds,
\quad
 K(t,s)=\|\Phi(t)\Phi(s)^{-1}\|.
\]

This is the preferred finite-path linear theorem because it neither loses an
unnecessary Gronwall exponential nor assumes a contraction.  A coarser
Gronwall corollary is allowed only after the natural kernel bound is exported.

### 3.2 Volterra route

After splitting `A=A_0+B` and using a known comparison propagator `Phi_0`, write

\[
  X(t)=X_0(t)+(TX)(t),\qquad
  (TX)(t)=\int_a^t
   \Phi_0(t)\Phi_0(s)^{-1}B(s)X(s)\,ds.
\]

There are two distinct stability mechanisms.

- **Contraction:** in a weighted sup norm, prove `||T|| <= kappa < 1`.  Banach's
  fixed-point theorem gives existence, uniqueness, and
  `||X-X_0|| <= ||T X_0||/(1-kappa)`.
- **Volterra factorial iterates:** when the kernel is bounded by an integrable
  control `m`, prove
  `||T^n|| <= M^n/n!`, where `M=integral m`.  The Neumann series then converges
  without `M<1`, and produces the sharper `exp M`-type bound appropriate to
  long finite paths.

These are separate theorem cards.  Replacing the factorial argument by a
contraction on arbitrarily short subintervals is a legitimate fallback, but the
subdivision constants and gluing proof must be explicit.

### 3.3 Normalization and fixed-solution quantifiers

For finite initial data, the required public quantifier shape is

\[
 \forall p\ \exists! y_p\;
  \bigl(L_p y_p=h_p\ \wedge\ J y_p(z_0)=v_p\bigr),
\]

followed, for an approximation order `N`, by

\[
 \forall p\ \forall N\ \forall z\in D_{p,N},\qquad
   \|J_{s_{p,N}}y_p(z)-J_{s_{p,N}}a_{p,N}(z)\|
      \le B_{p,N}(z).
\]

The existential quantifier for `y_p` is outside `N`.  The nearby statement
`forall N, exists y_{p,N}` is rejected even if every `y_{p,N}` solves the same
ODE.  Choice may define `y_p` only after existence and uniqueness, and the
normalization theorem is its public characterization.

For normalization at infinity the card must replace an informal phrase such as
“recessive solution” with an exact limit, weighted limit, or Volterra endpoint
condition, prove that the defining improper integral exists, prove uniqueness
in the stated growth class, and then prove agreement with any independently
constructed named function.  Finite IVP uniqueness does not by itself identify
a sectorially normalized solution at infinity.

## 4. Progressive paths

An admissible progressive path should be data, not magic:

\[
  \gamma_x:[0,1]\to D,
  \quad \gamma_x(0)=z_\ast,
  \quad \gamma_x(1)=x,
\]

together with piecewise `C^1` regularity, avoidance of singularities and cuts,
integrability of the pulled-back kernel, and a monotonicity condition such as
nondecrease of `Re(sigma * xi(gamma_x(t)))`.  The sign `sigma`, phase branch,
and orientation belong to the theorem statement.

The programme has three levels:

1. prove a bound along any supplied admissible path;
2. construct a path in explicit geometric domains (rays, sectors, star-shaped
   images, or finite concatenations) and calculate its control integral;
3. prove that solutions constructed along two admissible paths agree, using
   IVP uniqueness or a homotopy theorem on a simply connected nonsingular
   domain.

Level 1 is reusable conditional infrastructure and earns no named or source
coverage.  Level 2 prevents path-existence laundering.  Level 3 prevents a
chosen path from becoming part of the supposedly canonical solution.  An
infimum over all paths is deferred: its measurability, attainment, and API cost
are not justified by an initial consumer.

## 5. Proposed module seams

The provisional dependency direction is

```text
LMLF.Quantitative.Basic
  -> LMLF.ODE.Residual
  -> LMLF.ODE.Transform
  -> LMLF.ODE.PathSystem
  -> LMLF.ODE.Duhamel
  -> LMLF.ODE.Volterra
  -> LMLF.ODE.NormalizedSolution
  -> LMLF.ODE.ProgressivePath
  -> LMLF.ODE.ErrorTransfer
```

`Definitions.*` modules for named special functions do not import this chain.
Turning-point and named applications may import the completed method layer.
`Audit.*` may consume the public declarations but is never imported back.

Do not introduce a comparison-system structure before the Duhamel route and at
least one Volterra consumer expose genuinely shared fields.  Likely stable
seams are a residual function, path admissibility predicate, fundamental-frame
predicate, and explicit propagator majorant.  A record that contains the target
error estimate or a field saying “the desired progressive path exists” is
hypothesis laundering.

## 6. Theorem-card queue and natural-language proof gates

Every row is a separate bounded card.  `NLP` names the required future proof
dossier; it does not assert that the file exists.  **Gate 2** means both the
theorem card and complete NLP require two independent approvals: one
API/semantics review and one proof/quantitative review.  If a later card names a
special function, constructs a canonical continuation, or changes into a
transition/zero/connection packet, it is automatically upgraded to **Gate 3**
with a third structural/circularity referee.

| Queue ID | Genuinely new result and frozen boundary | NLP dossier | Gate | Depends on | Acceptance IDs |
|---|---|---|---:|---|---|
| ODE-001 | Exact scalar residual algebra, including subtraction of an exact solution; no stability claim | `blueprint/proofs/ODE-001.md` | 2 | QB-001 | ODE-T01–T03 |
| ODE-002 | Expanded gauge/change-of-variable identity and Schwarzian corollary, with exact residual multiplier | `blueprint/proofs/ODE-002.md` | 2 | ODE-001 | ODE-T04–T07 |
| ODE-003 | Pullback of a complex scalar equation and its jet to a real-time path system, including piecewise-path gluing | `blueprint/proofs/ODE-003.md` | 2 | ODE-001 | ODE-T08–T10 |
| ODE-004 | Duhamel gap identity and natural propagator-kernel bound with visible initial mismatch | `blueprint/proofs/ODE-004.md` | 2 | ODE-003 | ODE-T11–T14 |
| ODE-005 | Volterra operator bounds and `n!` iterate estimate on a finite interval | `blueprint/proofs/ODE-005.md` | 2 | ODE-004 + integral core | ODE-T15–T18 |
| ODE-006 | Weighted-sup contraction theorem with explicit `kappa < 1` and perturbation bound | `blueprint/proofs/ODE-006.md` | 2 | ODE-004 + pinned `ContractingWith` audit | ODE-T19–T21 |
| ODE-007 | Existence and uniqueness for one finite-IVP normalized solution, plus public characterization | `blueprint/proofs/ODE-007.md` | 2 | pinned ODE API + ODE-003 | ODE-T22–T24 |
| ODE-008 | Improper-endpoint Volterra construction and uniqueness in an explicit weighted growth class | `blueprint/proofs/ODE-008.md` | 2, or 3 when named | ODE-005 | ODE-T25–T28 |
| ODE-009 | Progressive-path existence in one explicit geometry and independence of admissible path | `blueprint/proofs/ODE-009.md` | 2 | ODE-003 + ODE-007 | ODE-T29–T32 |
| ODE-010 | Scaled-jet propagator/envelope theorem, including the `s'` term for variable scaling | `blueprint/proofs/ODE-010.md` | 2 | ODE-004 | ODE-T33–T36 |
| ODE-011 | All-orders residual-to-error transfer for one fixed normalized solution | `blueprint/proofs/ODE-011.md` | 2, or 3 when named | ODE-001 + ODE-004/005 + ODE-007/008 + ODE-010 | ODE-T37–T41 |

No card may cite this planning document as its proof dossier.  Each dossier must
expand all quantifiers, state exact integrability and regularity hypotheses,
derive constants, include the listed adversarial tests, and bind exact proposed
Lean signatures before its `lean_ready` gate can pass.

After implementation, the exact candidate head receives the required
`mathlib_reuse`, `api_dependency`, `quantitative_correctness`, and
`proof_quality` verdicts, plus `source_fidelity` whenever a named/source claim
is present.  The work packet's overall distinct-reviewer minimum remains three
even for a Gate-2 pre-Lean packet.  Filled envelopes, verdicts, and disposition
ledgers remain external to the candidate head.

## 7. Dependency DAG

```text
QB-001 ---------> ODE-001 ---------> ODE-002
                       |
                       +-----------> ODE-003 -----> ODE-004 -----> ODE-010
                                          |             |
pinned real-time ODE API ----------------> ODE-007      +-------> ODE-005
                                          |             +-------> ODE-006
                                          |                         |
                                          +------> ODE-009          +-------> ODE-008
                                                                    |
ODE-001 + ODE-004 + ODE-007/008 + ODE-010 ------------------------> ODE-011
```

The finite integral core is an additional dependency of ODE-004/005 wherever
the chosen Bochner-integral formulation needs it.  ODE-002 is independent of
the Volterra critical path and should not delay generic system stability.

## 8. Acceptance tests and permanent negative regressions

| ID | Required check |
|---|---|
| ODE-T01 | `L(y-a)=Ly-La` is checked with the selected residual sign. |
| ODE-T02 | `y''=0`, exact `y=0`, approximant `a=1`: residual zero but error one.  No residual-only theorem can typecheck against this case. |
| ODE-T03 | Inhomogeneous signs are checked with a constant forcing and a quadratic exact solution. |
| ODE-T04 | Identity map `xi(z)=z`, `chi=1` reduces the transform to the original equation. |
| ODE-T05 | Affine `xi(z)=az+b` exposes exactly the `a^2` derivative factor. |
| ODE-T06 | A non-affine polynomial/rational chart checks the expanded formula against the Schwarzian form. |
| ODE-T07 | Every denominator theorem requires `xi' != 0`; a constant `xi` is rejected. |
| ODE-T08 | Constant path gives zero evolution and identical endpoints. |
| ODE-T09 | Reversal changes orientation and swaps integration endpoints with the correct sign. |
| ODE-T10 | Concatenating two paths gives the product/order expected for propagators. |
| ODE-T11 | `R=0` and matching initial data give zero gap. |
| ODE-T12 | `R=0` with nonmatching data retains exactly the initial-mismatch term. |
| ODE-T13 | For `X'=r`, Duhamel reduces to the fundamental theorem of calculus. |
| ODE-T14 | A long unstable scalar system records exponential amplification rather than the residual alone. |
| ODE-T15 | `T^0` is the identity and the zeroth factorial bound is exact. |
| ODE-T16 | The triangular simplex calculation gives `M^n/n!`, not merely `M^n`. |
| ODE-T17 | Zero kernel gives zero correction and a terminating Neumann series. |
| ODE-T18 | A case with `M>1` still passes the factorial-iterate theorem but fails the contraction premise. |
| ODE-T19 | `kappa=0` yields the exact comparison solution. |
| ODE-T20 | The boundary `kappa=1` is excluded; no division by `1-kappa` is totalized into a claim. |
| ODE-T21 | Changing the weight shows every weight-ratio factor in the kernel norm. |
| ODE-T22 | Zero initial jet for a homogeneous linear equation gives the zero solution by uniqueness. |
| ODE-T23 | Two solutions with identical normalized jet are proved equal on the stated interval/domain. |
| ODE-T24 | Parameter and approximation-order quantifiers are inspected: the chosen solution does not depend on `N`. |
| ODE-T25 | The improper integral has a separately proved integrable majorant. |
| ODE-T26 | The limiting normalization is strong enough for uniqueness; a deliberately too-large growth class fails. |
| ODE-T27 | Endpoint orientation and phase sign are tested on a decaying exponential model. |
| ODE-T28 | Choice is used only after existence and uniqueness and is eliminated by a characterization theorem. |
| ODE-T29 | Rays and finite ray-plus-arc paths satisfy the declared progressive monotonicity with endpoints shown. |
| ODE-T30 | Paths crossing a cut, pole, or zero of the transformation derivative are rejected. |
| ODE-T31 | Two admissible paths to the same point construct the same state under the exact uniqueness hypotheses. |
| ODE-T32 | Domain nonemptiness is witnessed by the base point and at least one nontrivial endpoint. |
| ODE-T33 | Constant scale reduces to conjugation by a diagonal matrix. |
| ODE-T34 | Variable scale includes `s'/s`; a regression omitting it is algebraically false. |
| ODE-T35 | Scale and inverse scale are positive/nonzero on the exact domain. |
| ODE-T36 | A poorly scaled oscillator and its natural scaling demonstrate the conditioning difference without changing the exact solution. |
| ODE-T37 | `N=0` approximant and empty finite sums have a stated residual and bound. |
| ODE-T38 | Small orders are expanded directly and agree with the recurrence/residual generator. |
| ODE-T39 | The error majorant is proved nonnegative on the conclusion domain. |
| ODE-T40 | The conclusion domain is nonempty/reachable in every named specialization. |
| ODE-T41 | One public fixed-solution theorem yields every order; no order-indexed target function occurs in its type. |

## 9. Mathlib reuse checkpoints

The pinned audit already found useful real-time ODE, Gronwall, contraction, and
Bochner-integral infrastructure, but no ready-made complex-holomorphic linear
ODE, Liouville transformation, Volterra-factorial, or progressive-path package.
Before freezing each card, re-run local source search against the exact pin and
record exact signatures/imports.  In particular:

- compare ODE-007 with `IsPicardLindelof`, its existence theorem, and
  `ODE_solution_unique`; do not wrap them if a direct specialization suffices;
- use `ContractingWith` for ODE-006 if its fixed-point and distance results fit
  the weighted function space without adapter noise;
- compare ODE-004 with the existing Gronwall approximate-trajectory theorems,
  but retain the natural fundamental-matrix bound when Gronwall is strictly
  coarser;
- search for simplex/iterated-integral lemmas before implementing ODE-005;
- keep matrix, continuous-linear-map, and norm imports narrow and verified.

## 10. Known hard research questions

1. What is the smallest durable representation of a fundamental matrix and its
   inverse in current Mathlib: matrices, linear equivalences, or continuous
   linear maps?  The answer affects every kernel and connection theorem.
2. Can factorial Volterra iterates be proved cleanly for merely integrable
   kernels, or should the first card assume a continuous scalar majorant?
3. Which weighted sup space gives a complete metric space while keeping endpoint
   and measurability obligations tractable?
4. How should piecewise smooth complex paths be represented so concatenation,
   reversal, line integrals, and endpoint derivatives compose without a large
   bespoke path library?
5. Can path independence be reduced to existing real-time IVP uniqueness, or is
   a holomorphic identity/monodromy theorem needed on the intended domains?
6. Which normalization-at-infinity classes are strong enough for uniqueness yet
   weak enough to include the named Airy/Bessel/Hankel solutions?
7. Can one state sharp propagator bounds without choosing a matrix norm whose
   constants later contaminate Olver's natural envelopes?
8. When parameter derivatives are added, can differentiation under the Volterra
   integral preserve explicit constants and keep spatial and parameter
   derivatives visibly distinct?
9. Is a reusable `residual_nf` tactic justified after two family implementations,
   and can it expose rather than solve branch and nonvanishing side conditions?
10. Which results are plausible Mathlib contributions independent of special
    functions: path-pulled linear systems, Volterra factorial iterates, or
    fundamental-matrix Duhamel bounds?

## 11. Exit criteria for the generic method layer

This track is ready for a first named consumer only when:

- every used queue entry has a frozen theorem card, complete NLP, required
  independent approvals, and an external `lean_ready: pass` envelope;
- exact transformations and residuals are public independently of their bounds;
- one fixed normalized solution is constructed and characterized before the
  all-orders theorem;
- path existence, integrability, kernel bounds, and majorant nonnegativity are
  proved rather than stored as application-equivalent fields;
- the negative regressions ODE-T02, ODE-T20, ODE-T24, and ODE-T34 remain;
- the implementation imports no named function and no downstream turning-point
  or connection module.
