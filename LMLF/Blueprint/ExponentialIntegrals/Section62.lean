import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import LMLF.Blueprint.ExponentialIntegrals.Section61
import LMLF.Integral.Curve

open scoped Interval Topology
open Filter
noncomputable section
local instance propDecidable (p : Prop) : Decidable p := Classical.propDecidable p
namespace LMLF.Blueprint.ExponentialIntegrals.Section62

/-! DLMF §6.2 supplies principal-branch functions and their value/path
interfaces. The reader-facing declarations below use named maps and typed
path/value interfaces. -/

/- DLMF 6.2 principal branch domain: the negative real cut, including zero. -/
def principalCutDomain (z : ℂ) : Prop :=
  ¬ (z.im = 0 ∧ z.re ≤ 0)

/-! Shared path/value vocabulary. New reader statements use the typed
`ImproperC1Ray` interface from `LMLF.Integral.Curve`; the path integral
interface remains available to the later contour formulas in Chapter 6. -/

def pathIntegral (f : ℂ → ℂ) (γ : ℝ → ℂ) (a b : ℝ) : ℂ :=
  ∫ t in a..b, f (γ t) * deriv γ t

def regularPath (γ : ℝ → ℂ) : Prop :=
  Continuous γ ∧ ∀ t : ℝ, DifferentiableAt ℝ γ t

def HasImproperPathIntegral (f : ℂ → ℂ) (γ : ℝ → ℂ) (a : ℝ) (v : ℂ) : Prop :=
  (∀ R : ℝ, a ≤ R →
      IntervalIntegrable (fun t : ℝ => f (γ t) * deriv γ t)
        MeasureTheory.volume a R) ∧
    Tendsto (fun R : ℝ => pathIntegral f γ a R) atTop (𝓝 v)

def HasImproperIntegral (f : ℝ → ℂ) (a : ℝ) (v : ℂ) : Prop :=
  (∀ R : ℝ, a ≤ R → IntervalIntegrable f MeasureTheory.volume a R) ∧
    Tendsto (fun R : ℝ => ∫ t in a..R, f t) atTop (𝓝 v)

def HasCauchyPrincipalValue (f : ℝ → ℂ) (a b c : ℝ) (v : ℂ) : Prop :=
  (∀ ε : ℝ, 0 < ε →
      IntervalIntegrable f MeasureTheory.volume a (c - ε) ∧
        IntervalIntegrable f MeasureTheory.volume (c + ε) b) ∧
    Tendsto
      (fun ε : ℝ => ∫ t in a..(c - ε), f t + ∫ t in (c + ε)..b, f t)
      (nhdsWithin 0 (Set.Ioi 0)) (𝓝 v)

def HasLowerImproperPrincipalValue (f : ℝ → ℂ) (a : ℝ) (v : ℂ) : Prop :=
  (∀ R : ℝ, 0 < R →
      IntervalIntegrable f MeasureTheory.volume a (-1 / R) ∧
        IntervalIntegrable f MeasureTheory.volume (1 / R) R) ∧
    Tendsto
      (fun R : ℝ =>
        (∫ t in a..(-1 / R), f t) + ∫ t in (1 / R)..R, f t)
      atTop (𝓝 v)

def HasUpperImproperPrincipalValue (f : ℝ → ℂ) (b : ℝ) (v : ℂ) : Prop :=
  (∀ R : ℝ, 0 < R →
      IntervalIntegrable f MeasureTheory.volume (-R) (-1 / R) ∧
        IntervalIntegrable f MeasureTheory.volume (1 / R) b) ∧
    Tendsto
      (fun R : ℝ =>
        (∫ t in (-R)..(-1 / R), f t) + ∫ t in (1 / R)..b, f t)
      atTop (𝓝 v)

/-! Typed branch-aware improper rays. -/

/-- A principal-cut E₁ ray, with the branch invariant stored for its lifetime. -/
structure PrincipalE1Ray extends LMLF.Integral.ImproperC1Ray where
  avoidsCut : ∀ t : ℝ, 0 ≤ t → principalCutDomain (point t)

/-- A sine-tail ray avoids only the origin, not E₁'s logarithmic cut. -/
structure SineTailRay extends LMLF.Integral.ImproperC1Ray where
  avoidsOrigin : ∀ t : ℝ, 0 ≤ t → point t ≠ 0

/-! Principal-value helpers used by the anchored real-Ei and logarithmic
integral statements. The anchored declarations below use the canonical maps
for function values and keep these convergence specifications separate. -/

def hasEiLowerPV (x : ℝ) (v : ℂ) : Prop :=
  HasLowerImproperPrincipalValue
    (fun t : ℝ => Complex.exp (-(t : ℂ)) / (t : ℂ)) (-x) (-v)

def hasEiUpperPV (x : ℝ) (v : ℂ) : Prop :=
  HasUpperImproperPrincipalValue
    (fun t : ℝ => Complex.exp (t : ℂ) / (t : ℂ)) x v

def hasLogarithmicIntegralPV (x : ℝ) (v : ℝ) : Prop :=
  (∀ ε : ℝ, 0 < ε → ε < min 1 (x - 1) →
      IntervalIntegrable (fun t : ℝ => 1 / Real.log t) MeasureTheory.volume 0 (1 - ε) ∧
        IntervalIntegrable (fun t : ℝ => 1 / Real.log t) MeasureTheory.volume (1 + ε) x) ∧
    Tendsto
      (fun ε : ℝ =>
        (∫ t in (0 : ℝ)..(1 - ε), 1 / Real.log t) +
          ∫ t in (1 + ε)..x, 1 / Real.log t)
      (nhdsWithin 0 (Set.Ioi 0)) (𝓝 v)

/-! Canonical Chapter 6 maps. Their branch and convergence domains are carried
explicitly by the theorem statements below. -/

-- ANCHOR: dlmf_6_2_3
/-- DLMF 6.2.3: the entire complementary exponential integral. -/
def principalEin (z : ℂ) : ℂ :=
  ∫ t in (0 : ℝ)..1,
    (if t * z = 0 then 1 else (1 - Complex.exp (-(t * z))) / (t * z)) * z
-- ANCHOR_END: dlmf_6_2_3

/-- The principal E₁ function on the principal-cut domain. -/
def principalE1 (z : ℂ) : ℂ :=
  if _ : principalCutDomain z then
    principalEin z - Complex.log z - Real.eulerMascheroniConstant
  else 0

/-- The real positive-ray E₁ value, defined from the principal E₁ map. -/
def realE1 (x : ℝ) : ℂ :=
  if 0 < x then principalE1 (x : ℂ) else 0

/-- The principal real exponential integral away from its singular point. -/
def realEi (x : ℝ) : ℂ :=
  if x = 0 then 0
  else -principalEin (-x) + (Real.log |x| : ℂ) + Real.eulerMascheroniConstant

-- ANCHOR: dlmf_6_2_9
/-- DLMF 6.2.9: the entire sine integral. -/
def principalSi (z : ℂ) : ℂ :=
  ∫ t in (0 : ℝ)..1,
    (if t * z = 0 then 1 else Complex.sin (t * z) / (t * z)) * z
-- ANCHOR_END: dlmf_6_2_9

/-- DLMF's lower-case sine integral `si(z) = Si(z) - π/2`. -/
def si (z : ℂ) : ℂ := principalSi z - Real.pi / 2

-- ANCHOR: dlmf_6_2_12
/-- DLMF 6.2.12: the entire cosine integral Cin. -/
def principalCin (z : ℂ) : ℂ :=
  ∫ t in (0 : ℝ)..1,
    (if t * z = 0 then 0 else (1 - Complex.cos (t * z)) / (t * z)) * z
-- ANCHOR_END: dlmf_6_2_12

/-- The principal cosine integral on the principal-cut domain. -/
def principalCi (z : ℂ) : ℂ :=
  if _ : principalCutDomain z then
    -principalCin z + Complex.log z + Real.eulerMascheroniConstant
  else 0

def principalCiPositive (x : ℝ) : ℂ :=
  -principalCin x + Complex.log x + Real.eulerMascheroniConstant

/-- The regular entire part of the principal hyperbolic cosine integral. -/
def principalChiRegular (z : ℂ) : ℂ :=
  ∫ t in (0 : ℝ)..1,
    (if t * z = 0 then 0 else (Complex.cosh (t * z) - 1) / (t * z)) * z

-- ANCHOR: dlmf_6_2_15
/-- DLMF 6.2.15: the entire hyperbolic sine integral. -/
def principalShi (z : ℂ) : ℂ :=
  ∫ t in (0 : ℝ)..1,
    (if t * z = 0 then 1 else Complex.sinh (t * z) / (t * z)) * z
-- ANCHOR_END: dlmf_6_2_15

def principalChi (z : ℂ) : ℂ :=
  if _ : principalCutDomain z then
    Real.eulerMascheroniConstant + Complex.log z + principalChiRegular z
  else 0

-- ANCHOR: dlmf_6_2_17
/-- DLMF 6.2.17: the canonical auxiliary function f. -/
def principalAuxiliaryF (z : ℂ) : ℂ :=
  principalCi z * Complex.sin z - si z * Complex.cos z
-- ANCHOR_END: dlmf_6_2_17

-- ANCHOR: dlmf_6_2_18
/-- DLMF 6.2.18: the canonical auxiliary function g. -/
def principalAuxiliaryG (z : ℂ) : ℂ :=
  -principalCi z * Complex.cos z - si z * Complex.sin z
-- ANCHOR_END: dlmf_6_2_18

-- ANCHOR: dlmf_6_2_1
/-- DLMF 6.2.1: principal E₁ is represented by a typed cut-avoiding ray. -/
theorem dlmf_6_2_1_spec (z : ℂ) (hz : principalCutDomain z) :
    ∃ γ : PrincipalE1Ray, γ.start = z ∧
      γ.toImproperC1Ray.HasImproperIntegral
        (fun u : ℂ => Complex.exp (-u) / u) (principalE1 z)
-- ANCHOR_END: dlmf_6_2_1
    := by sorry

-- ANCHOR: dlmf_6_2_2
/-- DLMF 6.2.2: the principal E₁ value equals its convergent ray form. -/
theorem dlmf_6_2_2_spec (z : ℂ) (hz : principalCutDomain z) :
    HasImproperIntegral
      (fun t : ℝ => Complex.exp (-(t : ℂ)) / ((t : ℂ) + z)) 0
      (Complex.exp z * principalE1 z)
-- ANCHOR_END: dlmf_6_2_2
    := by sorry

-- ANCHOR: dlmf_6_2_4
/-- DLMF 6.2.4: E₁ and Ein on the principal branch. -/
theorem dlmf_6_2_4_spec (z : ℂ) (hz : principalCutDomain z) :
    principalE1 z = principalEin z - Complex.log z -
      Real.eulerMascheroniConstant
-- ANCHOR_END: dlmf_6_2_4
    := by sorry

-- ANCHOR: dlmf_6_2_5
/-- DLMF 6.2.5: the two principal-value forms of real Ei. -/
theorem dlmf_6_2_5_spec (x : ℝ) (hx : 0 < x) :
    hasEiLowerPV x (realEi x) ∧ hasEiUpperPV x (realEi x)
-- ANCHOR_END: dlmf_6_2_5
    := by sorry

-- ANCHOR: dlmf_6_2_6
/-- DLMF 6.2.6: negative-real Ei equals minus the positive E₁ value. -/
theorem dlmf_6_2_6_spec (x : ℝ) (hx : 0 < x) :
    realEi (-x) = -realE1 x ∧
      HasImproperIntegral
        (fun t : ℝ => Complex.exp (-(t : ℂ)) / (t : ℂ)) x (realE1 x)
-- ANCHOR_END: dlmf_6_2_6
    := by sorry

-- ANCHOR: dlmf_6_2_7
/-- DLMF 6.2.7: both real Ei values in terms of Ein. -/
theorem dlmf_6_2_7_spec (x : ℝ) (hx : 0 < x) :
    realEi x = -principalEin (-x) + (Real.log x : ℂ) +
        Real.eulerMascheroniConstant ∧
      realEi (-x) = -principalEin x + (Real.log x : ℂ) +
        Real.eulerMascheroniConstant
-- ANCHOR_END: dlmf_6_2_7
    := by sorry

-- ANCHOR: dlmf_6_2_8
/-- DLMF 6.2.8: the logarithmic integral agrees with Ei of log x. -/
theorem dlmf_6_2_8_spec (x : ℝ) (hx : 1 < x) (li : ℝ)
    (hli : hasLogarithmicIntegralPV x li) :
    (li : ℂ) = realEi (Real.log x)
-- ANCHOR_END: dlmf_6_2_8
    := by sorry

-- ANCHOR: dlmf_6_2_10
/-- DLMF 6.2.10: the sine tail and its canonical `Si - π/2` value. -/
theorem dlmf_6_2_10_spec (z : ℂ) (hz : z ≠ 0) :
    si z = principalSi z - Real.pi / 2 ∧
      ∃ γ : SineTailRay, γ.start = z ∧
        γ.toImproperC1Ray.HasImproperIntegral
          (fun u : ℂ => Complex.sin u / u) (-si z)
-- ANCHOR_END: dlmf_6_2_10
    := by sorry

-- ANCHOR: dlmf_6_2_11
/-- DLMF 6.2.11: principal Ci is minus a cut-avoiding cosine tail. -/
theorem dlmf_6_2_11_spec (z : ℂ) (hz : principalCutDomain z) :
    ∃ γ : PrincipalE1Ray, γ.start = z ∧
      γ.toImproperC1Ray.HasImproperIntegral
        (fun u : ℂ => Complex.cos u / u) (-principalCi z)
-- ANCHOR_END: dlmf_6_2_11
    := by sorry

-- ANCHOR: dlmf_6_2_13
/-- DLMF 6.2.13: principal Ci and the entire Cin function. -/
theorem dlmf_6_2_13_spec (z : ℂ) (hz : principalCutDomain z) :
    principalCi z = -principalCin z + Complex.log z +
      Real.eulerMascheroniConstant
-- ANCHOR_END: dlmf_6_2_13
    := by sorry

-- ANCHOR: dlmf_6_2_14
/-- DLMF 6.2.14: positive-real limits of Si and Ci. -/
theorem dlmf_6_2_14_spec :
    Tendsto (fun x : ℝ => principalSi x) atTop (𝓝 (Real.pi / 2)) ∧
      Tendsto (fun x : ℝ => principalCi (x : ℂ)) atTop (𝓝 0)
-- ANCHOR_END: dlmf_6_2_14
    := by sorry

-- ANCHOR: dlmf_6_2_16
/-- DLMF 6.2.16: principal Chi and its regular entire part. -/
theorem dlmf_6_2_16_spec (z : ℂ) (hz : principalCutDomain z) :
    principalChi z = Real.eulerMascheroniConstant + Complex.log z +
      principalChiRegular z
-- ANCHOR_END: dlmf_6_2_16
    := by sorry

-- ANCHOR: dlmf_6_2_19
/-- DLMF 6.2.19: the canonical auxiliary pair reconstructs Si. -/
theorem dlmf_6_2_19_spec (z : ℂ) (hz : principalCutDomain z) :
    principalSi z = Real.pi / 2 - principalAuxiliaryF z * Complex.cos z -
      principalAuxiliaryG z * Complex.sin z
-- ANCHOR_END: dlmf_6_2_19
    := by sorry

-- ANCHOR: dlmf_6_2_20
/-- DLMF 6.2.20: the canonical auxiliary pair reconstructs Ci. -/
theorem dlmf_6_2_20_spec (z : ℂ) (hz : principalCutDomain z) :
    principalCi z = principalAuxiliaryF z * Complex.sin z -
      principalAuxiliaryG z * Complex.cos z
-- ANCHOR_END: dlmf_6_2_20
    := by sorry

-- ANCHOR: dlmf_6_2_21
/-- DLMF 6.2.21: derivative laws for the canonical auxiliary pair. -/
theorem dlmf_6_2_21_spec (z : ℂ) (hz : principalCutDomain z) :
    HasDerivAt principalAuxiliaryF (-principalAuxiliaryG z) z ∧
      HasDerivAt principalAuxiliaryG (principalAuxiliaryF z - 1 / z) z
-- ANCHOR_END: dlmf_6_2_21
    := by sorry

end LMLF.Blueprint.ExponentialIntegrals.Section62
