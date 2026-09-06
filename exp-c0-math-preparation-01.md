# EXP-C0 mathematics preparation 01

## Status, snapshot, and decision

This is a read-only natural-language source-convention and pinned-Mathlib
correspondence dossier prepared 2026-09-06. `EXP-C0` is only a preproduction
label. This is not a theorem card, source manifest, source partition, production
ID allocation, signature freeze, `lean_ready` decision, fidelity approval,
implementation, or coverage evidence.

The checked LMLF snapshot is clean `main` at
`b8d2f731fcfd5cd0889d0732f13699eb94681c86`, using Lean `v4.33.1` and pinned
Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`. The recommendation is to let
ordinary source-target mappings name exact upstream declarations directly.
Do not add `LMLF.exp`, theorem aliases, or a conjunction theorem merely to raise
LMLF declaration counts. A tiny import/signature regression consumer is enough
to protect each accepted upstream interface.

## Limited source discovery and conventions

This preparation consulted the official [DLMF §4.2](https://dlmf.nist.gov/4.2)
exponential subsection and the separate addition-law lead in
[DLMF §4.8](https://dlmf.nist.gov/4.8). It records short independent
paraphrases only. The page locators and displayed equation labels below are
discovery handles, not approved canonical-document, leaf, appearance, atom, or
occurrence identities. No denominator or count follows. No source payload was
downloaded or retained; a future exact-bound audit needs an authorized evidence
route consistent with the [DLMF notices](https://dlmf.nist.gov/about/notices).

The relevant source convention is complex throughout: `z,z1,z2 : C`, `i` is
the imaginary unit, `pi` is the real circle constant embedded in `C`, `Re z` is
real part, and `|z|` is complex modulus. The source uses both `exp z` and
`e^z`; [§4.2.E32](https://dlmf.nist.gov/4.2.E32) later states the convention
identifying `e^z` with `exp z`. The eventual entity/notation view must approve
these correspondences with `Complex.exp`, `Complex.I`, `Real.pi`, `Complex.re`,
and the complex norm. The dossier does not presume that review.

Preferred core §4.2 execution family:

- [§4.2.E19](https://dlmf.nist.gov/4.2.E19): finite mandatory support identifying
  the source exponential with the pinned series-defined entity; this dossier
  does not assign it independent execution credit;
- §4.2 compound prose following E19: complex exponential is entire, has no
  real or complex zeros, and has period `2*pi*i`; these are distinct
  mathematical assertions within one prose appearance;
- [§4.2.E20](https://dlmf.nist.gov/4.2.E20): a separate displayed appearance of
  the translation equality for period `2*pi*i`;
- [§4.2.E21](https://dlmf.nist.gov/4.2.E21): negating the argument gives the
  multiplicative inverse;
- [§4.2.E22](https://dlmf.nist.gov/4.2.E22): the modulus is real exponential of
  the real part.

All are ordinary exact or structural mathematics, not asymptotic or
approximative claims. Addition at
[§4.8.E16](https://dlmf.nist.gov/4.8.E16) is an optional later add-on: it has an
exact pinned target, but introduces a second source section and the reviewed
`e^z = exp z` convention/dependency. Keeping it later makes the first execution
packet genuinely §4.2-local.

General phase (§4.2.E23), real/imaginary decomposition (§4.2.E24), and the
inverse relation using multivalued `Ln` (§4.2.E25) stay outside the first
execution subpacket. Their presence in the same selected source leaf still has
to be inventoried and dispositioned by the source audit; selecting a smaller
Lean execution subpacket does not license cherry-picking source scope or a
claim of full-leaf coverage.

E19 is not a logarithmic-inverse definition. At this pin,
`Complex.exp` is itself defined as the limit of the Cauchy sequence of partial
sums `∑ m ∈ Finset.range n, z^m / m.factorial` in
[Complex/Exponential.lean lines 50--64](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/Complex/Exponential.lean#L50-L64).
The exact reusable convergence theorem is

`NormedSpace.expSeries_div_hasSum_exp (z : ℂ) :
  HasSum (fun n : ℕ => z^n / (n.factorial : ℂ)) (NormedSpace.exp z)`

at [Normed/Algebra/Exponential.lean lines 630--641](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/Normed/Algebra/Exponential.lean#L630-L641).
Mathlib separately proves

`Complex.exp_eq_exp_ℂ : Complex.exp = NormedSpace.exp`

whose proof explicitly reconciles the Cauchy-limit definition with the
summable series at
[SpecialFunctions/Exponential.lean lines 207--213](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/SpecialFunctions/Exponential.lean#L207-L213).
Together these give the exact identification support for E19 after rewriting
the sum by `Complex.exp_eq_exp_ℂ`; factorial coercion and the harmless
`z^n / n!` versus `z^n * (n!)⁻¹` notation still require entity review. This
support is mandatory before E20--E22 can be presented as results about the
reviewed source entity, even if E19's own source-target execution status remains
separate. An equality to an unguarded `tsum` alone would be insufficient:
because Lean's `tsum` is total, carrying the existing `HasSum` evidence avoids
laundering the source's convergent-series assertion through totalization.

## Exact one-for-one Mathlib correspondence

### Entirety

Source meaning: `z ↦ exp z` is holomorphic on all of `C`. Pinned declaration:

`Complex.differentiable_exp : Differentiable ℂ Complex.exp`

at [ExpDeriv.lean lines 83--102](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/SpecialFunctions/ExpDeriv.lean#L83-L102), specialized to scalar field `ℂ`.
There are no hypotheses. A semantics reviewer must confirm that the source's
“entire” is faithfully represented by everywhere complex differentiability;
the nearby derivative theorem additionally states derivative `exp z`, but that
is not needed to discharge the entirety atom and must not gain extra credit.

### No zeros

Source meaning: for every complex `z`, `exp z` is nonzero. Pinned declaration:

`Complex.exp_ne_zero (z : ℂ) : Complex.exp z ≠ 0`

at [Exponential.lean lines 157--166](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/Complex/Exponential.lean#L157-L166).
There are no hypotheses. This single complex theorem implies the real
specialization; do not manufacture a second theorem solely because the prose
says “real or complex”. Whether the prose has one or two source atoms is an
external atomization decision, and one upstream declaration may serve both
reviewed mappings without duplicating source credit.

### Periodicity

Source meaning: translation by `2*pi*i` leaves complex exponential unchanged;
it does not say this is a least or fundamental period. Pinned declaration:

`Complex.exp_periodic : Function.Periodic Complex.exp
  (2 * (Real.pi : ℂ) * Complex.I)`

at [Trigonometric/Basic.lean lines 1201--1204](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/SpecialFunctions/Trigonometric/Basic.lean#L1201-L1204).
`Function.Periodic f c` unfolds to `∀ z, f (z+c)=f z`; thus E20 is an
application of the upstream theorem, with no source-orientation bridge and no
hypotheses. The compound prose and E20 are separate appearances. Exact source
review must decide whether the prose period statement is self-contained or only
introduces E20; genuinely repeated assertions stay distinct in the source
inventory and may both map to this same declaration, while introductory context
may share ownership. Declaration-count convenience must not decide this.

### Negative argument / inverse

Source meaning: `exp (-z)` is the reciprocal of `exp z`. Pinned declaration:

`Complex.exp_neg (z : ℂ) : Complex.exp (-z) = (Complex.exp z)⁻¹`

at [Exponential.lean lines 161--169](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/Complex/Exponential.lean#L161-L169).
There is no hypothesis. The only source-facing normalization is
`1 / exp z = (exp z)⁻¹`. Although Lean division/inversion is total, the same
file's `exp_ne_zero` proves this reciprocal has the ordinary field meaning; no
extra assumed nonzero premise should be added.

### Modulus

Source meaning: complex modulus of `exp z` equals real exponential of `Re z`.
Pinned declaration:

`Complex.norm_exp (z : ℂ) : ‖Complex.exp z‖ = Real.exp z.re`

at [Complex/Trigonometric.lean lines 983--985](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/Complex/Trigonometric.lean#L983-L985).
There are no hypotheses and no algebraic proof bridge. Exact entity review must
confirm DLMF vertical bars mean complex modulus and the RHS exponential is real,
not complex exponential applied to an implicit embedding.

### Addition (optional later add-on)

Source meaning: after the source's `e^z = exp z` convention is resolved,
`exp z1 * exp z2 = exp (z1+z2)`. Pinned declaration:

`Complex.exp_add (z1 z2 : ℂ) :
  Complex.exp (z1+z2) = Complex.exp z1 * Complex.exp z2`

at [Exponential.lean lines 110--130](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/Complex/Exponential.lean#L110-L130).
There are no hypotheses. The only mathematical bridge is symmetry of equality.
The `e^z` convention is not free: the source audit must decide whether it is a
notation association or a separately target-bearing identity and discharge the
corresponding in-range dependency without transferring credit.

## Complete natural-language bridge argument

For arbitrary `z,z1,z2 ∈ C`, first identify the source entity by the E19
`HasSum` theorem and `Complex.exp_eq_exp_ℂ` correspondence above. Periodicity,
nonvanishing, modulus, and entirety then have the same orientation and domains
as their declarations. The source
reciprocal is the notation `1/a`, which equals `a⁻¹`; instantiate `a=exp z`.
The upstream nonvanishing theorem guarantees `a≠0`, so this is the ordinary
reciprocal and the upstream inverse equality is exactly the source equality.
For addition, first apply the independently reviewed source convention replacing
each `e^w` by `exp w`. The resulting source equality is the reverse orientation
of `Complex.exp_add z1 z2`; symmetry gives it immediately. No other hypotheses,
branch choices, limit arguments, or new mathematics are required.

This paragraph is sufficient only for the orientation/notation bridges. Exact
upstream matches still need the project's source, semantics, signature, and
implementation reviews; direct Mathlib inspection is not source approval.

## Planned exact-interface regression consumers

No Lean file is authorized here. A later disposable or test-only consumer should
check precisely these expressions, without introducing public declarations:

- apply `Complex.exp_periodic` to arbitrary `z` and obtain the displayed
  translation equality;
- apply `Complex.exp_ne_zero z`;
- `simpa [one_div] using Complex.exp_neg z`;
- exact `Complex.norm_exp z`;
- optionally, in the later §4.8 add-on, use
  `(Complex.exp_add z1 z2).symm` after the reviewed `e^z` convention;
- check `(Complex.differentiable_exp : Differentiable ℂ Complex.exp)`.

The mandatory support consumer should also `#check`
`NormedSpace.expSeries_div_hasSum_exp (z : ℂ)` and
`Complex.exp_eq_exp_ℂ`. Once source/entity review freezes E19, the precise
composed target to regress is
`HasSum (fun n : ℕ => z^n / (n.factorial : ℂ)) (Complex.exp z)`.
This dossier does not attempt that Lean bridge proof.

Imports: `Mathlib.Analysis.SpecialFunctions.Exponential` supplies the E19
support pair; `Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic` supplies
periodicity, norm, and transitively the elementary exponential interfaces;
add `Mathlib.Analysis.SpecialFunctions.ExpDeriv` for entirety.
Separate disposable `lake env lean` harnesses at the stated pin already accepted
all six execution signatures, the period/inverse/norm/addition orientations,
and the two E19 support declarations. This is interface evidence only, not an
implementation or axiom audit.

## Required reviews, exclusions, and remaining gaps

Before execution, an authorized finite source batch must bind retained exact
payload evidence and actual retrieval metadata; reconcile aliases and annotated
representations; close leaf ownership and atomization; and review the compound
prose as at least distinct entirety and zero-free assertions. It must decide
whether the prose period and E20 are self-contained repeated assertions or
context plus display, preserving each genuine source appearance without
count-driven merger. It must also approve the ordinary classification,
the `exp/e^z`, complex/real, norm, real-part, `i`, and `pi` entity/notation
associations, all exact hypotheses, and this packet's finite support closure.
Only then may a target card/signature and `lean_ready` gate be considered.

Explicit exclusions expose the remaining mathematics rather than hiding it:

- E19 support has exact pinned ingredients, but its eventual source-facing
  statement and independent target/credit disposition are not frozen here;
- general phase and the inverse image formula use multivalued values and cannot
  be replaced by `Complex.arg`/`Complex.log` without branch review;
- real/imaginary decomposition has pinned support
  (`Complex.exp_eq_exp_re_mul_sin_add_cos`, `Complex.exp_re`, `Complex.exp_im`)
  but properly belongs with the trig entity packet.

This dossier changes no LMLF repository, theorem card, schema, source evidence,
CI, Verso, commit, or remote state and grants no approval or coverage credit.
