# Chapter 5: the local Gauss hypergeometric equation

**Status: accepted.** The reviewed natural-language proof and the accepted Lean implementation
close exactly `C05-09-02`. They establish the all-parameter regularized Gauss equation and its
ordinary nonexceptional counterpart throughout the open unit disk.

This is a concise public adaptation of the immutable pre-Lean proof packet
`olver-ch5-hypergeometric-ode-01.md` (SHA-256
`7276ed8d9090d6b65251f854870b5547fc1410073631eb76fe103cf5ef881d09`). That packet was independently
accepted by referee A (`fc54ab07807b5d1381d9000fde989edd39e679823ae732fb94bbe99ff395ae2e`)
and referee B (`6fb688423768ef5e3622efde48b3f8bbb635743d834f019dfd3c7258e3c8f003`).
This public adaptation is not byte-for-byte the reviewed artifact.

The fresh independent code/library referee accepted the exact two-theorem implementation without
required or optional findings; its 202-line report has SHA-256
`ce09a05b2215a8e95926a69df366c121469188e5c7c2548208dc8c6d7a7c7971`. The accepted artifacts are:

- [`LMLF/ODE/Hypergeometric.lean`](../../LMLF/ODE/Hypergeometric.lean), 234 lines, SHA-256
  `43e186e7559a6a8f49210d25af340ad27948f99dbb871cad2f7fb4813db6dd88`;
- [`LMLFTest/ODE/Hypergeometric.lean`](../../LMLFTest/ODE/Hypergeometric.lean), 75 lines, SHA-256
  `d72f616389a53e178f9b60c5049f52f24f398b57a874ae1952a3994853bfdd54`;
- [`LMLF/Results.lean`](../../LMLF/Results.lean), SHA-256
  `deb61e878500ed94b2abc4d2e59cc34125ec83181cb7601115ab25d3ace28a0d`;
- `lakefile.toml`, SHA-256
  `8175f3184d7ed673f05c9312413ad09af3d0ef2b50042a68a39f666d49495fb0`.

The `LMLF/Results.lean` and `lakefile.toml` hashes above identify the historical ODE-acceptance
snapshot published at `a3682edf0fd1cfdbfa88d3606bf26a254eedbd82`; later accepted result leaves
may update those two integration files without changing the frozen ODE core or test.

The 263-line pre-acceptance public blueprint had SHA-256
`bf3c3125a5c1381e5bd28af745ca13000a87dd3fcd7b4de4b4d26959cabc66ee`. The code referee reviewed
the frozen Lean outputs rather than that blueprint; the publication-status and evidence updates on
this page do not claim independent review of the final public bytes.

The predecessor local-series API is published at commit
`55e10eb42dc3a79e7eee1b1d440a23c94fa14bb5`. The fixed environment is Lean `v4.33.1` with Mathlib
`0df444a360eaa60ab8c11dca51a86af692955474`.

## Source boundary

The private retained source is Frank W. J. Olver, *Asymptotics and Special Functions*, corrected
1997 reprint, SHA-256
`ecee986dbc65c6a9d738837496772841605325dd3242b93abf025c59cfa405b1`. Printed p. 156 (retained
DjVu p. 169) gives the unnormalized Gauss equation

\[
 z(1-z)y''(z)+\bigl(c-(a+b+1)z\bigr)y'(z)-ab\,y(z)=0.
\]

Printed p. 159 (DjVu p. 172) gives the local Gamma-regularized series

\[
 \mathbf F(a,b;c;z)=\sum_{n\ge0}
 \frac{(a)_n(b)_n}{n!\,\Gamma(c+n)}z^n,
 \qquad |z|<1,
\]

and asserts that it solves this equation for all complex parameters. The source pages were checked
privately; no scan, OCR transcript, or extended quotation is reproduced here.

Only the strict unit-disk series sum is in scope. This blueprint does not cover analytic
continuation, branch cuts, boundary values, parameter entireness, exceptional-parameter shift
formulas, transformations, generalized hypergeometric equations, or numerics.

## Accepted public surface and dependency

The implementation is in `LMLF/ODE/Hypergeometric.lean`, namespace `LMLF.ODE`, directly above
`LMLF.Definitions.Hypergeometric`. It does not import the normalized real-variable
`LMLF.ODE.LinearSecondOrder` layer: normalization would divide by `z(1-z)` and lose the required
statement at `z=0`.

With `open LMLF.Definitions`, the exact two public declarations are:

```lean
theorem regularizedGaussHypergeometricSeriesSum_gaussEquation
    {a b c z : ℂ} (hz : ‖z‖ < 1) :
    z * (1 - z) *
          deriv (deriv (regularizedGaussHypergeometricSeriesSum a b c)) z
      + (c - (a + b + 1) * z) *
          deriv (regularizedGaussHypergeometricSeriesSum a b c) z
      - a * b * regularizedGaussHypergeometricSeriesSum a b c z = 0

theorem gaussHypergeometricSeriesSum_gaussEquation
    {a b c z : ℂ} (hc : ∀ n : ℕ, c ≠ -(n : ℂ)) (hz : ‖z‖ < 1) :
    z * (1 - z) * deriv (deriv (gaussHypergeometricSeriesSum a b c)) z
      + (c - (a + b + 1) * z) * deriv (gaussHypergeometricSeriesSum a b c) z
      - a * b * gaussHypergeometricSeriesSum a b c z = 0
```

The regularized theorem has no parameter hypothesis. The ordinary theorem retains the source
exclusion `hc`. Both retain the strict disk guard and include `z=0`. The coefficient recurrence used
below remains private; there is no new public solution predicate, derivative-formula family, or
generalized ODE framework.

## 1. A total coefficient recurrence

Put

\[
 A_n=\bigl(\texttt{Complex.regularizedGaussHGFunSeries }a\ b\ c\bigr).\operatorname{coeff}(n)
     =\frac{(a)_n(b)_n}{n!\,\Gamma(c+n)}.
\]

The implemented private algebraic lemma is

\[
 (n+1)(c+n)A_{n+1}=(a+n)(b+n)A_n                     \tag{1}
\]

for every `n : ℕ` and all `a b c : ℂ`.

Rewrite the coefficients with `Complex.coeff_regularizedGaussHGFunSeries`. The two uses of
`Polynomial.ascPochhammer_succ_eval` give
`(a)_(n+1)=(a)_n(a+n)` and `(b)_(n+1)=(b)_n(b+n)`, while `Nat.factorial_succ` gives
`(n+1)!=(n+1)n!`. The only cancellation is the cast of `n+1`, which is nonzero. No factorial,
`c+n`, or Gamma value is cancelled.

For the denominator step use the pinned identity

```lean
Complex.one_div_Gamma_eq_self_mul_one_div_Gamma_add_one (s : ℂ) :
  (Complex.Gamma s)⁻¹ = s * (Complex.Gamma (s + 1))⁻¹
```

at `s=c+n`. This theorem is total, including `s=0` and every negative integer. Writing
`P_n=(a)_n`, `Q_n=(b)_n`, and `f_n=(n!:ℂ)`, the complete calculation is

\[
\begin{aligned}
 &(n+1)(c+n)
   \frac{P_n(a+n)Q_n(b+n)}{(n+1)f_n\Gamma(c+n+1)}\\
 &=P_nQ_n(a+n)(b+n)f_n^{-1}
   \bigl((c+n)\Gamma(c+n+1)^{-1}\bigr)\\
 &=P_nQ_n(a+n)(b+n)f_n^{-1}\Gamma(c+n)^{-1}\\
 &=(a+n)(b+n)A_n.
\end{aligned}
\]

All inverses in this calculation are Mathlib's totalized inverses. At `c+n=0` the middle identity is
`0 * Gamma(1)⁻¹ = Gamma(0)⁻¹ = 0`; there is no hidden division. The available ratio and
non-cross-multiplied coefficient recurrences are unsuitable because they exclude precisely such
zero denominator parameters or zero coefficients.

## 2. Genuine series for both derivatives

Let

```text
y = regularizedGaussHypergeometricSeriesSum a b c
p = Complex.regularizedGaussHGFunSeries a b c.
```

The published predecessor theorem gives a genuine
`HasFPowerSeriesOnBall y p 0 1`. Apply `HasFPowerSeriesOnBall.fderiv`, then compose the resulting
continuous-linear-map-valued series with

```lean
ContinuousLinearMap.apply ℂ ℂ 1
```

using `ContinuousLinearMap.comp_hasFPowerSeriesOnBall`. Since `deriv y z` is `fderiv ℂ y z 1`,
`ContinuousLinearMap.apply_apply` and `HasFPowerSeriesOnBall.congr` identify the resulting function
with `deriv y`. Repeat the construction once more for `deriv (deriv y)`. Both differentiated series
remain genuine power series on the same radius-one ball.

The coefficient identity

```lean
FormalMultilinearSeries.derivSeries_coeff_one (q) (n) :
  q.derivSeries.coeff n 1 = (n + 1) • q.coeff (n + 1)
```

together with `FormalMultilinearSeries.apply_eq_prod_smul_coeff` gives, for every `‖z‖<1`, genuine
`HasSum`s

\[
\begin{aligned}
 \sum_{n\ge0}A_nz^n &=y(z),\\
 \sum_{n\ge0}(n+1)A_{n+1}z^n &=y'(z),\\
 \sum_{n\ge0}(n+2)(n+1)A_{n+2}z^n &=y''(z).
\end{aligned}                                                   \tag{2}
\]

Thus the displayed derivatives are actual derivatives, not formal placeholders or derivatives of
an arbitrary totalized `tsum`.

No unused `AnalyticOnNhd` fact is required inside this proof. The predecessor's analytic API remains
valuable and should be exercised by focused tests or downstream consumers; for example, it combines
with `AnalyticAt.differentiableAt` and `AnalyticAt.deriv` to expose first- and second-derivative
existence at exceptional `c=-N` alongside the new equation.

## 3. Finite-prefix shifts and the residual

Use `HasSum.mul_left` on (2), followed by `hasSum_nat_add_iff'` in the direction that restores an
explicit finite prefix.

- Multiply the second-derivative series by `z`, insert the zero degree-zero term, and shift by one:
  \[
  \sum_{n\ge0}n(n+1)A_{n+1}z^n=z\,y''(z).                  \tag{3}
  \]
- Multiply it by `z^2`, insert the two zero prefix terms, and shift by two:
  \[
  \sum_{n\ge0}n(n-1)A_nz^n=z^2y''(z).                     \tag{4}
  \]
  Here `n-1` means `(n:ℂ)-1`, not truncated natural subtraction; the `n=0,1` terms vanish.
- Multiply the first-derivative series by `z`, insert its zero prefix, and shift by one:
  \[
  \sum_{n\ge0}nA_nz^n=z\,y'(z).                            \tag{5}
  \]

These are finite-prefix operations, not infinite rearrangements. Combine (2)--(5) using
`HasSum.add`, `HasSum.sub`, and scalar multiplication. The coefficient of `z^n` in the resulting
Gauss residual is

\[
\begin{aligned}
B_n={}&n(n+1)A_{n+1}-n(n-1)A_n+c(n+1)A_{n+1}\\
 &-(a+b+1)nA_n-abA_n\\
={}&(n+1)(c+n)A_{n+1}-(a+n)(b+n)A_n=0,
\end{aligned}
\]

where the polynomial identity
`n(n-1)+(a+b+1)n+ab=(a+n)(b+n)` gives the second line and (1) gives zero. Hence the combined sequence
is pointwise zero. `hasSum_zero` and `HasSum.unique` force its sum to be zero. Reassociation gives

\[
z(1-z)y''(z)+\bigl(c-(a+b+1)z\bigr)y'(z)-ab\,y(z)=0,
\]

proving the all-parameter regularized theorem.

## 4. The ordinary theorem comes only from the Gamma bridge

Assume `hc : ∀ n : ℕ, c ≠ -(n:ℂ)` and set
`O=gaussHypergeometricSeriesSum a b c`, `R=regularizedGaussHypergeometricSeriesSum a b c`, and
`G=Complex.Gamma c`. Pinned `Complex.Gamma_ne_zero hc` gives `G≠0`.

On the open unit ball, the published theorem
`gaussHypergeometricSeriesSum_div_Gamma hc` states `O(w)/G=R(w)`. Now, and only with the proved
nonvanishing of `G`, `div_eq_iff` gives the `EqOn` identity

\[
O(w)=G R(w).                                                  \tag{6}
\]

Apply `Set.EqOn.deriv` on the open ball twice. Simplifying with `deriv_const_mul_field` yields

\[
O'=G R',\qquad O''=G R''.                                    \tag{7}
\]

Substitution of (6)--(7) factors the ordinary residual as `G` times the regularized residual, which
is zero by the first public theorem. This is the entire ordinary proof. It does not replay the
coefficient argument, differentiate Gamma, or attach source meaning to an exceptional ordinary
totalization.

## Exceptional cases and boundaries

- If `c=-N`, then `A_0,...,A_N` vanish. At `n=N`, (1) is `0=0` and does not falsely force the
  potentially nonzero `A_(N+1)` to vanish.
- If `a=-M` or `b=-M`, Pochhammer termination is already respected by the polynomial successor
  identity. If it overlaps the initial Gamma-zero block, the regularized function may be identically
  zero; the proof still applies. This includes `a=0`, `b=0`, and simultaneous degeneracies.
- At `z=0`, the residual is `cA_1-abA_0`, exactly (1) at `n=0`. Even when `c=0`, nothing is divided
  by `c` or `z`.
- No factor `1-z` is cancelled. The strict hypothesis `‖z‖<1` supplies all convergence used here;
  no boundary or exterior value follows.

## Accepted Lean correspondence and verification

The implementation uses the pinned APIs
`Complex.coeff_regularizedGaussHGFunSeries`,
`Polynomial.ascPochhammer_succ_eval`, `Nat.factorial_succ`,
`Complex.one_div_Gamma_eq_self_mul_one_div_Gamma_add_one`,
`HasFPowerSeriesOnBall.fderiv`, `ContinuousLinearMap.comp_hasFPowerSeriesOnBall`,
`FormalMultilinearSeries.derivSeries_coeff_one`,
`FormalMultilinearSeries.apply_eq_prod_smul_coeff`, `HasFPowerSeriesOnBall.hasSum`,
`hasSum_nat_add_iff'`, the additive `HasSum` operations, `Complex.Gamma_ne_zero`,
`Set.EqOn.deriv`, and `deriv_const_mul_field`.

The source-to-Lean anchors are:

- the all-parameter regularized equation:
  [`regularizedGaussHypergeometricSeriesSum_gaussEquation`](../../LMLF/ODE/Hypergeometric.lean#L67);
- the ordinary equation transported through the public Gamma bridge:
  [`gaussHypergeometricSeriesSum_gaussEquation`](../../LMLF/ODE/Hypergeometric.lean#L196).

Focused consumers check the exact two signatures, the origin with `c=0`, arbitrary exceptional
`c=-N`, zero and negative-natural numerator parameters, and a combined exceptional-parameter
consumer. In that last test, the accepted regularized analyticity theorem yields differentiability
of the function and of its first derivative, hence existence of both first and second derivatives,
while the new ODE theorem supplies the equation at `c=-N`; see
[`LMLFTest/ODE/Hypergeometric.lean`](../../LMLFTest/ODE/Hypergeometric.lean#L57).
The ordinary theorem reuses the public
[`gaussHypergeometricSeriesSum_div_Gamma`](../../LMLF/Definitions/Hypergeometric.lean#L115) bridge
and the regularized ODE rather than duplicating the coefficient calculation.

Root's independent acceptance checks passed the full 2,839-job build, positive declaration
inventory, all 25 negative fixtures, complete clean LSP diagnostics for the core and test files,
`check_lean_file` on both files, import and diff checks, and exact axiom checks for both public
theorems. Those axiom checks reported only `propext`, `Classical.choice`, and `Quot.sound`. The code
referee independently passed a 2,803-job affected build and clean local checks. All recorded tests
were local; no CI was run.

This slice adds exactly `C05-09-02`. At the historical principal-Gauss checkpoint `18531f4`,
Chapter 5 coverage was `16/108 = 14.81%` claim components, `3/13 = 23.08%` whole numbered
theorems, and `0/44 = 0%` exercises; see the [Chapter 5 checklist](chapter05.md) for current totals.
No §8 component, numbered theorem, or exercise receives credit from this
slice. It supplies no analytic continuation, cut-plane or boundary values, parameter analyticity,
transformation formulas, or numerics. The later accepted
[exceptional-shift slice](chapter05-hypergeometric-exceptional-shift.md) checks `C05-09-03`; that
additional credit does not belong to this historical ODE slice.
