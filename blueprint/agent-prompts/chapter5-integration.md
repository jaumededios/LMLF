# Chapter 5 integration contract

All section authors own `Section51` through `Section518`. The integration task owns
only these shared files:

- `LMLF.lean`;
- `doc/LMLFManual.lean`;
- `doc/LMLFManual/Chapter5.lean`;
- `lakefile.toml`, only if module discovery requires it.

Do not edit a section Lean file, section Verso file, manifest, referee report,
coverage aggregate, or generated HTML.

Required result:

1. Import all `LMLF.Blueprint.Gamma.Section51` through `Section518` from the root
   library so a root build elaborates every statement.
2. Import all `LMLFManual.Chapter5.Section51` through `Section518` from the manual.
3. Keep `Chapter5.lean` as a concise DLMF Chapter 5 landing/index page. Remove its
   old sample implementations of 5.2 and 5.11 so there is exactly one canonical
   page for each section.
4. Include the 18 section manuals immediately below Chapter 5, in numerical order,
   at the nesting level that produces one navigable page per DLMF section.
5. Preserve the DLMF-first UX and disable Verso numbering for source-numbered
   headings where necessary.
6. Do not add coverage/status/editorial prose to mathematical pages.

Verification:

- root `lake build` elaborates every new module;
- `cd doc && lake build` succeeds;
- generated manual metadata has one route/title for each section 5.1–5.18;
- source contains no `#check` and no duplicate 5.2/5.11 entry bodies;
- `git diff --check` passes.

Generated HTML publication and global coverage synchronization are parent-owned.
