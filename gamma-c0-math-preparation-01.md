# Gamma C0 mathematics preparation 01

## Status, snapshot, and bounded recommendation

This is a read-only natural-language/pinned-API correspondence dossier prepared 2026-09-06.
`Gamma C0` is only a preparation label. This file is not a source
inventory, theorem card, production identifier, signature freeze, readiness or
source-fidelity approval, implementation, test result, or coverage evidence.

The checked repository snapshot is clean `main` at `b8d2f731fcfd5cd0889d0732f13699eb94681c86`, with Lean `v4.33.1` and pinned
Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`. The existing
`LMLF/Definitions/Gamma.lean` already reuses `Complex.Gamma` and exports four
accepted wrappers: honest Euler-integrand integrability, Euler-integral
identification, real/complex agreement, and the totalized value at classical
poles. Do not define another Gamma object or add synonymous wrappers.

Recommended first execution family: the positive-half-plane Euler formula and
its integrability support, recurrence with source-honest pole restrictions,
positive-integer factorial values, and the real/complex bridge. Reflection and
duplication are recorded only as a possible next frontier. This dossier performs
no new Lean proof attempt.

## Limited official source discovery

Only the official DLMF pages [§5.2](https://dlmf.nist.gov/5.2), [§5.4](https://dlmf.nist.gov/5.4), and
[§5.5](https://dlmf.nist.gov/5.5) were consulted. No bulk source payload was
downloaded or retained. These locators are normalization and discovery aids,
not substitutes for an authorized exact source leaf or for occurrence,
notation, entity, and atom review.

The bounded source meanings are:

- [5.2.E1](https://dlmf.nist.gov/5.2.E1):
  `Gamma(z) = integral_0^infinity exp(-t) t^(z-1) dt`, only for `Re z > 0`;
- prose immediately following 5.2.E1: continuation is meromorphic, has no
  zeros, and has simple poles at `z = -n`; reciprocal Gamma is entire with
  zeros there;
- [5.4.E1](https://dlmf.nist.gov/5.4.E1): `Gamma(1)=1` and
  `n! = Gamma(n+1)` for nonnegative integers `n`;
- [5.5.E1](https://dlmf.nist.gov/5.5.E1):
  `Gamma(z+1)=z Gamma(z)`, understood for the classical meromorphic Gamma.

The DLMF annotations point to Olver pages, but that bibliographic note does not prove the exact locked-edition appearance, wording, formula boundary, or
normalization. Every omitted assertion from any future selected source leaf
remains a source-inventory and disposition obligation. In particular, selecting
only E1 from a leaf does not silently discharge neighboring prose, special
values, psi material, or other displayed equations.

## Exact pinned core correspondence

All declarations in this section are supplied by `Mathlib.Analysis.SpecialFunctions.Gamma.Basic`.
Source locators use the exact pinned commit.

### Euler integrability — structural analytic support

Pinned declaration:
`Complex.GammaIntegral_convergent {s : ℂ} (hs : 0 < s.re) :`
`  IntegrableOn (fun x : ℝ => (Real.exp (-x) : ℂ) * (x : ℂ) ^ (s - 1))`
`    (Set.Ioi 0) MeasureTheory.volume`

It is at
[Basic.lean lines 81–103](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/SpecialFunctions/Gamma/Basic.lean#L81-L103).
The exact existing project endpoint is
`LMLF.Definitions.gamma_eulerIntegrable` with the same hypothesis and expanded
integrand. This is structural support for the formula; it should receive an
independent source target only if the selected source atom actually asserts
convergence or integrability.

The integral is a set integral over the positive real axis. Since `x > 0`, the
coerced complex base lies on the positive real ray, so Mathlib's complex power
has the unambiguous positive-real logarithm normalization intended by
`t^(z-1)`. The explicit `IntegrableOn` theorem prevents a total set integral
from masquerading as a convergent improper integral.

### Euler value — ordinary exact identity

Pinned declarations:
`Complex.GammaIntegral (s : ℂ) : ℂ :=`
`  ∫ x in Set.Ioi (0 : ℝ), (Real.exp (-x) : ℂ) * (x : ℂ) ^ (s - 1)`

`Complex.Gamma_eq_integral {s : ℂ} (hs : 0 < s.re) :`
`  Complex.Gamma s = Complex.GammaIntegral s`
They occur at
[Basic.lean lines 105–111](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/SpecialFunctions/Gamma/Basic.lean#L105-L111)
and
[lines 319–320](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/SpecialFunctions/Gamma/Basic.lean#L319-L320).
The existing `LMLF.Definitions.gamma_eq_eulerIntegral` already exposes exactly
the expanded DLMF-shaped equality under `0 < s.re`. It is the preferred project
identification; no new bridge or duplicate facade is justified.

### Recurrence — ordinary exact identity with a semantic domain repair

Pinned declaration:
`Complex.Gamma_add_one (s : ℂ) (h2 : s ≠ 0) :`
`  Complex.Gamma (s + 1) = s * Complex.Gamma s`

It is at
[Basic.lean lines 310–317](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/SpecialFunctions/Gamma/Basic.lean#L310-L317).
The hypothesis is exact for Mathlib's total function, but is not by itself an
honest classical point-value domain: at `s = -m` for positive `m`, both pole
values are totalized and the equation can reduce to an equality involving
zeros. A future source-facing pointwise target should therefore assume
`∀ n : ℕ, s ≠ -(n : ℂ)` (or an equivalent reviewed nonpole predicate), derive
`s ≠ 0` from the `n=0` case, and apply `Complex.Gamma_add_one` directly. This
also ensures `s+1` is not a pole. If the source target is instead explicitly an
identity of meromorphic functions, a meromorphic formulation is required; the
totalized pointwise theorem alone is not that formulation.

No public recurrence wrapper is needed merely to package this one-line
specialization. A direct target mapping plus its reviewed source-domain
hypothesis is the smaller, more durable interface.

### Positive-integer values — ordinary exact identity

Pinned declarations:
`Complex.Gamma_one : Complex.Gamma 1 = 1`
`Complex.Gamma_nat_eq_factorial (n : ℕ) :`
`  Complex.Gamma ((n : ℂ) + 1) = (n.factorial : ℂ)`

They are at
[Basic.lean lines 322–331](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/SpecialFunctions/Gamma/Basic.lean#L322-L331).
The factorial theorem already includes `n=0`, so the separate value at one is
mathematical overlap, not a reason to create two project wrappers. DLMF 5.4.E1
prints the factorial equality in the reverse orientation; equality symmetry
and explicit coercion of `n!` into `ℂ` are the only bridges. For a statement
indexed by a positive natural `N`, write `N=n+1`; do not introduce subtraction
and a new public theorem unless a real consumer requires that interface.

### Real/complex agreement — structural entity bridge

Pinned declaration:
`Complex.Gamma_ofReal (s : ℝ) :`
`  Complex.Gamma (s : ℂ) = (Real.Gamma s : ℂ)`

It is at
[Basic.lean lines 401–424](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/SpecialFunctions/Gamma/Basic.lean#L401-L424).
The exact existing endpoint `LMLF.Definitions.gamma_ofReal` is already the
preferred bridge. It holds for every real input because both Mathlib objects
share the same pole totalization. For a claim about finite classical Gamma
values, restrict to `0 < s` when only the Euler domain is needed, or explicitly
exclude nonpositive integers. This bridge identifies representations; it is not
independent evidence for analytic continuation or pole behavior.

## Totalization boundary and fidelity rule

Pinned Mathlib deliberately defines a total `Complex.Gamma : ℂ → ℂ` and proves
`Complex.Gamma_neg_nat_eq_zero (n : ℕ) : Complex.Gamma (-(n : ℂ)) = 0`
at
[Basic.lean lines 338–354](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/SpecialFunctions/Gamma/Basic.lean#L338-L354).
The existing `LMLF.Definitions.gamma_neg_nat_eq_zero` correctly labels this as
Mathlib's convention. DLMF §5.2 instead says classical Gamma has simple poles at
these points and no zeros. Thus zero here is a sentinel value, never a finite
classical Gamma value and never evidence against the pole.

The general repair rule is: an ordinary pointwise source identity may use the
Mathlib function only where every classical Gamma argument is away from
`{-n | n : ℕ}`; an integral identity additionally keeps its convergence-domain
hypothesis; a quotient additionally proves its denominator nonzero. Pole order,
residue, or global no-zero claims require their own meromorphic or punctured-
domain theorem. They cannot be inferred from the total function's values.

## Optional next frontier, not first-packet scope

`Mathlib.Analysis.SpecialFunctions.Gamma.Beta` contains the source-level pinned
declarations
`Complex.Gamma_mul_Gamma_one_sub (z : ℂ) :`
`  Gamma z * Gamma (1-z) = π / sin (π*z)`
at
[Beta.lean lines 397–423](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/SpecialFunctions/Gamma/Beta.lean#L397-L423),
and
`Complex.Gamma_mul_Gamma_add_half (s : ℂ) :`
`  Gamma s * Gamma (s+1/2) = Gamma (2*s) * (2:ℂ)^(1-2*s) * (Real.sqrt π : ℂ)`
at
[Beta.lean lines 557–589](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/SpecialFunctions/Gamma/Beta.lean#L557-L589).
These are reusable upstream facts, but their unrestricted Lean statements again use
totalization. DLMF [5.5.E3](https://dlmf.nist.gov/5.5.E3) explicitly excludes
integral `z`; DLMF [5.5.E5](https://dlmf.nist.gov/5.5.E5) requires `2z` not be a
nonpositive integer. Those exclusions must be retained in any source-facing
target. Duplication also needs an algebraic orientation/exponent and square-root
normalization bridge. Neither theorem belongs in the first bounded family
unless a reviewed finite consumer selects it.

## Natural-language proof correspondence

Fix `s : ℂ` with `0 < s.re`. On `t ∈ (0,∞)`, interpret the source power through
the ordinary real logarithm of the positive base; this is the value represented
by Mathlib's complex power on `(t : ℂ)`. Apply the existing integrability wrapper
to establish the integral honestly, then the existing Euler wrapper to identify
its value with `Complex.Gamma s`. No continuation claim is used.

For recurrence at a classical point, assume `s` is not any nonpositive integer.
The zero case is excluded, so the pinned recurrence applies; the same hypothesis
also excludes a pole at `s+1`. For `n : ℕ`, apply the pinned factorial theorem
directly and reverse equality only if following DLMF's printed orientation. For
a real positive parameter, use the existing coercion bridge; both sides then
denote the same finite Gamma value.

These are normalization, domain, and orientation arguments, not new Gamma
mathematics. They do not prove the DLMF continuation prose, pole residues, or
no-zero statement.

## Execution and review boundary

Read-only `#check` under the pinned environment accepted the four existing LMLF
signatures and the Basic declarations listed above. This is interface evidence
only. The optional Beta declarations were inspected in the exact pinned source;
their module was not built or tested in this preparation.

Chapters 1–3 may contribute only finite prerequisites or consumer support for
this wave. If a Stage-1 Chapter 4–10 source packet selects this Chapter-5 family,
its required deliverable is reviewed actual Lean using the narrowest import,
not another planning document. Before any genuinely new Lean mathematics, the
frozen natural-language proof and exact source semantics need the required
multiple independent mathematical reviews, plus structural/circularity review
where continuation or exceptional values enter.

This preparation changes no LMLF source, public API, source inventory, schema,
CI, Verso, commit, or remote state, and grants no readiness, implementation, or
coverage status.
