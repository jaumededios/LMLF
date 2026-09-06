# Proposed Stage 1: DLMF through Chapter 10

**Normative owner:** `jaumededios`  
**Document status:** proposed implementation plan under a user-authorized scope; not independently reviewed  
**Scope decision date:** 2026-09-06  
**Source snapshot proposed for audit:** NIST DLMF version 1.2.7, release date 2026-06-15  
**Discovery access date:** 2026-09-06; not an audit-wide retrieval date

This supplement records the new Stage 1 programme boundary at the level of
specific functions and source assertions. It does not declare an executable
manifest, certify a source audit, authorize Lean work, or report implementation
readiness.

## 1. Effect of this supplement

The user-authorized Stage 1 programme is now:

- the mathematical content of DLMF Chapters 4--10, including mathematical
  assertions made in prose; and
- only the deliberately selected exact-mathematics infrastructure from DLMF
  Chapters 1--3, plus finitely identified support dependencies needed by the
  Chapter 4--10 consumers.

This boundary supersedes the old roadmap's **programme priority** that made the
locked Olver (1997) track the first source-coverage programme. It does not
rewrite, weaken, merge, or silently supersede the semantics of any frozen
Olver, BOOTSTRAP-0, IMPROPER-0, QL, OLV, inventory, transcription, proof,
review, or implementation artifact. In particular:

- `SRC-OLV-*`, `OLV97-*`, and their edition relations remain evidence only for
  the locked corrected 1997 Olver track;
- DLMF occurrences earn only DLMF coverage, and Olver occurrences earn only
  locked-Olver coverage;
- a mathematical theorem may be shared after an explicit semantic mapping,
  but a proof of one source occurrence never silently credits the other; and
- the accepted BOOTSTRAP-0 implementation and every frozen IMP/Olver byte and
  external record remain unchanged and retain exactly their existing status.

The broad programme boundary is authorized. It is **not** a closed executable
manifest: no finite denominator exists until the section, equation, table,
caption, and prose audit has produced reviewed occurrence cards. Executable
work must still be selected into finite closed manifests under
[`source_manifest.md`](source_manifest.md).

## 2. Exact-mathematics boundary

LMLF remains an exact Lean/mathlib library. Stage 1 may define exact functions
and prove exact identities, inequalities, convergence statements, finite
approximations, explicit remainders, asymptotic statements with their precise
meaning, qualitative properties, and the exact mathematics supporting them.

Stage 1 does not implement floating-point evaluation, arbitrary-precision
evaluation, interval arithmetic, tolerance selection, adaptive truncation,
quadrature procedures, root-finding procedures, recurrence-evaluation
strategies, performance models, or a software catalogue. A future verified
numerical library is a design consideration: definitions and theorems should
not needlessly prevent such a consumer, but that future library imposes no
current numerical API and supplies no present acceptance criterion.

This distinction applies especially to DLMF Chapter 3 and to the “Computation”
sections of Chapters 4--10:

- exact identities, hypotheses, convergence claims, stability claims, error
  bounds, and other mathematical assertions are eligible source occurrences;
- a description of an algorithm or software package is not itself an LMLF
  implementation target; and
- any mathematical assertion embedded in algorithmic prose is extracted and
  audited independently of the algorithm that motivated it.

### 2.1 Quantitative-first asymptotic architecture

Every asymptotic or approximation occurrence has two separately visible
deliverables:

1. a semantic exact-mathematics result with the target function, finite
   approximant, remainder or error majorant, domain, truncation order,
   thresholds, constants, branches, exceptional values, and parameter
   dependence explicit; and
2. a faithful bridge recovering the DLMF statement's exact qualitative or
   asymptotic meaning from that quantitative result.

The bridge belongs in the consumer-only `Audit/SourceRecovery` layer when the
source statement uses filters, Landau notation, or another qualitative
asymptotic form. That layer may import the finite quantitative theorem; semantic
definition and result modules never import it backwards. A proof only of the
printed `O`, `o`, `~`, or qualitative approximation statement cannot be counted
as the completed quantitative deliverable.

When DLMF does not supply the needed explicit bound, producing one is new
mathematics: its proof and review status remains honestly pending until it
passes the ordinary proof-before-Lean gates. The missing estimate may not be
moved into an opaque majorant, hypothesis structure, or assumed remainder and
then reported as completed. This is exact quantitative mathematics, not a
numerical evaluation algorithm.

Genuinely structural qualitative properties--for example analyticity,
continuation, monotonicity, sign, uniqueness, or zero structure--remain
ordinary semantic targets. They are not artificially converted into remainder
bounds merely because quantitative-first treatment applies to asymptotic and
approximation occurrences.

## 3. Source lock and provenance

The provisional audit target is the official [DLMF root](https://dlmf.nist.gov/),
which displayed **Version 1.2.7; Release date 2026-06-15** when accessed on
the 2026-09-06 discovery pass. The official
[project news](https://dlmf.nist.gov/about/news/) and
[versioned errata record](https://dlmf.nist.gov/errata/) independently identify
that release. The chapter landing pages used to verify the scope map are:

- [Chapter 1](https://dlmf.nist.gov/1), [Chapter 2](https://dlmf.nist.gov/2),
  and [Chapter 3](https://dlmf.nist.gov/3);
- [Chapter 4](https://dlmf.nist.gov/4), [Chapter 5](https://dlmf.nist.gov/5),
  [Chapter 6](https://dlmf.nist.gov/6), and [Chapter 7](https://dlmf.nist.gov/7);
  and
- [Chapter 8](https://dlmf.nist.gov/8), [Chapter 9](https://dlmf.nist.gov/9),
  and [Chapter 10](https://dlmf.nist.gov/10).

Before the audit becomes authoritative, a reviewed source-snapshot record must
bind at least a unique snapshot ID, DLMF version, release date, canonical URL
set, retrieval method, and a per-page actual retrieval date, content digest,
and retrieval/version evidence. Audit retrievals may occur after 2026-09-06 and
may span multiple dates; the discovery access date does not claim that those
future page bytes were inspected or frozen. A root-page version label alone is
not a digest or a per-page snapshot.

Because the website can change, a later DLMF release requires an explicit new
snapshot and versioned schema/data migration. An audit may not silently mix
changed page content into the provisional 1.2.7 target. Corrections are carried
forward through explicit occurrence lineage (`unchanged`, `modified`, `split`,
`merged`, `added`, or `removed`), not by mutating old audit truth.

Different renderings of the same page (HTML/MathML, TeX encodings, and image
fallbacks) are representations of one source occurrence unless an audit finds
a substantive mismatch. Such a mismatch is recorded and resolved rather than
silently choosing a rendering.

Store locators, audit metadata, hashes where lawful and useful, short source
fragments only when necessary, and independently written mathematical
paraphrases. Do not mirror the website, bulk-copy its prose, figures, or tables,
or treat a visualization as the source. Follow the official
[NIST copyright and permissions notice](https://www.nist.gov/copyrights-disclaimers).

## 4. Chapter map

The following map fixes the Stage 1 boundary without claiming that the listed
examples exhaust the eventual occurrence or entity inventory.

| Chapter | Official title | Stage 1 treatment | Mandatory family/subject sentinels |
|---|---|---|---|
| 1 | [Algebraic and Analytic Methods](https://dlmf.nist.gov/1) | Selective supporting infrastructure. Admit only exact statements used by a Chapter 4--10 card or a finite foundation packet whose planned Chapter 4--10 consumers are named. | notation; algebra; inequalities; real and complex calculus; series and products; continued fractions; differential equations; transforms; distributions; spectral/eigenfunction material when a selected consumer requires it |
| 2 | [Asymptotic Approximations](https://dlmf.nist.gov/2) | Selective method infrastructure. Create exact-source cards only for methods actually consumed by Chapter 4--10 cards or for a finite method packet whose planned Chapter 4--10 consumers are named. | asymptotic definitions; real and contour integrals; Mellin methods; differential/difference equations with parameters; sums; explicit remainders and Stokes phenomena |
| 3 | [Numerical Methods](https://dlmf.nist.gov/3) | No blanket algorithm programme. Extract only exact mathematical assertions needed by selected consumers; keep numerical procedures and executable evaluators out of LMLF. | error measures, conditioning/stability assertions, interpolation or approximation identities, convergence and error bounds, continued-fraction facts, exact mathematical constants |
| 4 | [Elementary Functions](https://dlmf.nist.gov/4) | Exhaustive mathematical-assertion audit of §§4.1--4.47; §4.48 software entries are metadata-only, except that any mathematical claim in their surrounding prose is extracted. | logarithm, exponential, powers, generalized logarithms/exponentials, **[Lambert W](https://dlmf.nist.gov/4.13)**, trigonometric/inverse trigonometric, hyperbolic/inverse hyperbolic functions, application identities and exact computation/approximation claims |
| 5 | [Gamma Function](https://dlmf.nist.gov/5) | Exhaustive mathematical-assertion audit of §§5.1--5.23; §5.24 software entries are metadata-only under the same extraction rule. | Gamma and reciprocal Gamma, beta, multidimensional integrals, polygamma, **[Barnes G/double Gamma](https://dlmf.nist.gov/5.17)** and every multiple-Gamma relation actually asserted, **[q-factorials, q-Gamma, and q-Beta](https://dlmf.nist.gov/5.18)**, applications and exact computation/approximation claims |
| 6 | [Exponential, Logarithmic, Sine, and Cosine Integrals](https://dlmf.nist.gov/6) | Exhaustive mathematical-assertion audit of §§6.1--6.20; §6.21 software entries are metadata-only under the same extraction rule. | exponential and logarithmic integrals, sine and cosine integrals, hyperbolic variants and chapter-defined auxiliaries, branches and continuation, zeros, applications and exact computation/approximation claims |
| 7 | [Error Functions, Dawson's and Fresnel Integrals](https://dlmf.nist.gov/7) | Exhaustive mathematical-assertion audit of §§7.1--7.24; §7.25 software entries are metadata-only under the same extraction rule. | erf/erfc and complex relatives, Dawson and Fresnel integrals, generalized and inverse error functions, repeated erfc integrals, Voigt functions, zeros, applications and exact computation/approximation claims |
| 8 | [Incomplete Gamma and Related Functions](https://dlmf.nist.gov/8) | Exhaustive mathematical-assertion audit of §§8.1--8.27; §8.28 software entries are metadata-only under the same extraction rule. | lower/upper and normalized incomplete gamma functions and **[their generalizations](https://dlmf.nist.gov/8.16)**; **[incomplete beta](https://dlmf.nist.gov/8.17)**; **[generalized exponential integral](https://dlmf.nist.gov/8.19)**; **[generalized sine/cosine integrals](https://dlmf.nist.gov/8.21)**; uniform expansions, zeros, applications and exact computation/approximation claims |
| 9 | [Airy and Related Functions](https://dlmf.nist.gov/9) | Exhaustive mathematical-assertion audit of §§9.1--9.19; §9.20 software entries are metadata-only under the same extraction rule. | Ai, Bi, derivatives, modulus/phase and zeros, **[Scorer functions](https://dlmf.nist.gov/9.12)**, generalized Airy functions, incomplete Airy functions, applications and exact computation/approximation claims |
| 10 | [Bessel Functions](https://dlmf.nist.gov/10) | Exhaustive mathematical-assertion audit of §§10.1--10.76; §10.77 software entries are metadata-only under the same extraction rule. | Bessel J/Y and Hankel functions; modified Bessel I/K; order derivatives and imaginary-order variants; **[§10.46](https://dlmf.nist.gov/10.46)** with its explicit generalized-Bessel/Mittag--Leffler content and separately classified incomplete-function reference lead; **[spherical Bessel functions](https://dlmf.nist.gov/10.47)**; **[Kelvin functions](https://dlmf.nist.gov/10.61)**; connection, zero, modulus/phase, application, and exact computation/approximation claims |

The bold entries are omission sentinels. An audit that merely expands generic
landing-page labels such as “Elementary Functions,” “Airy and Related
Functions,” or “Bessel Functions” and misses any of them is incomplete. The
same principle applies to every further named function, normalization,
auxiliary, coefficient family, and named limiting object discovered during the
body audit.

### 4.1 Function-level seed map

The official special-notation pages and the hidden-family sections give the
following minimum entity leads. This is a discovery checklist, not an allocated
entity inventory and not a claim that no other functions occur.

| Chapter | Specific functions or value-changing normalizations that must be investigated |
|---|---|
| 4 | `ln`, multivalued `Ln`, `exp`, complex powers; `sin`, `cos`, `tan`, `csc`, `sec`, `cot` and their principal/general inverses; `sinh`, `cosh`, `tanh`, `csch`, `sech`, `coth` and their principal/general inverses; the generalized logarithms/exponentials of [§4.12](https://dlmf.nist.gov/4.12); every branch `W_k` of Lambert W in [§4.13](https://dlmf.nist.gov/4.13) |
| 5 | `Gamma`, reciprocal Gamma, `psi`/digamma and the polygamma derivatives; beta `B`; Barnes `G`/double Gamma and Glaisher's constant from [§5.17](https://dlmf.nist.gov/5.17); q-shifted factorials, q-factorials, `Gamma_q`, q-digamma when mathematically asserted, and `B_q` from [§5.18](https://dlmf.nist.gov/5.18) |
| 6 | `Ei`, `E_1`, `Ein`, logarithmic integral `li`, `Si`, `si`, `Ci`, `Cin`, and every hyperbolic or auxiliary function defined or used in the chapter; see the official [§6.1 notation page](https://dlmf.nist.gov/6.1) |
| 7 | `erf`, `erfc`, `w` (the complex complementary/Faddeeva function), Dawson `F`; Fresnel script-F, `C`, and `S`; Goodwin--Staton `G`; repeated erfc integrals; Voigt `U` and `V`; the value-changing probability and scaled alternatives and the generalized/inverse families in §§7.16--7.19; see [§7.1](https://dlmf.nist.gov/7.1) |
| 8 | `gamma(a,z)`, `Gamma(a,z)`, `gamma*(a,z)`, `P(a,z)`, `Q(a,z)`; incomplete beta `B_x(a,b)` and `I_x(a,b)`; generalized exponential integral `E_p(z)`; generalized `si(a,z)`, `ci(a,z)`, `Si(a,z)`, and `Ci(a,z)`; Prym and incomplete-factorial alternatives only after alias/normalization review; see [§8.1](https://dlmf.nist.gov/8.1) |
| 9 | `Ai`, `Bi`, their derivatives and distinct modulus/phase auxiliaries; Scorer `Gi` and `Hi`; generalized Airy `A_n`, `B_n`, `U_m`, `V_m` and other functions actually defined in [§9.13](https://dlmf.nist.gov/9.13); the internal-cross-reference definition of incomplete Airy functions and the distinct external-reference leads in [§9.14](https://dlmf.nist.gov/9.14); every value-changing alternate normalization; see [§9.1](https://dlmf.nist.gov/9.1) |
| 10 | `J_nu`, `Y_nu`, `H_nu^(1)`, `H_nu^(2)`, `I_nu`, `K_nu`; their imaginary-order forms and order derivatives; generalized Bessel `phi(rho,beta;z)` and Mittag--Leffler `E_(a,b)(z)` explicitly defined in [§10.46](https://dlmf.nist.gov/10.46), with incomplete modified Bessel/Hankel retained separately as that section's reference lead; spherical `j_n`, `y_n`, `h_n^(1)`, `h_n^(2)`; modified spherical `i_n^(1)`, `i_n^(2)`, `k_n`; Kelvin `ber_nu`, `bei_nu`, `ker_nu`, `kei_nu` and separately named modulus/phase auxiliaries; see [§10.1](https://dlmf.nist.gov/10.1) |

Aliases are listed here to force investigation, not to prejudge identity. For
example, scaled error/probability functions, branch-indexed Lambert W values,
and alternate cylinder-function normalizations require the value/argument and
domain tests in the entity protocol before they may share a canonical entity.

## 5. What constitutes a source occurrence

For Chapters 4--10, the audit universe is every chapter and section landing
page and every subsection in the ranges above. An occurrence is an atomic
mathematical assertion in any of these locations:

- a numbered or unnumbered displayed formula, inline formula, definition,
  limiting relation, domain restriction, or exceptional-value convention;
- prose that asserts existence, uniqueness, analyticity, continuation,
  monotonicity, convexity, sign, reality, symmetry, a branch choice, a zero
  property, convergence, an approximation regime, an error estimate, or any
  other mathematical fact, including assertions whose quantifiers or
  hypotheses are implicit in nearby prose;
- a table entry, table heading, caption, figure caption, or application passage
  that makes a mathematical claim; and
- exact mathematics stated in a methods-of-computation, tables, or
  approximations section.

One displayed formula can yield multiple occurrences if it makes logically
separable claims with different domains or dependencies. Conversely, one
theorem card may implement several occurrences only when it enumerates the
mapping and proves every occurrence-local specialization. Repeated source
appearances remain separate occurrence rows even when one Lean theorem
discharges all of them.

The following are source records but not theorem targets merely by existing:

- bibliography entries, citations, historical attributions, author metadata,
  acknowledgements, and lists of references;
- software catalogue entries, package names, links, and implementation
  availability claims; and
- visual media as media objects, graphical styling, or sampled pixels.

Their locator/provenance records remain available to explain the audit. If a
bibliographic note, software paragraph, table, caption, or visual annotation
also asserts mathematics, extract that assertion into its own occurrence. A
plot itself is neither a proof nor a formal theorem; a caption's mathematical
claim is a proof obligation, and numerical samples may serve only as
non-authoritative regression evidence.

Chapter indices, notation lists, search results, and landing-page contents are
discovery aids. They cannot establish exhaustive body coverage or replace the
prose audit.

### 5.1 Formula, prose-claim, and reference-lead fidelity

A heading or TOC entry is not by itself a theorem denominator. The body audit
must distinguish at least these roles without collapsing them:

- `explicit_mathematical_assertion`: the website supplies a definition,
  formula, or sufficiently definite prose proposition;
- `internal_cross_reference_assertion`: the website makes a definition or
  assertion by pointing to another DLMF occurrence; both locators and the exact
  specialization are required;
- `underspecified_mathematical_claim`: the prose asserts mathematics but does
  not state enough detail for a faithful theorem card; the occurrence remains
  unresolved/blocked rather than being generalized or guessed; and
- `mathematical_reference_lead`: the website reports that an external source
  contains results on a named topic or regime but does not reproduce those
  results. Record the named function/topic, every domain or limiting qualifier
  actually printed, citation, and reference-only role. Do not invent a theorem
  or silently import the cited paper.

For example, [§10.46](https://dlmf.nist.gov/10.46) explicitly defines the
generalized Bessel function `phi(rho,beta;z)` and Mittag--Leffler
`E_(a,b)(z)`. Its prose statement that a Laplace transform can be expressed in
terms of the latter is a substantive mathematical claim and must not disappear,
but its exact formal target remains unresolved until source-faithful review
supplies the missing statement. The final sentence about incomplete modified
Bessel and Hankel functions is a reference lead, not an explicit DLMF formula
and not permission to import all results of the cited paper. Apply the same
distinction to generalized/incomplete Airy passages and every “for results in
this regime, see ...” sentence.

These roles are proposed audit-schema values, not current authoritative
inventory vocabulary. A reviewed migration may rename them while preserving
the distinctions. The first two roles create theorem occurrences. An
underspecified claim creates a provisional unresolved occurrence and blocks
closure until review either recovers a precise, source-faithful proposition or
classifies it as a reference lead. A reference lead remains an audit/provenance
record and does not require a theorem card merely for naming literature.
Consulting a cited source may create a separately bounded support-source card;
it never expands Stage 1 to the rest of that paper.

## 6. Audit protocol

### 6.1 Page and content-unit census

1. Freeze a canonical URL inventory for the proposed DLMF 1.2.7 snapshot. Give
   every chapter, section, subsection, equation block, prose block, table,
   caption, figure, application block, computation block, software block, and
   reference block a content-unit record.
2. Record for every content unit exactly one disposition: `mathematical`,
   `mixed`, or `nonmathematical`, plus a reviewable reason. `Mixed` units must
   yield both occurrence rows and non-theorem metadata rows. Every mathematical
   portion also receives one of the fidelity roles in §5.1.
3. Perform a forward body pass and a second reverse/checklist pass. Reconcile
   the equation list, notation list, list of figures, list of tables, and all
   subsection headings against the census. These aids detect omissions but do
   not supply coverage themselves.
4. Have a source/semantics reviewer independently check the completed census
   and every `nonmathematical` disposition. Zero uncensused or unclassified
   units is required before a chapter audit can be called complete.

### 6.2 Occurrence extraction

For each `mathematical` or `mixed` unit:

1. split the content into atomic assertions without losing nearby hypotheses;
2. paraphrase the statement, recording explicit binders, domain, branches,
   orientation, normalization, exceptional values, limiting mode, and whether
   the source wording is definition, equality, implication, approximation,
   asymptotic relation, or qualitative claim;
3. assign occurrence-local notation and entity associations; and
4. record cross-references, cited dependencies, duplicate occurrences, and any
   ambiguity. Ambiguous rows stay unresolved; they are never promoted by a
   plausible reconstruction.

Prose receives the same scrutiny as formulas. In particular, phrases such as
“is entire,” “has one zero,” “is positive,” “uniformly,” “for large order,” or
“the expansion can be differentiated” require their own quantified cards or an
explicit mapping to a card that proves the full assertion.

### 6.3 Entity and notation reconciliation

Each named object has a canonical entity record containing its conventional
specification, aliases, argument order, parameter roles, normalization,
branches, singularities/totalization, real/complex agreement, intended Lean
object, and an identification theorem or unresolved identification obligation.
Value-changing normalizations are separate entities; mere printed aliases may
share an entity only after review.

Each glyph occurrence has a notation record. The same glyph in two local
contexts is not presumed identical, and a modern DLMF name is not silently
assigned to an expression in the Olver track. Cross-source entity equivalence
uses an explicit reviewed mapping record and never transfers occurrence
coverage.

### 6.4 Cards, proofs, and manifests

Every in-scope Chapter 4--10 occurrence must eventually map to at least one
bounded card. A card states exact imports, public declarations, source
occurrences, dependencies, proof artifact, classifications, and all
orthogonal statuses. Infrastructure cards from Chapters 1--3 or from pinned
mathlib earn no Chapter 4--10 coverage unless they separately implement and
reconcile a selected Chapter 4--10 occurrence.

For each asymptotic/approximation occurrence, the card graph separately names
the finite quantitative card and the faithful source-recovery card required by
§2.1, with the recovery card downstream of the quantitative result. If the
source already prints an explicit remainder, that exact occurrence remains the
quantitative target; otherwise the added finite bound is independently reviewed
new mathematics and the printed qualitative statement remains the recovery
target.

Only finite reviewed batches of cards enter executable manifests. A chapter or
section wildcard is forbidden. Source audit completion, card specification,
natural-language proof completion, review approval, Lean authorization,
implementation, and coverage reconciliation remain independent facts.

Genuinely new mathematics follows the existing proof-before-Lean gate: a
complete natural-language proof precedes exact signature design and Lean work,
and at least two fresh independent reviews are required, one for
source/semantics and one independently re-deriving the proof and its domains,
constants, and edge cases. Construction, continuation, identification through
existence/uniqueness, nontrivial source recovery, zeros, connections,
turning-point work, and theorem-sized hypothesis packets also require a
separately represented structural-circularity review. Any material change
invalidates the affected approvals.

## 7. Stable identities and orthogonal state

The future machine schema must allocate opaque, never-reused identifiers in
separate namespaces, for example:

- source snapshots: `SRC-DLMF-WEB-1.2.7-20260615`;
- immutable snapshot-local occurrences: `DLMF127-O-000001`;
- canonical mathematical entities: `DLMF-E-000001`;
- occurrence-local notation: `DLMF127-N-000001`; and
- theorem cards: `DLMF-CARD-000001`.

The example serials are illustrative and allocate no actual IDs. Human-readable
slugs and current locators may change; primary IDs do not. Successor snapshots
link occurrences through explicit lineage instead of recycling IDs. Crosswalks
to `OLV97-*`, Mathlib declarations, or later source tracks are separate records.

No single `status` field is permitted. At minimum the presentation and machine
records expose separately:

- source/audit state, including census disposition, transcription and semantic
  reconciliation, snapshot review, and unresolved ambiguity;
- `specification_status` and `proof_status`;
- `review_status`, with external envelope identity rather than candidate
  self-certification;
- `implementation_status` and `prototype_status`;
- `coverage_status`; and
- manifest membership and manifest state.

Existing controlled vocabularies in
[`theorem_cards/README.md`](theorem_cards/README.md) remain authoritative where
they apply. Any additional source-audit vocabulary requires a versioned schema
decision and migration. The existing `inventory-v1.0.0` CSVs remain the
Olver-focused machine authority; this proposal neither writes ad hoc DLMF rows
into them nor creates an unofficial competing coverage authority. DLMF source
coverage begins only after a reviewed schema migration establishes the
multi-track authority and preserves all frozen Olver identities and semantics.

## 8. Dependencies outside the boundary

A Chapter 4--10 source assertion may invoke a function conventionally treated
in Chapter 11 or later, cite a later result, or require a fact not yet present
in mathlib. The exact function identification or result required creates an
explicit support dependency with its own source locator, exact statement,
reason, consumer list, and status. It does **not** put the rest of the later
chapter into Stage 1 and does not earn coverage for that chapter.

Every support dependency must be discharged by one of:

1. transparent reuse of a pinned mathlib theorem, with an exact declaration and
   semantic audit;
2. a bounded source-independent infrastructure card;
3. a bounded out-of-range source-support card explicitly marked as support,
   not target-chapter coverage; or
4. an honest blocked status.

This rule also prevents dependency laundering: a difficult normalization,
existence, continuation, contour, or estimate cannot be hidden in an assumed
record or other opaque target-shaped hypothesis and then counted as a completed
DLMF occurrence.

## 9. Stage 1 acceptance criteria

No current count or percentage is asserted. Quantitative totals become valid
only after the audited census exists and all totals are derived from its rows.
Stage 1 is complete only when all the following are evidenced.

### Quantitative closure

- One reviewed source-audit manifest binds the selected DLMF version and release
  identity and enumerates the complete canonical URL census. Each retrieved
  page has its own actual retrieval date, content digest, and version evidence;
  the 2026-09-06 discovery date is not reused as an audit-wide access date. If
  the source changes during the audit, the manifest records a new snapshot and
  explicit versioned migration rather than silently mixing bytes.
- For Chapters 4--10, the number of uncensused content units is zero; the number
  of units without a reviewed disposition is zero; and the number of unresolved
  mathematical or mixed units is zero.
- Every extracted mathematical assertion, including every prose assertion,
  has exactly one immutable occurrence row; repeat appearances are retained;
  every row has a reviewed source locator and snapshot binding.
- Every mathematical reference lead and underspecified claim has a reviewed
  fidelity role and exact printed qualifiers. No reference lead is promoted to
  a theorem, and no underspecified claim is counted complete, by importing or
  inventing unstated content.
- Every Chapter 4--10 occurrence has an explicit, reviewed disposition for
  notation and entity applicability and is associated with one or more bounded
  theorem cards; all applicable associations are confirmed, and the numbers of
  unresolved dispositions and orphan occurrences, notation records, entities,
  and cards are zero.
- Every card is selected into some finite closed manifest. The union of
  deduplicated occurrence IDs declared by those manifests, partitioned by the
  declared coverage roles, reconciles exactly with the audited target-occurrence
  set and contains no wildcard membership. Association-row counts are never
  used as source totals: one card may cover several occurrences and several
  cards may discharge different obligations for one occurrence.
- Every required support dependency, including every cross-reference beyond
  Chapter 10, has exactly one explicit disposition and zero silent dependencies
  remain.
- All required natural-language proof, source/semantics review,
  proof/quantitative review, structural-circularity review, signature review,
  implementation review, and external-envelope gates are present for the exact
  artifact bytes to which they apply; no candidate-owned status is counted as a
  reviewer.
- Every selected public declaration compiles under the pinned Lean/mathlib
  versions, and the declaration/occurrence reconciliation reports zero missing
  targets, zero extra coverage claims, and zero unresolved branch,
  normalization, domain, exception, or binder-order mismatches.
- Every asymptotic/approximation occurrence has both its explicit finite
  quantitative deliverable and its downstream faithful source-recovery bridge.
  No qualitative-only or implicit-Landau proof is counted as completing the
  quantitative member of the pair.

### Qualitative correctness

- The mathematical meaning of every source occurrence is preserved, including
  implicit prose hypotheses, domains, branches, uniformity, limiting modes,
  normalizations, and exceptional cases.
- Each named function is the accepted identified implementation; definitions
  do not depend circularly on later asymptotic or qualitative results.
- Named estimates discharge their generic hypotheses and prove advertised
  domain reachability/nonemptiness and majorant nonnegativity. Choice and
  hypothesis laundering are absent.
- Exact natural constants, thresholds, domains, and residual identities are
  retained before convenience corollaries; totalized Lean operations are not
  used to assert classically invalid pole, cut, or integrability cases.
- Every omission sentinel and additional named lead discovered by the audit has
  a reviewed fidelity-role disposition. Every substantive mathematical
  assertion has full occurrence/entity/card coverage; a pure citation or
  reference lead remains recorded without theorem credit. Independent source
  review confirms that no substantive mathematics was evaded by relabeling it
  as a reference-only lead.
- Chapters 1--3 contain only reviewed, consumer-justified exact infrastructure;
  no report claims that all Chapter 3 numerical algorithms were implemented.
- Bibliographic, software, and visual-media records are not advertised as
  proved theorems; every mathematical claim embedded in them is nevertheless
  extracted and handled.
- DLMF and locked-Olver coverage remain distinct in reports and user-facing
  navigation. Shared mathematics is credited to each source only through its
  own reconciled occurrence mapping.
- No numerical evaluator or algorithmic API has entered the LMLF package.

Passing a validator, building Lean, or rendering documentation establishes
only the fact tested. None alone establishes source completeness,
mathematical review, implementation authorization, or Stage 1 completion.

## 10. Bounded next steps

These steps prepare execution without pretending that the programme boundary
is already a manifest:

1. Obtain independent scope review of this exact supplement and record any
   amendment as a new reviewed decision; do not modify frozen Olver artifacts.
2. Propose for review a versioned multi-track schema migration and source-track
   crosswalk that reuses the existing orthogonal card vocabulary, preserves
   `inventory-v1.0.0` as frozen Olver-focused input, and names the future
   machine authority explicitly.
3. Create the provisional DLMF 1.2.7 source-audit manifest and a **Chapter 4
   URL/content-unit census only** as the first bounded audit packet, recording
   each page's actual retrieval date, digest, and version evidence. If the site
   has changed, create the required successor snapshot/migration rather than
   assigning new bytes to 1.2.7. Report derived counts only after independent
   census review.
4. Use [§4.13 Lambert W](https://dlmf.nist.gov/4.13) as an omission-sensitive
   pilot for prose extraction, branch/notation reconciliation, and
   occurrence-to-card mapping. The pilot earns no chapter-completeness claim.
5. After that audit packet is approved, select a small finite first
   implementation manifest based on dependency closure and existing mathlib
   reuse. Apply the full proof-before-Lean and external authorization gates.
6. Extend the audit in finite reviewed chapter/section packets, preserving
   explicit support-dependency edges and publishing only derived denominators.

## 11. Verso/read-only presentation handoff

A preliminary Verso view may read the future snapshot, content-unit,
occurrence, notation, entity, card, dependency, review-envelope, and manifest
records. It should expose filters by chapter/section/function and show all
status axes independently, source provenance prominently, unresolved items
without optimistic defaults, and separate DLMF versus Olver coverage.

The view is a read-only projection. It must use stable IDs for links, label
counts as provisional until their audit is reviewed, avoid readiness percentages
that combine unlike axes, and never become mathematical, source, review, or
authorization authority. A discrepancy between Verso and the underlying
versioned records is a presentation defect, not a reason to change mathematical
truth.

## 12. Present truth

As of this proposal, the only newly established fact is the user-authorized
programme boundary described in §§1--2. The official DLMF pages were consulted
to verify version, chapter titles, section ranges, and omission sentinels. No
DLMF Chapter 4--10 page census, occurrence total, source reconciliation,
theorem-card set, proof set, review quorum, closed manifest, Lean authorization,
implementation, or coverage percentage is claimed. This document itself has
not received independent review.
