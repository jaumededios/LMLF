# Bessel source revision 2 — independent source-referee report

## Binding and decision

- Exact reviewed commit: `4147deda85688ac5e6e7dc0868a45c0f60dc7036`
- Review perspective: source semantics, source-to-inventory/API boundary, and scope fidelity
- Reviewer ID: `/root/def_bern_002_referee_a/bessel_source_r2_referee_c`
- Reviewer kind: independent Codex agent
- Model/runtime record: OpenAI GPT-5-family Codex agent in the Codex desktop Linux runtime; no more granular model identifier was exposed to this session
- Isolation strength: `manual_attestation`, not `technically_enforced`
- Isolation method: fresh-context reviewer; exact commit exported with `git archive` into disposable directory `/tmp/bessel-source-r2-referee-c.LlaCYd`; only that extraction, the supplied private PDF, the original brief, and the required PDF/Lean referee instructions were read. No live dirty-worktree file and no prior referee report was inspected. No repository or inventory file was edited.

Artifact bindings verified with ordinary SHA-256:

| Artifact | SHA-256 |
| --- | --- |
| Private source PDF `/tmp/codex-web-uploads-5qVFkz/ccbc2d4c-f600-4d0a-90ec-eeeb25e7cdce` | `08e1844d29a5ad21f89b9b600249ce18ac1665a5845be2d4e4219a3ededdc909` |
| `blueprint/source_transcriptions/OLV97-C02-BESSEL-JI.md` | `f157c9fc8688da02a680661c185a8a5458a24ba5b6dd77641190a4393d6e5439` |
| `blueprint/source_transcriptions/OLV97-C12-BESSEL-REAL-AUX.md` | `13d223d6e088582f2eb9c4fbc282cb4d1a8acf29abd32d6f28e26918d42acc5b` |

Per-file verdicts:

| File | Verdict |
| --- | --- |
| `blueprint/source_transcriptions/OLV97-C02-BESSEL-JI.md` | **APPROVE** |
| `blueprint/source_transcriptions/OLV97-C12-BESSEL-REAL-AUX.md` | **APPROVE** |

**Atomic inventory integration may begin: YES**, limited to provisional source-inventory integration under the binding conditions below. This approval is not an entity-identification approval, theorem-card approval, manifest-membership decision, source-coverage claim, or Lean authorization.

## Material findings

No material source-fidelity, mathematical-normalization, attribution, or scope finding remains in either reviewed file.

## Binding conditions on the approved integration

1. Integration must bind the exact commit and hashes above. A change to either transcription body or the source snapshot requires fresh review.
2. The proposed atomic queues are planning metadata, not CSV-ready rows. Their richer labels must be mapped one-for-one to the controlled `inventory-v1.0.0` values before insertion, or a separately reviewed versioned inventory-schema migration must first add the needed values. In particular, current planning labels such as `source_property`, `figure`, `footnote`, `notation_definition`, `normalization_check`; `qualitative_support`, `exercise_target`, `source_auxiliary_geometry`, `source_reference`, `source_report`, `source_notation`, `source_table_metadata`; and `direct_figure`/`direct_table` are not values accepted by the archived validator. They must not be copied into the authoritative CSVs as though already canonical. This is an expected normalization boundary explicitly signaled by the files' “proposes no CSV edit” language, not a defect in the approved mathematical transcription.
3. Preserve a documented one-to-one mapping from each proposed occurrence ID to any final canonical occurrence ID. The review found 58 Chapter 2 proposed rows and 61 Chapter 12 proposed rows, all with one scalar value in each queue column, no duplicate proposed IDs, and no collision with an existing `blueprint/inventory/occurrences.csv` ID at the reviewed commit.
4. The rendered page ranges may be recorded as independently reviewed page evidence, and the two exact Markdown transcriptions may be recorded as verified source-transcription artifacts. Occurrence/entity/notation reconciliation must nevertheless remain unresolved or provisional wherever the files say it is unresolved—especially general-order origin semantics, cut-boundary semantics, Exercise 9.3–9.7 domains and paths, real/complex entity bridges, integral-order `Y`/`K` continuation, the exact identity of Chapter 12 Exercise 1.1's `c`, and source-wide alias/entity consolidation.
5. `OLV97-C02-BES-J-FIG0901` and `OLV97-C12-BES-TABLE-X` record only the existence and role of an omitted figure/table. They must not be marked as though the figure geometry or numerical table values were transcribed or verified from these Markdown files. Use an honest metadata/summary status supported by the canonical schema, or defer those rows until the schema can represent that distinction.
6. Keep every exercise occurrence classified as an exercise target, not as an assertion proved in the surrounding exposition. Preserve the source's inherited-but-incomplete branch/domain conditions rather than inventing a principal-cut boundary theorem, a straight-line path for Exercise 9.7, or path independence.
7. No integration step may confirm Bessel entities, create or register `DEF-BES-*`/`CMP-BES-*` cards, select a manifest, claim source recovery, or authorize implementation. Those later gates remain exactly as stated in the archived Bessel family programme and source-manifest policy.

## Source evidence

### Chapter 2, printed pp. 55–61 / PDF pp. 68–74

All seven PDF pages were rendered independently at 3× resolution and inspected visually. The bundled Poppler executable was unusable on this host because it required GLIBC 2.38; the fallback renderer was PyMuPDF 1.28.2 in the disposable review directory. Visual review, not text extraction, was the authority.

- Printed p. 55 / PDF p. 68 confirms the integer-order domain, Bessel integral (9.01), order/argument roles, entireness cross-reference, and exponential form (9.02). The preceding Airy material and Exercise 8.1 are correctly excluded.
- Printed p. 56 / PDF p. 69 confirms the positively oriented contour form (9.03), contour deformation, origin derivatives, the exact powers and alternating sign in (9.04), `J_{-n}=(-1)^nJ_n` in (9.05), and the all-`z`, nonzero-`h` Laurent generating function (9.06).
- Printed p. 57 / PDF p. 70 confirms (9.07)–(9.11): both Bessel-equation forms, the general-order series with `(z/2)^ν`, `(z²/4)^s`, `s! Γ(ν+s+1)`, local uniformity of the normalized series, separate order/spatial semantics, the principal branch, and the continued-branch rule `J_ν(ze^{mπi})=e^{mνπi}J_ν(z)`. The footnote's warning that the integer integral argument does not extend to general order is represented without promoting it to a new definition.
- Printed p. 58 / PDF p. 71 confirms Schlaefli's loop formula (9.12), the principal-at-crossing/continuous-along-loop power convention, the `τ`-contour endpoints and exponent in (9.13), the strict `|ph z|<π/2` continuation range, Fig. 9.1's existence, and (9.14). The figure is expressly not reconstructed.
- Printed p. 59 / PDF p. 72 confirms (9.15)–(9.16), `J'_0=-J_1`, Exercises 9.1–9.6, and the beginning of Exercise 9.7. The four half-integral signs and prefactors, both repeated-derivative identities, Poisson prefactor/domain, and both Exercise 9.6 bounds match.
- Printed p. 60 / PDF p. 73 confirms the two Fresnel sums completing Exercise 9.7, every assumption and factor in Exercise 9.8, the `I_ν` series (10.01), rotation factor `e^{-νπi/2}` in (10.02), unequal-principal-cut footnote, modified equation (10.03), recurrences (10.04)–(10.05), Chapter 7 pointer, and Exercise 10.1.
- Printed p. 61 / PDF p. 74 confirms the exact half-open phase ranges and the second factor `e^{3νπi/2}` in Exercise 10.2; the signs/powers in Exercises 10.3–10.6; principal-at-`ph z=0` continuation language for Exercises 10.4–10.5; the Kelvin rotation factors; and the boundary at the beginning of section 11.

The revision correctly treats Exercises 9.3–9.7 as inherited-branch targets with unresolved maximal domains. In particular it does not invent cut-boundary admission for Exercises 9.3–9.6, and it leaves the path, endpoint, homotopy, and path-independence semantics of `∫₀ᶻ J_ν(t) dt` in Exercise 9.7 open.

### Chapter 12, printed pp. 435–438 / PDF pp. 448–451

All four PDF pages were rendered and inspected visually.

- Printed p. 435 / PDF p. 448 confirms the shared real domain `ν≥0, x>0` through section 7; joint continuity/positivity and both spatial/order monotonicity directions for `I` and `K`; (1.01)–(1.03) with bounded-`ν` uniformity at infinity; the ordered Wronskian `W{K,I}=1/x`; and all four (1.05) recurrences with the essential neutral notation choice `ℒ_ν=I_ν` or `e^{νπi}K_ν`.
- Printed p. 436 / PDF p. 449 confirms the signs and factors in (1.06)–(1.12), the positive-integer exceptions after order replacement, bounded-`ν` uniformity in (1.09), the ordered Wronskian `W{J,Y}=2/(πx)`, zero interlacing and one-based indices in (1.13), fixed-order zero asymptotics (1.14), and the definition of the smallest positive balancing root.
- Printed p. 437 / PDF p. 450 confirms `0<X_ν<y_{ν,1}`; the positive-real square-root weight (1.16); `d(E_ν²)/dx=-2/(πxJ_ν²)`; continuity, positivity, and nonincrease; the zero-safe modulus/continuous-unwrapped-phase system (1.17)–(1.20); zero phases `(s-1)π` and `(s-1/2)π`; and every power and prefactor in (1.22)–(1.24).
- Printed p. 438 / PDF p. 451 confirms the intermediate `+2mπ` phase, `m∈ℤ`, the continuity-in-`ν` argument making `m` independent of `ν`, and the order-`1/2` chain `J_{1/2}`, `Y_{1/2}`, `X_{1/2}=π/4`, `θ_{1/2}=x-π/2` forcing `m=0`. It also confirms that the numerical `X_ν` table exists but need not be reproduced; the table footnote reports that `X_ν` increases with `ν` and cites Watson (1944, §15.6). Exercise 1.1 has `X_ν=ν-c(ν/2)^{1/3}+O(ν^{-1/3})` with `c=-0.36605…`, described only by a Chapter 11 §2.2 cross-reference. The transcription correctly keeps `c` neutral and unresolved rather than inventing an exact identification.

The two Wronskian displays consistently determine the local convention `W{f,g}=fg'-f'g`; no sign reversal was found. The phase is correctly treated as a continuously unwrapped phase, not a pointwise principal arctangent through zeros.

## API, classification, and scope evidence

- The artifacts remain copyright-safe mathematical transcriptions in fresh prose. No page image, figure geometry, numerical table values, or extended source prose is presented as repository source content.
- Main-exposition assertions, exercises, footnotes, normalization checks, cross-references, and omitted visual/table metadata are kept distinguishable. Scope stops at section 11 on printed p. 61 and before Chapter 12 section 2/2.1 content on printed p. 438.
- The Bessel family programme preserves the required dependency direction: locked source collation and entity split precede construction/identification; exceptional-order continuation precedes Hankel use; exact basis/Wronskian facts precede modulus/phase applications; named quantitative applications remain downstream.
- The planning queues do not purport to freeze theorem-card classifications. The archived `lmlf-classification-v2` packet/target vocabulary is not used to claim source coverage or approval, and the files expressly disclaim card registration, manifest membership, reconciliation, and implementation authorization.
- There is no Lean declaration or proof change in this review. The proof-local rubric's diagnostics, tactic, axiom, and elaboration sections are therefore not applicable. The library-scale rubric yields no source/API refactor finding beyond preserving the explicit inventory-normalization boundary stated above.

## Report digest convention

The report digest is the ordinary lowercase hexadecimal SHA-256 of the complete final file bytes exactly as stored at the report path. It is reported externally after the file is finalized and is deliberately not embedded in this file, avoiding a self-referential digest.
