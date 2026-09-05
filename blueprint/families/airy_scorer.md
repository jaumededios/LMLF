# Airy and Scorer family programme

**Status:** planning only; no provisional ID below is registered or authorized  
**Current source evidence:** contents-only leads `OLV10P-O0012` and `OLV10P-O0021`; no resolved Airy or Scorer entity row  
**Mathlib position at the pin:** no named `Ai` or `Bi` implementation found; regularized hypergeometric infrastructure is a promising construction substrate

## Family boundary and edition-scoped claim

This file plans the baseline Airy functions, their integral/rotation identifications, real restrictions, and the additional Airy/Scorer objects required by inhomogeneous comparison problems. It also identifies the seam where modulus, phase, and positive envelopes become comparison-layer objects rather than baseline definitions.

The evidence currently justifies much less than that programme:

- `OLV10P-O0012` records the contents headings “Airy Integral” in Chapter 2 §8 and a Chapter 4 Airy-integral heading. It is `occurrence_unresolved` and does not establish that the printed object is already `Ai`, `Bi`, a contour integral, or a particular normalization.
- `OLV10P-O0021` records Chapter 11 Airy-function and auxiliary-function headings. It is also contents-only. No derivative, rotation, modulus, phase, or envelope symbol has been collated.
- DLMF gives modern Airy conventions and points to Olver's modulus/phase and Scorer-related treatment. Those are convention warnings and locator aids, not evidence that a particular Scorer name or notation occurs in the locked edition.

Accordingly, `Ai`, `Bi`, `Gi`, `Hi`, rotated Airy solutions, modulus, phase, and envelopes are planning concepts here. Source entities and named source applications are created only after a locked-edition body audit confirms them. A project-required inhomogeneous solution absent from the source is recorded as `project_extra` and excluded from source-completeness totals.

## Source and normalization questions

### Airy integral and homogeneous solutions

1. What is the exact Chapter 2 “Airy integral”: contour, orientation, integrand, phase sign, prefactor, domain, and printed symbol?
2. Does the text identify that integral with `Ai`, a rotated `Ai`, or another normalization? Do not infer the answer from the heading.
3. Where are `Ai` and `Bi` first named in the mathematical body, and which argument convention and derivative notation are used?
4. Is the differential equation printed as $y''=zy$, $y''-zy=0$, or after a rescaling/change of sign? Record the independent and dependent variables explicitly.
5. Which normalization is primary: initial values at zero, real integral, contour behavior, recessiveness, a Wronskian, or a connection formula?
6. Which powers of 3 occur in the initial values, and are they real positive powers before coercion? A complex-power interpretation would introduce an unintended branch.
7. Which rotated solutions and cube-root conventions occur? Record the branch and exact direction of each rotation.
8. Does a prime always mean differentiation in the Airy argument, or are scaled transition derivatives also given distinct notation?

### Scorer and inhomogeneous Airy objects

1. Does the locked edition actually name Scorer functions, or does it use unnamed particular solutions/inhomogeneous Airy integrals?
2. If a named object occurs, is it `Gi`, `Hi`, another notation, or a scaled/rotated form? Record the precise inhomogeneous equation including the sign and constant on the right-hand side.
3. Which integral representation is used, on what domain, and with what endpoint or contour semantics?
4. Which homogeneous correction fixes the particular solution uniquely? An inhomogeneous equation alone never identifies it.
5. Are real-axis definitions primary with later continuation, or are complex contour definitions primary?
6. Which connection formulas to `Ai` and `Bi` are printed or consumed? A modern DLMF relation is not automatically an Olver occurrence.

### Auxiliary functions

1. Enumerate every printed modulus, phase, weight, envelope, or auxiliary symbol in Chapter 11 rather than using one generic “Airy auxiliaries” entity.
2. Determine which are conventional named functions, which are algebraic combinations of `Ai`/`Bi`, and which are arbitrary controls satisfying inequalities.
3. For a modulus/phase pair, record positivity, zeros, base phase, unwrapping convention, and interval. A positive real envelope is not holomorphic.
4. Separate functions of the Airy argument from transition-variable rescalings involving a large parameter.

## Construction versus reuse plan

### Baseline decision process

The pinned audit found no named Airy functions. It did find `Complex.regularizedHGFun`, an entire regularized generalized-hypergeometric series when the numerator-cardinality condition holds. Its regularized $0F1$ specialization has coefficients with reciprocal Gamma factors and is a likely shared substrate for Airy and Bessel series.

The construction decision should compare two routes before a card is frozen:

| Route | Benefit | Proof burden and risk |
|---|---|---|
| Generic Airy IVP power series with recurrence $c_{n+3}=c_n/((n+3)(n+2))$ | Directly mirrors the equation and handles arbitrary initial values; uniqueness is naturally shared by `Ai` and `Bi`. | Requires an entire-convergence proof, termwise differentiation, recurrence normalization, and a robust complex IVP uniqueness theorem. |
| Linear combinations of the existing regularized $0F1$ kernel | Reuses convergence and analyticity and may share work with Bessel. | Requires exact coefficient specialization, Gamma-factor simplification, argument rescaling, and proof that exceptional denominator parameters are handled by regularization. |

The preferred direction is to prototype the regularized-$0F1$ route first, as recommended by the pin audit, while keeping the generic Airy recurrence as the readable equation-level proof plan. The final family exposes exactly one `Ai` and one `Bi`. If both constructions are retained, one is private or secondary and a proved equality connects them.

The conventional identification candidate is the entire Airy equation plus two exact initial values. DLMF's standard values are useful for convention checking, but the locked source must be collated before they are described as Olver's normalization. The powers of 3 are positive real powers coerced to the complex codomain. Existence and uniqueness must be proved below all turning-point estimates.

Integral and contour formulas should be identification theorems for the already constructed functions unless a careful reuse review finds that one integral construction is substantially cleaner. A contour construction requires contour geometry, orientation, convergence, holomorphy, differentiation under the integral, the equation, and normalization. None can be imported from a later steepest-descent estimate.

Scorer-type functions form a later subwave. Reuse is unassessed. Their actual construction should be selected only after source collation fixes the inhomogeneous equation and normalization. Candidate routes are a convergent series with an inhomogeneous recurrence, a real integral followed by continuation, or variation of parameters from the accepted Airy basis. Whichever route is selected must prove uniqueness under the additional normalization; it cannot select “some particular solution.”

## Dependency graph

```text
locked-edition Airy/auxiliary body audit
          |                         |
          |                         +--> decide whether Scorer names are source entities
          v
pin audit + regularized 0F1 substrate identification
          |
          +--> generic entire Airy-IVP construction and uniqueness
                         |
                         v
                   identified Ai and Bi
                    /      |       \
          real agreement   |        contour/integral bridges
                           |
                   Wronskian and exact rotations
                           |
              +------------+----------------+
              |                             |
       zero-safe modulus/phase        inhomogeneous construction
       and envelope properties        and Scorer identification
              |                             |
              +-------------+---------------+
                            v
          turning-point / inhomogeneous comparison applications
                            |
                   zeros and connection results
```

Generic ODE uniqueness and low-level entire-series lemmas may be shared infrastructure. Airy identification may depend on them, but neither may depend on turning-point, envelope, zero, or connection estimates.

## Required natural-language proof dossiers

### `NLP-AIR-IVP-001` — entire Airy IVP constructor

Fix the actual coefficient or hypergeometric construction for arbitrary initial values. Derive the coefficient recurrence algebraically, prove convergence for every complex argument, justify termwise first and second derivatives, prove the differential equation, and recover both initial values. Give a complete uniqueness proof for differentiable/analytic solutions on the stated domain. The dossier must say which regularity makes the derivative expressions meaningful and cannot rely on totalized derivatives.

If the $0F1$ route is selected, the dossier additionally derives the exact coefficient specialization and all Gamma simplifications, including the zero coefficient class. It proves equality with the recurrence construction or eliminates the unused construction before the public card is frozen.

### `NLP-AIR-NAMED-001` — `Ai` and `Bi` normalization

State the two functions' exact initial values, the meaning of every fractional power, and the Airy equation. Prove the actual objects satisfy those data and use IVP uniqueness to obtain expanded characterizations. Establish linear independence and the exact Wronskian only if included in this bounded card. Include adversarial calculations that detect an `Ai` derivative sign error and interchange of the two initial-value pairs.

### `NLP-AIR-INT-001` — real and contour integral bridges

For each collated formula, state the path, orientation, phase sign, prefactor, convergence mode, and parameter/argument domain. Prove convergence, differentiability under the integral, the equation, and the matching normalization; conclude equality through the accepted characterization. Real oscillatory formulas use the appropriate improper interpretation rather than a totalized Bochner integral.

### `NLP-AIR-ROT-001` — rotations and connection identities

Define each root of unity or argument rotation exactly, prove the rotated function solves the transformed equation, compute normalization or Wronskians, and establish every connection coefficient. Domains and branch behavior must be explicit. This dossier is separate from asymptotic Stokes analysis; exact algebraic connections do not import asymptotic estimates.

### `NLP-SCO-001` — inhomogeneous Airy/Scorer identification

Begin only after the source/normalization split is resolved. Prove existence of the selected particular solution, its inhomogeneous equation with exact forcing constant, the extra initial/boundary/integral normalization that makes it unique, and its agreement with any conventional integral. Treat every rotated or alternate Scorer normalization as a separate bounded target. This is definition/continuation work and requires a structural/circularity reviewer.

### `NLP-AIR-ENV-001` — modulus, phase, and zero-safe envelopes

For each confirmed auxiliary, give the exact algebraic definition from `Ai`, `Bi`, and derivatives or an independent conventional definition. Prove positivity/nonvanishing where claimed, base phase and continuation, and the inequalities needed by comparison theorems. Explain why the envelope remains meaningful at zeros of `Ai` or `Bi`. Keep any arbitrary project control object labelled `project_extra`.

### `NLP-AIR-REAL-001` — real agreement and derivative meaning

Prove conjugation symmetry or another reality theorem, then pointwise real agreement on the intended interval. Prove derivative restriction from neighborhood agreement and fix whether primes denote ordinary Airy-argument derivatives or scaled transition derivatives. Include endpoints and zeros used by later applications.

## Provisional theorem-card queue

| Provisional ID | Bounded target | Provisional theorem class | Coverage class | Principal prerequisites |
|---|---|---|---|---|
| `CON-AIR-001` | One generic entire solution constructor for the Airy IVP, including existence and uniqueness | `existence_uniqueness` | `infrastructure` | Pin audit; shared series/ODE support; `NLP-AIR-IVP-001` |
| `DEF-AIR-001` | `Ai` and `Bi` as the two exact normalized IVP solutions, with expanded characterizations | `definition_identification` | `entity_identification` | `CON-AIR-001`; collated normalization before any source claim; `NLP-AIR-NAMED-001` |
| `DEF-AIR-002` | Exactly the collated Airy integral formulas and their equality to the accepted functions | `definition_identification` | `entity_identification` | `DEF-AIR-001`; path/integral support; `NLP-AIR-INT-001` |
| `DEF-AIR-003` | Finite list of accepted rotated solutions and exact connection identities | `exact_identity` | `entity_identification` | `DEF-AIR-001`; resolved rotation notation; `NLP-AIR-ROT-001` |
| `DEF-SCO-001` | One source-confirmed Scorer-type object or one explicitly labelled project-extra particular solution | `definition_identification` | `entity_identification` | Locked body evidence or project-extra decision; `DEF-AIR-001`; `NLP-SCO-001` |
| `CMP-AIR-001` | Airy Wronskian, real basis, and exact comparison identities required by turning-point work | `exact_identity` | `infrastructure` | `DEF-AIR-001`; bounded target list |
| `CMP-AIR-002` | Confirmed modulus/phase/envelope objects and zero-safe bounds on explicit domains | `qualitative_support` | `infrastructure` | Auxiliary collation; `CMP-AIR-001`; `NLP-AIR-ENV-001` |
| `AUD-AIR-001` | Expanded equation, initial-value, rotation, Wronskian, forcing-sign, and real-agreement regressions | `audit_regression` | `infrastructure` | Accepted public Airy/Scorer declarations |

No card in this queue covers a Chapter 11 turning-point occurrence. Such a card must later bind one exact collated occurrence, its finite approximant, parameter regime, scaling, constants, and derivative convention.

## Acceptance gates

### Baseline Airy identification

- Locked-edition collation resolves whether the source uses the candidate standard normalization; absent that, the card says only that it identifies the conventional project `Ai`/`Bi` objects.
- One actual object exists for each of `Ai` and `Bi`; any alternative series/integral construction is private or proved equal.
- Entire convergence, differentiability, the exact equation, exact initial values, and IVP uniqueness are proved without downstream estimates.
- Fractional powers in normalization constants are unambiguous positive real powers.
- Real agreement and derivative restriction are proved on the domains consumed later.
- Expanded audits catch a sign, scale, or swapped-normalization error.
- Two pre-Lean mathematical reviewers and an independent structural/circularity reviewer approve the frozen construction/identification dossiers.

### Scorer or inhomogeneous identification

- A source name/normalization is supported by a locked body occurrence, or the object is explicitly a project extra.
- The forcing term, sign, and constant are frozen.
- The equation is supplemented by enough initial, boundary, growth, or integral data to prove uniqueness.
- Integral semantics, continuation, and exceptional directions are proved.
- No field or choice assumption contains the desired particular-solution estimate.

### Readiness for transition estimates

- Baseline Airy identification and the exact comparison identities are accepted.
- Positive envelopes are proved on a reachable/nonempty domain and remain valid at model zeros.
- Transition coordinates, branches, argument rotations, and scaled derivative conventions are explicit.
- Residual identity, residual bound, normalized actual solution, and ODE stability are separate accepted dependencies.
- Every source occurrence and normalization is reconciled before coverage is claimed.

## Negative and adversarial tests

1. **Equation sign:** an audit must distinguish $y''=zy$ from $y''=-zy$ and from a rescaled argument equation.
2. **`Ai` derivative sign:** the initial derivative at zero must detect a missing minus sign.
3. **`Ai`/`Bi` swap:** expanded zero values and derivatives must distinguish the two functions independently of an opaque IVP predicate.
4. **Fractional-power branch:** the constants use positive real powers of 3; a complex principal-power reinterpretation must not typecheck as the same normalization claim.
5. **Insufficient ODE data:** exhibit that the Airy equation alone admits many solutions, so no equation-only identification is accepted.
6. **Contour orientation:** reversing a contour or changing the cubic phase sign must change the audit identity.
7. **Rotation direction:** tests distinguish multiplication of the argument by a root of unity from multiplication of the function value by that root.
8. **Wronskian orientation:** swapping basis order changes the sign; the accepted convention is frozen.
9. **Scorer forcing sign:** the expanded inhomogeneous equation detects a sign or constant mismatch.
10. **Particular-solution ambiguity:** adding a homogeneous Airy solution must violate the extra normalization used to identify a Scorer object.
11. **Zeros:** no relative remainder theorem may divide by `Ai`, `Bi`, or a linear combination without an explicit zero-free domain.
12. **Real derivative:** pointwise reality at one point does not justify derivative agreement.
13. **Circularity:** the construction dependency report must fail if baseline `Ai` imports turning-point asymptotics or comparison envelopes.

## Explicit unknowns and blockers

- The locked 1997 copy has not been scanned for the Airy leads, and no exact printed page, formula, or notation has been resolved.
- It is unknown whether the Chapter 2 Airy integral is itself a named Airy function and which normalization it has.
- The complete Chapter 11 list of derivatives, rotations, moduli, phases, and auxiliaries is unknown.
- No Scorer notation is confirmed as a source entity; DLMF locators alone do not promote one.
- The pin audit has not compiled an Airy construction. It only established that regularized $0F1$ is a feasible entire-series substrate.
- The choice between a direct recurrence construction and a $0F1$-based construction is not frozen.
- Generic complex second-order IVP uniqueness infrastructure is a known major gap in the pinned Mathlib audit and may require a separate infrastructure packet.
- Contour infrastructure, improper oscillatory integral semantics, and parameter-continuation requirements are not yet scoped into cards.
- No envelope inequality, transition region, Wronskian normalization, or zero theorem has been collated from the source.
- No provisional card has exact signatures, dossier approvals, implementation authorization, or manifest membership.

## Downstream asymptotic consumers

Prospective consumers, subject to direct collation, include:

- Chapter 4 Airy-integral applications after the exact integral object is identified;
- Chapter 11 simple turning-point comparison systems, including finite coefficient sums multiplying a comparison function and its derivative;
- inhomogeneous turning-point models using a source-confirmed Scorer-type solution;
- uniform large-parameter ODE results across a turning point, with explicit $u^{-2/3}$-scale neighborhoods and scaled state bounds;
- zero-safe value and derivative estimates based on positive Airy envelopes;
- local zero displacement and later global zero indexing;
- exact rotated-basis and connection-matrix calculations, followed by quantitative connection estimates;
- parameter and spatial derivative transport on explicit complex neighborhoods.

The generic turning-point, residual, stability, Cauchy, and zero-perturbation infrastructure can proceed without a completed named family. A named Airy or Scorer theorem cannot.
