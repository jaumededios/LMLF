import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import Mathlib.Analysis.RCLike.Sqrt
import Mathlib.Analysis.Calculus.Deriv.Basic

open scoped BigOperators

noncomputable section
namespace LMLF.Blueprint.Elementary.Section438

/-! Principal-branch inverse hyperbolic APIs and the power-series, derivative,
and addition formulas of DLMF §4.38.  Every branch-sensitive identity carries
its real-part, cut, or denominator hypotheses explicitly. -/

def arcsinh (z : ℂ) : ℂ := Complex.log (z + Complex.sqrt (1 + z ^ 2))
def arccosh (z : ℂ) : ℂ := Complex.log (z + Complex.sqrt (z ^ 2 - 1))
def arctanh (z : ℂ) : ℂ := (Complex.log (1 + z) - Complex.log (1 - z)) / 2
def arccsch (z : ℂ) : ℂ := arcsinh (1 / z)
def arcsech (z : ℂ) : ℂ := arccosh (1 / z)
def arccoth (z : ℂ) : ℂ := arctanh (1 / z)

/-- Principal arcsinh is analytic off its imaginary branch cuts. -/
def arcsinhBranchDomain (z : ℂ) : Prop :=
  ¬ (z.re = 0 ∧ 1 ≤ |z.im|)

/-- Principal arccosh is analytic off its real branch cut `(-∞, 1]`. -/
def arccoshBranchDomain (z : ℂ) : Prop :=
  ¬ (z.im = 0 ∧ z.re ≤ 1)

/-- Principal arctanh is analytic off its real branch cuts. -/
def arctanhBranchDomain (z : ℂ) : Prop :=
  ¬ (z.im = 0 ∧ (z.re ≤ -1 ∨ 1 ≤ z.re))

/-- DLMF §4.38: coefficient for the local arccosh expansion. -/
def arccoshLocalCoeff (n : ℕ) : ℂ :=
  (-1 : ℂ) ^ (n + 1) * Finset.prod (Finset.range (n + 1)) (fun k => (2 * k + 1 : ℂ)) /
    ((4 : ℂ) ^ (n + 1) * (Nat.factorial (n + 1) : ℂ) * (2 * (n + 1) + 1))

/-- DLMF §4.38: coefficient for the transformed arctanh expansion. -/
def arctanhTransformedCoeff (n : ℕ) : ℂ :=
  Finset.prod (Finset.range (n + 1)) (fun k => (2 * (k + 1) : ℂ) / (2 * k + 3 : ℂ))

/-- A square-root value, used to state DLMF's multivalued correspondences. -/
def sqrtValue (x s : ℂ) : Prop := s ^ 2 = x

/-- A value of the multivalued inverse hyperbolic sine. -/
def arcsinhValue (z w : ℂ) : Prop := Complex.exp w - Complex.exp (-w) = 2 * z

/-- A value of the multivalued inverse hyperbolic cosine. -/
def arccoshValue (z w : ℂ) : Prop := Complex.exp w + Complex.exp (-w) = 2 * z

/-- A value of the multivalued inverse hyperbolic tangent. -/
def arctanhValue (z w : ℂ) : Prop := Complex.exp (2 * w) * (1 - z) = 1 + z

/-- A value of the multivalued inverse hyperbolic cotangent. -/
def arccothValue (z w : ℂ) : Prop := Complex.exp (2 * w) * (z - 1) = z + 1

-- ANCHOR: dlmf_4_38_1
theorem dlmf_4_38_1 (z : ℂ) (hz : ‖z‖ < 1) :
    arcsinh z = ∑' n : ℕ, ((-1 : ℂ) ^ n * (Nat.choose (2*n) n : ℂ) /
      ((4 : ℂ)^n * (2*n+1))) * z ^ (2*n+1) :=
-- ANCHOR_END: dlmf_4_38_1
by sorry
-- ANCHOR: dlmf_4_38_2
theorem dlmf_4_38_2 (z : ℂ) (hr : 0 < z.re) (hz : 1 < ‖z‖) :
    arcsinh z = Complex.log (2*z) + ∑' n : ℕ, ((-1 : ℂ) ^ n *
      (Nat.choose (2*(n+1)) (n+1) : ℂ) / ((4 : ℂ)^(n+1) * (2*(n+1)) * z^(2*(n+1)))) :=
-- ANCHOR_END: dlmf_4_38_2
by sorry
-- ANCHOR: dlmf_4_38_3
theorem dlmf_4_38_3 (z : ℂ) (hz : 1 < ‖z‖) :
    arccosh z = Complex.log (2*z) - ∑' n : ℕ, (
      (Nat.choose (2*(n+1)) (n+1) : ℂ) / ((4 : ℂ)^(n+1) * (2*(n+1)) * z^(2*(n+1)))) :=
-- ANCHOR_END: dlmf_4_38_3
by sorry
-- ANCHOR: dlmf_4_38_4
theorem dlmf_4_38_4 (z : ℂ) (hr : 0 < z.re) (hz : ‖z - 1‖ ≤ 2) :
    arccosh z = Complex.sqrt (2*(z-1)) * (1 + ∑' n : ℕ,
      arccoshLocalCoeff n * (z-1)^(n+1)) :=
-- ANCHOR_END: dlmf_4_38_4
by sorry
-- ANCHOR: dlmf_4_38_5
theorem dlmf_4_38_5 (z : ℂ) (hz : ‖z‖ ≤ 1) (hpm : z ≠ 1 ∧ z ≠ -1) :
    arctanh z = ∑' n : ℕ, z^(2*n+1) / (2*n+1) :=
-- ANCHOR_END: dlmf_4_38_5
by sorry
-- ANCHOR: dlmf_4_38_6
theorem dlmf_4_38_6 (z : ℂ) (hi : z.im ≠ 0) (hz : 1 ≤ ‖z‖) :
    arctanh z = Complex.I * (if 0 < z.im then 1 else -1) * (Real.pi/2) +
      ∑' n : ℕ, 1 / ((2*n+1 : ℕ) : ℂ) / z^(2*n+1) :=
-- ANCHOR_END: dlmf_4_38_6
by sorry
-- ANCHOR: dlmf_4_38_7
theorem dlmf_4_38_7 (z : ℂ) (hz : (z^2).re < 1/2) :
    arctanh z = z/(1-z^2) * (1 + ∑' n : ℕ,
      arctanhTransformedCoeff n * (z^2/(z^2-1))^(n+1)) :=
-- ANCHOR_END: dlmf_4_38_7
by sorry
-- ANCHOR: dlmf_4_38_8
theorem dlmf_4_38_8 (x y : ℝ) : x^2 - y^2 = 1/2 ↔
    (((x : ℂ) + Complex.I * (y : ℂ)) ^ 2).re = 1/2 :=
-- ANCHOR_END: dlmf_4_38_8
by sorry
-- ANCHOR: dlmf_4_38_9
theorem dlmf_4_38_9 (z : ℂ) (h : 1 + z^2 ≠ 0 ∧ arcsinhBranchDomain z) :
    HasDerivAt arcsinh (1 / Complex.sqrt (1 + z^2)) z :=
-- ANCHOR_END: dlmf_4_38_9
by sorry
-- ANCHOR: dlmf_4_38_10
theorem dlmf_4_38_10 (z : ℂ) (σ : ℂ) (hσ : σ = 1 ∨ σ = -1)
    (hbranch : (0 < z.re ∧ σ = 1) ∨ (z.re < 0 ∧ σ = -1))
    (h : z^2 - 1 ≠ 0 ∧ arccoshBranchDomain z) :
    HasDerivAt arccosh (σ / Complex.sqrt (z^2 - 1)) z :=
-- ANCHOR_END: dlmf_4_38_10
by sorry
-- ANCHOR: dlmf_4_38_11
theorem dlmf_4_38_11 (z : ℂ) (h : z^2 ≠ 1 ∧ arctanhBranchDomain z) :
    HasDerivAt arctanh (1 / (1-z^2)) z :=
-- ANCHOR_END: dlmf_4_38_11
by sorry
-- ANCHOR: dlmf_4_38_12
theorem dlmf_4_38_12 (z : ℂ) (σ : ℂ) (hσ : σ = 1 ∨ σ = -1)
    (hbranch : (0 < z.re ∧ σ = 1) ∨ (z.re < 0 ∧ σ = -1))
    (h : z ≠ 0 ∧ 1+z^2 ≠ 0 ∧ arcsinhBranchDomain (1 / z)) :
    HasDerivAt arccsch (-σ / (z * Complex.sqrt (1+z^2))) z :=
-- ANCHOR_END: dlmf_4_38_12
by sorry
-- ANCHOR: dlmf_4_38_13
theorem dlmf_4_38_13 (z : ℂ) (h : z ≠ 0 ∧ 1-z^2 ≠ 0 ∧ arccoshBranchDomain (1 / z)) :
    HasDerivAt arcsech (-(1 / (z * Complex.sqrt (1-z^2)))) z :=
-- ANCHOR_END: dlmf_4_38_13
by sorry
-- ANCHOR: dlmf_4_38_14
theorem dlmf_4_38_14 (z : ℂ) (h : z^2 ≠ 1 ∧ arctanhBranchDomain (1 / z)) :
    HasDerivAt arccoth (1 / (1-z^2)) z :=
-- ANCHOR_END: dlmf_4_38_14
by sorry
-- ANCHOR: dlmf_4_38_15
theorem dlmf_4_38_15 (ε : ℂ) (hε : ε ^ 2 = 1) (u v : ℂ) :
    ∀ w, (∃ x y, arcsinhValue u x ∧ arcsinhValue v y ∧ w = x + ε * y) ↔
      ∃ r s, sqrtValue (1 + v^2) r ∧ sqrtValue (1 + u^2) s ∧
        arcsinhValue (u * r + ε * v * s) w :=
-- ANCHOR_END: dlmf_4_38_15
by sorry
-- ANCHOR: dlmf_4_38_16
theorem dlmf_4_38_16 (ε : ℂ) (hε : ε ^ 2 = 1) (u v : ℂ) :
    ∀ w, (∃ x y, arccoshValue u x ∧ arccoshValue v y ∧ w = x + ε * y) ↔
      ∃ r s, sqrtValue (u^2 - 1) r ∧ sqrtValue (v^2 - 1) s ∧
        arccoshValue (u * v + ε * r * s) w :=
-- ANCHOR_END: dlmf_4_38_16
by sorry
-- ANCHOR: dlmf_4_38_17
theorem dlmf_4_38_17 (ε : ℂ) (hε : ε ^ 2 = 1) (u v : ℂ)
    (h : 1 + ε * u * v ≠ 0) :
    ∀ w, (∃ x y, arctanhValue u x ∧ arctanhValue v y ∧ w = x + ε * y) ↔
      arctanhValue ((u + ε * v) / (1 + ε * u * v)) w :=
-- ANCHOR_END: dlmf_4_38_17
by sorry
-- ANCHOR: dlmf_4_38_18
theorem dlmf_4_38_18 (ε : ℂ) (hε : ε ^ 2 = 1) (u v : ℂ) :
    ∀ w, (∃ x y, arcsinhValue u x ∧ arccoshValue v y ∧ w = x + ε * y) ↔
      ∃ r s, sqrtValue (1 + u^2) r ∧ sqrtValue (v^2 - 1) s ∧
        arcsinhValue (u * v + ε * r * s) w ∧
        arccoshValue (v * r + ε * u * s) w :=
-- ANCHOR_END: dlmf_4_38_18
by sorry
-- ANCHOR: dlmf_4_38_19
theorem dlmf_4_38_19 (ε : ℂ) (hε : ε ^ 2 = 1) (u v : ℂ)
    (h : v + ε * u ≠ 0 ∧ ε * u * v + 1 ≠ 0) :
    ∀ w, (∃ x y, arctanhValue u x ∧ arccothValue v y ∧ w = x + ε * y) ↔
      arctanhValue ((u * v + ε) / (v + ε * u)) w ∧
        arccothValue ((v + ε * u) / (u * v + ε)) w :=
-- ANCHOR_END: dlmf_4_38_19
by sorry

end LMLF.Blueprint.Elementary.Section438
