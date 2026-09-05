# Qualitative source recovery

**Normative owner:** `jaumededios`

**Programme status:** planning only

**Source edition:** F. W. J. Olver, *Asymptotics and Special Functions*,
corrected A K Peters reprint, 1997, ISBN 1-56881-069-5

## Purpose

The long-term source-facing deliverable is a qualitative version of Olver that
is extremely close to the locked edition in order, notation, hypotheses, and
conclusion. The semantic library nevertheless remains quantitative: its
canonical results are finite identities and explicit inequalities on stated
domains. These aims are compatible only if qualitative statements are
**downstream audit views** of quantitative theorems, never foundations for
them.

This document fixes that boundary. It specifies how a collated Olver occurrence
is connected to a finite theorem, how the printed qualitative conclusion is
recovered, and what evidence is required before the catalogue may say that the
occurrence has been recovered. It creates no theorem card, closes no manifest,
and makes no current source-coverage claim.

Companion plans specify the [catalogue and cross-link model](navigation_and_docs.md),
the [staged release gates](release_strategy.md), and the
[open mathematical research queue](open_research_questions.md).

The governing rule is:

> Quantitative theorems are the reusable mathematical API. Source-faithful
> qualitative theorems are separately built certificates that the stronger
> finite results really recover the locked source.

## Two products, one dependency direction

The project publishes two views of proved mathematics.

| View | Intended reader | Statement style | Dependency role |
|---|---|---|---|
| Quantitative semantic library | Formalizers and downstream mathematics | Finite approximant, explicit domain, explicit majorant, constants and order visible | Canonical reusable API |
| Olver source-recovery companion | Readers following the book chapter by chapter | The locked qualitative statement, with source notation and implicit conventions made precise | Audit-only consumer of the semantic API |

The source-recovery companion lives under `LMLF/Audit/SourceRecovery`. Its
modules are compiled in continuous integration and included in release
evidence, but neither `LMLF.lean` nor any semantic module imports them. A
source-recovery theorem may import a finite theorem; the finite theorem may not
import a qualitative bridge, a source occurrence, or Mathlib's filter-based
asymptotics solely to support that bridge.

The intended dependency graph is:

```text
finite core -> method theorem -> exact-source or named quantitative theorem
                                                        |
                                                        v
                                      Audit/SourceRecovery bridge lemmas
                                                        |
                                                        v
                                  edition-specific qualitative theorem
                                                        |
                                                        v
                                         catalogue and release evidence
```

There is no edge back from the last three layers. In particular:

- a qualitative theorem cannot be used to prove a quantitative theorem;
- a source-facing predicate cannot appear in a semantic public signature;
- a source card cannot hide a missing finite estimate behind a Landau
  hypothesis;
- source recovery never licenses a second implementation of a named function;
- deleting the audit tree must leave the semantic package buildable with the
  same public declarations.

## What “close to Olver” means

Closeness is assessed against a reconciled occurrence in the locked 1997
edition, not against memory, a later printing, or a modern DLMF paraphrase. For
each recovered occurrence, the source-facing page should preserve, as far as
Lean permits:

1. the chapter and local theorem order;
2. the source's function names and displayed argument order;
3. the source quantifier order and which parameters are held fixed;
4. the number-of-terms or last-index convention;
5. the source scale and its qualitative relation (`O`, `o`, asymptotic
   equivalence, asymptotic expansion, or another explicitly collated notion);
6. stated sector, interval, branch, and parameter restrictions;
7. uniformity or differentiation qualifiers only when the source states them;
8. exceptional cases and normalization conventions active at that occurrence.

Closeness does not mean reproducing ambiguous prose or relying on suppressed
conditions. A source statement with an implicit convention receives a precise
Lean proposition plus a short convention note. If two plausible readings are
not equivalent, the occurrence remains unresolved until collation settles the
choice. The catalogue may display the conventional printed notation while the
formal theorem uses canonical LMLF objects; an explicit notation/entity map
connects them.

The source-recovery theorem is not required to be the preferred downstream API.
It may intentionally retain source binder order, a historical normalization, or
a qualitative conclusion that is less informative than the quantitative
theorem. That is the point of the companion layer.

## The quantitative-to-qualitative bridge contract

A qualitative conclusion is never obtained from a finite bound by name alone.
Every bridge packet supplies the following evidence.

### 1. The quantitative producer

Identify one reviewed quantitative declaration and its exact theorem card. The
producer must concern the intended fixed target function and the intended
finite approximant. If it is a named application, the function's identification
gate must already have passed.

The producer exposes:

- the target and approximant at every used order;
- the domain and all parameter constraints;
- the majorant and proof of its nonnegativity on that domain;
- normalization, branch, exceptional-value, and derivative conventions;
- any restrictions coupling order, parameters, and the large variable.

### 2. An eventual-domain witness

The source limit process must eventually lie in the finite theorem's domain.
This is a mathematical theorem, not an inference from a threshold's name. For
each fixed set of source parameters and each order used by the qualitative
statement, the bridge proves eventual membership in the corresponding finite
domain.

Uniform source statements require the matching uniform domain result. A family
of pointwise thresholds chosen separately for each parameter does not recover a
uniform theorem.

### 3. A scale comparison

The finite majorant must imply the exact collated qualitative relation. Typical
proof obligations are:

- for a big-O conclusion, an explicit eventual comparison of the majorant with
  a constant multiple of the source scale;
- for a little-o conclusion, convergence of the majorant divided by the source
  scale to zero, with eventual positivity or nonvanishing where division is
  used;
- for asymptotic equivalence, a lower bound or nonvanishing result for the
  leading term sufficient to turn additive error into a relative statement;
- for an asymptotic expansion, the required remainder relation at each fixed
  order together with the source's exact index convention and asymptotic-scale
  hypotheses.

The finite estimate may be stronger than the source conclusion, but the bridge
must show the implication explicitly. An expression described informally as
“clearly smaller” is not recovery evidence.

### 4. A notation and normalization equality

The quantitative approximant must be proved equal, on the relevant domain, to
the finite expression printed by Olver after resolving source notation. This is
where coefficient normalization, powers, logarithms, phase factors, derivative
scalings, and branch conventions are reconciled. Definitional similarity is not
enough when a sign, power, or parameter conversion is involved.

### 5. The exact source conclusion

The final audit declaration states the precise collated proposition, not merely
a project-invented modern substitute. Its card has `theorem_class:
qualitative_bridge` and `coverage_class: audit_source_recovery`. It records the
source occurrence, the quantitative producer card, all bridge dependencies,
and the reconciliation result.

## Standard bridge families

Shared bridge lemmas may be developed inside the audit tree after repeated
proofs establish stable patterns. They should be small implications between an
explicit bound and Mathlib's qualitative relations. They do not belong in the
finite core.

### Eventual big-O

Suppose a finite theorem gives an error bound on a tail domain. To recover an
`O(g)` statement, the bridge needs an eventual-domain proof and an explicit
constant controlling the majorant by the norm of (g). The recovered relation
must use the same filter and parameter freezing as the source.

An unnamed existential constant is acceptable in the *qualitative audit
conclusion* when that is exactly the source notion, because the imported
quantitative theorem already supplies its provenance. It remains forbidden as
the terminal output of the semantic quantitative theorem.

### Eventual little-o

For an `o(g)` statement, a fixed bound by (C\lVert g\rVert) is insufficient.
The bridge needs a factor tending to zero or a direct proof that the explicit
majorant is little-o of the source scale. The proof records positivity and
nonvanishing conditions required by quotient arguments.

### Asymptotic equivalence

An additive inequality alone does not imply (f\sim a) near zeros of (a).
Recovery needs eventual nonvanishing or a quantitative lower bound for the
leading approximant, and an explicit relative-error factor tending to zero. If
Olver uses an additive rather than relative convention at a zero or transition,
the audit theorem follows that convention instead of forcing equivalence.

### Poincaré expansion

A family of finite inequalities becomes a Poincaré expansion only after proving
the remainder has the required relation to the next retained or omitted scale
at every fixed order. `HasErrorFamily` by itself supplies none of:

- an asymptotic scale;
- convergence of any normalized remainder;
- eventual domain membership;
- consistency between order conventions;
- a finite-sum representation of the approximants.

All of these are separate bridge obligations. A theorem valid only for orders
coupled to the large variable may be valuable quantitative mathematics without
implying the source's fixed-order expansion.

### Differentiated expansions

The source bridge may recover a differentiated expansion only from an explicit
quantitative derivative theorem or another valid derivative argument. It may
not differentiate a qualitative relation, a real-axis bound, or a formal
coefficient series without the necessary neighborhood control and regularity.
Spatial and parameter derivatives use separate bridge records.

### Uniform and sectorial statements

Every uniformity qualifier is part of the proposition. The bridge records the
parameter set, the filter, and whether constants and thresholds are uniform.
For a sectorial statement it also proves that the eventual path remains in the
correct branch chart. A theorem on every compact subset is not silently
promoted to a theorem on the full open set.

## Generation policy

“Generated from the finite theorem” has two deliberately different meanings.

1. **Generated catalogue data.** Once the occurrence, quantitative card,
   qualitative card, declarations, and review artifacts are registered, the
   website can generate cross-links, status badges, dependency diagrams, and a
   source-order contents view.
2. **Kernel-checked mathematical derivation.** The qualitative theorem is a
   checked proof from the finite producer and reviewed bridge lemmas. It is not
   generated by trusting metadata or copying the source prose.

Automation may create a draft bridge card listing the expected obligations:
eventual domain, scale comparison, notation equality, parameter uniformity, and
source proposition. It may not mark those obligations proved, manufacture a
filter, select a branch, or infer the source theorem class. The final theorem
and card receive ordinary source and mathematical review.

## Edition and source reconciliation

### Snapshot discipline

An edition is a bibliographic target; a snapshot is the exact object inspected.
The 2010 CRC preview has its own `olver_crc_2010_preview` edition row as well as
its own snapshot row. It is not assigned to `olver_1997b`. The pending 1997 copy
is a distinct locked-edition snapshot placeholder, not evidence of inspection.
The preview can generate preview-specific leads and provisional transcriptions,
but only an inspected, reproducibly identified copy assigned to the locked
edition can close a 1997 occurrence.

For each recovery packet, retain:

- edition and snapshot IDs;
- printed chapter, section, page, equation, theorem, example, or exercise
  labels;
- snapshot coordinates in the page-audit table, never substituted for printed
  labels without a verified map;
- a copyright-safe mathematical transcription and ordinary digest;
- collator and independent reviewer IDs;
- notation, entity, and occurrence associations;
- reconciliation status and notes on any discrepancy.

### Cross-edition comparison

Occurrences are edition-specific. If a 1974 printing, the 1997 corrected
reprint, and a later CRC reprint contain corresponding material, create
separate occurrence records and an explicit edition-relation record rather than
overwriting one locator. The canonical relation has independent
`content_equivalence_status` and `page_locator_equivalence_status` axes. Unless
both are `matched`, `join_semantics` is `non_equivalent`: consumers may not join
or transfer occurrence, notation, entity-confirmation, or coverage identity.
The current 2010-to-1997 row is unresolved on both axes and therefore expressly
non-equivalent.

Once concrete corresponding occurrences exist, a reviewed reconciliation may
classify their mathematical relationship more finely:

| Outcome | Meaning | Coverage effect |
|---|---|---|
| `verbatim_mathematics` | Mathematical statement and notation agree; only layout or pagination differs | A proved transport record may support navigation, but the locked occurrence is still independently identified |
| `equivalent_rewording` | Formal propositions are proved equivalent after explicit convention mapping | Separate occurrences, connected by an equivalence certificate |
| `corrected` | Later edition changes a hypothesis, constant, sign, formula, or exception | Separate targets; never merge silently |
| `mismatch` | Materially different results or normalizations | No transport of coverage |
| `unresolved` | Copies or evidence are insufficient | No reconciliation claim |

DLMF is a locator and convention cross-check. It may reveal a normalization
hazard or cite an Olver page, but it cannot supply a missing Olver transcription
or prove that two editions agree.

### Source errata

When the locked source appears false or incomplete, preserve three facts:

1. the exact printed proposition;
2. the diagnosed issue and reproducible counterexample or proof gap;
3. a corrected quantitative theorem, if one is proved.

Do not prove a repaired statement and label the printed occurrence recovered.
The catalogue marks the occurrence `source_issue` or `not_recovered`, links the
corrected theorem as a related result, and records whether an authoritative
erratum supports the change.

## Card and module organization

The audit tree should mirror source order without turning chapter order into a
semantic dependency chain. A suitable documentary layout is:

```text
LMLF/Audit/SourceRecovery/
  Basic                         shared quantitative-to-qualitative bridges
  Olver1997/Chapter01
  Olver1997/Chapter02
  ...
  Olver1997/Chapter14
  Olver1997                     edition-specific audit umbrella
  SourceRecovery               all source-recovery audits
```

Files are created only for carded occurrences; empty chapter shells are not
evidence of coverage. The edition umbrella is a build target and documentation
entry point, not a dependency of `LMLF.lean`.

Each source bridge has a stable `SR-*` card distinct from its quantitative
producer. A single quantitative theorem may support several source occurrences,
and one source occurrence may require several quantitative lemmas. These are
many-to-many associations, never encoded by inventing a combined status.

Minimum `SR-*` card fields are:

- occurrence and edition/snapshot IDs;
- copyright-safe exact mathematical transcription and hash;
- theorem, coverage, and novelty classifications;
- source-facing proposition and notation map;
- quantitative producer cards and declaration names;
- eventual-domain and scale-comparison declarations;
- branch, derivative, normalization, and exceptional-value reconciliation;
- proof/review/implementation/coverage status axes;
- mismatch and non-recovery tests;
- downstream catalogue and manifest associations.

## Coverage rule

An occurrence earns source-recovery credit only when all of the following hold:

1. the locked occurrence is resolved and independently collated;
2. its target function or generic data have the required identification;
3. the quantitative producer is implemented and audited, and is accepted for
   this same release or an earlier release;
4. the audit-only qualitative theorem is implemented and kernel checked;
5. the source statement follows with the same quantifiers, scale, domain,
   uniformity, branches, and exceptions;
6. source-fidelity and mathematical reviewers approve the frozen bridge;
7. the occurrence-card associations and closed release manifest validate;
8. generated documentation links the source, quantitative theorem,
   qualitative theorem, proof dossier, reviews, and release.

Until then the catalogue uses precise partial labels such as `located`,
`transcribed`, `quantitative theorem proved`, or `qualitative bridge pending`.
It must not display a single green “formalized” badge.

For the planned Watson MVP this means the path remains:

```text
OLV97-C03-WATSON collation
  -> QL-001 finite Laplace infrastructure
  -> OLV-001 exact-source quantitative theorem
  -> SR-001 exact qualitative source bridge
  -> occurrence reconciliation in OLV-MVP-1
```

The DLMF locator and a generic finite Laplace theorem alone do not complete any
of these later stages.

## Permanent anti-overclaiming tests

Every qualitative release audit checks at least these failure modes:

- a fixed-order estimate was advertised as an all-orders expansion;
- an order-dependent target was advertised as one fixed function;
- a pointwise theorem was advertised as uniform;
- a threshold depending on a parameter was advertised as uniform in that
  parameter;
- big-O was used where the source states little-o, equivalence, or a full
  expansion;
- an additive bound was turned into relative error at a zero;
- a differentiated qualitative statement lacked a quantitative derivative
  theorem;
- a source branch or exceptional case was dropped;
- a repaired theorem was described as recovery of a false printed theorem;
- a 2010 preview or DLMF page was described as a reconciled 1997 occurrence;
- a qualitative bridge was imported by a semantic module;
- a generated page inferred proof or coverage status from a filename.

These are release-blocking specification or source-fidelity failures, even when
all involved Lean files compile.
