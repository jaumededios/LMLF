# OLV97-C03-WATSON-BOUNDS - mathematical transcription

**Status:** first collation; independent source review pending
**Edition:** F. W. J. Olver, *Asymptotics and Special Functions*, corrected
A K Peters reprint, 1997, ISBN 1-56881-069-5
**Source snapshot:** `SRC-OLV-1997-USER-PDF-20260905`
**Source location:** Chapter 3, section 9.1-9.2, printed pp. 89-90; PDF pages
102-103
**Depends on:** Theorem 3.1 and its remainder \(\phi_n\), equation (3.04)

This file records only the mathematical content needed to distinguish the
source's global bounds from the local-tail proof of Theorem 3.1.

## Section 9.1 global majorant

Let

\[
 \phi_n(t)=q(t)-\sum_{s=0}^{n-1}
 a_s t^{(s+\lambda-\mu)/\mu},
 \qquad \beta_n=\frac{n+\lambda}{\mu}.
\]

If a real number \(\sigma_n\) satisfies

\[
 \lvert\phi_n(t)\rvert
 \le \lvert a_n\rvert t^{\beta_n-1}e^{\sigma_nt}
 \qquad(0<t<\infty), \tag{9.01}
\]

then, for \(x>\max(\sigma_n,0)\),

\[
 \left\lvert\int_0^\infty e^{-xt}\phi_n(t)\,dt\right\rvert
 \le
 \Gamma(\beta_n)
 \frac{\lvert a_n\rvert}{(x-\sigma_n)^{\beta_n}}. \tag{9.02}
\]

When the logarithmic quotient is meaningful, the least admissible exponent is
described by

\[
 \sigma_n=\sup_{t>0}\psi_n(t), \tag{9.03}
\]

where

\[
 \psi_n(t)=\frac1t\log\left\lvert
 \frac{\phi_n(t)}{a_nt^{\beta_n-1}}
 \right\rvert.
\]

This construction can fail when \(a_n=0\) or when the supremum is infinite.
The source analyzes the small-\(t\) obstruction, especially when \(\mu>1\).

## Section 9.2 relaxed factor

For a supplied \(M>1\), replace (9.01) with

\[
 \lvert\phi_n(t)\rvert
 \le M\lvert a_n\rvert t^{\beta_n-1}e^{\widehat\sigma_nt}.
\]

Then

\[
 \left\lvert\int_0^\infty e^{-xt}\phi_n(t)\,dt\right\rvert
 \le
 \Gamma(\beta_n)
 \frac{M\lvert a_n\rvert}{(x-\widehat\sigma_n)^{\beta_n}}
 \qquad(x>\max(\widehat\sigma_n,0)), \tag{9.04}
\]

with candidate least exponent

\[
 \widehat\sigma_n=\sup_{t>0}\frac1t\log\left\lvert
 \frac{\phi_n(t)}{Ma_nt^{\beta_n-1}}
 \right\rvert. \tag{9.05}
\]

One alternate choice uses

\[
 M_n=\sup_{t>0}\left\lvert
 \frac{\phi_n(t)}{a_nt^{\beta_n-1}}
 \right\rvert,
\]

when this supremum is finite, giving \(\widehat\sigma_n=0\).

## Classification notes

- Equations (9.01)-(9.05) are direct source formulas, not consequences of the
  hypotheses of Theorem 3.1 alone.
- The global majorant is stronger than the local asymptotic hypothesis plus
  eventual convergence used in Theorem 3.1.
- A reusable Lean lemma should accept the global majorant and the constants
  \(M,\sigma\) as explicit inputs. Computing a best supremum is a separate
  theorem and requires nonzero-denominator and extended-real conventions.
- The bound is a direct Gamma-moment estimate after replacing
  \(e^{-xt}e^{\sigma t}\) by \(e^{-(x-\sigma)t}\).
- Section 9.3 introduces sign-dependent refinements. Those formulas require a
  real coefficient/sign convention and are outside this first transcription.

## Open formalization points

1. Decide whether the first packet covers only the supplied-majorant
   implication (9.01) -> (9.02), leaving the best-\(\sigma_n\) formula for a
   later packet.
2. Separate the \(a_n=0\) case rather than relying on a totalized logarithmic
   quotient.
3. Preserve the strict domain \(x>\max(\sigma_n,0)\), which supplies both
   \(x>0\) and \(x-\sigma_n>0\).
4. Record whether complex-valued \(q\) is an intended source interpretation or
   a project generalization. The estimate itself naturally uses a norm.
