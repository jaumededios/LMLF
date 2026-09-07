# Chapter 5: holomorphic linear IVP on a simply connected domain

## Status and source boundary

**Status: accepted.** This page records the complete global continuation proof for Olver's Chapter
5, Theorem 3.1, together with its scalar second-order consequences and the required test-only Gauss
consumer. Two independent reviews accepted the complete local and global mathematics. Fresh
independent code reviews accepted both the local and global Lean developments without findings,
and root's repository-level validation accepted the four public theorems and their consumers.

Source: Frank W. J. Olver, *Asymptotics and Special Functions*, corrected A K Peters reprint
(1997) of the 1974 edition, Chapter 5, Theorem 3.1, printed pp. 145--146 (preserved DjVu
pp. 158--159). This is original mathematical exposition and includes no scan, OCR, or copied
source passage.

The reviewed baseline is commit `1637092c7a1abb0681dfe52c45f5b7fa1a7e9e8a`, Lean `v4.33.1`,
and Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`. The 882-line local and 729-line global
mathematical packets have SHA-256 digests
`e8bad9c297bd074e010d8ad742e8de1d0e120721078476dcdc5fe17fdc150d2a` and
`49531707760938182b14324014706877e8e5f6fae36c25bde855eab118998090`.
Two independent reviews accepted the combined mathematics, with digests
`34f5f0b9393e55326ec515ee08a71c1293523a3cf959e51253b6e5c8183e265b` and
`a2bd9e813ce04a8e9a97377f5595c4a0793b7aad0e55992c8fa88e98a0d2a104`.

The fresh independent local code review has SHA-256
`2d66a39e93090f90496528de9e0966395f2c8f4c391372574cc71396fa73c330`; the fresh independent
global code review has SHA-256
`aaddfdd33f8296f25f52873e14e1e77f1fb04632972919d5fb050aae169b3221`. Both reports returned
ACCEPT with no findings. The frozen accepted source and test artifacts are:

- the 448-line [`LMLF/ODE/HolomorphicLinear/Local.lean`](../../LMLF/ODE/HolomorphicLinear/Local.lean#L373),
  SHA-256 `1cec5f590a15fc7c31a457a65f182a85aa5d6e471ade63af0749590088b95782`;
- the 39-line [`LMLFTest/ODE/HolomorphicLinear/Local.lean`](../../LMLFTest/ODE/HolomorphicLinear/Local.lean#L11),
  SHA-256 `984cf9d93f868f34faa61023c4c03421a68dad8ce9962244870497afd630c858`;
- the 415-line [`LMLF/ODE/HolomorphicLinear.lean`](../../LMLF/ODE/HolomorphicLinear.lean#L289),
  SHA-256 `bfd99286e5f22c52261dead823b6dc0a5ccb42c7d0eb457f1d86f9ee90b289a6`;
- the 117-line [`LMLF/ODE/HolomorphicSecondOrder.lean`](../../LMLF/ODE/HolomorphicSecondOrder.lean#L18),
  SHA-256 `ffd11ea3c489050eea8a37988952c30ee4f904fd091eb3e94407302e25dddf62`;
- the 20-line [`LMLFTest/ODE/HolomorphicLinear.lean`](../../LMLFTest/ODE/HolomorphicLinear.lean#L10),
  SHA-256 `7103829992e7d07bc423ee6e190f73a5ac77e5543c22ec7d01d4f1b981a4ca6a`;
- the 95-line [`LMLFTest/ODE/HolomorphicSecondOrder.lean`](../../LMLFTest/ODE/HolomorphicSecondOrder.lean#L30),
  SHA-256 `8dcbe129eab4ef2171b988c87c18c367dd0269e035a3fcb4d80273ee0a7e1b9c`.

The accepted integration wiring has SHA-256
`15a0e0e008f4a6e9d25be5e2985097a1554b801467b6eb77ce2871ddfc93aa94` for
[`LMLF/Results.lean`](../../LMLF/Results.lean) and
`cc62ebfb92054baba30968d5fabd2164a646f11296863d8a20eb64f7f4841785` for
[`lakefile.toml`](../../lakefile.toml). All eight historical production-file baseline hashes were
unchanged.

Root acceptance passed the complete local 3,158-job `lake build`, all 25 negative fixtures,
complete zero-diagnostic LSP checks for every new production and test file, direct
warning-as-error checks, deterministic file and library checks, import and diff checks, and
standard-axiom checks for all four public theorems and the named test declarations; those checks
reported only `propext`, `Classical.choice`, and `Quot.sound`. The local main and remote main were
both verified at the clean baseline commit above. The repository's sole CI workflow is
manual-only; it was not dispatched, and no CI was run.

The architecture has four public theorems and no public continuation framework:

```text
LMLF.ODE.HolomorphicLinear.Local
  LMLF.ODE.exists_unique_holomorphicLinearIVP_ball

LMLF.ODE.HolomorphicLinear
  LMLF.ODE.exists_unique_holomorphicLinearIVP

LMLF.ODE.HolomorphicSecondOrder
  LMLF.ODE.exists_unique_holomorphicSecondOrderLinear
  LMLF.ODE.infinite_holomorphicSecondOrderLinearSolutions
```

The local theorem is the analysis-only input. The solution predicate, presheaf, stalks, germs,
`ULift` adapter, étale space, covering, lift, and extraction helpers remain private. The scalar
module is downstream of the global Banach-valued theorem. No public Picard representation,
solution-sheaf structure, germ-transport API, or continuation certificate is introduced.

## Public first-order theorem

Let `E : Type u` carry exactly

```text
[NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E].
```

Let `Z⊆ℂ` be open and simply connected, let
`A:ℂ→(E→L[ℂ]E)` be analytic on `Z`, fix `x₀∈Z`, and prescribe `u₀:E`. Then
`exists_unique_holomorphicLinearIVP` returns an ambient `u:ℂ→E` such that, in this order,

1. `u x₀ = u₀`;
2. `AnalyticOnNhd ℂ u Z`;
3. `HasDerivAt u (A z (u z)) z` for every `z∈Z`;
4. for every ambient `v:ℂ→E`, the same initial value, analyticity, and pointwise equation imply
   `Set.EqOn u v Z`.

This is not an ordinary `∃!` among total functions: two ambient representatives can agree on `Z`
and differ elsewhere. There is no finite-dimensional, `Nontrivial E`, coefficient-bound, or
`Type 0` assumption.

The only analytic input is the accepted whole-ball arbitrary-basepoint theorem
[`exists_unique_holomorphicLinearIVP_ball`](../../LMLF/ODE/HolomorphicLinear/Local.lean#L373).
For one disk and every basepoint in that same disk, it provides all initial values and `EqOn`
uniqueness. Its complete Picard and factorial proof is given in the
[local blueprint](chapter05-holomorphic-local-ivp.md).

## Universe-safe base space

The pinned concrete presheaf and étale-space APIs place the base and the value types in the same
universe. Using the subtype `Z` itself as the base would therefore silently restrict a general
`E : Type u` to `Type 0`. Define instead the private base

\[
  X=\operatorname{ULift}^{u}(Z).
\]

Let `c:X→ℂ` be `ULift.down`, followed by the subtype inclusion. This is an open embedding: the
`ULift` map is a homeomorphism and the inclusion of the open subtype `Z` is an open embedding.
Thus the image under `c` of every open subset of `X` is ambient-open in `ℂ`.

The same homeomorphism transports the needed topology. Simple connectedness of `Z` gives a
`SimplyConnectedSpace Z` instance, hence one on `X`. Since open subsets of `ℂ` are locally path
connected, `Z` and then `X` obtain `LocallyPathConnectedSpace` instances. These structures are
used by the covering-lift theorem and never appear in the public statement.

## The private local predicate of solutions

For an open `U` of `X`, write

\[
  U^a=c''U.
\]

For a section function `s:U→E`, define `Sol U s` to mean that there exists an ambient
`a:ℂ→E` with

1. `a(c x)=s(x)` for every `x∈U`;
2. `AnalyticOnNhd ℂ a Uᵃ`;
3. `HasDerivAt a (A z (a z)) z` for every `z∈Uᵃ`.

The section is stored as a function; the ambient function is only a proof witness. No quotient of
ambient functions is introduced.

### Restriction

If `V≤U` and `Sol U s`, restrict `s` to `V` and reuse the same ambient witness. The inclusion
`Vᵃ⊆Uᵃ`, monotonicity of `AnalyticOnNhd`, and pointwise restriction of the derivative equation
give `Sol V`. Identity and composition of restriction maps are definitional equalities.

### Locality

Suppose each point of `U` has an open neighborhood `V≤U` on which the restricted section has an
ambient solution witness. Because `c` is injective, every `z∈Uᵃ` represents a unique point of `U`.
Define a total ambient `a` to have the section value on `Uᵃ` and zero outside it.

Fix `z∈Uᵃ` and choose a local neighborhood `V` with ambient witness `b`. The set `Vᵃ` is an ambient
open neighborhood of `z`. On it, `a` and `b` both equal the given section, so they are eventually
equal at `z`. Transfer analyticity using `AnalyticAt.congr`. Transfer the derivative equation using
`Filter.EventuallyEq.hasDerivAt_iff`; equality at the basepoint also identifies
`A z (a z)` with `A z (b z)`. Repeating at every point proves `Sol U s`.

Therefore `Sol` gives a `TopCat.LocalPredicate` on the constant family `fun _ : X ↦ E`. Let `P`
be this local predicate and

```text
F = TopCat.subsheafToTypes P.
```

Mathlib supplies evaluation of a germ,
`TopCat.stalkToFiber P x : F.stalk x → E`, and
`TopCat.stalkToFiber_germ`, which says that the germ of a section evaluates to its value at `x`.
No continuity of this evaluation into the ordinary topology of `E` is needed or asserted.

## Stalk evaluation is injective

Fix `x:X`. Consider two solution sections on open neighborhoods `U` and `V` of `x`, and suppose
their values at `x` agree. Choose ambient solution witnesses `a` and `b`. Their ambient domains
`Uᵃ` and `Vᵃ` are open neighborhoods of `c x`, so choose `r>0` with

\[
  \operatorname{ball}(c x,r)\subseteq U^a\cap V^a.
\]

The coefficient is analytic on this ball. Apply the local disk theorem at its center with the
common value. Both `a` and `b` are analytic solutions with that initial value, so each agrees on
the disk with the selected local solution. Hence they agree with one another there. Pulling the
disk back through `c` gives a common open neighborhood on which the original sections agree.

This proves the neighborhood-uniqueness premise of `TopCat.stalkToFiber_injective`; hence

\[
  \operatorname{stalkToFiber}_x:F_x\longrightarrow E
\]

is injective. Injectivity is a consequence of local ODE uniqueness, not a generic property of
presheaf stalks.

## One disk trivializes all fibers above it

Fix `x:X`. Since `Z` is open, choose `R>0` so that

\[
  D=\operatorname{ball}(c x,R)\subseteq Z.
\]

Let `B` be the inverse image of `D` in `X`. Its ambient image is exactly `D`. For every `y∈B`,
consider evaluation

\[
  \operatorname{ev}_y:F(B)\longrightarrow E,
  \qquad s\longmapsto s(y).
\]

This map is bijective. For surjectivity, prescribe arbitrary `e:E` at `c y`; the local disk theorem
on the same disk `D`, now based at `c y`, gives a solution on all of `D` and hence a section of
`F(B)` with value `e`. For injectivity, two sections with the same value at `y` have ambient
witnesses on `D`; local uniqueness based at `c y` makes those witnesses, and therefore the
sections, equal on the whole disk.

For every section `s`, `stalkToFiber_germ` gives the commuting identity

\[
  \operatorname{stalkEval}_y(\operatorname{germ}_{B,y}(s))
  =\operatorname{ev}_y(s).                                  \tag{1}
\]

The left evaluation is injective and the right evaluation is bijective. Thus the germ map
`F(B)→F.stalk y` is bijective:

- injectivity follows by applying (1) to equal germs and then using injectivity of `evᵧ`;
- for a stalk element `ξ`, choose `s` with
  `evᵧ(s)=stalkEvalᵧ(ξ)`; equation (1) and injectivity of stalk evaluation imply
  `germ(s)=ξ`.

The quantifier order is decisive: one disk `B` is chosen at `x`, and its germ map is bijective for
every `y∈B`. A center-only disk theorem, or a disk chosen anew for each `y`, would not match the
covering criterion.

## The étale space is a covering

Let `T=F.EtaleSpace`. A point of `T` consists of a basepoint and a solution germ above it, and
`TopCat.Presheaf.EtaleSpace.base:T→X` is the projection. The preceding one-disk/all-points lemma is
exactly the hypothesis of `TopCat.Presheaf.EtaleSpace.isCoveringMap_base`. Therefore the projection
is a covering map.

Nothing in this step assumes a covering or continuation certificate as input. The covering is
derived from analytic local existence and uniqueness.

## Global existence from a covering lift

Let `x₀ˣ:X` denote the lifted point corresponding to `x₀∈Z`. Choose a small disk about `x₀` inside
`Z`. The local theorem with datum `u₀` gives a section `s₀`; let `e₀:T` be its germ over `x₀ˣ`.

Apply `IsCoveringMap.existsUnique_continuousMap_lifts` to the covering `T→X`, the identity map on
`X`, and the chosen point `e₀`. The simply connected and locally path connected instances on `X`
give a continuous lift

\[
  L:X\longrightarrow T,
  \qquad L(x_0^X)=e_0,
  \qquad \operatorname{base}(Lx)=x.                         \tag{2}
\]

Thus `L` continuously chooses one solution germ above every point.

Because the stalk type depends on the basepoint, first define the private total map

\[
  \operatorname{germValue}(t)=
  \operatorname{stalkToFiber}
    (P,t.\operatorname{base},t.\operatorname{germ})
  \quad(t:T).                                                \tag{3}
\]

This is definitionally well typed: `t.germ` lies in the stalk over `t.base`. One must not instead
treat the germ component of `L x` directly as an element of the stalk over `x`; (2) is a
propositional equality, not a definitional one. Put `u_X=germValue∘L`, and define the requested
ambient `u:ℂ→E` to equal `u_X` over `Z` via `ULift.up`, and zero outside `Z`.

### Extraction of actual local analytic sections

Fix `x:X`. Continuity of `L` gives convergence of `L` to `L x` along the neighborhood filter.
The theorem `TopCat.Presheaf.EtaleSpace.exists_section_of_tendsto` returns an open neighborhood
`U` of the base of `L x`, a section `s∈F(U)`, and, eventually near `x`, both membership over `U`
and equality of the selected germ with the germ of `s`.

At such a nearby `y`, apply `stalkToFiber_germ` first at the actual basepoint `base (L y)`. It
identifies `germValue (L y)` with the corresponding value of `s`. Only afterward transport the
subtype argument along `base (L y)=y`; proof irrelevance removes the discrepancy between the
membership proofs. This yields, eventually near `x`,

\[
  u_X(y)=s(y).                                                \tag{4}
\]

Choose the ambient analytic ODE witness `a:ℂ→E` stored by `s`. Shrink the relative neighborhood in
`X` to an open one and take its image under the open embedding `c`. On this ambient open
neighborhood of `c x`, the total `u` agrees with `a`. Transfer `AnalyticAt` through the eventual
equality and transfer `HasDerivAt` through
`Filter.EventuallyEq.hasDerivAt_iff`, using equality at the point in the right-hand side
`A z (u z)`. Since `x` was arbitrary,

\[
  \operatorname{AnalyticOnNhd}_{\mathbb C}(u,Z),
  \qquad
  \operatorname{HasDerivAt}u(A(z)u(z))z\quad(z\in Z).        \tag{5}
\]

This proof does not infer analyticity from continuity of `L` or from continuity of stalk
evaluation. Analyticity comes from local equality with the actual analytic section witnesses that
generate the étale topology.

At `x₀ˣ`, rewrite using `L(x₀ˣ)=e₀`, then apply `stalkToFiber_germ` to the initial section. It gives
`u(x₀)=s₀(x₀)=u₀`, completing global existence.

## Global `EqOn` uniqueness

Let `u` and `v` be ambient analytic solutions on `Z` with the same value at `x₀`. Choose a disk
centered at `x₀` and contained in `Z`. Local disk uniqueness gives equality throughout that disk,
so `u` and `v` are eventually equal at `x₀`.

Simple connectedness gives path connectedness and hence preconnectedness of `Z`. The Banach-valued
identity principle
`AnalyticOnNhd.eqOn_of_preconnected_of_eventuallyEq` promotes the local equality to

\[
  \operatorname{EqOn}(u,v,Z).                                \tag{6}
\]

Thus simple connectedness is used for existence through the covering lift, while connectedness is
enough for uniqueness after local uniqueness has been established.

## Scalar second-order theorem

Let `f,g:ℂ→ℂ` be analytic on the same open simply connected `Z`, take `x₀∈Z`, and prescribe
`w₀,w₁:ℂ`. The public theorem `exists_unique_holomorphicSecondOrderLinear` returns an ambient
`w:ℂ→ℂ` such that, in this order,

1. `AnalyticOnNhd ℂ w Z`;
2. `w x₀ = w₀`;
3. `HasDerivAt w w₁ x₀`;
4. for every `z∈Z`,
   `HasDerivAt (deriv w) (-(f z * deriv w z + g z * w z)) z`;
5. every ambient competitor `q` with these same properties satisfies `Set.EqOn w q Z`.

This is a genuine first-and-second complex derivative statement, not a pair of unrelated
coordinate functions.

Take `E=ℂ×ℂ` and define

\[
  A(z)(a,b)=\bigl(b,-(g(z)a+f(z)b)\bigr).                   \tag{7}
\]

To bundle (7), use the constant coordinate map
`p₁=ContinuousLinearMap.snd ℂ ℂ ℂ` and

\[
  p_2(z)=-\bigl(g(z)\,\operatorname{fst}+f(z)\,\operatorname{snd}\bigr).
\]

Analytic closure under scalar multiplication, addition, and negation proves the pair
`z↦(p₁,p₂(z))` analytic. Compose with the continuous linear equivalence
`ContinuousLinearMap.prodL ℂ` to obtain the desired operator-valued analytic map. Merely invoking
`AnalyticOnNhd.prod` produces the pair of coordinate operators, not yet the bundled map, so this
last composition is necessary.

Apply the global first-order theorem at initial state `(w₀,w₁)`. Write the resulting state as
`U(z)=(w(z),v(z))`. Projection by the continuous linear coordinate maps proves `w` and `v`
analytic and gives

\[
  w'(z)=v(z),
  \qquad v'(z)=-(g(z)w(z)+f(z)v(z)).                         \tag{8}
\]

The first equality is a `HasDerivAt` witness, hence `deriv w z=v z`. Because it holds throughout
the open set, `deriv w` and `v` agree on a neighborhood of every point. Transfer the second witness
in (8) across this local equality and commute the two scalar summands to obtain

\[
  \operatorname{HasDerivAt}(\operatorname{deriv}w)
  \bigl(-(f(z)\operatorname{deriv}w(z)+g(z)w(z))\bigr)z.     \tag{9}
\]

At `x₀`, the first projection gives `w(x₀)=w₀` and
`HasDerivAt w w₁ x₀`.

For uniqueness, let `q` be a scalar competitor. Its analyticity implies analyticity of `deriv q`.
The state `z↦(q z,deriv q z)` solves (7): differentiability of `q` gives the first coordinate and
the assumed scalar second-derivative witness gives the second. `HasDerivAt.deriv` at `x₀`
identifies its initial state with `(w₀,w₁)`. First-order `EqOn` uniqueness makes the state functions
equal on `Z`, and first projection gives scalar `EqOn` uniqueness.

## Infinitely many solutions on the domain

The theorem `infinite_holomorphicSecondOrderLinearSolutions` asserts infinitude of exactly the set

```text
{s : Z → ℂ | ∃ w : ℂ → ℂ,
  AnalyticOnNhd ℂ w Z ∧
  (∀ z ∈ Z,
    HasDerivAt (deriv w) (-(f z * deriv w z + g z * w z)) z) ∧
  s = fun z : Z ↦ w z}
```

It counts restricted functions `Z→ℂ`, not total ambient functions that can be changed outside the
domain.

Simple connectedness makes `Z` nonempty; choose `x₀∈Z`. For each `a:ℂ`, apply the second-order
theorem with `w(x₀)=a` and `w'(x₀)=0`, and let `Φ(a):Z→ℂ` be the restriction of a chosen solution.
Every `Φ(a)` lies in the displayed set. If `Φ(a)=Φ(b)`, evaluate at the subtype point `x₀`; the
prescribed values give `a=b`. Hence `Φ` is injective. Since `ℂ` is infinite, its range is infinite,
and that range is contained in the solution set. Therefore the displayed domain-level set is
infinite.

## Test-only Gauss reuse

The required downstream test is named

```text
LMLFTest.ODE.regularizedGauss_reuses_holomorphicSecondOrderLinearIVP
```

It imports the new scalar API and the accepted regularized analytic and ODE APIs. It is not a
principal-function definition and adds no Gauss continuation theorem.

Fix arbitrary `a,b,c:ℂ`, including `c=-(N:ℂ)`, and let `Z⊆ℂ` be open and simply connected with

\[
  Z\subseteq\operatorname{ball}(0,1),
  \qquad 0\notin Z.
\]

Choose `x₀∈Z`. Put

\[
\begin{aligned}
 d(z)&=z(1-z),\\
 f(z)&=\frac{c-(a+b+1)z}{d(z)},\\
 g(z)&=\frac{-ab}{d(z)},\\
 R(z)&=\operatorname{regularizedGaussHypergeometricSeriesSum}(a,b,c,z).
\end{aligned}                                                \tag{10}
\]

The test obtains from the scalar IVP theorem an ambient solution `w` with

\[
  w(x_0)=R(x_0),
  \qquad w'(x_0)=R'(x_0),
\]

solving `w''+fw'+gw=0` on `Z`, and proves `Set.EqOn w R Z`.

### Denominator and coefficient analyticity

For `z∈Z`, the exclusion of zero gives `z≠0`. Strict unit-disk membership gives `‖z‖<1`, hence
`z≠1`, because otherwise `‖z‖=1`. Therefore `1-z≠0` and

\[
  d(z)=z(1-z)\ne0.                                           \tag{11}
\]

The numerators and denominator in (10) are entire by the analytic closure rules for constants,
the identity, addition, subtraction, multiplication, and negation. Apply `AnalyticOnNhd.div` on
`Z` using (11). This proves `f` and `g` analytic. A tactic may discharge the polynomial closure
steps, but the pointwise nonvanishing proof is substantive and remains explicit.

### The regularized series is a competitor

The accepted theorem
`LMLF.Definitions.regularizedGaussHypergeometricSeriesSum_analyticOnNhd` makes `R` analytic on the
unit disk for all three parameters. Restrict it to `Z`; then `AnalyticOnNhd.deriv` makes
`deriv R` analytic there.

For `z∈Z`, the accepted theorem
`LMLF.ODE.regularizedGaussHypergeometricSeriesSum_gaussEquation` gives

\[
  d(z)R''(z)+\bigl(c-(a+b+1)z\bigr)R'(z)-abR(z)=0.           \tag{12}
\]

Writing `N(z)=c-(a+b+1)z` and using (11), rearrange (12):

\[
\begin{aligned}
 R''(z)
 &=\frac{-N(z)R'(z)+abR(z)}{d(z)}\\
 &=-\left(f(z)R'(z)+g(z)R(z)\right).                        \tag{13}
\end{aligned}
\]

In Lean, clear exactly the nonzero denominator with `eq_div_iff` or `div_eq_iff`, substitute the
accepted polynomial equation, and use commutative-ring normalization. The accepted equation
already uses `deriv R z` and `deriv (deriv R) z`, so this algebraic step hides no derivative
conversion.

Analyticity of `deriv R` at `z` gives a canonical
`HasDerivAt (deriv R) (deriv (deriv R) z) z`; rewrite its derivative value using (13). Analyticity
of `R` at `x₀` similarly gives `HasDerivAt R (deriv R x₀) x₀`. Therefore `R` meets every competitor
obligation of the scalar IVP theorem. Apply that theorem with initial data
`R x₀` and `deriv R x₀`; its uniqueness clause directly gives the required `EqOn w R Z`.

This test works at exceptional parameters because both accepted inputs are regularized and
unconditional in `c`. It says nothing at the excluded origin, across the unit circle, on a slit
plane, or about continuation of a named Gauss function.

## Pinned API ownership and implementation traps

- `Mathlib.Topology.Sheaves.LocalPredicate` owns `TopCat.LocalPredicate`,
  `TopCat.subsheafToTypes`, `TopCat.stalkToFiber`, `TopCat.stalkToFiber_germ`, and
  `TopCat.stalkToFiber_injective`. The locality field must be proved explicitly; evaluation is not
  automatically injective.
- `Mathlib.Topology.Sheaves.EtaleSpace` owns
  `TopCat.Presheaf.EtaleSpace.isCoveringMap_base` and
  `TopCat.Presheaf.EtaleSpace.exists_section_of_tendsto`. The former needs one neighborhood whose
  germ map is bijective at every point; the latter supplies the genuine local analytic section
  used in extraction.
- `Mathlib.Topology.Homotopy.Lifting` owns
  `IsCoveringMap.existsUnique_continuousMap_lifts`. Its source requires simply connected and
  locally path connected instances.
- `Homeomorph.ulift.toHomotopyEquiv` transports simple connectedness; the open embedding of
  `Homeomorph.ulift` transports local path connectedness. Open images use
  `IsOpen.isOpenMap_subtype_val` together with that open embedding.
- `AnalyticAt.congr`, `Filter.EventuallyEq.hasDerivAt_iff`, and `AnalyticOnNhd.congr` transfer local
  representatives. Continuity of the lift or of stalk evaluation is not analytic evidence.
- The dependent value map must first evaluate a general étale-space point in the stalk over its
  own base. Only afterward may the lift equation transport that value to a chosen `x`.
- `AnalyticOnNhd.eqOn_of_preconnected_of_eventuallyEq` is the Banach-valued global identity
  principle used for uniqueness. `AnalyticOnNhd.deriv` constructs the scalar competitor state.
- `ContinuousLinearMap.prodL` bundles the two analytic coordinate operators in the scalar system.
  `AnalyticOnNhd.prod` alone stops one type short.
- `Set.infinite_range_of_injective` proves infinitude of the restrictions. Counting ambient
  functions would produce a false off-domain notion of distinct solution.

## Source-to-proof-to-Lean map and nonclaims

| Source or mathematical role | Natural-language stage | Owning public module |
|---|---|---|
| disk construction inside Theorem 3.1 | Picard primitives, factorial bounds, local uniform sum, disk uniqueness | [`exists_unique_holomorphicLinearIVP_ball`](../../LMLF/ODE/HolomorphicLinear/Local.lean#L373) |
| analytic continuation and monodromy | private solution local predicate, stalk separation, covering, identity lift, analytic extraction | [`exists_unique_holomorphicLinearIVP`](../../LMLF/ODE/HolomorphicLinear.lean#L289) |
| prescribed scalar value and derivative | state-space specialization `E=ℂ×ℂ` and projection | [`exists_unique_holomorphicSecondOrderLinear`](../../LMLF/ODE/HolomorphicSecondOrder.lean#L18) |
| infinitely many source solutions | inject initial values into restrictions `Z→ℂ` | [`infinite_holomorphicSecondOrderLinearSolutions`](../../LMLF/ODE/HolomorphicSecondOrder.lean#L93) |
| downstream reuse only | normalized regularized Gauss equation on a punctured subdomain of the unit disk | [`regularizedGauss_reuses_holomorphicSecondOrderLinearIVP`](../../LMLFTest/ODE/HolomorphicSecondOrder.lean#L30) |

The accepted source-to-natural-language-to-Lean chain checks exactly `C05-03-01`, `C05-03-02`,
and all of `T05-3.1`. Current Chapter 5 coverage is **16/108 = 14.81% claim components, 3/13 =
23.08% whole numbered theorems, and 0/44 = 0% exercises**. The 108-component denominator retains
the disclosed editorial bundling rule; this development does not alter any denominator.

The development does not prove the complex-domain fundamental-pair/Wronskian extension
`C05-03-03`, the source's naming of the Liouville--Neumann expansion `C05-03-04`, the local Taylor
recurrence `C05-03-05`, Theorem 3.2, Gauss continuation `C05-09-04`, cross-cut behavior, or any
principal branch theorem. It also does not modify or depend on the existing real-time
second-order ODE API.
