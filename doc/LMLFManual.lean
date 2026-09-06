import VersoManual
import LMLFManual.Components
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

#doc (Manual) "LMLF · Mathematical Functions with Lean" =>
%%%
authors := ["The LMLF contributors"]
shortTitle := "LMLF"
%%%

LMLF is an exact, theorem-oriented overlay for the NIST Digital Library of Mathematical Functions.
The navigation follows DLMF, while each overlay result separates the mathematical statement from its
qualitative consequence, quantitative strengthening, provenance, and checked Lean form.

This first site slice covers DLMF Chapters 4–10. Chapters 1–3 are replaced by a compact reference to
the analytic vocabulary that is genuinely new in LMLF; ordinary background already supplied by
Mathlib is intentionally not duplicated.

The source navigation is pinned here to DLMF version 1.2.7 (released 2026-06-15). A source link or a
chapter heading is navigation, not a coverage claim. The overlay says explicitly when LMLF has no
accepted theorem yet.

:::result "Coverage at a glance" "DLMF Chapters 4–10 boundary"
*Implemented and checked.* Chapters 1–2 expose LMLF's eight-declaration finite-error vocabulary;
Chapter 5 exposes four exact Gamma identification and convention declarations.

*Blueprinted.* Chapter 3 records the finite-exceptional improper-integral packet and the
QL-001/OLV-001/SR-001 Watson route. Its closest current Olver-facing quantitative statement is printed
in full, but is not presented as checked Lean.

*Source preparation.* Chapters 9–10 have bounded Olver transcriptions, but no reconciled Airy or
Bessel theorem cards.

*Left for later.* Chapter 4, the remainder of Chapter 5, and Chapters 6–8 have navigation scaffolds but
no accepted LMLF result cards; the theorem families listed in Chapters 9–10 likewise remain later work.
:::

*Reading the result cards.*

Each theorem card has up to three views:

* *Qualitative* — the source-facing or asymptotic conclusion closest to Olver's formulation.
* *Quantitative* — a finite identity or explicit bound, when LMLF has one.
* *Lean* — a collapsed, elaborated snippet for accepted declarations. Planned statements are never
  made to look kernel-checked.

Definition-identification results do not acquire artificial “quantitative” counterparts. Conversely,
a finite bound may have no released asymptotic bridge yet. Missing halves stay visible.

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
