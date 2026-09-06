# Gamma global-identification frontier 01 — addendum 01

## Binding and limited qualification

This addendum binds and preserves byte-for-byte
`gamma-global-identification-frontier-01.md` with SHA-256
`aa957e7d533a827e8814a7d2fec95a032c4f1b6af9e3a9061b67b3bb65e69e1a`.
It changes no old bytes. It qualifies only the original audit's statement that
the entire-reciprocal route is fully available on the Mathlib side.

The snapshot remains clean `main` at
`b8d2f731fcfd5cd0889d0732f13699eb94681c86`, with Lean `v4.33.1` and Mathlib
`0df444a360eaa60ab8c11dca51a86af692955474`. This is a circularity clarification,
not an implementation, new proof, source approval, or scope expansion.

## Independently established premise required

The source prose statement that reciprocal Gamma is entire is itself a
mathematical assertion requiring proof in any source-facing Lean packet. Its
mere appearance in print does not provide a Lean premise and does not identify
the source's Gamma with `Complex.Gamma`.

Accordingly, the entire-reciprocal uniqueness route is valid only when one of
the following has already been proved and independently accepted without using
the desired global identification:

- reciprocal entireness derived from the source object's actual definition; or
- an equivalent reviewed characterization that independently yields an entire
  reciprocal and its Euler-half-plane overlap with pinned reciprocal Gamma.

It is circular to assume the source's target reciprocal-entireness assertion,
use it to identify the global Gamma object, and then present the resulting
Mathlib theorem as the proof of that same assertion. A printed property may
guide the target statement; it does not discharge the target.

## Consequence for the default continuation route

If the source defines Gamma only as the meromorphic continuation of its Euler
germ, the reciprocal route is not automatically available. Pinned
`Meromorphic.Gamma` together with `gamma_eq_eulerIntegral` supplies one canonical
construction satisfying meromorphy and germ agreement, but those facts alone do
not prove uniqueness against an arbitrary source candidate.

That default route may still require a reviewed global meromorphic identity or
normal-form argument with the exact source continuation domain, equality notion
away from poles, and point-value convention stated explicitly. The original
audit correctly records that no single global arbitrary-meromorphic germ
uniqueness facade was found at the pin.

Only after such a noncircular identification, or after independently justified
entire-reciprocal uniqueness, may downstream global recurrence, pole, or
reciprocal-entireness targets reuse the corresponding Mathlib facts as results
about the source entity.

## Unchanged decision and stop line

`Complex.Gamma` remains the sole canonical implementation candidate; no second
Gamma object or synonym wrapper is proposed. Stop before any new
natural-language proof or Lean declaration until the exact source definition,
continuation characterization, and dependency order are frozen and receive the
required independent mathematical and structural/circularity reviews.

This addendum creates no source identity, readiness state, coverage claim,
production change, CI evidence, commit, or remote action.
