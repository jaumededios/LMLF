# Chapter 5: global linear initial-value theorem

**Status:** Accepted. Two fresh natural-language reviews approved this proof, and a fresh
independent code review accepted the Lean implementation without findings. The implementation and
its local verification check `C05-01-02`, `C05-01-03`, and the whole of Theorem 1.1.

## Source and review record

Source: Frank W. J. Olver, *Asymptotics and Special Functions*, corrected A K Peters reprint
(1997) of the work first published in 1974, Chapter 5, Theorem 1.1, printed pp. 139--141. The
retained source has SHA-256
`ecee986dbc65c6a9d738837496772841605325dd3242b93abf025c59cfa405b1`.
This page contains original mathematical exposition only; it includes no scan, OCR, or page
rendering from the book.

This public page consolidates the approved 552-line natural-language packet with SHA-256
`d06b1b722409ca10ce21984e1628c3a655a83df999e4ab8cf2d7575c05b11ad1`. Two fresh independent
reviews approved that exact packet without mathematical changes:

- review A, SHA-256
  `15a453c836d5f48b93d8431e6149c1b6faf8421095fe59995fb759e7cd123f6c`;
- review B, SHA-256
  `c71a46ccbe1deade8ab956067e0c2c9ae05b24922a1f8500e38d2afa4af7c16b`.

The fresh independent Lean code review accepted the implementation without findings; its report
has SHA-256
`dee4f39774a6d60436ea0f2917ef2e39abe7361df809cfd654e436c5531b32b3`.
The frozen accepted implementation artifacts have these SHA-256 digests:

- `LMLF/ODE/LinearSecondOrder.lean`:
  `ff845560c0122975065c4f75a6e4895574a065091cd38f033f9ae48154356aba`;
- `LMLFTest/ODE/LinearSecondOrder.lean`:
  `e429829f0c0aeb3d42413b27e9e7076f1794b61d4227145ad6234bd6638f723a`;
- `LMLF/Results.lean`:
  `8c67c5df1460bb434af72a2c8dd5c0c1b2a43786593a45aa4e706838c4e3f8d4`;
- `lakefile.toml`:
  `7e7bccdb025e3c19eb6a2a5a6dee011981df4d8f5baa71ebb00ac2666de384e3`.

Local acceptance independently passed the full `lake build` (2,776 jobs), repository inventory
validation and all 25 negative fixtures, clean full-file diagnostics, and the standard-axiom
checks for all six public declarations and both consumers.

The source theorem concerns a homogeneous second-order equation on a finite or infinite open real
interval. It says that continuous coefficients give infinitely many twice continuously
differentiable solutions, and that arbitrary prescribed values of the solution and its first
derivative at any point determine one solution uniquely.

In the [Chapter 5 checklist](chapter05.md), this theorem is represented by
`C05-01-02` and `C05-01-03`. Both rows and the whole numbered theorem are checked. The previously
checked Wronskian rows remain `C05-01-08`--`C05-01-11`; this page does not claim the full
fundamental-pair equivalence in Theorem 1.2.

## Source-to-Lean correspondence

The accepted public API exposes both source-shaped and reusable phase-shaped forms over the two
concrete scalar fields:

- complex phase IVP: [`exists_unique_complexLinearIVP`](../../LMLF/ODE/LinearSecondOrder.lean#L761);
- real phase IVP: [`exists_unique_realLinearIVP`](../../LMLF/ODE/LinearSecondOrder.lean#L778);
- complex source-form `C²` IVP: [`exists_unique_complexSecondOrderLinear`](../../LMLF/ODE/LinearSecondOrder.lean#L829);
- real source-form `C²` IVP: [`exists_unique_realSecondOrderLinear`](../../LMLF/ODE/LinearSecondOrder.lean#L847);
- infinitely many complex `C²` solutions: [`infinite_complexSecondOrderLinearSolutions`](../../LMLF/ODE/LinearSecondOrder.lean#L890);
- infinitely many real `C²` solutions: [`infinite_realSecondOrderLinearSolutions`](../../LMLF/ODE/LinearSecondOrder.lean#L900).

The required cross-module reuse is checked by
[`complexCanonicalLinearIVP_wronskian_ne_zero`](../../LMLFTest/ODE/LinearSecondOrder.lean#L16) and
[`realCanonicalLinearIVP_wronskian_ne_zero`](../../LMLFTest/ODE/LinearSecondOrder.lean#L38).

## Statement in phase form

Let `I ⊆ ℝ` be nonempty, open, and preconnected. Thus `I` is an arbitrary nonempty open real
interval: it may be bounded, a half-line, or all of `ℝ`. Let `𝕂` be either `ℝ` or `ℂ`, and let

\[
  f,g:\mathbb R\longrightarrow\mathbb K
\]

be continuous on `I`. Fix `x₀∈I` and arbitrary `a₀,a₁∈𝕂`.

There exist functions `y,v:ℝ→𝕂` such that

\[
  y(x_0)=a_0,\qquad v(x_0)=a_1,                              \tag{1}
\]

and, at every `x∈I`, they have the pointwise derivatives

\[
  y'(x)=v(x),\qquad
  v'(x)=-f(x)v(x)-g(x)y(x).                                  \tag{2}
\]

If `ỹ,ṽ:ℝ→𝕂` satisfy the same phase equations and the same initial values, then

\[
  y=\widetilde y\text{ on }I,
  \qquad
  v=\widetilde v\text{ on }I.                               \tag{3}
\]

The equalities in (3) are equalities on `I`, not equalities of ambient functions on all of `ℝ`.
Values outside the differential equation's domain are irrelevant.

The theorem is to be available explicitly in both of the following forms:

1. `f,g,y,v` are complex-valued, while the independent variable remains real;
2. `f,g,y,v` are real-valued, which is the direct source specialization.

The complex-valued form is a conservative extension useful for the existing Wronskian API. It is
not a result about a complex independent variable.

## First-order state system

For either concrete scalar field put

\[
  E=\mathbb K\times\mathbb K,
  \qquad X=(y,v),
\]

with the product sup norm, and define

\[
  F(t,(y,v))=(v,-f(t)v-g(t)y).                               \tag{4}
\]

Then the state equation `X'=F(t,X)` is exactly (2).

Fix a nonempty compact interval `J=[A,B]⊆I`. Continuity gives finite nonnegative bounds

\[
  \lVert f(t)\rVert\le M_f,
  \qquad
  \lVert g(t)\rVert\le M_g
  \quad(t\in J).
\]

Set

\[
  K=1+M_f+M_g>0.                                             \tag{5}
\]

For states `Z=(z₁,z₂)` and `W=(w₁,w₂)`, let

\[
  D=\lVert Z-W\rVert
   =\max(\lVert z_1-w_1\rVert,\lVert z_2-w_2\rVert).
\]

Then

\[
\begin{aligned}
 \lVert F(t,Z)-F(t,W)\rVert
 &=\max\bigl(\lVert z_2-w_2\rVert,
   \lVert-g(t)(z_1-w_1)-f(t)(z_2-w_2)\rVert\bigr)\\
 &\le \max(D,(M_g+M_f)D)\\
 &\le K D.                                                   \tag{6}
\end{aligned}
\]

Thus `F(t,·)` is globally `K`-Lipschitz and hence is `K`-Lipschitz on every state ball. For every
fixed state `Z`, the map `t↦F(t,Z)` is continuous on `J`. Since `F(t,0)=0`, equation (6) also gives

\[
  \lVert F(t,Z)\rVert\le K\lVert Z\rVert.                   \tag{7}
\]

No differentiability of the coefficients has been used.

## A uniform local time step

Let `c∈J`, let `X_c∈E` be any state, and suppose `[c-d,c+d]⊆J`. Put

\[
  R=1+\lVert X_c\rVert>0,
  \qquad
  L=2KR.                                                      \tag{8}
\]

If `Z` is in the closed radius-`R` ball about `X_c`, then

\[
\begin{aligned}
 \lVert Z\rVert
 &\le \lVert Z-X_c\rVert+\lVert X_c\rVert\\
 &\le R+\lVert X_c\rVert\\
 &\le 2R.
\end{aligned}
\]

Consequently (7) gives `‖F(t,Z)‖≤L` on the time slab and state ball. Use the local
Picard--Lindelöf parameters

\[
  a=R,\qquad r=0,\qquad L=2KR,
\]

and the state Lipschitz constant `K`. If

\[
  0<d\le\frac1{2K},                                          \tag{9}
\]

then

\[
 L\max((c+d)-c,c-(c-d))=Ld\le R=a-r.                        \tag{10}
\]

The local theorem's four obligations are therefore all satisfied: (6) supplies state
Lipschitzness, fixed-state time continuity was proved above, (7)--(8) supply the vector-field norm
bound on the state ball, and (10) is the time-radius inequality. Local Picard--Lindelöf existence
produces `X:ℝ→E` with `X(c)=X_c` and

\[
  X'(t)=F(t,X(t))
\]

as a derivative within `[c-d,c+d]`. At each `t∈(c-d,c+d)`, the closed interval is a neighborhood
of `t`, so this becomes an ordinary pointwise derivative.

The decisive feature is that the permitted upper bound `1/(2K)` for `d` is independent of the
current state. The state ball and the norm bound both scale through `R`, so no a priori bound on a
future trajectory is being assumed.

## Existence on a bounded window

Fix

\[
  p<x_0<q,
  \qquad [p,q]\subseteq I.
\]

Openness and preconnectedness let us choose

\[
  A<p<x_0<q<B,
  \qquad [A,B]\subseteq I.                                  \tag{11}
\]

Indeed, choose a point of `I` just to the left of `p` and another just to the right of `q`.
Preconnectedness of a subset of `ℝ` puts the closed segment between them in `I`.

Use the coefficient bounds on `[A,B]` to obtain `K` as in (5). Define

\[
  \mu=\min(p-A,B-q)>0,
  \qquad
  d=\min\left(\frac\mu2,\frac1{4K}\right)>0.                \tag{12}
\]

Every radius-`d` slab centered in `[p,q]` is contained in `[A,B]`, and `d≤1/(2K)`. Hence the
uniform local construction applies at every center in `[p,q]` and at every state.

Choose finite meshes from `x₀` to `q` and from `x₀` to `p`, with every mesh spacing strictly less
than `d`. Such meshes exist by the Archimedean property. Begin with state `(a₀,a₁)` at `x₀` and
construct its local solution on the radius-`d` slab.

Proceed recursively to the right. If a local solution has been constructed at center `cᵢ`, use
its value at the next center `cᵢ₊₁` as the initial state for a new local solution there. The next
center lies strictly inside the old slab because the spacing is less than `d`. Continue finitely
until the center `q` is reached. Repeat the construction to the left, starting from the same
initial slab and ending at center `p`.

### Compatibility on overlaps

For adjacent rightward centers `cᵢ<cᵢ₊₁`, the open slabs overlap in

\[
  (c_{i+1}-d,c_i+d).
\]

The new center `cᵢ₊₁` lies strictly inside this overlap. Both local solutions satisfy the same
state equation there and agree at `cᵢ₊₁` by construction. Equation (6) supplies a single state
Lipschitz constant, and the state domain is all of `E`. Open-interval ODE uniqueness therefore
makes the two local solutions equal on the overlap. For adjacent leftward centers
`cᵢ₊₁<cᵢ`, the same argument uses `(cᵢ-d,cᵢ₊₁+d)` and initial time `cᵢ₊₁`.

Every hypothesis of uniqueness is now visible: the overlap is an explicit open interval, its
initial time is interior, the vector field is Lipschitz there, both trajectories have ordinary
pointwise derivatives there, state membership is automatic, and the recursively chosen initial
states agree.

List all centers in increasing order. Their open slabs cover `[p,q]`. If a point belongs to slabs
at centers `cᵢ` and `cⱼ`, it belongs to every slab at an intermediate center: its distance to an
intermediate center is no larger than the greater of its distances to the two extreme centers.
Chaining adjacent compatibility therefore proves that every local solution whose slab contains
the point has the same value there.

Select any containing slab at each point of `[p,q]` and define the window solution from its local
solution. Compatibility makes the value independent of that selection. More strongly, on the
intersection of `(p,q)` with any fixed local slab, the selected function equals that local
solution pointwise. It therefore agrees with a genuine local solution throughout an open
neighborhood of each point and inherits its derivative.

No derivative is pasted from two one-sided endpoint derivatives. Every possible seam is covered by
an open neighborhood on which the glued function equals one ordinary local solution. We obtain

\[
  X_{p,q}(x_0)=(a_0,a_1),
  \qquad
  X_{p,q}'(t)=F(t,X_{p,q}(t))\quad(t\in(p,q)).                \tag{13}
\]

This is a finite construction, not an appeal to a maximal-solution or continuation theorem.

## Compatibility of bounded-window solutions

Consider all pairs `(p,q)` satisfying

\[
  p<x_0<q,
  \qquad [p,q]\subseteq I.
\]

Choose one window solution `X_{p,q}` satisfying (13) for each pair. Given two windows `(p,q)` and
`(p',q')`, their open intersection is

\[
  (p,q)\cap(p',q')
  =\bigl(\max(p,p'),\min(q,q')\bigr),                         \tag{14}
\]

and contains `x₀`. Its closed hull is compact and contained in `I`. Bound `f` and `g` on that
closed hull and obtain a state Lipschitz constant from (6). The two window solutions solve the
same equation on (14) and have the same state `(a₀,a₁)` at the interior point `x₀`. Open-interval
uniqueness gives

\[
  X_{p,q}=X_{p',q'}
  \quad\text{on }(p,q)\cap(p',q').                            \tag{15}
\]

This rebounding step is essential: on an unbounded `I`, the coefficients need not have one global
bound or one global Lipschitz constant.

## Global existence on the open interval

For every `x∈I`, there is a window `(pₓ,qₓ)` of the preceding kind with `x∈(pₓ,qₓ)`. Indeed,
`min(x,x₀)` and `max(x,x₀)` belong to `I`. Openness gives a point of `I` strictly to the left of
the minimum and a point strictly to the right of the maximum; preconnectedness contains the closed
segment between them.

Choose one such window for every `x∈I` and define

\[
  X(x)=X_{p_x,q_x}(x)\quad(x\in I),                           \tag{16}
\]

with an arbitrary value outside `I`. Fix `x∈I`. For every `u∈(pₓ,qₓ)`, the selected window for
`u` and the fixed window `(pₓ,qₓ)` both contain `x₀` and `u`. Compatibility (15) gives

\[
  X(u)=X_{p_u,q_u}(u)=X_{p_x,q_x}(u).                         \tag{17}
\]

Thus `X` agrees with one fixed window solution on the entire open neighborhood `(pₓ,qₓ)` of `x`.
It inherits that solution's ordinary derivative:

\[
  X'(x)=F(x,X(x)).                                            \tag{18}
\]

Every window has the prescribed state at `x₀`, so `X(x₀)=(a₀,a₁)`. Applying the two coordinate
projections to (18) gives (1)--(2). This proves existence on the whole of `I`, including a
half-line or all of `ℝ`, without a countable exhaustion, endpoint limit, global growth bound, or
unstated continuation premise.

## Global uniqueness on the open interval

Let `X, X̃:ℝ→E` solve the state equation on `I` and have the same state at `x₀`. Fix `x∈I`.
Choose `p,q` such that

\[
  p<\min(x,x_0)\le\max(x,x_0)<q,
  \qquad [p,q]\subseteq I.                                  \tag{19}
\]

Compact coefficient bounds on `[p,q]` give one state Lipschitz constant through (6). On the open
interval `(p,q)`, both trajectories have ordinary pointwise derivatives, both lie in the full
state space, and they agree at the interior initial time `x₀`. Open-interval uniqueness gives
`X=X̃` throughout `(p,q)`, and in particular at `x`. Since `x` was arbitrary,

\[
  X=\widetilde X\text{ on }I.                                \tag{20}
\]

Projecting (20) proves both equalities in (3). Nothing is asserted outside `I`.

## Recovery of the scalar `C²` theorem

Write `X=(y,v)`. The first phase equation makes `y` differentiable on `I` and identifies
`deriv y=v` there. The second makes `v` differentiable and identifies its derivative with

\[
  h(x)=-f(x)v(x)-g(x)y(x).                                   \tag{21}
\]

Pointwise differentiability makes `y` and `v` continuous on `I`. Together with continuity of
`f` and `g`, equation (21) makes `h` continuous. Hence `v` is `C¹` on `I`: it is differentiable
and its derivative is the continuous function `h`. Since `y` is differentiable and its derivative
is the `C¹` function `v`, the function `y` is `C²` on `I`.

Because `I` is open, the equality `deriv y=v` holds on a neighborhood of every point of `I`.
The derivative witness for `v` therefore transfers locally to `deriv y`, giving

\[
  (\operatorname{deriv}y)'(x)
  =-f(x)\operatorname{deriv}y(x)-g(x)y(x)
  \quad(x\in I).                                             \tag{22}
\]

Equivalently,

\[
  y''+fy'+gy=0
\]

on `I`. At the basepoint,

\[
  y(x_0)=a_0,
  \qquad
  \operatorname{deriv}y(x_0)=v(x_0)=a_1.                    \tag{23}
\]

For scalar uniqueness, let `ỹ` be any other `C²` function satisfying (22)--(23), and put
`ṽ=deriv ỹ`. Differentiability of `ỹ` supplies the first phase equation for `(ỹ,ṽ)`, while its
second-order equation supplies the second. Phase uniqueness (20) gives

\[
  y=\widetilde y\text{ on }I,
  \qquad
  \operatorname{deriv}y=\operatorname{deriv}\widetilde y
  \text{ on }I.                                              \tag{24}
\]

This recovers the full source formulation, not merely uniqueness conditional on an independently
given velocity function.

The same argument proves the explicit complex-valued and real-valued versions. In each version,
the regularity is `C²` with respect to the real independent variable.

## Infinitely many solutions

Choose `x₀∈I`, possible because `I` is nonempty. For each `c∈𝕂`, apply the IVP theorem with

\[
  y_c(x_0)=c,
  \qquad
  y_c'(x_0)=0.                                                \tag{25}
\]

Choose one resulting solution `y_c`. If `c≠d`, then `y_c(x₀)≠y_d(x₀)`, so `y_c` and `y_d` are
distinct functions. Thus `c↦y_c` injects the infinite field `𝕂` into the set of global `C²`
solutions on `I`. The equation therefore has infinitely many solutions, separately over `ℝ` and
over `ℂ`. This conclusion uses only Theorem 1.1 and does not assume the fundamental-pair theorem.

## Actual Wronskian reuse target

The phase output is intentionally aligned with the accepted
[Wronskian and Abel API](chapter05-wronskians.md). Fix `x₀∈I` and construct two complex solutions
with initial phase states

\[
  (y_1(x_0),v_1(x_0))=(1,0),
  \qquad
  (y_2(x_0),v_2(x_0))=(0,1).                                \tag{26}
\]

Their phase equations are exactly the hypotheses of `wronskian_eq_zero_iff`. At the basepoint,

\[
  W(x_0)=y_1(x_0)v_2(x_0)-y_2(x_0)v_1(x_0)=1.               \tag{27}
\]

For every `x∈I`, the zero-equivalence theorem says

\[
  W(x)=0\iff W(x_0)=0.
\]

Equation (27) makes the right side false, so `W(x)≠0` throughout `I`. The real IVP theorem and
`realWronskian_eq_zero_iff` give the identical real-valued consumer. The accepted implementation
tests call those existing declarations rather than reprove Abel's identity.

This consumer checks real and complex phase conventions and genuine reuse across the two public
ODE modules. It is not itself new source coverage, and it proves only the canonical pair's
nonvanishing Wronskian, not the full three-way equivalence of Theorem 1.2.

## Coverage boundary

- Natural-language mathematics completed here: `C05-01-02` and `C05-01-03`.
- Checked Lean coverage: `C05-01-02`, `C05-01-03`, and the whole of `T05-1.1`.
- Current Chapter 5 checked claim-component count: `16/108 = 14.81%`.
- Current whole-numbered-theorem count: `3/13 = 23.08%`.
- Current exercise count: `0/44 = 0%`.
- Theorem 1.2 is now independently accepted and documented in the
  [fundamental-pair blueprint](chapter05-fundamental-pairs.md); none of its additional credit is
  claimed by this historical Theorem 1.1 slice.
- The later [first-order](chapter05-first-order.md),
  [local Gauss-series](chapter05-hypergeometric-series.md),
  [local Gauss-ODE](chapter05-hypergeometric-ode.md), and
  [exceptional-shift](chapter05-hypergeometric-exceptional-shift.md) slices are also independently
  accepted; their four claim-component credits likewise do not belong to this page.
