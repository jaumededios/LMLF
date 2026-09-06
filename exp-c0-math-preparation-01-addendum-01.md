# EXP-C0 mathematics preparation 01 — addendum 01

## Status and binding

This append-only clarification binds and leaves unchanged
`exp-c0-math-preparation-01.md`, SHA-256
`ea55b3495cb3d34eea6c1917af68a37fad14e73f87aa1ee52c2b08f7f5bdd31e`.
It was checked against Lean `v4.33.1` and pinned Mathlib commit
`0df444a360eaa60ab8c11dca51a86af692955474`. It supplies a more explicit
natural-language bridge for the §4.2 series identification and records the
real/complex restriction theorem needed to interpret the real exponential in
the modulus formula. It does not alter the original dossier's scope or approve
a source identity, atomization, classification, target, signature, proof gate,
or coverage claim. No Lean implementation or test harness is proposed here.

The first packet remains DLMF §4.2. DLMF §4.8 addition remains an optional
later packet; nothing below imports it into the first packet's source scope.

## Exact pinned declarations and locators

In `Mathlib.Analysis.Normed.Algebra.Exponential`, under
`[NormedDivisionRing 𝔸] [NormedAlgebra ℚ 𝔸] [CompleteSpace 𝔸]`, the pinned
declaration is

`NormedSpace.expSeries_div_hasSum_exp (x : 𝔸) :
  HasSum (fun n => x ^ n / n !) (NormedSpace.exp x)`.

Its definition is at
[Exponential.lean lines 628–640](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/Normed/Algebra/Exponential.lean#L628-L640).
At `𝔸 = ℂ`, Lean elaborates the factorial denominator in `ℂ`, yielding the
specialization recorded in the original dossier.

In `Mathlib.Analysis.SpecialFunctions.Exponential`:

`Complex.exp_eq_exp_ℂ : Complex.exp = NormedSpace.exp`.

It is proved at
[SpecialFunctions/Exponential.lean lines 209–212](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/SpecialFunctions/Exponential.lean#L209-L212).
That module directly imports both the normed-algebra exponential module and
`Mathlib.Analysis.Complex.Exponential`.

The latter defining module contains the exact restriction theorem

`Complex.ofReal_exp (x : ℝ) : (Real.exp x : ℂ) = Complex.exp x`

at
[Complex/Exponential.lean lines 187–192](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/Complex/Exponential.lean#L187-L192).
The orientation is embedded real exponential equals complex exponential at the
embedded real input; there are no hypotheses.

Finally, the exact real-valued modulus statement is

`Complex.norm_exp (z : ℂ) : ‖Complex.exp z‖ = Real.exp z.re`

at
[Complex/Trigonometric.lean lines 983–985](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/Complex/Trigonometric.lean#L983-L985).
Its defining import is `Mathlib.Analysis.Complex.Trigonometric`; the broader
`Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic` used by the original
dossier exposes it transitively.

## Complete §4.2 E19 `HasSum` bridge

Fix `z : ℂ` and let `a n = z^n / (n.factorial : ℂ)`. Specializing
`NormedSpace.expSeries_div_hasSum_exp` gives `HasSum a (NormedSpace.exp z)`.
Applying the function equality `Complex.exp_eq_exp_ℂ` at `z` gives
`Complex.exp z = NormedSpace.exp z`; using its symmetric equality to replace
the limit in that `HasSum` statement gives

`HasSum (fun n : ℕ => z^n / (n.factorial : ℂ)) (Complex.exp z)`.

This already proves convergence: a `HasSum` witness entails that the series is
summable. It also gives the needed identification rather than merely a
candidate value. If an independently reviewed source interpretation says the
same term sequence has sum `s`, uniqueness of limits (`HasSum.unique`) gives
`s = Complex.exp z`. Thus existence and uniqueness are both carried by
`HasSum`; the bridge never replaces the series with Lean's totalized `tsum`.

This argument still depends on review of the source's indexing, factorial
coercion, division-versus-inverse notation, and the assertion that its displayed
series denotes a convergent sum. It does not derive those source conventions
from the Mathlib target.

## Real restriction and the modulus right-hand side

For every `x : ℝ`, `Complex.ofReal_exp x` identifies the restriction of
`Complex.exp` to the embedded real line with the embedded value of `Real.exp`.
Consequently the right-hand side of `Complex.norm_exp z` is specifically the
real exponential evaluated at the real number `z.re`; if it must be compared
inside `ℂ`, `Complex.ofReal_exp z.re` supplies the coercion bridge. The norm
theorem itself is already an equality in `ℝ`, so no coercion or auxiliary
algebraic lemma is needed for the direct §4.2 E22 target.

Neither the E19 identification nor this real-restriction bridge assumes source
nonvanishing. The §4.2 zero-free assertion remains a separate source claim with
its separate direct target `Complex.exp_ne_zero`; it must not be used silently
as a premise for E19 or E22.

## Stop line

These pinned interfaces close only the mathematical normalization bridge. A
future reviewed execution still must bind exact authorized source evidence and
approve entity/notation meanings, ownership, atomization, finite dependencies,
and exact target signatures. Assertions omitted from a selected source leaf
remain source-inventory obligations. This addendum supplies no production ID,
card, review verdict, readiness decision, or source-coverage credit.
