# IMP-001 endpoint-regression proposer checkpoint

This external checkpoint records proposer evidence for the bounded endpoint
regression slice at candidate head
`b99b3c0dccb19ebab7efa21c00a80b9157069f9c`. It is not a referee verdict,
implementation acceptance, merge authorization, or whole-IMP completion claim.
The final independent implementation-review quorum remains pending.

## Candidate and authorization binding

- Implementation base: `0f4df472dd2c97267dbc2c2128975eb3277132e0`.
- Full IMP-R24 commit:
  `e13b07b591667e3da4c732d8cc6601de21b28b0c`.
- Positive IMP-R22 Gamma commit and checkpoint head:
  `b99b3c0dccb19ebab7efa21c00a80b9157069f9c`.
- `LMLFTest/Integral/Improper/IMP001EndpointAE.lean` SHA-256:
  `313171f874e6f89b3b5ed6d6b87e4670fe3a3d22dba0eeb378790a7b9ee4dd2e`.
- `LMLFTest/Integral/Improper/IMP001GammaEndpoint.lean` SHA-256:
  `9bcbed11516602f5685891d0228e7d73fc0c19baec149e5ee8e9895bc8333c70`.
- Registered `lakefile.toml` SHA-256:
  `8d14a7e8c01e985e7141a39e946de284602c11378063b6024f8c37d71288e7ee`.
- The diff from the implementation base through this head contains exactly the
  two test files above and their two test-target registrations in
  `lakefile.toml`. Production Lean files are unchanged.

The original core specification and dependency pins remain unchanged:

- specification commit:
  `3a1b16cae6d186a20530de3b883c1bb871ee76f6`;
- `review/work_packets/IMP-001.yaml` SHA-256:
  `e0f16a660417d967312df0f7cc7ce12ea1243226801b409475548566d594796b`;
- `blueprint/theorem_cards/IMP-001.yaml` / `TC-IMP-001-R7` SHA-256:
  `d81f8970bcba3bf1a489f8cb4fea8b303a3e3bf6d1ad3ade37b42f3094b528c4`;
- `blueprint/proofs/IMP-001-R7.md` / `NLP-IMP-001-R7` SHA-256:
  `941ca0f2a7e402e9dd3636d7c93744290b3f5b52b8705484c18630c6fe173548`;
- `blueprint/theorem_cards/IMP-001-signatures-R6.md` /
  `SIG-IMP-001-R6-P2` SHA-256:
  `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d`;
- `review/classifications-v3.json` SHA-256:
  `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`;
- Lean toolchain `leanprover/lean4:v4.33.1`, resolved Mathlib revision
  `0df444a360eaa60ab8c11dca51a86af692955474`, and
  `lake-manifest.json` SHA-256
  `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404`.

The bounded analytic-regression authorization is the external
`lean-ready-envelope-r2.yaml`, SHA-256
`ee3fb545a1772eae460cfaa39ecf45b1d7d4c075461f2424577ee273dce25d9c`,
and `root-adjudication-r2.md`, SHA-256
`b1b77b956d19ea8c0f741d2d7111f98b8c31e38d27b89d01cb811a3e1dbafb17`.
Both bind `blueprint/proofs/IMP-001-REG-R2.md`, SHA-256
`316fc09bf3f35a5649f951ea0964ed1330e540d028a48c4706312d37c87ae7e9`.

## Implemented regression content

All declarations are nonproduction tests in namespace
`LMLFTest.Integral.Improper`.

IMP-R24 is fully implemented. Its planned main theorem is
`LMLFTest.Integral.Improper.finiteEndpoint_update_iff`. For an arbitrary
complete normed real vector space, arbitrary finite `S`, and arbitrary
integrands equal off `{k} ∪ S`, the file proves:

- global almost-everywhere equality from finite-set nullity;
- interval `IntervalIntegrable` equivalence and totalized interval-integral
  equality (REG.50);
- honest `IntegrableOn` equivalence and set-integral equality on `Ioi k`
  (REG.51);
- the full fixed-primitive T05 equivalence (REG.53);
- invariance of the existential right-hand side of public T08 (REG.54);
- T01 invariance for every value, derived through public T08 without opening
  T01's private representation (REG.52); and
- explicit two-sided T07 transport from either honest `IntegrableOn` witness,
  including both integrability witnesses, equal values, and both public T07
  conclusions under exactly `∀ c ∈ S, k < c`.

The positive half of IMP-R22 is implemented by
`LMLFTest.Integral.Improper.initialEndpoint_integrable_example`. The theorem
uses the exact function
`fun t => if k < t then Real.exp (-(t - k)) / Real.sqrt (t - k) else 0`.
It proves honest integrability on `Ioi k`, exact set integral
`Real.Gamma (1 / 2)`, strict positivity of that value, and the public T07
instance for arbitrary finite `S` under exactly `∀ c ∈ S, k < c`.
The proof uses the pinned Gamma convergence, integral, and positivity theorems
plus measure-preserving translation. The negative conditional, non-`L¹`
initial-endpoint example is not included here; IMP-R22 is not complete until
that separately assigned regression is finished and integrated.

## Verification evidence

The proposer ran direct Lean checks for both new files. After registration of
both modules, the proposer also ran the default `lake build`; it completed all
2756 jobs successfully. There were no warnings or errors. The only additional
build output was the existing informational `#check` replay from
`IMP001Regressions.lean`. `git diff --check` passed, and the new files contain
no `sorry`, `admit`, `axiom`, `unsafe`, heartbeat override, recursion-depth
override, or other trust/resource escape.

The proposer diagnostic reported exactly these axioms for each new main
theorem:

- `LMLFTest.Integral.Improper.finiteEndpoint_update_iff`:
  `propext`, `Classical.choice`, `Quot.sound`;
- `LMLFTest.Integral.Improper.initialEndpoint_integrable_example`:
  `propext`, `Classical.choice`, `Quot.sound`.

The root agent independently inspected both final files and explicitly reports
rerunning the direct Lean checks, the full local build, and LSP axiom checks at
the bound commits, all passing with the same results. These are root/proposer
self-checks only. They supply no independent implementation-referee credit and
do not change the pending implementation-review or merge gates.
