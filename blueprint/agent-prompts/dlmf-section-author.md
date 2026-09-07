# LMLF DLMF-section author contract

This contract is for the statement-coverage phase. Proofs are deliberately out of
scope: use `by sorry` for every result not already available under a clear Mathlib
name. Do not spend time proving, golfing, or automating proofs.

The dispatch message supplies exactly four variables:

- `SECTION_RANGE`: the assigned DLMF sections;
- `LEAN_FILE`: the only Lean source file owned by this task;
- `DOC_FILE`: the only Verso source file owned by this task;
- `MANIFEST_FILE`: the only coverage manifest owned by this task.

Do not edit aggregators, shared foundations, generated HTML, global coverage JSON,
or another task's files. If shared vocabulary is missing, define a minimally
scoped readable version in `LEAN_FILE` and record the desired consolidation in the
manifest. This prevents concurrent authors from colliding.

## Source of truth

Use the official DLMF pages for `SECTION_RANGE`, including their subsections,
numbered equations, equation constraints, surrounding prose, symbols, notes,
tables, and graphics captions. Follow links to the `.tex` encodings when useful.
Do not infer a formula from memory.

The repository's `coverage/dlmf-4-10-source-inventory.json` is the enumeration
checklist. It is not a substitute for reading DLMF. At minimum, account for every
`numbered_formula` whose `location.section` is in `SECTION_RANGE`.

## Required page experience

The page should feel like DLMF written in an era where Lean is commonplace.
For every mathematical result, present this sequence:

1. the DLMF subsection heading and stable source link;
2. the source formula or mathematical display;
3. polished ordinary mathematical prose explaining exactly what it says,
   including hypotheses, conventions, and specialization choices;
4. an open Lean disclosure containing the complete declaration copied through a
   Verso external-source anchor.

In Verso display math, write raw TeX inside `$$\`...\``. Do not add `\[` and
`\]`: Verso already selects display mode, and those redundant delimiters are
invalid input to the site's KaTeX renderer. Use only KaTeX-supported commands.

Do not write status prose such as “qualitative view”, “Lean analogue”, “proof
pending”, “this theorem says”, or “there is no error majorant”. Do not use
`#check`. Do not replace a declaration by its name. Do not expose opaque wrapper
predicates merely to avoid writing the mathematical proposition.

If the most readable formal statement is a real-positive, real-variable, or other
honest specialization of the complex DLMF result, state that plainly in the prose
and manifest. Never label a consequence or specialization as an exact match.

## Lean statement standard

- Prefer the canonical Mathlib object and notation after searching the pinned
  environment.
- Optimize declaration names, binder order, hypotheses, and line breaks for a
  mathematically literate human reader.
- State domains explicitly and naturally. Avoid unnecessary typeclass machinery.
- Introduce small reusable definitions for genuinely recurring expressions,
  approximants, coefficients, remainders, partial sums, or partial products.
- Every public definition and theorem must have a doc comment naming its DLMF ID.
- Wrap every displayed declaration in a unique external-source anchor. The anchor
  must stop before the proof body so the site displays the statement, not `sorry`.
- Declarations must elaborate. Proofs may be `by sorry`.
- Use Chapter 1–3 infrastructure for errors, filters, series, asymptotic scales,
  and Poincaré expansions where it makes the result more natural.

## Qualitative and quantitative results

A second quantitative declaration appears only when it is mathematically distinct
from the qualitative/asymptotic declaration. Examples include an explicit finite
remainder bound, a truncation error, a computable enclosure, or a uniform estimate.
An exact identity or an inequality is not duplicated under two labels. Preserve
both declarations when DLMF genuinely supplies both.

## Coverage manifest

Write `MANIFEST_FILE` as JSON with this shape:

```json
{
  "section_range": ["5.x", "5.y"],
  "numbered_formula_ids_expected": ["5.x.E1"],
  "numbered_formula_ids_stated": ["5.x.E1"],
  "numbered_formula_ids_omitted": [],
  "extra_statement_ids": [],
  "declarations": [
    {
      "source_id": "5.x.E1",
      "names": ["LMLF.Blueprint.Gamma.example"],
      "relation": "exact",
      "proof_status": "missing",
      "quantitative_analogue": "not_applicable",
      "notes": ""
    }
  ],
  "shared_vocabulary_requests": [],
  "known_gaps": []
}
```

Allowed `relation` values are `exact`, `specialization`, `consequence`, and
`related`. An omission must include a concrete reason in `known_gaps`; silence is
not acceptable.

## Verification and handoff

Before finishing:

1. compare expected IDs from the inventory with the manifest;
2. build `LEAN_FILE` with the pinned project;
3. build `DOC_FILE` if its standalone shape permits it;
4. search both files for `#check` and reject any hit;
5. when the page is integrated, run `node scripts/check_rendered_tex.mjs` and
   reject any KaTeX parse failure;
6. report counts, build results, specialization decisions, vocabulary requests,
   and every remaining gap.

Do not claim the section is complete unless expected and stated ID sets are equal
and the Lean module elaborates.
