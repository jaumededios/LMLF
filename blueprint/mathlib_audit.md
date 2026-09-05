# Local Mathlib feasibility audit

Date: 2026-09-05

This audit records what was checked against locally installed Lean and Mathlib sources, and what was
confirmed by compiling small Lean files. It deliberately separates existing Mathlib declarations from
interfaces that this project still has to define.

## Status terminology

- **Verified existing API** means the declaration and its defining import were found in the pinned local
  Mathlib source. Every identifier listed in the declaration matrix also passed a consolidated `#check`
  run under that pin.
- **Compiled spike** means a standalone prototype was accepted by `lake env lean` against the pinned
  snapshot. Such a theorem is a viable project interface; it is not thereby an existing Mathlib theorem.
- **Planned project interface** means a name or abstraction proposed by the blueprint but not currently
  supplied by Mathlib.
- Negative availability claims below come from searches of the complete local Mathlib trees for both
  v4.33.1 and the available v4.34.0-rc2 snapshot. They are not claims about all future Mathlib versions.

## Toolchain and dependency pin

The recommended reproducible baseline is:

```text
Lean:                 leanprover/lean4:v4.33.1
Mathlib tag:          v4.33.1
Resolved Mathlib SHA: 0df444a360eaa60ab8c11dca51a86af692955474
```

This is already expressed by the repository's `lean-toolchain`, `lakefile.toml`, and
`lake-manifest.json`. The cached Mathlib checkout at `.lake/packages/mathlib` is clean, is exactly at
the SHA above, and is tagged `v4.33.1`.

The local machine also has Lean v4.29.0, v4.33.0, v4.33.1, and v4.34.0-rc2. A v4.34.0-rc2 Mathlib
checkout at commit `69fae596b29969db7afb6ac4a40653e882274410` was searched as a comparison. It did
not add any of the missing named special-function or Euler--Maclaurin facilities relevant here. A stable
v4.33.1 pin is therefore preferable to taking an RC without an API benefit.

## Verified import and declaration matrix

### Gamma

Import `Mathlib.Analysis.SpecialFunctions.Gamma.Basic` provides:

- `Complex.GammaIntegral_convergent`
- `Complex.GammaIntegral`
- `Complex.partialGamma`
- `Complex.tendsto_partialGamma`
- `Complex.Gamma`
- `Complex.Gamma_eq_integral`
- `Complex.Gamma_add_one`
- `Complex.Gamma_zero`
- `Complex.Gamma_neg_nat_eq_zero`
- `Complex.Gamma_ofReal`
- `Complex.integral_cpow_mul_exp_neg_mul_Ioi`
- `Complex.Gamma_nat_eq_factorial`
- `Real.Gamma`
- `Real.Gamma_eq_integral`
- `Real.Gamma_eq_zero_iff`
- `Real.integral_rpow_mul_exp_neg_mul_Ioi`
- `Real.Gamma_nat_eq_factorial`

Import `Mathlib.Analysis.SpecialFunctions.Gamma.Deriv` additionally provides
`Complex.differentiableAt_Gamma`, `Complex.tendsto_self_mul_Gamma_nhds_zero`, and
`Complex.not_continuousAt_Gamma_neg_nat`.

Mathlib's complex `Gamma` is totalized to zero at nonpositive integers. There is no corresponding global
complex `Gamma_eq_zero_iff` declaration. `Complex.partialGamma` is a finite integral from zero to a real
upper endpoint; it is not a complete conventional lower/upper incomplete-Gamma API.

### Hypergeometric series and the regularized `0F1` substrate

Import `Mathlib.Analysis.SpecialFunctions.OrdinaryHypergeometric` provides the root declarations:

- `ordinaryHypergeometricCoefficient`
- `ordinaryHypergeometricSeries`
- `ordinaryHypergeometric`, with notation `₂F₁`
- `ordinaryHypergeometric_eq_tsum`
- `ordinaryHypergeometricSeries_radius_eq_one`

The definition explicitly takes the junk value zero outside its convergence radius; it does not provide
analytic continuation of `₂F₁`.

Import `Mathlib.Analysis.SpecialFunctions.RegularizedHypergeometric` provides:

- `Complex.regularizedHGFunCoeff`
- `Complex.regularizedHGFunSeries`
- `Complex.regularizedHGFun`
- `Complex.radius_regularizedHGFunSeries_eq_top`
- `Complex.regularizedGaussHGFun`
- `Complex.ordinaryHypergeometric_div_Gamma_eq`

For `a.card ≤ b.card`, `Complex.radius_regularizedHGFunSeries_eq_top` makes the defining power series
entire. The standard `FormalMultilinearSeries.hasSum`, `hasFPowerSeriesOnBall`, and
`HasFPowerSeriesOnBall.analyticOnNhd` infrastructure can then supply convergence and analyticity.

This gives a particularly useful existing substrate for the regularized `₀F₁` kernel:

```lean
Complex.regularizedHGFun 0 {c} z
```

Its coefficient specializes to

```lean
1 / ((n.factorial : ℂ) * Complex.Gamma (c + n))
```

Consequently, later Airy and Bessel constructions should first investigate definitions through this
single existing kernel, rather than independently rebuilding coefficient convergence for each family.
Parameter continuation, connection formulae, and named classical-function normalization remain project
work.

### Cauchy estimates and analytic derivative transport

Import `Mathlib.Analysis.Complex.Liouville` provides:

- `Complex.norm_deriv_le_of_forall_mem_sphere_norm_le`
- `Complex.norm_iteratedDeriv_le_of_forall_mem_sphere_norm_le`

The latter has the usable shape

```lean
(n : ℕ) (hR : 0 < R)
(hf : DiffContOnCl ℂ f (Metric.ball c R))
(hC : ∀ z ∈ Metric.sphere c R, ‖f z‖ ≤ C) :
  ‖iteratedDeriv n f c‖ ≤ (n.factorial : ℝ) * C / R ^ n
```

For an error estimate on `f - a`, also import
`Mathlib.Analysis.Calculus.IteratedDeriv.Lemmas`, which supplies `iteratedDeriv_sub`. The analytic
side-condition needed by that lemma can be derived locally from `DiffContOnCl.differentiableOn`,
`DifferentiableOn.analyticAt`, and `AnalyticAt.contDiffAt`.

### Real restriction and principal branches

Import `Mathlib.Analysis.Complex.RealDeriv` provides:

- `HasDerivAt.real_of_complex`
- `HasDerivAt.comp_ofReal`
- `HasDerivAt.ofReal_comp`
- `ContDiffAt.real_of_complex`
- `Differentiable.real_of_complex`

Import `Mathlib.Analysis.SpecialFunctions.Complex.Log` provides `Complex.slitPlane`,
`Complex.isOpen_slitPlane`, `Complex.slitPlane_ne_zero`, `Complex.exp_log`, and `Complex.log_exp`.

Import `Mathlib.Analysis.SpecialFunctions.Complex.Analytic` provides the root declarations
`analyticAt_clog` and `iteratedDeriv_succ_log`, as well as `AnalyticAt.clog`, `AnalyticOnNhd.clog`,
`AnalyticAt.cpow`, and `AnalyticOnNhd.cpow`. The root declarations are not in the `Complex` namespace.

Import `Mathlib.Analysis.SpecialFunctions.Pow.Complex` provides `Complex.cpow_def_of_ne_zero`.
Import `Mathlib.Analysis.Complex.SqrtDeriv` provides `Complex.hasDerivAt_sqrt` and
`Complex.differentiableOn_sqrt`.

Import `Mathlib.Analysis.Complex.BranchLogRoot` provides
`Complex.exists_continuousOn_eqOn_exp_comp` and `Complex.exists_continuousOn_pow_eq`. These establish
continuous branches under simply-connectedness and nonvanishing hypotheses. They do **not** directly
instantiate the blueprint's planned analytic `LogBranchOn` interface. Principal slit-plane charts are
well supported; a reusable theorem upgrading a continuous logarithm branch of an analytic nonvanishing
map to an analytic branch is still needed for the generic interface.

### Finite Taylor estimates and asymptotics

Imports `Mathlib.Analysis.Asymptotics.Defs` and `Mathlib.Analysis.Asymptotics.Lemmas` provide
`Asymptotics.IsBigOWith`, `IsBigO`, and `IsLittleO`; `IsBigOWith.bound` recovers an eventual explicit
norm inequality. These filter-based declarations are useful internally but do not satisfy the blueprint's
terminal requirement for an explicit domain and finite error function.

Import `Mathlib.Analysis.Calculus.Taylor` provides `taylor_mean_remainder_bound` and
`taylor_integral_remainder`. Import `Mathlib.Analysis.Calculus.TaylorIntegral` provides
`map_add_eq_sum_add_integral_iteratedFDeriv`. These are reusable ingredients, not a ready-made finite
asymptotic-expansion API with the blueprint's public shape.

### Integration and summation by parts

Import `Mathlib.MeasureTheory.Integral.IntervalIntegral.IntegrationByParts` provides:

- `intervalIntegral.integral_mul_deriv_eq_deriv_mul`
- `intervalIntegral.integral_smul_deriv_eq_deriv_smul`
- the corresponding `_of_hasDerivAt`, `_of_hasDerivWithinAt`, and `_of_hasDeriv_right` variants

Import `Mathlib.MeasureTheory.Integral.IntegralEqImproper` provides:

- `MeasureTheory.integral_Ioi_mul_deriv_eq_deriv_mul`
- `MeasureTheory.integral_Iic_mul_deriv_eq_deriv_mul`
- `MeasureTheory.integral_mul_deriv_eq_deriv_mul`

These retain explicit boundary terms and form a sound basis for oscillatory integration by parts. Bounds
involving a complex phase, lower bounds on its derivative, and explicit repeated-remainder constants are
planned project results.

Import `Mathlib.Algebra.BigOperators.Module` provides `Finset.sum_Ico_by_parts`,
`Finset.sum_Ioc_by_parts`, and `Finset.sum_range_by_parts`. Import
`Mathlib.NumberTheory.AbelSummation` provides the root declarations
`sum_mul_eq_sub_sub_integral_mul` and `sum_mul_eq_sub_integral_mul`.

### Bernoulli material and Euler--Maclaurin

Import `Mathlib.NumberTheory.BernoulliPolynomials` provides:

- root `bernoulli`
- `Polynomial.bernoulli`
- `Polynomial.derivative_bernoulli`
- `Polynomial.sum_range_pow_eq_bernoulli_sub`

Import `Mathlib.NumberTheory.ZetaValues` provides root `bernoulliFun`,
`hasDerivAt_bernoulliFun`, and `intervalIntegrable_bernoulliFun`, together with Fourier-related facts.

No Euler--Maclaurin theorem, periodic-Bernoulli remainder package, or directly reusable finite
Euler--Maclaurin expansion was found in either searched snapshot. Such a method module is new formalization
work, although the Bernoulli and integration primitives already exist.

### ODEs, Gronwall estimates, and contraction mappings

Import `Mathlib.Analysis.ODE.Gronwall` provides:

- root `gronwallBound`
- `gronwallBound_of_K_ne_0`
- `norm_le_gronwallBound_of_norm_deriv_right_le`
- `dist_le_of_approx_trajectories_ODE`
- `dist_le_of_trajectories_ODE`

Import `Mathlib.Analysis.ODE.ExistUnique` provides `IsPicardLindelof`,
`IsPicardLindelof.exists_eq_forall_mem_Icc_hasDerivWithinAt`, `ODE_solution_unique`, and
`ODE_solution_unique_univ`.

Import `Mathlib.Topology.MetricSpace.Contracting` provides
`ContractingWith.dist_le_of_fixedPoint`, `ContractingWith.fixedPoint_isFixedPt`,
`ContractingWith.dist_fixedPoint_le`, and `ContractingWith.fixedPoint_lipschitz_in_map`.

The ODE library is formulated for real time, although its state space may be complex as a real normed
space. It does not directly supply complex-holomorphic IVP uniqueness, analytic second-order linear ODE
theory, Frobenius theory, Volterra/factorial iterates, Liouville--Green transformations, progressive
paths, or analytic Wronskian infrastructure. These are substantial later method modules, not thin wrappers.

## Compiled spikes

The following facts concern project prototypes compiled with `lake env lean`; their project names are not
claims about existing Mathlib declarations.

### Explicit finite-error algebra

The blueprint definitions `ErrorOn`, `NormBoundOn`, and `HasFiniteExpansion`, together with project
lemmas `ErrorOn.restrict`, `ErrorOn.weaken`, `ErrorOn.trans`, and `ErrorOn.comp`, compiled using only:

```lean
import Mathlib.Analysis.Normed.Group.Basic
import Mathlib.Data.Set.Function
import Mathlib.Tactic.Abel
```

This confirms that the explicit finite-error layer has a small and stable dependency surface. The
filter-based Mathlib asymptotics API should support internal derivations rather than replace this public
layer.

### Gamma identification wrapper

The blueprint's Euler-integral identification compiled exactly:

```lean
import Mathlib.Analysis.SpecialFunctions.Gamma.Basic

open MeasureTheory Set

namespace Olver.Definitions

theorem gamma_eq_eulerIntegral {s : ℂ} (hs : 0 < s.re) :
    Complex.Gamma s =
      ∫ t in Set.Ioi (0 : ℝ),
        (Real.exp (-t) : ℂ) * (t : ℂ) ^ (s - 1) := by
  simpa only [Complex.GammaIntegral] using Complex.Gamma_eq_integral hs

end Olver.Definitions
```

Here `Olver.Definitions.gamma_eq_eulerIntegral` is a planned/project wrapper; the theorem after `using`
is the verified existing Mathlib result.

### Regularized hypergeometric summation

A project lemma asserting

```lean
HasSum (fun n : ℕ =>
  Complex.regularizedHGFunCoeff a b n * z ^ n)
  (Complex.regularizedHGFun a b z)
```

under `a.card ≤ b.card` compiled from
`Complex.radius_regularizedHGFunSeries_eq_top` and
`FormalMultilinearSeries.hasSum`. This confirms that regularized `₀F₁` has a working entire-series
foundation without a new convergence proof.

### Cauchy transport to `ErrorOn`

The proposed project theorem `errorOn_iteratedDeriv_of_disks` compiled with:

```lean
import Mathlib.Analysis.Complex.Liouville
import Mathlib.Analysis.Calculus.IteratedDeriv.Lemmas
```

Its hypotheses use positive radii, `DiffContOnCl` for both functions on each ball, and a boundary-sphere
error bound. Its conclusion is the explicit estimate

```lean
ErrorOn D (iteratedDeriv k f) (iteratedDeriv k a)
  (fun z => (k.factorial : ℝ) * b z / (r z) ^ k)
```

The proof applies `Complex.norm_iteratedDeriv_le_of_forall_mem_sphere_norm_le` to `f - a` and rewrites
with `iteratedDeriv_sub`. Thus the intended Cauchy derivative-transport layer is feasible on the pinned
release.

These spikes did not compile a complete geometric-series case study, named Airy family, or complete
Euler--Maclaurin/ODE method module; this report does not claim those milestones are already proved.

## Confirmed major gaps

No named Mathlib implementation was found for:

- Airy `Ai` or `Bi`;
- Bessel `J`, `Y`, `I`, or `K`, or Hankel functions;
- a complete upper/lower incomplete-Gamma family;
- `erf`/`erfc`, Fresnel integrals, or exponential/sine/cosine integrals;
- parabolic-cylinder or Whittaker functions;
- Euler--Maclaurin with an explicit remainder;
- complex analytic linear-ODE/Frobenius and Liouville--Green method packages.

There are unrelated uses of the word “Bessel” for inequalities and potentials; these are not the
classical Bessel special functions. Ordinary `₂F₁` and regularized generalized hypergeometric series
are useful construction substrates but do not provide the blueprint's named families, branches,
parameter regularity, continuation, or connection formulas.

## Recommended smallest foundation milestone

The smallest milestone already supported by compiled evidence is an **M0/M1 bootstrap**, not the full
special-function roadmap:

1. Establish the pinned package and a minimal quantitative core containing `ErrorOn`, `NormBoundOn`,
   `HasFiniteExpansion`, and the four verified error-algebra lemmas.
2. Add the thin Gamma definition/identification wrapper and an umbrella definitions import.
3. Add the verified Cauchy derivative-transport theorem as the next independent analytic module.
4. Use a small exact finite example, such as the geometric remainder, as the first end-to-end acceptance
   theorem. This example itself was not part of the compiled spikes and must still be checked.

Airy should not block the bootstrap milestone. When named functions begin, regularized `₀F₁` is the
preferred first substrate for sharing coefficient, convergence, and analyticity work between Airy and
Bessel kernels. Bessel `Y`/Hankel continuation, generic analytic branch records, Euler--Maclaurin, and
complex analytic ODE methods should be scheduled as explicit later work packages rather than assumed to
be available upstream.
