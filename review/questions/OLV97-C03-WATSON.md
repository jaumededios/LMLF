# Review questions: Olver 1997 Watson packet

**Audience:** independent source, analysis, and Lean-library referees
**Status:** questions for a draft; no implementation authorization
**Source snapshot:** `SRC-OLV-1997-USER-PDF-20260905`
**Primary occurrence:** `OLV97-C03-WATSON`, Theorem 3.1, printed pp. 71-72
**Related source formulas:** `OLV97-C03-WATSON-BOUNDS`, section 9.1-9.2,
printed pp. 89-90

Please review from the attached/source-bound pages rather than from memory or a
modern statement of Watson's lemma. Answers should distinguish source fidelity,
mathematical correctness, and desirable generalization.

## A. Source transcription

1. Does the normalized transcription of (3.02)-(3.08) preserve every exponent,
   index boundary, quantifier, strict inequality, and endpoint convention?
2. Does Olver intend \(q\) and \(a_s\) to be real-valued, complex-valued, or
   either? What nearby convention in this edition supports the answer?
3. Is `t -> 0` in (3.02) unambiguously `t -> 0+` because `t` is positive?
4. Is the source's expansion convention exactly captured by
   \(\phi_n(t)=O(t^{(n+\lambda-\mu)/\mu})\) for every fixed \(n\), with the
   empty sum at \(n=0\)?
5. Does “the integral converges throughout its range” require separate
   convergence at each permitted interior infinity, or only convergence of a
   globally specified improper integral?
6. Does the proof require one baseline \(X\) for each fixed \(n\), or can a
   single \(X\) be chosen independently of \(n\) from the theorem hypothesis?

## B. Proof extracted from pp. 71-72

7. Verify the exact finite identity (3.05), including the Gamma argument and
   power of \(x\).
8. Verify that the local bound (3.06) is valid for every \(n\ge0\) solely from
   \(\lambda,\mu>0\) and the local remainder estimate.
9. Verify that convergence at the chosen baseline \(X\) makes
   \(\Phi_n(t)=\int_{k_n}^t e^{-Xv}\phi_n(v)\,dv\) bounded on
   \([k_n,\infty)\), including conditionally convergent cases.
10. Verify the integration-by-parts identity (3.07), both boundary terms, and
    the constant in (3.08).
11. Verify that
    \[
      K_n\Gamma(\beta_n)x^{-\beta_n}
      +L_ne^{-(x-X)k_n}
    \]
    implies the exact source expansion for each fixed \(n\), with no hidden
    uniformity claim.
12. Identify any extra regularity needed to make the source's proof rigorous
    for functions with finitely many discontinuities or infinities.

## C. Quantitative packet boundary

13. Should the first reusable theorem accept the local constants
    \(k,K,X,L\) as explicit data and prove the two-term bound, while a separate
    bridge derives existence of those constants from Olver's qualitative
    hypotheses?
14. Should the supplied-global-majorant implication (9.01) -> (9.02) be a
    separate card? The current recommendation is yes, because it uses stronger
    hypotheses than Theorem 3.1.
15. Should the best-exponent definitions (9.03) and (9.05) be deferred until
    extended-real suprema, zero coefficients, and logarithmic quotients have a
    dedicated card?
16. Is the proposed novelty split correct?
    - proof-level local-tail inequality: `strengthened_conclusion` or
      `equivalent_reformulation` of the proof;
    - qualitative bridge: `source_equivalent`;
    - global bound (9.02): direct source target;
    - Banach-valued generalization: `generalized`.

## D. Lean semantics

17. What is the smallest robust interface for the source's possibly
    conditional improper integral? In particular, should it be expressed as a
    `Tendsto` of finite `intervalIntegral`s rather than a totalized whole-line
    Bochner integral?
18. How should finite interior singularities be represented without making the
    first packet depend on an unnecessarily large integration framework?
19. Is a complex-valued first theorem preferable, with the real-valued source
    statement as a corollary, or would that make source recovery harder to
    audit?
20. Which exact pinned Mathlib declarations already provide:
    - the real power-exponential Gamma moment;
    - finite-interval integration by parts for the tail primitive;
    - exponential decay versus arbitrary real powers;
    - conversion between interval-integral limits and set integrals when
      absolute integrability is available?
21. Can the generic finite theorem be stated over a complete normed real vector
    space without complicating the source-facing complex/real specialization?

## E. Anti-laundering tests

22. Give a counterexample showing that local asymptotic data without a tail
    convergence or tail-majorant hypothesis cannot imply any global Laplace
    bound.
23. Give a counterexample showing that eventual convergence alone cannot
    supply a useful numerical tail constant uniformly in a family.
24. Check `n=0`, `a_n=0`, `0<lambda<mu`, `mu>1`, and `sigma_n<0` explicitly.
25. Confirm that no theorem assumes (9.01), (9.02), or the final asymptotic
    conclusion inside a structure field under a different name.

## Requested review output

Please return:

1. answers or findings keyed to questions 1-25;
2. a corrected mathematical transcription if any symbol or hypothesis is wrong;
3. a recommended packet split and scalar/integral semantics;
4. a verdict for source fidelity and a separate verdict for the local-tail
   natural-language proof;
5. explicit unresolved issues that must block theorem-card freezing;
6. model/runtime identity and a statement that the review used a fresh context.

The review may approve the source collation while requesting changes to the
quantitative theorem design. It must not set `lean_ready`; that remains a later
external-envelope decision after frozen cards, signatures, proofs, and quorum.
