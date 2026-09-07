import Mathlib.Data.List.Defs

namespace LMLF.Blueprint.ExponentialIntegrals.Section620

/-- DLMF 6.20(i): sources for elementary-function approximations. -/
inductive ElementaryApproximationSource
  | hastings1955
  | codyThacher1968
  | codyThacher1969
  | macleod1996b
deriving DecidableEq, Repr

/-- DLMF 6.20(ii): sources for Chebyshev-series expansions. -/
inductive ChebyshevApproximationSource
  | clenshaw1962
  | lukeWimp1963
  | luke1969b_smallInterval
  | luke1969b_realRanges
  | luke1969b_infinity
deriving DecidableEq, Repr

/-- DLMF 6.20(iii): sources for Padé-type and rational expansions. -/
inductive RationalApproximationSource
  | luke1969b_pade
  | luke1969b_einRational
deriving DecidableEq, Repr

/-- DLMF 6.20(i): the four cited source families for elementary approximations. -/
-- ANCHOR: dlmf_6_20_i_p1
def elementaryApproximationSources : List ElementaryApproximationSource :=
  [ .hastings1955
  , .codyThacher1968
  , .codyThacher1969
  , .macleod1996b ]
-- ANCHOR_END: dlmf_6_20_i_p1

/-- DLMF 6.20(ii): the five cited source families for Chebyshev expansions. -/
-- ANCHOR: dlmf_6_20_ii_p1
def chebyshevApproximationSources : List ChebyshevApproximationSource :=
  [ .clenshaw1962
  , .lukeWimp1963
  , .luke1969b_smallInterval
  , .luke1969b_realRanges
  , .luke1969b_infinity ]
-- ANCHOR_END: dlmf_6_20_ii_p1

/-- DLMF 6.20(iii): the two cited source families for rational expansions. -/
-- ANCHOR: dlmf_6_20_iii_p1
def rationalApproximationSources : List RationalApproximationSource :=
  [ .luke1969b_pade
  , .luke1969b_einRational ]
-- ANCHOR_END: dlmf_6_20_iii_p1

end LMLF.Blueprint.ExponentialIntegrals.Section620
