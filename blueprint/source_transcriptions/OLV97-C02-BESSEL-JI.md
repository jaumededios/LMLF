# OLV97-C02-BESSEL-JI - planning mathematical transcription

**Status:** planning-only first collation; transcribed-unreconciled;
independent review pending
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

Exercise 9.5 asks for Poisson's integral

\[
 J_\nu(z)=
 \frac{(z/2)^\nu}{\pi^{1/2}\Gamma(\nu+1/2)}
 \int_0^\pi \cos(z\cos\theta)\sin^{2\nu}\theta\,d\theta,
 \qquad \operatorname{Re}\nu>-\frac12,
\]

and for a direct verification that this integral satisfies (9.11).

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

## Scope boundary

The Airy material and Exercise 8.1 above the section-9 heading on printed
p. 55 belong to the existing Chapter 2 Airy transcription and are excluded
here. Fig. 9.1 is not reproduced. Section 11, beginning on printed p. 61, is
outside scope. No formula from Chapter 7, DLMF, or memory has been used to fill
an omitted definition or continuation theorem.

## Inventory integration proposal

This section is planning metadata only. It proposes no CSV edit, confirmed
association, theorem-card registration, or manifest membership.

### Occurrence proposal

| Field | Proposed value |
| --- | --- |
| occurrence_id | OLV97-C02-BESSEL-JI |
| edition_id | olver_1997b |
| source_snapshot_id | SRC-OLV-1997-USER-PDF-20260905 |
| queue_class | seed |
| chapter, section | 2, 9.1-10.1 plus Exercises 9.1-9.8 and 10.1-10.6 |
| printed pages | 55-61 |
| locator | Ch. 2 sections 9-10, eqs. (9.01)-(9.16), (10.01)-(10.05), and printed exercises in range |
| printed label | The Bessel Function \(J_\nu(z)\); The Modified Bessel Function \(I_\nu(z)\) |
| source kind | body_definition with separately marked exercise targets |
| target class | source_definition |
| novelty class | source_recovery |
| evidence | direct_formula |
| resolution | transcribed_unreconciled |
| transcription status | mathematical_transcription |
| reconciliation | unresolved; independent page, formula, branch, and entity review required |

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
