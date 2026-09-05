# Testing and continuous-integration blueprint

**Status:** target design; current CI is only a baseline Lean build

**Applies to:** specification artifacts, semantic Lean modules, audit consumers,
future proof-producing tactics, and external review evidence

**Excluded:** all numerical-evaluation and performance infrastructure

The purpose of CI is to reproduce objective evidence at an exact source tree and
pinned toolchain.  CI does not issue mathematical approvals, certify source
fidelity, attest reviewer independence, or mutate lifecycle states.  Filled
review envelopes, verdicts, and disposition ledgers remain external to the
candidate head as required by `review/PROTOCOL.md`.

## 1. Invariants

Every maintained branch and candidate head preserves these invariants:

1. Lean is `leanprover/lean4:v4.33.1` and Mathlib resolves to the commit recorded
   in `lake-manifest.json`, unless a separately reviewed pin-upgrade packet
   changes both;
2. the build is offline after dependencies are restored from the pinned lock;
3. specification checks run before Lean implementation checks;
4. semantic roots, audit-only roots, and tests are built explicitly;
5. public declarations have reproducible axiom and import evidence;
6. exact constants, domains, thresholds, branches, and edge cases are protected
   by theorem statements, not by sampled values;
7. expected tactic failures are tested as failures;
8. generated reports never rewrite cards, source inventories, or reviews; and
9. no green job is interpreted as a review verdict or source-coverage claim.

## 2. Pipeline overview

The target pull-request pipeline is ordered as follows:

```text
checkout exact head + resolve recorded toolchain
  -> repository/scope checks
  -> contract and source-card lint
  -> narrow semantic build
  -> complete semantic-root build
  -> separate audit-root build
  -> exact mathematical regressions
  -> tactic positive/negative tests (only when tactics exist)
  -> public axiom audit
  -> import/dependency audit
  -> coverage/review-envelope consistency report
  -> immutable proposer-evidence bundle
```

Jobs may run in parallel after contract lint passes, but evidence is accepted
only when every required job refers to the same full head SHA, toolchain, Mathlib
revision, and specification binding.

## 3. Job classes

### 3.1 `spec-parse`

Fast checks on every change:

- parse YAML, CSV, JSON, and required Markdown frontmatter;
- reject duplicate keys, invalid controlled values, duplicate stable IDs,
  malformed hashes, root-escaping paths, and `REPLACE_*` placeholders at frozen
  levels;
- validate theorem-card, proof-artifact, work-packet, and local inventory
  references; and
- report the input digest manifest used by later jobs.

This job uses the `draft` or `freeze` level from `contract_linting.md`, selected
from the artifact's declared state.  It does not infer a more advanced state.

### 3.2 `source-contracts`

Run the source-card validators against explicit manifest IDs:

- recompute locally available source-snapshot and transcription digests;
- verify edition, snapshot, occurrence, notation, entity, card, and manifest
  joins;
- distinguish planning-only placeholders from closure-ready records;
- compare declared and actual distinct occurrence/card totals;
- reject generic/named/source-recovery role mismatches;
- require exact-source reconciliation only for the closed manifest under test;
  and
- emit unresolved inventory debt without turning it into coverage.

No source is downloaded in CI.  If licensed source bytes cannot be stored in the
runner, a previously created immutable digest and external evidence reference is
checked structurally; CI states that it did not inspect the bytes.

### 3.3 `lean-narrow`

For each implementation packet, compile:

- every changed Lean file;
- a generated disposable import probe for every promised narrow public import;
- every exact signature fixture bound by the packet; and
- the packet's declared immediate consumers.

The probe is generated outside the candidate tree or in an ignored temporary
directory.  It does not become source.  A broad umbrella import passing while a
promised narrow import fails is a failure.

### 3.4 `lean-semantic`

Build the maintained semantic library root and every declared public umbrella.
The intended root is `LMLF`; audit-only and test modules are not imported into
it.  This job detects missing root reachability, duplicate declarations, and
errors hidden by compiling only the changed file.

### 3.5 `lean-audits`

Build every audit consumer explicitly even though it is not imported by the
semantic root.  Planned examples include:

- `LMLF.Audit.Definitions` for expanded defining formulas and normalization;
- `LMLF.Audit.SourceRecovery` for qualitative recovery theorems; and
- future import, axiom, and public-signature audit modules.

An audit file that is not reachable from this job is unfinished evidence.  An
audit file imported into semantic foundations is an import-layer violation.

### 3.6 `math-regressions`

Compile exact theorem regressions from public declarations.  These are small
mathematical results, not runtime tests.  The suite protects:

- `N = 0`, the first nontrivial order, small orders, vanishing coefficients, and
  terminating expansions;
- empty-domain behavior for generic infrastructure and explicit inhabited or
  reachable domains for concrete applications;
- nonnegativity of public majorants;
- denominator margins, pole exclusions, branch cuts, endpoint conventions, and
  totalized-operation traps;
- real/complex agreement and the exact derivative variable;
- finite-sum endpoints and recurrence index ranges;
- exact natural bounds before weakened corollaries;
- constant and geometry comparisons such as
  `11 * (11 / 10)^10 < 29` versus the half-radius factor `2048`;
- threshold changes such as `(1 - θ) * x ≥ R₀` under Cauchy transport;
- the divergent factorial example, which must not acquire a false
  convergence-in-order consequence;
- the entire-function counterexample showing that real-axis control plus
  holomorphy does not preserve derivative scale; and
- cancellation points where a relative error against a vanishing leading term
  is invalid.

No theorem is weakened just to keep a regression green.  A deliberate change to
a constant, threshold, or domain requires a new theorem-card revision, new
proof review, and an explicit regression migration.

### 3.7 `tactic-tests`

This job is absent until an automation packet satisfies `tactics.md`.  Each
tactic then has four fixture groups:

1. **positive:** reproduces the frozen theorem statement from accepted manual
   proofs;
2. **side-condition:** verifies the exact kind and stable ordering of remaining
   obligations;
3. **expected failure:** confirms missing positivity, geometry, recurrence, or
   stability assumptions are not invented; and
4. **resource bound:** confirms deterministic step and expression limits fail
   conservatively.

Expected-failure tests assert stable diagnostic codes, not full error prose.
The suite compares manual and automated proofs by theorem statement, axiom
allowlist, and permitted imports; it does not require proof-term text equality.

Mandatory tactic regressions are the complete table in `tactics.md`, including:

- a too-small requested majorant and a missing inverse margin for `bound_calc`;
- absent radius, absent boundary control, and a disk crossing a cut for
  `cauchy_bound`; and
- off-range recurrence, exceptional denominator, and residual-without-stability
  misuse for `residual_nf`.

### 3.8 `axiom-audit`

For every public declaration changed or added by the packet:

1. elaborate it in the pinned environment;
2. obtain the transitive axiom set through Lean's environment, using a checked
   audit command rather than source-text search alone;
3. sort and serialize qualified axiom names deterministically;
4. compare the set exactly with the packet allowlist; and
5. include the per-declaration result in proposer evidence.

The ordinary default allowlist is limited to foundational axioms explicitly
accepted by the packet, commonly `propext`, `Classical.choice`, and `Quot.sound`.
The packet, not this document, is normative for a particular declaration.  Any
project-local axiom, `sorryAx`, undeclared external theorem, unsafe proof escape,
or assumption substituted for the target is a hard failure.

Source scanning for `sorry`, `admit`, `axiom`, `unsafe`, and `implemented_by` is
an additional defense.  It is not a substitute for transitive axiom inspection.
The audit must distinguish a declared data assumption in a theorem's binders
from a global axiom in its proof dependencies.

### 3.9 `import-audit`

Build a machine-readable project import graph and compare it with the permitted
layer DAG:

```text
Basic / low-level branch-domain support
  -> Construction -> Definitions -> model properties
  -> Quantitative core -> Complex/Integral/Summation/ODE methods
identified functions + methods -> applications -> zeros/connections
finite source theorems -> Audit/SourceRecovery
semantic modules -> nothing in Audit, Test, or Tactic as a prerequisite
```

The exact graph may branch; arrows never point backward.  Checks reject:

- definitions importing downstream remainder or comparison estimates;
- quantitative foundations importing named-function catalogues;
- a construction importing its identification or an estimate that consumes it;
- audit modules imported by the public semantic root;
- tactic imports in semantic foundation/definition files;
- umbrella cycles and discovery through unnecessarily broad imports; and
- undeclared direct dependencies that bypass accepted work-item IDs.

In addition to direct imports, inspect declaration dependencies for public
identification and source theorems.  A narrow source import does not prove that a
declaration avoids a later theorem re-exported through another path.

The report records direct import edges, relevant declaration dependencies,
umbrella fanout, and deviations.  Compile-time or elaboration-performance claims
require measurements; import count alone is not a performance finding.

### 3.10 `review-consistency`

When an external review bundle is supplied, validate but never author it:

- packet, card, proof, signature, rubric, toolchain, base, and head digests;
- distinct durable reviewer IDs and allowed human/agent composition;
- proposer exclusion and actual isolation metadata;
- invalidation after any candidate or specification change;
- terminal disposition for every finding; and
- exact merge-gate prerequisites.

If the bundle is absent, CI reports `review evidence not supplied`; it does not
create a placeholder approval.  Review records judging the candidate are not
committed back by CI.

## 4. Test layout

The eventual repository layout should keep responsibilities visible:

```text
LMLF/                         semantic library only
LMLF/Audit/                   separately built semantic/source audits
LMLF/Tactic/                  opt-in tactic implementations, if admitted
LMLFTest/Unit/                local theorem and edge fixtures
LMLFTest/Regression/          frozen constant/domain/source regressions
LMLFTest/Tactic/Positive/     supported automated proofs
LMLFTest/Tactic/Failure/      expected failures and diagnostic codes
testdata/contracts/valid/     valid schema/source/review fixtures
testdata/contracts/invalid/   one controlled defect per fixture
```

The layout is a target, not authorization to create empty files.  A packet adds
only the fixtures it owns.

## 5. Contract-linter test strategy

Every diagnostic in `contract_linting.md` has:

- one smallest valid fixture;
- one fixture with exactly that defect;
- a mutation test where a digest, revision, ID, enum, join role, or count is
  changed while other data remain valid; and
- a gate-level test showing when planning debt becomes a blocking error.

High-priority mutations include:

- substituting the 2010 preview for locked 1997 collation;
- swapping parameter order or derivative variable;
- relabeling `exact_source_generic` as a named application;
- closing a manifest with an unresolved notation/entity;
- changing proof bytes without changing the external digest;
- reusing one reviewer ID twice;
- binding an implementation verdict to the wrong head; and
- inserting a global axiom behind a theorem with an unchanged public type.

Fixtures use fabricated or redistributable miniature sources.  Licensed book
text is not copied merely to test the validator.

## 6. Per-packet regression matrix

Every work packet contains a finite matrix:

| Area | Required evidence |
|---|---|
| Signature | exact qualified names, binder order, types, declaration count |
| Source | occurrence/entity/notation links and recovery classification |
| Domain | endpoints, nonempty/reachable witness, threshold membership |
| Bound | majorant formula, sign, each named constant and loss |
| Analysis | regularity, integrability, nonvanishing, neighborhood geometry |
| Edge | order zero, small order, exceptional values, empty generic domains |
| Trust | transitive axiom set and forbidden-token scan |
| Dependency | direct imports, declaration dependencies, affected consumers |
| Review | bound artifact digests, quorum, dispositions, exact candidate head |

An inapplicable cell contains a reviewed reason.  It is not silently omitted.

## 7. Pull-request, main, and release gates

### Pull request

Required: `spec-parse`, relevant `source-contracts`, narrow and full Lean builds,
owned regressions, axiom/import audits, and a reproducible evidence bundle.  A
pull request may be technically green while its external review gate remains
pending.

### Main branch

All pull-request jobs rerun at the exact merge candidate.  Cached artifacts are
accepted only when their key includes the full toolchain, Mathlib revision,
schema-set version, and input digests.  No job pushes formatting, generated
contracts, or status changes to main.

### Release manifest

In addition to main-branch checks, validate closed membership, occurrence
counts, source/entity/notation reconciliation, separate audit roots, exact
review quorums, and terminal dispositions.  Release evidence names the exact
commit; it does not embed a self-referential commit hash into that commit.

## 8. Toolchain upgrades

A Lean or Mathlib upgrade is its own packet.  It must:

- update the requested and resolved pins coherently;
- rerun local-source availability and exact-signature comparisons;
- rebuild every semantic, audit, regression, and tactic target;
- recompute axiom and import baselines rather than grandfathering diffs;
- identify changed normal forms or theorem dependencies; and
- receive fresh implementation verdicts because the recorded toolchain binding
  changed.

Online documentation or a matching declaration name is not upgrade evidence.

## 9. Evidence retention

Each run publishes a read-only bundle containing:

- full head SHA and dirty-state assertion;
- toolchain, requested Mathlib version, and resolved full commit;
- schema and linter versions;
- input digest manifest;
- exact commands and untruncated logs;
- build target list;
- structured contract/source diagnostics;
- theorem regression list and results;
- per-declaration axiom sets;
- import/declaration graph report; and
- known omissions, including whether source bytes or external review records
  were unavailable.

The bundle is proposer evidence, not a verdict.  Retention must allow a referee
to distinguish two runs at different heads.

## 10. Numerical boundary

CI contains no floating-point comparisons, interval certificates, random
sampling of analytic domains, tolerance-driven order selection, numerical
quadrature, root finding, ODE solving, evaluator benchmarks, or external
numerical oracle.  Exact rational arithmetic used to kernel-check a displayed
inequality is allowed.  Wall-clock measurement may diagnose Lean elaboration or
proof-checking cost; it is not a special-function performance benchmark.
