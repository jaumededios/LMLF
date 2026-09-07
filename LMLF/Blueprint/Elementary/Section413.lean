import Mathlib.Analysis.Asymptotics.AsymptoticEquivalent
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
import Mathlib.Analysis.SpecialFunctions.Complex.Log
import Mathlib.Analysis.SpecialFunctions.Pow.Complex
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic

/-! DLMF §4.13: Lambert W, its branches, expansions, and integrals. -/
namespace LMLF.Blueprint.Elementary.Section413

noncomputable section

open scoped BigOperators Interval Topology
open Filter Set Asymptotics

/-- DLMF 4.13: a selected branch of the multivalued Lambert function. -/
structure LambertBranch where
  index : ℤ
  cut : Set ℂ
  value : ℂ → ℂ
  equation : ∀ z, z ∉ cut → value z * Complex.exp (value z) = z

/-! The analytic and side selectors below keep branch-dependent statements
    explicit without pretending that a pointwise root chooses a branch. -/

/-- DLMF 4.13.E3_2, E6, E11: the two signed boundary sides. -/
inductive BoundarySide where
  | upper
  | lower

/-- DLMF 4.13.E3_2, E6, E11: branch index associated with a side. -/
def BoundarySide.code : BoundarySide → ℤ
  | .upper => 1
  | .lower => -1

/-- The side of the argument cut used by the signed notation
    `W_{±1}(x ∓ 0 i)`: the upper branch index is approached from below,
    and the lower branch index from above. -/
def BoundarySide.approachSign : BoundarySide → ℝ
  | .upper => -1
  | .lower => 1

/-- DLMF 4.13.E1_1, E4_1, E10--E16: analytic branch on its open domain. -/
def analyticLambertBranch (W : LambertBranch) : Prop :=
  ∀ z, z ∉ W.cut → DifferentiableAt ℂ W.value z

/-- DLMF 4.13: the excluded cut of the principal branch. -/
def principalCut : Set ℂ := {z | z.im = 0 ∧ z.re ≤ -Real.exp (-1)}

/-- DLMF 4.13: the excluded cut of every nonprincipal branch. -/
def nonprincipalCut : Set ℂ := {z | z.im = 0 ∧ z.re ≤ 0}

/-- DLMF 4.13.E2, E3_2, E6, E11: a side-indexed boundary branch. -/
structure LambertBoundaryBranch where
  branch : LambertBranch
  side : BoundarySide
  boundaryValue : BoundarySide → ℝ → ℂ
  selector : branch.index = side.code ∧ branch.cut = nonprincipalCut
  equation : ∀ x : ℝ, x < 0 →
    boundaryValue side x * Complex.exp (boundaryValue side x) = x
  range : ∀ x : ℝ, x < 0 → (boundaryValue side x).re ≤ -1
  branchPointValue : boundaryValue side (-Real.exp (-1)) = -1
  sideLimit : ∀ x : ℝ, x < 0 → ∀ ε : ℝ, 0 < ε →
    ∃ δ : ℝ, 0 < δ ∧ ∀ z : ℂ,
      ‖z - (x : ℂ)‖ < δ →
        BoundarySide.approachSign side * z.im > 0 →
          ‖branch.value z - boundaryValue side x‖ < ε

/-- The logarithmic strip on the positive real ray that identifies `W_k`.
    For large positive arguments its roots have imaginary part near `2π k`;
    the open strip of width `2π` excludes all neighboring branches. -/
def branchSector (k : ℤ) (w : ℂ) : Prop :=
  (2 * (k : ℝ) - 1) * Real.pi < w.im ∧
    w.im < (2 * (k : ℝ) + 1) * Real.pi

/-- DLMF 4.13.E1_1 and E10: an indexed analytic branch with its cut. -/
def indexedLambertBranch (W : LambertBranch) (k : ℤ) : Prop :=
  W.index = k ∧
    (k = 0 → W.cut = principalCut) ∧
    (k ≠ 0 → W.cut = nonprincipalCut) ∧
    analyticLambertBranch W ∧
    ∃ R : ℝ, 0 < R ∧ ∀ x : ℝ, R < x →
      branchSector k (W.value (x : ℂ))

/-- DLMF 4.13: the principal Lambert branch selector. -/
def principalBranch (W : LambertBranch) : Prop :=
  W.index = 0 ∧ W.cut = principalCut

/-- DLMF 4.13: the nonprincipal branch-cut selector. -/
def nonprincipalBranch (W : LambertBranch) : Prop :=
  W.index ≠ 0 ∧ W.cut = nonprincipalCut

/-- DLMF 4.13.E1_1: the branch-indexed logarithm. -/
def branchLog (k : ℤ) (z : ℂ) : ℂ :=
  Complex.log z + 2 * Real.pi * Complex.I * k

/-- DLMF 4.13.E2: the real branch point at negative inverse e. -/
def branchPoint : ℂ := -(Real.exp (-1) : ℂ)

/-- DLMF 4.13.E5: the Maclaurin coefficient, with the source index n ≥ 1. -/
def lambertMaclaurinCoeff (n : ℕ) : ℂ :=
  if n = 0 then 0 else (-(n : ℂ)) ^ (n - 1) / (n.factorial : ℂ)

/-- DLMF 4.13.E5_1: the parameterized Maclaurin coefficient. -/
def lambertParameterCoeff (a : ℂ) (n : ℕ) : ℂ :=
  a * ((n : ℂ) + a) ^ ((n : ℤ) - 1) / (n.factorial : ℂ)

/-- DLMF 4.13.E5_3: the square-series coefficient. -/
def lambertSquareCoeff (n : ℕ) : ℂ :=
  if n = 0 then 0 else (n : ℂ) ^ (n - 2) / (n.factorial : ℂ)

/-- DLMF 4.13.E4_2: the derivative polynomials p_n. -/
def derivativePolynomial : ℕ → ℂ → ℂ
  | 0 => fun _ => 1
  | n + 1 => fun x =>
      (1 + x) * deriv (derivativePolynomial n) x +
        (1 - (n + 1 : ℂ) * (x + 3)) * derivativePolynomial n x

/-- DLMF 4.13.E7-E8: the branch-point coefficient family c_n. -/
structure BranchPointCoefficients where
  value : ℕ → ℚ
  c_zero : value 0 = 1
  c_one : value 1 = 1
  recurrence : ∀ n, 2 ≤ n →
    value n = value (n - 1) / (n + 1) -
      (1 / 2) * Finset.sum (Finset.Icc 2 (n - 1))
        (fun k => value k * value (n + 1 - k))

/-- DLMF 4.13.E9_2: the square-root branch-point coefficient family d_n. -/
structure BranchPointDCoefficients where
  value : ℕ → ℝ
  d_zero : value 0 = -1
  d_one : value 1 = Real.sqrt 2
  d_two : value 2 = -(2 / 3)
  d_three : value 3 = (11 / 36) * Real.sqrt 2
  d_four : value 4 = -(43 / 135)
  recurrence : ∀ (n : ℕ), 1 ≤ n →
    ((n : ℝ) + 2) * value 1 * value (n + 1) =
      -2 * value n +
        ((n : ℝ) / 2) * Finset.sum (Finset.Icc 1 (n - 1))
          (fun k => value k * value (n - k)) -
        (((n : ℝ) + 2) / 2) * Finset.sum (Finset.Icc 1 (n - 1))
          (fun k => value (k + 1) * value (n - k + 1))

/-- DLMF 4.13.E9: the product-defined auxiliary coefficient sequence. -/
def branchPointG (c : BranchPointCoefficients) (n : ℕ) : ℚ :=
  (Finset.prod (Finset.Icc 0 n) (fun j => (2 * (j : ℚ) + 1))) * c.value (2 * n + 1)

/-- DLMF 4.13.E1_2 and E3: a selected Wright omega branch. -/
structure WrightOmega where
  value : ℂ → ℂ
  equation : ∀ z, value z + Complex.log (value z) = z

/-- DLMF 4.13.E1_3: a selected tree-function branch. -/
structure TreeFunction where
  value : ℂ → ℂ
  equation : ∀ z, value z * Complex.exp (-value z) = z

/-- DLMF 4.13.E1_1: the first two terms of the additive branch expansion. -/
def firstWExpansion (k : ℤ) (z : ℂ) : ℂ :=
  branchLog k z - Complex.log (branchLog k z)

/-- DLMF 4.13.E10-E11: unsigned Stirling cycle numbers of the first kind. -/
def stirlingCycle : ℕ → ℕ → ℕ
  | 0, 0 => 1
  | 0, _ + 1 => 0
  | _ + 1, 0 => 0
  | n + 1, k + 1 => n * stirlingCycle n (k + 1) + stirlingCycle n k

/-- DLMF 4.13.E10: the N-term Poincare partial sum. -/
def largeWPartial (k : ℤ) (z : ℂ) (N : ℕ) : ℂ :=
  firstWExpansion k z +
    ∑ n ∈ Finset.Icc 1 N,
        ((-1 : ℂ) ^ n / (branchLog k z) ^ n) *
        Finset.sum (Finset.Icc 1 n) (fun m =>
          (stirlingCycle n (n - m + 1) : ℂ) *
            (-Complex.log (branchLog k z)) ^ m / (m.factorial : ℂ))

/-- DLMF 4.13.E10: the inverse-logarithmic Poincare scale. -/
def largeWScale (k : ℤ) (z : ℂ) (N : ℕ) : ℝ :=
  (1 + ‖Complex.log (branchLog k z)‖) ^ N / ‖branchLog k z‖ ^ N

/-- DLMF 4.13.E11: eta equals log(-1/x) on the negative real approach. -/
def eta (x : ℝ) : ℝ := Real.log (-1 / x)

/-- DLMF 4.13.E11: the N-term negative-real Poincare partial sum. -/
def negativeWPartial (x : ℝ) (N : ℕ) : ℂ :=
  -(eta x : ℂ) - Complex.log (eta x) +
    ∑ n ∈ Finset.Icc 1 N,
      (1 : ℂ) / (eta x : ℂ) ^ n *
        Finset.sum (Finset.Icc 1 n) (fun m =>
          (stirlingCycle n (n - m + 1) : ℂ) *
            (-Real.log (eta x) : ℂ) ^ m / (m.factorial : ℂ))

/-- DLMF 4.13.E11: the inverse-eta Poincare scale. -/
def negativeWScale (x : ℝ) (N : ℕ) : ℝ :=
  (1 + ‖Real.log (eta x)‖) ^ N / ‖eta x‖ ^ N

/-- The square-root series displayed in E9_1, exposed as a function so the
    proof-sketch declaration can state its differentiated substitution. -/
def branchPointSeries (d : BranchPointDCoefficients) (z : ℂ) : ℂ :=
  ∑' n : ℕ, (d.value n : ℂ) *
    (Real.exp 1 * z + 1) ^ ((n : ℂ) / 2)

-- ANCHOR: dlmf_4_13_1
/-- DLMF 4.13.E1: a selected Lambert branch satisfies the defining equation. -/
theorem dlmf_4_13_1 (W : LambertBranch) (z : ℂ) (hz : z ∉ W.cut) :
    W.value z * Complex.exp (W.value z) = z
-- ANCHOR_END: dlmf_4_13_1
:= by sorry

-- ANCHOR: dlmf_4_13_1_1
/-- DLMF 4.13.E1_1: the additive branch expansion with an o(1) remainder. -/
theorem dlmf_4_13_1_1 (Wk : ℤ → LambertBranch) (k : ℤ) (l : Filter ℂ)
    (hbranch : indexedLambertBranch (Wk k) k)
    (hregime : l ≤ cocompact ℂ ∧ NeBot l ∧ ∀ᶠ z in l, z ∉ (Wk k).cut) :
    (fun z => (Wk k).value z - firstWExpansion k z) =o[l] (fun _ => (1 : ℂ))
-- ANCHOR_END: dlmf_4_13_1_1
:= by sorry

-- ANCHOR: dlmf_4_13_1_2
/-- DLMF 4.13.E1_2: the selected Wright omega equation. -/
theorem dlmf_4_13_1_2 (ω : WrightOmega) (z : ℂ) :
    ω.value z + Complex.log (ω.value z) = z
-- ANCHOR_END: dlmf_4_13_1_2
:= by sorry

-- ANCHOR: dlmf_4_13_1_3
/-- DLMF 4.13.E1_3: the selected tree-function equation. -/
theorem dlmf_4_13_1_3 (T : TreeFunction) (z : ℂ) :
    T.value z * Complex.exp (-T.value z) = z
-- ANCHOR_END: dlmf_4_13_1_3
:= by sorry

-- ANCHOR: dlmf_4_13_2
/-- DLMF 4.13.E2: principal and signed boundary-branch special values. -/
theorem dlmf_4_13_2 (W₀ : LambertBranch) (Wpm : LambertBoundaryBranch)
    (hprincipal : principalBranch W₀)
    (hbranchPoint : W₀.value branchPoint = -1)
    (hprincipalRange : ∀ x : ℝ, -Real.exp (-1) ≤ x → -1 ≤ (W₀.value x).re) :
    W₀.value branchPoint = -1 ∧
      Wpm.boundaryValue Wpm.side (-Real.exp (-1)) = -1 ∧
      W₀.value 0 = 0 ∧ W₀.value (Real.exp 1) = 1
-- ANCHOR_END: dlmf_4_13_2
:= by sorry

-- ANCHOR: dlmf_4_13_3
/-- DLMF 4.13.E3: the moved Wright omega relation. -/
theorem dlmf_4_13_3 (ω : WrightOmega) (z : ℂ) :
    ω.value z + Complex.log (ω.value z) = z
-- ANCHOR_END: dlmf_4_13_3
:= by sorry

-- ANCHOR: dlmf_4_13_3_1
/-- DLMF 4.13.E3_1: the principal real simplification for x ≥ -1. -/
theorem dlmf_4_13_3_1 (W₀ : LambertBranch) (x : ℝ) (hx : -1 ≤ x)
    (hprincipal : principalBranch W₀)
    (hEq : W₀.value ((x : ℂ) * Complex.exp x) *
      Complex.exp (W₀.value ((x : ℂ) * Complex.exp x)) =
        (x : ℂ) * Complex.exp x)
    (hRange : -1 ≤ (W₀.value ((x : ℂ) * Complex.exp x)).re) :
    W₀.value ((x : ℂ) * Complex.exp x) = x
-- ANCHOR_END: dlmf_4_13_3_1
:= by sorry

-- ANCHOR: dlmf_4_13_3_2
/-- DLMF 4.13.E3_2: the signed W_{±1} simplification for x < -1. -/
theorem dlmf_4_13_3_2 (Wpm : LambertBoundaryBranch) (x : ℝ) (hx : x < -1)
    : Wpm.boundaryValue Wpm.side (x * Real.exp x) = x
-- ANCHOR_END: dlmf_4_13_3_2
:= by sorry

-- ANCHOR: dlmf_4_13_4
/-- DLMF 4.13.E4: derivative of a selected branch away from zero and -1. -/
theorem dlmf_4_13_4 (W : LambertBranch) (z : ℂ)
    (hz : z ∉ W.cut ∧ z ≠ 0) (hW : W.value z ≠ -1)
    (hderiv : HasDerivAt W.value (Complex.exp (-(W.value z)) / (1 + W.value z)) z) :
    deriv W.value z = Complex.exp (-(W.value z)) / (1 + W.value z) ∧
      Complex.exp (-(W.value z)) / (1 + W.value z) =
        W.value z / (z * (1 + W.value z))
-- ANCHOR_END: dlmf_4_13_4
:= by sorry

-- ANCHOR: dlmf_4_13_4_1
/-- DLMF 4.13.E4_1: the nth derivative with the canonical p_{n-1}. -/
theorem dlmf_4_13_4_1 (W : LambertBranch) (n : ℕ) (z : ℂ)
    (hn : 1 ≤ n) (hz : z ∉ W.cut) (hW : W.value z ≠ -1)
    (hregular : ContDiffAt ℂ n W.value z) :
    iteratedDeriv n W.value z =
      Complex.exp (-(n : ℂ) * W.value z) *
        derivativePolynomial (n - 1) (W.value z) /
          (1 + W.value z) ^ (2 * n - 1)
-- ANCHOR_END: dlmf_4_13_4_1
:= by sorry

-- ANCHOR: dlmf_4_13_4_2
/-- DLMF 4.13.E4_2: initial value and recurrence for p_n. -/
theorem dlmf_4_13_4_2 :
    derivativePolynomial 0 = (fun _ => 1) ∧
      ∀ n, 1 ≤ n → ∀ x,
        derivativePolynomial n x =
          (1 + x) * deriv (derivativePolynomial (n - 1)) x +
            (1 - (n : ℂ) * (x + 3)) * derivativePolynomial (n - 1) x
-- ANCHOR_END: dlmf_4_13_4_2
:= by sorry

-- ANCHOR: dlmf_4_13_5
/-- DLMF 4.13.E5: the principal Maclaurin series, beginning at n = 1. -/
theorem dlmf_4_13_5 (W₀ : LambertBranch) (z : ℂ)
    (hz : z ∉ W₀.cut ∧ ‖z‖ < Real.exp (-1))
    (hprincipal : principalBranch W₀)
    (hbranch : W₀.value z * Complex.exp (W₀.value z) = z) :
    W₀.value z = ∑' n : ℕ, lambertMaclaurinCoeff n * z ^ n
-- ANCHOR_END: dlmf_4_13_5
:= by sorry

-- ANCHOR: dlmf_4_13_5_1
/-- DLMF 4.13.E5_1: the parameterized principal series. -/
theorem dlmf_4_13_5_1 (W₀ : LambertBranch) (a z : ℂ)
    (hz : z ≠ 0 ∧ ‖z‖ < Real.exp (-1) ∧ z ∉ W₀.cut)
    (hprincipal : principalBranch W₀)
    (hbranch : W₀.value z * Complex.exp (W₀.value z) = z) :
    (W₀.value z / z) ^ a = Complex.exp (-a * W₀.value z) ∧
      Complex.exp (-a * W₀.value z) =
        ∑' n : ℕ, lambertParameterCoeff a n * (-z) ^ n
-- ANCHOR_END: dlmf_4_13_5_1
:= by sorry

-- ANCHOR: dlmf_4_13_5_2
/-- DLMF 4.13.E5_2: the reciprocal principal series. -/
theorem dlmf_4_13_5_2 (W₀ : LambertBranch) (z : ℂ)
    (hz : ‖z‖ < Real.exp (-1) ∧ -z ∉ W₀.cut)
    (hprincipal : principalBranch W₀)
    (hbranch : W₀.value (-z) * Complex.exp (W₀.value (-z)) = -z) :
    1 / (1 + W₀.value (-z)) =
      ∑' n : ℕ, ((n : ℂ) ^ n / (n.factorial : ℂ)) * z ^ n
-- ANCHOR_END: dlmf_4_13_5_2
:= by sorry

-- ANCHOR: dlmf_4_13_5_3
/-- DLMF 4.13.E5_3: the principal square series. -/
theorem dlmf_4_13_5_3 (W₀ : LambertBranch) (z : ℂ)
    (hz : ‖z‖ < Real.exp (-1) ∧ z ∉ W₀.cut)
    (hprincipal : principalBranch W₀)
    (hbranch : W₀.value z * Complex.exp (W₀.value z) = z) :
    (1 + W₀.value z) ^ 2 =
      1 - 2 * ∑' n : ℕ, lambertSquareCoeff n * (-z) ^ n
-- ANCHOR_END: dlmf_4_13_5_3
:= by sorry

-- ANCHOR: dlmf_4_13_6
/-- DLMF 4.13.E6: the signed branch-point expansion for |t| < 2 sqrt pi. -/
theorem dlmf_4_13_6 (W₀ : LambertBranch) (Wpm : LambertBoundaryBranch)
    (c : BranchPointCoefficients) (t : ℝ)
    (ht : ‖t‖ < 2 * Real.sqrt Real.pi)
    (hprincipal : principalBranch W₀)
    (hEq₀ : W₀.value ((-Real.exp (-1 - t ^ 2 / 2) : ℝ) : ℂ) *
      Complex.exp (W₀.value ((-Real.exp (-1 - t ^ 2 / 2) : ℝ) : ℂ)) =
        (-Real.exp (-1 - t ^ 2 / 2) : ℝ))
    (hEqpm : Wpm.boundaryValue Wpm.side (-Real.exp (-1 - t ^ 2 / 2)) *
      Complex.exp (Wpm.boundaryValue Wpm.side (-Real.exp (-1 - t ^ 2 / 2))) =
        (-Real.exp (-1 - t ^ 2 / 2) : ℝ))
    (hRange₀ : 0 ≤ t → -1 ≤
      (W₀.value ((-Real.exp (-1 - t ^ 2 / 2) : ℝ) : ℂ)).re)
    (hRangePm : t ≤ 0 → -1 ≥
      (Wpm.boundaryValue Wpm.side (-Real.exp (-1 - t ^ 2 / 2))).re) :
    (if 0 ≤ t then W₀.value ((-Real.exp (-1 - t ^ 2 / 2) : ℝ) : ℂ)
      else Wpm.boundaryValue Wpm.side (-Real.exp (-1 - t ^ 2 / 2))) =
      ∑' n : ℕ, (-1 : ℂ) ^ ((n : ℤ) - 1) * (c.value n : ℂ) * (t : ℂ) ^ n
-- ANCHOR_END: dlmf_4_13_6
:= by sorry

-- ANCHOR: dlmf_4_13_7
/-- DLMF 4.13.E7: initial values of the branch-point coefficients. -/
theorem dlmf_4_13_7 (c : BranchPointCoefficients) :
    c.value 0 = 1 ∧ c.value 1 = 1 ∧ c.value 2 = 1 / 3 ∧
      c.value 3 = 1 / 36 ∧ c.value 4 = -(1 / 270)
-- ANCHOR_END: dlmf_4_13_7
:= by sorry

-- ANCHOR: dlmf_4_13_8
/-- DLMF 4.13.E8: recurrence of the branch-point coefficients. -/
theorem dlmf_4_13_8 (c : BranchPointCoefficients) :
    ∀ n, 2 ≤ n →
      c.value n = c.value (n - 1) / (n + 1) -
        (1 / 2) * Finset.sum (Finset.Icc 2 (n - 1))
          (fun k => c.value k * c.value (n + 1 - k))
-- ANCHOR_END: dlmf_4_13_8
:= by sorry

-- ANCHOR: dlmf_4_13_9
/-- DLMF 4.13.E9: relation to the named branchPointG sequence. -/
theorem dlmf_4_13_9 (c : BranchPointCoefficients) (g : ℕ → ℚ)
    (hG : ∀ n, g n = branchPointG c n) :
    ∀ n : ℕ,
      (Finset.prod (Finset.Icc 0 n) (fun j => (2 * (j : ℚ) + 1))) *
          c.value (2 * n + 1) = g n
-- ANCHOR_END: dlmf_4_13_9
:= by sorry

-- ANCHOR: dlmf_4_13_9_1
/-- DLMF 4.13.E9_1: the principal square-root branch-point series. -/
theorem dlmf_4_13_9_1 (W₀ : LambertBranch) (d : BranchPointDCoefficients) (z : ℂ)
    (hz : ‖Real.exp 1 * z + 1‖ < 1 ∧ z ∉ W₀.cut)
    (hphase : ‖(z + (Real.exp (-1) : ℂ)).arg‖ < Real.pi)
    (hprincipal : principalBranch W₀)
    (hbranch : W₀.value z * Complex.exp (W₀.value z) = z) :
    W₀.value z =
      ∑' n : ℕ, (d.value n : ℂ) *
        (Real.exp 1 * z + 1) ^ ((n : ℂ) / 2)
-- ANCHOR_END: dlmf_4_13_9_1
:= by sorry

-- ANCHOR: dlmf_4_13_9_2
/-- DLMF 4.13.E9_2: initial values and recurrence of d_n. -/
theorem dlmf_4_13_9_2 (d : BranchPointDCoefficients) :
    d.value 0 = -1 ∧ d.value 1 = Real.sqrt 2 ∧
      d.value 2 = -(2 / 3) ∧ d.value 3 = (11 / 36) * Real.sqrt 2 ∧
      d.value 4 = -(43 / 135) ∧
      ∀ (n : ℕ), 1 ≤ n →
        ((n : ℝ) + 2) * d.value 1 * d.value (n + 1) =
          -2 * d.value n +
            ((n : ℝ) / 2) * Finset.sum (Finset.Icc 1 (n - 1))
              (fun k => d.value k * d.value (n - k)) -
            (((n : ℝ) + 2) / 2) * Finset.sum (Finset.Icc 1 (n - 1))
              (fun k => d.value (k + 1) * d.value (n - k + 1))
-- ANCHOR_END: dlmf_4_13_9_2
:= by sorry

-- ANCHOR: dlmf_4_13_10
/-- DLMF 4.13.E10: complete Poincare expansion through every finite order. -/
theorem dlmf_4_13_10 (Wk : ℤ → LambertBranch) (k : ℤ) (l : Filter ℂ)
    (hbranch : indexedLambertBranch (Wk k) k)
    (hregime : l ≤ cocompact ℂ ∧ NeBot l ∧ ∀ᶠ z in l, z ∉ (Wk k).cut) :
    ∀ N : ℕ,
      (fun z => (Wk k).value z - largeWPartial k z N) =O[l]
        (fun z => (largeWScale k z N : ℂ))
-- ANCHOR_END: dlmf_4_13_10
:= by sorry

-- ANCHOR: dlmf_4_13_11
/-- DLMF 4.13.E11: the signed W_{±1} expansion as x approaches zero from below. -/
theorem dlmf_4_13_11 (Wpm : LambertBoundaryBranch) (l : Filter ℝ)
    (hregime : l = nhdsWithin 0 (Iio 0))
    : ∀ N : ℕ,
      (fun x => Wpm.boundaryValue Wpm.side x - negativeWPartial x N) =O[l]
        (fun x => (negativeWScale x N : ℂ))
-- ANCHOR_END: dlmf_4_13_11
:= by sorry

-- ANCHOR: dlmf_4_13_12
/-- DLMF 4.13.E12: an antiderivative on a nonzero selected-branch domain. -/
theorem dlmf_4_13_12 (W : LambertBranch) (D : Set ℂ) (F : ℂ → ℂ)
    (hprincipal : principalBranch W)
    (hanalytic : analyticLambertBranch W)
    (hD : D = principalCutᶜ \ {0})
    (hW : ∀ z, z ∈ D → W.value z ≠ 0)
    (hF : ∀ z, z ∈ D → HasDerivAt F (W.value z) z) :
    ∃ C : ℂ, ∀ z, z ∈ D → F z = z / W.value z + z * W.value z - z + C
-- ANCHOR_END: dlmf_4_13_12
:= by sorry

-- ANCHOR: dlmf_4_13_13
/-- DLMF 4.13.E13: an antiderivative of W z / z on the nonzero domain. -/
theorem dlmf_4_13_13 (W : LambertBranch) (D : Set ℂ) (F : ℂ → ℂ)
    (hprincipal : principalBranch W)
    (hanalytic : analyticLambertBranch W)
    (hD : D = principalCutᶜ \ {0})
    (hW : ∀ z, z ∈ D → W.value z ≠ 0)
    (hF : ∀ z, z ∈ D → HasDerivAt F (W.value z / z) z) :
    ∃ C : ℂ, ∀ z, z ∈ D → F z = (W.value z) ^ 2 / 2 + W.value z + C
-- ANCHOR_END: dlmf_4_13_13
:= by sorry

-- ANCHOR: dlmf_4_13_14
/-- DLMF 4.13.E14: an antiderivative of sin(W z) on the nonzero domain. -/
theorem dlmf_4_13_14 (W : LambertBranch) (D : Set ℂ) (F : ℂ → ℂ)
    (hprincipal : principalBranch W)
    (hanalytic : analyticLambertBranch W)
    (hD : D = principalCutᶜ \ {0})
    (hW : ∀ z, z ∈ D → W.value z ≠ 0)
    (hF : ∀ z, z ∈ D → HasDerivAt F (Complex.sin (W.value z)) z) :
    ∃ C : ℂ, ∀ z, z ∈ D →
      2 * F z = z * (1 + 1 / W.value z) * Complex.sin (W.value z) -
        z * Complex.cos (W.value z) + C
-- ANCHOR_END: dlmf_4_13_14
:= by sorry

-- ANCHOR: dlmf_4_13_15
/-- DLMF 4.13.E15: the principal finite integral representation. -/
theorem dlmf_4_13_15 (W₀ : LambertBranch) (z : ℂ) (hz : z ∉ principalCut)
    (hprincipal : principalBranch W₀) (hanalytic : analyticLambertBranch W₀)
    (hI : IntervalIntegrable (fun t : ℝ =>
      (((1 - (t : ℂ) / Complex.tan (t : ℂ)) ^ 2 + (t : ℂ) ^ 2) /
        (z + (t : ℂ) * Complex.exp (-(t : ℂ) / Complex.tan (t : ℂ)) /
      Complex.sin (t : ℂ)))) MeasureTheory.volume 0 Real.pi) :
    W₀.value z = z / Real.pi *
      (∫ t in (0 : ℝ)..Real.pi,
        (((1 - (t : ℂ) / Complex.tan (t : ℂ)) ^ 2 + (t : ℂ) ^ 2) /
          (z + (t : ℂ) * Complex.exp (-(t : ℂ) / Complex.tan (t : ℂ)) /
            Complex.sin (t : ℂ))))
-- ANCHOR_END: dlmf_4_13_15
:= by sorry

-- ANCHOR: dlmf_4_13_16
/-- DLMF 4.13.E16: the principal logarithmic integral representation. -/
theorem dlmf_4_13_16 (W₀ : LambertBranch) (z : ℂ) (hz : z ∉ principalCut)
    (hprincipal : principalBranch W₀) (hanalytic : analyticLambertBranch W₀)
    (hI : IntervalIntegrable (fun t : ℝ =>
      Complex.log (1 + z * Complex.sin (t : ℂ) / (t : ℂ) *
        Complex.exp ((t : ℂ) / Complex.tan (t : ℂ)))) MeasureTheory.volume 0 Real.pi) :
    W₀.value z = 1 / Real.pi *
      (∫ t in (0 : ℝ)..Real.pi,
        Complex.log (1 + z * Complex.sin (t : ℂ) / (t : ℂ) *
          Complex.exp ((t : ℂ) / Complex.tan (t : ℂ))))
-- ANCHOR_END: dlmf_4_13_16
:= by sorry

-- ANCHOR: dlmf_4_13_proof_E3_1
/-- DLMF 4.13 proof sketch after E3_1: substitution into the principal branch. -/
theorem dlmf_4_13_proof_E3_1 (W₀ : LambertBranch) (t x : ℂ)
    (hx : x = W₀.value t)
    (hEq : W₀.value t * Complex.exp (W₀.value t) = t)
    (hSelector : W₀.value (x * Complex.exp x) = x) :
    x * Complex.exp x = t ∧ W₀.value (x * Complex.exp x) = x
-- ANCHOR_END: dlmf_4_13_proof_E3_1
:= by sorry

-- ANCHOR: dlmf_4_13_proof_E3_2
/-- DLMF 4.13 proof sketch after E3_2: substitution on a signed side. -/
theorem dlmf_4_13_proof_E3_2 (Wpm : LambertBoundaryBranch) (t x : ℝ)
    (hx : x = Wpm.boundaryValue Wpm.side t)
    (hEq : Wpm.boundaryValue Wpm.side t * Complex.exp (Wpm.boundaryValue Wpm.side t) = t)
    (hSelector : Wpm.boundaryValue Wpm.side (x * Real.exp x) = x) :
    x * Real.exp x = t ∧ Wpm.boundaryValue Wpm.side (x * Real.exp x) = x
-- ANCHOR_END: dlmf_4_13_proof_E3_2
:= by sorry

-- ANCHOR: dlmf_4_13_proof_E9_1
/-- DLMF 4.13 proof sketch after E9_1: substitution into z(1+W)W' = W. -/
theorem dlmf_4_13_proof_E9_1 (W₀ : LambertBranch) (d : BranchPointDCoefficients)
    (z : ℂ)
    (hz : ‖Real.exp 1 * z + 1‖ < 1 ∧ z ∉ W₀.cut)
    (hprincipal : principalBranch W₀)
    (hseries : W₀.value z = branchPointSeries d z)
    (hderiv : HasDerivAt W₀.value (deriv W₀.value z) z)
    (hseriesDeriv : deriv W₀.value z = deriv (branchPointSeries d) z)
    (hode : z * (1 + W₀.value z) * deriv W₀.value z = W₀.value z) :
    z * (1 + branchPointSeries d z) * deriv (branchPointSeries d) z =
      branchPointSeries d z
-- ANCHOR_END: dlmf_4_13_proof_E9_1
:= by sorry

end
end LMLF.Blueprint.Elementary.Section413
