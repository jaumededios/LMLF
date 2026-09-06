# IMP-001 R7 final-specification proposer evidence

**Record kind:** external proposer evidence; untrusted until independently verified  
**Specification commit:** `3a1b16cae6d186a20530de3b883c1bb871ee76f6`  
**Parent commit:** `9e6e038871ac66f80534626d3deade0b27af6752`  
**External envelope:** `IMP-001-review-envelope-pending.yaml`

This record supports dispatch of fresh final-specification review. It is not a
referee report, gate verdict, quorum record, `lean_ready` authorization,
implementation approval, or human review. Proposer and primary-agent
self-checks count as zero reviewers.

## Frozen specification bindings

| Artifact | Path | Revision | SHA-256 |
|---|---|---:|---|
| Work packet | `review/work_packets/IMP-001.yaml` | 1 | `e0f16a660417d967312df0f7cc7ce12ea1243226801b409475548566d594796b` |
| Theorem card | `blueprint/theorem_cards/IMP-001.yaml` | 7 | `d81f8970bcba3bf1a489f8cb4fea8b303a3e3bf6d1ad3ade37b42f3094b528c4` |
| Natural-language proof | `blueprint/proofs/IMP-001-R7.md` | 7 | `941ca0f2a7e402e9dd3636d7c93744290b3f5b52b8705484c18630c6fe173548` |
| Exact-signature proposal | `blueprint/theorem_cards/IMP-001-signatures-R6.md` | proposal 2, semantic R6 | `0e220214233fec5f2f95608789b139900e7dfddef8a6b824b8d54bce37e74f2d` |
| Classification schema | `review/classifications-v3.json` | 3 | `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e` |
| Lean toolchain file | `lean-toolchain` | — | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| Lake manifest | `lake-manifest.json` | — | `4bd9b595f84163f69bdb0ffc9b1a876b5df71d65bdd53122415610d083d43404` |

The exact Lean toolchain is `leanprover/lean4:v4.33.1`; the resolved Mathlib
revision is `0df444a360eaa60ab8c11dca51a86af692955474`.

The frozen `IMPROPER-0` manifest has one source-free card, eight targets, and
zero source occurrences. Production Lean, library dependencies, toolchain,
Lake manifest, and the manual-only GitHub workflow are unchanged. No production
IMP declaration was introduced.

The canonical NLP-IMP-001-R6 proof remains byte-for-byte unchanged at
`88f60d501c4261cba37b5d1f320406c258bde785ed3912720b3be897d6424f0e`.
NLP-IMP-001-R7 is a new frozen metadata-binding successor; its final reviewers
must assess its exact bytes and bindings rather than inherit an earlier proof
verdict.

## Authorship and freeze history

`imp_r6_signature_author` drafted the candidate specification. After a
temporary author-usage failure, the primary Codex agent acting under the user's
delegated project authority completed bounded mechanical corrections to YAML,
artifact digests, `LMLF.Results` import scope, verification-command order, and
IMP-R25's acceptance-cycle wording. These actions are proposer work and confer
no review credit.

The author's independent read-only preservation audit completed after root
freeze with no edits. Three fresh final referees A/B/C are now running against
the frozen specification; no result is recorded or inferred here. The pending
external envelope intentionally contains no reviewer IDs or verdict references.
All pre-Lean, implementation-review, composite, and merge gates remain pending.
Candidate implementation base/head SHAs remain null because this is the
pre-Lean specification stage.

Prior R6 natural-language, architecture, and exact-signature reports are
prerequisite historical evidence only. They count zero toward every final R7
quorum and do not establish a current gate result.

## Primary-agent self-check ledger

The primary Codex agent reported the following local checks against the frozen
specification:

- all 16 YAML files parsed;
- the card and packet contain eight byte-identical exact signature strings,
  matching proof anchors across exactly three modules;
- all upstream artifact hashes match;
- the packet contains no self path and no unresolved placeholder;
- all 25 separately mandatory IMP regressions and all 21 card-edge joins are
  represented;
- inventory validation passed with counts `148/31/32/34/88` and manifest totals
  `BOOTSTRAP-0=0`, `DEMO-0=0`, `IMPROPER-0=0`, `OLV-MVP-1=1`;
- the negative suite rejected all 25 intentionally invalid copied fixtures and
  then passed the same positive validation;
- `lake build` reported `Build completed successfully (2748 jobs).`; and
- `git diff --check` passed.

These are proposer self-checks, not independently verified gate evidence. No
GitHub CI run was started; user policy remains local testing only.

## Author preservation audit

The author reports that normalized R6 and R7 proof bodies are byte-identical:
62,434 bytes with SHA-256
`701a178dfb69889a1cc6be0c194881ecbd79d47e7e0411157fbb727caa53b676`.
Only the normalized frontmatter, opening lifecycle/signature-binding paragraph,
short status paragraph before the pinned ledger, one implementation-split
lifecycle sentence, and final remaining-gates section differ. All eight target
anchors and 38 numbered identities are unchanged.

The author also reports these byte-identical section hashes:

| Normalized section | SHA-256 |
|---|---|
| Target proof core | `f5574153533982ca7c1390f77f900d70c9a793d987cb7fed66ef28fd35441196` |
| Boundary and audit | `f473ffd574af371ebc997b1985ca241a9837a65c4b287a2a12a02a66e23e1ddd` |
| Regression obligations | `ee11026250ade8f44983090253042389fd1b23c1f399aa6fa3c6de358adffc02` |
| Reconstruction | `34adb090b096639e2df65ea6ec0844ac09112beb898a447bbe16e31fd5ef7737` |

The author reran the YAML, digest, target, 25-regression plus 21-edge-join,
and type-harness checks; all passed and the author reported no material issue.
This preservation audit is proposer-only evidence. It is not an independent
review, contributes zero reviewer IDs, and establishes no gate result.

## Disposable eight-type equality check

The primary Codex agent used disposable file
`/tmp/lmlf-imp-r7-freeze-check.1lNWr1lA/PacketTypes.lean`, SHA-256
`180f0f1cf9e6e310afd59506c266280c5aef777a8daacf68c18ac94cd48f6fca`,
against the valid repaired R6 harness rooted at
`/workspace/Documents/Codex/imp-r6-negative-fix.XT854T`.

The check exited 0 with 17 unused-binder style warnings. It checks all eight
fully quantified packet types by `example := @accepted_harness_declaration`.
Because the six imported theorem targets are axioms, this is type equality only
and is not theorem-proof evidence.

Reproduction command from the harness root:

```sh
lake env lean /tmp/lmlf-imp-r7-freeze-check.1lNWr1lA/PacketTypes.lean
```

Exact disposable source:

```lean
import LMLF.Integral.Improper.Abel
import LMLF.Integral.Improper.Bochner

/-! Disposable R7 packet-type equality checks against the reviewed R6 signature harness. The imported six theorem targets remain axioms; this is not target proof evidence. -/

open Filter MeasureTheory Set
open scoped Interval
noncomputable section

-- IMP-001-T01
example : ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [CompleteSpace E] (f : ℝ → E) (k : ℝ) (S : Finset ℝ)
    (I : E),
    Prop :=
  @LMLF.Integral.HasImproperIntegralAtTopExcept

-- IMP-001-T02
example : ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [CompleteSpace E] {f : ℝ → E} {k : ℝ} {S : Finset ℝ}
    {I J : E}
    (hI : LMLF.Integral.HasImproperIntegralAtTopExcept f k S I)
    (hJ : LMLF.Integral.HasImproperIntegralAtTopExcept f k S J),
    I = J :=
  @LMLF.Integral.HasImproperIntegralAtTopExcept.unique

-- IMP-001-T03
example : ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {H : Type*} [NormedAddCommGroup H] [NormedSpace ℝ H]
    [CompleteSpace E] [CompleteSpace H]
    {A : Type*} (s : Finset A) (f : A → ℝ → E)
    (S : A → Finset ℝ) (I : A → E) (T : A → E →L[ℝ] H)
    {k : ℝ}
    (h : ∀ i ∈ s,
      LMLF.Integral.HasImproperIntegralAtTopExcept
        (f i) k (S i) (I i)),
    LMLF.Integral.HasImproperIntegralAtTopExcept
      (fun t => ∑ i ∈ s, T i (f i t)) k
      (s.biUnion S) (∑ i ∈ s, T i (I i)) :=
  @LMLF.Integral.HasImproperIntegralAtTopExcept.finset_clm

-- IMP-001-T04
example : ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [CompleteSpace E] (f : ℝ → E) {a k : ℝ} (S : Finset ℝ)
    (I : E) (hak : a ≤ k) (hS : ∀ c ∈ S, k < c)
    (hf : IntervalIntegrable f MeasureTheory.volume a k),
    LMLF.Integral.HasImproperIntegralAtTopExcept
        f a S ((∫ t in a..k, f t) + I) ↔
      LMLF.Integral.HasImproperIntegralAtTopExcept f k S I :=
  @LMLF.Integral.HasImproperIntegralAtTopExcept.split_regular

-- IMP-001-T05
example : ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [CompleteSpace E] (g : ℝ → E) (k : ℝ) (S : Finset ℝ)
    (F : ℝ → E),
    Prop :=
  @LMLF.Integral.IsFiniteExceptionalPrimitive

-- IMP-001-T06
example : ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [CompleteSpace E] {g F : ℝ → E} {k : ℝ} {S : Finset ℝ}
    (hF : LMLF.Integral.IsFiniteExceptionalPrimitive g k S F)
    (h : ℝ)
    (hInt : MeasureTheory.IntegrableOn
      (fun t => Real.exp (-h * t) • F t) (Set.Ioi k))
    (hLim : Filter.Tendsto
      (fun R => Real.exp (-h * R) • F R)
      Filter.atTop (nhds 0)),
    LMLF.Integral.HasImproperIntegralAtTopExcept
      (fun t => Real.exp (-h * t) • g t) k S
      (h • ∫ t in Set.Ioi k, Real.exp (-h * t) • F t) :=
  @LMLF.Integral.IsFiniteExceptionalPrimitive.hasImproperIntegralAtTopExcept_exp_smul

-- IMP-001-T07
example : ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [CompleteSpace E] (f : ℝ → E) (k : ℝ) (S : Finset ℝ)
    (hS : ∀ c ∈ S, k < c)
    (hf : MeasureTheory.IntegrableOn f (Set.Ioi k)),
    LMLF.Integral.HasImproperIntegralAtTopExcept
      f k S (∫ t in Set.Ioi k, f t) :=
  @LMLF.Integral.HasImproperIntegralAtTopExcept.of_integrableOn_Ioi

-- IMP-001-T08
example : ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [CompleteSpace E] {f : ℝ → E} {k : ℝ} {S : Finset ℝ}
    {I : E},
    LMLF.Integral.HasImproperIntegralAtTopExcept f k S I ↔
      ∃ F : ℝ → E,
        LMLF.Integral.IsFiniteExceptionalPrimitive f k S F ∧
          Filter.Tendsto F Filter.atTop (nhds I) :=
  @LMLF.Integral.hasImproperIntegralAtTopExcept_iff_exists_primitive
```

## Pending review state

The external envelope is initialized with empty reviewer sets and every gate
pending. The three planned fresh final referees may be dispatched only against
this exact frozen specification and external binding. Their eventual verdicts
must establish the packet's actual card, natural-language-proof, structural,
and overall distinct-reviewer requirements before the composite `lean_ready`
gate can be adjudicated.

Implementation-review and merge gates remain pending and inapplicable to the
current pre-Lean-only evidence. No candidate implementation base or head exists,
and no production implementation work is authorized by this record.
