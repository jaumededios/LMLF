# Object-first Lean statements

The §5.10 continued fraction and §5.9.2 Hankel integral are design exemplars,
not isolated exceptions. A DLMF formula should become a short readable theorem
because the mathematical objects beneath it already have honest interfaces.

## Review questions

1. What object is the formula actually manipulating: a coefficient stream,
   formal germ, contour, branch lift, ordered zero sequence, recurrence
   solution, partial product, quadrature rule, or remainder family?
2. Which conditions persist for the lifetime of that object? Put those in its
   structure or subtype.
3. Are syntax, finite evaluation, analytic convergence, and quantitative error
   genuinely different claims? Give each its own declaration.
4. Is the object merely asserted to exist and then selected with
   `Classical.choose`? If the mathematics supplies a normalization, define the
   canonical map and state reconstruction and uniqueness.
5. Does the source compute arbitrary finite data? Expose the algorithm and a
   theorem saying how much input a requested output uses.
6. Is a theorem unreadable because it expands a standard construction? Move
   the construction into shared Chapters 1–3 vocabulary, while keeping its
   semantic data visible there.
7. Is a definition only an arbitrary function with a theorem that repeats its
   assumed property, or a remainder defined by subtracting both sides of the
   desired equality? Replace it with named source data and a non-tautological
   characterization.

## §5.10: normalized continued fractions

The reader-facing evaluator defaults to offset zero and accepts `(offset := k)`
only for a tail. Numerator streams inhabit `CFCoefficients`, whose subtype
invariant says that once a numerator is zero all later numerators are zero.
Without this normalization the tail after a zero is invisible and uniqueness
is false.

Coefficient extraction acts on the odd formal/asymptotic germ used by the
Stirling expansion. `cfracCoeff` is executable over rational coefficients;
`formalContinuedFraction_cfracCoeff` states reconstruction,
`cfracCoeff_unique` states normalized uniqueness, and
`cfracCoeff_congr_prefix` states finite dependence. Analytic convergence to the
Gamma function remains a separate theorem.

This pattern should be reused for power-series coefficients, product factors,
recurrence coefficients, and other canonically normalized source data.

## §5.9.2: branch-aware contour integrals

A contour formula should display the special-function integrand and value, not
three screens of interval parameterizations. `C1Contour` defines the ordinary
`dγ` integral. `LogLiftedC1Contour` adds the continuous logarithm required by a
power on a contour winding around zero. `HasHankelIntegral` names the standard
outer-radius-then-inner-radius convergence regime.

This pattern should be reused for Mellin–Barnes paths, steepest-descent
contours, branch-selected inverses, and principal-value paths: type the path and
its branch/admissibility data once, then let the special-function theorem read
like the formula it formalizes.
