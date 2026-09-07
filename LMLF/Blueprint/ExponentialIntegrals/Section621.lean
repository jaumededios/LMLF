import Mathlib.Data.List.Defs

/-!
# DLMF §6.21 Software

This section is a bibliographic page rather than a page of analytic identities.
The typed lists below preserve the DLMF distinction between web-downloadable
research software and related literature.
-/

namespace LMLF.Blueprint.ExponentialIntegrals.Section621

/-- DLMF 6.21(ii): web-downloadable software for real arguments. -/
inductive RealWebSoftware
  | amos1980a
  | cody1993b
  | smith2011
deriving DecidableEq, Repr

/-- DLMF 6.21(iii): web-downloadable software for complex arguments. -/
inductive ComplexWebSoftware
  | amos1990
deriving DecidableEq, Repr

/-- DLMF 6.21(ii): related literature listed after the downloadable entries. -/
inductive RelatedRealSoftwareLiterature
  | gautschi1973
  | macleod1996b
  | paciorek1970
  | stegunAndZucker1976
deriving DecidableEq, Repr

/-- DLMF 6.21(i): directories supplying broader software indexes. -/
inductive SoftwareDirectory
  | dlmfSoftwareIndex
  | gamsClassC5
deriving DecidableEq, Repr

/- The declarations below are deliberately finite data, not claims that a
   package is installed or that a cited algorithm has a formal verification. -/

/-- DLMF 6.21(i): the two directory sources named by the introduction. -/
-- ANCHOR: dlmf_6_21_i_p2
def softwareDirectories : List SoftwareDirectory :=
  [ .dlmfSoftwareIndex
  , .gamsClassC5 ]
-- ANCHOR_END: dlmf_6_21_i_p2

/-- DLMF 6.21(ii): the real-variable web-downloadable software entries. -/
-- ANCHOR: dlmf_6_21_ii_p1
def realVariableSoftware : List RealWebSoftware :=
  [ .amos1980a
  , .cody1993b
  , .smith2011 ]
-- ANCHOR_END: dlmf_6_21_ii_p1

/-- DLMF 6.21(ii): related real-variable software literature. -/
-- ANCHOR: dlmf_6_21_I1_related
def relatedRealVariableLiterature : List RelatedRealSoftwareLiterature :=
  [ .gautschi1973
  , .macleod1996b
  , .paciorek1970
  , .stegunAndZucker1976 ]
-- ANCHOR_END: dlmf_6_21_I1_related

/-- DLMF 6.21(iii): the complex-variable web-downloadable software entry. -/
-- ANCHOR: dlmf_6_21_iii_p1
def complexVariableSoftware : List ComplexWebSoftware :=
  [ .amos1990 ]
-- ANCHOR_END: dlmf_6_21_iii_p1

end LMLF.Blueprint.ExponentialIntegrals.Section621
