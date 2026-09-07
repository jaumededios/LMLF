import Mathlib.Data.List.Defs

noncomputable section
namespace LMLF.Blueprint.ExponentialIntegrals.Section617

/-- DLMF 6.17#p1: application areas named in the physical-applications survey. -/
inductive PhysicalApplication
  | diffusionTheory
  | transportProblems
  | stellarRadiativeEquilibrium
  | quantumExchangeIntegrals
  | astrophysics
  | electromagneticRadiation
deriving DecidableEq, Repr

/-- DLMF 6.17#p1: the cited application areas and their order in the survey. -/
-- ANCHOR: dlmf_6_17_p1
def citedPhysicalApplications : List PhysicalApplication :=
  [ .diffusionTheory
  , .transportProblems
  , .stellarRadiativeEquilibrium
  , .quantumExchangeIntegrals
  , .astrophysics
  , .electromagneticRadiation ]
-- ANCHOR_END: dlmf_6_17_p1

end LMLF.Blueprint.ExponentialIntegrals.Section617
