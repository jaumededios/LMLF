# E0 implementation proposer evidence 01 — addendum 01

## Scope and frozen-candidate binding

This append-only correction supplements, and does not alter, `e0-implementation-proposer-01.md` (SHA-256 `95d955565ca7d2f6d0212b8a9a5a17f666b5c8af9250c6c471ceddc46b5efe66`). It changes no code, schema, fixture, original report, main-worktree file, CI state, or remote state. It supplies no approval, reviewer-independence finding, quorum credit, or integration authority.

Root froze the unchanged 66-file candidate as local commit `26f4051e13f3a7bc558c225138458f211bf31597`, tree `85bc0bbd802c2ae8044a3bf4f66e6f5cb00b542c`. The implementation proposer did not create that commit and did not push it.

Frozen-state verification produced exactly:

```text
$ git rev-parse HEAD
26f4051e13f3a7bc558c225138458f211bf31597
$ git rev-parse HEAD^{tree}
85bc0bbd802c2ae8044a3bf4f66e6f5cb00b542c
$ git status --short
[no output]
$ git diff --name-only e3b4cafa7f8d1e8b033806737eab23e641a401d8 HEAD | sort | wc -l
66
```

## Digest-set correction

All 66 individual SHA-256/path pairs printed in the original report are correct and match the frozen files. The original report's aggregate `2e5926ef10a7e3022fd9100c0bedbfa138ca43b397251d8dab3b8e6d05472d79` is not the hash of newline-delimited manifest bytes: it was inadvertently computed with the two literal bytes backslash and `n` after each record.

The corrected canonical encoding is: each already-listed lowercase SHA-256, two ASCII spaces, its repository-relative path, then one LF byte; records remain sorted by path; the final record also has an LF. The bytes are UTF-8 (and, for this ASCII manifest, byte-identical to ASCII). The corrected digest is:

```text
$ git diff --name-only e3b4cafa7f8d1e8b033806737eab23e641a401d8 HEAD | sort | xargs sha256sum | sha256sum
ada01f62cb31d08eb7dee69721b83b8ac07ac2876684a1b0dc1af1c8b2b70454  -
```

Independent extraction of the 66 displayed lines from the original report and comparison with the frozen paths produced exactly:

```text
report_rows=66 actual_rows=66 exact_individual_match=True
manifest_encoding=utf-8 final_lf=True sha256=ada01f62cb31d08eb7dee69721b83b8ac07ac2876684a1b0dc1af1c8b2b70454
```

Thus `ada01f62cb31d08eb7dee69721b83b8ac07ac2876684a1b0dc1af1c8b2b70454`, not `2e5926ef...`, is the canonical digest-set SHA-256 for this frozen candidate.

## Literal verification output correction

The original section labeled “Verification transcript” summarized or paraphrased several output lines. It should not be treated as literal stdout. The commands were rerun against frozen HEAD `26f4051e13f3a7bc558c225138458f211bf31597`; the following blocks are the complete captured stdout for each command. Exit statuses are recorded outside stdout.

`python3 -m compileall -q scripts` produced no stdout and exited 0.

`python3 -m tabnanny scripts/validate_inventory.py scripts/companion_contract.py` produced no stdout and exited 0.

`python3 scripts/validate_inventory.py` exited 0 and produced exactly:

```text
inventory validation passed: 148 occurrences, 31 notations, 32 entities, 34 entity evidence rows, 88 occurrence associations; classification examples [DEF-001, OLV-001, QB-001, QL-001, SR-001]; manifest totals [BOOTSTRAP-0=0, DEMO-0=0, IMPROPER-0=0, OLV-MVP-1=1]
```

`python3 scripts/validate_inventory.py --negative-tests --companion-tests` exited 0 and produced exactly:

```text
negative invariant tests passed: 25 intentionally invalid copied fixtures rejected
companion structural validation passed (no authority or readiness implied)
CandidateAtoms={"FX-B4.1": ["FX-O1", "FX-O2"]}
Target[synthetic_fixture_only]={"FX-B4.1": ["FX-O1", "FX-O2"]}
companion real-mode positive control passed: CandidateAtoms={"E0TEST-B4.1": ["E0TEST-O1", "E0TEST-O2"]}; Target omitted
companion negative tests passed: 74 focused adversarial fixtures rejected
inventory validation passed: 148 occurrences, 31 notations, 32 entities, 34 entity evidence rows, 88 occurrence associations; classification examples [DEF-001, OLV-001, QB-001, QL-001, SR-001]; manifest totals [BOOTSTRAP-0=0, DEMO-0=0, IMPROPER-0=0, OLV-MVP-1=1]
```

`git diff --check e3b4cafa7f8d1e8b033806737eab23e641a401d8 HEAD` produced no stdout and exited 0.

`lake build` exited 0 and produced exactly:

```text
ℹ [2753/2766] Replayed LMLFTest.Integral.Improper.IMP001Regressions
info: LMLFTest/Integral/Improper/IMP001Regressions.lean:23:0: @HasImproperIntegralAtTopExcept : {E : Type u_1} →
  [inst : NormedAddCommGroup E] → [NormedSpace ℝ E] → [CompleteSpace E] → (ℝ → E) → ℝ → Finset ℝ → E → Prop
info: LMLFTest/Integral/Improper/IMP001Regressions.lean:27:0: @HasImproperIntegralAtTopExcept.unique : ∀ {E : Type u_1} [inst : NormedAddCommGroup E] [inst_1 : NormedSpace ℝ E]
  [inst_2 : CompleteSpace E] {f : ℝ → E} {k : ℝ} {S : Finset ℝ} {I J : E},
  HasImproperIntegralAtTopExcept f k S I → HasImproperIntegralAtTopExcept f k S J → I = J
info: LMLFTest/Integral/Improper/IMP001Regressions.lean:33:0: @HasImproperIntegralAtTopExcept.finset_clm : ∀ {E : Type u_1} [inst : NormedAddCommGroup E] [inst_1 : NormedSpace ℝ E]
  {H : Type u_2} [inst_2 : NormedAddCommGroup H] [inst_3 : NormedSpace ℝ H] [inst_4 : CompleteSpace E]
  [inst_5 : CompleteSpace H] {A : Type u_3} (s : Finset A) (f : A → ℝ → E) (S : A → Finset ℝ) (I : A → E)
  (T : A → E →L[ℝ] H) {k : ℝ},
  (∀ i ∈ s, HasImproperIntegralAtTopExcept (f i) k (S i) (I i)) →
    HasImproperIntegralAtTopExcept (fun t ↦ ∑ i ∈ s, (T i) (f i t)) k (s.biUnion S) (∑ i ∈ s, (T i) (I i))
info: LMLFTest/Integral/Improper/IMP001Regressions.lean:44:0: @HasImproperIntegralAtTopExcept.split_regular : ∀ {E : Type u_1} [inst : NormedAddCommGroup E]
  [inst_1 : NormedSpace ℝ E] [inst_2 : CompleteSpace E] (f : ℝ → E) {a k : ℝ} (S : Finset ℝ) (I : E),
  a ≤ k →
    (∀ c ∈ S, k < c) →
      IntervalIntegrable f volume a k →
        (HasImproperIntegralAtTopExcept f a S ((∫ (t : ℝ) in a..k, f t) + I) ↔ HasImproperIntegralAtTopExcept f k S I)
info: LMLFTest/Integral/Improper/IMP001Regressions.lean:51:0: @IsFiniteExceptionalPrimitive : {E : Type u_1} →
  [inst : NormedAddCommGroup E] → [NormedSpace ℝ E] → [CompleteSpace E] → (ℝ → E) → ℝ → Finset ℝ → (ℝ → E) → Prop
info: LMLFTest/Integral/Improper/IMP001Regressions.lean:55:0: @IsFiniteExceptionalPrimitive.hasImproperIntegralAtTopExcept_exp_smul : ∀ {E : Type u_1} [inst : NormedAddCommGroup E]
  [inst_1 : NormedSpace ℝ E] [inst_2 : CompleteSpace E] {g F : ℝ → E} {k : ℝ} {S : Finset ℝ},
  IsFiniteExceptionalPrimitive g k S F →
    ∀ (h : ℝ),
      IntegrableOn (fun t ↦ Real.exp (-h * t) • F t) (Ioi k) volume →
        Tendsto (fun R ↦ Real.exp (-h * R) • F R) atTop (nhds 0) →
          HasImproperIntegralAtTopExcept (fun t ↦ Real.exp (-h * t) • g t) k S
            (h • ∫ (t : ℝ) in Ioi k, Real.exp (-h * t) • F t)
info: LMLFTest/Integral/Improper/IMP001Regressions.lean:65:0: @HasImproperIntegralAtTopExcept.of_integrableOn_Ioi : ∀ {E : Type u_1} [inst : NormedAddCommGroup E]
  [inst_1 : NormedSpace ℝ E] [inst_2 : CompleteSpace E] (f : ℝ → E) (k : ℝ) (S : Finset ℝ),
  (∀ c ∈ S, k < c) → IntegrableOn f (Ioi k) volume → HasImproperIntegralAtTopExcept f k S (∫ (t : ℝ) in Ioi k, f t)
info: LMLFTest/Integral/Improper/IMP001Regressions.lean:71:0: @hasImproperIntegralAtTopExcept_iff_exists_primitive : ∀ {E : Type u_1} [inst : NormedAddCommGroup E]
  [inst_1 : NormedSpace ℝ E] [inst_2 : CompleteSpace E] {f : ℝ → E} {k : ℝ} {S : Finset ℝ} {I : E},
  HasImproperIntegralAtTopExcept f k S I ↔ ∃ F, IsFiniteExceptionalPrimitive f k S F ∧ Tendsto F atTop (nhds I)
Build completed successfully (2766 jobs).
```

The frozen implementation remains at the E0 stop line stated in the original report. The two independent reviews of the exact frozen HEAD remain external to this proposer correction.
