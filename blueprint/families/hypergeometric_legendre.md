# Hypergeometric, Legendre, Ferrers, and Whittaker family programme

**Status:** planning only; no provisional ID below is registered or authorized  
**Current source evidence:** contents-only leads `OLV10P-O0016`, `OLV10P-O0018`, and `OLV10P-O0023`  
**Mathlib position at the pin:** useful ordinary and regularized hypergeometric series exist, but no audited global named continuation or Legendre/Whittaker identification is presently available

## Family boundary and source honesty

This file owns the shared hypergeometric substrates and plans the source-confirmed ordinary/regularized hypergeometric, Kummer, Legendre/Ferrers, and Whittaker objects. It also owns the regularized $0F1$ kernel proposed as a construction dependency for Airy and Bessel. Parabolic-cylinder functions are planned in [`remaining_families.md`](remaining_families.md), though their eventual construction may consume Kummer objects from this file.

The current inventory does not yet confirm a mathematical-body occurrence for any object in this file:

- `OLV10P-O0016` is a Chapter 5 contents lead labelled “Hypergeometric and Legendre Functions.” Its ordinary/regularized hypergeometric and Legendre/Ferrers entity split is unresolved.
- `OLV10P-O0018` is a Chapter 7 contents lead including confluent hypergeometric and Whittaker families among several others.
- `OLV10P-O0023` is a Chapter 14 contents lead revisiting the exponential integral and confluent hypergeometric function. It may reuse an earlier entity or introduce a new normalization; that cannot be decided from contents.
- the function-inventory prose also flags generalized hypergeometric and Barnes-integral notation as audit leads. No source-occurrence row currently resolves those objects.

DLMF's distinction between ordinary and regularized Gauss/Kummer functions is a warning against conflation, not evidence that both occur in the locked edition. All family membership, notation, and normalization claims wait for the locked mathematical-body audit.

## Source and normalization questions

### Gauss and generalized hypergeometric functions

1. Enumerate every printed ${}_pF_q$ object and record parameter-list order, multiplicity, argument position, and whether parameters are ordered sequences, multisets, or symmetric lists.
2. Determine whether boldface or another typography denotes a regularized function and record the exact Gamma factor relating it to the ordinary version.
3. For each series occurrence, record convergence radius, boundary conditions, terminating cases, and exceptional denominator parameters.
4. Determine which formulas are only local power-series identities and which refer to an analytic continuation on a cut plane.
5. Record the continuation cut, boundary convention, base germ, and monodromy/branch data. Mathlib's ordinary ${}_2F_1$ is deliberately zero outside its convergence radius; that junk value is not the classical continuation.
6. Determine which Euler/Barnes integral representations occur, their contours and orientations, pole-separation conditions, and parameter exclusions.
7. Record parameter transformations and connection formulas as relations rather than aliases whenever they change values or arguments.

### Confluent hypergeometric/Kummer and Whittaker functions

1. Collate each Kummer notation: ordinary `M`, regularized bold `M`, `U`, or explicit ${}_1F_1$. Determine which are distinct entities.
2. Freeze argument order and the exact Gamma normalization of regularized `M`.
3. Record exceptional denominator parameters, terminating numerator parameters, and the continuation used at singular parameter values.
4. For `U`, determine the primary definition: integral, connection formula, asymptotic normalization, or ODE plus boundary data. Baseline identification must avoid circular dependence on the later asymptotic theorem that consumes `U`.
5. For Whittaker `M` and `W`, collate parameter order, powers/exponentials in the Kummer transformation, branch cut, and any scaled variants.
6. Determine whether Chapter 14 uses exactly the earlier Kummer object or a reparameterized normalization.

### Legendre and Ferrers functions

1. Split ordinary Legendre functions, associated functions, and Ferrers functions only after body collation.
2. Freeze degree, order, and spatial argument positions; source notation often makes order/degree reversal easy.
3. Determine whether `P` and `Q` are normalized on a complex cut plane, while Ferrers objects are real/interior-cut functions on ((-1,1)), and how boundary values are related.
4. Record phase conventions for associated order, especially factors involving powers of $1-z^2$, $z^2-1$, or signs for integral order.
5. Determine how second-kind `Q` is defined at exceptional degrees/orders and which logarithmic branch appears.
6. Record normalization at $z=1$, Wronskians, and any conical or scaled variants only when source occurrences confirm them.
7. Identify whether a hypergeometric formula is the construction, a local representation, or a continuation theorem.

## Construction versus reuse plan

### Pinned substrates already verified

The pin audit established the following precise starting points:

- the ordinary hypergeometric series and function, with notation for ${}_2F_1$, and radius one;
- the ordinary function's explicit zero junk value outside its convergence radius;
- generic regularized hypergeometric coefficients, series, and function;
- entire convergence in the spatial variable when the number of numerator parameters does not exceed the number of denominator parameters;
- a regularized Gauss object and an ordinary-Gauss-divided-by-Gamma relation on its proved domain.

These declarations should be reused at their exact signatures. They are not a ready-made global classical ${}_2F_1$, Kummer `U`, Legendre, Ferrers, or Whittaker API.

### Planned layers

| Layer/object | Construction/reuse plan | Semantic guardrail |
|---|---|---|
| Regularized $0F1$ | Wrap the exact `regularizedHGFun` specialization only after proving its coefficient and `HasSum` statements in readable form. | Keep it a kernel, not an `Ai`, `J`, or `I` alias. Parameter regularity beyond the pinned theorem is separately proved. |
| Ordinary local ${}_2F_1$ | Reuse the Mathlib power-series object strictly on its honest disk and for terminating cases where a separate theorem justifies evaluation. | Never market its outside-radius zero as analytic continuation. |
| Regularized local/global Gauss | Reuse the regularized series where valid. Construct global continuation from a base germ, Euler integral, ODE, or connection charts only after source needs and branch conventions are frozen. | The ordinary/regularized Gamma relation is domain-restricted at exceptional parameters. |
| Generalized ${}_pF_q$ | Reuse generic regularized infrastructure for the finite parameter multisets actually confirmed. Add ordinary variants only with explicit denominator exclusions and convergence regions. | No wildcard “all generalized hypergeometric functions” card. |
| Kummer `M` / regularized `M` | Use regularized ${}_1F_1$ as the primary series substrate. Derive ordinary `M` on nonexceptional denominator parameters and separately prove any continued exceptional values. | Totalized multiplication/division by Gamma cannot establish continuation. |
| Kummer `U` | Compare an integral construction with a connection-formula construction. Prefer an integral or normalized ODE characterization that does not depend on its target large-argument estimate. | An asymptotic condition may identify `U` only if established independently, not assumed from the theorem being formalized. |
| Legendre/Ferrers `P` | Build from an accepted hypergeometric germ or normalized ODE, then prove continuation and distinguish cut-plane from interior Ferrers objects. | Do not identify two boundary values across a cut by definitional equality. |
| Legendre/Ferrers `Q` | Construct after `P` and parameter regularity, using an integral/connection/ODE normalization matching the source. | Exceptional integer parameters need limiting theorems, not totalized sine/Gamma quotients. |
| Whittaker `M/W` | Define through accepted Kummer functions with exact powers and exponentials when that matches the source; otherwise prove the transformation as an identification bridge. | Branch, parameter conversion, and value-changing scale are public data. |

The shared hypergeometric construction layer may import Gamma and low-level branch/series support. It may not import Airy, Bessel, parabolic-cylinder, or Whittaker applications that consume it. Legendre/Whittaker definitions import individual accepted hypergeometric files, never the global definitions umbrella.

## Dependency graph

```text
locked-edition Ch. 5 / Ch. 7 / Ch. 14 body audit
              |
              +--> exact ordinary/regularized/member/alias split
              |
pinned ordinary + regularized hypergeometric substrate audit
              |
              +--> regularized 0F1 kernel -----------------> Airy and Bessel constructors
              |
              +--> local ordinary/regularized Gauss germs
              |                 |
              |                 +--> Gauss continuation charts
              |                           |
              |                           +--> Legendre/Ferrers P
              |                                      |
              |                                      +--> Q and connection data
              |
              +--> regularized 1F1 / Kummer M
                                |
                                +--> Kummer U
                                |       |
                                |       +--> Chapter 14 applications
                                |
                                +--> Whittaker M/W
                                +--> parabolic-cylinder bridges
              |
expanded coefficient, exceptional-parameter, branch, and real-agreement audits
              |
named finite asymptotic applications, zeros, and connections
```

Global continuation is intentionally downstream of a verified local germ. A family derived through hypergeometric functions still needs its own equation, normalization, branch, and uniqueness audit.

## Required natural-language proof dossiers

### `NLP-HG0F1-001` — regularized $0F1$ kernel

Identify the precise Mathlib specialization, expand its coefficient, prove its `HasSum` statement for every complex argument, and record its parameter semantics and regularity. Treat denominator values at Gamma poles explicitly. Demonstrate the exact rescalings consumed by one Airy and one Bessel prototype without identifying the kernel as either family.

### `NLP-HG-GAUSS-LOCAL-001` — local Gauss series

State numerator and denominator parameters, convergence disk, boundary exclusions, terminating cases, and ordinary/regularized relation. Compare every statement with the pin's exact zero-outside-radius definition. Prove only honest in-disk or polynomial results and include an outside-disk adversarial case.

### `NLP-HG-GAUSS-CONT-001` — Gauss continuation

Choose the base germ and continuation domain, construct overlapping charts or an integral representation, prove regularity and overlap equality, and establish uniqueness. Classify singular points and parameter exceptions. Record monodromy/branch behavior only to the strength required by selected consumers. This is high-risk continuation work requiring structural review.

### `NLP-HG-GENERAL-001` — finite generalized family list

For each confirmed ${}_pF_q$ member, give finite parameter arities, coefficients, radius/entire criterion, exceptional denominator parameters, and regularization. The dossier must be a finite list; a theorem quantified over generic finite multisets may be infrastructure but cannot stand in for source entity identification without member bridges.

### `NLP-KUM-M-001` — Kummer `M` and regularized `M`

Derive the exact ${}_1F_1$ specialization, prove entire spatial convergence, freeze the Gamma scale between ordinary and regularized versions, and classify denominator-parameter exceptions. Establish the confluent equation and initial normalization. Include terminating-polynomial cases.

### `NLP-KUM-U-001` — Kummer `U`

Give a noncircular construction, convergence/domain proof, confluent equation, and enough integral/boundary/connection data for uniqueness. Prove its relationship to `M` on an explicit nonexceptional parameter domain and separately handle continued parameter values. A later large-argument estimate cannot be imported to define the object it estimates.

### `NLP-LEG-P-001` — Legendre/Ferrers first-kind objects

Freeze degree/order/argument order, source branches, and associated-function phase. Construct the cut-plane and interior objects, prove their differential equations and normalizations, and establish any hypergeometric representations only on their correct domains. State boundary-value relations rather than identifying the objects globally.

### `NLP-LEG-Q-001` — second-kind and exceptional parameters

Construct and normalize `Q`, prove linear independence/Wronskian with `P`, specify logarithmic branches, and treat integer or resonant degree/order limits. Distinguish Ferrers `Q` from complex-cut `Q`. This continuation packet requires structural review.

### `NLP-WHI-001` — Whittaker transformations

Collate parameter order, derive the exact Kummer transformation with all powers and exponentials, prove the Whittaker equation and normalization, and establish branch/real agreement. `M` and `W` are separate targets even when both reduce to Kummer objects.

### `NLP-HGLEG-REAL-001` — real restrictions and boundary values

Prove the exact real-domain agreement used downstream. For Ferrers/Legendre distinctions, identify which boundary value or interior restriction is meant and prove derivative agreement from a neighborhood theorem. No cut boundary is crossed by simplification.

## Provisional theorem-card queue

| Provisional ID | Bounded target | Provisional theorem class | Coverage class | Principal prerequisites |
|---|---|---|---|---|
| `DEF-HG0F1-001` | Readable regularized $0F1$ coefficient and entire-series identification | `definition_identification` | `infrastructure` | Pin audit; `NLP-HG0F1-001` |
| `DEF-HG-001` | Local ordinary Gauss ${}_2F_1$ wrapper on the convergence disk, including terminating cases | `definition_identification` | `entity_identification` | Body entity confirmation; `NLP-HG-GAUSS-LOCAL-001` |
| `DEF-HG-002` | Local regularized Gauss object and exact ordinary/Gamma relation on a nonexceptional domain | `definition_identification` | `entity_identification` | `DEF-HG-001`; collated normalization |
| `DEF-HG-003` | One global Gauss continuation on a frozen cut domain | `definition_identification` | `entity_identification` | Accepted local germ; branch support; `NLP-HG-GAUSS-CONT-001` |
| `DEF-HG-004` | Finite list of additional source-confirmed generalized hypergeometric members | `definition_identification` | `entity_identification` | Locked member list; `NLP-HG-GENERAL-001` |
| `DEF-KUM-001` | Kummer `M` and regularized `M`, with exact Gamma normalization and exceptional parameters | `definition_identification` | `entity_identification` | Generic regularized substrate; `NLP-KUM-M-001` |
| `DEF-KUM-002` | Kummer `U` on one frozen cut domain with noncircular characterization | `definition_identification` | `entity_identification` | `DEF-KUM-001`; integral/ODE support; `NLP-KUM-U-001` |
| `DEF-LEG-001` | First-kind Legendre and exactly confirmed associated variants on the complex domain | `definition_identification` | `entity_identification` | `DEF-HG-003` or accepted ODE constructor; `NLP-LEG-P-001` |
| `DEF-LEG-002` | First-kind Ferrers objects on their real/interior domain and boundary relation | `definition_identification` | `entity_identification` | `DEF-LEG-001`; real-boundary support |
| `DEF-LEG-003` | Second-kind Legendre/Ferrers objects, exceptional parameters, and Wronskian normalization | `definition_identification` | `entity_identification` | `DEF-LEG-001/002`; parameter regularity; `NLP-LEG-Q-001` |
| `DEF-WHI-001` | Whittaker `M` through the accepted Kummer object | `definition_identification` | `entity_identification` | `DEF-KUM-001`; `NLP-WHI-001` |
| `DEF-WHI-002` | Whittaker `W` through the accepted Kummer object and a noncircular normalization | `definition_identification` | `entity_identification` | `DEF-KUM-002`; `NLP-WHI-001` |
| `AUD-HGLEG-001` | Expanded coefficient, convergence-domain, Gamma-scale, branch, parameter-order, Ferrers, and Whittaker regressions | `audit_regression` | `infrastructure` | Accepted public declarations |

The generic $0F1$ card is infrastructure and claims no source entity. All entity-identification rows require a confirmed member split before their final cards are frozen. No wildcard generalized-function card or whole Chapter 5/7 application is permitted.

## Acceptance gates

### Hypergeometric substrate gate

- Every wrapper is compared with the exact pinned declaration and narrow import.
- The ordinary Mathlib object's outside-radius zero is documented and excluded from classical continuation claims.
- Every series theorem includes a convergence/`HasSum` result on its stated domain.
- Numerator/denominator parameter order, multiplicities, termination, and singular denominator values are tested.
- Ordinary/regularized relations state nonexceptional hypotheses, with separate continuation theorems at exceptional parameters.
- The $0F1$ kernel remains family-neutral and has independently audited Airy/Bessel specializations.

### Continuation and named-family gate

- A locked body occurrence confirms each source member and normalization.
- A global object has a base germ, explicit domain/cut, regularity, overlap equality, and uniqueness.
- Kummer `U`, Legendre/Ferrers `Q`, and Whittaker `W` are normalized without circular appeal to their future asymptotic estimates.
- Degree/order/argument positions and phase factors are public.
- Cut-plane functions and Ferrers interior functions are not conflated.
- Definition/continuation packets have two mathematical approvals and a third structural/circularity approval.
- Expanded audits prove recognizable series terms, initial values, Wronskians, or transformation formulas from the public declarations.

### Named-application gate

- The application cites exact source occurrences and identified objects.
- Every series, integral, ODE, branch, parameter, and connection hypothesis is discharged.
- Finite approximant, order convention, domain, threshold, constants, majorant nonnegativity, and reachability are explicit.
- A local series theorem is not reported as a global large-argument theorem.

## Negative and adversarial tests

1. **Outside-radius junk value:** choose a nonterminating Gauss parameter set and an argument outside the unit disk; reject identification of Mathlib's zero fallback with the classical continuation.
2. **Terminating exception:** a terminating numerator parameter may yield a polynomial, but this must follow from coefficient vanishing rather than an unrestricted radius claim.
3. **Denominator pole:** an ordinary coefficient with a singular denominator parameter is not repaired by totalized division.
4. **Regularization factor:** an expanded low-order coefficient detects multiplication versus division by the relevant Gamma factor.
5. **Parameter order:** the audit distinguishes numerator parameters, denominator parameters, and spatial argument; symmetry among numerator parameters does not justify arbitrary list rearrangement across the separator.
6. **Branch point:** continuation identities near $z=1$ or infinity state a cut and cannot be globally simplified.
7. **Kummer sign/scale:** the confluent equation and first coefficients distinguish the argument sign and ordinary/regularized normalization.
8. **`U` ambiguity:** the confluent ODE alone does not identify `U`; adding an `M` solution must violate its extra normalization.
9. **Degree/order swap:** associated Legendre audits independently expose reversed degree and order.
10. **Ferrers conflation:** the real interior object is not definitionally equal to an arbitrary boundary value of the complex-cut object.
11. **Second-kind exceptional parameter:** a sine or Gamma denominator vanishing at an integer does not produce the continued `Q` value through totalization.
12. **Whittaker prefactor:** expanded transformation tests detect a missing exponential, half-power, or parameter shift.
13. **Derivative variable:** parameter derivatives and spatial derivatives are not interchanged.
14. **Circular normalization:** any baseline definition depending on a large-argument application fails dependency review.

## Explicit unknowns and blockers

- No locked-edition mathematical-body occurrence for a hypergeometric, Legendre, Ferrers, Kummer, or Whittaker object is currently resolved.
- The ordinary/regularized member split and exact printed typography are unknown.
- The finite list of generalized hypergeometric functions actually used is unknown.
- Barnes-integral notations, contours, and their status as functions versus representations have not been inventoried.
- It is unknown whether Chapter 14 reuses or renormalizes the Chapter 7 confluent hypergeometric object.
- The pinned substrate supplies local/series semantics, not the needed global continuation or parameter-analyticity package.
- No general analytic-continuation chart, monodromy, or complex second-order ODE uniqueness package has been accepted in LMLF.
- The precise construction of Kummer `U`, Legendre/Ferrers `Q`, and Whittaker `W` is undecided.
- Source-required real boundary-value conventions and exceptional-parameter limits are unknown.
- No proposed card has exact signatures, frozen dossier/review evidence, implementation authorization, or manifest membership.

## Downstream asymptotic consumers

Potential consumers after identification include:

- Chapter 5 finite large-parameter expansions for Gauss hypergeometric and Legendre/Ferrers functions;
- Chapter 6 parabolic-cylinder constructions expressed through Kummer functions;
- Chapter 7 confluent hypergeometric and Whittaker large-parameter/large-argument results;
- Chapter 14 exponential-integral and confluent-hypergeometric remainder models, after entity reconciliation to earlier chapters;
- the shared $0F1$ construction substrate for Airy and Bessel first-kind functions;
- regular-singular Frobenius packets, resonant/logarithmic cases, and exact connection matrices;
- local zero displacement and parameter-dependent zero results for identified Legendre or hypergeometric functions;
- coefficient-transfer and Barnes-contour methods when their exact source occurrences are selected.

Generic continuation, Frobenius, integral, ODE stability, and connection-matrix infrastructure may be developed conditionally. It does not identify any named member until the family-specific normalization and exceptional-value gates pass.
