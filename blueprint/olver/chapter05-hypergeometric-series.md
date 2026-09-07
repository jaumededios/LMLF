# Chapter 5: local Gauss hypergeometric series

**Status: accepted historical series slice.** The reviewed natural-language proof and Lean
implementation close exactly `C05-09-01`. They also provide the local definition, coefficient,
convergence, origin-value, analyticity, and Gamma-bridge part of `C05-09-02`; the separately
accepted [local Gauss-ODE slice](chapter05-hypergeometric-ode.md) now supplies the missing
all-parameter differential equation and closes that row. The later accepted
[exceptional-shift slice](chapter05-hypergeometric-exceptional-shift.md) closes `C05-09-03`.

## Source, scope, and review record

Source: Frank W. J. Olver, *Asymptotics and Special Functions*, corrected A K Peters reprint
(1997) of the work first published in 1974, Chapter 5, printed pp. 159--160. This page is an
original mathematical exposition and contains no source facsimile or transcription.

The immutable 408-line natural-language packet has SHA-256
`42f574b77d9c534e03f49db5a22b64def95607e77c2db4f2ebb3bd8a77977f4d`. Two fresh independent
reviews accepted its mathematics, source boundary, exact coefficient normalizations, radius
argument, and proposed API without correction:

- review A: `72c770f3d90c2637228daeaa689d7395afd57dbc696970bd6c59ecf35d6804c0`;
- review B: `97516fa67afe311726c8f8bb1cae93d1d020db654ca52bd72e6db838d3f07694`.

The fresh independent code-referee report has SHA-256
`336520f61a9891d40be928d2a6905e0996507331653e4a108336635557ca24ed` and accepted all twelve
declarations. The accepted artifacts are:

- [`LMLF/Definitions/Hypergeometric.lean`](../../LMLF/Definitions/Hypergeometric.lean), 155 lines,
  SHA-256 `6fb37043203951afe5ba870c5cdc1c42d07d74cdd12492d7479ba5b8a7832572`;
- [`LMLFTest/Definitions/Hypergeometric.lean`](../../LMLFTest/Definitions/Hypergeometric.lean), 44
  lines, SHA-256 `d86d2f5fada6da3b1e0ce5301af0e6986cd4df2dbac414cca79f537ec4b9392f`;
- [`LMLF/Definitions.lean`](../../LMLF/Definitions.lean), SHA-256
  `b47828a323a33763630cb5dca8ed5d194d1ba420293d6f9453c1a917c4c1b1dc`.

The combined FirstOrder and Hypergeometric integration keeps the accepted source and test files
unchanged and has `lakefile.toml` SHA-256
`383a0853584ba996b410c526170941ee258d14860e0552e2b3447bd5c19704ec`. Root's combined validation
passed the full 2,837-job build, repository inventory, all 25 negative fixtures, and whitespace
checks. The Hypergeometric slice separately passed clean full-file diagnostics and standard-axiom
checks for all twelve public declarations.

This public page adapts the reviewed packet to the implemented names and evidence. Its exact bytes
were not the bytes read by the natural-language referees.

## Coverage boundary

The accepted scope is deliberately local.

- `C05-09-01` is checked: the ordinary Gauss coefficient, its nonexceptional denominator
  hypothesis, genuine convergence and summation for `‖z‖ < 1`, its named local sum, normalization
  at zero, and point-variable analyticity on the open unit disk are implemented.
- This historical slice contributed partial evidence to `C05-09-02`: the regularized local
  definition, Gamma-denominator coefficients, all-parameter unit-disk summation, origin value,
  analyticity, and ordinary/regularized bridge. The separately accepted
  [local Gauss-ODE implementation](chapter05-hypergeometric-ode.md) proves the remaining
  all-parameter differential equation, so the combined evidence now checks that row.
- No result here constructs analytic continuation, a principal cut-plane branch, a value on the
  unit circle, parameter analyticity, a transformation identity, or a derivative formula.
- The later [exceptional-shift implementation](chapter05-hypergeometric-exceptional-shift.md)
  combines these definitions and analytic facts with its two shift identities and the existing
  ODE API to check `C05-09-03`; that additional credit does not belong to this historical slice.

This historical slice itself added exactly one claim component; the separately accepted ODE slice
and exceptional-shift slice add two more. Current Chapter 5 coverage is
`16/108 = 14.81%` claim components,
`3/13 = 23.08%` whole numbered theorems, and
`0/44 = 0%` exercises.

## Local objects and totalization discipline

For `a,b,c,z : ℂ`, write `(q)ₙ` for the rising Pochhammer symbol. On the source-valid ordinary
parameter domain

\[
  c\ne -n\qquad(n\in\mathbb N),                              \tag{1}
\]

the ordinary local series is

\[
  \sum_{n=0}^{\infty}
    \frac{(a)_n(b)_n}{(c)_n n!}z^n.                         \tag{2}
\]

The regularized local series is

\[
  \sum_{n=0}^{\infty}
    \frac{(a)_n(b)_n}{\Gamma(c+n)n!}z^n,                    \tag{3}
\]

and its coefficients make sense for every complex `a,b,c` under Mathlib's totalized field
operations and Gamma function.

The accepted definitions
[`gaussHypergeometricSeriesSum`](../../LMLF/Definitions/Hypergeometric.lean#L19) and
[`regularizedGaussHypergeometricSeriesSum`](../../LMLF/Definitions/Hypergeometric.lean#L27) are
transparent views of Mathlib's ordinary and regularized formal-series sums. Those underlying sums
use totalized `tsum`: the ambient functions therefore have a value even where convergence has not
been proved. The project names retain `SeriesSum`, and mathematical meaning is supplied only by
the domain-guarded theorems below. In particular, the definitions do not denote an analytically
continued principal branch.

Condition (1) is represented exactly by

```lean
hc : ∀ n : ℕ, c ≠ -(n : ℂ)
```

Every ordinary source-facing theorem carries `hc`. Every theorem asserting a freely chosen
pointwise sum or source value also carries `hz : ‖z‖ < 1`; the ambient power-series and analytic
theorems express the same open-disk restriction in their set-valued conclusions. Regularized
theorems need no parameter restriction, but their free-point summation remains inside the disk.

## Source-to-proof-to-Lean correspondence

| Content | Natural-language justification | Accepted Lean declaration |
|---|---|---|
| Ordinary local sum | Definition (2) with totalization discipline | [`gaussHypergeometricSeriesSum`](../../LMLF/Definitions/Hypergeometric.lean#L19) |
| Regularized local sum | Definition (3), partial evidence only | [`regularizedGaussHypergeometricSeriesSum`](../../LMLF/Definitions/Hypergeometric.lean#L27) |
| Ordinary radius at least one | exhaustive terminating/nonterminating proof below | [`ordinaryHypergeometricSeries_radius_ge_one`](../../LMLF/Definitions/Hypergeometric.lean#L31) |
| Ordinary ambient expansion | radius theorem plus generic power-series API | [`gaussHypergeometricSeriesSum_hasFPowerSeriesOnBall`](../../LMLF/Definitions/Hypergeometric.lean#L55) |
| Regularized ambient expansion | Mathlib's unconditional radius bound plus generic API | [`regularizedGaussHypergeometricSeriesSum_hasFPowerSeriesOnBall`](../../LMLF/Definitions/Hypergeometric.lean#L69) |
| Exact ordinary coefficient sum | `HasFPowerSeriesOnBall.hasSum` inside the disk | [`hasSum_gaussHypergeometricSeries`](../../LMLF/Definitions/Hypergeometric.lean#L83) |
| Exact regularized coefficient sum | the same genuine summation API and coefficient theorem | [`hasSum_regularizedGaussHypergeometricSeries`](../../LMLF/Definitions/Hypergeometric.lean#L99) |
| Division by Gamma | pinned ordinary/regularized identity, source-disk guarded | [`gaussHypergeometricSeriesSum_div_Gamma`](../../LMLF/Definitions/Hypergeometric.lean#L115) |
| Ordinary origin value | constant coefficient of (2) | [`gaussHypergeometricSeriesSum_zero`](../../LMLF/Definitions/Hypergeometric.lean#L123) |
| Regularized origin value | degree-zero coefficient of (3) | [`regularizedGaussHypergeometricSeriesSum_zero`](../../LMLF/Definitions/Hypergeometric.lean#L129) |
| Ordinary point-variable analyticity | ambient expansion on the unit ball | [`gaussHypergeometricSeriesSum_analyticOnNhd`](../../LMLF/Definitions/Hypergeometric.lean#L139) |
| Regularized point-variable analyticity | ambient expansion on the unit ball | [`regularizedGaussHypergeometricSeriesSum_analyticOnNhd`](../../LMLF/Definitions/Hypergeometric.lean#L148) |

The ordinary coefficient in the public `HasSum` theorem is displayed exactly as

```text
((n! : ℂ)⁻¹ * (a)ₙ * (b)ₙ * ((c)ₙ)⁻¹) * zⁿ,
```

while the regularized coefficient is displayed exactly as

```text
((a)ₙ * (b)ₙ / ((n! : ℂ) * Complex.Gamma (c+n))) * zⁿ.
```

These are genuine `HasSum` propositions, not equations between totalized `tsum` expressions.

## Ordinary radius proof

Let `p = ordinaryHypergeometricSeries ℂ a b c` and assume (1). There are three exhaustive cases.

First suppose `a = -m` for some natural `m`. The first numerator Pochhammer terminates, and
Mathlib's corresponding radius theorem gives `p.radius = ⊤`. Hence `1 ≤ p.radius`. This case also
covers simultaneous termination of both numerator parameters.

Otherwise suppose `b = -m` for some natural `m`. The second numerator termination theorem again
gives radius `⊤`, hence the required bound.

In the remaining case neither `a` nor `b` is a nonpositive integer. For every `n : ℕ`, equality
`(n : ℂ) = -a` would negate to `a = -(n : ℂ)`, contrary to the first case's negation. The same
argument gives `(n : ℂ) ≠ -b`. Equality `(n : ℂ) = -c` would negate to
`c = -(n : ℂ)`, contradicting `hc n`. Therefore

```text
∀ n : ℕ, (n : ℂ) ≠ -a ∧ (n : ℂ) ≠ -b ∧ (n : ℂ) ≠ -c.
```

This is precisely the hypothesis of Mathlib's exact-radius theorem, so `p.radius = 1`. The three
cases prove `1 ≤ p.radius` under `hc`.

The proof does not use Mathlib's exceptional-denominator polynomial theorem. Such behavior comes
from inverse-zero totalization when `c` is a nonpositive integer and is outside the ordinary
source domain (1).

## From radius to genuine summation

For the ordinary series, the preceding result gives

\[
  0<1\le p.\operatorname{radius}.
\]

The generic `FormalMultilinearSeries.hasFPowerSeriesOnBall` theorem constructs an expansion on the
full radius ball. `HasFPowerSeriesOnBall.mono` restricts that expansion to radius one, yielding the
accepted ordinary ambient expansion. For the regularized formal series, Mathlib directly supplies
the unconditional radius-at-least-one theorem, and the identical generic argument yields the
regularized expansion.

If `‖z‖ < 1`, then `z` belongs to the radius-one emetric ball centered at zero. The `hasSum` field
of each ambient expansion therefore proves genuine summation at `z`. In the ordinary case,
Mathlib's formal-series application formula reduces the term to (2). In the regularized case,
the one-dimensional formal-series application rule produces `z^n` times the coefficient, and the
regularized coefficient theorem rewrites that coefficient to the denominator in (3). Commutativity
of complex multiplication puts it in the displayed source order.

This establishes convergence rather than merely identifying whatever value a totalized sum might
have. It also covers terminating numerator cases: their true radius may be infinite, but the public
source theorem conservatively restricts to the open unit disk.

## Gamma relation and origin values

Under `hc` and `‖z‖ < 1`, the accepted bridge states

\[
  \frac{F_{\mathrm{series}}(a,b;c;z)}{\Gamma(c)}
  =\mathbf F_{\mathrm{series}}(a,b;c;z).                    \tag{4}
\]

The underlying Mathlib identity happens to hold between totalized functions for every `z`, but
the public theorem deliberately retains the source-disk guard so that (4) does not imply
continuation semantics outside the proved domain.

At `z=0`, all positive-degree terms vanish. The ordinary constant coefficient is one, giving

\[
  F_{\mathrm{series}}(a,b;c;0)=1
\]

under `hc`. The regularized constant coefficient is

\[
  \mathbf F_{\mathrm{series}}(a,b;c;0)=\Gamma(c)^{-1}
\]

for all parameters. In particular, if `c` is a nonpositive integer, Mathlib's Gamma value and its
inverse are zero, matching the regularized constant coefficient. This all-parameter local fact was
partial evidence only; the separately accepted ODE module now supplies the differential equation.

## Analyticity and consumers

`HasFPowerSeriesOnBall.analyticOnNhd` turns the two ambient radius-one expansions into
point-variable analyticity on `Metric.ball 0 1`. Rewriting the emetric radius-one ball as the usual
metric ball is the only domain conversion. These results say nothing about analyticity in `a`,
`b`, or `c`.

The focused tests exercise:

- the exact [ordinary `HasSum`](../../LMLFTest/Definitions/Hypergeometric.lean#L12);
- recovery of the regularized totalized value from genuine
  [`HasSum.tsum_eq`](../../LMLFTest/Definitions/Hypergeometric.lean#L20);
- numerator [termination](../../LMLFTest/Definitions/Hypergeometric.lean#L27);
- the exceptional regularized [origin value](../../LMLFTest/Definitions/Hypergeometric.lean#L31);
- ordinary and regularized analyticity through downstream differentiability consumers at
  [lines 34](../../LMLFTest/Definitions/Hypergeometric.lean#L34) and
  [39](../../LMLFTest/Definitions/Hypergeometric.lean#L39).

## Dependency boundary

The production module is a Mathlib-only leaf:

```text
Mathlib regularized/ordinary series and analytic support
  -> LMLF.Definitions.Hypergeometric
  -> LMLF.Definitions
  -> LMLF.Results
```

It imports no project Gamma wrapper, ODE module, umbrella, Legendre or Bessel development, or
numerical layer. It reuses Mathlib's ordinary and regularized formal series, coefficients, Gamma,
radius bounds, sums, and analytic machinery. No duplicate formal series, coefficient definition,
Gamma alias, generalized-hypergeometric framework, continuation object, or ODE framework is
introduced.
