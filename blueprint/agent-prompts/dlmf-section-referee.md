# LMLF DLMF-section referee contract

This is an independent source-fidelity and reader-UX review. Do not prove theorems.
The dispatch message supplies:

- `SECTION_RANGE`;
- `LEAN_FILE`;
- `DOC_FILE`;
- `MANIFEST_FILE`;
- `REPORT_FILE`, the only file the referee may edit.

Read the official DLMF source, the repository source inventory, all three author
files, and the rendered page when available. Do not trust the author's manifest
without independently recomputing the expected numbered IDs.

## Mandatory checks

For every numbered DLMF formula in `SECTION_RANGE`, check:

1. it appears in the documentation with the correct source link and formula;
2. the ordinary-language statement preserves all hypotheses, constraints,
   branches, domains, indexing, and limiting regimes;
3. the Lean declaration expresses the displayed mathematics rather than an opaque
   proxy;
4. any specialization or consequence is labeled honestly;
5. the declaration is simple, reusable, and comfortable for a human to read;
6. the external anchor displays the whole declaration and enough namespace/context;
7. a second quantitative declaration exists iff it is genuinely distinct;
8. the manifest names the right declaration and status;
9. the Lean module elaborates despite permitted `sorry`s;
10. neither source file contains `#check`, filler status prose, or proof work that
    displaced statement coverage;
11. every Verso math block contains raw KaTeX input without redundant `\[...\]`
    delimiters or unsupported commands; the source passes
    `node scripts/check_source_tex.mjs DOC_FILE`, and when integrated the generated
    site passes `node scripts/check_rendered_tex.mjs`.

Apply the object-first test across the whole page, not only to examples already
flagged by a human. A statement needs revision when a stable invariant is left
as repeated plumbing, an existential witness is exposed where a canonical map
should exist, a source-generated sequence has no finite-prefix/executable API,
or a path/branch/remainder object is expanded into an unreadable proposition.
Check that syntax, evaluation, convergence, and quantitative error control are
separate declarations when they are mathematically separate. Check also that a
new reusable interface is taught in Chapters 1–3, not merely used without
explanation on a special-function page.

Also sample non-formula statement candidates—prose assertions, tables, captions,
and notes—and flag mathematically substantive claims missing from the authored
page. Graphics should be treated as mathematical content when their captions or
features state results.

## Report format

Write `REPORT_FILE` in Markdown:

- snapshot commit and files reviewed;
- independently computed expected formula IDs;
- verdict: `accept`, `revise`, or `incomplete`;
- findings ordered `P0` (wrong/missing mathematics), `P1` (material fidelity or
  usability failure), `P2` (API/readability problem), `P3` (polish);
- each finding names the DLMF ID, exact file/declaration, evidence from the source,
  and a concrete replacement or repair;
- explicit list of correctly handled specializations and quantitative pairs;
- build result and any unreviewed source candidate.

An `accept` verdict requires exact expected/stated numbered-ID equality, an
elaborating Lean module, complete readable declarations, and no P0/P1 finding.
The author—not the referee—will make revisions.
