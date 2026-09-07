# Olver Chapter 5 coverage checklist

Source: Frank W. J. Olver, *Asymptotics and Special Functions*, 1997 corrected reprint of the 1974 edition, Chapter 5, “Differential Equations with Regular Singularities; Hypergeometric and Legendre Functions,” printed pp. 139–189 (preserved DjVu pp. 152–202; SHA-256 `ecee986dbc65c6a9d738837496772841605325dd3242b93abf025c59cfa405b1`).

This is bookkeeping for implementations, not an implementation framework. It does not alter the frozen E0 metadata/schema machinery. Items start `pending` and move to `checked` only after their Lean declarations, consumers where required, and acceptance checks pass; a source packet, transcription, or proof sketch is not Lean coverage.

## Denominators and counting rule

- **Whole-numbered-theorem metric:** `2 / 13 = 15.38%`. The denominator is the thirteen items explicitly headed “Theorem” in Chapter 5. A theorem counts only when its complete printed statement, including all cases and hypotheses, has a checked Lean implementation. Lemma 14.1 is not silently promoted into this denominator.
- **Claim-component metric:** `12 / 108 = 11.11%`. The denominator is the 108 rows in “Claim components.” Each row is one independently reusable definition, formula/result family, or mathematical-prose conclusion. Equivalent displayed forms and contiguous formulas proved as one family are deliberately bundled; routine algebraic lines used only inside a proof are excluded.
- **Exercises:** `0 / 44 = 0%`, reported separately. Exercises are not in either denominator above.
- Percentages are Chapter-5-only unit coverage, not estimates of proof effort or of the whole book. Later chapters should add their own audited denominators rather than extrapolating from this chapter.

Independent review verified the 13 theorem headings and 44 exercise headings and mechanically checked the table totals and subsection sums. It did not independently re-decompose every mathematical sentence and display into the 108 editorial claim rows. Accordingly, `108` is a disclosed editorial inventory, not a canonical or effort-weighted count.

The accepted Wronskian, Theorem 1.1, and Theorem 1.2 slices check `C05-01-02`–`C05-01-11`. The accepted [first-order slice](chapter05-first-order.md) now adds `C05-01-01`, so all eleven §1 claim components are checked; the two §1 exercises remain unproved. The accepted [local Gauss-series slice](chapter05-hypergeometric-series.md) adds exactly `C05-09-01`. `C05-09-02` remains pending/partial because its regularized local-series data are implemented but its all-parameter hypergeometric ODE is not.

## Subsection counts

| § | Printed pages | Numbered theorems | Claim components | Exercises |
|---|---:|---:|---:|---:|
| 1 | 139–143 | 2 | 11 | 2 |
| 2 | 143–145 | 2 | 3 | 1 |
| 3 | 145–148 | 2 | 7 | 4 |
| 4 | 148–150 | 1 | 8 | 1 |
| 5 | 150–153 | 0 | 6 | 1 |
| 6 | 153–154 | 0 | 3 | 2 |
| 7 | 154–156 | 0 | 5 | 0 |
| 8 | 156–159 | 1 | 7 | 4 |
| 9 | 159–163 | 1 | 8 | 7 |
| 10 | 163–168 | 0 | 7 | 3 |
| 11 | 168–169 | 0 | 3 | 1 |
| 12 | 169–174 | 1 | 12 | 3 |
| 13 | 174–180 | 2 | 8 | 4 |
| 14 | 180–185 | 1 | 14 | 5 |
| 15 | 185–189 | 0 | 6 | 6 |
| **Total** | **139–189** | **13** | **108** | **44** |

## Whole numbered theorems

| Label | Page | Short source paraphrase | Status | Future Lean link |
|---|---:|---|---|---|
| T05-1.1 | 139 | Continuous real coefficients give global `C²` solutions on the interval and unique solutions for prescribed value and derivative. | checked | [`exists_unique_realSecondOrderLinear`](../../LMLF/ODE/LinearSecondOrder.lean#L847), [`infinite_realSecondOrderLinearSolutions`](../../LMLF/ODE/LinearSecondOrder.lean#L900) |
| T05-1.2 | 141–142 | Fundamental pair, nowhere-zero Wronskian, and linear independence are equivalent. | checked | [`complexFundamentalPair_iff`](../../LMLF/ODE/FundamentalPair.lean#L353), [`realFundamentalPair_iff`](../../LMLF/ODE/FundamentalPair.lean#L373), [`complexSecondOrderFundamentalPair_iff`](../../LMLF/ODE/FundamentalPair.lean#L485), [`realSecondOrderFundamentalPair_iff`](../../LMLF/ODE/FundamentalPair.lean#L510) |
| T05-2.1 | 143–144 | Real-parameter solutions and specified mixed derivatives depend continuously on parameter and variable. | pending | unassigned |
| T05-2.2 | 144–145 | Holomorphic parameter dependence of coefficients and initial data gives holomorphic dependence of the solution and its first two `x`-derivatives. | pending | unassigned |
| T05-3.1 | 145–146 | Holomorphic coefficients on a simply connected domain give holomorphic solutions and a unique solution for prescribed initial data. | pending | unassigned |
| T05-3.2 | 146–147 | Jointly continuous, separately holomorphic coefficients and holomorphic initial data give holomorphic parameter dependence for complex-variable solutions. | pending | unassigned |
| T05-4.1 | 149–150 | A Frobenius series converges to a solution up to the nearest coefficient singularity when the other exponent is not a positive-integer shift. | pending | unassigned |
| T05-8.1 | 156–158 | Every second-order homogeneous linear ODE with at most three regular singularities, including infinity, transforms to the hypergeometric equation. | pending | unassigned |
| T05-9.1 | 160 | For fixed nonsingular `z`, every branch of the regularized hypergeometric function is entire in each parameter. | pending | unassigned |
| T05-12.1 | 172 | In the stated right-half-plane parameter range, principal `P` and `Q` associated Legendre solutions form a numerically satisfactory pair. | pending | unassigned |
| T05-13.1 | 174–176 | Principal associated Legendre `P` has the two stated Schläfli-type loop-integral representations under their parameter conditions. | pending | unassigned |
| T05-13.2 | 177–178 | Principal associated Legendre `Q` has the stated figure-eight contour representation off its cut. | pending | unassigned |
| T05-14.1 | 183–184 | Legendre polynomials obey the stated finite addition theorem under the branch convention for the square roots. | pending | unassigned |

## Claim components

### §1. Real-variable existence and Wronskians (11)

| Label | Page | Short source paraphrase | Status | Future Lean link |
|---|---:|---|---|---|
| C05-01-01 | 139 | The first-order homogeneous scalar equation has the exponential-of-an-integral general solution (1.02). | checked | [`hasDerivAt_const_mul_exp_neg_integral`](../../LMLF/ODE/LinearFirstOrder.lean#L31), [`eqOn_const_mul_exp_neg_integral_of_hasDerivAt`](../../LMLF/ODE/LinearFirstOrder.lean#L45), [`hasDerivAt_const_mul_cexp_neg_integral`](../../LMLF/ODE/LinearFirstOrder.lean#L78), [`eqOn_const_mul_cexp_neg_integral_of_hasDerivAt`](../../LMLF/ODE/LinearFirstOrder.lean#L92) |
| C05-01-02 | 139 | Under continuous coefficients, the second-order equation has infinitely many twice-continuously-differentiable solutions. | checked | [`infinite_realSecondOrderLinearSolutions`](../../LMLF/ODE/LinearSecondOrder.lean#L900), [`infinite_complexSecondOrderLinearSolutions`](../../LMLF/ODE/LinearSecondOrder.lean#L890) |
| C05-01-03 | 139–141 | Prescribing `w(x₀)` and `w′(x₀)` selects a unique solution on the interval. | checked | [`exists_unique_realSecondOrderLinear`](../../LMLF/ODE/LinearSecondOrder.lean#L847), [`exists_unique_complexSecondOrderLinear`](../../LMLF/ODE/LinearSecondOrder.lean#L829), [`exists_unique_realLinearIVP`](../../LMLF/ODE/LinearSecondOrder.lean#L778), [`exists_unique_complexLinearIVP`](../../LMLF/ODE/LinearSecondOrder.lean#L761) |
| C05-01-04 | 141 | A fundamental pair is a pair spanning every solution by constant linear combination; the canonical IVP pair is an example. | checked | [`SpansSecondOrderLinearSolutionsOn`](../../LMLF/ODE/FundamentalPair.lean#L22), [`complexLinearSolution_eqOn_cramer`](../../LMLF/ODE/FundamentalPair.lean#L143), [`realLinearSolution_eqOn_cramer`](../../LMLF/ODE/FundamentalPair.lean#L163), [`exists_complexCanonicalFundamentalPair`](../../LMLF/ODE/FundamentalPair.lean#L535), [`exists_realCanonicalFundamentalPair`](../../LMLF/ODE/FundamentalPair.lean#L576) |
| C05-01-05 | 141–142 | Define the Wronskian of two solutions by `w₁ w₂′ − w₂ w₁′`. | checked | [`wronskian`](../../LMLF/ODE/Wronskian.lean#L17), [`realWronskian`](../../LMLF/ODE/Wronskian.lean#L22) |
| C05-01-06 | 142 | Define linear independence by vanishing of a constant linear combination only for zero coefficients. | checked | [`linearIndependent_restrict_pair_iff`](../../LMLF/ODE/FundamentalPair.lean#L31) |
| C05-01-07 | 141–142 | Fundamental-pair, nowhere-zero-Wronskian, and linear-independence conditions are equivalent in full. | checked | [`complexFundamentalPair_iff`](../../LMLF/ODE/FundamentalPair.lean#L353), [`realFundamentalPair_iff`](../../LMLF/ODE/FundamentalPair.lean#L373), [`complexSecondOrderFundamentalPair_iff`](../../LMLF/ODE/FundamentalPair.lean#L485), [`realSecondOrderFundamentalPair_iff`](../../LMLF/ODE/FundamentalPair.lean#L510) |
| C05-01-08 | 142 | Along two solutions of `w″+fw′+gw=0`, the Wronskian satisfies `W′ = −fW`. | checked | [`hasDerivAt_wronskian`](../../LMLF/ODE/Wronskian.lean#L26), [`hasDerivAt_realWronskian`](../../LMLF/ODE/Wronskian.lean#L118) |
| C05-01-09 | 142 | Abel’s identity integrates the Wronskian equation to `W = C exp(−∫f)`. | checked | [`wronskian_eq_mul_cexp_integral`](../../LMLF/ODE/Wronskian.lean#L38), [`realWronskian_eq_mul_exp_integral`](../../LMLF/ODE/Wronskian.lean#L130) |
| C05-01-10 | 142 | The Wronskian of two solutions either vanishes everywhere or nowhere in the interval interior. | checked | [`wronskian_zero_or_nowhere_zero`](../../LMLF/ODE/Wronskian.lean#L64), [`realWronskian_zero_or_nowhere_zero`](../../LMLF/ODE/Wronskian.lean#L156) |
| C05-01-11 | 142 | If the first-derivative coefficient is zero, every solution-pair Wronskian is constant. | checked | [`wronskian_eq_of_f_eq_zero`](../../LMLF/ODE/Wronskian.lean#L103), [`realWronskian_eq_of_f_eq_zero`](../../LMLF/ODE/Wronskian.lean#L195) |

### §2. Parameter dependence, real independent variable (3)

| Label | Page | Short source paraphrase | Status | Future Lean link |
|---|---:|---|---|---|
| C05-02-01 | 143–144 | Continuous parameterized coefficients and continuous initial data make `w`, `wₓ`, and `wₓₓ` jointly continuous. | pending | unassigned |
| C05-02-02 | 143–144 | With continuous parameter derivatives and compatible initial data, `wᵤ`, `wᵤₓ`, and `wᵤₓₓ` are jointly continuous. | pending | unassigned |
| C05-02-03 | 144–145 | Holomorphic parameter data make the solution and its first two `x`-derivatives holomorphic in the parameter. | pending | unassigned |

### §3. Complex-variable existence (7)

| Label | Page | Short source paraphrase | Status | Future Lean link |
|---|---:|---|---|---|
| C05-03-01 | 145–146 | Holomorphic coefficients on a simply connected domain admit infinitely many holomorphic solutions. | pending | unassigned |
| C05-03-02 | 145–146 | Complex initial value and derivative determine a unique holomorphic solution. | pending | unassigned |
| C05-03-03 | 146 | Fundamental-pair, Wronskian, linear-independence, Abel, and equivalence results from §1 extend to the complex domain. | pending | unassigned |
| C05-03-04 | 146 | The Picard-series representation (3.03) is named the Liouville–Neumann expansion. | pending | unassigned |
| C05-03-05 | 146 | Local Taylor solutions exist up to the nearest coefficient singularity, with arbitrary first two coefficients and the stated recurrence thereafter. | pending | unassigned |
| C05-03-06 | 146–147 | Under the four hypotheses of Theorem 3.2, the solution and first two `z`-derivatives are holomorphic in the parameter. | pending | unassigned |
| C05-03-07 | 147 | Define `R₁`, `R₂`, and `R∞` arcs by increasing smoothness plus a nonvanishing tangent, and note standard paths are finite chains of them. | pending | unassigned |

### §4. Singularities and Frobenius solutions (8)

| Label | Page | Short source paraphrase | Status | Future Lean link |
|---|---:|---|---|---|
| C05-04-01 | 148 | Define an ordinary point by analyticity of both normalized coefficients. | pending | unassigned |
| C05-04-02 | 148 | Define a regular singularity by analyticity of `(z−z₀)f` and `(z−z₀)²g`. | pending | unassigned |
| C05-04-03 | 148 | Define irregular singularities and finite/infinite rank from the least regularizing powers or essential singularities. | pending | unassigned |
| C05-04-04 | 149 | The roots of the indicial quadratic are the exponents/indices of a regular singularity. | pending | unassigned |
| C05-04-05 | 149 | Frobenius substitution gives recurrence (4.05), fixing later coefficients from a nonzero leading coefficient. | pending | unassigned |
| C05-04-06 | 149 | Two formal Frobenius series occur for nonintegral exponent difference; integer difference can obstruct one unless the resonance numerator vanishes. | pending | unassigned |
| C05-04-07 | 149–150 | The nonresonant Frobenius series converges and solves the ODE throughout the coefficient disk. | pending | unassigned |
| C05-04-08 | 150 | Integer sign of an exponent determines analytic/pole/branch behavior; nonintegral exponent difference yields a fundamental pair. | pending | unassigned |

### §5. Resonant second solutions (6)

| Label | Page | Short source paraphrase | Status | Future Lean link |
|---|---:|---|---|---|
| C05-05-01 | 150–151 | Reduction of order with `w₂=w₁v` gives the integral formula for a second solution. | pending | unassigned |
| C05-05-02 | 151 | Equal exponents force a logarithmic second solution with the stated leading asymptotic. | pending | unassigned |
| C05-05-03 | 151–152 | Positive integral exponent difference gives a second solution of form (5.04), with a logarithm that may vanish in the exceptional resonant case. | pending | unassigned |
| C05-05-04 | 152 | The resonant second-solution series converges at least to the nearest singularity of the normalized coefficients. | pending | unassigned |
| C05-05-05 | 152 | Direct substitution determines resonant coefficients; for positive difference the leading coefficient may be normalized arbitrarily. | pending | unassigned |
| C05-05-06 | 152–153 | At a critical parameter where two solutions coalesce, the normalized difference quotient limits to another solution under Theorem 2.1’s hypotheses. | pending | unassigned |

### §6. The point at infinity (3)

| Label | Page | Short source paraphrase | Status | Future Lean link |
|---|---:|---|---|---|
| C05-06-01 | 153 | Under `z=1/t`, infinity is ordinary exactly under the stated analyticity conditions, and solutions have convergent inverse-power series. | pending | unassigned |
| C05-06-02 | 153 | Infinity is regular singular under the stated coefficient expansions; a Frobenius-type inverse-power solution exists and its exponent obeys the displayed quadratic. | pending | unassigned |
| C05-06-03 | 154 | Infinity is irregular when `zf` or `z²g` is singular there, with rank determined by the least regularizing power. | pending | unassigned |

### §7. Numerically satisfactory solutions (5)

| Label | Page | Short source paraphrase | Status | Future Lean link |
|---|---:|---|---|---|
| C05-07-01 | 154 | Define a numerically satisfactory pair by stable reconstruction near a singular region; `e^z,e^(−z)` is satisfactory at infinity while `cosh,sinh` is not. | pending | unassigned |
| C05-07-02 | 155 | At a regular singularity define the larger-real-part/no-log solution as recessive and independent companions as dominant. | pending | unassigned |
| C05-07-03 | 155 | A normalized recessive asymptotic identifies a unique solution, while a dominant asymptotic generally does not. | pending | unassigned |
| C05-07-04 | 155 | For unequal exponents with equal real part, neither solution dominates and the Frobenius pair is numerically satisfactory. | pending | unassigned |
| C05-07-05 | 155–156 | Recession is singularity-relative; with `n≥3` regular singularities one generally needs `n` recessive solutions rather than one globally satisfactory pair. | pending | unassigned |

### §8. Hypergeometric equation and reduction (7)

| Label | Page | Short source paraphrase | Status | Future Lean link |
|---|---:|---|---|---|
| C05-08-01 | 156 | Define the hypergeometric equation (8.01). | pending | unassigned |
| C05-08-02 | 156 | Its only singularities are `0,1,∞`, all regular, with exponent pairs `(0,1−c)`, `(0,c−a−b)`, and `(a,b)`. | pending | unassigned |
| C05-08-03 | 156–158 | Any second-order homogeneous equation with at most three regular singularities transforms to the hypergeometric equation. | pending | unassigned |
| C05-08-04 | 156–157 | Three prescribed finite regular singularities determine the Riemann/Papperitz coefficient form, subject to the Fuchs exponent-sum relation. | pending | unassigned |
| C05-08-05 | 157 | Define Riemann’s `P`-symbol by listing singularities and unordered exponent pairs. | pending | unassigned |
| C05-08-06 | 157–158 | The corresponding equation with one singularity at infinity has form (8.05) and is the finite-three-point limit. | pending | unassigned |
| C05-08-07 | 158 | A fractional-linear change of variable plus a gauge factor carries the Riemann equation to (8.07), hence to hypergeometric form with the stated parameters. | pending | unassigned |

### §9. Hypergeometric function (8)

| Label | Page | Short source paraphrase | Status | Future Lean link |
|---|---:|---|---|---|
| C05-09-01 | 159 | Define the hypergeometric series and its sum `F(a,b;c;z)` for nonexceptional `c` and `‖z‖<1`. | checked | [`gaussHypergeometricSeriesSum`](../../LMLF/Definitions/Hypergeometric.lean#L19), [`ordinaryHypergeometricSeries_radius_ge_one`](../../LMLF/Definitions/Hypergeometric.lean#L31), [`hasSum_gaussHypergeometricSeries`](../../LMLF/Definitions/Hypergeometric.lean#L83), [`gaussHypergeometricSeriesSum_analyticOnNhd`](../../LMLF/Definitions/Hypergeometric.lean#L139) |
| C05-09-02 | 159 | Define the gamma-regularized function and its Pochhammer series, which exists and solves the equation for all parameters. | pending (partial) | local-series evidence only: [`regularizedGaussHypergeometricSeriesSum`](../../LMLF/Definitions/Hypergeometric.lean#L27), [`hasSum_regularizedGaussHypergeometricSeries`](../../LMLF/Definitions/Hypergeometric.lean#L99), [`regularizedGaussHypergeometricSeriesSum_zero`](../../LMLF/Definitions/Hypergeometric.lean#L129); all-parameter ODE missing, so no credit |
| C05-09-03 | 159 | At nonpositive integral `c`, identity (9.05) moves the regularized solution to exponent `1−c`. | pending | unassigned |
| C05-09-04 | 159 | Analytic continuation across `‖z‖=1` gives a principal branch cut on `[1,∞)` and only possible branch points/poles at `1` and infinity; other branches are generally singular at `z=0`. | pending | unassigned |
| C05-09-05 | 160 | For fixed nonsingular `z`, each branch is entire separately in `a,b,c`. | pending | unassigned |
| C05-09-06 | 160 | Principal `(1−z)^(−a)` equals the corresponding hypergeometric specialization, including the geometric-series case. | pending | unassigned |
| C05-09-07 | 160–161 | Euler’s beta-integral represents the principal hypergeometric function under the stated real-part and cut conditions, with the noted continuation to a cut boundary. | pending | unassigned |
| C05-09-08 | 161 | Gauss’s value at `z=1` is the gamma quotient (9.10)/(9.11) when `Re(c−a−b)>0`, with the stated classical-`F` restriction. | pending | unassigned |

### §10. Other hypergeometric solutions (7)

| Label | Page | Short source paraphrase | Status | Future Lean link |
|---|---:|---|---|---|
| C05-10-01 | 163 | Define the second local solution `G` at zero; its Wronskian with the principal solution gives independence except at integral `c` and determines recession roles. | pending | unassigned |
| C05-10-02 | 164 | Euler’s transformation relates `F(a,b;c;z)` to `(1−z)^(c−a−b)F(c−a,c−b;c;z)`. | pending | unassigned |
| C05-10-03 | 164–165 | The two Pfaff transformations (10.05)–(10.06) continue the principal function into `Re z<1/2` with matching branches. | pending | unassigned |
| C05-10-04 | 165 | The two displayed local solutions at `z=1` form an independent pair unless `a+b−c` is integral. | pending | unassigned |
| C05-10-05 | 165–166 | Connection formulas (10.11)/(10.12) express the solution at zero in the basis at one with stated cuts and parameter exceptions. | pending | unassigned |
| C05-10-06 | 166 | Formula (10.13) connects a solution at one to the two series solutions at infinity, with principal branches on the stated cut. | pending | unassigned |
| C05-10-07 | 167 | Formulas (10.15)/(10.16) connect the solution at zero to the two series solutions at infinity, with stated cuts and classical-`F` restrictions. | pending | unassigned |

### §11. Generalized hypergeometric functions (3)

| Label | Page | Short source paraphrase | Status | Future Lean link |
|---|---:|---|---|---|
| C05-11-01 | 168 | Define the generalized hypergeometric differential equation via the Euler operator; its order is `max(p,q+1)`. | pending | unassigned |
| C05-11-02 | 168 | Define `pFq` as the exponent-zero Pochhammer series solution under its denominator and convergence conditions. | pending | unassigned |
| C05-11-03 | 168 | Classify convergence: entire for `p≤q`, radius one for `p=q+1`, and divergent at nonzero `z` for `p>q+1` unless the series terminates. | pending | unassigned |

### §12. Associated Legendre equation (12)

| Label | Page | Short source paraphrase | Status | Future Lean link |
|---|---:|---|---|---|
| C05-12-01 | 169 | Define the associated Legendre equation and record invariance under `μ↦−μ`, `ν↦−ν−1`, and `z↦−z`. | pending | unassigned |
| C05-12-02 | 169 | Its singularities `1,−1,∞` are regular with the exponent data shown in the Riemann symbol. | pending | unassigned |
| C05-12-03 | 169–170 | Define principal `P_v^(−μ)` by the equivalent hypergeometric formulas (12.04)–(12.05) and the specified branches. | pending | unassigned |
| C05-12-04 | 170 | Define principal `Q_v^μ` by equivalent formulas (12.06)–(12.07), including its normalization at negative integral degree. | pending | unassigned |
| C05-12-05 | 170–171 | These `P,Q` branches exist off the singular points, have the stated cuts/branch points, and are entire separately in degree and order for fixed regular `z`. | pending | unassigned |
| C05-12-06 | 171 | Endpoint normalizations (12.08)–(12.09) characterize recession of `P` at one and `Q` at infinity in their parameter ranges. | pending | unassigned |
| C05-12-07 | 171 | Degree/order symmetries reduce eight candidate associated Legendre solutions to four distinct ones. | pending | unassigned |
| C05-12-08 | 171–172 | Connection formulas (12.11)–(12.14) relate the four distinct associated Legendre solutions. | pending | unassigned |
| C05-12-09 | 172 | Under `Re ν≥−1/2`, `Re μ≥0`, `Re z≥0`, principal `P_v^(−μ),Q_v^μ` are numerically satisfactory. | pending | unassigned |
| C05-12-10 | 172 | Wronskians (12.15)–(12.16) characterize linear dependence, especially the negative-integral `ν+μ` exceptional set. | pending | unassigned |
| C05-12-11 | 172–173 | The recommended parameter region is essential: outside it the same pair is generally not satisfactory even if independent. | pending | unassigned |
| C05-12-12 | 173–174 | Formulas (12.18)–(12.23) give the remaining limiting forms at infinity and at one, including exceptional half-degree/zero-order cases. | pending | unassigned |

### §13. General degree and order (8)

| Label | Page | Short source paraphrase | Status | Future Lean link |
|---|---:|---|---|---|
| C05-13-01 | 174 | At integral degree and zero order, the associated `P` equals the Legendre polynomial; `ν` and `μ` are thereby called degree and order. | pending | unassigned |
| C05-13-02 | 174–176 | Principal associated `P` has the two loop-integral representations (13.01)–(13.02) with their path, branch, and parameter conditions. | pending | unassigned |
| C05-13-03 | 176–177 | The order-raising and degree-raising relations (13.10)–(13.12) hold for all parameters by analytic continuation. | pending | unassigned |
| C05-13-04 | 177–178 | Principal associated `Q` has the figure-eight integral (13.13) with its path and branch conditions. | pending | unassigned |
| C05-13-05 | 178 | Define the application-standard `Q_v^μ` by gamma rescaling of the entire-in-parameters solution, noting its negative-integral exception. | pending | unassigned |
| C05-13-06 | 178 | Order reversal obeys the gamma-ratio relation (13.15). | pending | unassigned |
| C05-13-07 | 178–179 | Formulas (13.16)–(13.18) give hypergeometric and contour representations of the application-standard `Q`. | pending | unassigned |
| C05-13-08 | 179 | The `Q` functions obey the same three recurrence relations (13.10)–(13.12) as `P`. | pending | unassigned |

### §14. Integer degree and order (14)

| Label | Page | Short source paraphrase | Status | Future Lean link |
|---|---:|---|---|---|
| C05-14-01 | 180 | For nonnegative integer degree/order, define the reduced branch cut and identify `P_n^m` with `(z²−1)^(m/2)` times the `m`th derivative of `P_n`. | pending | unassigned |
| C05-14-02 | 180 | Consequences: `P_n^m=0` for `m>n`, polynomiality for even `m≤n`, and only the finite cut for odd `m≤n`. | pending | unassigned |
| C05-14-03 | 180 | Rodrigues’ formula (14.02) gives `P_n^m` by an `(n+m)`th derivative. | pending | unassigned |
| C05-14-04 | 180–181 | Contour formulas (14.03)–(14.05) represent positive and negative integer orders and include relation (14.04). | pending | unassigned |
| C05-14-05 | 181 | Trigonometric contour parametrization gives integral formulas (14.07)–(14.08) for `P_n^m` and `P_n^(−m)`. | pending | unassigned |
| C05-14-06 | 181 | `Q_n^m` equals `(z²−1)^(m/2)` times the `m`th derivative of `Q_n`. | pending | unassigned |
| C05-14-07 | 181 | Formula (14.10) expresses `Q_n` as a logarithmic multiple of `P_n` plus a finite polynomial correction. | pending | unassigned |
| C05-14-08 | 182 | Cut and hyperbolic integrals (14.11)–(14.12) represent `Q_n^m`, with the stated continuation and convergence extension. | pending | unassigned |
| C05-14-09 | 182 | For nonnegative integers `n≥m`, the integer-order Wronskian is the explicit factorial multiple of `(z²−1)⁻¹` in (14.13). | pending | unassigned |
| C05-14-10 | 182 | For nonnegative integers `n≥m`, all zeros of `P_n^m` lie in `[-1,1]`, enabling the reduction-of-order integral (14.14) off the cut. | pending | unassigned |
| C05-14-11 | 182–183 | Neumann’s integral (14.15) represents `Q_n` as a Cauchy transform of `P_n` off `[-1,1]`. | pending | unassigned |
| C05-14-12 | 183–184 | Legendre polynomials satisfy the finite addition theorem (14.16)–(14.17). | pending | unassigned |
| C05-14-13 | 184 | Lemma 14.1 evaluates the mean reciprocal of `a+b cosθ+c sinθ` under `a>sqrt(b²+c²)`. | pending | unassigned |
| C05-14-14 | 184 | The addition theorem extends to complex variables by analytic continuation and to general degree by an infinite gamma-weighted series. | pending | unassigned |

### §15. Ferrers functions (6)

| Label | Page | Short source paraphrase | Status | Future Lean link |
|---|---:|---|---|---|
| C05-15-01 | 185–186 | Define real Ferrers `P,Q` on `−1<x<1` from the upper/lower boundary values of associated Legendre functions. | pending | unassigned |
| C05-15-02 | 186 | Hypergeometric representation (15.03), connection (15.04), and formula (15.05) extend Ferrers functions with the stated cuts. | pending | unassigned |
| C05-15-03 | 186 | Endpoint limits (15.06)–(15.08) describe `P_v^(±μ),Q_v^(±μ)` as `x→1−`. | pending | unassigned |
| C05-15-04 | 186 | No one standard pair is satisfactory near one for all nonnegative parameters, but `P_n^(−m),Q_n^m` is satisfactory for nonnegative integers. | pending | unassigned |
| C05-15-05 | 187 | At zero, transformed Ferrers solutions have the even/odd hypergeometric basis (15.09) and decompositions (15.10)–(15.11). | pending | unassigned |
| C05-15-06 | 187–188 | Coefficients (15.12)–(15.13) give the explicit Maclaurin decompositions, extended by analytic continuation. | pending | unassigned |

## Proof-internal support assertions (excluded from both denominators)

These are implementation obligations once their parent results are attempted, but they are not counted again as book-level claims. Each row deliberately groups a proof’s local estimates, algebraic rewrites, and continuation steps.

| Label | Page | Short source paraphrase | Status | Future Lean link |
|---|---:|---|---|---|
| PI05-1.1 | 139–141 | Picard iterates satisfy integral equations, factorial majorants, and uniform-convergence conditions yielding existence. | pending | support-only; unassigned |
| PI05-1.2 | 141 | Repeated substitution bounds a zero-initial-data difference and forces uniqueness. | pending | support-only; unassigned |
| PI05-1.3 | 142 | Two-by-two linear algebra and zero-initial-data uniqueness prove the implication cycle in Theorem 1.2. | pending | support-only; unassigned |
| PI05-2.1 | 143–144 | Uniform continuity of iterates and parameter-uniform majorants justify joint continuity and differentiated limits. | pending | support-only; unassigned |
| PI05-2.2 | 144–145 | Holomorphic iterates plus compact-uniform convergence justify holomorphic parameter limits. | pending | support-only; unassigned |
| PI05-3.1 | 145–146 | Disk-local Liouville–Neumann convergence and continuation through a finite disk chain prove global existence. | pending | support-only; unassigned |
| PI05-3.2 | 146–147 | Piecewise `R₂` paths reduce the complex ODE to real path-parameter equations for Theorem 3.2. | pending | support-only; unassigned |
| PI05-4.1 | 149–150 | Cauchy coefficient bounds and the majorizing recurrence prove the Frobenius radius bound. | pending | support-only; unassigned |
| PI05-5.1 | 152–153 | Differentiating the parameterized ODE and commuting mixed derivatives proves the coalescing-solution limit solves it. | pending | support-only; unassigned |
| PI05-8.1 | 156–158 | Rational coefficient decomposition, indicial matching, Fuchs relation, and Möbius/gauge changes prove Theorem 8.1. | pending | support-only; unassigned |
| PI05-9.1 | 160 | An M-test and Theorem 3.2 transport parameter entire-ness from the unit disk to other branches. | pending | support-only; unassigned |
| PI05-9.2 | 160–161 | Beta substitution, dominated/termwise integration, Abel continuity, and analytic continuation derive Euler and Gauss formulas. | pending | support-only; unassigned |
| PI05-10.1 | 165–167 | Endpoint limits and gamma reflection determine connection coefficients; descending-power comparison determines the infinity coefficients. | pending | support-only; unassigned |
| PI05-12.1 | 172 | Endpoint asymptotics, Abel’s Wronskian form, and boundary cases establish numerical satisfactoriness. | pending | support-only; unassigned |
| PI05-12.2 | 173 | Cauchy’s parameter formula removes exceptional half-degree restrictions in the infinity asymptotic. | pending | support-only; unassigned |
| PI05-13.1 | 174–176 | Integration by parts shows the contour integral solves the ODE; path collapse and normalization identify it with `P`. | pending | support-only; unassigned |
| PI05-13.2 | 178 | Phase cancellation, fixed-path asymptotics, and path collapse identify the figure-eight integral with `Q`. | pending | support-only; unassigned |
| PI05-14.1 | 181 | Differentiating Legendre’s equation and using recessive uniqueness proves the derivative representation for `Q_n^m`. | pending | support-only; unassigned |
| PI05-14.2 | 183–184 | A generating-function integral, Fourier coefficient extraction, and the `P/Q` integrals prove the addition theorem. | pending | support-only; unassigned |
| PI05-15.1 | 187–188 | Imaginary-axis asymptotics and a two-equation coefficient solve produce the Maclaurin constants. | pending | support-only; unassigned |

## Exercises (separate denominator: 44)

| Label | Page | Short source paraphrase | Status | Future Lean link |
|---|---:|---|---|---|
| EX05-1.1 | 143 | Extend Theorem 1.1 to a continuous inhomogeneous right-hand side. | pending | unassigned |
| EX05-1.2 | 143 | Prove existence and uniqueness with finitely many coefficient discontinuities and integrable coefficients, including endpoint initial data. | pending | unassigned |
| EX05-2.1 | 145 | Allow the real initial point to vary continuously with the parameter in Theorem 2.1. | pending | unassigned |
| EX05-3.1 | 147 | Construct the given Maclaurin fundamental pair for `(cosh z)w″+w=0`, check its Wronskian, and find radii. | pending | unassigned |
| EX05-3.2 | 147–148 | Construct global even/odd Weber solutions, their recurrence, and exponential-series alternatives. | pending | unassigned |
| EX05-3.3 | 148 | Use Cauchy bounds and a majorant recurrence to prove the Taylor solution radius is at least the coefficient radius. | pending | unassigned |
| EX05-3.4 | 148 | Join any two points of a domain by a single `R₂` arc inside it. | pending | unassigned |
| EX05-4.1 | 150 | Find independent local series solutions at zero and one for the displayed equation. | pending | unassigned |
| EX05-5.1 | 153 | Verify the stated logarithmic fundamental pair in the unit disk and its coefficient formula. | pending | unassigned |
| EX05-6.1 | 154 | Classify infinity and compute exponents/rank for three displayed ODEs. | pending | unassigned |
| EX05-6.2 | 154 | Construct independent series solutions of Legendre’s equation outside the unit disk. | pending | unassigned |
| EX05-8.1 | 158 | Show no second-order homogeneous linear ODE is free of singularities everywhere. | pending | unassigned |
| EX05-8.2 | 158 | Solve equations with one or two regular singularities and no irregular ones in elementary closed form. | pending | unassigned |
| EX05-8.3 | 158 | Prove the stated Riemann-symbol transformation under the exponent-sum condition. | pending | unassigned |
| EX05-8.4 | 158–159 | Derive the general second-order equation with `n` prescribed regular singularities and the accessory-parameter constraints. | pending | unassigned |
| EX05-9.1 | 161 | Express logarithm, inverse hyperbolic sine, and arctangent in hypergeometric form. | pending | unassigned |
| EX05-9.2 | 161 | Express complete elliptic integrals `K` and `E` hypergeometrically. | pending | unassigned |
| EX05-9.3 | 162 | Prove the two stated differentiation identities for the regularized hypergeometric function. | pending | unassigned |
| EX05-9.4 | 162 | Verify two Gauss contiguous relations. | pending | unassigned |
| EX05-9.5 | 162 | Prove Pochhammer’s contour formula and assess extension to other branches. | pending | unassigned |
| EX05-9.6 | 162 | Derive the stated large-`c` asymptotic expansion and its enlarged sector when `Re z<1/2`. | pending | unassigned |
| EX05-9.7 | 162 | Derive the stated large-parameter expansion and its complex-`z` extension. | pending | unassigned |
| EX05-10.1 | 167 | Express Jacobi polynomials in two hypergeometric forms. | pending | unassigned |
| EX05-10.2 | 167 | Prove the displayed quadratic transformation. | pending | unassigned |
| EX05-10.3 | 168 | Use the coalescing-parameter method to construct the logarithmic second hypergeometric solution for integral `c`. | pending | unassigned |
| EX05-11.1 | 169 | Derive the third-order product equation and Clausen’s square identity. | pending | unassigned |
| EX05-12.1 | 174 | Prove the alternative hypergeometric representation of associated `Q`. | pending | unassigned |
| EX05-12.2 | 174 | Prove Whipple’s formula. | pending | unassigned |
| EX05-12.3 | 174 | Verify the three half-order closed forms at `z=cosh ζ`. | pending | unassigned |
| EX05-13.1 | 179 | Derive monodromy/branch continuation formulas for associated Legendre functions. | pending | unassigned |
| EX05-13.2 | 179 | Prove two parameter recurrences and one derivative identity for associated `P`. | pending | unassigned |
| EX05-13.3 | 179 | Deform the contour in (13.01) to obtain the displayed real improper integral. | pending | unassigned |
| EX05-13.4 | 179–180 | Take integer-degree limits in the contour formulas, producing logarithmic and real-integral representations. | pending | unassigned |
| EX05-14.1 | 185 | Transform (14.12) into Heine’s integral. | pending | unassigned |
| EX05-14.2 | 185 | Deduce the stated bound for `Q_n(cosh(α+iβ))`. | pending | unassigned |
| EX05-14.3 | 185 | Prove Jacobi’s lemma and derive the repeated-integration formula for `P_n^m`. | pending | unassigned |
| EX05-14.4 | 185 | Deduce the hyperbolic integral for `P_n^m(cosh ζ)`. | pending | unassigned |
| EX05-14.5 | 185 | Derive and analytically continue the generating expansion involving `Q_n`. | pending | unassigned |
| EX05-15.1 | 188 | Derive explicit `Q_n` as a logarithmic `P_n` term minus a polynomial. | pending | unassigned |
| EX05-15.2 | 188 | Prove integer-order Ferrers derivative and repeated-integral identities. | pending | unassigned |
| EX05-15.3 | 188 | Derive two Ferrers Wronskians and confirm them at zero. | pending | unassigned |
| EX05-15.4 | 188 | Prove reflection formulas under `x↦−x` for Ferrers `P,Q`. | pending | unassigned |
| EX05-15.5 | 188–189 | Derive the Green/Wronskian integral identity and the resulting orthogonality formulas. | pending | unassigned |
| EX05-15.6 | 189 | Prove the large-degree Ferrers-to-Bessel limit. | pending | unassigned |

## Scan notes and finite uncertainties

- The chapter boundary, all fifteen subsection starts, all theorem/lemma headings, and all exercise headings were checked across the complete embedded text layer. Formula-sensitive pages 141–145, 156, 159, 169–170, 172, 174, 177–178, 180, 182, and 186–188 were also checked against rendered page images.
- No theorem or exercise heading remains ambiguous. The `108` claim-component denominator is exact relative to the bundling rule above, but it is an editorial decomposition: splitting an equivalent-formula family or a multi-conclusion row would change that denominator and must be recorded as an explicit checklist revision.
- Historical notes on p. 189 are bibliographic commentary, not mathematical claims, and are excluded. Footnotes that change hypotheses or branch conventions have been absorbed into their parent rows rather than counted separately.
