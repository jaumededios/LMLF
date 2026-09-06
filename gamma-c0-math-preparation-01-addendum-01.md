# Gamma C0 mathematics preparation 01 — addendum 01

## Binding and limited supersession

This addendum binds and preserves byte-for-byte
`gamma-c0-math-preparation-01.md` with SHA-256
`19ab6760ab4fbccbea52150869d1c105e5db8e773463632682a4cde8294f609d`.
It changes no old bytes. It narrowly supersedes only any reading of the
original recommendation that treats the full nonpole recurrence as already
source-ready. All pinned signatures, totalization warnings, reuse decisions,
and exclusions in the original dossier remain in force.

The checked repository remains clean `main` at
`b8d2f731fcfd5cd0889d0732f13699eb94681c86`, using Lean `v4.33.1` and Mathlib
`0df444a360eaa60ab8c11dca51a86af692955474`. The relevant accepted project file
is `LMLF/Definitions/Gamma.lean`, importing
`Mathlib.Analysis.SpecialFunctions.Gamma.Basic`.

This is mathematical preparation only. It is not an implementation, source
inventory, theorem card, readiness decision, source approval, or coverage
claim.

## Correct identification boundary

The accepted LMLF identification theorem is exactly

`LMLF.Definitions.gamma_eq_eulerIntegral {s : ℂ} (hs : 0 < s.re) :`
`  Complex.Gamma s = ∫ t in Set.Ioi 0,`
`    (Real.exp (-t) : ℂ) * (t : ℂ) ^ (s - 1)`.

It identifies the source-normalized Euler integral with `Complex.Gamma` only on
the positive half-plane. It does not yet identify the source's meromorphic
continuation with Mathlib's canonical Gamma on the whole pole-free plane.
`LMLF.Definitions.gamma_neg_nat_eq_zero` documents Mathlib's totalization and
supplies no continuation theorem.

Consequently, adding the honest hypothesis
`∀ n : ℕ, s ≠ -(n : ℂ)` repairs the classical point-value domain of
`Complex.Gamma_add_one`, but does not itself supply the missing global
source-to-Mathlib entity identification. Domain correctness and entity
identification are separate obligations.

## First genuinely ready bounded family

Subject to the still-required exact source and independent reviews, the
mathematically prepared first family is confined to the already identified
domain:

- Euler-integrand integrability and Euler value for `0 < s.re`;
- `Gamma ((n : ℂ) + 1) = n!` for `n : ℕ`, whose argument is in that half-plane;
- real/complex agreement used at `0 < x`, where both sides denote the same
  finite Euler-Gamma value;
- recurrence only with `0 < s.re` as bounded support, since then both `s` and
  `s+1` lie in the identified half-plane and `s ≠ 0` follows.

The positive-half-plane recurrence can support a finite consumer or an exact
source atom whose own domain is that half-plane. It cannot receive complete
credit for the global classical recurrence displayed in DLMF 5.5.E1, whose
meaning depends on the globally continued Gamma.

These targets continue to reuse the existing canonical `Complex.Gamma` and the
accepted LMLF wrappers. No second Gamma construction and no public recurrence,
factorial, or real-positive synonym wrapper is recommended.

## Conditional full-nonpole recurrence frontier

A full pointwise recurrence away from the poles remains conditional on a prior
accepted global entity/continuation identification. A later finite
natural-language proof must select and review one noncircular route, for
example:

1. identify the source Euler germ with Mathlib Gamma on `Re s > 0`, then use a
   source-justified meromorphic-continuation theorem and its uniqueness
   conditions to identify the two meromorphic objects globally; or
2. use only finitely many recurrence shifts to move each stated nonpole input
   into the positive half-plane, but only if the exact source occurrence or
   accepted source definition legitimately supplies that recurrence and all
   intermediate-domain conditions.

The second route cannot use the recurrence being targeted as its own
unreviewed identification premise. It must expose the shift count, prove that
the shifted point reaches `Re > 0`, keep every intermediate Gamma argument away
from the poles, and justify each division or cancellation. If those facts are
not supplied by the selected source contract, the route is unavailable.

This addendum chooses neither route and proves neither. The eventual dossier
must state the actual source continuation characterization, domain, uniqueness
principle, and dependency order, then receive the required independent
mathematical and structural/circularity reviews before any genuinely new Lean
mathematics or global source claim.

## Unchanged architecture and omissions

Mathlib's `Complex.Gamma` remains the sole canonical implementation candidate.
The issue is a missing accepted global identification theorem, not a need for a
new function. Direct Mathlib reuse remains preferred once that identification
exists.

Every omitted assertion from a future selected source leaf remains a separate
source-inventory and disposition obligation. This clarification creates no
source identity, occurrence, production identifier, implementation authority,
CI evidence, commit, or remote state.
