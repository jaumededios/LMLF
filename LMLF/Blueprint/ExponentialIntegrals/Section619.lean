import Mathlib.Data.List.Defs

/-!
# DLMF 6.19: tables

Section 6.19 is a bibliography of numerical tables rather than a section of
numbered identities. The typed records below preserve the functions, grids,
sources, and stated accuracy without pretending that a table lookup is an
analytic theorem.
-/

noncomputable section
namespace LMLF.Blueprint.ExponentialIntegrals.Section619

/-- DLMF 6.19: bibliographic sources named by the section. -/
inductive TableSource
  | lebedevFedorova1960
  | fletcherEtAl1962
  | abramowitzStegun1964
  | zhangJin1996
deriving DecidableEq, Repr

/-- DLMF 6.19: quantities tabulated in the cited real and complex tables. -/
inductive TableQuantity
  | xInvSi
  | negXInvSqCin
  | xInvEin
  | negXInvEinNeg
  | si
  | ci
  | siPi
  | cinPi
  | ei
  | eOne
  | xExpNegEi
  | xExpEOne
  | xF
  | xSqG
  | zExpEOne
  | expEOne
  | eOneAddLog
  | realImagEOne
deriving DecidableEq, Repr

/-- One-dimensional tabulation grids used by DLMF 6.19. -/
inductive AxisGrid
  | arithmetic (start step stop : ℚ)
  | piecewise (start step midpoint step' stop : ℚ)
  | piecewise3WithTail (start step midpoint step' midpoint' step'' stop : ℚ)
      (tail : List ℚ)
  | interval (start stop : ℚ)
  | inverseArithmetic (start step stop : ℚ)
  | explicit (values : List ℚ)
  | signedExplicit (values : List ℚ)

/-- Cartesian grids for the real variable `x` and complex coordinates `x,y`. -/
inductive TableGrid
  | x (grid : AxisGrid)
  | xy (xGrid yGrid : AxisGrid)

/-- Accuracy notation used by the DLMF table descriptions. -/
inductive TableAccuracy
  | significant (low high : Nat)
  | decimal (digits : Nat)

/-- A typed bibliographic table record for DLMF 6.19. -/
structure TableRecord where
  source : TableSource
  pages : String
  quantities : List TableQuantity
  grid : TableGrid
  accuracy : TableAccuracy

/-! ### Introduction -/

/-- DLMF 6.19#i.p1: the introductory index references. -/
-- ANCHOR: indexReferences
def indexReferences : List TableSource :=
  [.lebedevFedorova1960, .fletcherEtAl1962]
-- ANCHOR_END: indexReferences

/-! ### Real variables -/

/-- DLMF 6.19#ii.p1, 6.19#I1.i1.p1, 6.19#I1.i2.p1: real-variable tables. -/
-- ANCHOR: realVariableTables
def realVariableTables : List TableRecord :=
  [ { source := .abramowitzStegun1964
      pages := "Chapter 5"
      quantities := [.xInvSi, .negXInvSqCin, .xInvEin, .negXInvEinNeg]
      grid := .x (.arithmetic 0 (1 / 100) (1 / 2))
      accuracy := .significant 8 11 }
  , { source := .abramowitzStegun1964
      pages := "Chapter 5"
      quantities := [.si, .ci, .ei, .eOne]
      grid := .x (.arithmetic (1 / 2) (1 / 100) 2)
      accuracy := .significant 8 11 }
  , { source := .abramowitzStegun1964
      pages := "Chapter 5"
      quantities := [.si, .ci, .xExpNegEi, .xExpEOne]
      grid := .x (.arithmetic 2 (1 / 10) 10)
      accuracy := .significant 8 11 }
  , { source := .abramowitzStegun1964
      pages := "Chapter 5"
      quantities := [.xF, .xSqG, .xExpNegEi, .xExpEOne]
      grid := .x (.inverseArithmetic 0 (1 / 200) (1 / 10))
      accuracy := .significant 8 11 }
  , { source := .abramowitzStegun1964
      pages := "Chapter 5"
      quantities := [.siPi, .cinPi]
      grid := .x (.arithmetic 0 (1 / 10) 10)
      accuracy := .significant 8 11 }
  , { source := .zhangJin1996
      pages := "pp. 652, 689"
      quantities := [.si, .ci]
      grid := .x (.piecewise 0 (1 / 2) 20 2 30)
      accuracy := .decimal 8 }
  , { source := .zhangJin1996
      pages := "pp. 652, 689"
      quantities := [.ei, .eOne]
      grid := .x (.interval 0 100)
      accuracy := .significant 8 8 } ]
-- ANCHOR_END: realVariableTables

/-! ### Complex variables -/

/-- DLMF 6.19#iii.p1, 6.19#I2.i1.p1, 6.19#I2.i2.p1: complex-variable tables. -/
-- ANCHOR: complexVariableTables
def complexVariableTables : List TableRecord :=
  [ { source := .abramowitzStegun1964
      pages := "Chapter 5"
      quantities := [.zExpEOne]
      grid := .xy (.arithmetic (-19) 1 20) (.arithmetic 0 1 20)
      accuracy := .decimal 6 }
  , { source := .abramowitzStegun1964
      pages := "Chapter 5"
      quantities := [.expEOne]
      grid := .xy (.arithmetic (-4) (1 / 2) (-2)) (.arithmetic 0 (1 / 5) 1)
      accuracy := .decimal 6 }
  , { source := .abramowitzStegun1964
      pages := "Chapter 5"
      quantities := [.eOneAddLog]
      grid := .xy (.arithmetic (-2) (1 / 2) (5 / 2)) (.arithmetic 0 (1 / 5) 1)
      accuracy := .decimal 6 }
  , { source := .zhangJin1996
      pages := "pp. 690–692"
      quantities := [.realImagEOne]
      grid := .xy
        (.signedExplicit [1 / 2, 1, 3, 5, 10, 15, 20, 50, 100])
        (.piecewise3WithTail 0 (1 / 2) 1 1 5 5 30 [50, 100])
      accuracy := .significant 8 8 } ]
-- ANCHOR_END: complexVariableTables

end LMLF.Blueprint.ExponentialIntegrals.Section619
