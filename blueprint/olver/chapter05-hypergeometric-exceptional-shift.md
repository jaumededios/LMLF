# Chapter 5: exceptional denominator shift for the Gauss series

**Status: accepted.** The reviewed mathematics, two public shift identities, and focused joint
consumer complete exactly `C05-09-03` on the open unit disk.

## Source and review record

Source: Frank W. J. Olver, *Asymptotics and Special Functions*, corrected A K Peters reprint
(1997) of the work first published in 1974, Chapter 5, printed p. 159 (preserved DjVu p. 172;
source SHA-256 `ecee986dbc65c6a9d738837496772841605325dd3242b93abf025c59cfa405b1`). This is an
original exposition; it contains no source image, OCR transcript, or extended quotation.

The superseding 596-line mathematical packet has SHA-256
`fab7a16d1d3f8b8bb3c2254f2d42841dca64106822c28989a76a42af3cf757e9`. It retains the complete
mathematics of the historical packet and corrects only the coverage and joint-consumer gate. Its
review history is:

- original referee A, SHA-256
  `9e415fde4d4626f146f5aede121d6c46ed40e5c26d0eb95791431f46addf5aa2`, accepted the
  mathematics, source scope, API, and dependency design, while independently requiring the ODE
  and joint consumer before source-row credit;
- original referee B, SHA-256
  `1a31ab189a4e5418a9881a59b529dc5a425c5979d6896ca6088cd95d74a404cf`, accepted all
  mathematics, source work, API, and architecture but requested one editorial correction: remove
  the optional route to credit without the ODE/joint consumer;
- referee A's bounded delta review, SHA-256
  `fb76f2e69f42f8e901225d7c5302a31ecacb68c47dbe13a888a866dcbb1be6da`, accepted that
  correction without reopening the mathematical review;
- referee B's bounded delta review, SHA-256
  `1ea024ff6fbecec58e640dc6df5c49d6afae22109e745a7bd402cfebc9e7a490`, accepted the
  correction and closed the sole prior request.

Thus both independent review lines accept the superseding packet. This public page adapts that
evidence to blueprint form; its exact bytes were not the bytes reviewed by the referees.

The 340-line pre-acceptance public blueprint had SHA-256
`8e64587bd573a2933ee115a595cd37aeea8f79197b0b822f90d6ce3e16e0ad26`. The fresh independent
code/library referee accepted the exact implementation without required or optional findings; its
191-line report has SHA-256
`776d65757b241ac2b5e358fb3cee327f889673aad4399ef5629c32f576bdd72a`. The accepted artifacts are:

- [`LMLF/Results/Hypergeometric.lean`](../../LMLF/Results/Hypergeometric.lean), 148 lines, SHA-256
  `4754437f4308941e4a0e6fafee8fcae89b7cb2d6b0732bc1d5f4db99277e008a`;
- [`LMLFTest/Results/Hypergeometric.lean`](../../LMLFTest/Results/Hypergeometric.lean), 127 lines,
  SHA-256 `9d10673de96b54c4019b516bf0bf25c6e148716d6730ea49d9088c79ec4c293d`;
- [`LMLF/Results.lean`](../../LMLF/Results.lean), SHA-256
  `2fdce3f43de64c2a5cbb9ef91d3e450ae4aaf23ba7543e92088c57d61954a317`;
- `lakefile.toml`, SHA-256
  `5851a630995cf396152fb9a26aef6262ba65647041efad6f83084101ecb7d0d3`.

The code referee reviewed the frozen Lean outputs rather than this public blueprint. The
publication-status and evidence updates here do not claim independent review of the final public
bytes.

The all-parameter local Gauss-ODE checkpoint on which the coverage gate depends is published at
`a3682edf0fd1cfdbfa88d3606bf26a254eedbd82`. The exceptional-shift production module remains
independent of that ODE module; only the downstream test imports both.

## Scope

For `a,b,c,z : ℂ`, write `(q)ₙ` for the rising Pochhammer symbol. The existing regularized local
series is

\[
  \mathbf F_{\mathrm{series}}(a,b;c;z)
  =\sum_{s=0}^{\infty}
    \frac{(a)_s(b)_s}{s!\,\Gamma(c+s)}z^s.                \tag{1}
\]

For `N : ℕ`, the source identity has the two forms

\[
\begin{aligned}
 \mathbf F_{\mathrm{series}}(a,b;-N;z)
 &= (a)_{N+1}(b)_{N+1}z^{N+1}
    \mathbf F_{\mathrm{series}}(a+N+1,b+N+1;N+2;z),       \tag{2}\\
 &= \frac{(a)_{N+1}(b)_{N+1}z^{N+1}}{(N+1)!}
    F_{\mathrm{series}}(a+N+1,b+N+1;N+2;z).              \tag{3}
\end{aligned}
\]

The directly justified domain is `‖z‖ < 1`. The source derives the identity from its local series
before introducing values outside the disk by analytic continuation. Correspondingly, the LMLF
objects here are named `SeriesSum` functions backed by totalized power-series sums, not principal
cut-plane branches. Neither theorem may be presented as a continuation or branch identity.

## Complete local-series proof

Fix `a,b,z : ℂ`, `N : ℕ`, and `‖z‖ < 1`. Put

\[
 M=N+1,
 \quad
 r_s=\frac{(a)_s(b)_s}{s!\,\Gamma(-N+s)}z^s,
 \quad
 K=(a)_M(b)_M z^M,
\]

and let

\[
 g_k=\frac{(a+M)_k(b+M)_k}
            {k!\,\Gamma(N+2+k)}z^k.                     \tag{4}
\]

All naturals appearing in these complex expressions are cast to `ℂ`.

### The first `M` coefficients vanish

If `s<M`, then `s≤N`. Set `d=N-s`. The inequality permits natural subtraction before casting, and
`Nat.cast_sub` gives

\[
 -(N:\mathbb C)+(s:\mathbb C)=-((N-s):\mathbb C)=-(d:\mathbb C).
\]

By `Complex.Gamma_neg_nat_eq_zero`, `Γ(-(d:ℂ))=0`. Hence the denominator of `r_s` is
`(s!:ℂ)·0=0`. Complex division is totalized, so `x/0=0`; no numerator hypothesis is needed.
Therefore

\[
 \sum_{s\in\operatorname{range}(M)}r_s=0.                \tag{5}
\]

This includes `s=N`, where the Gamma argument is zero, and it includes `N=0`, where the prefix is
the single constant term.

### The remaining coefficients are a shifted series

At the tail index `s=k+M`, natural arithmetic followed by casting gives

\[
 -N+(k+M)=k+1,
 \qquad
 (N+2)+k=(N+1+k)+1.
\]

The two uses of `Complex.Gamma_nat_eq_factorial` therefore give

\[
 \Gamma(-N+s)=k!,
 \qquad
 \Gamma(N+2+k)=(N+1+k)!=s!.                              \tag{6}
\]

These natural factorials and their complex casts are nonzero. No zero Gamma value is cancelled in
the tail.

Evaluating `ascPochhammer_mul ℂ M k` at `a` and `b` yields

\[
 (a)_{M+k}=(a)_M(a+M)_k,
 \qquad
 (b)_{M+k}=(b)_M(b+M)_k.                                 \tag{7}
\]

Together with `k+M=M+k` and `pow_add`, equations (6) and (7) give the exact coefficient equality

\[
 r_{k+M}=K g_k.                                           \tag{8}
\]

This equality only multiplies by `(a)_M` and `(b)_M`; it never cancels either factor. It therefore
remains valid when one or both numerator Pochhammer factors vanish.

### Restore the finite prefix with `HasSum`

The existing `hasSum_regularizedGaussHypergeometricSeries`, applied to the shifted parameters,
is a genuine

\[
 \operatorname{HasSum}
   \bigl(g,\mathbf F_{\mathrm{series}}(a+M,b+M;N+2;z)\bigr). \tag{9}
\]

`HasSum.mul_left` scales this sum by `K`. The pointwise identity (8), transported with
`HasSum.congr_fun`, turns it into a sum for `k ↦ r_{k+M}`. Then `HasSum.sum_range_add` restores the
first `M` terms and adds their finite sum to the limit. That finite sum is zero by (5), so the
whole sequence `r` has sum

\[
 K\,\mathbf F_{\mathrm{series}}(a+M,b+M;N+2;z).
\]

Independently, the existing regularized summation theorem at denominator `-N` says that `r` has
sum `\mathbf F_{\mathrm{series}}(a,b;-N;z)`. `HasSum.unique` proves (2). This is a comparison of
two genuine sums of the same convergent series, not an equality obtained by manipulating
unconstrained totalized `tsum` values.

The exact pinned signature of `HasSum.sum_range_add` takes a tail `f (n+k)` and returns a sum of
`f` whose value is the finite prefix over `Finset.range k` plus the tail limit. An implementation
must explicitly normalize the harmless `k+M`/`M+k` difference at the coefficient boundary.

## Ordinary normalization

The shifted ordinary denominator `(N+2:ℂ)` is the cast of a strictly positive natural. Its real
part therefore cannot equal that of `-(j:ℂ)` for any `j : ℕ`. Thus the existing local bridge
applies internally, with no caller-supplied denominator hypothesis:

\[
 \frac{F_{\mathrm{series}}(a+M,b+M;N+2;z)}{\Gamma(N+2)}
 =\mathbf F_{\mathrm{series}}(a+M,b+M;N+2;z).             \tag{10}
\]

Since `N+2=M+1`, `Complex.Gamma_nat_eq_factorial` gives `Γ(N+2)=(M!:ℂ)`. Substitution in (2)
proves (3), with exactly one divisor `(N+1)!`, no sign, and no additional `N!` factor. As a direct
normalization check, `factorial_mul_ascPochhammer ℂ M k` states

\[
 (M!: \mathbb C)(M+1)_k=((M+k)!:\mathbb C),
\]

which changes the shifted ordinary denominator into the factorial denominator of the exceptional
tail. The public ordinary theorem is nevertheless to be derived from (2), the existing Gamma
bridge, and the Gamma factorial evaluation, rather than from a duplicate tail proof.

## Boundary and numerator-termination cases

- If `N=0`, the vanishing prefix consists only of the constant term. Equations (2) and (3) reduce
  to `abz` times the shifted function with parameters `(a+1,b+1;2)`; `1!=1`.
- If `z=0`, the exceptional constant coefficient is zero. On the right, `M=N+1>0`, so `0^M=0`.
  There is no `0^0` ambiguity.
- If `a=-m` with `m≤N`, then `m<M` and `(a)_M=0`. All prefix coefficients vanish through Gamma,
  and every coefficient from degree `M` onward vanishes through `(a)_s`. Both sides are
  identically zero on the source disk. The argument is symmetric in `b` and covers simultaneous
  early termination.
- If `a=-m` with `m>N`, then `a+M=-(m-N-1)`. The shifted numerator series terminates after degree
  `m-N-1`, while the original series runs from degree `M` through degree `m`. Multiplication by
  `z^M` aligns the degrees. Again the statement is symmetric in `b` and permits simultaneous
  termination.

These cases are why no proof may cancel either numerator prefactor.

## Analytic residual and the exponent statement

Define only for this explanation

\[
 H(z)=(a)_M(b)_M
   \mathbf F_{\mathrm{series}}(a+M,b+M;N+2;z).            \tag{11}
\]

No new public definition is proposed. The existing regularized analyticity theorem makes `H`
analytic on the unit disk, and (2) becomes

\[
 \mathbf F_{\mathrm{series}}(a,b;-N;z)=z^M H(z),
 \qquad M=N+1=1-(-N).                                    \tag{12}
\]

The existing origin theorem and Gamma normalization give

\[
 H(0)=\frac{(a)_M(b)_M}{M!}.                             \tag{13}
\]

Under the exact hypothesis `(a)_M(b)_M≠0`, the complex cast of `M!` is nonzero, hence `H(0)≠0`.
Equations (12) and (13), together with analyticity, are the precise local analytic-factor meaning
of exponent `M=N+1=1-c`. The accepted named focused test demonstrates this without adding a public
order-of-vanishing theorem.

If `(a)_M(b)_M=0`, equation (2) instead makes the regularized local-series function identically
zero on the disk. The zero function has no finite exact order of vanishing. The unconditional
conclusion is the factorization by `z^(N+1)`; an exact exponent statement requires the nonzero
prefactor.

## Accepted public API

The production module exposes exactly two declarations in namespace `LMLF.Definitions`:

```lean
theorem regularizedGaussHypergeometricSeriesSum_neg_nat
    {a b z : ℂ} (N : ℕ) (hz : ‖z‖ < 1) :
    regularizedGaussHypergeometricSeriesSum a b (-(N : ℂ)) z =
      (ascPochhammer ℂ (N + 1)).eval a *
        (ascPochhammer ℂ (N + 1)).eval b * z ^ (N + 1) *
          regularizedGaussHypergeometricSeriesSum
            (a + ((N + 1 : ℕ) : ℂ))
            (b + ((N + 1 : ℕ) : ℂ)) ((N + 2 : ℕ) : ℂ) z
```

```lean
theorem regularizedGaussHypergeometricSeriesSum_neg_nat_eq_gauss
    {a b z : ℂ} (N : ℕ) (hz : ‖z‖ < 1) :
    regularizedGaussHypergeometricSeriesSum a b (-(N : ℂ)) z =
      ((ascPochhammer ℂ (N + 1)).eval a *
          (ascPochhammer ℂ (N + 1)).eval b * z ^ (N + 1) /
        (Nat.factorial (N + 1) : ℂ)) *
          gaussHypergeometricSeriesSum
            (a + ((N + 1 : ℕ) : ℂ))
            (b + ((N + 1 : ℕ) : ℂ)) ((N + 2 : ℕ) : ℂ) z
```

The first theorem is proved from the genuine regularized `HasSum`; the second is derived from the
first through `gaussHypergeometricSeriesSum_div_Gamma` and
`Complex.Gamma_nat_eq_factorial`. The positive shifted denominator condition is internal. There
is no new coefficient definition, Gamma wrapper, branch object, generalized shift framework,
public alias, or public exact-order theorem.

## Dependency boundary and pinned infrastructure

The accepted production leaf is:

```text
LMLF.Definitions.Hypergeometric
  -> LMLF.Results.Hypergeometric
```

`LMLF/Results/Hypergeometric.lean` imports only `LMLF.Definitions.Hypergeometric`; it does not
import the ODE module. The important pinned Mathlib support and owners are:

| Purpose | Declaration | Owner |
|---|---|---|
| Exceptional Gamma zero | `Complex.Gamma_neg_nat_eq_zero` | `Mathlib.Analysis.SpecialFunctions.Gamma.Basic` |
| Natural Gamma value | `Complex.Gamma_nat_eq_factorial` | `Mathlib.Analysis.SpecialFunctions.Gamma.Basic` |
| Pochhammer shift | `ascPochhammer_mul` | `Mathlib.RingTheory.Polynomial.Pochhammer` |
| Factorial normalization | `factorial_mul_ascPochhammer` | `Mathlib.RingTheory.Polynomial.Pochhammer` |
| Tail scaling | `HasSum.mul_left` | `Mathlib.Topology.Algebra.InfiniteSum.Ring` |
| Pointwise sum transport | `HasSum.congr_fun` | `Mathlib.Topology.Algebra.InfiniteSum.Basic` |
| Finite-prefix restoration | `HasSum.sum_range_add` | `Mathlib.Topology.Algebra.InfiniteSum.NatInt` |
| Sum uniqueness | `HasSum.unique` | `Mathlib.Topology.Algebra.InfiniteSum.Defs` |

The frozen predecessor also supplies `hasSum_regularizedGaussHypergeometricSeries`,
`gaussHypergeometricSeriesSum_div_Gamma`,
`regularizedGaussHypergeometricSeriesSum_zero`, and
`regularizedGaussHypergeometricSeriesSum_analyticOnNhd`. At the pinned environment the pointwise
transport theorem is named `HasSum.congr_fun`; there is no declaration named `HasSum.congr`.

Private implementation steps may use `Complex.coeff_regularizedGaussHGFunSeries`,
`Polynomial.eval_mul`, `Polynomial.eval_comp`, `ascPochhammer_eval_eq_zero_iff`, `Nat.cast_sub`,
`Nat.factorial_ne_zero`, `Nat.cast_ne_zero`, and `pow_add`. None warrants a new public wrapper or
helper.

## Accepted consumers, verification, and coverage

Focused tests cover the general regularized and ordinary identities, both `N=0` specializations,
`z=0`, and early, late, and simultaneous numerator-termination cases. These examples record the
relevant `EqOn` zero identity and shifted Pochhammer factors; they are not public theorems asserting
an exact polynomial degree. The named
[`exceptionalGaussExponentCertificate`](../../LMLFTest/Results/Hypergeometric.lean#L83) jointly
uses:

1. the published all-parameter theorem
   `regularizedGaussHypergeometricSeriesSum_gaussEquation`;
2. `regularizedGaussHypergeometricSeriesSum_neg_nat`;
3. analyticity of the residual factor `H` on the source disk; and
4. `H 0 ≠ 0` under the exact hypothesis

   `(ascPochhammer ℂ (N + 1)).eval a *
    (ascPochhammer ℂ (N + 1)).eval b ≠ 0`.

The test module imports both `LMLF.ODE.Hypergeometric` and `LMLF.Results.Hypergeometric`. This is a
test-only composition edge and is not reversed into the production identity leaf. The exact public
anchors are
[`regularizedGaussHypergeometricSeriesSum_neg_nat`](../../LMLF/Results/Hypergeometric.lean#L70)
and
[`regularizedGaussHypergeometricSeriesSum_neg_nat_eq_gauss`](../../LMLF/Results/Hypergeometric.lean#L120).
The early-termination
[`EqOn` zero consumer](../../LMLFTest/Results/Hypergeometric.lean#L47) preserves the necessary
zero-prefactor caveat: the unconditional shift identity still holds, but the identically zero
function has no finite exact vanishing order. The named certificate proves an exact nonzero
analytic residual only under the displayed prefactor hypothesis.

Root's independent acceptance checks passed the full 2,841-job build, positive declaration
inventory, all 25 negative fixtures, complete zero-diagnostic LSP checks for core and test,
deterministic file checks for both, import and diff checks, and exact standard-axiom checks for the
two public theorems and the named test. The code referee independently passed the same full
2,841-job build, a 2,804-job affected build, and clean local checks. All recorded tests were local;
no CI was run.

This slice adds exactly `C05-09-03`. At the historical principal-Gauss checkpoint `18531f4`,
Chapter 5 coverage was `16/108 = 14.81%` claim components, `3/13 = 23.08%` whole numbered
theorems, and `0/44 = 0%` exercises; see the [Chapter 5 checklist](chapter05.md) for current totals.
No §8 or §3 component, numbered theorem, or exercise receives credit from
this exceptional-shift slice. The result is a local series identity and analytic factorization
only: it supplies no analytic continuation, principal branch, parameter entireness, or numerical
result.
