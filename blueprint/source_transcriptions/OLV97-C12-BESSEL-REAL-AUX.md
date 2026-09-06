# OLV97-C12-BESSEL-REAL-AUX - planning mathematical transcription

**Status:** planning-only first collation; transcribed-unreconciled;
independent review pending
**Edition:** F. W. J. Olver, *Asymptotics and Special Functions*, corrected
A K Peters reprint, 1997, ISBN 1-56881-069-5
**Source snapshot:** SRC-OLV-1997-USER-PDF-20260905
**Snapshot SHA-256:**
08e1844d29a5ad21f89b9b600249ce18ac1665a5845be2d4e4219a3ededdc909
**Source location:** Chapter 12, sections 1.1-1.3 and Exercise 1.1,
printed pp. 435-438; PDF pages 448-451; equations (1.01)-(1.24)

This is a formula-level transcription in new prose. It contains no scan,
page image, extracted page text, or numerical table. It is not a theorem card,
does not reconcile an inventory record, and does not authorize implementation.
The source assertions collected in sections 1.1-1.3 are distinguished from
Exercise 1.1. The collation stops before section 2.1.

## Checked page map

| Printed page | PDF page | Located material |
| --- | ---: | --- |
| 435 | 448 | Chapter 12 title; section 1 and 1.1; real \(I/K\) positivity, monotonicity, endpoint behavior, Wronskian, and recurrences (1.01)-(1.05) |
| 436 | 449 | negative-order \(I/K\) formulas; section 1.2; real \(J/Y\) endpoint behavior, Wronskian, recurrences, negative orders, and zeros (1.06)-(1.14); section 1.3 begins |
| 437 | 450 | root \(X_\nu\), weight \(E_\nu\), modulus \(M_\nu\), phase \(\theta_\nu\), derivatives, zero phases, and endpoint forms (1.15)-(1.24) |
| 438 | 451 | phase-normalization argument at order \(1/2\); numerical table not reproduced; Exercise 1.1; section 2 heading and section 2.1 begin outside scope |

## Shared real domain and role in Chapter 12

Until section 8 of the chapter, the source restricts the variables by

\[
 \nu\geq0,\qquad x>0.
\]

Section 1 collects Bessel and modified-Bessel facts for later use as Case III
comparison functions. Unless a narrower condition is shown, every assertion
below inherits this real-order, positive-argument convention. A prime denotes
ordinary differentiation with respect to \(x\), never differentiation in the
order \(\nu\).

## Source assertions: the real modified basis \(I_\nu,K_\nu\)

The source states that \(I_\nu(x)\) and \(K_\nu(x)\) are continuous and
positive as functions of \(\nu\) and \(x\) on the shared domain. For fixed
\(\nu\), \(I_\nu(x)\) increases and \(K_\nu(x)\) decreases with \(x\). For
fixed \(x\), \(I_\nu(x)\) decreases and \(K_\nu(x)\) increases with \(\nu\).

For fixed \(\nu\), as \(x\to0^+\),

\[
 I_\nu(x)\sim\frac{(x/2)^\nu}{\Gamma(\nu+1)}, \tag{1.01}
\]

and

\[
 K_0(x)\sim\log\frac1x,
 \qquad
 K_\nu(x)\sim\frac{\Gamma(\nu)}{2(x/2)^\nu}
 \quad(\nu>0). \tag{1.02}
\]

As \(x\to+\infty\),

\[
 I_\nu(x)\sim\frac{e^x}{(2\pi x)^{1/2}},
 \qquad
 K_\nu(x)\sim\left(\frac\pi{2x}\right)^{1/2}e^{-x}. \tag{1.03}
\]

Both large-\(x\) relations are stated to hold uniformly for bounded \(\nu\).

The ordered-basis Wronskian is

\[
 \mathcal W\{K_\nu(x),I_\nu(x)\}
 =I_\nu(x)K_{\nu+1}(x)+I_{\nu+1}(x)K_\nu(x)
 =\frac1x. \tag{1.04}
\]

Thus the local orientation is
\(\mathcal W\{f,g\}=fg'-f'g\): swapping \(K_\nu,I_\nu\) reverses the sign.

For the compact recurrence display, the source writes

\[
 \mathscr L_\nu(x)=I_\nu(x)
 \quad\hbox{or}\quad
 \mathscr L_\nu(x)=e^{\nu\pi i}K_\nu(x).
\]

With this order-dependent rescaling, it gives

\[
\begin{aligned}
 \mathscr L_{\nu-1}(x)-\mathscr L_{\nu+1}(x)
 &=\frac{2\nu}{x}\mathscr L_\nu(x),&
 \mathscr L_\nu'(x)
 &=\mathscr L_{\nu-1}(x)-\frac\nu x\mathscr L_\nu(x),\\
 \mathscr L_{\nu-1}(x)+\mathscr L_{\nu+1}(x)
 &=2\mathscr L_\nu'(x),&
 \mathscr L_\nu'(x)
 &=\mathscr L_{\nu+1}(x)+\frac\nu x\mathscr L_\nu(x).
\end{aligned} \tag{1.05}
\]

The factor \(e^{\nu\pi i}\) belongs to the generic \(K\)-recurrence notation;
it is not part of the positive real normalization of \(K_\nu(x)\).

The negative-order connections are

\[
 I_{-\nu}(x)=I_\nu(x)+\frac2\pi\sin(\nu\pi)K_\nu(x),
 \qquad
 K_{-\nu}(x)=K_\nu(x). \tag{1.06}
\]

The source says that (1.03)-(1.05) remain valid after replacing every
\(\nu\) by \(-\nu\). It also says that the correspondingly replaced (1.01)
is valid provided \(\nu\notin\{1,2,3,\ldots\}\). This exception must be
retained: at positive integral \(\nu\), the naively replaced leading
coefficient contains reciprocal Gamma at a nonpositive integer and does not
describe \(I_{-\nu}=I_\nu\).

## Source assertions: the real unmodified basis \(J_\nu,Y_\nu\)

The source states that the unmodified Bessel functions are continuous in
\(\nu\) and \(x\) on the shared domain. For fixed \(\nu\), as \(x\to0^+\),

\[
 J_\nu(x)\sim\frac{(x/2)^\nu}{\Gamma(\nu+1)}, \tag{1.07}
\]

and

\[
 Y_0(x)\sim-\frac2\pi\log\frac1x,
 \qquad
 Y_\nu(x)\sim-\frac{\Gamma(\nu)}{\pi(x/2)^\nu}
 \quad(\nu>0). \tag{1.08}
\]

As \(x\to+\infty\),

\[
\begin{aligned}
 J_\nu(x)
 &=\left(\frac2{\pi x}\right)^{1/2}
 \left\{\cos\!\left(x-\frac12\nu\pi-\frac14\pi\right)
 +O(x^{-1})\right\},\\
 Y_\nu(x)
 &=\left(\frac2{\pi x}\right)^{1/2}
 \left\{\sin\!\left(x-\frac12\nu\pi-\frac14\pi\right)
 +O(x^{-1})\right\}.
\end{aligned} \tag{1.09}
\]

These statements are uniform for bounded \(\nu\).

The ordered Wronskian identity is

\[
 \mathcal W\{J_\nu(x),Y_\nu(x)\}
 =J_{\nu+1}(x)Y_\nu(x)-J_\nu(x)Y_{\nu+1}(x)
 =\frac2{\pi x}. \tag{1.10}
\]

This fixes the same local orientation
\(\mathcal W\{f,g\}=fg'-f'g\).

Writing \(\mathscr C_\nu=J_\nu\) or \(Y_\nu\), the recurrence package is

\[
\begin{aligned}
 \mathscr C_{\nu-1}(x)+\mathscr C_{\nu+1}(x)
 &=\frac{2\nu}{x}\mathscr C_\nu(x),&
 \mathscr C_\nu'(x)
 &=\mathscr C_{\nu-1}(x)-\frac\nu x\mathscr C_\nu(x),\\
 \mathscr C_{\nu-1}(x)-\mathscr C_{\nu+1}(x)
 &=2\mathscr C_\nu'(x),&
 \mathscr C_\nu'(x)
 &=-\mathscr C_{\nu+1}(x)+\frac\nu x\mathscr C_\nu(x).
\end{aligned} \tag{1.11}
\]

Functions of negative order are connected by

\[
\begin{aligned}
 J_{-\nu}(x)
 &=\cos(\nu\pi)J_\nu(x)-\sin(\nu\pi)Y_\nu(x),\\
 Y_{-\nu}(x)
 &=\sin(\nu\pi)J_\nu(x)+\cos(\nu\pi)Y_\nu(x).
\end{aligned} \tag{1.12}
\]

The source says (1.09)-(1.11) remain valid with every \(\nu\) replaced by
\(-\nu\), while the correspondingly replaced (1.07) requires
\(\nu\notin\{1,2,3,\ldots\}\).

Let \(j_{\nu,s}\) and \(y_{\nu,s}\) denote respectively the positive zeros
of \(J_\nu(x)\) and \(Y_\nu(x)\), in increasing index order. The source states
the interlacing

\[
 y_{\nu,1}<j_{\nu,1}<y_{\nu,2}<j_{\nu,2}<\cdots . \tag{1.13}
\]

For fixed \(\nu\) and \(s\to\infty\), it gives

\[
 j_{\nu,s}=\left(s+\frac\nu2-\frac14\right)\pi+O(s^{-1}),
 \qquad
 y_{\nu,s}=\left(s+\frac\nu2-\frac34\right)\pi+O(s^{-1}). \tag{1.14}
\]

The source does not on these pages supply a global zero-counting definition
beyond the positive-zero indexing just used.

## Source assertions: balancing root and weight

Define \(X_\nu\) to be the smallest positive root of

\[
 J_\nu(x)+Y_\nu(x)=0.
\]

Using (1.07), (1.08), and (1.13), the source observes a negative sign near
\(0^+\) and a positive sign at \(y_{\nu,1}\), obtaining

\[
 0<X_\nu<y_{\nu,1}. \tag{1.15}
\]

It further states that continuity of \(X_\nu\) in \(\nu\) is provable by the
methods of Chapter 7, section 7.

The real-variable weight is

\[
 E_\nu(x)=
 \begin{cases}
 \{-Y_\nu(x)/J_\nu(x)\}^{1/2},&0<x\leq X_\nu,\\
 1,&x\geq X_\nu,
 \end{cases} \tag{1.16}
\]

using the positive real square root. At \(x=X_\nu\), the defining root
identity makes the two pieces agree. From (1.10),

\[
 \frac d{dx}\{E_\nu^2(x)\}
 =-\frac2{\pi xJ_\nu^2(x)},
 \qquad 0<x<X_\nu.
\]

Accordingly, the source states that \(E_\nu(x)\) is continuous, positive, and
nonincreasing in \(x\), and is also continuous in \(\nu\).

## Source assertions: modulus and continuously unwrapped phase

The value pair is represented by

\[
 J_\nu(x)=E_\nu^{-1}(x)M_\nu(x)\cos\theta_\nu(x),
 \qquad
 Y_\nu(x)=E_\nu(x)M_\nu(x)\sin\theta_\nu(x). \tag{1.17}
\]

For \(0<x\leq X_\nu\), this gives

\[
 M_\nu(x)=\{2|Y_\nu(x)|J_\nu(x)\}^{1/2},
 \qquad
 \theta_\nu(x)=-\frac\pi4. \tag{1.18}
\]

For \(x\geq X_\nu\), it gives

\[
 M_\nu(x)=\{J_\nu^2(x)+Y_\nu^2(x)\}^{1/2},
 \qquad
 \theta_\nu(x)=\tan^{-1}\{Y_\nu(x)/J_\nu(x)\}. \tag{1.19}
\]

The inverse-tangent branch is explicitly selected so that
\(\theta_\nu(x)\) is continuous. Thus (1.19) is a local quotient formula for
an unwrapped phase, not a pointwise principal-arctangent totalization through
the zeros of \(J_\nu\).

Differentiation and (1.10) yield

\[
 \theta_\nu'(x)=\frac2{\pi xM_\nu^2(x)},
 \qquad x>X_\nu. \tag{1.20}
\]

The source concludes that \(\theta_\nu\) is nondecreasing. Its zero-index
normalization is

\[
 \theta_\nu(y_{\nu,s})=(s-1)\pi,
 \qquad
 \theta_\nu(j_{\nu,s})=\left(s-\frac12\right)\pi. \tag{1.21}
\]

As \(x\to0^+\), the weight satisfies

\[
 E_0(x)\sim
 \left\{\frac2\pi\log\frac1x\right\}^{1/2},
 \qquad
 E_\nu(x)\sim
 \left(\frac\nu\pi\right)^{1/2}
 \frac{\Gamma(\nu)}{(x/2)^\nu}
 \quad(\nu>0), \tag{1.22}
\]

while the modulus satisfies

\[
 M_0(x)\sim
 2\left\{\frac1\pi\log\frac1x\right\}^{1/2},
 \qquad
 M_\nu(x)\longrightarrow
 \left(\frac2{\pi\nu}\right)^{1/2}
 \quad(\nu>0). \tag{1.23}
\]

As \(x\to+\infty\),

\[
 M_\nu(x)\sim\left(\frac2{\pi x}\right)^{1/2},
 \qquad
 \theta_\nu(x)=x-\frac12\nu\pi-\frac14\pi+O(x^{-1}). \tag{1.24}
\]

To fix the additive multiple of \(2\pi\) in the last phase formula, the
source uses continuity in \(\nu\) and the half-order identities

\[
 J_{1/2}(x)=2^{1/2}(\pi x)^{-1/2}\sin x,
 \qquad
 Y_{1/2}(x)=-2^{1/2}(\pi x)^{-1/2}\cos x.
\]

They give

\[
 X_{1/2}=\frac\pi4,
 \qquad
 \theta_{1/2}(x)=x-\frac\pi2
\]

on the \(x\geq X_{1/2}\) branch used in the large-\(x\) argument. The source
then supplies a short numerical table of \(X_\nu\); that table is deliberately
not reproduced here.

## Exercise 1.1: target, not a source assertion

Exercise 1.1 asks the reader to show, as \(\nu\) becomes large,

\[
 X_\nu
 =\nu-c\left(\frac\nu2\right)^{1/3}+O(\nu^{-1/3}),
\]

where \(c=-0.36605\ldots\) refers back to the exact Airy root selected in
Chapter 11, section 2.2. The decimal is not the definition of \(c\). This
large-order formula is an exercise target and is not proved in section 1.

## Convention, normalization, and open-question log

1. All baseline functions on these pages have real order \(\nu\geq0\) and
   positive real argument \(x\). Formulas obtained by replacing \(\nu\) with
   \(-\nu\) are separately qualified and do not change the baseline domain
   silently.
2. The source assumes the Chapter 2 and Chapter 7 normalizations of
   \(J_\nu,Y_\nu,I_\nu,K_\nu\). These pages collect properties; they do not
   redefine the complex branches or the integral-order continuations of
   \(Y\) and \(K\).
3. The Wronskian equations fix both basis order and sign:
   \(\mathcal W\{K,I\}=1/x\) and
   \(\mathcal W\{J,Y\}=2/(\pi x)\), with
   \(\mathcal W\{f,g\}=fg'-f'g\).
4. In (1.05), the generic recurrence member for \(K\) is
   \(e^{\nu\pi i}K_\nu\), not \(K_\nu\) by itself. Dropping this
   order-dependent factor changes the recurrence signs.
5. The negative-order formulas (1.06) and (1.12) are exact real-argument
   connection formulas. Their use at integral orders must respect the
   separately constructed classical \(Y_n\) and \(K_n\); totalized sine
   quotients from other definitions are not supplied here.
6. The small-\(x\) formulas after \(\nu\mapsto-\nu\) exclude positive integral
   \(\nu\). This exception is explicit in the source and cannot be erased by
   reciprocal-Gamma notation.
7. The zeros \(j_{\nu,s}\) and \(y_{\nu,s}\) are positive real zeros in the
   displayed interlacing order. A local zero result does not by itself prove
   this global indexing.
8. The square roots in \(E_\nu\) and \(M_\nu\) are positive real square roots.
   The formulas rely on the sign regime before \(X_\nu\), not on a complex
   square-root branch.
9. The phase \(\theta_\nu\) is globally selected by continuity and the
   constant value \(-\pi/4\) before the switching root. Formula (1.19) must
   not be implemented as an unqualified principal arctangent at zeros of
   \(J_\nu\).
10. The continuity assertions for \(X_\nu\), \(E_\nu\), and
    \(\theta_\nu\) mix spatial and order dependence. A Lean implementation
    needs separate theorems for each variable and may not infer order
    regularity from the spatial ODE.
11. The \(O\)-terms in (1.09), (1.14), (1.24), and Exercise 1.1 are
    qualitative source statements with the displayed fixed/bounded-parameter
    qualifiers. This transcription supplies no missing explicit constants.
12. Exercise 1.1 is not an assertion of section 1, and its \(c\) must be
    reconciled to the exact Chapter 11 Airy switch-root entity rather than to
    the printed decimal alone.

## Scope boundary

The numerical \(X_\nu\) table on printed p. 438 is omitted under the
copyright-safe documentation policy; only the exact half-order normalization
used in the phase argument is retained. Section 2, its formal-series title,
and every formula beginning with section 2.1 are outside this transcription.
No Chapter 7 or DLMF formula has been imported to complete a gap in the four
inspected pages.

## Inventory integration proposal

This section is planning metadata only. It proposes no CSV edit, confirmed
association, theorem-card registration, or manifest membership.

### Occurrence proposal

| Field | Proposed value |
| --- | --- |
| occurrence_id | OLV97-C12-BESSEL-REAL-AUX |
| edition_id | olver_1997b |
| source_snapshot_id | SRC-OLV-1997-USER-PDF-20260905 |
| queue_class | cross_cutting |
| chapter, section | 12, 1.1-1.3 and Exercise 1.1 |
| printed pages | 435-438 |
| locator | Ch. 12 section 1, eqs. (1.01)-(1.24), through Exercise 1.1 and before section 2.1 |
| printed label | Bessel Functions and Modified Bessel Functions of Real Order and Argument |
| source kind | body_definition/property collection with separately marked exercise target |
| target class | source_definition and qualitative support |
| novelty class | source_recovery |
| evidence | direct_formula and direct_prose |
| resolution | transcribed_unreconciled |
| transcription status | mathematical_transcription |
| reconciliation | unresolved; independent page, formula, normalization, zero-index, and auxiliary review required |

### Provisional entity split

| Proposed entity | Mathematical role | Unresolved point |
| --- | --- | --- |
| `bessel_j_real` | real restriction of \(J_\nu(x)\) | bridge to the Chapter 2 complex family |
| `bessel_y_real` | real second-kind function \(Y_\nu(x)\) | integral-order continuation and complex-family bridge |
| `modified_bessel_i_real` | real restriction of \(I_\nu(x)\) | bridge to the Chapter 2 complex family |
| `modified_bessel_k_real` | real second modified function \(K_\nu(x)\) | normalization and integral-order continuation |
| `bessel_real_basis` | ordered basis \((J_\nu,Y_\nu)\) | Wronskian orientation and real agreement |
| `modified_bessel_real_basis` | ordered basis \((K_\nu,I_\nu)\) | Wronskian orientation and recurrence rescaling |
| `bessel_positive_zeros` | indexed zeros \(j_{\nu,s},y_{\nu,s}\) | global indexing and continuity in parameters |
| `bessel_balance_root_x` | smallest root \(X_\nu\) of \(J_\nu+Y_\nu\) | existence, uniqueness under selector, continuity in \(\nu\) |
| `bessel_weight_e` | positive weight \(E_\nu(x)\) | piecewise agreement and positivity proof |
| `bessel_modulus_m` | zero-safe modulus \(M_\nu(x)\) | positivity and endpoint continuation |
| `bessel_phase_theta` | continuous unwrapped phase \(\theta_\nu(x)\) | branch construction through component zeros |

The real restrictions normally remain the same canonical function entities as
their complex counterparts; the `_real` labels above describe proposed
evidence roles, not a decision to create duplicate public functions.

### Provisional downstream card links

The following identifiers already occur in the Bessel family plan. Their
appearance here is only a proposed evidence link; none is registered,
authorized, or selected into a manifest by this transcription.

| Provisional card ID | Possible use of this collation |
| --- | --- |
| `DEF-BES-001` | real \(J\) agreement, negative-order formula, recurrence, and origin behavior |
| `DEF-BES-002` | real \(I\) agreement, recurrence, positivity, and origin behavior |
| `DEF-BES-003` | nonintegral \(Y\) normalization and real connection formula |
| `DEF-BES-004` | integral-order \(Y\) continuation required by the real basis |
| `DEF-BES-005` | \(K\) normalization, negative-order equality, positivity, and integral continuation |
| `ANA-BES-001` | continuity in order used by negative-order and auxiliary assertions |
| `CMP-BES-001` | exact \(J/Y\) and \(K/I\) comparison bases, recurrences, and oriented Wronskians |
| `CMP-BES-002` | \(X_\nu,E_\nu,M_\nu,\theta_\nu\), zero-safe formulas, and endpoint behavior |
| `AUD-BES-001` | sign, Wronskian, negative-order, zero/interlacing, and half-order phase regressions |

No theorem card is created by this file, and these IDs remain provisional.
