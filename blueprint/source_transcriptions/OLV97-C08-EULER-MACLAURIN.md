# OLV97-C08-EULER-MACLAURIN - mathematical transcription

**Status:** planning-only first collation; independent source review pending
**Coverage effect:** none; normalized inventory rows remain provisional and
this transcription does not create a card, manifest membership, or coverage
**Edition:** F. W. J. Olver, *Asymptotics and Special Functions*, corrected
A K Peters reprint, 1997, ISBN 1-56881-069-5
**Source snapshot:** `SRC-OLV-1997-USER-PDF-20260905`
**Source PDF SHA-256:**
`08e1844d29a5ad21f89b9b600249ce18ac1665a5845be2d4e4219a3ededdc909`
**Source location:** Chapter 8, section 1, printed pp. 279-284; PDF pages
292-297
**Collated boundary:** the unnumbered setup and equations (1.01)-(1.13), ending
before section 2.1

This file records mathematical content and conventions in new prose. It does
not reproduce the book's surrounding exposition, figures, exercises, or page
images. The source bytes and rendered inspection images are not repository
artifacts.

## Page and equation map

| Printed page | PDF page | Material checked |
|---:|---:|---|
| 279 | 292 | Half-weighted sum \(S\), integral \(I\), first cellwise integration by parts, definition of \(\omega_1\), and the first exact \(S-I\) identity |
| 280 | 293 | Figure 1.1 and equations (1.01)-(1.03), including the zero-mean choice for the primitives \(\omega_s\) |
| 281 | 294 | Finite Euler-Maclaurin identity (1.04), generating function (1.05), Bernoulli-polynomial definition (1.06), and periodic normalization (1.07) |
| 282 | 295 | Bernoulli-number generating function (1.08), coefficient formula (1.09), reflection (1.10), recurrence (1.11), and low-index values |
| 283 | 296 | Theorem 1.1, midpoint formula (1.12), and even-zeta formula (1.13), whose proof continues on the next page |
| 284 | 297 | End of the proof of (1.13) and Exercises 1.1-1.5; section 2.1 begins at the foot of the page and is excluded |

## Endpoint convention and the first exact identity

Let \(a,n\in\mathbb Z\) with \(a<n\). The source begins with the
half-weighted finite sum

\[
 S:=\frac12 f(a)+\sum_{k=a+1}^{n-1}f(k)+\frac12 f(n),
 \qquad
 I:=\int_a^n f(x)\,dx.
\]

The interior sum is empty when \(n=a+1\). Thus neither endpoint belongs to the
sum with full weight.

For an integer \(j\), integration by parts on one unit interval gives

\[
 \int_j^{j+1}f(x)\,dx
 =\left[(x-j-\tfrac12)f(x)\right]_{j}^{j+1}
  -\int_j^{j+1}(x-j-\tfrac12)f'(x)\,dx.
\]

Write \([x]\) for the integer in \((x-1,x]\), including when \(x<0\). This is
the usual floor, and the fractional part \(\{x\}:=x-[x]\) lies in
\([0,1)\). Define

\[
 \omega _1(x):=x-[x]-\frac12=\{x\}-\frac12.
\]

Then

\[
 \frac12f(j)+\frac12f(j+1)
 =\int_j^{j+1}f(x)\,dx
  +\int_j^{j+1}\omega _1(x)f'(x)\,dx,
\]

and summing over \(j=a,\ldots,n-1\) yields the exact identity

\[
 S=I+\int_a^n\omega _1(x)f'(x)\,dx.
\]

The periodic saw-tooth function has period one and jumps at the integers. The
floor convention fixes its point value at every integer as
\(\omega_1(k)=-\tfrac12\); its left limit there is \(+\tfrac12\). This
point-value convention is invisible to the displayed integrals but matters to
pointwise normalization.

## Periodic primitives and the finite Euler-Maclaurin identity

The next periodic primitive is introduced by

\[
 \omega _2(x)=\int \omega _1(x)\,dx, \tag{1.01}
\]

with the primitive chosen to be continuous. Since the integral of
\(\omega_1\) over a unit interval is zero, \(\omega_2\) is periodic. Its
remaining additive constant is fixed by requiring zero mean on one period.
The construction continues, for \(s\ge2\), through

\[
 \omega _s(x)=\int\omega _{s-1}(x)\,dx, \tag{1.02}
\]

\[
 \int_0^1\omega _s(x)\,dx=0. \tag{1.03}
\]

Here an indefinite integral denotes a primitive; (1.03) fixes its constant.
In particular, \(\omega_s\) is periodic, and on each open unit interval its
derivative is \(\omega_{s-1}\).

For any positive integer \(m\), repeated cellwise integration by parts gives

\[
\begin{aligned}
 \frac12f(j)+\frac12f(j+1)
 &=\int_j^{j+1}f(x)\,dx \\
 &\quad+\sum_{s=1}^{m-1}(-1)^{s+1}\omega_{s+1}(0)
   \bigl(f^{(s)}(j+1)-f^{(s)}(j)\bigr) \\
 &\quad+(-1)^{m+1}\int_j^{j+1}
   \omega_m(x)f^{(m)}(x)\,dx.
\end{aligned}
\]

Summing the endpoint differences telescopes and gives the source's finite
Euler-Maclaurin formula

\[
\boxed{
 S=I+\sum_{s=1}^{m-1}(-1)^{s+1}\omega_{s+1}(0)
   \bigl(f^{(s)}(n)-f^{(s)}(a)\bigr)+R_m(f;a,n)
} \tag{1.04}
\]

with exact remainder

\[
 R_m(f;a,n):=(-1)^{m+1}\int_a^n
   \omega_m(x)f^{(m)}(x)\,dx. \tag{EM-remainder}
\]

For \(m=1\), the finite correction sum is empty and this reduces to the first
exact identity above. Equation (1.04) is an identity, not merely an asymptotic
expansion, and this part of the source supplies no remainder inequality.

For comparison with a half-open finite-sum API, a direct rearrangement of the
source convention is

\[
\begin{aligned}
 \sum_{k=a}^{n-1}f(k)
 &=\int_a^n f(x)\,dx+\frac{f(a)-f(n)}2 \\
 &\quad+\sum_{s=1}^{m-1}(-1)^{s+1}\omega_{s+1}(0)
   \bigl(f^{(s)}(n)-f^{(s)}(a)\bigr)+R_m(f;a,n).
\end{aligned} \tag{EM-half-open}
\]

This last display is a convention conversion extracted from (1.04); it is not
a separately numbered formula in the source.

## Smoothness actually stated and used

The printed setup calls \(f\) “slowly varying,” but gives no formal smoothness
class. It then lets \(m\) be an arbitrary positive integer and uses derivatives
through \(f^{(m)}\) in repeated integrations by parts on every interval
\([j,j+1]\).

A simple sufficient hypothesis for a formal restatement is
\(f\in C^m([a,n])\). A weaker standard interface would require derivatives
through order \(m-1\) to be continuous with the top derivative absolutely
continuous (or an equivalent cellwise integration-by-parts hypothesis), plus
integrability of the displayed remainder integrand. Neither replacement is
printed in the source and must be labelled as a formalization choice. The
source also does not state whether \(f\) is real- or complex-valued.

## Generating function for the periodic functions

Set \(\omega_0(x):=1\). For \(0\le x<1\), the source constructs

\[
 \frac{t e^{xt}}{e^t-1}
 =\sum_{s=0}^{\infty}\omega_s(x)t^s. \tag{1.05}
\]

As a power series in complex \(t\), the nearest nonzero singularities occur at
\(t=\pm2\pi i\). The accompanying argument therefore justifies (1.05) for
\(|t|<2\pi\). The following sentence asserts uniformity with respect to \(x\)
in what it calls the “unit disk” and uses this to validate the preceding
coefficient construction. No convergence claim on \(|t|=2\pi\) is needed
here.

## Bernoulli normalization and the \(B_1\) convention

The Bernoulli polynomials are defined by the exponential generating function

\[
 \frac{t e^{xt}}{e^t-1}
 =\sum_{s=0}^{\infty}B_s(x)\frac{t^s}{s!},
 \qquad |t|<2\pi. \tag{1.06}
\]

Comparison with (1.05), followed by periodic extension, gives

\[
 s!\,\omega_s(x)=B_s(x-[x])=B_s(\{x\}). \tag{1.07}
\]

On the same page the source states the fundamental derivative identity

\[
 B_s'(x)=sB_{s-1}(x)\qquad(s\ge1). \tag{Bernoulli-derivative}
\]

The displayed range is part of the source statement. The algebraic formula
has a harmless zero-factor extension at \(s=0\), but that extension is not
attributed to the printed range.

The Bernoulli numbers are \(B_s:=B_s(0)\), with generating function

\[
 \frac{t}{e^t-1}
 =\sum_{s=0}^{\infty}B_s\frac{t^s}{s!}. \tag{1.08}
\]

Consequently the source uses

\[
 B_0=1,\qquad B_1=-\frac12,
\]

and every odd \(B_s\) with \(s\ge3\) vanishes. This is the negative-\(B_1\)
convention. In particular,

\[
 B_1(x)=x-\frac12,
 \qquad
 \omega_1(k)=B_1(0)=-\frac12\quad(k\in\mathbb Z).
\]

The polynomial coefficient formula is

\[
 B_s(x)=\sum_{j=0}^{s}\binom{s}{j}B_{s-j}x^j. \tag{1.09}
\]

Reflection about \(x=\tfrac12\) gives

\[
 B_s(1-x)=(-1)^sB_s(x). \tag{1.10}
\]

For \(s\ge2\), the source records \(B_s(1)=B_s\). Setting \(x=1\) in
(1.09) then gives the recurrence

\[
 B_{s-1}=-\frac1s\sum_{j=0}^{s-2}\binom{s}{j}B_j,
 \qquad s\ge2. \tag{1.11}
\]

The displayed low-index audit is

\[
 B_0=1,\quad B_1=-\frac12,\quad B_2=\frac16,\quad
 B_4=-\frac1{30},\quad B_6=\frac1{42},\quad
 B_8=-\frac1{30},\quad B_{10}=\frac5{66}.
\]

The source identifies this as Nörlund's convention and warns of an older
notation in which its \(B_{2s}\) is written \((-1)^{s-1}B_s\). That older
symbol therefore changes both the displayed suffix and the sign convention;
it must not be mixed with the \(B_s\) defined by (1.08).

The first polynomials shown are

\[
\begin{aligned}
 B_0(x)&=1,\\
 B_1(x)&=x-\tfrac12,\\
 B_2(x)&=x^2-x+\tfrac16,\\
 B_3(x)&=x^3-\tfrac32x^2+\tfrac12x,\\
 B_4(x)&=x^4-2x^3+x^2-\tfrac1{30},\\
 B_5(x)&=x^5-\tfrac52x^4+\tfrac53x^3-\tfrac16x,\\
 B_6(x)&=x^6-3x^5+\tfrac52x^4-\tfrac12x^2+\tfrac1{42}.
\end{aligned}
\]

Substituting (1.07) into (1.04) gives the following exact consequence of the
collated formulas:

\[
\begin{aligned}
 S
 &=I+\sum_{s=1}^{m-1}(-1)^{s+1}\frac{B_{s+1}}{(s+1)!}
   \bigl(f^{(s)}(n)-f^{(s)}(a)\bigr)\\
 &\quad+\frac{(-1)^{m+1}}{m!}\int_a^n
   B_m(\{x\})f^{(m)}(x)\,dx.
\end{aligned} \tag{EM-Bernoulli-rewrite}
\]

For \(m=2p\), odd Bernoulli-number vanishing reduces this to

\[
\begin{aligned}
 S
 &=I+\sum_{r=1}^{p}\frac{B_{2r}}{(2r)!}
   \bigl(f^{(2r-1)}(n)-f^{(2r-1)}(a)\bigr)\\
 &\quad-\frac1{(2p)!}\int_a^n
   B_{2p}(\{x\})f^{(2p)}(x)\,dx.
\end{aligned} \tag{EM-even-rewrite}
\]

These two rewrites use only information already present in section 1. They are
not equation labels from the book, and they do not import the standardized
presentation that starts in section 2.1.

## Bernoulli polynomial bounds and the even-zeta value

Theorem 1.1 states that, on the real interval \([0,1]\) and for \(s\ge1\):

1. the only zeros of \(B_{2s}(x)-B_{2s}\) are \(0\) and \(1\);
2. the only zeros of \(B_{2s+1}(x)\) are \(0,\tfrac12,1\);
3. the bounds
   \[
    |B_{2s}(x)|\le |B_{2s}|,
    \qquad
    |B_{2s}(x)-B_{2s}|
    \le(2-2^{1-2s})|B_{2s}|
   \]
   hold.

The midpoint evaluation used in the proof is

\[
 B_s\!\left(\frac12\right)
 =-\left(1-\frac1{2^{s-1}}\right)B_s
 =(2^{1-s}-1)B_s. \tag{1.12}
\]

Finally, for positive integers \(s\), the source identifies the convergent
Dirichlet series at even arguments as

\[
 \zeta(2s):=\sum_{j=1}^{\infty}\frac1{j^{2s}}
 =(-1)^{s-1}\frac{(2\pi)^{2s}B_{2s}}{2(2s)!},
 \qquad s\ge1. \tag{1.13}
\]

The proof compares the even-power expansion obtained from (1.08) with the
partial-fraction identity

\[
 \pi t\cot(\pi t)=1+\sum_{j=1}^{\infty}\frac{2t^2}{t^2-j^2}
 \qquad(t\notin\mathbb Z).
\]

Equation (1.13) also fixes the sign of \(B_{2s}\) as
\((-1)^{s-1}\). The local occurrence of \(\zeta\) here is the positive-even
Dirichlet series; the section does not define its analytic continuation.

## Ambiguities and review questions retained by this collation

1. “Slowly varying” is descriptive, not a stated differentiability
   hypothesis. Any \(C^m\), absolute-continuity, or interval-integrability
   interface is a formalization choice requiring review.
2. The codomain of \(f\) is not explicit. The printed derivation is scalar;
   complex- or Banach-valued versions would be generalizations even though the
   linear identity admits such extensions under suitable integration theory.
3. Equations (1.02)-(1.03) do not print an explicit range for \(s\). Their
   recursive context indicates \(s\ge2\); \(\omega_0=1\) is introduced only
   later for the generating function.
4. The point value of \(\omega_1\) at an integer is \(-\tfrac12\), not the
   symmetric value \(0\) sometimes assigned to a periodic saw-tooth function.
   Almost-everywhere equality is insufficient for pointwise source identity.
5. Equation (1.05) displays the condition \(0\le x<1\), while its convergence
   radius in \(t\) is supplied by the following paragraph. Equation (1.06)
   explicitly displays \(|t|<2\pi\). No boundary convergence at
   \(|t|=2\pi\) is asserted in this transcription. The source's phrase “unit
   disk” for the asserted uniformity in \(x\) sits beside the real condition
   \(0\le x<1\); an exact complex-\(x\) reading would need separate review.
6. The phrase “for all values of \(x\)” following (1.06) does not explicitly
   declare whether \(x\) is real or complex. The periodic identity (1.07) and
   Theorem 1.1 use real \(x\).
7. Equation (1.12) is derived by coefficient comparison without a separately
   printed index range. It is algebraically valid for the nonnegative indices
   defined by (1.06), but an exact theorem signature should state its range.
8. The source's section-1 finite identity supplies an exact integral remainder
   but no norm bound, derivative supremum, or infinite-endpoint passage. Such
   results are later work, not part of this occurrence.

## Excluded nearby material

Exercises 1.1-1.5 on printed p. 284 concern a shifted-node version of (1.04),
Bernoulli addition and multiplication identities, power sums, and Fourier
series. They were inspected to locate the end of section 1 but are not part of
the requested numbered-equation collation. Section 2.1 begins on that page and
is outside this transcription.

## Inventory integration record

The normalized inventory records one Chapter 8 occurrence, a partial page
audit, and provisional entities and notations for the periodic functions
\(\omega_s\), Bernoulli polynomials, Bernoulli numbers, and the local
positive-even Dirichlet-series use of \(\zeta\). The occurrence remains
`transcribed_unreconciled`; notation normalization remains unresolved; all
entity and occurrence links remain provisional. No theorem card or manifest
membership is created by this registration.
