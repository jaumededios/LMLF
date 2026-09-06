# Independent Bessel source revision 2 referee report

## Overall disposition

Both reviewed files are **APPROVED** for source-transcription acceptance at the exact commit and hashes bound below. I found no actionable mathematical, source-faithfulness, scope, copyright, or atomic-queue defect. Atomic inventory integration may begin for the provisional occurrence rows in these two exact files, subject to the integration conditions stated below.

This approval is for planning-source evidence only. It does not reconcile an inventory record, establish a theorem card, select a canonical entity, authorize implementation, or turn an exercise target into a proved source assertion.

## Exact review bindings and isolation

The repository evidence was read only from a disposable `git archive` of commit `4147deda85688ac5e6e7dc0868a45c0f60dc7036`, whose tree is `d60cd54b6e241f0833a6d4d417dd1d44319dd90d`. No live dirty-worktree file bytes and no prior referee report were inspected.

The private source snapshot at `/tmp/codex-web-uploads-5qVFkz/ccbc2d4c-f600-4d0a-90ec-eeeb25e7cdce` has SHA-256 `08e1844d29a5ad21f89b9b600249ce18ac1665a5845be2d4e4219a3ededdc909`, exactly as declared by both transcriptions. The document has 585 PDF pages. I rendered and visually inspected printed pages 55 through 61, corresponding to PDF pages 68 through 74, and printed pages 435 through 438, corresponding to PDF pages 448 through 451.

The reviewed Chapter 2 file is `blueprint/source_transcriptions/OLV97-C02-BESSEL-JI.md`, with SHA-256 `f157c9fc8688da02a680661c185a8a5458a24ba5b6dd77641190a4393d6e5439`.

The reviewed Chapter 12 file is `blueprint/source_transcriptions/OLV97-C12-BESSEL-REAL-AUX.md`, with SHA-256 `13d223d6e088582f2eb9c4fbc282cb4d1a8acf29abd32d6f28e26918d42acc5b`.

I also read the complete 1,753-line project brief and the complete PDF, global Lean-library referee, and local Lean-proof referee instructions, including the global rubric, research basis, local rubric, and LSP playbook. No Lean declarations or proof edits are in the reviewed artifacts, so tactic, elaboration, and kernel-trust checks do not create additional findings here; the applicable mathematical-intent, API-boundary, dependency, source-status, and review-snapshot requirements were applied.

## `OLV97-C02-BESSEL-JI.md`

**Verdict: APPROVE.**

The page map and scope are exact. The collation begins with section 9 on printed page 55, includes sections 9.1 through 9.5, Exercises 9.1 through 9.8, section 10.1, and Exercises 10.1 through 10.6, and stops before section 11. The preceding Airy material, Figure 9.1 image, and the following zeta material are correctly excluded, while the existence and role of Figure 9.1 are retained as metadata.

All numbered formulas checked against the rendered source are faithful. In particular, the integer-order integral, exponential integral, contour integral, Maclaurin derivatives and series, negative-order sign, Laurent generating function, differential identity, and Bessel equation have the correct orientations, signs, derivative orders, factorials, binomial factor, and powers of two. The general-order series has the correct factor `(z/2)^nu`, alternating sign, `(z^2/4)^s`, and reciprocal Gamma index. The branch continuation uses rotation by `m pi i` and multiplier `exp(m nu pi i)`. The Schlaefli formulas have the correct `1/(2 pi i)` prefactor, powers of `t`, exponential signs, contour endpoints, and phase restriction. The order and derivative recurrences and their solved forms have the correct signs and factors.

The modified first-kind formulas are also exact: the series loses the alternating sign, the rotation multiplier is `exp(-nu pi i/2)`, the modified differential equation has the required minus sign, and the recurrence signs agree with the source. The principal-branch ranges in Exercise 10.2, the Airy transformations and derivative signs in Exercise 10.4, the mutually inverse series signs in Exercise 10.5, and the Kelvin rotations, phases, and fourth-order equation in Exercise 10.6 all match the printed page.

Exercise status is handled correctly. Exercises 9.1 through 9.8 and 10.1 through 10.6 are consistently described as reader targets rather than surrounding-exposition assertions. The revision-2 warnings for Exercises 9.3 through 9.7 are necessary and source-faithful: the half-integral square roots, repeated derivative powers, Poisson prefactor, and complex-argument bound inherit a coherent principal or continued branch without inventing a cut-boundary convention; Exercise 9.7 leaves the path from zero, endpoint semantics, homotopy information, cut behavior, and exact domain unresolved. The transcription does not invent a straight-line path or path-independence theorem.

The branch, origin, parameter, and derivative distinctions are sound. The integer-order entire function is not conflated with the branched general-order function at zero; reciprocal-Gamma zeros are not treated as ordinary division by a pole; normalized-kernel regularity is kept separate from the branch-producing power; the ODE is not treated as a normalization; recurrence divisions by the argument are not presented as origin identities; and primes are correctly bound to the spatial argument. The footnote warning that the principal cuts of `I_nu(z)` and `J_nu(i z)` differ is preserved, as is the footnote explaining why the integer-order integral is not the general-order definition.

The substantive cross-references to Theorem 1.1, reciprocal-Gamma equation (1.12), comparison equation (7.19), Theorem 8.1, section 4.2, Airy equation (8.05), Exercise 10.2, and Chapter 7 are present and assigned source-reference roles without claiming that the referenced results were inspected here.

The atomic queue contains 58 occurrence rows. Every row has one scalar source kind, target class, context role, and evidence value; every occurrence identifier is unique within this file and across the other reviewed file. Formula groups sharing a printed equation or exercise number remain one source occurrence, while prose properties, the figure, footnotes, and substantive cross-references receive distinct identifiers. The inherited edition, snapshot, queue class, resolution, reconciliation, and novelty metadata are explicit and appropriately provisional.

## `OLV97-C12-BESSEL-REAL-AUX.md`

**Verdict: APPROVE.**

The page map and scope are exact. The file covers Chapter 12, sections 1.1 through 1.3 and Exercise 1.1 on printed pages 435 through 438, while excluding the numerical table contents and all substantive section 2.1 material. It correctly records the shared real domain `nu >= 0` and `x > 0` through section 7 and treats negative-order replacements as separately qualified extensions rather than silently enlarging that baseline domain.

The modified and unmodified Bessel formulas match the source in all checked signs, powers, constants, and qualifiers. The small- and large-argument relations have the correct Gamma factors and powers, including the distinct logarithmic zero-order cases. Bounded-order uniformity is retained only for the stated large-argument formulas. The positive-integer exception after replacing `nu` by `-nu` is retained for the small-argument `I` and `J` formulas.

The two ordered Wronskians are exact with the declared convention `W{f,g} = f g' - f' g`: `W{K,I} = 1/x` and `W{J,Y} = 2/(pi x)`. The generic modified recurrence correctly uses the order-dependent member `exp(nu pi i) K_nu`, not unscaled positive-real `K_nu`; all four modified and all four unmodified recurrence signs agree with the source. The negative-order connection matrices have the correct sine and cosine signs.

The zero and auxiliary-function data are faithful. Positive zeros are indexed from one and interlace beginning with `y_{nu,1}` before `j_{nu,1}`. The large-index offsets are `nu/2 - 1/4` for `j` and `nu/2 - 3/4` for `y`. `X_nu` is the smallest positive root of `J_nu + Y_nu`, with `0 < X_nu < y_{nu,1}`. The positive real square-root conventions for `E_nu` and `M_nu`, the piecewise switch at `X_nu`, the derivative of `E_nu^2`, and the continuously unwrapped rather than principal-arctangent interpretation of `theta_nu` are all explicit.

The phase normalization is particularly well preserved. The intermediate ambiguity is exactly an additive `2 m pi` with integer `m`; `m` is not coupled to the order and is correctly reported as independent of `nu` by continuity. The half-order identities give `X_{1/2} = pi/4` and `theta_{1/2}(x) = x - pi/2` on the outer branch, forcing `m = 0`. The phase values at the indexed zeros and the signs and prefactors in the endpoint formulas for `E_nu`, `M_nu`, and `theta_nu` all match the printed source.

Exercise 1.1 is correctly isolated as an exercise target. Its symbol `c` remains neutral source notation with the printed value `-0.36605...` and only the Chapter 11, section 2.2 cross-reference; the transcription does not invent an exact Airy-zero identity or treat the decimal as an exact definition. The `X_nu` table itself is not reproduced. Its footnote is accurately and minimally paraphrased as a report that `X_nu` increases with `nu` and that Watson's 1944 section 15.6 contains a theorem including this result. The separate phase footnote to Chapter 1, Exercise 5.4 is also retained with reference-only status.

The atomic queue contains 61 occurrence rows. Each row has scalar kind, target, role, and evidence fields, and all identifiers are unique within this file and across the Chapter 2 file. The queue separates numbered formulas, unnumbered properties, notation, the balancing-root definition, phase normalization, the exercise, omitted-table metadata, both footnotes, and substantive cross-references. Its inherited cross-cutting, unresolved, and source-recovery metadata correctly prevents premature reconciliation.

## Copyright and invention check

No scan, page image, figure, numerical table, extended extracted passage, or invented source theorem appears in either file. The mathematical formulas and compact source locations are accompanied by new explanatory prose. Omitted material is identified rather than reconstructed. Open branch, path, endpoint, exceptional-value, entity-link, and exact-constant questions remain visibly open. I found no unsupported import from DLMF, Chapter 7, Chapter 11, Watson, or memory.

## Atomic inventory integration decision and acceptance conditions

Atomic inventory integration **may begin now** for all 119 provisional occurrence rows: 58 from the Chapter 2 file and 61 from the Chapter 12 file.

Acceptance requires integration to preserve each row's exact occurrence identifier and scalar source-kind, target-class, context-role, and evidence fields, together with the declared inherited metadata. The rows must remain provisional, transcribed-unreconciled, unresolved, and source-recovery evidence until a separate reconciliation review changes those statuses. Integration must not merge distinct occurrence rows, infer canonical entity identity from the provisional entity split, register the suggested downstream cards, select manifest membership, or promote an exercise to a source assertion.

Later theorem-card or implementation work must first resolve the open branch and origin regimes, the Exercise 9.3 through 9.7 domain and path semantics, exceptional integer-order continuations, real/complex bridges, global zero indexing, continuous phase construction, and the exact Chapter 11 identity of `c` where those matters are used. Those are correctly documented downstream obligations and are not defects blocking source-occurrence integration.

This verdict binds only the exact commit and file hashes stated above. Any material edit to either transcription requires renewed review of the changed bytes and their source bindings.

The SHA-256 of this report is intentionally supplied out of band because embedding it in the report would be self-referential.
