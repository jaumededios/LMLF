# Chapter 5 global object-first audit

## Snapshot and scope

Review snapshot: branch `site/verso-dlmf-overlay`, tip `31b53f8`
(`Complete Chapter 4 DLMF statement overlay`), with the Chapter 5 author and
manual files uncommitted in the worktree.  I reviewed:

- `LMLF/Blueprint/Gamma/Section51.lean` through `Section518.lean`, including
  `Section59.lean`;
- the corresponding `doc/LMLFManual/Chapter5/Section*.lean` files;
- `coverage/sections/chapter5-*.json` and the Chapter 5 aggregate wiring;
- the shared Chapter 3 contour/integral vocabulary and the §5.10 continued
  fraction implementation.

The numbered formula inventories in the manifests agree with the source
inventories: §5.2 has 9, §5.4 has 20, §5.5 has 9, §5.6 has 9, §5.7 has 8,
§5.8 has 5, §5.9 has 25, §5.10 has 2, §5.11 has 19, §5.12 has 12, §5.13
has 5, §5.14 has 7, §5.15 has 9, §5.16 has 2, §5.17 has 7, and §5.18 has
12.  Sections 5.1 and 5.3 have no numbered displays; their notation and
figure-caption inventories are separate.  Thus this is an object/API audit,
not a missing-number audit.

Focused checks:

- every `LMLF/Blueprint/Gamma/Section*.lean` file elaborates with the current
  permitted `sorry`s;
- the source TeX checker accepts the manual source expressions sampled during
  the review.

The DLMF semantics were checked against the official pages for [§5.4](https://dlmf.nist.gov/5.4),
[§5.9](https://dlmf.nist.gov/5.9), [§5.11](https://dlmf.nist.gov/5.11),
[§5.12](https://dlmf.nist.gov/5.12), and [§5.13](https://dlmf.nist.gov/5.13).

## Verdict

**Revise.**  The numbered coverage is broad and the pages are readable at the
ordinary DLMF level, but several central Chapter 5 APIs still expose
implementation choices rather than the mathematical objects.  The most
important repairs are shared infrastructure changes, not individual proof
holes.

## P1 — material API or source-fidelity problems

### G5-1 — Integral statements systematically conflate convergence with value

**Locations:** `LMLF/Blueprint/Gamma/Section59.lean` declarations
`dlmf_5_9_1`, `dlmf_5_9_2_5`, `dlmf_5_9_3`, `dlmf_5_9_4`, `dlmf_5_9_5`,
`dlmf_5_9_10`, `dlmf_5_9_10_1`, `dlmf_5_9_10_2`, `dlmf_5_9_11_1`,
`dlmf_5_9_11_2`, `dlmf_5_9_12`, `dlmf_5_9_13`, `dlmf_5_9_14`,
`dlmf_5_9_15`, `dlmf_5_9_16`, `dlmf_5_9_17`, `dlmf_5_9_18`,
`dlmf_5_9_19`, and `dlmf_5_9_20`; analogous conjunctions occur in
`Section512.lean`, `Section513.lean`, and `Section514.lean`.

Most of these declarations have the shape

```lean
IntegrableOn integrand domain ∧ integral = value
```

or several copies of that shape.  This is precisely the unreadable pattern
that the §5.2 Gamma page avoided: a reader cannot use the value identity
without unpacking an unrelated convergence assertion, and there is no reusable
name for the actual improper integral.  The official §5.9 page presents the
integral identity and its domain conditions as mathematical data; it does not
make “the proof that this function is integrable” the visible shape of every
formula.

**Repair.**  Introduce shared declarations in Chapters 1–3, then split each
entry into the mathematically independent pieces.  For example:

```lean
def GammaEulerIntegrand (z : ℂ) : ℝ → ℂ := ...

def GammaEulerDomain (z : ℂ) : Prop := 0 < z.re

theorem gammaEuler_integrable (hz : GammaEulerDomain z) :
    IntegrableOn (GammaEulerIntegrand z) (Set.Ioi 0)

theorem gammaEuler_value (hz : GammaEulerDomain z) :
    ∫ t in Set.Ioi (0 : ℝ), GammaEulerIntegrand z t = Complex.Gamma z
```

For conditionally convergent formulas, use a named `HasImproperIntegral` or
`HasOscillatoryIntegral` relation rather than a bare `Tendsto` of an expanded
interval integral.  The manual should show the ordinary DLMF theorem first,
then the convergence declaration and the value declaration as separate
expandable Lean panels.  This is a Chapter 5-wide migration and should be
done before adding more special-function statements.

### G5-2 — §5.9.2’s good contour API is not reused by the other contour formulas

**Locations:** `Section59.complexSegmentIntegral`,
`Section59.verticalLineIntegral`, `Section512.contourIntegral`,
`Section513.verticalLineIntegral`, and the associated declarations
`dlmf_5_9_20`, `dlmf_5_9_11`, `dlmf_5_9_17`, `dlmf_5_12_10`,
`dlmf_5_12_11`, `dlmf_5_12_12`, and all §5.13 entries.

The user-facing §5.9.2 statement correctly uses
`LMLF.Integral.HasHankelRepresentation` and hides the finite contour
parameterization.  Elsewhere the project regresses to raw functions
`ℝ → ℂ` and Mathlib's totalized `deriv`:

```lean
def contourIntegral (f : ℂ → ℂ) (curve : ℝ → ℂ) : ℂ :=
  ∫ u in (0 : ℝ)..1, f (curve u) * deriv curve u
```

There are also three namespace-local copies of the vertical-line integral.  A
raw curve can be nowhere differentiable while the definition still returns a
value, so the displayed formula silently loses the `C¹` premise.  This is a
material mismatch for exactly the class of branch-sensitive integrals the
project is trying to make seamless.

**Repair.**  Generalize the Chapter 3 `C1Contour` interface used by §5.9.2:

```lean
structure C1Contour where
  curve : ℝ → ℂ
  deriv : ℝ → ℂ
  hasDeriv : ...

def C1Contour.integral (γ : C1Contour) (f : ℂ → ℂ) : ℂ := ...
def verticalLine (c : ℝ) : C1Contour := ...
```

Add an `ImproperC1Contour`/`HasImproperContourIntegral` layer for whole-line
and loop limits.  Define a single `verticalLine` object and reuse it in §§5.9,
5.12, and 5.13.  Keep branch lifts as explicit typed data, as §5.9.2 and the
good parts of `SecondLoopLogBranch` already do.

### G5-3 — §5.11 coefficient streams are arbitrary selected witnesses

**Locations:** `Section511.StirlingCoefficientSpec`,
`existsStirlingCoefficientSpec`, `stirlingCoefficientSpec`, `gCoeff`, and
`aCoeff`.

The module proves only `Nonempty StirlingCoefficientSpec` and then defines the
public coefficient streams by `Classical.choice`.  The fields do record the
first seven values and a recurrence, but the stream displayed to readers is
not an algorithmically determined object.  This is unlike §5.10, where
`gammaContinuedFractionCoeff` is an executable normalized map and has
reconstruction, uniqueness, and finite-prefix behavior.

**Repair.**  Make the coefficient source canonical.  Define `aCoeff : ℕ → ℝ`
by a recurrence/finite recursion (the coefficient of the new index is
isolated using the nonzero initial coefficient), define `gCoeff` from it, and
state:

```lean
theorem aCoeff_recurrence ...
theorem aCoeff_unique (a : ℕ → ℝ) (h : ...recurrence...) : a = aCoeff
theorem aCoeff_prefix (N : ℕ) : aCoeff N = ...finite computation...
```

If the recursive construction is too much for the current proof phase, retain
the structure only as a temporary internal specification and do not expose
`Classical.choice` as the Chapter 5 public definition.  At minimum, provide a
canonical stream and an explicit uniqueness theorem before using it in the
asymptotic panels.

### G5-4 — Generalized Bernoulli polynomials are also selected by choice

**Locations:** `Section511.GeneralizedBernoulliSpec`,
`existsGeneralizedBernoulliSpec`, `generalizedBernoulliSpec`, and
`generalizedBernoulli`.

The ratio expansions 5.11.13–5.11.18 depend on an arbitrary selected function
whose only public law is a generating-function `HasSum`.  This loses the exact
finite-prefix nature of the generalized Bernoulli polynomials and makes the
coefficients impossible to compute or compare.  It also duplicates the
project's generalized-binomial vocabulary in Chapter 4/§5.11.

**Repair.**  Define generalized Bernoulli coefficients from the formal power
series identity (or the standard finite recurrence) and expose a finite
coefficient evaluator.  State the generating-function identity as the
semantic theorem, not as the property of a `Classical.choice` object.  A
useful API is:

```lean
def generalizedBernoulli (α x : ℝ) (n : ℕ) : ℝ := coefficient ... n
theorem generalizedBernoulli_prefix ...
theorem generalizedBernoulli_generating ...
```

The reader should see `generalizedBernoulli α x n`, not a hidden
`generalizedBernoulliSpec.value` projection.

### G5-5 — §5.17 Barnes product has no semantic product/convergence layer

**Locations:** `Section517.barnesG`, `barnesGProductTerm`,
`dlmf_5_17_3`.

`barnesG` is defined directly with Mathlib's totalized `∏'`, while E3 merely
repeats the same expression.  There is no `HasProd`/convergence declaration
for the canonical product and no separation between “the product exists,”
“this is the Barnes function,” and “the functional equation holds.”  The DLMF
E3 display is a genuine canonical-product representation, not a definition
whose theorem should be a restatement.

**Repair.**  Define a product datum or an explicit partial-product sequence:

```lean
def barnesGPartialProduct (z : ℂ) (N : ℕ) : ℂ := ...
theorem barnesGProduct_hasProd (z : ℂ) :
    HasProd (barnesGProductTerm z) (barnesGProduct z)
def barnesG (z : ℂ) := barnesGProductPrefactor z * barnesGProduct z
theorem barnesG_product_formula ...
```

If the current theorem is intentionally proof-pending, the semantic shape
should still be this three-layer API.  Do not make `∏'` itself the only
statement of convergence.

### G5-6 — Glaisher's constant uses a totalized limit and then proves its own definition

**Locations:** `Section517.glaisherLogConstant`, `glaisherConstant`,
`dlmf_5_17_6`, and the first conjunct of `dlmf_5_17_7`.

`glaisherLogConstant` is `limUnder atTop glaisherPartialExpression`, so the
first conjunct of E7 is the defining expression restated as a theorem.  E6 is
also exactly the defining equation of `glaisherConstant`.  A totalized limit
does not communicate that the sequence converges, and a reader cannot tell
which value is intended independently of the chosen totalization.

**Repair.**  Choose a canonical source value (for example the zeta-derivative
expression in E7) and make convergence a separate theorem:

```lean
def glaisherLogConstant : ℝ := ...canonical zeta derivative expression...
theorem glaisherPartialExpression_tendsto :
  Tendsto glaisherPartialExpression atTop (𝓝 glaisherLogConstant)
def glaisherConstant : ℝ := Real.exp glaisherLogConstant
```

Then E7 contains the nontrivial sequence-limit and zeta-derivative
identifications; E6 is a definition panel or a useful named rewrite, not a
fake theorem.  This is the same syntax/convergence/value separation needed for
series and integrals.

### G5-7 — q-Gamma and q-Beta quotients expose totalized poles

**Locations:** `Section518.qGamma`, `qBeta`, `qGammaPoleFree`,
`dlmf_5_18_4`, `dlmf_5_18_7`, `dlmf_5_18_11`, and `dlmf_5_18_12`.

The module documents the issue, but the public functions are still ordinary
field quotients.  E4 and E11 are definition restatements; E5, E6, E8–E10, and
E12 use values without consistently carrying the denominator's pole-free
condition.  In particular, `qGammaReal` is merely the real part of a
totalized complex quotient, while the convexity and Bohr–Mollerup declarations
need a positive real-valued function on `x > 0`.

**Repair.**  Introduce a pole-free/domain object for the source's ordinary
q-Gamma function, analogous to the branch-aware contour object:

```lean
structure QGammaPoint (q : ℝ) (z : ℂ) where
  hq : 0 < q ∧ q < 1
  hdenom : qGammaDenom q z ≠ 0

def qGammaValue (p : QGammaPoint q z) : ℂ := ...
theorem qGamma_recurrence (p : ...) : ...
```

Keep a totalized convenience function only as a clearly named implementation
proxy.  For `qPochhammerInf` and `qJacksonIntegral`, pair each `tprod`/`∑'`
definition with a `HasProd`/`HasSum` theorem before using it in a value
identity.

### G5-8 — The extrema formula is an unstructured existential sequence

**Location:** `Section54.gamma_extrema_asymptotic` (DLMF 5.4.20).

The official page presents the points `x_n` as the successive extrema from
Table 5.4.1 and then gives their asymptotic location.  The current theorem
only says that *some* function `x : ℕ → ℝ` has zero derivative/digamma values
and an eventual bound.  It does not say that `x_n` is the unique critical
point in the relevant pole interval, that the sequence is ordered, or that it
is the sequence selected by the table.  The eventual bound also leaves the
reader to infer that the asymptotic regime starts after the totalized `log 0`
case.

**Repair.**  Define a typed extremum sequence:

```lean
structure GammaExtremum (n : ℕ) where
  point : ℝ
  inPoleInterval : ...
  critical : deriv Real.Gamma point = 0
  uniqueInInterval : ...
def gammaExtremum (n : ℕ) : GammaExtremum n := ...
```

State the asymptotic theorem for `gammaExtremum n |>.point`, explicitly for
`n ≥ 1` (or use a filter that excludes the finite initial table rows), and keep
the decimal table as labelled approximations.  This makes the existential
choice meaningful and gives later chapters a reusable ordered-zero API.

## P2 — clear reusable/API/readability improvements

### G5-9 — Rising factorial and generalized binomial are duplicated locally

**Locations:** `Section52.pochhammerSymbol`, `Section511.risingFactorial`,
`Section511.generalizedBinomial`, and `LMLF/Blueprint/Elementary/Section46.lean`'s
`generalizedBinomial`.

§5.2 already exposes Mathlib's evaluated ascending Pochhammer polynomial, while
§5.11 creates a real-only product under a new name.  Chapter 4 already has a
complex generalized-binomial definition.  This forces readers to remember
which coefficient API each asymptotic page uses and makes future coefficient
algorithms harder to share.

**Repair.**  Put the generic finite rising factorial and generalized binomial
in Chapter 2/3 vocabulary, define real/complex coercion lemmas, and make
`Section511` use those canonical objects.  Keep a local notation only when it
improves the displayed formula, with a one-line equivalence theorem.

### G5-10 — Remainders are residual definitions presented as substantive theorems

**Locations:** `Section511.gammaRemainder`, `complexStirlingRemainder`, and
`dlmf_5_11_10`; `Section57.logGammaOnePlus` and
`logGamma_one_add_hasSum`; `Section517.dlmf_5_17_6`.

Some residual definitions are legitimate source notation, but the current
manual presents them as if the following theorem established the expansion.
For example, `gammaRemainder` is literally
`Gamma / prefactor - finiteSum`, and E10 then asserts the corresponding
factorization.  Likewise `logGammaOnePlus` is defined by the infinite series,
so the displayed `HasSum` target is algebraically the series component of the
definition rather than the reader-facing theorem that the independently
chosen log-Gamma branch has that Taylor expansion.

**Repair.**  Mark source-defined residuals as `def` panels and reserve theorem
panels for their bounds, sign/phase information, uniqueness, or convergence.
For log-Gamma, define the normalized branch first and state the `HasSum` result
against that branch.  For a finite asymptotic expansion, expose a record such
as `GammaExpansion K z` only if it carries the source's nontrivial remainder
data; otherwise do not add a theorem whose proof is just unfolding.

### G5-11 — Repeated pole hypotheses should have a named regular-point API

**Locations:** the repeated binders
`∀ n : ℕ, z ≠ -(n : ℂ)` in §§5.2, 5.4, 5.5, 5.6, 5.7, 5.8, 5.9, 5.15,
and 5.17, plus the corresponding integer-pole variants.

The hypotheses are mathematically stable data, but every formula expands them
again.  This is the pointwise analogue of expanding a contour into all its
parameterization details.

**Repair.**  Add a small shared predicate/subtype such as
`GammaRegularPoint` and `GammaNoPole` (with coercion back to `ℂ`) and use it for
the pointwise API.  Keep proposition-form convenience lemmas for users who
already have an ordinary `z`, but make the structured form the canonical
interface.  Do not force this onto formulas whose pole conditions genuinely
vary independently (e.g. a quotient with several shifted arguments).

### G5-12 — §5.14 coordinate-selection plumbing obscures Selberg objects

**Locations:** `Section514.firstCoordinatesProduct`, `selbergIndex`,
`selbergCubeIntegrand`, `laguerreIntegrand`, and E4/E5.

The formulas repeatedly expose `Fin.castLE hmn`, `k.1`, and the translated
source index.  The result is technically readable to a Lean expert but not to
the DLMF reader looking for the Selberg and Laguerre integrands.

**Repair.**  Introduce a small `CoordinateSelection m n` object carrying
`m ≤ n` and the canonical embedding, with named projections
`selectedCoordinate` and `selbergIndex`.  Then the displayed formulas retain
the mathematical `t_1⋯t_m` and `n-k` vocabulary while the finite-index proof
plumbing stays in the shared definition panel.

### G5-13 — §5.18 contains several definition-equation theorem panels

**Locations:** `dlmf_5_18_1`, `dlmf_5_18_4`, and `dlmf_5_18_11`.

These declarations restate `qPochhammer`, `qGamma`, and `qBeta` definitions.
The ordinary DLMF formula should still be displayed, but the Lean panel should
show the definition itself, not a theorem whose only content is unfolding.

**Repair.** Use definition anchors for E1/E4/E11, and reserve theorem anchors for
the finite-product recurrence, convergence (`HasProd`), pole-free recurrence,
and Jackson-integral/value claims.  This also makes the page consistent with
the §5.10 “algorithm as definition, reconstruction as theorem” design.

### G5-14 — §5.3 figure captions are represented mostly by tautologies

**Locations:** `Section53.gamma_abs_graph_nonnegative`,
`reciprocal_gamma_abs_graph`, and `digamma_abs_graph_nonnegative`.

The declarations prove nonnegativity or the norm-of-inverse identity, but do
not define a graph datum or preserve the substantive caption information (the
plotted domains, reciprocal surface, and qualitative shape).  Since §5.3 has
no numbered displays, this does not create an ID mismatch, but it weakens the
“Lean-era DLMF” integration at exactly the figure boundary.

**Repair.**  Keep the elementary helper lemmas if useful, but add a compact
figure-data record with the function, domain, and caption assertions.  Make the
manual present those as figure metadata/qualitative claims rather than as if
the nonnegativity lemmas were the plotted mathematics.

## Accepted patterns and explicit do-not-refactor decisions

- **§5.10:** `CFCoefficients`/`ZeroTerminated`, optional evaluator offset,
  executable `cfracCoeff`, reconstruction, uniqueness, and finite-prefix
  dependence are the correct Chapter 5 pattern.  Keep analytic convergence
  separate from formal reconstruction.
- **§5.9.2:** `HasHankelRepresentation` is the correct reader-facing contour
  statement.  Keep the special-function integrand and value visible while
  hiding the finite contour machinery.  Generalize this interface; do not
  replace it with expanded interval integrals.
- **§5.2:** `gamma_eulerIntegrable` and `gamma_eq_eulerIntegral` are correctly
  separate declarations.  Apply this pattern to the remaining integral pages.
- **§5.16:** the positive-index subtype and conditional summation filter are a
  good model for ordered/conditionally convergent sums.  Retain the subtype
  rather than reverting to an unguarded `ℕ` sum.
- **§5.12 branch data:** the global coherence intent in
  `SecondLoopLogBranch` and `PochhammerLogBranch` is correct.  The repair is to
  put the branch data on the shared contour interface, not to erase it or
  replace it with a free existential.
- **§5.18 E3:** the existing `HasProd` declaration is the right separation;
  the surrounding q-Gamma definitions should be migrated to the same standard.
- Do not turn every finite product or elementary identity into a structure.
  Structures are justified where data persist across a limit/branch/path,
  where an algorithm needs a canonical normalized source, or where the same
  invariant is consumed by multiple downstream formulas.

## Suggested migration order

1. Split the integral declarations and introduce the shared `C1Contour`,
   vertical-line, improper-integral, and branch-lift interfaces (G5-1/G5-2).
2. Replace §5.11's two `Classical.choice` coefficient families with canonical
   finite-prefix maps (G5-3/G5-4), then migrate the ratio/asymptotic statements.
3. Repair Barnes products and Glaisher's constant (G5-5/G5-6).
4. Add q-Gamma pole-free/value and `HasSum`/`HasProd` layers (G5-7).
5. Add the reusable Chapter 2/3 finite-coefficient, regular-Gamma-point, and
   coordinate-selection vocabulary (G5-9/G5-11/G5-12), then clean definition
   panels and the extrema sequence (G5-8/G5-10/G5-13/G5-14).

This order keeps the DLMF-facing theorem names stable while migrating the
objects underneath them, and it gives later chapters the same seamless UX as
the two existing exemplars.
