import Mathlib.Analysis.SpecialFunctions.Complex.Log
import Mathlib.Analysis.SpecialFunctions.Gamma.Digamma
import LMLF.Blueprint.ExponentialIntegrals.Section62

open scoped BigOperators
noncomputable section

namespace LMLF.Blueprint.ExponentialIntegrals.Section66

open LMLF.Blueprint.ExponentialIntegrals.Section62

/-! DLMF §6.6.  The sums below use zero-based `n + 1` reindexes for the
positive-indexed series in E1, E2, E4, and E6; this keeps the declarations in
the standard `ℕ`-indexed `tsum` form while retaining their source signs. -/

/-- DLMF 6.6.E1: the positive-real exponential-integral series term. -/
def eiSeriesTerm (x : ℝ) (n : ℕ) : ℝ :=
  x ^ (n + 1) / (Nat.factorial (n + 1) * (n + 1))

/-- DLMF 6.6.E2/E3: the complex exponential-integral series term. -/
def e1SeriesTerm (z : ℂ) (n : ℕ) : ℂ :=
  ((-1 : ℂ) ^ (n + 1) * z ^ (n + 1)) /
    ((Nat.factorial (n + 1) : ℂ) * (n + 1))

/-- DLMF 6.6.E3: the digamma-weighted exponential-integral series term. -/
def e1DigammaSeriesTerm (z : ℂ) (n : ℕ) : ℂ :=
  z ^ n / (Nat.factorial n : ℂ) * Complex.digamma (n + 1)

/-- DLMF 6.6.E4: the complementary exponential-integral series term. -/
def einSeriesTerm (z : ℂ) (n : ℕ) : ℂ :=
  ((-1 : ℂ) ^ n * z ^ (n + 1)) /
    ((Nat.factorial (n + 1) : ℂ) * (n + 1))

/-- DLMF 6.6.E5: the sine-integral series term. -/
def siSeriesTerm (z : ℂ) (n : ℕ) : ℂ :=
  (-1 : ℂ) ^ n * z ^ (2 * n + 1) /
    ((Nat.factorial (2 * n + 1) : ℂ) * (2 * n + 1))

/-- DLMF 6.6.E6: the cosine-integral series term. -/
def ciSeriesTerm (z : ℂ) (n : ℕ) : ℂ :=
  (-1 : ℂ) ^ (n + 1) * z ^ (2 * (n + 1)) /
    ((Nat.factorial (2 * (n + 1)) : ℂ) * (2 * (n + 1)))

-- ANCHOR: dlmf_6_6_1
/-- DLMF 6.6.E1: `Ei(x)` power series for `x > 0`. -/
theorem dlmf_6_6_1 (x : ℝ) (hx : 0 < x) :
    realEi x = (Real.eulerMascheroniConstant : ℂ) + Real.log x +
      ∑' n : ℕ, x ^ (n + 1) / (Nat.factorial (n + 1) * (n + 1)) :=
-- ANCHOR_END: dlmf_6_6_1
by sorry

-- ANCHOR: dlmf_6_6_2
/-- DLMF 6.6.E2: principal `E₁(z)` power series. -/
theorem dlmf_6_6_2 (z : ℂ) (hz : principalCutDomain z) :
    principalE1 z = -(Real.eulerMascheroniConstant : ℂ) - Complex.log z -
      ∑' n : ℕ, ((-1 : ℂ) ^ (n + 1) * z ^ (n + 1)) /
        ((Nat.factorial (n + 1) : ℂ) * (n + 1)) :=
-- ANCHOR_END: dlmf_6_6_2
by sorry

-- ANCHOR: dlmf_6_6_3
/-- DLMF 6.6.E3: digamma-weighted `E₁(z)` power series. -/
theorem dlmf_6_6_3 (z : ℂ) (hz : principalCutDomain z) :
    principalE1 z = -Complex.log z + Complex.exp (-z) *
      ∑' n : ℕ, z ^ n / (Nat.factorial n : ℂ) * Complex.digamma (n + 1) :=
-- ANCHOR_END: dlmf_6_6_3
by sorry

-- ANCHOR: dlmf_6_6_4
/-- DLMF 6.6.E4: complementary exponential-integral power series. -/
theorem dlmf_6_6_4 (z : ℂ) :
    principalEin z = ∑' n : ℕ, ((-1 : ℂ) ^ n * z ^ (n + 1)) /
      ((Nat.factorial (n + 1) : ℂ) * (n + 1)) :=
-- ANCHOR_END: dlmf_6_6_4
by sorry

-- ANCHOR: dlmf_6_6_5
/-- DLMF 6.6.E5: sine-integral power series. -/
theorem dlmf_6_6_5 (z : ℂ) :
    principalSi z = ∑' n : ℕ, (-1 : ℂ) ^ n * z ^ (2 * n + 1) /
      ((Nat.factorial (2 * n + 1) : ℂ) * (2 * n + 1)) :=
-- ANCHOR_END: dlmf_6_6_5
by sorry

-- ANCHOR: dlmf_6_6_6
/-- DLMF 6.6.E6: cosine-integral power series. -/
theorem dlmf_6_6_6 (z : ℂ) (hz : principalCutDomain z) :
    principalCi z = (Real.eulerMascheroniConstant : ℂ) + Complex.log z +
      ∑' n : ℕ, (-1 : ℂ) ^ (n + 1) * z ^ (2 * (n + 1)) /
        ((Nat.factorial (2 * (n + 1)) : ℂ) * (2 * (n + 1))) :=
-- ANCHOR_END: dlmf_6_6_6
by sorry

/- DLMF 6.6 prose: every displayed power series converges for finite
   arguments.  Each fact is exposed independently so callers do not need an
   irrelevant argument for another series. -/

-- ANCHOR: eiSeriesTerm_summable
/-- DLMF 6.6 prose: the E1 series is summable for every finite real argument. -/
theorem eiSeriesTerm_summable (x : ℝ) :
    Summable (eiSeriesTerm x) :=
-- ANCHOR_END: eiSeriesTerm_summable
by sorry

-- ANCHOR: e1SeriesTerm_summable
/-- DLMF 6.6 prose: the E2 series is summable for every finite complex argument. -/
theorem e1SeriesTerm_summable (z : ℂ) :
    Summable (e1SeriesTerm z) :=
-- ANCHOR_END: e1SeriesTerm_summable
by sorry

-- ANCHOR: e1DigammaSeriesTerm_summable
/-- DLMF 6.6 prose: the E3 digamma series is summable for every finite complex argument. -/
theorem e1DigammaSeriesTerm_summable (z : ℂ) :
    Summable (e1DigammaSeriesTerm z) :=
-- ANCHOR_END: e1DigammaSeriesTerm_summable
by sorry

-- ANCHOR: einSeriesTerm_summable
/-- DLMF 6.6 prose: the E4 series is summable for every finite complex argument. -/
theorem einSeriesTerm_summable (z : ℂ) :
    Summable (einSeriesTerm z) :=
-- ANCHOR_END: einSeriesTerm_summable
by sorry

-- ANCHOR: siSeriesTerm_summable
/-- DLMF 6.6 prose: the E5 series is summable for every finite complex argument. -/
theorem siSeriesTerm_summable (z : ℂ) :
    Summable (siSeriesTerm z) :=
-- ANCHOR_END: siSeriesTerm_summable
by sorry

-- ANCHOR: ciSeriesTerm_summable
/-- DLMF 6.6 prose: the E6 series is summable for every finite complex argument. -/
theorem ciSeriesTerm_summable (z : ℂ) :
    Summable (ciSeriesTerm z) :=
-- ANCHOR_END: ciSeriesTerm_summable
by sorry

end LMLF.Blueprint.ExponentialIntegrals.Section66
