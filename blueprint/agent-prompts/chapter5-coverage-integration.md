# Chapter 5 coverage-integration contract

The section manifests in `coverage/sections/chapter5-*.json` are the reviewed
statement mappings. This task owns only:

- a new reusable synchronization script under `scripts/`;
- `coverage/overrides.json`;
- regenerated `coverage/dlmf-4-10.json`;
- regenerated `coverage/dlmf-4-10-source-inventory.json`;
- the hard-coded formula summary rows in `doc/LMLFManual/Components.lean`;
- `coverage/README.md` if the synchronization workflow needs documentation.

Do not edit section Lean/docs/manifests, referee reports, navigation, or generated
HTML.

Requirements:

1. Accept both manifest shapes currently present: the author-contract shape with
   `numbered_formula_ids_*`/`declarations`, and the earlier page shape with
   `included_ids`/`entries`.
2. Normalize display IDs such as `5.7.3` to canonical ledger IDs `5.7.E3`.
3. Independently compute expected formula IDs for sections 5.1–5.18 from the
   schema-v2 source inventory and require exact equality with manifest coverage.
   The expected total is 160 numbered formulas. Abort on an omission, duplicate,
   unknown ID, malformed relation, or missing declaration name.
4. Convert every reviewed formula to an override with truthful `match`, Lean
   statement/proof booleans, declaration names, quantitative analogue/statement/
   proof booleans, quantitative declaration names, and useful notes.
5. Preserve stronger existing evidence when merging, notably the proved
   `LMLF.Definitions.gamma_eq_eulerIntegral` mapping for `5.2.E1`.
6. Replace stale Chapter 5 overrides for sections 5.1–5.18, while preserving any
   overrides outside that range.
7. Regenerate both ledgers using the existing generators and the pinned DLMF
   release. The structural inventory must reflect all 160 checked statements.
8. Update the rendered summary table from the regenerated formula-ledger counts;
   do not hand-invent a total.
9. Document and test an idempotent command that can be rerun after manifest edits.

Verification:

- all JSON parses;
- exactly 160 Chapter 5 formulas in sections 5.1–5.18 have checked statements;
- proof and quantitative totals agree between overrides, both ledgers, and the
  rendered summary;
- the 2,108 formula and 4,792 structural-candidate guards remain unchanged;
- synchronization is idempotent apart from generator timestamps;
- root and documentation builds pass;
- `git diff --check` passes.
