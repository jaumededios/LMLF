# Bessel and cylinder-function family programme

**Status:** planning only; no provisional ID below is registered or authorized  
**Current source evidence:** contents-only leads for `J`, `I`, later cylinder families, and Chapter 12 comparison auxiliaries  
**Mathlib position at the pin:** no named classical Bessel `J`, `Y`, `I`, `K`, or Hankel object was found; regularized hypergeometric series are a candidate shared substrate

## Family boundary and source honesty

This wave plans first- and second-kind Bessel functions, modified Bessel functions, Hankel functions, any source-confirmed “cylinder function” aliases or bases, and the exact model properties later required for simple-pole comparison systems. It does not automatically include every modern Bessel relative. Spherical functions, Kelvin functions, Nicholson combinations, Anger/Weber functions, Struve functions, and arbitrary cylinder-function linear combinations enter only if a locked-edition body occurrence or a separately labelled project need confirms them. Nicholson/Anger/Struve leads are tracked in [`remaining_families.md`](remaining_families.md).

The present evidence is discovery-level:

- `OLV10P-O0013` and `bessel_j_candidate` are based on the Chapter 2 §9 contents heading only.
- `OLV10P-O0014` and `bessel_i_candidate` are based on the Chapter 2 §10 contents heading only.
- `OLV10P-O0018` is a Chapter 7 contents lead to Bessel, Hankel, modified Bessel, “other cylinder,” confluent hypergeometric, Whittaker, and Struve material. Its member split is unresolved.
- `OLV10P-O0022` is a Chapter 12 contents lead to Bessel/modified-Bessel simple-pole models and auxiliaries. No comparison basis or auxiliary notation is resolved.

No current Bessel entity is confirmed from a locked mathematical-body occurrence. DLMF formulas below are convention candidates and adversarial checks, not statements that Olver uses exactly those normalizations.

## Source and normalization questions

### First-kind Bessel `J`

1. Collate the exact order and argument positions, glyph, branch for $(z/2)^\nu$, and initial series domain.
2. Determine whether the source treats $J_n$ for integral order as entire in $z$ separately from the principal-cut nonintegral-order function.
3. Record the value or limiting behavior at $z=0$ by order regime. A totalized complex power at zero is not a continuation theorem.
4. Determine how reciprocal Gamma factors at negative integral orders are interpreted and which relation between $J_{-n}$ and $J_n$ is used.
5. Record spatial derivative notation separately from order derivatives. Later large-order work cannot infer parameter regularity from holomorphy in (z).

### Second-kind `Y` and Hankel functions

1. Verify whether the nonintegral-order quotient
   \[
   Y_\nu(z)=\frac{\cos(\pi\nu)J_\nu(z)-J_{-\nu}(z)}{\sin(\pi\nu)}
   \]
   matches the printed convention, including numerator order, signs, and branch.
2. Determine how integral orders are defined: parameter limit, recurrence plus normalization, integral formula, or another continuation. Division by zero at integral order is not an acceptable definition.
3. Collate the source branch cut and boundary-value convention for `Y`.
4. Verify the exact Hankel signs and basis order. The modern candidate relations $H^{(1)}=J+iY$ and $H^{(2)}=J-iY$ are normalization checks until collated.
5. Determine whether the source uses scaled Hankel functions or phase-normalized variants as distinct entities.

### Modified functions `I` and `K`

1. Collate the series/rotation convention relating `I` to `J`, including every factor depending on order and the selected branch.
2. Determine the principal cut and origin behavior by order regime.
3. Record the nonintegral-order construction of `K`, its integral-order continuation, and its normalization relative to $I_\nu$ and $I_{-\nu}$.
4. Verify whether a factor of $\pi/2$, a sine denominator, or an exponential phase is present. Do not transfer a modern normalization to the source.
5. Determine which real positivity, monotonicity, and Wronskian properties are needed by Chapter 12 comparison arguments.

### Cylinder and simple-pole comparison objects

1. Determine whether “cylinder function” denotes a generic linear combination, a named basis member, or a specific normalization in each occurrence.
2. Enumerate each Chapter 12 modulus, phase, envelope, or auxiliary symbol, its real/complex domain, and its relation to the baseline functions.
3. Record the large parameter, spatial argument, and every scaling used to turn the source equation into the comparison equation.
4. Separate exact Bessel identities from comparison estimates and from transformed solutions of another ODE.
5. Confirm whether source formulas use ordinary derivatives, derivatives of a scaled argument, or a scaled two-component state.

## Construction versus reuse plan

### Shared series substrate

The first construction investigation uses the pinned `Complex.regularizedHGFun` specialization corresponding to regularized $0F1$. Its coefficient denominator already contains a factorial and a Gamma factor, making it a plausible shared kernel for `J` and `I`. Before use, a separate bounded substrate card must prove the exact coefficient specialization, entire summation in the spatial variable, parameter semantics, and the exceptional denominator behavior required by these families.

That substrate does not itself define a Bessel function. `J` and `I` additionally require order-dependent prefactors, argument rescaling, branches, and source normalization. The public identification must reconstruct a recognizable series. For `J`, a convention candidate on the principal cut is

\[
J_\nu(z)=(z/2)^\nu
\sum_{k\ge0}\frac{(-1)^k(z^2/4)^k}{k!\,\Gamma(\nu+k+1)}.
\]

This formula is used here to enumerate proof obligations, not to claim an Olver transcription.

### Object-by-object plan

| Object | Planned construction/reuse decision | Required proof seam |
|---|---|---|
| `J` | Construct from one regularized $0F1$ kernel plus a branch-explicit prefactor, unless a later pin audit finds a canonical object. Consider a separate entire integer-order corollary rather than forcing one false global formula. | `HasSum`-level reconstruction, Bessel equation, branch domain, origin cases, order/argument regularity, and normalization. |
| `I` | Reuse the same kernel with the modified sign/rescaling; prove the exact relation to the accepted `J` only on a domain where phase powers are coherent. | A missing order-dependent phase must be visible; no informal substitution $z\mapsto iz$. |
| `Y` | Define nonintegral orders by a proved combination of accepted `J` functions if that matches the collated convention. Define integral orders by an actual parameter-continuation construction. | Parameter regularity near integers and the limiting value are separate from spatial holomorphy. |
| `K` | Select a nonintegral `I`-combination or integral representation after source audit, then prove exceptional-order continuation. | Exact scale factor, cut, reality/positivity, and integer-order limit. |
| `H^(1)`, `H^(2)` | Define as exact finite combinations of accepted `J` and `Y` if source conventions match. | Sign, basis order, branch inheritance, Wronskians, and any scaled variants. |
| Generic cylinder basis | Prefer a predicate/theorem about a linear combination of the accepted basis unless the source names a value-changing normalization. | Do not create a public “cylinder function” that hides coefficients or normalization. |

Integral representations, generating functions, recurrence relations, and ODE characterizations should normally be identification/property theorems for these single objects. A second public construction is permitted only with a proved equality and a concrete reuse benefit.

Baseline definitions may import the accepted hypergeometric kernel, reciprocal Gamma, and low-level branch support. They may not import large-order Bessel estimates, simple-pole comparison theorems, zero locations, connection matrices, or source-recovery modules.

## Dependency graph

```text
locked-edition body audit: Ch. 2 §§9-10, Ch. 7, Ch. 12
             |
             +--> exact entity/alias/normalization split
             |
pin audit + regularized 0F1 + reciprocal-Gamma facts + branch support
             |
             +--> J construction/identification
             |       |
             |       +--> Y for nonintegral order
             |       |        |
             |       |        +--> parameter continuation to integral order
             |       |                     |
             |       |                     +--> Hankel functions
             |       |
             |       +--> integer-order entire and origin theorems
             |
             +--> I construction/identification
                     |
                     +--> K for nonintegral order
                              |
                              +--> parameter continuation to integral order
             |
      exact recurrences, derivatives, Wronskians, real agreement
             |
      positive moduli/envelopes and simple-pole comparison identities
             |
      large-order/pole-transition named applications
             |
      zeros and connection matrices
```

The two exceptional-order continuation branches are deliberately explicit. A generic continuation toolkit may serve both, but acceptance of `Y_n` cannot be inferred from acceptance of `K_n` or vice versa.

## Required natural-language proof dossiers

### `NLP-BES-KERNEL-001` — regularized $0F1$ substrate

Record the exact pinned declarations, coefficient specialization, entire convergence in the spatial variable, and parameter behavior. Prove the reusable series equality without naming it `J` or `I`. State explicitly which denominator parameters are covered by regularization and what further parameter analyticity is absent from Mathlib. This dossier is jointly consumed by Airy and Bessel construction work and is owned by the hypergeometric substrate queue.

### `NLP-BES-J-001` — first-kind construction

Fix order and argument types, branch domain, prefactor, and series. Prove summation, differentiation, the Bessel equation, source/conventional normalization, integer-order simplifications, and origin behavior. Prove real agreement in the real order/positive argument regimes used downstream. Include negative integral orders and a nonintegral order crossing the cut as adversarial cases.

### `NLP-BES-I-001` — modified first-kind construction

Derive the modified series from the shared kernel, prove the modified Bessel equation and normalization, and establish any rotation relation to `J` with its exact order-dependent phase and branch domain. Treat real positivity only if required and proved.

### `NLP-BES-YCONT-001` — second-kind continuation

Start with the nonintegral quotient on a fixed cut domain. Prove its equation, linear independence, and normalization. Then prove the parameter limit at each integral order using actual parameter regularity; define or identify the integral-order object and prove agreement with the nonintegral family where meaningful. This definition/continuation dossier requires structural review.

### `NLP-BES-KCONT-001` — modified second-kind continuation

Give the exact nonintegral construction and normalization, prove the chosen cut and real-positive behavior, establish the integral-order limit, and reconcile any integral representation used. The dossier must expose every scale factor and cannot use totalized sine division at integral order.

### `NLP-BES-HANKEL-001` — Hankel basis

Prove exact combination identities, equations, branch inheritance, Wronskians, conjugation or real-axis boundary relations, and the exact normalization of any scaled variants. This dossier includes a sign table and verifies it independently from the definitions.

### `NLP-BES-PARAM-001` — order regularity

Separate holomorphy/differentiability in the spatial argument from regularity in the order. Prove precisely the parameter continuity or differentiability used for exceptional-order limits and large-order transformations. Branch-generated logarithmic terms are carried explicitly.

### `NLP-BES-ENV-001` — simple-pole comparison auxiliaries

After collation enumerates the objects, define each modulus, phase, or envelope in expanded form, prove positivity/nonvanishing and exact Wronskian relations, then prove the bounds consumed by the comparison system. A source auxiliary and a project control function are kept distinct.

## Provisional theorem-card queue

| Provisional ID | Bounded target | Provisional packet theorem class | Packet coverage class | Principal prerequisites |
|---|---|---|---|---|
| `DEF-BES-001` | Principal-cut `J` plus separately stated integer-order/origin facts | `definition_identification` | `entity_identification` | `DEF-HG0F1-001`; reciprocal Gamma as needed; `NLP-BES-J-001` |
| `DEF-BES-002` | Principal-cut `I` and exact modified-equation normalization | `definition_identification` | `entity_identification` | `DEF-HG0F1-001`; `NLP-BES-I-001` |
| `DEF-BES-003` | Nonintegral-order `Y` only | `definition_identification` | `entity_identification` | `DEF-BES-001`; collated quotient convention; first part of `NLP-BES-YCONT-001` |
| `DEF-BES-004` | Integral-order continuation of `Y` and compatibility with the nonintegral family | `definition_identification` | `entity_identification` | `DEF-BES-003`; `ANA-BES-001`; full `NLP-BES-YCONT-001` |
| `DEF-BES-005` | Nonintegral `K`, integral-order continuation, and source-confirmed integral bridge | `definition_identification` | `entity_identification` | `DEF-BES-002`; `ANA-BES-001`; `NLP-BES-KCONT-001` |
| `DEF-BES-006` | `H^(1)` and `H^(2)` exact combinations and branch conventions | `definition_identification` | `entity_identification` | `DEF-BES-003/004`; `NLP-BES-HANKEL-001` |
| `ANA-BES-001` | Order-parameter regularity sufficient for the explicitly listed exceptional limits | `qualitative_support` | `infrastructure` | Shared kernel parameter facts; `NLP-BES-PARAM-001` |
| `DEF-BES-007` | Finite, collated set of value-changing scaled/cylinder normalizations | `definition_identification` | `entity_identification` | Locked entity split; accepted basis functions |
| `CMP-BES-001` | Exact Bessel/modified-Bessel comparison basis and Wronskian package for a simple pole | `exact_identity` | `infrastructure` | Accepted definitions; exact transformed equation |
| `CMP-BES-002` | Finite set of confirmed moduli/phases/envelopes and their zero-safe bounds | `qualitative_support` | `infrastructure` | Auxiliary body audit; `CMP-BES-001`; `NLP-BES-ENV-001` |
| `AUD-BES-001` | Expanded series, branch, origin, integer-order, sign, Wronskian, and real-agreement regressions | `audit_regression` | `infrastructure` | Accepted public Bessel declarations |

`DEF-HG0F1-001` is owned by [`hypergeometric_legendre.md`](hypergeometric_legendre.md). Its appearance here is a dependency, not a duplicate queue row. No provisional card represents “all cylinder functions,” and no large-order source theorem is smuggled into a definition card.

## Acceptance gates

### Baseline first-kind gate

- Locked source evidence is resolved before an Olver normalization is claimed.
- The regularized-kernel specialization and any Gamma-factor simplifications are proved at the pin.
- `J` and `I` each have one actual object, a convergent recognizable series, the correct equation, branch domain, normalization, and real agreement.
- Integral and nonintegral order regimes at the origin are separated.
- Spatial and order regularity are stated independently.
- Public audits expose the power of two, sign pattern, order/argument positions, and one low integer order.

### Second-kind and Hankel gate

- Nonintegral formulas have explicit sine/nonvanishing hypotheses.
- Integral-order `Y` and `K` values come from proved parameter continuation or another conventional construction, never from totalized division.
- Parameter regularity supporting the limit is accepted before the exceptional-order card.
- Cuts and boundary-value conventions are public.
- Hankel signs, Wronskians, and scaled variants are independently audited.
- Definition/continuation packets have two mathematical approvals plus a structural/circularity approval.

### Simple-pole comparison gate

- The transformed equation and comparison basis are exact, with all order and argument rescalings visible.
- Moduli/envelopes are positive on a proved reachable domain and remain meaningful at zeros of basis components.
- Residual, stability, normalization, and fixed-solution compatibility are separate accepted dependencies.
- Every named source application has an occurrence-bound finite theorem, explicit majorant, nonnegativity, and domain reachability.

## Negative and adversarial tests

1. **Power of two:** the expanded `J` series must detect replacing $(z/2)^\nu$ or $z^2/4$ with an unscaled power.
2. **Alternating sign:** `J` and `I` low-order coefficients distinguish the oscillatory and modified series.
3. **Order/argument reversal:** the audit fixes which input is $\nu$ and which is $z$.
4. **Origin by order:** reject a global theorem assigning a nonintegral-order value at zero solely through totalized complex power.
5. **Negative integral order:** test the accepted relation between $J_{-n}$ and $J_n$; reciprocal Gamma zeros must cancel the correct coefficients.
6. **`Y` at integer order:** totalized division by $\sin(\pi n)=0$ must not define the classical continued value.
7. **`K` scale:** an expanded nonintegral identity must detect a missing $\pi/2$, sine, or sign factor once the source normalization is frozen.
8. **Hankel signs:** `H^(1)` and `H^(2)` are distinguished by the sign of the `iY` term and Wronskian orientation.
9. **Branch boundary:** a principal-cut identity cannot be rewritten across the cut without a separate boundary-value theorem.
10. **Rotation phase:** the `I`/`J` relation must include order-dependent branch factors; substituting (iz) syntactically is insufficient.
11. **Parameter versus spatial derivative:** spatial holomorphy cannot justify the integral-order parameter limit.
12. **Equation-only identification:** the Bessel equation without normalization admits a two-dimensional solution space.
13. **Zero-safe errors:** no relative comparison estimate may divide by `J`, `Y`, `I`, `K`, or a Hankel component without a proved zero-free domain.
14. **Circular import:** construction/identification fails the dependency audit if it imports a large-order or pole-transition theorem.

## Explicit unknowns and blockers

- No locked 1997 Bessel-family body occurrence has been registered, transcribed, or reconciled.
- The Chapter 7 member split and the meaning of “other cylinder functions” are unknown.
- The Chapter 12 comparison basis, Wronskian convention, and auxiliary symbols are unknown.
- Modern DLMF formulas have not been checked against the locked source's exact scale, branch, and argument order.
- The regularized $0F1$ substrate is feasible but no named Bessel construction has been compiled or reviewed.
- Mathlib support for parameter analyticity of the regularized kernel has not been established; this may be the critical blocker for exceptional-order continuation.
- The actual construction choice for `Y_n` and `K_n` is unresolved.
- Required real restrictions, cut boundary values, and origin conventions depend on the eventual source applications.
- It is unknown which scaled Hankel, spherical, Nicholson, or other cylinder normalizations merit distinct entities.
- No proposed card has exact signatures, a frozen proof dossier, authorization, or manifest membership.

## Downstream asymptotic consumers

Potential consumers after direct collation and identification include:

- Chapter 7 large-order Bessel, Hankel, modified-Bessel, and cylinder-function finite expansions;
- Chapter 9 saddle/coalescing configurations producing Bessel or Nicholson-type models;
- Chapter 12 simple-pole comparison systems and their real/complex auxiliaries;
- uniform value and scaled-derivative bounds across pole transitions;
- explicit recurrence and derivative estimates at large argument or order;
- local zero displacement for `J`, `Y`, and combinations, followed separately by global zero indexing;
- exact and quantitative connection matrices among `J/Y`, Hankel, and `I/K` bases;
- hypergeometric and Whittaker normalization bridges that use the same Gamma and $0F1$ substrates.

Generic ODE residual/stability, Cauchy transport, branch geometry, and zero-perturbation work can proceed conditionally. No named Bessel consumer may be released until the exact function and exceptional-order semantics it uses have passed the family gates.
