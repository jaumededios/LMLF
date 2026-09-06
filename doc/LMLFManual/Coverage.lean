import VersoManual
import LMLFManual.Components

open Verso.Genre Manual
open LMLFManual

#doc (Manual) "Coverage" =>
%%%
tag := "coverage"
number := false
%%%

The coverage ledger currently has one machine-readable record for every numbered formula in DLMF
Chapters 4–10. Statement coverage and proof coverage are separate: a declaration implemented with an
axiom or `by sorry` still counts as a Lean statement, but not as a proof.

:::coverageSummary
:::

[Download the complete JSON ledger](https://jaume.dedios.cat/LMLF/coverage/dlmf-4-10.json).

Each record contains the DLMF identifier and permalink, whether an LMLF statement exists, whether it
is proved, and whether a distinct quantitative analogue has been stated or proved. The next schema
revision will add independently indexed prose assertions and unnumbered formulas; they are not folded
into the numbered-formula denominator above.
