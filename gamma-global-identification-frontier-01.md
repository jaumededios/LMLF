# Gamma global-identification frontier 01

## Status and decision

This is a read-only pinned-Mathlib availability audit. It is not a source
identification, proof dossier, implementation, theorem card, readiness decision,
source approval, or coverage evidence. The repository snapshot is clean `main`
at `b8d2f731fcfd5cd0889d0732f13699eb94681c86`, with Lean `v4.33.1` and Mathlib
`0df444a360eaa60ab8c11dca51a86af692955474`.

Decision: the pin already supplies global meromorphy of canonical
`Complex.Gamma`, complex differentiability at every nonpole, and an entire
reciprocal. It also supplies a global identity theorem strong enough to identify
two entire reciprocal-Gamma candidates from agreement on the Euler half-plane.
Thus the preferred noncircular route is direct pinned reuse through reciprocal
Gamma, provided a finite source binding really supplies the corresponding
meromorphic continuation or entire reciprocal. No new Gamma construction or
recurrence-as-its-own-identification premise is justified.

## Exact available Gamma API

### Holomorphy away from nonpositive integers

Import `Mathlib.Analysis.SpecialFunctions.Gamma.Deriv` provides:

`Complex.differentiableAt_Gamma (s : ℂ)`
`  (hs : ∀ m : ℕ, s ≠ -(m : ℂ)) : DifferentiableAt ℂ Complex.Gamma s`.

The exact source is `Gamma/Deriv.lean:64-83`. The same file has
`Complex.continuousAt_Gamma` with the identical nonpole hypothesis
(`:88-89`). This is pointwise complex differentiability at every nonpole. No
named theorem packaging `AnalyticOnNhd ℂ Complex.Gamma` on the complement of
the nonpositive integers was found; that set-level facade is derivable but is
not needed for the reciprocal route.
The same import proves

`Complex.tendsto_self_mul_Gamma_nhds_zero :`
`  Tendsto (fun z : ℂ ↦ z * Complex.Gamma z) (𝓝[≠] 0) (𝓝 1)`

at `Gamma/Deriv.lean:94-98`, and noncontinuity at every totalized pole via
`Complex.not_continuousAt_Gamma_neg_nat (n : ℕ)` at `:107-124`.

### Nonvanishing and entire reciprocal

Import `Mathlib.Analysis.SpecialFunctions.Gamma.Beta` provides:

`Complex.Gamma_ne_zero {s : ℂ}`
`  (hs : ∀ m : ℕ, s ≠ -(m : ℂ)) : Complex.Gamma s ≠ 0`,

`Complex.Gamma_eq_zero_iff (s : ℂ) :`
`  Complex.Gamma s = 0 ↔ ∃ m : ℕ, s = -(m : ℂ)`,

and

`Complex.differentiable_one_div_Gamma :`
`  Differentiable ℂ (fun s : ℂ ↦ (Complex.Gamma s)⁻¹)`.

Their exact locations are `Gamma/Beta.lean:425-455` and `:500-535`. The last
theorem is global, including the totalized poles. With
`analyticOnNhd_univ_iff_differentiable` from
`Mathlib.Analysis.Complex.CauchyIntegral` (`CauchyIntegral.lean:682-686`), it is
exactly an entire-function theorem for reciprocal Gamma.

The reciprocal zero set follows directly from `inv_eq_zero` and
`Complex.Gamma_eq_zero_iff`, but no named reciprocal-Gamma zero-set theorem was
found. That is a small algebraic bridge, not new continuation mathematics.

### Global meromorphy

Import `Mathlib.Analysis.Meromorphic.Complex` provides exactly:

`MeromorphicNFOn.Gamma :`
`  MeromorphicNFOn Complex.Gamma Set.univ`,

`Meromorphic.Gamma : Meromorphic Complex.Gamma`,

`MeromorphicOn.Gamma {s : Set ℂ} : MeromorphicOn Complex.Gamma s`.

These are at `Analysis/Meromorphic/Complex.lean:19-29`. The normal-form theorem
is stronger than bare meromorphy: at a pole it selects the representative whose
point value is zero. Its proof is already routed through the entire reciprocal,
so it does not provide an independent source convention for values at poles.

## Pole order and residue boundary

The pin has the punctured-neighborhood limit giving a simple pole with residue
one at zero. It also has meromorphy and noncontinuity at every `-n`. The bounded
search found no Gamma theorem computing
`meromorphicOrderAt Complex.Gamma (-(n : ℂ)) = -1`, no theorem saying reciprocal
Gamma has a simple zero at every `-n`, and no general residue formula
`(-1)^n / n!`. Therefore exact simple-pole/order/residue data away from zero is
genuinely missing as named Gamma mathematics at this pin. It could likely be
derived from the zero case and recurrence, but that would be new proof work and
is beyond this audit.

## Available uniqueness infrastructure

Import `Mathlib.Analysis.Analytic.Uniqueness` provides the specialized shape

`AnalyticOnNhd.eq_of_eventuallyEq`
`  (hf : AnalyticOnNhd ℂ f Set.univ)`
`  (hg : AnalyticOnNhd ℂ g Set.univ)`
`  (hfg : f =ᶠ[𝓝 z₀] g) : f = g`,

at `Analytic/Uniqueness.lean:230-237`. Import
`Mathlib.Analysis.Analytic.IsolatedZeros` additionally provides
`AnalyticOnNhd.eq_of_frequently_eq` at `IsolatedZeros.lean:256-264` when only an
accumulating equality set is convenient. The neighborhood version is enough:
choose a positive-real-part base point, and Euler-half-plane agreement supplies
local agreement there.

The meromorphic search found local punctured-neighborhood identity principles
in `Analysis/Meromorphic/IsolatedZeros.lean`, but no single global theorem
identifying two arbitrary meromorphic functions from one germ. Since
meromorphic functions may differ at isolated point values, any such statement
must specify equality off a discrete set or normal-form representatives. The
entire-reciprocal route avoids that missing facade and avoids proving that the
pole-free plane is connected.

## Finite noncircular route, conditional on source binding

For a future source candidate `G`, the source contract must first fix what `G`
is, whether it is a meromorphic Gamma continuation or its reciprocal, its pole
and totalization convention, and its agreement with the Euler integral on
`Re s > 0`. Nothing in this audit invents those facts.

If the contract supplies an entire reciprocal `R` and proves on the Euler
half-plane that `R s = (Complex.Gamma s)⁻¹`, convert pinned
`differentiable_one_div_Gamma` to `AnalyticOnNhd` and apply
`AnalyticOnNhd.eq_of_eventuallyEq` at any point with positive real part. This
gives global equality of the entire reciprocals. At each nonpole, use the
source-side nonvanishing/pole characterization and `Complex.Gamma_ne_zero` to
invert the equality and identify the finite Gamma values. Only after this global
entity identification may `Complex.Gamma_add_one` discharge the source-facing
full nonpole recurrence without circularity.

This route is fully available on the Mathlib side. The remaining work is finite
but source-specific: exact candidate and notation binding, Euler-germ overlap,
reciprocal entireness, pole/nonzero semantics, and the policy for values at
poles. If the source supplies only bare meromorphy and no entire reciprocal,
either a reviewed global meromorphic identity lemma or an equivalent
normal-form argument is still needed.

## Stop line

Stop here before drafting a new natural-language continuation proof or any Lean
declaration. First freeze the actual source characterization and convention,
then obtain the required independent mathematical and structural/circularity
reviews. The canonical object remains `Complex.Gamma`; no production file,
wrapper, source inventory, CI, commit, or remote action is authorized here.
