# §5.12 object-first author follow-up

Section range: DLMF §5.12 (Beta Function), formulas 5.12.1–5.12.12.

## Referee repairs

- Retained typed Euler, shifted, hyperbolic, vertical, Barnes, cosine, Fourier,
  and first-loop domains, keeping convergence/integrability declarations apart
  from value identities.
- Renamed the former conservative guard to `GammaQuotientDefined` and stated
  its exact guarantee: all three displayed Gamma factors are nonzero.  It is a
  conservative quotient guard, not a characterization of every finite
  meromorphic continuation value; its `.value` evaluator is shown before all
  uses.
- E11 now has explicit `SecondLoopDomain` data (`Re b > 0`, `a ∉ ℤ`, and a
  cut point between `-1` and `0`), an inhabited canonical branch constructor,
  and endpoint laws recording one positive winding: the outgoing `t` lift is
  incoming `+ 2πi`, while the `1+t` lift returns to its principal value.
- Removed the unconditional `Filter.limUnder` E11 value.  The truncation
  family is total only as a finite-family interface; `SecondLoopIntegralData`
  must supply its actual `Tendsto` limit, and the convergence theorem merely
  exposes that supplied fact.  The value identity consumes this data separately.
- E12 now uses the shared `LMLF.Integral.PiecewiseC1Contour` API with breakpoints, stored
  tangent, derivative-off-breaks law, two-log integral, and integrability
  predicate.  The source path is explicit as `(1+, 0+, 1-, 0-)`, returning to
  the base point `P`; both lifts are principal at `P` and continuous on the
  contour.  The shared `C1Contour` API remains used for E10.
- E10 prose now says the positively oriented loop begins at `t=0`, circles
  `1`, and returns to its start; all quotient-domain prose uses the exact
  `GammaQuotientDefined` guarantee rather than an imprecise shorthand.
- Restored the global principal-value convention and E11/E12 cut, winding,
  loop-order, and return-to-`P` prose in the manual.

The manifest retains all twelve source IDs, with `specialization` labels where
the conservative Gamma quotient guard narrows the DLMF meromorphic domain. No
quantitative analogue is added: E11 convergence is qualitative analytic
existence, not an error bound.

## Focused checks

- `lake env lean LMLF/Blueprint/Gamma/Section512.lean`
- `lake env lean LMLFManual/Chapter5/Section512.lean`
- `node scripts/check_source_tex.mjs doc/LMLFManual/Chapter5/Section512.lean`
- Manifest JSON parse with Node.
- Source/manual anchor-byte parity check (71 anchors, no missing or duplicate
  anchors after the shared contour migration).
- `rg` check for no `Filter.limUnder` or `#check` in the focused §5.12 files.

All proofs remain `by sorry` under the section-author contract; no whole-site
generation was run.
