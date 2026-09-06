---
schema_version: nl-proof-v1
artifact_id: NLP-BERN-001-R1
work_item_id: DEF-BERN-001
title: Identification of Olver's Bernoulli numbers and polynomials with pinned Mathlib
owner: jaumededios
revision: 1
artifact_state: draft
proof_status: draft

theorem_card_bindings:
  - card_id: DEF-BERN-001
    card_revision: 1
    signature_artifact_id: not_applicable-no-project-declarations

target_bindings:
  - target_id: DEF-BERN-001-T01
    declaration: _root_.bernoulli
    proof_section: target-def-bern-001-t01
    theorem_class: identification
    coverage_class: source_prerequisite
    novelty_class: source_equivalent
  - target_id: DEF-BERN-001-T02
    declaration: Polynomial.bernoulli
    proof_section: target-def-bern-001-t02
    theorem_class: identification
    coverage_class: source_prerequisite
    novelty_class: source_equivalent
  - target_id: DEF-BERN-001-T03
    declaration: _root_.bernoulliFun
    proof_section: target-def-bern-001-t03
    theorem_class: identification
    coverage_class: source_prerequisite
    novelty_class: equivalent_reformulation

source_bindings:
  occurrences:
    - OLV97-C08-EULER-MACLAURIN
  entities:
    - bernoulli_numbers
    - bernoulli_polynomials
  notations:
    - OLV97-N-EM-BNUM
    - OLV97-N-EM-BPOLY
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

# DEF-BERN-001: Bernoulli identification dossier

## Status and exact boundary

This first retained draft identifies the Bernoulli numbers $B_s$ and Bernoulli polynomials
$B_s(x)$ collated from Olver, Chapter 8 section 1, with the already existing
pinned Mathlib objects `bernoulli`, `Polynomial.bernoulli`, and the real
evaluation facade `bernoulliFun`. It proposes no project definition, alias, or
wrapper declaration and authorizes no Lean work.

The source transcription is bound above by SHA-256 and remains
`transcribed_unreconciled`; independent source and normalization review are
still required. A change to the source snapshot, transcription bytes, Mathlib
pin, or any cited Mathlib declaration invalidates this draft's bindings.

The packet stops before periodic Bernoulli functions. In particular,
Olver's \(\omega_s\), fractional-part periodization, integer point values, and
identification with Mathlib's `periodizedBernoulli` belong to later
`DEF-BERN-002`; the real-line facade and calculus/envelope infrastructure then
belong to `BER-001`. Every finite
Euler--Maclaurin identity, coefficient, endpoint conversion, and remainder
belongs to `EM-001`.

This draft makes the source-to-library identification type-complete. Olver's
analytic coefficients are compared in \(\mathbb C\) with canonical casts of
Mathlib's rational coefficients; equation (1.11) supplies a rational recurrence
that proves the identification independently of any unformalized
analytic-to-formal power-series bridge.

## Exact source contract

The bound collation records, for $s\in\mathbb N$,

\[
 \frac{z}{e^z-1}=\sum_{s=0}^{\infty}B_s\frac{z^s}{s!},
 \qquad B_s:=B_s(0),
\]

and

\[
 \frac{z e^{xz}}{e^z-1}
 =\sum_{s=0}^{\infty}B_s(x)\frac{z^s}{s!},
 \qquad |z|<2\pi.
\]

Its finite coefficient, first-value, derivative, and reflection conventions
are

\[
 B_s(x)=\sum_{j=0}^{s}\binom{s}{j}B_{s-j}x^j,
 \quad B_1=-\frac12,
 \quad B_s'(x)=sB_{s-1}(x)\ (s\ge1),
 \quad B_s(1-x)=(-1)^sB_s(x).
\]

This packet audits the algebraic/formal normalization. The analytic assertion
that the displayed complex series converges for $|z|<2\pi$ is not supplied by
the cited formal-power-series theorem and is not a target here.

## Standing assumptions and target/quantifier ledger

The exact source snapshot and transcription are fixed before all indices. Let
\(B_s^{\mathrm O}\in\mathbb C\) denote the coefficient specified by Olver's
convergent generating function, and let
\(P_s^{\mathrm O}\in\mathbb Q[X]\) be the canonical rational polynomial
specified by the finite coefficient formula (1.09). Equation (1.11), together
with \(B_0^{\mathrm O}=1\), shows that every coefficient lies in the embedded
copy of \(\mathbb Q\). No choice of coefficient sequence, scalar embedding, or
polynomial representative is made after \(s\). Coefficient-wise mapping of
\(P_s^{\mathrm O}\) to \(\mathbb C[X]\) is an algebraic corollary, not a claim
about the unresolved complex-\(x\) scope of the source sentence.

| ID | Binder or data | Type | Quantifier position | Depends on | Role |
|---|---|---|---|---|---|
| `BER-D01` | exact source snapshot and transcription | fixed artifacts | before all mathematics | nothing | source identity and formulas |
| `BER-D02` | source coefficient family \(B^{\mathrm O}\) | \(\mathbb N\to\mathbb C\) | fixed by (1.08), then used by every target | `BER-D01` | analytic source coefficients |
| `BER-D03` | rational source polynomial family \(P^{\mathrm O}\) | \(\mathbb N\to\mathbb Q[X]\) | fixed by (1.09) after `BER-D02` | `BER-D02` and BER.2 | canonical polynomial representatives |
| `DEF-BERN-001-T01` | \(s\) | \(\mathbb N\) | universally quantified after `BER-D01`--`BER-D02` | source recurrence and pinned formal recurrence | identify \(B_s^{\mathrm O}=(\texttt{bernoulli s}:\mathbb C)\); source equivalent |
| `DEF-BERN-001-T02` | \(s\) | \(\mathbb N\) | universally quantified after T01 | (1.09), T01, `Polynomial.bernoulli_def` | identify \(P_s^{\mathrm O}=\texttt{Polynomial.bernoulli s}\); source equivalent |
| `DEF-BERN-001-T03` | \(s,x\) | \(\mathbb N\times\mathbb R\) | \(s\) first, then universal real \(x\) | T02 and definition of `bernoulliFun` | real evaluation agreement; equivalent reformulation |

The index is always the natural number $s$. The polynomial and real-function
arguments come after the index. Differentiation is only with respect to that
argument; no derivative in the discrete index is intended.

## Pinned dependency and prospective audit ledger

All targets below are existing declarations to inspect or reuse, not proposed
LMLF declarations.

| ID | Exact pinned declaration | Defining import | Exact role in this packet |
|---|---|---|---|
| `BER-M00` | `_root_.bernoulli_zero` | `Mathlib.NumberTheory.Bernoulli` | $B_0=1$ base case |
| `BER-M01` | `_root_.bernoulli` | `Mathlib.NumberTheory.Bernoulli` | rational number sequence with the negative-$B_1$ convention |
| `BER-M02` | `_root_.bernoulli_one` | same | $B_1=-1/2$ regression |
| `BER-M03` | `_root_.bernoulliPowerSeries` | same | formal series with coefficient $B_s/s!$ |
| `BER-M04` | `_root_.bernoulliPowerSeries_mul_exp_sub_one` | same | number generating-function normalization |
| `BER-M05` | `Polynomial.bernoulli` | `Mathlib.NumberTheory.BernoulliPolynomials` | rational Bernoulli polynomial |
| `BER-M06` | `Polynomial.bernoulli_def` | same | source-facing coefficient orientation |
| `BER-M07` | `Polynomial.coeff_bernoulli` | same | coefficient regression, including out-of-range zero |
| `BER-M08` | `Polynomial.bernoulli_one` | same | $B_1(X)=X-1/2$ regression |
| `BER-M09` | `Polynomial.bernoulli_eval_zero` | same | $B_s(0)=B_s$ |
| `BER-M10` | `Polynomial.derivative_bernoulli` | same | derivative in the polynomial variable |
| `BER-M11` | `Polynomial.bernoulli_comp_one_sub_X` | same | polynomial reflection identity |
| `BER-M12` | `Polynomial.bernoulli_eval_one_sub` | same | evaluated rational reflection identity |
| `BER-M13` | `Polynomial.bernoulli_generating_function` | same | polynomial formal generating-function normalization |
| `BER-M14` | `_root_.bernoulliFun` | `Mathlib.NumberTheory.ZetaValues` | real base change and evaluation of `Polynomial.bernoulli` |
| `BER-M15` | `_root_.bernoulliFun_one` | same | $B_1(x)=x-1/2$ over ℝ |
| `BER-M16` | `_root_.bernoulliFun_eval_zero` | same | real evaluation at zero |
| `BER-M17` | `_root_.hasDerivAt_bernoulliFun` | same | real derivative convention |
| `BER-M18` | `_root_.bernoulliFun_eval_one_sub` | same | real reflection convention |

At pinned revision `0df444a360eaa60ab8c11dca51a86af692955474`,
`BER-M00`--`BER-M04` are defined or proved in
`Mathlib/NumberTheory/Bernoulli.lean`; `BER-M05`--`BER-M13` are in
`Mathlib/NumberTheory/BernoulliPolynomials.lean`; and `BER-M14`--`BER-M18`
are in `Mathlib/NumberTheory/ZetaValues.lean`. The umbrella import for the
first two groups is intentionally the narrower Bernoulli-polynomial import;
the real facade requires `ZetaValues`.

## Exact normalization identities

### `DEF-BERN-001-I01` - coefficient orientation

Pinned `Polynomial.bernoulli_def` gives

\[
 \operatorname{Polynomial.bernoulli}(s)
 =\sum_{j=0}^{s}\operatorname{monomial}
   \left(j,\operatorname{bernoulli}(s-j)\binom{s}{j}\right).
\]

Evaluation at $x$ is therefore

\[
 \sum_{j=0}^{s}\binom{s}{j}\operatorname{bernoulli}(s-j)x^j.
\]

This is term-for-term Olver's equation (1.09). The alternative defining
display in the Mathlib source uses $i$ for the Bernoulli-number index and
the monomial degree $s-i$; it is the same sum after $j=s-i$, not the
opposite Bernoulli convention. `Polynomial.coeff_bernoulli` independently
fixes the coefficient of $X^j$ as
$B_{s-j}\binom{s}{j}$ for $j\le s$, and zero otherwise.

### `DEF-BERN-001-I02` - evaluation at zero and first index

In `DEF-BERN-001-I01`, setting $x=0$ kills every $j>0$ term and leaves
$B_s\binom{s}{0}=B_s$. This is exactly
`Polynomial.bernoulli_eval_zero`. Pinned `bernoulli_one` gives
$\operatorname{bernoulli}(1)=-1/2$, while
`Polynomial.bernoulli_one` gives $B_1(X)=X-1/2$. Hence the source and pin
both use the negative-$B_1$ convention.

### `DEF-BERN-001-I03` - recurrence and coefficient uniqueness

Olver prints

\[
 B_0^{\mathrm O}=1,
 \qquad
 B_{s-1}^{\mathrm O}
 =-\frac1s\sum_{j=0}^{s-2}\binom{s}{j}B_j^{\mathrm O}
 \quad(s\ge2). \tag{BER.1}
\]

The recurrence starts in \(\mathbb Q\) and uses only rational operations, so
induction shows that every analytic coefficient
\(B_s^{\mathrm O}\in\mathbb C\) is the canonical cast of a unique rational
number. Pinned `bernoulli_zero` supplies the same base value. Instantiate
`bernoulliPowerSeries_mul_exp_sub_one` at the coefficient algebra
\(A=\mathbb Q\). For \(s\ge2\), taking its coefficient of degree \(s\) gives
explicitly

\[
 0=[Z^s]\bigl(\mathcal B(Z)(e^Z-1)\bigr)
  =\sum_{j=0}^{s-1}\frac{B_j}{j!(s-j)!}.
\]

Multiplication by \(s!\) gives
\(0=\sum_{j=0}^{s-1}\binom{s}{j}B_j\). The final term is
\(sB_{s-1}\), so isolating it gives exactly BER.1 for root `bernoulli`.
Induction on the index therefore gives

\[
 B_s^{\mathrm O}=(\operatorname{bernoulli}(s):\mathbb C)
 \qquad(s\in\mathbb N). \tag{BER.2}
\]

This is the identification proof. It does not assume that an analytic complex
series and a formal power series are definitionally the same object.

### `DEF-BERN-001-I04` - formal generating function for the numbers

For any commutative ℚ-algebra $A$, pinned `bernoulliPowerSeries A` has
formal coefficient

\[
 [Z^s]\,\mathcal B(Z)=\operatorname{algebraMap}_{\mathbb Q,A}(B_s/s!).
\]

Pinned `bernoulliPowerSeries_mul_exp_sub_one` proves

\[
 \mathcal B(Z)(\exp Z-1)=Z
\]

as an equality of formal power series. This is the correct denominator-cleared
formal meaning of Olver's $Z/(e^Z-1)$. One must not write division by
$\exp Z-1$ inside the formal power-series ring: its constant coefficient is
zero, so it is not a unit. The cleared identity nevertheless fixes the same
coefficient recurrence and, in particular, the same $B_1=-1/2$.

### `DEF-BERN-001-I05` - formal generating function for the polynomials

For a commutative ℚ-algebra $A$ and $x\in A$, let

\[
 \mathcal B_x(Z)=\sum_{s\ge0}
   \operatorname{aeval}_x(B_s(X))\frac{Z^s}{s!}.
\]

Pinned `Polynomial.bernoulli_generating_function x` states

\[
 \mathcal B_x(Z)(\exp Z-1)=Z\,\operatorname{rescale}_x(\exp Z).
\]

The coefficient of $Z^s$ in `rescale x (exp A)` is $x^s/s!$, so its
formal series is $e^{xZ}$. Thus the right side is $Ze^{xZ}$, precisely
the denominator-cleared form of Olver's polynomial generating function. The
factor order in the source comment and theorem statement is immaterial because
the power-series coefficient ring is commutative.

## Target proofs

<a id="target-def-bern-001-t01"></a>
### `DEF-BERN-001-T01` - Olver's numbers are root `bernoulli`

Olver's printed base value and recurrence are BER.1. I03 proves by induction
that its complex analytic coefficient is the canonical cast of
`_root_.bernoulli s : ℚ`, establishing BER.2. I02 independently checks the
convention-sensitive coefficient \(B_1=-1/2\), and I04 checks compatibility
with the denominator-cleared formal generating identity. Thus the identified
rational object is `_root_.bernoulli : ℕ → ℚ`; the source coefficient is its
cast into the analytic scalar field.

<a id="target-def-bern-001-t02"></a>
### `DEF-BERN-001-T02` - Olver's polynomials are `Polynomial.bernoulli`

After BER.2, `DEF-BERN-001-I01` is exactly Olver's finite coefficient formula
as an equality in \(\mathbb Q[X]\), after only a bound-index rename. Its
constant term is the identified number by `DEF-BERN-001-I02`. Independently,
`DEF-BERN-001-I05` gives the same
denominator-cleared formal generating identity after arbitrary commutative
\(\mathbb Q\)-algebra base change. These checks rule out reversal of the
coefficient sequence, reversal of the polynomial argument, and use of the
positive-$B_1$ sequence. The canonical rational representative is
`Polynomial.bernoulli s : ℚ[X]`. Its coefficient-wise map to
\(\mathbb C[X]\) is a valid algebraic corollary, while source equivalence is
claimed only for the rational polynomial and its real evaluations.

Pinned `Polynomial.derivative_bernoulli` further gives

\[
 (B_s)'=sB_{s-1},
\]

for the source range \(s\ge1\). Mathlib's natural-index theorem also covers
\(s=0\), where natural subtraction and the scalar zero make the right side
zero. This is a harmless algebraic extension, not an enlargement attributed
to Olver. Pinned
`Polynomial.bernoulli_comp_one_sub_X` gives

\[
 B_s(1-X)=(-1)^sB_s(X).
\]

These are Olver's derivative-variable and reflection conventions.

<a id="target-def-bern-001-t03"></a>
### `DEF-BERN-001-T03` - the real facade is `bernoulliFun`

Pinned `bernoulliFun s x` is definitionally the evaluation at $x\in\mathbb R$
of `Polynomial.bernoulli s` after mapping its rational coefficients into
ℝ. It is therefore an evaluation facade, not a fourth Bernoulli object.
`bernoulliFun_eval_zero`, `bernoulliFun_one`,
`hasDerivAt_bernoulliFun`, and `bernoulliFun_eval_one_sub` transport exactly
the zero-evaluation, $B_1$, derivative, and reflection conclusions above:

\[
 B_s(0)=B_s,\qquad B_1(x)=x-\frac12,
\]

\[
 \frac{d}{dx}B_s(x)=sB_{s-1}(x),\qquad
 B_s(1-x)=(-1)^sB_s(x).
\]

The derivative is with respect to the real argument $x$ and is source-facing
for \(s\ge1\); the pinned theorem's \(s=0\) case is the zero-factor extension.
The conclusion is global in \(x\) because a polynomial has no branch or
singularity. This completes
the mathematical identification, subject to the draft's external source and
pin-review gates.

## Analytic side-condition ledger

| ID | Exact proposition | Consumed by | Proof or dependency | Status |
|---|---|---|---|---|
| BER-A01 | the source series converges for \(|t|<2\pi\) | naming \(B_s^{\mathrm O}\) in T01 | bound source equation (1.08) | assumed from source; no boundary claim |
| BER-A02 | every \(B_s^{\mathrm O}\) is the cast of a rational number | I03 and T01 | BER.1 starts at 1 and uses only rational operations | proved by induction |
| BER-A03 | root `bernoulli` satisfies BER.1 with base 1 | I03 and T01 | `bernoulli_zero` plus coefficient calculation from the pinned cleared identity | discharged |
| BER-A04 | \(P_s^{\mathrm O}=\texttt{Polynomial.bernoulli s}\) in \(\mathbb Q[X]\) | T02 | source (1.09), BER.2, and `Polynomial.bernoulli_def` | discharged coefficientwise |
| BER-A05 | `bernoulliFun s x` is evaluation after \(\mathbb Q\to\mathbb R\) coefficient map | T03 | pinned definition and `bernoulliFun_eval_zero` | discharged for every real \(x\) |
| BER-A06 | derivative statement has source range \(s\ge1\) | T02--T03 convention audit | source derivative display and pinned derivative theorems | discharged; \(s=0\) only a Mathlib extension |
| BER-A07 | reflection holds over the stated rational/real domains | T02--T03 convention audit | pinned polynomial and real reflection theorems | discharged |

No equality of an analytic function with a formal-power-series object is used
without a bridge. The analytic series supplies the source coefficients and the
printed recurrence; the formal series supplies the pinned recurrence.

## Constant-loss and trust ledgers

This identification has no inequality, estimate, majorant, or constant, so the
constant-loss ledger is not applicable. It proposes no LMLF declaration or
proof term, so an allowed-axiom report is likewise not applicable. A future
audit module may kernel-check the pinned declaration shapes, but that audit is
not an implementation of new Bernoulli mathematics.

## Regularity, uniqueness, exceptions, and real agreement

| Question | Resolution |
|---|---|
| construction | reuse root `bernoulli`; form `Polynomial.bernoulli`; map/evaluate it as `bernoulliFun` |
| familiar specification | the source recurrence `I03` proves identity; denominator-cleared formal generating identities `I04` and `I05` audit compatibility |
| uniqueness | coefficient comparison recursively fixes the number series; `I01` then fixes every polynomial coefficient |
| validity | all $s\in\mathbb N$; rational polynomial arguments for `Polynomial.bernoulli`, real arguments for `bernoulliFun` |
| regularity | polynomial globally; the prospective derivative audit is `hasDerivAt_bernoulliFun` |
| normalization | $B_0=1$, $B_1=-1/2$, coefficient of $x^j$ equal to $\binom{s}{j}B_{s-j}$ |
| real agreement | `bernoulliFun` is coefficient base change ℚ→ℝ followed by evaluation |
| branches and poles | none; all three reused objects are algebraic/polynomial |
| exceptional index | $s=0$ is handled by the zero derivative factor; $s=1$ has unequal polynomial endpoint values, $B_1(0)=-1/2$ and $B_1(1)=+1/2$ |

The $s=1$ endpoint observation is only an adversarial check on the
nonperiodic polynomial. This packet makes no choice of periodic representative
and no claim about values after periodization.

## Boundary and adversarial checks

1. At $s=0$, the coefficient formula gives $B_0(X)=1$, evaluation at zero
   gives $B_0=1$, and Mathlib's derivative extension has the required zero
   factor; the source derivative display begins at $s=1$.
2. At $s=1$, the pin gives $B_1=-1/2$ and $B_1(x)=x-1/2$. Replacing this
   by the positive-$B_1$ convention would fail both `BER-M02` and `BER-M08`.
3. At $s=2$, `I01` gives $B_2(x)=x^2-x+1/6$; this detects either reversal
   of the index $s-j$ or loss of the binomial coefficient.
4. Setting $x=0$ must produce `bernoulli s`, not `bernoulli' s`; these differ
   at $s=1$.
5. Reflection at $s=1$ reads $B_1(1-x)=-B_1(x)$, confirming both the sign
   exponent and the center $1/2$.
6. A claimed formal quotient by `exp A - 1` is rejected: the denominator has
   zero constant coefficient. Only the cleared products `BER-M04` and
   `BER-M13` are prospective audit targets.
7. `bernoulliFun 1 0=-1/2` and `bernoulliFun 1 1=+1/2`; treating the
   nonperiodic real polynomial as periodic is false.

## Hypothesis-, choice-, and dependency-laundering audit

The source analytic series is used only to name its coefficients; the printed
base value, finite recurrence, and coefficient formula perform the actual
identification. There are no branches, denominators at input values, or
project-local choices in the three identifications. The only algebraic ambient
assumptions in the formal generating theorems are the pinned declarations'
commutative-ring and ℚ-algebra assumptions. The source's analytic radius
$|z|<2\pi$ is deliberately not inferred from those formal statements.

No future `DEF-BERN-002`, `BER-001`, or `EM-001` result is used to identify the
present objects. Conversely, those later packets may depend on this
identification after it is reviewed and accepted. This direction prevents a
periodicization or Euler--Maclaurin formula from laundering the normalization
it is supposed to consume.

## Regression and release obligations

An eventual audit, if separately authorized, must check exactly
`BER-M00`--`BER-M18` at the bound revision and must preserve these expected
shapes:

- root type `ℕ → ℚ`, polynomial type `ℕ → ℚ[X]`, and real facade
  `ℕ → ℝ → ℝ`;
- coefficient $B_{s-j}\binom{s}{j}$, $B_1=-1/2$, and evaluation at zero;
- derivative in the polynomial/real argument and reflection $1-x$;
- both denominator-cleared formal generating identities with factorial-scaled
  coefficients;
- an empty LMLF public-declaration list and no semantic alias.

Review must also confirm the source snapshot and transcription digests, the
resolved Mathlib SHA, and the exact imported declaration sources. Validation
of this Markdown/YAML shape is not mathematical approval.

## Trust, imports, and exclusions

The narrow intended audit imports are
`Mathlib.NumberTheory.BernoulliPolynomials` for rational numbers, rational
polynomials, and formal generating identities, and
`Mathlib.NumberTheory.ZetaValues` only for the real evaluation facade and its
calculus/reflection facts. No project module or public declaration is proposed.

This packet contains no Lean implementation, `sorry`, axiom, numerical
certificate, floating-point computation, interval computation, evaluator,
tolerance, quadrature, or solver. It excludes periodic Bernoulli functions,
Olver's \(\omega_s\), all Euler--Maclaurin statements, power-sum applications,
Bernoulli bounds, midpoint values, zeta values, and analytic convergence of the
complex generating series.
