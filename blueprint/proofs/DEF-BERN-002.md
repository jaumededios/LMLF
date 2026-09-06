---
schema_version: nl-proof-v1
artifact_id: NLP-BERN-002-R1
work_item_id: DEF-BERN-002
title: Identification of Olver's periodic Bernoulli polynomial with pinned Mathlib
owner: jaumededios
revision: 1
artifact_state: draft
proof_status: complete

theorem_card_bindings:
  - card_id: DEF-BERN-002
    card_revision: 1
    signature_artifact_id: not_applicable-no-project-declarations

target_bindings:
  - target_id: DEF-BERN-002-T01
    declaration: _root_.periodizedBernoulli
    proof_section: target-def-bern-002-t01
    theorem_class: identification
    coverage_class: source_prerequisite
    novelty_class: source_equivalent

source_bindings:
  occurrences:
    - OLV97-C08-EULER-MACLAURIN
  entities:
    - periodic_bernoulli_functions
  notations:
    - OLV97-N-EM-OMEGA
  snapshots:
    - SRC-OLV-1997-USER-PDF-20260905
  snapshot_digests:
    - snapshot_id: SRC-OLV-1997-USER-PDF-20260905
      algorithm: sha256
      value: 08e1844d29a5ad21f89b9b600249ce18ac1665a5845be2d4e4219a3ededdc909
  transcription:
    path: blueprint/source_transcriptions/OLV97-C08-EULER-MACLAURIN.md
    sha256: f0d1113204c984096f04af658037aed6ddb9012fbcca5fb6dfdfb84c4bdadb99
    status: transcribed_unreconciled

dependency_bindings:
  lean_toolchain: leanprover/lean4:v4.33.1
  mathlib_revision: 0df444a360eaa60ab8c11dca51a86af692955474
  lake_manifest_sha256: 4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404
  mathlib_audit:
    path: blueprint/mathlib_audit.md
    sha256: 6b0aab27aac6711894567048c3f232f6ab3345b5d0c79b5b3402e0ecad38378c
  accepted_work_items: []
  draft_work_items:
    - work_item_id: DEF-BERN-001
      card_revision: 1
      card_sha256: 344078c22e3525fe6dcd1c11c83962d52bad496a62c48bdce3e6fb47b53b507b
      proof_artifact_id: NLP-BERN-001-R1
      proof_sha256: 91acc0f38731738eaec1317ef50af9831f89a674d9512bb16bcafc6d454eef3d
      status: planning_prerequisite_not_yet_accepted

classification_schema_binding:
  path: review/classifications-v2.json
  schema_version: lmlf-classification-v2
  artifact_revision: 2
  sha256: 8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9

structural_circularity_review:
  applicability: required
  inapplicable_reason: null
  required_perspectives:
    - dependency_direction
    - source_to_target_reachability
    - hypothesis_and_choice_laundering

supersedes: null
---

# DEF-BERN-002: periodic Bernoulli identification dossier

## Status and exact boundary

This author-complete revision-1 draft identifies the unscaled periodic
Bernoulli function

\[
 x\longmapsto B_s(\{x\})=s!\,\omega_s(x)
\]

collated from Olver, Chapter 8 section 1, with the pullback of the already
existing pinned Mathlib object
`periodizedBernoulli s : UnitAddCircle -> Real`:

\[
 \operatorname{periodizedBernoulli}(s)
   (x:\operatorname{UnitAddCircle})
 =\operatorname{bernoulliFun}(s)(\operatorname{Int.fract}x).
 \tag{PBER.1}
\]

It proposes no LMLF definition, alias, theorem, notation, wrapper, or signature
artifact and authorizes no Lean work. In particular, PBER.1 is identification
evidence for an existing pinned declaration, not a proposed project theorem.

The bound source transcription remains `transcribed_unreconciled`, and the
polynomial identification `DEF-BERN-001` remains an unaccepted planning
prerequisite. This dossier cannot freeze or authorize implementation until
those upstream semantics and this exact normalization are independently
accepted. A change to the source snapshot, transcription bytes, upstream
artifact bytes, Mathlib pin, or any cited pinned source invalidates these
bindings.

The packet stops at source identification. The later `BER-001` packet owns any
real-line facade for the circle function and every project calculus, unit-cell
integral, periodicity convenience lemma, and explicit envelope. Every finite
Euler--Maclaurin identity, endpoint conversion, coefficient, remainder, and
bound remains in `EM-001` or later packets.

## Exact source contract and scaling

The source first defines the periodic saw-tooth

\[
 \omega_1(x)=\{x\}-\frac12,
 \qquad 0\le\{x\}<1,
\]

assigning \(\omega_1(k)=-1/2\) at every integer. It constructs higher
\(\omega_s\) as zero-mean periodic primitives and later compares the ordinary
and exponential generating functions to obtain equation (1.07):

\[
 s!\,\omega_s(x)=B_s(x-[x])=B_s(\{x\}). \tag{PBER.2}
\]

The source uses the usual floor for positive and negative inputs, so
\(\{x\}=x-\lfloor x\rfloor\in[0,1)\). It also fixes
\(B_1(x)=x-1/2\) and \(B_1=-1/2\). Thus PBER.2 gives

\[
 B_1(\{k\})=B_1(0)=-\frac12
 \qquad(k\in\mathbb Z). \tag{PBER.3}
\]

The object identified with `periodizedBernoulli s` is the unscaled function
\(B_s(\{x\})\), not \(\omega_s\). Equivalently, after the identification,
Olver's normalized primitive is the mathematical function
\(x\mapsto\operatorname{periodizedBernoulli}s(x:\mathbb U)/s!\).
This factorial is not optional: already at \(s=2\), \(2!\omega_2=B_2(\{x\})\).

## Standing assumptions and target/quantifier ledger

Fix the exact source snapshot and transcription first. Conditional on
acceptance of `DEF-BERN-001`, write \(B_s^{\mathrm O}(y)\) for the source
polynomial identified with `bernoulliFun s y` on real inputs. No function,
representative, or endpoint value is chosen after \(s\) or \(x\).

| ID | Binder or data | Type | Quantifier position | Depends on | Mathematical role |
|---|---|---|---|---|---|
| `PBER-D01` | exact source snapshot and transcription | fixed artifacts | before all mathematics | nothing | fixes PBER.2 and the half-open convention |
| `PBER-D02` | accepted polynomial normalization | fixed dependency | before the target | `DEF-BERN-001` | identifies source \(B_s(y)\) with `bernoulliFun s y` |
| `PBER-D03` | \(s\) | \(\mathbb N\) | universal after `PBER-D01`--`D02` | source index convention | fixes the polynomial degree before the argument |
| `PBER-D04` | \(x\) | \(\mathbb R\) | universal after \(s\) | quotient map and canonical representative | source real pullback point |
| `DEF-BERN-002-T01` | circle point \(q\) | `UnitAddCircle` | universal after \(s\) | `periodizedBernoulli`, `AddCircle.equivIco` | identifies the entire circle-valued function; source equivalent |

Every circle point has exactly one representative in \([0,1)\), so the real
pullback equality PBER.1 determines the circle function and reaches every
circle point. Conversely, two real inputs differing by an integer map to the
same quotient point. This is an identification on all of `UnitAddCircle`, not
only a pointwise formula on a proper subset.

## Pinned dependency and prospective audit ledger

All declarations in this table already exist at Mathlib revision
`0df444a360eaa60ab8c11dca51a86af692955474`. They are evidence or prospective
audit subjects, not proposed LMLF declarations.

| ID | Exact pinned declaration | Defining import | Exact consumed role |
|---|---|---|---|
| `PBER-M00` | `_root_.periodizedBernoulli` | `Mathlib.NumberTheory.ZetaValues` | existing circle-valued object and sole identification target |
| `PBER-M01` | `_root_.bernoulliFun` | `Mathlib.NumberTheory.ZetaValues` | real evaluation of the accepted Bernoulli polynomial |
| `PBER-M02` | `AddCircle.liftIco` | `Mathlib.Topology.Instances.AddCircle.Defs` | selects the half-open representative |
| `PBER-M03` | `AddCircle.liftIco_zero_coe_apply` | same | restriction of the lift to \(x\in[0,p)\) |
| `PBER-M04` | `AddCircle.coe_equivIco_mk_apply` | same | computes the quotient representative as fractional part |
| `PBER-M05` | `Int.fract_nonneg` | `Mathlib.Algebra.Order.Floor.Ring` | lower bound \(0\le\operatorname{fract}x\) |
| `PBER-M06` | `Int.fract_lt_one` | same | strict upper bound \(\operatorname{fract}x<1\) |
| `PBER-M07` | `Int.fract_intCast` | same | integer representative is zero |
| `PBER-M08` | `_root_.bernoulliFun_one` | `Mathlib.NumberTheory.ZetaValues` | \(B_1(y)=y-1/2\) and both one-sided values |
| `PBER-M09` | `_root_.bernoulliFun_eval_zero` | same | endpoint value is the negative-convention Bernoulli number |
| `PBER-M10` | `_root_.bernoulli_one` | `Mathlib.NumberTheory.Bernoulli` | \(B_1=-1/2\) convention regression |
| `PBER-M11` | `_root_.bernoulliFun_endpoints_eq_of_ne_one` | `Mathlib.NumberTheory.ZetaValues` | endpoint compatibility exactly when \(s\ne1\) |
| `PBER-M12` | `_root_.periodizedBernoulli.continuous` | same | continuity of the circle function for \(s\ne1\) |
| `PBER-M13` | `_root_.bernoulliFun_zero` | same | constant-one regression at \(s=0\) |
| `PBER-M14` | `_root_.bernoulliFun_two` | same | endpoint-compatible quadratic regression at \(s=2\) |
| `PBER-M15` | `AddCircle.continuous_mk'` | `Mathlib.Topology.Instances.AddCircle.Defs` | continuity of the quotient map in the discontinuity regression |

`UnitAddCircle` itself is the abbreviation `AddCircle (1 : Real)` from
`Mathlib.Topology.Instances.AddCircle.Real`. The hashes of that source,
`AddCircle/Defs`, `Floor/Ring`, `Bernoulli`, `BernoulliPolynomials`, and
`ZetaValues` are frozen in the card. Although one intended audit import
`Mathlib.NumberTheory.ZetaValues` transitively exposes these declarations, the
table records their defining imports rather than pretending they originate in
the umbrella file.

## Exact identification identities

### `DEF-BERN-002-I01` - pinned definition and codomain

Pinned Mathlib defines

```text
periodizedBernoulli (s : Nat) : UnitAddCircle -> Real
  := AddCircle.liftIco 1 0 (bernoulliFun s).
```

Thus the pin uses the unit additive circle, not a second function on `Real`,
and applies the real Bernoulli polynomial only after choosing a representative
in the half-open interval \([0,1)\). This type distinction is essential: the
circle object is intrinsically periodic, whereas the source formula is its
real pullback.

### `DEF-BERN-002-I02` - the selected representative is fractional part

`AddCircle.equivIco 1 0` is the equivalence between `UnitAddCircle` and
`Ico 0 1`. For a real \(x\), pinned
`AddCircle.coe_equivIco_mk_apply` computes its underlying representative as

\[
 \operatorname{Int.fract}(x/1)\cdot1=\operatorname{Int.fract}x.
 \tag{PBER.4}
\]

Pinned `Int.fract_nonneg` and `Int.fract_lt_one` give exactly

\[
 0\le\operatorname{Int.fract}x<1. \tag{PBER.5}
\]

This is the source's half-open representative. It is not truncation toward
zero: for example, \(\operatorname{fract}(-1/4)=3/4\), as required by the
usual floor convention.

### `DEF-BERN-002-I03` - agreement on the fundamental interval

For \(y\in[0,1)\), pinned `AddCircle.liftIco_zero_coe_apply` and I01 give

\[
 \operatorname{periodizedBernoulli}s(y:\mathbb U)
 =\operatorname{bernoulliFun}s(y). \tag{PBER.6}
\]

Conditional on the accepted `DEF-BERN-001` identification, the right side is
Olver's \(B_s(y)\). Hence the circle function agrees with the source polynomial
on precisely the source's chosen fundamental interval, including the left
endpoint and excluding the right endpoint.

### `DEF-BERN-002-I04` - arbitrary real pullback

For arbitrary \(x\in\mathbb R\), unfold `periodizedBernoulli` and `liftIco`.
The latter composes `bernoulliFun s` with `AddCircle.equivIco 1 0`. Substituting
the representative computation PBER.4 gives

\[
 \operatorname{periodizedBernoulli}s(x:\mathbb U)
 =\operatorname{bernoulliFun}s(\operatorname{Int.fract}x). \tag{PBER.1 revisited}
\]

By `DEF-BERN-001`, this is \(B_s(\{x\})\). By the source equation PBER.2,
it is also \(s!\omega_s(x)\). No derivative, integral, recurrence for
\(\omega_s\), Fourier formula, or Euler--Maclaurin identity participates in
this conclusion.

### `DEF-BERN-002-I05` - integer value and the negative `B_1` convention

For \(k\in\mathbb Z\), pinned `Int.fract_intCast` gives
\(\operatorname{Int.fract}(k:\mathbb R)=0\). I04 therefore gives

\[
 \operatorname{periodizedBernoulli}1(k:\mathbb U)
 =\operatorname{bernoulliFun}1(0).
\]

Pinned `bernoulliFun_one` reduces the right side to
\(0-1/2=-1/2\). Equivalently, `bernoulliFun_eval_zero` followed by
`bernoulli_one` gives the same value. This duplicates the check through two
recognizable pinned normalizations and proves PBER.3. A lift through
\((0,1]\) would instead assign \(B_1(1)=+1/2\), so the half-open endpoint is
mathematically observable and cannot be changed as an implementation detail.

### `DEF-BERN-002-I06` - endpoint jump and continuity split

Pinned `bernoulliFun_one` gives \(B_1(y)=y-1/2\). In the real pullback at an
integer \(k\), approach from the right with representatives \(y\downarrow0\):
the values tend to \(-1/2\), equal to the assigned value from I05. Approach
from the left with representatives \(y\uparrow1\): the values tend to
\(+1/2\). Thus left limit minus assigned/right value is one (equivalently the
right-minus-left jump is \(-1\)); the circle function is discontinuous at the
common integer class. Indeed, `AddCircle.continuous_mk'` says the quotient map
from `Real` to `UnitAddCircle` is continuous. If `periodizedBernoulli 1` were
continuous, its composition with that map would be continuous, contradicting
the two pullback limits just computed.

For \(s\ne1\), pinned `bernoulliFun_endpoints_eq_of_ne_one` proves
\(B_s(1)=B_s(0)\). The pinned construction then exposes
`periodizedBernoulli.continuous`, which proves continuity on all of
`UnitAddCircle`. The exception in that theorem is therefore exact, not a proof
artifact. This continuity result is a normalization regression only; the sole
source-identification target remains `periodizedBernoulli` itself.

## Target proof

<a id="target-def-bern-002-t01"></a>
### `DEF-BERN-002-T01` - Olver's periodic Bernoulli polynomial is `periodizedBernoulli`

Fix \(s\in\mathbb N\). I01 shows that the pinned object applies
`bernoulliFun s` to the canonical \([0,1)\) representative of each
`UnitAddCircle` point. I02 identifies the representative of the real quotient
point \((x:\mathbb U)\) as `Int.fract x`, and I04 consequently proves PBER.1
for every real \(x\). Once the planning prerequisite `DEF-BERN-001` is
accepted, it identifies the right side as Olver's \(B_s(\{x\})\), while the
collated equation (1.07)
identifies the same value as \(s!\omega_s(x)\).

Every circle point has a representative in \([0,1)\), so this pullback equality
determines the full circle function. I05 checks the convention-sensitive value
at the quotient class of the integers, and I06 checks both the genuine
first-index jump and the endpoint compatibility for every other index. Hence
the exact existing declaration
`_root_.periodizedBernoulli : Nat -> UnitAddCircle -> Real` is the pinned
implementation of Olver's unscaled periodic Bernoulli polynomial. The target
is `identification` / `source_prerequisite` / `source_equivalent`: it identifies
a source entity, covers no source theorem, and proposes no new mathematics or
declaration.

The quantifiers are reconstructed exactly: after the fixed source and accepted
polynomial identification, for every \(s\in\mathbb N\) and every real \(x\),
PBER.1 holds; surjectivity of the quotient representative extends the
identification to every `UnitAddCircle` point. No smaller domain and no
exceptional value are suppressed.

## Analytic side-condition ledger

| ID | Exact proposition | Consumed by | Proof or dependency | Status |
|---|---|---|---|---|
| `PBER-A01` | source \(B_s(y)\) equals `bernoulliFun s y` for real \(y\) | I03--I04 and T01 | draft `DEF-BERN-001` revision 1 | pending prerequisite acceptance |
| `PBER-A02` | the chosen representative lies in `Ico 0 1` | I02--I04 and T01 | `Int.fract_nonneg`, `Int.fract_lt_one`, and `AddCircle.equivIco` | discharged at the pin |
| `PBER-A03` | every circle point is reached by its representative | T01 | `AddCircle.equivIco` is an equivalence whose inverse is the quotient map | discharged at the pin |
| `PBER-A04` | integers have representative zero | I05 and endpoint regression | `Int.fract_intCast` | discharged at the pin |
| `PBER-A05` | \(B_1(0)=-1/2\) | I05 and T01 | `bernoulliFun_one`; independently `bernoulliFun_eval_zero` plus `bernoulli_one` | discharged at the pin |
| `PBER-A06` | one-sided pullback limits at an integer are \(+1/2\) from the left and \(-1/2\) from the right | I06 and discontinuity regression | explicit linear formula `bernoulliFun_one` and PBER.1 | discharged mathematically |
| `PBER-A06b` | the real quotient map is continuous | I06 and discontinuity regression | `AddCircle.continuous_mk'` | discharged at the pin |
| `PBER-A07` | endpoint values agree for \(s\ne1\) | I06 and continuity regression | `bernoulliFun_endpoints_eq_of_ne_one` | discharged at the pin |
| `PBER-A08` | the circle function is continuous for \(s\ne1\) | I06 and continuity regression | `periodizedBernoulli.continuous` | discharged at the pin |

There is no branch, pole, denominator, improper integral, or analytic
continuation. The only limit argument is the explicit linear first-index
endpoint regression; it is not used to define the function.

## Constant-loss and trust ledgers

This identification has no inequality, estimate, majorant, threshold, or
constant loss. The factorial in PBER.2 is an exact normalization factor rather
than an estimate. It proposes no LMLF declaration or proof term, so an axiom
report and implementation dependency report are not applicable. An eventual
separately authorized audit may kernel-check the pinned shapes without
introducing a semantic wrapper.

## Regularity, uniqueness, exceptions, and real agreement

| Question | Resolution |
|---|---|
| construction | reuse `periodizedBernoulli s := AddCircle.liftIco 1 0 (bernoulliFun s)` |
| familiar specification | PBER.1 is exactly \(B_s(\{x\})\) after `DEF-BERN-001`; source equation (1.07) supplies \(s!\omega_s\) |
| uniqueness | `AddCircle.equivIco 1 0` gives one representative per circle point; agreement on `Ico 0 1` fixes the circle function |
| validity | all \(s\in\mathbb N\), all \(x\in\mathbb R\), equivalently every point of `UnitAddCircle` |
| endpoint | the half-open representative includes 0 and excludes 1; every integer is assigned the value at 0 |
| regularity | continuous on the circle exactly for the pinned proved range \(s\ne1\); no global derivative target |
| normalization | identified object is \(B_s(\{x\})=s!\omega_s(x)\), with \(B_1(\{k\})=-1/2\) |
| real agreement | pullback along `Real -> UnitAddCircle` is `bernoulliFun s (Int.fract x)` |
| branches and poles | none |
| exceptional index | \(s=1\) is discontinuous at the integer class; its point value is still fully specified |

## Boundary and adversarial checks

1. At \(s=0\), `bernoulliFun_zero` gives the constant value 1. The source's
   later convention \(\omega_0=1\) and PBER.2 agree because \(0!=1\).
2. At \(s=1\), every integer has fractional part zero and value \(-1/2\).
   Replacing the negative Bernoulli convention by the positive one would give
   the wrong endpoint and fails `PBER-M08`--`PBER-M10`.
3. At \(s=1\), the right limit equals the assigned value \(-1/2\), while the
   left limit is \(+1/2\). Assigning zero, averaging the limits, or claiming
   continuity is false.
4. Replacing `liftIco` by `liftIoc` selects the representative 1 rather than 0
   at the integer class and changes the first-index value to \(+1/2\). Such a
   replacement is not extensionally harmless.
5. At \(s=2\), `bernoulliFun_two` gives
   \(B_2(y)=y^2-y+1/6\), whose values at 0 and 1 agree. This checks the pinned
   continuity route and also detects accidental use of the first polynomial.
6. For negative input, the representative is the usual fractional part. In
   particular, \(-1/4\) is represented by \(3/4\), not by \(-1/4\); a
   truncation-toward-zero convention would leave the fundamental interval.
7. Omitting the factorial in PBER.2 would identify `periodizedBernoulli s`
   with \(\omega_s\). This is false from \(s=2\) onward and would corrupt later
   Euler--Maclaurin coefficients.
8. Treating `bernoulliFun s` itself as periodic is false at \(s=1\), since its
   endpoint values are unequal. Periodicity belongs to the quotient-valued
   construction, not to the nonperiodic polynomial.
9. The nearby false statement
   `Continuous (periodizedBernoulli s)` for every natural \(s\) is rejected by
   the two one-sided values at \(s=1\). The pinned theorem's hypothesis
   \(s\ne1\) must remain visible.

## Hypothesis-, choice-, and dependency-laundering audit

The identification uses only three ingredients: the independently accepted
nonperiodic polynomial normalization, the pinned definition by `liftIco`, and
the pinned computation of the canonical representative. It does not infer
normalization from a Fourier series, zeta value, recursive primitive,
Euler--Maclaurin formula, derivative theorem, integral, or downstream use.
Those facts could all be compatible with a wrongly assigned point value and
therefore may not substitute for the half-open endpoint check.

No project-local choice is made. `AddCircle.equivIco` fixes one representative
before evaluation, `Int.fract` computes it, and `bernoulliFun` is the fixed
upstream polynomial facade. In particular, there is no after-the-fact choice
between \([0,1)\), \((0,1]\), or an averaged value at integers.

`DEF-BERN-001` is a forward planning prerequisite and must become accepted
before this packet can freeze. `BER-001` is an explicit later consumer and may
define a real-line facade or prove calculus/envelope support only after this
identification is accepted. Neither `BER-001` nor `EM-001` may flow backward
to identify the function they consume. This prevents an Euler--Maclaurin
coefficient or integral-insensitive equality from laundering the source's
pointwise convention.

## Regression and release obligations

An eventual audit, if separately authorized, must check `PBER-M00`--`PBER-M15`
against the bound source hashes and preserve these recognizable facts:

- exact type `Nat -> UnitAddCircle -> Real` and defining import
  `Mathlib.NumberTheory.ZetaValues`;
- definition by `AddCircle.liftIco 1 0 (bernoulliFun s)`;
- agreement with `bernoulliFun s y` for every \(y\in[0,1)\);
- arbitrary-real pullback `bernoulliFun s (Int.fract x)`;
- integer first-index value \(-1/2\), right limit \(-1/2\), and left limit
  \(+1/2\);
- continuous circle function for \(s\ne1\), with no false all-index claim;
- exact scaling `periodizedBernoulli = s! * omega_s` in source notation; and
- an empty LMLF public-declaration list with no semantic alias or wrapper.

Review must also confirm the source snapshot and transcription digests, the
exact `DEF-BERN-001` revision and digests, the resolved Mathlib SHA, every
bound Mathlib source hash, and the declaration-defining imports. Validation of
this Markdown/YAML shape is not mathematical approval.

## Trust, imports, and exclusions

The sole intended umbrella import for a future read-only audit is
`Mathlib.NumberTheory.ZetaValues`. The dependency ledger records narrower
defining imports for the additive-circle and fractional-part facts, but this
packet proposes no project module and no public declaration.

This dossier contains no Lean implementation, `sorry`, axiom, numerical
certificate, floating-point computation, interval computation, evaluator,
tolerance, quadrature, or solver. It excludes a new real facade, all
periodicity/calculus/integral/envelope packaging, recursive construction of
Olver's primitives, Fourier and zeta formulas, and every Euler--Maclaurin
identity, coefficient, endpoint conversion, remainder, or bound. Those
exclusions keep the source-identification target distinct from future package
wrappers and method results.
