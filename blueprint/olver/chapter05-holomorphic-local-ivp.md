# Chapter 5: holomorphic linear IVP on a disk

## Status, source, and formal boundary

**Status: accepted local theorem; no separate source credit.** The natural-language proof received
two independent mathematical ACCEPT reviews, and the frozen Lean production and test files
received a fresh independent code ACCEPT review with no findings. The complete global development
that uses this theorem has also received root acceptance. This page documents the local analytic
ingredient of Olver's Chapter 5, Theorem 3.1. It does not prove the theorem's global
simply-connected conclusion by itself and therefore earns no separate source row.

Source: Frank W. J. Olver, *Asymptotics and Special Functions*, corrected A K Peters reprint
(1997) of the 1974 edition, Chapter 5, Theorem 3.1, printed pp. 145--146 (preserved DjVu
pp. 158--159). This blueprint is original exposition: it contains no scan, OCR, or copied source
text.

The reviewed repository baseline is `1637092c7a1abb0681dfe52c45f5b7fa1a7e9e8a`, with Lean
`v4.33.1` and Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`. The mathematical packets
have SHA-256 digests
`e8bad9c297bd074e010d8ad742e8de1d0e120721078476dcdc5fe17fdc150d2a` and
`49531707760938182b14324014706877e8e5f6fae36c25bde855eab118998090`; their independent review
reports have digests
`34f5f0b9393e55326ec515ee08a71c1293523a3cf959e51253b6e5c8183e265b` and
`a2bd9e813ce04a8e9a97377f5595c4a0793b7aad0e55992c8fa88e98a0d2a104`.

The accepted implementation is the 448-line
[`LMLF/ODE/HolomorphicLinear/Local.lean`](../../LMLF/ODE/HolomorphicLinear/Local.lean#L373),
SHA-256 `1cec5f590a15fc7c31a457a65f182a85aa5d6e471ade63af0749590088b95782`.
Its 39-line test module is
[`LMLFTest/ODE/HolomorphicLinear/Local.lean`](../../LMLFTest/ODE/HolomorphicLinear/Local.lean#L11),
SHA-256 `984cf9d93f868f34faa61023c4c03421a68dad8ce9962244870497afd630c858`.
The code-referee report has digest
`2d66a39e93090f90496528de9e0966395f2c8f4c391372574cc71396fa73c330`.

Root acceptance passed the complete local 3,158-job `lake build`, all 25 negative fixtures,
complete zero-diagnostic LSP checks, direct warning-as-error checks, deterministic file and library
checks, import and diff checks, and standard-axiom checks for the accepted public declarations and
named consumers. No CI was dispatched or run.

The public theorem belongs to the analysis-only module `LMLF.ODE.HolomorphicLinear.Local`:

```lean
LMLF.ODE.exists_unique_holomorphicLinearIVP_ball
```

All chosen primitives, Picard terms, compact bounds, radii, estimates, and uniqueness helpers are
private. The downstream solution-sheaf, germ, `ULift`, covering, and monodromy machinery is also
private, but belongs to the global layer rather than this module.

## Public theorem

Let `E : Type u` carry only

```text
[NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E].
```

Fix `q : ℂ`, `R : ℝ` with `0 < R`, and write

\[
  B=\operatorname{ball}(q,R).
\]

Let `A : ℂ → (E →L[ℂ] E)` be analytic on `B`. For every arbitrary basepoint `x₀∈B` and datum
`u₀:E`, there is an ambient function `u:ℂ→E` such that, in this order,

1. `u x₀ = u₀`;
2. `AnalyticOnNhd ℂ u B`;
3. `HasDerivAt u (A z (u z)) z` for every `z∈B`;
4. every ambient `v:ℂ→E` with the same initial value, analyticity, and pointwise equation satisfies
   `Set.EqOn u v B`.

Thus the theorem produces a solution on the whole fixed ball, not on a smaller ball depending on
the basepoint or datum. The basepoint need not be the center. There is no coefficient bound on the
whole open ball, no finite-dimensional or nontriviality hypothesis, and no claim that two arbitrary
ambient extensions agree outside `B`.

## Compact exhaustion and coefficient bounds

Let `K⊆B` be compact and adjoin the basepoint:

\[
  K^*=K\cup\{x_0\}.
\]

This is nonempty and compact, even when `K` is empty. The continuous function
`z↦|z-q|` attains a maximum `m` on `K*`. Since every point of `K*` lies in the open ball,
`m<R`. Set

\[
  r=\frac{m+R}{2}.
\]

Then

\[
  0<r<R,
  \qquad K\cup\{x_0\}\subseteq \operatorname{ball}(q,r),
  \qquad \overline B(q,r)\subseteq B.                       \tag{1}
\]

The closed ball is compact because `ℂ` is proper. Analyticity makes `A` continuous on `B`, so the
operator norm has a finite maximum on `closedBall q r`. Choose `M` with

\[
  M\ge0,
  \qquad \|A(z)\|\le M\quad(z\in\overline B(q,r)).          \tag{2}
\]

The radius and bound are proof-local and may vary with `K`. This is essential: a holomorphic
coefficient can be unbounded on the whole open ball. For a pointwise argument take `K={z}`; for
local uniform convergence take an arbitrary compact `K`.

## One whole-ball Picard sequence

Construct ambient functions `Pₙ:ℂ→E` recursively, while carrying differentiability on the original
ball `B`. Start with

\[
  P_0(z)=u_0.
\]

Given `Pₙ`, put `Fₙ(z)=A(z)Pₙ(z)`. Differentiability of `A` and `Pₙ` implies differentiability of
`Fₙ` on `B`. A differentiable Banach-valued function on a complex ball has a primitive there.
Choose the next primitive normalized at the given basepoint:

\[
  P_{n+1}(x_0)=0,
  \qquad
  \operatorname{HasDerivAt}P_{n+1}\bigl(A(z)P_n(z)\bigr)z
  \quad(z\in B).                                             \tag{3}
\]

Equation (3) also supplies the differentiability invariant for the next recursive step. This is
one sequence on all of `B`; the smaller radii used below estimate it but do not select new
primitives. Consequently no compatibility or gluing statement between radius-indexed choices is
needed.

## Ray formula

Fix a smaller closed ball as in (1), with bound (2), and take `z` in it. Set

\[
  \delta=z-x_0,
  \qquad \gamma(t)=x_0+t\delta\quad(0\le t\le1).
\]

Closed balls are convex over the real scalars, so `γ([0,1])` remains in the same closed ball and
hence in `B`. The integrand `t↦Fₙ(γ(t))` is continuous. The Banach-valued fundamental theorem of
calculus along the affine segment gives

\[
  \delta\mathbin\bullet\int_0^1F_n(x_0+t\delta)\,dt
     =P_{n+1}(z)-P_{n+1}(x_0).
\]

Using the normalization,

\[
  P_{n+1}(z)=
  \delta\mathbin\bullet\int_0^1
     A(x_0+t\delta)P_n(x_0+t\delta)\,dt.                    \tag{4}
\]

The scalar multiplying the Banach-valued integral is the complex number `δ`. The theorem already
implements the complex-to-real affine chain rule. Formula (4) also covers `z=x₀`, because both
sides are zero and no division by `δ` occurs.

## Factorial estimate

Write `C=‖u₀‖`. For every `n:ℕ` and `z∈closedBall q r`, prove

\[
  \boxed{
  \|P_n(z)\|\le
  C M^n\frac{\|z-x_0\|^n}{n!}.}                             \tag{5}
\]

At `n=0`, `P₀(z)=u₀`, while `M⁰=‖z-x₀‖⁰=0!=1`; thus the estimate is equality, including the
usual `0^0` convention.

Assume (5) for `n`. For `t∈[0,1]`, the affine point lies in the same closed ball and

\[
  \|\gamma(t)-x_0\|=t\|\delta\|.
\]

The operator bound and induction hypothesis give

\[
\begin{aligned}
 \|A(\gamma(t))P_n(\gamma(t))\|
 &\le M\|P_n(\gamma(t))\|\\
 &\le C M^{n+1}\frac{t^n\|\delta\|^n}{n!}.                 \tag{6}
\end{aligned}
\]

Apply the norm estimate for the interval integral to (4), then use
`∫₀¹tⁿdt=1/(n+1)`:

\[
\begin{aligned}
 \|P_{n+1}(z)\|
 &\le \|\delta\| C M^{n+1}\frac{\|\delta\|^n}{n!}
       \frac1{n+1}\\
 &=C M^{n+1}\frac{\|\delta\|^{n+1}}{(n+1)!}.
\end{aligned}
\]

No step divides by `C`, `M`, or `‖δ‖`. Zero initial data, a zero coefficient bound, a coincident
endpoint, and the one-point Banach space are all included.

## Function and derivative majorants

Put

\[
  d_0=\|x_0-q\|,
  \qquad \rho=r+d_0.
\]

For `w∈ball q r`, the triangle inequality gives `‖w-x₀‖≤ρ`. Therefore (5) yields the uniform
bound

\[
  \|P_n(w)\|\le C\frac{(M\rho)^n}{n!}.                       \tag{7}
\]

This real majorant is summable by the exponential power-over-factorial series. The Weierstrass
M-test gives absolute and uniform summability of the function series on every such smaller ball.

The derivatives satisfy

\[
  \operatorname{deriv}P_0(w)=0,
  \qquad
  \operatorname{deriv}P_{n+1}(w)=A(w)P_n(w),                \tag{8}
\]

and hence

\[
  \|\operatorname{deriv}P_{n+1}(w)\|
  \le CM\frac{(M\rho)^n}{n!}.                               \tag{9}
\]

This second majorant is summable even when `C=0` or `M=0`. Since every compact subset of `B` fits
strictly inside some smaller concentric ball containing `x₀`, both series converge locally
uniformly on all of `B`. A smaller ball centered merely at `x₀` would not suffice for a distant
compact subset.

At each fixed `w∈B`, (7) proves norm summability. Completeness of `E` then gives the genuine sum

\[
  \operatorname{HasSum}(n\mapsto P_n(w))
    \left(\sum_n'P_n(w)\right).                              \tag{10}
\]

Keeping this `HasSum` is important because Mathlib's `tsum` is totalized at nonsummable points.

## The ambient sum, its value, and holomorphy

Define on all of `ℂ`

\[
  u(z)=\sum_{n=0}^{\infty}P_n(z).
\]

Only its restriction to `B` is semantically constrained. At the basepoint, `P₀(x₀)=u₀` and every
successor term is zero, so direct summation gives

\[
  u(x_0)=u_0.                                                 \tag{11}
\]

Now fix `z∈B` and choose a smaller open ball containing both `z` and `x₀`. Every `Pₙ` is
differentiable there and the uniform majorant (7) is summable. The locally uniform complex sum
theorem therefore proves `u` differentiable on that ball, in particular at `z`. Repeating at every
point gives differentiability on `B`; since `B` is open,

\[
  \operatorname{AnalyticOnNhd}_{\mathbb C}(u,B).             \tag{12}
\]

The same majorant also yields uniform convergence of finite partial sums. Thus holomorphy is not
being inferred from pointwise convergence alone.

## Termwise differentiation and the equation

At a fixed `z∈B`, termwise differentiation gives the actual sum

\[
  \operatorname{HasSum}
    \bigl(n\mapsto\operatorname{deriv}P_n(z)\bigr)
    (\operatorname{deriv}u(z)).                              \tag{13}
\]

Independently, map (10) through the continuous linear map `A(z)`:

\[
  \operatorname{HasSum}
    \bigl(n\mapsto A(z)P_n(z)\bigr)
    (A(z)u(z)).                                               \tag{14}
\]

By (8), the sequence in (14) is the derivative series after deleting its zero first term. Shift
(13) by one, identify the terms using (8), and apply uniqueness of sums in the Hausdorff space
`E`. This proves

\[
  \operatorname{deriv}u(z)=A(z)u(z).                         \tag{15}
\]

The differentiability already proved for `u` supplies its canonical derivative witness; rewriting
with (15) yields

\[
  \operatorname{HasDerivAt}u\bigl(A(z)u(z)\bigr)z.           \tag{16}
\]

This completes existence on the whole ball.

## Uniqueness on the whole ball

Let `u` and `v` be two ambient solutions with `u(x₀)=v(x₀)`, and put `D=u-v`. Subtracting their
derivative witnesses gives

\[
  D(x_0)=0,
  \qquad D'(z)=A(z)D(z)\quad(z\in B).                        \tag{17}
\]

Fix `z∈B`, choose a smaller closed concentric ball containing `x₀` and `z`, and choose its bound
`M`. Define

\[
\begin{gathered}
  \delta=z-x_0,
  \qquad \gamma(t)=x_0+t\delta,\\
  W(t)=D(\gamma(t)),
  \qquad L=\|\delta\|M.
\end{gathered}
\]

The mixed real/complex chain rule makes `W` a real-differentiable Banach-valued curve with

\[
  W'(t)=\delta\mathbin\bullet A(\gamma(t))W(t)
  \quad(0\le t\le1).                                        \tag{18}
\]

The curve and its displayed derivative are continuous on the compact unit interval. The
fundamental theorem of calculus, using `W(0)=0`, gives

\[
  W(t)=\int_0^t\delta\mathbin\bullet A(\gamma(s))W(s)\,ds.   \tag{19}
\]

Continuity supplies a finite `C≥0` such that `‖W(t)‖≤C` on `[0,1]`. Prove for every natural `n`
and `t∈[0,1]` that

\[
  \boxed{
  \|W(t)\|\le C\frac{(Lt)^n}{n!}.}                           \tag{20}
\]

The case `n=0` is the compact bound. Assuming (20), for `s∈[0,t]` one has

\[
\begin{aligned}
 \|\delta\mathbin\bullet A(\gamma(s))W(s)\|
 &\le \|\delta\|M C\frac{(Ls)^n}{n!}\\
 &=C\frac{L^{n+1}s^n}{n!}.                                  \tag{21}
\end{aligned}
\]

Insert (21) into (19), use the interval-integral norm bound and
`∫₀ᵗsⁿds=tⁿ⁺¹/(n+1)`, and obtain the successor case

\[
  \|W(t)\|\le C\frac{(Lt)^{n+1}}{(n+1)!}.
\]

At `t=1`, for every `n`,

\[
  0\le\|D(z)\|\le C\frac{L^n}{n!}.
\]

The right side tends to zero, so `D(z)=0`. Since `z` was arbitrary, `Set.EqOn u v B`. This second
factorial argument also divides by none of `C`, `L`, `M`, or `‖z-x₀‖`; all zero cases remain
inside the proof.

## Pinned Mathlib map and known traps

The implementation uses the following owning modules and pinned declarations.

- `Mathlib.Analysis.Complex.HasPrimitives` owns
  `DifferentiableOn.isExactOn_ball` and `Complex.IsExactOn.with_val_at`. They are genuinely
  Banach-valued and return an ambient primitive with an arbitrary prescribed value.
- `Mathlib.Analysis.Calculus.FDeriv.CompCLM` owns `DifferentiableOn.clm_apply`, used for
  `z↦A z (Pₙ z)`.
- `Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus` owns the Banach-valued affine
  ray theorem `intervalIntegral.integral_unitInterval_deriv_eq_sub`, the interval FTC used in
  uniqueness, and the interval-integral norm bound.
- `Mathlib.Analysis.Calculus.Deriv.Comp` owns `HasDerivAt.scomp`; with inner scalar `ℝ` and outer
  scalar `ℂ`, it supplies the mixed-scalar chain rule.
- `Mathlib.Analysis.Complex.LocallyUniformLimit` owns
  `Complex.differentiableOn_tsum_of_summable_norm` and
  `Complex.hasSum_deriv_of_summable_norm`. Both work for complete Banach targets without finite
  dimensionality.
- `Mathlib.Analysis.Complex.CauchyIntegral` owns
  `DifferentiableOn.analyticOnNhd`.
- `Mathlib.Analysis.SpecialFunctions.Integrals.Basic` provides the root-namespace theorem
  `integral_pow`. The name is not `intervalIntegral.integral_pow`.
- The compact theorem is root-namespace `isCompact_closedBall`, not
  `Metric.isCompact_closedBall`. `Real.summable_pow_div_factorial` supplies the majorants, and
  `FloorSemiring.tendsto_pow_div_factorial_atTop` supplies the uniqueness limit.
- `Summable.of_norm` is the correct direction from norm summability to Banach-valued summability.
  At this pin, `Summable.norm` has an unsuitable finite-dimensional real-space hypothesis.
- The tail comparison must retain genuine `HasSum` witnesses, explicitly remove
  `deriv P₀=0`, shift with `hasSum_nat_add_iff' 1`, and finish with `HasSum.unique`.

## Source-to-proof-to-Lean map

The source's disk construction becomes the public, universe-polymorphic Banach theorem
[`exists_unique_holomorphicLinearIVP_ball`](../../LMLF/ODE/HolomorphicLinear/Local.lean#L373).
Its mathematical stages correspond to private implementation stages as follows:

| Mathematical stage | Lean realization |
|---|---|
| smaller concentric compact ball and coefficient bound | private radius and operator-bound lemmas |
| normalized Liouville--Neumann increments on the whole disk | private primitive and Picard recursion |
| straight-ray integral identity | private Banach-valued ray lemma |
| factorial bound and exponential majorant | private norm-bound and summability lemmas |
| ambient sum, local uniform holomorphy, and actual derivative | body of the public theorem |
| affine-segment factorial uniqueness | private whole-ball uniqueness lemma |

The named test
[`genericHolomorphicLinearIVP_ball`](../../LMLFTest/ODE/HolomorphicLinear/Local.lean#L11) restates
the full arbitrary-universe, arbitrary-basepoint, whole-ball contract. The named
[`zeroCoefficient_holomorphicLinearIVP`](../../LMLFTest/ODE/HolomorphicLinear/Local.lean#L24)
specializes to the zero coefficient and uses the public uniqueness clause to identify the returned
solution with the constant function.

Current Chapter 5 coverage is **16/108 = 14.81% claim components, 3/13 = 23.08% whole numbered
theorems, and 0/44 = 0% exercises**. The completed global and scalar development checks exactly
`C05-03-01`, `C05-03-02`, and all of `T05-3.1`; the disk lemma is an independently useful public
analytic seam but earns no additional source credit.

The following are not proved here: the complex-domain Wronskian and fundamental-pair extensions
`C05-03-03`, the named expansion row `C05-03-04`, the Taylor recurrence `C05-03-05`, Theorem 3.2,
or any Gauss continuation result.
