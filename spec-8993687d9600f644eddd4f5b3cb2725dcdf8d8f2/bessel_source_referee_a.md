# Independent Bessel source-referee report A

## Verdict

**REQUEST_CHANGES**

The two transcriptions are unusually careful and I found no swapped sign,
missing numerical prefactor, wrong Wronskian orientation, incorrect zero
ordering, or main-exposition/exercise misclassification in the formulas they
actually display. The exact page maps also check. Approval is nevertheless
withheld because branch/path semantics for several Chapter 2 exercise targets
remain under-specified, the Chapter 12 phase/source boundary is not fully
preserved, and both proposed inventory records conflict with the repository's
atomic-occurrence policy.

## Review identity and exact inputs

- Referee: `bessel_source_referee_a`
- Reviewed Git commit: `8993687d9600f644eddd4f5b3cb2725dcdf8d8f2`
- Review mode: read-only disposable `git archive` of that commit; the live
  worktree and all other reviewer reports were not inspected.
- Complete governing brief:
  `/home/codex/.codex/attachments/6740fc8c-818a-4ce2-95bb-67293a5ba2bf/pasted-text.txt`
  (all 1,753 lines read).
- Repository policies read from the archive: `blueprint/source_manifest.md`,
  `blueprint/function_inventory.md`, and `review/rubrics/source_fidelity.md`.
- PDF-review procedure read in full:
  `/home/codex/.codex/plugins/cache/openai-primary-runtime/pdf/26.630.12135/skills/pdf/SKILL.md`.

Exact SHA-256 bindings:

| Input | SHA-256 |
| --- | --- |
| Private Olver PDF `/tmp/codex-web-uploads-5qVFkz/ccbc2d4c-f600-4d0a-90ec-eeeb25e7cdce` | `08e1844d29a5ad21f89b9b600249ce18ac1665a5845be2d4e4219a3ededdc909` |
| `blueprint/source_transcriptions/OLV97-C02-BESSEL-JI.md` | `9b440a62eac5781a9b879ae9cce4fe7863bcf23746e241b10adae8f49a92744c` |
| `blueprint/source_transcriptions/OLV97-C12-BESSEL-REAL-AUX.md` | `bcd704d6f0931e1ba3ce0cb0e52d9c415fb3d81b81b28c094b5982010e31d6fc` |

The transcriptions' embedded snapshot digest matches the independently
computed PDF digest.

## Page convention and visual method

The PDF has 585 pages and a sequential embedded page-label array `1` through
`585`; there is no offsetting custom label scheme. I therefore interpreted
"PDF page N" as the one-based page number and rendered zero-based index
`N - 1`. This gives the claimed maps:

- PDF 68-74 -> printed 55-61;
- PDF 448-451 -> printed 435-438.

Every one of those eleven PDF pages was rendered independently with PyMuPDF
1.28.2 at 2.5x (1265 by 1947 RGB PNG) and visually inspected at original
render resolution. Text extraction was used only to navigate and confirm the
page-count/label convention, never as a substitute for the page images. The
rendered pages show the 1997 A K Peters pagination and the cited section and
equation labels.

## Findings

### F1 - Chapter 2 exercise branch and path semantics are not audit-closed

Artifact evidence: `OLV97-C02-BESSEL-JI.md`, especially lines 243-279 and
299-314, presents the half-order formulas, powers `z^(+/-nu)`, Poisson's
integral, and `integral_0^z J_nu(t) dt` as formulas without attaching a branch
or path convention. Lines 470-511 discuss several branch hazards but do not
close this one.

Source evidence: printed p. 57 / PDF p. 70 makes general-order `J_nu(z)`
multivalued in `z`, selects a principal branch, and gives continuation between
branches. Printed pp. 59-60 / PDF pp. 72-73 then pose Exercises 9.3-9.7 using
square/fractional powers and, in 9.7, an integral ending at a complex `z`,
without restating a path in the exercise itself. The source's brevity is a
convention hazard to record, not permission for a future formal statement to
be global or path-free.

Why material: the project brief requires branch, domain, and integral semantics
to be visible, and the inventory policy requires notation rows to capture
branch and exception policy. In particular, `integral_0^z` cannot silently
become an unrestricted real interval integral or a globally path-independent
complex integral across a branch cut.

Acceptance condition: for Exercises 9.3-9.7, state exactly which principal or
continued branch is inherited from section 9.3, and specify or explicitly mark
unresolved the meaning/path and admissible domain of Exercise 9.7's integral.
If the inspected pages do not settle that semantic point, retain it as an open
source question rather than supplying a global identity. Apply the same rule to
the square/fractional powers in Exercises 9.3-9.5.

### F2 - The Chapter 12 phase-normalization chain is compressed past a material convention

Artifact evidence: `OLV97-C12-BESSEL-REAL-AUX.md` lines 339-356 says only that
an additive multiple of `2*pi` is fixed by continuity in `nu` and the half-order
case. It omits the intermediate displayed phase with an integer `m` and does
not state the source's conclusion that this integer is independent of `nu`.

Source evidence: printed p. 438 / PDF p. 451 first writes the large-`x` phase
with `+ 2*m*pi`, declares `m` integral, uses continuity of `theta_nu` in `nu`
to make `m` independent of `nu`, and only then sets `nu = 1/2` to obtain
`m = 0`.

Why material: this is the exact branch-unwrapping argument behind (1.24), not
merely expository detail. Omitting the integer and its parameter independence
weakens the promised phase-convention audit.

Acceptance condition: record the intermediate `+ 2*m*pi + O(x^-1)` relation,
`m in Z`, the independence of `m` from `nu`, and the half-order specialization
that forces `m = 0`. It is fine to do so in fresh prose plus the minimal
mathematical display.

### F3 - The Chapter 12 boundary imports an unverified identity for `c` and omits an in-scope qualitative source note

Artifact evidence: `OLV97-C12-BESSEL-REAL-AUX.md` lines 369-371 calls `c` the
"exact Airy root selected" in Chapter 11, and lines 414-416 strengthens this to
an "exact Chapter 11 Airy switch-root entity". The scoped source location is
only Chapter 12, printed pp. 435-438. Separately, lines 356-358 and 420-425 omit
the numerical table (correctly) but do not preserve its mathematically
substantive footnote.

Source evidence: printed p. 438 / PDF p. 451 says only on the inspected page
that `c = -0.36605...` is defined in Chapter 11, section 2.2. The page's table
footnote also reports that `X_nu` is increasing in `nu` and points to a theorem
of Watson containing that result. The exact nature of `c` cannot be certified
from the allowed four-page source window alone.

Why material: a cross-reference is valid provenance, but turning it into an
exact root identity without binding and reviewing the referenced source page is
an out-of-scope semantic promotion. Conversely, the omitted monotonicity note
is directly on an inspected page and concerns the very auxiliary object being
inventoried. The copyright policy permits a short independent paraphrase and
forbids reproducing the table, so these two concerns can be resolved together.

Acceptance condition: either (a) neutralize the `c` description to "the
constant defined at Chapter 11 section 2.2" and mark its exact identity for
separate collation, or (b) bind and independently review the Chapter 11 source
occurrence before asserting the root identity. Add a short paraphrase of the
printed-p. 438 monotonicity/cross-reference footnote, without reproducing the
numerical table; classify it as a source report/cross-reference rather than as
a theorem proved on these pages.

### F4 - Both inventory proposals collapse many required occurrences into one

Artifact evidence:

- `OLV97-C02-BESSEL-JI.md` lines 526-542 proposes one occurrence spanning two
  definitions, numbered formulas (9.01)-(9.16) and (10.01)-(10.05), and fourteen
  separate exercises.
- `OLV97-C12-BESSEL-REAL-AUX.md` lines 432-450 proposes one occurrence spanning
  a property collection, twenty-four numbered formulas, a numerical table, a
  substantive footnote/cross-reference, and Exercise 1.1. Its scalar proposed
  `target class` and `evidence` fields are also expressed as mixtures.

Policy evidence: `blueprint/function_inventory.md` defines occurrences as
separate printed definitions, theorems, formulas, exercises, tables,
normalization checks, and cross-references, explicitly says repeated
definitions/uses/exercises remain separate occurrences, and in audit-workflow
step 4 requires a separate occurrence for each such item in manifest scope.
`blueprint/source_manifest.md` likewise makes repeated appearances separate
occurrences.

Why material: the one-row proposal loses per-item kind, exercise/assertion
status, notation, entity links, and reconciliation. It cannot later support the
repository's coverage denominator or reverse audit without being redesigned.
Calling the table "planning metadata only" correctly prevents premature CSV
state changes but does not make the proposed row shape conformant.

Acceptance condition: remove the singular occurrence proposals or replace them
with an atomic occurrence plan. At minimum definitions, distinct exercises,
the omitted table, substantive footnotes/cross-references, and other selected
formula/property occurrences must have separate IDs and scalar classifications.
A block-level transcription file may remain as a shared artifact, but it must
not be presented as one canonical occurrence.

## Checks that passed

- Edition, ISBN, snapshot identifier, source digest, printed/PDF page maps,
  section labels, and numbered equation ranges are reproducible.
- Chapter 2 signs and factors in (9.01)-(9.16), (10.01)-(10.05), and all
  transcribed exercise formulas match the rendered pages.
- The locally uniform normalized-series statement, the `z != 0`/multivalued
  split, principal-power convention, continuation formula (9.10), Schlaefli
  loop power and orientation description, and the `|ph z| < pi/2` condition on
  (9.13) are preserved.
- Exercise 10.2's two half-plane phase ranges and exponential factors are
  exact; Exercise 10.4's Airy factors/signs and Exercise 10.6's Kelvin rotations
  are exact.
- Chapter 12 real baseline domain `nu >= 0`, `x > 0`; all small- and large-`x`
  factors; bounded-`nu` uniformity statements; negative-order exceptions;
  recurrence signs; and positive-square-root conventions match.
- Wronskian orientation is correct: `W{K,I}=1/x` and
  `W{J,Y}=2/(pi*x)` use `W{f,g}=f*g' - f'*g`. No basis swap occurred.
- Positive zeros are ordered correctly as `y_(nu,1) < j_(nu,1) < ...`; the
  asymptotic indices, `0 < X_nu < y_(nu,1)`, phase values at both zero families,
  and the half-order normalization are correct.
- Main exposition and exercises are explicitly separated. The Chapter 2 Airy
  material above section 9, Chapter 2 zeta material beginning at section 11,
  and Chapter 12 section 2 formulas are correctly excluded. No copied scan,
  OCR block, figure, or numerical table appears in the artifacts; the prose is
  independently phrased.

## Final disposition

After F1-F4 are satisfied, re-hash both revised artifacts and repeat independent
visual collation on the same exact PDF bytes. No formula correction is presently
required; the acceptance work concerns source semantics, scope, and normalized
inventory structure.

The exact SHA-256 of this final report file is supplied as a detached digest to
the commissioning agent. Embedding a file's own ordinary SHA-256 in its hashed
bytes would be self-referential and would not be an exact file digest.
