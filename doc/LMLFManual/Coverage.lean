import VersoManual
import LMLFManual.Components

open Verso.Genre Manual
open LMLFManual

#doc (Manual) "Coverage" =>
%%%
tag := "coverage"
number := false
%%%

*Numbered formulas.*

The formula ledger has one machine-readable record for every numbered formula in DLMF Chapters
4–10. Statement coverage and proof coverage are separate: a declaration implemented with `by sorry`
counts as a Lean statement, but not as a proof.

:::coverageSummary
:::

[Download the complete JSON ledger](https://jaume.dedios.cat/LMLF/coverage/dlmf-4-10.json).

Each record contains the DLMF identifier and permalink, whether an LMLF statement exists, whether it
is proved, and whether a distinct quantitative analogue has been stated or proved.

*Structural source inventory.*

Not every mathematical statement in the DLMF is a numbered formula. The schema-v2 inventory gives a
stable identifier and content hash to every machine-detectable source candidate, without copying the
DLMF body. Formula constraints are retained as components of their formula rather than counted again.

:::sourceInventorySummary
:::

[Download the structural inventory](https://jaume.dedios.cat/LMLF/coverage/dlmf-4-10-source-inventory.json)
or its [JSON Schema](https://jaume.dedios.cat/LMLF/coverage/dlmf-source-inventory.schema.json).

All 4,792 structural candidates begin as `unreviewed`. A later editorial pass must decide whether
each block contains no mathematical claim or one or more claims, write the natural-language
statements, and attach Lean declarations. Until then, `unknown` means *not reviewed*; it never means
that no Lean result exists.
