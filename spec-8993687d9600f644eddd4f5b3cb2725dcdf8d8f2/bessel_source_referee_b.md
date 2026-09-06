# Independent source-fidelity review: Olver Bessel baseline transcriptions

## Verdict

**CHANGES REQUESTED for commit `8993687d9600f644eddd4f5b3cb2725dcdf8d8f2`.**

The two new transcription artifacts pass the mathematical source-fidelity audit: I found no sign, scale, branch, contour-orientation, Wronskian, phase, asymptotic-domain, exercise-status, or scope-boundary defect in either file. The commit as a repository state does not pass, because its normative Bessel status document still says that only contents-level evidence exists and that no locked 1997 Bessel body material has been transcribed. That is directly contradicted by the two files added in this commit.

Acceptance is therefore blocked only on the status-truth repair described in finding F-01. This verdict does **not** require promoting either draft into the normalized inventory, a theorem card, a manifest, source coverage, reconciliation, or Lean authorization.

## Exact review binding

- Candidate commit: `8993687d9600f644eddd4f5b3cb2725dcdf8d8f2`
- Candidate tree: `466c193436a23e4b1619209e86f6555c16e1e0e4`
- Parent used only for the bounded diff: `128cd804b676074b2958157864e2e4357d4bc121`
- Commit subject: `docs: transcribe Olver Bessel baselines`
- Deterministic `git archive --format=tar` SHA-256: `01daa595206445736979133b76b59d5401cdffacd083a783768e661ce9a41ded`
- Diff boundary: exactly two added files, 1,063 lines total; `git diff --check` passed.
- Review workspace: a fresh archive extracted under `/tmp`; the live worktree and all other reviewer outputs were not inspected.
- Reviewer model: OpenAI Codex, GPT-5 family (the runtime did not expose a more specific backend model identifier).
- Review date: 2026-09-06 UTC.

### Bound artifacts

| Artifact | Bytes | SHA-256 |
| --- | ---: | --- |
| `blueprint/source_transcriptions/OLV97-C02-BESSEL-JI.md` | 18,091 | `9b440a62eac5781a9b879ae9cce4fe7863bcf23746e241b10adae8f49a92744c` |
| `blueprint/source_transcriptions/OLV97-C12-BESSEL-REAL-AUX.md` | 16,994 | `bcd704d6f0931e1ba3ce0cb0e52d9c415fb3d81b81b28c094b5982010e31d6fc` |
| Private 585-page Olver PDF | 63,288,492 | `08e1844d29a5ad21f89b9b600249ce18ac1665a5845be2d4e4219a3ededdc909` |
| Full 1,753-line user brief | — | `6787cdb628a66783d81190939e9593525ebb2640a8c870d685d95ce26ba0cce3` |
| PDF skill instructions | — | `b09cb414c60234a15599c04a502ce36fe6e9aa178aabe007e43a3346b5aab607` |

The recomputed PDF digest exactly matches the snapshot digest printed in both transcriptions and the `SRC-OLV-1997-USER-PDF-20260905` row.

## Method and evidence inspected

I read the complete user brief and complete PDF skill, then the exact archived candidate artifacts and the relevant source-governance/status material: root `README.md`, `blueprint/README.md`, `blueprint/source_manifest.md`, `blueprint/qualitative/source_recovery.md`, `blueprint/families/bessel_cylinder.md`, `blueprint/inventory/source_snapshots.csv`, and `blueprint/inventory/page_audits.csv`. I also checked the existing archived Chapter 11 Airy transcription only to resolve the exact meaning of the cross-referenced constant `c` in Chapter 12 Exercise 1.1.

The private PDF was independently rendered with Python 3.11.2 and PyMuPDF 1.28.2 at a 2.5 scale (1265 by 1947 pixels per page, approximately 180 dpi). I visually inspected all seven PDF pages 68–74 (printed pp. 55–61) and all four PDF pages 448–451 (printed pp. 435–438), including the edges where the stated scope begins and ends. Text extraction was used only as a secondary locator; the formula comparison was against the rendered page images.

The initially preferred bundled Poppler binary was unusable because it requires GLIBC 2.38, unavailable in this container. That tooling issue did not limit the visual audit because PyMuPDF rendered all requested pages successfully.

## Findings

### F-01 — Blocking repository-status contradiction

`blueprint/families/bessel_cylinder.md:4` says the current source evidence consists of “contents-only leads,” its discovery summary at lines 11–16 repeats that premise, and line 222 says: “No locked 1997 Bessel-family body occurrence has been registered, transcribed, or reconciled.” Commit `8993687...` itself adds two hash-bound, locked-1997 mathematical-body transcriptions. Both new files explicitly identify themselves as `planning-only first collation; transcribed-unreconciled` at line 3 and bind exact body pages at lines 10–12. Thus “not registered” and “not reconciled” remain true, but “not transcribed” and “contents-only” do not.

The same new planning state is omitted from the current-truth summaries in root `README.md:18–20` and `blueprint/README.md:31`; `blueprint/source_manifest.md:218–222` likewise lists the existing parallel transcriptions without acknowledging the new unregistered Bessel drafts. Those omissions matter because these files present themselves as current status authorities and the governance policy treats planning, transcription, inventory registration, reconciliation, coverage, and authorization as separate axes.

**Required repair:** update the current-status prose, especially `blueprint/families/bessel_cylinder.md`, to acknowledge these two locked-body first collations while retaining their exact `transcribed_unreconciled`, unregistered, unmanifested, uncarded, and unauthorized status. Do not claim confirmed entities, reconciliation, or source coverage. Whether to add normalized occurrence/page-audit rows is a later integration choice and is not required to resolve this finding.

## Source-fidelity acceptance record

### Chapter 2, printed pp. 55–61

**Accepted.** The PDF-to-printed-page map 68–74 ↔ 55–61 is exact. The transcription begins at §9.1 after the preceding Airy material on p. 55 and stops before the substantive §11 Zeta material on p. 61.

Adversarial checks passed:

- Integer `J_n`: Bessel integral, exponential integral, positive unit-circle orientation, Laurent kernel `exp{z(h-h⁻¹)/2}/h^(n+1)`, Maclaurin coefficient powers of two and alternating signs, `J_{-n}=(-1)^n J_n`, and the generating function all match.
- General-order `J_ν`: `(z/2)^ν`, `(-1)^s(z²/4)^s`, reciprocal-Gamma index `ν+s+1`, negative-integral initial-term cancellation, the principal-power rule, and continuation `J_ν(ze^{mπi})=e^{mνπi}J_ν(z)` match. The text correctly warns that this is branch continuation, not independent principal-value evaluation.
- Schlaefli formulas: the Hankel loop from `-∞` around `(0+)`, continuous power convention, exponent `t-z²/(4t)`, denominator `t^(ν+1)`, substitutions `t=zh/2`, `h=e^τ`, oriented contour from `∞-πi` to `∞+πi`, exponent `z sinh τ-ντ`, and `|ph z|<π/2` domain all match. The figure is expressly omitted.
- `J` recurrences: sums, differences, derivative signs, factors `2ν/z` and `2`, and the `J'_0=-J_1` specialization match.
- Modified `I_ν`: the nonalternating series, modified equation sign, principal-value convention, rotation factor `e^{-νπi/2}`, warning about unequal principal cuts, and all recurrence signs match.
- Principal-branch Exercise 10.2 ranges and second rotation factor `e^{3νπi/2}` match exactly.
- Airy Exercise 10.4: `ξ=(2/3)z^(3/2)`, `W=z^(-1/2)w`, transformed order `1/3`, every factor `1/3`, and all four `I/J` sum/difference signs for `Ai(±z)` and `Ai'(±z)` match.
- Exercises 9.1–9.8 and 10.1–10.6 are consistently labeled as targets rather than exposition assertions; the Kelvin names are not promoted beyond their exercise occurrence.

### Chapter 12, printed pp. 435–438

**Accepted.** The PDF-to-printed-page map 448–451 ↔ 435–438 is exact. The transcription includes §§1.1–1.3 and Exercise 1.1, omits the numerical table, and stops before §2.1 formulas.

Adversarial checks passed:

- The inherited baseline domain `ν≥0`, `x>0`, fixed-`ν` small-`x` readings, bounded-`ν` large-`x` uniformity, and fixed-`ν`, large-`s` zero asymptotics are all preserved.
- `W{K_ν,I_ν}=1/x` has the correct ordered-basis sign for `W{f,g}=fg'-f'g`. The compact recurrence member is correctly `L_ν=e^{νπi}K_ν`, not bare `K_ν`; all four recurrence signs follow from that scaling.
- `I_{-ν}=I_ν+(2/π)sin(νπ)K_ν` and `K_{-ν}=K_ν` match, including the positive-integral exception when the small-`x` `I` formula is transported by `ν↦-ν`.
- `W{J_ν,Y_ν}=2/(πx)` matches the ordered form `J_{ν+1}Y_ν-J_νY_{ν+1}`. All four `J/Y` recurrence signs and both negative-order rotation formulas match, with the corresponding positive-integral exception retained.
- The `J/Y` endpoint forms, phases `x-νπ/2-π/4`, positive-zero interlacing, and zero asymptotics match with their stated parameter regimes.
- `X_ν` is the smallest positive root of `J_ν+Y_ν=0` and satisfies `0<X_ν<y_{ν,1}`. `E_ν` uses the positive square root of `-Y_ν/J_ν` through `X_ν` and equals `1` thereafter. The derivative of `E_ν²` has the required negative sign.
- `J_ν=E_ν^{-1}M_ν cos θ_ν` and `Y_ν=E_νM_ν sin θ_ν` match. Before the switch, `M_ν={2|Y_ν|J_ν}^{1/2}` and `θ_ν=-π/4`; after it, `M_ν=(J_ν²+Y_ν²)^{1/2}` with a continuously unwrapped inverse-tangent branch. The phase derivative is `+2/(πxM_ν²)`.
- Zero phases `(s-1)π` and `(s-1/2)π`, all small- and large-`x` `E/M/θ` forms, and the additive phase constant are correct. At `ν=1/2`, `X_{1/2}=π/4` and `θ_{1/2}=x-π/2`, forcing the large-`x` integer phase offset to zero.
- Exercise 1.1 remains an exercise target. Its factor `(ν/2)^(1/3)`, error `O(ν^(-1/3))`, and cross-reference `c=-0.36605…` are correct; the file also correctly treats the exact least-absolute-value negative root of `Ai=Bi`, not the decimal, as the definition of `c`.

## Acceptance criteria for a revised candidate

1. Preserve the two transcription files mathematically unchanged unless another independently evidenced source correction appears.
2. Repair F-01 so every current-status authority distinguishes “two locked-body first transcriptions now exist” from “no normalized inventory registration, independent reconciliation, entity confirmation, theorem card, manifest membership, source coverage, or implementation authorization.”
3. Keep exercises visibly separate from exposition assertions and retain the exact page/scope boundaries.
4. Rebind any amended candidate by a new exact commit/tree and new SHA-256 digests before re-review.

## Final integrity note

The SHA-256 of this review file is intentionally reported out of band after the final bytes are written; embedding its own final digest would change those bytes and invalidate the digest.
