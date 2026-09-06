# Remaining named-family portfolios

**Status:** planning only; no provisional ID below is registered or authorized  
**Scope rule:** each portfolio is independently bounded; “remaining families” is not a manifest member and cannot authorize an open-ended implementation  
**Source rule:** only locked-edition mathematical-body occurrences can confirm family membership and normalization

## Purpose and portfolio split

This file holds the named families not assigned to the Gamma, Airy/Scorer, Bessel/cylinder, or hypergeometric/Legendre programmes. It is deliberately split into independent portfolios:

1. exponential, logarithmic, sine, and cosine integrals;
2. error functions, Dawson's integral, and Fresnel integrals;
3. parabolic-cylinder functions;
4. source-confirmed classical orthogonal polynomials;
5. Riemann zeta and Bernoulli objects;
6. Anger/Weber, Struve, and Nicholson-type objects;
7. named auxiliary, scaled, envelope, phase, and coefficient functions.

An item moves from this holding file to a focused family file once the locked body audit establishes a substantial member list or the first bounded card is ready. Goodwin–Staton, incomplete Beta, Faddeeva, generalized exponential integrals, spherical Bessel, conical, Lommel, Lambert `W`, and similar modern relatives remain unpromoted. They receive neither an entity nor a card merely because they are adjacent in DLMF or mathematically related to a confirmed family.

## Evidence ledger

| Portfolio | Current evidence | Honest present claim |
|---|---|---|
| Exponential-related integrals | `OLV10P-O0007` is direct 2010-preview body material at Chapter 2 §3.1 but has an unsafe OCR symbol and unresolved entity split; `OLV10P-O0008` is a contents heading; `OLV10P-O0023` is a Chapter 14 revisit heading | One unresolved exponential-integral definition is visible in the preview, including a negative-real-axis principal-cut indication; exact `Ei`/`E1` identity and all other members are unresolved. |
| Error/Dawson/Fresnel | `OLV10P-O0009`, contents only | The heading is a discovery lead. No variant, scale, or source entity is confirmed. |
| Parabolic cylinder | `OLV10P-O0017`, contents only at Chapter 6 §6 | A large-order application family is a lead. `U`, `V`, and `D` parameterizations are not yet confirmed. |
| Orthogonal polynomials | `OLV10P-O0011`, contents only at Chapter 2 §§6–7 | The source must enumerate body members; no DLMF family tree may be imported wholesale. |
| Zeta | `OLV10P-O0015` and `riemann_zeta_candidate`, contents only | Even the identity as Riemann zeta remains provisional until the body is checked. |
| Bernoulli | `OLV10P-O0019`, contents only at Chapter 8 §1 | Bernoulli polynomials are a lead; the separate status of numbers/functions and the $B_1$ convention are unresolved. |
| Anger/Struve/Nicholson | `OLV10P-O0020` is an Anger heading; `OLV10P-O0018` includes Struve in Chapter 7 contents; Nicholson is only a prose audit lead at present | Exact member split and Olver-specific factors are unresolved. |
| Auxiliaries | Airy and Bessel contents leads mention auxiliary functions; the architectural blueprint anticipates envelopes/control objects | Each printed auxiliary must be individually collated; project controls are `project_extra`. |

## Portfolio A — exponential, logarithmic, sine, and cosine integrals

### Source and normalization questions

- Visually resolve the symbol and formula in `OLV10P-O0007`: `Ei`, `E1`, another exponential integral, or a local auxiliary.
- Split `Ei`, `E1`, logarithmic integral, sine integral, and cosine integral only when their body definitions or uses are inspected.
- Record integration interval/path, endpoint interpretation, principal value if any, logarithm branch, cut, and boundary values on the cut.
- Determine whether real and complex variants are one continued object or distinct source normalizations.
- Reconcile the Chapter 14 exponential-integral object to the Chapter 2 entity, preserving a separate occurrence even if the entity is identical.
- Record additive constants in logarithmic/cosine integrals; a derivative alone does not identify the normalization.

### Construction versus reuse and dependencies

The pin audit found no named exponential/sine/cosine-integral API. A fresh pin search remains mandatory. Candidate constructions are honest real improper/principal-value integrals followed by continuation, or a complex cut-plane integral/series with explicit logarithm. The chosen object must have a base-domain integral, branch-aware continuation, and exact real agreement. Related functions should be connected by proved transformations rather than maintained as unrelated constructions.

```text
locked body collation and Ei/E1/member split
            |
pin reuse audit + improper/principal-value integral support + log branch
            |
one base exponential-integral object on an honest domain
            |
continuation and cut boundary values
            |
confirmed logarithmic/sine/cosine members and exact relations
            |
Chapter 14 reconciliation and named remainder applications
```

### Proof dossiers and card queue

- `NLP-EI-BASE-001`: exact integral semantics, convergence, branch/cut, equation or derivative identity, additive normalization, and real agreement.
- `NLP-EI-CONT-001`: continuation from the base domain, overlap uniqueness, boundary values, singular/logarithmic behavior at zero, and exceptional-value policy.
- `NLP-EI-REL-001`: each confirmed relation among `Ei`, `E1`, logarithmic, sine, and cosine integrals, with phases and additive constants.

| Provisional ID | Bounded target | Packet theorem / coverage class | Prerequisites |
|---|---|---|---|
| `DEF-EI-001` | The single object resolved from `OLV10P-O0007`, on its base integral domain | `definition_identification` / `entity_identification` | Locked symbol/formula collation; reuse audit; `NLP-EI-BASE-001` |
| `DEF-EI-002` | Cut-plane continuation and boundary convention for that object | `definition_identification` / `entity_identification` | `DEF-EI-001`; `NLP-EI-CONT-001`; structural review |
| `DEF-EI-003` | Finite list of additional confirmed logarithmic/sine/cosine members and exact relations | `definition_identification` / `entity_identification` | Body member split; `NLP-EI-REL-001`; split before registration if declarations are not tightly coupled |
| `AUD-EI-001` | Expanded cut, additive-constant, sign, and real-agreement regressions | `audit_regression` / `infrastructure` | Accepted public objects |

### Acceptance gates, negative tests, unknowns, and consumers

The gate requires an exact symbol/member split, one actual object per normalization, proved integral convergence or principal-value semantics, a branch-aware continuation, explicit behavior at zero and on cut boundaries, real/complex agreement, and independent expanded audits. Continuation packets require the structural/circularity reviewer.

Negative tests must distinguish `Ei` from `E1`, upper from lower path orientation, a missing sign in the exponential, principal value from an ordinary divergent integral, and two antiderivatives differing by an additive constant. A theorem must fail if it crosses the cut without a boundary convention or treats a totalized divergent integral as classical.

Unknowns include the OCR symbol in the only visible body definition, the entire member list, the Chapter 14 normalization, and the availability of useful pinned Mathlib primitives. Prospective consumers include Chapter 14 finite remainder models, endpoint/saddle integral transformations, branch-sensitive connection formulas, and relations to incomplete Gamma—but only after the exact entities are reconciled.

## Portfolio B — error functions, Dawson's integral, and Fresnel integrals

### Source and normalization questions

- Enumerate `erf`, complementary/scaled error functions, Dawson's integral, and each Fresnel member only from body occurrences.
- Freeze every prefactor, argument rescaling, and phase. In particular, test whether a Fresnel phase uses $\pi t^2/2$, $t^2$, or another scale.
- Determine whether functions are introduced as real integrals, entire complex continuations, or both.
- Record path and endpoint conventions, values at zero/infinity if used as normalizations, parity, and derivative variable.
- Treat a scaled complementary error function and Faddeeva-type object as distinct only if the source confirms them.

### Construction versus reuse and dependencies

No named error/Fresnel implementation was found in the pinned audit. Audit again at card time. Error functions are natural entire-series or path-independent integral constructions; real integral formulas and the complementary identity can then identify named variants. Dawson can be derived from an accepted error-family object or constructed by its own integral/ODE if that matches the source. Fresnel functions may use real oscillatory integrals with an entire series bridge; their scale must be frozen before sharing infrastructure.

```text
locked member/scale audit
       |
pin audit + entire-series/path-integral infrastructure
       |
error base function -----> complementary/scaled variants -----> Dawson bridge
       |
Fresnel base pair with exact phase scale
       |
real agreement, rotations, derivatives, and audits
       |
Gaussian saddle and transition applications
```

### Proof dossiers and card queue

- `NLP-ERF-001`: entire construction, real integral, derivative, parity, zero normalization, and complement relation.
- `NLP-DAW-001`: actual construction, exact scale relative to accepted error functions if used, ODE/integral characterization, and uniqueness.
- `NLP-FRE-001`: exact sine/cosine phase, convergence, entire continuation, parity, derivatives, and real agreement.

| Provisional ID | Bounded target | Packet theorem / coverage class | Prerequisites |
|---|---|---|---|
| `DEF-ERF-001` | Base error function and exactly one confirmed complementary normalization | `definition_identification` / `entity_identification` | Body collation; `NLP-ERF-001` |
| `DEF-ERF-002` | Finite list of source-confirmed scaled error variants | `definition_identification` / `entity_identification` | `DEF-ERF-001`; exact scale audit |
| `DEF-DAW-001` | Dawson object with integral/ODE and exact error-function bridge | `definition_identification` / `entity_identification` | `DEF-ERF-001` if used; `NLP-DAW-001` |
| `DEF-FRE-001` | Source-confirmed Fresnel pair with exact phase and real/complex identifications | `definition_identification` / `entity_identification` | Body collation; `NLP-FRE-001` |
| `AUD-ERFRE-001` | Expanded zero, parity, derivative, complement, phase-scale, and real-agreement tests | `audit_regression` / `infrastructure` | Accepted public objects |

### Acceptance gates, negative tests, unknowns, and consumers

The gate requires the locked member list, `HasSum` or path-integral validity, exact constants, one public object per normalization, real/complex agreement, and derivative theorems on honest neighborhoods. A scaled function is not an alias unless equality is literal on the same inputs.

Negative tests detect a missing $2/\sqrt\pi$, `erf`/`erfc` interchange, a wrong Dawson exponential scale, Fresnel sine/cosine interchange, and the factor $\pi/2$ in the quadratic phase. Tests include zero, parity, one derivative, and a rotation identity only after its branch is frozen. Faddeeva or generalized error functions must not appear without source or project-extra registration.

The exact variants, scale factors, and source formulas are all unknown because `OLV10P-O0009` is contents-only. Prospective consumers are Gaussian/Laplace and saddle models, coalescing configurations, complex continuation estimates, and error-function transition formulas selected by future occurrences.

## Portfolio C — parabolic-cylinder functions

### Source and normalization questions

- Determine which of `U`, `V`, $D_\nu$, or other symbols occur, and freeze parameter/argument order.
- Collate the exact differential equation and the parameter conversion between notations.
- Check the DLMF candidate $D_\nu(z)=U(-\nu-1/2,z)$ against the locked source before adopting it.
- Record branches, real normalization, Wronskian, recessive/dominant solution choice, and exceptional parameter behavior.
- Determine whether the Chapter 6 large-order statement uses the baseline function or a scaled version.

### Construction versus reuse and dependencies

No named parabolic-cylinder object was found in the pin audit. The preferred first investigation derives the family from accepted Kummer `M/U` functions with an exact parameter transformation and power/exponential prefactors. A normalized ODE/IVP construction is the fallback if it avoids circular dependence and provides cleaner parameter regularity. An asymptotic recessiveness statement from the target Chapter 6 theorem may not serve as an assumed baseline definition.

```text
locked Ch. 6 member and normalization audit
          |
accepted Kummer M/U + branch support    or    independent normalized ODE constructor
          |                                      |
          +------------------+-------------------+
                             v
              identified parabolic-cylinder basis
                             |
              exact conversions, Wronskians, real agreement
                             |
              Chapter 6 large-order finite applications
```

### Proof dossiers and card queue

- `NLP-PCY-001`: source parameter convention, construction, differential equation, exact Kummer conversion or IVP normalization, branches, and real agreement.
- `NLP-PCY-BASIS-001`: second solution/basis, exceptional parameters, Wronskian, and conversion among every confirmed notation.

| Provisional ID | Bounded target | Packet theorem / coverage class | Prerequisites |
|---|---|---|---|
| `DEF-PCY-001` | One primary source-confirmed parabolic-cylinder object | `definition_identification` / `entity_identification` | Locked member audit; `DEF-KUM-001/002` or accepted ODE support; `NLP-PCY-001` |
| `DEF-PCY-002` | Finite set of alternate parameterizations and a normalized basis | `definition_identification` / `entity_identification` | `DEF-PCY-001`; `NLP-PCY-BASIS-001`; structural review |
| `AUD-PCY-001` | Expanded parameter-shift, equation, Wronskian, branch, and real-value regressions | `audit_regression` / `infrastructure` | Accepted public objects |

### Acceptance gates, negative tests, unknowns, and consumers

Acceptance requires a confirmed member split, exact parameter conversion, noncircular normalization, uniqueness, branches, exceptional values, and a readable equation audit. Test the sign and half-unit parameter shift, argument scaling, Gaussian prefactor, `U/V/D` interchange, Wronskian orientation, and a parameter where a basis degenerates. The source symbols and normalizations are presently unknown, and the Kummer dependency is itself planning-only. The principal consumer is the Chapter 6 large-order family; later turning-point, zero, and connection consumers are admitted only when collated.

## Portfolio D — classical orthogonal polynomials

### Source and normalization questions

- Audit Chapter 2 §§6–7 body pages and list only the named polynomial families actually defined or used.
- For each member, record parameter order, polynomial degree, leading coefficient, weight, support interval, Rodrigues/generating formula, and orthogonality normalization.
- Distinguish monic, orthonormal, and classical normalizations as value-changing entities.
- Record exceptional parameters, finite-support/degenerate cases, endpoint values, and real versus complex argument use.
- Determine which later applications reuse the same objects and which rescale them for asymptotics.

### Construction versus reuse and dependencies

The current Mathlib audit did not catalogue orthogonal-polynomial families, so a complete pin search is the first technical task. Prefer existing polynomial objects and prove normalization bridges. Otherwise construct each confirmed family as an exact finite polynomial from a recurrence, Rodrigues formula, or hypergeometric expression, choosing the route that makes degree and normalization transparent. Orthogonality and norm formulas are properties, not necessarily constructors.

```text
locked Chapter 2 body member list
        |
per-member pin reuse audit + exact polynomial/hypergeometric substrate
        |
one normalized polynomial sequence per confirmed member
        |
degree/leading coefficient/recurrence/generating identities
        |
orthogonality and real-zero properties when consumed
        |
large-degree finite asymptotic applications
```

### Proof dossiers and card queue

- `NLP-ORTH-MEMBER-001`: a template instantiated separately for each confirmed family, including exact finite construction, degree, normalization, recurrence, parameter range, and any orthogonality measure.
- `NLP-ORTH-BRIDGE-001`: hypergeometric or alternate-normalization bridge, with all factors and exceptional parameters.

The queue reserves the pattern `DEF-ORTH-<MEMBER>-001`; it is not a wildcard card. Each `<MEMBER>` is replaced by a confirmed canonical entity ID and registered as a separate bounded card. `AUD-ORTH-<MEMBER>-001` similarly contains low-degree, leading-coefficient, endpoint, and normalization regressions. A cross-family recurrence infrastructure card may be proposed only after at least two accepted consumers demonstrate a stable abstraction.

### Acceptance gates, negative tests, unknowns, and consumers

Each member passes separately: locked source occurrence, exact finite degree, parameter domain, one normalization, reuse comparison, low-degree expansions, and the properties actually needed downstream. Tests distinguish monic from classical/orthonormal forms, degree from parameter, a sign in the leading coefficient, weight normalization, endpoint values, and degenerate parameter cases. A generic orthogonal-polynomial record cannot replace identification of a named sequence.

The entire member list and all source normalizations are unknown because `OLV10P-O0011` is contents-only. Potential consumers include large-degree endpoint/turning-point asymptotics, recurrence methods, zero location, and hypergeometric specialization, each after an exact occurrence is selected.

## Portfolio E — Riemann zeta and Bernoulli objects

### Source and normalization questions

- Confirm that the Chapter 2 zeta heading denotes Riemann zeta, and record argument type, initial Dirichlet-series domain, continuation, pole, and any functional-equation normalization.
- Distinguish a completed/scaled zeta function if it appears; it is not an alias.
- Independently review the locked Chapter 8 §1 split into Bernoulli numbers, Bernoulli polynomials, and periodic functions recorded by `OLV97-C08-EULER-MACLAURIN`.
- Reconcile the transcribed $B_1=-1/2$ sign, polynomial argument, `[0,1)` periodic representative, integer point value, and derivative variable with the pinned declarations.
- Freeze only the exact finite Euler–Maclaurin identity and integral remainder supplied by that occurrence; norm bounds are later project mathematics.

### Construction versus reuse and dependencies

The pin supplies `bernoulli`, `Polynomial.bernoulli`, `bernoulliFun`, and `periodizedBernoulli`; the last uses the `[0,1)` representative and matches the transcribed integer value at $B_1$. `DEF-BERN-001` is therefore reuse-only and declaration-free. `BER-001` may add only a real-line facade plus the calculus/envelope facts required by Euler--Maclaurin, after exact source identification. The zeta decision remains separate: the new occurrence identifies only positive-even Dirichlet-series values, not analytic continuation or pole semantics.

```text
locked zeta/Bernoulli body audit
       |
pin reuse audit
       +--> identified zeta and continuation/pole semantics
       |
       +--> identified Bernoulli numbers/polynomials/periodic function
                         |
                         +--> exact Euler-Maclaurin finite identity
                                      |
                                      +--> explicit remainder applications
```

### Proof dossiers and card queue

- `NLP-ZETA-001`: pin reuse, Dirichlet-series convergence/equality, continuation domain, pole and totalized values, real agreement, and only the functional identities included in the bounded card.
- `NLP-BERN-001`: exact match of numbers and rational polynomials, their real
  evaluation facade, the $B_1$ convention, derivative identity, coefficient
  orientation, and source notation.
- `NLP-BERN-002`: exact match of the source periodization with pinned
  `periodizedBernoulli`, including the `[0,1)` representative and endpoint jump;
  later `BER-001` owns only the real-line facade and calculus/envelope API.

| Provisional ID | Bounded target | Packet theorem / coverage class | Prerequisites |
|---|---|---|---|
| `DEF-ZETA-001` | Riemann zeta only, if confirmed, with one conventional identification and pole policy | `definition_identification` / `entity_identification` | Locked body confirmation; pin audit; `NLP-ZETA-001` |
| `DEF-BERN-001` | Source-confirmed Bernoulli numbers and polynomials via pinned Mathlib | `definition_identification` / `entity_identification` | Locked normalization audit; `NLP-BERN-001` |
| `DEF-BERN-002` | Periodic Bernoulli function only if source-confirmed or required as a labelled project extra | `definition_identification` / `entity_identification` | `DEF-BERN-001`; endpoint convention |
| `AUD-ZBERN-001` | Expanded initial values, $B_1$, derivative, periodic-boundary, and zeta-pole regressions | `audit_regression` / `infrastructure` | Accepted public objects |

### Acceptance gates, negative tests, unknowns, and consumers

Acceptance requires source identity, exact pin declarations, series convergence domain, continuation/pole semantics, Bernoulli normalization, and independent low-index audits. Tests catch the two $B_1$ conventions, polynomial index/argument reversal, periodic endpoint mismatch, zeta's pole treated as a finite value, and a Dirichlet-series formula asserted outside its half-plane. The Bernoulli split, periodic representative, exact finite remainder, and positive-even zeta formula are transcribed but independently unreviewed; global zeta identity remains unresolved. Prospective consumers are finite Euler–Maclaurin, coefficient transfer, power sums, and source-confirmed zeta asymptotics; the generic summation method remains separate infrastructure.

## Portfolio F — Anger/Weber, Struve, and Nicholson-type objects

### Source and normalization questions

- Inspect the Chapter 9 Anger heading and determine whether Anger, Weber, associated Anger–Weber, or another pair is actually named.
- Collate the Olver-specific factor convention flagged by DLMF; record every phase, order, and argument position.
- Inspect Chapter 7 for the exact Struve members, including ordinary/modified or scaled variants only if present.
- Locate and transcribe any Nicholson Bessel combination; determine whether it is a named source function, a finite combination of accepted Bessel functions, or only a local formula.
- Record the inhomogeneous ODE, forcing term, particular-solution normalization, branches, and exceptional orders for each confirmed member.

### Construction versus reuse and dependencies

No reuse decision is recorded. Search the pin first. Likely routes are an integral or series construction for the inhomogeneous functions, with Bessel/modified-Bessel homogeneous bases used for exact connection formulas. Nicholson-type objects should remain finite combinations of accepted Bessel objects unless the source normalization merits a separate name. Parameter continuation must not use totalized quotient formulas.

```text
locked Ch. 7 / Ch. 9 body audit and factor table
        |
pin audit + accepted Bessel basis + integral/series support
        |
inhomogeneous constructor + exact forcing normalization
        |
uniqueness via initial/integral/boundary data
        |
exceptional orders and exact connections
        |
large-order saddle/coalescing applications
```

### Proof dossiers and card queue

- `NLP-ANGER-001`: exact series/integral, Olver-specific factor, inhomogeneous equation, branches, and uniqueness normalization.
- `NLP-STRUVE-001`: exact source member, construction, equation/forcing, exceptional orders, and Bessel connection.
- `NLP-NICH-001`: exact Bessel combination, normalization, and proof that a new public object is warranted.

| Provisional ID | Bounded target | Packet theorem / coverage class | Prerequisites |
|---|---|---|---|
| `DEF-ANGER-001` | Finite source-confirmed Anger/Weber member set, split if more than one construction packet | `definition_identification` / `entity_identification` | Locked factor audit; `NLP-ANGER-001` |
| `DEF-STRUVE-001` | One source-confirmed Struve normalization | `definition_identification` / `entity_identification` | Locked body occurrence; accepted Bessel dependencies; `NLP-STRUVE-001` |
| `DEF-NICH-001` | One exact Nicholson-type combination if confirmed as a named normalization | `definition_identification` / `entity_identification` | Accepted Bessel objects; `NLP-NICH-001` |
| `AUD-INHOM-001` | Expanded forcing-sign, factor, exceptional-order, and connection regressions | `audit_regression` / `infrastructure` | Accepted public objects |

### Acceptance gates, negative tests, unknowns, and consumers

The gate requires locked names/formulas, the exact source-specific factor, one actual object, convergence/regularity, inhomogeneous forcing, enough normalization for uniqueness, exceptional-order continuation, and Bessel-basis connection proofs. Tests detect a factor-of-two or phase error, forcing sign, order/argument swap, adding a homogeneous solution, and division by a vanishing sine/Gamma factor. The exact member list and even Nicholson's source status are unknown. Potential consumers are Chapter 9 large-order/coalescing-saddle applications and Chapter 7 inhomogeneous cylinder applications.

## Portfolio G — named auxiliaries, rescalings, phases, and envelopes

### Source and normalization questions

- Create one occurrence/entity per printed auxiliary; never one row for “all auxiliary functions.”
- Decide whether each object is a named source function, a value-changing scale of a base function, a coefficient family, or a project control.
- Record argument and parameter roles, positivity, zeros, base phase, unwrapping interval, branch, derivative variable, and dimensional scale.
- Distinguish real moduli/envelopes from holomorphic functions and exact phase functions from arbitrary continuous lifts.
- Record whether the source uses the object in a theorem statement, proof estimate, table, or only a heading.

### Construction versus reuse and dependencies

An exact algebraic rescaling should be defined from the accepted base family. A modulus/envelope should use a transparent formula or a separately proved existence/uniqueness characterization. A phase lift needs a base value and interval/domain. Arbitrary functions chosen only because they satisfy the desired estimate remain hypotheses of a generic theorem or labelled project extras; they do not become named source functions.

```text
locked auxiliary-symbol audit
       |
accepted base named functions + exact scale/branch data
       |
finite algebraic auxiliary definitions
       |
positivity/nonvanishing/base-phase/regularity proofs
       |
comparison-system bounds
       |
named transition and zero applications
```

### Proof dossiers and card queue

- `NLP-AUX-SCALE-001`: exact scale, inverse relation, branches, zeros, and derivative transformation.
- `NLP-AUX-ENV-001`: explicit envelope formula, positivity/nonvanishing, zero-safe inequalities, and domain reachability.
- `NLP-AUX-PHASE-001`: phase construction, base value, continuity/unwrapping, derivative, and changes across components.

Queue IDs use the pattern `DEF-AUX-<ENTITY>-001`, `CMP-AUX-<ENTITY>-001`, and `AUD-AUX-<ENTITY>-001` only after `<ENTITY>` is a resolved canonical inventory ID. These are reservation patterns, not wildcard cards. Airy auxiliaries are owned by `CMP-AIR-*`; Bessel auxiliaries by `CMP-BES-*`; a row stays here only when it is genuinely cross-family or belongs to another confirmed family.

### Acceptance gates, negative tests, unknowns, and consumers

Acceptance requires a resolved entity, exact formula or unique characterization, base-family dependency, real/complex type, branch/phase convention, positivity and reachability, and an audit independent of the opaque predicate used by comparison proofs. Tests include zeros of the base function, a negative envelope, a phase shifted by an unrecorded multiple of $2\pi$, a missing large-parameter scale, and accidental treatment of a real modulus as holomorphic. The full source auxiliary inventory is unknown. Consumers are transition estimates, scaled-state bounds, zero location, and connection matrices.

## Cross-portfolio theorem-card queue summary

The tables above propose bounded handles, but several rows explicitly require splitting after collation. The first admissible registrations should be the narrow substrate or reuse packets with two demonstrated consumers:

1. `DEF-BERN-001`, if locked normalization matches pinned Mathlib;
2. `DEF-EI-001`, once the visible preview symbol and locked occurrence are reconciled;
3. one of `DEF-ERF-001` or `DEF-FRE-001`, after the Chapter 2 body audit;
4. `DEF-PCY-001` only after its Kummer dependencies are accepted;
5. individual `DEF-ORTH-<MEMBER>-001` cards, never a chapter-wide card;
6. Anger/Struve/Nicholson and auxiliary cards only when their exact source factor or project-extra role is settled.

Priority here means a sensible dependency order, not execution readiness. None enters `DEMO-0`, `BOOTSTRAP-0`, or `OLV-MVP-1` without an explicit reviewed manifest revision.

## Common acceptance and review gates

Every portfolio must pass the repository-wide definition gates in [`README.md`](README.md), plus the following:

- a queue pattern is replaced by a finite target list before registration;
- source/semantics review uses the exact locked occurrence, not this planning prose or DLMF alone;
- new series, integral, ODE, continuation, or exceptional-parameter mathematics has a complete dossier and two independent mathematical approvals;
- continuation, particular-solution, transition, zero, and connection work has the additional structural/circularity review;
- the pin-specific reuse report covers every proposed definition and helper, not just the headline object;
- source entities, project extras, and generic infrastructure have distinct coverage classes and inventories;
- implementation audits prove expanded normalizations, edge values, and argument order from the public API;
- named quantitative cards separately prove reachable domains, majorant nonnegativity, and every generic assumption.

## Cross-portfolio explicit unknowns

- A locked 1997 snapshot is now available in the canonical source-snapshot ledger, but none of these family portfolios has a complete independently reviewed body audit from it.
- No page range in these portfolios has a complete, independently reviewed locked-edition audit.
- Most leads are contents-only; the bounded Chapter 8 Bernoulli/zeta occurrence is a new exception, but family membership and member counts elsewhere remain unknown.
- Except for the recorded Bernoulli and hypergeometric substrates, pin-specific reuse searches are incomplete.
- Branch, contour, principal-value, parameter-regularity, and complex ODE infrastructure remains uncarded for many proposed constructions.
- No source application, exact approximant, finite error bound, or occurrence reconciliation is specified here.
- No provisional ID has exact signatures, a frozen proof revision/digest, external review evidence, implementation authorization, or release status.

These unknowns are intentional blockers for named claims, not blockers for unrelated generic finite calculus, integration, summation, ODE, or complex-domain infrastructure.
