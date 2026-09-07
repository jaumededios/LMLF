import VersoManual
import Verso.Code.External
import LMLF.Blueprint.ExponentialIntegrals.Section616
import LMLFManual.Components

open Verso.Genre Manual Verso.Code.External LMLFManual
open LMLF.Blueprint.ExponentialIntegrals.Section616
set_option verso.exampleProject "."

#doc (Manual) "§6.16 Mathematical Applications" =>
%%%
tag := "chapter-6-section-16"
%%%
:::dlmfChapter "https://dlmf.nist.gov/6.16"
Source: NIST Digital Library of Mathematical Functions, §6.16, Mathematical Applications.
:::

# §6.16 Mathematical Applications
%%%
number := false
%%%

This section applies sine-integral and logarithmic-integral methods to two
classical topics: the Gibbs phenomenon and the relation between the
logarithmic integral and prime counting. All limits and order estimates retain
the real domains and hypotheses stated by the DLMF.

## The Gibbs phenomenon
%%%
number := false
%%%

The odd-harmonic Fourier series is stated on the actual source domain
`−π < x < π`: its sum is `π/4` for `0 < x < π`, is zero at `x=0`, and is
`−π/4` for `−π < x < 0`.  The Lean helper `sawtoothValueOnDomain` is the corresponding
domain-indexed piece, while the theorem keeps the source interval explicit;
there is no exported value for arguments outside this interval.

::::dlmfEntry "§6.16(i) source note" "https://dlmf.nist.gov/6.16#i.info"
The source note cites Temme (1996b, pp. 181–182), correcting the numerical
value `1.089490…` on p. 182 to `1.1789…`, records Gibbs's letter to *Nature*
59 (1899, p. 606), and notes that Figure 6.16.1 was produced at NIST.
::::

::::dlmfEntry "6.16.1" "https://dlmf.nist.gov/6.16.E1"
$$`\sin x+\frac{1}{3}\sin(3x)+\cdots=\begin{cases}\frac{\pi}{4},&0<x<\pi,\\0,&x=0,\\-\frac{\pi}{4},&-\pi<x<0.\end{cases}`$$
:::leanStatement "Sawtooth value on the source domain"
```anchor sawtoothValueOnDomain (module := LMLF.Blueprint.ExponentialIntegrals.Section616)
def sawtoothValueOnDomain (x : ℝ) (hx : -Real.pi < x ∧ x < Real.pi) : ℝ :=
  if 0 < x then Real.pi / 4 else if x = 0 then 0 else -Real.pi / 4
```
:::
:::leanStatement "Odd-harmonic Fourier series"
```anchor dlmf_6_16_1 (module := LMLF.Blueprint.ExponentialIntegrals.Section616)
theorem dlmf_6_16_1 {x : ℝ} (hx : -Real.pi < x) (hx' : x < Real.pi) :
    HasSum (fun k : ℕ => gibbsTerm k x)
      (sawtoothValueOnDomain x ⟨hx, hx'⟩)
```
:::
::::

The nth partial sum has both a finite Fourier representation and an integral
representation.  Its sine-integral term is the canonical real restriction of
the §6.2 principal `principalSi`, and `sineRemainder n x` is the named
correction term used by E3 and E4.

::::dlmfEntry "6.16.2" "https://dlmf.nist.gov/6.16.E2"
$$`S_n(x)=\sum_{k=0}^{n-1}\frac{\sin((2k+1)x)}{2k+1}=\frac12\int_0^x\frac{\sin(2nt)}{\sin t}dt=\frac12\operatorname{Si}(2nx)+R_n(x)`$$
:::leanStatement "Partial sum and sine-integral decomposition"
```anchor dlmf_6_16_2 (module := LMLF.Blueprint.ExponentialIntegrals.Section616)
theorem dlmf_6_16_2 (n : ℕ) (x : ℝ) :
    sinePartial n x =
      (1/2 : ℝ) * ∫ t in (0 : ℝ)..x,
        Real.sin (2 * (n : ℝ) * t) / Real.sin t ∧
      sinePartial n x =
        (1/2 : ℝ) * (principalSi ((2 * (n : ℝ) * x : ℝ) : ℂ)).re +
          sineRemainder n x
```
:::
::::

::::dlmfEntry "6.16.3" "https://dlmf.nist.gov/6.16.E3"
$$`R_n(x)=\frac12\int_0^x(\csc t-t^{-1})\sin(2nt)dt`$$
:::leanStatement "The remainder is defined by the displayed integral"
```anchor sineRemainder (module := LMLF.Blueprint.ExponentialIntegrals.Section616)
def sineRemainder (n : ℕ) (x : ℝ) : ℝ :=
  (1/2 : ℝ) * ∫ t in (0 : ℝ)..x,
    (1 / Real.sin t - 1 / t) * Real.sin (2*n*t)
```
:::
::::

::::dlmfEntry "§6.16(i) uniform remainder and limits" "https://dlmf.nist.gov/6.16#i.p1"
Integration by parts gives the source's `R_n(x)=O(n⁻¹)` estimate uniformly
for `x ∈ [−π,π]`.  The Lean disclosure fixes a source-valid `x` in that
interval and applies the estimate to the canonical `sineRemainder`; for fixed
`x`, the partial sums converge to the three piecewise values above, as in
[§6.2.14](https://dlmf.nist.gov/6.2.E14).  The convergence is not uniform near
the jump.
::::

::::dlmfEntry "6.16.4" "https://dlmf.nist.gov/6.16.E4"
$$`R_n(x)=O(n^{-1}),\quad n\to\infty,\quad -\pi\le x\le\pi`$$
:::leanStatement "Uniform remainder order"
```anchor dlmf_6_16_4 (module := LMLF.Blueprint.ExponentialIntegrals.Section616)
theorem dlmf_6_16_4 (x : ℝ) (hx : x ∈ Set.Icc (-Real.pi) Real.pi) :
    (fun n : ℕ => sineRemainder n x) =O[atTop] (fun n => (n : ℝ)⁻¹)
```
:::
::::

::::dlmfEntry "§6.16(i) Gibbs overshoot" "https://dlmf.nist.gov/6.16#i.p2"
The first maximum of `Si(x)/2` for positive x occurs at `x=π` and is
`1.1789…` times `π/4`, the approximately 18% overshoot.  Scaling
`x=π/(2n)` gives that overshoot asymptotically, while `x=π/n` gives an
undershoot of approximately 10%, with analogous scalings thereafter.  This
source compares the maximum with [Figure 6.3.2](https://dlmf.nist.gov/6.3.F2)
and the scalings with [Figure 6.16.1](https://dlmf.nist.gov/6.16.F1).
::::

::::dlmfEntry "§6.16(i) Gibbs phenomenon" "https://dlmf.nist.gov/6.16#i.p3"
This nonuniformity is the Gibbs phenomenon for Fourier series of piecewise
continuous functions; the source refers to Carslaw (1930) for additional
graphs and information.
::::

::::dlmfEntry "6.16.F1" "https://dlmf.nist.gov/6.16.F1"
Figure 6.16.1: graph of `S_n(x)` for `n=250`, `−0.1 ≤ x ≤ 0.1`.
::::

## Number-theoretic significance of li(x)
%%%
number := false
%%%

:::leanStatement "Canonical real logarithmic integral"
```anchor realLogarithmicIntegral (module := LMLF.Blueprint.ExponentialIntegrals.Section616)
def realLogarithmicIntegral (x : ℝ) : ℝ :=
  (realEi (Real.log x)).re
```
:::

:::leanStatement "Principal-value characterization of li"
```anchor realLogarithmicIntegral_pv (module := LMLF.Blueprint.ExponentialIntegrals.Section616)
theorem realLogarithmicIntegral_pv (x : ℝ) (hx : 1 < x) :
    hasLogarithmicIntegralPV x (realLogarithmicIntegral x)
```
:::

::::dlmfEntry "§6.16(ii) source note" "https://dlmf.nist.gov/6.16#ii.info"
The source note records that Figure 6.16.2 was produced at NIST.
::::

::::dlmfEntry "§6.16(ii) number-theoretic statement" "https://dlmf.nist.gov/6.16#ii.p1"
Assuming the named Mathlib proposition `RiemannHypothesis` for the nonreal
zeros of ζ, the canonical map `realLogarithmicIntegral` supplies the
principal-value logarithmic integral through its §6.2 characterization.  Mathlib's
`primeCountingReal x = Nat.primeCounting ⌊x⌋₊` counts primes not exceeding x;
this is the real-variable specialization appropriate to the source's
`x → ∞` statement.  The source points to
[§25.10(i)](https://dlmf.nist.gov/25.10#i), [§27.12](https://dlmf.nist.gov/27.12),
[Figure 6.16.2](https://dlmf.nist.gov/6.16.F2), and Bays–Hudson (2000).
::::

::::dlmfEntry "6.16.5" "https://dlmf.nist.gov/6.16.E5"
$$`\operatorname{li}(x)-\pi(x)=O(\sqrt{x}\ln x),\quad x\to\infty`$$
:::leanStatement "Prime-counting approximation under RH"
```anchor dlmf_6_16_5 (module := LMLF.Blueprint.ExponentialIntegrals.Section616)
theorem dlmf_6_16_5 (hRH : RiemannHypothesis) :
    (fun x : ℝ => realLogarithmicIntegral x - primeCountingReal x) =O[atTop]
      (fun x => Real.sqrt x * Real.log x)
```
:::
::::

Figure 6.16.2 compares `li(x)` with the step values of `π(x)` for
`x=10,20,…,1000`; it is an NIST-produced graph, as noted by the source.

::::dlmfEntry "6.16.F2" "https://dlmf.nist.gov/6.16.F2"
Figure 6.16.2: logarithmic integral with vertical bars marking prime counts.
::::

end LMLFManual.Chapter6
