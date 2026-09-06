# Same-author addendum 01 — inventory-context correction

## Exact binding

- Original report: `e0-contract-referee-c.md`, SHA-256
  `f7c53e5c055f5d6245bf0c0cf917f4a148468540f01eafe40ed1bb8b6920eb83`.
- Reviewed candidate: `stage1-companion-schema-design-draft-03.md`, SHA-256
  `0ca695804d589d2fec652f265a87d2f9c95a6d0e0095056dae1d39719896bb6f`.
- Same reviewer identity: `/root/e0_contract_referee_c`.
- Addendum disposition: correct one contextual inventory attribution; preserve the original
  `approve` verdict and every substantive finding.

This addendum is append-only. The original report and candidate bytes remain unchanged.

## Correction

The original report's final inventory bullet says that the deterministic library inventory found
7 Lean files, 210 lines, 3 definitions, and 18 theorems and labels this as repository context. Those
figures came from the command I actually ran against
`/tmp/lmlf-stage1-scope.DbhM9YHt`, the accepted R7 scope checkout at commit
`aebe7968bd6d5dcd23ac949d5d5e0d8854334ca1`. They describe that older scope checkout, not the
reviewed main repository baseline. I misattributed the context statistic in the report.

I reran the exact skill command against the correct main repository root:

```text
/home/codex/.codex/skills/referee-lean-library/scripts/library_inventory.sh /workspace/Documents/Codex/2026-09-05/yo
```

At clean `main` commit `b8d2f731fcfd5cd0889d0732f13699eb94681c86`, equal to `origin/main` at
the rerun, the correct summary is:

```text
Lean files: 16
Lean lines: 4623
definitions: 29
lemmas: 57
theorems: 128
trust/resource markers: none reported
```

These counts are inventory leads only. Neither the original count nor this correction is Lean build,
proof, axiom, import-safety, or implementation evidence.

## Binding and verdict effect

The corrected inventory context does not change the contract review. Draft 03 proposes no Lean
declaration or proof, and the approval rests on its finite schema/validator contract, ownership and
closure rules, classification/role separation, external digest ordering, synthetic-only authority
boundary, and realizable local tests—not on the number of Lean files or declarations.

The following exact main-repository bindings were reverified and are unchanged:

- `review/PROTOCOL.md`:
  `7453bc0ca6985d7ca2e8c525d9655a94e412c48e3850b92d9367a9f643d3177d`;
- `review/classifications-v3.json`:
  `975e08b89d609cbdd15ff3f8d24f40a42bb17ea0f4c37bb26d9cf53fb8dc4b5e`;
- `scripts/validate_inventory.py`:
  `c954ce39762b160e7328846dc3740df242deb381b4d5da7995df70cd74b90a75`; and
- all fourteen `blueprint/inventory/*.csv` digests still equal candidate Appendix A, so all fifteen
  protected legacy input bindings remain exact.

I also reran the current main validator after the correction check:

- `python3 scripts/validate_inventory.py`: exit 0 with the same reported legacy totals;
- `python3 scripts/validate_inventory.py --negative-tests`: exit 0 with all 25 existing copied
  negative fixtures rejected.

No validator, protocol, classification, legacy input, candidate, original report, schema, fixture,
or Lean file was edited. No Lean build was run or claimed.

**Effective verdict for the exact draft-03 digest remains:** `approve`.

This limited correction does not approve a changed draft-03 successor and does not extend approval
to any future schema, classification successor, fixture, validator implementation, production data,
card, signature, proof, Lean code, integration head, or authority record. Each still requires its own
exact review and selection.

