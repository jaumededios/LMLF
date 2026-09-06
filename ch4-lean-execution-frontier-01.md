# Chapter 4 Lean execution frontier 01

## Status and outcome

Read-only external preparation audit, 2026-09-06. It grants no source, signature, implementation, coverage, approval, quorum, or adjudication credit.
It creates no production IDs or counts. The reviewed LMLF snapshot was clean
`main` at `b8d2f731fcfd5cd0889d0732f13699eb94681c86`; Lean is `v4.33.1` and
Mathlib is exactly `0df444a360eaa60ab8c11dca51a86af692955474`. Programme input was the supplied
exact `stage_1_dlmf-R7.md` at proposal commit `aebe7968bd6d5dcd23ac949d5d5e0d8854334ca1`,
especially §§1, 3--6, 9, and 11. The shortest credible execution order is:

1. complex exponential structural laws;
2. the entire circular/hyperbolic bridge (`sin`, `cos`, `sinh`, `cosh` only);
3. conditionally, nonzero-base principal complex powers after an exact branch/entity review.

Do not start with `Ln`, reciprocal trigonometric/hyperbolic functions, or
Lambert W. Those are mathematical representation gaps, not missing wrappers.

## Evidence boundary and local-first search

The required library inventory found 16 Lean files and no Chapter 4 semantic module. Local `rg` found only incidental uses of `Real.exp`, `Real.log`,
`Real.sin`, `Real.cos`, and complex power in the existing improper-integral and
Gamma work. There is therefore no local declaration to reuse or migrate.

Limited discovery inspected only the official Chapter 4 landing page and
§§[4.2](https://dlmf.nist.gov/4.2), [4.8](https://dlmf.nist.gov/4.8),
[4.13](https://dlmf.nist.gov/4.13), [4.14](https://dlmf.nist.gov/4.14), and
[4.28](https://dlmf.nist.gov/4.28). These locators are leads, not a canonical
document census, source partition, denominator, or source approval. No raw page
payload is reproduced here. Future exact-payload retention needs an authorized
route consistent with the [DLMF notice](https://dlmf.nist.gov/about/notices).

## Pinned availability comparison

| Family | Pinned canonical surface | Execution verdict |
|---|---|---|
| exponential | `Complex.exp`, addition, inverse, zero-free, period, norm, real/imaginary decomposition; complex differentiability | ready; strongest first packet |
| logarithm | `Complex.log` plus inverse laws and exact branch predicates; `Real.log` | partial: Mathlib chooses one `(-pi,pi]` value and `log 0 = 0`; DLMF also uses multivalued `Ln` and a two-sided closed cut |
| powers | `Complex.cpow` and `Real.rpow`, with explicit totalization and branch hypotheses | conditionally ready only for source claims matching principal `cpow` at nonzero base |
| trig/hyperbolic | canonical complex and real `sin/cos/tan/sinh/cosh/tanh`, addition, Euler and imaginary-argument bridges | `sin/cos/sinh/cosh` ready; quotient families need pole-domain work |
| Lambert family | no Lambert W, Wright omega, or Tree T definition/theorem found anywhere in pinned Mathlib; the only `Lambert` hit is unrelated Lambert series | blocked; not a first packet |

Pinned sources: [`Complex.exp`](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/Complex/Exponential.lean#L60-L63), [`Complex.log`](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/SpecialFunctions/Complex/Log.lean#L27-L39),
[`Complex.cpow`](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/SpecialFunctions/Pow/Complex.lean#L22-L38), and [complex trig/hyperbolic definitions](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/Complex/Trigonometric.lean#L28-L60).

## G1 (P1): packet EXP-C0 -- complex exponential core

Bounded mathematical target: only reviewed source-owning leaves whose atoms state the period,
absence of zeros, inverse-at-negation, norm, and (optionally) entirety of complex exponential.
Discovery leads are the prose and formulas in DLMF §4.2(iii); they are not packet membership yet.

Exact reuse, with no hypotheses unless shown:

- `Complex.exp_periodic : Function.Periodic Complex.exp (2 * Real.pi * Complex.I)`;
- `Complex.exp_ne_zero (z : ℂ) : Complex.exp z ≠ 0`;
- `Complex.exp_neg (z : ℂ) : Complex.exp (-z) = (Complex.exp z)⁻¹`;
- `Complex.norm_exp (z : ℂ) : ‖Complex.exp z‖ = Real.exp z.re`;
- `Complex.exp_add (z w : ℂ) : exp (z+w) = exp z * exp w` for the exact
  addition-law leaf if selected;
- `Complex.differentiable_exp : Differentiable ℂ Complex.exp` for an
  independently atomized “entire” prose target.

Import `Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic` for the first
five; add `Mathlib.Analysis.SpecialFunctions.ExpDeriv` only if the entire or
derivative atom is in the closed packet. The substantive implementations are
[the period theorem](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/SpecialFunctions/Trigonometric/Basic.lean#L1201-L1204),
[zero-free/inverse laws](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/Complex/Exponential.lean#L161-L169), and
[the norm identity](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/Complex/Trigonometric.lean#L983-L985).

No semantic `LMLF.exp`, alias theorem, or conjunction wrapper should be added. An exact
Mathlib-interface reuse record plus a tiny exact-signature regression consumer should terminate each exact match. Only
notation/orientation bridges required for a faithful source statement belong
downstream in `LMLF/Audit/SourceRecovery`, never in semantic code.

Gates: review exact selected bytes plus annotations; close their leaf ownership
and atomization; approve `DLMF exp <-> Complex.exp`, `i <-> Complex.I`, complex
norm, real part, and period semantics; classify each as ordinary exact or
structural; then freeze a finite execution manifest and obtain `lean_ready`.
Natural-language work is a short exact-declaration/notation correspondence,
plus the standard explanation that complex differentiability everywhere is
the source's “entire”. No new mathematical proof is needed for exact matches.

Consumers: packet G2; principal powers; later Chapter 5 Gamma, Chapter 6
exponential integrals, Chapter 8 incomplete Gamma, and exponential
representations in Chapters 9--10. These are planning consumers, not reviewed
support edges.

## G2 (P1): packet TRIGHYP-C0 -- entire-function bridge

Bounded target: reviewed atoms for the exponential definitions of complex
`sin/cos/sinh/cosh`, Euler's two signs, `cosh z +/- sinh z`, and the
imaginary-argument relations. Discovery leads are DLMF §§4.14 and 4.28. Exclude
`tan/cot/sec/csc/tanh/coth/sech/csch`, their zeros, and their poles.

One import suffices: `Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic`. Reuse directly:

- canonical definitions `Complex.sin`, `Complex.cos`, `Complex.sinh`,
  `Complex.cosh`;
- `Complex.cos_add_sin_I`, `Complex.cos_sub_sin_I`;
- `Complex.cosh_add_sinh`, `Complex.cosh_sub_sinh`;
- `Complex.sin_mul_I`, `Complex.cos_mul_I`;
- useful nontrivial closure already present: `Complex.sin_add`,
  `Complex.cos_add`, `Complex.sinh_add`, `Complex.cosh_add`, and
  `Complex.cosh_sq_sub_sinh_sq`.

The exact statements and proofs are in
[Trigonometric.lean](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/Complex/Trigonometric.lean#L116-L150),
[the exponential/imaginary bridges](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/Complex/Trigonometric.lean#L281-L320), and
[Euler/Pythagorean identities](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/Complex/Trigonometric.lean#L457-L481).

NL proof need: only algebraic normalization between DLMF's `i*z`, `i*sin z`,
and division by `2*i` and Mathlib's commuted forms. Disposable Lean examples
verified those normalizations using the canonical definitions, `I_sq`, and
ring reasoning. Keep these source-facing equalities in recovery; do not create
semantic wrappers around the definitions.

Gates match G1 and additionally require a single reviewed choice of complex
rather than merely real entities. Downstream consumers include Chapter 6
sine/cosine and hyperbolic integrals, Chapter 7 Fresnel families, and later
oscillatory Airy/Bessel representations; exact edges await their own manifests.

## G3 (P2, conditional): packet CPOW-C0 -- nonzero principal powers

Proceed only after the source/entity review proves that the selected atoms mean
the same single-valued principal power as `Complex.cpow`. Import only
`Mathlib.Analysis.SpecialFunctions.Pow.Complex`. Candidate exact reuse:

- `Complex.cpow_def_of_ne_zero (ha : a ≠ 0) (z : ℂ) :
  a ^ z = Complex.exp (Complex.log a * z)`;
- `Complex.cpow_add (z1 z2 : ℂ) (ha : a ≠ 0) :
  a ^ (z1+z2) = a^z1 * a^z2` (source orientation by symmetry);
- `Complex.cpow_natCast (a : ℂ) (n : ℕ) : a ^ (n : ℂ) = a ^ n`.

These are exact at
[Pow/Complex.lean](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/SpecialFunctions/Pow/Complex.lean#L35-L45) and
[the exponent-add law](https://github.com/leanprover-community/mathlib4/blob/0df444a360eaa60ab8c11dca51a86af692955474/Mathlib/Analysis/SpecialFunctions/Pow/Complex.lean#L71-L88).
NL proof need is just multiplication-order/orientation normalization for exact
matches. Do not expose Mathlib's `0^0=1` totalization as DLMF semantics unless
the exact source atom explicitly supplies it.

## Exact blockers and do-not-refactor decisions

1. Mathlib has `(Complex.log z).im` in `(-pi,pi]`, `log 0 = 0`, and one value
   on the negative cut. DLMF's default closed convention treats two cut sides
   and also has multivalued `Ln`. No alias can repair that object mismatch.
2. The endpoint mismatch is executable: `Complex.log_mul_eq_add_log_iff` uses
   `arg x + arg y in Ioc (-pi) pi`, and `Complex.log_exp` assumes
   `-pi < Im z` and `Im z <= pi`; discovery formulas in §4.8 display closed
   lower bounds. Those atoms require exact side conventions or a new reviewed
   multivalued model and complete NL proof.
3. `Complex.cpow` is principal and totalized. General multivalued powers are
   absent. Do not use `Real.rpow` to under-prove a complex source occurrence.
4. Lean's field division totalizes at zero. The DLMF quotient families are
   meromorphic with poles; named `sec/csc/sech/csch/coth` are also absent.
   Defer them until domains/poles and entity totalization are explicit.
5. Lambert `W_k`, legacy `Wp/Wm`, Wright omega, and Tree T are all absent.
   Defining one by choice from `w*exp w=z` would launder existence, uniqueness,
   branches, and analyticity. Their first honest packet needs constructions or
   reviewed existence/uniqueness on explicit domains, branch identifications,
   complete NL proofs, and structural-circularity review.

Rubric disposition: mathematical intent and dependency direction favor G1--G2;
the reusable seam is already Mathlib, so wrapper extraction is rejected; public
signatures stay canonical; imports are narrow and semantic-to-recovery only;
proof architecture isolates branch/pole models; no performance claim was made;
and no existing API, consumer, or compatibility surface changes. There is no
local-proof handoff until a source batch, target statement, and signature are
externally authorized.

## Reproducible Lean checks and limitations

In disposable `/tmp/lmlf-ch4-check.oeJBjR`, `lake env lean` accepted separate harnesses
for the imports above. `#check` printed every signature quoted here; compiled examples proved
the DLMF-oriented exponential period, inverse, norm,
Euler, imaginary-argument, hyperbolic-square, and exponent-add forms. The
Lambert result is from exhaustive case-insensitive `rg` over pinned
`Mathlib/` (only unrelated “Lambert series” occurred), not an assertion about
future Mathlib. The harnesses are not production artifacts and prove no source
identity, completeness, coverage, or axiom audit. No repository code, schema,
card, Verso, CI, commit, or remote state was changed.
