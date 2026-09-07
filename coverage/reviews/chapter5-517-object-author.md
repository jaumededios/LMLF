# DLMF §5.17 object-author handoff

## Scope

This pass repairs only `LMLF/Blueprint/Gamma/Section517.lean`,
`doc/LMLFManual/Chapter5/Section517.lean`, and
`coverage/sections/chapter5-517.json`.  The seven numbered displays in the
source inventory remain covered: 5.17.E1–E7 are all stated, with no omissions.

## Object decisions

- Barnes' canonical product now has named factor, prefactor, finite partial
  product, and infinite product-value objects.  `barnesGProduct_hasProd` gives
  the semantic convergence declaration, and
  `barnesGProduct_partialProduct_tendsto` connects the executable finite
  approximants to that value.  `barnesG` and E3 use the named product rather
  than repeating a raw `∏'` expression.
- Glaisher's logarithm is canonically anchored to the zeta-derivative value;
  it is no longer a totalized `limUnder` definition.  The convergence of the
  renormalized finite expression is independently stated by
  `glaisherPartialExpression_tendsto`, while E7's two zeta-derivative
  identities remain a separate value theorem.  `glaisherConstant` is then the
  exponential of that canonical value.
- The manual introduces every custom object before a dependent declaration is
  displayed.  In E3, product convergence is shown before the Barnes value
  identity; in E7, convergence is shown separately from the zeta-value
  identities.

## Coverage and specialization

The E1 recurrence and normalization are stated on the ordinary pole-free
domain used by the existing totalized `Complex.Gamma`; E4 is the positive-real
path/logarithm specialization; E5 is the positive-real specialization of the
source sector, with its index shift made explicit in prose.  E6 retains the
source decimal as prose rather than asserting an unenclosed numerical bound.

No genuinely distinct finite error estimate is supplied by this section's
formalization.  The Nemes error bounds and exponentially improved expansion
referenced by DLMF are recorded as a known gap rather than duplicated as a
qualitative/quantitative pair.

## Verification

- `lake env lean LMLF/Blueprint/Gamma/Section517.lean` succeeds; all proof
  obligations are intentionally `by sorry` for statement coverage.
- `python3 -m json.tool coverage/sections/chapter5-517.json` succeeds.
- The standalone manual Lean command cannot run in this checkout because the
  `VersoManual` module is not present in the available Lake search path.
- `#check` is absent from the edited source and manual files.
- The source-TeX checker should be run by the parent integration task after
  registering the page with the current documentation build.
