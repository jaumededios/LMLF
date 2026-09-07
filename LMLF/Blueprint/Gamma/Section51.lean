import Mathlib.Analysis.SpecialFunctions.Gamma.Beta
import Mathlib.Analysis.SpecialFunctions.Gamma.Digamma

/-!
# DLMF §5.1: special notation for the Gamma-function chapter

Section 5.1 is a notation table rather than a theorem section.  The definitions below
make its recurring conventions explicit without competing with the canonical Mathlib
objects or with the substantive q-Gamma definitions in §5.18.
-/

-- ANCHOR: section51Context
namespace LMLF.Blueprint.Gamma.Section51
-- ANCHOR_END: section51Context

/-! ### Variables, coordinates, and parameter conditions -/

/-- DLMF §5.1: the symbols `j`, `m`, `n`, and (apart from §5.20) `k` denote
nonnegative integers.  Mathlib's natural numbers are the corresponding type. -/
-- ANCHOR: NonnegativeInteger
abbrev NonnegativeInteger := ℕ
-- ANCHOR_END: NonnegativeInteger

/-- DLMF §5.1: the complex variable `z = x + i y`, represented from its real
coordinates. -/
-- ANCHOR: complexCoordinate
def complexCoordinate (x y : ℝ) : ℂ := (x : ℂ) + (y : ℂ) * Complex.I
-- ANCHOR_END: complexCoordinate

/-- DLMF §5.1: the real part of `z = x + i y` is `x`. -/
-- ANCHOR: complexCoordinate_re
theorem complexCoordinate_re (x y : ℝ) :
    (complexCoordinate x y).re = x
-- ANCHOR_END: complexCoordinate_re
:= by
  sorry

/-- DLMF §5.1: the imaginary part of `z = x + i y` is `y`. -/
-- ANCHOR: complexCoordinate_im
theorem complexCoordinate_im (x y : ℝ) :
    (complexCoordinate x y).im = y
-- ANCHOR_END: complexCoordinate_im
:= by
  sorry

/-- DLMF §5.1: the chapter's q-parameter convention is `|q| < 1`; for a
complex parameter this is Mathlib's norm inequality. -/
-- ANCHOR: qParameterCondition
def qParameterCondition (q : ℂ) : Prop := ‖q‖ < 1
-- ANCHOR_END: qParameterCondition

/-- DLMF §5.1: for a real q, the complex norm condition is the ordinary
absolute-value condition. -/
-- ANCHOR: real_qParameterCondition_iff
theorem real_qParameterCondition_iff (q : ℝ) :
    qParameterCondition (q : ℂ) ↔ |q| < 1
-- ANCHOR_END: real_qParameterCondition_iff
:= by
  sorry

/-- DLMF §5.1: an arbitrary small positive constant can be chosen below any
given positive tolerance. -/
-- ANCHOR: exists_positive_delta_lt
theorem exists_positive_delta_lt {ε : ℝ} (hε : 0 < ε) :
    ∃ δ : ℝ, 0 < δ ∧ δ < ε
-- ANCHOR_END: exists_positive_delta_lt
:= by
  sorry

/-! ### Canonical names for the main functions -/

/-- DLMF §5.1: the Gamma function `Γ(z)`, using Mathlib's canonical complex
Gamma function. -/
-- ANCHOR: gammaFunction
noncomputable def gammaFunction (z : ℂ) : ℂ := Complex.Gamma z
-- ANCHOR_END: gammaFunction

/-- DLMF §5.1: the psi (digamma) function `ψ(z)`, using Mathlib's canonical
complex digamma function. -/
-- ANCHOR: psiFunction
noncomputable def psiFunction (z : ℂ) : ℂ := Complex.digamma z
-- ANCHOR_END: psiFunction

/-- DLMF §5.1: the beta function `B(a,b)`, represented by Mathlib's complex
Euler beta integral.  Its interval-integral convergence theorem applies when
`0 < a.re` and `0 < b.re`; the meromorphic continuation is a separate object. -/
-- ANCHOR: betaFunction
noncomputable def betaFunction (a b : ℂ) : ℂ := Complex.betaIntegral a b
-- ANCHOR_END: betaFunction

/-- DLMF §5.1: Gauss's alternative `Π(w)` notation for `Γ(w+1)`. -/
-- ANCHOR: gaussPi
noncomputable def gaussPi (w : ℂ) : ℂ := gammaFunction (w + 1)
-- ANCHOR_END: gaussPi

/-- DLMF §5.1: Gauss's alternative `Ψ(w)` notation for `ψ(w+1)`. -/
-- ANCHOR: gaussPsi
noncomputable def gaussPsi (w : ℂ) : ℂ := psiFunction (w + 1)
-- ANCHOR_END: gaussPsi

/-- DLMF §5.1: Davis's `Ψ(z)` notation for the psi function. -/
-- ANCHOR: davisPsi
noncomputable def davisPsi (z : ℂ) : ℂ := psiFunction z
-- ANCHOR_END: davisPsi

/-- DLMF §5.1: Pairman's `𝖥(w)` notation for `ψ(w+1)`. -/
-- ANCHOR: pairmanF
noncomputable def pairmanF (w : ℂ) : ℂ := psiFunction (w + 1)
-- ANCHOR_END: pairmanF

/-- DLMF §5.1: Gauss's shifted Π notation agrees with Gamma after replacing
`w` by `z-1`. -/
-- ANCHOR: gaussPi_shift_eq_gamma
theorem gaussPi_shift_eq_gamma (z : ℂ) :
    gaussPi (z - 1) = gammaFunction z
-- ANCHOR_END: gaussPi_shift_eq_gamma
:= by
  sorry

/-- DLMF §5.1: Gauss's shifted Ψ notation agrees with psi after replacing
`w` by `z-1`. -/
-- ANCHOR: gaussPsi_shift_eq_psi
theorem gaussPsi_shift_eq_psi (z : ℂ) :
    gaussPsi (z - 1) = psiFunction z
-- ANCHOR_END: gaussPsi_shift_eq_psi
:= by
  sorry

/-- DLMF §5.1: Pairman's shifted notation agrees with psi after replacing
`w` by `z-1`. -/
-- ANCHOR: pairmanF_shift_eq_psi
theorem pairmanF_shift_eq_psi (z : ℂ) :
    pairmanF (z - 1) = psiFunction z
-- ANCHOR_END: pairmanF_shift_eq_psi
:= by
  sorry

/-- DLMF §5.1: the factorial alternative specialized to nonnegative integers:
Gamma at `n + 1` is ordinary `n.factorial`.  This is the `Nat` specialization
of the source's `(z - 1)!` notation. -/
-- ANCHOR: gamma_nat_succ_eq_factorial
theorem gamma_nat_succ_eq_factorial (n : ℕ) :
    gammaFunction ((n : ℂ) + 1) = (n.factorial : ℂ)
-- ANCHOR_END: gamma_nat_succ_eq_factorial
:= by
  sorry

/-! ### Constants and derivative notation -/

/-- DLMF §5.1: `γ` denotes Euler's constant, as defined in §5.2(ii). -/
-- ANCHOR: eulerConstant
noncomputable abbrev eulerConstant : ℝ := Real.eulerMascheroniConstant
-- ANCHOR_END: eulerConstant

/-- DLMF §5.1: a prime on a complex-valued function denotes differentiation
with respect to its displayed complex variable.  This definition uses
Mathlib's totalized `deriv`; it is intended where differentiability has been
established, since `deriv` returns a default value otherwise. -/
-- ANCHOR: primeDerivative
noncomputable def primeDerivative (f : ℂ → ℂ) (z : ℂ) : ℂ := deriv f z
-- ANCHOR_END: primeDerivative

/-- DLMF §5.1: the prime convention is Mathlib's totalized `deriv` at the
displayed argument.  No differentiability hypothesis is added here. -/
-- ANCHOR: primeDerivative_eq_deriv
theorem primeDerivative_eq_deriv (f : ℂ → ℂ) (z : ℂ) :
    primeDerivative f z = deriv f z
-- ANCHOR_END: primeDerivative_eq_deriv
:= by
  rfl

end LMLF.Blueprint.Gamma.Section51
