# Named-function family programme

**Normative owner:** `jaumededios`  
**Programme status:** planning only  
**Source edition:** F. W. J. Olver, *Asymptotics and Special Functions*, corrected A K Peters reprint, 1997, ISBN 1-56881-069-5

## Purpose and present non-claims

This directory turns the broad named-function track in the roadmap into bounded family queues. It is a planning layer between the occurrence/entity inventory and future theorem cards. It does not add a source occurrence, resolve an existing occurrence, register a card, close a manifest, authorize implementation, or claim that any family has been formalized.

The current source evidence is intentionally weak outside the small Chapter 2 preview sample. The available publisher preview identifies itself as a 2010 CRC reprint and has not been reconciled to the locked 1997 edition. Several family leads come only from its contents pages. DLMF references are normalization checks and locator aids; they are not substitutes for a mathematical-body occurrence in the locked edition. These files therefore describe questions, packet boundaries, and gates. They do not silently promote a contents heading into a source entity or theorem.

`DEF-001` remains the only current Gamma identification card, and it is limited to four wrappers around `Complex.Gamma`. No ID proposed below is present in `blueprint/inventory/cards.csv`. The proposed IDs are queue handles only. Their initial state is:

- specification: draft;
- proof: not started, except where a future reuse-only card justifies `not_required`;
- review: not started;
- implementation: not started and not authorized;
- coverage: not applicable for infrastructure/entity-identification work, and merely prospective for a future source application;
- manifest membership: absent until a reviewed manifest revision registers the finished card.

## Evidence discipline

Every family row must retain the exact evidence class already recorded in the inventory:

| Inventory fact | What this programme may say | What it may not say |
|---|---|---|
| Direct body material in the 2010 preview | A provisional occurrence or entity is evidenced in that preview. | That the locked 1997 occurrence, formula, notation, or normalization is reconciled. |
| Contents-only heading in the 2010 preview | The heading is a discovery lead for a body audit. | That each modern family member, alias, or normalization occurs in the book. |
| DLMF cross-reference | A modern convention or known hazard should be checked. | That the convention is Olver's printed convention or that the entity occurs there. |
| Project comparison need | A project-extra may be proposed and reported separately. | That the object contributes to Olver source-completeness totals. |
| Pinned Mathlib declaration | Reuse feasibility may be audited against the exact local signature. | That the object matches Olver without an identification and normalization review. |

An exact locked-edition body scan must create or update occurrences, notations, entities, page audits, and associations in the canonical CSV inventory before a family card cites them. Repeated uses, definitions, exercises, normalization checks, and cross-references remain separate occurrences. Whole-family labels never replace that occurrence accounting.

## Programme files and ownership seams

| File | Primary scope | Important boundary |
|---|---|---|
| [`gamma_related.md`](gamma_related.md) | Gamma, reciprocal Gamma, Beta, psi/polygamma, incomplete Gamma and regularizations | Extends neither `DEF-001` nor the bootstrap manifest; every additional object is a new packet. |
| [`airy_scorer.md`](airy_scorer.md) | Airy `Ai`/`Bi`, rotations, Airy integral identifications, and source-confirmed Scorer-type objects | Baseline construction/identification stays below turning-point and inhomogeneous comparison estimates. |
| [`bessel_cylinder.md`](bessel_cylinder.md) | Bessel `J`/`Y`, modified `I`/`K`, Hankel functions, cylinder aliases, and pole-comparison model needs | Exceptional-order continuation and branch choices are separate from formal quotient formulas. |
| [`hypergeometric_legendre.md`](hypergeometric_legendre.md) | Hypergeometric kernels and continuations, Kummer/Whittaker bridges, Legendre/Ferrers families | Mathlib's series objects are substrates, not already identified global classical functions. |
| [`remaining_families.md`](remaining_families.md) | Exponential-related integrals; error/Dawson/Fresnel; parabolic cylinder; orthogonal polynomials; zeta; Bernoulli; Anger/Struve/Nicholson; auxiliary objects | Each portfolio remains independently gateable; “remaining” is not a wildcard manifest item. |

The file split is documentary. Final construction files should be smaller whenever branch, continuation, or exceptional-parameter proofs would otherwise create a dependency knot.

## Common lifecycle for a family wave

Each family advances through the following gates in order. Different families may progress independently.

1. **Evidence closure.** Inspect the locked snapshot's mathematical body, enumerate occurrences, transcribe the mathematics, hash it, resolve notation and entity links, and obtain independent collation review. Contents/index leads are either promoted to body occurrences or explicitly excluded.
2. **Semantic split.** Decide which printed names are aliases, which are value-changing normalizations, which derivatives are separately named, and which project auxiliaries are outside source counts. Freeze argument order, ambient types, branches, contours, and exceptional values.
3. **Pinned reuse audit.** Search the exact local Mathlib revision and the existing LMLF public API. Compare signatures, convergence domains, continuation, totalization, normalizations, imports, and parameter regularity. Reuse a canonical object where it matches; otherwise record why a construction is necessary.
4. **Construction design.** Choose one actual object per named function. Separate construction, conventional specification, identification/uniqueness, and later comparison/asymptotic properties. Choice is permitted only after existence and the relevant uniqueness are proved.
5. **Bounded cards and dossiers.** Replace a queue row by a complete theorem card with exact signatures and a complete natural-language proof dossier when new mathematics is present. Each packet lists exclusions so that a family name cannot authorize an open-ended implementation.
6. **Pre-Lean review.** Obtain the source/semantics and proof/quantitative approvals required by the protocol. Definition, continuation, transition, zero, and connection packets also receive an independent structural/circularity review. Bind reviews to frozen artifact revisions and digests externally.
7. **Implementation and public audit.** Implement only the authorized declarations, build on the pin, inspect axioms and imports, and prove independent expanded-form audit regressions from the public API. A green build cannot repair a semantic mismatch.
8. **Named-application admission.** Only an identified function may enter a named asymptotic packet. The application must discharge generic hypotheses, prove the domain reachable/nonempty, prove the majorant nonnegative, and reconcile each claimed source occurrence.

## Shared dependency architecture

```text
locked-edition body collation + notation/entity resolution
                              |
pinned Mathlib reuse audit ---+--- low-level branch/domain/series support
                              |
                              v
                 construction, when necessary
                              |
                              v
           conventional specification + identification
                    |                     |
                    |                     +--> separately built definition audit
                    v
        elementary exact identities and real agreement
                    |
                    v
          comparison properties and positive envelopes
                    |
generic quantitative methods (independent of named families)
                    |
                    v
          named finite asymptotic applications
                    |
                    v
       zeros, connections, and source-recovery audits
```

Forbidden edges include definitions importing their asymptotic consumers, constructors importing a family umbrella that imports them back, the quantitative core importing named functions, and a comparison module introducing a second copy of an identified function.

## Natural-language proof dossier classes

Each family file names concrete dossiers, but all use the following minimum content.

| Dossier class | Required content before review |
|---|---|
| Reuse identification | Exact pinned declarations and imports; expanded source/conventional formula; domain and totalization comparison; proof that the wrapper is no stronger than the reused fact. |
| Series construction | Coefficient formula and parameter exclusions; finite coefficient identities; convergence radius or entire convergence; a `HasSum`-level value statement; analytic dependence actually required downstream; order-zero and terminating cases. |
| Integral construction | Exact contour/interval and orientation; integrand branches; convergence or improper-integral semantics; endpoint behavior; differentiation conditions; agreement with the actual object. |
| ODE/IVP identification | Actual regularity; exact equation; enough initial, boundary, or Wronskian data; existence; uniqueness on the stated domain; proof that normalization is independent of downstream asymptotics. |
| Continuation and exceptional parameters | Initial domain; overlap equality; continuation domain and uniqueness; pole/removable-value analysis; explicit totalized off-domain behavior; parameter regularity needed for limiting definitions. |
| Real/complex agreement | Pointwise agreement on a stated real set; reality proof; neighborhood hypotheses for derivative restriction; exact derivative variable and scaling. |
| Comparison/envelope | Exact model identity first; positivity/nonvanishing of envelopes; zero-safe bounds; normalization and Wronskian; no arbitrary field that assumes the desired estimate. |

Every dossier expands quantifiers, names upstream facts, proves analytic side conditions, treats edge cases, traces constants, and includes at least one adversarial test. “Standard,” “by analytic continuation,” and “take the usual branch” are not proof steps.

## Common acceptance gates

A family can be called **identified** only when all applicable checks below pass:

- a locked-edition source claim has a resolved, independently reviewed occurrence; project extras are labelled separately;
- the actual implementation object is unique in the public API;
- its conventional series, integral, transformation, or normalized equation is proved on the stated domain;
- convergence/integrability and regularity are theorems, not consequences inferred from a totalized expression;
- branch, cut, orientation, scaling, argument order, derivative variable, and exceptional values are visible;
- reused Mathlib semantics have been compared at the pinned commit;
- real agreement and derivative agreement are proved at the strength actually consumed;
- the public audit contains independently recognizable normalization and exceptional-value regressions;
- dependency review finds no backward edge and no hidden second construction;
- required pre-Lean and implementation quorums approve the same frozen artifacts and exact candidate head.

A family can be called **ready for a named quantitative application** only after identification, plus proof of application-domain reachability/nonemptiness, majorant nonnegativity, every concrete generic hypothesis, exact constants and thresholds, and source-occurrence reconciliation. An abstract theorem conditioned on an assumed model bound remains infrastructure.

## Shared negative-test policy

Every family audit must include failures that a superficially plausible API could miss:

- swapping two parameters or the order/argument positions;
- dropping a power, sign, phase, or normalization factor;
- extending a convergent series or integral outside its domain by totalization;
- treating division by zero as a removable continuation;
- using pointwise real agreement to infer derivative agreement;
- identifying a solution from an ODE without enough normalization;
- choosing a solution, branch, phase, or contour whose required property is merely assumed;
- importing a later asymptotic theorem to establish the baseline definition;
- dividing an error by a named function at one of its zeros;
- calling a DLMF convention an Olver occurrence without locked-edition evidence.

The family files add concrete sign, branch, exceptional-order, and scaling regressions.

## Queue maintenance

Provisional IDs are stable planning handles within this directory, not registry entries. Before registration, the specification owner must:

The queue tables use the packet-level axes from artifact revision 2 of
`review/classifications-v2.json`.  Thus `exact_identity`,
`qualitative_support`, and `audit_regression` in those tables describe whole
packet shape; they do not pre-classify each future declaration.  `mixed` is
used when the principal targets span more than one packet shape.  Every bounded
card must later supply independent target-level rows.

1. split any row that cannot be expressed as a bounded declaration packet;
2. assign exact theorem and coverage classes using the theorem-card vocabulary;
3. add exact signatures, imports, source/entity/notation IDs, exclusions, dependencies, consumers, and an owner;
4. record natural-language proof revisions and review requirements;
5. revise a manifest explicitly if the card is to become executable or claim coverage.

Deleting a speculative row does not delete a source occurrence. Adding a discovered entity does not add it to a release. The CSV inventory, theorem cards, external review evidence, and family programme remain distinct records of distinct facts.
