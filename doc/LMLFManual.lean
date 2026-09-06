import VersoManual
import LMLFManual.Components
import LMLFManual.Coverage
import LMLFManual.Chapter1
import LMLFManual.Chapter2
import LMLFManual.Chapter3
import LMLFManual.Chapter4
import LMLFManual.Chapter5
import LMLFManual.Chapter6
import LMLFManual.Chapter7
import LMLFManual.Chapter8
import LMLFManual.Chapter9
import LMLFManual.Chapter10

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open LMLFManual

set_option pp.rawOnError true

#doc (Manual) "LMLF · DLMF with Lean" =>
%%%
authors := ["The LMLF contributors"]
shortTitle := "LMLF"
%%%

The NIST Digital Library of Mathematical Functions remains the source document. LMLF follows its
chapter and equation numbering and adds an expandable Lean counterpart wherever one has been
written. Any specialization or consequence is stated in the surrounding prose. A second Lean panel
appears only for a genuinely distinct finite estimate.

Chapters 1–3 contain only LMLF's additional interfaces for approximants, finite error bounds, series,
and improper integrals. Chapters 4–10 link every section back to the current DLMF source.

{include 0 LMLFManual.Coverage}

{include 1 LMLFManual.Chapter1}

{include 1 LMLFManual.Chapter2}

{include 1 LMLFManual.Chapter3}

{include 1 LMLFManual.Chapter4}

{include 1 LMLFManual.Chapter5}

{include 1 LMLFManual.Chapter6}

{include 1 LMLFManual.Chapter7}

{include 1 LMLFManual.Chapter8}

{include 1 LMLFManual.Chapter9}

{include 1 LMLFManual.Chapter10}
