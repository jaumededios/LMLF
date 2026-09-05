# Open mathematical research queue

**Normative owner:** `jaumededios`

**Queue status:** planning only

**Coverage effect:** none until a question is converted into reviewed theorem
cards and released declarations

## Purpose

LMLF contains problems that are genuinely mathematical, not merely Lean
implementation tasks: finding explicit finite bounds behind qualitative source
statements, proving the right continuation and uniqueness theorems, constructing
uniform transformations, retaining fixed solutions at every order, and
separating local zero information from global indexing. This document keeps
those questions visible without turning hopes into prerequisites or coverage
claims.

The queue is deliberately distinct from:

- the source occurrence inventory, which records what is printed;
- the family programme, which records candidate packet boundaries;
- theorem cards, which freeze exact statements;
- release manifests, which contain only finite, fully carded work;
- implementation issues, which concern an already reviewed theorem.

A research ID is a discussion handle, not a theorem ID. No row here authorizes
Lean work, claims novelty, resolves a source occurrence, or enters a release
denominator.

Answers become source-facing results only through the
[audit-only recovery contract](source_recovery.md), the
[cross-linked catalogue](navigation_and_docs.md), and the closed gates in the
[release strategy](release_strategy.md).

## Queue states and priorities

Use these research states:

| State | Meaning |
|---|---|
| `question` | The issue is real, but the exact mathematical alternatives are not yet bounded. |
| `scoped` | Inputs, desired outputs, and counterexamples are sufficiently clear for a research dossier. |
| `candidate_answer` | A complete mathematical proposal exists but is not independently reviewed. |
| `reviewed_answer` | The research conclusion is reviewed; exact theorem cards may now be drafted. |
| `converted` | Bounded cards record every intended declaration; the queue item links them. |
| `retired` | The question was duplicated, disproved, made irrelevant, or deliberately deferred, with a reason. |

Priorities describe scheduling, not severity:

- `critical_path`: blocks a currently selected source manifest;
- `near_term`: unlocks several already planned packets;
- `programme`: important for a later established track;
- `exploratory`: useful but not yet justified as a dependency.

Only a manifest may turn a research dependency into release-critical work.

## Summary queue

| ID | Priority | Initial state | Question | Likely track |
|---|---|---|---|---|
| RQ-SRC-001 | critical_path | candidate_answer | What is the exact locked-edition Watson proposition and local convention set? | source recovery |
| RQ-WAT-001 | critical_path | candidate_answer | Which explicit finite Watson theorem follows from precisely those hypotheses? | integral methods |
| RQ-QUAL-001 | critical_path | scoped | What bridge proves the exact printed qualitative relation from the finite theorem? | qualitative recovery |
| RQ-SCALE-001 | near_term | question | What minimal project representation of asymptotic scales supports source recovery without entering the finite core? | audit architecture |
| RQ-INT-001 | near_term | candidate_answer | How should local amplitude control and the nonlocal Laplace tail be combined with useful explicit constants? | integral methods |
| RQ-CAUCHY-001 | near_term | scoped | Which radius-selection theorems preserve useful derivative constants across moving domains? | complex derivatives |
| RQ-AIRY-001 | near_term | question | What shared construction gives identified Ai/Bi while remaining independent of turning-point estimates? | definitions/ODE |
| RQ-BESSEL-001 | near_term | question | How should Bessel kernels, branches, and exceptional orders be constructed and identified uniformly? | definitions/continuation |
| RQ-PARAM-001 | programme | question | What parameter-analyticity results justify derivatives and exceptional-parameter limits? | parameter transitions |
| RQ-CODE-001 | programme | question | What reusable complex linear-ODE existence and uniqueness layer is actually needed? | ODE foundations |
| RQ-FIXED-001 | programme | scoped | How can one normalized solution be shown to satisfy every finite order estimate? | ODE normalization |
| RQ-PATH-001 | programme | question | Can progressive paths be constructed with explicit geometry on the intended sectors? | ODE stability |
| RQ-TURN-001 | programme | question | Which positive zero-safe Airy envelopes yield uniform value and scaled-derivative bounds? | turning points |
| RQ-POLE-001 | programme | question | What comparison system and envelopes are correct near simple poles and order transitions? | pole transitions |
| RQ-SUM-001 | near_term | question | What finite Euler–Maclaurin theorem with explicit remainder is best for source applications? | summation |
| RQ-FROB-001 | programme | question | How should regular-singular resonance and logarithmic terms be separated quantitatively? | regular singularities |
| RQ-COAL-001 | programme | question | Which coalescing-saddle normal forms can be constructed with explicit uniform domains and tails? | contour methods |
| RQ-ZERO-001 | programme | scoped | Which hypotheses turn approximate zeros into local existence, uniqueness, and displacement bounds? | zeros |
| RQ-INDEX-001 | programme | question | What extra global information identifies a local zero as the source's indexed zero? | zeros |
| RQ-CONN-001 | programme | question | How can connection matrices retain exponentially small coefficients that algebraic error cannot resolve? | connections |
| RQ-SHARP-001 | exploratory | question | Which natural constants and domains deserve sharpened alternative proofs? | quantitative quality |

The initial state is conservative. A source locator, a plausible proof sketch,
or a Mathlib declaration with a similar name does not move an item to
`candidate_answer`.

## Critical-path questions

### RQ-SRC-001 — locked Watson collation

**Question.** What are the exact hypotheses, coefficient and exponent
conventions, endpoint assumptions, parameter quantifiers, and qualitative
conclusion of Watson's lemma on printed pp. 71–72 of the locked 1997 reprint?

**Why it remains open.** A hash-bound 1997 snapshot, page map, mathematical
transcription, and provisional notation/entity records now exist. Independent
collation review and reconciliation remain pending, especially for the scalar
codomain and conditional-improper-integral convention. A later preview cannot
silently answer either question.

**Closing evidence.** An inspected snapshot record, printed-page map,
copyright-safe mathematical transcription with digest, notation/entity links,
and independent collation review.

**Guardrail.** DLMF's modern formulation or a theorem remembered as “Watson's
lemma” cannot be substituted for the occurrence selected by `OLV-MVP-1`.

**Candidate answer.** See
[`OLV97-C03-WATSON.md`](../source_transcriptions/OLV97-C03-WATSON.md) and the
[independent review questions](../../review/questions/OLV97-C03-WATSON.md).

### RQ-WAT-001 — explicit finite Watson theorem

**Question.** After RQ-SRC-001, what explicit remainder identity and bound can
be proved from exactly the collated source hypotheses, and which useful stronger
finite theorem requires additional hypotheses?

The research must decide whether the source controls the amplitude globally or
locally, how the integration range and exponential scale are normalized, how
the tail is bounded, whether Gamma moments are genuinely needed, and what the
order-zero statement means.

**Closing evidence.** A complete natural-language proof that separates:

- finite amplitude expansion;
- exact termwise moments;
- local remainder integral;
- nonlocal tail;
- all integrability and endpoint conditions;
- explicit order, parameter, threshold, and constant dependence;
- a nonempty specialization and nonnegative majorant.

The proof must identify an exact source-matching theorem and separately label
any theorem using stronger hypotheses.

**Candidate answer.** The draft
[`OLV-001` proof](../proofs/OLV-001.md) derives a local-Gamma plus
exponential-tail inequality from precisely the source proof, through the draft
[`QL-001` finite theorem](../proofs/QL-001.md).  The global-majorant formulas
on printed pp. 89-90 are transcribed separately and are not assumed in this
route.

**Guardrail.** A global remainder theorem assumed as a hypothesis is not a
solution when the source only supplies local data. An explicit coefficient
formula is not an explicit remainder bound.

### RQ-QUAL-001 — exact Watson qualitative bridge

**Question.** Which eventual-domain and scale-comparison lemmas derive the
collated Watson conclusion from RQ-WAT-001's finite theorem with the same fixed
parameters and order convention?

**Closing evidence.** A source-facing proposition, a proved notation equality,
eventual membership in the finite theorem's domain, the exact big-O/little-o or
expansion implication, and an `SR-001` proof dossier reviewed against the locked
occurrence.

**Guardrail.** An all-orders finite family does not imply a Poincaré expansion
until the scale and normalized remainders are controlled for every fixed order.

## Foundational qualitative questions

### RQ-SCALE-001 — source-facing asymptotic scales

**Question.** What is the smallest audit-only interface that faithfully
expresses the qualitative relations Olver actually uses: asymptotic sequence,
Poincaré expansion, uniform expansion, equivalence, and differentiated
expansion?

The answer should first inventory exact source definitions and check Mathlib's
existing relations. A local predicate is justified only where it states a
genuinely source-specific convention or eliminates repeated mismatch. It must
not become a universal semantic expansion typeclass.

**Closing evidence.** At least two collated source consumers, exact comparison
with existing Mathlib notions, fixed zero/order conventions, and bridge proofs
from finite estimates.

**Guardrail.** The interface remains in `Audit/SourceRecovery`; semantic finite
theorems do not acquire filter arguments to satisfy it.

### RQ-INT-001 — local Watson bounds and tails

**Question.** Given a finite local expansion of an amplitude on ([0,T]), what
minimal explicit hypotheses control the tail beyond (T) without assuming the
desired result?

Candidate approaches include a directly supplied tail majorant, global growth
control integrated against the kernel, or a source-specific monotonicity bound.
They lead to different theorems and should not be hidden behind one record.

**Closing evidence.** Separate exact identities and estimates, comparison of at
least two useful hypothesis sets, and examples showing when the global and local
versions differ.

**Guardrail.** Compactness or integrability alone cannot manufacture the
numerical-valued tail control required by a finite bound.

### RQ-CAUCHY-001 — derivative radii and moving domains

**Question.** Which explicit radius functions give useful derivative bounds for
half-planes, sectors, annuli, and turning-point neighborhoods while preserving
the original threshold and branch conditions?

The first test is the known proportional-radius calculation where the natural
choice yields a factor below 29 rather than the crude half-radius factor 2048.
Later tests should include radii of size (u^{-2/3}) and distance-to-cut
constraints.

**Closing evidence.** Geometry lemmas, exact factorial/radius losses, threshold
transport, optimized choices under their true constraints, and a comparison
against a direct differentiated identity.

**Guardrail.** Optimizing a scalar factor cannot override disk containment. A
real-axis bound plus an entire extension is not neighborhood control.

## Named-function construction and continuation

### RQ-AIRY-001 — one noncircular Airy construction

**Question.** Does Mathlib's regularized hypergeometric substrate provide the
best shared actual construction of Ai/Bi, or is a direct entire IVP series more
auditable at the pinned revision?

The answer must compare coefficient recurrence, convergence, analyticity,
parameter-free normalization constants, real agreement, IVP uniqueness, and
future sharing with Bessel kernels. It should not choose a construction only
because the first few formulas are short.

**Closing evidence.** A complete construction/identification proof on paper,
an exact reuse audit, two normalization checks, and a dependency proof that no
turning-point asymptotic theorem is used.

**Guardrail.** The Airy equation without both normalizing data does not identify
Ai or Bi. A chosen solution carrying the desired estimates is circular.

### RQ-BESSEL-001 — kernels, branches, and exceptional order

**Question.** How should one actual Bessel family support the principal
first-kind series, second-kind continuation, modified functions, and Hankel
normalizations without duplicating functions or using division by zero at
integral orders?

Subquestions include regularized (0F1) reuse, the branch of
((z/2)^\nu), behavior at (z=0), analyticity in the order parameter, and the
continued definition of (Y_n) and related functions.

**Closing evidence.** Domain-correct specifications for each selected entity,
parameter-regularity proof strong enough for exceptional-order limits, exact
connection formulas, and adversarial sign/power-of-two/order tests.

**Guardrail.** The quotient formula for nonintegral order is not a definition
at integral order under Lean's totalized division. A normalized kernel is not
itself the classical Bessel function until the prefactor is reconstructed.

### RQ-PARAM-001 — parameter analyticity

**Question.** What joint regularity in parameter and spatial variables is
needed for the source's order derivatives, limiting definitions, moving-
argument chain rules, and uniform bounds?

Different consumers may need holomorphy in the spatial variable only,
differentiability in one real parameter, or joint holomorphy on a product
domain. The weakest natural result should be selected per consumer rather than
asserted universally.

**Closing evidence.** Explicit product domains and branch charts, derivative
identities including logarithmic terms from parameter-dependent powers, and
uniform majorants justifying series/integral differentiation.

**Guardrail.** Spatial holomorphy says nothing by itself about differentiation
with respect to order. Pointwise continuation at exceptional parameters does
not supply parameter derivatives.

## ODE and transition research

### RQ-CODE-001 — complex analytic linear ODE layer

**Question.** What reusable existence, uniqueness, Wronskian, and parameter-
dependence results are required below special-function identification and
Liouville–Green theory, given that the pinned Mathlib ODE API is primarily
real-time?

**Closing evidence.** Two concrete consumers, a natural state-space and domain
formulation, exact hypotheses for analytic coefficients, and a proof plan that
reuses general calculus without rebuilding an unnecessary ODE framework.

**Guardrail.** Do not create a broad complex-ODE hierarchy in anticipation of
consumers. Do not use later special-function asymptotics to prove foundational
uniqueness.

### RQ-FIXED-001 — one solution at every order

**Question.** When a source proof constructs an approximating or exact solution
after fixing truncation order, what normalization or compatibility argument
proves the estimates concern one fixed function for all orders?

**Closing evidence.** A precise distinction between
“for every order there exists a solution” and “there exists one solution for
every order,” followed by a uniqueness, overlap, or normalization theorem that
proves the latter where required.

**Guardrail.** `HasErrorFamily` requires one fixed target. Packaging an
order-indexed family of chosen solutions under one informal name is a P0
specification failure.

### RQ-PATH-001 — progressive-path construction

**Question.** For each intended Liouville–Green sector, can one explicitly
construct paths on which the phase is progressive and bound the resulting
error-control integral?

There are two required outputs: a generic estimate for any admissible path and
a named construction on an explicit region. Only the second discharges a named
application.

**Closing evidence.** Parameterized paths, regularity, endpoints, domain and
branch containment, progress inequalities, length/weight control, and an
explicit error-control bound.

**Guardrail.** A structure field saying an admissible path exists is not the
construction. Simply connectedness or a diagram is not quantitative geometry.

### RQ-TURN-001 — Airy envelopes through a turning point

**Question.** Which positive envelopes for Ai, Bi, and their derivatives are
strong enough to make two-component remainder bounds meaningful at comparison-
function zeros and uniform across the transition scale?

**Closing evidence.** Exact model identities, positivity or nonvanishing of the
envelopes, Wronskian normalization, explicit value and scaled-derivative bounds,
and matching on overlap regions.

**Guardrail.** Relative error against Ai is invalid at an Airy zero. A positive
envelope is an analytic object requiring proof, not an arbitrary field assumed
to dominate the function.

### RQ-POLE-001 — simple-pole comparison models

**Question.** Which Bessel/modified-Bessel comparison basis, phase shift, and
scaled state correspond to Olver's simple-pole transformations, and how are
their branches and exceptional orders reconciled?

**Closing evidence.** Direct source collation, exact transformed operator,
identified model functions, zero-safe envelopes, and explicit uniform domains.

**Guardrail.** Modern DLMF taxonomy can guide the search but does not determine
the book's normalization or prove that a named model occurs in the locked
edition.

## Summation, singularities, and coalescence

### RQ-SUM-001 — finite Euler–Maclaurin remainder

**Question.** Which finite Euler–Maclaurin form best matches the selected Olver
occurrences while reusing Mathlib's Bernoulli material and integration by
parts?

Decisions include endpoint convention, Bernoulli (B_1) sign, finite smoothness
versus analytic hypotheses, periodic Bernoulli normalization, interval and tail
forms, and an explicit remainder norm.

**Closing evidence.** Exact finite identity, explicit remainder integral and
bound, order-zero/small-order tests, and a source occurrence showing the
chosen orientation is useful.

**Guardrail.** The availability of Bernoulli polynomials is not the availability
of Euler–Maclaurin. An unspecified derivative supremum is not a completed
source application.

### RQ-FROB-001 — resonance at a regular singularity

**Question.** How should quantitative Frobenius theorems separate nonresonant
denominator bounds from resonant logarithmic solutions and parameter limits?

**Closing evidence.** Exact recurrences, convergence or finite remainder
bounds, resonance classification, construction and normalization of the second
solution, and a domain that does not hide small denominators.

**Guardrail.** A uniform coefficient formula with a vanishing denominator is
not repaired by totalization. Excluding resonance and treating resonance are
different theorems.

### RQ-COAL-001 — constructed coalescing normal forms

**Question.** For selected coalescing saddle or endpoint configurations, can the
normal-form map and contour deformation be constructed with explicit parameter
domains, inverse bounds, and nonlocal tails?

**Closing evidence.** A fixed-contour or fully accounted moving-contour
identity, quantitative inverse/implicit-function bounds, branch and orientation
control, local coefficient identities, and explicit tails.

**Guardrail.** A record whose fields assume the desired normal form and all its
bounds is conditional infrastructure, not completion of a named configuration.

## Zeros and connection problems

### RQ-ZERO-001 — local zero displacement

**Question.** What reusable hypotheses on a finite approximant and remainder
give existence, uniqueness, and an explicit displacement bound for a nearby
zero in the real and complex settings?

Candidate routes include sign/monotonicity, quantitative inverse-function
arguments, Rouché-type estimates, and Newton–Kantorovich-style inequalities.
They have different domains and multiplicity assumptions and should not be
merged prematurely.

**Closing evidence.** At least two genuine consumers or one independently
useful theorem, a nonempty neighborhood, derivative/nondegeneracy margin,
boundary exclusion, multiplicity statement, and a sharp adversarial example.

**Guardrail.** A small residual at one point does not prove existence or
uniqueness. A local zero is not automatically the (m)-th source zero.

### RQ-INDEX-001 — global indexing

**Question.** Which ordering, sign, oscillation, argument-principle, or
zero-counting information identifies a locally located zero with Olver's global
index?

**Closing evidence.** A separate theorem connecting local neighborhoods to a
complete interval/contour count and showing no skipped or repeated zero.

**Guardrail.** The nearest approximate zero need not have the intended index.
Indexing is never bundled silently into a local perturbation theorem.

### RQ-CONN-001 — exponentially small connection data

**Question.** How can normalized fundamental matrices and their error bounds
determine connection coefficients at the scale claimed by the source,
especially when algebraic-order remainders dominate an exponentially small
entry?

**Closing evidence.** Exact basis and Wronskian normalization, overlap identity,
spatial constancy, inverse bounds with column scales preserved, cocycle
compatibility, and a remainder smaller than every coefficient being resolved.

**Guardrail.** An unresolved exponentially small coefficient is not zero.
Changing basis normalization can change the connection matrix and must be
tracked explicitly.

## Quantitative quality

### RQ-SHARP-001 — which bounds should be sharpened?

**Question.** Where does a natural proof lose enough in constant or domain to
harm a real source application, and which alternative identity or radius/path
choice repairs that loss?

This is not an invitation to optimize every constant. Candidate work must name
a downstream theorem and compare the complete domain/threshold/constant tuple.

**Closing evidence.** Two proved bounds, exact specializations, downstream
impact, and a regression showing the intended improvement.

**Guardrail.** A smaller constant on a much smaller or unreachable domain is not
automatically sharper. Decimal approximation alone is not mathematical
improvement.

## Research dossier template

Before moving a row to `candidate_answer`, create a bounded dossier containing:

1. stable research ID, owner, source occurrences, and target consumers;
2. exact question with quantifiers and competing formulations;
3. pinned Mathlib and local-library search evidence;
4. source evidence and edition status;
5. proposed theorem statements in mathematical notation, not Lean code;
6. complete proof or counterexample, including analytic side conditions;
7. provenance of every constant, threshold, branch, path, and normalization;
8. edge cases, negative examples, and reasons nearby claims fail;
9. dependency direction and circularity analysis;
10. classification of the result as source equivalent, reformulation,
    generalization, stronger conclusion, stronger hypotheses, or genuinely new;
11. explicit statement of what the answer does **not** solve;
12. independent review requirements before theorem-card conversion.

Experiments, computer algebra, numerical plots, and literature searches may
guide a dossier. They are evidence sources, not a proof of the proposed exact
theorem.

## Conversion to theorem cards

A `reviewed_answer` may be converted only by splitting it into finite cards with
exact imports, declarations, binder order, dependencies, proof artifacts,
exclusions, and review gates. Conversion follows these rules:

- generic infrastructure and named application are separate cards;
- exact identity, residual bound, existence, normalization, stability, and
  source recovery are split when they have distinct proof or dependency roles;
- a new explicit constant or uniformity claim is classified as new mathematics
  and reviewed before Lean;
- source-equivalent and strengthened statements receive separate recovery
  obligations;
- a conditional theorem remains conditional until a named card discharges its
  assumptions;
- the research row links the cards but does not inherit their status.

If research finds that a desired theorem is false, retain the counterexample and
retire or reformulate the item. Do not delete the question and later reintroduce
the same overclaim.

## Queue maintenance and anti-overclaiming

Review this queue at every manifest-planning cycle. Add an item only when it has
a concrete mathematical uncertainty and plausible downstream consumer. Merge
duplicates, retire obsolete abstractions, and record when a pinned Mathlib fact
fully answers the question.

The queue audit rejects:

- marking literature consensus as `reviewed_answer` without a checked proof;
- treating a source locator as a mathematical transcription;
- describing a conditional structure as construction of its fields;
- moving a desired estimate, contour, branch, or normalization into an
  assumption and declaring the named problem solved;
- counting a research answer as source coverage or released API;
- assigning a release date to an unsolved theorem and then weakening the
  theorem silently to meet it;
- allowing an exploratory abstraction to block unrelated closed manifests;
- closing a question because a Lean statement with different hypotheses
  compiles.

The queue is successful when it makes the hard parts legible early, lets
independent tracks proceed, and preserves the difference between “we know what
must be proved,” “we have a reviewed mathematical proof,” and “the theorem is
released.”
