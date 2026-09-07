import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Elementary.Section49
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§4.9 Continued Fractions" =>
%%%
tag := "chapter-4-section-9"
%%%

:::dlmfChapter "https://dlmf.nist.gov/4.9"
Source: NIST Digital Library of Mathematical Functions, §4.9.
:::

# §4.9 Continued Fractions
%%%
number := false
%%%

Section 4.9 gives continued fractions for the principal logarithm and exponential.
The finite approximants below are indexed by their depth: depth `d` retains the first
`d+1` numerators and denominators, and the displayed infinite fraction is interpreted
as the limit as `d → ∞`.

:::leanStatement "Lean · finite continued-fraction approximants"
```anchor continuedFractionTail (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
def continuedFractionTail (numerator denominator : ℕ → ℂ) (offset depth : ℕ) : ℂ :=
  match depth with
  | 0 => 0
  | n + 1 => numerator offset /
      (denominator offset + continuedFractionTail numerator denominator (offset + 1) n)
```

```anchor continuedFractionConvergent (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
def continuedFractionConvergent (numerator denominator : ℕ → ℂ) (depth : ℕ) : ℂ :=
  continuedFractionTail numerator denominator 0 (depth + 1)
```
:::

::::dlmfEntry "4.9.1" "https://dlmf.nist.gov/4.9.E1"
$$`\log(1+z)=\cfrac{z}{1+\cfrac{z}{2+\cfrac{z}{3+\cfrac{4z}{4+\cfrac{4z}{5+\cfrac{9z}{6+\cdots}}}}}}.`
The numerator sequence is `z,z,z,4z,4z,9z,9z,…`, while the denominators are
`1,2,3,4,…`. Here `log` is the principal logarithm. The source condition
`|ph(1+z)| < π` selects its branch; the explicit nonzero hypothesis below makes the
argument of the logarithm visible in the formal statement.

:::leanStatement "Lean · principal logarithm continued fraction"
```anchor logarithmFractionNumerator (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
def logarithmFractionNumerator (z : ℂ) : ℕ → ℂ
  | 0 => z
  | n + 1 => ((((n + 2) / 2 : ℕ) : ℂ) ^ 2) * z
```

```anchor logarithmFractionDenominator (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
def logarithmFractionDenominator : ℕ → ℂ := fun n => (n + 1 : ℕ)
```

```anchor dlmf_4_9_1 (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
theorem dlmf_4_9_1 {z : ℂ} (hz : 1 + z ≠ 0)
    (hphase : |Complex.arg (1 + z)| < Real.pi) :
    Tendsto
        (fun depth =>
          continuedFractionConvergent (logarithmFractionNumerator z)
            logarithmFractionDenominator depth)
        atTop (nhds (Complex.log (1 + z))) := by
  sorry
```
:::
::::

::::dlmfEntry "4.9.2" "https://dlmf.nist.gov/4.9.E2"
$$`\log\!\left(\frac{1+z}{1-z}\right)=\cfrac{2z}{1-\cfrac{z^2}{3-\cfrac{4z^2}{5-\cfrac{9z^2}{7-\cdots}}}}.`
The denominator sequence is `1,3,5,7,…`; the negative signs belong to the successive
square numerators. The principal branches are used away from the real cuts
`(-∞,-1]` and `[1,∞)`, which is expressed below by the corresponding condition on `z`.

:::leanStatement "Lean · symmetric logarithm continued fraction"
```anchor symmetricLogFractionNumerator (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
def symmetricLogFractionNumerator (z : ℂ) : ℕ → ℂ
  | 0 => 2 * z
  | n + 1 => -((((n + 1 : ℕ) : ℂ) ^ 2) * z ^ 2)
```

```anchor symmetricLogFractionDenominator (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
def symmetricLogFractionDenominator : ℕ → ℂ := fun n => (2 * n + 1 : ℕ)
```

```anchor dlmf_4_9_2 (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
theorem dlmf_4_9_2 {z : ℂ}
    (hz : ¬(z.im = 0 ∧ (z.re ≤ -1 ∨ 1 ≤ z.re))) :
    Tendsto
        (fun depth =>
          continuedFractionConvergent (symmetricLogFractionNumerator z)
            symmetricLogFractionDenominator depth)
        atTop (nhds (Complex.log ((1 + z) / (1 - z)))) := by
  sorry
```
:::
::::

::::dlmfEntry "4.9.3" "https://dlmf.nist.gov/4.9.E3"
$$`e^z=\cfrac{1}{1-\cfrac{z}{1+\cfrac{z}{2-\cfrac{z}{3+\cfrac{z}{2-\cdots}}}}}.`
$$`e^z=1+\cfrac{z}{1-\cfrac{z}{2+\cfrac{z}{3-\cfrac{z}{2+\cdots}}}}.`
$$`e^z=1+\cfrac{z}{1-z/2+\cfrac{z^2/(4\cdot3)}{1+\cfrac{z^2/(4\cdot15)}{1+\cdots}}}.`
DLMF records all three forms for complex `z`. In the first fraction the initial
denominators are `1,1,2,3,2,5,2,…`; in the second they are
`1,2,3,2,5,2,…`. Their numerator signs alternate as displayed. In the third form
the first denominator is `1-z/2`, every later denominator is `1`, and the successive
noninitial numerators are `z²/(4(4n²−1))`.

:::leanStatement "Lean · exponential continued fractions"
```anchor exponentialFractionNumeratorOne (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
def exponentialFractionNumeratorOne (z : ℂ) : ℕ → ℂ
  | 0 => 1
  | n + 1 => (-1 : ℂ) ^ (n + 1) * z
```

```anchor exponentialFractionDenominatorOne (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
def exponentialFractionDenominatorOne : ℕ → ℂ
  | 0 => 1
  | n + 1 => if (n + 1) % 2 = 0 then 2 else n + 1
```

```anchor exponentialFractionNumeratorTwo (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
def exponentialFractionNumeratorTwo (z : ℂ) : ℕ → ℂ := fun n => (-1 : ℂ) ^ n * z
```

```anchor exponentialFractionDenominatorTwo (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
def exponentialFractionDenominatorTwo : ℕ → ℂ
  | 0 => 1
  | n + 1 => if (n + 1) % 2 = 1 then 2 else n + 2
```

```anchor exponentialFractionNumeratorThree (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
def exponentialFractionNumeratorThree (z : ℂ) : ℕ → ℂ
  | 0 => z
  | n + 1 => z ^ 2 / ((4 * (4 * (n + 1) ^ 2 - 1) : ℕ) : ℂ)
```

```anchor exponentialFractionDenominatorThree (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
def exponentialFractionDenominatorThree (z : ℂ) : ℕ → ℂ
  | 0 => 1 - z / 2
  | _ + 1 => 1
```

```anchor dlmf_4_9_3 (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
theorem dlmf_4_9_3 (z : ℂ) :
    Tendsto
        (fun depth =>
          continuedFractionConvergent (exponentialFractionNumeratorOne z)
            exponentialFractionDenominatorOne depth)
        atTop (nhds (Complex.exp z)) ∧
      Tendsto
        (fun depth =>
          1 + continuedFractionConvergent (exponentialFractionNumeratorTwo z)
            exponentialFractionDenominatorTwo depth)
        atTop (nhds (Complex.exp z)) ∧
      Tendsto
        (fun depth =>
          1 + continuedFractionConvergent (exponentialFractionNumeratorThree z)
            (exponentialFractionDenominatorThree z) depth)
        atTop (nhds (Complex.exp z)) := by
  sorry
```
:::
::::

::::dlmfEntry "4.9.4" "https://dlmf.nist.gov/4.9.E4"
$$`e^z-e_{n-1}(z)=\frac{z^n}{n!}-\cfrac{n!z}{n+1+\cfrac{z}{n+2-\cfrac{(n+1)z}{n+3+\cfrac{2z}{n+4-\cfrac{(n+2)z}{n+5+\cdots}}}}}.`
Write `e_n(z) = ∑_{k=0}^n z^k/k!`. For a positive integer `n`, the alternating
signs and the coefficients in the numerator sequence are part of the displayed
continued fraction. The formal statement represents this positive integer by
`n : ℕ` together with `1 ≤ n`.

:::leanStatement "Lean · exponential remainder continued fraction"
```anchor exponentialExpansion (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
def exponentialExpansion (n : ℕ) (z : ℂ) : ℂ :=
  ∑ k ∈ Finset.range (n + 1), z ^ k / (k.factorial : ℂ)
```

```anchor exponentialRemainderNumerator (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
def exponentialRemainderNumerator (n : ℕ) (z : ℂ) : ℕ → ℂ
  | 0 => (n.factorial : ℂ) * z
  | k + 1 =>
      (-1 : ℂ) ^ k *
        (if k % 2 = 0 then (((k / 2 + 1 : ℕ) : ℂ))
        else (((n + (k + 1) / 2 : ℕ) : ℂ))) * z
```

```anchor exponentialRemainderDenominator (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
def exponentialRemainderDenominator (n : ℕ) : ℕ → ℂ :=
  fun k => (n + k + 1 : ℕ)
```

```anchor dlmf_4_9_4 (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
theorem dlmf_4_9_4 {n : ℕ} (hn : 1 ≤ n) (z : ℂ) :
    Tendsto
        (fun depth =>
          z ^ n / (n.factorial : ℂ) -
            continuedFractionConvergent
              (exponentialRemainderNumerator n z)
              (exponentialRemainderDenominator n) depth)
        atTop (nhds (Complex.exp z - exponentialExpansion (n - 1) z)) := by
  sorry
```
:::
::::

::::dlmfEntry "4.9.5" "https://dlmf.nist.gov/4.9.E5"
$$`e_n(z)=\sum_{k=0}^{n}\frac{z^k}{k!}.`
The finite sum uses exactly the indices from `0` through `n`; in the formal
expression this is `Finset.range (n + 1)`.

:::leanStatement "Lean · finite exponential expansion"
```anchor dlmf_4_9_5 (module := LMLF.Blueprint.Elementary.Section49) -showProofStates
theorem dlmf_4_9_5 (n : ℕ) (z : ℂ) :
    exponentialExpansion n z =
      ∑ k ∈ Finset.range (n + 1), z ^ k / (k.factorial : ℂ) := by
  sorry
```
:::
::::
