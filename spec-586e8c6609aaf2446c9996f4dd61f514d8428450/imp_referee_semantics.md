# Independent mathematical referee report: IMP-001

## Verdict

**REQUEST_CHANGES**

The six target statements have sound mathematical semantics, the finite Abel
identity is correct, and the boundary is sufficient for the stated QL-001 and
OLV-001 consumers without assuming either downstream conclusion. One material
proof-completeness gap remains in the regular-point insertion argument used to
prove T03. It is local and does not require changing any target statement, so
this is not a block.

Separate rubric verdicts:

- **Theorem-card/source-semantics contract: APPROVE.** The quantifiers,
  relation semantics, six target shapes, classification, and QL/OLV-facing
  boundary are mathematically sound. This is approval of the mathematical
  card content at the reviewed bytes, not approval of the deliberately absent
  exact Lean signature artifact.
- **Natural-language proof correctness: REQUEST_CHANGES.** IMP-F1 must be
  repaired before this proof revision can pass.
- **Structural circularity, source-to-target reachability, and
  hypothesis/choice laundering: APPROVE.** Dependencies point from IMP to
  QL/OLV, the primitive field is strictly weaker than the QL conclusion, and
  no target value, exceptional set, primitive, or order-dependent object is
  hidden by choice.
- **Overall: REQUEST_CHANGES**, determined by the nonpassing proof verdict.

This verdict concerns source-independent semantics, proof correctness,
dependency direction, downstream reachability, and hypothesis/choice
laundering. It is not a `lean_ready` decision or an implementation review.

## Snapshot and isolation

- Reviewed commit: `586e8c6609aaf2446c9996f4dd61f514d8428450`.
- Method: resolved the exact commit and expanded `git archive` into the
  disposable directory `/tmp/imp-referee-586e8c66-hH2Yqg`; no file was read
  from the live worktree for the substantive review.
- Core card SHA-256: `537051e1e23a446636d5dbf8e2d8113792818b0b5b8c7736db88f23c6de0cbfa`
  (matches the supplied binding).
- Core proof SHA-256: `c714c16c2e462bdf3bb09bc8ff91258d3061cc4084f1f4c555c19cda9789439d`
  (matches the supplied binding).
- Classification SHA-256:
  `8c9f8dbb5ab351771a433a9901fe176a66ec214092c5d5880b3ec57c9a5b23e9`
  (matches the bindings in the reviewed artifacts).
- Isolation strength: manual fresh archive and fresh referee context. This was
  not a technically enforced clean-room run.
- No other referee report was read.
- No repository file was edited.

Inspected artifacts were exactly the requested IMP-001 card/proof,
`review/PROTOCOL.md`, `review/classifications-v2.json`,
`blueprint/automation/proof_artifact_schema.md`, the QL-001 and OLV-001
cards/proofs, and `review/questions/OLV97-C03-WATSON.md`.

## Finding

### IMP-F1 — P1 — T03 refinement omits the analytic fact that creates the new endpoint limits

Location: `blueprint/proofs/IMP-001.md`, `IMP-001-I02` and
`target-imp-001-t03`, with corresponding dependency and side-condition
ledgers.

T03 refines each exceptional set `S_i` to the finite union by repeatedly
inserting a point `d` at which the relevant summand is regular. The dossier
says that splitting truncations at `d` by adjacent-interval additivity “gives
two endpoint limits.” Additivity identifies sums of integrals once the
integrals exist, but it does not by itself prove either new one-sided limit at
the newly marked regular endpoint. The missing input is the variable-endpoint
continuity (equivalently, absolute continuity) of the Bochner indefinite
integral for a function integrable on a compact neighborhood of `d`:

\[
  \int_u^x f \longrightarrow \int_u^d f \quad (x\to d),
  \qquad
  \int_x^v f \longrightarrow \int_d^v f \quad (x\to d).
\]

That fact is true under the stated regular-piece `IntervalIntegrable`
hypothesis, so the theorem is not false. Nevertheless it is non-elementary,
is not supplied by `IMP-M01`, and is neither proved nor bound in the dependency
ledger. The proof-artifact schema requires such a step to be derived internally
or tied to a pinned declaration. Without it, IMP-I02 does not yet prove all
clauses of the refined T01 relation, and T03's proof is incomplete.

Why P1: T03 is a public target and the refinement is the indispensable route
from individual `S_i` to their union. The omission prevents the natural-language
proof gate from passing, although the repair is bounded and statement-preserving.

#### Exact acceptance condition for IMP-F1

Issue a new proof revision that does all of the following:

1. Add a pinned Mathlib dependency, or a complete internal lemma, proving the
   following exact claims from `IntervalIntegrable f p q`, for every
   `p < d < q`:

   \[
   \int_p^b f\longrightarrow\int_p^d f\quad(b\uparrow d),
   \qquad
   \int_a^q f\longrightarrow\int_d^q f\quad(a\downarrow d).
   \]

   Equivalently, bind/prove continuity at `d` of both variable-endpoint
   indefinite integrals, with the first limit on the left-neighborhood filter
   of `d` and the second on the right-neighborhood filter. A proof through
   norm-integrability and absolute continuity/dominated convergence is
   acceptable.
2. Use it in IMP-I02 to construct the new finite endpoint limits, not merely
   the equality of their sums.
3. State and prove the actual refinement result needed by T03: if
   `HasImp(f,k,S,I)`, `d > k`, and `d` is not in `S`, then
   `HasImp(f,k,insert d S,I)` (and the deletion converse), using the relation's
   regular-piece integrability to discharge the compact-neighborhood premise.
   Check it in all component shapes: the empty-set component
   `[k,infinity)`, the initial bounded component, an interior bounded
   component, and the final unbounded component. Show both directions and
   show that the total related value is unchanged.
4. Update `IMP-M*`/`IMP-A*` and regression `IMP-R03` so the dependency and its
   side conditions are explicit.
5. Rebind the revised proof/card digests in a fresh external review round, as
   required by the protocol.

There are no P0, P2, or P3 findings.

## Independent re-derivation of the six targets

### T01 — finite-exceptional right-ray relation

For `S = {c_1 < ... < c_m}` with every `c_i > k`, the components are
`[k,c_1)`, `(c_i,c_{i+1})`, and `(c_m,infinity)`. On each component, compact
regular truncations are explicitly Bochner interval-integrable. The first
component has a left-to-right limit, every interior component is the sum of
independent right-of-left-endpoint and left-of-right-endpoint limits, and the
last component has an independent right-of-`c_m` limit plus an at-top limit.
Their finite sum is the proposed value. For `S = empty`, this reduces to the
one-sided limit of `intervalIntegral f k R` at positive infinity.

Changing an interior anchor from `d` to `e` adds the fixed proper integral
`integral d e` to the left contribution and subtracts it from the right
contribution. Hence the component sum, and therefore the relation, is anchor
independent. Values of `f` at isolated exceptional points do not enter; the
approach to each side does.

### T02 — uniqueness

Two witnesses for the same `f,k,S` use the same ordered components. Each
corresponding endpoint function tends to both proposed component limits along
a nontrivial one-sided or at-top filter in a Hausdorff normed space. Uniqueness
of limits makes every component contribution equal; finite summation then
gives `I = J`. No existence claim or choice-selected value is introduced.

### T03 — finite-union continuous-linear combination

Let `S_A` be the literal finite union of the `S_i`. Mathematically, a summand
regular at each point of `S_A \ S_i` can be refined to `S_A` without changing
its value: the indefinite integral is continuous at the inserted regular
point and adjacent-interval additivity makes the two new component sums
recombine to the old one. This is the valid route whose missing cited step is
IMP-F1.

After refinement, all summands share `S_A`. On every regular truncation,
continuous real-linear maps commute with Bochner integration and finite sums
preserve integrability. At every finite side and at infinity, continuity of
the maps and finiteness of the index set commute the endpoint limit with the
sum. Interchanging the two finite sums yields exactly

\[
  \operatorname{HasImp}\left(\sum_i T_i\circ f_i,k,S_A,
  \sum_i T_i(I_i)\right).
\]

This includes zero, addition, negation, real scalar multiplication, and fixed
complex multiplication viewed as a continuous real-linear map.

### T04 — prepending a regular interval

For `a <= k`, let `J = integral_a^k f`. On every truncation beyond `k`,

\[
  \int_a^R f = J + \int_k^R f,
\]

and, before a first exceptional point, the analogous identity holds with the
moving upper endpoint. All later component limits are unchanged. Thus

\[
  \operatorname{HasImp}(f,a,S,J+I)
  \iff \operatorname{HasImp}(f,k,S,I).
\]

The sign and order are correct. The reverse implication subtracts the fixed
`J`; restriction and adjacent-interval closure give the equivalent regular
integrability clauses. At `a = k`, `J = 0`.

### T05 — normalized finite-exceptional primitive

The predicate requires `S` above `k`, continuity of explicit `F` on
`[k,infinity)`, `F(k)=0`, and, on every closed regular interval,
`IntervalIntegrable g` together with

\[
  F(b)-F(a)=\int_a^b g.
\]

At an exceptional point, continuity of `F` turns the increment law on each
side into two independent finite endpoint limits. It does not assert a limit
at infinity, boundedness, convergence at a new Laplace weight, or an error
estimate. It is therefore sufficient for finite exceptional gluing while not
containing the QL conclusion.

### T06 — derivative-free finite Abel identity

Let `G(t)=integral_a^t g`. For `a <= b`, define on the product rectangle

\[
 H(t,v)=1_{\{a\le v\le t\le b\}}e^{-ht}\mathbin{\bullet}g(v).
\]

With `M = exp(|h| max(|a|,|b|))`,

\[
  \lVert H(t,v)\rVert
  \le 1_{[a,b]^2}(t,v)M\lVert g(v)\rVert.
\]

The majorant is product-integrable: Tonelli reduces its norm integral to
`M (b-a) integral_[a,b] ||g(v)||`, which is finite by
`IntervalIntegrable g a b`. Restricted a.e. strong measurability follows from
that of `g`, Borel measurability of the triangle and exponential, and
continuity of scalar multiplication. Hence Bochner Fubini is legitimate and

\[
 \int_a^b e^{-ht}\mathbin{\bullet}G(t)\,dt
 =\int_a^b\left(\int_v^b e^{-ht}\,dt\right)
       \mathbin{\bullet}g(v)\,dv.
\]

The scalar FTC, with no division by `h`, gives
`h integral_u^v exp(-ht) dt = exp(-hu)-exp(-hv)`. Multiplication and
linearity therefore give

\[
 h\mathbin{\bullet}\int_a^b e^{-ht}\mathbin{\bullet}G(t)\,dt
 =\int_a^b e^{-ht}\mathbin{\bullet}g(t)\,dt
  -e^{-hb}\mathbin{\bullet}(F(b)-F(a)).
\]

Since the all-`t` increment law says `F(t)=F(a)+G(t)`, the constant part
contributes `(e^{-ha}-e^{-hb}) bullet F(a)`. Rearrangement yields exactly the
stated boundary signs. At `h=0`, it reduces to the increment law; at `a=b`,
all integrals vanish and the boundary terms cancel. The proof uses no
derivative of `F`.

## Focused semantic audits

- **Ordinary improper versus principal value:** pass. Every finite exception
  has independent one-sided limits; no common cutoff is available. A cutoff
  multiple of `1/(t-c)` is rejected, while the conditionally convergent
  `sin(1/(t-c))/(t-c)` example can be accepted separately on both sides.
- **Totalization firewall:** pass. T01, T03, T04, T05, and T06 carry explicit
  finite-piece `IntervalIntegrable` evidence. No conclusion follows merely
  from the value of Mathlib's totalized integral at a nonintegrable function.
- **Anchors:** pass except for the separate regular-insertion proof gap in
  IMP-F1. Anchor changes cancel by exact adjacent additivity.
- **T04 signs/orientation:** pass. The prepended value is `integral_a^k f + I`,
  not its negative, and the theorem explicitly restricts to `a <= k`.
- **T05 sufficiency/laundering:** pass. Continuity plus the regular increment
  law supplies all finite exceptional side limits needed by componentwise
  Abel; the bound on `F` and the at-infinity argument remain QL hypotheses and
  proof obligations.
- **T06 Fubini:** pass. The dossier gives a valid compact-product majorant and
  a legitimate Bochner Fubini route. An implementation must express the
  restricted a.e.-measurability carefully; this is proof plumbing, not an
  additional hypothesis.
- **Quantifiers:** pass. T03 has one common `k`, explicit `S_i`, their literal
  union, and finite maps; T04 fixes `I` before prepending; T06 quantifies every
  real `h`; no object depends on a Watson truncation order.
- **Choice:** pass. Finite sorting is canonical, anchors are deterministic and
  immaterial, `F` and all exceptional sets are explicit, and no improper value
  is selected by choice.

## Six-target boundary and downstream reachability

The boundary is sufficient after IMP-F1 is repaired.

For QL-001-T01, instantiate T05 with
`g(t)=exp(-X t) bullet phi(t)` and put `h=x-X>0`. Apply T06 on each regular
piece. Continuity of `F` cancels opposite exceptional boundary terms. The
bound on `F`—a QL hypothesis, not an IMP field—kills the at-infinity boundary
and absolutely controls `h integral exp(-h t) F(t)`. This constructs the T01
relation for the weighted tail. T04 prepends the locally integrable `[0,k]`
piece. No public finite-exception Abel theorem is necessary; the finite
telescoping is a private QL proof helper.

For QL-001-T02, T03 combines the remainder with finitely many model moments on
the literal union of exceptional sets (the smooth model terms use the empty
set); T02 identifies the resulting relational value. Whole-set Gamma moment
bridges under absolute integrability can remain private Mathlib adapters.

For OLV-001, eventual convergence at one common baseline `X`, together with
T03 and the absolutely convergent finite model moments, gives ordinary
baseline convergence of each remainder. The source adapter may then define
the explicit accumulated `F_n` component by component, choose constants so it
is continuous through each exception, and prove the T05 predicate. Its limit
at infinity plus compact continuity yields the external bound `L_n`. Applying
QL supplies the target estimate. This construction does not require a seventh
public IMP target and does not assume the target weighted integral or error
bound.

Accordingly, do not add a public primitive-construction or split-Abel wrapper
solely for these two consumers. Private helpers are appropriate until an
independent second consumer establishes a reusable API. The missing
regular-endpoint continuity lemma should likewise be internal unless later use
justifies exposing it.

## Lifecycle conditions outside this verdict

Even after IMP-F1 is corrected, implementation remains unauthorized until the
new revision is frozen and bound to exact signatures/imports, the required
theorem-card, proof, and structural-circularity quorums approve the same
digests, the ID/registry and manifest conditions are reconciled, and an
external envelope sets `lean_ready` to `pass`. The present draft's candidate
status fields are not gate evidence.
