# Chapter 5: the principal Gauss function on the cut plane

## Status, source, and exact boundary

**Status: mathematics and Lean implementation accepted.** Two fresh independent reviews read the
complete 784-line construction. Each found the same namespace-only error in the pinned Pochhammer
API; each then independently accepted the exact two-occurrence correction. Root accepted the
corrected natural-language proof before Lean implementation began. After implementation, a
separate fresh code referee read the full core and downstream source and tests and returned
`ACCEPT` with no actionable finding; Root then accepted the Lean milestone after full code/test
and fresh code-report reads. The accepted public boundary is exactly the sixteen core declarations
and four downstream declarations recorded in Section 12.

The accepted natural-language packet has SHA-256
`861682197bc45d153735783ccd6650968a847b663146ff5b2541921752e17abb`. The two full independent
review reports have digests
`e2903f43eb0dbe2a570978ff3583e79372c349eae95ad267821c1beb58c39aeb` and
`ac3386ee01da03a4bb5c2cedf47ff63363eff206835518f225490c78be9a41ec`; their exact-repair ACCEPT
signoffs have digests
`5376c2d02ab8f91582a11c08f01749c7a38158c73279cc240d48f1c6448b77ae` and
`862ada53194bef4424da0fa721e7a298bdb44f59d98055e30122e586570ff003`. Those signoffs bind the
repaired packet, not an earlier design. The fresh code-referee report has digest
`2c896e03928b7bf0702e46a739c4a1923ee7187d21fd9189357091fbb151a8df`.

The accepted implementation and consumer bytes are:

- [the 747-line core](../../LMLF/ODE/Hypergeometric/Principal.lean), SHA-256
  `932d118bbdb2b4d483e56e230f0812f87626c28d96ead937aa9543a8ae4e3cf8`;
- [its 214-line focused test](../../LMLFTest/ODE/Hypergeometric/Principal.lean), SHA-256
  `3222f453748da05b8dcd0325bfda154da1e5f6b11fc53cff95eb661156dc4aa6`;
- [the 159-line downstream result leaf](../../LMLF/Results/HypergeometricPrincipal.lean), SHA-256
  `6ab3a61e7c9f8895cc02a4be275ab49729afce9c6f129d1c8467ebf934a2a130`;
- [its 172-line focused test](../../LMLFTest/Results/HypergeometricPrincipal.lean), SHA-256
  `d9aea14273e6f43a52a925b05aea5471327c012766f012ae1545f620b5b13f33`.

The toolchain remains Lean `v4.33.1` with Mathlib
`0df444a360eaa60ab8c11dca51a86af692955474`. This page binds the reviewed file bytes above, not
an in-flight commit. The accepted integration wiring has SHA-256
`8d92cec2598856f2a7a5b73714ec5d8e80d77a1f2a5ce3ad682dbe975e062874` for
[`LMLF/Results.lean`](../../LMLF/Results.lean) and
`a893e442c2d374409ed696a64e66aae2e79f898bf0f89ad89acdaf19378de792` for
[`lakefile.toml`](../../lakefile.toml). No GitHub CI was dispatched; acceptance is based on the
local verification recorded in Section 13.

Source: Frank W. J. Olver, *Asymptotics and Special Functions*, corrected A K Peters reprint
(1997) of the 1974 edition, Chapter 5, printed p. 159 (preserved DjVu p. 172). That page first
gives the Gamma-regularized local Gauss series, including its exceptional-denominator shift, and
then defines exterior values by analytic continuation; deletion of the real ray from `1` to
`+∞` selects the principal branch. The separate parameter-entireness result begins on printed
p. 160. This page is original mathematical exposition of the principal-cut construction.

The accepted result is a Gamma-regularized principal Gauss function for every
`a,b,c : ℂ`, holomorphic on the plane cut along `[1,∞)`, together with the ordinary function
obtained from it by Gamma scaling. On the cut it retains the existing ambient regularized-series
value. It includes exceptional parameters `c=-N` and the cases in which numerator termination
makes the regularized solution identically zero.

This is nevertheless only one named-function milestone inside `C05-09-04`. It does not prove
local continuation across an interior point of the chosen cut, classify the singularities at
`1` or infinity, or formulate the parameter-qualified singular behavior of a nonprincipal branch
at `0`. It proves no part of Theorem 3.2 or Theorem 9.1 and makes no claim about parameter
entireness, transformations, monodromy classification, or numerical algorithms. In particular,
there is no proposed general `z=1` value theorem: that point is outside the principal domain and
belongs to a later checkpoint. The ambient fallback below merely leaves that checkpoint possible.
The single terminating compatibility check at `z=1` earns no `C05-09-08` credit.

At the historical principal-Gauss checkpoint `18531f4`, Chapter 5 coverage was
`16/108 = 14.81%` claim components, `3/13 = 23.08%` whole numbered theorems, and
`0/44 = 0%` exercises. This accepted partial milestone did not change any coverage count or
complete source row `C05-09-04`. See the [Chapter 5 checklist](chapter05.md) for current totals.

## 1. The principal domain and its three-chart cover

All order intervals in this construction use Mathlib's `ComplexOrder`. In that order,

\[
 z\le w
 \quad\Longleftrightarrow\quad
 \operatorname{Re}z\le \operatorname{Re}w
 \qquad\text{and}\qquad
 \operatorname{Im}z=\operatorname{Im}w.
\]

Consequently, when `r` is real,

\[
\begin{aligned}
 z\in\operatorname{Ici}(r:\mathbb C)
 &\Longleftrightarrow
   \operatorname{Im}z=0\ \text{and}\ r\le\operatorname{Re}z,\\
 z\in\operatorname{Iic}(r:\mathbb C)
 &\Longleftrightarrow
   \operatorname{Im}z=0\ \text{and}\ \operatorname{Re}z\le r.
\end{aligned}                                                \tag{1}
\]

Thus these intervals are real rays. They must not be interpreted as coordinate half-planes.
Define

\[
\begin{aligned}
 D   &:=\operatorname{Ici}(1:\mathbb C)^c,\\
 B_0 &:=\operatorname{ball}(0,1),\\
 A   &:=\operatorname{Iic}(0:\mathbb C)^c
        \cap\operatorname{Ici}(1:\mathbb C)^c,\\
 B   &:=\operatorname{Ici}(0:\mathbb C)^c.
\end{aligned}                                                \tag{2}
\]

The coordinate descriptions are

\[
\begin{aligned}
 D&=\{z:\operatorname{Im}z\ne0\ \text{or}\ \operatorname{Re}z<1\},\\
 A&=\{z:\operatorname{Im}z\ne0\ \text{or}\ 0<\operatorname{Re}z<1\},\\
 B&=\{z:\operatorname{Im}z\ne0\ \text{or}\ \operatorname{Re}z<0\}.
\end{aligned}                                                \tag{3}
\]

Hence `D` is exactly the plane with the real ray `[1,∞)` removed. It is not Mathlib's standard
negative-axis slit plane. In particular, the identity identifying
`Iic (0 : ℂ)ᶜ` with `Complex.slitPlane` applies to the first factor of `A`, not to `D`.

### Openness and simple connectedness

The order rays `Ici r` and `Iic r` are closed, so their complements are open. Therefore `D` and
`B` are open, `A` is an intersection of two open sets, and `B₀` is open as a metric ball.

All star-convexity statements below regard `ℂ` as a real normed vector space.

- The domain `D` is star convex at `0`, since the deleted ray begins strictly to the right of
  the center.
- The complement of the nonpositive ray is star convex at `1/2`, and `D` is also star convex at
  `1/2`; their intersection `A` is therefore star convex at `1/2`.
- The domain `B`, obtained by deleting the nonnegative ray, is star convex at `-1/2`.

The three displayed centers belong to their domains. Thus `D`, `A`, and `B` are nonempty and
contractible, hence simply connected. At the pinned Mathlib version the robust formal route is
`StarConvex.contractibleSpace`, followed by the `SimplyConnectedSpace.ofContractible` instance.
The implementation directly imports
`Mathlib.Analysis.Convex.Contractible` for this bridge rather than rely on a transitive import.
No smooth-homotopy construction is required.

### The cover

The two slit charts cover the punctured principal domain:

\[
 A\cup B=D\setminus\{0\}.                                  \tag{4}
\]

Indeed, both charts lie in `D` and both exclude zero. Conversely, suppose `z∈D`, `z≠0`, and
`z∉B`. Then `z∈Ici(0:ℂ)`, so (1) says that `z` is real with nonnegative real part. Nonzeroness
makes that real part strictly positive. Thus `z` is outside `Iic(0:ℂ)`, and membership in `D`
puts it in `A`.

Furthermore,

\[
 B_0\subseteq D.                                           \tag{5}
\]

A point on the deleted ray has real part at least one and consequently norm at least one, so it
cannot lie in the open unit ball. Since zero itself belongs to `B₀`, equations (4) and (5) give
the exact three-set cover

\[
 B_0\cup A\cup B=D.                                       \tag{6}
\]

This set equality, rather than an informal picture, will justify the fallback case in the total
definition.

### The disk overlaps

Put

\[
 U_A:=A\cap B_0,
 \qquad
 U_B:=B\cap B_0.                                          \tag{7}
\]

The unit ball is convex and hence star convex at each of its points. Intersecting its
star-convexity with that of the charts shows that `U_A` is star convex at `1/2`, while `U_B` is
star convex at `-1/2`. Both centers have norm `1/2`, so the overlaps are nonempty. They are open,
path connected, preconnected, contractible, and simply connected. These facts allow the global
scalar IVP theorem to be used on the overlaps themselves, which will be crucial below.

### The disconnected chart overlap

Every nonreal number belongs to both slit charts, while no real number does. Consequently

\[
 A\cap B=H_+\cup H_-,                                     \tag{8}
\]

where

\[
 H_+:=\{z:0<\operatorname{Im}z\},
 \qquad
 H_-:=\{z:\operatorname{Im}z<0\}.
\]

The union is disjoint. Each half-plane is open and convex, and therefore preconnected. The
points `i/2` and `-i/2` lie respectively in `H₊∩B₀` and `H₋∩B₀`. The overlap `A∩B` itself is
not connected; any gluing proof that applies the identity theorem to it in one step has missed
one of its two components.

## 2. The accepted series germ and the normalized equation

Fix arbitrary `a,b,c : ℂ`. Let

\[
 R(z):=\mathbf F_{\mathrm{series}}(a,b;c;z)
\]

denote the already published regularized Gauss series-sum function. Its existing meaning is not
changed: it is the local, totalized series object, and its source interpretation is established on
`B₀`. The published local results give

\[
 \operatorname{AnalyticOnNhd}_{\mathbb C}(R,B_0)           \tag{9}
\]

for every choice of parameters and, for every `z∈B₀`,

\[
 z(1-z)R''(z)
 +\bigl(c-(a+b+1)z\bigr)R'(z)
 -abR(z)=0.                                                \tag{10}
\]

This is the polynomial, unnormalized Gauss equation. It includes `z=0` and places no restriction
on `c`.

Away from the two singular points define ambient coefficient functions

\[
\begin{aligned}
 d(z)&:=z(1-z),\\
 N(z)&:=c-(a+b+1)z,\\
 f(z)&:=\frac{N(z)}{d(z)},\\
 g(z)&:=-\frac{ab}{d(z)}.
\end{aligned}                                              \tag{11}
\]

These quotients are total ambient functions, but their analytic assertions are deliberately
restricted to sets on which the denominator is nonzero. The chart `A` excludes zero by its
negative-ray cut and excludes one because `A⊆D`. The chart `B` excludes both zero and one by its
nonnegative-ray cut. Therefore

\[
 d(z)\ne0\qquad(z\in A\ \text{or}\ z\in B).               \tag{12}
\]

The numerators and `d` are polynomial expressions, so quotient closure for analytic functions,
using (12) pointwise, proves that `f` and `g` are analytic on both charts and hence on their
overlaps. No parameter is cancelled, and the construction never divides by `c`.

On either disk overlap, (10) and (12) are equivalent to the normalized value identity

\[
 R''(z)=-\bigl(f(z)R'(z)+g(z)R(z)\bigr).                  \tag{13}
\]

The scalar IVP theorem asks for more than an equality involving the value of a totalized
derivative. Its candidate predicate requires

\[
 \operatorname{HasDerivAt}(\operatorname{deriv}R)
   \left(-\bigl(f(z)\operatorname{deriv}R(z)+g(z)R(z)\bigr)\right)z.
                                                                  \tag{14}
\]

This witness follows from (9): analyticity makes `deriv R` analytic and differentiable, producing
the derivative witness with value `deriv (deriv R) z`. Equations (10) and (12), followed by field
algebra, replace that value by the right side of (14). Thus the normalized candidate condition is
proved only at ordinary points; it is not assumed at the singular origin.

## 3. Global solutions on the two slit charts

Use the actual scalar initial-value problems based at

\[
 q_A=\frac12,
 \qquad
 q_B=-\frac12.                                             \tag{15}
\]

Both points lie in `B₀`; the first lies in `A` and the second in `B`. Apply the published global
holomorphic second-order IVP theorem on `A`, with coefficients `f,g` and the initial data

\[
 w_A(q_A)=R(q_A),
 \qquad
 w_A'(q_A)=R'(q_A).                                       \tag{16}
\]

It returns an ambient function `w_A : ℂ → ℂ` that is analytic on all of `A`, satisfies the
normalized equation there, and has the prescribed value and first derivative. Its uniqueness
field says that this selected function is `EqOn` to every other analytic solution on all of `A`
with the same data.

Apply the same theorem on `B`, based at `q_B`, to obtain an ambient `w_B` analytic on `B`, with

\[
 w_B(q_B)=R(q_B),
 \qquad
 w_B'(q_B)=R'(q_B),                                       \tag{17}
\]

and satisfying the normalized equation throughout `B`.

The geometric hypotheses are exactly the openness and simple connectedness proved in Section 1,
and the coefficient hypotheses are those of Section 2. The implementation uses classical choice
to select the two ambient representatives. Their values outside the respective
charts are irrelevant, and the final germ-uniqueness theorem will show that no mathematical
choice remains in the public function.

## 4. Why fresh IVPs are required on the disk overlaps

It is not valid to use the uniqueness clause attached to `w_A` directly against `R`. That clause
expects a competitor analytic on all of `A`, while the accepted theorem gives analyticity of `R`
only on `B₀`. Restricting an analytic fact by monotonicity does not shrink the domain appearing in
the old uniqueness clause.

Instead, invoke the scalar theorem anew on the exact overlap `U_A`, at `q_A`, with data
`R(q_A),R'(q_A)`. Let `u_A` be its selected solution. Its uniqueness clause has two genuine
candidates:

1. the restriction of `w_A` to `U_A`, whose analyticity and equation restrict from `A` and whose
   initial data are (16);
2. the restriction of `R` to `U_A`, whose analyticity restricts from `B₀`, whose first derivative
   exists by analyticity, and whose equation is the witness (14).

The two uniqueness applications give `EqOn u_A w_A U_A` and `EqOn u_A R U_A`. Pointwise symmetry
and transitivity therefore yield

\[
 \operatorname{EqOn}(w_A,R,U_A).                           \tag{18}
\]

Repeat the construction on `U_B`, based at `q_B`, and compare its chosen solution first with
`w_B` and then with `R`. This gives

\[
 \operatorname{EqOn}(w_B,R,U_B).                           \tag{19}
\]

Equations (18) and (19) are consequences of actual IVP uniqueness on the precise overlap
domains. They are not an unproved appeal to uniqueness of analytic continuation.

## 5. Agreement on both chart-overlap components

On the open triple intersection `A∩B∩B₀`, equations (18) and (19) show that both chart solutions
equal `R`; hence

\[
 w_A=w_B\quad\text{on }A\cap B\cap B_0.                  \tag{20}
\]

The restrictions of `w_A` and `w_B` to `H₊` are analytic because `H₊⊆A∩B`. The point `i/2`
belongs to the open set in (20), so equality there supplies an eventual equality in the
neighborhood filter at `i/2`. The half-plane `H₊` is preconnected. The analytic identity theorem
therefore gives

\[
 \operatorname{EqOn}(w_A,w_B,H_+).                         \tag{21}
\]

Likewise, `-i/2` belongs to the lower half-plane and to the same open triple intersection.
Applying the identity theorem on the preconnected set `H₋` gives

\[
 \operatorname{EqOn}(w_A,w_B,H_-).                         \tag{22}
\]

Combining (8), (21), and (22) proves

\[
 \operatorname{EqOn}(w_A,w_B,A\cap B).                    \tag{23}
\]

Both witnesses `i/2` and `-i/2` are essential. An equality propagated from the upper half-plane
alone gives no information on the lower component.

## 6. The deterministic ambient definition

Define the regularized principal function `P=P_{a,b,c}:ℂ→ℂ` with fixed priority
`B₀`, then `A`, then `B`, and with the old series function as the fallback outside `D`:

\[
 P(z)=
 \begin{cases}
   R(z),   & z\in D\cap B_0,\\
   w_A(z), & z\in D,\ z\notin B_0,\ z\in A,\\
   w_B(z), & z\in D,\ z\notin B_0,\ z\notin A,\\
   R(z),   & z\notin D.
 \end{cases}                                               \tag{24}
\]

The third branch is sound: the cover (6) says that a point of `D` lying in neither `B₀` nor `A`
must lie in `B`. The outer membership test makes the ambient function agree definitionally with
the existing regularized series sum off the principal domain. This fallback carries no assertion
that the series converges there or that its totalized value already has source meaning.

The overlap equalities eliminate every priority conflict. On `B₀`, the first branch is `R`. On
`A`, a point in `B₀` is handled by (18), while every other point takes the chart branch directly.
On `B`, a point in `B₀` is handled by (19); a later point also in `A` is handled by (23); the
remaining points take the fallback chart branch. Thus

\[
\begin{aligned}
 \operatorname{EqOn}(P,R,B_0),\\
 \operatorname{EqOn}(P,w_A,A),\\
 \operatorname{EqOn}(P,w_B,B),\\
 \operatorname{EqOn}(P,R,D^c).
\end{aligned}                                              \tag{25}
\]

The first equality contains the origin literally, as well as every exceptional denominator and
every numerator-termination case. No parameter hypothesis has occurred anywhere in the
construction.

### Why the fallback matters at `z=1`

The point `1` lies in `Ici(1:ℂ)`, so `1∉D`. Equation (24) therefore gives the exact fallback
identity

\[
 P_{a,b,c}(1)=R_{a,b,c}(1).                                \tag{25a}
\]

This is not a general Gauss value formula. It says only that the new definition preserves the
ambient value of the already published series object at the boundary.

There is nevertheless a decisive terminating check. Take `a=b=0` and `c=1`. In degree zero the
regularized coefficient is

\[
 \frac{(0)_0(0)_0}{0!\,\Gamma(1)}=1.
\]

For every positive degree `k`, `(0)_k=0`; hence all remaining terms vanish. The formal series is
the constant polynomial one, so its totalized sum is genuinely one at every `z`, without any
convergence issue. Thus (25a) gives `P_{0,0,1}(1)=1`. Since `Γ(1)=1`, the Gamma-scaled ordinary
principal function has the same value. A zero fallback would instead force this boundary value to
zero and make the later source theorem impossible.

For nonterminating parameters, a future theorem evaluating the principal function at `1` now
reduces first to the existing series definition there. It will still require its own convergence
and summation proof, with the appropriate parameter hypotheses. Nothing in the present milestone
supplies that proof or claims the general Gauss value formula.

## 7. Holomorphy on the cut plane

The first three equalities in (25) transport analyticity from the corresponding known functions to
`P` on the same open sets. Formally, the equalities may have to be symmetrized to match the
orientation of `AnalyticOnNhd.congr`; mathematically this changes nothing. The result is
analyticity of `P` on `B₀`, on `A`, and on `B`.

Every point of `D` lies in one of these three open sets by (6). Since `AnalyticOnNhd` is a local,
pointwise property, the three conclusions assemble to

\[
 \operatorname{AnalyticOnNhd}_{\mathbb C}(P,D).             \tag{26}
\]

There is no assertion of analyticity at a point of the cut. The ambient value there is inherited
from `R`, but no exterior convergence or analytic meaning follows from that definitional choice.

## 8. The Gauss equation, including the origin

The public equation retains the polynomial form

\[
 z(1-z)P''(z)
 +\bigl(c-(a+b+1)z\bigr)P'(z)
 -abP(z)=0
 \qquad(z\in D).                                          \tag{27}
\]

The proof splits at zero.

If `z=0`, use `P=R` on the open unit ball. Apply derivative transport for `Set.EqOn` once to
identify first derivatives and again to identify second derivatives. After transporting the
values of `P`, `P'`, and `P''` to those of `R`, equation (27) is exactly the already published
local polynomial equation (10). This works for every `c`, including `c=0` and every negative
integer.

Now suppose `z≠0`. Equation (4) puts `z` in `A` or `B`. Choose the corresponding chart solution
`w`. The appropriate equality in (25), differentiated twice on the open chart, identifies the
values of `P`, `P'`, and `P''` with those of `w`. The chart IVP supplies

\[
 w''(z)=-\bigl(f(z)w'(z)+g(z)w(z)\bigr).                  \tag{28}
\]

Membership in `D` gives `z≠1`, so together with the case hypothesis `z≠0` it gives `d(z)≠0`.
Substitute (11) into (28), multiply by `d(z)`, and use field algebra to obtain the unnormalized
Gauss equation for `w`. The derivative equalities then transfer it to `P`.

This division of cases is mandatory. The normalized equation is used only where its denominator
is nonzero; the singular origin is closed solely by the accepted local polynomial theorem.

## 9. Principal uniqueness means uniqueness of the whole germ

The domain `D` is star convex at zero and hence preconnected, and `0∈D`. Let `V:ℂ→ℂ` be any
ambient function such that

1. `V` is analytic on `D`; and
2. `V=R` on the whole open unit disk `B₀`.

By (25), `P` also equals `R` on `B₀`. Hence `P` and `V` agree on an open neighborhood of zero.
The identity theorem on the preconnected domain `D`, using (26) and the analyticity of `V`, gives

\[
 \operatorname{EqOn}(P,V,D).                               \tag{29}
\]

No ODE hypothesis on `V` is needed: a holomorphic function on a connected domain is determined by
an open germ. This is the canonical characterization of the principal function and proves that
the choices of chart representatives in Section 3 have no effect on `D`.

The hypothesis must not be weakened to the two equalities `V(0)=R(0)` and `V'(0)=R'(0)`. The
origin is a singular point of the normalized equation. When `c=-N`, the regularized series may
start in degree `N+1`, or it may vanish identically after numerator termination. Its value and
first derivative at zero therefore do not characterize the intended branch. The public
uniqueness principle must preserve the entire unit-disk series germ.

## 10. Exceptional denominators on the whole principal domain

Let `N:ℕ` and put `M=N+1`. Write `(q)_M` for the rising Pochhammer symbol. Define on `D`

\[
 Q(z):=(a)_M(b)_M z^M
       P_{a+M,b+M,N+2}(z).                                \tag{30}
\]

Both `P_{a,b,-N}` and `Q` are analytic on `D`. On `B₀`, their defining principal functions agree
with the appropriate published series sums, and the existing local exceptional-shift theorem
gives

\[
 P_{a,b,-N}(z)=Q(z)\qquad(z\in B_0).                       \tag{31}
\]

The germ-uniqueness principle (29), equivalently a direct use of the identity theorem on `D`,
extends this equality to the entire principal domain:

\[
 \boxed{
 P_{a,b,-N}(z)
 =(a)_{N+1}(b)_{N+1}z^{N+1}
   P_{a+N+1,b+N+1,N+2}(z)}
 \qquad(z\in D).                                          \tag{32}
\]

No Pochhammer factor is cancelled. If `a=-m` with `m≤N`, then `(a)_{N+1}=0`, and (32) makes the
regularized principal function zero throughout `D`. The same conclusion holds if `b=-m` with
`m≤N`, including simultaneous early termination. The revised fallback is not automatically zero,
so the global conclusion requires a separate coefficient argument outside `D`.

Assume first that `a=-m` and `m≤N`. For every series index `k`, the exact coefficient of the old
regularized series is

\[
 A_k=
 \frac{(-m)_k(b)_k}{k!\,\Gamma(-N+k)}.                    \tag{32a}
\]

There are two exhaustive cases.

- If `k≤N`, put `j=N-k`. After the natural subtraction is cast into `ℂ`,
  `-N+k=-j`. The identity `Complex.Gamma_neg_nat_eq_zero` gives
  `Γ(-N+k)=Γ(-j)=0`. The denominator in (32a) is therefore zero, and totalized complex division
  makes `A_k=0`. No numerator or Gamma factor is cancelled.
- If `N<k`, then `m≤N<k`, so `m<k`. The root-level Pochhammer theorem
  `ascPochhammer_eval_neg_coe_nat_of_lt` gives `(-m)_k=0`. Thus the numerator in (32a) is zero
  and again `A_k=0`, regardless of the Gamma value.

Every coefficient is therefore zero. By
`Complex.coeff_regularizedGaussHGFunSeries`, the underlying formal multilinear series has zero
coefficient in every degree. Its application in degree `k` is consequently zero for every `z`,
and the definition

\[
 \operatorname{FormalMultilinearSeries.sum}(p,z)
 =\sum_{k=0}^{\infty}p_k(z,\ldots,z)
\]

reduces to the totalized sum of the zero sequence. Hence

\[
 R_{-m,b,-N}(z)=0\qquad\text{for every }z\in\mathbb C.     \tag{32b}
\]

This conclusion does not use convergence of the series at `z`; it uses pointwise vanishing of all
formal coefficients and `tsum_zero`. The argument with the second numerator factor instead gives

\[
 R_{a,-m,-N}(z)=0\qquad\text{for every }z\in\mathbb C      \tag{32c}
\]

when `m≤N`.

Inside `D`, equation (32) already makes the corresponding principal function zero. Outside `D`,
the fallback equality in (25), together with (32b) or (32c), does the same. Thus the principal
ambient function is identically zero on all of `ℂ` in either early-termination case, including
simultaneous termination.

This is also why an exact finite order-of-vanishing statement needs a nonzero-prefactor
hypothesis: the zero function has no finite exact order. Without such a hypothesis, (32) is the
correct unconditional factorization. At the origin it gives the right value as well, because
`N+1>0` and therefore `P_{a,b,-N}(0)=0`.

No assertion is made here about the exact polynomial degree in any terminating but nonzero case.

## 11. The ordinary principal function is only a scaling

There is no second continuation construction for the ordinary Gauss function. Define its ambient
principal version by

\[
 F^{\mathrm{pr}}_{a,b,c}(z):=\Gamma(c)P_{a,b,c}(z).         \tag{33}
\]

The totalized expression makes sense for every parameter, but source-facing ordinary statements
must assume the exact nonexceptional condition

\[
 h_c:\qquad c\ne-n\quad\text{for every }n\in\mathbb N.    \tag{34}
\]

Under (34), Gamma is nonzero. On `B₀`, the published local bridge

\[
 \frac{F_{\mathrm{series}}(a,b;c;z)}{\Gamma(c)}=R(z)
\]

therefore gives

\[
 F_{\mathrm{series}}(a,b;c;z)
 =\Gamma(c)R(z)
 =F^{\mathrm{pr}}_{a,b,c}(z).                             \tag{35}
\]

Thus the ordinary principal function agrees with the ordinary series on the entire open unit
disk, including zero. Cancelling the nonzero constant in (33) gives the regularization bridge

\[
 \frac{F^{\mathrm{pr}}_{a,b,c}(z)}{\Gamma(c)}=P_{a,b,c}(z)
 \qquad(z\in\mathbb C)                                    \tag{36}
\]

under (34). The ambient conclusion is legitimate: on the cut both totalized principal functions
still satisfy the defining relation (33), and nonvanishing of Gamma permits cancellation at every
ambient point. No boundary analyticity or ordinary source value is inferred from this algebraic
identity. In particular, source-facing ordinary statements continue to require exactly (34).

Constant multiplication transports analyticity and the homogeneous polynomial equation. Hence,
under (34), `F^{pr}` is analytic on `D` and satisfies

\[
 z(1-z)(F^{\mathrm{pr}})''(z)
 +\bigl(c-(a+b+1)z\bigr)(F^{\mathrm{pr}})'(z)
 -abF^{\mathrm{pr}}(z)=0
 \qquad(z\in D).                                          \tag{37}
\]

Two uses of the derivative rule for multiplication by a constant give the required first- and
second-derivative identities. The ordinary uniqueness theorem again uses the whole disk germ: an
analytic ambient competitor on `D` that agrees with `F_series` throughout `B₀` agrees with
`F^{pr}` throughout `D`.

Finally, Gamma at the positive integer `N+2` is `(N+1)!`. Combining this with (32) yields the
ordinary shifted form

\[
 \boxed{
 P_{a,b,-N}(z)
 =\frac{(a)_{N+1}(b)_{N+1}z^{N+1}}{(N+1)!}
   F^{\mathrm{pr}}_{a+N+1,b+N+1,N+2}(z)}
 \qquad(z\in D).                                          \tag{38}
\]

This identity is derived from the one regularized continuation. It is not evidence for a second,
ordinary IVP construction.

## 12. Formalization route and public boundary

The accepted physical core is `LMLF/ODE/Hypergeometric/Principal.lean`. This location makes its
essential dependence on both the local Gauss equation and the global holomorphic second-order IVP
visible, while leaving the lightweight `LMLF.Definitions` umbrella unchanged. The public domain,
functions, and analytic facts live in namespace `LMLF.Definitions`; the two polynomial equation
theorems live in namespace `LMLF.ODE`.

The accepted core surface consists of exactly sixteen declarations:

| Mathematical role | Accepted public declaration |
|---|---|
| Principal domain `D` | [`LMLF.Definitions.gaussHypergeometricDomain`](../../LMLF/ODE/Hypergeometric/Principal.lean#L21) |
| Coordinate membership criterion (3) | [`LMLF.Definitions.mem_gaussHypergeometricDomain_iff`](../../LMLF/ODE/Hypergeometric/Principal.lean#L24) |
| Openness of `D` | [`LMLF.Definitions.isOpen_gaussHypergeometricDomain`](../../LMLF/ODE/Hypergeometric/Principal.lean#L37) |
| Simple connectedness of `D` | [`LMLF.Definitions.isSimplyConnected_gaussHypergeometricDomain`](../../LMLF/ODE/Hypergeometric/Principal.lean#L69) |
| All-parameter regularized function `P` | [`LMLF.Definitions.regularizedGaussHypergeometric`](../../LMLF/ODE/Hypergeometric/Principal.lean#L500) |
| Ordinary function `Γ(c)P` | [`LMLF.Definitions.gaussHypergeometric`](../../LMLF/ODE/Hypergeometric/Principal.lean#L514) |
| Regularized disk equality in (25) | [`LMLF.Definitions.regularizedGaussHypergeometric_eqOn_seriesSum`](../../LMLF/ODE/Hypergeometric/Principal.lean#L518) |
| Regularized fallback equality on `Dᶜ` | [`LMLF.Definitions.regularizedGaussHypergeometric_eqOn_seriesSum_compl`](../../LMLF/ODE/Hypergeometric/Principal.lean#L527) |
| Regularized analyticity (26) | [`LMLF.Definitions.regularizedGaussHypergeometric_analyticOnNhd`](../../LMLF/ODE/Hypergeometric/Principal.lean#L557) |
| Regularized whole-germ uniqueness (29) | [`LMLF.Definitions.regularizedGaussHypergeometric_eqOn_of_eqOn_seriesSum`](../../LMLF/ODE/Hypergeometric/Principal.lean#L580) |
| Ordinary disk equality (35) | [`LMLF.Definitions.gaussHypergeometric_eqOn_seriesSum`](../../LMLF/ODE/Hypergeometric/Principal.lean#L598) |
| Ordinary analyticity on `D` | [`LMLF.Definitions.gaussHypergeometric_analyticOnNhd`](../../LMLF/ODE/Hypergeometric/Principal.lean#L614) |
| Ordinary whole-germ uniqueness | [`LMLF.Definitions.gaussHypergeometric_eqOn_of_eqOn_seriesSum`](../../LMLF/ODE/Hypergeometric/Principal.lean#L621) |
| All-ambient Gamma quotient (36) | [`LMLF.Definitions.gaussHypergeometric_div_Gamma`](../../LMLF/ODE/Hypergeometric/Principal.lean#L638) |
| Regularized polynomial equation (27) | [`LMLF.ODE.regularizedGaussHypergeometric_gaussEquation`](../../LMLF/ODE/Hypergeometric/Principal.lean#L694) |
| Ordinary polynomial equation (37) | [`LMLF.ODE.gaussHypergeometric_gaussEquation`](../../LMLF/ODE/Hypergeometric/Principal.lean#L722) |

The ordinary function itself is the total ambient scaling in (33). Every source-facing ordinary
result in this milestone nevertheless retains the exact hypothesis
`hc : ∀ n : ℕ, c ≠ -(n : ℂ)`: disk agreement, analyticity, whole-germ uniqueness, the Gamma
quotient, and the ordinary Gauss equation. Some constant-multiplication arguments may prove a
stronger structural fact without using `hc`, but this milestone deliberately keeps a uniform
source-valid parameter boundary. The implementation marks that intentional unused hypothesis
honestly; it does not manufacture a fake use or add a duplicate wrapper.

The accepted downstream exceptional development is
[`LMLF/Results/HypergeometricPrincipal.lean`](../../LMLF/Results/HypergeometricPrincipal.lean).
Its four public consequences are
[`LMLF.Definitions.regularizedGaussHypergeometric_neg_nat`](../../LMLF/Results/HypergeometricPrincipal.lean#L72),
the regularized shift (32);
[`LMLF.Definitions.regularizedGaussHypergeometric_neg_nat_eq_gauss`](../../LMLF/Results/HypergeometricPrincipal.lean#L105),
the ordinary factorial form (38);
[`LMLF.Definitions.regularizedGaussHypergeometric_eq_zero_of_early_left_termination`](../../LMLF/Results/HypergeometricPrincipal.lean#L135);
and
[`LMLF.Definitions.regularizedGaussHypergeometric_eq_zero_of_early_right_termination`](../../LMLF/Results/HypergeometricPrincipal.lean#L148).
The last two are the symmetric all-ambient early-termination zero theorems proved in Section 10.

The chart domains `A` and `B`, normalized coefficients, chosen chart and overlap solutions, and
all gluing lemmas should remain private. There is one present consumer of this geometry, so a
general public three-chart framework would add an abstraction without demonstrated reuse. The
published scalar holomorphic IVP theorem is already the correct reusable boundary.

The dependency direction is fixed as

```text
LMLF.Definitions.Hypergeometric
LMLF.ODE.Hypergeometric
LMLF.ODE.HolomorphicSecondOrder
Mathlib.Analysis.Convex.Contractible
  -> LMLF.ODE.Hypergeometric.Principal

LMLF.Results.Hypergeometric
LMLF.ODE.Hypergeometric.Principal
  -> LMLF.Results.HypergeometricPrincipal
```

The downstream leaf uses the accepted exceptional-series identity; the core does not import
either the old or the new results leaf. Existing names ending in `SeriesSum` keep their local-series
meanings and are neither changed nor aliased to the continuation. The ordinary function is not
constructed by a second IVP. The accepted focused consumers are
[`LMLFTest/ODE/Hypergeometric/Principal.lean`](../../LMLFTest/ODE/Hypergeometric/Principal.lean)
and
[`LMLFTest/Results/HypergeometricPrincipal.lean`](../../LMLFTest/Results/HypergeometricPrincipal.lean).
Integration adds the two semantic imports in [`LMLF/Results.lean`](../../LMLF/Results.lean#L9)
and the four corresponding library globs in [`lakefile.toml`](../../lakefile.toml#L34). The
lightweight `LMLF/Definitions.lean` umbrella is unchanged.

The accepted implementation uses these already published inputs:

- `LMLF.Definitions.regularizedGaussHypergeometricSeriesSum` and
  `LMLF.Definitions.gaussHypergeometricSeriesSum` for the unchanged local functions;
- `LMLF.Definitions.regularizedGaussHypergeometricSeriesSum_analyticOnNhd` for (9);
- `LMLF.ODE.regularizedGaussHypergeometricSeriesSum_gaussEquation` for (10);
- `LMLF.Definitions.gaussHypergeometricSeriesSum_div_Gamma` for the ordinary disk bridge;
- `LMLF.Definitions.regularizedGaussHypergeometricSeriesSum_neg_nat` for (31);
- `LMLF.ODE.exists_unique_holomorphicSecondOrderLinear` for the two chart IVPs and the two fresh
  overlap IVPs.

The relevant pinned Mathlib boundary consists of the complex-order descriptions and closed-order
sets; complement openness; the slit-domain star-convexity lemmas; `StarConvex.inter`, convexity of
the unit ball, and the contractible-to-simply-connected bridge; analytic quotient closure with an
explicit nonzero denominator; `AnalyticOnNhd.congr`; the preconnected analytic identity theorem
from an `EventuallyEq`; twofold `Set.EqOn.deriv` transport; and the Gamma nonvanishing and
positive-integer factorial formulas.

The exceptional ambient-zero proof additionally uses the exact coefficient identity
`Complex.coeff_regularizedGaussHGFunSeries`,
`Complex.Gamma_neg_nat_eq_zero`, the root-level theorem
`ascPochhammer_eval_neg_coe_nat_of_lt`, the definition `FormalMultilinearSeries.sum`, and
`tsum_zero`. The index specialization is polynomial degree `k` and root index `m`, using `m<k`.
The proof partitions the indices before simplifying, so it neither cancels a vanishing Gamma
factor nor relies on convergence outside the unit disk.

For the identity theorem in Section 5, mere nonemptiness of the triple overlap is not enough. The
formal proof turns its openness and membership of `±i/2` into the exact neighborhood-filter
eventual equalities. Likewise, the scalar ODE candidate for `R` contains the full
`HasDerivAt (deriv R) ...` witness from (14), not merely equation (13).

## 13. Focused tests and acceptance evidence

The accepted production proofs and focused public-use tests together cover all of the following.

1. The exact `ComplexOrder` descriptions of `D`, `A`, and `B`, guarding against an accidental
   substitution of the negative-axis slit plane.
2. Membership of `0`, `1/2`, `-1/2`, `i/2`, and `-i/2` in every set where each point is used.
3. The punctured two-chart cover, the complete three-open cover, and the decomposition of
   `A∩B` into the upper and lower half-planes.
4. Disk agreement at a generic point and at the origin.
5. The all-parameter regularized equation at zero and at nonzero points of both real chart
   pieces.
6. Chart equality on representative points of both the upper and lower overlap components.
7. Germ uniqueness for an ambient competitor whose values off `D` differ.
8. The cases `c=0` and `c=-N`, including early numerator termination and the resulting ambient
   identically zero function proved by the inside-domain shift and outside-domain coefficient
   argument.
9. Ordinary disk agreement and the all-ambient Gamma bridge under exactly (34).
10. Both global exceptional-shift formulas, including the factorial normalization in (38).
11. The fallback equality on `Dᶜ`, literal membership `1∉D`, and the genuine terminating checks
    `P_{0,0,1}(1)=1` and `F^{pr}_{0,0,1}(1)=1` through the series coefficients.

The private chart geometry, overlap identities, and chart-solution equalities are verified inside
the production proof. The focused test modules consume their public domain, germ, analyticity,
equation, exceptional-shift, termination, and boundary-fallback consequences.

The named regressions are
[`LMLFTest.ODE.Hypergeometric.Principal.terminatingRegularizedGaussSeries_zero_zero_one`](../../LMLFTest/ODE/Hypergeometric/Principal.lean#L187),
[`LMLFTest.ODE.Hypergeometric.Principal.terminatingPrincipalGauss_at_one`](../../LMLFTest/ODE/Hypergeometric/Principal.lean#L204),
and
[`LMLFTest.Results.principalExceptionalGaussCertificate`](../../LMLFTest/Results/HypergeometricPrincipal.lean#L145).

Root's acceptance run completed the plain `lake build` successfully across 3,163 jobs, obtained a
positive library inventory, and confirmed that all 25 negative fixtures were rejected. The
independent code referee additionally passed direct warning-as-error compilation for all four
frozen production/test files, four complete zero-diagnostic LSP checks, standard-axiom verification
for all twenty public declarations and the three named tests, and the file, dependency, import,
and library-trust checks. No GitHub CI result is claimed.

## 14. What remains after this construction

This development now provides a complete principal regularized Gauss function
on `D` and its one Gamma-scaled ordinary counterpart. It will not by itself finish all of
`C05-09-04`. Later work must still establish local continuation across points of the artificial
cut away from `1`, classify the behavior at `1` and infinity, and state and prove the properly
qualified nonprincipal behavior at the singular origin. Those later arguments may use the public
domain and canonical germ characterization above, but they must not be folded into this milestone
without their own source proof and review.
