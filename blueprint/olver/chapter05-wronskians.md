# Chapter 5: Wronskian and Abel identity

This blueprint gives the approved natural-language mathematics for the first
implementation slice of Olver Chapter 5. It should be read with the
[Chapter 5 coverage checklist](chapter05.md) and the
[current project direction](../current_direction.md).

## Status and source

**Status:** the natural-language proof was approved after two independent
reviews, and the corresponding Lean implementation and both equation
consumers have passed acceptance. Root independently completed the full
project build (2,768 jobs, exit 0), all 25 negative tests plus inventory
validation, and standard-axiom-only checks for the public core and consumers.

Source: Frank W. J. Olver, *Asymptotics and Special Functions*, corrected
A K Peters reprint (1997) of the 1974 edition, Chapter 5, “Differential
Equations with Regular Singularities; Hypergeometric and Legendre Functions.”
The four source components below occur on printed p. 142, in the real-variable
section beginning on printed p. 139. The hypergeometric and associated
Legendre equations used as consumers occur on printed pp. 156 and 169.

The retained source has SHA-256
`ecee986dbc65c6a9d738837496772841605325dd3242b93abf025c59cfa405b1`.
The book, page renderings, and extracted text remain private; none is embedded
here. This chapter text is an original proof exposition.

| Checklist component | Result in this blueprint | Lean status |
|---|---|---|
| `C05-01-08` | A1, Wronskian derivative | checked: [complex](../../LMLF/ODE/Wronskian.lean#L38), [real](../../LMLF/ODE/Wronskian.lean#L154) |
| `C05-01-09` | A2, Abel basepoint formula | checked: [complex](../../LMLF/ODE/Wronskian.lean#L50), [real](../../LMLF/ODE/Wronskian.lean#L166) |
| `C05-01-10` | A3, zero/nowhere-zero alternative | checked: [complex](../../LMLF/ODE/Wronskian.lean#L100), [real](../../LMLF/ODE/Wronskian.lean#L215) |
| `C05-01-11` | A4, constant Wronskian when `f=0` | checked: [complex](../../LMLF/ODE/Wronskian.lean#L139), [real](../../LMLF/ODE/Wronskian.lean#L254) |

These are four claim components, not the whole of Theorem 1.2. In particular,
this slice does not prove the initial-value theorem or the full equivalence
between a fundamental pair, a nowhere-zero Wronskian, and linear
independence. The two equations at the end are consumers of A2 and add no
source-component credit.

## Common setting

The independent variable is real. Let `I ⊆ ℝ` be nonempty, open, and
preconnected. Thus `I` may be a bounded open interval, a half-line, or all of
`ℝ`. The reusable core permits complex coefficients and complex-valued
solutions; this includes real-coefficient equations with complex solutions
without making any claim about the complex independent-variable theory later
in the chapter.

Let `f,g : ℝ → ℂ`. Represent a second-order solution by a phase pair
`(y,v)`, where `y,v : ℝ → ℂ` and, at every `x ∈ I`, there are pointwise
derivative witnesses

\[
y'(x)=v(x), \qquad
v'(x)=-f(x)v(x)-g(x)y(x).
\]

These equations say exactly that `y` solves

\[
y''+fy'+gy=0
\]

on `I`, while avoiding any reliance on a totalized derivative outside the
domain. For two phase pairs `(y₁,v₁)` and `(y₂,v₂)`, define

\[
W(x)=y_1(x)v_2(x)-y_2(x)v_1(x).
\]

The implemented pointwise determinant definition is generic in its argument
type and in any value type having multiplication and subtraction. It therefore
supports, for example, real or complex domains and real or complex values. The
analytic A1–A4 theorems proved in this slice still have a real independent
variable, with separate complex- and real-valued versions; the generic
definition alone is not a claim of complex-time analytic Abel theory.

No continuity of `f` or `g` is needed for A1 or A4. A2 and A3 require only
`ContinuousOn f I`; continuity of `g` does not enter Abel's identity.

## Complex-valued core

### A1. Wronskian derivative

For every `x ∈ I`, `W` is differentiable at `x` and

\[
W'(x)=-f(x)W(x).
\]

**Proof.** The product and subtraction rules, followed by the two phase
systems, give

\[
\begin{aligned}
W'(x)
 &=v_1(x)v_2(x)+y_1(x)v_2'(x)
   -v_2(x)v_1(x)-y_2(x)v_1'(x)\\
 &=v_1v_2+y_1(-fv_2-gy_2)
   -v_2v_1-y_2(-fv_1-gy_1).
\end{aligned}
\]

All quantities in the last line are evaluated at `x`. Commutativity cancels
`v₁v₂-v₂v₁` and the two terms containing `g y₁y₂`. The remaining terms are

\[
-fy_1v_2+fy_2v_1=-f(y_1v_2-y_2v_1)=-fW.
\]

This calculation also supplies the required derivative witness for `W`. ∎

### A2. Abel's identity in basepoint form

Assume `f` is continuous on `I`. For every `x₀,x ∈ I`,

\[
W(x)=W(x_0)\operatorname{Complex.exp}\!\left(
  -\int_{x_0}^{x}f(t)\,dt\right).
\]

The integral is the oriented, complex-valued interval integral. The formula
therefore covers both `x<x₀` and `x>x₀`, and an unbounded `I` causes no
improper-integral obligation.

**Proof.** Fix `x₀ ∈ I` and set

\[
A(x)=\int_{x_0}^{x}f(t)\,dt.
\]

For any `x ∈ I`, preconnectedness of a subset of `ℝ` puts the entire
unoriented closed segment between `x₀` and `x` inside `I`. The restriction of
`f` to this compact segment is continuous and hence interval integrable.
Because `I` is open, continuity on `I` also gives ordinary continuity at the
variable endpoint. The local fundamental theorem of calculus gives
`A'(x)=f(x)`, with the same statement for either endpoint order.

Define the integrating-factor product

\[
E(x)=\operatorname{Complex.exp}(A(x))W(x).
\]

The exponential chain rule, product rule, `A'=f`, and A1 give

\[
E'(x)=\operatorname{Complex.exp}(A(x))
       \bigl(f(x)W(x)+W'(x)\bigr)=0
\]

at every point of `I`. A differentiable complex-valued function of a real
variable with zero derivative on an open preconnected set is constant there.
Thus `E(x)=E(x₀)`. The integral from `x₀` to itself is zero, so
`E(x₀)=W(x₀)`. Complex exponential never vanishes and
`exp(A)⁻¹=exp(-A)`; multiplying by this inverse proves the formula. ∎

### A3. Zero/nowhere-zero alternative

Under A2's hypotheses, exactly one of the following holds:

- `W(x)=0` for every `x ∈ I`;
- `W(x)≠0` for every `x ∈ I`.

Equivalently, `W(x)=0` if and only if `W(x₀)=0` for any `x,x₀ ∈ I`.

**Proof.** A2 expresses `W(x)` as `W(x₀)` multiplied by a nonzero complex
exponential. Hence their vanishing is equivalent. Fixing one basepoint gives
the dichotomy, and nonemptiness of `I` makes its alternatives mutually
exclusive. ∎

### A4. Vanishing first-derivative coefficient

If `f(x)=0` for every `x ∈ I`, then `W` is constant on `I`. No continuity of
`f` or `g` is assumed.

**Proof.** A1 gives the pointwise derivative `W'(x)=0` throughout `I`.
Derivative-zero constancy on the open preconnected set proves the result
directly. In particular, A4 does not inherit the continuity assumption of
A2. ∎

## Explicit real-valued corollaries

Let `f,g,y₁,v₁,y₂,v₂ : ℝ → ℝ`, with the same nonempty open preconnected set
`I` and the real phase equations

\[
y_i'(x)=v_i(x), \qquad
v_i'(x)=-f(x)v_i(x)-g(x)y_i(x)
\quad (i=1,2;\ x\in I).
\]

Define

\[
W_{\mathbb R}(x)=y_1(x)v_2(x)-y_2(x)v_1(x).
\]

Then:

1. without coefficient-continuity assumptions,
   \[
   W_{\mathbb R}'(x)=-f(x)W_{\mathbb R}(x)
   \quad(x\in I);
   \]
2. if `f` is continuous on `I`, then for all `x₀,x ∈ I`,
   \[
   W_{\mathbb R}(x)=W_{\mathbb R}(x_0)
   \operatorname{Real.exp}\!\left(-\int_{x_0}^{x}f(t)\,dt\right);
   \]
3. under the assumptions of item 2, `Wℝ` is identically zero or nowhere zero
   on `I`, equivalently
   \[
   W_{\mathbb R}(x)=0\iff W_{\mathbb R}(x_0)=0;
   \]
4. if `f=0` on `I`, then `Wℝ` is constant, without any continuity assumption
   on `f` or `g`.

The proof of item 1 is the A1 calculation in `ℝ`, and item 4 follows directly
from it. For item 2, the same compact-segment and oriented-FTC argument gives
`A'=f`; differentiating `Real.exp(A)Wℝ` makes it constant. Since real
exponential never vanishes and has inverse `Real.exp(-A)`, the stated formula
follows. Item 3 follows from that nonzero factor. This direct proof avoids an
unnecessary scalar abstraction; alternatively, all four statements can be
transported through the canonical inclusion `ℝ → ℂ`.

## Consumer C1: hypergeometric equation on `(0,1)`

Choose real parameters `a,b,c` and put

\[
d=c-a-b-1.
\]

The normalized hypergeometric equation has real coefficients

\[
f_{\mathbb R}(t)=\frac{c-(a+b+1)t}{t(1-t)},
\qquad
g_{\mathbb R}(t)=-\frac{ab}{t(1-t)}.
\]

For complex-valued solutions, put
`fℂ(t)=ofReal(fℝ(t))` and `gℂ(t)=ofReal(gℝ(t))`. Assume two complex phase pairs
satisfy, for every `t∈(0,1)`,

\[
y_i'(t)=v_i(t), \qquad
v_i'(t)=-f_{\mathbb C}(t)v_i(t)-g_{\mathbb C}(t)y_i(t).
\]

For `x₀,x∈(0,1)`, every point of the segment between them has `t>0` and
`1-t>0`. Thus the rational coefficients are continuous there, denominators do
not vanish, and all logarithms below have positive arguments. Define

\[
F(t)=c\log t-d\log(1-t).
\]

The derivative and partial fraction calculation is

\[
\begin{aligned}
F'(t)
 &=\frac c t+\frac d{1-t}\\
 &=\frac{c(1-t)+dt}{t(1-t)}
  =\frac{c+(d-c)t}{t(1-t)}
  =\frac{c-(a+b+1)t}{t(1-t)}
  =f_{\mathbb R}(t).
\end{aligned}
\]

Oriented FTC therefore gives, for either order of `x` and `x₀`,

\[
\int_{x_0}^{x}f_{\mathbb R}(t)\,dt
=c\log\!\left(\frac{x}{x_0}\right)
-d\log\!\left(\frac{1-x}{1-x_0}\right).
\]

Both ratios are positive. Using positive-base real powers
`r^q=Real.exp(q log r)` yields

\[
\operatorname{Real.exp}\!\left(
-\int_{x_0}^{x}f_{\mathbb R}(t)\,dt\right)
=\left(\frac{x}{x_0}\right)^{-c}
 \left(\frac{1-x}{1-x_0}\right)^d.
\]

The canonical inclusion `ofReal : ℝ → ℂ` is continuous and real-linear, so it
commutes with the oriented Bochner interval integral:

\[
\int_{x_0}^{x}f_{\mathbb C}(t)\,dt
=\operatorname{ofReal}\!\left(
  \int_{x_0}^{x}f_{\mathbb R}(t)\,dt\right).
\]

It also satisfies

\[
\operatorname{Complex.exp}(\operatorname{ofReal}(u))
=\operatorname{ofReal}(\operatorname{Real.exp}(u)).
\]

Applying A2 gives the concrete complex-valued Wronskian law

\[
W(x)=W(x_0)\operatorname{ofReal}\!\left(
\left(\frac{x}{x_0}\right)^{-c}
\left(\frac{1-x}{1-x_0}\right)^{c-a-b-1}
\right).
\]

The nonzero zeroth-order coefficient `g` has disappeared because A1 cancels
it, not because the consumer set it to zero.

The accepted Lean consumer is
[`hypergeometric_wronskian`](../../LMLFTest/ODE/Wronskian.lean#L87).

## Consumer C2: associated Legendre equation on `(-1,1)`

Choose complex parameters `μ,ν` and complex-valued solutions. After division
by `1-t²`, the first- and zeroth-order coefficients are

\[
f_{\mathbb C}(t)=\operatorname{ofReal}\!\left(
  \frac{-2t}{1-t^2}\right),
\qquad
g_{\mathbb C}(t)=
 \frac{\nu(\nu+1)}{1-t^2}-\frac{\mu^2}{(1-t^2)^2},
\]

where the real denominators in the second expression are included in `ℂ`.
Assume two complex phase pairs satisfy

\[
y_i'(t)=v_i(t), \qquad
v_i'(t)=-f_{\mathbb C}(t)v_i(t)-g_{\mathbb C}(t)y_i(t)
\]

at every `t∈(-1,1)`.

Fix `x₀,x∈(-1,1)`. On the entire segment between them,

\[
1-t^2=(1-t)(1+t)>0.
\]

Thus all denominators are nonzero, the first-derivative coefficient is
continuous, and

\[
F(t)=\log(1-t^2)
\]

is defined there with

\[
F'(t)=\frac{-2t}{1-t^2}=:f_{\mathbb R}(t).
\]

The oriented FTC and positivity give

\[
\int_{x_0}^{x}f_{\mathbb R}(t)\,dt
=\log(1-x^2)-\log(1-x_0^2)
\]

and hence

\[
\operatorname{Real.exp}\!\left(
-\int_{x_0}^{x}f_{\mathbb R}(t)\,dt\right)
=\frac{1-x_0^2}{1-x^2}.
\]

The same real-linear integral bridge and exponential compatibility used in
C1 show that

\[
\operatorname{Complex.exp}\!\left(
-\int_{x_0}^{x}f_{\mathbb C}(t)\,dt\right)
=\operatorname{ofReal}\!\left(\frac{1-x_0^2}{1-x^2}\right).
\]

Therefore A2 yields

\[
W(x)=W(x_0)\operatorname{ofReal}\!\left(
  \frac{1-x_0^2}{1-x^2}\right).
\]

The genuinely complex parameters `μ,ν` occur only in `gℂ`, so their
disappearance is a direct test of the reusable cancellation in A1.

The accepted Lean consumer is
[`associatedLegendre_wronskian`](../../LMLFTest/ODE/Wronskian.lean#L149).

## Review provenance

The approved blueprint consolidates the following immutable, project-authored
evidence. Hashes are SHA-256 values.

| Evidence | SHA-256 |
|---|---|
| Original core proof packet | `9037ccfcfb74c05daff0e54094577510390bc91870292abe5e0bbb2a5e61b386` |
| Real-specialization and consumer addendum | `8c08b8947259d27311a985fafd5647fda7a6870259086224e48e5d73485389fb` |
| Independent core referee A report | `ae244b08a201815c724cb6421832b0e2a98f6383e188d1b0810531cf19b5b846` |
| Independent core referee B report | `94df244b736bd383bd14a627b40c5710df6f69b6023c02f1ce0c6cf9e913a362` |
| Independent addendum referee A report | `7c9446dcf8bc98e4cc51d27f430cc4baa4bd9f11bad357572542350f55809a68` |
| Independent addendum referee B report | `415f077d69aa2b08092808f58db73e7e4983be60791b5a93838d69c68ca1e5e9` |
| A/B comparison report | `4a1e5a094b1f4a2a63d97b4e7f07a2f23a390c13d86f33eaf24728b3e4cdf716` |
| Final integration-delta referee report | `83d1a686c55bf5d6370a04ae4439d2d36900e533e1f47936b0cb0698572ef11f` |
| Accepted core Lean file | `091295aafbab1741be0dc4f27cadf14ee24d59f23d4e6811d653edaf11a43e9d` |
| Accepted equation-consumer Lean file | `e989775024b550f136ae38484cd277aa178c5f679001b132faa5baee78713646` |

Both addendum referees approved the complex core, the fully quantified real
corollaries, and both consumers without further mathematical amendment. The
accepted implementation realizes exactly those four source components; it
does not change the coverage boundary stated above.
