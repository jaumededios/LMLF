# Architecture decision memo: Watson packet

**Audience:** an external model used for high-leverage library-design decisions

**Status:** decision request for draft theorem cards; no Lean authorization

**Repository snapshot:** commit `773ef08b0fd536813a0b14c5883bb9801d5198ec`

**Relevant drafts:** `blueprint/theorem_cards/QL-001.yaml`,
`blueprint/theorem_cards/OLV-001.yaml`, `blueprint/proofs/QL-001.md`, and
`blueprint/proofs/OLV-001.md`

## Purpose and boundary

Please decide the public semantic and dependency architecture for the first
Watson-lemma packet. We will handle transcription comparison, pinned-Mathlib
search, routine edge cases, proof details, and Lean implementation locally.
Do not spend review time checking equations line by line.

The mathematical core is the following. If a remainder `phi` obeys a local
bound

\[
  \|\phi(t)\|\le Kt^{\beta-1}\quad(0<t\le k),\qquad \beta,k>0,
\]

and its baseline weighted primitive

\[
  F(t)=\int_k^t e^{-Xv}\phi(v)\,dv
\]

obeys `norm (F t) <= L` for `t >= k`, then for `x > max X 0` the
improper Laplace integral exists and

\[
 \left\|\int_0^\infty e^{-xt}\phi(t)\,dt\right\|
 \le K\Gamma(\beta)x^{-\beta}+Le^{-(x-X)k}.
\]

Olver's eventual-convergence hypothesis supplies one positive baseline
parameter (X), common to all truncation orders; the local and primitive-bound
constants (k_n,K_n,L_n) are then existential and order-dependent.
Named-function applications will instead supply effective constants. The
source allows improper convergence and does not clearly require absolute
convergence, so replacing its integral by Mathlib's totalized whole-ray
Bochner integral would strengthen or distort the theorem.

## Decisions requested

### D1. Canonical improper-integral semantics

Choose the canonical public representation of a possibly conditionally
convergent integral.

- **A — relational limit predicate (current recommendation):** define a
  predicate relating an integrand and value through `Tendsto` of finite
  interval integrals. State theorems using that relation; add bridges to
  Mathlib set integrals after absolute integrability is known.
- **B — partial-value API:** package convergence evidence with a uniquely
  determined integral value and make that package the primary theorem input
  and output.
- **C — Bochner/set-integral API:** state the public theorem with
  `MeasureTheory.Integrable` and the ordinary set integral, accepting absolute
  convergence as the library contract.

A is source-faithful and keeps existence explicit, but creates a small new
integration layer. B may improve downstream ergonomics but risks premature
packaging. C maximizes immediate Mathlib reuse but loses the conditional case.

Please decide whether A, B, C, or a precisely described hybrid should be the
canonical layer. If A or B, specify whether the primitive relation should be
one-sided at infinity plus an explicit split point, or a single two-endpoint
relation on `(0, infinity)`.

### D2. Scalar and codomain generality

Choose the generality boundary between reusable analysis and source-facing
theorems.

- **A — generic kernel, scalar wrappers (current recommendation):** prove the
  local-tail estimate for a complete normed real vector space, then state the
  Gamma-moment/Watson layer for real and complex scalars as appropriate.
- **B — complex-first:** use complex-valued amplitudes throughout and derive
  the real theorem by coercion or specialization.
- **C — real-first:** formalize only the real case until a concrete complex
  consumer appears.

A exposes the genuinely vector-valued integration-by-parts argument without
forcing Gamma-moment algebra into an over-general statement. B gives one
scalar API but may couple generic infrastructure to complex coercions. C is
smallest but likely creates later duplication.

Please decide the stable public boundary, including whether the generic
kernel is worthwhile before a second concrete consumer exists.

### D3. Quantitative witness packaging

The reusable theorem needs `k`, `K`, `X`, and `L` as usable data; the
source-facing theorem only proves that such witnesses exist.

- **A — flat theorem arguments (current recommendation):** expose the four
  constants and their hypotheses directly. Introduce a structure only after
  repeated consumers reveal a stable abstraction.
- **B — certificate structure:** define a reusable local-tail certificate
  containing the constants, domain facts, local majorant, and primitive
  bound; make application theorems construct certificates.
- **C — existential-only public API:** hide the witnesses in the generic
  theorem and provide separate extraction results when needed.

A is transparent and resists a one-use wrapper. B may become the right input
to automation and named-function instances, but fixes fields and coercion
choices early. C is closest to the qualitative source and least useful for
quantitative applications.

Please decide what should be public in the first release and what should be
deliberately deferred.

### D4. Interior singularities and the scope of the first integration layer

Olver permits finitely many discontinuities or infinities. There are three
plausible scopes:

- **A — singularity-agnostic core (current recommendation):** formulate the
  generic local-tail theorem only in terms of the finite interval integrals
  and limit relations it actually uses. Put finite-breakpoint bookkeeping in
  source adapters when a source example requires it.
- **B — finite-breakpoint API now:** make a finite ordered singularity set and
  componentwise improper convergence part of the foundational integral
  definition.
- **C — locally Bochner-integrable first release:** support unbounded points
  only when the function is still locally absolutely integrable; postpone
  conditionally convergent interior singularities.

A keeps the core small but must be designed carefully enough that an adapter
can represent all source cases without changing theorem statements. B is most
literal but creates substantial framework before a concrete use. C is
pragmatic but records a real source-coverage limitation.

Please decide the supported semantics for the first release and state exactly
which source cases, if any, may be deferred.

### D5. Packet and module dependency graph

The proposed layering is:

1. a small improper-integration module containing limit predicates,
   uniqueness, linearity, splitting, and bridges to Mathlib integrals;
2. a generic Laplace local-tail module proving the bounded-primitive estimate;
3. a finite Watson module combining that estimate with Gamma moments;
4. an `Olver1997` source adapter deriving existential witnesses and recovering
   the printed qualitative asymptotic expansion;
5. a separate later packet for the stronger global-majorant estimate in
   section 9 and, later still, its best-exponent suprema.

This direction prevents source-specific definitions from entering reusable
analysis and prevents the stronger section 9 hypothesis from being silently
used in the Chapter 3 theorem. The cost is several public layers for the first
example.

Please approve this graph or give a replacement graph. In particular, decide
whether layers 2 and 3 should remain separate, which declarations should be
public, and whether the qualitative recovery belongs in the source module or
in a general asymptotics bridge.

## Constraints not being reopened in this review

- The proof-derived local-tail inequality and the stronger section 9 global
  majorant remain distinct theorem packets.
- No infinite series is integrated; every conclusion is at a fixed finite
  truncation order.
- Quantitative constants may depend on the truncation order unless uniformity
  is explicitly assumed.
- Source-facing declarations must not encode the desired conclusion or a
  stronger section 9 hypothesis inside an opaque structure field.
- Natural-language proof review and source-fidelity review remain separate
  gates. This memo is only for architecture.

## Requested response

Return one decisive recommendation for each of D1-D5, with a brief reason and
the principal rejected alternative. Then give:

1. one coherent module/dependency diagram;
2. pseudocode-level signatures for the canonical improper-integral relation,
   generic local-tail theorem, and source-facing Watson theorem;
3. a short list of decisions that must be frozen before Lean work, separated
   from choices safe to defer.

Optimize for a durable LMLF-wide foundation, not merely the shortest Watson
proof. If two decisions interact, resolve them together rather than returning
an unranked menu. Do not set `lean_ready`; implementation authorization remains
a separate review-envelope decision.
