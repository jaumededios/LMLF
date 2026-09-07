# Chapter 5: first-order homogeneous scalar equation

## Status and source

**Status: accepted.** The reviewed natural-language mathematics and Lean implementation close
exactly `C05-01-01`. This is not a whole-numbered-theorem credit.

Source: Frank W. J. Olver, *Asymptotics and Special Functions*, corrected
A K Peters reprint (1997) of the 1974 edition, Chapter 5, printed p. 139
(preserved DjVu p. 152), equation (1.02). The retained source has SHA-256
`ecee986dbc65c6a9d738837496772841605325dd3242b93abf025c59cfa405b1`.
The book, page rendering, and OCR remain private. This blueprint is an
original mathematical exposition.

Credit exactly the existing component `C05-01-01`: the first-order
homogeneous scalar equation has the exponential-of-an-integral general
solution. This is not a new whole numbered theorem. The explicit basepoint
form, complex-valued real-time extension, API design, and Wronskian reuse add
no further source credit.

The accepted implementation artifacts have these SHA-256 digests:

- [`LMLF/ODE/LinearFirstOrder.lean`](../../LMLF/ODE/LinearFirstOrder.lean), 123 lines:
  `e182fb2b208144d8e71e1589637524e37792f98f077bbe3645eefb16062d6718`;
- [`LMLFTest/ODE/LinearFirstOrder.lean`](../../LMLFTest/ODE/LinearFirstOrder.lean), 129 lines:
  `9fd8f13d594da5c44644cfbe36b41b1217071f5bdaf58c0ca15dc0647bfaaf12`;
- the migrated [`LMLF/ODE/Wronskian.lean`](../../LMLF/ODE/Wronskian.lean), 209 lines:
  `5b7c5bd5a28f282f65cad32bcb13fc4acb7bc92f7f26c007c7032d3e7e4f380e`;
- [`LMLF/Results.lean`](../../LMLF/Results.lean):
  `e4b274c94e41c062f9ac8d54810c8d332dbe1a4cc9fadb1469395858df6c9676`.

The fresh independent code-referee report has SHA-256
`47347470b9229e3ab47c33bf2a608399e3deb79145442886cacf04897506c449` and accepted the exact four
declarations, tests, and narrow Wronskian reuse without a finding. Root acceptance passed the full
2,780-job build, inventory and all 25 negative fixtures, clean diagnostics for the three affected
source files, and standard-axiom checks for 20 selected public declarations across the new and
dependent ODE modules.

The printed formula has the negative sign appropriate to

\[
  w'(x)+a(x)w(x)=0,
  \qquad\text{or equivalently}\qquad
  w'(x)=-a(x)w(x).
\]

It uses an indefinite integral and does not display a separate multiplier.
For a complete general-solution statement one must include an arbitrary
constant `c`: an additive constant inside a real exponential cannot represent
the zero solution or negative multiples. The page also does not restate a
continuity hypothesis or interval in the sentence containing (1.02).
Accordingly, the formal statement below is the reviewed continuous-classical
interpretation on an open real interval, not a claim that those precise
Lean-level hypotheses were printed beside the formula.

## Common setting and local FTC step

Let `I ⊆ ℝ` be open and preconnected, let `x₀ ∈ I`, and take the independent
variable to be real. The basepoint makes `I` nonempty. No boundedness is
assumed, so `I` may be a bounded open interval, a half-line, or all of `ℝ`.

For a coefficient `a` continuous on `I`, define the oriented interval
integral

\[
  A(u)=\int_{x_0}^{u}a(t)\,dt.
\]

In the complex-valued case this is the complex Bochner interval integral.
Fix `x ∈ I`. Preconnectedness in `ℝ` puts the entire unoriented closed segment
between `x₀` and `x` inside `I`. Continuity on that compact segment gives
interval integrability. Openness of `I` turns continuity on `I` into ordinary
continuity at `x` and supplies the local measurability needed by the
interval-integral fundamental theorem of calculus. Hence

\[
  A'(x)=a(x).
\]

This holds with either endpoint order because the interval integral is
oriented, and `A(x₀)=0`. Only finite segments lying in `I` are integrated.
Thus an unbounded `I` creates no improper-integral obligation, no values of
`a` outside `I` are used, and no global uniform bound is required.

All ODE hypotheses and conclusions below use pointwise `HasDerivAt` witnesses
at points of `I`. Classification is by `EqOn` on `I`; no totalized derivative
or assertion outside the ODE domain is involved.

## Real-valued formula

Assume `a : ℝ → ℝ` is continuous on `I`.

### R1. Every constant expression is a solution

For arbitrary `c : ℝ`, define

\[
  \Phi_c(u)=c\,\operatorname{Real.exp}\!\left(
    -\int_{x_0}^{u}a(t)\,dt\right)=c e^{-A(u)}.
\]

Then, at every `x ∈ I`,

\[
  \Phi_c'(x)=-a(x)\Phi_c(x),
  \qquad \Phi_c(x_0)=c.
\]

**Proof.** The local FTC step gives `A'(x)=a(x)`, so
`(-A)'(x)=-a(x)`. The exponential chain rule and multiplication by the
constant `c` give

\[
\begin{aligned}
  \Phi_c'(x)
    &=c e^{-A(x)}(-a(x))\\
    &=-a(x)\bigl(c e^{-A(x)}\bigr)
     =-a(x)\Phi_c(x).
\end{aligned}
\]

Also `A(x₀)=0`, so `\Phi_c(x₀)=c`. This includes `c=0` and all negative
real `c`. ∎

### R2. Every solution has the basepoint formula

Let `w : ℝ → ℝ` satisfy

\[
  w'(x)=-a(x)w(x) \qquad (x\in I)
\]

by pointwise derivative witnesses. Then

\[
  w(x)=w(x_0)\operatorname{Real.exp}\!\left(
    -\int_{x_0}^{x}a(t)\,dt\right)
  \qquad (x\in I).
\]

**Proof.** Set `E(u)=e^{A(u)}w(u)`. At every `x ∈ I`, the chain and
product rules give

\[
\begin{aligned}
  E'(x)
    &=e^{A(x)}a(x)w(x)+e^{A(x)}w'(x)\\
    &=e^{A(x)}\bigl(a(x)w(x)-a(x)w(x)\bigr)=0.
\end{aligned}
\]

Thus `E` is differentiable on `I` with derivative zero. Derivative-zero
constancy on an open preconnected set gives `E(x)=E(x₀)`. Since `A(x₀)=0`,

\[
  e^{A(x)}w(x)=w(x_0).
\]

Real exponential never vanishes and its inverse is `e^{-A(x)}`. Multiplying
by that inverse proves the formula on `I`. Together with R1, this classifies
the real solutions exactly by the initial value `c=w(x₀)`. ∎

## Complex-valued equation with real time

Assume `a : ℝ → ℂ` is continuous on `I`. The time variable remains real.

### C1. Every constant expression is a solution

For arbitrary `c : ℂ`, define

\[
  \Psi_c(u)=c\,\operatorname{Complex.exp}\!\left(
    -\int_{x_0}^{u}a(t)\,dt\right)=c\exp(-A(u)).
\]

Then, at every `x ∈ I`,

\[
  \Psi_c'(x)=-a(x)\Psi_c(x),
  \qquad \Psi_c(x_0)=c.
\]

**Proof.** The vector-valued local FTC step gives `A'(x)=a(x)`. The
complex exponential chain rule and multiplication by `c` yield

\[
\begin{aligned}
  \Psi_c'(x)
    &=c\exp(-A(x))(-a(x))\\
    &=-a(x)\bigl(c\exp(-A(x))\bigr)
     =-a(x)\Psi_c(x),
\end{aligned}
\]

where commutativity of complex multiplication permits the rearrangement.
The identity `A(x₀)=0` gives `\Psi_c(x₀)=c`. ∎

### C2. Every solution has the basepoint formula

Let `w : ℝ → ℂ` satisfy

\[
  w'(x)=-a(x)w(x) \qquad (x\in I)
\]

by pointwise derivative witnesses. Then

\[
  w(x)=w(x_0)\operatorname{Complex.exp}\!\left(
    -\int_{x_0}^{x}a(t)\,dt\right)
  \qquad (x\in I).
\]

**Proof.** Define `E(u)=\operatorname{Complex.exp}(A(u))w(u)`. For every
`x ∈ I`,

\[
\begin{aligned}
  E'(x)
    &=\exp(A(x))a(x)w(x)+\exp(A(x))(-a(x)w(x))\\
    &=0.
\end{aligned}
\]

Derivative-zero constancy gives `E(x)=E(x₀)` throughout `I`; hence
`\exp(A(x))w(x)=w(x₀)`. Complex exponential is nonzero and
`\exp(A(x))^{-1}=\exp(-A(x))`, which proves the stated `EqOn` formula. Thus
complex real-time solutions are classified by `c=w(x₀)`. This makes no claim
about complex-time analytic ODEs. ∎

## Accepted public API

The source-free module is [`LMLF/ODE/LinearFirstOrder.lean`](../../LMLF/ODE/LinearFirstOrder.lean),
in namespace `LMLF.ODE`. Its public surface is the following four reviewed
contracts: a solution witness and an `EqOn` classification theorem for each
of `ℝ` and `ℂ`.

The declarations are anchored at
[`hasDerivAt_const_mul_exp_neg_integral`](../../LMLF/ODE/LinearFirstOrder.lean#L31),
[`eqOn_const_mul_exp_neg_integral_of_hasDerivAt`](../../LMLF/ODE/LinearFirstOrder.lean#L45),
[`hasDerivAt_const_mul_cexp_neg_integral`](../../LMLF/ODE/LinearFirstOrder.lean#L78), and
[`eqOn_const_mul_cexp_neg_integral_of_hasDerivAt`](../../LMLF/ODE/LinearFirstOrder.lean#L92).

```lean
theorem hasDerivAt_const_mul_exp_neg_integral
    {I : Set ℝ} (hI : IsOpen I) (hIc : IsPreconnected I)
    {a : ℝ → ℝ} (ha : ContinuousOn a I)
    {x₀ : ℝ} (hx₀ : x₀ ∈ I) (c : ℝ) :
    ∀ x ∈ I,
      HasDerivAt
        (fun u ↦ c * Real.exp (-∫ t in x₀..u, a t))
        (-a x * (c * Real.exp (-∫ t in x₀..x, a t))) x

theorem eqOn_const_mul_exp_neg_integral_of_hasDerivAt
    {I : Set ℝ} (hI : IsOpen I) (hIc : IsPreconnected I)
    {a w : ℝ → ℝ} (ha : ContinuousOn a I)
    (hw : ∀ x ∈ I, HasDerivAt w (-a x * w x) x)
    {x₀ : ℝ} (hx₀ : x₀ ∈ I) :
    Set.EqOn w
      (fun x ↦ w x₀ * Real.exp (-∫ t in x₀..x, a t)) I

theorem hasDerivAt_const_mul_cexp_neg_integral
    {I : Set ℝ} (hI : IsOpen I) (hIc : IsPreconnected I)
    {a : ℝ → ℂ} (ha : ContinuousOn a I)
    {x₀ : ℝ} (hx₀ : x₀ ∈ I) (c : ℂ) :
    ∀ x ∈ I,
      HasDerivAt
        (fun u ↦ c * Complex.exp (-∫ t in x₀..u, a t))
        (-a x * (c * Complex.exp (-∫ t in x₀..x, a t))) x

theorem eqOn_const_mul_cexp_neg_integral_of_hasDerivAt
    {I : Set ℝ} (hI : IsOpen I) (hIc : IsPreconnected I)
    {a w : ℝ → ℂ} (ha : ContinuousOn a I)
    (hw : ∀ x ∈ I, HasDerivAt w (-a x * w x) x)
    {x₀ : ℝ} (hx₀ : x₀ ∈ I) :
    Set.EqOn w
      (fun x ↦ w x₀ * Complex.exp (-∫ t in x₀..x, a t)) I
```

The compact-segment FTC helper remains private. No generic
Banach-algebra wrapper, packed solution structure, or broader ODE theory is
part of this slice. A later equivalence wrapper is unnecessary unless actual
call sites justify it.

These contracts were reviewed against Lean `4.33.1` and Mathlib
`0df444a360eaa60ab8c11dca51a86af692955474`. The required interfaces are
`Set.EqOn`, `IsPreconnected.ordConnected`,
`OrdConnected.uIcc_subset`, `ContinuousOn.intervalIntegrable`,
`ContinuousOn.stronglyMeasurableAtFilter`, `ContinuousOn.continuousAt`,
`intervalIntegral.integral_hasDerivAt_right`,
`intervalIntegral.integral_same`, the `HasDerivAt` negation/product/constant
multiplication and real/complex exponential rules,
`IsOpen.is_const_of_deriv_eq_zero`, and the real/complex exponential
nonvanishing and negation identities. No matching public scalar
classification theorem was found in the pinned project or Mathlib sources.

## Accepted Wronskian reuse

The existing Abel formulas in [`LMLF/ODE/Wronskian.lean`](../../LMLF/ODE/Wronskian.lean) are now
direct consumers. All public Wronskian theorem names, binders, hypotheses, and conclusions remain
unchanged.

For the complex formula, `hasDerivAt_wronskian` already proves pointwise

\[
  W'(z)=-f(z)W(z)
\]

from the four phase-pair derivative hypotheses. Applying
`eqOn_const_mul_cexp_neg_integral_of_hasDerivAt` with coefficient `f`,
solution `W`, and basepoint `x₀`, then evaluating at `x`, gives exactly

\[
  W(x)=W(x_0)\operatorname{Complex.exp}\!\left(
    -\int_{x_0}^{x}f(t)\,dt\right).
\]

The coefficient `g` is used only in the phase equations and cancels in the
Wronskian derivative calculation. Therefore the preserved Abel theorem needs
only `ContinuousOn f I`, never continuity of `g`.

The real proof is identical: `hasDerivAt_realWronskian` supplies
`W_{\mathbb R}'=-fW_{\mathbb R}`, and the real `EqOn` theorem yields the
existing `realWronskian_eq_mul_exp_integral` conclusion without changing any
assumption or sign. The duplicated private compact-segment FTC helper was removed after both A2
bodies migrated successfully.

A1 remains the direct determinant differentiation theorem. Complex and real
A4 must also remain direct derivative-zero constancy proofs: routing A4
through the new formula would incorrectly impose continuity where the current
theorems assume only `f=0` on `I` and no continuity of `f` or `g`. The A3
theorems and equation-specific consumers continue through the frozen A2
signatures and require no mathematical change. Arbitrary first-order
solutions must not be realized artificially as Wronskians.

No other Wronskian proof body or signature changed. Future numerical use is only a design
consideration; this blueprint proposes no algorithm or stability result.

## Review provenance

This public blueprint is a concise adaptation, not a byte-for-byte copy, of
the immutable 469-line original review packet
`LMLF-review-evidence/olver-ch5-first-order-01.md` (SHA-256
`d927c9075f4008a2d5d2abc3503c15634032ac15dbbdaf2e7538a5cbd9ad1e34`).
Root read that packet in full and accepted it after two independent reviews,
identified in the review record by SHA-256 prefixes `4e623896…` and
`dec4f381…`. The adaptation preserves the accepted four-statement
mathematics, API contracts, attribution, source caveats, and dependency
boundary while omitting packet-internal audit detail.

That public pre-implementation blueprint had SHA-256
`faf62b999c73bdfd9535e209d3c42a4c04ec0e1b77816bcc53673b2a9e9820ab`. The publication edits above
record later accepted Lean evidence; they do not claim that the revised public bytes were the bytes
read by the natural-language referees.

## Coverage boundary

- This slice adds exactly `C05-01-01`; §1 now has all `11/11` claim components checked.
- The two §1 exercises remain unproved.
- At the historical principal-Gauss checkpoint `18531f4`, Chapter 5 coverage was
  `16/108 = 14.81%` claim components, `3/13 = 23.08%` whole numbered theorems, and
  `0/44 = 0%` exercises. See the [Chapter 5 checklist](chapter05.md) for current totals.
