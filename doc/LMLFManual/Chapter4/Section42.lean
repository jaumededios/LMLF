import VersoManual
import Verso.Code.External
import LMLFManual.Components
import LMLF.Blueprint.Elementary.Section42

open Verso.Genre Manual
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.2 Definitions" =>
%%%
tag := "chapter-4-section-2"
%%%

The DLMF distinguishes the multivalued logarithm `Ln` from its principal branch `ln`.
The general path avoids the origin and has a branch point at `0`; the principal branch is analytic
on `ℂ \\ (-∞,0]` and real on positive reals. Figure [4.2.1](https://dlmf.nist.gov/4.2.F1)
shows the shared branch cut for `ln z` and `z^α`. We use the closed convention on the cut,
`-π < ph z ≤ π`, with explicit upper and lower cut values. Mathlib `Complex.log` is totalized at
zero, so the Lean statements retain the DLMF nonzero/domain hypotheses.

::::dlmfEntry "4.2.1" "https://dlmf.nist.gov/4.2.E1"
The general logarithm is the path integral `Ln z = ∫₁ᶻ dt/t` for `z ≠ 0`, with paths avoiding the origin.
The anchored Lean statement below is the algebraic principal branch-value specialization; the
path-integral continuation and winding construction remain documented here in prose.
:::leanStatement "Lean statement · general logarithm"
```anchor dlmf_4_2_1 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_1 (z : ℂ) (hz : z ≠ 0) : generalLogBranch z (Complex.log z) := by sorry
```
:::
::::

::::dlmfEntry "4.2.2–4.2.7" "https://dlmf.nist.gov/4.2.E2"
The principal logarithm is single-valued off the negative real axis.  Its phase lies in `(-π,π)`
for the open convention and in `(-π,π]` for the closed convention (the lower endpoint is excluded and `π` is included); the only zero of `ln z` is at `z=1`;
on the cut the upper and lower
values differ by the sign of `iπ`, and the general value adds `2 k π i`. Source links: [E2](https://dlmf.nist.gov/4.2.E2), [E3](https://dlmf.nist.gov/4.2.E3), [E4](https://dlmf.nist.gov/4.2.E4), [E5](https://dlmf.nist.gov/4.2.E5), [E6](https://dlmf.nist.gov/4.2.E6), and [E7](https://dlmf.nist.gov/4.2.E7).
:::leanStatement "Lean statements · principal and general logarithms"
```anchor dlmf_4_2_2 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_2 (z : ℂ) (hz : principalLogDomain z) : Complex.exp (Complex.log z) = z := by sorry
```
```anchor dlmf_4_2_3 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_3 (z : ℂ) (hz : principalLogDomain z) :
    Complex.log z = Real.log ‖z‖ + Complex.I * Complex.arg z := by sorry
```
```anchor dlmf_4_2_4 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_4 (x : ℝ) (hx : x < 0) :
    closedCutPoint x = (x : ℂ) ∧
      upperCutLog x - lowerCutLog x = 2 * Real.pi * Complex.I := by sorry
```
```anchor dlmf_4_2_5 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_5 (z : ℂ) (hz : closedPrincipalLogDomain z)
    (hphase : closedPrincipalPhase (Complex.log z)) :
    Complex.log z = Real.log ‖z‖ + Complex.I * Complex.arg z := by sorry
```
```anchor dlmf_4_2_6 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_6 (z : ℂ) (k : ℤ) (hz : z ≠ 0) :
    generalLogValue z k = Complex.log z + 2 * k * Real.pi * Complex.I := by sorry
```
```anchor dlmf_4_2_7 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_7 (x : ℝ) (hx : x < 0) :
    upperCutLog x = Real.log |x| + Real.pi * Complex.I ∧
      lowerCutLog x = Real.log |x| - Real.pi * Complex.I := by sorry
```
:::
::::

::::dlmfEntry "4.2.8–4.2.18" "https://dlmf.nist.gov/4.2.E8"
Changing the base gives logarithm quotients and the reciprocal/base-change identities.  The natural
base is the unique positive number `e`; the decimal formulas identify common and natural logarithms,
including the displayed numerical constants. E11 retains a coarse enclosure of the displayed decimal
prefix, while E15 includes both the quotient and `(log₁₀ e) ln z` equalities.
Source links: [E8](https://dlmf.nist.gov/4.2.E8), [E9](https://dlmf.nist.gov/4.2.E9), [E10](https://dlmf.nist.gov/4.2.E10), [E11](https://dlmf.nist.gov/4.2.E11), [E12](https://dlmf.nist.gov/4.2.E12), [E13](https://dlmf.nist.gov/4.2.E13), [E14](https://dlmf.nist.gov/4.2.E14), [E15](https://dlmf.nist.gov/4.2.E15), [E16](https://dlmf.nist.gov/4.2.E16), [E17](https://dlmf.nist.gov/4.2.E17), and [E18](https://dlmf.nist.gov/4.2.E18).
The reusable Lean API is `logBase a z = Complex.log z / Complex.log a`; its statements below
carry the source restrictions `a,b ≠ 0,1` and the nonzero denominator conditions. Lean's field
division is totalized, so these hypotheses are part of the mathematical interface rather than an
implicit convention.
:::leanStatement "Lean definition · logarithm to a general base"
```anchor logBase (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
def logBase (a z : ℂ) : ℂ := Complex.log z / Complex.log a
```
:::
:::leanStatement "Lean statements · logarithms to a general base"
```anchor dlmf_4_2_8 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_8 (a z : ℂ) (ha0 : a ≠ 0) (ha1 : a ≠ 1) (hz : z ≠ 0)
    (hden : Complex.log a ≠ 0) : logBase a z = Complex.log z / Complex.log a := by sorry
```
```anchor dlmf_4_2_9 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_9 (a b z : ℂ) (ha0 : a ≠ 0) (ha1 : a ≠ 1) (hb0 : b ≠ 0) (hb1 : b ≠ 1)
    (hz : z ≠ 0) (hba : Complex.log a ≠ 0) (hbb : Complex.log b ≠ 0) :
    logBase a z = logBase b z / logBase b a := by sorry
```
```anchor dlmf_4_2_10 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_10 (a b : ℂ) (ha0 : a ≠ 0) (ha1 : a ≠ 1) (hb0 : b ≠ 0) (hb1 : b ≠ 1)
    (hba : Complex.log a ≠ 0) (hbb : Complex.log b ≠ 0) : logBase a b = 1 / logBase b a := by sorry
```
```anchor dlmf_4_2_11 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_11 : |Real.exp 1 - 2.71828| < 0.00001 := by sorry
```
```anchor dlmf_4_2_12 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_12 : Real.log (Real.exp 1) = 1 := by sorry
```
```anchor dlmf_4_2_13 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_13 : ∫ x in (1 : ℝ)..Real.exp 1, 1 / x = 1 := by sorry
```
```anchor dlmf_4_2_14 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_14 (z : ℂ) (hz : z ≠ 0) : logBase (Real.exp 1) z = Complex.log z := by sorry
```
```anchor dlmf_4_2_15 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_15 (z : ℂ) (hz : z ≠ 0) (h10 : Real.log 10 ≠ 0) :
    logBase 10 z = Complex.log z / Real.log 10 ∧
      logBase 10 z = logBase 10 (Real.exp 1) * Complex.log z := by sorry
```
```anchor dlmf_4_2_16 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_16 (z : ℂ) (hz : z ≠ 0) (h10 : Real.log 10 ≠ 0) :
    Complex.log z = Real.log 10 * logBase 10 z := by sorry
```
```anchor dlmf_4_2_17 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_17 : |1 / Real.log 10 - 0.43429| < 0.00001 := by sorry
```
```anchor dlmf_4_2_18 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_18 : |Real.log 10 - 2.30258| < 0.00001 := by sorry
```
:::
::::

::::dlmfEntry "4.2.19–4.2.25" "https://dlmf.nist.gov/4.2.E19"
The exponential is entire and has no real or complex zeros; it also has the displayed power series, period `2πi`, reciprocal identity,
modulus `exp(Re z)`, phase modulo `2π`, Cartesian decomposition, and inverse relation with the general logarithm.
Source links: [E19](https://dlmf.nist.gov/4.2.E19), [E20](https://dlmf.nist.gov/4.2.E20), [E21](https://dlmf.nist.gov/4.2.E21), [E22](https://dlmf.nist.gov/4.2.E22), [E23](https://dlmf.nist.gov/4.2.E23), [E24](https://dlmf.nist.gov/4.2.E24), and [E25](https://dlmf.nist.gov/4.2.E25).
:::leanStatement "Lean statements · exponential function"
```anchor dlmf_4_2_19 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_19 (z : ℂ) :
    HasSum (fun n : ℕ ↦ z ^ n / Nat.factorial n) (Complex.exp z) := by sorry
```
```anchor dlmf_4_2_20 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_20 (z : ℂ) : Complex.exp (z + 2 * Real.pi * Complex.I) = Complex.exp z := by sorry
```
```anchor dlmf_4_2_21 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_21 (z : ℂ) : Complex.exp (-z) = 1 / Complex.exp z := by sorry
```
```anchor dlmf_4_2_22 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_22 (z : ℂ) : ‖Complex.exp z‖ = Real.exp z.re := by sorry
```
```anchor dlmf_4_2_23 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_23 (z : ℂ) :
    ∃ k : ℤ, z.im + 2 * k * Real.pi = Complex.arg (Complex.exp z) := by sorry
```
```anchor dlmf_4_2_24 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_24 (x y : ℝ) :
    Complex.exp (x + Complex.I * y) =
      Real.exp x * Real.cos y + Complex.I * (Real.exp x * Real.sin y) := by sorry
```
```anchor dlmf_4_2_25 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_25 (ζ : ℂ) (hζ : ζ ≠ 0) :
    ∀ z : ℂ, Complex.exp z = ζ ↔ ∃ k : ℤ, z = generalLogValue ζ k := by sorry
```
:::
::::

::::dlmfEntry "4.2.26–4.2.37" "https://dlmf.nist.gov/4.2.E26"
Powers are defined through `exp(a Ln z)` in general and `exp(a ln z)` principally; E26 retains every
integer logarithm branch, while E28 onward specializes to the principal slit-plane branch. The section records
integer powers, modulus and phase formulas, the relation with `e^z`, factorial series for `e`, inversion,
the principal-value phase restriction `-π ≤ Im((1/a)Ln w) ≤ π`, and the closed-definition square-root example.
The principal power is analytic on `ℂ \ (-∞,0]` and is two-valued and discontinuous on the cut unless
the exponent is integral. For the open convention, the final E37 inequalities become strict.
E36 assumes the half-open principal-phase condition `-π < Im((1/a) ln w) ≤ π` and concludes
the corresponding principal-power inversion; it does not assert that this condition holds universally.
Source links: [E26](https://dlmf.nist.gov/4.2.E26), [E27](https://dlmf.nist.gov/4.2.E27), [E28](https://dlmf.nist.gov/4.2.E28), [E29](https://dlmf.nist.gov/4.2.E29), [E30](https://dlmf.nist.gov/4.2.E30), [E31](https://dlmf.nist.gov/4.2.E31), [E32](https://dlmf.nist.gov/4.2.E32), [E33](https://dlmf.nist.gov/4.2.E33), [E34](https://dlmf.nist.gov/4.2.E34), [E35](https://dlmf.nist.gov/4.2.E35), [E36](https://dlmf.nist.gov/4.2.E36), and [E37](https://dlmf.nist.gov/4.2.E37).
:::leanStatement "Lean statements · powers"
```anchor dlmf_4_2_26 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_26 (z a : ℂ) (k : ℤ) (hz : z ≠ 0) :
    generalPowerValue z a k = Complex.exp (a * generalLogValue z k) := by sorry
```
```anchor dlmf_4_2_27 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_27 (z : ℂ) (n : ℕ) (hz : z ≠ 0) :
    generalPowerValue z n 0 = z ^ n ∧
      generalPowerValue z (- (n : ℂ)) 0 = 1 / z ^ n := by sorry
```
```anchor dlmf_4_2_28 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_28 (z a : ℂ) (hz : principalLogDomain z) : principalPower z a = Complex.exp (a * Complex.log z) := by sorry
```
```anchor dlmf_4_2_29 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_29 (z a : ℂ) (hz : principalLogDomain z) : ‖principalPower z a‖ = ‖z‖ ^ a.re * Real.exp (-a.im * Complex.arg z) := by sorry
```
```anchor dlmf_4_2_30 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_30 (z a : ℂ) (hz : principalLogDomain z) : ∃ k : ℤ, Complex.arg (principalPower z a) = a.re * Complex.arg z + a.im * Real.log ‖z‖ + 2 * k * Real.pi := by sorry
```
```anchor dlmf_4_2_31a (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_31a (z : ℂ) (a : ℝ) (hz : principalLogDomain z) : ‖principalPower z a‖ = ‖z‖ ^ a := by sorry
```
```anchor dlmf_4_2_31b (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_31b (z : ℂ) (a : ℝ) (hz : principalLogDomain z) : ∃ k : ℤ, Complex.arg (principalPower z a) = a * Complex.arg z + 2 * k * Real.pi := by sorry
```
```anchor dlmf_4_2_32 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_32 (z : ℂ) : (Real.exp 1 : ℂ) ^ z = Complex.exp z := by sorry
```
```anchor dlmf_4_2_33 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_33 (z : ℂ) : ∀ k : ℤ, generalPowerValue (Real.exp 1) z k = Complex.exp z * Complex.exp (2 * k * z * Real.pi * Complex.I) := by sorry
```
```anchor dlmf_4_2_34 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_34 : (Real.exp 1 : ℝ) = ∑' n : ℕ, (1 : ℝ) / Nat.factorial n := by sorry
```
```anchor dlmf_4_2_35 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_35 (z w a : ℂ) (hz : z ≠ 0) (ha : a ≠ 0) (hw : w ≠ 0) :
    (∃ k : ℤ, generalPowerValue z a k = w) ↔
      ∃ k : ℤ, z = Complex.exp ((1 / a) * generalLogValue w k) := by sorry
```
```anchor dlmf_4_2_36 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_36 (a w : ℂ) (ha : a ≠ 0) (hw : w ≠ 0)
    (hphase : -Real.pi < ((1 / a) * Complex.log w).im ∧
      ((1 / a) * Complex.log w).im ≤ Real.pi) :
    principalPower (Complex.exp ((1 / a) * Complex.log w)) a = w := by sorry
```
```anchor dlmf_4_2_37 (module := LMLF.Blueprint.Elementary.Section42) -showProofStates
theorem dlmf_4_2_37 (z : ℂ) : Complex.sqrt (z ^ 2) =
    if 0 < z.re ∨ (z.re = 0 ∧ 0 ≤ z.im) then z else -z := by sorry
```
:::
::::
