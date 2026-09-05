# Proof-producing tactic roadmap

**Status:** planning specification; no tactic implementation is authorized

**Scope:** theorem-first automation for exact estimates and exact finite residuals

**Excluded:** numerical evaluation, interval arithmetic, tolerance search, adaptive
truncation, quadrature, floating point, external CAS or solver certificates

This document refines the tactic policy in `blueprint/roadmap.md`.  The three
candidate tactics are conveniences over accepted theorems.  They do not enlarge
the trusted base, prove new mathematics, or earn source coverage.  A manual
proof remains the reference semantics for every automated proof.

## 1. Global admission rule

No custom tactic is admitted because its name appears in the roadmap.  Before a
tactic work packet may be frozen, all of the following must hold:

1. every theorem the tactic may apply is already in an accepted semantic module;
2. the repeated manual consumers meet the tactic-specific threshold below and
   are recorded by declaration and accepted commit;
3. those consumers exhibit the same mathematical proof boundary, not merely
   similar surface syntax;
4. a natural-language automation contract lists the accepted goal shapes,
   deterministic inputs, emitted side conditions, failure behavior, search
   limits, imports, and trace format;
5. two independent pre-Lean reviewers approve that contract for API/dependency
   design and proof/trust behavior;
6. the tactic has a bounded work packet and is not added to a closed semantic or
   source-coverage manifest by implication; and
7. the reference manual proofs remain in regression fixtures until the tactic
   has survived at least two reviewed releases.

“Stable manual consumer” means a compiled and audited declaration whose
statement is frozen and whose proof has passed the normal axiom, import, and
regression gates.  Prototype spikes and two variants of one proof do not count
as separate consumers.

Readiness is necessary, not sufficient.  If the tactic saves little code,
obscures useful constants, or gives worse diagnostics than theorem application,
the decision is to keep the combinators and omit the tactic.

## 2. Trust model

Lean's kernel checks the proof term emitted by a tactic.  The metaprogram that
searches for and assembles the term is therefore outside the trusted kernel in
the usual sense: a bug may make it fail, time out, or propose an ill-typed term,
but it cannot make the kernel accept a false theorem.  This story is valid only
under the following controls:

- tactic success always ends in an ordinary proof term built from declared
  theorems and kernel-checked reduction;
- no new `axiom`, `sorry`, `admit`, `unsafe` proof escape, `implemented_by`,
  unverified native-code oracle, external solver result, or generated theorem
  assumption is permitted;
- standard proof-producing normalization such as `simp`, `ring_nf`,
  `field_simp`, `norm_num`, `positivity`, `linarith`, and `nlinarith` may be used
  only where its hypotheses are present and its proof term is checked;
- a future reflective procedure requires its own correctness theorem and review
  packet; reflection is not smuggled in as a tactic implementation detail;
- every changed public theorem receives an axiom report.  Tactic use does not
  change the packet's allowed-axiom list;
- tactic modules are opt-in leaves.  Semantic foundations, function
  constructions, identifications, and source applications do not import
  `LMLF.Tactic.*` merely to make their statements available; and
- tactic traces identify every applied project rule and every generated
  obligation.  A trace is diagnostic evidence, not a proof certificate.

Failure is conservative: the original goal remains unproved, with no local
declaration and no coverage state changed.  A timeout, unsupported expression,
or ambiguity is an ordinary tactic failure.

## 3. Rule registration

Automation must use a small, reviewed registry rather than searching every
theorem in the environment.  Each rule-registration change is reviewed like a
public API change and records:

- the fully qualified theorem declaration and accepted work-item commit;
- the input and conclusion heads it matches;
- whether application is directional or symmetric;
- the side-condition classes it can emit;
- the semantic layer and narrow import that owns it; and
- positive, negative, and ambiguity fixtures.

Registration never changes a theorem's meaning and never marks an application
as source-complete.  Family-specific recurrence rules remain locally scoped;
they are not global simplifier rules.  Special-function definitions are never
globally unfolded into infinite sums, integrals, or ODE characterizations.

The registry must reject cycles among derived rules and cap search by rule
applications and expression size.  The default mode is deterministic: fixed
input, environment, and registry order produce the same proof plan and the same
ordered side-condition list.

## 4. `bound_calc`

### 4.1 Purpose

`bound_calc` composes already proved finite bounds.  Its primary lane works with
`QuantitativeAnalysis.ErrorOn` and `NormBoundOn`; a later pointwise-inequality
lane may be proposed only if repeated consumers justify it.

The intended rules include restriction, weakening, exactness, transitivity,
finite sums, scalar or linear maps, products, inversion, and division.  Each
rule first exists as a discoverable theorem.  The tactic is a thin proof-plan
constructor over those theorems.

### 4.2 Readiness threshold

The initial work packet may be drafted only after at least **three stable manual
consumers** satisfy all of these conditions:

- they occur in at least two semantic modules and two work packets;
- together they use at least three distinct rule shapes, one of which is not
  mere restriction or weakening;
- at least one exposes a genuine sign, denominator-margin, domain-intersection,
  or operator-norm side condition; and
- the proposed common registry reproduces their natural bounds without
  worsening a frozen constant or shrinking a frozen domain.

One long proof split into three lemmas counts once.  The QB-001 bootstrap alone
does not meet the threshold.

### 4.3 Input and output contract

The user supplies the target bound in the goal and the relevant hypotheses or a
bounded list of named facts.  The tactic may infer routine intermediate
approximants when the chain is unique.  It does **not** synthesize an unnamed
constant, choose between mathematically different majorants, or search for a
smaller domain.

On success it emits a kernel-checked composition proof and leaves any unsolved
conditions as ordinary, named goals.  The result must display the exact natural
bound, including cross terms such as `e * d`, inverse margins such as `m - e`,
and supplied operator norm factors.  Simplified corollaries are separate proof
steps.

### 4.4 Side conditions

Depending on the selected rule, the tactic can emit:

- set inclusion, equality, `Set.MapsTo`, or intersection membership;
- pointwise comparison between the proved and requested majorants;
- nonnegativity of standalone controls not already implied by a bound;
- positivity and strict denominator margins such as `0 < m` and `e < m`;
- nonvanishing needed for totalized division to represent the intended formula;
- an explicit norm bound for a linear or bilinear map;
- segment, image, branch, or analytic-neighborhood containment for nonlinear
  composition; and
- typeclass or scalar-action obligations made visible by the selected theorem.

The tactic may discharge a side condition by a local assumption or a
proof-producing elementary closer.  The trace still records that the condition
existed and how it was closed.  It may not replace it by a stronger invented
assumption.

### 4.5 Explicit non-goals

`bound_calc` does not:

- prove integrability, differentiability, analyticity, branch existence, model
  envelopes, contour construction, or ODE stability;
- turn an existential or qualitative asymptotic statement into a constant;
- choose a Cauchy radius, truncation order, contour, or tolerance;
- use interval or floating-point evaluation;
- declare a generic conditional estimate to be a named application; or
- use the conclusion of a structure field as if the named instance had been
  discharged.

## 5. `cauchy_bound`

### 5.1 Purpose

`cauchy_bound` applies an accepted wrapper around
`Complex.norm_iteratedDeriv_le_of_forall_mem_sphere_norm_le` to an explicitly
chosen center, order, and positive radius.  For an error remainder it also uses
the proved derivative-of-difference bridge.  Its natural output is the exact
factor

```text
(k.factorial : ℝ) * B / r ^ k.
```

The tactic is a domain-and-application wrapper, not a complex-extension or
geometry discovery engine.

### 5.2 Readiness threshold

The initial work packet requires at least **three stable explicit-radius
proofs**, in at least two work packets, with:

- two genuinely different radius geometries, such as fixed radius and
  proportional radius, or proportional radius and distance-to-boundary radius;
- one order-zero fixture and one positive-order fixture;
- one proof whose boundary estimate requires a nontrivial weight comparison;
- one real-facing consumer that separately uses an accepted complex-to-real
  derivative restriction theorem; and
- exact constant and domain regressions, including the proposed `29` versus
  `2048` comparison when that M3 packet is accepted.

Repeated specializations of the same disk lemma do not satisfy this threshold.

### 5.3 Required inputs

The call must identify or make uniquely inferable:

- derivative order `k`;
- center or center function;
- chosen radius or radius function `r`;
- the functions `f` and `a`, or the already named remainder;
- the accepted differentiability/continuity-on-closed-disk hypotheses; and
- the boundary-sphere bound with its displayed majorant.

Optional syntax may request a particular accepted corollary, such as a
proportional-radius form.  There is no radius optimizer in the tactic.

### 5.4 Emitted obligations

The tactic leaves, in a stable order:

1. positivity of every radius;
2. exact disk or closed-disk containment in the analytic domain;
3. the required `DiffContOnCl` or accepted equivalent regularity facts for both
   target and approximant;
4. the boundary-sphere remainder bound;
5. any boundary-to-center weight comparison;
6. threshold transport, for example `(1 - θ) * x ≥ R₀`;
7. sector, cut, pole, or branch avoidance introduced by the chosen disk; and
8. real/complex agreement and derivative restriction only when a separate
   real-facing wrapper has been explicitly requested.

The tactic does not infer neighborhood control from a real-axis estimate plus
holomorphy.  The permanent counterexample `exp (-z) * sin (exp (2*z))` must be a
negative regression for any attempted shortcut.

### 5.5 Failure boundary

It fails rather than choosing a radius, strengthening a threshold, replacing a
sphere bound by an unproved disk bound, applying Cauchy to a nonanalytic
absolute-value envelope, or confusing spatial and parameter derivatives.
Mixed derivatives and polydisks require a later separately carded tactic or
explicit theorem application.

## 6. `residual_nf`

### 6.1 Purpose

`residual_nf` proves exact identities for a finite approximant under a specified
differential operator.  It may differentiate finite expressions, distribute the
operator, shift and split finite sums, normalize coefficient-ring expressions,
apply scoped coefficient recurrences, cancel interior terms, and expose the
terminal residual.

Its output is an equality such as `L (A N) = rho N`.  It proves no inequality,
no smallness of `rho`, no existence of an actual solution, no normalization or
uniqueness theorem, and no stability estimate.  Those are distinct semantic
packets.

### 6.2 Readiness threshold

The roadmap threshold is literal: at least **two distinct ODE families** must
first have accepted manual exact-residual proofs sharing the same normalization
pattern.  In addition:

- each family has a frozen finite-sum and truncation convention, including
  `N = 0` and small-order statements;
- the shared steps are expressed by accepted generic finite-sum and derivative
  lemmas, rather than by accidental simplifier behavior;
- the families use materially different coefficient recurrences, showing that
  the abstraction is not a rename of one application;
- family-specific rules are scoped and carry no downstream estimate imports;
- exact residual identities compile under narrow imports; and
- the manual and automated forms agree in exact residual expression, not only
  after a norm inequality.

Until this threshold is met, the project develops `FiniteSum`, coefficient, and
family residual lemmas only.

### 6.3 Normalization package

A proposed call supplies a reviewed normalization package naming:

- the operator's exact action and linearity lemmas;
- the finite approximant and whether `N` counts terms or last index;
- derivative rules for each term constructor;
- permitted finite-sum shift, split, and endpoint lemmas;
- the coefficient recurrence and its valid index range;
- the exact coefficient ring and coercion boundary; and
- the expected residual normal form.

This is ordinary registered theorem metadata, not a structure field asserting
the desired residual identity.  A package cannot contain the target equality as
an assumption.

### 6.4 Emitted obligations

The tactic can emit:

- differentiability or finite differentiability needed by derivative rules;
- index inequalities for recurrence application and endpoint splitting;
- denominator nonvanishing or parameter exclusions in the recurrence;
- branch/domain facts for exact powers or logarithmic blocks;
- coercion and characteristic facts required to move coefficient identities
  into the analytic codomain;
- boundary cases for empty sums and `N = 0`; and
- operator-domain membership where the operator is not total semantically.

It does not discharge those by totalized division, derivative, or integral
behavior.  Cancellation happens in the exact coefficient ring before norms or
order comparisons.

### 6.5 Deliberate limits

The first tactic supports a small grammar learned from its two families.  It is
not a universal symbolic ODE solver, expression language for arbitrary real
functions, recurrence prover, branch solver, or computer algebra system.
Power-log and multi-component expansions enter only after new stable consumers
and a reviewed grammar extension.

## 7. Failure and adversarial suite

Each tactic packet must include fixtures that are expected to fail.  The runner
checks the stable diagnostic code or failure class, not the complete prose of an
error message.

| Candidate | Mandatory rejected case | Expected class |
|---|---|---|
| `bound_calc` | requested majorant is smaller with no comparison proof | `unproved_majorant_comparison` |
| `bound_calc` | inverse estimate has no positive denominator margin | `missing_denominator_margin` |
| `bound_calc` | only a generic assumed model bound is offered for a named application | `coverage_boundary` |
| `cauchy_bound` | radius is omitted or nonpositive | `radius_required` |
| `cauchy_bound` | real-axis bound is offered without a boundary-neighborhood bound | `missing_boundary_bound` |
| `cauchy_bound` | chosen disk crosses a cut or leaves the analytic domain | `disk_containment` |
| `residual_nf` | a recurrence is applied outside its index range | `recurrence_domain` |
| `residual_nf` | a denominator is zero at an exceptional parameter | `nonvanishing_required` |
| `residual_nf` | the goal asks for solution error from residual smallness alone | `stability_not_residual` |

Additional tests cover ambiguous rule paths, registry cycles, unsupported
syntax, expression-size and step limits, and missing scoped imports.  A tactic
must never close one of these tests after a registry refactor without an
explicitly reviewed contract change.

## 8. Regression obligations

Every automated proof has a theorem-level regression whose statement protects
the mathematical output.  The suite includes:

- empty and singleton domains;
- order zero, first nontrivial order, vanishing coefficients, and terminating
  sums;
- exact natural bounds before simplified corollaries;
- explicit constants, threshold transport, and disk geometry;
- branch cuts, exceptional parameters, and totalized-operation traps;
- cancellation points where a relative error would be meaningless;
- residual endpoint terms and recurrence off-by-one cases;
- deterministic traces and stable side-condition ordering; and
- a comparison against the retained manual reference proof.

The comparison is not source-text equality.  Both proofs must establish the
same frozen theorem, pass the same axiom allowlist, and respect the same narrow
import boundary.

## 9. Rollout and stability

Each tactic progresses through three stages:

1. **private fixture:** used only in `LMLFTest`, with manual proofs retained;
2. **experimental opt-in:** its own narrow `LMLF.Tactic.<Name>` import, no use in
   semantic source-coverage modules, and no compatibility promise; and
3. **stable opt-in:** only after two reviewed releases, no silent output changes,
   complete negative tests, and documented migration for registry changes.

Tactic implementation and semantic theorem implementation are never placed in
the same work packet.  A tactic cannot approve its own theorem, change theorem
cards, set lifecycle status, or generate external review verdicts.

## 10. Permanent exclusions

There will be no `interval_bound`, floating-point normalizer, tolerance router,
adaptive order selector, numerical Cauchy optimizer, quadrature tactic,
root-finding tactic, or ODE solver in this project.  Exact rational
specializations proved by ordinary `norm_num`-style mathematics remain in
scope.  Their role is proof and regression, not numerical evaluation.
