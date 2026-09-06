# IMP-001 Abel-regression proposer checkpoint

**Checkpoint role:** proposer/root-local implementation evidence only  
**Candidate commit:** `a52868015516bae5200f39a0b5d03228e3111101`  
**Scope:** nonpublic analytic regressions `IMP-R11`, `IMP-R12`, and `IMP-R13`

## Exact bindings

- Implementation: `LMLFTest/Integral/Improper/IMP001AbelExamples.lean`
  - SHA-256: `73b7cfcd90aee475ad0ae8e4bd68e843918672be470ef13f38431ebd4a88feee`
- Test registration: `lakefile.toml`
  - SHA-256: `70f49995fb2ac39ea65489a17c1462a6c9048864324caa8b42b4db3d07911775`
- Reviewed companion: `blueprint/proofs/IMP-001-REG-R2.md`
  - artifact `NLP-IMP-001-REG-R2`, revision 2
  - SHA-256: `316fc09bf3f35a5649f951ea0964ed1330e540d028a48c4706312d37c87ae7e9`
- Supplemental Lean-ready envelope:
  - SHA-256: `ee3fb545a1772eae460cfaa39ecf45b1d7d4c075461f2424577ee273dce25d9c`
- R2 root adjudication:
  - SHA-256: `b1b77b956d19ea8c0f741d2d7111f98b8c31e38d27b89d01cb811a3e1dbafb17`
- Toolchain: `leanprover/lean4:v4.33.1`
- Resolved Mathlib revision: `0df444a360eaa60ab8c11dca51a86af692955474`

The R2 supplemental natural-language gate passed with two fresh approvals
(`/root/imp_reg_nl_referee_c` and `/root/imp_reg_nl_referee_d`) and authorized
bounded nonpublic formalization of these three regressions. It did not authorize
a public API change or constitute implementation acceptance.

## Implemented regression declarations

- `LMLFTest.Integral.Improper.discontinuousPrimitive_counterexample`
  (`IMP-R11`): the exact zero integrand and discontinuous step primitive satisfy
  every T05 field except continuity; the weighted primitive has integral
  `exp (-1) > 0`, while the weighted integrand has only improper value zero.
- `LMLFTest.Integral.Improper.endpointOnly_counterexample` (`IMP-R12`): the
  exact continuous compact polynomial bump matches the zero-integrand endpoint
  law, fails at the midpoint, and gives a strictly positive weighted bump
  integral for every `h > 0`, contradicting the substituted finite Abel law.
- `LMLFTest.Integral.Improper.indicatorPrimitive_nondifferentiable`
  (`IMP-R13`): the exact closed-interval indicator and clipped primitive satisfy
  T05; the primitive is bounded, eventually constant, and nondifferentiable at
  both 1 and 2; all positive exponential-weight hypotheses and exact values are
  recorded.

The `REG.42` calculation is independent of the IMP conclusions it tests. It
splits the weighted `FI` integral at 1 and 2, evaluates the middle interval by
the reviewed FTC antiderivative
`-exp (-h*t) * ((t-1)/h + 1/h^2)`, evaluates the tail directly, and derives
`(exp (-h) - exp (-2*h)) / h^2`. T06 is used only once, as the final consumer
that produces the R13 improper-integral value
`(exp (-h) - exp (-2*h)) / h`; T07 is not used. The direct weighted-indicator
integral is retained as an independent cross-check.

## Local verification recorded

Proposer-local checks completed without warnings: direct Lean elaboration,
the named Lake target (`2742/2742`), the default Lake build (`2757` jobs), the
required local referee preflight, trust/resource-marker scan, and diff check.
Root separately performed a full source read, direct Lean elaboration, the full
`2757`-job build, and LSP axiom inspection of all three primary theorems. Each
reported only `[propext, Classical.choice, Quot.sound]`.

These are proposer and root-local checks, not independent implementation
review. Overall IMP-001 acceptance remains incomplete: oscillatory regressions
`IMP-R04`, `IMP-R05`, and `IMP-R06`, plus the negative `IMP-R22` case, remain
pending. This checkpoint makes no claim of independent review, merge approval,
full regression completion, or full IMP acceptance.
