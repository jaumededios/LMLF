# Gamma-related family programme

**Status:** planning only; no provisional ID below is registered or authorized  
**Current registered-card boundary:** `DEF-001` only, specifying four proposed thin wrappers around `Complex.Gamma`
**Potential source territory:** Chapter 2 §§1–2 and §5, the Chapter 4 incomplete-Gamma heading, and later occurrences found by the locked-edition audit

## Family boundary and source honesty

This wave covers Euler Gamma, reciprocal Gamma, Beta, psi/digamma and named polygamma derivatives, and upper/lower incomplete-Gamma variants. It does not include Stirling estimates, Watson's lemma, generic Laplace moments, or any source theorem merely because Gamma occurs in its proof. Those belong to separate method or application cards.

The current inventory supports only these limited statements:

- `gamma`, `reciprocal_gamma`, `beta`, `digamma`, `trigamma`, and `tetragamma` are evidenced by mathematical-body material in the **2010 publisher preview**; their occurrences remain `located_untranscribed`, their normalization remains unresolved, and reconciliation to the locked 1997 edition is pending.
- incomplete Gamma is currently only the contents lead `OLV10P-O0010`, spanning Chapter 2 §5 and a Chapter 4 heading. It is `occurrence_unresolved`; no particular upper, lower, normalized, or regularized member is yet a confirmed source entity.
- `DEF-001` identifies a reusable Mathlib Gamma object for project use and claims no Olver occurrence. It does not resolve any source-inventory row and does not authorize reciprocal Gamma, Beta, polygamma, or incomplete Gamma.

Any source-facing card waits for a locked-edition body occurrence. The definition work may proceed as `entity_identification` when independently motivated, but it must continue to claim no source-theorem coverage.

## Source and normalization questions

### Euler Gamma and reciprocal Gamma

1. Does the locked printing use the Euler integral only for positive real part, and which continuation statement follows it?
2. Which recurrence, product, or limit formula is used to characterize continuation? Record exact domains rather than transferring the 2010 preview locator.
3. Does the printed reciprocal Gamma mean the entire continuation of $1/\Gamma(z)$, and are its zeros at the nonpositive integers stated or used?
4. Are powers in the Euler integrand explicitly real-positive powers coerced to complex values, or expressed through a complex branch convention?
5. Which pole convention is needed in source recovery? Mathlib's total `Complex.Gamma` returns zero at nonpositive integers; that is an implementation convention at classical poles, not a finite classical Gamma value.
6. Do later occurrences use scaled Gamma, reciprocal Gamma, Gamma ratios, or logarithmic Gamma as separately named objects? A nontrivial scale or parameter conversion must not be collapsed into an alias.

### Beta

1. Record the printed symbol, argument order, initial integral domain, endpoint interpretation, and any symmetry convention.
2. Determine whether Beta is treated through its defining integral, the Gamma quotient, analytic continuation, or more than one of these.
3. At exceptional parameters, distinguish a genuine continuation/removable value from a totalized quotient involving zero-valued Gamma at a pole.
4. If the source uses incomplete Beta, create a distinct entity only after a body occurrence confirms it; it is not part of this wave merely by family association.

### Psi, digamma, trigamma, and tetragamma

1. Visually collate the exact psi glyph and the naming relation between psi and digamma.
2. Confirm whether the derivative is the spatial derivative of Gamma's logarithm, the quotient $\Gamma'/\Gamma$, a derivative of a chosen logarithm branch, or an equivalent formula on a pole-free domain.
3. Confirm the derivative variable and indexing convention for polygamma. In particular, determine whether trigamma/tetragamma are treated as separately named entities and whether any higher named orders occur.
4. Record pole sets, residues or recurrence normalizations if printed, and real agreement on the domain used later.
5. Determine whether the source uses a total function at poles, a meromorphic function on a punctured domain, or only formulas under explicit exclusions.

### Incomplete Gamma

1. Split upper and lower functions only after collating the printed integrals, integration paths, argument order, and endpoint conventions.
2. Determine which variants are normalized by $\Gamma(a)$, which are unnormalized, and whether a boldface or alternate glyph changes values.
3. Record the initial convergence domain in the parameter and the branch/cut in the complex argument.
4. Determine how continuation in the parameter or argument is characterized, including removable values and poles.
5. Check whether Chapter 4 reuses the Chapter 2 object, introduces a new normalization, or merely applies it. Repeated occurrences remain separate even when the entity is shared.
6. Record whether parameter derivatives, recurrence relations, or complementary identities are used downstream; none may be inferred from a modern reference without source collation.

## Construction versus reuse plan

| Object | Current reusable substrate | Planned decision | Required boundary |
|---|---|---|---|
| Euler Gamma | Pinned `Complex.Gamma`, its Euler-integral convergence/equality, real agreement, recurrence facts, and totalization facts | Keep the Mathlib object. Extend the public sheet only through new, bounded reuse cards. | Never create a second public Gamma. Every new wrapper must say whether it is global, pole-free, or right-half-plane only. |
| Reciprocal Gamma | Pointwise inverse of the reused Gamma is an obvious candidate; local Mathlib availability beyond the audited Gamma facts is not yet assessed | Audit Mathlib first. If using the pointwise inverse, prove its entire extension and zeros rather than relying on division totalization. Compare against a product/series construction only if it materially simplifies the proof. | One public object, with a characterization valid through Gamma's poles. A proof away from poles is insufficient. |
| Beta | Availability in the pinned tree has not yet been recorded | Search the pin for a canonical Beta object and exact integral/Gamma identities. Reuse if semantics match; otherwise choose one construction and prove both integral and Gamma-quotient identifications on their honest domains. | Do not define Beta merely by a totalized quotient and claim continuation at exceptional parameters. |
| Digamma/polygamma | No pinned availability decision is recorded | Audit before construction. A derivative of the reused Gamma on the pole-free domain is preferable if it supports continuation and real agreement. If a meromorphic/logarithmic-derivative construction is required, expose its domain and identification. | A selected complex logarithm branch is not globally available around Gamma's zeros/poles. Prefer the branch-free quotient where valid and prove equivalence carefully. |
| Lower incomplete Gamma | `Complex.partialGamma` is a finite integral to a real upper endpoint, not a complete classical family API | Determine whether it matches any collated source occurrence exactly. Reuse it as a construction ingredient or prove a bridge; do not rename it prematurely. | Endpoint type, argument order, and continuation must match. |
| Upper incomplete Gamma | No complete named API was found in the pinned audit | Construct from an honest improper integral on its convergence/cut domain or from a proved complement relation after the lower function is identified. | Integrability and path/branch semantics precede the value theorem. |
| Regularized variants | Regularized hypergeometric infrastructure may help some continuations, but no decision is recorded | Compare division-by-Gamma, series, and integral constructions after source variants are known. | A formula divided by Gamma is not a global continuation theorem at exceptional parameters. |

Construction files may depend on the individual Gamma definition file and low-level branch/integration support. They may not import the definitions umbrella, incomplete-Gamma asymptotics, Watson/Laplace results, or source-recovery audits. Generic moment identities live in the integral layer even if Gamma notation packages their values.

## Dependency graph

```text
locked-edition collation of Ch. 2 §§1-2, §5 and relevant later pages
             |                         |
             |                         +--> split upper/lower/regularized entities
             v
pin-specific reuse audit for Gamma, Beta, derivatives, partialGamma
             |
             +--> existing DEF-001 (four wrappers only)
             |
             +--> reciprocal Gamma construction/entire identification
             |         |
             |         +--> Beta and polygamma identities where genuinely needed
             |
             +--> incomplete-Gamma base integrals
                       |
                       +--> complement/recurrence identities
                       +--> continuation and exceptional parameters
                       +--> regularized variants
             |
             v
expanded definition audits and real-agreement checks
             |
             v
named integral, recurrence, large-parameter, and connection applications
```

The graph is not a mandate that Beta depend on reciprocal Gamma or that incomplete Gamma use a quotient construction. Final edges are chosen after the reuse audit and semantic split. It is a mandate that continuation and exceptional-value claims depend on the proofs that justify them.

## Required natural-language proof dossiers

### `NLP-GAM-RECIP-001` — reciprocal Gamma through the poles

The dossier must define the actual candidate, prove equality with $1/\Gamma$ on the pole-free domain, prove holomorphy/entireness at every nonpositive integer, establish the values there, and identify its zero set to the strength used downstream. It must name the local Gamma facts or product theorem supplying removability. An argument that Lean's inverse of zero is zero is explicitly rejected.

### `NLP-GAM-BETA-001` — Beta construction and identification

Give the exact integral and convergence domain, the actual construction, the Gamma-quotient theorem with all nonpole hypotheses, symmetry, analytic regularity required later, exceptional-parameter policy, and real agreement. If the actual object is reused, replace construction proof with an exact pinned-signature comparison. Include cases exposing parameter reversal and endpoint nonintegrability.

### `NLP-GAM-PSI-001` — digamma and named derivatives

Fix the pole-free domain, derivative variable, indexing, and actual definitions. Prove equivalence of the logarithmic derivative and quotient formulations on their common domain without assuming a global logarithm. Establish recurrence and real restriction only if included in the card. Treat trigamma and tetragamma as separately bounded targets rather than allowing “all derivatives” to expand scope.

### `NLP-IGAM-BASE-001` — lower and upper base-domain integrals

State parameters and arguments in frozen order; define paths, powers, cuts, endpoints, and initial convergence domains; prove integrability/improper convergence; identify the selected objects with the conventional integrals; and prove the complement identity only on a domain where both sides are established. Include zero argument, positive-real parameters, and an endpoint where the integral ceases to be valid.

### `NLP-IGAM-CONT-001` — continuation, recurrences, and regularization

Start from the accepted base-domain objects, construct or reuse continuation, prove overlap equality and uniqueness, classify poles/removable values, and establish regularized values independently of totalized division. Every recurrence states its own domain. Parameter and spatial regularity are separated. This is high-risk continuation work and requires the third structural/circularity review.

### `NLP-GAM-REAL-001` — real/complex agreement

For every public real object actually used later, prove pointwise agreement on a specified real domain and record what happens at classical poles or excluded endpoints. Derivative agreement must use a real neighborhood or an appropriately stated within-domain result; pointwise coercion equality alone is insufficient.

## Provisional theorem-card queue

These rows are not cards and are not members of any manifest.

| Provisional ID | Bounded target | Provisional packet theorem class | Packet coverage class | Principal prerequisites |
|---|---|---|---|---|
| `DEF-GAM-002` | One reciprocal-Gamma object; equality with the inverse off poles; entire continuation; values at nonpositive integers | `definition_identification` | `entity_identification` | Locked normalization audit for any source claim; `DEF-001`; `NLP-GAM-RECIP-001` |
| `DEF-GAM-003` | One Beta object; defining integral; Gamma relation on an explicit domain; symmetry and real agreement | `definition_identification` | `entity_identification` | Pin reuse audit; collated argument order; `NLP-GAM-BETA-001` |
| `DEF-GAM-004` | Digamma/psi object and its pole-free logarithmic-derivative identification | `definition_identification` | `entity_identification` | `DEF-001`; exact glyph/alias audit; `NLP-GAM-PSI-001` |
| `DEF-GAM-005` | Trigamma and tetragamma only, with frozen indexing and derivative identities | `definition_identification` | `entity_identification` | `DEF-GAM-004`; confirmed source entity split; bounded dossier revision |
| `DEF-IGAM-001` | Lower incomplete Gamma on its initial integral domain | `definition_identification` | `entity_identification` | Body collation; `partialGamma` compatibility audit; `NLP-IGAM-BASE-001` |
| `DEF-IGAM-002` | Upper incomplete Gamma on its initial improper-integral domain and complement theorem | `definition_identification` | `entity_identification` | `DEF-001`; `DEF-IGAM-001` if complement is used; `NLP-IGAM-BASE-001` |
| `DEF-IGAM-003` | Exactly the regularized variants confirmed by collation, with exceptional-parameter continuation | `definition_identification` | `entity_identification` | `DEF-IGAM-001/002`; `DEF-GAM-002`; `NLP-IGAM-CONT-001` |
| `AUD-GAM-001` | Expanded exact normalization, pole, argument-order, and complement regressions | `audit_regression` | `infrastructure` | The accepted public family declarations |

No “Gamma asymptotics” card is queued here. A future named source application receives its own occurrence-bound card only after the precise formula, approximant, order convention, domain, constants, and normalization have been transcribed.

## Acceptance gates

### Family identification gate

- `DEF-001` remains unchanged unless a reviewed replacement card explicitly widens it.
- The locked source occurrence and notation/entity links are resolved for every source claim; otherwise the card says only that it identifies a conventional project object.
- Each object has one actual public implementation and at least one recognizable identification theorem.
- Integral formulas have convergence/integrability theorems and honest endpoint semantics.
- Quotient formulas exclude poles unless a separate continuation theorem supplies the exceptional values.
- Pole sets and Lean totalized values are both documented without conflation.
- Named derivative indices and variables are fixed, and real/complex agreement is proved on the consumed domain.
- New construction and continuation dossiers have two mathematical approvals plus the required structural/circularity approval before authorization.
- Definition audits depend only on the public family API and are built separately.

### Named-application gate

- Every source occurrence is in a finite manifest and reconciled to the locked edition.
- The application imports the identified object rather than rebuilding its integral/series locally.
- Every generic moment, recurrence, contour, or ODE hypothesis is proved for the named object.
- Parameter exclusions, threshold, order dependence, branch, domain reachability, and majorant nonnegativity are explicit.
- Any qualitative printed conclusion is recovered in the audit layer from the finite theorem, not substituted for it.

## Negative and adversarial tests

1. **Pole totalization:** reject a theorem describing `Complex.Gamma (-n) = 0` as a classical finite Gamma value.
2. **Reciprocal at poles:** prove the accepted reciprocal object has its intended value through the pole by continuation, not merely because inverse zero is zero.
3. **Beta parameter order:** an expanded integral audit must fail if the two endpoint exponents are swapped.
4. **Beta quotient exceptional case:** test a parameter pair where a Gamma factor is at a pole; the unrestricted totalized quotient must not masquerade as the continued Beta value.
5. **Psi branch trap:** reject a global definition that requires one holomorphic logarithm of Gamma across its zeros or poles.
6. **Polygamma index:** distinguish the first derivative of psi from the first derivative of Gamma and test the trigamma/tetragamma naming convention.
7. **Incomplete-Gamma complement:** test both argument order and upper/lower orientation; a swap must change an expanded formula.
8. **Endpoint convergence:** ensure an integral theorem cannot be applied when the real-part hypothesis at zero is absent.
9. **Regularization:** at a denominator-Gamma pole, require a proved continued value rather than simplification through division by zero.
10. **Real derivatives:** reject a derivative-coercion theorem derived from pointwise real agreement at one point.

## Explicit unknowns and blockers

- No locked 1997 snapshot has been registered or reconciled for these occurrences.
- Exact printed pages, labels, formulas, glyphs, and parameter order are missing for the preview-seeded Chapter 2 entities.
- The incomplete-Gamma member split is unknown because its lead is contents-only.
- Pinned Mathlib availability for Beta, digamma/polygamma, and reciprocal-Gamma continuation has not been recorded in the present audit.
- It is undecided whether `Complex.partialGamma` matches a source lower incomplete-Gamma object or is only a useful internal finite-integral helper.
- Required parameter regularity for later source applications is unknown until those occurrences are collated.
- It is unknown which scaled Gamma ratios, logarithmic Gamma objects, or additional named derivatives appear elsewhere in the edition.
- No proposed card has exact signatures, a frozen dossier revision, independent approvals, or manifest membership.

These blockers do not prevent generic Laplace or integral infrastructure. They do prevent any claim that the unresolved named variants or their source normalizations have been formalized.

## Downstream asymptotic consumers

The following are prospective consumers, not current source-coverage claims:

- exact exponential moments in the finite Laplace core, with `DEF-001` used only if the selected proof benefits from Gamma notation;
- incomplete-Gamma finite tails and their large-argument/large-parameter bounds once the upper/lower objects are identified;
- Watson-type applications whose collated proof uses Gamma moments, while Watson itself remains an `exact_source_generic` theorem rather than a Gamma application;
- saddle and endpoint models involving incomplete Gamma or Gamma ratios;
- coefficient recurrences and connection constants for hypergeometric, Bessel, parabolic-cylinder, and Whittaker families;
- Euler–Maclaurin and zeta-related formulas using Gamma/psi factors;
- pole, zero, and connection estimates that require reciprocal Gamma's zeros or polygamma parameter derivatives.

Each consumer must cite the narrowest accepted definition file. A consumer needing only Euler Gamma must not wait for incomplete Gamma, and no unresolved family may block unrelated generic quantitative work.
