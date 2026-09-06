# Primary adjudication finding: ROOT-SIG-N1

**Finding ID:** `ROOT-SIG-N1`  
**Severity:** P2  
**Bound snapshot:** `8af103fee3b2000033fc1e8c684645e529aaa841`  
**Disposition:** signature-proposal acceptance withheld pending repair and fresh review

This is an administrative adjudication finding recorded by the primary Codex
agent under the user's delegated project authority. It is not a referee report,
mathematical proof, peer-review verdict, quorum record, or independent approval,
and it counts as zero independent reviewers.

## Exact bounded issue

The frozen proposal's two `NegativeTypeShapeChecks` use
`fail_if_success exact <relation/equivalence>` while the outer goal is `True`.
Both checks therefore remain successful even under the signature mutations they
claim to reject: removing `IntegrableOn` from T07, or changing T08 to a fixed-F
shape. In either mutated case, the supplied relation or equivalence term still
cannot prove `True`, so `fail_if_success` succeeds for a reason unrelated to the
target type shape.

The claimed negative type-shape rejection evidence is therefore vacuous. This
is a validation-harness defect, not a mathematical defect in either target.

## Authority and pending disposition

Main remains clean and frozen at
`8af103fee3b2000033fc1e8c684645e529aaa841`. The primary Codex agent withholds
acceptance of this exact signature proposal. Any later independent approval of
the frozen proposal does not resolve `ROOT-SIG-N1`; acceptance remains withheld
until the guard is repaired and the repaired exact artifact is reviewed.

The original signature author has been assigned only to build a corrected,
author-owned new temporary harness and isolate signature-mutant sensitivity.
No candidate edit is authorized until the two already-active independent
signature reviews finish. Their partial reports have not been inspected, and
this note records no purported peer finding, verdict, or approval.

The next bounded step is to finish the pending independent reviews, assess their
completed reports separately, then freeze a repaired proposal and obtain fresh
review of its exact bytes and corrected negative guards. Final card, work
packet, registry/manifest authorization, external `lean_ready`, and production
implementation remain unavailable.
