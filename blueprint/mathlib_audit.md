# Local Mathlib feasibility audit

Date: 2026-09-05

This audit records historical checks against locally installed Lean and Mathlib sources together with
separately bound external scratch evidence. It deliberately separates existing Mathlib declarations,
unbound audit-session observations, and interfaces that this project still has to define. The exact
specification commit `073a5675ffaba33c5bec52de00d525165aa17ff4` contains no Lean project, toolchain
files, or implementation; this document does not treat untracked working-tree files as evidence for that
snapshot.

## Status terminology

- **Historical API audit** means the declaration and its defining import were found in the audit-session
  Mathlib source. The identifiers in the declaration matrix were reported to pass a consolidated `#check`
  in that session. Unless a separate artifact is cited, this is an unbound local observation rather than a
  reproducible check of the exact specification commit.
- **Historical compiled spike** means a standalone prototype was reported accepted by `lake env lean` in
  the earlier audit session. It is feasibility evidence only: no committed implementation or exact-snapshot
  build is implied.
- **Bound external scratch evidence** means a separate evidence record supplies the specification commit,
  source and artifact digests, exact toolchain/Mathlib revisions, command, and exit status. It can establish
  signature elaboration for the bytes it binds, but is neither repository implementation nor acceptance.
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

The baseline was observed in an earlier local working session, but the exact specification commit does not
contain `lean-toolchain`, `lakefile.toml`, `lake-manifest.json`, `.lake/packages/mathlib`, or any Lean
source. Accordingly the historical clean-checkout statement is not a property of that commit. The
separate QB scratch record below binds this Lean/Mathlib pair for its one compile-only test.

The earlier audit session reported local Lean installations at v4.29.0, v4.33.0, v4.33.1, and
v4.34.0-rc2. It also reported searching a v4.34.0-rc2 Mathlib checkout at commit
`69fae596b29969db7afb6ac4a40653e882274410` without finding the missing named special-function or
Euler--Maclaurin facilities relevant here. That comparison is historical search evidence, not an
exact-specification build record. The stable v4.33.1 pair remains the recommended baseline.

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
`hasDerivAt_bernoulliFun`, `intervalIntegrable_bernoulliFun`, and
`periodizedBernoulli`, together with Fourier-related facts.  At the pinned
revision,

```lean
def periodizedBernoulli (k : ℕ) : UnitAddCircle → ℝ :=
  AddCircle.liftIco 1 0 (bernoulliFun k)
```

uses the representative in `[0,1)`.  Its pullback along `ℝ → UnitAddCircle`
therefore agrees with `bernoulliFun k (Int.fract x)`, including the
source-critical integer value `B₁(0) = -1/2`.  Mathlib exposes continuity of
this circle function for `k ≠ 1`; the exclusion records the genuine jump in
the first periodic Bernoulli function.  Useful supporting declarations include
`bernoulli_one`, `Polynomial.bernoulli_def`,
`Polynomial.bernoulli_eval_zero`, `Polynomial.derivative_bernoulli`,
`bernoulliFun_eval_one`, `bernoulliFun_eq_integral`,
`bernoulliFun_eval_half`, `Int.fract_intCast`, and
`periodizedBernoulli.continuous`.

Consequently the project must not define a second periodization.  A bounded
Bernoulli identification packet can reuse Mathlib's numbers and polynomials
without new semantic declarations.  The method layer needs only a real-line
facade for `periodizedBernoulli`, the factorial conversion to Olver's
`ω_s = B_s({x}) / s!`, and the missing cellwise calculus and envelope lemmas.

No Euler--Maclaurin theorem or directly reusable finite periodic-Bernoulli
remainder expansion was found in either searched snapshot. Such a method
module is new formalization work, although the Bernoulli periodization and
integration primitives already exist.

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

## Compilation evidence

Project names below are not claims about existing Mathlib declarations. Each subsection says whether its
evidence is bound external scratch evidence or only an unbound historical audit-session observation.

### Explicit finite-error algebra — bound external scratch evidence

The current frozen QB surface consists of the three definitions `ErrorOn`, `NormBoundOn`, and
`HasErrorFamily`, together with the five lemmas `ErrorOn.exact`, `ErrorOn.restrict`, `ErrorOn.weaken`,
`ErrorOn.trans`, and `ErrorOn.comp`. A scratch file reproducing those eight signatures in declaration
order and importing only `LMLF.Basic` compiled with exit status zero under Lean v4.33.1 and Mathlib
commit `0df444a360eaa60ab8c11dca51a86af692955474`.

The exact command, revisions, source and manifest digests, and empty standard output/error are recorded in
[QB-001 scratch build evidence](/home/codex/Documents/Codex/2026-09-05/LMLF-review-evidence/scratch/QB-001-build-evidence.md);
the compiled source is
[QB-001-signatures.lean](/home/codex/Documents/Codex/2026-09-05/LMLF-review-evidence/scratch/QB-001-signatures.lean).
This is external compile-only evidence for signature elaboration. It is not a repository implementation,
does not establish the frozen proof bodies as an implementation, and does not authorize Lean work.

An earlier unbound audit-session prototype used the now-superseded name `HasFiniteExpansion` and checked
only four of the five `ErrorOn` lemmas. That historical result must not be cited as validation of the
current eight-signature QB surface. The current scratch evidence supports the feasibility of the explicit
finite-error interface; the filter-based Mathlib asymptotics API remains an internal derivation substrate,
not a replacement for that public layer.

### Gamma identification wrapper — historical audit-session observation

The earlier audit session reported compiling the following theorem body under the obsolete project
namespace `Olver.Definitions`. The current planned spelling is shown below with `LMLF.Definitions`, but no
new compile of this renamed declaration is claimed here:

```lean
import Mathlib.Analysis.SpecialFunctions.Gamma.Basic

open MeasureTheory Set

namespace LMLF.Definitions

theorem gamma_eq_eulerIntegral {s : ℂ} (hs : 0 < s.re) :
    Complex.Gamma s =
      ∫ t in Set.Ioi (0 : ℝ),
        (Real.exp (-t) : ℂ) * (t : ℂ) ^ (s - 1) := by
  simpa only [Complex.GammaIntegral] using Complex.Gamma_eq_integral hs

end LMLF.Definitions
```

Here `LMLF.Definitions.gamma_eq_eulerIntegral` is a planned project wrapper. The theorem after `using` is
the Mathlib declaration found in the historical API audit. The old prototype supports the proof idea but,
without a bound current-namespace compile record, does not establish a repository implementation.

### Regularized hypergeometric summation — historical audit-session observation

A project lemma asserting

```lean
HasSum (fun n : ℕ =>
  Complex.regularizedHGFunCoeff a b n * z ^ n)
  (Complex.regularizedHGFun a b z)
```

under `a.card ≤ b.card` was reported to compile from
`Complex.radius_regularizedHGFunSeries_eq_top` and
`FormalMultilinearSeries.hasSum`. This confirms that regularized `₀F₁` has a working entire-series
foundation without a new convergence proof.

### Cauchy transport to `ErrorOn` — historical audit-session observation

The proposed project theorem `errorOn_iteratedDeriv_of_disks` was reported to compile with:

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
with `iteratedDeriv_sub`. This is historical feasibility evidence at the audit-session dependency version,
not an exact-specification build claim.

Neither the bound QB scratch check nor the historical spikes compiled a complete geometric-series case
study, named Airy family, or complete Euler--Maclaurin/ODE method module; this report does not claim those
milestones are already proved.

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

The smallest milestone supported by current bound scratch evidence is the QB portion of an **M0/M1
bootstrap**, not a repository implementation and not the full special-function roadmap:

1. Establish a committed package and exact pin, then implement the externally scratch-checked QB surface:
   `ErrorOn`, `NormBoundOn`, `HasErrorFamily`, `ErrorOn.exact`, `ErrorOn.restrict`, `ErrorOn.weaken`,
   `ErrorOn.trans`, and `ErrorOn.comp`, behind the single frozen `LMLF.Basic` import.
2. Compile the current `LMLF.Definitions` Gamma wrapper and bind the result; the present evidence for that
   wrapper is only the superseded-namespace historical spike.
3. Re-run and bind the Cauchy derivative-transport theorem before treating it as executable milestone
   evidence.
4. Use a small exact finite example, such as the geometric remainder, as the first end-to-end acceptance
   theorem. This example itself was not part of the compiled spikes and must still be checked.

Airy should not block the bootstrap milestone. When named functions begin, regularized `₀F₁` is the
preferred first substrate for sharing coefficient, convergence, and analyticity work between Airy and
Bessel kernels. Bessel `Y`/Hankel continuation, generic analytic branch records, Euler--Maclaurin, and
complex analytic ODE methods should be scheduled as explicit later work packages rather than assumed to
be available upstream.
