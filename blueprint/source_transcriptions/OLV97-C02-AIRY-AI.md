# OLV97-C02-AIRY-AI - planning mathematical transcription

**Status:** planning-only first collation; independent review pending
**Edition:** F. W. J. Olver, *Asymptotics and Special Functions*, corrected
A K Peters reprint, 1997, ISBN 1-56881-069-5
**Source snapshot:** SRC-OLV-1997-USER-PDF-20260905
**Snapshot SHA-256:**
08e1844d29a5ad21f89b9b600249ce18ac1665a5845be2d4e4219a3ededdc909
**Source location:** Chapter 2, sections 8.1-8.3, printed pp. 53-55;
PDF pages 66-68; equations (8.01)-(8.06)

This is a formula-level transcription in new prose. It contains no scan,
page image, extracted page text, or claim of source reconciliation. It is not
a theorem card and does not authorize implementation.

## Checked page map

| Printed page | PDF page | Located material |
| --- | ---: | --- |
| 53 | 66 | section 8.1; real integral (8.01); contour continuation (8.02) begins |
| 54 | 67 | continuation of (8.02); section 8.2; Maclaurin series (8.03) |
| 55 | 68 | initial values (8.04); section 8.3; ODE (8.05); rotation relation (8.06) |

## Real integral and analytic continuation

For a real argument \(x\), the source begins with the improper oscillatory
integral

\[
 \operatorname{Ai}(x)=\frac1\pi\int_0^\infty
 \cos\!\left(\frac{t^3}{3}+xt\right)\,dt. \tag{8.01}
\]

The convergence asserted at this point is caused by oscillation, not decay of
the integrand. Thus (8.01) is not presented as an absolutely convergent
integral.

After putting \(t=v/i\), the same real-axis value is expressed first on the
imaginary axis and then as a single exponential integral:

\[
 \operatorname{Ai}(x)
 =\frac1{\pi i}\int_0^{i\infty}
   \cosh\!\left(\frac{v^3}{3}-xv\right)\,dv
 =\frac1{2\pi i}\int_{-i\infty}^{i\infty}
   \exp\!\left(\frac{v^3}{3}-xv\right)\,dv.
\]

For a complex argument \(z\), contour deformation gives

\[
 \operatorname{Ai}(z)=\frac1{2\pi i}\int_{\mathcal L}
 \exp\!\left(\frac{v^3}{3}-zv\right)\,dv. \tag{8.02}
\]

The orientation of \(\mathcal L\) is from an infinite endpoint in

\[
 -\frac\pi2\leq \operatorname{ph}v\leq-\frac\pi6
\]

to an infinite endpoint in the conjugate sector. For the global analytic
continuation argument the endpoints are kept away from the sector boundaries:
for an arbitrary sufficiently small positive \(\delta\), which may be taken
with \(0<\delta<\pi/6\), the initial end lies in

\[
 -\frac\pi2+\delta\leq \operatorname{ph}v
 \leq-\frac\pi6-\delta,
\]

and the terminal end lies in its conjugate sector. With such a contour the
integral is stated to converge absolutely and uniformly for \(z\) in compact
subsets of the plane. The resulting continuation is entire.

## Local normalization at zero

The Maclaurin expansion is grouped according to powers congruent to \(0\) and
\(1\) modulo \(3\):

\[
\begin{aligned}
 \operatorname{Ai}(z)
 ={}&\operatorname{Ai}(0)
 \left(1+\frac{z^3}{3!}+\frac{1\cdot4}{6!}z^6
       +\frac{1\cdot4\cdot7}{9!}z^9+\cdots\right)\\
 &+\operatorname{Ai}'(0)
 \left(z+\frac2{4!}z^4+\frac{2\cdot5}{7!}z^7
       +\frac{2\cdot5\cdot8}{10!}z^{10}+\cdots\right).
 \tag{8.03}
\end{aligned}
\]

The two constants are

\[
 \operatorname{Ai}(0)
 =\frac{\Gamma(1/3)}{2\pi\,3^{1/6}}
 =\frac1{3^{2/3}\Gamma(2/3)},
 \qquad
 \operatorname{Ai}'(0)
 =-\frac{3^{1/6}\Gamma(2/3)}{2\pi}
 =-\frac1{3^{1/3}\Gamma(1/3)}. \tag{8.04}
\]

Here every fractional power of \(3\) is a positive real power. No complex
power choice is needed for these normalizing constants.

## Differential equation and rotations

Differentiating (8.02) under the integral sign yields a vanishing contour
boundary term and the equation

\[
 \frac{d^2w}{dz^2}=zw. \tag{8.05}
\]

The entire function \(w(z)=\operatorname{Ai}(z)\) is one solution. If
\(\rho=e^{2\pi i/3}\), then \(\rho^3=1\), so the two argument rotations

\[
 z\longmapsto \rho z,
 \qquad z\longmapsto \rho^{-1}z
\]

give two more solutions, \(\operatorname{Ai}(\rho z)\) and
\(\operatorname{Ai}(\rho^{-1}z)\). The exact linear dependence printed in the
source is

\[
 \operatorname{Ai}(z)
 +\rho\,\operatorname{Ai}(\rho z)
 +\rho^{-1}\operatorname{Ai}(\rho^{-1}z)=0. \tag{8.06}
\]

These rotations use fixed exponential constants; they do not involve a
choice of a cube-root branch as a function of \(z\).

## Convention and ambiguity log

1. In (8.01), the integral is an improper oscillatory real integral. A
   totalized Lebesgue or Bochner integral would not by itself encode the
   source's convergence claim.
2. The source writes “ph \(v\)” for contour directions. The displayed sector
   data determine endpoint rays modulo \(2\pi\), but a globally selected
   argument function is neither used nor needed by the exponential integrand.
3. Equation (8.02) allows a family of admissible oriented contours. A later
   formal statement must decide whether contour independence is part of the
   definition or an identification theorem for one fixed contour.
4. The endpoint sectors in the first statement include their boundaries; the
   compact-uniform continuation argument subsequently uses the strict
   \(\delta\)-interior sectors. These are distinct convergence assertions.
5. A prime in (8.03)-(8.04) means differentiation in the displayed Airy
   argument. It is not a derivative in a scaled turning-point variable.
6. The ODE plus entireness alone does not identify \(\operatorname{Ai}\); the
   integral or the two initial values supply the normalization.
7. The linear relation (8.06) fixes both the direction of argument rotation
   and the coefficients multiplying the rotated values. Reversing only one of
   those choices gives a different formula.
8. The source's \(\Gamma\)-normalization is locally clear at the positive real
   arguments \(1/3\) and \(2/3\), but the project-wide Gamma entity link still
   requires independent reconciliation.

## Scope boundary

The general interchange theorem printed between (8.02) and (8.03) is not an
Airy entity and is not transcribed here. The contour-decay estimates used to
justify deformation are summarized only to fix endpoint sectors. The Bessel
section beginning later on printed p. 55 is outside this occurrence.

## Inventory integration record

The normalized inventory records the occurrence, entities, notations, and
provisional links below. This registration is planning metadata only: every
source and normalization status remains unreviewed and no theorem card or
manifest membership follows from it.

### Occurrence proposal

| Field | Recorded value |
| --- | --- |
| occurrence_id | OLV97-C02-AIRY-AI |
| edition_id | olver_1997b |
| source_snapshot_id | SRC-OLV-1997-USER-PDF-20260905 |
| queue_class | later_family |
| chapter, section | 2, 8.1-8.3 |
| printed pages | 53-55 |
| locator | Ch. 2 sections 8.1-8.3, eqs. (8.01)-(8.06) |
| printed label | The Airy Integral |
| source_kind | body_definition |
| target_class | source_definition |
| novelty_class | source_recovery |
| evidence | direct_formula |
| resolution | transcribed_unreconciled |
| transcription status | mathematical_transcription |
| reconciliation | unresolved; independent source and semantics review required |

### Entity records

| Entity ID | Canonical label | Kind | Recorded status |
| --- | --- | --- | --- |
| airy_ai | Airy function \(\operatorname{Ai}\) | named special function | provisional identity; normalization transcribed |
| airy_ai_contour_family | admissible \(\operatorname{Ai}\) contours | source auxiliary geometry | provisional; contour-equivalence policy unresolved |

The existing gamma entity is a proposed provisional dependency, not a new
entity row.

### Notation records

| Notation ID | Entity | Printed symbol | Domain, role, and unresolved point |
| --- | --- | --- | --- |
| OLV97-N-AIR-AI | airy_ai | \(\operatorname{Ai}(x),\operatorname{Ai}(z)\) | real oscillatory baseline, then entire continuation; normalization is (8.04) |
| OLV97-N-AIR-L | airy_ai_contour_family | \(\mathcal L\) | oriented from the lower sector to its conjugate; boundary versus strict-sector convergence must stay distinct |
| OLV97-N-AIR-ROT | airy_ai | \(\operatorname{Ai}(ze^{\pm2\pi i/3})\) | fixed argument rotations and value coefficients in (8.06) |
| OLV97-N-AIR-PRIME | airy_ai | \(\operatorname{Ai}'(z)\) | derivative with respect to the Airy argument |
| OLV97-N-AIR-GAMMA | gamma | \(\Gamma(1/3),\Gamma(2/3)\) | positive-real Gamma values in (8.04); entity link remains provisional |

All notation rows use the snapshot above, evidence type `direct_formula`,
resolution status `normalization_unresolved`, and transcription status
`mathematical_transcription`.
