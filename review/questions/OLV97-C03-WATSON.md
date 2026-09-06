# Architecture decision memo: Watson packet

**Audience:** an external model used for high-leverage library-design decisions

**Status:** advisory response received; provisional architecture recorded below;
no Lean authorization

**Repository snapshot originally sent for advice:** commit
`773ef08b0fd536813a0b14c5883bb9801d5198ec`

**Relevant drafts:** `blueprint/theorem_cards/QL-001.yaml`,
`blueprint/theorem_cards/OLV-001.yaml`, `blueprint/proofs/QL-001.md`, and
`blueprint/proofs/OLV-001.md`; the provisional disposition is incorporated in
their successor revision-2 drafts and is not yet bound to a frozen commit

**Source availability:** the private source snapshot is available to the local
project workflow at SHA-256
`08e1844d29a5ad21f89b9b600249ce18ac1665a5845be2d4e4219a3ededdc909`.
The copyrighted source bytes, OCR, and rendered pages are not stored in this
repository.

**Advisory response:** a GPT-6 Pro response was received on 2026-09-06 at
SHA-256
`a35bb2262144f59aac20e72efbed46204e12375a2ad239d50397326e12895c63`.
It was prepared against a different DjVu witness and an earlier repository
commit, and it was not a fresh-context formal referee. It is design input only:
it supplies no source attestation, review quorum, or implementation authority.
Every source claim adopted below was checked independently against the exact
private PDF.

## Current action requested

Please answer only the schema-level question in
**One remaining structural question for a future model pass** below.  The D1--D5
material is retained as an audit trail: it has already been answered
provisionally, checked against the supplied PDF, and incorporated into the
revision-2 Watson drafts.  Reopening those choices would require a concrete
architectural objection, not routine proof or Lean-level preferences.

We will handle transcription comparison, pinned-Mathlib search, routine edge
cases, proof details, and Lean implementation locally.  The requested response
should focus on the durable classification-schema boundary.

## Historical purpose and boundary

The original request was to decide the public semantic and dependency
architecture for the first Watson-lemma packet.  The following sections record
that request and the resulting disposition; they are context, not the current
question.  Do not spend review time checking equations line by line.

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

## Previously requested decisions (provisionally resolved)

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

A exposes the genuinely vector-valued bounded-primitive argument without
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

## Provisional disposition after the advisory response

The response resolves D1--D5 provisionally, subject to fresh theorem-card,
natural-language-proof, source-fidelity, and structural reviews against the
eventual frozen commit.

1. **D1/D4 — relational ordinary-improper semantics with a finite-exceptional
   adapter.** The source adapter records a finite exceptional set and separate
   one-sided Riemann limits at every exceptional endpoint. Every compact
   regular piece is represented in Lean by Mathlib's Bochner
   `intervalIntegral` with explicit integrability evidence; no second proper
   Riemann integral library is planned. Its useful proof object is a continuous
   normalized weighted primitive whose increment law holds on those pieces.
   The generic local-tail proof consumes that object; it does not require
   global Bochner local integrability. Cauchy principal value is a separate
   later adapter, because printed Exercise 3.4 introduces it as an extension
   rather than the default meaning of Theorem 3.1.
2. **D2 — generic kernel, complex source theorem.** The finite-piece
   Abel/Fubini kernel is intended for a complete normed real vector space. The Watson
   moment layer and Olver-facing theorem use complex-valued amplitudes and
   coefficients; a real specialization is a corollary. This matches the
   book's explicit real-or-complex convention for its Laplace framework
   without coupling the generic estimate to complex arithmetic.
3. **D3 — flat witnesses first.** Keep `k`, `K`, `X`, `L`, the finite
   exceptional set, and the primitive witness visible. A certificate structure
   is deferred until at least two consumers establish stable fields.
4. **D5 — five downward-only layers.** Use a small ordinary-improper relation,
   finite-exceptional primitive layer, and finite-piece Abel/Fubini identity; a
   generic local-tail estimate; a
   scalar Watson/Gamma-moment layer; the `Olver1997` source adapter and later
   qualitative audit consumer; and an independent section 9 global-majorant
   packet. No source module may be imported by the reusable layers.

One positive baseline `X` is chosen before the truncation order. The local and
primitive constants remain order-dependent. This quantifier order is now part
of the draft source-facing contract.

## One remaining structural question for a future model pass

The frozen `review/classifications-v2.json` makes `QL-001` its required example
of packet-level novelty `novel`. The advisory response correctly observes that
the underlying Abel/Dirichlet bounded-primitive estimate is classical, even if
our exact explicit packaging is new project work.

Should a future `classifications-v3.json` split **mathematical novelty** from
**formalization/package novelty**, migrate `QL-001` accordingly, and leave v2
immutable for already bound artifacts? Please answer only this schema-level
question. Do not mutate v2, rewrite existing historical bindings, review proof
details, or set `lean_ready`.

## Local work that does not need another large-model decision

The project team will independently settle exact Lean names, the representation
of ordered exceptional points, finite-partition telescoping, bridge lemmas to
Mathlib integrals under absolute integrability, routine edge tests, and the
eventual exact signatures. All of these remain behind the proof-before-Lean
review gates.
