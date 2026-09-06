# IMP-001 analytic-regression companion R1 disposition

**Supplement:** `IMP-001-REG-R1`  
**Companion commit:** `9b3ad2e903bb182cafe8d7c13e7cbfe80f8538b7`  
**Companion SHA-256:** `c10dcbc498d80b98f24473a367546963c0b9d6713d99e73e21fd834ff8eedd4c`  
**Pending envelope SHA-256:** `fd13506194ddc37dbf8b5c5fe8e8f0380ac58981c030370b3c7909ceb53e0ba1`  
**Outcome:** `changes_required`

This is an administrative disposition and adjudication by the primary Codex
agent `/root` acting under the user's delegated project authority. It is not a
third referee report or human review and counts as zero reviewers. It does not
alter the immutable pending envelope, reports, verdicts, or companion bytes.

## Exact review evidence

| Reviewer | Artifact | SHA-256 | Verdict and finding |
|---|---|---|---|
| `/root/imp_reg_nl_referee_a` | `imp_reg_nl_referee_a.md` | `ec2405cb0426b9e96a4c1e10df9901e2659fed74bb6e9855b7220b34a4e60c69` | `request_changes`; `A-REG-M02-001` (P2) |
| `/root/imp_reg_nl_referee_a` | `IMP-001-REG-natural_language_review-imp_reg_nl_referee_a.json` | `456537d54e80dabd3eccbfa648a329fd7cf4ef64e551606b3bb75bc04f0b7cfa` | `request_changes`; `A-REG-M02-001` (P2) |
| `/root/imp_reg_nl_referee_b` | `imp_reg_nl_referee_b.md` | `3923451683bbf89640592fdc6b95b2c56b1c3add7d1c7cbb1fad70a208a178ba` | `request_changes`; `B1` (P2) |
| `/root/imp_reg_nl_referee_b` | `IMP-001-REG-natural_language_review-imp_reg_nl_referee_b.json` | `e88bf3c1ffcb9f445c3ad7b5b4d4c54e7030ad16ded657576c38c8556c5058b8` | `request_changes`; `B1` (P2) |

Both fresh reviewers independently identified the same material defect. Their
verdict JSONs bind the exact pending envelope, core artifacts and passing core
authority, companion commit and digest, pinned toolchain and Mathlib revision,
and regression-only scope. Neither verdict counts toward the core pre-Lean
quorum.

## Sustained finding

R1 cites `intervalIntegral.integral_comp_mul_deriv` for substitution while its
side-condition ledger supplies only continuity on the finite image interval.
At pinned Mathlib revision
`0df444a360eaa60ab8c11dca51a86af692955474`,
`IntegrationByParts.lean` lines 531--534 show that the unprimed theorem requires
global `Continuous g`. Lines 521--524 define
`intervalIntegral.integral_comp_mul_deriv'` with the matching local premise
`ContinuousOn g (f '' [[a, b]])`.

For the reciprocal substitution, the naturally transformed expression is
continuous on the image interval but singular at zero; the cutoff model also
does not supply the global continuity claimed by the unprimed API. The displayed
substitution identities and the remaining analytic derivations are otherwise
mathematically correct, but the frozen dependency citation is not usable from
the premises R1 records.

The primary agent independently inspected the pinned Mathlib declaration types
at lines 521--534 and sustains `A-REG-M02-001` and `B1` as the same valid P2
substitution-API mismatch.

## Disposition and scope

The R1 supplemental outcome is `changes_required`. R1 grants no authority to
formalize its new analytic regressions in Lean, and no passing supplemental
envelope or authorization record exists. No analytic regression Lean was
attempted.

The existing core IMP-001 pre-Lean authority at specification commit
`3a1b16cae6d186a20530de3b883c1bb871ee76f6` remains unchanged. This finding
does not reopen or alter the core theorem-card, natural-language-proof,
structural, or composite `lean_ready` gates, and it changes no public target or
premise.

A successor is being authored at the new path
`blueprint/proofs/IMP-001-REG-R2.md`. It is expected to correct the
local-continuity substitution theorem and its side-condition ledger. That work
has no inherited approval: after it is frozen at exact new bytes, at least two
fresh independent mathematical reviewers must approve the successor before any
new analytic regression it supplies may be formalized in Lean.
