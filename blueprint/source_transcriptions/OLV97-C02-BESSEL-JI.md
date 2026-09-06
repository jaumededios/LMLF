# OLV97-C02-BESSEL-JI - planning mathematical transcription

**Status:** planning-only revision 2; Referee A changes integrated;
transcribed-unreconciled; fresh independent review pending
**Edition:** F. W. J. Olver, *Asymptotics and Special Functions*, corrected
A K Peters reprint, 1997, ISBN 1-56881-069-5
**Source snapshot:** SRC-OLV-1997-USER-PDF-20260905
**Snapshot SHA-256:**
08e1844d29a5ad21f89b9b600249ce18ac1665a5845be2d4e4219a3ededdc909
**Source location:** Chapter 2, sections 9.1-9.5 and 10.1, together with
Exercises 9.1-9.8 and 10.1-10.6, printed pp. 55-61; PDF pages 68-74;
equations (9.01)-(9.16) and (10.01)-(10.05)

This is a formula-level transcription in new prose. It contains no scan,
page image, extracted page text, figure, or extended source prose. It is not
a theorem card, does not reconcile an inventory record, and does not
authorize implementation. Results stated in the main exposition are kept
separate below from formulas posed only as exercises.

## Checked page map

| Printed page | PDF page | Located material |
| --- | ---: | --- |
| 55 | 68 | section 9.1; integer-order integral definitions (9.01)-(9.02) |
| 56 | 69 | contour formula, integer-order series, negative-order relation, and generating function (9.03)-(9.06) |
| 57 | 70 | Bessel equation; general-order definition, branch rule, and equation (9.07)-(9.11) |
| 58 | 71 | Schlaefli contour formulas and first recurrence (9.12)-(9.14); Fig. 9.1 not reproduced |
| 59 | 72 | recurrences (9.15)-(9.16); Exercises 9.1-9.7 begin |
| 60 | 73 | Exercise 9.7 concludes; Exercise 9.8; section 10.1, definition, rotation, equation, recurrences (10.01)-(10.05); Exercise 10.1 |
| 61 | 74 | Exercises 10.2-10.6; section 11 begins and is outside scope |

## Main exposition: integer-order first-kind function

For an integer \(n\) and real or complex \(z\), the source first defines
\(J_n(z)\) by Bessel's integral

\[
 J_n(z)=\frac1\pi\int_0^\pi
 \cos(n\theta-z\sin\theta)\,d\theta,
 \qquad n=0,\pm1,\pm2,\ldots . \tag{9.01}
\]

Here \(n\) is called the order and \(z\) the argument. The source states that
this is entire in \(z\). An equivalent exponential form is

\[
 J_n(z)=\frac1{2\pi}\int_{-\pi}^{\pi}
 \exp(-in\theta+iz\sin\theta)\,d\theta. \tag{9.02}
\]

After \(h=e^{i\theta}\), the positively oriented unit circle
\(\mathcal C\) gives

\[
 J_n(z)=\frac1{2\pi i}\int_{\mathcal C}
 \exp\!\left\{\frac z2(h-h^{-1})\right\}
 \frac{dh}{h^{n+1}}. \tag{9.03}
\]

The same formula remains valid when the unit circle is deformed to any simple
closed contour encircling the origin once with the same orientation.

For \(n\geq0\), residue extraction gives

\[
 J_n^{(r)}(0)=0\quad(0\leq r\leq n-1),
\]

and, for \(s=0,1,2,\ldots\),

\[
 J_n^{(n+2s)}(0)=
 \frac{(-1)^s}{2^{n+2s}}\binom{n+2s}{s},
 \qquad
 J_n^{(n+2s+1)}(0)=0.
\]

Consequently,

\[
 J_n(z)=\left(\frac z2\right)^n
 \sum_{s=0}^{\infty}
 \frac{(-1)^s(z^2/4)^s}{s!(n+s)!},
 \qquad n=0,1,2,\ldots . \tag{9.04}
\]

Changing the integration variable in (9.01) gives the integer negative-order
identity

\[
 J_{-n}(z)=(-1)^nJ_n(z). \tag{9.05}
\]

The Laurent generating function is

\[
 \exp\!\left\{\frac z2(h-h^{-1})\right\}
 =\sum_{n=-\infty}^{\infty}J_n(z)h^n,
 \qquad h\neq0. \tag{9.06}
\]

The source states that this Laurent series converges for all complex \(z\)
and all nonzero complex \(h\).

Differentiation of (9.01), followed by an integration by parts, gives the
identity summarized in the source as

\[
 z\{zJ_n'(z)\}'+(z^2-n^2)J_n(z)=0, \tag{9.07}
\]

so \(w=J_n(z)\) satisfies Bessel's equation

\[
 z^2w''+zw'+(z^2-n^2)w=0. \tag{9.08}
\]

## Main exposition: general order, series, and branches

For a general real or complex order \(\nu\), the integral (9.01) is not used
as the definition. The source instead defines

\[
 J_\nu(z)=\left(\frac z2\right)^\nu
 \sum_{s=0}^{\infty}
 \frac{(-1)^s(z^2/4)^s}{s!\,\Gamma(\nu+s+1)}. \tag{9.09}
\]

This agrees with (9.04) for zero and positive integral order. At a negative
integral order, the first \(-\nu\) reciprocal-Gamma terms vanish, making the
definition consistent with (9.05).

The source asserts locally uniform convergence of the normalized sum on
compact subsets of the \(\nu\)- and \(z\)-planes. Thus

\[
 \left(\frac z2\right)^{-\nu}J_\nu(z)
\]

is entire separately in \(z\) and \(\nu\). For \(z\neq0\), \(J_\nu(z)\) is
entire in \(\nu\); as a function of \(z\), it is generally multivalued unless
\(\nu\) is zero or an integer. The principal branch is obtained by using the
principal value of \((z/2)^\nu=\exp\{\nu\log(z/2)\}\). The branch-continuation
rule printed in the source is

\[
 J_\nu(ze^{m\pi i})=e^{m\nu\pi i}J_\nu(z),
 \qquad m\in\mathbb Z. \tag{9.10}
\]

This is a relation between continuously selected branches; it is not a
license to replace both sides everywhere by unrelated principal values.

Termwise differentiation shows that both \(J_\nu\) and \(J_{-\nu}\) satisfy

\[
 w''+\frac1z w'+\left(1-\frac{\nu^2}{z^2}\right)w=0. \tag{9.11}
\]

The equation alone does not distinguish either normalization.

## Main exposition: Schlaefli contours and recurrences

Substituting the Hankel-loop formula for reciprocal Gamma into (9.09) gives
Schlaefli's integral

\[
 J_\nu(z)=\frac{(z/2)^\nu}{2\pi i}
 \int_{-\infty}^{(0+)}
 \exp\!\left(t-\frac{z^2}{4t}\right)
 \frac{dt}{t^{\nu+1}}. \tag{9.12}
\]

The notation \(-\infty\) to \((0+)\) denotes the same Hankel loop used earlier
for reciprocal Gamma. Along it, \(t^{\nu+1}\) has its principal value where
the path crosses the positive real axis and is continued continuously on the
rest of the path.

For positive \(z\), the substitutions \(t=zh/2\) and \(h=e^\tau\) yield

\[
 J_\nu(z)=\frac1{2\pi i}
 \int_{\infty-\pi i}^{\infty+\pi i}
 \exp(z\sinh\tau-\nu\tau)\,d\tau, \tag{9.13}
\]

on the contour shown in the omitted Fig. 9.1. The source extends this formula
by analytic continuation to \(|\operatorname{ph}z|<\pi/2\).

The contour calculation first yields

\[
 J_{\nu-1}(z)+J_{\nu+1}(z)=\frac{2\nu}{z}J_\nu(z), \tag{9.14}
\]

and

\[
 J_{\nu-1}(z)-J_{\nu+1}(z)=2J_\nu'(z). \tag{9.15}
\]

Although (9.13) has the displayed phase restriction, the source says analytic
continuation removes it from (9.14). Combining (9.14) and (9.15) gives

\[
 J_{\nu+1}(z)=\frac\nu zJ_\nu(z)-J_\nu'(z),
 \qquad
 J_{\nu-1}(z)=\frac\nu zJ_\nu(z)+J_\nu'(z). \tag{9.16}
\]

In particular, \(J_0'(z)=-J_1(z)\). Every prime in this chapter-2 collation
means differentiation with respect to the displayed argument \(z\), not the
order.

## Exercises 9.1-9.8: targets, not source assertions

The following formulas are posed for the reader to derive. They are not
assertions established in the surrounding exposition.

Exercise 9.1 asks for three consequences of (9.06):

\[
\begin{aligned}
 1&=J_0(z)+2J_2(z)+2J_4(z)+2J_6(z)+\cdots,\\
 \cos z&=J_0(z)-2J_2(z)+2J_4(z)-2J_6(z)+\cdots,\\
 \frac z2\cos z&=J_1(z)-9J_3(z)+25J_5(z)-49J_7(z)+\cdots.
\end{aligned}
\]

Exercise 9.2 asks for Neumann's addition formula at integer order,

\[
 J_n(z_1+z_2)=\sum_{s=-\infty}^{\infty}
 J_s(z_1)J_{n-s}(z_2),
\]

and then for

\[
 1=J_0^2(z)+2\sum_{s=1}^{\infty}J_s^2(z).
\]

Exercise 9.3 gives the half-integral targets

\[
\begin{aligned}
 J_{1/2}(z)&=\left(\frac2{\pi z}\right)^{1/2}\sin z,&
 J_{3/2}(z)&=\left(\frac2{\pi z}\right)^{1/2}
 \left(\frac{\sin z}{z}-\cos z\right),\\
 J_{-1/2}(z)&=\left(\frac2{\pi z}\right)^{1/2}\cos z,&
 J_{-3/2}(z)&=-\left(\frac2{\pi z}\right)^{1/2}
 \left(\frac{\cos z}{z}+\sin z\right).
\end{aligned}
\]

The square root in these formulas and the half-integral \(J\)-values inherit
the principal branch selected in section 9.3, or a branch obtained from it by
the continuation rule (9.10). The exercise does not restate a cut, boundary
value, or maximal admissible \(z\)-domain. Those details remain unresolved
source semantics and must be fixed before this target is formalized.

Exercise 9.4 asks, for nonnegative integral \(s\), to prove

\[
 \left(\frac1z\frac d{dz}\right)^s
 \{z^\nu J_\nu(z)\}=z^{\nu-s}J_{\nu-s}(z),
\]

and

\[
 \left(\frac1z\frac d{dz}\right)^s
 \{z^{-\nu}J_\nu(z)\}=(-1)^s z^{-\nu-s}J_{\nu+s}(z).
\]

Here \(z^\nu\), \(z^{-\nu}\), and all Bessel factors inherit one coherent
principal-or-continued branch from section 9.3. The inspected exercise does
not specify the cut, whether cut boundaries are admitted, or the precise
punctured domain on which repeated differentiation is intended.

Exercise 9.5 asks for Poisson's integral

\[
 J_\nu(z)=
 \frac{(z/2)^\nu}{\pi^{1/2}\Gamma(\nu+1/2)}
 \int_0^\pi \cos(z\cos\theta)\sin^{2\nu}\theta\,d\theta,
 \qquad \operatorname{Re}\nu>-\frac12,
\]

and for a direct verification that this integral satisfies (9.11).
The prefactor \((z/2)^\nu\) and \(J_\nu(z)\) again inherit the branch convention
of section 9.3. Although the \(\theta\)-integral is over a real interval, the
exercise does not separately state an admissible complex \(z\)-domain or its
boundary convention.

Exercise 9.6 asks for the bounds

\[
 |J_\nu(z)|\leq
 \frac{|z/2|^\nu e^{|\operatorname{Im}z|}}{\Gamma(\nu+1)},
 \qquad \nu\geq-\frac12,
\]

and, at integral order,

\[
 |J_n(z)|\leq e^{|\operatorname{Im}z|},
 \qquad n=0,\pm1,\pm2,\ldots .
\]

The first inequality is printed in a real-\(\nu\) range; it should not be read
as an ordering hypothesis on complex \(\nu\).
The general-order Bessel value in this bound is understood on the same
principal or continuously selected branch as in section 9.3. The exercise
does not state whether the estimate is intended on a cut boundary.

Exercise 9.7 asks, for \(\operatorname{Re}\nu>-1\), to show

\[
 \int_0^z J_\nu(t)\,dt
 =2\sum_{s=0}^{\infty}J_{\nu+2s+1}(z),
\]

and then, using the source's Fresnel notation from section 4.2, to deduce

\[
 C(z)=\sum_{s=0}^{\infty}
 J_{2s+1/2}\!\left(\frac{\pi z^2}{2}\right),
 \qquad
 S(z)=\sum_{s=0}^{\infty}
 J_{2s+3/2}\!\left(\frac{\pi z^2}{2}\right).
\]

For this exercise the source prints \(\int_0^z\) but does not specify a path,
a homotopy class, or an admissible complex domain. Because \(J_\nu(t)\) is
generally branch-dependent and the endpoint \(t=0\) is exceptional in the
general-order definition, this transcription does not invent a straight-line
path or claim path independence. The integrand, its half-integral descendants,
and the Fresnel identities are recorded as inheriting a coherent principal or
continued branch from section 9.3; the path, endpoint semantics, cut behavior,
and exact domain remain open source-reconciliation questions.

Exercise 9.8 assumes \(a>0\), \(b>0\), \(\nu+1/2>0\), initially with
\(b<a\), and asks for

\[
 \int_0^\infty e^{-at}J_\nu(bt)t^\nu\,dt
 =\frac{\Gamma(\nu+1/2)(2b)^\nu}
 {\pi^{1/2}(a^2+b^2)^{\nu+1/2}}.
\]

It then asks that the restriction \(b<a\) be removed using Exercise 9.6 and
analytic continuation.

## Main exposition: modified first-kind function

For arbitrary \(\nu\) and \(z\neq0\), the source defines

\[
 I_\nu(z)=\left(\frac z2\right)^\nu
 \sum_{s=0}^{\infty}
 \frac{(z^2/4)^s}{s!\,\Gamma(\nu+s+1)}. \tag{10.01}
\]

Unless \(\nu\) is zero or an integer, this is multivalued in \(z\). Its
principal branch uses the principal value of \((z/2)^\nu\). Comparing the
series with (9.09), the source obtains

\[
 I_\nu(z)=e^{-\nu\pi i/2}J_\nu(iz), \tag{10.02}
\]

where the two sides have principal values when
\(\operatorname{ph}z=0\) and are then continued together. The accompanying
footnote warns that the principal-branch cuts of \(I_\nu(z)\) and
\(J_\nu(iz)\) are not the same.

Both \(I_\nu\) and \(I_{-\nu}\) satisfy the modified Bessel equation

\[
 w''+\frac1z w'-\left(1+\frac{\nu^2}{z^2}\right)w=0. \tag{10.03}
\]

The stated recurrences are

\[
 I_{\nu-1}(z)-I_{\nu+1}(z)=\frac{2\nu}{z}I_\nu(z),
 \qquad
 I_{\nu-1}(z)+I_{\nu+1}(z)=2I_\nu'(z), \tag{10.04}
\]

and therefore

\[
 I_{\nu+1}(z)=-\frac\nu zI_\nu(z)+I_\nu'(z),
 \qquad
 I_{\nu-1}(z)=\frac\nu zI_\nu(z)+I_\nu'(z). \tag{10.05}
\]

## Exercises 10.1-10.6: targets, not source assertions

Exercise 10.1 asks, for integral \(n\), to prove

\[
 I_n(z)=I_{-n}(z)=\frac1\pi\int_0^\pi
 e^{z\cos\theta}\cos(n\theta)\,d\theta.
\]

Exercise 10.2 refines the branch-sensitive rotation (10.02). With principal
branches it asks for

\[
 I_\nu(z)=e^{-\nu\pi i/2}J_\nu(iz),
 \qquad -\pi<\operatorname{ph}z\leq\frac\pi2,
\]

and

\[
 I_\nu(z)=e^{3\nu\pi i/2}J_\nu(iz),
 \qquad \frac\pi2<\operatorname{ph}z\leq\pi.
\]

Exercise 10.3 asks for the modified generating function

\[
 \exp\!\left\{\frac z2(h+h^{-1})\right\}
 =\sum_{n=-\infty}^{\infty}I_n(z)h^n,
 \qquad h\neq0.
\]

Exercise 10.4 sets

\[
 \xi=\frac23z^{3/2},\qquad W=z^{-1/2}w,
\]

and asks that the Airy equation (8.05) be transformed into

\[
 \frac{d^2W}{d\xi^2}+\frac1\xi\frac{dW}{d\xi}
 -\left(1+\frac1{9\xi^2}\right)W=0.
\]

It also asks for

\[
\begin{aligned}
 \operatorname{Ai}(z)
 &=\frac13z^{1/2}\{I_{-1/3}(\xi)-I_{1/3}(\xi)\},&
 \operatorname{Ai}(-z)
 &=\frac13z^{1/2}\{J_{-1/3}(\xi)+J_{1/3}(\xi)\},\\
 \operatorname{Ai}'(z)
 &=\frac13z\{I_{2/3}(\xi)-I_{-2/3}(\xi)\},&
 \operatorname{Ai}'(-z)
 &=\frac13z\{J_{2/3}(\xi)-J_{-2/3}(\xi)\}.
\end{aligned}
\]

The exercise specifies principal values at
\(\operatorname{ph}z=0\), with the functions elsewhere related by
continuity.

Exercise 10.5 asks for the mutually inverse-looking expansions

\[
 I_\nu(z)=\sum_{s=0}^{\infty}\frac{z^s}{s!}J_{\nu+s}(z),
 \qquad
 J_\nu(z)=\sum_{s=0}^{\infty}(-1)^s\frac{z^s}{s!}I_{\nu+s}(z),
\]

again with branches principal at \(\operatorname{ph}z=0\).

Exercise 10.6 introduces the Kelvin-function targets. It asks that
\(\operatorname{ber}_\nu x\), \(\operatorname{bei}_\nu x\),
\(\operatorname{ber}_{-\nu}x\), and
\(\operatorname{bei}_{-\nu}x\), defined through

\[
 \operatorname{ber}_\nu x\pm i\operatorname{bei}_\nu x
 =J_\nu(xe^{\pm3\pi i/4})
 =e^{\pm\nu\pi i/2}I_\nu(xe^{\pm\pi i/4}),
\]

satisfy

\[
 x^4w^{(4)}+2x^3w^{(3)}
 -(1+2\nu^2)(x^2w''-xw')
 +(\nu^4-4\nu^2+x^4)w=0.
\]

Because these names occur only inside an exercise on the inspected pages,
their promotion to source entities must remain separate from acceptance of
the \(J/I\) exposition.

## Convention, branch, and open-question log

1. The printed argument order is \(J_\nu(z)\) and \(I_\nu(z)\): order first
   as a subscript, spatial argument second in parentheses.
2. The source first gives a single-valued entire \(J_n(z)\) for integral
   order, then a branch-dependent \(J_\nu(z)\) for general order. These must
   not be collapsed into one unrestricted principal-power theorem at \(z=0\).
3. Equations (9.09) and (10.01) exclude \(z=0\) from the general-order
   definition as stated. Origin values and limiting behavior depend on the
   order and require separate continuation statements.
4. Reciprocal Gamma makes initial terms vanish at negative integral order.
   A later Lean specification must express those zeros without treating
   division by a Gamma pole as ordinary field division.
5. The normalized kernels in (9.09) and (10.01) are asserted entire in their
   variables, while the prefactor creates the \(z\)-branching. Spatial and
   order regularity therefore need distinct public statements.
6. Formula (9.10) records analytic continuation between branches. Exercise
   10.2 separately records what happens when both sides are evaluated using
   principal branches on two phase ranges. These statements are related but
   not interchangeable.
7. The phase notation \(\operatorname{ph}z\) is local source notation. The
   pages do not define a global argument function, and boundary choices in
   Exercise 10.2 must be preserved exactly.
8. The Schlaefli contours in (9.12)-(9.13) have orientations, powers, and
   continuation conventions that belong to any formal integral statement.
   The omitted Fig. 9.1 is not reconstructed here.
9. The ODEs (9.11) and (10.03) have two-dimensional solution spaces. They do
   not identify \(J_\nu\) or \(I_\nu\) without the series normalization and
   branch data.
10. The recurrences divide by \(z\); their displayed form is not an origin
    theorem. Equivalent division-free forms should be retained for origin
    reasoning.
11. Every item in the two exercise sections remains an exercise target until
    separately proved and reviewed. In particular, Exercise 10.2 is direct
    source evidence for intended branch behavior, not a theorem established
    on these pages.
12. Exercise 9.7 depends on the source's earlier Fresnel normalizations, and
    Exercise 10.4 depends on the Chapter 2 Airy normalization. Those entity
    links remain provisional.
13. Exercise 10.6 is the first locked-page occurrence in this bounded scan of
    the Kelvin names. Whether each sign/order variant is a separate canonical
    entity requires the project-wide identity audit.
14. Exercises 9.3-9.7 inherit the principal or coherently continued branch
    convention of section 9.3, but do not restate their full admissible
    domains. In particular, Exercise 9.7 leaves the complex path from \(0\) to
    \(z\) unresolved; no path or path-independence assertion is supplied here.

## Scope boundary

The Airy material and Exercise 8.1 above the section-9 heading on printed
p. 55 belong to the existing Chapter 2 Airy transcription and are excluded
here. Fig. 9.1 is not reproduced. Section 11, beginning on printed p. 61, is
outside scope. No formula from Chapter 7, DLMF, or memory has been used to fill
an omitted definition or continuation theorem.

## Atomic occurrence-planning queue

This section is planning metadata only. It proposes no CSV edit, confirmed
association, theorem-card registration, or manifest membership. The
transcription file is a shared artifact, not one canonical occurrence. Every
row below is a distinct provisional occurrence with scalar kind, target, role,
and evidence fields. All rows inherit edition `olver_1997b`, snapshot
`SRC-OLV-1997-USER-PDF-20260905`, queue class `seed`, resolution
`transcribed_unreconciled`, reconciliation `unresolved`, and novelty class
`source_recovery`. IDs are provisional until inventory review.

### Numbered formulas and properties

| Provisional occurrence ID | Printed item | Source kind | Target class | Context role | Evidence |
| --- | --- | --- | --- | --- | --- |
| `OLV97-C02-BES-J-F0901` | (9.01) | body_definition | source_definition | integer-order \(J_n\) integral | direct_formula |
| `OLV97-C02-BES-J-F0902` | (9.02) | displayed_formula | source_formula | integer-order exponential integral | direct_formula |
| `OLV97-C02-BES-J-F0903` | (9.03) | displayed_formula | source_formula | integer-order contour integral | direct_formula |
| `OLV97-C02-BES-J-F0904` | (9.04) | displayed_formula | source_formula | nonnegative-integer Maclaurin series | direct_formula |
| `OLV97-C02-BES-J-F0905` | (9.05) | displayed_formula | source_formula | integer negative-order connection | direct_formula |
| `OLV97-C02-BES-J-F0906` | (9.06) | displayed_formula | source_formula | Laurent generating function | direct_formula |
| `OLV97-C02-BES-J-F0907` | (9.07) | displayed_formula | source_formula | differential identity | direct_formula |
| `OLV97-C02-BES-J-F0908` | (9.08) | displayed_formula | source_formula | integer-order Bessel equation | direct_formula |
| `OLV97-C02-BES-J-F0909` | (9.09) | body_definition | source_definition | general-order \(J_\nu\) series | direct_formula |
| `OLV97-C02-BES-J-F0910` | (9.10) | displayed_formula | source_formula | branch-continuation rule | direct_formula |
| `OLV97-C02-BES-J-F0911` | (9.11) | displayed_formula | source_formula | general-order Bessel equation | direct_formula |
| `OLV97-C02-BES-J-F0912` | (9.12) | displayed_formula | source_formula | Hankel-loop Schlaefli integral | direct_formula |
| `OLV97-C02-BES-J-F0913` | (9.13) | displayed_formula | source_formula | \(\tau\)-contour Schlaefli integral | direct_formula |
| `OLV97-C02-BES-J-F0914` | (9.14) | displayed_formula | source_formula | order recurrence | direct_formula |
| `OLV97-C02-BES-J-F0915` | (9.15) | displayed_formula | source_formula | derivative recurrence | direct_formula |
| `OLV97-C02-BES-J-F0916` | (9.16) | displayed_formula | source_formula | solved order/derivative recurrences | direct_formula |
| `OLV97-C02-BES-I-F1001` | (10.01) | body_definition | source_definition | general-order \(I_\nu\) series | direct_formula |
| `OLV97-C02-BES-I-F1002` | (10.02) | displayed_formula | source_formula | \(I/J\) rotation and continuation | direct_formula |
| `OLV97-C02-BES-I-F1003` | (10.03) | displayed_formula | source_formula | modified Bessel equation | direct_formula |
| `OLV97-C02-BES-I-F1004` | (10.04) | displayed_formula | source_formula | modified order/derivative recurrences | direct_formula |
| `OLV97-C02-BES-I-F1005` | (10.05) | displayed_formula | source_formula | solved modified recurrences | direct_formula |
| `OLV97-C02-BES-J-PROP-INT-ENTIRE` | prose after (9.01) | source_property | qualitative_support | integer-order entireness in \(z\) | direct_prose |
| `OLV97-C02-BES-J-PROP-CONTOUR-DEFORM` | prose after (9.03) | source_property | qualitative_support | contour-deformation invariance | direct_prose |
| `OLV97-C02-BES-J-PROP-MAC-DERIV` | unnumbered formulas before (9.04) | displayed_formula | source_formula | derivatives at the origin | direct_formula |
| `OLV97-C02-BES-J-PROP-GENFUN-CONV` | prose after (9.06) | source_property | qualitative_support | Laurent-series convergence | direct_prose |
| `OLV97-C02-BES-J-PROP-NORM-LOCAL` | prose after (9.09) | source_property | qualitative_support | locally uniform normalized-series convergence | direct_prose |
| `OLV97-C02-BES-J-PROP-NORM-ENTIRE` | prose after (9.09) | source_property | qualitative_support | normalized-kernel entireness | direct_prose |
| `OLV97-C02-BES-J-PROP-ORDER-ENTIRE` | prose after (9.09) | source_property | qualitative_support | entire order dependence for \(z\neq0\) | direct_prose |
| `OLV97-C02-BES-J-PROP-Z-MULTI` | prose after (9.09) | source_property | qualitative_support | general-order multivaluedness in \(z\) | direct_prose |
| `OLV97-C02-BES-J-PROP-SCHLAEFLI-DOM` | prose after (9.13) | source_property | qualitative_support | analytic-continuation phase domain | direct_prose |
| `OLV97-C02-BES-J-PROP-REC-CONT` | prose after (9.15) | source_property | qualitative_support | removal of the phase restriction from (9.14) | direct_prose |
| `OLV97-C02-BES-J-PROP-J0-DERIV` | unnumbered formula after (9.16) | displayed_formula | source_formula | \(J_0'=-J_1\) specialization | direct_formula |
| `OLV97-C02-BES-I-PROP-Z-MULTI` | prose after (10.01) | source_property | qualitative_support | general-order multivaluedness in \(z\) | direct_prose |

### Exercises

| Provisional occurrence ID | Printed item | Source kind | Target class | Context role | Evidence |
| --- | --- | --- | --- | --- | --- |
| `OLV97-C02-BES-J-EX0901` | Exercise 9.1 | exercise | exercise_target | generating-function specializations | direct_formula |
| `OLV97-C02-BES-J-EX0902` | Exercise 9.2 | exercise | exercise_target | Neumann addition and square sum | direct_formula |
| `OLV97-C02-BES-J-EX0903` | Exercise 9.3 | exercise | exercise_target | half-integral formulas with inherited branch | direct_formula |
| `OLV97-C02-BES-J-EX0904` | Exercise 9.4 | exercise | exercise_target | iterated derivative identities with inherited branch | direct_formula |
| `OLV97-C02-BES-J-EX0905` | Exercise 9.5 | exercise | exercise_target | Poisson integral with inherited branch | direct_formula |
| `OLV97-C02-BES-J-EX0906` | Exercise 9.6 | exercise | exercise_target | complex-argument bounds | direct_formula |
| `OLV97-C02-BES-J-EX0907` | Exercise 9.7 | exercise | exercise_target | unresolved-path integral and Fresnel sums | direct_formula |
| `OLV97-C02-BES-J-EX0908` | Exercise 9.8 | exercise | exercise_target | Laplace-Bessel integral | direct_formula |
| `OLV97-C02-BES-I-EX1001` | Exercise 10.1 | exercise | exercise_target | integer-order real integral | direct_formula |
| `OLV97-C02-BES-I-EX1002` | Exercise 10.2 | exercise | exercise_target | principal-branch phase ranges | direct_formula |
| `OLV97-C02-BES-I-EX1003` | Exercise 10.3 | exercise | exercise_target | modified generating function | direct_formula |
| `OLV97-C02-BES-I-EX1004` | Exercise 10.4 | exercise | exercise_target | Airy transformation and connection formulas | direct_formula |
| `OLV97-C02-BES-I-EX1005` | Exercise 10.5 | exercise | exercise_target | \(I/J\) series transforms | direct_formula |
| `OLV97-C02-BES-I-EX1006` | Exercise 10.6 | exercise | exercise_target | Kelvin definitions and fourth-order equation | direct_formula |

### Figure, footnotes, and substantive cross-references

| Provisional occurrence ID | Printed item | Source kind | Target class | Context role | Evidence |
| --- | --- | --- | --- | --- | --- |
| `OLV97-C02-BES-J-FIG0901` | Fig. 9.1 | figure | source_auxiliary_geometry | omitted \(\tau\)-contour figure | direct_figure |
| `OLV97-C02-BES-J-FN0901` | footnote under section 9.3 | footnote | qualitative_support | failure of (9.01) at general order | direct_prose |
| `OLV97-C02-BES-I-FN1001` | footnote after (10.02) | footnote | qualitative_support | unequal principal cuts for \(I_\nu(z)\) and \(J_\nu(iz)\) | direct_prose |
| `OLV97-C02-BES-I-XREF-EX1002` | Exercise 10.2 pointer in the (10.02) footnote | cross_reference | source_reference | principal-cut comparison | direct_prose |
| `OLV97-C02-BES-J-XREF-T11` | Theorem 1.1 reference after (9.01) | cross_reference | source_reference | entireness proof provenance | direct_prose |
| `OLV97-C02-BES-J-XREF-GAMMA` | equation (1.12) reference around (9.12) | cross_reference | source_reference | reciprocal-Gamma loop provenance | direct_prose |
| `OLV97-C02-BES-J-XREF-CH7E719` | equation (7.19) comparison after (9.12) | cross_reference | source_reference | earlier Schlaefli comparison | direct_prose |
| `OLV97-C02-BES-J-XREF-T81` | Theorem 8.1 reference before (9.12) | cross_reference | source_reference | sum-integral interchange provenance | direct_prose |
| `OLV97-C02-BES-J-XREF-FRESNEL` | section 4.2 reference in Exercise 9.7 | cross_reference | source_reference | Fresnel normalization dependency | direct_prose |
| `OLV97-C02-BES-I-XREF-AIRY` | equation (8.05) reference in Exercise 10.4 | cross_reference | source_reference | Airy-equation dependency | direct_prose |
| `OLV97-C02-BES-I-XREF-CH7` | Chapter 7 pointer after (10.05) | cross_reference | source_reference | later cylinder-family development | direct_prose |

### Provisional entity split

| Proposed entity | Mathematical role | Unresolved point |
| --- | --- | --- |
| `bessel_j` | first-kind Bessel family \(J_\nu(z)\) | integral/general-order/origin regimes and branch bridge |
| `bessel_j_integer_generating_basis` | integer-index Laurent family in (9.06) | whether this is an entity or only a property of `bessel_j` |
| `modified_bessel_i` | modified first-kind family \(I_\nu(z)\) | origin regimes and exact principal-cut semantics |
| `schlaefli_j_contours` | contour family in (9.12)-(9.13) | exact low-level contour representation and equivalence |
| `kelvin_ber` and `kelvin_bei` | exercise-defined Kelvin functions | sign/order alias policy and later body occurrences |

The Gamma, Airy, and Fresnel objects are provisional dependencies, not new
entity proposals here.

### Provisional downstream card links

The following identifiers already occur in the Bessel family plan. Their
appearance here is only a proposed evidence link; none is registered,
authorized, or selected into a manifest by this transcription.

| Provisional card ID | Possible use of this collation |
| --- | --- |
| `DEF-BES-001` | \(J\) construction/identification, series, branch, integer order, and origin split |
| `DEF-BES-002` | \(I\) construction/identification, series, rotation, and modified equation |
| `ANA-BES-001` | order regularity needed beyond the locally uniform series assertion |
| `DEF-BES-007` | only if a reviewed entity audit selects a finite set of Kelvin/scaled normalizations |
| `AUD-BES-001` | expanded power-of-two, alternating-sign, negative-order, branch, rotation, ODE, and recurrence checks |

No theorem card is created by this file, and these IDs remain provisional.
