# Chapter 5: principal Gauss specializations

## Status, source, and exact boundary

**Status: mathematics and Lean implementation accepted.** Two fresh independent mathematical
referees read the complete natural-language proof before Lean implementation began and accepted
the four-declaration slice, including the direct-owner import refinement. After implementation, a
fresh code referee read the complete production and test leaves and returned `ACCEPT` with no
actionable finding. Root then read all source, tests, and reports, reproduced the full local build
and scoped checks, and accepted exactly `C05-09-06`.

The frozen 527-line proof packet has SHA-256
`f9408f690b9ba009010bec10c47da7e15c37d98a398bedcb532ebc1afc0879a5`. The independent
mathematical reports have SHA-256
`f3e78b9ef8de5985b6688191d9f228b2a9c36ac081e3b333fa8274ddd2959995` and
`6e933551e95d749e2187b3d8579022385e1c40bdc95efad9d7da3cc594070f55`; the 73-line fresh code
report has SHA-256
`3ecbab5b1de7ecb100242ea6e970b6e2aca38b3e18c9deb15945815214673a9a`.

The accepted implementation bytes are:

- [the 113-line production leaf](../../LMLF/Results/HypergeometricPrincipalSpecializations.lean),
  SHA-256 `6d77b9697ea1d2e3397d8bf26024534841a153ecb1b0bc23eaa364f9d04313ee`;
- [the 110-line focused test](../../LMLFTest/Results/HypergeometricPrincipalSpecializations.lean),
  SHA-256 `b4e2587f8714a8ea7a7399971a789ce233e9d0cf1bd631e5cbe3b6ab70ae7157`;
- [`LMLF/Results.lean`](../../LMLF/Results.lean), SHA-256
  `6006ad20fc438de952adfde1539a3863db22790fc9ba09ab70b401eaa1cd1b33`;
- [`lakefile.toml`](../../lakefile.toml), SHA-256
  `04e9c0dc571495527c7d9074013a622b6f6260c2902126f83b10eb7222f69c69`.

The toolchain is Lean `4.33.1`, with Mathlib pinned at
`0df444a360eaa60ab8c11dca51a86af692955474`. The reviewed base commit is
`18531f4d109c600f6c9a9248fcf5c8fd4db8dd48`. This page binds the bytes above rather than an
in-flight commit.

Source: Frank W. J. Olver, *Asymptotics and Special Functions*, corrected A K Peters reprint
(1997) of the 1974 edition, Chapter 5, printed p. 160, §9.3. This is not established as a second
edition. The source gives the principal identity

\[
  F(a,1;1;z)=(1-z)^{-a},
\]

and singles out `a=1`, where the geometric series represents `F(1,1;1;z)`. The continued identity
belongs on the principal cut plane; the infinite series converges on `|z|<1`. This page contains
original exposition, not a scan, OCR transcription, or extended quotation.

The slice proves precisely the printed specialization, its regularized `c=1` consequence under
Olver's Gamma convention, the reciprocal case, and the corresponding `HasSum`. A general `b=c`
identity is deferred. There is no theorem on the removed ray, no convergence assertion outside the
unit disk, and no Euler-integral or Gauss-at-one result. Thus `C05-09-04`, `C05-09-07`, and
`C05-09-08` remain pending. At this accepted checkpoint Chapter 5 stands at
`17/108 = 15.74%` claim components, `3/13 = 23.08%` whole numbered theorems, and `0/44 = 0%`
exercises; the [Chapter 5 checklist](chapter05.md) is the authority for current totals.

## 1. Domain and branch

Write `D = gaussHypergeometricDomain = ℂ \ [1,+∞)`. With Mathlib's `ComplexOrder`,

\[
  1-z\in\operatorname{Complex.slitPlane}
  \Longleftrightarrow \neg(1-z\le0)
  \Longleftrightarrow \neg(1\le z)
  \Longleftrightarrow z\in D.
\]

The steps are `Complex.mem_slitPlane_iff_not_le_zero`, `sub_nonpos`, and the definition of `D`.
Thus translation by `1-z` pulls the principal complex-power cut back exactly to `[1,+∞)`.

For fixed `a : ℂ`, put `v z = (1-z)^(-a)` using `Complex.cpow`. The affine base and constant
exponent are analytic, and the displayed cut calculation discharges the slit-plane hypothesis of
`AnalyticOnNhd.cpow`. Hence `v` is analytic on neighborhoods of all of `D`. This includes `z=0`,
where the base is one; the sole zero of the base, `z=1`, is excluded.

## 2. Complete disk-germ proof

Let

\[
 S=\operatorname{ordinaryHypergeometricSeries}_{\mathbb C}(a,1,1),\quad
 B=\operatorname{binomialSeries}_{\mathbb C}(-a),\quad
 N=-\operatorname{ContinuousLinearMap.id}.
\]

The ordinary-series theorem requires `1 ≠ -(n : ℂ)`, while the binomial comparison requires
`(n : ℂ) ≠ -1`. Each follows by taking real parts and using nonnegativity of natural numbers. They
remain separate private helpers; no parameter-side-condition API is added.

Instantiate `binomialSeries_eq_ordinaryHypergeometricSeries` with exponent `-a` and auxiliary
parameter `1`. This gives `B = S.compContinuousLinearMap N`: the exponent sign makes the first
Gauss parameter `-(-a)=a`, while `N` changes the argument to `-x`. The existing local Gauss theorem
supplies a power series for `gaussHypergeometricSeriesSum a 1 1` with formal series `S`, center
zero, and radius one. Compose it with `N`. The center stays zero, `‖N‖ₑ=1`, and the returned radius
normalizes to one, producing

\[
 \operatorname{HasFPowerSeriesOnBall}
  (x\mapsto\operatorname{gaussHypergeometricSeriesSum}(a,1,1,-x),B,0,1).
\]

Independently, `Complex.one_add_cpow_hasFPowerSeriesOnBall_zero` at exponent `-a` gives the same
formal series, center, and radius for `x ↦ (1+x)^(-a)`. If `‖x‖<1`, `Metric.eball_ofReal` supplies
the ENNReal ball membership needed by `.hasSum`. Both convergent sums then have literally the same
multilinear-series summand. `HasSum.unique` gives

\[
 \operatorname{gaussHypergeometricSeriesSum}(a,1,1,-x)=(1+x)^{-a}.
\]

Replacing `x` by `-z` proves the whole open-disk germ

\[
 \operatorname{gaussHypergeometricSeriesSum}(a,1,1,z)=(1-z)^{-a}\quad(‖z‖<1).
\]

This compares two genuine convergent sums and assigns no source meaning to a totalized `tsum`
outside its convergence domain.

## 3. Principal continuation and the two conventions

Reverse the disk equality to obtain the `EqOn` orientation required by
`gaussHypergeometric_eqOn_of_eqOn_seriesSum`. Together with analyticity of `v` and the denominator
condition at `c=1`, public whole-germ uniqueness proves equality throughout `D`:

```lean
theorem gaussHypergeometric_one_one
    (a : ℂ) {z : ℂ} (hz : z ∈ gaussHypergeometricDomain) :
    gaussHypergeometric a 1 1 z = (1 - z) ^ (-a)
```

The regularized result is intentionally a corollary. The public ambient convention bridge states
`gaussHypergeometric a 1 1 z / Complex.Gamma 1 = regularizedGaussHypergeometric a 1 1 z`.
Under `hz`, rewrite its numerator with the ordinary theorem, use `Complex.Gamma_one` and division
by one, and take symmetry:

```lean
theorem regularizedGaussHypergeometric_one_one
    (a : ℂ) {z : ℂ} (hz : z ∈ gaussHypergeometricDomain) :
    regularizedGaussHypergeometric a 1 1 z = (1 - z) ^ (-a)
```

Source review verified this internal dependency. Downstream tests show that the public results
compose, but opaque theorem proofs mean those implications alone cannot establish how the
regularized theorem was proved.

## 4. Geometric specialization

Set `a=1` in the ordinary theorem. `Complex.cpow_neg_one` proves

```lean
theorem gaussHypergeometric_geometric
    {z : ℂ} (hz : z ∈ gaussHypergeometricDomain) :
    gaussHypergeometric 1 1 1 z = (1 - z)⁻¹
```

If `‖z‖<1`, then `Complex.re_le_norm z` implies `z.re<1`, hence `z∈D`. The standard geometric
series theorem sums `z^n` to `(1-z)⁻¹`; rewrite its terminal value with the preceding identity:

```lean
theorem hasSum_gaussHypergeometric_geometric
    {z : ℂ} (hz : ‖z‖ < 1) :
    HasSum (fun n : ℕ ↦ z ^ n) (gaussHypergeometric 1 1 1 z)
```

The strict norm guard belongs to convergence, while the reciprocal identity holds on the larger
principal domain.

## 5. Public boundary, imports, and reuse

All four declarations are in namespace `LMLF.Definitions` and are the only non-private declarations
in the production leaf. Its three proof helpers are private; there is no new function, instance,
attribute, axiom, unsafe declaration, or public generalization. The imports are exactly:

```lean
import LMLF.ODE.Hypergeometric.Principal
import Mathlib.Analysis.Analytic.Binomial
```

The direct principal import supplies the continuation API and imports the local series API from
`LMLF.Definitions.Hypergeometric`; the specialization consumes both without importing
`LMLF.Results.HypergeometricPrincipal`. The Mathlib binomial module owns the new formal-series seam,
and exceptional-parameter results play no role. `LMLF/Results.lean` adds exactly one import, and
`lakefile.toml` adds exactly the production and test globs.

The test leaf imports only the production leaf. It consumes generic ordinary and regularized
identities, the convention bridge, origin normalization, terminating `a=-3`, nonterminating
`a=1/2`, the reciprocal, and the geometric `HasSum`. It checks that `1` and `2` are excluded and
also exercises upper- and lower-half-plane points beyond the disk. Its named
`LMLFTest.Results.principalGaussSpecializationConventionSeriesCertificate` composes all four public
APIs. These are regression consumers, not additional source coverage.

## 6. Verification and acceptance evidence

The fresh code referee independently checked both files directly with warnings as errors; the
production and test checks took 2.297 s and 2.251 s and emitted no output. Complete LSP outlines
recovered the exact imports, helpers, signatures, examples, and named certificate. Complete LSP
diagnostics returned `partial: false`, `success: true`, no items, and no failed dependencies.

Standard axiom and source scans passed for all four public theorems and the named certificate. Each
depends only on `propext`, `Classical.choice`, and `Quot.sound`; suspicious-source lists were empty.
Inventory and lexical scans found no `sorry`, `admit`, new axiom, unsafe declaration, or resource
override. Exact-import, declaration-count, forbidden-scope, pinned-version, hash, line-count, and
whitespace checks passed.

Root additionally reproduced the full local `lake build`: all 3,178 jobs completed successfully.
The positive inventory passed, and all 25 negative fixtures were rejected as required. Root also
repeated complete zero-diagnostic LSP checks, standard axiom/source checks on both power identities
and the named certificate, scoped wiring and frozen-hash checks, and `git diff --check`. No GitHub
CI was run or used for acceptance.
