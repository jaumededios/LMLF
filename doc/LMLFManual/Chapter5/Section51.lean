import VersoManual
import Verso.Code.External
import LMLF.Blueprint.Gamma.Section51
import LMLFManual.Components

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean
open Verso.Code.External
open LMLFManual

set_option verso.exampleProject "."

#doc (Manual) "§5.1 Special Notation" =>
%%%
tag := "chapter-5-section-1"
%%%

:::dlmfChapter "https://dlmf.nist.gov/5.1"
Source: NIST Digital Library of Mathematical Functions, §5.1.
:::

# §5.1 Special Notation
%%%
number := false
%%%

Section 5.1 is the notation contract for the rest of Chapter 5.  It does not number
equations: instead, it fixes the domains of the recurring indices and variables, the
meaning of the small parameter `δ`, the Euler constant `γ`, and the names used for the
principal Gamma-family functions.  The declarations below keep those conventions visible
while reusing Mathlib's functions in every later section.

## Variables and parameters
%%%
number := false
%%%

::::dlmfEntry "5.1.variables" "https://dlmf.nist.gov/5.1"
The source convention is
$$`j,m,n\ \text{are nonnegative integers},\qquad k\ \text{is a nonnegative integer except in §5.20},`
$$`x,y\in\mathbb R,\qquad z=x+\mathrm{i}y,\qquad a,b,q,s,w\in\mathbb R\ \text{or}\ \mathbb C,\qquad |q|<1.`

Thus `j`, `m`, `n`, and the usual Chapter 5 `k`-indices are naturally represented by
`ℕ`; the stated §5.20 exception is a local convention of that later section.  Real
coordinates determine a complex argument through `z = x + i y`.  When a parameter is
allowed to be real or complex, the formal development uses `ℂ` and inserts the canonical
real-to-complex coercion.  The q restriction is a norm inequality in the complex model.

:::leanStatement "Lean · variable domains and complex coordinates"
```anchor section51Context (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
namespace LMLF.Blueprint.Gamma.Section51
```

```anchor NonnegativeInteger (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
abbrev NonnegativeInteger := ℕ
```

```anchor complexCoordinate (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
def complexCoordinate (x y : ℝ) : ℂ := (x : ℂ) + (y : ℂ) * Complex.I
```

```anchor complexCoordinate_re (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
theorem complexCoordinate_re (x y : ℝ) :
    (complexCoordinate x y).re = x
```

```anchor complexCoordinate_im (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
theorem complexCoordinate_im (x y : ℝ) :
    (complexCoordinate x y).im = y
```

```anchor qParameterCondition (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
def qParameterCondition (q : ℂ) : Prop := ‖q‖ < 1
```

```anchor real_qParameterCondition_iff (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
theorem real_qParameterCondition_iff (q : ℝ) :
    qParameterCondition (q : ℂ) ↔ |q| < 1
```
:::
::::

::::dlmfEntry "5.1.delta" "https://dlmf.nist.gov/5.1"
$$`\delta>0,\qquad \delta\ \text{arbitrarily small}.`

The symbol `δ` is an arbitrary small positive constant.  Its use is local to a
statement—typically as a sector margin or an error tolerance—and means `δ > 0`, with
the intended choice made as small as needed.  The elementary formal content is that every
positive tolerance admits such a choice:

:::leanStatement "Lean · positive-small convention"
```anchor exists_positive_delta_lt (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
theorem exists_positive_delta_lt {ε : ℝ} (hε : 0 < ε) :
    ∃ δ : ℝ, 0 < δ ∧ δ < ε
```
:::
::::

## Function names and historical alternatives
%%%
number := false
%%%

::::dlmfEntry "5.1.functions" "https://dlmf.nist.gov/5.1"
The principal functions named by the source are
$$`\Gamma(z),\qquad \psi(z),\qquad B(a,b),\qquad \Gamma_q(z).`

Here `Γ` is the Gamma function, `ψ` is the psi (digamma) function, `B` is the beta
function, and `Γ_q` is the q-Gamma function.  The Gamma and psi declarations below
are the canonical complex Mathlib objects used throughout LMLF.  For `B`, Mathlib's
`Complex.betaIntegral` is the interval Euler integral: its convergence theorem applies
when `0 < Re a` and `0 < Re b`.  The Lean wrapper accepts arbitrary complex arguments,
but its Euler-integral interpretation is used with those hypotheses; it is not the
meromorphic continuation, which is introduced separately in §5.12 when needed.  The
q-Gamma object is defined with its q-products in §5.18, where the same `|q|<1`
convention is used; this section intentionally introduces no second q-Gamma
implementation.

:::leanStatement "Lean · canonical Gamma-family names"
```anchor gammaFunction (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
noncomputable def gammaFunction (z : ℂ) : ℂ := Complex.Gamma z
```

```anchor psiFunction (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
noncomputable def psiFunction (z : ℂ) : ℂ := Complex.digamma z
```

```anchor betaFunction (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
noncomputable def betaFunction (a b : ℂ) : ℂ := Complex.betaIntegral a b
```
:::
::::

::::dlmfEntry "5.1.alternatives" "https://dlmf.nist.gov/5.1"
$$`\Gamma(z)=\Pi(z-1)=(z-1)!,\qquad
\psi(z)=\Psi(z-1)=\Psi(z)=\mathsf F(z-1).`

The source records historical alternatives for the first two functions:
`Γ(z)` may be written as Gauss's `Π(z−1)` or as `(z−1)!`; and `ψ(z)` may be
written as Gauss's `Ψ(z−1)`, Davis's `Ψ(z)`, or Pairman's `𝖥(z−1)`.  These are
not different functions.  The shifted aliases below make the argument shift explicit,
which avoids confusing Gauss's `Π` with a finite product or a q-Pochhammer symbol.
The factorial display is source notation for a general complex argument; the Lean
factorial declaration below intentionally records only its `Nat` specialization
`z = n + 1`, where the right side is ordinary `n.factorial`.

:::leanStatement "Lean · historical notation aliases"
```anchor gaussPi (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
noncomputable def gaussPi (w : ℂ) : ℂ := gammaFunction (w + 1)
```

```anchor gaussPsi (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
noncomputable def gaussPsi (w : ℂ) : ℂ := psiFunction (w + 1)
```

```anchor davisPsi (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
noncomputable def davisPsi (z : ℂ) : ℂ := psiFunction z
```

```anchor pairmanF (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
noncomputable def pairmanF (w : ℂ) : ℂ := psiFunction (w + 1)
```

```anchor gaussPi_shift_eq_gamma (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
theorem gaussPi_shift_eq_gamma (z : ℂ) :
    gaussPi (z - 1) = gammaFunction z
```

```anchor gaussPsi_shift_eq_psi (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
theorem gaussPsi_shift_eq_psi (z : ℂ) :
    gaussPsi (z - 1) = psiFunction z
```

```anchor pairmanF_shift_eq_psi (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
theorem pairmanF_shift_eq_psi (z : ℂ) :
    pairmanF (z - 1) = psiFunction z
```

```anchor gamma_nat_succ_eq_factorial (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
theorem gamma_nat_succ_eq_factorial (n : ℕ) :
    gammaFunction ((n : ℂ) + 1) = (n.factorial : ℂ)
```
:::
::::

## Constants and derivatives
%%%
number := false
%%%

::::dlmfEntry "5.1.constants" "https://dlmf.nist.gov/5.1"
$$`\gamma\ \text{is Euler's constant},\qquad f'(u)=\frac{d}{du}f(u).`

The symbol `γ` means Euler's constant, with its definition deferred by the source to
[§5.2(ii)](https://dlmf.nist.gov/5.2#ii).  A prime means differentiation with respect
to the displayed variable: for a complex function this is Mathlib's `deriv` at the
complex argument.  Mathlib's `deriv` is totalized, so at a point where differentiability
has not been established it returns a default value rather than certifying that a
derivative exists.  Accordingly, the notation below is intended only on a
differentiability domain; the declaration itself carries no such premise.  These
conventions explain, for example, why later formulas write `Γ'(z)` and `ψ'(z)` without
introducing a new derivative operator.

:::leanStatement "Lean · Euler constant and prime notation"
```anchor eulerConstant (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
noncomputable abbrev eulerConstant : ℝ := Real.eulerMascheroniConstant
```

```anchor primeDerivative (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
noncomputable def primeDerivative (f : ℂ → ℂ) (z : ℂ) : ℂ := deriv f z
```

```anchor primeDerivative_eq_deriv (module := LMLF.Blueprint.Gamma.Section51) -showProofStates
theorem primeDerivative_eq_deriv (f : ℂ → ℂ) (z : ℂ) :
    primeDerivative f z = deriv f z
```
:::
::::

The source page supplies conventions rather than numbered mathematical claims, so the
manifest records these notation anchors as extra statement IDs.  Later sections may use
the canonical objects directly; the aliases above are provided when a historical symbol
must be displayed faithfully.
