# OLV97-C11-AIRY-REAL-AUX - planning mathematical transcription

**Status:** planning-only first collation; independent review pending
**Edition:** F. W. J. Olver, *Asymptotics and Special Functions*, corrected
A K Peters reprint, 1997, ISBN 1-56881-069-5
**Source snapshot:** SRC-OLV-1997-USER-PDF-20260905
**Snapshot SHA-256:**
08e1844d29a5ad21f89b9b600249ce18ac1665a5845be2d4e4219a3ededdc909
**Source location:** Chapter 11, sections 1.1-1.4 and 2.1-2.4, printed
pp. 392-397; PDF pages 405-410; equations (1.01)-(1.19) and (2.01)-(2.15)

This is a formula-level transcription in new prose. It contains no scan,
page image, extracted page text, graph, or numerical table. It is not a
theorem card, does not reconcile any inventory record, and does not authorize
implementation.

## Checked page map

| Printed page | PDF page | Located material |
| --- | ---: | --- |
| 392 | 405 | section 1.1; equations (1.01)-(1.09); coefficient definitions |
| 393 | 406 | sections 1.2-1.3; equations (1.10)-(1.19); graph begins |
| 394 | 407 | sections 1.3-1.4; error statements; section 2.1 and (2.01) begin |
| 395 | 408 | equations (2.02)-(2.07); definition and numerical approximation of \(c\) |
| 396 | 409 | equations (2.08)-(2.12); numerical table begins |
| 397 | 410 | table continuation; section 2.4; equations (2.13)-(2.15); exercises 2.1-2.2 |

## Real Airy equation and the Ai normalization

The comparison equation for a real independent variable is

\[
 \frac{d^2w}{dx^2}=xw. \tag{1.01}
\]

One solution is the real Airy integral

\[
 \operatorname{Ai}(x)=\frac1\pi\int_0^\infty
 \cos\!\left(\frac{t^3}{3}+xt\right)\,dt, \tag{1.02}
\]

with initial data

\[
 \operatorname{Ai}(0)=\frac1{3^{2/3}\Gamma(2/3)},
 \qquad
 \operatorname{Ai}'(0)=-\frac1{3^{1/3}\Gamma(1/3)}. \tag{1.03}
\]

For the formulas through (1.18), let \(x>0\) and

\[
 \xi=\frac23x^{3/2},
\]

where \(x^{3/2}\) is the positive real power. The positive-argument Bessel
representations are

\[
 \operatorname{Ai}(x)=\frac1\pi\left(\frac{x}{3}\right)^{1/2}
 K_{1/3}(\xi),
 \qquad
 \operatorname{Ai}'(x)=-\frac{x}{\pi\sqrt3}K_{2/3}(\xi). \tag{1.04}
\]

For a negative Airy argument, still writing \(x>0\),

\[
\begin{aligned}
 \operatorname{Ai}(-x)
 &=\frac{x^{1/2}}{3}
   \{J_{1/3}(\xi)+J_{-1/3}(\xi)\}\\
 &=\left(\frac{x}{3}\right)^{1/2}
   \operatorname{Re}\{e^{\pi i/6}H^{(1)}_{1/3}(\xi)\},
 \tag{1.05}\\
 \operatorname{Ai}'(-x)
 &=\frac{x}{3}\{J_{2/3}(\xi)-J_{-2/3}(\xi)\}\\
 &=\frac{x}{\sqrt3}
   \operatorname{Re}\{e^{-\pi i/6}H^{(1)}_{2/3}(\xi)\}.
 \tag{1.06}
\end{aligned}
\]

## Real asymptotic coefficient system

Set \(u_0=v_0=1\), and, for \(s\geq1\),

\[
 u_s=\frac{(2s+1)(2s+3)(2s+5)\cdots(6s-1)}{216^s s!},
 \qquad
 v_s=-\frac{6s+1}{6s-1}u_s.
\]

As \(x\to+\infty\), the source gives

\[
 \operatorname{Ai}(x)\sim
 \frac{e^{-\xi}}{2\sqrt\pi\,x^{1/4}}
 \sum_{s=0}^\infty(-1)^s\frac{u_s}{\xi^s},
 \qquad
 \operatorname{Ai}'(x)\sim
 -\frac{x^{1/4}e^{-\xi}}{2\sqrt\pi}
 \sum_{s=0}^\infty(-1)^s\frac{v_s}{\xi^s}. \tag{1.07}
\]

The negative-argument expansions are

\[
\begin{aligned}
 \operatorname{Ai}(-x)\sim{}&
 \frac1{\sqrt\pi\,x^{1/4}}
 \left\{
 \cos(\xi-\pi/4)\sum_{s=0}^\infty(-1)^s\frac{u_{2s}}{\xi^{2s}}
 +\sin(\xi-\pi/4)\sum_{s=0}^\infty(-1)^s
   \frac{u_{2s+1}}{\xi^{2s+1}}
 \right\}, \tag{1.08}\\
 \operatorname{Ai}'(-x)\sim{}&
 \frac{x^{1/4}}{\sqrt\pi}
 \left\{
 \sin(\xi-\pi/4)\sum_{s=0}^\infty(-1)^s\frac{v_{2s}}{\xi^{2s}}
 -\cos(\xi-\pi/4)\sum_{s=0}^\infty(-1)^s
   \frac{v_{2s+1}}{\xi^{2s+1}}
 \right\}. \tag{1.09}
\end{aligned}
\]

## The real Bi solution and its normalization

The second standard real solution is specified by

\[
 \operatorname{Bi}(x)=\frac1\pi\int_0^\infty
 \left\{
 e^{-t^3/3+xt}+\sin\!\left(\frac{t^3}{3}+xt\right)
 \right\}\,dt. \tag{1.10}
\]

Its zero data are

\[
 \operatorname{Bi}(0)=\frac1{3^{1/6}\Gamma(2/3)},
 \qquad
 \operatorname{Bi}'(0)=\frac{3^{1/6}}{\Gamma(1/3)}. \tag{1.11}
\]

For \(x>0\),

\[
\begin{aligned}
 \operatorname{Bi}(x)
 &=\left(\frac{x}{3}\right)^{1/2}
   \{I_{1/3}(\xi)+I_{-1/3}(\xi)\}\\
 &=\left(\frac{x}{3}\right)^{1/2}
   \operatorname{Re}\{e^{\pi i/6}H^{(1)}_{1/3}(-i\xi)\},
 \tag{1.12}\\
 \operatorname{Bi}'(x)
 &=\frac{x}{\sqrt3}\{I_{2/3}(\xi)+I_{-2/3}(\xi)\}\\
 &=\frac{x}{\sqrt3}
   \operatorname{Re}\{e^{\pi i/3}H^{(1)}_{2/3}(-i\xi)\}.
 \tag{1.13}
\end{aligned}
\]

The negative-argument versions are

\[
\begin{aligned}
 \operatorname{Bi}(-x)
 &=\left(\frac{x}{3}\right)^{1/2}
   \{J_{-1/3}(\xi)-J_{1/3}(\xi)\}\\
 &=-\left(\frac{x}{3}\right)^{1/2}
   \operatorname{Im}\{e^{\pi i/6}H^{(1)}_{1/3}(\xi)\},
 \tag{1.14}\\
 \operatorname{Bi}'(-x)
 &=\frac{x}{\sqrt3}\{J_{-2/3}(\xi)+J_{2/3}(\xi)\}\\
 &=-\frac{x}{\sqrt3}
   \operatorname{Im}\{e^{-\pi i/6}H^{(1)}_{2/3}(\xi)\}.
 \tag{1.15}
\end{aligned}
\]

As \(x\to+\infty\),

\[
 \operatorname{Bi}(x)\sim
 \frac{e^\xi}{\sqrt\pi\,x^{1/4}}
 \sum_{s=0}^\infty\frac{u_s}{\xi^s},
 \qquad
 \operatorname{Bi}'(x)\sim
 \frac{x^{1/4}e^\xi}{\sqrt\pi}
 \sum_{s=0}^\infty\frac{v_s}{\xi^s}. \tag{1.16}
\]

For negative arguments,

\[
\begin{aligned}
 \operatorname{Bi}(-x)\sim{}&
 \frac1{\sqrt\pi\,x^{1/4}}
 \left\{
 -\sin(\xi-\pi/4)\sum_{s=0}^\infty(-1)^s\frac{u_{2s}}{\xi^{2s}}
 +\cos(\xi-\pi/4)\sum_{s=0}^\infty(-1)^s
   \frac{u_{2s+1}}{\xi^{2s+1}}
 \right\}, \tag{1.17}\\
 \operatorname{Bi}'(-x)\sim{}&
 \frac{x^{1/4}}{\sqrt\pi}
 \left\{
 \cos(\xi-\pi/4)\sum_{s=0}^\infty(-1)^s\frac{v_{2s}}{\xi^{2s}}
 +\sin(\xi-\pi/4)\sum_{s=0}^\infty(-1)^s
   \frac{v_{2s+1}}{\xi^{2s+1}}
 \right\}. \tag{1.18}
\end{aligned}
\]

The basis normalization is completed by

\[
 \mathcal W\{\operatorname{Ai}(x),\operatorname{Bi}(x)\}=\frac1\pi.
 \tag{1.19}
\]

The ratio derivative used later on the same pages is

\[
 \frac d{dx}\frac{\operatorname{Bi}(x)}{\operatorname{Ai}(x)}
 =\frac1{\pi\operatorname{Ai}^2(x)},
\]

on intervals where \(\operatorname{Ai}(x)\neq0\). It fixes the local
Wronskian orientation as
\(\operatorname{Ai}\operatorname{Bi}'-\operatorname{Ai}'\operatorname{Bi}\).
For \(x>0\), the source also records that \(\operatorname{Ai}\),
\(\operatorname{Bi}\), and \(\operatorname{Bi}'\) are positive,
\(\operatorname{Ai}'\) is negative, and each is monotone.

Section 1.4 supplies remainder controls for (1.07)-(1.09) and
(1.16)-(1.18). In particular, for \(x>0\),

\[
 \operatorname{Ai}(x)\leq
 \frac{e^{-\xi}}{2\sqrt\pi\,x^{1/4}},
 \qquad
 |\operatorname{Ai}'(x)|\leq
 \frac{x^{1/4}e^{-\xi}}{2\sqrt\pi}
 \left(1+\frac7{72\xi}\right).
\]

The more detailed error statements refer to the separately defined functions
\(P(\nu,\xi)\), \(Q(\nu,\xi)\), and \(\chi(n)\) from other source locations;
they are not promoted to entities by this bounded collation.

## Value modulus, value phase, and weight

For real \(x\), the source introduces a positive weight \(E\), value modulus
\(M\), and continuously unwrapped phase \(\theta\) through

\[
 E(x)\operatorname{Ai}(x)=M(x)\sin\theta(x),
 \qquad
 E(x)^{-1}\operatorname{Bi}(x)=M(x)\cos\theta(x), \tag{2.01}
\]

where \(E^{-1}(x)=1/E(x)\). Once \(E\) is prescribed, the algebraic recovery
is

\[
\begin{aligned}
 M(x)&=\{E^2(x)\operatorname{Ai}^2(x)
       +E^{-2}(x)\operatorname{Bi}^2(x)\}^{1/2},\\
 \theta(x)&=\tan^{-1}\!\left\{
       \frac{E^2(x)\operatorname{Ai}(x)}{\operatorname{Bi}(x)}
       \right\}. \tag{2.02}
\end{aligned}
\]

Let \(c\) be the negative root of
\(\operatorname{Ai}(x)=\operatorname{Bi}(x)\) having smallest absolute value.
The chosen weight is

\[
 E(x)=
 \begin{cases}
  \{\operatorname{Bi}(x)/\operatorname{Ai}(x)\}^{1/2},&c\leq x<\infty,\\
  1,&-\infty<x\leq c.
 \end{cases} \tag{2.03}
\]

The source reports \(c=-0.36605\) to five decimal places. It also states that
\(E\) is monotone in \(x\) and never smaller than \(1\). Formula (2.03) then
reduces (2.02) to

\[
 M(x)=\{2\operatorname{Ai}(x)\operatorname{Bi}(x)\}^{1/2},
 \qquad \theta(x)=\frac\pi4
 \qquad(x\geq c), \tag{2.04}
\]

and

\[
 M(x)=\{\operatorname{Ai}^2(x)+\operatorname{Bi}^2(x)\}^{1/2},
 \qquad
 \theta(x)=\tan^{-1}\!\{\operatorname{Ai}(x)/\operatorname{Bi}(x)\}
 \qquad(x\leq c). \tag{2.05}
\]

The inverse-tangent branch in (2.05) is chosen continuously and is fixed by
\(\theta(c)=\pi/4\). The limiting scales are

\[
 E(x)\sim\sqrt2\exp\!\left(\frac23x^{3/2}\right),
 \qquad
 M(x)\sim\pi^{-1/2}x^{-1/4}
 \qquad(x\to+\infty), \tag{2.06}
\]

and

\[
 M(x)\sim\pi^{-1/2}(-x)^{-1/4}
 \qquad(x\to-\infty). \tag{2.07}
\]

## Derivative modulus and derivative phase

Using the same weight \(E\), the derivative pair is represented by

\[
 E(x)\operatorname{Ai}'(x)=N(x)\sin\omega(x),
 \qquad
 E(x)^{-1}\operatorname{Bi}'(x)=N(x)\cos\omega(x). \tag{2.08}
\]

For \(x\geq c\),

\[
\begin{aligned}
 N(x)&=\left\{
 \frac{\operatorname{Ai}'^2(x)\operatorname{Bi}^2(x)
      +\operatorname{Bi}'^2(x)\operatorname{Ai}^2(x)}
      {\operatorname{Ai}(x)\operatorname{Bi}(x)}
 \right\}^{1/2},\\
 \omega(x)&=\tan^{-1}\!\left\{
 \frac{\operatorname{Ai}'(x)\operatorname{Bi}(x)}
      {\operatorname{Bi}'(x)\operatorname{Ai}(x)}
 \right\}. \tag{2.09}
\end{aligned}
\]

For \(x\leq c\),

\[
 N(x)=\{\operatorname{Ai}'^2(x)+\operatorname{Bi}'^2(x)\}^{1/2},
 \qquad
 \omega(x)=\tan^{-1}\!\{\operatorname{Ai}'(x)/\operatorname{Bi}'(x)\}.
 \tag{2.10}
\]

The inverse-tangent branches are again continuous. The global branch is fixed
by

\[
 \omega(x)\longrightarrow-\frac\pi4
 \qquad(x\to+\infty), \tag{2.11}
\]

and the modulus satisfies

\[
 N(x)\sim\pi^{-1/2}|x|^{1/4}
 \qquad(x\to\pm\infty). \tag{2.12}
\]

## Global constants associated with the auxiliaries

The three printed suprema are

\[
 \lambda=\sup_{-\infty<x<\infty}
 \{\pi|x|^{1/2}M^2(x)\}, \tag{2.13}
\]

and

\[
\begin{aligned}
 \mu_1&=\sup_{-\infty<x<\infty}
 \{\pi E(x)M(x)|x|^{1/2}|\operatorname{Ai}(x)|\},\\
 \mu_2&=\sup_{-\infty<x<\infty}
 \{\pi E(x)^{-1}M(x)|x|^{1/2}|\operatorname{Bi}(x)|\}.
 \tag{2.14}
\end{aligned}
\]

Numerical evaluation is reported as

\[
 \lambda=1.04\ldots,
 \qquad \mu_1=1,
 \qquad \mu_2=1. \tag{2.15}
\]

The respective suprema are described as approached at
\(x=1.33\ldots\), \(x\to-\infty\), and \(x\to-\infty\).

## Convention and ambiguity log

1. All functions in this collation are functions of a real \(x\). A later
   complex Ai/Bi object needs an explicit real-restriction agreement theorem;
   it is not supplied merely by reusing the same glyph.
2. The integrals (1.02) and (1.10) have improper semantics. In particular,
   their oscillatory terms are not presented as absolutely integrable.
3. The fractional powers of positive \(x\), \(3\), and positive quantities in
   braces are intended as positive real powers. The source pages do not define
   a complex-power branch for them.
4. The Bessel and Hankel identities (1.04)-(1.06) and (1.12)-(1.15) use
   \(\xi>0\), except that the Hankel argument \(-i\xi\) occurs in
   (1.12)-(1.13). Project-wide branch and normalization links for
   \(J_\nu,I_\nu,K_\nu,H^{(1)}_\nu\) remain unreviewed.
5. The Wronskian symbol is not defined afresh on these pages. The subsequent
   ratio derivative confirms the order
   \(\operatorname{Ai}\operatorname{Bi}'-\operatorname{Ai}'\operatorname{Bi}\),
   but a project-wide Wronskian convention still needs reconciliation.
6. The quotient form of \(\tan^{-1}\) in (2.05) is singular at zeros of
   \(\operatorname{Bi}\), and the form in (2.10) is singular at zeros of
   \(\operatorname{Bi}'\). The source resolves this by continuous branch
   continuation. A literal pointwise principal-arctangent definition would
   not be source-equivalent.
7. The conditions \(\theta(c)=\pi/4\) and
   \(\omega(+\infty)=-\pi/4\) remove the additive multiples of \(\pi\) left by
   the tangent ratios. They must be part of any phase specification.
8. Although (2.04) and (2.05) overlap at \(x=c\), their agreement uses the
   defining equality \(\operatorname{Ai}(c)=\operatorname{Bi}(c)\) and the
   chosen positive square root.
9. The decimal \(c=-0.36605\) and \(\lambda=1.04\ldots\) are reported
   numerical values, not exact definitions. The exact \(c\) is selected by a
   root-ordering condition; the exact \(\lambda\) is the supremum in (2.13).
10. The symbol \(\lambda\) in (2.13) is local to these auxiliary constants and
    is unrelated to exponent parameters bearing the same glyph elsewhere.
11. The asymptotic signs \(\sim\) in (1.07)-(1.18) and (2.06)-(2.12) require
    the source's finite-remainder convention. They do not assert convergence
    of the displayed infinite series.
12. Primes denote differentiation in the unscaled real Airy argument \(x\).
    No turning-point parameter or scaled derivative occurs in sections 1-2.

## Scope boundary

The graph and numerical table on printed pp. 393 and 396-397 are deliberately
not reproduced. Exercises 1.1, 1.2, 2.1, and 2.2 are not promoted as defining
occurrences here. Section 3 begins on printed p. 397 and is outside scope.

## Inventory integration record

The normalized inventory records the two occurrences, entities, notations, and
provisional links below. This registration is planning metadata only: every
source and normalization status remains unreviewed and neither occurrence is
in a manifest or bound to a theorem card.

### Occurrence records

| Occurrence ID | Locator | Printed label | Source kind | Target class |
| --- | --- | --- | --- | --- |
| OLV97-C11-AIRY-REAL | Ch. 11 sections 1.1-1.4, printed pp. 392-394, eqs. (1.01)-(1.19) | Airy Functions of Real Argument | body_definition | source_definition |
| OLV97-C11-AIRY-AUX | Ch. 11 sections 2.1-2.4, printed pp. 394-397, eqs. (2.01)-(2.15) | Auxiliary Functions for Real Variables | body_definition | source_definition |

Both rows would use edition olver_1997b, snapshot
SRC-OLV-1997-USER-PDF-20260905, queue class later_family, novelty class
source_recovery, evidence type direct_formula, resolution
transcribed_unreconciled, transcription status mathematical_transcription,
and reconciliation status unresolved.

### Entity records

| Entity ID | Canonical label | Kind | Proposed status or normalization |
| --- | --- | --- | --- |
| airy_ai | real Airy \(\operatorname{Ai}\) | named special function | same candidate as Chapter 2; real agreement pending |
| airy_bi | real Airy \(\operatorname{Bi}\) | named special function | provisional; (1.10), (1.11), and (1.19) transcribed |
| airy_real_basis | ordered real Airy basis \((\operatorname{Ai},\operatorname{Bi})\) | source basis pair | provisional; Wronskian orientation and value transcribed |
| airy_real_asymptotic_coefficients | Airy coefficients \(u_s,v_s\) | source auxiliary sequences | provisional; zero-based formulas transcribed |
| airy_weight_e | Airy weight \(E\) | named source auxiliary | positive piecewise function selected by \(c\) |
| airy_value_modulus_m | Airy value modulus \(M\) | named source auxiliary | positive square-root normalization |
| airy_value_phase_theta | Airy value phase \(\theta\) | named source auxiliary | continuous unwrapped phase; \(\theta(c)=\pi/4\) |
| airy_derivative_modulus_n | Airy derivative modulus \(N\) | named source auxiliary | positive square-root normalization |
| airy_derivative_phase_omega | Airy derivative phase \(\omega\) | named source auxiliary | continuous unwrapped phase; limit (2.11) |
| airy_weight_switch_c | Airy weight switch \(c\) | source auxiliary constant | least-absolute-value negative root of \(\operatorname{Ai}=\operatorname{Bi}\) |
| airy_auxiliary_lambda | Airy modulus supremum \(\lambda\) | source auxiliary constant | exact supremum (2.13); decimal only approximate |
| airy_auxiliary_mu1 | weighted \(\operatorname{Ai}\) supremum \(\mu_1\) | source auxiliary constant | exact supremum (2.14), reported value \(1\) |
| airy_auxiliary_mu2 | weighted \(\operatorname{Bi}\) supremum \(\mu_2\) | source auxiliary constant | exact supremum (2.14), reported value \(1\) |

The existing gamma entity is a proposed dependency. The Bessel and Hankel
symbols should link only after their own locked-edition entities are resolved.

### Notation records

| Notation ID | Entity | Printed symbol | Binder, domain, branch, or exception policy |
| --- | --- | --- | --- |
| OLV97-N-AIR11-AI | airy_ai | \(\operatorname{Ai}(x),\operatorname{Ai}'(x)\) | real \(x\); prime is the Airy-argument derivative |
| OLV97-N-AIR11-BI | airy_bi | \(\operatorname{Bi}(x),\operatorname{Bi}'(x)\) | real \(x\); integral and initial normalization in (1.10)-(1.11) |
| OLV97-N-AIR11-XI | airy_real_asymptotic_coefficients | \(\xi=\frac23x^{3/2}\) | \(x>0\); positive real power |
| OLV97-N-AIR11-UV | airy_real_asymptotic_coefficients | \(u_s,v_s\) | \(s\in\mathbb N\); \(u_0=v_0=1\), product formula for \(s\geq1\) |
| OLV97-N-AIR11-W | airy_real_basis | \(\mathcal W\{\operatorname{Ai},\operatorname{Bi}\}\) | orientation locally confirmed as \(\operatorname{Ai}\operatorname{Bi}'-\operatorname{Ai}'\operatorname{Bi}\) |
| OLV97-N-AIR11-E | airy_weight_e | \(E(x),E^{-1}(x)\) | real \(x\); \(E^{-1}=1/E\); piecewise at \(c\) |
| OLV97-N-AIR11-M | airy_value_modulus_m | \(M(x)\) | real \(x\); nonnegative square root, with positive behavior from the basis |
| OLV97-N-AIR11-THETA | airy_value_phase_theta | \(\theta(x)\) | real \(x\); continuous arctangent branch fixed at \(c\) |
| OLV97-N-AIR11-C | airy_weight_switch_c | \(c\) | selected negative root; decimal is not the definition |
| OLV97-N-AIR11-N | airy_derivative_modulus_n | \(N(x)\) | real \(x\); nonnegative square root |
| OLV97-N-AIR11-OMEGA | airy_derivative_phase_omega | \(\omega(x)\) | real \(x\); continuous arctangent branch fixed at \(+\infty\) |
| OLV97-N-AIR11-LAMBDA | airy_auxiliary_lambda | \(\lambda\) | supremum over all real \(x\); unrelated to Watson notation |
| OLV97-N-AIR11-MU1 | airy_auxiliary_mu1 | \(\mu_1\) | supremum over all real \(x\) |
| OLV97-N-AIR11-MU2 | airy_auxiliary_mu2 | \(\mu_2\) | supremum over all real \(x\) |

All entity rows use queue class `later_family` with provisional identity and
unresolved normalization. All notation rows use the snapshot above, evidence
type `direct_formula`, resolution status `normalization_unresolved`, and
transcription status `mathematical_transcription`.
