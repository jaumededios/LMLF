import LMLF.Definitions.Gamma
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import LMLF.Integral.Curve

/-!
# DLMF §5.13: integrals

The displayed formulas use named integrands and typed domain data. In particular,
`VerticalLine` is the canonical straight contour `s = c + i t`; its tangent is
part of the object rather than a derivative hypothesis repeated in every theorem.
Integrability declarations are kept separate from the corresponding value identities.
-/

open Filter MeasureTheory Set
open scoped BigOperators

noncomputable section

namespace LMLF.Blueprint.Gamma.Section513

open LMLF.Integral

/-! ## Shared contour and branch vocabulary -/

/-- DLMF 5.13.1: a nonzero base equipped with the source's principal-phase domain. -/
-- ANCHOR: PrincipalPowerPoint
structure PrincipalPowerPoint where
  value : ℂ
  nonzero : value ≠ 0
  phase : |Complex.arg value| < Real.pi
-- ANCHOR_END: PrincipalPowerPoint

/-- DLMF 5.13.1: the underlying complex value of a principal-power point. -/
-- ANCHOR: principalPowerPointCoe
instance principalPowerPointCoe : Coe PrincipalPowerPoint ℂ :=
  ⟨PrincipalPowerPoint.value⟩
-- ANCHOR_END: principalPowerPointCoe

/-- DLMF 5.13.5: a Gamma parameter carrying the pole-free invariant used by the
de Branges--Wilson kernel. -/
-- ANCHOR: PoleFreeGammaPoint
structure PoleFreeGammaPoint where
  value : ℂ
  not_pole : ∀ n : ℕ, value ≠ -(n : ℂ)
-- ANCHOR_END: PoleFreeGammaPoint

/-- DLMF 5.13.5: the underlying complex value of a pole-free Gamma point. -/
-- ANCHOR: poleFreeGammaPointCoe
instance poleFreeGammaPointCoe : Coe PoleFreeGammaPoint ℂ :=
  ⟨PoleFreeGammaPoint.value⟩
-- ANCHOR_END: poleFreeGammaPointCoe

/-! ## Barnes' first integral -/

/-- DLMF 5.13.1: domain data for Barnes' vertical-line beta integral. -/
-- ANCHOR: BarnesFirstDomain
structure BarnesFirstDomain where
  a : ℂ
  b : ℂ
  z : PrincipalPowerPoint
  c : ℝ
  hab : 0 < (a + b).re
  lower : -a.re < c
  upper : c < b.re
-- ANCHOR_END: BarnesFirstDomain

/-- DLMF 5.13.1: the displayed Gamma-product integrand on the vertical line. -/
-- ANCHOR: BarnesFirstDomain.integrand
def BarnesFirstDomain.integrand (p : BarnesFirstDomain) : ℂ → ℂ := fun s ↦
  Complex.Gamma (s + p.a) * Complex.Gamma (p.b - s) *
    (p.z : ℂ) ^ (-s)
-- ANCHOR_END: BarnesFirstDomain.integrand

/-- DLMF 5.13.1: convergence of Barnes' vertical-line integral. -/
-- ANCHOR: dlmf_5_13_1_integrable
theorem dlmf_5_13_1_integrable (p : BarnesFirstDomain) :
    (verticalLine p.c).Integrable p.integrand
-- ANCHOR_END: dlmf_5_13_1_integrable
  := by sorry

/-- DLMF 5.13.1: Barnes' vertical-line value identity. -/
-- DLMF 5.13.1 https://dlmf.nist.gov/5.13.E1
-- ANCHOR: dlmf_5_13_1
theorem dlmf_5_13_1 (p : BarnesFirstDomain) :
    (1 / (2 * Real.pi * Complex.I)) *
        (verticalLine p.c).integral p.integrand =
      Complex.Gamma (p.a + p.b) * (p.z : ℂ) ^ p.a /
        (1 + (p.z : ℂ)) ^ (p.a + p.b)
-- ANCHOR_END: dlmf_5_13_1
  := by sorry

/-! ## Barnes' modulus-square integral -/

/-- DLMF 5.13.2: real parameter domain for the modulus-square integral. -/
-- ANCHOR: BarnesModulusDomain
structure BarnesModulusDomain where
  a : ℝ
  b : ℝ
  a_pos : 0 < a
  b_pos : 0 < b
  b_lt_pi : b < Real.pi
-- ANCHOR_END: BarnesModulusDomain

/-- DLMF 5.13.2: the real modulus-square integrand. -/
-- ANCHOR: BarnesModulusDomain.integrand
def BarnesModulusDomain.integrand (p : BarnesModulusDomain) (t : ℝ) : ℝ :=
  ‖Complex.Gamma ((p.a : ℂ) + (t : ℂ) * Complex.I)‖ ^ 2 *
    Real.exp ((2 * p.b - Real.pi) * t)
-- ANCHOR_END: BarnesModulusDomain.integrand

/-- DLMF 5.13.2: convergence of the modulus-square integral. -/
-- ANCHOR: dlmf_5_13_2_integrable
theorem dlmf_5_13_2_integrable (p : BarnesModulusDomain) :
    MeasureTheory.Integrable p.integrand
-- ANCHOR_END: dlmf_5_13_2_integrable
  := by sorry

/-- DLMF 5.13.2: Barnes' modulus-square value identity. -/
-- DLMF 5.13.2 https://dlmf.nist.gov/5.13.E2
-- ANCHOR: dlmf_5_13_2
theorem dlmf_5_13_2 (p : BarnesModulusDomain) :
    (1 / (2 * Real.pi : ℝ)) * (∫ t : ℝ, p.integrand t) =
      Real.Gamma (2 * p.a) / (2 * Real.sin p.b) ^ (2 * p.a)
-- ANCHOR_END: dlmf_5_13_2
  := by sorry

/-! ## Barnes' beta integral -/

/-- DLMF 5.13.3: complex domain data for Barnes' beta integral. -/
-- ANCHOR: BarnesBetaDomain
structure BarnesBetaDomain where
  a : ℂ
  b : ℂ
  c : ℂ
  d : ℂ
  a_pos : 0 < a.re
  b_pos : 0 < b.re
  c_pos : 0 < c.re
  d_pos : 0 < d.re
-- ANCHOR_END: BarnesBetaDomain

/-- DLMF 5.13.3: the four-factor Barnes beta integrand. -/
-- ANCHOR: BarnesBetaDomain.integrand
def BarnesBetaDomain.integrand (p : BarnesBetaDomain) (t : ℝ) : ℂ :=
  Complex.Gamma (p.a + (t : ℂ) * Complex.I) *
    Complex.Gamma (p.b + (t : ℂ) * Complex.I) *
    Complex.Gamma (p.c - (t : ℂ) * Complex.I) *
    Complex.Gamma (p.d - (t : ℂ) * Complex.I)
-- ANCHOR_END: BarnesBetaDomain.integrand

/-- DLMF 5.13.3: the normalized whole-line Barnes beta integral. -/
-- ANCHOR: BarnesBetaDomain.integral
noncomputable def BarnesBetaDomain.integral (p : BarnesBetaDomain) : ℂ :=
  (1 / (2 * Real.pi : ℂ)) * ∫ t : ℝ, p.integrand t
-- ANCHOR_END: BarnesBetaDomain.integral

/-- DLMF 5.13.3: convergence of Barnes' beta integrand. -/
-- ANCHOR: dlmf_5_13_3_integrable
theorem dlmf_5_13_3_integrable (p : BarnesBetaDomain) :
    MeasureTheory.Integrable p.integrand
-- ANCHOR_END: dlmf_5_13_3_integrable
  := by sorry

/-- DLMF 5.13.3: Barnes' beta value identity. -/
-- DLMF 5.13.3 https://dlmf.nist.gov/5.13.E3
-- ANCHOR: dlmf_5_13_3
theorem dlmf_5_13_3 (p : BarnesBetaDomain) :
    p.integral =
      Complex.Gamma (p.a + p.c) * Complex.Gamma (p.a + p.d) *
        Complex.Gamma (p.b + p.c) * Complex.Gamma (p.b + p.d) /
          Complex.Gamma (p.a + p.b + p.c + p.d)
-- ANCHOR_END: dlmf_5_13_3
  := by sorry

/-! ## Ramanujan's beta integral -/

/-- DLMF 5.13.4: domain data for Ramanujan's reciprocal-Gamma integral. -/
-- ANCHOR: RamanujanBetaDomain
structure RamanujanBetaDomain where
  a : ℂ
  b : ℂ
  c : ℂ
  d : ℂ
  sum_gt_three : 3 < (a + b + c + d).re
-- ANCHOR_END: RamanujanBetaDomain

/-- DLMF 5.13.4: the reciprocal four-Gamma integrand. -/
-- ANCHOR: RamanujanBetaDomain.integrand
def RamanujanBetaDomain.integrand (p : RamanujanBetaDomain) (t : ℝ) : ℂ :=
  1 / (Complex.Gamma (p.a + (t : ℂ)) * Complex.Gamma (p.b + (t : ℂ)) *
    Complex.Gamma (p.c - (t : ℂ)) * Complex.Gamma (p.d - (t : ℂ)))
-- ANCHOR_END: RamanujanBetaDomain.integrand

/-- DLMF 5.13.4: convergence of Ramanujan's reciprocal-Gamma integral. -/
-- ANCHOR: dlmf_5_13_4_integrable
theorem dlmf_5_13_4_integrable (p : RamanujanBetaDomain) :
    MeasureTheory.Integrable p.integrand
-- ANCHOR_END: dlmf_5_13_4_integrable
  := by sorry

/-- DLMF 5.13.4: Ramanujan's beta value identity. -/
-- DLMF 5.13.4 https://dlmf.nist.gov/5.13.E4
-- ANCHOR: dlmf_5_13_4
theorem dlmf_5_13_4 (p : RamanujanBetaDomain) :
    (∫ t : ℝ, p.integrand t) =
      Complex.Gamma (p.a + p.b + p.c + p.d - 3) /
        (Complex.Gamma (p.a + p.c - 1) * Complex.Gamma (p.a + p.d - 1) *
          Complex.Gamma (p.b + p.c - 1) * Complex.Gamma (p.b + p.d - 1))
-- ANCHOR_END: dlmf_5_13_4
  := by sorry

/-! ## de Branges--Wilson's beta integral -/

/-- DLMF 5.13.5: four positive Gamma parameters with their pole-free invariant. -/
-- ANCHOR: DeBrangesWilsonDomain
structure DeBrangesWilsonDomain where
  parameter : Fin 4 → PoleFreeGammaPoint
  positive : ∀ k : Fin 4, 0 < ((parameter k : ℂ).re)
-- ANCHOR_END: DeBrangesWilsonDomain

/-- DLMF 5.13.5: the numerator of the de Branges--Wilson integrand. -/
-- ANCHOR: DeBrangesWilsonDomain.numerator
def DeBrangesWilsonDomain.numerator (p : DeBrangesWilsonDomain) (t : ℝ) : ℂ :=
  ∏ k : Fin 4,
    Complex.Gamma ((p.parameter k : ℂ) + (t : ℂ) * Complex.I) *
      Complex.Gamma ((p.parameter k : ℂ) - (t : ℂ) * Complex.I)
-- ANCHOR_END: DeBrangesWilsonDomain.numerator

/-- DLMF 5.13.5: the pole-free extension of the displayed quotient. At `t = 0`
the reciprocal-Gamma factors provide its removable totalized value. -/
-- ANCHOR: DeBrangesWilsonDomain.integrand
def DeBrangesWilsonDomain.integrand (p : DeBrangesWilsonDomain) (t : ℝ) : ℂ :=
  p.numerator t *
    (1 / Complex.Gamma (2 * (t : ℂ) * Complex.I)) *
    (1 / Complex.Gamma (-2 * (t : ℂ) * Complex.I))
-- ANCHOR_END: DeBrangesWilsonDomain.integrand

/-- DLMF 5.13.5: convergence of the de Branges--Wilson integrand. -/
-- ANCHOR: dlmf_5_13_5_integrable
theorem dlmf_5_13_5_integrable (p : DeBrangesWilsonDomain) :
    MeasureTheory.Integrable p.integrand
-- ANCHOR_END: dlmf_5_13_5_integrable
  := by sorry

/-- DLMF 5.13.5: de Branges--Wilson's beta value identity. -/
-- DLMF 5.13.5 https://dlmf.nist.gov/5.13.E5
-- ANCHOR: dlmf_5_13_5
theorem dlmf_5_13_5 (p : DeBrangesWilsonDomain) :
    (1 / (4 * Real.pi : ℝ)) * ∫ t : ℝ, p.integrand t =
      (∏ j : Fin 4, ∏ k : Fin 4,
        if j < k then Complex.Gamma ((p.parameter j : ℂ) + (p.parameter k : ℂ)) else 1) /
        Complex.Gamma (∑ k : Fin 4, (p.parameter k : ℂ))
-- ANCHOR_END: dlmf_5_13_5
  := by sorry

end LMLF.Blueprint.Gamma.Section513
