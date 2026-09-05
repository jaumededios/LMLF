# QB-001 public signatures

**Normative owner:** `jaumededios`  
**Artifact revision:** 2  
**Specification status:** `frozen`  
**Baseline specification commit:** `pending_external_record_after_commit`

This artifact freezes the import, namespace, declaration order, binder order,
implicit arguments, and conclusions for the BOOTSTRAP-0 QB-001 slice.  It
contains signatures only.  No ninth public declaration is in scope.

```lean
import LMLF.Basic

namespace QuantitativeAnalysis

variable {X Y E : Type*} [NormedAddCommGroup E]

def ErrorOn (D : Set X) (f a : X → E) (b : X → ℝ) : Prop :=
  ∀ x ∈ D, ‖f x - a x‖ ≤ b x

def NormBoundOn (D : Set X) (f : X → E) (b : X → ℝ) : Prop :=
  ∀ x ∈ D, ‖f x‖ ≤ b x

def HasErrorFamily
    (f : X → E) (a : ℕ → X → E)
    (D : ℕ → Set X) (b : ℕ → X → ℝ) : Prop :=
  ∀ n, ErrorOn (D n) f (a n) (b n)

namespace ErrorOn

theorem exact {D : Set X} {f a : X → E} (h : Set.EqOn f a D) :
    ErrorOn D f a (fun _ => 0)

theorem restrict {D D' : Set X} {f a : X → E} {b : X → ℝ}
    (h : ErrorOn D f a b) (hD : D' ⊆ D) :
    ErrorOn D' f a b

theorem weaken {D : Set X} {f a : X → E} {b d : X → ℝ}
    (h : ErrorOn D f a b) (hbd : ∀ x ∈ D, b x ≤ d x) :
    ErrorOn D f a d

theorem trans {D : Set X} {f a c : X → E} {b d : X → ℝ}
    (hfa : ErrorOn D f a b) (hac : ErrorOn D a c d) :
    ErrorOn D f c (fun x => b x + d x)

theorem comp {D : Set X} {f a : X → E} {b : X → ℝ}
    (h : ErrorOn D f a b) {S : Set Y} (ψ : Y → X)
    (hψ : Set.MapsTo ψ S D) :
    ErrorOn S (f ∘ ψ) (a ∘ ψ) (b ∘ ψ)

end ErrorOn
end QuantitativeAnalysis
```

## Freeze rule

The signatures are unchanged from revision 1.  Revision 2 changes only the
artifact's governance metadata and records that this bounded specification is
frozen.  Any later signature change increments the artifact revision and
invalidates all external gates for the prior revision.  The eventual
implementation must reproduce these declarations exactly or return to
specification review.  The baseline commit and all review/authorization state
are recorded externally after the commit exists, avoiding a self-referential
hash.
