# Chapter 5: fundamental pairs and the Wronskian

**Status:** Accepted. The reviewed natural-language mathematics and repaired Lean implementation
check `C05-01-04`--`C05-01-07` and the whole of Theorem 1.2.

## Source and review record

Source: Frank W. J. Olver, *Asymptotics and Special Functions*, corrected A K Peters reprint
(1997) of the work first published in 1974, Chapter 5, printed pp. 141--142. The retained source
has SHA-256
`ecee986dbc65c6a9d738837496772841605325dd3242b93abf025c59cfa405b1`.
This page contains original mathematical exposition only; it includes no scan, OCR, or page
rendering from the book.

This public page consolidates the frozen 735-line mathematical packet with SHA-256
`c9a37930663862db475054826aef73cc868a535613c3e64856ad154b1c48dafd`.
Two fresh independent referees approved all of its mathematics and each requested the same public
API correction: the spanning-only predicate should have a spanning-specific name rather than
`IsFundamentalPairOn`. Their report hashes are:

- review A:
  `f918ee50d0d2a9b24d3c5c88044e263ac8adf1ec8f2992ec40af254960de6cc1`;
- review B:
  `6c784b45cc2f579abd68279f6b39aeab8a18f3efbc22ec59d2a54aa075fe654e`.

Root adopted the name `SpansSecondOrderLinearSolutionsOn`, with no compatibility alias. The
reviewed packet therefore supplies the approved mathematics, while this consolidation records the
subsequent root-resolved public name. The exact bytes of this public page were not independently
reviewed, and the referee reports are not described as having approved that renamed declaration.

The final repaired implementation received independent delta acceptance after the sole P2 API
reuse finding against the earlier snapshot was corrected. The delta report has SHA-256
`000c5e03ca3bbc41c4e5b0d08d03f6d16d376ec9a0bc4bbe33052f4869173273`; acceptance applies to the
repaired core below, not to that earlier snapshot. The accepted artifacts have these SHA-256
digests:

- [`LMLF/ODE/FundamentalPair.lean`](../../LMLF/ODE/FundamentalPair.lean), 617 lines:
  `e48cd7135d7d0d33779e569b0e1e3e6b48f5e18e06f9a217907fb8375a3f97be`;
- [`LMLFTest/ODE/FundamentalPair.lean`](../../LMLFTest/ODE/FundamentalPair.lean), 115 lines:
  `c8bb6175cd6a47009a3c16f901d6dc6e3f67c25c75d1677bccf434e2b6cf862a`;
- [`LMLF/Results.lean`](../../LMLF/Results.lean):
  `83cbceaf942627afa80f1fbe41573621f957783405a98251769cc438be61a60a`;
- [`lakefile.toml`](../../lakefile.toml):
  `376de15f948f2d94ae064cc6ec5fa0d057a597067d1b69f1708c272046008c73`.

The accepted parent modules at this slice's review snapshot were `LMLF/ODE/LinearSecondOrder.lean` at
`ff845560c0122975065c4f75a6e4895574a065091cd38f033f9ae48154356aba` and
`LMLF/ODE/Wronskian.lean` at
`091295aafbab1741be0dc4f27cadf14ee24d59f23d4e6811d653edaf11a43e9d`. Root acceptance passed the
full 2,778-job build, repository inventory and all 25 negative fixtures, standard-axiom checks for
all ten public declarations and four named tests, and clean full-file diagnostics for the core and
test files.

The source components are:

| Checklist component | Mathematical content | Accepted public target |
|---|---|---|
| `C05-01-04` | Fundamental-pair spanning and the normalized IVP pair | [`SpansSecondOrderLinearSolutionsOn`](../../LMLF/ODE/FundamentalPair.lean#L22); [`exists_complexCanonicalFundamentalPair`](../../LMLF/ODE/FundamentalPair.lean#L535); [`exists_realCanonicalFundamentalPair`](../../LMLF/ODE/FundamentalPair.lean#L576) |
| `C05-01-05` | Wronskian definition | existing [`wronskian`](../../LMLF/ODE/Wronskian.lean#L17); existing [`realWronskian`](../../LMLF/ODE/Wronskian.lean#L22) |
| `C05-01-06` | Interval-relative scalar linear independence | [`linearIndependent_restrict_pair_iff`](../../LMLF/ODE/FundamentalPair.lean#L31) |
| `C05-01-07` | Full three-way equivalence | [`complexFundamentalPair_iff`](../../LMLF/ODE/FundamentalPair.lean#L353); [`realFundamentalPair_iff`](../../LMLF/ODE/FundamentalPair.lean#L373); [`complexSecondOrderFundamentalPair_iff`](../../LMLF/ODE/FundamentalPair.lean#L485); [`realSecondOrderFundamentalPair_iff`](../../LMLF/ODE/FundamentalPair.lean#L510) |

The accepted general connection-coefficient results are
[`complexLinearSolution_eqOn_cramer`](../../LMLF/ODE/FundamentalPair.lean#L143) and
[`realLinearSolution_eqOn_cramer`](../../LMLF/ODE/FundamentalPair.lean#L163). The focused tests
exercise the [complex](../../LMLFTest/ODE/FundamentalPair.lean#L17) and
[real](../../LMLFTest/ODE/FundamentalPair.lean#L35) formulas directly, check off-domain invariance
for [spanning](../../LMLFTest/ODE/FundamentalPair.lean#L53) and
[restricted independence](../../LMLFTest/ODE/FundamentalPair.lean#L72), and include
[complex](../../LMLFTest/ODE/FundamentalPair.lean#L89) and
[real](../../LMLFTest/ODE/FundamentalPair.lean#L102) canonical-pair consumers.

## Setting and interval discipline

Let `I ⊆ ℝ` be nonempty, open, and preconnected. Thus `I` may be a bounded open interval, a
half-line, or all of `ℝ`. Let `𝕂` be either `ℝ` or `ℂ`, and let

\[
  f,g:\mathbb R\longrightarrow\mathbb K
\]

be continuous on `I`. A phase solution is a pair `y,v:ℝ→𝕂` having, at every `x∈I`, the
pointwise derivatives

\[
  y'(x)=v(x),\qquad
  v'(x)=-f(x)v(x)-g(x)y(x).                                  \tag{1}
\]

The Lean API expresses both equations with `HasDerivAt`. All equalities of solutions below are
`EqOn` equalities on `I`; ambient values outside `I` are irrelevant.

For two fixed phase solutions `(y₁,v₁)` and `(y₂,v₂)`, their Wronskian is

\[
  W(x)=y_1(x)v_2(x)-y_2(x)v_1(x).                            \tag{2}
\]

This is exactly the accepted generic definition `LMLF.ODE.wronskian`; the accepted
`realWronskian` is its real-valued abbreviation. No new determinant definition is needed.

## Spanning and interval-relative independence

The public predicate `SpansSecondOrderLinearSolutionsOn I f g y₁ y₂` says only the following:
for every `y,v:ℝ→𝕂` satisfying both phase equations (1), there are constants `A,B∈𝕂` such that

\[
  y(x)=A y_1(x)+B y_2(x)\quad(x\in I).                       \tag{3}
\]

It is deliberately a spanning predicate. In every theorem calling the fixed pair fundamental,
the four `HasDerivAt` families certifying that `(y₁,v₁)` and `(y₂,v₂)` solve (1) remain explicit
theorem hypotheses. The predicate does not bundle a solution class, velocities, or a solution
space, and there is no `IsFundamentalPairOn` alias.

The source's linear independence condition also concerns only restrictions to `I`. Define

\[
  r_1(x)=y_1(x),\qquad r_2(x)=y_2(x)\qquad(x:I).
\]

Then the standard Lean proposition is

```text
LinearIndependent 𝕂 ![(fun x : I ↦ y₁ x.1), (fun x : I ↦ y₂ x.1)]
```

It is equivalent to the source condition

\[
  \left(\forall x\in I,\ Ay_1(x)+By_2(x)=0\right)
  \Longrightarrow A=0\text{ and }B=0.                       \tag{4}
\]

The accepted theorem `linearIndependent_restrict_pair_iff` exposes this equivalence. Since its
proof is wholly pointwise, its domain should be arbitrary: for any type `X`, set `I:Set X`, and
ambient functions `y₁,y₂:X→R`, it identifies the `LinearIndependent R` proposition for the two
restrictions with (4). The scalar assumption is `[Ring R]`. This matches the assumptions of
Mathlib's `LinearIndependent.pair_iff`: the function module has the required additive group and
module structure pointwise. The ODE theorems themselves remain specialized to real time.

Using `LinearIndependent` for the ambient functions `ℝ→𝕂` would be wrong, because changing values
off `I` could change that proposition. Independence of the phase pairs would also be a different
condition from the source's scalar one.

## Two consequences of the accepted IVP theorem

The accepted [global linear IVP theorem](chapter05-global-ivp.md) supplies the two facts repeatedly
used below.

First, two arbitrary phase solutions with equal value and velocity at one `x₀∈I` agree in both
coordinates on `I`. To derive this directly from the existential API, invoke the accepted phase
IVP theorem with their common initial data. Its selected solution is `EqOn` to each competitor;
symmetry and transitivity give equality between the competitors.

Second, the zero phase is unique. The identically zero pair satisfies (1), so any phase solution
with value and velocity both zero at `x₀` is zero in both coordinates on `I`.

The local derivative fact used throughout is equally important. If two differentiable scalar
functions agree on `I`, then their derivatives agree at every `x₀∈I`: openness makes `I` a
neighborhood of `x₀`, so `EqOn` becomes an eventual equality there and derivative congruence
applies. Hence

\[
  Ay_1+By_2=0\text{ on }I
  \quad\Longrightarrow\quad
  Av_1(x_0)+Bv_2(x_0)=0.                                    \tag{5}
\]

This step is what connects scalar independence to the full initial-data matrix.

## Explicit Cramer representation

Fix `x₀∈I` and abbreviate

\[
  a=y_1(x_0),\quad b=y_2(x_0),\quad
  c=v_1(x_0),\quad d=v_2(x_0),\quad
  \Delta=ad-bc=W(x_0).                                      \tag{6}
\]

Let `(y,v)` be any phase solution, set `p=y(x₀)` and `q=v(x₀)`, and assume `Δ≠0`. Define

\[
  A=\frac{pd-bq}{\Delta},
  \qquad
  B=\frac{aq-pc}{\Delta}.                                   \tag{7}
\]

Direct expansion gives

\[
\begin{aligned}
 Aa+Bb
 &=\frac{pad-abq+abq-pbc}{\Delta}=p,\\
 Ac+Bd
 &=\frac{pcd-bcq+adq-pcd}{\Delta}=q.
\end{aligned}                                               \tag{8}
\]

Put

\[
  z=Ay_1+By_2,\qquad r=Av_1+Bv_2.                            \tag{9}
\]

The derivative rules give `z'=r`, and linearity of the equation gives

\[
\begin{aligned}
r'
 &=A(-fv_1-gy_1)+B(-fv_2-gy_2)\\
 &=-f(Av_1+Bv_2)-g(Ay_1+By_2)=-fr-gz.
\end{aligned}
\]

Thus `(z,r)` is a phase solution. Equations (8) say it has the same initial state as `(y,v)`, so
accepted phase uniqueness proves both

\[
  y=Ay_1+By_2\text{ on }I,
  \qquad
  v=Av_1+Bv_2\text{ on }I.                                  \tag{10}
\]

The public theorems `complexLinearSolution_eqOn_cramer` and
`realLinearSolution_eqOn_cramer` state (7) explicitly, assume only basepoint nonvanishing
`W(x₀)≠0`, and return both `EqOn` conclusions (10). Keeping only the scalar coordinate or hiding
the coefficients inside the equivalence proof would discard useful connection data. The
Wronskian-to-spanning implication and both canonical-pair theorems consume these declarations.

## Three-way equivalence in phase form

Assume explicit phase witnesses for the fixed pairs `(y₁,v₁)` and `(y₂,v₂)`. The following are
equivalent:

1. `SpansSecondOrderLinearSolutionsOn I f g y₁ y₂`;
2. `W(x)≠0` for every `x∈I`;
3. the two restrictions of `y₁,y₂` to subtype `I` form a `LinearIndependent 𝕂` family.

The full real and complex results are respectively `realFundamentalPair_iff` and
`complexFundamentalPair_iff`.

### Spanning implies a nowhere-zero Wronskian

Assume spanning and fix an arbitrary `x₀∈I`. Use the accepted IVP theorem to construct phase
solutions `(u₁,r₁)` and `(u₂,r₂)` with initial states `(1,0)` and `(0,1)`. Spanning supplies
constants `α,β,γ,δ` such that

\[
  u_1=\alpha y_1+\beta y_2,
  \qquad
  u_2=\gamma y_1+\delta y_2
  \quad\text{on }I.                                         \tag{11}
\]

Evaluation at `x₀`, followed by the local derivative argument, gives

\[
\begin{array}{ll}
 \alpha a+\beta b=1, & \alpha c+\beta d=0,\\
 \gamma a+\delta b=0, & \gamma c+\delta d=1.
\end{array}                                                  \tag{12}
\]

Expanding the determinant of these four scalar equations gives

\[
\begin{aligned}
1
 &=(\alpha a+\beta b)(\gamma c+\delta d)
   -(\gamma a+\delta b)(\alpha c+\beta d)\\
 &=(ad-bc)(\alpha\delta-\beta\gamma).
\end{aligned}                                               \tag{13}
\]

If `W(x₀)=ad-bc` were zero, (13) would say `1=0`. Thus `W(x₀)≠0`; the point was arbitrary, so the
Wronskian is nowhere zero.

### A nowhere-zero Wronskian implies spanning

Choose one `x₀∈I`. For an arbitrary phase solution, invoke the corresponding public Cramer theorem
with the hypothesis `W(x₀)≠0`. Its first conclusion is exactly the spanning relation (3). This
direction deliberately reuses `complexLinearSolution_eqOn_cramer` or
`realLinearSolution_eqOn_cramer` rather than repeating equations (7)--(10).

### A nowhere-zero Wronskian implies scalar independence

Suppose `Ay₁+By₂=0` on `I`, and fix `x₀∈I`. Evaluation and (5) give

\[
  Aa+Bb=0,\qquad Ac+Bd=0.                                   \tag{14}
\]

Multiply the first equality by `d`, the second by `b`, and subtract to obtain `AΔ=0`. Multiply
the second by `a`, the first by `c`, and subtract to obtain `BΔ=0`. Since `Δ=W(x₀)≠0`, both
coefficients vanish. The restriction bridge turns this two-coefficient conclusion into the
standard subtype `LinearIndependent` proposition.

### Scalar independence implies a nowhere-zero Wronskian

Fix `x₀∈I` and suppose `Δ=ad-bc=0`. A nonzero coefficient pair producing zero initial state exists
in every case:

- if `(a,b)≠(0,0)`, choose `(A,B)=(b,-a)`; then
  `Aa+Bb=0` and `Ac+Bd=bc-ad=0`;
- if `a=b=0` but `(c,d)≠(0,0)`, choose `(A,B)=(d,-c)`; then the value is zero and
  `Ac+Bd=dc-cd=0`;
- if `a=b=c=d=0`, choose `(A,B)=(1,0)`.

In all three cases `(Ay₁+By₂,Av₁+Bv₂)` solves (1), has zero initial state, and has a nonzero
coefficient pair. Uniqueness against the zero phase gives `Ay₁+By₂=0` on `I`. The
two-coefficient form of subtype independence forces `A=B=0`, a contradiction. Hence `W(x₀)≠0`;
again `x₀` was arbitrary.

This case split includes both easily missed singular cases: a zero first row with a nonzero second
row, and an entirely zero initial matrix.

## Source-form `C²` theorem

The source-form solution premise for `y:ℝ→𝕂` is

\[
  y\in C^2(I),
  \qquad
  (\operatorname{deriv}y)'(x)
   =-f(x)\operatorname{deriv}y(x)-g(x)y(x)\quad(x\in I),    \tag{15}
\]

where the second condition is pointwise `HasDerivAt`. Theorems
`complexSecondOrderFundamentalPair_iff` and `realSecondOrderFundamentalPair_iff` state the same
three-way equivalence for two scalar solutions satisfying (15), using

```text
wronskian y₁ (deriv y₁) y₂ (deriv y₂)
```

or its real abbreviation.

The phase/source conversion first reuses the accepted IVP API. Given any phase competitor `(y,v)`,
choose `x₀∈I` and invoke the accepted phase IVP theorem with initial state `(y(x₀),v(x₀))`. It
returns a selected phase solution `(s,r)`, proves `s` is `C²`, and makes `(s,r)` `EqOn` to every
phase competitor with those data. Hence `s=y` on `I`, and `ContDiffOn.congr` transports `C²`
regularity to `y`.

The first phase equation identifies `deriv y=v` on `I`. Openness makes that an eventual equality
near each point, so derivative congruence transfers the second phase witness from `v` to
`deriv y`, proving (15). This route reuses the accepted theorem instead of duplicating its private
regularity proof.

Conversely, if `y` satisfies (15), set `v=deriv y`. On the open set `I`, `C²` regularity gives the
ordinary derivative witness `y'=deriv y`; equation (15) is exactly the second phase witness. Thus
`(y,deriv y)` is a phase solution. These two conversions transfer spanning in both directions,
while the Wronskian and independence propositions are already the source ones.

A direct calculus fallback is also valid: the phase witnesses make `y,v` differentiable and
continuous, the continuous expression `-fv-gy` is `deriv v`, so `v` is `C¹` and `y` is `C²`.
This fallback should be used only if transporting the accepted IVP output is unexpectedly awkward;
it is not a reason to add a public calculus or solution-space framework.

## Canonical normalized pair

Fix `x₀∈I`. Apply the accepted complex or real phase IVP theorem to the initial states

\[
  (y_1(x_0),v_1(x_0))=(1,0),
  \qquad
  (y_2(x_0),v_2(x_0))=(0,1).                                \tag{16}
\]

The IVP output supplies `C²` regularity of both scalar coordinates and all four fixed phase
witnesses. At the basepoint,

\[
  W(x_0)=1\cdot1-0\cdot0=1.                                 \tag{17}
\]

For an arbitrary `x∈I`, the accepted complex theorem `wronskian_eq_zero_iff`, or its real
counterpart `realWronskian_eq_zero_iff`, says that `W(x)=0` iff `W(x₀)=0`. Equation (17) makes the
right side false, so `W` is nowhere zero. These calls are required application-level reuse of the
existing Wronskian API, not a new proof of Abel's identity.

The phase equivalence gives spanning and subtype linear independence. For an arbitrary phase
solution `(y,v)`, the public Cramer theorem specializes, using (16)--(17), to

\[
  A=y(x_0),\qquad B=v(x_0),                                  \tag{18}
\]

and returns both exact representations

\[
\begin{aligned}
 y&=y(x_0)y_1+v(x_0)y_2 &&\text{on }I,\\
 v&=y(x_0)v_1+v(x_0)v_2 &&\text{on }I.
\end{aligned}                                               \tag{19}
\]

Therefore `exists_complexCanonicalFundamentalPair` and
`exists_realCanonicalFundamentalPair` return:

- the two scalar and two velocity functions;
- `C²` regularity of both scalar functions;
- the four normalized initial values (16);
- all four pointwise phase derivative families;
- nowhere-zero existing Wronskian on `I`;
- `SpansSecondOrderLinearSolutionsOn`;
- standard `LinearIndependent` for the two scalar restrictions to subtype `I`; and
- for every phase solution, both coordinate formulas (19) with the exact initial-value
  coefficients.

The complex result still has a real independent variable. It is a conservative reusable
counterpart to the real source theorem, not the complex-variable theorem later in Chapter 5.

## Architecture and coverage boundary

The dependency direction is

```text
LMLF.ODE.LinearSecondOrder      LMLF.ODE.Wronskian
                 \                 /
                  LMLF.ODE.FundamentalPair
                              ↓
                         LMLF.Results
```

The accepted core explicitly imports the IVP and Wronskian modules and the Mathlib
linear-independence lemmas it uses. Neither foundational module imports the new one. It keeps
arbitrary-phase uniqueness and phase/source conversion helpers private and introduces no public
solution structure, submodule, basis wrapper, matrix wrapper, new scalar hierarchy, duplicate
Wronskian, or duplicate Abel proof.

Natural-language and checked Lean scope completed here is `C05-01-04`--`C05-01-07`, including all
of Theorem 1.2:

- claim components: `16/108 = 14.81%`;
- whole numbered theorems: `3/13 = 23.08%`;
- exercises: `0/44 = 0%`.

The later [first-order](chapter05-first-order.md),
[local Gauss-series](chapter05-hypergeometric-series.md),
[local Gauss-ODE](chapter05-hypergeometric-ode.md), and
[exceptional-shift](chapter05-hypergeometric-exceptional-shift.md) slices are now independently
accepted; their four additional claim-component credits do not belong to this historical Theorem
1.2 slice.
