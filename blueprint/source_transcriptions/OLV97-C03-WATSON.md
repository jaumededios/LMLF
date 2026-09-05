# OLV97-C03-WATSON - mathematical transcription

**Status:** first collation; independent source review pending  
**Edition:** F. W. J. Olver, *Asymptotics and Special Functions*, corrected
A K Peters reprint, 1997, ISBN 1-56881-069-5  
**Source snapshot:** `SRC-OLV-1997-USER-PDF-20260905`  
**Source location:** Chapter 3, section 3, Theorem 3.1, printed pp. 71-72;
PDF pages 84-85  
**Supporting conventions:** Chapter 1 section 7, printed pp. 16-17; Chapter 3
section 2.1, printed pp. 67-68

This file records mathematical content and source conventions in new prose. It
does not reproduce the book's surrounding exposition or page images.

## Printed theorem, normalized transcription

Fix positive real constants \(\lambda\) and \(\mu\). Let \(q(t)\) be a
function of the positive real variable \(t\), with coefficients \(a_s\), such
that

\[
 q(t) \sim \sum_{s=0}^{\infty}
   a_s t^{(s+\lambda-\mu)/\mu}
 \qquad (t\to0^+). \tag{3.02}
\]

Then

\[
 \int_0^\infty e^{-xt}q(t)\,dt
 \sim
 \sum_{s=0}^{\infty}
   \Gamma\!\left(\frac{s+\lambda}{\mu}\right)
   \frac{a_s}{x^{(s+\lambda)/\mu}}
 \qquad (x\to+\infty), \tag{3.03}
\]

provided the improper integral on the left converges over its full range for
all sufficiently large \(x\).

The source permits, subject to convergence, finitely many discontinuities and
infinities in the integration range, including at \(t=0\). It states that the
local expansion ensures convergence at \(0\).

## Exact finite-order meaning used by the proof

For each \(n\in\mathbb N\), define

\[
 \beta_n:=\frac{n+\lambda}{\mu}>0,
 \qquad
 \phi_n(t):=q(t)-\sum_{s=0}^{n-1}
   a_s t^{(s+\lambda-\mu)/\mu}. \tag{3.04}
\]

The empty sum is zero when \(n=0\). Olver's asymptotic-expansion convention,
together with the next coefficient in the full expansion, gives

\[
 \phi_n(t)=O(t^{\beta_n-1})\qquad(t\to0^+).
\]

Equivalently, for each fixed \(n\), there are positive \(k_n,K_n\) such that

\[
 \lvert\phi_n(t)\rvert\le K_n t^{\beta_n-1}
 \qquad(0<t\le k_n).
\]

Termwise evaluation of the finite model moments gives the exact remainder
identity

\[
 \int_0^\infty e^{-xt}q(t)\,dt
 =
 \sum_{s=0}^{n-1}
   \Gamma\!\left(\frac{s+\lambda}{\mu}\right)
   \frac{a_s}{x^{(s+\lambda)/\mu}}
 + \int_0^\infty e^{-xt}\phi_n(t)\,dt. \tag{3.05}
\]

## Quantitative inequalities appearing in the source proof

The local interval satisfies

\[
 \left\lvert\int_0^{k_n}e^{-xt}\phi_n(t)\,dt\right\rvert
 \le
 K_n\int_0^{k_n}e^{-xt}t^{\beta_n-1}\,dt
 < K_n\Gamma(\beta_n)x^{-\beta_n}. \tag{3.06}
\]

Choose one real \(X\) for which
\(\int_0^\infty e^{-Xt}\phi_n(t)\,dt\) converges, and put

\[
 \Phi_n(t):=\int_{k_n}^{t}e^{-Xv}\phi_n(v)\,dv.
\]

Convergence makes \(\Phi_n\) continuous and bounded on \([k_n,\infty)\).
Let

\[
 L_n:=\sup_{t\ge k_n}\lvert\Phi_n(t)\rvert.
\]

For \(x>X\), integration by parts gives

\[
 \int_{k_n}^{\infty}e^{-xt}\phi_n(t)\,dt
 = (x-X)\int_{k_n}^{\infty}e^{-(x-X)t}\Phi_n(t)\,dt, \tag{3.07}
\]

and hence

\[
 \left\lvert\int_{k_n}^{\infty}e^{-xt}\phi_n(t)\,dt\right\rvert
 \le L_ne^{-(x-X)k_n}. \tag{3.08}
\]

Combining the two pieces yields the proof-level finite estimate

\[
 \left\lvert
 \int_0^\infty e^{-xt}q(t)\,dt
 -\sum_{s=0}^{n-1}
   \Gamma\!\left(\frac{s+\lambda}{\mu}\right)
   \frac{a_s}{x^{(s+\lambda)/\mu}}
 \right\rvert
 < K_n\Gamma(\beta_n)x^{-\beta_n}
   +L_ne^{-(x-X)k_n}. \tag{W-local-tail}
\]

For fixed \(n,\lambda,\mu,k_n,K_n,X,L_n\), the exponential term is
\(o(x^{-\beta_n})\). Therefore the remainder is
\(O(x^{-\beta_n})\), which is the finite-order condition for (3.03).

## Source convention reconciliation

- Chapter 1 section 7 defines an \(n\)-term remainder using the first \(n\)
  terms, indexed \(0,\ldots,n-1\), and requires an \(O\)-bound at the next
  scale for each fixed \(n\).
- The exponents in (3.02) are \((s+\lambda-\mu)/\mu\); the integrated exponents
  are \((s+\lambda)/\mu\). This shift by one is part of the theorem.
- \(n=0\) is meaningful: the finite sum is empty and the local exponent is
  \(\lambda/\mu-1>-1\).
- \(x\) is the positive large parameter; \(q\), \(a_s\), \(\lambda\), and
  \(\mu\) are fixed as \(x\to+\infty\).
- The integral is an improper Riemann integral in the book's convention. The
  theorem does not assume absolute convergence.
- The theorem does not state uniformity in \(n\), \(\lambda\), \(\mu\), or any
  auxiliary parameter.

## Ambiguities deliberately left for review

1. The statement names \(t\) as real but does not explicitly say whether
   \(q(t)\) and \(a_s\) are real or complex. The proof works with absolute
   values and appears compatible with complex values, but this should be
   classified as interpretation or generalization, not silently assumed.
2. A Lean statement matching conditional improper convergence needs a
   limit-of-finite-interval-integrals interface. Mathlib's totalized Bochner
   integral is not by itself source-equivalent.
3. Interior infinities require an explicit convention for subdivision and
   convergence at every singular point. A first bounded packet may expose a
   locally integrable formulation and record whether that is equivalent to or
   stronger than the printed convention.
4. Equation (W-local-tail) is extracted from the printed proof but is not
   displayed as a single theorem in the source. It is a quantitative
   strengthening/repackaging, whereas equations (3.02)-(3.08) are direct source
   content.

## Excluded nearby source material

Chapter 3 section 9.1 gives a different global-exponential-majorant error bound.
It has its own transcription because it assumes more than Theorem 3.1 and must
not be used to hide a stronger hypothesis in the source-recovery route.
