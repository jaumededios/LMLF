# QB-001 revision 3 review ledger

**Normative owner:** `jaumededios`  
**Proof artifact:** `blueprint/proofs/QB-001.md`, revision 3  
**Card artifact:** `blueprint/theorem_cards/QB-001.yaml`, artifact revision 3;
specification revision unchanged  
**Signature artifact:** `blueprint/theorem_cards/QB-001-signatures.md`, revision 1  
**Final proof status:** `approved`  
**Final implementation status:** `authorized` for the eight signatures only

This ledger records the three mathematical review rounds.  It does not replace
implementation review, Lean compilation, or the external baseline-commit
record.

## Round 1 — initial review

**Outcome:** changes requested; not an approval of later revisions.

The initial review identified specification-integrity issues in the larger proof
dossier.  The subsequent revision made multi-premise domains explicit,
preserved the product cross term, distinguished the two sharper product bounds,
stated their actual-versus-approximant norm hypotheses, and fixed the required
normed-space/ring assumptions.  It also made clear that `HasErrorFamily` asserts
neither convergence nor monotone improvement.

## Round 2 — revision 2 review

**Outcome:** changes requested; superseded by revision 3.

Two remaining findings were resolved in revision 3:

1. The biadditive perturbation identity was made explicitly pointwise, so its
   function arguments and factor order cannot be misread.
2. Public declaration names for the exactness/conversion results and
   `NormBoundOn.min` were frozen rather than left implicit in prose.

The BOOTSTRAP-0 theorem card subsequently bounded implementation scope to the
eight signatures in `QB-001-signatures.md`; the rest of the approved proof
dossier remains unauthorized until separately carded.

## Round 3 — revision 3 independent approvals

Both referees reviewed the same frozen revision independently in fresh Sol
contexts.  Neither authored the packet, and neither approval relies on the
other's report.

### `proof_referee_a`

**Verdict:** `approved`

The referee found the bounded eight-signature proof/card mathematically correct.
The required hypotheses, generic empty-domain behavior, explicit domain
transport, and the absence of any convergence claim are all visible.  No
mathematical statement or signature change was requested.

### `proof_referee_b`

**Verdict:** `approved`

The referee independently confirmed the three definitions and five transport
arguments, including exactness, restriction direction, majorant weakening,
additive transitivity, and precomposition via `Set.MapsTo`.  Boundary cases and
the correspondence with the signature artifact were accepted without change.

## Disposition and authorization

All mathematical findings from rounds 1 and 2 are resolved in proof revision 3.
The two distinct round-3 approvals set `proof_status` and `review_status` to
`approved`.  Implementation is `authorized` only for:

1. `QuantitativeAnalysis.ErrorOn`
2. `QuantitativeAnalysis.NormBoundOn`
3. `QuantitativeAnalysis.HasErrorFamily`
4. `QuantitativeAnalysis.ErrorOn.exact`
5. `QuantitativeAnalysis.ErrorOn.restrict`
6. `QuantitativeAnalysis.ErrorOn.weaken`
7. `QuantitativeAnalysis.ErrorOn.trans`
8. `QuantitativeAnalysis.ErrorOn.comp`

Lean elaboration, axiom checks, import checks, and implementation rubrics remain
future gates.  No excluded proof-dossier result is authorized by this ledger.
